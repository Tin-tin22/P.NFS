unit uBaseCoordSystem;
{
-=-- did Simulation Framework  -----=-
  desc     :  system coordinate conversiopn between
              cartesian - polar,
              degree - radian
  lastedit :  2012 02 24

-=-------------------------------------------------------=-
}

interface

uses
  uCoordDataTypes;

//==============================================================================
  {01 point function }

  { Euclid distance }
  function CalcRange(const x1, y1, x2, y2: double): Double;
    { desc : menghitung jarak euclidian 2 dimensi antara 2 titik
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)
    }

  function CalcMove(const x1, y1: double): Extended;
   { Euclid distance }

  function CalcRangeDM(const x1, y1, x2, y2: double): Double;
    { desc : menghitung jarak euclidian 2 dimensi antara 2 titik
      input: Koordinat long lat 2 titik
      ouput: jarak (data miles)
    }

  function CalcRange3D(const x1, y1, z1,  x2, y2, z2: double): Double;
    { desc : menghitung jarak euclidian 3 dimensi antara 2 titik
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)
    }

  function CalcRange3DDM(const x1, y1, z1,  x2, y2, z2: double): Double;
    { desc : menghitung jarak euclidian 3 dimensi antara 2 titik
      input: Koordinat long lat 2 titik
      ouput: jarak (data miles)
    }

  { 02 direction function
   }
  function ValidateDegree(const aDegree: double): double;
    { desc  : memastikan range degree antara 0 .. 360
      input : degree, anything
      output: 0 <= output < 360.0
    }

  procedure RangeBearingToCoordDM(const aRange, aBearing: double; var mx, my : double);
  { desc  : mengkonversi coord polar (range bearing) sebuah titik
              ke sistem coordinat cartesian (mx, my)
      input : aRange (data miles) aBearing (degree compass)
      output: koordinat titik dalam degree long lat
    }

  function ConvCartesian_To_Compass(const degree: double): double;
    { desc  : mengkonversi arah, dari system cartesian ke compass
      input : derajat (0..360) dari sumbu X (east ), CCW, cartesian
      output: derajat (0..360) dari sumbu Y (north),  CW,    kompas
    }

  function ConvCompass_To_Cartesian(const degree: double): double;
    { desc  : mengkonversi arah, dari system compass ke cartesian
      input : derajat (0..360) dari sumbu Y (north),  CW,   compass
      output: derajat (0..360) dari sumbu X (east ), CCW, cartesian
    }

  function CalcBearing(const x1, y1, x2, y2: double): Double;
    { desc  : menghitung baringan (arah dari utara)   (compass)
      input : p1(x1, y1) , p2(x2, y2) long lat
      output: arah compass p2 dari p1
    }

  procedure RangeBearingToCoord(const aRange, aBearing: double; var mx, my : double);
    { desc  : mengkonversi coord polar (range bearing) sebuah titik
              ke sistem coordinat cartesian (mx, my)
      input : aRange (nauticl miles) aBearing (degree compass)
      output: koordinat titik dalam degree long lat
    }

  procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);
    { desc  : menghitung posisi 2d sebuah titik dari titik x1 y1 ke arah aCourse
              sejauh aDist
      input : x1, y1 : long lat
              aDist  : nautical miles
              aCourse: compass
      output: x2, y2 : long lat
    }

  function DegComp_IsBeetwen(const aDegTes: double;
    const aDeg1, aDeg2: double): boolean;
    { desc  : menentukan apakah sebuah derajat berada di antara sudut kecil
              diantara dua derajat yang lain
      input : degree, compass
      output: true / false
    }

  function ptToLineDistance(const ptFrom, ptTo, pt: t2DPoint): double;
    { desc  : menghitung jarak sebuah titik ke garis
      input : koordinat titik dan garis
      output: jarak, dalam satuan yang sama dengan input
    }

  function ptBetween2Point(const ptFrom, ptTo, pt : t2DPoint;
    const aDist: Double = 0.0): boolean;
    { desc  : menentukan apakah sebuah berada di garis, dengan toleransi aDist
      input : koordinat titik dan garis, toleransi
      output: true / false
    }
  { earth as sphere}
  function trueDistance(const x1, y1, x2, y2: double): double;
    { desc : menghitung jarak antara 2 titik di lingkaran besar.
      input: Koordinat long lat 2 titik
      ouput: jarak (nautical miles)
    }
  function DistanceToHorizon(const h: double): double;
   { desc   : menghitung jarak pandang horizon dilihat dari ketinggian h
      input : h (feet)
      output: distance (nautical miles)
    }

  function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;
   { desc   : menentukan apakah dua titik berada di atas horizon atau tidak
      input : x1, y1(degree long lat)   h (feet), x2, y2(degree long lat) h (feet),
      output: true / false
    }

  procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);
    { desc  : mengkonversi arah dari degree compass ke Red / Green
      input : arah degree compass
      output: aDir = 'R'  : kiri
              aDir = 'G'  : kanan
              aVal (0 .. 180) 0 = north
    }

  function ConvCustomAngleStart(const degree,startAngle: Double):Double;
  { !! string format di pindah ke uCoordStringFormat }

  function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double; mode : integer):boolean;

   // Radius in metre
  function IsInsideGlobe(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double):boolean;


  procedure ConvLattLongToMGRS(const latt, long: Double;
    var aNorthing, aEasting : Double;
    var aZoneNumber : Integer;
    var aZoneLetter : String;
    var aDigraph    : String);
  {
    desc : Mengkonversi Latitude dan Longitude ke dalam bentuk MGRS
    input : latt, long = decimal
    output : aNorthing, aEasting = 4 digit
             aZoneNumber = Nomor Zone
             aZoneLetter = Huruf Zone
             aDigraph   = Square Digraph, eg : FN
    eg : 49MFN10452613
  }

  procedure ConvMGRStoLattLong(const aZone, aSq : String;const aEasting, aNorthing : Double;
    var Latt, Long : Double);
  {
    desc : Mengkonversi koordinat MGRS ke dalam Latitude dan Longitude
    input : aNorthing, aEasting = 4 digit -- eg : north := 2613, east := 1045
             aZone = Zone -- eg : 49M
             aSq   = Digraph, eg : FN -- restriction : only 2 letters
    output : latt, long = decimal
  }


  procedure ConvDMCartesianToDegree(const X, Y : Double; var a, b : Double);
  {
    desc : mengkonversi koordinat kartesian dalam Datamile ke degree related to point
    input : x, y dalam datamile
    output : koordinat titik dalam degree long latt
  }

  procedure ConvLattLongToCartesianDM(const aPosX, aPosY, bPosX, bPosY : Double;
    var x, y:Double);
   {
      desc : mengkonversi Latt Long ke koordinat kartesian
      input : posisi a = pusat, b = titik lain
      output : koordinat x, y kartesian dalam datamile
   }
  function UTMLetterConv(const paramDouble : Double): Char;

  procedure ReverseAngle(const aDeg: Double; var aRevDeg: Double);

  function CalcElevation(const aRng, aHgt : Double) : Double;
  {
    desc : menghitung elevasi
    input : range target & tinggi target
    output : elevasi dalam degree
  }

  { calc prediction hit point beetwen 2 object }
  procedure CalcHitPredition(
     const tRange, tBearing, tSpeed, tCourse: double;
     const pSpeed: double;
     var hRange, hBearing, hTime, hSpeed: double);

  procedure ConvertToPPI(aMax:Double; aRad: Integer;aStartX, aStartY: Integer; aOffsetX, aOffsetY: Double;
    dx, dy: double; var ix, iy: integer);

