unit ufExocet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrLcd, StdCtrls, VrControls, VrRotarySwitch, VrDesign,
  VrBlinkLed, ExtCtrls;

type
  TfrmExocet_Rencong = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label4: TLabel;
    Bevel8: TBevel;
    Label5: TLabel;
    Bevel9: TBevel;
    Label6: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label7: TLabel;
    Bevel14: TBevel;
    Label8: TLabel;
    SwtrPumpAuxOn: TVrBlinkLed;
    VrBlinkLed1: TVrBlinkLed;
    VrBlinkLed2: TVrBlinkLed;
    VrBlinkLed3: TVrBlinkLed;
    Bevel15: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel20: TBevel;
    Label11: TLabel;
    Bevel21: TBevel;
    Label1: TLabel;
    VrBlinkLed4: TVrBlinkLed;
    VrBlinkLed5: TVrBlinkLed;
    Label20: TLabel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Label21: TLabel;
    Bevel10: TBevel;
    VrBlinkLed6: TVrBlinkLed;
    VrBlinkLed7: TVrBlinkLed;
    VrBlinkLed8: TVrBlinkLed;
    VrBlinkLed9: TVrBlinkLed;
    Bevel13: TBevel;
    Bevel16: TBevel;
    Bevel19: TBevel;
    Bevel22: TBevel;
    Label22: TLabel;
    Bevel23: TBevel;
    VrBlinkLed10: TVrBlinkLed;
    VrBlinkLed11: TVrBlinkLed;
    VrBitmapButton3: TVrBitmapButton;
    VrBitmapButton4: TVrBitmapButton;
    Bevel7: TBevel;
    Bevel24: TBevel;
    Label34: TLabel;
    VrBitmapButton6: TVrBitmapButton;
    VrBitmapButton7: TVrBitmapButton;
    VrBlinkLed22: TVrBlinkLed;
    VrBlinkLed23: TVrBlinkLed;
    VrBlinkLed24: TVrBlinkLed;
    VrBlinkLed25: TVrBlinkLed;
    VrBlinkLed26: TVrBlinkLed;
    VrBlinkLed27: TVrBlinkLed;
    VrBlinkLed28: TVrBlinkLed;
    VrBlinkLed29: TVrBlinkLed;
    Bevel25: TBevel;
    Label35: TLabel;
    Bevel26: TBevel;
    Bevel27: TBevel;
    Label36: TLabel;
    Bevel28: TBevel;
    VrBitmapButton8: TVrBitmapButton;
    VrBitmapButton9: TVrBitmapButton;
    VrBitmapButton10: TVrBitmapButton;
    Label37: TLabel;
    Label38: TLabel;
    VrBitmapButton11: TVrBitmapButton;
    VrBitmapButton12: TVrBitmapButton;
    VrBitmapButton13: TVrBitmapButton;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    VrBitmapButton14: TVrBitmapButton;
    Bevel29: TBevel;
    VrBlinkLed30: TVrBlinkLed;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch3: TVrRotarySwitch;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch5: TVrRotarySwitch;
    VrRotarySwitch6: TVrRotarySwitch;
    VrRotarySwitch7: TVrRotarySwitch;
    VrRotarySwitch8: TVrRotarySwitch;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label14: TLabel;
    Label42: TLabel;
    VrRotarySwitch14: TVrRotarySwitch;
    VrRotarySwitch15: TVrRotarySwitch;
    VrRotarySwitch16: TVrRotarySwitch;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label19: TLabel;
    Label12: TLabel;
    VrRotarySwitch12: TVrRotarySwitch;
    VrRotarySwitch13: TVrRotarySwitch;
    Label10: TLabel;
    VrRotarySwitch11: TVrRotarySwitch;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    VrRotarySwitch9: TVrRotarySwitch;
    VrRotarySwitch10: TVrRotarySwitch;
    VrRotarySwitch17: TVrRotarySwitch;
    VrRotarySwitch18: TVrRotarySwitch;
    VrRotarySwitch19: TVrRotarySwitch;
    VrRotarySwitch20: TVrRotarySwitch;
    GroupBox4: TGroupBox;
    Label23: TLabel;
    VrBitmapButton1: TVrBitmapButton;
    Label24: TLabel;
    VrBlinkLed12: TVrBlinkLed;
    GroupBox5: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    VrBlinkLed13: TVrBlinkLed;
    VrBlinkLed14: TVrBlinkLed;
    VrBlinkLed15: TVrBlinkLed;
    Label27: TLabel;
    GroupBox6: TGroupBox;
    VrBlinkLed16: TVrBlinkLed;
    VrBlinkLed18: TVrBlinkLed;
    VrRotarySwitch21: TVrRotarySwitch;
    GroupBox7: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    VrBlinkLed17: TVrBlinkLed;
    VrBlinkLed20: TVrBlinkLed;
    VrBlinkLed19: TVrBlinkLed;
    Label30: TLabel;
    VrBlinkLed21: TVrBlinkLed;
    Label32: TLabel;
    GroupBox8: TGroupBox;
    VrBitmapButton2: TVrBitmapButton;
    Label31: TLabel;
    Label33: TLabel;
    VrBitmapButton5: TVrBitmapButton;
    GroupBox9: TGroupBox;
    Label46: TLabel;
    Label47: TLabel;
    VrRotarySwitch24: TVrRotarySwitch;
    VrRotarySwitch25: TVrRotarySwitch;
    GroupBox10: TGroupBox;
    VrBlinkLed31: TVrBlinkLed;
    VrBlinkLed32: TVrBlinkLed;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    VrNum1: TVrNum;
    VrRotarySwitch22: TVrRotarySwitch;
    VrRotarySwitch23: TVrRotarySwitch;
    VrBitmapButton15: TVrBitmapButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExocet_Rencong: TfrmExocet_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;


procedure TfrmExocet_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton1.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton2.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton3.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton4.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton5.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton6.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton7.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton8.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton9.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton10.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton11.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton12.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton13.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton14.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'bbluebutt.bmp');
VrBitmapButton15.Glyph:=bmp;
freebmp(bmp);





bmp.Free;
end;

end.
