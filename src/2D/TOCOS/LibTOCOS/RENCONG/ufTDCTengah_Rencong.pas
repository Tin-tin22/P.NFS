unit ufTDCTengah_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  ufTDCTengah,
  Buttons, SpeedButtonImage, ImgList ,
  uMapWindow, MapXLib_TLB, Menus, OleCtrls, VrControls, VrWheel, VrDigit ;

type

  TfrmTDCTengah_Rencong = class(TfrmTDCTengah)
    btnWMnonMTI: TSpeedButtonImage;
    btnWMMTI_R: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    lblWM_MTI: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    lblWM_NONMTI: TLabel;
    btnRR_R: TSpeedButtonImage;
    btnIFF_R: TSpeedButtonImage;
    Label7: TLabel;
    Label8: TLabel;
    btnHM_R: TSpeedButtonImage;
    Label9: TLabel;
    btnDataReq_R: TSpeedButtonImage;
    Label19: TLabel;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange4: TSpeedButtonImage;
    lblRange32: TLabel;
    lblRange16: TLabel;
    Label27: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    btnDataReq_L: TSpeedButtonImage;
    Label42: TLabel;
    btnTM: TSpeedButtonImage;
    Label43: TLabel;
    btnOwnCurs: TSpeedButtonImage;
    Label44: TLabel;
    btn12Sec: TSpeedButtonImage;
    btn30Sec: TSpeedButtonImage;
    btn15Min: TSpeedButtonImage;
    btn6Min: TSpeedButtonImage;
    btnReset: TSpeedButtonImage;
    Label45: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    btnMS: TSpeedButtonImage;
    SpeedButtonImage50: TSpeedButtonImage;
    btnLINK: TSpeedButtonImage;
    btnAMPLInfo: TSpeedButtonImage;
    btnAIR: TSpeedButtonImage;
    btnSURF: TSpeedButtonImage;
    btnBLINDARC: TSpeedButtonImage;
    btnLPDTEST: TSpeedButtonImage;
    Label64: TLabel;
    spbSetRange2: TSpeedButtonImage;
    lblRange8: TLabel;
    lblRange4: TLabel;
    lblRange2: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Label29: TLabel;
    LabelSelection: TLabel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Label31: TLabel;
    Label32: TLabel;
    Label53: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label63: TLabel;
    Label66: TLabel;
    btnCUORoffCENT_L: TSpeedButtonImage;
    Label33: TLabel;
    btnCUorCENT_L: TSpeedButtonImage;
    Label34: TLabel;
    btnOFFCent_L: TSpeedButtonImage;
    Label35: TLabel;
    btnCENT_L: TSpeedButtonImage;
    Label36: TLabel;
    btnResetOBM_L: TSpeedButtonImage;
    Label41: TLabel;
    Label1: TLabel;
    btnResetOBM_R: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    Bevel3: TBevel;
    Label2: TLabel;
    btnTN: TSpeedButtonImage;
    Label54: TLabel;
    procedure spbSetRangeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblRange4Click(Sender: TObject);
    procedure btnWMnonMTIClick(Sender: TObject);
    procedure lblWM_NONMTIClick(Sender: TObject);
    procedure btnWMMTI_RClick(Sender: TObject);
    procedure lblWM_MTIClick(Sender: TObject);
    procedure btnCUORoffCENT_LClick(Sender: TObject);
    procedure btnCUorCENT_LClick(Sender: TObject);
    procedure btnOFFCent_LClick(Sender: TObject);
    procedure btnCENT_LClick(Sender: TObject);
    procedure btnResetOBM_LClick(Sender: TObject);
    procedure Label33Click(Sender: TObject);
    procedure Label34Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure Label36Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure btnDataReq_LClick(Sender: TObject);
    procedure Label42Click(Sender: TObject);
    procedure btnIFF_RClick(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure btnRR_RClick(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure btnHM_RClick(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure btnResetOBM_RClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure btnDataReq_RClick(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure btn12SecClick(Sender: TObject);
    procedure Label45Click(Sender: TObject);
    procedure btn30SecClick(Sender: TObject);
    procedure Label47Click(Sender: TObject);
    procedure btn6MinClick(Sender: TObject);
    procedure Label48Click(Sender: TObject);
    procedure btn15MinClick(Sender: TObject);
    procedure Label50Click(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure Label49Click(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure Label43Click(Sender: TObject);
    procedure btnOwnCursClick(Sender: TObject);
    procedure Label44Click(Sender: TObject);
    procedure btnAIRClick(Sender: TObject);
    procedure Label57Click(Sender: TObject);
    procedure btnSURFClick(Sender: TObject);
    procedure Label58Click(Sender: TObject);
    procedure btnBLINDARCClick(Sender: TObject);
    procedure Label63Click(Sender: TObject);
    procedure btnLPDTESTClick(Sender: TObject);
    procedure Label66Click(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure Label31Click(Sender: TObject);
    procedure btnAMPLInfoClick(Sender: TObject);
    procedure Label32Click(Sender: TObject);
    procedure btnLINKClick(Sender: TObject);
    procedure Label53Click(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
    procedure Label54Click(Sender: TObject);
    procedure btnDataReq_LMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_LMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
//    ClickNum: integer;
    procedure Reset_Scale_Button;
    procedure Reset_RadarSelect_Button;
    procedure Reset_Threat_Button;
    procedure SetUpdownImage(var spb : TSpeedButtonImage);
  public
    { Public declarations }
  end;

{var
  frmTDCTengah_Rencong: TfrmTDCTengah_Rencong;
}
implementation
uses Math, uBaseConstan, uLibRAdar, uLibTDCClass, uTDCConstan;

{$R *.dfm}

procedure TfrmTDCTengah_Rencong.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
begin
  Ob := (Sender As TSpeedButtonImage);
  TDCInterface.SetView_RangeScale(ob.Tag);
  Reset_Scale_Button;
  ob.ImageIndex := 1;
  rData.Step := ob.Tag  / 100;
end;

procedure TfrmTDCTengah_Rencong.Reset_Scale_Button;
begin
   spbSetRange2.ImageIndex := 0;
   spbSetRange4.ImageIndex := 0;
   spbSetRange8.ImageIndex := 0;
   spbSetRange16.ImageIndex := 0;
   spbSetRange32.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.Reset_RadarSelect_Button;
begin
  btnWMnonMTI.ImageIndex := 0;
  btnWMMTI_R.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.Reset_Threat_Button;
begin
  btn12Sec.ImageIndex := 0;
  btn30Sec.ImageIndex := 0;
  btn6Min.ImageIndex := 0;
  btn15Min.ImageIndex := 0;
  btnReset.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.SetUpdownImage(var spb : TSpeedButtonImage);
begin
  if spb.Down then spb.ImageIndex := 1
  else spb.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.FormCreate(Sender: TObject);
var i: integer;
   spb : TSpeedButtonImage;
begin
  inherited;

  FCoverVisible := TRUE;

  SetRegionCircle;
 // setRange
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

  ClickNum := 0;

  btn12Sec.Tag  := 12;
  btn30Sec.Tag  := 30;
  btn6Min.Tag   := 6  * 60;
  btn15Min.Tag  := 15 * 60;
  btnReset.Tag  := -1;

  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TSpeedButtonImage then begin
      spb := TSpeedButtonImage(Components[i]);
      if spb.Down then spb.ImageIndex := 1;
    end;
  end;

end;

procedure TfrmTDCTengah_Rencong.lblRange4Click(Sender: TObject);
begin
  if sender = lblRange2 then
    spbSetRange2.Click
  else if sender = lblRange4 then
    spbSetRange4.Click
  else if sender = lblRange8 then
    spbSetRange8.Click
  else if sender = lblRange16 then
    spbSetRange16.Click
  else if sender = lblRange32 then
    spbSetRange32.Click
end;

procedure TfrmTDCTengah_Rencong.btnWMnonMTIClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;

  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(FALSE);
end;

procedure TfrmTDCTengah_Rencong.lblWM_NONMTIClick(Sender: TObject);
begin
  btnWMnonMTI.Click;
end;

procedure TfrmTDCTengah_Rencong.btnWMMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_Rencong.lblWM_MTIClick(Sender: TObject);
begin
  btnWMMTI_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUORoffCENT_L.ImageIndex := 1;
  btnCUorCENT_L.ImageIndex    := 0;
end;
procedure TfrmTDCTengah_Rencong.Label33Click(Sender: TObject);
begin
  btnCUORoffCENT_L.Click;
end;

procedure TfrmTDCTengah_Rencong.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUorCENT_L.ImageIndex    := 0;
  btnCUorCENT_L.ImageIndex    := 1;
end;

procedure TfrmTDCTengah_Rencong.Label34Click(Sender: TObject);
begin
  btnCUorCENT_L.Click;
end;

procedure TfrmTDCTengah_Rencong.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnOFFCent_L.ImageIndex := 1;
  btnCent_L.ImageIndex := 0;
end;
procedure TfrmTDCTengah_Rencong.Label35Click(Sender: TObject);
begin
  btnOFFCent_L.Click;
end;

procedure TfrmTDCTengah_Rencong.btnCENT_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 1;
end;

procedure TfrmTDCTengah_Rencong.Label36Click(Sender: TObject);
begin
  btnCENT_L.Click;
end;

procedure TfrmTDCTengah_Rencong.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;
procedure TfrmTDCTengah_Rencong.Label41Click(Sender: TObject);
begin
  btnResetOBM_L.Click;
end;



procedure TfrmTDCTengah_Rencong.btnDataReq_LClick(Sender: TObject);
begin
   TDCInterface.DataRequest_Left(0);
end;

procedure TfrmTDCTengah_Rencong.Label42Click(Sender: TObject);
begin
  btnDataReq_L.Click;
end;

procedure TfrmTDCTengah_Rencong.btnIFF_RClick(Sender: TObject);
begin
  //  TDCControl1.TDC_Kanan.IFF := btnIFF_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.IFF=1) then  TDCCOntrol1.TDC_Kanan.IFF_Action;
end;

procedure TfrmTDCTengah_Rencong.Label7Click(Sender: TObject);
begin
  btnIFF_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btnRR_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing(btnRR_R.Down);
//  SetDown(btnRR_L, btnRR_R.Down);
end;

procedure TfrmTDCTengah_Rencong.Label8Click(Sender: TObject);
begin
  btnRR_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btnHM_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_R.Down);
 // SetDown(btnHM_L, btnHM_R.Down);
end;

procedure TfrmTDCTengah_Rencong.Label9Click(Sender: TObject);
begin
  btnHM_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btnResetOBM_RClick(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;

procedure TfrmTDCTengah_Rencong.Label1Click(Sender: TObject);
begin
  btnResetOBM_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btnDataReq_RClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Right(1);
end;

procedure TfrmTDCTengah_Rencong.Label19Click(Sender: TObject);
begin
  btnDataReq_R.Click;
end;

procedure TfrmTDCTengah_Rencong.btn12SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Rencong.Label45Click(Sender: TObject);
begin
  btn12Sec.Click;
end;

procedure TfrmTDCTengah_Rencong.btn30SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Rencong.Label47Click(Sender: TObject);
begin
  btn30Sec.Click;
end;

procedure TfrmTDCTengah_Rencong.btn6MinClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Rencong.Label48Click(Sender: TObject);
begin
  btn6Min.Click;
end;

procedure TfrmTDCTengah_Rencong.btn15MinClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Rencong.Label50Click(Sender: TObject);
begin
  btn15Min.Click;
end;

procedure TfrmTDCTengah_Rencong.btnResetClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Rencong.Label49Click(Sender: TObject);
begin
  btnReset.Click;
end;

procedure TfrmTDCTengah_Rencong.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;

procedure TfrmTDCTengah_Rencong.Label43Click(Sender: TObject);
begin
  btnTM.Click;
end;

procedure TfrmTDCTengah_Rencong.btnOwnCursClick(Sender: TObject);
begin
  TDCInterface.Cursorss.Visible := btnOwnCurs.Down;
end;

procedure TfrmTDCTengah_Rencong.Label44Click(Sender: TObject);
begin
  btnOwnCurs.Click;
end;

procedure TfrmTDCTengah_Rencong.btnAIRClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  btnAir.Down)
end;

procedure TfrmTDCTengah_Rencong.Label57Click(Sender: TObject);
begin
  btnAIR.Click;
end;

procedure TfrmTDCTengah_Rencong.btnSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, btnSurf.Down)
end;

procedure TfrmTDCTengah_Rencong.Label58Click(Sender: TObject);
begin
  btnSurf.Click;
end;

procedure TfrmTDCTengah_Rencong.btnBLINDARCClick(Sender: TObject);
begin
  TDCInterface.SetBlindARC(btnBLINDARC.Down);
  if btnBLINDARC.Down then btnBLINDARC.ImageIndex := 1
  else btnBLINDARC.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.Label63Click(Sender: TObject);
begin
  btnBLINDARC.Click;
end;

procedure TfrmTDCTengah_Rencong.btnLPDTESTClick(Sender: TObject);
begin
  TDCInterface.SetLPDTest(btnLPDTEST.Down);
  SetUpdownImage(btnLPDTEST);
end;

procedure TfrmTDCTengah_Rencong.Label66Click(Sender: TObject);
begin
  btnLPDTEST.Click;
end;

procedure TfrmTDCTengah_Rencong.btnMSClick(Sender: TObject);
begin
  TDCInterface.SetMainSymbolVisible(btnMS.Down);
end;

procedure TfrmTDCTengah_Rencong.Label31Click(Sender: TObject);
begin
  btnMs.Click;
end;

procedure TfrmTDCTengah_Rencong.btnAMPLInfoClick(Sender: TObject);
begin
  TDCInterface.SetAMPLInfoVisible(btnAMPLInfo.Down);
end;

procedure TfrmTDCTengah_Rencong.Label32Click(Sender: TObject);
begin
  btnAMPLInfo.Click;
end;

procedure TfrmTDCTengah_Rencong.btnLINKClick(Sender: TObject);
begin
  TDCInterface.SetLINKVisible(btnLINK.Down);
end;

procedure TfrmTDCTengah_Rencong.Label53Click(Sender: TObject);
begin
  btnLINK.Click;
end;

procedure TfrmTDCTengah_Rencong.btnTNClick(Sender: TObject);
begin
  TDCInterface.SetTrackNumberVisible(btnTN.Down);
end;

procedure TfrmTDCTengah_Rencong.Label54Click(Sender: TObject);
begin
  btnTN.Click;
end;

procedure TfrmTDCTengah_Rencong.btnDataReq_LMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  inherited;
   TDCInterface.DataRequest_left(0);

end;

procedure TfrmTDCTengah_Rencong.btnDataReq_LMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  inherited;
   TDCInterface.DataRequest_Right(255);

end;

procedure TfrmTDCTengah_Rencong.btnDataReq_RMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_Right(1);
end;

procedure TfrmTDCTengah_Rencong.btnDataReq_RMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_Right(255);

end;

end.
