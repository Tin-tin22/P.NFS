unit uMainCtrlPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Buttons, SpeedButtonImage, ufQEK, uLibTDCClass,
  VrControls, VrWheel,uDetected, uTorpedoTrack, uTCPClient, uDisplaySinga,
  Menus, uBaseConstan, ComCtrls;

type
  T_id = (not_selected ,Frndl, Hstl, Unkn);

  TactiveTorp_state = class
  public
    ID : T_id;
    Int_RAM,

    IsAssTrack,
    IsSearching,
    IsHoaming,

    IsTorpedo_On,
    IsTorpedoTest,
    IsPreparedTube,

    IsFired,
    IsTorpShutDown,

    IsMan,
    IsCor_Course,
    IsCor_depth,
    IsCor_Endis : Boolean;
    Tube : TTube;
    constructor Create;
    destructor Destroy; override;
  end;

  TvMainCtrlPanel  = class(TfrmQEK)
    GroupBox10: TGroupBox;
    btnFrndl: TSpeedButtonImage;
    btnHostl: TSpeedButtonImage;
    btnUnkn: TSpeedButtonImage;
    btnCloseContr: TSpeedButtonImage;
    btnResetObm: TSpeedButtonImage;
    GroupBox8: TGroupBox;
    Shape6: TShape;
    Label71: TLabel;
    btnAssTrack: TSpeedButtonImage;
    btnSearch: TSpeedButtonImage;
    btnHomng: TSpeedButtonImage;
    btnMan: TSpeedButtonImage;
    btnTorpCours: TSpeedButtonImage;
    btnTorpDepth: TSpeedButtonImage;
    btnEnds: TSpeedButtonImage;
    Bevel17: TBevel;
    Shape4: TShape;
    btnTorpShutDown: TSpeedButtonImage;
    Label72: TLabel;
    btnTorpOn: TSpeedButtonImage;
    btnTorpTest: TSpeedButtonImage;
    btnPrePareTube: TSpeedButtonImage;
    btnFire: TSpeedButtonImage;

    grpTorpAssg: TGroupBox;
    btnPort: TSpeedButtonImage;
    btnStb: TSpeedButtonImage;

    TmrTorpOnPort: TTimer;
    TmrTorpOnStarboard: TTimer;
    TmrRdyToFirePort: TTimer;
    TmrRdyToFireStarboard: TTimer;
    TmrFirePort: TTimer;
    TmrFireStarboard: TTimer;
    Timer3: TTimer;
    tWarning: TTimer;

    Image2: TImage;
    Button1: TButton;
    Memo1: TMemo;
    imgBackground: TImage;
    btnTest: TButton;
    btnTestFire: TButton;
    ManHandle: TVrWheel;
    btnIniRam: TSpeedButtonImage;
    btnCorr: TSpeedButtonImage;
    btnWipe: TSpeedButtonImage;




    procedure TorpedoAssgn(sender : TObject);
    procedure SetHandWheel(sender : TObject);

    procedure TmrTorpOnPortTimer(Sender: TObject);
    procedure TmrTorpOnStarboardTimer(Sender: TObject);
    procedure TmrRdyToFirePortTimer(Sender: TObject);
    procedure TmrRdyToFireStarboardTimer(Sender: TObject);
    procedure TmrFirePortTimer(Sender: TObject);
    procedure TmrFireStarboardTimer(Sender: TObject);

    procedure btnTorpOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrePareTubeClick(Sender: TObject);

    procedure btnResetObmClick(Sender: TObject);
    procedure btnFireClick(Sender: TObject);
    procedure btnAssTrackClick(Sender: TObject);
    procedure btnIniRamClick(Sender: TObject);
    procedure btnCorrClick(Sender: TObject);
    procedure btnWipeClick(Sender: TObject);
    procedure btnCloseContrClick(Sender: TObject);
    procedure btnTorpTestClick(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label78Click(Sender: TObject);
    procedure Label80Click(Sender: TObject);
    procedure btnFrndlClick(Sender: TObject);
    procedure btnHostlClick(Sender: TObject);
    procedure btnUnknClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnHomngClick(Sender: TObject);
    procedure btnTorpShutDownClick(Sender: TObject);
    procedure btnManClick(Sender: TObject);
    procedure Label81Click(Sender: TObject);
    procedure Label82Click(Sender: TObject);
    procedure GroupBox8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Close1Click(Sender: TObject);
    procedure GroupBox10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnTestClick(Sender: TObject);
    procedure btnTestFireClick(Sender: TObject);
    procedure ManHandleChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ManHandleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnIniRamMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnWipeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnCorrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnUnknMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnHostlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFrndlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbl34Click(Sender: TObject);
  private

    nCount, sState : integer;

    limDown   : boolean;
    limLastPos: TPoint;
    limScale  : single;

    procedure UpdateStateGroup(st,grp : Integer);
  public
    IsPortFlag : Boolean;
    IsStbFlag : Boolean;

    Port      : TactiveTorp_state;
    Starboard : TactiveTorp_state;
    CurTorp   : TactiveTorp_state;

    manCours  : Boolean;
    manDepth  : Boolean;
    manEndis  : Boolean;

    VDisplay  : TfrmLPDTorpedo;

    procedure SetLocalVariable(tdc: TGenericTDCInterface);
    procedure SetUpdownImage(var spb : TSpeedButtonImage);
    procedure Stagebutton(Selectedtorp: Ttube);
    procedure showPosOnAndu(PosX, PosY : Double);
    procedure LoadingStatus(LauncherID : Byte; LauncherStatus : TStatusWeapon);

    procedure Passing(i : Integer);
    procedure KillMan;
    procedure SystemOff;
  end;

implementation

uses
  uLibTorpedo_singa, uTCPDataType, uAnduProc, Math, uMainFormTorpedo;

var
  TOCOS : TTorpedoInterface;
  vMainTorpedo : TfMainTorpedo;
{$R *.dfm}

procedure TvMainCtrlPanel.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//  inherited;
  TOCOS := tdc  AS TTorpedoInterface;
  TOCOS.torpAssgn := ttPort;
end;

procedure TvMainCtrlPanel.UpdateStateGroup(st, grp: integer);
var
  i: Integer;
  s: string;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    if Components[i].ClassType = TSpeedButtonImage then
    begin
      s := Components[i].Name;
      with TSpeedButtonImage(FindComponent(s)) do
      begin
        case st of
          0:
            begin
              ImageIndex := 0;
              Down := false;
            end;
          1:
            begin
              if GroupIndex = grp then
              begin
                ImageIndex := 0;
                Down := false;
              end;
            end;
        end;
      end;
    end;
  end;
end;

procedure TvMainCtrlPanel.SetUpdownImage(var spb : TSpeedButtonImage);
begin
  if spb.Down then
    spb.ImageIndex := 1
  else
    spb.ImageIndex := 0;
end;

procedure TvMainCtrlPanel.showPosOnAndu(PosX, PosY: Double);
var Range, Bearing : Double;
begin
 Range := TOCOS.GetRange(PosX, PosY);
 Bearing := TOCOS.GetBearing(PosX, PosY);

 TOCOS.vDisplayCtrlPanelLeft.txtget213.Text := Formatfloat('#,##', Bearing);
 TOCOS.vDisplayCtrlPanelLeft.txtget2132.Text := Formatfloat('#,##', Range);
end;


procedure TvMainCtrlPanel.Stagebutton(Selectedtorp: TTube);
var
  useTorp : TactiveTorp_state;

begin
  if Selectedtorp = ttPort then
    useTorp := Port
  else
    useTorp := Starboard;

//  btnFrndl.Down := False;
//  btnHostl.Down := False;
//  btnUnkn.Down  := False;
//
//  case useTorp.ID of
//    Frndl :btnFrndl.Down := True;
//    Hstl  :btnHostl.Down := True;
//    Unkn  :btnUnkn.Down  := True;
//  else
//    begin
//      btnFrndl.Down := false;
//      btnHostl.Down := false;
//      btnUnkn.Down  := false;
//    end;
//  end;
//
//  SetUpdownImage(btnFrndl);
//  SetUpdownImage(btnHostl);
//  SetUpdownImage(btnUnkn);
//
//  btnIniRam.Down := useTorp.Int_RAM;
//  SetUpdownImage(btnIniRam);

  btnAssTrack.Down := useTorp.IsAssTrack;
  btnSearch.Down := useTorp.IsSearching;
  btnHomng.Down := useTorp.IsHoaming;
  SetUpdownImage(btnHomng);
  SetUpdownImage(btnSearch);
  SetUpdownImage(btnAssTrack);

  btnTorpOn.Down := useTorp.IsTorpedo_On;
  btnTorpTest.Down := useTorp.IsTorpedoTest;
  btnPrePareTube.Down := useTorp.IsPreparedTube;
  SetUpdownImage(btnTorpOn);
  SetUpdownImage(btnTorpTest);
  SetUpdownImage(btnPrePareTube);

  btnMan.Down        := useTorp.IsMan;
  btnTorpCours.Down  := False;
  btnTorpDepth.Down  := False;
  btnEnds.Down       := False;
  SetUpdownImage(btnMan);
  SetUpdownImage(btnTorpCours);
  SetUpdownImage(btnTorpDepth);
  SetUpdownImage(btnEnds);

  btnTorpShutDown.Down := useTorp.IsTorpShutDown;
  SetUpdownImage(btnTorpShutDown);
  btnFire.Down := useTorp.IsFired;
  SetUpdownImage(btnFire);
end;

procedure TvMainCtrlPanel.TorpedoAssgn(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    {PORT = 0   STB = 1}
    if TOCOS.TOCOSSysON then begin
      if (Tag = 0) then begin
        {utk penanda kalo launch tanpa target tombol port ato stb hrs dipilih}
        IsPortFlag := True;
        IsStbFlag := False;

        TOCOS.StatusTube:= True;
        TOCOS.torpAssgn := ttPort;
        TOCOS.vDisplayCtrlPanelLeft.pPage6Show;
        CurTorp := Port;
        Stagebutton(ttPort);
        {LOG}
        TOCOS.SendEvenTOCOS(1);
      end
      else if (Tag = 1) then begin
        IsPortFlag := False;
        IsStbFlag := True;

        TOCOS.StatusTube:= True;
        TOCOS.torpAssgn := ttStarBoard;
        TOCOS.vDisplayCtrlPanelLeft.pPage5Show;
        CurTorp := Starboard;
        Stagebutton(ttStarBoard);
        {LOG}
        TOCOS.SendEvenTOCOS(2);
      end;
      UpdateStateGroup(1, GroupIndex);
      ImageIndex := 1;

      if (btnTorpCours.ImageIndex =1) then begin
        btnTorpCours.ImageIndex := 0;
        manCours := False;
      end;
      if (btnTorpDepth.ImageIndex =1) then begin
        btnTorpDepth.ImageIndex := 0;
        manDepth := False;
      end;
      if (btnEnds.ImageIndex =1) then begin
        btnEnds.ImageIndex := 0;
        manEndis := False;
      end;
    end
    else
      UpdateStateGroup(1,GroupIndex);
  end;
end;

procedure TvMainCtrlPanel.SetHandWheel(sender : TObject);
var
  tR : TTorpedoTrack;
  i : Byte;
begin
  if not btnMan.Down  then begin
    (Sender as TSpeedButtonImage).Down := False;
    SetUpdownImage(btnTorpCours);
    SetUpdownImage(btnTorpDepth);
    SetUpdownImage(btnEnds);
    Exit;
  end;
  SetUpdownImage(btnTorpCours);
  SetUpdownImage(btnTorpDepth);
  SetUpdownImage(btnEnds);

  with Sender as TSpeedButtonImage do
  begin
    tR := nil;
    if btnMan.Down then
    begin
      if (TOCOS.TOCOSSysON) then begin

        if TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then
        begin
          if (Tag = 0) then begin  // torp cours click
            if btnTorpCours.Down then
            begin
              ManHandle.MinValue := 0;
              ManHandle.MaxValue := 359;
              manCours := true;
              manDepth := False;
              manEndis := False;

              ManHandle.Position := Round(tR.Course);
            end
            else
              manCours := False;
          end
          else if (Tag = 1) then begin // torp depth click
            if btnTorpDepth.Down  then
            begin
              ManHandle.MinValue := 7;
              ManHandle.MaxValue := 1324;
              manCours := false;
              manDepth := true;
              manEndis := False;

              ManHandle.Position := Round(Abs(tR.Depth * C_Meter_To_Feet));
            end
            else
             manDepth := False;
          end
          else if (Tag = 2) then begin // endis click
            if btnEnds.Down then
            begin
              ManHandle.MinValue := 273;
              ManHandle.MaxValue := 34722;
              manCours := false;
              manDepth := false;
              manEndis := true;

              ManHandle.Position := Round(Abs(tR.EnablingDistance));
            end
            else
              manEndis := False;
          end;
        end else
        begin
          UpdateStateGroup(1, GroupIndex);
          ImageIndex := 1;
        end;
      end
      else UpdateStateGroup(1, GroupIndex);
    end;
  end;
end;

procedure TvMainCtrlPanel.TmrTorpOnPortTimer(Sender: TObject);
begin
  SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn1, cYellow , True);
  TOCOS.vTechnicalCtrlPanel.IndTorpOn1_on := True;
  TmrTorpOnPort.Enabled := false;
end;

procedure TvMainCtrlPanel.TmrTorpOnStarboardTimer(Sender: TObject);
begin
  SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn2, cYellow , True);
  TOCOS.vTechnicalCtrlPanel.IndTorpOn2_on := True;
  TmrTorpOnStarboard.Enabled := false;
