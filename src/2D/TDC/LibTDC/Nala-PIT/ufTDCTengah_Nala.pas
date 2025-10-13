unit ufTDCTengah_Nala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

  Dialogs, StdCtrls, Buttons, SpeedButtonImage, ImgList, ExtCtrls,  ufTDCTengah,
  VrDigit, VrControls, VrWheel, Menus, OleCtrls, MapXLib_TLB, ShellAPI,
  uLibTDC_Nala, ufLog ;

type
  TfrmTDCTengah_Nala = class(TfrmTDCTengah)
    PopupMenu2: TPopupMenu;
    pnlLeft: TPanel;
    btnMRnonXXX_L: TSpeedButtonImage;
    btnTV_L: TSpeedButtonImage;
    btnAN_L: TSpeedButtonImage;
    lbl1: TLabel;
    bvl1: TBevel;
    SpbSetRange64: TSpeedButtonImage;
    SpbSetRange128: TSpeedButtonImage;
    SpbSetRange32: TSpeedButtonImage;
    SpbSetRange16: TSpeedButtonImage;
    SpbSetRange8: TSpeedButtonImage;
    SpbSetRange4: TSpeedButtonImage;
    SpbSetRange2: TSpeedButtonImage;
    bvl2: TBevel;
    pnlRight: TPanel;
    SpbAN_R: TSpeedButtonImage;
    SpbTV_R: TSpeedButtonImage;
    SpbMRnonXXX_R: TSpeedButtonImage;
    bvl7: TBevel;
    lbl3: TLabel;
    bvl8: TBevel;
    btnDAMTI_R: TSpeedButtonImage;
    btnDALIN_R: TSpeedButtonImage;
    btnDALOG_R: TSpeedButtonImage;
    btnWMnonMTI: TSpeedButtonImage;
    btnWMMTI_R: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    btnIFF_R: TSpeedButtonImage;
    btnRR_R: TSpeedButtonImage;
    btnHM_R: TSpeedButtonImage;
    pnlLeftbottom: TPanel;
    btnCENT_L: TSpeedButtonImage;
    bvl6: TBevel;
    bvl5: TBevel;
    lbl2: TLabel;
    bvl4: TBevel;
    bvl3: TBevel;
    btnICM1_L: TSpeedButtonImage;
    btnICM2_L: TSpeedButtonImage;
    btnICM3_L: TSpeedButtonImage;
    btnDataReq_L: TSpeedButtonImage;
    btnResetOBM_L: TSpeedButtonImage;
    btnOFFCent_L: TSpeedButtonImage;
    btnCUorCENT_L: TSpeedButtonImage;
    btnCUORoffCENT_L: TSpeedButtonImage;
    pnlRightBottom: TPanel;
    btnCENT_R: TSpeedButtonImage;
    bvl10: TBevel;
    bvl12: TBevel;
    lbl4: TLabel;
    bvl11: TBevel;
    bvl9: TBevel;
    btnICM1_R: TSpeedButtonImage;
    btnICM2_R: TSpeedButtonImage;
    btnICM3_R: TSpeedButtonImage;
    btnDataReq_R: TSpeedButtonImage;
    btnResetOBM_R: TSpeedButtonImage;
    btnOFFCent_R: TSpeedButtonImage;
    btnCUorCENT_R: TSpeedButtonImage;
    btnCUORoffCENT_R: TSpeedButtonImage;
    ImagePnlRange: TImage;
    ImagePnlBearing: TImage;
    btnTM: TSpeedButtonImage;
    btnOwnCurs: TSpeedButtonImage;
    btnMS: TSpeedButtonImage;
    btnArrow: TSpeedButtonImage;
    btnAMPLInfo: TSpeedButtonImage;
    btnLINK: TSpeedButtonImage;
    btnTN: TSpeedButtonImage;
    lbl5: TLabel;
    bvl13: TBevel;
    bvl14: TBevel;
    bvl15: TBevel;
    bvl16: TBevel;
    btn12Sec: TSpeedButtonImage;
    btn30Sec: TSpeedButtonImage;
    btn6Min: TSpeedButtonImage;
    btn15Min: TSpeedButtonImage;
    btnReset: TSpeedButtonImage;
    lbl6: TLabel;
    bvl20: TBevel;
    bvl18: TBevel;
    bvl17: TBevel;
    bvl19: TBevel;
    btnAIR: TSpeedButtonImage;
    btnSURF: TSpeedButtonImage;
    btnSUBSURF: TSpeedButtonImage;
    btnEW: TSpeedButtonImage;
    btnNAVAids: TSpeedButtonImage;
    btnBLINDARC: TSpeedButtonImage;
    lbl7: TLabel;
    bvl21: TBevel;
    bvl22: TBevel;
    bvl23: TBevel;
    bvl24: TBevel;
    btnLPDTEST: TSpeedButtonImage;
    btnBLINDARCASW: TSpeedButtonImage;
    PopupMenu3: TPopupMenu;
    close1: TMenuItem;
    PopupMenu4: TPopupMenu;
    Log1: TMenuItem;
    mniCloseandRestart1: TMenuItem;
    mnclose: TMenuItem;
    m1: TPanel;
    btn1: TButton;
    grp1: TGroupBox;
    chkRestart: TRadioButton;
    chkShutdown: TRadioButton;
    chkrbclose: TRadioButton;
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
    procedure btnHM_RClick(Sender: TObject);
    procedure btn12SecClick(Sender: TObject);
    procedure btnCUORoffCENT_RClick(Sender: TObject);
    procedure btnCUorCENT_RClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure btnArrowClick(Sender: TObject);
    procedure btnAMPLInfoClick(Sender: TObject);
    procedure btnLINKClick(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
    procedure btnOwnCursClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnDataReq_LMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_LMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDataReq_RMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pmnFullscreenClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbl4DblClick(Sender: TObject);
    procedure lbl2DblClick(Sender: TObject);
    procedure close1Click(Sender: TObject);
    procedure Log1Click(Sender: TObject);
    procedure mniCloseandRestart1Click(Sender: TObject);
    procedure SpbAN_RClick(Sender: TObject);
    procedure btnAN_LClick(Sender: TObject);
    procedure SpbMRnonXXX_RClick(Sender: TObject);
    procedure mncloseClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure lbl5DblClick(Sender: TObject);
    procedure lbl7DblClick(Sender: TObject);
    procedure lbl6DblClick(Sender: TObject);
    procedure SpeedButtonImage7Click(Sender: TObject);
  private
    ShowCtrlpnl : boolean;
    ClickNum: integer;
//   NalaInterface : TTDC_NalaInterface;

    procedure Reset_Scale_Button;
    procedure Reset_RadarSelect_Button;

    procedure Reset_Threat_Button;
    procedure Reset_ICML_Button;
    procedure Reset_ICMR_Button;

    procedure SetUpdownImage(var spb : TSpeedButtonImage);

    procedure Set_layOutTDCTengahinto5monitor;
    procedure Set_layOutTDCTengahinto1monitor;
    procedure Set_layOutTDCTengahinto4monitor;
  public
     cheat : Integer;
    { Public declarations }
    function WindowsExit(RebootParam: Longword): Boolean;


  end;

implementation

uses Math, uBaseConstan, uLibRAdar, uLibTDCClass, uTDCConstan, uMainFormTDC,
uCompassDisplay, uSettingFormToMonitorWith_ini;
{$R *.dfm}

procedure TfrmTDCTengah_Nala.FormCreate(Sender: TObject);
var i: integer;
   spb : TSpeedButtonImage;
begin
  cheat :=0;
  inherited;
  ShowCtrlpnl := False;
  FCoverVisible := TRUE;

  SetRegionCircle;
 // setRange
  spbSetRange2.Tag    := 2;

  spbSetRange4.Tag    := 4;

  spbSetRange8.Tag    := 8;

  spbSetRange16.Tag   := 16;

  spbSetRange32.Tag   := 32;

  spbSetRange64.Tag   := 64;

  spbSetRange128.Tag  := 128;
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

//  NalaInterface := TTDC_NalaInterface.Create;

    // setting layout form tengah
  case Screen.MonitorCount of
    1,2 : Set_layOutTDCTengahinto1monitor;
    4 : Set_layOutTDCTengahinto4monitor;
    5 : Set_layOutTDCTengahinto5monitor;
  end;


  if Screen.MonitorCount > 2 then begin
      Image1.Height := 1150;
      Image1.Width:= Image1.Height;
    end
  else begin
      Image1.Height := 764;
      Image1.Width:= Image1.Height;
    end;

  Map.BackColor := clGray;
  Map.Width   := Image1.Width  - 55;
  Map.Height  := Image1.Height - 55;
  Map.Left    := Image1.Left  + Panel1.Left + 28;
  Map.Top     := Image1.Top   + Panel1.Top  + 28;


  img1.Top  := pnl1.Top - img1.Height;
  img2.Top  := img1.Top;
  img1.Left := pnl1.Left + 38;
  img2.Left := img1.Left + 978;

  wBearing.Height := 150;
  wBearing.Width  := wBearing.Height;
  wRange.Height   := wBearing.Width;
  wRange.Width    := wRange.Height;
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

procedure TfrmTDCTengah_Nala.SpeedButtonImage7Click(Sender: TObject);
begin
  inherited;
  inc(cheat);
  if cheat > 5 then
  cheat :=0;

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
procedure TfrmTDCTengah_Nala.Reset_ICML_Button;
begin
  btnICM1_L.ImageIndex := 0;
  btnICM2_L.ImageIndex := 0;
  btnICM3_L.ImageIndex := 0;
  btnICM1_R.ImageIndex := 0;
  btnICM2_R.ImageIndex := 0;
  btnICM3_R.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Nala.Reset_ICMR_Button;
begin
  btnICM1_R.ImageIndex := 0;
  btnICM2_R.ImageIndex := 0;
  btnICM3_R.ImageIndex := 0;
end;

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

procedure TfrmTDCTengah_Nala.Set_layOutTDCTengahinto1monitor;
var KompLeft, KompRight, SetBottomPanelLeft, SetBottomPanelTop, SetRadarleft: Integer;
  add : string;
  c :TDrawCompass;
begin
  add := ExtractFilePath(Application.ExeName) + 'SetFormToMonitor.ini';
  SetRadarleft       := LoadSet_LayOut(add,  'RADAR', 'RLEFT', T_Def);
  // setting layout form tengah
  Width := 1920;
  Height:= 1080;
  // radar
  Image1.Height := 764;
  Image1.width  := Image1.Height;

  Image1.Left   := ((Width - Image1.Width ) div 2) + SetRadarleft;
  Image1.Top    := 10;
  Map.Left      := Image1.Left + 33;
  Map.Top       := Image1.Top + 33;

  pnlLeft.Left  := 0;
  pnlLeft.Top   := 0;

  pnlLeftbottom.Top:= ((height - pnlLeftbottom.Height) div 2)+40;

  pnlLeftbottom.Left:= 0;

  pnlRight.Left := width - pnlRight.width;
  pnlRight.Top  := pnlLeft.Top;;

  pnlRightBottom.Top  := pnlLeftbottom.Top;
  pnlRightBottom.Left := Width - pnlRightBottom.Width;

  // Panel Rnge & bering
  Panel3.top:= 300;
  pnlRange.top := Panel3.top;

  // setting panel digital Left position
  Panel3.Left := 300;
  pnlRange.Left := Panel3.Left + ImagePnlBearing.Width + 810 ;

  ImagePnlBearing.top := Panel3.top - 60;
  ImagePnlBearing.left:= Panel3.Left-55;
  ImagePnlBearing.Width := Panel3.Width + 110;
  ImagePnlBearing.Height := Panel3.Height + 100;


  ImagePnlRange.top := ImagePnlBearing.top ;
  ImagePnlRange.left:= pnlRange.Left-54;
  ImagePnlRange.Width:=  ImagePnlBearing.Width;
  ImagePnlRange.Height := ImagePnlBearing.Height;

  pnl1.Left := 336;//(Screen.Monitors[1].width + ((Screen.Monitors[4].Width -  pnl1.width) div 2));
  pnl1.Top  := 775;


end;


procedure TfrmTDCTengah_Nala.Set_layOutTDCTengahinto4monitor;
var KompLeft, KompTop, KompRight,
    SetPanelTengahLeft, SetPanelTengahTop,

    SetRadarleft,
    pnlRBTop, pnlRBLeft,

    SetBottomPanelLeft, SetBottomPanelTop
    : Integer;
  add : string;
begin
  add := ExtractFilePath(Application.ExeName) + 'SetFormToMonitor.ini';
  KompLeft           := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELKIRI', T_Def);
  KompTop            := LoadSet_LayOut(add, 'SETLEFTPANEL','PANELKIRIKANANTOP', T_Def);
  KompRight          := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELKANAN', T_Def);

  SetPanelTengahLeft := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELTENGAHKIRILEFT', T_Def);
  SetPanelTengahTop  := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELTENGAHTOP', T_Def);

  SetBottomPanelLeft := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELBOTTOMLEFT', T_Def);

  SetBottomPanelTop  := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELBOTTOMTOP', T_Def);

  SetRadarleft       := LoadSet_LayOut(add,  'RADAR', 'RLEFT', T_Def);
  pnlRBTop           := LoadSet_LayOut(add,  'RADAR', 'RBTOP', T_Def);
  pnlRBLeft          := LoadSet_LayOut(add,  'RADAR', 'RBLEFT', T_Def);
  // setting layout form tengah
  Left  := Screen.Monitors[3].Left;
  Width := Screen.Monitors[3].Width + Screen.Monitors[0].Width + Screen.Monitors[2].Width;
  Height:= Screen.Monitors[0].Height + Screen.Monitors[1].Height;

  Image1.Height := 1040;
  Image1.width  := Image1.Height;
  Image1.Left   := ((Width - Image1.Width ) div 2) + SetRadarleft;
  Image1.Top    := 10;

  Map.Width     := Image1.Width - 60;
  Map.Height    := Image1.Height - 60;
  Map.Left      := Image1.Left + 30;
  Map.Top       := Image1.Top + 30;
  SetRegionCircle;

  pnlLeft.Left := 574 + KompLeft;
  pnlLeft.Top  := 150 + KompTop;

  pnlLeftbottom.Top:= ((Screen.Monitors[1].height - pnlLeftbottom.Height) div 2)+60;
  pnlLeftbottom.Left:= 785 + KompLeft;

  pnlRight.Left := Screen.Monitors[1].width + Screen.Monitors[0].width + KompRight;
  pnlRight.Top  := pnlLeft.Top;;

  pnlRightBottom.Top  := pnlLeftbottom.Top;
  pnlRightBottom.Left := Screen.Monitors[1].width + Screen.Monitors[0].width + KompRight;

  // Panel Rnge & bering
  Panel3.top:= 65 + pnlRBTop;                         // set top pos
  pnlRange.top := Panel3.top;
  // setting panel digital Left position
  Panel3.Left := 1090 + pnlRBLeft;                    // set left pos
  pnlRange.Left := Panel3.Left + 1240;

  ImagePnlBearing.top :=5;
  ImagePnlBearing.left:= Panel3.Left-55;
  ImagePnlBearing.Width := Panel3.Width + 110;
  ImagePnlBearing.Height := Panel3.Height + 100;


  ImagePnlRange.top    :=5;
  ImagePnlRange.left   := pnlRange.Left-54;
  ImagePnlRange.Width  :=  ImagePnlBearing.Width;
  ImagePnlRange.Height := ImagePnlBearing.Height;

  pnl1.Left := (Screen.Monitors[3].width + ((Screen.Monitors[2].Width -  pnl1.width) div 2)) + SetBottomPanelLeft; // 1225;
  pnl1.Top  := (Screen.Monitors[2].Top + img1.Height + 30) + SetBottomPanelTop;
end;

procedure TfrmTDCTengah_Nala.Set_layOutTDCTengahinto5monitor;
var KompLeft, KompTop, KompRight,
    SetPanelTengahLeft, SetPanelTengahTop, SetPanelTengahRight,
    SetBottomPanelLeft, SetBottomPanelTop,
    SetRadarleft,
    pnlRBTop, pnlRBLeft: Integer;
  add : string;
begin
  add := ExtractFilePath(Application.ExeName) + 'SetFormToMonitor.ini';
  pnlRBTop           := LoadSet_LayOut(add,  'RADAR', 'RBTOP', T_Def);
  pnlRBLeft          := LoadSet_LayOut(add,  'RADAR', 'RBLEFT', T_Def);

  SetRadarleft       := LoadSet_LayOut(add,  'RADAR', 'RLEFT', T_Def);

  KompLeft           := LoadSet_LayOut(add, 'SETLEFTPANEL','PANELKIRI', T_Def);
  KompTop            := LoadSet_LayOut(add, 'SETLEFTPANEL','PANELKIRIKANANTOP', T_Def);
  KompRight          := LoadSet_LayOut(add, 'SETLEFTPANEL','PANELKANAN', T_Def);

  SetPanelTengahLeft := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELTENGAHKIRI', T_Def);
  SetPanelTengahTop  := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELTENGAHTOP', T_Def);
  SetPanelTengahRight:= LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELTENGAHKANAN', T_Def);

  SetBottomPanelLeft := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELBAWAHLEFT', T_Def);
  SetBottomPanelTop  := LoadSet_LayOut(add, 'SETLEFTPANEL', 'PANELBAWAHTOP', T_Def);

// setting layout form tengah
  Left  := Screen.Monitors[1].Left;
  Width := 3645;
  Height:= 2624;

  Image1.Height := 1150;
  Image1.width  := Image1.Height;
  Image1.Left   := ((Width - Image1.Width ) div 2) + SetRadarleft;
  Image1.Top    := 10;

  Map.Width     := Image1.Width - 60;
  Map.Height    := Image1.Height - 60;
  Map.Left      := Image1.Left + 30;
  Map.Top       := Image1.Top + 30;
  SetRegionCircle;

  pnlLeft.Left := 574 + KompLeft;
  pnlLeft.Top  := 150 + KompTop;
  pnlRight.Left := Screen.Monitors[1].width + Screen.Monitors[0].width + KompRight;
  pnlRight.Top  := pnlLeft.Top;;

  pnlLeftbottom.Top   := ((Screen.Monitors[1].height - pnlLeftbottom.Height) div 2) + 40 + SetPanelTengahTop;
  pnlLeftbottom.Left  := 785 + SetPanelTengahLeft;
  pnlRightBottom.Top  := pnlLeftbottom.Top;
  pnlRightBottom.Left := pnlLeftbottom.Left + 1000 + SetPanelTengahRight;

  // Panel Rnge & bering
  Panel3.top:= 65 + pnlRBTop;                         // set top pos
  pnlRange.top := Panel3.top;
  // setting panel digital Left position
  Panel3.Left := 1090 + pnlRBLeft;                    // set left pos
  pnlRange.Left := Panel3.Left + 1240;

  ImagePnlBearing.top :=5;
  ImagePnlBearing.left:= Panel3.Left-55;
  ImagePnlBearing.Width := Panel3.Width + 110;
  ImagePnlBearing.Height := Panel3.Height + 100;


  ImagePnlRange.top     :=5;
  ImagePnlRange.left    := pnlRange.Left-54;
  ImagePnlRange.Width   := ImagePnlBearing.Width;
  ImagePnlRange.Height  := ImagePnlBearing.Height;

  pnl1.Left := 1300 + SetBottomPanelLeft;;
  pnl1.Top  := 1300 + SetBottomPanelTop;

end;

procedure TfrmTDCTengah_Nala.SpbAN_RClick(Sender: TObject);
begin
  inherited;
//  (TDCInterface as TTDC_NalaInterface).frmMIK_Kanan.Visible := SpbAN_R.Down;
//  (TDCInterface as TTDC_NalaInterface).frmDisplay_Kanan.Visible:= SpbAN_R.Down;

end;

procedure TfrmTDCTengah_Nala.SpbMRnonXXX_RClick(Sender: TObject);
begin
  inherited;
  m1.Top := pnlRightBottom.Top + (pnlRightBottom.Height div 2);
  m1.Left:= pnlRightBottom.Left + pnlRightBottom.Width;
  m1.Visible := cheat = 5;
  cheat := 0;
end;

// --------------------------------------------------------------------------
procedure TfrmTDCTengah_Nala.btnCUORoffCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);
//    btnCUORoffCENT_L.ImageIndex := 0;
  btnCUorCENT_L.ImageIndex    := 0;
  btnCUORoffCENT_L.ImageIndex := 1;
