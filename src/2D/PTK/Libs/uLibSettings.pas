unit uLibSettings;

interface

uses
  Graphics, uCodecBase64,
  //connect NFS:
  uBridgeSet, Windows;

const
  C_DB_HOST     = '192.168.1.124';
  C_DB_PORT     = '3306';
  C_DB_PROTO    = 'mysql';
  C_DB_NAME     = 'tcms';
  C_DB_USER     = 'root';
  C_DB_PASS     = 'tcms';
  C_SVR_IP      = '192.168.1.124';
  C_MAP_PATH    = '.\tcms_map\tcms_world.gst';
  C_MAP_BGCOLOR =  $007A7070;
  C_MAP_CMS_BGCOLOR = $687760;
  C_MAP_ZOOM    = 128;
  C_MAP_LONG    = 112.722778;
  C_MAP_LATT    = -7.198333;

type

  TMonitorSetting = record
    Primary: Integer; // Set primary monitor index position at identify by windows
    ReadOutTop : Integer;
    WorksetTop : Integer;
  end;


  TComPortSetting = record
    Port : string;
    Enable : Byte;
    Reverse : Byte;
    PDKEnable : Byte;
  end;

  TMapSetting = record
    MapGeoset: string;
    MapDataGeoset: string;
    MapDataENCGeoset: string;
    MapZoom: integer;
    mX, mY: double;
    MapColor : TColor;
    MapGeosetNoRole: string;
  end;

  TDBaseSetting  = record
    dbServer,
    dbPort,
    dbProto,
    dbName,
    dbUser,
    dbPass: string
  end;

  TTcmsNetwork = record
    GamePort      : Integer;
    LauncherPort  : Integer;
    BCAddress     : string;
    SessionID     : Integer;
    Leader        : Boolean;
    MOCName       : Byte;
  end;

  TTcmsSnapshot = record
    MOCName   : Integer;
    ImageName : string;
    ImagePath : string;
  end;

  TARPAStatus = record
    status : Integer;
  end;

  TSonarStatus = record
    status : integer;
  end;

  TRecConsoleIdent = record
    ConsoleName : string;
    CubicleID : integer;
    TrainerMode : Boolean;
    CubicleCount : Integer;
  end;

  TSPSMode = record
    TipeProject : Integer;
    MonitorID : Integer;
    MonTop : Integer;
    MonLeft : Integer;
  end;

  TPasswordStatus = record
    status : Integer;
  end;

  TProjectType = record
    ProjectType : integer;
  end;

  TRec76mmSetting = record
    CorrectionMode : Byte;
    TrainEnable : Byte;
  end;

  TRecTetralSetting = record
    TimeToLaunch : Double;
  end;

  TRecLirodSetting = record
    TrainingSpeed : Double;
    ElevationSpeed : Double;
    VideoNum : string;
    VideoType : string;
    AttachTo : string;
    OffsetX,
    OffsetY  : string;
    Narrow : Integer;
    Wide : Integer;
    DepthOfView : Double;
    IsCameraOn : string;
    AirStep : Double;
    PlayerHeight : Integer;
    FOV : Integer;
    MonitorIndex: Integer;
  end;

  TRecThemeSetting = record
    ColorNum : Integer;
  end;


  function getFileSetting: string;

  procedure LoadMonitorSetting;
  procedure LoadMapSetting;

  procedure LoadDBSetting;
  procedure SaveDBSetting;

  procedure LoadTCMSNetwork;

  procedure LoadNFSBridgeSet;

  procedure LoadSonarStatus;
  procedure LoadARPAStatus;
  procedure LoadSPSMode;
  procedure LoadTCMSSnapshot;
  procedure LoadTCMSIdent;
  procedure LoadPasswordStatus;

  procedure LoadComportSetting;
  procedure LoadProjectSetting;

  { TCMS theme }
  procedure LoadThemeSetting;


var
  VTetralSetting : TRecTetralSetting;
  V76mmSetting : TRec76mmSetting;
  VMonitSetting : TMonitorSetting;
  VComPortSetting : TComPortSetting;
  VMapSetting : TMapSetting;
  VDBSetting  : TDBaseSetting;
  VTcmsNetwork : TTcmsNetwork;
  VTcmsSnapshot : TTcmsSnapshot;

  VNFSBridgeSet : TRecBridgeSet;

  VARPAStatus : TARPAStatus;
  VSonarStatus : TSonarStatus;
  VSPSType : TSPSMode;
  VConsoleIdent : TRecConsoleIdent;
  VPASSStatus : TPasswordStatus;
  VProjectType : TProjectType;
  VLirodSetting : TRecLirodSetting;

  VThemeSetting : TRecThemeSetting;

implementation

uses
  IniFiles, SysUtils, uIniFilesProcs;

function getFileSetting: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'tcmss.ini';
end;

procedure LoadSonarStatus;
var
  iniF: TIniFile;
  f : string ;
begin
  f := getFileSetting;
  iniF := TIniFile.Create(f);

  try
    with VSonarStatus do begin
      status := INIFReadInteger(iniF, 'Sonar', 'status', 0);
    end;
  finally
    iniF.Free;
  end;

