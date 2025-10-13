unit ufBawahKiri_Cakra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, ImgList, StdCtrls,
  VrControls, VrRotarySwitch, VrWheel,
  uLibWCCku, uLibWCCClassNew;

type
  TfrmBawahKiri_Cakra = class(TForm)
    Panel1: TPanel;
    SpeedButtonImage28: TSpeedButtonImage;
    Panel2: TPanel;
    btnIN_ATT: TSpeedButtonImage;
    btnIN_NAV: TSpeedButtonImage;
    btnIN_RAD: TSpeedButtonImage;
    btnR_DOWN: TSpeedButtonImage;
    btnR_UP: TSpeedButtonImage;
    Label44: TLabel;
    btnATrack: TSpeedButtonImage;
    btnBTrack: TSpeedButtonImage;
    btnCTrack: TSpeedButtonImage;
    btnDTrack: TSpeedButtonImage;
    btnETrack: TSpeedButtonImage;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Label23: TLabel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    btnSenASonar: TSpeedButtonImage;
    btnSenCSU: TSpeedButtonImage;
    btnSenPRS: TSpeedButtonImage;
    btnSenPRSPos: TSpeedButtonImage;
    btnSenCU: TSpeedButtonImage;
    btnSenATT1: TSpeedButtonImage;
    btnSenATT2: TSpeedButtonImage;
    btnSenATT3: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label14: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    btnDisSonar: TSpeedButtonImage;
    btnDisPRS: TSpeedButtonImage;
    btnDisAPeriskop: TSpeedButtonImage;
    btnDisNPeriskop: TSpeedButtonImage;
    btnDisINML: TSpeedButtonImage;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    VrRotarySwitch3: TVrRotarySwitch;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch5: TVrRotarySwitch;
    btnAPD: TSpeedButtonImage;
    btnBDD: TSpeedButtonImage;
    btnERBD1: TSpeedButtonImage;
    btnERBD2: TSpeedButtonImage;
    btnERPD: TSpeedButtonImage;
    btnREIN: TSpeedButtonImage;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Label29: TLabel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Shape1: TShape;
    SpeedButtonImage38: TSpeedButtonImage;
    SpeedButtonImage34: TSpeedButtonImage;
    SpeedButtonImage35: TSpeedButtonImage;
    SpeedButtonImage36: TSpeedButtonImage;
    SpeedButtonImage37: TSpeedButtonImage;
    Label45: TLabel;
    wLeft: TVrWheel;
    wRight: TVrWheel;
    VrRotarySwitch6: TVrRotarySwitch;
    btnRR: TSpeedButtonImage;
    Button1: TButton;
    Edit1: TEdit;
    procedure btnTrackSelClick(Sender: TObject);
    procedure btnTMADClick(Sender: TObject);
    procedure btnATrackClick(Sender: TObject);
    procedure btnBTrackClick(Sender: TObject);
    procedure btnCTrackClick(Sender: TObject);
    procedure btnDTrackClick(Sender: TObject);
    procedure btnETrackClick(Sender: TObject);
    procedure btnR_DOWNClick(Sender: TObject);
    procedure btnR_UPClick(Sender: TObject);
    procedure btnRRClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WCCInterface: TGenericWCCInterface;

  end;

implementation

{$R *.dfm}

procedure TfrmBawahKiri_Cakra.btnTrackSelClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateButton(btnATrack, TBSpring, RedBOX, TBOff);
    BtnC.UpdateButton(btnBTrack, TBSpring, RedBOX, TBOff);
    BtnC.UpdateButton(btnCTrack, TBSpring, RedBOX, TBOff);
    BtnC.UpdateButton(btnDTrack, TBSpring, RedBOX, TBOff);
    BtnC.UpdateButton(btnETrack, TBSpring, RedBOX, TBOff);

    case TSpeedButtonImage(Sender).Tag of
    1: BtnC.UpdateButton(btnATrack, TBLock, RedBOX, TBOn);
    2: BtnC.UpdateButton(btnBTrack, TBLock, RedBOX, TBOn);
    3: BtnC.UpdateButton(btnCTrack, TBLock, RedBOX, TBOn);
    4: BtnC.UpdateButton(btnDTrack, TBLock, RedBOX, TBOn);
    5: BtnC.UpdateButton(btnETrack, TBLock, RedBOX, TBOn);
    end;
  end;
