unit uLibTorpedo_Singa;

interface

uses
  uLibTDCClass, uMainCtrlPanel, uDisplaySinga, uTechnicalCtrlPanel,
  uDisplayCtrlPanelLeft, uDisplayCtrlPanelBottom, uDetected, Classes,
  uLibTDCTracks, uBaseConstan, uTrackFunction, uTorpedoTrack, uTCPDatatype;

type
  //TOperMode = ( mLocal, mLocalwSonar, mRemote);

//==============================================================================
  TTorpedoInterface = class (TGenericTDCInterface)
  protected

  public
    vDisplay : TfrmLPDTorpedo;
    vMainCtrlPanel: TvMainCtrlPanel;
    vTechnicalCtrlPanel: TvTechnicalCtrlPanel;
    vDisplayCtrlPanelLeft: TvDisplayCtrlPanelLeft;
    vDisplayCtrlPanelBottom: TvDisplayCtrlPanelBottom;

    isSearch  : Boolean;  // torpedo diset ke kecepatan minimum(low) - tdk mempengaruhi setting torpedo di ANDU
    isShutdown: Boolean;
    flagPT, flagSB      : Byte;

    constructor Create;
    destructor Destroy; override;
    procedure ShowAllForm; override;

    procedure SysReset;
    procedure SetTermination_torpAss(torpTube: TTube);

    procedure TakenInTorpManualControl(torpTube: TTube);
    procedure TakenOutTorpFromManualControl(torpTube: TTube);

    function GetTrackDomainFromScreenPos(const x,y :Double; var td:TTrackDomain):Boolean;
    function CheckAssTrack(tube: TTube):Boolean;
    function CheckTorpedoON(tube: TTube):Boolean;
    function CheckTorpedoTest(tube: TTube):Boolean;
    function CheckPrepareTube(tube: TTube):Boolean;
    function CheckFire(tube: TTube):Boolean;
    function CheckSearch(tube: TTube):Boolean;
    function CheckHoming(tube: TTube):Boolean;
    function CheckShutdown(tube: TTube):Boolean;
    function CheckMan(tube: TTube):Boolean;
    procedure SetTorpTest (const v: Boolean);
    procedure State(torp :TTorpedoTrack);
    procedure SetTorpStatus(aDt : Double); override;
    //(ANDU TOCOS)
    function FindTrack_by_TrackNo(const s:String ; var aMTrack : TManualTrack) : Boolean;
    function GetBearing(pX, pY : Double) : Double;
    function GetRange(pX, pY : Double) : Double;

    procedure TorpedoDestroy(const Launcher: integer); override;
    procedure Update_TorpedoSUT_Position(const cID: integer; const x, y, heading: double; const stat:Byte; tSpeed, tCourse, tDepth: double); override;
    procedure RecvUpdateTechnicalConsole(rec : TRecStatus_Console); override;
    procedure RecvTorpSUTStatus(rec : TRec_TorpStatus); override;
    procedure SendTorpDatato3D(tR : TTorpedoTrack);

    procedure WireBreakHomming(tube: TTube);
    procedure Homming_SUT(status : Boolean); override;
    procedure Searching_SUT; override;
    procedure TorpShutDown_SUT; override;
    procedure ManualControl_SUT(IsmanualTorp : boolean); override;
    procedure ClearStatus(tube:TTube);
    procedure close;

  end;

implementation

uses
  SysUtils, Types, uFormUtil, uBaseFunction, Math, uAnduProc, Forms, uSettingFormToMonitorWith_ini,
  ExtCtrls, ufQEK;

//==============================================================================
{ TTDC_NalaInterface }


constructor TTorpedoInterface.Create;
begin
  inherited;
  flagPT := 1;
  flagSB := 1;

  frmTengah  :=  TfrmLPDTorpedo.Create(nil);
  (frmTengah as TfrmLPDTorpedo).TDCInterface := self;
  frmTengah.Caption := ' Torpedo Control Console ';

  vDisplay := frmTengah as TfrmLPDTorpedo;
  vDisplay.Top := 0;
  vDisplay.Left := 142;

    // KAYA E DISINI YG DIRUBAH TP AQ G ERUH
  //frmMainCtrlPAnel := TfrmQEK.Create;
  vMainCtrlPanel   := TvMainCtrlPanel.Create(nil);
  vMainCtrlPanel.VDisplay := vDisplay;
  vMainCtrlPanel.SetLocalVariable(self);
//  vMainCtrlPanel.Show;
//  vMainCtrlPanel.Left := 0;   //-1277;
//  vMainCtrlPanel.Top := 200;  //   650;

  vTechnicalCtrlPanel := TvTechnicalCtrlPanel.Create(nil);
  vTechnicalCtrlPanel.SetLocalVariable(self);
//  vTechnicalCtrlPanel.Show;
//  vTechnicalCtrlPanel.Left := 0; //-1295;
//  vTechnicalCtrlPanel.Top := 0;

  vDisplayCtrlPanelLeft := TvDisplayCtrlPanelLeft.Create(nil);
  vDisplayCtrlPanelLeft.SetLocalVariable(self);
//  vDisplayCtrlPanelLeft.Show;
//  vDisplayCtrlPanelLeft.Left := 0; // -645;
//  vDisplayCtrlPanelLeft.Top := 0;

  vDisplayCtrlPanelBottom := TvDisplayCtrlPanelBottom.Create(nil);
  vDisplayCtrlPanelBottom.SetLocalVariable(self);

//  vDisplayCtrlPanelBottom.Show;
//  vDisplayCtrlPanelBottom.Left := 0;
//  vDisplayCtrlPanelBottom.Top := 675;

  FC1 := TFireControl.Create;
  FC1.Name := 'FC1';
  FC2 := TFireControl.Create;
  FC2.Name := 'FC2';
  FC3 := TFireControl.Create;
  FC3.Name := 'FC3';
  FC4 := TFireControl.Create;
  FC4.Name := 'FC4';
  FC5 := TFireControl.Create;
  FC5.Name := 'FC5';

  OBMLeft.Visible := False;
  Cursorss.Visible := False;
  //mode := mLocal;
  //SEARC := False;

  ShowAllForm;

end;

destructor TTorpedoInterface.Destroy;
begin
  FreeAndNil(FC1);
  FreeAndNil(FC2);
  FreeAndNil(FC3);
  FreeAndNil(FC4);

  if Assigned(frmTengah) then  FreeAndNil(frmTengah);

  if Assigned(vMainCtrlPanel) then  FreeAndNil(vMainCtrlPanel);
  if Assigned(vTechnicalCtrlPanel) then  FreeAndNil(vTechnicalCtrlPanel);
  if Assigned(vDisplayCtrlPanelLeft  ) then FreeAndNil(vDisplayCtrlPanelLeft);
  if Assigned(vDisplayCtrlPanelBottom) then FreeAndNil(vDisplayCtrlPanelBottom);
  inherited;
