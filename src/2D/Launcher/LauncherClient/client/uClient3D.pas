unit uClient3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DosCommand, Menus, ComCtrls, uTCPClient, 
  OverbyteIcsWndControl, OverbyteICSwSocket, OverbyteIcsPing,
  ExtCtrls, uQuery, Buttons, uTCPDataType, AdvSmoothPanel;

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
    pnlMemo: TPanel;
    pnlMain: TAdvSmoothPanel;
    pnlMenu: TAdvSmoothPanel;
    Minimize1: TMenuItem;
    pnl1: TPanel;
    N1: TMenuItem;
    ShowHideScroll1: TMenuItem;
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
    procedure Minimize1Click(Sender: TObject);
    procedure ShowHideScroll1Click(Sender: TObject);
  private
    cicle_time_connect: integer;
    cmdClientApp: TDosCommand;
    theClient: TTCPClient;
    thisComputer: tDataApplication;

    //Check ShipID, LauncherID
    aCheckShipID,
    aCheckLauncherID : Integer;

    { Check Connectiion }
    FisCheckConnect,
    FisCheckRespone       : Boolean;
    FTimeCheckConnect     : TTimer;
    FTimeCheckRespone     : TTimer;

    //function ExecIsRunning(FileName: string): Boolean;
    function CloseCurrentHandleApplication(ExeFileName: string): Integer;
    procedure SetDBAddress(sDB: string);
    procedure Set3DAddress(s3D: string);
    procedure GenerateNeededXML(sceneID: integer; bDebug: boolean);
    procedure XML_Cleanup(bDebug: boolean);      // BAWE-20110418: XML_CLEANUP
    procedure LaunchApplication(sceneID, ShipID, LauncherID : integer);
    procedure LaunchApplicationAll(sceneID: integer);
    procedure AddToLogs(s: string);
    procedure SetThisComputerConfig(c_ip: string);
    procedure OnNewLine(Sender: TObject; NewLine: string; OutputType: TOutputType);
    //procedure OnClientDisconected(Sender: TObject; ErrCode: Word);
  public
    m2DServerIP, m2DServerPort, m3DServerIP: string;
    mDBServer, mDBProto, mDBName, mDBUser, mDBPass: string;
    StatusDB, Status2D : string;

    procedure onRec2DOrderAvailable(apRec: PAnsiChar; aSize: integer);

    function processExists(exeFileName: string): Boolean;

    procedure FActionCheckConnect(Sender : TObject);          // Check Connect to Bridge
    procedure FActionCheckRespone(Sender : TObject);          // Check Respone From Bridge
  end;

var
  frmMain: TfrmMain;
  procid: DWord;
  DATA_PATH: string;
  bIsCleaningUp: boolean;

implementation

uses ShellApi, tlhelp32, StrUtils, uDataModule,  uBridgeSet,  DB, uXMLScen, IniFiles ;

{$R *.dfm}

////////////////////// net local procedure
function WindowsExit(RebootParam: Longword): Boolean;
var
   TTokenHd: THandle;
   TTokenPvg: TTokenPrivileges;
   cbtpPrevious: DWORD;
   rTTokenPvg: TTokenPrivileges;
   pcbtpPreviousRequired: DWORD;
   tpResult: Boolean;
const
   SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     tpResult := OpenProcessToken(GetCurrentProcess(),
       TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
       TTokenHd) ;
     if tpResult then
     begin
       tpResult := LookupPrivilegeValue(nil,
                                        SE_SHUTDOWN_NAME,
                                        TTokenPvg.Privileges[0].Luid) ;
       TTokenPvg.PrivilegeCount := 1;
       TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
       cbtpPrevious := SizeOf(rTTokenPvg) ;
       pcbtpPreviousRequired := 0;
       if tpResult then
         Windows.AdjustTokenPrivileges(TTokenHd,
                                       False,
                                       TTokenPvg,
                                       cbtpPrevious,
                                       rTTokenPvg,
                                       pcbtpPreviousRequired) ;
     end;
   end;
   Result := ExitWindowsEx(RebootParam, 0) ;
end;

procedure ClientNotifyServerConnect(theClient: TTCPClient);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID := _CM_CLIENT_MANAGE;
    numValue  := __CM_CLIENT_CONNECT;
    strValue  := '';
    strValue2 := '';
    strValue3 := '';
  end;
  theClient.sendDataEx(REC_2D_ORDER, @thePacket);

  //if client = 3d server = launch app
