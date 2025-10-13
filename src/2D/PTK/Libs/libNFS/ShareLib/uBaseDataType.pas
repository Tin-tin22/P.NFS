unit uBaseDataType;

  { Base Simulation System for RADAR simulation
    -------------------------------------------------------------------------
    -- unit       : uBaseDataType                                          --
    -- description: Base Data Type and it's operation                      --
    -- level      : 0                                                      --
    -------------------------------------------------------------------------
    ..  First Created : 12 Mei 2005       ..
    ..  by            : andySu            ..
    ........................................
    ..  Release Version :                 ..
    ..  Release Date    :                 ..
    ........................................
  }

  { history
     .
     .
   }


interface

uses
  Windows;

type

  // -- { Point } --------------------------------------------------------------
  tDouble2DPoint = record
    X, Y : double;
  end;

  tDADouble2DPoint = array of tDouble2DPoint;

  TDoubleRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Double);
      1: (TopLeft, BottomRight: tDouble2DPoint);
  end;


{  tPolarPoint = record
    Angle,
    Radius : double
  end;}

  tDouble3DPoint = record
    X, Y, Z : double;
  end;

  t2DPoint = tDouble2DPoint;
  t3DPoint = tDouble3DPoint;

  tSingle2DPoint = record
    x, y : single
  end;

  t2SPoint = tSingle2DPoint;

  t2DComboPoint = record
     Mx   : t2DPoint;
     Sc   : TPoint;
  end;

  tVect2D = record
    Speed : double;
    Course: double;
  end;


//  tDASingle2DPoint = array of tSingle2DPoint;
{
  tSingle3DPoint = record
    x, y, z : single
  end;

  tDASingle3DPoint = array of TSingle3DPoint;
}
//  tDADouble3DPoint = array of TDouble3DPoint;

  // -- { Rectangle } ---------------------------------------------------------

  tInterleave = record
     Counter    : Word;
     Cycle      : Word;
  end;

  TRelatifDirection = (
     rd_unknown,
     rd_left,
     rd_right,
     rd_up,
     rd_down,
     rd_infront,
     rd_behind
   );

//==============================================================================
  TcolorIndikator = (Red, Yellow, Green);
  TLaunchMode = (lmRBL, lmBOL);
  TLetterSize = (szSmall, szMedium, szLarge);
//==============================================================================
  //== { Function } ============================================================

  function Double2DPoint(const aX, aY: Double): tDouble2DPoint;
{
  function Double2DPointInDoubleRect( const aPoint : tDouble2DPoint;
      const aRect: tDoubleRect): boolean;
 }
  function Double2DPointToDoubleRect(
        const aPt: tDouble2DPoint;
        const aRadius: Double): TDoubleRect;

  function V2D_to_V2C(vd: tVect2D) : t2DPoint;
  function V2C_to_V2D(vc: t2DPoint) : tVect2D;

  function V2D_Add(v1, v2: tVect2D) : tVect2D;
  function V2D_Sub(v1, v2: tVect2D) : tVect2D;


implementation

uses
   Math;

  function Double2DPoint(const aX, aY: Double): tDouble2DPoint;
  begin
    Result.X := aX;
    Result.Y := aY;
  end;

  function Double2DPointToDoubleRect(
        const aPt: tDouble2DPoint;
        const aRadius: Double): TDoubleRect;
  begin
    Result.Left   := aPt.X - aRadius;
    Result.Right  := aPt.X + aRadius;
    Result.Top    := aPt.Y - aRadius;
    Result.Bottom := aPt.Y + aRadius;
  end;


{
  function Double2DPointInDoubleRect( const aPoint : tDouble2DPoint;
      const aRect: tDoubleRect): boolean;
  begin
    result := (aPoint.X > aRect.Left) and (aPoint.X < aRect.Right)
           and(aPoint.Y > aRect.Top) and (aPoint.Y < aRect.Bottom)
  end;
}

  function V2D_to_V2C(vd: tVect2D) : t2DPoint;
  var d : double;
  begin
    d := DegToRad(vd.Course);
    result.X := vd.Speed * cos(d);
    result.Y := vd.Speed * sin(d);
  end;

  function V2C_to_V2D(vc: t2DPoint) : tVect2D;
  begin
    result.Speed  := sqrt(sqr(vc.X) + sqr(vc.Y));
    result.Course := RadToDeg(ArcTan2(vc.Y, vc.X));
  end;

  function V2C_Add(c1, c2: t2DPoint) : t2DPoint;
  begin  //return c1 + c2;
    result.X := c1.X + c2.X;
    result.Y := c1.Y + c2.Y;
  end;

  function V2C_Sub(c1, c2: t2DPoint) : t2DPoint;
  begin  //return c1 - c2;
    result.X := c1.X - c2.X;
    result.Y := c1.Y - c2.Y;
  end;


  function V2D_Add(v1, v2: tVect2D) : tVect2D;
  begin
    result := V2C_to_V2D(V2C_Add(V2D_to_V2C(v1), V2D_to_V2C(v2)));
  end;

  function V2D_Sub(v1, v2: tVect2D) : tVect2D;
  begin
    result := V2C_to_V2D(V2C_sub(V2D_to_V2C(v1), V2D_to_V2C(v2)));
  end;

end.
