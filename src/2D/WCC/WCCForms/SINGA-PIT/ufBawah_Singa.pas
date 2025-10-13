unit ufBawah_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, SpeedButtonImage, ImgList, ExtCtrls, VrControls,
  VrRotarySwitch, StdCtrls, VrDesign, uLibWCCClassNew, uBaseConstan,
  uLibWCCKu, uTCPDataType, ulibRadar, uBaseDataType, VrWheel, uDetected,
  ufQEK;

type
  TfrmBawah_Singa = class(TfrmQEK)
    Timer1: TTimer;
    elevTimer: TTimer;
    Panel1: TPanel;
    lmpHORSCAN: TImage;
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
    btnBLINDARC: TSpeedButtonImage;
    btnLPDTEST: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnRR: TSpeedButtonImage;
    btnHM: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOFFCent: TSpeedButtonImage;
    btnCENT: TSpeedButtonImage;
    Label25: TLabel;
    Label29: TLabel;
    Label30: TLabel;
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
    Label28: TLabel;
    Bevel46: TBevel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch3: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch5: TVrRotarySwitch;
    VrRotarySwitch6: TVrRotarySwitch;
    VrRotarySwitch7: TVrRotarySwitch;
    VrRotarySwitch8: TVrRotarySwitch;
    VrRotarySwitch9: TVrRotarySwitch;
    Panel2: TPanel;
    Bevel26: TBevel;
    Bevel30: TBevel;
    Bevel43: TBevel;
    Shape3: TShape;
    lmpJAM: TImage;
    Bevel35: TBevel;
    Bevel34: TBevel;
    lmpREADY: TImage;
    lmpG1INRANGE: TImage;
    lmpG1ASDFC1: TImage;
    lmpG2INRANGE: TImage;
    lmpG2ASDFC1: TImage;
    Bevel25: TBevel;
    btnRESOBM_LEFT: TSpeedButtonImage;
    btnRANGEMAN: TSpeedButtonImage;
    btnGEN: TSpeedButtonImage;
    btnSTANDOFF: TSpeedButtonImage;
    btnATTCKR: TSpeedButtonImage;
    btnPAT: TSpeedButtonImage;
    btnPDT: TSpeedButtonImage;
    btnLOWFGT: TSpeedButtonImage;
    btnELEVMAN: TSpeedButtonImage;
    btnATO: TSpeedButtonImage;
    btnAFA: TSpeedButtonImage;
    btnSBA: TSpeedButtonImage;
    btnG1ATTN_A: TSpeedButtonImage;
    btnG2ATTN_A: TSpeedButtonImage;
    Shape1: TShape;
    btnG1FIRE_A: TSpeedButtonImage;
    btnG2FIRE_A: TSpeedButtonImage;
    Label98: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label104: TLabel;
    Label113: TLabel;
    Label115: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    wBearing: TVrWheel;
    Label31: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image4: TImage;
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
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wBearingChange(Sender: TObject);
    procedure wBearingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure elevTimerTimer(Sender: TObject);
  private
    { Private declarations }
    //OBMLeft_Start: t2DPoint;

    // Buat elevation mark control
    LastTurn, ClockWise: boolean;
    lastPos, curPos: integer;
  public
    { Public declarations }
    
    TGM_COUNTER: Integer;
    FC1_COUNTER: Integer;
  end;

implementation

uses
  ufWCCTengah, ufBawah2_Singa, uLibTDCClass,uLibTDCTracks, uTDCConstan;

var
  TIMER_COUNTER: Integer = 0;
  IsStartingFC1: Boolean = False;
  IsUpdatingTGMPos: Boolean = False;


{$R *.dfm}

//**********************************************//
//      FORM EVENTS                             //
//**********************************************//
procedure TfrmBawah_Singa.FormCreate(Sender: TObject);
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
procedure TfrmBawah_Singa.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
  Range: Double;
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    Range := (sender as TComponent).Tag;
    WCCInterface.SetView_RangeScale(Range);

    { TAMPILAN BTN }
    Ob := Sender As TSpeedButtonImage;
    ob.Down := True;
    if Ob.Down then
    begin
      self.Reset_Scale_Button;
      ob.Glyph := BtnC.greenBOX_On;
    end;
  end;
end;

procedure TfrmBawah_Singa.Reset_Scale_Button;
begin
  spbSetRange2.Glyph := BtnC.greenBOX_Off;
  spbSetRange4.Glyph := BtnC.greenBOX_Off;
  spbSetRange8.Glyph := BtnC.greenBOX_Off;
  spbSetRange16.Glyph := BtnC.greenBOX_Off;
  spbSetRange32.Glyph := BtnC.greenBOX_Off;
  spbSetRange64.Glyph := BtnC.greenBOX_Off;
  spbSetRange128.Glyph := BtnC.greenBOX_Off;
end;

procedure TfrmBawah_Singa.btnIFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnIFF, greenBOX);
  end;
end;

procedure TfrmBawah_Singa.btnRRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnRR, greenBOX);
    WCCInterface.SetRadar_RangeRing(btnRR.Down);
  end;
