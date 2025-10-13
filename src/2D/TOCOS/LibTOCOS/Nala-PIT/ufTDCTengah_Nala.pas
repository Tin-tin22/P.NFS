unit ufTDCTengah_Nala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

  Dialogs, StdCtrls, Buttons, SpeedButtonImage, ImgList, ExtCtrls,  ufTDCTengah,
  VrDigit, VrControls, VrWheel, Menus, OleCtrls, MapXLib_TLB;

type
  TfrmTDCTengah_Nala = class(TfrmTDCTengah)

    btnAN_R: TSpeedButtonImage;
    Label65: TLabel;
    btnTV_R: TSpeedButtonImage;
    Label1: TLabel;
    btnDAMTI_R: TSpeedButtonImage;
    BtnDALIN_R: TSpeedButtonImage;
    btnWMnonMTI: TSpeedButtonImage;
    btnDALOG_R: TSpeedButtonImage;
    btnWMMTI_R: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    lblDA_MTI: TLabel;
    lblDA_LIN: TLabel;
    lblDA_Log: TLabel;
    lblWM_MTI: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblWM_NONMTI: TLabel;
    btnMRnonXXX_R: TSpeedButtonImage;
    Label6: TLabel;
    btnRR_R: TSpeedButtonImage;
    btnIFF_R: TSpeedButtonImage;
    Label7: TLabel;
    Label8: TLabel;
    btnHM_R: TSpeedButtonImage;
    Label9: TLabel;
    btnCUORoffCENT_R: TSpeedButtonImage;
    Label10: TLabel;
    btnCUorCENT_R: TSpeedButtonImage;
    Label11: TLabel;
    btnOFFCent_R: TSpeedButtonImage;
    Label12: TLabel;
    btnCENT_R: TSpeedButtonImage;
    Label13: TLabel;
    btnResetOBM_R: TSpeedButtonImage;
    btnICM1_R: TSpeedButtonImage;
    Label14: TLabel;
    btnICM2_R: TSpeedButtonImage;
    Label15: TLabel;
    btnICM3_R: TSpeedButtonImage;
    Label16: TLabel;
    Label17: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label18: TLabel;
    btnDataReq_R: TSpeedButtonImage;
    Label19: TLabel;
    btnAN_L: TSpeedButtonImage;
    Label21: TLabel;
    btnTV_L: TSpeedButtonImage;
    Label22: TLabel;
    spbSetRange128: TSpeedButtonImage;
    spbSetRange64: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    lblRange128: TLabel;
    lblRange64: TLabel;
    lblRange32: TLabel;
    lblRange8: TLabel;
    Label27: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    lblRange16: TLabel;
    btnMRnonXXX_L: TSpeedButtonImage;
    Label29: TLabel;
    btnCUORoffCENT_L: TSpeedButtonImage;
    Label33: TLabel;
    btnCUorCENT_L: TSpeedButtonImage;
    Label34: TLabel;
    btnOFFCent_L: TSpeedButtonImage;
    Label35: TLabel;
    btnCENT_L: TSpeedButtonImage;
    Label36: TLabel;
    btnResetOBM_L: TSpeedButtonImage;
    btnICM1_L: TSpeedButtonImage;
    Label37: TLabel;
    btnICM2_L: TSpeedButtonImage;
    Label38: TLabel;
    btnICM3_L: TSpeedButtonImage;
    Label39: TLabel;
    Label40: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label41: TLabel;
    btnDataReq_L: TSpeedButtonImage;
    Label42: TLabel;
    btnTM: TSpeedButtonImage;
    lblBtnTM: TLabel;
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
    btnArrow: TSpeedButtonImage;
    btnLINK: TSpeedButtonImage;
    btnAMPLInfo: TSpeedButtonImage;
    btnTN: TSpeedButtonImage;
    btnAIR: TSpeedButtonImage;
    btnSURF: TSpeedButtonImage;
    btnEW: TSpeedButtonImage;
    btnSUBSURF: TSpeedButtonImage;
    btnNAVAids: TSpeedButtonImage;
    btnBLINDARC: TSpeedButtonImage;
    btnBLINDARCASW: TSpeedButtonImage;
    btnLPDTEST: TSpeedButtonImage;
    Label64: TLabel;
    spbSetRange4: TSpeedButtonImage;
    PopupMenu2: TPopupMenu;
    lblRange4: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label43: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    spbSetRange2: TSpeedButtonImage;
    lblRange2: TLabel;
    procedure btnAIRClick(Sender: TObject);
    procedure btnSURFClick(Sender: TObject);
    procedure btnSUBSURFClick(Sender: TObject);
    procedure btnEWClick(Sender: TObject);
    procedure btnNAVAidsClick(Sender: TObject);
    procedure btnBLINDARCClick(Sender: TObject);
    procedure btnBLINDARCASWClick(Sender: TObject);
    procedure btnLPDTESTClick(Sender: TObject);
    procedure btnDAMTI_RClick(Sender: TObject);
    procedure BtnDALIN_RClick(Sender: TObject);
    procedure btnDALOG_RClick(Sender: TObject);
    procedure btnWMnonMTIClick(Sender: TObject);
    procedure btnWMMTI_RClick(Sender: TObject);
    procedure btnIFF_RClick(Sender: TObject);
    procedure btnRR_RClick(Sender: TObject);
    procedure btnOFFCent_RClick(Sender: TObject);
    procedure btnCENT_RClick(Sender: TObject);
    procedure btnResetOBM_RClick(Sender: TObject);
    procedure btnDataReq_RClick(Sender: TObject);
    procedure btnCUORoffCENT_LClick(Sender: TObject);
    procedure btnCUorCENT_LClick(Sender: TObject);
    procedure btnOFFCent_LClick(Sender: TObject);
    procedure btnCENT_LClick(Sender: TObject);
    procedure btnResetOBM_LClick(Sender: TObject);
    procedure btnDataReq_LClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbSetRangeClick(Sender: TObject);
    procedure btnICM_RClick(Sender: TObject);
    procedure btnICM_LClick(Sender: TObject);

    procedure btnTV_LClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure lblBtnTMClick(Sender: TObject);
    procedure lblDA_MTIClick(Sender: TObject);
    procedure lblRange4Click(Sender: TObject);
    procedure btnHM_RClick(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure btn12SecClick(Sender: TObject);
    procedure btnCUORoffCENT_RClick(Sender: TObject);
    procedure btnCUorCENT_RClick(Sender: TObject);
    procedure lblDA_LINClick(Sender: TObject);
    procedure lblDA_LogClick(Sender: TObject);
    procedure lblWM_NONMTIClick(Sender: TObject);
    procedure lblWM_MTIClick(Sender: TObject);
    procedure Label33Click(Sender: TObject);
    procedure Label34Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure Label36Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure Label42Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure Label53Click(Sender: TObject);
    procedure btnArrowClick(Sender: TObject);
    procedure Label54Click(Sender: TObject);
    procedure btnAMPLInfoClick(Sender: TObject);
    procedure Label55Click(Sender: TObject);
    procedure btnLINKClick(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
    procedure Label57Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure btnOwnCursClick(Sender: TObject);
    procedure Label44Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure Label52Click(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label45Click(Sender: TObject);
    procedure Label47Click(Sender: TObject);
    procedure Label48Click(Sender: TObject);
    procedure Label50Click(Sender: TObject);
    procedure Label49Click(Sender: TObject);
    procedure Label28Click(Sender: TObject);
    procedure Label51Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnDataReq_LMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_LMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    ClickNum: integer;


    procedure Reset_Scale_Button;
    procedure Reset_RadarSelect_Button;

    procedure Reset_Threat_Button;

    procedure SetUpdownImage(var spb : TSpeedButtonImage);
  public
    { Public declarations }

  end;

implementation

uses Math, uBaseConstan, uLibRAdar, uLibTDCClass, uTDCConstan;
{$R *.dfm}

procedure TfrmTDCTengah_Nala.FormCreate(Sender: TObject);
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

  spbSetRange64.Tag   := 64;
  lblRange64.Tag      := 64;

  spbSetRange128.Tag  := 128;
  lblRange128.Tag     := 128;
  ClickNum := 0;


  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TSpeedButtonImage then begin
      spb := TSpeedButtonImage(Components[i]);
      if spb.Down then spb.ImageIndex := 1;
    end;
  end;

  btn12Sec.Tag  := 12;
  btn30Sec.Tag  := 30;
  btn6Min.Tag   := 6  * 60;
  btn15Min.Tag  := 15 * 60;
  btnReset.Tag  := -1;


  btnICM1_L.Tag := 1;
  btnICM2_L.Tag := 2;
  btnICM3_L.Tag := 3;

  btnICM1_R.Tag := 11;
  btnICM2_R.Tag := 12;
  btnICM3_R.Tag := 13;


end;

// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
begin
  Ob := (Sender As TSpeedButtonImage);
  TDCInterface.SetView_RangeScale(ob.Tag);
  Reset_Scale_Button;
  ob.ImageIndex := 1;
//  wRange.MaxValue := ob.Tag * 10;
  rData.Step := ob.Tag  / 100;
end;

procedure TfrmTDCTengah_Nala.lblRange4Click(Sender: TObject);
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
  else if sender = lblRange64 then
    spbSetRange64.Click
  else if sender = lblRange128 then
    spbSetRange128.Click;
end;

procedure TfrmTDCTengah_Nala.Reset_Scale_Button;
begin
   spbSetRange2.ImageIndex := 0;
   spbSetRange4.ImageIndex := 0;
   spbSetRange8.ImageIndex := 0;
   spbSetRange16.ImageIndex := 0;
   spbSetRange32.ImageIndex := 0;
   spbSetRange64.ImageIndex := 0;
   spbSetRange128.ImageIndex  := 0;
end;
// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.Reset_RadarSelect_Button;
begin
  btnDAMTI_R.ImageIndex := 0;
  BtnDALIN_R.ImageIndex := 0;
  btnDALOG_R.ImageIndex := 0;
  btnWMnonMTI.ImageIndex := 0;
  btnWMMTI_R.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Nala.Reset_Threat_Button;
begin
  btn12Sec.ImageIndex := 0;
  btn30Sec.ImageIndex := 0;
  btn6Min.ImageIndex := 0;
  btn15Min.ImageIndex := 0;
  btnReset.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Nala.SetUpdownImage(var spb : TSpeedButtonImage);
begin
  if spb.Down then spb.ImageIndex := 1
  else spb.ImageIndex := 0;
end;

// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUORoffCENT_L.ImageIndex := 1;
  btnCUorCENT_L.ImageIndex    := 0;
end;

procedure TfrmTDCTengah_Nala.Label33Click(Sender: TObject);
begin

  btnCUORoffCENT_L.Click;
end;

// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
  btnCUORoffCENT_L.ImageIndex := 0;
  btnCUorCENT_L.ImageIndex    := 0;
  btnCUorCENT_L.ImageIndex    := 1;
end;

procedure TfrmTDCTengah_Nala.Label34Click(Sender: TObject);
begin
  btnCUorCENT_L.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnOFFCent_L.ImageIndex := 1;
  btnCent_L.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Nala.Label35Click(Sender: TObject);
begin
  btnOFFCent_L.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnCENT_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 1;
end;

procedure TfrmTDCTengah_Nala.Label36Click(Sender: TObject);
begin
  btnCENT_L.Click;
end;
//------------------------------------------------------------------------------
// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnCUORoffCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);
end;
procedure TfrmTDCTengah_Nala.Label10Click(Sender: TObject);
begin
  btnCUORoffCENT_R.Click;
end;


procedure TfrmTDCTengah_Nala.btnCUorCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);
end;
procedure TfrmTDCTengah_Nala.Label11Click(Sender: TObject);
begin
  btnCUorCENT_R.Click;
end;

//------------------------------------------------------------------------------
// center & off center;
procedure TfrmTDCTengah_Nala.btnOFFCent_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);
end;
procedure TfrmTDCTengah_Nala.Label12Click(Sender: TObject);
begin
  btnOFFCent_R.Click;
end;

procedure TfrmTDCTengah_Nala.btnCENT_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);
end;
procedure TfrmTDCTengah_Nala.Label13Click(Sender: TObject);
begin
  btnCENT_R.Click;
