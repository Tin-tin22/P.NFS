unit uMainMM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, OleCtrls, MapXLib_TLB,
  uManageLoadDraw, uEventForm, uYakhont_Object, uTCPDatatype,
  AdvSmoothProgressBar;

type
  TfmMainMM = class(TForm)
    pnlMainMM: TPanel;
    pnlTop: TPanel;
    pnlLeftCenter: TPanel;
    pnlLeftBottom: TPanel;
    pnlRightTop: TPanel;
    pnlPLP: TPanel;
    pnlRightBottom: TPanel;
    GroupBox1: TGroupBox;
    btnRTP: TSpeedButton;
    btnPTP: TSpeedButton;
    btnLock: TSpeedButton;
    btnDate: TSpeedButton;
    btnInd: TSpeedButton;
    btnTD: TSpeedButton;
    Panel7: TPanel;
    btnCT: TSpeedButton;
    grpPLP: TGroupBox;
    lblTimeToPLP: TLabel;
    pnlMainPLP: TPanel;
    grbLeftTop: TGroupBox;
    grpLeftDown: TGroupBox;
    grpRightTop: TGroupBox;
    grpRightDown: TGroupBox;
    pnlAwrCwrEr: TPanel;
    btnAWR: TSpeedButton;
    btnCWR: TSpeedButton;
    btnER: TSpeedButton;
    Panel10: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    pnlAvailable: TPanel;
    pnlOperational: TPanel;
    pnlLaunched: TPanel;
    pnlPassed: TPanel;
    pnlDesignated: TPanel;
    pnlCancelled: TPanel;
    pnlPLP2: TPanel;
    pnlPLP4: TPanel;
    pnlPLP1: TPanel;
    pnlPLP3: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    GroupBox2: TGroupBox;
    Panel17: TPanel;
    Panel18: TPanel;
    pnlDate: TPanel;
    pnlTime: TPanel;
    pnlTimeOfRegime: TPanel;
    pnlRegime: TPanel;
    pnlTimeAge: TPanel;
    pnlSperryMK: TPanel;
    pnlSperryATT: TPanel;
    pnlSperryB: TPanel;
    pnlSperryC: TPanel;
    pnlFault: TPanel;
    pnlSC: TPanel;
    pnlTI2: TPanel;
    fMap: TMap;
    Panel32: TPanel;
    pnlRTP: TPanel;
    Panel34: TPanel;
    pnlRange: TPanel;
    pnlLongitudeShip: TPanel;
    pnlShipHeading: TPanel;
    pnlShipSpeed: TPanel;
    pnlShipPitch: TPanel;
    pnlShipRoll: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    Panel44: TPanel;
    Panel45: TPanel;
    pnlNoASM1: TPanel;
    pnlT1: TPanel;
    pnlTmax1: TPanel;
    pnltmaxs1: TPanel;
    pnlNoASM2: TPanel;
    pnlT2: TPanel;
    pnlTmax2: TPanel;
    pnltmaxs2: TPanel;
    pnlNoASM3: TPanel;
    pnlT3: TPanel;
    pnlTmax3: TPanel;
    pnltmaxs3: TPanel;
    pnlNoASM4: TPanel;
    pnlT4: TPanel;
    pnlTmax4: TPanel;
    pnltmaxs4: TPanel;
    Panel62: TPanel;
    Panel63: TPanel;
    pnlNow: TPanel;
    pnlNext: TPanel;
    btnTI: TSpeedButton;
    btnSD: TSpeedButton;
    btnDES: TSpeedButton;
    btnPLP: TSpeedButton;
    btnDOC: TSpeedButton;
    btnEXIT: TSpeedButton;
    pnlTI1: TPanel;
    imgRuler: TImage;
    Panel1: TPanel;
    pnlLeftBottomType: TPanel;
    pnlLeftBottomD: TPanel;
    pnlLeftBottomDd: TPanel;
    pnlLeftBottomPx: TPanel;
    pnlLeftBottomTrajectoryType: TPanel;
    pnlLeftBottomB: TPanel;
    pnlLeftBottomDj: TPanel;
    pnlLeftBottomDsgh: TPanel;
    pnlLeftBottomPz: TPanel;
    timerStart: TTimer;
    Panel2: TPanel;
    lblType: TLabel;
    lblD: TLabel;
    lblDd: TLabel;
    lblPx: TLabel;
    lblB: TLabel;
    lblDj: TLabel;
    lblDsgh: TLabel;
    lblPz: TLabel;
    lblTrajectoryType: TLabel;
    pnlLatitudeShip: TPanel;
    lblLatitude: TLabel;
    lblLongitude: TLabel;
    lblShipHeading: TLabel;
    lblShipSpeed: TLabel;
    lblShipPitch: TLabel;
    lblShipRoll: TLabel;
    btnFire: TButton;
    btnLog: TButton;
    pnl1: TPanel;
    Label1: TLabel;
    progBarPLP: TAdvSmoothProgressBar;
    progBarPrePLP: TAdvSmoothProgressBar;
    btnFireNow: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fMapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Cardinal; const RectFull,
      RectInvalid: IDispatch);
    procedure btnEXITClick(Sender: TObject);
    procedure btnTIClick(Sender: TObject);
    procedure timerStartTimer(Sender: TObject);
    procedure btnSDClick(Sender: TObject);
    procedure btnDESClick(Sender: TObject);
    procedure btnPLPClick(Sender: TObject);
    procedure btnCWRClick(Sender: TObject);
    procedure btnAWRClick(Sender: TObject);
    procedure btnFireClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnLockClick(Sender: TObject);
    procedure btnERClick(Sender: TObject);
    procedure btnDOCClick(Sender: TObject);
    procedure btnTDClick(Sender: TObject);
    procedure fMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRTPClick(Sender: TObject);
    procedure btnPTPClick(Sender: TObject);
    procedure btnDateClick(Sender: TObject);
    procedure btnIndClick(Sender: TObject);
    procedure btnCTClick(Sender: TObject);
    procedure btnFireNowClick(Sender: TObject);
    procedure grpPLPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);



  const
    default_T = 5.19;
    value_TMax = 55.42;
    value_TmaxS = 1554.16;

    { cancel }
    C_TI      = 1;
    C_SD      = 2;
    C_DES     = 3;
    C_PLP     = 4;
    C_DOC     = 5;
    C_EXIT    = 6;
    C_AWR     = 7;
    C_CWR     = 8;
    C_ER      = 9;
    C_RTP     = 10;
    C_PTP     = 11;
    C_LOCK    = 12;
    C_DATE    = 13;
    C_IND     = 14;
    C_TD      = 15;
    C_CT      = 16;
  private
    { Private declarations }
  public
    { Public declarations }
    FCanvas  : TCanvas;
    ManageLoadDraw : TManageLoadDraw;

    DataYakhont : TYakhont_Object;

    { CTType = CT 1 or CT 2 }
    CTType : Integer;

    C__isSendKey : Boolean;
    C__isReady   : Boolean;
    C__isSC_On   : Boolean;

    { for managing timer }
    StartTime, StopTime, StartAgingTime: TDateTime;
    thisDay, thisHour, thisMinute : integer;
	  thisSecond, tempSecond  : double;
    tempCounter, counterTemp: Integer;

    isTI, isSD, isDES, isPLP, isDOC, isExit, tempPLP : Boolean;

    isAWR, isCWR, isER : Boolean;

    checkCancelAll : Boolean;

    {Set nilai suhu T}
    value_T1, value_T2,value_T3,value_T4,
    value_TMax1, value_TMax2, value_TMax3, value_TMax4,
    value_TMax_S1, value_TMax_S2, value_TMax_S3, value_TMax_S4 : Double;

    { SD = showing result of TI and updating periodically on left panel }
    SD : Boolean;

    countAvailable, countOprational, countDesignated,
    countCancelled, countLaunched, countPassed : Integer;

    {untuk testing tanpa PLP Time}
    FiringNow : Boolean;

    { automatic input from instruktur }
    { own ship - from instructor }
    temp_heading, temp_speed : Single;
    temp_pitch, temp_roll    : single;
    temp_PosX, temp_PosY     : Single;    // result of convertion by map to screen

    { all target ship - convert map to screen }
    target_PosX, target_PosY   : Single;

    { assigned target ship - convert map to screen }
    cTarget_PosX, cTarget_PosY : Single;

    { seeker on ship - convert map to screen }
    seeker_PosX, seeker_PosY   : Single;

    { manual input }
    miTarget_PosX, miTarget_PosY : Single;
    miSeeker_PosX, miSeeker_PosY : Single;

    readyToLaunch : array[1..4] of Integer;

    { for TI, SD, DES, PLP, DOC button }
    { 0 for isCompletelyInsert manual input ? }
    checkerButtonProcedure : array[1..5] of Integer;

    { for right click -> cancel }
    fCancel : Integer;

    {cek request data instruktur}
    checkRequestInstructure : Boolean;

    function SetTime(StartTime: double): string;

    procedure adjusmentScale;
    procedure setLauncher;
    procedure rightClick;
  end;

