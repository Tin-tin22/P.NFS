unit uMessageHandle;

interface

uses
  uNetHandle, uNetwork_Data_TCMS, uNFS_TCPDatatype, uSockDatatype, SysUtils, uTcmsData,
  uIDGenerator, uLibEvent, Classes;

type
  TMessage_Handling = class
  private
    FOnRoleChangeState : TOnRoleChange;
    FOnCreateICM : TOnCreateICM;
    FOnDesigtExocet : TOnDesigtExocet;
    FOnBreakExocet : TOnBreakExocet;
    FOnDeviceChangeState : TOnSetWpnAndSnsrState;
    FOnDataObject : TOnSyncData;
    FOnDataEmitter: TOnSyncData;
    FOnStateExocet : TOnSyncData;
    FOnChangeIdent : TOnSyncData;
    FFireExocet : TOnSyncData;
    FOnDataGun76 : TOnSyncData;
    FOnDataRadarMW08 : TOnSyncData;
    FOnDataAreaMW08 : TOnSyncData;

    FOnDataDecoySysMode : TOnSyncData;
    FOnDataDecoySim : TOnSyncData;
    FOnDataDecoyLauncher: TOnSyncData;
    FOnDataDecoyController: TOnSyncData;
    FOnDecoyLaunchQueue: TOnUpdateDecoyLaunchQueue;
    FOnDecoyFiringQueue: TOnUpdateDecoyFiringQueue;
    FOnDecoyFiring: TOnDecoyFiring;
    FOnDecoyLCC: TOnSyncData;
    FOnDecoyDesigOps: TOnSyncData;
    FOnDecoyAutoData: TOnSyncData;

    FOnInitDecoyFiring: TOnSyncData;

    FOnLirodSetting: TOnSyncData;

    FOnNavDataStationing: TOnSyncData;
    FOnStationingRefObj: TOnSyncData;

    FBCAddress : string;
    FGamePort : Integer;
    FOnBreak76 : TOnSyncData;
    FOnDesigt76 : TOnSyncData;
    FOnFire76 : TOnFire76;
    FOnDataTetral : TOnSyncData;
    //new data tetral
    FOnDataTetral2 : TOnSyncData;
    FOnBreakTetral : TOnSyncData;
    FOnDesigtTetral : TOnSyncData;
    FSessionID: Integer;
    FOnLibraryChange: TOnLibraryChange;
    FOnTSMCChange : TOnSyncData;
    FIDShipSigma : string;
    FOnFireTetral : TOnSyncData;
    FOnDesigtA244: TOnSyncData;
    FOnBreakA244: TOnSyncData;
    FOnDataA244: TOnSyncData;
    FOnSyncDataObj: TOnSyncData;
    FOnDataTubeContent: TOnSyncData;
    FLeader: Boolean;
    FMOCName: Integer;
    FImageName: string;
    FImagePath: string;
    FOnDataNGS: TOnSyncData;
    FOnEngageManualTrack: TOnSyncData;
    FOnDataPAC: TOnSyncData;
    FOnSnapshotData: TOnSyncData;
    FOnGetTCMSIsON : TOnSyncData;
    FOnGetGICSetting : TOnSyncData;
    FOnSonarSync: TOnSyncData;
    FOnSyncScenario : TOnSyncScenario;
	  FOnDataEnvironment: TOnSyncData;
    FOnTrackDetect: TOnSyncData;
    FOnTrackShift: TOnSyncData;
    FOnFireTorpedoSPS : TOnSyncData;
    FOnFireTorpedoA244 : TOnSyncData;
    FOnChangeTrackDesc: TOnSyncData;
    FOnSetSonarEnvi: TOnSyncData;
    FOnSetTorpedoConfirmTarget : TOnSyncData;
    FOnTrackMovement : TOnSyncData;
    FOnIDGenerator : TOnSyncData;

    FOnRcvMOC_Online_Check: TOnSyncData;
    FAckCode: string;
    FOnDataNavRoute: TOnSyncData;
    FOnDataWPNavRoute: TOnSyncData;
    FOnDataManOverboard: TOnSyncData;
    FOnManOverboardPos: TOnSyncData;
    FOnDataPlanCordon: TOnSyncData;
    FOnPlanCordonTracks: TOnSyncData;
    FOnTrackPositioning: TOnSyncData;
    FOnNGSTarget: TOnSyncData;
	  FOnDataExocetTargetStatus: TOnSyncData;
    FOnDataPlanMissile : TOnSyncData;
    FOnDataMissileParameter : TOnSyncData;
    FOnDataFiringSquence : TOnSyncData;
    FOnDataExocetTargetObject : TOnSyncData;
	  FOnDataTDS: TOnSyncData;
    FOnTdsStbd: TOnSyncData;
    FOnTdsPort: TOnSyncData;
    FOnDataNavZigzag    : TOnSyncData;
    FOnDataPLNavZigzag  : TOnSyncData;
    FOnDataZigzagCatalogueValue : TOnSyncData;

    {sps}
    FOnMissilePos : TOnSyncData;

    {WASA related items}
    FOnDataWasa : TOnSyncData;
    FOnSelWasaChannel : TOnSyncData;
    FOnWasaChannelProp: TOnSyncData;
    FOnThreatEvalData : TOnSyncData;
    FOnTrkSelAirSetting : TOnSyncData;
    FOnEvalTracklist : TOnSyncData;

    {mail}
    FOnDataMail       : TOnSyncData;
    FOnDataMailValue  : TOnSyncData;
    FOnDataSentItemMail   : TOnSyncData;
    {status Mail}
    FOnDataStatusMail : TOnSyncData;

    FOnDataTWS: TOnSyncData;
    FOnTargetPAC: TOnSyncData;
    FOnFACode: TOnSyncData;
    FOnMW08Simulator: TOnSyncData;
    FOnHoldfireReportDef: TOnSyncData;

    {ASW Danger Zones}
    FOnASWDangerZones : TOnSyncData;

    FOnECMEngagement  : TOnSyncData;
    FonECMSimulator   : TOnSyncData;
    FOnECMAuth        : TOnSyncData;
    FOnARPADetected : TOnSyncData;

    {EMCON -ica}
    FOnEmconPlan1          : TOnSyncData;
    FOnEmconPlan2          : TOnSyncData;

     {Throw Off Control}
    FOnThrowOffControl : TOnSyncData;

	  FOnMM40Movement: TOnSyncData;
    FOnTrackSources: TOnSyncData;
	  FOnGameSync : TOnSyncData;
    FOnSessionAvailble : TOnSyncData;
    FOnSectorScreenObject: TOnSyncData;
    FOnDataSectorScreen: TOnSyncData;

    {ESM Bearing Track Data}
    FOnDataESMBrnTrack: TOnSyncData;

    {IFF Simulator}
    FOnIFFSimulator : TOnSyncData;
    FOnIFFTranspondCtrl : TOnSyncData;
    FOnIFFTranspondMC : TOnSyncData;
    FOnIFFInterrogations : TOnSyncData;
    FOnDataIFFPlot : TOnSyncData;
    FOnDataIFFPlotMonit : TOnSyncData;
    FOnDataIFFSectorsVisual : TOnSyncData;
    FOnDataIFFSectorsList : TOnSyncData;
//    FOnDataIFFPlotDisplay : TOnSyncData;

    FOn76mmBulletMovement: TOnSyncData;
    FOnTrackDataIFFCode : TOnSyncData;

    {Tactical Figure}
    FOnTrackMonitorData : TOnSyncData;

    {Tactical Figure}
    FOnSyncTacticalFigure : TOnSyncData;   //ga jadi

    FOnSyncListTactFigure : TOnSyncData;
    FOnSyncVisualTactFigure : TOnSyncData;
    FOnSyncVisualTactFigureGroup : TOnSyncData;
    FOnSyncVisualPolygon : TOnSyncData;
    FOnSyncVisualPolyline : TOnSyncData;

    {Geographic Situation}
    FOnSyncListGeoSituation : TOnSyncData;
    FOnSyncVisualGeo : TOnSyncData;
    FOnSyncVisualPolylineGeo : TOnSyncData;
    FOnSyncVisualPolygonGeo : TOnSyncData;

    {Area Alert}
    FOnSyncAreaAlert : TOnSyncData;
    FOnDataLIROD: TOnSyncData;
    FOnLirodSearchSector : TOnSyncData;
    FOnDataLIRODMK2: TOnSyncData;

    FOnLinkYSetting: TOnSyncData;
    FOnSonarRequest: TOnSyncData;
    FOnSonarStatus: TOnSyncData;
    FOnASWUnitIncluded : TOnSyncData;

    {OS Environment}
    FOnSyncDataMagneticVar : TOnSyncData;
    FOnSyncDataBarometric : TOnSyncData;
    FOnSyncDataHumidity : TOnSyncData;
    FOnSyncDataAirTemperature : TOnSyncData;
    FOnSyncDepthValue : TOnSyncData;
    FOnSyncDataWind : TOnSyncData;
    FOnSyncDataDrift : TOnSyncData;
    FOnSyncDataRelOSEnvi : TOnSyncData;
    FOnSyncDataEnviDateTime : TOnSyncData;

    FOnLogEvtStr: TGetStrProc;

