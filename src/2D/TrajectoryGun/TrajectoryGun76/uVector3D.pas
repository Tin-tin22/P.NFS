unit uVector3D;

interface

type

  T3DVectorComp = record // represent a vector component
    X, Y, Z: double;
    class operator Add(aC1, aC2: T3DVectorComp): T3DVectorComp;
    class operator Subtract(aC1, aC2: T3DVectorComp): T3DVectorComp;
  end;

  t3DDirection = record // represent direction in 3D space
    H, // 0 -> east, 0.5 *PI ->  north , PI = west, 1.5*PI = south;
    V: double; // 0 -> horizontal, 0.5 *PI -> up.
  end;

  t3DVector = record // a vector has magnitude and direction.
    M: double;
    Dir: t3DDirection;
    class operator Add(aV1, aV2: t3DVector): t3DVector;
    class operator Subtract(aV1, aV2: t3DVector): t3DVector;
  end;

//  tVector



  //------------------------------------------------------------------------------
function Make3DVComp(const ax, ay, az: double): t3DVectorComp;

function Vector_To_VComp(const aV: t3DVector): t3DVectorComp;
function VComp_To_Vector(const aV: t3DVectorComp): t3DVector;

//------------------------------------------------------------------------------
function VCompCross(const aC1, aC2: t3DVectorComp): t3DVectorComp; //return V1 X V2
function VCompDot(const aC1, aC2: t3DVectorComp): double; //return V1 . V2

//------------------------------------------------------------------------------
function VectorAdd(const aV, aW: t3DVector): t3DVector; //return V1 + V2
function VectorSub(const aV, aW: t3DVector): t3DVector; //return V1 - V2
function VectorCross(const aV, aW: t3DVector): t3DVector; //return V1 X V2
function VectorDot(const aV, aW: t3DVector): double; //return V1 . V2



implementation

uses
  math;

const
  C_MIN_DouBLe = 0.0000000001; // minimum for division, prevent EDevideByZero
  //  C_MIN_DouBLe = MinDouble;  //use this for better precision;
     //C_PI: double = 3.1415926535897932385;

    //------------------------------------------------------------------------------

function Make3DVComp(const ax, ay, az: double): t3DVectorComp;
begin
  result.X := ax;
  result.Y := aY;
  result.Z := aZ;
end;

//------------------------------------------------------------------------------

function Vector_To_VComp(const aV: t3DVector): t3DVectorComp;
var dW, sinT, cosT: extended;
begin
  sinCos(aV.Dir.V, sinT, cosT);

  Result.Z := aV.M * sinT;
  dW := aV.M * cosT;

  sinCos(aV.Dir.H, sinT, cosT);
  Result.X := dW * cosT;
  Result.Y := dW * sinT;
end;

//------------------------------------------------------------------------------

function VComp_To_Vector(const aV: t3DVectorComp): t3DVector;
var dW: double;
begin
  //this result M always positif
  result.M := sqrt(sqr(aV.X) + sqr(aV.Y) + sqr(aV.Z));

  if result.M > 0 then
  begin

    dW := sqrt(sqr(aV.X) + sqr(aV.Y));
    if dW > 0 then
    begin
      result.Dir.V := arcTan2(aV.Z, dW);

      if abs(aV.X) < C_MIN_DouBLe then
        // dx = 0 -> arah sumbu y -> 90°
        result.Dir.H := 0.5 * PI
      else
        result.Dir.H := arcTan2(aV.Y, aV.X)

    end
    else
    begin
      //arah tegak ke atas
      result.Dir.H := 0.0; //east
      result.Dir.V := 0.5 * PI;

    end
  end
  else
  begin
    // aPt1 = aPt2
    result.Dir.H := 0.0;
    result.Dir.V := 0.0;
  end;
end;

//------------------------------------------------------------------------------

function VCompAdd(const aC1, aC2: t3DVectorComp): t3DVectorComp; //return C1 + C2
begin
  result.X := aC1.X + aC2.X;
  result.Y := aC1.Y + aC2.Y;
  result.Z := aC1.Z + aC2.Z;
end;

//------------------------------------------------------------------------------

function VCompSub(const aC1, aC2: t3DVectorComp): t3DVectorComp; //return C1 - C2
begin
end;

//------------------------------------------------------------------------------

function VCompCross(const aC1, aC2: t3DVectorComp): t3DVectorComp; //return V1 X V2
begin
  result.X := aC1.Y * aC2.Z - aC1.Z * aC2.Y;
  result.Y := aC1.Z * aC2.X - aC1.X * aC2.Z;
  result.Z := aC1.X * aC2.Y - aC1.Y * aC2.X;
end;

//------------------------------------------------------------------------------

function VCompDot(const aC1, aC2: t3DVectorComp): double; //return V1 . V2
begin
  result := aC1.X * aC2.X + aC1.Y * aC2.Y + aC1.Z * aC2.Z;
end;

//------------------------------------------------------------------------------

function VectorAdd(const aV, aW: t3DVector): t3DVector; //return V1 + V2
var c1, c2: t3DVectorComp;
begin
  c1 := Vector_To_VComp(aV);
  c2 := Vector_To_VComp(aW);

  result := VComp_To_Vector(VCompAdd(c1, c2));
end;

//------------------------------------------------------------------------------

function VectorSub(const aV, aW: t3DVector): t3DVector; //return V1 - V2
var c1, c2: t3DVectorComp;
begin
  c1 := Vector_To_VComp(aV);
  c2 := Vector_To_VComp(aW);

  result := VComp_To_Vector(VCompSub(c1, c2));
end;

//------------------------------------------------------------------------------

function VectorCross(const aV, aW: t3DVector): t3DVector; //return V1 X V2
var v, w, c: t3DVectorComp;
begin
  v := Vector_To_VComp(aV);
  w := Vector_To_VComp(aW);

  c.X := V.Y * W.Z - V.Z * W.Y;
  c.Y := V.Z * W.X - V.X * W.Z;
  c.Z := V.X * W.Y - V.Y * W.X;

  result := VComp_To_Vector(c);
end;

//------------------------------------------------------------------------------

function VectorDot(const aV, aW: t3DVector): double; //return V1 . V2
var v, w: t3DVectorComp;
begin
  v := Vector_To_VComp(aV);
  w := Vector_To_VComp(aW);

  result := v.X * w.X + v.Y * w.Y + v.Z * w.Z;
end;

{ t3DVectorComp }

class operator t3DVectorComp.Add(aC1, aC2: T3DVectorComp): T3DVectorComp;
begin
  result.X := aC1.X + aC2.X;
  result.Y := aC1.Y + aC2.Y;
  result.Z := aC1.Z + aC2.Z;
end;

class operator t3DVectorComp.Subtract(aC1, aC2: T3DVectorComp): T3DVectorComp;
begin
  result.X := aC1.X - aC2.X;
  result.Y := aC1.Y - aC2.Y;
  result.Z := aC1.Z - aC2.Z;

end;

{ t3DVector }

class operator t3DVector.Add(aV1, aV2: t3DVector): t3DVector;
var c1, c2: t3DVectorComp;
begin
  c1 := Vector_To_VComp(aV1);
  c2 := Vector_To_VComp(aV2);

  result := VComp_To_Vector(VCompAdd(c1, c2));
end;

class operator t3DVector.Subtract(aV1, aV2: t3DVector): t3DVector;
var c1, c2: t3DVectorComp;
begin
  c1 := Vector_To_VComp(aV1);
  c2 := Vector_To_VComp(aV2);

  result := VComp_To_Vector(VCompSub(c1, c2));
end;

end.
