unit uYakhontManager;

interface

uses
  Classes, uTCPClient, uTCPServer, overbyteicsWSocketS, uTestShip, uTCPDatatype, uSimulationManager,
  uYakhont_Object, uData, MapXLib_TLB, ExtCtrls, overbyteicsWSocket, Math;

type
  TPLPState = (OnIdle, OnReadyFire);

  TYakhontManager = class(TSimulationManager)

  private
  public
    /// <author>aldy s</author>
    /// <summary>
    /// Untuk koneksi ke Instruktur
    /// </summary>
    NetComm,
    TCPClient : TTCPClient;
    LogMemo   : TStrings;
    ServerIp  : string;
    ServerPort: string;

    ShouldConnect : boolean;

    MissileHaveLaunch : Integer;
    MissileLaunch : array [0..3] of Boolean;
    LaunchInterval : Integer;
    TimerLaunch : TTimer;

    /// <summary>
    /// Untuk koneksi local ke Archos
    /// </summary>
    NetLocalCommServer : TTCPServer;

    StandAloneMode   : Boolean;
    pCurrentScenID   : integer;

    pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
    pShipName, pClassName : string;
    pShipID, pClassID : Integer;

    //Ship
    /// <author>aldy</author>
    xShip       : TXShip;    //posisi kapal
    ShipID, ShipClassID : integer;
    ShipName, ShipClassName : string;

    { added by farah }
    Missile1    : TYakhont_Object;
    Missile2    : TYakhont_Object;
    Missile3    : TYakhont_Object;
    Missile4    : TYakhont_Object;

    distance   : Double;           { in kilometer }
    bearing    : Double;           { in compass }
    targetType : Integer;

    data_Path : string;

    shipTarget1, shipTarget2 : Integer;
    tempAssignTarget : Integer;

    accumulation : Integer;

    { if distance > 19 km }
    isDistMoreThan19 : Boolean;

    { if Target In Range}
    isTargetInRange : Boolean;

    {Time Age}
    isTimeAgeStart : Boolean;
    TimeAgeCount : Double;

    {OFFSET MAP}
    mapOffsetX, mapOffsetY : Double;

    {Setting Monitor}
    idMainFormA1, idMainFormA2, idBlankScreen, idLoadingScreen,
    idMain, idMainMM, idCertificateData, idCirculationASM,
    idCRData, idLock, idManualInput, idSelectionTI, idTargetDest,
    idEmergencyRelease, idTest, idDoc : Integer;

    ConnectInterval : Integer;
    timerConnect    : TTimer;

    UpdateInterval  : Integer;
    timerToUpdate   : TTimer;

    tmrConnectToBridge: TTimer;

    PLPState : TPLPState;

    constructor Create;
    destructor Destroy;

    procedure BeginSimulation;
    procedure EndSimulation;
    procedure CreateObject;
    procedure SetLayOutForm;

    procedure Initialize;
    procedure Net_Connect; //iq
    procedure Net_Disconnect;

    procedure OnTimerLaunch  (sender : TObject);
    procedure OnTimerConnect (sender : TObject); //iqbal
    procedure OnTimerToUpdate(sender : TObject);

    procedure AddToMemoLog(const str: string);

    procedure EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure EventOnMainTimer(const dt: double); override;
    procedure EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
    procedure EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
    procedure EventOnReceiveTechnicalStatus(apRec: PAnsiChar; aSize: integer);
    procedure EventReceiveTarget(apRec: PAnsiChar; aSize: integer);

    // added by Iqbal ----------- sinkronisasi status misil dengan instruktur;
    procedure EventOnReceiveMissileStatus(apRec: PAnsiChar; aSize: Integer);

    //added by Iqbal ------------ send data untuk request data
    //procedure tmrConnectToBridgeTimer(sender : TObject);

    //added by Iqbal
    procedure OnTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);

    procedure EventOnReceivePLPState(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);

    procedure EventOnSendingLog(aEventID: Integer; aParam1, aParam2, aParam3: Double);


    function LoadScenarioFromIniFile(const fIni: string): integer;

    //added by aldy ------------- fungsi menentukan bearing baru dan distance baru;
    procedure PredictDistanceCourse(target : TRecTIVariant2; var Distance, Bearing: Double);
//    procedure PredictDistanceCourse(var Distance, Bearing: Double); overload;


    { added by farah }
    function Calc_Zoom(Map : TMap; onMapX1, onMapY1, onMapX2, onMapY2 : Double; shouldBeRange: Double): Double;

    procedure UpdatePnlLeftBottom;
    procedure UpdateDataTarget;

    //get Offset Peta
    procedure SetSceneOffSetFromID(const id: integer; var x, y: Double);
    procedure GetSceneOffSetFromPortID(const id: integer; var x, y: double);

    //Setting Form pada Monitor
    procedure LoadSettingForm(filepath : string);

  end;

var
  YakhontManager : TYakhontManager;

implementation

uses
  uBridgeSet, SysUtils, Forms, Windows, uMainMM, Graphics,
  uCertificateData, uCRData, uManualInput, uRegimesOfWork, uBaseSimulationObject,
  uLibClientObject, uBaseFunction, IniFiles, uBaseConstan, uFormUtil,
  uYakhont_A_1_MainForm, uYakhont_A_2_MainForm, uDataModule,
  uBaseDataType, uTrackFunction ,  uLoadingScreen, uEventForm, uCirculationASM,
  uLock, uSelectionTI, uTargetDestination, uEmergencyRelease, uBlankScreen,
  uDoc, uTest, uAppointmentASM, uAcknowledgement;

function dbID_to_MissileUniqueID(const shipid, tipeid, launcher, missileid : integer): string; overload;
  begin
    result := Format('%s%0.4d%0.2d%0.2d%0.2d',['MSL', shipID, tipeID, launcher, missileid]);
  end;

function dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                       MissileID, MissileNumber  : integer): string; overload;
begin
  result := Format('%s%0.4d%0.2d%0.2d%0.2d%0.2d',['MSL', ShipID, WeaponID, LauncherID,
                                                  MissileID, MissileNumber]);
end;

constructor TYakhontManager.Create;
begin
  inherited;
  NetComm := TTCPClient.Create;
  TCPClient := NetComm;

  xShip := TXShip.Create;
  xShip.PositionX := 118.5;
  xShip.PositionY := -9.2;

  Missile1 := TYakhont_Object.Create;
  Missile2 := TYakhont_Object.Create;
  Missile3 := TYakhont_Object.Create;
  Missile4 := TYakhont_Object.Create;

  shipTarget1 := 0;
  shipTarget2 := 0;

  NetLocalCommServer := TTCPServer.Create;

  TimerLaunch          := TTimer.Create(nil);
  TimerLaunch.Enabled  := False;
  TimerLaunch.Interval := 1000;
  TimerLaunch.OnTimer  := OnTimerlaunch;
  MissileHaveLaunch    := 0;

  isDistMoreThan19 := False;
  isTargetInRange := False;

  UpdateInterval  := 0;
  ConnectInterval := 0;

  accumulation := 0;

  PLPState := OnIdle;

  LoadSettingForm('..\bin\SettingYakhontToMonitor.ini');

end;

destructor TYakhontManager.Destroy;
begin
  NetComm.Free;

  NetLocalCommServer.Free;
end;

procedure TYakhontManager.OnTCPChangeState(Sender: TObject; OldState,  NewState: TSocketState);
begin
   if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
   tmrConnectToBridge.Enabled := True;
  end;
end;


procedure TYakhontManager.OnTimerConnect(sender : TObject);
var
  recSend : TRecData2DOrder;
begin
  ConnectInterval := ConnectInterval + 1;

  if ConnectInterval > 0 then
  begin
    if NetComm.State <> wsConnected then
    begin
     //req sync packet after connect
      Net_Connect;
    end
    else if NetComm.State = wsConnected then
    //else if fmMainMM.checkRequestInstructure = True then
    begin
      //req sync packet after connect
      recSend.orderID := _CM_REQ_SYNCPACKET;
      recSend.numValue := 0;
      recSend.strValue := '';
      recSend.strValue2 := '';
      recSend.strValue3 := '';
      recSend.ipConsole := '';
      NetComm.sendDataEx(REC_2D_ORDER, @recSend);
    end;
  end;
end;

procedure TYakhontManager.BeginSimulation;
var
  p : Integer;
begin
  //create Object2-nya
  CreateObject;
//  SetLayOutForm;
  TryStrToInt(pServer_Port, p);
  p := p + 1;
  //Register Packet-packet Net
  //------------------------------------------------------------ Local
  NetLocalCommServer.RegisterProcedure(REC_CMD_Yakhont, EventOnReceiveCommand, SizeOf(TRecCMD_Yakhont));
  NetLocalCommServer.RegisterProcedure(REC_COMMAND_YAKHONTPLP, EventOnReceivePLPState, SizeOf(TRec_Command_YakhontPLP));
  //-end

  NetLocalCommServer.Listen(IntToStr(p));   //server local Listen to client

  //Connect to bridge
  //tmrConnectToBridge.Enabled := True;
  //NetComm.Socket.OnChangeState := onTCPChangeState;

  //------------------------------------------------------------ To Instruktur
//  NetComm.RegisterProcedure(REC_POSITION , EventonReceiveDataPosition, SizeOf(TRecDataPosition));
  NetComm.RegisterProcedure(REC_3D_POSITION, EventonReceiveDataPosition, SizeOf(TRecData3DPosition));
  NetComm.RegisterProcedure(REC_STAT_ASSIGN_OBJECT, eventReceiveTarget, SizeOf(TRecObjectAssigned));
  NetComm.RegisterProcedure(REC_MISSILEPOS, EventonRecMissilePosAvailable, sizeof(TRecMissilePos));
  NetComm.RegisterProcedure(REC_DATA_Yakhont, nil, sizeof(TRecData_Yakhont));
  NetComm.RegisterProcedure(REC_STAT_ORDER_CONSOLE, EventOnReceiveTechnicalStatus, SizeOf(TRecStatus_Console));

  //added by Iqbal --------- register ke instruktur
  NetComm.RegisterProcedure(REC_MISSILEPOS, EventOnReceiveMissileStatus, SizeOf(TRecMissilePos));
  NetComm.RegisterProcedure(REC_2D_ORDER, nil, SizeOf(TRecData2DOrder));

  //  NetComm.RegisterProcedure(REC_STATUS_YAKHONT, EventOnReceiveTechnicalStatus, SizeOf(TRecStatus_Console_Yakhont));
  NetComm.RegisterProcedure(REC_EVENT_LOG, nil, SizeOf(TRecEventLog));
  //-end

  Net_Connect;

  // Connect To Bridge
  //timerConnect.Enabled := True;
  //TCPClient.Socket.OnChangeState := onTCPChangeState;

  StartSimulation;
end;

procedure TYakhontManager.EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
var
aRec     : ^TRecCMD_Yakhont;
aRecSend : TRecCMD_Yakhont;
dtRec    : TRecData_Yakhont;

dis, brg : Double;
I, J     : Integer;
launchedNumb, designatedNumb : Integer;