//    // ESM Msg
//    FOnMsgDataMovement: TOnMsgSendDataMovement;

  protected
    NetHandle : TNetHandle;

    function CekIp(IPAddress: string): Boolean;
  public
    constructor create;
    destructor destroy; override;

  public
    procedure Initialize;
    procedure InitNetwork;

    procedure Send_MovementData(rec : TRec_Data_Movement);

    procedure Send_SyncData(aSpeed, Course, X, Y : Double);
    procedure Send_Req_Connect(aSpeed, Course, X, Y : Double);
    procedure Send_Change_Role(IDRole, IDUser : Byte; Status : Boolean);
    procedure Send_Change_Lib(IDLib : Byte; Status : Boolean);
    procedure Send_Data_ICM(RoleSender, RoleRecevier : Integer; PosX, PosY : Double);
    procedure Send_Desigt_Exocet(ObjectID, TargetID : Integer);
    procedure Send_Break_Exocet(ObjectID, TargetID : Integer);
    procedure Send_Device_State(ParentID, ObjectID : Integer; StateID : Byte);
    procedure Send_Data_Obj(objectIdx, objectID : Integer; OrderID, SenderForm, TacticalMode: Byte;
              EnterHook, EnterPosX, EnterPosY, EnterHeading, EnterTurnRate,
              EnterSpd, EnterAccel, EnterAltDepth, EnterCliDiveRate  : Boolean;
              ObjName, className, HookID : string; Identity : Byte; Speed, Heading, TurnRate, Acceleration, ClmbRate : Double;
              ImmediateSpd, ImmediateClm, ImmediateHdg : Boolean; PosX, PosY, PosZ : Double;
              IFFMode1, IFFMode2, IFFMode3 : Integer; IFFMode4 : Byte; IFFSpec : Byte); overload;
    procedure Send_Data_Emitter(rec: TRec_Emitter_Data);
    procedure Send_Data_Clear_Object;
    procedure Send_Data_Obj(rec : TRec_Object_Data); overload;
    procedure Send_State_Exocet(rec : TRec_State_Exocet);
    procedure Send_Change_Idnt_Hf(OrdID : Byte; rec : TRec_Change_Identity_HF);
    procedure Send_Fire_Exocet;
    procedure Send_Data_RadarMW08(rec : TRec_Data_MW08);
    procedure Send_Data_Area_MW08(rec : TRec_Data_Area_MW08);
    procedure Send_Data_Gun76(rec : TRec_Data_Gun76);
    procedure Send_Desigt_Gun76(rec : TRec_Gun76);
    procedure Send_Break_Gun76(rec : TRec_Gun76);
    procedure Send_Fire76(rec : TRec_Gun76; OrdID : Byte);
    procedure Send_Data_Tetral(rec : TRec_Data_Tetral);
    procedure Send_Data_Tetral2(rec : TRec_Data_Tetral2);
    procedure Send_Desigt_Tetral(rec : TRec_Data_Fire_Tetral);
    procedure Send_Break_Tetral(rec : TRec_Data_Fire_Tetral);
    procedure Send_Data_Tsmc(rec : TRec_Data_TSMC);
    procedure Send_Fire_Tetral(rec : TRec_Data_Fire_Tetral);
    procedure Send_Desigt_A244(rec : TRec_Data_A244);
    procedure Send_Break_A244(rec : TRec_Data_A244);
    procedure Send_Set_Data_A244(rec : TRec_Data_A244);

    // WASA
    procedure Send_Data_WASA(rec : TRec_Data_Wasa);
    procedure Send_SelWasaChannel(rec: TRec_SelWasaChannel);
    procedure Send_WasaChanProperties(rec: TRec_WasaChanProperties);

    // Threat Air
    procedure Send_Data_Threat_Eval(rec : TRec_Threat_Eval_Values);
    procedure Send_Data_TrkSelAir(rec : TRec_TrackSelAirSetting);

    procedure Send_Data_Eval_Tracklist(rec : TRec_Eval_Tracklist);

    {LIROD}
    procedure Send_LIROD_Setting(rec : TRec_LIROD_Setting);
    procedure Send_LIROD_SearchSector(ARec : TRec_Lirod_SearchSector);
    procedure Send_Data_LIROD(aRec: TRec_LIROD_MK2);

    {NGS Oddy}
    procedure Send_Data_NGS(aRec: TRec_Data_NGS);
    procedure Send_NGS_Target(aRec: TRec_NGS_Target);
    
    {Sector Screen Oddy}
    procedure Send_Data_SectorScreen(aRec: TRec_Data_SectorScreen);
    procedure Send_SectorScreen_Object(aRec: TRec_SectorScreen_Object);


    procedure Send_Set_Tube_Content(rec : TRec_B515TubeContent);
    procedure Send_Engage_Manual_Track(rec: TRec_Track_Movement);
    procedure Send_Setting_GIC76(rec : TRec_Data_GIC76);
    procedure Send_Data_FOC(rec : TRec_Data_FOC);
    procedure Send_FireTorpedoA244(rec : TRec_FireTorpedoA244);

    procedure Send_Data_Nav_Stationing(rec: TRec_NavData_Stationing);
    procedure Send_Stationing_RefObj(rec: TRec_Stationing_RefObj);

    { Decoy }
    procedure Send_Data_DecoySysMode(rec : TRec_Data_DecoySysModeChg);
    procedure Send_Data_DecoySim(rec : TRec_Data_DecoySim);
    procedure Send_Data_DecoyLauncher(rec: TRec_Data_DecoyLauncher);
    procedure Send_Data_DecoyController(rec: TRec_Data_DecoyController);
    procedure Send_Data_DecoyLaunchQueue(rec: TRec_Decoy_Queue);
    procedure Send_Data_DecoyFiringQueue(rec: TRec_Decoy_Queue);
    procedure Send_Data_DecoyFiring(rec: TRec_Decoy_Firing);
    procedure Send_Data_DecoyLCC(rec : TRec_Data_Decoy_LCC);
    procedure Send_DecoyDesigOps(rec : TRec_Decoy_Desig_Ops);

    procedure Send_Data_DecoyAuto(rec : TRec_Data_DecoyAuto);

    procedure Send_Init_Decoy_Firing(rec : TRec_Data_Init_Decoy_Firing);

    procedure Send_Snapshot_Data(rec: TRec_Data_Snapshot);

    {SONAR}
    procedure Send_Sonar_Envi(rec : TRec_Sonar_Envi);
    procedure Send_Sync_Sonar(rec : TRec_Sonar_Sync);
    procedure Send_Sonar_Status(ARec: TRec_Sonar_Status);

    procedure Send_Track_Detect(rec : TRec_Track_Detection);
    procedure Send_Track_Shift(rec : TRec_Track_Shift);

	  procedure Send_EnvironmentData(rec : TRec_Data_Natural_Envi);
    procedure Send_ScenarioSync(rec : TRec_ScenarioSync);
	  procedure Send_ConsoleStatus(rec : TRecStatus_ConsoleTCMS);
    procedure Send_MissilePos(rec : TRecMissilePosTCMS);
    procedure Send_Track_Movement(rec : TRec_Track_Movement);
    procedure Send_Track_Sources(rec: TRec_Track_Sources);
    procedure Send_Change_Track_Desc(rec : TRec_Change_Track_Description);
	  procedure Send_Confirm_Target_Torpedo(rec : TRec_Torpedo_ConfirmTarget);
    procedure Send_MOC_Online_Check(rec: Trec_Check_MOC_Online);
    procedure Send_IDGenerator(rec : TRec_IDGenerator);
    procedure Send_Track_Positioning(rec: TRec_Track_Position);
	  procedure Send_Nav_Route_Data(rec : TRec_Data_Nav_Route);
    procedure Send_Nav_Route_Data_WP(rec : TRec_Data_WP_Nav_Route);
    procedure Send_Man_Overboard_Data(rec : TRec_Data_Man_Overboard);
    procedure Send_Man_Overboard_Pos(rec : TRec_Man_Overboard_Pos);
    procedure Send_Plan_Cordon_Data(rec : TRec_Data_Plan_Cordon);
    procedure Send_Plan_Cordon_Tracks(rec : TRec_Plan_Cordon_Tracks);
    procedure Send_Data_Target_Exocet(rec : TRec_Data_Target_Exocet);
    procedure Send_Data_Plan_Missile(rec : TRec_Plan_Missile);
    procedure Send_Data_Missile_Parameter(rec : TRec_Missile_Parameter);
    procedure Send_Data_Firing_Squence(rec : TRec_Missile_Firing_Squence);
    procedure Send_Data_Exocet_Target_Object(rec : TRec_Data_Exocet);
    procedure Send_Data_MW08_Simulator(rec : TRec_MW08_Simulator);
    procedure Send_Data_MM40_Movement(rec : TRec_ExocetMM40_Movement);
    procedure Send_Data_GameSync(rec : TRec_GameSync);
    procedure Send_Data_SessionAvailable(rec : TRec_Session);
    procedure Send_ECMEngagement(rec : TRec_ECMEngagement);
    procedure Send_ECMAuth(rec : TRec_ECMEAuth);
    procedure Send_ECMSimulator(rec : TRec_ECMSimulator);   {icha}
    procedure Send_ASWUnit(rec : TRec_ASWUnit);

    procedure Send_ARPA_DetectedTrack(rec : TRec_ARPA_DetectedTrack);

    //for ZigzagPlan
    procedure Send_Nav_Zigzag_Data(rec : TRec_Data_Nav_ZigzagPlan);
    procedure Send_Nav_Zigzag_Data_PL(rec : TRec_Data_Pl_Nav_ZigzagPlan);
    procedure Send_Nav_Zigzag_CatalogueValue(rec : TRec_Data_Nav_ZigzagCatalogueValue);

    {mail ica}
    procedure Send_Mail_Data(rec : TRec_Data_Mail);
    procedure Send_Mail_Value(rec : TRec_Data_MailValue);
    procedure Send_Sent_Mail(rec : TRec_Data_SentItemMail);
    {mail status}
    procedure Send_Mail_StatusMail(rec : TRec_Data_StatusMail);

    {EMCON}
    procedure Send_EmconPlan1(rec : TRec_EmconPlan1);
    procedure Send_EmconPlan2(rec : TRec_EmconPlan2);

    {TDS}
    procedure Send_TDS_Port(rec: TRec_TDS_Data);
    procedure Send_TDS_Stbd(rec: TRec_TDS_Data);

    {PAC}
    procedure Send_PAC_Data(aRec: TRec_PAC_Data);
    procedure Send_PAC_Target(aRec: TRec_PAC_Target);

    procedure Send_FA_Code(aRec: TRec_FA_Code);

    {Holdfire Report Def}
    procedure Send_HoldfireReportDef(rec: TRec_HoldfireReportDef);

    {ASW Danger Zones, include Torpedo Danger Zones and LLOA}
    procedure Send_ASWDangerZones(rec: TRec_ASWDangerZones);

    {Throw Off Control}
    procedure Send_Throw_Off_Control(rec: Trec_Throw_Off_Control);

    procedure Send_ESM_Brn_Track_Data(rec: TRec_Data_ESM_Brn_Track);

    {IFF Simulator}
    procedure Send_Data_IFF_Simulator(rec : TRec_IFF_Simulator);
    procedure Send_IFF_Plot_Data(rec : TRec_Data_IFF_Plot);
    procedure Send_IFF_Plot_Monit(rec : TRec_Data_IFF_Monit);
    procedure Send_Track_IFF_Code(rec : TRec_Track_IFF_Code);
    procedure Send_IFF_Transpond_Ctrl(rec : TRec_IFF_TranspondCtrl);
    procedure Send_IFF_Transpond_MC (rec : TRec_IFF_TranspondMC);
    procedure Send_IFF_Interrogations(rec : TRec_IFF_Interrogations);
    procedure Send_IFF_Sectors_List(rec : TRec_Data_IFF_Sector);

    {Track Monitor}
    procedure Send_Track_Monit_Data(rec : TRec_Track_Monitor);

    {Tactical Figure}
    procedure Send_TactFigure_List_Data(rec : TRec_List_Tactical_Figure);
    procedure Send_TactFigure_Visual_Data(rec : TRec_Visual_Tactical_Figure);
    procedure Send_TactFigure_Group_Visual_Data(rec : TRec_Visual_Tactical_Figure_Group);
    procedure Send_TactFigure_Polygon(rec : TRec_Visual_Polygon);
    procedure Send_TactFigure_Polyline(rec : TRec_Visual_Polyline);

    {Geographix Situation}
    procedure Send_Geo_List_Data(rec : TRec_List_Geographic_situation);
    procedure Send_Geo_Visual_Data(rec : TRec_Visual_Geo_Fig);
    procedure Send_Geo_Polygon(rec : TRec_Visual_Polygon);
    procedure Send_Geo_Polyline(rec : TRec_Visual_Polyline);
    {Area Alert}
    procedure Send_Area_Alert(rec : TRec_Area_Alert_Warning);

    procedure Send_LinkY_Setting(rec : TRec_LinkY_Setting);

    {OS Environment Data0}
    procedure Send_Data_MagneticVar(rec : TRec_Magnetic_Var);
    procedure Send_Data_Barrometric(rec : TRec_Barometric_Pressure);
    procedure Send_Data_Humidity(rec : TRec_Humidity);
    procedure Send_Data_Air_Temperature(rec : TRec_Air_Temperature);
    procedure Send_Data_Depth(rec : TRec_Depth);
    procedure Send_Data_Wind(rec : TRec_Wind);
    procedure Send_Data_Drift(rec : TRec_Drift);
    procedure Send_Data_Rel_OS_Poss(rec : TRec_Relative_OS_Poss);
    procedure Send_Data_Envi_Time_Date(rec : TRec_Envi_Date_Time);


    {76mm}
    procedure Send_76mm_Bullet_Movement(rec : TRec_76mm_Bullet_Movement);

    procedure netRecv_MovementData(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Req_Connect(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_ChangeRole(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_ChangeLib(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_ICM(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_On_TCMS(apRec : PAnsiChar; aSize : word);
    procedure netRecv_Desigt_Exocet(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Break_Exocet(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Device_State(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Object_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Emitter_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_State_Exocet(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Change_Idnt_Hf(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Fire_Exocet(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_RadarMW08(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_Area_MW08(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_Gun76(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Desigt_Gun76(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Break_Gun76(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Fire76(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_Tetra(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_Tetral2(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Desigt_Tetral(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Break_Tetral(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_TSMC(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_DataFireTetral(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Desigt_A244(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Break_A244(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Set_Data_A244(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_ASWUnit(apRec: PAnsiChar; aSize: Word);

    {WASA}
    procedure netRecv_Data_Wasa(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_SelWasaChannel(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_WasaChanProperties(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_LIROD_Setting(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_ECMEngagement(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_ECMSimulator(apRec: PAnsiChar; aSize: Word); //icha
    procedure netRecv_ECMAuth(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_ARPA_DetectedTrack(apRec : PAnsiChar; aSize : Word);

    {EMCON}
    procedure netRecv_EmconPlan1(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_EmconPlan2(apRec: PAnsiChar; aSize: Word);

    {NGS}
    procedure netRecv_Data_NGS(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_NGS_Target(apRec: PAnsiChar; aSize: Word);

    {LIROD}
    procedure netRecv_LIROD(aprec: PAnsiChar; aSize: Word);
    procedure netRecv_LIROD_SearchSector(aprec: PAnsiChar; aSize: Word);
    
    {Sector Screen}
    procedure netRecv_Data_SectorScreen(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_SectorScreen_Object(apRec: PAnsiChar; aSize: Word);


    procedure netRecv_MM40_Movement(apRec: PAnsiChar; aSize : Word);
    procedure netRecv_GameSync(apRec: PAnsiChar; aSize : Word);
    procedure netRecv_SessionAvailable(apRec: PAnsiChar; aSize : Word);

    {TDS}
    procedure netRecv_TDS_Port(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_TDS_Stbd(apRec: PAnsiChar; aSize: Word);

    {TWS}


    procedure netRecv_Set_Tube_Content(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Engage_Manual_Track(apRec: PAnsiChar; aSize: Word);

    {PAC}
    procedure netRecv_PAC(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_PAC_Target(apRec: PAnsiChar; aSize: Word);

    {FIRE AUTH}
    procedure netRecv_FA_Code(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_Snaps(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_GIC76Setting(apRec: PAnsiChar; aSize: Word);

    {SONAR}
    procedure netRecv_Sonar_Sync(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Sonar_Envi(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Sonar_Status(apRec: PAnsiChar; aSize: Word);


    procedure netRecv_Track_Detect(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Track_Shift(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_Data_Nav_Stationing(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Stationing_RefObj(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_Data_DecoySysMode(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoySim(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyLauncher(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyController(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyLaunchQueue(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyFiringQueue(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyFiring(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_DecoyLCC(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_DecoyDesigOps(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_Data_DecoyAuto(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_InitDecoyFiring(apRec: PAnsiChar; aSize: Word);


	  procedure netRecv_EnvironmentData(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_ScenarioSync(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_FireTorpedoSPS(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_FireTorpedoA244(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Change_Track_Desc(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_IDGenerator(apRec: PAnsiChar; aSize: Word);


    // Track
    procedure netRecv_Track_Movement(apRec : PAnsiChar; aSize: Word);
    procedure netRecv_Track_Sources(apRec : PAnsiChar; aSize: Word);

    procedure netRecv_LinkYSetting(apRec : PAnsiChar; aSize: Word);


	  procedure netRecv_Confirm_Target_Torpedo(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_MOC_Online_Check(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Nav_Route_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Nav_Route_Data_WP(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Man_Overboard_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Man_Overboard_Pos(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Plan_Cordon_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Plan_Cordon_Tracks(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Data_Target_Exocet(apRec: PAnsiChar; aSize: word);
    procedure netRecv_Track_Positioning(apRec: PAnsiChar; aSize: Word);
    //For ZigzagPlan
    procedure netRecv_Nav_Zigzag_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Nav_Zigzag_Data_PL(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Nav_Zigzag_Data_CatalogueValue(apRec: PAnsiChar; aSize: Word);

    {Recv Mail Ica}
    procedure netRecv_Mail_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Mail_Value_Data(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Sent_Item_Mail_Data(apRec: PAnsiChar; aSize: Word);
    {Mail status}
    procedure netRecv_Status_Mail(apRec: PAnsiChar; aSize: Word);

    procedure netRecv_PlanMissile(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_MissileParameter(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_FiringSquence(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_Exocet_Target_Object(apRec: PAnsiChar; aSize: Word);
    procedure netRecv_MW08_Simulator(apRec: PAnsiChar; aSize : Word);
    procedure netRecv_HoldFireReportDef(apRec: PAnsiChar; aSize: Word);

    {ASW Danger Zones}
    procedure netRecv_ASWDangerZones(apRec: PAnsiChar; aSize: Word);

    {Throw Off Control}
    procedure netrecv_Throw_Off_Control(aprec: PAnsiChar; aSize: Word);

    procedure netrecv_ESM_Brn_Track_Data(aprec: PAnsiChar; aSize: Word);

    {IFF Simulator}
    procedure netRecv_IFF_Simulator(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Data(aprec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Plot_Monit(aprec : PAnsiChar; aSize : Word);
//    procedure netRecv_IFF_Plot_Display(aprec : PAnsiChar; aSize : Word);
    procedure netRecv_Track_IFF_Code(aprec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Transpond_Ctrl(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Transpond_MC(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Interrogations(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_IFF_Sectors_List(apRec : PAnsiChar; aSize : Word);

    procedure netRecv_Data_Threat_Eval(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_TrkSelAir(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Eval_Tracklist(apRec : PAnsiChar; aSize : Word);

    {Track Monitor}
    procedure netRecv_Track_Monit_Data(apRec : PAnsiChar; aSize : Word);

    {Tactical Figure}
    procedure netRecv_TactFigure_List_Data(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_TactFigure_Visual_Data(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_TactFigure_Group_Visual_Data(apRec : PAnsiChar; asize : Word);
    procedure netRecv_TactFigure_Polygon(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_TactFigure_Polyline(apRec : PAnsiChar; aSize : Word);

    {Geographic Situation}
    procedure netRecv_Geo_List_Data(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Geo_Visual_Data(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Geo_Polyline(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Geo_Polygon(apRec : PAnsiChar; aSize : Word);

    {Area Alert}
    procedure netRecv_Area_Alert(apRec : PAnsiChar; aSize : Word);

    {OS Environment Data}
    procedure netRecv_Data_MagneticVar (apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Barometric(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Humidity(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Air_Temperature(apRec: PAnsiChar; aSize : Word);
    procedure netRecv_Data_Depth(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Wind(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Drift(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Rel_OS_Poss(apRec : PAnsiChar; aSize : Word);
    procedure netRecv_Data_Envi_Date_Time(apRec : PAnsiChar; aSize : Word);


    {76mm}
    procedure netRecv_76mm_Bullet_Movement(apRec: PAnsiChar; aSize: Word);

    { sps simulator }
    procedure netRecv_MissilePos(apRec: PAnsiChar; aSize: Word);

//    // Window message for ESM
//    procedure WMCopyData(var Msg: TWMCopyData);
//    procedure HandleCopyDataRecord(copyDataStruct: PCopyDataStruct);
//    procedure winRecv_VigileData(TrkData: TRec_Track_Detection);

  published
    property OnSyncDataObj : TOnSyncData read FOnSyncDataObj write FOnSyncDataObj;
    property OnTsmcChange : TOnSyncData read FOnTSMCChange write FOnTSMCChange;
    property OnChangeRoleStatus : TOnRoleChange read FOnRoleChangeState write FOnRoleChangeState;
    property OnLibraryChange    : TOnLibraryChange read FOnLibraryChange write FOnLibraryChange ;
    property OnCreateICM: TOnCreateICM read FOnCreateICM write FOnCreateICM;
    property OnDesigtExocet: TOnDesigtExocet read FOnDesigtExocet write FOnDesigtExocet;
    property OnBreakExocet: TOnBreakExocet read FOnBreakExocet write FOnBreakExocet;
    property OnDeviceChangeState: TOnSetWpnAndSnsrState read FOnDeviceChangeState write FOnDeviceChangeState;
    property OnSetDataObject: TOnSyncData read FOnDataObject write FOnDataObject;
    property OnSetDataEmitter: TOnSyncData read FOnDataEmitter write FOnDataEmitter;
    property OnStateExocet: TOnSyncData read FOnStateExocet write FOnStateExocet;
    property OnChangeIdent: TOnSyncData read FOnChangeIdent write FOnChangeIdent;
    property OnFireExocet: TOnSyncData read FFireExocet write FFireExocet;
    property OnDataRadarMW08: TOnSyncData read FOnDataRadarMW08 write FOnDataRadarMW08;
    property OnDataAreaMW08: TOnSyncData read FOnDataAreaMW08 write FOnDataAreaMW08;
    property OnDataGun76: TOnSyncData read FOnDataGun76 write FOnDataGun76;
    property OnDesigt76: TOnSyncData read FOnDesigt76 write FOnDesigt76;
    property OnBreak76: TOnSyncData read FOnBreak76 write FOnBreak76;
    property OnFire76: TOnFire76 read FOnFire76 write FOnFire76;
    property OnDataTetral: TOnSyncData read FOnDataTetral write FOnDataTetral;
    property OnDataTetral2: TOnSyncData read FOnDataTetral2 write FOnDataTetral2;
    property OnDesigtTetral: TOnSyncData read FOnDesigtTetral write FOnDesigtTetral;
    property OnBreakTetral: TOnSyncData read FOnBreakTetral write FOnBreakTetral;
    property OnFireTetral: TOnSyncData read FOnFireTetral write FOnFireTetral;
    property GamePort: Integer read FGamePort write FGamePort;
    property BCAddress: string read FBCAddress write FBCAddress;
    property SessionID: Integer read FSessionID write FSessionID;
    property Leader : Boolean read FLeader write FLeader;
    property MOCName : Integer read FMOCName write FMOCName;
    property ImageName : string read FImageName write FImageName;
    property ImagePath : string read FImagePath write FImagePath;
    property IDShipSigma  : string read FIDShipSigma write FIDShipSigma;
    property OnDesigtA244 : TOnSyncData read FOnDesigtA244 write FOnDesigtA244;
    property OnBreakA244 : TOnSyncData read FOnBreakA244 write FOnBreakA244;
    property OnSetDataA244 : TOnSyncData read FOnDataA244 write FOnDataA244;
    property OnDataTubeContent : TOnSyncData  read FOnDataTubeContent write FOnDataTubeContent;

    {WASA related items}
    property OnDataWasa : TOnSyncData read FOnDataWasa write FOnDataWasa;
    property OnSelWasaChannel: TOnSyncData read FOnSelWasaChannel write FOnSelWasaChannel;
    property OnwasaChanProp: TOnSyncData read FOnWasaChannelProp write FOnWasaChannelProp;
    property OnThreatEvalData: TOnSyncData read FOnThreatEvalData write FOnThreatEvalData;
    property OnTrkSelAirSetting: TOnSyncData read FOnTrkSelAirSetting write FOnTrkSelAirSetting;
    property OnEvalTracklist: TOnSyncData read FOnEvalTracklist write FOnEvalTracklist;

    {NGS}
    property OnDataNGS: TOnSyncData read FOnDataNGS write FOnDataNGS;
    property OnNGSTarget : TOnSyncData read FOnNGSTarget write FOnNGSTarget;

    property OnDataLIROD : TOnSyncData read FOnDataLIROD write FOnDataLIROD;
    property OnDataLIRODMK2 : TOnSyncData read FOnDataLIRODMK2 write FOnDataLIRODMK2;

    {Sector Screen}
    property OnDataSectorScreen: TOnSyncData read FOnDataSectorScreen write FOnDataSectorScreen;
    property OnSectorScreenObject : TOnSyncData read FOnSectorScreenObject write FOnSectorScreenObject;


    property OnEngageManualTrack : TOnSyncData read FOnEngageManualTrack write FOnEngageManualTrack;
    property OnGetTCMSIsON : TOnSyncData read FOnGetTCMSIsON write FOnGetTCMSIsON;
    property OnGetGICSetting : TOnSyncData read FOnGetGICSetting write FOnGetGICSetting;
    property onSnapshotData:TOnSyncData read FOnSnapshotData write FOnSnapshotData;

    {SONAR}
    property OnSonarSync : TOnSyncData read FOnSonarSync write FOnSonarSync;
    property OnSonarStatus : TOnSyncData read FOnSonarStatus write FOnSonarStatus;

	  property OnDataEnvironment : TOnSyncData read FOnDataEnvironment write FOnDataEnvironment;
    property OnSyncScenario : TOnSyncScenario read FOnSyncScenario write FOnSyncScenario;
  	property OnTrackDetect : TOnSyncData read FOnTrackDetect write FOnTrackDetect;
    property OnTrackShift : TOnSyncData read FOnTrackShift write FOnTrackShift;
    property OnFireTorpedoSPS : TOnSyncData read FOnFireTorpedoSPS write FOnFireTorpedoSPS;
    property OnFireTorpedoA244 : TOnSyncData read FOnFireTorpedoA244 write FOnFireTorpedoA244;
    property OnChangeTrackDesc : TOnSyncData read FOnChangeTrackDesc write FOnChangeTrackDesc;
    property OnSetSonarEnvi : TOnSyncData read FOnSetSonarEnvi write FOnSetSonarEnvi;
	  property OnSetTorpedoConfirmTarget : TOnSyncData read FOnSetTorpedoConfirmTarget write FOnSetTorpedoConfirmTarget;
    property OnDataDecoySysMode: TOnSyncData read FOnDataDecoySysMode write FOnDataDecoySysMode;
    property OnDataDecoySim: TOnSyncData read FOnDataDecoySim write FOnDataDecoySim;
    property OnDataDecoyLauncher: TOnSyncData read FOnDataDecoyLauncher
                                              write FOnDataDecoyLauncher;
    property OnDataDecoyController: TOnSyncData read FOnDataDecoyController
                                              write FOnDataDecoyController;
    property OnDecoyLaunchQueue: TOnUpdateDecoyLaunchQueue read FOnDecoyLaunchQueue
                                              write FOnDecoyLaunchQueue;
    property OnDecoyFiringQueue: TOnUpdateDecoyFiringQueue read FOnDecoyFiringQueue
                                              write FOnDecoyFiringQueue;
    property OnDecoyFiring: TOnDecoyFiring read FOnDecoyFiring write FOnDecoyFiring;
    property OnDecoyLCC: TOnSyncData read FOnDecoyLCC write FOnDecoyLCC;

    property OnDecoyDesigOps: TOnSyncData read FOnDecoyDesigOps write FOnDecoyDesigOps;
    property OnDecoyAutoData: TOnSyncData read FOnDecoyAutoData write FOnDecoyAutoData;

    property OnInitDecoyFiring: TOnSyncData read FOnInitDecoyFiring write FOnInitDecoyFiring;

    property OnNavDataStationing: TOnSyncData read FOnNavDataStationing
                                              write FOnNavDataStationing;
    property OnStationingRefObj: TOnSyncData read FOnStationingRefObj
                                             write FOnStationingRefObj;
    property AckCode: string read FAckCode write FAckCode;
    property OnRcvMOC_Online_Check: TOnSyncData read  FOnRcvMOC_Online_Check
                                                 write FOnRcvMOC_Online_Check;
    property OnTrackMovement : TOnSyncData read FOnTrackMovement write FOnTrackMovement;
    property OnTrackSources : TOnSyncData read FOnTrackSources write FOnTrackSources;


    property OnIDGenerator : TOnSyncData read FOnIDGenerator write FOnIDGenerator;
    property OnDataNavRoute : TOnSyncData read FOnDataNavRoute write FOnDataNavRoute;
    property OnDataWPNavRoute : TOnSyncData read FOnDataWPNavRoute write FOnDataWPNavRoute;
    property OnDataManOverboard : TOnSyncData read FOnDataManOverboard write FOnDataManOverboard;
    property OnDataPlanCordon : TOnSyncData read FOnDataPlanCordon write FOnDataPlanCordon;
    property OnManOverboardPos : TOnSyncData read FOnManOverboardPos write FOnManOverboardPos;
    property OnPlanCordonTracks : TOnSyncData read FOnPlanCordonTracks write FOnPlanCordonTracks;
    property OnTrackPositioning : TOnSyncData read FOnTrackPositioning write FOnTrackPositioning;
	  property OnDataExocetTargetStatus : TOnSyncData read FOnDataExocetTargetStatus write FOnDataExocetTargetStatus;
    property OnDataPlanMissile : TOnSyncData read FOnDataPlanMissile write FOnDataPlanMissile;
    property OnDataMissileParameter : TOnSyncData read FOnDataMissileParameter write FOnDataMissileParameter;
    property OnDataFiringSquence : TOnSyncData read FOnDataFiringSquence write FOnDataFiringSquence;
    property OnDataExocetTargetObject : TOnSyncData read FOnDataExocetTargetObject write FOnDataExocetTargetObject;
	  property OnTdsPort : TOnSyncData read FOnTdsPort write FOnTdsPort;
    property OnTdsStbd : TOnSyncData read FOnTdsStbd write FOnTdsStbd;
    property OnHoldfireReportDef : TOnSyncData read FOnHoldfireReportDef write FOnHoldfireReportDef;

    {SPS}
    property OnMissilePos : TOnSyncData read FOnMissilePos write FOnMissilePos;

    {ASW Danger Zones}
    property OnASWDangerZones : TOnSyncData read FOnASWDangerZones write FOnASWDangerZones;

    {Throw Off Control}
    property OnThrowOffControl : TOnSyncData read FOnThrowOffControl write FOnThrowOffControl;

    {PAC}
    property OnDataPAC : TOnSyncData read FOnDataPAC write FOnDataPAC;
    property OnTargetPAC : TOnSyncData read FOnTargetPAC write FOnTargetPAC;

    //zigzagPlan
    property OnDataNavZigzag    : TOnSyncData read FOnDataNavZigzag write FOnDataNavZigzag;
    property OnDataPLNavZigzag  : TOnSyncData read FOnDataPLNavZigzag write FOnDataPLNavZigzag;
    property OnDataNavZigzagCatalogue : TOnSyncData read FOnDataZigzagCatalogueValue write FOnDataZigzagCatalogueValue;

    //SentMailIca
    property OnDataSentItemMail : TOnSyncData read FOnDataSentItemMail write FOnDataSentItemMail;
    property OnDataSentStatusMail : TOnSyncData read FOnDataStatusMail write FOnDataStatusMail;

    property OnFACode : TOnSyncData read FOnFACode write FOnFACode;
    property OnMW08Simulator : TOnSyncData read FOnMW08Simulator write FOnMW08Simulator;
    property OnMM40Movement : TOnSyncData read FOnMM40Movement write FOnMM40Movement;
    property OnGameSync : TOnSyncData read FOnGameSync write FOnGameSync;
    property OnSessionAvaible : TOnSyncData read FOnSessionAvailble write FOnSessionAvailble;
    property OnECMEngagement : TOnSyncData read FOnECMEngagement write FOnECMEngagement;
    property OnECMSimulator : TOnSyncData read FOnECMSimulator write FOnECMSimulator;
    property OnECMAuth  : TOnSyncData read FOnECMAuth write FOnECMAuth;

    {EMCON}
    property OnEmconPlan1 : TOnSyncData read FOnEmconPlan1 write FOnEmconPlan1;
    property OnEmconPlan2 : TOnSyncData read FOnEmconPlan2 write FOnEmconPlan2;

    property OnDataESMBrnTrack : TOnSyncData read FOnDataESMBrnTrack write FOnDataESMBrnTrack;

    {IFF Code Uswah}
    property OnDataIFFPlot : TOnSyncData read FOnDataIFFPlot write FOnDataIFFPlot;
    property OnDataIFFPlotMonit : TOnSyncData read FOnDataIFFPlotMonit write FOnDataIFFPlotMonit;
    property OnTrackDataIFFCode : TOnSyncData read FOnTrackDataIFFCode write FOnTrackDataIFFCode;
    property OnTrackMonitorData : TOnSyncData read FOnTrackMonitorData write FOnTrackMonitorData;
    property OnIFFSimulator : TOnSyncData read FOnIFFSimulator write FOnIFFSimulator;
    property OnIFFTranspondCtrl : TOnSyncData read FOnIFFTranspondCtrl write FOnIFFTranspondCtrl;
    property OnIFFTranspondMC : TOnSyncData read FOnIFFTranspondMC write FOnIFFTranspondMC;
    property OnIFFInterrogations : TOnSyncData read FOnIFFInterrogations write FOnIFFInterrogations;
    property OnDataIFFSectorsVisual : TOnSyncData read FOnDataIFFSectorsVisual write FOnDataIFFSectorsVisual;
    property OnDataIFFSectorsList : TOnSyncData read FOnDataIFFSectorsList write FOnDataIFFSectorsList;
//    property OnDataIFFPlotDisplay : TOnSyncData read FOnDataIFFPlotDisplay write FOnDataIFFPlotDisplay;

    {Tactical Figure}
    property OnSyncTacticalFigure : TOnSyncData read FOnSyncTacticalFigure write FOnSyncTacticalFigure; // ga jadi

    property OnSyncListTactFigure : TOnSyncData read FOnSyncListTactFigure write FOnSyncListTactFigure;
    property OnSyncVisualTactFigure : TOnSyncData read FOnSyncVisualTactFigure write FOnSyncVisualTactFigure;
    property OnSyncVisualTactFigureGroup : TOnSyncData read FOnSyncVisualTactFigureGroup write FOnSyncVisualTactFigureGroup;
    property OnSyncVisualPolygon : TOnSyncData read FOnSyncVisualPolygon write FOnSyncVisualPolygon;
    property OnSyncVisualPolyline : TOnSyncData read FOnSyncVisualPolyline write FOnSyncVisualPolyline;

    //Geographic Situation
    property OnSyncListGeoSituation : TOnSyncData read FOnSyncListGeoSituation write FOnSyncListGeoSituation;
    property OnSyncVisualGeo  : TOnSyncData read FOnSyncVisualGeo write FOnSyncVisualGeo;
    property OnSyncVisualPolylineGeo : TOnSyncData read FOnSyncVisualPolylineGeo write FOnSyncVisualPolylineGeo;
    property OnSyncVisualPoligonGeo : TOnSyncData read FOnSyncVisualPolygonGeo write FOnSyncVisualPolygonGeo;

    // 76mm
    property On76mmBulletMovement : TOnSyncData read FOn76mmBulletMovement write FOn76mmBulletMovement;

    // LIROD
    property OnLirodSetting: TOnSyncData read FOnLirodSetting write FOnLirodSetting;
    property OnLirodSearchSector : TOnSyncData read FOnLirodSearchSector
      write FOnLirodSearchSector;

    {Area Alert}
    property OnSyncAreaAlert : TOnSyncData read FOnSyncAreaAlert write FOnSyncAreaAlert;

    property OnLinkYSetting : TOnSyncData read FOnLinkYSetting write FOnLinkYSetting;
    property OnARPADetected : TOnSyncData read FOnARPADetected write FOnARPADetected;

    {SONAR}
    property OnSonarRequest : TOnSyncData read FOnSonarRequest write FOnSonarRequest;
    property OnASWUnitIncluded : TOnSyncData read FOnASWUnitIncluded write FOnASWUnitIncluded;

    property OnSyncDataMagneticVar : TOnSyncData read FOnSyncDataMagneticVar write FOnSyncDataMagneticVar;
    property OnSyncDataBarometric : TOnSyncData read FOnSyncDataBarometric write FOnSyncDataBarometric;
    property OnSyncDataHumidity: TOnSyncData read FOnSyncDataHumidity write FOnSyncDataHumidity;
    property OnSyncDataAirTemperature : TOnSyncData  read FOnSyncDataAirTemperature write FOnSyncDataAirTemperature;
    property OnSyncDataDepth : TOnSyncData read FOnSyncDepthValue write FOnSyncDepthValue;
    property OnSyncDataWind: TOnSyncData read FOnSyncDataWind write FOnSyncDataWind;
    property OnSyncDataDrift : TOnSyncData  read FOnSyncDataDrift write FOnSyncDataDrift;
    property OnSyncDataRelOSEnvi: TOnSyncData read FOnSyncDataRelOSEnvi write FOnSyncDataRelOSEnvi;
    property OnSyncDataEnviDateTime : TOnSyncData read FOnSyncDataEnviDateTime write FOnSyncDataEnviDateTime;


    property OnLogEvtSt : TGetStrProc read FOnLogEvtStr write FOnLogEvtStr;
//    // ESM Msg
//    property OnMsgDataMovement: TOnMsgSendDataMovement read FOnMsgDataMovement
//                                                       write FOnMsgDataMovement;


  end;

var
  MessageHandle : TMessage_Handling;

implementation

uses
  uTCMSSimManager;

{ TMessage_Handling }

function TMessage_Handling.CekIp(IPAddress: string): Boolean;
var
  StrList: TStrings;
  Ip: string;
  I: Integer;
  found: Boolean;
begin
  found := False;
  Result := False;
  i := 0;

  StrList := TStringList.Create;

  if GetHostandIPList(Ip, StrList) then

  while not found and (i < StrList.Count) do
  begin
    ip := StrList[i];
    found := Ip = IPAddress;

    inc(i);
  end;

  Result := found;
end;

constructor TMessage_Handling.create;
begin
  NetHandle := TNetHandle.create;
end;

destructor TMessage_Handling.destroy;
begin
  inherited;
  NetHandle.StopListen;
  NetHandle.UnRegisterUDP;
  NetHandle.StopNetworking;
  NetHandle.Free;
end;

procedure TMessage_Handling.Initialize;
begin
  NetHandle.GamePort := FGamePort;
  NetHandle.BroadCastAddress := FBCAddress;
  NetHandle.StartNetworking;
  NetHandle.StartListen;
end;

procedure TMessage_Handling.InitNetwork;
begin
  NetHandle.RegisterUDPPacket(CPID_PLATFORM_MOVE, SizeOf(TRec_Data_Movement), netRecv_MovementData);
  NetHandle.RegisterUDPPacket(CPID_CHANGE_ROLE, SizeOf(TRec_Data_Change_Role), netRecv_ChangeRole);
  NetHandle.RegisterUDPPacket(CPID_LIBRARY, SizeOf(TRec_Data_Change_Library), netRecv_ChangeLib);
  NetHandle.RegisterUDPPacket(CPID_REQ_ICM, SizeOf(TRec_Data_ICM), netRecv_Data_ICM);
  NetHandle.RegisterUDPPacket(CPID_DESIGT_EXOCET, SizeOf(TRec_Data_Exocet), netRecv_Desigt_Exocet);
  NetHandle.RegisterUDPPacket(CPID_BREAK_EXOCET, SizeOf(TRec_Data_Exocet), netRecv_Break_Exocet);
  NetHandle.RegisterUDPPacket(CPID_DEVICE_STATE, SizeOf(TRec_Device_State), netRecv_Device_State);
  NetHandle.RegisterUDPPacket(CPID_OBJECT_DATA, SizeOf(TRec_Object_Data), netRecv_Object_Data);
  NetHandle.RegisterUDPPacket(CPID_EMITTER_WEAPON, SizeOf(TRec_Emitter_Data), netRecv_Emitter_Data);           //CPID_LIBRARY
  NetHandle.RegisterUDPPacket(CPID_STATE_EXOCET, SizeOf(TRec_State_Exocet),netRecv_State_Exocet);
  NetHandle.RegisterUDPPacket(CPID_CHANGE_IDENTITY, SizeOf(TRec_Change_Identity_HF), netRecv_Change_Idnt_Hf);
  NetHandle.RegisterUDPPacket(CPID_CHANGE_HOLDFIRE, SizeOf(TRec_Change_Identity_HF), netRecv_Change_Idnt_Hf);
  NetHandle.RegisterUDPPacket(CPID_FIRE_EXOCET, SizeOf(TRec_Fire_Exocet), netRecv_Fire_Exocet);
  NetHandle.RegisterUDPPacket(CPID_DATA_MW08, SizeOf(TRec_Data_MW08), netRecv_Data_RadarMW08);
  NetHandle.RegisterUDPPacket(CPID_AREA_MW08, SizeOf(TRec_Data_Area_MW08), netRecv_Data_Area_MW08);
  NetHandle.RegisterUDPPacket(CPID_DATA76, SizeOf(TRec_Data_Gun76), netRecv_Data_Gun76);
  NetHandle.RegisterUDPPacket(CPID_DESIGT76, SizeOf(TRec_Gun76), netRecv_Desigt_Gun76);
  NetHandle.RegisterUDPPacket(CPID_BREAK76, SizeOf(TRec_Gun76), netRecv_Break_Gun76);
  NetHandle.RegisterUDPPacket(CPID_FIRE76, SizeOf(TRec_Gun76), netRecv_Fire76);
  NetHandle.RegisterUDPPacket(CPID_STOP76, SizeOf(TRec_Gun76), netRecv_Fire76);
  NetHandle.RegisterUDPPacket(CPID_TETRAL, SizeOf(TRec_Data_Tetral), netRecv_Data_Tetra);
  //new tetral
  NetHandle.RegisterUDPPacket(CPID_TETRAL2, SizeOf(TRec_Data_Tetral2), netRecv_Data_Tetral2);
  NetHandle.RegisterUDPPacket(CPID_DESIGT_TETRAL, SizeOf(TRec_Data_Fire_Tetral), netRecv_Desigt_Tetral);
  NetHandle.RegisterUDPPacket(CPID_BREAK_TETRAL, SizeOf(TRec_Data_Fire_Tetral), netRecv_Break_Tetral);
  NetHandle.RegisterUDPPacket(CPID_TSMC, SizeOf(TRec_Data_Tsmc), netRecv_TSMC);
  NetHandle.RegisterUDPPacket(CPID_FIRE_TETRAL, SizeOf(TRec_Data_Fire_Tetral), netRecv_DataFireTetral);
  NetHandle.RegisterUDPPacket(CPID_DESIGT_A244, SizeOf(TRec_Data_A244), netRecv_Desigt_A244);
  NetHandle.RegisterUDPPacket(CPID_BREAK_A244, SizeOf(TRec_Data_A244), netRecv_Break_A244);
  NetHandle.RegisterUDPPacket(CPID_DATA_A244, SizeOf(TRec_Data_A244), netRecv_Set_Data_A244);
  NetHandle.RegisterUDPPacket(CPID_SET_TUBE_CONTENT, SizeOf(TRec_B515TubeContent), netRecv_Set_Tube_Content);

  // WASA
  NetHandle.RegisterUDPPacket(CPID_WASA, SizeOf(TRec_Data_Wasa), netRecv_Data_Wasa);
  NetHandle.RegisterUDPPacket(CPID_SEL_WASA_CHAN, SizeOf(TRec_SelWasaChannel), netRecv_SelWasaChannel);
  NetHandle.RegisterUDPPacket(CPID_WASA_CHAN_PROPERTIES, SizeOf(TRec_WasaChanProperties), netRecv_WasaChanProperties);
  {WASA related items}
  NetHandle.RegisterUDPPacket(CPID_THREAT_EVAL_VALUES, SizeOf(TRec_Threat_Eval_Values), netRecv_Data_Threat_Eval);
  NetHandle.RegisterUDPPacket(CPID_TRK_SEL_AIR_SETTING, SizeOf(TRec_TrackSelAirSetting), netRecv_Data_TrkSelAir);
  NetHandle.RegisterUDPPacket(CPID_EVAL_TRACKLIST, SizeOf(TRec_Eval_Tracklist), netRecv_Data_Eval_Tracklist);

  {LIROD}
  NetHandle.RegisterUDPPacket(CPID_LIROD_Setting, SizeOf(TRec_LIROD_Setting), netRecv_LIROD_Setting);
  NetHandle.RegisterUDPPacket(CPID_LIROD_SEARCH_SECTOR, SizeOf(TRec_LIROD_SearchSector), netRecv_LIROD_SearchSector);


  {NGS}
  NetHandle.RegisterUDPPacket(CPID_NGS, SizeOf(TRec_Data_NGS), netRecv_Data_NGS);
  NetHandle.RegisterUDPPacket(CPID_NGS_TARGET, SizeOf(TRec_NGS_Target), netRecv_NGS_Target);

  NetHandle.RegisterUDPPacket(CPID_DATA_LIROD, SizeOf(TRec_LIROD_MK2), netRecv_LIROD);

  {Sector Screen}
  NetHandle.RegisterUDPPacket(CPID_SECTOR_SCREEN, SizeOf(TRec_Data_SectorScreen), netRecv_Data_SectorScreen);
  NetHandle.RegisterUDPPacket(CPID_SECTOR_SCREEN_OBJECT, SizeOf(TRec_SectorScreen_Object), netRecv_SectorScreen_Object);

  {TDS}
  NetHandle.RegisterUDPPacket(CPID_TDS_PORT, SizeOf(TRec_TDS_Data), netRecv_TDS_Port);
  NetHandle.RegisterUDPPacket(CPID_TDS_STBD, SizeOf(TRec_TDS_Data), netRecv_TDS_Stbd);

  {PAC}
  NetHandle.RegisterUDPPacket(CPID_PAC, SizeOf(TRec_PAC_Data), netRecv_PAC);
  NetHandle.RegisterUDPPacket(CPID_PAC_TARGET, SizeOf(TRec_PAC_Target), netRecv_PAC_Target);

  NetHandle.RegisterUDPPacket(CPID_MANUAL_TRACK, SizeOf(TRec_Track_Movement), netRecv_Engage_Manual_Track);
  NetHandle.RegisterUDPPacket(CPID_SNAPSHOT, SizeOf(TRec_Data_Snapshot), netRecv_Snaps);

  NetHandle.RegisterUDPPacket(CPID_STATIONING_REFOBJ , SizeOf(TRec_Stationing_RefObj), netRecv_Stationing_RefObj);
  NetHandle.RegisterUDPPacket(CPID_DATA_NAV_STATIONING , SizeOf(TRec_NavData_Stationing), netRecv_Data_Nav_Stationing);

  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYSYSMODE , SizeOf(TRec_Data_DecoySysModeChg), netRecv_Data_DecoySysMode);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYSIM , SizeOf(TRec_Data_DecoySim), netRecv_Data_DecoySim);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYLNCH, SizeOf(TRec_Data_DecoyLauncher), netRecv_Data_DecoyLauncher);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYCTRL, SizeOf(TRec_Data_DecoyController), netRecv_Data_DecoyController);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYLNCHQUE, SizeOf(TRec_Decoy_Queue), netRecv_Data_DecoyLaunchQueue);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYFIRING, SizeOf(TRec_Decoy_Firing), netRecv_Data_DecoyFiring);
  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYFIREQUE, SizeOf(TRec_Decoy_Queue), netRecv_Data_DecoyFiringQueue);
  NetHandle.RegisterUDPPacket(CPID_DECOY_DESIG_OPS , SizeOf(TRec_Decoy_Desig_Ops), netRecv_DecoyDesigOps);

  NetHandle.RegisterUDPPacket(CPID_DATA_DECOYAUTO , SizeOf(TRec_Data_DecoyAuto), netRecv_Data_DecoyAuto);

  NetHandle.RegisterUDPPacket(CPID_INIT_DECOY_FIRING , SizeOf(TRec_Data_Init_Decoy_Firing), netRecv_InitDecoyFiring);

  NetHandle.RegisterUDPPacket(CPID_GIC76, SizeOf(TRec_Data_GIC76), netRecv_GIC76Setting);
  NetHandle.RegisterUDPPacket(CPID_SEND_ON_DATA, SizeOf(TRec_Data_On_Console), netRecv_Data_On_TCMS);
  NetHandle.RegisterUDPPacket(CPID_SONAR_SYNC, SizeOf(TRec_Sonar_Sync), netRecv_Sonar_Sync);
  NetHandle.RegisterUDPPacket(CPID_TRACK_DETECT, SizeOf(TRec_Track_Detection), netRecv_Track_Detect);
  NetHandle.RegisterUDPPacket(CPID_TRACK_SHIFT, SizeOf(TRec_Track_Shift), netRecv_Track_Shift);
  NetHandle.RegisterUDPPacket(CPID_SONAR_ENVI, SizeOf(TRec_Sonar_Envi), netRecv_Sonar_envi);

  NetHandle.RegisterUDPPacket(CPID_ENVI_DATA, SizeOf(TRec_Data_Natural_Envi), netRecv_EnvironmentData);
  NetHandle.RegisterUDPPacket(CPID_SCENARIO_SYNC, SizeOf(TRec_ScenarioSync), netRecv_ScenarioSync);

  NetHandle.RegisterUDPPacket(CPID_STATUS_CONSOLE_TCMS, SizeOf(TRecStatus_ConsoleTCMS), nil);
//  NetHandle.RegisterUDPPacket(CPID_MISSILE_POS_TCMS, SizeOf(TRecMissilePos), nil);            //comment icha

  NetHandle.RegisterUDPPacket(CPID_FIRE_TORPEDO, SizeOf(TRecDataTorperdoTCMS), netRecv_FireTorpedoSPS);
  NetHandle.RegisterUDPPacket(CPID_CHANGE_TRACK_DESC, SizeOf(TRec_Change_Track_Description), netRecv_Change_Track_Desc);
  NetHandle.RegisterUDPPacket(CPID_FIRE_TORPEDO_A244, SizeOf(TRec_FireTorpedoA244), netRecv_FireTorpedoA244);

  NetHandle.RegisterUDPPacket(CPID_CONFIRM_TARGET_TORPEDO, SizeOf(TRec_Torpedo_ConfirmTarget), netRecv_Confirm_Target_Torpedo);
  NetHandle.RegisterUDPPacket(CPID_CHECK_MOC_ONLINE, SizeOf(Trec_Check_MOC_Online), netRecv_MOC_Online_Check);

  // Track
  NetHandle.RegisterUDPPacket(CPID_TRACK_MOVEMENT, SizeOf(TRec_Track_Movement), netRecv_Track_Movement);
  NetHandle.RegisterUDPPacket(CPID_TRACK_SOURCES, SizeOf(TRec_Track_Sources), netRecv_Track_Sources);

  NetHandle.RegisterUDPPacket(CPID_IDGENERATOR, SizeOf(TRec_IDGenerator), netRecv_IDGenerator);
  NetHandle.RegisterUDPPacket(CPID_NAV_ROUTE_DATA, SizeOf(TRec_Data_Nav_Route), netRecv_Nav_Route_Data);
  NetHandle.RegisterUDPPacket(CPID_NAV_ROUTE_DATA_WP, SizeOf(TRec_Data_WP_Nav_Route), netRecv_Nav_Route_Data_WP);
  NetHandle.RegisterUDPPacket(CPID_MAN_OVERBOARD_DATA, SizeOf(TRec_Data_Man_Overboard), netRecv_Man_Overboard_Data);
  NetHandle.RegisterUDPPacket(CPID_MAN_OVERBOARD_POS, SizeOf(TRec_Man_Overboard_Pos), netRecv_Man_Overboard_Pos);
  NetHandle.RegisterUDPPacket(CPID_PLAN_CORDON_DATA, SizeOf(TRec_Data_Plan_Cordon), netRecv_Plan_Cordon_Data);
  NetHandle.RegisterUDPPacket(CPID_PLAN_CORDON_TRACKS, SizeOf(TRec_Plan_Cordon_Tracks), netRecv_Plan_Cordon_Tracks);
  NetHandle.RegisterUDPPacket(CPID_TRACK_POSITIONING, SizeOf(TRec_Track_Position), netRecv_Track_Positioning);
  NetHandle.RegisterUDPPacket(CPID_DATA_TARGET_EXOCET, SizeOf(TRec_Data_Target_Exocet), netRecv_Data_Target_Exocet);
  NetHandle.RegisterUDPPacket(CPID_PLAN_MISSILE, SizeOf(TRec_Plan_Missile), netRecv_PlanMissile);
  NetHandle.RegisterUDPPacket(CPID_MISSILE_PARAMETER, SizeOf(TRec_Missile_Parameter), netRecv_MissileParameter);
  NetHandle.RegisterUDPPacket(CPID_FIRING_SQUENCE, SizeOf(TRec_Missile_Firing_Squence), netRecv_FiringSquence);
  NetHandle.RegisterUDPPacket(CPID_EXOCET_TARGET_OBJECT, SizeOf(TRec_Data_exocet), netRecv_Exocet_Target_Object);
  NetHandle.RegisterUDPPacket(CPID_FA_CODE, SizeOf(TRec_FA_Code), netRecv_FA_Code);
  NetHandle.RegisterUDPPacket(CPID_MW08_SIMULATOR, SizeOf(TRec_MW08_simulator), netRecv_MW08_Simulator);
  NetHandle.RegisterUDPPacket(CPID_NAV_ZIGZAG, SizeOf(TRec_Data_Nav_ZigzagPlan), netRecv_Nav_Zigzag_Data);
  NetHandle.RegisterUDPPacket(CPID_NAV_ZIGZAG_PL, SizeOf(TRec_Data_Pl_Nav_ZigzagPlan), netRecv_Nav_Zigzag_Data_PL);
  NetHandle.RegisterUDPPacket(CPID_HOLDFIRE_REPORT_DEF, SizeOf(TRec_HoldfireReportDef), netRecv_HoldfireReportDef);
  NetHandle.RegisterUDPPacket(CPID_MM40_MOVEMENT, SizeOf(TRec_ExocetMM40_Movement), netRecv_MM40_Movement);
  NetHandle.RegisterUDPPacket(CPID_TRACK_IFF_CODE, SizeOf(TRec_Track_IFF_Code), netRecv_Track_IFF_Code);

  {SPS}
  NetHandle.RegisterUDPPacket(CPID_MISSILE_POS_TCMS, SizeOf(TRecMissilePosTCMS), netRecv_MissilePos);

  {ASW Danger Zones}
  NetHandle.RegisterUDPPacket(CPID_ASW_DANGER_ZONES, SizeOf(TRec_ASWDangerZones), netRecv_ASWDangerZones);

  {Throw Off Control}
  NetHandle.RegisterUDPPacket(CPID_THROW_OFF_CONTROL, SizeOf(TRec_Throw_Off_Control), netRecv_Throw_Off_control);
  NetHandle.RegisterUDPPacket(CPID_GAME_SYNC, SizeOf(TRec_GameSync), netRecv_GameSync);
  NetHandle.RegisterUDPPacket(CPID_SESSION_AVAILABLE, SizeOf(TRec_Session), netRecv_SessionAvailable);

  {sent Mail Ica}
  NetHandle.RegisterUDPPacket(CPID_Sent_Item_Mail, SizeOf(TRec_Data_SentItemMail), netRecv_Sent_Item_Mail_Data);
  NetHandle.RegisterUDPPacket(CPID_StatusMail, SizeOf(TRec_Data_StatusMail),netRecv_Status_Mail );
  {ecm icha}
  NetHandle.RegisterUDPPacket(CPID_ECM_ENGAGEMENT, Sizeof(TRec_ECMEngagement), netRecv_ECMEngagement);
  NetHandle.RegisterUDPPacket(CPID_ECM_SIMULATOR, Sizeof(TRec_ECMSimulator), netRecv_ECMSimulator);
  NetHandle.RegisterUDPPacket(CPID_ECM_AUTH, SizeOf(TRec_ECMEAuth), netRecv_ECMAuth);
  {EMCON }
  NetHandle.RegisterUDPPacket(CPID_DATA_EMCON_Plan1, SizeOf(TRec_EmconPlan1), netRecv_EmconPlan1);
  NetHandle.RegisterUDPPacket(CPID_DATA_EMCON_Plan2, SizeOf(TRec_EmconPlan2), netRecv_EmconPlan2);

  NetHandle.RegisterUDPPacket(CPID_ESM_BRN_TRACK_DATA, Sizeof(TRec_Data_ESM_Brn_Track), netrecv_ESM_Brn_Track_Data);

  {IFF Simulator}
  NetHandle.RegisterUDPPacket(CPID_IFF_PLOT, SizeOf(TRec_Data_IFF_Plot), netRecv_IFF_Data);
  NetHandle.RegisterUDPPacket(CPID_IFF_Plot_Monit, SizeOf(TRec_Data_IFF_Monit), netRecv_IFF_Plot_Monit);
//  NetHandle.RegisterUDPPacket(CPID_IFF_Plot_Display, SizeOf(TRec_Data_IFF_Display), netRecv_IFF_Plot_Display);
  NetHandle.RegisterUDPPacket(CPID_IFF_SIMULATOR, SizeOf(TRec_IFF_Simulator), netRecv_IFF_Simulator);
  NetHandle.RegisterUDPPacket(CPID_IFF_TRANSPOND_CTRL, SizeOf(TRec_IFF_TranspondCtrl), netRecv_IFF_Transpond_Ctrl);
  NetHandle.RegisterUDPPacket(CPID_IFF_TRANSPOND_MC, SizeOf(TRec_IFF_TranspondMC), netRecv_IFF_Transpond_MC);
  NetHandle.RegisterUDPPacket(CPID_IFF_INTERROGATIONS, SizeOf(TRec_IFF_Interrogations), netRecv_IFF_Interrogations);
  NetHandle.RegisterUDPPacket(CPID_IFF_SECTOR_LIST, SizeOf(TRec_Data_IFF_Sector), netRecv_IFF_Sectors_List);

  NetHandle.RegisterUDPPacket(CPID_76MM_BULLET_MOVEMENT, SizeOf(TRec_76mm_Bullet_Movement), netRecv_76mm_Bullet_Movement);

  {track Monitor}
  NetHandle.RegisterUDPPacket(CPID_TRACK_MONIT_DATA, SizeOf(TRec_Track_Monitor), netRecv_Track_Monit_Data);
  {Tactical Figure}
  NetHandle.RegisterUDPPacket(CPID_LIST_TACTICAL_FIGURE, SizeOf(TRec_List_Tactical_Figure), netRecv_TactFigure_List_Data);
  NetHandle.RegisterUDPPacket(CPID_VISUAL_TACTICAL_FIGURE, SizeOf(TRec_Visual_Tactical_Figure), netRecv_TactFigure_Visual_Data);
  NetHandle.RegisterUDPPacket(CPID_VISUAL_TACTICAL_FIGURE_GROUP, SizeOf(TRec_Visual_Tactical_Figure_Group), netRecv_TactFigure_Group_Visual_Data);
  NetHandle.RegisterUDPPacket(CPID_VISUAL_POLYGON, SizeOf(TRec_Visual_Polygon), netRecv_TactFigure_Polygon);
  NetHandle.RegisterUDPPacket(CPID_VISUAL_POLYLINE, SizeOf(TRec_Visual_Polyline), netRecv_TactFigure_Polyline);

  {Geographic Situation}
  NetHandle.RegisterUDPPacket(CPID_LIST_GEO_SITUATION, SizeOf(TRec_List_Geographic_situation), netRecv_Geo_List_Data);
  NetHandle.RegisterUDPPacket(CPID_VISUAL_GEO_FIG, SizeOf(TRec_Visual_Tactical_Figure), netRecv_Geo_Visual_Data);
  NetHandle.RegisterUDPPacket(CPID_GEOVISUAL_POLYLINE, SizeOf(TRec_Visual_Polyline), netRecv_Geo_Polyline);
  NetHandle.RegisterUDPPacket(CPID_GEOVISUAL_POLYGON, SizeOf(TRec_Visual_Polygon), netRecv_Geo_Polygon);

  {Area Alert}
  NetHandle.RegisterUDPPacket(CPID_AREA_ALERT, SizeOf(TRec_Area_Alert_Warning), netRecv_Area_Alert);

  NetHandle.RegisterUDPPacket(CPID_LINKY_SETTING, SizeOf(TRec_LinkY_Setting), netRecv_LinkYSetting);

  NetHandle.RegisterUDPPacket(CPID_SONAR_STATUS, SizeOf(TRec_Sonar_Status), netRecv_Sonar_Status);

  NetHandle.RegisterUDPPacket(CPID_ASW_UNIT_INCLUDED, SizeOf(TRec_ASWUnit), netRecv_ASWUnit);

  {OS Environment}
  NetHandle.RegisterUDPPacket(CPID_MAGNETIC_VAR, SizeOf(TRec_Magnetic_Var), netRecv_Data_MagneticVar);
  NetHandle.RegisterUDPPacket(CPID_BAROMETRIC_PRESS, SizeOf(TRec_Barometric_Pressure), netRecv_Data_Barometric);
  NetHandle.RegisterUDPPacket(CPID_HUMIDITY, SizeOf(TRec_Humidity), netRecv_Data_Humidity);
  NetHandle.RegisterUDPPacket(CPID_AIR_TEMPERATURE, SizeOf(TRec_Air_Temperature), netRecv_Data_Air_Temperature);
  NetHandle.RegisterUDPPacket(CPID_DEPTH, SizeOf(TRec_Depth), netRecv_Data_Depth);
  NetHandle.RegisterUDPPacket(CPID_WIND, SizeOf(TRec_Wind), netRecv_Data_Wind);
  NetHandle.RegisterUDPPacket(CPID_DRIFT, SizeOf(TRec_Drift), netRecv_Data_Drift);
  NetHandle.RegisterUDPPacket(CPID_REL_OS_POSS, SizeOf(TRec_Relative_OS_Poss), netRecv_Data_Rel_OS_Poss);
  NetHandle.RegisterUDPPacket(CPID_ENVI_DATE_TIME, SizeOf(TRec_Envi_Date_Time), netRecv_Data_Envi_Date_Time);
end;

//procedure Receive Message

procedure TMessage_Handling.netRecv_ChangeLib(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Change_Library;
  MyIP: string;
  LibID: Integer;
  LibStatus: Boolean;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  LibID     := rec^.LibID;
  LibStatus := rec^.LibStatus;

  if Assigned(FOnLibraryChange) then
    FOnLibraryChange(LibID, LibStatus);
end;

procedure TMessage_Handling.netRecv_ChangeRole(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Change_Role;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnRoleChangeState) then
      FOnRoleChangeState(rec^.RoleID, rec^.UserID, rec^.RoleStatus);
end;

procedure TMessage_Handling.netRecv_Change_Idnt_Hf(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Change_Identity_HF;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnChangeIdent) then
    FOnChangeIdent(apRec);
end;

procedure TMessage_Handling.netRecv_Change_Track_Desc(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Change_Track_Description;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnChangeTrackDesc) then
    FOnChangeTrackDesc(apRec);
end;

procedure TMessage_Handling.netRecv_Confirm_Target_Torpedo(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Torpedo_ConfirmTarget;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSetTorpedoConfirmTarget) then
    FOnSetTorpedoConfirmTarget(apRec);
end;

procedure TMessage_Handling.netRecv_Track_IFF_Code(aprec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Track_IFF_Code;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrackDataIFFCode) then
    FOnTrackDataIFFCode(apRec);

end;

procedure TMessage_Handling.netRecv_DataFireTetral(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_Fire_Tetral;
begin
  rec := @apRec^;

//  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
//    Exit;
  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnFireTetral) then
    FOnFireTetral(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Air_Temperature(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Air_Temperature;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataAirTemperature) then
    FOnSyncDataAirTemperature(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Area_MW08(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_Area_MW08;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataAreaMW08) then
    FOnDataAreaMW08(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Barometric(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Barometric_Pressure;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataBarometric) then
    FOnSyncDataBarometric(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoyAuto(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_DecoyAuto;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyAutoData) then
    FOnDecoyAutoData(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoyController(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_DecoyController;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataDecoyController) then
    FOnDataDecoyController(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoyFiring(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Decoy_Firing;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyFiring) then
    FOnDecoyFiring(apRec, rec^.OrderID);

end;

procedure TMessage_Handling.netRecv_Data_DecoyLauncher(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_DecoyLauncher;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataDecoyLauncher) then
    FOnDataDecoyLauncher(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoyFiringQueue(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Decoy_Queue;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyFiringQueue) then
    FOnDecoyFiringQueue(apRec, rec^.OrderID);

end;

procedure TMessage_Handling.netRecv_Data_DecoyLaunchQueue(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Decoy_Queue;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyLaunchQueue) then
    FOnDecoyLaunchQueue(apRec, rec^.OrderID);

end;

procedure TMessage_Handling.netRecv_Data_DecoyLCC(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Decoy_LCC;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyLCC) then
    FOnDecoyLCC(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoySim(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_DecoySim;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataDecoySim) then
    FOnDataDecoySim(apRec);

end;

procedure TMessage_Handling.netRecv_Data_DecoySysMode(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_DecoySysModeChg;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataDecoySysMode) then
    FOnDataDecoySysMode(apRec);

end;

procedure TMessage_Handling.netRecv_Data_Depth(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Depth;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDepthValue) then
   FOnSyncDepthValue(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Drift(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Drift;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataDrift) then
   FOnSyncDataDrift(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Envi_Date_Time(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Envi_Date_Time;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;
  if Assigned(FOnSyncDataEnviDateTime) then
    FOnSyncDataEnviDateTime(apRec);

end;

procedure TMessage_Handling.netRecv_Data_Eval_Tracklist(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Eval_Tracklist;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnEvalTracklist) then
    FOnEvalTracklist(apRec);

end;

procedure TMessage_Handling.netRecv_Data_Gun76(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Gun76;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataGun76) then
    FOnDataGun76(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Humidity(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Humidity;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataHumidity) then
    FOnSyncDataHumidity(apRec);
end;

procedure TMessage_Handling.netRecv_Data_ICM(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_ICM;
  RoleSend, RoleRecv : Integer;
  PosX, PosY : Double;
  MyIP: string;
  found: Boolean;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
  Exit;

  RoleSend := rec^.SenderRole;
  RoleRecv := rec^.RecvRole;
  PosX     := rec^.PosX;
  PosY     := rec^.PosY;

  if Assigned(FOnCreateICM) then
    FOnCreateICM(RoleSend, RoleRecv, PosX, PosY);
end;



procedure TMessage_Handling.netRecv_Data_MagneticVar(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Magnetic_Var;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataMagneticVar) then
    FOnSyncDataMagneticVar(apRec);

end;

procedure TMessage_Handling.netRecv_Data_RadarMW08(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_MW08;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataRadarMW08) then
    FOnDataRadarMW08(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Rel_OS_Poss(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Relative_OS_Poss;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataRelOSEnvi) then
    FOnSyncDataRelOSEnvi(apRec);

end;

procedure TMessage_Handling.netRecv_Data_SectorScreen(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_SectorScreen;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataSectorScreen) then
    FOnDataSectorScreen(apRec);

end;

procedure TMessage_Handling.netRecv_SectorScreen_Object(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_SectorScreen_Object;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSectorScreenObject) then
    FOnSectorScreenObject(apRec);
end;


procedure TMessage_Handling.netRecv_SelWasaChannel(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_SelWasaChannel;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSelWasaChannel) then
    FOnSelWasaChannel(apRec)
end;

procedure TMessage_Handling.netRecv_Data_Target_Exocet(apRec: PAnsiChar;
  aSize: word);
var
  rec : ^TRec_Data_Target_Exocet;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataExocetTargetStatus) then
    FOnDataExocetTargetStatus(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Tetra(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_Tetral;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

//  if Assigned(FOnDataTetral) then
//    FOnDataTetral(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Tetral2(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_Tetral2;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataTetral2) then
    FOnDataTetral2(apRec);
end;

procedure TMessage_Handling.netRecv_Data_Threat_Eval(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Threat_Eval_Values;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnThreatEvalData) then
    FOnThreatEvalData(apRec);

end;

procedure TMessage_Handling.netRecv_Data_TrkSelAir(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_TrackSelAirSetting;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrkSelAirSetting) then
    FOnTrkSelAirSetting(apRec);

end;

procedure TMessage_Handling.netRecv_Data_Wasa(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_Wasa;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataWasa) then
    FOnDataWasa(apRec)
end;

procedure TMessage_Handling.netRecv_Data_Wind(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Wind;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncDataWind) then
    FOnSyncDataWind(apRec);

end;

procedure TMessage_Handling.netRecv_Data_Nav_Stationing(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_NavData_Stationing;
begin

  rec:= @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnNavDataStationing) then
    FOnNavDataStationing(apRec);

end;

procedure TMessage_Handling.netRecv_Data_NGS(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_NGS;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnDataNGS) then
    FOnDataNGS(apRec)
end;

procedure TMessage_Handling.netRecv_Data_On_TCMS(apRec: PAnsiChar; aSize: word);
var
  rec : ^TRec_Data_On_Console;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnGetTCMSIsON) then
    FOnGetTCMSIsON(apRec);
end;

procedure TMessage_Handling.netRecv_DecoyDesigOps(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Decoy_Desig_Ops;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDecoyDesigOps) then
    FOnDecoyDesigOps(apRec);

end;

procedure TMessage_Handling.netRecv_Desigt_A244(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_A244;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDesigtA244) then
    FOnDesigtA244(apRec);
end;

procedure TMessage_Handling.netRecv_76mm_Bullet_Movement(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_76mm_Bullet_Movement;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOn76mmBulletMovement) then
    FOn76mmBulletMovement(apRec);

end;

procedure TMessage_Handling.netRecv_Area_Alert(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Area_Alert_Warning;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncAreaAlert) then
    FOnSyncAreaAlert(apRec);
end;

procedure TMessage_Handling.netRecv_ARPA_DetectedTrack(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_ARPA_DetectedTrack;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnARPADetected) then
    FOnARPADetected(apRec);
end;

procedure TMessage_Handling.netRecv_ASWDangerZones(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_ASWDangerZones;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnASWDangerZones) then
    FOnASWDangerZones(apRec);
end;

procedure TMessage_Handling.netRecv_ASWUnit(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_ASWUnit;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnASWUnitIncluded) then
    FOnASWUnitIncluded(apRec);
end;

procedure TMessage_Handling.netRecv_Break_A244(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_A244;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnBreakA244) then
    FOnBreakA244(apRec);
end;


procedure TMessage_Handling.netRecv_SessionAvailable(apRec: PAnsiChar;
  aSize: Word);
begin
  if Assigned(FOnSessionAvailble) then
    FOnSessionAvailble(apRec);
end;


procedure TMessage_Handling.netRecv_Sent_Item_Mail_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_SentItemMail;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataSentItemMail) then
    FOnDataSentItemMail(apRec);
end;

procedure TMessage_Handling.netRecv_Set_Data_A244(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_A244;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataA244) then
    FOnDataA244(apRec);
end;

procedure TMessage_Handling.netRecv_Set_Tube_Content(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_B515TubeContent;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataTubeContent) then
    FOnDataTubeContent(apRec);
end;

procedure TMessage_Handling.netRecv_Snaps(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_Snapshot;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma)then
    Exit;

  if Assigned(FOnSnapshotData) then
    FOnSnapshotData(apRec);

end;


procedure TMessage_Handling.netRecv_Sonar_Envi(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Sonar_Envi;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSetSonarEnvi) then
    FOnSetSonarEnvi(apRec);

end;

procedure TMessage_Handling.netRecv_Sonar_Status(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Sonar_Status;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSonarStatus) then
    FOnSonarStatus(apRec);
end;

procedure TMessage_Handling.netRecv_Sonar_Sync(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Sonar_Sync;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSonarSync) then
    FOnSonarSync(apRec);
end;

procedure TMessage_Handling.netRecv_Desigt_Exocet(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Exocet;
  ObjectID, TargetID : Integer;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  ObjectID := StrToInt(rec^.ObjectID);
  TargetID := rec^.TargetID;

  if Assigned(FOnDesigtExocet) then
    FOnDesigtExocet(ObjectID, TargetID);
end;

procedure TMessage_Handling.netRecv_Desigt_Gun76(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Gun76;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDesigt76) then
    FOnDesigt76(apRec);
end;

procedure TMessage_Handling.netRecv_Desigt_Tetral(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Fire_Tetral;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDesigtTetral) then
    FOnDesigtTetral(apRec);
end;

procedure TMessage_Handling.netRecv_Break_Gun76(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Gun76;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnBreak76) then
    FOnBreak76(apRec);
end;

procedure TMessage_Handling.netRecv_Break_Tetral(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Fire_Tetral;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnBreakTetral) then
    FOnBreakTetral(apRec);
end;

procedure TMessage_Handling.netRecv_Break_Exocet(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Exocet;
  ObjectID, TargetID : Integer;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  ObjectID := StrToInt(rec^.ObjectID);
  TargetID := rec^.TargetID;

  if Assigned(FOnBreakExocet) then
    FOnBreakExocet(ObjectID, TargetID);
end;

procedure TMessage_Handling.netRecv_Device_State(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Device_State;
  ParentID, DeviceID: Integer;
  State: Byte;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (IntToStr(rec^.ParentID) <> IDShipSigma) then
    Exit;

  DeviceID := rec^.DeviceID;
  State    := rec^.DeviceState;
  ParentID := rec^.ParentID;

  if Assigned(FOnDeviceChangeState) then
    FOnDeviceChangeState(ParentID, DeviceID, State);
end;

procedure TMessage_Handling.netRecv_Engage_Manual_Track(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Track_Movement;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnEngageManualTrack) then
    FOnEngageManualTrack(apRec);

  if Assigned(OnLogEvtSt) then
    OnLogEvtSt('netRecv_Engage_Manual_Track from ' + rec^.MOCSender + ' ram object id = ' + rec^.ObjectID);
end;

procedure TMessage_Handling.netRecv_EnvironmentData(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Natural_Envi;
  //speed, Course, X, Y, Time: Double;
  //OrderId: Byte;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  //Time    := rec^.pid.recTime;
  //speed   := rec^.Speed;

  if Assigned(FOnDataEnvironment) then
    FOnDataEnvironment(apRec);

end;

procedure TMessage_Handling.netrecv_ESM_Brn_Track_Data(aprec: PAnsiChar;
  aSize: Word);
var
  Rec : ^TRec_Data_ESM_Brn_Track;
begin
  Rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataESMBrnTrack) then
    FOnDataESMBrnTrack(apRec);
end;

procedure TMessage_Handling.netRecv_Exocet_Target_Object(apRec: PAnsiChar;
  aSize: Word);
var
  Rec : ^TRec_Data_Exocet;
begin
  Rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataExocetTargetObject) then
    FOnDataExocetTargetObject(apRec);
end;

procedure TMessage_Handling.netRecv_Fire76(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Gun76;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnFire76) then
    FOnFire76(apRec, aSize);
end;

procedure TMessage_Handling.netRecv_FireTorpedoA244(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_FireTorpedoA244;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnFireTorpedoA244) then
    FOnFireTorpedoA244(apRec)
end;

procedure TMessage_Handling.netRecv_FireTorpedoSPS(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRecDataTorperdoTCMS;
begin
  rec := @apRec^;

  if rec^.SessionID = SessionID then
  begin
    if Assigned(FOnFireTorpedoSPS) then
      FOnFireTorpedoSPS(apRec);
  end
end;

procedure TMessage_Handling.netRecv_FA_Code(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_FA_Code;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnFACode) then
    FOnFACode(apRec);

end;

procedure TMessage_Handling.netRecv_Fire_Exocet(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Fire_Exocet;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FFireExocet) then
    FFireExocet(apRec);
end;

procedure TMessage_Handling.netRecv_FiringSquence(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Missile_Firing_Squence;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataFiringSquence) then
    FOnDataFiringSquence(apRec);
end;

procedure TMessage_Handling.netRecv_GameSync(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_GameSync;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnGameSync) then
    FOnGameSync(apRec);
end;

procedure TMessage_Handling.netRecv_Geo_List_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_List_Geographic_situation;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncListGeoSituation) then
    FOnSyncListGeoSituation(apRec);
end;

procedure TMessage_Handling.netRecv_Geo_Polygon(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Visual_Polygon;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncVisualPolygonGeo) then
    FOnSyncVisualPolygonGeo(apRec);

end;

procedure TMessage_Handling.netRecv_Geo_Polyline(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Visual_Polyline;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncVisualPolylineGeo) then
    FOnSyncVisualPolylineGeo(apRec);

end;

procedure TMessage_Handling.netRecv_Geo_Visual_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Visual_Polyline;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncVisualGeo) then
    FOnSyncVisualGeo(apRec);
end;

procedure TMessage_Handling.netRecv_GIC76Setting(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Data_GIC76;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnGetGICSetting) then
    FOnGetGICSetting(apRec);
end;


procedure TMessage_Handling.netRecv_HoldFireReportDef(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_HoldfireReportDef;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnHoldfireReportDef) then
    FOnHoldfireReportDef(apRec);
end;

procedure TMessage_Handling.netRecv_IDGenerator(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_IDGenerator;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnIDGenerator) then
    FOnIDGenerator(apRec);
end;

procedure TMessage_Handling.netRecv_IFF_Data(aprec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_IFF_Plot;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataIFFPlot) then
    FOnDataIFFPlot(apRec);

end;

procedure TMessage_Handling.netRecv_IFF_Interrogations(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_IFF_Interrogations;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnIFFInterrogations) then
    FOnIFFInterrogations(apRec);

end;

//procedure TMessage_Handling.netRecv_IFF_Plot_Display(aprec: PAnsiChar;
//  aSize: Word);
//var
//  rec : ^TRec_Data_IFF_Display;
//begin
//  rec := @aprec^;
//
//  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
//    Exit;
//
//  if Assigned(FOnDataIFFPlotDisplay) then
//    FOnDataIFFPlotDisplay(apRec);
//
//end;

procedure TMessage_Handling.netRecv_IFF_Plot_Monit(aprec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_IFF_Monit;
begin
  rec := @aprec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataIFFPlotMonit) then
    FOnDataIFFPlotMonit(apRec);

end;

procedure TMessage_Handling.netRecv_IFF_Sectors_List(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_IFF_Sector;
begin
  rec := @aprec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaId <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataIFFSectorsList) then
    FOnDataIFFSectorsList(apRec);

end;


procedure TMessage_Handling.netRecv_IFF_Simulator(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_IFF_Simulator;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnIFFSimulator) then
    FOnIFFSimulator(apRec);
end;

procedure TMessage_Handling.netRecv_IFF_Transpond_Ctrl(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_IFF_TranspondCtrl;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnIFFTranspondCtrl) then
    FOnIFFTranspondCtrl(apRec);

end;

procedure TMessage_Handling.netRecv_IFF_Transpond_MC(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_IFF_TranspondMC;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnIFFTranspondMC) then
    FOnIFFTranspondMC(apRec);

end;

procedure TMessage_Handling.netRecv_InitDecoyFiring(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Data_Init_Decoy_Firing;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnInitDecoyFiring) then
    FOnInitDecoyFiring(apRec);

end;

procedure TMessage_Handling.netRecv_LinkYSetting(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_LinkY_Setting;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnLinkYSetting) then
    FOnLinkYSetting(apRec);

end;

procedure TMessage_Handling.netRecv_LIROD(aprec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_LIROD_MK2;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnDataLIROD) then
    FOnDataLIROD(apRec);
end;

procedure TMessage_Handling.netRecv_LIROD_SearchSector(aprec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_LIROD_SearchSector;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnLirodSearchSector) then
    FOnLirodSearchSector(apRec);

end;

procedure TMessage_Handling.netRecv_LIROD_Setting(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_LIROD_Setting;
begin

  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnLirodSetting) then
    FOnLirodSetting(apRec);

end;

procedure TMessage_Handling.netRecv_Mail_Data(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Mail;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataMail) then
    FOnDataMail(apRec);
end;

procedure TMessage_Handling.netRecv_Mail_Value_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_MailValue;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataMailValue) then
    FOnDataMailValue(apRec);
end;

procedure TMessage_Handling.netRecv_Man_Overboard_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Man_Overboard;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataManOverboard) then
    FOnDataManOverboard(apRec);
end;

procedure TMessage_Handling.netRecv_Man_Overboard_Pos(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Man_Overboard_Pos;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnManOverboardPos) then
    FOnManOverboardPos(apRec);
end;

procedure TMessage_Handling.netRecv_MissileParameter(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Missile_Parameter;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.sigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataMissileParameter) then
    FOnDataMissileParameter(apRec);
end;

procedure TMessage_Handling.netRecv_MissilePos(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRecMissilePosTCMS;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnMissilePos) then
    FOnMissilePos(apRec);
end;

procedure TMessage_Handling.netRecv_MM40_Movement(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_ExocetMM40_Movement;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnMM40Movement) then
    FOnMM40Movement(apRec);
end;

procedure TMessage_Handling.netRecv_MovementData(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Movement;
  speed, Course, X, Y, Time: Double;
  OrderId: Byte;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  Time    := rec^.pid.recTime;
  speed   := rec^.Speed;

  if Assigned(FOnSyncDataObj) then
    FOnSyncDataObj(apRec);
end;

procedure TMessage_Handling.netRecv_MW08_Simulator(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_MW08_Simulator;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnMW08Simulator) then
    FOnMW08Simulator(apRec);
end;

procedure TMessage_Handling.netRecv_Nav_Route_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Nav_Route;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataNavRoute) then
    FOnDataNavRoute(apRec);
end;

procedure TMessage_Handling.netRecv_Nav_Route_Data_WP(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_WP_Nav_Route;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataWPNavRoute) then
    FOnDataWPNavRoute(apRec);
end;

procedure TMessage_Handling.netRecv_Nav_Zigzag_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Nav_ZigzagPlan;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataNavZigzag) then
    FOnDataNavZigzag(apRec);
end;

procedure TMessage_Handling.netRecv_Nav_Zigzag_Data_CatalogueValue(
  apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Nav_ZigzagCatalogueValue;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataZigzagCatalogueValue) then
    FOnDataZigzagCatalogueValue(apRec);

end;

procedure TMessage_Handling.netRecv_Nav_Zigzag_Data_PL(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Pl_Nav_ZigzagPlan;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataPLNavZigzag) then
    FOnDataPLNavZigzag(apRec);
 end;

procedure TMessage_Handling.netRecv_NGS_Target(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_NGS_Target;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnNGSTarget) then
    FOnNGSTarget(apRec)
end;

procedure TMessage_Handling.netRecv_ScenarioSync(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_ScenarioSync;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) and (rec^.SigmaID <> IDShipSigma)  then
    Exit;

  if Assigned(FOnSyncScenario) then
    FOnSyncScenario(aprec);
end;

procedure TMessage_Handling.netRecv_Req_Connect(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_Connect;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;
end;

procedure TMessage_Handling.netRecv_State_Exocet(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_State_Exocet;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnStateExocet) then
    FOnStateExocet(apRec);
end;

procedure TMessage_Handling.netRecv_Stationing_RefObj(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Stationing_RefObj;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnStationingRefObj) then
    FOnStationingRefObj(apRec);

end;

procedure TMessage_Handling.netRecv_Status_Mail(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_StatusMail;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataStatusMail) then
    FOnDataStatusMail(apRec);
end;

procedure TMessage_Handling.netRecv_TactFigure_Group_Visual_Data(
  apRec: PAnsiChar; asize: Word);
var
  rec : ^TRec_Visual_Tactical_Figure_Group;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma)then
    Exit;

  if Assigned(FOnSyncVisualTactFigureGroup) then
    FOnSyncVisualTactFigureGroup(apRec);

  if Assigned(FOnSyncListTactFigure) then
    FOnSyncListTactFigure(apRec);

end;

procedure TMessage_Handling.netRecv_TactFigure_List_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_List_Tactical_Figure;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncListTactFigure) then
    FOnSyncListTactFigure(apRec);
end;

procedure TMessage_Handling.netRecv_TactFigure_Polygon(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Visual_Polygon;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncVisualPolygon) then
    FOnSyncVisualPolygon(apRec);

end;

procedure TMessage_Handling.netRecv_TactFigure_Polyline(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Visual_Polyline;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnSyncVisualPolyline) then
    FOnSyncVisualPolyline(apRec);

end;

procedure TMessage_Handling.netRecv_TactFigure_Visual_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Visual_Tactical_Figure;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma)then
    Exit;

  if Assigned(FOnSyncVisualTactFigure) then
    FOnSyncVisualTactFigure(apRec);

end;

procedure TMessage_Handling.netRecv_TDS_Port(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_TDS_Data;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnTdsPort) then
    FOnTdsPort(apRec);
end;

procedure TMessage_Handling.netRecv_TDS_Stbd(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_TDS_Data;
begin
  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if Assigned(FOnTdsStbd) then
    FOnTdsStbd(apRec);
end;

procedure TMessage_Handling.netrecv_Throw_Off_Control(aprec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Throw_Off_Control;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnThrowOffControl) then
    FOnThrowOffControl(apRec);
end;


procedure TMessage_Handling.netRecv_Track_Detect(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Track_Detection;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrackDetect) then
    FOnTrackDetect(apRec);

end;

procedure TMessage_Handling.netRecv_Track_Monit_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Track_Monitor;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.ObjectID <> IDShipSigma)  then
    Exit;

  if Assigned(FOnTrackMonitorData) then
    FOnTrackMonitorData(apRec);

end;

procedure TMessage_Handling.netRecv_Track_Movement(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Track_Movement;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnTrackMovement) then
    FOnTrackMovement(apRec);
end;

procedure TMessage_Handling.netRecv_Track_Positioning(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Track_Position;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrackPositioning) then
    FOnTrackPositioning(apRec);
end;

procedure TMessage_Handling.netRecv_Track_Shift(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Track_Shift;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrackShift) then
    FOnTrackShift(apRec);

end;

procedure TMessage_Handling.netRecv_Track_Sources(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_Track_Sources;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.SigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTrackSources) then
    FOnTrackSources(apRec);

end;

procedure TMessage_Handling.netRecv_TSMC(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Data_TSMC;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnTSMCChange) then
    FOnTSMCChange(apRec);
end;


procedure TMessage_Handling.netRecv_WasaChanProperties(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_WasaChanProperties;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnWasaChannelProp) then
    FOnWasaChannelProp(apRec)
end;

procedure TMessage_Handling.netRecv_Object_Data(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Object_Data;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnDataObject) then
    FOnDataObject(apRec);
end;


procedure TMessage_Handling.netRecv_ECMAuth(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_ECMEAuth;
begin
  rec := @apRec^;

  if Assigned(FOnECMAuth) then
    FOnECMAuth(apRec);
end;

procedure TMessage_Handling.netRecv_ECMEngagement(apRec: PAnsiChar;
  aSize: Word);
var
  rec : ^TRec_ECMEngagement;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) and (rec^.IDSigma <> IDShipSigma) then
    Exit;

  if Assigned(FOnECMEngagement) then
    FOnECMEngagement(apRec);
end;

procedure TMessage_Handling.netRecv_ECMSimulator(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_ECMSimulator;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) and (rec^.IDSigma <> IDShipSigma) then
    Exit;

  if Assigned(FonECMSimulator) then
    FonECMSimulator(apRec);
end;

procedure TMessage_Handling.netRecv_EmconPlan1(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_EmconPlan1;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnEmconPlan1) then
    FOnEmconPlan1(apRec);
end;

procedure TMessage_Handling.netRecv_EmconPlan2(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_EmconPlan2;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnEmconPlan2) then
    FOnEmconPlan2(apRec);
end;

procedure TMessage_Handling.netRecv_Emitter_Data(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_Emitter_Data;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) and (rec^.IDShigma <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataEmitter) then
    FOnDataEmitter((apRec));

end;

procedure TMessage_Handling.netRecv_PAC(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_PAC_Data;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnDataPAC) then
    FOnDataPAC(apRec);
end;

procedure TMessage_Handling.netRecv_PAC_Target(apRec: PAnsiChar; aSize: Word);
var
  rec: ^TRec_PAC_Target;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) then
    Exit;

  if Assigned(FOnTargetPAC) then
    FOnTargetPAC(apRec);

end;

procedure TMessage_Handling.netRecv_PlanMissile(apRec: PAnsiChar; aSize: Word);
var
  rec : ^TRec_Plan_Missile;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.sigmaID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataPlanMissile) then
    FOnDataPlanMissile(apRec);
end;

procedure TMessage_Handling.netRecv_Plan_Cordon_Data(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Data_Plan_Cordon;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnDataPlanCordon) then
    FOnDataPlanCordon(apRec);
end;

procedure TMessage_Handling.netRecv_Plan_Cordon_Tracks(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^TRec_Plan_Cordon_Tracks;
begin
  rec := @apRec^;

  if (rec^.SessionID <> FSessionID) or (rec^.objectID <> IDShipSigma) then
    Exit;

  if Assigned(FOnPlanCordonTracks) then
    FOnPlanCordonTracks(apRec);
end;

//Procedure Send Message
procedure TMessage_Handling.Send_DecoyDesigOps(rec: TRec_Decoy_Desig_Ops);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DECOY_DESIG_OPS, @rec);
end;

procedure TMessage_Handling.Send_Desigt_A244(rec: TRec_Data_A244);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DESIGT_A244, @rec);
end;

procedure TMessage_Handling.Send_76mm_Bullet_Movement(
  rec: TRec_76mm_Bullet_Movement);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_76MM_BULLET_MOVEMENT, @rec);
end;

procedure TMessage_Handling.Send_Area_Alert(rec: TRec_Area_Alert_Warning);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_AREA_ALERT, @rec);
end;

procedure TMessage_Handling.Send_ARPA_DetectedTrack(
  rec: TRec_ARPA_DetectedTrack);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_ARPA_DETECTED, @rec);
end;

procedure TMessage_Handling.Send_ASWDangerZones(rec: TRec_ASWDangerZones);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_ASW_DANGER_ZONES, @rec);
end;

procedure TMessage_Handling.Send_ASWUnit(rec: TRec_ASWUnit);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_ASW_UNIT_INCLUDED, @rec);
end;

procedure TMessage_Handling.Send_Break_A244(rec: TRec_Data_A244);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_BREAK_A244, @rec);
end;

procedure TMessage_Handling.Send_Set_Data_A244(rec: TRec_Data_A244);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_A244, @rec);
end;


procedure TMessage_Handling.Send_Data_SectorScreen(
  aRec: TRec_Data_SectorScreen);
begin
  aRec.SessionID := FSessionID;
  aRec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SECTOR_SCREEN, @aRec);
end;


procedure TMessage_Handling.Send_SectorScreen_Object(
  aRec: TRec_SectorScreen_Object);
begin
  aRec.SessionID := FSessionID;
  aRec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SECTOR_SCREEN_OBJECT, @aRec);
end;

procedure TMessage_Handling.Send_SelWasaChannel(rec: TRec_SelWasaChannel);
begin

  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SEL_WASA_CHAN, @rec);

end;

procedure TMessage_Handling.Send_Sent_Mail(rec: TRec_Data_SentItemMail);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_Sent_Item_Mail, @rec);
end;

procedure TMessage_Handling.Send_Setting_GIC76(rec: TRec_Data_GIC76);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_GIC76, @rec);
end;

procedure TMessage_Handling.Send_Data_WASA(rec: TRec_Data_Wasa);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_WASA, @rec);
end;

procedure TMessage_Handling.Send_Data_Wind(rec: TRec_Wind);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_WIND, @rec);
end;

procedure TMessage_Handling.Send_Data_Nav_Stationing(rec: TRec_NavData_Stationing);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_NAV_STATIONING , @Rec);
end;

procedure TMessage_Handling.Send_Data_NGS(aRec: TRec_Data_NGS);
begin
  aRec.SessionID := FSessionID;
  aRec.SigmaID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_NGS, @aRec);
end;

procedure TMessage_Handling.Send_Set_Tube_Content(rec: TRec_B515TubeContent);
begin
  rec.SessionID := FSessionID;
  rec.ObjectId  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SET_TUBE_CONTENT, @rec);
end;

procedure TMessage_Handling.Send_Snapshot_Data(rec: TRec_Data_Snapshot);
begin
  rec.SessionID := FSessionID;
  rec.pid.recTime := TimeInt;
  rec.ObjectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SNAPSHOT, @rec);
end;

procedure TMessage_Handling.Send_Sonar_Envi(rec: TRec_Sonar_Envi);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SONAR_ENVI, @rec);
end;


procedure TMessage_Handling.Send_Sonar_Status(ARec: TRec_Sonar_Status);
begin
  Arec.SessionID := FSessionID;
  Arec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_SONAR_STATUS, @arec);
end;

procedure TMessage_Handling.Send_Desigt_Exocet(ObjectID, TargetID: Integer);
var
  rec: TRec_Data_Exocet;
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IntToStr(ObjectID);
  rec.TargetID := TargetID;

  NetHandle.SendBroadcast_UDP_Data(CPID_DESIGT_EXOCET, @rec);
end;

procedure TMessage_Handling.Send_Desigt_Gun76(rec: TRec_Gun76);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DESIGT76, @rec);
end;

procedure TMessage_Handling.Send_Desigt_Tetral(rec: TRec_Data_Fire_Tetral);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DESIGT_TETRAL, @rec);
end;

procedure TMessage_Handling.Send_Break_Gun76(rec: TRec_Gun76);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_BREAK76, @rec);
end;

procedure TMessage_Handling.Send_Break_Tetral(rec: TRec_Data_Fire_Tetral);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_BREAK_TETRAL, @rec);
end;

procedure TMessage_Handling.Send_Device_State(ParentID, ObjectID: Integer; StateID: Byte);
var
  rec: TRec_Device_State;
begin
  rec.SessionID   := FSessionID;
  rec.objectID    := IDShipSigma;
  rec.ParentID    := ParentID;
  rec.DeviceID    := ObjectID;
  rec.DeviceState := StateID;

  NetHandle.SendBroadcast_UDP_Data(CPID_DEVICE_STATE, @rec);
end;

procedure TMessage_Handling.Send_ECMAuth(rec: TRec_ECMEAuth);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_ECM_AUTH, @rec);
end;

procedure TMessage_Handling.Send_ECMEngagement(rec: TRec_ECMEngagement);
begin
  rec.SessionID := FSessionID;
  rec.IDSigma := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_ECM_ENGAGEMENT, @rec);
end;

procedure TMessage_Handling.Send_ECMSimulator(rec: TRec_ECMSimulator);
begin
  rec.SessionID := FSessionID;
  rec.IDSigma := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_ECM_Simulator, @rec);
end;

procedure TMessage_Handling.Send_EmconPlan1(rec: TRec_EmconPlan1);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_EMCON_Plan1, @rec);
end;

procedure TMessage_Handling.Send_EmconPlan2(rec: TRec_EmconPlan2);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_EMCON_Plan2, @rec);
end;

procedure TMessage_Handling.Send_Engage_Manual_Track(rec: TRec_Track_Movement);
begin
  rec.SigmaID := IDShipSigma;
  rec.SessionID := FSessionID;


  NetHandle.SendBroadcast_UDP_Data(CPID_MANUAL_TRACK, @rec);

  if Assigned(OnLogEvtSt) then
    OnLogEvtSt('Send_Engage_Manual_Track');

end;

procedure TMessage_Handling.Send_EnvironmentData(rec: TRec_Data_Natural_Envi);
begin
  rec.SessionID  := FSessionID;
  rec.objectID   := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_ENVI_DATA, @rec);
end;

procedure TMessage_Handling.Send_ESM_Brn_Track_Data(
  rec: TRec_Data_ESM_Brn_Track);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_ESM_BRN_TRACK_DATA, @rec);
end;

procedure TMessage_Handling.Send_FA_Code(aRec: TRec_FA_Code);
begin
  aRec.SessionID := FSessionID;
  aRec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_FA_CODE, @aRec);
end;

procedure TMessage_Handling.Send_Fire76(rec: TRec_Gun76; OrdID : Byte);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;
  rec.OrdID := OrdID;
  NetHandle.SendBroadcast_UDP_Data(OrdID, @rec);
end;

procedure TMessage_Handling.Send_FireTorpedoA244(rec: TRec_FireTorpedoA244);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_FIRE_TORPEDO_A244, @rec);
end;

procedure TMessage_Handling.Send_Fire_Exocet;
var
  rec : TRec_Fire_Exocet;
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_FIRE_EXOCET, @rec);
end;

procedure TMessage_Handling.Send_Fire_Tetral(rec: TRec_Data_Fire_Tetral);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_FIRE_TETRAL, @rec);
end;

procedure TMessage_Handling.Send_Geo_List_Data(
  rec: TRec_List_Geographic_situation);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_LIST_GEO_SITUATION, @rec);
end;

procedure TMessage_Handling.Send_Geo_Polygon(rec: TRec_Visual_Polygon);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_GEOVISUAL_POLYGON, @rec);
end;

procedure TMessage_Handling.Send_Geo_Polyline(rec: TRec_Visual_Polyline);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_GEOVISUAL_POLYLINE, @rec);
end;

procedure TMessage_Handling.Send_Geo_Visual_Data(rec: TRec_Visual_Geo_Fig);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_VISUAL_GEO_FIG, @rec);
end;

procedure TMessage_Handling.Send_HoldfireReportDef(
  rec: TRec_HoldfireReportDef);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_HOLDFIRE_REPORT_DEF, @rec);
end;

procedure TMessage_Handling.Send_IDGenerator(rec: TRec_IDGenerator);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_IDGENERATOR, @rec);
end;

procedure TMessage_Handling.Send_IFF_Interrogations(
  rec: TRec_IFF_Interrogations);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_INTERROGATIONS, @rec);

end;

procedure TMessage_Handling.Send_IFF_Plot_Data(rec: TRec_Data_IFF_Plot);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_PLOT, @rec);
end;

procedure TMessage_Handling.Send_IFF_Plot_Monit(rec: TRec_Data_IFF_Monit);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;


  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_Plot_Monit, @rec);
end;

procedure TMessage_Handling.Send_IFF_Sectors_List(
  rec: TRec_Data_IFF_Sector);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_SECTOR_LIST, @rec);
end;


procedure TMessage_Handling.Send_IFF_Transpond_Ctrl(
  rec: TRec_IFF_TranspondCtrl);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_TRANSPOND_CTRL, @rec);
end;

procedure TMessage_Handling.Send_IFF_Transpond_MC(rec: TRec_IFF_TranspondMC);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_TRANSPOND_MC, @rec);
end;

procedure TMessage_Handling.Send_Init_Decoy_Firing(
  rec: TRec_Data_Init_Decoy_Firing);
begin

  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_INIT_DECOY_FIRING, @rec);

end;

procedure TMessage_Handling.Send_Break_Exocet(ObjectID, TargetID: Integer);
var
  rec: TRec_Data_Exocet;
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IntToStr(ObjectID);
  rec.TargetID := TargetID;

  NetHandle.SendBroadcast_UDP_Data(CPID_BREAK_EXOCET, @rec);
end;

procedure TMessage_Handling.Send_LinkY_Setting(rec: TRec_LinkY_Setting);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := FIDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_LINKY_SETTING, @rec);
end;

procedure TMessage_Handling.Send_LIROD_SearchSector(
  ARec: TRec_Lirod_SearchSector);
begin
  ARec.SessionID := FSEssionID;
  ARec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_LIROD_SEARCH_SECTOR, @ARec);
end;

procedure TMessage_Handling.Send_LIROD_Setting(rec: TRec_LIROD_Setting);
begin

  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_LIROD_Setting, @rec);

end;

procedure TMessage_Handling.Send_Change_Idnt_Hf(OrdID : Byte; rec: TRec_Change_Identity_HF);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(OrdID, @rec);
end;

procedure TMessage_Handling.Send_Change_Lib(IDLib: Byte; Status: Boolean);
var
  rec: TRec_Data_Change_Library;
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  rec.LibID     := IDLib;
  rec.LibStatus := Status;

  NetHandle.SendBroadcast_UDP_Data(CPID_LIBRARY, @rec);
end;

procedure TMessage_Handling.Send_Change_Role(IDRole, IDUser: Byte; Status: Boolean);
var
  rec: TRec_Data_Change_Role;
begin
  rec.SessionID  := FSessionID;
  rec.objectID   := IDShipSigma;
  rec.RoleID     := IDRole;
  rec.RoleStatus := Status;
  rec.UserID     := IDUser;

  NetHandle.SendBroadcast_UDP_Data(CPID_CHANGE_ROLE, @rec);
end;

procedure TMessage_Handling.Send_Change_Track_Desc(
  rec: TRec_Change_Track_Description);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_CHANGE_TRACK_DESC, @rec);
end;

procedure TMessage_Handling.Send_Confirm_Target_Torpedo(
  rec: TRec_Torpedo_ConfirmTarget);
begin
  rec.SessionID  := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_CONFIRM_TARGET_TORPEDO, @rec);
end;

procedure TMessage_Handling.Send_ConsoleStatus(rec: TRecStatus_ConsoleTCMS);
begin
  rec.SessionID  := FSessionID;
  rec.OWN_SHIP_UID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_STATUS_CONSOLE_TCMS, @rec);
end;

procedure TMessage_Handling.Send_Data_Air_Temperature(
  rec: TRec_Air_Temperature);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_AIR_TEMPERATURE, @rec);

end;

procedure TMessage_Handling.Send_Data_Area_MW08(rec: TRec_Data_Area_MW08);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_AREA_MW08, @rec);
end;

procedure TMessage_Handling.Send_Data_Barrometric(
  rec: TRec_Barometric_Pressure);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_BAROMETRIC_PRESS, @rec);
end;

procedure TMessage_Handling.Send_Data_Clear_Object;
var
  RecDataObj : TRec_Object_Data;
begin
  RecDataObj.SessionID := FSessionID;
  RecDataObj.HookIDObj := '0';
  RecDataObj.ParentID := '0';
  RecDataObj.OrderID := CORD_DELETE_ALL;

  NetHandle.SendBroadcast_UDP_Data(CPID_OBJECT_DATA , @RecDataObj);
end;

procedure TMessage_Handling.Send_Data_Emitter(rec: TRec_Emitter_Data);
begin
  rec.SessionID := FSessionID;
  rec.IDShigma := IDShipSigma;
  rec.ObjectIdx := 0;

  NetHandle.SendBroadcast_UDP_Data(CPID_EMITTER_WEAPON, @rec);
end;

procedure TMessage_Handling.Send_Data_Envi_Time_Date(rec: TRec_Envi_Date_Time);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_ENVI_DATE_TIME, @rec);
end;

procedure TMessage_Handling.Send_Data_Eval_Tracklist(rec: TRec_Eval_Tracklist);
begin

  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_EVAL_TRACKLIST, @rec);

end;

procedure TMessage_Handling.Send_Data_Exocet_Target_Object(
  rec: TRec_Data_Exocet);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_EXOCET_TARGET_OBJECT, @rec);
end;

procedure TMessage_Handling.Send_Data_DecoyAuto(rec: TRec_Data_DecoyAuto);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYAUTO, @rec);
end;

procedure TMessage_Handling.Send_Data_DecoyController(
  rec: TRec_Data_DecoyController);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYCTRL , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoyFiring(rec: TRec_Decoy_Firing);
begin

  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYFIRING , @Rec);

end;

procedure TMessage_Handling.Send_Data_DecoyLauncher(
  rec: TRec_Data_DecoyLauncher);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYLNCH , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoyFiringQueue(
  rec: TRec_Decoy_Queue);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYFIREQUE , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoyLaunchQueue(
  rec: TRec_Decoy_Queue);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYLNCHQUE , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoyLCC(rec: TRec_Data_Decoy_LCC);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOY_LCC , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoySim(rec: TRec_Data_DecoySim);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYSIM , @Rec);
end;

procedure TMessage_Handling.Send_Data_DecoySysMode(rec: TRec_Data_DecoySysModeChg);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_DECOYSYSMODE , @Rec);
end;

procedure TMessage_Handling.Send_Data_Depth(rec: TRec_Depth);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DEPTH, @rec);
end;

procedure TMessage_Handling.Send_Data_Drift(rec: TRec_Drift);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DRIFT, @rec);
end;

procedure TMessage_Handling.Send_Data_Firing_Squence(
  rec: TRec_Missile_Firing_Squence);
begin
  rec.SessionID := FSessionID;
  rec.sigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_FIRING_SQUENCE, @rec);
end;

procedure TMessage_Handling.Send_Data_FOC(rec : TRec_Data_FOC);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_FOC, @rec);

end;

procedure TMessage_Handling.Send_Data_GameSync(rec: TRec_GameSync);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_GAME_SYNC, @rec);
end;

procedure TMessage_Handling.Send_Data_Gun76(rec: TRec_Data_Gun76);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA76, @rec);
end;

procedure TMessage_Handling.Send_Data_Humidity(rec: TRec_Humidity);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_HUMIDITY, @rec);
end;

procedure TMessage_Handling.Send_Data_ICM(RoleSender, RoleRecevier: Integer;
  PosX, PosY: Double);
var
  rec: TRec_Data_ICM;
begin
  rec.SessionID  := FSessionID;
  rec.objectID   := IDShipSigma;
  rec.SenderRole := RoleSender;
  rec.RecvRole   := RoleRecevier;
  rec.PosX       := PosX;
  rec.PosY       := PosY;

  NetHandle.SendBroadcast_UDP_Data(CPID_REQ_ICM, @rec);
end;

procedure TMessage_Handling.Send_Data_IFF_Simulator(rec: TRec_IFF_Simulator);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_IFF_SIMULATOR, @rec);
end;

procedure TMessage_Handling.Send_Data_LIROD(aRec: TRec_LIROD_MK2);
begin
  aRec.SessionID := FSessionID;
  arec.sigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_LIROD, @arec);
end;


procedure TMessage_Handling.Send_Data_MagneticVar(rec: TRec_Magnetic_Var);
begin
  rec.SessionID := FSessionID;
  rec.sigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_MAGNETIC_VAR, @rec);

end;

procedure TMessage_Handling.Send_Data_Missile_Parameter(
  rec: TRec_Missile_Parameter);
begin
  rec.SessionID := FSessionID;
  rec.sigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_MISSILE_PARAMETER, @rec);
end;

procedure TMessage_Handling.Send_Data_MM40_Movement(
  rec: TRec_ExocetMM40_Movement);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_MM40_MOVEMENT, @rec);
end;

procedure TMessage_Handling.Send_Data_MW08_Simulator(rec: TRec_MW08_Simulator);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_MW08_SIMULATOR, @rec);
end;

procedure TMessage_Handling.Send_Data_Obj(rec: TRec_Object_Data);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_OBJECT_DATA, @rec);
end;

procedure TMessage_Handling.Send_Data_Plan_Missile(rec: TRec_Plan_Missile);
begin
  rec.SessionID := FSessionID;
  rec.sigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_PLAN_MISSILE, @rec);
end;

procedure TMessage_Handling.Send_Data_RadarMW08(rec: TRec_Data_MW08);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_MW08, @rec);
end;


procedure TMessage_Handling.Send_Data_Rel_OS_Poss(rec: TRec_Relative_OS_Poss);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_REL_OS_POSS, @rec);
end;

procedure TMessage_Handling.Send_Data_SessionAvailable(rec: TRec_Session);
begin
  NetHandle.SendBroadcast_UDP_Data(CPID_SESSION_AVAILABLE, @rec);
end;

procedure TMessage_Handling.Send_Data_Target_Exocet(
  rec: TRec_Data_Target_Exocet);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_DATA_TARGET_EXOCET, @rec);
end;

procedure TMessage_Handling.Send_Data_Tetral(rec: TRec_Data_Tetral);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_TETRAL, @rec);
end;

procedure TMessage_Handling.Send_Data_Tetral2(rec: TRec_Data_Tetral2);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_TETRAL2, @rec);
end;

procedure TMessage_Handling.Send_Data_Threat_Eval(
  rec: TRec_Threat_Eval_Values);
begin

  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_THREAT_EVAL_VALUES, @rec);

end;

procedure TMessage_Handling.Send_Data_TrkSelAir(rec: TRec_TrackSelAirSetting);
begin

  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_TRK_SEL_AIR_SETTING, @rec);

end;

procedure TMessage_Handling.Send_Data_Tsmc(rec: TRec_Data_TSMC);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_TSMC, @rec);
end;

procedure TMessage_Handling.Send_PAC_Data(aRec: TRec_PAC_Data);
begin
  aRec.SessionID := FSessionID;
  aRec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_PAC, @aRec);
end;

procedure TMessage_Handling.Send_PAC_Target(aRec: TRec_PAC_Target);
begin
  aRec.SessionID := FSessionID;
  aRec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_PAC_TARGET, @aRec);
end;

procedure TMessage_Handling.Send_Plan_Cordon_Data(rec: TRec_Data_Plan_Cordon);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_PLAN_CORDON_DATA, @rec);
end;

procedure TMessage_Handling.Send_Plan_Cordon_Tracks(rec: TRec_Plan_Cordon_Tracks);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_PLAN_CORDON_TRACKS, @rec);
end;