end;

// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;
procedure TfrmTDCTengah_Nala.Label41Click(Sender: TObject);
begin
  btnResetOBM_L.Click;
end;

procedure TfrmTDCTengah_Nala.btnResetOBM_RClick(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;

procedure TfrmTDCTengah_Nala.Label18Click(Sender: TObject);
begin
  btnResetOBM_R.Click;
end;
//------------------------------------------------------------------------------


procedure TfrmTDCTengah_Nala.btnAIRClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  btnAir.Down);
end;
procedure TfrmTDCTengah_Nala.Label23Click(Sender: TObject);
begin
  btnAIR.Click;
end;

procedure TfrmTDCTengah_Nala.btnSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, btnSurf.Down)
end;
procedure TfrmTDCTengah_Nala.Label24Click(Sender: TObject);
begin
  btnSurf.Click;
end;

procedure TfrmTDCTengah_Nala.btnSUBSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir, btnSUBSURF.Down)
end;
procedure TfrmTDCTengah_Nala.Label52Click(Sender: TObject);
begin
  btnSUBSURF.Click;
end;

procedure TfrmTDCTengah_Nala.btnEWClick(Sender: TObject);
begin
  TDCInterface.Filter(tdEW, btnEW.Down)
end;

procedure TfrmTDCTengah_Nala.Label25Click(Sender: TObject);
begin
  btnEW.Click;
