unit uObjectVisual;

interface
uses
  Windows, Graphics, usimvisuals, ucoordconverter, uCoordDataTypes, GdiPlus,
  uBaseConst, uBaseFunctionFCC, uTrackView, Math;

type
// ------------------------------------------------------------------------------

  TBlindZoneVisual = class(TDrawElement)
  private

    FPartial: Boolean;
    // FWarZonedegree : Single;
    FSweep: Double;
    FIsPixelRange: Boolean;
  protected
    FHeading: Double;
    FAngles: array [0 .. 1] of single;
    FRanges: single;
    FStartPoint, FEndPoint: t2DPoint;
    FStartPointMin, FEndPointMin: t2DPoint;

    FRects: TRect;
    FRelativeStartAngle: Double;
    FRelativeEndAngle: Double;
    FSx, FSy, FEx, FEy: Double;

    FPointPos: TPoint;
    FText: string;
    FPenStyle: TPenStyle;
    FDashStyle: TGPDashStyle;
    FShowArea: Boolean;
    FShowBlind: Boolean;
    FShowBallistic: Boolean;
    FShowBlindMin: Boolean;

    FTextOffsetX, FTextOffsetY: Integer;

    function getAngle(index: Integer): single;
    procedure SetAngle(index: Integer; Angle: single);
    function getRelativeAngle(index: Integer): Double;
    function getAngleMin(const Index: Integer): single;
    procedure setAngleMin(const Index: Integer; Angle: single);
  published
  public
    mX, mY, mx1, my1: Double;
    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

  published
    property Ranges: single read FRanges write FRanges;
    property StartAngle: single index 0 read getAngle write SetAngle;
    property EndAngle: single index 1 read getAngle write SetAngle;
    property StartAngleMin: single index 0 read getAngleMin write setAngleMin;
    property EndAngleMin: single index 1 read getAngleMin write setAngleMin;
    property Heading: Double read FHeading write FHeading;
    property RelativeStartAngle: Double index 1 read getRelativeAngle;
    property RelativeEndAngle: Double index 0 read getRelativeAngle;
    property Text: string read FText write FText;
    property PenStyle: TPenStyle read FPenStyle write FPenStyle;
    property DashStyle: TGPDashStyle read FDashStyle write FDashStyle;
    property ShowArea: Boolean read FShowArea write FShowArea;
    property ShowBlind: Boolean read FShowBlind write FShowBlind;
    property ShowBallistic: Boolean read FShowBallistic write FShowBallistic;
    property Partial: Boolean read FPartial write FPartial;
    property Sweep: Double read FSweep write FSweep;

    property ShowBlindMin: Boolean read FShowBlindMin write FShowBlindMin;
    property TextOffsetX: Integer read FTextOffsetX write FTextOffsetX;
    property TextOffsetY: Integer read FTextOffsetY write FTextOffsetY;
    property IsPixelRange : Boolean read FIsPixelRange write FIsPixelRange;
  end;

  // circle view for radar range / weapon range
  TRangeVisual = class(TDrawElement)
  private
    FRects: TRect;
    FPnt1: TPoint;
    FPnt4: TPoint;
    FPnt2: TPoint;
    FPnt3: TPoint;
    FPointPos: TPoint;
    FText: string;
    FShowArea: Boolean;
    FShowAreaAft: Boolean;
    FShowAreaFwd: Boolean;
    FBmpArea: TBmpIdentView;
    FRangeScr: Integer;

    FAlpha: Byte;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  public
    LineStyles: TPenStyle;

    mX, mY: Double;
    Range: single; // nautical miles

    property Pnt1: TPoint read FPnt1 write FPnt1;
    property Pnt2: TPoint read FPnt2 write FPnt2;
    property Pnt3: TPoint read FPnt3 write FPnt3;
    property Pnt4: TPoint read FPnt4 write FPnt4;
    property Text: string read FText write FText;
    property ShowArea: Boolean read FShowArea write FShowArea;
    property ShowAreaFwd: Boolean read FShowAreaFwd write FShowAreaFwd;
    property ShowAreaAft: Boolean read FShowAreaAft write FShowAreaAft;
    property Alpha: Byte read FAlpha write FAlpha;
    // property BmpArea : TBmpIdentView read FBmpArea write FBmpArea;
  end;

  TRangeRingsVisual = class(TDrawElement)
  private
    FRects : array of TRect;
    FNumOfRanges   : integer;

    procedure SetNumOfRange(const i: integer);

  public
    mX, mY: Double;
    Interval : Single;        // nautical miles

    constructor Create;
    destructor Destroy; override;

    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    property  RangeNum: Integer read FNumOfRanges write SetNumOfRange;
  end;

