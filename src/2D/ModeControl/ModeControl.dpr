program ModeControl;

uses
  Forms,
  Classes,
  uModeControl in 'uModeControl.pas' {fMainForm},
  ufrmNetSetting in '..\ShareLib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uLogMemo in 'uLogMemo.pas' {frmLogMemo},
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  ufrmMisral in 'DirWeapon\ufrmMisral.pas' {frmMistral},
  ufrmStrella in 'DirWeapon\ufrmStrella.pas' {frmStrella},
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMainForm, fMainForm);
  Application.CreateForm(TfrmNetSetting, frmNetSetting);
  Application.CreateForm(TfrmLogMemo, frmLogMemo);
  fMainForm.TcpClient.setLog(TStringList(frmLogMemo.mmoLogMemo.Lines));
  Application.Run;
  fMainForm.TcpClient.setLog(nil);
end.
