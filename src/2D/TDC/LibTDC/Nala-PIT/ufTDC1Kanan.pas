unit ufTDC1Kanan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Buttons, SpeedButtonImage, ufQEK, uLibTDCClass,
  ExtCtrls;

type
  TfrmTDC1Kanan = class(TfrmQEK) 
    Label1: TLabel;
    spbNextTrack: TSpeedButtonImage;
    Label24: TLabel;
    spbCorrect: TSpeedButtonImage;
    Label29: TLabel;
    spbInitiateRAM: TSpeedButtonImage;
    Label10: TLabel;
    spbAssignRAM: TSpeedButtonImage;
    Label2: TLabel;
    spbCursorMin: TSpeedButtonImage;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    SpeedButtonImage20: TSpeedButtonImage;
    Label13: TLabel;
    Label15: TLabel;
    SpeedButtonImage19: TSpeedButtonImage;
    spbIdentHelicopter: TSpeedButtonImage;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    spbIdentFriendly: TSpeedButtonImage;
    spbIdentHostile: TSpeedButtonImage;
    Label14: TLabel;
    Label18: TLabel;
    spbIdentUnknown: TSpeedButtonImage;
    Label25: TLabel;
    Label4: TLabel;
    spbCloseControl: TSpeedButtonImage;
    Label5: TLabel;
    spbWipe: TSpeedButtonImage;
    Label7: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    SpeedButtonImage1: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image1: TImage;
    procedure spbInitiateRAMClick(Sender: TObject);
    procedure spbIdentFriendlyClick(Sender: TObject);
    procedure spbIdentHostileClick(Sender: TObject);
    procedure spbIdentUnknownClick(Sender: TObject);
    procedure spbIdentHelicopterClick(Sender: TObject);
    procedure spbCorrectClick(Sender: TObject);
    procedure spbNextTrackClick(Sender: TObject);
    procedure spbWipeClick(Sender: TObject);
    procedure spbCloseControlClick(Sender: TObject);
    procedure spbAssignRAMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbCursorMinClick(Sender: TObject);
  private
  public
     procedure LoadImageList; override;
  end;


implementation
uses
  uBaseConstan, uTCPDataType;
{$R *.dfm}

procedure TfrmTDC1Kanan.spbInitiateRAMClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.TrackNumber := 255;
//  aRec.OrderType := C_OrdType_RAM_atasair;
  aRec.OrderType := byte(ID_AtasAir_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbIdentFriendlyClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Friendly);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbIdentHostileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
//  aRec.TrackNumber  := 255;
//  aRec.Ship_TID     := 255;
//
//  TDCInterface.OBMRight_SetIdentAtasAir(aRec, TDCInterface.HaveToSend);
  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbIdentUnknownClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
//  aRec.TrackNumber  := 255;
//  aRec.Ship_TID     := 255;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbIdentHelicopterClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Helicopter);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
//  aRec.TrackNumber  := 255;
//  aRec.Ship_TID     := 255;
//  TDCInterface.OBMRight_SetIdentAtasAir(aRec, TDCInterface.HaveToSend);
  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbCorrectClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM(tdAtasAir, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kanan.spbNextTrackClick(Sender: TObject);
begin
  TDCInterface.SetOBMRightPos_NextTrack_AtasAir;

end;

procedure TfrmTDC1Kanan.spbWipeClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfrmTDC1Kanan.spbCloseControlClick(Sender: TObject);
begin
  TDCInterface.CloseControl(tdAtasAir);
end;

procedure TfrmTDC1Kanan.spbAssignRAMClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRAM(aRec);
end;

procedure TfrmTDC1Kanan.FormCreate(Sender: TObject);
begin
  inherited;
  SetSpeedButtonGlyphNumber(4);
end;


procedure TfrmTDC1Kanan.LoadImageList;
begin
  ilOrangeBox.Height := 55;
  ilOrangeBox.Width  := 220;

  LoadImageFile(image_path+'tdc\orangeBOX_4.bmp', ilOrangeBox );

end;

procedure TfrmTDC1Kanan.spbCursorMinClick(Sender: TObject);
begin
//  inherited;
  TDCInterface.DelCursorFix(TDCInterface.OBMRight.Center);
end;

end.
