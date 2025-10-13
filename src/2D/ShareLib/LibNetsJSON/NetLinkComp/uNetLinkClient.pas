unit uNetLinkClient;

interface

uses
  Classes, SysUtils,

  OverbyteIcsWSocket,

  uDataType,
  uDataManager,
  UPacketProtocol,
  uBuffer,
  UHelper;

type
  TOnFinishBuffer = procedure(const b: Boolean) of object;

  // ==============================================================================
  TNetLinkClient = class
  private
    WSocket: TWSocket;
    FLogStat, FLogSend, FLogRecv: TGetStrProc;

    FLongXAddress: Cardinal;
    FHostName: string;
    FIPLists: TStrings;

    FRegProcs: TPacketManager;
    FDataQueue: TDataQueue;

    FLogData: TGetStrProc;

    FPacketizer: TPacketProtocol;

    FReceiveBuffer: TBytes;

    FOnConnected: TNotifyEvent;
    FOnDisConnected: TNotifyEvent;

    function GetMyHostName: string;
    procedure DefStrLog(const s: string);
    procedure SetStrLog(const index: integer; const Value: TGetStrProc);
    function GetChangeState: TChangeState;
    procedure SetChangeState(const Value: TChangeState);
    procedure HandleException(AE: exception; AClient: TWSocket);

    function GetConnected: Boolean;
    procedure SetLogData(const Value: TGetStrProc);

    procedure MessageArrived(const AData: TBytes);

    function GetState: TSocketState;
    procedure WSocket_OnDataAvailable(Sender: TObject; Error: Word);
    procedure WSocket_OnSessionConnected(Sender: TObject; Error: Word);
    procedure WSocket_OnSessionClosed(Sender: TObject; Error: Word);
    // procedure WSocket_OnSessionAvailable(Sender: TObject; Error: Word);

    procedure WSocket_OnDataSent(Sender: TObject; Error: Word);

    procedure CloseSocket;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Connect(aAddr, aPort: string);
    procedure Disconnect;

    // procedure SendData(const aID: Word; aBuffer: PAnsiChar);
    procedure SendData<T>(const aID: Word; Data: T);
    procedure FlushSendData;

    procedure RegisterProcedure(const aType: Word;
      aProcedure: TPacketHandlerProc);
    procedure UnRegisterProcedure(const aType: Word);
    procedure UnregisterAllProcedure;

    procedure GetPacket();
    property Connected: Boolean read getConnected;
    property State: TSocketState read getState;
    property OnStateChange: TChangeState read GetChangeState
      write SetChangeState;
    property MyLongIP: LongWord read FLongXAddress;
    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisConnected: TNotifyEvent read FOnDisConnected
      write FOnDisConnected;
    property OnlogRecv: TGetStrProc read FLogData write SetLogData;

    property OnGetStatusLog: TGetStrProc index 1 read FLogStat write SetStrLog;
    property OnGetSendLog: TGetStrProc index 2 read FLogSend write SetStrLog;
    property OnGetRecvLog: TGetStrProc index 3 read FLogRecv write SetStrLog;
    property MyHostName: string read getMyHostName;
  end;

implementation

uses
  Windows,
  Messages,
  DateUtils;

{ TNetLinkClient }
constructor TNetLinkClient.Create;
begin
  inherited;

  FLogStat := DefStrLog;
  FLogSend := DefStrLog;
  FLogRecv := DefStrLog;

  FPacketizer := TPacketProtocol.Create(10000);
  FPacketizer.MessageArrived := MessageArrived;

  FRegProcs := TPacketManager.Create;

  FIPLists := TStringList.Create;
  HostToIPList(FHostName, FIPLists);

  SetLength(FReceiveBuffer, 4 * 1024);

  WSocket := TWSocket.Create(nil);

  WSocket.OnDataSent := WSocket_OnDataSent;
  WSocket.OnSessionConnected := WSocket_OnSessionConnected;
  WSocket.OnSessionClosed := WSocket_OnSessionClosed;

  FDataQueue := TDataQueue.Create;
  FDataQueue.RegProcs := FRegProcs;
