unit uPtInRegion;
{
-=-- did Simulation Framework  -----=-
  desc     :
  lastedit : 2012 02 24

-=-------------------------------------------------------=-
}
(** Modification From  Microsoft Konowledge Base
   Original:
    PSS ID Number: Q121960
    Authored 24-Oct-1994			Last modified 25-May-1995
    Additional reference words: 3.00 3.10 3.50 4.00 95  hittest hit-test fails

KBCategory: kbprg kbcode
KBSubcategory: GdiMisc

    translated and Modified  13 - Dec - 2004
*)

interface

uses
  uCoordDataTypes;


  function IsIntersect(const p1, p2, p3, p4: t2DPoint): boolean;
  function IsPtInDoubleRect(const ptTest: t2DPoint;
                          const rTest: T2DRect): boolean;
  function IsPtInPolygon(const ptPolygon: TPoly2DPoint;
                            const ptTest: t2DPoint): boolean;


implementation

uses Math;

function IsCCW(const p0, p1, p2: t2DPoint): integer;
(*
 * PURPOSE
 * Determines, given three points, if when travelling from the first to
 * the second to the third, we travel in a counterclockwise direction.

 *
 * RETURN VALUE
 * (int) 1 if the movement is in a counterclockwise direction, -1 if
 * not.
 *************************************************************************)

var dx1, dx2,
    dy1, dy2: Double ;
begin

   dx1 := p1.x - p0.x;
   dx2 := p2.x - p0.x;
   dy1 := p1.y - p0.y;
   dy2 := p2.y - p0.y;

   (* This is basically a slope comparison: we don't do divisions because
    * of divide by zero possibilities with pure horizontal and pure
    * vertical lines.
    *)
  if (dx1 * dy2 > dy1 * dx2) then
    result :=   1
  else
    result :=  -1;
end;

function IsIntersect(const p1, p2, p3, p4: t2DPoint): boolean;
(*************************************************************************
 * PURPOSE
 * Given two line segments, determine if they intersect.
 *
 * RETURN VALUE
 * TRUE if they intersect, FALSE if not.
 *************************************************************************)
begin
   result := ((( IsCCW(p1, p2, p3) * IsCCW(p1, p2, p4)) <= 0)
         and  (( IsCCW(p3, p4, p1) * IsCCW(p3, p4, p2)  <= 0) )) ;
end;

function GetPolygonBoundRect(const rPoly: TPoly2DPoint): T2DRect;
var i: integer;
begin
  Result.Left:= MaxDouble;
  Result.Top:= MaxDouble;

  Result.Right:= MinDouble;
  Result.Bottom:= MinDouble;

  for i := 0 to High(rPoly) do begin
    if rPoly[i].X < Result.Left then
      Result.Left := rPoly[i].X
    else
      if rPoly[i].X > Result.Right then
        Result.Right := rPoly[i].X;

    if rPoly[i].Y < Result.Top then
      Result.Top := rPoly[i].Y
    else
      if rPoly[i].Y > Result.Bottom then
        Result.Bottom := rPoly[i].Y
  end;

end;

function IsPtInDoubleRect(const ptTest: t2DPoint;
                          const rTest: T2DRect): boolean;
begin
  result := (ptTest.X > rTest.Left) and (ptTest.X < rTest.Right)
         and(ptTest.Y > rTest.Top) and (ptTest.Y < rTest.Bottom)
end;


function IsPtInPolygon(const ptPolygon: TPoly2DPoint;
                            const ptTest: t2DPoint): boolean;

(*************************************************************************
 * FUNCTION:  FN_PtInPolygon
 *
 * PURPOSE
 * This routine determines if the point passed is in the polygon. It uses
 * the classical polygon hit-testing algorithm: a horizontal ray starting
 * at the point is extended infinitely rightwards and the number of
 * polygon edges that intersect the ray are counted. If the number is odd,

 * the point is inside the polygon.
 *
 * RETURN VALUE
 * (BOOL) TRUE if the point is inside the polygon, FALSE if not.
 *************************************************************************)

var i, HiRgpts, wnumintsct : integer;
    ppt, ppt1, ppt2 : t2DPoint;
    rctBound: T2DRect;
begin
  result := false;
  rctBound := GetPolygonBoundRect(ptPolygon);
  if not isPtInDoubleRect(ptTest, rctBound) then exit;

  ppt2   := ptTest;
  ppt2.X := rctBound.right + 50.0 ;

  wnumintsct := 0;
  HiRgpts := HIGH(ptPolygon);
  for i := 0 to HiRgpts-1 do begin
    ppt  := ptPolygon[i];
    ppt1 := ptPolygon[i+1];

    if isIntersect(ptTest, ppt2, ppt, ppt1) then
      inc(wnumintsct)
  end;

  if IsIntersect(ptTest, ppt2, ptPolygon[HiRgpts], ptPolygon[0]) then
    inc(wnumintsct);

  result := (wnumintsct and 1) = 1;
end;

end.
