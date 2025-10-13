unit ufWCCPanelBawah_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrRotarySwitch, ExtCtrls, StdCtrls, Buttons,
  SpeedButtonImage, ImgList, VrDesign;

type
  TfrmWCCPanelBawah_Rencong = class(TForm)
    ILBLUEBOX: TImageList;
    ILGREENBOX: TImageList;
    ILGREENROUND: TImageList;
    ILORANGEBOX: TImageList;
    ILORANGEROUND: TImageList;
    ILREDBOX: TImageList;
    ILREDROUND: TImageList;
    Panel1: TPanel;
    SpeedButtonImage29: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage6: TSpeedButtonImage;
    Label3: TLabel;
    SpeedButtonImage7: TSpeedButtonImage;
    Label4: TLabel;
    SpeedButtonImage8: TSpeedButtonImage;
    Label5: TLabel;
    SpeedButtonImage9: TSpeedButtonImage;
    Label6: TLabel;
    SpeedButtonImage10: TSpeedButtonImage;
    Label7: TLabel;
    SpeedButtonImage11: TSpeedButtonImage;
    Label8: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    Label9: TLabel;
    SpeedButtonImage13: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage14: TSpeedButtonImage;
    Label11: TLabel;
    SpeedButtonImage15: TSpeedButtonImage;
    Label12: TLabel;
    SpeedButtonImage16: TSpeedButtonImage;
    Label13: TLabel;
    SpeedButtonImage17: TSpeedButtonImage;
    Label14: TLabel;
    SpeedButtonImage18: TSpeedButtonImage;
    Label15: TLabel;
    SpeedButtonImage19: TSpeedButtonImage;
    Label16: TLabel;
    SpeedButtonImage20: TSpeedButtonImage;
    Label17: TLabel;
    SpeedButtonImage21: TSpeedButtonImage;
    Label18: TLabel;
    SpeedButtonImage22: TSpeedButtonImage;
    SpeedButtonImage23: TSpeedButtonImage;
    Label20: TLabel;
    SpeedButtonImage24: TSpeedButtonImage;
    Label21: TLabel;
    SpeedButtonImage25: TSpeedButtonImage;
    Label22: TLabel;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    Label24: TLabel;
    SpeedButtonImage28: TSpeedButtonImage;
    Label63: TLabel;
    Label1: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label23: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Bevel47: TBevel;
    Label113: TLabel;
    Bevel48: TBevel;
    Bevel46: TBevel;
    Bevel49: TBevel;
    Bevel50: TBevel;
    Bevel51: TBevel;
    Bevel52: TBevel;
    Bevel53: TBevel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
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
    Bevel54: TBevel;
    Bevel55: TBevel;
    Bevel56: TBevel;
    Bevel57: TBevel;
    Label133: TLabel;
    Bevel58: TBevel;
    Bevel59: TBevel;
    Bevel62: TBevel;
    Bevel63: TBevel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Bevel64: TBevel;
    Bevel65: TBevel;
    Bevel66: TBevel;
    Bevel67: TBevel;
    Bevel68: TBevel;
    Bevel69: TBevel;
    Bevel70: TBevel;
    Bevel71: TBevel;
    Label19: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label25: TLabel;
    Label148: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    VrRotarySwitch3: TVrRotarySwitch;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch5: TVrRotarySwitch;
    VrRotarySwitch6: TVrRotarySwitch;
    VrRotarySwitch7: TVrRotarySwitch;
    VrRotarySwitch8: TVrRotarySwitch;
    VrRotarySwitch9: TVrRotarySwitch;
    Panel2: TPanel;
    SpeedButtonImage30: TSpeedButtonImage;
    SpeedButtonImage31: TSpeedButtonImage;
    SpeedButtonImage32: TSpeedButtonImage;
    SpeedButtonImage33: TSpeedButtonImage;
    SpeedButtonImage34: TSpeedButtonImage;
    SpeedButtonImage35: TSpeedButtonImage;
    SpeedButtonImage36: TSpeedButtonImage;
    SpeedButtonImage37: TSpeedButtonImage;
    SpeedButtonImage38: TSpeedButtonImage;
    SpeedButtonImage39: TSpeedButtonImage;
    SpeedButtonImage40: TSpeedButtonImage;
    SpeedButtonImage41: TSpeedButtonImage;
    SpeedButtonImage42: TSpeedButtonImage;
    SpeedButtonImage43: TSpeedButtonImage;
    SpeedButtonImage44: TSpeedButtonImage;
    SpeedButtonImage45: TSpeedButtonImage;
    SpeedButtonImage46: TSpeedButtonImage;
    SpeedButtonImage47: TSpeedButtonImage;
    SpeedButtonImage48: TSpeedButtonImage;
    SpeedButtonImage49: TSpeedButtonImage;
    SpeedButtonImage50: TSpeedButtonImage;
    SpeedButtonImage51: TSpeedButtonImage;
    Shape1: TShape;
    SpeedButtonImage52: TSpeedButtonImage;
    Shape2: TShape;
    SpeedButtonImage53: TSpeedButtonImage;
    SpeedButtonImage54: TSpeedButtonImage;
    SpeedButtonImage55: TSpeedButtonImage;
    SpeedButtonImage56: TSpeedButtonImage;
    Shape3: TShape;
    SpeedButtonImage57: TSpeedButtonImage;
    Image2: TImage;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Bevel21: TBevel;
    Bevel24: TBevel;
    Bevel25: TBevel;
    Bevel26: TBevel;
    Bevel27: TBevel;
    Bevel28: TBevel;
    Bevel29: TBevel;
    Bevel30: TBevel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Bevel34: TBevel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Bevel35: TBevel;
    Bevel36: TBevel;
    Bevel37: TBevel;
    Bevel38: TBevel;
    Bevel39: TBevel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Bevel40: TBevel;
    Bevel41: TBevel;
    Bevel42: TBevel;
    Bevel43: TBevel;
    Bevel44: TBevel;
    Bevel45: TBevel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    Panel4: TPanel;
    SpeedButtonImage58: TSpeedButtonImage;
    SpeedButtonImage59: TSpeedButtonImage;
    SpeedButtonImage60: TSpeedButtonImage;
    SpeedButtonImage61: TSpeedButtonImage;
    SpeedButtonImage62: TSpeedButtonImage;
    Label60: TLabel;
    Label61: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    Bevel76: TBevel;
    Bevel77: TBevel;
    Bevel78: TBevel;
    Bevel79: TBevel;
    Panel5: TPanel;
    Shape4: TShape;
    Label149: TLabel;
    Label150: TLabel;
    VrRotarySwitch10: TVrRotarySwitch;
    VrRotarySwitch11: TVrRotarySwitch;
    GroupBox1: TGroupBox;
    VrBitmapButton2: TVrBitmapButton;
    VrBitmapButton3: TVrBitmapButton;
    Label32: TLabel;
    VrBitmapButton4: TVrBitmapButton;
    VrBitmapButton5: TVrBitmapButton;
    VrBitmapButton6: TVrBitmapButton;
    VrBitmapButton7: TVrBitmapButton;
    VrBitmapButton8: TVrBitmapButton;
    VrBitmapButton9: TVrBitmapButton;
    VrBitmapButton10: TVrBitmapButton;
    VrBitmapButton11: TVrBitmapButton;
    VrBitmapButton12: TVrBitmapButton;
    VrBitmapButton13: TVrBitmapButton;
    VrBitmapButton14: TVrBitmapButton;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    VrBitmapButton1: TVrBitmapButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    Panel6: TPanel;
    SpeedButtonImage63: TSpeedButtonImage;
    SpeedButtonImage64: TSpeedButtonImage;
    SpeedButtonImage65: TSpeedButtonImage;
    SpeedButtonImage66: TSpeedButtonImage;
    SpeedButtonImage67: TSpeedButtonImage;
    SpeedButtonImage68: TSpeedButtonImage;
    SpeedButtonImage69: TSpeedButtonImage;
    SpeedButtonImage70: TSpeedButtonImage;
    SpeedButtonImage71: TSpeedButtonImage;
    SpeedButtonImage72: TSpeedButtonImage;
    SpeedButtonImage73: TSpeedButtonImage;
    SpeedButtonImage74: TSpeedButtonImage;
    SpeedButtonImage75: TSpeedButtonImage;
    SpeedButtonImage76: TSpeedButtonImage;
    SpeedButtonImage77: TSpeedButtonImage;
    Label62: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label69: TLabel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Bevel12: TBevel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label79: TLabel;
    Bevel16: TBevel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Label84: TLabel;
    Bevel20: TBevel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Label199: TLabel;
    Label200: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Panel7: TPanel;
    SpeedButtonImage78: TSpeedButtonImage;
    SpeedButtonImage79: TSpeedButtonImage;
    SpeedButtonImage80: TSpeedButtonImage;
    SpeedButtonImage81: TSpeedButtonImage;
    SpeedButtonImage82: TSpeedButtonImage;
    SpeedButtonImage83: TSpeedButtonImage;
    SpeedButtonImage84: TSpeedButtonImage;
    SpeedButtonImage85: TSpeedButtonImage;
    SpeedButtonImage86: TSpeedButtonImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label59: TLabel;
    Bevel72: TBevel;
    Bevel73: TBevel;
    Bevel74: TBevel;
    Bevel75: TBevel;
    Label215: TLabel;
    Label216: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    VrRotarySwitch12: TVrRotarySwitch;
    Panel8: TPanel;
    SpeedButtonImage87: TSpeedButtonImage;
    SpeedButtonImage88: TSpeedButtonImage;
    SpeedButtonImage89: TSpeedButtonImage;
    SpeedButtonImage90: TSpeedButtonImage;
    SpeedButtonImage91: TSpeedButtonImage;
    SpeedButtonImage92: TSpeedButtonImage;
    SpeedButtonImage93: TSpeedButtonImage;
    SpeedButtonImage94: TSpeedButtonImage;
    SpeedButtonImage95: TSpeedButtonImage;
    SpeedButtonImage96: TSpeedButtonImage;
    SpeedButtonImage97: TSpeedButtonImage;
    SpeedButtonImage98: TSpeedButtonImage;
    SpeedButtonImage99: TSpeedButtonImage;
    SpeedButtonImage100: TSpeedButtonImage;
    SpeedButtonImage101: TSpeedButtonImage;
    Shape8: TShape;
    SpeedButtonImage102: TSpeedButtonImage;
    SpeedButtonImage103: TSpeedButtonImage;
    SpeedButtonImage104: TSpeedButtonImage;
    SpeedButtonImage105: TSpeedButtonImage;
    SpeedButtonImage106: TSpeedButtonImage;
    Shape9: TShape;
    SpeedButtonImage107: TSpeedButtonImage;
    SpeedButtonImage108: TSpeedButtonImage;
    SpeedButtonImage109: TSpeedButtonImage;
    SpeedButtonImage110: TSpeedButtonImage;
    SpeedButtonImage111: TSpeedButtonImage;
    Shape10: TShape;
    SpeedButtonImage112: TSpeedButtonImage;
    Label31: TLabel;
    Image1: TImage;
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
    Bevel80: TBevel;
    Bevel81: TBevel;
    Bevel82: TBevel;
    Bevel83: TBevel;
    Bevel84: TBevel;
    Bevel85: TBevel;
    Bevel86: TBevel;
    Bevel87: TBevel;
    Bevel88: TBevel;
    Bevel89: TBevel;
    Bevel90: TBevel;
    Bevel91: TBevel;
    Bevel92: TBevel;
    Bevel93: TBevel;
    Bevel94: TBevel;
    Bevel95: TBevel;
    Bevel96: TBevel;
    Bevel97: TBevel;
    Bevel98: TBevel;
    Bevel99: TBevel;
    Label226: TLabel;
    Label227: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label230: TLabel;
    Bevel100: TBevel;
    Bevel101: TBevel;
    Bevel102: TBevel;
    Bevel103: TBevel;
    Bevel104: TBevel;
    Label231: TLabel;
    Label232: TLabel;
    Label233: TLabel;
    Label234: TLabel;
    Label235: TLabel;
    Label236: TLabel;
    Label237: TLabel;
    Label239: TLabel;
    Label240: TLabel;
    Label241: TLabel;
    Label242: TLabel;
    Label243: TLabel;
    Label244: TLabel;
    Label245: TLabel;
    Label246: TLabel;
    Label247: TLabel;
    Label248: TLabel;
    Label249: TLabel;
    Label250: TLabel;
    Label251: TLabel;
    Label252: TLabel;
    Label253: TLabel;
    Label254: TLabel;
    Label255: TLabel;
    Label256: TLabel;
    Label257: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWCCPanelBawah_Rencong: TfrmWCCPanelBawah_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;

