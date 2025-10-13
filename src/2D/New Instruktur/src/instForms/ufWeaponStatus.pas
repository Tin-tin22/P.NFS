unit ufWeaponStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TFlatButtonUnit, Buttons, ExtCtrls, Menus,

  uInstrukturManager, uInstrukturObjects, uTCPDatatype,  uBaseConstan, uBridgeSet,
  uWeaponGetDetail, RzGroupBar, uClassDatabase ;

type
  TfWeaponStatus = class(TFrame)
    pnlWeaponStatus: TPanel;
    scrlbxC802: TScrollBox;
    Bevel2: TBevel;
    Label9: TLabel;
    grpAssignC802: TGroupBox;
    btnC802Track: TSpeedButton;
    edtC802Track: TEdit;
    btnC802Assign: TButton;
    btnC802DeAssign: TButton;
    scrlbxTOCOSExocet40: TScrollBox;
    lbl24: TLabel;
    bvl2: TBevel;
    grpAssignExocetMM40: TGroupBox;
    btnExocetMM40Track: TSpeedButton;
    edtExocetMM40Track: TEdit;
    btnExocetMM40Assign: TButton;
    btnExocetMM40DeAssign: TButton;
    scrlbxMistral: TScrollBox;
    lbl1: TLabel;
    bvl7: TBevel;
    scrlbxTOCOSMOC: TScrollBox;
    lbl4: TLabel;
    bvl11: TBevel;
    lbl5: TLabel;
    grp1: TGroupBox;
    chkMocMW08: TCheckBox;
    chkMocRadarAPPA: TCheckBox;
    chkMocLirodMK2: TCheckBox;
    chkMocKingklip: TCheckBox;
    scrlbxRBU: TScrollBox;
    lbl23: TLabel;
    bvl1: TBevel;
    btnRBUTrack: TSpeedButton;
    btnRBUAssign: TButton;
    edtRBUTrackLabel: TEdit;
    btnRbuDeAssign: TButton;
    scrlbxSPS: TScrollBox;
    lblNameSPS: TLabel;
    bvlSPS: TBevel;
    edtSPSTrackLabel: TEdit;
    btnSPSAssign: TButton;
    btnSPSDeAssisgn: TButton;
    scrlbxStrela: TScrollBox;
    Label2: TLabel;
    Bevel3: TBevel;
    scrlbxTetral: TScrollBox;
    Label3: TLabel;
    Bevel4: TBevel;
    grpTetral: TGroupBox;
    btnTetralTrack: TSpeedButton;
    edtTetralTrack: TEdit;
    btnTetralAssign: TButton;
    btnTetralDeAssign: TButton;
    ScrlbxTOCOS: TScrollBox;
    Bevel1: TBevel;
    lbl25: TLabel;
    lbl26: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label7: TLabel;
    bvl6: TBevel;
    cbbTOCOSTempWEC: TCheckBox;
    cbbTOCOSFuseWEC: TCheckBox;
    cbbTOCOSFuseTCC: TCheckBox;
    cbbTOCOSPwrRstWEC: TCheckBox;
    cbbTOCOSPwrRstTCC: TCheckBox;
    cbbTOCOSCMPTR: TCheckBox;
    cbbTOCOSSOFTTW: TCheckBox;
    cbbTOCOSNUG1: TCheckBox;
    cbbTOCOSNUG2: TCheckBox;
    cbbTOCOSAntiCondensHeating: TCheckBox;
    cbbTOCOSLoadProgram: TCheckBox;
    cbbTOCOSPortInP: TCheckBox;
    cbbTOCOSStbInP: TCheckBox;
    cbbTOCOSPort120: TCheckBox;
    cbbTOCOSStb120: TCheckBox;
    cbbTOCOSPort20: TCheckBox;
    cbbTOCOSStb20: TCheckBox;
    cbbTOCOSPortDoorOpen: TCheckBox;
    cbbTOCOSStbDoorOpen: TCheckBox;
    cbbTOCOSPortTorpOpen: TCheckBox;
    cbbTOCOSStbTorpOpen: TCheckBox;
    cbbTOCOSPortRtoFire: TCheckBox;
    cbbTOCOSStbRtoFire: TCheckBox;
    cbbTOCOSExtStabAvl: TCheckBox;
    cbbTOCOSCasAblAvl: TCheckBox;
    cbbTOCOSTempTEC: TCheckBox;
    cbbTOCOSPortSupply: TCheckBox;
    cbbTOCOSStbSupply: TCheckBox;
    scrlbxWCC: TScrollBox;
    pnlWCCIner: TPanel;
    bvl3: TBevel;
    lbl27: TLabel;
    chk36: TCheckBox;
    chk58: TCheckBox;
    chk80: TCheckBox;
    chk81: TCheckBox;
    chk82: TCheckBox;
    chk83: TCheckBox;
    chk84: TCheckBox;
    scrlbxYakhont: TScrollBox;
    lblYakhontStatus: TLabel;
    bvl4: TBevel;
    grpAssignYahkont: TGroupBox;
    btnYAKHONTTrack: TSpeedButton;
    edtYAKHONTTtrack: TEdit;
    btnYAKHONTAssign: TButton;
    btnYAKHONTDeAssign: TButton;
    scrlbxASROC: TScrollBox;
    lbl16: TLabel;
    bvlASROC: TBevel;
    pnlAssignAsroc: TPanel;
    btnASROCTrack: TSpeedButton;
    lblAssignAsroc: TLabel;
    edtASROCAssign1FC: TEdit;
    btnASROCAssign1FC: TButton;
    btnASROCDeAssign1FC: TButton;
    pmSPSGyroVal: TPopupMenu;
    Normal1: TMenuItem;
    ooLongGyroCagingTime1: TMenuItem;
    GyroStartingOverloaded1: TMenuItem;
    ooLongGyroStarting1: TMenuItem;
    NoLinkWithTIU1: TMenuItem;
    pmSPSTIUPort: TPopupMenu;
    Normal4: TMenuItem;
    Faulty1: TMenuItem;
    lowVoltage1: TMenuItem;
    NoLink1: TMenuItem;
    pmSPSTIUStarBoard: TPopupMenu;
    Normal3: TMenuItem;
    Faulty2: TMenuItem;
    LowVoltage2: TMenuItem;
    NoLink2: TMenuItem;
    pmSPSBarrelValue: TPopupMenu;
    Normal2: TMenuItem;
    UntimelyStartingTime1: TMenuItem;
    BarrelNoLongerReady1: TMenuItem;
    AbsenceOfGyro1: TMenuItem;
    ErrorWritingTorpedo1: TMenuItem;
    ExerciseHeadNotStart1: TMenuItem;
    orpedoNotLeaveBarrelinFire1: TMenuItem;
    GroupBox1: TGroupBox;
    AssignRBU6000: TGroupBox;
    bvl12: TBevel;
    btnSPS115Loading: TButton;
    grpLauncher1Yakhont: TGroupBox;
    grpLauncher4Yakhont: TGroupBox;
    bvl13: TBevel;
    grpLauncher1SPS: TGroupBox;
    grpLauncher2SPS: TGroupBox;
    imgLoadSPS1: TImage;
    imgLoadYakhont1: TImage;
    grp4: TGroupBox;
    lbl79: TLabel;
    chkRBUAlirKapal: TCheckBox;
    chkRBU_Unformer1Left: TCheckBox;
    lbl28: TLabel;
    lbl29: TLabel;
    chkRBU_Unformer2Left: TCheckBox;
    lbl30: TLabel;
    chkRBU_Unformer1Right: TCheckBox;
    lbl31: TLabel;
    chkRBU_Unformer2Right: TCheckBox;
    grp5: TGroupBox;
    grp2: TGroupBox;
    lbl55: TLabel;
    lbl56: TLabel;
    lbl57: TLabel;
    lbl58: TLabel;
    lbl59: TLabel;
    lbl60: TLabel;
    lbl61: TLabel;
    lbl62: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    lbl65: TLabel;
    lbl66: TLabel;
    imgRBU1Load1: TImage;
    imgRBU1Load4: TImage;
    imgRBU1Load7: TImage;
    imgRBU1Load2: TImage;
    imgRBU1Load5: TImage;
    imgRBU1Load8: TImage;
    imgRBU1Load10: TImage;
    imgRBU1Load11: TImage;
    imgRBU1Load3: TImage;
    imgRBU1Load6: TImage;
    imgRBU1Load9: TImage;
    imgRBU1Load12: TImage;
    grp3: TGroupBox;
    lbl67: TLabel;
    lbl68: TLabel;
    lbl69: TLabel;
    lbl70: TLabel;
    lbl71: TLabel;
    lbl72: TLabel;
    lbl73: TLabel;
    lbl74: TLabel;
    lbl75: TLabel;
    lbl76: TLabel;
    lbl77: TLabel;
    lbl78: TLabel;
    imgRBU2Load1: TImage;
    imgRBU2Load2: TImage;
    imgRBU2Load3: TImage;
    imgRBU2Load4: TImage;
    imgRBU2Load5: TImage;
    imgRBU2Load6: TImage;
    imgRBU2Load7: TImage;
    imgRBU2Load8: TImage;
    imgRBU2Load9: TImage;
    imgRBU2Load10: TImage;
    imgRBU2Load11: TImage;
    imgRBU2Load12: TImage;
    btn7: TButton;
    btn8: TButton;
    grp6: TGroupBox;
    lbl17: TLabel;
    chkASROCHydr: TCheckBox;
    lbl18: TLabel;
    chkASROCLauncher: TCheckBox;
    lbl19: TLabel;
    chkASROCLauncherSync: TCheckBox;
    lbl20: TLabel;
    chkASROCRocket1: TCheckBox;
    lbl21: TLabel;
    chkASROCRocket2: TCheckBox;
    grp7: TGroupBox;
    grpLauncher1Asroc: TGroupBox;
    imgLoadAsrock: TImage;
    btnAsrocLoading: TButton;
    grp8: TGroupBox;
    imgLoadC802_1: TImage;
    imgLoadC802_2: TImage;
    imgC802_3: TImage;
    imgC802_4: TImage;
    lbl80: TLabel;
    lbl81: TLabel;
    lbl82: TLabel;
    lbl83: TLabel;
    btn9: TButton;
    grp9: TGroupBox;
    grpC802Launcher1: TGroupBox;
    chkC802PrelaunchCheck1: TCheckBox;
    chkC802LaunchReadyCondition1: TCheckBox;
    chkC802Launch1: TCheckBox;
    grpC802Launcher2: TGroupBox;
    chkC802PrelaunchCheck2: TCheckBox;
    chkC802LaunchReadyCondition2: TCheckBox;
    chkC802Launch2: TCheckBox;
    grpC802Launcher3: TGroupBox;
    chkC802PrelaunchCheck3: TCheckBox;
    chkC802LaunchReadyCondition3: TCheckBox;
    chkC802Launch3: TCheckBox;
    grpC802Launcher4: TGroupBox;
    chkC802PrelaunchCheck4: TCheckBox;
    chkC802LaunchReadyCondition4: TCheckBox;
    chkC802Launch4: TCheckBox;
    imgLoadYakhont2: TImage;
    imgLoadYakhont3: TImage;
    imgLoadYakhont4: TImage;
    btnYakhontLoading4: TButton;
    lbl84: TLabel;
    lbl85: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    chkYakhont_Printer: TCheckBox;
    chkYakhontConsoleN1: TCheckBox;
    chkYakhontConsoleN2: TCheckBox;
    chkYakhontLauncherR1: TCheckBox;
    chkYakhontLauncherR3: TCheckBox;
    chkYakhontLauncherL2: TCheckBox;
    chkYakhontLauncherL4: TCheckBox;
    chkYakhontKR231: TCheckBox;
    chkYakhontGyro: TCheckBox;
    chkYakhontINS300V: TCheckBox;
    chkYakhontINS27V: TCheckBox;
    grp10: TGroupBox;
    grpRightLauncherExocet: TGroupBox;
    imgLoadExoRight1: TImage;
    imgLoadExoRight2: TImage;
    btnExocet40Loading2: TButton;
    grpRightLauncherExocet2: TGroupBox;
    imgLoadExoLeft1: TImage;
    imgLoadExoLeft2: TImage;
    btn2Exocet40Loading2: TButton;
    grp11: TGroupBox;
    chkExocet40: TCheckBox;
    lbl88: TLabel;
    lbl89: TLabel;
    lbl90: TLabel;
    lbl91: TLabel;
    imgLoadSPS3: TImage;
    imgLoadSPS5: TImage;
    imgLoadSPS2: TImage;
    imgLoadSPS4: TImage;
    imgLoadSPS6: TImage;
    lblMHP: TLabel;
    cbbSPSMHP: TComboBox;
    lbl6: TLabel;
    chkSPSSignal: TCheckBox;
    lbl7: TLabel;
    chkSPSNds: TCheckBox;
    lbl8: TLabel;
    edtSPSTIUPort: TEdit;
    btnSPSSelectTiuPort: TFlatButton;
    lbl9: TLabel;
    edtSPSTIUStartBoard: TEdit;
    btnSPSSelectTIUStartBoard: TFlatButton;
    lbl10: TLabel;
    chkSPSTempPort: TCheckBox;
    lbl15: TLabel;
    chkSPSTempStb: TCheckBox;
    lbl11: TLabel;
    chkSPSDegreePort: TCheckBox;
    lbl12: TLabel;
    chkSPSDegreeStarboard: TCheckBox;
    lbl13: TLabel;
    edtSPSGyroNumber: TEdit;
    btnSPSSelectGyroNumber: TFlatButton;
    edtSPSGyroval: TEdit;
    btnSPSSelectGytoVal: TFlatButton;
    lblBarrel: TLabel;
    edtSPSBarrelNumber: TEdit;
    btnSPSSelectBarrelNumber: TFlatButton;
    edtSPSBarrelVal: TEdit;
    btnSPSSelectBarrelVal: TFlatButton;
    lbl14: TLabel;
    chkSPSSelfTest: TCheckBox;
    grp13: TGroupBox;
    lbl92: TLabel;
    grp14: TGroupBox;
    grpLauncher1Tocos: TGroupBox;
    imgLoadTocos1: TImage;
    btnTocosLoading: TButton;
    grpLauncher2Tocos: TGroupBox;
    imgLoadTocos2: TImage;
    btnTocosLoading2: TButton;
    grp15: TGroupBox;
    chkTetralFwd: TCheckBox;
    chkTetralAft: TCheckBox;
    grp16: TGroupBox;
    grpLauncher1Tetral: TGroupBox;
    imgLoadFWDTet1: TImage;
    imgLoadFWDTet2: TImage;
    imgLoadFWDTet3: TImage;
    imgLoadFWDTet4: TImage;
    lbl93: TLabel;
    lbl94: TLabel;
    lbl95: TLabel;
    lbl96: TLabel;
    btnTetralLoading4: TButton;
    grpLauncher2Tetral: TGroupBox;
    imgLoadAFTTet1: TImage;
    imgLoadAFTTet2: TImage;
    imgLoadAFTTet3: TImage;
    imgLoadAFTTet4: TImage;
    lbl97: TLabel;
    lbl98: TLabel;
    lbl99: TLabel;
    lbl100: TLabel;
    btn2TetralLoading4: TButton;
    grp17: TGroupBox;
    grpRightLauncherMistral: TGroupBox;
    imgLoadMisRight1: TImage;
    imgLoadRightMis2: TImage;
    lbl101: TLabel;
    lbl102: TLabel;
    btnMistralLoading: TButton;
    grpLeftLauncherMistral: TGroupBox;
    imgLeftMis1: TImage;
    imgLeftMis2: TImage;
    lbl103: TLabel;
    lbl104: TLabel;
    btnMistralLoading2: TButton;
    grp18: TGroupBox;
    chk1: TCheckBox;
    chk2: TCheckBox;
    grp19: TGroupBox;
    grpRightLauncherStrela: TGroupBox;
    imgLoadRightStr1: TImage;
    imgLoadStrRight2: TImage;
    imgLoadStrRight3: TImage;
    imgLoadStrRight4: TImage;
    lbl105: TLabel;
    lbl106: TLabel;
    lbl107: TLabel;
    lbl108: TLabel;
    btn1: TButton;
    grpLeftLauncherStrela: TGroupBox;
    imgLoadStrLeft1: TImage;
    imgLoadStrLeft2: TImage;
    imgLoadStrLeft3: TImage;
    imgLoadStrLeft4: TImage;
    lbl109: TLabel;
    lbl110: TLabel;
    lbl111: TLabel;
    lbl112: TLabel;
    btn6: TButton;
    grp20: TGroupBox;
    chk11: TCheckBox;
    chk12: TCheckBox;
    cbbLoadC802: TComboBox;
    cbbLoadExoStarboard: TComboBox;
    cbbLoadExoPort: TComboBox;
    cbbLoadMisStarboard: TComboBox;
    cbbLoadMisPort: TComboBox;
    lbl114: TLabel;
    lbl115: TLabel;
    lbl116: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl119: TLabel;
    cbbLoadSPS: TComboBox;
    cbbLoadStrellaStarboard: TComboBox;
    cbbLoadStrellaPort: TComboBox;
    cbbLoadTetralFWD: TComboBox;
    cbbLoadTetralAFT: TComboBox;
    cbbLoadYakhont: TComboBox;
    btnSPSTrack: TSpeedButton;
    imgLoadAsrock2: TImage;
    rzgrpWeaponStatus: TRzGroupBar;
    rzgrpStrela: TRzGroup;
    rzgrpTetral: TRzGroup;
    rzgrpTocos: TRzGroup;
    rzgrpYakhont: TRzGroup;
    rzgrpC802: TRzGroup;
    rzgrpWCC: TRzGroup;
    rzgrpAsroc: TRzGroup;
    rzgrpMistral: TRzGroup;
    rzgrpRBU6000: TRzGroup;
    rzgrpSPS115: TRzGroup;
    rzgrpMOCsigma: TRzGroup;
    rzgrpExocetMM40: TRzGroup;
    rzgrpCannon76 : TRzGroup;
    pnlBlank: TPanel;
    lblMissileId: TLabel;
    lblFuze: TLabel;
    lblMissileType: TLabel;
    cbbMissileIDstatus: TComboBox;
    cbbMissileType: TComboBox;
    cbbFuzeType: TComboBox;
    lblMissile1: TLabel;
    lblMissile2: TLabel;
    chkSafetyFA: TCheckBox;
    chkControlFA: TCheckBox;
    chkCannon76: TCheckBox;
    btn2: TButton;
    tmrLoading: TTimer;
    procedure btnASROCAssign1FCClick(Sender: TObject);
    procedure btnC802AssignClick(Sender: TObject);
    procedure btnRBUAssignClick(Sender: TObject);
    procedure btnYAKHONTAssignClick(Sender: TObject);
    procedure Normal4Click(Sender: TObject);
    procedure Normal3Click(Sender: TObject);
    procedure Normal2Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure btnSPSAssignClick(Sender: TObject);
    procedure btnExocet40LoadingClick(Sender: TObject);
    procedure btnMistralLoadingClick(Sender: TObject);
    procedure btnStrelaLoadingClick(Sender: TObject);
    procedure btnTetralLoadingClick(Sender: TObject);
    procedure btnTocosLoadingClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure tmrLoadingTimer(Sender: TObject);

  private
    { Private declarations }
    { SPS }
    pmSPSGyro   : TPopupMenu;
    pmSPSBarrel : TPopupMenu;

    CountLoading   : integer;
    recSendStrella : TRec3DSetStrella;
    recSendC802    : TRecData_C802;
    recSendTetral  : TRec3DSetTetral;
    RecSendYakhont : TRecData_Yakhont;
    RecSendSPS     : TRecDataTorperdo;

    C802StatusLoad_1 : Boolean;
    C802StatusLoad_2 : Boolean;
    C802StatusLoad_3 : Boolean;
    C802StatusLoad_4 : Boolean;

    SPSStatusLoadport     : Boolean;
    SPSStatusLoadStaboard : Boolean;


    { Handle Event }
    { SPS }
    procedure SPSClickCheckBox(Sender : Tobject);
    procedure SPSbtnFlatClick(Sender : TObject);
    procedure PmGyroClick(Sender: TObject);
    procedure PmBarrelClick(Sender: TObject);

    { ASROC }
    procedure ASROCClickCheckBox(Sender : TObject);
    procedure ASROCClickRadioBtn(sender : TObject);

    { RBU }
    procedure RBUCbbClick(Sender : TObject);

    { TOCOS }
    procedure TOCOSCbbClick(Sender : Tobject);

    { Yakhont }
    procedure YakhontChkClick(Sender : TObject);

    { C802 }
    procedure C802ChkClick(Sender : TObject);

    { MOC }
    procedure MOCChkClick(sender : Tobject);

    { Tettral }
    procedure TetralChkClick(sender : Tobject);

    { Strela }
    procedure StrelaChkClick(sender : Tobject);

    { Mistral }
    procedure MistralChkClick(sender : Tobject);

    { Exocet40 }
    procedure Exocet40ChkClick(sender : TObject);

    { Cannon 76 }
    procedure Cannon76ChkClick(sender : TObject);

    { Cannon 40 }
    procedure Cannon40ChkClick(sender : TObject);

    { Cannon 57 }
    procedure Cannon57ChkClick(sender : TObject);

    procedure btnTrackObject(Sender : Tobject);
  public
    { Public declarations }
    firstCekOpenGroupBar : Boolean;
    procedure SetWeaponGroupBar;
    procedure WeaponStatusOpen (Sender: TObject);

    procedure NillAllSet;
    procedure SetHandleEvent;
    procedure ShowWeaponPanel(const WeaponName : string);
    procedure CreateSPSPopUp;

    procedure ASROCTrack(sender : TInsObject);
    procedure RBUTrack(sender : TInsObject);
    procedure SPSTrack(sender : TInsObject);
    procedure YAKHONTTrack(sender : TInsObject);
    procedure C802Track(sender : TInsObject);
    procedure LoadImageLight(Aimage: TImage; imgStat: string);
    procedure LoadingStatus(ShipID, WeaponID, LauncherID, MissileID: Byte; Status : TStatusWeapon);
    procedure LabelingAsrocMT(ShipID, WeaponID, LauncherID, MissileID : Byte; MissileType : TTypeMissileAsroc );

  end;
