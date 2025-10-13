unit ufWCCPanelAtas2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, SpeedButtonImage, ExtCtrls, StdCtrls,
  VrControls, VrRotarySwitch, VrBlinkLed,

  {LMDCustomButton, LMDButton, LMDCustomComponent, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, LMDImageList,} ComCtrls,
  uLibWCCClassNew, uSimulationManager,
  uBaseConstan, uLibWCCKu, uBaseSensor,
  ufQEK, VrDesign, RzBmpBtn;

type
  TfrmWCCPanelAtas2 = class(TfrmQEK)
    Panel8: TPanel;
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
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
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
    btnRDRSTAB: TSpeedButtonImage;
    pnlRight: TPanel;
    lmpG2BLDARC: TImage;
    lmpG2SYNC: TImage;
    lmpRRNF: TImage;
    lmpLPCRDY: TImage;
    lmpLMAGRDY: TImage;
    lmpRMAGRDY: TImage;
    lmpRPCRDY: TImage;
    btnG2ON: TSpeedButtonImage;
    btnG2OFF: TSpeedButtonImage;
    btnG2PREFRAG: TSpeedButtonImage;
    btnG2HETRCR: TSpeedButtonImage;
    btnG2PARPROX: TSpeedButtonImage;
    Label71: TLabel;
    Label72: TLabel;
    btnG1PARPROX: TSpeedButtonImage;
    btnG1AUTO: TSpeedButtonImage;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Bevel2: TBevel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Timer1: TTimer;
    Bevel3: TBevel;
    pnlLeft: TPanel;
    lbl1: TLabel;
    btnLOG: TSpeedButtonImage;
    btnLIN: TSpeedButtonImage;
    btnDICKEFIX: TSpeedButtonImage;
    btnPLD: TSpeedButtonImage;
    btnISU: TSpeedButtonImage;
    btnQUAT: TSpeedButtonImage;
    btnSTC: TSpeedButtonImage;
    vrtryswtch1: TVrRotarySwitch;
    vrtryswtch2: TVrRotarySwitch;
    vrtryswtch3: TVrRotarySwitch;
    btnMTICORR: TSpeedButtonImage;
    lbl2: TLabel;
    btnMTIPLD: TSpeedButtonImage;
    lbl4: TLabel;
    img1: TImage;
    vrtryswtch4: TVrRotarySwitch;
    lbl5: TLabel;
    lbl6: TLabel;
    bvl2: TBevel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    btnV1: TRzBmpButton;
    btn10: TRzBmpButton;
    btn2: TRzBmpButton;
    btn3: TRzBmpButton;
    btn4: TRzBmpButton;
    btn5: TRzBmpButton;
    btn6: TRzBmpButton;
    btn7: TRzBmpButton;
    btn8: TRzBmpButton;
    btn9: TRzBmpButton;
    btn11: TRzBmpButton;
    btn12: TRzBmpButton;
    btn13: TRzBmpButton;
    btn14: TRzBmpButton;
    btn15: TRzBmpButton;
    pnlcontrolGun3: TPanel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lmpG3SYNC: TImage;
    lmpG3BLDARC: TImage;
    btnG3PARPROX: TSpeedButtonImage;
    btnG3PREFRAG: TSpeedButtonImage;
    btnG3HETRCR: TSpeedButtonImage;
    btnG3OFF: TSpeedButtonImage;
    btnG3ON: TSpeedButtonImage;
    pnl1: TPanel;
    lmp4: TImage;
    lmp1: TImage;
    lmp2: TImage;
    lmp5: TImage;
    lmp6: TImage;
    lmp7: TImage;
    lmp8: TImage;
    lmp9: TImage;
    btnSakti: TRzBmpButton;
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
    procedure btnG1AUTOClick(Sender: TObject);
    procedure btnG1PARPROXClick(Sender: TObject);
    procedure btnG2PARPROXClick(Sender: TObject);
    procedure btnG2HETRCRClick(Sender: TObject);
    procedure btnG2PREFRAGClick(Sender: TObject);
    procedure btnG2ONClick(Sender: TObject);
    procedure btnG2OFFClick(Sender: TObject);
    procedure btnG3PARPROXClick(Sender: TObject);
    procedure btnG3HETRCRClick(Sender: TObject);
    procedure btnG3PREFRAGClick(Sender: TObject);
    procedure btnG3ONClick(Sender: TObject);
    procedure btnG3OFFClick(Sender: TObject);
    procedure btnMTIPLDClick(Sender: TObject);
    procedure btnMTICORRClick(Sender: TObject);
    procedure btnLOGClick(Sender: TObject);
    procedure btnLINClick(Sender: TObject);
    procedure btnDICKEFIXClick(Sender: TObject);
    procedure btnPLDClick(Sender: TObject);
    procedure btnISUClick(Sender: TObject);
    procedure btnQUATClick(Sender: TObject);
    procedure btnSTCClick(Sender: TObject);
    procedure btnAUTOFREQClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnV1Click(Sender: TObject);
    procedure vrtryswtch3Change(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure btnSaktiClick(Sender: TObject);
    procedure Panel8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure setPanel(Show: Boolean);
    procedure SetVisibleShip(vis : boolean);
    procedure SetRadarradiate(IsOn : boolean);

    { Private declarations }
  public
    { Public declarations }
//    procedure SetOffBtnAndIndikator; override;

  end;

implementation

uses
  ufWCCPanelAtas, ufWCCPanelBawah, ufWCCPanelBawah2, ufWCCTengah, uWCCManager, uTDCConstan, uLibRadar,
  uDetected, uAnduNala;

var
  TIMER_COUNTER: Integer = 0;
  FA_COUNTER: Integer;

{$R *.dfm}

procedure TfrmWCCPanelAtas2.Timer1Timer(Sender: TObject);
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
  if WCCInterface.Gun1.IsBlind then BtnC.UpdateImage(lmpRRNF, BtnC.redROUND_On)
  else BtnC.UpdateImage(lmpRRNF, BtnC.redROUND_OFF);

  if WCCInterface.Gun2.IsBlind then BtnC.UpdateImage(lmpG2BLDARC, BtnC.redROUND_On)
  else BtnC.UpdateImage(lmpG2BLDARC, BtnC.redROUND_Off);

  if WCCInterface.Gun3.IsBlind then BtnC.UpdateImage(lmpG3BLDARC, BtnC.redROUND_On)
  else BtnC.UpdateImage(lmpG3BLDARC, BtnC.redROUND_Off);

  //self.Caption := IntToStr(TIMER_COUNTER);
end;

procedure TfrmWCCPanelAtas2.vrtryswtch3Change(Sender: TObject);
begin
  inherited;

end;

//**********************************************//
//      RADAR CONTROL PANEL                     //
//**********************************************//

procedure TfrmWCCPanelAtas2.SetRadarradiate(IsOn: boolean);
begin
  if IsOn then begin
   (WCCInterface.frmTengah as TfrmWCCTengah).Map.BackColor := clGray;
   ConsoleWCC.Radar.Status := RAD_RADIATE;
  end
  else
  begin
    (WCCInterface.frmTengah as TfrmWCCTengah).Map.BackColor := clBlack;
     ConsoleWCC.Radar.Status := RAD_STANDBY;
  end;

  WCCInterface.SetRadarOnOff(True);

  if (ConsoleWCC.Radar.FreqType <> FREQ_OFF) and (ConsoleWCC.Radar.FreqBand <> BAND_OFF) and
    (ConsoleWCC.Radar.ScanType <> SCAN_OFF) and (ConsoleWCC.Radar.Polarization <> POL_OFF)  then
  begin
    WCCInterface.ActiveRadar.Radiate := IsOn;
    TDCSimCenter.Radarproses := IsOn;
    WCCInterface.SetTrackShown(IsOn);
  end;

end;
procedure TfrmWCCPanelAtas2.btnRadarRadiateClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status = RAD_STANDBY) then
  begin
    btnRadarStandByClick(sender);
    if WCCInterface.IsRadarError then Exit;

    { TAMPILAN BTN }
    btnRadarRadiate.Down := True;
