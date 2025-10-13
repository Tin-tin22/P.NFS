unit Throw_off_control;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrSpinner, VrControls, VrButtons, StdCtrls, ExtCtrls;

type
  TFrmThrow_off_control = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Edit1: TEdit;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    VrDemoButton4: TVrDemoButton;
    VrSpinner1: TVrSpinner;
    VrDemoButton5: TVrDemoButton;
    Label2: TLabel;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmThrow_off_control: TFrmThrow_off_control;

implementation

{$R *.dfm}

end.
