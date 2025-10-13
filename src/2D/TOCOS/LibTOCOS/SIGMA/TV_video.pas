unit TV_video;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, VrControls, VrButtons;

type
  TFrmTVvideo = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Settings1: TMenuItem;
    Picture1: TMenuItem;
    GroupBox1: TGroupBox;
    VrDemoButton1: TVrDemoButton;
    Label1: TLabel;
    VrDemoButton2: TVrDemoButton;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTVvideo: TFrmTVvideo;

implementation

{$R *.dfm}

end.
