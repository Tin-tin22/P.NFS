unit uLibTDC_Sigma;

interface

uses
  uLibTDCClass,
  A_2304_AirPnt,
  A_2304_AirPnt_AirControl,
  A_2304_AirPnt_Datalinks,
  A_2304_AirPnt_Description,
  A_2304_AirPnt_IFF,
  A_2304_AirPnt_Kinematics,
  A_2304_AirPnt_TrackManagement,
  AAW_engagement_advice,
  AAW_WASA_auto,
  AAW_WASA_manual,
  Air_temperature,
  Assoc,
  Association_warning,
  Barrometric_pressure,
  Bitmap_file_selection,
  Collision_aviodance,
  Computer_meteo,
  Depth,
  Drift,
  EMCON,
  EMCON_plan_editor,
  EMCON_warning,
  EMCON_warning_hal103,
  EMCON_warning_hal116,
  Engagement_plan_results,
  Evasive_action_warning_close,
  Evasive_action_warning_torpedo,
  EXOCET_engagement,
  EXOCET_monitoring_and_control,
  ExtSensor,
  Fire_authorize_code_def,
  FOC,
  Gun_monitoring_and_control,
  Gun_settings,
//  Hal36,
  Hal39,
  Hal40,
  Hal61,
  Hal109,
  Hal110,
  Hal123,
  Hal147,
  Hal148,
  Hold_fire_report_def,
  LinkY_AMS,
  LinkY_AMS_Rx,
  LinkY_AMS_Tx,
  LinkY_change_data_order,
  LinkY_command_Rx1,
  LinkY_command_Rx2,
  LinkY_command_Rx3,
  LinkY_command_Rx4,
  LinkY_command_Rx5,
  LinkY_command_Rx6,
  LinkY_command_Rx7,
  LinkY_command_Rx8,
  LinkY_command_Rx9,
  LinkY_command_Tx1,
  LinkY_command_Tx2,
  LinkY_command_Tx3,
  LinkY_encryption_keys,
  LinkY_filters,
  LinkY_force,
  LinkY_markers,
  LinkY_monitoring_and_control,
  LinkY_network_monitoring,
  LinkY_slot_alloc,
  LinkY_test,
  LinkY_warning_loss,
  LinkY_warning_NoNetwork,
  LinkY_warning_TNBlock,
  LinkY_warning_TNBlockExceeded,
  LinkY_warning_too,
  LinkY_warning_track,
  LinkY_Weapon_doctrine_Rx,
  LinkY_Weapon_doctrine_Rx1,
  LinkY_Weapon_doctrine_Tx,
  LIROD,
  LIROD_KBand,
  LIROD_video_selection,
  LLOA_calculation,
  Magnetic_variation,
  Man_overboard_recovery,
  MK46_engagement,
  MK46_engagement_HeliOrMPA,
  MK46_torpedo_launch,
  MW08_AIA_air,
  MW08_AIA_surface,
  MW08_AONI_air,
  MW08_AONI_surface,
  MW08_monitoring_and_control,

  Tactical_display_area;

type

