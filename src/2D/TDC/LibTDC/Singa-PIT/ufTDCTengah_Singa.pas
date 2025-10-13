unit ufTDCTengah_Singa;

interface

uses
  MapXLib_TLB,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uMapWindow,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ufTDCTengah, SpeedButtonImage, ImgList,
  Menus, OleCtrls, VrControls, VrWheel, VrDigit;

type

  TfrmTDCTengah_Singa = class(TfrmTDCTengah)
    btnICM1_R: TSpeedButtonImage;
    btnICM2_R: TSpeedButtonImage;
    btnICM3_R: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    Label9: TLabel;
    Bevel1: TBevel;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    btnICM1_L: TSpeedButtonImage;
    btnICM2_L: TSpeedButtonImage;
    btnICM3_L: TSpeedButtonImage;
    Label18: TLabel;
    Bevel2: TBevel;
    SpeedButtonImage17: TSpeedButtonImage;
    SpeedButtonImage18: TSpeedButtonImage;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage20: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    btnWMNonMTI: TSpeedButtonImage;
    btnWMMTI_R: TSpeedButtonImage;
    SpeedButtonImage25: TSpeedButtonImage;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    SpeedButtonImage28: TSpeedButtonImage;
    SpeedButtonImage29: TSpeedButtonImage;
    spbDataReq_R: TSpeedButtonImage;
    SpeedButtonImage31: TSpeedButtonImage;
    SpeedButtonImage32: TSpeedButtonImage;
    Panel2: TPanel;
    Panel3singa: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange4: TSpeedButtonImage;
    Label31: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    spbSetRange2: TSpeedButtonImage;
    spbSetRange64: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    spbDataReq_L: TSpeedButtonImage;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonImage4Click(Sender: TObject);
    procedure SpeedButtonImage9Click(Sender: TObject);
    procedure SpeedButtonImage10Click(Sender: TObject);
    procedure SpeedButtonImage11Click(Sender: TObject);
    procedure SpeedButtonImage12Click(Sender: TObject);
    procedure SpeedButtonImage13Click(Sender: TObject);
    procedure SpeedButtonImage5Click(Sender: TObject);
    procedure SpeedButtonImage6Click(Sender: TObject);
    procedure SpeedButtonImage7Click(Sender: TObject);
    procedure SpeedButtonImage8Click(Sender: TObject);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButtonImage20Click(Sender: TObject);
    procedure SpeedButtonImage21Click(Sender: TObject);
    procedure SpeedButtonImage22Click(Sender: TObject);
    procedure btnWMNonMTIClick(Sender: TObject);
    procedure btnWMMTI_RClick(Sender: TObject);
    procedure SpeedButtonImage31Click(Sender: TObject);
    procedure SpeedButtonImage32Click(Sender: TObject);
    procedure SpeedButtonImage28Click(Sender: TObject);
    procedure SpeedButtonImage29Click(Sender: TObject);
    procedure btnICM_LClick(Sender: TObject);
    procedure btnICM1_RClick(Sender: TObject);
    procedure wBearingChange(Sender: TObject);
    procedure wRangeChange(Sender: TObject);
    procedure spbSetRangeClick(Sender: TObject);
    procedure spbDataReq_RClick(Sender: TObject);
    procedure spbDataReq_LClick(Sender: TObject);
    procedure spbDataReq_LMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure spbDataReq_LMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure spbDataReq_RMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure spbDataReq_RMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private

    procedure Reset_Scale_Button;
    procedure Reset_RadarSelect_Button;

//    procedure SetUpdownImage(var spb : TSpeedButtonImage);
  public
    { Public declarations }
//    TDCInterface : TGenericTDCInterface;

  end;


implementation

uses uBaseConstan, uLibRadar, uLibTDCClass, uTDCConstan ;

{$R *.dfm}


procedure TfrmTDCTengah_Singa.Reset_Scale_Button;
begin
   spbSetRange2.ImageIndex := 0;
   spbSetRange4.ImageIndex := 0;
   spbSetRange8.ImageIndex := 0;
   spbSetRange16.ImageIndex := 0;
   spbSetRange32.ImageIndex := 0;
   spbSetRange64.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Singa.Reset_RadarSelect_Button;
begin
  btnWMnonMTI.ImageIndex := 0;
  btnWMMTI_R.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Singa.FormCreate(Sender: TObject);
