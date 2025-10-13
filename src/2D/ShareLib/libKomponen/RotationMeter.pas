unit RotationMeter;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics;

type

//==============================================================================
  TRGBPixel = record
    b, g, r : byte;
  end;

  ARGBPixel = array [0..1024] of TRGBPixel;
  pRGBPixel = ^ARGBPixel;

  TLine = (LTop, LBottom, LNone);

//==============================================================================
  TRotationBitmap = class
  private
    FTransparent: boolean;
    procedure setDegree(const Value: Single);
    function getHeight: integer;
    function getWidth: integer;
  protected
    FDegree: single;
    FBmpOri : TBitmap;
    FBmpRot : TBitmap;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromFile(const fName: string);
    procedure Draw(aCnv: TCanvas; const x, y: integer);

    property Rotation: Single read FDegree write setDegree;
    property Width: integer read getWidth;
    property Height: integer read getHeight;
  end;

//==============================================================================

  TRotationMeter = class(TGraphicControl)
  protected
    FBmpBG  : TBitmap;
    FBmpRot : TRotationBitmap;

    FCenter: TPoint;
    FDegree, FOffset, FMin, FMax, FScale, FScaleOut: single;
    FValue : Single;
    FLine : TLine;

    function getLine(const i: integer): TLine;
    procedure setLine(const i: integer; const val: TLine); virtual;

    function getValue(const i: integer): single;
    procedure setValue(const i: integer; const val: single); virtual;

    function getScale(const i: integer): single;
    procedure setScale(const i: Integer; const scale: single); virtual;

    function getScaleOut(const i: integer): single;
    procedure setScaleOut(const i: Integer; const scale: single); virtual;

    function getValueRange(const i: integer): single;
    procedure SetValueRange(const i: integer; const val: single); virtual;

    procedure Resize; override;
    procedure UpdateDegree; virtual;

  public
    { Public declarations }
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;

     procedure Paint; override;

     procedure LoadBGImage(const fName: string);
     procedure LoadImage(const fName: string);

  published
    property RotationOffset: single index 2 read getValue write setValue;

    property Value: single index 1 read getValue write setValue;
    property ValMin: single index 1 read getValueRange write SetValueRange;
    property ValMax: single index 2 read getValueRange write SetValueRange;
    property Scale: single index 1 read getScale write setScale;
    property ScaleOut: single index 1 read getScaleOut write setScaleOut;
    property Line: TLine index 1 read getLine write setLine;
  end;

//==============================================================================
  TCompassIndicator = class(TRotationMeter)
  protected
    FBmpIn : TRotationBitmap;
    FBmpOut: TRotationBitmap;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Paint; override;

    procedure LoadOutImage(const fName: string);
    procedure LoadInImage(const fName: string);
    procedure UpdateDegree; override;

  published
    property Scale: single index 1 read getScale write setScale;

  end;

procedure Register;

implementation

uses
  Math, Dialogs;

procedure Register;
begin
  RegisterComponents('DIDcomponent', [TRotationMeter, TCompassIndicator]);
end;

function getRGBPixBuf(const xCol, yRow:integer; bmp: TBitmap): TRGBPixel;
const p0: TRGBPixel = (b:0;g:0;r:0);
var pScL: pRGBPixel;
begin
  if (yRow >=0) and(yRow < bmp.height) and (xCol >=0) and (xCol < bmp.width ) then begin
   pScL :=  bmp.ScanLine[yRow];
   result := pScL[xCol]
  end
  else
    result := p0;
end;

function RotPoint(const x, y: integer; const aSin, aCos: Extended): TPoint;
begin
//x' = (x * cos A2) - (y * sin A2)
//y' = (x * sin A2) + (y * cos A2)

  result.X := Round(x * aCos - y * aSin);
  result.Y := Round(x * aSin + y * aCos);

end;

function OffPoint(const p: TPoint; const aDx, aDy: integer): TPoint;
begin
  Result.X := p.x + aDx;
  Result.Y := p.y + aDy;
end;

