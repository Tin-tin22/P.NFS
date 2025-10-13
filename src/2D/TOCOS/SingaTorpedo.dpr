program SingaTorpedo;



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
  uClientShip in '..\ShareLib\LibClientObject\uClientShip.pas',
  uLibClientObject in '..\ShareLib\LibClientObject\uLibClientObject.pas',
  uSimulationManager in '..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  uTestShip in '..\ShareLib\LibTest\uTestShip.pas',
  uObjectView in '..\ShareLib\LibObject\uObjectView.pas',
  uDetected in '..\ShareLib\LibSensor\uDetected.pas',
  uMapTools in '..\ShareLib\AppForms\uMapTools.pas' {frmMapTools},
  ufrmNetSetting in '..\ShareLib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uRadarTracks in '..\ShareLib\LibObject\uRadarTracks.pas',
  uStringFunction in '..\ShareLib\LibBaseSystem\uStringFunction.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uMapWindow in '..\ShareLib\AppForms\uMapWindow.pas' {frmMapWindow},
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uLabelDisplay in '..\ShareLib\libDisplay\uLabelDisplay.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uMapXFunction in '..\ShareLib\LibBaseSystem\uMapXFunction.pas',
  uCompassDisplay in '..\ShareLib\libDisplay\uCompassDisplay.pas',
  uTDCSplash in 'AppForms\uTDCSplash.pas' {frmSplash},
  uSpecialForm in 'AppForms\uSpecialForm.pas' {frmDeveloper},
  ufLog in 'AppForms\ufLog.pas' {frmLog},
  RCR_radar_LW03 in 'LW03\RCR_radar_LW03.pas' {Frm_RCR_radar_LW03},
  DA05 in 'ExtPanel\DA05.pas' {Frm_DA05},
  ufTDCTengah in 'LibTOCOS\Common-PIT\ufTDCTengah.pas' {frmTDCTengah},
  uLibTDC_Nala in 'LibTOCOS\uLibTDC_Nala.pas',
  uLibTDC_Oswald in 'LibTOCOS\uLibTDC_Oswald.pas',
  uLibTDC_Rencong in 'LibTOCOS\uLibTDC_Rencong.pas',
  uLibTDC_Singa in 'LibTOCOS\uLibTDC_Singa.pas',
  ufInjectionKeyboard in 'LibTOCOS\Nala-PIT\ufInjectionKeyboard.pas' {frmInjectionKeyBoard},
  ufTDC1Kanan in 'LibTOCOS\Nala-PIT\ufTDC1Kanan.pas' {frmTDC1Kanan},
  ufTDC1Kiri in 'LibTOCOS\Nala-PIT\ufTDC1Kiri.pas' {frmTDC1Kiri},
  ufTDC2Kanan in 'LibTOCOS\Nala-PIT\ufTDC2Kanan.pas' {frmTDC2Kanan},
  ufTDC2Kiri in 'LibTOCOS\Nala-PIT\ufTDC2Kiri.pas' {frmTDC2Kiri},
  ufTDCTengah_Singa in 'LibTOCOS\Singa-PIT\ufTDCTengah_Singa.pas' {frmTDCTengah_Singa},
  ufTdcKeyboard in 'LibTOCOS\Singa-PIT\ufTdcKeyboard.pas' {frmTdcKeyboard},
  ufTdcOrange in 'LibTOCOS\Singa-PIT\ufTdcOrange.pas' {frmTDCQEKSinga},
  ufTdcPc in 'LibTOCOS\Singa-PIT\ufTdcPc.pas' {frmTdcPc},
  ufTdcPwo in 'LibTOCOS\Singa-PIT\ufTdcPwo.pas' {frmTdcPwo},
  ufTdcTengahBawah in 'LibTOCOS\Singa-PIT\ufTdcTengahBawah.pas' {frmTdcTengahBawah},
  ufTDCKanan_Rencong in 'LibTOCOS\RENCONG\ufTDCKanan_Rencong.pas' {frmTDCKanan_Rencong},
  ufTDCKiri_Rencong in 'LibTOCOS\RENCONG\ufTDCKiri_Rencong.pas' {frmTDCKiri_Rencong},
  ufTDCTengah_Rencong in 'LibTOCOS\RENCONG\ufTDCTengah_Rencong.pas' {frmTDCTengah_Rencong},
  ufTDCTengah_Nala in 'LibTOCOS\Nala-PIT\ufTDCTengah_Nala.pas' {frmTDCTengahNala},
  ufQEK in 'LibTOCOS\Common-PIT\ufQEK.pas' {frmQEK},
  uDisplaySinga in 'LibTOCOS\Singa_torpedo\uDisplaySinga.pas' {frmLPDTorpedo},
  uLibTorpedo_Singa in 'LibTOCOS\uLibTorpedo_Singa.pas',
  uDisplayCtrlPanelLeft in 'LibTOCOS\Singa_torpedo\uDisplayCtrlPanelLeft.pas' {vDisplayCtrlPanelLeft},
  uMainCtrlPanel in 'LibTOCOS\Singa_torpedo\uMainCtrlPanel.pas' {vMainCtrlPanel},
  uTechnicalCtrlPanel in 'LibTOCOS\Singa_torpedo\uTechnicalCtrlPanel.pas' {vTechnicalCtrlPanel},
  uDisplayCtrlPanelBottom in 'LibTOCOS\Singa_torpedo\uDisplayCtrlPanelBottom.pas' {vDisplayCtrlPanelBottom},
  ufMIK in 'LibTOCOS\Common-PIT\ufMIK.pas',
  ufKeyBoard in 'LibTOCOS\Common-PIT\ufKeyBoard.pas' {frmKeyBoard},
  ufANDUKeyboard in 'LibTOCOS\Common-PIT\ufANDUKeyboard.pas' {frmANDUKey},
  ufANDUDisplay in 'LibTOCOS\Common-PIT\ufANDUDisplay.pas' {frmANDUDisplay},
  ufANDU in 'LibTOCOS\Common-PIT\ufANDU.pas' {frmQEK1},
  ufDisplay_Nala in 'LibTOCOS\Nala-PIT\ufDisplay_Nala.pas' {frmDisplay_NALA},
  ufOwa_8 in 'LibTOCOS\owa\ufOwa_8.pas' {frmOwa_8},
  ufMIK_Owa in 'LibTOCOS\owa\ufMIK_Owa.pas' {frmMIK_Owa},
  ufOwa_1 in 'LibTOCOS\owa\ufOwa_1.pas' {frmOwa_1},
  ufOwa_2 in 'LibTOCOS\owa\ufOwa_2.pas' {frmOwa_2},
  ufOwa_3 in 'LibTOCOS\owa\ufOwa_3.pas' {frmOwa_3},
  ufOwa_4 in 'LibTOCOS\owa\ufOwa_4.pas' {frmOwa_4},
  ufOwa_5 in 'LibTOCOS\owa\ufOwa_5.pas' {frmOwa_5},
  ufOwa_6 in 'LibTOCOS\owa\ufOwa_6.pas' {frmOwa_6},
  ufOwa_7 in 'LibTOCOS\owa\ufOwa_7.pas' {frmOwa_7},
  ufMIK_Singa in 'LibTOCOS\Singa-PIT\ufMIK_Singa.pas' {frmMIK_Singa},
  uAnduProc in 'LibTOCOS\Singa_torpedo\uAnduProc.pas',
  uTOCOSManager in 'LibTOCOS\Singa_torpedo\uTOCOSManager.pas',
  uLibRadar_WM28 in 'LibSensor\uLibRadar_WM28.pas',
  uLibRadar_DA05 in 'LibSensor\uLibRadar_DA05.pas',
  uLibTDCTrack in 'LibSensor\uLibTDCTrack.pas',
  uLibTDCTracks in 'LibSensor\uLibTDCTracks.pas',
  uTrackFunction in 'LibSensor\uTrackFunction.pas',
  uTorpedoTrack in 'LibObject\uTorpedoTrack.pas',
  uTorpedoView in 'LibObject\uTorpedoView.pas',
  uTDCmanager in 'uTDCmanager.pas',
  uMainFormTorpedo in 'uMainFormTorpedo.pas' {fMainTorpedo},
  ufDisplay_OWA in 'LibTOCOS\owa\ufDisplay_OWA.pas' {frmDisplay_Owa},
  ufTDCTengah_OWA in 'LibTOCOS\owa\ufTDCTengah_OWA.pas' {frmTDCTengah_OWA},
  ufTDCTengahBawah_OWA in 'LibTOCOS\owa\ufTDCTengahBawah_OWA.pas' {frmTengahBawah_OWA},
  ufTDCkanan_Singa in 'LibTOCOS\Singa-PIT\ufTDCkanan_Singa.pas' {fTDCKanan_Singa},
  ufTDCkiri_Singa in 'LibTOCOS\Singa-PIT\ufTDCkiri_Singa.pas' {fTDCKiri_singa},
  uLibTDC_Object in 'LibTOCOS_WCC\uLibTDC_Object.pas',
  uLibTDCClass in 'LibTOCOS_WCC\uLibTDCClass.pas',
  uLibTDCDisplay in 'LibTOCOS_WCC\uLibTDCDisplay.pas',
  uTDCConstan in 'LibTOCOS_WCC\uTDCConstan.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas',
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

  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfMainTorpedo, fMainTorpedo);
  Application.CreateForm(TfrmMapTools, frmMapTools);
  Application.CreateForm(TfrmNetSetting, frmNetSetting);
  Application.CreateForm(TfrmDeveloper, frmDeveloper);
  Application.CreateForm(TfrmDisplay_Owa, frmDisplay_Owa);
  //Application.CreateForm(TfrmLog, frmLog);
  //Application.CreateForm(TvConnect, vConnect);
  Application.CreateForm(TfrmKeyBoard, frmKeyBoard);
  Application.CreateForm(TfrmQEK1, frmQEK1);
  Application.CreateForm(TfrmDisplay_Owa, frmDisplay_Owa);
  Application.CreateForm(TfrmOwa_2, frmOwa_2);
  Application.CreateForm(TfrmOwa_3, frmOwa_3);
  Application.CreateForm(TfrmOwa_5, frmOwa_5);
  Application.CreateForm(TfrmOwa_6, frmOwa_6);
  Application.CreateForm(TFrm_RCR_radar_LW03, Frm_RCR_radar_LW03);
  Application.CreateForm(TfrmMIK_Singa, frmMIK_Singa);
  uTOCOSManager.BeginSimulation;
  uSimulationManager.SimCenter.NetComm.setLog(TStringList(fMainTorpedo.mmLogs.Lines));
  uSimulationManager.SimCenter.LogMemo := fMainTorpedo.mmLogs.Lines;



  uSimulationManager.SimCenter.InitializeSimulation;

  uMapTools.frmMapTools.Map         := uSimulationManager.SimCenter.FMap;
  uSimulationManager.SimCenter.Running := TRUE;

{$IFDEF tdcshowplash}
  while(splash.AlphaBlendValue > 0) do  begin
    splash.AlphaBlendValue := splash.AlphaBlendValue - 5;
    Application.ProcessMessages;

  end;
  splash.Free;
{$ENDIF}


  Application.Run;

  //Destroy sim Center
  uSimulationManager.SimCenter.EndSimulation;
  uSimulationManager.SimCenter.FinalizeSimulation;
  uTOCOSManager.EndSimulation;  //Free sim Center          //203.130.246.70 554

end.

