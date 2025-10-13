unit fPanelBawah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, Buttons, SpeedButtonImage, StdCtrls, ComCtrls,
  OleCtrls, MapXLib_TLB, jpeg, VrControls, VrWheel, VrRotarySwitch, Keyboard,
  pngimage{, Symbols}, uC802_Object, uEventForm, uTCPDatatype,
  uLibClientObject, TlHelp32;

type

  TRec_Target = record
    Number : Integer;
    Distance : Double;    // meter
    Azimuth : Double;
    Speed : Double;       // ms
    Course : Double;
    Mode : Integer;
    Longitude : Double;
    Latitude : Double;

    Mis_No : Integer;
    Hooming_Range : Integer;
    Self_Time : Double;
    Psiq, SitaZ, GamaZ : Double;
  end;

  TPanelBawah = class(TForm)
    il_orange: TImageList;
    PgCtrlMainMenu: TPageControl;
    TSStatus: TTabSheet;
    TSControl: TTabSheet;
    TSSetting: TTabSheet;
    TSRecordData: TTabSheet;
    TSLogOff: TTabSheet;
    Image1: TImage;
    pnlStatusPage: TPanel;
    btnPWRtoM_4: TSpeedButtonImage;
    btnPWRtoM_2: TSpeedButtonImage;
    btnCover_4: TSpeedButtonImage;
    btnCover_2: TSpeedButtonImage;
    btnArm_4: TSpeedButtonImage;
    btnLaunch_4: TSpeedButtonImage;
    btnLaunch_2: TSpeedButtonImage;
    btnCancel_4: TSpeedButtonImage;
    btnCancel_2: TSpeedButtonImage;
    il_Rotary: TImageList;
    il_Red: TImageList;
    btnSafe_4: TSpeedButtonImage;
    btnArm_2: TSpeedButtonImage;
    btnSafe_2: TSpeedButtonImage;
    btnArm_3: TSpeedButtonImage;
    btnArm_1: TSpeedButtonImage;
    btnCancel_3: TSpeedButtonImage;
    btnCancel_1: TSpeedButtonImage;
    btnCover_3: TSpeedButtonImage;
    btnCover_1: TSpeedButtonImage;
    btnLaunch_3: TSpeedButtonImage;
    btnLaunch_1: TSpeedButtonImage;
    btnPWRtoM_3: TSpeedButtonImage;
    btnPWRtoM_1: TSpeedButtonImage;
    btnSafe_3: TSpeedButtonImage;
    btnSafe_1: TSpeedButtonImage;
    btnDemist: TSpeedButtonImage;
    il_demist: TImageList;
    btnPower: TSpeedButtonImage;
    il_power: TImageList;
    btnMenu: TSpeedButtonImage;
    il_menu: TImageList;
    btnPlus: TSpeedButtonImage;
    btnMinus: TSpeedButtonImage;
    btnUp: TSpeedButtonImage;
    btnDown: TSpeedButtonImage;
    il_plus: TImageList;
    il_minus: TImageList;
    il_up: TImageList;
    il_down: TImageList;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    img6: TImage;
    img7: TImage;
    img8: TImage;
    img9: TImage;
    img10: TImage;
    img11: TImage;
    img12: TImage;
    img13: TImage;
    img14: TImage;
    vrtryswtchRigidCloseC_4: TVrRotarySwitch;
    vrtryswtchRigidCloseC_2: TVrRotarySwitch;
    stat1: TStatusBar;
    pnlStatusArea: TPanel;
    lbl80: TLabel;
    lbl81: TLabel;
    lbl82: TLabel;
    pnlPrecheck_MControl_Button: TPanel;
    pnlRecheck_MControl_Button: TPanel;
    pnlPowerOff_MControl_Button: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    grpFirePwr_Dist: TGroupBox;
    pnl6: TPanel;
    pnl7: TPanel;
    lbl83: TLabel;
    pnlFirePwr_Dist: TPanel;
    pnlAttack_Mode: TPanel;
    pnlTargetSet_1: TPanel;
    pnlTargetSet_2: TPanel;
    pnlGPS_para: TPanel;
    pnlMete_para: TPanel;
    pnlGyro_para: TPanel;
    pnlQuestions: TPanel;
    grpAttack_Mode: TGroupBox;
    lbl84: TLabel;
    pnl16: TPanel;
    pnl17: TPanel;
    grpTargetSet_1: TGroupBox;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl23: TPanel;
    pnl21: TPanel;
    pnl22: TPanel;
    pnl24: TPanel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    grpGPS_para: TGroupBox;
    lbl86: TLabel;
    pnl34: TPanel;
    pnl35: TPanel;
    pnl36: TPanel;
    pnl37: TPanel;
    pnl38: TPanel;
    pnl39: TPanel;
    grpTargetSet_2: TGroupBox;
    lbl85: TLabel;
    pnl28: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    pnl32: TPanel;
    pnl33: TPanel;
    grpMete_para: TGroupBox;
    lbl87: TLabel;
    pnl40: TPanel;
    pnl41: TPanel;
    pnl42: TPanel;
    pnl43: TPanel;
    pnl44: TPanel;
    pnl45: TPanel;
    pnl8: TPanel;
    flwpnl1: TFlowPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl48: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl46: TPanel;
    pnl47: TPanel;
    pnl49: TPanel;
    pnlInitState_4: TPanel;
    pnlInitState_2: TPanel;
    pnlInitState_1: TPanel;
    pnlInitState_3: TPanel;
    pnl54: TPanel;
    pnlLimiterOut_4: TPanel;
    pnlLimiterOut_2: TPanel;
    pnlLimiterOut_1: TPanel;
    pnlLimiterOut_3: TPanel;
    pnl59: TPanel;
    pnlPowerSupply_4: TPanel;
    pnlPowerSupply_2: TPanel;
    pnlPowerSupply_1: TPanel;
    pnlPowerSupply_3: TPanel;
    pnl64: TPanel;
    pnlRigidityStt_4: TPanel;
    pnlRigidityStt_2: TPanel;
    pnlRigidityStt_1: TPanel;
    pnlRigidityStt_3: TPanel;
    pnl69: TPanel;
    pnlTurnOnEquip_4: TPanel;
    pnlTurnOnEquip_2: TPanel;
    pnlTurnOnEquip_1: TPanel;
    pnlTurnOnEquip_3: TPanel;
    pnl74: TPanel;
    pnlFullOpen_4: TPanel;
    pnlFullOpen_2: TPanel;
    pnlFullOpen_1: TPanel;
    pnlFullOpen_3: TPanel;
    pnl79: TPanel;
    pnlCheckStage1_4: TPanel;
    pnlCheckStage1_2: TPanel;
    pnlCheckStage1_1: TPanel;
    pnlCheckStage1_3: TPanel;
    pnl84: TPanel;
    pnlBoosterArm_4: TPanel;
    pnlBoosterArm_2: TPanel;
    pnlBoosterArm_1: TPanel;
    pnlBoosterArm_3: TPanel;
    pnl89: TPanel;
    pnlAngleSet_4: TPanel;
    pnlAngleSet_2: TPanel;
    pnlAngleSet_1: TPanel;
    pnlAngleSet_3: TPanel;
    pnl94: TPanel;
    pnlLaunchReady_4: TPanel;
    pnlLaunchReady_2: TPanel;
    pnlLaunchReady_1: TPanel;
    pnlLaunchReady_3: TPanel;
    pnl99: TPanel;
    pnlCoCheck_4: TPanel;
    pnlCoCheck_2: TPanel;
    pnlCoCheck_1: TPanel;
    pnlCoCheck_3: TPanel;
    pnl104: TPanel;
    pnlLaunchButton_4: TPanel;
    pnlLaunchButton_2: TPanel;
    pnlLaunchButton_1: TPanel;
    pnlLaunchButton_3: TPanel;
    pnl109: TPanel;
    pnlTzkSetting_4: TPanel;
    pnlTzkSetting_2: TPanel;
    pnlTzkSetting_1: TPanel;
    pnlTzkSetting_3: TPanel;
    pnl114: TPanel;
    pnlBatteryAct_4: TPanel;
    pnlBatteryAct_2: TPanel;
    pnlBatteryAct_1: TPanel;
    pnlBatteryAct_3: TPanel;
    pnl119: TPanel;
    pnlCommandNo3_4: TPanel;
    pnlCommandNo3_2: TPanel;
    pnlCommandNo3_1: TPanel;
    pnlCommandNo3_3: TPanel;
    pnl124: TPanel;
    pnlPowerSwitch_4: TPanel;
    pnlPowerSwitch_2: TPanel;
    pnlPowerSwitch_1: TPanel;
    pnlPowerSwitch_3: TPanel;
    pnl129: TPanel;
    pnlMisNormal_4: TPanel;
    pnlMisNormal_2: TPanel;
    pnlMisNormal_1: TPanel;
    pnlMisNormal_3: TPanel;
    pnl134: TPanel;
    pnlGyroUncaged_4: TPanel;
    pnlGyroUncaged_2: TPanel;
    pnlGyroUncaged_1: TPanel;
    pnlGyroUncaged_3: TPanel;
    pnl139: TPanel;
    pnlAccurateCal_4: TPanel;
    pnlAccurateCal_2: TPanel;
    pnlAccurateCal_1: TPanel;
    pnlAccurateCal_3: TPanel;
    pnl144: TPanel;
    pnlIgnition_4: TPanel;
    pnlIgnition_2: TPanel;
    pnlIgnition_1: TPanel;
    pnlIgnition_3: TPanel;
    pnl149: TPanel;
    pnlInsideSectr_4: TPanel;
    pnlInsideSectr_2: TPanel;
    pnlInsideSectr_1: TPanel;
    pnlInsideSectr_3: TPanel;
    pnl154: TPanel;
    pnlTakeOff_4: TPanel;
    pnlTakeOff_2: TPanel;
    pnlTakeOff_1: TPanel;
    pnlTakeOff_3: TPanel;
    flwpnl2: TFlowPanel;
    pnl160: TPanel;
    pnl161: TPanel;
    pnl162: TPanel;
    pnl163: TPanel;
    pnl164: TPanel;
    pnl165: TPanel;
    pnlTgtNo_1: TPanel;
    pnlDis_1: TPanel;
    pnlAzm_1: TPanel;
    pnlSpd_1: TPanel;
    pnlCou_1: TPanel;
    pnlMode_1: TPanel;
    pnlTgtNo_2: TPanel;
    pnlDis_2: TPanel;
    pnlAzm_2: TPanel;
    pnlSpd_2: TPanel;
    pnlCou_2: TPanel;
    pnlMode_2: TPanel;
    pnl178: TPanel;
    pnl179: TPanel;
    pnl180: TPanel;
    pnl181: TPanel;
    pnl182: TPanel;
    pnlOwnHdg: TPanel;
    pnlPitch: TPanel;
    pnlRoll: TPanel;
    pnlLongtitude: TPanel;
    pnlLatitude: TPanel;
    pnl183: TPanel;
    pnl189: TPanel;
    pnl190: TPanel;
    pnl191: TPanel;
    pnl192: TPanel;
    pnl193: TPanel;
    pnlOwnSpd: TPanel;
    pnlWndSpd: TPanel;
    pnlWindDir: TPanel;
    pnlTemp: TPanel;
    pnl198: TPanel;
    pnl199: TPanel;
    pnl200: TPanel;
    pnl201: TPanel;
    pnl202: TPanel;
    pnl203: TPanel;
    pnl204: TPanel;
    pnl205: TPanel;
    pnlM_No_1: TPanel;
    pnlRzd_1: TPanel;
    pnlTzk_1: TPanel;
    pnlPsiq_1: TPanel;
    pnlSitaZ_1: TPanel;
    pnlGamaZ_1: TPanel;
    pnlM_No_2: TPanel;
    pnlRzd_2: TPanel;
    pnlTzk_2: TPanel;
    pnlPsiq_2: TPanel;
    pnlSitaZ_2: TPanel;
    pnlGamaZ_2: TPanel;
    pnl50: TPanel;
    flwpnl3: TFlowPanel;
    pnlLabel_MisState_2: TPanel;
    pnlLabel_MisStep_2: TPanel;
    pnlLaunchStep_2_AccurateCal: TPanel;
    img15: TImage;
    pnlLaunchStep_2_InsideSector: TPanel;
    img16: TImage;
    pnlLaunchStep_2_LimiterOut: TPanel;
    img17: TImage;
    pnlLaunchStep_2_RigidityStt: TPanel;
    img18: TImage;
    pnlLaunchStep_2_FullOpen: TPanel;
    img19: TImage;
    pnlLaunchStep_2_BoosterArm: TPanel;
    img20: TImage;
    pnlLaunchStep_2_LaunchButton: TPanel;
    img21: TImage;
    pnlLaunchStep_2_BatteryAct: TPanel;
    img22: TImage;
    pnlLaunchStep_2_PowerSwitch: TPanel;
    img23: TImage;
    pnlLaunchStep_2_GyroUncage: TPanel;
    img24: TImage;
    pnlLaunchStep_2_Ignition: TPanel;
    img25: TImage;
    pnlLaunchStep_2_TakeOff: TPanel;
    img26: TImage;
    flwpnlM_No1: TFlowPanel;
    pnlLabel_MisState_1: TPanel;
    pnlLabel_MisStep_1: TPanel;
    pnlLaunchStep_1_AccurateCal: TPanel;
    img27: TImage;
    pnlLaunchStep_1_InsideSector: TPanel;
    img28: TImage;
    pnlLaunchStep_1_LimiterOut: TPanel;
    img29: TImage;
    pnlLaunchStep_1_RigidityStt: TPanel;
    img30: TImage;
    pnlLaunchStep_1_FullOpen: TPanel;
    img31: TImage;
    pnlLaunchStep_1_BoosterArm: TPanel;
    img32: TImage;
    pnlLaunchStep_1_LaunchButton: TPanel;
    img33: TImage;
    pnlLaunchStep_1_BatteryAct: TPanel;
    img34: TImage;
    pnlLaunchStep_1_PowerSwitch: TPanel;
    img35: TImage;
    pnlLaunchStep_1_GyroUncage: TPanel;
    img36: TImage;
    pnlLaunchStep_1_Ignition: TPanel;
    img37: TImage;
    pnlLaunchStep_1_TakeOff: TPanel;
    img38: TImage;
    flwpnlM_No4: TFlowPanel;
    pnlLabel_MisState_4: TPanel;
    pnlLabel_MisStep_4: TPanel;
    pnlLaunchStep_4_AccurateCal: TPanel;
    img39: TImage;
    pnlLaunchStep_4_InsideSector: TPanel;
    img40: TImage;
    pnlLaunchStep_4_LimiterOut: TPanel;
    img41: TImage;
    pnlLaunchStep_4_RigidityStt: TPanel;
    img42: TImage;
    pnlLaunchStep_4_FullOpen: TPanel;
    img43: TImage;
    pnlLaunchStep_4_BoosterArm: TPanel;
    img44: TImage;
    pnlLaunchStep_4_LaunchButton: TPanel;
    img45: TImage;
    pnlLaunchStep_4_BatteryAct: TPanel;
    img46: TImage;
    pnlLaunchStep_4_PowerSwitch: TPanel;
    img47: TImage;
    pnlLaunchStep_4_GyroUncage: TPanel;
    img48: TImage;
    pnlLaunchStep_4_Ignition: TPanel;
    img49: TImage;
    pnlLaunchStep_4_TakeOff: TPanel;
    img50: TImage;
    flwpnlM_No3: TFlowPanel;
    pnlLabel_MisState_3: TPanel;
    pnlLabel_MisStep_3: TPanel;
    pnlLaunchStep_3_AccurateCal: TPanel;
    img51: TImage;
    pnlLaunchStep_3_InsideSector: TPanel;
    img52: TImage;
    pnlLaunchStep_3_LimiterOut: TPanel;
    img53: TImage;
    pnlLaunchStep_3_RigidityStt: TPanel;
    img54: TImage;
    pnlLaunchStep_3_FullOpen: TPanel;
    img55: TImage;
    pnlLaunchStep_3_BoosterArm: TPanel;
    img56: TImage;
    pnlLaunchStep_3_LaunchButton: TPanel;
    img57: TImage;
    pnlLaunchStep_3_BatteryAct: TPanel;
    img58: TImage;
    pnlLaunchStep_3_PowerSwitch: TPanel;
    img59: TImage;
    pnlLaunchStep_3_GyroUncage: TPanel;
    img60: TImage;
    pnlLaunchStep_3_Ignition: TPanel;
    img61: TImage;
    pnlLaunchStep_3_TakeOff: TPanel;
    img62: TImage;
    flwpnlRecordData: TFlowPanel;
    pnl121: TPanel;
    pnlRecordData_No: TPanel;
    pnl123: TPanel;
    pnl125: TPanel;
    pnlRecDataNo: TPanel;
    pnl127: TPanel;
    pnlRecDataTime: TPanel;
    pnl130: TPanel;
    pnlRecDataTgtNo: TPanel;
    pnl132: TPanel;
    pnlRecDataLong: TPanel;
    pnl135: TPanel;
    pnlRecDataDis: TPanel;
    pnl137: TPanel;
    pnlRecDataLat: TPanel;
    pnl140: TPanel;
    pnlRecDataAzm: TPanel;
    pnl142: TPanel;
    pnlRecDataOwnSpd: TPanel;
    pnl145: TPanel;
    pnlRecDataSpd: TPanel;
    pnl147: TPanel;
    pnlRecDataOwnHdg: TPanel;
    pnl150: TPanel;
    pnlRecDataCou: TPanel;
    pnl152: TPanel;
    pnlRecDataPitch: TPanel;
    pnl155: TPanel;
    pnlRecDataRzd: TPanel;
    pnl157: TPanel;
    pnlRecDataRoll: TPanel;
    pnl159: TPanel;
    pnlRecDataTzk: TPanel;
    pnl219: TPanel;
    pnlRecDataTzkFB: TPanel;
    pnl221: TPanel;
    pnlRecDataPsiq: TPanel;
    pnl223: TPanel;
    pnlRecDataWndSpd: TPanel;
    pnl225: TPanel;
    pnlRecDataSitaZ: TPanel;
    pnl227: TPanel;
    pnlRecDataWndDir: TPanel;
    pnl229: TPanel;
    pnlRecDataGamaZ: TPanel;
    pnl231: TPanel;
    pnlRecDataTemp: TPanel;
    pnlPrecheck_MControl: TPanel;
    lbl79: TLabel;
    pnlRecheck_MControl: TPanel;
    pnlPowerOff_MControl: TPanel;
    lbl19: TLabel;
    pnlMete_para_WindSpd: TPanel;
    pnlMete_para_WindDir: TPanel;
    pnlMete_para_Temp: TPanel;
    pnlAttack_Mode_Tgt1: TPanel;
    pnlAttack_Mode_Tgt2: TPanel;
    pnlFirePwr_Dist_Target1: TPanel;
    pnlFirePwr_Dist_Target2: TPanel;
    pnlGPS_para_OwnLong: TPanel;
    pnlGPS_para_OwnLat: TPanel;
    pnlGPS_para_OwnSpd: TPanel;
    pnlTargetSet_1_Number: TPanel;
    pnlTargetSet_1_Distance: TPanel;
    pnlTargetSet_1_Azimuth: TPanel;
    pnlTargetSet_1_Speed: TPanel;
    pnlTargetSet_1_Course: TPanel;
    pnlTargetSet_2_Number: TPanel;
    pnlTargetSet_2_Long: TPanel;
    pnlTargetSet_2_Lat: TPanel;
    tmrPrelaunchCheck_1: TTimer;
    grpStartPage: TGroupBox;
    pnl75: TPanel;
    pnl76: TPanel;
    pnlCombat: TPanel;
    pnl78: TPanel;
    stat2: TStatusBar;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    spl1: TSplitter;
    lbl28: TLabel;
    pnlSimulate: TPanel;
    pnlCheck: TPanel;
    pnlMainMenu: TPanel;
    grpGyro_para: TGroupBox;
    lbl29: TLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl51: TPanel;
    pnl52: TPanel;
    pnl53: TPanel;
    pnlGyro_para_OwnHdg: TPanel;
    pnlGyro_para_Pitch: TPanel;
    pnlGyro_para_Roll: TPanel;
    grpQuestion: TGroupBox;
    lbl30: TLabel;
    pnl55: TPanel;
    pnlQuestion_No: TPanel;
    vrtryswtchRigidCloseC_3: TVrRotarySwitch;
    vrtryswtchRigidCloseC_1: TVrRotarySwitch;
    img63: TImage;
    MapC802: TMap;
    tmrPrelaunchCheck_2: TTimer;
    grpCheckPage: TGroupBox;
    pnl56: TPanel;
    spl2: TSplitter;
    lbl31: TLabel;
    pnl57: TPanel;
    pnlCheckPg_Intf: TPanel;
    pnl60: TPanel;
    lblNameCheckPg: TLabel;
    lbl35: TLabel;
    lblContainCheckPg: TLabel;
    lbl39: TLabel;
    stat3: TStatusBar;
    pnlCheckPg_No1: TPanel;
    pnlCheckPg_No4: TPanel;
    pnlCheckPg_Stab: TPanel;
    pnlCheckPg_Port: TPanel;
    pnlCheckPg_No2: TPanel;
    pnlCheckPg_No3: TPanel;
    tmrCheckPage: TTimer;
    tmrPrelaunchCheck_3: TTimer;
    tmrPrelaunchCheck_4: TTimer;
    pnlHIDE: TPanel;
    btn_ENTER: TButton;
    btnFIRE: TButton;
    btnEXIT: TButton;
    il_orange_dis: TImageList;
    tmrLaunch: TTimer;
    pnlVisibleExit: TPanel;
    tmr1: TTimer;
    tmr2: TTimer;
    tmr3: TTimer;
    tmr4: TTimer;

    procedure ParSetting_behav;
    procedure LaunchStep_SetOn(indicator: TPanel);
    procedure LaunchStep_SetOff(indicator: TPanel);
    procedure LaunchStep_SetFailed(indicator: TPanel);
    procedure PrelaunchCheckOn(indicator: TPanel);
    procedure PrelaunchCheckOff(indicator: TPanel);
    procedure PrelaunchCheckFailed(indicator: TPanel);
    procedure LaunchReady_On(mis_num: Integer);
    procedure LaunchReady_Off(mis_num: Integer);
    procedure UpButton;
    procedure DownButton;
    procedure EnterButton;
    procedure PanelUp(panel: TPanel);
    procedure PanelDown(panel: TPanel);
    procedure PanelEditOn(panel: TPanel);
    procedure PanelEditOff(panel: TPanel);
    procedure InputNumber(num : String);
    procedure UpdatePosition;

    procedure btnSafe_2Click(Sender: TObject);
    procedure btnArm_2Click(Sender: TObject);
    procedure tmrPrelaunchCheck_1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPWRtoM_4Click(Sender: TObject);
    procedure btnPWRtoM_2Click(Sender: TObject);
    procedure btnPWRtoM_1Click(Sender: TObject);
    procedure btnPWRtoM_3Click(Sender: TObject);
    procedure btnPowerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFIREClick(Sender: TObject);
    procedure vrtryswtchRigidCloseC_4Change(Sender: TObject);
    procedure vrtryswtchRigidCloseC_2Change(Sender: TObject);
    procedure vrtryswtchRigidCloseC_1Change(Sender: TObject);
    procedure vrtryswtchRigidCloseC_3Change(Sender: TObject);
    procedure btnCover_4Click(Sender: TObject);
    procedure btnCover_2Click(Sender: TObject);
    procedure btnCover_1Click(Sender: TObject);
    procedure btnCover_3Click(Sender: TObject);
    procedure tmrPrelaunchCheck_2Timer(Sender: TObject);
    procedure MapC802DrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Cardinal; const RectFull,
      RectInvalid: IDispatch);
    procedure btnCancel_4Click(Sender: TObject);
    procedure tmrCheckPageTimer(Sender: TObject);
    procedure tmrPrelaunchCheck_3Timer(Sender: TObject);
    procedure tmrPrelaunchCheck_4Timer(Sender: TObject);
    procedure btnArm_4Click(Sender: TObject);
    procedure btnSafe_4Click(Sender: TObject);
    procedure btnArm_1Click(Sender: TObject);
    procedure btnArm_3Click(Sender: TObject);
    procedure btnSafe_1Click(Sender: TObject);
    procedure btnSafe_3Click(Sender: TObject);
    procedure btnCancel_1Click(Sender: TObject);
    procedure btnCancel_3Click(Sender: TObject);
    procedure btnCancel_2Click(Sender: TObject);
    procedure btn_ENTERClick(Sender: TObject);
    procedure btnEXITClick(Sender: TObject);
    procedure btnLaunch_1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrLaunchTimer(Sender: TObject);
    procedure btnLaunch_1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlVisibleExitDblClick(Sender: TObject);
    procedure btnLaunch_1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Open_cover1, Open_cover2, Open_cover3, Open_cover4: Boolean;

    long_tgt2, lat_tgt2: Double;

    Target1, Target2 : TRec_Target;

    LaunchTimer: Integer;
    LaunchMisNo: Integer;

    isNormal1, isNormal2, isNormal3, isNormal4 : Boolean;
    isLaunched1, isLaunched2, isLaunched3, isLaunched4: Boolean;

    function CloseCurrentHandleApplication(ExeFileName: string): Integer;
    procedure Mis_OnLaunch(mis_num: Integer);

  public
    { Public declarations }
    Prelaunch_count1, Prelaunch_count2, Prelaunch_count3, Prelaunch_count4: Integer;
    CheckPage_counter: Integer;
    ActivePage : Integer;
    ActivePanel : TPanel;
    FCanvas  : TCanvas;
    EventForm : TEventForm;
    ownHeading : Double;

    {SIMULATION TARGET}
    SimTarget1Draw : TClientObject;
    {Instruktur Target}
    ListAssignedObjects : array[0..1] of TClientObject;
    FAssignedTargetIns1 : TClientObject;
    FAssignedTargetIns2 : TClientObject;

    StartMode_array : array[0..2] of TPanel;
    StartMode_index: Integer; {mode COMBAT/SIMULATION/CHECK}

    MControl_array : array[0..2,0..1] of TPanel;
    MControl_index: Integer;

    ParSetting_array: array[0..7,0..1] of TCustomControl;
    ParSetting_index: Integer;
    ParSet_Menu_array: array of TPanel;
    ParSet_Menu_index: Integer;

    CheckPage_array: array[0..6] of TCustomControl;
    CheckPage_index: Integer;

    Data802 : TC802_Object; {untuk simulasi}
    Rec_data: TRecData_C802;

    Launcher1OnFromInstruktur,
    Launcher2OnFromInstruktur,
    Launcher3OnFromInstruktur,
    Launcher4OnFromInstruktur  : Boolean;

    procedure UpdateTargetAssign1;
    procedure UpdateTargetAssign2;
    procedure CreateSimulationObject;
    procedure CalculateSimPos;
    function GetAssignedTargetIns1 : TClientObject;
    function GetAssignedTargetIns2 : TClientObject;

    property AssignedTargetIns1 : TClientObject read GetAssignedTargetIns1;
    property AssignedTargetIns2 : TClientObject read GetAssignedTargetIns2;
  end;

  const
    PAGE_START  = 1;
    PAGE_STATUS = 2;
    PAGE_MCONTROL = 3;
    PAGE_PARSETTING = 4;
    PAGE_PARSETTING_FIREPWR = 41;
    PAGE_PARSETTING_ATTACK  = 42;
    PAGE_PARSETTING_TGTSET1 = 43;
    PAGE_PARSETTING_TGTSET2 = 44;
    PAGE_PARSETTING_GPSPARA = 45;
    PAGE_PARSETTING_METEPARA = 46;
    PAGE_PARSETTING_GYROPARA = 47;
    PAGE_PARSETTING_QUEST   = 48;
    PAGE_RECORDDATA = 5;
    PAGE_LOGOFF = 6;
    PAGE_CHECK = 7;

    BOOSTER_ARM = 1;
    BOOSTER_SAFE = 2;