end;

procedure ClientNotifyServerDisConnect(theClient: TTCPClient);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID   := _CM_CLIENT_MANAGE;
    numValue  := __CM_CLIENT_DISCONNECT;
    strValue  := '';
    strValue2 := '';
    strValue3 := '';
  end;
  theClient.sendDataEx(REC_2D_ORDER, @thePacket);
end;

procedure SendDataClientManagementFromClient(theClient: TTCPClient; mOrderID: byte; mNumValue: integer; mStrValue: string);
var
  thePacket: TRecData2DOrder;
begin
  with thePacket do begin
    orderID   := mOrderID;
    numValue  := mNumValue;
    strValue  := mStrValue;
    strValue2 := '';
    strValue3 := '';
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

procedure TfrmMain.ShowHideScroll1Click(Sender: TObject);
begin
  if Memo1.ScrollBars = ssNone then
  begin
    Memo1.ScrollBars := ssBoth ;
    Memo2.ScrollBars := ssBoth ;
  end
  else if Memo1.ScrollBars = ssBoth then
  begin
    Memo1.ScrollBars := ssNone;
    Memo2.ScrollBars := ssNone;
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
    StatusDB := 'DB SERVER :: ONLINE';
  end
  else begin
    AddToLogs('Can not connect DB Server on ' + mDBServer);
    spbDBServer.Caption := 'DB SERVER :: OFFLINE';
    StatusDB := 'DB SERVER :: OFFLINE';
  end;
end;

procedure TfrmMain.Set3DAddress(s3D: string);
begin
  m3DServerIP := s3D;
  AddToLogs('receive set 3D Server on ' + s3D);
end;

procedure TfrmMain.LaunchApplicationAll(sceneID: integer);
var
  sLine, sLine_2 , sName, addParams: string;

  cShipID,   
  weaponID,
  launcherID,
  FirstHeading : integer;

  isAssign,
  isLauncherExist : Boolean;