const
  C_2_Pi          = 2.0 * Pi;
  C_RadToDeg      = 180.0 / Pi;
  C_DegToRad      = Pi / 180.0;
  C_DegToMiliRad   = C_DegToRad * 1000;
  C_MiliRadToDeg   = C_RadToDeg / 1000;

  C_Degree_To_NauticalMile    = 60.0;
  C_Degree_To_DataMile        = 60.0 *  6000.0 / 6076.11549;
  C_Degree_To_Meter           = 60.0 * 1852.0;

  C_NauticalMile_To_Degree    = 1.0 /60.0;
  C_NauticalMile_To_Metre     = 1852.0;
  C_NauticalMile_To_Feet      = 6076.11549;
  C_NauticalMile_To_Yards     = 2025.37183;
  C_NauticalMile_To_DataMile  = 6076.11549 / 6000.0;  // nm to feet / nm to DM

  C_MperS2_to_KnotperS = 1.9438;
  C_MperS_to_FtperMinutes = 196.85;
  C_DM_to_Knots = 0.868976241901;
  C_Knots_to_DMH = 1 / C_DM_to_Knots;

  C_DataMile_To_Feet          = 6000.0;
  C_DataMile_To_NauticalMile  = 6000.0 / 6076.11549;
  C_DataMile_To_yard          = 2000.0;
  C_DataMile_To_degree        = 1.0 / C_Degree_To_DataMile;
  C_DataMile_To_Metre         = 1828.8;
  C_DataMile_To_kyard         = C_DataMile_To_yard / 1000;

  C_Feet_To_Meter             = 0.3048;
  C_Meter_To_NauticalMile     = 1.0 / C_NauticalMile_To_Metre;
  C_Meter_To_Feet             = 3.2808399;
  C_Meter_To_DataMile         = 1.0 / C_DataMile_To_Metre;
  C_HFeet_To_Meter            = C_Feet_To_Meter * 100;
  C_Meter_To_HFeet            = 1.0 / C_HFeet_To_Meter;
  C_HFeet_To_Feet             = 100;
  C_Feet_To_HFeet             = 1.0/100;

  C_Meter_To_Degree           = C_Meter_To_NauticalMile * C_NauticalMile_To_Degree;
  C_Degree_To_Feet            = C_Degree_To_NauticalMile * C_NauticalMile_To_Feet;

  C_Yards_To_NauticalMile     = 1.0 / C_NauticalMile_To_Yards;
  C_Yards_To_DataMile         = 1.0 / C_DataMile_To_yard;

  C_KYards_To_DataMile        = 1.0 / C_DataMile_To_yard * 1000;
  C_KYards_To_NauticalMile    = 1.0 / C_NauticalMile_To_Yards * 1000;


  C_NauticalMile_To_KYards    = C_NauticalMile_To_Yards / 1000;


  C_Yards_To_Meter            = 0.9144;
  C_Meter_To_Yards            = 1 / C_Yards_To_Meter;

  C_Kyards_To_Metre           = C_Yards_To_Meter * 1000;

  C_Hour_to_Second            = 3600;
  C_Second_to_Hour            = 1/3600;
  C_Minute_to_Second          = 60;

  C_KNOT_TO_METER_PERSEC = 0.514444;
  C_INSTALLATION_HEIGHT = 5.0;
  C_MUZZLE_VELOCITY_DIS = 500.0 * C_KNOT_TO_METER_PERSEC; // m/s
  C_MUZZLE_VELOCITY_SED = 300.0 * C_KNOT_TO_METER_PERSEC; // m/s
  C_TUBE_TILT_ANGLE = 45.0; // degrees

  C_FPS_TO_MPS = C_Feet_To_Meter / C_Minute_to_Second;
  C_MPS_TO_FPS = 1 / C_FPS_TO_MPS;

   C_MPS_TO_KNOT = 1 / C_KNOT_TO_METER_PERSEC;