//==============================================================================
  TTDC_Sigma = class(TGenericTDCInterface)
  protected

  public
    FrmTactical_display_area: TFrmTactical_display_area;

    FrmA_2304_AirPnt: TFrmA_2304_AirPnt;
    FrmA_2304_AirPnt_AirControl: TFrmA_2304_AirPnt_AirControl;
    FrmA_2304_AirPnt_Datalinks: TFrmA_2304_AirPnt_Datalinks;
    FrmA_2304_AirPnt_Description: TFrmA_2304_AirPnt_Description;
    FrmA_2304_AirPnt_IFF: TFrmA_2304_AirPnt_IFF;
    FrmA_2304_AirPnt_Kinematics: TFrmA_2304_AirPnt_Kinematics;
    FrmA_2304_AirPnt_Trackmanagement: TFrmA_2304_AirPnt_Trackmanagement;
    FrmAAW_engagement: TFrmAAW_engagement;
    FrmAAW_WASA_auto: TFrmAAW_WASA_auto;
    FrmAAW_WASA_man: TFrmAAW_WASA_man;
    FrmAir_temperature: TFrmAir_temperature;
    FrmAssoc: TFrmAssoc;
    FrmAssociation_warning: TFrmAssociation_warning;
    FrmBarrometric_pressure: TFrmBarrometric_pressure;
    FrmBtm_File_Sel: TFrmBtm_File_Sel;
    FrmCol_avoid: TFrmCol_avoid;
    FrmComputer_meteo: TFrmComputer_meteo;
    FrmDepth: TFrmDepth;
    FrmDrift: TFrmDrift;
    FrmEMCON: TFrmEMCON;
    FrmEMCON_plan_editor: TFrmEMCON_plan_editor;
    FrmEMCON_warning: TFrmEMCON_warning;
    FrmEMCON_warning_hal103: TFrmEMCON_warning_hal103;
    FrmEMCON_warning_hal116: TFrmEMCON_warning_hal116;
    FrmEngagement_plan_results: TFrmEngagement_plan_results;
    FrmEvasive_action_warning_close: TFrmEvasive_action_warning_close;
    FrmEvasive_action_warning_torpedo: TFrmEvasive_action_warning_torpedo;
    FrmEXOCET_engagement: TFrmEXOCET_engagement;
    FrmEXOCET_monitoring_and_control: TFrmEXOCET_monitoring_and_control;
    FrmExtSensor: TFrmExtSensor;
    FrmFire_authorize: TFrmFire_authorize;
    FrmFOC: TFrmFOC;
    FrmGun_monitoring: TFrmGun_monitoring;
    FrmGun_settings: TFrmGun_settings;
    FrmHal39: TFrmHal39;
    FrmHal40: TFrmHal40;
    FrmHal61: TFrmHal61;
    FrmHal109: TFrmHal109;
    FrmHal110: TFrmHal110;
    FrmHal123: TFrmHal123;
    FrmHal147: TFrmHal147;
    FrmHal148: TFrmHal148;
    FrmHold_fire_report_def: TFrmHold_fire_report_def;
    FrmLinkY_AMS: TFrmLinkY_AMS;
    FrmLinkY_AMS_Rx: TFrmLinkY_AMS_Rx;
    FrmLinkY_AMS_Tx: TFrmLinkY_AMS_Tx;
    FrmLinkY_change_data_order: TFrmLinkY_change_data_order;
    FrmLinkY_command_Rx1: TFrmLinkY_command_Rx1;
    FrmLinkY_command_Rx2: TFrmLinkY_command_Rx2;
    FrmLinkY_command_Rx3: TFrmLinkY_command_Rx3;
    FrmLinkY_command_Rx4: TFrmLinkY_command_Rx4;
    FrmLinkY_command_Rx5: TFrmLinkY_command_Rx5;
    FrmLinkY_command_Rx6: TFrmLinkY_command_Rx6;
    FrmLinkY_command_Rx7: TFrmLinkY_command_Rx7;
    FrmLinkY_command_Rx8: TFrmLinkY_command_Rx8;
    FrmLinkY_command_Rx9: TFrmLinkY_command_Rx9;
    FrmLinkY_command_Tx1: TFrmLinkY_command_Tx1;
    FrmLinkY_command_Tx2: TFrmLinkY_command_Tx2;
    FrmLinkY_command_Tx3: TFrmLinkY_command_Tx3;
    FrmLinkY_encryption_keys: TFrmLinkY_encryption_keys;
    FrmLinkY_filters: TFrmLinkY_filters;
    FrmLinkY_force: TFrmLinkY_force;
    FrmLinkY_markers: TFrmLinkY_markers;
    FrmLinkY_monitoring_and_control: TFrmLinkY_monitoring_and_control;
    FrmLinkY_network_monitoring: TFrmLinkY_network_monitoring;
    FrmLinkY_slot_alloc: TFrmLinkY_slot_alloc;
    FrmLinkY_test: TFrmLinkY_test;
    FrmLinkY_warning_loss: TFrmLinkY_warning_loss;
    FrmLinkY_warning_NoNetwork: TFrmLinkY_warning_NoNetwork;
    FrmLinkY_warning_TNBlock: TFrmLinkY_warning_TNBlock;
    FrmLinkY_warning_TNBlockExceeded: TFrmLinkY_warning_TNBlockExceeded;
    FrmLinkY_warning_too: TFrmLinkY_warning_too;
    FrmLinkY_warning_track: TFrmLinkY_warning_track;
    FrmLinkY_Weapon_Doctrine_Rx: TFrmLinkY_Weapon_Doctrine_Rx;
    FrmLinkY_weapon_doctrine_Rx1: TFrmLinkY_weapon_doctrine_Rx1;
    FrmLinkY_weapon_doctrine_tx: TFrmLinkY_weapon_doctrine_tx;
    FrmLIROD: TFrmLIROD;
    FrmLIROD_KBand: TFrmLIROD_KBand;
    FrmLIROD_video_selection: TFrmLIROD_video_selection;
    FrmLLOA_calculation: TFrmLLOA_calculation;
    FrmMagnetic_var: TFrmMagnetic_var;
    FrmMan_over_rec: TFrmMan_over_rec;
    FrmMK46_engagement: TFrmMK46_engagement;
    FrmMK46_engagement_HeliOrMPA: TFrmMK46_engagement_HeliOrMPA;
    FrmMK46_torpedo_launch: TFrmMK46_torpedo_launch;
    FrmMW08_AIA_air: TFrmMW08_AIA_air;
    FrmMW08_AIA_surface: TFrmMW08_AIA_surface;
    FrmMW08_AONI_air: TFrmMW08_AONI_air;
    FrmMW08_AONI_surface: TFrmMW08_AONI_surface;
    FrmMW08_monitoring_and_control: TFrmMW08_monitoring_and_control;

    constructor Create;
    destructor Destroy; override;

    procedure ShowAllForm; override;


  end;


