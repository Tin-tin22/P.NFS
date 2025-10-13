  unit ufWCCPanelAtas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, SpeedButtonImage, ExtCtrls, StdCtrls,
  VrControls, VrRotarySwitch, VrBlinkLed,

  {LMDCustomButton, LMDButton, LMDCustomComponent, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, LMDImageList,} ComCtrls,
  uLibWCCClassNew, uTDCConstan, uLibWCCKu, uBaseConstan,
  ufQEK, RzBmpBtn;

type
  TfrmWCCPanelAtas = class(TfrmQEK)
    Panel1: TPanel;
    Image1: TImage;
    Image23: TImage;
    SpeedButtonImage75: TSpeedButtonImage;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Panel3: TPanel;
    btnRELATIVE: TSpeedButtonImage;
    Label16: TLabel;
    btnNOCAS: TSpeedButtonImage;
    btnNAV: TSpeedButtonImage;
    btnLINEUP: TSpeedButtonImage;
    btnANTIICE: TSpeedButtonImage;
    btnSIM: TSpeedButtonImage;
    btnSystemOn: TSpeedButtonImage;
    btnSystemReset: TSpeedButtonImage;
    btnPowerOff: TSpeedButtonImage;
    btnPowerOn: TSpeedButtonImage;
    btnLP: TSpeedButtonImage;
    Label28: TLabel;
    Panel5: TPanel;
    btnExtCompass: TSpeedButtonImage;
    Label31: TLabel;
    btnIntCompass: TSpeedButtonImage;
    Label30: TLabel;
    btnGyroOnOff: TSpeedButtonImage;
    Label29: TLabel;
    Timer1: TTimer;
    Panel4: TPanel;
    Label23: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label115: TLabel;
    lmpAnticonHeatingLamp: TShape;
    lmpReadyLP: TImage;
    imgLmpRadar: TImage;
    Image4: TImage;
    lmpComp: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    lmpExtCompass: TImage;
    lmpIntCompass: TImage;
    btnCompError: TSpeedButtonImage;
    btnDisplayError: TSpeedButtonImage;
    btnStabError: TSpeedButtonImage;
    btnSoftError: TSpeedButtonImage;
    img1: TImage;
    btnV1: TRzBmpButton;
    btn1: TRzBmpButton;
    btn2: TRzBmpButton;
    btn3: TRzBmpButton;
    btn4: TRzBmpButton;
    btn5: TRzBmpButton;
    btn6: TRzBmpButton;
    btn7: TRzBmpButton;
    btn8: TRzBmpButton;
    btn16: TRzBmpButton;
    lmp1: TImage;
    lmp2: TImage;
    lmp3: TImage;
    lmp4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnPowerOnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnLPClick(Sender: TObject);
    procedure btnSystemOnClick(Sender: TObject);

    procedure btnSoftErrorClick(Sender: TObject);
    procedure btnCompErrorClick(Sender: TObject);
    procedure btnDisplayErrorClick(Sender: TObject);
    procedure btnStabErrorClick(Sender: TObject);
//    procedure VL1Click(Sender: TObject);
    procedure btnSystemResetClick(Sender: TObject);
    procedure btnPowerOffClick(Sender: TObject);
    procedure btnExtCompassClick(Sender: TObject);
    procedure btnIntCompassClick(Sender: TObject);

    procedure btnGyroOnOffClick(Sender: TObject);

    procedure btnSIMClick(Sender: TObject);
    procedure btnNAVClick(Sender: TObject);
    procedure btnNOCASClick(Sender: TObject);
    procedure btnRELATIVEClick(Sender: TObject);
    procedure btnLINEUPClick(Sender: TObject);
    procedure btnANTIICEClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure btnV1Click(Sender: TObject);
  private
    { Private declarations }
    procedure KondisiOff;
        {added by bagus}
    procedure SystemOff;
    procedure SystemOn;

  public
    { Public declarations }
    MAGNETRON_COUNTER: Integer;
    LP_COUNTER: Integer;
    IsMagRDY: Boolean;
    IsStarting: Boolean;
    IsLoadingLP: Boolean;
    IsProgLoaded: Boolean;
    IsSysRDY: Boolean;
    IsGyroON: Boolean;
      procedure PowerOff;
  end;

