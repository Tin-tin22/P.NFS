program Yakhont;

uses
  Windows,
  Forms,
  Classes,
  uYakhontManager in 'uYakhontManager.pas',
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uRegimesOfWork in 'uRegimesOfWork.pas' {fmMain},
  uSelectionTI in 'uSelectionTI.pas' {frmSelectionTI},
  uCertificateData in 'uCertificateData.pas' {frmCertificateData},
  uCRData in 'uCRData.pas' {frmCRData},
  uEventForm in 'uEventForm.pas',
  uMainMM in 'uMainMM.pas' {fmMainMM},
  uManageLoadDraw in 'uManageLoadDraw.pas',
  uManualInput in 'uManualInput.pas' {frmManualInput},
  uYakhont_A_1_MainForm in 'uYakhont_A_1_MainForm.pas' {frmYakh_A_1_MainForm},
  uYakhont_A_2_MainForm in 'uYakhont_A_2_MainForm.pas' {frmYakh_A_2_MainForm},
  uYakhont_Object in 'uYakhont_Object.pas',
  uTargetDestination in 'uTargetDestination.pas' {frmTargetDest},
  uCirculationASM in 'uCirculationASM.pas' {frmCirculationASM},
  uLogTCP in 'uLogTCP.pas' {frmLogTCP},
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uLock in 'uLock.pas' {frmLock},
  uLoadingScreen in 'uLoadingScreen.pas' {frmLoadingScreen},
  uEmergencyRelease in 'uEmergencyRelease.pas' {frmEmergencyRelease},
  uBlankScreen in 'uBlankScreen.pas' {frmBlankScreen},
  uAppointmentASM in 'uAppointmentASM.pas' {frmAppointmentASM},
  uTest in 'uTest.pas' {frmTest},
  uDoc in 'uDoc.pas' {frmDoc},
  uHeating in 'uHeating.pas' {frmHeating},
  uAcknowledgement in 'uAcknowledgement.pas' {frmAcknowledgement},
  uNetral in 'uNetral.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uYakhont_B_MainForm in 'uYakhont_B_MainForm.pas' {frmYakh_B_MainForm},
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := True;

  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmYakh_A_1_MainForm, frmYakh_A_1_MainForm);
  Application.CreateForm(TfrmYakh_A_2_MainForm, frmYakh_A_2_MainForm);
  Application.CreateForm(TfrmLoadingScreen, frmLoadingScreen);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmMainMM, fmMainMM);
  Application.CreateForm(TfrmSelectionTI, frmSelectionTI);
  Application.CreateForm(TfrmCertificateData, frmCertificateData);
  Application.CreateForm(TfrmCRData, frmCRData);
  Application.CreateForm(TfrmManualInput, frmManualInput);
  Application.CreateForm(TfrmTargetDest, frmTargetDest);
  Application.CreateForm(TfrmCirculationASM, frmCirculationASM);
  Application.CreateForm(TfrmLogTCP, frmLogTCP);
  Application.CreateForm(TfrmLock, frmLock);
  Application.CreateForm(TfrmEmergencyRelease, frmEmergencyRelease);
  Application.CreateForm(TfrmBlankScreen, frmBlankScreen);
  Application.CreateForm(TfrmAppointmentASM, frmAppointmentASM);
  Application.CreateForm(TfrmTest, frmTest);
  Application.CreateForm(TfrmDoc, frmDoc);
  Application.CreateForm(TfrmHeating, frmHeating);
  Application.CreateForm(TfrmAcknowledgement, frmAcknowledgement);
//  Application.CreateForm(TfrmYakh_B_MainForm, frmYakh_B_MainForm);
  //...
  ShowWindow(Application.MainForm.Handle, SW_SHOW);

  YakhontManager := TYakhontManager.Create;

  yakhontManager.Initialize;
//  if not YakhontManager.StandAloneMode then
    YakhontManager.BeginSimulation;

  YakhontManager.NetComm.setLog(TStringList(frmLogTCP.mmoLogTCP.Lines));

  Application.Run;
end.
