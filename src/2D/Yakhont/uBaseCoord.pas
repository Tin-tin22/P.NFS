unit uBaseCoord;
{  system coordinate cartesian, polar,  degree - radian
}

interface

uses

  uDataTypes;

//==============================================================================
  function trueDistance(const x1, y1, x2, y2: double): double;
    { desc : menghitung jarak antara 2 titik di lingkaran besar.
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)

    }
  function CalcRange(const x1, y1, x2, y2: double): Double;
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

  function FormatAltitude(const s: single): string;
  procedure RangeBearingToCoord(const r, b: double; var mx, my : double);

const

  C_Degree_To_NauticalMile = 60.0;
  C_NauticalMile_To_Degree = 1.0 /60.0;
  C_NauticalMile_To_Metre  = 1852.0;
  C_NauticalMile_To_Feet = 6076.11549;



implementation

uses
  Math, SysUtils , uStringFunc;

//==============================================================================
{ Direction Conversion }

procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
begin  // return *relatif* coord to radar center
  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := r * cosx;
  my := r * sinx;
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

function CalcRange(const x1, y1, x2, y2: double): Double;
var
  dx, dy: Extended;
begin
   {input dec degree, output nautical mile, }
  dx := (x2 - x1) * C_Degree_To_NauticalMile;
  dy := (y2 - y1) * C_Degree_To_NauticalMile;

  result := sqrt(sqr(dx) + sqr(dy));
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
  Degree, Minute, Second: double;
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
  Degree, Minute, Second: double;
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
  sec: double;
  str: string;
begin
  Result := 0.0;
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
  sec: double;
  str: string;
begin
  Result := 0.0;
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
  m := dyGaris / dxGaris;
  c := ptFrom.y - m * ptFrom.x;
    // pers garis lurus y = mx+c
  dy := (m * pt.x + c) - pt.y;
    // pers garis lurus   x = (y-c)/m
  dx := ((pt.y - c) / m) - pt.x;

  dr := sqrt(dx * dx + dy * dy);

  result := abs(dx * dy / dr);
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
  result := IntToStr(i);
end;

function FormatAltitude(const s: single):string;
begin
  result := FormatFloat('0000',s);
end;

end.
