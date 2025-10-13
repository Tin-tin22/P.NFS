unit ufTDC1Kanan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, StdCtrls, ImgList;

type
  TfrmTDC1Kanan_Rencong = class(TForm)
    Panel1: TPanel;
    ILORANGEBOX: TImageList;
    Label1: TLabel;
    Label24: TLabel;
    Label29: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    Label13: TLabel;
    Label15: TLabel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label18: TLabel;
    Label25: TLabel;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
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
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTDC1Kanan_Rencong: TfrmTDC1Kanan_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;

procedure TfrmTDC1Kanan_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage1.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage2.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage3.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage4.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage5.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage6.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage7.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage8.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage9.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage10.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage11.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage12.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage13.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage14.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage15.ImageIndex:=0;
freebmp(bmp);

bmp.LoadFromFile(IMAGES_PATH+'orangeBOX.bmp');
ILORANGEBOX.Add(bmp,nil);
SpeedButtonImage16.ImageIndex:=0;
freebmp(bmp);

bmp.Free;
end;

end.
