unit uCMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTCPServer, OverbyteICSWSocketS, OverbyteICSWsocket, uTCPDataType;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
  public
    theServer: TTCPServer;
  end;

var
  frmMain: TfrmMain;

implementation

uses uCMServer, uBridgeSet, uBaseConstant, uDM,uLibSettings;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  path: string;
begin

  path := GetEmulatorSettingDirectory;
  InitDefault_GameServerConfig(path, m2DServerIP, m2DServerPort, m3DServerIP, m3DServerPort);
  InitDefault_DBConfig(path, mDBServer, mDBProto, mDBName, mDBUser, mDBPass);
  DM.SetDBConnection(mDBServer, mDBProto, mDBName, mDBUser, mDBPass);
  theServer := TTCPServer.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  theServer.Free;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  frmCMServer.ShowThisForm();
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  theServer.Stop;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  theServer.Listen(m2DServerPort);
end;

end.

