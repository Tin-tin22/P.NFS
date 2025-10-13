unit uClientSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Winsock, StdCtrls;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..100] of TNetResource;

  TfrmSetting = class(TForm)
    Button2: TButton;
    Button1: TButton;
    Memo1: TMemo;
    gbDB: TGroupBox;
    Label2: TLabel;
    eDBServer: TComboBox;
    gbServer: TGroupBox;
    e3DServerIP: TComboBox;
    Label3: TLabel;
    Label1: TLabel;
    e2DServerIP: TComboBox;
    e3DServerPort: TEdit;
    e2DServerPort: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    eDBName: TEdit;
    eDBUser: TEdit;
    eDBPass: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    //mShipID, mShipClassID: integer;
  public
    { Public declarations }

  end;

var
  frmSetting: TfrmSetting;

implementation

uses uPubProc, uBridgeSet, uClient3D;

{$R *.dfm}

 
procedure TfrmSetting.Button1Click(Sender: TObject);
var
  s : string ;
begin
  s := GetEmulatorSettingDirectory;
  frmMain.m2DServerIP := e2DServerIP.Text;
  frmMain.m2DServerPort := e2DServerPort.Text;
  frmMain.m3DServerIP := e3DServerIP.Text;
  frmMain.m3DServerPort := e3DServerPort.Text;
  frmMain.mDBServer := eDBServer.Text;
  frmMain.mDBName := eDBName.Text;
  frmMain.mDBUser := eDBUser.Text;
  frmMain.mDBPass := eDBPass.Text;
  SaveDefault_DBConfig(s, frmMain.mDBServer, frmMain.mDBProto, frmMain.mDBName, frmMain.mDBUser, frmMain.mDBPass);
  SaveDefault_GameServerConfig(s, frmMain.m2DServerIP, frmMain.m2DServerPort, frmMain.m3DServerIP, frmMain.m3DServerPort);
  SaveDefault_ShipConfig(s, frmMain.mShipID, frmMain.mShipClassID, frmMain.mShipName, frmMain.mShipClassName);
end;

procedure TfrmSetting.FormShow(Sender: TObject);
var
  s : string ;
begin
  s := GetEmulatorSettingDirectory;
  InitDefault_DBConfig(s, frmMain.mDBServer, frmMain.mDBProto, frmMain.mDBName, frmMain.mDBUser, frmMain.mDBPass);
  InitDefault_GameServerConfig(s, frmMain.m2DServerIP, frmMain.m2DServerPort, frmMain.m3DServerIP, frmMain.m3DServerPort);
  InitDefault_ShipConfig(s, frmMain.mShipID, frmMain.mShipClassID, frmMain.mShipName, frmMain.mShipClassName);
  e2DServerIP.Text := frmMain.m2DServerIP;
  e2DServerPort.Text := frmMain.m2DServerPort;
  e3DServerIP.Text := frmMain.m3DServerIP;
  e3DServerPort.Text := frmMain.m3DServerPort;
  eDBServer.Text := frmMain.mDBServer;
  eDBName.Text := frmMain.mDBName;
  eDBUser.Text := frmMain.mDBUser;
  eDBPass.Text := frmMain.mDBPass;
end;

end.

