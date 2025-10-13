unit ufrmDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfrmDisplay = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDisplay: TfrmDisplay;

implementation

uses
  uClientManager;

{$R *.dfm}

procedure TfrmDisplay.FormPaint(Sender: TObject);
begin
//  uClientManager.SimCenter.DrawAllOnMapXCanvas(Canvas);
end;

end.
