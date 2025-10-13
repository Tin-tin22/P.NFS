unit ufWCCPanelBawah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, SpeedButtonImage, ImgList, ExtCtrls, VrControls,
  VrRotarySwitch, StdCtrls, VrDesign, uLibWCCClassNew, uBaseConstan,
  uLibWCCKu, uTCPDataType, ulibRadar, uBaseDataType, VrWheel, uDetected,
  ufQEK, RzBmpBtn;

type
  TfrmWCCPanelBawah = class(TfrmQEK)
    Panel1: TPanel;
    btnDAMTI: TSpeedButtonImage;
    btnDALIN: TSpeedButtonImage;
    btnDALOG: TSpeedButtonImage;
    btnWMnonMTI: TSpeedButtonImage;
    btnWMMTI: TSpeedButtonImage;
    spbSetRange2: TSpeedButtonImage;
    Label2: TLabel;
    spbSetRange4: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange64: TSpeedButtonImage;
    spbSetRange128: TSpeedButtonImage;
    btnAIR: TSpeedButtonImage;
    btnSURF: TSpeedButtonImage;
    btnEW: TSpeedButtonImage;
    btnBLINDARC: TSpeedButtonImage;
    btnLPDTEST: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnRR: TSpeedButtonImage;
    btnHM: TSpeedButtonImage;
    btnMS: TSpeedButtonImage;
    btnCOURSE: TSpeedButtonImage;
    btnAMPLINFO: TSpeedButtonImage;
    btnLINK: TSpeedButtonImage;
    btnTN: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOFFCent: TSpeedButtonImage;
    btnCENT: TSpeedButtonImage;
    Label25: TLabel;
    VrRotarySwitch3: TVrRotarySwitch;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch5: TVrRotarySwitch;
    VrRotarySwitch6: TVrRotarySwitch;
    VrRotarySwitch7: TVrRotarySwitch;
    VrRotarySwitch8: TVrRotarySwitch;
    VrRotarySwitch9: TVrRotarySwitch;
    Panel2: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    btnRESOBM_LEFT: TSpeedButtonImage;
    btnRANGEMAN: TSpeedButtonImage;
    btnGEN: TSpeedButtonImage;
    btnSTANDOFF: TSpeedButtonImage;
    btnATTCKR: TSpeedButtonImage;
    btnPAT: TSpeedButtonImage;
    btnPDT: TSpeedButtonImage;
    btnLOWFGT: TSpeedButtonImage;
    btnELEVMAN: TSpeedButtonImage;
    btnOATOSTBD: TSpeedButtonImage;
    btnOATOPORT: TSpeedButtonImage;
    btnATO: TSpeedButtonImage;
    btnAFA: TSpeedButtonImage;
    btnSBA: TSpeedButtonImage;
    Bevel25: TBevel;
    Bevel26: TBevel;
    Bevel30: TBevel;
    Label98: TLabel;
    Bevel34: TBevel;
    Label115: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Bevel47: TBevel;
    Bevel48: TBevel;
    Bevel49: TBevel;
    Bevel50: TBevel;
    Bevel51: TBevel;
    Bevel52: TBevel;
    Bevel53: TBevel;
    Bevel46: TBevel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    lmpHORSCAN: TImage;
    lmpREADY: TImage;
    lmpJAM: TImage;
    Timer1: TTimer;
    wBearing: TVrWheel;
    Label31: TLabel;
    elevTimer: TTimer;
    Image4: TImage;
    pnl1: TPanel;
    edtX: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtY: TEdit;
    lbl3: TLabel;
    edtZ: TEdit;
    mmo1: TMemo;
    img1: TImage;
    edtTOF: TEdit;
    lbl4: TLabel;
    btn1: TButton;
    chkuse: TCheckBox;
    lbl5: TLabel;
    pnlGun3Fire2: TPanel;
    bvl1: TBevel;
    lbl6: TLabel;
    lbl7: TLabel;
    lmpG3ASDFC1: TImage;
    lmpG3INRANGE: TImage;
    lbl8: TLabel;
    btnG3ATTN_A: TSpeedButtonImage;
    btnG3FIRE_A: TSpeedButtonImage;
    shp1: TShape;
    pnl2: TPanel;
    lbl9: TLabel;
    bvl2: TBevel;
    lbl10: TLabel;
    lmpG1ASDFC1: TImage;
    lmpG1INRANGE: TImage;
    lbl11: TLabel;
    btnG1ATTN_A: TSpeedButtonImage;
    btnG1FIRE_A: TSpeedButtonImage;
    shp2: TShape;
    pnl3: TPanel;
    bvl3: TBevel;
    lbl12: TLabel;
    lbl13: TLabel;
    lmpG2ASDFC1: TImage;
    lbl14: TLabel;
    lmpG2INRANGE: TImage;
    btnG2ATTN_A: TSpeedButtonImage;
    shp3: TShape;
    btnG2FIRE_A: TSpeedButtonImage;
    pnl4: TPanel;
    bvl4: TBevel;
    shp5: TShape;
    lmp1: TImage;
    lbl15: TLabel;
    lbl16: TLabel;
    lmp2: TImage;
    lbl17: TLabel;
    btn3: TSpeedButtonImage;
    btnGUN2_FIRE: TSpeedButtonImage;
    lmp3: TImage;
    lmp4: TImage;
    lmp5: TImage;
    lmp6: TImage;
    lmp7: TImage;
    lmp8: TImage;
    lmp9: TImage;
    lmp10: TImage;
    lmp11: TImage;
    lmp12: TImage;
    lmp13: TImage;
    btnclose: TVrBitmapButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRRClick(Sender: TObject);
    procedure btnHMClick(Sender: TObject);
    procedure spbSetRangeClick(Sender: TObject);
    procedure Reset_Scale_Button;
    procedure Reset_Vid_Button;
    procedure VIDEOSELClick(Sender: TObject);
    procedure btnAIRClick(Sender: TObject);
    procedure btnSURFClick(Sender: TObject);
    procedure btnEWClick(Sender: TObject);
    procedure btnBLINDARCClick(Sender: TObject);
    procedure btnLPDTESTClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure btnCOURSEClick(Sender: TObject);
    procedure btnAMPLINFOClick(Sender: TObject);
    procedure btnLINKClick(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure btnOFFCentClick(Sender: TObject);
    procedure btnCENTClick(Sender: TObject);
    procedure btnRESOBM_LEFTClick(Sender: TObject);
    procedure btnRANGEMANClick(Sender: TObject);
    procedure btnELEVMANClick(Sender: TObject);
    procedure btnLOWFGTClick(Sender: TObject);
    procedure btnPDTClick(Sender: TObject);
    procedure btnPATClick(Sender: TObject);
    procedure btnATTCKRClick(Sender: TObject);
    procedure btnSTANDOFFClick(Sender: TObject);
    procedure btnATOClick(Sender: TObject);
    procedure btnAFAClick(Sender: TObject);
    procedure btnSBAClick(Sender: TObject);
    procedure btnGENClick(Sender: TObject);
    procedure btnG1ATTN_AClick(Sender: TObject);
    procedure btnG1FIRE_AClick(Sender: TObject);
    procedure btnG2ATTN_AClick(Sender: TObject);
    procedure btnG2FIRE_AClick(Sender: TObject);
    procedure btnG3ATTN_AClick(Sender: TObject);
    procedure btnG3FIRE_AClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wBearingChange(Sender: TObject);
    procedure wBearingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure elevTimerTimer(Sender: TObject);

    procedure UpdateSpeedBtn;
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnBTKClick(Sender: TObject);
    procedure btnG1FIRE_AMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG1ATTN_AMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG1ATTN_AMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG3ATTN_AMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG2ATTN_AMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG3ATTN_AMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG2ATTN_AMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btncloseClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);

  private
    { Private declarations }
    //OBMLeft_Start: t2DPoint;
    Sw : Boolean;
    // Buat elevation mark control
    LastTurn, ClockWise: boolean;
    lastPos, curPos: integer;
  public
    { Public declarations }
    //WCCInterface: TGenericWCCInterface;
    TGM_COUNTER: Integer;
    FC1_COUNTER: Integer;
    procedure SetOffBtnAndIndikator; override;

  end;

