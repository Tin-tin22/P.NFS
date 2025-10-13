program Bridge3DConverter;

uses
  Vcl.Forms,
  System.Classes,
  uFrmMain3DBridgeConverter in 'uFrmMain3DBridgeConverter.pas' {frm3DBridgeConverter},
  uTCPServer in '..\ShareLib\LibNetworks\uTCPServer.pas',
  uTCPDatatype in '..\ShareLib\LibNetworks\uTCPDatatype.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uManagerBridge in 'uManagerBridge.pas',
  uBridgeSet in '..\ShareLib\LibSetting\uBridgeSet.pas',
  uNetLinkServer in '..\ShareLib\LibNetsJSON\NetLinkComp\uNetLinkServer.pas',
  uCodecBase64 in '..\ShareLib\LibSetting\uCodecBase64.pas',
  uBuffer in '..\ShareLib\LibNetsJSON\NetLinkComp\uBuffer.pas',
  uDataManager in '..\ShareLib\LibNetsJSON\NetLinkComp\uDataManager.pas',
  uDataType in '..\ShareLib\LibNetsJSON\NetLinkComp\uDataType.pas',
  uHelper in '..\ShareLib\LibNetsJSON\NetLinkComp\uHelper.pas',
  UPacketProtocol in '..\ShareLib\LibNetsJSON\NetLinkComp\UPacketProtocol.pas',
  uThreadSafeQueue in '..\ShareLib\LibNetsJSON\NetLinkComp\uThreadSafeQueue.pas',
  Grijjy.BinaryCoding in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.BinaryCoding.pas',
  Grijjy.Bson.IO in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.Bson.IO.pas',
  Grijjy.Bson in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.Bson.pas',
  Grijjy.Bson.Serialization in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.Bson.Serialization.pas',
  Grijjy.Collections in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.Collections.pas',
  Grijjy.DateUtils in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.DateUtils.pas',
  Grijjy.SysUtils in '..\ShareLib\LibNetsJSON\Grijjy\Grijjy.SysUtils.pas',
  uData3DConverter in 'Data\uData3DConverter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm3DBridgeConverter, frm3DBridgeConverter);
//  //create bridge manager
//  BridgeManager := TBridgeManager.Create;
//
//  BridgeManager.ONetLinkServer_OnClientStatus2D := frm3DBridgeConverter.NetLinkServer_OnClientStatus2D;
//  BridgeManager.OnLogReceived2D := frm3DBridgeConverter.OnLogReceived2D;
//  BridgeManager.OnLogListenPort2D := frm3DBridgeConverter.OnLogListenPort2D;
//
//  BridgeManager.SetLog2DServer(TStringList(frm3DBridgeConverter.mmoLogClientData.Lines));
//
//  BridgeManager.ONetLinkServer_OnClientStatus := frm3DBridgeConverter.NetLinkServer_OnClientStatus;
//  BridgeManager.OnLogReceived := frm3DBridgeConverter.OnLogReceived;
//  BridgeManager.OnLogListenPort3D := frm3DBridgeConverter.OnLogListenPort3D;
//
//  BridgeManager.InitSimulation;
//  BridgeManager.RunSimulation;
  Application.Run;

//  BridgeManager.StopSimulation;
//  BridgeManager.Free;
end.
