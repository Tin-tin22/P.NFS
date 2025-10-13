unit ufrmFiringCommand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvSmoothButton, AdvSmoothTabPager, AdvSmoothPanel;

type
  TfrmFiringCommand = class(TForm)
    mmfrmMain: TMainMenu;
    Application1: TMenuItem;
    DisplayController1: TMenuItem;
    DisplayFiringCommandProcedure1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    pnlMain: TAdvSmoothPanel;
    procedure DisplayController1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetFormLayout;
  end;

var
  frmFiringCommand: TfrmFiringCommand;

implementation

uses ufrmGameController, ufrmMainInstruktur;

{$R *.dfm}

procedure TfrmFiringCommand.DisplayController1Click(Sender: TObject);
begin
  case TComponent(sender).Tag of
    1 : frmMainInstruktur.SetFormLayout;
    2 : frmGameController.SetFormLayout;
  end;
end;

procedure TfrmFiringCommand.SetFormLayout;
var
  i : integer;
begin
   { set Firing Command & Procedures}
   DefaultMonitor := dmDesktop;
   if Screen.MonitorCount > 1 then i := 1
   else i := 0;

   Height       := Screen.Monitors[i].Height;
   Top          := Screen.Monitors[i].Top;
   Left         := Screen.Monitors[i].Left;
   width        := Screen.Monitors[i].Width;
   Show;
end;

end.
