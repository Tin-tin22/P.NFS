unit ufTDCkanan_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, Buttons, SpeedButtonImage,  ufQEK, uLibTDCClass;

type
  TfTDCKanan_Singa = class(TfrmQEK)
    GroupBox1: TGroupBox;
    spbInitAuto_Air: TSpeedButtonImage;
    spbInitRAM_air: TSpeedButtonImage;
    spbInitDR_Air: TSpeedButtonImage;
    spbInitRP: TSpeedButtonImage;
    spbInitDatum: TSpeedButtonImage;
    spbInitAuto_Surf: TSpeedButtonImage;
    spbInitRAM_Surf: TSpeedButtonImage;
    spbInitDR_Surf: TSpeedButtonImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    spbAssign_Auto: TSpeedButtonImage;
    spbAssign_RAM: TSpeedButtonImage;
    spbAssign_DR: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    spbNextTrack: TSpeedButtonImage;
    spbCorrect: TSpeedButtonImage;
    spbCloseControl: TSpeedButtonImage;
    Bevel4: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    spbIdentFriendly: TSpeedButtonImage;
    spbIdentHostile: TSpeedButtonImage;
    spbIdentUnknown: TSpeedButtonImage;
    spbIdentHeli: TSpeedButtonImage;
    spbNonSUB: TSpeedButtonImage;
    spbMissile: TSpeedButtonImage;
    spbBackTrackPlus: TSpeedButtonImage;
    spbBackTrackMinus: TSpeedButtonImage;
    Bevel5: TBevel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label24: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    spbESMFix: TSpeedButtonImage;
    spbESMFolTrack: TSpeedButtonImage;
    spbIFFActive: TSpeedButtonImage;
    spbFOCPlus: TSpeedButtonImage;
    spbFOCMin: TSpeedButtonImage;
    spbCursorPlus: TSpeedButtonImage;
    spbCursorMin: TSpeedButtonImage;
    spbWipe: TSpeedButtonImage;
    Bevel6: TBevel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Bevel7: TBevel;
    ilOrange: TImageList;
    procedure spbInitRAM_airClick(Sender: TObject);
    procedure spbInitAuto_AirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbInitDR_AirClick(Sender: TObject);
    procedure spbInitRPClick(Sender: TObject);
    procedure spbInitDatumClick(Sender: TObject);
    procedure spbInitAuto_SurfClick(Sender: TObject);
    procedure spbInitRAM_SurfClick(Sender: TObject);
    procedure spbInitDR_SurfClick(Sender: TObject);
    procedure spbIdentFriendlyClick(Sender: TObject);
    procedure spbIdentHostileClick(Sender: TObject);
    procedure spbIdentUnknownClick(Sender: TObject);
    procedure spbIdentHeliClick(Sender: TObject);
    procedure spbNonSUBClick(Sender: TObject);
    procedure spbMissileClick(Sender: TObject);
    procedure spbFOCPlusClick(Sender: TObject);
    procedure spbFOCMinClick(Sender: TObject);
    procedure spbWipeClick(Sender: TObject);
    procedure spbNextTrackClick(Sender: TObject);
    procedure spbCorrectClick(Sender: TObject);
    procedure spbCloseControlClick(Sender: TObject);
    procedure spbCursorPlusClick(Sender: TObject);
    procedure spbCursorMinClick(Sender: TObject);
    procedure spbAssign_AutoClick(Sender: TObject);
    procedure spbAssign_RAMClick(Sender: TObject);
    procedure spbAssign_DRClick(Sender: TObject);
    procedure spbBackTrackPlusClick(Sender: TObject);
    procedure spbBackTrackMinusClick(Sender: TObject);
    procedure spbESMFixClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;


implementation

uses
  uBaseConstan, uTCPDataType;

{$R *.dfm}
const IMAGES_PATH  = 'images/tdc/';

procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TfTDCKanan_Singa.FormCreate(Sender: TObject);
begin
  inherited;
//
end;

///=======================================================================
// button event

procedure TfTDCKanan_Singa.spbInitAuto_AirClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin         // init auto udara
  aRec.TrackNumber := 255;
  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateAuto(aRec, TDCInterface.HaveToSend );