end;

procedure TfrmBawah_Singa.btnHMClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnHM, greenBOX);
    WCCInterface.SetRadar_HeadingMarker(btnHM.Down);
  end;
end;

procedure TfrmBawah_Singa.VIDEOSELClick(Sender: TObject);
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
        btnDAMTI.Glyph := BtnC.greenBOX_On;

        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(TRUE);
      end;
    2: begin
        btnDALIN.Down := True;
        btnDALIN.Glyph := BtnC.greenBOX_On;

        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
        self.WCCInterface.SetRadar_Amplification(raLiner);
      end;
    3: begin
        btnDALOG.Down := True;
        btnDALOG.Glyph := BtnC.greenBOX_On;

        self.WCCInterface.SetRadar_type(rtDA_05);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
        self.WCCInterface.SetRadar_Amplification(raLogarithmic);
      end;
    4: begin
        btnWMnonMTI.Down := True;
        btnWMnonMTI.Glyph := BtnC.greenBOX_On;

        self.WCCInterface.SetRadar_type(rtWM_28);
        self.WCCInterface.SetRadar_MTI_Status(FALSE);
      end;
    5: begin
        btnWMMTI.Down := True;
        btnWMMTI.Glyph := BtnC.greenBOX_On;

        self.WCCInterface.SetRadar_type(rtWM_28);
        self.WCCInterface.SetRadar_MTI_Status(TRUE);
      end;
    end;

  end;
end;

procedure TfrmBawah_Singa.Reset_Vid_Button;
begin
  //btnDAMTI.Glyph := BtnC.greenBOX_Off;
  //btnDALIN.Glyph := BtnC.greenBOX_Off;
  //btnDALOG.Glyph := BtnC.greenBOX_Off;
  btnWMnonMTI.Glyph := BtnC.greenBOX_Off;
  btnWMMTI.Glyph := BtnC.greenBOX_Off;
end;

procedure TfrmBawah_Singa.btnAIRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnAIR, greenBOX);
    self.WCCInterface.Filter(tdUdara,  btnAir.Down);
  end;
end;

procedure TfrmBawah_Singa.btnSURFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSURF, greenBOX);
    self.WCCInterface.Filter(tdAtasAir,  btnSURF.Down);
  end;
end;

procedure TfrmBawah_Singa.btnEWClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnEW, greenBOX);
    //self.WCCInterface.Filter(tdEW,  btnEW.Down);
  end;
end;

procedure TfrmBawah_Singa.btnBLINDARCClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnBLINDARC, greenBOX);
    self.WCCInterface.SetBlindArc(btnBLINDARC.Down);
  end;
end;

procedure TfrmBawah_Singa.btnLPDTESTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnLPDTEST, orangeBOX);
    self.WCCInterface.SetLPDTest(btnLPDTEST.Down);
  end;
end;

procedure TfrmBawah_Singa.btnMSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnMS, greenBOX);
    //self.WCCInterface.SetMainSymbolVisible(self.btnMS.Down);
  end;
end;

procedure TfrmBawah_Singa.btnCOURSEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnCOURSE, greenBOX);
    //self.WCCInterface.SetCourseVisible(self.btnCOURSE.Down);
  end;
end;

procedure TfrmBawah_Singa.btnAMPLINFOClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnAMPLINFO, greenBOX);
    //self.WCCInterface.SetAMPLInfoVisible(self.btnAMPLINFO.Down);
  end;
end;

procedure TfrmBawah_Singa.btnLINKClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnLINK, greenBOX);
  end;
end;

procedure TfrmBawah_Singa.btnTNClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    //BtnC.UpdateLockBtnImage(btnTN, greenBOX);
    //self.WCCInterface.SetTrackNumberVisible(self.btnTN.Down);
  end;

end;

procedure TfrmBawah_Singa.btnTMClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    BtnC.UpdateLockBtnImage(btnTM, orangeBOX);
    self.WCCInterface.TrueMotion := btnTM.Down;
  end;
end;

procedure TfrmBawah_Singa.btnOFFCentClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    WCCInterface.CentLeft_SetStatus(stOFFCENT);
    BtnC.UpdateButton(btnOFFCent, TBLock, OrangeBOX, True);
    BtnC.UpdateButton(btnCent, TBLock, GreenBOX, False);
  end;
end;

procedure TfrmBawah_Singa.btnCENTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    WCCInterface.CentRight_SetStatus(stCENT);
    BtnC.UpdateButton(btnOFFCent, TBLock, OrangeBOX, False);
    BtnC.UpdateButton(btnCent, TBLock, GreenBOX, True);
  end;
end;

//**********************************************//
//      AIR FIRE CONTROL PANEL                  //
//**********************************************//

procedure TfrmBawah_Singa.btnRESOBM_LEFTClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnRESOBM_LEFT);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    self.WCCInterface.OBMLeft_Reset;
  end;
end;