end;

procedure TfrmTDCTengah_Nala.btnNAVAidsClick(Sender: TObject);
begin
//TDCControl1.NAV_AIDS := btnNAVAids.ImageIndex;
//if (TDCControl1.NAV_AIDS=1) then TDCCOntrol1.NAV_AIDS_Action;
end;

procedure TfrmTDCTengah_Nala.btnBLINDARCClick(Sender: TObject);
begin
  TDCInterface.SetBlindARC(btnBLINDARC.Down);
  if btnBLINDARC.Down then btnBLINDARC.ImageIndex := 1
  else btnBLINDARC.ImageIndex := 0;

end;
procedure TfrmTDCTengah_Nala.Label28Click(Sender: TObject);
begin
  btnBLINDARC.Click;

end;

procedure TfrmTDCTengah_Nala.btnBLINDARCASWClick(Sender: TObject);
begin
//TDCControl1.BLIND_ARC_ASW := btnBLINDARCASW.ImageIndex;
//if (TDCControl1.BLIND_ARC_ASW=1) then TDCCOntrol1.BLIND_ARC_ASW_Action;
end;

procedure TfrmTDCTengah_Nala.btnLPDTESTClick(Sender: TObject);
begin
  TDCInterface.SetLPDTest(btnLPDTEST.Down);
  SetUpdownImage(btnLPDTEST);
