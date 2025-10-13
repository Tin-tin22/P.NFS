unit uBaseConstan;

interface

uses
  SysUtils, Classes, Forms;

const
  //C_Degree_To_Meter = 60.0 * 1852.0;
  TOOL_DISTANCE = 100;
  TOOL_MOVE_UNIT = 101;
  TOOL_SELECT_UNIT = 102;
  TOOL_SET_POSITION_ONDATABASE = 103;
  TOOL_SELECT_RBUTARGET = 104;
  TOOL_SELECT_3DPOS = 105;
  TOOL_SELECT_SPSTARGET = 106;
  TOOL_SELECT_COORD = 107;
  TOOL_SELECT_ASROCTARGET = 108;
  TOOL_SELECT_YAKHONTTARGET = 109;
  TOOL_SELECT_C802TARGET = 110;
  TOOL_DATABASE_POS = 111;
  TOOL_SELECT_COORD_C802 = 112;
  TOOL_SELECT_COORD_YAKHONT = 113;
  TOOL_SELECT_COORD_STRELLA = 114;
  TOOL_SELECT_COORD_MISTRAL = 115;
  TOOL_REPOST_OBJECT = 116;
  TOOL_SELECT_COORD_RBU     = 117;
  TOOL_SELECT_TORPSUT_TARGET = 118;
 // TOOL_SELECT_RBU_TARGET   = 119;
  TOOL_SELECT_ASROC_TARGET = 120;
  TOOL_SELECT_CANON_TARGET = 121;
  TOOL_SELECT_TETRAL_TARGET = 122;
  TOOL_MAP_VIEW = 123;
  TOOL_SELECT_WAYPOINT = 124;

  C_Degree_To_Meter =  111319.49081869110446433493412896;

  C_Degree_To_NauticalMile    = 60.0;
  C_NauticalMile_To_Degree    = 1.0/60.0;

  C_NauticalMiles_TO_Meter    = 1852.0;
  C_Meter_To_NauticalMiles    = 1.0/1852.0;

  C_NauticalMiles_To_KiloMeter    = 1.8520;
  C_KiloMeter_To_NauticalMiles    = 1000.0/1852.0;

  C_NauticalMile_To_Feet      = 6076.131;
  C_Feet_To_NauticalMile      = 1.0/6076.131;
  C_HourToMinute = 60.0;
  C_MinuteToHour = 1 / 60.0;

  C_MilliSecondToHour   : double = 0.001 / 3600.0;
  C_HourToMilliSecond   : double = 3600000.0;

  C_SecondToHour   : double = 1.0 / 3600.0;
  C_HourToSecond   : double = 3600.0;
  
  C_MilliSecondToMinute   : double = 0.001 / 60.0;
  C_MinuteToMilliSecond   : double = 60000.0;

  C_MilliSecondToSecond : double = 0.001;
  C_SecondToMilliSecond : double = 1000.0;

  C_Meter_To_Feet             = 3.2808399;
  C_Feet_To_Meter             = 1.0/ C_Meter_To_Feet;

  C_NauticalMiles_To_Yard    = 2025.0;
  C_Yard_To_NauticalMiles    = 1.0/2025.0;

  C_NauticalMile_To_Fathom   =  1012.68591;
  C_Fathom_To_NauticalMile   =  1.0/1012.68591;

  C_DM_To_Yard  = 2000;
  C_DM_To_NM    = 0.9874729;
  C_NM_To_DM    = 1.012686;

  C_Meter_To_Yard = 1.0936133;
  C_Yard_To_Meter = 1 / 1.0936133;

  C_NauticalMile_To_Cable   =  10.0;
  C_Cable_To_NauticalMile   =  0.1;

  C_Meter_To_Cable   =  1.0/185.2;
  C_Cable_To_Meter   =  185.2;

  C_Mile_To_Cable   =  1.0/0.11508;
  C_Cable_To_Mile   =  0.11508;


  C_Pi: double    = Pi;
  C_2_Pi: double  = 2.0 * Pi;
  C_180_per_Pi    = 180.0 / Pi;
  C_Pi_per_180    = Pi / 180.0;

  C_RadToDeg   = C_180_per_pi;
  C_DegToRad   = C_Pi_per_180;

  C_MinZero    = 0.000000001;       // lebih kecil dari  ini dianggap 0.0;

  C_SPEED_OF_LIGHT = 299792460.0  ;  // m per s
  C_SPEED_OF_SOUND_IN_SEA = 1500.0;  // (approx) m per s
  C_SPEED_OF_SOUND_IN_SEA_Y = 1610.0;  // (approx) yard per s
  C_RANGE_OF_SOUND_IN_20M = 95000;//1932000.0; //yard

  C_Degree_To_Mils    = 17.7777777778;
  C_Mils_To_Degree    = 1 / C_Degree_To_Mils;

  C_Degree_To_TD    = 16.6;
  C_TD_To_Degree    = 1 / C_Degree_To_TD;

  C_Ms_To_knot   = 1.9438444924406047516198704103672;
  C_Knot_To_ms   = 0.51444444444444444444444444444444; //1.0/C_Ms_To_knot;

  // uSimulationManager, reading from inifiles;
  C_Map_Section = 'map';
      C_gst_ident   = 'geoset';
      C_grd_ident   = 'grid';

  C_mult_sect = 'multiplayer';
      C_servip_id = 'serverip';
      C_servport_id = 'serverport';
      C_autoconnect = 'autoconnect';
  C_game_sect  = 'game';
      C_playmode_id = 'playmode';

