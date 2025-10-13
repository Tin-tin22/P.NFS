unit uFrmPTK;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpeedButtonImage, StrUtils, IniFiles, ExtCtrls,
  OverbyteIcsWSocket, uFrmLogNewPDK, uThreadTimer, UfrmBaseTCMS, uLibSettings,
  uPTKEnum;

type
  TfrmPTK = class(TfrmBaseTCMS)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Network Connecttion }
    FipConnect : string;
    FPortConnect : string;
    FTimerConnect : TPrecisseTimer;
    FSocketTCPClient : TWSocket;
    FBuffer : array [0..1023] of AnsiChar;

    { Setting GUI }
    FFormWidth : Integer;
    FFormHeight : Integer;
    FisFullScreen : Boolean;
    FMode : Integer; // 0 = fcc1, 1 = fcc2
//    FServiceMonitor : integer;

    Btn_Separator : integer;
    Btn_Width : integer;
    Btn_Height : integer;
    FFont_Btn : Integer;

    { Private declarations }
    btn : TSpeedButtonImage;
    pnlPTK, pnlNumKey : TPanel;
    FBtnArray         : array [0..29] of TSpeedButtonImage;
    FBtnArrayNumKey  : array [0..29] of TSpeedButtonImage;
    FBtnMainCaption   : array [0..29] of string;
    FBtnMainNames     : array [0..29] of string;
    FBtnNumCaption   : array [0..29] of string;
    FBtnNumNames     : array [0..29] of string;

    FLocalCtrlState : TLocalCtrlState;
    FOperationMode : TOperationMode;
    FDrumSelection : TDrumSelection;
    FRateOfFire : TRateOfFire;
    FisEO : Boolean;
    FisZeroFlyOn : Boolean;
    FisCooEnableed : Boolean;
    FisScreenLocked : Boolean;
    FisLocalCtrl : Boolean;
    FisCheckStart : Boolean;

    procedure GenerateCaption;
    procedure GenerateNames;

    procedure addToLog(str : string);
    procedure SendToServerPTK(str : string);

    { All Event Button in PTK }
    procedure btnPtkClick(Sender : TObject);
    procedure btnNkClick(Sender : TObject);

    procedure GenerateCaptionByMenu(aMenu : string);
    procedure GenerateSysCtrlMenu;
    procedure GenerateLocalCtrlMenu;
    procedure GenerateCombatMenu;
    procedure GenerateCheckMenu;
    procedure GenerateIndSettingMenu;
    procedure GenerateCtrlGunMenu;
    procedure GenerateVideoMenu;
    procedure GenerateDataRecordMenu;

    procedure EnableAllBtn;
    procedure DisableAllBtn;
    procedure GenerateLockScreenMenu;
    procedure SetOperationModeDisplay;

    { Network Handler}
    procedure OnTimerConnectOnTime(const dt : Double);
    procedure SocketClientSessionClosed(Sender: TObject; ErrCode: Word);
    procedure SocketClientDataAvailable(Sender: TObject; ErrCode: Word);
    procedure SetRole(Msg : String);
    procedure FalseRole;
    procedure ProcessCommand(Cmd : String);

  public
    { Public declarations }
    PwoMode : Boolean;
    PcMode  : Boolean;
    AwwMode : Boolean;

    fSelected     : Integer;
    fSelectedSub  : Integer;

    fColorWindow, fColorWindowBg : Integer;

    procedure InitButtons;

    property LocalCtrlState : TLocalCtrlState read FLocalCtrlState write FLocalCtrlState;
    property OperationMode : TOperationMode read FOperationMode write FOperationMode;
    property DrumSelection : TDrumSelection read FDrumSelection write FDrumSelection;
    property RateOfFire : TRateOfFire read FRateOfFire write FRateOfFire;
  end;

var
  frmPTK: TfrmPTK;

implementation

uses
  uTCMSColors;

{$R *.dfm}

procedure TfrmPTK.addToLog(str: string);
begin

end;

procedure TfrmPTK.btnNkClick(Sender: TObject);
begin
  if TSpeedButtonImage(Sender).Name = 'btnNkNumCancel' then
    pnlPTK.BringToFront;
end;

procedure TfrmPTK.btnPtkClick(Sender: TObject);
var
  i: Integer;
begin
//  ShowMessage(TSpeedButtonImage(Sender).Name);
  //set other button color to black except pressed button
  for i := 2 to Length(FBtnArray) - 1 do
  begin
    FBtnArray[i].Color := clBlack;
  end;
  if (TSpeedButtonImage(Sender).Name <> 'btnSysCtrl') and
    (TSpeedButtonImage(Sender).Name <> 'btnLocalCtrl') and
    (TSpeedButtonImage(Sender).Name <> 'btnCombat') and
    (TSpeedButtonImage(Sender).Name <> 'btnCheck') and
    (TSpeedButtonImage(Sender).Name <> 'btnCtrlGun') and
    (TSpeedButtonImage(Sender).Name <> 'btnVideo') and
    (TSpeedButtonImage(Sender).Name <> 'btnDataRecord') then
  begin
    if FisLocalCtrl then
    begin
      for i := 0 to Length(FBtnArray) - 1 do
      begin
        FBtnArray[i].Color := clBlack;
      end;
      FBtnArray[1].Color := clLime;
      if FLocalCtrlState = lcCombat then
      begin
        FBtnArray[7].Color := clLime;
        SetOperationModeDisplay;
      end
      else if FLocalCtrlState = lcCheck then
      begin
        FBtnArray[8].Color := clLime;
        if FisCheckStart then
        begin
          FBtnArray[7].Enabled := False;
          FBtnArray[28].Color := clLime;
          FBtnArray[29].Color := clBlack;
        end
        else
        begin
          FBtnArray[7].Enabled := True;
          FBtnArray[28].Color := clBlack;
          FBtnArray[29].Color := clLime;
        end;

      end;

    end
    else
    begin
      for i := 0 to Length(FBtnArray) - 1 do
      begin
        FBtnArray[i].Color := clBlack;
      end;
      FBtnArray[0].Color := clLime;
    end;
  end;


  if TSpeedButtonImage(Sender).Name = 'btnSysCtrl' then
  begin
