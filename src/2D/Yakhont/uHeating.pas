unit uHeating;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, uMainMM;

type
  TfrmHeating = class(TForm)
    pnlheader: TPanel;
    pnlHeating: TPanel;
    pnlContent: TPanel;
    btnExit: TSpeedButtonImage;
    tmr1: TTimer;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHeating: TfrmHeating;
  frmHeatingTime : TfmMainMM;

implementation


{$R *.dfm}

procedure TfrmHeating.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHeating.FormShow(Sender: TObject);
begin
  Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 170;
  Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 269;
end;

end.
