unit ufOwa_8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_8 = class(TfrmQEK)
    Panel1: TPanel;
    btnINIT_SURF: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btmWIPE: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    btnCPA: TSpeedButtonImage;
    btnINT_CHANGE: TSpeedButtonImage;
    btnLINKPlus: TSpeedButtonImage;
    btnLINKMin: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnASS_LOCRT: TSpeedButtonImage;
    btnASS_LOCNRT: TSpeedButtonImage;
    btnASS_REMOTE: TSpeedButtonImage;
    btnCOR_DECOR: TSpeedButtonImage;
    Label8: TLabel;
    btnSEQ: TSpeedButtonImage;
    btnCORR: TSpeedButtonImage;
    btnREPOS: TSpeedButtonImage;
    btnCLOSE_CONTROL: TSpeedButtonImage;
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
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    procedure btnINIT_SURFClick(Sender: TObject);
    procedure btmWIPEClick(Sender: TObject);
    procedure btnCLOSE_CONTROLClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnASS_LOCRTClick(Sender: TObject);
    procedure btnASS_LOCNRTClick(Sender: TObject);
    procedure btnINT_CHANGEClick(Sender: TObject);
    procedure btnSEQClick(Sender: TObject);
    procedure btnLINKPlusClick(Sender: TObject);
    procedure btnLINKMinClick(Sender: TObject);
    procedure btnCOR_DECORClick(Sender: TObject);
    procedure btnASS_REMOTEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses
  uBaseConstan, uTCPDataType, uLibTDCClass;

{$R *.dfm}

procedure TfrmOwa_8.btnINIT_SURFClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitSurf, TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btmWIPEClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfrmOwa_8.btnCLOSE_CONTROLClick(Sender: TObject);
begin
  TDCInterface.CloseControl_OWA(TDCInterface.OBMRight.Center);
end;

procedure TfrmOwa_8.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btnASS_LOCRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocRT(aRec);
end;

procedure TfrmOwa_8.btnASS_LOCNRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocNRT(aRec);
end;

procedure TfrmOwa_8.btnINT_CHANGEClick(Sender: TObject);
begin
  TDCInterface.SwitchTrackPosition(TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btnSEQClick(Sender: TObject);
begin
  TDCInterface.SetOBM_NextTrack_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btnLINKPlusClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, true);
end;

procedure TfrmOwa_8.btnLINKMinClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, false);
end;

procedure TfrmOwa_8.btnCOR_DECORClick(Sender: TObject);
begin
  TDCInterface.CorrelateOrDecorelateTrack(TDCInterface.OBMRight);
end;

procedure TfrmOwa_8.btnASS_REMOTEClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRemote(aRec);
end;

end.
