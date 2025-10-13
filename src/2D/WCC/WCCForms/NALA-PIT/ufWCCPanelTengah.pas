unit ufWCCPanelTengah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uMapWindow,
  Dialogs, StdCtrls, Buttons, SpeedButtonImage, ImgList, ExtCtrls,
  Menus, OleCtrls, MapXLib_TLB, uLibTDCClass, VrControls, VrWheel;

type
  TfrmWCCPanelTengah = class(TfrmMapWindow)
    Panel1: TPanel;
    ILREDROUND: TImageList;
    ILREDBOX: TImageList;
    ILORANGEBOX: TImageList;
    ILORANGEROUND: TImageList;
    ILGREENBOX: TImageList;
    ILGREENROUND: TImageList;
    btnAN_R: TSpeedButtonImage;
    btnTV_R: TSpeedButtonImage;
    btnDAMTI_R: TSpeedButtonImage;
    BtnDALIN_R: TSpeedButtonImage;
    btnWMnonMTI: TSpeedButtonImage;
    btnDALOG_R: TSpeedButtonImage;
    btnWMMTI_R: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    ILBLUEBOX: TImageList;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnMRnonXXX_R: TSpeedButtonImage;
    Image1: TImage;
    btnRR_R: TSpeedButtonImage;
    btnIFF_R: TSpeedButtonImage;
    btnHM_R: TSpeedButtonImage;
    btnCUORoffCENT_R: TSpeedButtonImage;
    btnCUorCENT_R: TSpeedButtonImage;
    btnOFFCent_R: TSpeedButtonImage;
    btnCENT_R: TSpeedButtonImage;
    btnResetOBM_R: TSpeedButtonImage;
    btnICM1_R: TSpeedButtonImage;
    btnICM2_R: TSpeedButtonImage;
    btnICM3_R: TSpeedButtonImage;
    Label17: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    btnDataReq_R: TSpeedButtonImage;
    Image2: TImage;
    btnAN_L: TSpeedButtonImage;
    btnTV_L: TSpeedButtonImage;
    spbSetRange128: TSpeedButtonImage;
    spbSetRange64: TSpeedButtonImage;
    spbSetRange16: TSpeedButtonImage;
    spbSetRange32: TSpeedButtonImage;
    spbSetRange8: TSpeedButtonImage;
    Label27: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    btnMRnonXXX_L: TSpeedButtonImage;
    btnRR_L: TSpeedButtonImage;
    btnIFF_L: TSpeedButtonImage;
    btnHM_L: TSpeedButtonImage;
    btnCUORoffCENT_L: TSpeedButtonImage;
    btnCUorCENT_L: TSpeedButtonImage;
    btnOFFCent_L: TSpeedButtonImage;
    btnCENT_L: TSpeedButtonImage;
    btnResetOBM_L: TSpeedButtonImage;
    btnICM1_L: TSpeedButtonImage;
    btnICM2_L: TSpeedButtonImage;
    btnICM3_L: TSpeedButtonImage;
    Label40: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    btnDataReq_L: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOwnCurs: TSpeedButtonImage;
    btn12Sec: TSpeedButtonImage;
    btn30Sec: TSpeedButtonImage;
    btn15Min: TSpeedButtonImage;
    btn6Min: TSpeedButtonImage;
    btnReset: TSpeedButtonImage;
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
    Image3: TImage;
    Label64: TLabel;
    spbSetRange4: TSpeedButtonImage;
    PopupMenu2: TPopupMenu;
    wBearing: TVrWheel;
    wRange: TVrWheel;
    btnShowUpperPanel: TButton;
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
    procedure btnResetOBM_RClick(Sender: TObject);
    procedure btnDataReq_RClick(Sender: TObject);
    procedure SpeedButtonImage23Click(Sender: TObject);
    procedure SpeedButtonImage24Click(Sender: TObject);
    procedure SpeedButtonImage26Click(Sender: TObject);
    procedure SpeedButtonImage25Click(Sender: TObject);
    procedure SpeedButtonImage27Click(Sender: TObject);
    procedure btnIFF_LClick(Sender: TObject);
    procedure btnRR_LClick(Sender: TObject);
    procedure btnHM_LClick(Sender: TObject);
    procedure btnDataReq_LClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbSetRangeClick(Sender: TObject);
    procedure btnICM1_RClick(Sender: TObject);
    procedure btnICM2_RClick(Sender: TObject);
    procedure btnICM3_RClick(Sender: TObject);
    procedure btnICM1_LClick(Sender: TObject);
    procedure btnICM2_LClick(Sender: TObject);
    procedure btnICM3_LClick(Sender: TObject);
    procedure Reset_Scale_Button;
    procedure btnTV_LClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure btnHM_RClick(Sender: TObject);
    procedure btn12SecClick(Sender: TObject);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnCUORoffCENT_RClick(Sender: TObject);
    procedure btnCUorCENT_RClick(Sender: TObject);
    procedure wBearingChange(Sender: TObject);
    procedure wRangeChange(Sender: TObject);
    procedure btnShowUpperPanelClick(Sender: TObject);
  private
    { Private declarations }
    msDown : boolean; // flag mouse down;
    mIndex : integer; // marker index;

    procedure OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;
    procedure SetRangeScale(const  aScaleNm: double); override;

  end;

