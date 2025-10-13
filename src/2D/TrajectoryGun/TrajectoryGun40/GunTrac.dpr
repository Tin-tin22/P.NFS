program GunTrac;

uses
  Forms,
  uMain in 'uMain.pas' {frmGun40trj},
  Trajec in 'Trajec.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGun40trj, frmGun40trj);
  Application.Run;
end.
