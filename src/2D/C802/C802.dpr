program C802;

uses
  Forms,
  uC802Manager in 'uC802Manager.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  fPanelBawah in 'fPanelBawah.pas' {PanelBawah},
  fPanelAtas in 'fPanelAtas.pas' {PanelAtas},
  uC802_Object in 'uC802_Object.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uEventForm in 'uEventForm.pas',
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas' {/  ufTCPLog in 'ufTCPLog.pas' {fTCPLog},
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas' {$R *.res},
  FKeyboard in 'FKeyboard.pas' {Keyboard},
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;


  Application.CreateForm(TPanelAtas, PanelAtas);
  Application.CreateForm(TPanelBawah, PanelBawah);
  Application.CreateForm(TKeyboard, Keyboard_Form);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  Application.CreateForm(TDataModule1, DataModule1);
  //  Application.CreateForm(TfTCPLog, fTCPLog);
    C802Manager.Initialize;

//  if not C802Manager.StandAloneMode then
  C802Manager.BeginSimulation;

//  C802Manager.NetComm.setLog(TStringList(fTCPLog.mmolog.Lines));
//  fTCPLog.Show;
  Application.Run;
end.
