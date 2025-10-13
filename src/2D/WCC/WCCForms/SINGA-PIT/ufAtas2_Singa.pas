unit ufAtas2_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, SpeedButtonImage, ExtCtrls, StdCtrls,
  VrControls, VrRotarySwitch, VrBlinkLed,

  ComCtrls,
  uLibWCCClassNew, uSimulationManager,
  uBaseConstan, uLibWCCKu, uBaseSensor, ufQEK;

type
  TfrmAtas2_Singa = class(TfrmQEK)
    Panel7: TPanel;
    lmpG2SYNC: TImage;
    lmpG2BLDARC: TImage;
    lmpG1SYNC: TImage;
    lmpG1RDY: TImage;
    lmpG1FBLOC: TImage;
    lmpG1REMOTE: TImage;
    btnG2PARPROX: TSpeedButtonImage;
    btnG2HETRCR: TSpeedButtonImage;
    btnG2PREFRAG: TSpeedButtonImage;
    btnG1SINGLE: TSpeedButtonImage;
    btnG1AM2: TSpeedButtonImage;
    btnG1AM1: TSpeedButtonImage;
    btnG1PARPROX: TSpeedButtonImage;
    btnG1UNSAVE: TSpeedButtonImage;
    btnG1SAVE: TSpeedButtonImage;
    Label83: TLabel;
    Label84: TLabel;
    btnG2OFF: TSpeedButtonImage;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label82: TLabel;
    Label142: TLabel;
    btnG2ON: TSpeedButtonImage;
    Label69: TLabel;
    Timer1: TTimer;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel6: TBevel;
    Panel8: TPanel;
    VL13: TSpeedButtonImage;
    VL21: TSpeedButtonImage;
    VL14: TSpeedButtonImage;
    VL15: TSpeedButtonImage;
    VL16: TSpeedButtonImage;
    VL17: TSpeedButtonImage;
    VL18: TSpeedButtonImage;
    VL19: TSpeedButtonImage;
    VL20: TSpeedButtonImage;
    VL22: TSpeedButtonImage;
    VL23: TSpeedButtonImage;
    VL24: TSpeedButtonImage;
    VL25: TSpeedButtonImage;
    Label116: TLabel;
    Label117: TLabel;
    Label119: TLabel;
    Label118: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label141: TLabel;
    Panel6: TPanel;
    btnAUTOFREQ: TSpeedButtonImage;
    btnFREQ1: TSpeedButtonImage;
    btnFREQ2: TSpeedButtonImage;
    btnFREQ3: TSpeedButtonImage;
    btnFREQ4: TSpeedButtonImage;
    btnFREQ5: TSpeedButtonImage;
    btnFREQ6: TSpeedButtonImage;
    btnHIGHPRF: TSpeedButtonImage;
    btnLOWPRF: TSpeedButtonImage;
    btnFIXFREQ: TSpeedButtonImage;
    btnFREQAGIL: TSpeedButtonImage;
    btnCIRCPOL: TSpeedButtonImage;
    btnHORPOL: TSpeedButtonImage;
    btnHORSCAN: TSpeedButtonImage;
    btnHELSCAN: TSpeedButtonImage;
    btnRadarAlarm: TSpeedButtonImage;
    btnRDRSIL: TSpeedButtonImage;
    btnRadarStandBy: TSpeedButtonImage;
    btnRadarRadiate: TSpeedButtonImage;
    Label54: TLabel;
    Bevel1: TBevel;
    Label55: TLabel;
    Label56: TLabel;
    btnMTICORR: TSpeedButtonImage;
    btnSTC: TSpeedButtonImage;
    btnQUAT: TSpeedButtonImage;
    btnISU: TSpeedButtonImage;
    btnPLD: TSpeedButtonImage;
    btnDICKEFIX: TSpeedButtonImage;
    btnLIN: TSpeedButtonImage;
    btnLOG: TSpeedButtonImage;
    btnMTIPLD: TSpeedButtonImage;
    btnRDRSTAB: TSpeedButtonImage;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    VrRotarySwitch25: TVrRotarySwitch;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch3: TVrRotarySwitch;
    Label1: TLabel;
    procedure btnRadarAlarmClick(Sender: TObject);
    procedure btnRadarRadiateClick(Sender: TObject);
    procedure btnRadarStandByClick(Sender: TObject);
    procedure btnRDRSILClick(Sender: TObject);
    procedure btnHORSCANClick(Sender: TObject);
    procedure btnHELSCANClick(Sender: TObject);
    procedure btnHORPOLClick(Sender: TObject);
    procedure btnCIRCPOLClick(Sender: TObject);
    procedure btnLOWPRFClick(Sender: TObject);
    procedure btnHIGHPRFClick(Sender: TObject);
    procedure btnFREQ1Click(Sender: TObject);
    procedure Reset_Freq_Button;
    procedure btnFREQAGILClick(Sender: TObject);
    procedure btnFIXFREQClick(Sender: TObject);
    procedure btnRDRSTABClick(Sender: TObject);
    procedure btnG1SAVEClick(Sender: TObject);
    procedure btnG1UNSAVEClick(Sender: TObject);
    procedure btnG1PARPROXClick(Sender: TObject);
    procedure btnG1AM1Click(Sender: TObject);
    procedure btnG1AM2Click(Sender: TObject);
    procedure btnG1SINGLEClick(Sender: TObject);
    procedure btnG2ONClick(Sender: TObject);
    procedure btnG2OFFClick(Sender: TObject);
    procedure btnG2PARPROXClick(Sender: TObject);
    procedure btnG2HETRCRClick(Sender: TObject);
    procedure btnG2PREFRAGClick(Sender: TObject);
    procedure btnMTIPLDClick(Sender: TObject);
    procedure btnMTICORRClick(Sender: TObject);
    procedure btnLOGClick(Sender: TObject);
    procedure btnLINClick(Sender: TObject);
    procedure btnDICKEFIXClick(Sender: TObject);
    procedure btnPLDClick(Sender: TObject);
    procedure btnISUClick(Sender: TObject);
    procedure btnQUATClick(Sender: TObject);
    procedure btnSTCClick(Sender: TObject);
    procedure VL13Click(Sender: TObject);
    procedure btnAUTOFREQClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
  //frmWCCPanelAtas2: TfrmWCCPanelAtas2;

