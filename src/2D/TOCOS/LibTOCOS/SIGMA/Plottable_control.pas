unit Plottable_control;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, VrControls, VrLabel, VrButtons;

type
  TFrmPlot_Control = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    VrDemoButton1: TVrDemoButton;
    Bevel2: TBevel;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    Edit1: TEdit;
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPlot_Control: TFrmPlot_Control;

implementation

{$R *.dfm}

end.
