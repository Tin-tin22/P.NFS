unit ufAtas_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, SpeedButtonImage, ExtCtrls, StdCtrls,
  VrControls, VrRotarySwitch, VrBlinkLed,

  ComCtrls,
  uLibWCCClassNew, uTDCConstan, uLibWCCKu, uBaseConstan,
  ufQEK;

type
  TfrmAtas_Singa = class(TfrmQEK)
    Timer1: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Image23: TImage;
    SpeedButtonImage75: TSpeedButtonImage;
    Panel2: TPanel;
    Image10: TImage;
    Image9: TImage;
    Image8: TImage;
    Image7: TImage;
    Image5: TImage;
    Image4: TImage;
    Image33: TImage;
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
    btnCompError: TSpeedButtonImage;
    btnDisplayError: TSpeedButtonImage;
    btnStabError: TSpeedButtonImage;
    btnSoftError: TSpeedButtonImage;
    Panel3: TPanel;
    lmpReadyLP: TImage;
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
    Label115: TLabel;
    lmpAnticonHeatingLamp: TShape;
    Panel5: TPanel;
    lmpIntCompass: TImage;
    lmpExtCompass: TImage;
    btnExtCompass: TSpeedButtonImage;
    Label31: TLabel;
    btnIntCompass: TSpeedButtonImage;
    Label30: TLabel;
    btnGyroOnOff: TSpeedButtonImage;
    Label29: TLabel;
    Panel4: TPanel;
    VL1: TSpeedButtonImage;
    VL8: TSpeedButtonImage;
    VL6: TSpeedButtonImage;
    VL7: TSpeedButtonImage;
    VL2: TSpeedButtonImage;
    VL5: TSpeedButtonImage;
    VL3: TSpeedButtonImage;
    VL4: TSpeedButtonImage;
    VL9: TSpeedButtonImage;
    VL10: TSpeedButtonImage;
    VL11: TSpeedButtonImage;
    VL12: TSpeedButtonImage;
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
    Label95: TLabel;
    Label96: TLabel;
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
    Label112: TLabel;
    Label113: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPowerOnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnLPClick(Sender: TObject);
    procedure btnSystemOnClick(Sender: TObject);

    procedure btnSoftErrorClick(Sender: TObject);
    procedure btnCompErrorClick(Sender: TObject);
    procedure btnDisplayErrorClick(Sender: TObject);
    procedure btnStabErrorClick(Sender: TObject);
    procedure VL1Click(Sender: TObject);
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
  private
    { Private declarations }
    procedure KondisiOff;

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

  end;

implementation

uses ufAtas2_Singa, ufBawah_Singa, ufBawah2_Singa;

{$R *.dfm}

var
  TIMER_COUNTER: Integer = 0;

//**********************************************//
//      FORM EVENTS                             //
//**********************************************//
procedure TfrmAtas_Singa.FormCreate(Sender: TObject);
begin
  self.MAGNETRON_COUNTER := 0;
  self.LP_COUNTER := 0;
  IsMagRDY := False;
  
  inherited;

  Self.KondisiOff;
end;

procedure TfrmAtas_Singa.Timer1Timer(Sender: TObject);
begin
  //Inc(TIMER_COUNTER,1);

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
  end;

  if IsMagRDY and IsProgLoaded and (ConsoleWCC.Radar.Status = RAD_OFF) then
    if (ConsoleWCC.SystemON = False) and ConsoleWCC.PowerON then
    begin
      BtnC.UpdateBtnImage(TfrmAtas2_Singa(self.WCCInterface.frmWCCAtas2).btnRadarStandBy, BtnC.greenBOX_On);
      IsSysRDY := True;
      ConsoleWCC.Radar.Status := RAD_STANDBY;
    end;

  //self.Caption := IntToStr(TIMER_COUNTER);
end;

procedure TfrmAtas_Singa.KondisiOff;
begin
  BtnC.UpdateBtnImage(btnPowerOff, BtnC.greenBOX_On); { Lampu power off }
  Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOn;

  ConsoleWCC.PowerON := False;
  ConsoleWCC.SystemON := False;
end;

//**********************************************//
//      UPPER PANEL                             //
//**********************************************//

procedure TfrmAtas_Singa.VL1Click(Sender: TObject);
begin
  ConsoleWCC.Saklar[TSpeedButtonImage(Sender).Tag] := TSpeedButtonImage(Sender).Down;
end;

//**********************************************//
//      TECHNICAL CONTROL PANEL                 //
//**********************************************//

procedure TfrmAtas_Singa.btnSoftErrorClick(Sender: TObject);
begin
  Self.btnSoftError.Down := not Self.btnSoftError.Down;
end;

procedure TfrmAtas_Singa.btnCompErrorClick(Sender: TObject);
begin
  Self.btnCompError.Down := not Self.btnCompError.Down;
end;

procedure TfrmAtas_Singa.btnDisplayErrorClick(Sender: TObject);
begin
  Self.btnDisplayError.Down := not Self.btnDisplayError.Down;
end;

procedure TfrmAtas_Singa.btnStabErrorClick(Sender: TObject);
begin
  Self.btnStabError.Down := not Self.btnStabError.Down;
end;

