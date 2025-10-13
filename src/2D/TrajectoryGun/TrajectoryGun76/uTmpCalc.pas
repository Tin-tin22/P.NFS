unit uTmpCalc;

interface

implementation

uses math;


function TimeToSpeedX(const x: double): double;
//input: time(second)
//output:speed horizontal;
begin
  // current time to actual speed
  //y = -4.03428E-05x5 + 0.005878895x4 - 0.32695943x3 + 8.615260231x2
  // - 111.9018568x + 868.6728886
  //speednya ndak pas

  result := - 4.03428 * Power(10.0, -05.0) * Power(x, 5.0)
            + 0.005878895 * Power(x, 4.0)
            - 0.32695943  * Power(x, 3.0)
            + 8.615260231 * Power(x, 2.0)
            - 111.9018568 * x
            + 868.6728886;

  if result < 0 then
    result := 0;

end;

function SpeedXToSpeedY(const vx, elev: double): double;
var r: double;
begin
  result := 0;
  if (elev >=0)  and (elev <80) then
    result := vx * Tan(DegToRad(elev));
end;

function timeToPitch(const t, maxT: double; const e0:double): double;
begin
  result := 0;
  if maxT <=0  then exit;

  result := E0 * Cos(Pi * t/(maxT));
end;

//rumus abc 12
//for #antiair:
function inverseKuadrat1(const y, a, b, c: double): double;
var d: double;
begin
  result := 0;
  if a = 0 then
    exit;

  d := (4.0 *a *y + (b*b) - 4.0 *a *c);

  if d = 0 then
    exit;

  result := (-b + sqrt(d)) / (2 *a);
end;


function rangeAndHeightTo_elev(const r, h: double): double;
var a, b, c, sina: double;
begin
{persamaan dari sina  ke titik tertinggi.
y = 8.14147922x2 + 2.542982055x - 0.054807126
R² = 0.999729589
}
  a := 8.14147922;
  b := 2.542982055;
  c := 0.054807126;
  sina := inverseKuadrat1(h, a, b, c );
  if (sinA <-1) then
    sinA := -1;

  if (sinA > 1.0) then
    sinA := 1.0;

  result := RadToDeg(ArcSin(sinA));
end;

end.
