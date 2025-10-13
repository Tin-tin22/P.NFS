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
    btnOffTrm: TSpeedButtonImage;
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
  private
    { Private declarations }
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;
  end;

//var
//  Frm_DA05: TFrm_DA05;

implementation

{$R *.dfm}

end.
