unit ufrmNetSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmNetSetting = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    btnSet: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    procedure btnSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function getServerIP: string;
    function getServerPort: string;
    procedure setServerIP(const Value: string);
    procedure setServerPort(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property ServerIP: string read getServerIP write setServerIP;
    property ServerPort: string read getServerPort write setServerPort;
  end;

var
 frmNetSetting: TfrmNetSetting;

implementation

{$R *.dfm}

procedure TfrmNetSetting.btnSetClick(Sender: TObject);
begin
//
end;

function TfrmNetSetting.getServerIP: string;
begin
  result := Edit1.Text;
end;

function TfrmNetSetting.getServerPort: string;
begin
  result := Edit2.Text;
end;

procedure TfrmNetSetting.setServerIP(const Value: string);
begin
  Edit1.Text := Value;

end;

procedure TfrmNetSetting.setServerPort(const Value: string);
begin
  Edit2.Text := Value;

end;

procedure TfrmNetSetting.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

procedure TfrmNetSetting.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    ModalResult := mrOK;
  end;
  if Key = VK_ESCAPE then begin
    ModalResult := mrCancel;
  end;
end;

end.
