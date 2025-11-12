program FCC;

uses
  Vcl.Forms,
  ufrmMainDisplay in 'ufrmMainDisplay.pas' {frmMainFCC},
  uBaseFunctionFCC in 'LibBaseSystem\uBaseFunctionFCC.pas',
  uLibConst in 'LibUtils\uLibConst.pas',
  uBaseConst in 'LibBaseSystem\uBaseConst.pas',
  GdiPlus in 'libGDI\GdiPlus.pas',
  GdiPlusHelpers in 'libGDI\GdiPlusHelpers.pas',
  uObjectVisual in 'LibVisual\uObjectVisual.pas',
  uSimVisuals in 'LibVisual\uSimVisuals.pas',
  uCoordConverter in 'LibBaseSystem\uCoordConverter.pas',
  uCoordDataTypes in 'LibBaseSystem\uCoordDataTypes.pas',
  uTrackView in 'LibFCCObject\uTrackView.pas',
  uMapXUnitConverter in 'LibMapX\uMapXUnitConverter.pas',
  uFccManager in 'uFccManager.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uRadarVisual in 'LibVisual\uRadarVisual.pas',
  uRadarDynamicSector in 'LibVisual\uRadarDynamicSector.pas',
  uRadarNorthIndicator in 'uRadarNorthIndicator.pas',
  uRadarTargets in 'uRadarTargets.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainFCC, frmMainFCC);
  Application.Run;
end.
