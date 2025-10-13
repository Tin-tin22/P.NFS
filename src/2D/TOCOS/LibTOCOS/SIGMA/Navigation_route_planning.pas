unit Navigation_route_planning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, ExtCtrls;

type
  TFrmNavigation_route_plan = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Bevel2: TBevel;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    VrDemoButton4: TVrDemoButton;
    VrDemoButton5: TVrDemoButton;
    Edit1: TEdit;
    VrDemoButton6: TVrDemoButton;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNavigation_route_plan: TFrmNavigation_route_plan;

implementation

{$R *.dfm}

end.