begin
  aRec := @apRec^;

  fmMain.edit1.Text := IntToStr(aRec.cmd);

  case aRec.cmd of
    CMD_Yakhont_Cancel:
      begin

      end;
    CMD_Yakhont_Backlight:
      begin

      end;
    CMD_Yakhont_Key:
      begin
        designatedNumb := 0;

        fmMainMM.btnAWR.Enabled := False;
        fmMainMM.btnCWR.Enabled := False;
        fmMainMM.btnER.Enabled := False;

        if Missile1.isReady and (fmMainMM.pnlPLP1.Color = clLime) then begin
          fmMainMM.pnlPLP1.Color    := clAqua;
          fmMainMM.readyToLaunch[1] := 4;
        end;

        if Missile2.isReady and (fmMainMM.pnlPLP2.Color = clLime)then begin
          fmMainMM.pnlPLP2.Color    := clAqua;
          fmMainMM.readyToLaunch[2] := 4;
        end;

        if Missile3.isReady and (fmMainMM.pnlPLP3.Color = clLime) then begin
          fmMainMM.pnlPLP3.Color    := clAqua;
          fmMainMM.readyToLaunch[3] := 4;
        end;

        if Missile4.isReady and (fmMainMM.pnlPLP4.Color = clLime) then begin
          fmMainMM.pnlPLP4.Color    := clAqua;
          fmMainMM.readyToLaunch[4] := 4;
        end;

        if Missile1.isReady or Missile2.isReady or Missile3.isReady or Missile4.isReady then
        begin
          for I := 1 to 4 do
          begin
            if fmMainMM.readyToLaunch[I] = 4 then
            begin
               designatedNumb := designatedNumb + 1;
            end;

          end;
        end;

        fmMainMM.countDesignated       := designatedNumb;
        fmMainMM.pnlDesignated.Caption := IntToStr(fmMainMM.countDesignated);


      end;
    CMD_Yakhont_Start:
      begin
        if isTargetInRange or frmAcknowledgement.checkEmergencyButton then
        begin
          PLPState := OnIdle;

          MissileHaveLaunch := 0;

          for i := 0 to 3 do
            MissileLaunch[i] := false;

          if Missile1.isReady then MissileLaunch[0] := True;
          if Missile2.isReady then MissileLaunch[1] := True;
          if Missile3.isReady then MissileLaunch[2] := True;
          if Missile4.isReady then MissileLaunch[3] := True;

          if (not Missile1.isReady) and (not Missile2.isReady) and
             (not Missile3.isReady) and (not Missile4.isReady) then
          Exit;

          for i := 0 to 3 do
          begin
            if MissileLaunch[i] then
            begin
               MissileHaveLaunch := MissileHaveLaunch + 1;

               fmMainMM.countAvailable  := fmMainMM.countAvailable  - 1;
               fmMainMM.countOprational := fmMainMM.countOprational - 1;
               fmMainMM.countDesignated := fmMainMM.countDesignated - 1;

               fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
               fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
               fmMainMM.pnlDesignated.Caption  := IntToStr(fmMainMM.countDesignated);
               fmMainMM.pnlLaunched.Caption    := IntToStr(MissileHaveLaunch);

               MissileLaunch[i]     := false;

               dtRec.ShipID         := UniqueID_To_dbID(xShip.UniqueID);
               dtRec.mWeaponID      := C_DBID_YAKHONT;
               dtRec.mLauncherID    := i + 1;
               dtRec.mMissileID     := 1;
               dtRec.mMissileNumber := 1;

               if Missile1.isReady then
                 dtRec.mMissile1 := 1
               else
                 dtRec.mMissile1 := 0;

               if Missile2.isReady then
                 dtRec.mMissile2 := 1
               else
                 dtRec.mMissile2 := 0;

               if Missile3.isReady then
                 dtRec.mMissile3 := 1
               else
                 dtRec.mMissile3 := 0;

               if Missile4.isReady then
                 dtRec.mMissile4 := 1
               else
                 dtRec.mMissile4 := 0;

               case i of
                 0 :
                 begin
                   if frmManualInput.typeOfVariant = 1 then
                   begin
                      Missile1.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                      Missile1.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
                   end
                   else if frmManualInput.typeOfVariant = 2 then
                   begin
                      PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                      Missile1.Dis := dis;
                      Missile1.Brg := brg;
                   end;

                   dtRec.mTargetRange   := Missile1.Dis;
                   dtRec.mTargetBearing := Missile1.Brg;

                   dtRec.OrderID        := 1;

                   NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

                   fmMainMM.pnlPLP1.Color := clGray;
                 end;

                 1 :
                 begin
                   if frmManualInput.typeOfVariant = 1 then
                   begin
                      Missile2.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                      Missile2.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
                   end
                   else if frmManualInput.typeOfVariant = 2 then
                   begin
                      PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                      Missile2.Dis := dis;
                      Missile2.Brg := brg;
                   end;

                   dtRec.mTargetRange   := Missile2.Dis;
                   dtRec.mTargetBearing := Missile2.Brg;

                   dtRec.OrderID        := 1;

                   NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

                   fmMainMM.pnlPLP2.Color := clGray;
                 end;

                 2 :
                 begin
                   if frmManualInput.typeOfVariant = 1 then
                   begin
                      Missile3.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                      Missile3.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
                   end
                   else if frmManualInput.typeOfVariant = 2 then
                   begin
                      PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                      Missile3.Dis := dis;
                      Missile3.Brg := brg;
                   end;

                   dtRec.mTargetRange   := Missile3.Dis;
                   dtRec.mTargetBearing := Missile3.Brg;

                   dtRec.OrderID        := 1;

                   NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

                   fmMainMM.pnlPLP3.Color := clGray;
                 end;

                 3 :
                 begin
                   if frmManualInput.typeOfVariant = 1 then
                   begin
                      Missile4.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                      Missile4.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
                   end
                   else if frmManualInput.typeOfVariant = 2 then
                   begin
                      PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                      Missile4.Dis := dis;
                      Missile4.Brg := brg;
                   end;

                   dtRec.mTargetRange   := Missile4.Dis;
                   dtRec.mTargetBearing := Missile4.Brg;

                   dtRec.OrderID        := 1;

                   NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

                   fmMainMM.pnlPLP4.Color := clGray;
                 end;
               end;

               for j := 0 to 3 do
               begin
                 if MissileLaunch[j] then
                   TimerLaunch.Enabled := True;
               end;

               { apabila sudah penembakan, maka start circuit menjadi off }
               aRecSend.cmd := CMD_Yakhont_SCOff;
               YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @aRecSend, nil);
//
               Break;
            end;
          end;
        end
        else
        begin
          { apabila sudah penembakan, maka start circuit menjadi off }
               aRecSend.cmd := CMD_Yakhont_SCOff;
               YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @aRecSend, nil);
        end;

      end;
    CMD_Yakhont_SCOn:
      begin
        with fmMainMM do
        begin
          C__isSC_On := True;
          pnlSC.Caption   := 'On';
          pnlSC.Color     := clRed;
          pnlNow.Caption  := 'Salvo ready';
          pnlNext.Caption := 'Eng SC';

          { apabila salvo ready, boleh menekan tombol start pada archos }
          arec.cmd := CMD_Yakhont_ReadyToFire;
          YakhontManager.NetLocalCommServer.SendDataEx(REC_CMD_Yakhont, @arec, nil);
        end;
      end;
    CMD_Yakhont_SCOff:
      begin
        with fmMainMM do
        begin
          pnlSC.Caption := 'OFF';
          pnlSC.Color   := RGB(15, 69, 69);
        end;
      end;
  end;
end;

procedure TYakhontManager.EndSimulation;
begin
//  timerConnect.Enabled := False;
  YakhontManager.Free;
end;

procedure TYakhontManager.CreateObject;
begin
  NetComm.setLog(TStringList(LogMemo));

  // Create Form ---------------------------------------------------



  // Show Form -----------------------------------------------------

end;

procedure TYakhontManager.SetLayOutForm;
begin
  frmBlankScreen.Show;

  frmYakh_A_1_MainForm.Show;
  frmYakh_A_2_MainForm.Show;
  if not frmYakh_A_1_MainForm.timerA.Enabled then
   begin
     frmYakh_A_1_MainForm.timerA.Enabled := True;
     frmYakh_A_1_MainForm.setTime(0.0);
   end;
  YakhontManager.EventOnSendingLog(2, 0, 0, 0);
  case Screen.MonitorCount of
    1 :
      begin
        AlignFormToMonitor(idMainFormA1, apLeftTop, 0, 0, TForm(frmYakh_A_1_MainForm));
        AlignFormToMonitor(idMainFormA2, apRightTop, 0, 0, TForm(frmYakh_A_2_MainForm));
        AlignFormToMonitor(idBlankScreen, apRightTop{apCenterBottom}, 0, 0, TForm(frmBlankScreen));
        AlignFormToMonitor(idLoadingScreen, apCenterBottom, 0, 0, TForm(frmLoadingScreen));
        AlignFormToMonitor(idMain, apCenterBottom, 0, 0, TForm(fmMain));
        AlignFormToMonitor(idMainMM, {apRightTop}  apCenterBottom, 0, 0, TForm(fmMainMM));
        AlignFormToMonitor(idCertificateData, apCenter, 0, 0, TForm(frmCertificateData));
        AlignFormToMonitor(idCirculationASM, apNone, 0, 0, TForm(frmCirculationASM));
        AlignFormToMonitor(idCRData, apNone, 0, 0, TForm(frmCRData));
        AlignFormToMonitor(idLock, apNone, 0, 0, TForm(frmLock));
        AlignFormToMonitor(idManualInput, apNone, 0, 0, TForm(frmManualInput));
        AlignFormToMonitor(idSelectionTI, apNone, 0, 0, TForm(frmSelectionTI));
        AlignFormToMonitor(idTargetDest, apNone, 0, 0, TForm(frmTargetDest));
        AlignFormToMonitor(idEmergencyRelease, apNone, 0, 0, TForm(frmEmergencyRelease));

        AlignFormToMonitor(idTest, apRightTop {apCenterBottom}, 0, 0, TForm(frmTest));
        AlignFormToMonitor(idDoc, apRightTop {apCenterBottom}, 0, 0, TForm(frmDoc));
      end;
    2 :
      begin
        AlignFormToMonitor(idMainFormA1, apLeftTop, 0, 0, TForm(frmYakh_A_1_MainForm));
        AlignFormToMonitor(idMainFormA2, apRightTop, 0, 0, TForm(frmYakh_A_2_MainForm));
        AlignFormToMonitor(idBlankScreen, apCenterBottom, 0, 0, TForm(frmBlankScreen));
        AlignFormToMonitor(idLoadingScreen, apCenterBottom, 0, 0, TForm(frmLoadingScreen));
        AlignFormToMonitor(idMain, apCenterBottom, 0, 0, TForm(fmMain));
        AlignFormToMonitor(idMainMM, apCenterBottom, 0, 0, TForm(fmMainMM));
        AlignFormToMonitor(idCertificateData, apCenter, 0, 0, TForm(frmCertificateData));
        AlignFormToMonitor(idCirculationASM, apNone, 0, 0, TForm(frmCirculationASM));
        AlignFormToMonitor(idCRData, apNone, 0, 0, TForm(frmCRData));
        AlignFormToMonitor(idLock, apNone, 0, 0, TForm(frmLock));
        AlignFormToMonitor(idManualInput, apNone, 0, 0, TForm(frmManualInput));
        AlignFormToMonitor(idSelectionTI, apNone, 0, 0, TForm(frmSelectionTI));
        AlignFormToMonitor(idTargetDest, apNone, 0, 0, TForm(frmTargetDest));
        AlignFormToMonitor(idEmergencyRelease, apNone, 0, 0, TForm(frmEmergencyRelease));

        AlignFormToMonitor(idTest, apCenterBottom, 0, 0, TForm(frmTest));
        AlignFormToMonitor(idDoc, apCenterBottom, 0, 0, TForm(frmDoc));
      end;
    3:
      begin
        AlignFormToMonitor(idMainFormA1, apLeftTop, 0, 0, TForm(frmYakh_A_1_MainForm));
        AlignFormToMonitor(idMainFormA2, apRightTop, 0, 0, TForm(frmYakh_A_2_MainForm));
        AlignFormToMonitor(idBlankScreen, apCenterBottom, 0, 0, TForm(frmBlankScreen));
        AlignFormToMonitor(idLoadingScreen, apCenterBottom, 0, 0, TForm(frmLoadingScreen));
        AlignFormToMonitor(idMain, apCenterBottom, 0, 0, TForm(fmMain));
        AlignFormToMonitor(idMainMM, apCenterBottom, 0, 0, TForm(fmMainMM));
        AlignFormToMonitor(idCertificateData, apCenter, 0, 0, TForm(frmCertificateData));
        AlignFormToMonitor(idCirculationASM, apNone, 0, 0, TForm(frmCirculationASM));
        AlignFormToMonitor(idCRData, apNone, 0, 0, TForm(frmCRData));
        AlignFormToMonitor(idLock, apNone, 0, 0, TForm(frmLock));
        AlignFormToMonitor(idManualInput, apNone, 0, 0, TForm(frmManualInput));
        AlignFormToMonitor(idSelectionTI, apNone, 0, 0, TForm(frmSelectionTI));
        AlignFormToMonitor(idTargetDest, apNone, 0, 0, TForm(frmTargetDest));
        AlignFormToMonitor(idEmergencyRelease, apNone, 0, 0, TForm(frmEmergencyRelease));

        AlignFormToMonitor(idTest, apCenterBottom, 0, 0, TForm(frmTest));
        AlignFormToMonitor(idDoc, apCenterBottom, 0, 0, TForm(frmDoc));
      end;
    4,5 :
      begin
        AlignFormToMonitor(idMainFormA1, apLeftTop, 0, 0, TForm(frmYakh_A_1_MainForm));
        AlignFormToMonitor(idMainFormA2, apRightTop, 0, 0, TForm(frmYakh_A_2_MainForm));
        AlignFormToMonitor(idBlankScreen, apCenterBottom, 0, 0, TForm(frmBlankScreen));
        AlignFormToMonitor(idLoadingScreen, apCenterBottom, 0, 0, TForm(frmLoadingScreen));
        AlignFormToMonitor(idMain, apCenterBottom, 0, 0, TForm(fmMain));
        AlignFormToMonitor(idMainMM, apCenterBottom, 0, 0, TForm(fmMainMM));
        AlignFormToMonitor(idCertificateData, apCenter, 0, 0, TForm(frmCertificateData));
        AlignFormToMonitor(idCirculationASM, apNone, 0, 0, TForm(frmCirculationASM));
        AlignFormToMonitor(idCRData, apNone, 0, 0, TForm(frmCRData));
        AlignFormToMonitor(idLock, apNone, 0, 0, TForm(frmLock));
        AlignFormToMonitor(idManualInput, apNone, 0, 0, TForm(frmManualInput));
        AlignFormToMonitor(idSelectionTI, apNone, 0, 0, TForm(frmSelectionTI));
        AlignFormToMonitor(idTargetDest, apNone, 0, 0, TForm(frmTargetDest));
        AlignFormToMonitor(idEmergencyRelease, apNone, 0, 0, TForm(frmEmergencyRelease));

        AlignFormToMonitor(idTest, apCenterBottom, 0, 0, TForm(frmTest));
        AlignFormToMonitor(idDoc, apCenterBottom, 0, 0, TForm(frmDoc));
      end;
  end;
