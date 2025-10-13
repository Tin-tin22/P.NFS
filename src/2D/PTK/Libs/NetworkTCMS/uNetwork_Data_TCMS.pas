unit uNetwork_Data_TCMS;

interface

uses
  uUDPDatatype;

const
  PDK_76_ON = '761';
  PDK_76_OFF = '760';

  PDK_EXO_ON = 'exo1';
  PDK_EXO_OFF = 'exo0';
  PDK_TETFWD_ON = 'tetfwd1';
  PDK_TETFWD_OFF = 'tetfwd0';

  PDK_TETAFT_ON = 'tetaft1';
  PDK_TETAFT_OFF = 'tetaft0';

  CORD_ALL_SUBSYSTEM = 'ALL SUBSYSTEM';

  CPID_UDP = 20;

  CPID_CHANGE_ROLE                            = CPID_UDP + 1;
  CPID_PLATFORM_MOVE                          = CPID_UDP + 2;
    CORD_SPEED  = 1;
    CORD_COURSE = 2;

  CPID_REQ_CONNECT                            = CPID_UDP + 3;
  CPID_REQ_SYNC                               = CPID_UDP + 4;
  CPID_REQ_ICM                                = CPID_UDP + 5;
  CPID_STATE_EXOCET                           = CPID_UDP + 6;
    CORD_ACTIVITY   = 1;
    CORD_URGENCY    = 2;
    CORD_SAFETYPNL  = 3;
    CORD_CONTROLPNL = 4;
    CORD_VALIDATE   = 5;
    CORD_CMSFIRE    = 6;
    CORD_RESTORE    = 7;
    CORD_CANCELEP   = 8;
    CORD_MISSILE_ALLOC = 9;
    CORD_SALVO = 10;
  CPID_DESIGT_EXOCET                          = CPID_UDP + 7;
  CPID_BREAK_EXOCET                           = CPID_UDP + 8;
  CPID_FIRE_EXOCET                            = CPID_UDP + 9;
  CPID_DEVICE_STATE                           = CPID_UDP + 10;
  CPID_OBJECT_DATA                            = CPID_UDP + 11;

    CRT_TRAINING = 1;
    CRT_REPLAY = 2;

    CORD_DELETE_ALL = 0;
    CORD_CREATE_OBJ = 1;
    CORD_EDIT_OBJ   = 2;
    CORD_DELETE_OBJ = 3;
    CORD_CREATE_WPN = 4;

    CORD_RAM_SURF     = 11;
    CORD_RAM_AIR      = 12;
    CORD_DR_SURF      = 13;
    CORD_DR_AIR       = 14;
    CORD_DR_SURF_SUBSURF = 15;
    CORD_POINT_GEN    = 16;
    CORD_POINT_AIR    = 17;
    CORD_POINT_ESMFIX = 18;
    CORD_POINT_ASW    = 19;

    //PROGRESS
    CORD_DATUM        = 20;

    CORD_ESM_B_AIR    = 21;
    CORD_ESM_B_SURF   = 22;
    CORD_ESM_B_SUB    = 23;

    CORD_VIS_B_AIR    = 24;
    CORD_VIS_B_SURF   = 25;
    CORD_VIS_B_SUB    = 26;
    CORD_TWS_1        = 27;
    CORD_TWS_2        = 28;

    CORD_POINT_MOB    = 29;



  CPID_CHANGE_IDENTITY                        = CPID_UDP + 12;
  CPID_CHANGE_HOLDFIRE                        = CPID_UDP + 13;
  CPID_DESIGT76                               = CPID_UDP + 14;
  CPID_BREAK76                                = CPID_UDP + 15;
  CPID_FIRE76                                 = CPID_UDP + 16;
  CPID_STOP76                                 = CPID_UDP + 17;
    SF_CREATE_OBJ   = 1;
    SF_EDIT_OBJ     = 2;
    SF_PREPARE_WPN  = 3;
  CPID_DATA76                                 = CPID_UDP + 18;
    CORD_SETTING_ALL    = 0;
    CORD_POWER_STAT     = 1;
    CORD_BALLISTIC_TYPE = 2;
    CORD_FIRE_RATE      = 3;
    CORD_PROJECTILE_SPD = 4;
    CORD_RANGE_COOR     = 5;
    CORD_BEARING_COOR   = 6;
    CORD_FIRE_AUTH      = 7;
    CORD_GUN_CONNECTION = 8;
    CORD_GUN_AMMO       = 9;
    CORD_GUN_PAR_PROX   = 10;
    CORD_GUN_POS        = 11;
    CORD_GUN_BTTL       = 12;
    CORD_GUN_BURST      = 13;
    CORD_GUN_COEFF      = 14;
    CORD_MC             = 20;
    CORD_WAP            = 21;

  CPID_TETRAL                                 = CPID_UDP + 19;
    CORD_DESIGT_TETRALFWD  =  1;
    CORD_BREAK_TETRALFWD   =  2;
    CORD_DESIGT_TETRALAFT  =  3;
    CORD_BREAK_TETRALAFT   =  4;
    CORD_TETRAL_AFT        =  5;
    CORD_TETRAL_FWD        =  6;
    CORD_AUTH_CODE         =  7;
    CORD_POWER_ON          =  8;
    CORD_POWER_OFF         =  9;
    CORD_CONNECTION        = 10;
    CORD_NONE              = 11;
    CORD_LIROD             = 12;
    CORD_MODE              = 13;
    CORD_NUMBER_MISSILE    = 14;
    CORD_PROXFUSE          = 15;
    CORD_TYPE              = 16;
    CORD_STATE             = 17;
    CORD_EFFECT            = 18;
    CORD_OPERATIONAL       = 19;
    CORD_AVAILABLE         = 20;
    CORD_FIRE_CONDITIONS   = 21;
    CORD_KEY_ON            = 22;
    CORD_TGT_ENG           = 23;
    CORD_MNT_ALIGN         = 24;
  CPID_FIRE_TETRAL                            = CPID_UDP + 20;
  CPID_DATA_MW08                              = CPID_UDP + 21;
    CORD_MW_BTLSHRT      = 1;
    CORD_MW_STABILIZER   = 2;
    CORD_MW_TRANSMITTER  = 3;
    CORD_MW_BDRIVE       = 4;
    CORD_MW_TXAUTH       = 5;
    CORD_MW_JAMDET       = 6;
  CPID_AREA_MW08                              = CPID_UDP + 22;
    CORD_AIA_AIR            = 1;
    CORD_AONI_AIR           = 2;
    CORD_AIA_SURF           = 3;
    CORD_AONI_SURF          = 4;
    CORD_AIA_AIR_CLEAR      = 5;
    CORD_AONI_AIR_CLEAR     = 6;
    CORD_AIA_SURF_CLEAR     = 7;
    CORD_AONI_SURF_CLEAR    = 8;
    CORD_BLANK_SECTOR       = 9;
    CORD_BLANK_CLEAR        = 10;
  CPID_DESIGT_A244                            = CPID_UDP + 23;
  CPID_BREAK_A244                             = CPID_UDP + 24;
  CPID_DATA_A244                              = CPID_UDP + 25;


  CPID_LIBRARY                                = CPID_UDP + 26;
    CORD_LIB_CLASS    = 1;
    CORD_LIB_EMITTER  = 2;
  CPID_TSMC									                  = CPID_UDP + 27;
  CPID_WASA									                  = CPID_UDP + 28;
  CPID_SET_TUBE_CONTENT                       = CPID_UDP + 29;
  CPID_NGS                                    = CPID_UDP + 30;
    CORD_NGS_ACTIVE   = 1;
    CORD_NGS_INACTIVE = 2;
    CORD_NGS_BLIND = 3;
    CORD_NGS_BLIND_DEL = 4;


  CPID_EXOCET_TARGET_OBJECT                   = CPID_UDP + 31;

  CPID_MANUAL_TRACK                           = CPID_UDP + 32;

  CPID_PAC                                    = CPID_UDP + 33;
    CORD_PAC_ACTIVE   = 1;
    CORD_PAC_INACTIVE   = 2;
    CTYPE_PAC_SURFACE = 0;
    CTYPE_PAC_AIR = 1;
    CORD_APPLY_CORRECTION = 3;

  CPID_SNAPSHOT                               = CPID_UDP + 34;
  CPID_SEND_ON_DATA                           = CPID_UDP + 35;
  CPID_GIC76                                  = CPID_UDP + 36;
    CORD_GIC_ALL  = 0;
    CORD_ONLINE_STAT  = 1;
    CORD_AVAILABILITY = 2;
    CORD_FAILURE      = 3;
    CORD_TARGET_ENG   = 4;
    CORD_TARGET_AIM   = 5;
    CORD_DIRECT_ENG   = 6;
    CORD_WARM_FIRE    = 7;
    CORD_OPER_TEST    = 8;
    CORD_DECKFIXED    = 9;
    CORD_AUTH         = 10;
    CORD_STATIC_BRN   = 11;
    CORD_STATIC_ELEV  = 12;
    CORD_STATIC_RNG   = 13;
    CORD_DYNAMIC_BRN  = 14;
    CORD_DYNAMIC_ELEV = 15;
    CORD_DYNAMIC_RNG  = 16;
    CORD_FILE_INTRP   = 17;
    CORD_FIRE_STATE   = 18;
    CORD_OBJECT_DATA  = 19;
    CORD_OBJECT_ID    = 20;
    CORD_TRACK_NMB    = 21;

  CPID_SONAR_SYNC                             = CPID_UDP + 37;
    CORD_SYNC_PASSIVE = 1;
    CORD_SYNC_ACTIVE  = 2;
    CORD_DESYNC_PASSIVE = 3;
    CORD_DESYNC_ACTIVE = 4;
    CORD_SYNC_CHECK  = 5;

  CPID_ESM_TRACK_DATA                         = CPID_UDP + 38;
  CPID_ENVI_DATA                              = CPID_UDP + 39;

  { SPS115}
  CPID_STATUS_CONSOLE_TCMS                    = CPID_UDP + 40;
  CPID_MISSILE_POS_TCMS                       = CPID_UDP + 41;

  CPID_FOC                                    = CPID_UDP + 42;
  CPID_SCENARIO_SYNC                          = CPID_UDP + 43;

  CPID_TRACK_DETECT                           = CPID_UDP + 44;
    CORD_DETECT       = 1;
    CORD_REMOVE       = 2;
    CORD_REMOVE_ALL   = 3;
    CORD_START_PING   = 4;

  CPID_ON_CONSOLE                             = CPID_UDP + 45;
    CORD_ONLINE       = 0;
    CORD_OFFLINE      = 1;
    CORD_PLAY         = 2;
    CORD_CLOSE        = 3;
    CORD_START        = 4;
    CORD_RESTART_APP  = 5;
    CORD_RESTART_PC   = 6;
    CORD_SHUTDOWN_PC  = 7;

  CPID_FIRE_TORPEDO                           = CPID_UDP + 46;

  CPID_CHANGE_TRACK_DESC                      = CPID_UDP + 47;

  CPID_TRACK_SHIFT                            = CPID_UDP + 48;

  CPID_FIRE_TORPEDO_A244                      = CPID_UDP + 49;
    CORD_A244_FIRE = 1;

	CPID_SONAR_ENVI                             = CPID_UDP + 50;
  CPID_MOC_NAME                               = CPID_UDP + 51;
    MOC_1 = 1;
    MOC_2 = 2;
    MOC_3 = 3;
    MOC_4 = 4;
    MOC_5 = 5;
    MOC_GSS = 6;

  CPID_CHECK_MOC_ONLINE                       = CPID_UDP + 52;

  CPID_DATA_DECOYSIM                          = CPID_UDP + 53;
  CPID_DATA_DECOYLNCH                         = CPID_UDP + 54;
  CPID_DATA_DECOYCTRL                         = CPID_UDP + 55;
  CPID_DATA_DECOYLNCHQUE                      = CPID_UDP + 56;
  CPID_DATA_DECOYFIRING                       = CPID_UDP + 57;
  CPID_DATA_DECOYFIREQUE                      = CPID_UDP + 58;

  CPID_CONFIRM_TARGET_TORPEDO                 = CPID_UDP + 59;
  CPID_TRACK_MOVEMENT                         = CPID_UDP + 60;
    CORD_TRACK_SENSOR           = 0;
    CORD_TRACK_RAM_SURF         = 1;
    CORD_TRACK_RAM_AIR          = 2;
    CORD_TRACK_DR_SURF          = 3;
    CORD_TRACK_DR_AIR           = 4;
    CORD_TRACK_DR_SURF_SUBSURF  = 5;
    CORD_TRACK_POINT_GEN        = 6;
    CORD_TRACK_POINT_AIR        = 7;
    CORD_TRACK_POINT_ESMFIX     = 8;
    CORD_TRACK_POINT_ASW        = 9;
    CORD_TRACK_DATUM            = 10;
    CORD_TRACK_ESM_B_AIR        = 11;
    CORD_TRACK_ESM_B_SURF       = 12;
    CORD_TRACK_ESM_B_SUB        = 13;
    CORD_TRACK_VIS_B_AIR        = 14;
    CORD_TRACK_VIS_B_SURF       = 15;
    CORD_TRACK_VIS_B_SUB        = 16;
    CORD_TRACK_NGS              = 17;
    CORD_TRACK_TDS_PORT         = 18;
    CORD_TRACK_TDS_STBD         = 19;
    CORD_TRACK_PAC_REF          = 20;
    CORD_TRACK_ACT_SONAR        = 21;
    CORD_TRACK_PAS_SONAR        = 22;

  CPID_IDGENERATOR                            = CPID_UDP + 61;
    CORD_ID_REALOBJECT  = 1;
    CORD_ID_OTHEROBJECT = 2;

  CPID_NAV_ROUTE_DATA                         = CPID_UDP + 62;
  CPID_NAV_ROUTE_DATA_WP                      = CPID_UDP + 63;

  CPID_MAN_OVERBOARD_DATA                     = CPID_UDP + 64;
  CPID_MAN_OVERBOARD_POS                      = CPID_UDP + 65;

  CPID_PLAN_CORDON_DATA                       = CPID_UDP + 66;
  CPID_PLAN_CORDON_TRACKS                     = CPID_UDP + 67;

  CPID_TETRAL2                                = CPID_UDP + 68;
  CPID_DESIGT_TETRAL                          = CPID_UDP + 69;
  CPID_BREAK_TETRAL                           = CPID_UDP + 70;

  CPID_DATA_NAV_STATIONING                    = CPID_UDP + 71;
  CPID_STATIONING_REFOBJ                      = CPID_UDP + 72;


  CPID_TRACK_POSITIONING                      = CPID_UDP + 73;
    CORD_TRACK_WIPE = 1;
    CORD_TRACK_WIPE_SRC = 2;
    CORD_TRACK_REPOST = 3;
    CORD_TRACK_CORR = 4;
    CORD_TRACK_KEEPLOST = 5;
    CORD_BREAK_TWS_1 = 6;
    CORD_BREAK_TWS_2 = 7;
    CORD_OBJECT_REPOST = 8;
    CORD_TRACK_CHANGE_SRC = 9;
    CORD_DISJOIN = 10;



  CPID_NGS_TARGET                             = CPID_UDP + 74;
  CPID_DATA_TARGET_EXOCET                     = CPID_UDP + 75;
  CPID_PLAN_MISSILE                           = CPID_UDP + 76;
  CPID_MISSILE_PARAMETER                      = CPID_UDP + 77;
  CPID_FIRING_SQUENCE                         = CPID_UDP + 78;
  CPID_TDS_PORT                               = CPID_UDP + 79;
    CORD_TDS_PORT_SYNC = 1;
    CORD_TDS_PORT_OFF = 0;

  CPID_TDS_STBD                               = CPID_UDP + 80;
    CORD_TDS_STBD_SYNC = 1;
    CORD_TDS_STBD_OFF = 0;

  CPID_DATA_DECOY_LCC                         = CPID_UDP + 81;

  CPID_DECOY_DESIG_OPS                        = CPID_UDP + 82;

  CPID_NAV_ZIGZAG                             = CPID_UDP + 83;
  CPID_NAV_ZIGZAG_PL                          = CPID_UDP + 84;
  CPID_NAV_ZIGZAG_CATALOGUE                   = CPID_UDP + 85;

  CPID_PAC_TARGET                             = CPID_UDP + 86;

  CPID_EMITTER_WEAPON                         = CPID_UDP + 87;
    CORD_ADD_EMITTER  = 1;
    CORD_ADD_WEAPON   = 2;
    CORD_EDIT_EMITTER = 3;
    SYNC_CHANGE_EMITTER = 4;
    SYNC_EMITTER        = 5;

  CPID_FA_CODE                                = CPID_UDP + 88;
  CPID_MW08_SIMULATOR                         = CPID_UDP + 89;

  CPID_HOLDFIRE_REPORT_DEF                    = CPID_UDP + 90;
  CPID_ASW_DANGER_ZONES                       = CPID_UDP + 91;
  CPID_MM40_MOVEMENT                          = CPID_UDP + 92;
  CPID_GAME_SYNC                              = CPID_UDP + 93;
  CPID_TRACK_SOURCES                          = CPID_UDP + 94;
  CPID_THROW_OFF_CONTROL                      = CPID_UDP + 95;
  CPID_SESSION_AVAILABLE                      = CPID_UDP + 96;
    CORD_SESSION_INFO         = 1;
    CORD_SESSION_REQUEST      = 2;
    CORD_SESSION_REQUEST_ACK  = 3;
    CORD_SESSION_LEAVE        = 4;
    CORD_SESSION_LEAVE_ACK    = 5;
    CORD_SESSION_JOIN_INFO    = 6;
  CPID_Mail                                   = CPID_UDP + 97;
  CPID_Mail_Value                             = CPID_UDP + 98;
  CPID_Sent_Item_Mail                         = CPID_UDP + 99;
  CPID_StatusMail                             = CPID_UDP + 100;

  CPID_SECTOR_SCREEN                          = CPID_UDP + 101;
  CPID_SECTOR_SCREEN_OBJECT                   = CPID_UDP + 102;
    CORD_SS_UPDATE = 1;
    CORD_SS_CLEAR = 2;
    CORD_SS_CLEAR_ALL = 3;
    CORD_SS_REMOVE_TARGET = 4;
    CORD_SS_APPLY_TARGET = 5;

  CPID_ECM_ENGAGEMENT                         = CPID_UDP + 103;
    CORD_ECM_DESIG = 1;
    CORD_ECM_BREAK = 2;

  CPID_ECM_SIMULATOR                         = CPID_UDP + 104;

  CPID_INIT_DECOY_FIRING = CPID_UDP + 105;

  CPID_ESM_BRN_TRACK_DATA                     = CPID_UDP + 106;

  CPID_DATA_DECOYSYSMODE                      = CPID_UDP + 107;

  CPID_DATA_DECOYAUTO                         = CPID_UDP + 108;

  CPID_IFF_PLOT                               = CPID_UDP + 109;
    CORD_IFF_UPDATE = 1;
    CORD_IFF_WIPE = 2;
    CORD_IFF_WIPE_ALL = 3;

  CPID_IFF_Plot_Monit                         = CPID_UDP + 110;

  CPID_76MM_BULLET_MOVEMENT                   = CPID_UDP + 111;
    CORD_UPDATE_MOVEMENT = 1;
    CORD_SPLASH = 2;

  CPID_TRACK_IFF_CODE                         = CPID_UDP + 112;
    CORD_TRACK_IFF_UPDATE = 1;
    CORD_TRACK_IFF_CLEAR_ALL = 2;

  CPID_TRACK_MONIT_DATA                       = CPID_UDP + 113;
    CORD_TRACK_MONIT_UPDATE = 1;
    CORD_TRACK_MONIT_REMOVE = 2;

  CPID_TACTICAL_FIGURE                        = CPID_UDP + 114;
    CORD_TACTICAL_FIG_UPDATE = 1;
    CORD_TACTICAL_FIG_DELETE = 2;

  CPID_IFF_SIMULATOR                          = CPID_UDP + 115;
  CPID_IFF_TRANSPOND_MC                       = CPID_UDP + 116;
  CPID_IFF_TRANSPOND_CTRL                     = CPID_UDP + 117;
  CPID_LIROD_Setting                          = CPID_UDP + 118;

  CPID_IFF_INTERROGATIONS                     = CPID_UDP + 119;

  CPID_LIST_TACTICAL_FIGURE                   = CPID_UDP + 120;
    CORD_LIST_TF_UPDATE = 1;
    CORD_LIST_TF_DELETE = 2;
    CORD_LIST_TF_ACTIVE = 3;