var
  frmWCCPanelTengah: TfrmWCCPanelTengah;

implementation

uses Math, uMainFormWCC2D;

{$R *.dfm}

procedure TfrmWCCPanelTengah.FormCreate(Sender: TObject);
begin
  inherited;

  Map.BackColor := clGray;
  Map.Width   := Image1.Width - 60;
  Map.Height  := Image1.Height- 60;
  Map.Left    := Image1.Left  + Panel1.Left + 30;
  Map.Top     := Image1.Top   + Panel1.Top  + 30;

  FCoverVisible := TRUE;

  SetRegionCircle;
 // setRange
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

  fMainTDC.CreateFormWCC(0);

  self.Show;
end;

procedure TfrmWCCPanelTengah.spbSetRangeClick(Sender: TObject);
var
  Ob : TSpeedButtonImage;
begin
  //inherited;
  SetRangeScale((sender as TComponent).Tag);

  Ob := Sender As TSpeedButtonImage;
//  if (ob.ImageIndex=1) then begin
    Reset_Scale_Button;
    ob.ImageIndex :=1;
//  end;
end;


procedure TfrmWCCPanelTengah.lblRange4Click(Sender: TObject);
begin
  if sender = lblRange4 then
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

procedure TfrmWCCPanelTengah.Reset_Scale_Button;
begin
  spbSetRange4.ImageIndex := 0;
  spbSetRange8.ImageIndex := 0;
  spbSetRange16.ImageIndex := 0;
  spbSetRange32.ImageIndex := 0;
  spbSetRange64.ImageIndex := 0;
  spbSetRange128.ImageIndex  := 0;
end;

procedure TfrmWCCPanelTengah.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
end;

procedure TfrmWCCPanelTengah.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
end;

procedure TfrmWCCPanelTengah.btnCUORoffCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);
end;

procedure TfrmWCCPanelTengah.btnCUorCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);

end;

//------------------------------------------------------------------------------
// center & off center;
procedure TfrmWCCPanelTengah.btnOFFCent_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);
end;

procedure TfrmWCCPanelTengah.btnCENT_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);
end;

procedure TfrmWCCPanelTengah.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
end;

procedure TfrmWCCPanelTengah.btnCENT_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
end;

//------------------------------------------------------------------------------
procedure TfrmWCCPanelTengah.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;

