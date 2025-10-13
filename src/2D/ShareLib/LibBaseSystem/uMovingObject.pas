unit uMovingObject;
{ simple n fast movement calculator
  by Andy Sucipto
  20 Agustus 2007

  catatan:
    speed = knots,
    X dan Y -> dalam degree longlat ;

}

interface

  type

//    TChangingState = (csDirection, csSpeed);

    TMover  = class   // 2 D mover
    private
      function GetDirection(): double;
      procedure SetDirection(const Value: double);

      function GetTurnRate: double;
      procedure SetTurnRate(const Value: double);

      function GetAcceleration: double;
      procedure SetAcceleration(const Value: double);

      function GetSpeed: double;
      procedure SetSpeed(const Value: double);
      function GetDeltaDir: double;

    protected
      FPosX, FPosY, FPosZ  : double;                       // long lat;

      FAcceleration : double;                       // knots / second ??/
      FSpeed        : double;                       // degree / ms

      FTurnRate     : double;                       // Radians per second;

      FDirection    : double;                       // 0 .. 2 Pi;
      FDeltaDir     : double;

      FSinX, FCosX  : extended;

    public
      procedure Calc_Speed(const aDt: double);      // if accelerate
      procedure Calc_Direction(const aDt: double);  // if turn
      procedure Calc_Movement(const aDt: double);   //

      procedure Move(const aDt: double);            // dt : millisecond;

    public
      property X: double read FPosX write FPosX;    // asli longlat;
      property Y: double read FPosY write FPosY;
      property Z: double read FPosZ write FPosZ;

      property Acceleration : double
          read GetAcceleration write SetAcceleration;

      property Speed        : double
          read GetSpeed write SetSpeed;

      property Direction : double                // degree 0 .. 360 cartesian
          read GetDirection write SetDirection;

      property DeltaDirection : double                // degree 0 .. 360 cartesian
          read GetDeltaDir;

      property TurnRate     : double                // degree per second;
          read GetTurnRate  write SetTurnRate;

    end;

implementation

uses Math, uBaseConstan, uBaseFunction;

{ TMover }

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
function TMover.GetDirection(): double;
begin
  Result := C_RadToDeg * FDirection ;

end;

procedure TMover.SetDirection(const Value: double);
begin
  FDirection := C_DegToRad * Value;
  SinCos(FDirection, FSinx, FCosX);
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
function TMover.GetTurnRate: double;
begin
  result := C_RadToDeg * C_SecondToMilliSecond * FTurnRate ;
end;

procedure TMover.SetTurnRate(const Value: double);
begin
  FTurnRate := C_DegToRad * C_MilliSecondToSecond * Value ;
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
function TMover.GetAcceleration: double;
begin
  result := FAcceleration * C_Degree_To_NauticalMile
    * C_HourToMilliSecond * C_SecondToMilliSecond ;

end;

procedure TMover.SetAcceleration(const Value: double);
begin
  FAcceleration := C_NauticalMile_To_Degree * Value /
    (C_HourToMilliSecond * C_SecondToMilliSecond)
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
function TMover.GetSpeed: double;
begin
  result := FSpeed * C_Degree_To_NauticalMile * C_HourToMilliSecond;

end;

procedure TMover.SetSpeed(const Value: double);
begin
  // value = knots, FSpeed = degree per millisecond;
  FSpeed := C_NauticalMile_To_Degree * Value * C_MilliSecondToHour;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMover.Calc_Speed(const aDt: double);
begin
  // speed : degree per millisecond;
  // aDt   : miilisecond;

  FSpeed := FSpeed + FAcceleration * aDt;
end;

procedure TMover.Calc_Direction(const aDt: double);
begin
  //Direction : cartesian degree, 0.. 2 Pi , 0 = east
  //FTurnRate : radian per milli second

  FDeltaDir   := FTurnRate * aDt;
  FDirection  := FDirection + FDeltaDir;
  ValidateRadiant(FDirection);
end;

procedure TMover.Calc_Movement(const aDt: double);
var d, dx, dy: double;
begin
  // x := v . t;
  d := FSpeed * aDt;

  dx := d * FCosX;
  dy := d * FSinX;

  FPosX := FPosX + dx;
  FPosY := FPosY + dy;
end;


procedure TMover.Move(const aDt: double);
begin
   Calc_Speed(aDt);
   Calc_Direction(aDt);
   Calc_Movement(aDt);
end;

function TMover.GetDeltaDir: double;
begin
  result := C_RadToDeg * FDeltaDir;
end;

end.
