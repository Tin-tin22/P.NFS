unit uBridgeManager;

interface

uses
  Forms, Classes, Math,

  uTCPServer, uTCPClient, overbyteicsWSocketS,
  ExtCtrls, uBridgeSet, OverbyteIcsWsocket, logger, IniFiles,
  uPacketBuffer;

const
  SockStateS: array [TSocketState] of string = ('InvalidState', 'Opened',
    'Bound', 'Connecting', 'SocksConnected', 'Connected', 'Accepting',
    'Listening', 'Closed', 'DnsLookup');

type
  TOnLogPnlClient3D = procedure(str: string) of object;
  TOnLogSever2D = procedure(str: string) of object;
  TOnLogClient3D = procedure(str: string) of object;
  TOnLogpacket = procedure(str: string) of object;
  TOnLogSettingSocket = procedure(m2D_IP, m2D_Port, m3D_IP, m3D_Port: string)
    of object;
  TOnLogSettingDB = procedure(mDBServer, mDBProto, mDBName, mDBUser, mDBPass,
    mDBPort: string) of object;

  TBridgeManager = class
  private
    FPacketBuff: TPacketBuffer;

    // LoadSetting
    bridgeSet: TRecBridgeSet;
    bridgeSetPath: string;

    // For Connect to Server 3D
    // Use Timer For always check Server Because There is no Form
    FTimerConnect: TTimer;
    procedure OnTimerConnectRun(sender: TObject);

    // Event Disconnect Server For Triggering Timer To Connect
    procedure OnClientState(sender: TObject; OldState, NewState: TSocketState);

    // Event Connect & Disconnect From Client
    procedure OnClientTCPConnect(msg: string);
    procedure OnClientTCPDisconnect(msg: string);
    procedure checkOnOffMode;

  public
    TcpClient: TTCPClient;
    TcpServer: TTCPServer;

    IpServer3D, PortServer3D, Ip2D, Port2D: string;

    DBServer, DBProto, DBName, DBUser, DBPass, DBPort: string;

    GameStatus: Integer; // 0 : Stop, 1 : Play
    LastScenarioID: Integer;

    // Event handler
    OnLogPnlClient: TOnLogPnlClient3D;
    OnLogServer2D: TOnLogSever2D;
    OnLogClient3D: TOnLogClient3D;
    OnLogPacket: TOnLogpacket;

    OnlogSettingDB: TOnLogSettingDB;
    OnLogSettingSocket: TOnLogSettingSocket;

    // Log
    LogFile: TLogFile;

    constructor Create;
    destructor Destroy; override;

    // function GetClientOfServer(ip : string): TWSocketClient;

    procedure Prepare_As_Server2D;
    procedure Prepare_As_Client3D;

    procedure ConnectTo3DServer;
    procedure ListenServer2D;

    procedure InitSimulation;
    procedure RunSimulation;
    procedure PrepareStopSimulation;
    procedure StopSimulation;

    function GetServer2DClientCount: Integer;
    procedure CloseOneServer2DClient;

    procedure ServerReceive_ClientSend(apRec: PAnsiChar; aSize: Integer;
      sender: TWSocketClient);
    procedure ServerReceive_ServerSend(apRec: PAnsiChar; aSize: Integer;
      sender: TWSocketClient);
    procedure ServerReceive_ClientManagement(apRec: PAnsiChar; aSize: Integer;
      sender: TWSocketClient);
    procedure ServerReceive_ServerClientSend(apRec: PAnsiChar; aSize: Integer;
      sender: TWSocketClient);

    procedure ClientRecv_3D_ShipPos(apRec: PAnsiChar; aSize: Integer);
    procedure ClientRecv_3D_MissilePos(apRec: PAnsiChar; aSize: Integer);
    procedure ClientRecv_3D_Order(apRec: PAnsiChar; aSize: Integer);

    procedure ClientReceive_ServerSend(apRec: PAnsiChar; aSize: Integer);
  end;

var
  BridgeManager: TBridgeManager;

implementation

uses
  uTCPDatatype, SysUtils, Windows;

procedure TBridgeManager.ConnectTo3DServer;
begin
  FTimerConnect.Enabled := True;
end;

constructor TBridgeManager.Create;
begin
  inherited;
  FPacketBuff := TPacketBuffer.Create;

  TcpClient := TTCPClient.Create;
  TcpClient.Socket.OnChangeState := OnClientState;

  TcpServer := TTCPServer.Create;
  TcpServer.OnClientConnect := OnClientTCPConnect;
  TcpServer.OnClientDisConnect := OnClientTCPDisconnect;

  FTimerConnect := TTimer.Create(nil);
  FTimerConnect.Enabled := False;
  FTimerConnect.Interval := 5000;
  FTimerConnect.OnTimer := OnTimerConnectRun;

  // First Initialize, Next Read From IniFIle
  IpServer3D := '127.0.0.1';
  PortServer3D := '7777';
  Ip2D := '127.0.0.1';
  Port2D := '6666';

  // Log File
  LogFile := TLogFile.Create;
  LogFile.FileName := ChangeFileExt(Application.ExeName, '.log');
  LogFile.IsLog := True;
  LogFile.Init;

  // Save CurrentLastScenarioID and Status Game
  LastScenarioID := 0;
  GameStatus := 0;
end;

destructor TBridgeManager.Destroy;
begin
  LogFile.Free;
  FTimerConnect.Free;
  TcpServer.Free;
  TcpClient.Free;
  FPacketBuff.Free;
  inherited;
end;

function TBridgeManager.GetServer2DClientCount: Integer;
begin
  Result := TcpServer.WSocketServer.ClientCount;
end;

