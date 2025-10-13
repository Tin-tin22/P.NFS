unit uSingaTorpedoManager;

interface

uses
   uTDCManager;

type

  TTOCOSMan =  class(TTDCManager)


  end;

  procedure BeginSimulation;
  procedure EndSimulation;

var
  TOCOSSimCenter  : TTOCOSMan;


implementation


//------------------------------------------------------------------------------
//-- Simulation Initialization and Finalization
    procedure BeginSimulation;
    begin
      TOCOSSimCenter  := TTOCOSMan.Create;
      uSimulationManager.SimCenter := TOCOSSimCenter;
    end;

    procedure EndSimulation;
    begin
      uSimulationManager.SimCenter := nil;
      TOCOSSimCenter.Free;

    end;

end.