//    tmr_START         = 0;
//    tmr_INIT_STATE    = 20;
//    tmr_POWER_SUPPLY  = 40;
//    tmr_TURNON_EQUIP  = 60;
//    tmr_CHECK_STAGE_1 = 80;
//    tmr_ANGLE_SET     = 100;
//    tmr_COCHECK       = 120;
//    tmr_TZK_SETTING   = 140;
//    tmr_COMMAND_NO_3  = 160;
//    tmr_MIS_NORMAL    = 180;
//    tmr_ACC_CALC      = 190;
//    tmr_INSIDE_SECT   = 200;
//    tmr_LIMITER_OUT   = 201;
//    tmr_RIG_STT       = 202;
//    tmr_FULL_OPEN     = 210;
//    tmr_BOOSTER_ARM   = 211;
//    tmr_LAUNCH_READY  = 212;
//    tmr_LAUNCH_BUTT   = 215;
//    tmr_BATT_ACT      = 218;
//    tmr_POWER_SWITCH  = 221;
//    tmr_GYRO_UNCAGED  = 224;
//    tmr_IGNITION      = 227;
//    tmr_TAKE_OFF      = 230;


    tmr_START         = 0;
    tmr_INIT_STATE    = 5;
    tmr_POWER_SUPPLY  = 10;
    tmr_TURNON_EQUIP  = 15;
    tmr_CHECK_STAGE_1 = 20;
    tmr_ANGLE_SET     = 25;
    tmr_COCHECK       = 30;
    tmr_TZK_SETTING   = 35;
    tmr_COMMAND_NO_3  = 40;
    tmr_MIS_NORMAL    = 45;
    tmr_ACC_CALC      = 47;
    tmr_INSIDE_SECT   = 49;
    tmr_LIMITER_OUT   = 51;
    tmr_RIG_STT       = 53;
    tmr_FULL_OPEN     = 55;
    tmr_BOOSTER_ARM   = 57;
    tmr_LAUNCH_READY  = 59;
    tmr_LAUNCH_BUTT   = 62;
    tmr_BATT_ACT      = 64;
    tmr_POWER_SWITCH  = 66;
    tmr_GYRO_UNCAGED  = 68;
    tmr_IGNITION      = 70;
    tmr_TAKE_OFF      = 72;

var
  PanelBawah: TPanelBawah;

implementation

uses
  uC802Manager, fPanelAtas, uTrackFunction, uBaseConstan, uBaseFunction,
  uBaseSimulationObject, uBaseDataType, Math;

{$R *.dfm}

procedure TPanelBawah.UpdatePosition;
var
  I: Integer;
  client_obj: TClientObject;
begin
  {set Own Information}
  pnlOwnHdg.Caption := FormatFloat('0.00',C802Manager.xShip.Heading);
  pnlPitch.Caption  := FormatFloat('0.00',C802Manager.xShip.Pitch);
  pnlRoll.Caption   := FormatFloat('0.00',C802Manager.xShip.Roll);
//  pnlLongtitude.Caption  := FormatFloat('0.00',C802Manager.xShip.PositionX);{formatDMS_long(C802Manager.xShip.PositionX);}
//  pnlLatitude.Caption    := FormatFloat('0.00',C802Manager.xShip.PositionY);{formatDMS_lat(C802Manager.xShip.PositionY);}
  pnlGPS_para_OwnLong.Font.Color := clWhite;
  pnlGPS_para_OwnLat.Font.Color := clWhite;
  pnlGPS_para_OwnSpd.Font.Color := clWhite;
  pnlGPS_para_OwnLong.Caption := FormatFloat('0.00',C802Manager.xShip.PositionX);
  pnlGPS_para_OwnLat.Caption := FormatFloat('0.00',C802Manager.xShip.PositionY);
  pnlGPS_para_OwnSpd.Caption := FormatFloat('0.00',C802Manager.xShip.Speed);
  pnlLongtitude.Caption := FormatFloat('0.00000',C802Manager.xShip.PositionX);
  pnlLatitude.Caption := FormatFloat('0.00000',C802Manager.xShip.PositionY);

  pnlOwnSpd.Caption := FormatFloat('0.00',C802Manager.xShip.Speed);

//  for I := 0 to C802Manager.MainObjList.ItemCount - 1 do
//  begin
//    client_obj := C802Manager.MainObjList.getObject(I) as TClientObject;
//    {case I of
//      0:
//        begin
//          pnlTgtNo_1.Caption  := '2001';
//          pnlSpd_1.Caption    := FormatFloat('0.00',client_obj.Speed);
//          pnlCou_1.Caption    := FormatFloat('0.00',client_obj.Heading);
//        end;
//      1:
//        begin
//          pnlTgtNo_2.Caption  := '2002';
//          pnlSpd_2.Caption    := FormatFloat('0.00',client_obj.Speed);
//          pnlCou_2.Caption    := FormatFloat('0.00',client_obj.Heading);
//        end;
//    end; }
//  end;

  // update environment
  if C802Manager.Wind_Spd <> 0 then
  begin
    pnlWndSpd.Caption := FloatToStr(C802Manager.Wind_Spd);
    pnlMete_para_WindSpd.Caption := FloatToStr(C802Manager.Wind_Spd);
  end;

  if C802Manager.Wind_Dir <> 0 then
  begin
    pnlWindDir.Caption := FloatToStr(C802Manager.Wind_Dir);
    pnlMete_para_WindDir.Caption := FloatToStr(C802Manager.Wind_Dir);
  end;

  if C802Manager.Temp <> 0 then
  begin
    pnlTemp.Caption := FloatToStr(C802Manager.Temp);
    pnlMete_para_Temp.Caption := FloatToStr(C802Manager.Temp);
  end;

end;

procedure TPanelBawah.LaunchReady_On(mis_num: Integer);
begin
  with C802Manager do begin
    case mis_num of
      1:
        begin
          if (pnlAccurateCal_1.Caption = 'Y') and (pnlInsideSectr_1.Caption = 'Y') and (pnlLimiterOut_1.Caption = 'Y') and
          (pnlFullOpen_1.Caption = 'Y') and (pnlBoosterArm_1.Caption = 'Y') then
          begin
            {standalone}
            C802Manager.Missile1.FLaunchReady := True;
            Prelaunch_count1  := tmr_BOOSTER_ARM;
            tmrPrelaunchCheck_1.Enabled := True;
          end;
          if (pnlAccurateCal_1.Caption = '') and (pnlInsideSectr_1.Caption = '') and (pnlLimiterOut_1.Caption = '') and
          (pnlFullOpen_1.Caption = '') and (pnlBoosterArm_1.Caption = '') then
          begin
            C802Manager.Missile1.FLaunchReady := False;
          end;
          if (pnlAccurateCal_1.Caption = 'N') or (pnlInsideSectr_1.Caption = 'N') or (pnlLimiterOut_1.Caption = 'N') or
            (pnlFullOpen_1.Caption = 'N') or (pnlBoosterArm_1.Caption = 'N') then
          begin
            {standalone}
            C802Manager.Missile1.FLaunchReady := False;
//            Prelaunch_count1  := tmr_BOOSTER_ARM;
//            tmrPrelaunchCheck_1.Enabled := True;
          end;
        end;
      2:
        begin
          if (pnlAccurateCal_2.Caption = 'Y') and (pnlInsideSectr_2.Caption = 'Y') and (pnlLimiterOut_2.Caption = 'Y') and
          (pnlFullOpen_2.Caption = 'Y') and (pnlBoosterArm_2.Caption = 'Y')then
          begin
            {standalone}
            C802Manager.Missile2.FLaunchReady := True;
            Prelaunch_count1  := tmr_BOOSTER_ARM;
            tmrPrelaunchCheck_2.Enabled := True;
          end;
          if (pnlAccurateCal_2.Caption = '') and (pnlInsideSectr_2.Caption = '') and (pnlLimiterOut_2.Caption = '') and
          (pnlFullOpen_2.Caption = '') and (pnlBoosterArm_2.Caption = '') then
          begin
            C802Manager.Missile2.FLaunchReady := False;
          end;
          if (pnlAccurateCal_2.Caption = 'N') or (pnlInsideSectr_2.Caption = 'N') or (pnlLimiterOut_2.Caption = 'N') or
            (pnlFullOpen_2.Caption = 'N') or (pnlBoosterArm_2.Caption = 'N') then
          begin
            {standalone}
            C802Manager.Missile2.FLaunchReady := False;
//            Prelaunch_count2  := tmr_BOOSTER_ARM;
//            tmrPrelaunchCheck_2.Enabled := True;
          end;
        end;
      3:
        begin
          if (pnlAccurateCal_3.Caption = 'Y') and (pnlInsideSectr_3.Caption = 'Y') and (pnlLimiterOut_3.Caption = 'Y') and
          (pnlFullOpen_3.Caption = 'Y') and (pnlBoosterArm_3.Caption = 'Y') then
          begin
            {standalone}
            C802Manager.Missile3.FLaunchReady := True;
            Prelaunch_count1  := tmr_BOOSTER_ARM;
            tmrPrelaunchCheck_3.Enabled := True;
          end;
          if (pnlAccurateCal_3.Caption = '') and (pnlInsideSectr_3.Caption = '') and (pnlLimiterOut_3.Caption = '') and
          (pnlFullOpen_3.Caption = '') and (pnlBoosterArm_3.Caption = '') then
          begin
            C802Manager.Missile3.FLaunchReady := False;
          end;
          if (pnlAccurateCal_3.Caption = 'N') or (pnlInsideSectr_3.Caption = 'N') or (pnlLimiterOut_3.Caption = 'N') or
          (pnlFullOpen_3.Caption = 'N') or (pnlBoosterArm_3.Caption = 'N') then
          begin
            {standalone}
            C802Manager.Missile3.FLaunchReady := False;