//    FBtnArray[0].Down := True;
    FBtnArray[0].Color := clLime;
    FBtnArray[1].Color := clBlack;
    FisLocalCtrl := False;
    GenerateCaptionByMenu('SysCtrl');
  end
  else if TSpeedButtonImage(Sender).Name = 'btnLocalCtrl' then
  begin
//    FBtnArray[1].Down := True;
    FBtnArray[1].Color := clLime;
    FBtnArray[0].Color := clBlack;
    FisLocalCtrl := True;
    GenerateCaptionByMenu('LocalCtrl');
    if FLocalCtrlState = lcCombat then
    begin
      FBtnArray[7].Color := clLime;
      FBtnArray[8].Color := clBlack;
      GenerateCombatMenu;
      SetOperationModeDisplay;
    end
    else if FLocalCtrlState = lcCheck then
    begin
      FBtnArray[8].Color := clLime;
      FBtnArray[7].Color := clBlack;
      GenerateCheckMenu;
      FBtnArray[29].Color := clLime;
    end;

  end
  else if TSpeedButtonImage(Sender).Name = 'btnCombat' then
  begin
//    FBtnArray[7].Down := True;
    FBtnArray[7].Color := clLime;
    FBtnArray[8].Color := clBlack;
    FLocalCtrlState := lcCombat;
    GenerateCaptionByMenu('Combat');
  end
  else if TSpeedButtonImage(Sender).Name = 'btnCheck' then
  begin
//    FBtnArray[8].Down := True;
    FBtnArray[8].Color := clLime;
    FBtnArray[7].Color := clBlack;
    FLocalCtrlState := lcCheck;
    GenerateCaptionByMenu('Check');
    FBtnArray[29].Color := clLime;
  end
  else if TSpeedButtonImage(Sender).Name = 'btnNavSetting' then
  begin
    pnlNumKey.BringToFront;
  end
  else if TSpeedButtonImage(Sender).Name = 'btnWeatherSetting' then
  begin
    pnlNumKey.BringToFront;
  end
  else if TSpeedButtonImage(Sender).Name = 'btnCalSetting' then
  begin
    pnlNumKey.BringToFront;
  end
  else if TSpeedButtonImage(Sender).Name = 'btnIndSetting' then
  begin
    FBtnArray[0].Color := clBlack;
    FBtnArray[1].Color := clBlack;
    for i := 2 to Length(FBtnArray) - 1 do
    begin
      FBtnArray[i].Color := clBlack;
    end;
    GenerateCaptionByMenu('IndSetting');
  end
  else if TSpeedButtonImage(Sender).Name = 'btnBack' then
  begin
    if FisLocalCtrl then
    begin
      FBtnArray[1].Color := clLime;
      FBtnArray[0].Color := clBlack;
      GenerateLocalCtrlMenu;

      if FLocalCtrlState = lcCombat then
      begin
        FBtnArray[7].Color := clLime;
        FBtnArray[8].Color := clBlack;
        GenerateCombatMenu;
      end
      else if FLocalCtrlState = lcCheck then
      begin
        FBtnArray[8].Color := clLime;
        FBtnArray[7].Color := clBlack;
        GenerateCheckMenu;
      end;
    end
    else
    begin
      FBtnArray[0].Color := clLime;
      FBtnArray[1].Color := clBlack;
      GenerateSysCtrlMenu;
    end;
  end
  else if TSpeedButtonImage(Sender).Name = 'btnCtrlGun' then
  begin
    GenerateCaptionByMenu('CtrlGun');
  end
  else if TSpeedButtonImage(Sender).Name = 'btnVideo' then
  begin
    GenerateCaptionByMenu('Video');
  end
  else if TSpeedButtonImage(Sender).Name = 'btnDataRecord' then
  begin
    GenerateCaptionByMenu('DataRecord');
  end;

  if TSpeedButtonImage(Sender).Name = 'btnLockScreen' then
  begin
    GenerateCaptionByMenu('LockScreen');
  end;
end;

procedure TfrmPTK.DisableAllBtn;
var
  i: Integer;
begin
  for i := 0 to Length(FBtnArray) - 1 do
  begin
    FBtnArray[i].Enabled := False;
  end;
end;

procedure TfrmPTK.EnableAllBtn;
var
  i: Integer;
begin
  for i := 0 to Length(FBtnArray) - 1 do
  begin
    FBtnArray[i].Enabled := True;
  end;
end;

procedure TfrmPTK.FalseRole;
begin

end;

procedure TfrmPTK.FormCreate(Sender: TObject);
var
  iniF : TIniFile;
  iniPath : string;
begin
  inherited;
  SetServiceIndex(0);

