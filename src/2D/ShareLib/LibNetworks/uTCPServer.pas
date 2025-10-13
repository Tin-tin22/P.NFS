unit uTCPServer;

interface

uses
  overbyteicsWSocket, overbyteicsWSocketS, Classes, SysUtils, Windows,
  uTCPDatatype  ;

const
  //BUFFER_SIZE= 1024 * 1024 * 20;
  //BUFFER_SIZE= 20 shl 20;
  BUFFER_SIZE= 16 * 1024;

type

  TCPT_PROCEDURE      = procedure(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient) of object;
  TCPT_ARRAY_PROCEDURE= array of TCPT_PROCEDURE;

  TOnClientConnect    = procedure(cmdClient : string) of object;
  TOnClientDisconnect = procedure(cmsClient : string) of object;

  TTCPServer= class(TObject)
  private
    FLog: TStringList;
    FRealLog: TStringList;
    //pLogPointer: Pointer;
    FLargestRecordSize : integer;

    procedure HandleException(AE: exception; AClient: TWSocket);
  public
    arrayProcedure: TCPT_ARRAY_PROCEDURE;
    arrSize: array of word;

    LoginList: TStringList;
    IPList: TStringList;
    isTimeServer: boolean;

    WSocketServer: TWSocketServer;

    OnClientConnect     : TOnClientConnect;
    OnClientDisConnect  : TOnClientDisconnect;

    constructor Create;
    destructor Destroy; override;

    property  Log: TStringList read FLog;

    procedure DoNothing;

    procedure setLog(aLog: TStringList);
    procedure Listen(aPort: string);
    procedure Stop;
    procedure SendData(Index: integer; aBuffer: PAnsiChar; size: integer);
    procedure SendDataEx(aID: byte; aBuffer: PAnsiChar; aClient: TWSocketClient);
    procedure PacketRecognizer(aP: PAnsiChar; aSize: integer; Sender: TObject);

    procedure BGException(Sender: TObject; E: Exception; var CanClose: Boolean);

    procedure ClientCreate(Sender: TObject; Client: TWSocketClient);
    procedure ClientConnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure ClientDisconnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure ClientDataAvailable(Sender: TObject; Error: Word);
    procedure ClientBGException(Sender: TObject; E: Exception; var CanClose: Boolean);

    procedure RegisterProcedure(aType: word; aProcedure: TCPT_PROCEDURE; recordSize: word);
    procedure UnregisterAllProcedure;
  end;

//  TClientThread = class(TThread)
//  private
//    FWSocket        : TWSocket;             { Reference to client socket  }
//    FThreadAttached : Boolean;              { TRUE once socket attached   }
//  public
//    procedure Execute; override;            { Main method                 }
//  published
//    property WSocket: TWSocket read FWSocket write FWSocket;
//    property ThreadAttached : Boolean read FThreadAttached write FThreadAttached;
//  end;

  TClientConnected= class(TWSocketClient)
  private
    //ClientThread: TClientThread;    

    FBuffer: PAnsiChar;
    FBufferNow: LongWord;
    FBufferSize: LongWord;
    FBufferSizeKnown: boolean;
  public
    ConnectTime: TDateTime;

    Login: String;

    isReady: boolean;
  end;

implementation

{ TTCPServer }

constructor TTCPServer.Create;
begin
  inherited;
  WSocketServer:= TWSocketServer.Create(nil);
  FLog:= TStringList.Create;
  FRealLog:= FLog;
  //pLogPointer:= pointer(FLog);

  LoginList:= TStringList.Create;
  IPList:= TStringList.Create;
  isTimeServer:= False;

  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  FLargestRecordSize := 0;
end;

destructor TTCPServer.Destroy;
begin
  WSocketServer.Free;
  WSocketServer:= nil;

  setLength(arrayProcedure, 0);
  setLength(arrSize, 0);

  if Pointer(FRealLog)= Pointer(FLog) then
  begin
    FLog.Free;
    FLog:= nil;
  end;

  LoginList.Clear;
  LoginList.Free;
  LoginList:= nil;

  IPList.Clear;
  IPList.Free;
  IPList:= nil;
  inherited;
end;

procedure TTCPServer.setLog(aLog: TStringList);
begin
  if aLog= nil then
  begin
    FRealLog.Assign(FLog);
    FLog:= FRealLog;
    exit;
  end;

  aLog.Assign(FLog);
  //if pLogPointer= Pointer(FLog) then
  if Pointer(FRealLog)= Pointer(FLog) then
    FLog.Clear;
  FLog:= aLog;
end;

