program FiringSystemInst;

uses
  Forms,
  Classes,
  Controls,
  ufrmMainInstruktur in 'instForms\ufrmMainInstruktur.pas' {frmMainInstruktur},
  ufrmeLeftControl in 'instForms\ufrmeLeftControl.pas' {frmeControl: TFrame},
  uInstrukturManager in 'libInstruktur\uInstrukturManager.pas',
  uSimulationManager in '..\..\ShareLib\LibBaseSystem\uSimulationManager.pas',
  MSThreadTimer in '..\..\ShareLib\LibBaseSystem\Timer\MSThreadTimer.pas',
  uVirtualTime in '..\..\ShareLib\LibBaseSystem\Timer\uVirtualTime.pas',
  uBaseDataType in '..\..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseSimulationObject in '..\..\ShareLib\LibBaseSystem\uBaseSimulationObject.pas',
  uTCPClient in '..\..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\..\ShareLib\LibNetworks\uTCPServer.pas',
  uBaseConstan in '..\..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uBaseFunction in '..\..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uBaseInterleaver in '..\..\ShareLib\LibBaseSystem\uBaseInterleaver.pas',
  uMapXSim in '..\..\ShareLib\LibObject\uMapXSim.pas',
  uInstrukturObjects in 'libInstruktur\uInstrukturObjects.pas',
  uInstrukturViews in 'libInstruktur\uInstrukturViews.pas',
  uDataTypes in '..\..\ShareLib\LibObject\uDataTypes.pas',
  uStringFunc in '..\..\ShareLib\LibObject\uStringFunc.pas',
  uBaseCoordSystem in '..\..\ShareLib\LibObject\uBaseCoordSystem.pas',
  uObjectView in '..\..\ShareLib\LibObject\uObjectView.pas',
  uBaseGraphicProc in '..\..\ShareLib\libGrafik\uBaseGraphicProc.pas',
  uMovingObject in '..\..\ShareLib\LibBaseSystem\uMovingObject.pas',
  uShip in 'libInstruktur\uShip.pas',
  Logger in '..\..\ShareLib\LibObject\Logger.pas',
  uBridgeSet in '..\..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\..\ShareLib\LibSetting\uCodecBase64.pas',
  uDataModule in '..\..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uLibInstrukturSetting in '..\..\ShareLib\LibSetting\uLibInstrukturSetting.pas',
  uLibSettings in '..\..\ShareLib\LibSetting\uLibSettings.pas',
  uNewLog in '..\..\ShareLib\LibLognReplay\uNewLog.pas',
  uCommonLogReplay in '..\..\ShareLib\LibLognReplay\uCommonLogReplay.pas',
  uGlobalVar in '..\..\ShareLib\LibBaseSystem\uGlobalVar.pas',
  ufassignmissile in 'libDatabaseFs\ufassignmissile.pas' {frmAssignMisille},
  ufassignweapon in 'libDatabaseFs\ufassignweapon.pas' {frmAssignWeapon},
  ufEnvi in 'libDatabaseFs\ufEnvi.pas' {frmMoreEnvi},
  ufListScenario in 'libDatabaseFs\ufListScenario.pas' {frmListScenario},
  ufScenarioEdit in 'libDatabaseFs\ufScenarioEdit.pas' {frmSceEditor},
  ufWeaponList in 'libDatabaseFs\ufWeaponList.pas' {frmWeaponList},
  ufDBSetting in '..\..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uScriptManager in 'libInstruktur\uScriptManager.pas',
  uEventManager in 'libInstruktur\uEventManager.pas',
  ufGuidance in 'instForms\ufGuidance.pas' {fGuidance: TFrame},
  ufWeaponStatus in 'instForms\ufWeaponStatus.pas' {fWeaponStatus: TFrame},
  ufrmAddShipRuntime in 'instForms\ufrmAddShipRuntime.pas' {frmAddShipRuntime},
  uDistance in 'instForms\uDistance.pas' {frmDistance},
  uSelctionMan in 'libInstruktur\uSelctionMan.pas',
  uCustomZoom in 'instForms\uCustomZoom.pas' {frmCustomZoom},
  ufLogs in 'instForms\ufLogs.pas' {frmLogs},
  ufEventLog in 'instForms\ufEventLog.pas' {frmEventLog},
  uCMSetting in 'instForms\uCMSetting.pas' {frmCMSetting},
  uQuery in 'libInstruktur\uQuery.pas',
  uWeaponGetDetail in 'libInstruktur\uWeaponGetDetail.pas',
  uClassDatabase in '..\..\ShareLib\AppForms\uClassDatabase.pas',
  ufReportEvent in 'instForms\ufReportEvent.pas' {frmReportEvent},
  ufInstLog in 'instForms\ufInstLog.pas' {frmMainLog},
  uTrajectory in 'libInstruktur\uTrajectory.pas',
  uNewReplay in '..\..\ShareLib\LibLognReplay\uNewReplay.pas',
  uReplayControl in '..\..\ShareLib\LibLognReplay\uReplayControl.pas' {frmReplayControl},
  uSaveLog in '..\..\ShareLib\LibLognReplay\uSaveLog.pas' {frmSaveLog},
  ufRecordsList in 'instForms\ufRecordsList.pas' {frmRecordsList},
  ufrmTrajectoryView in 'instForms\ufrmTrajectoryView.pas' {frmTrjectoryView},
  uFrmLoadingScreen in 'instForms\uFrmLoadingScreen.pas' {frmLoadingScreen},
  ufrmGameController in 'instForms\ufrmGameController.pas' {frmGameController},
  GifImage in '..\..\ShareLib\LibTambahan\GifImage.pas';

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMainInstruktur, frmMainInstruktur);
  Application.CreateForm(TfrmReplayControl, frmReplayControl);
  Application.CreateForm(TfrmSaveLog, frmSaveLog);
  Application.CreateForm(TfrmRecordsList, frmRecordsList);
  Application.CreateForm(TfrmTrjectoryView, frmTrjectoryView);
  Application.CreateForm(TfrmLoadingScreen, frmLoadingScreen);
  //  Application.CreateForm(TfrmGameController, frmGameController);
  //Application.CreateForm(TfrmFiringCommand, frmFiringCommand);
  Application.CreateForm(TfrmGameController, frmGameController);
  Application.CreateForm(TfrmAssignMisille, frmAssignMisille);
  Application.CreateForm(TfrmAssignWeapon, frmAssignWeapon);
  Application.CreateForm(TfrmMoreEnvi, frmMoreEnvi);
  Application.CreateForm(TfrmListScenario, frmListScenario);
  Application.CreateForm(TfrmSceEditor, frmSceEditor);
  Application.CreateForm(TfrmWeaponList, frmWeaponList);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  Application.CreateForm(TfrmAddShipRuntime, frmAddShipRuntime);
  Application.CreateForm(TfrmDistance, frmDistance);
  Application.CreateForm(TfrmCustomZoom, frmCustomZoom);
  Application.CreateForm(TfrmLogs, frmLogs);
  Application.CreateForm(TfrmEventLog, frmEventLog);
  Application.CreateForm(TfrmCMSetting, frmCMSetting);
  Application.CreateForm(TfrmReportEvent, frmReportEvent);
  Application.CreateForm(TfrmMainLog, frmMainLog);
  { Script }
  uScriptManager.CreateSimulation;

  { Sim Manager }
  SimManager.FMap     := frmMainInstruktur.MainMap;
  SimManager.Minimap1 := frmGameController.MiniMap1;
  SimManager.initializeSimulation;

  { Ruler Distance }
  frmDistance.Map     := frmMainInstruktur.MainMap;

  { Form Main }
  frmMainInstruktur.SetFormLayout;
  frmMainInstruktur.SetFormEnvironment;

  { Form Firing Command }
  //frmFiringCommand.SetFormLayout;

  { Form Game Controller }
  frmGameController.SetFormLayout;
  frmGameController.SetFormEnvironment;
  frmGameController.CreateTrajectory;

  { Check Mode Instruktur }
  if SimManager.InsUtils.MapMode then
  begin
    frmGameController.Visible := False;
    frmMainInstruktur.FrameControlLeft.Visible  := False;
    frmMainInstruktur.pnlMainUp.Visible         := false;
    frmMainInstruktur.pnlInfo.Visible           := False;
    frmMainInstruktur.BorderStyle := bsNone;

    frmMainInstruktur.pnlMapInset.Top := frmMainInstruktur.pnlMapInset.Top +
                                         frmMainInstruktur.pnlInfo.Height;
    if SimManager.InsUtils.MapID = 0 then
      frmMainInstruktur.WindowState := wsMinimized;
  end;
  if not (SimManager.InsUtils.InsID = 2) then
  begin
    frmMainInstruktur.btnRecordStart.Enabled := false;
    frmMainInstruktur.pnlMainMenu.Width := frmMainInstruktur.btnToolTikas.Left + 70;
    frmMainInstruktur.mniTools.Visible := false;
    //frmLoadingScreen.Show;
  end;

  if SimManager.InsUtils.DenahMode = 1 then   //armabar
  begin
    frmGameController.pnlRuangIns.Visible := False;
    frmGameController.pnlRuangInsArmabar.Visible := True;
  end
  else                                   //kodikal
  begin
    frmGameController.pnlRuangIns.Visible := true;
    frmGameController.pnlRuangInsArmabar.Visible := false;
  end;

  SimManager.TCPClient.setLog(TStringList(frmMainLog.mmoLog.Lines));
  uScriptManager.StartSimulation;

  Application.Run;

  { Script }
  frmGameController.DestroyTrajectory;
  SimManager.TCPClient.setLog(nil);
  uScriptManager.EndSimulation;
end.
