program TDC_Asroc;



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
  vmSDK26 in '..\ShareLib\libADLAS\vmSDK26.pas',
  uMapXSim in '..\ShareLib\LibObject\uMapXSim.pas',
  uMapXFunction in '..\ShareLib\LibBaseSystem\uMapXFunction.pas',
  uMover in '..\ShareLib\LibObject\uMover.pas',
  uBaseSensor in '..\ShareLib\LibSensor\uBaseSensor.pas',
  uBaseSensorView in '..\ShareLib\LibSensor\uBaseSensorView.pas',
  uLibRadarComp in '..\ShareLib\LibSensor\uLibRadarComp.pas',
  uLibRadar in '..\ShareLib\LibSensor\uLibRadar.pas',
  uLibRadarView in '..\ShareLib\LibSensor\uLibRadarView.pas',
  uBaseGraphicProc in '..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uTrackFunction in '..\ShareLib\LibSensor\uTrackFunction.pas',
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uTorpedoTrack in '..\ShareLib\LibObject\uTorpedoTrack.pas',
  uTorpedoView in '..\ShareLib\LibObject\uTorpedoView.pas',
  uLibTDCTracks in '..\ShareLib\LibSensor\uLibTDCTracks.pas',
  uTDCConstan in '..\ShareLib\LibTDC_WCC\uTDCConstan.pas',
  uLibTDCClass in '..\ShareLib\LibTDC_WCC\uLibTDCClass.pas',
  uLibTDC_Nala in 'LibTDC\uLibTDC_Nala.pas',
  uLibTDC_Oswald in 'LibTDC\uLibTDC_Oswald.pas',
  uLibTDC_Rencong in 'LibTDC\uLibTDC_Rencong.pas',
  uLibTDC_Singa in 'LibTDC\uLibTDC_Singa.pas',
  uLibRadar_WM28 in 'LibSensor\uLibRadar_WM28.pas',
  uLibRadar_DA05 in 'LibSensor\uLibRadar_DA05.pas',
  uCompassDisplay in '..\ShareLib\libDisplay\uCompassDisplay.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uLabelDisplay in '..\ShareLib\libDisplay\uLabelDisplay.pas',
  uLibTDCDisplay in '..\ShareLib\LibTDC_WCC\uLibTDCDisplay.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  ufrmNetSetting in '..\ShareLib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uMapTools in '..\ShareLib\AppForms\uMapTools.pas' {frmMapTools},
  uMapWindow in '..\ShareLib\AppForms\uMapWindow.pas' {frmMapWindow},
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uLibSettings in '..\ShareLib\LibSetting\uLibSettings.pas',
  uLibEmulatorSetting in '..\ShareLib\LibSetting\uLibEmulatorSetting.pas',
  uLibTDC_Object in '..\ShareLib\LibTDC_WCC\uLibTDC_Object.pas',
  uTDCmanager in 'LibTDC\uTDCmanager.pas',
  ufTDCTengah in 'LibTDC\Common-PIT\ufTDCTengah.pas' {frmTDCTengah},
  ufTDC1Kanan in 'LibTDC\Nala-PIT\ufTDC1Kanan.pas' {frmTDC1Kanan},
  ufTDC1Kiri in 'LibTDC\Nala-PIT\ufTDC1Kiri.pas' {frmTDC1Kiri},
  ufTDC2Kanan in 'LibTDC\Nala-PIT\ufTDC2Kanan.pas' {frmTDC2Kanan},
  ufTDC2Kiri in 'LibTDC\Nala-PIT\ufTDC2Kiri.pas' {frmTDC2Kiri},
  ufTDCTengah_Singa in 'LibTDC\Singa-PIT\ufTDCTengah_Singa.pas' {frmTDCTengah_Singa},
  ufTDCkanan_Singa in 'LibTDC\Singa-PIT\ufTDCkanan_Singa.pas' {fTDCKanan_Singa},
  ufTdcPc in 'LibTDC\Singa-PIT\ufTdcPc.pas' {frmTdcPc},
  ufTdcPwo in 'LibTDC\Singa-PIT\ufTdcPwo.pas' {frmTdcPwo},
  ufTdcTengahBawah in 'LibTDC\Singa-PIT\ufTdcTengahBawah.pas' {frmTdcTengahBawah},
  ufTDCKanan_Rencong in 'LibTDC\RENCONG\ufTDCKanan_Rencong.pas' {frmTDCKanan_Rencong},
  ufTDCKiri_Rencong in 'LibTDC\RENCONG\ufTDCKiri_Rencong.pas' {frmTDCKiri_Rencong},
  ufTDCTengah_Rencong in 'LibTDC\RENCONG\ufTDCTengah_Rencong.pas' {frmTDCTengah_Rencong},
  uMainFormTDC in 'AppForms\uMainFormTDC.pas' {fMainTDC},
  uTDCSplash in 'AppForms\uTDCSplash.pas' {frmSplash},
  uSpecialForm in 'AppForms\uSpecialForm.pas' {frmDeveloper},
  ufLog in 'AppForms\ufLog.pas' {frmLog},
  ufTDCTengah_Nala in 'LibTDC\Nala-PIT\ufTDCTengah_Nala.pas' {frmTDCTengahNala},
  ufQEK in 'LibTDC\Common-PIT\ufQEK.pas' {frmQEK},
  ufTDCkiri_Singa in 'LibTDC\Singa-PIT\ufTDCkiri_Singa.pas' {fTDCKiri_singa},
  ufTDCTengah_OWA in 'LibTDC\owa\ufTDCTengah_OWA.pas' {frmTDCTengah_OWA},
  ufTDCTengahBawah_OWA in 'LibTDC\owa\ufTDCTengahBawah_OWA.pas' {frmTengahBawah_OWA},
  ufOwa_7 in 'LibTDC\owa\ufOwa_7.pas' {frmOwa_7},
  ufOwa_8 in 'LibTDC\owa\ufOwa_8.pas' {frmOwa_8},
  ufOwa_2 in 'LibTDC\owa\ufOwa_2.pas' {frmOwa_2},
  ufOwa_4 in 'LibTDC\owa\ufOwa_4.pas' {frmOwa_4},
  ufOwa_6 in 'LibTDC\owa\ufOwa_6.pas' {frmOwa_6},
  ufOwa_5 in 'LibTDC\owa\ufOwa_5.pas' {frmOwa_5},
  ufOwa_1 in 'LibTDC\owa\ufOwa_1.pas' {frmOwa_1},
  ufOwa_3 in 'LibTDC\owa\ufOwa_3.pas' {frmOwa_3},
  ufMIK in 'LibTDC\Common-PIT\ufMIK.pas' {fMIK},
  ufANDUDisplay in 'LibTDC\Common-PIT\ufANDUDisplay.pas' {frmANDUDisplay},
  ufANDUKeyboard in 'LibTDC\Common-PIT\ufANDUKeyboard.pas' {frmANDUKey},
  ufMIK_Singa in 'LibTDC\Singa-PIT\ufMIK_Singa.pas' {frmMIK_Singa},
  DA05 in 'ExtPanel\DA05.pas' {Frm_DA05},
  RCR_radar_LW03 in 'ExtPanel\RCR_radar_LW03.pas' {Frm_RCR_radar_LW03},
  ufKeyBoard in 'LibTDC\Common-PIT\ufKeyBoard.pas' {frmKeyBoard},
  ufMIK_Owa in 'LibTDC\owa\ufMIK_Owa.pas' {frmMIK_Owa},
  ufDisplay_Nala in 'LibTDC\Nala-PIT\ufDisplay_Nala.pas' {frmDisplay_NALA},
  ufDisplay_OWA in 'LibTDC\owa\ufDisplay_OWA.pas' {frmDisplay_Owa},
  ufTorpedoOwa in 'LibTDC\owa\ufTorpedoOwa.pas' {frmTorpOWA},
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas',
  ASRLRCU in 'LibTDC\Nala-PIT\ASRLRCU.pas' {frmASRL},
  ufrmBckGround in 'LibTDC\Common-PIT\ufrmBckGround.pas' {frmBackground},
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uGraphics in '..\ShareLib\libGrafik\uGraphics.pas';

