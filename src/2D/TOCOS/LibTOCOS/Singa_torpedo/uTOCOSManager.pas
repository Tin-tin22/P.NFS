unit uTOCOSManager;

interface

uses
   uTDCManager;

type

  TTOCOSMan =  class(TTDCManager)

  public
     procedure CreateShipForms(const aShipClassID, aTDCNumber: integer); override;
  end;

  procedure BeginSimulation;
  procedure EndSimulation;

var
  TOCOSSimCenter  : TTOCOSMan;


implementation

uses
  uSimulationManager, uLibTorpedo_Singa;


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

{ TTOCOSMan }

procedure TTOCOSMan.CreateShipForms(const aShipClassID,
  aTDCNumber: integer);
begin
//  inherited;

  TheTDC := TTorpedoInterface.Create;
  FMap := TheTDC.frmTengah.Map;

end;

end.