end;

procedure TYakhontManager.Initialize;
var
  n : integer ;
  fName : string;
begin
  n := ParamCount ;
  if (n = max_param) then
  begin
    StandAloneMode := false ;
  end
  else
  begin
    StandAloneMode := true;
  end;

  InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
      pDBServer, pDBProto, pDBName, pDBUser, pDBPass, pShipID, pCurrentScenID );

  FMap := fmMainMM.fMap;

  //set data_path
  data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
  fname     := data_Path + 'data\Scenario\TDCYakhont.ini';

  ShipID := pShipID;
  LoadScenarioFromIniFile(fname);
  xShip.UniqueID := dbID_to_UniqueID(ShipID);

  SetLayOutForm;
end;

procedure TYakhontManager.Net_Connect;
var
  recSend : TRecData2DOrder;
begin

    NetComm.Connect(pServer_Ip,  pServer_Port);
    if NetComm.State = wsConnected then
    begin
      ShouldConnect := true;
      recSend.orderID := _CM_REQ_SYNCPACKET;
      recSend.numValue := 0;
      recSend.strValue := '';
      recSend.strValue2 := '';
      recSend.strValue3 := '';
      recSend.ipConsole := '';
      NetComm.sendDataEx(REC_2D_ORDER, @recSend);
    end;


end;

procedure TYakhontManager.Net_Disconnect;
begin
  ShouldConnect := false;
  NetComm.Disconnect;
end;

procedure TYakhontManager.OnTimerLaunch(sender: TObject);
var
  dtRec    : TRecData_Yakhont;
  dis, brg : Double;
  I, J     : Integer;
  launchedNumb, designatedNumb : Integer;
begin
  LaunchInterval := LaunchInterval + 1;

  if LaunchInterval > 2 {10} then
  begin
    LaunchInterval := 0;
    TimerLaunch.Enabled := false;

    for i := 0 to 3 do
    begin
      if MissileLaunch[i] then
      begin
         MissileHaveLaunch := MissileHaveLaunch + 1;

         fmMainMM.countAvailable  := fmMainMM.countAvailable  - 1;
         fmMainMM.countOprational := fmMainMM.countOprational - 1;
         fmMainMM.countDesignated := fmMainMM.countDesignated - 1;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlDesignated.Caption  := IntToStr(fmMainMM.countDesignated);
         fmMainMM.pnlLaunched.Caption    := IntToStr(MissileHaveLaunch);

         MissileLaunch[i]     := false;

         dtRec.ShipID         := UniqueID_To_dbID(xShip.UniqueID);
         dtRec.mLauncherID    := i + 1;
         dtRec.mMissileID     := 1;
         dtRec.mMissileNumber := 1;
         dtRec.mWeaponID      := C_DBID_YAKHONT;
         dtRec.OrderID        := 1;

         case i of
           0 :
           begin
             if frmManualInput.typeOfVariant = 1 then
             begin
                Missile1.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                Missile1.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
             end
             else if frmManualInput.typeOfVariant = 2 then
             begin
                PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                Missile1.Dis := dis;
                Missile1.Brg := brg;
             end;

             dtRec.mTargetRange   := Missile1.Dis;
             dtRec.mTargetBearing := Missile1.Brg;

//             NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

             //fmMainMM.pnlPLP1.Color := clGray;
           end;

           1 :
           begin
             if frmManualInput.typeOfVariant = 1 then
             begin
                Missile2.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                Missile2.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
             end
             else if frmManualInput.typeOfVariant = 2 then
             begin
                PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                Missile2.Dis := dis;
                Missile2.Brg := brg;
             end;

             dtRec.mTargetRange   := Missile2.Dis;
             dtRec.mTargetBearing := Missile2.Brg;

//             NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

             //fmMainMM.pnlPLP2.Color := clGray;
           end;

           2 :
           begin
             if frmManualInput.typeOfVariant = 1 then
             begin
                Missile3.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                Missile3.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
             end
             else if frmManualInput.typeOfVariant = 2 then
             begin
                PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                Missile3.Dis := dis;
                Missile3.Brg := brg;
             end;

             dtRec.mTargetRange   := Missile3.Dis;
             dtRec.mTargetBearing := Missile3.Brg;

//             NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);

             //fmMainMM.pnlPLP3.Color := clGray;
           end;

           3 :
           begin
             if frmManualInput.typeOfVariant = 1 then
             begin
                Missile4.Dis := frmManualInput.Rec_TIVar1.DistTarget;
                Missile4.Brg := frmManualInput.Rec_TIVar1.BearingTarget;
             end
             else if frmManualInput.typeOfVariant = 2 then
             begin
                PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
                Missile4.Dis := dis;
                Missile4.Brg := brg;
             end;

             dtRec.mTargetRange   := Missile4.Dis;
             dtRec.mTargetBearing := Missile4.Brg;

//             NetComm.sendDataEx(REC_DATA_Yakhont, @dtRec);


             //fmMainMM.pnlPLP4.Color := clGray;
           end;

         end;

         for j := 0 to 3 do
         begin
           if MissileLaunch[j] then
             TimerLaunch.Enabled := True;
         end;

         Break;
      end;
    end;
  end;
end;

procedure TYakhontManager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

/// <summary>
/// event untuk timer selama simulasi berjalan
/// -> untuk melakukan setiap proses yg dijalankan setiap waktu
/// -> e.g. menggambar pada peta (repaint, dll)
/// </summary>
/// <param name="dt"></param>
procedure TYakhontManager.EventOnMainTimer(const dt: double);
var
  Longi, Latti : Double;
begin
  inherited;

  if TCPClient.State <> wsConnected then
    Net_Connect;

  accumulation := accumulation + 1;

  with fmMainMM do
  begin
    { set center map as own ship position }
    if accumulation mod 10 = 0 then
    begin
      fMap.CenterX  := xShip.PositionX;
      fMap.CenterY  := xShip.PositionY;
    end;

    Longi         := fMap.CenterX;
    Latti         := fMap.CenterY;
    temp_heading  := xShip.Heading;
    temp_speed    := xShip.Speed;
    temp_pitch    := xShip.Pitch;
    temp_roll     := xShip.Roll;

    FMap.ConvertCoord(temp_PosX, temp_PosY, Longi, Latti, miMapToScreen);

    { updating target data when target assigned by instructor }
    UpdateDataTarget;

    if accumulation mod 20 = 0 then
      UpdatePnlLeftBottom;
  end;

  with frmManualInput do
  begin
    StrGridShowResult.Cells[1,2] := formatDMS_lat(xShip.PositionY);
    StrGridShowResult.Cells[1,3] := formatDMS_long(xShip.PositionX);
    StrGridShowResult.Cells[1,5] := FormatFloat('0.00', xShip.Heading);
    StrGridShowResult.Cells[1,6] := FormatFloat('0.00', xShip.Speed);
  end;
end;

procedure TYakhontManager.UpdatePnlLeftBottom;
var
  dis, brg : Double;
  dj, dd, dsgh : Double;