//  case VThemeSetting.ColorNum of
//    1 : begin
//      fColorWindow := CL_TCMS_Window;
//      fColorWindowBg := CL_TCMS_WindowBackGround;
//    end;
//    2 :
//    begin
//      fColorWindow := CL_CMS_Window;
//      fColorWindowBg := CL_CMS_WindowBackGround;
//    end;
//  end;
  fColorWindow := CL_TCMS_WindowBackGround;
  Color := fColorWindow;

  { Initialize PTK }
  FisFullScreen := true;
  BorderStyle := bsDialog;
  Height := 400;
  Width := 600;
//  FServiceMonitor := 0;
  FipConnect := '127.0.0.1';
  FPortConnect := '2345';
  FFont_Btn := 10;

  { Create Network Handler }
  FSocketTCPClient := TWSocket.Create(nil);

  FTimerConnect := TPrecisseTimer.Create;
  FTimerConnect.OnRunning := OnTimerConnectOnTime;
  FTimerConnect.Interval := 2000;
  FTimerConnect.Enabled := True;

  { Get Setting from ptk.ini }
  iniPath := ExtractFilePath(Application.ExeName) + 'ptk.ini';
  iniF := TIniFile.Create(iniPath);
  try
//    iniF := TIniFile.Create(iniPath);
    FipConnect := iniF.ReadString('PTKSetting', 'ipConnect', '127.0.0.1');
//    FPortConnect := iniF.ReadString('PTKSetting', 'portConnect', '2345');
//    FisFullScreen := iniF.ReadBool('PTKSetting', 'isFullScreen', false);
//    FFormHeight := iniF.ReadInteger('PTKSetting', 'FormHeight', Height);
//    FFormWidth := iniF.ReadInteger('PTKSetting', 'FormWidth', Width);
////    FServiceMonitor := iniF.ReadInteger('PTKSetting', 'ServiceMonitor', 0);
//    FFont_Btn := iniF.ReadInteger('PTKSetting', 'FontSize', 6);
//    if FFont_Btn < 0 then
//      FFont_Btn := 8;
  finally
    iniF.Free;
  end;

  FMode := 1;

  if FisFullScreen then
  begin
    Left := Screen.Monitors[FServiceIndex].Left;
    Top := Screen.Monitors[FServiceIndex].Top;
    Width := Screen.Monitors[FServiceIndex].Width;
    Height := Screen.Monitors[FServiceIndex].Height;

    BorderStyle := bsNone;

    Btn_Separator := 6;
    Btn_Width := ((Width - (Btn_Separator * 7)) div 6);
    Btn_Height := ((Height - (Btn_Separator * 6)) div 5);
    FFont_Btn := Btn_Height div 10 ;
    if FFont_Btn <= 10 then
      FFont_Btn := 10;
  end
  else
  begin
     Left := Screen.Monitors[FServiceIndex].Left;
      Top := Screen.Monitors[FServiceIndex].Top;
//      Width := FFormWidth;
//      Height := FFormWidth;

    BorderStyle := bsSingle;

    Btn_Separator := 6;
    Btn_Width := ((Width - (Btn_Separator * 7)) div 6) - 1;
    Btn_Height := ((Height - (Btn_Separator * 6)) div 5) - 5;
    FFont_Btn := Btn_Height div 10 ;
    if FFont_Btn <= 10 then
      FFont_Btn := 10;
  end;
  InitButtons;

//  FLocalCtrlState := lcCombat;
//  FOperationMode := omWait;
//  FDrumSelection := dsLDrum;
//  FRateOfFire := frHigh;
  FisEO := True;
  FisZeroFlyOn := False;
  FisCooEnableed := False;
  FisLocalCtrl := False;
  FisCheckStart := False;
end;

procedure TfrmPTK.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmPTK.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TfrmPTK.GenerateCaption;
var
  i : Integer;
begin
  FBtnMainCaption[0] := 'SYS CTRL'    + #13#10;
  FBtnMainCaption[1] := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnMainCaption[2] := 'Ctrl'  + #13#10 + 'Gun';
  FBtnMainCaption[3] := 'Video'  + #13#10;
  FBtnMainCaption[4] := 'Data' + #13#10 + 'Record';
  FBtnMainCaption[5] := 'Lock'  + #13#10 + 'Screen';
  FBtnMainCaption[6] := 'NAV'  + #13#10 + 'Setting';
  FBtnMainCaption[7] := 'Weather'    + #13#10 + 'Setting';
  FBtnMainCaption[8] := 'CAL' + #13#10 + 'Setting';
  FBtnMainCaption[27] := 'Zero Fly'  + #13#10 + 'Off';

  for i := 9 to Length(FBtnArray)-1 do
  begin
    if i <> 27 then
      FBtnMainCaption[i] := '  ';
  end;

  FBtnNumCaption[0] := 'E';
  FBtnNumCaption[1] := 'W';
  FBtnNumCaption[2] := 'S';
  FBtnNumCaption[3] := 'N';
  FBtnNumCaption[4] := '  ';
  FBtnNumCaption[5] := '  ';
  FBtnNumCaption[6] := '1';
  FBtnNumCaption[7] := '2';
  FBtnNumCaption[8] := '3';
  FBtnNumCaption[9] := '.';
  FBtnNumCaption[10] := 'Up';
  FBtnNumCaption[11] := 'Backspace';
  FBtnNumCaption[12] := '4';
  FBtnNumCaption[13] := '5';
  FBtnNumCaption[14] := '6';
  FBtnNumCaption[15] := '+';
  FBtnNumCaption[16] := 'Down';
  FBtnNumCaption[17] := 'Del';
  FBtnNumCaption[18] := '7';
  FBtnNumCaption[19] := '8';
  FBtnNumCaption[20] := '9';
  FBtnNumCaption[21] := '-';
  FBtnNumCaption[22] := 'Enter';
  FBtnNumCaption[23] := '  ';
  FBtnNumCaption[24] := 'Left';
  FBtnNumCaption[25] := '0';
  FBtnNumCaption[26] := 'Right';
  FBtnNumCaption[27] := '  ';
  FBtnNumCaption[28] := 'Cancel';
  FBtnNumCaption[29] := 'Confirm';
