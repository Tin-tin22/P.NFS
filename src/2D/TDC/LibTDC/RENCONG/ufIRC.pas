unit ufIRC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, ImgList, StdCtrls,
  VrControls, VrBlinkLed, VrWheel;

type
  TfrmIRC_Rencong = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    ILSWITCH: TImageList;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButtonImage1: TSpeedButtonImage;
    Bevel4: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    VrBlinkLed1: TVrBlinkLed;
    VrBlinkLed2: TVrBlinkLed;
    Label12: TLabel;
    SpeedButtonImage2: TSpeedButtonImage;
    VrBlinkLed3: TVrBlinkLed;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    SpeedButtonImage3: TSpeedButtonImage;
    Bevel5: TBevel;
    VrBlinkLed4: TVrBlinkLed;
    Label18: TLabel;
    Label19: TLabel;
    VrWheel1: TVrWheel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIRC_Rencong: TfrmIRC_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;

procedure TfrmIRC_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

bmp.LoadFromFile(IMAGES_PATH+'switchHz2.bmp');
ILSWITCH.Add(bmp,nil);
SpeedButtonImage1.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switchHz2.bmp');
ILSWITCH.Add(bmp,nil);
SpeedButtonImage2.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'switchHz2.bmp');
ILSWITCH.Add(bmp,nil);
SpeedButtonImage3.ImageIndex:=0;
freebmp(bmp);


bmp.Free;
end;

end.
