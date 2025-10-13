unit ufTDCTengah_OWA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufTDCTengah, ImgList, Menus, OleCtrls, MapXLib_TLB, StdCtrls,
  VrDigit, VrControls, VrWheel, ExtCtrls, Buttons, SpeedButtonImage, Types;

type
  TfrmTDCTengah_OWA = class(TfrmTDCTengah)
    Panel2: TPanel;
    btnICM1_L: TSpeedButtonImage;
    btnICM2_L: TSpeedButtonImage;
    btnICM3_L: TSpeedButtonImage;
    Label40: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    btnICM4_L: TSpeedButtonImage;
    btnICM5_L: TSpeedButtonImage;
    btnICM6_L: TSpeedButtonImage;
    btnICM7_L: TSpeedButtonImage;
    btnICM8_L: TSpeedButtonImage;
    btnICM9_L: TSpeedButtonImage;
    btnICM10_L: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    btnDROBM_L: TSpeedButtonImage;
    btnOFFCent_L: TSpeedButtonImage;
    btnCent_L: TSpeedButtonImage;
    btnCUORoffCENT_L: TSpeedButtonImage;
    btnCUorCENT_L: TSpeedButtonImage;
    btnResetOBM_L: TSpeedButtonImage;
    btnDataReq_L: TSpeedButtonImage;
    Panel4: TPanel;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange4: TSpeedButtonImage;
    spbSetRange2: TSpeedButtonImage;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange64: TSpeedButtonImage;
    spbSetRange128: TSpeedButtonImage;
    spbSetRange256: TSpeedButtonImage;
    Panel5: TPanel;
    btnICM1_R: TSpeedButtonImage;
    btnICM2_R: TSpeedButtonImage;
    btnICM3_R: TSpeedButtonImage;
    Label23: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    btnICM4_R: TSpeedButtonImage;
    btnICM5_R: TSpeedButtonImage;
    btnICM6_R: TSpeedButtonImage;
    btnICM7_R: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    btnICM9_R: TSpeedButtonImage;
    SpeedButtonImage18: TSpeedButtonImage;
    btnDROCM_R: TSpeedButtonImage;
    btnDROBM_R: TSpeedButtonImage;
    btnOFFCent_R: TSpeedButtonImage;
    btnCENT_R: TSpeedButtonImage;
    btnCUORoffCENT_R: TSpeedButtonImage;
    btnCUorCENT_R: TSpeedButtonImage;
    btnResetOBM_R: TSpeedButtonImage;
    btnDataReq_R: TSpeedButtonImage;
    Panel6: TPanel;
    btnIFF: TSpeedButtonImage;
    btnVESTA: TSpeedButtonImage;
    btnLW03: TSpeedButtonImage;
    btnDALIN: TSpeedButtonImage;
    btnDALOG: TSpeedButtonImage;
    btnDAMTI: TSpeedButtonImage;
    btnDECCA: TSpeedButtonImage;
    SpeedButtonImage17: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    SpeedButtonImage28: TSpeedButtonImage;
    Panel7: TPanel;
    Panel9: TPanel;
    btnTM: TSpeedButtonImage;
    btnCUGEO: TSpeedButtonImage;
    ilWhite: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure spbSetRange256Click(Sender: TObject);
    procedure btnOFFCent_LClick(Sender: TObject);
    procedure btnCent_LClick(Sender: TObject);
    procedure btnResetOBM_LClick(Sender: TObject);
    procedure btnCUORoffCENT_LClick(Sender: TObject);
    procedure btnCUorCENT_LClick(Sender: TObject);
    procedure btnOFFCent_RClick(Sender: TObject);
    procedure btnCENT_RClick(Sender: TObject);
    procedure btnCUORoffCENT_RClick(Sender: TObject);
    procedure btnCUorCENT_RClick(Sender: TObject);
    procedure btnResetOBM_RClick(Sender: TObject);
    procedure btnDAMTIClick(Sender: TObject);
    procedure btnDALINClick(Sender: TObject);
    procedure btnDALOGClick(Sender: TObject);
    procedure btnLW03Click(Sender: TObject);
    procedure btnDECCAClick(Sender: TObject);
    procedure MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnVESTAClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure btnICM_LClick(Sender: TObject);
    procedure btnICM_RClick(Sender: TObject);
    procedure btnDataReq_LClick(Sender: TObject);
    procedure btnDataReq_RClick(Sender: TObject);
    procedure btnDROCM_RClick(Sender: TObject);
    procedure btnDROBM_RClick(Sender: TObject);
    procedure btnDROBM_LClick(Sender: TObject);

  private
    DRClick_R, DRClick_L :Byte;
  public
    { Public declarations }
    procedure Reset_Scale_Button;
    procedure Reset_RadarSelect_Button;

  end;


implementation

uses Math, uBaseConstan, uLibRAdar, uLibTDCClass, uTDCConstan,
      ufTDCTengahBawah_OWA;

{$R *.dfm}

procedure TfrmTDCTengah_OWA.FormCreate(Sender: TObject);
begin
  inherited;

  FCoverVisible := TRUE;

  SetRegionCircle;

  spbSetRange2.Tag    := 2;

  spbSetRange4.Tag    := 4;

  spbSetRange8.Tag    := 8;

  spbSetRange16.Tag   := 16;

  spbSetRange32.Tag   := 32;

  spbSetRange64.Tag   := 64;

  spbSetRange128.Tag  := 128;

  spbSetRange256.Tag  := 256;
  DRClick_R := 0;
  DRClick_L := 0;
