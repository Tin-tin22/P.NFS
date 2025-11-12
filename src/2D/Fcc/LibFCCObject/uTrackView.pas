unit uTrackView;

interface
uses
  Windows, Graphics, Types, SysUtils, GdiPlus, uBaseFunctionFCC;
type
  TBmpIdentView = class(TObject)
  private
    FBSize: integer;

    FBmpFrame: TBitmap; // loaded frame. from file.
    FBmpClr: TBitmap; // frame. colored.
    FBmpMain: TBitmap; // main symbol.

    FBmpBG: TBitmap; // Copied from canvas to perform transparent and
    // alphablend

    FBmp: TBitmap; // final bitmap, draw to canvas.
    FFillColor: TColor;

    procedure SetFrameFillColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCanvas: TCanvas);
    procedure LoadFrameBitmap(fName: string);
    procedure LoadMainBitmap(fName: string);
    procedure Initialize;

    property FrameFillColor: TColor read FFillColor write SetFrameFillColor;

  public
    Center: TPoint;
    Alpha: Byte;
    FrameVisible: boolean;
  published
    property Bmp: TBitmap read FBmp write FBmp;
    property BmpFrame: TBitmap read FBmpFrame write FBmpFrame;
    property BmpBG: TBitmap read FBmpBG write FBmpBG;
    property BmpClr: TBitmap read FBmpClr write FBmpClr;
    property BmpMain: TBitmap read FBmpClr write FBmpClr;
    property BSize: Integer read FBSize write FBSize;
  end;

implementation

const
  CL_IDGray = $007F7F7F;

procedure FreeBitmap(var Bmp: TBitmap);
begin
  with Bmp do
  begin
    Dormant;
    FreeImage;
    ReleaseHandle;
    Free;
  end;
  Bmp := nil;
end;
{ TBmpIdentView }

constructor TBmpIdentView.Create;
begin
  inherited;
  FrameVisible := true;

  Center.x := 100;
  Center.y := 100;

  FBSize := 32;
  FFillColor := clWhite;
  Alpha := 225;

  FBmpMain := TBitmap.Create;

  with FBmpMain do
  begin
    PixelFormat := pf8bit;
    Width := FBSize;
    Height := FBSize;
    Transparent := true;
    TransparentMode := tmFixed;
    TransparentColor := clFuchsia;
  end;

  FBmpFrame := TBitmap.Create;

  with FBmpFrame do
  begin
    PixelFormat := pf8bit;
    Width := FBSize;
    Height := FBSize;

  end;

  FBmpClr := TBitmap.Create;
  with FBmpClr do
  begin
    PixelFormat := pf8bit;
    Width := FBSize;
    Height := FBSize;
  end;

  FBmpBG := TBitmap.Create;
  with FBmpBG do
  begin
    PixelFormat := pf32bit;
    Width := FBmpFrame.Width;
    Height := FBmpFrame.Height;
  end;

  FBmp := TBitmap.Create;
  with FBmp do
  begin
    PixelFormat := pf32bit;
    Width := FBmpMain.Width;
    Height := FBmpMain.Height;
  end;
end;

destructor TBmpIdentView.Destroy;
begin
  FreeBitmap(FBmp);
  FreeBitmap(FBmpBG);

  FreeBitmap(FBmpClr);
  FreeBitmap(FBmpFrame);
  FreeBitmap(FBmpMain);

  inherited;
end;

procedure TBmpIdentView.Draw(aCanvas: TCanvas);
var
  h: integer;
begin
  inherited;
  h := (FBmp.Width + 1) shr 1;

  if FrameVisible then
  begin
    // FBmp.Canvas.Draw(0, 0,  FBmpClr);
    TransAlphaBlend(aCanvas, FBmpBG, FBmp, Center.x - h, Center.y - h, clFuchsia, Alpha); // coloring frame + main bitmap
  end
  else
  begin
//     TransAlphaBlend(aCanvas, FBmpBG, FBmpMain, Center.X - h, Center.Y - h, clFuchsia, Alpha);
  end;
//  TransAlphaBlend(aCanvas, FBmpBG, BmpMain, Center.x - h, Center.y - h, clFuchsia, Alpha);
end;

procedure TBmpIdentView.Initialize;
begin
  with FBmpFrame do
  begin
    Width := FBSize;
    Height := FBSize;
  end;

  with FBmpClr do
  begin
    Width := FBSize;
    Height := FBSize;
  end;

  with FBmpBG do
  begin
    Width := FBmpFrame.Width;
    Height := FBmpFrame.Height;
  end;

  with FBmp do
  begin
    Width := FBmpFrame.Width;
    Height := FBmpFrame.Height;
  end;
end;

procedure TBmpIdentView.LoadFrameBitmap(fName: string);
begin
  if not FileExists(fName) then
    raise Exception.Create(fName + ' not found!!')
  else begin
    FBmpFrame.LoadFromFile(fName);

    FBmpClr.Canvas.CopyMode := cmSrcCopy;

    FBmpClr.Canvas.StretchDraw(Rect(0, 0, FBSize, FBSize), FBmpFrame);

    ChangeBitmapIndex(FBmpClr, CL_IDGray, FFillColor);

    FBmp.Canvas.StretchDraw(Rect(0, 0, FBSize, FBSize), FBmpClr);
  end;
end;

procedure TBmpIdentView.LoadMainBitmap(fName: string);
begin
  if not FileExists(fName) then
    raise Exception.Create(fName + ' not found!!')
  else begin
    FBmpMain.LoadFromFile(fName);

    // FBmpClr.Canvas.CopyMode := cmSrcCopy;
    // FBmpClr.Canvas.Draw(0,0, FBmpMain);

    //FBmp.Canvas.Draw(0, 0, FBmpMain);
    FBmp.Canvas.StretchDraw(Rect(0, 0, fBSize, FBSize), FBmpMain);
  end;
end;

procedure TBmpIdentView.SetFrameFillColor(const Value: TColor);
begin
  if FFillColor = Value then
    Exit;

  FBmpClr.Canvas.CopyMode := cmSrcCopy;
  //FBmpClr.Canvas.Draw(0, 0, FBmpFrame);
  FBmpClr.Canvas.StretchDraw(Rect(0, 0, FBSize, FBSize), FBmpFrame);

  ChangeBitmapIndex(FBmpClr, CL_IDGray, Value);
  //FBmp.Canvas.Draw(0, 0, FBmpClr);
  FBmp.Canvas.StretchDraw(Rect(0, 0, FBSize, FBSize), FBmpClr);
end;

end.
