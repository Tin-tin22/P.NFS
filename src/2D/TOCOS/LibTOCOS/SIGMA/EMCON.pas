unit EMCON;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrLcd, StdCtrls, ExtCtrls, VrButtons;

type
  TFrmEMCON = class(TForm)
    Panel1: TPanel;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    Bevel1: TBevel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    VrClock1: TVrClock;
    VrClock2: TVrClock;
    Label5: TLabel;
    Bevel2: TBevel;
    VrDemoButton3: TVrDemoButton;
    VrDemoButton4: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
