unit uNewFrmPDK;

{
  This is New Form of WinPDK
  For WinPDF.exe and TCMS PDK in Train
  This Unit Used In 2 Project In Same Time
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedButtonImage, StrUtils, IniFiles, ExtCtrls,
  OverbyteIcsWSocket, uFrmLogNewPDK, uThreadTimer, UfrmBaseTCMS, uLibSettings;

const
  CONST_RT_NOROLE = '0';
  CONST_RT_SSW = '1';
  CONST_RT_SPC = '2';
  CONST_RT_AAW = '3';
  CONST_RT_APC = '4';
  CONST_RT_TRAIN = '5';
  CONST_RT_GSS = '6';
  CONST_RT_PWO = '7';
  CONST_RT_PC = '8';
  CONST_RT_ASW = '9';
  CONST_RT_AWW = '10';
  CONST_RT_EWOP = '11';

type

  TBtnMainType = (
        bmtGen, bmtTrackAir, bmtTrackSurf, bmtTrackSubsurf, bmtLinkYCntrl,
        bmtTrainEnv, bmtLirodEng, bmtTwsEng, bmtWeaponEng, bmtIdentCh
      );

  TfrmMainPDK = class(TfrmBaseTCMS)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
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
//    FServiceMonitor : integer;

    Btn_Separator : integer;
    Btn_Width : integer;
    Btn_Height : integer;
    FFont_Btn : Integer;

    { Private declarations }
    btn : TSpeedButtonImage;
    FBtnArray         : array [0..34] of TSpeedButtonImage;
    FBtnMainCaption   : array [0..34] of string;
    FBtnMainNames     : array [0..34] of string;

    IdIncr : Integer;

    procedure GenerateCaption;
    procedure GenerateNames;

    procedure addToLog(str : string);
    procedure SendToServerPDK(str : string);

    { All Event Button in Win PDK }
    procedure btnPdkClick(Sender : TObject);

    procedure GenerateCaptionByMenu(aMenu : string);
    procedure GenerateGenMenu;
    procedure GenerateTrackAirMenu;
    procedure GenerateTrackSurfMenu;
    //ICA
    procedure GenerateTrackSubSurfmenu;
    procedure GenerateLinkYCntrlMenu;
    procedure GenerateIdentcChangeMenu;
    procedure GenerateTrainEnvMenu;

    procedure GenerateLirodEngageMenu;
    procedure GenerateTwsEngageMenu;
    procedure GenerateWeaponEngageMenu;

    procedure EnableAllBtn;

    // Modified by DID 9/25/2013 9:21:54 AM
    //SSW
    procedure SswGenerateCaption;
    procedure SswGenerateNames;

    procedure SswGenerateCaptionByMenu(aMenu : string);
    procedure SswGenerateGenMenu;
    procedure SswGenerateTrackSurfMenu;
    procedure SswGenerateTrackSubSrfMenu;
    procedure SswGenerateLinkYCntrlMenu;
    procedure SswGenerateLirodEngageMenu;
    procedure SswGenerateTwsEngageMenu;
    procedure SswGenerateWeaponEngageMenu;
    procedure SswGenerateIdentChangeMenu;

    //SPC-1
    procedure SpcGenerateCaption;
    procedure SpcGenerateNames;

    procedure SpcCaptionByMenu(amenu : string);
    procedure SpcGenMenu;
    procedure SpcTrackSurfMenu;
    procedure SpcTrackSubSurfMenu;
    procedure SpcIdentChangeMenu;

    //ASW
    procedure AswGenerateCaption;
    procedure AswGenerateNames;

    procedure AswCaptionByMenu(aMenu : string);
    procedure AswGenMenu;
    procedure AswTrackSurfMenu;
    procedure AswTrackSubSurfMenu;
    procedure AswLinkYCntrlMenu;
    procedure AswLiroidEngageMenu;
    procedure AswWeaponEngageMenu;
    procedure AswIdentChangeMenu;

    //AAW
    procedure AawGenerateCaption;
    procedure AawGenerateNames;

    procedure AawCaptionByMenu(aMenu : string);
    procedure AawGenMenu;
    procedure AawTrackAirMenu;
    procedure AawLinkYCntrlMenu;
    procedure AawLirodEngageMenu;
    procedure AawTwsEngageMenu;
    procedure AawWeaponEngageMenu;
    procedure AawIdentChangeMenu;

    //APC
    procedure ApcGeneralCaption;
    procedure ApcGeneralNames;

    procedure ApcCaptionByMenu(aMenu : string);
    procedure ApcGenMenu;
    procedure ApcTrackAirMenu;
    procedure ApcLinkYCntrlMenu;
    procedure ApcIdentChangeMenu;

    //TRAIN
    procedure TrainGeneralCaption;
    procedure TrainGeneralNames;

    procedure TrainCaptionByMenu(aMenu : string);
    procedure TrainGenMenu;
    procedure TrainTrackAirMenu;
    procedure TrainTrackSurfMenu;
    procedure TrainTrackSubSrfMenu;
    procedure TrainEnvMenu;
    procedure TrainIdentChangeMenu;

    //GSS
    procedure GssGenerateCaption;
    procedure GssGenerateNames;

    procedure GssCaptionByMenu(aMenu : string);
    procedure GssGenMenu;

    //PWO
    procedure PwoGenerateCaption;
    procedure PwoGenerateNames;

    procedure PwoCaptionByMenu(aMenu : string);
    procedure PwoGenMenu;
    procedure PwoTrackAirMenu;
    procedure PwoTrackSurfMenu;
    procedure PwoTrackSubSrfMenu;
    procedure PwoLinkYCntrlMenu;
    procedure PwoLirodEngageMenu;
    procedure PwoTwsEngageMenu;
    procedure PwoWeaponEngageMenu;
    procedure PwoIdentChangeMenu;

    //PC
    procedure PcGenerateCaption;
    procedure PcGenerateNames;

    procedure PcCaptionByMenu(aMenu : string);
    procedure PcGenMenu;
    procedure PcTrackAirMenu;
    procedure PcTrackSurfMenu;
    procedure PcTrackSubSrfMenu;
    procedure PcLinkYCntrlMenu;
    procedure PcIdentChangeMenu;

    //AWW
    procedure AwwGenerateCaption;
    procedure AwwGenerateNames;

    procedure AwwCaptionByMenu(aMenu : string);
    procedure AwwGenMenu;
    procedure AwwTrackAirMenu;
    procedure AwwTrackSurfMenu;
    procedure AwwLinkYCntrlMenu;
    procedure AwwLirodEngageMenu;
    procedure AwwTwsEngageMenu;
    procedure AwwWeaponEngageMenu;
    procedure AwwIdentChangeMenu;

    { Network Handler}
    procedure OnTimerConnectOnTime(const dt : Double);
    procedure SocketClientSessionClosed(Sender: TObject; ErrCode: Word);
    procedure SocketClientDataAvailable(Sender: TObject; ErrCode: Word);
    procedure SetRole(Msg : String);
    procedure FalseRole;
    procedure ProcessCommand(Cmd : String);

  public
    { Public declarations }
    SswMode : Boolean;
    SpcMode : Boolean;
    AswMode : Boolean;
    AawMode : Boolean;
    ApcMode : Boolean;
    TrainMode : Boolean;
    GssMode : Boolean;
    PwoMode : Boolean;
    PcMode  : Boolean;
    AwwMode : Boolean;

    fSelected     : Integer;
    fSelectedSub  : Integer;

    fColorWindow, fColorWindowBg : Integer;

    procedure InitButtons;
  end;

var
  frmMainPDK: TfrmMainPDK;

implementation

uses
  uTCMSColors;

{$R *.dfm}

{ TfrmMainPDK }

procedure TfrmMainPDK.addToLog(str: string);
begin
  frmLogPDK.mmoLog.Lines.Insert(0, str);
end;

procedure TfrmMainPDK.ApcCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    ApcGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    ApcTrackAirMenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    ApcLinkYCntrlMenu;
  end
  else if aMenu = 'IdentChange' then begin
    ApcIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.ApcGeneralCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := ' '  + #13#10 + ' ';
  FBtnMainCaption[3] := ' '  + #13#10 + ' ';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := ' '  + #13#10 + ' ';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := ' ' + #13#10 + ' ';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.ApcGeneralNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := ' ';
  FBtnMainNames[3] := ' ';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := ' ';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := ' ';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.ApcGenMenu;
begin
  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;

  FBtnArray[27].Enabled := False;
  FBtnArray[27].Font.Color := clGray;

  FBtnArray[28].Enabled := False;
  FBtnArray[28].Font.Color := clGray;

end;

procedure TfrmMainPDK.ApcLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
//    GenerateCaptionByMenu(FBtnArray[i].Name);
  end;


end;

procedure TfrmMainPDK.ApcTrackAirMenu;
begin
  FBtnArray[12].Enabled := False;
  FBtnArray[12].Font.Color := clGray;
end;

procedure TfrmMainPDK.AswCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    AswGenMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    AswTrackSurfMenu;
  end
  else if aMenu = 'TrackSubsurf' then begin
    AswTrackSubSurfMenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    AswLinkYCntrlMenu
  end
  else if aMenu = 'LirodEngage' then begin
    AswLiroidEngageMenu;
  end
  else if aMenu ='WeaponEngage' then begin
    AswWeaponEngageMenu;
  end
  else if aMenu = 'IdentChange' then begin
    AswIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.AswGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := ' '  + #13#10 + ' ';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.AswGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := ' ';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.AswGenMenu;
begin

  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;
end;


procedure TfrmMainPDK.AswIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.AswLinkYCntrlMenu;
var i : Integer;
begin
   for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
//    GenerateCaptionByMenu(FBtnArray[i].Name);
  end;
end;

procedure TfrmMainPDK.AswLiroidEngageMenu;
begin
  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;
end;

procedure TfrmMainPDK.AswTrackSubSurfMenu;
begin
  GenerateTrackSubSurfmenu;
end;

procedure TfrmMainPDK.AswTrackSurfMenu;
begin
  FBtnArray[10].Enabled := False;
  FBtnArray[10].Font.Color := clGray;

  FBtnArray[11].Enabled := False;
  FBtnArray[11].Font.Color := clGray;

  FBtnArray[12].Enabled := False;
  FBtnArray[12].Font.Color := clGray;

  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[16].Enabled := False;
  FBtnArray[16].Font.Color := clGray;

  FBtnArray[17].Enabled := False;
  FBtnArray[17].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;
end;

procedure TfrmMainPDK.AswWeaponEngageMenu;
begin
  FBtnArray[11].Enabled := False;
  FBtnArray[11].Font.Color := clGray;

  FBtnArray[12].Enabled := False;
  FBtnArray[12].Font.Color := clGray;

  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[16].Enabled := False;
  FBtnArray[16].Font.Color := clGray;

  FBtnArray[17].Enabled := False;
  FBtnArray[17].Font.Color := clGray;

  FBtnArray[18].Enabled := False;
  FBtnArray[18].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;
end;

procedure TfrmMainPDK.AwwCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    AwwGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    AwwTrackAirMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    AwwTrackSurfMenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    AwwLinkYCntrlMenu;
  end
  else if aMenu = 'LirodEngage' then begin
    AwwLirodEngageMenu;
  end
  else if aMenu = 'TwsEngage' then begin
    AwwTwsEngageMenu;
  end
  else if aMenu = 'WeaponEngage' then begin
    AwwWeaponEngageMenu;
  end
  else if aMenu = 'IdentChange' then begin
    AwwIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.AwwGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := ' '  + #13#10 + ' ';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.AwwGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := ' ';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.AwwGenMenu;
begin
  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[27].Enabled := False;
  FBtnArray[27].Font.Color := clGray;

  FBtnArray[28].Enabled := False;
  FBtnArray[28].Font.Color := clGray;
end;

procedure TfrmMainPDK.AwwIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.AwwLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
  end;
end;

procedure TfrmMainPDK.AwwLirodEngageMenu;
begin

end;

procedure TfrmMainPDK.AwwTrackAirMenu;
begin

end;

procedure TfrmMainPDK.AwwTrackSurfMenu;
begin
  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;
end;

procedure TfrmMainPDK.AwwTwsEngageMenu;
begin

end;

procedure TfrmMainPDK.AwwWeaponEngageMenu;
begin
  FBtnArray[11].Enabled := True;
  FBtnArray[11].Font.Color := clYellow;

  FBtnArray[12].Enabled := True;
  FBtnArray[12].Font.Color := clYellow;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[16].Enabled := True;
  FBtnArray[16].Font.Color := clYellow;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;
end;

procedure TfrmMainPDK.AawCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    AawGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    AawTrackAirMenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    AawLinkYCntrlMenu;
  end
  else if aMenu = 'LirodEngage' then begin
    AawLirodEngageMenu;
  end
  else if aMenu = 'TwsEngage' then begin
    AawTwsEngageMenu;
  end
  else if aMenu = 'WeaponEngage' then begin
    AawWeaponEngageMenu;
  end
  else if aMenu = 'IdentChange' then begin
    AawIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.AawGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := ' '  + #13#10 + ' ';
  FBtnMainCaption[3] := ' '  + #13#10 + ' ';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.AawGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := ' ';
  FBtnMainNames[3] := ' ';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.AawGenMenu;
begin
  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;

  FBtnArray[27].Enabled := False;
  FBtnArray[27].Font.Color := clGray;

  FBtnArray[28].Enabled := False;
  FBtnArray[28].Font.Color := clGray;
end;

procedure TfrmMainPDK.AawIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.AawLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
  end;
end;

procedure TfrmMainPDK.AawLirodEngageMenu;
begin

end;

procedure TfrmMainPDK.AawTrackAirMenu;
begin
  FBtnArray[12].Enabled := False;
  FBtnArray[12].Font.Color := clGray;
end;

procedure TfrmMainPDK.AawTwsEngageMenu;
begin

end;

procedure TfrmMainPDK.AawWeaponEngageMenu;
begin
  FBtnArray[11].Enabled := True;
  FBtnArray[11].Font.Color := clYellow;

  FBtnArray[12].Enabled := True;
  FBtnArray[12].Font.Color := clYellow;

  FBtnArray[16].Enabled := True;
  FBtnArray[16].Font.Color := clYellow;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;

  FBtnArray[27].Enabled := False;
  FBtnArray[27].Font.Color := clGray;
end;

procedure TfrmMainPDK.btnPdkClick(Sender: TObject);
var
  i,j : integer;
  aSender : string;
begin
  aSender := (Sender as TSpeedButtonImage).Name;

  for I := 0 to Length(FBtnArray) - 1 do
  begin
    if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Enabled := False;
        FBtnArray[i].Font.Color := clGray;
        GenerateCaptionByMenu(FBtnArray[i].Name);
        fSelected := i+1;
      end else begin
        fSelectedSub := i+1;

        addToLog(IntToStr(fSelected)+'_'+ IntToStr(fSelectedSub));
        SendToServerPDK(IntToStr(fSelected)+'_'+ IntToStr(fSelectedSub));
      end;
    end;
  end;

  if SswMode = True then begin
    for i := 0 to Length(FBtnArray) - 1 do
    begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            SswGenerateCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end
  else if SpcMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            SpcCaptionByMenu(FBtnArray[i].Name);
          end;
        end;
      end;
  end
  else if AswMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            fSelected := i+1;
            FBtnArray[i].Font.Color := clGray;
            AswCaptionByMenu(FBtnArray[i].Name);
          end;
        end;
      end;
  end
  else if AawMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            AawCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end else if ApcMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            ApcCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end
  else if TrainMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            TrainCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end
  else if PwoMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            PwoCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end
  else if PcMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            PcCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end
  else if AwwMode = True then begin
      for I := 0 to Length(FBtnArray) - 1 do
      begin
        if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then
        begin
          if i < 10 then begin
            EnableAllBtn;
            FBtnArray[i].Enabled := False;
            FBtnArray[i].Font.Color := clGray;
            AwwCaptionByMenu(FBtnArray[i].Name);
          end
        end;
      end;
  end;
end;

procedure TfrmMainPDK.EnableAllBtn;
var
  I : integer;
begin
  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Enabled := True;
    FBtnArray[i].Font.Color := clYellow;
  end;
end;

procedure TfrmMainPDK.FalseRole;
begin
    SswMode := False;
    SpcMode := False;
    AswMode := False;
    AawMode := False;
    ApcMode := False;
    TrainMode := False;
    PwoMode := False;
    PcMode := False;
    AwwMode := False;
    GssMode := False;
end;

procedure TfrmMainPDK.FormCreate(Sender: TObject);
var
  iniF : TIniFile;
  iniPath : string;
begin
  inherited;
  SetServiceIndex(0);

  case VThemeSetting.ColorNum of
    1 : begin
      fColorWindow := CL_TCMS_Window;
      fColorWindowBg := CL_TCMS_WindowBackGround;
    end;
    2 :
    begin
      fColorWindow := CL_CMS_Window;
      fColorWindowBg := CL_CMS_WindowBackGround;
    end;
  end;

  Color := fColorWindow;

  { Initialize FDK }
  FisFullScreen := false;
  BorderStyle := bsDialog;
  Height := 600;
  Width := 400;
//  FServiceMonitor := 0;
  FipConnect := '127.0.0.1';
  FPortConnect := '2345';
  FFont_Btn := 8;

  { Create Network Handler }
  FSocketTCPClient := TWSocket.Create(nil);

  FTimerConnect := TPrecisseTimer.Create;
  FTimerConnect.OnRunning := OnTimerConnectOnTime;
  FTimerConnect.Interval := 2000;
  FTimerConnect.Enabled := True;

  { Get Setting from TCMS.ini }
  iniPath := ExtractFilePath(Application.ExeName) + 'tcmss.ini';
  try
    iniF := TIniFile.Create(iniPath);
    FipConnect := iniF.ReadString('PDKSetting', 'ipConnect', '127.0.0.1');
    FPortConnect := iniF.ReadString('PDKSetting', 'portConnect', '2345');
    FisFullScreen := iniF.ReadBool('PDKSetting', 'isFullScreen', false);
    FFormHeight := iniF.ReadInteger('PDKSetting', 'FormHeight', Height);
    FFormWidth := iniF.ReadInteger('PDKSetting', 'FormWidth', Width);
//    FServiceMonitor := iniF.ReadInteger('PDKSetting', 'ServiceMonitor', 0);
    FFont_Btn := iniF.ReadInteger('PDKSetting', 'FontSize', 6);
    if FFont_Btn < 0 then
      FFont_Btn := 8;
  finally
    iniF.Free;
  end;

  if FisFullScreen then
  begin
    Left := Screen.Monitors[FServiceIndex].Left;
    Top := Screen.Monitors[FServiceIndex].Top;
    Width := Screen.Monitors[FServiceIndex].Width;
    Height := Screen.Monitors[FServiceIndex].Height;

    BorderStyle := bsNone;

    Btn_Separator := 6;
    Btn_Width := ((Width - (Btn_Separator * 6)) div 5);
    Btn_Height := ((Height - (Btn_Separator * 8)) div 7);
  end
  else
  begin
     Left := Screen.Monitors[FServiceIndex].Left;
      Top := Screen.Monitors[FServiceIndex].Top;
      Width := FFormWidth;
      Height := FFormWidth;

    BorderStyle := bsSingle;

    Btn_Separator := 6;
    Btn_Width := ((Width - (Btn_Separator * 6)) div 5) - 1;
    Btn_Height := ((Height - (Btn_Separator * 8)) div 7) - 3;
  end;
  InitButtons;


end;

procedure TfrmMainPDK.FormDestroy(Sender: TObject);
begin
  FSocketTCPClient.OnSessionClosed := nil;
  FSocketTCPClient.OnDataAvailable := nil;

  if FSocketTCPClient.State = wsConnected then
    FSocketTCPClient.Close;
  FSocketTCPClient.Free;

  //FTimerConnect.Enabled := false;
  FTimerConnect.OnRunning := nil;
  FTimerConnect.Free;
end;

procedure TfrmMainPDK.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssShift in Shift then
  begin
    frmLogPDK.Show;
  end;
end;

procedure TfrmMainPDK.GenerateCaption;
var
  i  : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := 'TRAIN'  + #13#10 + 'ENV';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for i := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
  end;

end;

procedure TfrmMainPDK.GenerateCaptionByMenu(aMenu: string);
var
  i : integer;
begin
  if aMenu = 'Gen' then begin
    GenerateGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    GenerateTrackAirMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    GenerateTrackSurfMenu;
  end
  else if aMenu = 'TrackSubsurf' then begin
    GenerateTrackSubSurfmenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    GenerateLinkYCntrlMenu;
  end
  else if aMenu = 'WeaponEngage' then begin
    GenerateWeaponEngageMenu;
  end
  else if aMenu = 'IdentChange' then begin
    GenerateIdentcChangeMenu;
  end
  else if aMenu = 'LirodEngage' then begin
    GenerateLirodEngageMenu;
  end
  else if aMenu = 'TwsEngage' then begin
    GenerateTwsEngageMenu;
  end
  else if aMenu = 'TrainEnv' then begin
    GenerateTrainEnvMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.GenerateGenMenu;
begin
  FBtnMainCaption[10] := ' ';
  FBtnMainCaption[11] := 'PLAFT'  + #13#10 + 'REQ';
  FBtnMainCaption[12] := 'DIS'    + #13#10 + 'JOIN';
  FBtnMainCaption[13] := 'SUW'    + #13#10 + 'ADVICE';
  FBtnMainCaption[14] := 'AAW'    + #13#10 + 'ADVICE';
  FBtnMainCaption[15] := 'SENSOR' + #13#10 + 'RANGE';
  FBtnMainCaption[16] := 'START'  + #13#10 + 'CPA';
  FBtnMainCaption[17] := 'JOIN'   + #13#10 + '';
  FBtnMainCaption[18] := 'ASSOC'  + #13#10 + '';
  FBtnMainCaption[19] := 'INCL'   + #13#10 + 'AAW';
  FBtnMainCaption[20] := 'WEAPON' + #13#10 + 'RANGE';
  FBtnMainCaption[21] := 'STOP'   + #13#10 + 'CPA';
  FBtnMainCaption[22] := 'DCRP'   + #13#10 + '';
  FBtnMainCaption[23] := 'DISSOC' + #13#10 + '';
  FBtnMainCaption[24] := 'EXCL'   + #13#10 + 'AAW';
  FBtnMainCaption[25] := 'HOLD'   + #13#10 + 'FIRE';
  FBtnMainCaption[26] := 'THROW'  + #13#10 + 'OFF';
  FBtnMainCaption[27] := 'MAN'    + #13#10 + 'OB';
  FBtnMainCaption[28] := 'COLL'   + #13#10 + 'AVOID';
  FBtnMainCaption[29] := 'ICM'    + #13#10 + '(ACK)';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateIdentcChangeMenu;
begin
  FBtnMainCaption[10] := ' '    + #13#10 + ' ';
  FBtnMainCaption[11] := 'IDENT'  + #13#10 + 'NEUTRL';
  FBtnMainCaption[12] := 'IDENT'  + #13#10 + 'UNKNWN';
  FBtnMainCaption[13] := ' '       + #13#10 + ' ';
  FBtnMainCaption[14] := ' '    + #13#10 + ' ';
  FBtnMainCaption[15] := 'IDENT'    + #13#10 + 'ASS-FR';
  FBtnMainCaption[16] := ' '  + #13#10 + ' ';
  FBtnMainCaption[17] := ' '  + #13#10 + ' ';
  FBtnMainCaption[18] := 'IDENT'       + #13#10 + 'SUSPCT';
  FBtnMainCaption[19] := ' '       + #13#10 + ' ';
  FBtnMainCaption[20] := 'IDENT'       + #13#10 + 'FRIEND';
  FBtnMainCaption[21] := ' '       + #13#10 + ' ';
  FBtnMainCaption[22] := ' '   + #13#10 + ' ';
  FBtnMainCaption[23] := 'IDENT' + #13#10 + 'HOSTIL';
  FBtnMainCaption[24] := ' '   + #13#10 + ' ';
  FBtnMainCaption[25] := ' '   + #13#10 + ' ';
  FBtnMainCaption[26] := 'IDENT'   + #13#10 + 'JOKER';
  FBtnMainCaption[27] := 'IDENT'    + #13#10 + 'FAKER';
  FBtnMainCaption[28] := ' '   + #13#10 + ' ';
  FBtnMainCaption[29] := ' '   + #13#10 + ' ';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateLinkYCntrlMenu;
var i : Integer;
    sender : string;
begin
  FBtnMainCaption[10] := 'START'    + #13#10 + 'EMERG';
  FBtnMainCaption[11] := 'LINK-Y'  + #13#10 + 'ASSIGN';
  FBtnMainCaption[12] := 'START'  + #13#10 + 'F-TELL';
  FBtnMainCaption[13] := 'LINK-Y'       + #13#10 + 'CORREL';
  FBtnMainCaption[14] := 'LINK-Y'    + #13#10 + 'MARKER';
  FBtnMainCaption[15] := 'STOP'    + #13#10 + 'EMERG';
  FBtnMainCaption[16] := 'LINK-Y'  + #13#10 + 'PROHIB';
  FBtnMainCaption[17] := 'STOP'  + #13#10 + 'F-TELL';
  FBtnMainCaption[18] := 'LINK-Y'       + #13#10 + 'DECORR';
  FBtnMainCaption[19] := 'TARGET'       + #13#10 + 'DEST';
  FBtnMainCaption[20] := 'LINK-Y'       + #13#10 + 'H-FIRE';
  FBtnMainCaption[21] := 'LINK-Y'       + #13#10 + 'C-FIRE';
  FBtnMainCaption[22] := 'SALVO'   + #13#10 + 'CLEAR';
  FBtnMainCaption[23] := 'COVER' + #13#10 + ' ';
  FBtnMainCaption[24] := 'HEADS'   + #13#10 + 'UP';
  FBtnMainCaption[25] := 'ENGAGE'   + #13#10 + 'TGT';
  FBtnMainCaption[26] := 'CEASE'   + #13#10 + 'TGT';
  FBtnMainCaption[27] := 'ENGAGE'    + #13#10 + 'SSM';
  FBtnMainCaption[28] := 'ASSIGN'   + #13#10 + 'TGT';
  FBtnMainCaption[29] := 'CHANGE'   + #13#10 + 'ORDER';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';

  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
    GenerateCaptionByMenu(FBtnArray[i].Name);
  end;

end;

procedure TfrmMainPDK.GenerateLirodEngageMenu;
begin
  FBtnMainCaption[10] := 'JOY-TO'    + #13#10 + 'LIROD';
  FBtnMainCaption[11] := ' '  + #13#10 + ' ';
  FBtnMainCaption[12] := ' '  + #13#10 + ' ';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := ' '    + #13#10 + ' ';
  FBtnMainCaption[15] := 'DESIG'    + #13#10 + 'LIROD';
  FBtnMainCaption[16] := 'SRV'  + #13#10 + 'LIROD';
  FBtnMainCaption[17] := 'OTO'  + #13#10 + 'LIROD';
  FBtnMainCaption[18] := 'RANGE'       + #13#10 + 'FAR';
  FBtnMainCaption[19] := ' '       + #13#10 + '';
  FBtnMainCaption[20] := 'BREAK'       + #13#10 + 'LIROD';
  FBtnMainCaption[21] := 'SS'       + #13#10 + 'LIROD';
  FBtnMainCaption[22] := 'AUTO'   + #13#10 + 'TRACK';
  FBtnMainCaption[23] := 'RANGE' + #13#10 + 'NEAR';
  FBtnMainCaption[24] := ' '   + #13#10 + ' ';
  FBtnMainCaption[25] := 'KILL'   + #13#10 + '';
  FBtnMainCaption[26] := 'MISS'   + #13#10 + '';
  FBtnMainCaption[27] := ' '    + #13#10 + ' ';
  FBtnMainCaption[28] := ' '   + #13#10 + '';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateNames;
var
  i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := 'TrainEnv';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
  begin
    FBtnMainNames[i] := IntToStr(i);
  end;
end;

procedure TfrmMainPDK.GenerateTrackAirMenu;
begin
  FBtnMainCaption[10] := 'DIR'    + #13#10 + 'AIR';
  FBtnMainCaption[11] := 'VIS-B'  + #13#10 + 'AIR';
  FBtnMainCaption[12] := 'POINT'  + #13#10 + 'GEN';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := 'IFF'    + #13#10 + 'PLOT';
  FBtnMainCaption[15] := 'RAM'    + #13#10 + 'AIR';
  FBtnMainCaption[16] := 'ESM-B'  + #13#10 + 'AIR';
  FBtnMainCaption[17] := 'POINT'  + #13#10 + 'AIR';
  FBtnMainCaption[18] := ' '       + #13#10 + '';
  FBtnMainCaption[19] := ' '       + #13#10 + '';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'KEEP'   + #13#10 + 'LOST';
  FBtnMainCaption[23] := 'CHANGE' + #13#10 + 'SOURCE';
  FBtnMainCaption[24] := 'WIPE'   + #13#10 + 'SOURCE';
  FBtnMainCaption[25] := 'TAKE'   + #13#10 + 'RAM';
  FBtnMainCaption[26] := 'NEXT'   + #13#10 + 'RAM';
  FBtnMainCaption[27] := 'RE-'    + #13#10 + 'POSIT';
  FBtnMainCaption[28] := 'CORR'   + #13#10 + '';
  FBtnMainCaption[29] := 'WIPE'   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateTrackSubSurfmenu;
begin
  FBtnMainCaption[10] := 'DR'    + #13#10 + 'SUB';
  FBtnMainCaption[11] := 'VIS-B'  + #13#10 + 'SUB';
  FBtnMainCaption[12] := 'POINT'  + #13#10 + 'GEN';
  FBtnMainCaption[13] := ' '       + #13#10 + ' ';
  FBtnMainCaption[14] := ' '    + #13#10 + ' ';
  FBtnMainCaption[15] := 'DATUM'    + #13#10 + '';
  FBtnMainCaption[16] := 'ESM-B'  + #13#10 + 'SUB';
  FBtnMainCaption[17] := 'POINT'  + #13#10 + 'ASW';
  FBtnMainCaption[18] := ' '       + #13#10 + '';
  FBtnMainCaption[19] := ' '       + #13#10 + ' ';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := 'ACO-B'       + #13#10 + 'SUB';
  FBtnMainCaption[22] := 'KEEP'   + #13#10 + 'LOST';
  FBtnMainCaption[23] := 'CHANGE' + #13#10 + 'SOURCE';
  FBtnMainCaption[24] := 'WIPE'   + #13#10 + 'SOURCE';
  FBtnMainCaption[25] := ' '   + #13#10 + ' ';
  FBtnMainCaption[26] := ' '   + #13#10 + ' ';
  FBtnMainCaption[27] := 'RE-'    + #13#10 + 'POSIT';
  FBtnMainCaption[28] := 'CORR'   + #13#10 + '';
  FBtnMainCaption[29] := 'WIPE'   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateTrackSurfMenu;
begin
  FBtnMainCaption[10] := 'DR'    + #13#10 + 'SURF';
  FBtnMainCaption[11] := 'VIS-B'  + #13#10 + 'SURF';
  FBtnMainCaption[12] := 'POINT'  + #13#10 + 'GEN';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := 'MW08'    + #13#10 + 'SURF';
  FBtnMainCaption[15] := 'RAM'    + #13#10 + 'SURF';
  FBtnMainCaption[16] := 'ESM-B'  + #13#10 + 'SURF';
  FBtnMainCaption[17] := 'POINT'  + #13#10 + 'ESMFIX';
  FBtnMainCaption[18] := ' '       + #13#10 + '';
  FBtnMainCaption[19] := 'INIT'       + #13#10 + 'NAVRAD';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'KEEP'   + #13#10 + 'LOST';
  FBtnMainCaption[23] := 'CHANGE' + #13#10 + 'SOURCE';
  FBtnMainCaption[24] := 'WIPE'   + #13#10 + 'SOURCE';
  FBtnMainCaption[25] := 'TAKE'   + #13#10 + 'RAM';
  FBtnMainCaption[26] := 'NEXT'   + #13#10 + 'RAM';
  FBtnMainCaption[27] := 'RE-'    + #13#10 + 'POSIT';
  FBtnMainCaption[28] := 'CORR'   + #13#10 + '';
  FBtnMainCaption[29] := 'WIPE'   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateTrainEnvMenu;
begin
  FBtnMainCaption[10] := 'CREATE'    + #13#10 + 'OBJECT';
  FBtnMainCaption[11] := 'LAUNCH'  + #13#10 + 'WEAPON';
  FBtnMainCaption[12] := 'CC'  + #13#10 + 'OBJECT';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := ' '    + #13#10 + '';
  FBtnMainCaption[15] := 'EDIT'    + #13#10 + 'OBJECT';
  FBtnMainCaption[16] := ' '  + #13#10 + '';
  FBtnMainCaption[17] := ' '  + #13#10 + ' ';
  FBtnMainCaption[18] := ' '       + #13#10 + ' ';
  FBtnMainCaption[19] := ' '       + #13#10 + ' ';
  FBtnMainCaption[20] := 'DELETE'       + #13#10 + 'OBJECT';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := ' '   + #13#10 + ' ';
  FBtnMainCaption[23] := ' ' + #13#10 + ' ';
  FBtnMainCaption[24] := ' '   + #13#10 + '';
  FBtnMainCaption[25] := 'DREQ'   + #13#10 + 'OBJECT';
  FBtnMainCaption[26] := 'DISPL'   + #13#10 + 'OBJECT';
  FBtnMainCaption[27] := 'REPOS'    + #13#10 + 'OBJECT';
  FBtnMainCaption[28] := 'SEARCH'   + #13#10 + 'OBJECT';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateTwsEngageMenu;
begin
  FBtnMainCaption[10] := ' '    + #13#10 + '';
  FBtnMainCaption[11] := ' '  + #13#10 + '';
  FBtnMainCaption[12] := ' '  + #13#10 + '';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := ' '    + #13#10 + '';
  FBtnMainCaption[15] := ' '    + #13#10 + '';
  FBtnMainCaption[16] := ' '  + #13#10 + '';
  FBtnMainCaption[17] := 'DESIG'  + #13#10 + 'TWS-1';
  FBtnMainCaption[18] := 'DESIG'       + #13#10 + 'TWS-2';
  FBtnMainCaption[19] := ' '       + #13#10 + ' ';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'BREAK'   + #13#10 + 'TWS-1';
  FBtnMainCaption[23] := 'BREAK' + #13#10 + 'TWS-2';
  FBtnMainCaption[24] := ' '   + #13#10 + '';
  FBtnMainCaption[25] := ' '   + #13#10 + '';
  FBtnMainCaption[26] := ' '   + #13#10 + '';
  FBtnMainCaption[27] := 'MARK'    + #13#10 + 'SPLASH';
  FBtnMainCaption[28] := 'DELETE'   + #13#10 + 'SPLASH';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GenerateWeaponEngageMenu;
begin
  FBtnMainCaption[10] := 'DESIG'    + #13#10 + 'DECOY'; //icha
  FBtnMainCaption[11] := 'TETRAL'  + #13#10 + 'DESFWD';
  FBtnMainCaption[12] := 'TETRAL'  + #13#10 + 'DESAFT';
  FBtnMainCaption[13] := 'DESIG'       + #13#10 + 'GUN-76';
  FBtnMainCaption[14] := 'DESIG'    + #13#10 + 'A244';
  FBtnMainCaption[15] := 'BREAK'    + #13#10 + 'DECOY';  //ICHA
  FBtnMainCaption[16] := 'TETRAL'  + #13#10 + 'BRKFWD';
  FBtnMainCaption[17] := 'TETRAL'  + #13#10 + 'BRKAFT';
  FBtnMainCaption[18] := 'BREAK'       + #13#10 + 'GUN-76';
  FBtnMainCaption[19] := 'BREAK'       + #13#10 + 'A244';
  FBtnMainCaption[20] := 'DESIG'       + #13#10 + 'EXOCET';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := ' '   + #13#10 + '';
  FBtnMainCaption[23] := ' ' + #13#10 + '';
  FBtnMainCaption[24] := 'DESIG'   + #13#10 + 'ECM';
  FBtnMainCaption[25] := 'BREAK'   + #13#10 + 'EXOCET';
  FBtnMainCaption[26] := 'STOP'   + #13#10 + 'EXO-F1';
  FBtnMainCaption[27] := 'MARK'    + #13#10 + 'SPLASH';
  FBtnMainCaption[28] := 'DELETE'   + #13#10 + 'SPLASH';
  FBtnMainCaption[29] := 'BREAK'   + #13#10 + 'ECM';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmMainPDK.GssCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    GssGenMenu;
  end;
  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.GssGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := ' '  + #13#10 + ' ';
  FBtnMainCaption[2] := ' '  + #13#10 + ' ';
  FBtnMainCaption[3] := ' '  + #13#10 + ' ';
  FBtnMainCaption[4] := ' ' + #13#10 + ' ';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := ' '  + #13#10 + ' ';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := ' ' + #13#10 + ' ';
  FBtnMainCaption[9] := ' '  + #13#10 + ' ';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.GssGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := ' ';
  FBtnMainNames[2] := ' ';
  FBtnMainNames[3] := ' ';
  FBtnMainNames[4] := ' ';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := ' ';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := ' ';
  FBtnMainNames[9] := ' ';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.GssGenMenu;
begin

end;

procedure TfrmMainPDK.ApcIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.InitButtons;
var
  i, j,k : Integer;
  aTopInc : Integer;
begin
  GenerateCaption;
  GenerateNames;
  aTopInc := 0;
  j := 0;
  k := 0;

  for I := 0 to Length(FBtnArray) - 1 do
  begin
    btn             := TSpeedButtonImage.Create(nil);
    btn.Parent      := self;
    btn.Width       := Btn_Width;
    btn.Height      := Btn_Height;
    btn.Color       := clBlack;
    btn.Font.Color  := clYellow;
    btn.Font.Size   := FFont_Btn;
    btn.Name        := 'btn' + FBtnMainNames[i];
    btn.Caption     := FBtnMainCaption[i];
    btn.OnClick     := btnPdkClick;
    btn.Tag         := i;
    btn.Left        := Btn_Separator + k * (Btn_Width + Btn_Separator);
    btn.Top         := Btn_Separator + aTopInc;
    FBtnArray[i]    := btn;
    k := k + 1;

    if ((i + 1)mod 5) = 0 then begin
      j := j + 1;
      aTopInc := {Btn_Separator} + j * (Btn_Height + Btn_Separator);
      k := 0;
    end;
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

{ Network Handler }
procedure TfrmMainPDK.OnTimerConnectOnTime(const dt : Double);
begin
  if Assigned(FSocketTCPClient) then
  begin
    if (FSocketTCPClient.State <> wsConnecting) and (FSocketTCPClient.State <> wsConnected) then
    begin
      FSocketTCPClient.Port := FPortConnect;
      FSocketTCPClient.Addr := FipConnect;
      FSocketTCPClient.LineMode := True;
      FSocketTCPClient.LineEdit := True;
      FSocketTCPClient.LineEnd  := #13#10;
      FSocketTCPClient.OnSessionClosed := SocketClientSessionClosed;
      FSocketTCPClient.OnDataAvailable := SocketClientDataAvailable;
      FSocketTCPClient.Connect;
    end;

    if FSocketTCPClient.State = wsConnected then
    begin
      FTimerConnect.Enabled := false;
      addToLog('Network Connected');
    end;
  end;
end;

procedure TfrmMainPDK.PcCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    PcGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    PcTrackAirMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    PcTrackSurfMenu;
  end
  else if aMenu = 'TrackSubsurf' then begin
    PcTrackSubSrfMenu;
  end
  else if aMenu = 'LinkYCntrl' then begin
    PcLinkYCntrlMenu;
  end
  else if aMenu = 'IdentChange' then begin
    PcIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

end;

procedure TfrmMainPDK.PcGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := ' '  + #13#10 + ' ';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := ' ' + #13#10 + ' ';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.PcGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := ' ';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := ' ';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.PcGenMenu;
begin
  FBtnArray[10].Enabled := False;

  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;
end;

procedure TfrmMainPDK.PcIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.PcLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
//    PcCaptionByMenu(FBtnArray[i].Name);
  end;
end;

procedure TfrmMainPDK.PcTrackAirMenu;
begin

end;

procedure TfrmMainPDK.PcTrackSubSrfMenu;
begin

end;

procedure TfrmMainPDK.PcTrackSurfMenu;
begin
  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;
end;

procedure TfrmMainPDK.ProcessCommand(Cmd: String);
begin
  { Here you should write your command interpreter.                       }
  { For simplicity, we just display received command !                    }
  { First remove EndOfLine marker                                         }
  if (Length(Cmd) >= Length(FSocketTCPClient.LineEnd)) and
     (Copy(Cmd, Length(Cmd) - Length(FSocketTCPClient.LineEnd) + 1,
           Length(FSocketTCPClient.LineEnd)) = String(FSocketTCPClient.LineEnd)) then
      Cmd := Copy(Cmd, 1, Length(Cmd) - Length(FSocketTCPClient.LineEnd));
  { Then display in memo                                                  }
  SetRole(Cmd);
end;

procedure TfrmMainPDK.PwoCaptionByMenu(aMenu: string);
var i : Integer;
begin
  if aMenu = 'Gen' then begin
    PwoGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    PwoTrackAirMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    PwoTrackSurfMenu
  end
  else if aMenu = 'TrackSubsurf' then begin
    PwoTrackSubSrfMenu
  end
  else if aMenu = 'LinkYCntrl' then begin
    PwoLinkYCntrlMenu;
  end
  else if aMenu = 'LirodEngage' then begin
    PwoLirodEngageMenu;
  end
  else if aMenu = 'TwsEngage' then begin
    PwoTwsEngageMenu
  end
  else if aMenu = 'WeaponEngage' then begin
    PwoWeaponEngageMenu
  end
  else if aMenu = 'IdentChange' then begin
    PwoIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.PwoGenerateCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.PwoGenerateNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.PwoGenMenu;
begin
  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;
end;

procedure TfrmMainPDK.PwoIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.PwoLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray)-6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
//    PwoCaptionByMenu(FBtnArray[i].Name);
  end;