begin
  with fmMainMM do
  begin
    // update own ship data
    lblLongitude.Caption   := formatDMS_long(xShip.PositionX);
    lblLatitude.Caption    := formatDMS_lat(xShip.PositionY);
    lblShipHeading.Caption := FormatFloat('0.00', xShip.Heading);
    lblShipSpeed.Caption   := FormatFloat('0.00', xShip.Speed);
    lblShipPitch.Caption   := FormatFloat('0.00', xShip.Pitch);
    lblShipRoll.Caption    := FormatFloat('0.00', xShip.Roll);

    //
    lblType.Caption        := '';
    lblD.Caption           := '';
    lblDd.Caption          := '';
    lblPx.Caption          := '';
    lblB.Caption           := '';
    lblDj.Caption          := '';
    lblDsgh.Caption        := '';
    lblPz.Caption          := '';

    if SD then
    begin
      { display }
      { distance -> km }
      { bearing  -> compass }
      if frmManualInput.typeOfVariant = 1 then
      begin
        distance   := (frmManualInput.Rec_TIVar1.DistTarget / 1000);     // m to km
        bearing    := frmManualInput.Rec_TIVar1.BearingTarget;
        targetType := frmManualInput.Rec_TIVar1.TypeTarget;
      end
      else if frmManualInput.typeOfVariant = 2 then
      begin
        PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);
        distance   := (dis / 1000);                                      // m to km
        bearing    := brg;
        targetType := frmManualInput.Rec_TIVar2.TypeTarget;
      end;

      if (distance > 0) and (distance <= 80) then
      begin
         lblTrajectoryType.Caption := 'B1';
         dj := 0;
         dd := 4;
         if (distance > 0) and (distance <= 50) then
            dsgh := 2.4
         else if (distance > 50) and (distance <= 80) then
            dsgh := 20.381;
      end
      else if (distance > 80) and (distance <= 120) then
      begin
         lblTrajectoryType.Caption := 'B1n';
         dj := distance - 50;
         dd := 72;
         dsgh := 19;
      end
      else if (distance > 120) and (distance <= 200) then
      begin
         lblTrajectoryType.Caption := 'B2';
         dj := 0;
         dd := distance - 15 {240};
         dsgh := 19;
      end
      else if (distance > 200) and (distance <= 300) then
      begin
         lblTrajectoryType.Caption := 'B2n';
         dj := distance - 50;
         dd := distance - 15 {270};
         dsgh := 19;
      end;

      lblD.Caption      := FormatFloat('0.00', distance);
      lblB.Caption      := FormatFloat('0.00', bearing);
      lblType.Caption   := IntToStr(targetType);

      lblDd.Caption     := FormatFloat('0.00', dd);
      lblDj.Caption     := FormatFloat('0.00', dj);
      lblDsgh.Caption   := FormatFloat('0.00', dsgh);
      lblPx.Caption     := '0.97';
      lblPz.Caption     := '0.97';
    end;
  end;
end;

procedure TYakhontManager.UpdateDataTarget;     { update data target for drawing on map }
var
  i : Integer;
  obj : TClientObject;

  { temp target position }
  Longi, Latti : Double;
  result_X, result_Y : Single;
  result_Pt : TPoint;

  tempTargetAssignment : string;
  cond1, cond2, condTargetAssignment : Integer;

  { ptc = own ship point; pte = seeker point }
  ptc, pte : t2DPoint;
  seekerX, seekerY : Single;
begin
  if (frmSelectionTI.currentSelectionTI = 1) or (frmSelectionTI.currentSelectionTI = 2) then
  begin
    { target ship & when seeker on }
    { MainObjList.ItemCount is sum of targets }
    SetLength(EventForm.target_X, MainObjList.ItemCount);
    SetLength(EventForm.target_Y, MainObjList.ItemCount);
    EventForm.length_array := MainObjList.ItemCount;

    for I := 0 to MainObjList.ItemCount - 1 do
    begin
      obj := MainObjList.getObject(i) as TClientObject;

      { comparing assigned shipID }
      cond1 := AnsiCompareText(obj.UniqueID, dbID_to_UniqueID(shiptarget1));
      cond2 := AnsiCompareText(obj.UniqueID, dbID_to_UniqueID(shipTarget2));

      if (cond1 = 0) or (cond2 = 0) then
      begin
        Longi := obj.PositionX;
        Latti := obj.PositionY;

        fmMainMM.FMap.ConvertCoord(result_X, result_Y, longi, Latti, miMapToScreen);
        result_Pt.X := Round(result_X);
        result_Pt.Y := Round(result_Y);

        EventForm.target_X[I] := result_Pt.X;
        EventForm.target_Y[I] := result_Pt.Y;

        // =======================================================================


        tempTargetAssignment := dbID_to_UniqueID(tempAssignTarget);
        condTargetAssignment := AnsiCompareText(obj.UniqueID, tempTargetAssignment);

        { target yang akan ditembak }
        if condTargetAssignment = 0 then
        begin
          fmMainMM.target_PosX  := result_Pt.X;
          fmMainMM.target_PosY  := result_Pt.Y;

          ptc.X := xShip.PositionX;
          ptc.Y := xShip.PositionY;

          fmMainMM.FMap.ConvertCoord(fmMainMM.cTarget_PosX, fmMainMM.cTarget_PosY, longi, Latti, miMapToScreen);

          pte := CalcPositionAhead(ptc,
          CalcRange(ptc.X, ptc.Y, longi, Latti) - (19 * C_KiloMeter_To_NauticalMiles),
          ConvCompass_To_Cartesian(CalcBearing(ptc.X, ptc.Y, longi, Latti)));

          fmMainMM.FMap.ConvertCoord(seekerX, seekerY, pte.X, pte.Y, miMapToScreen);
          fmMainMM.seeker_PosX    := Round(seekerX);
          fmMainMM.seeker_PosY    := Round(seekerY);

          bearing  := CalcBearing(ptc.X, ptc.Y, longi, Latti);
          distance := (CalcRange(ptc.X, ptc.Y, longi, latti)) * C_NauticalMiles_TO_Meter;

          if distance > 19000 then
            isDistMoreThan19 := true
          else
            isDistMoreThan19 := False;

          if (distance <= 300000) and (distance > 19000) then
            isTargetInRange := True
          else
            isTargetInRange := False;


          { update record }
          with frmManualInput do
          begin
            case frmManualInput.typeOfVariant of
              1: begin
                Rec_TIVar1.DistTarget                 := distance;
                Rec_TIVar1.BearingTarget              := bearing;
                Rec_TIVar1.HeadingTarget              := obj.Heading;
                Rec_TIVar1.SpeedTarget                := obj.Speed;
              end;

              2: begin
                Rec_TIVar2.LongTarget                 := Longi;
                Rec_TIVar2.LattTarget                 := Latti;
                Rec_TIVar2.HeadingTarget              := obj.Heading;
                Rec_TIVar2.Speedtarget                := obj.Speed;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TYakhontManager.OnTimerToUpdate(sender : TObject);
begin
  UpdateInterval := UpdateInterval + 1;

  if UpdateInterval > 0 then
  begin
    if (UpdateInterval mod 10) = 0 then
    begin

    end;
  end;
end;

procedure TYakhontManager.SetSceneOffSetFromID(const id: Integer; var x: Double; var y: Double);
var
  IDPORT : integer ;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ENV_PETA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    IDPORT := DQ.Fields[0].AsInteger ;
    DQ.Close;
    GetSceneOffSetFromPortID(IDPORT,x,y);
  end;
end;


{procedure TYakhontManager.tmrConnectToBridgeTimer(sender: TObject);
var
  recSend : TRecData2DOrder;
begin
  tmrConnectToBridge.Enabled := False;

  //connect to bridge
  if TCPClient.State <> wsConnected then
  begin
    TCPClient.Connect(pServer_Ip,pServer_Port);
    tmrConnectToBridge.Enabled := True;
  end
  else
  begin
    tmrConnectToBridge.Enabled := False;

    if TCPClient.State = wsConnected then
    begin
      //req sync packet after connect
      recSend.orderID := _CM_REQ_SYNCPACKET;
      recSend.numValue := 0;
      recSend.strValue := '';
      recSend.strValue2 := '';
      recSend.strValue3 := '';
      recSend.ipConsole := '';
      TCPClient.sendDataEx(REC_2D_ORDER, @recSend);
    end;
  end;

end;
}
procedure TYakhontManager.GetSceneOffSetFromPortID(const id: integer; var x, y: double);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select XOFFSET,YOFFSET from env_port where ID=' + IntToStr(id));
    DQ.Open;
    x := DQ.FieldByName('XOFFSET').AsFloat;
    y := DQ.FieldByName('YOFFSET').AsFloat;
    DQ.Close;
  end;
end;

procedure  TYakhontManager.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
var
  sc  : TSimulationClass;
  obj : TClientObject;
  aRec: ^TRecData3DPosition;
begin
  aRec := @apRec^;

  {Conver to 3D to map}
  aRec^.x := aRec^.x + mapoffsetX;
  aRec^.y := aRec^.y + mapoffsetY;

  AddToMemoLog(' _pos: ' + IntToStr(aRec^.ShipID) + Format('%2.6f, %2.6f',[aRec^.X, aRec^.Y]));

  // update it's own possision
  if aRec.ShipID = UniqueID_To_dbID(xShip.UniqueID) then
  begin
      xShip.PositionX := aRec.X;
      xShip.PositionY := aRec.Y;
      xShip.PositionZ := aRec.Z;

      xShip.Speed    := aRec.speed;
      xShip.Heading  := aRec.heading;

      //***
      xShip.Pitch := aRec.pitch;
      xShip.Roll  := aRec.roll;
  end
  else
  begin
    sc := MainObjList.FindObjectByUid(dbID_to_UniqueID(aRec.ShipID));

    {klo gk nemu dicreate}
    if sc = nil then begin
      obj := TClientObject.Create;
      obj.UniqueID := dbID_to_UniqueID(aRec.ShipID);
      obj.Enabled := TRUE;

      obj.PositionX := aRec.X;
      obj.PositionY := aRec.Y;
      obj.PositionZ := aRec.Z;
      obj.Speed    := aRec.speed;
      obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);

      MainObjList.AddObject(obj);
    end
    else {klo nemu di update}
    begin
      obj := sc as TClientObject;

      obj.PositionX := aRec.X;
      obj.PositionY := aRec.Y;
      obj.PositionZ := aRec.Z;
      obj.Speed    := aRec.speed;
      obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);
    end;
    //***
  end;
end;