const
  LoadImgOff        = '..\data\images\NFS instruktur - interface\imageIns\light\GRAY.bmp';
  LoadImgLoading    = '..\data\images\NFS instruktur - interface\imageIns\light\GREEN.bmp';
  LoadImgRunning    = '..\data\images\NFS instruktur - interface\imageIns\light\RED.bmp';

  OFFLINE = 0;
  ONLINE  = 1;
  RUNNING = 2;

  tmr_STRELLA_STABOARD = 0;
  tmr_STRELLA_PORT     = 5;
  tmr_C802             = 10;
  tmr_TETRAL_FWD       = 15;
  tmr_TETRAL_AFT       = 20;
  tmr_YAKHONT          = 25;
  tmr_SPS              = 30;



var
  frmWeaponStatus : TfWeaponStatus;

implementation

uses
  ufrmMainInstruktur, ufrmGameController, uDataModule;
{$R *.dfm}

function DeleteAmpersand(Value: string): string;
var
  i: integer;
  found: Boolean;
begin
  i := -1;
  found := false;

  for i := 0 to Length(Value) - 1 do
  begin
    if Value[i] = '&' then
    begin
      found := true;
      break;
    end;
  end;

  if found then
    Delete(Value, i, 1);
  result := Value;
end;

{ TfWeaponStatus }

procedure TfWeaponStatus.NillAllSet;
begin

end;

procedure TfWeaponStatus.SetHandleEvent;
begin
  { Track Object }
  btnASROCTrack.Tag   := 1;
  btnYAKHONTTrack.Tag := 2;
  btnRBUTrack.Tag     := 3;
  btnC802Track.Tag    := 4;
  btnSPSTrack.Tag     := 5;
  btnASROCTrack.OnClick   := btnTrackObject;
  btnYAKHONTTrack.OnClick := btnTrackObject;
  btnRBUTrack.OnClick     := btnTrackObject;
  btnC802Track.OnClick    := btnTrackObject;
  btnSPSTrack.OnClick     := btnTrackObject;


  { ==============================SPS115======================== }
  { SPS115 }
  { Check Box }
  chkSPSSignal.Tag                  := 1;
  chkSPSSignal.OnClick              := SPSClickCheckBox;
  chkSPSNds.Tag                     := 2;
  chkSPSNds.OnClick                 := SPSClickCheckBox;
  chkSPSDegreePort.Tag              := 3;
  chkSPSDegreePort.OnClick          := SPSClickCheckBox;
  chkSPSDegreeStarboard.Tag         := 4;
  chkSPSDegreeStarboard.OnClick     := SPSClickCheckBox;
  chkSPSSelfTest.Tag                := 5;
  chkSPSSelfTest.OnClick            := SPSClickCheckBox;
  chkSPSTempPort.Tag                := 6;
  chkSPSTempPort.OnClick            := SPSClickCheckBox;
  chkSPSTempStb.Tag                 := 7;
  chkSPSTempStb.OnClick             := SPSClickCheckBox;
  { Button Pop Up }
  btnSPSSelectTiuPort.Tag           := 1;
  btnSPSSelectTiuPort.OnClick       := SPSbtnFlatClick;
  btnSPSSelectTIUStartBoard.Tag     := 2;
  btnSPSSelectTIUStartBoard.OnClick := SPSbtnFlatClick;
  btnSPSSelectGyroNumber.Tag        := 3;
  btnSPSSelectGyroNumber.OnClick    := SPSbtnFlatClick;
  btnSPSSelectGytoVal.Tag           := 4;
  btnSPSSelectGytoVal.OnClick       := SPSbtnFlatClick;
  btnSPSSelectBarrelNumber.Tag      := 5;
  btnSPSSelectBarrelNumber.OnClick  := SPSbtnFlatClick;
  btnSPSSelectBarrelVal.Tag         := 6;
  btnSPSSelectBarrelVal.OnClick     := SPSbtnFlatClick;

  { ============================================================ }

  { ==============================ASROC========================= }
  { ASROC }
  chkASROCHydr.Tag              := __STAT_ASROCK_HYDR;
  chkASROCHydr.OnClick          := ASROCClickCheckBox;
  chkASROCLauncher.Tag          := __STAT_ASROCK_LAUNCHER;
  chkASROCLauncher.OnClick      := ASROCClickCheckBox;
  chkASROCLauncherSync.Tag      := __STAT_ASROCK_LAUNCHER_SYNC;
  chkASROCLauncherSync.OnClick  := ASROCClickCheckBox;
  chkASROCRocket1.Tag           := __STAT_ASROCK_ROCKET1_READY;
  chkASROCRocket1.OnClick       := ASROCClickCheckBox;
  chkASROCRocket2.Tag           := __STAT_ASROCK_ROCKET2_READY;
  chkASROCRocket2.OnClick       := ASROCClickCheckBox;
//  chkAsrockAvailable.Tag        := __STAT_ASROCK_AVAILABLE_ERIKA;
//  chkAsrockAvailable.OnClick    := ASROCClickCheckBox;
//  chkAsrockSpeed.Tag            := __STAT_ASROCK_SPEED_ERIKA;
//  chkAsrockSpeed.OnClick        := ASROCClickCheckBox;
//  chkAsrockFuze.Tag             := __STAT_ASROCK_FUZE_ERIKA;
//  chkAsrockFuze.OnClick         := ASROCClickCheckBox;
//  chkAsrockAvailable2.Tag       := __STAT_ASROCK_AVAILABLE_NELLY;
//  chkAsrockAvailable2.OnClick   := ASROCClickCheckBox;
//  chkAsrockSpeed2.Tag           := __STAT_ASROCK_SPEED_NELLY;
//  chkAsrockSpeed2.OnClick       := ASROCClickCheckBox;
//  chkAsrockFuze2.Tag            := __STAT_ASROCK_FUZE_NELLY;
//  chkAsrockFuze2.OnClick        := ASROCClickCheckBox;

  //--ERIKA--
//  rbAvailableErika.Tag          := __STAT_ASROCK_AVAILABLE_ERIKA;
//  rbAvailableErika.Hint         := '1';
//  rbAvailableErika.OnClick      := ASROCClickRadioBtn;
//  rbEmptyErika.Tag              := __STAT_ASROCK_AVAILABLE_ERIKA;
//  rbEmptyErika.Hint             := '2';
//  rbEmptyErika.OnClick          := ASROCClickRadioBtn;
//  rbSpeedHighErika.Tag          := __STAT_ASROCK_SPEED_ERIKA;
//  rbSpeedHighErika.Hint         := '1';
//  rbSpeedHighErika.OnClick      := ASROCClickRadioBtn;
//  rbSpeedLowErika.Tag           := __STAT_ASROCK_SPEED_ERIKA;
//  rbSpeedLowErika.Hint          := '2';
//  rbSpeedLowErika.OnClick       := ASROCClickRadioBtn;
//  rbFuzeProxErika.Tag           := __STAT_ASROCK_FUZE_ERIKA;
//  rbFuzeProxErika.Hint          := '1';
//  rbFuzeProxErika.OnClick       := ASROCClickRadioBtn;
//  rbFuzeTimeErika.Tag           := __STAT_ASROCK_FUZE_ERIKA;
//  rbFuzeTimeErika.Hint          := '2';
//  rbFuzeTimeErika.OnClick       := ASROCClickRadioBtn;

  //--NELLY--
//  rbAvailableNelly.Tag          := __STAT_ASROCK_AVAILABLE_NELLY;
//  rbAvailableNelly.Hint         := '1';
//  rbAvailableNelly.OnClick      := ASROCClickRadioBtn;
//  rbEmptyNelly.Tag              := __STAT_ASROCK_AVAILABLE_NELLY;
//  rbEmptyNelly.Hint             := '2';
//  rbEmptyNelly.OnClick          := ASROCClickRadioBtn;
//  rbSpeedHighNelly.Tag          := __STAT_ASROCK_SPEED_NELLY;
//  rbSpeedHighNelly.Hint         := '1';
//  rbSpeedHighNelly.OnClick      := ASROCClickRadioBtn;
//  rbSpeedLowNelly.Tag           := __STAT_ASROCK_SPEED_NELLY;
//  rbSpeedLowNelly.Hint          := '2';
//  rbSpeedLowNelly.OnClick       := ASROCClickRadioBtn;
//  rbFuzeProxNelly.Tag           := __STAT_ASROCK_FUZE_NELLY;
//  rbFuzeProxNelly.Hint          := '1';
//  rbFuzeProxNelly.OnClick       := ASROCClickRadioBtn;
//  rbFuzeTimeNelly.Tag           := __STAT_ASROCK_FUZE_NELLY;
//  rbFuzeTimeNelly.Hint          := '2';
//  rbFuzeTimeNelly.OnClick       := ASROCClickRadioBtn;

  { =========================================================== }

  { ==============================RBU========================== }
  { RBU }
  chkRBUAlirKapal.Tag       := __STAT_RBU_ALIRAN_KAPAL;
  chkRBU_Unformer1Left.Tag  := __STAT_RBU_UNFORMER_I_LEFT;
  chkRBU_Unformer2Left.Tag  := __STAT_RBU_UNFORMER_II_LEFT;
  chkRBU_Unformer1Right.Tag := __STAT_RBU_UNFORMER_I_RIGHT;
  chkRBU_Unformer2Right.Tag := __STAT_RBU_UNFORMER_II_RIGHT;







  chkRBUAlirKapal.OnClick       := RBUCbbClick;
  chkRBU_Unformer1Left.OnClick  := RBUCbbClick;
  chkRBU_Unformer2Left.OnClick  := RBUCbbClick;
  chkRBU_Unformer1Right.OnClick := RBUCbbClick;
  chkRBU_Unformer2Right.OnClick := RBUCbbClick;

  { =========================================================== }

  { ==============================TOCOS======================== }
  { TOCOS }
  cbbTOCOSTempWEC.Tag                 := __STAT_TOCOS_TempWEC;
  cbbTOCOSTempWEC.OnClick             := TOCOSCbbClick;
  cbbTOCOSTempTEC.Tag                 := __STAT_TOCOS_TempTCC;
  cbbTOCOSTempTEC.OnClick             := TOCOSCbbClick;
  cbbTOCOSFuseWEC.Tag                 := __STAT_TOCOS_FuseWEC;
  cbbTOCOSFuseWEC.OnClick             := TOCOSCbbClick;
  cbbTOCOSFuseTCC.Tag                 := __STAT_TOCOS_FuseTCC;
  cbbTOCOSFuseTCC.OnClick             := TOCOSCbbClick;
  cbbTOCOSPwrRstWEC.Tag               := __STAT_TOCOS_PowerResetWEC;
  cbbTOCOSPwrRstWEC.OnClick           := TOCOSCbbClick;
  cbbTOCOSPwrRstTCC.Tag               := __STAT_TOCOS_PowerResetTCC;
  cbbTOCOSPwrRstTCC.OnClick           := TOCOSCbbClick;
  cbbTOCOSCMPTR.Tag                   := __STAT_TOCOS_CMPTR;
  cbbTOCOSCMPTR.OnClick               := TOCOSCbbClick;
  cbbTOCOSSOFTTW.Tag                  := __STAT_TOCOS_SOFTW;
  cbbTOCOSSOFTTW.OnClick              := TOCOSCbbClick;
  cbbTOCOSNUG1.Tag                    := __STAT_TOCOS_NUG_1;
  cbbTOCOSNUG1.OnClick                := TOCOSCbbClick;
  cbbTOCOSNUG2.Tag                    := __STAT_TOCOS_NUG_2;
  cbbTOCOSNUG2.OnClick                := TOCOSCbbClick;
  cbbTOCOSAntiCondensHeating.Tag      := __STAT_TOCOS_AntiCondensHeating;
  cbbTOCOSAntiCondensHeating.OnClick  := TOCOSCbbClick;
  cbbTOCOSLoadProgram.Tag             := __STAT_TOCOS_LOADPROGR;
  cbbTOCOSLoadProgram.OnClick         := TOCOSCbbClick;

  cbbTOCOSPortInP.Tag                 := __STAT_TOCOS_Port_Indikator_Port;
  cbbTOCOSPortInP.OnClick             := TOCOSCbbClick;
  cbbTOCOSStbInP.Tag                  := __STAT_TOCOS_StbPort_Indikator_Port;
  cbbTOCOSStbInP.OnClick              := TOCOSCbbClick;
  cbbTOCOSPortSupply.Tag              := __STAT_TOCOS_Port_ToSupply;
  cbbTOCOSPortSupply.OnClick          := TOCOSCbbClick;
  cbbTOCOSStbSupply.Tag               := __STAT_TOCOS_StbPort_ToSupply;
  cbbTOCOSStbSupply.OnClick           := TOCOSCbbClick;
  cbbTOCOSPort120.Tag                 := __STAT_TOCOS_Port_120_BAR;
  cbbTOCOSPort120.OnClick             := TOCOSCbbClick;
  cbbTOCOSStb120.Tag                  := __STAT_TOCOS_StbPort_120_BAR;
  cbbTOCOSStb120.OnClick              := TOCOSCbbClick;
  cbbTOCOSPort20.Tag                  := __STAT_TOCOS_Port_20_BAR;
  cbbTOCOSPort20.OnClick              := TOCOSCbbClick;
  cbbTOCOSStb20.Tag                   := __STAT_TOCOS_StbPort_20_BAR;
  cbbTOCOSStb20.OnClick               := TOCOSCbbClick;
  cbbTOCOSPortDoorOpen.Tag            := __STAT_TOCOS_Port_DOOR_Open;
  cbbTOCOSPortDoorOpen.OnClick        := TOCOSCbbClick;
  cbbTOCOSStbDoorOpen.Tag             := __STAT_TOCOS_StbPort_DOOR_Open;
  cbbTOCOSStbDoorOpen.OnClick         := TOCOSCbbClick;
  cbbTOCOSPortTorpOpen.Tag            := __STAT_TOCOS_Port_TORP_On;
  cbbTOCOSPortTorpOpen.OnClick        := TOCOSCbbClick;
  cbbTOCOSStbTorpOpen.Tag             := __STAT_TOCOS_StbPort_TORP_On;
  cbbTOCOSStbTorpOpen.OnClick         := TOCOSCbbClick;
  cbbTOCOSPortRtoFire.Tag             := __STAT_TOCOS_Port_Ready_To_Fire;
  cbbTOCOSPortRtoFire.OnClick         := TOCOSCbbClick;
  cbbTOCOSStbRtoFire.Tag              := __STAT_TOCOS_StbPort_Ready_To_Fire;
  cbbTOCOSStbRtoFire.OnClick          := TOCOSCbbClick;

  cbbTOCOSExtStabAvl.Tag              := __STAT_TOCOS_EXTSTABAVL;
  cbbTOCOSExtStabAvl.OnClick          := TOCOSCbbClick;
  cbbTOCOSCasAblAvl.Tag               := __STAT_TOCOS_CASSTABAVL;
  cbbTOCOSCasAblAvl.OnClick           := TOCOSCbbClick;
  { =========================================================== }

  { ==============================YAKHONT====================== }
  { Yakhont }
  chkYakhont_Printer.Tag    :=  __STAT_YAKHONT_PRINTER;
  chkYakhontConsoleN1.Tag   :=  __STAT_YAKHONT_CONSOLE_N1;
  chkYakhontConsoleN2.Tag   :=  __STAT_YAKHONT_CONSOLE_N2;
  chkYakhontLauncherR1.Tag  :=  __STAT_YAKHONT_RIGHT_1;
  chkYakhontLauncherR3.Tag  :=  __STAT_YAKHONT_RIGHT_3;
  chkYakhontLauncherL2.Tag  :=  __STAT_YAKHONT_LEFT_2;
  chkYakhontLauncherL4.Tag  :=  __STAT_YAKHONT_LEFT_4;
  chkYakhontKR231.Tag       :=  __STAT_YAKHONT_KR231;
  chkYakhontGyro.Tag        :=  __STAT_YAKHONT_GYRO;
  chkYakhontINS300V.Tag     :=  __STAT_YAKHONT_INS300V;
  chkYakhontINS27V.Tag      :=  __STAT_YAKHONT_INS27V;

  chkYakhont_Printer.OnClick    := YakhontChkClick;
  chkYakhontConsoleN1.OnClick   := YakhontChkClick;
  chkYakhontConsoleN2.OnClick   := YakhontChkClick;
  chkYakhontLauncherR1.OnClick  := YakhontChkClick;
  chkYakhontLauncherR3.OnClick  := YakhontChkClick;
  chkYakhontLauncherL2.OnClick  := YakhontChkClick;
  chkYakhontLauncherL4.OnClick  := YakhontChkClick;
  chkYakhontKR231.OnClick       := YakhontChkClick;
  chkYakhontGyro.OnClick        := YakhontChkClick;
  chkYakhontINS300V.OnClick     := YakhontChkClick;
  chkYakhontINS27V.OnClick      := YakhontChkClick;

  { =========================================================== }

  { ==============================C802========================= }
  { C802 }
  chkC802PreLaunchCheck1.Tag        :=  __STAT_C802_PRECHECK_LAUNCHER1;
  chkC802PreLaunchCheck2.Tag        :=  __STAT_C802_PRECHECK_LAUNCHER2;
  chkC802PreLaunchCheck3.Tag        :=  __STAT_C802_PRECHECK_LAUNCHER3;
  chkC802PreLaunchCheck4.Tag        :=  __STAT_C802_PRECHECK_LAUNCHER4;

  chkC802LaunchReadyCondition1.Tag  :=  __STAT_C802_READYCONDITION_LAUNCHER1;
  chkC802LaunchReadyCondition2.Tag  :=  __STAT_C802_READYCONDITION_LAUNCHER2;
  chkC802LaunchReadyCondition3.Tag  :=  __STAT_C802_READYCONDITION_LAUNCHER3;
  chkC802LaunchReadyCondition4.Tag  :=  __STAT_C802_READYCONDITION_LAUNCHER4;

  chkC802Launch1.Tag                :=  __STAT_C802_LAUNCH_LAUNCHER1;
  chkC802Launch2.Tag                :=  __STAT_C802_LAUNCH_LAUNCHER2;
  chkC802Launch3.Tag                :=  __STAT_C802_LAUNCH_LAUNCHER3;
  chkC802Launch4.Tag                :=  __STAT_C802_LAUNCH_LAUNCHER4;

  chkC802PreLaunchCheck1.OnClick        := C802ChkClick;
  chkC802PreLaunchCheck2.OnClick        := C802ChkClick;
  chkC802PreLaunchCheck3.OnClick        := C802ChkClick;
  chkC802PreLaunchCheck4.OnClick        := C802ChkClick;

  chkC802LaunchReadyCondition1.OnClick  := C802ChkClick;
  chkC802LaunchReadyCondition2.OnClick  := C802ChkClick;
  chkC802LaunchReadyCondition3.OnClick  := C802ChkClick;
  chkC802LaunchReadyCondition4.OnClick  := C802ChkClick;

  chkC802Launch1.OnClick                := C802ChkClick;
  chkC802Launch2.OnClick                := C802ChkClick;
  chkC802Launch3.OnClick                := C802ChkClick;
  chkC802Launch4.OnClick                := C802ChkClick;

  { =========================================================== }

  { ==============================TETRAL======================= }
  { Tetral }
  chkTetralFwd.OnClick  := TetralChkClick;
  chkTetralAft.OnClick  := TetralChkClick;

  chkTetralFwd.tag      :=__STAT_TETRAL_FWD;
  chkTetralAft.tag      :=__STAT_TETRAL_AFT;

  { =========================================================== }

  { ==============================MOC========================== }
  { SIGMA }
  chkMocMW08.OnClick      := MOCChkClick;
  chkMocRadarAPPA.OnClick := MOCChkClick;
  chkMocLirodMK2.OnClick  := MOCChkClick;
  chkMocKingklip.OnClick  := MOCChkClick;

  chkMocMW08.Tag          := __STAT_MOC_MW08;
  chkMocRadarAPPA.Tag     := __STAT_MOC_RadarARPA;
  chkMocLirodMK2.Tag      := __STAT_MOC_LIROD_MK2;
  chkMocKingklip.Tag      := __STAT_MOC_Kingklip;

  { =========================================================== }

  { ===========================EXOCET40======================== }
  { Exocet MM40}
  chkExocet40.OnClick := Exocet40ChkClick;
  chkSafetyFA.OnClick := Exocet40ChkClick;
  chkControlFA.OnClick := Exocet40ChkClick;

  chkExocet40.Tag     := __STAT_EXOCET40_ENABLE;
  chkSafetyFA.Tag     := __STAT_EXOCET40_SafetyFA;
  chkControlFA.Tag    := __STAT_EXOCET40_ControlFA;

  { =========================================================== }

  { ===========================CANNON 76 ====================== }
  { Cannon 76 }
  chkCannon76.OnClick := Cannon76ChkClick;
  chkCannon76.Tag     := __STAT_CANNON76_ENABLE;

  { =========================================================== }

  { ==========================STRELA=========================== }
  { STRELA }