//    SetVisibleShip(true);

    if btnRadarRadiate.Down then
    begin
      btnRadarRadiate.Glyph := BtnC.greenBOX_On;
      btnRadarStandBy.Glyph := BtnC.greenBOX_Off;

      SetRadarradiate(True);

      {LOG}
     WCCInterface.SendEvenWCC_120mm(1);
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnRadarStandByClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and (ConsoleWCC.Radar.Status <> RAD_OFF) then
  begin
    { TAMPILAN BTN }
    btnRadarStandBy.Down := True;
    if btnRadarStandBy.Down then
    begin
      btnRadarStandBy.Glyph := BtnC.greenBOX_On;
      btnRadarRadiate.Glyph := BtnC.greenBOX_Off;
      SetRadarradiate(false);
      {LOG}
     WCCInterface.SendEvenWCC_120mm(2);
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnRDRSILClick(Sender: TObject);
var
  wccAtas : TfrmWCCPanelAtas;
begin
  wccAtas := TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnRDRSIL, orangeBOX);
    if TSpeedButtonImage(Sender).Down then
    begin
      if (ConsoleWCC.Radar.Status = RAD_STANDBY) or (ConsoleWCC.Radar.Status = RAD_RADIATE) then
      begin
        self.btnRadarStandBy.Down := False;
        BtnC.UpdateBtnImage(btnRadarStandBy, GreenBOX, false);
        self.btnRadarRadiate.Down := False;
        BtnC.UpdateBtnImage(btnRadarRadiate, GreenBOX, false);
      end;

      WCCInterface.SetRadarOnOff(False);
      WCCInterface.ActiveRadar.Radiate  := False;
      ConsoleWCC.Radar.Status           := RAD_OFF;
      (WCCInterface.frmTengah as TfrmWCCTengah).Map.BackColor := clBlack;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(3);
    end
    else
    begin
      ConsoleWCC.Radar.Status := RAD_STANDBY;
      self.btnRadarStandBy.Down := false;
      btnRadarStandBy.Glyph := BtnC.greenBOX_On;
      SetRadarradiate(false);
      WCCInterface.SetRadarOnOff(True);
      BtnC.UpdateBtnImage(btnRadarStandBy, GreenBOX, True);
      self.btnRadarRadiate.Down := False;
      BtnC.UpdateBtnImage(btnRadarRadiate, GreenBOX, false);
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnRadarAlarmClick(Sender: TObject);
var
  fA: TfrmWCCPanelAtas;
  fB: TfrmWCCPanelBawah;
  fB2: TfrmWCCPanelBawah2;
