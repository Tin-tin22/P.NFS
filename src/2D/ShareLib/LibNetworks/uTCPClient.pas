unit uTCPClient;

interface

uses
  overbyteicsWSocket, overbyteicsWSocketS, Classes, SysUtils, Windows,
  {uBaseConstan,} uTcpDatatype;

const
//  BUFFER_SIZE= 1024 * 1024 * 20;
  BUFFER_SIZE =  16 * 1024;

type
  TCPT_PROCEDURE = procedure(apRec: PAnsiChar; aSize: integer) of object;
  TCPT_ARRAY_PROCEDURE = array of TCPT_PROCEDURE;

  TTCPClient= class(TObject)
  protected
    FLog: TStringList;
    FRealLog: TStringList;
    //pLogPointer: Pointer;

    WSocket: TWSocket;

    FBuffer: PAnsiChar;
    FBufferSize: LongWord;
    FBufferNow: LongWord;
    FBufferSizeKnown: boolean;

    arrayProcedure: TCPT_ARRAY_PROCEDURE;
    arrSize: array of word;
    FLargestRecordSize : integer;

    function getState: TSocketState;
    procedure HandleException(AE: exception; AClient: TWSocket);
  public
    property State: TSocketState read getState;
    property Log: TStringList read FLog;
    property Socket: TWSocket read WSocket;

    constructor Create;
    destructor Destroy; override;
    procedure Connect(aAddr, aPort: string);
    procedure Disconnect;

    procedure sendData(buffer: PAnsiChar; size: integer);
    procedure sendDataEx(aID: byte; aBuffer: PAnsiChar);

    procedure setLog(aLog: TStringList);
    procedure dataAvailable(Sender: TObject; Error: Word);
    procedure PacketRecognizer(aP: PAnsiChar; aSize: integer);

    procedure DataSent(Sender: TObject; Error: word);
    procedure RegisterProcedure(aType: word; aProcedure: TCPT_PROCEDURE; recordSize: word);
  end;

implementation

{uses
  FastMove;
}
procedure CopyMemory(Destination: Pointer; Source: Pointer; Length: DWORD);
begin
  Move(Source^, Destination^, Length);
end;

{ TClientSocket }

constructor TTCPClient.Create;
begin
  inherited Create;

  WSocket := TWSocket.Create(nil);
  FLog := TStringList.Create;
  FRealLog := FLog;
  //pLogPointer:= pointer(FLog);

  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  WSocket.OnDataSent := DataSent;
  FLargestRecordSize := 0;

end;

destructor TTCPClient.Destroy;
begin
  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  WSocket.OnDataSent := nil;

  WSocket.Free;
  WSocket := nil;

  //if pLogPointer= FLog then
  if Pointer(FRealLog) = Pointer(FLog) then
  begin
    FLog.Free;
    FLog := nil;
  end;
  inherited;
end;

procedure TTCPClient.Connect(aAddr, aPort: string);
begin
  if (WSocket.State <> wsConnected) and (WSocket.State <> wsConnecting) then
  begin
    GetMem(FBuffer, BUFFER_SIZE);
    FBufferSize := 0;
    FBufferNow := 0;
    FBufferSizeKnown := False;

    WSocket.OnDataAvailable := dataAvailable;
    WSocket.Proto := 'tcp';
    WSocket.LineMode := False;
    WSocket.LineEdit := False;
    WSocket.LineEcho := False;
    WSocket.Port := aPort;
    WSocket.Addr := aAddr;
    FLog.Add(DateTimeToStr(Now) + ': ' + 'Connecting ...');
    WSocket.Connect;
    while WSocket.State in [wsConnecting] do
      WSocket.ProcessMessages;
    if WSocket.State = wsConnected then
      FLog.Add(DateTimeToStr(Now) + ': ' + 'Connected')
    else
      FLog.Add(DateTimeToStr(Now) + ': ' + 'Not connected')
  end;
end;

procedure TTCPClient.Disconnect;
begin
  FLog.Add(DateTimeToStr(Now) + ': ' + 'Disconnecting ...');
  WSocket.OnDataAvailable := nil;
  WSocket.Close;
  FreeMem(FBuffer);
  FLog.Add(DateTimeToStr(Now) + ': ' + 'Disconnected');