implementation

uses
  ufWCCTengah, ufWCCPanelBawah2,   ufWCCPanelAtas2, uLibTDCClass, uTDCconstan, uLibTDCTracks, uBaseFunction;

var
  TIMER_COUNTER: Integer = 0;
  IsFC1_Lost : Boolean = False;
  IsStartingFC1: Boolean = False;
  IsUpdatingTGMPos: Boolean = False;


{$R *.dfm}

procedure TfrmWCCPanelBawah.UpdateSpeedBtn;
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).ImageIndex := 0;
end;

//**********************************************//
//      FORM EVENTS                             //
//**********************************************//
procedure TfrmWCCPanelBawah.FormCreate(Sender: TObject);
begin
  inherited;

  // setRange
  spbSetRange2.Tag    := 2;
  spbSetRange4.Tag    := 4;
  //lblRange4.Tag       := 4;
  spbSetRange8.Tag    := 8;
  //lblRange8.Tag       := 8;
  spbSetRange16.Tag   := 16;
  //lblRange16.Tag      := 16;
  spbSetRange32.Tag   := 32;
  //lblRange32.Tag      := 32;
  spbSetRange64.Tag   := 64;
  //lblRange64.Tag      := 64;
  spbSetRange128.Tag  := 128;
  //lblRange128.Tag     := 128;
