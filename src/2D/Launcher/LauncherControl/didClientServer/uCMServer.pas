unit uCMServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTCPServer, OverbyteICSWSocketS, OverbyteICSWsocket, uTCPDataType,
  ExtCtrls, ComCtrls, Menus, ToolWin, Buttons;

type
  TfrmCMServer = class(TForm)
    StatusBar1: TStatusBar;
    listClient: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    btRefresh: TSpeedButton;
    Panel3: TPanel;
    Memo1: TMemo;
    btnRun3DServer: TSpeedButton;
    btnRunClient: TSpeedButton;
    btStop: TSpeedButton;
    btReset: TSpeedButton;
    Edit1: TEdit;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    Run1: TMenuItem;
    Stop1: TMenuItem;
    Reset1: TMenuItem;
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btnRun3DServerClick(Sender: TObject);
    procedure btResetClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure btnRunClientClick(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
  private
    nCurrentScenario: integer;
    function GetCurrentScenarioIDAsString: string;
    function GetClientByIP(const pass: string): TWSocketClient;
    procedure AddToLogs(s: string);
    procedure RefreshClientList;
    procedure RemClientAddress(const cAddress: string);
    procedure AddClientAddress(const cAddress: string);
    procedure ServerSetDBAddressToClientConnected(cAdrress: string);
    procedure ServerSet3DAddressWhoRequested(cAdrress: string);
    procedure ServerSendResetToClientConnected(cAdrress: string);
    procedure ServerSendWelcomeToClientConnected(cAdrress: string);
    procedure ServerSendLaunchCommand(cStrValue: string);
    procedure ServerSendStopCommand(cStrValue: string);
  public
    procedure onRec2DOrderAvailable(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    function ShowThisForm(): integer;
  end;

var
  frmCMServer: TfrmCMServer;

implementation

uses StrUtils, uQuery, uCMMain, uBaseConstant, uDM, uCMSetting;

{$R *.dfm}

function TfrmCMServer.ShowThisForm(): integer;
begin
  Result := ShowModal;
end;

procedure TfrmCMServer.AddToLogs(s: string);
const
  c_time_format = '( HH:MM:SS )';
begin
  Memo1.Lines.Add(FormatDateTime(c_time_format, now) + ' ' + s);
end;

function TfrmCMServer.GetCurrentScenarioIDAsString: string;
begin
  Result := IntToStr(nCurrentScenario);
end;

procedure TfrmCMServer.onRec2DOrderAvailable(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
var
  aRec: ^TRecData2DOrder;
  OrderID: byte;
  numValue: integer;
  strValue: string;
  c_ip: string;
begin
  aRec := @apRec^;
  OrderID := aRec.orderID;
  numValue := aRec.numValue;
  strValue := aRec.strValue;
  c_ip := Sender.PeerAddr;
  case OrderID of
    _CM_CLIENT_MANAGE: begin
        case numValue of
          __CM_CLIENT_CONNECT: begin
              AddClientAddress(c_ip);
              AddToLogs('Client Connected from ' + c_ip);
              ServerSetDBAddressToClientConnected(c_ip);
              ServerSendWelcomeToClientConnected(c_ip);
            end;
          __CM_CLIENT_DISCONNECT: begin
              AddToLogs('Client disConnected from ' + c_ip);
              RemClientAddress(Sender.GetPeerAddr);
            end;
          __CM_CLIENT_REQ3D_ADDR: begin
              AddToLogs('Client ' + c_ip + ' request 3D Server.');
              ServerSet3DAddressWhoRequested(c_ip);
            end;
        end;
      end;
  end;
end;

function TfrmCMServer.GetClientByIP(const pass: string): TWSocketClient;
var
  i: integer;
  aClient: TWSocketClient;
  cAddress: string;
begin
  Result := nil;
  if frmMain.theServer.WSocketServer.ClientCount > 0 then begin
    for i := 0 to frmMain.theServer.WSocketServer.ClientCount - 0 do begin
      aClient := frmMain.theServer.WSocketServer.Client[i];
      if aClient <> nil then begin
        cAddress := aClient.PeerAddr;
        if cAddress = pass then
          Result := aClient;
      end;
    end;
  end;
end;

procedure TfrmCMServer.ServerSendResetToClientConnected(cAdrress: string);
begin
  ServerSendWelcomeToClientConnected(cAdrress);
  ServerSetDBAddressToClientConnected(cAdrress);
end;

procedure TfrmCMServer.ServerSendWelcomeToClientConnected(cAdrress: string);
var
  thePacket: TRecData2DOrder;
  aClient: TWSocketClient;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue := __CM_CLIENT_WELCOME;
    strValue := cAdrress;
  end;
  aClient := GetClientByIP(cAdrress);
  if aClient <> nil then begin
    if aClient.GetPeerAddr = cAdrress then begin
      frmMain.theServer.sendDataEx(REC_2D_ORDER, @thePacket, aClient);
      AddToLogs('Send welcome to ' + cAdrress);
    end;
  end;
end;

procedure TfrmCMServer.ServerSendLaunchCommand(cStrValue: string);
var
  thePacket: TRecData2DOrder;
  aClient: TWSocketClient;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_APP;
    numValue := __CM_CLIENT_LAUNCH;
    strValue := GetCurrentScenarioIDAsString;
  end;
  aClient := GetClientByIP(cStrValue);
  if aClient <> nil then begin
    if aClient.GetPeerAddr = cStrValue then begin
      frmMain.theServer.sendDataEx(REC_2D_ORDER, @thePacket, aClient);
      AddToLogs('Send launch command to ' + cStrValue);
    end;
  end;
end;

procedure TfrmCMServer.ServerSendStopCommand(cStrValue: string);
var
  thePacket: TRecData2DOrder;
  aClient: TWSocketClient;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_APP;
    numValue := __CM_CLIENT_STOP;
    strValue := '';
  end;
  aClient := GetClientByIP(cStrValue);
  if aClient <> nil then begin
    if aClient.GetPeerAddr = cStrValue then begin
      frmMain.theServer.sendDataEx(REC_2D_ORDER, @thePacket, aClient);
      AddToLogs('Send launch command to ' + cStrValue);
    end;
  end;
end;

procedure TfrmCMServer.ServerSetDBAddressToClientConnected(cAdrress: string);
var
  thePacket: TRecData2DOrder;
  aClient: TWSocketClient;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue := __CM_CLIENT_SETDB_ADDR;
    strValue := mDBServer;
  end;
  aClient := GetClientByIP(cAdrress);
  if aClient <> nil then begin
    if aClient.GetPeerAddr = cAdrress then begin
      frmMain.theServer.sendDataEx(REC_2D_ORDER, @thePacket, aClient);
      AddToLogs('Send set DB Server Address to ' + cAdrress);
    end;
  end;
end;

procedure TfrmCMServer.ServerSet3DAddressWhoRequested(cAdrress: string);
var
  thePacket: TRecData2DOrder;
  aClient: TWSocketClient;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue := __CM_CLIENT_SET3D_ADDR;
    strValue := m3DServerIP;
  end;
  aClient := GetClientByIP(cAdrress);
  if aClient <> nil then begin
    if aClient.GetPeerAddr = cAdrress then begin
      frmMain.theServer.sendDataEx(REC_2D_ORDER, @thePacket, aClient);
      AddToLogs('Send set DB Server Address to ' + cAdrress);
    end;
  end;
end;

procedure TfrmCMServer.RemClientAddress(const cAddress: string);
var
  li: TListItem;
  c_data: tDataApplication;
begin
  c_data := GetPCIDAndPCNameFromIPAddress(cAddress);
  li := listClient.FindCaption(0, IntToStr(c_data.c_id), false, true, false);
  if li <> nil then begin
    listClient.Items.Delete(li.Index);
  end;
end;

procedure TfrmCMServer.AddClientAddress(const cAddress: string);
var
  li: TListItem;
  c_data: tDataApplication;
begin
  c_data := GetPCConfigFromIPAddress(cAddress);
  li := listClient.FindCaption(0, IntToStr(c_data.c_id), false, true, false);
  if li = nil then begin
    li := listClient.Items.Add;
    li.Caption := IntToStr(c_data.c_id);
    if li.SubItems.Count < 1 then
      li.SubItems.Add(c_data.c_name)
    else
      li.SubItems[0] := c_data.c_name;
    if li.SubItems.Count < 2 then
      li.SubItems.Add(c_data.c_app_type_name)
    else
      li.SubItems[1] := c_data.c_app_type_name;
    if li.SubItems.Count < 3 then
      li.SubItems.Add(c_data.c_ip)
    else
      li.SubItems[2] := c_data.c_ip;
    if c_data.c_app_tipe = APP_3D_Server then m3DServerIP := cAddress;
  end;
end;

procedure TfrmCMServer.FormCreate(Sender: TObject);
begin
  if frmMain.theServer <> nil then begin
    frmMain.theServer.Stop;
    frmMain.theServer.RegisterProcedure(REC_2D_ORDER, frmCMServer.onRec2DOrderAvailable, sizeof(TRecData2DOrder));
    frmMain.theServer.Listen(m2DServerPort);
  end;
  Left := Screen.WorkAreaWidth - Width - 1;
  Top := Screen.WorkAreaHeight - Height - 1;
end;

procedure TfrmCMServer.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmCMServer.RefreshClientList;
var
  i: integer;
  aClient: TWSocketClient;
  li: TListItem;
  cAddress: string;
  c_data: tDataApplication;
begin
  if frmMain.theServer.WSocketServer.ClientCount > 0 then begin
    listClient.Clear;
    for i := 0 to frmMain.theServer.WSocketServer.ClientCount - 0 do begin
      aClient := frmMain.theServer.WSocketServer.Client[i];
      if aClient <> nil then begin
        cAddress := aClient.PeerAddr;
        c_data := GetPCConfigFromIPAddress(cAddress);
        if Length(Trim(cAddress)) > 0 then begin
          li := listClient.FindCaption(0, IntToStr(c_data.c_id), false, true, false);
          if li = nil then begin
            li := listClient.Items.Add;
            li.Caption := IntToStr(c_data.c_id);
            if li.SubItems.Count < 1 then
              li.SubItems.Add(c_data.c_name)
            else
              li.SubItems[0] := c_data.c_name;
            if li.SubItems.Count < 2 then
              li.SubItems.Add(c_data.c_app_type_name)
            else
              li.SubItems[1] := c_data.c_app_type_name;
            if li.SubItems.Count < 3 then
              li.SubItems.Add(c_data.c_ip)
            else
              li.SubItems[2] := c_data.c_ip;

          end;
          if c_data.c_app_tipe = APP_3D_Server then m3DServerIP := cAddress;
        end;
      end;
    end;
  end;
end;

procedure TfrmCMServer.btRefreshClick(Sender: TObject);
begin
  RefreshClientList;
end;

procedure TfrmCMServer.btnRun3DServerClick(Sender: TObject);
var
  i: integer;
  li: TListItem;
  cAddress: string;
  c_data: tDataApplication;
begin
  for i := 0 to listClient.Items.Count - 0 do begin
    li := listClient.Items.Item[i];
    if li <> nil then begin
      cAddress := li.SubItems[2];
      c_data := GetPCConfigFromIPAddress(cAddress);
      if c_data.c_app_tipe = APP_3D_Server then begin
        m3DServerIP := cAddress;
        ServerSendLaunchCommand(cAddress);
        Break;
      end;
    end;
  end;
end;

procedure TfrmCMServer.btnRunClientClick(Sender: TObject);
var
  i: integer;
  li: TListItem;
  cAddress: string;
  c_data: tDataApplication;
begin
  for i := 0 to listClient.Items.Count - 0 do begin
    li := listClient.Items.Item[i];
    if li <> nil then begin
      cAddress := li.SubItems[2];
      c_data := GetPCConfigFromIPAddress(cAddress);
      if c_data.c_app_tipe <> APP_3D_Server then begin
        ServerSendLaunchCommand(cAddress);
      end;
    end;
  end;
end;

procedure TfrmCMServer.btStopClick(Sender: TObject);
var
  i: integer;
  li: TListItem;
  cAddress: string;
  c_data: tDataApplication;
begin
  for i := 0 to listClient.Items.Count - 0 do begin
    li := listClient.Items.Item[i];
    if li <> nil then begin
      cAddress := li.SubItems[2];
      c_data := GetPCConfigFromIPAddress(cAddress);
      if c_data.c_app_tipe <> APP_3D_Server then begin
        ServerSendStopCommand(cAddress);
      end;
    end;
  end;
  for i := 0 to listClient.Items.Count - 0 do begin
    li := listClient.Items.Item[i];
    if li <> nil then begin
      cAddress := li.SubItems[2];
      c_data := GetPCConfigFromIPAddress(cAddress);
      if c_data.c_app_tipe = APP_3D_Server then begin
        ServerSendStopCommand(cAddress);
        Break;
      end;
    end;
  end;
end;

procedure TfrmCMServer.btResetClick(Sender: TObject);
var
  i: integer;
  li: TListItem;
  cAddress: string;
begin
  for i := 0 to listClient.Items.Count - 0 do begin
    li := listClient.Items.Item[i];
    if li <> nil then begin
      cAddress := li.SubItems[2];
      ServerSendResetToClientConnected(cAddress);
    end;
  end;
end;

procedure TfrmCMServer.FormShow(Sender: TObject);
begin
  Edit1Change(Self);
end;

procedure TfrmCMServer.Edit1Change(Sender: TObject);
begin
  if TryStrToInt(Edit1.Text, nCurrentScenario) then
    Label1.Caption := 'Current Scenario "' + GetSceneNameFromID(nCurrentScenario) + '"';
end;

procedure TfrmCMServer.Run1Click(Sender: TObject);
var
  li: TListItem;
  cIP: string;
begin
  li := listClient.Selected;
  if li <> nil then begin
    cIP := GetIPAddressFromPCID(li.Caption);
    ServerSendLaunchCommand(cIP);
  end;
end;

procedure TfrmCMServer.Stop1Click(Sender: TObject);
var
  li: TListItem;
  cIP: string;
begin
  li := listClient.Selected;
  if li <> nil then begin
    cIP := GetIPAddressFromPCID(li.Caption);
    ServerSendStopCommand(cIP);
  end;
end;

procedure TfrmCMServer.Reset1Click(Sender: TObject);
var
  li: TListItem;
  cIP: string;
begin
  li := listClient.Selected;
  if li <> nil then begin
    cIP := GetIPAddressFromPCID(li.Caption);
    ServerSendResetToClientConnected(cIP);
  end;
end;

procedure TfrmCMServer.Panel2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then begin
    if SpeedButton1.Visible then
      SpeedButton1.Visible := False
    else
      SpeedButton1.Visible := True;
  end;
end;

procedure TfrmCMServer.SpeedButton1Click(Sender: TObject);
begin
  frmCMSetting.ShowThisForm;
end;

end.