var
  fmMainMM: TfmMainMM;

implementation

uses
  uRegimesOfWork, uYakhontManager, uLogTCP, uBaseConstan, uBaseDataType, uBaseFunction,
  uNetral, uAppointmentASM, uCirculationASM, uHeating;

{$R *.dfm}

procedure TfmMainMM.btnFireClick(Sender: TObject);
var
  Rec_DataYakhont : TRecData_YAkhont;
begin
  Rec_DataYakhont.ShipID          := YakhontManager.ShipID;
  Rec_DataYakhont.mLauncherID     := 1;
  Rec_DataYakhont.mMissileID      := 1;
  Rec_DataYakhont.mMissileNumber  := 1{0};
  Rec_DataYakhont.mWeaponID       := C_DBID_YAKHONT;
  Rec_DataYakhont.OrderID         := 1;
  Rec_DataYakhont.mTargetBearing  := 50;
  Rec_DataYakhont.mTargetRange    := 90;

  YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @Rec_DataYakhont);
end;

procedure TfmMainMM.btnFireNowClick(Sender: TObject);
begin
  FiringNow := True;
end;

procedure TfmMainMM.btnTIClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(9, 0, 0, 0);
  fCancel := C_TI;
  EventForm.eventBtnTIOnClick;
end;

procedure TfmMainMM.btnSDClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(10, 0, 0, 0);
  if checkerButtonProcedure[1] = 1 then
  begin
    fCancel := C_SD;
    checkerButtonProcedure[2] := 1;
    EventForm.eventBtnSDOnClick;
    SD := true;
  end;
