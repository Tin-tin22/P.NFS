unit Drift;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, VrLcd, ExtCtrls;

type
  TFrmDrift = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    VrClock1: TVrClock;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