end;

procedure LoadMonitorSetting;
var
  inif : TIniFile;
begin
  inif := TIniFile.Create(getFileSetting);
  try
    with VMonitSetting do
    begin
      Primary := INIFReadInteger(inif, 'Monitor','Primary',1);
//      ReadOutTop := INIFReadInteger(inif, 'Monitor','ReadOutTop',1540);
//      WorksetTop := INIFReadInteger(inif, 'Monitor','WorksetTop',1540);
    end;

    with VLirodSetting do
    begin
      TrainingSpeed := INIFReadFloat(inif, 'LIROD', 'TrainingSpeed', 0.5);
      ElevationSpeed := INIFReadFloat(inif, 'LIROD', 'ElevationSpeed', 0.5);

      VideoNum := INIFReadString(inif,'LIROD', 'VideoNum', '1');
      VideoType := INIFReadString(inif,'LIROD', 'VideoType', '1');
      AttachTo := INIFReadString(inif,'LIROD', 'AttachTo', '1');
      OffsetX := INIFReadString(inif,'LIROD', 'OffsetX', '112.7');
      OffsetY := INIFReadString(inif,'LIROD', 'OffsetY', '-7.0');
      Narrow := INIFReadInteger(inif, 'LIROD', 'Narrow', 120);
      Wide := INIFReadInteger(inif, 'LIROD', 'Wide', 600);
      DepthOfView := INIFReadFloat(inif, 'LIROD', 'DepthOfView', 3500); // Meter
      AirStep := INIFReadFloat(inif, 'LIROD', 'AirStep', 1); // Degree
      PlayerHeight := INIFReadInteger(inif, 'LIROD', 'PlayerHeight', 15);


    end;
  finally
    inif.Free;
  end;
end;

procedure LoadProjectSetting;
var
  inif : TIniFile;
begin
  inif := TIniFile.Create(getFileSetting);
  try
    with VProjectType do
    begin
      ProjectType := INIFReadInteger(inif, 'Project','ProjectType',1);
    end;

    with V76mmSetting do
    begin
      CorrectionMode := INIFReadInteger(inif, 'Gun76mm','CorrectionMode',0);
      TrainEnable := INIFReadInteger(inif, 'Gun76mm','TrainEnable',0);
    end;

    with VTetralSetting do
    begin
      TimeToLaunch := INIFReadFloat(inif, 'Tetral','TimeToLaunch', 2);
    end;
  finally
    inif.Free;
  end;
end;

procedure LoadComportSetting;
var
  inif : TIniFile;
begin
  inif := TIniFile.Create(getFileSetting);
  try
    with VComPortSetting do
    begin
      Port := INIFReadString(inif, 'Port','Name','COM1');
      Enable := INIFReadInteger(inif, 'Port', 'Enable', 1);
      Reverse := INIFReadInteger(inif, 'Port', 'Reverse', 0);
      PDKEnable := INIFReadInteger(inif, 'Port', 'PdkEnable', 0);
    end;
  finally
    inif.Free;
  end;
end;


procedure LoadThemeSetting;
var
  inif : TIniFile;
begin
  iniF := TIniFile.Create(getFileSetting);

  try
    with VThemeSetting do begin
      ColorNum  := INIFReadInteger(inif,'Theme', 'ColorNum', 1);
    end;
  finally
    iniF.Free;

  end;
end;


procedure LoadTCMSIdent;
var
  inif : TIniFile;
begin
  try
    inif := TIniFile.Create(getFileSetting);

    VConsoleIdent.ConsoleName := INIFReadString(inif,'ident', 'ConsoleName', 'Not Identified');
    VConsoleIdent.CubicleID := INIFReadInteger(inif, 'ident', 'CubicleID', 0);
    VConsoleIdent.TrainerMode := INIFReadBool(inif, 'ident', 'Trainer', True);
    VConsoleIdent.CubicleCount := INIFReadInteger(inif, 'ident', 'CubicleCount', 4);
  finally

    inif.Free;
  end;
end;

procedure LoadMapSetting;
var
  inif : TIniFile;
begin
  inif := TIniFile.Create(getFileSetting);
  try
    with VMapSetting do
    begin
      MapGeoset       := INIFReadString(inif, 'Map','geoset',C_MAP_PATH);
      MapGeosetNoRole := INIFReadString(inif, 'Map', 'geosetnorole', C_MAP_PATH);
      MapDataENCGeoset:= INIFReadString(inif, 'Map', 'geosetEnc', C_MAP_PATH);
      mX              := INIFReadFloat(inif, 'Map','long',C_MAP_LONG);
      mY              := INIFReadFloat(inif, 'Map','latt',C_MAP_LATT);
      MapColor        := INIFReadInteger(inif, 'Map','MapColor', C_MAP_BGCOLOR); // C_MAP_CMS_BGCOLOR;          //RGB(160, 224, 255);                ini
      MapZoom         := INIFReadInteger(inif, 'Map','zoom', C_MAP_ZOOM);
    end;
  finally
    inif.Free;
  end;
end;