// function TBridgeManager.GetClientOfServer(ip: string): TWSocketClient;
// var
// i : integer;
// Client : TWSocketClient;
// begin
// Result := nil;
//
// for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
// begin
// Client := TcpServer.WSocketServer.Client[i];
//
// if TcpServer.WSocketServer.IsClient(Client) and Client.GetPeerAddr = ip then
// begin
// Result := Client;
// break;
// end;
// end;
// end;

procedure TBridgeManager.checkOnOffMode;
var
  readPath: string;
  helpIni: TIniFile;
  onOffMode: Integer;
begin
  helpIni := TIniFile.Create('..\bin\BridgeSet.ini');
  try

    readPath := helpIni.ReadString('OnOff', 'mode', '0');
    onOffMode := StrToInt(readPath);

    if onOffMode = 0 then
    begin
      readPath := helpIni.ReadString('OnOff', 'scenarioID', '0');
      LastScenarioID := StrToInt(readPath);
    end;
  finally
    helpIni.Free;
  end;
end;

procedure TBridgeManager.InitSimulation;
begin
  bridgeSetPath := GetSettingDirectory;

  // with bridgeSet.mDB do
  // begin
  InitDefault_DBConfig(bridgeSetPath, DBServer, DBProto, DBName, DBUser,
    DBPass, DBPort);
  // end;

  with bridgeSet.mServer do
  begin
    InitDefault_GameServerConfig(bridgeSetPath, Ip2D, Port2D, IpServer3D,
      PortServer3D);
  end;

  if Assigned(OnlogSettingDB) then
    OnlogSettingDB(DBServer, DBProto, DBName, DBUser, DBPass, DBPort);

  if Assigned(OnLogSettingSocket) then
    OnLogSettingSocket(Ip2D, Port2D, IpServer3D, PortServer3D);
  // yoga ganteng bro
  checkOnOffMode;

  Prepare_As_Server2D;
  Prepare_As_Client3D;
end;

procedure TBridgeManager.ListenServer2D;
begin
  TcpServer.Listen(Port2D);
end;

procedure TBridgeManager.OnClientState(sender: TObject;
  OldState, NewState: TSocketState);
var
  RecSend: TRecData2DOrder;
begin
  if Assigned(OnLogPnlClient) then
    OnLogPnlClient('Status : ' + SockStateS[NewState]);

  if Assigned(OnLogClient3D) then
    OnLogClient3D(SockStateS[OldState] + ' => ' + SockStateS[NewState]);

  if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
    FTimerConnect.Enabled := True;

    RecSend.orderID := _CM_CLIENT_APP;
    RecSend.numValue := __CM_CLIENT_STATUS;
    RecSend.strValue := SockStateS[NewState];
    // RecSend.strValue2 := '';
    // RecSend.strValue3 := '';
    // RecSend.ipConsole := '';
    //
    TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);

    if Assigned(OnLogClient3D) then
      OnLogClient3D('Disconnect from 3D server, try connecting...');

    // if Disconnect from 3D Server, --> Status Stop.
    GameStatus := 0;
    FPacketBuff.Clear;
  end;
end;

procedure TBridgeManager.OnClientTCPConnect(msg: string);
var
  RecSend: TRecData2DOrder;
begin
  if Assigned(OnLogServer2D) then
    OnLogServer2D('Client ' + msg + ' Connected');
end;

procedure TBridgeManager.OnClientTCPDisconnect(msg: string);
var
  RecSend: TRecData2DOrder;
begin
  if Assigned(OnLogServer2D) then
    OnLogServer2D('Client ' + msg + ' Disconnected');
end;

procedure TBridgeManager.OnTimerConnectRun(sender: TObject);
begin
  FTimerConnect.Enabled := False;

  if TcpClient.State <> wsConnected then
  begin
    TcpClient.Connect(IpServer3D, PortServer3D);
    FTimerConnect.Enabled := True;
  end
  else
  begin
    FTimerConnect.Enabled := False;
    // GameStatus := 1;

    if Assigned(OnLogPnlClient) then
      OnLogPnlClient('Connected')
  end;
end;

procedure TBridgeManager.Prepare_As_Server2D;
begin
  with TcpServer do
  begin
    // Receive from client 2D, rebroadcast.
    // Receive form console send to all console
    RegisterProcedure(C_REC_ORDER, ServerReceive_ServerSend, sizeof(TRecOrder));
    RegisterProcedure(C_REC_ORDER_XY, ServerReceive_ServerSend,
      sizeof(TRecOrderXY));
    RegisterProcedure(C_REC_TRACK_ORDER, ServerReceive_ServerSend,
      sizeof(TRecTrackOrder));
    RegisterProcedure(C_REC_ORDER_ASSIGNMENT, ServerReceive_ServerSend,
      sizeof(TRecOrderAssignment));
    RegisterProcedure(C_REC_SET_TRACKNUM, ServerReceive_ServerSend,
      sizeof(TRecSetTrackNumber));
    RegisterProcedure(C_REC_FIRE_CONTROL, ServerReceive_ServerSend,
      sizeof(TRecFireControlOrder));
    RegisterProcedure(C_REC_GUN_CONTROL, ServerReceive_ServerSend,
      sizeof(TRecGunControl));
    RegisterProcedure(C_REC_XXX_ORDER, ServerReceive_ServerSend,
      sizeof(TRecXXXOrder));
    RegisterProcedure(C_REC_LINK_ORDER, ServerReceive_ServerSend,
      sizeof(TRecLinkOrder));
    RegisterProcedure(C_REC_HARPOON_SETTING, ServerReceive_ServerSend,
      sizeof(TRecHarpoonPanelSetting));

    // receive from console send to instruktur
    RegisterProcedure(REC_CMD_COM_CONSOLE, ServerReceive_ServerSend,
      sizeof(TRecComConsole));
    RegisterProcedure(REC_STATUS_YAKHONT, ServerReceive_ServerSend,
      sizeof(TRecStatus_Console_Yakhont));
    RegisterProcedure(REC_STATUS_C802, ServerReceive_ServerSend,
      sizeof(TRecStatus_Console_C802));

    // receive from instruktur send to all console
    RegisterProcedure(RecRBU_SonarMode_ORDER, ServerReceive_ServerSend,
      sizeof(TRecRBU_SonarMode));
    RegisterProcedure(REC_STAT_ORDER_CONSOLE, ServerReceive_ServerSend,
      sizeof(TRecStatus_Console));
    RegisterProcedure(REC_STAT_ASSIGN_OBJECT, ServerReceive_ServerSend,
      sizeof(TRecObjectAssigned));
    RegisterProcedure(REC_EVENT_LOG, ServerReceive_ServerSend,
      sizeof(TRecEventLog));

    // receive from instruktur send to instruktur
    RegisterProcedure(REC_STATUS_GAME, ServerReceive_ServerSend,
      sizeof(TRecStatusGame));
    RegisterProcedure(REC_ENABLE_WEAPON, ServerReceive_ServerSend,
      sizeof(TRecEnableWeapon));
