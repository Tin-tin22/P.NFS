program Yakhont_B;

uses
  Forms,
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  ufDBSetting in '..\ShareLib\AppForms\ufDBSetting.pas' {frmDBSetting},
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uYakhont_B_Manager in 'uYakhont_B_Manager.pas',
  uYakhont_B_MainForm in 'uYakhont_B_MainForm.pas' {frmYakh_B_MainForm},
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Yakhont_B_Manager := TYakhont_B_Manager.Create;
  Yakhont_B_Manager.Initialize;
  Yakhont_B_Manager.BeginSimulation;

  Application.CreateForm(TfrmYakh_B_MainForm, frmYakh_B_MainForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmDBSetting, frmDBSetting);
  Application.Run;
end.
