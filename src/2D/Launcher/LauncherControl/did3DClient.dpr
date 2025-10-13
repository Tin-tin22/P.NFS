program did3DClient;

uses
  Forms,
  uClient3D in 'didClientServer\uClient3D.pas' {frmMain},
  DosCommand in 'didCommon\DosCommand.pas',
  uQuery in 'didCommon\uQuery.pas',
  uXMLScen in 'didCommon\uXMLScen.pas',
  uDataModule in '..\..\ShareLib\AppForms\uDataModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CLIENT 3D';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
