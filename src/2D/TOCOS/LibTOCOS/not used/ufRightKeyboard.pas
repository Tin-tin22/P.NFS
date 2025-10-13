unit ufRightKeyboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrDesign, 
  ExtCtrls;

type
  TfrmRightKeyBoard = class(TForm)
    GroupBox2: TGroupBox;
    VrBitmapButton15: TVrBitmapButton;
    Label15: TLabel;
    VrBitmapButton19: TVrBitmapButton;
    Label19: TLabel;
    Label20: TLabel;
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
    Label1: TLabel;
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
    procedure VrBitmapButton11Click(Sender: TObject);
    procedure VrBitmapButton14Click(Sender: TObject);
    procedure VrBitmapButton12Click(Sender: TObject);
    procedure VrBitmapButton13Click(Sender: TObject);
    procedure VrBitmapButton8Click(Sender: TObject);
    procedure VrBitmapButton9Click(Sender: TObject);
    procedure VrBitmapButton10Click(Sender: TObject);
    procedure VrBitmapButton4Click(Sender: TObject);
    procedure VrBitmapButton6Click(Sender: TObject);
    procedure VrBitmapButton7Click(Sender: TObject);
    procedure VrBitmapButton2Click(Sender: TObject);
    procedure VrBitmapButton3Click(Sender: TObject);
    procedure VrBitmapButton48Click(Sender: TObject);
    procedure VrBitmapButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}


procedure TfrmRightKeyBoard.VrBitmapButton22Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'A';
end;

procedure TfrmRightKeyBoard.VrBitmapButton19Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'B';
end;

procedure TfrmRightKeyBoard.VrBitmapButton20Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'C';
end;

procedure TfrmRightKeyBoard.VrBitmapButton23Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'D';
end;

procedure TfrmRightKeyBoard.VrBitmapButton24Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'E';
end;

procedure TfrmRightKeyBoard.VrBitmapButton25Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'F';
end;

procedure TfrmRightKeyBoard.VrBitmapButton26Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val:= 'G';
end;

procedure TfrmRightKeyBoard.VrBitmapButton27Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'H';
end;

procedure TfrmRightKeyBoard.VrBitmapButton28Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val:= 'I';
end;

procedure TfrmRightKeyBoard.VrBitmapButton29Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'J';
end;

procedure TfrmRightKeyBoard.VrBitmapButton30Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'K';
end;

procedure TfrmRightKeyBoard.VrBitmapButton31Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'L';
end;

procedure TfrmRightKeyBoard.VrBitmapButton32Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'M';
end;

procedure TfrmRightKeyBoard.VrBitmapButton33Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'N';
end;

procedure TfrmRightKeyBoard.VrBitmapButton34Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'O';
end;

procedure TfrmRightKeyBoard.VrBitmapButton35Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'P';
end;

procedure TfrmRightKeyBoard.QClick(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'Q';
end;

procedure TfrmRightKeyBoard.VrBitmapButton37Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'R';
end;

procedure TfrmRightKeyBoard.VrBitmapButton38Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'S';
end;

procedure TfrmRightKeyBoard.VrBitmapButton39Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'T';
end;

procedure TfrmRightKeyBoard.VrBitmapButton40Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'U';
end;

procedure TfrmRightKeyBoard.VrBitmapButton41Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'V';
end;

procedure TfrmRightKeyBoard.VrBitmapButton42Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'W';
end;

procedure TfrmRightKeyBoard.VrBitmapButton43Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'X';
end;

procedure TfrmRightKeyBoard.VrBitmapButton44Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'Y';
end;

procedure TfrmRightKeyBoard.VrBitmapButton45Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := 'Z';
end;

procedure TfrmRightKeyBoard.VrBitmapButton11Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '1';
end;

procedure TfrmRightKeyBoard.VrBitmapButton14Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '0';
end;

procedure TfrmRightKeyBoard.VrBitmapButton12Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '2';
end;

procedure TfrmRightKeyBoard.VrBitmapButton13Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '3';
end;

procedure TfrmRightKeyBoard.VrBitmapButton8Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '4';
end;

procedure TfrmRightKeyBoard.VrBitmapButton9Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '5';
end;

procedure TfrmRightKeyBoard.VrBitmapButton10Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '6';
end;

procedure TfrmRightKeyBoard.VrBitmapButton4Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '7';
end;

procedure TfrmRightKeyBoard.VrBitmapButton6Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '8';
end;

procedure TfrmRightKeyBoard.VrBitmapButton7Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '9';
end;

procedure TfrmRightKeyBoard.VrBitmapButton2Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '+';
end;

procedure TfrmRightKeyBoard.VrBitmapButton3Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := '-';
end;

procedure TfrmRightKeyBoard.VrBitmapButton48Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.Val := ' ';
end;

procedure TfrmRightKeyBoard.VrBitmapButton5Click(Sender: TObject);
begin
//TDCControl1.TDC_Kanan.KeyboardR.backspace;
end;


end.
