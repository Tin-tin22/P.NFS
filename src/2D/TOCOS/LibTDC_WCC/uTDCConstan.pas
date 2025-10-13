unit uTDCConstan;
{constanta and datatype}
interface

const

  // TDC_Cursor ================================================================
  i_OwnShip               =	 0;
  i_OBM_kanan             =  1;
  i_OBM_kiri              =  2;
  i_ICM_sender            =	 3;
  i_ICM_penerima          =	 4;
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

  i_min_marker = i_OwnShip;
  i_max_marker = i_DATUM;

  C_Symbol_Char : array[i_min_marker .. i_max_marker] of char =
  ('A',   'B',   'C',   'D',   'E',   'F',   'G',   'H',
   'I',   'J',   'K',   'L',   'M',   'N',   'O',   'P', 'Q');

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

  ID_ESM_Fix = '*';

// ampl info 1
  ID_AutomaticTrack    = '.'; // U
  ID_RAMTrack          = ' ';
  ID_AcquisitionTrack  = 'O'; // V
  ID_DRTTrack          = '_';
// id tracking
  ID_HOLD = 'T';
// ID_AcquisitionLabel = 'O';


  C_START_TRACKNUM_UDARA    =  0;     //o00
  C_START_TRACKNUM_ATASAIR_TOCOS  = 8;//010
  C_START_TRACKNUM_ATASAIR  = 24;     //o30
  C_START_TRACKNUM_BAWAHAIR = 40;     //o50


  C_BLINDARC_G1: Double = 130.0;
  C_BLINDARC_G2: double = 60.0;
  C_BLINDARC_G3: double = 60.0;

  C_BLINDARC_Exocet_1: double = 35.0;
  C_BLINDARC_Exocet_2: double = 35.0;

  C_MAGNETRON_WAIT_TIME = 5;
  C_LP_WAIT_TIME: Integer = 2;
  C_FREQ_AGIL_CH_TIME = 3;
  C_FC_READY_TIME = 3;

//  C_IMAGES_PATH='images/';
  C_IMAGES_PATH           ='images/wcc/';
  C_IMAGES_BSCOPE         ='images/bscope/';
  C_IMAGES_ASCOPE         ='images/ascope/';

  indx_FC1 = 1;
  indx_FC2 = 2;
  indx_FC3 = 3;
  indx_FC4 = 4;

  C_GUN1_RANGE = 32;
  C_GUN2_RANGE = 32;
  C_GUN3_RANGE = 32;

  C_FC1_RANGE = 48;
  C_FC2_RANGE = 48;
  C_FC3_RANGE = 48;

  ID_TrackingGate  = 'M';
  ID_ElevationMark    = 'K';

  // Sinbad
  SINBAD_DEF_RANGE   = 15000; //yards
  SINBAD_DEF_HEADING = 100; //degree
  SINBAD_DEF_SPEED   = 15; //knots

  ID_LASTPOS  = ID_HOLD;
  ID_CSU_ATT  = '1';
  ID_CSU_HAND = '2';
  ID_PRS      = '5';
  ID_ATT_PRS  = '6';
  ID_NAV_PRS  = '7';
  ID_START_PNT = 'A';

  ID_BEARINGRATE  = 0;
  ID_BEARING      = 1;
  ID_RANGE        = 2;
  ID_COURSE       = 3;
  ID_AOB          = 4;
  ID_SPEED        = 5;
type

  // gigih
//  BTN_COL = (GreenBOX, GreenROUND, RedBOX, RedROUND, OrangeBOX, OrangeROUND, BlueBOX);
  RADAR_STATUS = (RAD_OFF, RAD_STANDBY, RAD_RADIATE);
  FREQ_TYPE = (FREQ_OFF, FREQ_FIX, FREQ_AGIL);
  SCAN_TYPE = (SCAN_OFF, SCAN_HOR, SCAN_HEL);
  POLARIZATION_TYPE = (POL_OFF, POL_HOR, POL_CIRC);
  PRF_TYPE = (PRF_OFF, PRF_LOW, PRF_HIGH);
  FREQ_BAND = (BAND_OFF, BAND1, BAND2, BAND3, BAND4, BAND5, BAND6);

  TCursorOrigin_Status = ( stCU_OR_OFFCENT, stCU_OR_CENT );
  TCenter_Status = (stCENT, stOFFCENT);
  TEngageStatus = (teTrialReview, teEngage, teCeaseEngage);

implementation

end.