{$R *.res}

// {$DEFINE tdcshowplash}

{$IFDEF tdcshowplash}

var
  splash : TfrmSplash;
{$ENDIF}

begin
  Application.Initialize;

{$IFDEF tdcshowplash}

  splash := TfrmSplash.Create(Application);
  splash.FormStyle := fsStayOnTop;

  splash.AlphaBlend := True;
  splash.AlphaBlendValue := 0;
  splash.Show;
  splash.Update;

  while(splash.AlphaBlendValue <> 255) do begin
    splash.AlphaBlendValue := splash.AlphaBlendValue + 5;
    Application.ProcessMessages;
  end;
{$ENDIF}

  Application.CreateForm(TfMainTDC, fMainTDC);
  Application.CreateForm(TfrmDeveloper, frmDeveloper);
  //  Application.CreateForm(TfrmASRL, frmASRL);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  Application.CreateForm(TfrmNetSetting, frmNetSetting);
  Application.CreateForm(TfrmMapTools, frmMapTools);
  Application.CreateForm(TfrmMapWindow, frmMapWindow);
  {$IFNDEF tdcshowplash}
  Application.CreateForm(TfrmLog, frmLog);
{$ENDIF}

//  Application.CreateForm(TfrmMIK_Singa, frmMIK_Singa);
  uTDCManager.BeginSimulation;
  uSimulationManager.SimCenter.NetComm.setLog(TStringList(fMainTDC.mmLogs.Lines));
  uSimulationManager.SimCenter.LogMemo := fMainTDC.mmLogs.Lines;

  uSimulationManager.SimCenter.InitializeSimulation;

  uMapTools.frmMapTools.Map         := uSimulationManager.SimCenter.FMap;
  uSimulationManager.SimCenter.Running := TRUE;
  fMainTDC.Left := -2000;
{$IFDEF tdcshowplash}
  while(splash.AlphaBlendValue > 0) do  begin
    splash.AlphaBlendValue := splash.AlphaBlendValue - 5;
    Application.ProcessMessages;
  end;
  splash.Free;
{$ENDIF}
  Application.Run;
  //Destroy sim Center
  uSimulationManager.SimCenter.FinalizeSimulation;
  uTDCManager.EndSimulation;  //Free sim Center          //203.130.246.70 554

end.

