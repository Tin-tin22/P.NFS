unit uCRData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TfrmCRData = class(TForm)
    pnlCRData: TPanel;
    Panel2: TPanel;
    btnTI1: TSpeedButton;
    btnTI2: TSpeedButton;
    btnTI3: TSpeedButton;
    btnExit: TSpeedButton;
    Panel3: TPanel;
    Label1: TLabel;
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCRData: TfrmCRData;

implementation

{$R *.dfm}

procedure TfrmCRData.btnExitClick(Sender: TObject);
begin
   Close;
end;

end.