begin
  case thisComputer.c_app_tipe of
    APP_3D_Server: begin
        GenerateNeededXML(sceneID, cbDebug.Checked);
        sLine := thisComputer.c_app_name + ' ' + thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID);
      end;
    APP_3D_Client: begin
        GenerateNeededXML(sceneID, cbDebug.Checked);

        Sleep(6000);

        GetShipIDFromSceIDAndConsoleID(sceneID, thisComputer.c_id_console, cShipID, isAssign );

        if isAssign then
        begin
          {nando}
          AddToLogs('OBSERVER MODE');
          AddToLogs(IntToStr(cShipID));
          sName := GetShipNameFromID(cShipID);
          aCheckShipID := cShipID;
          aCheckLauncherID := 0;
          sLine := thisComputer.c_app_name + ' didPlatform --host ' + m3DServerIP + ' '+thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID) + ' --vehicle ' + IntToStr(cShipID);
          AddToLogs(sLine);
          AddToLogs('END OBSERVER MODE');
        end
        else
        begin
          AddToLogs('This Computer not assigned in scenario');
        end;
      end;

      APP_3D_weapon :
      begin
        GenerateNeededXML(sceneID, cbDebug.Checked);

        Sleep(6000);

        launcherID    := 0;
        weaponID      := 0;
        FirstHeading  := 0;

        isLauncherExist := false;

        GetShip_LauncherIDFromSceIDAndConsoleID(sceneID, thisComputer.c_id_console,
                                                cShipID,launcherID, isAssign);

        if isAssign then
        begin
          {nando}
          if ( LowerCase(thisComputer.c_name) = 'mistral' )         then weaponID := 8;
          if ( LowerCase(thisComputer.c_name) = 'strella' )         then weaponID := 9;
          if ( LowerCase(thisComputer.c_name) = 'tds meriam 40' )   then weaponID := 12;
          if ( LowerCase(thisComputer.c_name) = 'tds meriam 57' )   then weaponID := 13;
          if ( LowerCase(thisComputer.c_name) = 'tds meriam 76' )   then weaponID := 14;
          if ( LowerCase(thisComputer.c_name) = 'tds meriam 120' )  then weaponID := 15;

          AddToLogs('WEAPON MODE');
          AddToLogs('SHIP ID : ' + IntToStr(cShipID) +
                    ' WEAPONID : ' + IntToStr(weaponID) +
                    ' LAUNCHERID : ' + IntToStr(launcherID));

          CheckLauncherExistAndHeadingFromShipWeapon(cShipID,weaponID, launcherID, FirstHeading, isLauncherExist);

          if isLauncherExist then
          begin
            AddToLogs(IntToStr(cShipID));
            sName   := GetShipNameFromID(cShipID);
            sLine   := thisComputer.c_app_name + ' didPlatform --host ' + m3DServerIP + ' '
                       + thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID) +
                       ' --scFirstHeading ' + IntToStr(FirstHeading) +
                       ' --vehicle ' + IntToStr(cShipID) +
                       ' --weapon  ' + IntToStr(weaponID) +
                       ' --launcher ' + IntToStr(launcherID);
            sLine_2 := thisComputer.c_app_name_2 + ' -' + m2DServerIP + ' -' + m2DServerPort + ' -' + mDBServer
                    + ' -' + mDBProto + ' -' + mDBName + ' -' + mDBUser + ' -' + mDBPass + ' -' + IntToStr(cShipID)
                    + ' -' + IntToStr(sceneID) + ' -' + (IntToStr(LauncherID));

            aCheckShipID := cShipID;
            aCheckLauncherID := launcherID;

            AddToLogs(sLine);
            AddToLogs(sLine_2);
            AddToLogs('END WEAPON MODE');
          end
          else
          begin
            AddToLogs('Launcher Does not Exist');
          end;


        end
        else
        begin
          AddToLogs('This Computer not assigned in scenario');
        end;
      end;

    APP_2D: begin
        GetShipIDFromSceIDAndConsoleID(sceneID, thisComputer.c_id_console, cShipID, isAssign );

        Sleep(6000);

        if isAssign then
        begin
          sName := thisComputer.c_app_params + thisComputer.c_app_name;

          if FileExists(sName) then begin
            addParams := ' -' + m2DServerIP+' -'+m2DServerPort+' -'+mDBServer+' -'+mDBProto+' -'+mDBName+' -'+mDBUser+' -'+mDBPass+' -'+IntToStr(cShipID)+' -'+IntToStr(sceneID);
            sLine     := sName + addParams;

            aCheckShipID := cShipID;
            aCheckLauncherID := 0;
          end
          else begin
            sLine := '';
          end;
        end
        else
          AddToLogs('This Computer not assigned in scenario');

      end;
  else
      AddToLogs('thisComputer app type not in case '+IntToStr(thisComputer.c_app_tipe));
  end;

  if Trim(sLine) <> '' then
  begin
      cmdClientApp.CommandLine := sLine;
      AddToLogs(sLine);

      AddToLogs('run ' + cmdClientApp.CommandLine);
      cmdClientApp.Execute;
  end
  else
    AddToLogs('Received Launch Command, but something wrong !."' + sLine + '"');

  if Trim(sLine_2) <> '' then
  begin
    cmdClientApp.CommandLine := sLine_2;
    AddToLogs(sLine_2);

    AddToLogs('run' + cmdClientApp.CommandLine);
    cmdClientApp.Execute;
  end
  else
    AddToLogs('Received Launch SECOND COMMAND, but something wrong !."' + sLine_2 + '"');
end;

procedure TfrmMain.LaunchApplication(sceneID, ShipID, LauncherID : integer);
var
  sLine, sLine_2, sName, addParams: string;
  cShipID: integer;

  weaponID : integer;

  //LauncherID : Integer;

  isFound,
  isLauncherExist : Boolean;

  FirstHeading : Integer;
