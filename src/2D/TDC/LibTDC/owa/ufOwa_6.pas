unit ufOwa_6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_6 = class(TfrmQEK)
    Panel1: TPanel;
    btnINITAIR: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnWIPETrack: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    btnLINKPLUS: TSpeedButtonImage;
    btnLINKMIN: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnAssLocRT: TSpeedButtonImage;
    btnAssLocNRT: TSpeedButtonImage;
    btnAssRemote: TSpeedButtonImage;
    btnCORDECOR: TSpeedButtonImage;
    Label8: TLabel;
    btnSEQ: TSpeedButtonImage;
    btnCORR: TSpeedButtonImage;
    btnREPOS: TSpeedButtonImage;
    btnCLOSECTRL: TSpeedButtonImage;
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
    procedure btnINITAIRClick(Sender: TObject);
    procedure btnWIPETrackClick(Sender: TObject);
    procedure btnAssLocRTClick(Sender: TObject);
    procedure btnCLOSECTRLClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
    procedure btnAssLocNRTClick(Sender: TObject);
    procedure btnSEQClick(Sender: TObject);
    procedure btnLINKPLUSClick(Sender: TObject);
    procedure btnLINKMINClick(Sender: TObject);
    procedure btnCORDECORClick(Sender: TObject);
    procedure btnAssRemoteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmOwa_6: TfrmOwa_6;

implementation

uses
  uBaseConstan, uTCPDataType, uLibTDCClass;

{$R *.dfm}

procedure TfrmOwa_6.btnINITAIRClick(Sender: TObject);
begin
  TDCInterface.InitiateTrack(InitAir, TDCInterface.OBMRight);
end;

procedure TfrmOwa_6.btnWIPETrackClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfrmOwa_6.btnAssLocRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocRT(aRec);
end;

procedure TfrmOwa_6.btnCLOSECTRLClick(Sender: TObject);
begin
  TDCInterface.CloseControl_OWA(TDCInterface.OBMRight.Center);
end;

procedure TfrmOwa_6.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_6.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_6.btnAssLocNRTClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignLocNRT(aRec);
end;

procedure TfrmOwa_6.btnSEQClick(Sender: TObject);
begin
  TDCInterface.SetOBM_NextTrack_OWA(TDCInterface.OBMRight);
end;

procedure TfrmOwa_6.btnLINKPLUSClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, true);
end;

procedure TfrmOwa_6.btnLINKMINClick(Sender: TObject);
begin
  TDCInterface.SendLink_OWA(TDCInterface.OBMRight, false);
end;

procedure TfrmOwa_6.btnCORDECORClick(Sender: TObject);
begin
  TDCInterface.CorrelateOrDecorelateTrack(TDCInterface.OBMRight);
end;

procedure TfrmOwa_6.btnAssRemoteClick(Sender: TObject);
var aRec: TRecXXXOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRemote(aRec);
end;

end.