//            Prelaunch_count3  := tmr_BOOSTER_ARM;
//            tmrPrelaunchCheck_3.Enabled := True;
          end;
        end;
      4:
        begin
          if (pnlAccurateCal_4.Caption = 'Y') and (pnlInsideSectr_4.Caption = 'Y') and (pnlLimiterOut_4.Caption = 'Y') and
          (pnlFullOpen_4.Caption = 'Y') and (pnlBoosterArm_4.Caption = 'Y') then
          begin
            {standalone}
            C802Manager.Missile4.FLaunchReady := True;
            Prelaunch_count1  := tmr_BOOSTER_ARM;
            tmrPrelaunchCheck_4.Enabled := True;
          end;
          if (pnlAccurateCal_4.Caption = '') and (pnlInsideSectr_4.Caption = '') and (pnlLimiterOut_4.Caption = '') and
          (pnlFullOpen_4.Caption = '') and (pnlBoosterArm_4.Caption = '') then
          begin
            C802Manager.Missile4.FLaunchReady := False;
          end;
          if (pnlAccurateCal_4.Caption = 'N') or (pnlInsideSectr_4.Caption = 'N') or (pnlLimiterOut_4.Caption = 'N') or
            (pnlFullOpen_4.Caption = 'N') or (pnlBoosterArm_4.Caption = 'N') then
          begin
            {standalone}
            C802Manager.Missile4.FLaunchReady := False;
//            Prelaunch_count4  := tmr_BOOSTER_ARM;
//            tmrPrelaunchCheck_4.Enabled := True;
          end;
        end;
    end;
  end;

end;

procedure TPanelBawah.LaunchReady_Off(mis_num: Integer);
begin
  with C802Manager do begin
    case mis_num of
      1:
        if not Missile1.FAccurateCal or not Missile1.FInsideSectr or not Missile1.FLimiterOut or
        not Missile1.FFullOpen or not Missile1.FBoosterArm then
        begin
          {standalone}
          C802Manager.Missile1.FLaunchReady := False;
          Prelaunch_count1  := tmr_BOOSTER_ARM;
          tmrPrelaunchCheck_1.Enabled := True;
        end;
      2:
        if not Missile2.FAccurateCal or not Missile2.FInsideSectr or not Missile2.FLimiterOut or
        not Missile2.FFullOpen or not Missile2.FBoosterArm then
        begin
          {standalone}
          C802Manager.Missile2.FLaunchReady := False;
          Prelaunch_count1  := tmr_BOOSTER_ARM;
          tmrPrelaunchCheck_2.Enabled := True;
        end;
      3:
        if not Missile3.FAccurateCal or not Missile3.FInsideSectr or not Missile3.FLimiterOut or
        not Missile3.FFullOpen or not Missile3.FBoosterArm then
        begin
          {standalone}
          C802Manager.Missile3.FLaunchReady := False;
          Prelaunch_count1  := tmr_BOOSTER_ARM;
          tmrPrelaunchCheck_3.Enabled := True;
        end;
      4:
        if not Missile4.FAccurateCal or not Missile4.FInsideSectr or not Missile4.FLimiterOut or
        not Missile4.FFullOpen or not Missile4.FBoosterArm then
        begin
          {standalone}
          C802Manager.Missile4.FLaunchReady := False;
          Prelaunch_count1  := tmr_BOOSTER_ARM;
          tmrPrelaunchCheck_4.Enabled := True;
        end;
    end;
  end;

end;

procedure TPanelBawah.InputNumber(num : String);
begin
  ActivePanel.Caption := ActivePanel.Caption + num;
end;

procedure TPanelBawah.btnArm_1Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile1.FBoosterState = BOOSTER_SAFE) and PanelAtas.isOn and not tmrPrelaunchCheck_1.Enabled then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah ON.bmp');
    btnArm_1.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau.bmp');
    btnSafe_1.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile1.FBoosterState := BOOSTER_ARM;
//    C802Manager.Missile1.FBoosterArm  := True;

    Prelaunch_count1 := tmr_FULL_OPEN;
    tmrPrelaunchCheck_1.Enabled := True;
    C802Manager.SendEvenC802(49,0,0,0);
  end;
end;

procedure TPanelBawah.btnArm_2Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile2.FBoosterState = BOOSTER_SAFE) and PanelAtas.isOn and not tmrPrelaunchCheck_2.Enabled then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah ON.bmp');
    btnArm_2.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau.bmp');
    btnSafe_2.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile2.FBoosterState := BOOSTER_ARM;
//    C802Manager.Missile2.FBoosterArm  := True;

    Prelaunch_count2 := tmr_FULL_OPEN;
    tmrPrelaunchCheck_2.Enabled := True;
    C802Manager.SendEvenC802(50,0,0,0);
  end;
end;

procedure TPanelBawah.btnArm_3Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile3.FBoosterState = BOOSTER_SAFE) and PanelAtas.isOn and not tmrPrelaunchCheck_3.Enabled then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah ON.bmp');
    btnArm_3.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau.bmp');
    btnSafe_3.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile3.FBoosterState := BOOSTER_ARM;
//    C802Manager.Missile3.FBoosterArm  := True;

    Prelaunch_count3 := tmr_FULL_OPEN;
    tmrPrelaunchCheck_3.Enabled := True;
    C802Manager.SendEvenC802(51,0,0,0);
  end;
end;

procedure TPanelBawah.btnArm_4Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile4.FBoosterState = BOOSTER_SAFE) and PanelAtas.isOn and not tmrPrelaunchCheck_4.Enabled then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah ON.bmp');
    btnArm_4.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau.bmp');
    btnSafe_4.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile4.FBoosterState := BOOSTER_ARM;
//    C802Manager.Missile4.FBoosterArm  := True;

    Prelaunch_count4 := tmr_FULL_OPEN;
    tmrPrelaunchCheck_4.Enabled := True;

    C802Manager.SendEvenC802(52,0,0,0);
  end;

end;

procedure TPanelBawah.btnCancel_1Click(Sender: TObject);
begin
  if Prelaunch_count1 > tmr_LAUNCH_READY then
    tmrPrelaunchCheck_1.Enabled := False;

  C802Manager.SendEvenC802(61,0,0,0);
end;

procedure TPanelBawah.btnCancel_2Click(Sender: TObject);
begin
  if Prelaunch_count2 > tmr_LAUNCH_READY then
    tmrPrelaunchCheck_2.Enabled := False;

   C802Manager.SendEvenC802(62,0,0,0);
end;

procedure TPanelBawah.btnCancel_3Click(Sender: TObject);
begin
  if Prelaunch_count3 > tmr_LAUNCH_READY then
    tmrPrelaunchCheck_3.Enabled := False;

  C802Manager.SendEvenC802(63,0,0,0);
end;

procedure TPanelBawah.btnCancel_4Click(Sender: TObject);
begin
  if Prelaunch_count4 > tmr_LAUNCH_READY then
    tmrPrelaunchCheck_4.Enabled := False;

  C802Manager.SendEvenC802(64,0,0,0);
end;

procedure TPanelBawah.btnCover_1Click(Sender: TObject);
begin
  Open_cover1 := not Open_cover1;

  if (Open_cover1) and (C802Manager.Missile1.FRigidityStt) and not tmrPrelaunchCheck_1.Enabled then
  begin
    Prelaunch_count1  := tmr_RIG_STT;
    tmrPrelaunchCheck_1.Enabled := True;
    {standalone}
//    C802Manager.Missile1.FFullOpen := True;
    C802Manager.SendEvenC802(45,0,0,0);
  end;

end;

procedure TPanelBawah.btnCover_2Click(Sender: TObject);
begin
  Open_cover2 := not Open_cover2;

  if (Open_cover2) and (C802Manager.Missile2.FRigidityStt) and not tmrPrelaunchCheck_2.Enabled then
  begin
    Prelaunch_count2  := tmr_RIG_STT;
    tmrPrelaunchCheck_2.Enabled := True;
    {standalone}
//    C802Manager.Missile2.FFullOpen := True;
    C802Manager.SendEvenC802(46,0,0,0);
  end;
end;

procedure TPanelBawah.btnCover_3Click(Sender: TObject);
begin
  Open_cover3 := not Open_cover3;

  if (Open_cover3) and (C802Manager.Missile3.FRigidityStt) and not tmrPrelaunchCheck_3.Enabled then
  begin
    Prelaunch_count3  := tmr_RIG_STT;
    tmrPrelaunchCheck_3.Enabled := True;
    {standalone}
//    C802Manager.Missile3.FFullOpen := True;
    C802Manager.SendEvenC802(47,0,0,0);
  end;
end;

procedure TPanelBawah.btnCover_4Click(Sender: TObject);
begin
  Open_cover4 := not Open_cover4;

  if (Open_cover4) and (C802Manager.Missile4.FRigidityStt) and not tmrPrelaunchCheck_4.Enabled then
  begin
    Prelaunch_count4  := tmr_RIG_STT;
    tmrPrelaunchCheck_4.Enabled := True;
    {standalone}
//    C802Manager.Missile4.FFullOpen := True;
    C802Manager.SendEvenC802(48,0,0,0);
  end;
end;

procedure TPanelBawah.btnEXITClick(Sender: TObject);
var rec_: TRecCMD_C802;
begin
//  rec_.cmd := CMD_C802Archos_Exit;
//  C802Manager.NetLocalCommServer.SendDataEx(REC_CMD_C802,@rec_,nil);
//  C802Manager.EndSimulation;
//  Application.Terminate;

CloseCurrentHandleApplication('C802.exe');

end;

procedure TPanelBawah.Mis_OnLaunch(mis_num: Integer);
var new_range,new_bearing: Double;
    miss_data: TC802_Object;
begin
  Rec_data.ShipID := UniqueID_To_dbID(C802Manager.xShip.UniqueID);
  Rec_data.mLauncherID  := mis_num;
  Rec_data.mMissileID := 1;
  Rec_data.mMissileNumber := 1;
  Rec_data.mWeaponID := C_DBID_C802;
  Rec_data.OrderID := OrdID_C802_launch;

  miss_data := TC802_Object.Create;
  case mis_num of
    1: miss_data := C802Manager.Missile1;
    2: miss_data := C802Manager.Missile2;
    3: miss_data := C802Manager.Missile3;
    4: miss_data := C802Manager.Missile4;
  end;

  {if miss_data.TgtNo = Target1.Number then
    C802Manager.CalcDistanceCoursePrediction(Target1, new_range, new_bearing);
  if miss_data.TgtNo = Target2.Number then
    C802Manager.CalcDistanceCoursePrediction(Target2, new_range, new_bearing);

  Rec_data.mTargetRange := new_range;
  Rec_data.mTargetBearing := new_bearing;   }

  if miss_data.TgtNo = Target1.Number then
    new_bearing := Target1.Azimuth + C802Manager.xShip.Heading;
  if miss_data.TgtNo = Target2.Number then
    new_bearing := Target2.Azimuth + C802Manager.xShip.Heading;

  if new_bearing > 360 then
    new_bearing := new_bearing - 360;

  if miss_data.TgtNo = Target1.Number then
  begin
    Rec_data.mTargetRange := Target1.Distance;
  end
  else if miss_data.TgtNo = Target2.Number then
  begin
    Rec_data.mTargetRange := Target2.Distance;
  end;


//  Rec_data.mTargetRange := Target1.Distance;
  Rec_data.mTargetBearing := new_bearing;

  C802Manager.NetComm.sendDataEx(REC_DATA_C802, @Rec_data);

  if miss_data.TgtNo = Target1.Number then
  begin
    miss_data.TgtNo := Target1.Number;
    miss_data.Dis := Target1.Distance;
    miss_data.Azm := Target1.Azimuth;
    miss_data.Spd := Target1.Speed;
    miss_data.Cou := Target1.Course;
    miss_data.Rzd := Target1.Hooming_Range;
    miss_data.Tzk := Target1.Self_Time;
    miss_data.Psiq := Target1.Psiq;
    miss_data.SitaZ := Target1.SitaZ;
    miss_data.GamaZ := Target1.GamaZ;
    miss_data.Time := Now;
    miss_data.Long := C802Manager.xShip.PositionX;
    miss_data.Lat := C802Manager.xShip.PositionY;
    miss_data.OwnSpd := C802Manager.xShip.Speed;
    miss_data.OwnHdg := C802Manager.xShip.Heading;
    miss_data.Pitch := C802Manager.xShip.Pitch;
    miss_data.Roll := C802Manager.xShip.Roll;
//        miss_data.TzkFB
    miss_data.WndSpd := C802Manager.Wind_Spd;
    miss_data.WndDir := C802Manager.Wind_Dir;
    miss_data.Temp := C802Manager.Temp;
//    miss_data.Mode
  end
  else if miss_data.TgtNo = Target2.Number then
  begin
    miss_data.TgtNo := Target2.Number;
    miss_data.Dis := Target2.Distance;
    miss_data.Azm := Target2.Azimuth;
    miss_data.Spd := Target2.Speed;
    miss_data.Cou := Target2.Course;
    miss_data.Rzd := Target2.Hooming_Range;
    miss_data.Tzk := Target2.Self_Time;
    miss_data.Psiq := Target2.Psiq;
    miss_data.SitaZ := Target2.SitaZ;
    miss_data.GamaZ := Target2.GamaZ;
    miss_data.Time := Now;
    miss_data.Long := C802Manager.xShip.PositionX;
    miss_data.Lat := C802Manager.xShip.PositionY;
    miss_data.OwnSpd := C802Manager.xShip.Speed;
    miss_data.OwnHdg := C802Manager.xShip.Heading;
    miss_data.Pitch := C802Manager.xShip.Pitch;
    miss_data.Roll := C802Manager.xShip.Roll;
//        miss_data.TzkFB
    miss_data.WndSpd := C802Manager.Wind_Spd;
    miss_data.WndDir := C802Manager.Wind_Dir;
    miss_data.Temp := C802Manager.Temp;
//        miss_data.Mode
  end;

  miss_data.Free;
end;

procedure TPanelBawah.btnFIREClick(Sender: TObject);
var num: Integer;
begin
  if C802Manager.Missile1.FPWRtoM then num:=1;
  if C802Manager.Missile2.FPWRtoM then num:=2;
  if C802Manager.Missile3.FPWRtoM then num:=3;
  if C802Manager.Missile4.FPWRtoM then num:=4;


  Rec_data.ShipID := UniqueID_To_dbID(C802Manager.xShip.UniqueID);
  Rec_data.mLauncherID  := num;
  Rec_data.mMissileID := 1;
  Rec_data.mMissileNumber := 0;
  Rec_data.mWeaponID := C_DBID_C802;
  Rec_data.OrderID := OrdID_C802_launch;
//
//  miss_data := TC802_Object.Create;
//  case mis_num of
//    1: miss_data := C802Manager.Missile1;
//    2: miss_data := C802Manager.Missile2;
//    3: miss_data := C802Manager.Missile3;
//    4: miss_data := C802Manager.Missile4;
//  end;
//
//  if miss_data.TgtNo = 1 then
//    C802Manager.CalcDistanceCoursePrediction(Target1, new_range, new_bearing);
//  if miss_data.TgtNo = 2 then
//    C802Manager.CalcDistanceCoursePrediction(Target2, new_range, new_bearing);
//
//  Rec_data.mTargetRange := new_range;
//  Rec_data.mTargetBearing := new_bearing;

  C802Manager.NetComm.sendDataEx(REC_DATA_C802, @Rec_data);
end;

procedure TPanelBawah.btnLaunch_1Click(Sender: TObject);
begin
  if Sender = btnLaunch_1 then
  begin
    if C802Manager.Missile1.FLaunchReady and not tmrPrelaunchCheck_1.Enabled then
    begin
      isLaunched1 := True;
      pnlLabel_MisState_1.Font.Color := clBlack;
      pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Launch';
      pnlLabel_MisStep_1.Caption  := 'Launch Button';
      Prelaunch_count1 := tmr_LAUNCH_READY;
      tmrPrelaunchCheck_1.Enabled := True;

      C802Manager.SendEvenC802(57,0,0,0);
    end;
  end;
  if Sender = btnLaunch_2 then
  begin
    if C802Manager.Missile2.FLaunchReady and not tmrPrelaunchCheck_2.Enabled then
    begin
      isLaunched2 := True;
      pnlLabel_MisState_2.Font.Color := clBlack;
      pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Launch';
      pnlLabel_MisStep_2.Caption  := 'Launch Button';
      Prelaunch_count2 := tmr_LAUNCH_READY;
      tmrPrelaunchCheck_2.Enabled := True;

      C802Manager.SendEvenC802(58,0,0,0);
    end;
  end;
  if Sender = btnLaunch_3 then
  begin
    if C802Manager.Missile3.FLaunchReady and not tmrPrelaunchCheck_3.Enabled then
    begin
      isLaunched3 := True;
      pnlLabel_MisState_3.Font.Color := clBlack;
      pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Launch';
      pnlLabel_MisStep_3.Caption  := 'Launch Button';
      Prelaunch_count3 := tmr_LAUNCH_READY;
      tmrPrelaunchCheck_3.Enabled := True;

      C802Manager.SendEvenC802(59,0,0,0);
    end;
  end;
  if Sender = btnLaunch_4 then
  begin
    if C802Manager.Missile4.FLaunchReady and not tmrPrelaunchCheck_4.Enabled then
    begin
      isLaunched4 := True;
      pnlLabel_MisState_4.Font.Color := clBlack;
      pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Launch';
      pnlLabel_MisStep_4.Caption  := 'Launch Button';
      Prelaunch_count4 := tmr_LAUNCH_READY;
      tmrPrelaunchCheck_4.Enabled := True;

      C802Manager.SendEvenC802(60,0,0,0);
    end;
  end;
end;

procedure TPanelBawah.btnLaunch_1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not tmrLaunch.Enabled then
  begin
    if Sender = btnLaunch_1 then
      LaunchMisNo := 1;
    if Sender = btnLaunch_2 then
      LaunchMisNo := 2;
    if Sender = btnLaunch_3 then
      LaunchMisNo := 3;
    if Sender = btnLaunch_4 then
      LaunchMisNo := 4;
    LaunchTimer := 0;
    tmrLaunch.Enabled := True;
  end;
end;

procedure TPanelBawah.btnLaunch_1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tmrLaunch.Enabled := False;
end;

procedure TPanelBawah.btnPowerClick(Sender: TObject);
begin

  if PanelAtas.Fan_Switch and PanelAtas.AC_Switch and PanelAtas.DC_Switch and
     (btnPower.ImageIndex = 1) then
  begin
    PanelAtas.Power_Switch  := not PanelAtas.Power_Switch  ;
    PanelBawah.pnlStatusPage.Visible  := True;
    PanelBawah.grpStartPage.Visible   := True;
  end
  else
  begin
    btnPower.ImageList := il_power;
    PanelBawah.pnlStatusPage.Visible  := False;
    PanelBawah.grpStartPage.Visible   := False;
//    Exit;
  end;

  C802Manager.SendEvenC802(4,0,0,0);

//  PanelAtas.MainMenu_On;
end;

procedure TPanelBawah.btnPWRtoM_1Click(Sender: TObject);
begin
//  if C802Manager.Missile1.FPWRtoM and (Prelaunch_count1 <> 1) then
//    btnPWRtoM_1.ImageIndex := 1
//  else
//  begin

    if  Launcher1OnFromInstruktur {and PanelAtas.Power_Switch} then
      btnPWRtoM_1.ImageIndex := 1
    else
      btnPWRtoM_1.ImageIndex := 0;

    case btnPWRtoM_1.ImageIndex of
      0: C802Manager.Missile1.FPWRtoM := False;
      1: C802Manager.Missile1.FPWRtoM := True;
    end;
    C802Manager.SendEvenC802(8,0,0,0);
//  end;
end;