procedure Bmp_Rotate(bmpSrc, bmpDest: TBitmap; aDeg: single);
var i,j, fcx, fcy: integer;
    sinA,cosA : extended;
    ySinA, yCosA : Double;
    x,y : integer;
    x2,y2 : integer;
    pA : pRGBPixel;
begin
  bmpSrc.PixelFormat  := pf24bit;
  bmpDest.PixelFormat := pf24bit;

  bmpDest.Canvas.Brush.Color := clBlack;
  bmpDest.Canvas.FillRect(Rect(0, 0, bmpDest.Width, bmpDest.Height));

  SinCos(DegToRad(aDeg), sinA, cosA);

  fcx := bmpDest.Width  shr 1;
  fcy := bmpDest.Height shr 1;

  for j := 0 to bmpDest.Height-1 do begin
    y := (j - fcy);
    ySinA := y * sinA;
    yCosA := y * cosA;
    pA := bmpDest.ScanLine[j];

    for i := 0 to bmpDest.width-1 do begin
      x := (i - fcx);
      x2 := round(x * cosA - ySinA) + fcx;
      y2 := round(x * sinA + yCosA) + fcy;

      pA[i] := getRGBPixBuf(x2,y2, bmpSrc);
    end;
  end;
end;


procedure bmp_Destroy (var bmp: TBitmap);
begin
  Bmp.Width := 0;
  Bmp.Height := 0;
  Bmp.Dormant;             // Free up GDI resources
  Bmp.FreeImage;           // Free up Memory.
  Bmp.ReleaseHandle;       // Free up Handle.

  Bmp.Free;
  Bmp := nil;
end;

procedure SetBmpTranparent(var bmp: TBitmap);
begin
  with bmp do begin
    Transparent       := true;
    TransparentColor  := clBlack;
    TransparentMode   := tmFixed;
  end;

end;
procedure SetBmp(var bmpTo: TBitmap;  bmpFrom: TBitmap);
begin
  bmpTo.Width  := bmpFrom.Width;
  bmpTo.Height := bmpFrom.Height;
  bmpTo.Canvas.Draw(1, 1, bmpFrom);
end;

//==============================================================================
constructor TRotationBitmap.Create;
begin
  FBmpOri := TBitmap.Create;
  FBmpRot := TBitmap.Create;

//  setDegree(0);
end;

destructor TRotationBitmap.Destroy;
begin
  bmp_Destroy(FBmpRot);
  bmp_Destroy(FBmpOri);

  inherited;
end;

procedure TRotationBitmap.setDegree(const Value: Single);
begin
  FDegree := Value;
  Bmp_Rotate(FBmpOri, FBmpRot, FDegree);
end;

function TRotationBitmap.getHeight: integer;
begin
  Result := FBmpRot.Height;
end;

function TRotationBitmap.getWidth: integer;
begin
  Result := FBmpRot.Width;

end;

procedure TRotationBitmap.LoadFromFile(const fName: string);
begin
  FBmpOri.LoadFromFile(fName);
  SetBmpTranparent(FBmpOri);

  FBmpRot.Assign(FBmpOri);

  Bmp_Rotate(FBmpOri, FBmpRot, FDegree);
end;

procedure TRotationBitmap.Draw(aCnv: TCanvas; const x, y: integer);
begin
  aCnv.Draw(x, y, FBmpRot);

end;

//==============================================================================
{ TRotationMeter }

constructor TRotationMeter.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FBmpBG  := TBitmap.Create;

  FBmpRot := TRotationBitmap.Create;
//  FBmpRotIn := TRotationBitmap.Create;

  FOffset := 0.0;
  FDegree := 0.0;
  FMin    := 0.0;
  FMax    := 360.0;
  FScale  := 1.0;
end;

destructor TRotationMeter.Destroy;
begin
  FreeAndNil(FBmpRot);

  FreeAndNil(FBmpBG);

  inherited;
end;

//----------------------------------------------------------------------
function TRotationMeter.getLine(const i: integer): TLine;
begin

end;
procedure TRotationMeter.setLine(const i: integer; const val: TLine);
begin
  FLine := val;
