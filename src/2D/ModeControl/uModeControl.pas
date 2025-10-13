unit uModeControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, uTCPClient, OverbyteIcsWSocket , uTCPDatatype,
  Menus, IniFiles, OverbyteIcsWndControl,

  ufrmMisral, ufrmStrella;

type
  TfMainForm = class(TForm)
    tmrConBridge: TTimer;
    pm1: TPopupMenu;
    pmNetSetting: TMenuItem;
    pmLogMemo: TMenuItem;
    pmClose: TMenuItem;
    tmrGetValue: TTimer;


    procedure tmrConBridgeTimer(Sender: TObject);
    procedure onTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmNetSettingClick(Sender: TObject);
    procedure pmLogMemoClick(Sender: TObject);
    procedure pmCloseClick(Sender: TObject);
    procedure AddLogMemo(const LogMemo : TStringList;  str: string);
    procedure EventRecMissilePos(apRec: PAnsiChar; aSize: integer);
    procedure EventRecStrellaStruct(apRec: PAnsiChar; aSize: integer);
    procedure EventRecMistralStruct(apRec: PAnsiChar; aSize: integer);

  private
    { Private declarations }
    FrameWeapon : TFrame;
  public
    { Public declarations }
    TcpClient : TTCPClient;
    pCurrentScenID  : integer;
    pLauncherID : integer;
    pServer_Ip,
    pServer_Port,
    pDBServer,
    pDBProto,
    pDBName,
    pDBUser,
    pDBPass,
    pShipName,
    pClassName      : string;
    pShipID         : Integer;
  end;

var
  fMainForm: TfMainForm;

implementation

uses
  ufrmNetSetting, uLogMemo, uBridgeSet;

{$R *.dfm}

procedure TfMainForm.FormCreate(Sender: TObject);
var
  iniFile : TIniFile;
  strIni : string;
  initWeapon : integer;
begin
  TcpClient := TTCPClient.Create;

  pServer_Ip := '127.0.0.1';
  pServer_Port := '1234';

  InitDefault_AllConfigFromInstruktur_TDS(pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass, pShipID, pCurrentScenID, pLauncherID);

  {connect to bridge}
  tmrConBridge.Enabled := True;
  TcpClient.Socket.OnChangeState := onTCPChangeState;

  {register procedure}
  TcpClient.RegisterProcedure(REC_MISSILEPOS , EventRecMissilePos,    SizeOf(TRecMissilePos));
  TcpClient.RegisterProcedure(REC_CMD_STRELLA, EventRecStrellaStruct, SizeOf(TRec3DSetStrella));
  TcpClient.RegisterProcedure(REC_CMD_MISTRAL, EventRecMistralStruct, SizeOf(TRec3DSetMistral));
  TcpClient.RegisterProcedure(REC_2D_ORDER, nil, SizeOf(TRecData2DOrder));

  {Init Form Weapon
   1 : Mistral
   2 : Strella}
  strIni := ExtractFilePath(Application.ExeName);
  strIni := strIni + 'SettingWeapon.ini';
  if FileExists(strIni) then
  begin
    try
      iniFile := TIniFile.Create(strIni);
      initWeapon := iniFile.ReadInteger('SettingWeapon', 'InitWeapon' , 1);
    finally
      iniFile.Free;
    end;
  end
  else
  begin
    initWeapon := 1;
  end;

  case initWeapon of
    1 :
    begin
      FrameWeapon := TfrmMistral.Create(nil);
      Caption := 'Mistral Control';
    end;

    2 :
    begin
      FrameWeapon := TfrmStrella.Create(nil);
      Caption := 'Strella Control';
    end;
  end;

  if Assigned(FrameWeapon) then
  begin
    FrameWeapon.Parent := Self;
    FrameWeapon.Align := alClient;
  end;
end;

procedure TfMainForm.FormDestroy(Sender: TObject);
begin
  if TcpClient.State = wsConnected then
    TcpClient.Disconnect;
  FreeAndNil(TcpClient);

  if Assigned(FrameWeapon) then
    FrameWeapon.Free;
end;

procedure TfMainForm.onTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);
begin
  if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
   tmrConBridge.Enabled := True;
  end;
end;

procedure TfMainForm.pmCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMainForm.pmLogMemoClick(Sender: TObject);
begin
  frmLogMemo.Show;
end;

procedure TfMainForm.pmNetSettingClick(Sender: TObject);
begin
  frmNetSetting.Show;
end;