end;

procedure TfrmPTK.GenerateCaptionByMenu(aMenu: string);
begin
  if aMenu = 'SysCtrl' then
  begin
    GenerateSysCtrlMenu;
  end
  else if aMenu = 'LocalCtrl' then
  begin
    GenerateLocalCtrlMenu;
  end
  else if aMenu = 'Combat' then
  begin
    GenerateCombatMenu;
  end
  else if aMenu = 'Check' then
  begin
    GenerateCheckMenu;
  end
  else if aMenu = 'IndSetting' then
  begin
    GenerateIndSettingMenu;
  end
  else if aMenu = 'CtrlGun' then
  begin
    GenerateCtrlGunMenu;
  end
  else if aMenu = 'Video' then
  begin
    GenerateVideoMenu;
  end
  else if aMenu = 'DataRecord' then
  begin
    GenerateDataRecordMenu;
  end;

  if aMenu = 'LockScreen' then
  begin
    GenerateLockScreenMenu;
    FisScreenLocked := not FisScreenLocked;
  end;
end;

procedure TfrmPTK.GenerateCheckMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := 'Combat' + #13#10;
  FBtnArray[8].Caption := 'Check' + #13#10;
  FBtnArray[9].Caption := '  ';
  FBtnArray[10].Caption := '  ';
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := 'EO FCS' + #13#10 + 'Static';
  FBtnArray[13].Caption := 'EO FCS' + #13#10 + 'Dynamic';
  FBtnArray[14].Caption := 'EO Semi' + #13#10 + 'Static';
  FBtnArray[15].Caption := 'EO Semi' + #13#10 + 'Dynamic';
  FBtnArray[16].Caption := '  ';
  FBtnArray[17].Caption := '  ';
  if FMode = 0 then
  begin
    FBtnArray[18].Caption := 'FCC1&Gun' + #13#10;
  end
  else if FMode = 1 then
  begin
    FBtnArray[18].Caption := 'FCC2&Gun' + #13#10;
  end;
  FBtnArray[19].Caption := 'Gun' + #13#10 + 'Static';
  FBtnArray[20].Caption := 'Gun' + #13#10 + 'Speed';
  FBtnArray[21].Caption := 'Gun' + #13#10 + 'Sin';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := '  ';
  if FMode = 0 then
  begin
    FBtnArray[24].Caption := 'FCC1' + #13#10 + 'Static';
  end
  else if FMode = 1 then
  begin
    FBtnArray[24].Caption := 'FCC2' + #13#10 + 'Static';
  end;
  if FMode = 0 then
  begin
    FBtnArray[25].Caption := 'FCC1' + #13#10 + 'Dynamic';
  end
  else if FMode = 1 then
  begin
    FBtnArray[25].Caption := 'FCC2' + #13#10 + 'Dynamic';
  end;
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := '  ';
  FBtnArray[28].Caption := 'Check' + #13#10 +'Start';
  FBtnArray[29].Caption := 'Check' + #13#10 +'Stop';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btnCombat';
  FBtnArray[8].Name := 'btnCheck';
  FBtnArray[9].Name := 'btn9';
  FBtnArray[10].Name := 'btn10';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btnEoFcsStatic';
  FBtnArray[13].Name := 'btnEoFcsDynamic';
  FBtnArray[14].Name := 'btnEoSemiStatic';
  FBtnArray[15].Name := 'btnEoSemiDynamic';
  FBtnArray[16].Name := 'btn16';
  FBtnArray[17].Name := 'btn17';
  FBtnArray[18].Name := 'btnFccAndGun';
  FBtnArray[19].Name := 'btnGunStatic';
  FBtnArray[20].Name := 'btnGunSpeed';
  FBtnArray[21].Name := 'btnGunSin';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btnFccStatic';
  FBtnArray[25].Name := 'btnFccDynamic';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btn27';
  FBtnArray[28].Name := 'btnCheckStart';
  FBtnArray[29].Name := 'btnCheckStop';
end;

