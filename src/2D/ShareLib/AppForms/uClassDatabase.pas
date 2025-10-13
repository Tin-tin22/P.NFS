unit uClassDatabase;

interface

uses
  Classes;

type
  TVehicle = class
    { For Detail Ship}
    Vehicle_ID       : Integer;
    Vehicle_Name     : string;
    Vehicle_Ctgr     : Integer;
    Vehicle_No       : Integer;
    Vehicle_Maxspeed : Double;
    Vehicle_Minspeed : Double;
    Vehicle_Type     : Integer;
    Vehicle_Target   : Integer;

    Vehicle_X        : Double;
    Vehicle_Y        : Double;
    Vehicle_Z        : Double;
    Vehicle_Heading  : single;
    Vehicle_Speed    : single;
    Vehicle_Pitch    : single;
    Vehicle_Roll     : single;
    Vehicle_Rudder   : single;

    Vehicle_LENGTH          : Double;
    Vehicle_WIDTH           : Double;
    Vehicle_HEIGHT          : Double;
    Vehicle_SUSTAINABILITY  : Double;

    Vehicle_RudderSwingRate  : Double;
    Vehicle_ThrottleRate     : Double;
    Vehicle_Displacement     : Double;
    Vehicle_HeelFactor       : Double;
    Vehicle_ShaftUp          : Double;
    Vehicle_TacDiameter      : Double;
    Vehicle_TrimFactor       : Double;

    { For Scenario Editor }
    Vehicle_Console  : Integer;
  end;

  tDataWeapon = class
     IDSCENE :  integer ;
     IDSHIP :  integer ;
     IDWEAPON : integer ;
     NAMA : string;
     IDDET : integer ;
     ST : string;
  end;

  TWeapon = class
    ParentName,
    MissileName,
    MissileUID   : string;

    shipID        : word;
    WeaponID      : word;
    launcherID    : word;
    missileID     : word;
    MissileNumber : word;

    status: byte;
    x, y, z: double;
    heading: single;
    speed: single;
  end;

  TScenario = class
    Scenario_ID   : integer;
    Scenario_Name : string;
    Scenario_Port : Integer;
    Scenario_Building   : integer;
    Scenario_StaticShip : integer;
    Scenario_Buoy   : integer;
    Scenario_Tree   : Integer;
    Scenario_Theme  : integer;
    Scenario_Desc   : string;

    { Environment }
    Scenario_WindScale,
    Scenario_WindSpeed,
    Scenario_WindDir_X,
    Scenario_WindDir_Y,
    Scenario_WindDir_Deg,

    Scenario_CurrSpeed,
    Scenario_CurrDir_X,
    Scenario_CurrDir_Y,
    Scenario_CurrDir_Deg,

    Scenario_SeaState,
    Scenario_Temperature,
    Scenario_BaroPressure,
    Scenario_Humidity,
    Scenario_FogHeight,
    Scenario_FogHeight_Persen : Double;
  end;

  TClient = class
    C_ID : Integer;
    C_Ship, 
    C_Cubicle,
    C_Console,
    C_Type,
    C_Ip,
    C_Status : string;

    C_WeaponID : integer;

  end;

  TClientList = class
    Id  : integer;

    
    Cli_Cubicle,
    Cli_Console,
    Cli_Type,
    Cli_IP,

    Cli_Status : string;

    Cli_SHIP : string;

    Cli_SHIPID,
    Cli_LAUNCHERID,
    WeaponID : integer;
  end;

  TPort = class
    Port_ID       : Integer;
    Port_Name     : string;
    Port_XOffset  : Double;
    Port_YOffset  : Double;
  end;

  TConsole = class
    ShipID     : Integer;
    ConsoleID  : Integer;
    LauncherID : integer;
  end;

  TWeaponGetList = class
    ID,
    IDShip,
    IDWeapon,
    IDDetail,
    IDModel1,
    IDModel2,
    IDDof1,
    IDDof2,
    IDSwitch,
    Pos_H,
    Pos_P,
    STARTANGLE,
    ENDANGLE,
    Is3DActor : Integer;
  end;

  TWeaponDetail = class
    IDShip     : Integer;
    IDWeapon   : Integer;
    IDLauncher : Integer;
    IDType     : Integer;
    DetName    : String;

    StartAngle : Double;
    EndAngle   : Double;
    HighRange  : Double;
    LowRange   : Double;
  end;

  TShipWeapon = class
    Weapon_ID : Integer;
    Weapon_Name : string;
    Weapon_Type : integer;
    Weapon_Lethality : integer;
  end;

  TTypeWeapon = class
    Weapon_ID : Integer;
    Weapon_Name : string;
  end;

  TScenarioList = class
    Scenario_ID : Integer;
    Scenario_Name : string;
    Scenario_Port : Integer;
    Scenario_KET  : string;
    XOFFSET     : Double;
    YOFFSET     : Double;
    ENV_PETA    : Double;
  end;

  TSaveShipWeapon = class
    Ship_ID     : Integer;
    Weapon_ID   : Integer;
    Weapon_LauncherID : integer;
  end;

  TClientConsole = class
    ID        : Integer;
    PC_IP     : string[20];
    PC_ID     : Integer;
    PC_IDM    : Integer;
    PC_NAME   : string[20];
    APP_TIPE  : Integer;
    APP_NAME  : string[20];
    APP_PARAM : string[255];
    WeaponID  : Integer;
    PC_MAC    : string[20];
    APP_NAME_2: string[20];
  end;

  TSaveConsole = class
    ShipID     : Integer;
    ConsoleID  : Integer;
    LauncherID : Integer;
  end;

  TEnviScenario = class
    ENV_BUILDING : integer;
    ENV_SSHIP    : Integer;
    ENV_BUOY     : Integer;
    ENV_THEME    : Integer;
  end;

  TScenarioWeapon = class
    ShipID : Integer;
    WeaponName : string;
    WeaponID   : Integer;
    LauncherID : integer;
    EnableWeapon : Boolean;
  end;

  TDof = class
    ID : Integer;
    Nama : string;
  end;

  TSwitch = class
    ID : Integer;
    Nama : string;
  end;

  TModel = class
    ID : Integer;
    REFF : Integer;
    TIPE : Integer;
    Nama : string;
    Ext  : string;
  end;

  TMissile = class
    ID,
    IDM,
    IDMissile,
    IDModel,
    IDDof,
    Pos_H,
    Pos_P,
    HasLauncher : integer;
  end;

  TLogEvent = class
    ScenarioID,
    GameID,
    ConsoleID,
    EventID,
    ShipID    : Integer;
    Param1,
    Param2,
    param3    : double;
    tanggal,
    NameGame,
    jam       : string;

  end;

  TGameList = class
   GameName   : string;
   aScenName  : string;
   aTanggal   : string;
  end;

  TSearchScenarioIDList = class
   IDSce : Integer;
  end;

  TSceConList = class
    ShipID      : Integer;
    ShipConsole : Integer;
    ShipLaunch  : Integer;
  end;

  TRangDeg = class
    rangeMin    : Double;
    rangeMax    : Double;
    startDeg    : Double;
    endDeg      : Double;
  end;


implementation

end.
