unit uRadarVisual;


interface

uses
  Windows, Graphics, Math, Types,
  uCoordConverter, System.SysUtils;

type
  {================ RANGE RINGS ================}
  TRadarRangeRings = class
  private
    FCircleRect     : TRect;
    FCenterX        : Integer;
    FCenterY        : Integer;
    FOuterRadiusPx  : Integer;

  public
    Visible         : Boolean;
    NumRings        : Integer;
    CurrentRange_m  : Double;   // meter
    PenColor        : TColor;
    FontColor       : TColor;

    property CircleRect: TRect read FCircleRect write FCircleRect;
    property CenterX: Integer read FCenterX;
    property CenterY: Integer read FCenterY;
    property OuterRadiusPx: Integer read FOuterRadiusPx;

    constructor Create;

    // Hitung posisi berdasarkan lingkaran clip; cvt disiapkan kalau nanti butuh.
    procedure ConvertCoord(cvt: TCoordConverter);

    procedure Draw(ACanvas: TCanvas);
  end;

  {================ SECTOR ================}
  TRadarSector = class
  private
    FCircleRect     : TRect;
    FCenterX        : Integer;
    FCenterY        : Integer;
    FRadiusPx       : Integer;

  public
    Visible         : Boolean;
    StartDeg        : Double;   // bearing, 0°=atas, clockwise
    EndDeg          : Double;
    Color           : TColor;

    // Mode:
    //  - TRUE  -> pakai full radius lingkaran bundar (PPI style)
    //  - FALSE -> radius proporsional dari Radius_m terhadap CurrentRange_m
    UseFixedPPI     : Boolean;
    Radius_m        : Double;   // hanya dipakai kalau UseFixedPPI = FALSE
    CurrentRange_m  : Double;   // untuk hitung proporsi
    MapCenterX      : Double;   // world X (lon)
    MapCenterY      : Double;   // world Y (lat)

    property CircleRect: TRect read FCircleRect write FCircleRect;

    constructor Create(AStartDeg, AEndDeg: Double; AColor: TColor; AUseFixedPPI: Boolean = True);

    procedure ConvertCoord(cvt: TCoordConverter);
    procedure Draw(ACanvas: TCanvas);
  end;

  {================ BEARING LINE ================}
  TRadarBearing = class
  private
    FCircleRect     : TRect;
    FCenterX        : Integer;
    FCenterY        : Integer;
    FLengthPx       : Integer;

  public
    Visible         : Boolean;
    BearingDeg      : Double;   // 0°=atas, clockwise
    Color           : TColor;
    LabelText       : string;

    property CircleRect: TRect read FCircleRect write FCircleRect;

    constructor Create(ABearingDeg: Double; AColor: TColor; const ALabel: string = '');

    procedure ConvertCoord(cvt: TCoordConverter);
    procedure Draw(ACanvas: TCanvas);
  end;

implementation

{ TRadarRangeRings }

constructor TRadarRangeRings.Create;
begin
  Visible        := True;
  NumRings       := 6;
  CurrentRange_m := 3000;
  PenColor       := RGB(180, 200, 200);
  FontColor      := clWhite;
  FCircleRect    := Rect(0,0,0,0);
  FCenterX       := 0;
  FCenterY       := 0;
  FOuterRadiusPx := 0;
end;

procedure TRadarRangeRings.ConvertCoord(cvt: TCoordConverter);
begin
  // cvt disiapkan kalau nanti mau world-based; saat ini pure PPI pakai CircleRect
  if (FCircleRect.Right > FCircleRect.Left) and
     (FCircleRect.Bottom > FCircleRect.Top) then
  begin
    FCenterX := (FCircleRect.Left + FCircleRect.Right) div 2;
    FCenterY := (FCircleRect.Top  + FCircleRect.Bottom) div 2;
    FOuterRadiusPx := (FCircleRect.Right - FCircleRect.Left) div 2;
  end
  else
  begin
    FCenterX := 0;
    FCenterY := 0;
    FOuterRadiusPx := 0;
  end;
end;

procedure TRadarRangeRings.Draw(ACanvas: TCanvas);
var
  i, radius: Integer;
  incKm, distKm: Double;
  s: string;
begin
  if (not Visible) or (NumRings <= 0) or (FOuterRadiusPx <= 0) then
    Exit;

  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Style   := psSolid;
  ACanvas.Pen.Color   := PenColor;

  ACanvas.Font.Color  := FontColor;
  ACanvas.Font.Size   := 7;

  incKm := (CurrentRange_m / 1000.0) / NumRings;

  for i := 1 to NumRings do
  begin
    radius := (FOuterRadiusPx * i) div NumRings;

    ACanvas.Ellipse(
      FCenterX - radius, FCenterY - radius,
      FCenterX + radius, FCenterY + radius
    );

    // label jarak di kanan ring
    distKm := incKm * i;
    s := FormatFloat('0.0', distKm);
    ACanvas.TextOut(
      FCenterX + radius + 4,
      FCenterY - (ACanvas.TextHeight(s) div 2),
      s
    );
  end;

  // label outer range
  s := FormatFloat('0.0', CurrentRange_m / 1000.0) + ' km';
  ACanvas.TextOut(
    FCenterX - (ACanvas.TextWidth(s) div 2),
    FCenterY + FOuterRadiusPx + 4,
    s
  );
