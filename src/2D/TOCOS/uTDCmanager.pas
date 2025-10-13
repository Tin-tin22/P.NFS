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
    Dialogs,
//------------------------------------------------------------------------------
    uBaseDataType,
    uBaseSimulationObject,
    uBaseSensor,

    uLibRadar,

    uTCPClient,
    uTCPDatatype,


    uTestShip,
    uLibClientObject,

    uObjectView,
    uLibTDCClass,
    uLibTorpedo_Singa,
    uTorpedoTrack,
    overbyteICSWSocket,

    uSimulationManager, uMainCtrlPanel;

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

      procedure Handle_assign_torpedoSUT    (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_torpedoSUT  (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_asrl          (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_asrl        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_WIPE                 (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_ram    (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_auto       (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_dr       (apRec: PAnsiChar; aSize: integer);

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

      //gigih
//    procedure Handle_assign_FC_WCC        (apRec: PAnsiChar; aSize: integer);
//    procedure Handle_deassign_FC_WCC      (apRec: PAnsiChar; aSize: integer);
      procedure Handle_assign_gun_WCC       (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_gun_WCC     (apRec: PAnsiChar; aSize: integer);

      //mas sam
      procedure Handle_assign_FC_OCC        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_Fire_Torpedo_SUT   (apRec: PAnsiChar; aSize: integer);

      procedure  EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
      procedure  Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
      procedure  Event_AssignHandler(apRec: PAnsiChar; aSize: integer);

      procedure  EventOnReceiveTechnicalStatus(apRec: PAnsiChar; aSize: integer);

      procedure  EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
      procedure  Event_RecDBOrderAvailable(apRec: PAnsiChar; aSize: integer);
      procedure  Event_OnRecv_TorpDetecTarget(apRec: PAnsiChar; aSize: integer);

      procedure CreateShipForms(const aShipClassID, aTDCNumber: integer); virtual;
      procedure CreateMinimalForms;

    public
    // TDC parts..
      xShip       : TXShip;         // kapal tempat Radar berada
      ShipID, ShipClassID, Env_Map : integer;
      ShipName, ShipClassName : string;
      UseDatabase: boolean;
      OffX_Map, OffY_Map : Double;
      ActiveRadar : TClientRadar;

      TheTDC      : TGenericTDCInterface;

      TDCNumber   : integer;
      FTimebaseServer : BOOLEAN;

      GameSetting : TGameSetting;

      isStandAlone : boolean;

      data_Path   : string;

      constructor Create; override;
      destructor Destroy; override;

      procedure InitializeSimulation;     override;
      procedure FinalizeSimulation;       override;

      //specialProcedure
      function LoadScenarioFromIniFile(const fIni: string): integer; override;
      procedure LoadObjectSetting(const fIni: string);
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
    uMapXFunction, uLibTDC_Nala, uLibTDC_Oswald, uLibTDC_Singa, uLibTDC_Rencong,
    uTDCConstan, uMapWindow, uDataModule, uBridgeSet;


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
      uSimulationManager.SimCenter.MainThread.Suspend;
      uSimulationManager.SimCenter.LoadGeoset('');
      uSimulationManager.SimCenter := nil;
      TDCSimCenter.Free;

    end;

    function UniqueID_To_dbID(const uid: string): integer;
    var s: string;
    begin
      s := Copy(uid, 4, Length(uid)-3);
      if s = '' then
      s:='0';
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

//--------------------------------------------------------------------------
//-- Simulation Implementation
  constructor TTDCManager.Create;
  var i: integer;
  begin
    inherited;
    data_Path           := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
    FGameDelayInterval  := 1;
    FRepaintIL.Cycle    := 1; //3

    UniqueIdFactory := random(10);
    FTDC_OffCenter  := TRUE;

    GamePlayMode := pmStandAlone;

    FShipUpdateIL.Counter := 1;
    FShipUpdateIl.Cycle   := 29;   //10ms * 30

    FRadarUpdateIL.Counter := 2;
    FRadarUpdateIL.Cycle   := 297;


    SetLength(NetHandler, C_Max_Order_ID + 1);
    for i := 1 to C_Max_Order_ID do begin
      NetHandler[i] := nil;
    end;

//    NetHandler[OrdID_init_datum] := Handle_init_datum;

    NetHandler[OrdID_select_radar_type    ] := Handle_select_radar_type ;
    NetHandler[OrdID_start_ICM            ] := Handle_start_ICM ;
    NetHandler[OrdID_update_ICM           ] := Handle_update_ICM ;
    NetHandler[OrdID_end_ICM              ] := Handle_end_ICM ;
    NetHandler[OrdID_init_datum           ] := Handle_init_datum ;

    NetHandler[OrdID_FOC_plus             ] := Handle_FOC_plus ;
    NetHandler[OrdID_FOC_minus            ] := Handle_FOC_minus ;

    NetHandler[OrdID_Change_ident         ] := Handle_Change_Ident ;
{
    NetHandler[OrdID_ident_bawah_air      ] := Handle_ident_bawah_air ;
    NetHandler[OrdID_ident_atas_air       ] := Handle_ident_atas_air ;
    NetHandler[OrdID_ident_udara          ] := Handle_ident_udara;
}
    NetHandler[OrdID_assign_tor           ] := Handle_assign_tor ;
    NetHandler[OrdID_deassign_tor         ] := Handle_deassign_tor ;
    NetHandler[OrdID_assign_asrl          ] := Handle_assign_asrl ;
    NetHandler[OrdID_deassign_asrl        ] := Handle_deassign_asrl ;
    NetHandler[OrdID_WIPE                 ] := Handle_WIPE ;

    NetHandler[OrdID_init_ram    ]        := Handle_init_ram ;
{    NetHandler[OrdID_init_ram_udara       ] := Handle_init_ram_udara;
}
    NetHandler[ OrdID_init_auto           ] := Handle_init_auto ;
    NetHandler[ OrdID_init_DR             ] := Handle_init_DR ;
    NetHandler[OrdID_assign_ram           ] := Handle_assign_ram ;


    NetHandler[OrdID_assign_SSM           ] := Handle_assign_SSM ;
    NetHandler[OrdID_deassign_SSM         ] := Handle_deassign_SSM ;
    NetHandler[OrdID_init_esm_fix         ] := Handle_init_esm_fix ;

    NetHandler[OrdID_Synch_timebase       ] := Handle_Synch_timebase;

    NetHandler[OrdID_CorrectRAM           ] := Handle_CorrectRam;
    NetHandler[OrdID_UpdateTrackPos       ] := Handle_UpdateTrackPosition;

    NetHandler[OrdID_assign_FC            ] := Handle_assign_FC ;
    NetHandler[OrdID_deassign_FC          ] := Handle_deassign_FC ;

//    NetHandler[OrdID_assign_FC_WCC        ] := Handle_assign_FC_WCC ;
//    NetHandler[OrdID_deassign_FC_WCC      ] := Handle_deassign_FC_WCC ;

    NetHandler[OrdID_assign_gun           ] := Handle_assign_gun_WCC ;
    NetHandler[OrdID_assign_FC_OCC        ] := Handle_assign_FC_OCC ;
    NetHandler[ORD_3D_TORPEDO_SUT_FIRED   ] := Handle_Fire_Torpedo_SUT;
    NetHandler[OrdID_assign_torpedoSUT    ] := Handle_assign_torpedoSUT;
    NetHandler[OrdID_deassign_torpedoSUT  ] := Handle_deassign_torpedoSUT;
  end;

  destructor TTDCManager.Destroy;
  begin
    SetLength(NetHandler, 0);

    inherited;
  end;


  procedure TTDCManager.EventOnMainTimer(const dt: double);
  var i : Integer;
  begin

    for i := 0 to FSpeedMultiplier-1  do begin
      // update time
      MainGameTimer.IncreaseMillisecond(dt);

      // call move memb/e/r

//      if GamePlayMode = pmStandalone then begin
        MoveMember(dt);
        xShip.Run(dt);         // xShip is Moving;
//      end;

      if Assigned(ActiveRadar) then
      begin
        ActiveRadar.PositionX := xShip.PositionX;
        ActiveRadar.PositionY := xShip.PositionY;
        ActiveRadar.PositionZ := xShip.PositionZ;

        ActiveRadar.Direction := xShip.Heading;

        ActiveRadar.Run(dt);     // radar is rotating @ processing signal
        ActiveRadar.RadarProcess(MainObjList, MainGameTimer.GetMillisecond, true);
        ActiveRadar.DetObjects.RunAllMemberObject(dt);

      end;
      TheTDC.LastUpdateCounter :=  MainGameTimer.GetMillisecond;
      TheTDC.Run(dt);
    end;
    // end of for

    if (FShipUpdateIL.Counter = 0) or (FShipUpdateIL.Cycle = 0) then begin

      TheTDC.OwnShipMarker_SetPosition(xShip.PositionX, xShip.PositionY);

      TheTDC.Walk;

      if TheTDC. CU_ORStatus = stCU_OR_CENT then begin
//       TheTDC.Cursorss.Org.X  := xShip.PositionX;
//       TheTDC.Cursorss.Org.Y  := xShip.PositionY;
        TheTDC.Cursorss.SetStartCoord(xShip.PositionX, xShip.PositionY);
      end;

      if not TheTDC.TRUEMOTION then begin
        Fmap.CenterX := xShip.PositionX;
        Fmap.CenterY := xShip.PositionY;
        FMap.Rotation := 0;
      end
      else
      begin
        FMap.Rotation := -xShip.Heading;
      end;

    end;
    if (FShipUpdateIL.Cycle > 0) then
      FShipUpdateIL.Counter := (FShipUpdateIL.Counter + 1) mod FShipUpdateIL.Cycle;

    if (FRadarUpdateIL.Counter = 0) or (FRadarUpdateIL.Cycle = 0) then begin
      if FTimebaseServer then
        SendSynchTimeBase;
    end;
    if (FRadarUpdateIL.Cycle > 0) then
      FRadarUpdateIL.Counter := (FRadarUpdateIL.Counter + 1) mod FRadarUpdateIL.Cycle;

    // proses yg tidak termasuk gamespeed multiplier:
    // call Draw member

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

    // Send Update Bearing if User Bearing or Prediction Intercept else manually
    // Use TheTDC


      {Update Mode Via Andu saja : bagoes}
//    if TheTDC.TOCOSSysON then
//    begin
//      TheTDC.UpdateByModeTORP;
//    end;

    CleanUpMember;
    Application.ProcessMessages;

  end;

  procedure TTDCManager.InitializeSimulation;
  var fName: string;
  begin
    inherited;

    {For Weapon}
    NetComm.RegisterProcedure(REC_3D_TORPEDO_SUT,        Event_OrderRecognizer,           sizeof(TRecSetTorpedoSUT));
    NetComm.RegisterProcedure(C_REC_FIRE_CONTROL,        Event_OrderRecognizer,           sizeof(TRecFireControlOrder));

    {Position}
    NetComm.RegisterProcedure(REC_3D_POSITION,           EventonReceiveDataPosition,      sizeof(TRecDataPosition));
    NetComm.RegisterProcedure(REC_3D_MISSILEPOS,         EventonRecMissilePosAvailable,   sizeof(TRecMissilePos));

    {Lain-lain}
    {For Reconnect}
    NetComm.RegisterProcedure(REC_2D_ORDER,              nil,                             sizeof(TRecData2DOrder));

    NetComm.RegisterProcedure(C_REC_ORDER,               Event_OrderRecognizer,           sizeof(TRecOrder)) ;
    NetComm.RegisterProcedure(C_REC_ORDER_XY,            Event_OrderRecognizer,           sizeof(TRecOrderXY)) ;
    NetComm.RegisterProcedure(C_REC_TRACK_ORDER,         Event_OrderRecognizer,           sizeof(TRecTrackOrder));
    NetComm.RegisterProcedure(C_REC_ORDER_ASSIGNMENT,    Event_AssignHandler,             sizeof(TRecOrderAssignment));
    NetComm.RegisterProcedure(C_REC_GUN_CONTROL,         Event_OrderRecognizer,           sizeof(TRecGunControl));

    {Console}
    NetComm.RegisterProcedure(REC_EVENT_LOG,             nil,                             sizeof(TRecEventLog));

    // Register Technical Update Status : Aldy
    NetComm.RegisterProcedure(REC_STAT_ORDER_CONSOLE,   EventOnReceiveTechnicalStatus,    sizeof(TRecStatus_Console));

    {For Detect Target}
    NetComm.RegisterProcedure(REC_RECV_TORP_STATE,      Event_OnRecv_TorpDetecTarget,     sizeof(TRec_TorpStatus));

    fname := data_Path + 'data\Scenario\TDCSinga.ini';

    LoadScenarioFromIniFile(fname);

    ActiveRadar   := TClientRadar.Create;
    ActiveRadar.CreateDefaultView(FMap);

    ActiveRadar.PolarView.RangeMax := 128.0;

    TurnOnOffRadar(False);

    xShip       := TXShip.Create;
    xShip.CreateDefaultView(Fmap);

    //procedure titip;
    TheTDC.FMap := FMap;
    TheTDC.xSHIP := xShip ;
    TheTDC.ActiveRadar := ActiveRadar;
    TheTDC.SetRadar_type(rtWM_28);
    TheTDC.SetRadar_Amplification(raLiner);
    TheTDC.SetRadar_MTI_Status(FALSE);

    TheTDC.netSend := NetComm;
    TheTDC.HaveToSend := GamePlayMode = pmModeClient;

    LoadObjectSetting(fname);

    xShip.Enabled := TRUE;

    if Assigned(TheTDC) then begin
      TheTDC.Initialize;
    end;
  end;

  procedure TTDCManager.FinalizeSimulation;
  begin
{    NetComm.RegisterProcedure(
      REC_POSITION, nil, SizeOf(TRecDataPosition));
}
    xShip.Free;
    ActiveRadar.Free;

    if Assigned(TheTDC) then TheTDC.Destroy;

    inherited;
  end;

function TTDCManager.LoadScenarioFromIniFile(const fIni: string): integer;
var
  IniF                      :TIniFile;

  readStr, fName,
  pServer_Ip,pServer_Port,
  pDBServer, pDBProto,
  pDBName, pDBUser, pDBPass : string;

  readInt, n, pShipID,
  pCurrentScenID            : integer;



begin // di sini CreateForm dan Load Map
  // sebaiknya diubah, load setting aja simpan ke variabel GameSetting,
  // setelah semua di load baru di execute.
    if FIni = '' then
      FName := Copy(ExtractFilePath(Application.ExeName),1,Length(ExtractFilePath(Application.ExeName))-4) + 'data\Scenario\TDCScene.ini'
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

    // ini yg baca dari parameter

    { added by sam }
    isStandAlone := false;
    n := ParamCount ;
    if n < max_param then
      isStandAlone := True;
    { added by sam }
    if not isStandAlone then begin
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
        pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID);
    //. multiplayer section . . . .
    ServerIp  := pServer_Ip;
    ServerPort:= pServer_Port;

    end;
    //. Game Section . . . . .
    readInt := IniF.ReadInteger(C_game_sect, C_playmode_id, 0);
    GamePlayMode := TPlayMode(readInt);
    if GamePlayMode = pmModeClient then
      AddToMemoLog(' .Net Client.')
    else
      AddToMemoLog(' .Alone.');


    GameSetting.TargetFile :=  Inif.ReadString(C_game_sect,'target', '');

    ShipID := pShipID;

    readInt := Inif.ReadInteger(C_Ship_section, 'tdcnumber', 1);
    TDCNumber   := readInt;

    UseDatabase := True;

    if (not UseDatabase) or (isStandAlone) then begin
      ShipClassID := Inif.ReadInteger(C_Ship_section, 'classid', -1);
      CreateShipForms(ShipClassID, TDCNumber);

    end
    else begin
      if ( ShipID <> -1)then begin
        DataModule1.EmuConn.HostName := pDBServer;
        DataModule1.EmuConn.User := pDBUser;
        DataModule1.EmuConn.Password := pDBPass;
        DataModule1.EmuConn.Database := pDBName;
        DataModule1.EmuConn.Connect;

        //get offset by scenario;
//       GetSceneOffSetFromPortID(pCurrentScenID, mapOffsetX, mapOffsetY);
        Env_Map := DataModule1.GetMapById(pCurrentScenID);
        DataModule1.GetOffsetMapByEnvMap(Env_Map ,OffX_Map, OffY_Map);

        ShipName    := DataModule1.GetShipName(ShipId);
        ShipClassID := DataModule1.GetShipType(ShipId, ShipClassName);

        AddToMemoLog(' ShipID      = ' + IntToStr(ShipID) );
        AddToMemoLog(' ShipClassId = ' + IntToStr(ShipClassID) );

        AddToMemoLog(' ShipName ' + ShipName );
        AddToMemoLog(' ShipClassName ' + ShipClassName );

        CreateShipForms(ShipClassID, TDCNumber);

      end
      else begin
        AddToMemoLog('Error ShipID = '+ IntToStr(ShipID) );
        AddToMemoLog('Can not acquire data from db');
        CreateMinimalForms; // form tengah (map)di sini
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

  procedure TTDCManager.LoadObjectSetting(const fIni: string);
  var IniF:TIniFile;
      readDbl : double;
      fName : string;
      readInt : integer;

      RecSend : TRecData2DOrder;
  begin // di sini CreateForm dan Load Map
//    if FIni = '' then
//      FName := ExtractFilePath(Application.ExeName) + 'Scenario\TDCScene.ini'
//    else
      FName := FIni;

    if FileExists(FName) then
      AddToMemoLog('Load Setting '+ FName)
    else begin
      AddToMemoLog('Error:  "' +FName+ '" is not Exist');
      exit;
    end;

    IniF   := TIniFile.Create(FName);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    xship.Speed    := IniF.ReadFloat(C_Ship_section, C_speed_id,  0.0 );
    xship.Heading  := IniF.ReadFloat(C_Ship_section, C_heading_id,  0.0 );
    //xship.UniqueID := Inif.ReadString(C_Ship_section, 'thisshipid', 'flyingdutchman');
    {abli dari paramenter}
    xShip.UniqueID := dbID_to_UniqueID(ShipID);

    TheTDC.shipt_tid := IniF.ReadInteger(C_Ship_section, 'deftracknumber', 61);

    readDbl  := IniF.ReadFloat(C_Ship_section, C_posx_id,  0.0 );
    if  IsZero(readDbl) then
      xship.PositionX := FMap.CenterX
    else
      xship.PositionX := readDbl;

    readDbl  := IniF.ReadFloat(C_Ship_section, C_posy_id,  0.0 );
    if  IsZero(readDbl) then
      xship.PositionY := FMap.CenterY
    else
      xship.PositionY := readDbl;


    readDbl  := IniF.ReadFloat(C_Ship_section, C_posz_id,  0.0 );
    xship.PositionZ := readDbl;

    FMap.ZoomTo(64.0, xShip.PositionX, xShip.PositionY);

    //. WM_ radar section . . . .
    ActiveRadar.PositionX := xShip.PositionX;
    ActiveRadar.PositionY := xShip.PositionY;
    ActiveRadar.PositionZ := xShip.PositionZ;


    ActiveRadar.Frequency      := IniF.ReadFloat(C_wmradar_Section, C_freq_id, 9000.0 );
 //   ActiveRadar.PRF         := IniF.ReadFloat(C_wmradar_Section, C_prf_id,  3000.0 );

    readDbl := IniF.ReadFloat(C_wmradar_section, C_range_id,  32.0 );;
    TheTDC.SetView_RangeScale(readDbl);

    ActiveRadar.PulseWidth  := IniF.ReadFloat(C_wmradar_Section, C_pw_id, 0.05);
    ActiveRadar.AveratePower := Inif.ReadFloat(C_wmradar_Section, C_avpow_id, 21.0);


    ActiveRadar.LastTrackNumber := ShipID * 100;

    //. multiplayer section . . . .
    if GamePlayMode = pmModeClient then begin

      if not isStandAlone then
      begin
        readInt := IniF.ReadInteger(C_mult_sect, 'autoconnect', 0);
        if readInt = 1 then begin
          AddToMemoLog('Connecting to: '+ ServerIp + ' '+ ServerPort);
          netComm.Connect(ServerIp, ServerPort);
        end;

        readInt := IniF.ReadInteger(C_mult_sect, 'timebaseserver', 0);
        if readInt = 1 then begin
          AddToMemoLog('timebase synch server');
          FTimebaseServer := TRUE;
          NetHandler[OrdID_Synch_timebase       ] := NIL
        end
        else begin
          FTimebaseServer := FALSE;
          NetHandler[OrdID_Synch_timebase       ] := Handle_Synch_timebase;
        end;
      end;

      if NetComm.State = wsconnected then
      begin
        //req sync pakcet
        RecSend.orderID := _CM_REQ_SYNCPACKET;
        RecSend.numValue := 0;
        RecSend.strValue := '';
        RecSend.strValue2 := '';
        RecSend.strValue3 := '';
        RecSend.ipConsole := '';
        NetComm.sendDataEx(REC_2D_ORDER, @RecSend);
      end;
    end;

    if GameSetting.TargetFile <> '' then
      LoadTarget(GameSetting.TargetFile);

  end;

  procedure TTDCManager.LoadTarget(const fIni: string);
  var IniF:TIniFile;
      i   : integer;
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


  procedure TTDCManager.LoadScenario;
  begin
{    // kondisi map sudah di load.
} end;

  procedure TTDCManager.UnLoadScenario;
  begin
     MainObjList.ClearObject;
     MainViewList.ClearObject;
     netComm.Disconnect;
     ///LoadGrid('');
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
//    ActiveRadar.DrawViews (aCnv);
    ActiveRadar.ViewContainer.DrawAllView(aCnv);

    ActiveRadar.DrawObjects(aCnv);

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

        if (aTDCNumber = 1) or (aTDCNumber = 2) then
           TheTDC.CreateFormss(aTDCNumber);

        FMap := TheTDC.frmTengah.Map;

      end;
      //----------------------------------------------------------------------
      C_ShipC_Mandau     : begin      //Rencong
        TheTDC := TTDC_Rencong.Create;

        if (aTDCNumber = 1) then
           TheTDC.CreateFormss(aTDCNumber);

        FMap := TheTDC.frmTengah.Map;
      end;

      //----------------------------------------------------------------------
      C_ShipC_Singa      : begin       // fpb singa
        TheTDC := TTDC_Singa.Create;

        if (aTDCNumber = 1) then
           TheTDC.CreateFormss(aTDCNumber);

        FMap := TheTDC.frmTengah.Map;

      end;

      //----------------------------------------------------------------------
      C_ShipC_AhmadYani  : begin  // Oswald Siahaan
        TheTDC := TTDC_Oswald.Create;
        FMap := TheTDC.frmTengah.Map;

        if (aTDCNumber >= 1) and (aTDCNumber <= 4)then
           TheTDC.CreateFormss(aTDCNumber);
{        if aTDCNumber = 1 then

        else
          if aTDCNumber = 2 then
        TheTDC := TTDC_Oswald_2.Create;
}     end;
      //----------------------------------------------------------------------
{      C_ShipC_Sigma      : begin
        TheTDC := TTDC_Sigma.Create;
        FMap := TheTDC.frmTengah.Map;
      end;}
    end;
     if Assigned(TheTDC)then begin
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

    {Conver to 3D to map}
    aRec^.x := aRec^.x + OffX_Map;
    aRec^.y := aRec^.y + OffY_Map;

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

       MainObjList.AddObject(obj);
      end
      else {klo nemu di update}
        obj := sc as TClientObject;
        obj.PositionX := aRec.X;
        obj.PositionY := aRec.Y;
        obj.PositionZ := aRec.Z;
        obj.Speed    := aRec.speed;
        obj.Heading  :=ConvCompass_To_Cartesian(aRec.heading);
      //***
    end;
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TTDCManager.Event_OnRecv_TorpDetecTarget(apRec: PAnsiChar;
aSize: integer);
  var aRec: ^TRec_TorpStatus;
begin
  aRec := @apRec^;
    AddToMemoLog(' RECV: '+ C_REC_PACKETNAME[REC_RECV_TORP_STATE] +' to:' + dbID_to_UniqueID(aRec.ShipID));

  TheTDC.RecvTorpSUTStatus(aRec^);
end;

procedure  TTDCManager.Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
  var
//    pc : TPacketCheck;
    aRec: ^TRecOrder;
//    aRec2 : ^TRecSetTorpedoSUT;
begin
    aRec := @apRec^;
    AddToMemoLog(' RECV: '+C_ORDER_STR[aRec.OrderID] +
      ' to:' + aRec.ShipID);
//
//    CopyMemory(@pc, apRec, sizeof(TPacketCheck));
//    if pc.ID = REC_3D_TORPEDO_SUT then
//    begin
//      aRec2 := @apRec^;
//      aRec^.ShipID
//    end;

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

  /// <summary>
  /// Receive from server to update technical display status
  /// </summary>
  /// <param name="apRec"></param>
  /// <param name="aSize"></param>
  procedure TTDCManager.EventOnReceiveTechnicalStatus(apRec: PAnsiChar; aSize: integer);
  var
    aRec : ^TRecStatus_Console;
  begin
    aRec := @aprec^;
    AddToMemoLog(' +RECV: Order Update Technical Display -> Ship ID : ' +  aRec^.OWN_SHIP_UID + ' Error ID : ' + IntToStr(aRec^.ErrorID) + ' Value : ' + IntToStr(aRec^.ParamError));

    // added by Aldy
    TheTDC.RecvUpdateTechnicalConsole(aRec^);
  end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TTDCManager.EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
var
  aRec        : TRecMissilePos;
  arMissile   : ^TRec3DMissilePos;
  Crs, Depth  : Double;
  obj         : TClientObject;

  shipID,WeaponID, launcherID, missileID, missileNumber : integer ;

  status, tempUID : string;


begin
  CopyMemory(@aRec, apRec, aSize);

  arMissile := @apRec^;

  shipID        := arMissile^.shipID ;
  WeaponID      := arMissile^.WeaponID ;
  launcherID    := arMissile^.launcherID;
  missileID     := arMissile^.missileID;
  missileNumber := arMissile^.MissileNumber;

  Crs           := arMissile^.heading;
  Depth         := arMissile^.z;

  tempUID := dbID_to_MissileUniqueID(shipID, WeaponID, launcherID, missileID, missileNumber);

  arMissile^.x := arMissile^.x + OffX_Map;
  arMissile^.y := arMissile^.y + OffY_Map;

  tmpNewObj := MainObjList.FindObjectByUid(tempUID);

  //Loading Handle
  if (shipID = UniqueID_To_dbID(xShip.UniqueID) ) and (WeaponID = C_DBID_TORPEDO_SUT) then
  begin
    if arMissile^.status = ST_MISSILE_LOADED then
      TTorpedoInterface(TheTDC).vMainCtrlPanel.LoadingStatus(launcherID, tsLoading)

    else if arMissile^.status = ST_MISSILE_DEL then
      TTorpedoInterface(TheTDC).vMainCtrlPanel.LoadingStatus(launcherID, tsOff)

    else if arMissile^.status = ST_MISSILE_RUN then
      TTorpedoInterface(TheTDC).vMainCtrlPanel.LoadingStatus(launcherID, tsLaunch)

  end;

  //Create Object On Radar
  if Assigned(tmpNewObj) then // UPDATE
  begin
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
  end
  else
  begin
    if arMissile^.status = ST_MISSILE_RUN then
    begin
      //CREATE NEW
      obj := TClientObject.Create;
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

  if WeaponID = C_DBID_TORPEDO_SUT then
  begin
    TheTDC.Update_TorpedoSUT_Position(arMissile^.launcherID, arMissile^.X, arMissile^.Y, arMissile^.heading, arMissile^.status, arMissile^.speed, Crs, Depth);
    AddToMemoLog(' +RECV: TORPEDO '+ InttoStr(arMissile^.launcherID) + ' is ' + status + ' 1/RUN, 2/HIT, 3/DELETE');
    AddToMemoLog('    Speed    :' + FloatToStr(arMissile^.speed) );
    AddToMemoLog('    Heading  :' + FloatToStr(arMissile^.heading) );
    AddToMemoLog('    XYZ      :' + Format('%3.8f, %3.8f, %3.8f', [arMissile^.X, arMissile^.Y, arMissile^.Z]));
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  procedure  TTDCManager.Event_RecDBOrderAvailable(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecData3DOrder;
//       swOn, swOff: boolean;
  begin
    aRec := @apRec^;

    if (aRec.sOrder = ORD_DB_STT) then begin

    end
    else if (aRec.sOrder = ORD_DB_STF) then begin


    end;
{    swOn  := (aRec.sOrder = ORD_DB_STT);
    swOff := (aRec.sOrder = ORD_DB_STF);

    if swOn xor swOff then begin

    end;   }
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
    TheTDC.Recv_Ident(aRec^);
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
    TheTDC.setAssignASRL(aRec^, false);
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
       InitTrackSurf  : TheTDC.RecvInitiateTrack(aRec^);
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

  procedure TTDCManager.Handle_CorrectRam     (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderAssignment;
  begin
    aRec := @apRec^;

    if aRec.ShipID = xShip.UniqueID then begin
      TheTDC.AssignTrackToDetected(aRec^.Ship_TID, aRec^.TrackNumber, aRec^.DetectedUID)
    end;
  end;

  procedure TTDCManager.Handle_UpdateTrackPosition (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
     aRec := @apRec^;
     TheTDC.RecvUpdateTrackPosition(aRec^);
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
//  aRec := @apRec^;
  aRec := @apRec^;
  TheTDC.OCC_AssignFC(aRec^);
end;

procedure TTDCManager.Handle_Fire_Torpedo_SUT(apRec: PAnsiChar; aSize: integer);
begin
  TheTDC.FireTorp_SUT;
end;

procedure TTDCManager.TurnOnOffRadar(const setOn: boolean);
begin
 ActiveRadar.Radiate := setOn;
  ActiveRadar.Enabled := setOn;
  if not setOn then
    Fmap.BackColor := clBlack
  else
    Fmap.BackColor := clGray;
  SetAllLayerVisibility(FMap, setOn);

end;

procedure TTDCManager.Handle_assign_torpedoSUT(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderAssignment;
begin
   aRec := @apRec^;
   TheTDC.SetAssignTorpedo_SUT(aRec^, false);
end;

procedure TTDCManager.Handle_deassign_torpedoSUT  (apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderAssignment;
begin
   aRec := @apRec^;
   TheTDC.SetDeassignTorpedo_SUT(aRec^,false);
end;

end.









