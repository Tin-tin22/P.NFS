unit uBaseFunction;

  { Base Simulation System for RADAR simulation
    -------------------------------------------------------------------------
    -- unit uBaseFunction                                                  --
    -- contain Base Function and Procedure                                 --
    -- level      : 0                                                      --
    -------------------------------------------------------------------------
    ..  First Created : 12 Mei 2005       ..
    ..  by            : andySu            ..
    ........................................
  }

  { history
     .
     .
   }


interface

  uses
    Classes, Windows, ExtCtrls, uBaseConstan, uBaseDataType, uTCPDatatype, Math, uTCPClient;

  { Coordinat Conversion }

    function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: double): tDouble2DPoint;

  { Distance Convertion }
    function ConvMeter_To_Feet(const aMeter: double): double;
    function ConvFeet_To_Meter(const aMeter: double): double;

  { Direction Conversion }
    function ConvCartesian_To_Compass(const degree: double): double;
    function ConvCompass_To_Cartesian(const degree: double): double;

  { Speed Conversion }
    function ConvMeterPerSecond_To_KiloMeterPerHour(const aMps: double): double;
    function ConvKiloMeterPerHour_To_MeterPerSecond(const aKmpH: double): double;

    function ConvMeterPerSecond_To_FeetPerMinute(const aMps: double): double;

    function ConvMeterPerSecond_To_Knots(const aMps: double): double;
    function ConvKnots_To_MeterPerSecond(const aKts: double): double;

    function ConvMach_To_Knot(const aSpdMach, atLevel: double): double;
    function ConvKnot_To_Mach(const aSpdKnot, atLevel: double): double;

  { Direction }
    {Radian Unit}
    function ValidateRadiant(const aRad: double): double;
    function AddRadianClockWise(const aRad, goCW: double): double;
    function AddRadianCounterClockWise(const aRad, goCCW: double): double;
    function RadiantBack(const aRad: double): double;
    function IsRadiantDestAtLeft(const src, dest: double): boolean;

    {cartesian // compass}
    function ValidateDegree(const degreeOrg: double): double;
    {-180 s/d 180}
    function Validate180Degree(const degreeOrg: double): double;
    {Kompas direction}
    function DegComp_IsBeetwen(const aDegTes: double;
        const aDeg1, aDeg2: double): boolean;

    procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);
{
    function AddDegreeLeft(const degreeOrg, gotoLeft: double): double;
    function AddDegreeRight(const degreeOrg, gotoRight: double): double;
    function DegreeBack(const degreeOrg: double): double;

    function IsDegreeDestAtLeft(const src, dest: double): boolean;
}
  { FileIni }
    function GetIntIni(FName,Section,Ident:String;Deflt:Integer):Integer;
    function GetStrIni(FName,Section,Ident:String;Deflt:String) :String;
    function GetFltIni(FName,Section,Ident:String;Deflt:Double) :Double;

    function Range3D(X1,Y1,Z1,X2,Y2,Z2:Double):Double;{X,Y dalam Degree, Z Dalam Ft}
    function NextPost2D(PrePost:tDouble2DPoint;Speed,Heading:Integer;DeltaT:Double):tDouble2DPoint;overload;
    procedure NextPost2D(PreX,PreY:Double;Speed,Heading:Integer;DeltaT:Double;var PosX,PosY:Double);overload;
    function SudutBelok(Tujuan,Asal:Double):Double;

