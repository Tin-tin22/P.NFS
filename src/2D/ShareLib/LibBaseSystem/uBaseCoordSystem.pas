unit uBaseCoordSystem;
{  system coordinate cartesian, polar,  degree - radian
}

interface

uses

  uDataTypes, Windows;

type
  TPointBOL = record
     x, y : Double;
   end;

//==============================================================================
  function trueDistance(const x1, y1, x2, y2: double): double;
    { desc : menghitung jarak antara 2 titik di lingkaran besar.
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)

    }
  function CalcRange(const x1, y1, x2, y2: double): Double;
  function CalcRange3D(const x1, y1, x2, y2, z1, z2: double): Double;
  function CalcMove(const x1, y1: double): Extended;
   { Euclid distance }

  function CalcBearing(const x1, y1, x2, y2: double): Double;
  { arc tan}

  procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);

  { Direction Conversion }
  function ConvCartesian_To_Compass(const degree: double): double;
  function ConvCompass_To_Cartesian(const degree: double): double;
  function ConvCustomAngleStart(const degree,startAngle: Double):Double;

  {Kompas direction}
  function DegComp_IsBeetwen(const aDegTes: double;
    const aDeg1, aDeg2: double): boolean;

  function ptToLineDistance(const ptFrom, ptTo, pt: t2DPoint): double;
  function ValidateDegree(const degreeOrg: double): double;

  function ptBetween2Point(const ptC, ptFrom, ptTo : t2DPoint; ratDiff : double): boolean;

 { ToString conversion - formatting }
  function formatDMS_long(const x: double): string;
  function formatDMS_latt(const y: double): string;
  //aldy
  function formatDM_longitude(const x: double): string;
  function formatDM_latitude(const y: double): string;

  function dmsToLong(const s: string): Double;
  function dmsToLatt(const s: string): Double;
  //aldy
  function dmToLongitude(const s: string): Double;
  function dmToLatitude(const s: string): Double;

  function FormatTrackNumber(const i: integer): string;

  function FormatCourse(const d: double): string; overload;
  function FormatCourse(const d: single): string; overload;

  function FormatSpeed(const d: double): string;

  function FormatTurnRate(const d: double): string;           // added by mizuki

  function FormatAltitude(const s: single): string;
  procedure RangeBearingToCoord(const r, b: double; var mx, my : double);

  function DistanceToHorizon(const h: double): double;
  function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;

  function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrHeight, tgtHeight : double; mode : integer):boolean;
  function IsPointInPolygon (const x,y : integer; x1, y1, x2, y2, x3, y3, x4, y4 : Integer): boolean;

const

  C_Degree_To_NauticalMile = 60.0;
  C_NauticalMile_To_Degree = 1.0 /60.0;
  C_NauticalMile_To_Metre  = 1852.0;
  C_NauticalMile_To_Feet = 6076.11549;
  C_NauticalMile_To_Yards = 2025.37183;
  C_Feet_To_Meter = 0.3048;
  C_Meter_To_NauticalMile = 1 / C_NauticalMile_To_Metre;
  C_Meter_To_Degree = C_Meter_To_NauticalMile * C_NauticalMile_To_Degree;
  C_Degree_To_Feet = C_Degree_To_NauticalMile * C_NauticalMile_To_Feet;



implementation

uses
  Math, SysUtils , uStringFunc;

//==============================================================================
{ Horizon View Calculation }

(*
Distance to horizon

At a height h above the ground, the distance to the horizon d, is given by:
  d = sqrt(2*R*h/b)

b=0.8279 is a factor that accounts for atmospheric refraction and depends
  on the atmospheric temperature lapse rate, which is taken to be standard.

  R is the radius of the earth. Note that the earth is assumed smooth- likely only true over the oceans!

For h in feet and d in nm:
 d =1.17*sqrt(h)

i.e. from 10000 feet, the horizon is 117nm awa
*)

function DistanceToHorizon(const h: double): double;
//const b = 0.8279;
//      R = 3438.147;
begin  //For h in feet and d in nm:
//  result := sqrt(2*R* (h /6076.11549) );
    result := sqrt(1.13169 * h);
end;

function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;
var s :double;
    d1, d2 : double;
begin
  s := trueDistance(x1, y1, x2, y2);
  d1 := DistanceToHorizon(h1);

  if s <  d1  then begin
    result := true;
  end
  else begin // behind the horizon
    d2 := DistanceToHorizon(h2);
    result := (d1 + d2) > s;
  end
end;

{
  ctrX, ctrY, X, Y : in degree
  radius in meter
}
function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrHeight, tgtHeight : double
         ; mode : integer):boolean;
var
  deltaX, deltaY, deltaR : double;
begin
  deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
  deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
  deltaR := sqrt((deltaX*deltaX)+(deltaY*deltaY));

  if mode = 1 then
    result := ((deltaR <= radius) and (ctrHeight < 0.5*tgtHeight))
  else
  if mode = 2 then
    result := deltaR <= radius;
