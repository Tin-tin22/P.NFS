unit Magnetic_variation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, VrLcd, ExtCtrls;

type
  TFrmMagnetic_var = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    VrClock1: TVrClock;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