implementation

uses
  Math, SysUtils, uStringFunc;


//==============================================================================
function CalcRange(const x1, y1, x2, y2: double): Double;
var dx, dy: Extended;
begin
  { input long lat degree, output nautical mile }
  dx := (x2 - x1);
  dy := (y2 - y1);

  result := sqrt(sqr(dx) + sqr(dy)) * C_Degree_To_NauticalMile;
end;

//==============================================================================
function CalcMove(const x1, y1: double): Extended;
var
  d : Extended;
begin
  d := (x1 - y1) * C_Degree_To_DataMile;

  result := d;
end;

//==============================================================================
function CalcRangeDM(const x1, y1, x2, y2: double): Double;
var dx, dy: Extended;
begin
  { input long lat degree, output nautical mile }
  dx := (x2 - x1);
  dy := (y2 - y1);

  result := sqrt(sqr(dx) + sqr(dy)) * C_Degree_To_DataMile;
end;

//==============================================================================
function CalcRange3D(const x1, y1, z1, x2, y2,  z2: double): Double;
var dx, dy, dz: Extended;
begin
  { input long lat degree, output nautical mile}
  dx := (x2 - x1) ;
  dy := (y2 - y1) ;
  dz := (z2 - z1) ;

  result := sqrt(sqr(dx) + sqr(dy) + sqr(dz) )* C_Degree_To_NauticalMile;
end;

//==============================================================================
function CalcRange3DDM(const x1, y1, z1, x2, y2,  z2: double): Double;
var dx, dy, dz: Extended;
begin
  { input long lat degree, output nautical mile}
  dx := (x2 - x1) ;
  dy := (y2 - y1) ;
  dz := (z2 - z1) ;

  result := sqrt(sqr(dx) + sqr(dy) + sqr(dz) )* C_Degree_To_DataMile;
end;

//==============================================================================
function ValidateDegree(const aDegree: double): double;
begin
  result := aDegree - (Floor(aDegree / 360.0) * 360.0);
end;

