unit uTCPClient;

interface

uses
  WSocket, WSocketS, Classes, SysUtils, Windows;

const
  //PORT= '2120';
  PACKET_PASS= 'SKL';
  BUFFER_SIZE= 1024 * 1024 * 20;

type
  TPacketCheck= record
    ID: byte;
    Pass: array[0..2] of char;
  end;

  TCPT_PROCEDURE      = procedure(apRec: PAnsiChar; aSize: integer) of object;
  TCPT_ARRAY_PROCEDURE= array of TCPT_PROCEDURE;

  TTCPClient= class(TObject)
  private
    FLog: TStringList;
    WSocket: TWSocket;

    FBuffer: PAnsiChar;
    FBufferSize: LongWord;
    FBufferNow: LongWord;
    FBufferSizeKnown: boolean;

    arrayProcedure: TCPT_ARRAY_PROCEDURE;
    arrSize: array of word;

    bLogChanged: boolean;

    function getState: TSocketState;
  public
    property State: TSocketState read getState;

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

{ TClientSocket }

constructor TTCPClient.Create;
begin
  inherited Create;

  WSocket:= TWSocket.Create(nil);
  FLog:= TStringList.Create;

  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  WSocket.OnDataSent:= DataSent;
end;

destructor TTCPClient.Destroy;
begin
  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  WSocket.OnDataSent := nil;

  WSocket.Free;
  WSocket := nil;

  if not bLogChanged then
  begin
    FLog.Clear;
    FLog.Free;
    FLog:= nil;
  end;

  inherited;
end;

procedure TTCPClient.Connect(aAddr, aPort: string);
begin
  if (WSocket.State <> wsConnected) and (WSocket.State <> wsConnecting) then
  begin
    GetMem(FBuffer, BUFFER_SIZE);
    FBufferSize:= 0;
    FBufferNow:= 0;
    FBufferSizeKnown:= False;

    WSocket.OnDataAvailable:= dataAvailable;
    WSocket.Proto:= 'tcp';
    WSocket.LineMode:= False;
    WSocket.LineEdit := False;
    WSocket.LineEcho := False;
    WSocket.Port:= aPort;
    WSocket.Addr:= aAddr;
    FLog.Add(DateTimeToStr(Now)+': '+'Connecting ...');
    WSocket.Connect;
    While WSocket.State in [wsConnecting] do
      WSocket.ProcessMessages;
    if WSocket.State= wsConnected then
      FLog.Add(DateTimeToStr(Now)+': '+'Connected')
    else
      FLog.Add(DateTimeToStr(Now)+': '+'Not connected')
  end;
end;

procedure TTCPClient.Disconnect;
begin
  FLog.Add(DateTimeToStr(Now)+': '+'Disconnecting ...');
  WSocket.Close;
  WSocket.OnDataAvailable := nil;
  FreeMem(FBuffer);
  FLog.Add(DateTimeToStr(Now)+': '+'Disconnected');
end;

procedure TTCPClient.sendData(buffer: PAnsiChar; size: integer);
begin
  if WSocket.State= wsConnected then
  begin
    { TODO -oArmand : Ini buat apa ya? }
    if not WSocket.AllSent then
      raise Exception.Create('in process...');

    FLog.Add(DateTimeToStr(Now)+': '+'Sending data');
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
  strTemp:= 'Sending: ID '+ inttostr(aID);
  stamp.ID:= aID;
  stamp.Pass:= PACKET_PASS;
  CopyMemory(aBuffer, @stamp, sizeof(TPacketCheck));
  size:= arrSize[aID];
  //size:= sizeof(TRecDataOrderWeather);

  getMem(lBuffer, size+ 4);
  CopyMemory(lBuffer, @size, 4);
  CopyMemory(lBuffer+4, aBuffer, size);

  if WSocket.State= wsConnected then
  begin
    { TODO -oArmand : Ini buat apa ya? }
    //if not WSocket.AllSent then
    //  raise Exception.Create('cannot send packet, in process...');
    while not WSocket.AllSent do
    begin
      FLog.Add('AllSent is false, pending ...');
      WSocket.ProcessMessages;
    end;

    FLog.Add(DateTimeToStr(Now)+': '+strTemp);
    WSocket.Send(lBuffer, size+ 4);
  end;

  freeMem(lBuffer);
