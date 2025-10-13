unit ufLeftKeyboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrDesign,
  ExtCtrls;

type
  TfrmLeftKeyBoard = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    VrBitmapButton1: TVrBitmapButton;
    Label2: TLabel;
    VrBitmapButton2: TVrBitmapButton;
    Label3: TLabel;
    VrBitmapButton3: TVrBitmapButton;
    Label4: TLabel;
    VrBitmapButton4: TVrBitmapButton;
    Label5: TLabel;
    VrBitmapButton6: TVrBitmapButton;
    Label6: TLabel;
    VrBitmapButton7: TVrBitmapButton;
    Label7: TLabel;
    VrBitmapButton8: TVrBitmapButton;
    Label8: TLabel;
    VrBitmapButton9: TVrBitmapButton;
    Label9: TLabel;
    VrBitmapButton10: TVrBitmapButton;
    Label10: TLabel;
    VrBitmapButton11: TVrBitmapButton;
    Label11: TLabel;
    VrBitmapButton12: TVrBitmapButton;
    Label12: TLabel;
    VrBitmapButton13: TVrBitmapButton;
    Label13: TLabel;
    VrBitmapButton14: TVrBitmapButton;
    Label14: TLabel;
    VrBitmapButton16: TVrBitmapButton;
    Label16: TLabel;
    GroupBox2: TGroupBox;
    VrBitmapButton15: TVrBitmapButton;
    Label15: TLabel;
    VrBitmapButton19: TVrBitmapButton;
    Label19: TLabel;
    Label20: TLabel;
    VrBitmapButton21: TVrBitmapButton;
    Label21: TLabel;
    VrBitmapButton22: TVrBitmapButton;
    Label22: TLabel;
    VrBitmapButton20: TVrBitmapButton;
    Label23: TLabel;
    VrBitmapButton23: TVrBitmapButton;
    Label24: TLabel;
    VrBitmapButton24: TVrBitmapButton;
    Label25: TLabel;
    VrBitmapButton25: TVrBitmapButton;
    Label26: TLabel;
    VrBitmapButton26: TVrBitmapButton;
    Label27: TLabel;
    VrBitmapButton17: TVrBitmapButton;
    VrBitmapButton18: TVrBitmapButton;
    Label18: TLabel;
    VrBitmapButton27: TVrBitmapButton;
    VrBitmapButton28: TVrBitmapButton;
    VrBitmapButton29: TVrBitmapButton;
    VrBitmapButton30: TVrBitmapButton;
    VrBitmapButton31: TVrBitmapButton;
    VrBitmapButton32: TVrBitmapButton;
    VrBitmapButton33: TVrBitmapButton;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    VrBitmapButton34: TVrBitmapButton;
    VrBitmapButton35: TVrBitmapButton;
    Q: TVrBitmapButton;
    VrBitmapButton37: TVrBitmapButton;
    VrBitmapButton38: TVrBitmapButton;
    VrBitmapButton39: TVrBitmapButton;
    VrBitmapButton40: TVrBitmapButton;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    VrBitmapButton41: TVrBitmapButton;
    VrBitmapButton42: TVrBitmapButton;
    VrBitmapButton43: TVrBitmapButton;
    VrBitmapButton44: TVrBitmapButton;
    VrBitmapButton45: TVrBitmapButton;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    VrBitmapButton5: TVrBitmapButton;
    VrBitmapButton46: TVrBitmapButton;
    VrBitmapButton48: TVrBitmapButton;
    Label17: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label49: TLabel;
    VrBitmapButton36: TVrBitmapButton;
    Label50: TLabel;
    Label51: TLabel;
    procedure VrBitmapButton22Click(Sender: TObject);
    procedure VrBitmapButton19Click(Sender: TObject);
    procedure VrBitmapButton20Click(Sender: TObject);
    procedure VrBitmapButton23Click(Sender: TObject);
    procedure VrBitmapButton24Click(Sender: TObject);
    procedure VrBitmapButton25Click(Sender: TObject);
    procedure VrBitmapButton26Click(Sender: TObject);
    procedure VrBitmapButton27Click(Sender: TObject);
    procedure VrBitmapButton28Click(Sender: TObject);
    procedure VrBitmapButton29Click(Sender: TObject);
    procedure VrBitmapButton30Click(Sender: TObject);
    procedure VrBitmapButton31Click(Sender: TObject);
    procedure VrBitmapButton32Click(Sender: TObject);
    procedure VrBitmapButton33Click(Sender: TObject);
    procedure VrBitmapButton34Click(Sender: TObject);
    procedure VrBitmapButton35Click(Sender: TObject);
    procedure QClick(Sender: TObject);
    procedure VrBitmapButton37Click(Sender: TObject);
    procedure VrBitmapButton38Click(Sender: TObject);
    procedure VrBitmapButton39Click(Sender: TObject);
    procedure VrBitmapButton40Click(Sender: TObject);
    procedure VrBitmapButton41Click(Sender: TObject);
    procedure VrBitmapButton42Click(Sender: TObject);
    procedure VrBitmapButton43Click(Sender: TObject);
    procedure VrBitmapButton44Click(Sender: TObject);
    procedure VrBitmapButton45Click(Sender: TObject);
    procedure VrBitmapButton14Click(Sender: TObject);
    procedure VrBitmapButton11Click(Sender: TObject);
    procedure VrBitmapButton12Click(Sender: TObject);
    procedure VrBitmapButton13Click(Sender: TObject);
    procedure VrBitmapButton8Click(Sender: TObject);
    procedure VrBitmapButton9Click(Sender: TObject);
    procedure VrBitmapButton10Click(Sender: TObject);
    procedure VrBitmapButton4Click(Sender: TObject);
    procedure VrBitmapButton6Click(Sender: TObject);
    procedure VrBitmapButton7Click(Sender: TObject);
    procedure VrBitmapButton48Click(Sender: TObject);
    procedure VrBitmapButton3Click(Sender: TObject);
    procedure VrBitmapButton2Click(Sender: TObject);
    procedure VrBitmapButton5Click(Sender: TObject);
    procedure VrBitmapButton18Click(Sender: TObject);
    procedure VrBitmapButton16Click(Sender: TObject);
    procedure VrBitmapButton36Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmLeftKeyBoard.VrBitmapButton22Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'A';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton19Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'B';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton20Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'C';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton23Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'D';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton24Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'E';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton25Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'F';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton26Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'G';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton27Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'H';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton28Click(Sender: TObject);
