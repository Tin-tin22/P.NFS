unit uCMControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OverbyteIcsPing, StdCtrls, Menus, Buttons, AdvSmoothPanel ;

type
  TCMControl = class(TForm)
    Timer2: TTimer;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    N1: TMenuItem;
    CloseControlClient1: TMenuItem;
    StopControlClient1: TMenuItem;
    StartControlClient1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    pnlMemo: TPanel;
    pnlTitle: TAdvSmoothPanel;
    Minimize1: TMenuItem;
    ShowScroll1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure CloseControlClient1Click(Sender: TObject);
    procedure StopControlClient1Click(Sender: TObject);
    procedure StartControlClient1Click(Sender: TObject);
    procedure MoveForm(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Minimize1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowScroll1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cicle_time_ping: integer;
    ping1: TPing;
    bPingError: boolean;
    m2DServerIP, m2DServerPort, m3DServerIP: string;

    function CloseCurrentHandleApplication(ExeFileName: string): Integer;
    function ExecIsRunning(FileName: string): Boolean;

    procedure AddToLogs(s: string);
    procedure Ping1DnsLookupDone(Sender: TObject; Error: Word);
    procedure Ping1EchoReply(Sender: TObject; Icmp: TObject; Status: Integer);

  public

  end;

const
  cDID3DApp = 'did3DClient.exe';


var
  CMControl: TCMControl;
  cCurrentApp : string;

implementation

uses ShellApi, tlhelp32, uBridgeSet, IniFiles;

{$R *.dfm}

function TCMControl.ExecIsRunning(FileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  fName : string;
begin
  fName := ExtractFileName(FileName);
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(fName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(fName))) then begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function TCMControl.CloseCurrentHandleApplication(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  fName : string;
begin
  fName := ExtractFileName(ExeFileName);
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(fName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(fName))) then
      Result := Integer(TerminateProcess(
        OpenProcess(PROCESS_TERMINATE,
        BOOL(0),
        FProcessEntry32.th32ProcessID),
        0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TCMControl.AddToLogs(s: string);
const
  c_time_format = '( HH:MM:SS )';
begin
  if Memo1.Lines.Count = 20 then Memo1.Lines.Delete(0);
  Memo1.Lines.Add(FormatDateTime(c_time_format, now) + ' ' + s);
end;

procedure TCMControl.Ping1DnsLookupDone(Sender: TObject; Error: Word);
begin
  //AddToLogs(IntToStr(Error));

  if Error <> 0 then begin
    AddToLogs('Ping unknown host ''' + m2DServerIP + '''');
    Exit;
  end;
  Ping1.Address := Ping1.DnsResult;
  AddToLogs('Start Ping');
  Ping1.Ping;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TCMControl.Ping1EchoReply(Sender: TObject; Icmp: TObject; Status: Integer);
begin
  //AddToLogs('Ping Status = ' + IntToStr(Status));

  if Status <> 0 then begin
    AddToLogs('Ping "' + m2DServerIP + '" success.');
    bPingError := False;
  end
  else begin
    bPingError := True;
    Timer2.Enabled := False;
    if ExecIsRunning(cCurrentApp) then
      CloseCurrentHandleApplication(cCurrentApp);
    BringToFront;
    Timer2.Enabled := True;
  end;
end;

procedure TCMControl.FormClose(Sender: TObject; var Action: TCloseAction);
var
  nameFile :  string;
  IniF : TIniFile;
begin
  {save layout to ini }
  nameFile := ExtractFilePath(Application.ExeName) + 'did3DControl.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  IniF.WriteString('layout', 'Top', IntToStr(Self.Top));
  IniF.WriteString('layout', 'Left', IntToStr(Self.Left));
end;

procedure TCMControl.FormCreate(Sender: TObject);
var
  path, m3DServerPort: string;
  h : Integer;
  nameFile : String;
  IniF : TIniFile;
  t, l : Integer;
begin
//  cCurrentApp := ExtractFilePath(ParamStr(0))+'\'+cDID3DApp;
  cCurrentApp := ExtractFilePath(Application.ExeName)+'\'+cDID3DApp;
  //ShowMessage(cCurrentApp);
  {
  Left := Screen.WorkAreaWidth - Width - 1;
  //Top := Screen.WorkAreaHeight - Height - 1;
  Height := Screen.WorkAreaHeight div 5;
  Top := 0;
  }
  nameFile := ExtractFilePath(Application.ExeName) + 'did3DControl.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  t := IniF.ReadInteger('layout', 'top', 3);
  l := IniF.ReadInteger('layout', 'left', 3);

  Top := t;
  Left := l;

//  Left := Screen.WorkAreaWidth - Width - 1;
  h := (Screen.WorkAreaHeight div 4);
  Height := Screen.WorkAreaHeight div 5;
//  Top := Screen.WorkAreaHeight - Height - (Height div 2);

  path := GetSettingDirectory;
  InitDefault_GameServerConfig(path, m2DServerIP, m2DServerPort, m3DServerIP, m3DServerPort);
  ping1 := TPing.Create(Self);
  ping1.OnDnsLookupDone := Ping1DnsLookupDone;
  Ping1.OnEchoReply := Ping1EchoReply;
end;

procedure TCMControl.FormDestroy(Sender: TObject);
var
  nameFile :  string;
  IniF : TIniFile;
begin
  {save layout to ini }
  nameFile := ExtractFilePath(Application.ExeName) + 'did3DControl.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  IniF.WriteString('layout', 'Top', IntToStr(Self.Top));
  IniF.WriteString('layout', 'Left', IntToStr(Self.Left));

  if ExecIsRunning(cCurrentApp) then
    CloseCurrentHandleApplication(cCurrentApp);
  if ping1 <> nil then begin
    ping1.OnDnsLookupDone := nil;
    Ping1.OnEchoReply := nil;
    ping1.Free;
  end;
end;

procedure TCMControl.FormShow(Sender: TObject);
begin
  //send to back
  Self.SendToBack;
end;

procedure TCMControl.Timer2Timer(Sender: TObject);
begin
  inc(cicle_time_ping);
  if cicle_time_ping >= 10 then begin
    ping1.DnsLookup(m2DServerIP);
    cicle_time_ping := 0;
  end;

  if not ExecIsRunning(cCurrentApp) then begin
    if FileExists(cCurrentApp) then begin
      if not bPingError then
        ShellExecute(Handle, 'open', pChar(cCurrentApp), '', nil, SW_SHOWNORMAL)
      else
        AddToLogs('waiting for network connection...');
    end
    else
      AddToLogs('Can not find DID 3D Launcher');
  end;

end;

procedure TCMControl.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TCMControl.CloseControlClient1Click(Sender: TObject);
begin
  if ExecIsRunning(cCurrentApp) then
    CloseCurrentHandleApplication(cCurrentApp);
end;

procedure TCMControl.StopControlClient1Click(Sender: TObject);
begin
  Timer2.Enabled := False;
  if ExecIsRunning(cCurrentApp) then
    CloseCurrentHandleApplication(cCurrentApp);
end;

procedure TCMControl.ShowScroll1Click(Sender: TObject);
begin
  if Memo1.ScrollBars = ssNone then
    Memo1.ScrollBars := ssBoth
  else if Memo1.ScrollBars = ssBoth then
    Memo1.ScrollBars := ssNone;
end;

procedure TCMControl.StartControlClient1Click(Sender: TObject);
begin
  Timer2.Enabled := True;
end;

procedure TCMControl.Minimize1Click(Sender: TObject);
begin
  Self.WindowState := wsMinimized;
end;

procedure TCMControl.MoveForm(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then begin
      ReleaseCapture;
      SendMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
    end;
end;

end.