procedure TTCPServer.Listen(aPort: string);
begin
  WSocketServer.OnClientConnect:= ClientConnect;
  WSocketServer.OnClientDisconnect:= ClientDisconnect;
  WSocketServer.OnClientCreate:= ClientCreate;
  WSocketServer.OnBgException:= BGException;
  WSocketServer.Proto:= 'tcp';
  WSocketServer.Port:= aPort;
  WSocketServer.Addr:= '0.0.0.0';

  WSocketServer.LineMode:= False;
  WSocketServer.LineEdit := False;
  WSocketServer.LineEcho := False;

  WSocketServer.ClientClass:= TClientConnected;
  WSocketServer.Banner:= '';
  //WSocketServer.BufSize:= 20 shl 10;

  WSocketServer.Listen;
  FLog.Add(DateTimeToStr(Now)+': '+'Server starting and listening ...');
end;

procedure TTCPServer.Stop;
begin
  WSocketServer.Close;
  FLog.Add(DateTimeToStr(Now)+': '+'Server stopped');
end;

procedure TTCPServer.SendData(Index: integer; aBuffer: PAnsiChar;
  size: integer);
begin
  if Index>= WSocketServer.ClientCount then
  begin
    raise Exception.Create('Index '+inttostr(Index)+' is out of bound');
    exit;
  end;

  if WSocketServer.Client[Index].State= wsConnected then
  begin
    WSocketServer.Client[Index].Send(aBuffer, size);
  end;
end;

procedure TTCPServer.SendDataEx(aID: byte; aBuffer: PAnsiChar;
  aClient: TWSocketClient);
var
  lBuffer: PAnsiChar;
  stamp: TPacketCheck;
  size: longword;
  strTemp: string;
  i: integer;
begin
  //if aID<= length(arrayProcedure) then
  if (aID<= length(arrayProcedure)) and (arrSize[aID]> 0) then
  begin
    strTemp:= 'Send: ID '+ inttostr(aID) +'  ' + C_REC_PACKETNAME[aID]
     + ' Size ' + IntToStr(arrSize[aID]) ;

    stamp.ID:= aID;
    stamp.Pass:= PACKET_PASS;
    CopyMemory(aBuffer, @stamp, sizeof(TPacketCheck));
    size:= arrSize[aID];

    getMem(lBuffer, size+ 4);
    CopyMemory(lBuffer, @size, 4);
    CopyMemory(lBuffer+4, aBuffer, size);

    if aClient<> nil then
    begin
      if aClient.State= wsConnected then
      begin
        { TODO -oArmand : Ini buat apa ya? }
        {
        while not aClient.AllSent do
        begin
          FLog.Add('AllSent is false, pending ...');
          aClient.ProcessMessages;
        end;
        }
        if not aClient.AllSent then
          FLog.Add(TimeToStr(Now)+ ': AllSent flag is false');

        FLog.Add(TimeToStr(Now)+': '+strTemp);
        try
          aClient.send(lBuffer, size+ 4);
        except
          on e: exception do HandleException(e, aClient);
        end; //end exception
      end;
    end
    else
    begin
      for i:= 0 to WSocketServer.ClientCount-1 do
      begin
        //if (WSocketServer.Client[i].State= wsConnected) and (TClientConnected(WSocketServer.Client[i]).isReady) then
        if (WSocketServer.Client[i]<> nil) and (WSocketServer.Client[i].State= wsConnected) then
        begin
          { TODO -oArmand : Ini buat apa ya? }
          {
          while not WSocketServer.Client[i].AllSent do
          begin
            FLog.Add('AllSent is false, pending ...');
            WSocketServer.Client[i].ProcessMessages;
          end;
          }
          if not WSocketServer.Client[i].AllSent then
            FLog.Add(TimeToStr(Now)+ ': AllSent flag is false');

          FLog.Add(TimeToStr(Now)+': '+strTemp + ', to: '+
             WSocketServer.Client[i].GetPeerAddr);
          try
            WSocketServer.Client[i].send(lBuffer, size + 4);
          except
            on e: exception do HandleException(e, WSocketServer.Client[i]);
          end; //end exception
        end;
      end;
    end;
    freeMem(lBuffer);
  end
  else
  begin
    FLog.Add(TimeToStr(Now)+': '+'Trying to send unknown packet (ID= '+ inttostr(aID)+')');
  end;
end;

procedure TTCPServer.ClientCreate(Sender: TObject; Client: TWSocketClient);
begin
  {  Entah kenapa kalo pake thread ada packet yang gak dikirim...
     Apa modelku yang salah ya?
     - Armand
  with Client as TClientConnected do
  begin
    Client.ThreadDetach;
    Client.MultiThreaded         := TRUE;
    ClientThread                 := TClientThread.Create(TRUE);
    ClientThread.FreeOnTerminate := TRUE;
    ClientThread.WSocket         := Client;
    ClientThread.Suspended       := FALSE;
    // Wait until thread is started and has attached client socket to
    // his own context.
    while not ClientThread.ThreadAttached do
      Sleep(0);
  end;
  }