implementation

uses
  ufAtas_Singa, ufBawah_Singa, ufBawah2_Singa, ufWCCTengah, uWCCManager, uLibTDCTracks, uTDCConstan;

var
  TIMER_COUNTER: Integer = 0;
  FA_COUNTER: Integer;

{$R *.dfm}

procedure TfrmAtas2_Singa.Timer1Timer(Sender: TObject);
var
  band: Integer;
begin
  //Inc(TIMER_COUNTER,1);
  Inc(FA_COUNTER,1);

  If (FA_COUNTER = C_FREQ_AGIL_CH_TIME) and (ConsoleWCC.Radar.FreqType = FREQ_AGIL) then
  begin
    FA_COUNTER := 0;
    band := random(6);
    case band of
    1: btnFREQ1.Click;
    2: btnFREQ2.Click;
    3: btnFREQ3.Click;
    4: btnFREQ4.Click;
    5: btnFREQ5.Click;
    6: btnFREQ6.Click;
    end
  end;

  if WCCInterface.Gun1.IsBlind then BtnC.UpdateImage(lmpG1FBLOC, BtnC.redROUND_On)
  else BtnC.UpdateImage(lmpG1FBLOC, BtnC.redROUND_Off);

  if WCCInterface.Gun2.IsBlind then BtnC.UpdateImage(lmpG2BLDARC, BtnC.redROUND_On)
  else BtnC.UpdateImage(lmpG2BLDARC, BtnC.redROUND_Off);

  //self.Caption := IntToStr(TIMER_COUNTER);
end;

//**********************************************//
//      RADAR CONTROL PANEL                     //
//**********************************************//