//  chkStrelaLaunch1.OnClick  := StrelaChkClick;
//  chkStrelaLaunch2.OnClick  := StrelaChkClick;
//  chkStrelaLaunch3.OnClick  := StrelaChkClick;
//  chkStrelaLaunch4.OnClick  := StrelaChkClick;
//
//  chkStrelaLaunch1.tag      :=__STAT_STRELA_LAUNCER1;
//  chkStrelaLaunch2.tag      :=__STAT_STRELA_LAUNCER2;
//  chkStrelaLaunch3.tag      :=__STAT_STRELA_LAUNCER3;
//  chkStrelaLaunch4.tag      :=__STAT_STRELA_LAUNCER4;
  { =========================================================== }

  { ==========================MISTRAL=========================== }
  { Mistral }
  //chkMistralLaunch1.OnClick  := MistralChkClick;
  //chkMistralLaunc2.OnClick   := MistralChkClick;

  //chkMistralLaunch1.tag      :=__STAT_MISTRAL_LAUNCER1;
  //chkMistralLaunc2.tag       :=__STAT_MISTRAL_LAUNCER2;
  { =========================================================== }

  { ===========================CANNON 57 ====================== }
  { Cannon 57 }
 // chkCannon57enableWeaphon.OnClick := Cannon57ChkClick;
 // chkCannon57enableWeaphon.Tag     := __STAT_CANNON57_ENABLE;

  { =========================================================== }

  { ===========================CANNON 40 ====================== }
  { Cannon 40 }
  //chkCannon40EnableCannon.OnClick := Cannon40ChkClick;
  //chkCannon40EnableCannon.Tag     := __STAT_CANNON40_ENABLE;

  { =========================================================== }
end;

{ ================================================================}
{ Event Handle }
{ SPS }
procedure TfWeaponStatus.CreateSPSPopUp;
begin
  pmSPSGyro     := TPopupMenu.Create(nil);
  pmSPSBarrel   := TPopupMenu.Create(nil);
end;

procedure TfWeaponStatus.Normal2Click(Sender: TObject);
var
  i,id : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;

  TempBarrel : string;
  BarrelName : string;

  aID, aParam : Integer;
begin
  if SimManager.TrackObject = nil then exit;
  id := TMenuItem(sender).Tag;

  edtSPSBarrelVal.Text := DeleteAmpersand(TMenuItem(sender).Caption);
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        if edtSPSBarrelNumber.Text = 'Barrel 1' then
        begin
          WeaponSPS.Barrel1         := id;
          aID := __STAT_SPS_BARREL_1;
        end
        else
        if edtSPSBarrelNumber.Text = 'Barrel 2' then
        begin
          WeaponSPS.Barrel2         := id;
          aID := __STAT_SPS_BARREL_2;
        end
        else
        if edtSPSBarrelNumber.Text = 'Barrel 3' then
        begin
          WeaponSPS.Barrel3         := id;
          aID := __STAT_SPS_BARREL_3;
        end
        else
        if edtSPSBarrelNumber.Text = 'Barrel 4' then
        begin
          WeaponSPS.Barrel4         := id;
          aID := __STAT_SPS_BARREL_4;
        end
        else
        if edtSPSBarrelNumber.Text = 'Barrel 5' then
        begin
          WeaponSPS.Barrel5         := id;
          aID := __STAT_SPS_BARREL_5;
        end
        else
        if edtSPSBarrelNumber.Text = 'Barrel 6' then
        begin
          WeaponSPS.Barrel6         := id;
          aID := __STAT_SPS_BARREL_6;
        end;

        Break;
      end;
    end;
  end;

  aParam := TMenuItem(sender).Tag;
  SimManager.NetSendStatConsole(dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID) , C_DBID_TORPEDO_A244S, aID , aParam);
end;

procedure TfWeaponStatus.Normal3Click(Sender: TObject);
var
  i,id : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;
begin
  if SimManager.TrackObject = nil then exit;

  id := TMenuItem(sender).Tag;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        WeaponSPS.TIU_StarBoard := id;
        edtSPSTIUStartBoard.Text := getSPS_TIU_Stat(WeaponSPS.TIU_StarBoard);
      end;
    end;
  end;

  SimManager.NetSendStatConsole(dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID), C_DBID_TORPEDO_A244S,  104 , id);
end;

procedure TfWeaponStatus.Normal4Click(Sender: TObject);
var
  i,id : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;
begin
  if SimManager.TrackObject = nil then exit;

  id := TMenuItem(sender).Tag;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        WeaponSPS.TIU_Port := id;
        edtSPSTIUPort.Text := getSPS_TIU_Stat(WeaponSPS.TIU_Port);

        Break;
      end;
    end;
  end;

  SimManager.NetSendStatConsole(dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID), C_DBID_TORPEDO_A244S,  103 , id);
end;

procedure TfWeaponStatus.Normal1Click(Sender: TObject);
var
  i,id : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;

  TempBarrel : string;
  BarrelName : string;

  aID, aParam : Integer;
begin
  if SimManager.TrackObject = nil then exit;
  id := TMenuItem(sender).Tag;

  edtSPSGyroval.Text := DeleteAmpersand(TMenuItem(sender).Caption);
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        if edtSPSGyroNumber.Text = 'Gyro 1' then
        begin
          WeaponSPS.Gyro1         := id;
          aID := __STAT_SPS_GYRO_1;
        end
        else
        if edtSPSGyroNumber.Text = 'Gyro 2' then
        begin
          WeaponSPS.Gyro2         := id;
          aID := __STAT_SPS_GYRO_2;
        end
        else
        if edtSPSGyroNumber.Text = 'Gyro 3' then
        begin
          WeaponSPS.Gyro3         := id;
          aID := __STAT_SPS_GYRO_3;
        end
        else
        if edtSPSGyroNumber.Text = 'Gyro 4' then
        begin
          WeaponSPS.Gyro4         := id;
          aID := __STAT_SPS_GYRO_4;
        end
        else
        if edtSPSGyroNumber.Text = 'Gyro 5' then
        begin
          WeaponSPS.Gyro5         := id;
          aID := __STAT_SPS_GYRO_5;
        end
        else
        if edtSPSGyroNumber.Text = 'Gyro 6' then
        begin
          WeaponSPS.Gyro6         := id;
          aID := __STAT_SPS_GYRO_6;
        end;

        Break;
      end;
    end;
  end;

  aParam := TMenuItem(sender).Tag;
  SimManager.NetSendStatConsole(dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID) , C_DBID_TORPEDO_A244S, aID , aParam);
end;

procedure TfWeaponStatus.btnSPSAssignClick(Sender: TObject);
var
  atag : Integer;

  i, launcherID, j,
  missileID           : Integer;
  WeaponShip          : TWeaponOnShip;
  WeaponSPS           : TWeaponOn_SPS;
//  recSPS              : TRecDataTorperdo;
  isFound             : Boolean;
begin
  if SimManager.TrackObject = nil then Exit;

  SPSStatusLoadport     := false;
  SPSStatusLoadStaboard := false;

  atag := TButton(sender).Tag;

  isFound := False;

  if TComponent(Sender).Tag = 3 then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if WeaponShip is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(WeaponShip);

        RecSendSPS.ShipID         := SimManager.TrackObject.FDataBaseID;
        RecSendSPS.mWeaponID      := WeaponSPS.Weapon_ID;
        RecSendSPS.mMissileNumber := 1;
        RecSendSPS.ISC            := 0;
        RecSendSPS.ISR            := 0;
        RecSendSPS.WTR            := 0;
        RecSendSPS.CEI            := 0;
        RecSendSPS.PRG            := 0;
        RecSendSPS.DOP            := 0;
        RecSendSPS.ACE            := 0;
        RecSendSPS.FLO            := 0;
        RecSendSPS.ISD            := 0;
        RecSendSPS.ACM            := 0;
        RecSendSPS.OrderID        := _ORD_SPS_LOADING;

        if cbbLoadSPS.Text = 'All' then
        begin
          if WeaponSPS.Weapon_Launcher = 1 then
          begin
            if WeaponSPS.Weapon_Status = 1 then
            begin
              SPSStatusLoadport := True;
            end;
          end
          else if WeaponSPS.Weapon_Launcher = 2 then
          begin
            if WeaponSPS.Weapon_Status = 1 then
            begin
              SPSStatusLoadStaboard := True;
            end;
            CountLoading := tmr_SPS;
            tmrLoading.Enabled := True;
          end;

        end
        else
        begin
          if Odd(StrToInt(cbbLoadSPS.Text)) then    //ganjil
          begin
            launcherID := 2;
            missileID  := cbbLoadSPS.ItemIndex + 1;
          end
          else
          begin
            launcherID := 1;
            missileID  := cbbLoadSPS.ItemIndex - 2;
          end;
        end;

        if launcherID = WeaponSPS.Weapon_Launcher then
        begin
          if WeaponSPS.Weapon_Status = 1 then
          begin
            RecSendSPS.mLauncherID    := launcherID;
            RecSendSPS.mMissileID     := missileID;

            SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
          end;
        end;
      end;
    end;

  end
  else
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
      
      if WeaponShip is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(WeaponShip);
        isFound := True;
        Break;
      end;
    end;

    if isFound then
    begin
      case atag of
        1 :
        begin
          //assign track
          if WeaponSPS.SPS_TrackObject = nil then Exit;

          WeaponSPS.isDrawAdvice              := True;
          WeaponSPS.AdviceOn_SPS.Visible      := True;
          WeaponSPS.AdviceOn_SPS.SymbolPHP.Visible  := True;
          WeaponSPS.AdviceOn_SPS.SymbolELP.Visible  := True;
          WeaponSPS.AdviceOn_SPS.MLinePHP.Visible   := True;
          WeaponSPS.AdviceOn_SPS.MLineELP.Visible   := True;
          WeaponSPS.AdviceOn_SPS.TgtSpeed     := WeaponSPS.SPS_TrackObject.Speed;
          WeaponSPS.AdviceOn_SPS.TgtBearing   := WeaponSPS.SPS_TrackObject.Course;
          WeaponSPS.AdviceOn_SPS.TgtPosX      := WeaponSPS.SPS_TrackObject.PositionX;
          WeaponSPS.AdviceOn_SPS.TgtPosY      := WeaponSPS.SPS_TrackObject.PositionY;
          WeaponSPS.AdviceOn_SPS.ShipSpeed    := SimManager.TrackObject.Speed;

          case cbbSPSMHP.ItemIndex of
            0 : WeaponSPS.AdviceOn_SPS.Radius := WeaponSPS.ps50;
            1 : WeaponSPS.AdviceOn_SPS.Radius := WeaponSPS.ps80;
            2 : WeaponSPS.AdviceOn_SPS.Radius := WeaponSPS.ps90;
          end;
        end;

        2 :
        begin
          //remove track
          WeaponSPS.SPS_TrackObject       := nil;
          WeaponSPS.isDrawAdvice          := False;
          WeaponSPS.AdviceOn_SPS.Visible  := False;
          WeaponSPS.AdviceOn_SPS.SymbolPHP.Visible  := false;
          WeaponSPS.AdviceOn_SPS.SymbolELP.Visible  := False;
          WeaponSPS.AdviceOn_SPS.MLinePHP.Visible   := False;
          WeaponSPS.AdviceOn_SPS.MLineELP.Visible   := False;
          edtSPSTrackLabel.Text := '';
        end;
      end;
    end;
  end;
end;


procedure TfWeaponStatus.SPSTrack(sender: TInsObject);
begin
  if SimManager.TrackObject = nil then Exit;
  if sender = nil then Exit;

  edtSPSTrackLabel.Text := TInsObject(sender).ObjName;
end;

procedure TfWeaponStatus.SPSbtnFlatClick(Sender: TObject);
var
  id : Integer;
  p : TPoint;
begin
  GetCursorpos(p);

  id := TFlatButton(sender).Tag;

  case id of
    1 : pmSPSTIUPort.Popup(p.X,p.Y);
    2 : pmSPSTIUStarBoard.Popup(p.X,p.Y);
    3 : pmSPSGyro.Popup(p.X, p.Y);
    4 : pmSPSGyroVal.Popup(p.X, p.Y);
    5 : pmSPSBarrel.Popup(p.X, p.Y);
    6 : pmSPSBarrelValue.Popup(p.X, p.Y);
  end;
end;

procedure TfWeaponStatus.SPSClickCheckBox(Sender: Tobject);
var
  i,id : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;

  cbbSPS115  : TCheckBox;
  aParam, astID : Integer;
  ShipStrID : string;
begin
  if SimManager.TrackObject = nil then Exit;

  id := TCheckBox(sender).Tag;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        case id of
          1 : begin
                WeaponSPS.is115V := TCheckBox(sender).Checked;
                astID := __STAT_SPS_115V;
              end;
          2 : begin
                WeaponSPS.isNDS := TCheckBox(sender).Checked;
                astID := __STAT_SPS_NDS;
              end;
          3 : begin
                WeaponSPS.isDeg45_Port := TCheckBox(sender).Checked;
                astID := __STAT_SPS_45_DEG_PORT;
              end;
          4 : begin
                WeaponSPS.isDeg45_StarBoard := TCheckBox(sender).Checked;
                astID := __STAT_SPS_45_DEG_STARBOARD;
              end;
          5 : begin
                WeaponSPS.isSelf := TCheckBox(sender).Checked;
                astID := __STAT_SPS_SELFTEST;
              end;
          6 : begin
                WeaponSPS.isTemp_Port := TCheckBox(sender).Checked;
                astID := __STAT_SPS_TEMP_PORT;
              end;
          7 : begin
                WeaponSPS.isTemp_StarBoard := TCheckBox(sender).Checked;
                astID := __STAT_SPS_TEMP_STARBOARD;
              end;
        end;
      end;
    end;
  end;

  cbbSPS115 := TCheckBox(sender);
  ShipStrID   := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if cbbSPS115.Checked then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_TORPEDO_A244S, astID , aParam);
end;

procedure TfWeaponStatus.PmBarrelClick(Sender: TObject);
var
  i : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;
begin
  if SimManager.TrackObject = nil then exit;

  edtSPSBarrelNumber.Text := DeleteAmpersand(TMenuItem(sender).Caption);
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        case TMenuItem(sender).Tag of
          1 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel1);
          2 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel2);
          3 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel3);
          4 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel4);
          5 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel5);
          6 : edtSPSBarrelVal.Text := getSPS_Barrel_Stat(WeaponSPS.Barrel6);
        end;

        Break;
      end;
    end;
  end;
end;

procedure TfWeaponStatus.PmGyroClick(Sender: TObject);
var
  i : Integer;
  weaponship : TWeaponOnShip;
  WeaponSPS  : TWeaponOn_SPS;
begin
  if SimManager.TrackObject = nil then exit;

  edtSPSGyroNumber.Text := DeleteAmpersand(TMenuItem(sender).Caption);
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_A244S then
    begin
      if weaponship is TWeaponOn_SPS then
      begin
        WeaponSPS := TWeaponOn_SPS(weaponship);

        case TMenuItem(sender).Tag of
          1 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro1);
          2 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro2);
          3 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro3);
          4 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro4);
          5 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro5);
          6 : edtSPSGyroval.Text := getSPS_Gyro_Stat(WeaponSPS.Gyro6);
        end;

        Break;
      end;
    end;
  end;
end;

{ Tetral }
procedure TfWeaponStatus.TetralChkClick(sender: Tobject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponTetral  : TWeaponOn_Tetral;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TETRAL then
    begin
      if weaponship is TWeaponOn_Tetral then
      begin
        WeaponTetral := TWeaponOn_Tetral(weaponship);

        case id of
          __STAT_TETRAL_FWD : WeaponTetral.TetralFwd    := TCheckBox(sender).Checked;
          __STAT_TETRAL_AFT : WeaponTetral.TetralAft    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_TETRAL, id , aParam);
end;

{ TOCOS }
procedure TfWeaponStatus.TOCOSCbbClick(Sender: Tobject);
var
  i, id : Integer;

  Weaponship  : TWeaponOnShip;
  WeaponTOCOS : TWeaponOn_TOCOS;

  aTag, aParam : integer;
  ShipStrID    : string;
  CbbTOCOS    : TCheckBox;
begin
  if SimManager.TrackObject = nil then exit;

  aTag := TCheckBox(sender).Tag;
  CbbTOCOS := TCheckBox(sender);

  //set Object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_TORPEDO_SUT then
    begin
      if weaponship is TWeaponOn_TOCOS then
      begin
        WeaponTOCOS := TWeaponOn_TOCOS(weaponship);

        case aTag of
            __STAT_TOCOS_TempWEC            : WeaponTOCOS.TempWEC             := CbbTOCOS.Checked;
            __STAT_TOCOS_TempTCC            : WeaponTOCOS.TempTCC             := CbbTOCOS.Checked;
            __STAT_TOCOS_FuseWEC            : WeaponTOCOS.FuseWEC             := CbbTOCOS.Checked;
            __STAT_TOCOS_FuseTCC            : WeaponTOCOS.FuseTCC             := CbbTOCOS.Checked;
            __STAT_TOCOS_PowerResetWEC      : WeaponTOCOS.PowerResetWEC       := CbbTOCOS.Checked;
            __STAT_TOCOS_PowerResetTCC      : WeaponTOCOS.PowerResetTCC       := CbbTOCOS.Checked;
            __STAT_TOCOS_CMPTR              : WeaponTOCOS.CMPTR               := CbbTOCOS.Checked;
            __STAT_TOCOS_SOFTW              : WeaponTOCOS.SOFTW               := CbbTOCOS.Checked;
            __STAT_TOCOS_NUG_1              : WeaponTOCOS.NUG_1               := CbbTOCOS.Checked;
            __STAT_TOCOS_NUG_2              : WeaponTOCOS.NUG_2               := CbbTOCOS.Checked;
            __STAT_TOCOS_AntiCondensHeating : WeaponTOCOS.AntiCondensHeating  := CbbTOCOS.Checked;
            __STAT_TOCOS_LOADPROGR          : WeaponTOCOS.LOADPROGR           := CbbTOCOS.Checked;

            __STAT_TOCOS_Port_Indikator_Port      : WeaponTOCOS.Port_Indikator_Port   := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_Indikator_Port   : WeaponTOCOS.STB_Indikator_Port    := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_ToSupply            : WeaponTOCOS.Port_ToSupply         := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_ToSupply         : WeaponTOCOS.STB_ToSupply          := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_120_BAR             : WeaponTOCOS.Port_120_BAR          := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_120_BAR          : WeaponTOCOS.STB_120_BAR           := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_20_BAR              : WeaponTOCOS.Port_20_BAR           := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_20_BAR           : WeaponTOCOS.STB_20_BAR            := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_DOOR_Open           : WeaponTOCOS.Port_DOOR_Open        := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_DOOR_Open        : WeaponTOCOS.STB_DOOR_Open         := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_TORP_On             : WeaponTOCOS.Port_TORP_On          := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_TORP_On          : WeaponTOCOS.STB_TORP_On           := CbbTOCOS.Checked;
            __STAT_TOCOS_Port_Ready_To_Fire       : WeaponTOCOS.Port_Ready_To_Fire    := CbbTOCOS.Checked;
            __STAT_TOCOS_StbPort_Ready_To_Fire    : WeaponTOCOS.STB_Ready_To_Fire     := CbbTOCOS.Checked;

            __STAT_TOCOS_EXTSTABAVL   : WeaponTOCOS.EXTSTABAVL := CbbTOCOS.Checked;
            __STAT_TOCOS_CASSTABAVL   : WeaponTOCOS.CASSTABAVL := CbbTOCOS.Checked;

        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if CbbTOCOS.Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_TORPEDO_SUT, aTag , aParam);
end;

{ Yakhont }
procedure TfWeaponStatus.YAKHONTTrack(sender: TInsObject);
begin
  if SimManager.TrackObject = nil then Exit;
  if sender = nil then Exit;

  edtYAKHONTTtrack.Text := TInsObject(sender).ObjName;
end;

procedure TfWeaponStatus.btnYAKHONTAssignClick(Sender: TObject);
var
  iObj                : TInsObject;
  i, j,
  launcherID          : Integer;
  WeaponShip          : TWeaponOnShip;
  WeaponYAKHONT       : TWeaponOn_Yakhont;
//  RecSend             : TRecData_Yakhont;
  recAssign           : TRecObjectAssigned;

  arMissile : array[0..3] of Integer;
