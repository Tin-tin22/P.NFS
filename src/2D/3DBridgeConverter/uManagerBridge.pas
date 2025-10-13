unit uManagerBridge;

interface
uses
  Classes, ExtCtrls, Windows, SysUtils, uTCPServer, uTCPDatatype, overbyteicsWSocketS,
  uBridgeSet, uNetLinkServer, uData3DConverter, uDataType;
type
  TConnectStatus = procedure (const sl: TStringList) of Object;

  TBridgeManager = class
  private
    //setting
    bridgeSet     :  TRecBridgeSet;
    bridgeSetPath : string;
    FNetLinkServer_OnClientStatus: TConnectStatus;
    FONetLinkServer_OnClientStatus: TConnectStatus;
    FONetLinkServer_OnClientStatus2D: TGetStrProc;
    FOnLogReceived3d: TGetStrProc;
    FOnLogReceived2d: TGetStrProc;
    FOnLogListenPort2D: TGetStrProc;
    FOnLogListenPort3D: TGetStrProc;
    TimerGetPacket : TTimer;
    FLastScenarioActive : word;

    procedure OnTimerGetPacketRun(sender : TObject);

    //Event Connect & Disconnect From Client Bridge 2D
    procedure OnClient2DTCPConnect(cmd : string);
    procedure OnClient2DTCPDisconnect(cmd : string);

    procedure FNetLinkServer_OnClientConnect(const s: string);
    procedure FNetLinkServer_OnClientDisconnect(const s: string);
    procedure FOnLogReceived(const s: string);
  public
    TcpServer2D : TTCPServer;
    TcpServer3D: TNetLinkServer;

    constructor Create;
    destructor Destroy;

    procedure ListenServerBridge2D(Port: string);
    procedure ListenServerBridge3D(Port: string);
    procedure Prepare_As_ServerBridge2D;
    procedure Prepare_As_ServerBridge3D;

    procedure InitSimulation;
    procedure RunSimulation;
    procedure StopSimulation;

    procedure SetLog2DServer(aLog: TStringList);

    //event for network
    procedure Server2Drecv_Missilepos(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure ClientRecv_3D_Order(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);

    procedure Server2DReceive_Server3DSend(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure Server2DRecv_StatusGame(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);

    procedure ServerReceive_ClientManagement(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);



    //event for network 3D
    procedure RecvReqSce(AHeader: TPacketHeader; AContent: string);
    procedure NetHandler_Recv_3DStatus(AHeader: TPacketHeader; AContent: string);
    procedure ClientRecv_3D_MissilePos(AHeader: TPacketHeader; AContent: string);
    procedure ClientRecv_3D_ShipPos(AHeader: TPacketHeader; AContent: string);
    procedure ServerRecv_3D_Server2DSend(AHeader: TPacketHeader; AContent: string);

    //event Log for network 2D
    property OnLogListenPort2D : TGetStrProc read FOnLogListenPort2D write FOnLogListenPort2D;
    property OnLogReceived2D : TGetStrProc read FOnLogReceived2d write FOnLogReceived2d;
    property ONetLinkServer_OnClientStatus2D : TGetStrProc read FONetLinkServer_OnClientStatus2D write FONetLinkServer_OnClientStatus2D;

    //event Log for network 3D
    property ONetLinkServer_OnClientStatus : TConnectStatus read FONetLinkServer_OnClientStatus write FONetLinkServer_OnClientStatus;
    property OnLogReceived : TGetStrProc read FOnLogReceived3d write FOnLogReceived3d;
    property OnLogListenPort3D : TGetStrProc read FOnLogListenPort3D write FOnLogListenPort3D;
  end;
var
  BridgeManager : TBridgeManager;
implementation

uses
  Grijjy.Bson,
  Grijjy.Bson.IO,
  Grijjy.Bson.Serialization;

{ TBridgeManager }

procedure TBridgeManager.ClientRecv_3D_MissilePos(AHeader: TPacketHeader; AContent: string);
var
  incoming_data: TRecMissilePos3D;
  apRec: TRec3DMissilePos;
begin
  if Length(AContent)>0 then
  begin
    TgoBsonSerializer.Deserialize<TRecMissilePos3D>(AContent, incoming_data);

    if Assigned(OnLogReceived) then
    begin
      OnLogReceived('JSON : ' + AContent);
      OnLogReceived('TBridgeManager.ClientRecv_3D_MissilePos : REC_3D_MISSILEPOS'
             + #13#10 +'ShipID : ' + IntToStr(incoming_data.ShipID)
             + #13#10 +'X : ' + FormatFloat('0.00', incoming_data.X));
    end;

    apRec.ShipID := incoming_data.ShipID;
    apRec.WeaponID := incoming_data.WeaponID;
    apRec.launcherID := incoming_data.launcherID;
    apRec.missileID := incoming_data.missileID;
    apRec.MissileNumber := incoming_data.MissileNumber;
    apRec.status := incoming_data.status;
    apRec.x := incoming_data.x;
    apRec.y := incoming_data.y;
    apRec.z := incoming_data.z;
    apRec.heading := incoming_data.heading;
    apRec.speed := incoming_data.speed;

    TcpServer2D.SendDataEx(REC_3D_MISSILEPOS, @apRec, nil);
  end;
end;

procedure TBridgeManager.ClientRecv_3D_Order(apRec: PAnsiChar; aSize: integer;
  Sender: TWSocketClient);
begin

end;

procedure TBridgeManager.ClientRecv_3D_ShipPos(AHeader: TPacketHeader; AContent: string);
var
  incoming_data: TRecDataPosition3D;
  apRec: TRecData3DPosition;
begin
  if Length(AContent)>0 then
  begin
    TgoBsonSerializer.Deserialize<TRecDataPosition3D>(AContent, incoming_data);

    if Assigned(OnLogReceived) then
    begin
      OnLogReceived('JSON : ' + AContent);
      OnLogReceived('TBridgeManager.ClientRecv_3D_ShipPos : REC3D_POSITION'
             + #13#10 +'ShipID : ' + IntToStr(incoming_data.ShipID)
             + #13#10 +'X : ' + FormatFloat('0.00', incoming_data.X));
    end;

    apRec.ShipID := incoming_data.ShipID;
    apRec.X := incoming_data.X;
    apRec.Y := incoming_data.Y;
    apRec.Z := incoming_data.Z;
    apRec.Heading := incoming_data.Heading;
    apRec.Speed := incoming_data.Speed;
    apRec.pitch := incoming_data.pitch;
    apRec.roll := incoming_data.roll;
    apRec.rudder := incoming_data.rudder;
    TcpServer2D.SendDataEx(REC_3D_POSITION, @apRec, nil);
  end;
end;

constructor TBridgeManager.Create;
begin
  TcpServer2D := TTCPServer.Create;
  TcpServer2D.OnClientConnect := OnClient2DTCPConnect;
  TcpServer2D.OnClientDisConnect := OnClient2DTCPDisconnect;

  TcpServer3D:= TNetLinkServer.Create;
  TcpServer3D.OnClient_Connect     := FNetLinkServer_OnClientConnect;
  TcpServer3D.OnClient_DisConnect  := FNetLinkServer_OnClientDisconnect;

  TcpServer3D.OnGetStatusLog:= FOnLogReceived;
  TcpServer3D.OnGetSendLog:= FOnLogReceived;
  TcpServer3D.OnGetRecvLog:= FOnLogReceived;

  TimerGetPacket := TTimer.Create(nil);
  TimerGetPacket.Enabled  := False;
  TimerGetPacket.Interval := 30;
  TimerGetPacket.OnTimer  := OnTimerGetPacketRun;
end;

destructor TBridgeManager.Destroy;
begin
  TimerGetPacket.Free;

  TcpServer3D.DisposeOf;

  TcpServer2D.Free;
end;

procedure TBridgeManager.FNetLinkServer_OnClientConnect(const s: string);
var sl: TStringList;
begin
  if Assigned(OnLogReceived) then
    OnLogReceived(s);

  sl := TStringList.Create;
  try
    TcpServer3D.GetConnectedList(sl);

    if Assigned(ONetLinkServer_OnClientStatus) then
      ONetLinkServer_OnClientStatus(sl);
  finally
    sl.DisposeOf;
  end;
end;

procedure TBridgeManager.FNetLinkServer_OnClientDisconnect(const s: string);
var sl: TStringList;
begin
  if Assigned(OnLogReceived) then
    OnLogReceived(s);

  sl := TStringList.Create;
  try
    TcpServer3D.GetConnectedList(sl);

    if Assigned(ONetLinkServer_OnClientStatus) then
      ONetLinkServer_OnClientStatus(sl);
  finally
    sl.DisposeOf;
  end;
end;

procedure TBridgeManager.InitSimulation;
begin
  bridgeSetPath := GetSettingDirectory;

  with bridgeSet.mBridgeConverter do begin
    InitDefault_BridgeConverterConfig(bridgeSetPath, ServerBridge2DPort, ServerBridge3DPort);
  end;

  Prepare_As_ServerBridge2D;
  Prepare_As_ServerBridge3D;
end;

procedure TBridgeManager.ListenServerBridge2D(Port: string);
begin
  TcpServer2D.Listen(Port);

  if Assigned(OnLogListenPort2D) then
    OnLogListenPort2D(Port);

end;

procedure TBridgeManager.ListenServerBridge3D(Port: string);
begin
  TcpServer3D.Listen(Port);

  if Assigned(OnLogListenPort3D) then
    OnLogListenPort3D(Port);

  TimerGetPacket.Enabled := True;
end;

procedure TBridgeManager.NetHandler_Recv_3DStatus(AHeader: TPacketHeader;
  AContent: string);
var
  incoming_data: TRecStatusGame3D;
begin
  if Length(AContent)>0 then
  begin
    TgoBsonSerializer.Deserialize<TRecStatusGame3D>(AContent, incoming_data);

    if Assigned(OnLogReceived) then
    begin
      OnLogReceived('JSON : ' + AContent);
      OnLogReceived('TBridgeManager.Server2DRecv_StatusGame : REC_STATUS_GAME'
             + #13#10 +'ScenarioID : ' + IntToStr(incoming_data.ScenarioID)
             + #13#10 +'StatusConnect : ' + IntToStr(incoming_data.StatusConnect));
    end;
  end;

end;

procedure TBridgeManager.OnClient2DTCPConnect(cmd: string);
begin
  if Assigned(ONetLinkServer_OnClientStatus2D) then
    ONetLinkServer_OnClientStatus2D('Client ' + cmd + ' Connected');
end;

procedure TBridgeManager.OnClient2DTCPDisconnect(cmd: string);
begin
  if Assigned(ONetLinkServer_OnClientStatus2D) then
    ONetLinkServer_OnClientStatus2D('Client ' + cmd + ' Disconnected');
end;

procedure TBridgeManager.OnTimerGetPacketRun(sender: TObject);
begin
  TimerGetPacket.Enabled:= False;
  try
    TcpServer3D.GetPacket;
  finally
    TimerGetPacket.Enabled:= True;
  end;
end;

procedure TBridgeManager.FOnLogReceived(const s: string);
begin
  if Assigned(OnLogReceived) then
    OnLogReceived(s);
end;

procedure TBridgeManager.Prepare_As_ServerBridge2D;
begin
  //Receive Scenario id
  TcpServer2D.RegisterProcedure(REC_STATUS_GAME , Server2DRecv_StatusGame, SizeOf(TRecStatusGame));
  TcpServer2D.RegisterProcedure(REC_2D_ORDER,           ServerReceive_ClientManagement , sizeof(TRecData2DOrder));
  //For Weapon
  TcpServer2D.RegisterProcedure(REC_3D_EXOCET,        Server2DReceive_Server3DSend, sizeof(TRecSetExocet));
  TcpServer2D.RegisterProcedure(REC_3D_ASROCK,        Server2DReceive_Server3DSend, sizeof(TRec3DSetAsrock));
  TcpServer2D.RegisterProcedure(REC_3D_RBU,           Server2DReceive_Server3DSend, sizeof(TRec3DSetRBU));
  TcpServer2D.RegisterProcedure(REC_3D_TORPEDO_SUT,   Server2DReceive_Server3DSend, sizeof(TRecSetTorpedoSUT));
  TcpServer2D.RegisterProcedure(REC_SPSS_ORDER,       Server2DReceive_Server3DSend, SizeOf(TRecDataTorperdo));
  TcpServer2D.RegisterProcedure(C_REC_CANNON,         Server2DReceive_Server3DSend, SizeOf(TRec3DSetWCC));
  TcpServer2D.RegisterProcedure(REC_CMD_TETRAL,       Server2DReceive_Server3DSend, SizeOf(TRec3DSetTetral));
  TcpServer2D.RegisterProcedure(REC_CMD_MISTRAL,      Server2DReceive_Server3DSend, SizeOf(TRec3DSetMistral));
  TcpServer2D.RegisterProcedure(REC_CMD_STRELLA,      Server2DReceive_Server3DSend, SizeOf(TRec3DSetStrella));
  TcpServer2D.RegisterProcedure(REC_DATA_Yakhont,     Server2DReceive_Server3DSend, SizeOf(TRecData_YAkhont));
  TcpServer2D.RegisterProcedure(REC_DATA_C802,        Server2DReceive_Server3DSend, SizeOf(TRecData_C802));
  TcpServer2D.RegisterProcedure(REC_CMD_EXOCET_40,    Server2DReceive_Server3DSend, SizeOf(TRec3DSetExocet_40));
  TcpServer2D.RegisterProcedure(REC_SET_CHAFF,        Server2DReceive_Server3DSend, sizeof(TRecSetChaff));
  TcpServer2D.RegisterProcedure(REC_SET_ASROCK,       Server2DReceive_Server3DSend, sizeof(TRecSetAsrock));
  TcpServer2D.RegisterProcedure(REC_3D_TORPEDO_MK44,  Server2DReceive_Server3DSend, sizeof(TRecTorpedoMK44Order));
  TcpServer2D.RegisterProcedure(REC_3D_WCC,           Server2DReceive_Server3DSend, SizeOf(TRec3DSetWCC));

  //For Position
  TcpServer2D.RegisterProcedure(REC_3D_MISSILEPOS,      Server2DReceive_Server3DSend , sizeof(TRec3DMissilePos));
  TcpServer2D.RegisterProcedure(REC_3D_POSITION,        Server2DReceive_Server3DSend ,    sizeOf(TRecData3DPosition));
  TcpServer2D.RegisterProcedure(REC_STAT_CANNON_SPLASH, Server2DReceive_Server3DSend,  SizeOf(TRecSplashCANNON));

  //For Utility
  TcpServer2D.RegisterProcedure(REC_3D_ORDER,           Server2DReceive_Server3DSend, sizeof(TRecData3DOrder));
  TcpServer2D.RegisterProcedure(REC_RECV_TORP_STATE,    Server2DReceive_Server3DSend, sizeof(TRec_TorpStatus));
  TcpServer2D.RegisterProcedure(REC_3D_SETCONTROL,      Server2DReceive_Server3DSend, sizeOf(spActorsController));
  TcpServer2D.RegisterProcedure(REC_3D_UTIL_TOOLS,      Server2DReceive_Server3DSend, sizeOf(spUtilityTools));
  TcpServer2D.RegisterProcedure(REC_STATUS_MESSAGE,     Server2DReceive_Server3DSend, SizeOf(TRecMessageHandling));

  //GUIDANCE VEHICLE
  TcpServer2D.RegisterProcedure(REC_GUIDANCE,         Server2DReceive_Server3DSend, SizeOf(TRecGuidance));
end;

procedure TBridgeManager.Prepare_As_ServerBridge3D;
begin
  TcpServer3D.RegisterProcedure(REC_SCEID, RecvReqSce);
  TcpServer3D.RegisterProcedure(REC3D_STATUS_GAME, NetHandler_Recv_3DStatus);

  //for weapon
  TcpServer3D.RegisterProcedure(REC_3D_EXOCET,        nil);
  TcpServer3D.RegisterProcedure(REC_3D_ASROCK,        nil);
  TcpServer3D.RegisterProcedure(REC_3D_RBU,           nil);
  TcpServer3D.RegisterProcedure(REC_3D_TORPEDO_SUT,   nil);
  TcpServer3D.RegisterProcedure(REC_SPSS_ORDER,       nil);
  TcpServer3D.RegisterProcedure(C_REC_CANNON,         nil);
  TcpServer3D.RegisterProcedure(REC_CMD_TETRAL,       nil);
  TcpServer3D.RegisterProcedure(REC_CMD_MISTRAL,      nil);
  TcpServer3D.RegisterProcedure(REC_CMD_STRELLA,      nil);
  TcpServer3D.RegisterProcedure(REC_CMD_MISTRAL,      nil);
  TcpServer3D.RegisterProcedure(REC_DATA_Yakhont,     nil);
  TcpServer3D.RegisterProcedure(REC_DATA_C802,        nil);
  TcpServer3D.RegisterProcedure(REC_CMD_EXOCET_40,    nil);

  //For Position
  TcpServer3D.RegisterProcedure(REC3D_POSITION, ClientRecv_3D_ShipPos);
  TcpServer3D.RegisterProcedure(REC_3D_MISSILEPOS, ClientRecv_3D_MissilePos);
  TcpServer3D.RegisterProcedure(REC_STAT_CANNON_SPLASH, ServerRecv_3D_Server2DSend);

  //For Utility
  TcpServer3D.RegisterProcedure(REC_3D_ORDER,           ServerRecv_3D_Server2DSend);
  TcpServer3D.RegisterProcedure(REC_RECV_TORP_STATE,    ServerRecv_3D_Server2DSend);
  TcpServer3D.RegisterProcedure(REC_3D_SETCONTROL,      nil);
  TcpServer3D.RegisterProcedure(REC_3D_UTIL_TOOLS,      ServerRecv_3D_Server2DSend);
  TcpServer3D.RegisterProcedure(REC_STATUS_MESSAGE,     ServerRecv_3D_Server2DSend);
end;

procedure TBridgeManager.Server2DReceive_Server3DSend(apRec: PAnsiChar;
  aSize: integer; Sender: TWSocketClient);
var
  pc: TPacketCheck;
  RecRecv : ^TRecSplashCannon;
  RecRecvTorpState : ^TRec_TorpStatus;
  RecRecvStatusMessage : ^TRecMessageHandling;
  RecvData3DOrder : ^TRecData3DOrder;
  RecSendData3DOrder : TRecData3DOrder3D;
  strWeapon : string;

  Recv2dMissilePos : ^TRec3DMissilePos;
  RecSendMissilePos : TRecMissilePos3D;

  Recv2DPos : ^TRecData3DPosition;
  RecSend2DPositionTo3D: TRecDataPosition3D;

  RecvRecMeriam : ^TRec3DSetWCC;
  RecSendMeriamTo3D : TRec3DSetWCC3D;

  recTorpedoSut : ^TRecSetTorpedoSUT;
  recSenTorpedoSut : TRecSetTorpedoSUT3D;

  recRBU        : ^TRec3DSetRBU;
  recSendRBU    : TRec3DSetRBU3D;

  recExocet     : ^TRec3DSetExocet;
  recSendExocet : TRecSetExocet3D;

  recASROC      : ^TRec3DSetAsrock;
  recSendASROC  : TRec3DSetAsrock3D;

  recA244       : ^TRecDataTorperdo;
  recSendA244   : TRecDataTorperdo3D;

  recYAHKONT    : ^TRecData_Yakhont;
  recSendYahkont: TRecData_Yakhont3D;

  recC802       : ^TRecData_C802;
  recSendC802   : TRecData_C8023D;

  recExocetMM40 : ^TRec3DSetExocet_40;
  recSendExocetMM40 : TRecSetExocet3D_40;

  recTetral     : ^TRec3DSetTetral;
  recSendTetral : TRec3DSetTetral3D;

  recActorController3d : ^spActorsController;
  recSendActorController3d :  spActorsController3D;

  recUtilityTools : ^spUtilityTools;
  recSendUtiityTools : spUtilityTools3D;

  recGuidance : ^TRecGuidance;
  recSendGuidance : TRecGuidance3D;

  recSetChaff : ^TRecSetChaff;
  recSendChaff : TRec3DSetChaff3D;

  recTorpedoMK44order : ^TRecTorpedoMK44Order;
  recSendTorpedoMk44Order : TRecTorpedoMK44Order3D;

  RecMistral : ^TRec3DSetMistral;
  RecSendMistral : TRec3DSetMistral3D;

  RecStrella : ^TRec3DSetStrella;
  recSendStrella : TRec3DSetStrella3D;
begin
  // client socket received. server socket rebroadcast.
  // receive from 3D, send to 3D panel
  // theServer.WSocketServer.

  CopyMemory(@pc, apRec, sizeof(TPacketCheck));
//  tcpServer.SendDataEx(pc.ID, apRec, nil);

  case pc.ID of
    REC_3D_TORPEDO_SUT:
    begin
      recTorpedoSut := @apRec^;
      recSenTorpedoSut.ShipID          := recTorpedoSut^.ShipID;
      recSenTorpedoSut.mWeaponID       := recTorpedoSut^.mWeaponID; //Diisi sesuai Database
      recSenTorpedoSut.mLauncherID     := recTorpedoSut^.mLauncherID;
      recSenTorpedoSut.mMissileID      := recTorpedoSut^.mMissileID;
      recSenTorpedoSut.mMissileNumber  := recTorpedoSut^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang
      recSenTorpedoSut.mT_ID           := recTorpedoSut^.mT_ID;
      recSenTorpedoSut.OrderID         := recTorpedoSut^.OrderID;

      recSenTorpedoSut.mTorpedoCourse        := recTorpedoSut^.mTorpedoCourse;
      recSenTorpedoSut.mTorpedoSpeed         := recTorpedoSut^.mTorpedoSpeed;
      recSenTorpedoSut.mTorpedoDepth         := recTorpedoSut^.mTorpedoDepth;
      recSenTorpedoSut.mTorpedoSafeDistance  := recTorpedoSut^.mTorpedoSafeDistance;
      recSenTorpedoSut.mTorpedoEnDis         := recTorpedoSut^.mTorpedoEnDis;
      recSenTorpedoSut.mpredm                := recTorpedoSut^.mpredm;
      recSenTorpedoSut.mTargetType           := recTorpedoSut^.mTargetType;

      TcpServer3D.SendData(REC_3D_TORPEDO_SUT, recSenTorpedoSut);
    end;
    REC_3D_RBU:
    begin
      recRBU := @apRec^;

      recSendRBU.ShipID := recRBU^.ShipID;
      recSendRBU.mWeaponID      := recRBU^.mWeaponID;  // Diisi sesuai Database
      recSendRBU.mLauncherID    := recRBU^.mLauncherID;
      recSendRBU.mMissileID     := recRBU^.mMissileID;
      recSendRBU.mMissileNumber := recRBU^.mMissileNumber;  // Diisi 0 aj...nanti instruktur yang ngisi ulang
      recSendRBU.mCount         := recRBU^.mCount;
      recSendRBU.mMissileType   := recRBU^.mMissileType;
      recSendRBU.mTargetID      := recRBU^.mTargetID;  // Added by bagoes
      recSendRBU.OrderID        := recRBU^.OrderID;

      recSendRBU.mLncrBearing   := recRBU^.mLncrBearing;
      recSendRBU.mLncRange      := recRBU^.mLncRange;
      recSendRBU.mTargetDepth   := recRBU^.mTargetDepth;
      recSendRBU.mCorrBearing   := recRBU^.mCorrBearing;
      recSendRBU.mCorrElev      := recRBU^.mCorrElev;

      TcpServer3D.SendData(REC_3D_RBU, recSendRBU);
    end;
    REC_SPSS_ORDER:
    begin
      recA244 := @apRec^;
      recSendA244.ShipID := recA244^.ShipID;
      recSendA244.mWeaponID       := recA244^.mWeaponID; //Diisi sesuai Database
      recSendA244.mLauncherID     := recA244^.mLauncherID;
      recSendA244.mMissileID      := recA244^.mMissileID;
      recSendA244.mMissileNumber  := recA244^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang

      recSendA244.OrderID     := recA244^.OrderID;

      recSendA244.ISC := recA244^.ISC;
      recSendA244.ISR := recA244^.ISR;
      recSendA244.WTR := recA244^.WTR;             //(0: SH, 1 :DP);
      recSendA244.CEI := recA244^.CEI;
      recSendA244.PRG := recA244^.PRG;             //(0: HE, 1 :SP)
      recSendA244.DOP := recA244^.DOP;             //(0: CW, 1 :FM)
      recSendA244.ACE := recA244^.ACE;
      recSendA244.FLO := recA244^.FLO;
      recSendA244.ISD := recA244^.ISD;
      recSendA244.ACM := recA244^.ACM;

      TcpServer3D.SendData(REC_SPSS_ORDER, recSendA244);
    end;
    REC_3D_EXOCET:
    begin
      recExocet := @apRec^;
      recSendExocet.shipID          := recExocet^.shipID;
      recSendExocet.mWeaponID       := recExocet^.mWeaponID; //Diisi sesuai Database
      recSendExocet.mLauncherID     := recExocet^.mLauncherID;
      recSendExocet.mMissileID      := recExocet^.mMissileID;
      recSendExocet.mMissileNumber  := recExocet^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang

      recSendExocet.sOrder          := recExocet^.sOrder;

      recSendExocet.mProxFuze       := recExocet^.mProxFuze;
      recSendExocet.mAltitude       := recExocet^.mAltitude;
      recSendExocet.mSearchArea     := recExocet^.mSearchArea;
      recSendExocet.mRTG            := recExocet^.mRTG;
      recSendExocet.mManualWidth    := recExocet^.mManualWidth;
      recSendExocet.mSelecDepth     := recExocet^.mSelecDepth;
      recSendExocet.mTBearing       := recExocet^.mTBearing;
      recSendExocet.mTRange         := recExocet^.mTRange;

      TcpServer3D.SendData(REC_3D_EXOCET, recSendExocet);
    end;
    REC_3D_ASROCK:
    begin
      recASROC := @apRec^;
      recSendASROC.ShipID          := recASROC^.ShipID;
      recSendASROC.mWeaponID       := recASROC^.mWeaponID;       //  Diisi sesuai Database
      recSendASROC.mLauncherID     := recASROC^.mLauncherID;
      recSendASROC.mMissileID      := recASROC^.mMissileID;
      recSendASROC.mMissileNumber  := recASROC^.mMissileNumber;       //  Diisi 0 aj...nanti instruktur yang ngisi ulang
      recSendASROC.mMissile_Type   := recASROC^.mMissile_Type;       //  add by eka
      recSendASROC.mTargetID       := recASROC^.mTargetID;       //  Added by bagoes
      recSendASROC.OrderID         := recASROC^.OrderID;
      recSendASROC.mTargetBearing  := recASROC^.mTargetBearing;
      recSendASROC.mTargetRange    := recASROC^.mTargetRange;
      recSendASROC.mTargetDepth    := recASROC^.mTargetDepth;
      recSendASROC.mFuzeType       := recASROC^.mFuzeType;       //  0: time   1 : prox

      recSendASROC.mCorrRange      := recASROC^.mCorrRange;

      TcpServer3D.SendData(REC_3D_ASROCK, recSendASROC);
    end;
    C_REC_CANNON:
    begin
      RecvRecMeriam := @apRec^;
      if Assigned(OnLogReceived2D) then
      OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : C_REC_CANNON'
                 + #13#10 +'shipID : ' + IntToStr(RecvRecMeriam^.ShipID)
                 + #13#10 +'mWeaponID : ' + IntToStr(RecvRecMeriam^.mWeaponID)
                 + #13#10 +'mLauncherID : ' + FloatToStr(RecvRecMeriam^.mLauncherID)
                 + #13#10 +'mMissileID : ' + FloatToStr(RecvRecMeriam^.mMissileID)
                 + #13#10 +'mMissileNumber : ' + FloatToStr(RecvRecMeriam^.mMissileNumber)
                 + #13#10 +'mOrderID : ' + FloatToStr(RecvRecMeriam^.mOrderID)
                 + #13#10 +'mTargetID : ' + FloatToStr(RecvRecMeriam^.mTargetID)
                 + #13#10 +'mModeID : ' + FloatToStr(RecvRecMeriam^.mModeID)
                 + #13#10 +'mUpDown : ' + FloatToStr(RecvRecMeriam^.mUpDown)
                 + #13#10 +'mAutoCorrectElev : ' + FloatToStr(RecvRecMeriam^.mAutoCorrectElev)
                 + #13#10 +'mAutoCorrectBearing : ' + FloatToStr(RecvRecMeriam^.mAutoCorrectBearing)
                 + #13#10 +'mBalistikID : ' + FloatToStr(RecvRecMeriam^.mBalistikID)
                 + #13#10 +'mSalvoRate : ' + FloatToStr(RecvRecMeriam^.mSalvoRate));

      RecSendMeriamTo3D.shipID := RecvRecMeriam^.shipID;
      RecSendMeriamTo3D.mWeaponID := RecvRecMeriam^.mWeaponID;
      RecSendMeriamTo3D.mLauncherID := RecvRecMeriam^.mLauncherID;
      RecSendMeriamTo3D.mMissileID := RecvRecMeriam^.mMissileID;
      RecSendMeriamTo3D.mMissileNumber := RecvRecMeriam^.mMissileNumber;
      RecSendMeriamTo3D.mOrderID := RecvRecMeriam^.mOrderID;
      RecSendMeriamTo3D.mTargetID := RecvRecMeriam^.mTargetID;

      RecSendMeriamTo3D.mModeID := RecvRecMeriam^.mModeID;
      RecSendMeriamTo3D.mUpDown := RecvRecMeriam^.mUpDown;
      RecSendMeriamTo3D.mAutoCorrectElev := RecvRecMeriam^.mAutoCorrectElev;
      RecSendMeriamTo3D.mAutoCorrectBearing := RecvRecMeriam^.mAutoCorrectBearing;
      RecSendMeriamTo3D.mBalistikID := RecvRecMeriam^.mBalistikID;
      RecSendMeriamTo3D.mSalvoRate := RecvRecMeriam^.mSalvoRate;
      TcpServer3D.SendData(C_REC_CANNON, RecSendMeriamTo3D);
    end;
    REC_3D_WCC:
    begin
      RecvRecMeriam := @apRec^;
      if Assigned(OnLogReceived2D) then
      OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : C_REC_CANNON'
                 + #13#10 +'shipID : ' + IntToStr(RecvRecMeriam^.ShipID)
                 + #13#10 +'mWeaponID : ' + IntToStr(RecvRecMeriam^.mWeaponID)
                 + #13#10 +'mLauncherID : ' + FloatToStr(RecvRecMeriam^.mLauncherID)
                 + #13#10 +'mMissileID : ' + FloatToStr(RecvRecMeriam^.mMissileID)
                 + #13#10 +'mMissileNumber : ' + FloatToStr(RecvRecMeriam^.mMissileNumber)
                 + #13#10 +'mOrderID : ' + FloatToStr(RecvRecMeriam^.mOrderID)
                 + #13#10 +'mTargetID : ' + FloatToStr(RecvRecMeriam^.mTargetID)
                 + #13#10 +'mModeID : ' + FloatToStr(RecvRecMeriam^.mModeID)
                 + #13#10 +'mUpDown : ' + FloatToStr(RecvRecMeriam^.mUpDown)
                 + #13#10 +'mAutoCorrectElev : ' + FloatToStr(RecvRecMeriam^.mAutoCorrectElev)
                 + #13#10 +'mAutoCorrectBearing : ' + FloatToStr(RecvRecMeriam^.mAutoCorrectBearing)
                 + #13#10 +'mBalistikID : ' + FloatToStr(RecvRecMeriam^.mBalistikID)
                 + #13#10 +'mSalvoRate : ' + FloatToStr(RecvRecMeriam^.mSalvoRate));

      RecSendMeriamTo3D.shipID := RecvRecMeriam^.shipID;
      RecSendMeriamTo3D.mWeaponID := RecvRecMeriam^.mWeaponID;
      RecSendMeriamTo3D.mLauncherID := RecvRecMeriam^.mLauncherID;
      RecSendMeriamTo3D.mMissileID := RecvRecMeriam^.mMissileID;
      RecSendMeriamTo3D.mMissileNumber := RecvRecMeriam^.mMissileNumber;
      RecSendMeriamTo3D.mOrderID := RecvRecMeriam^.mOrderID;
      RecSendMeriamTo3D.mTargetID := RecvRecMeriam^.mTargetID;

      RecSendMeriamTo3D.mModeID := RecvRecMeriam^.mModeID;
      RecSendMeriamTo3D.mUpDown := RecvRecMeriam^.mUpDown;
      RecSendMeriamTo3D.mAutoCorrectElev := RecvRecMeriam^.mAutoCorrectElev;
      RecSendMeriamTo3D.mAutoCorrectBearing := RecvRecMeriam^.mAutoCorrectBearing;
      RecSendMeriamTo3D.mBalistikID := RecvRecMeriam^.mBalistikID;
      RecSendMeriamTo3D.mSalvoRate := RecvRecMeriam^.mSalvoRate;
      TcpServer3D.SendData(REC_3D_WCC, RecSendMeriamTo3D);
    end;
    REC_DATA_Yakhont :
    begin
      recYAHKONT := @apRec^;
      recSendYahkont.ShipID          := recYAHKONT^.ShipID;
      recSendYahkont.mWeaponID       := recYAHKONT^.mWeaponID; //Diisi sesuai Database
      recSendYahkont.mLauncherID     := recYAHKONT^.mLauncherID;
      recSendYahkont.mMissileID      := recYAHKONT^.mMissileID;
      recSendYahkont.mMissileNumber  := recYAHKONT^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulan

      recSendYahkont.mMissile1       := recYAHKONT^.mMissile1;
      recSendYahkont.mMissile2       := recYAHKONT^.mMissile2;
      recSendYahkont.mMissile3       := recYAHKONT^.mMissile3;
      recSendYahkont.mMissile4       := recYAHKONT^.mMissile4;

      recSendYahkont.OrderID         := recYAHKONT^.OrderID;

      recSendYahkont.mTargetBearing  := recYAHKONT^.mTargetBearing;
      recSendYahkont.mTargetRange    := recYAHKONT^.mTargetRange;

      TcpServer3D.SendData(REC_DATA_Yakhont, recSendYahkont);
    end;
    REC_DATA_C802 :
    begin
      recC802 := @apRec^;
      recSendC802.ShipID          := recC802^.ShipID;
      recSendC802.mWeaponID       := recC802^.mWeaponID; //Diisi sesuai Database
      recSendC802.mLauncherID     := recC802^.mLauncherID;
      recSendC802.mMissileID      := recC802^.mMissileID;
      recSendC802.mMissileNumber  := recC802^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulan

      recSendC802.OrderID         := recC802^.OrderID;

      recSendC802.mTargetBearing  := recC802^.mTargetBearing;
      recSendC802.mTargetRange    := recC802^.mTargetRange;
      TcpServer3D.SendData(REC_DATA_C802, recSendC802);
    end;
    REC_CMD_EXOCET_40 :
    begin
      recExocetMM40 := @apRec^;
      recSendExocetMM40.shipID            := recExocetMM40^.shipID;
      recSendExocetMM40.mWeaponID         := recExocetMM40^.mWeaponID;
      recSendExocetMM40.mLauncherID       := recExocetMM40^.mLauncherID;
      recSendExocetMM40.mMissileID        := recExocetMM40^.mMissileID;
      recSendExocetMM40.mMissileNumber    := recExocetMM40^.mMissileNumber;

      recSendExocetMM40.sOrder            := recExocetMM40^.sOrder;

      recSendExocetMM40.mTRange           := recExocetMM40^.mTRange;
      recSendExocetMM40.mTBearing         := recExocetMM40^.mTBearing;

      recSendExocetMM40.mAngular_Mode     := recExocetMM40^.mAngular_Mode;
      recSendExocetMM40.mAgility_Mode     := recExocetMM40^.mAgility_Mode;
      recSendExocetMM40.mInitialStep_Mode := recExocetMM40^.mInitialStep_Mode;

      recSendExocetMM40.mObstacle_Alt     := recExocetMM40^.mObstacle_Alt;
      recSendExocetMM40.mObstacle_Range   := recExocetMM40^.mObstacle_Range;

      recSendExocetMM40.mApproach_Range   := recExocetMM40^.mApproach_Range;
      recSendExocetMM40.mTerminal_Range   := recExocetMM40^.mTerminal_Range;

      recSendExocetMM40.mLeft_Angle       := recExocetMM40^.mLeft_Angle;
      recSendExocetMM40.mRight_Angle      := recExocetMM40^.mRight_Angle;
      recSendExocetMM40.mFar_Range        := recExocetMM40^.mFar_Range;
      recSendExocetMM40.mNear_Range       := recExocetMM40^.mNear_Range;

      recSendExocetMM40.mMasking1         := recExocetMM40^.mMasking1;
      recSendExocetMM40.mMasking2         := recExocetMM40^.mMasking2;
      recSendExocetMM40.mMasking3         := recExocetMM40^.mMasking3;
      recSendExocetMM40.mMasking4         := recExocetMM40^.mMasking4;
      recSendExocetMM40.mMasking5         := recExocetMM40^.mMasking5;
      recSendExocetMM40.mMasking6         := recExocetMM40^.mMasking6;
      recSendExocetMM40.mMasking7         := recExocetMM40^.mMasking7;
      recSendExocetMM40.mMasking8         := recExocetMM40^.mMasking8;
      recSendExocetMM40.mMasking9         := recExocetMM40^.mMasking9;
      recSendExocetMM40.mMasking10        := recExocetMM40^.mMasking10;
      recSendExocetMM40.mMasking11        := recExocetMM40^.mMasking11;
      recSendExocetMM40.mMasking12        := recExocetMM40^.mMasking12;
      recSendExocetMM40.mMasking13        := recExocetMM40^.mMasking13;
      recSendExocetMM40.mMasking14        := recExocetMM40^.mMasking14;
      recSendExocetMM40.mMasking15        := recExocetMM40^.mMasking15;
      recSendExocetMM40.mMasking16        := recExocetMM40^.mMasking16;
      recSendExocetMM40.mSeekerOpenPosX   := recExocetMM40^.mSeekerOpenPosX;
      recSendExocetMM40.mSeekerOpenPosY   := recExocetMM40^.mSeekerOpenPosY;
      recSendExocetMM40.mSeekerOpenHeading   := recExocetMM40^.mSeekerOpenHeading;

      TcpServer3D.SendData(REC_CMD_EXOCET_40, recSendExocetMM40);
    end;
    REC_CMD_TETRAL :
    begin
      recTetral := @apRec^;
      recSendTetral.ShipID := recTetral^.ShipID;
      recSendTetral.mLauncherID     := recTetral^.mLauncherID;
      recSendTetral.mMissileID      := recTetral^.mMissileID;
      recSendTetral.mMissileNumber  := recTetral^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang

      recSendTetral.OrderID         := recTetral^.OrderID;

      recSendTetral.mTargetBearing  := recTetral^.mTargetBearing;
      recSendTetral.mTargetRange    := recTetral^.mTargetRange;
      recSendTetral.mTargetElev     := recTetral^.mTargetElev;

      TcpServer3D.SendData(REC_CMD_TETRAL, recSendTetral);
    end;
    REC_3D_UTIL_TOOLS :
    begin
      recUtilityTools := @apRec^;
      recSendUtiityTools.OrderID := recUtilityTools^.OrderID;
      recSendUtiityTools.c0 := recUtilityTools^.c0;
      recSendUtiityTools.c1 := recUtilityTools^.c1;
      recSendUtiityTools.c2 := recUtilityTools^.c2;
      recSendUtiityTools.c3 := recUtilityTools^.c3;
      recSendUtiityTools.c4 := recUtilityTools^.c4;        //For Camera -> //co  = shipID, c1 =
      recSendUtiityTools.c5 := recUtilityTools^.c5;
      recSendUtiityTools.c6 := recUtilityTools^.c6;
      TcpServer3D.SendData(REC_3D_UTIL_TOOLS, recSendUtiityTools);
    end;
    REC_3D_SETCONTROL :
    begin
      recActorController3d := @apRec^;
      recSendActorController3d.ShipID := recActorController3d^.ShipID;
      recSendActorController3d.TypeID := recActorController3d^.TypeID;

      recSendActorController3d.ActorRuntimeID1 := recActorController3d^.ActorRuntimeID1;   //Weapon ID
      recSendActorController3d.ActorRuntimeID2 := recActorController3d^.ActorRuntimeID2;   //Launcher ID
      recSendActorController3d.ActorRuntimeID3 := recActorController3d^.ActorRuntimeID3;   //Missile ID
      recSendActorController3d.ActorRuntimeID4 := recActorController3d^.ActorRuntimeID4;   //Missile Number

      recSendActorController3d.OrderID := recActorController3d^.OrderID;
      recSendActorController3d.x := recActorController3d^.x;
      recSendActorController3d.y := recActorController3d^.y;
      recSendActorController3d.z := recActorController3d^.z;
      recSendActorController3d.h := recActorController3d^.H;
      recSendActorController3d.p := recActorController3d^.p;
      recSendActorController3d.r := recActorController3d^.r;

      TcpServer3D.SendData(REC_3D_SETCONTROL, recSendActorController3d);
    end;
    REC_3D_MISSILEPOS :
    begin
      Recv2dMissilePos := @apRec^;
      RecSendMissilePos.shipID := Recv2dMissilePos^.shipID;
      RecSendMissilePos.WeaponID      := Recv2dMissilePos^.WeaponID;
      RecSendMissilePos.launcherID    := Recv2dMissilePos^.launcherID;
      RecSendMissilePos.missileID     := Recv2dMissilePos^.missileID;
      RecSendMissilePos.MissileNumber := Recv2dMissilePos^.MissileNumber;

      RecSendMissilePos.status:= Recv2dMissilePos^.status;
      RecSendMissilePos.x:=Recv2dMissilePos^.x;
      RecSendMissilePos.y:=Recv2dMissilePos^.y;
      RecSendMissilePos.z:= Recv2dMissilePos^.z;
      RecSendMissilePos.heading:= Recv2dMissilePos^.heading;
      RecSendMissilePos.speed:= Recv2dMissilePos^.speed;

      TcpServer3D.SendData(REC_3D_MISSILEPOS, RecSendMissilePos);
    end;
    REC_3D_ORDER :
    begin
      RecvData3DOrder := @apRec^;
      if Assigned(OnLogReceived2D) then
      OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : REC_3D_ORDER'
                 + #13#10 +'shipID : ' + IntToStr(RecvData3DOrder^.shipID)
                 + #13#10 +'sOrder : ' + IntToStr(RecvData3DOrder^.sOrder)
                 + #13#10 +'mValue : ' + FloatToStr(RecvData3DOrder^.mValue)
                 + #13#10 +'ModeMove : ' + IntToStr(RecvData3DOrder^.ModeMove)
                 + #13#10 +'coordinatX : ' + FloatToStr(RecvData3DOrder^.coordinatX)
                 + #13#10 +'coordinatY : ' + FloatToStr(RecvData3DOrder^.coordinatY)
                 + #13#10 +'coordinatZ : ' + FloatToStr(RecvData3DOrder^.coordinatZ));
      RecSendData3DOrder.shipID := RecvData3DOrder^.shipID;
      RecSendData3DOrder.sOrder := RecvData3DOrder^.sOrder;
      RecSendData3DOrder.mValue := RecvData3DOrder^.mValue;
      RecSendData3DOrder.ModeMove := RecvData3DOrder^.ModeMove;
      RecSendData3DOrder.coordinatX := RecvData3DOrder^.coordinatX;
      RecSendData3DOrder.coordinatY := RecvData3DOrder^.coordinatY;
      RecSendData3DOrder.coordinatZ := RecvData3DOrder^.coordinatZ;
      TcpServer3D.SendData(REC_3D_ORDER, RecSendData3DOrder);
    end;
    REC_3D_POSITION :
    begin
      Recv2DPos := @apRec^;

      if Assigned(OnLogReceived2D) then
      OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : REC_3D_POSITION'
                 + #13#10 +'ShipID : ' + IntToStr(Recv2DPos^.ShipID)
                 + #13#10 +'X : ' + FloatToStr(Recv2DPos^.X)
                 + #13#10 +'Y : ' + FloatToStr(Recv2DPos^.Y)
                 + #13#10 +'Z : ' + FloatToStr(Recv2DPos^.Z)
                 + #13#10 +'Heading : ' + FloatToStr(Recv2DPos^.Heading)
                 + #13#10 +'Speed : ' + FloatToStr(Recv2DPos^.Speed)
                 + #13#10 +'pitch : ' + FloatToStr(Recv2DPos^.pitch)
                 + #13#10 +'roll : ' + FloatToStr(Recv2DPos^.roll)
                 + #13#10 +'rudder : ' + FloatToStr(Recv2DPos^.rudder));

      RecSend2DPositionTo3D.ShipID := Recv2DPos^.ShipID;
      RecSend2DPositionTo3D.X := Recv2DPos^.X;
      RecSend2DPositionTo3D.Y := Recv2DPos^.Y;
      RecSend2DPositionTo3D.Z := Recv2DPos^.Z;
      RecSend2DPositionTo3D.Heading := Recv2DPos^.Heading;
      RecSend2DPositionTo3D.Speed := Recv2DPos^.Speed;
      RecSend2DPositionTo3D.pitch := Recv2DPos^.pitch;
      RecSend2DPositionTo3D.roll := Recv2DPos^.roll;
      RecSend2DPositionTo3D.rudder := Recv2DPos^.rudder;
      TcpServer3D.SendData(REC3D_POSITION, RecSend2DPositionTo3D);
    end;
    REC_GUIDANCE:
    begin
      recGuidance := @apRec^;
      recSendGuidance.ShipID := recGuidance^.ShipID;
      recSendGuidance.GuidanceID:= recGuidance^.GuidanceID;         // SL     | Helm  | Circle    | Zigzag   | Sinuation | Formation | Evasion | Waypoint| Outrun | Engagement | Shadow  |
                            //====================================================================================================================
      recSendGuidance.param0    := recGuidance^.param0;       // Course | Angle | TgtID     | Course   | Course    |           | TgtID   |         | TgtID  | TgtID      | TgtID   |
      recSendGuidance.param1    := recGuidance^.param1;       // Speed  | Speed | Speed     | Speed    | Speed     |           |         |         |        | Speed      | Speed   |
      recSendGuidance.param2    := recGuidance^.param2;       //        |       | Radius    | legLgth  | Amplitude |           |         |         |        | EgmntRange | TgtRange|
      recSendGuidance.param3    := recGuidance^.param3;       //        |       | Direction |          | Period    |           |         |                  | Altitude   |
      recSendGuidance.param4    := recGuidance^.param4;       //        |       | RangeOffst|          |
      recSendGuidance.param5    := recGuidance^.param5;       //        |       | AngleOffst|          |
      recSendGuidance.param6    := recGuidance^.param6;       //        |       | AbsAglOfst|          |
      TcpServer3D.SendData(REC_GUIDANCE, recSendGuidance);
    end;
    REC_SET_CHAFF:
    begin
      recSetChaff := @apRec^;
      recSendChaff.ShipID := recSetChaff^.ShipID;
      recSendChaff.mLauncherID   := recSetChaff^.mLauncherID;
      recSendChaff.OrderID       := recSetChaff^.OrderID;
      //mCountID      : integer;
      recSendChaff.mDegreeRate   := recSetChaff^.mDegreeRate;
      recSendChaff.mPart         := recSetChaff^.mPart;
      recSendChaff.mPartNo       := recSetChaff^.mPartNo;

      TcpServer3D.SendData(REC_SET_CHAFF, recSendChaff);
    end;
    REC_3D_TORPEDO_MK44:
    begin
      recTorpedoMK44order := @apRec^;
      recSendTorpedoMk44Order.shipID := recTorpedoMK44Order^.shipID;
      recSendTorpedoMk44Order.OrderID       := recTorpedoMK44Order^.OrderID;
      recSendTorpedoMk44Order.mID           := recTorpedoMK44Order^.mID;
      recSendTorpedoMk44Order.mISD          := recTorpedoMK44Order^.mISD;
      recSendTorpedoMk44Order.mFloor        := recTorpedoMK44Order^.mFloor;
      recSendTorpedoMk44Order.mGyroRunOut   := recTorpedoMK44Order^.mGyroRunOut;

      TcpServer3D.SendData(REC_3D_TORPEDO_MK44, recSendTorpedoMk44Order);
    end;
    REC_CMD_MISTRAL:
    begin
      RecMistral := @apRec^;
      RecSendMistral.ShipID := RecMistral^.ShipID;
      RecSendMistral.mWeaponID       := RecMistral^.mWeaponID; //Diisi sesuai Database
      RecSendMistral.mLauncherID     := RecMistral^.mLauncherID;
      RecSendMistral.mMissileID      := RecMistral^.mMissileID;
      RecSendMistral.mMissileNumber  := RecMistral^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang

      RecSendMistral.OrderID         := RecMistral^.OrderID;

      RecSendMistral.mTargetBearing  := RecMistral^.mTargetBearing;
      RecSendMistral.mTargetRange    := RecMistral^.mTargetRange;
      RecSendMistral.mTargetElev     := RecMistral^.mTargetElev;

      TcpServer3D.SendData(REC_CMD_MISTRAL, RecSendMistral);
    end;
    REC_CMD_STRELLA:
    begin
      RecStrella := @apRec^;
      recSendStrella.ShipID := RecStrella^.ShipID;
      recSendStrella.mWeaponID       := RecStrella^.mWeaponID; //Diisi sesuai Database
      recSendStrella.mLauncherID     := RecStrella^.mLauncherID;
      recSendStrella.mMissileID      := RecStrella^.mMissileID;
      recSendStrella.mMissileNumber  := RecStrella^.mMissileNumber; //Diisi 0 aj...nanti instruktur yang ngisi ulang

      recSendStrella.OrderID         := RecStrella^.OrderID;

      recSendStrella.mTargetBearing  := RecStrella^.mTargetBearing;
      recSendStrella.mTargetRange    := RecStrella^.mTargetRange;
      recSendStrella.mTargetElev     := RecStrella^.mTargetElev;

      TcpServer3D.SendData(REC_CMD_STRELLA, recSendStrella);
    end;
  end;
//  if pc.ID = REC_STAT_CANNON_SPLASH then
//  begin
//    RecRecv := @apRec^;
//
//    strWeapon := 'Unknown Cannon';
//    case RecRecv^.WeaponID of
//      C_DBID_CANNON40   : strWeapon := 'Cannon 40';
//      C_DBID_CANNON57   : strWeapon := 'Cannon 57';
//      C_DBID_CANNON76   : strWeapon := 'Cannon 76';
//      C_DBID_CANNON120  : strWeapon := 'Cannon 120';
//    end;
//
//    if Assigned(OnLogReceived2D) then
//
//    OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : Receive ' +  strWeapon + ' Launcher ' +
//                              IntToStr(RecRecv^.LauncherID) +
//                              ' From Vehicle ' + IntToStr(RecRecv^.ShipID) + ' Splash @' +
//               ' X : ' + FloatToStr(RecRecv^.PosX) +
//               ' Y : ' + FloatToStr(RecRecv^.PosY) +
//               ' Z : ' + FloatToStr(RecRecv^.PosZ));
//  end
//  else
//  if  pc.ID = REC_RECV_TORP_STATE then
//  begin
//    RecRecvTorpState := @apRec^;
//    if Assigned(OnLogReceived2D) then
//    OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : Sut detect target ' + 'ShipID ' + inttostr(RecRecvTorpState^.ShipID)
//               +' ' + ' mWeaponID  ' + inttostr(RecRecvTorpState^.mWeaponID)
//               +' ' + 'mLauncherID ' + inttostr(RecRecvTorpState^.mLauncherID)
//               +' ' + 'mMissileID  ' + inttostr(RecRecvTorpState^.mMissileID  )
//               +' ' + 'isFind      ' + inttostr(RecRecvTorpState^.isFind));
//
//
//  end
//  else
//  if pc.ID = REC_STATUS_MESSAGE then
//  begin
//    RecRecvStatusMessage := @apRec^;
//    if Assigned(OnLogReceived2D) then
//    OnLogReceived2D('TBridgeManager.ClientReceive_ServerSend : REC_STATUS_MESSAGE'
//               +' ' + FloatToStr(RecRecvStatusMessage^.MessageID)
//               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd1)
//               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd2)
//               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd3)
//               +'-' + FloatToStr(RecRecvStatusMessage^.Cmd4));
//  end
end;

procedure TBridgeManager.Server2Drecv_Missilepos(apRec: PAnsiChar; aSize: integer;
 Sender: TWSocketClient);
begin
//
end;

procedure TBridgeManager.RecvReqSce(AHeader: TPacketHeader; AContent: string);
var
  incoming_data: TRecRequestScenario;
  apRec: TRecRequestScenario;
begin
  if Length(AContent)>0 then
  begin
    TgoBsonSerializer.Deserialize<TRecRequestScenario>(AContent, incoming_data);

    if Assigned(OnLogReceived) then
    begin
      OnLogReceived('JSON : ' + AContent);
      OnLogReceived('TBridgeManager.RecvReqSce : REC_SCEID'
             + #13#10 +'ScenarioID : ' + IntToStr(incoming_data.ScenarioID)
             + #13#10 +'StatusSce : ' + FormatFloat('0.00', incoming_data.StatusSce));
    end;

    apRec.ScenarioID := FLastScenarioActive;
    apRec.StatusSce := 1;
    TcpServer3D.SendData(REC_SCEID, apRec);
  end;
end;

procedure TBridgeManager.RunSimulation;
begin
  ListenServerBridge2D(bridgeSet.mBridgeConverter.ServerBridge2DPort);
  ListenServerBridge3D(bridgeSet.mBridgeConverter.ServerBridge3DPort);
end;

procedure TBridgeManager.Server2DRecv_StatusGame(apRec: PAnsiChar;
  aSize: integer; Sender: TWSocketClient);
var
  rec : ^TRecStatusGame;
  recStatus: TRecStatusGame3D;
begin
   Rec := @apRec^;
  if Assigned(OnLogReceived2D) then
    OnLogReceived2D('TBridgeManager.Server2DRecv_StatusGame : REC_STATUS_GAME'
           + #13#10 +'ScenarioID : ' + IntToStr(Rec^.ScenarioID)
           + #13#10 +'StatusConnect : ' + IntToStr(Rec^.StatusConnect));

  if Rec^.StatusConnect = 1 then
  begin
    FLastScenarioActive := Rec^.ScenarioID;
  end
  else
    FLastScenarioActive := 0;

  recStatus.ScenarioID := Rec^.ScenarioID;
  recStatus.StatusConnect := Rec^.StatusConnect;

  TcpServer3D.SendData(REC_STATUS_GAME, recStatus);
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
//            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
          end;

          __CM_CLIENT_CONNECT :
          begin
            IpToSend  := Sender.GetPeerAddr;

//            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//            begin
//              Client := TcpServer.WSocketServer.Client[i];
//              if Client.GetPeerAddr = IpToSend then
//              begin
//                //Send Set DB Address
//                RecSend.orderID   := _CM_CLIENT_MANAGE;
//                RecSend.numValue  := __CM_CLIENT_SETDB_ADDR;
//                RecSend.strValue  := DBServer;
//                RecSend.strValue2 := '';
//                RecSend.strValue3 := '';
//                RecSend.ipConsole := IpToSend;
//                //Send to Launcher
//                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//
//                //Send Set DB Address
//                RecSend.orderID   := _CM_CLIENT_MANAGE;
//                RecSend.numValue  := __CM_CLIENT_WELCOME;
//                RecSend.strValue  := IpToSend;
//                RecSend.strValue2 := '';
//                RecSend.strValue3 := '';
//                RecSend.ipConsole := IpToSend;
//                //Send to Launcher
//                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//              end;
//            end;
          end;

          __CM_CLIENT_RESTART :
          begin
            IpToSend  := aRec.ipConsole;
//            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//            begin
//              Client := TcpServer.WSocketServer.Client[i];
//              if Client.GetPeerAddr = IpToSend then
//              begin
//                //Send Restart
//                RecSend.orderID   := _CM_CLIENT_MANAGE;
//                RecSend.numValue  := __CM_CLIENT_RESTART;
//                RecSend.strValue  := IpToSend;
//                RecSend.strValue2 := '';
//                RecSend.strValue3 := '';
//                RecSend.ipConsole := IpToSend;
//
//                //Send to Launcher
//                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//              end;
//            end;
          end;

          __CM_CLIENT_SHUTDOWN :
          begin
            IpToSend  := aRec.ipConsole;
//            for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//            begin
//              Client := TcpServer.WSocketServer.Client[i];
//              if Client.GetPeerAddr = IpToSend then
//              begin
//                //Send Restart
//                RecSend.orderID   := _CM_CLIENT_MANAGE;
//                RecSend.numValue  := __CM_CLIENT_SHUTDOWN;
//                RecSend.strValue  := IpToSend;
//                RecSend.strValue2 := '';
//                RecSend.strValue3 := '';
//                RecSend.ipConsole := IpToSend;
//
//                //Send to Launcher
//                TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//              end;
//            end;
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
//            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
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
//            TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, nil);
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
//          for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//          begin
//            Client := TcpServer.WSocketServer.Client[i];
//            if Client.GetPeerAddr = IpToSend then
//            begin
//              TcpServer.SendDataEx(REC_2D_ORDER, apRec, Client);
//            end
//          end;
        end;

        __CM_CLIENT_LAUNCHALL :
        begin
          //Send To All Launcher
//          tcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

          //Save ScenarioID
//          LastScenarioID := StrToInt(aRec^.strValue);

          if Assigned(OnLogReceived2D) then
          begin
            OnLogReceived2D('');
            OnLogReceived2D('TBridgeManager.ServerReceive_ClientManagement : Run Scenario ID -> ' + aRec^.strValue);
          end;
        end;
      end;
    end;

    _CM_CLIENT_CHECK  :
    begin
      //Send To All Launcher
//      tcpServer.SendDataEx(REC_2D_ORDER, apRec, nil);

      if Assigned(OnLogReceived2D) then
      begin
        OnLogReceived2D('');
        OnLogReceived2D('TBridgeManager.ServerReceive_ClientManagement : == Client Check ==');
      end;

//      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//      begin
//        Client := TcpServer.WSocketServer.Client[i];
//
//        if Assigned(OnLogPacket) then
//        begin
//          OnLogPacket('Client ' + IntToStr(i) + ' Ip Adress ' + Client.GetPeerAddr);
//        end;
//      end;
    end;

    _CM_CLIENT_CHECKSCENARIOID :
    begin
      IpToSend  := Sender.GetPeerAddr;

//      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//      begin
//        Client := TcpServer.WSocketServer.Client[i];
//        if Client.GetPeerAddr = IpToSend then
//        begin
//          RecSend.orderID   := _CM_CLIENT_CHECKSCENARIOID;
//          RecSend.numValue  := GameStatus;
//          RecSend.strValue  := IntToStr(LastScenarioID);
//          RecSend.strValue2 := '';
//          RecSend.strValue3 := '';
//          RecSend.ipConsole := '';
//
//          TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//        end;
//      end;
    end;

    _CM_REQ_SYNCPACKET :
    begin
      IpToSend  := Sender.GetPeerAddr;
      PortToSend := Sender.GetPeerPort;

//      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//      begin
//        Client := TcpServer.WSocketServer.Client[i];
//        if (Client.GetPeerAddr = IpToSend) and (Client.GetPeerPort = PortToSend) then
//        begin
//          for j := 0 to FPacketBuff.BuffCount - 1 do
//          begin
//            if FPacketBuff.PeekPacket(j, pBuff, pSize) then
//            begin
//              pid := @pBuff^;
//              TcpServer.SendDataEx(pid^.ID, pBuff, Client);
//            end;
//          end;
//
//          if Assigned(OnLogPacket) then
//            OnLogPacket('Send Sync Packet To ' + IpToSend);
//        end;
//      end;
    end;

    _CM_CLIENT_CONNECT :
    begin
      IpToSend  := Sender.GetPeerAddr;
//      for i := 0 to TcpServer.WSocketServer.ClientCount - 1 do
//      begin
//        Client := TcpServer.WSocketServer.Client[i];
//        if Client.GetPeerAddr = IpToSend then
//        begin
//          RecSend.orderID   := aRec^.orderID;
//          RecSend.numValue  := aRec^.numValue;
//          RecSend.strValue  := '';
//          RecSend.strValue2 := '';
//          RecSend.strValue3 := '';
//          RecSend.ipConsole := '';
//
//          TcpServer.SendDataEx(REC_2D_ORDER, @RecSend, Client);
//        end;
//      end;
    end;
  end;
end;


procedure TBridgeManager.ServerRecv_3D_Server2DSend(AHeader: TPacketHeader;
  AContent: string);
begin
//
end;

procedure TBridgeManager.SetLog2DServer(aLog: TStringList);
begin
  TcpServer2D.setLog(aLog);
end;

procedure TBridgeManager.StopSimulation;
begin
  TimerGetPacket.Enabled := False;
  TcpServer2D.UnregisterAllProcedure;
  TcpServer2D.Stop;

  TcpServer3D.UnregisterAllProcedure;
  TcpServer3D.Stop;
end;

end.