procedure TfrmAtas2_Singa.btnRadarRadiateClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_STANDBY) then
  begin
    { TAMPILAN BTN }
    btnRadarRadiate.Down := True;
    if btnRadarRadiate.Down then
    begin
      btnRadarRadiate.Glyph := BtnC.greenBOX_On;
      btnRadarStandBy.Glyph := BtnC.greenBOX_Off;

      ConsoleWCC.Radar.Status := RAD_RADIATE;

      if (ConsoleWCC.Radar.FreqType <> FREQ_OFF) and (ConsoleWCC.Radar.FreqBand <> BAND_OFF) and
        (ConsoleWCC.Radar.ScanType <> SCAN_OFF) and (ConsoleWCC.Radar.Polarization <> POL_OFF) and
        (ConsoleWCC.Radar.FreqBand <> BAND_OFF) then
      begin
        WCCInterface.SetRadarOnOff(True);
        WCCInterface.ActiveRadar.Radiate := True;
      end;
    end;
  end;
end;

procedure TfrmAtas2_Singa.btnRadarStandByClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_RADIATE) then
  begin
    { TAMPILAN BTN }
    btnRadarStandBy.Down := True;
    if btnRadarStandBy.Down then
    begin
      btnRadarStandBy.Glyph := BtnC.greenBOX_On;
      btnRadarRadiate.Glyph := BtnC.greenBOX_Off;

      ConsoleWCC.Radar.Status := RAD_STANDBY;

      WCCInterface.ActiveRadar.Radiate := not btnRadarStandBy.Down;
    end;
  end;
end;

procedure TfrmAtas2_Singa.btnRDRSILClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnRDRSIL, orangeBOX);
    if ConsoleWCC.Radar.Status = RAD_STANDBY then
    begin
      self.btnRadarStandBy.Down := False;
      BtnC.UpdateLockBtnImage(btnRadarStandBy, GreenBOX);
    end
    else
    begin
      self.btnRadarRadiate.Down := False;
      BtnC.UpdateLockBtnImage(btnRadarRadiate, GreenBOX);
    end;
    ConsoleWCC.Radar.Status := RAD_OFF;
  end;
end;

procedure TfrmAtas2_Singa.btnRadarAlarmClick(Sender: TObject);
var
  fA: TfrmAtas_Singa;
  fB: TfrmBawah_Singa;
  fB2: TfrmBawah2_Singa;
begin
  ConsoleWCC.PowerON := True;
  ConsoleWCC.SystemON := True;
  ConsoleWCC.Radar.Status := RAD_STANDBY;
  TfrmAtas_Singa(WCCInterface.frmWCCAtas1).IsProgLoaded := true;
  TfrmAtas_Singa(WCCInterface.frmWCCAtas1).IsSysRDY := true;
  TfrmAtas_Singa(WCCInterface.frmWCCAtas1).btnSystemOnClick(nil);
  BtnC.UpdateLockBtnImage(btnRadarAlarm, redBOX);
end;