procedure TfrmWCCPanelTengah.btnResetOBM_RClick(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;
//------------------------------------------------------------------------------


procedure TfrmWCCPanelTengah.btnAIRClick(Sender: TObject);
begin
//  TDCControl1.AIR := btnAIR.ImageIndex;
//if (TDCControl1.AIR=1) then  TDCCOntrol1.AIR_Action;
end;

procedure TfrmWCCPanelTengah.btnSURFClick(Sender: TObject);
begin
//  TDCControl1.SURF := btnSURF.ImageIndex;
//if (TDCControl1.SURF=1) then  TDCCOntrol1.SURF_Action;
end;

procedure TfrmWCCPanelTengah.btnSUBSURFClick(Sender: TObject);
begin
//  TDCControl1.SUB_SURF := btnSUBSURF.ImageIndex;
//If (TDCControl1.SUB_SURF=1) Then  TDCCOntrol1.SUB_SURF_Action;
end;

procedure TfrmWCCPanelTengah.btnEWClick(Sender: TObject);
begin
//  TDCControl1.EW := btnEW.ImageIndex;
//if (TDCControl1.EW=1) then TDCCOntrol1.EW_Action;
end;

procedure TfrmWCCPanelTengah.btnNAVAidsClick(Sender: TObject);
begin
//TDCControl1.NAV_AIDS := btnNAVAids.ImageIndex;
//if (TDCControl1.NAV_AIDS=1) then TDCCOntrol1.NAV_AIDS_Action;
end;

procedure TfrmWCCPanelTengah.btnBLINDARCClick(Sender: TObject);
begin
//TDCControl1.BLIND_ARC := btnBLINDARC.ImageIndex;
//if (TDCControl1.BLIND_ARC=1) then TDCCOntrol1.BLIND_ARC_Action;
end;

procedure TfrmWCCPanelTengah.btnBLINDARCASWClick(Sender: TObject);
begin
//TDCControl1.BLIND_ARC_ASW := btnBLINDARCASW.ImageIndex;
//if (TDCControl1.BLIND_ARC_ASW=1) then TDCCOntrol1.BLIND_ARC_ASW_Action;
end;

procedure TfrmWCCPanelTengah.btnLPDTESTClick(Sender: TObject);
begin
//  TDCControl1.LPD_TEST := btnLPDTEST.ImageIndex;
//if (TDCControl1.LPD_TEST=1) then  TDCCOntrol1.LPD_TEST_Action;
end;

procedure TfrmWCCPanelTengah.btnDAMTI_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_MTI_Status(btnDAMTI_R.Down);
end;
procedure TfrmWCCPanelTengah.Label46Click(Sender: TObject);
begin
  btnDAMTI_R.Click;
end;

procedure TfrmWCCPanelTengah.BtnDALIN_RClick(Sender: TObject);
begin
//  TDCControl1.DA_LIN := BtnDALIN_R.ImageIndex;
//if (TDCControl1.DA_LIN=1) then  TDCCOntrol1.DA_LIN_Action;
end;

procedure TfrmWCCPanelTengah.btnDALOG_RClick(Sender: TObject);
begin
//  TDCControl1.DA_LOG := btnDALOG_R.ImageIndex;
//if (TDCControl1.DA_LOG=1) then  TDCCOntrol1.DA_LOG_Action;
end;

procedure TfrmWCCPanelTengah.btnWMnonMTIClick(Sender: TObject);
begin
//  TDCControl1.WM_NONMTI := btnWMnonMTI.ImageIndex;
//if (TDCControl1.WM_NONMTI=1) then  TDCCOntrol1.WM_NONMTI_Action;
end;

procedure TfrmWCCPanelTengah.btnWMMTI_RClick(Sender: TObject);
begin
//  TDCControl1.WM_MTI := btnWMMTI_R.ImageIndex;
//if (TDCControl1.WM_MTI=1) then  TDCCOntrol1.WM_MTI_Action;
end;

procedure TfrmWCCPanelTengah.btnIFF_RClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kanan.IFF := btnIFF_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.IFF=1) then  TDCCOntrol1.TDC_Kanan.IFF_Action;
end;



procedure TfrmWCCPanelTengah.btnDataReq_RClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kanan.DATA_REQ := btnDataReq_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.DATA_REQ=1) then  TDCCOntrol1.TDC_Kanan.DATA_REQ_Action;
end;