//==============================================================================
function ConvCartesian_To_Compass(const degree: double): double;
begin
  result := ValidateDegree(90.0 - degree);
end;

//==============================================================================
function ConvCompass_To_Cartesian(const degree: double): double;
begin
  result := ValidateDegree(90.0 - degree);
end;

//==============================================================================
function CalcBearing(const x1, y1, x2, y2: double): Double;
var dx, dy, bearing: Extended;
begin
  { input dec degree, output Compass Coord }
  dx := (x2 - x1);
  dy := (y2 - y1);
  bearing := C_RadToDeg * ArcTan2(dy, dx);
  result  := ConvCartesian_To_Compass(bearing);
end;

//==============================================================================
procedure RangeBearingToCoord(const aRange, aBearing: double; var mx, my : double);
var dist : double;
    dir  : extended;
    sinx, cosx: extended;
begin
  dist := aRange * C_NauticalMile_To_Degree;
  dir := C_DegToRad * (90.0 - aBearing);
  SinCos(dir, sinx, cosx);

  mx := dist * cosx;
  my := dist * sinx;
end;

procedure RangeBearingToCoordDM(const aRange, aBearing: double; var mx, my : double);
var dist : double;
    dir  : extended;
    sinx, cosx: extended;
begin
  dist := aRange * C_DataMile_To_Degree;
  dir := C_DegToRad * (90.0 - aBearing);
  SinCos(dir, sinx, cosx);

  mx := dist * cosx;
  my := dist * sinx;
end;

//==============================================================================
procedure CalcForward(const x1, y1, aDist, aCourse: double; var x2, y2: double);
var dx, dy: double;

begin
  RangeBearingToCoord(aDist, aCourse, dx, dy);

  x2 := x1 + dx;
  y2 := y1 + dy;
end;

//==============================================================================
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

//==============================================================================
function IsDegreeDestAtLeft(const src, dest: double): boolean;
{ Cartesian }
{ return true jika dest dikiri (CCW) src, cartesian, east = 0 }
var
  back: double;
begin
  back := ValidateRange(dest - src, 360.0);
  result := (back - 180.0) < 0.0;
end;

//function IsCompasCW(const src, dest: double): boolean;


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

//==============================================================================
function ptBetween2Point(const ptFrom, ptTo, pt : t2DPoint;
    const aDist: Double = 0.0): boolean;
var d: Double;
   p1, p2 : t2DPoint;
begin
  result := false;
  d := ptToLineDistance(ptFrom, ptTo, pt);

  if d > aDist then exit;

  p1.X := Min(ptFrom.X, ptTo.X);
  p1.Y := Min(ptFrom.Y, ptTo.Y);

  p2.X := Max(ptFrom.X, ptTo.X);
  p2.Y := Max(ptFrom.Y, ptTo.Y);

  result := (p1.X < pt.X) and (pt.X < p2.X)
       and  (p1.Y < pt.Y) and (pt.Y < p2.Y)

end;

//==============================================================================
function trueDistance(const x1, y1, x2, y2: double): double;
const R = 3438.147;
begin
  result := ArcCos(sin(y1) * sin(y2) + cos(y1) * cos(y2) *  cos(x2 - x1)) * R;
end;

//==============================================================================
function DistanceToHorizon(const h: double): double;
const R = 3438.147;   ///earth radius in nautical mile
var hNm : double;
begin  //For h in feet and d in nm:
  hNm := (h /6076.11549);
  result := sqrt(hNm * hNm +  2* R * hNm );
end;

//==============================================================================
function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;
var s :double;
    d1, d2 : double;
begin
  s  := trueDistance(x1, y1, x2, y2);
  d1 := DistanceToHorizon(h1);

  if s <  d1  then begin
    result := true;
  end
  else begin // behind the horizon
    d2 := DistanceToHorizon(h2);
    result := (d1 + d2) > s;
  end
end;


procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);
var dSin, dCos: extended;
begin
  sinCos(C_DegToRad * aDeg, dSin, dCos);
  if dSin < 0 then
    aDir := 'R'
  else
    aDir := 'G';
  aVal := C_RadToDeg * ArcCos(dCos);
end;


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

function ConvCustomAngleStart(const degree,startAngle: Double):Double;
begin
  result := startAngle - degree;
  if result < 0.0 then result := result + 360.0;
end;

{
  ctrX, ctrY, X, Y : in degree
  radius in meter
}
function IsInsideGlobe(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double):boolean;
var
  deltaX, deltaY, deltaZ, deltaR : double;