end;
procedure TRotationMeter.setScale(const i: Integer; const scale: Single);
begin
  FScale := scale;
  UpdateDegree;
  Invalidate;
end;

function TRotationMeter.getScale(const i: integer): single;
begin
  Result := FScale;
end;

procedure TRotationMeter.setScaleOut(const i: Integer; const scale: Single);
begin
  FScaleOut := scale;
  UpdateDegree;
  Invalidate;
end;

function TRotationMeter.getScaleOut(const i: integer): single;
begin
  Result := FScaleOut;
end;

procedure TRotationMeter.UpdateDegree;
var iSat : single;
begin
  FDegree := FValue * FScale;//+ FOffset;
  iSat := FDegree - Round(FDegree /10.0 ) * 10.0;

  FBmpRot.Rotation  := -FDegree;

end;

function TRotationMeter.getValue(const i: integer): single;
begin
  result := FDegree;
end;

procedure TRotationMeter.setValue(const i: integer; const val: single);
begin
  case i of
    1:begin
      FValue := EnsureRange(val, FMin, FMax);
      end;
    2:begin
      FOffset := val;
      FValue := EnsureRange(val, FMin, FMax );

      end;
  end;
//  UpdateDegree;
//  Invalidate;
end;

function TRotationMeter.getValueRange(const i: integer): single;
begin
  case i of
    1: begin
      Result := FMin;
    end;
    2: begin
      Result := FMax;
    end;
  end;
end;

procedure TRotationMeter.SetValueRange(const i: integer; const val: single);
begin
  case i of
    1: begin
      FMin := val;

      if FValue < FMin then
        FValue := FMin;
    end;
    2: begin
      FMax := val;

      if FValue > FMax then
        FValue := FMax;
    end;
  end;
end;

procedure TRotationMeter.Paint;
var
  iLeft, iTop : integer;
  pnt : array [0..5] of TPoint;
begin
  inherited;

  iLeft :=  FCenter.X - (FBmpBG.Width  div 2);
  iTop  :=  FCenter.Y - (FBmpBG.Height div 2);
  Canvas.Draw(iLeft, iTop, FBmpBG);

  if csDesigning in ComponentState then begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(Rect( 1, 1, Width, Height));
    Canvas.Ellipse(Rect( 1, 1, Width, Height));
  end;

  iLeft :=  FCenter.X - (FBmpRot.Width  div 2);
  iTop  :=  FCenter.Y - (FBmpRot.Height div 2);
  FBmpRot.Draw(Canvas, iLeft, iTop);

  Canvas.Brush.Color := clGray;
  pnt[0].X := FCenter.X - 20;
  pnt[1].X := FCenter.X - 20;
  pnt[2].X := FCenter.X - 10;
  pnt[3].X := FCenter.X + 10;
  pnt[4].X := FCenter.X + 20;
  pnt[5].X := FCenter.X + 20;

  case FLine of
  LNone: begin

      end;
  LTop : begin
        pnt[0].Y := 8;
        pnt[1].Y := 12;
        pnt[2].Y := FCenter.Y - 30;
        pnt[3].Y := FCenter.Y - 30;
        pnt[4].Y := 12;
        pnt[5].Y := 8;

        Canvas.Polyline(pnt);
        Canvas.MoveTo(FCenter.X, 6);
        Canvas.LineTo(FCenter.X,FCenter.Y-30);

      end;
  LBottom : begin
        pnt[0].Y := FBmpRot.Height + 11;
        pnt[1].Y := FBmpRot.Height;
        pnt[2].Y := FCenter.Y + 30;
        pnt[3].Y := FCenter.Y + 30;
        pnt[4].Y := FBmpRot.Height;
        pnt[5].Y := FBmpRot.Height + 11;

        Canvas.Polyline(pnt);
        Canvas.MoveTo(FCenter.X, FBmpRot.Height + 13);
        Canvas.LineTo(FCenter.X,FCenter.Y+30);
      end;


  end;
  

end;

procedure TRotationMeter.Resize;
begin
  inherited;
  FCenter.X := Width shr 1;
  FCenter.Y := Height shr 1;