//    CORD_LIST_TF_UPDATE = 4;

  CPID_VISUAL_TACTICAL_FIGURE                 = CPID_UDP + 121;
  CPID_VISUAL_TACTICAL_FIGURE_GROUP           = CPID_UDP + 122;

  CPID_AREA_ALERT                             = CPID_UDP + 123;

  CPID_DATA_LIROD                             = CPID_UDP + 124;
    CORD_DESIG_LIROD = 1;
    CORD_BREAK_LIROD = 2;
    CORD_OTO_LIROD   = 3; //icha
    CORD_JOY_LIROD   = 4;
    CORD_MOVE_LIROD = 5;
    CORD_KILL_LIROD = 6;

  CPID_DATA_EMCON_Plan1                       = CPID_UDP +125;
  CPID_DATA_EMCON_Plan2                       = CPID_UDP +126;


  CPID_THREAT_EVAL_VALUES                     = CPID_UDP + 127;

  CPID_TRK_SEL_AIR_SETTING                    = CPID_UDP + 128;

  CPID_EVAL_TRACKLIST                         = CPID_UDP + 129;
  CPID_LINKY_SETTING                          = CPID_UDP + 130;

  CPID_SEL_WASA_CHAN                          = CPID_UDP + 131;
  CPID_WASA_CHAN_PROPERTIES                   = CPID_UDP + 132;
  CPID_ECM_AUTH                               = CPID_UDP + 133;

  CPID_ARPA_DETECTED                          = CPID_UDP + 134;

  CPID_LIROD_SEARCH_SECTOR                    = CPID_UDP + 135;

  CPID_VISUAL_POLYGON                         = CPID_UDP + 136;

  CPID_SONAR_STATUS                           = CPID_UDP + 137;

  CPID_VISUAL_POLYLINE                        = CPID_UDP + 138;
  CPID_ASW_UNIT_INCLUDED                      = CPID_UDP + 139;
    CORD_ASW_UNIT_ADD   = 1;
    CORD_ASW_UNIT_DEL   = 2;
    CORD_ASW_THREAT_ADD = 3;
    CORD_ASW_THREAT_DEL = 4;

  CPID_MAGNETIC_VAR                           = CPID_UDP + 140;
  CPID_BAROMETRIC_PRESS                       = CPID_UDP + 141;
  CPID_HUMIDITY                               = CPID_UDP + 142;
  CPID_AIR_TEMPERATURE                        = CPID_UDP + 143;
  CPID_WIND                                   = CPID_UDP + 144;
  CPID_DEPTH                                  = CPID_UDP + 145;
  CPID_DRIFT                                  = CPID_UDP + 146;
  CPID_REL_OS_POSS                            = CPID_UDP + 147;
  CPID_ENVI_DATE_TIME                         = CPID_UDP + 148;
  CPID_IFF_SECTORS_VISUAL                     = CPID_UDP + 149;
  CPID_IFF_SECTOR_LIST                        = CPID_UDP + 150;
    CORD_SECTOR_UPDATE    = 1;
    CORD_SECTOR_CLEAR     = 2;
    CORD_IFF_BLANK_SECTOR = 3;
    CORD_IFF_BLANK_CLEAR  = 4;

  CPID_LIST_GEO_SITUATION                    = CPID_UDP + 151;
    CORD_LIST_GEO_ADD    = 1;
    CORD_LIST_GEO_DELETE = 2;
    CORD_LIST_GEO_ACTIVE = 3;
    CORD_LIST_GEO_UPDATE = 4;

  CPID_VISUAL_GEO_FIG                        = CPID_UDP + 152;
  CPID_GEOVISUAL_POLYLINE                    = CPID_UDP + 153;
  CPID_GEOVISUAL_POLYGON                     = CPID_UDP + 154;

  CPID_UDP_MAX                               = CPID_UDP + 155;


