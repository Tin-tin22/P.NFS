unit uTCPDatatype;
{versi lengkap, urut}

{ nb :
  * STANDART SATUAN DALAM KOMUNIKASI DATA PENEMBAKAN
  RANGE    ===>  METER
  BEARING  ===>  DEGREE
  DEPTH    ===>  METER
  ELECVASI ===>  DEGREE
  SPEED    ===>  M/S
  * }


interface

uses
  Classes, Windows, OverbyteIcswSocket, uBaseDataType;

type

  tDouble3DPoint = record
    X, Y, Z: double;
  end;

  tSingle3DPoint = record
    X, Y, Z: single;
  end;

//  tDouble2DPoint = record
//    X, Y: double;
//  end;

  TPacketCheck = record
    ID: byte;
    Pass: array[0..2] of Ansichar;
  end;

// Tambahan Data SPS115  (record)
//----------------------------------------------------------------------------
//  TIU_Error = (Faulty, Low_Voltage, No_link);

  TError = record              //  Setting Error Data
    Gyro_n        : Integer;
    Barrel_n      : Integer;
    SelfTest      : Boolean;   //  OK , FAIL
    Power_Signal  : Boolean;   //  ON , OFF
    Link_NDS      : Boolean;   //  OP , NOOP
  end;

  //=====>>> Barrel_n
  { 0- Normal
    1- Untimely starting time
    2- Barrel no longer ready
    3- Absence of gyro
    4- Error writing torpedo
    5- Exercise head not start
    6- Torpedo not leave barrel in FIRE }

  //=====>>>> Gyro_n
 {  0- Normal
    1- Too long gyro caging time
    2- Gyro starting overload
    3- Too long gyro starting
    4- No link with TIU port/stb   }

//-----------------------------------------------------------------------------
  //All Enumeration Prepare For RecSendTorpedo
   TTPOType = (A244MOD3,A244MOD1,MU90,EMPTY);
   TWTRType = (SH, DP);
   TPRGType = (HE, SP);
   TDOPType = (CW, FM);
   TACMType = (ACT, PAS, MIX);

  //REC_SPSS_ORDER= 57;
  //Added By Nando For SPSS
  TRecDataTorperdo = record
    Pc: TPacketCheck;

    ShipID          : word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : word;
    mMissileID      : word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang

    OrderID     : byte;

    ISC : single;
    ISR : word;
    WTR : word;             //(0: SH, 1 :DP);
    CEI : word;
    PRG : word;             //(0: HE, 1 :SP)
    DOP : word;             //(0: CW, 1 :FM)
    ACE : word;
    FLO : word;
    ISD : word;
    ACM : word;             //(0: ACT,1 :PAS,2 :MIX)
  end;

//----------------------------------------------------------------------------
  TPanelPortStbd = record                 //  Torpedo Panel Data (Port & Stbd)
    TIU       : Integer;
    _45Deg    : Boolean;
    Temp      : Integer;
  end;

  {=====>>>> TIU  Port & Stbrd      Set Error TIU
    0- NORMAL       (OP)
    1- Faulty       (NOOP)
    2- Low_Voltage  (NOOP)
    3- No_link      (NOOP)
  }

//----------------------------------------------------------------------------

  TTorpData = record                 //  Torpedo Parameter Data
    Torp    : TTpoType;
    Wtr,              // DEEP , SHALOW
    Prg,              // HELIX , SPIRAL
    Dop,              //FM , CW
    Acm     : string; // Active, Passive, Mixed
    Isc,
    Isr,
    Ace,
    Cei,
    Flo,
    Isd     :Integer;
  end;

//----------------------------------------------------------------------------
  TBarrel = record                    // Data Brrel + Data Torpedo
    BrlNum  : Integer;
    Tpo     : TTorpData;
    // TIU,TMP : Integer;
  end;

//----------------------------------------------------------------------------
  TgtDataRec = record                 // Target data
    Tn, Rng, Brg, Crs, Spd: double;
  end;

//----------------------------------------------------------------------------
  TShipData = record                 // Ship data
    Source: string;
    Heading, Speed: Integer;
  end;

//----------------------------------------------------------------------------
  TTacticalData = record             // TacticalData
   MHP, OptCrs, TimeDrop: Integer;
  end;

//REC_FIRE FROM SPS 115----------------------------------------------------------------------------
   TFire = record                      // DATA PENEMBAKAN
    pc : TPacketCheck;
    Barrel : TBarrel;
    Target : TgtDataRec;
    Ship   : TShipData;
    TctData: TTacticalData;
  end;
// Akhir Data Tambahan SPS115

//----------------------------------------------------------------------------
   tTesq = record
    pc : TPacketCheck;
    Stg : string[20];
    Itg : Integer;
    Sgl : Single;
  end;

  //REC_3D_POSITION = 1; -------------------------------------------------------
  TRecData3DPosition = record
    Pc: TPacketCheck;
    ShipID: word;
    X, Y, Z: double;
    Heading: single;
    Speed: single;
    pitch: single;
    roll: single;
    rudder: single;
  end;

  TRecDataAll3DPosition = record     //posisi ship maupun weapon>>khusus untuk replay
    Pc: TPacketCheck;
    ShipID: word;
    WeaponID : word;
    launcherID    : word;
    missileID     : word;
    MissileNumber : word;
    X, Y, Z: double;
    Heading: single;
    Speed: single;
    pitch: single;
    roll: single;
    rudder: single;
    ObjType : Byte;
    OrderID : Byte;
  end;


  spPosition = TRecData3DPosition;

  //REC_POSITION = 2; -------------------------------------------------------
