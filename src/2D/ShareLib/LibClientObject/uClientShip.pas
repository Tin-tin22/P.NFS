unit uClientShip;

interface

  uses
//    Graphics, MapXLib_TLB,
    uBaseSimulationObject, uLibClientObject;



//==============================================================================
  type

    TClientShip = class(TClientObject)
    protected
      

    public

      constructor Create;
      destructor Destroy; override;


    end;



implementation

//==============================================================================
{ TClientShip }

constructor TClientShip.Create;
begin

end;

destructor TClientShip.Destroy;
begin

  inherited;
end;

end.
