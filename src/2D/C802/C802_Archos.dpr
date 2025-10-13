program C802_Archos;

uses
  Forms,
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uC802_ArchosManager in 'uC802_ArchosManager.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  FKeyboard in 'FKeyboard.pas' {Keyboard},
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas' {/  uTestShip in '..\ShareLib\LibTest\uTestShip.pas';},
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  C802_ArchosManager := TC802_ArchosManager.Create;

  Application.CreateForm(TKeyboard, Keyboard_Form);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  C802_ArchosManager.Initialize;
  C802_ArchosManager.BeginSimulation;

  Application.Run;
end.