procedure TPanelBawah.btnPWRtoM_2Click(Sender: TObject);
begin
//  if C802Manager.Missile2.FPWRtoM and (Prelaunch_count2 <> 1) then
//    btnPWRtoM_2.ImageIndex := 1
//  else
//  begin

    if Launcher2OnFromInstruktur {and PanelAtas.Power_Switch} then
      btnPWRtoM_2.ImageIndex := 1
    else
      btnPWRtoM_2.ImageIndex := 0;


    case btnPWRtoM_2.ImageIndex of
      0: C802Manager.Missile2.FPWRtoM := False;
      1: C802Manager.Missile2.FPWRtoM := True;
    end;
    C802Manager.SendEvenC802(9,0,0,0);
//  end;
end;

procedure TPanelBawah.btnPWRtoM_3Click(Sender: TObject);
begin
//  if C802Manager.Missile3.FPWRtoM and (Prelaunch_count3 <> 1) then
//    btnPWRtoM_3.ImageIndex := 1
//  else
//  begin

    if Launcher3OnFromInstruktur {and PanelAtas.Power_Switch} then
    begin
      btnPWRtoM_3.ImageIndex := 1;
      btnPWRtoM_3.ImageIndex := 1 ;
    end
    else
      btnPWRtoM_3.ImageIndex := 0;

    case btnPWRtoM_3.ImageIndex of
      0: C802Manager.Missile3.FPWRtoM := False;
      1: C802Manager.Missile3.FPWRtoM := True;
    end;

    C802Manager.SendEvenC802(10,0,0,0);
//  end;
end;

procedure TPanelBawah.btnPWRtoM_4Click(Sender: TObject);
begin
//  if C802Manager.Missile4.FPWRtoM and (Prelaunch_count4 <> 1) then
//    btnPWRtoM_4.ImageIndex := 1
//  else
//  begin

    if Launcher4OnFromInstruktur {and PanelAtas.Power_Switch} then
      btnPWRtoM_4.ImageIndex := 1
    else
      btnPWRtoM_4.ImageIndex := 0;

    case btnPWRtoM_4.ImageIndex of
      0: C802Manager.Missile4.FPWRtoM := False;
      1: C802Manager.Missile4.FPWRtoM := True;
    end;

    C802Manager.SendEvenC802(11,0,0,0);
//  end;
end;

procedure TPanelBawah.btnSafe_1Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile1.FBoosterState = BOOSTER_ARM) and PanelAtas.isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah.bmp');
    btnArm_1.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau ON.bmp');
    btnSafe_1.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile1.FBoosterState := BOOSTER_SAFE;
    C802Manager.SendEvenC802(53,0,0,0);
  end;
end;

procedure TPanelBawah.btnSafe_2Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile2.FBoosterState = BOOSTER_ARM) and PanelAtas.isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah.bmp');
    btnArm_2.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau ON.bmp');
    btnSafe_2.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile2.FBoosterState := BOOSTER_SAFE;
    C802Manager.SendEvenC802(54,0,0,0);
  end;
end;

procedure TPanelBawah.btnSafe_3Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile3.FBoosterState = BOOSTER_ARM) and PanelAtas.isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah.bmp');
    btnArm_3.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau ON.bmp');
    btnSafe_3.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile3.FBoosterState := BOOSTER_SAFE;
    C802Manager.SendEvenC802(55,0,0,0);
  end;
end;

procedure TPanelBawah.btnSafe_4Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (C802Manager.Missile4.FBoosterState = BOOSTER_ARM) and PanelAtas.isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\button merah.bmp');
    btnArm_4.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\button hijau ON.bmp');
    btnSafe_4.Glyph := bitmap;

    bitmap.Free;

    C802Manager.Missile4.FBoosterState := BOOSTER_SAFE;
    C802Manager.SendEvenC802(56,0,0,0);
  end;
end;

procedure TPanelBawah.btn_ENTERClick(Sender: TObject);
begin
  EnterButton;
end;

procedure TPanelBawah.ParSetting_behav;
begin
  if pnlFirePwr_Dist.BevelOuter = bvLowered then
    grpFirePwr_Dist.BringToFront
  else if pnlAttack_Mode.BevelOuter = bvLowered then
    grpAttack_Mode.BringToFront
  else if pnlTargetSet_1.BevelOuter = bvLowered then
    grpTargetSet_1.BringToFront
  else if pnlTargetSet_2.BevelOuter = bvLowered then
    grpTargetSet_2.BringToFront
  else if pnlGPS_para.BevelOuter = bvLowered then
    grpGPS_para.BringToFront
  else if pnlMete_para.BevelOuter = bvLowered then
    grpMete_para.BringToFront;

end;

procedure TPanelBawah.pnlVisibleExitDblClick(Sender: TObject);
begin
  pnlHIDE.Visible := not pnlHIDE.Visible;
end;

procedure TPanelBawah.LaunchStep_SetOn(indicator: TPanel);
begin
  indicator.Color := clLime;
  indicator.Font.Color  := clBlack;
end;

procedure TPanelBawah.MapC802DrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Cardinal; const RectFull,
  RectInvalid: IDispatch);
var
  I: Integer;
  dir_tgt : Double;
  obj : TClientObject;
  ptt : T2dPoint;
  pts : t2DPoint;
  int_random: Integer;
  float_random: Double;
  { draw target }
  LongShip, LatShip : Double;
  point_tgt, point_ctr : t2DPoint;
  x_tgt,y_tgt : Single;
  x_sc_tgt,y_sc_tgt : Integer;
  bearing_tgt: Double;

  p: Integer;
  s: string;
begin
  if not Assigned(FCanvas) then
    Exit;
  FCanvas.Handle := hOutputDC;

  EventForm.drawCompass(FCanvas);

  {DrawMembersView(C802Manager.MainObjList, FCanvas);}
  if Assigned(C802Manager.MainObjList) then
  begin
    for I := 0 to Length(ListAssignedObjects) - 1 do
    begin
      if Assigned(ListAssignedObjects[I]) then
      begin
        obj := TClientObject.Create;
        obj := ListAssignedObjects[I] as TClientObject;

        if obj.UniqueID <> '' then
        begin
          if I = 0 then begin
            with Target1 do begin
              Number := UniqueID_To_dbID(obj.UniqueID);
              Distance := CalcRange(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY,
                                  obj.PositionX, obj.PositionY) * C_NauticalMiles_TO_Meter;
              bearing_tgt := CalcBearing(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY,
                             obj.PositionX, obj.PositionY);
              if bearing_tgt < C802Manager.xShip.Heading then
                Azimuth := (bearing_tgt + 360) - C802Manager.xShip.Heading
              else  Azimuth := bearing_tgt - C802Manager.xShip.Heading;
              Speed := obj.Speed;
              Course := obj.Heading;
              Longitude := obj.PositionX;
              Latitude := obj.PositionY;

              if (Distance >= 10000) and (Distance <= 15000) then
                Hooming_Range := 5000
              else if (Distance > 15000) and (Distance <= 25000) then
                Hooming_Range := 9000
              else if (Distance > 25000) then
                Hooming_Range := 13000;

              if Hooming_Range <> 0 then
                pnlRzd_1.Caption := FloatToStr(Hooming_Range/1000);

              if (Speed <> 0) and (Hooming_Range <> 0) then
              begin
                Self_Time := (Distance - Hooming_Range) / Speed;
                pnlTzk_1.Caption := FormatFloat('0.00', Self_Time);

                int_random := Random(2);
                float_random := Random;
                Psiq := int_random + float_random;
                pnlPsiq_1.Caption := FormatFloat('0.00', Psiq);

                int_random := Random(2);
                float_random := Random;
                SitaZ := 14 + int_random + float_random;
                pnlSitaZ_1.Caption := FormatFloat('0.00', SitaZ);

                int_random := Random(2);
                float_random := Random;
                GamaZ := int_random + float_random;
                pnlGamaZ_1.Caption := FormatFloat('0.00', GamaZ);
              end;
            end;
          end
          else with Target2 do begin
            Number := UniqueID_To_dbID(obj.UniqueID);
            Distance := CalcRange(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY,
                                obj.PositionX, obj.PositionY) * C_NauticalMiles_TO_Meter;
            bearing_tgt := CalcBearing(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY,
                           obj.PositionX, obj.PositionY);
            if bearing_tgt < C802Manager.xShip.Heading then
              Azimuth := (bearing_tgt + 360) - C802Manager.xShip.Heading
            else  Azimuth := bearing_tgt - C802Manager.xShip.Heading;
            Speed := obj.Speed;
            Course := obj.Heading;
            Longitude := obj.PositionX;
            Latitude := obj.PositionY;

            if (Distance >= 10000) and (Distance <= 15000) then
              Hooming_Range := 5000
            else if (Distance > 15000) and (Distance <= 25000) then
              Hooming_Range := 9000
            else if (Distance > 25000) then
              Hooming_Range := 13000;

            if Hooming_Range <> 0 then
              pnlRzd_1.Caption := FloatToStr(Hooming_Range/1000);

            if (Speed <> 0) and (Hooming_Range <> 0) then
            begin
              Self_Time := (Distance - Hooming_Range) / Speed;
              pnlTzk_2.Caption := FormatFloat('0.00', Self_Time);

              int_random := Random(2);
              float_random := Random;
              Psiq := int_random + float_random;
              pnlPsiq_2.Caption := FormatFloat('0.00', Psiq);

              int_random := Random(2);
              float_random := Random;
              SitaZ := 14 + int_random + float_random;
              pnlSitaZ_2.Caption := FormatFloat('0.00', SitaZ);

              int_random := Random(2);
              float_random := Random;
              GamaZ := int_random + float_random;
              pnlGamaZ_2.Caption := FormatFloat('0.00', GamaZ);
            end;
          end;

          EventForm.drawTarget(FCanvas, obj.PositionX, obj.PositionY, UniqueID_To_dbID(obj.UniqueID));
        end;
      end;
    end;
  end;

  { draw target }
  if not Assigned(ListAssignedObjects[0]) then
  begin
    if (Target1.Distance <> 0) and (Target1.Course <> 1000) then
    begin
      point_ctr.X := MapC802.CenterX;
      point_ctr.Y := MapC802.CenterY;
      dir_tgt := Target1.Azimuth + C802Manager.xShip.Heading;
      if dir_tgt > 360 then
        dir_tgt := dir_tgt - 360;
      point_tgt := CalcPositionAhead(point_ctr,Target1.Distance * C_Meter_To_NauticalMiles,
                   ConvCompass_To_Cartesian(dir_tgt));
      EventForm.drawTarget(FCanvas, point_tgt.X, point_tgt.Y, Target1.Number);

      p:= Round(ArcTan(DegToRad(30))*160);
  //          MapC802.ConvertCoord(x_tgt, y_tgt, point_tgt.X, point_tgt.Y,mimaptoscreen);
  //          x_sc_tgt := Round(x_tgt);
  //          y_sc_tgt := Round(y_tgt);
    end;
  end;

  if not Assigned(ListAssignedObjects[1]) then
  begin
    if (Target2.Longitude <> 1000) and (Target2.Latitude <> 1000) then
    begin
      EventForm.drawTarget(FCanvas, Target2.Longitude, Target2.Latitude, Target2.Number);
    end;
  end;

end;

procedure TPanelBawah.LaunchStep_SetOff(indicator: TPanel);
begin
  indicator.Color := clBlack;
  indicator.Font.Color  := clWhite;
end;

procedure TPanelBawah.LaunchStep_SetFailed(indicator: TPanel);
begin
  indicator.Color := clRed;
  indicator.Font.Color  := clBlack;
end;

procedure TPanelBawah.PrelaunchCheckOn(indicator: TPanel);
begin
  indicator.Font.Color := clLime;
  indicator.Caption := 'Y';
end;

procedure TPanelBawah.PrelaunchCheckOff(indicator: TPanel);
begin
  indicator.Caption := '';
end;

procedure TPanelBawah.PrelaunchCheckFailed(indicator: TPanel);
begin
  indicator.Font.Color := clRed;
  indicator.Caption := 'N';
end;

procedure TPanelBawah.tmrCheckPageTimer(Sender: TObject);
var cap : string;
begin
  CheckPage_counter := CheckPage_counter + 1;

  case CheckPage_counter of
    7:
      begin
        lblContainCheckPg.Font.Color := clLime;
        lblContainCheckPg.Caption := 'CPU.........................................................Normal';
      end;
    8: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Dual RAM...............................................Normal';
    9: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'EPROM....................................................Normal';
    10: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Static RAM.............................................Normal';
    11: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Serial port A..........................................Normal';
    12: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Serial port B...........................................Normal';
    13: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Serial port C...........................................Normal';
    14: lblContainCheckPg.Caption := lblContainCheckPg.Caption +#13+
          'Serial port D...........................................Normal';
    15:
      begin
        tmrCheckPage.Enabled := False;
        CheckPage_counter := 0;
      end;
  end;
end;

procedure TPanelBawah.tmrLaunchTimer(Sender: TObject);
begin
  LaunchTimer := LaunchTimer + 1;

//  if LaunchTimer = 6 then
//  begin
    case LaunchMisNo of
      1:
        if C802Manager.Missile1.FLaunchReady then
        begin
          pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Launch';
          pnlLabel_MisStep_1.Caption  := 'Launch Button';
          tmrPrelaunchCheck_1.Enabled := True;
        end;
      2:
        if C802Manager.Missile2.FLaunchReady then
        begin
          pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Launch';
          pnlLabel_MisStep_2.Caption  := 'Launch Button';
          tmrPrelaunchCheck_2.Enabled := True;
        end;
      3:
        if C802Manager.Missile3.FLaunchReady then
        begin
          pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Launch';
          pnlLabel_MisStep_3.Caption  := 'Launch Button';
          tmrPrelaunchCheck_3.Enabled := True;
        end;
      4:
        if C802Manager.Missile4.FLaunchReady then
        begin
          pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Launch';
          pnlLabel_MisStep_4.Caption  := 'Launch Button';
          tmrPrelaunchCheck_4.Enabled := True;
        end;
    end;
    tmrLaunch.Enabled := False;
//  end;

end;

