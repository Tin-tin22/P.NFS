program Sigma;

uses
  Forms,
  Plottable_control in 'Plottable_control.pas' {FrmPlot_Control},
  Sector_screen in 'Sector_screen.pas' {FrmSec_screen},
  TV_video in 'TV_video.pas' {FrmTVvideo},
  Stationing in 'Stationing.pas' {FrmStationing},
  Trial_manoeuvre in 'Trial_manoeuvre.pas' {FrmTrial_man},
  Navigation_route in 'Navigation_route.pas' {FrmNavigation_route},
  Navigation_route_planning in 'Navigation_route_planning.pas' {FrmNavigation_route_plan},
  Man_overboard_recovery in 'Man_overboard_recovery.pas' {FrmMan_over_rec},
  Collision_aviodance in 'Collision_aviodance.pas' {FrmCol_avoid},
  Navrad_monitoring in 'Navrad_monitoring.pas' {FrmNAVRAD_monitoring},
  TDA_composition in 'TDA_composition.pas' {FrmTDA_com},
  TDA_reposition in 'TDA_reposition.pas' {FrmTDA_rep},
  Track_filter in 'Track_filter.pas' {FrmTrack_filter},
  Own_pos_grid in 'Own_pos_grid.pas' {FrmOwn_pos_grid},
  Hal39 in 'Hal39.pas' {FrmHal39},
  Hal40 in 'Hal40.pas' {FrmHal40},
  Transmit_ICM in 'Transmit_ICM.pas' {FrmTransmit_ICM},
  SGO_definition in 'SGO_definition.pas' {FrmSGO_def},
  Operator_desk in 'Operator_desk.pas' {FrmOp_desk},
  Bitmap_file_selection in 'Bitmap_file_selection.pas' {FrmBtm_File_Sel},
  Snapshot in 'Snapshot.pas' {FrmSnapshot},
  TV_video1 in 'TV_video1.pas' {FrmTV_video1},
  Notepad in 'Notepad.pas' {FrmNotepad},
  Timer_settings in 'Timer_settings.pas' {FrmTimer_settings},
  Timer_expired in 'Timer_expired.pas' {FrmTimer_expired},
  Own_ship in 'Own_ship.pas' {FrmOwn_ship},
  Drift in 'Drift.pas' {FrmDrift},
  Magnetic_variation in 'Magnetic_variation.pas' {FrmMagnetic_var},
  Wind in 'Wind.pas' {FrmWind},
  Air_temperature in 'Air_temperature.pas' {FrmAir_temperature},
  Barrometric_pressure in 'Barrometric_pressure.pas' {FrmBarrometric_pressure},
  Computer_meteo in 'Computer_meteo.pas' {FrmComputer_meteo},
  Depth in 'Depth.pas' {FrmDepth},
  Platform_library in 'Platform_library.pas' {FrmPlatform_library},
  Search_platform in 'Search_platform.pas' {FrmSearch_platform},
  Platform_library_180AirPnt in 'Platform_library_180AirPnt.pas' {FrmPlat_library_180AirPnt},
  Tact_figures in 'Tact_figures.pas' {FrmTact_figures},
  Hal61 in 'Hal61.pas' {FrmHal61},
  Assoc in 'Assoc.pas' {FrmAssoc},
  Association_warning in 'Association_warning.pas' {FrmAssociation_warning},
  Track_monitor in 'Track_monitor.pas' {FrmTrack_monitor},
  A_2304_AirPnt_Kinematics in 'A_2304_AirPnt_Kinematics.pas' {FrmA_2304_AirPnt_Kinematics},
  A_2304_AirPnt_Description in 'A_2304_AirPnt_Description.pas' {FrmA_2304_AirPnt_Description},
  A_2304_AirPnt_Datalinks in 'A_2304_AirPnt_Datalinks.pas' {FrmA_2304_AirPnt_Datalinks},
  A_2304_AirPnt_TrackManagement in 'A_2304_AirPnt_TrackManagement.pas' {FrmA_2304_AirPnt_Trackmanagement},
  A_2304_AirPnt_AirControl in 'A_2304_AirPnt_AirControl.pas' {FrmA_2304_AirPnt_AirControl},
  A_2304_AirPnt_IFF in 'A_2304_AirPnt_IFF.pas' {FrmA_2304_AirPnt_IFF},
  Track_warning in 'Track_warning.pas' {FrmTrack_warning},
  Track_warning2 in 'Track_warning2.pas' {FrmTrack_warning2},
  EMCON_warning in 'EMCON_warning.pas' {FrmEMCON_warning},
  EMCON in 'EMCON.pas' {FrmEMCON},
  EMCON_plan_editor in 'EMCON_plan_editor.pas' {FrmEMCON_plan_editor},
  Weapon_assignment_panel in 'Weapon_assignment_panel.pas' {FrmWeapon_assign_panel},
  Fire_authorize_code_def in 'Fire_authorize_code_def.pas' {FrmFire_authorize},
  WAP_fire_authorize in 'WAP_fire_authorize.pas' {FrmWAP_fire_authorize},
  Hold_fire_report_def in 'Hold_fire_report_def.pas' {FrmHold_fire_report_def},
  Own_engagement in 'Own_engagement.pas' {FrmOwn_engagement},
  Track_selection_air in 'Track_selection_air.pas' {FrmTrack_selection_air},
  Threat_evaluation_air in 'Threat_evaluation_air.pas' {FrmThreat_evaluation_air},
  AAW_engagement_advice in 'AAW_engagement_advice.pas' {FrmAAW_engagement},
  AAW_WASA_manual in 'AAW_WASA_manual.pas' {FrmAAW_WASA_man},
  AAW_WASA_auto in 'AAW_WASA_auto.pas' {FrmAAW_WASA_auto},
  Weapon_assignment_monitor in 'Weapon_assignment_monitor.pas' {FrmWeapon_assignment_monitor},
  ExtSensor in 'ExtSensor.pas' {FrmExtSensor},
  SUW_engagement_advice in 'SUW_engagement_advice.pas' {FrmSUW_engagement_advice},
  Track_monitor_brn in 'Track_monitor_brn.pas' {FrmTrack_monitor_brn},
  Throw_off_control in 'Throw_off_control.pas' {FrmThrow_off_control},
  MK46_engagement in 'MK46_engagement.pas' {FrmMK46_engagement},
  MK46_torpedo_launch in 'MK46_torpedo_launch.pas' {FrmMK46_torpedo_launch},
  MK46_engagement_HeliOrMPA in 'MK46_engagement_HeliOrMPA.pas' {FrmMK46_engagement_HeliOrMPA},
  TDZ_calculation in 'TDZ_calculation.pas' {FrmTDZ_calculation},
  LLOA_calculation in 'LLOA_calculation.pas' {FrmLLOA_calculation},
  FOC in 'FOC.pas' {FrmFOC},
  MW08_monitoring_and_control in 'MW08_monitoring_and_control.pas' {FrmMW08_monitoring_and_control},
  MW08_settings in 'MW08_settings.pas' {FrmMW08_settings},
  MW08_RF in 'MW08_RF.pas' {FrmMW08_RF},
  MW08_AIA_air in 'MW08_AIA_air.pas' {FrmMW08_AIA_air},
  MW08_AIA_surface in 'MW08_AIA_surface.pas' {FrmMW08_AIA_surface},
  MW08_AONI_air in 'MW08_AONI_air.pas' {FrmMW08_AONI_air},
  MW08_AONI_surface in 'MW08_AONI_surface.pas' {FrmMW08_AONI_surface},
  MW08_warning_clutter in 'MW08_warning_clutter.pas' {FrmMW08_warning_clutter},
  MW08_warning_duct in 'MW08_warning_duct.pas' {FrmMW08_warning_duct},
  MW08_warning_non in 'MW08_warning_non.pas' {FrmMW08_warning_non},
  EMCON_warning_hal103 in 'EMCON_warning_hal103.pas' {FrmEMCON_warning_hal103},
  Hal109 in 'Hal109.pas' {FrmHal109},
  Hal110 in 'Hal110.pas' {FrmHal110},
  LIROD_KBand in 'LIROD_KBand.pas' {FrmLIROD_KBand},
  LIROD_video_selection in 'LIROD_video_selection.pas' {FrmLIROD_video_selection},
  EMCON_warning_hal116 in 'EMCON_warning_hal116.pas' {FrmEMCON_warning_hal116},
  Evasive_action_warning_torpedo in 'Evasive_action_warning_torpedo.pas' {FrmEvasive_action_warning_torpedo},
  Evasive_action_warning_close in 'Evasive_action_warning_close.pas' {FrmEvasive_action_warning_close},
  Navrad_monitoring_hal119 in 'Navrad_monitoring_hal119.pas' {FrmNAVRAD_monitoring_hal119},
  Navrad_monitoring_revers in 'Navrad_monitoring_revers.pas' {FrmNAVRAD_monitoring_revers},
  LinkY_monitoring_and_control in 'LinkY_monitoring_and_control.pas' {FrmLinkY_monitoring_and_control},
  Hal123 in 'Hal123.pas' {FrmHal123},
  LinkY_encryption_keys in 'LinkY_encryption_keys.pas' {FrmLinkY_encryption_keys},
  LinkY_markers in 'LinkY_markers.pas' {FrmLinkY_markers},
  LinkY_filters in 'LinkY_filters.pas' {FrmLinkY_filters},
  LinkY_network_monitoring in 'LinkY_network_monitoring.pas' {FrmLinkY_network_monitoring},
  LinkY_slot_alloc in 'LinkY_slot_alloc.pas' {FrmLinkY_slot_alloc},
  LinkY_test in 'LinkY_test.pas' {FrmLinkY_test},
  LinkY_warning_TNBlock in 'LinkY_warning_TNBlock.pas' {FrmLinkY_warning_TNBlock},
  LinkY_warning_track in 'LinkY_warning_track.pas' {FrmLinkY_warning_track},
  LinkY_warning_TNBlockExceeded in 'LinkY_warning_TNBlockExceeded.pas' {FrmLinkY_warning_TNBlockExceeded},
  LinkY_warning_NoNetwork in 'LinkY_warning_NoNetwork.pas' {FrmLinkY_warning_NoNetwork},
  LinkY_warning_loss in 'LinkY_warning_loss.pas' {FrmLinkY_warning_loss},
  LinkY_warning_too in 'LinkY_warning_too.pas' {FrmLinkY_warning_too},
  LinkY_force in 'LinkY_force.pas' {FrmLinkY_force},
  LinkY_AMS_Tx in 'LinkY_AMS_Tx.pas' {FrmLinkY_AMS_Tx},
  Tactical_display_area in 'Tactical_display_area.pas' {FrmTactical_display_area},
  LinkY_AMS_Rx in 'LinkY_AMS_Rx.pas' {FrmLinkY_AMS_Rx},
  LinkY_Weapon_doctrine_Tx in 'LinkY_Weapon_doctrine_Tx.pas' {FrmLinkY_weapon_doctrine_tx},
  LinkY_Weapon_doctrine_Rx in 'LinkY_Weapon_doctrine_Rx.pas' {FrmLinkY_Weapon_Doctrine_Rx},
  LinkY_Weapon_doctrine_Rx1 in 'LinkY_Weapon_doctrine_Rx1.pas' {FrmLinkY_weapon_doctrine_Rx1},
  LinkY_change_data_order in 'LinkY_change_data_order.pas' {FrmLinkY_change_data_order},
  LinkY_command_Tx1 in 'LinkY_command_Tx1.pas' {FrmLinkY_command_Tx1},
  LinkY_command_Rx1 in 'LinkY_command_Rx1.pas' {FrmLinkY_command_Rx1},
  LinkY_command_Rx2 in 'LinkY_command_Rx2.pas' {FrmLinkY_command_Rx2},
  LinkY_command_Rx3 in 'LinkY_command_Rx3.pas' {FrmLinkY_command_Rx3},
  LinkY_command_Tx2 in 'LinkY_command_Tx2.pas' {FrmLinkY_command_Tx2},
  LinkY_command_Rx4 in 'LinkY_command_Rx4.pas' {FrmLinkY_command_Rx4},
  LinkY_command_Rx5 in 'LinkY_command_Rx5.pas' {FrmLinkY_command_Rx5},
  LinkY_command_Rx6 in 'LinkY_command_Rx6.pas' {FrmLinkY_command_Rx6},
  LinkY_command_Tx3 in 'LinkY_command_Tx3.pas' {FrmLinkY_command_Tx3},
  LinkY_command_Rx7 in 'LinkY_command_Rx7.pas' {FrmLinkY_command_Rx7},
  LinkY_command_Rx8 in 'LinkY_command_Rx8.pas' {FrmLinkY_command_Rx8},
  LinkY_command_Rx9 in 'LinkY_command_Rx9.pas' {FrmLinkY_command_Rx9},
  Gun_monitoring_and_control in 'Gun_monitoring_and_control.pas' {FrmGun_monitoring},
  Hal147 in 'Hal147.pas' {FrmHal147},
  Hal148 in 'Hal148.pas' {FrmHal148},
  Gun_settings in 'Gun_settings.pas' {FrmGun_settings},
  Naval_gunfire_support in 'Naval_gunfire_support.pas' {FrmNaval_gunfire_support},
  Naval_gunfire_supportHal156 in 'Naval_gunfire_supportHal156.pas' {FrmNaval_gunfire_supportHal156},
  Servotest_76mm_gun in 'Servotest_76mm_gun.pas' {FrmServotest_76mm_gun},
  EXOCET_monitoring_and_control in 'EXOCET_monitoring_and_control.pas' {FrmEXOCET_monitoring_and_control},
  EXOCET_engagement in 'EXOCET_engagement.pas' {FrmEXOCET_engagement},
  Engagement_plan_results in 'Engagement_plan_results.pas' {FrmEngagement_plan_results};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmTactical_display_area, FrmTactical_display_area);
  Application.CreateForm(TFrmLinkY_weapon_doctrine_tx, FrmLinkY_weapon_doctrine_tx);
  Application.CreateForm(TFrmLinkY_Weapon_Doctrine_Rx, FrmLinkY_Weapon_Doctrine_Rx);
  Application.CreateForm(TFrmLinkY_weapon_doctrine_Rx1, FrmLinkY_weapon_doctrine_Rx1);
  Application.CreateForm(TFrmLinkY_change_data_order, FrmLinkY_change_data_order);
  Application.CreateForm(TFrmLinkY_command_Tx1, FrmLinkY_command_Tx1);
  Application.CreateForm(TFrmLinkY_command_Rx1, FrmLinkY_command_Rx1);
  Application.CreateForm(TFrmLinkY_command_Rx2, FrmLinkY_command_Rx2);
  Application.CreateForm(TFrmLinkY_command_Rx3, FrmLinkY_command_Rx3);
  Application.CreateForm(TFrmLinkY_command_Tx2, FrmLinkY_command_Tx2);
  Application.CreateForm(TFrmLinkY_command_Rx4, FrmLinkY_command_Rx4);
  Application.CreateForm(TFrmLinkY_command_Rx5, FrmLinkY_command_Rx5);
  Application.CreateForm(TFrmLinkY_command_Rx6, FrmLinkY_command_Rx6);
  Application.CreateForm(TFrmLinkY_command_Tx3, FrmLinkY_command_Tx3);
  Application.CreateForm(TFrmLinkY_command_Rx7, FrmLinkY_command_Rx7);
  Application.CreateForm(TFrmLinkY_command_Rx8, FrmLinkY_command_Rx8);
  Application.CreateForm(TFrmLinkY_command_Rx9, FrmLinkY_command_Rx9);
  Application.CreateForm(TFrmGun_monitoring, FrmGun_monitoring);
  Application.CreateForm(TFrmHal147, FrmHal147);
  Application.CreateForm(TFrmHal148, FrmHal148);
  Application.CreateForm(TFrmGun_settings, FrmGun_settings);
  Application.CreateForm(TFrmNaval_gunfire_support, FrmNaval_gunfire_support);
  Application.CreateForm(TFrmNaval_gunfire_supportHal156, FrmNaval_gunfire_supportHal156);
  Application.CreateForm(TFrmServotest_76mm_gun, FrmServotest_76mm_gun);
  Application.CreateForm(TFrmEXOCET_monitoring_and_control, FrmEXOCET_monitoring_and_control);
  Application.CreateForm(TFrmEXOCET_engagement, FrmEXOCET_engagement);
  Application.CreateForm(TFrmEngagement_plan_results, FrmEngagement_plan_results);
  Application.Run;
end.
