program Screen;

uses
  Forms,
  uScreen in 'uScreen.pas' {fScreen},
  uScreenManager in 'uScreenManager.pas',
  uFormUtil in 'uFormUtil.pas',
  DosCommand in 'DosCommand.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TfScreen, fScreen);
  FCmdLine := TDosCommand.Create(nil);
  FScreenManager := TScreenManager.Create;
  FScreenManager.SetLayout;
  FScreenManager.RunController; //jalanin Controller
  Application.Run;
end.