procedure TfrmWCCPanelBawah_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;


Image1.Picture.LoadFromFile(IMAGES_PATH+'mic.bmp');
Image2.Picture.LoadFromFile(IMAGES_PATH+'mic.bmp');

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton1.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton2.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton3.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton4.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton5.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton6.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton7.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton8.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton9.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton10.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton11.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton12.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton13.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'button_3.bmp');
VrBitmapButton14.Glyph:=bmp;
freebmp(bmp);


bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage1.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage2.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage3.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage4.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage5.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage6.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage7.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage8.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage9.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage10.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage11.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage12.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage13.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage14.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage15.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage29.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage16.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage17.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage18.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage19.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage20.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage21.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage22.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage23.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage24.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage25.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage26.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage27.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage28.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage30.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage31.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeROUND.bmp');
ILORANGEROUND.Add(bmp,nil);
SpeedButtonImage32.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage33.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage34.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage35.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage36.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage37.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage38.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage39.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage40.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage41.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage42.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage43.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage44.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage45.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage46.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage47.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage48.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage49.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage50.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage51.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage52.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage53.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage54.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage57.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage55.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage56.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage58.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage61.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage59.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage60.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage62.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage63.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage64.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage65.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage66.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage67.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage68.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage69.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage70.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage71.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage72.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage73.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage74.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage75.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage76.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage77.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage78.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage80.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage79.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage81.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage82.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage83.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'blueBOX.bmp');
ILBLUEBOX.Add(bmp,nil);
SpeedButtonImage84.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'blueBOX.bmp');
ILBLUEBOX.Add(bmp,nil);
SpeedButtonImage85.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'blueBOX.bmp');
ILBLUEBOX.Add(bmp,nil);
SpeedButtonImage86.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage87.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage88.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage89.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage90.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage91.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage92.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage93.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage94.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage95.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage96.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage97.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage98.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage99.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage100.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage101.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage102.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage103.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage104.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage105.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage106.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage107.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage108.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage109.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage110.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage111.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage112.ImageIndex:=0;
freebmp(bmp);








bmp.Free;
end;

end.
