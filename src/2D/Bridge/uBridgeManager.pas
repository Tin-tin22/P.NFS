unit uBridgeManager;

interface

uses
  Forms, Classes, Math,

  uTCPServer, uTCPClient, overbyteicsWSocketS,
  ExtCtrls, uBridgeSet, OverbyteIcsWsocket, logger, IniFiles,
  uPacketBuffer;

const
  SockStateS: array[TSocketState] of string
  = (' InvalidState',
    ' Opened', ' Bound',
    ' Connecting', 'SocksConnected', ' Connected',
    ' Accepting', ' Listening',
    ' Closed', 'DnsLookup');

type
  TOnLogPnlClient3D     = procedure ( str : string ) of object;
  TOnLogSever2D         = procedure ( str : string ) of object;
  TOnLogClient3D        = procedure ( str : string ) of object;
  TOnLogpacket          = procedure ( str : string ) of object;
  TOnLogSettingSocket   = procedure ( m2D_IP, m2D_Port, m3D_IP, m3D_Port : string ) of object;
  TOnLogSettingDB       = procedure ( mDBServer, mDBProto, mDBName, mDBUser, mDBPass, mDBPort : string) of object;

  TBridgeManager = class
  private
    FPacketBuff : TPacketBuffer;

    //LoadSetting
    bridgeSet     :  TRecBridgeSet;
    bridgeSetPath : string;

    //For Connect to Server 3D
    //Use Timer For always check Server Because There is no Form
    TimerConnect : TTimer;
    procedure OnTimerConnectRun(sender : TObject);

    //Event Disconnect Server For Triggering Timer To Connect
    procedure OnClientState(Sender: TObject; OldState, NewState: TSocketState);

    //Event Connect & Disconnect From Client
    procedure OnClientTCPConnect(cmd : string);
    procedure OnClientTCPDisconnect(cmd : string);
    procedure checkOnOffMode;

  public
    TcpClient : TTCPClient;
    TcpServer : TTCPServer;

    IpServer3D,
    PortServer3D,
    Ip2D,
    Port2D : string;

    DBServer,
    DBProto,
    DBName,
    DBUser,
    DBPass,
    DBPort : string;

    GameStatus     : Integer; // 0 : Stop, 1 : Play
    LastScenarioID : integer;

    //Event handler
    OnLogPnlClient      : TOnLogPnlClient3D;
    OnLogServer2D       : TOnLogSever2D;
    OnLogClient3D       : TOnLogClient3D;
    OnLogPacket         : TOnLogpacket;

    OnlogSettingDB      : TOnLogSettingDB;
    OnLogSettingSocket  : TOnLogSettingSocket;

    //Log
    LogFile             : TLogFile;

    constructor Create;
    destructor Destroy;

    function GetClientOfServer(ip : string): TWSocketClient;

    procedure Prepare_As_Server2D;
    procedure Prepare_As_Client3D;
    procedure ConnectTo3DServer;
    procedure ListenServer2D;

    procedure InitSimulation;
    procedure RunSimulation;
    procedure PrepareStopSimulation;
    procedure StopSimulation;

    procedure ServerReceive_ClientSend(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure ServerReceive_ServerSend(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure ServerReceive_ClientManagement(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure ServerReceive_ServerClientSend(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);

    procedure ClientRecv_3D_ShipPos(apRec: PAnsiChar; aSize: integer);
    procedure ClientRecv_3D_MissilePos(apRec: PAnsiChar; aSize: integer);
    procedure ClientRecv_3D_Order(apRec: PAnsiChar; aSize: integer);

    procedure ClientReceive_ServerSend(apRec: PAnsiChar; aSize: integer);
  end;

var
  BridgeManager : TBridgeManager;

implementation

uses
  uTCPDatatype, SysUtils, Windows;

procedure TBridgeManager.ConnectTo3DServer;
begin
  TimerConnect.Enabled := True;
end;

constructor TBridgeManager.Create;
begin
  FPacketBuff := TPacketBuffer.Create;

  TcpClient := TTCPClient.Create;
  TcpClient.Socket.OnChangeState := OnClientState;

  TcpServer := TTCPServer.Create;
  TcpServer.OnClientConnect     := OnClientTCPConnect;
  TcpServer.OnClientDisConnect  := OnClientTCPDisconnect;

  TimerConnect := TTimer.Create(nil);
  TimerConnect.Enabled  := False;
  TimerConnect.Interval := 10000;
  TimerConnect.OnTimer  := OnTimerConnectRun;

  //First Initialize, Next Read From IniFIle
  IpServer3D    := '127.0.0.1';
  PortServer3D  := '7777';
  Ip2D          := '127.0.0.1';
  Port2D        := '6666';

  //Log File
  LogFile           := TLogFile.Create;
  LogFile.FileName  := ChangeFileExt(Application.ExeName,'.log');
  LogFile.IsLog     := True;
  LogFile.Init;

  //Save CurrentLastScenarioID and Status Game
  LastScenarioID  := 1;
  GameStatus      := 0;
end;

destructor TBridgeManager.Destroy;
begin
  TcpClient.Free;
  TcpServer.Free;

  TimerConnect.Free;
  FPacketBuff.Free;
end;

function TBridgeManager.GetClientOfServer(ip: string): TWSocketClient;
var
  i : integer;
  Client : TWSocketClient;
begin
  Result := nil;

  for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
  begin
    Client := TcpServer.WSocketServer.Client[i];
    if Client.GetPeerAddr = ip then
    begin
      Result := Client;
      break;
    end;
  end;
end;

procedure TBridgeManager.checkOnOffMode;
var
  readPath  : string;
  helpIni   : TIniFile;
  onOffMode : Integer;
begin
  helpIni   := TIniFile.Create('..\bin\BridgeSet.ini');

  readPath  := helpIni.ReadString('OnOff', 'mode','Default');
  onOffMode := StrToInt(readPath);

  if onOffMode = 0 then begin
    readPath       := helpIni.ReadString('OnOff', 'scenarioID','Default');
    LastScenarioID := StrToInt(readPath);
  end;

  helpIni.Free;
end;

procedure TBridgeManager.InitSimulation;
begin
  bridgeSetPath := GetSettingDirectory;

//  with bridgeSet.mDB do
//  begin
    InitDefault_DBConfig(bridgeSetPath, DBServer, DBProto, DBName, DBUser, DBPass, DBPort  );
//  end;

  with bridgeSet.mServer do begin
    InitDefault_GameServerConfig(bridgeSetPath, Ip2D, Port2D, IpServer3D, PortServer3D);
  end;

  if Assigned(OnlogSettingDB) then
    OnlogSettingDB( DBServer, DBProto, DBName, DBUser, DBPass, DBPort );

  if Assigned(OnLogSettingSocket) then
    OnLogSettingSocket(Ip2D, Port2D, IpServer3D, PortServer3D);
  //yoga ganteng bro
  checkOnOffMode;

  Prepare_As_Server2D;
  Prepare_As_Client3D;
end;

procedure TBridgeManager.ListenServer2D;
begin
  TcpServer.Listen(Port2D);
end;

procedure TBridgeManager.OnClientState(Sender: TObject; OldState,
  NewState: TSocketState);
var
  RecSend : TRecData2DOrder;
begin
  if Assigned(OnLogPnlClient) then
      OnLogPnlClient(SockStateS[NewState]);

  if Assigned(OnLogServer2D) then
        OnLogServer2D(SockStateS[OldState] + ' => ' + SockStateS[NewState]);

  if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
    TimerConnect.Enabled := True;

    RecSend.orderID   := _CM_CLIENT_APP;
    RecSend.numValue  := __CM_CLIENT_STATUS;
    RecSend.strValue  := SockStateS[NewState];
//    RecSend.strValue2 := '';
//    RecSend.strValue3 := '';
//    RecSend.ipConsole := '';
//
    TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);

    if Assigned(OnLogServer2D) then
      OnLogServer2D('Disconnect from 3D server, try connecting...');

    //if Disconnect from 3D Server, --> Status Stop.
    GameStatus := 0;
    FPacketBuff.Clear;
  end;
end;

procedure TBridgeManager.OnClientTCPConnect(cmd: string);
var
  RecSend : TRecData2DOrder;
begin
  if Assigned(OnLogServer2D) then
    OnLogServer2D('Client ' + cmd + ' Connected');
end;

procedure TBridgeManager.OnClientTCPDisconnect(cmd: string);
var
  RecSend : TRecData2DOrder;
begin
  if Assigned(OnLogServer2D) then
    OnLogServer2D('Client ' + cmd + ' Disconnected');
end;

procedure TBridgeManager.OnTimerConnectRun(sender: TObject);
begin
  TimerConnect.Enabled := False;

  if TcpClient.State <> wsConnected then
  begin
    TcpClient.Connect(IpServer3D, PortServer3D);
    TimerConnect.Enabled := True;
  end
  else
  begin
    TimerConnect.Enabled := false;
//    GameStatus := 1;

    if Assigned(OnLogPnlClient) then
      OnLogPnlClient('Connected')
  end;
end;

procedure TBridgeManager.Prepare_As_Server2D;
begin
  with tcpServer do begin
    // Receive from client 2D, rebroadcast.
    // Receive form console send to all console
    RegisterProcedure(C_REC_ORDER,            ServerReceive_ServerSend, sizeof(TRecOrder));
    RegisterProcedure(C_REC_ORDER_XY,         ServerReceive_ServerSend, sizeof(TRecOrderXY));
    RegisterProcedure(C_REC_TRACK_ORDER,      ServerReceive_ServerSend, sizeof(TRecTrackOrder));
    RegisterProcedure(C_REC_ORDER_ASSIGNMENT, ServerReceive_ServerSend, sizeof(TRecOrderAssignment));
    RegisterProcedure(C_REC_SET_TRACKNUM,     ServerReceive_ServerSend, sizeof(TRecSetTrackNumber));
    RegisterProcedure(C_REC_FIRE_CONTROL,     ServerReceive_ServerSend, sizeof(TRecFireControlOrder));
    RegisterProcedure(C_REC_GUN_CONTROL,      ServerReceive_ServerSend, sizeof(TRecGunControl));
    RegisterProcedure(C_REC_XXX_ORDER,        ServerReceive_ServerSend, sizeof(TRecXXXOrder));
    RegisterProcedure(C_REC_LINK_ORDER,       ServerReceive_ServerSend, sizeof(TRecLinkOrder));
    RegisterProcedure(C_REC_HARPOON_SETTING,  ServerReceive_ServerSend, sizeof(TRecHarpoonPanelSetting));

    //receive from console send to instruktur
    RegisterProcedure(REC_CMD_COM_CONSOLE,    ServerReceive_ServerSend, SizeOf(TRecComConsole));
    RegisterProcedure(REC_STATUS_YAKHONT,     ServerReceive_ServerSend, SizeOf(TRecStatus_Console_Yakhont));
    RegisterProcedure(REC_STATUS_C802,        ServerReceive_ServerSend, SizeOf(TRecStatus_Console_C802));

    //receive from instruktur send to all console
    RegisterProcedure(RecRBU_SonarMode_ORDER, ServerReceive_ServerSend, SizeOf(TRecRBU_SonarMode));
    RegisterProcedure(REC_STAT_ORDER_CONSOLE, ServerReceive_ServerSend, SizeOf(TRecStatus_Console));
    RegisterProcedure(REC_STAT_ASSIGN_OBJECT, ServerReceive_ServerSend, SizeOf(TRecObjectAssigned));
    RegisterProcedure(REC_EVENT_LOG, ServerReceive_ServerSend, SizeOf(TRecEventLog));

    //receive from instruktur send to instruktur
    RegisterProcedure(REC_STATUS_GAME , ServerReceive_ServerSend, SizeOf(TRecStatusGame));
    RegisterProcedure(REC_ENABLE_WEAPON , ServerReceive_ServerSend, SizeOf(TRecEnableWeapon));
    RegisterProcedure(REC_ASROC_TYPE_MISSILE , ServerReceive_ServerSend, SizeOf(TRecAsrocMissileType));

    //receive from instruktur send to all or one console
    RegisterProcedure(REC_2D_ORDER,           ServerReceive_ClientManagement , sizeof(TRecData2DOrder));

    //For Update Position
    RegisterProcedure(REC_3D_POSITION,        ServerReceive_ClientSend, sizeof(TRecData3DPosition));
    RegisterProcedure(REC_3D_MISSILEPOS,      ServerReceive_ClientSend, sizeof(TRec3DMissilePos));

    //For Weapon
    RegisterProcedure(REC_3D_EXOCET,        ServerReceive_ClientSend, sizeof(TRecSetExocet));

    RegisterProcedure(REC_CMD_EXOCET_40,    ServerReceive_ClientSend, SizeOf(TRec3DSetExocet_40));
    //RegisterProcedure(REC_CMD_EXOCET_40,    ServerReceive_ClientSend, SizeOf(TRec3DSetExocet_40));

    RegisterProcedure(REC_3D_ORDER,         ServerReceive_ServerClientSend, sizeof(TRecData3DOrder));
    RegisterProcedure(REC_SET_CHAFF,        ServerReceive_ClientSend, sizeof(TRecSetChaff));
    RegisterProcedure(REC_SET_ASROCK,       ServerReceive_ClientSend, sizeof(TRecSetAsrock));
    RegisterProcedure(REC_3D_TORPEDO_SUT,   ServerReceive_ClientSend, sizeof(TRecSetTorpedoSUT));
    RegisterProcedure(REC_3D_TORPEDO_MK44,  ServerReceive_ClientSend, sizeof(TRecTorpedoMK44Order));
    RegisterProcedure(C_REC_CANNON,         ServerReceive_ClientSend, sizeof(TRec3DSetWCC));
    RegisterProcedure(REC_3D_RBU,           ServerReceive_ClientSend, SizeOf(TRec3DSetRBU));
    RegisterProcedure(REC_DATA_Yakhont,     ServerReceive_ClientSend, SizeOf(TRecData_YAkhont));
    RegisterProcedure(REC_3D_WCC,           ServerReceive_ClientSend, SizeOf(TRec3DSetWCC));
    RegisterProcedure(REC_CMD_TETRAL,       ServerReceive_ClientSend, SizeOf(TRec3DSetTetral));
    RegisterProcedure(REC_CMD_MISTRAL,      ServerReceive_ClientSend, SizeOf(TRec3DSetMistral));
    RegisterProcedure(REC_CMD_STRELLA,      ServerReceive_ClientSend, SizeOf(TRec3DSetStrella));

    RegisterProcedure(REC_DATA_Yakhont,     ServerReceive_ClientSend, SizeOf(TRecData_YAkhont));
    RegisterProcedure(REC_DATA_C802,        ServerReceive_ClientSend, SizeOf(TRecData_C802));
    RegisterProcedure(REC_SPSS_ORDER,       ServerReceive_ClientSend, SizeOf(TRecDataTorperdo));

    //For Utility
    RegisterProcedure(REC_ENVIRONMENT,        nil,                      Sizeof(TRecDataEnvironment));
    RegisterProcedure(REC_3D_UTIL_TOOLS,      ServerReceive_ClientSend, SizeOf(spUtilityTools));
    RegisterProcedure(REC_3D_SETCONTROL,      ServerReceive_ClientSend, sizeOf(spActorsController));
    RegisterProcedure(REC_STAT_CANNON_SPLASH, nil,                      SizeOf(TRecSplashCANNON));
    RegisterProcedure(REC_RECV_TORP_STATE,    nil,                      SizeOf(TRec_TorpStatus));

    //For Map Control
    RegisterProcedure(REC_MAP_COMMAND,      ServerReceive_ServerSend, SizeOf(TRecMapCommand));
    RegisterProcedure(REC_WEAPON_SHOW_RANGE,ServerReceive_ServerSend, SizeOf(TRecWeaponShowRange));

    //GUIDANCE VEHICLE
    RegisterProcedure(REC_GUIDANCE,         ServerReceive_ClientSend, SizeOf(TRecGuidance));

    //For REPLAY
    RegisterProcedure(REC_REPLAY,           ServerReceive_ServerSend, SizeOf(TRec_Replay));

    //for trajectory
    RegisterProcedure(REC_TRAJECTORY_VIEW,  ServerReceive_ServerSend, SizeOf(TRec_Trajectory_View));

    RegisterProcedure(REC_VIEW_RANGE_WEAPON,  ServerReceive_ServerSend, SizeOf(TRec_View_Range_Weapon));
  end;
end;

procedure TBridgeManager.Prepare_As_Client3D;
begin
  tcpClient.RegisterProcedure(REC_2D_ORDER,         nil , sizeof(TRecData2DOrder));
  tcpClient.RegisterProcedure(REC_STATUS_GAME , nil, SizeOf(TRecStatusGame));

  //For Weapon
  tcpClient.RegisterProcedure(REC_3D_EXOCET,        nil, sizeof(TRecSetExocet));
  tcpClient.RegisterProcedure(REC_3D_ASROCK,        nil, sizeof(TRec3DSetAsrock));
  tcpClient.RegisterProcedure(REC_3D_RBU,           nil, sizeof(TRec3DSetRBU));
  tcpClient.RegisterProcedure(REC_3D_TORPEDO_SUT,   nil, sizeof(TRecSetTorpedoSUT));
  TCPClient.RegisterProcedure(REC_SPSS_ORDER,       nil, SizeOf(TRecDataTorperdo));
  TCPClient.RegisterProcedure(C_REC_CANNON,         nil, SizeOf(TRec3DSetWCC));
  TCPClient.RegisterProcedure(REC_CMD_TETRAL,       nil, SizeOf(TRec3DSetTetral));
  TCPClient.RegisterProcedure(REC_CMD_MISTRAL,      nil, SizeOf(TRec3DSetMistral));
  TCPClient.RegisterProcedure(REC_CMD_STRELLA,      nil, SizeOf(TRec3DSetStrella));
  TCPClient.RegisterProcedure(REC_CMD_MISTRAL,      nil, SizeOf(TRec3DSetMistral));
  TCPClient.RegisterProcedure(REC_DATA_Yakhont,     nil, SizeOf(TRecData_YAkhont));
  TCPClient.RegisterProcedure(REC_DATA_C802,        nil, SizeOf(TRecData_C802));
  TCPClient.RegisterProcedure(REC_CMD_EXOCET_40,    nil, SizeOf(TRec3DSetExocet_40));

  //For Position
  tcpClient.RegisterProcedure(REC_3D_MISSILEPOS,      ClientRecv_3D_MissilePos , sizeof(TRec3DMissilePos));
  tcpClient.RegisterProcedure(REC_3D_POSITION,        ClientRecv_3D_ShipPos ,    sizeOf(TRecData3DPosition));
  TcpClient.RegisterProcedure(REC_STAT_CANNON_SPLASH, ClientReceive_ServerSend,  SizeOf(TRecSplashCANNON));

  //For Utility
  TcpClient.RegisterProcedure(REC_3D_ORDER,           ClientReceive_ServerSend, sizeof(TRecData3DOrder));
  TcpClient.RegisterProcedure(REC_RECV_TORP_STATE,    ClientReceive_ServerSend, sizeof(TRec_TorpStatus));
  tcpClient.RegisterProcedure(REC_3D_SETCONTROL,      nil, sizeOf(spActorsController));
  tcpClient.RegisterProcedure(REC_3D_UTIL_TOOLS,      ClientReceive_ServerSend, sizeOf(spUtilityTools));
  TcpClient.RegisterProcedure(REC_STATUS_MESSAGE,     ClientReceive_ServerSend, SizeOf(TRecMessageHandling));

end;

procedure TBridgeManager.RunSimulation;
begin
  ConnectTo3DServer;
  ListenServer2D;
end;

procedure TBridgeManager.PrepareStopSimulation;
begin
  if ( TcpClient.State = wsConnected ) or ( TcpClient.State = wsConnecting ) then
  begin
    TimerConnect.Enabled := false;
    TcpClient.Disconnect;
  end;
end;

procedure TBridgeManager.ServerReceive_ClientSend(apRec: PAnsiChar; aSize: Integer; Sender: TWSocketClient);
var
  pc: TPacketCheck;

  recTorpedoSut : ^TRecSetTorpedoSUT;
  recRBU        : ^TRec3DSetRBU;
  recWCC        : ^TRec3DSetWCC;
  recExocet     : ^TRec3DSetExocet;
  recASROC      : ^TRec3DSetAsrock;
  recA244       : ^TRecDataTorperdo;
  recYAHKONT    : ^TRecData_Yakhont;
  recC802       : ^TRecData_C802;
  recExocetMM40 : ^TRec3DSetExocet_40;
  recTetral     : ^TRec3DSetTetral;

  xTarget_3D,
  yTarget_3D,
  zTarget_3D    : Double;

  xOffsetMap,
  yOffsetMap    : Double;
begin
 // receive from 2D, send to 3D
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  if (TCPClient <> nil) and (TCPClient.State in [wsConnected]) then
    TCPClient.sendDataEx(pc.ID, apRec);

  if Assigned(OnLogPacket) then
  begin
    if pc.ID = REC_3D_TORPEDO_SUT then
    begin
      recTorpedoSut := @apRec^;
      OnLogPacket('REC_3D_TORPEDO_SUT, '+ IntToStr(pc.ID) +' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_3D_RBU then
    begin
      OnLogPacket('REC_3D_RBU, '+ IntToStr(pc.ID) +' --> Send Back To Server 3D');

      recRBU := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recRBU^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recRBU^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recRBU^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recRBU^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recRBU^.mMissileNumber));

      OnLogPacket('mMissileType :' + IntToStr(recRBU^.mMissileType));
      OnLogPacket('mTargetID :' + IntToStr(recRBU^.mTargetID));
      OnLogPacket('OrderID :' + FloatToStr(recRBU^.OrderID));

      OnLogPacket('mLncrBearing :' + FloatToStr(recRBU^.mLncrBearing));
      OnLogPacket('mLncRange :' + FloatToStr(recRBU^.mLncRange));
      OnLogPacket('mTargetDepth :' + FloatToStr(recRBU^.mTargetDepth));
      OnLogPacket('mCorrBearing :' + FloatToStr(recRBU^.mCorrBearing));
      OnLogPacket('mCorrElev :' + FloatToStr(recRBU^.mCorrElev));
    end
    else
    if pc.ID = REC_SPSS_ORDER then
    begin
      OnLogPacket('REC_SPSS_ORDER, '+ IntToStr(pc.ID) +' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_3D_EXOCET then
    begin
      OnLogPacket('REC_3D_EXOCET, '+ IntToStr(pc.ID) +' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_3D_ASROCK then
    begin
      OnLogPacket('REC_3D_ASROCK,  '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = C_REC_CANNON  then
    begin
      OnLogPacket('C_REC_CANNON,  '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_DATA_Yakhont then
    begin
      OnLogPacket('REC_DATA_Yakhont, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');

      recYAHKONT := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recYAHKONT^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recYAHKONT^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recYAHKONT^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recYAHKONT^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recYAHKONT^.mMissileNumber));


      OnLogPacket('OrderID :' + FloatToStr(recYAHKONT^.OrderID));

      OnLogPacket('mTRGtBearing :' + FloatToStr(recYAHKONT^.mTargetBearing));
      OnLogPacket('mTRGTRange :' + FloatToStr(recYAHKONT^.mTargetRange));

      OnLogPacket('missile1:' + FloatToStr(recYAHKONT^.mMissile1));
      OnLogPacket('missile2:' + FloatToStr(recYAHKONT^.mMissile2));
      OnLogPacket('missile3:' + FloatToStr(recYAHKONT^.mMissile3));
      OnLogPacket('missile4:' + FloatToStr(recYAHKONT^.mMissile4));

    end
    else
    if pc.ID = REC_DATA_C802 then
    begin
      OnLogPacket('REC_DATA_C802, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_CMD_EXOCET_40 then
    begin
      OnLogPacket('REC_CMD_EXOCET_40, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_CMD_TETRAL then
    begin
      OnLogPacket('REC_CMD_TETRAL, ' + IntToStr(pc.ID) + ' --> Send Back To Server 3D' );

      recTetral := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recTetral^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recTetral^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recTetral^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recTetral^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recTetral^.mMissileNumber));
      OnLogPacket('OrderID :' + IntToStr(recTetral^.OrderID));
      OnLogPacket('TargetBearing :' + FloatToStr(recTetral^.mTargetBearing));
      OnLogPacket('TargetRange :' + FloatToStr(recTetral^.mTargetRange));
      OnLogPacket('TargetElev :' + FloatToStr(recTetral^.mTargetElev));
      
    end
    else
    if pc.ID = REC_3D_UTIL_TOOLS then
    begin
      OnLogPacket('REC_3D_UTIL_TOOLS, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_3D_SETCONTROL then
    begin
      OnLogPacket('REC_3D_SETCONTROL, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    if pc.ID = REC_3D_POSITION then
    begin
      OnLogPacket('REC_3D_POSITION, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end

    else
    if pc.ID = REC_3D_MISSILEPOS then
    begin
      OnLogPacket('REC_3D_MISSILEPOS, '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end
    else
    begin
      OnLogPacket('Not From Console,  '+ IntToStr(pc.ID) + ' --> Send Back To Server 3D');
    end;
  end;
end;

procedure TBridgeManager.ServerReceive_ServerClientSend(apRec: PAnsiChar;
  aSize: integer; Sender: TWSocketClient);
var
  pc: TPacketCheck;
begin
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  tcpServer.SendDataEx(pc.ID, apRec, nil);
  TcpClient.sendDataEx(pc.ID, apRec);
end;

procedure TBridgeManager.ServerReceive_ServerSend(apRec: PAnsiChar;
  aSize: integer; Sender: TWSocketClient);
var
  pc: TPacketCheck;

  RecConsole : ^TRecStatus_Console;
  RecObjectAssigned : ^TRecObjectAssigned;
  RecTesLog : ^TRecEventLog;
begin
  // server socket received. server socket re broadcast
  // receive from 2D, send to 2D
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  tcpServer.SendDataEx(pc.ID, apRec, nil);

  if pc.ID = REC_STAT_ORDER_CONSOLE then
  begin
    RecConsole := @apRec^;

    OnLogPacket('Ship ID : ' + RecConsole^.OWN_SHIP_UID + ' ' +
    'Weapon ID : ' + IntToStr(RecConsole^.WeaponID) + ' ' +
    'Error ID : ' + IntToStr(RecConsole^.ErrorID) + ' ' +
    'Param ID : ' + IntToStr(RecConsole^.ParamError));

    FPacketBuff.PutPacket(apRec ,aSize);
  end
  else
  if pc.ID = REC_STAT_ASSIGN_OBJECT then
  begin
    RecObjectAssigned := @apRec^;

    OnLogPacket('Ship ID : ' +IntToStr(RecObjectAssigned^.ShipID) + ' ' +
    'object Assign : ' + IntToStr(RecObjectAssigned^.ObjectAssign) + ' ' +
    'order ID : ' + IntToStr(RecObjectAssigned^.OrderID) + ' ' +
    'mode : ' + IntToStr(RecObjectAssigned^.mode));

  end
  else
  if pc.ID = REC_EVENT_LOG then
  begin
    RecTesLog := @apRec^;

    OnLogPacket('console ID : ' +IntToStr(Recteslog^.consoleID) + ' ' +
    'eventID : ' + IntToStr(Recteslog^.eventID) + ' ' +
    'param1: ' + FloatToStr(Recteslog^.param1) + ' ' +
    'param2 : ' + FloatToStr(Recteslog^.param2)+ ' '+
    'param3 : '+ FloatToStr(Recteslog.param3)+' '+
    'ShipID : '+inttostr(Recteslog.ShipID));
  end
  else
  if pc.ID = REC_STATUS_GAME then
  begin
    FPacketBuff.PutPacket(apRec, aSize);

//    CopyMemory(@pc, apRec, sizeof(TPacketCheck));
    //send to 3d bridge converter
    if (TCPClient <> nil) and (TCPClient.State in [wsConnected]) then
      TCPClient.sendDataEx(pc.ID, apRec);
  end
  else
  if pc.ID = REC_ASROC_TYPE_MISSILE then
  begin
    FPacketBuff.PutPacket(apRec, aSize);
  end
end;

procedure TBridgeManager.StopSimulation;
begin

end;

procedure TBridgeManager.ServerReceive_ClientManagement(apRec: PAnsiChar;
  aSize: integer; Sender: TWSocketClient);
var
  i,j : integer;

  aRec      : ^TRecData2DOrder;
  RecSend   : TRecData2DOrder;

  IpToSend  : string;
  PortToSend : string;
  Client    : TWSocketClient;
  pBuff     : PAnsiChar;
  pid       : ^TPacketCheck;
  pSize     : Word;
  pc: TPacketCheck;
begin
  aRec := @apRec^;

  case aRec.orderID of
    _CM_CLIENT_MANAGE :
    begin
        case aRec.numValue of
          __CM_CLIENT_RESTARTALLCOMM,
          __CM_CLIENT_SHUTDOWNALLCOM,
          __CM_CLIENT_RESTARTSERVERCOMM,
          __CM_CLIENT_SHUTDOWNSERVERCOMM,
          __CM_CLIENT_CLOSEALLCOM :
          begin
            RecSend.orderID   := aRec.orderID;
            RecSend.numValue  := aRec.numValue;
            RecSend.strValue  := '';
            RecSend.strValue2 := '';
            RecSend.strValue3 := '';
            RecSend.ipConsole := '';
            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
          end;

          __CM_CLIENT_CONNECT :
          begin
            IpToSend  := Sender.GetPeerAddr;

            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
            begin
              Client := TcpServer.WSocketServer.Client[i];
              if Client.GetPeerAddr = IpToSend then
              begin
                //Send Set DB Address
                RecSend.orderID   := _CM_CLIENT_MANAGE;
                RecSend.numValue  := __CM_CLIENT_SETDB_ADDR;
                RecSend.strValue  := DBServer;
                RecSend.strValue2 := '';
                RecSend.strValue3 := '';
                RecSend.ipConsole := IpToSend;
                //Send to Launcher
                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);

                //Send Set DB Address
                RecSend.orderID   := _CM_CLIENT_MANAGE;
                RecSend.numValue  := __CM_CLIENT_WELCOME;
                RecSend.strValue  := IpToSend;
                RecSend.strValue2 := '';
                RecSend.strValue3 := '';
                RecSend.ipConsole := IpToSend;
                //Send to Launcher
                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
              end;
            end;
          end;

          __CM_CLIENT_RESTART :
          begin
            IpToSend  := aRec.ipConsole;
            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
            begin
              Client := TcpServer.WSocketServer.Client[i];
              if Client.GetPeerAddr = IpToSend then
              begin
                //Send Restart
                RecSend.orderID   := _CM_CLIENT_MANAGE;
                RecSend.numValue  := __CM_CLIENT_RESTART;
                RecSend.strValue  := IpToSend;
                RecSend.strValue2 := '';
                RecSend.strValue3 := '';
                RecSend.ipConsole := IpToSend;

                //Send to Launcher
                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
              end;
            end;
          end;

          __CM_CLIENT_SHUTDOWN :
          begin
            IpToSend  := aRec.ipConsole;
            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
            begin
              Client := TcpServer.WSocketServer.Client[i];
              if Client.GetPeerAddr = IpToSend then
              begin
                //Send Restart
                RecSend.orderID   := _CM_CLIENT_MANAGE;
                RecSend.numValue  := __CM_CLIENT_SHUTDOWN;
                RecSend.strValue  := IpToSend;
                RecSend.strValue2 := '';
                RecSend.strValue3 := '';
                RecSend.ipConsole := IpToSend;

                //Send to Launcher
                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
              end;
            end;
          end;

          __CM_CLIENT_RESTART_ALL :
          begin
            //Send Restart
            RecSend.orderID   := _CM_CLIENT_MANAGE;
            RecSend.numValue  := __CM_CLIENT_RESTART;
            RecSend.strValue  := '';
            RecSend.strValue2 := '';
            RecSend.strValue3 := '';
            RecSend.ipConsole := '';

            //Send to Launcher
            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
          end;

          __CM_CLIENT_SHUTDOWN_ALL :
          begin
            //Send Restart
            RecSend.orderID   := _CM_CLIENT_MANAGE;
            RecSend.numValue  := __CM_CLIENT_SHUTDOWN;
            RecSend.strValue  := '';
            RecSend.strValue2 := '';
            RecSend.strValue3 := '';
            RecSend.ipConsole := '';

            //Send to Launcher
            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
            GameStatus := 0;
          end;
        end;
    end;

    _CM_CLIENT_APP    :
    begin
      case aRec.numValue of
        __CM_CLIENT_LAUNCH, __CM_CLIENT_STOP,
        __CM_CLIENT_RELAUNCH  :
        begin
          IpToSend  := aRec.ipConsole;
          for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
          begin
            Client := TcpServer.WSocketServer.Client[i];
            if Client.GetPeerAddr = IpToSend then
            begin
              TcpServer.SendDataEx(REC_2D_ORDER, apRec, Client);
            end
          end;
        end;
      
        __CM_CLIENT_LAUNCHALL :
        begin
          //Send To All Launcher
          tcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

          CopyMemory(@pc, apRec, sizeof(TPacketCheck));
          if (TCPClient <> nil) and (TCPClient.State in [wsConnected]) then
            TCPClient.sendDataEx(pc.ID, apRec);

          GameStatus := 1;
          //Save ScenarioID
          LastScenarioID := StrToInt(aRec^.strValue);
        end;
      end;
    end;
    
    _CM_CLIENT_CHECK  :
    begin
      //Send To All Launcher
      tcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

      if Assigned(OnLogPacket) then
      begin
        OnLogPacket('');
        OnLogPacket('== Client Check ==');
      end;

      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
      begin
        Client := TcpServer.WSocketServer.Client[i];

        if Assigned(OnLogPacket) then
        begin
          OnLogPacket('Client ' + IntToStr(i) + ' Ip Adress ' + Client.GetPeerAddr);
        end;
      end;
    end;

    _CM_CLIENT_CHECKSCENARIOID :
    begin
      IpToSend  := Sender.GetPeerAddr;

      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
      begin
        Client := TcpServer.WSocketServer.Client[i];
        if Client.GetPeerAddr = IpToSend then
        begin
          RecSend.orderID   := _CM_CLIENT_CHECKSCENARIOID;
          RecSend.numValue  := GameStatus;
          RecSend.strValue  := IntToStr(LastScenarioID);
          RecSend.strValue2 := '';
          RecSend.strValue3 := '';
          RecSend.ipConsole := '';

          TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
        end;
      end;
    end;

    _CM_REQ_SYNCPACKET :
    begin
      IpToSend  := Sender.GetPeerAddr;
      PortToSend := Sender.GetPeerPort;

      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
      begin
        Client := TcpServer.WSocketServer.Client[i];
        if (Client.GetPeerAddr = IpToSend) and (Client.GetPeerPort = PortToSend) then
        begin
          for j := 0 to FPacketBuff.BuffCount - 1 do
          begin
            if FPacketBuff.PeekPacket(j, pBuff, pSize) then
            begin
              pid := @pBuff^;
              TcpServer.SendDataEx(pid^.ID, pBuff, Client);
            end;
          end;

          if Assigned(OnLogPacket) then
            OnLogPacket('Send Sync Packet To ' + IpToSend);
        end;
      end;
    end;

    _CM_CLIENT_CONNECT :
    begin
      IpToSend  := Sender.GetPeerAddr;
      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
      begin
        Client := TcpServer.WSocketServer.Client[i];
        if Client.GetPeerAddr = IpToSend then
        begin
          RecSend.orderID   := aRec^.orderID;
          RecSend.numValue  := aRec^.numValue;
          RecSend.strValue  := '';
          RecSend.strValue2 := '';
          RecSend.strValue3 := '';
          RecSend.ipConsole := '';

          TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
        end;
      end;
    end;
  end;
end;

procedure TBridgeManager.ClientReceive_ServerSend(apRec: PAnsiChar;
  aSize: integer);
var
  pc: TPacketCheck;
  RecRecv : ^TRecSplashCannon;
  RecRecvTorpState : ^TRec_TorpStatus;
  RecRecvStatusMessage : ^TRecMessageHandling;
  strWeapon : string;
begin
  // client socket received. server socket rebroadcast.
  // receive from 3D, send to 2D panel
  // theServer.WSocketServer.

  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  tcpServer.SendDataEx(pc.ID, apRec, nil);

  if pc.ID = REC_STAT_CANNON_SPLASH then
  begin
    RecRecv := @apRec^;

    strWeapon := 'Unknown Cannon';
    case RecRecv^.WeaponID of
      C_DBID_CANNON40   : strWeapon := 'Cannon 40';
      C_DBID_CANNON57   : strWeapon := 'Cannon 57';
      C_DBID_CANNON76   : strWeapon := 'Cannon 76';
      C_DBID_CANNON120  : strWeapon := 'Cannon 120';
    end;

    OnLogPacket('Receive ' +  strWeapon + ' Launcher ' +
                              IntToStr(RecRecv^.LauncherID) +
                              ' From Vehicle ' + IntToStr(RecRecv^.ShipID) + ' Splash @' +
               ' X : ' + FloatToStr(RecRecv^.PosX) +
               ' Y : ' + FloatToStr(RecRecv^.PosY) +
               ' Z : ' + FloatToStr(RecRecv^.PosZ));
  end
  else
  if  pc.ID = REC_RECV_TORP_STATE then
  begin
    RecRecvTorpState := @apRec^;
    OnLogPacket('Sut detect target ' + 'ShipID ' + inttostr(RecRecvTorpState^.ShipID)
               +' ' + ' mWeaponID  ' + inttostr(RecRecvTorpState^.mWeaponID)
               +' ' + 'mLauncherID ' + inttostr(RecRecvTorpState^.mLauncherID)
               +' ' + 'mMissileID  ' + inttostr(RecRecvTorpState^.mMissileID  )
               +' ' + 'isFind      ' + inttostr(RecRecvTorpState^.isFind));


  end
  else
  if pc.ID = REC_STATUS_MESSAGE then
  begin
    RecRecvStatusMessage := @apRec^;
    OnLogPacket('Receive Message'
               +' ' + FloatToStr(RecRecvStatusMessage^.MessageID)
               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd1)
               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd2)
               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd3)
               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd4));
  end;
end;

procedure TBridgeManager.ClientRecv_3D_ShipPos(apRec: PAnsiChar; aSize: integer);
var
  aRec: ^TRecData3DPosition;
//  RecSend : TRecDataPosition;
begin
  //Receive From 3D Server.
  aRec := @apRec^;

  if Assigned(OnLogClient3D) then
    OnLogClient3D('Receive Ship Position '
                  + 'X:' + FloatToStr(aRec^.x) + '--'
                  + 'Y:' + FloatToStr(aRec^.y) + '--'
                  + 'Z:' + FloatToStr(aRec^.z));

  if IsNan(aRec^.X) or
     IsNan(aRec^.Y) or
     IsNan(aRec^.Z) or
     IsNan(aRec^.Heading) or
     isNan(aRec^.Speed) or
     isNan(aRec^.pitch) or
     IsNan(aRec^.roll) or
     IsNan(aRec^.rudder) then
  begin
    LogFile.Log('ERROR', 'RECEIVE NAN POS');

    if Assigned(OnLogPacket) then
      OnLogPacket('ERROR RECEIVE NAN POS');
  end
  else
  begin
    tcpServer.SendDataEx(aRec.pc.ID, apRec, nil);
  end;
end;

procedure TBridgeManager.ClientRecv_3D_MissilePos(apRec: PAnsiChar; aSize: Integer);
var
  aRec : ^TRec3DMissilePos;
begin
  //Receive From 3D Server
  aRec := @apRec^;

  if Assigned(OnLogClient3D) then
    OnLogClient3D('Receive Missile Position '
                  + 'X:' + FloatToStr(aRec^.x) + '--'
                  + 'Y:' + FloatToStr(aRec^.y) + '--'
                  + 'Z:' + FloatToStr(aRec^.z));

  if IsNan(aRec^.X) or
     IsNan(aRec^.Y) or
     IsNan(aRec^.Z) or
     IsNan(aRec^.heading) or
     IsNan(aRec^.speed) then
  begin
    LogFile.Log('ERROR', 'RECEIVE NAN POS');

    if Assigned(OnLogPacket) then
      OnLogPacket('ERROR RECEIVE NAN POS');
  end
  else
  begin
    if ( aRec^.status = ST_MISSILE_LOADED ) or
       ( aRec^.status = ST_MISSILE_DEL ) or
       ( aRec^.status = ST_MISSILE_LOCK) or
       ( aRec^.status = ST_MISSILE_UNLOCK) then
    begin
      FPacketBuff.PutPacket(apRec, aSize);
    end;

    TcpServer.SendDataEx(arec.Pc.ID, apRec, nil);
  end;
end;

procedure TBridgeManager.ClientRecv_3D_Order(apRec: PAnsiChar; aSize: Integer);
var
  aRec : ^TRecData3DOrder;
begin
 aRec := @apRec^;
 TcpServer.SendDataEx(arec.Pc.ID, apRec, nil);
end;

end.
