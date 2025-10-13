unit ufTDCKanan_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ufQEK,
  Dialogs, StdCtrls, Buttons, SpeedButtonImage, ImgList, ExtCtrls, uLibTDCClass;

type
  TfrmTDCKanan_Rencong = class(TfrmQEK)
    spbIdentUnknownUdara: TSpeedButtonImage;
    spbidentUdaraHostile: TSpeedButtonImage;
    spbIdentAtasAirHostile: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    spbIdentUdaraFriendly: TSpeedButtonImage;
    spbIdentAtasAirFriendly: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    spbNextTrack: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    spbCorrect: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    procedure FormCreate(Sender: TObject);
    procedure spbIdentUnknownUdaraClick(Sender: TObject);
    procedure spbidentUdaraHostileClick(Sender: TObject);
    procedure spbIdentAtasAirHostileClick(Sender: TObject);
    procedure spbIdentUdaraFriendlyClick(Sender: TObject);
    procedure spbIdentAtasAirFriendlyClick(Sender: TObject);
    procedure spbNextTrackClick(Sender: TObject);
    procedure spbCorrectClick(Sender: TObject);
    procedure SpeedButtonImage16Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
}
implementation

uses
  uTCPDataType, uBaseConstan;

{$R *.dfm}


procedure TfrmTDCKanan_Rencong.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmTDCKanan_Rencong.spbIdentUnknownUdaraClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.TrackNumber := 255;

  if TDCInterface.IsHitTrack(TDCInterface.OBMRight.Center) then
    TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend)
  else
    TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDCKanan_Rencong.spbidentUdaraHostileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_udara_hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.TrackNumber := 255;

  if TDCInterface.IsHitTrack(TDCInterface.OBMRight.Center) then
    TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend)
  else
    TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;


procedure TfrmTDCKanan_Rencong.spbIdentAtasAirHostileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.TrackNumber := 255;

  if TDCInterface.IsHitTrack(TDCInterface.OBMRight.Center) then
    TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend)
  else
    TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDCKanan_Rencong.spbIdentUdaraFriendlyClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Udara_friendly);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  aRec.TrackNumber := 255;

  if TDCInterface.IsHitTrack(TDCInterface.OBMRight.Center) then
    TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend)
  else
    TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDCKanan_Rencong.spbIdentAtasAirFriendlyClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_friendly);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  aRec.TrackNumber := 255;

  if TDCInterface.IsHitTrack(TDCInterface.OBMRight.Center) then
    TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend)
  else
    TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
//  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDCKanan_Rencong.spbNextTrackClick(Sender: TObject);
begin
//  inherited;
  TDCInterface.SetOBMPos_NextTrack;

end;

procedure TfrmTDCKanan_Rencong.spbCorrectClick(Sender: TObject);
begin
//  inherited;
  TDCInterface.CorrectRAM(tdDontCare);

end;

procedure TfrmTDCKanan_Rencong.SpeedButtonImage16Click(Sender: TObject);
begin
//  inherited;
  TDCInterface.WipeOnRightOBM;
end;

end.
