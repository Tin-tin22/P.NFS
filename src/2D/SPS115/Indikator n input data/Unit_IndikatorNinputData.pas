unit Unit_IndikatorNinputData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrLeds;

type
  TFrm_spsIndikator = class(TForm)
    vrld1: TVrLed;
    vrld2: TVrLed;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure vrld1Click(Sender: TObject);
    procedure vrld2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_spsIndikator: TFrm_spsIndikator;

implementation


{$R *.dfm}

procedure TFrm_spsIndikator.vrld1Click(Sender: TObject);
var st : boolean;
begin
  st:=vrld1.Active;
  st:=not st;
  vrld1.Active:= st;

end;

procedure TFrm_spsIndikator.vrld2Click(Sender: TObject);
var st : boolean;
begin
  st:=vrld2.Active;
  st:=not st;
  vrld2.Active:= st;
end;

end.
