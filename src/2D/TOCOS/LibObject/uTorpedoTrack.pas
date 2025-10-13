unit uTorpedoTrack;

interface

  uses
    uRadarTracks, MapXLib_TLB, uBaseDataType, uTorpedoView, uLibTDCTracks;

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



    TStatusWeapon = (tsOff, tsLoading, tsLaunch);
    TSpeedType = (stLow, stMedium, stHigh);
    TTube = (ttNone, ttPort, ttStarBoard);
    TPredm = (mNone, mIntercept, mBearingRider, mManualNavigate, mTargetSearchProgram, mHoming);
    TSearchm = (smSur, smSub);
    TLolimm = (lmOn, lmOff);
    THomingType = (htPas, htAct, htCmb);
    THomingBlockType = (hbOn, hbOff);

    TLoadStatus = class // Prince
    Private
    public
      Port        : TStatusWeapon;
      StarBoard   : TStatusWeapon;
      constructor Create;
      destructor Destroy; override;
    end;

    TTorpedoTrack = class (TDisplayTrack)
    private

      FMaxBatt      : Double;
      FMaxWire      : Double;
      FEndis        : Double;
      FSafeDist     : Double;
      FRunTime      : Double;
      FDepth        : Double;
      FShipDistance : Double;

      FIsManual : Boolean;

      FTube     : TTube;
      FSpeedType: TSpeedType;


      procedure setShipDist(const Value: double);
      function getShipDist: double;

      procedure setBatt(const Value: double);
      function getBatt: double;

      procedure setWire(const Value: double);
      function getWire: double;

      procedure setTube(const Value: TTube);
      function getTube: TTube;

      procedure setEnbDist(const Value: double);
      function getEnbDist: double;

      procedure SetSafeDist(const Value: double);
      function GetSafeDist: double;

      procedure SetSpeedType(const Value: TSpeedType);

      procedure SetRunTime(const value: Double);
      function getRunTime: Double;

      procedure SetDepth(const value: Double);
	    function getDepth: Double;


    protected
      tgtPos : t2DPoint;

    public
      TargetType  : Byte;
      ComUnit     : Byte;

      Ladis         : Double;
      Uplim         : Double;
      Lolim         : Double;
      SREEL         : Double;
      TREEL         : Double;
      BearingToDraw : Double;
      RangeToDraw   : Double;
      JarakTempuh   : Double;
      LastPositionX : Double;
      LastPositionY : Double;
      TempSpeed     : Double;

      TargetID      : Integer;

      IsNoTarget        : Boolean;
      IsLoadTube        : Boolean;
      Is_inTargetArea   : Boolean;
      IsnotActive_Torp  : Boolean;
      isSafedistance    : Boolean;

      Launched          : Boolean;
      IsHoaming         : Boolean;
      isShutdown        : Boolean;
      isSearch          : Boolean;
      isDetectTarget    : Boolean;

      TrackView   : TTorpedoView;
      Target      : TTarget;
      TargetTrack : TManualTrack;
      PhpData     : TPHPData;
      PredMod     : TPredm;
      LolimMode   : TLolimm;
      SearchMode  : TSearchm;
      TempSpeedType : TSpeedType;
      HomingType  : THomingType;
      HomingBlockType  : THomingBlockType;


      constructor Create;
      destructor Destroy; override;
      procedure Set_Pos_Symbol;
      procedure CreateDefaultView(const aMap: TMap); override;
      procedure Update; override;
      procedure Run(const aDeltaMs: double); override;

      procedure visPHP(aVis: Boolean);
      procedure CalcPHP;
      procedure UpdateTrack(heading: Double);
      procedure visTrackView(aVis: Boolean);
    public
      property ShipDistance : double read getShipDist   write setShipDist;      // Nm
      property EnablingDistance : double read getEnbDist   write setEnbDist;    // yard
      property SafeDistance : double read GetSafeDist  write SetSafeDist;       // yard
      property WireDistance : double read getWire      write setWire;           // yard
      property BatteryDistance : double read getBatt      write  setBatt;       // yard
      property SpeedType : TSpeedType read FSpeedType write SetSpeedType;
      property Tube : TTube read getTube write setTube;
      property RunTime : Double read getRunTime write SetRunTime;
      property Depth : Double read getDepth write SetDepth; // feet
      property IsManual : Boolean read FIsManual write FIsManual;
    end;

implementation