begin
   if not ConsoleWCC.CekSaklar then exit;
    ConsoleWCC.PowerON := True;
    ConsoleWCC.SystemON := True;
    ConsoleWCC.Radar.Status := RAD_STANDBY;
    TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1).IsProgLoaded := true;
    TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1).IsSysRDY := true;
    TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1).btnSystemOnClick(nil);
    BtnC.UpdateLockBtnImage(btnRadarAlarm, redBOX);
    {LOG}
    WCCInterface.SendEvenWCC_120mm(4);
end;

procedure TfrmWCCPanelAtas2.btnHORSCANClick(Sender: TObject);
begin

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORSCAN.Glyph := BtnC.greenBOX_On;
      btnHELSCAN.Glyph := BtnC.greenBOX_Off;
      BtnC.UpdateImage(TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.sgreenROUND_On);
    end;
    ConsoleWCC.Radar.ScanType := SCAN_HOR;
    WCCInterface.SetEMarkConstraint(C_EMarkMin, C_EMarkMin + 8);
  end;
end;

procedure TfrmWCCPanelAtas2.btnHELSCANClick(Sender: TObject);
begin
  {Added By Bagus}
  if not ConsoleWCC.PowerON then
    ConsoleWCC.SystemON := False;

  if not ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := false;
    btnHORSCAN.Glyph := BtnC.greenBOX_Off;
    btnHELSCAN.Glyph := BtnC.greenBOX_Off;

    BtnC.UpdateImage(TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.sgreenROUND_Off);
    ConsoleWCC.Radar.ScanType := SCAN_OFF;
   // WCCInterface.SetEMarkConstraint(C_EMarkMin, C_EMarkMin + 8);

  end;
  {Added By Bagus}


  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnHORSCAN.Glyph := BtnC.greenBOX_Off;
      btnHELSCAN.Glyph := BtnC.greenBOX_On;

      BtnC.UpdateImage(TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.sgreenROUND_Off);
    end;

    ConsoleWCC.Radar.ScanType := SCAN_HEL;
    WCCInterface.SetEMarkConstraint(C_EMarkMin, C_EMarkMin + 25);
  end;
