unit uTDCmanager;
(*
  Created       : 14 August 2007
  Last Modified : 14 August 2007

  Author        : Andy Sucipto
  description   : implementation of simulation manager
                  for kolat emulator TDC .

*)

interface

uses
    Forms,
    Graphics,
    Classes,

//------------------------------------------------------------------------------
    uBaseDataType,
    uBaseSimulationObject,
    uBaseSensor,

    uDataModule,

    uLibRadar,

    uTCPClient,
    uTCPDatatype,


    uTestShip,
    uLibClientObject,

    uObjectView,
    uLibTDCClass,

    uSimulationManager,
    uBridgeSet,
    uLibEmulatorSetting,

    {re-connect}
    overbyteicsWSocket;

  type

//==============================================================================
// Client manager for TDC Simulator
//==============================================================================
    TGameSetting = record
      TargetFile: string;
      // nanti yg lain pindah sini ya...
      
    end;
    

    TTDCManager = class(TSimulationManager)
    private
      FTDC_OffCenter    : boolean;
      FShipUpdateIL     : tInterleave;
      FRadarUpdateIL    : tInterleave;

      function GetRepaintCycle: Word;
      procedure SetRepaintCycle(const Value: Word);

    protected
      UniqueIdFactory : integer;
      NetHandler      :   TCPT_ARRAY_PROCEDURE;

      procedure EventOnMainTimer(const dt: double); override;

      {re-connect}
