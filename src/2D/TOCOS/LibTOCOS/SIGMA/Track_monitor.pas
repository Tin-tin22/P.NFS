unit Track_monitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VrControls, VrButtons;

type
  TFrmTrack_monitor = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    VrDemoButton1: TVrDemoButton;
    Bevel1: TBevel;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTrack_monitor: TFrmTrack_monitor;

implementation

{$R *.dfm}

end.
