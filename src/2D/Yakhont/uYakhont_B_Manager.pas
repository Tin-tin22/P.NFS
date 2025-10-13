unit uYakhont_B_Manager;

interface

uses
  Classes, uTCPClient, overbyteicsWSocketS, ExtCtrls, OverbyteIcsWsocket;

  type
  TOnConnected = procedure (cmd : Boolean) of object;

  TYakhont_B_Manager = class
  private
  public
    OnConnected : TOnConnected;

    NetCommLocalClient : TTCPClient;
    LogMemo   : TStrings;
    ServerIp  : string;
    ServerPort: string;

    ShouldConnect : boolean;

    ConnectInterval : Integer;
    timerConnect : TTimer;

    StandAloneMode   : Boolean;
    pCurrentScenID   : integer;

    pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
    pShipName, pClassName : string;
    pShipID, pClassID : Integer;

    constructor Create;
    destructor Destroy;

    procedure BeginSimulation;
    procedure EndSimulation;
    procedure CreateObject;
    procedure SetLayOutForm;

    procedure Initialize;
    procedure Net_Connect;
    procedure Net_Disconnect;

    {event for socket}
    procedure ConnectToMainDisplay;
    procedure OnClientState(Sender: TObject; OldState, NewState: TSocketState);
    procedure RequestPLPState;

    procedure AddToMemoLog(const str: string);

    procedure EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer);
    procedure EventOnReceivePLPState(apRec: PAnsiChar; aSize: integer);

    procedure OnTimerConnect(sender : TObject);
  end;

var
  Yakhont_B_Manager : TYakhont_B_Manager;

implementation

uses
  uBridgeSet, uTCPDatatype, SysUtils, uYakhont_B_MainForm,
  Forms;

procedure TYakhont_B_Manager.ConnectToMainDisplay;
begin
  timerConnect.Enabled := True;
end;

constructor TYakhont_B_Manager.Create;
begin
  NetCommLocalClient    := TTCPClient.Create;
  NetCommLocalClient.Socket.OnChangeState := OnClientState;

  timerConnect          := TTimer.Create(nil);
  timerConnect.Enabled  := False;
  timerConnect.Interval := 2000;
  timerConnect.OnTimer  := OnTimerConnect;

  ShouldConnect         := false;
end;

destructor TYakhont_B_Manager.Destroy;
begin
  NetCommLocalClient.Free;
  timerConnect.Free;
end;

procedure TYakhont_B_Manager.OnClientState(Sender: TObject; OldState,
  NewState: TSocketState);
begin
  if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
    ShouldConnect :=  false;
    ConnectToMainDisplay;

    if Assigned(OnConnected) then
      OnConnected(false);
  end;
end;

procedure TYakhont_B_Manager.OnTimerConnect(sender : TObject);
begin
  if NetCommLocalClient.State <> wsConnected then
  begin
    Net_Connect;

    if Assigned(OnConnected) then
      OnConnected(false);

    { start circuit kembali ke posisi OFF }
    with frmYakh_B_MainForm do
    begin
      imgOn.Picture.LoadFromFile(fIndikatorOff);
      imgOff.Picture.LoadFromFile(fIndikatorOn);

      btnKey.ImageIndex := 0;
      btnStart.ImageIndex := 0;

      normalisasi;
    end;
  end
  else
  begin
    timerConnect.Enabled := false;

    if Assigned(OnConnected) then
      OnConnected(true);

    RequestPLPState;
  end;
end;

procedure TYakhont_B_Manager.RequestPLPState;
var
  RecSend : TRec_Command_YakhontPLP;
begin
  RecSend.Mode := 1;
  NetCommLocalClient.sendDataEx(REC_COMMAND_YAKHONTPLP, @RecSend);
end;

procedure TYakhont_B_Manager.BeginSimulation;
begin
  //create Object2-nya
  CreateObject;
  SetLayOutForm;

  //Register Packet-packet Net
  //------------------------------------------------------------ Local
  NetCommLocalClient.RegisterProcedure(REC_CMD_Yakhont, EventOnReceiveCommand, SizeOf(TRecCMD_YAkhont));
  NetCommLocalClient.RegisterProcedure(REC_COMMAND_YAKHONTPLP, EventOnReceivePLPState, SizeOf(TRec_Command_YakhontPLP));

  //------------------------------------------------------------ To Instruktur

  ConnectToMainDisplay;