end;

procedure TfrmMainPDK.PwoLirodEngageMenu;
begin

end;

procedure TfrmMainPDK.PwoTrackAirMenu;
begin

end;

procedure TfrmMainPDK.PwoTrackSubSrfMenu;
begin

end;

procedure TfrmMainPDK.PwoTrackSurfMenu;
begin

end;

procedure TfrmMainPDK.PwoTwsEngageMenu;
begin

end;

procedure TfrmMainPDK.PwoWeaponEngageMenu;
begin

end;

procedure TfrmMainPDK.SendToServerPDK(str: string);
begin
  if Assigned(FSocketTCPClient) then
  begin
    if FSocketTCPClient.State = wsConnected then
    begin
      FSocketTCPClient.SendLine(str + #13#10);
    end;
  end;
end;

procedure TfrmMainPDK.SetRole(Msg: String);
var i : Integer;
begin
  if Msg = CONST_RT_NOROLE then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_NOROLE');
  end
  else
  if Msg = CONST_RT_SSW then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_SSW');
    SswMode := True;
    SswGenerateCaption;
    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        SswGenerateCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_SPC then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_SPC');
    SpcMode := True;
    SpcGenerateCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        SpcCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_AAW then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_AAW');
    AawMode := True;
    AawGenerateCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        AawCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_APC then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_APC');
    ApcMode := True;
    ApcGeneralCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        ApcCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_TRAIN then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_TRAIN');
    TrainMode := True;
    TrainGeneralCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        TrainCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_GSS then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_GSS');
    GssMode := True;
    GssGenerateCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        GssCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if (Msg = CONST_RT_PWO) or (Msg = CONST_RT_EWOP) then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_PWO');
    PwoMode := True;
    PwoGenerateCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        PwoCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_PC then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_PC');
    PcMode := True;
    PcGenerateCaption;
    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        PcCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_ASW then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_ASW');
    AswMode := True;
    AswGenerateCaption;

    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        AswCaptionByMenu(FBtnArray[i].Name);
      end;
    end;
  end
  else
  if Msg = CONST_RT_AWW then
  begin
    FalseRole;
    addToLog('Role = CONST_RT_AWW');
    AwwMode := True;
    AwwGenerateCaption;
    for I := 0 to Length(FBtnArray) - 1 do
    begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Caption := FBtnMainCaption[i];
        FBtnArray[i].Name := FBtnMainNames[i];
        AwwCaptionByMenu(FBtnArray[i].Name);
      end;;
    end;
  end
end;

procedure TfrmMainPDK.SocketClientSessionClosed(Sender: TObject; ErrCode: Word);
begin
  FTimerConnect.Enabled := true;
end;


procedure TfrmMainPDK.SpcCaptionByMenu(amenu: string);
var
  i : integer;
begin
  if aMenu = 'Gen' then begin
    SpcGenMenu;
  end
  else if amenu = 'TrackSurf' then begin
    SpcTrackSurfMenu;
  end
  else if amenu = 'TrackSubSrf' then begin
    SpcTrackSubSurfMenu;
  end
  else if amenu = 'IdentChange' then begin
     SpcIdentChangeMenu
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.SpcGenerateCaption;
var
  i  : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := ' '  + #13#10 + ' ';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := ' ' + #13#10 + ' ';
  FBtnMainCaption[5] := ' '  + #13#10 + ' ';
  FBtnMainCaption[6] := ' '  + #13#10 + ' ';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := ' ' + #13#10 + ' ';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.SpcGenerateNames;
var
  i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := ' ';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := ' ';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := ' ';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := ' ';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);

