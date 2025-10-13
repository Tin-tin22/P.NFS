unit Trajec;

interface

uses
  Classes;

  //Meriam 40
  function Gun40_GetV0XByElev(const GunElev : Double) : Double;
  function Gun40_GetV0YByElev(const GunElev : Double) : Double;
  function Gun40_GetElevByRange(const GunRange : Double) : Double;
  function Gun40_GetElevByHeight(const TargetHeight : Double) : Double;
  function Gun40_GetTimeExplode(const TargetHeight, TargetRange: Double): Double;

  procedure Gun40_LockTargetAir(const TargetHeight, TargetRange : Double; var GunElev : Double; var GunTime : Double);
  procedure Gun40_GetFlightTimeAndRangeMaxByElev(const GunElev : Double ; var FlightTime :Double ; var RangeMax : Double);

  //Meriam 120
  function Gun120_GetV0XByElev(const GunElev : Double): Double;
  function Gun120_GetV0YByElev(const GunElev : Double): Double;
  function Gun120_GetElevByRange(const GunRange : Double): Double;
  procedure Gun120_LockTargetAir(const TargetHeight, TargetRange : Double; var GunElev : Double; var GunTime : Double);
  procedure Gun120_GetFlightTimeAndRangeMaxByElev(const GunElev : Double ; var FlightTime :Double ; var RangeMax : Double);

implementation

uses math;

//================================== MERIAM 40 ===========================================================================
function Gun40_GetV0XByElev(const GunElev : Double) : Double;
begin
  Result := 0;

  if ((GunElev >= 0) and (GunElev <= 0.18)) then
  begin
    Result := (0.1685*(Power(100*GunElev, 3.0))) - (5.2738*power(100*GunElev, 2.0)) + (48.98*100*GunElev) + 807.74;
  end
  else
  if ((GunElev >= 0.19) and (GunElev <= 1.54)) then
  begin
    Result := (-24.879*power(GunElev, 3)) + (113.7*power(GunElev, 2.0)) - (304.08*GunElev) + 981.15;
  end
  else
  if ((GunElev >= 1.55) and (GunElev <= 6.65)) then
  begin
    Result := (0.4717*power(GunElev, 4.0)) - (9.5861*power(GunElev, 3.0)) + (75.601*power(GunElev, 2.0)) - (303.83*GunElev) + 1020.7;
  end
  else
  if ((GunElev >= 6.66) and (GunElev <= 14.63)) then
  begin
    Result := (-0.0667*power(GunElev, 3.0)) + (2.8295*power(GunElev, 2.0)) - (47.542*GunElev) + 653.11;
  end
  else
  if ((GunElev >= 14.64) and (GunElev <= 24.72)) then
  begin
    Result := (-0.0147*power(GunElev, 3.0)) + (1.0379*power(GunElev, 2.0)) - (27.817*GunElev) + 586.13;
  end
  else
  if ((GunElev >= 24.73) and (GunElev <= 40)) then
  begin
    Result := (-23.931*power(GunElev/10, 3.0)) + (226.79*power(GunElev/10, 2.0)) - (729.39*GunElev/10) + 1086.3;
  end;
end;

function Gun40_GetV0YByElev(const GunElev : Double) : Double;
begin
  Result := 0;

  if ((GunElev >= 0) and (GunElev <= 0.18)) then
  begin
    Result := (0.2027*(Power(100*GunElev, 3.0))) + (6.444*power(100*GunElev, 2.0)) - (65.064*100*GunElev) + 1214.6;
  end
  else
  if ((GunElev >= 0.19) and (GunElev <= 1.54)) then
  begin
    Result := (162.57*power(GunElev, 3.0)) - (423.9*power(GunElev, 2.0)) + (240.74*GunElev) + 924.24;
  end
  else
  if ((GunElev >= 1.55) and (GunElev <= 6.65)) then
  begin
    Result := (1.6345*power(GunElev, 3.0)) - (17.232*power(GunElev, 2.0)) + (9.7817*GunElev) + 869.95;
  end
  else
  if ((GunElev >= 6.66) and (GunElev <= 14.63)) then
  begin
    result := (1.1299*power(GunElev, 2.0)) - (39.46*GunElev) + 867.79;
  end
  else
  if ((GunElev >= 14.64) and (GunElev <= 24.72)) then
  begin
    result := (0.257*power(GunElev, 2.0)) - (16.043*GunElev) + 709.27;
  end
  else
  if ((GunElev >= 24.73) and (GunElev <= 40)) then
  begin
    Result := (-20.127*power(GunElev/10, 4.0)) + (294.24*power(GunElev/10, 3.0)) - (1553.9*power(GunElev/10, 2.0)) + (3513.3*GunElev/10) - 2416.8;
  end;
end;