type

  TStr100 = string[100];
  TStr50 = string[50];
  TStr20 = string[20];
  TStr15 = string[15];
  TStr10 = string[10];
  TStr5  = string[5];

  TFloatingPointS = Single;
  TFloatingPointD = Double;

  TRec_Sonar_Status = record
    pid : TPacketID;
    SigmaID : TStr10;
    SessionID : Integer;

    DetectionMode,
    RXUStatus,
    TXUStatus : Byte;
  end;

  TRec_LIROD_SearchSector = record
    pid        : TPacketID;
    SigmaID   : TStr10;
    SessionID  : Integer;

    TopLimit : Double;
    BottomLimit: Double;
    LeftBearing: Double;
    RightBearing: Double;
    RangeNear: Double;
    RangeFar: Double;
  end;


  TRec_Data_Init_Decoy_Firing = record
    pid        : TPacketID;
    ObjectID   : TStr10;
    SessionID  : Integer;
    OS_Hdg     : Double;
    CurrentTime: TDateTime;
    TickCount  : Cardinal;
  end;

  //Record untuk TSMC
  TRec_Data_TSMC = record
    pid        : TPacketID;
    ObjectID   : TStr10;// string[255];
    SessionID  : Integer;
    Segment    : Integer;
    OperState  : Integer;
  end;

  //Record untuk ganti role, user, shift
  TRec_Data_Change_Role = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    RoleID     : Integer;
    RoleStatus : Boolean;
    UserID     : Integer;
  end;

  //Record untuk ganti library
  TRec_Data_Change_Library = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;// string[255];
    LibID      : Integer;
    LibStatus  : Boolean;
  end;

  //record untuk perubahan data kapal
  TRec_Data_Movement = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectIdx         : Integer;
    objectID          : TStr10;// string[255];
    HookIDObj         : TStr10;// string[255];
    ParentID          : TStr10;// string[255];
    TacticalMode      : Byte;
    SenderForm        : Byte;
    ClassName         : TStr20;// string[255];
    ObjName           : TStr20;// string[255];
    ClassDomain       : Integer;
    Identity          : Byte;
    Speed             : TFloatingPointS;
    OrderedSpeed      : TFloatingPointS;
    Heading           : TFloatingPointS;
    OrderedHeading    : TFloatingPointS;
    TurnRate          : TFloatingPointS;
    Acceleration      : TFloatingPointS;
    ClmbRate          : TFloatingPointS;
    PosX              : Double;
    PosY              : Double;
    Elevation         : Double;
    OrderedElevation  : Double;
    AirTemp           : TFloatingPointS;
    Humidity          : TFloatingPointS;
    Preasure          : TFloatingPointS;
    WindTrue          : TFloatingPointS;
    Depth             : TFloatingPointS;
    ConsoleId         : Byte;
	  IsDisconnecting   : Boolean;
    IsDetected        : Boolean;
    Emitters          : string[255];
  end;

  TRec_Track_Position = record
    pid       : TPacketID;
    SessionID : Integer;
    SigmaID   : TStr10;
    TrackID   : integer;
    OrderID   : Byte;
    ReposX    : Double;
    ReposY    : Double;
    Speed     : TFloatingPointS;
    Heading   : TFloatingPointS;
    Elevation : Double;
  end;

  TRec_Track_IFF_Code = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;
    TrackID   : TStr10;
    OrderID   : Byte;
    Mode1     : TStr10;
    Mode2     : TStr10;
    Mode3     : TStr10;
    Mode4     : Byte;
    ModeC     : TStr10;
    ModeSpecC : TStr10;
  end;

  TRec_Track_Movement = record
    pid       : TPacketID;
    SessionID : Integer;
    SigmaID   : TStr10;
    TrackID   : integer;
    ObjectID  : TStr10;
    DetName   : TStr20;
	  PlatID    : TStr10;
    PosX      : Double;
    PosY      : Double;
    DatumX    : Double;
    DatumY    : Double;
    Elevation : Double;
    HoldFire  : Boolean;
    Heading   : TFloatingPointS;
    Speed     : TFloatingPointS;
    Range     : TFloatingPointS;
    Bearing   : TFloatingPointS;
    TrackNum  : Integer;
    LinkYStat : TStr10;
    PUNumber  : TStr10;
    Ampli     : TStr10;
    PrivCode  : TStr10;
    ConnIndicator       : TStr10;
    IFFIndicator        : TStr10;
    ThreatIndicator     : TStr10;
    Identity            : byte;
    SensorID            : integer;
    MOCSender           : TStr10;
    IsTrackUnitFound    : Boolean;
    DeviceNum           : TStr10;
    Domain              : Byte;
    LinkYSigmaID        : TStr10;
    TrackMainSource     : Byte;
    TrackType           : Byte;
  end;

  TRec_IDGenerator = record
    pid             : TPacketID;
    SessionID       : Integer;
    SigmaID         : TStr10;
    OrderID         : Byte;

    IDRealObject    : Cardinal;
    IDNonRealObject : Cardinal;
    IDTrack         : Cardinal;
    DeviceNumber    : Cardinal;
    IDFigure        : Cardinal;
    IDIFFMode1      : Cardinal;
    IDIFFMode2      : Cardinal;
    IDIFFMode3A     : Cardinal;
    IDIFFModeC      : Cardinal;
  end;

  //for Console
  TRecStatus_ConsoleTCMS = record
    pid : TPacketID;
    SessionID : Integer;
    //Pc: TPacketCheck;

    OWN_SHIP_UID    : TStr15;
    WeaponID   : word;
    ErrorID    : Word;
    ParamError : Byte;
  end;

  // REC_MISSILEPOS
  TRecMissilePosTCMS = record
    pid : TPacketID;
    SessionID : Integer;

    shipID: word;
    WeaponID      : word;
    launcherID    : word;
    missileID     : word;
    MissileNumber : word;

    status: byte;
    x, y, z: double;
    heading: single;
    speed: single;
  end;

  TRecDataTorperdoTCMS = record
    Pc: TPacketID;
    SessionID : Integer;

    ShipID          : word;
    mWeaponID       : Word;
    mLauncherID     : word;
    mMissileID      : word;
    mMissileNumber  : Word;

    OrderID     : byte;

    ISC : single;
    ISR : word;
    WTR : word;
    CEI : word;
    PRG : word;
    DOP : word;
    ACE : word;
    FLO : word;
    ISD : word;
    ACM : word;
  end;

  //record data cloud dan rain untuk noise ARPA
  TRec_Data_Natural_Envi = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
    RainIntensity     : TFloatingPointS;
    SeaState          : TFloatingPointS;
    CloudPosX1        : Double;
    CloudPosY1        : Double;
    CloudDensity1     : Double;
    CloudSize1        : Double;
    CloudPosX2        : Double;
    CloudPosY2        : Double;
    CloudDensity2     : Double;
    CloudSize2        : Double;
    CloudPosX3        : Double;
    CloudPosY3        : Double;
    CloudDensity3     : Double;
    CloudSize3        : Double;
    CloudPosX4        : Double;
    CloudPosY4        : Double;
    CloudDensity4     : Double;
    CloudSize4        : Double;
    CloudPosX5        : Double;
    CloudPosY5        : Double;
    CloudDensity5     : Double;
    CloudSize5        : Double;
  end;

  //record ketika pertama kali connect
  TRec_Data_Connect = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : Integer;
    OrderID   : Byte;
    SpeedNow  : TFloatingPointS;
    Speed     : TFloatingPointS;
    CourseNow : TFloatingPointS;
    Posx      : Double;
    Posy      : Double;
  end;

  //record create ICM;
  TRec_Data_ICM = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    SenderRole : Integer;
    RecvRole   : Integer;
    PosX       : Double;
    PosY       : Double;
  end;

  //record desigt & break exocet
  TRec_Data_Exocet = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    LauncherID  : Byte;
    ObjectID    : TStr10;
    TargetID    : Integer;
  end;

  //record state exocet
  TRec_State_Exocet = record
    pid             : TPacketID;
    SessionID       : Integer;
    ObjectID        : TStr10;
    LauncherNum     : Byte;
    OrderID         : Byte;
    { Simulator Status }
    SimOnline       : Byte;
    SimAvailability : Byte;
    SimFailure      : Byte;
    SafetyPnl       : Boolean;
    ControlPnl      : Boolean;
    SimEngMonitor   : Byte;
    SimEngagement   : Byte;
    SimEngSupport   : Byte;
    { Exocet Status }
    State           : Byte;
    Availability    : Byte;
    Configuration   : Byte;
    Activity        : Byte;
    Urgency         : Byte;
    { System Configuration Value }
    ValidateEP      : Boolean;
    CancelEP        : Boolean;
    RestoreMissile  : Boolean;
    CMSFireAuth     : Boolean;
    MissileAlloc    : Byte;
    TOTType         : Byte;
    TOTTime         : TFloatingPointD;
    SalvoSize       : Byte;
    TrainMissile    : array[0..3] of Boolean;
    TrainOffMissile : array[0..3] of Boolean;
    FiringMissile   : array[0..3] of Boolean;
  end;

  TRec_Data_Target_Exocet = record
    pid         : TPacketID;
    SessionID   : Integer;
    SigmaID     : TStr10;
    TargetID    : TStr10;
    Salvo       : integer;
    TSS         : integer;
  end;

  TRec_Fire_Exocet = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectID    : TStr10;
  end;

  //record change state sensor & weapon
  TRec_Device_State = record
    pid         : TPacketID;
    SessionID   : Integer;
    ParentID    : Integer;
    ObjectID    : TStr10;
    DeviceID    : Integer;
    DeviceState : Byte;
  end;

  {PAC}
  TRec_PAC_Target = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectID    : TStr10;
    TargetID    : TStr10;
    OrderID     : Byte;
    Bearing,
    Range,
    Elev,
    BCorr,
    RCorr, Ecorr       : TFloatingPointS;
    PACType : Byte;
    TimeLast    : TStr20;

  end;

  TRec_PAC_Data = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    ObjectID    : TStr10;
    TargetID    : TStr10;

    PACType     : Byte;
    IsActive       : Boolean;
    IsEnable : Boolean;
    Gun,
    Tracker : Integer;
  end;

  TRec_FA_Code = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr5;
    Code : TStr5;
  end;

  //record create & editObject
  TRec_Object_Data = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectIdx         : Integer;
    objectID          : TStr10;
    HookIDObj         : TStr10;
    ParentID          : TStr10;
    OrderID           : Byte;
    SenderForm        : Byte;
    TacticalMode      : Byte;
    EnterHook         : Boolean;
    EnterPosX         : Boolean;
    EnterPosY         : Boolean;
    EnterHeading      : Boolean;
    EnterTurnRate     : Boolean;
    EnterSpd          : Boolean;
    EnterAccel        : Boolean;
    EnterAltDepth     : Boolean;
    EnterCliDiveRate  : Boolean;
    ClassName         : TStr20;
    ObjName           : TStr20;
    Identity          : Byte;
    Speed             : TFloatingPointS;
    Heading           : TFloatingPointS;
    TurnRate          : TFloatingPointS;
    Acceleration      : TFloatingPointS;
    ClmbRate          : TFloatingPointS;
    ImmediateSpd      : Boolean;
    ImmediateClm      : Boolean;
    ImmediateHdg      : Boolean;
    PosX              : Double;
    PosY              : Double;

    VerticalAlt       : TFloatingPointS;
    CreateFrom        : Byte;
    MocName           : Byte;

    EntryRelCrsMode   : Byte;
    EntryRelSpdMode   : Byte;

    IFFMode1         : Integer;
    IFFMode2         : Integer;
    IFFMode3A        : Integer;
    IFFModeC         : Integer;
    IFFMode4         : Byte;
    IFFSpec          : Byte;
  end;

  // record create emitter data
  TRec_Emitter_Data = record
    pid             : TPacketID;
    SessionID       : Integer;
    SyncID          : Byte;
    ObjectIdx       : Integer;
    IDShigma        : TStr10;
    ObjectID        : TStr10;
    OrderID         : Byte;
    SenderForm      : Byte;
    IdEmitter      : integer;
    EmitterName    : TStr20;
    EmitterType    : integer;
    FreqType       : integer;
    PriType        : integer;
    ScanType       : integer;
    Frequency       : TFloatingPointS;
    Pri             : TFloatingPointS;
    PulseWidth     : TFloatingPointS;
    ScanRate       : TFloatingPointS;
    TransmitPower  : TFloatingPointS;
    ThreatLevel    : integer;
    JammerWidth    : TFloatingPointS;
    PingRate       : TFloatingPointS;
    OprStatus      : Byte;
  end;


  //record change identity dan holdfire
  TRec_Change_Identity_HF = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectId  : TStr10;
    IdTrack   : TStr10;
    OrderID   : Byte;
    Identity  : Byte;
    Holdfire  : Boolean;
  end;

  //record change attributes (identity, domain, primer, secunder)
  TRec_Change_Track_Description = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectId  : TStr10;
    IdTrack   : TStr10;
    Identity  : Byte;
    Domain    : Byte;
    Symbol    : Byte;
    Primer    : Byte;
    Secunder  : Byte;
    Clas      : Byte;
    Conf      : Byte;

    PrivateCode : TStr10;
  end;

  TRec_Gun76  = record
    pid       : TPacketID;
    SessionID : Integer;
    SigmaID  : TStr10;
    OrdID     : Byte;
    TargetID  : TStr10;

