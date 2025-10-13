unit uTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmTest = class(TForm)
    pnlAbove: TPanel;
    pnlMiddle: TPanel;
    pnlBottom: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnlKR163U: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnlExit: TPanel;
    pnlHelp: TPanel;
    pnlAutomatictests: TPanel;
    pnlPrinter: TPanel;
    pnlRS232: TPanel;
    pnlKCn: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl21: TPanel;
    pnl22: TPanel;
    pnl23: TPanel;
    pnl24: TPanel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    pnl28: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    pnl32: TPanel;
    pnl33: TPanel;
    pnl34: TPanel;
    pnl35: TPanel;
    pnl36: TPanel;
    pnl37: TPanel;
    pnl38: TPanel;
    pnl39: TPanel;
    pnl56: TPanel;
    pnl57: TPanel;
    pnl58: TPanel;
    pnl59: TPanel;
    pnl60: TPanel;
    pnl61: TPanel;
    pnl62: TPanel;
    pnl63: TPanel;
    pnl64: TPanel;
    pnl65: TPanel;
    pnl66: TPanel;
    pnl67: TPanel;
    pnl68: TPanel;
    pnl69: TPanel;
    pnl70: TPanel;
    pnl71: TPanel;
    pnl74: TPanel;
    pnl75: TPanel;
    pnl76: TPanel;
    pnl77: TPanel;
    pnl78: TPanel;
    pnl79: TPanel;
    pnl80: TPanel;
    pnl40: TPanel;
    pnl41: TPanel;
    pnl42: TPanel;
    pnl43: TPanel;
    pnl44: TPanel;
    pnl45: TPanel;
    pnl46: TPanel;
    pnl47: TPanel;
    pnl48: TPanel;
    pnl49: TPanel;
    pnl50: TPanel;
    pnl51: TPanel;
    pnl52: TPanel;
    pnl53: TPanel;
    pnl54: TPanel;
    pnl55: TPanel;
    procedure pnlExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTest: TfrmTest;

implementation

{$R *.dfm}

procedure TfrmTest.FormShow(Sender: TObject);
begin
  Left :=  160;
  Top  :=  0;
end;

procedure TfrmTest.pnlExitClick(Sender: TObject);
begin
  Close;
end;

end.