begin
  deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
  deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
  deltaZ := (Z - ctrZ);
  deltaR := sqrt((deltaX*deltaX)+(deltaY*deltaY)+(deltaZ*deltaZ));

  result := deltaR <= radius;

end;

function IsInsideCircle(ctrX, ctrY, X, Y, radius : double; ctrZ, Z : double
         ; mode : integer):boolean;
var
  deltaX, deltaY, deltaZ, deltaR : double;
begin
  Result := False;
  if mode = 1 then
  begin
    deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaZ := (Z - ctrZ) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaR := sqrt((deltaX*deltaX)+(deltaY*deltaY)+(deltaZ*deltaZ));

    result := deltaR <= radius;
  end
  else
  if mode = 2 then
  begin
    deltaX := (X - ctrX) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaY := (Y - ctrY) * C_Degree_To_NauticalMile * C_NauticalMile_To_Metre;
    deltaR := sqrt((deltaX*deltaX)+(deltaY*deltaY));

    result := deltaR <= radius;
  end;
end;

function UTMLetterConv(const paramDouble : Double): Char;
var
  i : Byte;
begin
  i := 90;
    if ((84.0 >= paramDouble) and (paramDouble >= 72.0)) then
      i := 88
    else if ((72.0 > paramDouble) and (paramDouble >= 64.0)) then
      i := 87
    else if ((64.0 > paramDouble) and (paramDouble >= 56.0)) then
      i := 86
    else if ((56.0 > paramDouble) and (paramDouble >= 48.0)) then
      i := 85
    else if ((48.0 > paramDouble) and (paramDouble >= 40.0)) then
      i := 84
    else if ((40.0 > paramDouble) and (paramDouble >= 32.0)) then
      i := 83
    else if ((32.0 > paramDouble) and (paramDouble >= 24.0)) then
      i := 82
    else if ((24.0 > paramDouble) and (paramDouble >= 16.0)) then
      i := 81
    else if ((16.0 > paramDouble) and (paramDouble >= 8.0)) then
      i := 80
    else if ((8.0 > paramDouble) and (paramDouble >= 0.0)) then
      i := 78
    else if ((0.0 > paramDouble) and (paramDouble >= -8.0)) then
      i := 77
    else if ((-8.0 > paramDouble) and (paramDouble >= -16.0)) then
      i := 76
    else if ((-16.0 > paramDouble) and (paramDouble >= -24.0)) then
      i := 75
    else if ((-24.0 > paramDouble) and (paramDouble >= -32.0)) then
      i := 74
    else if ((-32.0 > paramDouble) and (paramDouble >= -40.0)) then
      i := 72
    else if ((-40.0 > paramDouble) and (paramDouble >= -48.0)) then
      i := 71
    else if ((-48.0 > paramDouble) and (paramDouble >= -56.0)) then
      i := 70
    else if ((-56.0 > paramDouble) and (paramDouble >= -64.0)) then
      i := 69
    else if ((-64.0 > paramDouble) and (paramDouble >= -72.0)) then
      i := 68
    else if ((-72.0 > paramDouble) and (paramDouble >= -80.0)) then
      i := 67;
    Result := Chr(i);
end;

procedure ConvLattLongToMGRS(const latt, long: Double;
  var aNorthing, aEasting : Double;
  var aZoneNumber : Integer;
  var aZoneLetter : String;
  var aDigraph    : String);
const
  C_RADIUS = 6378173.0;
  C_ECCSQ  = 0.0067395;
  C_K0     = 0.9996;
  C_A      = 6378173.0;
  C_B      = 6356752.3;
  C_DIGRAPH_LETTERS : array [0..23] of Char = (
    'A','B','C','D','E','F','G','H','J','K','L','M',
    'N','P','Q','R','S','T','U','V','W','X','Y','Z'
  );

  C_DIGRAPH_NUMBERS : array [0..23] of Integer = (
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24
  );
var

  d11 : Double;
  i, jj, kk : Integer;
  k0, a, b, e, ee, N, T, C0, A0, M, x,y,k: Double;
  f : Double; // flattening
  aZoneCM : Double;
  aDeltaLong : Double;
  dL : Double;
  latr : Double;
  longDigraph, lattDigraph : Integer;
  f12, f13 : Integer;
  loD, laD : Integer;
  nn, dd :Double;
  llDigraph : Double;
  longLtr, lattLtr : String;
  aNorth, aEast : Integer;
  aNorthingMGRS, aEastingMGRS: string;
