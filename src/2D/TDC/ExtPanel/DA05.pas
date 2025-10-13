unit DA05;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrRotarySwitch, Buttons, SpeedButtonImage, ExtCtrls,
  StdCtrls, ImgList, VrDesign, VrBlinkLed, VrWheel, VrTrackBar,
  uLibTDCClass;

type
  TFrm_DA05 = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    Image9: TImage;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Image2: TImage;
    Image3: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    VrRotaryTSpeed: TVrRotarySwitch;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Panel2: TPanel;
    Orange: TImageList;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    VrRotaryTCourse: TVrRotarySwitch;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Bevel4: TBevel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Green1: TImageList;
    VrRBY: TVrBlinkLed;
    VrBlinkLed1: TVrBlinkLed;
    VrRHTctrl: TVrBlinkLed;
    VrDAAVL: TVrBlinkLed;
    VrRHText: TVrBlinkLed;
    VrANT: TVrBlinkLed;
    VrTXRX: TVrBlinkLed;
    VrWGD: TVrBlinkLed;
    VrFAIL: TVrBlinkLed;
    VrTrackBar1: TVrTrackBar;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    VrMti: TVrWheel;
    VrSlope: TVrWheel;
    VrAmpl: TVrWheel;
    VrWheel1: TVrWheel;
    VrDimmer: TVrWheel;
    btnOffAtn: TSpeedButtonImage;
    btn10rpm: TSpeedButtonImage;
    btn20rpm: TSpeedButtonImage;
    btnHdr: TSpeedButtonImage;
    btnCirc: TSpeedButtonImage;
    btnOff: TSpeedButtonImage;
    btnStby: TSpeedButtonImage;
    btnOn: TSpeedButtonImage;
    btnPrfLow: TSpeedButtonImage;
    btnPrfHigh: TSpeedButtonImage;
    btnBatt: TSpeedButtonImage;
    btnStc: TSpeedButtonImage;
    btnIsu: TSpeedButtonImage;
    btnCor: TSpeedButtonImage;
    btnCvs: TSpeedButtonImage;
    btnFapOff: TSpeedButtonImage;
    btnFap256: TSpeedButtonImage;
    btnTics: TSpeedButtonImage;
    btnLin: TSpeedButtonImage;
    btnMti: TSpeedButtonImage;
    btnAut: TSpeedButtonImage;
    Timer1: TTimer;
    procedure btnOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btn10rpmClick(Sender: TObject);
    procedure btn20rpmClick(Sender: TObject);
  private
    { Private declarations }

    MAGNETRON_COUNTER: Integer;
    IsMagRDY: Boolean;
    IsStarting: Boolean;
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;

  end;

//var
//  Frm_DA05: TFrm_DA05;

const C_MAGNETRON_WAIT_TIME = 5;

implementation

uses
  uLibRadar;

{$R *.dfm}

procedure TFrm_DA05.btnOnClick(Sender: TObject);
begin
  //if btnOn.Down then
  //begin
    btnOff.ImageIndex := 0;
    btnOn.ImageIndex := 1;

    IsStarting:=True;

  //end;
end;

procedure TFrm_DA05.FormCreate(Sender: TObject);
var i: integer;
    spb : TSpeedButtonImage;
begin
  MAGNETRON_COUNTER := 0;
  Timer1.Enabled := true;
  VrRBY.Color := clRed;

  for i := 0 to ComponentCount-1 do begin
    if (Components[i] is TSpeedButtonImage) then begin
      spb := (Components[i] as TSpeedButtonImage);

      if (spb <> btnOff) and (spb <> btnBatt) then begin
         spb.Glyph := btnOFf.Glyph;
      end
    end;
  end;

end;

procedure TFrm_DA05.Timer1Timer(Sender: TObject);
begin
  If IsStarting then MAGNETRON_COUNTER := MAGNETRON_COUNTER + 1;

  If (C_MAGNETRON_WAIT_TIME = MAGNETRON_COUNTER) and IsStarting then
  begin
    MAGNETRON_COUNTER := 0;
    IsStarting := False;
    IsMagRDY := True;
  end;

  if IsMagRDY then begin
    VrRBY.Color := clGreen;
    //btnStby.ImageIndex := 1;
    btnOn.ImageIndex := 0;
    btnOn.Down := false;
  end;
end;

procedure TFrm_DA05.btn10rpmClick(Sender: TObject);
begin
  if TDCInterface.ActiveRadar.FRadarType = rtDA_05 then
    TDCInterface.ActiveRadar.TimeBase.RotationSpeed := 10;
end;

procedure TFrm_DA05.btn20rpmClick(Sender: TObject);
begin
  if TDCInterface.ActiveRadar.FRadarType = rtDA_05 then
    TDCInterface.ActiveRadar.TimeBase.RotationSpeed := 20;
end;

end.
