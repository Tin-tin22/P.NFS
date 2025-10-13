unit ufIFF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, VrLcd, VrDesign, Buttons, SpeedButtonImage,
  VrControls, VrWheel, ImgList;

type
  TfrmIFF_Rencong = class(TForm)
    ILSWITCH2: TImageList;
    ILSWITCH3: TImageList;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    GroupBox2: TGroupBox;
    Bevel1: TBevel;
    VrWheel1: TVrWheel;
    VrWheel2: TVrWheel;
    Label95: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label59: TLabel;
    Label5: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Label7: TLabel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Label10: TLabel;
    Bevel24: TBevel;
    Bevel25: TBevel;
    Label11: TLabel;
    Bevel27: TBevel;
    Label12: TLabel;
    Bevel26: TBevel;
    Bevel29: TBevel;
    Bevel30: TBevel;
    Bevel28: TBevel;
    Bevel31: TBevel;
    Label13: TLabel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Label14: TLabel;
    Bevel34: TBevel;
    Bevel35: TBevel;
    Bevel36: TBevel;
    Bevel37: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Bevel38: TBevel;
    Bevel39: TBevel;
    Bevel40: TBevel;
    Bevel41: TBevel;
    Bevel42: TBevel;
    Bevel43: TBevel;
    Bevel44: TBevel;
    Bevel45: TBevel;
    Bevel46: TBevel;
    Bevel47: TBevel;
    Bevel48: TBevel;
    Bevel49: TBevel;
    Label23: TLabel;
    Label24: TLabel;
    Image1: TImage;
    Label25: TLabel;
    Label26: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    VrWheel3: TVrWheel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Image5: TImage;
    Image6: TImage;
    SpeedButtonImage8: TSpeedButtonImage;
    GroupBox4: TGroupBox;
    VrBitmapButton1: TVrBitmapButton;
    VrNum2: TVrNum;
    GroupBox5: TGroupBox;
    VrBitmapButton2: TVrBitmapButton;
    VrNum3: TVrNum;
    GroupBox8: TGroupBox;
    VrBitmapButton5: TVrBitmapButton;
    VrNum6: TVrNum;
    GroupBox3: TGroupBox;
    VrNum1: TVrNum;
    VrBitmapButton6: TVrBitmapButton;
    GroupBox9: TGroupBox;
    VrNum7: TVrNum;
    VrBitmapButton7: TVrBitmapButton;
    GroupBox10: TGroupBox;
    VrBitmapButton8: TVrBitmapButton;
    VrNum8: TVrNum;
    GroupBox11: TGroupBox;
    VrBitmapButton9: TVrBitmapButton;
    VrNum9: TVrNum;
    GroupBox12: TGroupBox;
    VrBitmapButton10: TVrBitmapButton;
    VrNum10: TVrNum;
    GroupBox13: TGroupBox;
    VrBitmapButton11: TVrBitmapButton;
    VrNum11: TVrNum;
    GroupBox14: TGroupBox;
    VrBitmapButton12: TVrBitmapButton;
    VrNum12: TVrNum;
    GroupBox15: TGroupBox;
    VrBitmapButton13: TVrBitmapButton;
    VrNum13: TVrNum;
    GroupBox16: TGroupBox;
    VrBitmapButton14: TVrBitmapButton;
    VrNum14: TVrNum;
    GroupBox17: TGroupBox;
    VrBitmapButton3: TVrBitmapButton;
    VrNum15: TVrNum;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    GroupBox7: TGroupBox;
    VrBitmapButton4: TVrBitmapButton;
    VrNum5: TVrNum;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIFF_Rencong: TfrmIFF_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;

procedure TfrmIFF_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage1.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage2.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage3.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage4.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage5.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage6.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH3_HZ.bmp');
ILSWITCH3.Add(bmp,nil);
SpeedButtonImage7.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage8.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage9.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage10.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage11.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage12.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage13.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage14.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage15.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'SWITCH2.bmp');
ILSWITCH2.Add(bmp,nil);
SpeedButtonImage16.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton1.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton2.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton3.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton4.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton5.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton6.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton7.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton8.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton9.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton10.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton11.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton12.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton13.Glyph:=bmp;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'small_black.bmp');
VrBitmapButton14.Glyph:=bmp;
freebmp(bmp);

Image1.Picture.LoadFromFile(IMAGES_PATH+'BTN_PINK.bmp');
Image2.Picture.LoadFromFile(IMAGES_PATH+'BTN_YELLOW.bmp');
Image3.Picture.LoadFromFile(IMAGES_PATH+'BTN_BLUE.bmp');
Image4.Picture.LoadFromFile(IMAGES_PATH+'BTN_GREEN.bmp');
Image5.Picture.LoadFromFile(IMAGES_PATH+'BTN_BLUE.bmp');
Image6.Picture.LoadFromFile(IMAGES_PATH+'BTN_BLUE.bmp');


bmp.Free;
end;

end.