end;

procedure TvMainCtrlPanel.btnTestClick(Sender: TObject);
var
  aRec : TRecSetTorpedoSUT;
begin
  if TOCOS.torpAssgn = ttPort then
      aRec.mLauncherID := 1
    else if TOCOS.torpAssgn = ttStarBoard then
      aRec.mLauncherID := 2;
    TOCOS.Update_Bearing_TORP(90, aRec);
end;

procedure TvMainCtrlPanel.btnTestFireClick(Sender: TObject);
var
  aRec : TRecSetTorpedoSUT;
begin
  aRec.ShipID  := 20 {NALA};
  aRec.OrderID := __ORD_TORPEDOSUT_FIRED;
  aRec.mLauncherID := 2;
  aRec.mMissileID := 1;
  aRec.mWeaponID := C_DBID_TORPEDO_SUT;
  aRec.mMissileNumber := 1;

  aRec.mTorpedoCourse := 180;
  aRec.mTorpedoSpeed := 18 {+ C_Knot_To_ms {LOW};
  aRec.mTorpedoDepth := 1 {* C_Feet_To_Meter};
  aRec.mTargetType := __TORPEDOSUT_TARGET_SURFACE;
  aRec.mpredm := Word(mManualNavigate);
  aRec.mTorpedoSafeDistance := 273 {* C_Yard_To_Meter};
  aRec.mTorpedoEnDis := 100 {* C_Yard_To_Meter};

  TOCOS.netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
end;

procedure TvMainCtrlPanel.btnTorpOnClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnTorpOn.Down)then
  begin
    {Menyalakan button TORP ON}
    if TOCOS.CheckTorpedoON(TOCOS.torpAssgn) then
    begin
      btnTorpOn.Down := True;
      SetUpdownImage(btnTorpOn);

      TOCOS.SetStatus(0,0,TOCOS.torpAssgn, ID_GeneralStatus);   // Show General Symbol (tanda baterai)

      if Assigned(CurTorp) then
      begin
        CurTorp.IsTorpedo_On := True;

        if CurTorp = Port then
        begin
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind120Bar1, cYellow, True);
          TOCOS.vTechnicalCtrlPanel.Ind120Bar1_on := True;
          TmrTorpOnPort.Enabled:= true;

          if CurTorp.IsPreparedTube = True then
          begin
            TmrRdyToFirePort.Interval:= 77000;
            TmrRdyToFirePort.Enabled := True;
          end;
        end else
        if CurTorp = StarBoard then
        begin
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind120Bar2, cYellow, True);
          TOCOS.vTechnicalCtrlPanel.Ind120Bar2_on := True;
          TmrTorpOnStarboard.Enabled:= true;

          if CurTorp.IsPreparedTube = True then
          begin
            TmrRdyToFireStarboard.Interval:= 77000;
            TmrRdyToFireStarboard.Enabled := True;
          end;
        end;
      end;
      TOCOS.SendEvenTOCOS(9);
    end
    else
    begin
      if Assigned(CurTorp) then
        CurTorp.IsTorpedo_On := False;
      btnTorpOn.Down := False;
      SetUpdownImage(btnTorpOn);
    end;
  end
  else
  begin
    {Mematikan button TORP ON}
    if (TOCOS.torpAssgn = ttPort) then
    begin
      if not (TOCOS.LoadTube.Port = tsLoading) then {Kalo sedang launch tombol torp on tdk bisa di off}
      begin
        btnTorpOn.Down := True;
        Exit;
      end;


      SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn1, cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndTorpOn1_on := False;
      SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire1 , cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndRdyToFre1_on  := False;

      TmrTorpOnPort.Enabled     := False;
      TmrRdyToFirePort.Enabled  := False;
    end else
    if (TOCOS.torpAssgn = ttStarBoard) then
    begin
      if not (TOCOS.LoadTube.Port = tsLoading) then
      begin
        btnTorpOn.Down := True;
        Exit;
      end;

      SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn2, cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndTorpOn2_on := False;
      SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire2 , cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndRdyToFre2_on  := False;

      TmrTorpOnStarboard.Enabled    := False;
      TmrRdyToFireStarboard.Enabled := False;
    end;

    if Assigned(CurTorp) then
        CurTorp.IsTorpedo_On := False;
    btnTorpOn.Down := False;
    SetUpdownImage(btnTorpOn);
  end;