end;

procedure TfrmWCCPanelAtas2.btnHORPOLClick(Sender: TObject);
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

procedure TfrmWCCPanelAtas2.btnCIRCPOLClick(Sender: TObject);
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

procedure TfrmWCCPanelAtas2.btnLOWPRFClick(Sender: TObject);
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

procedure TfrmWCCPanelAtas2.btnHIGHPRFClick(Sender: TObject);
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

procedure TfrmWCCPanelAtas2.btnFREQ1Click(Sender: TObject);
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
    1: begin
        ConsoleWCC.Radar.FreqBand := BAND1;
        btnFREQ1.Down := True;
        btnFREQ1.Glyph := BtnC.greenBOX_On;
      end;
    2: begin
        ConsoleWCC.Radar.FreqBand := BAND2;
        btnFREQ2.Down := True;
        btnFREQ2.Glyph := BtnC.greenBOX_On;
      end;
    3: begin
        ConsoleWCC.Radar.FreqBand := BAND3;
        btnFREQ3.Down := True;
        btnFREQ3.Glyph := BtnC.greenBOX_On;
      end;
    4: begin
        ConsoleWCC.Radar.FreqBand := BAND4;
        btnFREQ4.Down := True;
        btnFREQ4.Glyph := BtnC.greenBOX_On;
      end;
    5: begin
        ConsoleWCC.Radar.FreqBand := BAND5;
        btnFREQ5.Down := True;
        btnFREQ5.Glyph := BtnC.greenBOX_On;
      end;
    6: begin
        ConsoleWCC.Radar.FreqBand := BAND6;
        btnFREQ6.Down := True;
        btnFREQ6.Glyph := BtnC.greenBOX_On;
      end;
    end
  end;
end;

procedure TfrmWCCPanelAtas2.Reset_Freq_Button;
begin
  btnFREQ1.Glyph := BtnC.greenBOX_Off;
  btnFREQ2.Glyph := BtnC.greenBOX_Off;
  btnFREQ3.Glyph := BtnC.greenBOX_Off;
  btnFREQ4.Glyph := BtnC.greenBOX_Off;
  btnFREQ5.Glyph := BtnC.greenBOX_Off;
  btnFREQ6.Glyph := BtnC.greenBOX_Off;
end;

//procedure TfrmWCCPanelAtas2.SetOffBtnAndIndikator;
//begin
//  inherited;
//
//end;

procedure TfrmWCCPanelAtas2.setPanel(Show: Boolean);
begin
//  pnlLeft.Visible   := not Show;
//  pnlRight.Visible := Show;
end;

procedure TfrmWCCPanelAtas2.SetVisibleShip(vis: boolean);
var
  I: Integer;
  detObj : TDetectedObject;
begin
  for I := 0 to WCCInterface.ActiveRadar.DetObjects.ItemCount - 1 do
  begin
    detObj := WCCInterface.ActiveRadar.DetObjects.getObject(i) as TDetectedObject;
    detObj.Visibles := vis;
  end;
end;

procedure TfrmWCCPanelAtas2.btnFREQAGILClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnFREQAGIL.Glyph := BtnC.greenBOX_On;
      btnFIXFREQ.Glyph := BtnC.greenBOX_Off;
      self.Timer1.Enabled := True;
      WCCInterface.ActiveRadar.FrequencyMode := fmAgile;
      ConsoleWCC.Radar.FreqType := FREQ_AGIL;
    end;
    FA_COUNTER := 0;
  end;
end;