begin
  latr := latt * C_DegToRad;
  k0 := C_K0;

  if long < 0 then
    aZoneNumber := Floor((180 + long)/6) + 1
  else
    aZoneNumber := Floor(long / 6) + 31;

  aZoneCM :=6 * aZoneNumber - 183;
  aDeltaLong := long - aZoneCM;
  dL  := aDeltaLong * C_DegToRad;
  a   := C_A;
  b   := C_B;
  e   := Sqrt(1 - Sqr((b/a)));
  ee  := Sqr(e) / (1 - Sqr(e));
  N   := a/Sqrt(1 - e*e* Sin(latr) * Sin(latr));
  T := Sqr(Tan(latr));
  C0 := ee* Sqr(Cos(latr));
  A0 := dL * Cos(latr);
  M := a*((1-(e*e/4)-3*Power(e, 4)/64-5*Power(e, 6)/256)*Latr-(3*e*e/8+3*
    Power(e, 4)/32+45*Power(e,6)/1024)*SIN(2*Latr)+(15*Power(e,4)/256+45*
    Power(e,6)/1024)*SIN(4*Latr)-(35*Power(e,6)/3072)*SIN(6*Latr));
  x := k0*N*(A0 + (1-T+C0)*Power(A0, 3)/6 + (5-18*T+T*T+72*C0-58*ee)*Power(A0,5)/120);
  y := k0*(M + N*TAN(latr)*(A0*A0/2 + (5 - T +9*C0 +4*C0*C0 )*
    Power(A0,4)/24 + (61-148*T+16*T*T)*Power(A0,6)/720));
  k := k0*(1 + (1+C0)*A0*A0/2 + (5 - 4*T +42*C0 + 13*C0*C0 -28*D11)*Power(A0,4)/24 + (
    61-148*T+16*T*T)*Power(A0,6)/720);

  aEasting := 500000 + x;

  if latt > 0 then
    aNorthing := y
  else
    aNorthing := 10000000 + y;
  f12 := 8 * ((aZoneNumber -1) mod 3) + 1;
  f13 := 1 + (5 * ((aZoneNumber - 1) mod 2));
  longDigraph := f12 + Floor(aEasting / 100000) - 1;
  nn := (f13 + Floor(y / 100000));
  dd := 20;

  llDigraph := nn - (dd * floor(nn/dd));
  lattDigraph := Round(llDigraph);

  for jj := 0 to Length(C_DIGRAPH_LETTERS) - 1 do begin
    if longDigraph = jj + 1 then begin
      longLtr := C_DIGRAPH_LETTERS[jj];
    end;

    if lattDigraph = jj + 1 then begin
      lattLtr := C_DIGRAPH_LETTERS[jj];
    end;
  end;

  aNorth := Round(aNorthing);
  aEast := Round(aEasting);

  aNorthingMGRS := RightStr(IntToStr(aNorth), 5);
  aNorthingMGRS := LeftStr(aNorthingMGRS, 4);
  aNorthing := StrToFloat(aNorthingMGRS);

  aEastingMGRS := RightStr(IntToStr(aEast), 5);
  aEastingMGRS := LeftStr(aEastingMGRS, 4);
  aEasting := StrToFloat(aEastingMGRS);

  aDigraph := longLtr + lattLtr;
  aZoneLetter := UTMLetterConv(latt);
end;

procedure ConvMGRStoLattLong(const aZone, aSq : String;const aEasting, aNorthing : Double;
  var Latt, Long : Double);
const
  C_RADIUS = 6378173.0;
  C_ECCSQ  = 0.0067395;
  C_D1     = 0.9996;
//  C_A      = 6378173.0;
//  C_B      = 6356752.3;

  DigraphLetrsE = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
	DigraphLetrsN = 'ABCDEFGHJKLMNPQRSTUV';
  AllDGLetrs = 'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV'+
               'ABCDEFGHJKLMNPQRSTUV';
  C_DIGRAPH_LETTERS : array [0..23] of Char = (
    'A','B','C','D','E','F','G','H','J','K','L','M',
    'N','P','Q','R','S','T','U','V','W','X','Y','Z'
  );

  C_DIGRAPH_NUMBERS : array [0..23] of Integer = (
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24
  );
var
  d2, d3, d4, d5, d6, d7, d8, d9, d10, d11: Double;
  d12, d13, d14, d15, d16, d17, d18, d19 : Double;

  i : integer;

  aZoneNumber : Integer;
  aEast, aNorth : double;
  longDig, lattDig : Double;
  aSqLeft, aSqRight : Char;
  Latz : Char;
  LatBand, LatBandLow, LatBandHigh : integer;
  LowLetr, HighLetr : Integer;
  LatBandLetrs : string;
  NLetr : Char;
  ELetr : Char;
  NBase : Double;