end;

procedure TvMainCtrlPanel.FormCreate(Sender: TObject);
begin
  inherited;
  //torpAssgn := ttPort;
//  ass_track := False;
//  data := 0;
  nCount := 0;
  sState := 0;
  manCours := false;
  manDepth := False;
  manEndis := False;
  IsPortFlag := False;
  IsStbFlag := False;

  btnTorpShutDown.Caption := UpperCase('TORP' + #13 + 'Shut' + #13 + 'Down');
  btnCloseContr.Caption := UpperCase('close' + #13 + 'Contr');
  btnResetObm.Caption := UpperCase('RESET' + #13 + 'OBM');
  btnIniRam.Caption := UpperCase('INI' + #13 + 'RAM');
  btnAssTrack.Caption := UpperCase('ASS' + #13 + 'TRACK');
  btnTorpOn.Caption := UpperCase('TORP' + #13 + 'ON');
  btnTorpTest.Caption := UpperCase('TORP' + #13 + 'TEST');
  btnPrePareTube.Caption := UpperCase('PRE' + #13 + 'PARE' + #13 + 'TUBE');
  btnTorpCours.Caption := UpperCase('TORP' + #13 + 'COURS');
  btnTorpDepth.Caption := UpperCase('TORP' + #13 + 'DEPTH');

  Port      := TactiveTorp_state.create;
  Port.Tube := ttPort;

  Starboard  := TactiveTorp_state.create;
  Starboard.Tube := ttStarBoard;

  CurTorp   := Port;
  //Screen.Cursor := crNone;
end;

procedure TvMainCtrlPanel.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Port);
  FreeAndNil(Starboard);
  inherited;
end;

procedure TvMainCtrlPanel.FormShow(Sender: TObject);
begin
  inherited;
  ManHandle.Width  := 154;
  ManHandle.Height := 154;
end;



procedure TvMainCtrlPanel.GroupBox10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt : TPoint;
begin
  GetCursorPos(pt);

  if Button = mbRight then
  begin
//    pmRightClick.Popup(pt.X, pt.Y);
  end;

end;

procedure TvMainCtrlPanel.GroupBox8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case Button of
    mbLeft: begin
        if (ssShift in Shift) then begin
          if Button1.Visible then
            Button1.Visible := False
          else
            Button1.Visible := True;

          btnTestFire.Visible := not btnTestFire.Visible;
          btnTest.Visible := not btnTest.Visible;
        end;
      end;
  end;

end;

procedure TvMainCtrlPanel.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  limDown   := true;
  limLastPos.X:= X;
  limLastPos.Y:= Y;
end;

procedure TvMainCtrlPanel.Image2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  ix, iy : integer;
begin
  if limDown then begin
    ix := X - limLastPos.X;
    iy := Y - limLastPos.Y;
    TOCOS.vDisplay.TDCInterface.OBMRight_SetPosition(
        VDisplay.TDCInterface.OBMRight.Center.X + Floor(ix * limScale),
        VDisplay.TDCInterface.OBMRight.Center.Y + Floor(iy * limScale));

    limLastPos.X := X;
    limLastPos.Y := Y;

    showPosOnAndu(TOCOS.vDisplay.TDCInterface.OBMRight.mPos.X, TOCOS.vDisplay.TDCInterface.OBMRight.mPos.Y);
  end;
  limScale  := 1.0;
end;

procedure TvMainCtrlPanel.Image2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  limDown   := false;
end;

procedure TvMainCtrlPanel.KillMan;
begin
  btnTorpCours.Down := False;
  btnTorpDepth.Down := False;
  btnEnds.Down      := False;
  SetUpdownImage(btnTorpCours);
  SetUpdownImage(btnTorpDepth);
  SetUpdownImage(btnEnds);

  manCours := False;
  manDepth := False;
  manEndis := False;
end;

procedure TvMainCtrlPanel.btnPrePareTubeClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnPrePareTube.Down) then
  begin
    {Menyalakan button PRE PARE TUBE}
    if TOCOS.CheckPrepareTube(TOCOS.torpAssgn) then
    begin
      btnPrePareTube.Down := True;
      SetUpdownImage(btnPrePareTube);

      if Assigned(CurTorp) then
      begin
        CurTorp.IsPreparedTube := True;
        if CurTorp = Port then
        begin
          Port.IsPreparedTube := True;

          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen1 , cYellow , true);
          TOCOS.vTechnicalCtrlPanel.IndDorrOpn1_on  := true;

          if TOCOS.vTechnicalCtrlPanel.IndTorpOn1_on = True then
          begin
            TmrRdyToFirePort.Enabled := True;
            TmrRdyToFirePort.Interval:= 7000;
          end;
        end else
        if CurTorp = StarBoard then
        begin
          Starboard.IsPreparedTube := True;

          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen2 , cYellow , true);
          TOCOS.vTechnicalCtrlPanel.IndDorrOpn2_on  := true;

          if TOCOS.vTechnicalCtrlPanel.IndTorpOn2_on = True then
          begin
            TmrRdyToFireStarboard.Enabled := True;
            TmrRdyToFireStarboard.Interval:= 7000;
          end;
        end;
      end;

      TOCOS.SendEvenTOCOS(11);
    end
    else
    begin
      if Assigned(CurTorp) then
        CurTorp.IsPreparedTube := False;
      btnPrePareTube.Down := False;
      SetUpdownImage(btnPrePareTube);
    end;
  end
  else
  begin
    {Mematikan button PRE PARE TUBE}
    if (TOCOS.torpAssgn = ttPort) then
    begin
      SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen1 , cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndDorrOpn1_on  := False;

      if (TOCOS.LoadTube.Port = tsLoading) then {Kalo sedang launch tombol torp on tdk bisa di off}
      begin
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire1 , cYellow , False);
        TOCOS.vTechnicalCtrlPanel.IndRdyToFre1_on  := False;

        TmrRdyToFirePort.Enabled := False;
      end;
    end else
    if (TOCOS.torpAssgn = ttStarBoard) then
    begin
      SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen2 , cYellow , False);
      TOCOS.vTechnicalCtrlPanel.IndDorrOpn2_on  := False;

      if (TOCOS.LoadTube.StarBoard = tsLoading) then {Kalo sedang launch tombol torp on tdk bisa di off}
      begin
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire2 , cYellow , False);
        TOCOS.vTechnicalCtrlPanel.IndRdyToFre2_on  := False;

        TmrRdyToFireStarboard.Enabled := False;
      end;
    end;

    if Assigned(CurTorp) then
        CurTorp.IsPreparedTube := False;
    btnPrePareTube.Down := False;
    SetUpdownImage(btnPrePareTube);
  end;
end;

procedure TvMainCtrlPanel.TmrRdyToFirePortTimer(Sender: TObject);
begin
  if CurTorp.IsTorpedoTest = false then
  begin
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire1 , cYellow , True);
    TOCOS.vTechnicalCtrlPanel.IndRdyToFre1_on  := True;
    TmrRdyToFirePort.Enabled := false;
  end
  else
  begin
    TmrRdyToFirePort.Enabled := false;
    TmrRdyToFirePort.Enabled := True;
  end;
end;

procedure TvMainCtrlPanel.TmrRdyToFireStarboardTimer(Sender: TObject);
begin
  if CurTorp.IsTorpedoTest = false then
  begin
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire2 , cYellow , True);
    TOCOS.vTechnicalCtrlPanel.IndRdyToFre2_on  := True;
    TmrRdyToFireStarboard.Enabled := false;
  end
  else
  begin
    TmrRdyToFireStarboard.Enabled := false;
    TmrRdyToFireStarboard.Enabled := True;
  end;
end;

procedure TvMainCtrlPanel.TmrFirePortTimer(Sender: TObject);
begin
  if TOCOS.vTechnicalCtrlPanel.IndToSup1_on = True then
  begin
    {indikator TO SUP PLY1 Mati}
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply1, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.IndToSup1_on  := False;
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar1, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.Ind20Bar1_on  := False;
    TmrFirePort.Enabled := False;
    TmrFirePort.Enabled := True;
    Exit;
  end else
  if TOCOS.vTechnicalCtrlPanel.Ind120Bar1_on = True then
  begin
    {indikator 120 BAR Mati}
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind120Bar1, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.Ind120Bar1_on  := False;
    TmrFirePort.Enabled := False;
    TmrFirePort.Enabled := True;
    Exit;
  end else
  if TOCOS.vTechnicalCtrlPanel.IndTorpOn1_on = True then
  begin
    {indikator TORP ON Mati}
    SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn1, cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndTorpOn1_on := False;

    {Tombol TORP ON Mati}
    Port.IsTorpedo_On := False;
    btnTorpOn.Down := False;
    SetUpdownImage(btnTorpOn);

    {Tombol FIRE Mati}
    Port.IsFired := False;
    btnFire.Down := False;
    SetUpdownImage(btnFire);

    TmrFirePort.Enabled := false;
  end;
end;

procedure TvMainCtrlPanel.TmrFireStarboardTimer(Sender: TObject);
begin
  if TOCOS.vTechnicalCtrlPanel.IndToSup2_on = True then
  begin
    {indikator TO SUP PLY1 Mati}
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply2, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.IndToSup2_on  := False;
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar2, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.Ind20Bar2_on  := False;
    TmrFireStarboard.Enabled := False;
    TmrFireStarboard.Enabled := True;
    Exit;
  end else
  if TOCOS.vTechnicalCtrlPanel.Ind120Bar2_on = True then
  begin
    {indikator 120 BAR Mati}
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind120Bar2, cYellow , false);
    TOCOS.vTechnicalCtrlPanel.Ind120Bar2_on  := False;
    TmrFireStarboard.Enabled := False;
    TmrFireStarboard.Enabled := True;
    Exit;
  end else
  if TOCOS.vTechnicalCtrlPanel.IndTorpOn2_on = True then
  begin
    {indikator TORP ON Mati}
    SetImageIndikator((TOCOS).vTechnicalCtrlPanel.IndTorpOn2, cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndTorpOn2_on := False;

    {Tombol TORP ON Mati}
    Starboard.IsTorpedo_On := False;
    btnTorpOn.Down := False;
    SetUpdownImage(btnTorpOn);

    {Tombol FIRE Mati}
    Starboard.IsFired := False;
    btnFire.Down := False;
    SetUpdownImage(btnFire);

    TmrFireStarboard.Enabled := false;
  end;
end;

procedure TvMainCtrlPanel.btnResetObmClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) then
    TOCOS.OBMRight_Reset;
  SetUpdownImage(btnResetObm);