end;

procedure TTorpedoInterface.ShowAllForm;
var path :string;
  idxTengah, alTengah, xTengah, yTengah,
  idxvTechnicalCtrlPanel, alvTechnicalCtrlPanel, xvTechnicalCtrlPanel, yvTechnicalCtrlPanel,
  idxvMainCtrlPanel, alvMainCtrlPanel, xvMainCtrlPanel, yvMainCtrlPanel,
  idxvDisplay, alvDisplay, xvDisplay, yvDisplay,
  idxvDisplayCtrlPanelBottom, alvDisplayCtrlPanelBottom, xvDisplayCtrlPanelBottom, yvDisplayCtrlPanelBottom,
  idxvDisplayCtrlPanelLeft, alvDisplayCtrlPanelLeft, xvDisplayCtrlPanelLeft, yvDisplayCtrlPanelLeft : Integer;

begin
  //inherited;

  path := ExtractFilePath(Application.ExeName) + 'SetFormTOCOSToMonitor.ini';
  Getsettingform(path, 'TENGAH', idxTengah, alTengah, xTengah, yTengah);
  Getsettingform(path, 'TECHNICALCTRLPANEL',idxvTechnicalCtrlPanel, alvTechnicalCtrlPanel, xvTechnicalCtrlPanel, yvTechnicalCtrlPanel);
  Getsettingform(path, 'MAINCTRLPANEL', idxvMainCtrlPanel, alvMainCtrlPanel, xvMainCtrlPanel, yvMainCtrlPanel);
  Getsettingform(path, 'DISPLAY', idxvDisplay, alvDisplay, xvDisplay, yvDisplay);
  Getsettingform(path, 'DISPLAYCTRLPNLBTM', idxvDisplayCtrlPanelBottom, alvDisplayCtrlPanelBottom, xvDisplayCtrlPanelBottom, yvDisplayCtrlPanelBottom);
  Getsettingform(path, 'DISPLAYCTRLPNLLEFT', idxvDisplayCtrlPanelLeft, alvDisplayCtrlPanelLeft, xvDisplayCtrlPanelLeft, yvDisplayCtrlPanelLeft);

  //setting form size..
  vTechnicalCtrlPanel.Height := 1080;
  vTechnicalCtrlPanel.Width := 1920;

  vMainCtrlPanel.Height := 540;
  vMainCtrlPanel.Width := 1920;

  frmTengah.Height := 1080;
  frmTengah.Width := 1280;

  vDisplay.Height := 1080;
  vDisplay.Width := 1280;

  vDisplayCtrlPanelBottom.Width := 1280;
  vDisplayCtrlPanelBottom.Height := 540;

  vDisplayCtrlPanelLeft.Height := 1620;
  vDisplayCtrlPanelLeft.Width := 640;


  case Screen.MonitorCount of
    1 :
      begin
        AlignFormToMonitor(0, apCenter  , 0, 0, TForm(frmTengah ));

        //monitor 0 bawah
        AlignFormToMonitor(0, apCenterBottom  , 0 , 0, TForm(vMainCtrlPanel));
        AlignFormToMonitor(0, apRightTop  , 0, 0, TForm(vDisplayCtrlPanelBottom ));

        //monitor 1 tengah
        AlignFormToMonitor(0, apLeftTop  , 0, 0, TForm(vDisplayCtrlPanelLeft ));
        AlignFormToMonitor(0, apRightTop   , 0, 0, TForm(vDisplay));

        //monitor 2 atas
        AlignFormToMonitor(0, apLeftBottom, 0, 0, TForm(vTechnicalCtrlPanel));
      end;
    2 :
      begin
        AlignFormToMonitor(idxvMainCtrlPanel, TAlignPos(alvMainCtrlPanel), xvMainCtrlPanel, yvMainCtrlPanel, TForm(vMainCtrlPanel));
        AlignFormToMonitor(idxvTechnicalCtrlPanel, TAlignPos(alvTechnicalCtrlPanel), xvTechnicalCtrlPanel, yvTechnicalCtrlPanel, TForm(vTechnicalCtrlPanel));

        //monitor 1
        AlignFormToMonitor(idxvDisplayCtrlPanelLeft, TAlignPos(alvDisplayCtrlPanelLeft), xvDisplayCtrlPanelLeft, yvDisplayCtrlPanelLeft, TForm(vDisplayCtrlPanelLeft));
        AlignFormToMonitor(idxvDisplay, TAlignPos(alvDisplay), xvDisplay, yvDisplay, TForm(vDisplay));

        //monitor 2
        AlignFormToMonitor(idxvDisplayCtrlPanelBottom, TAlignPos(alvDisplayCtrlPanelBottom), xvDisplayCtrlPanelBottom, yvDisplayCtrlPanelBottom, TForm(vDisplayCtrlPanelBottom));

//        if Assigned(vDisplay               ) then vDisplay.FormStyle  := fsStayOnTop;
        if Assigned(vDisplay               ) then vDisplay.BorderStyle := bsSizeable;
        if Assigned(vMainCtrlPanel         ) then vMainCtrlPanel.BorderStyle := bsSizeable;
        if Assigned(vTechnicalCtrlPanel    ) then vTechnicalCtrlPanel.BorderStyle := bsSizeable;
        if Assigned(vDisplayCtrlPanelLeft  ) then vDisplayCtrlPanelLeft.BorderStyle := bsSizeable;
        if Assigned(vDisplayCtrlPanelBottom) then vDisplayCtrlPanelBottom.BorderStyle := bsSizeable;