end;

procedure TTCPServer.ClientConnect(Sender: TObject; Client: TWSocketClient;
  Error: Word);
begin
  GetMem(TClientConnected(Client).FBuffer, BUFFER_SIZE);
  TClientConnected(Client).FBufferSize:= 0;
  TClientConnected(Client).FBufferNow:= 0;
  TClientConnected(Client).FBufferSizeKnown:= False;

  TClientConnected(Client).isReady:= False;
  TClientConnected(Client).Login:= '';

  TClientConnected(Client).LineMode:= False;
  TClientConnected(Client).LineEdit := False;
  TClientConnected(Client).LineEcho := False;
  TClientConnected(Client).OnDataAvailable:= ClientDataAvailable;
  TClientConnected(Client).OnBgException:= ClientBgException;
  TClientConnected(Client).ConnectTime:= Now;
  //TClientConnected(Client).BufSize:= 20 shl 10;

  FLog.Add(DateTimeToStr(Now)+': '+'Client connecting from ' + TClientConnected(Client).PeerAddr);

  //Nando Added For Parsing IP Client Connect
  if Assigned(OnClientConnect) then
    OnClientConnect(TClientConnected(Client).PeerAddr);
end;

procedure TTCPServer.ClientDisconnect(Sender: TObject;
  Client: TWSocketClient; Error: Word);
var
  i: integer;
begin
  FreeMem(TClientConnected(Client).FBuffer);
  FLog.Add(DateTimeToStr(Now)+': '+'Client disconnecting from ' + TClientConnected(Client).PeerAddr +
          ', duration: '+ FormatDateTime('hh:nn:ss',Now - TClientConnected(Client).ConnectTime));

  //Nando Added For Parsing IP Client Disonnect
  if Assigned(OnClientDisConnect) then
    OnClientDisConnect(TClientConnected(Client).PeerAddr);

  i:= IPList.IndexOf(TClientConnected(Client).PeerAddr);
  if i>= 0 then
  begin
    IPList.Delete(i);
    LoginList.Delete(i);
  end;
end;

procedure TTCPServer.ClientBGException(Sender: TObject; E: Exception;
  var CanClose: Boolean);
begin
  FLog.Add(TimeToStr(Now)+': '+'Client exception occured: ' + E.ClassName + ': ' + E.Message);
  CanClose := True; //Bye bye client!
end;

procedure TTCPServer.BGException(Sender: TObject; E: Exception;
  var CanClose: Boolean);
begin
  FLog.Add(TimeToStr(Now)+': '+'Server exception occured: ' + E.ClassName + ': ' + E.Message);
  CanClose := False; //Bye bye client!
end;

procedure TTCPServer.ClientDataAvailable(Sender: TObject; Error: Word);
var
  buffer: PAnsiChar;
  receivedByte: integer;
  len: integer;
  p, p2: pointer;
  {
  i: integer;
  strHex: sting;
  }
  bLoop: Boolean;
begin
  receivedByte:= TWSocket(Sender).RcvdCount;
  FLog.Add(TimeToStr(Now)+'Recv: '+ inttostr(receivedByte) + ' byte from ' + TClientConnected(Sender).PeerAddr + ' available');

  if receivedByte < 1  then exit;

  GetMem(buffer, receivedByte);
  len:= TClientConnected(Sender).Receive(buffer, receivedByte);
  if len <= 0 then
  begin
    FLog.Add(TimeToStr(Now)+': '+ 'packet with length '+ inttostr(len) + 'received!');
    exit;
  end;

  p:= TClientConnected(Sender).FBuffer+ TClientConnected(Sender).FBufferNow;
  CopyMemory(PAnsiChar(p), buffer, len);
  inc(TClientConnected(Sender).FBufferNow, len);

  bLoop:= True;
  while bLoop do
  begin
    if (not TClientConnected(Sender).FBufferSizeKnown) and (TClientConnected(Sender).FBufferNow>= 4) then
    begin
      CopyMemory(@(TClientConnected(Sender).FBufferSize), TClientConnected(Sender).FBuffer, 4);
      TClientConnected(Sender).FBufferSizeKnown:= True;
    end;

    if (TClientConnected(Sender).FBufferSizeKnown) and (TClientConnected(Sender).FBufferNow>= TClientConnected(Sender).FBufferSize+ 4) then
    begin
      p:= TClientConnected(Sender).FBuffer+ 4;
      PacketRecognizer(p, TClientConnected(Sender).FBufferSize, Sender);

      if TClientConnected(Sender).FBufferNow>TClientConnected(Sender).FBufferSize+ 4 then
      begin
        p:= TClientConnected(Sender).FBuffer+ (TClientConnected(Sender).FBufferSize+ 4);
        TClientConnected(Sender).FBufferNow:= TClientConnected(Sender).FBufferNow- (TClientConnected(Sender).FBufferSize+ 4);

        GetMem(p2, TClientConnected(Sender).FBufferNow);
        CopyMemory(p2, p, TClientConnected(Sender).FBufferNow);
        CopyMemory(TClientConnected(Sender).FBuffer, p2, TClientConnected(Sender).FBufferNow);
        FreeMem(p2);

        //CopyMemory(TClientConnected(Sender).FBuffer, p, TClientConnected(Sender).FBufferNow);
        //TClientConnected(Sender).FBufferSize:= 0;
        TClientConnected(Sender).FBufferSizeKnown:= False;
      end
      else
      begin
        TClientConnected(Sender).FBufferSize:= 0;
        TClientConnected(Sender).FBufferNow:= 0;
        TClientConnected(Sender).FBufferSizeKnown:= False;
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