end;

procedure TvMainCtrlPanel.btnFireClick(Sender: TObject);
var
  tR : TTorpedoTrack;
  i : Byte;
begin
  if (TOCOS.TOCOSSysON) and (btnFire.Down) then
  begin
    {Menyalakan button FIRE}
    if TOCOS.CheckFire(TOCOS.torpAssgn) then
    begin
      btnFire.Down := True;
      SetUpdownImage(btnFire);

      if Assigned(CurTorp) then
      begin
        CurTorp.IsFired := True;

        if CurTorp = Port then
        begin
          TmrFirePort.Enabled := True;

          {indikator RDY TO FIRE Mati}
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire1 , cYellow , false);
          (TOCOS).vTechnicalCtrlPanel.IndRdyToFre1_on  := False;

        end else
        if CurTorp = StarBoard then
        begin
          TmrFireStarboard.Enabled := True;

          {indikator RDY TO FIRE Mati}
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire2 , cYellow , false);
          (TOCOS).vTechnicalCtrlPanel.IndRdyToFre2_on  := False;

        end;

        if TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then
        begin
          if tR.IsNoTarget then
          begin
            btnMan.Down := True;
            btnMan.Click
          end;
        end;

        TOCOS.FireTorp_SUT
      end;
    end
    else
    begin
      CurTorp.IsFired := False;
      btnFire.Down := False;
      SetUpdownImage(btnFire);
    end;
  end
  else begin
    CurTorp.IsFired := False;
    btnFire.Down := False;
    SetUpdownImage(btnFire);
  end;