procedure TYakhontManager.EventOnReceivePLPState(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
var
  aRec : ^TRec_Command_YakhontPLP;
  RecSend : TRec_Command_YakhontPLP;
begin
  aRec := @apRec^;

  if aRec^.Mode = 1 then
  begin
    RecSend.Mode := 2;
    RecSend.CommandID := Byte(YakhontManager.PLPState);
    NetLocalCommServer.SendDataEx(REC_COMMAND_YAKHONTPLP, @RecSend, nil);
  end;
end;

procedure TYakhontManager.EventOnReceiveMissileStatus(apRec: PAnsiChar; aSize: Integer);
var
  aRec : ^TRecMissilePos;
  I : Integer;
   qCancel, qOprational, qLaunched, qPassed : Integer;
  //missileLaunched_1, missileLaunched_2, missileLaunched_3, missileLaunched_4 : Boolean;
begin
     qCancel := fmMainMM.countCancelled;
     qOprational := 0;
     qLaunched := 0;
     qPassed := 0;
  aRec := @apRec^;
  if (pShipID = aRec^.shipID) and (aRec^.WeaponID = C_DBID_YAKHONT) then
  begin
    case aRec^.launcherID of
      1 :
      begin
        case aRec^.status of
          ST_MISSILE_LOADED :
          begin
            if (fmMain.checkKR231 = False) and (fmMain.checkLauncher1 = False) then
            begin
              fmMainMM.pnlPLP1.Color:=clLime;
              frmCirculationASM.colorMissile1.Color:=clCream;
              frmAppointmentASM.colorMissile1.Color:=clCream;
              frmCirculationASM.checkCirculationASM_1:=True;
              frmAppointmentASM.checkAppointmentASM_1:=True;
              frmEmergencyRelease.checkEmergency_1:=True;

              Missile1.isReady:=True;
              Missile1.state := Missile1.C_noState;

              fmMainMM.readyToLaunch[1] := 1;


              fmMainMM.value_T1 := RandomRange(881,891)*0.01;
              fmMainMM.pnlNoASM1.Caption := '1';
              fmMainMM.pnlT1.Caption    := FloatToStr(fmMainMM.value_T1);
              fmMainMM.pnlTmax1.Caption := FloatToStr(fmMainMM.value_TMax);
              fmMainMM.pnltmaxs1.Caption:= FloatToStr(fmMainMM.value_TmaxS);
            end;

            fmMain.missileLoaded1:=True;

//            qOprational := qOprational + 1;
//            qPassed := qPassed - 1;
          end;

          ST_MISSILE_RUN :
          begin

            fmMainMM.pnlPLP1.Color:=clGray;
            fmMainMM.readyToLaunch[1] := 2;
            fmMainMM.pnlNoASM1.Caption := '';
            fmMainMM.pnlT1.Caption    := '';
            fmMainMM.pnlTmax1.Caption := '';
            fmMainMM.pnltmaxs1.Caption:= '';
            //fmMainMM.readyToLaunch[1] := 3;
//            qOprational := qOprational - 1;
//            qLaunched := qLaunched + 1;
          end;

          ST_MISSILE_DEL :
          begin
            fmMainMM.pnlPLP1.Color:=clPurple;
            frmCirculationASM.colorMissile1.Color:=clRed;
            frmAppointmentASM.colorMissile1.Color:=clRed;
            frmCirculationASM.checkCirculationASM_1:=False;
            frmAppointmentASM.checkAppointmentASM_1:=False;
            frmEmergencyRelease.checkEmergency_1:=False;
            Missile1.isReady:=False;
            fmMain.missileLoaded1:=False;
            fmMainMM.readyToLaunch[1] := 3;
//            qPassed := qPassed + 1;
//            qLaunched := qLaunched - 1;
          end;
        end;
      end;

      2 :
      begin
        case aRec^.status of
          ST_MISSILE_LOADED :
          begin
            if (fmMain.checkKR231 = False) and (fmMain.checklauncher2 = False) then
            begin
              fmMainMM.pnlPLP2.Color:=clLime;
              frmCirculationASM.colorMissile2.Color:=clCream;
              frmAppointmentASM.colorMissile2.Color:=clCream;
              frmCirculationASM.checkCirculationASM_2:=True;
              frmAppointmentASM.checkAppointmentASM_2:=True;
              frmEmergencyRelease.checkEmergency_2:=True;
              Missile2.isReady:=True;
              Missile2.state  := Missile2.C_noState;

              fmMainMM.readyToLaunch[2] := 1;

              fmMainMM.value_T2 := RandomRange(881,891)*0.01;
              fmMainMM.pnlNoASM2.Caption:= '2';
              fmMainMM.pnlT2.Caption    := FloatToStr(fmMainMM.value_T2);
              fmMainMM.pnlTmax2.Caption := FloatToStr(fmMainMM.value_TMax);
              fmMainMM.pnltmaxs2.Caption:= FloatToStr(fmMainMM.value_TmaxS);
            end;

            fmMain.missileLoaded2:=True;
//            qOprational := qOprational + 1;
//            qPassed := qPassed - 1;
          end;

          ST_MISSILE_RUN :
          begin
            fmMainMM.pnlPLP2.Color:=clGray;
            fmMainMM.readyToLaunch[2] := 2;
            fmMainMM.pnlNoASM2.Caption := '';
            fmMainMM.pnlT2.Caption    := '';
            fmMainMM.pnlTmax2.Caption := '';
            fmMainMM.pnltmaxs2.Caption:= '';
            //fmMainMM.readyToLaunch[2] := 3;
//            qOprational := qOprational - 1;
//            qLaunched := qLaunched + 1;
          end;

          ST_MISSILE_DEL :
          begin
            fmMainMM.pnlPLP2.Color:=clPurple;
            frmCirculationASM.colorMissile2.Color:=clRed;
            frmAppointmentASM.colorMissile2.Color:=clRed;
            frmCirculationASM.checkCirculationASM_2:=False;
            frmAppointmentASM.checkAppointmentASM_2:=False;
            frmEmergencyRelease.checkEmergency_2:=False;
            Missile2.isReady:=False;
            fmMain.missileLoaded2:=False;
            fmMainMM.readyToLaunch[2] := 3;
//            qPassed := qPassed + 1;
//            qLaunched := qLaunched - 1;
          end;
        end;
      end;

      3 :
      begin
        case aRec^.status of
          ST_MISSILE_LOADED :
          begin
            if (fmMain.checkKR231 = False) and (fmMain.checkLauncher3 = False) then
            begin
              fmMainMM.pnlPLP3.Color:=clLime;
              frmCirculationASM.colorMissile3.Color:=clCream;
              frmAppointmentASM.colorMissile3.Color:=clCream;
              frmCirculationASM.checkCirculationASM_3:=True;
              frmAppointmentASM.checkAppointmentASM_3:=True;
              frmEmergencyRelease.checkEmergency_3:=True;
              Missile3.isReady:=True;
              Missile3.state := Missile3.C_noState;

              fmMainMM.readyToLaunch[3] := 1;


              fmMainMM.value_T3 := RandomRange(881,891)*0.01;
              fmMainMM.pnlNoASM3.Caption:= '3';
              fmMainMM.pnlT3.Caption    := FloatToStr(fmMainMM.value_T3);
              fmMainMM.pnlTmax3.Caption := FloatToStr(fmMainMM.value_TMax);
              fmMainMM.pnltmaxs3.Caption:= FloatToStr(fmMainMM.value_TmaxS);
            end;
            fmMain.missileLoaded3:=True;


//            qOprational := qOprational + 1;
//            qPassed := qPassed - 1;
          end;

          ST_MISSILE_RUN :
          begin
            fmMainMM.pnlPLP3.Color:=clGray;
            fmMainMM.readyToLaunch[3] := 2;
            fmMainMM.pnlNoASM3.Caption := '';
            fmMainMM.pnlT3.Caption    := '';
            fmMainMM.pnlTmax3.Caption := '';
            fmMainMM.pnltmaxs3.Caption:= '';
            //fmMainMM.readyToLaunch[3] := 3;
//            qOprational := qOprational - 1;
//            qLaunched := qLaunched + 1;
          end;

          ST_MISSILE_DEL :
          begin
            fmMainMM.pnlPLP3.Color:=clPurple;
            frmCirculationASM.colorMissile3.Color:=clRed;
            frmAppointmentASM.colorMissile3.Color:=clRed;
            frmCirculationASM.checkCirculationASM_3:=False;
            frmAppointmentASM.checkAppointmentASM_3:=False;
            frmEmergencyRelease.checkEmergency_3:=False;
            Missile3.isReady:=False;
            fmMain.missileLoaded3:=False;
            fmMainMM.readyToLaunch[3] := 3;
//            qLaunched := qLaunched - 1;
//            qPassed := qPassed + 1;
          end;
        end;
      end;

      4 :
      begin
        case aRec^.status of
          ST_MISSILE_LOADED :
          begin
            if (fmMain.checkKR231 = False) and (fmMain.checkLauncher4 = False) then
            begin
              fmMainMM.pnlPLP4.Color:=clLime;
              frmCirculationASM.colorMissile4.Color:=clCream;
              frmAppointmentASM.colorMissile4.Color:=clCream;
              frmCirculationASM.checkCirculationASM_4:=True;
              frmAppointmentASM.checkAppointmentASM_4:=True;
              frmEmergencyRelease.checkEmergency_4:=True;
              Missile4.isReady:=True;
              Missile4.state := Missile4.C_noState;

              fmMainMM.readyToLaunch[4] := 1;

              fmMainMM.value_T4 := RandomRange(881,891)*0.01;
              fmMainMM.pnlNoASM4.Caption:= '4';
              fmMainMM.pnlT4.Caption    := FloatToStr(fmMainMM.value_T4);
              fmMainMM.pnlTmax4.Caption := FloatToStr(fmMainMM.value_TMax);
              fmMainMM.pnltmaxs4.Caption:= FloatToStr(fmMainMM.value_TmaxS);
            end;

            fmMain.missileLoaded4:=True;
            Missile4.state := Missile4.C_noState;


//            qOprational := qOprational + 1;
//            qPassed := qPassed - 1;
          end;

          ST_MISSILE_RUN :
          begin
            fmMainMM.pnlPLP4.Color:=clGray;
            fmMainMM.readyToLaunch[4] := 2;
            fmMainMM.pnlNoASM4.Caption := '';
            fmMainMM.pnlT4.Caption    := '';
            fmMainMM.pnlTmax4.Caption := '';
            fmMainMM.pnltmaxs4.Caption:= '';
            //fmMainMM.readyToLaunch[4] := 3;
//            qOprational := qOprational - 1;
//            qLaunched := qLaunched + 1;
          end;

          ST_MISSILE_DEL :
          begin
            fmMainMM.pnlPLP4.Color:=clPurple;
            frmCirculationASM.colorMissile4.Color:=clRed;
            frmAppointmentASM.colorMissile4.Color:=clRed;
            frmCirculationASM.checkCirculationASM_4:=False;
            frmAppointmentASM.checkAppointmentASM_4:=False;
            frmEmergencyRelease.checkEmergency_4:=False;
            Missile4.isReady:=False;
            fmMain.missileLoaded4:=False;
            fmMainMM.readyToLaunch[4] := 3;
//            qLaunched := qLaunched - 1;
//            qPassed := qPassed + 1;
          end;
        end;
      end;
    end;



     for I := 1 to 4 do
   begin
//     if fmMainMM.readyToLaunch[I] = 0 then
//        qCancel     := qCancel + 1;

     if fmMainMM.readyToLaunch[I] = 1 then
     begin
        qOprational := qOprational + 1;
        //qPassed := qPassed - 1;
     end;


     if fmMainMM.readyToLaunch[I] = 2 then
        qLaunched   := qLaunched + 1;

     if fmMainMM.readyToLaunch[I] = 3 then
     begin
        qPassed     := qPassed + 1;
        //qOprational := qOprational - 1;
     end;



   end;

   fmMainMM.countAvailable         := qOprational+ qCancel;
   fmMainMM.countCancelled         := qCancel;
   fmMainMM.countOprational        := qOprational;
   fmMainMM.countLaunched          := qLaunched;
   fmMainMM.countPassed            := qPassed;

   fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
   fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
   fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
   fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
   fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);

  end;


end;