begin
  if not Assigned(SimManager.TrackObject) then Exit;


  if not Assigned(SimManager.TrackObject) then Exit;

  if TComponent(Sender).Tag = 3 then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if WeaponShip is TWeaponOn_Yakhont then
      begin
        WeaponYAKHONT := TWeaponOn_Yakhont(WeaponShip);

        RecSendYakhont.ShipID         := SimManager.TrackObject.FDataBaseID;
        RecSendYakhont.mMissileID     := 1;
        RecSendYakhont.mMissileNumber := 1;
        RecSendYakhont.OrderID        := __ORD_Yahkont_LOADING;
        RecSendYakhont.mLauncherID    := WeaponYAKHONT.Weapon_Launcher;
        RecSendYakhont.mTargetBearing := 0;
        RecSendYakhont.mTargetRange   := 0;
        RecSendYakhont.mWeaponID      := WeaponYAKHONT.Weapon_ID;

        if cbbLoadYakhont.Text = 'All' then
        begin
          if WeaponYAKHONT.Weapon_Launcher = 1 then
          begin
            if WeaponYAKHONT.Weapon_Status = 1 then
            begin
              RecSendYakhont.mMissile1 := 1;
            end;
          end
          else if WeaponYAKHONT.Weapon_Launcher = 2 then
          begin
            if WeaponYAKHONT.Weapon_Status = 1 then
            begin
              RecSendYakhont.mMissile2 := 1;
            end;
          end
          else if WeaponYAKHONT.Weapon_Launcher = 3 then
          begin
            if WeaponYAKHONT.Weapon_Status = 1 then
            begin
              RecSendYakhont.mMissile3 := 1;
            end;
          end
          else if WeaponYAKHONT.Weapon_Launcher = 4 then
          begin
            if WeaponYAKHONT.Weapon_Status = 1 then
            begin
              RecSendYakhont.mMissile4 := 1;
            end;
            CountLoading := tmr_YAKHONT;
            tmrLoading.Enabled := True;
            Break;
          end;
        end
        else
        begin
          if WeaponYAKHONT.Weapon_Launcher = cbbLoadYakhont.ItemIndex + 1 then
          begin

            if WeaponYAKHONT.Weapon_Status = 1 then
            begin

              for j:= 0 to 3 do
                arMissile[j] := 0;

              arMissile[cbbLoadYakhont.ItemIndex] := 1;

              RecSendYakhont.mMissile1      := arMissile[0];
              RecSendYakhont.mMissile2      := arMissile[1];
              RecSendYakhont.mMissile3      := arMissile[2];
              RecSendYakhont.mMissile4      := arMissile[3];

              SimManager.NetSendTo3D_OrderMissile_YAHKONT(RecSendYakhont);
            end
          end;
        end;

      end;
    end;
  end
  else
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if WeaponShip is TWeaponOn_Yakhont then
      begin
        WeaponYAKHONT := TWeaponOn_Yakhont(WeaponShip);

        if Assigned(WeaponYAKHONT.YAKHONT_TrackObject) then
        begin
          case TComponent(sender).Tag of
            //Assign
            1 :
            begin
              recAssign.ShipID       := SimManager.TrackObject.FDataBaseID;
              recAssign.ObjectAssign := WeaponYAKHONT.YAKHONT_TrackObject.FDataBaseID;
              recAssign.OrderID      := __ORD_ID_YAKHONT;
              recAssign.mode         := 1;
              SimManager.NetSendTo2D_ObjectAssign(recAssign);

              btnYAKHONTAssign.Enabled    := False;
              btnYAKHONTDeAssign.Enabled  := True;
            end;

            //Deassign
            2 :
            begin
              recAssign.ShipID       := SimManager.TrackObject.FDataBaseID;
              recAssign.ObjectAssign := WeaponYAKHONT.YAKHONT_TrackObject.FDataBaseID;
              recAssign.OrderID      := __ORD_ID_YAKHONT;
              recAssign.mode         := 0;
              SimManager.NetSendTo2D_ObjectAssign(recAssign);

              WeaponYAKHONT.YAKHONT_TrackObject := nil;
              btnYAKHONTAssign.Enabled      := True;
              btnYAKHONTDeAssign.Enabled    := false;
              edtYAKHONTTtrack.Text     := '';
            end;
          end;
        end;

        Break;
      end;
    end;
  end;
end;

procedure TfWeaponStatus.YakhontChkClick(Sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  CbbRBU : TCheckBox;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponYakhont   : TWeaponOn_Yakhont;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_Yakhont then
    begin
      if weaponship is TWeaponOn_Yakhont then
      begin
        WeaponYakhont := TWeaponOn_Yakhont(weaponship);
        with WeaponYakhont do
        begin
        case id of
          __STAT_YAKHONT_PRINTER    :  STAT_YAKHONT_PRINTER    := TCheckBox(sender).Checked;
          __STAT_YAKHONT_CONSOLE_N1 :  STAT_YAKHONT_CONSOLE_N1 := TCheckBox(sender).Checked;
          __STAT_YAKHONT_CONSOLE_N2 :  STAT_YAKHONT_CONSOLE_N2 := TCheckBox(sender).Checked;
          __STAT_YAKHONT_RIGHT_1    :  STAT_YAKHONT_RIGHT_1    := TCheckBox(sender).Checked;
          __STAT_YAKHONT_RIGHT_3    :  STAT_YAKHONT_RIGHT_3    := TCheckBox(sender).Checked;
          __STAT_YAKHONT_LEFT_2     :  STAT_YAKHONT_LEFT_2     := TCheckBox(sender).Checked;
          __STAT_YAKHONT_LEFT_4     :  STAT_YAKHONT_LEFT_4     := TCheckBox(sender).Checked;
          __STAT_YAKHONT_KR231      :  STAT_YAKHONT_KR231      := TCheckBox(sender).Checked;
          __STAT_YAKHONT_GYRO       :  STAT_YAKHONT_GYRO       := TCheckBox(sender).Checked;
          __STAT_YAKHONT_INS300V    :  STAT_YAKHONT_INS300V    := TCheckBox(sender).Checked;
          __STAT_YAKHONT_INS27V     :  STAT_YAKHONT_INS27V     := TCheckBox(sender).Checked;
        end;
        end;
      end;
    end;
  end;

  //send to console
  aTag    := TCheckBox(sender).Tag;
  CbbRBU  := TCheckBox(sender);

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if CbbRBU.Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_YAKHONT, aTag , aParam);
end;

{ RBU }
procedure TfWeaponStatus.RBUTrack(sender: TInsObject);
begin
  if SimManager.TrackObject = nil then Exit;
  if sender = nil then Exit;

  edtRBUTrackLabel.Text := TInsObject(sender).ObjName;

end;

procedure TfWeaponStatus.btnRBUAssignClick(Sender: TObject);
var
  iObj : TInsObject;

  i, launcherID,
  salvo         : Integer;
  WeaponShip    : TWeaponOnShip;
  WeaponRBU     : TWeaponOn_RBU;

  recAssign     : TRecRBU_SonarMode;
  recLoading    : TRecSetRBU;
begin
  if not Assigned(SimManager.TrackObject) then exit;

  //ShowMessage(IntToStr(TComponent(Sender).tag));

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_RBU then
    begin
      WeaponRBU := TWeaponOn_RBU(WeaponShip);

      if (TComponent(Sender).Tag = 3) or (TComponent(Sender).Tag = 4) then begin
        recLoading.ShipID          := SimManager.TrackObject.FDataBaseID;
        recLoading.mWeaponID       := WeaponRBU.Weapon_ID;

        if TComponent(Sender).Tag = 3 then begin
          launcherID := 1;
        end
        else if TComponent(Sender).Tag = 4 then begin
          launcherID := 2;
        end;
        recLoading.mLauncherID     := launcherID;
        recLoading.mMissileID      := 1;
        recLoading.mMissileNumber  := 1;
        recLoading.OrderID         := __ORD_RBU_LOADING;
        recLoading.mCount          := 12;
        recLoading.mMissileType    := 0;
        recLoading.mTargetID       := 0;
        recLoading.mLncrBearing    := 0;
        recLoading.mLncRange       := 0;
        recLoading.mTargetDepth    := 0;
        recLoading.mCorrBearing    := 0;
        recLoading.mCorrElev       := 0;

        SimManager.NetSendTo3D_OrderMissileRBU6000(recLoading);
      end;


      if Assigned(WeaponRBU.RBU_TrackObject) then
      begin
        case TComponent(sender).Tag of
          //Assign
          1 :
          begin
            recAssign.OWN_SHIP_UID    := SimManager.TrackObject.UniqueID;
            recAssign.TARGET_SHIP_UID := WeaponRBU.RBU_TrackObject.UniqueID;
            recAssign.Mode := True;
            SimManager.NetSendRBU_TrackObject(recAssign);

            btnRBUAssign.Enabled    := False;
            btnRBUDeAssign.Enabled  := True;
          end;

          //Deassign
          2 :
          begin
            recAssign.OWN_SHIP_UID    := SimManager.TrackObject.UniqueID;
            recAssign.TARGET_SHIP_UID := WeaponRBU.RBU_TrackObject.UniqueID;
            recAssign.Mode := false;

            SimManager.NetSendRBU_TrackObject(recAssign);

            WeaponRBU.RBU_TrackObject := nil;
            btnRBUAssign.Enabled      := True;
            btnRBUDeAssign.Enabled    := false;
            edtRBUTrackLabel.Text     := '';
          end;
        end;
      end;

      Break;
    end;
  end;
end;

procedure TfWeaponStatus.RBUCbbClick(Sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  CbbRBU : TCheckBox;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponRBU   : TWeaponOn_RBU;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_RBU6000 then
    begin
      if weaponship is TWeaponOn_RBU then
      begin
        WeaponRBU := TWeaponOn_RBU(weaponship);

        case id of
          __STAT_RBU_ALIRAN_KAPAL :
              begin
                WeaponRBU.ShipSignal := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_UNFORMER_I_LEFT :
              begin
                WeaponRBU.Unformer1Left := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_UNFORMER_II_LEFT :
              begin
                WeaponRBU.Unformer2Left := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_UNFORMER_I_RIGHT :
              begin
                WeaponRBU.Unformer1Right := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_UNFORMER_II_RIGHT :
              begin
                WeaponRBU.Unformer2Right := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE1_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE1_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE2_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE2_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE3_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE3_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE4_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE4_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE5_FAULT  :
              begin
                WeaponRBU.LAUNCHER1_MISSILE5_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE6_FAULT  :
              begin
               WeaponRBU.LAUNCHER1_MISSILE6_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE7_FAULT :
              begin
               WeaponRBU.LAUNCHER1_MISSILE7_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE8_FAULT :
              begin
               WeaponRBU.LAUNCHER1_MISSILE8_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE9_FAULT :
              begin
               WeaponRBU.LAUNCHER1_MISSILE9_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE10_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE10_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE11_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE11_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER1_MISSILE12_FAULT :
              begin
                WeaponRBU.LAUNCHER1_MISSILE12_FAULT := TCheckBox(Sender).Checked;
              end;

          __STAT_RBU_LAUNCHER2_MISSILE1_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE1_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE2_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE2_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE3_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE3_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE4_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE4_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE5_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE5_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE6_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE6_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE7_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE7_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE8_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE8_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE9_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE9_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE10_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE10_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE11_FAULT :
              begin
                WeaponRBU.LAUNCHER2_MISSILE11_FAULT := TCheckBox(Sender).Checked;
              end;
          __STAT_RBU_LAUNCHER2_MISSILE12_FAULT  :
              begin
                WeaponRBU.LAUNCHER2_MISSILE12_FAULT := TCheckBox(Sender).Checked;
              end;
        end;
      end;
    end;
  end;

  //send to console
  aTag    := TCheckBox(sender).Tag;
  CbbRBU  := TCheckBox(sender);

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if CbbRBU.Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_RBU6000 , aTag , aParam);
end;

{ Asroc }
procedure TfWeaponStatus.ASROCTrack(sender: TInsObject);
begin
  if SimManager.TrackObject = nil then Exit;
  if sender = nil then Exit;

  edtASROCAssign1FC.Text := TInsObject(sender).ObjName;
end;

procedure TfWeaponStatus.btnASROCAssign1FCClick(Sender: TObject);
var
  i, j, k : integer;
  recAssign   : TRecFireControlOrder;
  recsend     : TRec3DSetAsrock;
  WeaponShip  : TWeaponOnShip;
  WeaponASROC : TWeaponOn_ASROC;
  recSentTMAsroc : TRecAsrocMissileType;
  Weaponx       : TWeapon ;
  listWeaponSce : TList;
  sceWeapon : TScenarioWeapon;
begin


  if not Assigned(SimManager.TrackObject) then Exit;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_ASROC then
    begin
      WeaponASROC := TWeaponOn_ASROC(WeaponShip);

      if TComponent(sender).Tag = 3 then
      begin
       RecSend.ShipID         := SimManager.TrackObject.FDataBaseID;
       RecSend.mWeaponID      := WeaponASROC.Weapon_ID;
       RecSend.mLauncherID    := WeaponASROC.Weapon_Launcher;

       RecSend.mMissileID     := cbbMissileIDstatus.ItemIndex+1;
       RecSend.mMissileNumber := 1;

       RecSend.mMissile_Type  := cbbMissileType.ItemIndex +5;


       RecSend.mTargetID      := 0;
       RecSend.OrderID        := __ORD_ASROCK_LOADING;
       RecSend.mTargetBearing := 0;
       RecSend.mTargetRange   := 0;
       RecSend.mTargetDepth   := 0;
       RecSend.mFuzeType      := cbbFuzeType.ItemIndex+1;
       RecSend.mCorrRange     := 0;

       SimManager.NetSendTo3D_OrderMissileAsroc (RecSend);

       //cuma buat ngisi label missile Type Instruktur

       recSentTMAsroc.ShipId := SimManager.TrackObject.FDataBaseID;
       recSentTMAsroc.WeaponID := WeaponASROC.Weapon_ID;
       recSentTMAsroc.MissileID := cbbMissileIDstatus.ItemIndex+1;
       recSentTMAsroc.LauncherID := WeaponASROC.Weapon_Launcher;
       recSentTMAsroc.MissileType     := cbbMissileType.ItemIndex+5;
        listWeaponSce := TList.Create;
        DataModule1.GetListWeaponOnShipBySceID(0, SimManager.TrackObject.FDataBaseID , listWeaponSce);
        for k := 0 to listWeaponSce.Count-1 do
        begin
          sceWeapon := TScenarioWeapon(listWeaponSce.Items[k]);
          if (sceWeapon.LauncherID = WeaponASROC.Weapon_Launcher) and (sceWeapon.WeaponID = WeaponASROC.Weapon_ID)
          and (sceWeapon.ShipID = SimManager.TrackObject.FDataBaseID)   then
          begin
            if cbbMissileIDstatus.ItemIndex+1 = 1 then
            begin
             if (WeaponASROC.MissileType1 = tsEmpty) then
             begin
               SimManager.NetSendAsroc_MissileType(recSentTMAsroc);
             end;
            end
            else if (cbbMissileIDstatus.ItemIndex+1 = 2)  then
            begin
             if WeaponASROC.MissileType2 = tsEmpty then
             begin
               SimManager.NetSendAsroc_MissileType(recSentTMAsroc);
             end;
            end;
          end;

        end;



      end;

      if Assigned(WeaponASROC.Asroc_TrackObject) then
      begin
        case TComponent(sender).Tag of
          //Assign
          1 :
          begin
            recAssign.ShipID      := SimManager.TrackObject.UniqueID;
            recAssign.OrderID     := OrdID_assign_FC;
            recAssign.FC_number   := 5;
            recAssign.FC_command  := Byte(AssignTrackSs);
            recAssign.TrackUID    := WeaponASROC.Asroc_TrackObject.UniqueID;
            recAssign.Ship_TID    := 63;
            recAssign.TrackNumber := SimManager.AsrockAssignNumber + 1;

            recAssign.X           := WeaponASROC.Asroc_TrackObject.PositionX;
            recAssign.Y           := WeaponASROC.Asroc_TrackObject.PositionY;

            SimManager.NetSendASROC_TrackObject(recAssign);

            btnASROCAssign1FC.Enabled   := false;
            btnASROCDeAssign1FC.Enabled := True;
          end;

          //Deassign
          2 :
          begin
            recAssign.ShipID      := SimManager.TrackObject.UniqueID;
            recAssign.OrderID     := OrdID_deassign_FC;
            recAssign.FC_number   := 5;
            recAssign.FC_command  := Byte(AssignTrackSs);
            recAssign.TrackUID    := WeaponASROC.Asroc_TrackObject.UniqueID;
            recAssign.Ship_TID    := 63;
            recAssign.TrackNumber := SimManager.AsrockAssignNumber + 1;

            recAssign.X           := WeaponASROC.Asroc_TrackObject.PositionX;
            recAssign.Y           := WeaponASROC.Asroc_TrackObject.PositionY;

            SimManager.NetSendASROC_TrackObject(recAssign);

            WeaponASROC.Asroc_TrackObject := nil;

            edtASROCAssign1FC.Text      := '';
            btnASROCAssign1FC.Enabled   := true;
            btnASROCDeAssign1FC.Enabled := false;
          end;
        end;
      end;

      Break;
    end;
  end;
end;

procedure TfWeaponStatus.ASROCClickCheckBox(Sender: TObject);
var
  i, id : Integer;

  Weaponship  : TWeaponOnShip;
  WeaponASROC : TWeaponOn_ASROC;

  aTag : integer;
  ShipStrID : string;
  CbbASROCK : TCheckBox;
  aParam : Integer;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set Object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_ASROC then
    begin
      if weaponship is TWeaponOn_ASROC then
      begin
        WeaponASROC := TWeaponOn_ASROC(weaponship);

        case id of
          __STAT_ASROCK_HYDR      :
              begin
                WeaponASROC.isHydr := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_LAUNCHER         :
              begin
                WeaponASROC.isLauncher := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_LAUNCHER_SYNC    :
              begin
                WeaponASROC.isLauncherSync := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_ROCKET1_READY    :
              begin
                WeaponASROC.isRocket1 := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_ROCKET2_READY    :
              begin
                WeaponASROC.isRocket2 := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_AVAILABLE_ERIKA      :
              begin
                WeaponASROC.isAvailable_Erika := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_SPEED_ERIKA        :
              begin
                WeaponASROC.isSpeed_Erika := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_FUZE_ERIKA    :
              begin
                WeaponASROC.isFuze_Erika := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_AVAILABLE_NELLY    :
              begin
                WeaponASROC.isAvailable_Nelly := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_SPEED_NELLY    :
              begin
                WeaponASROC.isSpeed_Nelly := TCheckBox(sender).Checked;
              end;
          __STAT_ASROCK_FUZE_NELLY    :
              begin
                WeaponASROC.isFuze_Nelly := TCheckBox(sender).Checked;
              end;
        end;
      end;
    end;
  end;

  //Send To Console
  aTag       := TCheckBox(sender).Tag;
  CbbASROCK  := TCheckBox(sender);
  ShipStrID  := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if CbbASROCK.Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_ASROC, aTag , aParam);
end;

procedure TfWeaponStatus.ASROCClickRadioBtn(sender: TObject);
var
  i, id : Integer;

  Weaponship  : TWeaponOnShip;
  WeaponASROC : TWeaponOn_ASROC;

  aTag : integer;
  ShipStrID : string;

  Param : integer;
begin
  if SimManager.TrackObject = nil then exit;
  id    := TRadioButton(sender).Tag;
  Param := StrToInt(TRadioButton(sender).Hint);

  //set Object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_ASROC then
    begin
      if weaponship is TWeaponOn_ASROC then
      begin
        WeaponASROC := TWeaponOn_ASROC(weaponship);

        case id of
          __STAT_ASROCK_AVAILABLE_ERIKA      :
              begin
                case Param of
                  1 : WeaponASROC.isAvailable_Erika := True;
                  2 : WeaponASROC.isAvailable_Erika := False;
                end
              end;
          __STAT_ASROCK_SPEED_ERIKA        :
              begin
                case Param of
                  1 : WeaponASROC.isSpeed_Erika := true;
                  2 : WeaponASROC.isSpeed_Erika := false;
                end;
              end;
          __STAT_ASROCK_FUZE_ERIKA    :
              begin
                case Param of
                  1 : WeaponASROC.isFuze_Erika := true;
                  2 : WeaponASROC.isFuze_Erika := false;
                end;
              end;

          __STAT_ASROCK_AVAILABLE_NELLY    :
              begin
                case Param of
                  1 : WeaponASROC.isAvailable_Nelly := True;
                  2 : WeaponASROC.isAvailable_Nelly := False;
                end
              end;
          __STAT_ASROCK_SPEED_NELLY    :
              begin
                case Param of
                  1 : WeaponASROC.isSpeed_Nelly := true;
                  2 : WeaponASROC.isSpeed_Nelly := false;
                end;
              end;
          __STAT_ASROCK_FUZE_NELLY    :
              begin
                case Param of
                  1 : WeaponASROC.isFuze_Nelly := true;
                  2 : WeaponASROC.isFuze_Nelly := false;
                end;
              end;
        end;
      end;
    end;
  end;

  ShipStrID  := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);
  SimManager.NetSendStatConsole(ShipStrID, C_DBID_ASROC, id , Param);

end;

{ C802 }
procedure TfWeaponStatus.C802Track(sender: TInsObject);
begin
  if SimManager.TrackObject = nil then Exit;
  if sender = nil then Exit;

  edtC802Track.Text := TInsObject(sender).ObjName;
end;

procedure TfWeaponStatus.btnC802AssignClick(Sender: TObject);
var
  iObj : TInsObject;

  i, launcherID, j      : Integer;
  WeaponShip            : TWeaponOnShip;
  WeaponC802            : TWeaponOn_C802;
//  recsend               : TRecData_C802;
  recAssign             : TRecObjectAssigned;