end;

procedure TfrmMainPDK.SpcGenMenu;
begin
  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;
end;

procedure TfrmMainPDK.SpcIdentChangeMenu;
begin
//  GenerateIdentcChangeMenu;
end;

procedure TfrmMainPDK.SpcTrackSubSurfMenu;
begin
//  GenerateTrackSubSurfmenu;
end;

procedure TfrmMainPDK.SpcTrackSurfMenu;
begin
//  GenerateTrackSurfMenu;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;
end;

procedure TfrmMainPDK.SswGenerateCaption;
var
  i  : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := ' ';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := ' ';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.SswGenerateCaptionByMenu(aMenu: string);
VAR i : Integer;
begin
  if aMenu = 'Gen' then begin
    SswGenerateGenMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    SswGenerateTrackSurfMenu;
  end
  else if aMenu = 'TrackSubSrf' then begin
     SswGenerateTrackSubSrfMenu;
  end
  else if aMenu = 'TrackLinkYCntrl' then begin
    SswGenerateLinkYCntrlMenu;
  end
   else if aMenu = 'LirodEngage' then begin
    SswGenerateLirodEngageMenu;
  end
  else if aMenu = 'TwsEngage' then begin
    SswGenerateTwsEngageMenu;
  end
  else if aMenu = 'WeaponEngage' then begin
    SswGenerateWeaponEngageMenu;
  end
  else if aMenu = 'IdentChange' then begin
    SswGenerateIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