end;

procedure TTCPClient.sendData(buffer: PAnsiChar; size: integer);
begin
  if WSocket.State = wsConnected then
  begin
    { TODO -oArmand : Ini buat apa ya? }
    if not WSocket.AllSent then
      raise Exception.Create('in process...');

    FLog.Add(TimeToStr(Now) + ': ' + 'Sending data');
    WSocket.Send(buffer, size);
  end
end;

procedure TTCPClient.sendDataEx(aID: byte; aBuffer: PAnsiChar);
var
  lBuffer: PAnsiChar;
  stamp: TPacketCheck;
  size: longword;
  strTemp: string;
begin
  //if aID<= length(arrayProcedure) then
  if (aID <= length(arrayProcedure)) and (arrSize[aID] > 0) then
  begin
    strTemp:= 'Send: ID '+ inttostr(aID) +'  ' + C_REC_PACKETNAME[aID];
    stamp.ID := aID;
    stamp.Pass := PACKET_PASS;
    CopyMemory(aBuffer, @stamp, sizeof(TPacketCheck));
    size := arrSize[aID];

    getMem(lBuffer, size + 4);
    CopyMemory(lBuffer, @size, 4);
    CopyMemory(lBuffer + 4, aBuffer, size);

    if WSocket.State = wsConnected then
    begin
      { TODO -oArmand : Ini buat apa ya? }
      //if not WSocket.AllSent then
      //  raise Exception.Create('cannot send packet, in process...');
      {
      while not WSocket.AllSent do
      begin
        FLog.Add('AllSent is false, pending ...');
        WSocket.ProcessMessages;
      end;
      }
      if not WSocket.AllSent then
        FLog.Add(TimeToStr(Now) + ': AllSent flag is false');

      FLog.Add(TimeToStr(Now) + ': ' + strTemp);
      try
        WSocket.Send(lBuffer, size + 4);
      except
        on e: exception do HandleException(e, WSocket);
      end; //end exception
    end;

    freeMem(lBuffer);
  end
  else
  begin
    FLog.Add(TimeToStr(Now) + ': ' + 'Trying to send unknown packet (ID= ' + inttostr(aID) + ')');
  end;
end;

procedure TTCPClient.setLog(aLog: TStringList);
begin
  if aLog = nil then
  begin
    FRealLog.Assign(FLog);
    FLog := FRealLog;
    exit;
  end;

  aLog.Assign(FLog);
  //if pLogPointer= Pointer(FLog) then
  if Pointer(FRealLog) = Pointer(FLog) then
    FLog.Clear;
  FLog := aLog;
end;

procedure TTCPClient.dataAvailable(Sender: TObject; Error: Word);
var
  buffer: PAnsiChar;
  receivedByte: integer;
  len: integer;
  p, p2: pointer;
  {
  i: integer;
  }
  str: string;
  bLoop: boolean;
begin

  receivedByte := TWSocket(Sender).RcvdCount;
//  Number of characters in receive buffer but not read yet.

  FLog.Add(TimeToStr(Now) + ': ' + inttostr(receivedByte) + ' byte from '
    + TWSocket(Sender).PeerAddr);

  if receivedByte < 1  then exit;

  GetMem(buffer, receivedByte+1);
  len := TWSocket(Sender).Receive(buffer, receivedByte);

  if len <= 0 then
  begin
    FLog.Add(TimeToStr(Now) + 'ERR: ' + 'packet with length ' + inttostr(len)
     + ' received!');
    exit;
  end;