end;

procedure TvMainCtrlPanel.btnAssTrackClick(Sender: TObject);
var
  aRec    : TRecOrderAssignment;
  WesFire : Boolean;
  tR      : TTorpedoTrack;
  i       : Byte;
begin
  {Asumsi port/starboard hrs sdh dipilih}
  if (TOCOS.TOCOSSysON) and (TOCOS.StatusTube = True) then begin
    WesFire := true;
    {Jika dalam keadaan homing asumsi tidak bisa asstrack/ deasstrack}
    if CurTorp.IsHoaming then
    begin
      if (btnAssTrack.Down)then
        btnAssTrack.Down := False
      else
        btnAssTrack.Down := True;

      SetUpdownImage(btnAssTrack);
      Exit;
    end;

    {Menyalakan button ASS TRACK}
    if (btnAssTrack.Down)then
    begin
      if not TOCOS.CheckAssTrack(TOCOS.torpAssgn) then
      begin
        btnAssTrack.Down := False;
        SetUpdownImage(btnAssTrack);
        Exit;
      end;

      btnAssTrack.Down := True;
      SetUpdownImage(btnAssTrack);

      CurTorp.IsAssTrack := True;
      if CurTorp = Port then
      begin
        if not (TOCOS.LoadTube.Port = tsLaunch) then {assign track setelah fire ? }
        begin
          TOCOS.vDisplayCtrlPanelLeft.sign63.Caption := '';
          TOCOS.vDisplayCtrlPanelLeft.txt603.Text := 'O N';
          WesFire := False;
        end
      end else
      if CurTorp = StarBoard then
      begin
        if not (TOCOS.LoadTube.StarBoard = tsLaunch) then
        begin
          TOCOS.vDisplayCtrlPanelLeft.sign53.Caption := '';
          TOCOS.vDisplayCtrlPanelLeft.txt503.Text := 'O N';
          WesFire := False;
        end
      end;

      TOCOS.SetAssignTorpedo_SUT(aRec);

      {assign track setelah fire}
      if WesFire = True then
      begin
        TOCOS.SetToTargetAfterFire;

        {Diikuti dengan membunuh tombol manual}
        btnMan.Down := False;
        SetUpdownImage(btnMan);
        KillMan;
      end;
    end
    else {DeAssign Track}
    begin
      if TOCOS.torpAssgn = ttPort then
      begin
        if not (TOCOS.LoadTube.Port = tsLaunch) then
        begin
          TOCOS.vDisplayCtrlPanelLeft.sign63.Caption := '';
          WesFire := False;
        end
      end else
      if TOCOS.torpAssgn = ttStarBoard then
      begin
        if not (TOCOS.LoadTube.StarBoard = tsLaunch) then
        begin
          TOCOS.vDisplayCtrlPanelLeft.sign53.Caption := '';
          WesFire := False;
        end
      end;

      {DeAssign track setelah fire}
      if WesFire = True then
      begin
        if TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then
        begin
          tR.IsManual := True;
          KillMan;
          btnMan.Down := True;
          SetUpdownImage(btnMan);
          TOCOS.SetNoTargetAfterFire;
          TOCOS.SetDeAssignTo3D;
        end;
      end
      else
        TOCOS.SetTermination_torpAss(TOCOS.torpAssgn);

      btnAssTrack.Down := False;
      SetUpdownImage(btnAssTrack);
      if Assigned(CurTorp) then
        CurTorp.IsAssTrack := False;
    end;
  end
  else
  begin
    btnAssTrack.Down := False;
    SetUpdownImage(btnAssTrack);
    if Assigned(CurTorp) then
      CurTorp.IsAssTrack := False;
  end;
end;

procedure TvMainCtrlPanel.btnIniRamClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  if (TOCOS.TOCOSSysON) and {(btnIniRam.Down) and}
      ((TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar)) then
  begin

    aRec.TrackNumber := 255;
    aRec.OrderType := byte(ID_AtasAir_Unknown); //C_OrdType_RAM_Udara;
    aRec.X := TOCOS.OBMRight.mPos.X;
    aRec.Y := TOCOS.OBMRight.mPos.Y;

    if Assigned(CurTorp) then
      CurTorp.Int_RAM := True;

    TOCOS.InitiateRAM(aRec,TOCOS.HaveToSend);

    with TOCOS.vDisplayCtrlPanelBottom do
    begin
      btnMS.Click;
      btnMS.Down := True;
      SetUpdownImage(btnMS);

      btnArrow.Click;
      btnArrow.Down := True;
      SetUpdownImage(btnArrow);

      btnAmplInfo.Click;
      btnAmplInfo.Down := True;
      SetUpdownImage(btnAmplInfo);

      btnTN.Click;
      btnTN.Down := True;
      SetUpdownImage(btnTN);
    end;
  end;
  btnIniRam.Down := False;
  SetUpdownImage(btnIniRam);
end;

procedure TvMainCtrlPanel.btnIniRamMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  btnIniRam.Down := True;
  SetUpdownImage(btnIniRam);
end;

procedure TvMainCtrlPanel.btnCorrClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) then
  begin
    TOCOS.CorrectRAM(tdAtasAir,TOCOS.HaveToSend); //(tdUdara);
  end;
  btnCorr.Down := False;
  SetUpdownImage(btnCorr);
end;

procedure TvMainCtrlPanel.btnCorrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  btnCorr.Down := True;
  SetUpdownImage(btnCorr);
end;

procedure TvMainCtrlPanel.btnWipeClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) then
  begin
    CurTorp.Int_RAM := not TOCOS.JustFindTrack_by_OBMRight;

    if TOCOS.Wipe_TorpedoSUTTrack then
    begin
      TOCOS.WipeOnRightOBM;
      TOCOS.actTrack_Closecontroled := nil;
    end;
  end;
  btnWipe.Down := False;
  SetUpdownImage(btnWipe);
