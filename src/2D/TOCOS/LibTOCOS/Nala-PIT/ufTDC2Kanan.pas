unit ufTDC2Kanan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Buttons, SpeedButtonImage, StdCtrls, uLibTDCClass, ufQEK;

type
  TfrmTDC2Kanan = class(TfrmQEK)
    Label1: TLabel;
    SpeedButtonImage9: TSpeedButtonImage;
    Label24: TLabel;
    spbCorrect: TSpeedButtonImage;
    Label29: TLabel;
    spbInitRAM: TSpeedButtonImage;
    Label10: TLabel;
    spbAssignRAMTrack: TSpeedButtonImage;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    spbInitESMFix: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    Label16: TLabel;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    spbDataLinkPlus: TSpeedButtonImage;
    Label13: TLabel;
    Label15: TLabel;
    spbDataLinkMin: TSpeedButtonImage;
    spbIdentMissile: TSpeedButtonImage;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    spbIdentFriendly: TSpeedButtonImage;
    spbSetIdentHostile: TSpeedButtonImage;
    Label14: TLabel;
    Label18: TLabel;
    spbUdaraUnknown: TSpeedButtonImage;
    Label25: TLabel;
    Label4: TLabel;
    spbCloseControl: TSpeedButtonImage;
    Label5: TLabel;
    spbWipe: TSpeedButtonImage;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    procedure spbInitRAMClick(Sender: TObject);
    procedure spbCorrectClick(Sender: TObject);
    procedure spbIdentFriendlyClick(Sender: TObject);
    procedure spbSetIdentHostileClick(Sender: TObject);
    procedure spbUdaraUnknownClick(Sender: TObject);
    procedure spbIdentMissileClick(Sender: TObject);
    procedure spbCloseControlClick(Sender: TObject);
    procedure spbWipeClick(Sender: TObject);
    procedure spbInitESMFixClick(Sender: TObject);
    procedure spbAssignRAMTrackClick(Sender: TObject);
    procedure spbDataLinkPlusClick(Sender: TObject);
    procedure spbDataLinkMinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonImage4Click(Sender: TObject);
    procedure SpeedButtonImage9Click(Sender: TObject);
  private

  public

     procedure LoadImageList; override;
  end;


implementation

uses
  uBaseConstan, uTCPDataType;

{$R *.dfm}


procedure TfrmTDC2Kanan.spbInitRAMClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
//  aRec.OrderID := 0;
  aRec.TrackNumber := 255;

//  aRec.OrderType := C_OrdType_RAM_Udara;
  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec);
end;

procedure TfrmTDC2Kanan.spbCorrectClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM(tdUdara);
end;

procedure TfrmTDC2Kanan.spbIdentFriendlyClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_udara_Friendly);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kanan.spbSetIdentHostileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Udara_Hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kanan.spbUdaraUnknownClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kanan.spbIdentMissileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Rudal);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kanan.spbCloseControlClick(Sender: TObject);
begin
  TDCInterface.CloseControl(tdUdara);
end;

procedure TfrmTDC2Kanan.spbWipeClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfrmTDC2Kanan.spbInitESMFixClick(Sender: TObject);
var aRec : TRecOrderXY;
begin
  aRec.OrderType := byte(ID_Rudal);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.SetInitESMFix(aRec);
end;

procedure TfrmTDC2Kanan.spbAssignRAMTrackClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRAM(aRec);
end;

procedure TfrmTDC2Kanan.spbDataLinkPlusClick(Sender: TObject);
begin
 //
end;

procedure TfrmTDC2Kanan.spbDataLinkMinClick(Sender: TObject);
begin
//
end;

procedure TfrmTDC2Kanan.LoadImageList;
begin
  ilOrangeBox.Height := 55;
  ilOrangeBox.Width  := 220;

  LoadImageFile(image_path+'tdc\orangeBOX_4.bmp', ilOrangeBox );

end;

procedure TfrmTDC2Kanan.FormCreate(Sender: TObject);
begin
  inherited;
  SetSpeedButtonGlyphNumber(4);

end;

procedure TfrmTDC2Kanan.SpeedButtonImage4Click(Sender: TObject);
begin
  TDCInterface.DelCursorFix(TDCInterface.OBMRight.Center);

end;

procedure TfrmTDC2Kanan.SpeedButtonImage9Click(Sender: TObject);
begin
  TDCInterface.SetOBMRightPos_NextTrack_Udara;

end;

end.