end;

destructor TNetLinkClient.Destroy;
begin
  FRegProcs.Free;
  FIPLists.Free;

  WSocket.OnDataSent := nil;
  CloseSocket;
  WSocket.Free;
  WSocket := nil;

  FDataQueue.Clear;
  FDataQueue.Free;
  FPacketizer.MessageArrived := nil;
  FPacketizer.DisposeOf;
  inherited;
end;

function TNetLinkClient.GetMyHostName: string;
begin
  var i: Integer := Length(FHostName);
  if i > 32 then
    result := Copy(FHostName, 1, 32)
  else
    result := FHostName;
end;

procedure TNetLinkClient.DefStrLog(const s: string);
begin
  // do nothing
  // LogFile_net(s);
end;

procedure TNetLinkClient.HandleException(AE: exception; AClient: TWSocket);
begin
  if (AE is ESocketException) then
  begin
    FLogStat(TimeToString + '  Error : ' + AClient.Addr + AE.Message);
    AClient.Close;
  end
  else
  begin
    FLogStat(TimeToString + ': Unhandled exception raised!');
  end;
end;

procedure TNetLinkClient.MessageArrived(const AData: TBytes);
begin
  if Assigned(FLogRecv) then
    FLogRecv('Packet Found.');
  FDataQueue.PutPacket(AData);
end;

procedure TNetLinkClient.SetStrLog(const index: integer; const Value: TGetStrProc);
begin
  var
    x: TGetStrProc;
  if not Assigned(Value) then
    x := DefStrLog
  else
    x := Value;
  case index of
    1:
      FLogStat := x;
    2:
      FLogSend := x;
    3:
      FLogRecv := x;
  end;
end;

procedure TNetLinkClient.Connect(aAddr, aPort: string);
begin
  if (WSocket.State <> wsConnected) and (WSocket.State <> wsConnecting) then
  begin
    WSocket.OnDataAvailable := WSocket_OnDataAvailable;
    WSocket.Proto := C_SOCK_DEF_PROTO;
    WSocket.LineMode := False;
    WSocket.LineEdit := False;
    WSocket.LineEcho := False;
    WSocket.Port := aPort;
    WSocket.Addr := aAddr;
    FLogStat(DateToString + ': ' + 'Connecting to ' + aAddr + ' port ' + aPort);
    WSocket.Connect;
  end;
end;

procedure TNetLinkClient.CloseSocket;
begin
  PostMessage(WSocket.Handle, WM_QUIT, 0, 0);
end;

procedure TNetLinkClient.Disconnect;
begin
  FLogStat(DateToString + ': ' + 'Disconnecting ...');
  WSocket.OnDataAvailable := nil;
  WSocket.Close;
end;

