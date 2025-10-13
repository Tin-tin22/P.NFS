program Yakhont_A_2;

uses
  Forms,
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uYakhont_A_2_Manager in 'uYakhont_A_2_Manager.pas',
  uYakhont_A_2_MainForm in 'uYakhont_A_2_MainForm.pas' {frmYakh_A_2_MainForm},
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Yakhont_A_2_Manager := TYakhont_A_2_Manager.Create;
  Yakhont_A_2_Manager.Initialize;
  Yakhont_A_2_Manager.BeginSimulation;

  Application.CreateForm(TfrmYakh_A_2_MainForm, frmYakh_A_2_MainForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  Application.Run;
end.