implementation

uses ufWCCPanelAtas2, ufWCCPanelBawah, ufWCCPanelBawah2, ufWCCTengah, uAnduNala;

{$R *.dfm}

//**********************************************//
//      FORM EVENTS                             //
//**********************************************//

procedure TfrmWCCPanelAtas.FormCreate(Sender: TObject);
begin
  self.MAGNETRON_COUNTER := 0;
  self.LP_COUNTER := 0;
  IsMagRDY := False;
  BtnC.UpdateImage(lmpComp, BtnC.redROUND_Off);
  inherited;
//  Self.KondisiOff;
end;

procedure TfrmWCCPanelAtas.Timer1Timer(Sender: TObject);
begin

  If IsStarting then MAGNETRON_COUNTER := MAGNETRON_COUNTER + 1;
  If IsLoadingLP then LP_COUNTER := LP_COUNTER + 1;

  If (C_MAGNETRON_WAIT_TIME = MAGNETRON_COUNTER) and IsStarting then
  begin
    MAGNETRON_COUNTER := 0;
    IsStarting := False;
    IsMagRDY := True;
  end;

  If (C_LP_WAIT_TIME = LP_COUNTER) and IsLoadingLP then
  begin
    LP_COUNTER := 0;
    IsLoadingLP := False;
    IsProgLoaded := True;

    BtnC.UpdateImage(lmpReadyLP, BtnC.greenROUND_On);
    BtnC.UpdateBtnImage(btnLP, BtnC.orangeBOX_Off);
        BtnC.UpdateImage(lmpComp, BtnC.redROUND_Off);
  end;

  if IsMagRDY and IsProgLoaded and (ConsoleWCC.Radar.Status = RAD_OFF) then
    if (ConsoleWCC.SystemON = False) and ConsoleWCC.PowerON then
    begin
//    BtnC.UpdateBtnImage(TfrmWCCPanelAtas2(self.WCCInterface.frmWCCAtas2).btnRadarStandBy, BtnC.greenBOX_On);
      IsSysRDY := True;
      ConsoleWCC.Radar.Status := RAD_STANDBY;
//    BtnC.UpdateBtnImage(btnLP, BtnC.orangeBOX_Off);
    end;
end;

//**********************************************//
//      UPPER PANEL                             //
//**********************************************//

//procedure TfrmWCCPanelAtas.VL1Click(Sender: TObject);
//begin
//  ConsoleWCC.Saklar[TSpeedButtonImage(Sender).Tag] := TSpeedButtonImage(Sender).Down;
//end;

//**********************************************//
//      TECHNICAL CONTROL PANEL                 //
//**********************************************//

procedure TfrmWCCPanelAtas.btnSoftErrorClick(Sender: TObject);
begin
  Self.btnSoftError.Down := not Self.btnSoftError.Down;
end;

procedure TfrmWCCPanelAtas.btnCompErrorClick(Sender: TObject);
begin
  Self.btnCompError.Down := not Self.btnCompError.Down;
end;

procedure TfrmWCCPanelAtas.btnDisplayErrorClick(Sender: TObject);
begin
  Self.btnDisplayError.Down := not Self.btnDisplayError.Down;
end;

procedure TfrmWCCPanelAtas.btnStabErrorClick(Sender: TObject);
begin
  Self.btnStabError.Down := not Self.btnStabError.Down;
end;

//**********************************************//
//      MAIN SYSTEM SWITCHING                   //
//**********************************************//
procedure TfrmWCCPanelAtas.btnNAVClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnNAV, OrangeBOX);
  end;
end;

procedure TfrmWCCPanelAtas.btnNOCASClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnNOCAS, redBOX);
  end;
end;

procedure TfrmWCCPanelAtas.btnRELATIVEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnRELATIVE, OrangeBOX);
  end;
end;

