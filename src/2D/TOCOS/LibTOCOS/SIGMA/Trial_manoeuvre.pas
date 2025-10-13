unit Trial_manoeuvre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrButtons, VrControls, ExtCtrls;

type
  TFrmTrial_man = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    VrPowerButton1: TVrPowerButton;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTrial_man: TFrmTrial_man;

implementation

{$R *.dfm}

end.