function Gun40_GetTimeExplode(const TargetHeight, TargetRange : Double): Double;
var
  GunElev, GunV0X , GunV0Y : Double;
  CosVOX , sinVOY : Double;

  Time1, Time2 : Double;
  GunRange1, GunRange2 : Double;
begin
  Result := 0;

  Time1 := 0;
  Time2 := 0;

  GunElev := Gun40_GetElevByHeight(TargetHeight);
  GunV0X  := Gun40_GetV0XByElev(GunElev);
  GunV0Y  := Gun40_GetV0YByElev(GunElev);

  sinVOY := Sin(DegToRad(GunElev));

  Time1 := Power(GunV0Y * sinVOY , 2.0) - (20*TargetHeight);//- (20*TargetHeight));// - (GunV0Y * Sin(DegToRad(GunElev)))) / 10;
  //Time2 := (-1 * Sqrt( Power(V0Y * Sin(DegToRad(Elev)), 2.0) - (20*THeight)) - (V0Y * Sin(DegToRad(Elev)))) / 10;


  GunRange1 := GunV0X * CosVOX * Time1;
  GunRange2 := GunV0X * CosVOX * Time2;

  if (Abs(GunRange1 - TargetRange) < 10) then
    Result := Time1
  else
  if (Abs(GunRange2 - TargetRange) < 10) then
    Result := Time2
  else
    Result := 0;
  
end;

function Gun40_GetElevByHeight(const TargetHeight : Double) : Double;
begin
  Result := 0;

  if ((TargetHeight > 0) and (TargetHeight < 0.55)) then
  begin
    Result := (-0.6375 * Power(TargetHeight, 2.0)) + (0.5835 * TargetHeight) + 0.0246;
  end
  else
  if ((TargetHeight >= 0.55) and (TargetHeight < 29.79)) then
  begin
    Result := (-0.0012 * Power(TargetHeight, 2.0)) + (0.0792 * TargetHeight) + 0.2108;
  end
  else
  if ((TargetHeight >= 29.79) and (TargetHeight < 290.93)) then
  begin
    Result := (-0.00002 * Power(TargetHeight, 2.0)) + (0.0262 * TargetHeight) + 0.9213;
  end
  else
  if ((TargetHeight >= 290.93) and (TargetHeight < 917.69)) then
  begin
    Result := (-0.0433 * Power((TargetHeight/100), 2.0)) + (1.7884 * (TargetHeight/100)) + 1.8311;
  end
  else
  if ((TargetHeight >= 917.69) and (TargetHeight < 2044.03)) then
  begin
    Result := (-0.0134 * Power((TargetHeight/100), 2.0)) + (1.2907 * (TargetHeight/100)) + 3.9609;
  end
  else
  if ((TargetHeight >= 2044.03) and (TargetHeight < 3918.70)) then
  begin
    Result := (-0.007 * Power((TargetHeight/100), 2.0)) + (1.0769 * (TargetHeight/100)) + 5.64;
  end;
end;

procedure Gun40_LockTargetAir(const TargetHeight, TargetRange : Double; var GunElev : Double; var GunTime : Double);
var
  GunV0X, GunV0Y,
  CosVOX, sinVOY : Double;

  gun40Elev,
  gun40RangeMax,
  gun40FlightTime,
  gun40Height : Double;

  DeltaRange,
  DeltaAlt : Double;

  isDeltaRange,
  isDeltaAlt : Boolean;

  isLock : Boolean;
begin
  isLock := false;

  isDeltaRange := False;
  isDeltaAlt   := False;

  gun40Elev       := 0;
  gun40RangeMax   := 0;
  gun40FlightTime := 0;
  gun40Height     := 0;

  GunElev := 0;
  GunTime := 0;

  repeat
    gun40Elev := gun40Elev + 0.01;
    gun40FlightTime := 0;

    repeat
      gun40FlightTime := gun40FlightTime + 0.1;

      GunV0X := Gun40_GetV0XByElev(gun40Elev);
      GunV0Y := Gun40_GetV0YByElev(gun40Elev);

      CosVOX := Cos(DegToRad(gun40Elev));
      sinVOY := Sin(DegToRad(gun40Elev));

      gun40RangeMax := GunV0X * CosVOX * gun40FlightTime;
      gun40Height   := (GunV0Y * sinVOY * gun40FlightTime) - (5 * gun40FlightTime * gun40FlightTime);

      DeltaRange := gun40RangeMax - TargetRange;
      DeltaAlt   := gun40Height - TargetHeight;

      isDeltaRange := Abs(DeltaRange) < 10;
      isDeltaAlt   := Abs(DeltaAlt) < 10;

      isLock := isDeltaRange and isDeltaAlt;

      if isLock then
      begin
        GunElev := gun40Elev;
        GunTime := gun40FlightTime;
      end;

    until (((gun40FlightTime >= 55 ) or (gun40Height < 0)) or isLock);
  until (isLock or (gun40Elev >= 37));
