unit ufQEK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, SpeedButtonImage, uLibTDCClass, ExtCtrls;

type
  TcolorIndikator = (cRed, cYellow, cGreen);
  TfrmQEK = class(TForm)
    ilOrangeBox: TImageList;
    ilGreenBox: TImageList;
    ilBlueBox: TImageList;


    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected

     procedure LoadImageFile(fName: string; imgL: TImageList);
     procedure UpdateSpeedBtn;
     procedure SetSpeedButtonGlyphNumber(const b: byte);


     procedure UpdateImageIndikator(bmpRed, bmpYlw, bmpGrn : Tbitmap);
     procedure Createbitmap(var bmp_On, bmp_Off : Tbitmap; clr :TcolorIndikator);
     procedure freebmp(var bmp: TBitmap);
     procedure Destroybitmap(Var bmp: TBitmap);

  public
     IndikatorRedOff,
     IndikatorRedOn,
     IndikatorYellowOff,
     IndikatorYellowOn,
     IndikatorGreenOff,
     IndikatorGreenOn    : TBitmap;

    { Public declarations }
     image_path   : string;
     TDCInterface : TGenericTDCInterface;
     procedure LoadImageList; virtual;
     procedure LoadBmpFile(bmp: TBitmap; fName: string); virtual;
     procedure SetLocalVariable(tdc :TGenericTDCInterface); virtual;
     procedure SetImageIndikator(Var Img :TImage; clr :TcolorIndikator; IsOn : boolean);
 end;

var
  frmQEK: TfrmQEK;

implementation
uses
  uBaseConstan, RzBmpBtn;
{$R *.dfm}

{ TfrmQEK }
const IMAGES_PATH ='images/';


procedure TfrmQEK.Createbitmap(Var bmp_On, bmp_Off : Tbitmap; clr :TcolorIndikator);
begin
  bmp_On  :=TBitmap.Create;
  bmp_Off :=TBitmap.Create;

  case clr of
  cRed     :begin
             bmp_On.LoadFromFile('..\data\images\tdc\redROUND_down.bmp');
             bmp_Off.LoadFromFile('..\data\images\tdc\redROUND_up.bmp');
           end;
  cYellow  :begin
             bmp_On.LoadFromFile('..\data\images\tdc\orangeROUND_down.bmp');
             bmp_Off.LoadFromFile('..\data\images\tdc\orangeROUND_up.bmp');
           end;
  cGreen   :begin
             bmp_On.LoadFromFile('..\data\images\tdc\greenROUND_down.bmp');
             bmp_Off.LoadFromFile('..\data\images\tdc\greenROUND_up.bmp');
           end;
  end;
end;

procedure TfrmQEK.Destroybitmap(var bmp : Tbitmap);
begin
if Assigned(bmp) then begin

  freebmp(bmp);
  bmp.free;
end;
end;

procedure TfrmQEK.freebmp(var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TfrmQEK.UpdateImageIndikator(bmpRed, bmpYlw, bmpGrn : Tbitmap);
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TImage then begin
     if ((Components[i] as TImage).tag = 1001) then
       (Components[i] as TImage).Picture.Assign(bmpRed)
     else if ((Components[i] as TImage).tag = 1002) then
       (Components[i] as TImage).Picture.Assign(bmpYlw)
     else if ((Components[i] as TImage).tag = 1003) then
       (Components[i] as TImage).Picture.Assign(bmpGrn);
    end;

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
//  LoadImageFile(image_path+'tdc\greenBOX.bmp', ilGreenBox );
//  LoadImageFile(image_path+'tdc\orangeBOX.bmp', ilOrangeBox );
//  LoadImageFile(image_path+'tdc\blueBOX.bmp', ilBlueBox);
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

procedure TfrmQEK.LoadBmpFile(bmp: TBitmap; fName: string);
begin
  bmp.LoadFromFile(fName);
end;

procedure TfrmQEK.SetImageIndikator(var Img: TImage; clr: TcolorIndikator;
  IsOn: boolean);
begin
  case clr of
    cRed : begin
      if IsOn then
        Img.Picture.Assign(IndikatorRedOn)
      else
        Img.Picture.Assign(IndikatorRedOff);
    end;
    cYellow : begin
      if IsOn then
        Img.Picture.Assign(IndikatoryellowOn)
      else
        Img.Picture.Assign(IndikatorYellowOff);
    end;
    cGreen : begin
      if IsOn then
        Img.Picture.Assign(IndikatorGreenOn)
      else
        Img.Picture.Assign(IndikatorGreenOff);
    end;
  end;
end;

procedure TfrmQEK.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//
end;

procedure TfrmQEK.FormCreate(Sender: TObject);
begin
  image_path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4) + 'data\images\';
//  image_path := data_path + 'data\images\';
  LoadImageList;
  UpdateSpeedBtn;

  Createbitmap(IndikatorRedOn, IndikatorRedOff, cRed);
  Createbitmap(IndikatorYellowOn, IndikatorYellowOff, cYellow);
  Createbitmap(IndikatorGreenOn, IndikatorGreenOff, cGreen);

  UpdateImageIndikator(IndikatorRedOff, IndikatorYellowOff, IndikatorGreenOff);

end;


procedure TfrmQEK.FormDestroy(Sender: TObject);
begin
  Destroybitmap(IndikatorRedOn);
  Destroybitmap(IndikatorRedOff);
  Destroybitmap(IndikatorYellowOff);
  Destroybitmap(IndikatorYellowOn);
  Destroybitmap(IndikatorGreenOff);
  Destroybitmap(IndikatorGreenOn);
end;

procedure TfrmQEK.SetSpeedButtonGlyphNumber(const b: byte);
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).NumGlyphs := b;
end;

end.