//  TRecDataPosition = record
//    pc : TPacketCheck;
//    UID: string[15];
//
//    position: tDouble3DPoint;
//    heading,
//    speed,
//    pitch,
//    roll,
//    rudder,
//    fuel    : single;
//    status  : byte;
//  end;

  //REC_3D_ORDER= 3; -------------------------------------------------------
  TRecData3DOrder = record
    pc: TPacketCheck;
    shipID: word;
    sOrder: byte;
    mValue: single;
    ModeMove : byte;
    coordinatX : Single;
    coordinatY : Single;
    coordinatZ : Single;
  end;

  //== Damage Order ===========================================================//
  { from uConst  with conflict :(
    REC_ORDER = 3;
    TRecDataOrder = record
      pc: TPacketCheck;         // 4
      shipID: word;             // 2
      sOrder: byte;             // 1
      mValue: single;           // 4
    end;
  }

  // REC_SET_EXOCET  = 4;
{  TRecSetExocet = record
    pc: TPacketCheck;
    shipID: word;
    sOrder: byte;
    mCountID: single;
    mProxFuze: single;
    mAltitude: single;
    mSearchArea: single;
    mRTG: single;
    mManualWidth: single;
    mSelecDepth: single;
    mTBearing: single;
    mTRange: single;
  end;
  }

  // REC_3D_EXOCET   = 4; -----------------------------------------------------
  TRec3DSetExocet = record
    pc              : TPacketCheck;

    shipID          : word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : word;
    mMissileID      : word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang

    sOrder          : byte;

    mProxFuze       : single;
    mAltitude       : single;
    mSearchArea     : single;
    mRTG            : single;
    mManualWidth    : single;
    mSelecDepth     : single;
    mTBearing       : single;
    mTRange         : single;

  end;
  TRecSetExocet  = TRec3DSetExocet;

  // REC_3D_CHAFF= 5; ----------------------------------------------------------
  TRec3DSetChaff = record
    pc            : TPacketCheck;
    ShipID        : word;
    mLauncherID   : word;
    OrderID       : byte;
    //mCountID      : integer;
    mDegreeRate   : single;
    mPart         : integer;
    mPartNo       : integer;
  end;
  TRecSetChaff = TRec3DSetChaff;

  //REC_3D_ASROCK   = 6; -------------------------------------------------------
  TRec3DSetAsrock = record
    pc              : TPacketCheck;

    ShipID          : word;
    mWeaponID       : Word;       //  Diisi sesuai Database
    mLauncherID     : word;
    mMissileID      : word;
    mMissileNumber  : Word;       //  Diisi 0 aj...nanti instruktur yang ngisi ulang
    mMissile_Type   : word;       //  add by eka
    mTargetID       : Word;       //  Added by bagoes
    OrderID         : byte;
    mTargetBearing  : single;
    mTargetRange    : single;
    mTargetDepth    : single;
    mFuzeType       : Word;       //  0: time   1 : prox

    mCorrRange      : single;
  end;
  TRecSetAsrock = TRec3DSetAsrock;

  //C_REC_MERIAM                = 7; -------------------------------------------
  TRecMeriam = record
    PC          : TPacketCheck;                                //17
    ShipID      : word;
    OrderID     : byte;   //
    Gun_number  : integer;
    X, Y, Z     : double;
    TOF         : double;
  end;

{ // REC_3D_TORPEDO = 8;
  TRec3DSetTorpedo = record
    pc: TPacketCheck;
    ShipID: word;
    OrderID: byte;
    mCountID: integer;
  end;
}
  //REC_3D_TORPEDO_MK44 = 8;  --------------------------------------------------
  TRecTorpedoMK44Order = record
    PC            : TPacketCheck;
    shipID        : word;
    OrderID       : byte;
    mID           : word;
    mISD          : single;
    mFloor        : single;
    mGyroRunOut   : boolean;
  end;

  //REC_3D_TORPEDO_SUT  = 9; ---------------------------------------------------
  TRecSetTorpedoSUT = record
    pc              : TPacketCheck;

    ShipID          : word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : word;
    mMissileID      : word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang
    mT_ID           : Word;
    OrderID         : byte;

    mTorpedoCourse        : single;
    mTorpedoSpeed         : single;
    mTorpedoDepth         : single;
    mTorpedoSafeDistance  : Single;
    mTorpedoEnDis         : Single;
    mpredm                : word;
    mTargetType           : Byte;
  end;

  // C_REC_ORDER                 = 10;  -------------------------------------
  TRecOrder = record
    PC              : TPacketCheck;
    ShipID          : string[15];

    OrderID         : byte;
    OrderByteParam  : byte;
  end;

  //C_REC_ORDER_XY              = 11;   -------------------------------------
  TRecOrderXY = record
    PC        : TPacketCheck;
    ShipID    : string[15];
    OrderID   : byte;
    OrderType : byte;
    X, Y      : double;
  end;


//----------------------------------------------------------------------------
  //REC_3D_WAYPOINT = 12;
{  TRec3DDataWaypoint = record
    ID: byte;
    Pass: array[0..2] of char;
    ParentUID: string[12];
    UniqueID: string[12];
    Order: integer;
    ProfileType: byte;
    X: double;
    Y: double;
    Speed: single;
    Halu: single;
    Durasi: longword;
    ETA: longword;
  end;
 }

  //C_REC_TRACK_ORDER           = 12;   -------------------------------------
  TRecTrackOrder = record
    PC          : TPacketCheck;
    ShipID      : string[15];
    OrderID     : byte;
    OrderType   : byte;
    Ship_TID    : byte;
    TrackNumber : byte;
    X, Y        : double;
  end;

  //C_REC_ORDER_ASSIGNMENT      = 13; -------------------------------------
  TRecOrderAssignment = record
    PC          : TPacketCheck;
    ShipID      : string[15];
    OrderID     : byte;
    DetectedUID : string[15];
    Ship_TID    : byte;
    TrackNumber : byte;
  end;

  //C_REC_SET_TRACKNUM          = 14; -------------------------------------
  TRecSetTrackNumber = record
    PC          : TPacketCheck;
    ShipID      : string[15];
    OrderID     : byte;
    ShipTID     : byte;
    TrackNumber : byte;
  end;

  //C_REC_FIRE_CONTROL          = 15; -------------------------------------
  TRecFireControlOrder = record
    PC            : TPacketCheck;
    ShipID        : string[15];
    OrderID       : byte;
    FC_number     : byte;
    FC_command    : byte;
    TrackUID      : string[15];
    Ship_TID      : byte;
    TrackNumber   : byte;
    X, Y          : double;
   end;

   //C_REC_GUN_CONTROL           = 16; -------------------------------------
   TRecGunControl = record
      PC          : TPacketCheck;
      ShipID      : string[15];
      OrderID     : byte;   //
      TrackUID    : string[15];
      Ship_TID    : byte;
      TrackNumber : byte;
      Gun_number  : byte;   // gun1,2,3
      AssignedTo  : byte;   // (assign ke FC mana) gun1,2,3
      FireMode    : byte;   // (SINGLE, BURST) * gun1 only
      Bullet1     : byte;   // (PARPROX, IMPACT) gun1,2,3
      Bullet2     : byte;   // (HE_TRACER, PRE_FRAG) * gun2,3 only
      ControlMode : byte;   // (remote, local) gun1,2,3
      IsSync      : boolean;// mengarah ke target ato tidak
      //IsBlind     : boolean;// lg blind ato ga
      //InRange     : boolean;// masuk jarak tembak ato ga
    end;


{uConst
    //REC_SET_MERIAM              = 17;  --------------------------------------
  TRecMeriam = record
    PC: TPacketCheck; //17
    ShipID: word;
    OrderID: byte; //
    Gun_number: byte;
    X, Y: single;
  end;
    }

    //C_REC_XXX_ORDER             = 17; ---------------------------------------
    TRecXXXOrder = record
      PC          : TPacketCheck;
      ShipID      : string[15];
      OrderID     : byte;
      TrackUID    : string[15];
      Ship_TID    : byte;
      TrackNumber : byte;
      X, Y        : double;
      temp1, temp2, temp3, temp4   : byte;
      temp5, temp6   : double;
      temp7   : string[15];
    end;

// C_REC_LINK_ORDER            = 18; --------------------------------------
    TRecLinkOrder = record
      PC          : TPacketCheck;
      ShipID      : string[15];
      OrderID     : byte;
      SenderID    : string[15];
      TrackUID    : string[15];
      TrackSymbol : byte;
      TrackAmp1,
      TrackAmp2   : byte;
      PrivCode    : string[15];
      Ship_TID    : byte;
      TrackNumber : byte;
      Speed,
      Course      : double;
      X, Y, Z     : double;
      Frekwensi   : single;
    end;


   //REC_3D_RBU   = 19; -------------------------------------------------------
  TRec3DSetRBU = record
    pc             : TPacketCheck;
    ShipID         : word;
    mWeaponID      : Word;  // Diisi sesuai Database
    mLauncherID    : word;
    mMissileID     : word;
    mMissileNumber : Word;  // Diisi 0 aj...nanti instruktur yang ngisi ulang
    mCount         : Word;
    mMissileType   : word;
    mTargetID      : Word;  // Added by bagoes
    OrderID        : byte;

    mLncrBearing   : single;
    mLncRange      : single;
    mTargetDepth   : single;
    mCorrBearing   : single;
    mCorrElev      : single;
  end;
  TRecSetRBU = TRec3DSetRBU;

  // REC_DB_ORDER                = 20; -----------------------------------------
  TRecDBEffect = record
    pc: TPacketCheck;
    ShipID: word;
    ModulID: byte;
    CompID: byte;
    StatusID: byte;
    StatusVal: single;
  end;
    // andy
  //C_REC_HARPOON_SETTING        = 30;  --------------------------------------
  TRecHarpoonPanelSetting = record  // 30;
    PC        : TPacketCheck;
    ShipID    : string[15];
    OrderID   : byte;
    OrderData : byte;
  end;

  //REC_ENVI                    = 34;
  //REC_ENVIRONMENT             = REC_ENVI;
  TRecDataEnvironment = record
      pc: TPacketCheck;
      windVelocity: Double;
      windHeading: Double;
      seaCurrentVelocity: Double;
      seaCurrentHeading: Double;
      temperature: Double;
      humidity: Double;
      surfacePressure: Double;
    end;

  // REC_MISSILEPOS              = 50;  ----------------------------------------
  TRecMissilePos = record
    pc: TPacketCheck;

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
  TRec3DMissilePos = TRecMissilePos;

  //REC_3D_SETCONTROL = 51;  ------------------------------------------------
  spActorsController = record
    pc: TPacketCheck;
    ShipID: word;
    TypeID: word;

    ActorRuntimeID1: word;   //Weapon ID
    ActorRuntimeID2: word;   //Launcher ID
    ActorRuntimeID3: word;   //Missile ID
    ActorRuntimeID4: word;   //Missile Number

    OrderID: word;
    x, y, z: double;
    h, p, r : double;
  end;

  // REC_TEXTURE_CAMERA = 52;   ------------------------------------------------
  TRecDataTextureCamera = record
    pc: TPacketCheck;
    ShipID: word;
    LiodID: word;
    ShaderID: word;
   end;

  TRecTextureCamera = TRecDataTextureCamera;

  //REC_3D_UTIL_TOOLS           = 53;
  spUtilityTools = record
    pc: TPacketCheck;
    OrderID: word;
    c0,c1,c2,c3,c4 :word;        //For Camera -> //co  = shipID, c1 =
    c5, c6: double;
  end;

  TRecDataOrder_noval = record
    ID : Byte;
    Pass : array[0..2] of char;
    order : Byte;
  end;

  //REC_2D_ORDER= 54; -------------------------------------------------------
  TRecData2DOrder = record
    pc         : TPacketCheck;
    orderID    : byte;
    numValue   : integer;
    strValue   : string[15];
    strValue2  : string[15];
    strValue3  : string[15];
    ipConsole  : string[15];
  end;

  TRecDataControl = record
    pc        : TPacketCheck;
    orderID   : Byte;
    numValue  : Integer;
  end;

  // REC_CANNON             = 7;  ----------------------------------------
  TRec3DSetWCC = record
   pc               : TPacketCheck;

   ShipID          : word;
   mWeaponID       : Word; //Diisi sesuai Database
   mLauncherID     : word;
   mMissileID      : word;
   mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang
   mOrderID        : byte;

   mTargetID       : Word; // Added by bagoes
   mModeID         : Word; // ModeID

   mUpDown              : Single;
   mAutoCorrectElev     : Single;
   mAutoCorrectBearing  : Single;

   mBalistikID    : Word;
   mSalvoRate     : Word;
  end;

   TRecSplashCannon = record

    Pc         : TPacketCheck;
    ShipID,
    WeaponID,
    LauncherID : Word;
    PosX,
    PosY,
    PosZ       : Double;
  end;

  TRecMessageHandling = record
    Pc              : TPacketCheck;
    MessageID       : word;
    Cmd1            : double;
    Cmd2            : double;
    Cmd3            : double;
    Cmd4            : double;
  end;

{
const  unsigned  char structSetCannon = 7;
const  unsigned  int  ORD_CANNON_LR   = 1; // left-right
const  unsigned  int  ORD_CANNON_UD   = 2; // up-down
const  unsigned  int  ORD_CANNON_F    = 3; // fire

const  unsigned  int  TIPE_AR_LAUNCHER_CANNON = 16;
  }

//  TCPC_T_POSITION= procedure(aRec: TRecDataPosition) of object;
//  TCPS_T_POSITION= procedure(aRec: TRecDataPosition; s: TWSocket) of object;


  //for Console
  TRecStatus_Console = record
    Pc: TPacketCheck;

    OWN_SHIP_UID    : string[15];
    WeaponID   : word;
    ErrorID    : Word;
    ParamError : Byte;
  end;
                                     
  //for C-802 Console
  TRecStatus_Console_C802 = record
    Pc: TPacketCheck;

    OWN_SHIP_UID    : string[15];
    ErrorID    : Word;
    ParamError : Byte;
    LauncherNum: Byte;
  end;

  TRecStatus_Console_Yakhont = record
    Pc: TPacketCheck;

    OWN_SHIP_UID    : string[15];
    ErrorID    : Word;
    ParamError : Byte;
    LauncherNum: Byte;
  end;

  TRecRBU_SonarMode = record
    Pc: TPacketCheck;

    OWN_SHIP_UID    : string[15];
    TARGET_SHIP_UID : string[15];
    Mode            : Boolean;
  end;

   // REC_3D_WCC              = 63;  ----------------------------------------

  // command C-802
   TRecCMD_C802 = record
    pc  : TPacketCheck;
    cmd : Integer;
  end;
  // REC_CMD_C802              = 67;  ----------------------------------------

   TRecData_C802 = record
     pc  : TPacketCheck;

     //Add New
     ShipID          : word;
     mWeaponID       : Word; //Diisi sesuai Database
     mLauncherID     : word;
     mMissileID      : word;
     mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulan

     OrderID         : Byte;

     mTargetBearing  : Single;
     mTargetRange    : Single;
   end;

   // command Yakhont
  TRecCMD_Yakhont = record
     pc  : TPacketCheck;
     cmd : Integer;
  end;

  TRecData_Yakhont = record
     pc  : TPacketCheck;

     //Add New
     ShipID          : word;
     mWeaponID       : Word; //Diisi sesuai Database
     mLauncherID     : word;
     mMissileID      : word;
     mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulan

     mMissile1,
     mMissile2,
     mMissile3,
     mMissile4       : Byte;

     OrderID         : Byte;

     mTargetBearing  : Single;
     mTargetRange    : Single;
   end;


   //REC_EVENT_LOG                     = 79;
   TRecEventLog = record
     pc        : TPacketCheck;
     consoleID : word;
     eventID   : Word;
     param1    : Double;
     param2    : Double;
     param3    : Double;
     ShipID    : word;
   end;

   //REC_GAME_NAME                    = 80;
   TRecGameName = record
     pc        : TPacketCheck;
     GameName  : string[20];
   end;


   TRecStatusGame = record        //=84
     pc  : TPacketCheck;

     ScenarioID : Word;
     StatusConnect : byte;
  end;

  //REC_ENABLE_WEAPON                = 85
  TRecEnableWeapon = record
     pc  : TPacketCheck;

     Shipid     : Integer;
     WeaponID   : byte;
     Value      : Single;
     Launcher   : Byte;

  end;

  //REC_ASROC_TYPE_MISSILE                = 89
  TRecAsrocMissileType = record
     pc  : TPacketCheck;

     ShipId       : Byte;
     WeaponID     : Byte;
     MissileID    : Byte;
     LauncherID   : Byte;
     
     MissileType  : Byte;

  end;

  //Nando & Dandih -> Contoh


   //REC_CMD_STATUS_CONSOLE = 71
   TRecComConsole = record
     pc         : TPacketCheck;
     OrderID    : Integer;
     ShipID     : Integer;
     launcherID : Integer;
     ShipName   : string[20];
     IpSender   : string[20];
   end;

  //Exocet 27
  TRec3DSetExocet_40 = record
    pc                : TPacketCheck;

    shipID            : word;
    mWeaponID         : Word;
    mLauncherID       : word;
    mMissileID        : word;
    mMissileNumber    : Word;

    sOrder            : byte;

    mTRange           : single;
    mTBearing         : single;
      
    mAngular_Mode     : Byte;
    mAgility_Mode     : Byte;
    mInitialStep_Mode : Byte;
    
    mObstacle_Alt     : Single;
    mObstacle_Range   : Single;
    
    mApproach_Range   : Single;
    mTerminal_Range   : Single;

    mLeft_Angle       : Single;
    mRight_Angle      : Single;
    mFar_Range        : Single;
    mNear_Range       : Single;

    mMasking1         : Byte;
    mMasking2         : Byte;
    mMasking3         : Byte;
    mMasking4         : Byte;
    mMasking5         : Byte;
    mMasking6         : Byte;
    mMasking7         : Byte;
    mMasking8         : Byte;
    mMasking9         : Byte;
    mMasking10        : Byte;
    mMasking11        : Byte;
    mMasking12        : Byte;
    mMasking13        : Byte;
    mMasking14        : Byte;
    mMasking15        : Byte;
    mMasking16        : Byte;
    mSeekerOpenPosX   : Double;
    mSeekerOpenPosY   : Double;
    mSeekerOpenHeading   : Single;

    //mMasking          : array[0..15] of Byte;
  end;
  TRecSetExocet_40  = TRec3DSetExocet_40;

  //Tetral
  TRec3DSetTetral = record
    pc          : TPacketCheck;

    ShipID          : Word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : Word;
    mMissileID      : Word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang

    OrderID         : Byte;

    mTargetBearing  : Single;
    mTargetRange    : Single;
    mTargetElev     : Single;
  end;
  TRecSetTetral = TRec3DSetTetral;

  //Mistral
  TRec3DSetMistral = record
    pc          : TPacketCheck;

    ShipID          : Word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : Word;
    mMissileID      : Word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang

    OrderID         : Byte;

    mTargetBearing  : Single;
    mTargetRange    : Single;
    mTargetElev     : Single;
  end;
  TRecSetMistral = TRec3DSetMistral;

  //Strella\
  TRec3DSetStrella = record
    pc          : TPacketCheck;

    ShipID          : Word;
    mWeaponID       : Word; //Diisi sesuai Database
    mLauncherID     : Word;
    mMissileID      : Word;
    mMissileNumber  : Word; //Diisi 0 aj...nanti instruktur yang ngisi ulang

    OrderID         : Byte;

    mTargetBearing  : Single;
    mTargetRange    : Single;
    mTargetElev     : Single;
  end;
  TRecSetStrella = TRec3DSetStrella;

  TRecObjectAssigned = record        { For C802 & Yakhont Only }
    pc            : TPacketCheck;

    ShipID        : Integer;
    ObjectAssign  : Integer;         { ID kapal target }
    OrderID       : integer;
    mode          : Integer;
  end;

  TRecMapCommand = record
    pc        : TPacketCheck;

    OrderID   : Integer;
    ToolID    : Integer;

    MapID     : Integer;

    {Zooming and Positioning}
    X         : Double;
    Y         : Double;
    Scale     : Double;

    {Selecting}
    ShipID    : Integer;
  end;

  TRecWeaponShowRange = record
    pc        : TPacketCheck;

    Order     : Byte; {Show(1)/Hide(0)}
    {Weapon Info}
    wName     : string[30];
    wLauncher : string[30];
    wDetail   : string[30];

    {ship ID}
    ShipID    : Integer;
  end;

  TRecGuidance = record
    pc        : TPacketCheck;
    ShipID    : Word;
    GuidanceID: Word;         // SL     | Helm  | Circle    | Zigzag   | Sinuation | Formation | Evasion | Waypoint| Outrun | Engagement | Shadow  |
                              //====================================================================================================================
    param0    : Single;       // Course | Angle | TgtID     | Course   | Course    |           | TgtID   |         | TgtID  | TgtID      | TgtID   |
    param1    : Single;       // Speed  | Speed | Speed     | Speed    | Speed     |           |         |         |        | Speed      | Speed   |
    param2    : Single;       //        |       | Radius    | legLgth  | Amplitude |           |         |         |        | EgmntRange | TgtRange|
    param3    : Single;       //        |       | Direction |          | Period    |           |         |                  | Altitude   |
    param4    : Single;       //        |       | RangeOffst|          |
    param5    : Single;       //        |       | AngleOffst|          |
    param6    : Single;       //        |       | AbsAglOfst|          |
  end;

  TRec_Command_YakhontPLP = record
    pc        : TPacketCheck;

    Mode      : integer;    // 1 : Request, 2 : Answer Request
    CommandID : Integer;    // For Answer Request : 1 : Idle, 2 : ready Fire;
  end;

  TRec_TorpStatus = record
    pc          : TPacketCheck;
    ShipID      : Word;
    mWeaponID   : Word;
    mLauncherID : Word;
    mMissileID  : Word;
    isFind      : Byte;
    TargetID    : Word;
  end;

  TRec_StatusLoading = record   //86
    pc              : TPacketCheck;
    ShipID          : Word;
    mWeaponID       : Word;
    mLauncherID     : Word;
    mMissileID      : Word;
    mMissileNumber  : Word;
    Status          : Byte;

  end;

  //REC_REPLAY
  TRec_Replay = record
    pc              : TPacketCheck;
    OrderID         : Integer;
    ReplayName      : String[255];
    ReplayControl   : byte; // 1 ; start , 2 : stop, 3 ; pause , 4 ; resume
    ReplaySpeed     : byte;
  end;

  //rec Trajectory view
  TRec_Trajectory_View = record
   pc     : TPacketCheck;
   WeaponLabel : byte;
   Status : byte;
  end;

  //rec ViewRangeWeapon
  TRec_View_Range_Weapon = record
   pc     : TPacketCheck;
   aID    : string[20];
   WeaponName : string[20];
   LauncherName : string[20];
   WeaponType : string[20];
   Status : Boolean;
  end;


const

  //aldy map
  OID_MAP         = 0;
  OID_OBJ_Center  = 1;
  OID_OBJ_Focused = 2;
  OID_OBJ_Select  = 3;
  OID_VIEW_SELECT = 4;
  OID_MAP_OFFSETT = 5;
  OID_MAP_CENTER  = 6;

  //VEHICLE GUIDANCES CONST  ::> yg tidak perlu diabaikan aj
  VG_StraightLine = 1;
  VG_Helm         = 2;
  VG_Circle       = 3;
  VG_Station      = 4;
  VG_Zigzag       = 5;
  VG_Sinuation    = 6;
  VG_Formation    = 7;
  VG_Evasion      = 8;
  VG_Waypoint     = 9;
  VG_Outrun       = 10;
  VG_Engagement   = 11;
  VG_Shadow       = 12;
  VG_WaypointMove = 13;
  VG_WaypointStop = 14;

  // Tambahan Data SPS115 (const)
  //==> TIU
  TIU_OP          = 0;
  TIU_Faulty      = 1;
  TIU_LowVoltage  = 2;
  TIU_NoLink      = 3;

  max_TIUTemp     = 100;


  // ==> Gyro =
  Gyro_Normal               = 0;
  Too_Long_Gyro_caging_Time = 1;
  Gyro_starting_Overload    = 2;
  Too_long_gyro_starting    = 3;
  No_link_with_TIU_portstbd = 4;

  // ==> Barrel =
  Barrel_Normal                     = 0;
  Untimely_starting_time            = 1;
  Barrel_noLongger_ready            = 2;
  Absence_of_gyro                   = 3;
  Error_writing_Torpedo             = 4;
  Exercise_head_not_start           = 5;
  Torpedo_not_leave_barrel_in_fire  = 6;
  // Akhir Tambahan SPS115

  //PORT= '2120';
  BUFFER_SIZE= 1024 * 1024 * 20;
  PACKET_PASS= 'SKL';

  // Record Constan untuk Register Procedure =====================================
  REC_3D_POSITION                 = 1;
  //REC_3D_WAYPOINT               = 12;

  REC_POSITION                    = 2;
  REC_3D_ORDER                    = 3;
  REC_3D_EXOCET                   = 4;
  REC_SET_EXOCET                  = REC_3D_EXOCET;
  __ORD_EXOCET_FIRE           = 1;

  REC_3D_CHAFF                    = 5;
  REC_SET_CHAFF                   = REC_3D_CHAFF;

  REC_3D_ASROCK                   = 6;
  REC_SET_ASROCK                  = REC_3D_ASROCK;
  __ORD_ASROCK_ASSIGNED       = 1;
  __ORD_ASROCK_DEASSIGNED     = 2;
  __ORD_ASROCK_FIRE           = 3;
  __ORD_ASROCK_LOADING        = 4;
  __ORD_ASROCK_ON             = 5;
  __ORD_ASROCK_OFF            = 6;


  C_REC_CANNON                    = 7;
  REC_SET_CANNON                  = C_REC_CANNON;
  __ORD_CANNON_LR             = 1;  // meriam left-right
  __ORD_CANNON_UD             = 2;  // meriam up-down
  __ORD_CANNON_F              = 3;  // meriam fire
  __ORD_CANNON_DIRECT_LR      = 4;  // meriam direct left-right
  __ORD_CANNON_DIRECT_UD      = 5;  // meriam direct up-down
  __ORD_CANNON_DIRECT_F       = 6;  // meriam direct fire
  __ORD_CANNON_START_F        = 7;  // meriam start fire
  __ORD_CANNON_STOP_F         = 8;  // meriam stop fire
  __ORD_CANNON_ASSIGNED       = 9;  // meriam assigned
  __ORD_CANNON_DEASSIGNED     = 10; // meriam deassigned
  __ORD_CANNON_AUTOCORRECT    = 11; // meriam correction
  __ORD_CANNON_ON             = 13; // meriam on
  __ORD_CANNON_OFF            = 14; // meriam off
  __ORD_CANNON_UNLOCK         = 15;
  __ORD_CANNON_LOCK           = 16;


  {Mode ID GUN}
  M_DirBomb           = 1;
  M_IndBomb_BlindBomb = 2;
  M_AirTarget         = 3;


  REC_3D_TORPEDO_MK44             = 8;
  REC_3D_TORPEDO_SUT              = 9;

  {ORD TORP SUT}
  __ORD_TORPEDOSUT_FIRED		  = 1;  // FIRE
  __ORD_TORPEDOSUT_NAVIGATE   = 2;  // NAVIGATE -> UPDATE COURSE, ENDIS DAN DEPTH
  __ORD_TORPEDOSUT_HOMING     = 3;  // HOMMING ->
  __ORD_TORPEDOSUT_SEARCH     = 4;  // ACTIVE SEARCH SONAR TORPEDO -> Pergerakan based on Intercept or Bearing mode
  __ORD_TORPEDOSUT_MANUAL     = 5;  // MANUALY UPDATE COURSE DAN DEPTH
  __ORD_TORPEDOSUT_SHUTDOWN   = 6;  // KILL TORP SUT
  __ORD_TORPEDOSUT_LOADING    = 7;  // LOADING
  __ORD_TORPEDOSUT_ON         = 8;
  __ORD_TORPEDOSUT_OFF        = 9;
  __ORD_TORPEDOSUT_DELETE     = 10;
  __ORD_TORPEDOSUT_TARGETSEARCHPROGRAM = 11;
  {ORD TORP SUT}

  __TORPEDOSUT_TARGET_SURFACE    = 1;   // search surface
  __TORPEDOSUT_TARGET_SUBSURFACE = 2;   // search subsurface

  C_REC_ORDER                     = 10;
  C_REC_ORDER_XY                  = 11;
  C_REC_TRACK_ORDER               = 12;
  C_REC_ORDER_ASSIGNMENT          = 13;
  C_REC_SET_TRACKNUM              = 14;
  C_REC_FIRE_CONTROL              = 15;
  C_REC_GUN_CONTROL               = 16;

  //uConst.REC_SET_MERIAM              = 17;
  C_REC_XXX_ORDER                 = 17;
  C_REC_LINK_ORDER                = 18;

  REC_3D_RBU                      = 19;
  REC_SET_RBU                     = REC_3D_RBU;
  __ORD_RBU_ASSIGNED          = 1; // RBU Assign
  __ORD_RBU_DEASSIGNED        = 2; // RBU Deassign
  __ORD_RBU_FIRE              = 3; // RBU Fire
  __ORD_RBU_LOADING           = 4; // RBU Loading
  __ORD_RBU_AUTO              = 5; // RBU Auto
  __ORD_RBU_STARTF            = 6; // RBU Start Fire
  __ORD_RBU_STOPF             = 7; // RBU Stop Fire
  __ORD_RBU_FIRE_SALVO        = 6; // RBU Fire
  __ORD_RBU_ON                = 8;
  __ORD_RBU_OFF               = 9;

  C_REC_HARPOON_SETTING           = 30;
  REC_DB_ORDER                    = 31;

  REC_DATA_C802         = 20; //------- End C802 -----------
    __ORD_C802_FIRE          = 1;
    __ORD_C802_RADAR_ASSIGN  = 2;
    __ORD_C802_LOADING       = 3;
    __ORD_C802_ON            = 4;
    __ORD_C802_OFF           = 5;
    
  REC_CMD_C802          = 25; //-----   C802 ---------------
    CMD_C802_Combat     = 1;
    CMD_C802_Simulate   = 2;
    CMD_C802_Check      = 3;
    CMD_C802_LogOff     = 4;
    CMD_C802_Status     = 5;
    CMD_C802_MControl   = 6;
    CMD_C802_ParSetting = 7;
    CMD_C802_RecordData = 8;
    CMD_C802_Tab        = 9;
    CMD_C802_Esc        = 10;
    CMD_C802_BackSpace  = 11;
    CMD_C802_Enter      = 13;
    CMD_C802_OnOff      = 14;
    CMD_C802_Up         = 15;
    CMD_C802_Down       = 16;
    CMD_C802_Left       = 17;
    CMD_C802_Right      = 18;
    CMD_C802_Dash       = 19;
    CMD_C802_Dot        = 20;
    CMD_C802_1          = 21;
    CMD_C802_2          = 22;
    CMD_C802_3          = 23;
    CMD_C802_4          = 24;
    CMD_C802_5          = 25;
    CMD_C802_6          = 26;
    CMD_C802_7          = 27;
    CMD_C802_8          = 28;
    CMD_C802_9          = 29;
    CMD_C802_0          = 30;

    CMD_C802Archos_Exit = 100;
    CMD_C802Archos_Start = 200;

    OrdID_C802_launch = 1;

  //----- Tetral, Mistral, Strella -----
  REC_CMD_TETRAL      = 21;
    __ORD_TETRAL_FIRE     = 1;
    __ORD_TETRAL_ASSIGN   = 2;
    __ORD_TETRAL_LOADING  = 8;
    __ORD_TETRAL_ON      = 9;
    __ORD_TETRAL_OFF     = 10;

  REC_CMD_MISTRAL     = 22;
    __ORD_MISTRAL_FIRE    = 1;
    __ORD_MISTRAL_ASSIGN  = 2;
    __ORD_MISTRAL_LOADING = 8;
    __ORD_MISTRAL_ON      = 9;
    __ORD_MISTRAL_OFF     = 10;
    __ORD_MISTRAL_UNLOCK   = 11;
    __ORD_MISTRAL_LOCK     = 12;

  REC_CMD_STRELLA     = 23;
    __ORD_STRELLA_FIRE    = 1;
    __ORD_STRELLA_ASSIGN  = 2;
    __ORD_STRELLA_LOADING = 8;
    __ORD_STRELA_ON       = 9;
    __ORD_STRELA_OFF      = 10;
    __ORD_STRELA_UNLOCK   = 11;
    __ORD_STRELA_LOCK     = 12;

  REC_DATA_Yakhont        = 24; //------ End Yakhont ---------
     __ORD_Yahkont_FIRE    = 1;
     __ORD_Yahkont_RELEASE = 2;
     __ORD_Yahkont_LOADING = 3;
     __ORD_YAKHONT_ON      = 4;
     __ORD_YAKHONT_OFF     = 5;

  REC_STAT_ORDER_YAKHONT  = 25;

  REC_CMD_Yakhont         = 26; //------- Yakhont ------------
  CMD_Yakhont_Cancel      = 1;
  CMD_Yakhont_Backlight   = 2;
  CMD_Yakhont_Key         = 3;
  CMD_Yakhont_Start       = 4;

  CMD_Yakhont_OpenKey     = 5;
  CMD_Yakhont_SCOn        = 6;
  CMD_Yakhont_SCOff       = 7;
  CMD_Yakhont_ReadyToFire = 8;

  CMD_Yakhont_Terminate   = 9;

  REC_CMD_EXOCET_40       = 27;
    __ORD_EXOCET_40_FIRE     = 1;
    __ORD_EXOCET_40_LOADING  = 2;
    __ORD_EXOCET_40_ON      = 3;
    __ORD_EXOCET_40_OFF     = 4;

  REC_ENVI                        = 34;
  REC_ENVIRONMENT                 = REC_ENVI;

  REC_ORD_NOVAL                   = 40;
  REC_ORDER_NOVAL                 = REC_ORD_NOVAL;

  REC_MISSILEPOS                  = 50;
  REC_3D_MISSILEPOS               = REC_MISSILEPOS;

  REC_3D_SETCONTROL               = 51;
  REC_TEXTURE_CAMERA              = 52;
  REC_3D_UTIL_TOOLS               = 53;

  REC_2D_ORDER                    = 54;

  REC_STAT_ORDER_CONSOLE          = 55;
  REC_ERROR_SPS115 		            = 56;
  REC_SPSS_ORDER			            = 57;
  _ORD_SPS_FIRE           = 1;
  _ORD_SPS_LOADING        = 3;
  __ORD_SPS_ON            = 4;
  __ORD_SPS_OFF           = 5;

  REC_SET_TIU_Port 			          = 58;
  REC_SET_TIU_Stbd 			          = 59;

  REC_ASRL_PANEL_SETTING          = 62;
  REC_3D_WCC                      = 63;
  REC_SET_WCC                     = REC_3D_WCC;
  REC_STAT_CANNON_SPLASH          = 64;
  REC_RBU_SONARMODE			          = 65;

  RecRBU_SonarMode_ORDER          = 66;

  REC_CMD_COM_CONSOLE             = 71;

  REC_STAT_ORDER_CONSOLE_C802     = 72;
  REC_STAT_ASSIGN_OBJECT          = 73;
    __ORD_ID_C802     = 1;
    __ORD_ID_YAKHONT  = 2;
    
  {aldy}
  REC_MAP_COMMAND                 = 74;
  REC_WEAPON_SHOW_RANGE           = 75;
  REC_STATUS_C802                 = 76;

  REC_GUIDANCE                    = 77;

  REC_STATUS_YAKHONT              = 78;

  REC_EVENT_LOG                   = 79;
  REC_GAME_NAME                   = 80;

  {Farah Yakhont PLP}
  REC_COMMAND_YAKHONTPLP          = 81;

  REC_RECV_TORP_STATE             = 82;
  REC_DATA_CONTROL                = 83;
  REC_STATUS_GAME                 = 84;
  REC_ENABLE_WEAPON               = 85;
  REC_STATUS_LOADING              = 86;
  REC_STATUS_MESSAGE              = 87;
  REC_REPLAY                      = 88;
  REC_ASROC_TYPE_MISSILE          = 89;
  REC_TRAJECTORY_VIEW             = 90;
  REC_VIEW_RANGE_WEAPON           = 91;

  //STATUS WEAPON
  //ERROR FOR SPS115
  __STAT_SPS_115V                   = 101;
    __PARAM_115V_ON       = 1;
    __PARAM_115V_OFF      = 2;
  __STAT_SPS_NDS                    = 102;
    __PARAM_NDS_ON        = 1;
    __PARAM_NDS_OFF       = 2;
  __STAT_SPS_TIU_PORT               = 103;
  __STAT_SPS_TIU_STARBOARD          = 104;
    __PARAM_TIU_NORMAL      = 0;
    __PARAM_TIU_FAULTY      = 1;
    __PARAM_TIU_LOWVOLTAGE  = 2;
    __PARAM_TIU_NOLINK      = 3;
  __STAT_SPS_TEMP_PORT              = 105;
  __STAT_SPS_TEMP_STARBOARD         = 106;
    __PARAM_TEMP_NORMAL     = 1;
    __PARAM_TEMP_OVERHEAD   = 2;
  __STAT_SPS_45_DEG_PORT            = 107;
  __STAT_SPS_45_DEG_STARBOARD       = 108;
    __PARAM_45_ON   = 1;
    __PARAM_45_OFF  = 2;
  __STAT_SPS_GYRO_1                 = 109;
  __STAT_SPS_GYRO_2                 = 110;
  __STAT_SPS_GYRO_3                 = 111;
  __STAT_SPS_GYRO_4                 = 112;
  __STAT_SPS_GYRO_5                 = 113;
  __STAT_SPS_GYRO_6                 = 114;
    __PARAM_GYRO_NORMAL        = 1;
    __PARAM_GYRO_LONG_CAGING   = 2;
    __PARAM_GYRO_OVERLOAD      = 3;
    __PARAM_GYRO_LONG_STARTING = 4;
    __PARAM_GYRO_NOLINK_TIU    = 5;
  __STAT_SPS_BARREL_1               = 115;
  __STAT_SPS_BARREL_2               = 116;
  __STAT_SPS_BARREL_3               = 117;
  __STAT_SPS_BARREL_4               = 118;
  __STAT_SPS_BARREL_5               = 119;
  __STAT_SPS_BARREL_6               = 120;
    __PARAM_BARREL_NORMAL      = 1;
    __PARAM_BARREL_UNTIMESTART = 2;
    __PARAM_BARREL_NOREADY     = 3;
    __PARAM_BARREL_NOGYRO      = 4;
    __PARAM_BARREL_WRITINGTRP  = 5;
    __PARAM_BARREL_HEADERROR   = 6;
    __PARAM_BARREL_FIREERROR   = 7;
  __STAT_SPS_SELFTEST               = 121;
    __PARAM_SELFTEST_OK        = 1;
    __PARAM_SELFTEST_FAIL      = 2;

  //ERROR FOR ASROCK - TDC
  __STAT_ASROCK_HYDR                = 201;
    __PARAM_HYDR_ON         = 1;
    __PARAM_HYDR_OFF        = 2;
  __STAT_ASROCK_LAUNCHER            = 202;
    __PARAM_LNCHR_ON        = 1;
    __PARAM_LNCHR_OFF       = 2;
  __STAT_ASROCK_LAUNCHER_SYNC       = 203;
    __PARAM_LNCHR_S_ON      = 1;
    __PARAM_LNCHR_S_OFF     = 2;
  __STAT_ASROCK_ROCKET1_READY       = 204;
    __PARAM_ROCKET1_ON      = 1;
    __PARAM_ROCKET1_OFF     = 2;
  __STAT_ASROCK_ROCKET2_READY       = 205;
    __PARAM_ROCKET2_ON      = 1;
    __PARAM_ROCKET2_OFF     = 2;
  __STAT_ASROCK_AVAILABLE_ERIKA     = 206;
  __STAT_ASROCK_SPEED_ERIKA         = 207;
  __STAT_ASROCK_FUZE_ERIKA          = 208;
  __STAT_ASROCK_AVAILABLE_NELLY     = 209;
  __STAT_ASROCK_SPEED_NELLY         = 210;
  __STAT_ASROCK_FUZE_NELLY          = 211;

  //ERROR FOR RBU
  __STAT_RBU_BALISTIK12                 = 301;
  __STAT_RBU_PERUBAHAN_HALU             = 302;
  __STAT_RBU_BAHAYA_TPO                 = 303;
  __STAT_RBU_KONTAK_HILANG              = 304;  // JUGA UNTUK INDIKATOR ADA KONTAK
  __STAT_RBU_ALIRAN_KAPAL               = 305;   // u/ RBU mulai 305 kebwah defaultnya di bikin true ya mas yg mengerjakan Instruktur!!!
  __STAT_RBU_UNFORMER_I_LEFT            = 306;
  __STAT_RBU_UNFORMER_II_LEFT           = 307;
  __STAT_RBU_UNFORMER_I_RIGHT           = 308;
  __STAT_RBU_UNFORMER_II_RIGHT          = 309;
                                //   310
    // MISSILE_FAULT
  __STAT_RBU_LAUNCHER1_MISSILE1_FAULT    = 311;
  __STAT_RBU_LAUNCHER1_MISSILE2_FAULT    = 312;
  __STAT_RBU_LAUNCHER1_MISSILE3_FAULT    = 313;
  __STAT_RBU_LAUNCHER1_MISSILE4_FAULT    = 314;
  __STAT_RBU_LAUNCHER1_MISSILE5_FAULT    = 315;
  __STAT_RBU_LAUNCHER1_MISSILE6_FAULT    = 316;
  __STAT_RBU_LAUNCHER1_MISSILE7_FAULT    = 317;
  __STAT_RBU_LAUNCHER1_MISSILE8_FAULT    = 318;
  __STAT_RBU_LAUNCHER1_MISSILE9_FAULT    = 319;
  __STAT_RBU_LAUNCHER1_MISSILE10_FAULT   = 320;
  __STAT_RBU_LAUNCHER1_MISSILE11_FAULT   = 321;
  __STAT_RBU_LAUNCHER1_MISSILE12_FAULT   = 322;

  __STAT_RBU_LAUNCHER2_MISSILE1_FAULT    = 331;
  __STAT_RBU_LAUNCHER2_MISSILE2_FAULT    = 332;
  __STAT_RBU_LAUNCHER2_MISSILE3_FAULT    = 333;
  __STAT_RBU_LAUNCHER2_MISSILE4_FAULT    = 334;
  __STAT_RBU_LAUNCHER2_MISSILE5_FAULT    = 335;
  __STAT_RBU_LAUNCHER2_MISSILE6_FAULT    = 336;
  __STAT_RBU_LAUNCHER2_MISSILE7_FAULT    = 337;
  __STAT_RBU_LAUNCHER2_MISSILE8_FAULT    = 338;
  __STAT_RBU_LAUNCHER2_MISSILE9_FAULT    = 339;
  __STAT_RBU_LAUNCHER2_MISSILE10_FAULT   = 340;
  __STAT_RBU_LAUNCHER2_MISSILE11_FAULT   = 341;
  __STAT_RBU_LAUNCHER2_MISSILE12_FAULT   = 342;
      // parameter on off
    __PARAM_RBU_ON  = 1;
    __PARAM_RBU_OFF = 2;

  //ERROR FOR TOCOS
  __STAT_TOCOS_TempWEC                    = 401;
  __STAT_TOCOS_TempTCC                    = 402;
  __STAT_TOCOS_FuseWEC                    = 403;
  __STAT_TOCOS_FuseTCC                    = 404;
  __STAT_TOCOS_PowerResetWEC              = 405;
  __STAT_TOCOS_PowerResetTCC              = 406;
  __STAT_TOCOS_CMPTR                      = 407;
  __STAT_TOCOS_SOFTW                      = 408;
  __STAT_TOCOS_NUG_1                      = 409;
  __STAT_TOCOS_NUG_2                      = 410;
  __STAT_TOCOS_AntiCondensHeating         = 411;
  __STAT_TOCOS_LOADPROGR                  = 412;

  __STAT_TOCOS_Port_Indikator_Port        = 413;
  __STAT_TOCOS_StbPort_Indikator_Port     = 414;
  __STAT_TOCOS_Port_ToSupply              = 415;
  __STAT_TOCOS_StbPort_ToSupply           = 416;
  __STAT_TOCOS_Port_120_BAR               = 417;
  __STAT_TOCOS_StbPort_120_BAR            = 418;
  __STAT_TOCOS_Port_20_BAR                = 419;
  __STAT_TOCOS_StbPort_20_BAR             = 420;
  __STAT_TOCOS_Port_DOOR_Open             = 421;
  __STAT_TOCOS_StbPort_DOOR_Open          = 422;
  __STAT_TOCOS_Port_TORP_On               = 423;
  __STAT_TOCOS_StbPort_TORP_On            = 424;
  __STAT_TOCOS_Port_Ready_To_Fire         = 425;
  __STAT_TOCOS_StbPort_Ready_To_Fire      = 426;

  __STAT_TOCOS_EXTSTABAVL                 = 427;
  __STAT_TOCOS_CASSTABAVL                 = 428;
    // parameter on off
    __PARAM_TOCOS_ON  = 1;
    __PARAM_TOCOS_OFF = 2;

  //ERROR FOR WCC
  __STAT_RRNF                       = 501;
    __PARAM_RRNF_ON          = 1;
    __PARAM_RRNF_OFF         = 2;
  __STAT_RPC_LPC                    = 502;
    __PARAM_RPC_ON           = 1;
    __PARAM_LPC_ON          = 2;
  __STAT_RDY_RH_LH_MAG              = 503;
    __PARAM_RH_MAG_ON        = 1;
    __PARAM_RH_MAG_OFF       = 2;
  __STAT_RADAR_ERROR                = 504;
    __PARAM_RADAR_ERROR_ON   = 1;
    __PARAM_RADAR_ERROR_OFF  = 2;
  __STAT_COMPUTER                   = 505;
    __PARAM_COMPUTER_ON      = 1;
    __PARAM_COMPUTER_OFF     = 2;
  __STAT_SYN_GUN2                   = 506;
    __PARAM_SYN_GUN2_ON      = 1;
    __PARAM_SYN_GUN2_OFF     = 2;
  __STAT_SYN_GUN3                   = 507;
    __PARAM_SYN_GUN3_ON      = 1;
    __PARAM_SYN_GUN3_OFF     = 2;

  //ERROR FOR YAKHONT
  __STAT_YAKHONT_PRINTER            = 601;
  __STAT_YAKHONT_CONSOLE_N1         = 602;
  __STAT_YAKHONT_CONSOLE_N2         = 603;
  __STAT_YAKHONT_RIGHT_1            = 604;
  __STAT_YAKHONT_RIGHT_3            = 605;
  __STAT_YAKHONT_LEFT_2             = 606;
  __STAT_YAKHONT_LEFT_4             = 607;
  __STAT_YAKHONT_KR231              = 608;
  __STAT_YAKHONT_GYRO               = 609;
  __STAT_YAKHONT_INS300V            = 610;
  __STAT_YAKHONT_INS27V             = 611;

  __YAKHONT_STATUS_ON               = 1;
  __YAKHONT_STATUS_OFF              = 2;

  //ERROR FOR C802
  //Launcher 1
  __STAT_C802_INITSTATE             = 701;
  __STAT_C802_POWERSUPPLY           = 702;
  __STAT_C802_TURNONEQUIP           = 703;
  __STAT_C802_CHECKSTAGE1           = 704;
  __STAT_C802_ANGLESET              = 705;
  __STAT_C802_COCHECK               = 706;
  __STAT_C802_TZKSETTING            = 707;
  __STAT_C802_COMMANDNO3            = 708;
  __STAT_C802_MISNORMAL             = 709;
  __STAT_C802_ACCURATECAL           = 710;
  __STAT_C802_INSIDESECTR           = 711;
  __STAT_C802_LIMITEROUT            = 712;
  __STAT_C802_RIGIDITYSTT           = 713;
  __STAT_C802_FULLOPEN              = 714;
  __STAT_C802_BOOSTERARM            = 715;
  __STAT_C802_LAUNCHREADY           = 716;
  __STAT_C802_LAUNCHBUTTON          = 717;
  __STAT_C802_BATTERYACT            = 718;
  __STAT_C802_POWERSWITCH           = 719;
  __STAT_C802_GYROUNCAGED           = 720;
  __STAT_C802_IGNITION              = 721;
  __STAT_C802_TAKEOFF               = 722;

  __STAT_C802_PRECHECK_LAUNCHER1       = 701;
  __STAT_C802_PRECHECK_LAUNCHER2       = 702;
  __STAT_C802_PRECHECK_LAUNCHER3       = 703;
  __STAT_C802_PRECHECK_LAUNCHER4       = 704;

  __STAT_C802_READYCONDITION_LAUNCHER1 = 705;
  __STAT_C802_READYCONDITION_LAUNCHER2 = 706;
  __STAT_C802_READYCONDITION_LAUNCHER3 = 707;
  __STAT_C802_READYCONDITION_LAUNCHER4 = 708;

  __STAT_C802_LAUNCH_LAUNCHER1         = 709;
  __STAT_C802_LAUNCH_LAUNCHER2         = 710;
  __STAT_C802_LAUNCH_LAUNCHER3         = 711;
  __STAT_C802_LAUNCH_LAUNCHER4         = 712;

    // parameter on off
    __PARAM_C802_ON  = 1;
    __PARAM_C802_OFF = 2;

  __STAT_MOC_RadarARPA = 801;
  __STAT_MOC_MW08      = 802;
  __STAT_MOC_LIROD_MK2 = 803;
  __STAT_MOC_Kingklip  = 804;
    __PARAM_MOC_ON  = 1;
    __PARAM_MOC_OFF = 2;

  //ERROR FOR TETTRAL
  __STAT_TETRAL_FWD    = 901;
  __STAT_TETRAL_AFT    = 902;
    __PARAM_TETRAL_ON  = 1;
    __PARAM_TETRAL_OFF = 2;

 //ERROR FOR EXOCET40
  __STAT_EXOCET40_ENABLE  = 1001;
  __STAT_EXOCET40_SafetyFA = 1002;
  __STAT_EXOCET40_ControlFA = 1003;
  __STAT_EXOCET40_FIRING = 1004;
    __PARAM_EXOCET40_ON  = 1;
    __PARAM_EXOCET40_OFF = 2;

 //ERROR FOR CANNON76
  __STAT_CANNON76_ENABLE  = 1101;
    __PARAM_CANNON76_ON  = 1;
    __PARAM_CANNON76_OFF = 2;

 //ERROR FOR STRELA
   __STAT_STRELA_LAUNCER1  = 1201;
   __STAT_STRELA_LAUNCER2  = 1202;
   __STAT_STRELA_LAUNCER3  = 1203;
   __STAT_STRELA_LAUNCER4  = 1204;
      __PARAM_STRELA_ON  = 1;
      __PARAM_STRELA_OFF = 2;

  //ERROR FOR MISTRAL
   __STAT_MISTRAL_LAUNCER1  = 1301;
   __STAT_MISTRAL_LAUNCER2  = 1302;
      __PARAM_MISTRAL_ON  = 1;
      __PARAM_MISTRAL_OFF = 2;

 //ERROR FOR CANNON40
  __STAT_CANNON40_ENABLE  = 1401;
    __PARAM_CANNON40_ON  = 1;
    __PARAM_CANNON40_OFF = 2;

  //ERROR FOR CANNON57
  __STAT_CANNON57_ENABLE  = 1501;
    __PARAM_CANNON57_ON  = 1;
    __PARAM_CANNON57_OFF = 2;


  C_REC_PACKETNAME :  array [1 .. 91] of string =
  ('REC_3D_POSITION',
   'REC_POSITION',
   'REC_3D_ORDER',
   'REC_3D_EXOCET',
   'REC_3D_CHAFF',

   'REC_3D_ASROCK',
   'C_REC_MERIAM',
   'REC_3D_TORPEDO_MK44',
   'REC_3D_TORPEDO_SUT',
   'C_REC_ORDER',
{11}
   'C_REC_ORDER_XY',
   'C_REC_TRACK_ORDER',
   'C_REC_ORDER_ASSIGNMENT',
   'C_REC_SET_TRACKNUM',
   'C_REC_FIRE_CONTROL',

   'C_REC_GUN_CONTROL',
   'C_REC_XXX_ORDER',
   'C_REC_LINK_ORDER',
   'REC_SET_RBU',
   'REC_802',

{21}
   'REC_TETRAL',
   'REC_MISTRAL',
   'REC_STRELLA',
   'REC_DATA_Yakhont',
   '',

   '',
   'REC_EXOCET40',
   '',
   '',
   'C_REC_HARPOON_SETTING',

{31}
   'REC_DB_ORDER',
   '',
   '',
   'REC_ENVI',
   '',

   '',
   '',
   '',
   '',
   'REC_ORD_NOVAL',

{41}
   '',
   '',
   '',
   '',
   '',

   '',
   '',
   '',
   '',
   'REC_MISSILEPOS',

{51}
   'REC_3D_SETCONTROL ',
   'REC_TEXTURE_CAMERA',
   'REC_3D_UTIL_TOOLS',
   'REC_2D_ORDER',
   'REC_STAT_ORDER_CONSOLE',
   
   'REC_ERROR_SPS115',
   'REC_SPSS_ORDER',
   'REC_SET_TIU_Port',
   'REC_SET_TIU_Stbd',
   '',
{61}
   '',
   'REC_ASRL_PANEL_SETTING',
   'REC_3D_WCC',
   'REC_STAT_CANNON_SPLASH',
   'REC_RBU_SONARMODE',

   'RecRBU_SonarMode_ORDER',
   'REC_CMD_C802',
   'REC_DATA_C802',
   'REC_CMD_Yakhont',
   'REC_DATA_Yakhont',
{71}
   'REC_CMD_COM_CONSOLE',
   'REC_STAT_ORDER_CONSOLE_C802',
   'REC_STAT_ASSIGN_OBJECT' ,
   'REC_MAP_COMMAND',
   'REC_WEAPON_SHOW_RANGE',
{76}
   'REC_STATUS_C802',
   'REC_GUIDANCE',
   'REC_STATUS_YAKHONT',
   'REC_EVENT_LOG',
   'REC_GAME_NAME',
{81}
   'REC_COMMAND_YAKHONTPLP',
   'REC_RECV_TORP_STATE',
   'REC_DATA_CONTROL',
   'REC_STATUS_GAME',
   'REC_ENABLE_WEAPON',
   'REC_STATUS_LOADING',
   'REC_STATUS_MESSAGE',
   'REC_REPLAY',
   'REC_ASROC_TYPE_MISSILE',
   'REC_TRAJECTORY_VIEW',
{91}
   'REC_VIEW_RANGE_WEAPON'

);
  // OrderID untuk TDC order Recognizer C_REC_ORDER .. C_REC_LINK_ORDER --------

  OrdID_select_radar_type     = 1;
  OrdID_start_ICM             = 2;
  OrdID_update_ICM            = 3;
  OrdID_end_ICM               = 4;
  OrdID_init_datum            = 5;
  OrdID_FOC_plus              = 6;
  OrdID_FOC_minus             = 7;

  OrdID_change_ident          = 8;
  OrdID_ident_bawah_air       = OrdID_change_ident;    // old value = 8
  OrdID_ident_atas_air        = OrdID_change_ident;    // old value = 16;
  OrdID_ident_udara           = OrdID_change_ident;    // old value = 23;

  OrdID_assign_tor            = 9;
  OrdID_deassign_tor          = 10;
  OrdID_assign_asrl           = 11;
  OrdID_deassign_asrl         = 12;
  OrdID_WIPE                  = 13;

  OrdID_init_ram              = 14;
  OrdID_init_ram_atas_air     = OrdID_init_ram;            // old value = 14;
  OrdID_init_ram_udara        = OrdID_init_ram;            // old value = 21;

  OrdID_assign_ram            = 15;
  OrdID_change_ampl_info      = OrdID_assign_ram;

  OrdID_init_track            = 16;
  OrdID_update_SSM            = 18;

  OrdID_assign_SSM            = 19;
  OrdID_deassign_SSM          = 20;

  OrdID_init_auto             = 21;  // track automatic
  OrdID_CorrectRAM            = 22;

  OrdID_init_DR               = 23;  // track dead recon

  OrdID_init_esm_fix          = 24;
  OrdID_Synch_timebase        = 25;
  OrdID_UpdateTrackPos        = 26;
  OrdID_assign_FC_WCC         = 27;
  OrdID_deassign_FC_WCC       = 28;

  OrdID_assign_FC             = OrdID_assign_FC_WCC;
  OrdID_deassign_FC           = OrdID_deassign_FC_WCC;
  OrdID_BreakTrack            = OrdID_deassign_FC;

  OrdID_assignTrackSinbad       = 29;
  OrdID_InputPeriskop           = 30;
  OrdID_assign_engBox           = 31;

  OrdID_assign_gun              = 32;
  OrdID_deassign_gun            = 33;

  OrdID_assign_FC_OCC           = 34;
  OrdID_deassign_FC_OCC         = 35;

  //OrdID_TrackRepos            = 36;
  OrdID_SwitchPosition          = 37;
  OrdID_TrackLost               = 38;

  OrdID_init_point              = 39;
  OrdID_recv_sonar_owa          = 40;

  OrdID_send_link               = 41;
  OrdID_stop_send_link          = 42;

  OrdID_correlate_track         = 43;
  OrdID_decorrelate_track       = 44;

  OrdID_UpdateTrackPos_Owa      = 45;

  ORD_ASROCK_ASSIGNED         = 1; // Asrock Assign
  ORD_ASROCK_DEASSIGNED       = 2; // Asrock Deassign
  ORD_ASROCK                  = 3; // Asrock Fire


// added From Tocos
  ORD_TORPEDOMK46_FIRED     = 54; // (36)
  ORD_3D_TORPEDO_SUT_FIRED  = 55; // (37)
  ORD_3D_TORPEDO_SUT_HANDLE = 56; // (38)

  OrdID_assign_torpedoSUT   = 57; // (39)
  OrdID_deassign_torpedoSUT = 58; // (40)

  ORD_3D_TORPEDO_SUT_UPDATE_BEARING = 59;
  ORD_3D_TORPEDO_SUT_UPDATE_INTERCEPT = 60;

// End From Tocos


  C_Max_Order_ID                = 60;


  C_ORDER_STR :array[1..C_Max_Order_ID] of string =
  (
    'select_radar_type',
    'start_ICM',
    'update_ICM',
    'end_ICM',
    'init_datum',
    'FOC_plus',
    'FOC_minus',
    'change_ident',
    'assign_tor',
    'deassign_tor',
    'assign_asrl',
    'deassign_asrl',
    'WIPE',
    'init_ram',
    'assign_ram',
    '',
    '',
    'update_SSM',
    'assign_SSM',
    'deassign_SSM',
    'init AUTO',
    'assign_ram_udara',
    'init DR',
    'init_esm_fix',
    'Synch TB',
    'Update Track Pos',
    'assign_FC_WCC',
    'deassign_FC_WCC',
    'fire_gun1',
    'fire_gun2',
    'fire_gun3',
    'assign_gun',
    'deassign_gun',
    'assign_FC_OCC',
    'deassign_FC_OCC',
    '',
	  '',
	  '',
	  '',
	  '',
	  '',
	  '',
    '',
	  '',
	  '',
	  '',
	  '',
	  '',
	  '',
	  '',
    'Asrock Assign',
    'Asrock Deassign',
    'Asrock Fire',

	  // Tocos
	  'fire_torpedoMK46',
    'fire_torpedoSUT',
    'torpedoSUT_handle',
    'assign_torpSUT',
    'deassign_torpSUT',
    'ORD_3D_TORPEDO_SUT_UPDATE_BEARING',
    'ORD_3D_TORPEDO_SUT_UPDATE_INTERCEPT'
  );

  // order for harpoon  C_REC_HARPOON_SETTING
  OrdHpn_None            = 0;
  OrdHpn_LaunchMode      = 1;
  OrdHpn_SearchMode      = 2;
  OrdHpn_SearchArea      = 3;
  OrdHpn_RecSearchArea   = 4;
  OrdHpn_LauncherTube    = 5;

  OrdHpn_Selected        = 10;
  OrdHpn_Sel_Area        = 11;


  C_OrdType_Torpedo_MK44: byte  = 0;
  C_OrdType_Torpedo_A244: byte  = 1;

  C_OrdType_RAM_atasair:byte = 0;    //TTrackDomain tdAtasAir
  C_OrdType_RAM_udara  :byte = 2;    //TTrackDomain tdudaraa


  CT_EXOCET  = 55;
  CT_TORPEDO_SUT = 57;




  /////////////////////////////////////////////////////////////////////////
  /// REC_3D_ORDER    = 3;
  //........................................................................
  ORD_SHIP_DEL			= 1;
  ORD_NETWORK       = 11;
  ORD_SETPOS        = 12;
  ORD_THROTTLE      = 21; // ...
  ORD_RUDDER        = 22;
  ORD_STOP          = 23;
  ORD_VERRUDDER     = 24;
  ORD_CAM_ANJUNGAN  = 26;
  ORD_CAM_BLK       = 27;
  ORD_ORD_ADDANGLE  = 69; // ...

  ORD_BELL = 28;
    ORD_BELL0 = 0;
    ORD_BELL1 = 1;
    ORD_BELL2 = 2;
    ORD_BELL3 = 3;
    ORD_BELL4 = 4;
    ORD_BELL5 = 5;
    ORD_BELL6 = 6;
    ORD_BELL7 = 7;
    ORD_BELL8 = 8;
    ORD_BELL9 = 9;

  ORD_ALT = 29;

  ORD_LAMP = 30;
    ORD_AnchorLight = 1;
    ORD_AnchorLightOff = 2;
    ORD_SternLight = 3;
    ORD_SternLightOff = 4;
    ORD_MastheadLight = 5;
    ORD_MastheadLightOff = 6;
    ORD_MastheadLight2 = 7;
    ORD_MastheadLight2Off = 8;
    ORD_PortLight = 9;
    ORD_PortLightOff = 10;
    ORD_StarboardLight = 11;
    ORD_StarboardLightOff = 12;
    ORD_SpecialLightL1Off = 13;
    ORD_SpecialLightL1Red = 14;
    ORD_SpecialLightL1White = 15;
    ORD_SpecialLightL2Off = 16;
    ORD_SpecialLightL2Red = 17;
    ORD_SpecialLightL2White = 18;
    ORD_SpecialLightL3Off = 19;
    ORD_SpecialLightL3Red = 20;
    ORD_SpecialLightL3White = 21;
    ORD_SpecialLightR1Off = 22;
    ORD_SpecialLightR1Red = 23;
    ORD_SpecialLightR1White = 24;
    ORD_SpecialLightR2Off = 25;
    ORD_SpecialLightR2Red = 26;
    ORD_SpecialLightR2White = 27;
    ORD_SpecialLightR3Off = 28;
    ORD_SpecialLightR3Red = 29;
    ORD_SpecialLightR3White = 30;
    ORD_OpsDangerLightL = 31;
    ORD_OpsDangerLightLOff = 32;
    ORD_OpsDangerLightR = 33;
    ORD_OpsDangerLightROff = 34;

  ORD_LIOD_LR = 110; // ...
  ORD_LIOD_UD = 111;
  ORD_LIOD_Z = 112;
  ORD_LIOD_SBO = 113;
  ORD_LIOD_TSHOOT = 114; // liod shoot laser
  ORD_LIOD_TFOLLOW = 115; // liod follow target
  ORD_LIOD_LSR_FB = 116; // liod feed back laser
  ORD_LIOD_SHADER = 117; // ...

//  ORD_CANNON_LR               = 41;  // left-right
//  ORD_CANNON_UD               = 42;  // up-down
//  ORD_CANNON_F                = 43;  // meriam fire
//  ORD_ASROCK_ASSIGNED         = 101; // Asrock Assign
//  ORD_ASROCK_DEASSIGNED       = 102; // Asrock Deassign
 // ORD_ASROCK                  = 103; // Asrock Fire

  // effect perkenaan database
  ORD_DB_RQ = 210;    // request status
  ORD_DB_RQ_STF = 0;  // request status false
  ORD_DB_RQ_STT = 1;  // request status true
  ORD_DB_SHIP = 211;  // sending ship status ( prosentase di mValue )

  // Value sOrder :
  ORD_DB_STT = 220;   // sending status true
  ORD_DB_STF = 221;   // sending status false

  /// modul ID from sonar
  ORD_DB_ST = 1; // request status


// spActorController //REC_3D_SETCONTROL = 51;  -------------------------------

  /// actor runtime
  STATE_AR_CLEAR			= 1;
  STATE_AR_DEL  			= 2;
  STATE_AR_CREATE			= 3;

  ST_MISSILE_RUN			= 1;
  ST_MISSILE_HIT			= 2;
  ST_MISSILE_DEL			= 3;
  ST_MISSILE_LOADED   = 5;
  ST_MISSILE_UNLOCK   = 6;
  ST_MISSILE_LOCK     = 7;


  TIPE_AR_SHIP 			        = 1;
  TIPE_AR_SUBMARINE		      = 2;
  TIPE_AR_HELICOPTER		    = 3;
  TIPE_AR_AIRCRAFT          = 4;

  TIPE_AR_LAUNCHER = 11;
  TIPE_AR_MISSILE = 12;

  TIPE_MISC_OJK			  = 50;
    TIPE_MISC_MODEL_1	= 1;
    TIPE_MISC_MODEL_2	= 2;
    TIPE_MISC_MODEL_3	= 3;
  TIPE_MISC_OLL			  = 51;
    TIPE_MISC_MODEL_4	= 4;
    TIPE_MISC_MODEL_5	= 5;
    TIPE_MISC_MODEL_6	= 6;
    ORD_OJK_CLEAR			= 1;
    ORD_OJK_DEL				= 2;
    ORD_OJK_CREATE		= 3;
  TIPE_MISC_RANJAU		= 52;
    ORD_RANJAU_CLEAR  = 1;
    ORD_RANJAU_DEL		= 2;
    ORD_RANJAU_CREATE	= 3;
/// end constant actor runtime


/////////////////////////////////////////////////////////////////////////
  //REC_3D_UTIL_TOOLS = 53;  -------------------------------------------------------
  TIPE_UTIL_CAM_OBSERVER	= 1;
		ORD_UTIL_CAMOBS_UP	= 1;  // up
		ORD_UTIL_CAMOBS_FR	= 2;  // front
		ORD_UTIL_CAMOBS_BK	= 3;  // back
		ORD_UTIL_CAMOBS_LF	= 4;  // left
		ORD_UTIL_CAMOBS_RG	= 5;  // right

    //On Move
    ORD_UTIL_CAMOBS_MOVE_UP	= 11 ;
    ORD_UTIL_CAMOBS_MOVE_DW	= 12 ;
    ORD_UTIL_CAMOBS_MOVE_FR	= 13 ;
    ORD_UTIL_CAMOBS_MOVE_BK	= 14 ;
    ORD_UTIL_CAMOBS_MOVE_LF	= 15 ;
    ORD_UTIL_CAMOBS_MOVE_RG	= 16 ;

    ORD_UTIL_CAMOBS_ROT_UP	= 21 ;
    ORD_UTIL_CAMOBS_ROT_DW	= 22 ;
    ORD_UTIL_CAMOBS_ROT_LF	= 23 ;
    ORD_UTIL_CAMOBS_ROT_RG	= 24 ;

    //Off Move
    ORD_UTIL_CAMOBS_MOVE_UP_OFF	= 41 ;
    ORD_UTIL_CAMOBS_MOVE_DW_OFF	= 42 ;
    ORD_UTIL_CAMOBS_MOVE_FR_OFF	= 43 ;
    ORD_UTIL_CAMOBS_MOVE_BK_OFF	= 44 ;
    ORD_UTIL_CAMOBS_MOVE_LF_OFF	= 45 ;
    ORD_UTIL_CAMOBS_MOVE_RG_OFF	= 46 ;

    ORD_UTIL_CAMOBS_ROT_UP_OFF	= 51 ;
    ORD_UTIL_CAMOBS_ROT_DW_OFF	= 52 ;
    ORD_UTIL_CAMOBS_ROT_LF_OFF	= 53 ;
    ORD_UTIL_CAMOBS_ROT_RG_OFF	= 54 ;

    ORD_UTIL_CAMOBS_LOCK		= 31;  // lock
    ORD_UTIL_CAMOBS_ULOCK	  = 32;  // unlock

  TIPE_UTIL_PLAYER_SETTING   		    = 51;
    PLAYER_SET_BASE     		    = 0;
    SET_BASE_KEYBOARD    	      = 1;
    SET_BASE_KEY_ON             = 1;
    SET_BASE_UNLOCK  		        = 2;

    PLAYER_SET_OBSERVER         = 1;
	  SET_OBS_VHCFOCUS   		      = 1;

	  PLAYER_SET_ATTACH_SHIP  		= 2;
    PLAYER_SET_ATTACH_LAUNCHER	= 3;
	  PLAYER_SET_ATTACH_MISSILE	  = 4;
    PLAYER_SET_LOCK_OBJECT		  = 5;
    PLAYER_SET_FIRING_LOCK      = 6;

    PLAYER_SET_ATTACH_SHIP2  		= 10;
    PLAYER_SET_ATTACH_LAUNCHER2	= 11;
	  PLAYER_SET_ATTACH_MISSILE2  = 12;
    PLAYER_SET_LOCK_OBJECT2		  = 13;
    PLAYER_SET_FIRING_LOCK2     = 14;

      LOCK_SURFACE    = 1;
      LOCK_SUBSURFCE  = 2;
      LOCK_AIR        = 3;
      LOCK_WEAPON     = 4;

      LOCK_SIDE_DEFAULT	    = 0;
      LOCK_SIDE_LEFT		    = 1;
      LOCK_SIDE_RIGHT		    = 2;
      LOCK_SIDE_FRONT		    = 3;
      LOCK_SIDE_BACK		    = 4;
      LOCK_SIDE_TOP		      = 5;
      
  TIPE_UTIL_PLAYER_EVENT  			    = 52;
    IS_PLAYER_STOP_ALL    		  = 0;
	  IS_PLAYER_MOVE_OFF     		  = 1;
	  IS_PLAYER_MOVE_ON     		  = 2;
      MOVE_PLAYER_FORWARD   = 1;
      MOVE_PLAYER_BACK		  = 2;
      MOVE_PLAYER_LEFT		  = 3;
      MOVE_PLAYER_RIGHT	    = 4;
      MOVE_PLAYER_UP		    = 5;
      MOVE_PLAYER_DOWN 	    = 6;
	IS_PLAYER_ROTATE_OFF    		  = 3;
	IS_PLAYER_ROTATE_ON     		  = 4;
      ROTATE_PLAYER_UP		  = 1;
      ROTATE_PLAYER_DOWN	  = 2;
      ROTATE_PLAYER_LEFT	  = 3;
      ROTATE_PLAYER_RIGHT	  = 4;



  TIPE_UTIL_PAUSE_GAME    = 2; // BAWE-20110622: PAUSE_GAME
  // REC_3D_UTIL_TOOLS = 53; -------------------------------------------------------

  ORD_ENVI                        = 54;
  ORD_SEA_STATE                   = 56; // BAWE-20110503: ON_THE_FLY_OCEAN_CONTROL_2: SEA_STATE
  ORD_HUMIDITY                    = 57;
  ORD_BAROPRESSURE                = 58;
  ORD_TEMPERATURE                 = 59;
  ORD_CURSPEED                    = 60;
  ORD_WINDSPEED                   = 61;
  ORD_WINDDIRECTION               = 62;
  ORD_CURDIRECTION                = 63;

  //SENT CLIENT STATUS
  ORD_REFRESH_CLIENT              = 64;


  /// modul on game ( konstan ini harus sama dengan di database)
  C_DBID_ASROC                    = 1;
  C_DBID_RBU6000                  = 2;
  C_DBID_TORPEDO_A244S            = 3;
  C_DBID_TORPEDO_SUT              = 4;
  C_DBID_TETRAL                   = 5;
  C_DBID_YAKHONT                  = 6;
  C_DBID_C802                     = 7;
  C_DBID_MISTRAL                  = 8;
  C_DBID_STRELA                   = 9;
  C_DBID_EXOCET_MM40              = 10;
  C_DBID_EXOCET_MM38              = 11;
  C_DBID_CANNON40                 = 12;
  C_DBID_CANNON57                 = 13;
  C_DBID_CANNON76                 = 14;
  C_DBID_CANNON120                = 15;
  C_DBID_MOCCONSOLE               = 16;

  C_TIPEID_MISSILE = 1;
  C_TIPEID_ROCKET  = 2;
  C_TIPEID_CANNON  = 3;
  C_TIPEID_TORPEDO = 4;
  // modul on game -------------------------------------------------------------

  { constan order untuk client management ( REC_2D_ORDER :: TRecData2DOrder)}
  //REC_2D_ORDER= 54; ----------------------------------------------------------
  ///*****************************////
  _CM_CLIENT_MANAGE             = 1;
    __CM_CLIENT_CONNECT            = 1;
    __CM_CLIENT_DISCONNECT         = 2;
    __CM_CLIENT_WELCOME            = 3;
    __CM_CLIENT_RESTART            = 4;
    __CM_CLIENT_SHUTDOWN           = 5;
    __CM_CLIENT_RESET              = 6;
    __CM_CLIENT_REQDB_ADDR         = 7;
    __CM_CLIENT_SETDB_ADDR         = 8;
    __CM_CLIENT_REQ3D_ADDR         = 9;
    __CM_CLIENT_SET3D_ADDR         = 10;
    __CM_CLIENT_CLOSE_LAUNCHER     = 11;
    __CM_CLIENT_REQ_SIM_TIME       = 12;
    __CM_CLIENT_SET_SIM_TIME       = 13;
    __CM_CLIENT_RESTART_ALL        = 14;
    __CM_CLIENT_SHUTDOWN_ALL       = 15;
    __CM_CLIENT_RESTARTALLCOMM     = 16;
    __CM_CLIENT_SHUTDOWNALLCOM     = 17;
    __CM_CLIENT_RESTARTSERVERCOMM  = 18;
    __CM_CLIENT_SHUTDOWNSERVERCOMM = 19;
    __CM_CLIENT_CLOSEALLCOM        = 20;
  _CM_CLIENT_APP                = 2;
    __CM_CLIENT_LAUNCH             = 1;
    __CM_CLIENT_STOP               = 2;
    __CM_CLIENT_RELAUNCH           = 3;
    __CM_CLIENT_LAUNCHALL          = 4;
    __CM_CLIENT_STATUS             = 5;
  _CM_CLIENT_CHECK              = 3;
  _CM_CLIENT_CHECKSCENARIOID    = 4;
  _CM_CLIENT_CONNECT            = 5;
    __CM_CLIENT_INST               = 1;
    __CM_CLIENT_CONSOLE            = 2;
    __CM_CLIENT_LAUNCHER           = 3;
  _CM_REQ_SYNCPACKET            = 6;

  ///*****************************////


  /// modul on game ( konstan ini harus sama dengan di database)
  ORD_ANJUNGAN_MESINON_OF         = 1 ;
  ORD_ANJUNGAN_THROTTLEKIRI       = 2 ;
  ORD_ANJUNGAN_THROTTLEKANAN      = 3 ;
  ORD_ANJUNGAN_RUDDER             = 4 ;
  ORD_ANJUNGAN_INDIKATOR          = 5 ;
  ORD_RADARNAVIGASI_MESINON_OF    = 6 ;

  ORD_RADARDA05_MESINON_OF        = 7 ;
  ORD_RADARGM28_MESINON_OF        = 8 ;

  ORD_SONAR_HULL_MESINON_OF       = 9 ;
  ORD_SONAR_TOWED_MESINON_OF      = 10;

  ORD_TDC_MESINON_OF              = 11;
  ORD_TDC_RADAR                   = 12;
  ORD_TDC_PERSENJATAAN            = 13;

  ORD_WCC_MESINON_OF              = 14;
  ORD_WCC_RADAR                   = 15;
  ORD_WCC_PERSENJATAAN            = 16;

  ORD_OCC_MESINON_OF              = 17;
  ORD_LIOD_MESINON_OF             = 18;
  ORD_PERISKOPNAVIGASI_MESINON_OF = 19;
  ORD_PERISKOPSERANG_MESINON_OF   = 20;

  ORD_CANNON1_ON_OF               = 21;
  ORD_CANNON2_ON_OF               = 22;
  ORD_CANNON3_ON_OF               = 23;
  ORD_CANNON4_ON_OF               = 24;

  ORD_TORPEDO1_ON_OF              = 25;
  ORD_TORPEDO2_ON_OF              = 26;
  ORD_TORPEDO3_ON_OF              = 27;
  ORD_TORPEDO4_ON_OF              = 28;
  ORD_TORPEDO5_ON_OF              = 29;
  ORD_TORPEDO6_ON_OF              = 30;
  ORD_TORPEDO7_ON_OF              = 31;
  ORD_TORPEDO8_ON_OF              = 32;
  ORD_EXOCET1_ON_OF               = 33;
  ORD_EXOCET2_ON_OF               = 34;
  ORD_EXOCET3_ON_OF               = 35;
  ORD_EXOCET4_ON_OF               = 36;
  ORD_CHAFF1_ON_OF                = 37;
  ORD_CHAFF2_ON_OF                = 38;
  ORD_CHAFF3_ON_OF                = 39;
  ORD_CHAFF4_ON_OF                = 40;
  ORD_ASROCK1_ON_OF               = 41;
  ORD_ASROCK2_ON_OF               = 42;
  ORD_ASROCK3_ON_OF               = 43;
  ORD_ASROCK4_ON_OF               = 44;

  ORD_3D_TORPEDO_MK44_FIRED       = 36;

  //REC_3D_UTIL_TOOLS = 53;
    ORD_SET_LONGLAT = 0;
    ORD_SET_WAKTU = 1;
    ORD_SET_WEATHER	= 2;
      ORD_W_THEME_CLEAR = 0;
      ORD_W_THEME_FAIR = 1;
      ORD_W_THEME_FOGGY	= 2;
      ORD_W_THEME_RAINY	= 3;
    ORD_SET_SEASON = 3;
      ORD_SEASON_SPRING	= 0;
      ORD_SEASON_FALL	= 1;
      ORD_SEASON_WINTER	= 2;
      ORD_SEASON_SUMMER	= 3;
    ORD_SET_WIND = 4;
      ORD_WIND_NONE = 0;
      ORD_WIND_BREEZE = 1;
      ORD_WIND_LIGHT = 2;
      ORD_WIND_MODERATE	= 3;
      ORD_WIND_HEAVY = 4;
      ORD_WIND_SEVERE	= 5;
    ORD_SET_TIME_PERIODE = 5;
      ORD_TIME_DAWN = 0;
      ORD_TIME_DAY = 1;
      ORD_TIME_DUSK = 2;
      ORD_TIME_NIGHT = 3;
    ORD_SET_CLOUD			= 6;
      ORD_CLOUD_CLEAR		= 0;
      ORD_CLOUD_FEW		= 1;
      ORD_CLOUD_SCATTERED	= 2;
      ORD_CLOUD_BROKEN		= 3;
      ORD_CLOUD_OVERCAST	= 4;


type
  OrdType_ICM = (icm1, icm2, icm3);
  OrdType_datum_number = (datum_number1, datum_number2, datum_number3, datum_number4, datum_number5);
  OrdType_torpedo = (MK44, A244);
  OrdType_wipe = (kiri_1, kiri_2, kanan_1, kanan_2);

  TOrdType_FC_number = (FC1, FC2, FC3, FC4, FC5);

  TOrdType_FC_command = (STO, SBS, ATO, SBA, RATO, RSTO,
    break_track, open_fire, hold_fire,
    GenFix, BlindBomb, IndirectBomb,
    InitTrackSurf, AssignTrackSs
  );

  TOrdType_OWA_command = (InitAir, InitSurf, InitSubRT, InitSubNRT,
        AssLocRT, AssLocNRT, AssRemote, ReposTrack, CorrectTrack);

 //TOrdType_OWA_command = (InitAir, InitSurf, InitSub, AssLocRT, AssLocNRT);

  OrdType_GunNumber   = (Gun1, Gun2, Gun3);
  OrdType_BulletType1 = (PARPROX, IMPACT);
  OrdType_BulletType2 = (HE_TRACER, PRE_FRAG);
  OrdType_FireMode    = (SINGLE_FIRE, BURST_FIRE);
  OrdType_ControlMode = (LOCAL, REMOTE);

  //yutyutyu

implementation

end.