end;

// PointInPolygon() function
function IsPointInPolygon (const x,y : integer;x1, y1, x2, y2, x3, y3, x4, y4 : Integer): boolean;
var
  PolyHandle: hRgn;
  aPolygon: array [0..3] of TPoint;
begin
  aPolygon[0].x := x1;
  aPolygon[0].y := y1;

  aPolygon[1].x := x2;
  aPolygon[1].y := y2;

  aPolygon[2].x := x3;
  aPolygon[2].y := y3;

  aPolygon[3].x := x4;
  aPolygon[3].y := y4;

  PolyHandle := CreatePolygonRgn(aPolygon[0], Length(aPolygon), Winding);
  result     := PtInRegion(PolyHandle,X,Y);
  DeleteObject(PolyHandle);
end;

//==============================================================================
{ Direction Conversion }

procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
    range : double;
begin
  range := r * C_NauticalMile_To_Degree;

  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := range * cosx;
  my := range * sinx;
end;

function ConvCustomAngleStart(const degree,startAngle: Double):Double;
begin
  result := startAngle - degree;
  if result < 0.0 then result := result + 360.0;
end;
function ConvCartesian_To_Compass(const degree: double): double;
begin
  // input : derajat (0..360) dari sumbu X, CCW, cartesian
  // output: derajat (0..360) dari utara,   CW, kompas

  result := 90.0 - degree;
  if result < 0.0 then result := result + 360.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ConvCompass_To_Cartesian(const degree: double): double;
begin
  // input : derajat (0..360) dari utara,   CW, kompas
  // output: derajat (0..360) dari sumbu X, CCW, cartesian

  result := 90.0 - degree;
  if result < 0.0 then result := result + 360.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function DegComp_IsBeetwen(const aDegTes: double;
  const aDeg1, aDeg2: double): boolean;
{compass direction}
var
  d1, d2: double;
begin
  d1 := (aDegTes - aDeg1);
  if d1 < 0.0 then d1 := d1 + 360.0;
//  while d1 < 0.0 do d1 := d1+ 360.0;

  d2 := (aDeg2 - aDeg1);
  if d2 < 0.0 then d2 := d2 + 360.0;
//  while d2 < 0.0 do d2 := d2+ 360.0;

  result := d1 < d2;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function IsDegreeDestAtLeft(const src, dest: double): boolean;
{ Cartesian }
{ return true jika dest dikiri (CCW) src, cartesian, east = 0 }
var
  back: double;
begin
  back := ValidateRange(dest - src, 360.0);
  result := (back - 180.0) < 0.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function trueDistance(const x1, y1, x2, y2: double): double;
const
  R = 3438.147;
begin
  result := ArcCos(sin(y1) * sin(y2) + cos(y1) * cos(y2) *
    cos(x2 - x1)) * R;
end;

function CalcRange3D(const x1, y1, x2, y2, z1, z2: double): Double;
var
  dx, dy, dz: Extended;
begin
   {input dec degree, output nautical mile, }
  dx := (x2 - x1) * C_Degree_To_NauticalMile;
  dy := (y2 - y1) * C_Degree_To_NauticalMile;
  dz := (z2 - z1) * C_Degree_To_NauticalMile;

  result := sqrt(sqr(dx) + sqr(dy) + sqr(dz) );
end;

function CalcRange(const x1, y1, x2, y2: double): Double;
var
  dx, dy: Extended;
begin
   {input dec degree, output nautical mile, }
  dx := (x2 - x1) * C_Degree_To_NauticalMile;
  dy := (y2 - y1) * C_Degree_To_NauticalMile;

  result := sqrt(sqr(dx) + sqr(dy));
end;

function CalcMove(const x1, y1: double): Extended;
var
  d : Extended;
begin
  d := (x1 - y1) * C_Degree_To_NauticalMile;

  result := d;
end;

function CalcBearing(const x1, y1, x2, y2: double): Double;
var
  dx, dy, bearing: Extended;
begin
   {input dec degree, output Compass Coord }
  dx := (x2 - x1);
  dy := (y2 - y1);
  bearing := RadToDeg(ArcTan2(dy, dx));
  result := ConvCartesian_To_Compass(bearing);
end;

//==============================================================================
procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);
{ x1, y1 : long lat degree
  aDist  : nautical Miles
  aDir   : Compas;
}
var dir : Double;
begin
  dir := DegToRad(90 - aCourse);

  X2 := X1 + C_NauticalMile_To_Degree * aDist * Cos(dir);
  Y2 := Y1 + C_NauticalMile_To_Degree * aDist * Sin(dir);

end;
//==============================================================================

