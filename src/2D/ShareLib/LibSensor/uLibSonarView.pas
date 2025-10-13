unit uLibSonarView;

interface

  uses

   uBaseSimulationObject, uMapXSim, MapXLib_TLB;

  type

//==============================================================================
   TClientSonarView = class(TSimViewOnMapX)

   public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;
    constructor Create;


   end;


implementation


{ TClientSonarView }

constructor TClientSonarView.Create;
begin


end;

constructor TClientSonarView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

end;

destructor TClientSonarView.Destroy;
begin

  inherited;
end;

end.