procedure TfrmPTK.GenerateCombatMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := 'Combat' + #13#10;
  FBtnArray[8].Caption := 'Check' + #13#10;
  FBtnArray[9].Caption := '  ';
  FBtnArray[10].Caption := '  ';
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := 'IND' + #13#10 + 'Setting';
  FBtnArray[13].Caption := 'D. Attack' + #13#10 + 'Setting';
  FBtnArray[14].Caption := 'V. Fire' + #13#10 + 'Setting';
  FBtnArray[15].Caption := 'Wait' + #13#10;
  FBtnArray[16].Caption := 'IND' + #13#10;
  FBtnArray[17].Caption := 'Autono-' + #13#10 + 'mous';
  FBtnArray[18].Caption := 'CAL' + #13#10 + 'Setting';
  FBtnArray[19].Caption := 'NAV' + #13#10 + 'Setting';
  FBtnArray[20].Caption := 'Weather' + #13#10 + 'Setting';
  FBtnArray[21].Caption := 'D. Attack';
  FBtnArray[22].Caption := 'V. Fire';
  FBtnArray[23].Caption := '  ';
  FBtnArray[24].Caption := '  ';
  if FisEO then
  begin
    FBtnArray[25].Caption := 'EO' + #13#10;
  end
  else
  begin
    FBtnArray[25].Caption := 'TR' + #13#10;
  end;
  FBtnArray[26].Caption := '  ';
  if FisZeroFlyOn then
  begin
    FBtnArray[27].Caption := 'Zero Fly'  + #13#10 + 'On';
  end
  else
  begin
    FBtnArray[27].Caption := 'Zero Fly'  + #13#10 + 'Off';
  end;
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := 'Confirm' + #13#10;

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btnCombat';
  FBtnArray[8].Name := 'btnCheck';
  FBtnArray[9].Name := 'btn9';
  FBtnArray[10].Name := 'btn10';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btnIndSetting';
  FBtnArray[13].Name := 'btnDAttackSetting';
  FBtnArray[14].Name := 'btnVFireSetting';
  FBtnArray[15].Name := 'btnWait';
  FBtnArray[16].Name := 'btnInd';
  FBtnArray[17].Name := 'btnAutonomous';
  FBtnArray[18].Name := 'btnCalSetting';
  FBtnArray[19].Name := 'btnNavSetting';
  FBtnArray[20].Name := 'btnWeatherSetting';
  FBtnArray[21].Name := 'btnDAttack';
  FBtnArray[22].Name := 'btnVFire';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btnEo';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btnZeroFlyOff';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btnConfirm';

  SetOperationModeDisplay;
end;

procedure TfrmPTK.GenerateCtrlGunMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := 'Servo On'    + #13#10;
  FBtnArray[8].Caption := '  ';
  FBtnArray[9].Caption := '  ';
  FBtnArray[10].Caption := 'L Drum' + #13#10;
  FBtnArray[11].Caption := 'R Drum' + #13#10;
  FBtnArray[12].Caption := '  ';
  FBtnArray[13].Caption := 'COO' + #13#10 + 'Disabled';
  FBtnArray[14].Caption := '  ';
  FBtnArray[15].Caption := 'High' + #13#10;
  FBtnArray[16].Caption := 'Middle' + #13#10;
  FBtnArray[17].Caption := 'Low' + #13#10;
  FBtnArray[18].Caption := '  ';
  FBtnArray[19].Caption := 'Return' + #13#10 + 'Zero';
  FBtnArray[20].Caption := 'Turn Off';
  FBtnArray[21].Caption := 'RR' + #13#10 + 'Setting';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := 'Time' + #13#10 + 'Setting';
  FBtnArray[24].Caption := '  ';
  FBtnArray[25].Caption := '  ';
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := '  ';
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := '  ';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btnServoOn';
  FBtnArray[8].Name := 'btn8';
  FBtnArray[9].Name := 'btn9';
  FBtnArray[10].Name := 'btnLDrum';
  FBtnArray[11].Name := 'btnRDrum';
  FBtnArray[12].Name := 'btn12';
  FBtnArray[13].Name := 'btnCooDisabled';
  FBtnArray[14].Name := 'btn14';
  FBtnArray[15].Name := 'btnHigh';
  FBtnArray[16].Name := 'btnMiddle';
  FBtnArray[17].Name := 'btnLow';
  FBtnArray[18].Name := 'btn18';
  FBtnArray[19].Name := 'btn19';
  FBtnArray[20].Name := 'btn20';
  FBtnArray[21].Name := 'btnRrSetting';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btnTimeSetting';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btn25';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btn27';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btn29';
end;

procedure TfrmPTK.GenerateDataRecordMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := '  ';
  FBtnArray[8].Caption := '  ';
  FBtnArray[9].Caption := 'Record' + #13#10 + 'Start';
  FBtnArray[10].Caption := 'Record' + #13#10 + 'Stop';
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := '  ';
  FBtnArray[13].Caption := '  ';
  FBtnArray[14].Caption := '  ';
  FBtnArray[15].Caption := '  ';
  FBtnArray[16].Caption := '  ';
  FBtnArray[17].Caption := '  ';
  FBtnArray[18].Caption := '  ';
  FBtnArray[19].Caption := '  ';
  FBtnArray[20].Caption := '  ';
  FBtnArray[21].Caption := '  ';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := '  ';
  FBtnArray[24].Caption := '  ';
  FBtnArray[25].Caption := '  ';
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := '  ';
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := '  ';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btn7';
  FBtnArray[8].Name := 'btn8';
  FBtnArray[9].Name := 'btnRecordStart';
  FBtnArray[10].Name := 'btnRecordStop';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btn12';
  FBtnArray[13].Name := 'btn13';
  FBtnArray[14].Name := 'btn14';
  FBtnArray[15].Name := 'btn15';
  FBtnArray[16].Name := 'btn16';
  FBtnArray[17].Name := 'btn17';
  FBtnArray[18].Name := 'btn18';
  FBtnArray[19].Name := 'btn19';
  FBtnArray[20].Name := 'btn20';
  FBtnArray[21].Name := 'btn21';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btn25';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btn27';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btn29';