//**********************************************//
//      MAIN SYSTEM SWITCHING                   //
//**********************************************//
procedure TfrmAtas_Singa.btnNAVClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnNAV, OrangeBOX);
  end;
end;

procedure TfrmAtas_Singa.btnNOCASClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnNOCAS, redBOX);
  end;
end;

procedure TfrmAtas_Singa.btnRELATIVEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnRELATIVE, OrangeBOX);
  end;
end;

procedure TfrmAtas_Singa.btnLINEUPClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
    { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnLINEUP, redBOX);
  end;
end;
procedure TfrmAtas_Singa.btnPowerOffClick(Sender: TObject);
begin
  { TAMPILAN BTN }
  btnPowerOff.Down := True;
  if btnPowerOff.Down then
  begin
    btnpoweroff.Glyph := BtnC.greenBOX_On;
    btnPowerOn.Glyph := BtnC.orangeBOX_Off;
  end;

  //self.WCCInterface.test;

end;
procedure TfrmAtas_Singa.btnPowerOnClick(Sender: TObject);
begin
  if ConsoleWCC.CekSaklar then
  begin
    { TAMPILAN BTN }
    btnPowerOn.Down := True;
    if btnPowerOn.Down then
    begin
      btnPowerOff.Glyph := BtnC.greenBOX_Off;
      btnPowerOn.Glyph := BtnC.orangeBOX_On;
      Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOff;
      BtnC.UpdateBtnImage(btnLP, BtnC.orangeBOX_On);

      IsStarting:=True;
      ConsoleWCC.PowerON := True;

      //self.WCCInterface.CreateManTrack;
    end;
  end;
end;

procedure TfrmAtas_Singa.btnLPClick(Sender: TObject);
begin
  btnLP.Down := True;
  BtnC.SpringLoaded(btnLP);
  if ConsoleWCC.PowerON then IsLoadingLP := True;
end;

procedure TfrmAtas_Singa.btnSystemOnClick(Sender: TObject);
var
  fA2: TfrmAtas2_Singa;
  fB: TfrmBawah_Singa;
  fB2: TfrmBawah2_Singa;
begin
  if ConsoleWCC.PowerON and IsProgLoaded and IsSysRDY then
  begin
    fA2 := TfrmAtas2_Singa(WCCInterface.frmWCCAtas2);
    fB := TfrmBawah_Singa(WCCInterface.frmWCCBawah1);
    fB2 := TfrmBawah2_Singa(WCCInterface.frmWCCBawah2);

    { TAMPILAN BTN }
    btnSystemOn.Down := True;
    BtnC.UpdateLockBtnImage(btnSystemOn, greenBOX);

    ConsoleWCC.SystemON := True;
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_On);
    // Siap Track
    BtnC.UpdateBtnImage(fB.btnSBA, BtnC.greenBOX_On);
    BtnC.UpdateBtnImage(fB2.btnFC2SBS, BtnC.greenBOX_On);
    BtnC.UpdateBtnImage(fB2.btnFC3SBS, BtnC.greenBOX_On);
    // Gun1 Siap
    BtnC.UpdateImage(fA2.lmpG1REMOTE, BtnC.greenROUND_On);
    BtnC.UpdateImage(fA2.lmpG1RDY, BtnC.greenROUND_On);

    //****************
    //Radar siap
    fa2.btnHORSCAN.Click;
    fa2.btnHORPOL.Click;
    fa2.btnFIXFREQ.Click;
    fa2.btnLOWPRF.Click;
    fa2.btnFREQ1.Click;
    //fA2.btnRadarRadiate.Click;

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
      //btnEW.Down := true;
      //btnEW.Click;

      //btnMS.Down := true;
      //btnMS.Click;
      //btnCOURSE.Down := true;
      //btnCOURSE.Click;
      //btnAMPLINFO.Down := true;
      //btnAMPLINFO.Click;
      //btnLINK.Down := true;
      //btnTN.Down := true;
      //btnTN.Click;
    end;
  end;  
end;

procedure TfrmAtas_Singa.btnSystemResetClick(Sender: TObject);
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

procedure TfrmAtas_Singa.btnANTIICEClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON then
  begin
     { TAMPILAN BTN }
    BtnC.UpdateLockBtnImage(btnANTIICE, orangeBOX);
  end;
end;

procedure TfrmAtas_Singa.btnSIMClick(Sender: TObject);
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
procedure TfrmAtas_Singa.btnExtCompassClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnExtCompass);
  if IsGyroON then
  begin
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_On);
    BtnC.UpdateImage(lmpIntCompass, BtnC.greenROUND_Off);
  end;
end;

procedure TfrmAtas_Singa.btnIntCompassClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnIntCompass);
  if IsGyroON then
  begin
    BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_Off);
    BtnC.UpdateImage(lmpIntCompass, BtnC.greenROUND_On);
  end;
end;

procedure TfrmAtas_Singa.btnGyroOnOffClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if sender.ClassType = TLabel then btnGyroOnOff.Down := not btnGyroOnOff.Down;
    BtnC.UpdateLockBtnImage(btnGyroOnOff, GreenBOX);

    IsGyroON := btnGyroOnOff.Down;
  end;
end;

procedure TfrmAtas_Singa.FormShow(Sender: TObject);
begin
  self.Timer1.Enabled := True;
end;

end.