procedure LoadSPSMode;
var
  inif : TIniFile;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'SPS115.ini') then
  begin
    inif := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'SPS115.ini');
    try
      with VSPSType do
      begin
        TipeProject := INIFReadInteger(inif, 'SPS','Status',0);
        MonitorID := INIFReadInteger(inif,'SPS', 'monitorID', 0);
        MonTop := INIFReadInteger(inif,'SPS','monTop',0);
        MonLeft := INIFReadInteger(inif,'SPS','monLeft',0);
      end;
    finally
      inif.Free;
    end;
  end
  else
  begin
    with VSPSType do
    begin
      TipeProject := 0;
      MonitorID := 0;
      MonTop := 0;
      MonLeft := 0 ;
    end;
  end;
end;

procedure LoadDBSetting;
var IniF: TIniFile;
    readIn, readOut : string;
begin
  IniF := TIniFile.Create(getFileSetting);

  with VDBSetting do begin
    dbServer :=  IniFReadstring(inif, 'Database', 'dbserver', '192.168.1.124');
    dbPort   :=  INIFReadString(IniF, 'Database', 'dbport', C_DB_PORT);
    dbProto  :=  IniFReadstring(inif, 'Database', 'dbproto', C_DB_PROTO );
    dbName   :=  IniFReadstring(inif, 'Database', 'dbname',  C_DB_NAME);

    readIn    := Base64Encode(C_DB_USER);
    readOut   := IniFReadstring(inif, 'Database', 'dbuser', readIn);
    dbUser    := Base64Decode(readOut);

    readIn    := Base64Encode(C_DB_PASS);
    readOut   := IniFReadstring(inif, 'Database', 'dbpass', readIn);
    dbPass    := Base64Decode(readOut);
  end;
end;

procedure SaveDBSetting;
var  iniF: TIniFile;
begin
  IniF := TIniFile.Create(getFileSetting);

  with iniF, VDBSetting do begin
    WriteString('Database', 'dbserver', dbServer);
    WriteString('Database', 'dbproto',  dbProto );
    WriteString('Database', 'dbname',   dbName);
    WriteString('Database', 'dbuser',   Base64Encode(dbUser));
    WriteString('Database', 'dbpass',   Base64Encode(dbPass));
  end;
  inif.Free;

end;

procedure LoadTCMSNetwork;
var
  iniF: TIniFile;
begin
  iniF := TIniFile.Create(getFileSetting);

  try
    with VTcmsNetwork do begin
      SessionID     := INIFReadInteger(iniF, 'Network', 'SessionID', 1111);
      GamePort      := INIFReadInteger(iniF, 'Network', 'GamePort', 9876);
      BCAddress     := INIFReadString(iniF, 'Network', 'BroadCastAddress', '192.168.1.255');
      Leader        := INIFReadBool(iniF, 'Network', 'Leader', False);
      LauncherPort  := INIFReadInteger(iniF, 'Network', 'LauncherPort', 8888);
      MOCName       := INIFReadInteger(iniF, 'Network', 'MOCName', 1)
    end;
  finally
    iniF.Free;
  end;
end;

procedure LoadTCMSSnapshot;
var
  iniF: TIniFile;
begin
  iniF := TIniFile.Create(getFileSetting);
  try
    with VTcmsSnapshot do begin
      MOCName   := INIFReadInteger(iniF, 'Snapshot', 'MOCName', 1);
      ImageName := INIFReadString(iniF, 'Snapshot', 'ImageName', 'MOC1_Image1');
      ImagePath := INIFReadString(iniF, 'Snapshot', 'ImagePath', 'Z:\Image\');

    end;
  finally
    iniF.Free;
  end;

end;

procedure LoadNFSBridgeSet;
var IniF: TIniFile;
   bsFile : string;
begin
  bsFile := ExtractFilePath(ParamStr(0)) + 'bridgeset.ini';
  IniF := TIniFile.Create(bsFile);

  with VNFSBridgeSet.mServer do begin
    uBridgeSet.InitDefault_GameServerConfig( bsFile,
    m2D_IP,  m2D_Port,
    m3D_IP,  m3D_Port );
  end;

  with VNFSBridgeSet.mDB do begin
    uBridgeSet.InitDefault_DBConfig( bsFile,
    mDBServer,
    mDBProto,
    mDBName,
    mDBUser,
    mDBPass);
  end;

  with VNFSBridgeSet.mShip do begin
    uBridgeSet.InitDefault_ShipConfig( bsFile,
    mShipID,
    mClassID,
    mShipName,
    mClassName);
  end;
end;

procedure LoadARPAStatus;
var
  iniF: TIniFile;
begin
  iniF := TIniFile.Create(getFileSetting);

  try
    with VARPAStatus do begin
      status := INIFReadInteger(iniF, 'ARPA', 'status', 0);
    end;
  finally
    iniF.Free;
  end;
end;

procedure LoadPasswordStatus;
var
  iniF: TIniFile;
begin
  iniF := TIniFile.Create(getFileSetting);
  try
    VPASSStatus.status := INIFReadInteger(iniF, 'Password', 'PasswordOn', 1);
  finally
    iniF.Free;
  end;

end;
end.