end;

procedure TfrmPTK.GenerateIndSettingMenu;
var
  i: Integer;
begin
  if FMode = 0 then
  begin
    FBtnArray[0].Caption := 'FCC1' + #13#10;
  end
  else if FMode = 1 then
  begin
    FBtnArray[0].Caption := 'FCC2' + #13#10;
  end;
  FBtnArray[1].Caption := 'TCC' + #13#10;
  FBtnArray[2].Caption := 'SR' + #13#10;
  FBtnArray[3].Caption := 'TR' + #13#10;
  FBtnArray[29].Caption := 'BACK' + #13#10;

  EnableAllBtn;
  for i := 4 to Length(FBtnArray) - 2 do
  begin
    FBtnArray[i].Caption := '  ';
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Name := 'btn' + IntToStr(i);
  end;

  FBtnArray[0].Name := 'btnFcc';
  FBtnArray[1].Name := 'btnTcc';
  FBtnArray[2].Name := 'btnSr';
  FBtnArray[3].Name := 'btnTr';
  FBtnArray[29].Name := 'btnBack';
end;

procedure TfrmPTK.GenerateLocalCtrlMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := 'Combat' + #13#10;
  FBtnArray[8].Caption := 'Check' + #13#10;
  FBtnArray[9].Caption := '  ';
  FBtnArray[10].Caption := '  ';
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := '  ';
  FBtnArray[13].Caption := '  ';
  FBtnArray[14].Caption := '  ';
  FBtnArray[15].Caption := '  ';
  FBtnArray[16].Caption := '  ';
  FBtnArray[17].Caption := '  ';
  FBtnArray[18].Caption := '  ';
  FBtnArray[19].Caption := '  ';
  FBtnArray[20].Caption := '  ';
  FBtnArray[21].Caption := '  ';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := '  ';
  FBtnArray[24].Caption := '  ';
  FBtnArray[25].Caption := '  ';
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := 'Zero Fly'  + #13#10 + 'Off';
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := '  ';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btnCombat';
  FBtnArray[8].Name := 'btnCheck';
  FBtnArray[9].Name := 'btn9';
  FBtnArray[10].Name := 'btn10';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btn12';
  FBtnArray[13].Name := 'btn13';
  FBtnArray[14].Name := 'btn14';
  FBtnArray[15].Name := 'btn15';
  FBtnArray[16].Name := 'btn16';
  FBtnArray[17].Name := 'btn17';
  FBtnArray[18].Name := 'btn18';
  FBtnArray[19].Name := 'btn19';
  FBtnArray[20].Name := 'btn20';
  FBtnArray[21].Name := 'btn21';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btn25';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btnZeroFlyOff';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btn29';

//  FBtnArray[7].GroupIndex := 2;
//  FBtnArray[8].GroupIndex := 2;
end;

procedure TfrmPTK.GenerateLockScreenMenu;
begin
  if FisScreenLocked then
  begin
    EnableAllBtn;
    FBtnArray[5].Caption := 'Lock' + #13#10 + 'Screen';
  end
  else
  begin
    DisableAllBtn;
    FBtnArray[5].Enabled := True;
    FBtnArray[5].Caption := 'Unlock' + #13#10 + 'Screen';
  end;
end;

procedure TfrmPTK.GenerateNames;
var
  i : Integer;
begin
  FBtnMainNames[0] := 'SysCtrl';
  FBtnMainNames[1] := 'LocalCtrl';
  FBtnMainNames[2] := 'CtrlGun';
  FBtnMainNames[3] := 'Video';
  FBtnMainNames[4] := 'DataRecord';
  FBtnMainNames[5] := 'LockScreen';
  FBtnMainNames[6] := 'NavSetting';
  FBtnMainNames[7] := 'WeatherSetting';
  FBtnMainNames[8] := 'CalSetting';
  FBtnMainNames[27] := 'ZeroFlyOff';

  for i := 9 to Length(FBtnMainNames)-1 do
  begin
    if i <> 27 then
      FBtnMainNames[i] := IntToStr(i);
  end;

  FBtnNumNames[0] := 'NumE';
  FBtnNumNames[1] := 'NumW';
  FBtnNumNames[2] := 'NumS';
  FBtnNumNames[3] := 'NumN';
  FBtnNumNames[4] := '4';
  FBtnNumNames[5] := '5';
  FBtnNumNames[6] := 'Num1';
  FBtnNumNames[7] := 'Num2';
  FBtnNumNames[8] := 'Num3';
  FBtnNumNames[9] := 'NumDot';
  FBtnNumNames[10] := 'NumUp';
  FBtnNumNames[11] := 'NumBackspace';
  FBtnNumNames[12] := 'Num4';
  FBtnNumNames[13] := 'Num5';
  FBtnNumNames[14] := 'Num6';
  FBtnNumNames[15] := 'NumPlus';
  FBtnNumNames[16] := 'NumDown';
  FBtnNumNames[17] := 'NumDel';
  FBtnNumNames[18] := 'Num7';
  FBtnNumNames[19] := 'Num8';
  FBtnNumNames[20] := 'Num9';
  FBtnNumNames[21] := 'NumMinus';
  FBtnNumNames[22] := 'NumEnter';
  FBtnNumNames[23] := '23';
  FBtnNumNames[24] := 'NumLeft';
  FBtnNumNames[25] := 'Num0';
  FBtnNumNames[26] := 'NumRight';
  FBtnNumNames[27] := '27';
  FBtnNumNames[28] := 'NumCancel';
  FBtnNumNames[29] := 'NumConfirm';
