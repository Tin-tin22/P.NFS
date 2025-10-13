unit ufOwa_1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, Buttons, SpeedButtonImage, ExtCtrls, ImgList, StdCtrls;

type
  TfrmOwa_1 = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnCeaseEngage: TSpeedButtonImage;
    btnEngage: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    btnNonSub: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnTREngage: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    btnClearIFF: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    btnReviewFRND: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure btnTREngageClick(Sender: TObject);
    procedure btnCeaseEngageClick(Sender: TObject);
    procedure btnEngageClick(Sender: TObject);
    procedure btnNonSubClick(Sender: TObject);
    procedure SpeedButtonImage7Click(Sender: TObject);
    procedure btnReviewFRNDClick(Sender: TObject);
  private
    { Private declarations }
    ShowFriend: boolean;
  public
    { Public declarations }
  end;

{var
  frmOwa_1: TfrmOwa_1;
 }
implementation

uses uTDCConstan, uTCPDataType;

{$R *.dfm}

procedure TfrmOwa_1.btnTREngageClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderType := Byte(teTrialReview);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_1.btnCeaseEngageClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderType := Byte(teCeaseEngage);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_1.btnEngageClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin // ass engagebox

  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderType := Byte(teEngage);

  TDCInterface.SetHarpoonEngage(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_1.btnNonSubClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_NonSub);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_1.SpeedButtonImage7Click(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_1.btnReviewFRNDClick(Sender: TObject);
begin
  ShowFriend := not ShowFriend;
  TDCInterface.ReviewFriend_OWA(ShowFriend);
end;

end.
