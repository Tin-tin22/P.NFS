unit ufQEK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, SpeedButtonImage, uLibTDCClass;

type

  TfrmQEK = class(TForm)
    ilOrangeBox: TImageList;
    ilGreenBox: TImageList;
    ilBlueBox: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
     procedure LoadImageFile(fName: string; imgL: TImageList);
     procedure UpdateSpeedBtn;

     procedure SetSpeedButtonGlyphNumber(const b: byte);

  public
    { Public declarations }
     image_path : string;
     TDCInterface : TGenericTDCInterface;

     procedure LoadImageList; virtual;
     procedure SetLocalVariable(tdc :TGenericTDCInterface); virtual;
 end;

var
  frmQEK: TfrmQEK;

implementation

{$R *.dfm}

{ TfrmQEK }
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TfrmQEK.UpdateSpeedBtn;
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).ImageIndex := 0;
end;

procedure TfrmQEK.LoadImageList;
begin

  LoadImageFile(image_path+'tdc\greenBOX.bmp', ilGreenBox );
  LoadImageFile(image_path+'tdc\orangeBOX.bmp', ilOrangeBox );
  LoadImageFile(image_path+'tdc\blueBOX.bmp', ilBlueBox);

end;

procedure TfrmQEK.LoadImageFile(fName: string; imgL: TImageList);
var bmp :TBitmap;
begin
  bmp:=TBitmap.Create;
  bmp.LoadFromFile(fName);

  imgL.Add(bmp,nil);

  freebmp(bmp);
  bmp.free;
end;

procedure TfrmQEK.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//
end;


procedure TfrmQEK.FormCreate(Sender: TObject);
begin
  image_path := ExtractFilePath(Application.ExeName) + '..\data\images\';

  LoadImageList;

  UpdateSpeedBtn;

end;


procedure TfrmQEK.SetSpeedButtonGlyphNumber(const b: byte);
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).NumGlyphs := b;
end;

end.