end;

procedure TvMainCtrlPanel.btnWipeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  btnWipe.Down := True;
  SetUpdownImage(btnWipe);
end;

procedure TvMainCtrlPanel.btnCloseContrClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnCloseContr.Down) then begin
    TOCOS.CloseControl(tdAtasAir); //(tdUdara);
  end
  else begin
    btnCloseContr.Down := False;
    SetUpdownImage(btnCloseContr);
    TOCOS.WipeCloseControlerMarker;
  end;
end;

procedure TvMainCtrlPanel.btnTorpTestClick(Sender: TObject);
begin
  if (btnTorpOn.Down)  and (btnTorpTest.Down) then
  begin
    if TOCOS.CheckTorpedoTest(TOCOS.torpAssgn) then
    begin
      btnTorpTest.Down := True;
      SetUpdownImage(btnTorpTest);

      if Assigned(CurTorp) then
      begin
        CurTorp.IsTorpedoTest := True;
        TOCOS.SetTorpTest(True);
        Timer3.Enabled := True;
        {LOG}
        TOCOS.SendEvenTOCOS(10);
      end;
    end
    else
    begin
      if Assigned(CurTorp) then
        CurTorp.IsTorpedoTest := False;
      btnTorpTest.Down := False;
      SetUpdownImage(btnTorpTest);
    end;
  end
  else
  begin
    if Assigned(CurTorp) then
      CurTorp.IsTorpedoTest := False;
    btnTorpTest.Down := False;
    SetUpdownImage(btnTorpTest);
    TOCOS.SetTorpTest(False);
    Timer3.Enabled := False;
    TOCOS.TorpTest.step := 0;
    nCount := 0;
    sState := 1;
  end;
end;

procedure TvMainCtrlPanel.Timer3Timer(Sender: TObject);
begin
  Inc(nCount);
  if sState > 23 then begin
     sState := 0;
     nCount := 0;
     if Assigned(CurTorp) then
      CurTorp.IsTorpedoTest := False;
     btnTorpTest.Down := False;
     SetUpdownImage (btnTorpTest);
     TOCOS.SetTorpTest (False);
     Timer3.Enabled  := False;
     nCount := 0;
     sState := 1;
  end
  else
    TOCOS.TorpTest.step := sState;

  if ((nCount = 4) and (sState mod 2 = 1)) or  ((nCount = 2) and (sState mod 2 = 0))then begin
    Inc(sState);
    nCount := 0;
  end;
end;

procedure TvMainCtrlPanel.Button1Click(Sender: TObject);
//var
//  aRec : TRecSetTorpedoSUT;
begin
  TOCOS.SetToTargetAfterFire;
//  TOCOS.netSend.setLog(TStringList(Memo1.Lines));
//
//  aRec.mTorpedoCourse := 90;
//  aRec.mTorpedoSpeed := 18;
//  aRec.mTorpedoDepth := 60;
//  aRec.mLauncherID := 1;
//  aRec.ShipID  := 20;
//  //aRec.TargetID:= 6;
//  aRec.OrderID := ORD_3D_TORPEDO_SUT_FIRED;
//  //TOCOS.FireTorp_SUT(aRec);
//  aRec.mWeaponID := C_DBID_TORPEDO_SUT;
//  TOCOS.netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
end;
procedure TvMainCtrlPanel.Close1Click(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TvMainCtrlPanel.Label78Click(Sender: TObject);
begin
  btnTorpCours.Click;
end;

procedure TvMainCtrlPanel.Label80Click(Sender: TObject);
begin
  btnTorpDepth.Click;
end;

procedure TvMainCtrlPanel.btnFrndlClick(Sender: TObject);
var
  aRec  : TRecTrackOrder;
  td    : TTrackDomain;
  label pass;
begin
  if (TOCOS.TOCOSSysON) and {(btnFrndl.Down) and}
      ((TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar)) then begin

    if CurTorp.Int_RAM then
      CurTorp.ID := Frndl
    else begin
      CurTorp.ID := not_selected;
      goto pass;
    end;

    with Sender as TSpeedButtonImage do // set button
    begin
      UpdateStateGroup(1, GroupIndex);
      ImageIndex := 1;
    end;

    //td := TOCOS.GetTrackDomainFromScreenPos(TOCOS.OBMRight.mPos.X,TOCOS.OBMRight.mPos.Y);
    if TOCOS.GetTrackDomainFromScreenPos(TOCOS.OBMRight.mPos.X,TOCOS.OBMRight.mPos.Y,td) then begin
        if (td=tdAtasAir) then aRec.OrderType := byte(ID_AtasAir_Friendly)
        else if (td=tdBawahAir) then aRec.OrderType := byte(ID_BawahAir_Friendly);
    end;

    aRec.X := TOCOS.OBMRight.mPos.X;
    aRec.Y := TOCOS.OBMRight.mPos.Y;
    TOCOS.Change_Ident(aRec, TOCOS.HaveToSend);
      {LOG}
    TOCOS.SendEvenTOCOS(4);
  end;
//  else begin
  pass:
    btnFrndl.Down := False;
    SetUpdownImage(btnFrndl);
//  end;

end;

procedure TvMainCtrlPanel.btnHostlClick(Sender: TObject);
var aRec : TRecTrackOrder;
    td : TTrackDomain;
    label pass;
begin
  if (TOCOS.TOCOSSysON) and {(btnHostl.Down) and}
      ((TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar)) then begin

    if CurTorp.Int_RAM then
      CurTorp.ID := Hstl
    else begin
      CurTorp.ID := not_selected;
      goto pass;
    end;

    with Sender as TSpeedButtonImage do // set button
    begin
      UpdateStateGroup(1, GroupIndex);
      ImageIndex := 1;
    end;

    //td := TOCOS.GetTrackDomainFromScreenPos(TOCOS.OBMRight.mPos.X,TOCOS.OBMRight.mPos.Y);
    if TOCOS.GetTrackDomainFromScreenPos(TOCOS.OBMRight.mPos.X,TOCOS.OBMRight.mPos.Y,td) then begin
      if (td=tdAtasAir) then aRec.OrderType := byte(ID_AtasAir_Hostile)
      else if (td=tdBawahAir) then aRec.OrderType := byte(ID_BawahAir_Hostile);
    end;

    aRec.X := TOCOS.OBMRight.mPos.X;
    aRec.Y := TOCOS.OBMRight.mPos.Y;
    TOCOS.Change_Ident(aRec, TOCOS.HaveToSend);
    {LOG}
    TOCOS.SendEvenTOCOS(5);
  end;
//  else begin
  pass:
    btnHostl.Down := False;
    SetUpdownImage(btnHostl);
//  end;

end;

procedure TvMainCtrlPanel.btnUnknClick(Sender: TObject);
var aRec : TRecTrackOrder;
    td : TTrackDomain;
    label pass;
begin
  if (TOCOS.TOCOSSysON) and {(btnUnkn.Down) and}
      ((TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar)) then begin
    if CurTorp.Int_RAM then
      CurTorp.ID := Unkn
    else begin
      CurTorp.ID := not_selected;
      goto pass;
    end;

    with Sender as TSpeedButtonImage do // set button
    begin
      UpdateStateGroup(1, GroupIndex);
      ImageIndex := 1;
    end;

    if TOCOS.GetTrackDomainFromScreenPos(TOCOS.OBMRight.mPos.X,TOCOS.OBMRight.mPos.Y,td) then begin
        if (td=tdAtasAir) then aRec.OrderType := byte(ID_AtasAir_Unknown)
        else if (td=tdBawahAir) then aRec.OrderType := byte(ID_BawahAir_Unknown);
    end;

    aRec.X := TOCOS.OBMRight.mPos.X;
    aRec.Y := TOCOS.OBMRight.mPos.Y;
    TOCOS.Change_Ident(aRec, TOCOS.HaveToSend);
      {LOG}
    TOCOS.SendEvenTOCOS(6);
  end;
//  else begin
    pass:
    btnUnkn.Down := False;
    SetUpdownImage(btnUnkn);
//  end;
end;

procedure TvMainCtrlPanel.btnSearchClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnSearch.Down)  then begin
    {Menyalakan button SEARC}
    if TOCOS.CheckSearch(TOCOS.torpAssgn) then
    begin
      btnSearch.Down := True;
      SetUpdownImage(btnSearch);

      if Assigned(CurTorp) then
      begin
        CurTorp.IsSearching := True;

        {Mengirim 3D menyalakan search disini}
        TOCOS.isSearch := True;
        TOCOS.Searching_SUT;
      end;
      TOCOS.SendEvenTOCOS(9);
    end
    else
    begin
      CurTorp.IsSearching := False;
      btnSearch.Down := False;
      SetUpdownImage(btnSearch);
    end;
  end
  else begin
    {Mematikan button SEARC}
    CurTorp.IsSearching := False;
    btnSearch.Down := False;
    SetUpdownImage(btnSearch);

    {Mengirim 3D mematikan search disini}
    TOCOS.isSearch := False;
    TOCOS.Searching_SUT;
  end;
