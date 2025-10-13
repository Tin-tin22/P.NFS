unit ufDisplay_Nala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufANDUDisplay, StdCtrls, ExtCtrls;

type
  TfrmDisplay_NALA = class(TfrmANDUDisplay)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  frmDisplay_NALA: TfrmDisplay_NALA;
}
implementation

{$R *.dfm}

procedure TfrmDisplay_NALA.FormCreate(Sender: TObject);
begin
  inherited;
  SetNumOfPage(4);
end;

end.
