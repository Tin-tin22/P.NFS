program did3DClient;

uses
  Forms,
  uClient3D in 'client\uClient3D.pas' {frmMain},
  uQuery in 'client\uQuery.pas',
  uXMLScen in 'client\uXMLScen.pas',
  uDataModule in '..\..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uTCPClient in '..\..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\..\ShareLib\LibNetworks\uTCPDatatype.pas',
  DosCommand in 'component\DosCommand.pas',
  uBridgeSet in '..\..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\..\ShareLib\LibSetting\uCodecBase64.pas',
  uBaseDataType in '..\..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uClassDatabase in '..\..\ShareLib\AppForms\uClassDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CLIENT 3D';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