procedure TfrmWCCPanelAtas.btnLINEUPClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnLINEUP, redBOX);
  end;
end;
procedure TfrmWCCPanelAtas.btnPowerOffClick(Sender: TObject);
begin
 if not ConsoleWCC.CekSaklar then  exit;
    PowerOff;

  //self.WCCInterface.test;
end;

procedure TfrmWCCPanelAtas.PowerOff;  {added by bagus}
begin
  { TAMPILAN BTN }
  btnPowerOff.Down := True;
  if btnPowerOff.Down then
  begin
    btnpoweroff.Glyph := BtnC.greenBOX_On;
    btnPowerOn.Glyph := BtnC.orangeBOX_Off;
    KondisiOff;
  end;
end;

procedure TfrmWCCPanelAtas.KondisiOff;
begin
  BtnC.UpdateBtnImage(btnPowerOff, BtnC.greenBOX_On); { Lampu power off }
  BtnC.UpdateBtnImage(btnPowerOn, BtnC.orangeBOX_Off);
  Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOn;
  BtnC.UpdateImage(lmpComp, BtnC.redROUND_Off);
  SystemOff;
end;

procedure TfrmWCCPanelAtas.btnPowerOnClick(Sender: TObject);
begin
  if WCCInterface.IsCompError then Exit;
  if not ConsoleWCC.CekSaklar then  exit;

  if ConsoleWCC.PowerON then begin
    SystemOff;
    IsStarting:=True;
    ConsoleWCC.PowerON := True;
    Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOff;
    (WCCInterface.frmTengah as TfrmWCCTengah).Map.BackColor := clBlack;
//    WCCInterface.DeleteAllTrack;
//    WCCInterface.ClearSIMObject;
    exit;
  end;

  { TAMPILAN BTN }
  btnPowerOn.Down := True;
  if btnPowerOn.Down then
   begin
    btnPowerOff.Glyph := BtnC.greenBOX_Off;
    btnPowerOn.Glyph := BtnC.orangeBOX_On;
    Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOff;
    BtnC.UpdateBtnImage(btnLP, BtnC.orangeBOX_Off);
    BtnC.UpdateImage(lmpComp, BtnC.redROUND_On);
    IsStarting:=True;
    ConsoleWCC.PowerON := True;
  end;
end;

procedure TfrmWCCPanelAtas.btnLPClick(Sender: TObject);
begin
  if not ConsoleWCC.CekSaklar then  exit;

  if not btnPowerOn.Down then begin
    btnLP.Down := False;
    Exit;
  end;

  BtnC.SpringLoaded(btnLP);
  BtnC.UpdateBtnImage(btnLP, BtnC.orangeBOX_On);
  if ConsoleWCC.PowerON then IsLoadingLP := True;
end;

procedure TfrmWCCPanelAtas.SystemOff;
var
  fA2: TfrmWCCPanelAtas2;
  fB:  TfrmWCCPanelBawah;
  fB2: TfrmWCCPanelBawah2;
  fAn: TfrmAndu;