end;

procedure TfrmPTK.GenerateSysCtrlMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := 'NAV'  + #13#10 + 'Setting';
  FBtnArray[7].Caption := 'Weather'    + #13#10 + 'Setting';
  FBtnArray[8].Caption := 'CAL' + #13#10 + 'Setting';
  FBtnArray[9].Caption := '  ';
  FBtnArray[10].Caption := '  ';
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := '  ';
  FBtnArray[13].Caption := '  ';
  FBtnArray[14].Caption := '  ';
  FBtnArray[15].Caption := '  ';
  FBtnArray[16].Caption := '  ';
  FBtnArray[17].Caption := '  ';
  FBtnArray[18].Caption := '  ';
  FBtnArray[19].Caption := '  ';
  FBtnArray[20].Caption := '  ';
  FBtnArray[21].Caption := '  ';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := '  ';
  FBtnArray[24].Caption := '  ';
  FBtnArray[25].Caption := '  ';
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := 'Zero Fly'  + #13#10 + 'Off';
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := '  ';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btnNavSetting';
  FBtnArray[7].Name := 'btnWeatherSetting';
  FBtnArray[8].Name := 'btnCalSetting';
  FBtnArray[9].Name := 'btn9';
  FBtnArray[10].Name := 'btn10';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btn12';
  FBtnArray[13].Name := 'btn13';
  FBtnArray[14].Name := 'btn14';
  FBtnArray[15].Name := 'btn15';
  FBtnArray[16].Name := 'btn16';
  FBtnArray[17].Name := 'btn17';
  FBtnArray[18].Name := 'btn18';
  FBtnArray[19].Name := 'btn19';
  FBtnArray[20].Name := 'btn20';
  FBtnArray[21].Name := 'btn21';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btn25';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btnZeroFlyOff';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btn29';
end;

procedure TfrmPTK.GenerateVideoMenu;
var
  i: Integer;
begin
  FBtnArray[0].Caption := 'SYS CTRL'    + #13#10;
  FBtnArray[1].Caption := 'LOCAL'  + #13#10 + 'CTRL';
  FBtnArray[2].Caption := 'Ctrl'  + #13#10 + 'Gun';
  FBtnArray[3].Caption := 'Video'  + #13#10;
  FBtnArray[4].Caption := 'Data' + #13#10 + 'Record';
  FBtnArray[5].Caption := 'Lock'  + #13#10 + 'Screen';
  FBtnArray[6].Caption := '  ';
  FBtnArray[7].Caption := '  ';
  FBtnArray[8].Caption := '  ';
  FBtnArray[9].Caption := 'TV' + #13#10;
  FBtnArray[10].Caption := 'IR' + #13#10;
  FBtnArray[11].Caption := '  ';
  FBtnArray[12].Caption := 'Bright' + #13#10 + '+';
  FBtnArray[13].Caption := 'Bright' + #13#10 + '-';
  FBtnArray[14].Caption := 'Contrast' + #13#10 + '+';
  FBtnArray[15].Caption := 'Contrast' + #13#10 + '-';
  FBtnArray[16].Caption := 'Gain' + #13#10 + '+';
  FBtnArray[17].Caption := 'Gain' + #13#10 + '-';
  FBtnArray[18].Caption := '  ';
  FBtnArray[19].Caption := '  ';
  FBtnArray[20].Caption := '  ';
  FBtnArray[21].Caption := '  ';
  FBtnArray[22].Caption := '  ';
  FBtnArray[23].Caption := '  ';
  FBtnArray[24].Caption := '  ';
  FBtnArray[25].Caption := '  ';
  FBtnArray[26].Caption := '  ';
  FBtnArray[27].Caption := '  ';
  FBtnArray[28].Caption := '  ';
  FBtnArray[29].Caption := '  ';

  EnableAllBtn;

  for i := 0 to Length(FBtnArray) - 1 do
  begin
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

  FBtnArray[0].Name := 'btnSysCtrl';
  FBtnArray[1].Name := 'btnLocalCtrl';
  FBtnArray[2].Name := 'btnCtrlGun';
  FBtnArray[3].Name := 'btnVideo';
  FBtnArray[4].Name := 'btnDataRecord';
  FBtnArray[5].Name := 'btnLockScreen';
  FBtnArray[6].Name := 'btn6';
  FBtnArray[7].Name := 'btn7';
  FBtnArray[8].Name := 'btn8';
  FBtnArray[9].Name := 'btnTv';
  FBtnArray[10].Name := 'btnIr';
  FBtnArray[11].Name := 'btn11';
  FBtnArray[12].Name := 'btnBrightPlus';
  FBtnArray[13].Name := 'btnBrightMin';
  FBtnArray[14].Name := 'btnContrastPlus';
  FBtnArray[15].Name := 'btnContrastMin';
  FBtnArray[16].Name := 'btnGainPlus';
  FBtnArray[17].Name := 'btnGainMin';
  FBtnArray[18].Name := 'btn18';
  FBtnArray[19].Name := 'btn19';
  FBtnArray[20].Name := 'btn20';
  FBtnArray[21].Name := 'btn21';
  FBtnArray[22].Name := 'btn22';
  FBtnArray[23].Name := 'btn23';
  FBtnArray[24].Name := 'btn24';
  FBtnArray[25].Name := 'btn25';
  FBtnArray[26].Name := 'btn26';
  FBtnArray[27].Name := 'btn27';
  FBtnArray[28].Name := 'btn28';
  FBtnArray[29].Name := 'btn29';