begin
  aCheckShipID := ShipID;
  aCheckLauncherID := LauncherID;

  if cbDebug.Checked then AddToLogs('State Test 1');
  case thisComputer.c_app_tipe of

    APP_3D_Server: begin
        if cbDebug.Checked then AddToLogs('State Test 2');
        GenerateNeededXML(sceneID, cbDebug.Checked);
        if cbDebug.Checked then AddToLogs('State Test 3');
        sLine := thisComputer.c_app_name + ' ' + thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID);
        if cbDebug.Checked then AddToLogs('State Test 4');
      end;

    APP_3D_Client: begin
        if cbDebug.Checked then AddToLogs('State Test 2');
        GenerateNeededXML(sceneID, cbDebug.Checked);
        if cbDebug.Checked then AddToLogs('State Test 3');

        sName := GetShipNameFromID(ShipID);
        if sName <> '' then

          sLine := thisComputer.c_app_name + ' didPlatform --host ' + m3DServerIP + ' '+thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID) + ' --vehicle ' + IntToStr(ShipID)
        else
          sLine := '';
        if cbDebug.Checked then AddToLogs('State Test 4');
      end;

    APP_3D_weapon :
    begin
      AddToLogs('WEAPON MODE');

      if cbDebug.Checked then AddToLogs('State Test 2');
        GenerateNeededXML(sceneID, cbDebug.Checked);
      if cbDebug.Checked then AddToLogs('State Test 3');

      if (ShipID > 0) and (LauncherID > 0) then
      begin
        if ( LowerCase(thisComputer.c_name) = 'mistral' )         then weaponID := 8;
        if ( LowerCase(thisComputer.c_name) = 'strella' )         then weaponID := 9;
        if ( LowerCase(thisComputer.c_name) = 'tds meriam 40' )   then weaponID := 12;
        if ( LowerCase(thisComputer.c_name) = 'tds meriam 57' )   then weaponID := 13;
        if ( LowerCase(thisComputer.c_name) = 'tds meriam 76' )   then weaponID := 14;
        if ( LowerCase(thisComputer.c_name) = 'tds meriam 120' )  then weaponID := 15;

        AddToLogs('WEAPON MODE');
        AddToLogs('SHIP ID : ' + IntToStr(ShipID) +
                  ' WEAPONID : ' + IntToStr(weaponID) +
                  ' LAUNCHERID : ' + IntToStr(launcherID));

        CheckLauncherExistAndHeadingFromShipWeapon(ShipID, weaponID, launcherID, FirstHeading, isLauncherExist);

        if isLauncherExist then
        begin
          AddToLogs(IntToStr(cShipID));
          sName := GetShipNameFromID(cShipID);
          sLine := thisComputer.c_app_name + ' didPlatform --host ' + m3DServerIP + ' '
                  + thisComputer.c_app_params + ' --ScenarioID ' + IntToStr(sceneID) +
                   ' --scFirstHeading ' + IntToStr(FirstHeading) +
                   ' --vehicle ' + IntToStr(ShipID) +
                   ' --weapon  ' + IntToStr(weaponID) +
                   ' --launcher ' + IntToStr(launcherID);

          sLine_2 := thisComputer.c_app_name_2 + ' -' + m2DServerIP + ' -' + m2DServerPort + ' -' + mDBServer
                    + ' -' + mDBProto + ' -' + mDBName + ' -' + mDBUser + ' -' + mDBPass + ' -' + (IntToStr(ShipID))
                    + ' -' + (IntToStr(sceneID)) + ' -' + (IntToStr(LauncherID));

          AddToLogs(sLine);

          AddToLogs(sLine_2);
        end
        else
        begin
          AddToLogs('Cant Found Configuration');
        end;

      end
      else
      begin
        AddToLogs('Cant Found Configuration');
        sLine := '';
      end;
    end;

    APP_2D: begin
        cShipID := ShipID;

        if cbDebug.Checked then
          if cShipID <= 0 then  AddToLogs('Can not find ship id from scene '+IntToStr(sceneID)+' and console id '+IntToStr(thisComputer.c_id_console));

        sName := thisComputer.c_app_params + thisComputer.c_app_name;

        if cbDebug.Checked then AddToLogs('Assign as :: '+sName+' '+IntToStr(cShipID));

        if FileExists(sName) then begin
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
      AddToLogs(sLine);
      if cbDebug.Checked then AddToLogs('run ' + cmdClientApp.CommandLine);
      cmdClientApp.Execute;

      cmdClientApp.CommandLine := sLine_2;
      AddToLogs(sLine_2);
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
  
  strValue,
  strValue2,
  strValue3: string;

  S: string;

  tmp,            // ScenarioID
  tmp2,           // ShipID
  tmp3: integer;  // LauncherID

  recSend : TRecComConsole;