uses
  uBaseConstan, uBaseFunction, uBaseSimulationObject, Math;

procedure CalcHitPredition(
   const tRange, tBearing, tSpeed, tCourse: double;
   const pSpeed: double;
   var hRange, hBearing, hTime: double);
var vR : double;
//    tMinute: double;
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

  FTube             := ttPort;
  PredMod           := mIntercept;
  {Course --> diisi kearah target}
  Ladis             := 2000;
  SpeedType         := stLow;
  {cspeed --> diisi setelah ditembakkan}
  HomingType        := htPas;
  Uplim             := 54;              {feet}
  TargetType        := 1;               {__TORPEDOSUT_TARGET_SURFACE}
  FDepth            := 60.0;            {feet}
  LolimMode         := lmOn;
  Lolim             := 510;             {feet}
  HomingBlockType   := hbOff;
  EnablingDistance  := 6562;            {yard}
  ComUnit           := 1;

  WireDistance      := 15311 + 20122;   {yard}
  BatteryDistance   := WireDistance * 1.2; {sementara nilai ini g dpake low: 29.5 km; medium: 13.3 km high: 13.6 km}
  SafeDistance      := 273;             {yard}

  FRunTime          := 0;
  BearingToDraw     := 0;
  RangeToDraw       := 0;
  JarakTempuh       := 0;

  Launched          := False;
  IsHoaming         := False;
  isDetectTarget    := False;
  FIsManual         := False;
  Is_inTargetArea   := False;
  IsnotActive_Torp  := False;
  isShutdown        := False;
  isSearch          := False;
end;

destructor TTorpedoTrack.Destroy;
begin
  ViewContainer.ClearObject;
  inherited;
end;

procedure TTorpedoTrack.Set_Pos_Symbol;
begin
  TrackView.SetRange_Symbol(EnablingDistance, WireDistance, BatteryDistance);

end;

procedure TTorpedoTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;
  TrackView := TTorpedoView.CreateOnMapX(self, aMap);
  TrackView.Visible := true;
  TrackView.visiblePHP := True;
  ViewContainer.AddObject(TrackView);
  Set_Pos_Symbol;
end;

procedure TTorpedoTrack.Run(const aDeltaMs: double);
begin
  inherited;
  //if not Enabled then CalcPHP;
  //range := CalcRange(LastSetX,LastSetY, PositionX, PositionY) * C_NauticalMile_To_Degree;
  CalcPHP;
end;

procedure TTorpedoTrack.Update;
begin
  inherited;
end;

procedure TTorpedoTrack.CalcPHP;
var
  mx, my : double;
  hRange, hBearing, hTime: double;
  EndistPos, MaxWirePos, BatPos : Double;
  tempRange : Double;

begin
  if IsnotActive_Torp then
    Exit;

  if Assigned(TargetTrack) and (not IsNoTarget) then begin
    Target.Distance := CalcRange(FPosition.X, FPosition.Y,
                          TargetTrack.PositionX, TargetTrack.PositionY);
    Target.Bearing  := CalcBearing(FPosition.X, FPosition.Y,
                        TargetTrack.PositionX, TargetTrack.PositionY);
    Target.Speed    :=  TargetTrack.Speed;
    Target.Course   :=  TargetTrack.Course;

    TargetTrack.SetAssByTorpedo(TrackView.TubeInfo);
  end;

  tempRange := CalcRange(LastPositionX, LastPositionY,FPosition.X, FPosition.Y);

  JarakTempuh := JarakTempuh + tempRange;

  LastPositionX := FPosition.X;
  LastPositionY := FPosition.Y;

  CalcHitPredition(Target.Distance, Target.Bearing, Target.Speed, Target.Course, Speed,
                   hRange, hBearing, hTime); //hTime dl hour

  // jika jarak Torp <= 15m dari Php skip drawing prediction line
  Is_inTargetArea := (hRange * C_NauticalMiles_TO_Meter) <= 200;
  if Is_inTargetArea  then
  begin
    TrackView.visiblePHP := False;
    Exit;
  end;

  PhpData.hitRange    := hRange;
  PhpData.hitBearing  := hBearing;
  phpData.hitTime     := hTime;

  RunTime := hTime * C_HourToMinute;

  EndistPos  := ((EnablingDistance * C_Yard_To_NauticalMiles) - ShipDistance) * C_NauticalMile_To_Degree;
  MaxWirePos := ((WireDistance * C_Yard_To_NauticalMiles) - ShipDistance) * C_NauticalMile_To_Degree;
  BatPos     := ((BatteryDistance * C_Yard_To_NauticalMiles) - JarakTempuh) * C_NauticalMile_To_Degree;

  if BatPos * C_Degree_To_Meter <= 5 then
    BatteryDistance := 0;
  if MaxWirePos * C_Degree_To_NauticalMile < 0 then
    WireDistance := 0;


  // jarak & baringan berubah
  RangeBearingToCoord(hRange* C_NauticalMile_To_Degree, BearingToDraw, mx, my );
  TrackView.ptHit.Mx.X := PositionX + mx;
  TrackView.ptHit.Mx.Y := PositionY + my;

  // jarak tetap & baringan berubah
  RangeBearingToCoord(EndistPos, BearingToDraw, mx, my);
  TrackView.ptEndis.Mx.X := PositionX + mx;
  TrackView.ptEndis.Mx.Y := PositionY + my;

  // jarak tetap & baringan berubah
  RangeBearingToCoord(MaxWirePos , BearingToDraw, mx, my );
  TrackView.ptMaxWire.Mx.X := PositionX + mx;
  TrackView.ptMaxWire.Mx.Y := PositionY + my;

  // jarak tetap & baringan berubah
  RangeBearingToCoord(BatPos , BearingToDraw, mx, my );
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

