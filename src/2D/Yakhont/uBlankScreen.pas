unit uBlankScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmBlankScreen = class(TForm)
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBlankScreen: TfrmBlankScreen;

implementation

uses
  uTCPDatatype, uYakhontManager, uLoadingScreen;

{$R *.dfm}

procedure TfrmBlankScreen.btnExitClick(Sender: TObject);
var
  rec: TRecCMD_Yakhont;
begin
  YakhontManager.EventOnSendingLog(45, 0, 0, 0);
  rec.cmd := CMD_Yakhont_Terminate;
  YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @rec, nil);
  Application.Terminate;
end;

procedure TfrmBlankScreen.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if GetKeyState(VK_CONTROL) < 0 then
  begin
    case Msg.CharCode of
      VK_SHIFT :
      begin
        btnExit.Visible := true;
      end;
    end;
  end;
end;

end.