end;

procedure TfrmBawahKiri_Cakra.btnTMADClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateButton(btnAPD, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnBDD, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnERBD1, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnERBD2, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnERPD, TBLock, RedBOX, TBOff);

    case TSpeedButtonImage(Sender).Tag of
    1: WCCInterface.SetTMADView(ttAPD);
    2: WCCInterface.SetTMADView(ttBDD);
    3: WCCInterface.SetTMADView(ttERBD1);
    4: WCCInterface.SetTMADView(ttERBD2);
    5: WCCInterface.SetTMADView(ttERPD);
    end;

    BtnC.UpdateButton((Sender as TSpeedButtonImage), TBLock, RedBOX, TBOn);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnSenSelClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateButton(btnSenASonar, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnSenCSU, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnSenPRS, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnSenPRSPos, TBLock, RedBOX, TBOff);
    BtnC.UpdateButton(btnSenCU, TBLock, RedBOX, TBOff);

    case TSpeedButtonImage(Sender).Tag of
    1: BtnC.UpdateButton(btnSenASonar, TBLock, RedBOX, TBOn);
    2: BtnC.UpdateButton(btnSenCSU, TBLock, RedBOX, TBOn);
    3: BtnC.UpdateButton(btnSenPRS, TBLock, RedBOX, TBOn);
    4: BtnC.UpdateButton(btnSenPRSPos, TBLock, RedBOX, TBOn);
    5: BtnC.UpdateButton(btnSenCU, TBLock, RedBOX, TBOn);
    end;

    BtnC.UpdateButton((Sender as TSpeedButtonImage), TBLock, RedBOX, TBOn);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnATrackClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnATrack, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnBTrackClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnBTrack, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnCTrackClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnCTrack, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnDTrackClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnDTrack, RedBOX);
  end;
end;          

procedure TfrmBawahKiri_Cakra.btnETrackClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnETrack, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnR_DOWNClick(Sender: TObject);
var RNow: double;
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    RNow := WCCInterface.FTDCRangeScale;
    if RNow > 4 then begin
      RNow := RNow / 2;
      WCCInterface.SetView_RangeScale(RNow);
      WCCInterface.TMADStatus2.RangeStatusDisplay := FloatToStr(RNow);
    end;
  end;
end;

procedure TfrmBawahKiri_Cakra.btnR_UPClick(Sender: TObject);
var RNow: double;
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    RNow := WCCInterface.FTDCRangeScale;
    if RNow < 64 then begin
      RNow := RNow * 2;
      WCCInterface.SetView_RangeScale(RNow);
      WCCInterface.TMADStatus2.RangeStatusDisplay := FloatToStr(RNow);
    end;
  end;
end;

procedure TfrmBawahKiri_Cakra.btnRRClick(Sender: TObject);
begin
  BtnC.UpdateLockBtnImage(btnRR, greenBOX);
  WCCInterface.SetRadar_RangeRing(btnRR.Down);
end;

procedure TfrmBawahKiri_Cakra.Button1Click(Sender: TObject);
begin
  WCCInterface.testSinbad(Edit1.Text);
end;

procedure TfrmBawahKiri_Cakra.btnDisSonarClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnDisSonar, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnDisPRSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnDisPRS, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnDisAPeriskopClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnDisAPeriskop, RedBOX);
  end;
end;

procedure TfrmBawahKiri_Cakra.btnDisNPeriskopClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    // lockbutton
    BtnC.UpdateLockBtnImage(btnDisNPeriskop, RedBOX);
  end;
end;

end.
