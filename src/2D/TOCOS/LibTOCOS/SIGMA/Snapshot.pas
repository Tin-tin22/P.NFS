unit Snapshot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, ExtCtrls;

type
  TFrmSnapshot = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Bevel1: TBevel;
    VrDemoButton3: TVrDemoButton;
    VrDemoButton4: TVrDemoButton;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    VrDemoButton7: TVrDemoButton;
    VrPowerButton1: TVrPowerButton;
    VrPowerButton2: TVrPowerButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSnapshot: TFrmSnapshot;

implementation

{$R *.dfm}

end.
