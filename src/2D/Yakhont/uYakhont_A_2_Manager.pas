unit uYakhont_A_2_Manager;

interface

uses
  Classes, uTCPClient;

  type
  TYakhont_A_2_Manager = class
  private
  public
    NetCommLocalClient : TTCPClient;
    LogMemo   : TStrings;
    ServerIp  : string;
    ServerPort: string;

    ShouldConnect : boolean;

    StandAloneMode   : Boolean;
    pCurrentScenID   : integer;

    pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
    pShipName, pClassName : string;
    pShipID, pClassID : Integer;

    constructor Create;
    destructor Destroy;

    procedure BeginSimulation;
    procedure EndSimulation;
    procedure CreateObject;
    procedure SetLayOutForm;

    procedure Initialize;
    procedure Net_Connect;
    procedure Net_Disconnect;

    procedure AddToMemoLog(const str: string);
  end;

var
  Yakhont_A_2_Manager : TYakhont_A_2_Manager;

implementation

uses
  OverbyteIcswSocket, uBridgeSet, uTCPDatatype, SysUtils;

constructor TYakhont_A_2_Manager.Create;
begin
  NetCommLocalClient := TTCPClient.Create;
end;

destructor TYakhont_A_2_Manager.Destroy;
begin
  NetCommLocalClient.Free;
end;

procedure TYakhont_A_2_Manager.BeginSimulation;
begin
  //create Object2-nya
  CreateObject;
  SetLayOutForm;

  //Register Packet-packet Net
  //------------------------------------------------------------ Local
  NetCommLocalClient.RegisterProcedure(REC_CMD_Yakhont, nil, SizeOf(TRecCMD_YAkhont));

  //------------------------------------------------------------ To Instruktur

  Net_Connect;
end;

procedure TYakhont_A_2_Manager.EndSimulation;
begin
  Yakhont_A_2_Manager.Free;
end;

procedure TYakhont_A_2_Manager.CreateObject;
begin
  NetCommLocalClient.setLog(TStringList(LogMemo));

  // Create Form ---------------------------------------------------

  // Show Form -----------------------------------------------------

end;

procedure TYakhont_A_2_Manager.SetLayOutForm;
begin

end;

procedure TYakhont_A_2_Manager.Initialize;
var
  i, n : integer ;
  str : string ;
begin
  n := ParamCount ;
  if n < max_param then
    StandAloneMode := true
  else
  begin
     StandAloneMode := false ;
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
      pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );
  end;
end;

procedure TYakhont_A_2_Manager.Net_Connect;
var
  p : Integer;
begin
  p := StrToInt(pServer_Port) + 1;

  NetCommLocalClient.Connect(pServer_Ip,  IntToStr(p));
  if NetCommLocalClient.State = wsConnected then
    ShouldConnect := true;
end;

procedure TYakhont_A_2_Manager.Net_Disconnect;
begin
  ShouldConnect := false;
  NetCommLocalClient.Disconnect;
end;

procedure TYakhont_A_2_Manager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

end.