//    function NorthToEast(const degree: double): double ;
    function CalcRange(const x1, y1, x2, y2: double):Double;
    function CalcBearing(const x1, y1, x2, y2: double):Double;
    function CalcElevation(const r, z1, z2: double): double;


    procedure InitOleVariant(var TheVar:OleVariant);

    function  ptToRect(const pt: TPoint; const r: word): TRect;

    function IsAlmostZero(const d: double): boolean;

    procedure StringListCompare(const aStrs1, aStrs2 :TStrings;
          var aStrsEqual, aStrsIn_1_Only, aStrsIn_2_Only: TStrings;
          const aSort: boolean= false);

    function Calc_DopplerShift(const orgFreq, objSpeed: double ): double;
    function Calc_powerloss(const orgPower, aDistance: double) : double;

    function IntToOct(Value: Longint; digits: Integer): string;
    function OctToInt(const oct: string): integer;

    procedure ClearListAndObject(var list: tList);
    //gg
    procedure RangeBearingToCoord(const r, b: double; var mx, my : double);

  	function CalcPositionAhead(
      const ptOrg: t2DPoint;
      const aRange, aDirection: double {nautical mile, Cartesian}
      ) : t2DPoint;

    function CalcCrossPoint(const pt1, pt2: t2DPoint; const h1, h2 : double;
                        var aCross: t2DPoint): boolean; {UNTESTED}

    function ptToLineDistance(const ptFrom, ptTo, pt: TPoint):double;

    function DistanceToHorizon(const h: double): double;
    function IsVisibleByHorizon(const x1, y1, h1: double; const x2, y2, h2: double): boolean;

    function ConvertToWord(const str: string; var w: word):boolean;
    function ConvertToInt(const str: string; var i: integer):boolean;
    function ConvertToFloat(const str: string; var f: double):boolean;

    function WindTrueToRel(const tWind, ship: tVect2D): tVect2D;
    function WindRelToTrue(const rWind, ship: tVect2D): tVect2D;

    function UniqueID_To_dbID(const uid: string): integer;
    function dbID_to_UniqueID(const id: integer): string;

    function ConvLL_To_Str(LL: Double; cType: Char): string;
    function ConvDegree_To_Georef(B, L: Double): string;
    function  ReadValConsoleSetting(val : integer): Boolean;


    function WindowsExit(RebootParam: Longword): Boolean;
    {Conversion Range To Elev For GUN}
    function Gun40_ConvertRangeToElev(const GunRange : Double): Double;
    function Gun120_ConvertRangeToElev(const Range : Double):Double;
    {Conversion Range To Elev For GUN}


    // Send Even Log Console
    procedure SendLogEvenConsole(ClientTCP : TTCPClient; Ship_ID, Console_ID, Even_Id : Word; prm1, prm2, prm3 : double);
    function DeleteAmpersand(Value: string): string;

implementation

uses
  IniFiles, Variants, SysUtils,
  {test} Dialogs;

function DeleteAmpersand(Value: string): string;
var
  i: integer;
  found: Boolean;
begin
  i := -1;
  found := false;

  for i := 0 to Length(Value) - 1 do
  begin
    if Value[i] = '&' then
    begin
      found := true;
      break;
    end;
  end;

  if found then
    Delete(Value, i, 1);
  result := Value;
end;

{ Conversion Range To Elevasi Gun 120mm}
                                     {Meter to Degree}
function Gun40_ConvertRangeToElev(const GunRange : Double): Double;
begin
  Result := 0;

  if ((GunRange > 0) and (GunRange < 600)) then
  begin
    Result := (0.0003*Power((GunRange/100), 2.0)) + (0.0295*GunRange/100) - 0.0005;
  end
  else
  if ((GunRange >= 600) and (GunRange < 3300)) then
  begin
    Result := (0.0008*Power((GunRange/100), 2.0)) + (0.02*GunRange/100) + 0.0498;
  end
  else
  if ((GunRange >= 3300) and (GunRange < 6700)) then
  begin
    Result := (0.0027*Power((GunRange/100), 2.0)) - (0.1182*GunRange/100) + 2.6125;
  end
  else
  if ((GunRange >= 6700) and (GunRange < 9200)) then
  begin
    Result := (0.0031*Power(((GunRange/100) - 66), 2.0)) + (0.2336*((GunRange/100) - 66)) + 6.4387;
  end
  else
   if ((GunRange >= 9200) and (GunRange < 11100)) then
  begin
    Result := (0.0072*Power(((GunRange/100) - 91), 2.0)) + (0.3738*((GunRange/100) - 91)) + 14.292;
  end
  else
  if ((GunRange >= 1100) and (GunRange < 12300)) then
  begin
    Result := (0.0541*Power(((GunRange/100) - 110), 2.0)) + (0.3815*((GunRange/100) - 110)) + 24.507;
  end;