procedure TYakhontManager.eventReceiveTarget(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRecObjectAssigned;
begin
  aRec := @apRec^;
  aRec := @apRec^;

  if aRec.mode = 0 then
  begin
    // cancel
    shipTarget1 := 0;
    shipTarget2 := 0;
  end
  else if aRec.mode = 1 then
  begin
    if (frmSelectionTI.currentSelectionTI = 1) or (frmSelectionTI.currentSelectionTI = 2) then
    begin
      if aRec.OrderID = __ORD_ID_YAKHONT then
        tempAssignTarget := aRec.ObjectAssign;

      if ((shipTarget1 <> 0) and (shipTarget2 <> 0)) and (shipTarget1 <> shipTarget2) then
      begin
         { get ship id of assginment target }

         shipTarget2 := tempAssignTarget;
      end
      else
      begin
        shipTarget2 := 0;

        if shipTarget1 = 0 then
          shipTarget1 := tempAssignTarget;

        if shipTarget2 = 0 then
          shipTarget2 := tempAssignTarget;
      end;
    end;
  end;
end;

procedure TYakhontManager.EventOnSendingLog(aEventID: Integer; aParam1, aParam2, aParam3: Double);
var
  aRec : TRecEventLog;
begin
  aRec.consoleID := 6;
  aRec.eventID   := aEventID;
  aRec.param1    := aParam1;
  aRec.param2    := aParam2;
  aRec.param3    := aParam3;
  aRec.ShipID    := UniqueID_To_dbID(xShip.UniqueID);

  NetComm.sendDataEx(REC_EVENT_LOG, @aRec);
end;

procedure TYakhontManager.EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
var aRec: TRecMissilePos;
    arMissile   : ^TRec3DMissilePos;
    tipe, status: string;
    tempUID     : string;
    ts          : LongWord;
    obj : TClientObject;
    shipID, weaponID, launcherID, missileID, missileNumber : integer ;
begin
  CopyMemory(@aRec, apRec, aSize);

  arMissile := @apRec^;

  shipID        := arMissile^.shipID ;
  WeaponID      := arMissile^.WeaponID ;
  launcherID    := arMissile^.launcherID;
  missileID     := arMissile^.missileID;
  missileNumber := arMissile^.MissileNumber;

  tempUID := dbID_to_MissileUniqueID(shipID, WeaponID, launcherID, missileID, missileNumber);

  tmpNewObj := MainObjList.FindObjectByUid(tempUID);

  if Assigned(tmpNewObj) then
  begin
    // UPDATE
    if arMissile^.status = ST_MISSILE_RUN then
    begin
      obj := tmpNewObj as TClientObject;

      obj.PositionX := arMissile^.x;
      obj.PositionY := arMissile^.y;
      obj.PositionZ := arMissile^.Z;
      obj.Speed    := arMissile^.speed;
      obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);
    end
    else if arMissile^.status = ST_MISSILE_DEL then
    begin
      tmpNewObj.MarkAs_NeedToBeFree;
    end
    else if arMissile^.status = ST_MISSILE_HIT then
    begin
//        MainObjList.RemoveObject(tmpNewObj);
    end;
  end
  else
  begin
    if arMissile^.status = ST_MISSILE_RUN then
    begin
      //CREATE NEW
      obj := TClientObject.Create;
      //obj.UniqueID := aRec.missileID;
      obj.Enabled := TRUE;
      obj.UniqueID := tempUID;  //--> set UniqID-nya spt temp. biar klo dicari ketemu
      {tambahan Aldy}
      obj.PositionX := arMissile^.x;
      obj.PositionY := arMissile^.y;
      obj.PositionZ := arMissile^.Z;
      obj.Speed    := arMissile^.speed;
      obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);

      MainObjList.AddObject(obj);
    end;
  end;
end;

procedure TYakhontManager.EventOnReceiveTechnicalStatus(apRec: PAnsiChar; aSize: integer);
var
//  aRec: ^TRecStatus_Console_Yakhont;
  aRec : ^TRecStatus_Console;
  picture_Path : String;
  fIndikatorOn, fIndikatorOff, fIndikatorFault : String;
  fCentang, fSilang : string;
  I, sum, qCancel, qOprational, qLaunched, qPassed : Integer;