//    PosX            : Double;
//    PosY            : Double;
//    StartX,
//    StartY          : Double;
//    Elevation       : Double;
//    Heading         : Single;
//    Speed           : Single;
//    BallisticType   : Byte;
//    ElevationToPHP  : Double;
//    TrueRange,
//    TrueBearing     : Double;
//    RangeNow,
//    HeightNow : Double;
//    FireRate : Byte;
  end;

  TRec_Data_Gun76 = record
    pid           : TPacketID;
    SessionID     : Integer;
    objectID      : TStr10;
    TargetID      : TStr10;
    IsDesig       : Boolean;
    IsTrajected   : Boolean;
    OrderID       : Byte;
    PowerStat     : Byte;
    BallisticType : Byte;
    FireRate      : Byte;
    Ammo          : Byte;
    ParProx       : Byte;
    GunConnection : Byte;
    GunPosition   : Byte;
    GunBttl       : Byte;
    GunBurst      : TFloatingPointS;
    GunCoeff      : TFloatingPointS;
    FireAuth      : Boolean;
    ProjectilSpd  : TFloatingPointS;
    RangeCorr     : TFloatingPointS;
    BearingCorr   : TFloatingPointS;
    OperabilityTest : Byte;
    ThrowOff : Double;
    AimMode : Byte;
    CorrMode : Byte;
  end;

  TRec_LIROD_MK2 = record
    pid       : TPacketID;
    SessionID : Integer;
    SigmaID   : TStr10;
    OrdID     : Byte;
    TargetID  : TStr10;
    PlatormID : TStr10;
    IsDesig : Boolean;
    TrackingMode  : Byte;
    //icha
    IsSrvLirod : Boolean;
    MocControling : TStr5;
    Elevation : Double;
    Bearing   : Double;
    LirodAvailability : Byte;
    isJoytoLirod : Boolean;
  end;



  TRec_Data_Tetral = record
    pid            : TPacketID;
    SessionID      : Integer;
    objectID       : TStr10;
    TargetID       : TStr10;
    TetralID       : Byte;
    LauncherID     : Byte;
    OrderID        : Byte;
    State          : Byte;
  end;

  //ubah lala
  TRec_Data_Tetral2 = record
    pid            : TPacketID;
    SessionID      : Integer;
    objectID       : TStr10;
    TargetID       : TStr10;
    TetralID       : Byte;
    IsFiring       : Boolean;
    IsAuth         : Boolean;
    LauncherType1  : Byte;
    LauncherState1 : Byte;
    LauncherEffect1: Byte;
    LauncherType2  : Byte;
    LauncherState2 : Byte;
    LauncherEffect2: Byte;
    LauncherType3  : Byte;
    LauncherState3 : Byte;
    LauncherEffect3: Byte;
    LauncherType4  : Byte;
    LauncherState4 : Byte;
    LauncherEffect4: Byte;
    PowerOn        : Boolean;
    ModeWar        : Boolean;
    ModePeace      : Boolean;
    NumMissile     : Byte;
    Proxfuse       : Byte;
    Operational    : Boolean;
    Available      : Boolean;
    FireConditions : Byte;
    KeyOn          : Byte;
    TargetEng      : Byte;
    MntAlign       : Byte;
    Connection     : Byte;
    EngState       : Byte;
    OprAvailable   : Boolean;
    SubSystemMode  : Byte;
    TDAActive      : Boolean;
  end;

  TRec_Data_Fire_Tetral = record
    pid            : TPacketID;
    SessionID      : Integer;
    objectID       : TStr10;
    TargetID       : TStr10;
    TetralID       : Byte;
    ObjectIdx      : Integer;
    ProjectileID   : TStr10;
    ObjectName     : TStr10;
    Enable         : Boolean;
    TargetCourse   : TFloatingPointS;
    TargetSpeed    : TFloatingPointS;
    RangeMissile   : TFloatingPointS;
    BearingMissile : TFloatingPointS;
    Visible        : Boolean;
    LauncherNumber : Integer;
    Speed          : TFloatingPointS;
    TargetBearing  : TFloatingPointS;
    TargetRange    : TFloatingPointS;
  end;

  TRec_Data_MW08  = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
    OrderID           : Byte;
    StateID           : Byte;
    BttlID            : Byte;
    BDriveID          : Byte;
    Stabilizer        : Byte;
    TransmitterState  : Byte;
    TXAuth            : Byte;
    JammingDetection  : Byte;
  end;

  TRec_MW08_VideoSetting = record
    pid           : TPacketID;
    SessionID     : Integer;
    objectID      : TStr10;
    SensorIdx     : TStr10;
    DisplayVideo  : Byte;
    ThreshMode    : Byte;
    Threshold     : integer;
    ClutterFilter : Byte;
    STC           : Byte;
  end;

  TRec_Sonar_Sync = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    SigmaID    : TStr10;
    TargetID    : TStr10;
    TrackType   : Byte;
    TrackNumber : TStr20;
    Bearing     : TFloatingPointS;
    Range       : TFloatingPointS;
    Speed       : TFloatingPointS;
    Course      : TFloatingPointS;
    TrackUnitID : TStr10;
    RequestedID : TStr10;
  end;

  TRec_Vigile_Sync = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    ObjectID    : TStr10;
    AssocID     : TStr10;
    TrackNumber : TStr10;
    Bearing     : TFloatingPointS;
  end;

  TRec_Data_Area_MW08 = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectId    : TStr10;
    AreaMode    : Byte;
    ItemIdx     : Byte;
    BgnBrn      : TFloatingPointS;
    EndBrn      : TFloatingPointS;
    BgnRng      : TFloatingPointS;
    EndRng      : TFloatingPointS;
    ref         : TStr20;
  end;

  TRec_Data_FOC = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectId    : TStr10;
    TrackNumber : TStr10;
    Speed       : TFloatingPointS;
    Radius      : TFloatingPointS;
    TimeRem     : TFloatingPointS;
    ref         : TStr20;
  end;

  TRec_Data_A244 = record
    pid           : TPacketID;
    SessionID     : Integer;
    ObjectId      : TStr10;
    TargetID      : TStr10;
    MHPType       : Byte;
    LauncherMode  : Byte;
    RangeMode     : Byte;
    Duration      : TFloatingPointS;
    Speed         : TFloatingPointS;
    ISR           : Integer;
    ACE           : Integer;
    TTG           : TFloatingPointS;
  end;

  TRec_B515TubeContent = record
    pid             : TPacketID;
    SessionID       : Integer;
    objectID        : TStr10;
    TorpedoType     : byte;
    Authentication  : Boolean;
    ConfirmTarget   : Boolean;
    TubePt          : array [0..2] of Boolean;
    TubeStb         : array [0..2] of Boolean;
  end;

  TRec_Data_Wasa = record
    pid         : TPacketID;
    SessionID   : Integer;
    objectID    : TStr10;
    OrderID     : Byte;
    IsSyncMsg   : Boolean;
    Wasa        : Integer;
  end;

  TRec_SelWasaChannel = record
    pid           : TPacketID;
    SessionID     : Integer;
    objectID      : TStr10;
    TgtDetectName : TStr10;
    SensorName    : TStr10;
    WeaponName    : TStr10;
    IsSyncMsg     : Boolean;
  end;

  TRec_WasaChanProperties = record
    pid           : TPacketID;
    SessionID     : Integer;
    objectID      : TStr10;
    TgtDetectName : TStr10;
    SensorName    : TStr10;
    WeaponName    : TStr10;
    PlanAuth       : Boolean;
    PlanInhibited : Boolean;
    EngStatus     : Byte;
    EngResult     : Byte;
  end;

  // NGS -> Naval Gunfire Support
  TRec_Data_NGS = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr10;

    BombardMode : Byte;
    Activation : Boolean;
    Tracker : Byte;
    RefStatus : Byte;
    RefPointID : TStr10;
    ObjectID : TStr10;
    Range, Bearing, Height : TFloatingPointS;
    PosGrid : Byte;

  end;

  TRec_NGS_Target = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr10;
    ObjectID : TStr10;
    OrderID : Byte;
    Visible : Boolean;
    Bearing,
    Range,
    Height : TFloatingPointS;
    PosGrid : TStr10;
    Engageable : TStr10;
    PosX, PosY : TFloatingPointD;
  end;

  // Sector Screen
  TRec_Data_SectorScreen = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr10;
    RefPointID : TStr10;
    RefStatus : Byte;
    OffSetBearing : TFloatingPointS;
    OffsetRange : TFloatingPointS; // in kyards
    IsRotationSlaved,
    IsActive,
    IsEnterSector,
    IsExitSector,
    IsUseNewScreen : Boolean;
  end;

  TRec_SectorScreen_Object = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr10;
    ObjectID : TStr10;
    OrderID : Byte;
    BearingStart : TFloatingPointS;
    BearingEnd : TFloatingPointS;
    RangeMin : TFloatingPointS;
    RangeMax : TFloatingPointS;
    OffsetBearing,
    OffsetRange : TFloatingPointS;
    UnitName : TStr10;
    TargetID : TStr10;
  end;

  TRec_Data_Snapshot = record                 ///record utk data image snapshot
    pid : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;
    MOCName   : Integer;
    ImageName : TStr50;
    ImagePath : TStr100;
    IsHide    : Boolean;
  end;

  TRec_Data_On_Console = record
    pid : TPacketID;
    SessionID : Integer;
    OrderID   : byte;
    ConsoleName : TStr20;
    CubicleID : integer;
  end;

  Trec_Data_ESM_Track = record
    pid         : TPacketID;
    SessionID   : Integer;
    ConsoleID   : Byte;
    ObjectId    : TStr10;
    IsRecognized: Boolean;
    Freq        : TFloatingPointS;
    PulseWidth  : TFloatingPointS;
    PRP         : TFloatingPointS;
    ARP         : TFloatingPointS;
    Level       : TFloatingPointS;
  end;

  TRec_Data_GIC76 = record
    pid : TPacketID;
    SessionID : Integer;

    OnlineState,
    Availability,
    Failure,
    TargetEng,
    TargetAim,
    DirectEng,
    WarmFire,
    OperTest,
    DeckFixed,
    Auth,
    ManualControl: Byte;

    OrderID : integer;

    StaticBrn,
    StaticElev,
    StaticRng,
    DynamicBrn,
    DynamicElev,
    DynamicRng : TFloatingPointS;

    SigmaID,
    FileInterupt,
    FireState,
    ObjectData,
    ObjectID,
    TrackNumber : TStr10;

  end;

  TRec_ScenarioSync = record
    pid                 : TPacketID;
    SessionID           : Integer;
    SigmaID             : TStr50;

    GamePlayType        : Byte;
    ScenarioName        : TStr20;
    ScenarioStat        : Byte;
    RecordName          : TStr50;
    RecordStat          : Byte;

    SnapshotName        : TStr20;

    MsScenario          : LongWord;
    OffsetTimeScenario  : TDateTime;
    MsReplay            : LongWord;
    OffserTimeReplay    : TDateTime;
  end;

  TESM_DataReq = record
    PRPModCW: Boolean;
    EmitterFreqAgi: Double;
    Amplitude: Double; // emitter's level
    EmitterName: TStr20;
    RdrTypeName: TStr20;
    Freq: Double;
    PRF: Double;
    PRF_Modulation: Double;
    Pulsewidth: Double;
    // editable values
    PltfAmp: Byte;
    ConfLvl: Byte;
    ScanChannel: Byte;
    FreqBand: Byte;
    ARP: Double;
    ARV: Double;
    BeamWidth: Double;
    TrkIdent: Byte;
  end;

  TRec_Track_Detection = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    ObjectID    : TStr10;
    TargetID    : TStr10;
    SensorID    : Integer;
    TrackType   : Byte;
    TrackNumber : TStr10;
    Bearing     : TFloatingPointS;
    Range       : TFloatingPointS;
    ESM_TN      : TStr10;
    PrpModCW    : Boolean;
    EsmDataReq  : TESM_DataReq;
  end;

  TRec_Track_Shift = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectID    : TStr10;
    TargetID    : TStr10;
    SensorID    : Integer;
    TrackType   : Byte;
    TrackNumber : TStr10;
  end;

  TRec_Sonar_Envi = record
    pid         : TPacketID;
    SessionID   : Integer;
    ObjectID    : TStr10;
    Temperature : TFloatingPointS;
    Battleshort,
    EPU1,
    EPU2,
    PowerWarn,
    SensorWarn,
    PowerLimit,
    SmokeWarn,
    TXUStatus,
    RXUStatus,
    KeyStatus,
    TransmitStatus : Boolean;
    TXAuth : Boolean;
  end;

  TRec_FireTorpedoA244 = record
    Pc          : TPacketID;
    SessionID   : Integer;

    ShipID      : TStr10;
    ObjectID    : TStr10;
    OrderID     : byte;

    ShipX       : Double;
    ShipY       : Double;
    ShipElev    : Double;

    mLauncherID : Integer;
    RangeMove   : Double;

    ISC : single;
    ISR : word;
    WTR : word;
    CEI : word;
    PRG : word;
    DOP : word;
    ACE : word;
    FLO : word;
    ISD : word;
    ACM : word;

    MovingState : Byte;
    StepMoving  : Byte;
    TargetID    : TStr10;
    PosX        : Double;
    PosY        : Double;
    Elevation   : Double;
    Speed       : Single;
    OrdHeading  : Single;
    Heading     : Single;
    TurnRate    : Single;

    InitISR_X   : Double;
    InitISR_Y   : Double;
    InitISR_Z   : Double;
    TToGoISC    : Single;
    TMSpinState : Byte;
    TMDegStartM : Single;
    TMElevState : Byte;
    TMCircle    : integer;
    TMTurnRate  : Single;
  end;

  TRec_Data_Nav_Route = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    RouteName  : TStr50;
    Selected   : TStr50;
    RefLati    : Double;
    RefLongi   : Double;
    Active     : Boolean;
    WaypointID : TStr10;
    Targeted   : Boolean;
    Waypoint_Latitude,
    Waypoint_Longitude : double;
    PtLeg      : Integer;
    StbLeg     : Integer;
    MaxWPNum   : Integer;
    OrderID    : Byte;
    EndRouteETA: Double;
  end;

  TRec_Data_WP_Nav_Route = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    WaypointID : TStr10;
    Targeted   : Boolean;
    Waypoint_Latitude,
    Waypoint_Longitude : double;
    PtLeg      : Integer;
    StbLeg     : Integer;
  end;

  TRec_Data_Nav_Plan = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    PlanName  : TStr50;
    Duration  : Double;
    Angle     : Double;
    PlanSelected      : TStr50;
    IndexPlanSelected : Integer;
  end;

  TRec_Data_Nav_ZigzagCatalogueValue = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    IndexCat : Integer;
    CatName : TStr50;
    NrPlans : Integer;
  end;

  TRec_Data_Mail = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    MailSubj  : TStr50;
    Status    : TStr10;
    IndexSelected     :  Integer;
    indexSelectedSent : Integer;