begin
    BtnC.UpdateImage(lmpReadyLP, BtnC.greenROUND_Off); // Lmp Ready off
    fA2 := TfrmWCCPanelAtas2(WCCInterface.frmWCCAtas2);
    fB  := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);
    fB2 := TfrmWCCPanelBawah2(WCCInterface.frmWCCBawah2);
    fAn := TfrmAndu(WCCInterface.frmAnduNala);

    if WCCInterface.IsFireControlInUse(1) then
      WCCInterface.ShowAScope(atoBreak);

    WCCInterface.DeleteAllTrack;
    WCCInterface.ClearSIMObject;

    fB2.SetOffBtnAndIndikator;


    btnSystemOn.Down := False;
    BtnC.UpdateLockBtnImage(btnSystemOn, greenBOX);
    btnSIM.Down := False;
    BtnC.UpdateLockBtnImage(btnSIM, OrangeBOX);
    BtnC.UpdateImage(lmpReadyLP , BtnC.greenROUND_Off);
    btnLP.Down := False;
    BtnC.UpdateLockBtnImage(btnLP, OrangeBOX);

    ConsoleWCC.SystemON := False;
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_Off);
    (WCCInterface.frmTengah as TfrmWCCTengah).Map.BackColor := clBlack;
    // Siap Track
    BtnC.UpdateBtnImage(fB.btnSBA, BtnC.sgreenBOX_Off);
    BtnC.UpdateBtnImage(fB2.btnFC2SBS, BtnC.sgreenBOX_Off);
    BtnC.UpdateBtnImage(fB2.btnFC3SBS, BtnC.sgreenBOX_Off);
    // Gun1 Siap
    BtnC.UpdateImage(fA2.lmpRPCRDY, BtnC.greenROUND_Off);
    BtnC.UpdateImage(fA2.lmpRMAGRDY, BtnC.greenROUND_Off);
    BtnC.UpdateImage(fA2.lmpLMAGRDY, BtnC.greenROUND_Off);

    //****************
    //Radar siap
    with fa2 do
    begin
      btnRadarStandBy.Glyph:= BtnC.greenBOX_Off; // Btn Standby off

      //btnHORSCAN.Click;
      btnHORSCAN.Glyph := BtnC.greenBOX_Off;
      btnHELSCAN.Glyph := BtnC.greenBOX_Off;
      BtnC.UpdateImage(TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1).lmpHORSCAN, BtnC.sgreenROUND_Off);

      btnRadarAlarm.Glyph := BtnC.redBOX_Off;
      btnRadarAlarm.Down  := false;

      //btnHORPOL.Click;
      btnHORPOL.Glyph := BtnC.greenBOX_Off;
      btnCIRCPOL.Glyph := BtnC.greenBOX_Off;

     // btnFIXFREQ.Click;
      btnFREQAGIL.Glyph := BtnC.greenBOX_Off;
      btnFIXFREQ.Glyph  := BtnC.greenBOX_Off;

      //btnLOWPRF.Click;
      btnLOWPRF.Glyph := BtnC.greenBOX_Off;
      btnHIGHPRF.Glyph := BtnC.greenBOX_Off;

      btnFREQ1.Click;

      btnRadarRadiate.Down  := False;
      btnRadarRadiate.Glyph := BtnC.greenBOX_Off;

      btnFREQ1.Down := false;
      btnFREQ2.Down := false;
      btnFREQ3.Down := false;
      btnFREQ4.Down := false;
      btnFREQ5.Down := false;

      btnFREQ1.Glyph := BtnC.greenBOX_Off;
      btnFREQ2.Glyph := BtnC.greenBOX_Off;
      btnFREQ3.Glyph := BtnC.greenBOX_Off;
      btnFREQ4.Glyph := BtnC.greenBOX_Off;
      btnFREQ5.Glyph := BtnC.greenBOX_Off;

      //btnRadarRadiate.Click;

      btnLIN.Down:= False;
      BtnC.UpdateLockBtnImage(btnLIN, greenBOX);
      btnLOG.Down:= False;
      BtnC.UpdateLockBtnImage(btnLOG, greenBOX);

      // btn GUn 2 & 3
      btnG2ON.down := false;
      btnG2OFF.down := false;
      btnG3ON.down := false;
      btnG3OFF.down := false;
      btnG2ON.Glyph := BtnC.greenBOX_Off;
      btnG2OFF.Glyph := BtnC.greenBOX_Off;
      btnG3ON.Glyph := BtnC.greenBOX_Off;
      btnG3OFF.Glyph := BtnC.greenBOX_Off;

    end;

    WCCInterface.SetRadarOnOff(False);
    WCCInterface.ActiveRadar.Radiate  := False;
    ConsoleWCC.Radar.Status           := RAD_OFF;
    ConsoleWCC.Radar.ScanType         := SCAN_OFF;
    ConsoleWCC.Radar.Polarization     := POL_OFF;
    ConsoleWCC.Radar.FreqType         := FREQ_OFF;
    ConsoleWCC.Radar.PRF              := PRF_OFF;
    ConsoleWCC.Radar.FreqBand         := BAND_OFF;

    with fb do
    begin
      btnWMnonMTI.Click;
      spbSetRange32.Click;

      btnAIR.Down       :=  False;
      btnSURF.Down      :=  False;
      btnEW.Down        :=  False;
      btnMS.Down        :=  False;
      btnCOURSE.Down    :=  False;
      btnAMPLINFO.Down  :=  False;
      btnTN.Down        :=  False;

      //btnLINK.Down := true;
      btnAIR.Glyph      :=  BtnC.sgreenBOX_Off;
      btnSURF.Glyph     :=  BtnC.sgreenBOX_Off;
      btnEW.Glyph       :=  BtnC.sgreenBOX_Off;
      btnMS.Glyph       :=  BtnC.sgreenBOX_Off;
      btnCOURSE.Glyph   :=  BtnC.sgreenBOX_Off;
      btnAMPLINFO.Glyph :=  BtnC.sgreenBOX_Off;
      btnTN.Glyph       :=  BtnC.sgreenBOX_Off;

      spbSetRange2.Down := False;
      spbSetRange4.Down := False;
      spbSetRange8.Down := False;
      spbSetRange16.Down := False;
      spbSetRange32.Down := False;
      spbSetRange64.Down := False;
      spbSetRange128.Down := False;

      spbSetRange2.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange4.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange8.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange16.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange32.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange64.Glyph := BtnC.sgreenBOX_Off;
      spbSetRange128.Glyph := BtnC.sgreenBOX_Off;

      btnDAMTI.Down := False;
      btnDALIN.Down := False;
      btnDALOG.Down := False;
      btnWMnonMTI.Down := False;
      btnWMMTI.Down := False;

      btnDAMTI.Glyph := BtnC.sgreenBOX_Off;
      btnDALIN.Glyph := BtnC.sgreenBOX_Off;
      btnDALOG.Glyph := BtnC.sgreenBOX_Off;
      btnWMnonMTI.Glyph := BtnC.sgreenBOX_Off;
      btnWMMTI.Glyph := BtnC.sgreenBOX_Off;
    end;

    with fB2 do begin
      btnFC3_B.Down := False;
      btnFC3_B.Click;
      btnFC2_B.Down := False;
      btnFC2_B.Click;

    end;
    with fAn do begin
      Reset_Andu_Button;
      tvshow
    end;

    lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOn;

    IsMagRDY            := false;
    IsStarting          := false;
    IsLoadingLP         := false;
    IsProgLoaded        := false;
    IsSysRDY            := false;
    IsGyroON            := false;
    MAGNETRON_COUNTER   := 0;
    LP_COUNTER          := 0;
    ConsoleWCC.PowerON  := False;
    ConsoleWCC.SystemON := False;