end;
procedure TfrmTDCTengah_Nala.btnCUorCENT_LClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);
  btnCUORoffCENT_L.ImageIndex := 0;
//  btnCUorCENT_L.ImageIndex    := 0;
  btnCUorCENT_L.ImageIndex    := 1;
end;

procedure TfrmTDCTengah_Nala.btnOFFCent_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnOFFCent_L.ImageIndex := 1;
  btnCent_L.ImageIndex := 0;
end;

procedure TfrmTDCTengah_Nala.btnCENT_LClick(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);
  btnOFFCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 0;
  btnCent_L.ImageIndex := 1;
end;

procedure TfrmTDCTengah_Nala.btnCUORoffCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);
end;
procedure TfrmTDCTengah_Nala.btnCUorCENT_RClick(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);
end;
procedure TfrmTDCTengah_Nala.btnOFFCent_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);
end;
procedure TfrmTDCTengah_Nala.btnCENT_RClick(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);
end;
procedure TfrmTDCTengah_Nala.btnResetOBM_LClick(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;
end;
procedure TfrmTDCTengah_Nala.btnResetOBM_RClick(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;
end;

procedure TfrmTDCTengah_Nala.btn1Click(Sender: TObject);
begin
  inherited;
  //  inherited;

if chkShutdown.Checked then
  WindowsExit(EWX_POWEROFF or EWX_FORCE);   //Shutdown
if chkRestart.Checked then
  WindowsExit(EWX_REBOOT or EWX_FORCE);    //Restart
if chkrbclose.Checked then
  Application.Terminate;    //close
end;

procedure TfrmTDCTengah_Nala.btnAIRClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  btnAir.Down);
end;
procedure TfrmTDCTengah_Nala.btnSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, btnSurf.Down)
end;
procedure TfrmTDCTengah_Nala.btnSUBSURFClick(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir, btnSUBSURF.Down)
end;
procedure TfrmTDCTengah_Nala.btnEWClick(Sender: TObject);
begin
  TDCInterface.Filter(tdEW, btnEW.Down)
