program simpleLog;

uses
  Forms,
  uSimpleLog in 'uSimpleLog.pas' {frmLogger},
  MSThreadTimer in '..\LogReplay\MSThreadTimer.pas',
  uCommonLogReplay in '..\LogReplay\uCommonLogReplay.pas',
  uNewLog in '..\LogReplay\uNewLog.pas',
  uNewReplay in '..\LogReplay\uNewReplay.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogger, frmLogger);
  Application.Run;
end.
