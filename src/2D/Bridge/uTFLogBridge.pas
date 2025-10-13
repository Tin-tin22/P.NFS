unit uTFLogBridge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,

  uBridgeManager;

type
  TTFLogBridge = class(TForm)
    pnlMain: TPanel;
    pnlClient: TPanel;
    pnlServer: TPanel;
    mLogClient: TMemo;
    mLogServer: TMemo;
    pnlClientUp: TPanel;
    pnlServerUp: TPanel;                              
    pnlClientBottom: TPanel;
    pnlSetting: TPanel;
    pnlSettingUp: TPanel;
    mLogSetting: TMemo;
    pnlPacket: TPanel;
    pnlUppacket: TPanel;
    mmoPacket: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TimerTerminate : TTimer;

    procedure onTimerTerminateRun(sender : Tobject);

    procedure OnLogPnlClient3D(str: string);
    procedure OnLogServer2D(str: string);
    procedure OnLogClient3D(str: string);
    procedure OnLogPacket(str : string);
    procedure OnLogSettingSocket( m2D_IP, m2D_Port, m3D_IP, m3D_Port : string );
    procedure OnLogSettingDB( mDBServer, mDBProto, mDBName, mDBUser, mDBPass, mDBPort : string);

    procedure PrepareStopSimulation;
  end;

var
  TFLogBridge: TTFLogBridge;

implementation

{$R *.dfm}

{ TTFLogBridge }

procedure TTFLogBridge.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PrepareStopSimulation;
end;

procedure TTFLogBridge.FormCreate(Sender: TObject);
begin
  TimerTerminate := TTimer.Create(nil);
  TimerTerminate.Enabled  := false;
  TimerTerminate.Interval := 200;
  TimerTerminate.OnTimer  := onTimerTerminateRun;
end;

procedure TTFLogBridge.OnLogClient3D(str: string);
begin
  if mLogClient.Lines.Count > 100 then mLogClient.Lines.Clear;
  mLogClient.Lines.Insert(0, str);
end;

procedure TTFLogBridge.OnLogPacket(str: string);
begin
   if mmoPacket.Lines.Count > 100 then mmoPacket.Lines.Clear;
  mmoPacket.Lines.Insert(0, str);
end;

procedure TTFLogBridge.OnLogPnlClient3D(str: string);
begin
  pnlClientBottom.Caption := str;
end;

procedure TTFLogBridge.OnLogServer2D(str: string);
begin
  if mLogServer.Lines.Count > 100 then mLogServer.Lines.Clear;
  mLogServer.Lines.Insert(0, str);
end;

procedure TTFLogBridge.OnLogSettingDB(mDBServer, mDBProto, mDBName, mDBUser,
  mDBPass, mDBPort: string);
begin
  mLogSetting.Lines.Add('DB Server : ' + mDBServer);
  mLogSetting.Lines.Add('DB Proto  : ' + mDBProto);
  mLogSetting.Lines.Add('DB Name   : ' + mDBName);
  mLogSetting.Lines.Add('DB User   : ' + mDBUser);
  mLogSetting.Lines.Add('DB Pass   : ' + mDBPass);
  mLogSetting.Lines.Add('DB Port   : ' + mDBPort);
end;

procedure TTFLogBridge.OnLogSettingSocket(m2D_IP, m2D_Port, m3D_IP,
  m3D_Port: string);
begin
  mLogSetting.Lines.Add('3D Server : ' + m3D_IP);
  mLogSetting.Lines.Add('3D Port   : ' + m3D_Port);
  mLogSetting.Lines.Add('2D Server : ' + m2D_IP);
  mLogSetting.Lines.Add('2D Port   : ' + m2D_Port);
end;

procedure TTFLogBridge.onTimerTerminateRun(sender: Tobject);
begin
  TimerTerminate.Enabled := false;
  Application.Terminate;
end;

procedure TTFLogBridge.PrepareStopSimulation;
begin
  BridgeManager.PrepareStopSimulation;
  TimerTerminate.Enabled := True;
end;

end.
