unit uCertificateData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TfrmCertificateData = class(TForm)
    pnlCertificateData: TPanel;
    Panel2: TPanel;
    btnCDSNS: TSpeedButton;
    Panel1: TPanel;
    btnCDASM: TSpeedButton;
    btnExit: TSpeedButton;
    pnlCD_SNS: TPanel;
    Label1: TLabel;
    grpZ: TGroupBox;
    grpY: TGroupBox;
    grpX: TGroupBox;
    pnlDx: TPanel;
    pnlDy: TPanel;
    pnlDZ: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlCD_ASM: TPanel;
    GroupBox3: TGroupBox;
    pnlAx: TPanel;
    Label8: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    pnlAy: TPanel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    pnlQ: TPanel;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    pnlRx: TPanel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    pnlRy: TPanel;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    pnlRz: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label14: TLabel;
    pnlNetral: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnCDASMClick(Sender: TObject);
    procedure btnCDSNSClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure defaultData;
  end;

var
  frmCertificateData: TfrmCertificateData;

implementation

{$R *.dfm}

procedure TfrmCertificateData.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     Close;
  end;
end;

procedure TfrmCertificateData.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCertificateData.FormShow(Sender: TObject);
begin
  pnlNetral.BringToFront;
  defaultData;
end;

procedure TfrmCertificateData.btnCDASMClick(Sender: TObject);
begin
  pnlCD_ASM.BringToFront;
end;

procedure TfrmCertificateData.btnCDSNSClick(Sender: TObject);
begin
  pnlCD_SNS.BringToFront;
end;

procedure TfrmCertificateData.defaultData;
begin
  pnlAx.Caption := '-00.01.38';
  pnlAy.Caption := '-00 14 35';
  pnlQ.Caption  := ' 89 55 00';
  pnlRx.Caption := '44.488';
  pnlRy.Caption := '06.248';
  pnlRz.Caption := '-5.536';

  pnlDx.Caption := '-00.09.30';
  pnlDy.Caption := '-00.00.30';
  pnlDZ.Caption := '-00.00.02';
end;

end.