end;

procedure TfrmTDCTengah_Nala.btnNAVAidsClick(Sender: TObject);
begin
//TDCControl1.NAV_AIDS := btnNAVAids.ImageIndex;
//if (TDCControl1.NAV_AIDS=1) then TDCCOntrol1.NAV_AIDS_Action;
end;

procedure TfrmTDCTengah_Nala.btnBLINDARCClick(Sender: TObject);
begin
  TDCInterface.SetBlindARC(btnBLINDARC.Down);
  if btnBLINDARC.Down then
    btnBLINDARC.ImageIndex := 1
  else
    btnBLINDARC.ImageIndex := 0;

end;
procedure TfrmTDCTengah_Nala.btnBLINDARCASWClick(Sender: TObject);
begin
  TDCInterface.SetBlindARCASW(btnBLINDARCASW.Down);
  if btnBLINDARCASW.Down then
    btnBLINDARCASW.ImageIndex := 1
  else
    btnBLINDARCASW.ImageIndex := 0;

//  TDCControl1.BLIND_ARC_ASW := btnBLINDARCASW.ImageIndex;
//  if (TDCControl1.BLIND_ARC_ASW=1) then TDCCOntrol1.BLIND_ARC_ASW_Action;
end;

procedure TfrmTDCTengah_Nala.btnLPDTESTClick(Sender: TObject);
begin
  TDCInterface.SetLPDTest(btnLPDTEST.Down);
  SetUpdownImage(btnLPDTEST);
