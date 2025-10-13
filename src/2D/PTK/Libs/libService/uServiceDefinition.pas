unit uServiceDefinition;

interface

type

  TServiceType = Word;

  TArrayServiceType = array of TServiceType;

  TRecServicePosition = record
    X            : Integer;
    Y            : Integer;
    Domain       : Byte;  // 0: System  , 1: Local
    Monitor      : Byte; // 0: Primary , 1: Secondary
    Selection    : Byte;   // TDA, PDK, ICON, MENU, AUTO, MAN, AP
  end;

{Selection
  - TDA   = TDA menu item.
  - PDK   = via PDK.
  - ICON  = via Icon.
  - MENU  = via pop-up menu (workset unbounded).
  - AUTO  = via pop-up menu (workset, automatic pop-up after workset selection).
  - MAN   = via pop-up menu (workset, initial manual pop-up after workset selection).
    To be used for additional functions within a workset.
  - AP    = always present.
}

  TArrayServicePos = array of TRecServicePosition;

const

  C_SVC_76mm_Gun_Designation                                    =   1;
  C_SVC_76mm_Gun_Monitoring_And_Control                         =   2;
  C_SVC_76mm_Gun_Simulator                                      =   3;
  C_SVC_A244_Engagement                                         =   4;
  C_SVC_AAW_WASA                                                =   5;
  C_SVC_AAW_Engagement_Advice                                   =   6;
  C_SVC_Action_State_Selection                                  =   7;
  C_SVC_Adaptive_System_Parameters                              =   8;
  C_SVC_Air_Temperature                                         =   9;
  C_SVC_Aircraft_Direction                                      =  10;
  C_SVC_Archiving_And_Retrieval                                 =  11;
  C_SVC_Area_Alert                                              =  12;
  C_SVC_Backup_Support_File_System                              =  13;
  C_SVC_Barometric_Pressure                                     =  14;
  C_SVC_Change_Watch_Shift                                      =  15;
  C_SVC_Collision_Avoidance                                     =  16;
  C_SVC_Computer_Meteo                                          =  17;
  C_SVC_CPA_Prediction_1                                        =  18;
  C_SVC_Depth                                                   =  19;
  C_SVC_Diagnostic_Data_Logging_Control                         =  20;
  C_SVC_Drift                                                   =  21;
  C_SVC_ECIS_Global_Settings                                    =  22;
  C_SVC_ECIS_Map_Settings                                       =  23;
  C_SVC_ECIS_Object_Info                                        =  24;
  C_SVC_EMCON_Planning                                          =  25;
  C_SVC_Engagement_Overview                                     =  26;
  C_SVC_Evasive_Manoeuvre                                       =  27;
  C_SVC_Exocet_Alarms                                           =  28;
  C_SVC_Exocet_Engagement                                       =  29;
  C_SVC_Exocet_Firing_Sequence                                  =  30;
  C_SVC_Exocet_Monitoring_And_Control                           =  31;
  C_SVC_Exocet_Simulator                                        =  32;
  C_SVC_External_Sensor_And_Weapon_Zones                        =  33;
  C_SVC_Fire_Authorization_Code_Definition                      =  34;
  C_SVC_Furthest_On_Circle                                      =  35;
  C_SVC_Garbage_Support_File_System                             =  36;
  C_SVC_Helicopter_Recovery                                     =  37;
  C_SVC_Help_Message_Editor                                     =  38;
  C_SVC_Hold_Fire_Control                                       =  39;
  C_SVC_Hold_Fire_Report_Definition                             =  40;
  C_SVC_Humidity                                                =  41;
  C_SVC_Initiate_Manual_Air_Tracks                              =  42;
  C_SVC_Initiate_Manual_Subsurface_Tracks                       =  43;
  C_SVC_Initiate_Manual_Surface_Tracks                          =  44;
  C_SVC_Instructor_Situation_Display                            =  45;
  C_SVC_Inter_Console_Marker                                    =  46;
  C_SVC_Kingklip_Monitoring_And_Control                         =  47;
  C_SVC_Kingklip_Simulator                                      =  48;
  C_SVC_Library_Support_Capability                              =  49;
  C_SVC_Limited_Lines_Of_Approach                               =  50;
  C_SVC_Link_Y_Aircraft_Mission_Status                          =  51;
  C_SVC_Link_Y_Change_Data_Order                                =  52;
  C_SVC_Link_Y_Force_Engagement                                 =  53;
  C_SVC_Link_Y_Monitoring_And_Control                           =  54;
  C_SVC_Link_Y_Track_Control                                    =  55;
  C_SVC_Link_Y_Weapon_Doctrine_Cmd                              =  56;
  C_SVC_Lirod_Designation                                       =  57;
  C_SVC_Lirod_Monitoring_And_Control                            =  58;
  C_SVC_Lirod_Simulator                                         =  59;
  C_SVC_Logical_File_Management                                 =  60;
  C_SVC_Logical_Subsystem_Definition                            =  61;
  C_SVC_Logical_Subsystem_Monitoring                            =  62;
  C_SVC_Magnetic_Variation                                      =  63;
  C_SVC_Maintain_Platform_Library                               =  64;
  C_SVC_Man_Overboard_Recovery                                  =  65;
  C_SVC_Manual_Allocation                                       =  66;
  C_SVC_MW08_Monitoring_And_Control                             =  67;
  C_SVC_MW08_Simulator                                          =  68;
  C_SVC_MW08_TWS_Channel_Designation                            =  69;
  C_SVC_Naval_Gunfire_Support                                   =  70;
  C_SVC_Navigation_Route_Handling                               =  71;
  C_SVC_Navrad_Monitoring                                       =  72;
  C_SVC_Navrad_Simulator                                        =  73;
  C_SVC_OM_Definition                                           =  74;
  C_SVC_Open_Close_At_Given_Bearing                             =  75;
  C_SVC_Open_Close_To_Given_Distance                            =  76;
  C_SVC_Operational_System_Monitoring_And_Control               =  77;
  C_SVC_Operational_System_Parameters                           =  78;
  C_SVC_Operational_Tacticos_Parameters                         =  79;
  C_SVC_Operator_Tactical_Figures                               =  80;
  C_SVC_Operator_Tools                                          =  81;
  C_SVC_Osd_Stab_Simulator                                      =  82;
  C_SVC_Own_Coverage                                            =  83;
  C_SVC_Own_Ship                                                =  84;
  C_SVC_Parallel_Index_Navigation                               =  85;
  C_SVC_Performance_Meter                                       =  86;
  C_SVC_Plan_Cordon_Handling                                    =  87;
  C_SVC_Platform_Library                                        =  88;
  C_SVC_Platform_Library_Information                            =  89;
  C_SVC_Platform_Read_Out                                       =  90;
  C_SVC_Pre_Action_Calibration_Air                              =  91;
  C_SVC_Pre_Action_Calibration_Surface                          =  92;
  C_SVC_Print_Job_Control                                       =  93;
  C_SVC_Print_Snapshot                                          =  94;
  C_SVC_Printer_Rerouter                                        =  95;
  C_SVC_Radar_Scan_Converter_Settings                           =  96;
  C_SVC_Radar_Video_Display                                     =  97;
  C_SVC_RAM_Track_Sequencing                                    =  98;
  C_SVC_Replay_Control                                          =  99;
  C_SVC_Repository_Update_Support                               = 100;
  C_SVC_Search_Platform                                         = 101;
  C_SVC_Sector_Screen_Handling                                  = 102;
  C_SVC_Servotest_76mm_OM_Gun                                   = 103;
  C_SVC_SGO_Definition                                          = 104;
  C_SVC_Stationing                                              = 105;
  C_SVC_Subsystem_Access                                        = 106;
  C_SVC_Subsystem_Dl_Control_Overview                           = 107;
  C_SVC_SUW_Engagement_Advice                                   = 108;
  C_SVC_System_Access                                           = 109;
  C_SVC_System_Configuration_Definition                         = 110;
  C_SVC_System_Start_Up                                         = 111;
  C_SVC_Tactical_Data_Logging_Control                           = 112;
  C_SVC_Tactical_Dl_Scenario_Definition                         = 113;
  C_SVC_Tactical_Replay_Control                                 = 114;
  C_SVC_Tactical_Situation_Display_Related                      = 115;
  C_SVC_TDS_Simulator                                           = 116;
  C_SVC_Technical_Data_Logging_1_Control                        = 117;
  C_SVC_Technical_Data_Logging_2_Control                        = 118;
  C_SVC_Technical_System_Monitoring                             = 119;
  C_SVC_Technical_System_Monitoring_And_Control                 = 120;
  C_SVC_Technical_System_Parameters                             = 121;
  C_SVC_Tetral_Aft_Designation                                  = 122;
  C_SVC_Tetral_Aft_Monitoring_And_Control                       = 123;
  C_SVC_Tetral_Aft_Simulator                                    = 124;
  C_SVC_Tetral_Fwd_Designation                                  = 125;
  C_SVC_Tetral_Fwd_Monitoring_And_Control                       = 126;
  C_SVC_Tetral_Fwd_Simulator                                    = 127;
  C_SVC_Threat_Evaluation_Air                                   = 128;
  C_SVC_Throw_Off_Control                                       = 129;
  C_SVC_Time_And_Date                                           = 130;
  C_SVC_Torpedo_Danger_Zone_Calculation                         = 131;
  C_SVC_Track_Association_Manipulation                          = 132;
  C_SVC_Track_Identity_Change                                   = 133;
  C_SVC_Track_Information                                       = 134;
  C_SVC_Track_Join_Manipulation                                 = 135;
  C_SVC_Track_Manipulation                                      = 136;
  C_SVC_Track_Monitor                                           = 137;
  C_SVC_Track_Selection_Air                                     = 138;
  C_SVC_Track_Store                                             = 139;
  C_SVC_Training_Control                                        = 140;
  C_SVC_Class_Library_Definition                                = 141;
  C_SVC_Training_Script_Definition                              = 142;
  C_SVC_Transit_At_Given_Distance                               = 143;
  C_SVC_Trial_Manoeuvre                                         = 144;
  C_SVC_TV_Video                                                = 145;
  C_SVC_VECTAC                                                  = 146;
  C_SVC_Warning_And_Alert_Handling                              = 147;
  C_SVC_Weapon_Assignment_Monitoring                            = 148;
  C_SVC_Weapon_Assignment_Panel                                 = 149;
  C_SVC_Wind                                                    = 150;
  C_SVC_Wind_Gps_GMT_Simulator                                  = 151;
  C_SVC_Workset_Definition                                      = 152;
  C_SVC_Workset_Manager                                         = 153;
  C_SVC_World_Definition_And_Control                            = 154;
  C_SVC_Zigzag_Planning                                         = 155;
  C_SVC_TacticalDisplayArea                                     = 156;
  C_SVC_ReadOutArea                                             = 157;
  C_SVC_LINK_Y_CO_Tx                                            = 158;
  C_SVC_LINK_Y_CO_Rx                                            = 159;
  C_SVC_LINK_Y_AMS_Tx                                           = 160;
  C_SVC_LINK_Y_AMS_Rx                                           = 161;
  C_SVC_Line                                                    = 162;
  C_SVC_Calculator                                              = 163;
  C_SVC_FOC                                                     = 164;
  C_SVC_Mail                                                    = 165;
  C_SVC_Operator_Notes                                          = 166;
  C_SVC_Radar_Video_Display_Control                             = 167;
  C_SVC_Snapshot_P                                              = 168;
  C_SVC_Snapshot_S                                              = 169;
  C_SVC_TV_Video_1                                              = 170;
  C_SVC_TV_Video_2                                              = 171;
  C_SVC_Timers                                                  = 172;
  C_SVC_Emitter_Library_Definition                              = 173;
  C_SVC_Tactical_Environment                                    = 174;
  C_SVC_Training_Session_Control                                = 175;
  //
  C_SVC_Decoy_Engagement                                        = 176;
  C_SVC_Decoy_Deployment                                        = 177;
  C_SVC_Decoy_Firing_Sequence                                   = 178;
  C_SVC_Decoy_Simulator                                         = 179;