//        if Assigned(vDisplay               ) then vDisplay.BorderStyle := bsNone;
//        if Assigned(vMainCtrlPanel         ) then vMainCtrlPanel.BorderStyle := bsNone;
//        if Assigned(vTechnicalCtrlPanel    ) then vTechnicalCtrlPanel.BorderStyle := bsNone;
//        if Assigned(vDisplayCtrlPanelLeft  ) then vDisplayCtrlPanelLeft.BorderStyle := bsNone;
//        if Assigned(vDisplayCtrlPanelBottom) then vDisplayCtrlPanelBottom.BorderStyle := bsNone;

      end;
    3 :
      begin
        AlignFormToMonitor(idxTengah, TAlignPos(alTengah), xTengah, yTengah, TForm(frmTengah ));

        //monitor 0

        AlignFormToMonitor(idxvMainCtrlPanel, TAlignPos(alvMainCtrlPanel), xvMainCtrlPanel, yvMainCtrlPanel, TForm(vMainCtrlPanel));
        AlignFormToMonitor(idxvTechnicalCtrlPanel, TAlignPos(alvTechnicalCtrlPanel), xvTechnicalCtrlPanel, yvTechnicalCtrlPanel, TForm(vTechnicalCtrlPanel));

        //monitor 1
        AlignFormToMonitor(idxvDisplayCtrlPanelLeft, TAlignPos(alvDisplayCtrlPanelLeft), xvDisplayCtrlPanelLeft, yvDisplayCtrlPanelLeft, TForm(vDisplayCtrlPanelLeft));
        AlignFormToMonitor(idxvDisplay, TAlignPos(alvDisplay), xvDisplay, yvDisplay, TForm(vDisplay));

        //monitor 2     Setting nya kok ndak bener ya di console???
        AlignFormToMonitor(idxvDisplayCtrlPanelBottom, TAlignPos(alvDisplayCtrlPanelBottom), xvDisplayCtrlPanelBottom, yvDisplayCtrlPanelBottom, TForm(vDisplayCtrlPanelBottom));
      end;
  end;

  if Assigned(vDisplay               ) then vDisplay.Show;
  if Assigned(vMainCtrlPanel         ) then vMainCtrlPanel.Show;
  if Assigned(vTechnicalCtrlPanel    ) then vTechnicalCtrlPanel.Show;
  if Assigned(vDisplayCtrlPanelLeft  ) then vDisplayCtrlPanelLeft.Show;
  if Assigned(vDisplayCtrlPanelBottom) then vDisplayCtrlPanelBottom.Show;
end;

{============================== ANDU TOCOS =================================== }

function TTorpedoInterface.FindTrack_by_TrackNo(const s:String ;
          var aMTrack : TManualTrack) : Boolean;
var
  i : Integer;
  list : TList;
  no : String;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := FALSE;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    no := GetTrackNo(aMTrack.ShipTrackId,aMTrack.TrackNumber);
    if (no = s) then result := True
    else Dec(i);
  end;
  TrackList.ReturnList;

  if not Result then aMtrack := nil;
end;
{===============================================================================}

procedure TTorpedoInterface.RecvUpdateTechnicalConsole(rec : TRecStatus_Console);
var
  s    : String;
  mShip: Integer;
  val  : Boolean;
  lmp  : TImage;
  clr  : TcolorIndikator;
begin
  s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
  TryStrToInt(s,mShip);
  if (rec.OWN_SHIP_UID = s) or (rec.OWN_SHIP_UID = xSHIP.UniqueID) then
  begin
    if rec.ParamError = __PARAM_TOCOS_ON then
      val := True
    else
      val := false;


    with vTechnicalCtrlPanel do begin
      if not btnSysOn.Down then Exit;

      case rec.ErrorID  of
      __STAT_TOCOS_NUG_1 : lmp := IndNUG1;
      __STAT_TOCOS_NUG_2 : lmp := IndNUG2;

      __STAT_TOCOS_Port_Indikator_Port     : lmp := IndPort;
      __STAT_TOCOS_StbPort_Indikator_Port  : lmp := IndStb;
      __STAT_TOCOS_Port_ToSupply           : lmp := IndToSupply1;
      __STAT_TOCOS_StbPort_ToSupply        : lmp := IndToSupply2;
      __STAT_TOCOS_Port_120_BAR            : lmp := Ind120Bar1;
      __STAT_TOCOS_StbPort_120_BAR         : lmp := Ind120Bar2;
      __STAT_TOCOS_Port_20_BAR             : lmp := Ind20Bar1;
      __STAT_TOCOS_StbPort_20_BAR          : lmp := Ind20Bar2;
      __STAT_TOCOS_Port_DOOR_Open          : lmp := IndDoorOpen1;
      __STAT_TOCOS_StbPort_DOOR_Open       : lmp := IndDooropen2;
      __STAT_TOCOS_Port_TORP_On            : lmp := IndTorpOn1;
      __STAT_TOCOS_StbPort_TORP_On         : lmp := IndTorpOn2;
      __STAT_TOCOS_Port_Ready_To_Fire      : lmp := IndRdyToFire1;
      __STAT_TOCOS_StbPort_Ready_To_Fire   : lmp := IndRdyToFire2;
        else Exit;
      end;

      if (rec.ErrorID < 413) then
        clr := cRed
      else if (rec.ErrorID >= 413) and (rec.ErrorID <= 426)then
        clr := cYellow
      else
        clr := cGreen;

      if lmp <> nil then
        setimageindikator(lmp, clr, val);
    end;



    {
        __STAT_TempWEC :
        begin
          if rec.ParamError = 1 then
            btnTempWec.Click
          else
          begin
            btnTempWec.Down := False;
            SetUpdownImage(btnTempWec);
          end;
        end;
        __STAT_TempTCC :
        begin
          if rec.ParamError = 1 then
            btnTempTcc.Click
          else
          begin
            btnTempTcc.Down := false;
            SetUpdownImage(btnTempTcc);
          end;
        end;
        __STAT_FuseWEC :
        begin
          if rec.ParamError = 1 then
            btnWec.Click
          else
          begin
            btnWec.Down := false;
            SetUpdownImage(btnWec);
          end;
        end;
        __STAT_FuseTCC:
        begin
          if rec.ParamError = 1 then
            btnFusesTcc.Click
          else
          begin
            btnFusesTcc.Down := false;
            SetUpdownImage(btnFusesTcc);
          end;
        end;
        __STAT_PowerResetWEC:
        begin
          if rec.ParamError = 1 then
            btnPowerResetWec.Click
          else
          begin
            btnPowerResetWec.Down := false;
            SetUpdownImage(btnPowerResetWec);
          end;
        end;
        __STAT_PowerResetTCC:
        begin
          if rec.ParamError = 1 then
            btnPowerResetTcc.Click
          else
          begin
            btnPowerResetTcc.Down := false;
            SetUpdownImage(btnPowerResetTcc);
          end;
        end;
        __STAT_CMPTR :
        begin
          if rec.ParamError = 1 then
            btnCmptr.Click
          else
          begin
            btnCmptr.Down := false;
            SetUpdownImage(btnCmptr);
          end;
        end;
        __STAT_SOFTW :
        begin
          if rec.ParamError = 1 then
            btnSoftw.Click
          else
          begin
            btnSoftw.Down := false;
            SetUpdownImage(btnSoftw);
          end;
        end;
        __STAT_AntiCondensHeating :
        begin

        end;
        __STAT_LOADPROGR :
        begin
          if rec.ParamError = 1 then
            btnLoadProgr.Click
          else
          begin
            btnLoadProgr.Down := false;
            SetUpdownImage(btnLoadProgr);
          end;
        end;
        __STAT_Port_Indikator_Port :
        begin
          if rec.ParamError = 1 then
            btnPort.Click
          else
          begin
            btnPort.Down := false;
            SetUpdownImage(btnPort);
          end;
        end;
        __STAT_StbPort_Indikator_Port :
        begin
          if rec.ParamError = 1 then
            btnStb.Click
          else
          begin
            btnStb.Down := false;
            SetUpdownImage(btnStb);
          end;
        end;
        __STAT_Port_ToSupply :
        begin
          if rec.ParamError = 1 then
            btnToSupply1.Click
          else
          begin
            btnToSupply1.Down := false;
            SetUpdownImage(btnToSupply1);
          end;
        end;
        __STAT_Port_120_BAR :
        begin
          if rec.ParamError = 1 then
            btn120Bar1.Click
          else
          begin
            btn120Bar1.Down := false;
            SetUpdownImage(btn120Bar1);
          end;
        end;
        __STAT_Port_20_BAR :
        begin
          if rec.ParamError = 1 then
            btn20Bar1.Click
          else
          begin
            btn20Bar1.Down := false;
            SetUpdownImage(btn20Bar1);
          end;
        end;
        __STAT_Port_DOOR_Open :
        begin
          if rec.ParamError = 1 then
            btnDoorOpen1.Click
          else
          begin
            btnDoorOpen1.Down := false;
            SetUpdownImage(btnDoorOpen1);
          end;
        end;
        __STAT_Port_TORP_On :
        begin
          if rec.ParamError = 1 then
            btnTorpOn1.Click
          else
          begin
            btnTorpOn1.Down := false;
            SetUpdownImage(btnTorpOn1);
          end;
        end;
        __STAT_Port_Ready_To_Fire :
        begin
          if rec.ParamError = 1 then
            btnRdyToFre1.Click
          else
          begin
            btnRdyToFre1.Down := false;
            SetUpdownImage(btnRdyToFre1);
          end;
        end;

        __STAT_StbPort_ToSupply :
        begin
          if rec.ParamError = 1 then
            btnToSupply2.Click
          else
          begin
            btnToSupply2.Down := false;
            SetUpdownImage(btnToSupply2);
          end;
        end;
        __STAT_StbPort_120_BAR :
        begin
          if rec.ParamError = 1 then
            btn120Bar2.Click
          else
          begin
            btn120Bar2.Down := false;
            SetUpdownImage(btn120Bar2);
          end;
        end;
        __STAT_StbPort_20_BAR :
        begin
          if rec.ParamError = 1 then
            btn20Bar2.Click
          else
          begin
            btn20Bar2.Down := false;
            SetUpdownImage(btn20Bar2);
          end;
        end;
        __STAT_StbPort_DOOR_Open :
        begin
          if rec.ParamError = 1 then
            btnDoorOpen2.Click
          else
          begin
            btnDoorOpen2.Down := false;
            SetUpdownImage(btnDoorOpen2);
          end;
        end;
        __STAT_StbPort_TORP_On :
        begin
          if rec.ParamError = 1 then
            btnTorpOn2.Click
          else
          begin
            btnTorpOn2.Down := false;
            SetUpdownImage(btnTorpOn2);
          end;
        end;
        __STAT_StbPort_Ready_To_Fire :
        begin
          if rec.ParamError = 1 then
            btnRdyToFre2.Click
          else
          begin
            btnRdyToFre2.Down := false;
            SetUpdownImage(btnRdyToFre2);
          end;
        end;
      end;
    end;
    cendol : Konstanta dihapus nando}
  end;
