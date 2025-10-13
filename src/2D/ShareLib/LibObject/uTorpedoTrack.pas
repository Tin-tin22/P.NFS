unit uTorpedoTrack;

interface

  uses
    uRadarTracks, MapXLib_TLB, uBaseDataType, uTorpedoView;


  type

    TTarget = record
      Speed, Course: double;
      Bearing, Distance : double;
    end;

    TPHPData = record
      hitRange  ,
      hitBearing,
      hitTime   : double;
    end;

    TSpeedType = (stLow, stMedium, stHigh);
    TTube = (ttPort, ttStarBoard);

    TTorpedoTrack = class (TRadarTrack)
    private
      FSpeedType: TSpeedType;
      FMaxBatt  : double;
      FMaxWire  : double;
      FTube     : TTube;

      function getBatt: double;
      function getWire: double;
      procedure setBatt(const Value: double);
      procedure setWire(const Value: double);
      procedure SetSpeedType(const Value: TSpeedType);
      function getTube: TTube;
      procedure setTube(const Value: TTube);
      function getEnbDist: double;
      procedure setEnbDist(const Value: double);
    protected
      TrackView : TTorpedoView;
      tgtPos : t2DPoint;

    public
      Target : TTarget;
      TargetTrack : TRadarTrack;
      Launched  : boolean;

      PhpData : TPHPData;
      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      procedure Update; override;
      procedure Run(const aDeltaMs: double); override;

      procedure CalcPHP;
    public
      property EnablingDistance: double read getEnbDist write setEnbDist;  //yard
      property WireDistance    : double read getWire write setWire;  //yard
      property BatteryDistance : double read getBatt write  setBatt;    //yard
      property SpeedType: TSpeedType read FSpeedType write SetSpeedType;
      property Tube: TTube read getTube write setTube;
    end;

implementation

uses
  uBaseConstan, uBaseFunction, uBaseSimulationObject, Math;

procedure CalcHitPredition(
   const tRange, tBearing, tSpeed, tCourse: double;
   const pSpeed: double;
   var hRange, hBearing, hTime: double);
var vR : double;
    dA, dB, dC : double;
    sinA, sinB, sinC : double;
begin
  { a : target speed
    b : relatif speed.
    c : torpedo speed
  } if  abs(pSpeed) < 0.00000001 then exit;

   dC := 180 - (tBearing - tCourse);
   sinC := sin(DegToRad(dC));
   sinA := (tSpeed * sinC)/ pSpeed;
   if (sinA < -1.0) or (sinA > 1.0) then begin
     hTime  := 9999999.99;  //  tidak terkejar
     hRange := 9999999.99;  //
     exit;
   end;
   dA := RadToDeg(ArcSin(sinA));
   dB := 180 - dC - dA;
   sinB := Sin(DegToRad(dB));

   if  abs(sinC) < 0.00000001 then
      vR := pSpeed + tSpeed * cos(DegToRad(dC))
   else
      vR := (pSpeed * sinB) / sinC;

   hBearing := tCourse + dB;
   if abs(vR) < 0.00000001 then begin
     hTime  := 9999999.99;  //  tidak terkejar
     hRange := 9999999.99;  //
   end
   else begin
     hTime := tRange / vR;
     hRange := hTime * pSpeed;
   end;
end;

{ TTorpedoTrack }

constructor TTorpedoTrack.Create;
begin
  inherited;

  SpeedType := stMedium;
  FMaxWire  := (15311 + 20122) * C_Yard_To_NauticalMiles  * C_NauticalMile_To_Degree;
  FMaxBatt  :=  FMaxWire * 1.2;   // ga tau nilainya.

  Launched  := FALSE;
end;

destructor TTorpedoTrack.Destroy;
begin
  ViewContainer.ClearObject;
  inherited;
end;

procedure TTorpedoTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;
  TrackView := TTorpedoView.CreateOnMapX(self, aMap);
  TrackView.Visible := true;
  ViewContainer.AddObject(TrackView);
end;

procedure TTorpedoTrack.Run(const aDeltaMs: double);
begin
  inherited;

  CalcPHP;
end;

procedure TTorpedoTrack.Update;
begin
  inherited;

end;

procedure TTorpedoTrack.CalcPHP;
var mx, my : double;
    tRange, tBearing, tSpeed, tCourse: double;
    pSpeed: double;
    hRange, hBearing, hTime: double;

begin
  if Assigned(TargetTrack) then begin
    Target.Distance := CalcRange(FPosition.X, FPosition.Y,
                          TargetTrack.PositionX, TargetTrack.PositionY);
    Target.Bearing  := CalcBearing(FPosition.X, FPosition.Y,
                        TargetTrack.PositionX, TargetTrack.PositionY);
    Target.Speed  :=  TargetTrack.Speed;
    Target.Course :=  TargetTrack.Course;

  end;

  tRange  :=  Target.Distance;
  tBearing:=  Target.Bearing ;
  tSpeed  :=  Target.Speed   ;
  tCourse :=  Target.Course  ;

  pSpeed  :=  Speed;

  CalcHitPredition(tRange, tBearing, tSpeed, tCourse,
                   pSpeed,
                   hRange, hBearing, hTime);

  PhpData.hitRange    := hRange;
  PhpData.hitBearing  := hBearing;
  phpData.hitTime     := hTime;

  RangeBearingToCoord(hRange* C_NauticalMile_To_Degree, hBearing, mx, my );

  TrackView.ptHit.Mx.X := PositionX + mx;
  TrackView.ptHit.Mx.Y := PositionY + my ;

  Course := hBearing;

  //TrackView.ptMaxWire :=
  RangeBearingToCoord(FMaxWire , hBearing, mx, my );
  TrackView.ptMaxWire.Mx.X := PositionX + mx;
  TrackView.ptMaxWire.Mx.Y := PositionY + my;

  RangeBearingToCoord(FMaxBatt , hBearing, mx, my );
  TrackView.ptMaxBatt.Mx.X := PositionX + mx;
  TrackView.ptMaxBatt.Mx.Y := PositionY + my;
end;

function TTorpedoTrack.getWire: double;
begin
  result := FMaxWire * C_Degree_To_NauticalMile * C_NauticalMiles_To_Yard ;
end;
procedure TTorpedoTrack.setWire(const Value: double);
begin
  FMaxWire  := Value * C_Yard_To_NauticalMiles  * C_NauticalMile_To_Degree;
end;

procedure TTorpedoTrack.setBatt(const Value: double);
begin
  FMaxBatt  := Value * C_Yard_To_NauticalMiles  * C_NauticalMile_To_Degree;
end;

function TTorpedoTrack.getBatt: double;
begin
  result := FMaxBatt * C_Degree_To_NauticalMile * C_NauticalMiles_To_Yard ;
end;


procedure TTorpedoTrack.SetSpeedType(const Value: TSpeedType);
begin
  FSpeedType := Value;
  case FSpeedType of
    stLow    : Speed := 18;
    stMedium : Speed := 23;
    stHigh   : Speed := 24;
  end;
end;

function TTorpedoTrack.getTube: TTube;
begin
  result := FTube;
end;

procedure TTorpedoTrack.setTube(const Value: TTube);
begin
  FTube := Value;
  case FTube of
    ttPort :
      TrackView.TubeInfo := 'PT';
    ttStarBoard  :
      TrackView.TubeInfo := 'SB';
  end;

end;

function TTorpedoTrack.getEnbDist: double;
begin

end;

procedure TTorpedoTrack.setEnbDist(const Value: double);
begin

end;

end.