//      FBtnArray[i].Caption := FBtnMainCaption[i]; //test
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.SswGenerateGenMenu;
var i : Integer;
begin

//  FBtnArray[6].Enabled := False;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;
end;

procedure TfrmMainPDK.SswGenerateIdentChangeMenu;
begin

end;

procedure TfrmMainPDK.SswGenerateLinkYCntrlMenu;
var i : Integer;
begin
  for i := 10 to Length(FBtnArray) - 6 do
  begin
    FBtnArray[i].Enabled := False;
    FBtnArray[i].Font.Color := clGray;
  end;
end;

procedure TfrmMainPDK.SswGenerateLirodEngageMenu;
begin
//  FBtnArray[25].Enabled := False;
//  FBtnArray[25].Font.Color := clGray;
//
//  FBtnArray[26].Enabled := False;
//  FBtnArray[26].Font.Color := clGray;
end;

procedure TfrmMainPDK.SswGenerateNames;
var
  i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := ' ';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := ' ';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.SswGenerateTrackSubSrfMenu;
begin
  GenerateTrackSubSurfmenu;
end;

procedure TfrmMainPDK.SswGenerateTrackSurfMenu;
begin
//  GenerateTrackSurfMenu;

  FBtnArray[13].Enabled := False;

  FBtnArray[18].Enabled := False;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;

  FBtnArray[21].Enabled := False;