procedure TPanelBawah.tmrPrelaunchCheck_1Timer(Sender: TObject);
begin
  Prelaunch_count1  := Prelaunch_count1 + 1;

  case Prelaunch_count1 of
    tmr_INIT_STATE:
      begin
        isNormal1 := True;
        if C802Manager.Missile1.FInitState then
          PrelaunchCheckOn(pnlInitState_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlInitState_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'Power Supply';
      end;
    tmr_POWER_SUPPLY:
      begin
        if C802Manager.Missile1.FPowerSupply then
          PrelaunchCheckOn(pnlPowerSupply_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlPowerSupply_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'TurnOn Equips';
      end;
    tmr_TURNON_EQUIP:
      begin
        if C802Manager.Missile1.FTurnOnEquip then
          PrelaunchCheckOn(pnlTurnOnEquip_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlTurnOnEquip_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'CtrlS1,4 Stg1';
      end;
    Round((tmr_CHECK_STAGE_1-tmr_TURNON_EQUIP)/2)+tmr_TURNON_EQUIP:
        pnlLabel_MisStep_1.Caption  := 'CtrlS2,3 Stg1';
    tmr_CHECK_STAGE_1:
      begin
        if C802Manager.Missile1.FCheckStage1 then
          PrelaunchCheckOn(pnlCheckStage1_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlCheckStage1_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'CtrlSf1 Stg2';
      end;
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_1.Caption  := 'CtrlSf3 Stg2';
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)*2/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_1.Caption  := 'Transmt Anttn';
    tmr_ANGLE_SET:
      begin
        if C802Manager.Missile1.FAngleSet then
          PrelaunchCheckOn(pnlAngleSet_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlAngleSet_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'CtrlS2,4 Stg2';
      end;
    Round((tmr_COCHECK-tmr_ANGLE_SET)/2)+tmr_ANGLE_SET:
        pnlLabel_MisStep_1.Caption  := 'CtrlS1,3 Stg2';
    tmr_COCHECK:
      begin
        if C802Manager.Missile1.FCoCheck then
          PrelaunchCheckOn(pnlCoCheck_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlCoCheck_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'Tzk setting';
      end;
    tmr_TZK_SETTING:
      begin
        if C802Manager.Missile1.FTzkSetting then
          PrelaunchCheckOn(pnlTzkSetting_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlTzkSetting_1);
        end;

        pnlLabel_MisStep_1.Caption  := 'Command No.3';
      end;
    tmr_COMMAND_NO_3:
      begin
        if C802Manager.Missile1.FCommandNo3 then
          PrelaunchCheckOn(pnlCommandNo3_1)
        else begin
          isNormal1 := False;
          PrelaunchCheckFailed(pnlCommandNo3_1);
        end;
      end;
    tmr_MIS_NORMAL:
      begin
        if {C802Manager.Missile1.FMisNormal and} isNormal1 then
        begin
          PrelaunchCheckOn(pnlMisNormal_1);
          PanelAtas.setImplicit(1,2,True);
          PanelAtas.setImplicit(1,3,True);
          PanelAtas.setImplicit(1,4,True);
          pnlLabel_MisState_1.Font.Color := clBlack;
          pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Normal';
          pnlLabel_MisStep_1.Caption  := 'Mis Normal';
        end
        else begin
          PrelaunchCheckFailed(pnlMisNormal_1);
          pnlLabel_MisState_1.Font.Color := clRed;
          pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Failure';
          pnlLabel_MisStep_1.Caption  := '';
        end;

        tmrPrelaunchCheck_1.Enabled := False;
      end;
    tmr_ACC_CALC:
      begin
        if C802Manager.Missile1.FAccurateCal then
        begin
          PrelaunchCheckOn(pnlAccurateCal_1);
          LaunchStep_SetOn(pnlLaunchStep_1_AccurateCal);
        end
        else PrelaunchCheckFailed(pnlAccurateCal_1);
      end;
    tmr_INSIDE_SECT:
      begin
        if C802Manager.Missile1.FInsideSectr then
        begin
          PrelaunchCheckOn(pnlInsideSectr_1);
          LaunchStep_SetOn(pnlLaunchStep_1_InsideSector);
        end
        else PrelaunchCheckFailed(pnlInsideSectr_1);

        tmrPrelaunchCheck_1.Enabled := False;
        LaunchReady_On(1);
      end;
    tmr_LIMITER_OUT:
      begin
        if C802Manager.Missile1.FLimiterOut then
        begin
          PrelaunchCheckOn(pnlLimiterOut_1);
          LaunchStep_SetOn(pnlLaunchStep_1_LimiterOut);
          PanelAtas.setImplicit(1,1,True);
        end
        else PrelaunchCheckFailed(pnlLimiterOut_1);
      end;
    tmr_RIG_STT:
      begin
        if C802Manager.Missile1.FRigidityStt then
        begin
          PrelaunchCheckOn(pnlRigidityStt_1);
          LaunchStep_SetOn(pnlLaunchStep_1_RigidityStt);
        end
        else PrelaunchCheckFailed(pnlRigidityStt_1);

        tmrPrelaunchCheck_1.Enabled := False;
        LaunchReady_On(1);
      end;
    tmr_FULL_OPEN:
      begin
        if C802Manager.Missile1.FFullOpen then
        begin
          PrelaunchCheckOn(pnlFullOpen_1);
          LaunchStep_SetOn(pnlLaunchStep_1_FullOpen);
        end
        else begin
          PrelaunchCheckFailed(pnlFullOpen_1);
          btnCover_1Click(Sender);
        end;

        tmrPrelaunchCheck_1.Enabled := False;
        LaunchReady_On(1);
      end;
    tmr_BOOSTER_ARM:
      begin
        if C802Manager.Missile1.FBoosterArm then
        begin
          PrelaunchCheckOn(pnlBoosterArm_1);
          LaunchStep_SetOn(pnlLaunchStep_1_BoosterArm);
        end
        else PrelaunchCheckFailed(pnlBoosterArm_1);

        tmrPrelaunchCheck_1.Enabled := False;
        LaunchReady_On(1);
      end;
    tmr_LAUNCH_READY:
      begin
        if C802Manager.Missile1.FLaunchReady then
        begin
          PrelaunchCheckOn(pnlLaunchReady_1);
          PanelAtas.setImplicit(1,5,True);
        end
        else PrelaunchCheckFailed(pnlLaunchReady_1);

        pnlLabel_MisStep_1.Caption  := 'Launch Ready';
        tmrPrelaunchCheck_1.Enabled := False;
      end;
    tmr_LAUNCH_BUTT:
      begin
        if C802Manager.Missile1.FLaunchButton then
        begin
          PrelaunchCheckOn(pnlLaunchButton_1);
          LaunchStep_SetOn(pnlLaunchStep_1_LaunchButton);
        end
        else begin
          PrelaunchCheckOn(pnlLaunchButton_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_LaunchButton);
          isLaunched1 := False;
        end;

        pnlLabel_MisStep_1.Caption  := 'Battery Act';
      end;
    tmr_BATT_ACT:
      begin
        if C802Manager.Missile1.FBatteryAct then
        begin
          PrelaunchCheckOn(pnlBatteryAct_1);
          LaunchStep_SetOn(pnlLaunchStep_1_BatteryAct);
        end
        else begin
          PrelaunchCheckFailed(pnlBatteryAct_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_BatteryAct);
          isLaunched1 := False;
        end;

        pnlLabel_MisStep_1.Caption  := 'Power Switch';
      end;
    tmr_POWER_SWITCH:
      begin
        if C802Manager.Missile1.FPowerSwitch then
        begin
          PrelaunchCheckOn(pnlPowerSwitch_1);
          LaunchStep_SetOn(pnlLaunchStep_1_PowerSwitch);
        end
        else begin
          PrelaunchCheckFailed(pnlPowerSwitch_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_PowerSwitch);
          isLaunched1 := False;
        end;

        pnlLabel_MisStep_1.Caption  := 'Gyro Uncaged';
      end;
    tmr_GYRO_UNCAGED:
      begin
        if C802Manager.Missile1.FGyroUncaged then
        begin
          PrelaunchCheckOn(pnlGyroUncaged_1);
          LaunchStep_SetOn(pnlLaunchStep_1_GyroUncage);
        end
        else begin
          PrelaunchCheckFailed(pnlGyroUncaged_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_GyroUncage);
          isLaunched1 := False;
        end;

        pnlLabel_MisStep_1.Caption  := 'Ignition';
      end;
    tmr_IGNITION:
      begin
        if C802Manager.Missile1.FIgnition then
        begin
          PrelaunchCheckOn(pnlIgnition_1);
          LaunchStep_SetOn(pnlLaunchStep_1_Ignition);
        end
        else begin
          PrelaunchCheckFailed(pnlIgnition_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_Ignition);
          isLaunched1 := False;
        end;

        pnlLabel_MisState_1.Font.Color := clBlack;
        pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Take Off';
        pnlLabel_MisStep_1.Caption  := 'Take Off';
      end;
    tmr_TAKE_OFF:
      begin
        if {C802Manager.Missile1.FTakeOff and} isLaunched1 and isNormal1 then
        begin
          PrelaunchCheckOn(pnlTakeOff_1);
          LaunchStep_SetOn(pnlLaunchStep_1_TakeOff);
          Mis_OnLaunch(1);
          pnlLabel_MisState_1.Font.Color := clBlack;
          pnlLabel_MisState_1.Caption := 'M. No. 1: C802 NoMis';
          pnlLabel_MisStep_1.Caption  := '-';
        end
        else begin
          PrelaunchCheckFailed(pnlTakeOff_1);
          LaunchStep_SetFailed(pnlLaunchStep_1_TakeOff);
        end;

        tmrPrelaunchCheck_1.Enabled := False;

        {Clear Status Missile}
      end;
  end;
end;

procedure TPanelBawah.tmrPrelaunchCheck_2Timer(Sender: TObject);
begin
  Prelaunch_count2  := Prelaunch_count2 + 1;

  case Prelaunch_count2 of
    tmr_INIT_STATE:
      begin
        isNormal2 := True;
        if C802Manager.Missile2.FInitState then
          PrelaunchCheckOn(pnlInitState_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlInitState_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'Power Supply';
      end;
    tmr_POWER_SUPPLY:
      begin
        if C802Manager.Missile2.FPowerSupply then
          PrelaunchCheckOn(pnlPowerSupply_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlPowerSupply_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'TurnOn Equips';
      end;
    tmr_TURNON_EQUIP:
      begin
        if C802Manager.Missile2.FTurnOnEquip then
          PrelaunchCheckOn(pnlTurnOnEquip_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlTurnOnEquip_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'CtrlS1,4 Stg1';
      end;
    Round((tmr_CHECK_STAGE_1-tmr_TURNON_EQUIP)/2)+tmr_TURNON_EQUIP:
        pnlLabel_MisStep_2.Caption  := 'CtrlS2,3 Stg1';
    tmr_CHECK_STAGE_1:
      begin
        if C802Manager.Missile2.FCheckStage1 then
          PrelaunchCheckOn(pnlCheckStage1_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlCheckStage1_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'CtrlSf1 Stg2';
      end;
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_2.Caption  := 'CtrlSf3 Stg2';
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)*2/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_2.Caption  := 'Transmt Anttn';
    tmr_ANGLE_SET:
      begin
        if C802Manager.Missile2.FAngleSet then
          PrelaunchCheckOn(pnlAngleSet_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlAngleSet_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'CtrlS2,4 Stg2';
      end;
    Round((tmr_COCHECK-tmr_ANGLE_SET)/2)+tmr_ANGLE_SET:
        pnlLabel_MisStep_2.Caption  := 'CtrlS1,3 Stg2';
    tmr_COCHECK:
      begin
        if C802Manager.Missile2.FCoCheck then
          PrelaunchCheckOn(pnlCoCheck_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlCoCheck_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'Tzk setting';
      end;
    tmr_TZK_SETTING:
      begin
        if C802Manager.Missile2.FTzkSetting then
          PrelaunchCheckOn(pnlTzkSetting_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlTzkSetting_2);
        end;

        pnlLabel_MisStep_2.Caption  := 'Command No.3';
      end;
    tmr_COMMAND_NO_3:
      begin
        if C802Manager.Missile2.FCommandNo3 then
          PrelaunchCheckOn(pnlCommandNo3_2)
        else begin
          isNormal2 := False;
          PrelaunchCheckFailed(pnlCommandNo3_2);
        end;
      end;
    tmr_MIS_NORMAL:
      begin
        if {C802Manager.Missile2.FMisNormal and} isNormal2 then
        begin
          PrelaunchCheckOn(pnlMisNormal_2);
          PanelAtas.setImplicit(2,2,True);
          PanelAtas.setImplicit(2,3,True);
          PanelAtas.setImplicit(2,4,True);
          pnlLabel_MisState_2.Font.Color := clBlack;
          pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Normal';
          pnlLabel_MisStep_2.Caption  := 'Mis Normal';
        end
        else begin
          PrelaunchCheckFailed(pnlMisNormal_2);
          pnlLabel_MisState_2.Font.Color := clRed;
          pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Failure';
          pnlLabel_MisStep_2.Caption  := '';
        end;

        tmrPrelaunchCheck_2.Enabled := False;
      end;
    tmr_ACC_CALC:
      begin
        if C802Manager.Missile2.FAccurateCal then
        begin
          PrelaunchCheckOn(pnlAccurateCal_2);
          LaunchStep_SetOn(pnlLaunchStep_2_AccurateCal);
        end
        else PrelaunchCheckFailed(pnlAccurateCal_2);
      end;
    tmr_INSIDE_SECT:
      begin
        if C802Manager.Missile2.FInsideSectr then
        begin
          PrelaunchCheckOn(pnlInsideSectr_2);
          LaunchStep_SetOn(pnlLaunchStep_2_InsideSector);
        end
        else PrelaunchCheckFailed(pnlInsideSectr_2);

        tmrPrelaunchCheck_2.Enabled := False;
        LaunchReady_On(2);
      end;
    tmr_LIMITER_OUT:
      begin
        if C802Manager.Missile2.FLimiterOut then
        begin
          PrelaunchCheckOn(pnlLimiterOut_2);
          LaunchStep_SetOn(pnlLaunchStep_2_LimiterOut);
          PanelAtas.setImplicit(2,1,True);
        end
        else PrelaunchCheckFailed(pnlLimiterOut_2);
      end;
    tmr_RIG_STT:
      begin
        if C802Manager.Missile2.FRigidityStt then
        begin
          PrelaunchCheckOn(pnlRigidityStt_2);
          LaunchStep_SetOn(pnlLaunchStep_2_RigidityStt);
        end
        else PrelaunchCheckFailed(pnlRigidityStt_2);

        tmrPrelaunchCheck_2.Enabled := False;
        LaunchReady_On(2);
      end;
    tmr_FULL_OPEN:
      begin
        if C802Manager.Missile2.FFullOpen then
        begin
          PrelaunchCheckOn(pnlFullOpen_2);
          LaunchStep_SetOn(pnlLaunchStep_2_FullOpen);
        end
        else begin
          PrelaunchCheckFailed(pnlFullOpen_2);
          btnCover_2Click(Sender);
        end;

        tmrPrelaunchCheck_2.Enabled := False;
        LaunchReady_On(2);
      end;
    tmr_BOOSTER_ARM:
      begin
        if C802Manager.Missile2.FBoosterArm then
        begin
          PrelaunchCheckOn(pnlBoosterArm_2);
          LaunchStep_SetOn(pnlLaunchStep_2_BoosterArm);
        end
        else PrelaunchCheckFailed(pnlBoosterArm_2);

        tmrPrelaunchCheck_2.Enabled := False;
        LaunchReady_On(2);
      end;
    tmr_LAUNCH_READY:
      begin
        if C802Manager.Missile2.FLaunchReady then
        begin
          PrelaunchCheckOn(pnlLaunchReady_2);
          PanelAtas.setImplicit(2,5,True);
        end
        else PrelaunchCheckFailed(pnlLaunchReady_2);

        pnlLabel_MisStep_2.Caption  := 'Launch Ready';
        tmrPrelaunchCheck_2.Enabled := False;
      end;
    tmr_LAUNCH_BUTT:
      begin
        if C802Manager.Missile2.FLaunchButton then
        begin
          PrelaunchCheckOn(pnlLaunchButton_2);
          LaunchStep_SetOn(pnlLaunchStep_2_LaunchButton);
        end
        else begin
          PrelaunchCheckOn(pnlLaunchButton_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_LaunchButton);
          isLaunched2 := False;
        end;

        pnlLabel_MisStep_2.Caption  := 'Battery Act';
      end;
    tmr_BATT_ACT:
      begin
        if C802Manager.Missile2.FBatteryAct then
        begin
          PrelaunchCheckOn(pnlBatteryAct_2);
          LaunchStep_SetOn(pnlLaunchStep_2_BatteryAct);
        end
        else begin
          PrelaunchCheckFailed(pnlBatteryAct_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_BatteryAct);
          isLaunched2 := False;
        end;

        pnlLabel_MisStep_2.Caption  := 'Power Switch';
      end;
    tmr_POWER_SWITCH:
      begin
        if C802Manager.Missile2.FPowerSwitch then
        begin
          PrelaunchCheckOn(pnlPowerSwitch_2);
          LaunchStep_SetOn(pnlLaunchStep_2_PowerSwitch);
        end
        else begin
          PrelaunchCheckFailed(pnlPowerSwitch_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_PowerSwitch);
          isLaunched2 := False;
        end;

        pnlLabel_MisStep_2.Caption  := 'Gyro Uncaged';
      end;
    tmr_GYRO_UNCAGED:
      begin
        if C802Manager.Missile2.FGyroUncaged then
        begin
          PrelaunchCheckOn(pnlGyroUncaged_2);
          LaunchStep_SetOn(pnlLaunchStep_2_GyroUncage);
        end
        else begin
          PrelaunchCheckFailed(pnlGyroUncaged_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_GyroUncage);
          isLaunched2 := False;
        end;

        pnlLabel_MisStep_2.Caption  := 'Ignition';
      end;
    tmr_IGNITION:
      begin
        if C802Manager.Missile2.FIgnition then
        begin
          PrelaunchCheckOn(pnlIgnition_2);
          LaunchStep_SetOn(pnlLaunchStep_2_Ignition);
        end
        else begin
          PrelaunchCheckFailed(pnlIgnition_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_Ignition);
          isLaunched2 := False;
        end;

        pnlLabel_MisState_2.Font.Color := clBlack;
        pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Take Off';
        pnlLabel_MisStep_2.Caption  := 'Take Off';
      end;
    tmr_TAKE_OFF:
      begin
        if {C802Manager.Missile2.FTakeOff and} isLaunched2 and isNormal2 then
        begin
          PrelaunchCheckOn(pnlTakeOff_2);
          LaunchStep_SetOn(pnlLaunchStep_2_TakeOff);
          Mis_OnLaunch(2);
          pnlLabel_MisState_2.Font.Color := clBlack;
          pnlLabel_MisState_2.Caption := 'M. No. 2: C802 NoMis';
          pnlLabel_MisStep_2.Caption  := '-';
        end
        else begin
          PrelaunchCheckFailed(pnlTakeOff_2);
          LaunchStep_SetFailed(pnlLaunchStep_2_TakeOff);
        end;

        tmrPrelaunchCheck_2.Enabled := False;

        {Clear Status Missile}
      end;
  end;
end;

procedure TPanelBawah.tmrPrelaunchCheck_3Timer(Sender: TObject);
begin
  Prelaunch_count3  := Prelaunch_count3 + 1;

  case Prelaunch_count3 of
    tmr_INIT_STATE:
      begin
        isNormal3 := True;
        if C802Manager.Missile3.FInitState then
          PrelaunchCheckOn(pnlInitState_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlInitState_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'Power Supply';
      end;
    tmr_POWER_SUPPLY:
      begin
        if C802Manager.Missile3.FPowerSupply then
          PrelaunchCheckOn(pnlPowerSupply_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlPowerSupply_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'TurnOn Equips';
      end;
    tmr_TURNON_EQUIP:
      begin
        if C802Manager.Missile3.FTurnOnEquip then
          PrelaunchCheckOn(pnlTurnOnEquip_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlTurnOnEquip_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'CtrlS1,4 Stg1';
      end;
    Round((tmr_CHECK_STAGE_1-tmr_TURNON_EQUIP)/2)+tmr_TURNON_EQUIP:
        pnlLabel_MisStep_3.Caption  := 'CtrlS2,3 Stg1';
    tmr_CHECK_STAGE_1:
      begin
        if C802Manager.Missile3.FCheckStage1 then
          PrelaunchCheckOn(pnlCheckStage1_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlCheckStage1_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'CtrlSf1 Stg2';
      end;
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_3.Caption  := 'CtrlSf3 Stg2';
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)*2/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_3.Caption  := 'Transmt Anttn';
    tmr_ANGLE_SET:
      begin
        if C802Manager.Missile3.FAngleSet then
          PrelaunchCheckOn(pnlAngleSet_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlAngleSet_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'CtrlS2,4 Stg2';
      end;
    Round((tmr_COCHECK-tmr_ANGLE_SET)/2)+tmr_ANGLE_SET:
        pnlLabel_MisStep_3.Caption  := 'CtrlS1,3 Stg2';
    tmr_COCHECK:
      begin
        if C802Manager.Missile3.FCoCheck then
          PrelaunchCheckOn(pnlCoCheck_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlCoCheck_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'Tzk setting';
      end;
    tmr_TZK_SETTING:
      begin
        if C802Manager.Missile3.FTzkSetting then
          PrelaunchCheckOn(pnlTzkSetting_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlTzkSetting_3);
        end;

        pnlLabel_MisStep_3.Caption  := 'Command No.3';
      end;
    tmr_COMMAND_NO_3:
      begin
        if C802Manager.Missile3.FCommandNo3 then
          PrelaunchCheckOn(pnlCommandNo3_3)
        else begin
          isNormal3 := False;
          PrelaunchCheckFailed(pnlCommandNo3_3);
        end;
      end;
    tmr_MIS_NORMAL:
      begin
        if {C802Manager.Missile3.FMisNormal and }isNormal3 then
        begin
          PrelaunchCheckOn(pnlMisNormal_3);
          PanelAtas.setImplicit(3,2,True);
          PanelAtas.setImplicit(3,3,True);
          PanelAtas.setImplicit(3,4,True);
          pnlLabel_MisState_3.Font.Color := clBlack;
          pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Normal';
          pnlLabel_MisStep_3.Caption  := 'Mis Normal';
        end
        else begin
          PrelaunchCheckFailed(pnlMisNormal_3);
          pnlLabel_MisState_3.Font.Color := clRed;
          pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Failure';
          pnlLabel_MisStep_3.Caption  := '';
        end;

        tmrPrelaunchCheck_3.Enabled := False;
      end;
    tmr_ACC_CALC:
      begin
        if C802Manager.Missile3.FAccurateCal then
        begin
          PrelaunchCheckOn(pnlAccurateCal_3);
          LaunchStep_SetOn(pnlLaunchStep_3_AccurateCal);
        end
        else PrelaunchCheckFailed(pnlAccurateCal_3);
      end;
    tmr_INSIDE_SECT:
      begin
        if C802Manager.Missile3.FInsideSectr then
        begin
          PrelaunchCheckOn(pnlInsideSectr_3);
          LaunchStep_SetOn(pnlLaunchStep_3_InsideSector);
        end
        else PrelaunchCheckFailed(pnlInsideSectr_3);

        tmrPrelaunchCheck_3.Enabled := False;
        LaunchReady_On(3);
      end;
    tmr_LIMITER_OUT:
      begin
        if C802Manager.Missile3.FLimiterOut then
        begin
          PrelaunchCheckOn(pnlLimiterOut_3);
          LaunchStep_SetOn(pnlLaunchStep_3_LimiterOut);
          PanelAtas.setImplicit(3,1,True);
        end
        else PrelaunchCheckFailed(pnlLimiterOut_3);
      end;
    tmr_RIG_STT:
      begin
        if C802Manager.Missile3.FRigidityStt then
        begin
          PrelaunchCheckOn(pnlRigidityStt_3);
          LaunchStep_SetOn(pnlLaunchStep_3_RigidityStt);
        end
        else PrelaunchCheckFailed(pnlRigidityStt_3);

        tmrPrelaunchCheck_3.Enabled := False;
        LaunchReady_On(3);
      end;
    tmr_FULL_OPEN:
      begin
        if C802Manager.Missile3.FFullOpen then
        begin
          PrelaunchCheckOn(pnlFullOpen_3);
          LaunchStep_SetOn(pnlLaunchStep_3_FullOpen);
        end
        else begin
          PrelaunchCheckFailed(pnlFullOpen_3);
          btnCover_3Click(Sender);
        end;

        tmrPrelaunchCheck_3.Enabled := False;
        LaunchReady_On(3);
      end;
    tmr_BOOSTER_ARM:
      begin
        if C802Manager.Missile3.FBoosterArm then
        begin
          PrelaunchCheckOn(pnlBoosterArm_3);
          LaunchStep_SetOn(pnlLaunchStep_3_BoosterArm);
        end
        else PrelaunchCheckFailed(pnlBoosterArm_3);

        tmrPrelaunchCheck_3.Enabled := False;
        LaunchReady_On(3);
      end;
    tmr_LAUNCH_READY:
      begin
        if C802Manager.Missile3.FLaunchReady then
        begin
          PrelaunchCheckOn(pnlLaunchReady_3);
          PanelAtas.setImplicit(3,5,True);
        end
        else PrelaunchCheckFailed(pnlLaunchReady_3);

        pnlLabel_MisStep_3.Caption  := 'Launch Ready';
        tmrPrelaunchCheck_3.Enabled := False;
      end;
    tmr_LAUNCH_BUTT:
      begin
        if C802Manager.Missile3.FLaunchButton then
        begin
          PrelaunchCheckOn(pnlLaunchButton_3);
          LaunchStep_SetOn(pnlLaunchStep_3_LaunchButton);
        end
        else begin
          PrelaunchCheckOn(pnlLaunchButton_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_LaunchButton);
          isLaunched3 := False;
        end;

        pnlLabel_MisStep_3.Caption  := 'Battery Act';
      end;
    tmr_BATT_ACT:
      begin
        if C802Manager.Missile3.FBatteryAct then
        begin
          PrelaunchCheckOn(pnlBatteryAct_3);
          LaunchStep_SetOn(pnlLaunchStep_3_BatteryAct);
        end
        else begin
          PrelaunchCheckFailed(pnlBatteryAct_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_BatteryAct);
          isLaunched3 := False;
        end;

        pnlLabel_MisStep_3.Caption  := 'Power Switch';
      end;
    tmr_POWER_SWITCH:
      begin
        if C802Manager.Missile3.FPowerSwitch then
        begin
          PrelaunchCheckOn(pnlPowerSwitch_3);
          LaunchStep_SetOn(pnlLaunchStep_3_PowerSwitch);
        end
        else begin
          PrelaunchCheckFailed(pnlPowerSwitch_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_PowerSwitch);
          isLaunched3 := False;
        end;

        pnlLabel_MisStep_3.Caption  := 'Gyro Uncaged';
      end;
    tmr_GYRO_UNCAGED:
      begin
        if C802Manager.Missile3.FGyroUncaged then
        begin
          PrelaunchCheckOn(pnlGyroUncaged_3);
          LaunchStep_SetOn(pnlLaunchStep_3_GyroUncage);
        end
        else begin
          PrelaunchCheckFailed(pnlGyroUncaged_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_GyroUncage);
          isLaunched3 := False;
        end;

        pnlLabel_MisStep_3.Caption  := 'Ignition';
      end;
    tmr_IGNITION:
      begin
        if C802Manager.Missile3.FIgnition then
        begin
          PrelaunchCheckOn(pnlIgnition_3);
          LaunchStep_SetOn(pnlLaunchStep_3_Ignition);
        end
        else begin
          PrelaunchCheckFailed(pnlIgnition_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_Ignition);
          isLaunched3 := False;
        end;

        pnlLabel_MisState_3.Font.Color := clBlack;
        pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Take Off';
        pnlLabel_MisStep_3.Caption  := 'Take Off';
      end;
    tmr_TAKE_OFF:
      begin
        if {C802Manager.Missile3.FTakeOff and} isLaunched3 and isNormal3 then
        begin
          PrelaunchCheckOn(pnlTakeOff_3);
          LaunchStep_SetOn(pnlLaunchStep_3_TakeOff);
          Mis_OnLaunch(3);
          pnlLabel_MisState_3.Font.Color := clBlack;
          pnlLabel_MisState_3.Caption := 'M. No. 3: C802 NoMis';
          pnlLabel_MisStep_3.Caption  := '-';
        end
        else begin
          PrelaunchCheckFailed(pnlTakeOff_3);
          LaunchStep_SetFailed(pnlLaunchStep_3_TakeOff);
        end;

        tmrPrelaunchCheck_3.Enabled := False;

        {Clear Status Missile}
      end;
  end;
end;

procedure TPanelBawah.tmrPrelaunchCheck_4Timer(Sender: TObject);
begin
  Prelaunch_count4  := Prelaunch_count4 + 1;

  case Prelaunch_count4 of
    tmr_INIT_STATE:
      begin
        isNormal4 := True;
        if C802Manager.Missile4.FInitState then
          PrelaunchCheckOn(pnlInitState_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlInitState_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'Power Supply';
      end;
    tmr_POWER_SUPPLY:
      begin
        if C802Manager.Missile4.FPowerSupply then
          PrelaunchCheckOn(pnlPowerSupply_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlPowerSupply_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'TurnOn Equips';
      end;
    tmr_TURNON_EQUIP:
      begin
        if C802Manager.Missile4.FTurnOnEquip then
          PrelaunchCheckOn(pnlTurnOnEquip_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlTurnOnEquip_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'CtrlS1,4 Stg1';
      end;
    Round((tmr_CHECK_STAGE_1-tmr_TURNON_EQUIP)/2)+tmr_TURNON_EQUIP:
        pnlLabel_MisStep_4.Caption  := 'CtrlS2,3 Stg1';
    tmr_CHECK_STAGE_1:
      begin
        if C802Manager.Missile4.FCheckStage1 then
          PrelaunchCheckOn(pnlCheckStage1_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlCheckStage1_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'CtrlSf1 Stg2';
      end;
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_4.Caption  := 'CtrlSf3 Stg2';
    Round((tmr_ANGLE_SET-tmr_CHECK_STAGE_1)*2/3)+tmr_CHECK_STAGE_1:
        pnlLabel_MisStep_4.Caption  := 'Transmt Anttn';
    tmr_ANGLE_SET:
      begin
        if C802Manager.Missile4.FAngleSet then
          PrelaunchCheckOn(pnlAngleSet_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlAngleSet_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'CtrlS2,4 Stg2';
      end;
    Round((tmr_COCHECK-tmr_ANGLE_SET)/2)+tmr_ANGLE_SET:
        pnlLabel_MisStep_4.Caption  := 'CtrlS1,3 Stg2';
    tmr_COCHECK:
      begin
        if C802Manager.Missile4.FCoCheck then
          PrelaunchCheckOn(pnlCoCheck_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlCoCheck_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'Tzk setting';
      end;
    tmr_TZK_SETTING:
      begin
        if C802Manager.Missile4.FTzkSetting then
          PrelaunchCheckOn(pnlTzkSetting_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlTzkSetting_4);
        end;

        pnlLabel_MisStep_4.Caption  := 'Command No.3';
      end;
    tmr_COMMAND_NO_3:
      begin
        if C802Manager.Missile4.FCommandNo3 then
          PrelaunchCheckOn(pnlCommandNo3_4)
        else begin
          isNormal4 := False;
          PrelaunchCheckFailed(pnlCommandNo3_4);
        end;
      end;
    tmr_MIS_NORMAL:
      begin
        if {C802Manager.Missile4.FMisNormal and} isNormal4 then
        begin
          PrelaunchCheckOn(pnlMisNormal_4);
          PanelAtas.setImplicit(4,2,True);
          PanelAtas.setImplicit(4,3,True);
          PanelAtas.setImplicit(4,4,True);
          pnlLabel_MisState_4.Font.Color := clBlack;
          pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Normal';
          pnlLabel_MisStep_4.Caption  := 'Mis Normal';
        end
        else begin
          PrelaunchCheckFailed(pnlMisNormal_4);
          pnlLabel_MisState_4.Font.Color := clRed;
          pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Failure';
          pnlLabel_MisStep_4.Caption  := '';
        end;

        tmrPrelaunchCheck_4.Enabled := False;
      end;
    tmr_ACC_CALC:
      begin
        if C802Manager.Missile4.FAccurateCal then
        begin
          PrelaunchCheckOn(pnlAccurateCal_4);
          LaunchStep_SetOn(pnlLaunchStep_4_AccurateCal);
        end
        else PrelaunchCheckFailed(pnlAccurateCal_4);
      end;
    tmr_INSIDE_SECT:
      begin
        if C802Manager.Missile4.FInsideSectr then
        begin
          PrelaunchCheckOn(pnlInsideSectr_4);
          LaunchStep_SetOn(pnlLaunchStep_4_InsideSector);
        end
        else PrelaunchCheckFailed(pnlInsideSectr_4);

        tmrPrelaunchCheck_4.Enabled := False;
        LaunchReady_On(4);
      end;
    tmr_LIMITER_OUT:
      begin
        if C802Manager.Missile4.FLimiterOut then
        begin
          PrelaunchCheckOn(pnlLimiterOut_4);
          LaunchStep_SetOn(pnlLaunchStep_4_LimiterOut);
          PanelAtas.setImplicit(4,1,True);
        end
        else PrelaunchCheckFailed(pnlLimiterOut_4);
      end;
    tmr_RIG_STT:
      begin
        if C802Manager.Missile4.FRigidityStt then
        begin
          PrelaunchCheckOn(pnlRigidityStt_4);
          LaunchStep_SetOn(pnlLaunchStep_4_RigidityStt);
        end
        else PrelaunchCheckFailed(pnlRigidityStt_4);

        tmrPrelaunchCheck_4.Enabled := False;
        LaunchReady_On(4);
      end;
    tmr_FULL_OPEN:
      begin
        if C802Manager.Missile4.FFullOpen then
        begin
          PrelaunchCheckOn(pnlFullOpen_4);
          LaunchStep_SetOn(pnlLaunchStep_4_FullOpen);
        end
        else begin
          PrelaunchCheckFailed(pnlFullOpen_4);
          btnCover_4Click(Sender);
        end;

        tmrPrelaunchCheck_4.Enabled := False;
        LaunchReady_On(4);
      end;
    tmr_BOOSTER_ARM:
      begin
        if C802Manager.Missile4.FBoosterArm then
        begin
          PrelaunchCheckOn(pnlBoosterArm_4);
          LaunchStep_SetOn(pnlLaunchStep_4_BoosterArm);
        end
        else PrelaunchCheckFailed(pnlBoosterArm_4);

        tmrPrelaunchCheck_4.Enabled := False;
        LaunchReady_On(4);
      end;
    tmr_LAUNCH_READY:
      begin
        if C802Manager.Missile4.FLaunchReady then
        begin
          PrelaunchCheckOn(pnlLaunchReady_4);
          PanelAtas.setImplicit(4,5,True);
        end
        else PrelaunchCheckFailed(pnlLaunchReady_4);

        pnlLabel_MisStep_4.Caption  := 'Launch Ready';
        tmrPrelaunchCheck_4.Enabled := False;
      end;
    tmr_LAUNCH_BUTT:
      begin
        if C802Manager.Missile4.FLaunchButton then
        begin
          PrelaunchCheckOn(pnlLaunchButton_4);
          LaunchStep_SetOn(pnlLaunchStep_4_LaunchButton);
        end
        else begin
          PrelaunchCheckOn(pnlLaunchButton_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_LaunchButton);
          isLaunched4 := False;
        end;

        pnlLabel_MisStep_4.Caption  := 'Battery Act';
      end;
    tmr_BATT_ACT:
      begin
        if C802Manager.Missile4.FBatteryAct then
        begin
          PrelaunchCheckOn(pnlBatteryAct_4);
          LaunchStep_SetOn(pnlLaunchStep_4_BatteryAct);
        end
        else begin
          PrelaunchCheckFailed(pnlBatteryAct_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_BatteryAct);
          isLaunched4 := False;
        end;

        pnlLabel_MisStep_4.Caption  := 'Power Switch';
      end;
    tmr_POWER_SWITCH:
      begin
        if C802Manager.Missile4.FPowerSwitch then
        begin
          PrelaunchCheckOn(pnlPowerSwitch_4);
          LaunchStep_SetOn(pnlLaunchStep_4_PowerSwitch);
        end
        else begin
          PrelaunchCheckFailed(pnlPowerSwitch_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_PowerSwitch);
          isLaunched4 := False;
        end;

        pnlLabel_MisStep_4.Caption  := 'Gyro Uncaged';
      end;
    tmr_GYRO_UNCAGED:
      begin
        if C802Manager.Missile4.FGyroUncaged then
        begin
          PrelaunchCheckOn(pnlGyroUncaged_4);
          LaunchStep_SetOn(pnlLaunchStep_4_GyroUncage);
        end
        else begin
          PrelaunchCheckFailed(pnlGyroUncaged_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_GyroUncage);
          isLaunched4 := False;
        end;

        pnlLabel_MisStep_4.Caption  := 'Ignition';
      end;
    tmr_IGNITION:
      begin
        if C802Manager.Missile4.FIgnition then
        begin
          PrelaunchCheckOn(pnlIgnition_4);
          LaunchStep_SetOn(pnlLaunchStep_4_Ignition);
        end
        else begin
          PrelaunchCheckFailed(pnlIgnition_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_Ignition);
          isLaunched4 := False;
        end;

        pnlLabel_MisState_4.Font.Color := clBlack;
        pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Take Off';
        pnlLabel_MisStep_4.Caption  := 'Take Off';
      end;
    tmr_TAKE_OFF:
      begin
        if {C802Manager.Missile4.FTakeOff and} isLaunched4 and isNormal4 then
        begin
          PrelaunchCheckOn(pnlTakeOff_4);
          LaunchStep_SetOn(pnlLaunchStep_4_TakeOff);
          Mis_OnLaunch(4);
          pnlLabel_MisState_4.Font.Color := clBlack;
          pnlLabel_MisState_4.Caption := 'M. No. 4: C802 NoMis';
          pnlLabel_MisStep_4.Caption  := '-';
        end
        else begin
          PrelaunchCheckFailed(pnlTakeOff_4);
          LaunchStep_SetFailed(pnlLaunchStep_4_TakeOff);
        end;

        tmrPrelaunchCheck_4.Enabled := False;

        {Clear Status Missile}
      end;
  end;
end;

procedure TPanelBawah.UpButton;
begin
  case ActivePage of
    PAGE_START:
      begin
        if StartMode_index <> 0 then
        begin
          PanelUp(StartMode_array[StartMode_index]);
          StartMode_index := StartMode_index - 1;
          PanelDown(StartMode_array[StartMode_index]);
        end;
      end;
    PAGE_STATUS:
      begin

      end;
    PAGE_MCONTROL:
      begin
        if MControl_index <> 0 then
        begin
          PanelUp(MControl_array[MControl_index,0]);
          PanelEditOff(MControl_array[MControl_index,1]);
          MControl_index := MControl_index - 1;
          PanelDown(MControl_array[MControl_index,0]);
          PanelEditOn(MControl_array[MControl_index,1]);
        end;
      end;
    PAGE_PARSETTING:
      begin
        if ParSetting_index <> 0 then
        begin
          PanelUp(TPanel(ParSetting_array[ParSetting_index,0]));
          ParSetting_index := ParSetting_index - 1;
          PanelDown(TPanel(ParSetting_array[ParSetting_index,0]));
          TGroupBox(ParSetting_array[ParSetting_index,1]).BringToFront;
        end;
      end;
    PAGE_PARSETTING_FIREPWR..PAGE_PARSETTING_QUEST:
      begin
        if ParSet_Menu_index <> 0 then
        begin
          PanelEditOff(ParSet_Menu_array[ParSet_Menu_index]);
          ParSet_Menu_index := ParSet_Menu_index - 1;
          PanelEditOn(ParSet_Menu_array[ParSet_Menu_index]);
        end;
      end;
    PAGE_RECORDDATA:
      begin

      end;
    PAGE_LOGOFF:
      begin

      end;
    PAGE_CHECK:
      begin
        tmrCheckPage.Enabled := False;

        lblNameCheckPg.Caption := '';
        lblContainCheckPg.Caption := '';
        if CheckPage_index <> 0 then
        begin
          PanelUp(TPanel(CheckPage_array[CheckPage_index]));
          CheckPage_index := CheckPage_index - 1;
          PanelDown(TPanel(CheckPage_array[CheckPage_index]));
        end;
      end;
  end;
end;

procedure TPanelBawah.DownButton;
var tab_visible : Integer;
begin
  case ActivePage of
    PAGE_START:
      begin
        if StartMode_index <> 2 then
        begin
          PanelUp(StartMode_array[StartMode_index]);
          StartMode_index := StartMode_index + 1;
          PanelDown(StartMode_array[StartMode_index]);
        end;
      end;
    PAGE_STATUS:
      begin

      end;
    PAGE_MCONTROL:
      begin
        if MControl_index <> 2 then
        begin
          PanelUp(MControl_array[MControl_index,0]);
          PanelEditOff(MControl_array[MControl_index,1]);
          MControl_index := MControl_index + 1;
          PanelDown(MControl_array[MControl_index,0]);
          PanelEditOn(MControl_array[MControl_index,1]);
        end;
      end;
    PAGE_PARSETTING:
      begin
        if StartMode_index = 0 then tab_visible := 5;
        if StartMode_index = 1 then tab_visible := 7;

        if ParSetting_index <> tab_visible then
        begin
          PanelUp(TPanel(ParSetting_array[ParSetting_index,0]));
          ParSetting_index := ParSetting_index + 1;
          PanelDown(TPanel(ParSetting_array[ParSetting_index,0]));
          TGroupBox(ParSetting_array[ParSetting_index,1]).BringToFront;
        end;
      end;
    PAGE_PARSETTING_FIREPWR..PAGE_PARSETTING_QUEST:
      begin
        if ParSet_Menu_index <> Length(ParSet_Menu_array)-1 then
        begin
          PanelEditOff(ParSet_Menu_array[ParSet_Menu_index]);
          ParSet_Menu_index := ParSet_Menu_index + 1;
          PanelEditOn(ParSet_Menu_array[ParSet_Menu_index]);
        end;
      end;
    PAGE_RECORDDATA:
      begin

      end;
    PAGE_LOGOFF:
      begin

      end;
    PAGE_CHECK:
      begin
        tmrCheckPage.Enabled := False;

        lblNameCheckPg.Caption := '';
        lblContainCheckPg.Caption := '';
        if CheckPage_index <> Length(CheckPage_array)-1 then
        begin
          PanelUp(TPanel(CheckPage_array[CheckPage_index]));
          CheckPage_index := CheckPage_index + 1;
          PanelDown(TPanel(CheckPage_array[CheckPage_index]));
        end;
      end;
  end;
end;

procedure TPanelBawah.vrtryswtchRigidCloseC_1Change(Sender: TObject);
begin
  case vrtryswtchRigidCloseC_1.SwitchPosition of
    0: C802Manager.SendEvenC802(41,0,0,0);
//    1:
    2:
      begin
        Prelaunch_count1 := tmr_INSIDE_SECT;
        tmrPrelaunchCheck_1.Enabled := True;
        {standalone}
//        C802Manager.Missile1.FLimiterOut := True;
//        C802Manager.Missile1.FRigidityStt := True;
        C802Manager.SendEvenC802(37,0,0,0);
      end;
//    3:
  end;
//  LaunchReady_On(1);
end;

procedure TPanelBawah.vrtryswtchRigidCloseC_2Change(Sender: TObject);
begin
  case vrtryswtchRigidCloseC_2.SwitchPosition of
    0: C802Manager.SendEvenC802(42,0,0,0);
//    1:
    2:
      begin
        Prelaunch_count2 := tmr_INSIDE_SECT;
        tmrPrelaunchCheck_2.Enabled := True;
        {standalone}
//        C802Manager.Missile2.FLimiterOut := True;
//        C802Manager.Missile2.FRigidityStt := True;
        C802Manager.SendEvenC802(38,0,0,0);
      end;
//    3:
  end;
//  LaunchReady_On(2);
end;

procedure TPanelBawah.vrtryswtchRigidCloseC_3Change(Sender: TObject);
begin
  case vrtryswtchRigidCloseC_3.SwitchPosition of
    0: C802Manager.SendEvenC802(43,0,0,0);
//    1:
    2:
      begin
        Prelaunch_count3 := tmr_INSIDE_SECT;
        tmrPrelaunchCheck_3.Enabled := True;
        {standalone}
//        C802Manager.Missile3.FLimiterOut := True;
//        C802Manager.Missile3.FRigidityStt := True;
        C802Manager.SendEvenC802(39,0,0,0);
      end;
//    3:
  end;
//  LaunchReady_On(3);
end;

procedure TPanelBawah.vrtryswtchRigidCloseC_4Change(Sender: TObject);
begin
  case vrtryswtchRigidCloseC_4.SwitchPosition of
    0:
      begin
        {standalone}
//        C802Manager.Missile4.FLimiterOut := False;
//        C802Manager.Missile4.FRigidityStt := False;
//        PrelaunchCheckFailed(pnlLimiterOut_4);
//        PrelaunchCheckFailed(pnlRigidityStt_4);
//
//        LaunchReady_On(4);

         C802Manager.SendEvenC802(44,0,0,0);
      end;
//    1:
    2:
      begin
        Prelaunch_count4 := tmr_INSIDE_SECT;
        tmrPrelaunchCheck_4.Enabled := True;
        {standalone}
//        C802Manager.Missile4.FLimiterOut := True;
//        C802Manager.Missile4.FRigidityStt := True;

        C802Manager.SendEvenC802(40,0,0,0);
      end;
//    3:
  end;
//  LaunchReady_On(4);
end;

procedure TPanelBawah.PanelUp(panel: TPanel);
begin
  panel.BevelOuter := bvRaised;
  panel.Font.Color := clWindowText;
end;

procedure TPanelBawah.PanelDown(panel: TPanel);
begin
  panel.BevelOuter := bvLowered;
  panel.Font.Color := clBlue;
end;

procedure TPanelBawah.PanelEditOn(panel: TPanel);
begin
  panel.Color := clBlue;
  panel.Font.Color  := clBlack;
  ActivePanel := panel;
  {
  if ActivePanel = pnlTargetSet_1_Number then
    Data802.TgtNo := StrToInt(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_1_Distance then
    Data802.Dis := strtofloat(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_1_Azimuth then
    Data802.Azm := strtofloat(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_1_Speed then
    Data802.Spd := StrToFloat(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_1_Course then
    Data802.Cou := StrToFloat(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_2_Long then
    Data802.Long := StrToFloat(ActivePanel.Caption)
  else if ActivePanel = pnlTargetSet_2_Lat then
    Data802.Lat := StrToFloat(ActivePanel.Caption);

  //jika simulasi update simulasi object position
  CalculateSimPos;  }
end;

procedure TPanelBawah.PanelEditOff(panel: TPanel);
begin
  panel.Color := clBlack;
  panel.Font.Color  := clWhite;
  ActivePanel := nil;
end;

procedure TPanelBawah.FormCreate(Sender: TObject);
begin
  C802Manager := TC802Manager.Create;
  Data802 := TC802_Object.Create;
  MapC802.DoubleBuffered := true;
  FCanvas := TCanvas.Create;
  EventForm := TEventForm.Create;

  Target1.Azimuth := 1000;
  Target1.Speed  := 1000;
  Target1.Course := 1000;
  Target1.Longitude := 1000;
  Target1.Latitude := 1000;

  Target2.Azimuth := 1000;
  Target2.Speed  := 1000;
  Target2.Course := 1000;
  Target2.Longitude := 1000;
  Target2.Latitude := 1000;

  Launcher1OnFromInstruktur := false;
  Launcher2OnFromInstruktur := false;
  Launcher3OnFromInstruktur := false;
  Launcher4OnFromInstruktur := false;

end;

procedure TPanelBawah.FormDestroy(Sender: TObject);
begin
  Data802.Free;
  FCanvas.Free;
  EventForm.Free;
  C802Manager.Free;
//  if Assigned(SimTarget1Draw) then
//    SimTarget1Draw.Free;
end;

procedure TPanelBawah.FormShow(Sender: TObject);
begin
  pnlHIDE.Visible        := False;
  pnlStatusPage.Visible  := False;
  grpStartPage.Visible   := False;
  grpCheckPage.Visible   := False;

  grpStartPage.BringToFront;
//pnlStatusPage.BringToFront;
//grpCheckPage.BringToFront;
  StartMode_array[0] := pnlCombat;
  StartMode_array[1] := pnlSimulate;
  StartMode_array[2] := pnlCheck;
  StartMode_index := 0;
  PanelDown(StartMode_array[StartMode_index]);

  Prelaunch_count1  := tmr_START;
  Prelaunch_count2  := tmr_START;
  Prelaunch_count3  := tmr_START;
  Prelaunch_count4  := tmr_START;
  CheckPage_counter := 0;

  MControl_array[0,0] := pnlPrecheck_MControl_Button;
  MControl_array[0,1] := pnlPrecheck_MControl;
  MControl_array[1,0] := pnlRecheck_MControl_Button;
  MControl_array[1,1] := pnlRecheck_MControl;
  MControl_array[2,0] := pnlPowerOff_MControl_Button;
  MControl_array[2,1] := pnlPowerOff_MControl;
  MControl_index  := 0;
  PanelDown(MControl_array[MControl_index,0]);

  ParSetting_array[0,0] := TPanel(pnlFirePwr_Dist);
  ParSetting_array[0,1] := TGroupBox(grpFirePwr_Dist);
  ParSetting_array[1,0] := TPanel(pnlAttack_Mode);
  ParSetting_array[1,1] := TGroupBox(grpAttack_Mode);
  ParSetting_array[2,0] := TPanel(pnlTargetSet_1);
  ParSetting_array[2,1] := TGroupBox(grpTargetSet_1);
  ParSetting_array[3,0] := TPanel(pnlTargetSet_2);
  ParSetting_array[3,1] := TGroupBox(grpTargetSet_2);
  ParSetting_array[4,0] := TPanel(pnlGPS_para);
  ParSetting_array[4,1] := TGroupBox(grpGPS_para);
  ParSetting_array[5,0] := TPanel(pnlMete_para);
  ParSetting_array[5,1] := TGroupBox(grpMete_para);
  ParSetting_array[6,0] := TPanel(pnlGyro_para);
  ParSetting_array[6,1] := TGroupBox(grpGPS_para);
  ParSetting_array[7,0] := TPanel(pnlQuestions);
  ParSetting_array[7,1] := TGroupBox(grpMete_para);
  ParSetting_index  := 0;
  ParSet_Menu_index := 0;
  PanelDown(TPanel(ParSetting_array[ParSetting_index,0]));
  TGroupBox(ParSetting_array[ParSetting_index,1]).BringToFront;

  CheckPage_array[0] := TPanel(pnlCheckPg_Intf);
  CheckPage_array[1] := TPanel(pnlCheckPg_Stab);
  CheckPage_array[2] := TPanel(pnlCheckPg_Port);
  CheckPage_array[3] := TPanel(pnlCheckPg_No1);
  CheckPage_array[4] := TPanel(pnlCheckPg_No2);
  CheckPage_array[5] := TPanel(pnlCheckPg_No3);
  CheckPage_array[6] := TPanel(pnlCheckPg_No4);
  CheckPage_index := 0;
  PanelDown(TPanel(CheckPage_array[CheckPage_index]));

  { BOOSTER }
  C802Manager.Missile1.FBoosterState := BOOSTER_SAFE;
  C802Manager.Missile2.FBoosterState := BOOSTER_SAFE;
  C802Manager.Missile3.FBoosterState := BOOSTER_SAFE;
  C802Manager.Missile4.FBoosterState := BOOSTER_SAFE;
end;

procedure TPanelBawah.EnterButton;
var count: Integer;
    tgtno: Integer;
    data: TC802_Object;
    state: Boolean;
    float_random: Single;
    int_random: Integer;
begin
  case ActivePage of
    PAGE_START:
      begin
        case StartMode_index of
          0:
            begin
              pnlGyro_para.Visible  := False;
              pnlQuestions.Visible  := False;
              grpStartPage.Visible  := False;
              if PanelAtas.Power_Switch then
                pnlStatusPage.Visible := True
              else
               pnlStatusPage.Visible := False;

              pnlStatusPage.BringToFront;
              PgCtrlMainMenu.Pages[0].Show;
              ActivePage := PAGE_STATUS;
            end;
          1:
            begin
              pnlGyro_para.Visible  := True;
              pnlQuestions.Visible  := True;
              grpStartPage.Visible  := False;
              if PanelAtas.Power_Switch then
                pnlStatusPage.Visible := True
              else
               pnlStatusPage.Visible := False;

              pnlStatusPage.BringToFront;
              PgCtrlMainMenu.Pages[0].Show;
              ActivePage := PAGE_STATUS;
            end;
          2:
            begin
              grpStartPage.Visible := False;
              if PanelAtas.Power_Switch then
                grpCheckPage.Visible := True
              else
                grpCheckPage.Visible := False;

              grpCheckPage.BringToFront;
              ActivePage := PAGE_CHECK;
            end;
        end;

      end;
    PAGE_STATUS:
      begin

      end;
    PAGE_MCONTROL:
      begin
        case MControl_index of
          0,1:
            begin
              TryStrToInt(ActivePanel.Caption,count);
              case count of
                1:
                  if C802Manager.Missile1.FPWRtoM and not tmrPrelaunchCheck_1.Enabled then
                  begin
                    pnlLabel_MisState_1.Font.Color := clBlack;
                    pnlLabel_MisState_1.Caption := 'M. No. 1: C802 PLCheck';
                    pnlLabel_MisStep_1.Caption  := 'Init State';
                    Prelaunch_count1  := tmr_START;
                    tmrPrelaunchCheck_1.Enabled := True;
                  end;
                2:
                  if C802Manager.Missile2.FPWRtoM and not tmrPrelaunchCheck_2.Enabled then
                  begin
                    pnlLabel_MisState_2.Font.Color := clBlack;
                    pnlLabel_MisState_2.Caption := 'M. No. 2: C802 PLCheck';
                    pnlLabel_MisStep_2.Caption  := 'Init State';
                    Prelaunch_count2  := tmr_START;
                    tmrPrelaunchCheck_2.Enabled := True;
                  end;
                3:
                  if C802Manager.Missile3.FPWRtoM and not tmrPrelaunchCheck_3.Enabled then
                  begin
                    pnlLabel_MisState_3.Font.Color := clBlack;
                    pnlLabel_MisState_3.Caption := 'M. No. 3: C802 PLCheck';
                    pnlLabel_MisStep_3.Caption  := 'Init State';
                    Prelaunch_count3  := tmr_START;
                    tmrPrelaunchCheck_3.Enabled := True;
                  end;
                4:
                  if C802Manager.Missile4.FPWRtoM and not tmrPrelaunchCheck_4.Enabled then
                  begin
                    pnlLabel_MisState_4.Font.Color := clBlack;
                    pnlLabel_MisState_4.Caption := 'M. No. 4: C802 PLCheck';
                    pnlLabel_MisStep_4.Caption  := 'Init State';
                    Prelaunch_count4  := tmr_START;
                    tmrPrelaunchCheck_4.Enabled := True;
                  end;
              end;

              if MControl_index = 0 then
                C802Manager.SendEvenC802(12,count,0,0)
              else if MControl_index = 1 then
                C802Manager.SendEvenC802(13,count,0,0);

            end;
          2:
            begin
              TryStrToInt(ActivePanel.Caption,count);
              case count of
                1:
                  begin
                    PrelaunchCheckOff(pnlInitState_1);
                    PrelaunchCheckOff(pnlPowerSupply_1);
                    PrelaunchCheckOff(pnlTurnOnEquip_1);
                    PrelaunchCheckOff(pnlCheckStage1_1);
                    PrelaunchCheckOff(pnlAngleSet_1);
                    PrelaunchCheckOff(pnlCoCheck_1);
                    PrelaunchCheckOff(pnlTzkSetting_1);
                    PrelaunchCheckOff(pnlCommandNo3_1);
                    PrelaunchCheckOff(pnlMisNormal_1);
                    PrelaunchCheckOff(pnlAccurateCal_1);
                    PrelaunchCheckOff(pnlInsideSectr_1);
                    pnlLabel_MisState_1.Font.Color := clBlack;
                    pnlLabel_MisState_1.Caption := 'M. No. 1: C802 Unknown';
                    pnlLabel_MisStep_1.Caption  := 'Power On Ready';
                  end;
                2:
                  begin
                    PrelaunchCheckOff(pnlInitState_2);
                    PrelaunchCheckOff(pnlPowerSupply_2);
                    PrelaunchCheckOff(pnlTurnOnEquip_2);
                    PrelaunchCheckOff(pnlCheckStage1_2);
                    PrelaunchCheckOff(pnlAngleSet_2);
                    PrelaunchCheckOff(pnlCoCheck_2);
                    PrelaunchCheckOff(pnlTzkSetting_2);
                    PrelaunchCheckOff(pnlCommandNo3_2);
                    PrelaunchCheckOff(pnlMisNormal_2);
                    PrelaunchCheckOff(pnlAccurateCal_2);
                    PrelaunchCheckOff(pnlInsideSectr_2);
                    pnlLabel_MisState_2.Font.Color := clBlack;
                    pnlLabel_MisState_2.Caption := 'M. No. 2: C802 Unknown';
                    pnlLabel_MisStep_2.Caption  := 'Power On Ready';
                  end;
                3:
                  begin
                    PrelaunchCheckOff(pnlInitState_3);
                    PrelaunchCheckOff(pnlPowerSupply_3);
                    PrelaunchCheckOff(pnlTurnOnEquip_3);
                    PrelaunchCheckOff(pnlCheckStage1_3);
                    PrelaunchCheckOff(pnlAngleSet_3);
                    PrelaunchCheckOff(pnlCoCheck_3);
                    PrelaunchCheckOff(pnlTzkSetting_3);
                    PrelaunchCheckOff(pnlCommandNo3_3);
                    PrelaunchCheckOff(pnlMisNormal_3);
                    PrelaunchCheckOff(pnlAccurateCal_3);
                    PrelaunchCheckOff(pnlInsideSectr_3);
                    pnlLabel_MisState_3.Font.Color := clBlack;
                    pnlLabel_MisState_3.Caption := 'M. No. 3: C802 Unknown';
                    pnlLabel_MisStep_3.Caption  := 'Power On Ready';
                  end;
                4:
                  begin
                    PrelaunchCheckOff(pnlInitState_4);
                    PrelaunchCheckOff(pnlPowerSupply_4);
                    PrelaunchCheckOff(pnlTurnOnEquip_4);
                    PrelaunchCheckOff(pnlCheckStage1_4);
                    PrelaunchCheckOff(pnlAngleSet_4);
                    PrelaunchCheckOff(pnlCoCheck_4);
                    PrelaunchCheckOff(pnlTzkSetting_4);
                    PrelaunchCheckOff(pnlCommandNo3_4);
                    PrelaunchCheckOff(pnlMisNormal_4);
                    PrelaunchCheckOff(pnlAccurateCal_4);
                    PrelaunchCheckOff(pnlInsideSectr_4);
                    pnlLabel_MisState_4.Font.Color := clBlack;
                    pnlLabel_MisState_4.Caption := 'M. No. 4: C802 Unknown';
                    pnlLabel_MisStep_4.Caption  := 'Power On Ready';
                  end;
              end;
            end;
        end;
      end;
    PAGE_PARSETTING:
      begin
        case ParSetting_index of
          0:
            begin
              ActivePage := PAGE_PARSETTING_FIREPWR;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,2);
              ParSet_Menu_array[0] := pnlFirePwr_Dist_Target1;
              ParSet_Menu_array[1] := pnlFirePwr_Dist_Target2;

            end;
          1:
            begin
              ActivePage := PAGE_PARSETTING_ATTACK;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,2);
              ParSet_Menu_array[0] := pnlAttack_Mode_Tgt1;
              ParSet_Menu_array[1] := pnlAttack_Mode_Tgt2;

            end;
          2:
            begin
              ActivePage := PAGE_PARSETTING_TGTSET1;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,5);
              ParSet_Menu_array[0] := pnlTargetSet_1_Number;
              ParSet_Menu_array[1] := pnlTargetSet_1_Distance;
              ParSet_Menu_array[2] := pnlTargetSet_1_Azimuth;
              ParSet_Menu_array[3] := pnlTargetSet_1_Speed;
              ParSet_Menu_array[4] := pnlTargetSet_1_Course;

            end;
          3:
            begin
              ActivePage := PAGE_PARSETTING_TGTSET2;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,3);
              ParSet_Menu_array[0] := pnlTargetSet_2_Number;
              ParSet_Menu_array[1] := pnlTargetSet_2_Long;
              ParSet_Menu_array[2] := pnlTargetSet_2_Lat;

            end;
          4:
            begin
              ActivePage := PAGE_PARSETTING_GPSPARA;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,3);
              ParSet_Menu_array[0] := pnlGPS_para_OwnLong;
              ParSet_Menu_array[1] := pnlGPS_para_OwnLat;
              ParSet_Menu_array[2] := pnlGPS_para_OwnSpd;

            end;
          5:
            begin
              ActivePage := PAGE_PARSETTING_METEPARA;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,3);
              ParSet_Menu_array[0] := pnlMete_para_WindSpd;
              ParSet_Menu_array[1] := pnlMete_para_WindDir;
              ParSet_Menu_array[2] := pnlMete_para_Temp;

            end;
          6:
            begin
              ActivePage := PAGE_PARSETTING_GYROPARA;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,3);
              ParSet_Menu_array[0] := pnlGyro_para_OwnHdg;
              ParSet_Menu_array[1] := pnlGyro_para_Pitch;
              ParSet_Menu_array[2] := pnlGyro_para_Roll;

            end;
          7:
            begin
              ActivePage := PAGE_PARSETTING_QUEST;
              ParSet_Menu_index := 0;
              SetLength(ParSet_Menu_array,1);
              ParSet_Menu_array[0] := pnlQuestion_No;

            end;
        end;
        PanelEditOn(ParSet_Menu_array[ParSet_Menu_index]);
      end;
    PAGE_PARSETTING_FIREPWR:
      begin
        count := 0;
        if (ActivePanel = pnlFirePwr_Dist_Target1) then
        begin
          TryStrToInt(pnlFirePwr_Dist_Target1.Caption,count);
          Target1.Mis_No := count;

          if (Target1.Distance/1000 >= 120) or (Target1.Distance/1000 <= 8) then
            state := False
          else
          begin
            if (Target1.Azimuth < 300) and (Target1.Azimuth > 240) and
                    ((Target1.Mis_No = 2) or (Target1.Mis_No = 4)) then
              state := True
            else if (Target1.Azimuth < 120) and (Target1.Azimuth > 60) and
                    ((Target1.Mis_No = 1) or (Target1.Mis_No = 3))  then
              state := True
            else state := False;
          end;

          tgtno := Target1.Number;

          C802Manager.SendEvenC802(35,count,0,0);
        end
        else if (ActivePanel = pnlFirePwr_Dist_Target2) then
        begin
          TryStrToInt(pnlFirePwr_Dist_Target2.Caption,count);
          Target2.Mis_No := count;

          if (Target2.Distance/1000 >= 120) or (Target2.Distance/1000 <= 8) then
            state := False
          else
          begin
            if (Target2.Azimuth < 300) and (Target2.Azimuth > 240) and
                    ((Target2.Mis_No = 2) or (Target2.Mis_No = 4)) then
              state := True
            else if (Target2.Azimuth < 120) and (Target2.Azimuth > 60) and
                    ((Target2.Mis_No = 1) or (Target2.Mis_No = 3))  then
              state := True
            else state := False;
          end;

          tgtno := Target2.Number;

          C802Manager.SendEvenC802(36,count,0,0);
        end;

        case count of
          1:
            if not tmrPrelaunchCheck_1.Enabled then begin
              C802Manager.Missile1.TgtNo := tgtno;
              C802Manager.Missile1.FAccurateCal := state;
              C802Manager.Missile1.FInsideSectr := state;
              Prelaunch_count1  := tmr_MIS_NORMAL;
              tmrPrelaunchCheck_1.Enabled := True;
            end;
          2:
            if not tmrPrelaunchCheck_2.Enabled then begin
              C802Manager.Missile2.TgtNo := tgtno;
              C802Manager.Missile2.FAccurateCal := state;
              C802Manager.Missile2.FInsideSectr := state;
              Prelaunch_count2  := tmr_MIS_NORMAL;
              tmrPrelaunchCheck_2.Enabled := True;
            end;
          3:
            if not tmrPrelaunchCheck_3.Enabled then begin
              C802Manager.Missile3.TgtNo := tgtno;
              C802Manager.Missile3.FAccurateCal := state;
              C802Manager.Missile3.FInsideSectr := state;
              Prelaunch_count3  := tmr_MIS_NORMAL;
              tmrPrelaunchCheck_3.Enabled := True;
            end;
          4:
            if not tmrPrelaunchCheck_4.Enabled then begin
              C802Manager.Missile4.TgtNo := tgtno;
              C802Manager.Missile4.FAccurateCal := state;
              C802Manager.Missile4.FInsideSectr := state;
              Prelaunch_count4  := tmr_MIS_NORMAL;
              tmrPrelaunchCheck_4.Enabled := True;
            end;
        end;
      end;
    PAGE_PARSETTING_ATTACK:
      begin
        count := 0;
        if (ActivePanel = pnlAttack_Mode_Tgt1) then
        begin
          TryStrToInt(pnlAttack_Mode_Tgt1.Caption,count);
          Target1.Mode := count;
          C802Manager.SendEvenC802(15,count,0,0);
        end
        else if (ActivePanel = pnlAttack_Mode_Tgt2) then
        begin
          TryStrToInt(pnlAttack_Mode_Tgt2.Caption,count);
          Target2.Mode := count;
          C802Manager.SendEvenC802(16,count,0,0);
        end;
      end;
    PAGE_PARSETTING_TGTSET1:
      with Target1 do begin
        if ActivePanel = pnlTargetSet_1_Number then
        begin
          Number := StrToInt(pnlTargetSet_1_Number.Caption);
          C802Manager.SendEvenC802(17,Number,0,0);
        end
        else if ActivePanel = pnlTargetSet_1_Distance then
        begin
          Distance := StrToFloat(pnlTargetSet_1_Distance.Caption) * 1000;
          C802Manager.SendEvenC802(18,Distance,0,0);
        end
        else if ActivePanel = pnlTargetSet_1_Azimuth then
        begin
          Azimuth := StrToFloat(pnlTargetSet_1_Azimuth.Caption) - C802Manager.xShip.Heading;
           if Azimuth < 0 then
             Azimuth := 360 + Azimuth;

          C802Manager.SendEvenC802(19,Azimuth,0,0);
        end
        else if ActivePanel = pnlTargetSet_1_Speed then
        begin
          Speed := StrToFloat(pnlTargetSet_1_Speed.Caption) * c_knot_to_ms;
          C802Manager.SendEvenC802(20,Speed,0,0);
        end
        else if ActivePanel = pnlTargetSet_1_Course then
        begin
          Course := StrToFloat(pnlTargetSet_1_Course.Caption);
          C802Manager.SendEvenC802(21,Course,0,0);
        end;
        if (Distance >= 10000) and (Distance <= 15000) then
          Hooming_Range := 5000
        else if (Distance > 15000) and (Distance <= 25000) then
          Hooming_Range := 9000
        else if (Distance > 25000) then
          Hooming_Range := 13000;

        if Hooming_Range <> 0 then
          pnlRzd_1.Caption := FloatToStr(Hooming_Range/1000);

        if (Speed <> 0) and (Hooming_Range <> 0) then
        begin
          Self_Time := (Distance - Hooming_Range) / Speed;
          pnlTzk_1.Caption := FormatFloat('0.00', Self_Time);

          int_random := Random(2);
          float_random := Random;
          Psiq := int_random + float_random;
          pnlPsiq_1.Caption := FormatFloat('0.00', Psiq);

          int_random := Random(2);
          float_random := Random;
          SitaZ := 14 + int_random + float_random;
          pnlSitaZ_1.Caption := FormatFloat('0.00', SitaZ);

          int_random := Random(2);
          float_random := Random;
          GamaZ := int_random + float_random;
          pnlGamaZ_1.Caption := FormatFloat('0.00', GamaZ);
        end;

        ActivePanel.Color := clWhite;
        ActivePanel.Font.Color := clBlack;

        //jika simulasi update simulasi object position
        CalculateSimPos;

      end;
    PAGE_PARSETTING_TGTSET2:
      begin
        if ActivePanel = pnlTargetSet_2_Number then
        begin
          Target2.Number := StrToInt(pnlTargetSet_2_Number.Caption);
          ActivePanel.Color := clWhite;
          ActivePanel.Font.Color := clBlack;
          C802Manager.SendEvenC802(22,Target2.Number,0,0);
        end
        else begin
          if ActivePanel = pnlTargetSet_2_Long then
          begin
            long_tgt2 := 1000;
            TryStrToFloat(pnlTargetSet_2_Long.Caption, long_tgt2);
            if long_tgt2 <> 1000 then
            begin
              ActivePanel.Color := clWhite;
              ActivePanel.Font.Color := clBlack;
              Target2.Longitude := long_tgt2;
            end;
            C802Manager.SendEvenC802(23,Target2.Longitude,0,0);
          end
          else if ActivePanel = pnlTargetSet_2_Lat then
          begin
            lat_tgt2 := 1000;
            TryStrToFloat(pnlTargetSet_2_Lat.Caption, lat_tgt2);
            if lat_tgt2 <> 1000 then
            begin
              ActivePanel.Color := clWhite;
              ActivePanel.Font.Color := clBlack;
              Target2.Latitude := lat_tgt2;
            end;
            C802Manager.SendEvenC802(23,Target2.Latitude,0,0);
          end;

          if (pnlTargetSet_2_Long.Caption <> '') and (pnlTargetSet_2_Lat.Caption <> '') then
          begin
            Target2.Distance := CalcRange(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY, long_tgt2, lat_tgt2)*1000;
            Target2.Azimuth := CalcBearing(C802Manager.xShip.PositionX, C802Manager.xShip.PositionY, long_tgt2, lat_tgt2);

            Target2.Azimuth := Target2.Azimuth - C802Manager.xShip.Heading;
           if Target2.Azimuth < 0 then
             Target2.Azimuth := 360 + Target2.Azimuth;
          end;
        end;
      end;
    PAGE_PARSETTING_GPSPARA:
      begin

      end;
    PAGE_PARSETTING_METEPARA:
      begin
        if ActivePanel = pnlMete_para_WindSpd then
        begin
          C802Manager.Wind_Spd := StrToFloat(pnlMete_para_WindSpd.Caption);
          C802Manager.SendEvenC802(28,C802Manager.Wind_Spd,0,0);
        end
        else if ActivePanel = pnlMete_para_WindDir then
        begin
          C802Manager.Wind_Dir := StrToFloat(pnlMete_para_WindDir.Caption);
          C802Manager.SendEvenC802(29,C802Manager.Wind_Dir,0,0);
        end
        else if ActivePanel = pnlMete_para_Temp then
        begin
          C802Manager.Temp := StrToFloat(pnlMete_para_Temp.Caption);
          C802Manager.SendEvenC802(30,C802Manager.Temp,0,0);
        end;

        ActivePanel.Color := clWhite;
        ActivePanel.Font.Color := clBlack;
      end;
    PAGE_PARSETTING_GYROPARA:
      begin

      end;
    PAGE_PARSETTING_QUEST:
      begin

      end;
    PAGE_RECORDDATA:
      begin
        try
          count := StrToInt(pnlRecordData_No.Caption);
          case count of
            1: data := C802Manager.Missile1;
            2: data := C802Manager.Missile2;
            3: data := C802Manager.Missile3;
            4: data := C802Manager.Missile4;
          end;

          C802Manager.SendEvenC802(65,count,0,0);

          pnlRecDataNo.Caption  := IntToStr(count) + '         ';
          pnlRecDataTgtNo.Caption := IntToStr(data.TgtNo) + '         ';
          pnlRecDataDis.Caption   := FormatFloat('0.000',data.Dis/1000) + ' km   ';
          pnlRecDataAzm.Caption   := FormatFloat('0.000',data.Azm) + ' °      ';
          pnlRecDataSpd.Caption   := FormatFloat('0.000',data.Spd) + ' kn    ';
          pnlRecDataCou.Caption   := FormatFloat('0.000',data.Cou) + ' °      ';
          pnlRecDataRzd.Caption   := FormatFloat('0.000',data.Rzd/1000) + ' km   ';
          pnlRecDataTzk.Caption   := FormatFloat('0.000',data.Tzk) + ' s      ';
          pnlRecDataPsiq.Caption  := FormatFloat('0.000',data.Psiq) + ' °      ';
          pnlRecDataSitaZ.Caption := FormatFloat('0.000',data.SitaZ) + ' °      ';
          pnlRecDataGamaZ.Caption := FormatFloat('0.000',data.GamaZ) + ' °      ';

          pnlRecDataTime.Caption  := FormatDateTime('hh:mm:nn',data.Time) + '         ';
          pnlRecDataLong.Caption  := FormatFloat('0.000',data.Long) + ' °      ';
          pnlRecDataLat.Caption   := FormatFloat('0.000',data.Lat) + ' °      ';
          pnlRecDataOwnSpd.Caption := FormatFloat('0.000',data.OwnSpd) + ' kn    ';
          pnlRecDataOwnHdg.Caption := FormatFloat('0.000',data.OwnHdg) + ' °      ';
          pnlRecDataPitch.Caption := FormatFloat('0.000',data.Pitch) + ' °      ';
          pnlRecDataRoll.Caption  := FormatFloat('0.000',data.Roll) + ' °      ';
          pnlRecDataTzkFB.Caption := FormatFloat('0.000',data.TzkFB) + ' s      ';
          pnlRecDataWndSpd.Caption := FormatFloat('0.000',data.WndSpd)+ ' m/s ';
          pnlRecDataWndDir.Caption := FormatFloat('0.000',data.WndDir) + ' °      ';
          pnlRecDataTemp.Caption  := FormatFloat('0.000',data.Temp) + ' °C    ';

        finally

        end;

      end;
    PAGE_LOGOFF:
      begin
        pnlStatusPage.Visible  := False;
        grpCheckPage.Visible   := False;
        grpStartPage.Visible   := True;
        ActivePage := PAGE_START;

        PanelUp(StartMode_array[0]);
        PanelUp(StartMode_array[1]);
        PanelUp(StartMode_array[2]);
        PanelDown(StartMode_array[StartMode_index]);

        C802Manager.SendEvenC802(66,0,0,0);
      end;
    PAGE_CHECK:
      begin
        case CheckPage_index of
          0:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for interface:';
              lblContainCheckPg.Font.Color := clYellow;
              lblContainCheckPg.Caption := 'HbM-3507 board....................................Checking';
              tmrCheckPage.Enabled  := True;
            end;
          1:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for staboard:';
            end;
          2:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for port:';
            end;
          3:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for no.1:';
            end;
          4:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for no.2:';
            end;
          5:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for no.3:';
            end;
          6:
            begin
              lblNameCheckPg.Caption := 'HbM-3507 board for no.4:';
            end;
        end;
      end;
  end;
end;

procedure TPanelBawah.UpdateTargetAssign1;
var
  miss_selected : TC802_Object;
  v_random : Single;
begin
  if StartMode_index = SM_SIMULATE then
  begin
    if Assigned(Data802) then
    begin
      if Data802.TgtNo <> 0 then
        pnlTgtNo_1.Caption := IntToStr(Data802.TgtNo);

      if Data802.Dis <> 0 then
        pnlDis_1.Caption := FloatToStr(Data802.Dis/1000);

      if Data802.Azm <> 0 then
        pnlAzm_1.Caption := FloatToStr(Data802.Azm);

      if Data802.Spd <> 0 then
        pnlSpd_1.Caption := FloatToStr(Data802.Spd * C_Ms_To_knot);

      if Data802.Cou <> 0 then
        pnlCou_1.Caption := FloatToStr(Data802.Cou);

      if Data802.Mode <> 0 then
      begin
        case Data802.Mode of
          1: pnlMode_1.Caption := 'LPM1';
          2: pnlMode_1.Caption := 'LPM2';
          3: pnlMode_1.Caption := 'PPM';
        end;
      end;
    end;

  end
  else if StartMode_index = SM_COMBAT then
  begin
    with Target1 do begin
      if Number <> 0 then
          pnlTgtNo_1.Caption := IntToStr(Number);

      if Distance <> 0 then
        pnlDis_1.Caption := FormatFloat('0.00',Distance/1000);

      if Azimuth <> 1000 then
        pnlAzm_1.Caption := FormatFloat('0',Azimuth);

      if Speed <> 1000 then
        pnlSpd_1.Caption := FormatFloat('0.00',Speed * C_Ms_To_knot);

      if Course <> 1000 then
        pnlCou_1.Caption := FormatFloat('0',Course);

      if Mode <> 0 then
      begin
        case Mode of
          1: pnlMode_1.Caption := 'LPM1';
          2: pnlMode_1.Caption := 'LPM2';
          3: pnlMode_1.Caption := 'PPM';
        end;
      end;

      if Mis_No <> 0 then
        pnlM_No_1.Caption := IntToStr(Mis_No);

      if Hooming_Range <> 0 then
        pnlRzd_1.Caption := FloatToStr(Hooming_Range/1000);

      if Self_Time <> 0 then
        pnlTzk_1.Caption := FormatFloat('0.00',Self_Time);

//      if Target1.Longitude <> 1000 then
//        pnlLongtitude.Caption := FormatFloat('0.00000',Target1.Longitude);
//
//      if Target1.Latitude <> 1000 then
//        pnlLatitude.Caption := FormatFloat('0.00000',Target1.Latitude)
    end;
  end;

end;

procedure TPanelBawah.UpdateTargetAssign2;
begin
  if StartMode_index = SM_COMBAT then
  begin
    with Target2 do begin
      if Number <> 0 then
          pnlTgtNo_2.Caption := IntToStr(Number);

      if Distance <> 0 then
        pnlDis_2.Caption := FormatFloat('0.00',Distance/1000);

      if Azimuth <> 1000 then
        pnlAzm_2.Caption := FormatFloat('0',Azimuth);

      if Speed <> 1000 then
        pnlSpd_2.Caption := FormatFloat('0.00',Speed * C_Ms_To_knot);

      if Course <> 1000 then
        pnlCou_2.Caption := FormatFloat('0',Course);

      if Mode <> 0 then
      begin
        case Mode of
          1: pnlMode_2.Caption := 'LPM1';
          2: pnlMode_2.Caption := 'LPM2';
          3: pnlMode_2.Caption := 'PPM';
        end;
      end;

      if Mis_No <> 0 then
        pnlM_No_2.Caption := IntToStr(Mis_No);

      if Hooming_Range <> 0 then
        pnlRzd_2.Caption := FloatToStr(Hooming_Range/1000);

      if Self_Time <> 0 then
        pnlTzk_2.Caption := FormatFloat('0.00',Self_Time);

//      if Target1.Longitude <> 1000 then
//        pnlLongtitude.Caption := FloatToStr(Target1.Longitude);
//
//      if Target1.Latitude <> 1000 then
//        pnlLatitude.Caption := FloatToStr((Target1.Latitude))
    end;
  end;

end;

procedure TPanelBawah.CreateSimulationObject;
begin
  {Create target Object yg akan digambar posisi awal di xship}
  SimTarget1Draw := TClientObject.Create;
  SimTarget1Draw.PositionX := C802Manager.xShip.PositionX;
  SimTarget1Draw.PositionY := C802Manager.xShip.PositionY;

  C802Manager.MainObjList.AddObject(SimTarget1Draw);
end;

procedure TPanelBawah.CalculateSimPos;
var
  pts, ptt : t2DPoint;
begin
  if StartMode_index = SM_SIMULATE then
    begin
      if ((Data802.Long <> 112.0) and (Data802.Lat <> -9.2)) then    {jika tidak sama dengan default}
      begin
        SimTarget1Draw.PositionX := Data802.Long;
        SimTarget1Draw.PositionY := Data802.Lat;
      end
      else if (Data802.Azm <> 0) and (Data802.Dis <> 0) then {jika tidak sama dengan default}
      begin
        pts.X := C802Manager.xShip.PositionX;
        pts.Y := C802Manager.xShip.PositionY;
        ptt := CalcPositionAhead(pts, Data802.Dis * C_KiloMeter_To_NauticalMiles, Data802.Azm);
        SimTarget1Draw.PositionX := ptt.X;
        SimTarget1Draw.PositionY := ptt.Y;
      end;
      {kalkulasi}

    end;
end;

function TPanelBawah.CloseCurrentHandleApplication(
  ExeFileName: string): Integer;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
        OpenProcess(PROCESS_TERMINATE,
        BOOL(0),
        FProcessEntry32.th32ProcessID),
        0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function TPanelBawah.GetAssignedTargetIns1 : TClientObject;
begin
  Result := ListAssignedObjects[0];
end;

function TPanelBawah.GetAssignedTargetIns2 : TClientObject;
begin
  Result := ListAssignedObjects[1];
end;
end.