end;

procedure TfrmTDCTengah_Nala.Label51Click(Sender: TObject);
begin
  btnLPDTEST.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnDAMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;
procedure TfrmTDCTengah_Nala.lblDA_MTIClick(Sender: TObject);
begin
  btnDAMTI_R.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.BtnDALIN_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLiner);
end;

procedure TfrmTDCTengah_Nala.lblDA_LINClick(Sender: TObject);
begin
  BtnDALIN_R.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnDALOG_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_Nala.lblDA_LogClick(Sender: TObject);
begin
  btnDALOG_R.Click;
end;

//------------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnWMnonMTIClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;

  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(FALSE);
end;
procedure TfrmTDCTengah_Nala.lblWM_NONMTIClick(Sender: TObject);
begin
   btnWMnonMTI.Click;
end;
//------------------------------------------------------------------------------
Procedure TfrmTDCTengah_Nala.btnWMMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_Nala.lblWM_MTIClick(Sender: TObject);
begin
  btnWMMTI_R.Click;
end;
//------------------------------------------------------------------------------

procedure TfrmTDCTengah_Nala.btnIFF_RClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kanan.IFF := btnIFF_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.IFF=1) then  TDCCOntrol1.TDC_Kanan.IFF_Action;
end;
procedure TfrmTDCTengah_Nala.Label7Click(Sender: TObject);
begin
  btnIFF_R.Click;
end;

procedure TfrmTDCTengah_Nala.btnDataReq_RClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kanan.DATA_REQ := btnDataReq_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.DATA_REQ=1) then  TDCCOntrol1.TDC_Kanan.DATA_REQ_Action;
end;

procedure TfrmTDCTengah_Nala.Label19Click(Sender: TObject);
begin
  btnDataReq_R.Click;
end;


procedure TfrmTDCTengah_Nala.btnDataReq_LClick(Sender: TObject);
begin

//  TDCControl1.TDC_Kiri.DATA_REQ := btnDataReq_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.DATA_REQ =10) then TDCCOntrol1.TDC_Kiri.DATA_REQ_Action;
end;
procedure TfrmTDCTengah_Nala.Label42Click(Sender: TObject);
begin
  btnDataReq_L.Click;
end;


procedure TfrmTDCTengah_Nala.btnICM_RClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMRight(num,
      TDCInterface.OBMRight.mPos.X , TDCInterface.OBMRight.mPos.Y)
  else
    TDCInterface.EndICMRight(num);

end;


procedure TfrmTDCTengah_Nala.btnICM_LClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMLeft(num,
      TDCInterface.OBMleft.mPos.X , TDCInterface.OBMleft.mPos.Y)
  else
    TDCInterface.EndICMLeft(num);

end;


