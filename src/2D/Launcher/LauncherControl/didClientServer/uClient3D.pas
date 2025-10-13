unit uClient3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DosCommand, Menus, ComCtrls, uTCPClient, 
  OverbyteIcsWndControl, OverbyteICSwSocket, OverbyteIcsPing,
  ExtCtrls, uQuery, Buttons, uTCPDataType;

type
  TfrmMain = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Timer1: TTimer;
    Panel2: TPanel;
    spb2DServer: TPanel;
    btnClose: TPanel;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    pnlStatus: TPanel;
    Panel3: TPanel;
    Memo2: TMemo;
    cbDebug: TCheckBox;
    spbDBServer: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Close1Click(Sender: TObject);
    procedure Panel2DblClick(Sender: TObject);
    procedure MoveForm(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbDebugClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cicle_time_connect: integer;
    cmdClientApp: TDosCommand;
    theClient: TTCPClient;
    thisComputer: tDataApplication;
    //function ExecIsRunning(FileName: string): Boolean;
    function CloseCurrentHandleApplication(ExeFileName: string): Integer;
    procedure SetDBAddress(sDB: string);
    procedure Set3DAddress(s3D: string);
    procedure GenerateNeededXML(sceneID: integer; bDebug: boolean);
    procedure XML_Cleanup(bDebug: boolean);      // BAWE-20110418: XML_CLEANUP
    procedure LaunchApplication(sceneID: integer);
    procedure AddToLogs(s: string);
    procedure SetThisComputerConfig(c_ip: string);
    procedure OnNewLine(Sender: TObject; NewLine: string; OutputType: TOutputType);
    //procedure OnClientDisconected(Sender: TObject; ErrCode: Word);
  public
    m2DServerIP, m2DServerPort, m3DServerIP: string;
    mDBServer, mDBProto, mDBName, mDBUser, mDBPass: string;
    procedure onRec2DOrderAvailable(apRec: PAnsiChar; aSize: integer);
  end;

var
  frmMain: TfrmMain;
  procid: DWord;
  DATA_PATH: string;
  bIsCleaningUp: boolean;

implementation

uses ShellApi, tlhelp32, StrUtils, uDataModule,  uBridgeSet,  DB, uXMLScen,
     BimaWMI, BimaFTC;

{$R *.dfm}

////////////////////// net local procedure
procedure ClientNotifyServerConnect(theClient: TTCPClient);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue := __CM_CLIENT_CONNECT;
    strValue := '';
  end;
  theClient.sendDataEx(REC_2D_ORDER, @thePacket);
end;

procedure ClientNotifyServerDisConnect(theClient: TTCPClient);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue := __CM_CLIENT_DISCONNECT;
    strValue := '';
  end;
  theClient.sendDataEx(REC_2D_ORDER, @thePacket);
end;

procedure SendDataClientManagementFromClient(theClient: TTCPClient; mOrderID: byte; mNumValue: integer; mStrValue: string);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID := mOrderID;
    numValue := mNumValue;
    strValue := mStrValue;
  end;
  theClient.sendDataEx(REC_2D_ORDER, @thePacket);
end;

////////////////////// net local procedure


procedure TfrmMain.AddToLogs(s: string);
const
  c_time_format = '( HH:MM:SS )';
begin
  if Memo1.Lines.Count = 500 then Memo1.Lines.Delete(0);
  Memo1.Lines.Add(FormatDateTime(c_time_format, now) + ' ' + s);
end;
 
function TfrmMain.CloseCurrentHandleApplication(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
        OpenProcess(PROCESS_TERMINATE,
        BOOL(0),
        FProcessEntry32.th32ProcessID),
        0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

//++ BAWE-20110418: XML_CLEANUP
procedure TfrmMain.XML_Cleanup(bDebug: boolean);
var
  fShipXMLName, fOceanXMLName, fDetailXMLName: string;
begin
  //++ BAWE-20110617: XML_CLEANUP
  if bIsCleaningUp = false then
  begin
    bIsCleaningUp := true;
  //-- BAWE-20110617: XML_CLEANUP
    fShipXMLName := DATA_PATH + 'ships.xml';
    fOceanXMLName := DATA_PATH + 'oceanConfig.xml';
    fDetailXMLName := DATA_PATH + 'level.xml';

    if bDebug then ShowMessage('Start Deleting Old XML...');

    if FileExists(fShipXMLName) then
      begin
        DeleteFile(fShipXMLName);
        if bDebug then AddToLogs('Old ' + fShipXMLName + ' file deleted!');
      end
    else
      if bDebug then AddToLogs('Cannot find old ' + fShipXMLName + '. Proceed!');

    if FileExists(fOceanXMLName) then
      begin
        DeleteFile(fOceanXMLName);
        if bDebug then AddToLogs('Old ' + fOceanXMLName + ' file deleted!');
      end
    else
      if bDebug then AddToLogs('Cannot find old ' + fOceanXMLName + '. Proceed!');

    if FileExists(fDetailXMLName) then
      begin
        DeleteFile(fDetailXMLName);
        if bDebug then AddToLogs('Old ' + fDetailXMLName + ' file deleted!');
      end
    else
      if bDebug then AddToLogs('Cannot find old ' + fDetailXMLName + '. Proceed!');

    if bDebug then ShowMessage('End Deleting Old XML...');
  //++ BAWE-20110617: XML_CLEANUP
    //bIsCleaningUp := false;
  end;
  //-- BAWE-20110617: XML_CLEANUP
end;
//-- BAWE-20110418: XML_CLEANUP

procedure TfrmMain.GenerateNeededXML(sceneID: integer; bDebug: boolean);
var
  fShipXMLName, fOceanXMLName, fDetailXMLName: string;
begin
  fShipXMLName := DATA_PATH + 'ships.xml';
  fOceanXMLName := DATA_PATH + 'oceanConfig.xml';
  fDetailXMLName := DATA_PATH + 'level.xml';

  XML_Cleanup(bDebug);          // BAWE-20110418: XML_CLEANUP

  if bDebug then ShowMessage('Start Generate Needed XML Scenario');

  GenerateShipXMLScen(sceneID, fShipXMLName, bDebug);
  if FileExists(fShipXMLName) then
    AddToLogs('Generated "' + fShipXMLName + '"')
  else
    AddToLogs('Generate ' + fShipXMLName + ' fault');

  GenerateOceanXMLScen(sceneID, fOceanXMLName, bDebug);
  if FileExists(fOceanXMLName) then
    AddToLogs('Generated "' + fOceanXMLName + '"')
  else
    AddToLogs('Generate ' + fOceanXMLName + ' fault');

  GenerateDetailXMLScen(sceneID, fDetailXMLName, bDebug);
  if FileExists(fOceanXMLName) then
    AddToLogs('Generated "' + fDetailXMLName + '"')
  else
    AddToLogs('Generate ' + fDetailXMLName + ' fault');

  //++ BAWE-20110617: XML_CLEANUP
  bIsCleaningUp := false;
  //-- BAWE-20110617: XML_CLEANUP

  if bDebug then ShowMessage('End Generate Needed XML Scenario');

end;

procedure TfrmMain.SetThisComputerConfig(c_ip: string);
begin
  thisComputer := GetPCConfigFromIPAddress(c_ip);
  AddToLogs('This is ' + thisComputer.c_name);
  if thisComputer.c_app_tipe = APP_3D_Client then begin
    SendDataClientManagementFromClient(TheClient, _CM_CLIENT_MANAGE, __CM_CLIENT_REQ3D_ADDR, '');
    AddToLogs('Send Request Server 3D Address ... ');
  end;
end;

procedure TfrmMain.SetDBAddress(sDB: string);
var
  path: string;
begin
  path := GetSettingDirectory;
  mDBServer := sDB;
  if DataModule1.InitZDB(mDBServer, mDBProto, mDBName, mDBUser, mDBPass) then begin
    AddToLogs('set DB Server on ' + mDBServer + ' and connected.');
    SaveDefault_DBConfig(path, mDBServer, mDBProto, mDBName, mDBUser, mDBPass);
    spbDBServer.Caption := 'DB SERVER :: ONLINE';
  end
  else begin
    AddToLogs('Can not connect DB Server on ' + mDBServer);
    spbDBServer.Caption := 'DB SERVER :: OFFLINE';
  end;
end;

procedure TfrmMain.Set3DAddress(s3D: string);
begin
  m3DServerIP := s3D;
  AddToLogs('receive set 3D Server on ' + s3D);
end;


procedure TfrmMain.LaunchApplication(sceneID: integer);
var
  sLine, sName, addParams: string;
  cShipID: integer;
begin
  if cbDebug.Checked then AddToLogs('State Test 1');
  case thisComputer.c_app_tipe of
    APP_3D_Server: begin
        if cbDebug.Checked then AddToLogs('State Test 2');
        GenerateNeededXML(sceneID, cbDebug.Checked);
        if cbDebug.Checked then AddToLogs('State Test 3');
        sLine := thisComputer.c_app_name + ' ' + thisComputer.c_app_params;
        if cbDebug.Checked then AddToLogs('State Test 4');
      end;
    APP_3D_Client: begin
        if cbDebug.Checked then AddToLogs('State Test 2');
        GenerateNeededXML(sceneID, cbDebug.Checked);
        if cbDebug.Checked then AddToLogs('State Test 3');
        cShipID := GetShipAssignedFromIDScenarioAndIDConsole(sceneID, thisComputer.c_id_console);
        sName := GetShipNameFromID(cShipID);
        if sName <> '' then
          sLine := thisComputer.c_app_name + ' didPlatform --host ' + m3DServerIP + ' --name "' + sName + '" ' + thisComputer.c_app_params
        else
          sLine := '';
        if cbDebug.Checked then AddToLogs('State Test 4');
      end;
    APP_2D: begin
        cShipID := GetShipAssignedFromIDScenarioAndIDConsole(sceneID, thisComputer.c_id_console);

        if cbDebug.Checked then
          if cShipID <= 0 then  AddToLogs('Can not find ship id from scene '+IntToStr(sceneID)+' and console id '+IntToStr(thisComputer.c_id_console));
        
        sName := thisComputer.c_app_params + thisComputer.c_app_name;

        if cbDebug.Checked then AddToLogs('Assign as :: '+sName+' '+IntToStr(cShipID));
        
        if FileExists(sName) then begin
          //addParams := ' -s ' + m2DServerIP + ' -d ' + mDBServer + ' -i ' + dbID_to_UniqueID(cShipID) + ' -c ' + IntToStr(sceneID);
          addParams := ' -' + m2DServerIP+' -'+m2DServerPort+' -'+mDBServer+' -'+mDBProto+' -'+mDBName+' -'+mDBUser+' -'+mDBPass+' -'+IntToStr(cShipID)+' -'+IntToStr(sceneID);
          sLine     := sName + addParams;
        end
        else begin
          if cbDebug.Checked then AddToLogs('File Not Exists :: '+sName);
          sLine := '';
        end;
      end;
    else
      if cbDebug.Checked then AddToLogs('thisComputer app type not in case '+IntToStr(thisComputer.c_app_tipe));
  end;

  if cbDebug.Checked then AddToLogs('State Test 5  :: params :: "' + sLine + '"');

  if Trim(sLine) <> '' then begin
    if cbDebug.Checked then begin
      AddToLogs('State Test 6');
      ShellExecute(Handle, 'open', 'NOTEPAD.exe', '', nil, SW_SHOWNORMAL);
      AddToLogs('State Test 7');
    end
    else begin
      cmdClientApp.CommandLine := sLine;
      if cbDebug.Checked then AddToLogs('run ' + cmdClientApp.CommandLine);
      cmdClientApp.Execute;
    end;
  end
  else
    AddToLogs('Received Launch Command, but something wrong !."' + sLine + '"');
end;

procedure TfrmMain.onRec2DOrderAvailable(apRec: PAnsiChar; aSize: integer);
var
  aRec: ^TRecData2DOrder;
  OrderID: byte;
  numValue: Integer;
  strValue: string;
  S: string;
  tmp: integer;
begin
  aRec := @apRec^;
  OrderID := aRec.orderID;
  numValue := aRec.numValue;
  strValue := aRec.strValue;

  if cbDebug.Checked then AddToLogs('-- DEBUG ORDER ID : "' + IntToStr(OrderID) + '" :: "' + IntToStr(numValue) + '" :: "' + strValue + '"');

  case OrderID of
    _CM_CLIENT_MANAGE: begin
        case numValue of
          __CM_CLIENT_SETDB_ADDR: begin
              SetDBAddress(strValue);
            end;
          __CM_CLIENT_SET3D_ADDR: begin
              Set3DAddress(strValue);
            end;
          __CM_CLIENT_WELCOME: begin
              SetThisComputerConfig(strValue);
              AddToLogs('SERVER ::: Welcome ' + thisComputer.c_name);
            end;
          __CM_CLIENT_RESET: begin
              SetThisComputerConfig(strValue);
              AddToLogs('SERVER ::: Reset ' + thisComputer.c_name);
            end;
          __CM_CLIENT_RESTART: begin
              AddToLogs('SERVER ::: Restart Computer ' + thisComputer.c_name);
              if ZamWmiCloseWin(GetCompName, '', '', true, S) = 0 then S := 'PC Reboot Accepted';
            end;
          __CM_CLIENT_SHUTDOWN: begin
              AddToLogs('SERVER ::: Shutdown Computer ' + thisComputer.c_name);
              if ZamWmiCloseWin(GetCompName, '', '', false, S) = 0 then S := 'PC Power Down Accepted';
            end;
          __CM_CLIENT_CLOSE_LAUNCHER: begin
              AddToLogs('SERVER ::: Close this Launcher');
              btnCloseClick(Self);
            end;
        end;
      end;
    _CM_CLIENT_APP: begin
        case numValue of
          __CM_CLIENT_LAUNCH: begin
              thisComputer := GetPCConfigFromIPAddress(thisComputer.c_ip);
              AddToLogs(' ::: this "' + thisComputer.c_ip + '" run as ' + thisComputer.c_name + ' ( ' + thisComputer.c_app_type_name + ' )');
              if TryStrToInt(trim(strValue), tmp) then
              begin
                if tmp > 0 then
                  LaunchApplication(tmp)
                else
                  AddToLogs(' Scenario 0 may be invalid, ceck it !!');
              end
              else
                AddToLogs(' ::: 3D Server Receive Launch Command. but, wrong "' + strValue + '"');
            end;
          __CM_CLIENT_STOP: begin
              cmdClientApp.Stop;
              //++ BAWE-20110418: XML_CLEANUP
              XML_Cleanup(cbDebug.Checked);
              //-- BAWE-20110418: XML_CLEANUP
              if thisComputer.c_app_type = APP_2D then begin
                CloseCurrentHandleApplication(thisComputer.c_app_name);
                AddToLogs(' ::: 2D Client Receive Stop Command. "' + thisComputer.c_app_name + '"');
              end;
              AddToLogs(' ::: STOPED');
            end;
          __CM_CLIENT_RELAUNCH: begin
              if thisComputer.c_app_type = APP_2D then
                CloseCurrentHandleApplication(thisComputer.c_app_name);
              cmdClientApp.Stop;
              cmdClientApp.Execute;
              AddToLogs(' ::: RELAUNCH');
            end;
        end;
      end;
  end;
end;

procedure TfrmMain.OnNewLine(Sender: TObject; NewLine: string; OutputType: TOutputType);
begin
  AddToLogs(NewLine);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  path, m3DServerPort: string;
  h: integer;
begin
  DATA_PATH := GetDataPath;
  if not DirectoryExists(DATA_PATH) then ShowMessage('Data Path does not exist');

  //ShowWindow(Application.Handle, SW_HIDE);
  //SetWindowLong(Application.Handle, GWL_EXSTYLE, getWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  //ShowWindow(Application.Handle, SW_SHOW);

  path := GetSettingDirectory;
  InitDefault_GameServerConfig(path, m2DServerIP, m2DServerPort, m3DServerIP, m3DServerPort);
  InitDefault_DBConfig(path, mDBServer, mDBProto, mDBName, mDBUser, mDBPass);
  cmdClientApp := TDosCommand.Create(Self);
  cmdClientApp.OnNewLine := OnNewLine;
  AddToLogs('3D :: Launcher');
  theClient := TTCPClient.Create;
  TheClient.RegisterProcedure(REC_2D_ORDER, onRec2DOrderAvailable, sizeof(TRecData2DOrder));
  //TheClient.setLog(TStringList(Memo2.Lines));
  Left := Screen.WorkAreaWidth - Width - 1;
  h := (Screen.WorkAreaHeight div 4);
  Height := h + h - 1;
  Top := Screen.WorkAreaHeight - Height - 1;
  //++ BAWE-20110617: XML_CLEANUP
    bIsCleaningUp := false;
  //-- BAWE-20110617: XML_CLEANUP

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  cmdClientApp.Stop;
  if TheClient <> nil then begin
    if TheClient.State = wsConnected then begin
      ClientNotifyServerDisConnect(TheClient);
      TheClient.Socket.OnSessionClosed := nil;
      TheClient.Disconnect;
    end;
    TheClient.Free;
  end;
  if cmdClientApp <> nil then cmdClientApp.Free;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if (TheClient.State <> wsConnected) then begin
    inc(cicle_time_connect);
    if cicle_time_connect >= 10 then begin
      try
        TheClient.Disconnect;
        TheClient.Connect(m2DServerIP, m2DServerPort);
      finally
        ClientNotifyServerConnect(TheClient);
      end;
      cicle_time_connect := 0;
    end;
    spb2DServer.Caption := '2D SERVER :: OFFLINE';
    pnlStatus.Caption := 'Connecting ' + DupeString('.', cicle_time_connect);
  end
  else begin
    spb2DServer.Caption := '2D SERVER :: ONLINE';
    pnlStatus.Caption := FormatDateTime('DD-MM-YY HH:MM:SS', now);
  end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  cmdClientApp.Stop;
  Close;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if cmdClientApp <> nil then cmdClientApp.Stop;
end;

procedure TfrmMain.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.Panel2DblClick(Sender: TObject);
begin
  if cbDebug.Visible then
    cbDebug.Visible := false
  else
    cbDebug.Visible := true;
end;

procedure TfrmMain.MoveForm(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmMain.cbDebugClick(Sender: TObject);
begin
  if cbDebug.Checked then
  begin
    TheClient.setLog(TStringList(Memo2.Lines));
    Memo2.Visible := True;
  end
  else
  begin
    cbDebug.Visible := true;
    TheClient.setLog(nil);
    Memo2.Visible := False;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //++ BAWE-20110617: XML_CLEANUP
    bIsCleaningUp := false;
  //-- BAWE-20110617: XML_CLEANUP
end;

end.

