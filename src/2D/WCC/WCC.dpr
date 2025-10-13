program WCC;



uses
  Forms,
  Controls,
  Classes,
  MSThreadTimer in '..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uQScheduler2 in '..\ShareLib\LibBaseSystem\Timer\uQScheduler2.pas',
  uVirtualTime in '..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uBaseSimulationObject in '..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uBaseSensor in '..\ShareLib\LibSensor\uBaseSensor.pas',
  uBaseSensorView in '..\ShareLib\LibSensor\uBaseSensorView.pas',
  uLibRadarComp in '..\ShareLib\LibSensor\uLibRadarComp.pas',
  uLibRadar in '..\ShareLib\LibSensor\uLibRadar.pas',
  uLibRadarView in '..\ShareLib\LibSensor\uLibRadarView.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uWCCmanager in 'uWCCmanager.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uTorpedoTrack in '..\ShareLib\LibObject\uTorpedoTrack.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas',
  vmSDK26 in '..\ShareLib\libADLAS\vmSDK26.pas',
  uMapTools in '..\ShareLib\AppForms\uMapTools.pas' {frmMapTools},
  ufrmNetSetting in '..\ShareLib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uMainFormWCC in 'AppForms\uMainFormWCC.pas' {fMainWCC},
  uMapWindow in '..\ShareLib\AppForms\uMapWindow.pas' {frmMapWindow},
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uLabelDisplay in '..\ShareLib\libDisplay\uLabelDisplay.pas',
  uLibWCC_Nala in 'LibWCC\uLibWCC_Nala.pas',
  ufWCCPanelAtas in 'WCCForms\NALA-PIT\ufWCCPanelAtas.pas' {frmWCCPanelAtas},
  ufWCCPanelBawah in 'WCCForms\NALA-PIT\ufWCCPanelBawah.pas' {frmWCCPanelBawah},
  Windows,
  uLibWCCku in 'LibWCC\uLibWCCku.pas',
  ufQEK in 'WCCForms\COMMON-PIT\ufQEK.pas' {frmQEK},
  ufWCCPanelAtas2 in 'WCCForms\NALA-PIT\ufWCCPanelAtas2.pas' {frmWCCPanelAtas2},
  ufWCCPanelBawah2 in 'WCCForms\NALA-PIT\ufWCCPanelBawah2.pas' {frmWCCPanelBawah2},
  ufAScope in 'WCCForms\NALA-PIT\ufAScope.pas' {frmAScope},
  uPubProc in 'LibWCC\uPubProc.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uLibTDCClass in '..\ShareLib\LibTDC_WCC\uLibTDCClass.pas',
  uLibWCCClassNew in 'LibWCC\uLibWCCClassNew.pas',
  ufBScope in 'WCCForms\NALA-PIT\ufBScope.pas' {frmBScope},
  uBaseGraphicObjects in '..\ShareLib\libGrafik\uBaseGraphicObjects.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uLibWCC_Rencong in 'LibWCC\uLibWCC_Rencong.pas',
  uLibWCC_Singa in 'LibWCC\uLibWCC_Singa.pas',
  ufAtas2_Singa in 'WCCForms\SINGA-PIT\ufAtas2_Singa.pas' {frmAtas2_Singa},
  ufAtas_Singa in 'WCCForms\SINGA-PIT\ufAtas_Singa.pas' {frmAtas_Singa},
  ufBawah2_Singa in 'WCCForms\SINGA-PIT\ufBawah2_Singa.pas' {frmBawah2_Singa},
  ufBawah_Singa in 'WCCForms\SINGA-PIT\ufBawah_Singa.pas' {frmBawah_Singa},
  ufWCCTengah in 'WCCForms\COMMON-PIT\ufWCCTengah.pas' {frmWCCTengah},
  ufAtas_Rencong in 'WCCForms\RENCONG-PIT\ufAtas_Rencong.pas' {frmAtas_Rencong},
  ufAtas2_Rencong in 'WCCForms\RENCONG-PIT\ufAtas2_Rencong.pas' {frmAtas2_Rencong},
  ufBawah2_Rencong in 'WCCForms\RENCONG-PIT\ufBawah2_Rencong.pas' {frmBawah2_Rencong},
  ufBawah_Rencong in 'WCCForms\RENCONG-PIT\ufBawah_Rencong.pas' {frmBawah_Rencong},
  uMapXFunction in '..\ShareLib\LibBaseSystem\uMapXFunction.pas',
  uAScopeDisplay in '..\ShareLib\libDisplay\uAScopeDisplay.pas',
  uBScopeBaseDisplay in '..\ShareLib\libDisplay\uBScopeBaseDisplay.pas',
  uSpecialForm in 'AppForms\uSpecialForm.pas' {frmDeveloper},
  uTorpedoView in '..\ShareLib\LibObject\uTorpedoView.pas',
  ufLog in 'AppForms\ufLog.pas' {frmLog},
  uSplash in 'AppForms\uSplash.pas' {frmSplash},
  uLibTDC_Object in '..\ShareLib\LibTDC_WCC\uLibTDC_Object.pas',
  uCorrection in 'RangeCorrection\uCorrection.pas',
  uData in 'RangeCorrection\uData.pas',
  ufKoreksi in 'RangeCorrection\ufKoreksi.pas' {FrmKoreksi},
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uLibEmulatorSetting in '..\ShareLib\LibSetting\uLibEmulatorSetting.pas',
  uLibSettings in '..\ShareLib\LibSetting\uLibSettings.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCompassDisplay in '..\ShareLib\libDisplay\uCompassDisplay.pas',
  uDataTypes in '..\ShareLib\LibObject\uDataTypes.pas',
  uStringFunc in '..\ShareLib\LibObject\uStringFunc.pas',
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas',
  ufrmBckGround in 'WCCForms\COMMON-PIT\ufrmBckGround.pas' {frmBackground},
  uAnduNala in 'WCCForms\NALA-PIT\uAnduNala.pas' {frmAndu},
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uGraphics in '..\ShareLib\libGrafik\uGraphics.pas';