begin
  if not Assigned(SimManager.TrackObject) then Exit;

  C802StatusLoad_1 := False;
  C802StatusLoad_2 := False;
  C802StatusLoad_3 := False;
  C802StatusLoad_4 := False;

  if TComponent(sender).Tag = 3 then
  begin
    for i:= 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
      if WeaponShip is TWeaponOn_C802 then
      begin
        WeaponC802 := TWeaponOn_C802(WeaponShip);

        recSendC802.ShipID         := SimManager.TrackObject.FDataBaseID;
        recSendC802.mMissileID     := 1;
        recSendC802.mMissileNumber := 1;
        recSendC802.OrderID        := __ORD_C802_LOADING;
        recSendC802.mTargetBearing := 0;
        recSendC802.mTargetRange   := 0;
        recSendC802.mWeaponID      := WeaponC802.Weapon_ID;

        if cbbLoadC802.Text = 'All' then
        begin

          if WeaponC802.Weapon_Launcher = 1 then
          begin
            if WeaponC802.Weapon_Status = 1 then
            begin
              C802StatusLoad_1 := True;
            end;
          end
          else if WeaponC802.Weapon_Launcher = 2 then
          begin
            if WeaponC802.Weapon_Status = 1 then
            begin
              C802StatusLoad_2 := True;
            end;
          end
          else if WeaponC802.Weapon_Launcher = 3 then
          begin
            if WeaponC802.Weapon_Status = 1 then
            begin
              C802StatusLoad_3 := True;
            end;
          end
          else if WeaponC802.Weapon_Launcher = 4 then
          begin
            if WeaponC802.Weapon_Status = 1 then
            begin
              C802StatusLoad_4 := True;
            end;
            CountLoading := tmr_C802;
            tmrLoading.Enabled := True;
            break;
          end

        end
        else
        begin
          if  WeaponC802.Weapon_Launcher = cbbLoadC802.ItemIndex + 1 then
          begin
            if WeaponC802.Weapon_Status = 1 then
            begin
              recSendC802.mLauncherID    := StrToInt(cbbLoadC802.Text);
              SimManager.NetSendTo3D_OrderMissile_C802(recSendC802);
            end;
          end;
        end;

      end;
    end;
  end
  else
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
      if WeaponShip is TWeaponOn_C802 then
      begin
        WeaponC802 := TWeaponOn_C802(WeaponShip);
        if Assigned(WeaponC802.C802_TrackObject) then
        begin
          case TComponent(sender).Tag of
            //Assign
            1 :
            begin
              recAssign.ShipID       := SimManager.TrackObject.FDataBaseID;
              recAssign.ObjectAssign := WeaponC802.C802_TrackObject.FDataBaseID;
              recAssign.OrderID      := __ORD_ID_C802;
              recAssign.mode         := 1;
              SimManager.NetSendTo2D_ObjectAssign(recAssign);

              btnC802Assign.Enabled    := False;
              btnC802DeAssign.Enabled  := True;

            end;

            //Deassign
            2 :
            begin
              recAssign.ShipID       := SimManager.TrackObject.FDataBaseID;
              recAssign.ObjectAssign := WeaponC802.C802_TrackObject.FDataBaseID;
              recAssign.OrderID      := __ORD_ID_C802;
              recAssign.mode         := 0;
              SimManager.NetSendTo2D_ObjectAssign(recAssign);

              WeaponC802.C802_TrackObject := nil;
              btnC802Assign.Enabled      := True;
              btnC802DeAssign.Enabled    := false;

              edtC802Track.Text     := '';
            end;
          end;
        end;
        Break;
      end;
    end;
  end;

end;

procedure TfWeaponStatus.C802ChkClick(Sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  CbbRBU : TCheckBox;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponC802   : TWeaponOn_C802;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_C802 then
    begin
      if weaponship is TWeaponOn_C802 then
      begin
        WeaponC802 := TWeaponOn_C802(weaponship);

        case id of
          __STAT_C802_PRECHECK_LAUNCHER1             : WeaponC802.STAT_C802_PRECHECK_LAUNCHER1 := TCheckBox(sender).Checked;
          __STAT_C802_PRECHECK_LAUNCHER2             : WeaponC802.STAT_C802_PRECHECK_LAUNCHER2 := TCheckBox(sender).Checked;
          __STAT_C802_PRECHECK_LAUNCHER3             : WeaponC802.STAT_C802_PRECHECK_LAUNCHER3 := TCheckBox(sender).Checked;
          __STAT_C802_PRECHECK_LAUNCHER4             : WeaponC802.STAT_C802_PRECHECK_LAUNCHER4 := TCheckBox(sender).Checked;

          __STAT_C802_READYCONDITION_LAUNCHER1       : WeaponC802.STAT_C802_READYCONDITION_LAUNCHER1 := TCheckBox(sender).Checked;
          __STAT_C802_READYCONDITION_LAUNCHER2       : WeaponC802.STAT_C802_READYCONDITION_LAUNCHER2 := TCheckBox(sender).Checked;
          __STAT_C802_READYCONDITION_LAUNCHER3       : WeaponC802.STAT_C802_READYCONDITION_LAUNCHER3 := TCheckBox(sender).Checked;
          __STAT_C802_READYCONDITION_LAUNCHER4       : WeaponC802.STAT_C802_READYCONDITION_LAUNCHER4 := TCheckBox(sender).Checked;

          __STAT_C802_LAUNCH_LAUNCHER1               : WeaponC802.STAT_C802_LAUNCH_LAUNCHER1 := TCheckBox(sender).Checked;
          __STAT_C802_LAUNCH_LAUNCHER2               : WeaponC802.STAT_C802_LAUNCH_LAUNCHER2 := TCheckBox(sender).Checked;
          __STAT_C802_LAUNCH_LAUNCHER3               : WeaponC802.STAT_C802_LAUNCH_LAUNCHER3 := TCheckBox(sender).Checked;
          __STAT_C802_LAUNCH_LAUNCHER4               : WeaponC802.STAT_C802_LAUNCH_LAUNCHER4 := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  //send to console
  aTag    := TCheckBox(sender).Tag;
  CbbRBU  := TCheckBox(sender);

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if CbbRBU.Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_C802, aTag , aParam);
end;

{ Cannon 76 }
procedure TfWeaponStatus.Cannon76ChkClick(sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponCannon76  : TWeaponOn_Cannon76;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_CANNON76  then
    begin
      if weaponship is TWeaponOn_Cannon76 then
      begin
        WeaponCannon76 := TWeaponOn_Cannon76(weaponship);

        case id of
          __STAT_CANNON76_ENABLE : WeaponCannon76.EnableCannon76    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_CANNON76, id , aParam);
end;
{ Exocet MM40 }
procedure TfWeaponStatus.Exocet40ChkClick(sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponExocet40  : TWeaponOn_EXOCET40;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_EXOCET_MM40 then
    begin
      if weaponship is TWeaponOn_EXOCET40 then
      begin
        WeaponExocet40 := TWeaponOn_EXOCET40(weaponship);

        case id of
          __STAT_EXOCET40_ENABLE    : WeaponExocet40.EnableExocet40  := TCheckBox(sender).Checked;
          __STAT_EXOCET40_SafetyFA  : WeaponExocet40.SafetyFA        := TCheckBox(sender).Checked;
          __STAT_EXOCET40_ControlFA : WeaponExocet40.ControlFA       := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_EXOCET_MM40, id , aParam);
end;

{ Sigma }
procedure TfWeaponStatus.MOCChkClick(sender: Tobject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponMOC   : TWeaponOn_MOC;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_MOCCONSOLE then
    begin
      if weaponship is TWeaponOn_MOC then
      begin
        WeaponMOC := TWeaponOn_MOC(weaponship);

        case id of
          __STAT_MOC_RadarARPA  : WeaponMOC.RadarARPA      := TCheckBox(sender).Checked;
          __STAT_MOC_MW08       : WeaponMOC.RadarMW        := TCheckBox(sender).Checked;
          __STAT_MOC_LIROD_MK2  : WeaponMOC.LirodMK2       := TCheckBox(sender).Checked;
          __STAT_MOC_Kingklip   : WeaponMOC.SonarKingklip  := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_MOCCONSOLE, id , aParam);
end;

{ ======================================================================= }

{ ======================================================================= }
procedure TfWeaponStatus.ShowWeaponPanel(const WeaponName: string);
var
  i,j,k : Integer;

  TempWeaponShip : TWeaponOnShip;

  { Weapon Ship }
  WeaponShip : TWeaponOnShip;

  pmSPSGyroMenuItem,
  pmSPSBarrelMenuItem : TMenuItem;

  WeaponExocet40 : TWeaponOn_EXOCET40;
  WeaponASROC    : TWeaponOn_ASROC;
  WeaponRBU      : TWeaponOn_RBU;
  WeaponTOCOS    : TWeaponOn_TOCOS;
  WeaponSPS      : TWeaponOn_SPS;
  WeaponYakhont  : TWeaponOn_Yakhont;
  WeaponC802     : TWeaponOn_C802;
  WeaponMoc      : TWeaponOn_MOC;
  WeaponTetral   : TWeaponOn_Tetral;
  WeaponCannon76 : TWeaponOn_Cannon76;
  WeaponCannon57 : TWeaponOn_Cannon57;
  WeaponCannon40 : TWeaponOn_Cannon40;
  WeaponStrela   : TWeaponOn_Strella;
  WeaponMistral  : TWeaponOn_Mistral;
begin
  //pnlBlank.BringToFront;

  if not Assigned(SimManager.TrackObject) then Exit;


  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(TInsObject(SimManager.TrackObject).WeaponOnShip_List[i]);
    if weaponship.Weapon_Name = WeaponName then
    begin

      case WeaponShip.Weapon_ID of
        C_DBID_ASROC :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
            rzgrpAsroc.Visible := True;
            //rzgrpAsroc.Opened := True;
          end;
          edtASROCAssign1FC.Text := '';
          frmMainInstruktur.cekStatusWeapon := 1;
          if weaponship is TWeaponOn_ASROC then
          begin
            WeaponASROC := TWeaponOn_ASROC(weaponship);

            chkASROCHydr.OnClick          := nil;
            chkASROCLauncher.OnClick      := nil;
            chkASROCLauncherSync.OnClick  := nil;
            chkASROCRocket1.OnClick       := nil;
            chkASROCRocket2.OnClick       := nil;
//            chkAsrockAvailable.OnClick    := nil;
//            chkAsrockAvailable2.OnClick   := nil;
//            chkAsrockSpeed.OnClick        := nil;
//            chkAsrockSpeed2.OnClick       := nil;
//            chkAsrockFuze.OnClick         := nil;
//            chkAsrockFuze2.OnClick        := nil;

//            rbAvailableErika.OnClick      := nil;
//            rbEmptyErika.OnClick          := nil;
//            rbSpeedLowErika.OnClick       := nil;
//            rbSpeedHighErika.OnClick      := nil;
//            rbFuzeTimeErika.OnClick       := nil;
//            rbFuzeProxErika.OnClick       := nil;

//            rbAvailableErika.Checked      := False;
//            rbEmptyErika.Checked          := true;
//            rbSpeedLowErika.Checked       := true;
//            rbSpeedHighErika.Checked      := False;
//            rbFuzeTimeErika.Checked       := true;
//            rbFuzeProxErika.Checked       := false;

//            rbAvailableNelly.OnClick      := nil;
//            rbEmptyNelly.OnClick          := nil;
//            rbSpeedLowNelly.OnClick       := nil;
//            rbSpeedHighNelly.OnClick      := nil;
//            rbFuzeTimeNelly.OnClick       := nil;
//            rbFuzeProxNelly.OnClick       := nil;

//            rbAvailableNelly.Checked      := False;
//            rbEmptyNelly.Checked          := true;
//            rbSpeedLowNelly.Checked       := true;
//            rbSpeedHighNelly.Checked      := False;
//            rbFuzeTimeNelly.Checked       := true;
//            rbFuzeProxNelly.Checked       := false;

            chkASROCHydr.Checked          := WeaponASROC.isHydr;
            chkASROCLauncher.Checked      := WeaponASROC.isLauncher;
            chkASROCLauncherSync.Checked  := WeaponASROC.isLauncherSync;
            chkASROCRocket1.Checked       := WeaponASROC.isRocket1;
            chkASROCRocket2.Checked       := WeaponASROC.isRocket2;

//            chkAsrockAvailable.Checked    := WeaponASROC.isAvailable_Erika;
//            chkAsrockAvailable2.Checked   := WeaponASROC.isAvailable_Nelly;
//            chkAsrockSpeed.Checked        := WeaponASROC.isSpeed_Erika;
//            chkAsrockSpeed2.Checked       := WeaponASROC.isSpeed_Nelly;
//            chkAsrockFuze.Checked         := WeaponASROC.isFuze_Erika;
//            chkAsrockFuze2.Checked        := WeaponASROC.isFuze_Nelly;

//            rbAvailableErika.Checked      := WeaponASROC.isAvailable_Erika;
//            rbSpeedHighErika.Checked      := WeaponASROC.isSpeed_Erika;
//            rbFuzeProxErika.Checked       := WeaponASROC.isFuze_Erika;

//            rbAvailableNelly.Checked      := WeaponASROC.isAvailable_Nelly;
//            rbSpeedHighNelly.Checked      := WeaponASROC.isSpeed_Nelly;
//            rbFuzeProxNelly.Checked       := WeaponASROC.isFuze_Nelly;


            chkASROCHydr.OnClick          := ASROCClickCheckBox;
            chkASROCLauncher.OnClick      := ASROCClickCheckBox;
            chkASROCLauncherSync.OnClick  := ASROCClickCheckBox;
            chkASROCRocket1.OnClick       := ASROCClickCheckBox;
            chkASROCRocket2.OnClick       := ASROCClickCheckBox;
//            chkAsrockAvailable.OnClick    := ASROCClickCheckBox;
//            chkAsrockAvailable2.OnClick   := ASROCClickCheckBox;
//            chkAsrockSpeed.OnClick        := ASROCClickCheckBox;
//            chkAsrockSpeed2.OnClick       := ASROCClickCheckBox;
//            chkAsrockFuze.OnClick         := ASROCClickCheckBox;
//            chkAsrockFuze2.OnClick        := ASROCClickCheckBox;

//            rbAvailableErika.OnClick      := ASROCClickRadioBtn;
//            rbEmptyErika.OnClick          := ASROCClickRadioBtn;
//            rbSpeedLowErika.OnClick       := ASROCClickRadioBtn;
//            rbSpeedHighErika.OnClick      := ASROCClickRadioBtn;
//            rbFuzeTimeErika.OnClick       := ASROCClickRadioBtn;
//            rbFuzeProxErika.OnClick       := ASROCClickRadioBtn;

