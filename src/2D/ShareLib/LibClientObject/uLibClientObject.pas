unit uLibClientObject;
(*
  Created       : 15 August 2007
  Last Modified : 19 August 2007

  Author        : Andy Sucipto
  Description   : class description untuk client object;
                  receive synchronization from server.

*)


interface

  uses
    uBaseSimulationObject;

  type


//==============================================================================

  TClientObject = class(TSimulationClass)
  protected

  public
    Speed         : double;
    Heading       : double;

    constructor Create;
    destructor Destroy; override;

  end;



implementation

{ TClientObject }

constructor TClientObject.Create;
begin
  inherited;

end;

destructor TClientObject.Destroy;
begin

  inherited;
end;

end.



