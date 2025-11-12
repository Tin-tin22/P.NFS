unit uRadarDynamicSector;

interface

uses
  Windows, SysUtils, Math, Graphics, Types,
  uCoordConverter;

type
  // Mode penentuan pusat sektor
  TCenterMode = (cmScreenCenter, cmMapPosition);

  // Satu slice sektor (multi slice dalam satu objek)
  TRadarSectorSlice = record
    BaseStartDeg : Double; // sudut awal (bearing)
    BaseEndDeg   : Double; // sudut akhir (bearing)
    MinRadius_m  : Double; // radius minimum (meter)
    MaxRadius_m  : Double; // radius maksimum (meter)
  end;

  TRadarDynamicSector = class
  private
    FSlices         : array of TRadarSectorSlice;

    FVisible        : Boolean;
    FColor          : TColor;

    FHeadingDeg     : Double;      // heading kapal (0°=utara)
    FCenterX        : Integer;     // posisi tengah di layar (screen)
    FCenterY        : Integer;
    FOuterRadiusPx  : Integer;     // radius pixel dari lingkaran radar (maksimal)
    FCurrentRange_m : Double;      // range maksimal layar (meter)

    FCenterMode     : TCenterMode;
    FMapPosX        : Double;      // koordinat X (lon kapal)
    FMapPosY        : Double;      // koordinat Y (lat kapal)
    FCoordConverter : TCoordConverter;

    function NormalizeAngle(const A: Double): Double;
    procedure UpdateCenterFromMode;
    function BuildSlicePolygon(const Slice: TRadarSectorSlice;
      out Points: TArray<TPoint>): Boolean;
  public
    constructor Create;

    property Visible       : Boolean read FVisible write FVisible;
    property Color         : TColor  read FColor   write FColor;
    property HeadingDeg    : Double  read FHeadingDeg write FHeadingDeg;
    property OuterRadiusPx : Integer read FOuterRadiusPx write FOuterRadiusPx;
    property CurrentRange_m: Double  read FCurrentRange_m write FCurrentRange_m;

    property CenterX       : Integer read FCenterX write FCenterX;
    property CenterY       : Integer read FCenterY write FCenterY;

    property CenterMode    : TCenterMode   read FCenterMode write FCenterMode;
    property MapPosX       : Double        read FMapPosX write FMapPosX;
    property MapPosY       : Double        read FMapPosY write FMapPosY;
    property CoordConverter: TCoordConverter read FCoordConverter write FCoordConverter;

    procedure Clear;
    procedure AddSlice(BaseStartDeg, BaseEndDeg: Double;
                       MinRadius_m, MaxRadius_m: Double);
    procedure ConvertCoord(cvt: TCoordConverter);
    procedure Draw(ACanvas: TCanvas);
  end;

implementation

{ TRadarDynamicSector }

constructor TRadarDynamicSector.Create;
begin
  inherited Create;
  FVisible        := True;
  FColor          := clRed;
  FHeadingDeg     := 0;
  FCenterX        := 0;
  FCenterY        := 0;
  FOuterRadiusPx  := 0;
  FCurrentRange_m := 1000; // default biar gak nol
  FCenterMode     := cmScreenCenter;
  SetLength(FSlices, 0);
end;

procedure TRadarDynamicSector.Clear;
begin
  SetLength(FSlices, 0);
end;

procedure TRadarDynamicSector.AddSlice(BaseStartDeg, BaseEndDeg: Double;
  MinRadius_m, MaxRadius_m: Double);
var
  n: Integer;
begin
  if MinRadius_m < 0 then MinRadius_m := 0;
  if MaxRadius_m < 0 then MaxRadius_m := 0;
  if MaxRadius_m < MinRadius_m then
    MaxRadius_m := MinRadius_m;

  n := Length(FSlices);
  SetLength(FSlices, n + 1);

  FSlices[n].BaseStartDeg := BaseStartDeg;
  FSlices[n].BaseEndDeg   := BaseEndDeg;
  FSlices[n].MinRadius_m  := MinRadius_m;
  FSlices[n].MaxRadius_m  := MaxRadius_m;
end;

procedure TRadarDynamicSector.ConvertCoord(cvt: TCoordConverter);
begin
  if cvt <> nil then
    FCoordConverter := cvt;
  UpdateCenterFromMode;
end;