implementation

{ TBlindZoneVisual }

procedure TBlindZoneVisual.ConvertCoord(cvt: TCoordConverter);
var
  r, r1: Integer;
  rDegree, rDegree1: Double;
  dX, dY, dx1, dy1: Double;
  pt: TPoint;
begin
  inherited;
  if StartAngle = EndAngle then
    exit;

  cvt.ConvertToScreen(mX, mY, Fcenter.X, Fcenter.Y);



  if FIsPixelRange then
  begin
//    rDegree := Ranges * C_NauticalMile_To_Degree;
//    dX := mX + rDegree;
//    dY := mY;
//
//    cvt.ConvertToScreen(dX, dY, pt.X, pt.Y);

    r := 5000;
  end
  else
  begin
    rDegree := Ranges * C_NauticalMile_To_Degree;
    dX := mX + rDegree;
    dY := mY;

    cvt.ConvertToScreen(dX, dY, pt.X, pt.Y);

    r := abs(pt.X - Center.X);
  end;

  FRelativeStartAngle := StartAngle;
  FRelativeStartAngle := ConvCompass_To_Cartesian(FRelativeStartAngle);
  FRelativeStartAngle := ConvCustomAngleStart(FRelativeStartAngle, FHeading);
  FRelativeStartAngle := FRelativeStartAngle * C_DegToRad;

  FRelativeEndAngle := EndAngle;
  FRelativeEndAngle := ConvCompass_To_Cartesian(FRelativeEndAngle);
  FRelativeEndAngle := ConvCustomAngleStart(FRelativeEndAngle, FHeading);
  FRelativeEndAngle := FRelativeEndAngle * C_DegToRad;

  FEndPoint.X := Center.X + Round(Cos(FRelativeStartAngle) * r);
  FEndPoint.Y := Center.Y + Round(Sin(FRelativeStartAngle) * r);
  FStartPoint.X := Center.X + Round(Cos(FRelativeEndAngle) * r);
  FStartPoint.Y := Center.Y + Round(Sin(FRelativeEndAngle) * r);

  FRects.Left := Center.X - r;
  FRects.Top := Center.Y - r;
  FRects.Right := Center.X + r;
  FRects.Bottom := Center.Y + r;

  cvt.ConvertToMap(Round(FStartPoint.X), Round(FStartPoint.Y), FSx, FSy);
  cvt.ConvertToMap(Round(FEndPoint.X), Round(FEndPoint.Y), FEx, FEy);

  FPointPos.X := pt.X;
  FPointPos.Y := pt.Y;

end;

constructor TBlindZoneVisual.Create;
begin
  FAlpha := 255;
  FDashStyle := DashStyleSolid;
  FTextOffsetX := -5;
  FTextOffsetY := -5;
end;

destructor TBlindZoneVisual.Destroy;
begin

  inherited;
end;

procedure TBlindZoneVisual.Draw(aCanvas: TCanvas);
var
  i: Integer;
  cl: TGPColor;
  p: IGPPen;
  b: IGPBrush;
  rect: TGPRectF;
  Graphics: IGPGraphics;
  rad: Integer;
  aStart, aSweep, aEnd: single;
  pt1, pt2: TGPPoint;