procedure SplitDegreeMinuteSecond(const dd: double; var d, m, s: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := Trunc(MinDet);
  s := Frac(MinDet) * 60.0;
end;

procedure SplitDegreeMinute(const dd: double; var d, m: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := MinDet;
  {
  s := Frac(MinDet) * 60.0;
  }
end;

//==============================================================================

function formatDMS_long(const x: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('000', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

//==============================================================================

function formatDMS_latt(const y: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('00', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function formatDM_longitude(const x: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('000', Degree) + '° ' +
    FormatFloat('00.000', Minute) + ''' ' {+
    FormatFloat('00.0', second) + '" '};
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

function formatDM_latitude(const y: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('00', Degree) + '° ' +
    FormatFloat('00.000', Minute) + ''' ' {+
    FormatFloat('00.0', second) + '" '};

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function dmsToLong(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
begin
  Result := 0.0;
  if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 6, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[16] = 'W' then
    result := -result;
end;

function dmsToLatt(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
begin
  Result := 0.0;

  if length(s) < 15 then exit;
    // 123456789012345
    // 07° 52' 34.2" S

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 9, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[15] = 'S' then
    result := -result;

end;

function dmToLongitude(const s: string): Double;
var
  d: Integer;
  m : double;
  str: string;
begin
//  Result := 0.0;
  //if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E
  //115° 03.229' E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 6, 6);
  m := StrToFloat(str);
  {
  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);
  }
  result := d + (m / 60.0) {+ (sec / 3600.0)};

  if s[14] = 'W' then
    result := -result;
end;

function dmToLatitude(const s: string): Double;
var
  d: Integer;
  m : double;
  str: string;
begin
//  Result := 0.0;
  //if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E
  //00° 08.093' S
  //

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 6);
  M := StrToFloat(str);
  {
  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);
  }
  result := d + (m / 60.0) {+ (sec / 3600.0)};

  if s[13] = 'S' then
    result := -result;
end;

//==============================================================================
function ValidateDegree(const degreeOrg: double): double;
begin
  result := degreeOrg - (Floor(degreeOrg / 360.0) * 360.0);
end;

//==============================================================================

// point dalam degree, ratDiff dalam meter
function ptBetween2Point(const ptC, ptFrom, ptTo : t2DPoint;ratDiff : double): boolean;
var
  ptLnDist, dist, dist1, dist2 : double;
begin
  result := false;

  ptLnDist := ptToLineDistance(ptFrom,ptTo,ptC);
  ptLnDist := ptLnDist * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;

  if ptLnDist <= ratDiff then begin
    dist  := CalcRange(ptFrom.X,ptFrom.Y,ptTo.X,ptTo.Y) * C_NauticalMile_To_Metre;
    dist1 := CalcRange(ptFrom.X,ptFrom.Y,ptC.X,ptC.Y)   * C_NauticalMile_To_Metre;
    dist2 := CalcRange(ptTo.X,ptto.Y,ptC.X,ptC.Y)       * C_NauticalMile_To_Metre;

    result := abs(dist - (dist1 + dist2)) <= 1;
  end;

end;

function ptToLineDistance(const ptFrom, ptTo, pt: t2DPoint): double;
var
  dxGaris, dyGaris, dx, dy, dr: double;
  m, c: double;
begin
  dxGaris := (ptTo.x - ptFrom.x);
  if dxGaris = 0 then begin //==||==> vertikal line
    result := abs(pt.x - ptFrom.x);
    exit;
  end;
  dyGaris := (ptTo.y - ptFrom.y);
  if dyGaris = 0 then begin //==__==> horizontal Line
    result := abs(pt.y - ptFrom.y);
    exit;
  end;
  try
    m := dyGaris / dxGaris;
    c := ptFrom.y - m * ptFrom.x;
      // pers garis lurus y = mx+c
    dy := (m * pt.x + c) - pt.y;
      // pers garis lurus   x = (y-c)/m
    dx := ((pt.y - c) / m) - pt.x;

    dr := sqrt(dx * dx + dy * dy);

    result := abs(dx * dy / dr);
  except
    result := 1000;
  end;
end;

function FormatCourse(const d: double): string;
var
  i1, i2: Integer;
begin
  i1 := Trunc(Int(d)) mod 360;
  i2 := Trunc(Int(frac(d) * 10));
  result := Format('%3.3d.%1.1d', [i1, i2]);
end;

function FormatCourse(const d: single): string;
var
  i1, i2: Integer;
begin
  i1 := Floor(d) mod 360;
  i2 := Floor(frac(d) * 10);
  result := Format('%3.3d.%1.1d', [i1, i2]);
end;


function FormatSpeed(const d: double): string;
begin
  result := FormatFloat('00.0', abs(d));
end;

function FormatTrackNumber(const i: integer): string;
begin
  result := format('%4d', [i]);
end;

function FormatAltitude(const s: single):string;
begin
  result := FormatFloat('0000',s);
end;

function FormatTurnRate(const d: double): string;             // added by mizuki
var
  degMin : double;
begin
  //degMin := d * 60;                                      // (deg/s) -> (deg/min)
  result := FormatFloat('0.00', degMin);
end;

end.
