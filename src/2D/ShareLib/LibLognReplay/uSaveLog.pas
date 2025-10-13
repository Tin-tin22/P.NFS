unit uSaveLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, AdvSmoothButton ;

type
  TfrmSaveLog = class(TForm)
    Bevel1: TBevel;
    Label7: TLabel;
    Bevel2: TBevel;
    feLogName: TEdit;
    Label1: TLabel;
    feScenarioName: TEdit;
    btnCancel: TAdvSmoothButton;
    btnAccept: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
  public
  end;

var
  frmSaveLog: TfrmSaveLog;

implementation
uses  uGlobalVar;
{$R *.dfm}


procedure TfrmSaveLog.FormShow(Sender: TObject);
var
  aDateTime : TDatetime;
  formatDate : string;
begin
  aDateTime := Now;
  DateTimeToString(formatDate, 'ddmmyy_hhnnss', aDateTime);
  feScenarioName.Text := CurrentScenarioName;
  feLogName.Text := 'Replay_'+CurrentScenarioName+'_'+formatDate;
end;

procedure TfrmSaveLog.btnAcceptClick(Sender: TObject);
begin
  if feLogName.Text <>'' then
  begin
    CurrentLogFile := feLogName.Text;
    ModalResult := mrOK;
  end
  else
    showmessage('isi nama log');
end;

procedure TfrmSaveLog.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
