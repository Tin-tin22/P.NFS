unit Operator_desk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VrControls, VrLcd, StdCtrls, VrButtons;

type
  TFrmOp_desk = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    GroupBox1: TGroupBox;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    VrClock1: TVrClock;
    VrClock2: TVrClock;
    VrClock3: TVrClock;
    VrDemoButton9: TVrDemoButton;
    Bevel2: TBevel;
    VrDemoButton10: TVrDemoButton;
    VrDemoButton11: TVrDemoButton;
    Bevel1: TBevel;
    ComboBox1: TComboBox;
    VrPowerButton1: TVrPowerButton;
    VrPowerButton2: TVrPowerButton;
    VrPowerButton3: TVrPowerButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOp_desk: TFrmOp_desk;

implementation

{$R *.dfm}

end.
