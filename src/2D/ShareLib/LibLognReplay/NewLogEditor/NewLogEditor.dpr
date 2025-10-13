program NewLogEditor;

uses
  Forms,
  uNewLogEdit in 'uNewLogEdit.pas' {frmReplayEditoor},
  MSThreadTimer in '..\LogReplay\MSThreadTimer.pas',
  uCommonLogReplay in '..\LogReplay\uCommonLogReplay.pas',
  uNewLog in '..\LogReplay\uNewLog.pas',
  uNewReplay in '..\LogReplay\uNewReplay.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmReplayEditoor, frmReplayEditoor);
  Application.Run;
end.
