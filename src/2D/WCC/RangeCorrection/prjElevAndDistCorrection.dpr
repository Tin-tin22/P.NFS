program prjElevAndDistCorrection;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uCorrection in 'uCorrection.pas',
  uData in 'uData.pas',
  uConst in 'uConst.pas',
  uTCPClient in 'uTCPClient.pas',
  uConnect in 'uConnect.pas' {vConnect};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TvConnect, vConnect);
  data := TData.create;
  Application.Run;
end.