end;

procedure TfrmPTK.InitButtons;
var
  i, j,k : Integer;
  aTopInc : Integer;
begin
  GenerateCaption;
  GenerateNames;
  aTopInc := 0;
  j := 0;
  k := 0;

  pnlPTK := TPanel.Create(nil);
  pnlPTK.Parent := Self;
  pnlPTK.Align := alClient;
  for i := 0 to Length(FBtnArray) - 1 do
  begin
    btn             := TSpeedButtonImage.Create(nil);
    btn.Parent      := pnlPTK;
    btn.Width       := Btn_Width;
    btn.Height      := Btn_Height;
    btn.Color       := clBlack;
    btn.Font.Color  := CL_TCMS_Orange;
    btn.Font.Size   := FFont_Btn;
    btn.Name        := 'btn' + FBtnMainNames[i];
    btn.Caption     := FBtnMainCaption[i];
    btn.OnClick     := btnPtkClick;
    btn.Tag         := i;
    btn.Left        := Btn_Separator + k * (Btn_Width + Btn_Separator);
    btn.Top         := Btn_Separator + aTopInc;
    FBtnArray[i]    := btn;
    k := k + 1;

    if ((i + 1)mod 6) = 0 then begin
      j := j + 1;
      aTopInc := j * (Btn_Height + Btn_Separator);
      k := 0;
    end;
    if AnsiContainsStr(FBtnArray[i].Caption, '  ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
//  FBtnArray[0].GroupIndex := 1;
//  FBtnArray[1].GroupIndex := 1;
//  FBtnArray[0].Down := True;
  FBtnArray[0].Color := clLime;
  FBtnArray[1].Color := clBlack;
  aTopInc := 0;
  j := 0;
  k := 0;
  pnlNumKey := TPanel.Create(nil);
  pnlNumKey.Parent := Self;
  pnlNumKey.ParentBackground := False;
  pnlNumKey.Align := alClient;
  pnlNumKey.Color := clMedGray;
   for i := 0 to Length(FBtnArrayNumKey) - 1 do
  begin
    btn             := TSpeedButtonImage.Create(nil);
    btn.Parent      := pnlNumKey;
    btn.Width       := Btn_Width;
    btn.Height      := Btn_Height;
    btn.Color       := clSkyBlue;
    btn.Font.Color  := clTeal;
    btn.Font.Size   := FFont_Btn;
    btn.Font.Style := [fsBold];
    btn.Name        := 'btnNk' + FBtnNumNames[i];
    btn.Caption     := FBtnNumCaption[i];
    btn.OnClick     := btnNkClick;
    btn.Tag         := i;
    btn.Left        := Btn_Separator + k * (Btn_Width + Btn_Separator);
    btn.Top         := Btn_Separator + aTopInc;
    FBtnArrayNumKey[i]    := btn;
    k := k + 1;

    if ((i + 1)mod 6) = 0 then begin
      j := j + 1;
      aTopInc := j * (Btn_Height + Btn_Separator);
      k := 0;
    end;
    if AnsiContainsStr(FBtnArrayNumKey[i].Caption, '  ') then begin
      FBtnArrayNumKey[i].Enabled := False;
    end;
  end;

  pnlPTK.BringToFront;
end;

procedure TfrmPTK.OnTimerConnectOnTime(const dt: Double);
begin

end;

procedure TfrmPTK.ProcessCommand(Cmd: String);
begin

end;

procedure TfrmPTK.SendToServerPTK(str: string);
begin

end;

procedure TfrmPTK.SetOperationModeDisplay;
begin
  case FOperationMode of
    omWait:
    begin
      FBtnArray[15].Color := clLime;
      FBtnArray[16].Color := clBlack;
      FBtnArray[17].Color := clBlack;
      FBtnArray[21].Color := clBlack;
      FBtnArray[22].Color := clBlack;
    end;
    omInd:
    begin
      FBtnArray[15].Color := clBlack;
      FBtnArray[16].Color := clLime;
      FBtnArray[17].Color := clBlack;
      FBtnArray[21].Color := clBlack;
      FBtnArray[22].Color := clBlack;
    end;
    omAutonomous:
    begin
      FBtnArray[15].Color := clBlack;
      FBtnArray[16].Color := clBlack;
      FBtnArray[17].Color := clLime;
      FBtnArray[21].Color := clBlack;
      FBtnArray[22].Color := clBlack;
    end;
    omDAttack:
    begin
      FBtnArray[15].Color := clBlack;
      FBtnArray[16].Color := clBlack;
      FBtnArray[17].Color := clBlack;
      FBtnArray[21].Color := clLime;
      FBtnArray[22].Color := clBlack;
    end;
    omVFire:
    begin
      FBtnArray[15].Color := clBlack;
      FBtnArray[16].Color := clBlack;
      FBtnArray[17].Color := clBlack;
      FBtnArray[21].Color := clBlack;
      FBtnArray[22].Color := clLime;
    end;
  end;
end;

procedure TfrmPTK.SetRole(Msg: String);
begin

end;

procedure TfrmPTK.SocketClientDataAvailable(Sender: TObject; ErrCode: Word);
begin

end;

procedure TfrmPTK.SocketClientSessionClosed(Sender: TObject; ErrCode: Word);
begin

end;

end.
