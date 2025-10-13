unit uScreenManager;

interface

uses
  Classes, Windows, Forms, DosCommand, IniFiles;

Type TScreenManager = class
public
  ScreenCount : Integer;
  FormList : TList;
  Command : string;
  Command_2nd : string;
  MainMonitor : Integer;
  IniF: TIniFile;
  constructor Create;
  destructor Destroy;
  procedure SetLayout;
  procedure LoadCommand;
  procedure RunController;
end;

var
  FScreenManager : TScreenManager;
  FCmdLine : TDosCommand;

implementation

uses
  uFormUtil, uScreen, SysUtils;


const
  C_CMD = 'cmd';
  C_Main = 'main';
  C_Client = 'client';
  C_Controller = 'control';
  C_Path = 'path';
  C_imgBackground = 'imgBackground';

constructor TScreenManager.Create;
begin
  FormList := TList.Create;
  ScreenCount := Screen.MonitorCount;
end;

destructor TScreenManager.Destroy;
begin
  FormList.Free;
  FCmdLine.stop;
  Application.Terminate;
end;

procedure TScreenManager.SetLayout;
var
  I: Integer;
  scf : TfScreen ;
  h, w : Integer;
  path, imgbmp, nameFile : string;
  temp : string;
begin
  nameFile := ExtractFilePath(Application.ExeName) + 'Screen.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  MainMonitor := IniF.ReadInteger(C_CMD, C_Main, 1);
  MainMonitor := MainMonitor - 1; {monitor ke-1 berarti monitor 0}

  path := '.\images\'; //IniF.ReadString(C_CMD, C_Path, 'D:\2D\bin\');

  imgbmp := IniF.ReadString(C_CMD, C_imgBackground, 'screen');

  for I := 0 to ScreenCount - 1 do
  begin
    Application.CreateForm(TfScreen, scf);
    FormList.Add(scf);

    h := Screen.Monitors[I].Height;
    w := Screen.Monitors[I].Width;

    scf.SetWidthHeight(w, h);

    if I = MainMonitor then
      scf.advsmthpnlMenuMenu.Visible := true;

//    scf.SetImage(ExtractFilePath(Application.ExeName) + 'screen.jpg');

     if w <= 810 then
      scf.SetImage(path + imgbmp +'_800x600.bmp')            // Resolusi 800x600
    else if w <= 1030 then
      begin
        if h <= 610 then
          scf.SetImage(path + imgbmp +'_1024x600.bmp')       // Resolusi 1024x600
        else if h <= 1290 then
          scf.SetImage(path + imgbmp +'_1024x1280.bmp');     // Resolusi 1024x1280
      end
    else if w <= 1290 then
      scf.SetImage(path + imgbmp +'_1280x1024.bmp')          // Resolusi 1280x1024
    else if w <= 1610 then
    begin
      if h <= 910 then
        scf.SetImage(path + imgbmp +'_1600x900.bmp')         // Resolusi 1600x900
      else if h <= 1210 then
        scf.SetImage(path + imgbmp +'_1600x1200.bmp')        // Resolusi 1600x1200
    end
    else
      scf.SetImage(path + imgbmp +'.bmp');                   // Default Resolusi 1920x1080

    AlignFormToMonitor(I, apLeftTop, 0, 0, TForm(scf));

    scf.Show;
  end;
end;

procedure TScreenManager.LoadCommand;
var
  nameFile : string;
begin
  nameFile := ExtractFilePath(Application.ExeName) + 'Screen.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  Command := IniF.ReadString(C_CMD, 'cmd', 'Screen.exe');

  FCmdLine.CommandLine := Command;
end;

procedure TScreenManager.RunController;
var
  nameFile : string;
  countApplication : Integer;
  path : string;
  l : Integer;
  I: Integer;
  scf : TfScreen;
  command_2nd : string;
begin
  nameFile := ExtractFilePath(Application.ExeName) + 'Screen.ini';

  if not FileExists(nameFile) then
    Exit;

  IniF := TIniFile.Create(nameFile);

  //ada berapa aplikasi di console?
  countApplication := StrToInt(IniF.ReadString(C_CMD, 'Application', 'default'));

  if countApplication = 1 then
  begin
    Command := IniF.ReadString(C_CMD, C_Controller, 'did3DControl.exe');
    FCmdLine.CommandLine := Command;

    FCmdLine.Execute;
  end
  else if countApplication = 2 then
  begin
    Command := IniF.ReadString(C_CMD, C_Controller, 'did3DControl.exe');
    FCmdLine.CommandLine := Command;

    FCmdLine.Execute;

    command_2nd := IniF.ReadString(C_CMD, '2ndApp', 'default');
    FCmdLine.CommandLine := command_2nd;

    FCmdLine.Execute;
  end;



  for I := 0 to FormList.Count - 1 do
  begin
    scf := FormList.Items[I];
    scf.SendToBack;
  end;
end;
end.