end;

procedure TTCPClient.setLog(aLog: TStringList);
begin
  aLog.Assign(FLog);
  FLog.Free;
  FLog:= aLog;
  bLogChanged:= True;
end;

procedure TTCPClient.dataAvailable(Sender: TObject; Error: Word);
var
  buffer: PAnsiChar;
  receivedByte: integer;
  len: integer;
  p, p2: pointer;
  {
  i: integer;
  strHex: string;
  }
  bLoop: boolean;
begin
  receivedByte:= TWSocket(Sender).RcvdCount;
  GetMem(buffer, receivedByte);
  FLog.Add(DateTimeToStr(Now)+': '+ inttostr(receivedByte) + ' length data from ' + TWSocket(Sender).PeerAddr + ' available');
  len:= TWSocket(Sender).Receive(buffer, receivedByte);
  if len <= 0 then
  begin
    FLog.Add(DateTimeToStr(Now)+': '+ 'Error receiving data or zero length packet');
    exit;
  end;

  p:= FBuffer+ FBufferNow;
  CopyMemory(PAnsiChar(p), buffer, receivedByte);
  inc(FBufferNow, receivedByte);

  bLoop:= True;
  while bLoop do
  begin
    if (not FBufferSizeKnown) and (FBufferNow>= 4) then
    begin
      CopyMemory(@(FBufferSize), FBuffer, 4);
      FBufferSizeKnown:= True;
    end;

    if (FBufferSizeKnown) and (FBufferNow>= FBufferSize+ 4) then
    begin
      p:= FBuffer+ 4;
      PacketRecognizer(p, FBufferSize);

      if FBufferNow>FBufferSize+ 4 then
      begin
        p:= FBuffer+ (FBufferSize+ 4);
        FBufferNow:= FBufferNow- (FBufferSize+ 4);

        GetMem(p2, FBufferNow);
        CopyMemory(p2, p, FBufferNow);
        CopyMemory(FBuffer, p2, FBufferNow);
        FreeMem(p2);

        //CopyMemory(FBuffer, p, FBufferNow);
        //FBufferSize:= 0;
        FBufferSizeKnown:= False;
      end
      else
      begin
        FBufferSize:= 0;
        FBufferNow:= 0;
        FBufferSizeKnown:= False;
      end;
    end
    else
      bLoop:= False;
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
  if lPc.Pass<> PACKET_PASS then
  begin
    FLog.Add(DateTimeToStr(Now)+': '+'Packet password is wrong');
    Exit;
  end;

  if Assigned(arrayProcedure[lPc.ID]) then
    arrayProcedure[lPc.ID](aP, arrSize[lPc.ID])
  else
    FLog.Add(DateTimeToStr(Now)+': '+'Unidentified data available (ID= '+ inttostr(lPC.ID)+')');
end;

function TTCPClient.getState: TSocketState;
begin
  result:= WSocket.State;
end;

procedure TTCPClient.DataSent(Sender: TObject; Error: word);
begin
  FLog.Add('Data sent: '+ Sender.ClassName+' - '+ inttostr(Error));
end;

procedure TTCPClient.RegisterProcedure(aType: word; aProcedure: TCPT_PROCEDURE; recordSize: word);
begin
  if aType>= length(arrayProcedure) then
  begin
    SetLength(arrayProcedure, aType+ 1);
    SetLength(arrSize, aType+ 1);
  end;
  arrayProcedure[aType]:= aProcedure;
  arrSize[aType]:= recordSize;
end;

end.