end;

procedure TfrmMainPDK.SswGenerateTwsEngageMenu;
begin
// GenerateTwsEngageMenu;
end;


procedure TfrmMainPDK.SswGenerateWeaponEngageMenu;
begin
  FBtnArray[11].Enabled := False;
  FBtnArray[11].Font.Color := clGray;

  GenerateWeaponEngageMenu;
  FBtnArray[12].Enabled := False;
  FBtnArray[12].Font.Color := clGray;

  GenerateWeaponEngageMenu;
  FBtnArray[16].Enabled := False;
  FBtnArray[16].Font.Color := clGray;

  GenerateWeaponEngageMenu;
  FBtnArray[17].Enabled := False;
  FBtnArray[17].Font.Color := clGray;
end;


procedure TfrmMainPDK.TrainCaptionByMenu(aMenu: string);
var i: Integer;
begin
  if aMenu = 'Gen' then begin
    TrainGenMenu;
  end
  else if aMenu = 'TrackAir' then begin
    TrainTrackAirMenu;
  end
  else if aMenu = 'TrackSurf' then begin
    TrainTrackSurfMenu;
  end
  else if aMenu = 'TrackSubSrf' then begin
    TrainTrackSubSrfMenu;
  end
  else if aMenu = 'TrainEnv' then begin
    TrainEnvMenu;
  end
  else if aMenu = 'IdentChange' then begin
    TrainIdentChangeMenu;
  end;

  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

