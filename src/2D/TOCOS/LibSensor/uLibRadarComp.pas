unit uLibRadarComp;

(*
  Created       : 15 August 2007
  Last Modified : 15 August 2007

  Author        : Andy Sucipto
  Description   : component part of Radar class for Emulator Client2D

*)


interface

  uses
   Windows, Graphics, MapXLib_TLB,

   uBaseSimulationObject, uMapXSim;


  type

//==============================================================================
    TRadarComponent = class(TSimulationClass)

    end;

    TRadarScanPattern = (rspHorizontal, rspHelical ); // conical, raster, dll


//==============================================================================
    TRadarTimeBase = class(TSimulationClass)
    private
      FScanPattern: TRadarScanPattern;
      FElevation: double;

      function GetDirection: double;
      procedure setDirectionOffset(const Value: double);
    procedure SetElevation(const Value: double);

    protected
      FAbsoluteDirection: double;   // absolut from east 0°
      FDirectionOffset  : double;   // ofsset, ship heading
      FDirection        : double;   // actual timebase direction

      FPrevDirection    : double;
      FRotationSpeed    : double;   // RPM

      // vertical direction


    public

      constructor Create;

      procedure Run(const aDeltaMs: double);   override;

    published
      property RotationSpeed: double read FRotationSpeed write FRotationSpeed;

      property CurrentDirection:  double read GetDirection;
      property DirectionOffset: double read FDirectionOffset write setDirectionOffset;
      property OriginalDirection: double read FDirection;  //actual cartesian direction

      property ScanPatern: TRadarScanPattern read FScanPattern write FScanPattern;

      property Elevation: double read FElevation write SetElevation;
    end;


//==============================================================================



implementation

uses
  uBaseFunction, uBaseConstan, uLibRadar, math, SysUtils;

//==============================================================================
{ TRadarComponent }



//==============================================================================
{ TRadarTimeBase }
constructor TRadarTimeBase.Create;
begin
  inherited;
  FAbsoluteDirection  := 0.0;
  FDirectionOffset    := 45.0;
  FDirection      := FAbsoluteDirection + FDirectionOffset;

  FRotationSpeed  := 6.0;

  FElevation      := 0.0; //
end;


function TRadarTimeBase.GetDirection: double;
begin
  Result := ConvCartesian_To_Compass(FDirection);
end;

procedure TRadarTimeBase.setDirectionOffset(const Value: double);
begin
  FDirectionOffset := Value;
  FDirection := FAbsoluteDirection + FDirectionOffset;

end;

procedure TRadarTimeBase.Run(const aDeltaMs: double);
var addDegree: double;
begin
  inherited;
    { TODO : Buat helical scan mode }
  FPrevDirection := FDirection;

  addDegree:= 0.006 * aDeltaMs *  FRotationSpeed;
  FAbsoluteDirection := FAbsoluteDirection - adddegree;

  FDirection := FAbsoluteDirection + FDirectionOffset;

  while FAbsoluteDirection < 0.0 do
    FAbsoluteDirection := FAbsoluteDirection + 360.0;

  while FDirection < 0.0 do
    FDirection := FDirection + 360.0;

//if ScanPatern = rspHelical then begin
//  FElevation := FElevation + aDeltaMs *
//end;

end;


procedure TRadarTimeBase.SetElevation(const Value: double);
begin
  FElevation := Value;
end;

end.