procedure TfrmWCCPanelAtas2.btnFIXFREQClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnFREQAGIL.Glyph := BtnC.greenBOX_Off;
      btnFIXFREQ.Glyph  := BtnC.greenBOX_On;
      self.Timer1.Enabled := false;
      ConsoleWCC.Radar.FreqType := FREQ_FIX;
      WCCInterface.ActiveRadar.FrequencyMode := fmFixed;
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnRDRSTABClick(Sender: TObject);
begin
  { TAMPILAN BTN }
  //UpdateLockBtnImage(btnRDRSTAB, redBOX);
end;

procedure TfrmWCCPanelAtas2.btn1Click(Sender: TObject);
begin
  inherited;
  //setPanel(False);
end;

procedure TfrmWCCPanelAtas2.btn2Click(Sender: TObject);
begin
  inherited;
 // setPanel(True);

end;

procedure TfrmWCCPanelAtas2.btnAUTOFREQClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnAUTOFREQ, greenBOX);
  end;
end;

// Receiver //
procedure TfrmWCCPanelAtas2.btnMTIPLDClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnMTIPLD, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnMTICORRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnMTICORR, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnLOGClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
//      btnLOG.Glyph := BtnC.greenBOX_On;
      btnLIN.Glyph := BtnC.greenBOX_Off;
      btnLIN.Down := False;
      self.WCCInterface.SetRadar_Amplification(raLogarithmic);
    end;
    BtnC.UpdateLockBtnImage(btnLOG, greenBOX);

  end;
end;

procedure TfrmWCCPanelAtas2.btnLINClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin

    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
//      btnLOG.Glyph := BtnC.greenBOX_On;
      btnLOG.Glyph := BtnC.greenBOX_Off;
      btnLOG.Down := False;
      self.WCCInterface.SetRadar_Amplification(raLiner);
    end;
     BtnC.UpdateLockBtnImage(btnLIN, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnDICKEFIXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnDICKEFIX, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnPLDClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnPLD, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnISUClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnISU, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnQUATClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnQUAT, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnSaktiClick(Sender: TObject);
var
  i : Integer;
  F :TfrmWCCPanelAtas;
begin
//  inherited;
  for i := 1 to 25 do
  begin
    ConsoleWCC.Saklar[i] := TRzBmpButton(Sender).Down;
  end;

  F := TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1);
  if ConsoleWCC.CekSaklar then
     F.btnpoweroff.Glyph := BtnC.greenBOX_On
  else begin
    F.btnPowerOff.Down := True;
    F.PowerOff;
    F.btnpoweroff.Glyph := BtnC.greenBOX_Off;
  end;
end;

procedure TfrmWCCPanelAtas2.btnSTCClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSTC, greenBOX);
  end;
end;

procedure TfrmWCCPanelAtas2.btnV1Click(Sender: TObject);
var F :TfrmWCCPanelAtas;
begin
//  inherited;
  ConsoleWCC.Saklar[TRzBmpButton(Sender).Tag] := TRzBmpButton(Sender).Down;
  F := TfrmWCCPanelAtas(WCCInterface.frmWCCAtas1);

    if ConsoleWCC.CekSaklar then
       F.btnpoweroff.Glyph := BtnC.greenBOX_On
    else begin
      F.btnPowerOff.Down := True;
      F.PowerOff;
      F.btnpoweroff.Glyph := BtnC.greenBOX_Off;
    end;

end;

procedure TfrmWCCPanelAtas2.edt1Change(Sender: TObject);
begin
  inherited;
end;

//**********************************************//
//      GUN STATUS & CONTROL PANEL              //
//**********************************************//
procedure TfrmWCCPanelAtas2.btnG1AUTOClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnG1AUTO, orangeBOX);
    WCCInterface.Gun1.Salvo   := btnG1AUTO.Down;

    {LOG}
    if btnG1AUTO.Down then
      WCCInterface.SendEvenWCC_120mm(5)
    else
      WCCInterface.SendEvenWCC_120mm(6);

  //  WCCInterface.Gun1.Synchronized := TRUE; // kapan assign local ato remote

  //    BtnC.UpdateImage(lmpRPCRDY, BtnC.greenROUND_Off);
  //    BtnC.UpdateImage(lmpLMAGRDY, BtnC.greenROUND_On);
  //    BtnC.UpdateImage(lmpLPCRDY, BtnC.orangeROUND_On);
  end;