//  FLog.Add( 'RECV: ' + inttostr(receivedByte) +' LEN: ' + inttostr(len) + '------');

  p := FBuffer + FBufferNow;
  CopyMemory(PAnsiChar(p), buffer, receivedByte);
  inc(FBufferNow, receivedByte);

  bLoop := True;
  while bLoop do
  begin
    if (not FBufferSizeKnown) and (FBufferNow >= 4) then
    begin
      CopyMemory(@(FBufferSize), FBuffer, 4);
      FBufferSizeKnown := True;           // record size is known
    end;

    if (FBufferSizeKnown) and (FBufferNow >= FBufferSize + 4) then
    begin                                  // jika sudah tau ukuran record
      p := FBuffer + 4;
      PacketRecognizer(p, FBufferSize);    // ambil 1 record, lempar.

      if FBufferNow > FBufferSize + 4 then    // jika masih ada data di buffer
      begin
        p := FBuffer + (FBufferSize + 4);
        FBufferNow := FBufferNow - (FBufferSize + 4);

        GetMem(p2, FBufferNow);
        CopyMemory(p2, p, FBufferNow);         // geser data ke awal FBuffer
        CopyMemory(FBuffer, p2, FBufferNow);
        FreeMem(p2);

        //CopyMemory(FBuffer, p, FBufferNow);
        //FBufferSize:= 0;
        FBufferSizeKnown := False;
      end
      else
      begin
        FBufferSize := 0;                    // buffer habis.
        FBufferNow := 0;
        FBufferSizeKnown := False;
      end;
    end
    else
      bLoop := False;
  end;

  {
  strHex:= '';
  for i:= 0 to receivedByte-1 do
  begin
    strHex:= strHex+' '+inttohex(ord(buffer[i]), 2);
  end;
  FLog.Add(strHex);
  }
  FreeMem(buffer);
end;

procedure TTCPClient.PacketRecognizer(aP: PAnsiChar; aSize: integer);
var
  lPc: TPacketCheck;
begin
  CopyMemory(@lPc, aP, sizeof(TPacketCheck));

  if lPc.Pass <> PACKET_PASS then
  begin
    FLog.Add(TimeToStr(Now) + ': ' + 'Packet password is wrong');
    Exit;
  end;

  if lPc.ID <= length(arrayProcedure) then
  begin
    if Assigned(arrayProcedure[lPc.ID]) then
    begin
      FLog.Add(TimeToStr(Now) + ': ' + '(ID= ' + inttostr(lPC.ID) + ')'
        + C_REC_PACKETNAME[lPC.id] );
      arrayProcedure[lPc.ID](aP, arrSize[lPc.ID]);
    end
    else
      FLog.Add(TimeToStr(Now) + ': ' + 'Unregistered (ID= ' + inttostr(lPC.ID) + ')');
  end
  else
  begin
    FLog.Add(TimeToStr(Now) + ': ' + 'Unregistered (ID= ' + inttostr(lPC.ID) + ')');
  end;
end;

function TTCPClient.getState: TSocketState;
begin
  result := WSocket.State;
end;

procedure TTCPClient.DataSent(Sender: TObject; Error: word);
begin
  FLog.Add('Sent: ' + Sender.ClassName + ' - ' + inttostr(Error));
end;

procedure TTCPClient.RegisterProcedure(aType: word; aProcedure: TCPT_PROCEDURE; recordSize: word);
var
  lastLength: integer;
  i: integer;
begin
  lastLength := length(arrayProcedure);
  if aType >= lastLength then
  begin
    SetLength(arrayProcedure, aType + 1);
    SetLength(arrSize, aType + 1);
    for i := lastLength to aType do
    begin
      arrSize[i] := 0;
    end;
  end;
  if recordSize > FLargestRecordSize  then
    FLargestRecordSize := recordSize;

//  FLog.Add('Register ID :'+ FormatFloat('00', aType) +
  FLog.Add('Register ID :'+ Format('%0.2d', [aType]) +
            ' as ' + C_REC_PACKETNAME[aType]+
            ' size ' + IntToStr(recordSize) );
//  FLog.Add('Largest Registered Packet size is ' + IntToStr(FLargestRecordSize));

  arrayProcedure[aType] := aProcedure;
  arrSize[aType] := recordSize;
end;

procedure TTCPClient.HandleException(AE: exception;
  AClient: TWSocket);
begin
  if (AE is ESocketException) then
  begin
    FLog.Add(TimeToStr(Now) + ': Error accured: ' + AE.Message);
    FLog.Add(TimeToStr(Now) + ': Closing client ...');
    AClient.Close;
  end
  else
  begin
    FLog.Add(TimeToStr(Now) + ': Unhandled exception raised!');
  end;
end;

end.