end;


{ Conversion Range To Elevasi Gun 120mm}
                                     {Meter to Degree}
function Gun120_ConvertRangeToElev(const Range : Double):Double;
begin
  result := 0;

  if ( Range > 0 ) and ( Range <= 3500 ) then
  begin
    result := ((0.0003)*Power(((Range/100)), 2.0)) +
            ((0.0426)*((Range/100))) + 0.0074;
  end
  else
  if ( Range > 3500 ) and ( Range <= 7000 ) then
  begin
    result := ((0.0006)*Power(((Range/100)), 2.0)) +
            ((0.019)*((Range/100))) + 0.4617;
  end
  else
  if ( Range > 7000 ) and ( Range <= 10500 ) then
  begin
    result := ((0.0011)*Power(((Range/100)), 2.0)) -
            ((0.0477)*((Range/100))) + 2.849;
  end
  else
  if ( Range > 10500 ) and ( Range <= 14000 ) then
  begin
    result := ((0.1229)*Power(((Range/1000)), 2.0)) -
            ((0.7451)*((Range/1000))) + 4.3499;
  end
  else
  if ( Range > 14000 ) and ( Range <= 17500 ) then
  begin
    result := ((0.1246)*Power(((Range/1000)), 2.0)) -
            ((0.4754)*((Range/1000)));
  end
  else
  if ( Range > 17500 ) and ( Range <= 18350) then
  begin
    result := ((0.0174)*Power(((Range/100)-175), 2.0)) +
            ((0.3609)*((Range/100)-175)) + 30.323;
  end;
end;

{ Corrdinat Conversion }
function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: double): tDouble2DPoint;
begin
//  Result.x := aRadius * Sin(aAngleRadian);
//  Result.y := aRadius * Cos(aAngleRadian);
  Result.x := aRadius * Cos(aAngleRadian);
  Result.y := aRadius * Sin(aAngleRadian);
end;


{ Distance Convertion }
function ConvMeter_To_Feet(const aMeter: double): double;
begin
  result := aMeter * 0.3048;

end;

function ConvFeet_To_Meter(const aMeter: double): double;
begin
  result := aMeter * 3.28083;

end;

//==============================================================================
{ Direction Conversion }

function ConvCartesian_To_Compass(const degree: double): double ;
begin
  // input : derajat (0..360) dari sumbu X, CCW, cartesian
  // output: derajat (0..360) dari utara,   CW, kompas

   result := 90.0 - degree;
   if result < 0.0 then result := result + 360.0;
end;

function ConvCompass_To_Cartesian(const degree: double): double ;
begin
  // input : derajat (0..360) dari utara,   CW, kompas
  // output: derajat (0..360) dari sumbu X, CCW, cartesian

   result := 90.0 - degree;
   if result < 0.0 then result := result + 360.0;
end;

//==============================================================================
{ Speed Conversion }
function ConvMeterPerSecond_To_KiloMeterPerHour(const aMps: double): double;
begin
  result := aMps * 3.600;
end;

function ConvKiloMeterPerHour_To_MeterPerSecond(const aKmpH: double): double;
begin
  result := aKmpH * 10.0 / 36.0;
end;

function ConvMeterPerSecond_To_FeetPerMinute(const aMps: double): double;
begin
  result := aMps *  3.28 * 60.0;
end;

function ConvMeterPerSecond_To_Knots(const aMps: double): double;
begin
  result := (aMps / 1852.0) * 3600.0;
end;

function ConvKnots_To_MeterPerSecond(const aKts: double): double;
begin
  result := (aKts * 1852.0) / 3600.0;
end;


