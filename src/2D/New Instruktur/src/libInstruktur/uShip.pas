{ ================uShip.pas=================}
{ ==  throttle, rudder ship konversi to 3D =}
{ ==  Maxxima                              =}
{ ==  Sam                                  =}
{ =================uShip.pas================}
unit uShip;

interface

uses
  Dialogs, Classes, SysUtils, DB;

type

  tKonv = record // Throttle and Rudder value
    speed: double;
    angle: double;
    addrudder: double;
  end;

  TShip2D = class
  private
    FKonv: tKonv;

    FMaxAhead : double;
    FMinAstern: double;
    FMaxRudder: double;
    FMinRudder: double;

    FPanjang  : double;
    FLebar    : double;
    FTinggi   : double;

    procedure SetSpeed(spdKiri, spdKanan, spdRudd: double);
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetSpeedRudder(FCurL, FCurR, FRudd: double); // percent

    procedure SetShipData(const aMaxAhead, aMinAstern, aMaxRudder, aMinRudder,
           aPanjang, aLebar, aTinggi: double);

  published
    property Panjang: double  read FPanjang ;
    property Lebar: double    read FLebar;
    property Tinggi: double   read FTinggi;
    property mKonv: tKonv     read FKonv;
  end;

implementation

uses Math;

procedure tShip2D.SetSpeedRudder(FCurL, FCurR, FRudd: double);
var
  spdKiri, spdKanan, spdRudder: double;
begin
  spdKiri := 0;
  if FCurL > 0 then
    spdKiri := (FCurL ) * (FMaxAhead / 2)
  else
    if FCurL = 0 then
    spdKiri := 0
  else
    if FCurL < 0 then
    spdKiri := ((FCurL) * (FMinAstern / 2)) * -1;

  spdKanan := 0;
  if FCurR > 0 then
    spdKanan := ( FCurR ) * (FMaxAhead / 2)
  else
    if FCurR = 0 then
    spdKanan := 0
  else
    if FCurR < 0 then
    spdKanan := (( FCurR ) * (FMinAstern / 2)) * -1;

  if FRudd > 0 then
    spdRudder := FRudd * FMaxRudder
  else
  if FRudd = 0 then
    spdRudder := 0
  else
    spdRudder := - abs( FRudd * FMinRudder);

  SetSpeed(spdKiri,spdKanan, spdRudder);
end;

procedure tShip2D.SetSpeed(spdKiri, spdKanan, spdRudd: double);
var
  vX1, vX2, vY1, vY2, Total, Arah, Sx, Sy,
  addRudder, st1, st2, stt1, stt2, stt3, stt4,
  sdtArah, A: double;
begin
  /// Equation
  if (spdKiri = 0) and (spdKanan = 0) then
  begin
    FKonv.speed := 0;
//    FKonv.angle := 0;
    FKonv.angle := spdRudd;
  end
  else
  begin
    A := 2 * ((180 / Pi) * (ArcTan((FLebar / 2) / (FPanjang / 2))));

    st1 := (90 - (A / 2));
    st2 := (90 + (A / 2));

    stt1 := cos(DegtoRad(st1));
    stt2 := cos(DegtoRad(st2));
    stt3 := sin(DegtoRad(st1));
    stt4 := sin(DegtoRad(st2));

    vX1 := (spdKiri * stt1);
    vX2 := (spdKanan * stt2);
    vY1 := (spdKiri * stt3);
    vY2 := (spdKanan * stt4);

    sX := vX1 + vX2;
    sY := vY1 + vY2;

    if (sY < 0) then
      Total := (sqrt(sqr(sX) + sqr(sY)) * -1)
    else
      Total := sqrt(sqr(sX) + sqr(sY));

    if ((spdKiri) = (spdKanan)) then
      sdtArah := 89.363
    else
      sdtArah := (sY / sX);
    Arah := RadtoDeg(ArcTan((sdtArah)));

    if (abs(spdKiri) = abs(spdKanan)) then
      addRudder := 0
    else
      addRudder := abs(90 - abs(Arah));

    FKonv.speed := Total;
    if Arah >= 0 then
      FKonv.addrudder :=  addRudder  
    else
      FKonv.addrudder :=  -addRudder ;

    FKonv.angle := spdRudd;

  end;

end;


procedure tShip2D.SetShipData(const aMaxAhead, aMinAstern, aMaxRudder, aMinRudder,
           aPanjang, aLebar, aTinggi: double);
begin
  FMaxAhead   := aMaxAhead;
  FMinAstern  := -(abs(aMinAstern));
  FMaxRudder  := aMaxRudder ;
  FMinRudder  := aMinRudder;

  FPanjang    := aPanjang;
  FLebar      := aLebar;
  FTinggi     := aTinggi;
end;

constructor tShip2D.Create;
begin
  inherited;
end;


destructor tShip2D.Destroy;
begin

  inherited;
end;


end.