end;

function TTorpedoInterface.GetBearing(pX, pY: Double): Double;
begin
  Result :=  ValidateDegree(CalcBearing(xSHIP.PositionX, xSHIP.PositionY, pX, Py));
end;

function TTorpedoInterface.GetRange(pX, pY: Double): Double;  // yard
begin
  Result := C_NauticalMiles_To_Yard * CalcRange(xSHIP.PositionX, xSHIP.PositionY, pX, Py);
end;

function TTorpedoInterface.GetTrackDomainFromScreenPos(const x,y :Double; var td:TTrackDomain):Boolean;
var findTrack: boolean;
    pt  : TPoint;
    mTrack : TManualTrack;
begin
  result := False;
  pt := ConvertToScreen(x,y);

  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if not findTrack or not (cTrack is TManualTrack) then exit;

  mTrack := cTrack as TManualTrack;
  td := GetTrackDomainFromIDENT(mTrack.GetIdent);
  Result := True;
end;

procedure TTorpedoInterface.Homming_SUT(status : Boolean);
var
  i     : Byte;
  s     : String;
  mShip : Integer;
  tR    :TTorpedoTrack;
  aRec  : TRecSetTorpedoSUT;
begin
  inherited;

  if GetTorp_fromTube(torpAssgn,i,tR) then
  begin
    if tR.Launched and tR.Enabled and not tR.IsManual then
    begin
      if status then
      begin
        if tR.isDetectTarget then
        begin
          tR.IsHoaming  := True;
          tR.TempSpeed  := tR.Speed;
          tR.TempSpeedType := tR.SpeedType;
          tR.SpeedType  := stHigh;
          aRec.OrderID  := __ORD_TORPEDOSUT_HOMING;
          aRec.mPredm   := Word(mHoming);
        end
        else
        begin
          if tR.TrackView.Show_Endist then
          begin
            Exit;   {Torp belum mencapai jarak}
          end
          else
          begin
            aRec.OrderID  := __ORD_TORPEDOSUT_TARGETSEARCHPROGRAM;
            aRec.mPredm   := Word(mTargetSearchProgram);
            tR.TargetID   := 0;
          end;
        end;
      end
      else
      begin
        tR.IsHoaming := False;
        tR.SpeedType := tR.TempSpeedType;
        tR.Speed     := tR.TempSpeed;
        aRec.OrderID := __ORD_TORPEDOSUT_MANUAL;
        aRec.mPredm  := Word(mManualNavigate);
      end;


      if not TOCOSSim then
      begin
        s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
        TryStrToInt(s,mShip);

        aRec.ShipID         := mShip;
        aRec.mT_ID          := tR.TargetID;
        aRec.mMissileID     := 1;
        aRec.mMissileNumber := 1;
        aRec.mWeaponID      := C_DBID_TORPEDO_SUT;

        if (tR.Tube = ttPort) then
          aRec.mLauncherID := 1 else
        if (tR.Tube = ttStarBoard) then
          aRec.mLauncherID := 2;

        aRec.mTorpedoCourse       := tR.Course;
        aRec.mTorpedoSpeed        := tR.Speed;
        aRec.mTorpedoDepth        := abs(tR.Depth)* C_Feet_To_Meter;
        aRec.mTargetType          := tR.TargetType;
        aRec.mTorpedoSafeDistance := tR.SafeDistance * C_Yard_To_Meter;
        aRec.mTorpedoEnDis        := tr.EnablingDistance * C_Yard_To_Meter;

        netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
        {LOG}
        SendEvenTOCOS(12);
        {LOG}
      end;
    end;
  end;