function GetMachLevel(const atLevel: double): double;
begin
  if      atLevel <  1005.0 then result := 661.7
  else if atLevel <  2005.0 then result := 659.2
  else if atLevel <  3005.0 then result := 657.2
  else if atLevel <  4005.0 then result := 654.9
  else if atLevel <  5005.0 then result := 652.6
  else if atLevel <  6005.0 then result := 650.3
  else if atLevel <  7005.0 then result := 647.9
  else if atLevel <  8005.0 then result := 645.6
  else if atLevel <  9005.0 then result := 643.3
  else if atLevel < 10005.0 then result := 640.9
  else if atLevel < 15005.0 then result := 638.6
  else if atLevel < 20005.0 then result := 626.7
  else if atLevel < 25005.0 then result := 614.6
  else if atLevel < 30005.0 then result := 602.2
  else if atLevel < 35005.0 then result := 589.5
  else if atLevel < 36089.0 then result := 576.6
  else                           result := 573.8;

end;

function ConvMach_To_Knot(const aSpdMach, atLevel: double): double;
begin
  Result :=  aSpdMach * GetMachLevel(atLevel);
end;

function ConvKnot_To_Mach(const aSpdKnot, atLevel: double): double;
begin
  Result :=  aSpdKnot / GetMachLevel(atLevel);
end;

//==============================================================================
{ Direction }

function ValidateRadiant(const aRad: double): double;
begin
  result := aRad - (Floor(aRad / C_2_Pi)* C_2_Pi);
end;
{  Result := aRad;
  while result > C_2_Pi do result := result - C_2_Pi;
  while result < 0.0 do result := result + C_2_Pi;
}

function AddRadianClockWise(const aRad, goCW: double): double;
begin
  result := aRad - goCW;
  while result < 0.0 do result := result + C_2_Pi;
end;

function AddRadianCounterClockWise(const aRad, goCCW: double): double;
begin
  result := aRad + goCCW;
  while result > C_2_Pi do result := result - C_2_Pi;
end;

function RadiantBack(const aRad: double): double;
begin
  result := aRad + C_Pi;
  while result > C_2_Pi do result := result - C_2_Pi;
end;

function IsRadiantDestAtLeft(const src, dest: double): boolean;
{ return true jika dest dikiri src, cartesian, east = 0 }
var back : double;
begin
  back := ValidateRadiant(dest - src);
  result := (back - C_Pi) < 0.0;
end;

function DegComp_IsBeetwen(const aDegTes: double;
    const aDeg1, aDeg2: double): boolean;
{compass direction}
var d1, d2 : double;
begin
  d1 := (aDegTes-aDeg1);
  if d1 < 0.0 then d1 := d1+ 360.0;
//  while d1 < 0.0 do d1 := d1+ 360.0;

  d2 := (aDeg2-aDeg1);
  if d2 < 0.0 then d2 := d2+ 360.0;
//  while d2 < 0.0 do d2 := d2+ 360.0;

  result := d1 < d2;
end;

(*    {- Kompas direction}

function AddDegreeLeft(const degreeOrg, gotoLeft: double): double;
begin
  result := degreeOrg - gotoleft;
  while result < 0.0 do result := result + 360.0;
end;

function AddDegreeRight(const degreeOrg, gotoRight: double): double;
begin
  result := degreeOrg + gotoRight ;
  while result > 360.0 do result := result - 360.0;
end;

function DegreeBack(const degreeOrg: double): double;
begin
  result := degreeOrg + 180.0 ;
  while result > 360.0 do result := result - 360.0;
end;

function IsDegreeDestAtLeft(const src, dest: double): boolean;
{ return true jika dest dikiri src, cartesian, east = 0 }
var baliknya : double;
begin

  baliknya := DegreeBack(src);

  if baliknya > src then begin
     result := (dest > src) and (dest < baliknya)
  end
  else begin // baliknya < src, lewat titik nol
    result := ((dest > src) and (dest <= 360.0))
      or ((dest >= 0.0 ) and (dest < baliknya ));
  end;
end;
*)

function ValidateDegree(const degreeOrg: double): double;
begin
  try
    result := degreeOrg - (Floor(degreeOrg / 360.0)* 360.0);
  except
    //ShowMessage('Error Validate Degree : ' + FloatToStr(degreeOrg));
  end
end;

