unit ufOwa_7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_7 = class(TfrmQEK)
    Panel1: TPanel;
    btnINIT_SUBSRT: TSpeedButtonImage;
    btnINIT_ASWPOINT: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnWIPE: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    btnLOST: TSpeedButtonImage;
    btnCRS_SPD: TSpeedButtonImage;
    btnLINKPLUS: TSpeedButtonImage;
    btnLINKMIN: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnASS_LOCRT: TSpeedButtonImage;
    btnASS_LOCNRT: TSpeedButtonImage;
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
    Label6: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    btnASS_REMOTE: TSpeedButtonImage;
    procedure btnINIT_SUBSRTClick(Sender: TObject);
    procedure btnCLOSE_CONTROLClick(Sender: TObject);
    procedure btnWIPEClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
    procedure btnASS_LOCRTClick(Sender: TObject);
    procedure btnASS_LOCNRTClick(Sender: TObject);
    procedure btnINIT_ASWPOINTClick(Sender: TObject);
    procedure btnSEQClick(Sender: TObject);
    procedure btnLOSTClick(Sender: TObject);
    procedure btnLINKPLUSClick(Sender: TObject);
    procedure btnLINKMINClick(Sender: TObject);
    procedure btnCOR_DECORClick(Sender: TObject);
    procedure btnASS_REMOTEClick(Sender: TObject);
    procedure btnCRS_SPDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmOwa_7: TfrmOwa_7;

implementation
uses
  uBaseConstan, uTCPDataType, uLibTDCClass, Math;

{$R *.dfm}

procedure TfrmOwa_7.btnINIT_SUBSRTClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitSubRT, TDCInterface.OBMLeft);
end;

procedure TfrmOwa_7.btnCLOSE_CONTROLClick(Sender: TObject);
begin
  TDCInterface.CloseControl_OWA( TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_7.btnWIPEClick(Sender: TObject);
begin
  TDCInterface.WipeOnLeftOBM;
end;

procedure TfrmOwa_7.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_7.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_7.btnASS_LOCRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignLocRT(aRec);
end;

procedure TfrmOwa_7.btnASS_LOCNRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignLocNRT(aRec);
end;

procedure TfrmOwa_7.btnINIT_ASWPOINTClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderID := 255;
  TDCInterface.SetInitDatum(aRec, TDCInterface.HaveToSend );
end;

procedure TfrmOwa_7.btnSEQClick(Sender: TObject);
begin
  TDCInterface.SetOBM_NextTrack_OWA(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_7.btnLOSTClick(Sender: TObject);
var aRec: TRecFireControlOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.SetTrackInLostMode(aRec);
end;

procedure TfrmOwa_7.btnLINKPLUSClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMLeft, true);
end;

procedure TfrmOwa_7.btnLINKMINClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMLeft, false);
end;

procedure TfrmOwa_7.btnCOR_DECORClick(Sender: TObject);
begin
  TDCInterface.CorrelateOrDecorelateTrack(TDCInterface.OBMLeft);
end;

procedure TfrmOwa_7.btnASS_REMOTEClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.AssignRemote(aRec);
end;

procedure TfrmOwa_7.btnCRS_SPDClick(Sender: TObject);
var c, s: double;
begin
  TDCInterface.GetCourseSpeedSubTrack(TDCInterface.OBMLeft, c, s);
  //self.Text := 'course : ' + FloatToStr(Floor(c)) + '--- speed : ' + FloatToStr(Floor(s));
end;

end.