procedure TfMainForm.AddLogMemo(const LogMemo : TStringList;  str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

procedure TfMainForm.tmrConBridgeTimer(Sender: TObject);
var
  recSend : TRecData2DOrder;
begin
  tmrConBridge.Enabled := False;

  {connect to bridge}
  if TcpClient.State <> wsConnected then
  begin
    TcpClient.Connect(pServer_Ip,pServer_Port);
    tmrConBridge.Enabled := True;
  end
  else
  begin
    tmrConBridge.Enabled := False;

    {req sync packet after connect}
    if TcpClient.State = wsConnected then
    begin
      recSend.orderID   := _CM_REQ_SYNCPACKET;
      recSend.numValue  := 0;
      recSend.strValue  := '';
      recSend.strValue2 := '';
      recSend.strValue3 := '';
      recSend.ipConsole := '';
      TcpClient.sendDataEx(REC_2D_ORDER, @recSend);
    end;
  end;
end;

procedure TfMainForm.EventRecMissilePos(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRecMissilePos;
begin
  aRec := @apRec^;

  if ( pShipID = aRec^.shipID ) and        {____________________________strella}
     ( aRec^.WeaponID = C_DBID_STRELA) then
  begin
    case aRec^.launcherID of
      1:  {port}
      begin
        case aRec^.missileID of
          1:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock1.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock1.BitmapIndex := 0;
              end;
            end;
          end;
          2:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock2.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock2.BitmapIndex := 0;
              end;
            end;
          end;
          3:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock3.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock3.BitmapIndex := 0;
              end;
            end;
          end;
          4:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock4.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock4.BitmapIndex := 0;
              end;
            end;
          end;
        end;
      end;
      2: {starboard}
      begin
        case aRec^.missileID of
          1:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock1.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl1.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock1.BitmapIndex := 0;
              end;
            end;
          end;
          2:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock2.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgLeftControl2.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock2.BitmapIndex := 0;
              end;
            end;
          end;
          3:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock3.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgRightControl1.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock3.BitmapIndex := 0;
              end;
            end;
          end;
          4:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 3;
                TfrmStrella(FrameWeapon).imgUnlock4.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmStrella(FrameWeapon).imgRightControl2.BitmapIndex := 0;
                TfrmStrella(FrameWeapon).imgUnlock4.BitmapIndex := 0;
              end;
            end;
          end;
        end;
      end;
    end;
  end
  else
  if ( pShipID = aRec^.shipID ) and         {___________________________mistral}
     ( aRec^.WeaponID = C_DBID_MISTRAL) then
  begin
    case aRec^.launcherID of
      2: {starboard}
      begin
        case aRec^.missileID of
          2:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 3;
                TfrmMistral(FrameWeapon).imgUnlock2.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 0;
                TfrmMistral(FrameWeapon).imgUnlock2.BitmapIndex := 0;
              end;
            end;
          end;
          1:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 3;
                TfrmMistral(FrameWeapon).imgUnlock1.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 0;
                TfrmMistral(FrameWeapon).imgUnlock1.BitmapIndex := 0;
              end;
            end;
          end;
        end;
      end;
      1: {port}
      begin
        case aRec^.missileID of
          2:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 3;
                TfrmMistral(FrameWeapon).imgUnlock2.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmMistral(FrameWeapon).imgRightControl.BitmapIndex := 0;
                TfrmMistral(FrameWeapon).imgUnlock2.BitmapIndex := 0;
              end;
            end;
          end;
          1:
          begin
            case aRec^.status of
              ST_MISSILE_LOADED:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 4;
              end;
              ST_MISSILE_UNLOCK:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 1;
              end;
              ST_MISSILE_LOCK:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 4;
              end;
              ST_MISSILE_RUN:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 3;
                TfrmMistral(FrameWeapon).imgUnlock1.Enabled := False;
              end;
              ST_MISSILE_DEL:
              begin
                TfrmMistral(FrameWeapon).imgLeftControl.BitmapIndex := 0;
                TfrmMistral(FrameWeapon).imgUnlock1.BitmapIndex := 0;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfMainForm.EventRecMistralStruct(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRec3DSetMistral;
begin
  aRec := @apRec^;

  if (pShipID = aRec^.shipID) and (aRec^.mWeaponID = C_DBID_MISTRAL) then
  begin
    case aRec^.mLauncherID of
      1, 2:  {port|starboard}
      begin
        if aRec^.OrderID = __ORD_MISTRAL_DIRECT_LR then
        begin
          TfrmMistral(FrameWeapon).vrdgtgrpVrBearing.Value := aRec^.mTargetBearing;
          TfrmMistral(FrameWeapon).vrdgtgrpElevasi.Value := aRec^.mTargetElev;
        end;
      end;
    end;
  end;
end;

procedure TfMainForm.EventRecStrellaStruct(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRec3DSetStrella;
begin
  aRec := @apRec^;

  if (pShipID = aRec^.shipID) and (aRec^.mWeaponID = C_DBID_STRELA) then
  begin
    case aRec^.mLauncherID of
      1, 2:  {port|starboard}
      begin
        if aRec^.OrderID = __ORD_STRELA_DIRECT_LR then
        begin
          TfrmStrella(FrameWeapon).vrdgtgrpVrBearing.Value := aRec^.mTargetBearing;
          TfrmStrella(FrameWeapon).vrdgtgrpElevation.Value := aRec^.mTargetElev;
        end;
      end;
    end;
  end;
end;

end.
