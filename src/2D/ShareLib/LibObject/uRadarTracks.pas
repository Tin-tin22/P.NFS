unit uRadarTracks;

interface

  uses
    Graphics, MapXLib_TLB,
    uMapXSim, uMover, uBaseConstan, uObjectView;

  type

//==============================================================================
    TRadarTrack = class(TSimClassOnMapX)
    protected
      procedure SetX(const Value: double); virtual;
      procedure SetY(const Value: double); virtual;
      procedure SetZ(const Value: double); virtual;

      function getIsMoving: boolean;

      function GetSpeed: double;
      procedure SetSpeed(const Value: double);

      function getCourse: double;
      procedure setCourse(const Value: double);

      function getHeight: double;
      procedure setHeight(const Value: double);
    public
      FMover : TMover;

      LastUpdateTime : double;
      LastSetX, LastSetY: double;

      constructor Create;
      destructor Destroy; override;


      procedure Update; override;
      procedure Run(const aDeltaMs: double); override;

      procedure SetPosition(const x, y: double);

    public
      property Speed: double read GetSpeed write SetSpeed;
      property Course: double read getCourse write setCourse;
      property Height: double read getHeight write setHeight; //meter

      property PositionX : double read FPosition.X write SetX;
      property PositionY : double read FPosition.Y write SetY;
      property PositionZ : double read FPosition.Z write SetZ;

      property IsMoving: Boolean read  getIsMoving;

    end;
//==============================================================================

    TDisplayTrack   = class(TRadarTrack)  // track yg bisa di testhit;
    protected
      FClickArea    : TRectangleView;
    public
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      function TestViewHit(const x, y: integer): boolean; virtual;

    end;

implementation

uses
  uBaseFunction, uBaseSimulationObject, uBaseDataType;

//==============================================================================
{ TRadarTrack }

constructor TRadarTrack.Create;
begin
  inherited;

  FMover := TMover.Create;
  FMover.Speed := 0.0;
  FMover.Acceleration := 0.0;
  FMover.TurnRate := 0.0;
  FMover.Direction := 90.0;
end;

destructor TRadarTrack.Destroy;
begin
  FMover.Free;

  inherited;
end;

function TRadarTrack.getIsMoving: boolean;
begin
  result := not IsAlmostZero(FMover.Speed);    //knots. klo ga salah. :P
end;

function TRadarTrack.GetSpeed: double;
begin
  result := FMover.Speed;
end;

procedure TRadarTrack.SetSpeed(const Value: double);
begin
  FMover.Speed := abs(Value);
end;

function TRadarTrack.getCourse: double;
begin
  Result := ConvCartesian_To_Compass(FMover.Direction);
end;

procedure TRadarTrack.setCourse(const Value: double);
begin
  FMover.Direction := ConvCompass_To_Cartesian(Value);
end;

function TRadarTrack.getHeight: double;
begin
  result := FPosition.Z * C_Degree_To_NauticalMile * C_NauticalMiles_TO_Meter;
end;

procedure TRadarTrack.setHeight(const Value: double);
begin
  FPosition.Z := Value * C_Meter_To_NauticalMiles * C_NauticalMile_To_Degree;
  FMover.Z := FPosition.Z;
end;

procedure TRadarTrack.Run(const aDeltaMs: double);
begin
  inherited;
  if Enabled  then
    if getIsMoving then begin
      // gerak lurus tok.
      FMover.Move(aDeltaMs);
    end;
end;

procedure TRadarTrack.SetPosition(const x, y: double);
begin
  SetX(X);
  SetY(Y);

  LastSetX := X;
  LastSetY := Y;
end;

procedure TRadarTrack.Update;
begin
  inherited;

  if getIsMoving then begin
    FPosition.X := FMover.X;
    FPosition.Y := FMover.Y;
  end;
end;

procedure TRadarTrack.SetX(const Value: double);
begin
  FPosition.X := Value;
  FMover.X    := Value;
end;

procedure TRadarTrack.SetY(const Value: double);
begin
  FPosition.Y := Value;
  FMover.Y    := Value;
end;

procedure TRadarTrack.SetZ(const Value: double);
begin
  FPosition.Z := Value;
  FMover.Z    := Value;
end;


{ TDisplayTrack }

procedure TDisplayTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  FClickArea  := TRectangleView.CreateOnMapX(self,  aMap);
  FClickArea.Visible := FALSE;
  ViewContainer.AddObject(FClickArea);
end;

destructor TDisplayTrack.Destroy;
begin
  ViewContainer.CleanUpObject;

  inherited;
end;

function TDisplayTrack.TestViewHit(const x, y: integer): boolean;
begin
  result :=  Assigned(FClickArea) and FClickArea.TestHitView(x, y);
end;

end.
