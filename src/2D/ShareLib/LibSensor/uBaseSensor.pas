unit uBaseSensor;

(*
  Created       : 14 August 2007
  Last Modified : 14 August 2007

  Author        : Andy Sucipto
  Description   : Base class of radar & sonar;

*)


interface

uses

  uBaseSimulationObject,
  uMapXSim;

type

//==============================================================================
    tPolarizationDirection = (pdHorizontal, pdVertical);
    tFrequencyMode = (fmFixed, fmAgile);

//==============================================================================
   TGenericSensor = class(TSimClassOnMapX)


   public
      constructor Create;
      destructor Destroy; override;

   end;



implementation

{ TBaseSensor }

constructor TGenericSensor.Create;
begin
  inherited;

end;

destructor TGenericSensor.Destroy;
begin

  inherited;
end;


{function Calc_PRF_To_Detection_Range(const aPRFinPPS: double):double;
begin ///result in nautical miles  //untested
  result := IfThen(IsAlmostZero(aPRFinPPS), 0.0,
    (C_Meter_To_NauticalMiles * 0.5 * C_SPEED_OF_LIGHT / aPRFinPPS));
end;

function Calc_DetectionRange_To_PRF(const aRNm: double):double;
begin //untested
  result :=  0.5 * C_SPEED_OF_LIGHT / (aRNm * C_NauticalMiles_TO_Meter);
end;
}

end.
