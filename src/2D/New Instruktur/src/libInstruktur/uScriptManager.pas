unit uScriptManager;

interface

uses
  Windows, Classes,
  uInstrukturManager, uSimulationManager, uEventManager, uDataModule;

  procedure CreateSimulation;
  procedure EndSimulation;
  procedure StartSimulation;

implementation

  procedure CreateSimulation;
  begin
    SimManager      := TSimManager.create;
    SimCenter       := SimManager;
    EventManager    := TEventManager.Create;
  end;

  procedure StartSimulation;
  begin
    EventManager.AssignEvent;
    SimManager.StartSimulation;
    SimManager.ConnectToBridge;
  end;

  procedure EndSimulation;
  begin
    SimManager.StopSimulation;

    { Disconnect From Database - Sometime Generates Error }
    DataModule1.EmuConn.Disconnect;

    SimCenter       := nil;

    { Geoset Set Nil - Sometimes Error Mapper.dll } 
    SimManager.FMap.Geoset := '';
    SimManager.FMap        := nil;

    SimManager.Free;
    EventManager.Free;
  end;
  
end.
