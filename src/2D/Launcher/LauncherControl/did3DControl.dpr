program did3DControl;

uses
  Forms,
  uCMControl in 'didClientServer\uCMControl.pas' {CMControl},
  uBridgeSet in '..\..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\..\ShareLib\LibSetting\uCodecBase64.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '3D - CONTROL';
  Application.Name := 'Control';
  Application.CreateForm(TCMControl, CMControl);
  Application.Run;
end.