end;

procedure TfrmWCCPanelAtas.SystemOn;
var
  fA2: TfrmWCCPanelAtas2;
  fB: TfrmWCCPanelBawah;
  fB2: TfrmWCCPanelBawah2;
begin
    if ConsoleWCC.PowerON and IsProgLoaded and IsSysRDY then
  begin
    { TAMPILAN BTN }
    fA2 := TfrmWCCPanelAtas2(WCCInterface.frmWCCAtas2);
    fB := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);
    fB2 := TfrmWCCPanelBawah2(WCCInterface.frmWCCBawah2);

    // edit by bagus
    btnSystemOn.Down := True;
    BtnC.UpdateLockBtnImage(btnSystemOn, greenBOX);

    ConsoleWCC.SystemON := True;
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_On);
    // Siap Track
    BtnC.UpdateBtnImage(fB.btnSBA, BtnC.sgreenBOX_On);
    BtnC.UpdateBtnImage(fB2.btnFC2SBS, BtnC.sgreenBOX_On);
    BtnC.UpdateBtnImage(fB2.btnFC3SBS, BtnC.sgreenBOX_On);
    // Gun1 Siap


    //****************
    //Radar siap
    with fa2 do
    begin

      //Radar siap
      btnHORSCAN.Click;
      btnHORPOL.Click;
      btnFIXFREQ.Click;
      btnLOWPRF.Click;
      btnFREQ1.Click;
      btnLIN.Click;
      btnRadarStandByClick(self);

      // Gun Indikator Siap
      BtnC.UpdateImage(lmpRPCRDY, BtnC.greenROUND_On);
      BtnC.UpdateImage(lmpG3SYNC , BtnC.greenROUND_On);
      BtnC.UpdateImage(lmpG2SYNC , BtnC.greenROUND_On);
      BtnC.UpdateImage(lmpRMAGRDY , BtnC.greenROUND_On);
      BtnC.UpdateImage(lmpComp, BtnC.redROUND_Off);

    end;

    //****************
    //Display option

    with fb do
    begin
      btnWMnonMTI.Click;
      spbSetRange32.Click;

      btnAIR.Down := true;
      btnAIR.Click;
      btnSURF.Down := true;
      btnSURF.Click;
      btnEW.Down := true;
      btnEW.Click;

      btnMS.Down := true;
      btnMS.Click;
      btnCOURSE.Down := true;
      btnCOURSE.Click;
      btnAMPLINFO.Down := true;
      btnAMPLINFO.Click;
      //btnLINK.Down := true;
      btnTN.Down := true;
      btnTN.Click;

      btnWMnonMTI.Down := true;
      btnWMnonMTI.Click;
      btnWMnonMTI.Glyph := BtnC.sgreenBOX_On;

    end;

  end
