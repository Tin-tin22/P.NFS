unit ufOwa_4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, ImgList, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls;

type
  TfrmOwa_4 = class(TfrmQEK)
    Panel1: TPanel;
    btnInitAir: TSpeedButtonImage;
    btnInitSurf: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnWIPE: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    btnINIT_SUBSNRT: TSpeedButtonImage;
    btnINIT_AIRPOINT: TSpeedButtonImage;
    btnLINKPlus: TSpeedButtonImage;
    btnLINKMin: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnASS_LOCRT: TSpeedButtonImage;
    btnASS_LOCNRT: TSpeedButtonImage;
    btnASS_REMOTE: TSpeedButtonImage;
    btnTRTV_ENG: TSpeedButtonImage;
    Label8: TLabel;
    btnSEQ: TSpeedButtonImage;
    btnCORR: TSpeedButtonImage;
    btnREPOS: TSpeedButtonImage;
    btnCLOSE_CTRL: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    procedure btnInitAirClick(Sender: TObject);
    procedure btnInitSurfClick(Sender: TObject);
    procedure btnWIPEClick(Sender: TObject);
    procedure btnCLOSE_CTRLClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnSEQClick(Sender: TObject);
    procedure btnASS_LOCRTClick(Sender: TObject);
    procedure btnINIT_SUBSNRTClick(Sender: TObject);
    procedure btnTRTV_ENGClick(Sender: TObject);
    procedure btnASS_LOCNRTClick(Sender: TObject);
    procedure btnINIT_AIRPOINTClick(Sender: TObject);
    procedure btnLINKPlusClick(Sender: TObject);
    procedure btnLINKMinClick(Sender: TObject);
    procedure btnASS_REMOTEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmOwa_4: TfrmOwa_4;

implementation

uses
  uBaseConstan, uTCPDataType, uTDCConstan;

{$R *.dfm}

procedure TfrmOwa_4.btnInitAirClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitAir, TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnInitSurfClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitSurf, TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnWIPEClick(Sender: TObject);
begin
  TDCInterface.WipeOnLeftOBM;
end;

procedure TfrmOwa_4.btnCLOSE_CTRLClick(Sender: TObject);
begin
  TDCInterface.CloseControl_OWA(TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_4.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnSEQClick(Sender: TObject);
begin
  TDCInterface.SetOBM_NextTrack_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnASS_LOCRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignLocRT(aRec);
end;

procedure TfrmOwa_4.btnINIT_SUBSNRTClick(Sender: TObject);
begin
  //TDCInterface.InitiateTrack(tdBawahAir, TDCInterface.OBMLeft.Center);
  TDCInterface.InitiateTrack(InitSubNRT, TDCInterface.OBMLeft);
end;

procedure TfrmOwa_4.btnTRTV_ENGClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderType := Byte(teTrialReview);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_4.btnASS_LOCNRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignLocNRT(aRec);
end;

procedure TfrmOwa_4.btnINIT_AIRPOINTClick(Sender: TObject);
var aRec: TRecOrderXY;
begin // tdPointGen, tdPointEW, tdPointAir, tdPointASW
  aRec.OrderID    := OrdID_init_point;
  aRec.OrderType  := byte(tdPointAir);
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  TDCInterface.SetInitPoint(aRec, TDCInterface.HaveToSend );
end;

procedure TfrmOwa_4.btnLINKPlusClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMLeft, true);
end;

procedure TfrmOwa_4.btnLINKMinClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMLeft, false);
end;

procedure TfrmOwa_4.btnASS_REMOTEClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignRemote(aRec);
end;

end.