procedure TMessage_Handling.Send_Data_Obj(objectIdx, objectID : Integer; OrderID,
          SenderForm, TacticalMode : Byte;
          EnterHook, EnterPosX, EnterPosY, EnterHeading, EnterTurnRate,
          EnterSpd, EnterAccel, EnterAltDepth, EnterCliDiveRate  : Boolean;
          ObjName, className, HookID : string; Identity : Byte; Speed, Heading, TurnRate,
          Acceleration, ClmbRate : Double; ImmediateSpd, ImmediateClm,
          ImmediateHdg : Boolean; PosX, PosY, PosZ : Double;
          IFFMode1, IFFMode2, IFFMode3 : Integer;
          IFFMode4 : Byte; IFFSpec : Byte);
var
  rec: TRec_Object_Data;
begin
  rec.ParentID          := '';
  rec.SessionID         := FSessionID;
  rec.ObjectID          := IntToStr(ObjectID);
  rec.HookIDObj         := HookID;
  rec.objectIdx         := objectIdx;
  rec.OrderID           := OrderID;
  rec.SenderForm        := SenderForm;
  rec.TacticalMode      := TacticalMode;
  rec.EnterHook         := EnterHook;
  rec.EnterPosX         := EnterPosX;
  rec.EnterPosY         := EnterPosY;
  rec.EnterHeading      := EnterHeading;
  rec.EnterTurnRate     := EnterTurnRate;
  rec.EnterSpd          := EnterSpd;
  rec.EnterAccel        := EnterAccel;
  rec.EnterAltDepth     := EnterAltDepth;
  rec.EnterCliDiveRate  := EnterCliDiveRate;
  rec.ClassName         := ClassName;
  rec.ObjName           := ObjName;
  rec.Identity          := Identity;
  rec.Speed             := Speed;
  rec.Heading           := Heading;
  rec.TurnRate          := TurnRate;
  rec.Acceleration      := Acceleration;
  rec.ClmbRate          := ClmbRate;
  rec.ImmediateSpd      := ImmediateSpd;
  rec.ImmediateClm      := ImmediateClm;
  rec.ImmediateHdg      := ImmediateHdg;
  rec.PosX              := PosX;
  rec.PosY              := PosY;
  rec.VerticalAlt       := PosZ;

  rec.IFFMode1          := IFFMode1;
  rec.IFFMode2          := IFFMode2;
  rec.IFFMode3A         := IFFMode3;
  rec.IFFMode4          := IFFMode4;
  rec.IFFSpec           := IFFSpec;

  NetHandle.SendBroadcast_UDP_Data(CPID_OBJECT_DATA, @rec);
