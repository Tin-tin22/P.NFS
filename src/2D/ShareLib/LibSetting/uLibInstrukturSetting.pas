unit uLibInstrukturSetting;

interface

type

  TRecInstMapSet  = record
    geoset, geosetMini1 , geosetMini2  : string;
    xCenter, yCenter, zoom: double;
    xOffset, yOffset: double;
    useOffset: boolean;
  end;

  procedure InitConfig_InstrMap(var aMapSet : TRecInstMapSet);
  procedure SaveConfig_InstrMap(const aMapSet : TRecInstMapSet);


implementation

uses
  SysUtils, IniFiles, uLibSettings;

const
  CInstr_SettingFile = 'Instruktur.ini';

  // default data
  MAPPATH = '..\Data\mapsea\';
  C_GEOSET   = MAPPATH +'INDONESIA.GST';

  // ini const
  iniSect_Map       = 'map';
  iniVal_geo        = 'geoset';
  iniVal_geoMini1   = 'geosetminimap1';
  iniVal_geoMini2   = 'geosetminimap2';
  iniVal_MapX   = 'centerx';
  iniVal_MapY   = 'centery';
  iniVal_MapZ   = 'zoom';

  iniVal_MapOffX   = 'offsetx';
  iniVal_MapOffY   = 'offsety';
  iniVal_MapOff    = 'useoffset';

//------------------------------------------------------------------------------
function instrPrepareInif: string;
var fPath : string;
begin
  fpath := GetEmulatorSettingDirectory;

  if not DirectoryExists(fPath) then
    ForceDirectories(fpath);

  result := fPath + CInstr_SettingFile;
end;

procedure InitConfig_InstrMap(var aMapSet : TRecInstMapSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := instrPrepareInif;

  ini := TIniFile.Create(iniF);
  with aMapSet do begin
    geoset  := ForceReadString(ini, iniSect_Map, iniVal_geo,  C_GEOSET   );
    geosetMini1  := ForceReadString(ini, iniSect_Map, iniVal_geoMini1,  C_GEOSET   );
    geosetMini2  := ForceReadString(ini, iniSect_Map, iniVal_geoMini2,  C_GEOSET   );

    xCenter := ForceReadFloat(ini, iniSect_Map, iniVal_MapX, 112.739524);
    yCenter := ForceReadFloat(ini, iniSect_Map, iniVal_MapY, -7.19549);
    zoom    := ForceReadFloat(ini, iniSect_Map, iniVal_MapZ, 20.0);

    xOffset  :=  ForceReadFloat(ini, iniSect_Map, iniVal_MapOffX, 112.739524);
    yOffset  :=  ForceReadFloat(ini, iniSect_Map, iniVal_MapOffY, -7.19549);

    useOffset:=  ForceReadBool(ini, iniSect_Map, iniVal_MapOff, false);
  end;
  ini.Free;
end;

procedure SaveConfig_InstrMap(const aMapSet : TRecInstMapSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := instrPrepareInif;
  ini := TIniFile.Create(iniF);
  with aMapSet, Ini do begin
    WriteString(iniSect_Map,  iniVal_geo,  geoset );

    WriteFloat(iniSect_Map, iniVal_MapX  , xCenter );
    WriteFloat(iniSect_Map, iniVal_MapY  , yCenter  );
    WriteFloat(iniSect_Map, iniVal_MapZ  , zoom  );

    WriteFloat(iniSect_Map, iniVal_MapOffX  , xOffset );
    WriteFloat(iniSect_Map, iniVal_MapOffY  , yOffset );
    WriteBool(iniSect_Map, iniVal_MapOff  , useOffset );
  end;

  ini.Free;
end;


end.