end;

procedure TfmMainMM.btnDESClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(11, 0, 0, 0);
  if checkerButtonProcedure[2] = 1 then
  begin
    fCancel := C_DES;
    checkerButtonProcedure[3] := 1;
    EventForm.eventBtnDESOnClick;
  end;
end;

procedure TfmMainMM.btnPLPClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(12, 0, 0, 0);
  if checkerButtonProcedure[3] = 1 then
  begin
    fCancel := C_PLP;
    checkerButtonProcedure[4] := 1;
    EventForm.eventBtnPLPOnClick;

  end;

end;

procedure TfmMainMM.btnDOCClick(Sender: TObject);
begin
  if checkerButtonProcedure[4] = 1 then
  begin
    fCancel := C_DOC;
    checkerButtonProcedure[5] := 1;
    EventForm.eventBtnDocClick;
  end;
end;

procedure TfmMainMM.btnEXITClick(Sender: TObject);
begin
  YakhontManager.EventOnSendingLog(9, 0, 0, 0);
  fCancel := C_EXIT;
  //tempSecond := 0;
  //counterTemp := 0;
  EventForm.eventBtnExitClick;
end;

procedure TfmMainMM.btnAWRClick(Sender: TObject);
begin
//  if not isCWR then
//  begin
    isAWR   := True;
    fCancel := C_AWR;
    EventForm.eventBtnAWRClick;