//    RegisterProcedure(REC_ASROC_TYPE_MISSILE, ServerReceive_ServerSend,
//      sizeof(TRecAsrocMissileType));

    // receive from instruktur send to all or one console
    RegisterProcedure(REC_2D_ORDER, ServerReceive_ClientManagement,
      sizeof(TRecData2DOrder));

    // For Update Position
    RegisterProcedure(REC_3D_POSITION, ServerReceive_ClientSend,
      sizeof(TRecData3DPosition));
    RegisterProcedure(REC_3D_MISSILEPOS, ServerReceive_ClientSend,
      sizeof(TRec3DMissilePos));

    // For Weapon
    RegisterProcedure(REC_3D_EXOCET, ServerReceive_ClientSend,
      sizeof(TRecSetExocet));

    RegisterProcedure(REC_CMD_EXOCET_40, ServerReceive_ClientSend,
      sizeof(TRec3DSetExocet_40));
    // RegisterProcedure(REC_CMD_EXOCET_40,    ServerReceive_ClientSend, SizeOf(TRec3DSetExocet_40));

    RegisterProcedure(REC_3D_ORDER, ServerReceive_ServerClientSend,
      sizeof(TRecData3DOrder));
    RegisterProcedure(REC_SET_CHAFF, ServerReceive_ClientSend,
      sizeof(TRecSetChaff));
//    RegisterProcedure(REC_SET_ASROCK, ServerReceive_ClientSend,
//      sizeof(TRecSetAsrock));
    RegisterProcedure(REC_3D_TORPEDO_SUT, ServerReceive_ClientSend,
      sizeof(TRecSetTorpedoSUT));
    RegisterProcedure(REC_3D_TORPEDO_MK44, ServerReceive_ClientSend,
      sizeof(TRecTorpedoMK44Order));
    RegisterProcedure(C_REC_CANNON, ServerReceive_ClientSend,
      sizeof(TRec3DSetWCC));
    RegisterProcedure(REC_3D_RBU, ServerReceive_ClientSend,
      sizeof(TRec3DSetRBU));
    RegisterProcedure(REC_DATA_Yakhont, ServerReceive_ClientSend,
      sizeof(TRecData_YAkhont));
//    RegisterProcedure(REC_3D_WCC, ServerReceive_ClientSend,
//      sizeof(TRec3DSetWCC));
    RegisterProcedure(REC_CMD_TETRAL, ServerReceive_ClientSend,
      sizeof(TRec3DSetTetral));
//    RegisterProcedure(REC_CMD_MISTRAL, ServerReceive_ClientSend,
//      sizeof(TRec3DSetMistral));
//    RegisterProcedure(REC_CMD_STRELLA, ServerReceive_ClientSend,
//      sizeof(TRec3DSetStrella));

    RegisterProcedure(REC_DATA_Yakhont, ServerReceive_ClientSend,
      sizeof(TRecData_YAkhont));
    RegisterProcedure(REC_DATA_C802, ServerReceive_ClientSend,
      sizeof(TRecData_C802));
    RegisterProcedure(REC_SPSS_ORDER, ServerReceive_ClientSend,
      sizeof(TRecDataTorperdo));

    // For Utility
    RegisterProcedure(REC_ENVIRONMENT, nil, sizeof(TRecDataEnvironment));
    RegisterProcedure(REC_3D_UTIL_TOOLS, ServerReceive_ClientSend,
      sizeof(spUtilityTools));
    RegisterProcedure(REC_3D_SETCONTROL, ServerReceive_ClientSend,
      sizeof(spActorsController));
    RegisterProcedure(REC_STAT_CANNON_SPLASH, nil, sizeof(TRecSplashCANNON));
    RegisterProcedure(REC_RECV_TORP_STATE, nil, sizeof(TRec_TorpStatus));

    // For Map Control
    RegisterProcedure(REC_MAP_COMMAND, ServerReceive_ServerSend,
      sizeof(TRecMapCommand));
    RegisterProcedure(REC_WEAPON_SHOW_RANGE, ServerReceive_ServerSend,
      sizeof(TRecWeaponShowRange));

    // GUIDANCE VEHICLE
    RegisterProcedure(REC_GUIDANCE, ServerReceive_ClientSend,
      sizeof(TRecGuidance));

    // For REPLAY
    RegisterProcedure(REC_REPLAY, ServerReceive_ServerSend,
      sizeof(TRec_Replay));

    // for trajectory
    RegisterProcedure(REC_TRAJECTORY_VIEW, ServerReceive_ServerSend,
      sizeof(TRec_Trajectory_View));

    RegisterProcedure(REC_VIEW_RANGE_WEAPON, ServerReceive_ServerSend,
      sizeof(TRec_View_Range_Weapon));
  end;