end;



procedure TfrmTDCTengah_OWA.Reset_Scale_Button;
begin
   spbSetRange2.ImageIndex := 0;
   spbSetRange4.ImageIndex := 0;
   spbSetRange8.ImageIndex := 0;
   spbSetRange16.ImageIndex := 0;
   spbSetRange32.ImageIndex := 0;
   spbSetRange64.ImageIndex := 0;
   spbSetRange128.ImageIndex  := 0;
   spbSetRange256.ImageIndex  := 0;

end;

procedure TfrmTDCTengah_OWA.Reset_RadarSelect_Button;
begin
  btnIFF.ImageIndex := 0;
  btnVESTA.ImageIndex := 0;
  btnLW03.ImageIndex := 0;
  btnDALIN.ImageIndex := 0;
  btnDALOG.ImageIndex := 0;
  btnDAMTI.ImageIndex := 0;
  btnDECCA.ImageIndex := 0;
end;

procedure TfrmTDCTengah_OWA.spbSetRange256Click(Sender: TObject);
var
  Ob : TSpeedButtonImage;
begin
  Ob := (Sender As TSpeedButtonImage);
  TDCInterface.SetView_RangeScale(ob.Tag);
  Reset_Scale_Button;
  ob.ImageIndex := 1;
  rData.Step := ob.Tag  / 100;
end;

procedure TfrmTDCTengah_OWA.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnOFFCent_L.ImageIndex := 1;
  btnCent_L.ImageIndex := 0;
end;

procedure TfrmTDCTengah_OWA.btnCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 1;
end;

procedure TfrmTDCTengah_OWA.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;

procedure TfrmTDCTengah_OWA.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUORoffCENT_L.ImageIndex := 1;
  btnCUorCENT_L.ImageIndex    := 0;
end;

procedure TfrmTDCTengah_OWA.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUorCENT_L.ImageIndex    := 0;
  btnCUorCENT_L.ImageIndex    := 1;
end;

procedure TfrmTDCTengah_OWA.btnOFFCent_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);
end;

procedure TfrmTDCTengah_OWA.btnCENT_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);
end;

procedure TfrmTDCTengah_OWA.btnCUORoffCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);
end;

procedure TfrmTDCTengah_OWA.btnCUorCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);
end;

procedure TfrmTDCTengah_OWA.btnResetOBM_RClick(Sender: TObject);
begin
    TDCInterface.OBMRight_Reset;
end;

procedure TfrmTDCTengah_OWA.btnIFFClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  //TDCInterface.SetRadar_type(rtLW_03);
  //TDCInterface.SetRadar_MTI_Status(FALSE);
  //TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_OWA.btnVESTAClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  //TDCInterface.SetRadar_type(rtLW_03);
  //TDCInterface.SetRadar_MTI_Status(FALSE);
  //TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_OWA.btnDAMTIClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_OWA.btnDALINClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLiner);
end;

procedure TfrmTDCTengah_OWA.btnDALOGClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_OWA.btnLW03Click(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtLW_03);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_OWA.btnDECCAClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDECCA_1229);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_OWA.MapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PtInRect(Map.BoundsRect,Point(X,Y)) then
    TDCInterface.HideFormBawahOWA;
end;

procedure TfrmTDCTengah_OWA.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PtInRect(panel1.BoundsRect,Point(X,Y)) then
    TDCInterface.HideFormBawahOWA;
end;

procedure TfrmTDCTengah_OWA.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;

procedure TfrmTDCTengah_OWA.btnICM_LClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMLeft(num,
      TDCInterface.OBMleft.mPos.X , TDCInterface.OBMleft.mPos.Y)
  else
    TDCInterface.EndICMLeft(num);
end;

procedure TfrmTDCTengah_OWA.btnICM_RClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMRight(num,
      TDCInterface.OBMRight.mPos.X , TDCInterface.OBMRight.mPos.Y)
  else
    TDCInterface.EndICMRight(num);
end;

procedure TfrmTDCTengah_OWA.btnDataReq_LClick(Sender: TObject);
begin
  inherited;
  Inc(DRClick_L);
  TDCInterface.DataRequest_Left(DRClick_L);
  if (DRClick_L = 4) then DRClick_L := 0;
end;

procedure TfrmTDCTengah_OWA.btnDataReq_RClick(Sender: TObject);
begin
  inherited;
  Inc(DRClick_R);
  TDCInterface.DataRequest_Right(DRClick_R);
  if (DRClick_R = 4) then DRClick_R := 0;
end;

procedure TfrmTDCTengah_OWA.btnDROCM_RClick(Sender: TObject);
begin
  inherited;
  TDCInterface.DR_OCM_right;
end;

procedure TfrmTDCTengah_OWA.btnDROBM_RClick(Sender: TObject);
begin
  inherited;
  TDCInterface.DR_OBM_right(btnDROBM_R.Down);
end;

procedure TfrmTDCTengah_OWA.btnDROBM_LClick(Sender: TObject);
begin
  inherited;
  TDCInterface.DR_OBM_left(btnDROBM_L.Down);
end;

end.
