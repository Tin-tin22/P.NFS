unit uNetUDPnode;

interface
uses
  Windows, Classes, SysUtils, OverbyteIcsWSocket, OverbyteIcsWinSock,
  uNetBaseSocket, uUDPDatatype;

type

  TNetUDPNode = class(TNetBaseSocket)
  private
    FPort : Word;
    FActive: boolean;

    function getActive: boolean;
  private
    FAddrIn  : TSockAddrIn;
    FAddrSize: integer;


  protected
    FBuffer: PAnsiChar;
    FBufferNow: LongWord;

    procedure WSocket_OnDataAvailable(Sender: TObject; Error: Word);
    procedure WSocket_OnDataSent(Sender: TObject; Error: word);
    procedure WSocket_OnChangeState(Sender: TObject;
                                 OldState, NewState : TSocketState);

    procedure PacketRecognizer(aP: PAnsiChar; const aSize: integer;
      const ipSender: string); override;

  public

    constructor Create;
    destructor Destroy; override;

    procedure Connect(aPort: string = '');
    procedure Listen(aPort: string = '');
    procedure Close;

    procedure SendData(const aID: word; aBuffer: PAnsiChar); override;
    procedure SendDataTo(const toIP: string; const aID: word; aBuffer: PAnsiChar);
 {   procedure FlushSendData; override; }
  public

    property MyLongIP: LongWord read FLongXAddress;
    property Active: boolean read getActive;
    property Port: Word read FPort write FPort;

  end;


implementation

uses

 WinSock;

const
  CUDP_BUFFSIZE = 4096;
//==============================================================================
{ TNetUDPNode }

constructor TNetUDPNode.Create;
begin
  inherited;
  FPort :=  021085;

  GetMem(FBuffer, CUDP_BUFFSIZE);
  FAddrSize := SizeOf(FAddrIn);

  WSocket := TWSocket.Create(nil);
  with  WSocket do begin
    Proto := 'udp';
    Port  := IntToStr(FPort);
    Addr  := '0.0.0.0';
//    Addr  := '255.255.255.255';

    OnDataSent      := WSocket_OnDataSent;
    OnDataAvailable := WSocket_OnDataAvailable;
    OnChangeState  :=  WSocket_OnChangeState;
  end;
end;

destructor TNetUDPNode.Destroy;
begin
  WSocket.Close;
  WSocket.Free;

  FreeMem(FBuffer);
  inherited;
end;

function TNetUDPNode.getActive: boolean;
begin

end;

procedure TNetUDPNode.Listen(aPort: string = '');
begin
  if (aPort <> '') then
    FPort := StrToInt(aPort);

  WSocket.Port := IntToStr(FPort);
  WSocket.Addr  := '0.0.0.0';
  WSocket.proto := 'udp';

  WSocket.Listen;
  FActive := true;
end;

procedure TNetUDPNode.Connect(aPort: string);
begin
  if (aPort <> '') then
    FPort := StrToInt(aPort);

  WSocket.proto := 'udp';
  WSocket.Port := IntToStr(FPort);
  WSocket.Addr  := '255.255.255.255';

  WSocket.Connect;
  FActive := true;
end;

procedure TNetUDPNode.Close;
begin

  WSocket.Abort;
  WSocket.Close;
  FActive := False;
end;

procedure TNetUDPNode.PacketRecognizer(aP: PAnsiChar; const aSize: integer;
      const ipSender: string);
var pid : ^TPacketID;
    recID: Word;
begin
  pid   := @aP^;
  recID := pid^.recID;
  pid^.ipSender := StrIp_To_LongIp(ipSender);
  // ;
  inherited;

end;

procedure TNetUDPNode.SendData(const aID: word; aBuffer: PAnsiChar);
var pSize: word;
begin

  if not PrepareSendData(aID, aBuffer) then begin
    FLogSend(TimeStr + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  pSize :=  FRegProcs[aID].recSize;
  WSocket.Send (aBuffer, pSize);
  //send to all
end;

procedure TNetUDPNode.SendDataTo(const toIP: string; const aID: word; aBuffer: PAnsiChar);
var pSize   : word;
    Dest    : OverbyteIcsWinSock.TSockAddr;
    DestLen : Integer;
    sInt    : LongWord;
    err : Integer;
begin
  if not PrepareSendData(aID, aBuffer) then begin
    FLogSend(TimeStr + ': Unregistered Packet ID ' + inttostr(aID));
    Exit;
  end;

  pSize := FRegProcs[aID].recSize;
  sInt  := StrIp_To_LongIp(toIP);;

  Dest.sin_port         := htons(FPort);
  Dest.sin_family       := AF_INET;
  Dest.sin_addr.S_addr  := sInt;

  DestLen := SizeOf(Dest);
  err     := WSocket.SendTo(dest, DestLen, aBuffer, pSize);

  if err < 0 then
    FLogSend('  ERR SENDTO'     + GetWindowsErr ( WSocket_WSAGetLastError));
end;

procedure TNetUDPNode.WSocket_OnDataAvailable(Sender: TObject; Error: Word);
var readByte: integer;
    recSize: ^Word;
    senderIP : string;
    Faddr : WinSock.sockaddr_in;
begin
{  if Assigned(FLogStat) then
    FLogStat('!----Data available----!');
}
  readByte := TWSocket(Sender).ReceiveFrom(FBuffer, CUDP_BUFFSIZE, FAddrIn , FAddrSize);
  CopyMemory(@Faddr, @FAddrin, SizeOf(FAddrIn));

  recSize := Pointer(FBuffer);
  senderIP := inet_ntoa(Faddr.sin_addr);

{ if Assigned(FLogStat) then
    FLogStat('    - byte read '+  IntToStr(readbyte) + ' - from: ' + senderIP);
}
  PacketRecognizer(FBuffer, recSize^, senderIP);
end;

procedure TNetUDPNode.WSocket_OnDataSent(Sender: TObject; Error: word);
begin
{  if Assigned(FLogStat) then
    FLogStat('data send');
}
end;

procedure TNetUDPNode.WSocket_OnChangeState(Sender: TObject;
                                 OldState, NewState : TSocketState);
begin
  FLogStat(SockStateToString(NewState));
end;

end.