function Validate180Degree(const degreeOrg: double): double;
begin
  try
    result := degreeOrg - (Floor(degreeOrg / 360.0)* 360.0);
    if result > 180 then
    result := result -360;

  except
    //ShowMessage('Error Validate Degree : ' + FloatToStr(degreeOrg));
  end;
end;

function IsDegreeDestAtLeft(const src, dest: double): boolean;
{ Cartesian }
{ return true jika dest dikiri (CCW) src, cartesian, east = 0 }
var back : double;
begin
  back := ValidateDegree(dest - src);
  result := (back - 180.0) < 0.0;
end;

procedure degreeToRedGreen(const aDeg: double; var aDir: char; var aVal: double);
var s, c: extended;
begin
  sinCos(DegToRad(aDeg), s, c);
  if s < 0 then aDir := 'R' else  aDir := 'G';
  aVal := RadToDeg(ArcCos(abs(c)));
end;


function GetIntIni(FName,Section,Ident:String;Deflt:Integer):Integer;
var IniF:TIniFile;
begin
   IniF  := TIniFile.Create(FName);
   Result:= IniF.ReadInteger(Section,Ident,Deflt);
   IniF.Free;
end;

function GetStrIni(FName,Section,Ident:String;Deflt:String) :String;
var IniF:TIniFile;
begin
   IniF  := TIniFile.Create(FName);
   Result:= IniF.ReadString(Section,Ident,Deflt);
   IniF.Free;
end;

function GetFltIni(FName,Section,Ident:String;Deflt:Double) :Double;
var IniF:TIniFile;
begin
   IniF  := TIniFile.Create(FName);
   Result:= IniF.ReadFloat(Section,Ident,Deflt);
   IniF.Free;
end;

function Range3D(X1,Y1,Z1,X2,Y2,Z2:Double):Double;
{X,Y dalam Degree, Z Dalam Ft}
begin
   result:=sqrt(sqr(X2-X1)+sqr(Y2-Y1)+sqr((Z2-Z1)/C_NauticalMile_To_Feet));
end;

function NextPost2D(PrePost:tDouble2DPoint;Speed,Heading:Integer;DeltaT:Double):tDouble2DPoint;
//DeltaT dalam Jam, speed dalam knot
var speed_x,speed_y :Double;
    dx,dy           :Double;
begin
//
  speed_x := speed * Cos(DegToRad(Heading));
  speed_y := speed * Sin(DegToRad(Heading));

  dx := speed_x * deltaT;
  dy := speed_y * deltaT;

  Result.X:=PrePost.X+ C_NauticalMile_To_Degree * dx;
  Result.Y:=PrePost.Y+ C_NauticalMile_To_Degree * dy;

end;

  procedure NextPost2D(PreX,PreY:Double;Speed,Heading:Integer;DeltaT:Double;var PosX,PosY:Double);
  //DeltaT dalam Jam, speed dalam knot
  var speed_x,speed_y :Double;
      dx,dy           :Double;
  begin