//    EventForm.eventBtnAWRClick;
//  end;
end;

procedure TfmMainMM.btnCWRClick(Sender: TObject);
begin
//  if not isAWR then
//  begin
    isCWR   := True;
    fCancel := C_CWR;
    EventForm.eventBtnCWRClick;
//  end;
end;

procedure TfmMainMM.btnERClick(Sender: TObject);
begin
  isER    := True;
  fCancel := C_ER;
  EventForm.eventBtnEROnClick;
end;

procedure TfmMainMM.btnLogClick(Sender: TObject);
begin
  frmLogTCP.Show;
end;

procedure TfmMainMM.btnRTPClick(Sender: TObject);
begin
  fCancel := C_RTP;
  EventForm.eventRTP;
end;

procedure TfmMainMM.btnPTPClick(Sender: TObject);
begin
  fCancel := C_PTP;
  EventForm.eventPTP;
end;

procedure TfmMainMM.btnLockClick(Sender: TObject);
begin
  fCancel := C_LOCK;
  EventForm.eventBtnLockClick;
end;

procedure TfmMainMM.btnDateClick(Sender: TObject);
begin
  fCancel := C_DATE;
end;

procedure TfmMainMM.btnIndClick(Sender: TObject);
begin
  fCancel := C_IND;
end;

procedure TfmMainMM.btnTDClick(Sender: TObject);
begin
  fCancel := C_TD;
  EventForm.eventBtnTDClick;
end;

procedure TfmMainMM.btnCTClick(Sender: TObject);
begin
  fCancel := C_CT;
end;

procedure TfmMainMM.fMapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
  hOutputDC, hAttributeDC: Cardinal; const RectFull, RectInvalid: IDispatch);
  var
    point_rad, point_ctr : t2DPoint;
  X, Y : Single;
  Xcent, Ycent : Single;
  intX, intY : Integer;

  example : TPoint;
begin
  if not Assigned(FCanvas) then
    Exit;
  FCanvas.Handle := hOutputDC;

  if isSD or isDES or isPLP or checkCancelAll {CTType = 2} then
  begin
    EventForm.drawCompass(FCanvas);
    EventForm.drawTarget(FCanvas);
  end;
end;

procedure TfmMainMM.fMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    rightClick;
end;

procedure TfmMainMM.FormCreate(Sender: TObject);
begin
  DataYakhont := TYakhont_Object.Create;

  fMap.DoubleBuffered := true;

  FCanvas := TCanvas.Create;
  ManageLoadDraw := TManageLoadDraw.Create;
  EventForm := TEventForm.Create;

  progBarPLP.Minimum := 0;
  progBarPLP.Maximum := 120;
  progBarPrePLP.Minimum := 0;
  progBarPrePLP.Maximum := 1000;

  C__isSendKey := False;
end;

