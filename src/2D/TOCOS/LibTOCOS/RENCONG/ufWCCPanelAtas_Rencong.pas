unit ufWCCPanelAtas_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls,
  VrControls, VrRotarySwitch;

type
  TfrmWCCPanelAtas_Rencong = class(TForm)
    ILUPDOWNSWITCH: TImageList;
    ILREDBOX: TImageList;
    ILREDROUND: TImageList;
    ILGREENBOX: TImageList;
    ILGREENROUND: TImageList;
    ILORANGEBOX: TImageList;
    ILORANGEROUND: TImageList;
    Panel1: TPanel;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
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
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    SpeedButtonImage13: TSpeedButtonImage;
    Label114: TLabel;
    Panel3: TPanel;
    SpeedButtonImage18: TSpeedButtonImage;
    Label1: TLabel;
    SpeedButtonImage19: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage20: TSpeedButtonImage;
    Label3: TLabel;
    SpeedButtonImage22: TSpeedButtonImage;
    Label4: TLabel;
    SpeedButtonImage23: TSpeedButtonImage;
    Label5: TLabel;
    SpeedButtonImage24: TSpeedButtonImage;
    Label6: TLabel;
    SpeedButtonImage25: TSpeedButtonImage;
    Label7: TLabel;
    SpeedButtonImage14: TSpeedButtonImage;
    Label8: TLabel;
    SpeedButtonImage15: TSpeedButtonImage;
    Label9: TLabel;
    SpeedButtonImage16: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage17: TSpeedButtonImage;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButtonImage21: TSpeedButtonImage;
    Label86: TLabel;
    Panel4: TPanel;
    SpeedButtonImage26: TSpeedButtonImage;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButtonImage27: TSpeedButtonImage;
    Label17: TLabel;
    SpeedButtonImage28: TSpeedButtonImage;
    Label18: TLabel;
    SpeedButtonImage29: TSpeedButtonImage;
    Label19: TLabel;
    SpeedButtonImage30: TSpeedButtonImage;
    Label20: TLabel;
    SpeedButtonImage31: TSpeedButtonImage;
    Label21: TLabel;
    SpeedButtonImage32: TSpeedButtonImage;
    Label22: TLabel;
    SpeedButtonImage33: TSpeedButtonImage;
    Label24: TLabel;
    SpeedButtonImage34: TSpeedButtonImage;
    Label25: TLabel;
    SpeedButtonImage35: TSpeedButtonImage;
    Label26: TLabel;
    SpeedButtonImage36: TSpeedButtonImage;
    Label27: TLabel;
    SpeedButtonImage37: TSpeedButtonImage;
    Label28: TLabel;
    Label115: TLabel;
    Panel5: TPanel;
    SpeedButtonImage38: TSpeedButtonImage;
    SpeedButtonImage39: TSpeedButtonImage;
    Label31: TLabel;
    Label32: TLabel;
    SpeedButtonImage40: TSpeedButtonImage;
    Label33: TLabel;
    SpeedButtonImage41: TSpeedButtonImage;
    Label30: TLabel;
    SpeedButtonImage42: TSpeedButtonImage;
    Label34: TLabel;
    Label29: TLabel;
    Panel6: TPanel;
    SpeedButtonImage43: TSpeedButtonImage;
    Label35: TLabel;
    SpeedButtonImage44: TSpeedButtonImage;
    SpeedButtonImage45: TSpeedButtonImage;
    SpeedButtonImage46: TSpeedButtonImage;
    SpeedButtonImage47: TSpeedButtonImage;
    SpeedButtonImage48: TSpeedButtonImage;
    SpeedButtonImage49: TSpeedButtonImage;
    Label41: TLabel;
    SpeedButtonImage50: TSpeedButtonImage;
    Label42: TLabel;
    SpeedButtonImage51: TSpeedButtonImage;
    Label43: TLabel;
    SpeedButtonImage52: TSpeedButtonImage;
    Label44: TLabel;
    SpeedButtonImage53: TSpeedButtonImage;
    Label45: TLabel;
    SpeedButtonImage54: TSpeedButtonImage;
    Label46: TLabel;
    SpeedButtonImage55: TSpeedButtonImage;
    Label47: TLabel;
    SpeedButtonImage56: TSpeedButtonImage;
    Label48: TLabel;
    SpeedButtonImage57: TSpeedButtonImage;
    Label49: TLabel;
    SpeedButtonImage58: TSpeedButtonImage;
    Label50: TLabel;
    SpeedButtonImage59: TSpeedButtonImage;
    Label51: TLabel;
    SpeedButtonImage60: TSpeedButtonImage;
    Label52: TLabel;
    SpeedButtonImage61: TSpeedButtonImage;
    Label53: TLabel;
    Label54: TLabel;
    Bevel1: TBevel;
    Label55: TLabel;
    Label56: TLabel;
    SpeedButtonImage62: TSpeedButtonImage;
    Label57: TLabel;
    SpeedButtonImage63: TSpeedButtonImage;
    Label58: TLabel;
    SpeedButtonImage64: TSpeedButtonImage;
    Label59: TLabel;
    SpeedButtonImage65: TSpeedButtonImage;
    Label61: TLabel;
    SpeedButtonImage66: TSpeedButtonImage;
    Label62: TLabel;
    SpeedButtonImage67: TSpeedButtonImage;
    Label63: TLabel;
    SpeedButtonImage68: TSpeedButtonImage;
    Label64: TLabel;
    SpeedButtonImage69: TSpeedButtonImage;
    Label65: TLabel;
    SpeedButtonImage70: TSpeedButtonImage;
    Label66: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    VrRotarySwitch4: TVrRotarySwitch;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    VrRotarySwitch3: TVrRotarySwitch;
    Panel7: TPanel;
    SpeedButtonImage71: TSpeedButtonImage;
    SpeedButtonImage91: TSpeedButtonImage;
    SpeedButtonImage90: TSpeedButtonImage;
    SpeedButtonImage89: TSpeedButtonImage;
    SpeedButtonImage72: TSpeedButtonImage;
    SpeedButtonImage73: TSpeedButtonImage;
    Label60: TLabel;
    SpeedButtonImage74: TSpeedButtonImage;
    Label67: TLabel;
    SpeedButtonImage75: TSpeedButtonImage;
    SpeedButtonImage76: TSpeedButtonImage;
    SpeedButtonImage77: TSpeedButtonImage;
    SpeedButtonImage78: TSpeedButtonImage;
    SpeedButtonImage79: TSpeedButtonImage;
    Label71: TLabel;
    Label72: TLabel;
    SpeedButtonImage80: TSpeedButtonImage;
    SpeedButtonImage81: TSpeedButtonImage;
    SpeedButtonImage82: TSpeedButtonImage;
    SpeedButtonImage83: TSpeedButtonImage;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Bevel2: TBevel;
    SpeedButtonImage88: TSpeedButtonImage;
    SpeedButtonImage84: TSpeedButtonImage;
    SpeedButtonImage85: TSpeedButtonImage;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label70: TLabel;
    Label81: TLabel;
    Label68: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label82: TLabel;
    SpeedButtonImage86: TSpeedButtonImage;
    Label142: TLabel;
    Label143: TLabel;
    SpeedButtonImage87: TSpeedButtonImage;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label69: TLabel;
    Panel8: TPanel;
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
    SpeedButtonImage102: TSpeedButtonImage;
    SpeedButtonImage103: TSpeedButtonImage;
    SpeedButtonImage104: TSpeedButtonImage;
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWCCPanelAtas_Rencong: TfrmWCCPanelAtas_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;


