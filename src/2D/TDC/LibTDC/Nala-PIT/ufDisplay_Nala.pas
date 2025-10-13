unit ufDisplay_Nala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufANDUDisplay, StdCtrls, ExtCtrls;

type
  TfrmDisplay_NALA = class(TfrmANDUDisplay)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmDisplay_NALA.FormCreate(Sender: TObject);
var i: integer;
begin
  inherited;
  SetNumOfPage(4);

  for i := 1 to 14 do begin
    SetTextLineNumber(i, '')
  end;


end;

end.