end;

procedure TfrmTDCTengah_Nala.btnDAMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05); {speed 10}
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;
procedure TfrmTDCTengah_Nala.BtnDALIN_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05); {speed 10}
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLiner);
end;

procedure TfrmTDCTengah_Nala.btnDALOG_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtDA_05); {speed 10}
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);
end;

procedure TfrmTDCTengah_Nala.btnWMnonMTIClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;

  TDCInterface.SetRadar_type(rtWM_28); {speed 60}
  TDCInterface.SetRadar_MTI_Status(FALSE);
end;
procedure TfrmTDCTengah_Nala.close1Click(Sender: TObject);
begin
//  inherited;
   Application.Terminate;
   WindowsExit(EWX_POWEROFF or EWX_FORCE) ;  //Shutdown

end;

Procedure TfrmTDCTengah_Nala.btnWMMTI_RClick(Sender: TObject);
begin
  Reset_RadarSelect_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
  TDCInterface.SetRadar_type(rtWM_28); {speed 60}
  TDCInterface.SetRadar_MTI_Status(TRUE);
end;

procedure TfrmTDCTengah_Nala.btnIFF_RClick(Sender: TObject);
begin
//  TDCControl1.TDC_Kanan.IFF := btnIFF_R.ImageIndex;
//if (TDCControl1.TDC_Kanan.IFF=1) then  TDCCOntrol1.TDC_Kanan.IFF_Action;

  m1.Top := pnlRightBottom.Top + (pnlRightBottom.Height div 2);
  m1.Left:= pnlRightBottom.Left + pnlRightBottom.Width;
  m1.Visible := cheat = 5;
  cheat := 0;