procedure TfrmWCCPanelTengah.SpeedButtonImage23Click(Sender: TObject);
begin
{if (SpeedButtonImage23.ImageIndex=0) then
  TDCControl.TDC_Kiri.DA_MTI := False
else
  TDCControl.TDC_Kiri.DA_MTI := True;
TDCCOntrol.TDC_Kiri.DA_MTI_Action;
}
end;

procedure TfrmWCCPanelTengah.SpeedButtonImage24Click(Sender: TObject);
begin
{if (SpeedButtonImage24.ImageIndex=0) then
  TDCControl.TDC_Kiri.DA_LIN := False
else
  TDCControl.TDC_Kiri.DA_LIN := True;
TDCCOntrol.TDC_Kiri.DA_LIN_Action;
}
end;

procedure TfrmWCCPanelTengah.SpeedButtonImage26Click(Sender: TObject);
begin
{if (SpeedButtonImage26.ImageIndex=0) then
  TDCControl.TDC_Kiri.DA_LOG := False
else
  TDCControl.TDC_Kiri.DA_LOG := True;
TDCCOntrol.TDC_Kiri.DA_LOG_Action;
}
end;

procedure TfrmWCCPanelTengah.SpeedButtonImage25Click(Sender: TObject);
begin
{if (SpeedButtonImage25.ImageIndex=0) then
  TDCControl.TDC_Kiri.WM_NONMTI := False
else
  TDCControl.TDC_Kiri.WM_NONMTI := True;
TDCCOntrol.TDC_Kiri.WM_NONMTI_Action;
}
end;

procedure TfrmWCCPanelTengah.SpeedButtonImage27Click(Sender: TObject);
begin
{  if (SpeedButtonImage27.ImageIndex=0) then
    TDCControl.TDC_Kiri.WM_MTI := False
  else
    TDCControl.TDC_Kiri.WM_MTI := True;
  TDCCOntrol.TDC_Kiri.WM_MTI_Action;
}
end;

procedure TfrmWCCPanelTengah.btnIFF_LClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kiri.IFF := btnIFF_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.IFF=1) then  TDCCOntrol1.TDC_Kiri.IFF_Action;
end;



procedure TfrmWCCPanelTengah.btnDataReq_LClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kiri.DATA_REQ := btnDataReq_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.DATA_REQ =10) then TDCCOntrol1.TDC_Kiri.DATA_REQ_Action;
end;


procedure TfrmWCCPanelTengah.btnICM1_RClick(Sender: TObject);
begin
// First ICM button on Right TDC -1
//TDCControl1.TDC_Kanan.ICM.First := btnICM1_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.ICM.First =1) then  TDCCOntrol1.TDC_Kanan.ICM_Action(1);
end;

procedure TfrmWCCPanelTengah.btnICM2_RClick(Sender: TObject);
begin
//  inherited;
//  TDCControl1.TDC_Kanan.ICM.Second := btnICM2_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.ICM.Second=1) then  TDCCOntrol1.TDC_Kanan.ICM_Action(2);
end;

procedure TfrmWCCPanelTengah.btnICM3_RClick(Sender: TObject);
begin
//  inherited;
//  TDCControl1.TDC_Kanan.ICM.Third := btnICM3_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.ICM.Third=1) then  TDCCOntrol1.TDC_Kanan.ICM_Action(3);
end;

procedure TfrmWCCPanelTengah.btnICM1_LClick(Sender: TObject);
begin
//  inherited;
//  TDCControl1.TDC_Kiri.ICM.First := btnICM1_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.ICM.First=1) then TDCCOntrol1.TDC_Kiri.ICM_Action(1);
end;

procedure TfrmWCCPanelTengah.btnICM2_LClick(Sender: TObject);
begin
//  inherited;
//  TDCControl1.TDC_Kiri.ICM.Second := btnICM2_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.ICM.Second=1) then TDCCOntrol1.TDC_Kiri.ICM_Action(2);
end;

