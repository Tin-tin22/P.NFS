unit ufAndu_Cakra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VrControls, VrBlinkLed, StdCtrls, VrRotarySwitch,
  uLibWCCClassNew;

type
  TfrmAndu_Cakra = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    GroupBox1: TGroupBox;
    VrBlinkLed1: TVrBlinkLed;
    VrBlinkLed2: TVrBlinkLed;
    VrBlinkLed3: TVrBlinkLed;
    VrBlinkLed4: TVrBlinkLed;
    VrBlinkLed5: TVrBlinkLed;
    VrBlinkLed6: TVrBlinkLed;
    VrBlinkLed7: TVrBlinkLed;
    VrBlinkLed9: TVrBlinkLed;
    VrBlinkLed11: TVrBlinkLed;
    VrBlinkLed12: TVrBlinkLed;
    VrBlinkLed13: TVrBlinkLed;
    VrBlinkLed14: TVrBlinkLed;
    VrBlinkLed15: TVrBlinkLed;
    VrBlinkLed16: TVrBlinkLed;
    VrBlinkLed17: TVrBlinkLed;
    VrBlinkLed18: TVrBlinkLed;
    VrBlinkLed8: TVrBlinkLed;
    VrBlinkLed10: TVrBlinkLed;
    VrBlinkLed19: TVrBlinkLed;
    VrBlinkLed20: TVrBlinkLed;
    VrBlinkLed21: TVrBlinkLed;
    VrBlinkLed22: TVrBlinkLed;
    VrBlinkLed23: TVrBlinkLed;
    VrBlinkLed24: TVrBlinkLed;
    VrBlinkLed25: TVrBlinkLed;
    VrBlinkLed26: TVrBlinkLed;
    VrBlinkLed27: TVrBlinkLed;
    VrBlinkLed28: TVrBlinkLed;
    VrBlinkLed29: TVrBlinkLed;
    VrBlinkLed30: TVrBlinkLed;
    VrBlinkLed31: TVrBlinkLed;
    VrBlinkLed32: TVrBlinkLed;
    GroupBox2: TGroupBox;
    VrBlinkLed33: TVrBlinkLed;
    VrBlinkLed34: TVrBlinkLed;
    VrBlinkLed35: TVrBlinkLed;
    VrBlinkLed36: TVrBlinkLed;
    VrBlinkLed37: TVrBlinkLed;
    VrBlinkLed38: TVrBlinkLed;
    VrBlinkLed39: TVrBlinkLed;
    VrBlinkLed40: TVrBlinkLed;
    VrBlinkLed41: TVrBlinkLed;
    VrBlinkLed42: TVrBlinkLed;
    VrBlinkLed43: TVrBlinkLed;
    VrBlinkLed44: TVrBlinkLed;
    VrBlinkLed45: TVrBlinkLed;
    VrBlinkLed46: TVrBlinkLed;
    VrBlinkLed47: TVrBlinkLed;
    VrBlinkLed48: TVrBlinkLed;
    VrBlinkLed49: TVrBlinkLed;
    VrBlinkLed50: TVrBlinkLed;
    VrBlinkLed51: TVrBlinkLed;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    Panel3: TPanel;
    Button9: TButton;
    Button8: TButton;
    Button7: TButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    Button16: TButton;
    Button15: TButton;
    Button14: TButton;
    Button12: TButton;
    Button11: TButton;
    Button10: TButton;
    Button1: TButton;
    Button13: TButton;
    Shape2: TShape;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WCCInterface: TGenericWCCInterface;
  end;

implementation

{$R *.dfm}

procedure TfrmAndu_Cakra.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Left := Trunc((Screen.WorkAreaWidth - self.Width) / 2);
end;

end.