end;
procedure TfrmTDCTengah_Nala.btnDataReq_RClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Right(1);
end;

procedure TfrmTDCTengah_Nala.btnDataReq_LClick(Sender: TObject);
begin
  TDCInterface.DataRequest_Left(1);
end;

procedure TfrmTDCTengah_Nala.btnICM_RClick(Sender: TObject);
var num: byte;
begin
  Reset_ICML_Button;

  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
  begin
    TDCInterface.StartICMRight(num,
      TDCInterface.OBMRight.mPos.X , TDCInterface.OBMRight.mPos.Y);

    (Sender as TSpeedButtonImage).ImageIndex := 1;
  end
  else
    TDCInterface.EndICMRight(num);
end;


procedure TfrmTDCTengah_Nala.btnICM_LClick(Sender: TObject);
var num: byte;
begin
  Reset_ICML_Button;

  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
  begin
    TDCInterface.StartICMLeft(num,
      TDCInterface.OBMleft.mPos.X , TDCInterface.OBMleft.mPos.Y);

    (Sender as TSpeedButtonImage).ImageIndex := 1;
  end
  else
    TDCInterface.EndICMLeft(num);
end;


procedure TfrmTDCTengah_Nala.btnTV_LClick(Sender: TObject);
begin
//  inherited;
  m1.Top := pnlLeftbottom.Top - (pnlLeftbottom.Height div 2);
  m1.Left:= pnlLeftbottom.Left - pnlLeftbottom.Width;
  m1.Visible := cheat = 5;
  cheat := 0;
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