//
    speed_x := speed * Cos(DegToRad(Heading));
    speed_y := speed * Sin(DegToRad(Heading));

    dx := speed_x * deltaT;
    dy := speed_y * deltaT;

    PosX := PreX + C_NauticalMile_To_Degree * dx;
    PosY := PreY + C_NauticalMile_To_Degree * dy;
  end;

  function SudutBelok(Tujuan,Asal:Double):Double;
  var T:Double;
  begin
    T:=abs(Tujuan-Asal);
    if T > 180 then T:=360-T;
    Result:=T;
  end;

  function CalcRange(const x1, y1, x2, y2: double):Double;
  var dx, dy : Extended;
  begin
   {input dec degree, output nautical mile, }
    dx := (x2 - x1) * C_Degree_To_NauticalMile;
    dy := (y2 - y1) * C_Degree_To_NauticalMile;

    result := sqrt(sqr(dx) + sqr(dy));
  end;

  function CalcBearing(const x1, y1, x2, y2: double):Double;
  var dx, dy, bearing : Extended;
  begin
   {input dec degree, output Compass Coord }
    dx := (x2 - x1);
    dy := (y2 - y1);
    bearing := RadToDeg(ArcTan2(dy, dx));
    result := ConvCartesian_To_Compass(bearing);
  end;

  function CalcElevation(const r, z1, z2: double): double;
  begin
   { input apapun asal sama } //untested;
   { return positif if z2 > z1 }
    result := C_RadToDeg * ArcTan2(z2-z1, r );
  end;

  procedure InitOleVariant(var TheVar:OleVariant);
  begin
    TVarData(TheVar).vType:=varError;
    TVarData(TheVar).vError:=  DISP_E_PARAMNOTFOUND;
  end;

  function  ptToRect(const pt: TPoint; const r: word): TRect;
  begin
    result.Left   := pt.X - r;
    result.Right  := pt.X + r;
    result.top    := pt.Y - r;
    result.Bottom := pt.Y + r;

  end;

  function IsAlmostZero(const d: double): boolean;
  begin
    result := abs(d) < C_MinZero;
  end;

  procedure StringListCompare(const aStrs1, aStrs2 :TStrings;
        var aStrsEqual, aStrsIn_1_Only, aStrsIn_2_Only: TStrings;
        const aSort: boolean= false);

  var i, j : integer;
      strI, strJ : string;
      same : boolean;

  begin
    aStrsIn_1_Only.Clear;
    aStrsIn_1_Only.AddStrings(aStrs1);
    (aStrsIn_1_Only as TStringList).Sorted := aSort;

    aStrsIn_2_Only.Clear;
    aStrsIn_2_Only.AddStrings(aStrs2);
    (aStrsIn_2_Only as TStringList).Sorted := aSort;

    for i := aStrsIn_1_Only.Count-1 downto 0 do begin
      strI := aStrsIn_1_Only[i];

      j := 0;
      same := false;
      while not same and (j < aStrsIn_2_Only.Count) do begin
        strJ := aStrsIn_2_Only[j];
        same :=  CompareStr(strI,  strJ) = 0;
        inc(j);
      end;

      if same then begin
        aStrsEqual.Insert(0,strI);
        aStrsIn_1_Only.Delete(i);
        aStrsIn_2_Only.Delete(j-1);
      end;
    end;
  end;

  function Calc_DopplerShift(const orgFreq, objSpeed: double ): double;
  begin
    //belum diitung nih..
    // f' = (speed of wave / (speed of wave +- objSpeed )) * orgfreq;
    result := orgFreq;
  end;

  function Calc_powerloss(const orgPower, aDistance: double) : double;
  begin

  end;

  function IntToOct(Value: Longint; digits: Integer): string;
  var rest: Longint;
      oct: string;
      i: Integer;
  begin
    oct := '';
    while Value <> 0 do
    begin
      rest  := Value mod 8;
      Value := Value div 8;
      oct := IntToStr(rest) + oct;
    end;
    for i := Length(oct) + 1 to digits do
      oct := '0' + oct;
    Result := oct;
  end;

  function OctToInt(const oct: string): integer;
  var i, c : integer;
      b : byte;
      str: string;
  begin
    result := 0;
    str := trim(oct);
    for i := 1 to length(str) do begin
      Val(str[i], b, c);
      if c = 0 then
        result := (result shl 3) + b
      else begin
        result := 0;
        exit;
      end;
    end;
  end;

  procedure ClearListAndObject(var list: tList);
  var i: integer;
      o: TObject;
  begin
    for i := list.Count-1 downto 0 do begin
      o := list.items[i];
      o.Free;
    end;
    list.Clear;
  end;

procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
begin  // return *relatif* coord to radar center
  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := r * cosx;
  my := r * sinx;
end;