//    IndexAttachmentSelected : Integer;
  end;

  TRec_Data_MailValue = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    IndexMail : Integer;
    MailFrom  : TStr10;
    MailSub   : TStr50;
    fileMail  : file;

    DataTime  : TDateTime;
    Priority  : TStr10;
    MailType  : TStr10;
    status    : TStr10;
    attachmentFile : TStr50;
  end;

  TRec_Data_SentItemMail = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    OrderID   : Byte;
    IndexSentMail : Integer;
    RespReq   : Boolean;
    RoleMail  : TStr50;
    MailFrom  : TStr10;
    MailRoleIndex : integer;         //icha 28052014
    MailSub   : TStr50;
    fileMail  : file;
    DataTime  : TDateTime;
    Priority  : TStr10;
    MailType  : TStr10;
    status    : TStr10;
    RespMail  : Boolean;
    MailAttachment : TStr50;
    IndexFromMail : Integer;
    isShowing : Boolean;
    isShowingResponse : Boolean; //response
    MailFromType : Byte;
  end;

  TRec_Data_StatusMail = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    indexSelectedSent : Integer;
    MailStatus  : Boolean;
  end;

  TRec_Data_Nav_ZigzagPlan = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    PlanName  : TStr50;
    PlanID    : Integer;
    planIDselected : Integer;
    Visible   : Boolean;
    {ichaFeb}
    VisibleASW : Boolean;
    VisibleTrialRoute : Boolean;
    Turn      : TStr10;
    X1    : Double;
    Y1    : Double;
    Range     : Double;
    Course    : Double;
    Speed     : Double;

    Duration  : Double;
    Angle     : Double;

    //tambahan
    aPostX    : Double;
    aPostY    : Double;
    bPostX    : Double;
    bPostY    : Double;

    PlanSelected      : TStr50;
    IndexPlanSelected : Integer;

    CatSelected : TStr50;
    IndCatalogueSelection : Integer;

    {minRange}
    mrX2      : Integer;
    mrY2 : Integer;
  end;

  TRec_Data_Pl_Nav_ZigzagPlan = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    PlanName  : TStr50;

    LegID     : Integer;
    duration  : Double;
    Angle     : Double;
    Turn      : TStr10;
    {test}
//    PosX      : Double;
//    PosY      : Double;
//    lastAngle : Double;
//
//    aPointPosX : Double;
//    aPointPosY : Double;
//    bPointPosX : Double;
//    bPointPosY :  Double;
//
//    lineUposX  : Double;
//    lineUposY  : Double;
//
//    lineBposX  : Double;
//    lineBposY  : Double;
  end;

  TRec_Data_Man_Overboard = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    ShipSide   : Byte;
    TurnType   : Byte;
    StartMOB   : Boolean;
    StartDraw  : Boolean;
    TurnRate   : TFloatingPointS;
    StartRTG   : TFloatingPointS;
    TTG        : TFloatingPointS;
    ETA        : TFloatingPointS;
    IsDrawMan  : Boolean;
  end;

  TRec_Man_Overboard_Pos = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    ManID      : TStr10;
    ManPosX    : Double;
    ManPosY    : Double;
  end;

  TRec_Data_Plan_Cordon = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    ContactID  : TStr10;
    IsActive   : Boolean;
    AttackZone : TFloatingPointS;
    SectorRng  : TFloatingPointS;
    ApprDist   : TFloatingPointS;
    AttackType : Byte;
    AttackUnit : TStr10;
  end;

  TRec_Plan_Cordon_Tracks = record
    pid        : TPacketID;
    SessionID  : Integer;
    ObjectID   : TStr10;
    TrackID    : TStr10;
    TrackNum   : TStr10;
    OrderID    : Byte;
  end;

  TRec_Torpedo_ConfirmTarget = record
    Pc          : TPacketID;
	SessionID   : Integer;
    ObjectID    : TStr10;
    TargetID    : integer;
    Stop        : Boolean;
    TrackNumber : TStr10;
    TTG         : TFloatingPointS;
    PosX        : Double;
    PosY        : Double;
  end;

