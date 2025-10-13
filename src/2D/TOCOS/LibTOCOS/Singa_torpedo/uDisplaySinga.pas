unit uDisplaySinga;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufTDCTengah, ImgList, Menus, OleCtrls, MapXLib_TLB, StdCtrls,
  VrDigit, VrControls, VrWheel, ExtCtrls, VrDesign;

type
  TfrmLPDTorpedo = class(TfrmTDCTengah)
    imgBackground: TImage;
    lmp1: TImage;
    lmp2: TImage;
    procedure FormCreate(Sender: TObject);
  private
    tocos_image_path:  string;
  public

  end;

implementation
uses
  uCompassDisplay;
{$R *.dfm}

procedure TfrmLPDTorpedo.FormCreate(Sender: TObject);
var
//  bmp :TBitmap;
//  i: integer;
  fname: string;
  c :TDrawCompass;
begin
  inherited;
  tocos_image_path := '..\data\images\torpedo\';
  fname := tocos_image_path+ 'tocos LPD.BMP';

  if FileExists(fname) then
    Image1.Picture.LoadFromFile(fname);

  c := TDrawCompass.Create;
  c.ptC.X := Image1.WIdth shr 1;
  c.ptC.Y := Image1.Height shr 1;

  c.Radius := (Image1.WIdth shr 1) - 2;
  c.DrawCompass(Image1.Canvas);

  c.Free;
end;

end.