end;

procedure TMessage_Handling.Send_Mail_Data(rec: TRec_Data_Mail);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_Mail, @rec);
end;

procedure TMessage_Handling.Send_Mail_StatusMail(rec: TRec_Data_StatusMail);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_StatusMail, @rec);
end;

procedure TMessage_Handling.Send_Mail_Value(rec: TRec_Data_MailValue);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_Mail_Value, @rec);
end;

procedure TMessage_Handling.Send_Man_Overboard_Data(rec: TRec_Data_Man_Overboard);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_MAN_OVERBOARD_DATA, @rec);
end;

procedure TMessage_Handling.Send_Man_Overboard_Pos(rec: TRec_Man_Overboard_Pos);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_MAN_OVERBOARD_POS, @rec);
end;

procedure TMessage_Handling.Send_MissilePos(rec: TRecMissilePosTCMS);
begin
  rec.SessionID  := FSessionID;
  rec.shipID := StrToInt(IDShipSigma);
  NetHandle.SendBroadcast_UDP_Data(CPID_MISSILE_POS_TCMS, @rec);
end;

procedure TMessage_Handling.Send_MovementData(rec : TRec_Data_Movement);
begin
  rec.SessionID   := FSessionID;
  rec.pid.recTime := TimeInt;

  NetHandle.SendBroadcast_UDP_Data(CPID_PLATFORM_MOVE, @rec);

