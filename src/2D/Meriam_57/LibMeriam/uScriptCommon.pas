unit uScriptCommon;

interface

  procedure BeginGameCommon;
  procedure EndGameCommon;


implementation

uses
   SysUtils, Controls, Forms,
   ulibSettings;


procedure BeginGameCommon;
var iResult: Integer;
    bResult : Boolean;
begin

//  {$IFDEF VER280}
  FormatSettings.DateSeparator     := '/';
  FormatSettings.TimeSeparator     := ':';
  FormatSettings.ShortDateFormat := 'd/m/yyyy';

  FormatSettings.DecimalSeparator  := '.';
  FormatSettings.ThousandSeparator := ',';

//  {$ELSE}
//  DateSeparator := '/';
//  FormatSettings.TimeSeparator     := ':';
//  ShortDateFormat := 'd/m/yyyy';
//
//  DecimalSeparator := '.';
//  ThousandSeparator := ',';
//  {$ENDIF}



  vSettingFile := getFileSetting;

  if FileExists(vSettingFile) then
  begin
    LoadFF_PathImageSetting(vSettingFile, vPathImageSetting);

    InitDefault_DBConfig(vSettingFile, vDbServer.mDBServer, vDbServer.mDBProto, vDbServer.mDBName,
      vDbServer.mDBUser, vDbServer.mDBPass, vDbServer.mDBPort);

    InitDefault_GameServerConfig(vSettingFile, vBridgeServer.m2D_IP, vBridgeServer.m2D_Port,
      vBridgeServer.m3D_IP, vBridgeServer.m3D_Port);
  end
  else
  begin
    Save_PathImageSetting(vSettingFile, vPathImageSetting);
    LoadFF_PathImageSetting(vSettingFile, vPathImageSetting);

    SaveDefault_DBConfig(vSettingFile, vDbServer.mDBServer, vDbServer.mDBProto, vDbServer.mDBName,
      vDbServer.mDBUser, vDbServer.mDBPass, vDbServer.mDBPort);

    InitDefault_DBConfig(vSettingFile, vDbServer.mDBServer, vDbServer.mDBProto, vDbServer.mDBName,
      vDbServer.mDBUser, vDbServer.mDBPass, vDbServer.mDBPort);

    SaveDefault_GameServerConfig(vSettingFile, vBridgeServer.m2D_IP, vBridgeServer.m2D_Port,
      vBridgeServer.m3D_IP, vBridgeServer.m3D_Port);
  end;


end;

procedure EndGameCommon;
begin

end;

end.
