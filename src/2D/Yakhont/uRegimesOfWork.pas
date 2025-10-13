unit uRegimesOfWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus;

type
  TfmMain = class(TForm)
    pnlMain: TPanel;
    grpRegimesOfWork: TGroupBox;
    Label1: TLabel;
    grpMenuOfRegimes: TGroupBox;
    btnMM: TSpeedButton;
    btnER: TSpeedButton;
    btnSC: TSpeedButton;
    btnCT: TSpeedButton;
    btnHeating: TSpeedButton;
    btnCD: TSpeedButton;
    btnOC: TSpeedButton;
    btnExit: TSpeedButton;
    PopupMenuCT: TPopupMenu;
    CT1: TMenuItem;
    CT2: TMenuItem;
    imgIntroScreen: TImage;
    Edit1: TEdit;
    imgPrinter: TImage;
    imgEthernet: TImage;
    imgMainNode1: TImage;
    imgLauncher4: TImage;
    imgLauncher2: TImage;
    Image4: TImage;
    imgMainNode2: TImage;
    imgLauncher1: TImage;
    imgLauncher3: TImage;
    btnClose: TSpeedButton;
    procedure btnCTClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CT2Click(Sender: TObject);
    procedure CT1Click(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnMMClick(Sender: TObject);
    procedure btnERClick(Sender: TObject);
    procedure btnSCClick(Sender: TObject);
    procedure btnHeatingClick(Sender: TObject);
    procedure btnCDClick(Sender: TObject);
    procedure btnOCClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnlMainDblClick(Sender: TObject);
  private
    { Private declarations }
    switchClose : Boolean;
  public
    { Public declarations }
    MainMode : Integer;

    _statePrinter,
    _stateKR231, checkKR231,
    _stateLauncher1, checkLauncher1,
    _stateLauncher2, checklauncher2,
    _stateLauncher3, checkLauncher3,
    _stateLauncher4,  checklauncher4 : Boolean;
    missileLoaded1, missileLoaded2, missileLoaded3, missileLoaded4 : Boolean;

  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
   uMainMM, uCertificateData, uYakhontManager, uTCPDatatype, uBlankScreen,
  uYakhont_A_1_MainForm, uYakhont_A_2_MainForm, uEventForm, uHeating, uNetral, uEmergencyRelease;

procedure TfmMain.btnMMClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(3, 0, 0, 0);
  MainMode := 1;
  EventForm.eventBtnMMClick;
end;

procedure TfmMain.btnERClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(4, 0, 0, 0);
  MainMode := 2;
  EventForm.eventBtnEROnClick;
end;

procedure TfmMain.btnSCClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(5, 0, 0, 0);
  MainMode := 3;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfmMain.btnCTClick(Sender: TObject);
begin
  MainMode := 4;
  PopupMenuCT.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfmMain.CT1Click(Sender: TObject);
begin
  with fmMainMM do
  begin
     CTType := 1;
     StartTime := now;
     timerStart.Enabled := True;
     ShowModal;
  end;
end;

procedure TfmMain.CT2Click(Sender: TObject);
begin
  with fmMainMM do
  begin
     CTType := 2;
     StartTime := now;
     timerStart.Enabled := True;
     ShowModal;
  end;
end;

procedure TfmMain.btnHeatingClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(6, 0, 0, 0);
  MainMode := 5;
  EventForm.eventBtnHeatingClick;

end;

procedure TfmMain.btnCDClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(7, 0, 0, 0);
  MainMode := 6;
  frmCertificateData.ShowModal;
end;

procedure TfmMain.btnOCClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(8, 0, 0, 0);
  MainMode := 7;
end;

procedure TfmMain.btnExitClick(Sender: TObject);
//var
//  rec: TRecCMD_Yakhont;
begin
//  YakhontManager.EventOnSendingLog(45, 0, 0, 0);
//  rec.cmd := CMD_Yakhont_Terminate;
//  YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @rec, nil);
//  Application.Terminate;

  with frmYakh_A_1_MainForm do
  begin
    isEnabled  := True;
    isChecked  := True;
    _state300v := false;

    btnOn.ImageIndex := 1;

    imgOnKR231.Picture.LoadFromFile(fIndikatorOff);
    timerA.Enabled := false;
  end;

  with frmYakh_A_2_MainForm do
  begin
    isSACS := false;
    _state27v := False;

    btnSACS.ImageIndex := 0;

  end;

  YakhontManager.SetLayOutForm;
  frmBlankScreen.Show;
  Close;
end;

procedure TfmMain.FormShow(Sender: TObject);
var
  picture_Path : String;
  fIndikatorOn, fIndikatorOff, fIndikatorFault : String;
  fCentang, fSilang : string;
begin
  pnlMain.Color   := RGB(15, 69, 69);

  picture_Path    := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
  fIndikatorOn    := picture_Path + 'data\images\yakhont\AB_Indikator_On_SMALL.bmp';
  fIndikatorOff   := picture_Path + 'data\images\yakhont\AB_Indikator_Of_SMALL.bmp';
  fIndikatorFault := picture_Path + 'data\images\yakhont\AB_Indikator_On_SMALL_Merah.bmp';

  fCentang        := picture_Path + 'data\images\yakhont\YakhontCentang.bmp';
  fSilang         := picture_Path + 'data\images\yakhont\YakhontSilang.bmp';

  { printer }
  if _statePrinter then
    imgPrinter.Picture.LoadFromFile(fSilang)
  else
    imgPrinter.Picture.LoadFromFile(fCentang);

  { launcher 1 }
  if _stateLauncher1 then
    imgLauncher1.Picture.LoadFromFile(fSilang)
  else
    imgLauncher1.Picture.LoadFromFile(fCentang);

  { launcher 2 }
  if _stateLauncher2 then
    imgLauncher2.Picture.LoadFromFile(fSilang)
  else
    imgLauncher2.Picture.LoadFromFile(fCentang);

  { launcher 3 }
  if _stateLauncher3 then
    imgLauncher3.Picture.LoadFromFile(fSilang)
  else
    imgLauncher3.Picture.LoadFromFile(fCentang);

  { launcher 4 }
  if _stateLauncher4 then
    imgLauncher4.Picture.LoadFromFile(fSilang)
  else
    imgLauncher4.Picture.LoadFromFile(fCentang);

  { KR231 }
  if _stateKR231 then
  begin
    imgLauncher1.Picture.LoadFromFile(fSilang);
    imgLauncher2.Picture.LoadFromFile(fSilang);
    imgLauncher3.Picture.LoadFromFile(fSilang);
    imgLauncher4.Picture.LoadFromFile(fSilang);
  end;

  with frmEmergencyRelease do
  begin
    EmergencyLaunched_1:=False;
    EmergencyLaunched_2:=False;
    EmergencyLaunched_3:=False;
    EmergencyLaunched_4:=False;

//    checkEmergency_1:=True;
//    checkEmergency_2:=True;
//    checkEmergency_3:=True;
//    checkEmergency_4:=True;
  end;

   //missileLoaded1:=False;
   //missileLoaded2:=False;
   //missileLoaded3:=False;
   //missileLoaded4:=False;

  YakhontManager.Missile1.state   := YakhontManager.Missile1.C_noState;
  YakhontManager.Missile2.state   := YakhontManager.Missile1.C_noState;
  YakhontManager.Missile3.state   := YakhontManager.Missile1.C_noState;
  YakhontManager.Missile4.state   := YakhontManager.Missile1.C_noState;


end;

procedure TfmMain.pnlMainDblClick(Sender: TObject);
begin
  inherited;
  switchClose := not switchClose;
  btnClose.Visible := switchClose;
end;

end.
