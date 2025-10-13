program Bridge;

uses
  Forms,
  Classes,
  uTFLogBridge in 'uTFLogBridge.pas' {TFLogBridge},
  uBridgeManager in 'uBridgeManager.pas',
  uTCPClient in '..\ShareLib\LibNetworks\uTCPClient.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  Logger in '..\ShareLib\LibObject\Logger.pas',
  uPacketBuffer in '..\ShareLib\LibNetworks\uPacketBuffer.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTFLogBridge, TFLogBridge);
  BridgeManager := TBridgeManager.Create;

  BridgeManager.OnLogPnlClient      := TFLogBridge.OnLogPnlClient3D;
  BridgeManager.OnlogSettingDB      := TFLogBridge.OnLogSettingDB;
  BridgeManager.OnLogSettingSocket  := TFLogBridge.OnLogSettingSocket;
  BridgeManager.OnLogServer2D       := TFLogBridge.OnLogServer2D;
  BridgeManager.OnLogClient3D       := TFlogBridge.OnLogClient3D;
  BridgeManager.OnLogPacket         := TFlogBridge.OnLogPacket;

  BridgeManager.InitSimulation;
  BridgeManager.RunSimulation;

  Application.Run;


end.