//  C_SVC_Decoy_Inventory                                         = 180;
  //
  C_SVC_BITMAP_EDITOR                                           = 180;
  C_SVC_CPA_Prediction_2                                        = 181;
  C_SVC_CPA_Prediction_3                                        = 182;
  C_SVC_Launch_Weapon                                           = 183;
  C_SVC_Primary_Desktop                                         = 184;
  C_SVC_Secondary_Desktop                                       = 185;

  C_SVC_Natural_Environmet_Monitor                              = 186;
  C_SVC_ASW_Danger_Zones                                        = 187;
  C_SVC_Console_Editor                                          = 188;

  C_SVC_SPS_Simulator                                           = 189;
  C_SVC_Launcher_Simulator                                      = 190;
  C_SVC_Sonar_Environment                                       = 191;
  C_SVC_Evasive_Action_Warning                                  = 192;
  C_SVC_Input_Hydro_Meteo                                       = 193;
  C_SVC_Holdfire_Report_Def                                     = 194;

  C_SVC_Decoy_EW_Threat_Eval                                    = 194;
  C_SVC_Decoy_Engagement_Planning                               = 195;

  // ESM Startup
  C_SVC_EsmCtrl_ESM_control                                     = 196;
  C_SVC_EsmCtrl_ESM_connect                                     = 197;
  C_SVC_EWSCU_EWSCU_control                                     = 198;
  C_SVC_EWSCU_EWSCU_connect                                     = 199;

  C_SVC_IFF_Simulator                                           = 200;

  //icha
  C_SVC_ECM                                                     = 201;
  C_SVC_ECM_Simulator                                           = 202;

  //uswah
  C_SVC_IFF_PLOT_MONIT                                          = 203;
  C_SVC_IFF_PLOT_DISPLAY                                        = 204;
  C_SVC_Torpedo_Danger_Areas                                    = 205;

    //icha18112014
  C_SVC_IFF_Interrogations                                      = 206;
  C_SVC_IFF_Transponder                                         = 207;

  C_SVC_ICM_Transmit                                            = 208;

  C_SVC_Max = C_SVC_IFF_Transponder;

  // ESM Startup services




  C_SVC_Name : array [0 .. C_SVC_Max] of string =
  (
   'Noservice',
   '76mm Gun Designation',
   '76mm Gun Monitoring And Control',
   '76mm Gun Simulator',
   'A244 Engagement',
   'AAW - WASA',
   'AAW Engagement Advice',
   'Action State Selection',
   'Adaptive System Parameters',
   'Air Temperature',
   'Aircraft Direction',
   'Archiving And Retrieval',
   'Area Alert',
   'Backup Support File System',
   'Barometric Pressure',
   'Shift',
   'Collision Avoidance',
   'Computer Meteo',
   'CPA Prediction 1',
   'Depth',
   'Diagnostic Data Logging Control',
   'Drift',
   'Ecis Global Settings',
   'Ecis Map Settings',
   'Ecis Object Info',
   'EMCON (Planning)',
   'Engagement Overview',
   'Evasive Manoeuvre',
   'Exocet Alarms',
   'Exocet Engagement',
   'Exocet Firing Sequence',
   'Exocet Monitoring And Control',
   'Exocet Simulator (Training)',
   'External Sensor And Weapon Zones',
   'Fire Authorization Code Definition',
   'FOC (Furthest On Circle)',
   'Garbage Support File System',
   'Helicopter Recovery',
   'Help Message Editor',
   'Hold Fire Control',
   'Hold Fire Report Definition',
   'Humidity',
   'Initiate Manual Air Tracks',
   'Initiate Manual Subsurface Tracks',
   'Initiate Manual Surface Tracks',
   'Instructor Situation Display',
   'Inter Console Marker',
   'Kingklip Monitoring And Control',
   'Kingklip Simulator (Training)',
   'Library Support Capability',  ///
   'Limited Lines Of Approach (Lloa)',
   'LINK-Y Aircraft Mission Status',
   'LIRODY Change Data Order',
   'LINK-Y Force Engagement',
   'LINK-Y Monitoring And Control',
   'LINK-Y Track Control',
   'LINK-Y Weapon Doctrine Cmd',
   'LIROD Designation',
   'LIROD Monitoring And Control',
   'LIROD Simulator (Training)',
   'Logical File Management',
   'Logical Subsystem Definition',
   'Logical Subsystem Monitoring',
   'Magnetic Variation',
   'Maintain Platform Library',
   'Man Overboard Recovery',
   'Manual Allocation',
   'MW08 Monitoring And Control',
   'MW08 Simulator (Training)',
   'MW08-TWS Channel Designation',
   'Naval Gunfire Support',
   'Navigation Route',
   'Navrad Monitoring',
   'Navrad Simulator (Training)',
   'OM Definition',
   'Open/Close At Given Bearing',
   'Open/Close To Given Distance',
   'Operational System Monitoring And Control',
   'Operational System Parameters',
   'Operational Tacticos Parameters',
   'Operator Tactical Figures',
   'Operator Tools',
   'OSD STAB Simulator (Training)',
   'Own Coverage',
   'Own Ship',
   'Parallel Index Navigation',
   'Performance Meter',
   'Plan Cordon',
   'Platform Library (Maintain Platform Library)',
   'Platform Library Information',
   'Platform Read-Out',
   'Pre-Action Calibration (PAC) Air',
   'Pre-Action Calibration (PAC) Surface',
   'Print Job Control',
   'Print Snapshot',
   'Printer Rerouter',
   'Radar Scan Converter (RSC) Settings',
   'Radar Video Display',
   'Ram Track Sequencing',
   'Replay Control',
   'Repository Update Support',
   'Search Platform',
   'Sector Screen',
   'Servotest 76mm Om Gun',
   'SGO Definition',
   'Stationing',
   'Subsystem Access',
   'Subsystem DL Control Overview',
   'SUW Engagement Advice',
   'System Access',
   'System Configuration Definition',
   'System Start-Up',
   'Tactical Data Logging Control',
   'Tactical Dl Scenario Definition',
   'Tactical Replay Control',
   'Tactical Situation Display Related',
   'TDS Simulator (Training)',
   'Technical Data Logging 1 Control',
   'Technical Data Logging 2 Control',
   'Technical System Monitoring',
   'Technical System Monitoring And Control',
   'Technical System Parameters',
   'Tetral Aft Designation',
   'Tetral Aft Monitoring And Control',
   'Tetral Aft Simulator (Training)',
   'Tetral Fwd Designation',
   'Tetral Fwd Monitoring And Control',
   'Tetral Fwd Simulator (Training)',
   'Threat Evaluation Air',
   'Throw-Off Control',
   'Time And Date',
   'Torpedo Danger Zone Calculation',
   'Track Association Manipulation',
   'Track Identity Change',
   'Track Information',
   'Track Join Manipulation',
   'Track Manipulation',
   'Track Monitor',
   'Track Selection Air',
   'Track Store',
   'Training Control',
   'Class Library Definition',
   'Training Script Definition',
   'Transit At Given Distance',
   'Trial Manoeuvre',
   'TV Video',
   'VECTAC',
   'Warning And Alert',
   'Weapon Assignment Monitoring',
   'Weapon Assignment Panel',
   'Wind',
   'Wind/GPS/GMT Simulator (Training)',
   'Workset Definition',
   'Workset Manager',
   'World Definition And Control',
   'Zigzag Planning',
   'Tactical Display Area',
   'Read Out Area',
   'Link Y Command Orders Tx',
   'Link Y Command Orders Rx',
   'Link Y AMS Tx',
   'Link Y AMS Rx',
   '-',
   'Calculator',
   'FOC',
   'Mail',
   'Operator Notes',
   'Radar Video Display Control',
   'Snapshot (primary screen)',
   'Snapshot (secondary screen)',
   'TV Video-1',
   'TV Video-2',
   'Timers',
   'Emitter Library Definition',
   'Tactical Environment',
   'Training Session Control',
   'Decoy Engagement', (* wrkDecoy *)
   'Decoy Deployment',
   'Decoy Firing Sequence',
   'Decoy Simulator',
//   'Decoy Inventory',
   'Bitmap Editor',
   'CPA Prediction 2',
   'CPA Prediction 3',
   'Launch Weapon',
   'Primary Desktop',
   'Secondary Desktop',
   'Natural Environment Monitor',
   'ASW Danger Zones',
   'Console Editor',
   'SPS Simulator (Training)',
   'Launcher Simulator (Training)' ,
   'Sonar Environment (Training)',
   'Evasive Action Warning',
   'Input Hydro Meteo',
   'EW Threat Evaluation',
   'EW Engagement Planning',
   'ESM control',
   'ESM connect',
   'EWSCU control',
   'EWSCU connect',
   'IFF Simulator (Training)',
   'ECM',
   'ECM Simulator',
   'IFF Plot Monitor',
   'IFF Plot Display',
   'Torpedo Danger Areas',
   'IFF Interrogations',
   'IFF Transponder'
  );


  // Konstantan Service yg BUKAN nama service
  C_SVCMonitor_Primary      = 0; // 0: Primary , 1: Secondary
  C_SVCMonitor_Secondary    = 1;

  C_SVCDomain_System        = 0;
  C_SVCDomain_Local         = 1;

  C_SVCSelect_TDA       = 0;
  C_SVCSelect_PDK       = 1;
  C_SVCSelect_ICON      = 2;
  C_SVCSelect_MENU      = 3;
  C_SVCSelect_AUTO      = 4;
  C_SVCSelect_MAN       = 5;
  C_SVCSelect_AP        = 6;
  C_SVCSelect_SEMI_AUTO = 7;

  function GetServiceName(const i: integer): string;

  procedure SetServicePosIndex(const aSvcID, aIdx: Integer);




var

  V_SVC_DEF_INDEX : array[0 .. C_SVC_Max] of Byte;

implementation

function GetServicename(const i: integer): string;
begin
  result := C_SVC_Name[i];
end;

procedure SetServicePosIndex(const aSvcID, aIdx: Integer);
begin
  V_SVC_DEF_INDEX[aSvcID] := aIdx;
end;

end.