procedure TfrmWCCPanelAtas_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

Image1.Picture.LoadFromFile(IMAGES_PATH+'degree_2.bmp');
Image2.Picture.LoadFromFile(IMAGES_PATH+'degree_2.bmp');

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage1.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage2.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage3.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage4.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage5.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage6.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage7.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage8.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage9.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage10.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage11.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage12.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage92.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage93.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage94.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage95.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage96.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage97.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage98.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage99.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage100.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage101.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage102.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage103.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switch_fusion.bmp');
ILUPDOWNSWITCH.Add(bmp,nil);
SpeedButtonImage104.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage13.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage14.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage15.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage16.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage17.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage18.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage19.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage20.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage21.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage22.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage23.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage24.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage25.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage26.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage27.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage28.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage29.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage30.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage31.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage33.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage35.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage36.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage37.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage32.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage34.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
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

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
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

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
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

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage47.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage48.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage49.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage50.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
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
SpeedButtonImage55.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage56.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage57.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redBOX.bmp');
ILREDBOX.Add(bmp,nil);
SpeedButtonImage58.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage59.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage60.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenBOX.bmp');
ILGREENBOX.Add(bmp,nil);
SpeedButtonImage61.ImageIndex:=0;
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

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage71.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
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

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage75.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage76.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage77.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage78.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'redROUND.bmp');
ILREDROUND.Add(bmp,nil);
SpeedButtonImage79.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage80.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage81.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage82.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage83.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage84.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
SpeedButtonImage85.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'greenROUND.bmp');
ILGREENROUND.Add(bmp,nil);
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

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage90.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage91.ImageIndex:=0;
freebmp(bmp);


bmp.Free;
end;

end.