//  // send msg to esm
//  if Assigned(FOnMsgDataMovement) then
//    FOnMsgDataMovement(rec);

end;

procedure TMessage_Handling.Send_Nav_Route_Data(rec: TRec_Data_Nav_Route);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_NAV_ROUTE_DATA, @rec);
end;

procedure TMessage_Handling.Send_Nav_Route_Data_WP(rec: TRec_Data_WP_Nav_Route);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_NAV_ROUTE_DATA_WP, @rec);
end;

procedure TMessage_Handling.Send_Nav_Zigzag_CatalogueValue(
  rec: TRec_Data_Nav_ZigzagCatalogueValue);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_NAV_ZIGZAG, @rec);
end;

procedure TMessage_Handling.Send_Nav_Zigzag_Data(rec: TRec_Data_Nav_ZigzagPlan);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_NAV_ZIGZAG, @rec);
end;

procedure TMessage_Handling.Send_Nav_Zigzag_Data_PL(
  rec: TRec_Data_Pl_Nav_ZigzagPlan);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_NAV_ZIGZAG_PL, @rec);
end;

procedure TMessage_Handling.Send_NGS_Target(aRec: TRec_NGS_Target);
begin
  aRec.SessionID := FSessionID;
  aRec.SigmaID  := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_NGS_TARGET, @aRec);