begin
//  inherited;
  if StartAngle = EndAngle then
    exit;

  Graphics := TGPGraphics.Create(aCanvas.Handle);
  cl := TGPColor.MakeARGB(FAlpha, 255, 255, 255);
  p := TGPPen.Create(cl, 2);
  p.DashStyle := FDashStyle;
  b := TGPHatchBrush.Create(HatchStyleDottedDiamond, TGPColor.Create
        (FAlpha div 2, 255, 255, 255), TGPColor.Create(FAlpha div 4, 255, 255, 255)
      );

  rad := (FRects.Right - FRects.Left) div 2;
  rect := TGPRectF.Create(Center.X - rad, Center.Y - rad, rad * 2, rad * 2);
  aStart := FRelativeStartAngle * C_RadToDeg;
  aEnd := FRelativeEndAngle * C_RadToDeg;

  if not FShowArea then begin
    with Graphics do begin
      DrawArc(p, rect, aStart, FSweep);

      pt1 := TGPPoint.Create(Center.X, Center.Y);
      pt2 := TGPPoint.Create(Round(FStartPoint.X), Round(FStartPoint.Y));
      DrawLine(p, pt1, pt2);

      pt1 := TGPPoint.Create(Center.X, Center.Y);
      pt2 := TGPPoint.Create(Round(FEndPoint.X), Round(FEndPoint.Y));
      DrawLine(p, pt1, pt2);
    end;

  end else begin
    Graphics.FillPie(b, rect, aStart, FSweep);

  end;

  with aCanvas do
  begin
//    Brush.Style := bsClear;

    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psDot;

    font.Name := 'Arial';
    font.Size := 8;
    font.Color := Color;
    SetBkMode(aCanvas.Handle, TRANSPARENT);

    TextOut(FPointPos.X + FTextOffsetX, FPointPos.Y + FTextOffsetY, FText);
  end;

end;

function TBlindZoneVisual.getAngle(index: Integer): single;
begin
  result := FAngles[index];
end;

function TBlindZoneVisual.getAngleMin(const Index: Integer): single;
begin
  result := FAngles[index];
end;

function TBlindZoneVisual.getRelativeAngle(index: Integer): Double;
begin
  case index of
    0:
      result := CalcBearing(mX, mY, FSx, FSy);
    1:
      result := CalcBearing(mX, mY, FEx, FEy);
  end;
end;

procedure TBlindZoneVisual.SetAngle(index: Integer; Angle: single);
begin
  FAngles[index] := Angle;
end;

procedure TBlindZoneVisual.setAngleMin(const Index: Integer; Angle: single);
begin
  FAngles[index] := Angle;
end;

{ TRangeVisual }

procedure TRangeVisual.ConvertCoord(cvt: TCoordConverter);
var
  r: Integer;
  rDegree: Double;
  dX, dY: Double;
  pt: TPoint;
begin
  inherited;

  cvt.ConvertToScreen(mX, mY, Fcenter.X, Fcenter.Y);

  if abs(Range) < 0.0000001 then
    exit;

  rDegree := Range * C_DataMile_To_Degree;
  dX := mX + rDegree;
  dY := mY;

  cvt.ConvertToScreen(dX, dY, pt.X, pt.Y);
  r := abs(pt.X - Center.X);
  FRangeScr := r;
  FRects.Left := Center.X - r;
  FRects.Top := Center.Y - r;
  FRects.Right := Center.X + r;
  FRects.Bottom := Center.Y + r;

  FPointPos.X := pt.X;
  FPointPos.Y := pt.Y;

end;

constructor TRangeVisual.Create;
begin
  inherited;

  Color := clWhite;
  LineStyles := psDot;
  FAlpha := 255;
  Size := 1;
end;

destructor TRangeVisual.Destroy;
begin

  inherited;
end;

procedure TRangeVisual.Draw(aCanvas: TCanvas);
var
  aX, aY: Integer;
  i: Integer;
  cl: TGPColor;
  p: IGPPen;
  b: IGPBrush;
  rect, rectR: TGPRectF;
  Graphics: IGPGraphics;
  rad: Integer;
  clDiv2 : TGPColor;
  red, green, blue : Byte;