end;

procedure TfrmWCCPanelAtas.btnSystemOnClick(Sender: TObject);
begin
  SystemOn;
end;

procedure TfrmWCCPanelAtas.btnSystemResetClick(Sender: TObject);
var b: Boolean;
begin
  BtnC.SpringLoaded(btnSystemReset);
  {b := ConsoleWCC.CekSaklar();
  if b = True then self.Caption := 'True'
  else self.Caption := 'False';}

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.SystemReset;
  end;

end;

procedure TfrmWCCPanelAtas.btnV1Click(Sender: TObject);
begin
  //inherited;
  ConsoleWCC.Saklar[TRzBmpButton(Sender).Tag] := TRzBmpButton(Sender).Down;
  if ConsoleWCC.CekSaklar then
     btnpoweroff.Glyph := BtnC.greenBOX_On
  else begin
    btnPowerOff.Down := True;
    PowerOff;
    btnpoweroff.Glyph := BtnC.greenBOX_Off;
  end;

end;

procedure TfrmWCCPanelAtas.btnANTIICEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
     { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnANTIICE, orangeBOX);
  end;
end;

procedure TfrmWCCPanelAtas.btnSIMClick(Sender: TObject);
begin
  //SpringLoaded(btnSIM);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    BtnC.UpdateLockBtnImage(btnSIM, OrangeBOX);
    WCCInterface.CreateSIMObject(btnSIM.Down);
  end;
end;

//**********************************************//
//      STABILISATION CONTROL PANEL             //
//**********************************************//
procedure TfrmWCCPanelAtas.btnExtCompassClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnExtCompass);
  if IsGyroON then
  begin
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_On);
    BtnC.UpdateImage(lmpIntCompass, BtnC.greenROUND_Off);
  end;
end;

procedure TfrmWCCPanelAtas.btnIntCompassClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnIntCompass);
  if IsGyroON then
  begin
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_Off);
    BtnC.UpdateImage(lmpIntCompass, BtnC.greenROUND_On);
  end;
end;

procedure TfrmWCCPanelAtas.btnGyroOnOffClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if sender.ClassType = TLabel then btnGyroOnOff.Down := not btnGyroOnOff.Down;
    BtnC.UpdateLockBtnImage(btnGyroOnOff, GreenBOX);

    IsGyroON := btnGyroOnOff.Down;
  end;
end;      

procedure TfrmWCCPanelAtas.FormShow(Sender: TObject);
begin
  self.Timer1.Enabled := True;
end;

end.
