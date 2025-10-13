unit uSettingFormToMonitorWith_ini;

interface

uses
Windows, SysUtils, IniFiles, Registry, uCodecBase64, Dialogs, Forms,
  StrUtils;

const
  c_idx         = 'IDX';
  c_Align       = 'ALIGN';
  c_OffX        = 'OFFX';
  c_OffY        = 'OFFY';
  T_Def         = 0;

  function LoadSet_LayOut(const pth, iniSect, iniVal: string;
    const  iniDeflt : integer): integer;
  function PrepareInif(const iPath: string): string;
  function ForceReadInt(var ini : TIniFile;
   const sSect, sKey: string; iDefault: integer): integer;

  procedure Getsettingform(const pth, cform : string; var Idx, Align, OffX, OffY :integer);   // input path ini & SectForm

implementation

uses
  uBridgeSet;

procedure Getsettingform (const pth, cform : string; var Idx, Align, OffX, OffY :integer);
begin
  Idx   := LoadSet_LayOut(pth, cform, c_idx, T_Def);
  Align := LoadSet_LayOut(pth, cform, c_Align, T_Def);
  OffX  := LoadSet_LayOut(pth, cform, c_OffX, T_Def);
  OffY  := LoadSet_LayOut(pth, cform, c_OffY, T_Def);
end;

function LoadSet_LayOut(const pth, iniSect, iniVal: string;
       const  iniDeflt : integer): integer;
var
  ini: TIniFile;
  iniF: string;
begin
  ini := TIniFile.Create(pth);
  Result := ForceReadInt(ini, iniSect, iniVal, iniDeflt);
  ini.Free;
end;

function PrepareInif(const iPath: string): string;
begin
  result := ExtractFilePath(iPath);

  if not DirectoryExists(result) then
    ForceDirectories(result);

  result := result + '\' + iniBridgeSet;
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
end.