implementation

uses SysUtils;

{ TTDC_Sigma }

constructor TTDC_Sigma.Create;
begin
  inherited;

  frmTengah := TFrmTactical_display_area.Create(nil);
  FrmTactical_display_area := frmTengah as TFrmTactical_display_area;

  FrmA_2304_AirPnt   :=  TFrmA_2304_AirPnt.Create(nil);
  FrmA_2304_AirPnt_AirControl    :=  TFrmA_2304_AirPnt_AirControl.Create(nil);
  FrmA_2304_AirPnt_Datalinks     :=  TFrmA_2304_AirPnt_Datalinks.Create(nil);
  FrmA_2304_AirPnt_Description  :=  TFrmA_2304_AirPnt_Description.Create(nil);
  FrmA_2304_AirPnt_IFF :=  TFrmA_2304_AirPnt_IFF.Create(nil);
  FrmA_2304_AirPnt_Kinematics :=  TFrmA_2304_AirPnt_Kinematics.Create(nil);
  FrmA_2304_AirPnt_Trackmanagement :=  TFrmA_2304_AirPnt_Trackmanagement.Create(nil);
  FrmAAW_engagement :=  TFrmAAW_engagement.Create(nil);
  FrmAAW_WASA_auto :=  TFrmAAW_WASA_auto.Create(nil);
  FrmAAW_WASA_man :=  TFrmAAW_WASA_man.Create(nil);
  FrmAir_temperature :=  TFrmAir_temperature.Create(nil);
  FrmAssoc :=  TFrmAssoc.Create(nil);
  FrmAssociation_warning :=  TFrmAssociation_warning.Create(nil);
  FrmBarrometric_pressure :=  TFrmBarrometric_pressure.Create(nil);
  FrmBtm_File_Sel :=  TFrmBtm_File_Sel.Create(nil);
  FrmCol_avoid :=  TFrmCol_avoid.Create(nil);
  FrmComputer_meteo :=  TFrmComputer_meteo.Create(nil);
  FrmDepth :=  TFrmDepth.Create(nil);
  FrmDrift :=  TFrmDrift.Create(nil);
  FrmEMCON :=  TFrmEMCON.Create(nil);
  FrmEMCON_plan_editor :=  TFrmEMCON_plan_editor.Create(nil);
  FrmEMCON_warning :=  TFrmEMCON_warning.Create(nil);
  FrmEMCON_warning_hal103 :=  TFrmEMCON_warning_hal103.Create(nil);
  FrmEMCON_warning_hal116 :=  TFrmEMCON_warning_hal116.Create(nil);
  FrmEngagement_plan_results :=  TFrmEngagement_plan_results.Create(nil);
  FrmEvasive_action_warning_close :=  TFrmEvasive_action_warning_close.Create(nil);
  FrmEvasive_action_warning_torpedo :=  TFrmEvasive_action_warning_torpedo.Create(nil);
  FrmEXOCET_engagement :=  TFrmEXOCET_engagement.Create(nil);
  FrmEXOCET_monitoring_and_control :=  TFrmEXOCET_monitoring_and_control.Create(nil);
  FrmExtSensor :=  TFrmExtSensor.Create(nil);
  FrmFire_authorize :=  TFrmFire_authorize.Create(nil);
  FrmFOC :=  TFrmFOC.Create(nil);
  FrmGun_monitoring :=  TFrmGun_monitoring.Create(nil);
  FrmGun_settings :=  TFrmGun_settings.Create(nil);

  FrmHal39 :=  TFrmHal39.Create(nil);
  FrmHal40 :=  TFrmHal40.Create(nil);
  FrmHal61 :=  TFrmHal61.Create(nil);
  FrmHal109 :=  TFrmHal109.Create(nil);
  FrmHal110 :=  TFrmHal110.Create(nil);
  FrmHal123 :=  TFrmHal123.Create(nil);
  FrmHal147 :=  TFrmHal147.Create(nil);
  FrmHal148 :=  TFrmHal148.Create(nil);
  FrmHold_fire_report_def :=  TFrmHold_fire_report_def.Create(nil);
  FrmLinkY_AMS :=  TFrmLinkY_AMS.Create(nil);
  FrmLinkY_AMS_Rx :=  TFrmLinkY_AMS_Rx.Create(nil);
  FrmLinkY_AMS_Tx :=  TFrmLinkY_AMS_Tx.Create(nil);
  FrmLinkY_change_data_order :=  TFrmLinkY_change_data_order.Create(nil);
  FrmLinkY_command_Rx1 :=  TFrmLinkY_command_Rx1.Create(nil);
  FrmLinkY_command_Rx2 :=  TFrmLinkY_command_Rx2.Create(nil);
  FrmLinkY_command_Rx3 :=  TFrmLinkY_command_Rx3.Create(nil);
  FrmLinkY_command_Rx4 :=  TFrmLinkY_command_Rx4.Create(nil);
  FrmLinkY_command_Rx5 :=  TFrmLinkY_command_Rx5.Create(nil);
  FrmLinkY_command_Rx6 :=  TFrmLinkY_command_Rx6.Create(nil);
  FrmLinkY_command_Rx7 :=  TFrmLinkY_command_Rx7.Create(nil);
  FrmLinkY_command_Rx8 :=  TFrmLinkY_command_Rx8.Create(nil);
  FrmLinkY_command_Rx9 :=  TFrmLinkY_command_Rx9.Create(nil);
  FrmLinkY_command_Tx1 :=  TFrmLinkY_command_Tx1.Create(nil);
  FrmLinkY_command_Tx2 :=  TFrmLinkY_command_Tx2.Create(nil);
  FrmLinkY_command_Tx3 :=  TFrmLinkY_command_Tx3.Create(nil);
  FrmLinkY_encryption_keys :=  TFrmLinkY_encryption_keys.Create(nil);
  FrmLinkY_filters :=  TFrmLinkY_filters.Create(nil);
  FrmLinkY_force :=  TFrmLinkY_force.Create(nil);
  FrmLinkY_markers :=  TFrmLinkY_markers.Create(nil);
  FrmLinkY_monitoring_and_control :=  TFrmLinkY_monitoring_and_control.Create(nil);
  FrmLinkY_network_monitoring :=  TFrmLinkY_network_monitoring.Create(nil);
  FrmLinkY_slot_alloc :=  TFrmLinkY_slot_alloc.Create(nil);
  FrmLinkY_test :=  TFrmLinkY_test.Create(nil);
  FrmLinkY_warning_loss :=  TFrmLinkY_warning_loss.Create(nil);
  FrmLinkY_warning_NoNetwork :=  TFrmLinkY_warning_NoNetwork.Create(nil);
  FrmLinkY_warning_TNBlock :=  TFrmLinkY_warning_TNBlock.Create(nil);
  FrmLinkY_warning_TNBlockExceeded :=  TFrmLinkY_warning_TNBlockExceeded.Create(nil);
  FrmLinkY_warning_too :=  TFrmLinkY_warning_too.Create(nil);
  FrmLinkY_warning_track :=  TFrmLinkY_warning_track.Create(nil);
  FrmLinkY_Weapon_Doctrine_Rx :=  TFrmLinkY_Weapon_Doctrine_Rx.Create(nil);
  FrmLinkY_weapon_doctrine_Rx1 :=  TFrmLinkY_weapon_doctrine_Rx1.Create(nil);
  FrmLinkY_weapon_doctrine_tx :=  TFrmLinkY_weapon_doctrine_tx.Create(nil);
  FrmLIROD :=  TFrmLIROD.Create(nil);
  FrmLIROD_KBand :=  TFrmLIROD_KBand.Create(nil);
  FrmLIROD_video_selection :=  TFrmLIROD_video_selection.Create(nil);
  FrmLLOA_calculation :=  TFrmLLOA_calculation.Create(nil);
  FrmMagnetic_var :=  TFrmMagnetic_var.Create(nil);
  FrmMan_over_rec :=  TFrmMan_over_rec.Create(nil);
  FrmMK46_engagement :=  TFrmMK46_engagement.Create(nil);
  FrmMK46_engagement_HeliOrMPA :=  TFrmMK46_engagement_HeliOrMPA.Create(nil);
  FrmMK46_torpedo_launch :=  TFrmMK46_torpedo_launch.Create(nil);
  FrmMW08_AIA_air :=  TFrmMW08_AIA_air.Create(nil);
  FrmMW08_AIA_surface :=  TFrmMW08_AIA_surface.Create(nil);
  FrmMW08_AONI_air :=  TFrmMW08_AONI_air.Create(nil);
  FrmMW08_AONI_surface :=  TFrmMW08_AONI_surface.Create(nil);
  FrmMW08_monitoring_and_control :=  TFrmMW08_monitoring_and_control.Create(nil);

