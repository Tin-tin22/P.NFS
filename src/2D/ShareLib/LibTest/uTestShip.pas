unit uTestShip;


(*
   experimental ship
   interface


   uBaseDatatype, uBaseSimulationObject;

type


//==============================================================================
    TRadarAreaView = class(TSimViewOnMapX)

   *)

interface

  uses
    Windows, Graphics, MapXLib_TLB ,
    uBaseSimulationObject, uBaseConstan, uMover, uObjectView,
    
    uMapXSim;

  type
//==============================================================================
   TTurnState  = (tsNone, tsTurnLeft, tsTurnRight);

   TSpeedState = (ssStable, ssAccelerate, ssDecelerate);

//==============================================================================

    TXShip = class (TSimClassOnMapX)
    private

      procedure SetHeading(const Value: double);
      function  GetHeading: double;

      function  GetSpeed: double;
      procedure InitSpeed(const Value: double);

      function  GetPos(const Index: Integer): double;
      procedure SetPos(const Index: Integer; const Value: double);

      //wida nambah
      procedure SetRoll(const val: Double);
      function  GetRoll: Double;

      procedure SetPitch(const val: Double);
      function  GetPitch: Double;

    protected
      FRoll : Double;
      FPitch: Double;

      //- ori data -
      FTurnState : TTurnState;
      FTurnDirection : double;
      FTurnRate      : double;
      FTurnCounter   : double;

      FSpeedState : TSpeedState;
      FDestSpeed  : double;

      //- view data
      FVSpeedVector : TSpeedVector;
      FV3Linelabel  : T3LineLabel;

    public
      Mover :  TMover;

      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;

      procedure Run(const aDeltaMs: double);    override;
      procedure Update; override;

    published

      property  Speed         : double read GetSpeed write InitSpeed;
      property  Heading       : double read GetHeading write SetHeading;
      //***
      property Roll           : Double read GetRoll write SetRoll;
      property Pitch          : Double read GetPitch write SetPitch;
      //***
      property PositionX : double index 0 // longlat degree
          read GetPos write SetPos;
      property PositionY : double index 1 // longlat degree
          read GetPos write SetPos;
      property PositionZ : double index 2 // longlat degree NOT always zero
          read GetPos write SetPos;

    public
      Moving : boolean;

      procedure SetTurnRate(const aTurnRate: double);     // degree / second;
//      procedure SetDirectionTo(const aDir: double);     // degree compass

      procedure CmdTurnLeftTo(const aDir:double);            // degree compass
      procedure CmdTurnRightTo(const aDir:double);

      procedure CmdSetSpeedTo(const aSpd: double);

    end;

//==============================================================================
{    TXShipView = class(TSimViewOnMapX)
    private

    protected

    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

    published

    end;
}
    TXSonarObject = class (TXShip)
    private
      FSoundFilename : String;     //trisno: idem dgn di atas
      FFreq          : double;
      FSoundFilePassive: String;
      FProfileFile: String;
      FEchoLevel: double;

      function GetSoundFile: String;  //trisno:added  to store sound filename
      procedure SetSoundFile(const Value: String);

      function GetFreq: double;  //trisno:added  to store freq
      procedure SetFreq(const Value: double);
      procedure SetSoundFilePassive(const Value: String);
      procedure SetProfileFile(const Value: String);
      procedure SetEchoLevel(const Value: double);
    public

    published
      //trisno: idem dgn di atas
      property SoundFile : String read GetSoundFile write SetSoundFile;
      property Freq : double read GetFreq write SetFreq;
      property SoundFilePassive : String read FSoundFilePassive write SetSoundFilePassive;
      property ProfileFile : String read FProfileFile write SetProfileFile;
      property EchoLevel : double read FEchoLevel write SetEchoLevel;
    end;


implementation

uses uBaseFunction, math, SysUtils;

//==============================================================================
{ TXShip }

constructor TXShip.Create;
begin
  inherited;

  FTurnState  := tsNone;
  FSpeedState := ssStable;

  Mover :=  TMover.Create;

//  Moving := FALSE;

  Moving := TRUE;

  FRoll := 0.0;
  FPitch := 0.0;

end;

destructor TXShip.Destroy;
begin

  ViewContainer.ClearObject;

  inherited;
end;

procedure TXShip.CreateDefaultView(const aMap: TMap);
begin
  FVSpeedVector := TSpeedVector.CreateOnMapX(self, aMap);
  FVSpeedVector.Visible := TRUE;

  ViewContainer.AddObject(FVSpeedVector);

  FV3Linelabel  := T3LineLabel.CreateOnMapX(self, aMap);
  FV3Linelabel.Visible := FALSE;
  ViewContainer.AddObject(FV3Linelabel);

end;