//  rct : TRect;           /
begin
  inherited;
  if not Visible then
    exit;

  Graphics := TGPGraphics.Create(aCanvas.Handle);

  red := GetRValue(Color);
  green := GetGValue(Color);
  blue := GetBValue(Color);

  cl := TGPColor.MakeARGB(FAlpha, red, green, blue);
  p := TGPPen.Create(cl, Size);
  p.DashStyle := DashStyleDash;

  rad := (FRects.Right - FRects.Left);
  rectR := TGPRectF.Create(FRects.Left, FRects.Top, rad, rad);

  if (rectR.X <> 0) and (rectR.Y <> 0) and (rectR.Width <> 0) and (rectR.Height <> 0) then
    Graphics.DrawArc(p, rectR, 0, 360);

  if FShowArea then
  begin
    clDiv2 := TGPColor.MakeARGB(FAlpha div 2, red, green, blue);
    b := TGPHatchBrush.Create(HatchStyleDottedDiamond, cl, clDiv2);

    rad := (FRects.Right - FRects.Left) div 2;
    if rad > 0 then
    begin
      rect := TGPRectF.Create(Center.X - rad, Center.Y - rad, rad * 2, rad * 2);
      Graphics.FillPie(b, rect, 0, 360);
//      rct.Left := Center.X - rad;
//      rct.Top := Center.Y - rad;
//      rct.Right := center.X + rad;
//      rct.Bottom := Center.Y + rad;
//      aCanvas.Pen.Width := 3;
//      aCanvas.Arc(rct.Left, rct.Top , rct.Right, rct.Bottom, 0,0,0,0);
    end;
  end;

  with aCanvas do
  begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psDot;

    font.Name := 'Arial';
    font.Size := 8;
    font.Color := Color;
    SetBkMode(aCanvas.Handle, TRANSPARENT);

    TextOut(FPointPos.X - 5, FPointPos.Y - 5, FText);

  end;

end;

{ TRangeRingsVisual }

procedure TRangeRingsVisual.ConvertCoord(cvt: TCoordConverter);
var i : integer;
    r : integer;
    rDegree: double;
    dx, dy: double;
    pt : TPoint;
begin
  if not (FFinalShow) then
    Exit;
  if abs(Interval) < 0.000001 then
    exit;

  cvt.ConvertToScreen(mx, my, FCenter.X, FCenter.Y);

// original:
  rDegree := Interval * C_NauticalMile_To_Degree;
  dx := mX + rDegree;
  dy := mY;
  cvt.ConvertToScreen(dx, dy, pt.X, pt.Y );

  r := Abs(pt.X - Center.X);

  //experimental:
//  r := cvt.NauticalMilesToPixels(Interval);

  for i := 0 to FNumOfRanges-1 do begin

    FRects[i].Left   := Center.X - r * (i + 1);
    FRects[i].Top    := Center.Y - r * (i + 1);
    FRects[i].Right  := Center.X + r * (i + 1);
    FRects[i].Bottom := Center.Y + r * (i + 1);
  end;

end;

constructor TRangeRingsVisual.Create;
begin
  FNumOfRanges := 4;
  SetLength(FRects, FNumOfRanges);

  mX := 0.0;
  mY := 0.0;

  Interval  := 0.5; // nautical miles
  RangeNum  := 4;
end;

destructor TRangeRingsVisual.Destroy;
begin

  inherited;
end;

procedure TRangeRingsVisual.Draw(aCanvas: TCanvas);
var i : integer;
begin

  // vFilter dipindah ke sim manager client
  //  if not (Visible and vFilter.Show(pftNone, 'Range rings', 'Display information')) then
  //    Exit;

  if not (FFinalShow) then
    Exit;

  aCanvas.Pen.Color := Color;
  aCanvas.Pen.Style := psSolid;
  for i := 0 to FNumOfRanges - 1 do
  begin
    aCanvas.Arc(FRects[i].Left, FRects[i].Top, FRects[i].Right,
      FRects[i].Bottom, 0, 0, 0, 0);
  end;
end;

procedure TRangeRingsVisual.SetNumOfRange(const i: integer);
begin
  FNumOfRanges := i;
  SetLength(FRects, FNumOfRanges);
end;

end.