//  // launch data for auto mode
//  TRec_Data_DecoyAutoLaunch = record
//    pid               : TPacketID;
//    SessionID         : Integer;
//
//    TargetName  : TStr20;
//    DecoyObjName: TStr10;
//  end;

  TRec_Data_DecoySysModeChg = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;

    DecoySysMode      : Byte;

    ModeChgNoteOnly   : Boolean; // do NOT change SysMode if this is TRUE
    ModeChgDeplNote   : Boolean;
    ModeChgSimNote    : Boolean;
  end;

  TRec_Data_DecoySim = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
//    OrderID           : Byte;
    DecoySimAvail     : Boolean;
    DecoyOpsStatus    : Byte;
    DecoySimCtrl      : Byte;
    DecoySysAvail     : Byte;

//    DecoySysMode      : Byte;
//    ModeChgDeplNote   : Boolean;
//    ModeChgSimNote    : Boolean;

    MasterSafetyArmed : Boolean;
    MainWpnArmed      : Boolean;
    IsPlanning        : Boolean;
    InclBtnActive     : Boolean;

    FireAuth          : Boolean;

    CTS_Mode           : Byte;
    TTF_Mode           : Byte;
    TTF_DelayBy        : TFloatingPointS; // sec
    CTS_EvadeTo        : TFloatingPointS; // deg

    CancelsFiringSeq   : Boolean;

//    RecAutoSend       : Boolean; // true: sent from sync, false: sent from user change of cbbSysMode

  end;

  TRec_Data_Decoy_LCC = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;

    AllowSurvRed      : Boolean;
    FiringWindow      : Boolean;

    VETO_Time         : Integer;
    PtHornSounding    : Boolean;
    SbHornSounding    : Boolean;

  end;

  TRec_Plan_Missile = record
    pid               : TPacketID;
    SessionID         : Integer;
    sigmaID           : TStr10;

    MissileFailure    : Boolean;
    LauncherNumber    : integer;
    MissileStat       : Byte;
    ApproachRange     : Double;
    ApproachBearing   : Double;
    SeekerFar         : Double;
    SeekerNear        : Double;
    SeekerLeftSearch  : Double;
    SeekerRighSearch  : Double;
    SeekerRTG         : Double;
  end;

  TRec_Missile_Firing_Squence = record
    pid             : TPacketID;
    SessionID       : Integer;
    sigmaID         : TStr10;
    LauncherNumber  : integer;

    GyroStatus      : Byte;
    SimLauncherStat : Byte;
    GMTLaunchTime   : TFloatingPointD;
    isStopFire      : Boolean;
    isForceFire     : Boolean;
  end;

  TRec_Missile_Parameter = record
    pid                 : TPacketID;
    SessionID           : Integer;
    sigmaID             : TStr10;
    LauncherNumber      : integer;

    ApplyAllMissile     : Boolean;
    InitialStepAltitude : byte;
    ObstacleLength      : Single;
    AngularApproach     : byte;
    TerminalManoueuvre  : byte;
    SearchMode          : byte;
    Masking             : byte;
    TargetPriority      : byte;
    SearchCriterion     : byte;
    Proximity           : byte;
    MaskingByte         : array[0..3]of array[0..3] of Boolean
  end;

  TRec_Data_DecoyLauncher = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
    //
    LauncherSide      : Byte;
    ArmingStatus      : Byte;
  end;

  TRec_Decoy_Desig_Ops = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
    //
    OrderID          : Byte;
    //
    TgtTN     : TStr10;
    DecoyType : Byte;
    Brg       : Double;
    ETR       : Double;
    LoPri     : Boolean;
    SpotNr    : TStr10;
    DesigID   : TStr10;
  end;

  TRec_Data_DecoyController = record
    pid               : TPacketID;
    SessionID         : Integer;
    objectID          : TStr10;
    //
    LauncherSide      : Byte;
    Selected          : array [0..11] of Boolean;
    MunitionType      : array [0..11] of Byte;
    DecoyStatus       : array [0..11] of Byte; // FDecoyStatus -> Deployment status
    TubeStatus        : array [0..11] of Byte; // FDecoyTubeStatus (empty, loaded, etc)

  end;

  TRec_Decoy_Queue = record  // used for both launch and firing queues
    pid                : TPacketID;
    SessionID          : Integer;
    objectID           : TStr10;
    OrderID            : Byte;
    //
    TubesInQueue : Integer;
    // Decoy in queue data
    QueueNum: Integer;
    TubeNum: TStr10;
    MunitionType: Byte;
    Actual_TTF: TTime;
    TTFSec,
    TTF1,
    TTF2,
    TTF3,
    TTF4: TFloatingPointS;
    BtnTag: Integer;
    LauncherSide: Integer; // launcher side where this tube belongs; 0=Pt, 1=Sb
    CTS_Mode: Byte;
    TTF_Mode: Byte;
  end;

  TRec_Decoy_Firing_Queue = record
    pid                : TPacketID;
    SessionID          : Integer;
    objectID           : TStr10;
    OrderID            : Byte;
    //
    TubesInFiringQueue : Integer;
    // Decoy in queue data
    QueueNum: Integer;
    TubeNum: TStr10;
    MunitionType: Byte;
    Actual_TTF: TTime;
    TTFSec,
    TTF1,
    TTF2,
    TTF3,
    TTF4: TFloatingPointS;
    BtnTag: Integer;
    LauncherSide: Integer; // launcher side where this tube belongs; 0=Pt, 1=Sb
    CTS_Mode: Byte;
    TTF_Mode: Byte;
  end;

  TRec_Decoy_Firing = record
    pid                : TPacketID;
    SessionID          : Integer;
    objectID           : TStr10;
    OrderID            : Byte;
    //
    FireSeqStatus      : Byte;
    FireSeqInProgress  : Boolean;
    StartTime          : TTime;
    CompletionTime     : TTime;
    TubesInSequence    : Integer;
  end;

 TRec_Stationing_RefObj = record
   pid                : TPacketID;
   SessionID          : Integer;
   objectID           : TStr10;

   Guide_TrackName    : TStr10;
 end;

 TRec_NavData_Stationing = record
   pid                : TPacketID;
   SessionID          : Integer;
   objectID           : TStr10;
   // inputs
   Active             : Boolean;
//   Guide_TrackNr      : string[255];
   Guide_Pos_Mode     : Byte;// relative, absolute
   Guide_Vector_Mode  : Byte; // actual, average
   Guide_Brg          : TFloatingPointS; //deg
   Guide_Rng          : TFloatingPointS; //NM
   Guide_Crs          : TFloatingPointS;
   Guide_Spd          : TFloatingPointS;
   OS_TurnRate     : TFloatingPointS; // deg/s
   OS_DurationMode    : Byte;
   OS_Duration        : TFloatingPointS;
   OS_Spd             : TFloatingPointS;