procedure TfmMainMM.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if GetKeyState(VK_F1) < 0 then
  begin
    EventForm.eventBtnAWRClick;
  end;

  if GetKeyState(VK_F2) < 0 then
  begin
    EventForm.eventBtnCWRClick;
  end;

  if GetKeyState(VK_F3) < 0 then
  begin

  end;

  if GetKeyState(VK_F4) < 0 then
  begin

  end;

  if GetKeyState(VK_F5) < 0 then
  begin

  end;

  if GetKeyState(VK_F6) < 0 then
  begin
    EventForm.eventBtnLockClick;
  end;

  if GetKeyState(VK_F7) < 0 then
  begin

  end;

  if GetKeyState(VK_F8) < 0 then
  begin

  end;

  if GetKeyState(VK_F9) < 0 then
  begin

  end;

  if GetKeyState(VK_F10) < 0 then
  begin
    EventForm.eventBtnEROnClick;
  end;

  if GetKeyState(VK_F11) < 0 then
  begin

  end;

  if GetKeyState(VK_F12) < 0 then
  begin

  end;

  if GetKeyState(VK_CONTROL) < 0 then
  begin
    case Msg.CharCode of
      VK_SHIFT :
      begin
        btnFire.Visible := true;
        btnLog.Visible  := true;
      end;

    end;
  end;

  if GetKeyState(VK_CONTROL) < 0 then
  begin
    case Msg.CharCode of
      VK_SPACE :
      begin
        btnFire.Visible := False;
        btnLog.Visible  := False;
      end;

    end;
  end;
end;

procedure TfmMainMM.FormShow(Sender: TObject);
begin
   netral.normalization;
   checkRequestInstructure:=True;

   EventForm.setproperties;

   { if MM then set something }
   if CTType = 0 then
     setLauncher;

   adjusmentScale;
end;



procedure TfmMainMM.grpPLPMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (Button = mbRight) and (ssCtrl in Shift) and (ssAlt in Shift) then
begin
  btnFireNow.Visible := True;
end;

end;

procedure TfmMainMM.setLauncher;
var
  I : Integer;
  qCancel, qOprational, qLaunched, qPassed : Integer;
begin
  with fmMain do
  begin
    if _stateLauncher1 then
    begin
       readyToLaunch[1] := 0;
       pnlPLP1.Color := clRed;
       YakhontManager.Missile1.isReady := False;
       frmAppointmentASM.colorMissile1.Color := clRed;
       frmCirculationASM.colorMissile1.Color := clRed;
       pnlNoASM1.Caption := '';
       pnlT1.Caption     := '';
       pnlTmax1.Caption  := '';
       pnltmaxs1.Caption := '';
    end;
    if _stateLauncher2 then
    begin
       readyToLaunch[2] := 0;
       pnlPLP2.Color := clRed;
       YakhontManager.Missile2.isReady := False;
       frmAppointmentASM.colorMissile2.Color := clRed;
       frmCirculationASM.colorMissile2.Color := clRed;
       pnlNoASM2.Caption := '';
       pnlT2.Caption     := '';
       pnlTmax2.Caption  := '';
       pnltmaxs2.Caption := '';
    end;
    if _stateLauncher3 then
    begin
       readyToLaunch[3] := 0;
       pnlPLP3.Color := clRed;
       YakhontManager.Missile3.isReady := False;
       frmAppointmentASM.colorMissile3.Color := clRed;
       frmCirculationASM.colorMissile3.Color := clRed;
       pnlNoASM3.Caption := '';
       pnlT3.Caption     := '';
       pnlTmax3.Caption  := '';
       pnltmaxs3.Caption := '';
    end;
    if _stateLauncher4 then
    begin
       readyToLaunch[4] := 0;
       pnlPLP4.Color := clRed;
       YakhontManager.Missile4.isReady := False;
       frmAppointmentASM.colorMissile4.Color := clRed;
       frmCirculationASM.colorMissile4.Color := clRed;
       pnlNoASM4.Caption := '';
       pnlT4.Caption     := '';
       pnlTmax4.Caption  := '';
       pnltmaxs4.Caption := '';
    end;

    if _stateKR231 then
    begin
       for I := 1 to 4 do
         readyToLaunch[I] := 0;

       pnlPLP1.Color := clRed;
       YakhontManager.Missile1.isReady := False;
       frmAppointmentASM.colorMissile1.Color := clRed;
       frmCirculationASM.colorMissile1.Color := clRed;
       pnlNoASM1.Caption := '';
       pnlT1.Caption     := '';
       pnlTmax1.Caption  := '';
       pnltmaxs1.Caption := '';

       pnlPLP2.Color := clRed;
       YakhontManager.Missile2.isReady := False;
       frmAppointmentASM.colorMissile2.Color := clRed;
       frmCirculationASM.colorMissile2.Color := clRed;
       pnlNoASM2.Caption := '';
       pnlT2.Caption     := '';
       pnlTmax2.Caption  := '';
       pnltmaxs2.Caption := '';

       pnlPLP3.Color := clRed;
       YakhontManager.Missile3.isReady := False;
       frmAppointmentASM.colorMissile3.Color := clRed;
       frmCirculationASM.colorMissile3.Color := clRed;
       pnlNoASM3.Caption := '';
       pnlT3.Caption     := '';
       pnlTmax3.Caption  := '';
       pnltmaxs3.Caption := '';

       pnlPLP4.Color := clRed;
       YakhontManager.Missile4.isReady := False;
       frmAppointmentASM.colorMissile4.Color := clRed;
       frmCirculationASM.colorMissile4.Color := clRed;
       pnlNoASM4.Caption := '';
       pnlT4.Caption     := '';
       pnlTmax4.Caption  := '';
       pnltmaxs4.Caption := '';
    end;
  end;

  //sum := 0;
  for I := 1 to 4 do
   begin
     if fmMainMM.readyToLaunch[I] = 0 then
        qCancel     := qCancel + 1;

     if fmMainMM.readyToLaunch[I] = 1 then
        qOprational := qOprational + 1;

     if fmMainMM.readyToLaunch[I] = 2 then
        qLaunched   := qLaunched + 1;

     if fmMainMM.readyToLaunch[I] = 3 then
        qPassed     := qPassed + 1;
   end;

  countAvailable         := qCancel + qOprational;
  countCancelled         := qCancel;
  countOprational        := qOprational;
  countLaunched          := qLaunched;
  countPassed            := qPassed;

  pnlAvailable.Caption   := IntToStr(countAvailable);
  pnlOperational.Caption := IntToStr(countOprational);
  pnlDesignated.Caption  := IntToStr(countDesignated);
  pnlCancelled.Caption   := IntToStr(countCancelled);
  pnlLaunched.Caption    := IntToStr(countLaunched);
  pnlPassed.Caption      := IntToStr(countPassed);