procedure TXShip.SetPos(const Index: Integer; const Value: double);
begin
  case Index of
    0: begin
        FPosition.X := Value;
        Mover.X     := Value;
    end;
    1: begin
        FPosition.Y := Value;
        Mover.Y     := Value;
    end;
    2: begin
        FPosition.Z := Value;
        Mover.Z     := Value;

    end;
  end;
end;

function TXShip.GetPos(const Index: Integer): double;
begin
  case Index of
    0: Result := FPosition.X;
    1: Result := FPosition.Y;
    2: Result := FPosition.Z;
  else
    Result := 0;
  end
end;
//------------------------------------------------------------------------------
procedure TXShip.SetHeading(const Value: double);
begin
  Mover.Direction := ConvCompass_To_Cartesian(Value);
end;

function TXShip.GetHeading: double;
begin
  result :=  ConvCartesian_To_Compass(Mover.Direction);
end;
//------------------------------------------------------------------------------
procedure TXShip.SetRoll(const val: Double);
begin
  FRoll := val;
end;

function TXShip.GetRoll: Double;
begin
  Result := FRoll;
end;

procedure TXShip.SetPitch(const val: Double);
begin
  FPitch := val;
end;

function TXShip.GetPitch: Double;
begin
  Result := FPitch;
end;
//------------------------------------------------------------------------------

procedure TXShip.InitSpeed(const Value: double);
begin
  Mover.Speed := Value;
end;

function TXShip.GetSpeed: double;
begin
  result := Mover.Speed;
end;

procedure TXShip.Run(const aDeltaMs: double);
begin
  inherited;

  if Moving then begin

    if FSpeedState <> ssStable then begin
      Mover.Calc_Speed(aDeltaMs);

      if ((FSpeedState = ssAccelerate) and (Mover.Speed >= FDestSpeed))
      or ((FSpeedState = ssDecelerate) and (Mover.Speed <= FDestSpeed)) then

        FSpeedState := ssStable;

    end;

    if (FTurnState = tsTurnLeft) or ((FTurnState = tsTurnRight))  then begin        // turn rate : (+) , CCW

      Mover.Calc_Direction(aDeltaMs);
      FTurnCounter := FTurnCounter - abs(Mover.DeltaDirection);

      if FTurnCounter <= 0.0 then begin
         FTurnCounter := 0.0;
         FTurnState := tsNone;
      end;

   end;

   Mover.Calc_Movement(aDeltaMs);
   FPosition.X := Mover.X;
   FPosition.Y := Mover.Y;

  end;
end;

procedure TXShip.Update;
//var spd, head: double;
begin
  inherited;

{  FVSpeedVector.Speed     := Mover.Speed;
  FVSpeedVector.Heading   := Mover.Direction;

  spd  := Mover.Speed;
  head := ConvCartesian_To_Compass(Mover.Direction);

  FV3Linelabel.Line1 := Format('%3.0f',[spd]);
  FV3Linelabel.Line2 := Format('%3.0f',[head]);
}
end;

procedure TXShip.SetTurnRate(const aTurnRate: double);
begin
  FTurnRate      := abs(aTurnRate); // Degree per second;

end;

procedure TXShip.CmdTurnLeftTo(const aDir: double);
// 'Left' = CCW;
// aDir : Compass
// FTurnDirection :
begin
  FTurnDirection := ConvCompass_To_Cartesian(aDir);
  Mover.TurnRate := FTurnRate;

  FTurnCounter := FTurnDirection - Mover.Direction;
  if FTurnCounter < 0.0 then FTurnCounter := FTurnCounter + 360.0;

  FTurnState := tsTurnLeft;
end;

procedure TXShip.CmdTurnRightTo(const aDir: double);
begin
  FTurnDirection := ConvCompass_To_Cartesian(aDir);
  Mover.TurnRate := -FTurnRate;

  FTurnCounter := Mover.Direction - FTurnDirection;
  if FTurnCounter < 0.0 then FTurnCounter := FTurnCounter + 360.0;

  FTurnState := tsTurnRight;
end;

procedure TXShip.CmdSetSpeedTo(const aSpd: double);
begin
  FDestSpeed  := aSpd;
  FSpeedState := ssAccelerate
end;

//------------------------------------------------------------------------------
//trisno: additional property implementation
procedure TXSonarObject.SetSoundFile(const Value: String);
begin
  FSoundFilename := Value;
end;

function TXSonarObject.GetSoundFile: String;
begin
  result :=  FSoundFilename;
end;

procedure TXSonarObject.SetFreq(const Value: double);
begin
  FFreq := Value;
end;

function TXSonarObject.GetFreq: double;
begin
  result :=  FFreq;
end;

procedure TXSonarObject.SetSoundFilePassive(const Value: String);
begin
  FSoundFilePassive := Value;
end;

procedure TXSonarObject.SetProfileFile(const Value: String);
begin
  FProfileFile := Value;
end;

procedure TXSonarObject.SetEchoLevel(const Value: double);
begin
  FEchoLevel := Value;
end;

end.