procedure TfrmWCCPanelTengah.btnICM3_LClick(Sender: TObject);
begin
//  inherited;
//  TDCControl1.TDC_Kiri.ICM.Third := btnICM3_L.ImageIndex;
//if (TDCControl1.TDC_Kiri.ICM.Third=1) then TDCCOntrol1.TDC_Kiri.ICM_Action(3);
end;

procedure TfrmWCCPanelTengah.btnTV_LClick(Sender: TObject);
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

//--- Range Ring Tombol kiri
procedure TfrmWCCPanelTengah.btnRR_LClick(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing(btnRR_L.Down);
  SetDown(btnRR_R, btnRR_L.Down);
end;

procedure TfrmWCCPanelTengah.Label31Click(Sender: TObject);
begin
  btnRR_L.Click;
end;

//--- Range Ring Tombol kanan
procedure TfrmWCCPanelTengah.btnRR_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing(btnRR_R.Down);
  SetDown(btnRR_L, btnRR_R.Down);
end;

procedure TfrmWCCPanelTengah.Label8Click(Sender: TObject);
begin
  btnRR_R.Click;
end;


//--- HEADING MARKER tombol kiri --
procedure TfrmWCCPanelTengah.btnHM_LClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_L.Down);
  SetDown(btnHM_R, btnHM_L.Down);
end;

procedure TfrmWCCPanelTengah.Label32Click(Sender: TObject);
begin
  btnHM_L.Click;
end;

//--- HEADING MARKER tombol kanan --
procedure TfrmWCCPanelTengah.btnHM_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_R.Down);
  SetDown(btnHM_L, btnHM_R.Down);
end;

procedure TfrmWCCPanelTengah.Label9Click(Sender: TObject);
begin
  btnHM_R.Click;
end;

procedure TfrmWCCPanelTengah.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;

procedure TfrmWCCPanelTengah.lblBtnTMClick(Sender: TObject);
begin
  btnTM.Click;
end;


procedure TfrmWCCPanelTengah.SetRangeScale(const aScaleNm: double);
begin
  TDCInterface.SetRadar_Range(aScaleNm);

end;



procedure TfrmWCCPanelTengah.btn12SecClick(Sender: TObject);
begin
  //TDCInterface.
end;

procedure TfrmWCCPanelTengah.MapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var lPt  : TPoint;
begin
  //inherited;

  msDown := Button = mbLeft;
  lpt.X  := X;
  lpt.Y  := Y;
  mIndex := TDCInterface.FindMarkerByPosition(lPt);
  TDCInterface.SelectedMarkerTool := mIndex;

  if mIndex < 0 then begin
    Map.OnMouseMove := nil;

    exit;
  end;

  case mIndex of

    i_OBM_kiri  : begin
      Map.OnMouseMove := OBMKiri_MapMouseMove;
    end;
    i_OBM_kanan : begin
      Map.OnMouseMove := OBMKanan_MapMouseMove;
    end;
    {: begin
    end;}

  end;

end;

procedure TfrmWCCPanelTengah.MapMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  //inherited;
 //
end;

procedure TfrmWCCPanelTengah.OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TDCInterface.OBMLeft_SetPosition(X, Y);
end;

procedure TfrmWCCPanelTengah.OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TDCInterface.OBMRight_SetPosition(X, Y);

end;

procedure TfrmWCCPanelTengah.MapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  Map.OnMouseMove := nil;
  msDown := FALSE;
  mIndex := -1;
  TDCInterface.SelectedMarkerTool := -1;

end;

procedure TfrmWCCPanelTengah.wBearingChange(Sender: TObject);
begin

  TDCInterface.CursorSetBearing(wBearing.Position);

end;

procedure TfrmWCCPanelTengah.wRangeChange(Sender: TObject);
begin

 TDCInterface.CursorSetRange(wRange.Position);

end;

procedure TfrmWCCPanelTengah.btnShowUpperPanelClick(Sender: TObject);
begin
  inherited;
  fMainTDC.fWCCpanelAtas.Show;
end;

end.
