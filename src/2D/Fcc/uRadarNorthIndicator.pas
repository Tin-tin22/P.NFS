unit uRadarNorthIndicator;

interface

uses
  Windows, SysUtils, Math, Graphics;

type
  TRadarNorthIndicator = class
  private
    FVisible       : Boolean;
    FUseTrueMotion : Boolean; // TRUE: utara relatif heading kapal
    FHeadingDeg    : Double;  // heading kapal (0..360)

    FCenterX       : Integer; // pusat lingkaran radar
    FCenterY       : Integer;
    FRadiusPx      : Integer; // radius lingkaran radar (outer range ring)

    FTriangleColor : TColor;
    FTextColor     : TColor;
    FLineColor     : TColor;

    function NormalizeAngle(const A: Double): Double;
  public
    constructor Create;

    property Visible       : Boolean read FVisible write FVisible;
    property UseTrueMotion : Boolean read FUseTrueMotion write FUseTrueMotion;
    property HeadingDeg    : Double  read FHeadingDeg write FHeadingDeg;

    property CenterX       : Integer read FCenterX write FCenterX;
    property CenterY       : Integer read FCenterY write FCenterY;
    property RadiusPx      : Integer read FRadiusPx write FRadiusPx;

    property TriangleColor : TColor read FTriangleColor write FTriangleColor;
    property TextColor     : TColor read FTextColor write FTextColor;
    property LineColor     : TColor read FLineColor write FLineColor;

    procedure Draw(ACanvas: TCanvas);
  end;

implementation

{ TRadarNorthIndicator }

constructor TRadarNorthIndicator.Create;
begin
  inherited Create;
  FVisible       := True;
  FUseTrueMotion := False;
  FHeadingDeg    := 0;

  FCenterX       := 0;
  FCenterY       := 0;
  FRadiusPx      := 0;

  FTriangleColor := clWhite;
  FTextColor     := RGB(255,255,0); // kuning
  FLineColor     := RGB(0,200,0);   // hijau tipis
end;

function TRadarNorthIndicator.NormalizeAngle(const A: Double): Double;
var
  r: Double;
begin
  r := FMod(A, 360.0);
  if r < 0 then
    r := r + 360.0;
  Result := r;
end;

procedure TRadarNorthIndicator.Draw(ACanvas: TCanvas);
var
  baseAngleDeg : Double;
  angRad       : Double;
  cx, cy       : Integer;
  rOuter       : Integer;

  // triangle geometry
  tipR, baseR  : Double;
  halfBase     : Double;
  triPts       : array[0..2] of TPoint;

  // line geometry
  lineR1, lineR2: Double;
  x1, y1, x2, y2: Integer;

  // text
  txt          : string;
  txtX, txtY   : Integer;
  txtOffset    : Double;
  bLabelRad    : Double;
begin
  if not FVisible then Exit;
  if FRadiusPx <= 0 then Exit;

  cx     := FCenterX;
  cy     := FCenterY;
  rOuter := FRadiusPx;

  // Tentukan sudut penunjuk
  if FUseTrueMotion then
  begin
    // utara relatif heading kapal:
    // jika kapal heading 90°, utara berada di 270° (kiri),
    // jadi sudut = 0° - heading
    baseAngleDeg := NormalizeAngle(0 - FHeadingDeg);
  end
  else
  begin
    // selalu ke 0° (atas layar)
    baseAngleDeg := 0;
  end;

  angRad := DegToRad(baseAngleDeg);

//  // ---- Garis kecil dari pinggir lingkaran ke dalam ----
//  lineR1 := rOuter - 15; // mulai sedikit di dalam
//  lineR2 := rOuter - 3;  // berakhir dekat tepian
//
//  x1 := cx + Round(lineR1 * Sin(angRad));
//  y1 := cy - Round(lineR1 * Cos(angRad));
//  x2 := cx + Round(lineR2 * Sin(angRad));
//  y2 := cy - Round(lineR2 * Cos(angRad));
//
//  ACanvas.Pen.Style := psSolid;
//  ACanvas.Pen.Color := FLineColor;
//  ACanvas.MoveTo(x1, y1);
//  ACanvas.LineTo(x2, y2);

  // ---- Segitiga di pinggir lingkaran ----
  // tip sedikit di luar circle, base sedikit di dalam
  tipR   := rOuter + -2;
  baseR  := rOuter - 15;
  halfBase := 5; // setengah lebar alas

  // titik ujung (tip) ke arah baseAngle
  triPts[0].X := cx + Round(tipR * Sin(angRad));
  triPts[0].Y := cy - Round(tipR * Cos(angRad));

  // titik tengah alas
  x1 := cx + Round(baseR * Sin(angRad));
  y1 := cy - Round(baseR * Cos(angRad));

  // dua titik alas: geser ±90° dari arah utama
  // (supaya segitiga menghadap keluar)
  triPts[1].X := x1 + Round(halfBase * Sin(angRad + Pi/2));
  triPts[1].Y := y1 - Round(halfBase * Cos(angRad + Pi/2));

  triPts[2].X := x1 + Round(halfBase * Sin(angRad - Pi/2));
  triPts[2].Y := y1 - Round(halfBase * Cos(angRad - Pi/2));

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := FTriangleColor;
  ACanvas.Pen.Style   := psClear;
  Polygon(ACanvas.Handle, triPts[0], 3);

  // ---- Teks "0°" di luar segitiga ----
//  txt := '0°';
//
//  ACanvas.Font.Color := FTextColor;
//  ACanvas.Font.Size  := 8;
//  ACanvas.Brush.Style := bsClear;
//
//  txtOffset := 14; // jarak teks dari tip ke luar
//  bLabelRad := tipR + txtOffset;
//
//  txtX := cx + Round(bLabelRad * Sin(angRad)) - (ACanvas.TextWidth(txt) div 2);
//  txtY := cy - Round(bLabelRad * Cos(angRad)) - (ACanvas.TextHeight(txt) div 2);
//
//  ACanvas.TextOut(txtX, txtY, txt);
end;

end.