end;

procedure TfTDCKanan_Singa.spbInitRAM_airClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin         // init ram udara
  aRec.TrackNumber := 255;

  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend );
end;



procedure TfTDCKanan_Singa.spbInitDR_AirClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin         // init DR udara
  aRec.TrackNumber := 255;
  aRec.OrderType := byte(ID_Udara_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateDR(aRec, TDCInterface.HaveToSend );
end;

procedure TfTDCKanan_Singa.spbInitRPClick(Sender: TObject);
begin
//  inherited;
  TDCInterface.InitiateRefPos(TDCInterface.OBMRight.mPos.X,
   TDCInterface.OBMRight.mPos.Y, TDCInterface.GetLastTrackID(tdRP));
end;

procedure TfTDCKanan_Singa.spbInitDatumClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;
  aRec.OrderID := 255;
  TDCInterface.SetInitDatum(aRec,
    TDCInterface.HaveToSend );
end;

procedure TfTDCKanan_Singa.spbInitAuto_SurfClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin         // init auto surf

  aRec.TrackNumber := 255;
  aRec.OrderType := byte(ID_atasair_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateAuto(aRec, TDCInterface.HaveToSend );
end;

procedure TfTDCKanan_Singa.spbInitRAM_SurfClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.TrackNumber := 255;

  aRec.OrderType := byte(ID_AtasAir_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbInitDR_SurfClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin         // init

  aRec.TrackNumber := 255;
  aRec.OrderType := byte(ID_atasair_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateDR(aRec, TDCInterface.HaveToSend );
end;

procedure TfTDCKanan_Singa.spbIdentFriendlyClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Friendly);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbIdentHostileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Hostile);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbIdentUnknownClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbIdentHeliClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_AtasAir_Helicopter);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbNonSUBClick(Sender: TObject);
var aRec: TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_BawahAir_NonSub);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbMissileClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderType := byte(ID_Rudal);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.Change_Ident(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbFOCPlusClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  TDCInterface.setFOCplus(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbFOCMinClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  TDCInterface.setFOCMinus(aRec, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbWipeClick(Sender: TObject);
begin
  TDCInterface.WipeOnRightOBM;
end;

procedure TfTDCKanan_Singa.spbNextTrackClick(Sender: TObject);
begin
  TDCInterface.SetOBMPos_NextTrack;
end;

procedure TfTDCKanan_Singa.spbCorrectClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM(tdDontCare, TDCInterface.HaveToSend);
end;

procedure TfTDCKanan_Singa.spbCloseControlClick(Sender: TObject);
begin
  TDCInterface.CloseControl(tdDontCare);
end;

procedure TfTDCKanan_Singa.spbCursorPlusClick(Sender: TObject);
begin
  TDCInterface.AddCursorFix;
end;

procedure TfTDCKanan_Singa.spbCursorMinClick(Sender: TObject);
begin
  TDCInterface.DelCursorFix(TDCInterface.OBMRight.Center);
end;

procedure TfTDCKanan_Singa.spbAssign_AutoClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignAuto(aRec);
end;

procedure TfTDCKanan_Singa.spbAssign_RAMClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignRAM(aRec);
end;

procedure TfTDCKanan_Singa.spbAssign_DRClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.AssignDR(aRec);
end;

procedure TfTDCKanan_Singa.spbBackTrackPlusClick(Sender: TObject);
begin
//  inherited;

  TDCInterface.SetBackTrackOnPos(True,
    TDCInterface.OBMRight.Center.X, TDCInterface.OBMRight.Center.Y);

end;

procedure TfTDCKanan_Singa.spbBackTrackMinusClick(Sender: TObject);
begin
//  inherited;
  TDCInterface.SetBackTrackOnPos(false,
    TDCInterface.OBMRight.Center.X, TDCInterface.OBMRight.Center.Y);

end;

procedure TfTDCKanan_Singa.spbESMFixClick(Sender: TObject);
var aRec : TRecOrderXY;
begin
  aRec.OrderType := byte(ID_Rudal);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.SetInitESMFix(aRec);
end;

end.