begin
  aRec := @apRec^;
  OrderID := aRec.orderID;
  numValue := aRec.numValue;
  strValue := aRec.strValue;
  strValue2 := aRec.strValue2;
  strValue3 := aRec.strValue3;

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

              //Launch 3D server With Scenario 0 (Default)
            end;
          __CM_CLIENT_RESET: begin
              SetThisComputerConfig(strValue);
              AddToLogs('SERVER ::: Reset ' + thisComputer.c_name);
            end;
          __CM_CLIENT_RESTART: begin
              AddToLogs('SERVER ::: Restart Computer ' + thisComputer.c_name);
              /// cari fungsi lain untuk restart PC. if ZamWmiCloseWin(GetCompName, '', '', true, S) = 0 then S := 'PC Reboot Accepted';
              WindowsExit(EWX_REBOOT or EWX_FORCE) ;
            end;
          __CM_CLIENT_SHUTDOWN: begin
              AddToLogs('SERVER ::: Shutdown Computer ' + thisComputer.c_name);
              /// cari fungsi lain untuk shutdown PC. if ZamWmiCloseWin(GetCompName, '', '', false, S) = 0 then S := 'PC Power Down Accepted';
              WindowsExit(EWX_POWEROFF or EWX_FORCE) ;
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
              if TryStrToInt(trim(strValue), tmp) and
                 TryStrToInt(trim(strValue2), tmp2) and
                 TryStrToInt(trim(strValue3), tmp3)
              then
              begin
                if tmp > -1 then
                  LaunchApplication(tmp, tmp2, tmp3)
                else
                  AddToLogs(' Scenario -1 may be invalid, ceck it !!');
              end
              else
                AddToLogs(' ::: Receive Launch Command. but, wrong "' + strValue + '"');
            end;
          __CM_CLIENT_STOP: begin
              cmdClientApp.Stop;

              aCheckShipID := 0;
              aCheckLauncherID := 0;

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
          __CM_CLIENT_LAUNCHALL: begin
              AddToLogs(':: Launch ALL From Scenario By Instructor');

              thisComputer := GetPCConfigFromIPAddress(thisComputer.c_ip);
              AddToLogs(' ::: this "' + thisComputer.c_ip + '" run as ' + thisComputer.c_name + ' ( ' + thisComputer.c_app_type_name + ' )');
              if TryStrToInt(trim(strValue), tmp) then
              begin
                if tmp > -1 then
                  LaunchApplicationall(tmp)
                else
                  AddToLogs(' Scenario -1 may be invalid, ceck it !!');
              end
              else
                AddToLogs(' ::: Receive Launch Command. but, wrong "' + strValue + '"');
              
            end;
        end;
      end;
    _CM_CLIENT_CHECK :
    begin
      AddToLogs('Check Status Console');
      thisComputer := GetPCConfigFromIPAddress(thisComputer.c_ip);

      if not TryStrToInt(trim(strValue), tmp) then Exit;
      recSend.ShipID     := aCheckShipID;
      recSend.launcherID := aCheckLauncherID;
      recSend.ShipName   := GetShipNameFromID(recSend.ShipID);
      recSend.IpSender   := thisComputer.c_ip;

      if processExists(thisComputer.c_app_name) then
        recSend.OrderID := 1
      else
        recSend.OrderID := 0;

      theClient.sendDataEx(REC_CMD_Com_CONSOLE, @RecSend);
    end;

    _CM_CLIENT_CONNECT :
    begin
      case numValue of
        __CM_CLIENT_LAUNCHER :
        begin
          FTimeCheckConnect.Enabled := True;
          FTimeCheckRespone.Enabled := False;

          //AddToLogs('==== Connection Succes ====');
        end;
      end
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
  t, l : Integer;
  nameFile : String;
  IniF : TIniFile;