end;

//**********************************************//
//      RADAR PANEL                             //
//**********************************************//
procedure TfrmWCCPanelBawah.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
  Range: Double;
begin
  if (ConsoleWCC.PowerON and ConsoleWCC.SystemON) and (ConsoleWCC.Radar.Status = RAD_RADIATE) or (ConsoleWCC.Radar.Status = RAD_STANDBY) then
  begin
    Range := (sender as TComponent).Tag;
    WCCInterface.SetView_RangeScale(Range);

    { TAMPILAN BTN }
    Ob := Sender As TSpeedButtonImage;
    ob.Down := True;
    if Ob.Down then
    begin
      self.Reset_Scale_Button;
      ob.Glyph := BtnC.sgreenBOX_On;
    end;
  end;
end;

procedure TfrmWCCPanelBawah.Reset_Scale_Button;
begin
  spbSetRange2.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange4.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange8.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange16.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange32.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange64.Glyph := BtnC.sgreenBOX_Off;
  spbSetRange128.Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah.btnIFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnIFF, sgreenBOX);
  end;
end;

procedure TfrmWCCPanelBawah.btnRRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnRR, sgreenBOX);
    WCCInterface.SetRadar_RangeRing(btnRR.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnHMClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnHM, sgreenBOX);
    WCCInterface.SetRadar_HeadingMarker(btnHM.Down);
  end;
end;

procedure TfrmWCCPanelBawah.VIDEOSELClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
  lbl: TLabel;
  tagg: byte;
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    if Sender.ClassType = TSpeedButtonImage then begin
      Ob := Sender As TSpeedButtonImage;
      tagg := ob.Tag;
    end
    else begin
      lbl := Sender as TLabel;
      tagg := lbl.Tag;
    end;

    if (ConsoleWCC.Radar.FreqType = FREQ_AGIL) and (tagg = 5) then exit;

    self.Reset_Vid_Button;
    case tagg of
    1: begin
        btnDAMTI.Down := True;
        btnDAMTI.Glyph := BtnC.sgreenBOX_On;
        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(TRUE);
      end;
    2: begin
        btnDALIN.Down := True;
        btnDALIN.Glyph := BtnC.sgreenBOX_On;
        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
        self.WCCInterface.SetRadar_Amplification(raLiner);
      end;
    3: begin
        btnDALOG.Down := True;
        btnDALOG.Glyph := BtnC.sgreenBOX_On;
        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
        self.WCCInterface.SetRadar_Amplification(raLogarithmic);
      end;
    4: begin
        btnWMnonMTI.Down := True;
        btnWMnonMTI.Glyph := BtnC.sgreenBOX_On;
        self.WCCInterface.SetRadar_type(rtWM_28);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
      end;
    5: begin
        btnWMMTI.Down := True;
        btnWMMTI.Glyph := BtnC.sgreenBOX_On;
        self.WCCInterface.SetRadar_type(rtWM_28);
        self.WCCInterface.SetRadar_MTI_Status(TRUE);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah.Reset_Vid_Button;
begin
  btnDAMTI.Glyph := BtnC.sgreenBOX_Off;
  btnDALIN.Glyph := BtnC.sgreenBOX_Off;
  btnDALOG.Glyph := BtnC.sgreenBOX_Off;
  btnWMnonMTI.Glyph := BtnC.sgreenBOX_Off;
  btnWMMTI.Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah.SetOffBtnAndIndikator;
begin
  inherited;

end;