end;

procedure TBridgeManager.Prepare_As_Client3D;
begin
//  TcpClient.RegisterProcedure(REC_2D_ORDER, nil, sizeof(TRecData2DOrder));
  TcpClient.RegisterProcedure(REC_STATUS_GAME, nil, sizeof(TRecStatusGame));

  // For Weapon
  TcpClient.RegisterProcedure(REC_3D_EXOCET, nil, sizeof(TRecSetExocet));
//  TcpClient.RegisterProcedure(REC_3D_ASROCK, nil, sizeof(TRec3DSetAsrock));
  TcpClient.RegisterProcedure(REC_3D_RBU, nil, sizeof(TRec3DSetRBU));
  TcpClient.RegisterProcedure(REC_3D_TORPEDO_SUT, nil,
    sizeof(TRecSetTorpedoSUT));
  TcpClient.RegisterProcedure(REC_SPSS_ORDER, nil, sizeof(TRecDataTorperdo));
  TcpClient.RegisterProcedure(C_REC_CANNON, nil, sizeof(TRec3DSetWCC));
  TcpClient.RegisterProcedure(REC_CMD_TETRAL, nil, sizeof(TRec3DSetTetral));
//  TcpClient.RegisterProcedure(REC_CMD_MISTRAL, nil, sizeof(TRec3DSetMistral));
//  TcpClient.RegisterProcedure(REC_CMD_STRELLA, nil, sizeof(TRec3DSetStrella));
//  TcpClient.RegisterProcedure(REC_CMD_MISTRAL, nil, sizeof(TRec3DSetMistral));
  TcpClient.RegisterProcedure(REC_DATA_Yakhont, nil, sizeof(TRecData_YAkhont));
  TcpClient.RegisterProcedure(REC_DATA_C802, nil, sizeof(TRecData_C802));
  TcpClient.RegisterProcedure(REC_CMD_EXOCET_40, nil,
    sizeof(TRec3DSetExocet_40));

  // For Position
  TcpClient.RegisterProcedure(REC_3D_MISSILEPOS, ClientRecv_3D_MissilePos,
    sizeof(TRec3DMissilePos));
  TcpClient.RegisterProcedure(REC_3D_POSITION, ClientRecv_3D_ShipPos,
    sizeof(TRecData3DPosition));
  TcpClient.RegisterProcedure(REC_STAT_CANNON_SPLASH, ClientReceive_ServerSend,
    sizeof(TRecSplashCANNON));

  // For Utility
  TcpClient.RegisterProcedure(REC_3D_ORDER, ClientReceive_ServerSend,
    sizeof(TRecData3DOrder));
  TcpClient.RegisterProcedure(REC_RECV_TORP_STATE, ClientReceive_ServerSend,
    sizeof(TRec_TorpStatus));
  TcpClient.RegisterProcedure(REC_3D_SETCONTROL, nil,
    sizeof(spActorsController));
  TcpClient.RegisterProcedure(REC_3D_UTIL_TOOLS, ClientReceive_ServerSend,
    sizeof(spUtilityTools));
  TcpClient.RegisterProcedure(REC_STATUS_MESSAGE, ClientReceive_ServerSend,
    sizeof(TRecMessageHandling));

end;

procedure TBridgeManager.RunSimulation;
begin
  ConnectTo3DServer;
  ListenServer2D;
end;

procedure TBridgeManager.PrepareStopSimulation;
begin
  FTimerConnect.Enabled := False;
  if TcpClient.State <> wsClosed then
  begin
    TcpClient.Disconnect;
  end;
  TcpServer.UnregisterAllProcedure;
  TcpServer.Stop;
end;

procedure TBridgeManager.ServerReceive_ClientSend(apRec: PAnsiChar;
  aSize: Integer; sender: TWSocketClient);
var
  pc: TPacketCheck;

  recTorpedoSut: ^TRecSetTorpedoSUT;
  recRBU: ^TRec3DSetRBU;
  recWCC: ^TRec3DSetWCC;
  recExocet: ^TRec3DSetExocet;
  recASROC: ^TRec3DSetAsrock;
  recA244: ^TRecDataTorperdo;
  recYAHKONT: ^TRecData_YAkhont;
  recC802: ^TRecData_C802;
  recExocetMM40: ^TRec3DSetExocet_40;
  recTetral: ^TRec3DSetTetral;

  xTarget_3D, yTarget_3D, zTarget_3D: Double;

  xOffsetMap, yOffsetMap: Double;