//            rbAvailableNelly.OnClick      := ASROCClickRadioBtn;
//            rbEmptyNelly.OnClick          := ASROCClickRadioBtn;
//            rbSpeedLowNelly.OnClick       := ASROCClickRadioBtn;
//            rbSpeedHighNelly.OnClick      := ASROCClickRadioBtn;
//            rbFuzeTimeNelly.OnClick       := ASROCClickRadioBtn;
//            rbFuzeProxNelly.OnClick       := ASROCClickRadioBtn;

            //loading Missile 1
            case WeaponASROC.LoadingMissile1 of
              tsOff : LoadImageLight(imgLoadAsrock, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAsrock, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadAsrock, LoadImgRunning);
            end;

            case WeaponASROC.LoadingMissile2 of
              tsOff : LoadImageLight(imgLoadAsrock2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAsrock2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadAsrock2, LoadImgRunning);
            end;

            case WeaponASROC.MissileType1 of
              tsEmpty : lblMissile1.Caption := 'Empty';
              tsErika : lblMissile1.Caption := 'Erika';
              tsNelly : lblMissile1.Caption := 'Nelly';
            end;

            case WeaponASROC.MissileType2 of
              tsEmpty : lblMissile2.Caption := 'Empty';
              tsErika : lblMissile2.Caption := 'Erika';
              tsNelly : lblMissile2.Caption := 'Nelly';
            end;


            if Assigned(WeaponASROC.Asroc_TrackObject) then
            begin
              edtASROCAssign1FC.Text := WeaponASROC.Asroc_TrackObject.ObjName;

              btnASROCAssign1FC.Enabled   := false;
              btnASROCDeAssign1FC.Enabled := True;
            end
            else
            begin
              edtASROCAssign1FC.Text := '';

              btnASROCAssign1FC.Enabled   := true;
              btnASROCDeAssign1FC.Enabled := false;
            end;
          end;
        end;

        C_DBID_RBU6000 :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpRBU6000.Visible := True;
             //rzgrpRBU6000.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_RBU then
          begin
            WeaponRBU := TWeaponOn_RBU(weaponship);
            edtRBUTrackLabel.Text := '';

            if Assigned(WeaponRBU.RBU_TrackObject) then
            begin
              btnRBUAssign.Enabled := false;
              btnRbuDeAssign.Enabled := True;

              edtRBUTrackLabel.Text := WeaponRBU.RBU_TrackObject.ObjName;
            end
            else
            begin
              btnRBUAssign.Enabled := True;
              btnRbuDeAssign.Enabled := false;

              edtRBUTrackLabel.Text := '';
            end;



            chkRBUAlirKapal.OnClick       := nil;
            chkRBU_Unformer1Left.OnClick  := nil;
            chkRBU_Unformer2Left.OnClick  := nil;
            chkRBU_Unformer1Right.OnClick := nil;
            chkRBU_Unformer2Right.OnClick := nil;



            chkRBUAlirKapal.Checked       := WeaponRBU.ShipSignal;
            chkRBU_Unformer1Left.Checked  := WeaponRBU.Unformer1Left;
            chkRBU_Unformer2Left.Checked  := WeaponRBU.Unformer2Left;
            chkRBU_Unformer1Right.Checked := WeaponRBU.Unformer1Right;
            chkRBU_Unformer2Right.Checked := WeaponRBU.Unformer2Right;



            chkRBUAlirKapal.OnClick       := RBUCbbClick;
            chkRBU_Unformer1Left.OnClick  := RBUCbbClick;
            chkRBU_Unformer2Left.OnClick  := RBUCbbClick;
            chkRBU_Unformer1Right.OnClick := RBUCbbClick;
            chkRBU_Unformer2Right.OnClick := RBUCbbClick;

            //loading port Missile 1
            case WeaponRBU.Launcher1Missile1 of
              tsOff : LoadImageLight(imgRBU1Load1, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load1, LoadImgRunning);
            end;

            //loading port Missile 2
            case WeaponRBU.Launcher1Missile2 of
              tsOff : LoadImageLight(imgRBU1Load2, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load2, LoadImgRunning);
            end;

              //loading port Missile 3
            case WeaponRBU.Launcher1Missile3 of
              tsOff : LoadImageLight(imgRBU1Load3, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load3, LoadImgRunning);
            end;

            //loading port Missile 4
            case WeaponRBU.Launcher1Missile4 of
              tsOff : LoadImageLight(imgRBU1Load4, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load4, LoadImgRunning);
            end;

            //loading port Missile 5
            case WeaponRBU.Launcher1Missile5 of
              tsOff : LoadImageLight(imgRBU1Load5, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load5, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load5, LoadImgRunning);
            end;

            //loading port Missile 6
            case WeaponRBU.Launcher1Missile6 of
              tsOff : LoadImageLight(imgRBU1Load6, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load6, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load6, LoadImgRunning);
            end;

              //loading port Missile 7
            case WeaponRBU.Launcher1Missile7 of
              tsOff : LoadImageLight(imgRBU1Load7, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load7, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load7, LoadImgRunning);
            end;

            //loading port Missile 8
            case WeaponRBU.Launcher1Missile8 of
              tsOff : LoadImageLight(imgRBU1Load8, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load8, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load8, LoadImgRunning);
            end;

            //loading port Missile 9
            case WeaponRBU.Launcher1Missile9 of
              tsOff : LoadImageLight(imgRBU1Load9, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load9, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load9, LoadImgRunning);
            end;

            //loading port Missile 10
            case WeaponRBU.Launcher1Missile10 of
              tsOff : LoadImageLight(imgRBU1Load10, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load10, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load10, LoadImgRunning);
            end;

              //loading port Missile 11
            case WeaponRBU.Launcher1Missile11 of
              tsOff : LoadImageLight(imgRBU1Load11, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load11, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load11, LoadImgRunning);
            end;

            //loading port Missile 12
            case WeaponRBU.Launcher1Missile12 of
              tsOff : LoadImageLight(imgRBU1Load12, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU1Load12, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU1Load12, LoadImgRunning);
            end;

            //loading starboard Missile 1
            case WeaponRBU.Launcher2Missile1 of
              tsOff : LoadImageLight(imgRBU2Load1, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load1, LoadImgRunning);
            end;

            //loading starboard Missile 2
            case WeaponRBU.Launcher2Missile2 of
              tsOff : LoadImageLight(imgRBU2Load2, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load2, LoadImgRunning);
            end;

            //loading starboard Missile 3
            case WeaponRBU.Launcher2Missile3 of
              tsOff : LoadImageLight(imgRBU2Load3, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load3, LoadImgRunning);
            end;

            //loading starboard Missile 4
            case WeaponRBU.Launcher2Missile4 of
              tsOff : LoadImageLight(imgRBU2Load4, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load4, LoadImgRunning);
            end;

            //loading starboard Missile 5
            case WeaponRBU.Launcher2Missile5 of
              tsOff : LoadImageLight(imgRBU2Load5, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load5, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load5, LoadImgRunning);
            end;

            //loading starboard Missile 6
            case WeaponRBU.Launcher2Missile6 of
              tsOff : LoadImageLight(imgRBU2Load6, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load6, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load6, LoadImgRunning);
            end;

            //loading starboard Missile 7
            case WeaponRBU.Launcher2Missile7 of
              tsOff : LoadImageLight(imgRBU2Load7, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load7, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load7, LoadImgRunning);
            end;

            //loading starboard Missile 8
            case WeaponRBU.Launcher2Missile8 of
              tsOff : LoadImageLight(imgRBU2Load8, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load8, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load8, LoadImgRunning);
            end;

            //loading starboard Missile 9
            case WeaponRBU.Launcher2Missile9 of
              tsOff : LoadImageLight(imgRBU2Load9, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load9, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load9, LoadImgRunning);
            end;

            //loading starboard Missile 10
            case WeaponRBU.Launcher2Missile10 of
              tsOff : LoadImageLight(imgRBU2Load10, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load10, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load10, LoadImgRunning);
            end;

            //loading starboard Missile 11
            case WeaponRBU.Launcher2Missile11 of
              tsOff : LoadImageLight(imgRBU2Load11, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load11, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load11, LoadImgRunning);
            end;

            //loading starboard Missile 12
            case WeaponRBU.Launcher2Missile12 of
              tsOff : LoadImageLight(imgRBU2Load12, LoadImgOff);
              tsLoading : LoadImageLight(imgRBU2Load12, LoadImgLoading);
              tsLaunch : LoadImageLight(imgRBU2Load12, LoadImgRunning);
            end;


          end;
        end;

        C_DBID_TORPEDO_SUT :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
            rzgrpTocos.Visible := True;
            //rzgrpTocos.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_TOCOS then
          begin
            WeaponTOCOS := TWeaponOn_TOCOS(weaponship);

            cbbTOCOSTempWEC.OnClick             := nil;
            cbbTOCOSTempTEC.OnClick             := nil;
            cbbTOCOSFuseWEC.OnClick             := nil;
            cbbTOCOSFuseTCC.OnClick             := nil;
            cbbTOCOSPwrRstWEC.OnClick           := nil;
            cbbTOCOSPwrRstTCC.OnClick           := nil;
            cbbTOCOSCMPTR.OnClick               := nil;
            cbbTOCOSSOFTTW.OnClick              := nil;
            cbbTOCOSNUG1.OnClick                := nil;
            cbbTOCOSNUG2.OnClick                := nil;
            cbbTOCOSAntiCondensHeating.OnClick  := nil;
            cbbTOCOSLoadProgram.OnClick         := nil;
            cbbTOCOSPortInP.OnClick             := nil;
            cbbTOCOSPortSupply.OnClick          := nil;
            cbbTOCOSPort120.OnClick             := nil;
            cbbTOCOSPort20.OnClick              := nil;
            cbbTOCOSPortDoorOpen.OnClick        := nil;
            cbbTOCOSPortTorpOpen.OnClick        := nil;
            cbbTOCOSPortRtoFire.OnClick         := nil;
            cbbTOCOSStbInP.OnClick              := nil;
            cbbTOCOSStbSupply.OnClick           := nil;
            cbbTOCOSStb120.OnClick              := nil;
            cbbTOCOSStb20.OnClick               := nil;
            cbbTOCOSStbDoorOpen.OnClick         := nil;
            cbbTOCOSStbTorpOpen.OnClick         := nil;
            cbbTOCOSStbRtoFire.OnClick          := nil;
            cbbTOCOSExtStabAvl.OnClick          := nil;
            cbbTOCOSCasAblAvl.OnClick           := nil;

            cbbTOCOSTempWEC.Checked             := WeaponTOCOS.TempWEC;
            cbbTOCOSTempTEC.Checked             := WeaponTOCOS.TempTCC;
            cbbTOCOSFuseWEC.Checked             := WeaponTOCOS.FuseWEC;
            cbbTOCOSFuseTCC.Checked             := WeaponTOCOS.FuseTCC;
            cbbTOCOSPwrRstWEC.Checked           := WeaponTOCOS.PowerResetWEC;
            cbbTOCOSPwrRstTCC.Checked           := WeaponTOCOS.PowerResetTCC;
            cbbTOCOSCMPTR.Checked               := WeaponTOCOS.CMPTR;
            cbbTOCOSSOFTTW.Checked              := WeaponTOCOS.SOFTW;
            cbbTOCOSNUG1.Checked                := WeaponTOCOS.NUG_1;
            cbbTOCOSNUG2.Checked                := WeaponTOCOS.NUG_2;
            cbbTOCOSAntiCondensHeating.Checked  := WeaponTOCOS.AntiCondensHeating;
            cbbTOCOSLoadProgram.Checked         := WeaponTOCOS.LOADPROGR;
            cbbTOCOSPortInP.Checked             := WeaponTOCOS.Port_Indikator_Port;
            cbbTOCOSPortSupply.Checked          := WeaponTOCOS.Port_ToSupply;
            cbbTOCOSPort120.Checked             := WeaponTOCOS.Port_120_BAR;
            cbbTOCOSPort20.Checked              := WeaponTOCOS.Port_20_BAR;
            cbbTOCOSPortDoorOpen.Checked        := WeaponTOCOS.Port_DOOR_Open;
            cbbTOCOSPortTorpOpen.Checked        := WeaponTOCOS.Port_TORP_On;
            cbbTOCOSPortRtoFire.Checked         := WeaponTOCOS.Port_Ready_To_Fire;
            cbbTOCOSStbInP.Checked              := WeaponTOCOS.STB_Indikator_Port;
            cbbTOCOSStbSupply.Checked           := WeaponTOCOS.STB_ToSupply;
            cbbTOCOSStb120.Checked              := WeaponTOCOS.STB_120_BAR;
            cbbTOCOSStb20.Checked               := WeaponTOCOS.STB_20_BAR;
            cbbTOCOSStbDoorOpen.Checked         := WeaponTOCOS.STB_DOOR_Open;
            cbbTOCOSStbTorpOpen.Checked         := WeaponTOCOS.STB_TORP_On;
            cbbTOCOSStbRtoFire.Checked          := WeaponTOCOS.STB_Ready_To_Fire;
            cbbTOCOSExtStabAvl.Checked          := WeaponTOCOS.EXTSTABAVL;
            cbbTOCOSCasAblAvl.Checked           := WeaponTOCOS.CASSTABAVL;

            cbbTOCOSTempWEC.OnClick             := TOCOSCbbClick;
            cbbTOCOSTempTEC.OnClick             := TOCOSCbbClick;
            cbbTOCOSFuseWEC.OnClick             := TOCOSCbbClick;
            cbbTOCOSFuseTCC.OnClick             := TOCOSCbbClick;
            cbbTOCOSPwrRstWEC.OnClick           := TOCOSCbbClick;
            cbbTOCOSPwrRstTCC.OnClick           := TOCOSCbbClick;
            cbbTOCOSCMPTR.OnClick               := TOCOSCbbClick;
            cbbTOCOSSOFTTW.OnClick              := TOCOSCbbClick;
            cbbTOCOSNUG1.OnClick                := TOCOSCbbClick;
            cbbTOCOSNUG2.OnClick                := TOCOSCbbClick;
            cbbTOCOSAntiCondensHeating.OnClick  := TOCOSCbbClick;
            cbbTOCOSLoadProgram.OnClick         := TOCOSCbbClick;
            cbbTOCOSPortInP.OnClick             := TOCOSCbbClick;
            cbbTOCOSPort120.OnClick             := TOCOSCbbClick;
            cbbTOCOSPort20.OnClick              := TOCOSCbbClick;
            cbbTOCOSPortDoorOpen.OnClick        := TOCOSCbbClick;
            cbbTOCOSPortTorpOpen.OnClick        := TOCOSCbbClick;
            cbbTOCOSPortRtoFire.OnClick         := TOCOSCbbClick;
            cbbTOCOSStbInP.OnClick              := TOCOSCbbClick;
            cbbTOCOSPortSupply.OnClick          := TOCOSCbbClick;
            cbbTOCOSStbSupply.OnClick           := TOCOSCbbClick;
            cbbTOCOSStb120.OnClick              := TOCOSCbbClick;
            cbbTOCOSStb20.OnClick               := TOCOSCbbClick;
            cbbTOCOSStbDoorOpen.OnClick         := TOCOSCbbClick;
            cbbTOCOSStbTorpOpen.OnClick         := TOCOSCbbClick;
            cbbTOCOSStbRtoFire.OnClick          := TOCOSCbbClick;
            cbbTOCOSExtStabAvl.OnClick          := TOCOSCbbClick;
            cbbTOCOSCasAblAvl.OnClick           := TOCOSCbbClick;

            //loading Missile 1
            case WeaponTOCOS.LoadingMissile1 of
              tsOff : LoadImageLight(imgLoadTocos1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadTocos1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadTocos1, LoadImgRunning);
            end;

            //loading Missile 2
            case WeaponTOCOS.LoadingMissile2 of
              tsOff : LoadImageLight(imgLoadTocos2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadTocos2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadTocos2, LoadImgRunning);
            end;
          end;
        end;

        C_DBID_TORPEDO_A244S :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpSPS115.Visible := True;
             //rzgrpSPS115.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          pmSPSGyro.Items.Clear;
          pmSPSBarrel.Items.Clear;

          for j := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
          begin
            TempWeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[j]);

            if TempWeaponShip.Weapon_Name = WeaponName then
            begin
              for k := 1 to 3 do
              begin
                if ((TempWeaponShip.Weapon_Launcher-1)*3 + k) = 1 then
                begin
                  edtSPSGyroNumber.Text   := 'Gyro 1';
                  edtSPSBarrelNumber.Text := 'Barrel 1';

                  edtSPSGyroval.Text      := getSPS_Gyro_Stat(TWeaponOn_SPS(TempWeaponShip).Gyro1);
                  edtSPSBarrelVal.Text    := getSPS_Barrel_Stat(TWeaponOn_SPS(TempWeaponShip).Barrel1);
                end;

                pmSPSGyroMenuItem         := TMenuItem.Create(pmSPSGyro);
                pmSPSGyroMenuItem.Caption := 'Gyro ' + IntToStr((TempWeaponShip.Weapon_Launcher-1)*3 + k);
                pmSPSGyroMenuItem.Tag     := (TempWeaponShip.Weapon_Launcher-1)*3 + k;
                pmSPSGyroMenuItem.Hint    := IntToStr((TempWeaponShip.Weapon_Launcher-1)*3 + k);
                pmSPSGyroMenuItem.OnClick := PmGyroClick;
                pmSPSGyro.Items.Add(pmSPSGyroMenuItem);

                pmSPSBarrelMenuItem         := TMenuItem.Create(pmSPSBarrel);
                pmSPSBarrelMenuItem.Caption := 'Barrel ' + IntToStr((TempWeaponShip.Weapon_Launcher-1)*3 + k);
                pmSPSBarrelMenuItem.Tag     := (TempWeaponShip.Weapon_Launcher-1)*3 + k;
                pmSPSBarrelMenuItem.Hint    := IntToStr((TempWeaponShip.Weapon_Launcher-1)*3 + k);
                pmSPSBarrelMenuItem.OnClick := PmBarrelClick;
                pmSPSBarrel.Items.Add(pmSPSBarrelMenuItem);
              end;
            end;
          end;

          if weaponship is TWeaponOn_SPS then
          begin
            WeaponSPS := TWeaponOn_SPS(weaponship);

            chkSPSSignal.OnClick          := nil;
            chkSPSNds.OnClick             := nil;
            chkSPSDegreePort.OnClick      := nil;
            chkSPSDegreeStarboard.OnClick := nil;
            chkSPSSelfTest.OnClick        := nil;
            chkSPSTempPort.OnClick        := nil;
            chkSPSTempStb.OnClick         := nil;

            chkSPSSignal.Checked          := WeaponSPS.is115V;
            chkSPSNds.Checked             := WeaponSPS.isNDS;
            chkSPSDegreePort.Checked      := WeaponSPS.isDeg45_Port;
            chkSPSDegreeStarboard.Checked := WeaponSPS.isDeg45_StarBoard;
            chkSPSSelfTest.Checked        := WeaponSPS.isSelf;
            chkSPSTempPort.Checked        := WeaponSPS.isTemp_Port;
            chkSPSTempStb.Checked         := WeaponSPS.isTemp_StarBoard;


            chkSPSSignal.OnClick          := SPSClickCheckBox;
            chkSPSNds.OnClick             := SPSClickCheckBox;
            chkSPSDegreePort.OnClick      := SPSClickCheckBox;
            chkSPSDegreeStarboard.OnClick := SPSClickCheckBox;
            chkSPSSelfTest.OnClick        := SPSClickCheckBox;
            chkSPSTempPort.OnClick        := SPSClickCheckBox;
            chkSPSTempStb.OnClick         := SPSClickCheckBox;

            edtSPSTIUPort.Text            := getSPS_TIU_Stat(WeaponSPS.TIU_Port);
            edtSPSTIUStartBoard.Text      := getSPS_TIU_Stat(WeaponSPS.TIU_StarBoard);

            //loading port Missile 2
            case WeaponSPS.LoadingPortMissile2 of
              tsOff : LoadImageLight(imgLoadSPS2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS2, LoadImgRunning);
            end;

            //loading port Missile 4
            case WeaponSPS.LoadingPortMissile4 of
              tsOff : LoadImageLight(imgLoadSPS4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS4, LoadImgRunning);
            end;

            //loading port Missile 6
            case WeaponSPS.LoadingPortMissile6 of
              tsOff : LoadImageLight(imgLoadSPS6, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS6, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS6, LoadImgRunning);
            end;

            //loading starboard Missile 1
            case WeaponSPS.LoadingStarboardMissile1 of
              tsOff : LoadImageLight(imgLoadSPS1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS1, LoadImgRunning);
            end;

            //loading starboard Missile 3
            case WeaponSPS.LoadingStarboardMissile3 of
              tsOff : LoadImageLight(imgLoadSPS3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS3, LoadImgRunning);
            end;

            //loading starboard Missile 5
            case WeaponSPS.LoadingStarboardMissile5 of
              tsOff : LoadImageLight(imgLoadSPS5, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadSPS5, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadSPS5, LoadImgRunning);
            end;

          end
        end;

        C_DBID_TETRAL :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpTetral.Visible := True;
             //rzgrpTetral.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Tetral then
          begin
            WeaponTetral := TWeaponOn_Tetral(weaponship);

            chkTetralFwd.OnClick  := nil;
            chkTetralAft.OnClick  := nil;

            chkTetralFwd.Checked  := WeaponTetral.TetralFwd;
            chkTetralAft.Checked  := WeaponTetral.TetralAft;


            chkTetralFwd.OnClick  := TetralChkClick;
            chkTetralAft.OnClick  := TetralChkClick;

            //loading FWD Missile 1
            case WeaponTetral.FWDMissile1 of
              tsOff : LoadImageLight(imgLoadFWDTet1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadFWDTet1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadFWDTet1, LoadImgRunning);
            end;

            //loading FWD Missile 2
            case WeaponTetral.FWDMissile2 of
              tsOff : LoadImageLight(imgLoadFWDTet2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadFWDTet2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadFWDTet2, LoadImgRunning);
            end;

            //loading FWD Missile 3
            case WeaponTetral.FWDMissile3 of
              tsOff : LoadImageLight(imgLoadFWDTet3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadFWDTet3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadFWDTet3, LoadImgRunning);
            end;

            //loading FWD Missile 4
            case WeaponTetral.FWDMissile4 of
              tsOff : LoadImageLight(imgLoadFWDTet4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadFWDTet4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadFWDTet4, LoadImgRunning);
            end;

            //loading AFT Missile 1
            case WeaponTetral.AFTMissile1 of
              tsOff : LoadImageLight(imgLoadAFTTet1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAFTTet1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadAFTTet1, LoadImgRunning);
            end;

            //loading AFT Missile 2
            case WeaponTetral.AFTMissile2 of
              tsOff : LoadImageLight(imgLoadAFTTet2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAFTTet2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrRight2, LoadImgRunning);
            end;

            //loading AFT Missile 3
            case WeaponTetral.AFTMissile3 of
              tsOff : LoadImageLight(imgLoadAFTTet3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAFTTet3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadAFTTet3, LoadImgRunning);
            end;

            //loading AFT Missile 4
            case WeaponTetral.AFTMissile4 of
              tsOff : LoadImageLight(imgLoadAFTTet4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadAFTTet4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadAFTTet4, LoadImgRunning);
            end;
          end;
        end;

        C_DBID_C802 :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpC802.Visible := True;
             //rzgrpC802.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_C802 then
          begin
            WeaponC802 := TWeaponOn_C802(weaponship);
            edtC802Track.Text := '';

            if Assigned(WeaponC802.C802_TrackObject) then
            begin
              btnC802Assign.Enabled   := False;
              btnC802DeAssign.Enabled := True;
              edtC802Track.Text       := WeaponC802.C802_TrackObject.ObjName;
            end
            else
            begin
              btnC802Assign.Enabled   := True;
              btnC802DeAssign.Enabled := False;
              edtC802Track.Text       := '';
            end;


            chkC802PreLaunchCheck1.OnClick        := nil;
            chkC802PreLaunchCheck2.OnClick        := nil;
            chkC802PreLaunchCheck3.OnClick        := nil;
            chkC802PreLaunchCheck4.OnClick        := nil;

            chkC802LaunchReadyCondition1.OnClick  := nil;
            chkC802LaunchReadyCondition2.OnClick  := nil;
            chkC802LaunchReadyCondition3.OnClick  := nil;
            chkC802LaunchReadyCondition4.OnClick  := nil;

            chkC802Launch1.OnClick                := nil;
            chkC802Launch2.OnClick                := nil;
            chkC802Launch3.OnClick                := nil;
            chkC802Launch4.OnClick                := nil;

            chkC802PreLaunchCheck1.Checked        := WeaponC802.STAT_C802_PRECHECK_LAUNCHER1;
            chkC802PreLaunchCheck2.Checked        := WeaponC802.STAT_C802_PRECHECK_LAUNCHER2;
            chkC802PreLaunchCheck3.Checked        := WeaponC802.STAT_C802_PRECHECK_LAUNCHER3;
            chkC802PreLaunchCheck4.Checked        := WeaponC802.STAT_C802_PRECHECK_LAUNCHER4;

            chkC802LaunchReadyCondition1.Checked  := WeaponC802.STAT_C802_READYCONDITION_LAUNCHER1;
            chkC802LaunchReadyCondition2.Checked  := WeaponC802.STAT_C802_READYCONDITION_LAUNCHER2;
            chkC802LaunchReadyCondition3.Checked  := WeaponC802.STAT_C802_READYCONDITION_LAUNCHER3;
            chkC802LaunchReadyCondition4.Checked  := WeaponC802.STAT_C802_READYCONDITION_LAUNCHER4;

            chkC802Launch1.Checked                := WeaponC802.STAT_C802_LAUNCH_LAUNCHER1;
            chkC802Launch2.Checked                := WeaponC802.STAT_C802_LAUNCH_LAUNCHER2;
            chkC802Launch3.Checked                := WeaponC802.STAT_C802_LAUNCH_LAUNCHER3;
            chkC802Launch4.Checked                := WeaponC802.STAT_C802_LAUNCH_LAUNCHER4;

            chkC802PreLaunchCheck1.OnClick        := C802ChkClick;
            chkC802PreLaunchCheck2.OnClick        := C802ChkClick;
            chkC802PreLaunchCheck3.OnClick        := C802ChkClick;
            chkC802PreLaunchCheck4.OnClick        := C802ChkClick;

            chkC802LaunchReadyCondition1.OnClick  := C802ChkClick;
            chkC802LaunchReadyCondition2.OnClick  := C802ChkClick;
            chkC802LaunchReadyCondition3.OnClick  := C802ChkClick;
            chkC802LaunchReadyCondition4.OnClick  := C802ChkClick;

            chkC802Launch1.OnClick                := C802ChkClick;
            chkC802Launch2.OnClick                := C802ChkClick;
            chkC802Launch3.OnClick                := C802ChkClick;
            chkC802Launch4.OnClick                := C802ChkClick;

            //loading Missile 1
            case WeaponC802.LoadingMissile1 of
              tsOff : LoadImageLight(imgLoadC802_1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadC802_1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadC802_1, LoadImgRunning);
            end;

            case WeaponC802.LoadingMissile2 of
              tsOff : LoadImageLight(imgLoadC802_2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadC802_2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadC802_2, LoadImgRunning);
            end;

            case WeaponC802.LoadingMissile3 of
              tsOff : LoadImageLight(imgC802_3, LoadImgOff);
              tsLoading : LoadImageLight(imgC802_3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgC802_3, LoadImgRunning);
            end;

            case WeaponC802.LoadingMissile4 of
              tsOff : LoadImageLight(imgC802_4, LoadImgOff);
              tsLoading : LoadImageLight(imgC802_4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgC802_4, LoadImgRunning);
            end;
          end;

        end;

        C_DBID_YAKHONT :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpYakhont.Visible := True;
             //rzgrpYakhont.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Yakhont then
          begin
            Weaponyakhont := TWeaponOn_Yakhont(weaponship);
            edtYAKHONTTtrack.Text := '';

            if Assigned(WeaponYakhont.YAKHONT_TrackObject) then
            begin
              btnYAKHONTAssign.Enabled := false;
              btnYAKHONTDeAssign.Enabled := True;

              edtYAKHONTTtrack.Text := WeaponYakhont.YAKHONT_TrackObject.ObjName;
            end
            else
            begin
              btnYAKHONTAssign.Enabled := True;
              btnYAKHONTDeAssign.Enabled := false;

              edtYAKHONTTtrack.Text := '';
            end;

            chkYakhont_Printer.OnClick    := nil;
            chkYakhontConsoleN1.OnClick   := nil;
            chkYakhontConsoleN2.OnClick   := nil;
            chkYakhontLauncherR1.OnClick  := nil;
            chkYakhontLauncherR3.OnClick  := nil;
            chkYakhontLauncherL2.OnClick  := nil;
            chkYakhontLauncherL4.OnClick  := nil;
            chkYakhontKR231.OnClick       := nil;
            chkYakhontGyro.OnClick        := nil;
            chkYakhontINS300V.OnClick     := nil;
            chkYakhontINS27V.OnClick      := nil;

            chkYakhont_Printer.Checked    := WeaponYakhont.STAT_YAKHONT_PRINTER;
            chkYakhontConsoleN1.Checked   := WeaponYakhont.STAT_YAKHONT_CONSOLE_N1;
            chkYakhontConsoleN2.Checked   := WeaponYakhont.STAT_YAKHONT_CONSOLE_N2;
            chkYakhontLauncherR1.Checked  := WeaponYakhont.STAT_YAKHONT_RIGHT_1;
            chkYakhontLauncherR3.Checked  := WeaponYakhont.STAT_YAKHONT_RIGHT_3;
            chkYakhontLauncherL2.Checked  := WeaponYakhont.STAT_YAKHONT_LEFT_2;
            chkYakhontLauncherL4.Checked  := WeaponYakhont.STAT_YAKHONT_LEFT_4;
            chkYakhontKR231.Checked       := WeaponYakhont.STAT_YAKHONT_KR231;
            chkYakhontGyro.Checked        := WeaponYakhont.STAT_YAKHONT_GYRO;
            chkYakhontINS300V.Checked     := WeaponYakhont.STAT_YAKHONT_INS300V;
            chkYakhontINS27V.Checked      := WeaponYakhont.STAT_YAKHONT_INS27V;

            chkYakhont_Printer.OnClick    := YakhontChkClick;
            chkYakhontConsoleN1.OnClick   := YakhontChkClick;
            chkYakhontConsoleN2.OnClick   := YakhontChkClick;
            chkYakhontLauncherR1.OnClick  := YakhontChkClick;
            chkYakhontLauncherR3.OnClick  := YakhontChkClick;
            chkYakhontLauncherL2.OnClick  := YakhontChkClick;
            chkYakhontLauncherL4.OnClick  := YakhontChkClick;
            chkYakhontKR231.OnClick       := YakhontChkClick;
            chkYakhontGyro.OnClick        := YakhontChkClick;
            chkYakhontINS300V.OnClick     := YakhontChkClick;
            chkYakhontINS27V.OnClick      := YakhontChkClick;

            //loading Missile 1
            case WeaponYakhont.LoadingMissile1 of
              tsOff : LoadImageLight(imgLoadYakhont1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadYakhont1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadYakhont1, LoadImgRunning);
            end;

            //loading Missile 2
            case WeaponYakhont.LoadingMissile2 of
              tsOff : LoadImageLight(imgLoadYakhont2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadYakhont2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadYakhont2, LoadImgRunning);
            end;

            //loading Missile 3
            case WeaponYakhont.LoadingMissile3 of
              tsOff : LoadImageLight(imgLoadYakhont3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadYakhont3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadYakhont3, LoadImgRunning);
            end;

            //loading Missile 4
            case WeaponYakhont.LoadingMissile4 of
              tsOff : LoadImageLight(imgLoadYakhont4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadYakhont4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadYakhont4, LoadImgRunning);
            end;

          end;
        end;

        C_DBID_MISTRAL  :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpMistral.Visible := True;
             //rzgrpMistral.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Mistral then
          begin
            WeaponMistral := TWeaponOn_Mistral(weaponship);

            //chkMistralLaunch1.OnClick  := nil;
            //chkMistralLaunc2.OnClick   := nil;

            //chkMistralLaunch1.Checked  := WeaponMistral.MistralLaunch1;
            //chkMistralLaunc2.Checked   := WeaponMistral.MistralLaunch2;

            //chkMistralLaunch1.OnClick  := MistralChkClick;
            //chkMistralLaunc2.OnClick   := MistralChkClick;

            //loading port Missile 1
            case WeaponMistral.portMissile1 of
              tsOff : LoadImageLight(imgLeftMis1, LoadImgOff);
              tsLoading : LoadImageLight(imgLeftMis1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLeftMis1, LoadImgRunning);
            end;

            //loading port Missile 2
            case WeaponMistral.portMissile2 of
              tsOff : LoadImageLight(imgLeftMis2, LoadImgOff);
              tsLoading : LoadImageLight(imgLeftMis2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLeftMis2, LoadImgRunning);
            end;

            //loading starboard Missile 1
            case WeaponMistral.StarboardMissile1 of
              tsOff : LoadImageLight(imgLoadMisRight1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadMisRight1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadMisRight1, LoadImgRunning);
            end;

            //loading starboard Missile 2
            case WeaponMistral.StarboardMissile2 of
              tsOff : LoadImageLight(imgLoadRightMis2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadRightMis2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadRightMis2, LoadImgRunning);
            end;
          end;
        end;

        C_DBID_STRELA  :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpStrela.Visible := True;
             //rzgrpStrela.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Strella then
          begin
            WeaponStrela := TWeaponOn_Strella(weaponship);
