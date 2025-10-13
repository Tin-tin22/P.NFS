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
    Label5: TLabel;
    Bevel1: TBevel;
    btnRR_R: TSpeedButtonImage;
    btnIFF_R: TSpeedButtonImage;
    btnHM_R: TSpeedButtonImage;
    btnDataReq_R: TSpeedButtonImage;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange4: TSpeedButtonImage;
    Label27: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    btnDataReq_L: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOwnCurs: TSpeedButtonImage;
    btn12Sec: TSpeedButtonImage;
    btn30Sec: TSpeedButtonImage;
    btn15Min: TSpeedButtonImage;
    btn6Min: TSpeedButtonImage;
    btnReset: TSpeedButtonImage;
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
    Bevel13: TBevel;
    Bevel14: TBevel;
    Label29: TLabel;
    LabelSelection: TLabel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    btnCUORoffCENT_L: TSpeedButtonImage;
    btnCUorCENT_L: TSpeedButtonImage;
    btnOFFCent_L: TSpeedButtonImage;
    btnCENT_L: TSpeedButtonImage;
    btnResetOBM_L: TSpeedButtonImage;
    btnResetOBM_R: TSpeedButtonImage;
    SpeedButtonImage2: TSpeedButtonImage;
    Bevel3: TBevel;
    Label2: TLabel;
    btnTN: TSpeedButtonImage;
    Panel2: TPanel;
    procedure spbSetRangeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnWMnonMTIClick(Sender: TObject);
    procedure btnWMMTI_RClick(Sender: TObject);
    procedure btnCUORoffCENT_LClick(Sender: TObject);
    procedure btnCUorCENT_LClick(Sender: TObject);
    procedure btnOFFCent_LClick(Sender: TObject);
    procedure btnCENT_LClick(Sender: TObject);
    procedure btnResetOBM_LClick(Sender: TObject);
    procedure btnDataReq_LClick(Sender: TObject);
    procedure btnIFF_RClick(Sender: TObject);
    procedure btnRR_RClick(Sender: TObject);
    procedure btnHM_RClick(Sender: TObject);
    procedure btnResetOBM_RClick(Sender: TObject);
    procedure btnDataReq_RClick(Sender: TObject);
    procedure btn12SecClick(Sender: TObject);
    procedure btn30SecClick(Sender: TObject);
    procedure btn6MinClick(Sender: TObject);
    procedure btn15MinClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure btnOwnCursClick(Sender: TObject);
    procedure btnAIRClick(Sender: TObject);
    procedure btnSURFClick(Sender: TObject);
    procedure btnBLINDARCClick(Sender: TObject);
    procedure btnLPDTESTClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure btnAMPLInfoClick(Sender: TObject);
    procedure btnLINKClick(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
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

  spbSetRange4.Tag    := 4;

  spbSetRange8.Tag    := 8;

  spbSetRange16.Tag   := 16;

  spbSetRange32.Tag   := 32;

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

procedure TfrmTDCTengah_Rencong.btnWMnonMTIClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;

  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(FALSE);
end;

procedure TfrmTDCTengah_Rencong.btnWMMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_Rencong.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUORoffCENT_L.ImageIndex := 1;
  btnCUorCENT_L.ImageIndex    := 0;
end;

procedure TfrmTDCTengah_Rencong.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUorCENT_L.ImageIndex    := 0;
  btnCUorCENT_L.ImageIndex    := 1;
end;

procedure TfrmTDCTengah_Rencong.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnOFFCent_L.ImageIndex := 1;
  btnCent_L.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Rencong.btnCENT_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 1;
end;

procedure TfrmTDCTengah_Rencong.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;

procedure TfrmTDCTengah_Rencong.btnDataReq_LClick(Sender: TObject);
begin
   TDCInterface.DataRequest_Left(0);
end;

procedure TfrmTDCTengah_Rencong.btnIFF_RClick(Sender: TObject);
begin
  //  TDCControl1.TDC_Kanan.IFF := btnIFF_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.IFF=1) then  TDCCOntrol1.TDC_Kanan.IFF_Action;
end;

procedure TfrmTDCTengah_Rencong.btnRR_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing(btnRR_R.Down);
//  SetDown(btnRR_L, btnRR_R.Down);
end;

procedure TfrmTDCTengah_Rencong.btnHM_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_R.Down);
 // SetDown(btnHM_L, btnHM_R.Down);
end;

procedure TfrmTDCTengah_Rencong.btnResetOBM_RClick(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;


procedure TfrmTDCTengah_Rencong.btnDataReq_RClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Right(1);
end;


procedure TfrmTDCTengah_Rencong.btn12SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;


procedure TfrmTDCTengah_Rencong.btn30SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;


procedure TfrmTDCTengah_Rencong.btn6MinClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;


procedure TfrmTDCTengah_Rencong.btn15MinClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;


procedure TfrmTDCTengah_Rencong.btnResetClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;


procedure TfrmTDCTengah_Rencong.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;


procedure TfrmTDCTengah_Rencong.btnOwnCursClick(Sender: TObject);
begin
  TDCInterface.Cursorss.Visible := btnOwnCurs.Down;
end;


procedure TfrmTDCTengah_Rencong.btnAIRClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  btnAir.Down)
end;


procedure TfrmTDCTengah_Rencong.btnSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, btnSurf.Down)
end;


procedure TfrmTDCTengah_Rencong.btnBLINDARCClick(Sender: TObject);
begin
  TDCInterface.SetBlindARC(btnBLINDARC.Down);
  if btnBLINDARC.Down then btnBLINDARC.ImageIndex := 1
  else btnBLINDARC.ImageIndex := 0;
end;


procedure TfrmTDCTengah_Rencong.btnLPDTESTClick(Sender: TObject);
begin
  TDCInterface.SetLPDTest(btnLPDTEST.Down);
  SetUpdownImage(btnLPDTEST);
end;


procedure TfrmTDCTengah_Rencong.btnMSClick(Sender: TObject);
begin
  TDCInterface.SetMainSymbolVisible(btnMS.Down);
end;


procedure TfrmTDCTengah_Rencong.btnAMPLInfoClick(Sender: TObject);
begin
  TDCInterface.SetAMPLInfoVisible(btnAMPLInfo.Down);
end;


procedure TfrmTDCTengah_Rencong.btnLINKClick(Sender: TObject);
begin
  TDCInterface.SetLINKVisible(btnLINK.Down);
end;


procedure TfrmTDCTengah_Rencong.btnTNClick(Sender: TObject);
begin
  TDCInterface.SetTrackNumberVisible(btnTN.Down);
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