end;

procedure TfmMainMM.timerStartTimer(Sender: TObject);
var
	CTime: TDateTime;
	ETime, AgingTime: double;
  test : Double;
  rec: TRecCMD_Yakhont;
begin
   pnlDate.Caption := FormatDateTime('dd MMMM yyyy', Now);
   pnlTime.Caption := FormatDateTime('hh:mm:ss', Now);

   CTime := now;
   ETime := CTime - StartTime;

   pnlTimeOfRegime.caption := setTime(ETime);

   if YakhontManager.isTimeAgeStart then
   begin
     AgingTime := CTime - StartAgingTime + YakhontManager.TimeAgeCount/86400;
     pnlTimeAge.Caption := SetTime(AgingTime);
   end;


   if fmMain.MainMode = 1 then
   begin
     if tempPLP then
     begin
//      progBarPrePLP.Visible:=True;
//      progBarPLP.Visible:=False;
        if tempSecond = 0 then
         begin
          progBarPrePLP.Position := 0;
          counterTemp := 0;
         end;

         if tempSecond > 0 then
         begin
          inc(counterTemp);
          progBarPrePLP.Position  := counterTemp;
         end;

//         if progBarPrePLP.Position = 240 then
//         begin
//           btnER.Enabled := False;
//           btnAWR.Enabled := False;
//           btnCWR.Enabled := False;
//           btnTI.Enabled  := False;
//           btnSD.Enabled  := False;
//           btnDES.Enabled := False;
//           btnPLP.Enabled := False;
//           btnDOC.Enabled := False;
//           btnEXIT.Enabled:= True;
//         end;
     end;

     if isPLP then
     begin
        if thisSecond = 0 then
        begin
          progBarPLP.Position := 0;
          tempCounter := 0;
        end;

        if thisSecond > 0 then
        begin

          inc(tempCounter);
          progBarPLP.Position  := tempCounter;

          if C__isSC_On then
          begin
            rec.cmd := CMD_Yakhont_ReadyToFire;
            YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @rec, nil);
          end;
        end;