end;

{ TRadarSector }

constructor TRadarSector.Create(AStartDeg, AEndDeg: Double; AColor: TColor; AUseFixedPPI: Boolean);
begin
  Visible        := True;
  StartDeg       := AStartDeg;
  EndDeg         := AEndDeg;
  Color          := AColor;
  UseFixedPPI    := AUseFixedPPI;
  Radius_m       := 3000;
  CurrentRange_m := 3000;
  MapCenterX     := 0;
  MapCenterY     := 0;
  FCircleRect    := Rect(0,0,0,0);
  FCenterX       := 0;
  FCenterY       := 0;
  FRadiusPx      := 0;
end;

procedure TRadarSector.ConvertCoord(cvt: TCoordConverter);
var
  cx, cy, outerR: Integer;
  ix, iy: Integer;
begin
  if (FCircleRect.Right <= FCircleRect.Left) or
     (FCircleRect.Bottom <= FCircleRect.Top) then
  begin
    FRadiusPx := 0;
    Exit;
  end;

  cx := (FCircleRect.Left + FCircleRect.Right) div 2;
  cy := (FCircleRect.Top  + FCircleRect.Bottom) div 2;
  outerR := (FCircleRect.Right - FCircleRect.Left) div 2;

  if UseFixedPPI then
  begin
    FCenterX  := cx;
    FCenterY  := cy;
    FRadiusPx := outerR;
  end
  else
  begin
    // world-based: radius proporsional Radius_m terhadap CurrentRange_m, dibatasi outerR
    if (cvt <> nil) and (CurrentRange_m > 0) then
    begin
      FCenterX := cx;
      FCenterY := cy;
      FRadiusPx := Round(outerR * (Radius_m / CurrentRange_m));
      if FRadiusPx < 0 then FRadiusPx := 0;
      if FRadiusPx > outerR then FRadiusPx := outerR;
    end
    else
    begin
      FCenterX  := cx;
      FCenterY  := cy;
      FRadiusPx := outerR;
    end;
  end;
end;

procedure TRadarSector.Draw(ACanvas: TCanvas);
var
  a1, a2: Double;
  x1, y1, x2, y2: Integer;
begin
  if (not Visible) or (FRadiusPx <= 0) then
    Exit;

  a1 := DegToRad(StartDeg - 90);
  a2 := DegToRad(EndDeg   - 90);

  ACanvas.Brush.Color := Color;
  ACanvas.Pen.Style   := psClear;

  x1 := FCenterX + Round(FRadiusPx * Cos(a1));
  y1 := FCenterY + Round(FRadiusPx * Sin(a1));
  x2 := FCenterX + Round(FRadiusPx * Cos(a2));
  y2 := FCenterY + Round(FRadiusPx * Sin(a2));

  Pie(ACanvas.Handle,
      FCenterX - FRadiusPx, FCenterY - FRadiusPx,
      FCenterX + FRadiusPx, FCenterY + FRadiusPx,
      x1, y1, x2, y2);
end;

{ TRadarBearing }

constructor TRadarBearing.Create(ABearingDeg: Double; AColor: TColor; const ALabel: string);
begin
  Visible    := True;
  BearingDeg := ABearingDeg;
  Color      := AColor;
  LabelText  := ALabel;
  FCircleRect := Rect(0,0,0,0);
  FCenterX    := 0;
  FCenterY    := 0;
  FLengthPx   := 0;
end;

procedure TRadarBearing.ConvertCoord(cvt: TCoordConverter);
begin
  if (FCircleRect.Right <= FCircleRect.Left) or
     (FCircleRect.Bottom <= FCircleRect.Top) then
  begin
    FLengthPx := 0;
    Exit;
  end;

  FCenterX  := (FCircleRect.Left + FCircleRect.Right) div 2;
  FCenterY  := (FCircleRect.Top  + FCircleRect.Bottom) div 2;
  FLengthPx := (FCircleRect.Right - FCircleRect.Left) div 2;
end;

procedure TRadarBearing.Draw(ACanvas: TCanvas);
var
  a: Double;
  x, y: Integer;
begin
  if (not Visible) or (FLengthPx <= 0) then
    Exit;

  a := DegToRad(BearingDeg - 90);

  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := Color;

  ACanvas.MoveTo(FCenterX, FCenterY);
  x := FCenterX + Round(FLengthPx * Cos(a));
  y := FCenterY + Round(FLengthPx * Sin(a));
  ACanvas.LineTo(x, y);

  if LabelText <> '' then
  begin
    ACanvas.Brush.Style := bsClear;
    ACanvas.Font.Color  := Color;
    ACanvas.Font.Size   := 8;
    ACanvas.TextOut(
      x - (ACanvas.TextWidth(LabelText) div 2),
      y + 4,
      LabelText
    );
  end;
end;

end.