procedure TTCPServer.PacketRecognizer(aP: PAnsiChar; aSize: integer; Sender: TObject);
var
  lPc: TPacketCheck;
begin
  CopyMemory(@lPc, aP, sizeof(TPacketCheck));
  if lPc.Pass<> PACKET_PASS then
  begin
    FLog.Add(TimeToStr(Now)+': '+'Packet password is wrong');
    Exit;
  end;

  if lPc.ID<= length(arrayProcedure) then
  begin
    if Assigned(arrayProcedure[lPc.ID]) then
    begin
      FLog.Add(TimeToStr(Now)+': '+' (ID= '+ inttostr(lPC.ID)+')'
        + C_REC_PACKETNAME[lPC.id] );
      arrayProcedure[lPc.ID](aP, arrSize[lPc.ID], TWSocketClient(Sender));
    end
    else
      FLog.Add(DateTimeToStr(Now)+': '+'Unidentified data available (ID= '+ inttostr(lPC.ID)+')');
  end
  else
  begin
    FLog.Add(DateTimeToStr(Now)+': '+'Unidentified data available (ID= '+ inttostr(lPC.ID)+')');
  end;
end;

procedure TTCPServer.DoNothing;
begin

end;

procedure TTCPServer.RegisterProcedure(aType: word;
  aProcedure: TCPT_PROCEDURE; recordSize: word);
var
  lastLength: integer;
  i: integer;
begin
  lastLength:= length(arrayProcedure);
  if aType>= lastLength then
  begin
    SetLength(arrayProcedure, aType+ 1);
    SetLength(arrSize, aType+ 1);
    for i:= lastLength to aType do
    begin
      arrSize[i]:= 0;
    end;
  end;
  if recordSize > FLargestRecordSize  then
    FLargestRecordSize := recordSize;

  FLog.Add('Register ID: '+ IntToStr(aType) +
            ' as ' + C_REC_PACKETNAME[aType]+
            ' size ' + IntToStr(recordSize) );
//  FLog.Add('Largest Registered Packet size is ' + IntToStr(FLargestRecordSize));

  arrayProcedure[aType]:= aProcedure;
  arrSize[aType]:= recordSize;
end;

procedure TTCPServer.UnregisterAllProcedure;
var
  i: integer;
begin
  for i := length(arrayProcedure) - 1 downto 0 do
  begin
    arrayProcedure[i] := nil;
    arrSize[i] := 0;
  end;

  SetLength(arrayProcedure, 0);
  SetLength(arrSize, 0);
end;

procedure TTCPServer.HandleException(AE: exception; AClient: TWSocket);
begin
  if (AE is ESocketException) then
  begin
    FLog.Add(TimeToStr(Now)+': Error accured: ' + AE.Message);
    FLog.Add(TimeToStr(Now)+': Closing client ...');
    AClient.Close;
  end
  else
  begin
    FLog.Add(TimeToStr(Now)+': Unhandled exception raised!');
  end;
end;

{ TClientThread }

//procedure TClientThread.Execute;
//begin
//  if not Assigned(WSocket) then
//    Exit;
//
//  { Attach client socket to this thread                                   }
//  WSocket.ThreadAttach;
//  { Signal main thread that we've attached socket to this thread          }
//  ThreadAttached := TRUE;
//  { Now let main thread continue starting the connection.                 }
//  { This little avoid race condition.                                     }
//  Sleep(0);
//  { Then process messages until WM_QUIT message is posted.                }
//  { TWSocket is event-driven. So even when used within a thread, we       }
//  { have to have a "message pump". Any message pump will do and there     }
//  { is one built in TWSocket, so use it !                                 }
//  WSocket.MessageLoop;
//  { Be sure to have main thread waiting for termination before terminating}
//  Sleep(0);
//  { Detach the hidden window from within the thread                       }
//  WSocket.ThreadDetach;
//end;

end.

