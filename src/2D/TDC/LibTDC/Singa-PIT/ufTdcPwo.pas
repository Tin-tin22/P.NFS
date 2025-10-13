unit ufTdcPwo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrRotarySwitch, StdCtrls, ExtCtrls, VrBlinkLed,
  Buttons, SpeedButtonImage, ImgList;

type
  TfrmTdcPwo = class(TForm)
    Panel1: TPanel;
    ILSWITCH2: TImageList;
    ILSWBLACK: TImageList;
    ILSWRED: TImageList;
    ILSWGRAY: TImageList;
    GroupBox1: TGroupBox;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    SpeedButtonImage23: TSpeedButtonImage;
    SpeedButtonImage24: TSpeedButtonImage;
    SpeedButtonImage25: TSpeedButtonImage;
    VrBlinkLed1: TVrBlinkLed;
    VrBlinkLed2: TVrBlinkLed;
    VrBlinkLed3: TVrBlinkLed;
    VrBlinkLed4: TVrBlinkLed;
    VrBlinkLed5: TVrBlinkLed;
    VrBlinkLed6: TVrBlinkLed;
    VrBlinkLed7: TVrBlinkLed;
    VrBlinkLed8: TVrBlinkLed;
    VrBlinkLed9: TVrBlinkLed;
    VrBlinkLed10: TVrBlinkLed;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    VrRotarySwitch1: TVrRotarySwitch;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    SpeedButtonImage17: TSpeedButtonImage;
    SpeedButtonImage18: TSpeedButtonImage;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage20: TSpeedButtonImage;
    VrBlinkLed11: TVrBlinkLed;
    VrBlinkLed12: TVrBlinkLed;
    VrBlinkLed13: TVrBlinkLed;
    VrBlinkLed14: TVrBlinkLed;
    VrBlinkLed15: TVrBlinkLed;
    VrBlinkLed16: TVrBlinkLed;
    VrBlinkLed17: TVrBlinkLed;
    VrBlinkLed18: TVrBlinkLed;
    VrBlinkLed19: TVrBlinkLed;
    VrBlinkLed20: TVrBlinkLed;
    Shape3: TShape;
    Label12: TLabel;
    Shape4: TShape;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    SpeedButtonImage28: TSpeedButtonImage;
    SpeedButtonImage29: TSpeedButtonImage;
    SpeedButtonImage30: TSpeedButtonImage;
    SpeedButtonImage31: TSpeedButtonImage;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
const IMAGES_PATH  = 'images\tdc\';

procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TfrmTdcPwo.FormCreate(Sender: TObject);
var bmpnya : TBitmap;
begin
  // ini buat imagelistnya
  bmpnya := TBitmap.Create;

  //SWITCH
  bmpnya.LoadFromFile(IMAGES_PATH + 'switchHz2.bmp'); // v
  ILSWITCH2. Add(bmpnya,nil);
  SpeedButtonImage1.ImageIndex := 0;
  SpeedButtonImage2.ImageIndex := 0;
  SpeedButtonImage3.ImageIndex := 0;
  SpeedButtonImage4.ImageIndex := 0;
  SpeedButtonImage5.ImageIndex := 0;
  SpeedButtonImage6.ImageIndex := 0;
  SpeedButtonImage7.ImageIndex := 0;
  SpeedButtonImage8.ImageIndex := 0;
  SpeedButtonImage9.ImageIndex := 0;
  SpeedButtonImage10.ImageIndex := 0;
  SpeedButtonImage11.ImageIndex := 0;
  SpeedButtonImage12.ImageIndex := 0;
  SpeedButtonImage13.ImageIndex := 0;
  SpeedButtonImage14.ImageIndex := 0;
  SpeedButtonImage15.ImageIndex := 0;
  SpeedButtonImage16.ImageIndex := 0;
  SpeedButtonImage17.ImageIndex := 0;
  SpeedButtonImage18.ImageIndex := 0;
  SpeedButtonImage19.ImageIndex := 0;
  SpeedButtonImage20.ImageIndex := 0;
  freeBmp(bmpnya);
  //END SWITCH

  //SW KOTAK
  bmpnya.LoadFromFile(IMAGES_PATH + 'switchKotakAbu.bmp'); // ABU
  ILSWGRAY. Add(bmpnya,nil);
  SpeedButtonImage21.ImageIndex := 0;
  freeBmp(bmpnya);

  bmpnya.LoadFromFile(IMAGES_PATH + 'switchKotakMerah.bmp'); // MERAH
  ILSWRED. Add(bmpnya,nil);
  SpeedButtonImage22.ImageIndex := 0;
  SpeedButtonImage23.ImageIndex := 0;
  SpeedButtonImage24.ImageIndex := 0;
  SpeedButtonImage25.ImageIndex := 0;
  SpeedButtonImage27.ImageIndex := 0;
  SpeedButtonImage28.ImageIndex := 0;
  SpeedButtonImage29.ImageIndex := 0;
  SpeedButtonImage30.ImageIndex := 0;
  freeBmp(bmpnya);

  bmpnya.LoadFromFile(IMAGES_PATH + 'switchKotakHitam.bmp'); // HITAM
  ILSWBLACK. Add(bmpnya,nil);
  SpeedButtonImage31.ImageIndex := 0;
  freeBmp(bmpnya);
  //END SW KOTAK
bmpnya.Free;

end;

end.