end;

procedure TTorpedoInterface.ManualControl_SUT(IsmanualTorp: boolean);
var
  i     : Byte;
  s, t  : String;
  mShip,
  mTarget : Integer;
  tR    :TTorpedoTrack;
  aRec : TRecSetTorpedoSUT;
begin
  inherited;
  tR := nil;
  if not GetTorp_fromTube(torpAssgn,i,tR) then begin
     if Assigned(torpManual)  then
        tR := torpManual;
  end;

  try
    if Assigned(tR) then begin
      tR.IsManual  := IsmanualTorp;   //<-- set Manual Locally
      if tR.Launched then
      begin
        if not TOCOSSim then begin
          s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
          t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
          TryStrToInt(s,mShip);
          TryStrToInt(t,mTarget);

          aRec.ShipID     := mShip;
          aRec.mT_ID      := mTarget;
          aRec.mMissileID := 1;
          aRec.mWeaponID  := C_DBID_TORPEDO_SUT;
          aRec.mMissileNumber := 1;

          if (tR.Tube = ttPort) then
            aRec.mLauncherID := 1 else
          if (tR.Tube = ttStarBoard) then
            aRec.mLauncherID := 2;

          if IsmanualTorp then begin
            aRec.OrderID := __ORD_TORPEDOSUT_MANUAL;
            aRec.mPredm  := Word(mManualNavigate);

          end
          else begin
            aRec.OrderID := __ORD_TORPEDOSUT_SEARCH;
            aRec.mPredm  := Word(tR.PredMod);
            tR.IsManual  := false;
          end;
          aRec.mTorpedoCourse := tR.Course;
          aRec.mTorpedoSpeed  := tR.Speed;
          aRec.mTorpedoDepth  := abs(tR.Depth)* C_Feet_To_Meter;
          aRec.mTargetType    := tR.TargetType;
          aRec.mTorpedoSafeDistance := tR.SafeDistance * C_Yard_To_Meter;
          aRec.mTorpedoEnDis  := tr.EnablingDistance * C_Yard_To_Meter;

          netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
        end;
      end;
    end;
  finally
  end;
end;

procedure TTorpedoInterface.SysReset;
begin
  TOCOSSysON := False;
  ResetStatus;
  SetLPDStatus(False);
end;

procedure TTorpedoInterface.Searching_SUT;
var
  i     : Byte;
  s, t  : String;
  mShip, mtarget : Integer;
  tR    :TTorpedoTrack;
  aRec : TRecSetTorpedoSUT;
begin
  inherited;

  if GetTorp_fromTube(torpAssgn,i,tR) then
  begin
    if not TOCOSSim then begin
      if isSearch then
      begin
        tR.TempSpeed      := tR.Speed;
        tR.TempSpeedType  := tR.SpeedType; {tampung dulu untuk keperluan lepas search}
        tR.SpeedType      := stLow;
      end
      else
      begin
        tR.SpeedType  := tR.TempSpeedType;
        tR.speed      := tR.TempSpeed;
      end;

      s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
      TryStrToInt(s,mShip);

      aRec.ShipID         := mShip;
      aRec.OrderID        := __ORD_TORPEDOSUT_SEARCH;
      aRec.mWeaponID      := C_DBID_TORPEDO_SUT;
      aRec.mMissileID     := 1;
      aRec.mMissileNumber := 1;

      if (tR.Tube = ttPort) then
        aRec.mLauncherID := 1 else
      if (tR.Tube = ttStarBoard) then
        aRec.mLauncherID := 2;

      if not tR.IsNoTarget then
      begin
        t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
        TryStrToInt(t,mTarget);

        aRec.mT_ID  := mTarget;
        aRec.mPredm := word(tR.PredMod);
      end
      else
      begin
        aRec.mT_ID  := 0;
        aRec.mPredm := Word(mManualNavigate);
      end;

      aRec.mTorpedoCourse       := tR.Course;
      aRec.mTorpedoSpeed        := tR.Speed;
      aRec.mTorpedoDepth        := abs(tR.Depth)* C_Feet_To_Meter;
      aRec.mTargetType          := tR.TargetType;
      aRec.mTorpedoSafeDistance := tR.SafeDistance * C_Yard_To_Meter;
      aRec.mTorpedoEnDis        := tr.EnablingDistance * C_Yard_To_Meter;

      netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);

      {LOG}
      SendEvenTOCOS(12);
      {LOG}
    end;
  end;
end;

procedure TTorpedoInterface.SendTorpDatato3D(tR : TTorpedoTrack);
Var
  s,t   : String;
  mShip,
  mTarget : Integer;
  aRec : TRecSetTorpedoSUT;
begin
  if not Assigned(tR) then
    Exit;

  if tR.Launched and tR.Enabled then     // Jika telah diluncurkan, jika enable, dan jika tidak dikontrol secara Manual
  begin
    if not TOCOSSim then begin
      s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
      TryStrToInt(s,mShip);

      aRec.ShipID          := mShip;
      aRec.OrderID         := __ORD_TORPEDOSUT_NAVIGATE;
      aRec.mWeaponID       := C_DBID_TORPEDO_SUT;
      aRec.mMissileID      := 1;
      aRec.mMissileNumber  := 1;

      if (tR.Tube = ttPort) then
        aRec.mLauncherID := 1 else
      if (tR.Tube = ttStarBoard) then
        aRec.mLauncherID := 2;

      if not tR.IsNoTarget then
      begin
        t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
        TryStrToInt(t,mTarget);

        aRec.mT_ID  := mTarget;
        aRec.mpredm := Word(tR.PredMod);
      end
      else
      begin
        aRec.mT_ID  := 0;
        aRec.mpredm := Word(mManualNavigate);
      end;

      aRec.mTorpedoCourse        := tR.Course;
      aRec.mTorpedoSpeed         := tR.Speed;
      aRec.mTorpedoDepth         := abs(tR.Depth) * C_feet_To_Meter;
      aRec.mTargetType           := tR.TargetType;
      aRec.mTorpedoSafeDistance  := tr.SafeDistance * C_Yard_To_Meter;
      aRec.mTorpedoEnDis         := tR.EnablingDistance * C_Yard_To_Meter;

      netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
    end;
  end;
end;

procedure TTorpedoInterface.SetTermination_torpAss(torpTube:TTube);
var
  i    :Byte;
  tR   :TTorpedoTrack;
begin
  if GetTorp_fromTube(torpTube,i,tR) then
  begin
    tempTorped := tR;
    torp_tocos.popObject(i);

    if not tempTorped.IsNoTarget then
      tempTorped.TargetTrack.AssByTorpedoVisible := False;

    tempTorped.IsNoTarget:= True;
    tempTorped.visTrackView(False);

    SetStatus(1,0,tempTorped.Tube,''); {status depth}
    SetStatus(2,0,tempTorped.Tube,''); {status runtime}
  end;