//      procedure onTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);

      // NetWork Event handler
      //procedure Handle_ (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_datum           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_FOC_plus             (apRec: PAnsiChar; aSize: integer);
      procedure Handle_FOC_minus            (apRec: PAnsiChar; aSize: integer);

      procedure Handle_Change_Ident      (apRec: PAnsiChar; aSize: integer);
      procedure Handle_select_radar_type    (apRec: PAnsiChar; aSize: integer);

      procedure Handle_start_ICM            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_update_ICM           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_end_ICM              (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_tor           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_tor         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_asrl          (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_asrl        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_WIPE                 (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_ram             (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_auto            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_dr              (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_ram           (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_FC            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_FC          (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_SSM           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_SSM         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_esm_fix         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_Synch_timebase       (apRec: PAnsiChar; aSize: integer);
      procedure SendSynchTimeBase;

      procedure Handle_CorrectRam           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_UpdateTrackPosition  (apRec: PAnsiChar; aSize: integer);

      procedure Handle_TrackSwitchPos       (apRec: PAnsiChar; aSize: integer);

      //gigih
      procedure Handle_assign_gun_WCC       (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_gun_WCC     (apRec: PAnsiChar; aSize: integer);

      //mas sam
      procedure Handle_assign_FC_OCC        (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_engBox        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_track           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_SetTrackLost         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_point           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_receive_sonar_owa    (apRec: PAnsiChar; aSize: integer);

      procedure Handle_receive_link         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_correlate_track      (apRec: PAnsiChar; aSize: integer);
      procedure Handle_decorrelate_track    (apRec: PAnsiChar; aSize: integer);

      procedure Handle_UpdateTrackPosition_Owa(apRec: PAnsiChar; aSize: integer);

      procedure  EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
      procedure  Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
      procedure  Event_AssignHandler(apRec: PAnsiChar; aSize: integer);

      procedure  Event_OnReceiveLink      (apRec: PAnsiChar; aSize: integer);

      procedure EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
      procedure Event_RecDBOrderAvailable(apRec: PAnsiChar; aSize: integer);
      function  dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                         MissileID, MissileNumber  : integer): string;

      procedure  Event_RcvHarpoonSetting(apRec: PAnsiChar; aSize: integer);
      procedure  Event_RcvASRLPanelSetting(apRec: PAnsiChar; aSize: integer);

      procedure CreateShipForms(const aShipClassID, aTDCNumber: integer); virtual;
      procedure CreateMinimalForms;

    public
    // TDC parts..
      OffX_Map, OffY_Map : Double;
      xShip       : TXShip;         // kapal tempat Radar berada
      //ShipID, ShipClassID : integer;
      //ShipName, ShipClassName : string;

      UseDatabase: boolean;

      ActiveRadar : TClientRadar;

      TheTDC      : TGenericTDCInterface;
//      TDCNumber   : integer;
      FTimebaseServer : BOOLEAN;

      GameSetting : TGameSetting;

      bridgeSet     :  TRecBridgeSet;
      bridgeSetPath : string;

      settingMap : TRecIniMapSet;
      settingTDC : TRecIniTDCSet;

      StandAloneMode : boolean;

      constructor Create;
      destructor Destroy; override;

      procedure InitializeSimulation;     override;
      procedure FinalizeSimulation;       override;

      //specialProcedure
      procedure LoadTarget(const fIni: string);


      procedure LoadScenario;     override;
      procedure UnLoadScenario;   override;

      procedure UpdateMember;                       override;

      procedure DrawMember;                         override;
      procedure DrawAllOnMapXCanvas(aCnv: TCanvas); override;

      procedure CleanUpMember;                      override;

      function GetUniqueId: string;
      procedure AddToMemoLog(const str :string);

      procedure TurnOnOffRadar(const setOn: boolean);

      procedure LoadKabehSetting;
      procedure ApplyKabehSetting;

      procedure GetAsrocWeaponAssigned;
    published
      property RepaintCycle: Word read GetRepaintCycle write SetRepaintCycle;
    end;
//==============================================================================


  procedure BeginSimulation;
  procedure EndSimulation;

var
  TDCSimCenter  : TTDCManager;


implementation

uses
    Windows, SysUtils, IniFiles, Math, uBaseFunction,  uBaseConstan, MapXLib_TLB,
    uMapXFunction,uLibTDC_Nala, uLibTDC_Oswald, uLibTDC_Singa, uLibTDC_Rencong,
    uTDCConstan, uMapWindow, DateUtils,uClassDatabase,
    ASRLRCU, Dialogs;


//------------------------------------------------------------------------------
//-- Simulation Initialization and Finalization
    procedure BeginSimulation;
    begin
      //ParamMap
      TDCSimCenter := TTDCManager.Create;
      uSimulationManager.SimCenter := TDCSimCenter;

    end;

    procedure EndSimulation;
    begin
      uSimulationManager.SimCenter := nil;
      TDCSimCenter.Free;

    end;

    function UniqueID_To_dbID(const uid: string): integer;
    var s: string;
    begin
      s := Copy(uid, 4, Length(uid)-3);
      try
        result := StrToInt(Trim(s));
      except
        on EConvertError do begin
          result := -1;
          exit;
        end
      end;
    end;

{ TClientManager }
//--------------------------------------------------------------------------
//-- Simulation Implementation
  constructor TTDCManager.Create;
  var i: integer;
  begin
    inherited;

    FGameDelayInterval  := 1;
    FRepaintIL.Cycle    := 1; //3

    UniqueIdFactory := random(10);
    FTDC_OffCenter  := TRUE;

    GamePlayMode := pmStandAlone;

    FShipUpdateIL.Counter := 1;
    FShipUpdateIl.Cycle   := 27;   //10ms * 30

    FRadarUpdateIL.Counter := 2;
    FRadarUpdateIL.Cycle   := 297;

    SetLength(NetHandler, C_Max_Order_ID + 1);
    for i := 1 to C_Max_Order_ID do begin
      NetHandler[i] := nil;
    end;

    {re-connect}
//    NetComm.Socket.OnChangeState := onTCPChangeState;

    NetHandler[ OrdID_select_radar_type ] := Handle_select_radar_type ;
    NetHandler[ OrdID_start_ICM         ] := Handle_start_ICM ;
    NetHandler[ OrdID_update_ICM        ] := Handle_update_ICM ;
    NetHandler[ OrdID_end_ICM           ] := Handle_end_ICM ;
    NetHandler[ OrdID_init_datum        ] := Handle_init_datum ;

    NetHandler[ OrdID_FOC_plus          ] := Handle_FOC_plus ;
    NetHandler[ OrdID_FOC_minus         ] := Handle_FOC_minus ;

    NetHandler[ OrdID_Change_ident      ] := Handle_Change_Ident ;

    NetHandler[ OrdID_assign_tor        ] := Handle_assign_tor ;
    NetHandler[ OrdID_deassign_tor      ] := Handle_deassign_tor ;
    NetHandler[ OrdID_assign_asrl       ] := Handle_assign_asrl ;
    NetHandler[ OrdID_deassign_asrl     ] := Handle_deassign_asrl ;
    NetHandler[ OrdID_WIPE              ] := Handle_WIPE ;

    NetHandler[ OrdID_init_ram          ] := Handle_init_ram ;

    NetHandler[ OrdID_init_auto         ] := Handle_init_auto ;
    NetHandler[ OrdID_init_DR           ] := Handle_init_DR ;
    NetHandler[ OrdID_assign_ram        ] := Handle_assign_ram ;


    NetHandler[ OrdID_assign_SSM        ] := Handle_assign_SSM ;
    NetHandler[ OrdID_deassign_SSM      ] := Handle_deassign_SSM ;
    NetHandler[ OrdID_init_esm_fix      ] := Handle_init_esm_fix ;

    NetHandler[ OrdID_Synch_timebase    ] := Handle_Synch_timebase;

    NetHandler[ OrdID_CorrectRAM        ] := Handle_CorrectRam;
    NetHandler[ OrdID_UpdateTrackPos    ] := Handle_UpdateTrackPosition;

    NetHandler[ OrdID_assign_FC         ] := Handle_assign_FC ;
    NetHandler[ OrdID_deassign_FC       ] := Handle_deassign_FC ;

    NetHandler[ OrdID_assign_gun        ] := Handle_assign_gun_WCC ;
    NetHandler[ OrdID_assign_FC_OCC     ] := Handle_assign_FC_OCC ;

    NetHandler[ OrdID_assign_engBox     ] := Handle_assign_engBox ;
    NetHandler[ OrdID_init_track        ] := Handle_init_track ;

    //NetHandler[ OrdID_TrackRepos        ] := Handle_TrackRepos ;
    NetHandler[ OrdID_SwitchPosition    ] := Handle_TrackSwitchPos ;
    NetHandler[ OrdID_TrackLost         ] := Handle_SetTrackLost ;

    NetHandler[ OrdID_init_point        ] := Handle_init_point ;
    NetHandler[ OrdID_recv_sonar_owa    ] := Handle_receive_sonar_owa ;
    NetHandler[ OrdID_send_link         ] := Handle_receive_link ;
    NetHandler[ OrdID_stop_send_link    ] := Handle_receive_link ;

    NetHandler[ OrdID_correlate_track   ] := Handle_correlate_track ;
    NetHandler[ OrdID_decorrelate_track ] := Handle_decorrelate_track ;

    NetHandler[ OrdID_UpdateTrackPos_owa] := Handle_UpdateTrackPosition_Owa;

    LoadKabehSetting;
  end;

  destructor TTDCManager.Destroy;
  begin
    SetLength(NetHandler, 0);

    inherited;
  end;


  procedure TTDCManager.EventOnMainTimer(const dt: double);
  var
  i : Integer;
  {re-connect}
//  recSend : TRecData2DOrder;
  begin

    for i := 0 to FSpeedMultiplier-1  do begin
      // update time
      MainGameTimer.IncreaseMillisecond(dt);

      // call move memb/e/r

//      if GamePlayMode = pmStandalone then begin
        MoveMember(dt);
        xShip.Run(dt);         // xShip is Moving;
//      end;

      ActiveRadar.PositionX := xShip.PositionX;
      ActiveRadar.PositionY := xShip.PositionY;
      ActiveRadar.PositionZ := xShip.PositionZ;

      ActiveRadar.Direction := xShip.Heading;

      ActiveRadar.Run(dt);     // radar is rotating @ processing signal

      { Update Heading }
      ActiveRadar.RadarProcess(MainObjList, MainGameTimer.GetMillisecond, true);
      ActiveRadar.DetObjects.RunAllMemberObject(dt);

      TheTDC.LastUpdateCounter :=  MainGameTimer.GetMillisecond;
      TheTDC.Run(dt);
    end;
    // end of for

    if (FShipUpdateIL.Counter = 0) or (FShipUpdateIL.Cycle = 0) then begin

      TheTDC.OwnShipMarker_SetPosition(xShip.PositionX, xShip.PositionY);

      TheTDC.Walk;

      if TheTDC. CU_ORStatus = stCU_OR_CENT then begin
        TheTDC.Cursorss.SetStartCoord(xShip.PositionX, xShip.PositionY);
      end;

      if not TheTDC.TrueMotion then
      begin
        Fmap.CenterX := xShip.PositionX;
        Fmap.CenterY := xShip.PositionY;
        Fmap.Rotation := 0;
      end
      else
      begin
        Fmap.Rotation := -xShip.Heading;
      end;

    end;
    if (FShipUpdateIL.Cycle > 0) then
      FShipUpdateIL.Counter := (FShipUpdateIL.Counter + 1) mod FShipUpdateIL.Cycle;

    if (FRadarUpdateIL.Counter = 0) or (FRadarUpdateIL.Cycle = 0) then begin
      if FTimebaseServer then
        SendSynchTimeBase;
      // nunut
      if ShouldConnect and (NetComm.State <> wsConnected ) then
        netComm.Connect(ServerIp, ServerPort);
    end;
    if (FRadarUpdateIL.Cycle > 0) then
      FRadarUpdateIL.Counter := (FRadarUpdateIL.Counter + 1) mod FRadarUpdateIL.Cycle;

    // proses yg tidak termasuk gamespeed multiplier:
    // call Draw member

    {re-connect}
//    if NetComm.State <> wsConnected then
//    begin
//      NetComm.Connect(ServerIp, ServerPort);
//    end
//    else
//    begin
//      //req sync packet after connect
//      recSend.orderID   := _CM_REQ_SYNCPACKET;
//      recSend.numValue  := 0;
//      recSend.strValue  := '';
//      recSend.strValue2 := '';
//      recSend.strValue3 := '';
//      recSend.ipConsole := '';
//      NetComm.sendDataEx(REC_2D_ORDER, @recSend);
//    end;

    if (FRepaintIL.Counter = 0) or (FRepaintIL.Cycle = 0) then begin
      UpdateMember;
      DrawMember;
    end;

    if  FRepaintIL.Cycle > 0 then
      FRepaintIL.Counter := (FRepaintIL.Counter + 1) mod FRepaintIL.Cycle;

    // call update tote
    if (FFormUpdateIL.Counter = 0) or (FFormUpdateIL.Cycle = 0) then
       ShowMemberData;

    if  FFormUpdateIL.Cycle > 0 then
       FFormUpdateIL.Counter := (FFormUpdateIL.Counter + 1) mod FFormUpdateIL.Cycle;

    // destroy everything that ask for freedom...

    CleanUpMember;
    Application.ProcessMessages;

  end;

  procedure TTDCManager.InitializeSimulation;
  var fName: string;

  begin
//     inherited; cuman VM.

    NetComm.RegisterProcedure(
      REC_3D_POSITION , EventonReceiveDataPosition, SizeOf(TRecData3DPosition));

    NetComm.RegisterProcedure(
       C_REC_ORDER, Event_OrderRecognizer, SizeOf(TRecOrder)) ;

    NetComm.RegisterProcedure(
       C_REC_ORDER_XY, Event_OrderRecognizer, SizeOf(TRecOrderXY));

    NetComm.RegisterProcedure(
      C_REC_TRACK_ORDER, Event_OrderRecognizer, SizeOf(TRecTrackOrder));

    NetComm.RegisterProcedure(
      C_REC_ORDER_ASSIGNMENT, Event_AssignHandler, sizeof(TRecOrderAssignment));

    NetComm.RegisterProcedure(
      C_REC_FIRE_CONTROL    ,Event_OrderRecognizer, sizeof(TRecFireControlOrder));

    NetComm.RegisterProcedure(
      C_REC_GUN_CONTROL    ,Event_OrderRecognizer, sizeof(TRecGunControl));

    NetComm.RegisterProcedure(
      REC_MISSILEPOS,       EventonRecMissilePosAvailable,  sizeof(TRecMissilePos));

    NetComm.RegisterProcedure(
      C_REC_XXX_ORDER,      Event_OrderRecognizer, sizeof(TRecXXXOrder));

    NetComm.RegisterProcedure(
      C_REC_LINK_ORDER,     Event_OnReceiveLink, sizeof(TRecLinkOrder));

    NetComm.RegisterProcedure(
      REC_3D_TORPEDO_MK44,  nil, sizeof(TRecTorpedoMK44Order));

    NetComm.RegisterProcedure(
      C_REC_HARPOON_SETTING, Event_RcvHarpoonSetting,  sizeOf(TRecHarpoonPanelSetting));

    NetComm.RegisterProcedure(
      REC_SET_ASROCK, nil , sizeof(TRec3DSetAsrock));

    NetComm.RegisterProcedure(
      REC_STAT_ORDER_CONSOLE, Event_RcvASRLPanelSetting , sizeof(TRecStatus_Console));

    NetComm.RegisterProcedure(
      REC_EVENT_LOG, nil, SizeOf(TRecEventLog));

    {re-connect}
//    NetComm.RegisterProcedure(
//      REC_2D_ORDER, nil, SizeOf(TRecData2DOrder));

   if ParamCount < 9 then
      //fname := ParamStr(1)      \\ update bagus => paramstr(1) = port
      StandAloneMode := True
   else
      StandAloneMode := False;

    fname := Data_dir + 'Scenario\TDCScene.ini';

    LoadKabehSetting;

    CreateShipForms(bridgeSet.mShip.mClassID, settingTDC.TDCNumber);

    if not StandAloneMode then
      GetAsrocWeaponAssigned;

    LoadGeoset(settingMap.geoset);
//    If VMInited then LoadGrid(settingMap.grid);

    Fmap.ZoomTo(32.0, settingMap.X, settingMap.Y);

    ActiveRadar   := TClientRadar.Create;
    ActiveRadar.CreateDefaultView(FMap);
//    ActiveRadar.PolarView.RangeMax := 32.0;

    TurnOnOffRadar(TRUE);

    xShip       := TXShip.Create;
    xShip.CreateDefaultView(Fmap);

    //procedure titip;
    TheTDC.FMap := FMap;
    TheTDC.xSHIP := xShip ;
    TheTDC.ActiveRadar := ActiveRadar;
    TheTDC.SetRadar_type(rtWM_28);
    TheTDC.SetRadar_Amplification(raLiner);
    TheTDC.SetRadar_MTI_Status(FALSE);

    TheTDC.SetView_RangeScale(32.0);
    TheTDC.netSend := NetComm;

    TheTDC.HaveToSend := true;

//    LoadObjectSetting(fname);
    ApplyKabehSetting;

    xShip.Enabled := TRUE;

    if Assigned(TheTDC) then begin
      TheTDC.Initialize;
    end;

    if not StandAloneMode then
    Net_Connect;

  end;

  procedure TTDCManager.FinalizeSimulation;
  begin
    Running := false;
    xShip.Free;
    ActiveRadar.Free;

    if Assigned(TheTDC) then begin
     TheTDC.netSend := nil;
     TheTDC.Free;
    end;

    inherited;
  end;

  procedure TTDCManager.LoadTarget(const fIni: string);
  var IniF:TIniFile;
      i: integer;
      sects : TStrings;
      ship : TXShip;
  begin // di sini CreateForm dan Load Map
    if not FileExists(FIni) then begin
      LogMemo.Add(fini + ' not found. No Target Loaded');
      exit;
    end;
      LogMemo.Add('Loading ' + fIni);

    IniF   := TIniFile.Create(FIni);
    sects := TStringList.Create;

    IniF.ReadSections(sects);
    for i := 0 to sects.Count-1 do begin

      LogMemo.Add('uid: ' + sects[i]);

      tmpNewObj  := TXShip.Create;

      Ship := tmpNewObj as TXShip;
      Ship.CreateDefaultView(FMap);
      Ship.UniqueID := sects[i];

      Ship.Speed    := IniF.ReadFloat(sects[i], C_speed_id,   0.0 );
      Ship.Heading  := IniF.ReadFloat(sects[i], C_heading_id, 0.0 );

      Ship.PositionX := IniF.ReadFloat(sects[i], C_posx_id,  0.0 );
      Ship.PositionY := IniF.ReadFloat(sects[i], C_posy_id,  0.0 );
      Ship.PositionZ := IniF.ReadFloat(sects[i], C_posz_id,  0.0 );

      Ship.Enabled := TRUE;
      MainObjList.AddObject(ship);

    end;

    sects.Clear;
    sects.Free;

  end;


//  procedure TTDCManager.onTCPChangeState(Sender: TObject; OldState,
//  NewState: TSocketState);
//  begin
//    if (OldState = wsConnected) and (NewState = wsClosed) then
//    begin
//      EventOnMainTimer(10);
//
//
//    end;
//  end;

procedure TTDCManager.LoadScenario;
  begin
{    // kondisi map sudah di load.
} end;

  procedure TTDCManager.UnLoadScenario;
  begin
     MainObjList.ClearObject;
     MainViewList.ClearObject;
     netComm.Disconnect;
    // if VMLoaded then LoadGrid('');
  end;

  procedure TTDCManager.UpdateMember;
  begin
    inherited;
    xShip.Update;
    ActiveRadar.Update;
    TheTDC.Update;
  end;

  //--------------------------------------------------------------------------
  procedure TTDCManager.DrawAllOnMapXCanvas(aCnv: TCanvas);
  begin
    xShip.DrawViews(aCnv);
    ActiveRadar.DrawViews (aCnv);

    TheTDC.Draw(aCnv);

  end;
  procedure TTDCManager.DrawMember;
  begin
    ActiveRadar.ConvertViewsPosition;
    xShip.ConvertViewsPosition;

    TheTDC.ConvertViewPosition;

    FMap.Repaint;
  end;

  function TTDCManager.GetUniqueId: string;
  begin
     Result := IntToStr(UniqueIdFactory);
     Inc(UniqueIdFactory);
  end;


  procedure TTDCManager.AddToMemoLog(const str: string);
  begin
    if Assigned(LogMemo) then begin
     LogMemo.Add('  ' + str);
    end;
  end;

  procedure TTDCManager.CleanUpMember;
  begin
    inherited;
    ActiveRadar.DetObjects.CleanUpObject;
    TheTDC.TrackList.CleanUpObject;
  end;

  procedure TTDCManager.CreateShipForms(const aShipClassID, aTDCNumber: integer);
  begin
    case aShipClassID of
      //----------------------------------------------------------------------
      C_ShipC_Fatahillah : begin   // nala
        TheTDC := TTDC_NalaInterface.Create;
        TheTDC.MyShipName := bridgeSet.mShip.mShipName;

        if (aTDCNumber = 1) or (aTDCNumber = 2) then
           TheTDC.CreateFormss(aTDCNumber)
        else
           TheTDC.CreateFormss(1);

        FMap := TheTDC.frmTengah.Map;

      end;
      //----------------------------------------------------------------------
      C_ShipC_Mandau     : begin      //Rencong
        TheTDC := TTDC_Rencong.Create;
        TheTDC.MyShipName := bridgeSet.mShip.mShipName;

         TheTDC.CreateFormss(1);

        FMap := TheTDC.frmTengah.Map;
      end;

      //----------------------------------------------------------------------
      C_ShipC_Singa      : begin       // fpb singa
        TheTDC := TTDC_Singa.Create;
        TheTDC.MyShipName := bridgeSet.mShip.mShipName;

        TheTDC.CreateFormss(1);

        FMap := TheTDC.frmTengah.Map;

      end;

      //----------------------------------------------------------------------
      C_ShipC_AhmadYani  : begin  // Oswald Siahaan
        TheTDC := TTDC_Oswald.Create;
        TheTDC.MyShipName := bridgeSet.mShip.mShipName;
        FMap := TheTDC.frmTengah.Map;

        if (aTDCNumber >= 1) and (aTDCNumber <= 4)then
           TheTDC.CreateFormss(aTDCNumber)
        else
           TheTDC.CreateFormss(1)
      end;

      else begin   // nala
        TheTDC := TTDC_NalaInterface.Create;
        TheTDC.MyShipName := bridgeSet.mShip.mShipName;

        if (aTDCNumber = 1) or (aTDCNumber = 2) then
           TheTDC.CreateFormss(aTDCNumber)
        else
           TheTDC.CreateFormss(1);

        FMap := TheTDC.frmTengah.Map;
      end;
      //----------------------------------------------------------------------

    end;
     if Assigned(TheTDC)then begin
       TheTDC.TDCNumber := aTDCNumber;
       TheTDC.ShowAllForm;
       TheTDC.SetDefaultLayOut;
    end;
  end;

  procedure TTDCManager.CreateMinimalForms;
  begin
    frmMapWindow := TfrmMapWindow.Create(nil);
    FMap := frmMapWindow.Map;
    frmMapWindow.Show;
  end;

 //= NetWork Event handler =================================================
  procedure  TTDCManager.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
  var  sc  : TSimulationClass;
       obj : TClientObject;
       aRec: ^TRecData3DPosition;
  begin
    aRec := @apRec^;
    aRec.X := aRec.X + OffX_Map;
    aRec.Y := aRec.Y + OffY_Map;


    AddToMemoLog('pos : ' + dbID_to_UniqueID(aRec.ShipID)  + Format(' %2.6f, %2.6f',[aRec.X, aRec.Y]));

    if dbID_to_UniqueID(aRec.ShipID) = xShip.UniqueID then begin
      if not TheTDC.tdcData.DeadReconEnable then begin
        xShip.PositionX := aRec.X;
        xShip.PositionY := aRec.Y;
        xShip.PositionZ := aRec.Z;
        xShip.Speed    := aRec.speed;
        xShip.Heading  := aRec.heading;
      end;
    end
    else begin
      sc := MainObjList.FindObjectByUid(dbID_to_UniqueID(aRec.ShipID));

      if sc = nil then begin
       obj := TClientObject.Create;
       obj.UniqueID := dbID_to_UniqueID(aRec.ShipID);
       obj.Enabled := TRUE;
       MainObjList.AddObject(obj);
      end

      else
      obj := sc as TClientObject;
      obj.PositionX := aRec.X;
      obj.PositionY := aRec.Y;
      obj.PositionZ := aRec.Z;
      obj.Speed     := aRec.speed;
      obj.Heading   := ConvCompass_To_Cartesian(aRec.heading);
    end;
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure  TTDCManager.Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrder;
  begin
    aRec := @apRec^;
    AddToMemoLog(' RECV: '+C_ORDER_STR[aRec.OrderID] +
      ' to:' + aRec.ShipID);

    if aRec.ShipID = xShip.UniqueID then begin
      if Assigned(NetHandler[aRec.OrderID]) then begin
        NetHandler[aRec.OrderID](apRec, aSize);
      end
      else begin
        if (aRec.OrderID >0) and (aRec.OrderID <= C_Max_Order_ID) then
          AddToMemoLog(' Unhandled Order ID '+
          InttoStr(aRec.OrderID) + '  '+ C_ORDER_STR[aRec.OrderID] )
        else
          AddToMemoLog(' Unhandled Order ID '+ InttoStr(aRec.OrderID) );
      end;
    end
    else begin
      AddToMemoLog(' Not for me. ');
      // kecuali ntransfer antar kapal
    end;
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TTDCManager.Event_AssignHandler(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecOrderAssignment;
  begin
    aRec := @apRec^;

    AddToMemoLog(' +RECV: Order Assignment '
      + Format('%d %d -> %s', [aRec^.Ship_TID, aRec^.TrackNumber, aRec^.DetectedUID]));

    if Assigned(NetHandler[aRec.OrderID]) then
      NetHandler[aRec.OrderID](apRec, aSize)
    else
      AddToMemoLog(' Unhandled OrderAssignment '+ InttoStr(aRec.OrderID) );

  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TTDCManager.EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
var
      arMissile : ^TRec3DMissilePos;
      TipeMissile, status, tempUID: string;
//      ts        : LongWord;
      obj : TClientObject;
      shipID, WeaponID, launcherID, missileID, MissileNumber : integer ;
begin
//    CopyMemory(@aRec, apRec, aSize);

    arMissile := @apRec^;
    arMissile^.x := arMissile^.x + OffX_Map;
    arMissile^.y := arMissile^.y + OffY_Map;

    shipID        := arMissile^.shipID;
    WeaponID      := arMissile^.WeaponID;
    launcherID    := arMissile^.launcherID;
    missileID     := arMissile^.missileID;
    missileID     := arMissile^.missileID;
    MissileNumber := arMissile^.MissileNumber;

    case MissileNumber of
      C_DBID_ASROC        : TipeMissile := 'ASROC';
      C_DBID_RBU6000      : TipeMissile := 'RBU6000';
      C_DBID_TORPEDO_A244S: TipeMissile := 'TORPEDO_A244S';
      C_DBID_TORPEDO_SUT  : TipeMissile := 'TORPEDO_SUT';
      C_DBID_YAKHONT      : TipeMissile := 'YAKHONT';
      C_DBID_C802         : TipeMissile := 'C802';
      C_DBID_EXOCET_MM40  : TipeMissile := 'EXOCET_MM40';
      C_DBID_EXOCET_MM38  : TipeMissile := 'EXOCET_MM38';
    end;

    tempUID := dbID_to_MissileUniqueID( shipID, WeaponID, LauncherID, missileID, MissileNumber);

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

          status := 'Running';
        end
        else if arMissile^.status = ST_MISSILE_DEL then
        begin
          MainObjList.RemoveObject(tmpNewObj);
        end
        else if arMissile^.status = ST_MISSILE_HIT then
        begin
           status := 'Explode';
  //        MainObjList.RemoveObject(tmpNewObj);
        end;

        AddToMemoLog(' +RECV: ' + TipeMissile + ' is ' + status);
        AddToMemoLog('    Speed    :' + FloatToStr(arMissile^.speed) );
        AddToMemoLog('    Heading  :' + FloatToStr(arMissile^.heading) );
        AddToMemoLog('    XYZ      :' + Format('%3.8f, %3.8f, %3.8f', [arMissile^.X, arMissile^.Y, arMissile^.Z]));
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
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TTDCManager.dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                         MissileID, MissileNumber  : integer): string;
begin
    result := Format('%s%0.4d%0.2d%0.2d%0.2d%0.2d',['MSL', ShipID, WeaponID, LauncherID,
                                                    MissileID, MissileNumber]);
end;


procedure  TTDCManager.Event_RecDBOrderAvailable(apRec: PAnsiChar; aSize: integer);
  //var aRec: ^TRecDataOrder;
  //     swOn, swOff: boolean;
  begin
    {aRec := @apRec^;

    if (aRec.sOrder = ORD_DB_STT) then begin

    end
    else if (aRec.sOrder = ORD_DB_STF) then begin

    end;
    }
{    swOn  := (aRec.sOrder = ORD_DB_STT);
    swOff := (aRec.sOrder = ORD_DB_STF);

    if swOn xor swOff then begin

    end;
 }
  end;

// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_init_datum(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;

    TheTDC.SetInitDatum(aRec^ , false);
  end;

  procedure TTDCManager.Handle_FOC_plus(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.setFOCPlus(aRec^, false);
  end;

  procedure TTDCManager.Handle_FOC_minus(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.setFOCMinus(aRec^, false);
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TTDCManager.Handle_Change_Ident(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin // change ident bawah air, atas air, udara
    aRec := @apRec^;
    TheTDC.Recv_Ident_OWA(aRec^);
  end;

  procedure TTDCManager.Handle_select_radar_type(apRec: PAnsiChar;
    aSize: integer);
//  var aRec: ^TRecOrder;
  begin
//    aRec := @apRec^;
//    aRec.OrderByteParam;
  end;

// .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
  procedure TTDCManager.Handle_start_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if aRec^.OrderType < 10 then
      TheTDC.StartICMLeft(aRec^.OrderType, aRec^.X, aRec^.Y, FALSE)
    else
      TheTDC.StartICMRight(aRec^.OrderType, aRec^.X, aRec^.Y, FALSE);
  end;

  procedure TTDCManager.Handle_update_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.UpdateICMPos(aRec^.OrderType,  aRec^.X, aRec^.Y);
  end;

  procedure TTDCManager.Handle_end_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if aRec^.OrderType < 10 then
      TheTDC.EndICMLeft(aRec^.OrderType, FALSE)
    else
      TheTDC.EndICMRight(aRec^.OrderType, FALSE);
  end;

  procedure TTDCManager.Handle_assign_tor(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTDC.SetAssignTorpedo_MK44(aRec^, false);
  end;

  procedure TTDCManager.Handle_deassign_tor(apRec: PAnsiChar;
    aSize: integer);
//  var aRec: ^TRecOrder;
  begin
//    aRec := @apRec^;
    TheTDC.SetDeAssignTorpedo(false);
  end;

  // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_assign_asrl(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTDC.setAssignASRL(aRec^,4, false);
  end;

  procedure TTDCManager.Handle_deassign_asrl(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTDC.setDeAssignASRL(aRec^, false);
  end;

  // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_WIPE(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.RecvWIPE(aRec^);
  end;
// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_init_ram(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTdc.InitiateRAM(aRec^, false);
  end;

  procedure TTDCManager.Handle_init_auto(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTdc.InitiateAuto(aRec^, false);
  end;

  procedure TTDCManager.Handle_init_dr(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTdc.InitiateDR(aRec^, false);
  end;

  procedure TTDCManager.Handle_assign_ram(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheTDC.RecvAssignRAM(aRec^);
  end;

  procedure TTDCManager.Handle_assign_FC(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecFireControlOrder;
  begin
    aRec := @apRec^;
    case TOrdType_FC_command(aRec^.FC_command) of
       RATO, RSTO,
       ATO, STO   : TheTDC.RecvAssign_FC(aRec^);
       Open_Fire  : TheTDC.SetOpenFire_FC(aRec^.FC_number, FALSE);
       Hold_Fire  : TheTDC.SetHoldFire_FC(aRec^.FC_number, FALSE);
       GenFix     : TheTDC.RecvAssign_GenFiX(aRec^);
       BlindBomb  : TheTDC.RecvAssign_BlindBomb(aRec^);
       AssignTrackSs : TheTDC.RecvAssign_FC(aRec^);
//       InitTrackSurf  : TheTDC.RecvInitiateTrack(aRec^);
    end;
  end;

  procedure TTDCManager.Handle_deassign_FC(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecFireControlOrder;
  begin
    aRec := @apRec^;
    //SBS, SBA
    TheTDC.RecvDeAssign_FC(aRec^);
  end;

  procedure TTDCManager.Handle_assign_SSM(apRec: PAnsiChar; aSize: integer);
  var aRec : ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.setAssignSSM(aRec^, false);
  end;

  procedure TTDCManager.Handle_deassign_SSM(apRec: PAnsiChar;
    aSize: integer);
//  var aRec : ^TRecOrderXY;
  begin
//    aRec := @apRec^;
    TheTDC.setDeAssignSSM(false);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_init_esm_fix(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheTDC.SetInitESMFix(aRec^, false);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_Synch_timebase(apRec: PAnsiChar; aSize: integer);
  var aRec : ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if ActiveRadar.FRadarType = TRadar_type(aRec.OrderType) then begin
      ActiveRadar.TimeBase.AbsDirection := aRec^.X;
      ActiveRadar.TimeBase.Elevation    := aRec^.Y;
    end;
  end;

  procedure TTDCManager.SendSynchTimeBase;
  var aRec : TRecOrderXY;
  begin
    aRec.ShipID := xShip.UniqueID;

    aRec.X := ActiveRadar.TimeBase.AbsDirection;
    aRec.Y := ActiveRadar.TimeBase.Elevation;
    aRec.OrderType := Byte(ActiveRadar.FRadarType);
    aRec.OrderID := OrdID_Synch_timebase;
    NetComm.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_CorrectRam(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderAssignment;
  begin
    aRec := @apRec^;

    if aRec.ShipID = xShip.UniqueID then begin
      TheTDC.AssignTrackToDetected(aRec^.Ship_TID, aRec^.TrackNumber, aRec^.DetectedUID)
    end;
  end;

  procedure TTDCManager.Handle_UpdateTrackPosition  (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
     aRec := @apRec^;
     TheTDC.RecvUpdateTrackPosition(aRec^);
  end;

  {procedure TTDCManager.Handle_TrackRepos  (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
     aRec := @apRec^;
     //TheTDC.RecvTrackRepos_Owa(aRec^);
  end;}

  procedure TTDCManager.Handle_TrackSwitchPos  (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecGunControl;
  begin
     aRec := @apRec^;
     TheTDC.RecvChangeTrackPos(aRec^);
  end;


function TTDCManager.GetRepaintCycle: Word;
  begin
    result := FRepaintIL.Cycle;
  end;

  procedure TTDCManager.SetRepaintCycle(const Value: Word);
  begin
    FRepaintIL.Cycle := Value;
  end;

{procedure TTDCManager.Handle_assign_FC_WCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecFireControlOrder;
begin
  aRec := @apRec^;
  TheTDC.Recv_AssignFC_WCC(aRec^);
end;

procedure TTDCManager.Handle_deassign_FC_WCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecFireControlOrder;
begin
  aRec := @apRec^;
  TheTDC.OBM_DeAssignFC(aRec^, false);
end;
}
procedure TTDCManager.Handle_assign_gun_WCC(apRec: PAnsiChar; aSize: integer);
//var aRec: ^TRecGunControl;
begin
  //aRec := @apRec^;
  //TheTDC.AssignGunToFC(aRec.Gun_number, aRec.AssignedTo, False);
end;

procedure TTDCManager.Handle_deassign_gun_WCC(apRec: PAnsiChar; aSize: integer);
//var aRec: ^TRecFireControlOrder;
begin
  //aRec := @apRec^;
  //TheTDC.OBMRight_AssignFC(aRec^, false);
end;

procedure TTDCManager.Handle_assign_FC_OCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderAssignment;
begin
  aRec := @apRec^;
  TheTDC.OCC_AssignFC(aRec^);
end;

procedure TTDCManager.Handle_assign_engBox(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecTrackOrder;
begin
  aRec := @apRec^;
  TheTDC.SetHarpoonEngage(aRec^, false);
end;

procedure TTDCManager.Handle_init_track(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecXXXOrder;
begin
  aRec := @apRec^;
  case TOrdType_OWA_command(aRec^.temp1) of
     InitAir, InitSurf,
     InitSubRT, InitSubNRT  : TheTDC.RecvInitiateTrack(aRec^);
     AssLocRT               : TheTDC.AssignLocRT(aRec^, false);
     AssLocNRT              : TheTDC.AssignLocNRT(aRec^, false);
     AssRemote              : TheTDC.AssignRemote(aRec^, false);
  end;
end;

procedure TTDCManager.Handle_SetTrackLost(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecFireControlOrder;
begin
  aRec := @apRec^;
  TheTDC.SetTrackInLostMode(aRec^, False);
end;

procedure TTDCManager.Handle_init_point(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderXY;
begin
  aRec := @apRec^;
  TheTDC.SetInitPoint(aRec^, false);
end;

procedure TTDCManager.Handle_receive_sonar_owa(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecTrackOrder;
begin
  aRec := @apRec^;
  TheTDC.RecvSonarPositionData_OWA(aRec^);
end;

procedure TTDCManager.Handle_receive_link(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecLinkOrder;
begin
  aRec := @apRec^;
  TheTDC.RecvLink_OWA(aRec^);
end;

procedure TTDCManager.Handle_correlate_track(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecGunControl;
begin
  aRec := @apRec^;
  TheTDC.RecvCorrelateTrack(aRec^);
end;

procedure TTDCManager.Handle_decorrelate_track(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecGunControl;
begin
  aRec := @apRec^;
  TheTDC.RecvDecorrelateTrack(aRec^);
end;

procedure TTDCManager.Handle_UpdateTrackPosition_Owa(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecTrackOrder;
begin
   aRec := @apRec^;
   TheTDC.RecvUpdateTrackPos_Owa(aRec^);
end;

procedure TTDCManager.TurnOnOffRadar(const setOn: boolean);
begin
  ActiveRadar.Enabled  := setOn;
  SetAllLayerVisibility(FMap, setOn);
end;

procedure TTDCManager.Event_OnReceiveLink(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecLinkOrder;
begin
  aRec := @apRec^;

  if Assigned(NetHandler[aRec.OrderID]) then
    NetHandler[aRec.OrderID](apRec, aSize)
  else
    AddToMemoLog(' Unhandled OrderAssignment '+ InttoStr(aRec.OrderID) );
end;


// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
procedure TTDCManager.Event_RcvASRLPanelSetting(apRec: PAnsiChar; aSize: integer);
var aRec : ^TRecStatus_Console;
begin
  aRec := @apRec^;
  // cuman buat TDC OWA
  TheTDC.RecvASRLSetting(aRec^);
end;

procedure TTDCManager.Event_RcvHarpoonSetting(apRec: PAnsiChar;
  aSize: integer);
var aRec : ^TRecHarpoonPanelSetting;
begin
  aRec := @apRec^;
  // cuman buat TDC OWA
  TheTDC.RecvHarpoonSetting(aRec^);
end;

procedure TTDCManager.LoadKabehSetting;
var CurrentScenID : integer;
    Dm: TDataModule1;
    s,
    Server_Ip,Server_Port, TriD_IP, TriD_Port,
    DBServer, DBProto, DBName, DBUser, DBPass,
    ShipName, ClassName : string;
    ShipID, ClassID : Integer;
    Env_Map, n : integer ;
begin
    { added by sam }
    n := ParamCount ;
    if n < max_param then
    begin
      StandAloneMode := true ;
    end;
    { added by sam }
    if not StandAloneMode then  begin

      InitDefault_AllConfigFromInstruktur(Server_Ip,Server_Port,
      DBServer, DBProto, DBName, DBUser,
      DBPass, ShipID, CurrentScenID );

      if DataModule1.InitZDB(DBServer, DBProto, DBName, DBUser, DBPass) then
      begin
        ClassID  := DataModule1.GetShipType(ShipID, ClassName);
        ShipName := DataModule1.GetShipName(ShipID);
      end;
      Env_Map := DataModule1.GetMapById(CurrentScenID);
      DataModule1.GetOffsetMapByEnvMap(Env_Map ,OffX_Map, OffY_Map);

    end;

  {  TriD_IP :='192.168.1.42';
    TriD_Port :='5001';
   }
  with bridgeSet.mDB do begin
    mDBServer := DBServer;
    mDBProto  := DBProto;
    mDBName   := DBName;
    mDBUser   := DBUser;
    mDBPass   := DBPass;
  end;

  with bridgeSet.mServer do begin
    m2D_IP    := Server_Ip;
    m2D_Port  := Server_Port;
    m3D_IP    := TriD_IP;
    m3D_Port  := TriD_Port;
  end;

  with bridgeSet.mShip do begin
    mShipID   := ShipID;
    mClassID  := ClassID;
    mShipName := ShipName;
    mClassName:= ClassName;
    mScenario  := CurrentScenID;
  end;

  {
  // BACA SETTING DARI FILE bridgeset.ini
  bridgeSetPath := GetEmulatorSettingDirectory;
  with bridgeSet.mDB do
    InitDefault_DBConfig(bridgeSetPath,
      mDBServer, mDBProto, mDBName, mDBUser, mDBPass );

  with bridgeSet.mServer do
    InitDefault_GameServerConfig(bridgeSetPath,
      m2D_IP,  m2D_Port,
      m3D_IP,  m3D_Port);

  with bridgeSet.mShip do
    InitDefault_ShipConfig(bridgeSetPath,
      mShipID,   mClassID,
      mShipName, mClassName);
   }
 //==> masih  salah ==>    mShipName, mClassName belum di load

  InitConfig_Map(settingMap);
  InitConfig_TDC(settingTDC);
end;

procedure TTDCManager.GetAsrocWeaponAssigned;
var WeaponAssigned : TScenarioWeapon;
    ListWeaponAssigned : TList;
    I : Integer;
begin
  ListWeaponAssigned := TList.Create;
  if DataModule1.GetListWeaponOnShipBySceID( bridgeSet.mShip.mScenario , bridgeSet.mShip.mShipID , ListWeaponAssigned) > 0 then
  begin
     for I := 0 to ListWeaponAssigned.Count - 1 do begin
       WeaponAssigned := TScenarioWeapon.Create;
       WeaponAssigned := TScenarioWeapon(ListWeaponAssigned.Items[I]);
       if WeaponAssigned.WeaponID = C_DBID_ASROC then begin
          case WeaponAssigned.LauncherID of
            1 : begin
                  (TheTDC as TTDC_NalaInterface).Rocket1_Set_on := True;
                end;
            2 : begin
                  (TheTDC as TTDC_NalaInterface).Rocket2_Set_on := True;
                end;
          end;
       end;
       WeaponAssigned.Free;
     end;
  end;
  ListWeaponAssigned.Free;

   if (TheTDC as TTDC_NalaInterface).Rocket1_Set_on then
    AddToMemoLog('Lonc1 is assigned')
  else
    AddToMemoLog('Lonc1 is not assigned');

  if (TheTDC as TTDC_NalaInterface).Rocket2_Set_on then
    AddToMemoLog('Lonc2 is assigned')
  else
    AddToMemoLog('Lonc2 is not assigned');
end;

procedure TTDCManager.ApplyKabehSetting;
begin
  ServerIp   :=  bridgeSet.mServer.m2D_IP;
  ServerPort := bridgeSet.mServer.m2D_Port;

  xShip.UniqueID := dbID_to_UniqueID(bridgeSet.mShip.mShipID);

  xShip.PositionX := settingMap.X;
  xShip.PositionY := settingMap.Y;
  xShip.PositionZ := 0;


  ActiveRadar.PositionX := xShip.PositionX;
  ActiveRadar.PositionY := xShip.PositionY;
  ActiveRadar.PositionZ := xShip.PositionZ;

  TheTDC.shipt_tid  := settingTDC.TDCDefTrackNum;
  FTimebaseServer  := settingTDC.TDCTBServer = 1;
  if FTimebaseServer then
    NetHandler[OrdID_Synch_timebase       ] := NIL
  else
    NetHandler[OrdID_Synch_timebase       ] := Handle_Synch_timebase;

end;


end.



