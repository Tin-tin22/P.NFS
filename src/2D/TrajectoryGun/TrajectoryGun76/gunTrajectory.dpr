program gunTrajectory;

uses
  Forms,
  ufGunCalc in 'ufGunCalc.pas' {Form1},
  uTmpCalc in 'uTmpCalc.pas',
  uVector3D in 'uVector3D.pas',
  uCanvasCoord in 'libDraw\uCanvasCoord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
