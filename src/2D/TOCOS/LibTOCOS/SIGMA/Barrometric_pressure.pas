unit Barrometric_pressure;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, VrLcd, ExtCtrls;

type
  TFrmBarrometric_pressure = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    VrClock1: TVrClock;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