//wida
procedure TTorpedoTrack.setEnbDist(const Value: double);
begin
  FEndis := Value * C_Yard_To_NauticalMiles  * C_NauticalMile_To_Degree;

end;

function TTorpedoTrack.getEnbDist: double;
begin
  result := FEndis * C_Degree_To_NauticalMile * C_NauticalMiles_To_Yard ;
end;

procedure TTorpedoTrack.SetRunTime(const Value: Double);
begin
   // input: minute
   FRunTime := value; // * C_HourToMinute;
end;

function TTorpedoTrack.getRunTime: Double;
begin
  result := FRunTime;
end;

procedure TTorpedoTrack.SetSafeDist(const Value: double);
begin
  FSafeDist := Value * C_Yard_To_NauticalMiles  * C_NauticalMile_To_Degree;
end;

function TTorpedoTrack.GetSafeDist: double;
begin
  result := FSafeDist * C_Degree_To_NauticalMile * C_NauticalMiles_To_Yard;
end;

procedure TTorpedoTrack.SetDepth(const value:Double);
begin
  FDepth := value;
end;

function TTorpedoTrack.getDepth: Double;
begin
  result := FDepth;
end;

procedure TTorpedoTrack.SetSpeedType(const Value: TSpeedType);
begin
  FSpeedType := Value;
  case FSpeedType of
    stLow    : Speed := 18;
    stMedium : Speed := 23;
    stHigh   : Speed := 34;
  end;
end;

procedure TTorpedoTrack.setShipDist(const Value: double);
begin
  FShipDistance := Value;
end;

function TTorpedoTrack.getShipDist: double;
begin
  result := FShipDistance;
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

procedure TTorpedoTrack.visPHP(aVis: Boolean);
begin
  TrackView.visiblePHP := aVis;
end;

procedure TTorpedoTrack.UpdateTrack(heading: Double);
//var mx, my : double;
begin
//  RangeBearingToCoord(FMaxWire , heading, mx, my );
//  TrackView.ptMaxWire.Mx.X := PositionX + mx;
//  TrackView.ptMaxWire.Mx.Y := PositionY + my;
//
//  RangeBearingToCoord(FMaxBatt , heading, mx, my );
//  TrackView.ptMaxBatt.Mx.X := PositionX + mx;
//  TrackView.ptMaxBatt.Mx.Y := PositionY + my;
//
//  RangeBearingToCoord(FEndis, heading, mx, my);
//  TrackView.ptEndis.Mx.X := PositionX + mx;
//  TrackView.ptEndis.Mx.Y := PositionY + my;

  TrackView.ptHit.Mx.X := TrackView.ptMaxWire.Mx.X ;
  TrackView.ptHit.Mx.Y := TrackView.ptMaxWire.Mx.Y;
end;

procedure TTorpedoTrack.visTrackView(aVis: Boolean);
begin
  //Enabled := False;
  TrackView.Visible := aVis;
end;

{ TLoadStatus }

constructor TLoadStatus.Create;
begin

end;

destructor TLoadStatus.Destroy;
begin

  inherited;
end;

end.
