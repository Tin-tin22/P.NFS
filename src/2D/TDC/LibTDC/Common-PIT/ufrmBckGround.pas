unit ufrmBckGround;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrDesign;

type
  TfrmBackground = class(TForm)
    btnclose: TVrBitmapButton;
    procedure FormShow(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Form1: TForm1;

implementation

{$R *.dfm}

procedure TfrmBackground.btncloseClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmBackground.FormCreate(Sender: TObject);
begin
self.Width:=1280;
self.Height:=1024;
end;

procedure TfrmBackground.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Ishown :Boolean;
begin
  Ishown := btnClose.Visible;
  if Button = mbRight then
  btnClose.Visible := not Ishown;
end;

procedure TfrmBackground.FormShow(Sender: TObject);
begin
  Self.WindowState := wsMaximized;
  btnclose.Left := Width - (btnclose.Width + 10);
end;

end.