//------------------------------------------------------------------------------
  function CalcPositionAhead(
    const ptOrg: t2DPoint;
    const aRange, aDirection: double {nautical mile, Cartesian degree}
    ) : t2DPoint;
  begin
      result.X := ptOrg.X + C_NauticalMile_To_Degree * aRange * Cos(aDirection * C_DegToRad);
      result.Y := ptOrg.Y + C_NauticalMile_To_Degree * aRange * Sin(aDirection * C_DegToRad);
  end;

  function CalcCrossPoint(const pt1, pt2: t2DPoint;        // map coord
                          const h1, h2 : double;           // heading, cartesian
                          var aCross: t2DPoint): boolean;  //result
  var dX, dY, x1, R1: double;
      a1, a2,  b : double;
      sinB : double;
      bear: double;
  begin
    result := false;
    a1 := DegToRad(h1);
    a2 := DegToRad(h2);
    b  := DegToRad(h2  - h1);

    dX := sqrt(sqr(pt2.X - pt1.X) + sqr(pt2.Y - pt1.Y));
    sinB := sin(b);

    if abs(sinB) < 0.000000000001 then
      R1 := dX
    else begin
      R1 := dX * sin(a2) / sinB;
      Result := true;
    end;
    bear := ArcTan2(pt2.Y - pt1.Y, pt2.X - pt1.X);

    dY := R1 * sin(a1 + bear);
    x1 := R1 * cos(a1 + bear);

    aCross.X := pt1.X + x1;
    aCross.Y := pt1.Y + dY;
  end;

 //------------------------------------------------------------------------------
  function ptToLineDistance(const ptFrom, ptTo, pt: TPoint):double;
  var dxGaris,dyGaris, dx, dy, dr: double;
      m, c: double;
  begin
    dxGaris := (ptTo.x-ptFrom.x);
    if dxGaris = 0 then begin  //==||==> vertikal line
      result := abs(pt.x - ptFrom.x);
      exit;
    end;
    dyGaris := (ptTo.y-ptFrom.y);
    if dyGaris = 0 then  begin //==__==> horizontal Line
      result := abs(pt.y - ptFrom.y);
      exit;
    end;
    m := dyGaris/dxGaris;
    c := ptFrom.y - m * ptFrom.x;
    dy := (m * pt.x + c) - pt.y;
    dx := ((pt.y - c )/m) - pt.x;
    dr := sqrt(dx*dx+dy*dy);

    result := abs(dx * dy / dr);
  end;

  function  trueDistance(const x1, y1, x2, y2: double): double;
  const R = 3438.147;
  begin
    result := ArcCos(sin(y1)*sin(y2) + cos(y1)*cos(y2) *
                     cos(x2-x1)) * R;
  end;

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

  function ConvertToWord(const str: string; var w: word):boolean;
  var e: integer;
  begin
    Val(Str, w, E);
    Result := E = 0;
  end;

  function ConvertToInt(const str: string; var i: integer):boolean;
  var e: integer;
  begin
    Val(Str, i, E);
    Result := E = 0;
  end;

  function ConvertToFloat(const str: string; var f: double):boolean;
  var e: integer;
  begin
    Val(Str, f, E);
    Result := E = 0;
  end;

  function WindTrueToRel(const tWind, ship: tVect2D): tVect2D;
  var t,  r: tVect2D;
  begin
    t.Speed  :=  tWind.Speed;
    t.Course :=  180 + tWind.Course;

    r := V2D_Sub(t, ship);
    result.Speed  :=  r.Speed;
    result.Course :=  ValidateDegree(r.Course + 180);
  end;

  function WindRelToTrue(const rWind, ship: tVect2D): tVect2D;
  var t, s, r: tVect2D;
  begin
    r.Speed  :=  rWind.Speed;
    r.Course :=  180 + rWind.Course;

    s.Speed  :=  ship.Speed;
    s.Course :=  ship.Course;

    t := V2D_Add(r, s);

    result.Speed  :=  t.Speed;
    result.Course :=  ValidateDegree(t.Course + 180);
  end;

  function UniqueID_To_dbID(const uid: string): integer;
  var s: string;
  begin
    s := Copy(uid, 4, Length(uid)-3);
    if s ='' then begin
      Result := 0;
      Exit;
    end;
    try
      result := StrToInt(Trim(s));
    except
      on EConvertError do begin
        result := -1;
        exit;
      end
    end;
  end;

  function dbID_to_UniqueID(const id: integer): string;
  begin
    result := Format('VSL%0.4d', [id]);
  end;

  procedure ConvLL_To_DMS(LL: Double; var D, M, S: Integer);
  var T: double;
  begin
    LL := abs(LL);
    D := Floor(LL);
    T := (LL - D) * 60;
    M := Floor(T);
    T := (T - M) * 60;
    S := Floor(T);
  end;

  function ConvLL_To_Str(LL: Double; cType: Char): string;
  var Dir: char;
    D, M, S: integer;
  begin
    ConvLL_To_DMS(LL, D, M, S);
    Dir := 'W';
    case cType of
      '0':
        if LL < 0 then
          Dir := 'W'
        else
          Dir := 'E';
      '1':
        if LL < 0 then
          Dir := 'S'
        else
          Dir := 'N';
    end;
    Result := IntToStr(Abs(D)) + '° ' + FormatFloat('00', M) + ''' ' + FormatFloat('00', S) + '" ' + Dir;
  end;

  function ConvDegree_To_Georef(B, L: Double): string;
var HrfSN: string;
  HrfWE: string;
  Bujur, Lintang, BM, LM: Integer;
  Hasil: string;
begin
  if (B < -180) or (B > 180) or (L > 90) or (L < -90) then
    hasil := 'N/A'
  else
  begin
    Hasil := '         ';
    hrfsn := 'ABCDEFGHJKLM';
    hrfWE := 'ABCDEFGHJKLMNPQRSTUVWXYZ';
    bujur := floor(B) + 180;
    BM := floor((B + 180 - bujur) * 60);
    hasil[1] := hrfWE[(bujur div 15) + 1];
    hasil[3] := hrfWE[(bujur mod 15) + 1];
    Hasil[5] := inttostr(BM div 10)[1];
    Hasil[6] := inttostr(BM mod 10)[1];
    Lintang := floor(L) + 90;
    LM := floor((L + 90 - Lintang) * 60);
    hasil[2] := hrfSN[(Lintang div 15) + 1];
    hasil[4] := hrfWE[(Lintang mod 15) + 1];
    Hasil[7] := inttostr(LM div 10)[1];
    Hasil[8] := inttostr(LM mod 10)[1];
    result := hasil;
  end;
end;

function ReadValConsoleSetting(val: integer): Boolean;
begin
  Result := False;
  if val = 1 then
    Result := True;
end;

function WindowsExit(RebootParam: Longword): Boolean;
var
   TTokenHd: THandle;
   TTokenPvg: TTokenPrivileges;
   cbtpPrevious: DWORD;
   rTTokenPvg: TTokenPrivileges;
   pcbtpPreviousRequired: DWORD;
   tpResult: Boolean;
const
   SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     tpResult := OpenProcessToken(GetCurrentProcess(),
       TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
       TTokenHd) ;
     if tpResult then
     begin
       tpResult := LookupPrivilegeValue(nil,
                                        SE_SHUTDOWN_NAME,
                                        TTokenPvg.Privileges[0].Luid) ;
       TTokenPvg.PrivilegeCount := 1;
       TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
       cbtpPrevious := SizeOf(rTTokenPvg) ;
       pcbtpPreviousRequired := 0;
       if tpResult then
         Windows.AdjustTokenPrivileges(TTokenHd,
                                       False,
                                       TTokenPvg,
                                       cbtpPrevious,
                                       rTTokenPvg,
                                       pcbtpPreviousRequired) ;
     end;
   end;
   Result := ExitWindowsEx(RebootParam, 0) ;
end;

procedure SendLogEvenConsole(ClientTCP : TTCPClient; Ship_ID, Console_ID, Even_Id : Word; prm1, prm2, prm3 : double);
Var aRec : TRecEventLog;
begin
   aRec.ShipID    := Ship_ID;
   aRec.consoleID := Console_ID;
   aRec.eventID   := Even_Id;
   aRec.param1    := prm1;
   aRec.param2    := prm2;
   aRec.param3    := prm3;
   ClientTCP.sendDataEx(REC_EVENT_LOG, @aRec);
end;

end.
