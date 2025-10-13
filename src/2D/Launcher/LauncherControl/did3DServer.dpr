program did3DServer;

uses
  Forms,
  uCMServer in 'didClientServer\uCMServer.pas' {frmCMServer},
  uDM in 'didCommon\uDM.pas' {DM: TDataModule},
  uQuery in 'didCommon\uQuery.pas',
  uCMMain in 'didClientServer\uCMMain.pas' {frmMain},
  uBaseConstant in 'didClientServer\uBaseConstant.pas',
  uCMSetting in 'didClientServer\uCMSetting.pas' {frmCMSetting},
  uTCPServer in '..\..\ShareLib\LibNetworks\uTCPServer.pas',
  uTCPDatatype in '..\..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uDataModule in '..\..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uBridgeSet in '..\..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\..\ShareLib\LibSetting\uCodecBase64.pas',
  uLibEmulatorSetting in '..\..\ShareLib\LibSetting\uLibEmulatorSetting.pas',
  uLibSettings in '..\..\ShareLib\LibSetting\uLibSettings.pas',
  uLibInstrukturSetting in '..\..\ShareLib\LibSetting\uLibInstrukturSetting.pas',
  uBaseDataType in '..\..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uClassDatabase in '..\..\ShareLib\AppForms\uClassDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GAME SERVER';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCMServer, frmCMServer);
  Application.CreateForm(TfrmCMSetting, frmCMSetting);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

