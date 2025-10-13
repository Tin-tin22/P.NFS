unit ufOwa_3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, ImgList, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls;

type
  TfrmOwa_3 = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage19: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnCEASE_ENG: TSpeedButtonImage;
    btnENG: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnFC1: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    btnTRRV_ENG: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnFC2: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    btnSEQ_TGT: TSpeedButtonImage;
    btnSEQ_WPN: TSpeedButtonImage;
    Label8: TLabel;
    btnFC3: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    btnREVIEW_FRND: TSpeedButtonImage;
    btnRESET_SEQ: TSpeedButtonImage;
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
    procedure btnFC1Click(Sender: TObject);
    procedure btnFC2Click(Sender: TObject);
    procedure btnFC3Click(Sender: TObject);
    procedure btnTRRV_ENGClick(Sender: TObject);
    procedure btnENGClick(Sender: TObject);
    procedure btnCEASE_ENGClick(Sender: TObject);
    procedure btnREVIEW_FRNDClick(Sender: TObject);
  private
    { Private declarations }
    ShowFriend : boolean;
  public
    { Public declarations }
  end;

//var
//  frmOwa_3: TfrmOwa_3;

implementation

uses
  uBaseConstan, uTCPDataType, uTDCConstan;

{$R *.dfm}

procedure TfrmOwa_3.btnFC1Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(1,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_3.btnFC2Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(2, TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_3.btnFC3Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(3, TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_3.btnTRRV_ENGClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderType := Byte(teTrialReview);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_3.btnENGClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderType := Byte(teEngage);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_3.btnCEASE_ENGClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderType := Byte(teCeaseEngage);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_3.btnREVIEW_FRNDClick(Sender: TObject);
begin
  ShowFriend := not ShowFriend;
  TDCInterface.ReviewFriend_OWA(ShowFriend);
end;

end.
