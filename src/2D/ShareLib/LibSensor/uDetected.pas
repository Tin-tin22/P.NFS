unit uDetected;

interface

  uses
    Graphics, MapXLib_TLB,
    uMapXSim, uObjectView, uMover, uBaseConstan, uRadarTracks;

  type
//==============================================================================
    tSignal = record
       Frequency: double;
       Power    : double;
    end;

//==============================================================================
// Detected Object = echo radar
    TDetectedObject = class(TDisplayTrack)
    private
      FVisibles: boolean;

      procedure SetVisibles(const Value: boolean);
      function getMaxColor: byte;
      procedure setmaxColor(const Value: byte);

    protected
      //- view data
      FRawVideo     : TRawVideoView;

      FDetPosTick,
      FLastDetPosTick  : LongWord;
      FLifeCounter     : double;

    public
      DetRange   : double;              // range from detector
      DetRangeBef :Double;
      DetBearing : double;
      DetTrackNumber : integer;

      DetSpeed  : double; // calculated;
      DetHead   : double; // calculated;
      DetDepth : double;
      DetName   : string;

      VisSubSurf : Boolean;
      VisSurf : Boolean;

      ReceivedSignal  : TSignal;
      ReturnSignal    : TSignal;

      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      procedure Update; override;


      procedure SetDetectedPosition(const x, y, z : double; const gTimeMs: LongWord);
      procedure Run(const aDeltaMs: double); override;

      property Visibles : boolean read FVisibles write SetVisibles;

      property MaxColors: byte read getMaxColor write setmaxColor;

    end;

//Trisno : Modification for Sonar ==============================================
    TSonarDetectedObject = class(TDetectedObject)
    public
      ShipPositionX : double;
      ShipPositionY : double;
      //ProfileFname : String;
      oObj : TObject;
      initvalue : boolean;
      procedure SetDetectedPosition(const x, y, z : double; const gTimeMs: LongWord;
                                    const ShipPosX, ShipPosY: double);overload;
    end;
//Trisno : end =================================================================

implementation

uses
  SysUtils, uBaseFunction, uBaseSimulationObject, Math, Classes;


{ TDetectedObject }

constructor TDetectedObject.Create;
begin
  inherited;
  FLastDetPosTick := 0;
  FDetPosTick     := 0;
  FLifeCounter := 0;

//  FTAssesTimer  := 0;
end;

procedure TDetectedObject.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  FRawVideo     := TRawVideoView.CreateOnMapX(self, aMap);
  FRawVideo.Color :=  C_defColor;
  FRawVideo.Visible := TRUE;
  ViewContainer.AddObject(FRawVideo);

end;

destructor TDetectedObject.Destroy;
begin
  ViewContainer.ClearObject;

  inherited;
end;

{function TDetectedObject.ProcessSignal(const recv: TSignal): TSignal;
begin
  ReceivedSignal := recv;

  ReturnSignal.Frequency := CalcDopplerShift()

end;
}
procedure TDetectedObject.Run(const aDeltaMs: double);
begin
  FRawVideo.ReduceIntensity(aDeltaMs);

  FLifeCounter := FLifeCounter + aDeltaMs;

  if FLifeCounter > 12000 then begin
     FNeedToBeFree := TRUE;
//     FLinelabel.Lbl1.Text := 'killed'
  end

end;

procedure TDetectedObject.SetDetectedPosition(const x, y, z : double;
    const gTimeMs: LongWord);
var dt : integer;
    dx, dy, dz : double;
    dist : double;
    initvalue : boolean;
begin

  FLastDetPosTick := FDetPosTick;
  FDetPosTick     := gTimeMs;

  dt := FDetPosTick - FLastDetPosTick;
  // known ms

  if (PositionX = 0) and (PositionY = 0) and (PositionZ = 0) then initvalue := true
  else initvalue := false;

  dx := x - PositionX;
  dy := y - PositionY;
  dz := z - PositionZ;

  PositionX  :=  x ;
  PositionY  :=  y ;
  PositionZ  :=  z ;

  DetHead  := ConvCartesian_To_Compass(C_RadToDeg * ArcTan2(dy, dx));  // compas
  dist := sqrt(sqr(dx) + sqr(dy)); //dy*-1.0;//

  if not IsAlmostZero (dt) and not initvalue then
    DetSpeed := (dist * C_Degree_To_NauticalMile) * C_HourToMilliSecond / dt
  else
    DetSpeed := 0;

  if Assigned (FRawVideo) then
    FRawVideo.MakeFullIntensity;

  FLifeCounter := 0;
end;

//Trisno : Modification for sonar ==============================================
procedure TSonarDetectedObject.SetDetectedPosition(const x, y, z: double;
  const gTimeMs: LongWord; const ShipPosX, ShipPosY: double);
var dt : integer;
    dx, dy, dz : double;
    dist: double;
begin
  if (PositionX = 0) and (PositionY = 0) and (PositionZ = 0) then initvalue := true
  else initvalue := false;

  FLastDetPosTick := FDetPosTick;
  FDetPosTick     := gTimeMs;

  dt := FDetPosTick - FLastDetPosTick;
  // known ms

  dx := x - PositionX;
  dy := y - PositionY;
  dz := z - PositionZ;


  DetHead  :=  ConvCartesian_To_Compass(C_RadToDeg * ArcTan2(dy, dx));  // compas

  //relative speed
  dx := (x - ShipPosX) - (PositionX - ShipPositionX);
  dy := (y - ShipPosY) - (PositionY - ShipPositionY);


  dist := sqrt(sqr(dx) + sqr(dy));

  if not IsAlmostZero (dt) and not initvalue then
    DetSpeed := (dist * C_Degree_To_NauticalMile) * C_HourToMilliSecond / dt
  else
    DetSpeed := 0;
{
  dx := x-ShipPosX;
  dy := y-ShipPosY;

  dist := sqrt(sqr(dx) + sqr(dy));

  dx := PositionX - ShipPositionX;
  dy := PositionY - ShipPositionY;

  prevdist := sqrt(sqr(dx) + sqr(dy));

  if prevDist < dist then begin
    DetSpeed := DetSpeed * -1;
  end;
}
  PositionX  :=  x ;
  PositionY  :=  y ;
  PositionZ  :=  z ;

  ShipPositionX := ShipPosX;
  ShipPositionY := ShipPosY;

{  if Assigned (FHistory) then
    FHistory.AddPoint(x, y);
}  if Assigned (FRawVideo) then
  FRawVideo.MakeFullIntensity;


  FLifeCounter := 0;
end;
//Trisno : end =================================================================

procedure TDetectedObject.SetVisibles(const Value: boolean);
var i   : integer;
    View: TSimulationView;
    list: TList;
begin
  FVisibles := Value;
  list := ViewContainer.GetList;

  for i := 0 to  list.Count-1 do begin
    View := TSimulationView(list.Items[i]);
    View.Visible := Value;
  end;
  FClickArea.Visible := FALSE;
  ViewContainer.ReturnList;
end;

procedure TDetectedObject.Update;
begin
  inherited;

  if FRawVideo.Visible then begin
    FRawVideo.Direction := DetHead;
  end;
end;


//==============================================================================
function TDetectedObject.getMaxColor: byte;
begin
  result := FRawVideo.MaxColor;
end;

procedure TDetectedObject.setmaxColor(const Value: byte);
begin
  FRawVideo.MaxColor := Value;
end;

end.
