unit ufTDCTengah_Singa;

interface

uses
  MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uMapWindow,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ufTDCTengah, SpeedButtonImage, ImgList,
  Menus, OleCtrls, VrControls, VrWheel, VrDigit;

type

  TfrmTDCTengah_Singa = class(TfrmTDCTengah)
    btnICM1_R: TSpeedButtonImage;
    Label3: TLabel;
    btnICM2_R: TSpeedButtonImage;
    Label1: TLabel;
    btnICM3_R: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    Label4: TLabel;
    SpeedButtonImage5: TSpeedButtonImage;
    Label5: TLabel;
    SpeedButtonImage6: TSpeedButtonImage;
    Label6: TLabel;
    SpeedButtonImage7: TSpeedButtonImage;
    Label7: TLabel;
    SpeedButtonImage8: TSpeedButtonImage;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    SpeedButtonImage9: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage10: TSpeedButtonImage;
    Label11: TLabel;
    SpeedButtonImage11: TSpeedButtonImage;
    Label12: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    Label13: TLabel;
    SpeedButtonImage13: TSpeedButtonImage;
    Label14: TLabel;
    btnICM1_L: TSpeedButtonImage;
    Label15: TLabel;
    btnICM2_L: TSpeedButtonImage;
    Label16: TLabel;
    btnICM3_L: TSpeedButtonImage;
    Label17: TLabel;
    Label18: TLabel;
    Bevel2: TBevel;
    SpeedButtonImage17: TSpeedButtonImage;
    Label19: TLabel;
    SpeedButtonImage18: TSpeedButtonImage;
    Label20: TLabel;
    SpeedButtonImage19: TSpeedButtonImage;
    Label21: TLabel;
    SpeedButtonImage20: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    btnWMNonMTI: TSpeedButtonImage;
    Label25: TLabel;
    btnWMMTI_R: TSpeedButtonImage;
    Label26: TLabel;
    SpeedButtonImage25: TSpeedButtonImage;
    Label27: TLabel;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    Label22: TLabel;
    SpeedButtonImage28: TSpeedButtonImage;
    Label23: TLabel;
    SpeedButtonImage29: TSpeedButtonImage;
    Label24: TLabel;
    SpeedButtonImage30: TSpeedButtonImage;
    Label28: TLabel;
    SpeedButtonImage31: TSpeedButtonImage;
    Label29: TLabel;
    SpeedButtonImage32: TSpeedButtonImage;
    Label30: TLabel;
    Panel2: TPanel;
    Panel3singa: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange4: TSpeedButtonImage;
    lblRange32: TLabel;
    lblRange16: TLabel;
    Label31: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    spbSetRange2: TSpeedButtonImage;
    lblRange8: TLabel;
    lblRange4: TLabel;
    lblRange2: TLabel;
    spbSetRange64: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    lblRange64: TLabel;
    spbDataReq_L: TSpeedButtonImage;
    Label32: TLabel;
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
  lblRange2.Tag       := 2;

  spbSetRange4.Tag    := 4;
  lblRange4.Tag       := 4;

  spbSetRange8.Tag    := 8;
  lblRange8.Tag       := 8;

  spbSetRange16.Tag   := 16;
  lblRange16.Tag      := 16;

  spbSetRange32.Tag   := 32;
  lblRange32.Tag      := 32;

  spbSetRange64.Tag   := 64;
  lblRange64.Tag      := 64;

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

end.