//------------
    C_Ship_section = 'ship';
      C_posx_id     = 'posx'   ;
      C_posy_id     = 'posy'   ;
      C_posz_id     = 'posz'   ;
      C_speed_id    = 'speed'  ;
      C_heading_id  = 'heading';
    C_wmradar_Section = 'wm_radar';
    C_daradar_Section = 'da_radar';
      C_freq_id   = 'frequency';
      C_range_id  = 'range';    //detectionrange
      C_prf_id    = 'prf';
      C_pw_id     = 'pulsewidth';
      C_avpow_id  = 'averagepower';

  C_defColor = $0050d0ff;

//  C_defColor = $0040c0ff;
//  C_defColor = $0030b0ef;


  // nanti ganti ini ke load file
  C_ShipC_Fatahillah =	  3;    // Nala
    C_ShipID_Nala           =    6; // Nala
    C_ShipID_Fatahillah     =    4; // Fatahilah

  C_ShipC_AhmadYani  =    6;     // OSWALD SIAHAAN
  C_ShipC_Mandau     =    1361;  // RENCONG
  C_ShipC_Singa      =    1364;  // Singa
  C_ShipC_Sigma      =    1290;   // Sigma
  C_ShipC_Kilo       =    9999;
  C_ShipC_Cakra      =    21;


  //****************************************
//  DistancePowerLost           = 100; // ???
//  PowerLostPerDistance        = 10; // ???
//  MinimumPower                = 10;
//  EMWaveSpeed                 = 1000; // in meter/microseconds

  //Weather setting files
  FGLOBALWEATHER ='.\LibWeather\WEATHERGLOBAL.INI';
  FWEATHER       ='.\LibWeather\WEATHER.INI';
  FTURBULENCE    ='.\LibWeather\TURBULENCE.INI';
  FWEATHERPATH   ='.\LibWeather\';

  // TDC_Cursor ================================================================
  i_OwnShip               =	 0;
  i_OBM_kanan             =  1;
  i_OBM_kiri              =  2;
  i_ICM_sender            =	 3;
  i_ICM_receiver          =	 4;
  i_Surface_Grid_Ori      =	 5;
  i_Splash_Point_ASR      =	 6;
  i_PHP_torpedo           =  7;
  i_Drop_Point	          =  8;
  i_Offset_BTK	          =  9;
  i_Kursor_Elevasi_WCC    = 10;
  i_Tanda_Tunda_Tembakan  = 11;
  i_Gerbang_Pelacakan	    = 12;
  i_Sasaran_simulasi_tes  = 13;
  i_penunjukan_ASRL	      = 14;
  i_plot	                = 15;
  i_DATUM                 = 16;
  i_ThrowOff              = 17;

  i_min_marker = i_OwnShip;
  i_max_marker = i_ThrowOff;

  C_Symbol_Char : array[i_min_marker .. i_max_marker] of char =
  ('A',   'B',   'C',   'D',   'E',   'F',   'G',   'H',
   'I',   'J',   'K',   'L',   'M',   'N',   'O',   'P',   'Q',   '#');

//- TDC Ident ----------------------------------------------------------------------------
// main symbol
  ID_Udara_Unknown   = 'A';
  ID_Udara_Hostile   = 'B';
  ID_Udara_Friendly  = 'C';

  ID_Rudal      = 'J';

  ID_AtasAir_Unknown   = 'D';
  ID_AtasAir_Hostile   = 'E';
  ID_AtasAir_Friendly  = 'F';
  ID_AtasAir_Helicopter = 'K';

  ID_BawahAir_Unknown   = 'G';
  ID_BawahAir_Hostile   = 'H';
  ID_BawahAir_Friendly  = 'I';
  ID_BawahAir_NonSub    = 'R';

  ID_ESM_Fix  = '*';
  ID_REFF_POS = '+';

// ampl info 1
  ID_AutomaticTrack    = 'U';
  ID_RAMTrack          = ' ';
  ID_AcquisitionTrack  = 'V';
  ID_DRTTrack          = '_';
  //ID_ATRA              = ID_AcquisitionTrack;
  //ID_AT                = ID_AutomaticTrack;
  ID_RA                = '+';
  ID_FC                = '*';
  ID_Astris            = 'W';