begin
  {status}
  aCheckShipID := 0;
  aCheckLauncherID := 0;

  StatusDB := 'DB SERVER :: OFFLINE';
  Status2D := '2D SERVER :: OFFLINE';

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
  theClient.RegisterProcedure(REC_CMD_Com_CONSOLE, nil, SizeOf(TRecComConsole));

  //TheClient.setLog(TStringList(Memo2.Lines));
  {
  Left := Screen.WorkAreaWidth - Width - 1;
  h := (Screen.WorkAreaHeight div 4);
  Height := h + h - 1;
  Top := Screen.WorkAreaHeight - Height - 1;
  }
  Left := 0 + 3;
  //Top := Screen.WorkAreaHeight - Height - 1;
  h := (Screen.WorkAreaHeight div 5);
  Height := h + h - 1;
  Top := 0 + h + 5;

  //++ BAWE-20110617: XML_CLEANUP
    bIsCleaningUp := false;
  //-- BAWE-20110617: XML_CLEANUP

  { for Check Connect to Server Every 5 Second }
  FTimeCheckConnect           := TTimer.Create(nil);
  FTimeCheckConnect.Interval  := 6000;
  FTimeCheckConnect.OnTimer   := FActionCheckConnect;
  FTimeCheckConnect.Enabled   := true;
  { if in 5 Second , not receive respone from server, Disconnect Socket }
  FTimeCheckRespone           := TTimer.Create(nil);
  FTimeCheckRespone.Interval  := 5000;
  FTimeCheckRespone.OnTimer   := FActionCheckRespone;
  FTimeCheckRespone.Enabled   := false;

  nameFile := ExtractFilePath(Application.ExeName) + 'did3DClient.ini';
  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  t := IniF.ReadInteger('layout', 'top', 3);
  l := IniF.ReadInteger('layout', 'left', 3);

  Top := t;
  Left := l;
  Timer1.Enabled := True;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  nameFile :  string;
  IniF : TIniFile;
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

  {save layout to ini }
  nameFile := ExtractFilePath(Application.ExeName) + 'did3DClient.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  IniF.WriteString('layout', 'Top', IntToStr(Self.Top));
  IniF.WriteString('layout', 'Left', IntToStr(Self.Left));
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if (TheClient.State <> wsConnected) then begin
    inc(cicle_time_connect);
    if cicle_time_connect >= 10 then begin
      try
        //TheClient.Disconnect;
        TheClient.Connect(m2DServerIP, m2DServerPort);
      finally
        ClientNotifyServerConnect(TheClient);
      end;
      cicle_time_connect := 0;
    end;
    spb2DServer.Caption := '2D SERVER :: OFFLINE';
    Status2D := '2D SERVER :: OFFLINE';
    pnlStatus.Caption := 'Connecting ' + DupeString('.', cicle_time_connect);
  end
  else begin
    spb2DServer.Caption := '2D SERVER :: ONLINE';
    Status2D := '2D SERVER :: ONLINE';
    pnlStatus.Caption := FormatDateTime('DD-MM-YY HH:MM:SS', now);
  end;

  pnlMenu.Caption.Text := Status2D + '   ' + StatusDB;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  cmdClientApp.Stop;
  Close;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  nameFile :  string;
  IniF : TIniFile;
begin
  {save layout to ini }
  nameFile := ExtractFilePath(Application.ExeName) + 'did3DClient.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  IniF.WriteString('layout', 'Top', IntToStr(Self.Top));
  IniF.WriteString('layout', 'Left', IntToStr(Self.Left));

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

procedure TfrmMain.Minimize1Click(Sender: TObject);
begin
  Self.WindowState := wsMinimized;
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
  Self.SendToBack;
end;

function TfrmMain.processExists(exeFileName: string): Boolean;
var 
  ContinueLoop: BOOL; 
  FSnapshotHandle: THandle; 
  FProcessEntry32: TProcessEntry32; 
begin 
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32); 
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32); 
  Result := False; 
  while Integer(ContinueLoop) <> 0 do 
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = 
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = 
      UpperCase(ExeFileName))) then 
    begin 
      Result := True; 
    end; 
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32); 
  end; 
  CloseHandle(FSnapshotHandle); 
end;

procedure TfrmMain.FActionCheckConnect(Sender: TObject);
var
  RecSend : TRecData2DOrder;
begin
  if (theClient <> nil) and (theClient.State in [wsConnected]) then
  begin
    { Send Request Connection }
    with RecSend do
    begin
      orderID   := _CM_CLIENT_CONNECT;
      numValue  := __CM_CLIENT_LAUNCHER;
      strValue  := '';
      strValue2 := '';
      strValue3 := '';
      ipConsole := '';
    end;
    FTimeCheckRespone.Enabled := True;
    theClient.sendDataEx(REC_2D_ORDER, @RecSend);

    //AddToLogs(' === Check Connection From Server ===');
  end;
end;

procedure TfrmMain.FActionCheckRespone(Sender: TObject);
begin
  if theClient.State = WsConnected then
  begin
    FTimeCheckRespone.Enabled := false;          
    TheClient.Disconnect;
    AddToLogs(' === Lost Connection From Server ===');
  end;
end;

end.