end;

procedure TfrmWCCPanelAtas2.btnG1PARPROXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnG1PARPROX, orangeBOX);
    WCCInterface.Gun1.Bullet1Type := Ord(btnG1PARPROX.Down);
  end;
end;

procedure TfrmWCCPanelAtas2.btnG2PARPROXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnG2PARPROX, orangeBOX);
    WCCInterface.Gun2.Bullet1Type := Ord(btnG2PARPROX.Down);
  end;
end;

procedure TfrmWCCPanelAtas2.btnG2HETRCRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG2HETRCR.Glyph := BtnC.orangeBOX_On;
      btnG2PREFRAG.Glyph := BtnC.orangeBOX_Off;
      WCCInterface.Gun2.Bullet2Type := 0;
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG2PREFRAGClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG2HETRCR.Glyph := BtnC.orangeBOX_Off;
      btnG2PREFRAG.Glyph := BtnC.orangeBOX_On;
      WCCInterface.Gun2.Bullet2Type := 1;
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG2ONClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
//   if not WCCInterface.IsGun2Syn then Exit;
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG2ON.Glyph := BtnC.greenBOX_On;
      btnG2OFF.Glyph := BtnC.greenBOX_Off;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(7);
    end;
    WCCInterface.Gun2.PowerOn := True;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG2OFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
//    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG2ON.Glyph := BtnC.greenBOX_Off;
      btnG2OFF.Glyph := BtnC.greenBOX_On;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(8);
    end;
    WCCInterface.Gun2.PowerOn := False;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG3PARPROXClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnG3PARPROX, orangeBOX);
    WCCInterface.Gun3.Bullet1Type := Ord(btnG3PARPROX.Down);
  end;
end;
        
procedure TfrmWCCPanelAtas2.btnG3HETRCRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG3HETRCR.Glyph := BtnC.orangeBOX_On;
      btnG3PREFRAG.Glyph := BtnC.orangeBOX_Off;
      WCCInterface.Gun3.Bullet2Type := 0;
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG3PREFRAGClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG3HETRCR.Glyph := BtnC.orangeBOX_Off;
      btnG3PREFRAG.Glyph := BtnC.orangeBOX_On;
      WCCInterface.Gun3.Bullet2Type := 1;
    end;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG3ONClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
//  if not WCCInterface.IsGun3Syn then Exit;
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG3ON.Glyph := BtnC.greenBOX_On;
      btnG3OFF.Glyph := BtnC.greenBOX_Off;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(8);
    end;
    WCCInterface.Gun3.PowerOn := True;
  end;
end;

procedure TfrmWCCPanelAtas2.btnG3OFFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    TSpeedButtonImage(Sender).Down := True;
    if TSpeedButtonImage(Sender).Down then
    begin
      btnG3ON.Glyph := BtnC.greenBOX_Off;
      btnG3OFF.Glyph := BtnC.greenBOX_On;
      {LOG}
      WCCInterface.SendEvenWCC_120mm(8);
    end;
    WCCInterface.Gun3.PowerOn := False;
  end;
end;

//**********************************************//
//      SAKLAR PANEL ATAS                       //
//**********************************************//
procedure TfrmWCCPanelAtas2.FormShow(Sender: TObject);
begin
  // Asumsi Gun1 Nyala terus
  WCCInterface.Gun1.PowerOn := True;
  WCCInterface.Gun1.Synchronized := TRUE;

//  pnlRight.Left := 365;
end;

procedure TfrmWCCPanelAtas2.Panel8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and (ssCtrl in Shift)
    and (ssAlt in Shift) then begin
      btnSakti.Visible := True;
  end;

  if (Button = mbLeft) and (ssCtrl in Shift)
    and (ssAlt in Shift) then begin
      btnSakti.Visible := False;
  end;
end;

procedure TfrmWCCPanelAtas2.FormCreate(Sender: TObject);
begin
  //fae
  inherited;

end;

end.