// id Tracking
  ID_HOLD = 'T';
  ID_ASS_ASRL = 'S';
  ID_CLOSE_CONTROLER = 'L';



  //  ID_Max_Wire = ID_ESM_Fix;

// SUT Prediction line symbol
  ID_Max_Wire = 'i';
  ID_Max_Batt = 'a';
  ID_Endis    = 'b';

// SUT LPD status
  ID_WireRupture      = 'A';
  ID_GeneralStatus    = 'e';         // tanda baterai

  ID_TargetDet        = 'f';
  ID_TurnAround       = 'g';

  ID_Power_Supply_Not_Correct = 'E';
  ID_SteeringAllowed          = 'c'; // Safe Distance

  ID_IgnitionFree     = 'd';
  ID_Prox_Fuze_effect = 'G';

  // LPD function
  ID_Close_controller = 'g';

  C_START_TRACKNUM_UDARA    =  0;     //o00    o027
  C_START_TRACKNUM_ATASAIR  = 24;     //o30
  C_START_TRACKNUM_BAWAHAIR = 40;     //o50


  C_BLINDARC_G1: Double = 130.0;
  C_BLINDARC_G2: double = 60.0;
  C_BLINDARC_G3: double = 60.0;

  C_BLINDARC_Exocet_1: double = 35.0;
  C_BLINDARC_Exocet_2: double = 35.0;

  C_key_kiri   = 0;
  C_key_kanan  = 1;

  C_LauncherRBU_Kanan = 1;
  C_LauncherRBU_Kiri = 2;

  c_klik_map_scene = 1;
  c_klik_map_ship = 2;
  c_klik_map_ojk = 3;
  c_klik_map_oll = 4;

  c_klik_databaseship = 5;

  C_RocketErika_LOW_Min  = 600;
  C_RocketErika_LOW_Max  = 1040;
  C_RocketErika_HIGH_Min = 1040;
  C_RocketErika_HIGH_Max = 1620;

  C_RocketNelly_LOW_Min  = 1620; // ikut rumus dulu        //  versi asli 600;
  C_RocketNelly_LOW_Max  = 2350;
  C_RocketNelly_HIGH_Min = 2350;
  C_RocketNelly_HIGH_Max = 3600;

  C_V_RocketErika_LOW    = 100.00;
  C_V_RocketErika_HIGH   = 130.00;
  C_V_RocketNelly_LOW    = 166.00;
  C_V_RocketNelly_HIGH   = 207.00;


  C_Val_scaleGreen = 65;
  C_start_scaleGreen = 15;

  {B-scope}
 C_ScaleWidth_on_Bscope  = 10.0 * C_Mils_To_Degree;           // 10   mils  ==>> Degree

 C_ScaleHeight_on_Bscope = 2000.0 * C_Yard_To_NauticalMiles ;  // 2000 yard  ==>> Nm

 C_NauticalMiles_To_Bscope_ScaleHeight = C_NauticalMiles_To_Yard / 2000;
 C_Degree_To_Bscope_ScaleWidth = C_Degree_To_Mils / 10;

type
  TTrackDomain   = ( tdAtasAir, tdBawahAir, tdUdara, tdEW, tdDontCare,
                     tdDatum, tdRP, tdCursor,
// track bearing OWA
                     tdGEN, tdESM, tdECM, tdASW, tdVIS, tdTOP,
                     tdPointGen, tdPointEW, tdPointAir, tdPointASW
                      );

  // gigih
  //TFC_ID = (FC_OFF, FC_1, FC_2, FC_3, FC_4);

  TBSMark = (tbmNone, tbmDefault, tbmShip, tbmIsland);
  TASMark = (tamNone, tamEcho, tamBGate, tamBGateEcho, tamNGate);
  ATOStat = (atoBreak, atoLockOn, atoAuto1, atoAuto2 ,atoReady, AtoLost1, AtoLost2, AtoGone);
  BscopeStat = (bsShow, bsHide);
  TThrowOff = (ttoMin12, ttoMin6, tto0, ttoPlus6, ttoPlus12);
  TSIMType = (tsShip, tsPlane);



const
  // WCC
  C_SIM_RANGE = 4;
  C_SIM_BEARING = 0;

  //C_Bullet_Speed  = 800; // m/s
  C_MuzzleVel1 = 800;
  C_MuzzleVel2 = 700;
  C_MuzzleVel3 = 700;

  C_EMarkMin = 270;
  C_EMarkMax = 350;

  C_WRangeGateID = 'wrg';
  C_WRangeGateWithEcho = 'wrge';
  C_NRangeGateID = 'nrg';
  C_EchoID = 'e';

  C_SIMUID_Ship   = 'uid_ship';
  C_SIMUID_Plane  = 'uid_plane';

  //C_SplashID1 = 'splash1';
  //C_SplashID2 = 'splash2';
  //C_SplashID3 = 'splash3';

implementation



end.