var i: integer;
   spb : TSpeedButtonImage;
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

  ClickNum := 0;

  btnICM1_L.Tag := 1;
  btnICM2_L.Tag := 2;
  btnICM3_L.Tag := 3;

  btnICM1_R.Tag := 11;
  btnICM2_R.Tag := 12;
  btnICM3_R.Tag := 13;


{  btn12Sec.Tag  := 12;
  btn30Sec.Tag  := 30;
  btn6Min.Tag   := 6  * 60;
  btn15Min.Tag  := 15 * 60;
  btnReset.Tag  := -1;
}
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TSpeedButtonImage then begin
      spb := TSpeedButtonImage(Components[i]);
      if spb.Down then spb.ImageIndex := 1;
    end;
  end;
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage4Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage9Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage10Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage11Click(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage12Click(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage13Click(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage5Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage6Click(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage7Click(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage8Click(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;

procedure TfrmTDCTengah_Singa.MapMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lPt  : TPoint;
begin

  msDown := Button = mbLeft;
  lpt.X  := X;
  lpt.Y  := Y;
  mIndex := TDCInterface.FindMarkerByPosition(lPt);
  TDCInterface.SelectedMarkerTool := mIndex;

  if mIndex < 0 then begin
    Map.OnMouseMove := nil;
    exit;
    ClickNum := 0;
  end;

  case mIndex of
    i_OBM_kiri  : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKiri_MapMouseMove;
    end;
    i_OBM_kanan : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKanan_MapMouseMove;
    end;

  end;

end;

procedure TfrmTDCTengah_Singa.MapMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  if  ClickNum = 1 then
    exit
  else if ClickNum = 2 then begin
    ClickNum := 0;
    Map.OnMouseMove := nil;
    msDown := FALSE;
    mIndex := -1;
    TDCInterface.SelectedMarkerTool := -1;
  end;
end;


procedure TfrmTDCTengah_Singa.SpeedButtonImage20Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage21Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLiner);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage22Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);

end;

procedure TfrmTDCTengah_Singa.btnWMNonMTIClick(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
end;

procedure TfrmTDCTengah_Singa.btnWMMTI_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(TRUE);
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage31Click(Sender: TObject);
begin
  TDCInterface.TrueMotion := (sender as TSpeedButtonImage).Down;
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage32Click(Sender: TObject);
begin
   TDCInterface.Cursorss.Visible := (sender as TSpeedButtonImage).Down;
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage28Click(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing((sender as TSpeedButtonImage).Down);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage29Click(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker((sender as TSpeedButtonImage).Down);
end;

procedure TfrmTDCTengah_Singa.btnICM_LClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMLeft(num,
      TDCInterface.OBMleft.mPos.X , TDCInterface.OBMleft.mPos.Y)
  else
    TDCInterface.EndICMLeft(num);
end;

procedure TfrmTDCTengah_Singa.btnICM1_RClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMRight(num,
      TDCInterface.OBMRight.mPos.X , TDCInterface.OBMRight.mPos.Y)
  else
    TDCInterface.EndICMRight(num);
end;

procedure TfrmTDCTengah_Singa.wBearingChange(Sender: TObject);
begin
  TDCInterface.CursorSetBearing(wBearing.Position);
  VrBearing.Value := wBearing.Position * 10;
end;

procedure TfrmTDCTengah_Singa.wRangeChange(Sender: TObject);
begin
  TDCInterface.CursorSetRange(wRange.Position);
  VrRange.Value := wRange.Position;
end;

procedure TfrmTDCTengah_Singa.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
begin
  Ob := (Sender As TSpeedButtonImage);
  TDCInterface.SetView_RangeScale(ob.Tag);
  Reset_Scale_Button;
  ob.ImageIndex := 1;
  rData.Step := ob.Tag  / 100;
end;

procedure TfrmTDCTengah_Singa.spbDataReq_RClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Right(1);

end;

procedure TfrmTDCTengah_Singa.spbDataReq_LClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Left(1);

end;

procedure TfrmTDCTengah_Singa.spbDataReq_LMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_left(0);

end;

procedure TfrmTDCTengah_Singa.spbDataReq_LMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_left(1);

end;

procedure TfrmTDCTengah_Singa.spbDataReq_RMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   TDCInterface.DataRequest_right(0);

end;

procedure TfrmTDCTengah_Singa.spbDataReq_RMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   TDCInterface.DataRequest_right(1);

end;

procedure TfrmTDCTengah_Singa.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//  inherited;
  if PtInRect(panel1.BoundsRect,Point(X,Y)) then
    TDCInterface.HideFormBawahOWA;

end;

end.