begin
  picture_Path    := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
  fIndikatorOn    := picture_Path + 'data\images\yakhont\AB_Indikator_On_SMALL.bmp';
  fIndikatorOff   := picture_Path + 'data\images\yakhont\AB_Indikator_Of_SMALL.bmp';
  fIndikatorFault := picture_Path + 'data\images\yakhont\AB_Indikator_On_SMALL_Merah.bmp';

  fCentang        := picture_Path + 'data\images\yakhont\YakhontCentang.bmp';
  fSilang         := picture_Path + 'data\images\yakhont\YakhontSilang.bmp';

  qCancel     := 0;
  qOprational := 0;
  qLaunched   := 0;
  qPassed     := 0;

  aRec := @apRec^;

  if aRec.OWN_SHIP_UID = xShip.UniqueID then
  begin
    if aRec.ErrorID = __STAT_YAKHONT_PRINTER then
    begin
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._statePrinter := True;
        fmMain.imgPrinter.Picture.LoadFromFile(fSilang);
        fmMainMM.pnlFault.Color   := clRed;
        fmMainMM.pnlFault.Caption := 'PRINTER';
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin
        fmMain._statePrinter := False;
        fmMain.imgPrinter.Picture.LoadFromFile(fCentang);
      end;
    end;

    if aRec.ErrorID = __STAT_YAKHONT_CONSOLE_N1 then
    begin

    end;

    if aRec.ErrorID = __STAT_YAKHONT_CONSOLE_N2 then
    begin

    end;

    if aRec.ErrorID = __STAT_YAKHONT_RIGHT_1 then
    begin
       { launcher 1 can't be launched }
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._stateLauncher1 := True;
        fmMain.imgLauncher1.Picture.LoadFromFile(fSilang);
        fmMain.checkLauncher1 := True;

        Missile1.isReady := False;
        fmMainMM.readyToLaunch[1] := 0;
        fmMainMM.pnlPLP1.Color    := clRed;

        frmCirculationASM.colorMissile1.Color:=clRed;
        frmAppointmentASM.colorMissile1.Color:=clRed;
        frmCirculationASM.checkCirculationASM_1:=False;
        frmAppointmentASM.checkAppointmentASM_1:=False;
        frmEmergencyRelease.checkEmergency_1:=False;

        fmMainMM.pnlNoASM1.Caption := '';
        fmMainMM.pnlT1.Caption     := '';
        fmMainMM.pnlTmax1.Caption  := '';
        fmMainMM.pnltmaxs1.Caption := '';

        frmAppointmentASM.colorMissile1.Color := clRed;
        frmCirculationASM.colorMissile1.Color := clRed;

        fmMainMM.pnlFault.Color   := clRed;
        fmMainMM.pnlFault.Caption := 'NODE 3';
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin

        fmMain.checkLauncher1 := False;

        if fmMain.checkKR231 = False then
        begin
          fmMain._stateLauncher1 := False;
          fmMain.imgLauncher1.Picture.LoadFromFile(fCentang);


          if fmMain.missileLoaded1 = true then
          begin
            Missile1.isReady := True;
            Missile1.state   := Missile1.C_noState;
            fmMainMM.readyToLaunch[1] := 1;
            fmMainMM.pnlPLP1.Color    := clLime;

            fmMainMM.pnlNoASM1.Caption := '1';
            fmMainMM.pnlT1.Caption     := FloatToStr(fmMainMM.value_T1);
            fmMainMM.pnlTmax1.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs1.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile1.Color := clCream;
            frmCirculationASM.colorMissile1.Color := clCream;
            frmCirculationASM.checkCirculationASM_1:= True;
            frmAppointmentASM.checkAppointmentASM_1:= True;
            frmEmergencyRelease.checkEmergency_1:= True;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP1.Color  := clPurple;
            fmMainMM.readyToLaunch[1] := 3;
          end;
        end;

      end;
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

         fmMainMM.countAvailable         := qCancel + qOprational;
         fmMainMM.countCancelled         := qCancel;
         fmMainMM.countOprational        := qOprational;
         fmMainMM.countLaunched          := qLaunched;
         fmMainMM.countPassed            := qPassed;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
         fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    end;

    if aRec.ErrorID = __STAT_YAKHONT_RIGHT_3 then
    begin
       { launcher 2 can't be launched }
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._stateLauncher2 := True;
        fmMain.imgLauncher2.Picture.LoadFromFile(fSilang);
        fmMain.checkLauncher2 := True;

        Missile2.isReady := False;
        fmMainMM.readyToLaunch[2] := 0;
        fmMainMM.pnlPLP2.Color    := clRed;

        frmCirculationASM.colorMissile2.Color:=clRed;
        frmAppointmentASM.colorMissile2.Color:=clRed;
        frmCirculationASM.checkCirculationASM_2:=False;
        frmAppointmentASM.checkAppointmentASM_2:=False;
        frmEmergencyRelease.checkEmergency_2:=False;

        fmMainMM.pnlNoASM2.Caption := '';
        fmMainMM.pnlT2.Caption     := '';
        fmMainMM.pnlTmax2.Caption  := '';
        fmMainMM.pnltmaxs2.Caption := '';

        frmAppointmentASM.colorMissile2.Color := clRed;
        frmCirculationASM.colorMissile2.Color := clRed;

        fmMainMM.pnlFault.Color   := clRed;
        fmMainMM.pnlFault.Caption := 'NODE 5';
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin

        fmMain.checklauncher2 := False;

        if fmMain.checkKR231 = False then
        begin
          fmMain._stateLauncher2 := False;
          fmMain.imgLauncher2.Picture.LoadFromFile(fCentang);


          if fmMain.missileLoaded2 = True then
          begin
            Missile2.isReady := True;
            Missile2.state   := Missile2.C_noState;
            fmMainMM.readyToLaunch[2] := 1;
            fmMainMM.pnlPLP2.Color    := clLime;

            fmMainMM.pnlNoASM2.Caption := '2';
            fmMainMM.pnlT2.Caption     := FloatToStr(fmMainMM.value_T2);
            fmMainMM.pnlTmax2.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs2.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile2.Color := clCream;
            frmCirculationASM.colorMissile2.Color := clCream;
            frmCirculationASM.checkCirculationASM_2:= True;
            frmAppointmentASM.checkAppointmentASM_2:= True;
            frmEmergencyRelease.checkEmergency_2:= True;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP2.Color  := clPurple;
            fmMainMM.readyToLaunch[2] := 3;
          end;
        end;

      end;
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

         fmMainMM.countAvailable         := qCancel + qOprational;
         fmMainMM.countCancelled         := qCancel;
         fmMainMM.countOprational        := qOprational;
         fmMainMM.countLaunched          := qLaunched;
         fmMainMM.countPassed            := qPassed;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
         fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    end;

    if aRec.ErrorID = __STAT_YAKHONT_LEFT_2 then
    begin
       { launcher 3 can't be launched }
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._stateLauncher3 := True;
        fmMain.imgLauncher3.Picture.LoadFromFile(fSilang);
        fmMain.checkLauncher3 := True;

        Missile3.isReady := False;
        fmMainMM.readyToLaunch[3] := 0;
        fmMainMM.pnlPLP3.Color    := clRed;

        frmCirculationASM.colorMissile3.Color:=clRed;
        frmAppointmentASM.colorMissile3.Color:=clRed;
        frmCirculationASM.checkCirculationASM_3:=False;
        frmAppointmentASM.checkAppointmentASM_3:=False;
        frmEmergencyRelease.checkEmergency_3:=False;

        fmMainMM.pnlNoASM3.Caption := '';
        fmMainMM.pnlT3.Caption     := '';
        fmMainMM.pnlTmax3.Caption  := '';
        fmMainMM.pnltmaxs3.Caption := '';

        frmAppointmentASM.colorMissile3.Color := clRed;
        frmCirculationASM.colorMissile3.Color := clRed;

        fmMainMM.pnlFault.Color   := clRed;
        fmMainMM.pnlFault.Caption := 'NODE 4';
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin

        fmMain.checkLauncher3 := False;

        if fmMain.checkKR231 = False then
        begin
          fmMain._stateLauncher3 := False;
          fmMain.imgLauncher3.Picture.LoadFromFile(fCentang);


          if fmMain.missileLoaded3 = True then
          begin
            Missile3.isReady := True;
            Missile3.state   := Missile3.C_noState;
            fmMainMM.readyToLaunch[3] := 1;
            fmMainMM.pnlPLP3.Color    := clLime;

            fmMainMM.pnlNoASM3.Caption := '3';
            fmMainMM.pnlT3.Caption     := FloatToStr(fmMainMM.value_T3);
            fmMainMM.pnlTmax3.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs3.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile3.Color := clCream;
            frmCirculationASM.colorMissile3.Color := clCream;
            frmCirculationASM.checkCirculationASM_3:= True;
            frmAppointmentASM.checkAppointmentASM_3:= True;
            frmEmergencyRelease.checkEmergency_3:= True;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP3.Color  := clPurple;
            fmMainMM.readyToLaunch[3] := 3;
          end;
        end;

      end;
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

         fmMainMM.countAvailable         := qCancel + qOprational;
         fmMainMM.countCancelled         := qCancel;
         fmMainMM.countOprational        := qOprational;
         fmMainMM.countLaunched          := qLaunched;
         fmMainMM.countPassed            := qPassed;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
         fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    end;

    if aRec.ErrorID = __STAT_YAKHONT_LEFT_4 then
    begin
       { launcher 4 can't be launched }
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._stateLauncher4 := True;
        fmMain.imgLauncher4.Picture.LoadFromFile(fSilang);
        fmMain.checklauncher4 := True;

        Missile4.isReady := False;
        fmMainMM.readyToLaunch[4] := 0;
        fmMainMM.pnlPLP4.Color    := clRed;

        frmCirculationASM.colorMissile4.Color:=clRed;
        frmAppointmentASM.colorMissile4.Color:=clRed;
        frmCirculationASM.checkCirculationASM_4:=False;
        frmAppointmentASM.checkAppointmentASM_4:=False;
        frmEmergencyRelease.checkEmergency_4:=False;

        fmMainMM.pnlNoASM4.Caption := '';
        fmMainMM.pnlT4.Caption     := '';
        fmMainMM.pnlTmax4.Caption  := '';
        fmMainMM.pnltmaxs4.Caption := '';

        frmAppointmentASM.colorMissile4.Color := clRed;
        frmCirculationASM.colorMissile4.Color := clRed;

        fmMainMM.pnlFault.Color   := clRed;
        fmMainMM.pnlFault.Caption := 'NODE 6';
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin

        fmMain.checklauncher4 := False;

        if fmMain.checkKR231 = False then
        begin
          fmMain._stateLauncher4 := False;
          fmMain.imgLauncher4.Picture.LoadFromFile(fCentang);


          if fmMain.missileLoaded4 = True then
          begin
            Missile4.isReady := True;
            Missile4.state   := Missile4.C_noState;
            fmMainMM.readyToLaunch[4] := 1;
            fmMainMM.pnlPLP4.Color    := clLime;

            fmMainMM.pnlNoASM4.Caption := '4';
            fmMainMM.pnlT4.Caption     := FloatToStr(fmMainMM.value_T4);
            fmMainMM.pnlTmax4.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs4.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile4.Color := clCream;
            frmCirculationASM.colorMissile4.Color := clCream;
            frmCirculationASM.checkCirculationASM_4:= True;
            frmAppointmentASM.checkAppointmentASM_4:= True;
            frmEmergencyRelease.checkEmergency_4:= True;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP4.Color  := clPurple;
            fmMainMM.readyToLaunch[4] := 3;
          end;
        end;

      end;
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

         fmMainMM.countAvailable         := qCancel + qOprational;
         fmMainMM.countCancelled         := qCancel;
         fmMainMM.countOprational        := qOprational;
         fmMainMM.countLaunched          := qLaunched;
         fmMainMM.countPassed            := qPassed;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
         fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    end;

    if aRec.ErrorID = __STAT_YAKHONT_KR231 then
    begin
      { all launchers cant be launched }
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        fmMain._stateKR231 := True;

        fmMain.checkKR231 := True;

        fmMain._stateLauncher1 := True;
        fmMain.imgLauncher1.Picture.LoadFromFile(fSilang);

        fmMain._stateLauncher2 := True;
        fmMain.imgLauncher2.Picture.LoadFromFile(fSilang);

        fmMain._stateLauncher3 := True;
        fmMain.imgLauncher3.Picture.LoadFromFile(fSilang);

        fmMain._stateLauncher4 := True;
        fmMain.imgLauncher4.Picture.LoadFromFile(fSilang);

        Missile1.isReady := False;
        Missile2.isReady := False;
        Missile3.isReady := False;
        Missile4.isReady := False;

        for I := 1 to 4 do
          fmMainMM.readyToLaunch[I] := 0;

        fmMainMM.pnlPLP1.Color    := clRed;
        fmMainMM.pnlPLP2.Color    := clRed;
        fmMainMM.pnlPLP3.Color    := clRed;
        fmMainMM.pnlPLP4.Color    := clRed;

        frmCirculationASM.checkCirculationASM_1:=False;
        frmAppointmentASM.checkAppointmentASM_1:=False;
        frmEmergencyRelease.checkEmergency_1:=False;

        frmCirculationASM.checkCirculationASM_2:=False;
        frmAppointmentASM.checkAppointmentASM_2:=False;
        frmEmergencyRelease.checkEmergency_2:=False;

        frmCirculationASM.checkCirculationASM_3:=False;
        frmAppointmentASM.checkAppointmentASM_3:=False;
        frmEmergencyRelease.checkEmergency_3:=False;

        frmCirculationASM.checkCirculationASM_4:=False;
        frmAppointmentASM.checkAppointmentASM_4:=False;
        frmEmergencyRelease.checkEmergency_4:=False;

        fmMainMM.pnlNoASM1.Caption := '';
        fmMainMM.pnlT1.Caption     := '';
        fmMainMM.pnlTmax1.Caption  := '';
        fmMainMM.pnltmaxs1.Caption := '';
        fmMainMM.pnlNoASM2.Caption := '';
        fmMainMM.pnlT2.Caption     := '';
        fmMainMM.pnlTmax2.Caption  := '';
        fmMainMM.pnltmaxs2.Caption := '';
        fmMainMM.pnlNoASM3.Caption := '';
        fmMainMM.pnlT3.Caption     := '';
        fmMainMM.pnlTmax3.Caption  := '';
        fmMainMM.pnltmaxs3.Caption := '';
        fmMainMM.pnlNoASM4.Caption := '';
        fmMainMM.pnlT4.Caption     := '';
        fmMainMM.pnlTmax4.Caption  := '';
        fmMainMM.pnltmaxs4.Caption := '';

        frmAppointmentASM.colorMissile1.Color := clRed;
        frmCirculationASM.colorMissile1.Color := clRed;
        frmAppointmentASM.colorMissile2.Color := clRed;
        frmCirculationASM.colorMissile2.Color := clRed;
        frmAppointmentASM.colorMissile3.Color := clRed;
        frmCirculationASM.colorMissile3.Color := clRed;
        frmAppointmentASM.colorMissile4.Color := clRed;
        frmCirculationASM.colorMissile4.Color := clRed;
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin
        fmMain._stateKR231 := False;

        fmMain.checkKR231 := False;
        if fmMain.checkLauncher1 = False then
        begin
          fmMain._stateLauncher1 := False;
          fmMain.imgLauncher1.Picture.LoadFromFile(fCentang);
          if fmMain.missileLoaded1 = true then
          begin
            Missile1.isReady := True;
            fmMainMM.readyToLaunch[1] := 1;
            fmMainMM.pnlPLP1.Color    := clLime;

            frmCirculationASM.checkCirculationASM_1:=True;
            frmAppointmentASM.checkAppointmentASM_1:=True;
            frmEmergencyRelease.checkEmergency_1:=True;

            fmMainMM.pnlNoASM1.Caption := '1';
            fmMainMM.pnlT1.Caption     := FloatToStr(fmMainMM.value_T1);
            fmMainMM.pnlTmax1.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs1.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile1.Color := clCream;
            frmCirculationASM.colorMissile1.Color := clCream;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP1.Color  := clPurple;
            fmMainMM.readyToLaunch[1] := 3;
          end;
        end;

        if fmMain.checklauncher2 = False then
        begin
          fmMain._stateLauncher2 := False;
          fmMain.imgLauncher2.Picture.LoadFromFile(fCentang);
          if fmMain.missileLoaded2 = True then
          begin
            Missile2.isReady := True;
            fmMainMM.readyToLaunch[2] := 1;
            fmMainMM.pnlPLP2.Color    := clLime;

            frmCirculationASM.checkCirculationASM_2:=True;
            frmAppointmentASM.checkAppointmentASM_2:=True;
            frmEmergencyRelease.checkEmergency_2:=True;

            fmMainMM.pnlNoASM2.Caption := '2';
            fmMainMM.pnlT2.Caption     := FloatToStr(fmMainMM.value_T2);
            fmMainMM.pnlTmax2.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs2.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile2.Color := clCream;
            frmCirculationASM.colorMissile2.Color := clCream;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP2.Color  := clPurple;
            fmMainMM.readyToLaunch[2] := 3;
          end;
        end;

        if fmMain.checkLauncher3 = False then
        begin
          fmMain._stateLauncher3 := False;
          fmMain.imgLauncher3.Picture.LoadFromFile(fCentang);
          if fmMain.missileLoaded3 = True then
          begin
            Missile3.isReady := True;
            fmMainMM.readyToLaunch[3] := 1;
            fmMainMM.pnlPLP3.Color    := clLime;

            frmCirculationASM.checkCirculationASM_3:=True;
            frmAppointmentASM.checkAppointmentASM_3:=True;
            frmEmergencyRelease.checkEmergency_3:=True;

            fmMainMM.pnlNoASM3.Caption := '3';
            fmMainMM.pnlT3.Caption     := FloatToStr(fmMainMM.value_T3);
            fmMainMM.pnlTmax3.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs3.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile3.Color := clCream;
            frmCirculationASM.colorMissile3.Color := clCream;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP3.Color  := clPurple;
            fmMainMM.readyToLaunch[3] := 3;
          end;
        end;

        if fmMain.checklauncher4 = False then
        begin
          fmMain._stateLauncher4 := False;
          fmMain.imgLauncher4.Picture.LoadFromFile(fCentang);
          if fmMain.missileLoaded4 = True then
          begin
            Missile4.isReady := True;
            fmMainMM.readyToLaunch[4] := 1;
            fmMainMM.pnlPLP4.Color    := clLime;

            frmCirculationASM.checkCirculationASM_4:=True;
            frmAppointmentASM.checkAppointmentASM_4:=True;
            frmEmergencyRelease.checkEmergency_4:=True;

            fmMainMM.pnlNoASM4.Caption := '4';
            fmMainMM.pnlT4.Caption     := FloatToStr(fmMainMM.value_T4);
            fmMainMM.pnlTmax4.Caption  := FloatToStr(fmMainMM.value_TMax);
            fmMainMM.pnltmaxs4.Caption := FloatToStr(fmMainMM.value_TmaxS);

            frmAppointmentASM.colorMissile4.Color := clCream;
            frmCirculationASM.colorMissile4.Color := clCream;

            fmMainMM.pnlFault.Color   := clTeal;
            fmMainMM.pnlFault.Caption := '';
          end
          else
          begin
            fmMainMM.pnlPLP4.Color  := clPurple;
            fmMainMM.readyToLaunch[4] := 3;
          end;
        end;

      end;
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

         fmMainMM.countAvailable         := qCancel + qOprational;
         fmMainMM.countCancelled         := qCancel;
         fmMainMM.countOprational        := qOprational;
         fmMainMM.countLaunched          := qLaunched;
         fmMainMM.countPassed            := qPassed;

         fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
         fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
         fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
         fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
         fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    end;

    if aRec.ErrorID = __STAT_YAKHONT_GYRO then
    begin

    end;

    if aRec.ErrorID = __STAT_YAKHONT_INS300V then
    begin
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        frmYakh_A_1_MainForm._state300v := True;
        frmYakh_A_1_MainForm.isChecked  := False;
        frmYakh_A_1_MainForm.imgPS.Picture.LoadFromFile(fIndikatorOff);
        frmYakh_A_1_MainForm.imgSB.Picture.LoadFromFile(fIndikatorOff);
        frmYakh_A_1_MainForm.img300v.Picture.LoadFromFile(fIndikatorFault);
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin
        frmYakh_A_1_MainForm._state300v := False;
        frmYakh_A_1_MainForm.isChecked  := True;
        frmYakh_A_1_MainForm.imgPS.Picture.LoadFromFile(fIndikatorOn);
        frmYakh_A_1_MainForm.imgSB.Picture.LoadFromFile(fIndikatorOn);
        frmYakh_A_1_MainForm.img300v.Picture.LoadFromFile(fIndikatorOff);
      end;
    end;
    if aRec.ErrorID = __STAT_YAKHONT_INS27V then
    begin
      if aRec.ParamError = __YAKHONT_STATUS_OFF then
      begin
        frmYakh_A_2_MainForm._state27v := True;
        frmYakh_A_2_MainForm.img27v.Picture.LoadFromFile(fIndikatorFault);
      end
      else if aRec.ParamError = __YAKHONT_STATUS_ON then
      begin
        frmYakh_A_2_MainForm._state27v := False;
        frmYakh_A_2_MainForm.img27v.Picture.LoadFromFile(fIndikatorOff);
      end;
    end;

    {sum := 0;
    for I := 1 to 4 do
    begin
      if fmMainMM.readyToLaunch[I] = 1 then
        sum := sum + 1;
    end;

  //  countAvailable  := sum;
    fmMainMM.countOprational := sum;
  //  countDesignated :=
    fmMainMM.countCancelled  := 4 - sum;
  //  countLaunched   :=
  //  countPassed     :=

    fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
    fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
    fmMainMM.pnlDesignated.Caption  := IntToStr(fmMainMM.countDesignated);
    fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
    fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
    fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
    }
  end;
end;

function TYakhontManager.LoadScenarioFromIniFile(const fIni: string): integer;
var
  IniF : TIniFile;
  readStr : string;
  readInt, n : integer;
  fName : string;

  pCurrentScenID : integer;
  pServer_Ip,pServer_Port, //TriD_IP, TriD_Port,
  pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
  pShipName, pClassName : string;
  pShipID, pClassID : Integer;

begin // di sini CreateForm dan Load Map
  // sebaiknya diubah, load setting aja simpan ke variabel GameSetting,
  // setelah semua di load baru di execute.
    if FIni = '' then
      FName := Copy(ExtractFilePath(Application.ExeName),1,Length(ExtractFilePath(Application.ExeName))-4) + 'data\Scenario\TDCYakhont.ini'
//      FName := Copy(ExtractFilePath(Application.ExeName),1,Length(ExtractFilePath(Application.ExeName))-4) + 'data\Scenario\TDCC802.ini'
    else
      FName := FIni;

    if FileExists(FName) then
      AddToMemoLog('Opening scenario '+ FName)
    else begin
      AddToMemoLog('Error: Scenario "' +FName+ '" is not Exist');
      exit;
    end;

    IniF   := TIniFile.Create(FName);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    if not StandAloneMode then
    begin
      InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
          pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );

      //. multiplayer section . . . .
      ServerIp  := pServer_Ip;     // Inif.ReadString(C_mult_sect, C_servip_id, '127.0.0.1');
      ServerPort:= pServer_Port;   //Inif.ReadString(C_mult_sect, C_servport_id, '2120'

      //. this ship section . . . .

      readStr := Inif.ReadString(C_Ship_section, 'thisshipid', 'VSL0020');
      ShipID := pShipID;  //UniqueID_To_dbID(readStr);

      readInt := Inif.ReadInteger(C_game_sect, 'dbconnect', 0);

      if ( ShipID <> -1)then
      begin
        DataModule1.EmuConn.HostName := pDBServer;
        DataModule1.EmuConn.User := pDBUser;
        DataModule1.EmuConn.Password := pDBPass;
        DataModule1.EmuConn.Database := pDBName;
        DataModule1.EmuConn.Connect;

        //get offset by scenario;
        //GetSceneOffSetFromPortID(pCurrentScenID, mapOffsetX, mapOffsetY);
        SetSceneOffSetFromID(pCurrentScenID, mapOffsetX, mapOffsetY);

        ShipName    := DataModule1.GetShipName(ShipId);
        ShipClassID := DataModule1.GetShipType(ShipId, ShipClassName);

        AddToMemoLog(' ShipID      = ' + IntToStr(ShipID) );
        AddToMemoLog(' ShipClassId = ' + IntToStr(ShipClassID) );

        AddToMemoLog(' ShipName ' + ShipName );
        AddToMemoLog(' ShipClassName ' + ShipClassName );
      end;
    end;

    //load map
    readStr := IniF.ReadString(C_Map_Section, C_gst_ident, '');
    //showmessage(readStr);
    if (readStr <> '') and FileExists(readStr) then begin
      AddToMemoLog('Opening geoset '+ readStr);
      LoadGeoset(readStr);
    end
    else begin
      dec(result);
      AddToMemoLog('Error: Geoset "' +readStr+ '" is not Exist');
      exit;
    end;

    readStr := IniF.ReadString(C_Map_Section, C_grd_ident, '');
    if (readStr <> '') and FileExists(readStr) then begin
      AddToMemoLog('Opening 3D map '+ readStr);
      ///LoadGrid(readStr);
    end
    else begin
      dec(result);
      AddToMemoLog('Error: 3D Map "' + readStr + '" is not Exist');
      exit;
    end;

    IniF.Free;
end;


procedure TYakhontManager.LoadSettingForm(filepath: string);
var
  inifile : TIniFile;
  tempstring : TStringList;
begin
  inifile := TIniFile.Create(filepath);
  tempstring := TStringList.Create;

  inifile.ReadSection('Form A', tempstring);

  idMainFormA1 := StrToInt(inifile.ReadString('Form A', tempstring[0],'Default'));
  idMainFormA2 := StrToInt(inifile.ReadString('Form A', tempstring[1],'Default'));
  idBlankScreen := StrToInt(inifile.ReadString('Form A', tempstring[2],'Default'));
  idLoadingScreen := StrToInt(inifile.ReadString('Form A', tempstring[3],'Default'));
  idMain := StrToInt(inifile.ReadString('Form A', tempstring[4],'Default'));
  idMainMM := StrToInt(inifile.ReadString('Form A', tempstring[5],'Default'));
  idCertificateData := StrToInt(inifile.ReadString('Form A', tempstring[6],'Default'));
  idCirculationASM := StrToInt(inifile.ReadString('Form A', tempstring[7],'Default'));
  idCRData := StrToInt(inifile.ReadString('Form A', tempstring[8],'Default'));
  idLock := StrToInt(inifile.ReadString('Form A', tempstring[9],'Default'));
  idManualInput := StrToInt(inifile.ReadString('Form A', tempstring[10],'Default'));
  idSelectionTI := StrToInt(inifile.ReadString('Form A', tempstring[11],'Default'));
  idTargetDest := StrToInt(inifile.ReadString('Form A', tempstring[12],'Default'));
  idEmergencyRelease := StrToInt(inifile.ReadString('Form A', tempstring[13],'Default'));
  idTest := StrToInt(inifile.ReadString('Form A',tempstring[14],'Default'));
  idDoc := StrToInt(inifile.ReadString('Form A', tempstring[15],'Default'));

  inifile.Free;
  tempstring.Free;
end;

//procedure TYakhontManager.PredictDistanceCourse({target : TRecTIVariant1; }var Distance, Bearing: Double);
//var
//  t : double; //waktu
//  posShip : tDouble2DPoint;
//  posTargetAwal : tDouble2DPoint;
//  posTargetBaru : tDouble2DPoint;
//  s : Double; //jarak
//begin
//  if (target.DistTarget > 0) and (target.DistTarget <= 80) then
//  begin
//    t := 10.7 + ((target.DistTarget - 7000) / 680);
//  end
//  else if (target.DistTarget > 80) and (target.DistTarget <= 120) then
//  begin
//    t := 74.6 + ((target.DistTarget - 5400) / 680);
//  end
//  else if (target.DistTarget > 120) and (target.DistTarget <= 200) then
//  begin
//    t := 173.6 + ((target.DistTarget - 69090.1) / 850);
//  end
//  else if (target.DistTarget > 200) and (target.DistTarget <= 300) then
//  begin
//    t := 234.7 + ((target.DistTarget - 109090.1) / 850);
//  end;
//
//  //set posisi kapal
//  posShip.X := xShip.PositionX;
//  posShip.Y := xShip.PositionY;
//
//  posTargetAwal := CalcPositionAhead(posShip, target.DistTarget, target.BearingTarget);
//
//  s := target.SpeedTarget * t;
//
//  posTargetBaru := CalcPositionAhead(posTargetAwal, s, target.HeadingTarget);
//
//  {Result DISTANCE}
//  Distance := CalcRange(posShip.X, posShip.Y, posTargetBaru.X, posTargetBaru.Y);
//
//  {Result BEARING}
//  Bearing := CalcBearing(posShip.X, posShip.Y, posTargetBaru.X, posTargetBaru.Y);
//end;

procedure TYakhontManager.PredictDistanceCourse(target : TRecTIVariant2; var Distance, Bearing: Double);
var
  t : double; //waktu
  posShip : tDouble2DPoint;
  posTargetAwal : tDouble2DPoint;
  posTargetBaru : tDouble2DPoint;
  s : Double; //jarak
  dis : Double; // jarak awal;
begin
  // set posisi kapal
  posShip.X := xShip.PositionX;
  posShip.Y := xShip.PositionY;

  posTargetAwal.X := target.LongTarget;
  posTargetAwal.Y := target.LattTarget;

  /// distance awal in Kilometer
  dis := CalcRange(posShip.X, posShip.Y, posTargetAwal.X, posTargetAwal.Y) * C_NauticalMiles_To_KiloMeter;

  if (dis > 0) and (dis <= 80) then
  begin
    t := 10.7 + ((dis - 7000) / 680);
  end
  else if (dis > 80) and (dis <= 120) then
  begin
    t := 74.6 + ((dis - 5400) / 680);
  end
  else if (dis > 120) and (dis <= 200) then
  begin
    t := 173.6 + ((dis - 69090.1) / 850);
  end
  else if (dis > 200) and (dis <= 300) then
  begin
    t := 234.7 + ((dis - 109090.1) / 850);
  end;

  s := (target.SpeedTarget * C_Knot_To_ms * t) * C_Meter_To_NauticalMiles;

  { masih salah brooooo }
  posTargetBaru := CalcPositionAhead(posTargetAwal, s, target.HeadingTarget);

  {Result DISTANCE} { dalam meter }
  Distance := CalcRange(posShip.X, posShip.Y, posTargetBaru.X, posTargetBaru.Y)* C_NauticalMiles_TO_Meter;
  if (Distance <= 300000) and (Distance > 19000) then
    isTargetInRange := True
  else
    isTargetInRange := False;

  {Result BEARING}  { dalam kompas }
  Bearing := CalcBearing(posShip.X, posShip.Y, posTargetBaru.X, posTargetBaru.Y);
end;

function TYakhontManager.Calc_Zoom(Map : TMap; onMapX1, onMapY1, onMapX2, onMapY2 : Double; shouldBeRange: Double): Double;
var
  rNow : Double;
begin
  Result := 1;
  rNow   := CalcRange(onMapX1, onMapY1, onMapX2, onMapY2);

  Result := shouldBeRange / rNow;
end;

end.