//   // outputs
//   TTG_to_Sta         : Double; // time to go, in sec.
//   RTG_to_Sta         : Double; // range to go
//   TTG_to_Turn        : Double; // time to go, in sec.
//   RTG_to_Turn        : Double; // range to go
//   // advices
//   AdvCrs             : Double; // Advice OS course
//   AdvSpd             : Double; // Advice OS speed
 end;

  Trec_Startup_ESM = record
    pid         : TPacketID;
    SessionID   : Integer;
    SensorID    : Integer;
    AckCode     : TStr10;
  end;

  Trec_Check_MOC_Online = record
    pid         : TPacketID;
    SessionID   : Integer;
    SensorID    : Integer;
    AckCode     : TStr20;
  end;

  TRec_MW08_Simulator = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;
    Online        : Byte;
    Availability  : Byte;
    Failure       : Byte;
    AirSurv       : Byte;
    SurfSurv      : Byte;
    Jamming       : Byte;
    TWSMeas1      : Byte;
    TWSCal1       : Byte;
    TWSMeas2      : Byte;
    TWSCal2       : Byte;
    WarmUpTime    : Byte;
  end;

  TRec_TDS_Data = record
    pid : TPacketID;
    SessionID : Integer;
    SigmaID : TStr10;
    OrderID : Byte;
    TdsID : TStr10;
    TargetID : TStr10;
    Range : TFloatingPointS;
    Height : TFloatingPointS;

    ManualControl : Boolean;
    OnlineState,
    Availability,
    Failure,
    OpticInv,
    ResControl  : byte;

    PowerLabel,
    ResControlLabel,
    OpticInvLabel : TStr20;

    IsSelect,
    IsAction,
    IsFire : Boolean;

    IsSelectEnable,
    IsActionEnable,
    IsFireEnable : Boolean;
  end;

  TRec_DesigPlanDecoyType = record
   pid                : TPacketID;
   SessionID          : Integer;
   objectID           : TStr10;

   DecoyType    : Byte;
 end;

  TRec_HoldfireReportDef = record
    pid : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    Pending,
    AsdFrnd,
    Frnd,
    Neutral,
    Unknown,
    Suspect,
    Hostile,
    WeaponStatus: Byte;
  end;

  TRec_ASWUnit = record
    pid         : TPacketID;
    SessionID   : integer;
    SigmaID     : TStr10;
    OrderID     : Byte;
    ObjectID    : TStr10;
    PCode       : TStr10;
    UnitName    : TStr10;
    PosX        : Double;
    PosY        : Double;
    METFR       : Double;
    Display     : Boolean;
  end;

  TRec_ASWDangerZones = record
    pid             : TPacketID;
    SessionID       : Integer;
    SigmaID         : TStr10;
    IncludeOwnShip  : Boolean;
    DisplayContour  : Boolean;
    FormationRef    : byte;
    ReferenceID     : TStr10;
    KinematicCourse : Double;
    KinematicSpeed  : Double;
    METFR           : Double;
    TorpedoSpeed    : Double;
    TDZDisplay      : Boolean;
    SnorkelSpeed    : Double;
    SubmergedSpeed  : Double;
    LLOADisplayTDA  : Boolean;
    LLOAScreenLine  : Boolean;
    LLOAFormation   : Byte;
  end;

  TRec_ExocetMM40_Movement = record
    pid             : TPacketID;
    SessionID       : Integer;
    SigmaID         : TStr10;
    ObjectID        : TStr10;
    TargetObjectID  : TStr10;
    RangeMax        : Double;
    RangeHit        : Double;

    { Pos Properties }
    PosX            : Double;
    PosY            : Double;
    Elevation       : Double;
    Heading         : Single;
    Speed           : Single;

    { Target and Launcher }
    TargetPosX      : Double;
    TargetPosY      : Double;
    LaunchPosX      : Double;
    LaunchPosY      : Double;

    { Spec Properties }
    MovingStep      : Byte;
    LauncherDegree  : Single;
    LauncherNumber  : Byte;
    TrajectoryType  : Byte;
    TrjctoryHighRng : Single;
    TrjctoryBOLBrng : Single;
    trjctoryHeading : Single;
    FarDistance     : Single;
    NearDistance    : Single;
    LSearchAngle    : Single;
    RSearchAngle    : Single;
    RangeToGo       : Single;
    FirstLaunchX    : Double;
    FirstLaunchY    : Double;
    SecondLaunchX   : Double;
    SecondLaunchY   : Double;
    InitialStep     : Byte;
    ObstacleLength  : Single;
    AngularApproach : Byte;
    TerminalMan     : Byte;
    SearchMode      : Byte;
    Masking         : Byte;
    TargetPriority  : Byte;
    SearchCriterion : Byte;
    Proximity       : Byte;
  end;

  Trec_Shutdown_ESM = record
    pid         : TPacketID;
    SessionID   : Integer;
    SensorID    : Integer;
    AckCode     : TStr10;
  end;

  Trec_Throw_Off_Control = record
    pid           : TPacketID;
    SessionID     : Integer;
    SigmaID       : Integer;
    ObjectID      : TStr10;
    DetectedName  : TStr10;
    ThrowOff      : Double;
    LeftThrowOffBtnEnable : Boolean;
    RightThrowOffBtnEnable : Boolean;
    EdtThrowOffEnable : Boolean;
  end;

  Trec_Ewscu_Launched = record
    pid         : TPacketID;
    SessionID   : Integer;
    SensorID    : Integer;
    AckCode     : TStr10;
  end;

  TRec_GameSync = record
    pid         : TPacketID;
    SessionID   : Integer;
    SigmaID     : TStr10;
    MiliSecond  : LongWord;
    GameTime    : Double;
  end;

  TRec_Track_Sources = record
    pid         : TPacketID;
    SessionID   : Integer;
    SigmaID     : TStr10;
    TrackID     : TStr10;
    Code        : Byte;
    Prefix      : TStr5;
    Name        : TStr20;
    Level       : Byte;
  end;

  Trec_Check_Signal_Validity = record
    ObjectID    : TStr10;
    ESM_TN      : TStr10;
    EmitterName : TStr20;
    ValidityCode: Byte; // 0=not 1=valid
  end;

  TRec_Session = record
    pid         : TPacketID;
    OrderID     : Byte;
    SigmaID     : TStr10;
    CubicleID   : integer;
    SessionName : TStr50;
    SessionID   : Integer;
  end;

  TRec_Check_Radar_On = record
    pid         : TPacketID;
    SessionID   : Integer;
    RadarName   : TStr20;
    IsOn        : Boolean;
  end;

  {ICHA}
  TRec_ECMSimulator = record
    pid         : TPacketID;
    OrderID     : Byte;
    SessionID   : integer;
    ObjectID    : TStr20;
    IDSigma     : TStr20;

    {ECM simulator property}
    ECMState        : Byte;                //ECM state
    ECMAvailability : Byte;
    ECMDesignation  : Byte;
    ECMSafetyMode   : Byte;
    ECMTrasmiter    : Byte;
    ECMHPA          : Byte;              //01122014
  end;

  TRec_ECMEngagement = record
    pid         : TPacketID;
    OrderID     : Byte;
    SessionID   : integer;
    ObjectID    : TStr20;
    IDSigma     : TStr20;

    { ECM Properties }
    Active      : boolean;
    Brn         : Double;
    Range       : Double;
    ClassEcm    : Byte;
    Spot        : TStr20;
    Freq        : Double;
    Scan        : Byte;
    NameEcm     : TStr50;
    priority    : byte;
    Duration    : double;
    Counter     : Double;
    JamID       : integer;
    Status      : byte;
    Jog         : byte;
    {icha}
    Jam         : byte;
    EngagementStatus : byte;
    Designation : byte;
    HPA         : byte;
  end;

  TRec_ECMEAuth = record
    pid         : TPacketID;
    OrderID     : Byte;
    SessionID   : integer;
    ObjectID    : TStr20;

    ECMAuth        : Boolean;
  end;


  {EMCON -ICA}

  TRec_EmconPlan2 = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    isActiveMw08  : Boolean;
    isActiveLirod : Boolean;
    isActiveECM   : Boolean;
    isActiveKingklip  : Boolean;

    isActivePlan2 : Boolean;
    TStart2  : TTime;
    TStop2   : TTime;
    EmconDate2 : TDate;


    onMW08      : Boolean;
    offMW08     : Boolean;

    onLirod     : Boolean;
    offLirod    : Boolean;

    onECM       : Boolean;
    offECM      : Boolean;

    onKingklip  : Boolean;
    offKingklip : Boolean;

  end;


  TRec_EmconPlan1  = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;

    isActivePlan1 : Boolean;

    TStart  : TTime;
    TStop   : TTime;
    EmconDate : TDate;

    isActiveMw08  : Boolean;
    isActiveLirod : Boolean;
    isActiveECM   : Boolean;
    isActiveKingklip  : Boolean;

    onMW08      : Boolean;
    offMW08     : Boolean;

    onLirod     : Boolean;
    offLirod    : Boolean;

    onECM       : Boolean;
    offECM      : Boolean;

    onKingklip  : Boolean;
    offKingklip : Boolean;
  end;

  //record ESM Bearing Track Data
  TRec_Data_ESM_Brn_Track = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectId  : TStr10;
    IdTrack   : TStr10;
    PltfAmp   : Byte;
    Conf      : Byte;
    ScanCh    : Byte;
    ScanType  : TStr10;
    BeamWidth : TFloatingPointS;
    ScanFr    : TFloatingPointS;
    ARP       : TFloatingPointS;
    PulseWidth: TFloatingPointS;
    Freq      : TFloatingPointS;
    Band      : Byte;
    PRF       : TFloatingPointS;
  end;

  {Uswah}
  //IFF Plots
  TRec_Data_IFF_Plot = record
    pid         : TPacketID;
    OrderID     : Byte;
    plotID      : integer;
    SessionID   : integer;
    ObjectId    : TStr10;
    TN          : TStr10;

    {IFF Plot Properties}
    Mode1       : TStr10;
    Mode2       : TStr10;
    Mode3       : TStr10;
    Mode4       : TStr15;
    SpcCode     : TStr15;
    Brn         : Double;
    Rng         : Double;
  end;

  TRec_Data_IFF_Monit = record
    pid         : TPacketID;
    OrderID     : Byte;
    SessionID   : integer;
    ObjectId    : TStr10;

    {IFF Monitor properties}
    Visible     : Boolean;
    DeltaRadX   : Double;
    DeltaRadY   : Double;
    SqrRadX     : Double;
    SqrRadY     : Double;
    VisibleIFFMonit : Boolean;
    Mode1       : Integer;
    Mode2       : integer;
    Mode3       : integer;
    Afterglow   : Double;
    VisibleIFFMode1    : Boolean;
    VisibleIFFMode2    : Boolean;
    VisibleIFFMode3    : Boolean;
    VisibleIFFDisplay : Boolean;
  end;

  TRec_Data_DecoyAuto = record
    pid         : TPacketID;
    SessionID   : integer;
    ObjectID    : TStr20;

    TargetDetName : TStr10;
