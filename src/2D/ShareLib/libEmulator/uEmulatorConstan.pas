unit uEmulatorConstan;

interface

uses
  Graphics;
  
const

//------------
    C_cassetemode_id = 'cassettemode';
    C_Cassette_Section = 'cassette';
      C_cassette_file = 'file';
      C_cassette_file_number = 'filenumber';
    C_Form_Data_Section = 'form';
      C_caption = 'caption';
      C_background_sound = 'soundbkground';
      C_ping_sound = 'soundping';
      C_after_ping_sound = 'soundafterping';
    C_Ship_section = 'ship';
      C_posx_id     = 'posx'   ;
      C_posy_id     = 'posy'   ;
      C_speed_id    = 'speed'  ;
      C_heading_id  = 'heading';
    C_wmradar_Section = 'wm_radar';
    C_daradar_Section = 'da_radar';
      C_freq_id   = 'frequency';
      C_range_id  = 'range';    //detectionrange
      C_prf_id    = 'prf';
      C_pw_id     = 'pulsewidth';
      C_avpow_id  = 'averagepower';
    C_targets_section   = 'targets';     //trisno: targets data
      C_target_numbers_id  = 'number';
    C_target_title_section = 'target';
      C_target_id = 'shipid';
      C_target_speed_id = 'speed';
      C_target_heading_id = 'heading';
      C_target_posx_id = 'posx';
      C_target_posy_id = 'posy';
      C_target_soundfile_id = 'soundfile';
      C_target_soundfilepassive_id = 'soundfilepassive';
      C_target_profile_id = 'profileimage';
      C_target_echolevel_id = 'echolevel';
      C_target_freq_id = 'freq';
    //TODO: add events constan
    C_Events_Section = 'events';
      C_event_numbers_id = 'numevents';
    C_event_title_section = 'event';
      C_event_type_id = 'type';
      C_event_timestart_id = 'timestart';
      C_event_duration_id = 'timestart';
      C_event_intvalue_id = 'intvalue';
      C_event_strvalue_id = 'strvalue';
    //trisno: constant for TRTD
    C_Sonar_Max_Freq_Slot = 8;
    C_Sonar_Bearing_Slot_Number = 30;
    C_SlotBearings : array [0 .. 29] of integer =
      (180,192,204,216,228,
       240,252,264,276,288,
       300,312,324,336,348,
         0, 12, 24, 36, 48,
        60, 72, 84, 96,108,
       120,132,144,156,168);
      {(174,186,198,210,222,
       234,246,258,270,282,
       294,306,318,330,342,
       354,  6, 18, 30, 42,
        54, 66, 78, 90,102,
       114,126,138,150,162);}
    C_DefaultBearingSequence : array [0 .. 29] of byte =
      ( 1, 3, 5, 7, 9,10, 8, 6, 4, 2,
        1, 3, 5, 7, 9,10, 8, 6, 4, 2,
        1, 3, 5, 7, 9,10, 8, 6, 4, 2);
    C_PulseNumber = 2;
    C_DisplayColor = $0000DDDD;//Graphics.clYellow;//clOlive;//clLime;//$0000B4FF;
    C_EchoColor = Graphics.clYellow;//$0000EEEE;//Graphics.clYellow;
    C_SonarNoiseLevel = 2; //in percent
    C_SonarLineNoiseLevel = 20; //in percent
    C_SonarLineMaxLength = 25;
    C_Number_Target_Label = 4;
    C_BearingShift = 12;
    C_ListenRefreshInterval : double = 1200000.0;
    C_ListenShiftInterval : double = 15000.0 / 360.0;

type
    sonarmode = (OMNI, TRDT, LPST, LPGC, MCC, LISTEN, PLAYCASSETTE, QOT, ATS);
    audiobeamloc = (ASC,ALC,AG);
    sonarobjectstatus = (UNMARKED, LABELED, GATED, AUTOTRACKED, GATEDNAUTOTRACKED);
    testresult = (INIT, NOGO, GO);
    TSelectObjectProc = procedure (const ObjectID: String) of object;
    TNewPulseLineProc = procedure of object;
    TAudioMoveProc = procedure (const x: integer) of object;
    TRangeGateMoveProc = procedure (const x: integer) of object;
    TRangeGateShow = procedure (const RGArray : array of integer) of object;
    TPlayerFunc = function (const UID:string; const FileName: string; const volume: integer): Boolean of object;
    TGetPlayerDataFunc = function (const UID: string): byte of object;
    TSequenceList = array [0 .. C_Sonar_Bearing_Slot_Number-1] of byte;
    TRangeList = array [0 .. C_Sonar_Bearing_Slot_Number-1] of double;
    TBearingPixelPosList = array [0 .. C_Sonar_Bearing_Slot_Number-1] of integer;
    TSlotBearingList = array [0 .. C_Sonar_Bearing_Slot_Number-1] of double;

implementation

end.