procedure TNetLinkClient.SendData<T>(const aID: Word; Data: T);
begin
  if not FRegProcs.IsRegistered(aID) then
  begin
    FLogSend(TimeToString + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;
  var
    h: TPacketHeader;
  var
    dtutc: TDateTime:= TTimeZone.Local.ToUniversalTime(Now);

  h.PacketID := aID;
  h.SenderAddress := FLongXAddress;
  h.SenderPort := StrToInt(WSocket.GetXPort);
  h.SentTime := DateTimeToUnixMs(dtutc, False);
  var
    bytes: TBytes := TPacketProtocol.WrapMessage
      (UHelper.TComposer.ComposePacket(h, Data));
  if WSocket.State = wsConnected then
  begin
    if not WSocket.AllSent then
    begin
      WSocket.Flush;
      FLogSend(TimeToString + ': flush!');
    end;
    var
      sz: integer := Length(bytes);
    FLogSend(TimeToString + ': Send id ' + inttostr(aID) + ' -  ' + inttostr(sz)
      + ' byte');
    try
      WSocket.Send(bytes, sz);
    except
      on e: exception do
        HandleException(e, WSocket);
    end;
  end;
end;

procedure TNetLinkClient.WSocket_OnSessionConnected(Sender: TObject; Error: Word);
begin
  var
    s: string;
  if WSocket.State = wsConnected then
  begin
    try
      s := WSocket.PeerAddr;
    except
      on ESocketException do
      begin
        Exit;
      end;
    end;
    // connect temenan rek..
    s := WSocket.GetXAddr;
    FLongXAddress := StrToLongIP(s);
    if Assigned(FOnConnected) then
      FOnConnected(self);
    FLogStat(TimeToString + ': ' + 'Connected to ' + s);
  end;
end;

procedure TNetLinkClient.WSocket_OnSessionClosed(Sender: TObject; Error: Word);
begin
  var
    s: string := TimeToString + ': ' +
      'DisConnected from ' + LongIPToStr(FLongXAddress);
  FLongXAddress := 0;
  if Assigned(FOnDisConnected) then
    FOnDisConnected(self);
  FLogStat(s);
end;

// procedure TNetLinkClient.WSocket_OnSessionAvailable(Sender: TObject; Error: Word);
// var
// s: string;
// begin
// if WSocket.State = wsConnected then
// begin
// s := WSocket.GetXAddr;
// FLongXAddress := StrIp_To_LongIp(s);
// FLogStat(TimeStr + ': ' + 'available ' + s);
// end;
// end;

procedure TNetLinkClient.WSocket_OnDataAvailable(Sender: TObject; Error: Word);
begin
  if Error <> 0 then
    Exit;

  try
    FillChar(FReceiveBuffer[0], Length(FReceiveBuffer), 0);
    var receivedByte: Integer := TWSocket(Sender).Receive(FReceiveBuffer,
      Length(FReceiveBuffer));
    FLogRecv(TimeToString + ': ReceivedBytes = ' + inttostr(receivedByte));
    if receivedByte < 1 then
      Exit;

    // svrIP := TWSocket(Sender).Addr;

    var readBytes: TBytes;
    SetLength(readBytes, receivedByte);
    Move(FReceiveBuffer[0], readBytes[0], receivedByte);
    FPacketizer.DataReceived(readBytes);

  finally

  end;
end;

function TNetLinkClient.GetState: TSocketState;
begin
  result := WSocket.State;
end;

procedure TNetLinkClient.WSocket_OnDataSent(Sender: TObject; Error: Word);
begin
  if Error = 0 then
    FLogSend('Data sent: ')
  else
    FLogSend('Data sent Error : ' + inttostr(Error));
end;

function TNetLinkClient.GetConnected: Boolean;
begin
  result := WSocket.State = wsConnected;
end;

procedure TNetLinkClient.GetPacket;
begin
  FDataQueue.GetPacket;
end;

function TNetLinkClient.GetChangeState: TChangeState;
begin
  result := WSocket.OnChangeState;
end;

procedure TNetLinkClient.SetChangeState(const Value: TChangeState);
begin
  WSocket.OnChangeState := Value;
end;

procedure TNetLinkClient.SetLogData(const Value: TGetStrProc);
begin
  FLogData := Value;
  FDataQueue.LogStat := Value;
end;

procedure TNetLinkClient.FlushSendData;
begin
  if (WSocket.State = wsConnected) and not WSocket.AllSent then
    WSocket.Flush;
end;

procedure TNetLinkClient.RegisterProcedure(const aType: Word;
  aProcedure: TPacketHandlerProc);
begin
  FRegProcs.Register(aType, aProcedure);
end;

procedure TNetLinkClient.UnRegisterProcedure(const aType: Word);
begin
  FRegProcs.UnRegister(aType);
end;

procedure TNetLinkClient.UnregisterAllProcedure;
begin
  FRegProcs.UnregisterALL;
end;

end.