//
//            chkStrelaLaunch1.OnClick  := nil;
//            chkStrelaLaunch2.OnClick  := nil;
//            chkStrelaLaunch3.OnClick  := nil;
//            chkStrelaLaunch4.OnClick  := nil;
//
//            chkStrelaLaunch1.Checked  := WeaponStrela.StrelaLauncer1;
//            chkStrelaLaunch2.Checked  := WeaponStrela.StrelaLauncer2;
//            chkStrelaLaunch3.Checked  := WeaponStrela.StrelaLauncer3;
//            chkStrelaLaunch4.Checked  := WeaponStrela.StrelaLauncer4;
//
//
//            chkStrelaLaunch1.OnClick  := StrelaChkClick;
//            chkStrelaLaunch2.OnClick  := StrelaChkClick;
//            chkStrelaLaunch3.OnClick  := StrelaChkClick;
//            chkStrelaLaunch4.OnClick  := StrelaChkClick;

            //loading port Missile 1
            case WeaponStrela.portMissile1 of
              tsOff : LoadImageLight(imgLoadStrLeft1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrLeft1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrLeft1, LoadImgRunning);
            end;

            //loading port Missile 2
            case WeaponStrela.portMissile2 of
              tsOff : LoadImageLight(imgLoadStrLeft2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrLeft2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrLeft2, LoadImgRunning);
            end;

              //loading port Missile 3
            case WeaponStrela.portMissile3 of
              tsOff : LoadImageLight(imgLoadStrLeft3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrLeft3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrLeft3, LoadImgRunning);
            end;

            //loading port Missile 4
            case WeaponStrela.portMissile4 of
              tsOff : LoadImageLight(imgLoadStrLeft4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrLeft4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrLeft4, LoadImgRunning);
            end;

            //loading starboard Missile 1
            case WeaponStrela.StarboardMissile1 of
              tsOff : LoadImageLight(imgLoadRightStr1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadRightStr1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadRightStr1, LoadImgRunning);
            end;

            //loading starboard Missile 2
            case WeaponStrela.StarboardMissile2 of
              tsOff : LoadImageLight(imgLoadStrRight2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrRight2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrRight2, LoadImgRunning);
            end;

            //loading starboard Missile 3
            case WeaponStrela.StarboardMissile3 of
              tsOff : LoadImageLight(imgLoadStrRight3, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrRight3, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrRight3, LoadImgRunning);
            end;

            //loading starboard Missile 4
            case WeaponStrela.StarboardMissile4 of
              tsOff : LoadImageLight(imgLoadStrRight4, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadStrRight4, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadStrRight4, LoadImgRunning);
            end;

          end;
        end;

        C_DBID_EXOCET_MM40 :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpExocetMM40.Visible := True;
             //rzgrpExocetMM40.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_EXOCET40 then
          begin
            WeaponExocet40 := TWeaponOn_EXOCET40(weaponship);

            chkExocet40.OnClick := nil;
            chkSafetyFA.OnClick := nil;
            chkControlFA.OnClick := nil;

            chkExocet40.Checked := WeaponExocet40.EnableExocet40;
            chkSafetyFA.Checked := WeaponExocet40.SafetyFA;
            chkControlFA.Checked := WeaponExocet40.ControlFA;

            chkExocet40.OnClick := Exocet40ChkClick;
            chkSafetyFA.OnClick := Exocet40ChkClick;
            chkControlFA.OnClick := Exocet40ChkClick;

            if WeaponExocet40.Firing then
            begin
              chkSafetyFA.Enabled   := True;
              chkControlFA.Enabled  := True;
            end
            else
            begin
              chkSafetyFA.Enabled   := False;
              chkControlFA.Enabled  := False;
            end;

            //loading port Missile 1
            case WeaponExocet40.portMissile1 of
              tsOff : LoadImageLight(imgLoadExoLeft1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadExoLeft1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadExoLeft1, LoadImgRunning);
            end;

            //loading port Missile 2
            case WeaponExocet40.portMissile2 of
              tsOff : LoadImageLight(imgLoadExoLeft2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadExoLeft2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadExoLeft2, LoadImgRunning);
            end;

            //loading starboard Missile 1
            case WeaponExocet40.StarboardMissile1 of
              tsOff : LoadImageLight(imgLoadExoRight1, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadExoRight1, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadExoRight1, LoadImgRunning);
            end;

            //loading starboard Missile 2
            case WeaponExocet40.StarboardMissile2 of
              tsOff : LoadImageLight(imgLoadExoRight2, LoadImgOff);
              tsLoading : LoadImageLight(imgLoadExoRight2, LoadImgLoading);
              tsLaunch : LoadImageLight(imgLoadExoRight2, LoadImgRunning);
            end;

          end;
        end;

        C_DBID_CANNON40  :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
            // rzgrpCannon40.Visible := True;
             //rzgrpCannon40.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Cannon40 then
          begin
            WeaponCannon40 := TWeaponOn_Cannon40(weaponship);

            //chkCannon40EnableCannon.OnClick := nil;
            //chkCannon40EnableCannon.Checked := WeaponCannon40.EnableCannon40;
            //chkCannon40EnableCannon.OnClick := Cannon40ChkClick;
          end;
        end;

        C_DBID_CANNON57  :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             //rzgrpCannon57.Visible := True;
             //rzgrpCannon57.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Cannon57 then
          begin
            WeaponCannon57 := TWeaponOn_Cannon57(weaponship);

           // chkCannon57enableWeaphon.OnClick := nil;
            //chkCannon57enableWeaphon.Checked := WeaponCannon57.EnableCannon57;
           // chkCannon57enableWeaphon.OnClick := Cannon57ChkClick;
          end;
        end;

        C_DBID_CANNON76  :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
              rzgrpCannon76.Visible := True;
//              rzgrpCannon76.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_Cannon76 then
          begin
            WeaponCannon76 := TWeaponOn_Cannon76(weaponship);

            chkCannon76.OnClick := nil;
            chkCannon76.Checked := WeaponCannon76.EnableCannon76;
            chkCannon76.OnClick := Cannon76ChkClick;
          end;
        end;

        C_DBID_CANNON120 :
        begin

        end;

        C_DBID_MOCCONSOLE :
        begin
          if frmMainInstruktur.cekStatusWeapon = 1 then
          begin
             rzgrpMOCsigma.Visible := True;
             rzgrpMOCsigma.Opened := True;
          end;
          frmMainInstruktur.cekStatusWeapon := 1;

          if weaponship is TWeaponOn_MOC then
          begin
            WeaponMoc := TWeaponOn_MOC(weaponship);

            chkMocMW08.OnClick       := nil;
            chkMocRadarAPPA.OnClick  := nil;
            chkMocLirodMK2.OnClick   := nil;
            chkMocKingklip.OnClick   := nil;

            chkMocMW08.Checked      := WeaponMOC.RadarMW;
            chkMocRadarAPPA.Checked := WeaponMOC.RadarARPA;
            chkMocLirodMK2.Checked  := WeaponMOC.LirodMK2;
            chkMocKingklip.Checked  := WeaponMOC.SonarKingklip;

            chkMocMW08.OnClick       := MOCChkClick;
            chkMocRadarAPPA.OnClick  := MOCChkClick;
            chkMocLirodMK2.OnClick   := MOCChkClick;
            chkMocKingklip.OnClick   := MOCChkClick;
          end;
        end;
      end;

      Break;
    end;
  end;
end;

procedure TfWeaponStatus.btnTrackObject(Sender: Tobject);
begin
  case TComponent(sender).Tag of
    //ASROC
    1 :
    begin
      SimManager.FMap.CurrentTool := TOOL_SELECT_ASROCTARGET;
    end;
    //YAHKONT
    2 :
    begin
      SimManager.FMap.CurrentTool := TOOL_SELECT_YAKHONTTARGET;
    end;
    //RBU
    3 :
    begin
      SimManager.FMap.CurrentTool := TOOL_SELECT_RBUTARGET;
    end;
    //C802
    4 :
    begin
      SimManager.FMap.CurrentTool := TOOL_SELECT_C802TARGET;
    end;
    //SPS
    5 :
    begin
      SimManager.FMap.CurrentTool := TOOL_SELECT_SPSTARGET;
    end;
  end;
end;

procedure TfWeaponStatus.StrelaChkClick(sender: Tobject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponStrela  : TWeaponOn_Strella;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_STRELA then
    begin
      if weaponship is TWeaponOn_Strella then
      begin
        WeaponStrela := TWeaponOn_Strella(weaponship);

        case id of
          __STAT_STRELA_LAUNCER1 : WeaponStrela.StrelaLauncer1    := TCheckBox(sender).Checked;
          __STAT_STRELA_LAUNCER2 : WeaponStrela.StrelaLauncer2    := TCheckBox(sender).Checked;
          __STAT_STRELA_LAUNCER3 : WeaponStrela.StrelaLauncer2    := TCheckBox(sender).Checked;
          __STAT_STRELA_LAUNCER4 : WeaponStrela.StrelaLauncer2    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_STRELA, id , aParam);
end;

procedure TfWeaponStatus.MistralChkClick(sender: Tobject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponMistral  : TWeaponOn_Mistral;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_MISTRAL then
    begin
      if weaponship is TWeaponOn_Mistral then
      begin
        WeaponMistral := TWeaponOn_Mistral(weaponship);

        case id of
          __STAT_MISTRAL_LAUNCER1 : WeaponMistral.MistralLaunch1    := TCheckBox(sender).Checked;
          __STAT_MISTRAL_LAUNCER2 : WeaponMistral.MistralLaunch2    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_MISTRAL, id , aParam);
end;

procedure TfWeaponStatus.Cannon40ChkClick(sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponCannon40  : TWeaponOn_Cannon40;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_CANNON40 then
    begin
      if weaponship is TWeaponOn_Cannon40 then
      begin
        WeaponCannon40 := TWeaponOn_Cannon40(weaponship);

        case id of
          __STAT_CANNON40_ENABLE : WeaponCannon40.EnableCannon40    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_CANNON40, id , aParam);
end;

procedure TfWeaponStatus.Cannon57ChkClick(sender: TObject);
var
  aTag : integer;
  ShipStrID : string;
  aParam : Integer;

  i, id : Integer;
  Weaponship  : TWeaponOnShip;
  WeaponCannon57  : TWeaponOn_Cannon57;
begin
  if SimManager.TrackObject = nil then exit;
  id := TCheckBox(sender).Tag;

  //set object
  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    weaponship := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);
    if weaponship.Weapon_ID = C_DBID_CANNON57 then
    begin
      if weaponship is TWeaponOn_Cannon57 then
      begin
        WeaponCannon57 := TWeaponOn_Cannon57(weaponship);

        case id of
          __STAT_CANNON57_ENABLE : WeaponCannon57.EnableCannon57    := TCheckBox(sender).Checked;
        end;
      end;
    end;
  end;

  ShipStrID := dbID_to_UniqueID(SimManager.TrackObject.FDataBaseID);

  if TCheckBox(sender).Checked = True then
    aParam := 1
  else
    aParam := 2;

  SimManager.NetSendStatConsole(ShipStrID, C_DBID_CANNON57, id , aParam);
end;

procedure TfWeaponStatus.btnExocet40LoadingClick(Sender: TObject);
var
  i, missileID,
  launcherID, j  : Integer;
  weaponShip     : TWeaponOnShip;
  weaponExocet   : TWeaponOn_EXOCET40;
  recsend        : TRec3DSetExocet_40;
begin
  if SimManager.TrackObject = nil then Exit;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_EXOCET40 then
    begin
      weaponExocet := TWeaponOn_EXOCET40(weaponShip);

      if TComponent(Sender).Tag = 0 then begin
        launcherID := 1;
      end
      else if TComponent(Sender).Tag = 1 then begin
        launcherID := 2;
      end;

      if weaponExocet.Weapon_Launcher = launcherID then
      begin
        if weaponExocet.Weapon_Status = 1 then
        begin
          if ((cbbLoadExoStarboard.Text = '1') and (launcherID = 1))
          or ((cbbLoadExoPort.Text = '1') and (launcherID = 2)) then
          begin
            missileID := 1;
          end
          else if ((cbbLoadExoStarboard.Text = '2') and (launcherID = 1))
          or ((cbbLoadExoPort.Text = '2') and (launcherID = 2)) then
          begin
            missileID := 2;
          end;

          RecSend.shipID                  := SimManager.TrackObject.FDataBaseID;
          RecSend.mWeaponID               := weaponExocet.Weapon_ID;
          RecSend.mLauncherID             := launcherID;
          RecSend.mMissileID              := missileID;
          RecSend.mMissileNumber          := 1;
          RecSend.sOrder                  := __ORD_EXOCET_40_LOADING;

          RecSend.mTBearing               := 0;
          RecSend.mTRange                 := 0;

          RecSend.mAngular_Mode           := 0;
          RecSend.mAgility_Mode           := 0;
          RecSend.mInitialStep_Mode       := 0;

          RecSend.mObstacle_Alt           := 0;
          RecSend.mObstacle_Range         := 0;
          RecSend.mApproach_Range         := 0;
          RecSend.mTerminal_Range         := 0;
          SimManager.NetSendTo3D_OrderMissileExocet_MM40(RecSend);
        end;
      end;
    end;
  end;
end;


procedure TfWeaponStatus.btnMistralLoadingClick(Sender: TObject);
var
  i,  j, missileID
  , launcherID      : Integer;
  weaponShip        : TWeaponOnShip;
  weaponMistral     : TWeaponOn_Mistral;
  recsend           : TRec3DSetMistral;
begin
  if SimManager.TrackObject = nil then Exit;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_Mistral then
    begin
      weaponMistral := TWeaponOn_Mistral(weaponShip);

      if TComponent(Sender).Tag = 1 then
      begin
        launcherID := 1;
      end
      else if TComponent(Sender).Tag = 2 then begin
        launcherID := 2;
      end;

      if ((cbbLoadMisStarboard.Text = '1') and (launcherID = 1))
      or ((cbbLoadMisPort.Text = '1') and (launcherID = 2)) then
      begin
        missileID := 1;
      end
      else if ((cbbLoadMisStarboard.Text = '2') and (launcherID = 1))
      or ((cbbLoadMisPort.Text = '2') and (launcherID = 2)) then
      begin
        missileID := 2;
      end;

      RecSend.shipID                  := SimManager.TrackObject.FDataBaseID;
      RecSend.mWeaponID               := weaponMistral.Weapon_ID;

      recsend.mLauncherID             := launcherID;
      recsend.mMissileID              := missileID;
      RecSend.mMissileNumber          := 1;

      RecSend.OrderID                 := __ORD_MISTRAL_LOADING ;

      RecSend.mTargetBearing          := 0;
      RecSend.mTargetRange            := 0;
      RecSend.mTargetElev             := 0;

      SimManager.NetSendTo3D_OrderMissileMistral(RecSend);

      Break;
    end;
  end;
end;

procedure TfWeaponStatus.btnStrelaLoadingClick(Sender: TObject);
var
  i, count, j, missileID
  , launcherID            : Integer;
  weaponShip              : TWeaponOnShip;
  weaponStrela            : TWeaponOn_Strella;
begin
  if SimManager.TrackObject = nil then Exit;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_Strella then
    begin
      weaponStrela := TWeaponOn_Strella(weaponShip);

        if TComponent(Sender).Tag = 0 then begin
          launcherID := 2;
        end
        else if TComponent(Sender).Tag = 1 then begin
          launcherID := 1;
        end;

        recSendStrella.ShipID                  := SimManager.TrackObject.FDataBaseID;
        recSendStrella.mWeaponID               := weaponStrela.Weapon_ID;

        recSendStrella.mLauncherID             := launcherID;

        recSendStrella.mMissileNumber          := 1;

        recSendStrella.OrderID                 := __ORD_STRELLA_LOADING ;

        recSendStrella.mTargetBearing          := 0;
        recSendStrella.mTargetRange            := 0;
        recSendStrella.mTargetElev             := 0;

        if launcherID = 2 then
        begin
          if cbbLoadStrellaStarboard.Text = 'All' then
          begin
            CountLoading := tmr_STRELLA_STABOARD;
            tmrLoading.Enabled := True;
          end
          else
          begin
            missileID := StrToInt(cbbLoadStrellaStarboard.Text);
            recSendStrella.mMissileID  := missileID;
            SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
          end;
        end
        else if launcherID = 1 then
        begin
          if cbbLoadStrellaPort.Text = 'All' then
          begin
            CountLoading := tmr_STRELLA_PORT;
            tmrLoading.Enabled := True;
          end
          else
          begin
            missileID := StrToInt(cbbLoadStrellaPort.Text);
            recSendStrella.mMissileID  := missileID;
            SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
          end;
        end;
      Break;
    end;
  end;
end;

procedure TfWeaponStatus.btnTetralLoadingClick(Sender: TObject);
var
  i, launcherID, j,
  missileID      : Integer;
  weaponShip     : TWeaponOnShip;
  weaponTetral   : TWeaponOn_Tetral;
//  recsend        : TRec3DSetTetral;
begin
  if SimManager.TrackObject = nil then Exit;

  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_Tetral then
    begin
      weaponTetral := TWeaponOn_Tetral(weaponShip);

        recSendTetral.ShipID                  := SimManager.TrackObject.FDataBaseID;
        recSendTetral.mWeaponID               := weaponTetral.Weapon_ID;

        recSendTetral.mMissileNumber          := 1;

        recSendTetral.OrderID                 := __ORD_TETRAL_LOADING ;

        recSendTetral.mTargetBearing               := 0;
        recSendTetral.mTargetRange                 := 0;
        recSendTetral.mTargetElev                  := 0;

        if TComponent(Sender).Tag = 0 then
        begin
          launcherID := 1;
          recSendTetral.mLauncherID := launcherID;
          if cbbLoadTetralFWD.Text = 'All' then
          begin
            CountLoading := tmr_TETRAL_FWD;
            tmrLoading.Enabled := True;
          end
          else
          begin
            missileID  := StrToInt(cbbLoadTetralFWD.Text);
            recSendTetral.mMissileID := missileID;
            SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
          end;

        end
        else if TComponent(Sender).Tag = 1 then
        begin
          launcherID := 2;
          recSendTetral.mLauncherID := launcherID;
          if cbbLoadTetralAFT.Text = 'All' then
          begin
            CountLoading := tmr_TETRAL_AFT;
            tmrLoading.Enabled := True;
          end
          else
          begin
            missileID  := StrToInt(cbbLoadTetralAFT.Text);
            recSendTetral.mMissileID := missileID;
            SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
          end;

        end;



      Break;
    end;
  end;