begin
  // receive from 2D, send to 3D
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  if (TcpClient <> nil) and (TcpClient.State in [wsConnected]) then
    TcpClient.SendDataEx(pc.ID, apRec);

  if Assigned(OnLogPacket) then
    OnLogPacket('Received : ' + C_REC_PACKETNAME[pc.ID]);

  if Assigned(OnLogPacket) then
  begin
    if pc.ID = REC_3D_TORPEDO_SUT then
    begin
      recTorpedoSut := @apRec^;
      OnLogPacket('REC_3D_TORPEDO_SUT, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else if pc.ID = REC_3D_RBU then
    begin
      OnLogPacket('REC_3D_RBU, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recRBU := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recRBU^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recRBU^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recRBU^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recRBU^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recRBU^.mMissileNumber));

      OnLogPacket('mMissileType :' + IntToStr(recRBU^.mMissileType));
      OnLogPacket('mTargetID :' + IntToStr(recRBU^.mTargetID));
      OnLogPacket('OrderID :' + FloatToStr(recRBU^.orderID));

      OnLogPacket('mLncrBearing :' + FloatToStr(recRBU^.mLncrBearing));
      OnLogPacket('mLncRange :' + FloatToStr(recRBU^.mLncRange));
      OnLogPacket('mTargetDepth :' + FloatToStr(recRBU^.mTargetDepth));
      OnLogPacket('mCorrBearing :' + FloatToStr(recRBU^.mCorrBearing));
      OnLogPacket('mCorrElev :' + FloatToStr(recRBU^.mCorrElev));
    end
    else if pc.ID = REC_SPSS_ORDER then
    begin
      OnLogPacket('REC_SPSS_ORDER, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else if pc.ID = REC_3D_EXOCET then
    begin
      OnLogPacket('REC_3D_EXOCET, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recExocet:= @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recExocet^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recExocet^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recExocet^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recExocet^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recExocet^.mMissileNumber));

      OnLogPacket('OrderID :' + IntToStr(recExocet^.sOrder));
    end
//    else if pc.ID = REC_3D_ASROCK then
//    begin
//      OnLogPacket('REC_3D_ASROCK,  ' + IntToStr(pc.ID) +
//        ' --> Send Back To Server 3D');
//    end
    else if pc.ID = C_REC_CANNON then
    begin
      OnLogPacket('C_REC_CANNON,  ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else if pc.ID = REC_DATA_Yakhont then
    begin
      OnLogPacket('REC_DATA_Yakhont, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recYAHKONT := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recYAHKONT^.ShipID));
      OnLogPacket('mTargetID :' + IntToStr(recYAHKONT^.mTargetID));
      OnLogPacket('mWeaponID :' + IntToStr(recYAHKONT^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recYAHKONT^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recYAHKONT^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recYAHKONT^.mMissileNumber));

      OnLogPacket('OrderID :' + FloatToStr(recYAHKONT^.orderID));

      OnLogPacket('mTRGtBearing :' + FloatToStr(recYAHKONT^.mTargetBearing));
      OnLogPacket('mTRGTRange :' + FloatToStr(recYAHKONT^.mTargetRange));

      OnLogPacket('missile1:' + FloatToStr(recYAHKONT^.mMissile1));
      OnLogPacket('missile2:' + FloatToStr(recYAHKONT^.mMissile2));
      OnLogPacket('missile3:' + FloatToStr(recYAHKONT^.mMissile3));
      OnLogPacket('missile4:' + FloatToStr(recYAHKONT^.mMissile4));

    end
    else if pc.ID = REC_DATA_C802 then
    begin
      OnLogPacket('REC_DATA_C802, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recC802 := @apRec^;
      OnLogPacket('ShipID :' + IntToStr(recC802^.ShipID));
      OnLogPacket('mTargetID :' + IntToStr(recC802^.mTargetId));
      OnLogPacket('mWeaponID :' + IntToStr(recC802^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recC802^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recC802^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recC802^.mMissileNumber));
      OnLogPacket('OrderID :' + IntToStr(recC802^.OrderID) + 'kalo 1 itu OrdID_C802_launch(1)' );
      OnLogPacket('mTargetBearing :' + FloatToStr(recC802^.mTargetBearing));
      OnLogPacket('mTargetRange :' + FloatToStr(recC802^.mTargetRange));

    end
    else if pc.ID = REC_CMD_EXOCET_40 then
    begin
      OnLogPacket('REC_CMD_EXOCET_40, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recExocetMM40:= @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recExocetMM40^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recExocetMM40^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recExocetMM40^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recExocetMM40^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recExocetMM40^.mMissileNumber));

      OnLogPacket('OrderID :' + IntToStr(recExocetMM40^.sOrder));
      OnLogPacket('Range :' + FloatToStr(recExocetMM40^.mTRange));
      OnLogPacket('Bearing :' + FloatToStr(recExocetMM40^.mTBearing));
      OnLogPacket('TargetID :' + IntToStr(recExocetMM40^.TargetID));

    end
    else if pc.ID = REC_CMD_TETRAL then
    begin
      OnLogPacket('REC_CMD_TETRAL, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');

      recTetral := @apRec^;

      OnLogPacket('ShipID :' + IntToStr(recTetral^.ShipID));
      OnLogPacket('mWeaponID :' + IntToStr(recTetral^.mWeaponID));
      OnLogPacket('mLauncherID :' + IntToStr(recTetral^.mLauncherID));
      OnLogPacket('mMissileID :' + IntToStr(recTetral^.mMissileID));
      OnLogPacket('mMissileNumber :' + IntToStr(recTetral^.mMissileNumber));
      OnLogPacket('OrderID :' + IntToStr(recTetral^.orderID));
      OnLogPacket('TargetBearing :' + FloatToStr(recTetral^.mTargetBearing));
      OnLogPacket('TargetRange :' + FloatToStr(recTetral^.mTargetRange));
      OnLogPacket('TargetElev :' + FloatToStr(recTetral^.mTargetElev));

    end
    else if pc.ID = REC_3D_UTIL_TOOLS then
    begin
      OnLogPacket('REC_3D_UTIL_TOOLS, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else if pc.ID = REC_3D_SETCONTROL then
    begin
      OnLogPacket('REC_3D_SETCONTROL, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else if pc.ID = REC_3D_POSITION then
    begin
      OnLogPacket('REC_3D_POSITION, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end

    else if pc.ID = REC_3D_MISSILEPOS then
    begin
      OnLogPacket('REC_3D_MISSILEPOS, ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end
    else
    begin
      OnLogPacket('Not From Console,  ' + IntToStr(pc.ID) +
        ' --> Send Back To Server 3D');
    end;
  end;
end;

procedure TBridgeManager.ServerReceive_ServerClientSend(apRec: PAnsiChar;
  aSize: Integer; sender: TWSocketClient);
var
  pc: TPacketCheck;
begin
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  TcpServer.SendDataEx(pc.ID, apRec, nil);
  TcpClient.SendDataEx(pc.ID, apRec);
  if Assigned(OnLogPacket) then
    OnLogPacket('Received : ' + C_REC_PACKETNAME[pc.ID]);
end;

procedure TBridgeManager.ServerReceive_ServerSend(apRec: PAnsiChar;
  aSize: Integer; sender: TWSocketClient);
var
  pc: TPacketCheck;

  RecConsole: ^TRecStatus_Console;
  RecObjectAssigned: ^TRecObjectAssigned;
  RecTesLog: ^TRecEventLog;
  RecStatusGame: ^TRecStatusGame;
begin
  // server socket received. server socket re broadcast
  // receive from 2D, send to 2D
  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  TcpServer.SendDataEx(pc.ID, apRec, nil);

  if Assigned(OnLogPacket) then
    OnLogPacket('Received : ' + C_REC_PACKETNAME[pc.ID]);

  if pc.ID = REC_STAT_ORDER_CONSOLE then
  begin
    RecConsole := @apRec^;

    OnLogPacket('Ship ID : ' + RecConsole^.OWN_SHIP_UID + ' ' + 'Weapon ID : ' +
      IntToStr(RecConsole^.WeaponID) + ' ' + 'Error ID : ' +
      IntToStr(RecConsole^.ErrorID) + ' ' + 'Param ID : ' +
      IntToStr(RecConsole^.ParamError));

    FPacketBuff.PutPacket(apRec, aSize);
  end
  else if pc.ID = REC_STAT_ASSIGN_OBJECT then
  begin
    RecObjectAssigned := @apRec^;

    OnLogPacket('Ship ID : ' + IntToStr(RecObjectAssigned^.ShipID) + ' ' +
      'object Assign : ' + IntToStr(RecObjectAssigned^.ObjectAssign) + ' ' +
      'order ID : ' + IntToStr(RecObjectAssigned^.orderID) + ' ' + 'mode : ' +
      IntToStr(RecObjectAssigned^.mode));

  end
  else if pc.ID = REC_EVENT_LOG then
  begin
    RecTesLog := @apRec^;

    OnLogPacket('console ID : ' + IntToStr(RecTesLog^.consoleID) + ' ' +
      'eventID : ' + IntToStr(RecTesLog^.eventID) + ' ' + 'param1: ' +
      FloatToStr(RecTesLog^.param1) + ' ' + 'param2 : ' +
      FloatToStr(RecTesLog^.param2) + ' ' + 'param3 : ' +
      FloatToStr(RecTesLog.param3) + ' ' + 'ShipID : ' +
      IntToStr(RecTesLog.ShipID));
  end
  else if pc.ID = REC_STATUS_GAME then
  begin
    RecStatusGame := @apRec^;

    if RecStatusGame.StatusConnect = 2 then begin
      FPacketBuff.Clear;
      LastScenarioID := RecStatusGame.ScenarioID;
    end;
    // else
    // FPacketBuff.PutPacket(apRec, aSize);

    // CopyMemory(@pc, apRec, sizeof(TPacketCheck));
    // send to 3d bridge converter
    if (TcpClient <> nil) and (TcpClient.State in [wsConnected]) then
      TcpClient.SendDataEx(pc.ID, apRec);
  end
  else if pc.ID = REC_ASROC_TYPE_MISSILE then
  begin
    FPacketBuff.PutPacket(apRec, aSize);
  end
end;

procedure TBridgeManager.StopSimulation;
begin

end;

procedure TBridgeManager.ServerReceive_ClientManagement(apRec: PAnsiChar;
  aSize: Integer; sender: TWSocketClient);
var
  i, j: Integer;

  aRec: ^TRecData2DOrder;
  RecSend: TRecData2DOrder;

  IpToSend: string;
  PortToSend: string;
  Client: TWSocketClient;
  pBuff: PAnsiChar;
  pid: ^TPacketCheck;
  pSize: Word;
  pc: TPacketCheck;
begin
  aRec := @apRec^;

  if Assigned(OnLogPacket) then
  begin
    OnLogPacket('Received : ' + C_REC_PACKETNAME[aRec.pc.ID]);
//    OnLogPacket('OrderID : ' + IntToStr(aRec.orderID));
//    OnLogPacket('numValue : ' + IntToStr(aRec.numValue));
//    OnLogPacket('strValue : ' + aRec.strValue);
//    OnLogPacket('strValue2 : ' + aRec.strValue2);
//    OnLogPacket('strValue3 : ' + aRec.strValue3);
//    OnLogPacket('ipConsole : ' + aRec.ipConsole);
  end;

  case aRec.orderID of
    _CM_CLIENT_MANAGE:
      begin
        case aRec.numValue of
          __CM_CLIENT_RESTARTALLCOMM, __CM_CLIENT_SHUTDOWNALLCOM,
            __CM_CLIENT_RESTARTSERVERCOMM, __CM_CLIENT_SHUTDOWNSERVERCOMM,
            __CM_CLIENT_CLOSEALLCOM:
            begin
              RecSend.orderID := aRec.orderID;
              RecSend.numValue := aRec.numValue;
              RecSend.strValue := '';
              RecSend.strValue2 := '';
              RecSend.strValue3 := '';
              RecSend.ipConsole := '';
              TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
            end;

          __CM_CLIENT_CONNECT:
            begin
              IpToSend := sender.GetPeerAddr;
              PortToSend := sender.GetPeerPort;

              for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
              begin
                Client := TcpServer.WSocketServer.Client[i];
                if (Client.GetPeerAddr = IpToSend) and
                  (Client.GetPeerPort = PortToSend) then
                begin
                  // Send Set DB Address
                  RecSend.orderID := _CM_CLIENT_MANAGE;
                  RecSend.numValue := __CM_CLIENT_SETDB_ADDR;
                  RecSend.strValue := DBServer;
                  RecSend.strValue2 := '';
                  RecSend.strValue3 := '';
                  RecSend.ipConsole := IpToSend;
                  // Send to Launcher
                  TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);

                  // Send Set DB Address
                  RecSend.orderID := _CM_CLIENT_MANAGE;
                  RecSend.numValue := __CM_CLIENT_WELCOME;
                  RecSend.strValue := IpToSend;
                  RecSend.strValue2 := '';
                  RecSend.strValue3 := '';
                  RecSend.ipConsole := IpToSend;
                  // Send to Launcher
                  TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
                end;
              end;
            end;

          __CM_CLIENT_RESTART:
            begin
              IpToSend := aRec.ipConsole;
              for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
              begin
                Client := TcpServer.WSocketServer.Client[i];
                if Client.GetPeerAddr = IpToSend then
                begin
                  // Send Restart
                  RecSend.orderID := _CM_CLIENT_MANAGE;
                  RecSend.numValue := __CM_CLIENT_RESTART;
                  RecSend.strValue := IpToSend;
                  RecSend.strValue2 := '';
                  RecSend.strValue3 := '';
                  RecSend.ipConsole := IpToSend;

                  // Send to Launcher
                  TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
                end;
              end;
            end;

          __CM_CLIENT_SHUTDOWN:
            begin
              IpToSend := aRec.ipConsole;
              for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
              begin
                Client := TcpServer.WSocketServer.Client[i];
                if Client.GetPeerAddr = IpToSend then
                begin
                  // Send Restart
                  RecSend.orderID := _CM_CLIENT_MANAGE;
                  RecSend.numValue := __CM_CLIENT_SHUTDOWN;
                  RecSend.strValue := IpToSend;
                  RecSend.strValue2 := '';
                  RecSend.strValue3 := '';
                  RecSend.ipConsole := IpToSend;

                  // Send to Launcher
                  TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
                end;
              end;
            end;

          __CM_CLIENT_RESTART_ALL:
            begin
              // Send Restart
              RecSend.orderID := _CM_CLIENT_MANAGE;
              RecSend.numValue := __CM_CLIENT_RESTART;
              RecSend.strValue := '';
              RecSend.strValue2 := '';
              RecSend.strValue3 := '';
              RecSend.ipConsole := '';

              // Send to Launcher
              TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
            end;

          __CM_CLIENT_SHUTDOWN_ALL:
            begin
              // Send Restart
              RecSend.orderID := _CM_CLIENT_MANAGE;
              RecSend.numValue := __CM_CLIENT_SHUTDOWN;
              RecSend.strValue := '';
              RecSend.strValue2 := '';
              RecSend.strValue3 := '';
              RecSend.ipConsole := '';

              // Send to Launcher
              TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
              GameStatus := 0;
            end;
        end;
      end;

    _CM_CLIENT_APP:
      begin
        case aRec.numValue of
          __CM_CLIENT_LAUNCH, __CM_CLIENT_STOP, __CM_CLIENT_RELAUNCH:
            begin
              IpToSend := aRec.ipConsole;
              for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
              begin
                Client := TcpServer.WSocketServer.Client[i];
                if Client.GetPeerAddr = IpToSend then
                begin
                  TcpServer.SendDataEx(REC_2D_ORDER, apRec, Client);
                end
              end;
            end;

          __CM_CLIENT_LAUNCHALL:
            begin
              // Send To All Launcher
              TcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

//              CopyMemory(@pc, apRec, sizeof(TPacketCheck));
//              if (TcpClient <> nil) and (TcpClient.State in [wsConnected]) then
//                TcpClient.SendDataEx(pc.ID, apRec);

              GameStatus := 1;
              // Save ScenarioID
              LastScenarioID := StrToInt(aRec^.strValue);
            end;
        end;
      end;

    _CM_CLIENT_CHECK:
      begin
        // Send To All Launcher
        TcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

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
            OnLogPacket('Client ' + IntToStr(i) + ' Ip Adress ' +
              Client.GetPeerAddr);
          end;
        end;
      end;

    _CM_CLIENT_CHECKSCENARIOID:
      begin
        IpToSend := sender.GetPeerAddr;

        for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
        begin
          Client := TcpServer.WSocketServer.Client[i];
          if Client.GetPeerAddr = IpToSend then
          begin
            RecSend.orderID := _CM_CLIENT_CHECKSCENARIOID;
            RecSend.numValue := GameStatus;
            RecSend.strValue := IntToStr(LastScenarioID);
            RecSend.strValue2 := '';
            RecSend.strValue3 := '';
            RecSend.ipConsole := '';

            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
          end;
        end;
      end;

    _CM_REQ_SYNCPACKET:
      begin
        IpToSend := sender.GetPeerAddr;
        PortToSend := sender.GetPeerPort;

        for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
        begin
          Client := TcpServer.WSocketServer.Client[i];
          if (Client.GetPeerAddr = IpToSend) and
            (Client.GetPeerPort = PortToSend) then
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

    _CM_CLIENT_CONNECT:
      begin
        IpToSend := sender.GetPeerAddr;
        for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
        begin
          Client := TcpServer.WSocketServer.Client[i];
          if Client.GetPeerAddr = IpToSend then
          begin
            RecSend.orderID := aRec^.orderID;
            RecSend.numValue := aRec^.numValue;
            RecSend.strValue := '';
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
  aSize: Integer);
var
  pc: TPacketCheck;
  RecRecv: ^TRecSplashCANNON;
  RecRecvTorpState: ^TRec_TorpStatus;
  RecRecvStatusMessage: ^TRecMessageHandling;
  strWeapon: string;
begin
  // client socket received. server socket rebroadcast.
  // receive from 3D, send to 2D panel
  // theServer.WSocketServer.

  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
  TcpServer.SendDataEx(pc.ID, apRec, nil);

  if pc.ID = REC_STAT_CANNON_SPLASH then
  begin
    RecRecv := @apRec^;

    strWeapon := 'Unknown Cannon';
    case RecRecv^.WeaponID of
      C_DBID_CANNON40:
        strWeapon := 'Cannon 40';
      C_DBID_CANNON57:
        strWeapon := 'Cannon 57';
      C_DBID_CANNON76:
        strWeapon := 'Cannon 76';
      C_DBID_CANNON120:
        strWeapon := 'Cannon 120';
    end;

    OnLogPacket('Receive ' + strWeapon + ' Launcher ' +
      IntToStr(RecRecv^.LauncherID) + ' From Vehicle ' +
      IntToStr(RecRecv^.ShipID) + ' Splash @' + ' X : ' +
      FloatToStr(RecRecv^.PosX) + ' Y : ' + FloatToStr(RecRecv^.PosY) + ' Z : '
      + FloatToStr(RecRecv^.PosZ));
  end
  else if pc.ID = REC_RECV_TORP_STATE then
  begin
    RecRecvTorpState := @apRec^;
    OnLogPacket('Sut detect target ' + 'ShipID ' +
      IntToStr(RecRecvTorpState^.ShipID) + ' ' + ' mWeaponID  ' +
      IntToStr(RecRecvTorpState^.mWeaponID) + ' ' + 'mLauncherID ' +
      IntToStr(RecRecvTorpState^.mLauncherID) + ' ' + 'mMissileID  ' +
      IntToStr(RecRecvTorpState^.mMissileID) + ' ' + 'isFind      ' +
      IntToStr(RecRecvTorpState^.isFind));

  end
  else if pc.ID = REC_STATUS_MESSAGE then
  begin
    RecRecvStatusMessage := @apRec^;
    OnLogPacket('Receive Message' + ' ' +
      FloatToStr(RecRecvStatusMessage^.MessageID) + '-' +
      FloatToStr(RecRecvStatusMessage^.Cmd1) + '-' +
      FloatToStr(RecRecvStatusMessage^.Cmd2) + '-' +
      FloatToStr(RecRecvStatusMessage^.Cmd3) + '-' +
      FloatToStr(RecRecvStatusMessage^.Cmd4));
  end;
end;

procedure TBridgeManager.ClientRecv_3D_ShipPos(apRec: PAnsiChar;
  aSize: Integer);
var
  aRec: ^TRecData3DPosition;
  // RecSend : TRecDataPosition;
begin
  // Receive From 3D Server.
  aRec := @apRec^;

  if Assigned(OnLogClient3D) then
    OnLogClient3D('Receive Ship Position ' + 'X:' + FloatToStr(aRec^.x) + '--' +
      'Y:' + FloatToStr(aRec^.y) + '--' + 'Z:' + FloatToStr(aRec^.z));

  if IsNan(aRec^.x) or IsNan(aRec^.y) or IsNan(aRec^.z) or IsNan(aRec^.Heading)
    or IsNan(aRec^.Speed) or IsNan(aRec^.pitch) or IsNan(aRec^.roll) or
    IsNan(aRec^.rudder) then
  begin
    LogFile.Log('ERROR', 'RECEIVE NAN POS');

    if Assigned(OnLogPacket) then
      OnLogPacket('ERROR RECEIVE NAN POS');
  end
  else
  begin
    TcpServer.SendDataEx(aRec.pc.ID, apRec, nil);
  end;
end;

procedure TBridgeManager.CloseOneServer2DClient;
var
  aClientConn: TWSocketClient;
begin
  if TcpServer.WSocketServer.ClientCount>0 then begin
    aClientConn:= TcpServer.WSocketServer.Client[TcpServer.WSocketServer.ClientCount - 1];
    if Assigned(aClientConn) and TcpServer.WSocketServer.IsClient(aClientConn) then
      aClientConn.Close
  end;
end;

procedure TBridgeManager.ClientRecv_3D_MissilePos(apRec: PAnsiChar;
  aSize: Integer);
var
  aRec: ^TRec3DMissilePos;
begin
  // Receive From 3D Server
  aRec := @apRec^;

  if Assigned(OnLogClient3D) then
    OnLogClient3D('Receive Missile Position ' + 'X:' + FloatToStr(aRec^.x) +
      '--' + 'Y:' + FloatToStr(aRec^.y) + '--' + 'Z:' + FloatToStr(aRec^.z));

  if IsNan(aRec^.x) or IsNan(aRec^.y) or IsNan(aRec^.z) or IsNan(aRec^.Heading)
    or IsNan(aRec^.Speed) then
  begin
    LogFile.Log('ERROR', 'RECEIVE NAN POS');

    if Assigned(OnLogPacket) then
      OnLogPacket('ERROR RECEIVE NAN POS');
  end
  else
  begin
    if (aRec^.status = ST_MISSILE_LOADED) or (aRec^.status = ST_MISSILE_DEL) or
      (aRec^.status = ST_MISSILE_LOCK) or (aRec^.status = ST_MISSILE_UNLOCK)
    then
    begin
      FPacketBuff.PutPacket(apRec, aSize);
    end;

    TcpServer.SendDataEx(aRec.pc.ID, apRec, nil);
  end;
end;

procedure TBridgeManager.ClientRecv_3D_Order(apRec: PAnsiChar; aSize: Integer);
var
  aRec: ^TRecData3DOrder;
begin
  aRec := @apRec^;
  TcpServer.SendDataEx(aRec.pc.ID, apRec, nil);
end;

end.
