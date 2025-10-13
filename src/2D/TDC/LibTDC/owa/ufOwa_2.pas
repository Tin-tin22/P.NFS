unit ufOwa_2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_2 = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnCEASE: TSpeedButtonImage;
    btnENG: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnFC1: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    btnNONSUB: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButtonImage8: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    Label8: TLabel;
    btnTRRVEng: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    btnREVFRND: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure btnCEASEClick(Sender: TObject);
    procedure btnFC1Click(Sender: TObject);
    procedure btnNONSUBClick(Sender: TObject);
    procedure btnTRRVEngClick(Sender: TObject);
    procedure btnREVFRNDClick(Sender: TObject);
  private
    { Private declarations }
    ShowFriend : boolean;
  public
    { Public declarations }
  end;

var
  frmOwa_2: TfrmOwa_2;

implementation

uses uTDCConstan, uTCPDataType;

{$R *.dfm}

procedure TfrmOwa_2.btnCEASEClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderType := Byte(teCeaseEngage);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_2.btnFC1Click(Sender: TObject);
begin
    TDCInterface.SetAssign_FC(1,  TDCInterface.OBMRight.Center);
end;

procedure TfrmOwa_2.btnNONSUBClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_NonSub);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_2.btnTRRVEngClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderType := Byte(teTrialReview);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_2.btnREVFRNDClick(Sender: TObject);
begin
ShowFriend := not ShowFriend;
  TDCInterface.ReviewFriend_OWA(ShowFriend);
end;

end.
