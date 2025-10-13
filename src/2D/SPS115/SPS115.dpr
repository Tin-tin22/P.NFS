program SPS115;

uses
  Forms,
  Classes,
  uSPS115 in 'uSPS115.pas' {Frm_Main},
  Unit_Interface in 'Lib\Unit_Interface.pas',
  Unit_FillValue in 'Lib\Unit_FillValue.pas',
  Unit_dataObject in 'Lib\Unit_dataObject.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  ufrmNetSetting in '..\ShareLib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uDataModule in '..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uDataTypes in '..\ShareLib\LibObject\uDataTypes.pas',
  uStringFunc in '..\ShareLib\LibObject\uStringFunc.pas',
  uBaseCoordSystem in '..\ShareLib\LibObject\uBaseCoordSystem.pas',
  uLogMemo in 'uLogMemo.pas' {frmLogMemo},
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.CreateForm(TfrmNetSetting, frmNetSetting);
  Application.CreateForm(TfrmLogMemo, frmLogMemo);
  Frm_Main.TheClient.setLog(TStringList(frmLogMemo.mmoLogMemo.Lines));
  Application.Run;
  Frm_Main.TheClient.setLog(nil);

end.
