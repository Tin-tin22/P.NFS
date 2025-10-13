unit uNetHandle;

interface

uses
  uBaseNetHandler, uNetUDPnode, uPacketRegister, uNetBaseSocket,SysUtils, uUDPDatatype;
Type
    TNetHandle = class(TBaseNetHandler)
    protected
      FNetUDPNodeTrans: TNetUDPNode;
      FLongIpBC: Longword;

      function GetBCAddress: string;
      procedure SetBCAddress(const Value: string);

    public
      constructor create;
      destructor destroy; override;

    public
      GamePort : Integer;
      property BroadCastAddress: string read GetBCAddress write SetBCAddress;
  
    public
      procedure StartNetworking; virtual;
      procedure StopNetworking; virtual;

      procedure StartListen;
      procedure StopListen;

      procedure SendBroadcast_UDP_Data(const aID: word; aBuffer: PAnsiChar;
                putPacket : boolean = true);

      procedure RegisterUDPPacket(const aType, aRecSize: word;
        aProcedure: TRegPacketHandlerProc);

      procedure UnRegisterUDP;
    end;

implementation

{ TNetHandle }

constructor TNetHandle.create;
begin
  inherited;
end;

destructor TNetHandle.destroy;
begin
  inherited;
end;

function TNetHandle.GetBCAddress: string;
begin
  result := LongIp_To_StrIp(FLongIpBC);
end;

procedure TNetHandle.RegisterUDPPacket(const aType, aRecSize: word;
  aProcedure: TRegPacketHandlerProc);
begin
  FNetUDPNodeTrans.RegisterProcedure(aType, aProcedure, aRecSize);
end;

procedure TNetHandle.SetBCAddress(const Value: string);
begin
  FLongIpBC := StrIp_To_LongIp(Value);
end;

procedure TNetHandle.StartListen;
begin
  FNetUDPNodeTrans.Listen();
end;

procedure TNetHandle.StartNetworking;
begin
  inherited;
  FNetUDPNodeTrans := TNetUDPNode.Create;
  FNetUDPNodeTrans.Port := GamePort;
end;

procedure TNetHandle.StopListen;
begin
  FNetUDPNodeTrans.Close;
end;

procedure TNetHandle.StopNetworking;
begin
  inherited;
  FNetUDPNodeTrans.Close;
  FNetUDPNodeTrans.Free;
end;

procedure TNetHandle.SendBroadcast_UDP_Data(const aID: word; aBuffer: PAnsiChar;
  putPacket : boolean = true);
var pid: ^TPacketID;
begin
  FNetUDPNodeTrans.SendDataTo(BroadCastAddress, aID, aBuffer);
end;

procedure TNetHandle.UnRegisterUDP;
begin
  FNetUDPNodeTrans.UnregisterAllProcedure;
end;

end.
