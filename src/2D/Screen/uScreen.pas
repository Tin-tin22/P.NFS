unit uScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, Buttons, SpeedButtonImage, ImgList, ushldlg,
  DosCommand, AdvSmoothPanel, StdCtrls;

type
  TfScreen = class(TForm)
    imgOut: TImage;
    btnShutDown: TSpeedButtonImage;
    btnRestart: TSpeedButtonImage;
    btnLaunch: TSpeedButtonImage;
    ilbtlaunch: TImageList;
    ilbtRestart: TImageList;
    ilbtShutDown: TImageList;
    advsmthpnlMenuMenu: TAdvSmoothPanel;
    btnExitToWindows: TSpeedButtonImage;
    ilbtExitToWindows: TImageList;
    procedure btnRestartClick(Sender: TObject);
    procedure btnShutDownClick(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
    procedure pnlMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure advsmthpnlMenuMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnExitToWindowsClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    function KillTask(ExeFileName: string): Integer;

  public
    { Public declarations }
    procedure SetImage(path :string);

  published
    procedure SetWidthHeight(w, h : Integer);
    procedure LaunchApp;
  end;

var
  fScreen: TfScreen;

implementation

uses
  uScreenManager,
  Tlhelp32;

{$R *.dfm}

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

procedure TfScreen.advsmthpnlMenuMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  r : Integer;
  Indicador : Integer;
begin
  if (Button = mbRight) {and (ssShift in Shift)} then
  begin
    r := MessageDlg('Do you really want to leave this program and enter Windows System', mtConfirmation, mbOKCancel, 1) ;

    if r = 1 then
    begin
      Application.Terminate;
    end;
  end;
end;

procedure TfScreen.btn1Click(Sender: TObject);
begin
//close launcher untuk stand alone aplikasi

end;

function KillApp(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
begin
  AppHandle:=FindWindow(Nil, sCapt) ;
  Result:=PostMessage(AppHandle, WM_QUIT, 0, 0) ;
end;

procedure TfScreen.btnExitToWindowsClick(Sender: TObject);
var
  r : Integer;
begin
  r := MessageDlg('Do you really want to leave this program and enter Windows System', mtConfirmation, mbOKCancel, 1) ;

    if r = 1 then
    begin
      Application.Terminate;
    end;
end;

procedure TfScreen.btnLaunchClick(Sender: TObject);
begin
  LaunchApp;

 KillTask('did3DControl.exe');
 KillTask('did3DClient.exe');
end;

procedure TfScreen.btnRestartClick(Sender: TObject);
begin
  WindowsExit(EWX_REBOOT or EWX_FORCE) ;
end;

procedure TfScreen.btnShutDownClick(Sender: TObject);
begin
  WindowsExit(EWX_POWEROFF or EWX_FORCE) ;
end;

function TfScreen.KillTask(ExeFileName: string): Integer;
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

  while Integer(ContinueLoop) <> 0 do
  begin
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

procedure TfScreen.SetImage(path: string);
begin
  if not FileExists(path) then exit;
  imgOut.Picture.LoadFromFile(path);
  imgOut.Stretch := true;
end;

procedure TfScreen.SetWidthHeight(w: Integer; h: Integer);
begin
  Self.Height := h;
  Self.Width := w;
end;

procedure TfScreen.LaunchApp;
begin
  FScreenManager.LoadCommand;
  fCmdLine.CommandLine := FScreenManager.Command;
  btnExitToWindows.Color := TransparentColorValue;

  if not (FCmdLine.CommandLine = '') then
    FCmdLine.Execute;
end;

procedure TfScreen.pnlMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  r : Integer;
begin
  if Button = mbRight then
  begin
    r := MessageDlg('Do you want to close the screen and automatically back to Windows', mtConfirmation, mbYesNoCancel, 1);
//    ShowMessage('Nilai return ' + IntToStr(r));
    if r = 6 then
      Application.Terminate;
  end;
end;

end.