end;

procedure TTorpedoInterface.TakenInTorpManualControl(torpTube: TTube);
var
  i    : Byte;
begin
  if GetTorp_fromTube(torpTube,i,torpManual) then
  begin
    if Assigned(torpManual) then
    begin
      torp_tocos.popObject(i);
      torpManual.visPHP(False);

      if not torpManual.IsNoTarget then
        torpManual.TargetTrack.AssByTorpedoVisible := False;

      SetStatus(1,0,torpManual.Tube,''); {status depth}
      SetStatus(2,0,torpManual.Tube,''); {status runtime}
    end;
  end;
end;

procedure TTorpedoInterface.TakenOutTorpFromManualControl(torpTube: TTube);
begin
  if Assigned(torpManual) then
  begin
    torpManual.Course := ValidateDegree(xSHIP.Heading + 180.0);
    torpManual.CalcPHP;
    torpManual.visPHP(True);

    if not torpManual.IsNoTarget then
      torpManual.TargetTrack.AssByTorpedoVisible:= true;

    torp_tocos.AddObject(torpManual);
    torpManual:= nil;
  end;
end;

function TTorpedoInterface.CheckTorpedoTest(tube: TTube): Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (vTechnicalCtrlPanel.IndTorpOn1_on = True) and (vMainCtrlPanel.Starboard.IsTorpedoTest = False)then
    begin
      Result := True;
    end;
  end
  else if(tube = ttStarBoard) then begin
    if (vTechnicalCtrlPanel.IndTorpOn2_on = True) and (vMainCtrlPanel.Port.IsTorpedoTest = false)then
    begin
      Result := True;
    end;

  end;
end;

procedure TTorpedoInterface.ClearStatus(tube: TTube);
begin
  SetStatus(0,0, tube, ID_WireRupture);

  {Clear Status di LPD}
  SetStatus(0,1, tube,'');
  SetStatus(0,2, tube,'');
  SetStatus(0,3, tube,'');

  {Clear Depth di LPD}
  SetStatus(1,0, tube,'');

  {Clear Runtime di LPD}
  SetStatus(2,0, tube,'');

  {Clear warning di LPD}
  SetStatus(3,0, tube,'');
end;

procedure TTorpedoInterface.close;
begin
  vDisplay.Close;
  vMainCtrlPanel.Close;
  vTechnicalCtrlPanel.Close;
  vDisplayCtrlPanelLeft.Close;
  vDisplayCtrlPanelBottom.Close;
end;

function TTorpedoInterface.CheckTorpedoON(tube: TTube):Boolean;
begin
  result := False;

  if tube = ttNone then
    Exit;

  if (tube = ttPort) then
  begin
     if vTechnicalCtrlPanel.IndToSup1_on and (vDisplayCtrlPanelLeft.txt603.Text = 'O N')
        and (StrToInt(vDisplayCtrlPanelLeft.txt614_1.Text)<>0) and (LoadTube.Port = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) and (vMainCtrlPanel.IsPortFlag) then
        Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if  vTechnicalCtrlPanel.IndToSup2_on and (vDisplayCtrlPanelLeft.txt503.Text = 'O N')
        and (StrToInt(vDisplayCtrlPanelLeft.txt514_1.Text)<>0) and (LoadTube.StarBoard = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) and (vMainCtrlPanel.IsStbFlag) then
        Result := True;
  end;
end;

function TTorpedoInterface.CheckAssTrack(tube: TTube): Boolean;
var findTrack,
    findObj   : boolean;
    detObj    : TDetectedObject;
begin
  result := False;

  findTrack := FindTrack_by_ScreenPos(OBMRight.Center.X, OBMRight.Center.Y, cTrack);
  findObj   := ActiveRadar.FindDetectedObjectByView(OBMRight.Center.X,OBMRight.Center.Y,detObj);

  if findObj then begin
    if findTrack and (cTrack is TManualTrack) then begin
      Result := True;
    end
  end;
end;

function TTorpedoInterface.CheckFire(tube: TTube): Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (vTechnicalCtrlPanel.IndToSup1_on)       and (vTechnicalCtrlPanel.Ind120Bar1_on)
        and (vTechnicalCtrlPanel.Ind20Bar1_on)  and (vTechnicalCtrlPanel.IndDorrOpn1_on)
        and (vTechnicalCtrlPanel.IndTorpOn1_on) and (LoadTube.Port = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) and (vTechnicalCtrlPanel.IndRdyToFre1_on) then
         Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if (vTechnicalCtrlPanel.IndToSup2_on)       and (vTechnicalCtrlPanel.Ind120Bar2_on)
        and (vTechnicalCtrlPanel.Ind20Bar2_on)  and (vTechnicalCtrlPanel.IndDorrOpn2_on)
        and (vTechnicalCtrlPanel.IndTorpOn2_on) and (LoadTube.StarBoard = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) and (vTechnicalCtrlPanel.IndRdyToFre2_on) then
        Result := True;
  end;
end;

function TTorpedoInterface.CheckHoming(tube: TTube): Boolean;
var
  i     : Byte;
  tR    :TTorpedoTrack;
begin
  result := False;
  if GetTorp_fromTube(torpAssgn,i,tR) then
  begin
    if (tube = ttPort) then begin
      if (LoadTube.Port = tsLaunch) and (vDisplayCtrlPanelLeft.txt612_1.Text ='O F F')
          and (tR.isSafedistance) then
           Result := True;
    end
    else if(tube = ttStarBoard) then begin
      if  (LoadTube.StarBoard = tsLaunch) and (vDisplayCtrlPanelLeft.txt512_1.Text ='O F F')
          and (tR.isSafedistance) then {kurang homing blok off}
          Result := True;
    end;
  end;
end;

function TTorpedoInterface.CheckMan(tube: TTube): Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (LoadTube.Port <> tsOff) then
         Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if  (LoadTube.StarBoard <> tsOff) then
        Result := True;
  end;
end;

function TTorpedoInterface.CheckPrepareTube(tube: TTube):Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (vTechnicalCtrlPanel.Ind20Bar1_on) and (vDisplayCtrlPanelLeft.txt603.Text = 'O N')
        and (StrToInt(vDisplayCtrlPanelLeft.txt614_1.Text)<>0) and (LoadTube.Port = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) then
        if (vMainCtrlPanel.btnTorpOn.Down) then
        begin
          if (vTechnicalCtrlPanel.IndTorpOn1_on) then
            Result := True;
        end
        else
          Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if  (vTechnicalCtrlPanel.Ind20Bar2_on) and (vDisplayCtrlPanelLeft.txt503.Text = 'O N')
        and (StrToInt(vDisplayCtrlPanelLeft.txt514_1.Text)<>0) and (LoadTube.StarBoard = tsLoading)
        and (vMainCtrlPanel.btnTorpTest.Down = False) then
        if (vMainCtrlPanel.btnTorpOn.Down) then
        begin
          if (vTechnicalCtrlPanel.IndTorpOn2_on) then
            Result := True;
        end
        else
          Result := True;
  end;
