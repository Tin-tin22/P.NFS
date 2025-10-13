unit ufOwa_5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_5 = class(TfrmQEK)
    Panel1: TPanel;
    btnINITAir: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnWIPE: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    btnINITChange: TSpeedButtonImage;
    btnLINKPlus: TSpeedButtonImage;
    btnLINKMin: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnASSLocRT: TSpeedButtonImage;
    btnAssLocNRT: TSpeedButtonImage;
    btnASS_REM: TSpeedButtonImage;
    btnCOR_DECOR: TSpeedButtonImage;
    Label8: TLabel;
    btnSEQ: TSpeedButtonImage;
    btnCORR: TSpeedButtonImage;
    btnREPOS: TSpeedButtonImage;
    btnCLOSE_CTRL: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    procedure btnINITAirClick(Sender: TObject);
    procedure btnWIPEClick(Sender: TObject);
    procedure btnASSLocRTClick(Sender: TObject);
    procedure btnCLOSE_CTRLClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
    procedure btnAssLocNRTClick(Sender: TObject);
    procedure btnINITChangeClick(Sender: TObject);
    procedure btnSEQClick(Sender: TObject);
    procedure btnLINKPlusClick(Sender: TObject);
    procedure btnLINKMinClick(Sender: TObject);
    procedure btnCOR_DECORClick(Sender: TObject);
    procedure btnASS_REMClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmOwa_5: TfrmOwa_5;

implementation

uses
  uBaseConstan, uTCPDataType, uLibTDCClass;

{$R *.dfm}

procedure TfrmOwa_5.btnINITAirClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitAir, TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnWIPEClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfrmOwa_5.btnASSLocRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocRT(aRec);
end;

procedure TfrmOwa_5.btnCLOSE_CTRLClick(Sender: TObject);
begin
  TDCInterface.CloseControl_OWA(TDCInterface.OBMRight.Center);
end;

procedure TfrmOwa_5.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnAssLocNRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocNRT(aRec);
end;

procedure TfrmOwa_5.btnINITChangeClick(Sender: TObject);
begin
  TDCInterface.SwitchTrackPosition(TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnSEQClick(Sender: TObject);
begin
  TDCInterface.SetOBM_NextTrack_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnLINKPlusClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, true);
end;

procedure TfrmOwa_5.btnLINKMinClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, false);
end;

procedure TfrmOwa_5.btnCOR_DECORClick(Sender: TObject);
begin
  TDCInterface.CorrelateOrDecorelateTrack(TDCInterface.OBMRight);
end;

procedure TfrmOwa_5.btnASS_REMClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRemote(aRec);
end;

end.