begin
  LatBand := 0;
  LongDig := 0;
  NBase   := 0.0;
  aZoneNumber := StrToInt(Copy(aZone, 0, 2));
  aSqLeft := LeftStr(aSq, 1)[Length(LeftStr(aSq, 1))];
  aSqRight := RightStr(aSq, 1)[Length(RightStr(aSq, 1))];
  Latz := RightStr(aZone, 1)[Length(RightStr(aZone, 1))];
  for I := 0 to Length(C_DIGRAPH_LETTERS) - 1 do begin
    if aSqLeft = C_DIGRAPH_LETTERS[i] then begin
      longDig := C_DIGRAPH_NUMBERS[i];
      Break;
    end
  end;
  ELetr := aSqLeft;

  for I := 0 to Length(C_DIGRAPH_LETTERS) - 1 do begin
    if aSqRight = C_DIGRAPH_LETTERS[i] then begin
      lattDig := C_DIGRAPH_NUMBERS[i];
      Break;
    end
  end;

  for I := 0 to Length(DigraphLetrsE) - 1 do begin
    if DigraphLetrsE[i + 1] = Latz then begin
      LatBand := i;
      Break;
    end;
  end;

  LatBandLow := 8 * LatBand - 96;
  LatBandHigh := 8 * LatBand - 88;

  if LatBand < 2 then begin
    LatBandLow := -90;
    LatBandHigh := -80;
  end
  else if LatBand = 21 then begin
    LatBandLow := 72;
    LatBandHigh := 84;
  end
  else if LatBand > 21 then begin
    LatBandLow := 84;
    LatBandHigh := 90;
  end;

  LowLetr := Floor(100 + 1.11 * LatBandLow);
  HighLetr := Floor(100 + 1.11 * LatBandHigh);

  Slice(AllDGLetrs, LowLetr, HighLetr, LatBandLetrs);

  for I := 0 to Length(LatBandLetrs) - 1 do begin
    if LatBandLetrs[i + 1] = aSqRight then begin
      NBase := 100000*(LowLetr + i);
      Break;
    end;
  end;

  aNorth := NBase + aNorthing;

  aEast := (longDig - ((8 * (aZoneNumber - 1)) mod 3)) * 100000;
  aEast := aEast + aEasting;
  d2 := C_RADIUS;
  d3 := C_ECCSQ;
  d5 := (1 - Sqrt(1 - d3)) / (1 + Sqrt(1 - d3));
  d16 := aEast - 500000.0;
  d17 := aNorth;
  d17 := d17 - 10000000.0;
  d12 := (aZoneNumber - 1) * 6 - 180 + 3;
  d4 := d3/ (1-d3);
  d11 := d17 / C_D1;
  d13 := d11 / (d2 * (1 - d3 / 4 - 3 * d3 * d3 / 64 - 5 * d3 * d3 * d3 / 256));
  d15 := d13 + (3.0 * d5 / 2.0 - 27.0 * d5 * d5 * d5 / 32.0) *
      Sin(2.0 * d13 * C_DegToRad) + (21.0 * d5 * d5 / 16.0 - 55.0 * d5 * d5 * d5 * d5 / 32.0) *
      Sin(4.0 * d13 * C_DegToRad) + 151.0 * d5 * d5 * d5 / 96.0 *
      Sin(6.0 * d13 * C_DegToRad);
  d14 := d15 * C_RadToDeg;
  d6 := d2 / Sqrt(1.0 - d3 * Sin(d15 * C_DegToRad) * Sin(d15 * C_DegToRad));
  d7 := Tan(d15 * C_DegToRad) * Tan(d15 * C_DegToRad);
  d8 := d4 * Cos(d15 * C_DegToRad) * Cos(d15 * C_DegToRad);
  d9 := d2 * (1.0 - d3) / Power(1.0 - d3 * Sin(d15 * C_DegToRad) * Sin(d15 * C_DegToRad), 1.5);
  d10 := d16 / (d6 * C_D1);
  d18 := d15 - d6 * Tan(d15 *C_DegToRad) / d9 * (d10 * d10 / 2.0 - (5.0 + 3.0 * d7 + 10.0 *
      d8 - 4.0 * d8 * d8 - 9.0 * d4) * d10 * d10 * d10 * d10 / 24.0 + (61.0 + 90.0 * d7 +
      298.0 * d8 + 45.0 * d7 * d7 - 252.0 * d4 - 3.0 * d8 * d8) * d10 * d10 * d10 * d10 *
      d10 * d10 / 720.0);
  d18 := d18 * C_RadToDeg;
  d19 := (d10 - (1.0 + 2.0 * d7 + d8) * d10 * d10 * d10 / 6.0 + (5.0 - 2.0 * d8 + 28.0 *
      d7 - 3.0 * d8 * d8 + 8.0 * d4 + 24.0 * d7 * d7) * d10 * d10 * d10 * d10 * d10 / 120.0) /
      Cos(d15 * C_DegToRad);
  d19 := d12 + d19 * C_RadToDeg;
  Latt := d18;


  Long := d19;
