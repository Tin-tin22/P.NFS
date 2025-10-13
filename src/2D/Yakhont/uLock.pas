unit uLock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmLock = class(TForm)
    pnlLock: TPanel;
    Label1: TLabel;
    pnlValue: TPanel;
    grpVerticalDev: TGroupBox;
    pnlVerticalDev: TPanel;
    pnlVDColor: TPanel;
    grpTransvAcce: TGroupBox;
    pnlTransvAcce: TPanel;
    pnlTAColor: TPanel;
    grpVelocityOfShip: TGroupBox;
    pnlVelocityOfShip: TPanel;
    pnlVoSColor: TPanel;
    grpRulesOfControl: TGroupBox;
    pnlRulesOfControl: TPanel;
    pnlRoCColor: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    btnExit: TSpeedButton;
    Panel2: TPanel;
    Label11: TLabel;
    Panel3: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLock: TfrmLock;

implementation

uses
  uMainMM;

{$R *.dfm}

procedure TfrmLock.btnExitClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmLock.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     Close;
  end;
end;

procedure TfrmLock.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 145;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 145;
end;

end.
