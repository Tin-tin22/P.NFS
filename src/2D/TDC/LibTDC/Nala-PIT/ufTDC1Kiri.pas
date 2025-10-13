unit ufTDC1Kiri;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Buttons, SpeedButtonImage, ufQEK, uLibTDCClass,
  ExtCtrls, RzBmpBtn;

type
  TfrmTDC1Kiri = class(TfrmQEK)
    Label1: TLabel;
    spbAssignASRL: TSpeedButtonImage;
    Label24: TLabel;
    spbDeAssignASRL: TSpeedButtonImage;
    Label29: TLabel;
    spbSetInitDatum: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    GroupBox1: TGroupBox;
    spbSetAssignTorpedoMk44: TSpeedButtonImage;
    Label13: TLabel;
    Label15: TLabel;
    spbAssignTorpedoA244: TSpeedButtonImage;
    spbIdentNonSubmarine: TSpeedButtonImage;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    spbIdentFriendly: TSpeedButtonImage;
    spbIdentHostile: TSpeedButtonImage;
    Label14: TLabel;
    Label18: TLabel;
    spbIdentUnknown: TSpeedButtonImage;
    Label25: TLabel;
    SpeedButtonImage11: TSpeedButtonImage;
    Label5: TLabel;
    spbWipeLeft: TSpeedButtonImage;
    GroupBox3: TGroupBox;
    spbFOCPlus: TSpeedButtonImage;
    spbFOCMinus: TSpeedButtonImage;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    spbSetDeAssignTorpedo: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage13: TSpeedButtonImage;
    Label6: TLabel;
    Label4: TLabel;
    Image1: TImage;
    procedure spbIdentFriendlyClick(Sender: TObject);
    procedure spbIdentHostileClick(Sender: TObject);
    procedure spbIdentNonSubmarineClick(Sender: TObject);
    procedure spbIdentUnknownClick(Sender: TObject);
    procedure spbSetInitDatumClick(Sender: TObject);
    procedure spbFOCPlusClick(Sender: TObject);
    procedure spbFOCMinusClick(Sender: TObject);
    procedure spbAssignASRLClick(Sender: TObject);
    procedure spbDeAssignASRLClick(Sender: TObject);
    procedure spbWipeLeftClick(Sender: TObject);
    procedure spbSetAssignTorpedoMk44Click(Sender: TObject);
    procedure spbSetDeAssignTorpedoClick(Sender: TObject);
    procedure spbAssignTorpedoA244Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure SpeedButtonImage11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
 //   TDCInterface : TGenericTDCInterface;
     procedure LoadImageList; override;

  end;


implementation

uses
  uBaseConstan,  uTCPDataType, uBaseFunction, ASRLRCU, uLibTDC_Nala;

{$R *.dfm}

procedure TfrmTDC1Kiri.spbIdentFriendlyClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_Friendly);
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kiri.spbIdentHostileClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_Hostile);
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kiri.spbIdentUnknownClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_Unknown);
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kiri.spbIdentNonSubmarineClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_NonSub);
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kiri.spbSetInitDatumClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  aRec.OrderID := 255;
  TDCInterface.SetInitDatum(aRec,
    TDCInterface.HaveToSend );
end;

procedure TfrmTDC1Kiri.spbFOCPlusClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  TDCInterface.setFOCplus(aRec, TDCInterface.HaveToSend);
end;

{var aRec: TRecOrder;
begin
  TDCInterface.setFOCplus(aRec, TDCInterface.HaveToSend);
end;
}
procedure TfrmTDC1Kiri.spbFOCMinusClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  TDCInterface.setFOCMinus(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC1Kiri.spbAssignASRLClick(Sender: TObject);
var aRec: TRecTrackOrder;
r,b : Single;
begin
inherited;
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
// TDCInterface.SetAssign_FC(5, TDCInterface.OBMLeft.Center);     // create FC

  TDCInterface.setAssignASRL(aRec, 4, TDCInterface.HaveToSend);  // procedure lawas asli

//(TDCInterface as TTDC_NalaInterface).setAssignASRLToFC5(aRec, 4);       // (Misssile Type 4)
end;

procedure TfrmTDC1Kiri.tmr1Timer(Sender: TObject);
begin
//inherited;
end;

procedure TfrmTDC1Kiri.spbDeAssignASRLClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
inherited;
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.setDeAssignASRL(aRec, TDCInterface.HaveToSend);
  spbAssignASRL.Down := False;
end;

procedure TfrmTDC1Kiri.spbWipeLeftClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;
  TDCInterface.setDeAssignASRL(aRec, TDCInterface.HaveToSend);
  TDCInterface.WipeOnLeftOBM;
  (TDCInterface as TTDC_NalaInterface).SendEvenAsroc(3);
end;

procedure TfrmTDC1Kiri.SpeedButtonImage11Click(Sender: TObject);
begin
  //inherited;
  TDCInterface.SetHoldFire_FC(5);
end;

procedure TfrmTDC1Kiri.spbSetAssignTorpedoMk44Click(Sender: TObject);
var
  aRec: TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.SetAssignTorpedo_MK44(aRec);
end;

procedure TfrmTDC1Kiri.spbSetDeAssignTorpedoClick(Sender: TObject);
begin
  TDCInterface.SetDeAssignTorpedo();
end;

procedure TfrmTDC1Kiri.spbAssignTorpedoA244Click(Sender: TObject);
var
  aRec: TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.SetAssignTorpedo_MK44(aRec);
end;

procedure TfrmTDC1Kiri.LoadImageList;
begin
  ilOrangeBox.Height := 55;
  ilOrangeBox.Width  := 220;

  LoadImageFile(image_path+'tdc\orangeBOX_4.bmp', ilOrangeBox );
end;

procedure TfrmTDC1Kiri.FormCreate(Sender: TObject);
var i: integer;
begin
  inherited;
  SetSpeedButtonGlyphNumber(4);

 //Screen.Cursor := crNone;

end;

end.