procedure TfrmMainPDK.TrainEnvMenu;
begin
  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.TrainGeneralCaption;
var i : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := ' ' + #13#10 + ' ';
  FBtnMainCaption[5] := 'TRAIN'  + #13#10 + 'ENV';
  FBtnMainCaption[6] := ' '  + #13#10 + ' ';
  FBtnMainCaption[7] := ' '    + #13#10 + ' ';
  FBtnMainCaption[8] := ' ' + #13#10 + ' ';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';

  for I := 10 to Length(FBtnArray)-1 do
  begin
    FBtnMainCaption[i] := ' ';
    FBtnArray[i].Caption := FBtnMainCaption[i];
  end;
end;

procedure TfrmMainPDK.TrainGeneralNames;
var i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := ' ';
  FBtnMainNames[5] := 'TrainEnv';
  FBtnMainNames[6] := ' ';
  FBtnMainNames[7] := ' ';
  FBtnMainNames[8] := ' ';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;

procedure TfrmMainPDK.TrainGenMenu;
begin
  FBtnArray[13].Enabled := False;
  FBtnArray[13].Font.Color := clGray;

  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[15].Enabled := False;
  FBtnArray[15].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[20].Enabled := False;
  FBtnArray[20].Font.Color := clGray;

  FBtnArray[22].Enabled := False;
  FBtnArray[22].Font.Color := clGray;

  FBtnArray[24].Enabled := False;
  FBtnArray[24].Font.Color := clGray;

  FBtnArray[25].Enabled := False;
  FBtnArray[25].Font.Color := clGray;

  FBtnArray[26].Enabled := False;
  FBtnArray[26].Font.Color := clGray;

  FBtnArray[27].Enabled := False;
  FBtnArray[27].Font.Color := clGray;

  FBtnArray[28].Enabled := False;
  FBtnArray[28].Font.Color := clGray;

  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.TrainIdentChangeMenu;