procedure TfrmAtas2_Singa.btnHORSCANClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORSCAN.Glyph := BtnC.greenBOX_On;
      btnHELSCAN.Glyph := BtnC.greenBOX_Off;

      BtnC.UpdateImage(TfrmBawah_Singa(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.greenROUND_On);
    end;

    ConsoleWCC.Radar.ScanType := SCAN_HOR;
    WCCInterface.SetEMarkConstraint(C_EMarkMin, C_EMarkMin + 8);
  end;
end;

procedure TfrmAtas2_Singa.btnHELSCANClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORSCAN.Glyph := BtnC.greenBOX_Off;
      btnHELSCAN.Glyph := BtnC.greenBOX_On;

      BtnC.UpdateImage(TfrmBawah_Singa(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.greenROUND_Off);
    end;

    ConsoleWCC.Radar.ScanType := SCAN_HEL;
    WCCInterface.SetEMarkConstraint(C_EMarkMin, C_EMarkMin + 25);
  end;
end;

procedure TfrmAtas2_Singa.btnHORPOLClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORPOL.Glyph := BtnC.greenBOX_On;
      btnCIRCPOL.Glyph := BtnC.greenBOX_Off;
    end;

    ConsoleWCC.Radar.Polarization := POL_HOR;
  end;
end;

procedure TfrmAtas2_Singa.btnCIRCPOLClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORPOL.Glyph := BtnC.greenBOX_Off;
      btnCIRCPOL.Glyph := BtnC.greenBOX_On;
    end;

    ConsoleWCC.Radar.Polarization := POL_CIRC;
  end;
end;

procedure TfrmAtas2_Singa.btnLOWPRFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnLOWPRF.Glyph := BtnC.greenBOX_On;
      btnHIGHPRF.Glyph := BtnC.greenBOX_Off;
    end;

    ConsoleWCC.Radar.PRF := PRF_LOW;
  end;
end;

procedure TfrmAtas2_Singa.btnHIGHPRFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnLOWPRF.Glyph := BtnC.greenBOX_Off;
      btnHIGHPRF.Glyph := BtnC.greenBOX_On;
    end;

    ConsoleWCC.Radar.PRF := PRF_HIGH;
  end;
end;

procedure TfrmAtas2_Singa.btnFREQ1Click(Sender: TObject);
var
  Ob : TSpeedButtonImage;
  lbl: TLabel;
  tagg: Integer;
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if Sender.ClassType = TSpeedButtonImage then begin
      Ob := Sender As TSpeedButtonImage;
      tagg := ob.Tag;
    end
    else begin
      lbl := Sender as TLabel;
      tagg := lbl.Tag;
    end;

    self.Reset_Freq_Button;
    case tagg of
    1: begin ConsoleWCC.Radar.FreqBand := BAND1;
        btnFREQ1.Down := True;
        btnFREQ1.Glyph := BtnC.greenBOX_On;
      end;
    2: begin ConsoleWCC.Radar.FreqBand := BAND2; btnFREQ2.Down := True;
        btnFREQ2.Glyph := BtnC.greenBOX_On;
      end;
    3: begin ConsoleWCC.Radar.FreqBand := BAND3; btnFREQ3.Down := True;
        btnFREQ3.Glyph := BtnC.greenBOX_On;
      end;
    4: begin ConsoleWCC.Radar.FreqBand := BAND4; btnFREQ4.Down := True;
        btnFREQ4.Glyph := BtnC.greenBOX_On;
      end;
    5: begin ConsoleWCC.Radar.FreqBand := BAND5; btnFREQ5.Down := True;
        btnFREQ5.Glyph := BtnC.greenBOX_On;
      end;
    6: begin ConsoleWCC.Radar.FreqBand := BAND6; btnFREQ6.Down := True;
        btnFREQ6.Glyph := BtnC.greenBOX_On;
      end;
    end
  end;
end;

procedure TfrmAtas2_Singa.Reset_Freq_Button;
begin
  btnFREQ1.Glyph := BtnC.greenBOX_Off;
  btnFREQ2.Glyph := BtnC.greenBOX_Off;
  btnFREQ3.Glyph := BtnC.greenBOX_Off;
  btnFREQ4.Glyph := BtnC.greenBOX_Off;
  btnFREQ5.Glyph := BtnC.greenBOX_Off;
  btnFREQ6.Glyph := BtnC.greenBOX_Off;
end;

procedure TfrmAtas2_Singa.btnFREQAGILClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnFREQAGIL.Glyph := BtnC.greenBOX_On;
      btnFIXFREQ.Glyph := BtnC.greenBOX_Off;
    end;

    ConsoleWCC.Radar.FreqType := FREQ_AGIL;
    FA_COUNTER := 0;

    WCCInterface.ActiveRadar.FrequencyMode := fmAgile;
  end;
end;

procedure TfrmAtas2_Singa.btnFIXFREQClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnFREQAGIL.Glyph := BtnC.greenBOX_Off;
      btnFIXFREQ.Glyph := BtnC.greenBOX_On;
    end;

    ConsoleWCC.Radar.FreqType := FREQ_FIX;
    WCCInterface.ActiveRadar.FrequencyMode := fmFixed;
  end;
end;

procedure TfrmAtas2_Singa.btnRDRSTABClick(Sender: TObject);
begin
  { TAMPILAN BTN }
  //UpdateLockBtnImage(btnRDRSTAB, redBOX);
end;

procedure TfrmAtas2_Singa.btnAUTOFREQClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnAUTOFREQ, greenBOX);
  end;
end;

// Receiver //
procedure TfrmAtas2_Singa.btnMTIPLDClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnMTIPLD, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnMTICORRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnMTICORR, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnLOGClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnLOG, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnLINClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnLIN, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnDICKEFIXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnDICKEFIX, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnPLDClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnPLD, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnISUClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnISU, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnQUATClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnQUAT, greenBOX);
  end;
