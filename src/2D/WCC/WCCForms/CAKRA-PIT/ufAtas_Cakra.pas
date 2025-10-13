unit ufAtas_Cakra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, SpeedButtonImage, ImgList,
  uLibWCCClassNew, uLibWCCku,
  uBaseConstan;

type
  TfrmAtas_Cakra = class(TForm)
    Panel1: TPanel;
    ILREDBOX: TImageList;
    ILREDROUND: TImageList;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    GroupBox2: TGroupBox;
    SpeedButtonImage10: TSpeedButtonImage;
    btnLP: TSpeedButtonImage;
    btnSystemReset: TSpeedButtonImage;
    btnPowerOn: TSpeedButtonImage;
    btnSystemOn: TSpeedButtonImage;
    btnPowerOff: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    GroupBox3: TGroupBox;
    Label59: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    lmpFC2RDY: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label68: TLabel;
    lmpReadyLP: TImage;
    ILORANGEBOX: TImageList;
    ILGREENBOX: TImageList;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    lmpAnticonHeatingLamp: TShape;
    Timer1: TTimer;
    btnTMAD: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    rb1: TRadioButton;
    rb2: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnTMADClick(Sender: TObject);
    procedure btnPowerOnClick(Sender: TObject);
    procedure btnSystemOnClick(Sender: TObject);
    procedure btnPowerOffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonImage1Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure SpeedButtonImage10Click(Sender: TObject);
  private
    { Private declarations }
    procedure KondisiOn;
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

    WCCInterface : TGenericWCCInterface;
  end;

implementation

uses
  uLibTDCTracks, uTDCConstan;
{$R *.dfm}

procedure TfrmAtas_Cakra.FormCreate(Sender: TObject);
begin
  MAGNETRON_COUNTER := 0;
  LP_COUNTER := 0;
  IsMagRDY := False;

  ConsoleWCC := TWcc.Create;
  Self.KondisiOff;
end;

procedure TfrmAtas_Cakra.KondisiOn;
begin
  {WCCInterface.SetRadarOnOff(True);
  WCCInterface.ActiveRadar.Radiate := True;
  WCCInterface.ActiveRadar.TimeBaseView.BackgroundVisible := False;
  WCCInterface.ActiveRadar.TimeBaseView.TimeBaseVisible := False;}

  WCCInterface.SetAllEchoOff;
end;

procedure TfrmAtas_Cakra.KondisiOff;
begin
  BtnC.UpdateBtnImage(btnPowerOff, BtnC.greenBOX_On); { Lampu power off }
  Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOn;

  ConsoleWCC.PowerON := False;
  ConsoleWCC.SystemON := False;
end;

procedure TfrmAtas_Cakra.Timer1Timer(Sender: TObject);
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
      //BtnC.UpdateBtnImage(TfrmWCCPanelAtas2(self.WCCInterface.frmWCCAtas2).btnRadarStandBy, BtnC.greenBOX_On);
      IsSysRDY := True;
      ConsoleWCC.Radar.Status := RAD_STANDBY;
    end;

  //self.Caption := IntToStr(TIMER_COUNTER);
end;

procedure TfrmAtas_Cakra.btnTMADClick(Sender: TObject);
begin
  WCCInterface.SetTMADStatus(True, 1);
  WCCInterface.SetTMADStatus(True, 2);
end;

procedure TfrmAtas_Cakra.btnPowerOnClick(Sender: TObject);
var stat: TBtnStatus;
begin
  stat := TBOn;
  BtnC.UpdateButton(btnPowerOn, TBLock, OrangeBOX, stat);
  case stat of
    TBOn: begin
      BtnC.UpdateButton(btnPowerOff, TBLock, OrangeBOX, TbOff);
      Self.lmpAnticonHeatingLamp.Brush.Color := BtnC.HeatLampOff;
      BtnC.UpdateButton(btnLP, TBSpring, OrangeBOX, TbOn);

      IsStarting:=True;
      ConsoleWCC.PowerON := True;
    end;
  end;
end;

procedure TfrmAtas_Cakra.btnLPClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnLP);
  if ConsoleWCC.PowerON then IsLoadingLP := True;
end;

procedure TfrmAtas_Cakra.btnSystemOnClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and IsProgLoaded and IsSysRDY then
  begin
    //fA2 := TfrmWCCPanelAtas2(WCCInterface.frmWCCAtas2);
    //fB := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);
    //fB2 := TfrmWCCPanelBawah2(WCCInterface.frmWCCBawah2);

    { TAMPILAN BTN }
    BtnC.UpdateButton(btnSystemOn, TBLock, GreenBOX, TBOn);
    ConsoleWCC.SystemON := True;

    //BtnC.UpdateImage(lmpExtCompass, BtnC.greenROUND_On);
    // Siap Track
    //UpdateBtnImage(fB.btnSBA, BtnC.greenBOX_On);
    //UpdateBtnImage(fB2.btnFC2SBS, BtnC.greenBOX_On);
    //UpdateBtnImage(fB2.btnFC3SBS, BtnC.greenBOX_On);
    // Gun1 Siap
    //WCCInterface.Gun1.PowerOn := true;
    //WCCInterface.Gun1.ReadyToFire := True;
    //UpdateImage(fA2.lmpRPCRDY, BtnC.greenROUND_On);
    //UpdateImage(fA2.lmpRMAGRDY, BtnC.greenROUND_On);
    //UpdateImage(fA2.lmpLMAGRDY, BtnC.greenROUND_On);

    //****************
    //Radar siap
    {fa2.btnHORSCAN.Click;
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
    end;}

    KondisiOn;
  end;
end;

procedure TfrmAtas_Cakra.btnPowerOffClick(Sender: TObject);
begin
  btnPowerOff.Down := True;
  if btnPowerOff.Down then
  begin
    btnpoweroff.Glyph := BtnC.greenBOX_On;
    btnPowerOn.Glyph := BtnC.orangeBOX_Off;
  end;
end;

procedure TfrmAtas_Cakra.FormShow(Sender: TObject);
begin
  self.Timer1.Enabled := True;
end;

procedure TfrmAtas_Cakra.SpeedButtonImage1Click(Sender: TObject);
begin
  ConsoleWCC.PowerOn := True;
  IsProgLoaded := True;
  IsSysRDY := True;

  self.btnSystemOnClick(nil);
end;

procedure TfrmAtas_Cakra.rb1Click(Sender: TObject);
begin
  WCCInterface.SetView_RangeScale(4);
end;

procedure TfrmAtas_Cakra.rb2Click(Sender: TObject);
begin
  WCCInterface.SetView_RangeScale(8);
end;



procedure TfrmAtas_Cakra.SpeedButtonImage10Click(Sender: TObject);
begin
  BtnC.UpdateLockBtnImage(SpeedButtonImage10, OrangeBOX);
end;

end.
