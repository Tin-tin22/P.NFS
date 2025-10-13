unit uAcknowledgement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmAcknowledgement = class(TForm)
    pnlAcknowledgement: TPanel;
    pnlContent: TPanel;
    Label1: TLabel;
    btnYes: TButton;
    btnNo: TButton;
    Panel1: TPanel;
    procedure btnNoClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    var
      checkEmergencyButton  : Boolean;

    { Public declarations }
  end;

var
  frmAcknowledgement: TfrmAcknowledgement;

  //YakhontEmergencyManager : TYakhontManager;

implementation

{$R *.dfm}
uses uTCPDatatype, uMainMM, uYakhontManager, uEmergencyRelease;

procedure TfrmAcknowledgement.btnNoClick(Sender: TObject);
begin
Close;

end;

procedure TfrmAcknowledgement.btnYesClick(Sender: TObject);
var
  rec_dataEmergencyYakhont : TRecData_Yakhont;
  rec_Emergency : TRecCMD_Yakhont;
  frmEmergency : TfrmEmergencyRelease;
  frmMain : TfmMainMM;

begin
  //rec_Emergency.cmd:=CMD_Yakhont_OpenKey;
  //rec_Emergency.cmd:=CMD_Yakhont_ReadyToFire;
  //YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @rec_Emergency, nil);
  //YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
  //YakhontManager.PLPState := OnReadyFire;
  checkEmergencyButton := True;
  //frmEmergency.missile_ready_to_On;
  Close;


end;


procedure TfrmAcknowledgement.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + frmEmergencyRelease.Left + 50;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + frmEmergencyRelease.top + 50;
end;

end.