end;

procedure ConvDMCartesianToDegree(const X, Y : Double; var a, b : Double);
begin
  a := X / C_Degree_To_DataMile;
  b := Y / C_Degree_To_DataMile;
end;

procedure ConvLattLongToCartesianDM(const aPosX, aPosY, bPosX, bPosY : Double;
  var x, y : Double);
var
  brn, gridBrn : Double;
begin
  x := CalcRangeDM(aPosX, aPosY, bPosX, aPosY);
  y := CalcRangeDM(aPosX, aPosY, aPosX, bPosY);
  brn := CalcBearing(aPosX, aPosY, bPosX, bPosY);
  gridBrn := ConvCompass_To_Cartesian(brn);
  if (gridBrn > 0) and (gridBrn < 90) then begin      // x y positive
    x := x;
    y := y;
  end
  else if (gridBrn > 90) and (gridBrn < 180) then begin // x negative y positive
    x := -x;
    y := y;
  end
  else if (gridBrn > 180) and (gridBrn < 270) then begin // x y negative
    x := -x;
    y := -y;
  end
  else if (gridBrn >270) and (gridBrn < 360) then begin // x positive y negative
    x := x;
    y := -y;
  end
  else if gridBrn = 90 then begin
    x := 0;
    y := y;
  end
  else if gridBrn = 180 then begin
    x := -x;
    y := 0;
  end
  else if gridBrn = 270 then begin
    x := 0;
    y := -y;
  end;

end;

procedure ReverseAngle(const aDeg: Double; var aRevDeg: Double);
begin
  if aDeg < 180 then
    aRevDeg := aDeg + 180
  else
    aRevDeg := aDeg - 180;

end;

function CalcElevation(const aRng, aHgt : Double) : Double;
var
  sdt : Double;
begin
  sdt := C_RadToDeg * ArcTan2(aHgt, aRng);
  Result := sdt;
end;

procedure CalcHitPredition(
   const tRange, tBearing, tSpeed, tCourse: double;
   const pSpeed: double;
   var hRange, hBearing, hTime, hSpeed: double);
var vR : double;
    tMinute: double;
    dA, dB, dC : double;
    sinA, sinB, sinC : double;
begin
  { a : target speed
    b : relatif speed.
    c : torpedo speed
  } if  abs(pSpeed) < 0.00000001 then exit;

   dC := 180 - (tBearing - tCourse);
   sinC := sin(DegToRad(dC));
   sinA := (tSpeed * sinC)/ pSpeed;
   dA := RadToDeg(ArcSin(sinA));
   dB := 180 - dC - dA;
   sinB := Sin(DegToRad(dB));

   if  abs(sinC) < 0.00000001 then begin
      vR := pSpeed + tSpeed * cos(DegToRad(dC));
   end
   else begin
      vR := (pSpeed * sinB) / sinC;
   end;

   hBearing := tCourse + dB;
   if abs(vR) < 0.00000001 then begin
     hTime  := 99999.99;  //  tidak terkejar
     hRange := 99999.99;  //
   end
   else begin
     hTime := tRange / vR;      //menit
     hRange := hTime * pSpeed;
   end;

   hSpeed := Vr;
end;

procedure ConvertToPPI(aMax:Double; aRad: Integer;aStartX, aStartY: Integer; aOffsetX, aOffsetY: Double;
    dx, dy: double; var ix, iy: integer);
var
  ox, oy : Integer;
  ddX, ddY : double;
begin

  ddX := dx - aOffsetX;
  ddY := aOffsetY - dy;

  if aMax < 0.000001 then
    aMax := 1;

  if aRad = 0 then
    aRad := 1;

  ox  := Round(ddX * C_Degree_To_DataMile / aMax * 2 * aRad);
  oy  := Round(ddY * C_Degree_To_DataMile / aMax * 2 * aRad);

  ix  := ox + aStartX;
  iy  := oy + aStartY;
end;



end.