end;

procedure Gun40_GetFlightTimeAndRangeMaxByElev(const GunElev : Double ; var FlightTime :Double ; var RangeMax : Double);
var
  gun40RangeMax,
  gun40FlightTime,
  gun40Height : Double;

  GunV0X, GunV0Y,
  CosVOX, sinVOY : Double;
begin
  gun40RangeMax   := 0;
  gun40FlightTime := 0;
  gun40Height     := 0;

  FlightTime := 0;
  RangeMax   := 0;

  repeat
    gun40FlightTime := gun40FlightTime + 0.1;

    GunV0X := Gun40_GetV0XByElev(GunElev);
    GunV0Y := Gun40_GetV0YByElev(GunElev);

    CosVOX := Cos(DegToRad(GunElev));
    sinVOY := Sin(DegToRad(GunElev));

    gun40RangeMax := GunV0X * CosVOX * gun40FlightTime;
    gun40Height   := (GunV0Y * sinVOY * gun40FlightTime) - (5 * gun40FlightTime * gun40FlightTime);

  until ((gun40FlightTime >= 55 ) or (gun40Height < 0));

  FlightTime  := gun40FlightTime;
  RangeMax    := gun40RangeMax;

  if GunElev = 0 then
  begin
    FlightTime  := 1;
    RangeMax    := 0;
  end;
end;

function Gun40_GetElevByRange(const GunRange : Double) : Double;
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

//======================================================================================================================


//================================== MERIAM 120 =========================================================================
function Gun120_GetV0XByElev(const GunElev : Double): Double;
begin
  Result := 0;

  if (( GunElev > 0.05 ) and ( GunElev <= 1.9 )) then
  begin
    Result := (-7.0619*(Power(GunElev, 2.0))) + (-40.285*GunElev) + 778.26;
  end
  else
  if (( GunElev > 1.9 ) and ( GunElev <= 4.93 )) then
  begin
    Result := (3.4889*(Power(GunElev, 2.0))) + (-60.798*GunElev) + 782.56;
  end
  else
  if (( GunElev > 4.93 ) and ( GunElev <= 10.06 )) then
  begin
    Result := (1.651*(Power(GunElev, 2.0))) + (-43.559*GunElev) + 741.34;
  end
  else
  if (( GunElev > 10.06 ) and ( GunElev <= 18.02 )) then
  begin
    Result := (0.413*(Power(GunElev, 2.0))) + (-18.644*GunElev) + 614.76;
  end
  else
  if (( GunElev > 18.02 ) and ( GunElev <= 30.14 )) then
  begin
    Result := (0.1289*(Power(GunElev, 2.0))) + (-8.7146*GunElev) + 527.14;
  end
  else
  if (( GunElev > 30.14 ) and ( GunElev <= 40 )) then
  begin
    Result := (0.0614*(Power(GunElev, 2.0))) + (-4.8105*GunElev) + 470.38;
  end;
end;

function Gun120_GetV0YByElev(const GunElev : Double): Double;
begin
  Result := 0;

  if (( GunElev > 0.05 ) and ( GunElev <= 1.9 )) then
  begin
    Result := (-7.0619*(Power(GunElev, 2.0))) + (-40.285*GunElev) + 778.26;
  end
  else
  if (( GunElev > 1.9 ) and ( GunElev <= 4.93 )) then
  begin
    Result := (0.4951*(Power(GunElev, 2.0))) + (-21.937*GunElev) + 816.72;
  end
  else
  if (( GunElev > 4.93 ) and ( GunElev <= 10.06 )) then
  begin
    Result := (0.2156*(Power(GunElev, 2.0))) + (-16.992*GunElev) + 799.05;
  end
  else
  if (( GunElev > 10.06 ) and ( GunElev <= 18.02 )) then
  begin
    Result := (0.3914*(Power(GunElev, 2.0))) + (-20.022*GunElev) + 810.97;
  end
  else
  if (( GunElev > 18.02 ) and ( GunElev <= 30.14 )) then
  begin
    Result := (0.1613*(Power(GunElev, 2.0))) + (-11.74*GunElev) + 736.15;
  end
  else
  if (( GunElev > 30.14 ) and ( GunElev <= 40 )) then
  begin
    Result := (0.0761*(Power(GunElev, 2.0))) + (-6.8575*GunElev) + 661.1;
  end;
end;