end;

procedure TvMainCtrlPanel.btnHomngClick(Sender: TObject);
var
  tR    : TTorpedoTrack;
  i     : Byte;
begin
  if (TOCOS.TOCOSSysON) and (btnHomng.Down) then
  begin
    {Menyalakan button HOMING}
    if TOCOS.CheckHoming(TOCOS.torpAssgn) then
    begin
      btnHomng.Down := True;
      SetUpdownImage(btnHomng);

      {Tombol Manual mati --------------------------------}
      btnMan.Down := False;
      btnTorpCours.Down := False;
      btnTorpDepth.Down := False;
      btnEnds.Down      := False;

      SetUpdownImage(btnMan);
      SetUpdownImage(btnTorpCours);
      SetUpdownImage(btnTorpDepth);
      SetUpdownImage(btnEnds);

      manCours := False;
      manDepth := False;
      manEndis := False;

      if TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then
        tR.IsManual := False;
      //--------------------------------------------------

      if Assigned(CurTorp) then
      begin
        CurTorp.IsHoaming := True;

        {Mengirim 3D menyalakan homing disini}
        TOCOS.Homming_SUT(True);
      end;
    end
    else
    begin
      CurTorp.IsHoaming := False;
      btnHomng.Down := False;
      SetUpdownImage(btnHomng);
    end;

  end
  else begin
    {Mematikan button HOMING}
    btnHomng.Down := False;
    SetUpdownImage(btnHomng);

    CurTorp.IsHoaming := False;
    {Mengirim 3D menyalakan homing disini}
    TOCOS.Homming_SUT(False);
  end;
end;

procedure TvMainCtrlPanel.btnTorpShutDownClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnTorpShutDown.Down) then begin
    {Menyalakan button TORPEDO SHUTDOWN}
    if TOCOS.CheckShutdown(TOCOS.torpAssgn) then
    begin
      btnTorpShutDown.Down := True;
      SetUpdownImage(btnTorpShutDown);

      if Assigned(CurTorp) then
      begin
        CurTorp.IsTorpShutDown := True;

        TOCOS.isShutdown := True;
        TOCOS.TorpShutDown_SUT;
      end;
    end
    else
    begin
      btnTorpShutDown.Down := False;
      SetUpdownImage(btnTorpShutDown);
      CurTorp.IsTorpShutDown := False;
    end;
  end
  else begin
    {Mematikan button TORPEDO SHUTDOWN}
    btnTorpShutDown.Down := False;
    SetUpdownImage(btnTorpShutDown);
    CurTorp.IsTorpShutDown := False;

    TOCOS.isShutdown := False;
    TOCOS.TorpShutDown_SUT;
  end;
end;

procedure TvMainCtrlPanel.btnManClick(Sender: TObject);
var  tR    : TTorpedoTrack;
     i     : Byte;
begin
  if (TOCOS.TOCOSSysON) then
  begin
    if (TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR)) and (TOCOS.CheckMan(TOCOS.torpAssgn)) then
    begin
      if (btnMan.Down) then
      begin
        btnMan.Down := True;
        SetUpdownImage(btnMan);

        tR.IsManual := True;

        if Assigned(CurTorp) then
          CurTorp.IsMan := True;

      end
      else
      begin
        btnMan.Down := False;
        SetUpdownImage(btnMan);

        tR.IsManual := False;

        if Assigned(CurTorp) then
          CurTorp.IsMan := False;

        if btnAssTrack.Down = False then
          TOCOS.ManCloseControl; {jk dlm keadaan no assign track kemudian man dilepas}
      end;

      KillMan;
    end;
  end
end;

procedure TvMainCtrlPanel.Label81Click(Sender: TObject);
begin
  btnPort.Click;
end;

procedure TvMainCtrlPanel.Label82Click(Sender: TObject);
begin
  btnStb.Click;
end;

procedure TvMainCtrlPanel.lbl34Click(Sender: TObject);
begin
  inherited;
  TOCOS.close;
end;

procedure TvMainCtrlPanel.LoadingStatus(LauncherID : Byte; LauncherStatus : TStatusWeapon);
begin
  case LauncherID of
    1 :
    begin
      TOCOS.LoadTube.Port := LauncherStatus;

      if LauncherStatus = tsLoading then
      begin
        TOCOS.vTechnicalCtrlPanel.IndToSup1_on := True;
        TOCOS.vTechnicalCtrlPanel.Ind20Bar1_on := True;

        if TOCOS.TOCOSSysON then
        begin
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply1, cYellow, TOCOS.vTechnicalCtrlPanel.IndToSup1_on);
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar1, cYellow, TOCOS.vTechnicalCtrlPanel.Ind20Bar1_on);
        end;
      end
      else
      begin
        TOCOS.vTechnicalCtrlPanel.IndToSup1_on := False;
        TOCOS.vTechnicalCtrlPanel.Ind20Bar1_on := False;
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply1, cYellow, False);
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar1, cYellow, False);
      end;
    end;
    2 :
    begin
      TOCOS.LoadTube.StarBoard := LauncherStatus;

      if LauncherStatus = tsLoading then
      begin
        TOCOS.vTechnicalCtrlPanel.IndToSup2_on := True;
        TOCOS.vTechnicalCtrlPanel.Ind20Bar2_on := True;

        if TOCOS.TOCOSSysON then
        begin
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply2, cYellow, TOCOS.vTechnicalCtrlPanel.IndToSup2_on);
          SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar2, cYellow, TOCOS.vTechnicalCtrlPanel.Ind20Bar2_on);
        end;
      end
      else
      begin
        TOCOS.vTechnicalCtrlPanel.IndToSup2_on := False;
        TOCOS.vTechnicalCtrlPanel.Ind20Bar2_on := False;
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndToSupply2, cYellow, False);
        SetImageIndikator(TOCOS.vTechnicalCtrlPanel.Ind20Bar2, cYellow, False);
      end;
    end;
  end;
