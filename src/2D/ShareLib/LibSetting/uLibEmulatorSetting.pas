unit uLibEmulatorSetting;

interface

type

    TRecIniMapSet  = record
      geoset : string;
      grid   : string;
      X, Y   : double;
    end;

    //--------------------------------------------------------------------------
    TRecIniTDCSet  = record
      TDCNumber      : byte;
      TDCDefTrackNum : byte;
      TDCTBServer    : byte;
    end;

    TRecIniRadar  = record
      DA_range : single;
      WM_Range : single;
      LW_Range : single;
    end;

    //--------------------------------------------------------------------------
    TRecIniRNavSet  = record
      Frequency,
      PRF,
      PulseWidth,
      AveratePower : single;
      geoset : string;
    end;

    //--------------------------------------------------------------------------
    procedure InitConfig_Map(var aMapSet : TRecIniMapSet);
    procedure SaveConfig_Map(const aMapSet : TRecIniMapSet);
    //--------------------------------------------------------------------------
    procedure InitConfig_tdc(var aTdcSet : TRecIniTDCSet);
    procedure SaveConfig_tdc(const aTdcSet : TRecIniTDCSet);
    //--------------------------------------------------------------------------
    procedure InitConfig_RadarNav(var arNavSet : TRecIniRNavSet);
    procedure SaveConfig_RadarNav(const arNavSet : TRecIniRNavSet);
    //--------------------------------------------------------------------------

implementation

uses
  SysUtils, IniFiles, uLibSettings;


const

  CTDC_SettingFile = 'Emulators.ini';

  CDef_Map_geoset    = '..\data\maps\IndonesiaNoGrid.gst';
  CDef_Rdr_geoset    = '..\data\maps\Indonesia.gst';
  CDef_Map_grid      = '..\data\maps\GRID\indonesia.grd';
  CDef_Map_X         = 112.5;
  CDef_Map_Y         = -7.2;


  CDef_TDC_Num       = 2;
  CDef_TDC_TrackNum  = 61;
  CDef_timbase_Synch = 0;

  CDef_WM_range      = 32;
  CDef_DA_range      = 128;
  CDef_LW_range      = 256;

  iniSect_Map       = 'map';
  iniVal_geo        = 'geoset';
  iniVal_grd        = 'grid';
  iniVal_cx         = 'centerx';
  iniVal_cy         = 'centery';

//------------------------------------------------------------------------------
// TDC Specific

  iniSect_TDC         = 'tdc';
  iniVal_tdc_Num      = 'tdcnumber';
  iniVal_tdc_defnum   = 'deftracknumber';
  iniVal_tdc_tbs = 'timebaseserver';
//  iniVal_ = '';

  iniSect_radar     = 'radar';
  iniVal_wm_range   = 'da_range';
  iniVal_da_range   = 'wm_range';
  iniVal_lw_range   = 'lw_range';

//------------------------------------------------------------------------------
// Radar Navigasi
  iniSect_rNav        = 'rNav';
  iniVal_freq_id      = 'frequency';
  iniVal_range_id     = 'range';    //detectionrange
  iniVal_prf_id       = 'prf';
  iniVal_pw_id        = 'pulsewidth';
  iniVal_avpow_id     = 'averagepower';

//------------------------------------------------------------------------------
function tdcPrepareInif: string;
var fPath : string;
begin
  fpath := GetEmulatorSettingDirectory;

  if not DirectoryExists(fPath) then
    ForceDirectories(fpath);

  result := fPath + CTDC_SettingFile;
end;

procedure InitConfig_Map(var aMapSet : TRecIniMapSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;

  ini := TIniFile.Create(iniF);
  with aMapSet do begin
    geoset :=  ForceReadString(ini, iniSect_Map,  iniVal_geo, CDef_Map_geoset     );
    grid   :=  ForceReadString(ini, iniSect_Map,  iniVal_grd, CDef_Map_grid       );
    X      :=  ForceReadFloat( ini, iniSect_Map,  iniVal_cx , CDef_Map_X          );
    Y      :=  ForceReadFloat( ini, iniSect_Map,  iniVal_cy , CDef_Map_Y          );
  end;
  ini.Free;
end;

procedure SaveConfig_Map(const aMapSet : TRecIniMapSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;
  ini := TIniFile.Create(iniF);
  with aMapSet, Ini do begin
    WriteString(iniSect_Map,  iniVal_geo, geoset );
    WriteString(iniSect_Map,  iniVal_grd, grid   );
    WriteFloat( iniSect_Map,  iniVal_cx , X      );
    WriteFloat( iniSect_Map,  iniVal_cy , Y      );
  end;

  ini.Free;
end;

//-----------------------------------------------------------------------------
procedure InitConfig_tdc(var aTdcSet : TRecIniTDCSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;

  ini := TIniFile.Create(iniF);
  with aTdcSet do begin
    TDCNumber      := ForceReadInt(ini, iniSect_TDC, iniVal_tdc_Num, CDef_TDC_Num);
    TDCDefTrackNum := ForceReadInt(ini, iniSect_TDC, iniVal_tdc_defnum, CDef_TDC_TrackNum   );
    TDCTBServer    := ForceReadInt(ini, iniSect_TDC, iniVal_tdc_tbs, CDef_timbase_Synch  );
  end;
  ini.Free;
end;

procedure SaveConfig_tdc(const aTdcSet : TRecIniTDCSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;
  ini := TIniFile.Create(iniF);
  with aTdcSet, Ini do begin
    WriteInteger( iniSect_TDC, iniVal_tdc_Num, TDCNumber       );
    WriteInteger( iniSect_TDC, iniVal_tdc_defnum, TDCDefTrackNum  );
    WriteInteger( iniSect_TDC, iniVal_tdc_tbs, TDCTBServer     );
  end;

  ini.Free;
end;

//-----------------------------------------------------------------------------
procedure InitConfig_RadarNav(var arNavSet : TRecIniRNavSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;

  ini := TIniFile.Create(iniF);
  with arNavSet do begin

    Frequency    := ForceReadFloat(Ini, iniSect_rNav, iniVal_freq_id,  9000.0 );
    PRF          := ForceReadFloat(Ini, iniSect_rNav, iniVal_prf_id,   825.0 );
    PulseWidth   := ForceReadFloat(Ini, iniSect_rNav, iniVal_pw_id,    0.05);
    AveratePower := ForceReadFloat(Ini, iniSect_rNav, iniVal_avpow_id, 21.0);

    geoset :=  ForceReadString(ini, iniSect_rNav,  iniVal_geo, CDef_Rdr_geoset );
  end;
  ini.Free;
end;

procedure SaveConfig_RadarNav(const arNavSet : TRecInirNavSet);
var ini: TIniFile;
    iniF: string;
begin
  iniF := tdcPrepareInif;
  ini := TIniFile.Create(iniF);
  with arNavSet, Ini do begin
    WriteFloat( iniSect_rNav, iniVal_freq_id, Frequency );
    WriteFloat( iniSect_rNav, iniVal_prf_id,  PRF );
    WriteFloat( iniSect_rNav, iniVal_pw_id,   PulseWidth );
    WriteFloat( iniSect_rNav, iniVal_avpow_id,AveratePower );
    WriteString(iniSect_rNav,  iniVal_geo, geoset );
  end;

  ini.Free;
end;


end.