end;

procedure TYakhont_B_Manager.EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer);
var aRec : ^TRecCMD_Yakhont;
begin
  aRec := @apRec^;

  frmYakh_B_MainForm.edit1.Text := IntToStr(aRec.cmd);

  case aRec.cmd of
    CMD_Yakhont_Cancel:
      begin

      end;
    CMD_Yakhont_Backlight:
      begin

      end;
    CMD_Yakhont_Key:
      begin

      end;
    CMD_Yakhont_Start:
      begin

      end;
    CMD_Yakhont_OpenKey:
      begin
        with frmYakh_B_MainForm do
        begin
          { status => sudah boleh membuka kunci, maka SC ON }
          C__mayIOpenKey := True;
          btnKey.Visible := True;
          KeyClosed.Visible := False;
          imgOn.Picture.LoadFromFile(fIndikatorRed);
          imgOff.Picture.LoadFromFile(fIndikatorOff);

          { setelah SC ON, maka kirim status bila SC ON (pada yakhont utama) }
          Key_Yakhont.cmd := CMD_Yakhont_SCOn;
          NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
        end;
      end;
    CMD_Yakhont_ReadyToFire:
      begin
        with frmYakh_B_MainForm do
        begin
          { bila salvo ready, maka sudah boleh menekan tombol START untuk penembakan }
          C__mayIPressStartFire := True;
          //btnStartClosed.Visible := False;
        end;
      end;
    CMD_Yakhont_SCOff:
      begin
        with frmYakh_B_MainForm do
        begin
          { start circuit kembali ke posisi OFF }
          imgOn.Picture.LoadFromFile(fIndikatorOff);
          imgOff.Picture.LoadFromFile(fIndikatorOn);

          btnKey.ImageIndex := 0;
          btnStart.ImageIndex := 0;

          normalisasi;

          Key_Yakhont.cmd := CMD_Yakhont_SCOff;
          NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
        end;
      end;
    CMD_Yakhont_Terminate :
      begin
        Application.Terminate;
      end;
  end;
end;

procedure TYakhont_B_Manager.EventOnReceivePLPState(apRec: PAnsiChar;
  aSize: integer);
var
  aRec : ^TRec_Command_YakhontPLP;
begin
  aRec := @apRec^;

  if aRec^.Mode = 2 then
  begin
    if aRec^.CommandID = 1 then
    begin
      with frmYakh_B_MainForm do
      begin
        { status => sudah boleh membuka kunci, maka SC ON }
        C__mayIOpenKey := True;
        btnKey.Visible    := True;
        KeyClosed.Visible   := False;
        imgOn.Picture.LoadFromFile(fIndikatorRed);
        imgOff.Picture.LoadFromFile(fIndikatorOff);

        { setelah SC ON, maka kirim status bila SC ON (pada yakhont utama) }
        Key_Yakhont.cmd := CMD_Yakhont_SCOn;
        NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
      end;
    end;
  end;
end;

procedure TYakhont_B_Manager.EndSimulation;
begin
  timerConnect.Enabled := false;
  Yakhont_B_Manager.Free;
end;

procedure TYakhont_B_Manager.CreateObject;
begin
  NetCommLocalClient.setLog(TStringList(LogMemo));

  // Create Form ---------------------------------------------------

  // Show Form -----------------------------------------------------

end;

procedure TYakhont_B_Manager.SetLayOutForm;
begin

end;

procedure TYakhont_B_Manager.Initialize;
var
  n : integer ;
begin
  n := ParamCount ;
  if n < max_param then
    StandAloneMode := true
  else
  begin
     StandAloneMode := false ;
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
      pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );
  end;
end;

procedure TYakhont_B_Manager.Net_Connect;
var
  p : Integer;
begin
  p := StrToInt(pServer_Port) + 1;

  NetCommLocalClient.Connect(pServer_Ip,  IntToStr(p));
  if NetCommLocalClient.State = wsConnected then ShouldConnect := true;
end;

procedure TYakhont_B_Manager.Net_Disconnect;
begin
  ShouldConnect         := false;
  timerConnect.Enabled  := false;
end;

procedure TYakhont_B_Manager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

end.
