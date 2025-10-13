unit uMainQEK_Owa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ufSatu, ufDua, ufTiga,ufEmpat,ufLima,ufEnam,ufTujuh,ufDelapan,ufSembilan;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
frmSatu.Show;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
frmDua.Show;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
frmTiga.Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
frmEmpat.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
frmLima.Show;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
frmEnam.Show;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
frmTujuh.Show;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
frmDelapan.Show;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
frmSembilan.Show;
end;

end.
