unit uCoordDataTypes;

{
-=-- did Simulation Framework  -----=-
  desc     : Standard tipe data untuk sistem coordinat;
  lastedit : 2012 02 24

-=-------------------------------------------------------=-
}

interface

type

  // TPoint with double precission
  t2DPoint = record
    X,
    Y: double;
  end;

  TPoly2DPoint = array of t2DPoint;

  t3DPoint = record
    X,
    Y,
    Z: double;
  end;

  t3DDirection = record
    H, V: double;
  end;

  T2DRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: double);
      1: (TopLeft, BottomRight: t2DPoint);
  end;

  function ValidateRange(const aVal, aMaxVal: double): double;

  function Make2DPoint(const dx, dy: double): t2DPoint;
  function Translate2DPoint(const org, offset: t2DPoint): t2DPoint;
  function Scale2DPoint(const org, scale: t2DPoint ): t2DPoint;

  function Rotate2DPoint(const pt: t2DPoint; const aSin, aCos: double): t2DPoint; overload;
  function Rotate2DPoint(const pt: t2DPoint; const aRad: double): t2DPoint; overload;

  function Make3DPoint(const dx, dy, dz: double): t3DPoint;

const

  C_Degree_To_NauticalMile = 60.0;
  C_NauticalMile_To_Degree = 1.0 /60.0;
  C_NauticalMile_To_Metre  = 1852.0;
  C_NauticalMile_To_Feet = 6076.11549;
  C_NauticalMile_To_Yards = 2025.37183;
  C_Feet_To_Meter = 0.3048;
  C_Meter_To_Feet = 3.281;
  C_Meter_To_NauticalMile = 1 / C_NauticalMile_To_Metre;
  C_Meter_To_Degree = C_Meter_To_NauticalMile * C_NauticalMile_To_Degree;
  C_Degree_To_Feet = C_Degree_To_NauticalMile * C_NauticalMile_To_Feet;
  C_MS_To_KNOTS = 1.9438449412;


implementation

uses Math;

function ValidateRange(const aVal, aMaxVal: double): double;
begin
  if aMaxVal = 0.0 then
    result := 0.0
  else
    result := aVal - (Floor(aVal / aMaxVal) * aMaxVal);
end;

function Make2DPoint(const dx, dy: double): t2DPoint;
begin
  Result.X := dX;
  Result.Y := dY;
end;

function Translate2DPoint(const org, offset: t2DPoint): t2DPoint;
begin
  Result.X := org.X + offset.X;
  Result.Y := org.Y + offset.Y;
end;

function Scale2DPoint(const org, scale: t2DPoint ): t2DPoint;
begin
  Result.X := org.X * scale.X;
  Result.Y := org.Y * scale.Y;
end;

function Rotate2DPoint(const pt: t2DPoint; const aSin, aCos: double): t2DPoint;
begin
  Result.X := pt.X * aCos - pt.Y * aSin;
  Result.Y := pt.X * aSin + pt.Y * aCos;
end;

function Rotate2DPoint(const pt: t2DPoint; const aRad: double): t2DPoint;
var aSin, aCos: Extended;
begin
  SinCos(aRad, aSin, aCos);
  Result.X := pt.X * aCos - pt.Y * aSin;
  Result.Y := pt.X * aSin + pt.Y * aCos;
end;

function Make3DPoint(const dx, dy, dz: double): t3DPoint;
begin
  Result.X := dX;
  Result.Y := dY;
  Result.Z := dZ;
end;

end.