{$R *.res}
{$DEFINE tdcshowplash}

{$IFDEF tdcshowplash}

//var splash : TfrmSplash;

{$ENDIF}

begin
 Application.Initialize;

{$IFDEF tdcshowplash}

  {splash := TfrmSplash.Create(Application);
  splash.FormStyle := fsStayOnTop;

  splash.AlphaBlend := True;
  splash.AlphaBlendValue := 0;
  splash.Show;
  splash.Update;

  while(splash.AlphaBlendValue <> 255) do begin
    splash.AlphaBlendValue := splash.AlphaBlendValue + 5;
    Application.ProcessMessages;
  end;   }
{$ENDIF}

  Application.CreateForm(TfMainWCC, fMainWCC);
  Application.CreateForm(TfrmMapTools, frmMapTools);
  Application.CreateForm(TfrmNetSetting, frmNetSetting);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmLog, frmLog);
  Application.CreateForm(TfrmSplash, frmSplash);
  //  Application.CreateForm(TfrmAndu, frmAndu);
  //  Application.CreateForm(TfrmBackground, frmBackground);
  uWCCManager.BeginSimulation;
  uSimulationManager.SimCenter.LogMemo := fMainWCC.mmLogs.Lines;
  uSimulationManager.SimCenter.InitializeSimulation;

  uMapTools.frmMapTools.Map         := uSimulationManager.SimCenter.FMap;
  uSimulationManager.SimCenter.NetComm.setLog(TStringList(fMainWCC.mmLogs.Lines));
  uSimulationManager.SimCenter.Running := TRUE;

{$IFDEF tdcshowplash}
  {while(splash.AlphaBlendValue > 0) do  begin
    splash.AlphaBlendValue := splash.AlphaBlendValue - 5;
    Application.ProcessMessages;

  end;
  splash.Free; }
{$ENDIF}

  Application.Run;

  //Destroy sim Center
  uSimulationManager.SimCenter.FinalizeSimulation;
  uWCCManager.EndSimulation;  //Free sim Center          //203.130.246.70 554
end.
