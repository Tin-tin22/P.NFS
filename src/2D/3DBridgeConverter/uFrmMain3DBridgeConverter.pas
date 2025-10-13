unit uFrmMain3DBridgeConverter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  Tfrm3DBridgeConverter = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    lbl2DServerPort: TLabel;
    mmoLog: TMemo;
    lbClients: TListBox;
    Label2: TLabel;
    lbl3DServerPrt: TLabel;
    mmoLogClient: TMemo;
    mmoLogClientData: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }


    procedure NetLinkServer_OnClientStatus2D(const str: string);
    procedure OnLogReceived2D(const s: string);
    procedure OnLogListenPort2D(const s: string);

    procedure NetLinkServer_OnClientStatus(const sl: TStringList);
    procedure OnLogReceived(const s: string);
    procedure OnLogListenPort3D(const s: string);
  end;

var
  frm3DBridgeConverter: Tfrm3DBridgeConverter;

implementation

{$R *.dfm}

uses uManagerBridge;

{ TForm1 }

procedure Tfrm3DBridgeConverter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BridgeManager.StopSimulation;
  BridgeManager.Free;
end;

procedure Tfrm3DBridgeConverter.FormCreate(Sender: TObject);
begin
  //  //create bridge manager
  BridgeManager := TBridgeManager.Create;

  BridgeManager.ONetLinkServer_OnClientStatus2D := frm3DBridgeConverter.NetLinkServer_OnClientStatus2D;
  BridgeManager.OnLogReceived2D := frm3DBridgeConverter.OnLogReceived2D;
  BridgeManager.OnLogListenPort2D := frm3DBridgeConverter.OnLogListenPort2D;

  BridgeManager.SetLog2DServer(TStringList(frm3DBridgeConverter.mmoLogClientData.Lines));

  BridgeManager.ONetLinkServer_OnClientStatus := frm3DBridgeConverter.NetLinkServer_OnClientStatus;
  BridgeManager.OnLogReceived := frm3DBridgeConverter.OnLogReceived;
  BridgeManager.OnLogListenPort3D := frm3DBridgeConverter.OnLogListenPort3D;

  BridgeManager.InitSimulation;
  BridgeManager.RunSimulation;
end;

procedure Tfrm3DBridgeConverter.NetLinkServer_OnClientStatus(const sl: TStringList);
begin
   lbClients.Items.Assign(sl);
end;

procedure Tfrm3DBridgeConverter.OnLogListenPort2D(const s: string);
begin
  lbl2DServerPort.Caption := s;
end;

procedure Tfrm3DBridgeConverter.OnLogListenPort3D(const s: string);
begin
  lbl3DServerPrt.Caption := s;
end;

procedure Tfrm3DBridgeConverter.OnLogReceived(const s: string);
begin
  mmoLog.Lines.Add(s);
end;


procedure Tfrm3DBridgeConverter.NetLinkServer_OnClientStatus2D(
  const str: string);
begin
  mmoLogClient.Lines.Add(str);
end;

procedure Tfrm3DBridgeConverter.OnLogReceived2D(const s: string);
begin
  mmoLogClientData.Lines.Add(s);
end;

end.
