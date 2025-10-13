unit SGO_definition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrLcd, VrButtons, StdCtrls, ExtCtrls, ComCtrls;

type
  TFrmSGO_def = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Edit2: TEdit;
    Edit3: TEdit;
    VrDemoButton1: TVrDemoButton;
    Label1: TLabel;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    Label4: TLabel;
    VrClock1: TVrClock;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSGO_def: TFrmSGO_def;

implementation

{$R *.dfm}

end.