//    DecoyObjID  : TStr10;

  end;

  TRec_ECM_Jam = record
    pid         : TPacketID;
    SessionID   : Integer;
    Jam_Status  : Byte;
  end;

  TRec_76mm_Bullet_Movement = record
    pid             : TPacketID;
    SessionID       : Integer;
    SigmaID         : TStr10;
    ObjectID        : TStr10;
    OrderID         : Byte;
    { Pos Properties }

    PosX            : Double;
    PosY            : Double;
    StartX,
    StartY          : Double;
    Elevation       : Double;
    Heading         : Single;
    Speed           : Single;

    ElevationMode : Byte;
    ElevationToPHP  : Double;
    TrueRange,
    TrueBearing     : Double;
    RangeNow,
    HeightNow : Double;
    FireRate : Byte;
    Dormant : Boolean;
    rRangeMax: double;
    rTimeMax: double;
    rHeightMax: double;
    rTimeNow: Double;
    rRunning: boolean;

  end;

  {uswah}
  TRec_IFF_Simulator = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;
    Online        : Byte;
    Availability  : Byte;
    Failure       : Byte;
    Interrogation : Byte;
    Transpond     : Byte;
  end;

  TRec_IFF_TranspondCtrl = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;
    TransmitAvail : Byte;
    TransmitCtrl  : Byte;
    Mode1On       : Byte;
    Mode2On       : Byte;
    Mode3On       : Byte;
    Mode4On       : Byte;
    Mode4AOn      : Byte;
    Mode4BOn      : Byte;
    Mode4S1On     : Byte;
    Mode4S2On     : Byte;
    TranspondAdd  : Byte;
    Mode1Val      : Tstr10;
    Mode2Val      : TStr10;
    Mode3Val      : TStr10;
    TransponderAdd : TStr20;
  end;

  TRec_IFF_TranspondMC = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;
    ModeSIFreply  : Byte;
    ModeSecureR   : Byte;
    ModeSecureC   : Byte;
    JammingStat   : Byte;
  end;


  TRec_Tactical_Figure = record
    pid           : TPacketID;
    OrderID       : Byte;
    SessionID     : integer;
    ObjectID      : TStr10;
    FigureID      : integer;

    {Tactical Figure Properties}
    Visible       : Boolean;
    Active        : Boolean;
    TFigureName   : TStr50;
    TRelatedFigur : TStr50;
    FigureType    : TStr10;
    Envi          : TStr10;
    FigureScope   : TStr10;
    FigureRef     : TStr10;
    SlaveMode     : TStr10; //True/relative
    FigurGrid     : TStr10;
    GridColorCode : TStr10;
    ModeRefren    : Byte;
    ModeGridFigur : Byte;
    PosX1         : Double;
    PosY1         : Double;
    OffsetRng     : Double;
    OffsetBrn     : Double;
    CenterX       : Double;
    CenterY       : Double;
    FigRadius     : Double;
    StartArcAngle : Double;
    EndArcAngle   : Double;
    PenStyle      : integer;
    CLContour     : integer;
    CLFill        : integer;
    PenWidth      : integer;
    HatchStyle    : integer;
    FillAlpha     : integer;
  end;

  TRec_List_Tactical_Figure = record
    pid           : TPacketID;
    OrderID       : Byte;
    SessionID     : integer;
    ObjectID      : TStr10;

    Visible       : Boolean;  //Y/N
    Active        : Boolean;  //Y/N
    TFigureName   : TStr50;
    TRelatedFigur : TStr50;
    Envi          : TStr10;  //A/S/U
    FigureScope   : TStr10;  //G/L
    FigureRef     : TStr10;  //T/OS/G
    FigureType    : TStr10;  //Gen/Eng/Area
    GridMode      : TStr10;
  end;

  TRec_List_Geographic_situation = record
    pid           : TPacketID;
    OrderID       : Byte;
    SessionID     : integer;
    ObjectID      : TStr10;

    Visible       : Boolean;  //Y/N
    GeoID         : Integer;
    GeoType       : TStr50;
    Active        : Boolean;  //Y/N
    GeoPoint      : Integer;
    GeoName       : TStr50;
  end;

  {uswah}
  TRec_Track_Monitor = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;
    OrderID   : Byte;

    CheckID   : integer;
    NameTrack : TStr10;
    Identity  : Byte;
    Envi      : Byte;
    Brn       : Double;
    Rng       : Double;
    Crs       : Double;
    Speed     : Double;
    HD        : Double;
    PrivCode  : TStr10;
    TypeTrk   : TStr10;
    OrgBrn    : Double;
    ColorQ    : TStr10;
    XCoor     : Double;
    YCoor     : Double;
    OrgCourse : Double;
  end;

  Trec_MOC_Session_Check = record
    Session_Status: Byte;
  end;

  Trec_EWS_State = record
    resm_state : Byte;
    recm_state : Byte;
  end;

  TRec_LIROD_Setting = record
    pid       : TPacketID;
    SessionID : Integer;
    ObjectID  : TStr10;
    KBandPowerOn: Boolean;
    KBandTxStatus: Byte;
    LirodStatus: Byte;
    TVCamera : Boolean;
    Environment : Byte;
    LirodConnection : Byte;
  end;

  TRec_IFF_Interrogations = record
    pid             : TPacketID;
    SessionID       : integer;
    SigmaID         : TStr10;

    TransmitAvail   : Byte;
    TransmitCtrl    : Byte;
    OmniMode1       : Byte;
    OmniMode2       : Byte;
    OmniMode3A      : Byte;
    OmniMode4       : Byte;
    OmniModeC       : Byte;
    BeginRng        : Double;
    EndRng          : Double;
    DispIFFSector   : Byte;
    DispIFFBlankSector : byte;
    ZeroIFF         : Boolean;
  end;

  TRec_Visual_Geo_Fig = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    Visible       : Boolean;
    Selected      : Boolean;
    FigureCopy    : Boolean;
    FigureSave    : Boolean;
    ParentGroup   : Boolean;
    GroupAll      : Boolean;

    PosX1         : Double;
    PosY1         : Double;
    PosX2         : Double;
    PosY2         : Double;
    XMapMin       : Double;
    YMapMin       : Double;
    XMapMax       : Double;
    YMapMax       : Double;
    CenterX       : Double;
    CenterY       : Double;
    FigurBrn      : Double;
    FigurRng      : Double;
    OffsetRng     : Double;
    OffsetBrn     : Double;

    PenStyle      : byte;
    HatchStyle    : byte;
    GDITranparent : integer;
    FillAlpha     : integer;
    CLContour     : integer;
    CLFill        : integer;
    PenWidth      : integer;
    NameGeo       : TStr50;

    {Properti masing-masing Shape}
    Radius        : integer;
    CircleRadius  : Double;
    SquareRadius  : Double;
    PieRadius     : Double;
    PieStartArch  : Double;
    PieEndArch    : Double;
    PieDrawMode   : Byte;
    RingHighRad   : Double;
    RingLowRad    : Double;
    RingStartArch : Double;
    RingEndArch   : Double;
    RingDrawMode  : Byte;
    IconIndex     : integer;
    IconContourCl : integer;

    VisualShape   : Byte;
    RefID         : TStr10;
    RefType       : Byte; // 0 == sigma, 1 others
  end;

  TRec_Visual_Tactical_Figure = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    Visible       : Boolean;
    Selected      : Boolean;
    FigureCopy    : Boolean;
    FigureSave    : Boolean;
    ParentGroup   : Boolean;
    GroupAll      : Boolean;

    PosX1         : Double;
    PosY1         : Double;
    PosX2         : Double;
    PosY2         : Double;
    XMapMin       : Double;
    YMapMin       : Double;
    XMapMax       : Double;
    YMapMax       : Double;
    CenterX       : Double;
    CenterY       : Double;
    FigurBrn      : Double;
    FigurRng      : Double;
    OffsetRng     : Double;
    OffsetBrn     : Double;

    PenStyle      : byte;
    HatchStyle    : byte;
    GDITranparent : integer;
    FillAlpha     : integer;
    CLContour     : integer;
    CLFill        : integer;
    PenWidth      : integer;
    NameFig       : TStr50;

    {Properti masing-masing Shape}
    Radius        : integer;
    CircleRadius  : Double;
    SquareRadius  : Double;
    PieRadius     : Double;
    PieStartArch  : Double;
    PieEndArch    : Double;
    PieDrawMode   : Byte;
    RingHighRad   : Double;
    RingLowRad    : Double;
    RingStartArch : Double;
    RingEndArch   : Double;
    RingDrawMode  : Byte;
    IconIndex     : integer;
    IconContourCl : integer;

    VisualShape   : Byte;
    RefID         : TStr10;
    RefType       : Byte; // 0 == sigma, 1 others
  end;

  TRec_Visual_Polygon = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;
    ListLineID    : integer;
    Visible       : boolean;
    Selected      : boolean;
    PenWidth      : integer;
    PenStyle      : byte;
    CLContour     : integer;
    PosX1         : double;
    PosX2         : double;
    PosY1         : double;
    PosY2         : double;
    LineBrn       : double;
    LineRng       : double;
    RefID         : TStr10;
    RefType       : Byte; // 0 == sigma, 1 others
    LineOffsetX   : Double;
    LineOffsetY   : Double;
    NameFig       : TStr50;
  end;

  TRec_Visual_Polyline = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;
    ListLineID    : integer;
    Visible       : boolean;
    Selected      : boolean;
    PenWidth      : integer;
    PenStyle      : byte;
    CLContour     : integer;
    PosX1         : double;
    PosX2         : double;
    PosY1         : double;
    PosY2         : double;
    LineBrn       : double;
    LineRng       : double;
    RefID         : TStr10;
    RefType       : Byte; // 0 == sigma, 1 others
    LineOffsetX   : Double;
    LineOffsetY   : Double;
  end;

  TRec_Visual_Tactical_Figure_Group = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    GroupID       : integer;
    GrpActive     : Boolean;
    GrpSelected   : Boolean;
    XMapGmax      : Double;
    YMapGMax      : Double;
    XMapGmin      : Double;
    YMapGmin      : Double;
  end;

  TRec_Area_Alert_Warning = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;
    IsActive      : Boolean;
    TgtNumber     : TStr10;
    AreaName      : TStr50;
    AreaEnvi      : TStr10;
    Alert         : Boolean;
    IsAreaActive  : Boolean;
    IsAlertActive : Boolean;
    IsEnterActive : Boolean;
    IsExitActive  : Boolean;
  end;

  TRec_Threat_Eval_Values = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    Tgt_TN     : TStr10;
    Inhibit    : Boolean;
    IndexOffset: Integer;
  end;

  TRec_TrackSelAirSetting = record

    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    // Id
    IsTrackingHostileId,
    IsTrackingSuspectId,
    IsTrackingUnknownId,
    IsTrackingPendingId: Boolean;
    // kinematics
    SectorMin, SectorMax,
    RangeMin, RangeMax,
    SpeedMin, SpeedMax,
    InclineAngle: Double;

    // For selection indicators
//    IdentSuspectSelected,
//    IdentHostileSelected,
//    IdentUnknownSelected,
//    IdentPendingSelected,
    KinematicSectorSelected,
    KinematicRangeSelected,
    KinematicSpeedSelected,
    KinematicInclineSelected: Boolean;

  end;

  TRec_Eval_Tracklist = record
    pid           : TPacketID;
    SessionID     : integer;
    ObjectID      : TStr10;

    TracklistOps : Byte;
    TrkTN,
    TrkObjID: TStr10;
  end;

  TRec_LinkY_Setting = record
    pid             : TPacketID;
    SessionID       : integer;
    SigmaID         : TStr10;

    isTXAuth        : Boolean;
    isRelayUnit     : Boolean;
    isAutoNTNAuth   : Boolean;
    isRadioSilence  : Boolean;
    isNetworkTest   : Boolean;
    isSlowPu        : Boolean;
    StationMode     : Byte;
    StationTime     : TDateTime;
    DLRPSetting     : Byte;
    DLRPGeoX        : Double;
    DLRPGeoY        : Double;
    DLRPObjectID    : TStr10;
    PlatFreq        : Byte;
    NTNLower        : Double;
    NTNUpper        : Double;
    Threshold       : Double;
    SReportDelay    : Double;
    OwnPU           : integer;
    OrderLoopTest   : Byte;
    ShortLoopTest   : Byte;
    LongLoopTest    : Byte;
    Modem           : Byte;
    Encryption      : Byte;
    OperStatus      : Byte;
  end;

  TRec_ARPA_DetectedTrack = record
    pid       : TPacketID;
    SessionID : integer;
    SigmaID   : TStr10;
    TrackID   : TStr10;
  end;

  TRec_Magnetic_Var = record
    pid       : TPacketID;
    SessionID : integer;
    SigmaID   : TStr10;

    EntryMode : byte;
    MagValue  : TStr10;
  end;

  TRec_Barometric_Pressure = record
    pid       : TPacketID;
    SessionID : integer;
    SigmaID   : TStr10;

    EntryMode : byte;
    BaromValue  : double;
  end;

  TRec_Humidity = record
    pid       : TPacketID;
    SessionID : integer;
    SigmaID   : TStr10;

    EntryMode : byte;
    HumidValue  : double;
  end;

  TRec_Air_Temperature = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;

    EntryMode     : byte;
    AirTempValue  : double;
  end;


  TRec_Wind = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;

    TrueWindDirection  : double;
    TrueWindSpeed     : double;
    EntryMode     : byte;
  end;

  TRec_Depth = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;

    EntryMode     : byte;
    DepthValue    : double;
  end;

  TRec_Drift = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;

    CourseValue   : Double;
    SpeedValue    : Double;
    EntryMode     : byte;
  end;

  TRec_Relative_OS_Poss = record
    pid           : TPacketID;
    SessionID     : integer;
    SigmaID       : TStr10;

    EntrySpdMode  : byte;
    EntryCrsMode  : byte;
    EntryPosMode  : byte;
    RelLattPos    : double;
    RelLongPos    : double;
  end;

  TRec_Envi_Date_Time = record
    pid               : TPacketID;
    SessionID         : integer;
    SigmaID           : TStr10;

    EntryTimeMode     : byte;
    EntryTimeZoneMode : byte;
    EntryDateMode     : byte;

    EnviTime          : TDateTime;
    EnviTimeZone      : TStr10;
    EnviDate          : TDateTime;

  end;


  TRec_Data_IFF_Sector = record
    pid         : TPacketID;
    SessionID   : integer;
    SigmaId     : TStr10;

    OrderID     : Byte;
    SectorVisible : Boolean;
    SectorID    : integer;
    StartBrn    : Double;
    EndBrn      : Double;
    StartRng    : Double;
    EndRng      : Double;
    SectorRef   : TStr10;
  end;

  TRec_Data_IFF_Blank_Sector = record
    pid         : TPacketID;
    SessionID   : integer;
    SigmaId     : TStr10;

    OrderID     : Byte;
    SectorVisible : Boolean;
    SectorID    : integer;
    StartBrn    : Double;
    EndBrn      : Double;
    StartRng    : Double;
    EndRng      : Double;
    SectorRef   : TStr10;
  end;








implementation

end.