procedure TfrmBawah_Singa.btnRANGEMANClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnRANGEMAN);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnELEVMANClick(Sender: TObject);
begin
  //BtnC.SpringLoaded(btnELEVMAN);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    ConsoleWCC.Radar.IsElevating := btnELEVMAN.Down;
    BtnC.UpdateLockBtnImage(btnELEVMAN, OrangeBOX);
    elevTimer.Enabled := false;
  end;
end;

procedure TfrmBawah_Singa.btnLOWFGTClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnLOWFGT);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnPDTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.greenBOX_On;
      btnPAT.Glyph := BtnC.greenBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmBawah_Singa.btnPATClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.greenBOX_On;
      btnPDT.Glyph := BtnC.greenBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmBawah_Singa.btnATTCKRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.orangeBOX_On;
      btnSTANDOFF.Glyph := BtnC.orangeBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmBawah_Singa.btnSTANDOFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then
    begin
      TSpeedButtonImage(Sender).Glyph := BtnC.orangeBOX_On;
      btnATTCKR.Glyph := BtnC.orangeBOX_Off;
    end
    else TSpeedButtonImage(Sender).Down := True;
  end;
end;

procedure TfrmBawah_Singa.btnATOClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.SetAssign_FC(1, WCCInterface.OBMLeft.Center);
    BtnC.UpdateButton(btnATO, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnAFA, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnSBA, TBSpring, GreenBOX, False);

    ConsoleWCC.Radar.IsElevating := True;
    elevTimer.Enabled := True;
    IsUpdatingTGMPos := True;
    IsStartingFC1 := true;
    WCCInterface.TGM_Marker.Visible := True;
    WCCInterface.TGM_Reset;
    WCCInterface.ShowAScope(atoLockOn);
  end;
end;

procedure TfrmBawah_Singa.btnAFAClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnAFA);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnSBAClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(1) then exit;

    WCCInterface.SetDeAssign_FC(1);

    BtnC.UpdateButton(btnSBA, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnAFA, TBSpring, GreenBOX, False);
    BtnC.UpdateImage(lmpREADY, BtnC.greenROUND_Off);
    WCCInterface.ShowAScope(atoBreak);
  end;
end;

procedure TfrmBawah_Singa.btnGENClick(Sender: TObject);
begin
  BtnC.UpdateLockBtnImage(btnGEN, orangeBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnG1ATTN_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnG1ATTN_A);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnG1FIRE_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender)); 
end;

procedure TfrmBawah_Singa.btnG2ATTN_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnG2ATTN_A);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmBawah_Singa.btnG2FIRE_AClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender)); 
end;

procedure TfrmBawah_Singa.Timer1Timer(Sender: TObject);
begin
  If IsStartingFC1 then Inc(FC1_COUNTER, 1);

  if IsUpdatingTGMPos then begin
    Inc(TGM_COUNTER, 1);
    if (TGM_COUNTER = C_FC_READY_TIME - 3) then begin
      ConsoleWCC.Radar.IsElevating := False;
      elevTimer.Enabled := False;
      WCCInterface.TGM_SetPosition(WCCInterface.OBMLeft.Center.X, WCCInterface.OBMLeft.Center.Y);
      WCCInterface.ShowAScope(atoAuto1);
    end;
    if (TGM_COUNTER = C_FC_READY_TIME - 2) then begin
      WCCInterface.ShowAScope(atoAuto2 );
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

    BtnC.UpdateButton(btnAFA, TBSpring, GreenBOX, False);
    if WCCInterface.IsFireControlInUse(1) then begin
      BtnC.UpdateImage(self.lmpREADY, BtnC.greenROUND_On);
      BtnC.UpdateButton(btnATO, TBSpring, GreenBOX, False);
    end
    else begin
      BtnC.UpdateButton(btnSBA, TBSpring, GreenBOX, True);
      BtnC.UpdateButton(btnATO, TBSpring, GreenBOX, False);
    end;
  end;
  
  // Lampu Indikator gun
  {if (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1') and WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.IsBlind = false) then
    BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_Off);

  if (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1') and WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.IsBlind = false) then
    BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_Off);
   }

  BtnC.UpdateImage(lmpG1INRANGE, GreenROUND, WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1'));
  BtnC.UpdateImage(lmpG2INRANGE, GreenROUND, WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1'));

  BtnC.UpdateBtnImage(btnG1FIRE_A, GreenBOX, WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC1'));
  BtnC.UpdateBtnImage(btnG2FIRE_A, GreenBOX, WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC1'));

end;

procedure TfrmBawah_Singa.elevTimerTimer(Sender: TObject);
begin
  wBearing.Position := wBearing.Position + 1;
  wBearingChange(nil);
end;

procedure TfrmBawah_Singa.FormShow(Sender: TObject);
begin
  self.Timer1.Enabled := True;
end;

procedure TfrmBawah_Singa.wBearingChange(Sender: TObject);
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

    //self.Caption := 'Lastpos = ' + IntToStr(lastPos) + ', CurPos = ' +
    //  IntToStr(curPos) + ', Clock = ' + BoolToStr(ClockWise, True);
  end;
end;

procedure TfrmBawah_Singa.wBearingMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then curPos := wBearing.Position;
end;

end.