end;

function TTorpedoInterface.CheckSearch(tube: TTube): Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (LoadTube.Port = tsLaunch) and (vMainCtrlPanel.btnHomng.Down = False) then
         Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if  (LoadTube.StarBoard = tsLaunch) and (vMainCtrlPanel.btnHomng.Down = False) then
        Result := True;
  end;
end;

function TTorpedoInterface.CheckShutdown(tube: TTube): Boolean;
begin
  result := False;
  if (tube = ttPort) then begin
    if (LoadTube.Port = tsLaunch) then
         Result := True;
  end
  else if(tube = ttStarBoard) then begin
    if  (LoadTube.StarBoard = tsLaunch) then
        Result := True;
  end;
end;

procedure TTorpedoInterface.TorpedoDestroy(const Launcher: integer);
begin
  inherited;

end;

procedure TTorpedoInterface.TorpShutDown_SUT;
var
  i       : Byte;
  s, t    : String;
  mShip,
  mtarget : Integer;
  tR      : TTorpedoTrack;
  aRec    : TRecSetTorpedoSUT;
begin
  if GetTorp_fromTube(torpAssgn,i,tR) then
  begin
    if tR.Enabled and tR.Launched then
    begin
      s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
      TryStrToInt(s,mShip);

      aRec.ShipID         := mShip;
      aRec.mWeaponID      := C_DBID_TORPEDO_SUT;
      aRec.mMissileID     := 1;
      aRec.mMissileNumber := 1;

      if isShutdown then {Kalo torpedo d shutdown}
      begin
        tR.visTrackView(False);
        tR.IsnotActive_Torp := True;
        tR.TempSpeed        := tR.Speed;
        tR.TempSpeedType    := tR.SpeedType;

        aRec.OrderID        := __ORD_TORPEDOSUT_SHUTDOWN;
        aRec.mTorpedoSpeed  := 0;
        aRec.mPredm         := Word(mManualNavigate);

        if not tR.IsNoTarget then
        begin
          t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
          TryStrToInt(t,mTarget);

          aRec.mT_ID  := mTarget;
        end
        else
        begin
          aRec.mT_ID  := 0;
        end;
      end
      else
      begin
        tR.visTrackView(True);
        tR.IsnotActive_Torp := False;
        tR.SpeedType        := tR.TempSpeedType;
        tR.Speed            := tR.TempSpeed;

        aRec.OrderID        := __ORD_TORPEDOSUT_NAVIGATE;
        aRec.mTorpedoSpeed  := tR.Speed;

        if not tR.IsNoTarget then
        begin
          t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
          TryStrToInt(t,mTarget);

          aRec.mT_ID  := mTarget;
          aRec.mPredm := word(tR.PredMod);
        end
        else
        begin
          aRec.mT_ID  := 0;
          aRec.mPredm := Word(mManualNavigate);
        end;
      end;

      if (torpAssgn = ttPort) then
        aRec.mLauncherID := 1 else
      if (torpAssgn = ttStarBoard) then
        aRec.mLauncherID := 2;

      aRec.mTorpedoCourse       := tR.Course;

      aRec.mTorpedoDepth        := abs(tR.Depth)* C_Feet_To_Meter;
      aRec.mTargetType          := tR.TargetType;
      aRec.mTorpedoSafeDistance := tR.SafeDistance * C_Yard_To_Meter;
      aRec.mTorpedoEnDis        := tr.EnablingDistance * C_Yard_To_Meter;

      netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
    end;
  end;
end;

procedure TTorpedoInterface.Update_TorpedoSUT_Position(const cID: integer;
  const x, y, heading: double; const stat: Byte; tSpeed, tCourse, tDepth: double);
var i : integer;
    l : TList;
    tube : TTube;

begin
  inherited;

  if cID = 1 then
    tube := ttPort
  else
    tube := ttStarBoard;

  l := TorpedoList.GetList;
  for i := 0 to l.Count-1 do begin
    trackTorped := l[i];
    if Assigned(trackTorped) then begin
      if (trackTorped.Launched) and (trackTorped.Tube = tube)  then begin
        if (stat = 3) or (stat = 2) then begin // fired
          if tube = ttPort then
            vMainCtrlPanel.Port.IsFired := False
          else
            vMainCtrlPanel.Starboard.IsFired := False;
          vMainCtrlPanel.btnFire.Down := vMainCtrlPanel.CurTorp.IsFired;
          vMainCtrlPanel.SetUpdownImage(vMainCtrlPanel.btnFire);
        end;
      end;
    end;
  end;


end;

procedure TTorpedoInterface.WireBreakHomming(tube: TTube);
var
  i     : Byte;
  s     : String;
  mShip : Integer;
  tR    :TTorpedoTrack;
  aRec  : TRecSetTorpedoSUT;
begin
  inherited;

  if GetTorp_fromTube(tube,i,tR) then
  begin
    if tR.Launched and tR.Enabled then
    begin
      if tR.isDetectTarget then
      begin
        tR.IsHoaming  := True;
        tR.TempSpeed  := tR.Speed;
        tR.TempSpeedType := tR.SpeedType;
        tR.SpeedType  := stHigh;
        aRec.OrderID  := __ORD_TORPEDOSUT_HOMING;
        aRec.mPredm   := Word(tR.PredMod);
      end
      else
      begin
        aRec.OrderID  := __ORD_TORPEDOSUT_TARGETSEARCHPROGRAM;
        aRec.mPredm   := Word(mTargetSearchProgram);
        tR.TargetID   := 0;
      end;

      if not TOCOSSim then
      begin
        s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
        TryStrToInt(s,mShip);

        aRec.ShipID         := mShip;
        aRec.mT_ID          := tR.TargetID;
        aRec.mMissileID     := 1;
        aRec.mMissileNumber := 1;
        aRec.mWeaponID      := C_DBID_TORPEDO_SUT;

        if (tR.Tube = ttPort) then
          aRec.mLauncherID := 1 else
        if (tR.Tube = ttStarBoard) then
          aRec.mLauncherID := 2;

        aRec.mTorpedoCourse       := tR.Course;
        aRec.mTorpedoSpeed        := tR.Speed;
        aRec.mTorpedoDepth        := abs(tR.Depth)* C_Feet_To_Meter;
        aRec.mTargetType          := tR.TargetType;
        aRec.mTorpedoSafeDistance := tR.SafeDistance * C_Yard_To_Meter;
        aRec.mTorpedoEnDis        := tr.EnablingDistance * C_Yard_To_Meter;

        netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
        {LOG}
        SendEvenTOCOS(12);
        {LOG}
      end;

      tempTorped := tR;
      torp_tocos.popObject(i);

      if not tempTorped.IsNoTarget then
        tempTorped.TargetTrack.AssByTorpedoVisible := False;

      tempTorped.IsNoTarget:= True;
      tempTorped.visTrackView(False);

      ClearStatus(tempTorped.Tube);
    end;
  end;