end;

procedure TvMainCtrlPanel.ManHandleChange(Sender: TObject);
var
  i    : Byte;
  tR   : TTorpedoTrack;
//  recSUT : TRecSetTorpedoSUT;
begin
//    data := ManHandle.Position;
//
//    if not TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then begin
//       if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = TOCOS.torpAssgn) then
//          tR := TOCOS.torpManual;
//    end;
//   berdasarkan pilihan button yang ON (Down)
    {Cendol disik : Bagos}
//   if btnTorpCours.Down then
//   begin
//     recSUT.mTorpedoCourse := data;
//     TOCOS.Update_Bearing_TORP(data, recSUT);
//   end
//   else if btnTorpDepth.Down then
//   begin
//      recSUT.mTorpedoDepth := data;
//      TOCOS.Update_Depth_TORP(data, recSUT);
//   end
//   else if btnEnds.Down then
//   begin
//     {Belum tau  dipake apa ndak
//     recSUT.mTorpedoDepth := data;
//     TOCOS.Update_EnDis_TORP(data, recSUT);
//   }
//   end;

    {
    if manCours then TOCOS.torpManual.Course := data
    else if manDepth then tR.Depth := data
    else if manEndis then tR.EnablingDistance := data;
    }


end;

procedure TvMainCtrlPanel.ManHandleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i    : Byte;
  tR   : TTorpedoTrack;
  recSUT : TRecSetTorpedoSUT;
  data : Double;
begin

    data := ManHandle.Position;

    if TOCOS.GetTorp_fromTube(TOCOS.torpAssgn,i,tR) then
    begin
      if tR.IsManual then
      begin
        if manCours and tR.isSafedistance then
        begin
          tR.Course := data;
          TOCOS.Update_Bearing_TORP(tR.Course, recSUT);
//          tR.CalcPHP; {belumselesai}
        end
        else if manDepth and tR.isSafedistance then
        begin
          tR.Depth := data;
          TOCOS.Update_Depth_TORP(tR.Depth, recSUT);
        end
        else if manEndis then
        begin
          tR.EnablingDistance := data;
          TOCOS.Update_EnDis_TORP(tR.EnablingDistance, recSUT);
          tR.CalcPHP;
        end;
      end;
    end;
end;

procedure TvMainCtrlPanel.Passing(i: Integer);
begin
  if i = 1 then
  begin
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen1 , cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndDorrOpn1_on  := False;

    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire1 , cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndRdyToFre1_on  := False;

    Port.IsPreparedTube := False;
    btnPrePareTube.Down := False;
    SetUpdownImage(btnPrePareTube);
  end
  else
  begin
    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndDoorOpen2 , cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndDorrOpn2_on  := False;

    SetImageIndikator(TOCOS.vTechnicalCtrlPanel.IndRdyToFire2 , cYellow , False);
    TOCOS.vTechnicalCtrlPanel.IndRdyToFre2_on  := False;

    Starboard.IsPreparedTube  := False;
    btnPrePareTube.Down       := False;
    SetUpdownImage(btnPrePareTube);
  end;
end;

{ TactiveTorp }

constructor TactiveTorp_state.Create;
begin
  ID              := not_selected;
  IsHoaming       := False;
  IsSearching     := False;
  IsTorpedo_On    := False;
  IsPreparedTube  := False;
  IsFired         := False;
end;

destructor TactiveTorp_state.Destroy;
begin
  inherited;
end;

procedure TvMainCtrlPanel.SystemOff;
var
  a       : Integer;
  i       : Byte;
  tR      : TTorpedoTrack;
  list1, list2, list3 :TList;
begin
  with Port do
  begin
    ID              := not_selected;
    Int_RAM         := False;
    IsAssTrack      := False;
    IsSearching     := False;
    IsHoaming       := False;
    IsTorpedo_On    := False;
    IsTorpedoTest   := False;
    IsPreparedTube  := False;
    IsFired         := False;
    IsTorpShutDown  := False;
    IsCor_Course    := False;
    IsCor_depth     := False;
    IsCor_Endis     := False;
    Tube            := ttPort;
  end;
  with Starboard do
  begin
    ID              := not_selected;
    Int_RAM         := False;
    IsAssTrack      := False;
    IsSearching     := False;
    IsHoaming       := False;
    IsTorpedo_On    := False;
    IsTorpedoTest   := False;
    IsPreparedTube  := False;
    IsFired         := False;
    IsTorpShutDown  := False;
    IsCor_Course    := False;
    IsCor_depth     := False;
    IsCor_Endis     := False;
    Tube            := ttPort;
  end;

  Timer3.Enabled                := False;
  TmrFirePort.Enabled           := False;
  TmrFireStarboard.Enabled      := False;
  TmrRdyToFirePort.Enabled      := False;
  TmrRdyToFireStarboard.Enabled := False;
  TmrTorpOnPort.Enabled         := False;
  TmrTorpOnStarboard.Enabled    := False;

  TOCOS.StatusTube := False;

  list1 := TOCOS.TorpedoList.GetList;
  if list1.Count > 0 then
  begin
    for I := 0 to list1.Count-1 do
    begin
      TOCOS.TorpedoList.popObject(I);
    end;
  end;

  list2 := TOCOS.torp_tocos.GetList;
  if list2.Count > 0 then
  begin
    for a := 0 to list2.Count-1 do
    begin
      if TOCOS.GetTorp_fromTube(ttPort,i,tR) then
      begin
        if not tR.IsNoTarget then
          tR.TargetTrack.AssByTorpedoVisible := False;
      end
      else if TOCOS.GetTorp_fromTube(ttStarBoard,i,tR) then
      begin
        if not tR.IsNoTarget then
          tR.TargetTrack.AssByTorpedoVisible := False;
      end;

      tR.visTrackView(False);

      TOCOS.ResetStatus;

      TOCOS.torp_tocos.popObject(I);
    end;
  end;

  list3 := TOCOS.TrackList.GetList;
  if list3.Count > 0 then
  begin
    for I := 0 to list3.Count-1 do
      TOCOS.TrackList.ClearObject;
  end;
  TOCOS.SetLPDStatus(False);
end;

procedure TvMainCtrlPanel.btnUnknMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  btnUnkn.Down := True;
  SetUpdownImage(btnUnkn);
end;

procedure TvMainCtrlPanel.btnHostlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  btnHostl.Down := True;
  SetUpdownImage(btnHostl);
end;

procedure TvMainCtrlPanel.btnFrndlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  btnFrndl.Down := True;
  SetUpdownImage(btnFrndl);
end;
end.