end;


procedure TMessage_Handling.Send_ScenarioSync(rec: TRec_ScenarioSync);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_SCENARIO_SYNC, @rec);
end;

procedure TMessage_Handling.Send_Req_Connect(aSpeed, Course, X, Y: Double);
var
  rec: TRec_Data_Connect;
begin
  rec.SessionID := FSessionID;
  rec.OrderID   := CPID_REQ_CONNECT;
end;

procedure TMessage_Handling.Send_State_Exocet(rec: TRec_State_Exocet);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_STATE_EXOCET, @rec);
end;

procedure TMessage_Handling.Send_Stationing_RefObj(rec: TRec_Stationing_RefObj);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_STATIONING_REFOBJ, @rec);
end;

procedure TMessage_Handling.Send_SyncData(aSpeed, Course, X, Y: Double);
var
  rec: TRec_Data_Movement;
begin
//  rec.SessionID   := FSessionID;
//  rec.objectID    := IDShipSigma;
//  rec.pid.recTime := TimeInt;
//  rec.OrderId     := 0;
//  rec.Speed       := aSpeed;
//  rec.Course      := Course;
//  rec.X           := X;
//  rec.Y           := Y;

  NetHandle.SendBroadcast_UDP_Data(CPID_REQ_SYNC, @rec);