begin
  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.TrainTrackAirMenu;
begin
  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.TrainTrackSubSrfMenu;
begin
  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.TrainTrackSurfMenu;
begin
  FBtnArray[14].Enabled := False;
  FBtnArray[14].Font.Color := clGray;

  FBtnArray[19].Enabled := False;
  FBtnArray[19].Font.Color := clGray;

  FBtnArray[30].Enabled := False;
  FBtnArray[30].Font.Color := clGray;
end;

procedure TfrmMainPDK.WMMoving(var Msg: TWMMoving);
var
  workArea: TRect;
begin

   workArea := Screen.Monitors[FServiceIndex].WorkareaRect;

   with Msg.DragRect^ do
   begin
     if Left < workArea.Left then
       OffsetRect(Msg.DragRect^, workArea.Left - Left, 0) ;

     if Top < workArea.Top then
       OffsetRect(Msg.DragRect^, 0, workArea.Top - Top) ;

     if Right > workArea.Right then
       OffsetRect(Msg.DragRect^, workArea.Right - Right, 0) ;

     if Bottom > workArea.Bottom then
       OffsetRect(Msg.DragRect^, 0, workArea.Bottom - Bottom) ;
   end;

end;

procedure TfrmMainPDK.SocketClientDataAvailable(Sender: TObject;
  ErrCode: Word);
var
  Len : Integer;
begin
  { We use line mode, we will receive a complete line }
  Len := FSocketTCPClient.Receive(@FBuffer, SizeOf(FBuffer) - 1);
  if Len <= 0 then
      Exit;

  FBuffer[Len]       := #0;              { Nul terminate  }
  ProcessCommand(String(FBuffer));       { Pass as string }
end;

end.