end;

procedure TfrmAtas2_Singa.btnSTCClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSTC, greenBOX);
  end;
end;

//**********************************************//
//      GUN STATUS & CONTROL PANEL              //
//**********************************************//
procedure TfrmAtas2_Singa.btnG1SAVEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.Gun1.PowerOn := True;
    BtnC.UpdateBtnImage(btng1save,BtnC.orangeBOX_On);
    btnG1UNSAVE.Down := false;
    BtnC.UpdateBtnImage(btng1unsave,BtnC.greenBOX_Off);
  end;
end;

procedure TfrmAtas2_Singa.btnG1UNSAVEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.Gun1.PowerOn := False;
    BtnC.UpdateBtnImage(btng1save,BtnC.orangeBOX_Off);
    btnG1SAVE.Down := false;
    BtnC.UpdateBtnImage(btng1unsave,BtnC.greenBOX_On);
  end;
end;

procedure TfrmAtas2_Singa.btnG1PARPROXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnG1PARPROX, orangeBOX);
    WCCInterface.Gun1.Bullet1Type := Ord(btnG1PARPROX.Down);  
  end;
end;

procedure TfrmAtas2_Singa.btnG1AM1Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmAtas2_Singa.btnG1AM2Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

  end;
end;

procedure TfrmAtas2_Singa.btnG1SINGLEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.Gun1.Salvo := btnG1SINGLE.Down;
    BtnC.UpdateButton(btnG1SINGLE, TBLock, GreenBOX, btnG1SINGLE.Down);
  end;
end;

procedure TfrmAtas2_Singa.btnG2ONClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    btnG2ON.Down := True;
    if btnG2ON.Down then
    begin
      btnG2ON.Glyph := BtnC.greenBOX_On;
      btnG2OFF.Glyph := BtnC.greenBOX_Off;
    end;
    WCCInterface.Gun2.PowerOn := True;
  end;
end;

procedure TfrmAtas2_Singa.btnG2OFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    btnG2OFF.Down := True;
    if btnG2OFF.Down then
    begin
      btnG2ON.Glyph := BtnC.greenBOX_Off;
      btnG2OFF.Glyph := BtnC.greenBOX_On;
    end;
    WCCInterface.Gun2.PowerOn := False;
  end;
end;

procedure TfrmAtas2_Singa.btnG2PARPROXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
  	BtnC.UpdateLockBtnImage(btnG2PARPROX, orangeBOX);
    WCCInterface.Gun2.Bullet1Type := Ord(btnG2PARPROX.Down);  
  end;
end;
        
procedure TfrmAtas2_Singa.btnG2HETRCRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    btnG2HETRCR.Down := True;
    if btnG2HETRCR.Down then
    begin
      btnG2HETRCR.Glyph := BtnC.orangeBOX_On;
      btnG2PREFRAG.Glyph := BtnC.orangeBOX_Off;
      WCCInterface.Gun2.Bullet2Type := 0;
    end;  
  end;
end;

procedure TfrmAtas2_Singa.btnG2PREFRAGClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    btnG2PREFRAG.Down := True;
    if btnG2PREFRAG.Down then
    begin
      btnG2HETRCR.Glyph := BtnC.orangeBOX_Off;
      btnG2PREFRAG.Glyph := BtnC.orangeBOX_On;
      WCCInterface.Gun2.Bullet2Type := 1;
    end;  
  end;
end;

//**********************************************//
//      SAKLAR PANEL ATAS                       //
//**********************************************//
procedure TfrmAtas2_Singa.VL13Click(Sender: TObject);
begin
  ConsoleWCC.Saklar[TSpeedButtonImage(Sender).Tag] := TSpeedButtonImage(Sender).Down;
end;

procedure TfrmAtas2_Singa.FormCreate(Sender: TObject);
begin
  inherited;
  
  Timer1.Enabled := True;
end;

end.
