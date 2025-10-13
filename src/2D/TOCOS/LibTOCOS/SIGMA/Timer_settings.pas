unit Timer_settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrButtons, ExtCtrls, StdCtrls;

type
  TFrmTimer_settings = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Bevel1: TBevel;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTimer_settings: TFrmTimer_settings;

implementation

{$R *.dfm}

end.