end;

destructor TTDC_Sigma.Destroy;
begin
//  FreeAndnil(FrmTactical_display_area);
  FreeAndNil(FrmA_2304_AirPnt);
  FreeAndNil(FrmA_2304_AirPnt_AirControl   );
  FreeAndNil(FrmA_2304_AirPnt_Datalinks );
  FreeAndNil(FrmA_2304_AirPnt_Description );
  FreeAndNil(FrmA_2304_AirPnt_IFF );
  FreeAndNil(FrmA_2304_AirPnt_Kinematics );
  FreeAndNil(FrmA_2304_AirPnt_Trackmanagement );
  FreeAndNil(FrmAAW_engagement);
  FreeAndNil(FrmAAW_WASA_auto );
  FreeAndNil(FrmAAW_WASA_man );
  FreeAndNil(FrmAir_temperature );
  FreeAndNil(FrmAssoc );
  FreeAndNil(FrmAssociation_warning );
  FreeAndNil(FrmBarrometric_pressure );
  FreeAndNil(FrmBtm_File_Sel );
  FreeAndNil(FrmCol_avoid );
  FreeAndNil(FrmComputer_meteo );
  FreeAndNil(FrmDepth);
  FreeAndNil(FrmDrift);
  FreeAndNil(FrmEMCON);
  FreeAndNil(FrmEMCON_plan_editor);
  FreeAndNil(FrmEMCON_warning);
  FreeAndNil(FrmEMCON_warning_hal103);
  FreeAndNil(FrmEMCON_warning_hal116);
  FreeAndNil(FrmEngagement_plan_results );
  FreeAndNil(FrmEvasive_action_warning_close );
  FreeAndNil(FrmEvasive_action_warning_torpedo );
  FreeAndNil(FrmEXOCET_engagement );
  FreeAndNil(FrmEXOCET_monitoring_and_control );
  FreeAndNil(FrmExtSensor );
  FreeAndNil(FrmFire_authorize );
  FreeAndNil(FrmFOC );
  FreeAndNil(FrmGun_monitoring );
  FreeAndNil(FrmGun_settings );

  FreeAndNil(FrmHal39);
  FreeAndNil(FrmHal40);
  FreeAndNil(FrmHal61);
  FreeAndNil(FrmHal109);
  FreeAndNil(FrmHal110);
  FreeAndNil(FrmHal123);
  FreeAndNil(FrmHal147);
  FreeAndNil(FrmHal148);
  FreeAndNil(FrmHold_fire_report_def);
  FreeAndNil(FrmLinkY_AMS);
  FreeAndNil(FrmLinkY_AMS_Rx);
  FreeAndNil(FrmLinkY_AMS_Tx);
  FreeAndNil(FrmLinkY_change_data_order);
  FreeAndNil(FrmLinkY_command_Rx1);
  FreeAndNil(FrmLinkY_command_Rx2);
  FreeAndNil(FrmLinkY_command_Rx3);
  FreeAndNil(FrmLinkY_command_Rx4);
  FreeAndNil(FrmLinkY_command_Rx5);
  FreeAndNil(FrmLinkY_command_Rx6);
  FreeAndNil(FrmLinkY_command_Rx7);
  FreeAndNil(FrmLinkY_command_Rx8);
  FreeAndNil(FrmLinkY_command_Rx9);
  FreeAndNil(FrmLinkY_command_Tx1);
  FreeAndNil(FrmLinkY_command_Tx2);
  FreeAndNil(FrmLinkY_command_Tx3);
  FreeAndNil(FrmLinkY_encryption_keys);
  FreeAndNil(FrmLinkY_filters);
  FreeAndNil(FrmLinkY_force);
  FreeAndNil(FrmLinkY_markers);
  FreeAndNil(FrmLinkY_monitoring_and_control);
  FreeAndNil(FrmLinkY_network_monitoring);
  FreeAndNil(FrmLinkY_slot_alloc);
  FreeAndNil(FrmLinkY_test);
  FreeAndNil(FrmLinkY_warning_loss);
  FreeAndNil(FrmLinkY_warning_NoNetwork);
  FreeAndNil(FrmLinkY_warning_TNBlock);
  FreeAndNil(FrmLinkY_warning_TNBlockExceeded);
  FreeAndNil(FrmLinkY_warning_too);
  FreeAndNil(FrmLinkY_warning_track);
  FreeAndNil(FrmLinkY_Weapon_Doctrine_Rx);
  FreeAndNil(FrmLinkY_weapon_doctrine_Rx1);
  FreeAndNil(FrmLinkY_weapon_doctrine_tx);
  FreeAndNil(FrmLIROD);
  FreeAndNil(FrmLIROD_KBand);
  FreeAndNil(FrmLIROD_video_selection);
  FreeAndNil(FrmLLOA_calculation);
  FreeAndNil(FrmMagnetic_var);
  FreeAndNil(FrmMan_over_rec);
  FreeAndNil(FrmMK46_engagement);
  FreeAndNil(FrmMK46_engagement_HeliOrMPA);
  FreeAndNil(FrmMK46_torpedo_launch);
  FreeAndNil(FrmMW08_AIA_air);
  FreeAndNil(FrmMW08_AIA_surface);
  FreeAndNil(FrmMW08_AONI_air);
  FreeAndNil(FrmMW08_AONI_surface);
  FreeAndNil(FrmMW08_monitoring_and_control);

  FreeAndNil(frmTengah);

  inherited;

