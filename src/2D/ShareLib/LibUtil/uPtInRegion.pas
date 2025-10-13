unit uPtInRegion;
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

uses Windows ;
type

  tDoublePoint = record
    X, Y : double;
  end;

  TDoubleRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Double);
      1: (TopLeft, BottomRight: tDoublePoint);
  end;

//TDynamicArrayDoublePoint
  tDADoublePoint = array of tDoublePoint;

  function DoublePoint(X, Y: Double): tDoublePoint;

  function FN_CCW(const p0, p1, p2: tDoublePoint): integer ;

  function FN_Intersect(const p1, p2, p3, p4: tDoublePoint): boolean;

  function FN_PtInDoubleRect(const ptTest: tDoublePoint;
                          const rctTest: tDoubleRect): boolean;

  function FN_PtInPolygon(const rgpts: tDADoublePoint;
                            const ptTest: tDoublePoint
                            ) : boolean;


implementation

uses Math;

function DoublePoint(X, Y: Double): tDoublePoint;
begin
  Result.X := X;
  Result.Y := Y;
end;


function FN_CCW(const p0, p1, p2: tDoublePoint): integer ;
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

   dx1 := p1.x - p0.x ;
   dx2 := p2.x - p0.x ;
   dy1 := p1.y - p0.y ;
   dy2 := p2.y - p0.y ;

   (* This is basically a slope comparison: we don't do divisions because
    * of divide by zero possibilities with pure horizontal and pure
    * vertical lines.
    *)
  if (dx1 * dy2 > dy1 * dx2) then
    result :=   1
  else
    result :=  -1;
end;

function FN_Intersect(const p1, p2, p3, p4: tDoublePoint): boolean;
(*************************************************************************
 * PURPOSE
 * Given two line segments, determine if they intersect.
 *
 * RETURN VALUE
 * TRUE if they intersect, FALSE if not.
 *************************************************************************)
begin
   result := ((( FN_CCW(p1, p2, p3) * FN_CCW(p1, p2, p4)) <= 0)
         and  (( FN_CCW(p3, p4, p1) * FN_CCW(p3, p4, p2)  <= 0) )) ;

end;

function FN_GetPolygonBoundRect(const rgpts: tDADoublePoint): tDoubleRect;
var i: integer;
begin
  Result.Left:= MaxDouble;
  Result.Top:= MaxDouble;

  Result.Right:= MinDouble;
  Result.Bottom:= MinDouble;

  for i := 0 to High(rgpts) do begin
    if rgpts[i].X < Result.Left then
      Result.Left := rgpts[i].X
    else
      if rgpts[i].X > Result.Right then
        Result.Right := rgpts[i].X;

    if rgpts[i].Y < Result.Top then
      Result.Top := rgpts[i].Y
    else
      if rgpts[i].Y > Result.Bottom then
        Result.Bottom := rgpts[i].Y
  end;

end;

function FN_PtInDoubleRect(const ptTest: tDoublePoint;
                          const rctTest: tDoubleRect): boolean;
begin
  result := (ptTest.X > rctTest.Left) and (ptTest.X < rctTest.Right)
         and(ptTest.Y > rctTest.Top) and (ptTest.Y < rctTest.Bottom)
end;

function FN_PtInPolygon(const rgpts: tDADoublePoint;
                          const ptTest: tDoublePoint
                          ) : boolean;

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
    ppt, ppt1, ppt2 : tDoublePoint;
    rctBound: tDoubleRect;
begin
  result := false;
  rctBound := FN_GetPolygonBoundRect(rgpts);
  if not FN_PtInDoubleRect(ptTest, rctBound) then exit;

  ppt2   := ptTest;
  ppt2.X := rctBound.right + 50.0 ;

  wnumintsct := 0;
  HiRgpts := HIGH(rgpts);
  for i := 0 to HiRgpts-1 do begin
    ppt  := rgpts[i];
    ppt1 := rgpts[i+1];

    if FN_Intersect(ptTest, ppt2, ppt, ppt1) then
      inc(wnumintsct)
  end;

  if FN_Intersect(ptTest, ppt2, rgpts[HiRgpts],rgpts[0]) then
    inc(wnumintsct);

  result := (wnumintsct and 1) = 1;
end;

end.