end;

procedure TRotationMeter.LoadBGImage(const fName: string);
begin
  FBmpBG.LoadFromFile(fName);

  Width := FBmpBG.Width;
  Height:= FBmpBG.Height;

  FCenter.X := Width  shr 1;
  FCenter.Y := Height shr 1;
end;

procedure TRotationMeter.LoadImage(const fName: string);
begin
  if FileExists(fName) then begin
    FBmpRot.LoadFromFile(fName);

//    setValue(FDegree);
  end;
end;

//==============================================================================

procedure TCompassIndicator.UpdateDegree;
var iPul: single;
begin
  FDegree := FValue * FScale;      //drmana?
//  ShowMessage(FloatToStr(FScale));
  iPul := FDegree;
  FBmpOut.Rotation  := - FScaleOut * FValue;
  FBmpIn.Rotation   := -ipul;

//  FBmp.Rotation := -36.0 * iSat;

end;

constructor TCompassIndicator.Create(aOwner: TComponent);
begin
  inherited;
  FBmpOut:= FBmpRot;
  FBmpIn := TRotationBitmap.Create;
end;

destructor TCompassIndicator.Destroy;
begin

  inherited;
end;

procedure TCompassIndicator.LoadInImage(const fName: string);
begin
  if FileExists(fName) then
    FBmpIn.LoadFromFile(fName);

    //LoadImage(fName);
end;

procedure TCompassIndicator.LoadOutImage(const fName: string);
begin
   LoadImage(fName);
end;

procedure TCompassIndicator.Paint;
var
  iLeft, iTop : integer;
  pnt : array [0..5] of TPoint;
begin
  inherited;

  iLeft :=  FCenter.X - (FBmpBG.Width  div 2);
  iTop  :=  FCenter.Y - (FBmpBG.Height div 2);
  Canvas.Draw(iLeft, iTop, FBmpBG);

  if csDesigning in ComponentState then begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(Rect( 1, 1, Width, Height));
    Canvas.Ellipse(Rect( 1, 1, Width, Height));
  end;

  iLeft :=  FCenter.X - (FBmpRot.Width  div 2);
  iTop  :=  FCenter.Y - (FBmpRot.Height div 2);
  FBmpRot.Draw(Canvas, iLeft, iTop);

  iLeft :=  FCenter.X - (FBmpIn.Width div 2);
  iTop  :=  FCenter.Y - (FBmpIn.Height div 2);
  FBmpIn.Draw(Canvas, iLeft, iTop);

  Canvas.Brush.Color := clGray;

  pnt[0].X := FCenter.X - 20;
  pnt[1].X := FCenter.X - 20;
  pnt[2].X := FCenter.X - 10;
  pnt[3].X := FCenter.X + 10;
  pnt[4].X := FCenter.X + 20;
  pnt[5].X := FCenter.X + 20;

  case FLine of
  LNone : begin

      end;
  LTop : begin
        pnt[0].Y := 8;
        pnt[1].Y := 12;
        pnt[2].Y := FCenter.Y - 30;
        pnt[3].Y := FCenter.Y - 30;
        pnt[4].Y := 12;
        pnt[5].Y := 8;

        Canvas.Polyline(pnt);
        Canvas.MoveTo(FCenter.X, 6);
        Canvas.LineTo(FCenter.X,FCenter.Y-30);

      end;
  LBottom : begin
        pnt[0].Y := FBmpRot.Height + 11;
        pnt[1].Y := FBmpRot.Height;
        pnt[2].Y := FCenter.Y + 30;
        pnt[3].Y := FCenter.Y + 30;
        pnt[4].Y := FBmpRot.Height;
        pnt[5].Y := FBmpRot.Height + 11;

        Canvas.Polyline(pnt);
        Canvas.MoveTo(FCenter.X, FBmpRot.Height + 13);
        Canvas.LineTo(FCenter.X,FCenter.Y+30);
      end;

  end;



  // Canvas.FrameRect(Rect  (FCenter.X - 10, 8, FCenter.X + 10, FCenter.Y - 20 ));

end;

end.
