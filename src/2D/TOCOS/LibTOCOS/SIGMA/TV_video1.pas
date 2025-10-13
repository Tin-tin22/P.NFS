unit TV_video1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, VrControls, VrButtons, StdCtrls, ExtCtrls;

type
  TFrmTV_video1 = class(TForm)
    MainMenu1: TMainMenu;
    Settings1: TMenuItem;
    Picture1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTV_video1: TFrmTV_video1;

implementation

{$R *.dfm}

end.