procedure TfrmTDCTengah_Nala.btnTV_LClick(Sender: TObject);
begin
//  inherited;

end;

procedure SetDown(spb: TSpeedButtonImage; const val: boolean);
var ev: TNotifyEvent;
begin
  ev := spb.OnClick;
  spb.Down := val;
  spb.OnClick := ev;
  if val then
    spb.ImageIndex := 1
  else
    spb.ImageIndex := 0;
end;

//--- Range Ring Tombol kanan
procedure TfrmTDCTengah_Nala.btnRR_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing(btnRR_R.Down);
//  SetDown(btnRR_L, btnRR_R.Down);
end;

procedure TfrmTDCTengah_Nala.Label8Click(Sender: TObject);
begin
  btnRR_R.Click;
end;

//--- HEADING MARKER tombol kanan --
procedure TfrmTDCTengah_Nala.btnHM_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_R.Down);
 // SetDown(btnHM_L, btnHM_R.Down);
end;

procedure TfrmTDCTengah_Nala.Label9Click(Sender: TObject);
begin
  btnHM_R.Click;
end;

procedure TfrmTDCTengah_Nala.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;

procedure TfrmTDCTengah_Nala.lblBtnTMClick(Sender: TObject);
begin
  btnTM.Down := NOT btnTM.Down;
  btnTM.Click;
end;


procedure TfrmTDCTengah_Nala.btnMSClick(Sender: TObject);
begin
  TDCInterface.SetMainSymbolVisible(btnMS.Down);
end;

procedure TfrmTDCTengah_Nala.Label53Click(Sender: TObject);
begin
  btnMs.Click;
end;

procedure TfrmTDCTengah_Nala.btnArrowClick(Sender: TObject);
begin
  TDCInterface.SetCourseVisible(btnArrow.Down);
end;

procedure TfrmTDCTengah_Nala.Label54Click(Sender: TObject);
begin
  btnArrow.Click;
end;

procedure TfrmTDCTengah_Nala.btnAMPLInfoClick(Sender: TObject);
begin
  TDCInterface.SetAMPLInfoVisible(btnAMPLInfo.Down);
end;

procedure TfrmTDCTengah_Nala.Label55Click(Sender: TObject);
begin
  btnAMPLInfo.Click;
end;

procedure TfrmTDCTengah_Nala.btnLINKClick(Sender: TObject);
begin
//  inherited;
   TDCInterface.SetLINKVisible(btnLINK.Down);
end;

procedure TfrmTDCTengah_Nala.Label56Click(Sender: TObject);
begin
  btnLINK.Click;
end;

procedure TfrmTDCTengah_Nala.btnTNClick(Sender: TObject);
begin
  TDCInterface.SetTrackNumberVisible(btnTN.Down);
end;

procedure TfrmTDCTengah_Nala.Label57Click(Sender: TObject);
begin
  btnTN.Click;
end;

procedure TfrmTDCTengah_Nala.btnOwnCursClick(Sender: TObject);
begin
   TDCInterface.Cursorss.Visible := btnOwnCurs.Down;
end;

procedure TfrmTDCTengah_Nala.Label44Click(Sender: TObject);
begin
  btnOwnCurs.Down := NOT btnOwnCurs.Down;
  btnOwnCurs.Click;
end;

procedure TfrmTDCTengah_Nala.btn12SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
end;

procedure TfrmTDCTengah_Nala.Label45Click(Sender: TObject);
begin
  btn12Sec.Click;
end;

procedure TfrmTDCTengah_Nala.Label47Click(Sender: TObject);
begin
  btn30Sec.Click;
end;

procedure TfrmTDCTengah_Nala.Label48Click(Sender: TObject);
begin
  btn6Min.Click;
end;

procedure TfrmTDCTengah_Nala.Label50Click(Sender: TObject);
begin
  btn15Min.Click;
end;

procedure TfrmTDCTengah_Nala.Label49Click(Sender: TObject);
begin
  btnReset.Click;
end;



procedure TfrmTDCTengah_Nala.FormPaint(Sender: TObject);
begin
  inherited;

//  DrawAngle(Image1.Canvas);
end;

procedure TfrmTDCTengah_Nala.btnDataReq_LMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_left(0);

end;

procedure TfrmTDCTengah_Nala.btnDataReq_LMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  inherited;

end;

procedure TfrmTDCTengah_Nala.btnDataReq_RMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   TDCInterface.DataRequest_right(1);
end;

procedure TfrmTDCTengah_Nala.btnDataReq_RMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  inherited;

end;

end.