procedure TfrmWCCPanelBawah.btnAIRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnAIR, sgreenBOX);
    self.WCCInterface.Filter(tdUdara,  btnAir.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnSURFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSURF, sgreenBOX);
    self.WCCInterface.Filter(tdAtasAir,  btnSURF.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnEWClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnEW, sgreenBOX);
    self.WCCInterface.Filter(tdEW,  btnEW.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnBLINDARCClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnBLINDARC, sgreenBOX);
    self.WCCInterface.SetBlindArc(btnBLINDARC.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnLPDTESTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnLPDTEST, sorangeBOX);
    self.WCCInterface.SetLPDTest(btnLPDTEST.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnMSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnMS, sgreenBOX);
    self.WCCInterface.SetMainSymbolVisible(self.btnMS.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnCOURSEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnCOURSE, sgreenBOX);
    self.WCCInterface.SetCourseVisible(self.btnCOURSE.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnAMPLINFOClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnAMPLINFO, sgreenBOX);
    self.WCCInterface.SetAMPLInfoVisible(self.btnAMPLINFO.Down);
  end;
end;

procedure TfrmWCCPanelBawah.btnLINKClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnLINK, sgreenBOX);
  end;
end;

procedure TfrmWCCPanelBawah.btnTNClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnTN, sgreenBOX);
    self.WCCInterface.SetTrackNumberVisible(self.btnTN.Down);
  end;

end;

procedure TfrmWCCPanelBawah.btnTMClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnTM, sorangeBOX);
    self.WCCInterface.TrueMotion := btnTM.Down;

  end;
end;

procedure TfrmWCCPanelBawah.btnOFFCentClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    WCCInterface.CentLeft_SetStatus(stOFFCENT);
    BtnC.UpdateButton(btnOFFCent, TBLock, sOrangeBOX, True);
    BtnC.UpdateButton(btnCent, TBLock, sGreenBOX, False);
  end;
end;

procedure TfrmWCCPanelBawah.btnCENTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    WCCInterface.CentRight_SetStatus(stCENT);
    BtnC.UpdateButton(btnOFFCent, TBLock, sOrangeBOX, False);
    BtnC.UpdateButton(btnCent, TBLock, sGreenBOX, True);
  end;
end;

procedure TfrmWCCPanelBawah.btncloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

//**********************************************//
//      AIR FIRE CONTROL PANEL                  //
//**********************************************//

procedure TfrmWCCPanelBawah.btnRESOBM_LEFTClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnRESOBM_LEFT);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    self.WCCInterface.OBMLeft_Reset;
  end;
end;

procedure TfrmWCCPanelBawah.btnRANGEMANClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnRANGEMAN);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmWCCPanelBawah.btnELEVMANClick(Sender: TObject);
begin
  //BtnC.SpringLoaded(btnELEVMAN);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    ConsoleWCC.Radar.IsElevating := btnELEVMAN.Down;
    BtnC.UpdateLockBtnImage(btnELEVMAN, sOrangeBOX);
    elevTimer.Enabled := false;
  end;
end;

procedure TfrmWCCPanelBawah.btnLOWFGTClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnLOWFGT);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmWCCPanelBawah.btnPDTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
      btnPAT.Glyph := BtnC.sgreenBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmWCCPanelBawah.btnPATClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
      btnPDT.Glyph := BtnC.sgreenBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmWCCPanelBawah.btnATTCKRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.sorangeBOX_On;
      btnSTANDOFF.Glyph := BtnC.sorangeBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmWCCPanelBawah.btnSTANDOFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.sorangeBOX_On;
      btnATTCKR.Glyph := BtnC.sorangeBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmWCCPanelBawah.btnATOClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.SetAssign_FC(1, WCCInterface.OBMLeft.Center);
    BtnC.UpdateButton(btnATO, TBSpring, sGreenBOX, True);
    BtnC.UpdateButton(btnAFA, TBSpring, sGreenBOX, True);
    BtnC.UpdateButton(btnSBA, TBSpring, sGreenBOX, False);

    ConsoleWCC.Radar.IsElevating := True;
    elevTimer.Enabled := True;
    IsUpdatingTGMPos := True;
    IsStartingFC1 := true;
    WCCInterface.TGM_Marker.Visible := True;
    WCCInterface.TGM_Reset;
    WCCInterface.ShowAScope(atoLockOn);

    {LOG}
      WCCInterface.SendEvenWCC_120mm(11);
  end;
end;

