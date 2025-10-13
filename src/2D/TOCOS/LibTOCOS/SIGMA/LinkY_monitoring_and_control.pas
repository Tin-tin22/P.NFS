unit LinkY_monitoring_and_control;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VrControls, VrButtons, StdCtrls, Menus, VrLcd;

type
  TFrmLinkY_monitoring_and_control = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Settings1: TMenuItem;
    Monitoring1: TMenuItem;
    Control1: TMenuItem;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    Label11: TLabel;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit2: TEdit;
    VrDemoButton4: TVrDemoButton;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Label17: TLabel;
    VrClock1: TVrClock;
    VrDemoButton5: TVrDemoButton;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
