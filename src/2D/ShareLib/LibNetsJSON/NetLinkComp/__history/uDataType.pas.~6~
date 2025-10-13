unit uDataType;

interface

uses
  System.Classes,
  System.SysUtils,
  Winapi.Winsock2,
  OverbyteIcsWSocket,

  Grijjy.Bson,
  Grijjy.Bson.IO,
  Grijjy.Bson.Serialization;

// -----------------------------------------------------------------------------

type

  TRecIP = record
    case Cardinal of
      0:
        (longIP: Cardinal);
      1:
        (b3, b2, b1, b0: Byte);
  end;

  TPacketHeader = record
    [BsonElement('ID')]
    PacketID: Integer;
    [BsonElement('SA')]
    SenderAddress: Cardinal;
    [BsonElement('SP')]
    SenderPort: Integer;
    // [BsonElement('RA')]
    // ReceiverAddress: Cardinal;
    // [BsonElement('RP')]
    // ReceiverPort: Integer;
    [BsonElement('ST')]
    SentTime: Int64;
    // [BsonElement('RT')]
    [BsonIgnore]
    ReceiveTime: Int64;
  end;

  TCommPacket = record
    [BsonElement('H')]
    Header: TPacketHeader;
    [BsonElement('C')]
    //Content: TBytes;
    Content: string;
  end;

// -----------------------------------------------------------------------------

const
  C_SOCK_BUFFER_SIZE = 1024 * 1024;
  C_SOCK_DEF_PROTO = 'tcp';

  C_SOCK_DEF_PORT = '1809';
  C_MAX_PACKET_BYTESIZE = 2; // 2 byte = 64KB
  //HC_RECID_STRING: Word = 0;

  C_SockStateString: array [TSocketState] of string = ('InvalidState', 'Opened',
    'Bound', 'Connecting', 'SocksConnected', 'Connected', 'Accepting',
    'Listening', 'Closed', 'DNS Lookup'); { V8.48 added DnsLookup }

// -----------------------------------------------------------------------------

function DateTimeToUnixMs(const AValue: TDateTime; AInputIsUTC: Boolean): Int64;
function UnixMsToDateTime(const AValue: Int64; AReturnUTC: Boolean): TDateTime;

function TimeToString: string;
function DateToString: string;

function HostToIPList(var aHostName: string; ss: TStrings): Boolean;

function LongIPToStr(const lIP: Cardinal): string;
function StrToLongIP(const s: string): Cardinal;

function SockStateToStr(const st: TSocketState): string;

implementation

uses
  Windows,
  Messages,
  DateUtils;

// -----------------------------------------------------------------------------

{ Unix date conversion support }

function DateTimeToUnixMs(const AValue: TDateTime; AInputIsUTC: Boolean): Int64;
begin
  var
    LDate: TDateTime;
  if AInputIsUTC then
    LDate := AValue
  else
    LDate := TTimeZone.Local.ToUniversalTime(AValue);
  Result := MilliSecondsBetween(UnixDateDelta, LDate);
  if LDate < UnixDateDelta then
     Result := -Result;
end;

function UnixMsToDateTime(const AValue: Int64; AReturnUTC: Boolean): TDateTime;
begin
  if AReturnUTC then
    Result := IncMilliSecond(UnixDateDelta, AValue)
  else
    Result := TTimeZone.Local.ToLocalTime(IncMilliSecond(UnixDateDelta, AValue));
end;

function TimeToString: string;
begin
  Result := FormatDateTime('hh:nn:ss.zzz ', now);
end;

function DateToString: string;
begin
  Result := FormatDateTime('dd-mm-yyyy hh:nn:ss ', now);
end;

function LongIPToStr(const lIP: Cardinal): string;
begin
  var
    r: TRecIP;
  r.longIP := lIP;
  Result := '0.0.0.0';
  try
    Result := Format('%d.%d.%d.%d', [r.b3, r.b2, r.b1, r.b0]);
  except
  end;
end;

function StrToLongIP(const s: string): Cardinal;
// const
// digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
var
  digits: set of AnsiChar;
  i, j, l: Integer;
  b: array [0 .. 3] of Byte;
  c: Byte;
  cp: string;
begin
  digits := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  FillChar(Result, 4, 0);

  l := Length(s);
  i := 1;
  c := 0;
  cp := '';

  while i <= l do
  begin
    if s[i] <> '.' then
    begin
      if CharInSet(s[i], digits) then // s[i] in digits then
        cp := cp + s[i]
      else
        Exit;
    end
    else
    begin // get .
      j := StrToInt(cp);
      if j > 255 then
        Exit;
      if j < 0 then
        Exit;

      b[c] := j;
      cp := '';
      Inc(c);
    end;

    Inc(i);
  end;
  if (cp <> '') then
  begin
    j := StrToInt(cp);
    if j > 255 then
      Exit;
    if j < 0 then
      Exit;

    b[c] := StrToInt(cp)
  end
  else
    Exit;

  Move(b, Result, 4);
end;

// -----------------------------------------------------------------------------

function HostToIPList(var aHostName: string; ss: TStrings): Boolean;
type
  TArrayPInAddr = array [0 .. 10] of PInAddr;
  PArrayPInAddr = ^TArrayPInAddr;
var
  i: Integer;
  pHe: PHostEnt;
  ptrPA: PArrayPInAddr;
  pBuffer: PAnsiChar;
  WSAData: TWSAData;
  ipAddr: string;
begin
  Result := false;

  if WSAStartup($0002, WSAData) <> 0 then
    Exit;

  GetMem(pBuffer, 256);

  try
    GetHostName(pBuffer, 256);
    pHe := GetHostByName(pBuffer);

    if pHe = nil then
      Exit;

    aHostName := string(pBuffer);
    ss.Clear;

    ptrPA := PArrayPInAddr(pHe^.h_addr_list);
    i := 0;
    while ptrPA^[i] <> nil do
    begin
      ipAddr := string(inet_ntoa(ptrPA^[i]^));
      ss.Add(ipAddr);
      Inc(i);
    end;
    Result := True;
  finally
    FreeMem(pBuffer);
    WSACleanup;
  end;
end;

function SockStateToStr(const st: TSocketState): string;
begin
  Result := C_SockStateString[st];
end;

// =============================================================================

end.