end;

procedure TMessage_Handling.Send_Sync_Sonar(rec: TRec_Sonar_Sync);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_SONAR_SYNC, @rec);

end;


procedure TMessage_Handling.Send_TactFigure_Group_Visual_Data(
  rec: TRec_Visual_Tactical_Figure_Group);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_VISUAL_TACTICAL_FIGURE_GROUP, @rec);
end;

procedure TMessage_Handling.Send_TactFigure_List_Data(
  rec: TRec_List_Tactical_Figure);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_LIST_TACTICAL_FIGURE, @rec);
end;

procedure TMessage_Handling.Send_TactFigure_Polygon(rec: TRec_Visual_Polygon);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_VISUAL_POLYGON, @rec);
end;

procedure TMessage_Handling.Send_TactFigure_Polyline(rec: TRec_Visual_Polyline);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_VISUAL_POLYLINE, @rec);
end;

procedure TMessage_Handling.Send_TactFigure_Visual_Data(
  rec: TRec_Visual_Tactical_Figure);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_VISUAL_TACTICAL_FIGURE, @rec);
end;

procedure TMessage_Handling.Send_TDS_Port(rec: TRec_TDS_Data);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TDS_PORT, @rec);
end;

procedure TMessage_Handling.Send_TDS_Stbd(rec: TRec_TDS_Data);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TDS_STBD, @rec);
end;