procedure TfrmWCCPanelBawah.btn1Click(Sender: TObject);
begin
  inherited;
  if Assigned(WCCInterface.ActiveFC) then begin
    edtX.Text := FormatFloat('0.0000000000000000000000000',WCCInterface.ActiveFC.TrackedTarget.PositionX);
    edtY.Text := FormatFloat('0.0000000000000000000000000',WCCInterface.ActiveFC.TrackedTarget.PositionY);
    edtZ.Text := FormatFloat('0.0000000000000000000000000',WCCInterface.ActiveFC.TrackedTarget.PositionZ);
  end;

end;

procedure TfrmWCCPanelBawah.btn2Click(Sender: TObject);
begin
  inherited;
  WCCInterface.frmTengah.Left         := -350;
  WCCInterface.frmWCCBawah1.Visible   := False;
  WCCInterface.frmWCCBawah2.formstyle := fsStayOnTop;
  WCCInterface.frmWCCBawah2.Visible   := True;

end;

procedure TfrmWCCPanelBawah.btnBTKClick(Sender: TObject);
begin
  inherited;
  //chkuse.Checked:= btnBTK.Down;
end;

procedure TfrmWCCPanelBawah.btnAFAClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnAFA);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    
  end;
end;

procedure TfrmWCCPanelBawah.btnSBAClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(1) then exit;
    if WCCInterface.SetDeAssign_FC(1) then begin
      BtnC.UpdateButton(btnSBA, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnAFA, TBSpring, sGreenBOX, False);
      BtnC.UpdateImage(lmpREADY, BtnC.sgreenROUND_Off);
  //  WCCInterface.ShowAScope(atoBreak);
      IsFC1_Lost := True;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(12);
    end;
  end;
end;

procedure TfrmWCCPanelBawah.btnGENClick(Sender: TObject);
begin
  BtnC.UpdateLockBtnImage(btnGEN, sorangeBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmWCCPanelBawah.btnG1ATTN_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnG1ATTN_A);
    Beep;
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmWCCPanelBawah.btnG1ATTN_AMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if WCCInterface.Gun1.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah.btnG1ATTN_AMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  btnG1ATTN_A.Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah.btnG1FIRE_AClick(Sender: TObject);
var OwnShip : Integer;
pnt : tDouble2DPoint;
begin
//  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if TSpeedButtonImage(Sender).Down then
    WCCInterface.StartCannonFire(TSpeedButtonImage(Sender).Tag)
  else
   WCCInterface.StopCannonFire(TSpeedButtonImage(Sender).Tag);

   if TSpeedButtonImage(Sender).Tag = 1 then
    if not TfrmWCCPanelAtas2(WCCInterface.frmWCCAtas2).btnG1AUTO.Down then
      TSpeedButtonImage(Sender).Down := False;
end;

procedure TfrmWCCPanelBawah.btnG1FIRE_AMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   WCCInterface.StopCannonFire(1);
end;

procedure TfrmWCCPanelBawah.btnG2ATTN_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnG2ATTN_A);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
  end;
end;

procedure TfrmWCCPanelBawah.btnG2ATTN_AMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if WCCInterface.Gun2.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah.btnG2ATTN_AMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah.btnG2FIRE_AClick(Sender: TObject);
var OwnShip : Integer;
//pnt : tDouble2DPoint;
begin

end;

procedure TfrmWCCPanelBawah.btnG3ATTN_AClick(Sender: TObject);
begin
 BtnC.SpringLoaded(btnG2ATTN_A);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmWCCPanelBawah.btnG3ATTN_AMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if WCCInterface.Gun3.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah.btnG3ATTN_AMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah.btnG3FIRE_AClick(Sender: TObject);
var OwnShip : Integer;
pnt : tDouble2DPoint;
begin

end;

