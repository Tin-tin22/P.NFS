unit uC802_ArchosManager;

interface

uses
  Classes, uTCPClient;

  type
  TC802_ArchosManager = class
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

    procedure EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer);

  end;

var
  C802_ArchosManager : TC802_ArchosManager;

implementation

uses
  OverbyteIcswSocket, uBridgeSet, uTCPDatatype, SysUtils, uFormUtil, FKeyboard,
  Forms;

constructor TC802_ArchosManager.Create;
begin
  NetCommLocalClient := TTCPClient.Create;
end;

destructor TC802_ArchosManager.Destroy;
begin
  NetCommLocalClient.Free;
end;

procedure TC802_ArchosManager.BeginSimulation;
begin
  //create Object2-nya
  CreateObject;
  SetLayOutForm;

  //Register Packet-packet Net
  //------------------------------------------------------------ Local
  NetCommLocalClient.RegisterProcedure(REC_CMD_C802, EventOnReceiveCommand, SizeOf(TRecCMD_C802));

  //------------------------------------------------------------ To Instruktur

  Net_Connect;
end;

procedure TC802_ArchosManager.EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer);
begin
  EndSimulation;
  Application.Terminate;
end;

procedure TC802_ArchosManager.EndSimulation;
begin
  C802_ArchosManager.Free;
end;

procedure TC802_ArchosManager.CreateObject;
begin
  NetCommLocalClient.setLog(TStringList(LogMemo));

  // Create Form ---------------------------------------------------

  // Show Form -----------------------------------------------------

end;

procedure TC802_ArchosManager.SetLayOutForm;
begin
  AlignFormToMonitor(0, apCenter, 0, 0, TForm(Keyboard_Form));

  Keyboard_Form.Show;
end;

procedure TC802_ArchosManager.Initialize;
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

  SetLayOutForm;

end;

procedure TC802_ArchosManager.Net_Connect;
var
  p : Integer;
begin
  p := StrToInt(pServer_Port) + 1;

  NetCommLocalClient.Connect(pServer_Ip,  IntToStr(p));
  if NetCommLocalClient.State = wsConnected then
    ShouldConnect := true;
end;

procedure TC802_ArchosManager.Net_Disconnect;
begin
  ShouldConnect := false;
  NetCommLocalClient.Disconnect;
end;

procedure TC802_ArchosManager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

end.