end;


procedure TfWeaponStatus.btnTocosLoadingClick(Sender: TObject);
var
  i, launcherID : Integer;
  weaponShip    : TWeaponOnShip;
  weaponSUT     : TWeaponOn_TOCOS;
  recsend       : TRecSetTorpedoSUT;
begin
  if SimManager.TrackObject = nil then Exit;


  for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
  begin
    WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

    if WeaponShip is TWeaponOn_TOCOS then
    begin
      weaponSUT := TWeaponOn_TOCOS(weaponShip);
      if TComponent(Sender).Tag = 0 then begin
        launcherID := 1;
      end
      else if TComponent(Sender).Tag = 1 then begin
        launcherID := 2;
      end;

      if launcherID = weaponSUT.Weapon_Launcher then
      begin
        if weaponSUT.Weapon_Status = 1 then
        begin
          recSend.ShipID                   := SimManager.TrackObject.FDataBaseID;
          recSend.mWeaponID                := weaponSUT.Weapon_ID;
          recSend.mLauncherID              := launcherID;
          recSend.mMissileID               := 1;
          recSend.mMissileNumber           := 1;
          recSend.OrderID                  := __ORD_TORPEDOSUT_LOADING ;
          recsend.mT_ID                    := 0;
          recsend.mTorpedoCourse           := 0;
          RecSend.mTorpedoSpeed            := 0;
          recsend.mTorpedoDepth            := 0;
          recsend.mTorpedoSafeDistance     := 0;
          recsend.mTorpedoEnDis            := 0;
          recsend.mpredm                   := 0;
          recsend.mTargetType              := 0;

          SimManager.NetSendTo3D_OrderMissileSUT(RecSend);
        end;
      end;
    end;
  end;
end;

procedure TfWeaponStatus.LoadImageLight(Aimage: TImage; imgStat: string);
begin
    Aimage.Picture.LoadFromFile(imgStat);
end;


procedure TfWeaponStatus.LoadingStatus(ShipID, WeaponID, LauncherID,
  MissileID : Byte;  Status : TStatusWeapon);
var
  i,j         : integer;
  shipInst    : TInsObject;
  WeaponShip  : TWeaponOnShip;

  WeaponTOCOS      : TWeaponOn_TOCOS;
  WeaponSPS        : TWeaponOn_SPS;
  WeaponAsroc      : TWeaponOn_ASROC;
  WeaponC802       : TWeaponOn_C802;
  WeaponYakhont    : TWeaponOn_Yakhont;
  WeaponMistral    : TWeaponOn_Mistral;
  WeaponStrela     : TWeaponOn_Strella;
  WeaponTetral     : TWeaponOn_Tetral;
  WeaponExocet40   : TWeaponOn_EXOCET40;
  WeaponRBU        : TWeaponOn_RBU;

begin
  for i := 0 to SimManager.MainObjList.ItemCount-1 do
  begin
    shipInst := TInsObject(SimManager.MainObjList.getObject(i));
    if shipInst.FDataBaseID = shipID then
    begin
      for j:=0 to shipInst.WeaponOnShip_List.Count -1 do
      begin
        WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
        if (WeaponShip is TWeaponOn_TOCOS) and (WeaponID = C_DBID_TORPEDO_SUT) then
        begin
          WeaponTOCOS := TWeaponOn_TOCOS(WeaponShip);

          case LauncherID of
            1 : WeaponTOCOS.LoadingMissile1 := Status;
            2 : WeaponTOCOS.LoadingMissile2 := Status;
          end;

//          if rzgrpTocos.Opened = True and rzgrpTocos.Opened = True then
//          begin
            frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//          end;
        end
        else if (WeaponShip is TWeaponOn_SPS) and (WeaponID = C_DBID_TORPEDO_A244S) then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_SPS then
          begin
            WeaponSPS := TWeaponOn_SPS(WeaponShip);

            case LauncherID of
              1 :
              begin
                case MissileID of
                   1 : WeaponSPS.LoadingPortMissile2 := Status;
                   2 : WeaponSPS.LoadingPortMissile4 := Status;
                   3 : WeaponSPS.LoadingPortMissile6 := Status;
                end;
              end;
              2 :
              begin
                case MissileID of
                   1 : WeaponSPS.LoadingStarboardMissile1 := Status;
                   2 : WeaponSPS.LoadingStarboardMissile3 := Status;
                   3 : WeaponSPS.LoadingStarboardMissile5 := Status;
                end;
              end;
            end;
//            if rzgrpSPS115.Opened = True and rzgrpSPS115.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;

          end;

        end
        else if (WeaponShip is TWeaponOn_ASROC) and (WeaponID = C_DBID_ASROC) then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_ASROC then
          begin
            WeaponAsroc := TWeaponOn_ASROC(WeaponShip);

            case LauncherID of
              1 :
              begin
                case MissileID of
                   1 : WeaponAsroc.LoadingMissile1 := Status;
                   2 : WeaponAsroc.LoadingMissile2 := Status;
                end;
              end;

            end;

//            if rzgrpAsroc.Opened = True and rzgrpAsroc.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//           end;
          end;

        end
        else if (WeaponShip is TWeaponOn_C802) and (WeaponID = C_DBID_C802) then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_C802 then
          begin
            WeaponC802 := TWeaponOn_C802(WeaponShip);

            case LauncherID of
              1 : WeaponC802.LoadingMissile1 := Status;
              2 : WeaponC802.LoadingMissile2 := Status;
              3 : WeaponC802.LoadingMissile3 := Status;
              4 : WeaponC802.LoadingMissile4 := Status;
            end;

//            if rzgrpC802.Opened = True and rzgrpC802.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_Yakhont) and (WeaponID = C_DBID_YAKHONT)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_Yakhont then
          begin
            WeaponYakhont := TWeaponOn_Yakhont(WeaponShip);

            case LauncherID of
              1 : WeaponYakhont.LoadingMissile1 := Status;
              2 : WeaponYakhont.LoadingMissile2 := Status;
              3 : WeaponYakhont.LoadingMissile3 := Status;
              4 : WeaponYakhont.LoadingMissile4 := Status;
            end;

//            if rzgrpYakhont.Opened = True and rzgrpYakhont.Visible = True then
//          begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_Mistral) and (WeaponID = C_DBID_MISTRAL)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_Mistral then
          begin
            WeaponMistral := TWeaponOn_Mistral(WeaponShip);

            case LauncherID of
              2 :
              begin
                case MissileID of
                   1 : WeaponMistral.portMissile1 := Status;
                   2 : WeaponMistral.portMissile2 := Status;
                end;
              end;
              1 :
              begin
                case MissileID of
                   1 : WeaponMistral.StarboardMissile1 := Status;
                   2 : WeaponMistral.StarboardMissile2 := Status;
                end;
              end;
            end;

//            if rzgrpMistral.Opened = True and rzgrpMistral.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_Strella) and (WeaponID = C_DBID_STRELA)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_Strella then
          begin
            WeaponStrela := TWeaponOn_Strella(WeaponShip);

            case LauncherID of
              1 :
              begin
                case MissileID of
                   1 : WeaponStrela.portMissile1 := Status;
                   2 : WeaponStrela.portMissile2 := Status;
                   3 : WeaponStrela.portMissile3 := Status;
                   4 : WeaponStrela.portMissile4 := Status;
                end;
              end;
              2 :
              begin
                case MissileID of
                   1 : WeaponStrela.StarboardMissile1 := Status;
                   2 : WeaponStrela.StarboardMissile2 := Status;
                   3 : WeaponStrela.StarboardMissile3 := Status;
                   4 : WeaponStrela.StarboardMissile4 := Status;
                end;
              end;
            end;

//            if rzgrpStrela.Opened = True and rzgrpStrela.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_Tetral) and (WeaponID = C_DBID_TETRAL)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_Tetral then
          begin
            WeaponTetral := TWeaponOn_Tetral(WeaponShip);

            case LauncherID of
              1 :
              begin
                case MissileID of
                   1 : WeaponTetral.FWDMissile1 := Status;
                   2 : WeaponTetral.FWDMissile2 := Status;
                   3 : WeaponTetral.FWDMissile3 := Status;
                   4 : WeaponTetral.FWDMissile4 := Status;
                end;
              end;
              2 :
              begin
                case MissileID of
                   1 : WeaponTetral.AFTMissile1 := Status;
                   2 : WeaponTetral.AFTMissile2 := Status;
                   3 : WeaponTetral.AFTMissile3 := Status;
                   4 : WeaponTetral.AFTMissile4 := Status;
                end;
              end;
            end;

//            if rzgrpTetral.Opened = True and rzgrpTetral.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_EXOCET40) and (WeaponID = C_DBID_EXOCET_MM40)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_EXOCET40 then
          begin
            WeaponExocet40 := TWeaponOn_EXOCET40(WeaponShip);

            case LauncherID of
              2 :
              begin
                case MissileID of
                   1 : WeaponExocet40.portMissile1 := Status;
                   2 : WeaponExocet40.portMissile2 := Status;
                end;
              end;
              1 :
              begin
                case MissileID of
                   1 : WeaponExocet40.StarboardMissile1 := Status;
                   2 : WeaponExocet40.StarboardMissile2 := Status;
                end;
              end;
            end;

//            if rzgrpExocetMM40.Opened = True and rzgrpExocetMM40.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end
        else if (WeaponShip is TWeaponOn_RBU) and (WeaponID = C_DBID_RBU6000)  then
        begin
          WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
          if WeaponShip is TWeaponOn_RBU then
          begin
            WeaponRBU := TWeaponOn_RBU(WeaponShip);

            case LauncherID of
              1 :
              begin
                case MissileID of
                   1  : WeaponRBU.Launcher1Missile1  := Status;
                   2  : WeaponRBU.Launcher1Missile2  := Status;
                   3  : WeaponRBU.Launcher1Missile3  := Status;
                   4  : WeaponRBU.Launcher1Missile4  := Status;
                   5  : WeaponRBU.Launcher1Missile5  := Status;
                   6  : WeaponRBU.Launcher1Missile6  := Status;
                   7  : WeaponRBU.Launcher1Missile7  := Status;
                   8  : WeaponRBU.Launcher1Missile8  := Status;
                   9  : WeaponRBU.Launcher1Missile9  := Status;
                   10 : WeaponRBU.Launcher1Missile10 := Status;
                   11 : WeaponRBU.Launcher1Missile11 := Status;
                   12 : WeaponRBU.Launcher1Missile12 := Status;
                end;
              end;
              2 :
              begin
                case MissileID of
                   1  : WeaponRBU.Launcher2Missile1  := Status;
                   2  : WeaponRBU.Launcher2Missile2  := Status;
                   3  : WeaponRBU.Launcher2Missile3  := Status;
                   4  : WeaponRBU.Launcher2Missile4  := Status;
                   5  : WeaponRBU.Launcher2Missile5  := Status;
                   6  : WeaponRBU.Launcher2Missile6  := Status;
                   7  : WeaponRBU.Launcher2Missile7  := Status;
                   8  : WeaponRBU.Launcher2Missile8  := Status;
                   9  : WeaponRBU.Launcher2Missile9  := Status;
                   10 : WeaponRBU.Launcher2Missile10 := Status;
                   11 : WeaponRBU.Launcher2Missile11 := Status;
                   12 : WeaponRBU.Launcher2Missile12 := Status;
                end;
              end;
            end;

//            if rzgrpRBU6000.Opened = True and rzgrpRBU6000.Visible = True then
//            begin
              frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);
//            end;
          end;

        end

      end;
    end;
  end;
end;

procedure TfWeaponStatus.SetWeaponGroupBar;
begin

    if not firstCekOpenGroupBar then
    begin
//      rzgrpStrela.Visible := True;
//      rzgrpTetral.Visible := True;
//      rzgrpTocos.Visible  := True;
//      rzgrpYakhont.Visible := True;
//      rzgrpCannon40.Visible := True;
//      rzgrpC802.Visible := True;
//      rzgrpWCC.Visible := True;
//      rzgrpAsroc.Visible := True;
//      rzgrpMistral.Visible := True;
//      rzgrpRBU6000.Visible := True;
//      rzgrpSPS115.Visible := True;
//      rzgrpMOCsigma.Visible := True;
//      rzgrpExocetMM40.Visible := True;
//      rzgrpCannon76.Visible := True;
//      rzgrpCannon57.Visible := True;

      rzgrpStrela.Opened := True;
      rzgrpTetral.Opened := True;
      rzgrpTocos.Opened  := True;
      rzgrpYakhont.Opened := True;
    //  rzgrpCannon40.Opened := True;
      rzgrpC802.Opened := True;
      rzgrpWCC.Opened := True;
      rzgrpAsroc.Opened := True;
      rzgrpMistral.Opened := True;
      rzgrpRBU6000.Opened := True;
      rzgrpSPS115.Opened := True;
      rzgrpMOCsigma.Opened := True;
      rzgrpExocetMM40.Opened := True;
      rzgrpCannon76.Opened := True;
      //rzgrpCannon57.Opened := True;
      firstCekOpenGroupBar := True;
    end;

    rzgrpStrela.Visible := False;
    rzgrpTetral.Visible := False;
    rzgrpTocos.Visible  := False;
    rzgrpYakhont.Visible := False;
    //rzgrpCannon40.Visible := False;
    rzgrpC802.Visible := False;
    rzgrpWCC.Visible := False;
    rzgrpAsroc.Visible := False;
    rzgrpMistral.Visible := False;
    rzgrpRBU6000.Visible := False;
    rzgrpSPS115.Visible := False;
    rzgrpMOCsigma.Visible := False;
    rzgrpExocetMM40.Visible := False;
    rzgrpCannon76.Visible := False;
    //rzgrpCannon57.Visible := False;

end;

procedure TfWeaponStatus.WeaponStatusOpen(Sender: TObject);
begin
end;

procedure TfWeaponStatus.LabelingAsrocMT(ShipID, WeaponID, LauncherID,
  MissileID: Byte; MissileType: TTypeMissileAsroc);
var
  i,j             : integer;
  shipInst        : TInsObject;
  WeaponShip      : TWeaponOnShip;
  WeaponAsroc     : TWeaponOn_ASROC;
begin
  for i := 0 to SimManager.MainObjList.ItemCount-1 do
  begin
    shipInst := TInsObject(SimManager.MainObjList.getObject(i));
    if shipInst.FDataBaseID = shipID then
    begin
      for j:=0 to shipInst.WeaponOnShip_List.Count -1 do
      begin
        WeaponShip := TWeaponOnShip(shipInst.WeaponOnShip_List.Items[j]);
        if (WeaponShip is TWeaponOn_ASROC) and (WeaponID = C_DBID_ASROC) then
        begin

            WeaponAsroc := TWeaponOn_ASROC(WeaponShip);
            case LauncherID of
              1 :
              begin
                case MissileID of
                   1 : WeaponAsroc.MissileType1 := MissileType;
                   2 : WeaponAsroc.MissileType2 := MissileType;
                end;
              end;

            end;
            frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.ShowWeaponPanel(WeaponShip.Weapon_Name);

        end

      end;

    end;

  end;
end;

procedure TfWeaponStatus.btn2Click(Sender: TObject);
var
   aRec : TRecEventLog;
begin
  aRec.consoleID := 1;
  aRec.eventID := 1;
  aRec.param1 := 20;
  aRec.param2 := 0;
  aRec.param3 := 0;
  aRec.ShipID := 1;

  SimManager.NetSendLogTest(aRec);
end;

procedure TfWeaponStatus.tmrLoadingTimer(Sender: TObject);
begin
  CountLoading := CountLoading + 1;

  //loading strella staboard
  if CountLoading = tmr_STRELLA_STABOARD + 1 then
  begin
    recSendStrella.mMissileID := 1;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 2 then
  begin
    recSendStrella.mMissileID := 2;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 3 then
  begin
    recSendStrella.mMissileID := 3;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 4 then
  begin
    recSendStrella.mMissileID := 4;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
    tmrLoading.Enabled := False;
  end

  //loading strella port
  else if CountLoading = tmr_STRELLA_PORT + 1 then
  begin
    recSendStrella.mMissileID := 1;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 7 then
  begin
    recSendStrella.mMissileID := 2;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 8 then
  begin
    recSendStrella.mMissileID := 3;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
  end
  else if CountLoading = 9 then
  begin
    recSendStrella.mMissileID := 4;
    SimManager.NetSendTo3D_OrderMissileStrella(recSendStrella);
    tmrLoading.Enabled := False;
  end

  //loading C802
  else if CountLoading = tmr_C802 + 1 then
  begin
    if C802StatusLoad_1 then
    begin
      recSendC802.mLauncherID    := 1;
      SimManager.NetSendTo3D_OrderMissile_C802(recSendC802);
    end;
  end
  else if CountLoading = tmr_C802 + 2 then
  begin
    if C802StatusLoad_2 then
    begin
      recSendC802.mLauncherID    := 2;
      SimManager.NetSendTo3D_OrderMissile_C802(recSendC802);
    end;
  end
  else if CountLoading = tmr_C802 + 3 then
  begin
    if C802StatusLoad_3 then
    begin
      recSendC802.mLauncherID    := 3;
      SimManager.NetSendTo3D_OrderMissile_C802(recSendC802);
    end;
  end
  else if CountLoading = tmr_C802 + 4 then
  begin
    if C802StatusLoad_4 then
    begin
      recSendC802.mLauncherID    := 4;
      SimManager.NetSendTo3D_OrderMissile_C802(recSendC802);
    end;
    tmrLoading.Enabled := False;
  end

  //loading TETRAL FWD
  else if CountLoading = tmr_TETRAL_FWD + 1 then
  begin
    recSendTetral.mMissileID  := 1;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_FWD + 2 then
  begin
    recSendTetral.mMissileID  := 2;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_FWD + 3 then
  begin
    recSendTetral.mMissileID  := 3;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_FWD + 4 then
  begin
    recSendTetral.mMissileID  := 4;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
    tmrLoading.Enabled := False;
  end

  //loading TETRAL AFT
  else if CountLoading = tmr_TETRAL_AFT + 1 then
  begin
    recSendTetral.mMissileID  := 1;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_AFT + 2 then
  begin
    recSendTetral.mMissileID  := 2;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_AFT + 3 then
  begin
    recSendTetral.mMissileID  := 3;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
  end
  else if CountLoading = tmr_TETRAL_AFT + 4 then
  begin
    recSendTetral.mMissileID  := 4;
    SimManager.NetSendTo3D_OrderMissileTetral(recSendTetral);
    tmrLoading.Enabled := False;
  end

  //Loading Yakhont
  else if CountLoading = tmr_YAKHONT + 1 then
  begin
    if RecSendYakhont.mMissile1 = 1 then
      SimManager.NetSendTo3D_OrderMissile_YAHKONT(RecSendYakhont);
  end
  else if CountLoading = tmr_YAKHONT + 2 then
  begin
    if RecSendYakhont.mMissile2 = 1 then
      SimManager.NetSendTo3D_OrderMissile_YAHKONT(RecSendYakhont);
  end
  else if CountLoading = tmr_YAKHONT + 3 then
  begin
    if RecSendYakhont.mMissile3 = 1 then
      SimManager.NetSendTo3D_OrderMissile_YAHKONT(RecSendYakhont);
  end
  else if CountLoading = tmr_YAKHONT + 4 then
  begin
    if RecSendYakhont.mMissile4 = 1 then
      SimManager.NetSendTo3D_OrderMissile_YAHKONT(RecSendYakhont);

      tmrLoading.Enabled := False;
  end

  //loading SPS
  else if CountLoading = tmr_SPS + 1 then
  begin
    if SPSStatusLoadStaboard then
    begin
      RecSendSPS.mLauncherID := 2;
      RecSendSPS.mMissileID := 1;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
  end
  else if CountLoading = tmr_SPS + 2 then
  begin
    if SPSStatusLoadport then
    begin
      RecSendSPS.mLauncherID := 1;
      RecSendSPS.mMissileID := 1;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
  end
  else if CountLoading = tmr_SPS + 3 then
  begin
    if SPSStatusLoadStaboard then
    begin
      RecSendSPS.mLauncherID := 2;
      RecSendSPS.mMissileID := 2;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
  end
  else if CountLoading = tmr_SPS + 4 then
  begin
    if SPSStatusLoadport then
    begin
      RecSendSPS.mLauncherID := 1;
      RecSendSPS.mMissileID := 2;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
  end
  else if CountLoading = tmr_SPS + 5 then
  begin
    if SPSStatusLoadStaboard then
    begin
      RecSendSPS.mLauncherID := 2;
      RecSendSPS.mMissileID := 3;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
  end
  else if CountLoading = tmr_SPS + 6 then   
  begin
    if SPSStatusLoadport then
    begin
      RecSendSPS.mLauncherID := 1;
      RecSendSPS.mMissileID := 3;
      SimManager.NetSendTo3D_OrderMissileTorpedo(RecSendSPS);
    end;
    tmrLoading.Enabled := False;
  end

end;

end.