procedure TfrmWCCPanelBawah.Timer1Timer(Sender: TObject);
begin
  If IsFC1_Lost then Inc(FC1_COUNTER, 1);
  if IsFC1_Lost then begin
    if (FC1_COUNTER = C_FC_READY_TIME - 2) then begin
      WCCInterface.ShowAScope(AtoLost2);
    end;

    if (FC1_COUNTER = C_FC_READY_TIME - 1) then begin
      WCCInterface.ShowAScope(AtoGone);
      IsFC1_Lost := False;
      FC1_COUNTER:= 0;
    end;
  end;

  If IsStartingFC1 then Inc(FC1_COUNTER, 1);

  if IsUpdatingTGMPos and IsStartingFC1 then begin
    Inc(TGM_COUNTER, 1);
    if (TGM_COUNTER = C_FC_READY_TIME - 3) then begin
      ConsoleWCC.Radar.IsElevating := False;
      elevTimer.Enabled := False;
      WCCInterface.TGM_SetPosition(WCCInterface.OBMLeft.Center.X, WCCInterface.OBMLeft.Center.Y);
      WCCInterface.ShowAScope(atoAuto1);
    end;
    if (TGM_COUNTER = C_FC_READY_TIME - 2) then begin
      WCCInterface.ShowAScope(atoAuto2);
    end;
    if (TGM_COUNTER = C_FC_READY_TIME - 1) then begin
      TGM_COUNTER := 0;
      IsUpdatingTGMPos := False;
      WCCInterface.ShowAScope(atoReady);
      WCCInterface.TGM_Marker.Visible := False;
    end;
  end;
  If (FC1_COUNTER = C_FC_READY_TIME) and IsStartingFC1 then
  begin
     FC1_COUNTER := 0;
    IsStartingFC1 := False;

    BtnC.UpdateButton(btnAFA, TBSpring, sGreenBOX, False);
    if WCCInterface.IsFireControlInUse(1) then begin
      BtnC.UpdateImage(self.lmpREADY, BtnC.sgreenROUND_On);
      BtnC.UpdateButton(btnATO, TBSpring, sGreenBOX, False);
    end
    else begin
      BtnC.UpdateButton(btnSBA, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnATO, TBSpring, sGreenBOX, False);
      WCCInterface.ShowAScope(AtoLost1);
      IsFC1_Lost := True;
    end;
  end;

  // Lampu Indikator senjata
  {if (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1') and WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.IsBlind = false) then
    BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_Off);

  if (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1') and WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.IsBlind = false) then
    BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_Off);

  if (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name = 'FC1') and WCCInterface.Gun3.IsInRange and (WCCInterface.Gun3.IsBlind = false) then
    BtnC.UpdateImage(lmpG3INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG3INRANGE, BtnC.greenROUND_Off);
  }

  BtnC.UpdateImage(lmpG1INRANGE, sGreenROUND, WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1'));
  BtnC.UpdateImage(lmpG2INRANGE, sGreenROUND, WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1'));
  BtnC.UpdateImage(lmpG3INRANGE, sGreenROUND, WCCInterface.Gun3.IsInRange and (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name = 'FC1'));

  BtnC.UpdateBtnImage(btnG1FIRE_A, sGreenBOX, WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1'));
  BtnC.UpdateBtnImage(btnG2FIRE_A, sGreenBOX, WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1'));
  BtnC.UpdateBtnImage(btnG3FIRE_A, sGreenBOX, WCCInterface.Gun3.ReadyToFire and (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name = 'FC1'));

  BtnC.UpdateBtnImage(btnGUN2_FIRE,sGreenBOX, WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1'));
end;

procedure TfrmWCCPanelBawah.elevTimerTimer(Sender: TObject);
begin
//  wBearing.Position := wBearing.Position + 1;
  wBearingChange(nil);
end;

procedure TfrmWCCPanelBawah.FormShow(Sender: TObject);
begin
  self.Timer1.Enabled := True;
end;

procedure TfrmWCCPanelBawah.Panel1DblClick(Sender: TObject);
begin
  inherited;
  Sw := not Sw;
  btnclose.Visible := Sw;
end;

procedure TfrmWCCPanelBawah.Panel2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
 if ssShift in Shift then
    pnl1.Visible  := true
 else
    pnl1.Visible  := False;
end;

procedure TfrmWCCPanelBawah.wBearingChange(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and ConsoleWCC.Radar.IsElevating then begin
    if (wBearing.Position <> curPos) then begin
      lastPos := curPos;
      curPos := wBearing.Position;
      if ((curPos >= 0) and (curPos < 10)) and ((lastPos > 350) and (lastPos < 360)) then
        ClockWise := true
      else if ((lastPos >= 0) and (lastPos < 10)) and ((curPos > 350) and (curPos < 360)) then
        ClockWise := false
      else ClockWise := lastPos < curPos;

      if LastTurn <> ClockWise then begin
        LastTurn := ClockWise;
        WCCInterface.EMarkFlag := not WCCInterface.EMarkFlag;
      end;
      WCCInterface.SetEmarkHeading;
    end;
  end;
end;

procedure TfrmWCCPanelBawah.wBearingMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then curPos := wBearing.Position;
end;

end.