begin
//T/DCControl1.TDC_Kiri.KeyboardL.Val := 'I';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton29Click(Sender: TObject);
begin
////TDCControl1.TDC_Kiri.KeyboardL.Val := 'J';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton30Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'K';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton31Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'L';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton32Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'M';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton33Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'N';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton34Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'O';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton35Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'P';
end;

procedure TfrmLeftKeyBoard.QClick(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'Q';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton37Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'R';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton38Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'S';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton39Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'T';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton40Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'U';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton41Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val:= 'V';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton42Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'W';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton43Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'X';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton44Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'Y';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton45Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := 'Z';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton14Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '0';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton11Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '1';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton12Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '2';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton13Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '3';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton8Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '4';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton9Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '5';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton10Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '6';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton4Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '7';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton6Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '8';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton7Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '9';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton48Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := ' ';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton3Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '-';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton2Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '+';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton5Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.BackSpace;
end;


procedure TfrmLeftKeyBoard.VrBitmapButton18Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '    ';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton16Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Val := '.';
end;

procedure TfrmLeftKeyBoard.VrBitmapButton36Click(Sender: TObject);
begin
//TDCControl1.TDC_Kiri.KeyboardL.Action_Mnemonic(//TDCControl1.TDC_Kiri.KeyboardL.Val);

end;

end.