procedure TMessage_Handling.Send_Throw_Off_Control(rec: Trec_Throw_Off_Control);
begin
  rec.SessionID := FSessionID;
  rec.objectID  := IDShipSigma;

  NetHandle.SendBroadcast_UDP_Data(CPID_THROW_OFF_CONTROL, @rec);
end;

procedure TMessage_Handling.Send_Track_Detect(rec: TRec_Track_Detection);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_DETECT, @rec);
end;

procedure TMessage_Handling.Send_Track_IFF_Code(rec: TRec_Track_IFF_Code);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_IFF_CODE, @rec);
end;

procedure TMessage_Handling.Send_Track_Monit_Data(rec: TRec_Track_Monitor);
begin
  rec.SessionID := FSessionID;
  rec.ObjectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_MONIT_DATA, @rec);
end;

procedure TMessage_Handling.Send_Track_Movement(rec: TRec_Track_Movement);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_MOVEMENT, @rec);
end;

procedure TMessage_Handling.Send_Track_Positioning(rec: TRec_Track_Position);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_POSITIONING, @rec);
end;

procedure TMessage_Handling.Send_Track_Shift(rec: TRec_Track_Shift);
begin
  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_SHIFT, @rec);

end;

procedure TMessage_Handling.Send_Track_Sources(rec: TRec_Track_Sources);
begin
  rec.SessionID := FSessionID;
  rec.SigmaID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_TRACK_SOURCES, @rec);

end;

procedure TMessage_Handling.Send_WasaChanProperties(
  rec: TRec_WasaChanProperties);
begin

  rec.SessionID := FSessionID;
  rec.objectID := IDShipSigma;
  NetHandle.SendBroadcast_UDP_Data(CPID_WASA_CHAN_PROPERTIES, @rec);

end;

procedure TMessage_Handling.Send_MOC_Online_Check(rec: Trec_Check_MOC_Online);
begin
  rec.SessionID := FSessionID;
  NetHandle.SendBroadcast_UDP_Data(CPID_CHECK_MOC_ONLINE, @rec);
end;

procedure TMessage_Handling.netRecv_MOC_Online_Check(apRec: PAnsiChar;
  aSize: Word);
var
  rec: ^Trec_Check_MOC_Online;
begin

  rec := @apRec^;

  if rec^.SessionID <> FSessionID then
    Exit;

  if rec^.SensorID = C_CONSOLE_MOC1 then
      Exit;

  if Assigned(FOnRcvMOC_Online_Check) then
    FOnRcvMOC_Online_Check(apRec);

end;





//// ESM window message
//procedure TMessage_Handling.HandleCopyDataRecord(copyDataStruct: PCopyDataStruct);
//var
//  DataObj: TRec_Track_Detection;
////  obj : TSimObject;
//begin
//
//
//
//end;
//
//procedure TMessage_Handling.WMCopyData(var Msg: TWMCopyData);
//begin
//
//  HandleCopyDataRecord(Msg.CopyDataStruct);
//
//end;







//procedure TMessage_Handling.winRecv_VigileData(TrkData: TRec_Track_Detection);
//begin
//
//
//end;

end.


