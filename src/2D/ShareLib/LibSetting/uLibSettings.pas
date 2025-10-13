unit uLibSettings;

interface

uses
   Inifiles;

  function ForceReadString(var ini : TIniFile;
    const sSect, sKey, sDefault : string): string;

  function ForceReadInt(var ini : TIniFile;
    const sSect, sKey: string; iDefault: integer): integer;

  function ForceReadFloat(var ini : TIniFile;
    const sSect, sKey: string; iDefault: double): double;

  function ForceReadBool(var ini : TIniFile;
    const sSect, sKey: string; iDefault: boolean): boolean;

  function PrepareInif(const iPath, iFile: string): string;

  function GetEmulatorSettingDirectory: string;
  
implementation

uses
  Windows, SysUtils;

function ForceReadString(var ini : TIniFile;
  const sSect, sKey, sDefault : string): string;
begin
  result := ini.ReadString(sSect, sKey, '');
  if result = '' then begin
    result := sDefault;
    ini.WriteString(sSect, sKey, sDefault);
  end;

end;

function ForceReadInt(var ini : TIniFile;
  const sSect, sKey: string; iDefault: integer): integer;
begin
  result := ini.ReadInteger(sSect, sKey, 0);
  if (result = 0) and (iDefault <> 0) then begin
    result := iDefault;
    ini.WriteInteger(sSect, sKey, iDefault);
  end;
end;

function ForceReadFloat(var ini : TIniFile;
  const sSect, sKey: string; iDefault: double): double;
begin
  result := ini.ReadFloat(sSect, sKey, 0.0);
  if (result = 0.0) and (iDefault <> 0.0) then begin
    result := iDefault;
    ini.WriteFloat(sSect, sKey, iDefault);
  end;
end;

function ForceReadBool(var ini : TIniFile;
  const sSect, sKey: string; iDefault: boolean): boolean;
begin
  result := ini.ReadBool(sSect, sKey, iDefault);
  if (result = iDefault) then begin
    ini.WriteBool(sSect, sKey, iDefault);
  end;
end;


function PrepareInif(const iPath, iFile: string): string;
begin
  result := ExtractFilePath(iPath);

  if not DirectoryExists(result) then
    ForceDirectories(result);

  result := result + '\' + iFile;

end;

function GetEmulatorSettingDirectory: string;
begin
  result := ExtractFilePath(ParamStr(0));
end;

{
function GetEmulatorSettingDirectory: string;
var reg: TREgistry;
begin
  result := '.';
  reg := TREgistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',
     False) then begin
     result := Reg.ReadString('AppData');
     result := IncludeTrailingPathDelimiter( result) + 'emulator\';
     Reg.CloseKey;
  end;

  reg.Free;
end;
}
end.
