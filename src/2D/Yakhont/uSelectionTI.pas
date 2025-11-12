unit uSelectionTI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmSelectionTI = class(TForm)
    pnlSelectionTI: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    btnTI1: TSpeedButton;
    btnTI2: TSpeedButton;
    btnMI: TSpeedButton;
    Panel2: TPanel;
    btnEM: TSpeedButton;
    procedure btnMIClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTI1Click(Sender: TObject);
    procedure btnTI2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    currentSelectionTI : Integer;
  end;

var
  frmSelectionTI: TfrmSelectionTI;

implementation

uses
  uManualInput, uMainMM, uYakhontManager;

{$R *.dfm}

{ currentSelectionTI = 1   => TI 1
  currentSelectionTI = 2   => TI 2
  currentSelectionTI = 3   => MI
}

procedure TfrmSelectionTI.btnTI1Click(Sender: TObject);
begin
   currentSelectionTI := 1;

   fmMainMM.pnlNow.Caption  := 'Reception TI-OI';
   fmMainMM.pnlNext.Caption := '';

   frmManualInput.pnlNumberOfTIVariant.BringToFront;
   frmManualInput.ShowModal;

   Close;
end;

procedure TfrmSelectionTI.btnTI2Click(Sender: TObject);
begin
   currentSelectionTI := 2;

   fmMainMM.pnlNow.Caption  := 'Reception TI-OI';
   fmMainMM.pnlNext.Caption := '';

   frmManualInput.pnlNumberOfTIVariant.BringToFront;
   frmManualInput.ShowModal;

   Close;
end;

procedure TfrmSelectionTI.btnMIClick(Sender: TObject);
begin
   currentSelectionTI := 3;

   fmMainMM.pnlNow.Caption  := 'Reception TI-OI';
   fmMainMM.pnlNext.Caption := '';

   frmManualInput.pnlNumberOfTIVariant.BringToFront;
   frmManualInput.ShowModal;

   Close;
end;

procedure TfrmSelectionTI.FormShow(Sender: TObject);
begin
   if fmMainMM.CTType = 0 then
   begin
     btnMI.Caption := 'MI';
   end
   else
     btnMI.Caption := 'SNS';

   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 245;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 220;

   currentSelectionTI := 0;
end;

end.