//        if (FiringNow = True) then progBarPLP.Position := 120; // Untuk Testing tanpa PLP Time

        if progBarPLP.Position = 120 then
        begin
          if not C__isSendKey then
          begin
            C__isSendKey := True;

            pnlNow.Caption  := '';
            pnlNext.Caption := 'ENG SC';

            { enable to activate SC (start circuit) }
            rec.cmd := CMD_Yakhont_OpenKey;

            YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @rec, nil);

            YakhontManager.PLPState := OnReadyFire;

            FiringNow := False;
          end;
        end;
     end;


   end;


   if fmMain.MainMode = 4 then
   begin
     if (CTType = 1) OR (CTType = 2) then
     begin
       if thisSecond > 2 then
       begin

       end;

       if thisSecond = 3 then  begin
          progBarPLP.Position := 0;
          tempCounter := 0;
       end;

       if thisSecond > 3 then
       begin
          inc(tempCounter);
          progBarPLP.Position  := tempCounter;
       end;

       if thisSecond > 6 then
       begin
         pnlPLP1.Color := clLime;
         pnlPLP2.Color := clLime;
         pnlPLP3.Color := clLime;
         pnlPLP4.Color := clLime;
         //=============================//
         pnlPLP1.Font.Color := clBlack;
         pnlPLP2.Font.Color := clBlack;
         pnlPLP3.Font.Color := clBlack;
         pnlPLP4.Font.Color := clBlack;

         pnlNoASM1.Color := clGreen;
         pnlNoASM2.Color := clGreen;
         pnlNoASM3.Color := clGreen;
         pnlNoASM4.Color := clGreen;
         //=============================//
//         pnlNoASM1.Caption := '1';
//         pnlNoASM2.Caption := '2';
//         pnlNoASM3.Caption := '3';
//         pnlNoASM4.Caption := '4';

         btnCWR.Font.Color := clBlack;
         btnAWR.Font.Color := clBlack;

         if (Round(thisSecond) mod 10 = 0) then
         begin
           pnlT1.Caption := '5.16';
           pnlT2.Caption := '5.16';
           pnlT3.Caption := '5.16';
           pnlT4.Caption := '5.16';
         end
         else
         begin
           pnlT1.Caption := '5.18';
           pnlT2.Caption := '5.18';
           pnlT3.Caption := '5.18';
           pnlT4.Caption := '5.18';
         end;
       end;
       if thisSecond > 8 then
       begin
         pnlNow.Caption  := 'SACS ready';
         pnlNext.Caption := 'Selection of TI';

         btnTI.Font.Color   := clBlack;
         btnEXIT.Font.Color := clWhite;
       end;

     end;
   end;

   if fmMain.MainMode = 5 then
   begin
     if tempPLP then
       begin
        progBarPrePLP.Visible:=True;
        progBarPLP.Visible:=False;
          if tempSecond = 0 then
           begin
            progBarPrePLP.Position := 0;
            counterTemp := 0;
           end;

           if tempSecond > 0 then
           begin
            inc(counterTemp);
            progBarPrePLP.Position  := counterTemp;
           end;

           if progBarPrePLP.Position = 30 then
           begin
            frmHeating.Close;
           end;
       end;
   end;
end;

procedure TfmMainMM.adjusmentScale;
var
  scX1, scY1, scX2, scY2 : Single;
  mpX1, mpY1, mpX2, mpY2 : Double;
  s : Double;
  scale : Double;

 x_rad, y_rad : Single;
 Long_rad, Lat_rad : Double;