end;

procedure TTDC_Sigma.ShowAllForm;
begin
  inherited;

  FrmA_2304_AirPnt.Show;
  FrmA_2304_AirPnt_AirControl   .Show;
  FrmA_2304_AirPnt_Datalinks .Show;
  FrmA_2304_AirPnt_Description .Show;
  FrmA_2304_AirPnt_IFF .Show;
  FrmA_2304_AirPnt_Kinematics .Show;
  FrmA_2304_AirPnt_Trackmanagement .Show;
  FrmAAW_engagement.Show;
  FrmAAW_WASA_auto .Show;
  FrmAAW_WASA_man .Show;
  FrmAir_temperature .Show;
  FrmAssoc .Show;
  FrmAssociation_warning .Show;
  FrmBarrometric_pressure .Show;
  FrmBtm_File_Sel .Show;
  FrmCol_avoid .Show;
  FrmComputer_meteo .Show;
  FrmDepth.Show;
  FrmDrift.Show;
  FrmEMCON.Show;
  FrmEMCON_plan_editor.Show;
  FrmEMCON_warning.Show;
  FrmEMCON_warning_hal103.Show;
  FrmEMCON_warning_hal116.Show;
  FrmEngagement_plan_results .Show;
  FrmEvasive_action_warning_close .Show;
  FrmEvasive_action_warning_torpedo .Show;
  FrmEXOCET_engagement .Show;
  FrmEXOCET_monitoring_and_control .Show;
  FrmExtSensor .Show;
  FrmFire_authorize .Show;
  FrmFOC .Show;
  FrmGun_monitoring .Show;
  FrmGun_settings .Show;

  FrmHal39.Show;
  FrmHal40.Show;
  FrmHal61.Show;
  FrmHal109.Show;
  FrmHal110.Show;
  FrmHal123.Show;
  FrmHal147.Show;
  FrmHal148.Show;
  FrmHold_fire_report_def.Show;
  FrmLinkY_AMS.Show;
  FrmLinkY_AMS_Rx.Show;
  FrmLinkY_AMS_Tx.Show;
  FrmLinkY_change_data_order.Show;
  FrmLinkY_command_Rx1.Show;
  FrmLinkY_command_Rx2.Show;
  FrmLinkY_command_Rx3.Show;
  FrmLinkY_command_Rx4.Show;
  FrmLinkY_command_Rx5.Show;
  FrmLinkY_command_Rx6.Show;
  FrmLinkY_command_Rx7.Show;
  FrmLinkY_command_Rx8.Show;
  FrmLinkY_command_Rx9.Show;
  FrmLinkY_command_Tx1.Show;
  FrmLinkY_command_Tx2.Show;
  FrmLinkY_command_Tx3.Show;
  FrmLinkY_encryption_keys.Show;
  FrmLinkY_filters.Show;
  FrmLinkY_force.Show;
  FrmLinkY_markers.Show;
  FrmLinkY_monitoring_and_control.Show;
  FrmLinkY_network_monitoring.Show;
  FrmLinkY_slot_alloc.Show;
  FrmLinkY_test.Show;
  FrmLinkY_warning_loss.Show;
  FrmLinkY_warning_NoNetwork.Show;
  FrmLinkY_warning_TNBlock.Show;
  FrmLinkY_warning_TNBlockExceeded.Show;
  FrmLinkY_warning_too.Show;
  FrmLinkY_warning_track.Show;
  FrmLinkY_Weapon_Doctrine_Rx.Show;
  FrmLinkY_weapon_doctrine_Rx1.Show;
  FrmLinkY_weapon_doctrine_tx.Show;
  FrmLIROD.Show;
  FrmLIROD_KBand.Show;
  FrmLIROD_video_selection.Show;
  FrmLLOA_calculation.Show;
  FrmMagnetic_var.Show;
  FrmMan_over_rec.Show;
  FrmMK46_engagement.Show;
  FrmMK46_engagement_HeliOrMPA.Show;
  FrmMK46_torpedo_launch.Show;
  FrmMW08_AIA_air.Show;
  FrmMW08_AIA_surface.Show;
  FrmMW08_AONI_air.Show;
  FrmMW08_AONI_surface.Show;
  FrmMW08_monitoring_and_control.Show;

end;

end.