function Gun120_GetElevByRange(const GunRange : Double): Double;
begin
  Result := 0;

  if ( GunRange > 0 ) and ( GunRange <= 3500 ) then
  begin
    Result := ((0.0003)*Power(((GunRange/100)), 2.0)) +
            ((0.0426)*((GunRange/100))) + 0.0074;
  end
  else
  if ( GunRange > 3500 ) and ( GunRange <= 7000 ) then
  begin
    Result := ((0.0006)*Power(((GunRange/100)), 2.0)) +
            ((0.019)*((GunRange/100))) + 0.4617;
  end
  else
  if ( GunRange > 7000 ) and ( GunRange <= 10500 ) then
  begin
    Result := ((0.0011)*Power(((GunRange/100)), 2.0)) -
            ((0.0477)*((GunRange/100))) + 2.849;
  end
  else
  if ( GunRange > 10500 ) and ( GunRange <= 14000 ) then
  begin
    Result := ((0.1229)*Power(((GunRange/1000)), 2.0)) -
            ((0.7451)*((GunRange/1000))) + 4.3499;
  end
  else
  if ( GunRange > 14000 ) and ( GunRange <= 17500 ) then
  begin
    Result := ((0.1246)*Power(((GunRange/1000)), 2.0)) -
            ((0.4754)*((GunRange/1000)));
  end
  else
  if ( GunRange > 17500 ) and ( GunRange <= 18800) then
  begin
    Result := ((0.0174)*Power(((GunRange/100)-175), 2.0)) +
            ((0.3609)*((GunRange/100)-175)) + 30.323;
  end;
end;

procedure Gun120_GetFlightTimeAndRangeMaxByElev(const GunElev : Double ; var FlightTime :Double ; var RangeMax : Double);
var
  gun120RangeMax,
  gun120FlightTime,
  gun120Height : Double;

  GunV0X, GunV0Y,
  CosVOX, sinVOY : Double;
begin
  gun120RangeMax   := 0;
  gun120FlightTime := 0;
  gun120Height     := 0;

  FlightTime := 0;
  RangeMax   := 0;

  repeat
    gun120FlightTime := gun120FlightTime + 0.1;

    GunV0X := Gun120_GetV0XByElev(GunElev);
    GunV0Y := Gun120_GetV0YByElev(GunElev);

    CosVOX := Cos(DegToRad(GunElev));
    sinVOY := Sin(DegToRad(GunElev));

    gun120RangeMax := GunV0X * CosVOX * gun120FlightTime;
    gun120Height   := (GunV0Y * sinVOY * gun120FlightTime) - (5 * gun120FlightTime * gun120FlightTime);

  until ((gun120FlightTime >= 70 ) or (gun120Height < 0));

  FlightTime  := gun120FlightTime;
  RangeMax    := gun120RangeMax;

  if GunElev = 0 then
  begin
    FlightTime  := 1;
    RangeMax    := 0;
  end;
end;

procedure Gun120_LockTargetAir(const TargetHeight, TargetRange : Double; var GunElev : Double; var GunTime : Double);
var
  GunV0X, GunV0Y,
  CosVOX, sinVOY : Double;

  gun120Elev,
  gun120RangeMax,
  gun120FlightTime,
  gun120Height : Double;

  DeltaRange,
  DeltaAlt : Double;

  isDeltaRange,
  isDeltaAlt : Boolean;

  isLock : Boolean;
begin
  isLock := false;

  isDeltaRange := False;
  isDeltaAlt   := False;

  gun120Elev       := 0;
  gun120RangeMax   := 0;
  gun120FlightTime := 0;
  gun120Height     := 0;

  GunElev := 0;
  GunTime := 0;

  repeat
    gun120Elev := gun120Elev + 0.01;
    gun120FlightTime := 0;

    repeat
      gun120FlightTime := gun120FlightTime + 0.1;

      GunV0X := Gun120_GetV0XByElev(gun120Elev);
      GunV0Y := Gun120_GetV0YByElev(gun120Elev);

      CosVOX := Cos(DegToRad(gun120Elev));
      sinVOY := Sin(DegToRad(gun120Elev));

      gun120RangeMax := GunV0X * CosVOX * gun120FlightTime;
      gun120Height   := (GunV0Y * sinVOY * gun120FlightTime) - (5 * gun120FlightTime * gun120FlightTime);

      DeltaRange := gun120RangeMax - TargetRange;
      DeltaAlt   := gun120Height - TargetHeight;

      isDeltaRange := Abs(DeltaRange) < 10;
      isDeltaAlt   := Abs(DeltaAlt) < 10;

      isLock := isDeltaRange and isDeltaAlt;

      if isLock then
      begin
        GunElev := gun120Elev;
        GunTime := gun120FlightTime;
      end;

    until (((gun120FlightTime >= 70 ) or (gun120Height < 0)) or isLock);
  until (isLock or (gun120Elev >= 38));
end;

//======================================================================================================================
end.