end;

procedure TTorpedoInterface.SetTorpTest(const v: Boolean);
begin
  TorpTest.Visible := v;
  if v then begin
    TorpTest.Left := 1;
    TorpTest.Top := 1;
    TorpTest.Width  := FMap.Width -2;
    TorpTest.Height := FMap.Height -2;
  end;
end;

procedure TTorpedoInterface.RecvTorpSUTStatus(rec: TRec_TorpStatus);
var
  j         : Byte;
  torpTube  : TTube;
  tR        : TTorpedoTrack;
begin
  inherited;
  if rec.ShipID = UniqueID_To_dbID(xSHIp.UniqueID)then begin
    if rec.mLauncherID = 1 then
     torpTube := ttPort
    else
     torpTube := ttStarBoard;

    if GetTorp_fromTube(torpTube,j,tR) then
    begin
      if rec.isFind = 1 then
      begin
        tR.isDetectTarget := True;
        tR.TargetID := rec.TargetID;
        SetStatus(0, 1, torpTube, ID_TargetDet);
      end
      else {belum pas}
      begin
        tR.isDetectTarget := False;
        tR.TargetID := rec.TargetID;
        SetStatus(0, 1, torpTube, ID_TurnAround);
        SetStatus(0, 3, torpTube, '');
      end;

    end;
  end;
end;


procedure TTorpedoInterface.SetTorpStatus(aDt : Double);
var
  i : Integer;
  l : TList;
  time: Double;
begin
  inherited;
      l := torp_tocos.GetList;

      for i:=0 to l.Count-1 do begin
        trackTorped := l[i];
        {-- RUNTIME -- }
        if trackTorped.Launched then begin
          time := trackTorped.RunTime - aDt * C_MilliSecondToMinute;
          trackTorped.RunTime := time;
        end;
        State(trackTorped);
      end;
      torp_tocos.ReturnList;

      {==  torpedo manual ==}
      if Assigned(torpManual) then begin
          {-- RUNTIME -- }
          State(torpManual);
      end;
end;

procedure TTorpedoInterface.State(torp :TTorpedoTrack);
var range, rTarget  :Double;
    runtimeTorp, depthTorp : string;
begin
    {-- DEPTH -- }
    if Assigned (torp) then begin
      try
        runtimeTorp := IntToStr(Round(torp.RunTime));
        depthTorp   := IntToStr(Round(abs(torp.Depth)));
      except
        runtimeTorp := '';
        depthTorp   := '';
      end;

      if ((abs(torp.Depth) < torp.Uplim) or (abs(torp.Depth) > torp.Lolim)) and
         (torp.LolimMode = lmOn) and (torp.Launched) then
      begin
        if torp.Tube = ttPort then
        begin
          if (flagPT mod 10) = 0 then
          begin
            flagPT := 1 ;
            SetStatus(1,0,torp.Tube, depthTorp);

            if (abs(torp.Depth) < torp.Uplim) then
              SetStatus(3,0,torp.Tube, 'UPL')
            else if (abs(torp.Depth) > torp.Lolim) then
              SetStatus(3,0,torp.Tube, 'LPL')
          end
          else
          begin
            flagPT := flagPT + 1;
            SetStatus(1,0,torp.Tube, '');
            SetStatus(3,0,torp.Tube, '');
          end;
        end else
        if torp.Tube = ttStarBoard then
        begin
          if (flagSB mod 10) = 0 then
          begin
            flagSB := 1 ;
            SetStatus(1,0,torp.Tube, depthTorp);

            if (abs(torp.Depth) < torp.Uplim) then
              SetStatus(3,0,torp.Tube, 'UPL')
            else if (abs(torp.Depth) > torp.Lolim) then
              SetStatus(3,0,torp.Tube, 'LPL')
          end
          else
          begin
            flagSB := flagSB + 1;
            SetStatus(1,0,torp.Tube, '');
            SetStatus(3,0,torp.Tube, '');
          end;
        end
      end
      else
      begin
        if torp.Tube = ttPort then
          flagPT := 1
        else if torp.Tube = ttStarBoard then
          flagSB := 1;

        SetStatus(1,0,torp.Tube, depthTorp);
        SetStatus(3,0,torp.Tube, '');
      end;

       //Prince
       {jk torpedo di shutdown atau tanpa target runtime disembunyikan}
       if torp.IsNoTarget or torp.IsnotActive_Torp then
        SetStatus(2,0,torp.Tube, '')
       else
        SetStatus(2,0,torp.Tube, runtimeTorp);

      if not torp.IsnotActive_Torp  and torp.Launched  then begin
        {-- sudah FIRE -- }
        if torp.Enabled then begin
          if not torp.IsNoTarget then
          begin
            rTarget := CalcRange(torp.PositionX,torp.PositionY, torp.TargetTrack.PositionX,torp.TargetTrack.PositionY)
                       * C_NauticalMiles_To_Yard;

            {Melewati target}
            if (rTarget > 300) and (not torp.isDetectTarget) then
              SetStatus(0, 1, torp.Tube, '');

            {Mencapai jarak ignition free +/- 1000 yard dari target}
            if (rTarget <= 1000) and (torp.IsHoaming) then
              SetStatus(0, 3, torp.Tube, ID_IgnitionFree);
          end;

          range := CalcRange(torp.LastSetX,torp.LastSetY, torp.PositionX,torp.PositionY)
                   * C_NauticalMiles_TO_Meter;

          {Mencapai jarak safedistance 150 s/d 300 meter}
          if (range >= (torp.SafeDistance * C_Yard_To_Meter)) and (range <= 300)then
          begin
            SetStatus(0, 2, torp.Tube, ID_SteeringAllowed);
            torp.isSafedistance := True;
          end
          else
            SetStatus(0, 2, torp.Tube, '');

          {Mencapai akhir baterai}
          if torp.BatteryDistance <= 0 then
            DeleteTorpedoSUTTrack(torp);

          {Mencapai kabel putus}
          if torp.WireDistance <= 0 then
            WireBreakHomming(torp.Tube);
        end;
      end;
    end
    else begin
      SetStatus(1,0,torp.Tube, '');
      SetStatus(2,0,torp.Tube,'');
    end;
end;


end.