procedure TfrmTDCTengah_Nala.btnHM_RClick(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker(btnHM_R.Down);
 // SetDown(btnHM_L, btnHM_R.Down);
end;

procedure TfrmTDCTengah_Nala.btnTMClick(Sender: TObject);
begin
  TDCInterface.TrueMotion := btnTM.Down;
end;

procedure TfrmTDCTengah_Nala.btnMSClick(Sender: TObject);
begin
  TDCInterface.SetMainSymbolVisible(btnMS.Down);
end;

procedure TfrmTDCTengah_Nala.btnArrowClick(Sender: TObject);
begin
  TDCInterface.SetCourseVisible(btnArrow.Down);
  if Assigned(frmLog) then frmLog.AddLog('btnArrowClicked');
end;

procedure TfrmTDCTengah_Nala.btnAMPLInfoClick(Sender: TObject);
begin
  TDCInterface.SetAMPLInfoVisible(btnAMPLInfo.Down);
end;

procedure TfrmTDCTengah_Nala.btnAN_LClick(Sender: TObject);
begin
  inherited;
//  (TDCInterface as TTDC_NalaInterface).frmMIK_Kiri.Visible:= btnAN_L.Down;
//  (TDCInterface as TTDC_NalaInterface).frmDisplay_Kiri.Visible:= btnAN_L.Down;
end;

procedure TfrmTDCTengah_Nala.btnLINKClick(Sender: TObject);
begin
//  inherited;
   TDCInterface.SetLINKVisible(btnLINK.Down);
end;

procedure TfrmTDCTengah_Nala.btnTNClick(Sender: TObject);
begin
  TDCInterface.SetTrackNumberVisible(btnTN.Down);
end;

procedure TfrmTDCTengah_Nala.btnOwnCursClick(Sender: TObject);
begin
   TDCInterface.Cursorss.Visible := btnOwnCurs.Down;
end;

procedure TfrmTDCTengah_Nala.btn12SecClick(Sender: TObject);
begin
  Reset_Threat_Button;
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
  (sender as TSpeedButtonImage).ImageIndex := 1;
end;

procedure TfrmTDCTengah_Nala.FormPaint(Sender: TObject);
begin
  inherited;

  DrawAngle(Image1.Canvas);
end;

procedure TfrmTDCTengah_Nala.lbl2DblClick(Sender: TObject);
begin
//  inherited;
    ShowCtrlpnl := not ShowCtrlpnl;
end;

procedure TfrmTDCTengah_Nala.lbl4DblClick(Sender: TObject);
begin
//  inherited;
 ShowCtrlpnl := not ShowCtrlpnl;
end;

procedure TfrmTDCTengah_Nala.lbl5DblClick(Sender: TObject);
begin
  inherited;
 ShowCtrlpnl := not ShowCtrlpnl;
end;

procedure TfrmTDCTengah_Nala.lbl6DblClick(Sender: TObject);
begin
  inherited;
 ShowCtrlpnl := not ShowCtrlpnl;
end;

procedure TfrmTDCTengah_Nala.lbl7DblClick(Sender: TObject);
begin
  inherited;
 ShowCtrlpnl := not ShowCtrlpnl;
end;

procedure TfrmTDCTengah_Nala.Log1Click(Sender: TObject);
begin
//  inherited;
 fMainTDC.Top:= 200;
end;

procedure TfrmTDCTengah_Nala.mncloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmTDCTengah_Nala.mniCloseandRestart1Click(Sender: TObject);
begin
//  inherited;
  Application.Terminate;
  WindowsExit(EWX_REBOOT or EWX_FORCE) ;  //Restart
end;

procedure TfrmTDCTengah_Nala.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  if ssShift in Shift then
    fMainTDC.Top:= 2000
  else
    fMainTDC.Top:= -2000;
  m1.Visible := ShowCtrlpnl;
  m1.Left := x;
  m1.Top := y;
  ShowCtrlpnl := False;

end;

procedure TfrmTDCTengah_Nala.pmnFullscreenClick(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmTDCTengah_Nala.btnDataReq_LMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_left(0);
end;

procedure TfrmTDCTengah_Nala.btnDataReq_LMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_left(1);

end;

procedure TfrmTDCTengah_Nala.btnDataReq_RMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   TDCInterface.DataRequest_right(0);
end;

procedure TfrmTDCTengah_Nala.btnDataReq_RMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.DataRequest_right(1);
end;

function TfrmTDCTengah_Nala.WindowsExit(RebootParam: Longword): Boolean;
var
   TTokenHd: THandle;
   TTokenPvg: TTokenPrivileges;
   cbtpPrevious: DWORD;
   rTTokenPvg: TTokenPrivileges;
   pcbtpPreviousRequired: DWORD;
   tpResult: Boolean;
const
   SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     tpResult := OpenProcessToken(GetCurrentProcess(),
       TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
       TTokenHd) ;
     if tpResult then
     begin
       tpResult := LookupPrivilegeValue(nil,
                                        SE_SHUTDOWN_NAME,
                                        TTokenPvg.Privileges[0].Luid) ;
       TTokenPvg.PrivilegeCount := 1;
       TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
       cbtpPrevious := SizeOf(rTTokenPvg) ;
       pcbtpPreviousRequired := 0;
       if tpResult then
         Windows.AdjustTokenPrivileges(TTokenHd,
                                       False,
                                       TTokenPvg,
                                       cbtpPrevious,
                                       rTTokenPvg,
                                       pcbtpPreviousRequired) ;
     end;
   end;
   Result := ExitWindowsEx(RebootParam, 0) ;
end;

end.