// x_sc_rad, y_sc_rad : Integer;

 x_cent, y_cent : Single;
 long_cent, lat_cent : Double;
 dist_rad, dist_map, zoom_const : Double;

 point_rad, point_ctr : t2DPoint;
begin
  { default range yakhont <= 300 km }
//  scX1 := fMap.Left + 10;      {tambah 10}
//  scY1 := fMap.Top + 10;
//
//  scX2 := fMap.Left + fMap.Width - 10; {kurang 10}
//  scY2 := fMap.Top + fMap.Height - 10;
//
//  fMap.ConvertCoord(scX1, scY1, mpX1, mpY1, miScreenToMap);
//  fMap.ConvertCoord(scX2, scY2, mpX2, mpY2, miScreenToMap);
//
//  s := 300 {kilometers} * C_KiloMeter_To_NauticalMiles;
//  scale := YakhontManager.Calc_Zoom(fMap, mpX1, mpY1, mpX2, mpY2, s);
//
//  fMap.ZoomTo(fMap.Zoom/scale, fMap.CenterX, fMap.CenterY);

  x_cent := Round(fMap.Width/2);
  y_cent := Round(fMap.Height/2);

  //longlat center of map
  fMap.ConvertCoord(x_cent, y_cent, long_cent, lat_cent, miScreenToMap);

  x_rad := x_cent;
  y_rad := y_cent - 340;

  //longlat radius from screen
  fMap.ConvertCoord(x_rad, y_rad, Long_rad, Lat_rad, miScreenToMap);

  //longlat radius from map
  point_ctr.X := long_cent;
  point_ctr.Y := lat_cent;
  point_rad   := CalcPositionAhead(point_ctr, 300 * C_KiloMeter_To_NauticalMiles, 90);

  dist_rad    := Lat_rad - lat_cent;
  dist_map    := point_rad.Y - lat_cent;
  zoom_const  := dist_rad / dist_map;

  fMap.ZoomTo(fMap.Zoom/zoom_const, point_ctr.X, point_ctr.Y);
end;

procedure TfmMainMM.rightClick;
begin
  if fCancel = C_TI then
  begin
    btnTI.Enabled := True;
  end;

  if fCancel = C_SD then
  begin
    btnSD.Enabled := True;
    isSD          := false;
  end;

  if fCancel = C_DES then
  begin
    btnDES.Enabled := True;
  end;

  if fCancel = C_PLP then
  begin

  end;

  if fCancel = C_DOC then
  begin

  end;

  if fCancel = C_EXIT then
  begin

  end;

  if fCancel = C_AWR then
  begin

  end;

  if fCancel = C_CWR then
  begin

  end;

  if fCancel = C_ER then
  begin

  end;

  if fCancel = C_RTP then
  begin

  end;

  if fCancel = C_PTP then
  begin

  end;

  if fCancel = C_LOCK then
  begin

  end;

  if fCancel = C_DATE then
  begin

  end;

  if fCancel = C_IND then
  begin

  end;

  if fCancel = C_TD then
  begin

  end;

  if fCancel = C_CT then
  begin

  end;
end;

function TfmMainMM.SetTime(StartTime: double): string;
begin
	If int(StartTime) > 0 then
	  thisDay := 0
  else
    thisHour := Trunc(StartTime);

	StartTime := Frac(StartTime) * 24; // untuk jam
	thisHour := Trunc(StartTime);

	StartTime := frac(StartTime) * 60; // untuk Menit
	thisMinute := Trunc(StartTime);

	thisSecond := frac(StartTime) * 60; // untuk detik
  tempSecond := Frac(StartTime) * 60;
  Result := '0' + IntToStr(thisHour) + ' : ' + '0' + IntToStr(thisMinute) + ' : ' + 	FloatToStrF(thisSecond, ffFixed,15,0);
end;

end.