procedure TRadarDynamicSector.UpdateCenterFromMode;
var
  ix, iy: Integer;
begin
  case FCenterMode of
    cmScreenCenter:
      ; // gunakan CenterX/CenterY yang sudah diatur di luar
    cmMapPosition:
      if Assigned(FCoordConverter) then
      begin
        FCoordConverter.ConvertToScreen(FMapPosX, FMapPosY, ix, iy);
        FCenterX := ix;
        FCenterY := iy;
      end;
  end;
end;

function TRadarDynamicSector.NormalizeAngle(const A: Double): Double;
var
  r: Double;
begin
  r := FMod(A, 360.0);
  if r < 0 then
    r := r + 360.0;
  Result := r;
end;

// Membentuk polygon sektor (clockwise, 0° di atas)
function TRadarDynamicSector.BuildSlicePolygon(
  const Slice: TRadarSectorSlice;
  out Points: TArray<TPoint>): Boolean;
var
  cx, cy: Integer;
  rMinPx, rMaxPx: Double;
  effStart, effEnd, spanCW: Double;
  steps, i, idx: Integer;
  bDeg, bRad: Double;
begin
  SetLength(Points, 0);
  Result := False;
  if (FOuterRadiusPx <= 0) or (FCurrentRange_m <= 0) then Exit;

  cx := FCenterX;
  cy := FCenterY;

  // ubah meter → pixel sesuai skala range
  rMaxPx := FOuterRadiusPx * (Slice.MaxRadius_m / FCurrentRange_m);
  rMinPx := FOuterRadiusPx * (Slice.MinRadius_m / FCurrentRange_m);
  if rMaxPx <= 0 then Exit;
  if rMaxPx > FOuterRadiusPx then rMaxPx := FOuterRadiusPx;
  if rMinPx < 0 then rMinPx := 0;
  if rMinPx > rMaxPx then rMinPx := rMaxPx;

  effStart := NormalizeAngle(Slice.BaseStartDeg + FHeadingDeg);
  effEnd   := NormalizeAngle(Slice.BaseEndDeg   + FHeadingDeg);

  spanCW := effEnd - effStart;
  if spanCW < 0 then spanCW := spanCW + 360.0;
  if spanCW <= 0 then Exit;

  steps := Max(8, Round(spanCW / 3.0));

  if rMinPx < 1 then
  begin
    // dari center
    SetLength(Points, steps + 2);
    idx := 0;
    Points[idx] := Point(cx, cy);
    Inc(idx);
    for i := 0 to steps do
    begin
      bDeg := effStart + spanCW * (i / steps);
      bDeg := NormalizeAngle(bDeg);
      bRad := DegToRad(bDeg);
      Points[idx].X := cx + Round(rMaxPx * Sin(bRad));
      Points[idx].Y := cy - Round(rMaxPx * Cos(bRad));
      Inc(idx);
    end;
  end
  else
  begin
    // annular
    SetLength(Points, (steps + 1) * 2);
    idx := 0;
    for i := 0 to steps do
    begin
      bDeg := effStart + spanCW * (i / steps);
      bRad := DegToRad(NormalizeAngle(bDeg));
      Points[idx].X := cx + Round(rMaxPx * Sin(bRad));
      Points[idx].Y := cy - Round(rMaxPx * Cos(bRad));
      Inc(idx);
    end;
    for i := 0 to steps do
    begin
      bDeg := effEnd - spanCW * (i / steps);
      bRad := DegToRad(NormalizeAngle(bDeg));
      Points[idx].X := cx + Round(rMinPx * Sin(bRad));
      Points[idx].Y := cy - Round(rMinPx * Cos(bRad));
      Inc(idx);
    end;
  end;

  Result := Length(Points) >= 3;
end;

procedure TRadarDynamicSector.Draw(ACanvas: TCanvas);
var
  i: Integer;
  pts: TArray<TPoint>;
begin
  if (not FVisible) or (Length(FSlices) = 0) or
     (FOuterRadiusPx <= 0) or (FCurrentRange_m <= 0) then Exit;

  UpdateCenterFromMode;

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := FColor;
  ACanvas.Pen.Style   := psClear;

  for i := 0 to High(FSlices) do
    if BuildSlicePolygon(FSlices[i], pts) then
      Polygon(ACanvas.Handle, pts[0], Length(pts));
end;

end.
