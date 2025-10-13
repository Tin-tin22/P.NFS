unit uSPS115;          // Last Update 03-11

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, ToolWin, ExtCtrls, TypInfo, VrControls,
  VrButtons, VrDesign, VrWheel, VrAngularMeter, VrRotarySwitch, jpeg,
  Unit_dataObject, Unit_FillValue, Unit_Interface, ButtonGroup, RzBmpBtn,
  RzButton,  VrSystem, ImgList, RzPanel, VrImageLed, RzRadChk, VrEdit,
  OverbyteIcsWndControl, OverbyteIcsWSocket, uTCPClient, Menus, uTCPDatatype,
  uDataModule, Grids, math,

  uBaseCoordSystem, AdvPicture;

type
  TStatusConsoleSPS = class
  private
    ROLL,
    SPS_115V,
    SPS_NDS,
    SPS_TIU_PORT,
    SPS_TIU_STARBOARD,
    SPS_TEMP_PORT,
    SPS_TEMP_STARBOARD,
    SPS_45_DEG_PORT,
    SPS_45_DEG_STARBOARD,
    SPS_GYRO_1,
    SPS_GYRO_2,
    SPS_GYRO_3,
    SPS_GYRO_4,
    SPS_GYRO_5,
    SPS_GYRO_6,
    SPS_BARREL_1,
    SPS_BARREL_2,
    SPS_BARREL_3,
    SPS_BARREL_4,
    SPS_BARREL_5,
    SPS_BARREL_6,
    SPS_SELFTEST : Integer;
  public
    function isReadyToFire(BarrelID : integer):Boolean;
    function isErrorInFire(BarrelID : integer):Boolean;

    constructor create;
    destructor destroy; override;
  published
  end;


  TFrm_Main = class(TForm)
    pnlBcGround: TPanel;
    imgBack: TImage;
    btn_H5: TVrBitmapButton;
    btn_H4: TVrBitmapButton;
    btn_H3: TVrBitmapButton;
    btn_H2: TVrBitmapButton;
    btn_H1: TVrBitmapButton;
    btn_H6: TVrBitmapButton;
    btn_Push4: TVrBitmapButton;
    btn_Push7: TVrBitmapButton;
    btn_PushPlusMin: TVrBitmapButton;
    btn_PushCLR: TVrBitmapButton;
    btn_PushLEFT: TVrBitmapButton;
    btn_Push1: TVrBitmapButton;
    btn_PushTAB: TVrBitmapButton;
    btn_Push5: TVrBitmapButton;
    btn_PushDOWN: TVrBitmapButton;
    btn_PushUP: TVrBitmapButton;
    btn_PushCHN: TVrBitmapButton;
    btn_Push0: TVrBitmapButton;
    btn_Push8: TVrBitmapButton;
    btn_Push2: TVrBitmapButton;
    btn_Push6: TVrBitmapButton;
    btn_PushRIGHT: TVrBitmapButton;
    btn_PushESC: TVrBitmapButton;
    btn_PushENT: TVrBitmapButton;
    btn_Pushtitik: TVrBitmapButton;
    btn_Push9: TVrBitmapButton;
    btn_Push3: TVrBitmapButton;
    btn_V12: TVrBitmapButton;
    btn_V16: TVrBitmapButton;
    btn_V15: TVrBitmapButton;
    btn_V14: TVrBitmapButton;
    btn_V13: TVrBitmapButton;
    btn_V11: TVrBitmapButton;
    btn_H7: TVrBitmapButton;
    btnPower: TRzBmpButton;
    tmrPower: TTimer;
    vrstrnglst1: TVrStringList;
    imgpower: TImage;
    imgStanby: TImage;
    tmrsTARTgYRO: TTimer;
    tmrIntervalGyro: TTimer;
    btn_Fire: TVrBitmapButton;
    btnKey: TRzBmpButton;
    rzpnlBlackScreen: TRzPanel;
    pnl_screen: TPanel;
    btn_RESET: TSpeedButton;
    pnl6: TPanel;
    lbl33: TLabel;
    pnl_linkStat: TPanel;
    pnl3: TPanel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    edt_Speed: TEdit;
    edt_Heading: TEdit;
    cbb_Source: TComboBox;
    pnl4: TPanel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    edt_Barrel: TEdit;
    edt_Gyro: TEdit;
    edt_Status: TEdit;
    edt_ITA: TEdit;
    cbb_Wtr: TComboBox;
    cbb_Prg: TComboBox;
    cbb_Cei: TComboBox;
    cbb_Dop: TComboBox;
    cbb_Acm: TComboBox;
    cbb_Isd: TComboBox;
    cbb_Flo: TComboBox;
    cbb_Ace: TComboBox;
    pnl_Isc: TPanel;
    edt_Isc: TEdit;
    pnl_Isr: TPanel;
    cbb_Isr: TComboBox;
    pnl5: TPanel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    cbb_MHP: TComboBox;
    edt_OptimCrs: TEdit;
    edt_TimeDrop: TEdit;
    mmo_displayMSG: TMemo;
    pnl7: TPanel;
    cbb_Mode: TComboBox;
    pnl8: TPanel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    pnlStbdTMP: TPanel;
    pnlStbd45: TPanel;
    pnlStbdTIU: TPanel;
    pnl9: TPanel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    pnlPortTIU: TPanel;
    pnlPort45: TPanel;
    pnlPortTMP: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    lbl_Torp_N: TLabel;
    pnl32: TPanel;
    pnl33: TPanel;
    edtRoll: TEdit;
    btn_V6: TButton;
    btn_V5: TButton;
    btn_V3: TButton;
    btn_V4: TButton;
    btn_V2: TButton;
    btn_V1: TButton;
    grp4: TGroupBox;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl4: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    pnl1: TPanel;
    edt_Rng1: TEdit;
    edt_Spd1: TEdit;
    edt_Crs1: TEdit;
    edt_Crs2: TEdit;
    edt_Spd2: TEdit;
    edt_Spd3: TEdit;
    edt_Crs3: TEdit;
    edt_Brg3: TEdit;
    edt_Brg2: TEdit;
    edt_Brg1: TEdit;
    edt_Rng2: TEdit;
    edt_Rng3: TEdit;
    edt_Tn3: TEdit;
    edt_Tn2: TEdit;
    edt_Tn1: TEdit;
    rzchckbx_Tgt1: TRzCheckBox;
    rzchckbx_Tgt3: TRzCheckBox;
    rzchckbx_Tgt2: TRzCheckBox;
    grp3: TGroupBox;
    btn_BARREL6: TSpeedButton;
    btn_BARREL2: TSpeedButton;
    btn_BARREL4: TSpeedButton;
    btn_BARREL5: TSpeedButton;
    btn_BARREL1: TSpeedButton;
    btn_BARREL3: TSpeedButton;
    pnl_Roll: TPanel;
    cbbBARREL1: TComboBox;
    cbbbARREL2: TComboBox;
    cbbBARREL6: TComboBox;
    cbbBARREL5: TComboBox;
    cbbBARREL4: TComboBox;
    cbbBARREL3: TComboBox;
    pm1: TPopupMenu;
    pmNetSetting: TMenuItem;
    Close1: TMenuItem;
    mniLogMemo1: TMenuItem;
    tmrFire: TTimer;
    tmrReadyToLaucnh: TTimer;
    tmrReadyFire: TTimer;
    tmrLoadProgram: TTimer;
    tmrConnectToBridge: TTimer;
    tmrLastPost: TTimer;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure cbb_WtrChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtRollChange(Sender: TObject);
    procedure edt_Tn1Enter(Sender: TObject);
    procedure btn_0Click(Sender: TObject);
    procedure btn_H1Click(Sender: TObject);
    procedure btn_H2Click(Sender: TObject);
    procedure btn_H3Click(Sender: TObject);
    procedure btn_H4Click(Sender: TObject);
    procedure btn_H5Click(Sender: TObject);
    procedure btn_H6Click(Sender: TObject);
    procedure btn_PushDOWNClick(Sender: TObject);
    procedure btnPowerClick(Sender: TObject);
    procedure tmrPowerTimer(Sender: TObject);
    procedure btn_H1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_H6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V13MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V14MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V15MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V16MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V16MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V15MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V14MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V13MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V12MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushPlusMinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushtitikMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushCLRMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushCHNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushENTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushTABMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushUPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushESCMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushLEFTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushDOWNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushRIGHTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_Push9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushPlusMinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushtitikMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushCLRMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushCHNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushENTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushTABMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushUPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushESCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushLEFTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushDOWNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_PushRIGHTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_V11Click(Sender: TObject);
    procedure btn_V12Click(Sender: TObject);
    procedure btn_V13Click(Sender: TObject);
    procedure btn_V14Click(Sender: TObject);
    procedure btn_V15Click(Sender: TObject);
    procedure btn_H7Click(Sender: TObject);
    procedure btn_PushENTClick(Sender: TObject);
    procedure btn_PushCHNClick(Sender: TObject);
    procedure btn_PushTABClick(Sender: TObject);
    procedure cbbBARREL6Change(Sender: TObject);
    procedure cbbBARREL6Click(Sender: TObject);
    procedure tmrsTARTgYROTimer(Sender: TObject);
    procedure tmrIntervalGyroTimer(Sender: TObject);
    procedure edt_Rng1Exit(Sender: TObject);
    procedure edt_Spd1Exit(Sender: TObject);
    procedure edt_Brg1Exit(Sender: TObject);
    procedure edt_Crs1Exit(Sender: TObject);
    procedure edt_Tn2Exit(Sender: TObject);
    procedure edt_Rng2Exit(Sender: TObject);
    procedure edt_Brg2Exit(Sender: TObject);
    procedure edt_Crs2Exit(Sender: TObject);
    procedure edt_Spd2Exit(Sender: TObject);
    procedure edt_Tn3Exit(Sender: TObject);
    procedure edt_Rng3Exit(Sender: TObject);
    procedure edt_Crs3Exit(Sender: TObject);
    procedure edt_Spd3Exit(Sender: TObject);
    procedure edt_IscExit(Sender: TObject);
    procedure cbb_WtrExit(Sender: TObject);
    procedure cbb_CeiExit(Sender: TObject);
    procedure cbb_PrgExit(Sender: TObject);
    procedure cbb_DopExit(Sender: TObject);
    procedure cbb_IsrExit(Sender: TObject);
    procedure cbb_AceExit(Sender: TObject);
    procedure cbb_FloExit(Sender: TObject);
    procedure cbb_IsdExit(Sender: TObject);
    procedure cbb_AcmExit(Sender: TObject);
    procedure edt_Tn1Exit(Sender: TObject);
    procedure cbb_SourceEnter(Sender: TObject);
    procedure edt_HeadingEnter(Sender: TObject);
    procedure btn_FireMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_FireMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_Brg3Exit(Sender: TObject);
    procedure edt_Rng1Change(Sender: TObject);
    procedure edt_Brg1Change(Sender: TObject);
    procedure edt_Crs1Change(Sender: TObject);
    procedure edt_Spd1Change(Sender: TObject);
    procedure edt_Spd2Change(Sender: TObject);
    procedure edt_Spd3Change(Sender: TObject);
    procedure edt_Crs2Change(Sender: TObject);
    procedure edt_Brg2Change(Sender: TObject);
    procedure edt_Rng2Change(Sender: TObject);
    procedure edt_Rng3Change(Sender: TObject);
    procedure edt_Brg3Change(Sender: TObject);
    procedure edt_Crs3Change(Sender: TObject);
    procedure edt_IscChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_PushPlusMinClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure pmNetSettingClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure rzchckbx_Tgt1Click(Sender: TObject);
    procedure mniLogMemo1Click(Sender: TObject);
    procedure tmrFireTimer(Sender: TObject);
    procedure btnKeyClick(Sender: TObject);
    procedure tmrReadyFireTimer(Sender: TObject);
    procedure btn_V16Click(Sender: TObject);
    procedure tmrLoadProgramTimer(Sender: TObject);
    procedure ImgBackgroundClick(Sender: TObject);
    procedure tmrConnectToBridgeTimer(Sender: TObject);
    procedure onTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);
    procedure tmrLastPostTimer(Sender: TObject);
    procedure TargetCheck;
    procedure TargetUnCheck;
    procedure TargetSetNul;
    procedure StopSelectingTarget;
  private
    { Private declarations }
    Mode            : TMode;

    //Firing Condition
    Fase            : Tphase;
    State           : Tstate;
    PowerState      : TPwr;
    
    iact, jact      : Integer;
    Fire            : TFire;
    ListTargetData  : array [1 .. 3] of TgtDataRec; // List target data

    BootTime,
    StartUpGyro,
    IntervalGyro    : Integer;
    TorpData        : TTorpData;
    ListTragetData  : array [1..3] of TgtDataRec;
    Shipdata        : Tshipdata;

    TimeFirePush    : integer;
    TimeLoadProg    : Integer;
    isLoadProgram   : Boolean;

    // var parameter
    CounterBlinkFire : Integer;
    CounterReadyToFire : integer;

    //MagicKeyNumber
    KeyNumber : array[0..2] of Integer;
    idKeyNumber : Integer;

    //Variabel Added By Nando
    FisErrorState   : Boolean;
    FStatusConsole  : TStatusConsoleSPS;

    procedure defaultValue(Tp: TTpoType; wt: string);
    procedure TEdit_GetIn;
    procedure TBtn_GetIn;
    procedure BtnCbbBarrel_GetIn;
    procedure SetImgButton(st: TPwr);
    procedure ChnImgButton(stPwr: TPwr; btn: TVrBitmapButton; img: string);
    procedure DefaultTorpData(Tpo: TTpoType);
    procedure SetClrEdtTrp;
    procedure FindTarget;
    procedure SelectTarget(st: boolean);
    procedure OnESC(TagControl: Integer);
    procedure WtrChnValue(wtr: string);
    procedure OnChangeState(Sender: TObject; OldState,NewState: TSocketState);
    procedure EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
    procedure SetPort(apRec: PAnsiChar; aSize: integer);
    procedure SetStbd(apRec: PAnsiChar; aSize: integer);
    procedure onRecDataAvailable(apRec: PAnsiChar; aSize: integer);

    procedure OnReceiveStatusConsole(apRec: PAnsiChar; aSize: integer);
    procedure OnReceiveTorpedoStatus(apRec: PAnsiChar; aSize: integer);

    procedure SetEditTextInTargetSelected(edt : TEdit; id : integer);

    //Sockect Added by Nando
    procedure SendFireToController;
    procedure PrepareToLaunchTorpedo;
    procedure SetRecTorpedoDefaultEnv;
    procedure FireTorpedo;
    function CheckBarrelSelected: Integer;
    procedure SetAfterFire;

    procedure GetBarrelStatusByID(aBarrelID : integer);
    procedure GetGyroStatusByID(aGyroID : integer);
    function GetStatusConsoleByParam(aId, aParam : integer): string;
    function GetTIULink : Boolean;

    procedure CalcHitPoint(aRec : TRecData3DPosition);

    procedure AddToLog(const LogMemo : TStringList;  str: string);

    procedure SetDefaultEnvironment;

    procedure CheckTargetEnggaged;

    procedure CalchPHPOnStandAlone(ShipHeading, ShipSpeed : double);
    function ChangeStringValue(str : string):string;

  public
    { Public declarations }
    LastPosition : TRecData3DPosition;

    OffX_Map, OffY_Map : Double;
    StandAloneMode : Boolean;
    TpoType1         : TTpoType;
    ListBtn,
    ListBtnBarrel,
    ListCbbBarrel   : TList;
    Barrel          : TBarrel;
    TheClient       : TTCPClient;
    data_path       : string;

    pCurrentScenID  : integer;
    pServer_Ip,
    pServer_Port,               //TriD_IP, TriD_Port,
    pDBServer,
    pDBProto,
    pDBName,
    pDBUser,
    pDBPass,
    pShipName,
    pClassName      : string;
    pShipID,
    pClassID        : Integer;

    //added by nando
    property IsErrorState : Boolean read FisErrorState write FisErrorState;
  end;

var
  Frm_Main: TFrm_Main;
  RecSendTorpedo : TRecDataTorperdo;

implementation


uses uBridgeSet, ufrmNetSetting, uDataTypes, uLogMemo;
{$R *.dfm}

procedure TFrm_Main.btn_V11Click(Sender: TObject);
var
  i: Integer;
begin
  if not btnPower.Down then Exit;

  if btn_V1.Caption = 'MODE' then
  begin
    cbb_Mode.SetFocus;
    if i mod 2 = 1 then
    begin
      pnl_Isc.Color := clYellow;
      pnl_Isr.Color := clYellow;
    end
    else
    begin
      pnl_Isc.Color := clRed;
      pnl_Isr.Color := clRed;
    end;
  end;

  if btn_V1.Caption = 'EXIT' then
  begin
    Fase:= fDefault;
    State.SetState(Fase);
  end;
end;

procedure TFrm_Main.btn_V11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V11, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V11, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.btn_V12Click(Sender: TObject);
begin
  if not btnPower.Down then Exit;

  if btn_V2.Caption = 'BITE' then
  begin
    Fase  := fBite;
    State.SetState(Fase);
  end;

  if btn_V2.Caption = 'SELECT TGT' then
  begin
    if Fase = fGyroStarted then
    begin
      frmLogMemo.mmoSetting.Lines.Add('Stop Gyro First');
    end
    else
    begin
      if CheckBarrelSelected = 0 then
      begin
        frmLogMemo.mmoSetting.Lines.Add('Barrel Has Not Been Selected');
      end
      else
      begin
        rzchckbx_Tgt1.SetFocus;
      end;
    end;

    //CheckTargetEnggaged;
  end;
end;

procedure TFrm_Main.btn_V12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V12, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V12MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V12, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.btn_V13Click(Sender: TObject);
begin
  if not btnPower.Down then Exit;

  if btn_V3.Caption = 'TORP TYPE' then
  begin
    if btn_BARREL6.Down then
      cbbBARREL6.SetFocus
    else if btn_BARREL5.Down then
      cbbBARREL5.SetFocus
    else if btn_BARREL4.Down then
      cbbBARREL4.SetFocus
    else if btn_BARREL3.Down then
      cbbBARREL3.SetFocus
    else if btn_BARREL2.Down then
      cbbbARREL2.SetFocus
    else if btn_BARREL1.Down then
      cbbBARREL1.SetFocus;
  end;
end;

procedure TFrm_Main.btn_V13MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V13, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V13MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V13, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.btn_V14Click(Sender: TObject);
var
  s : string;
begin
  if not btnPower.Down then Exit;

  if (lbl_Torp_N.Caption = 'n') then begin
    frmLogMemo.mmoSetting.Lines.Add('There is no Barrel Selected, choose at least one Barrel!');
    Exit;
  end;

  if btn_V4.Caption = 'START GYRO' then
  begin
    if tmrIntervalGyro.Enabled then begin
       frmLogMemo.mmoSetting.Lines.Add('Please Wait For Stop Gyro');
       Exit;
    end;

    if (edt_Barrel.Text = 'NOT READY') or
       (edt_Barrel.Text = 'ERROR') then
    begin
      Fase := fDefault;
      State.SetState(Fase);
      edt_Gyro.Text   := 'OFF';
      tmrsTARTgYRO.Enabled := False;
    end
    else
    begin
      Fase := fGyroStarted;
      State.SetState(Fase);
      edt_Gyro.Text := 'START UP';
      tmrsTARTgYRO.Enabled := True;
    end;
  end
  else if btn_V4.Caption = 'STOP GYRO' then
  begin
    tmrsTARTgYRO.Enabled := false;

    Fase := fDefault;
    State.SetState(Fase);
    edt_Gyro.Text   := 'OFF';
    edt_Status.Text := 'DESELECTED';

    tmrIntervalGyro.Enabled := True;            // jeda
    rzchckbx_Tgt2.Checked   := False;           // Disengaging Target
    rzchckbx_Tgt1.Checked   := False;
    rzchckbx_Tgt3.Checked   := False;

    TargetUnCheck;

    tmrLoadProgram.Enabled := False;
    s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
    imgStanby.Picture.LoadFromFile(s);
    edt_ITA.Text  := '0';
  end;
end;

procedure TFrm_Main.btn_V14MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V14, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V14MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V14, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.btn_V15Click(Sender: TObject);
var
  s : string;
  Ita, Isc : Double;
begin
  if not btnPower.Down then Exit;

  if btn_V5.Caption = 'SELECT n' then
  begin
    if (ErrorSlctbarrel.code > 0) and (ErrorSlctbarrel.code < 9) then begin
      frmLogMemo.mmoSetting.Lines.Add('(' + lbl_Torp_N.Caption +' - ' + IntToStr(ErrorTpoGyro.code) + ')');
      frmLogMemo.mmoSetting.Lines.Add('(' + lbl_Torp_N.Caption +' - ' + IntToStr(ErrorSlctbarrel.code) + ')');
      Exit;
    end;

    if (edt_Barrel.Text = 'READY') and (edt_Gyro.Text = 'STEADY') then
    begin
      edt_Status.Text := 'SELECTED';
      Barrel.BrlNum   := StrToInt(lbl_Torp_N.Caption);  // Nomor Barrel
      Barrel.Tpo      := TorpData;                      // ENTER TORP IN BARREL
      Fire.Barrel     := Barrel;

      Fase            := fBarrelSelected;
      State.SetState(Fase);

      if TryStrToFloat(edt_Isc.Text, Isc) then
      begin
        Isc := ValidateDegree(Isc);
        Ita := Isc - 45;
        edt_ITA.Text := FloatToStr(Ita);
      end;

    end
    else
    begin
      frmLogMemo.mmoSetting.Lines.Add('BARREL or GYRO is not Ready!');
    end;
  end
  else if btn_V5.Caption = 'DESELECT n' then
  begin
      Fase := fBarrelDeselected;
      State.SetState(Fase);
      edt_Status.Text := 'DESELECTED';

      tmrLoadProgram.Enabled := False;
      s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
      imgStanby.Picture.LoadFromFile(s);
      edt_ITA.Text  := '0';
  end;
end;

procedure TFrm_Main.btn_V15MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V15, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V15MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V15, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.btn_V16Click(Sender: TObject);
begin
  if not btnPower.Down then Exit;

  if ((edt_Barrel.Text = 'READY') and (edt_Gyro.Text = 'STEADY')
    and (edt_Status.Text = 'SELECTED')) then
  begin
    isLoadProgram := False;
    tmrLoadProgram.Enabled := True;
    PrepareToLaunchTorpedo;
  end;
end;

procedure TFrm_Main.btn_V16MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V16, vrstrnglst1.Strings[47]);
end;

procedure TFrm_Main.btn_V16MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_V16, vrstrnglst1.Strings[24]);
end;

procedure TFrm_Main.CalcHitPoint(aRec : TRecData3DPosition);
var
  aTn, aRange, aBearing, aCourse, aSpeed : double;

  isCheck, isError : Boolean;
  aRangeMHP : Double;

  hRange , hBearing, hTime, hSpeed : Double;
  Mx, My : Double;

  PHPPoint : t2DPoint;
  ELPPoint : t2DPoint;
  TargetPoint : t2DPoint;

  ELPBearing : Double;

  OptimeCourse : Double;
  RangeToDrop, TimeDrop     : Double;

  Speed : Double;
begin
  isCheck := False;
  isError := False;

  if pShipID <> aRec.ShipID  then exit;

  if rzchckbx_Tgt1.Checked then
  begin
    isCheck := True;

    aTn       := StrToFloat(edt_Tn1.Text);
    aRange    := StrToFloat(edt_Rng1.Text);
    aBearing  := StrToFloat(edt_Brg1.Text);
    aCourse   := StrToFloat(edt_Crs1.Text);
    aSpeed    := StrToFloat(edt_Spd1.Text);
  end
  else
  if rzchckbx_Tgt2.Checked then
  begin
    isCheck := True;

    aTn       := StrToFloat(edt_Tn2.Text);
    aRange    := StrToFloat(edt_Rng2.Text);
    aBearing  := StrToFloat(edt_Brg2.Text);
    aCourse   := StrToFloat(edt_Crs2.Text);
    aSpeed    := StrToFloat(edt_Spd2.Text);
  end
  else
  if rzchckbx_Tgt3.Checked then
  begin
    isCheck := True;

    aTn       := StrToFloat(edt_Tn3.Text);
    aRange    := StrToFloat(edt_Rng3.Text);
    aBearing  := StrToFloat(edt_Brg3.Text);
    aCourse   := StrToFloat(edt_Crs3.Text);
    aSpeed    := StrToFloat(edt_Spd3.Text);
  end;

  if aRange = 0 then isError := True;
  if aTn = 0 then isError := True;

  aRange := aRange * C_Meter_To_NauticalMile;

  if isCheck and not isError then
  begin
    case cbb_MHP.ItemIndex of
      0 : aRangeMHP := 4.84;
      1 : aRangeMHP := 3.26;
      2 : aRangeMHP := 1.63;
    end;

    aRec.X := aRec.X + OffX_Map;
    aRec.Y := aRec.Y + OffY_Map;

    CalcHitPredition(aRange, aBearing, aSpeed, aCourse, 30, hRange , hBearing, hTime, hSpeed);

    RangeBearingToCoord(hRange,hBearing,mx,my);

    PHPPoint.X := aRec.X + Mx;
    PHPPoint.Y := aRec.Y + My;

    ELPBearing := CalcBearing(PHPPoint.X, PHPPoint.Y , aRec.X, aRec.Y);

    RangeBearingToCoord(aRangeMHP, ELPBearing, mx, my);
    ELPPoint.X := PHPPoint.X + Mx;
    ELPPoint.Y := PHPPoint.Y + My;

    OptimeCourse := CalcBearing(aRec.X, aRec.Y, ELPPoint.X, ELPPoint.Y);
    RangeToDrop  := CalcRange(aRec.X, aRec.Y, ELPPoint.X, ELPPoint.Y);

    edt_OptimCrs.Text := FormatFloat('0.00',OptimeCourse);

    RangeBearingToCoord(aRange, aBearing, Mx, My);
    TargetPoint.X := aRec.X + Mx;
    TargetPoint.Y := aRec.Y + My;

    if CalcRange(aRec.X,aRec.Y, TargetPoint.X ,TargetPoint.Y ) < aRangeMHP then
    begin
      edt_TimeDrop.Text := '0';
      edt_OptimCrs.Text := FormatFloat('0.00',aBearing);
    end
    else
    begin
      if (cbb_Source.ItemIndex = 0) and (pnl_linkStat.Caption = 'OP') then
      begin
        if aRec.speed > 1 then
        begin
          TimeDrop          := (RangeToDrop/arec.speed)*3600;
          edt_TimeDrop.Text := FormatFloat('0.00',TimeDrop);
        end
        else
        begin
          edt_TimeDrop.Text := '999999';
        end;
      end
      else
      begin
        if TryStrToFloat(edt_Speed.Text, Speed) then
        begin
          if Speed > 1 then
          begin
            TimeDrop          := (RangeToDrop/Speed)*3600;
            edt_TimeDrop.Text := FormatFloat('0.00',TimeDrop);
          end
          else
          begin
            edt_TimeDrop.Text := '999999';
          end;
        end;
      end;
    end;
  end
  else
  begin
    edt_OptimCrs.Text := '0';
    edt_TimeDrop.Text := '0';
  end;
end;

procedure TFrm_Main.CalchPHPOnStandAlone(ShipHeading, ShipSpeed: double);
Var
  rec : TRecData3DPosition;
begin
  rec.ShipID  := 0;
  rec.X       := 0;
  rec.Y       := 0;
  rec.Z       := 0;
  rec.Heading := ShipHeading;
  rec.Speed   := ShipSpeed;

  CalcHitPoint(rec);
end;

procedure TFrm_Main.btnPowerClick(Sender: TObject);
var
  s: string;
begin
  if btnPower.Down then
  Begin
    tmrPower.Enabled := True;
    s := data_path + '.\Images\SPS115\lampu indikator on.bmp';
  End
  else
  begin
    PowerState := stOFF;
    SetImgButton(PowerState);
    BootTime   := 0;
    tmrPower.Enabled := False;
    s := data_path + '.\images\SPS115\lampu indikator off.bmp';

    SetDefaultEnvironment;
  end;
  imgpower.Picture.LoadFromFile(s);
end;

procedure TFrm_Main.onTCPChangeState(Sender: TObject; OldState, NewState: TSocketState);
begin
  if (OldState = wsConnected) and (NewState = wsClosed) then
  begin
   tmrConnectToBridge.Enabled := True;
  end;
end;

//added by arin
procedure TFrm_Main.tmrConnectToBridgeTimer(Sender: TObject);
var
  recSend : TRecData2DOrder;
  cb : TComboBox;
  I : Integer;
begin
  tmrConnectToBridge.Enabled := False;

  //connect to bridge
  if TheClient.State <> wsConnected then
  begin
    TheClient.Connect(pServer_Ip,pServer_Port);
    tmrConnectToBridge.Enabled := True;
  end
  else
  begin
    tmrConnectToBridge.Enabled := False;

    if TheClient.State = wsConnected then
    begin
      //req sync packet after connect
      recSend.orderID   := _CM_REQ_SYNCPACKET;
      recSend.numValue  := 0;
      recSend.strValue  := '';
      recSend.strValue2 := '';
      recSend.strValue3 := '';
      recSend.ipConsole := '';
      TheClient.sendDataEx(REC_2D_ORDER, @recSend);
    end;

    for I := 0 to 5 do
    begin
      cb := ListCbbBarrel[I];
        if cb.ItemIndex >=2 then
        begin
          cb.Color := RGB(242, 119, 151);
        end
        else
        cb.Color := clAqua;
    end;
  end;

end;

procedure TFrm_Main.tmrFireTimer(Sender: TObject);
var
  IdBlink : Integer;
begin
  CounterBlinkFire := CounterBlinkFire + tmrFire.Interval;

  IdBlink := (round((CounterBlinkFire/1000)) mod 2);

  case IdBlink of
    0 : ChnImgButton(PowerState, btn_Fire, vrstrnglst1.Strings[70]);
    1 : ChnImgButton(PowerState, btn_Fire, vrstrnglst1.Strings[71]);
  end;
end;

procedure TFrm_Main.tmrIntervalGyroTimer(Sender: TObject);
begin
  inc(IntervalGyro);
  if (IntervalGyro >= 3) then
  begin
    tmrIntervalGyro.Enabled := False;
    IntervalGyro            := 0;
  end;
end;

procedure TFrm_Main.tmrLastPostTimer(Sender: TObject);
begin
  //tmrLastPost.Enabled := False;
end;

procedure TFrm_Main.tmrLoadProgramTimer(Sender: TObject);
var
  IdBlink : Integer;
  s : string;
begin
  TimeLoadProg := TimeLoadProg + 1;

  IdBlink := TimeLoadProg mod 2;

  case IdBlink of
    0 : begin
          s := data_path + '.\Images\SPS115\lampu indikator on.bmp';
          imgStanby.Picture.LoadFromFile(s);
        end;
    1 : begin
          s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
          imgStanby.Picture.LoadFromFile(s);
        end;
  end;

  if TimeLoadProg > 10 then
  begin
    tmrLoadProgram.Enabled := False;
    TimeLoadProg := 0;

    s := data_path + '.\Images\SPS115\lampu indikator on.bmp';
    imgStanby.Picture.LoadFromFile(s);
    isLoadProgram := True;
  end;
end;

procedure TFrm_Main.tmrPowerTimer(Sender: TObject);
begin
  inc(BootTime);
  if (BootTime >= 3) then
  begin
    PowerState := stON;
    SetImgButton(PowerState);
    tmrPower.Enabled := False;
  end;
end;

procedure TFrm_Main.tmrReadyFireTimer(Sender: TObject);
begin
  TimeFirePush := TimeFirePush + 1;

  frmLogMemo.mmoSetting.Lines.Add('Count Timer ' + IntToStr(TimeFirePush));

  if TimeFirePush > 7 then
  begin
    tmrReadyFire.Enabled := False;
    TimeFirePush := 0;

    FireTorpedo;
    frmLogMemo.mmoSetting.Lines.Add('Prepare Torpedo Launch');
  end;
end;

procedure TFrm_Main.tmrsTARTgYROTimer(Sender: TObject);
begin

  inc(StartUpGyro);
  if (StartUpGyro >= 3) then
  begin
    if ErrorTpoGyro.code <> 0 then begin
       frmLogMemo.mmoSetting.Lines.Add('(' + lbl_Torp_N.Caption +' - ' +
       IntToStr(ErrorTpoGyro.code) + ')');
    end
    else begin
       edt_Gyro.Text  := 'STEADY';

       if GetTIULink then
       begin
         if btn_BARREL1.Down then
            GetGyroStatusByID(1)
         else
         if btn_BARREL2.Down then
            GetGyroStatusByID(2)
         else
         if btn_BARREL3.Down then
            GetGyroStatusByID(3)
         else
         if btn_BARREL4.Down then
            GetGyroStatusByID(4)
         else
         if btn_BARREL5.Down then
            GetGyroStatusByID(5)
         else
         if btn_BARREL6.Down then
            GetGyroStatusByID(6);
       end
       else
       begin
         edt_Gyro.Text := 'No Link With TIU';
       end;
    end;

    StartUpGyro   := 0;
    tmrsTARTgYRO.Enabled := False;
  end;

end;

procedure TFrm_Main.OnChangeState(Sender: TObject; OldState,
  NewState: TSocketState);
begin

end;

procedure TFrm_Main.btn_0Click(Sender: TObject);
begin
  if idKeyNumber < 3 then
  begin
    case TComponent(sender).Tag of
      96 .. 105 :
      begin
        KeyNumber[idKeyNumber] := StrToInt(TVrBitmapButton(sender).Hint);
        idKeyNumber := idKeyNumber + 1;
      end;
    end;
  end;

  if not btnPower.Down then Exit;

  case (Sender as Tcomponent).Tag of
    46:
    begin
      if (ActiveControl is TEdit) then
      begin
        (ActiveControl as TEdit).Text :=
        (ActiveControl as TEdit).Text + Char((Sender as Tcomponent).Tag);
        keybd_event(VK_END , 0, 0, 0);
      end;

      if (ActiveControl is TRzCheckBox) and (Mode = mdNormal) then
        if (pnl_linkStat.Caption = 'INOP') or
           (pnlPortTIU.Caption   = 'INOP') or
           (pnlPort45.Caption    = 'NO')   or
           (pnlPortTMP.Caption   = 'OVR')  or
           (pnlStbdTIU.Caption   = 'INOP') or
           (pnlStbd45.Caption    = 'NO')   or
           (pnlStbdTMP.Caption   = 'OVR')  then
        begin
          StopSelectingTarget;
        end
        else
          FindTarget;
    end;

    96 .. 105:
    if (ActiveControl is TEdit) then begin
      if ((Sender as Tcomponent).Tag >=1) and ((Sender as Tcomponent).Tag <=6)then
        Exit
      else begin
        keybd_event((Sender as Tcomponent).Tag , 0, 0, 0);
        keybd_event(VK_END , 0, 0, 0);
      end;
    end;

    106:
    begin
      if (ActiveControl is TEdit) then begin
        (ActiveControl as TEdit).Text :=
        copy((ActiveControl as TEdit).Text, 1, length
        ((ActiveControl as TEdit).Text) - 1);
        keybd_event(VK_END,0,0,0);
      end;

      if (ActiveControl is TRzCheckBox) then
      begin
        SelectTarget(False);
        TargetUnCheck;
      end;
    end;

    107:
      OnESC(ActiveControl.Tag);
  end;
end;

procedure TFrm_Main.GetBarrelStatusByID(aBarrelID: integer);
var
  Barrel1,
  Barrel2,
  Barrel3,
  Barrel4,
  Barrel5,
  Barrel6 : Integer;
begin
  Barrel1 := FStatusConsole.SPS_BARREL_1;
  Barrel2 := FStatusConsole.SPS_BARREL_2;
  Barrel3 := FStatusConsole.SPS_BARREL_3;
  Barrel4 := FStatusConsole.SPS_BARREL_4;
  Barrel5 := FStatusConsole.SPS_BARREL_5;
  Barrel6 := FStatusConsole.SPS_BARREL_6;

  case aBarrelID of
    0 : begin
          edt_Barrel.Text := 'NOT READY';
        end;
    1 : begin
          if (Barrel1 = 1) or (Barrel1 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel1 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_1,FStatusConsole.SPS_BARREL_1));
          end;
        end;
    2 : begin
          if (Barrel2 = 1) or (Barrel2 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel2 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_2,FStatusConsole.SPS_BARREL_2));
          end;
        end;
    3 : begin
          if (Barrel3 = 1) or (Barrel3 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel3 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_3,FStatusConsole.SPS_BARREL_3));
          end;
        end;
    4 : begin
          if (Barrel4 = 1) or (Barrel4 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel4 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_4,FStatusConsole.SPS_BARREL_4));
          end;
        end;
    5 : begin
          if (Barrel5 = 1) or (Barrel5 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel5 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_5,FStatusConsole.SPS_BARREL_5));
          end;
        end;
    6 : begin
          if (Barrel6 = 1) or (Barrel6 = 7) then
          begin
            edt_Barrel.Text := 'READY';
          end
          else
          if Barrel6 = 8 then
          begin
            edt_Barrel.Text := 'NOT READY';
          end
          else
          begin
            edt_Barrel.Text := 'ERROR';
            mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_BARREL_6,FStatusConsole.SPS_BARREL_6));
          end;
        end;
  end;
end;

procedure TFrm_Main.GetGyroStatusByID(aGyroID: integer);
var
  Gyro1,
  Gyro2,
  Gyro3,
  Gyro4,
  Gyro5,
  Gyro6 : Integer;
begin
    Gyro1 := FStatusConsole.SPS_GYRO_1;
    Gyro2 := FStatusConsole.SPS_GYRO_2;
    Gyro3 := FStatusConsole.SPS_GYRO_3;
    Gyro4 := FStatusConsole.SPS_GYRO_4;
    Gyro5 := FStatusConsole.SPS_GYRO_5;
    Gyro6 := FStatusConsole.SPS_GYRO_6;

    case aGyroID of
      1 : begin
            if Gyro1 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro1 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_1, FStatusConsole.SPS_GYRO_1));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_1, FStatusConsole.SPS_GYRO_1));
            end;
          end;
      2 : begin
            if Gyro2 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro2 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_2, FStatusConsole.SPS_GYRO_2));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_2, FStatusConsole.SPS_GYRO_2));
            end;
          end;
      3 : begin
            if Gyro3 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro3 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_3, FStatusConsole.SPS_GYRO_3));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_3, FStatusConsole.SPS_GYRO_3));
            end;
          end;
      4 : begin
            if Gyro4 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro4 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_4, FStatusConsole.SPS_GYRO_4));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_4, FStatusConsole.SPS_GYRO_4));
            end;
          end;
      5 : begin
            if Gyro5 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro5 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_5, FStatusConsole.SPS_GYRO_5));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_5, FStatusConsole.SPS_GYRO_5));
            end;
          end;
      6 : begin
            if Gyro6 = 1 then
              edt_Gyro.Text := 'STEADY'
            else
            if Gyro6 = 4 then
            begin
              edt_Gyro.Text := 'START UP';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_6, FStatusConsole.SPS_GYRO_6));
            end
            else
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(__STAT_SPS_GYRO_6, FStatusConsole.SPS_GYRO_6));
            end;
          end;
    end;
end;

procedure TFrm_Main.btnKeyClick(Sender: TObject);
begin
  CounterBlinkFire := 0;
  
  if btnKey.Down then
  begin
    tmrFire.Enabled := True;
  end
  else
  begin
    tmrFire.Enabled := False;
    ChnImgButton(PowerState, btn_Fire, vrstrnglst1.Strings[70]);
  end;
end;

procedure TFrm_Main.SetAfterFire;
var
  s  : string;
  I  : Integer;
  bt : TSpeedButton;
  Cb : TComboBox;
  edt: TEdit;
begin

  if ErrorSlctbarrel.code = 9 then begin
    frmLogMemo.mmoSetting.Lines.Add('(' + lbl_Torp_N.Caption +' - ' + IntToStr(ErrorTpoGyro.code) + ')');
    Cb := ListCbbBarrel[StrToInt(lbl_Torp_N.Caption)];
    Cb.ItemIndex:=3;
    SetClrEdtTrp;
    Exit;
  end;

  // Fire succses
  // set parameter
  Fire.Ship:=Shipdata;

  s:= GetEnumName(TypeInfo(TTpoType),integer(Fire.Barrel.Tpo.Torp)) ;
  frmLogMemo.mmoSetting.Lines.Add('');
  frmLogMemo.mmoSetting.Lines.Add('BARREL :');
  frmLogMemo.mmoSetting.Lines.Add('No        : ' + IntToStr(Fire.Barrel.BrlNum));
  frmLogMemo.mmoSetting.Lines.Add('Torp Type : ' + s);
  frmLogMemo.mmoSetting.Lines.Add('Torp Wtr  : ' + Fire.Barrel.Tpo.Wtr);
  frmLogMemo.mmoSetting.Lines.Add('Torp Prg  : ' + Fire.Barrel.Tpo.Prg);
  frmLogMemo.mmoSetting.Lines.Add('Torp Dop  : ' + Fire.Barrel.Tpo.Dop);
  frmLogMemo.mmoSetting.Lines.Add('Torp Acm  : ' + Fire.Barrel.Tpo.Acm);
  frmLogMemo.mmoSetting.Lines.Add('Torp Isc  : ' + IntToStr(Fire.Barrel.Tpo.Isc));
  frmLogMemo.mmoSetting.Lines.Add('Torp Isr  : ' + IntToStr(Fire.Barrel.Tpo.Isr));
  frmLogMemo.mmoSetting.Lines.Add('Torp Ace  : ' + IntToStr(Fire.Barrel.Tpo.Ace));
  frmLogMemo.mmoSetting.Lines.Add('Torp Cei  : ' + IntToStr(Fire.Barrel.Tpo.Cei));
  frmLogMemo.mmoSetting.Lines.Add('Torp Flo  : ' + IntToStr(Fire.Barrel.Tpo.Flo));
  frmLogMemo.mmoSetting.Lines.Add('Torp Isd  : ' + IntToStr(Fire.Barrel.Tpo.Isd));

  frmLogMemo.mmoSetting.Lines.Add('Target  :');
  frmLogMemo.mmoSetting.Lines.Add('No      : ' + FloatToStr(Fire.Target.Tn));
  frmLogMemo.mmoSetting.Lines.Add('Range   : ' + FloatToStr(Fire.Target.Rng));
  frmLogMemo.mmoSetting.Lines.Add('Bearing : ' + FloatToStr(Fire.Target.Brg));
  frmLogMemo.mmoSetting.Lines.Add('Course  : ' + FloatToStr(Fire.Target.Crs));
  frmLogMemo.mmoSetting.Lines.Add('Speed : ' + FloatToStr(Fire.Target.Spd));

  for I := 0 to 5 do
  begin
    cb :=ListCbbBarrel[I];
    bt := ListbtnBarrel[I];
    if bt.down then
    begin
      Cb.ItemIndex:=3;            // Set Value Cbb (Fired)
    end;
  end;

  SetClrEdtTrp;                   // Set color Cbb BARREL
  
  Fase := fBeforeSelection;
  State.SetState(Fase);
  edt_Barrel.Text := 'NOT READY';

  Fase := fGyroOff;
  State.SetState(Fase);
  edt_Gyro.Text := 'OFF';

  Fase := fBarrelDeselected;
  State.SetState(Fase);
  edt_Status.Text := 'DESELECTED';

  if rzchckbx_Tgt2.Checked then
  begin
    for I := 1 to 5 do
    begin
       edt:= (EdtTgtData[2,I] as TEdit);
       edt.Text:='0';
    end;

    rzchckbx_Tgt2.Checked := False;
  end;

  if rzchckbx_Tgt1.Checked then
  begin
    for I := 1 to 5 do
    begin
       edt:= (EdtTgtData[1,I] as TEdit);
       edt.Text:='0';
    end;

    rzchckbx_Tgt1.Checked := False;
  end;

  if rzchckbx_Tgt3.Checked then
  begin
     for I := 1 to 5 do
     begin
        edt:= (EdtTgtData[3,I] as TEdit);
        edt.Text:='0';
     end;

     rzchckbx_Tgt3.Checked := False;
  end;

  // Disengaging Target
  Fase := fDefault;
  State.SetState(Fase);

  s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
  imgStanby.Picture.LoadFromFile(s);
  isLoadProgram := False;

  Set_TgtSelected(edt_Tn1, edt_Rng1, edt_Brg1, edt_Crs1, edt_Spd1, false);
  Set_TgtSelected(edt_Tn2, edt_Rng2, edt_Brg2, edt_Crs2, edt_Spd2, false);
  Set_TgtSelected(edt_Tn3, edt_Rng3, edt_Brg3, edt_Crs3, edt_Spd3, false);

  TargetSetNul;
end;

procedure TFrm_Main.SetClrEdtTrp;
var
  bt     : TSpeedButton;
  cb     : TComboBox;
  fn     : Boolean;
  I,no   : Integer;

begin
  fn:= False;
  for I := 0 to 5 do begin
    bt:= ListBtnbarrel[I];
    cb:= ListCbbBarrel[I];
      if bt.Down then begin
          if cb.ItemIndex <= 2 then
          begin
            cb.Color := clLime;
            TpoType1 := TTpoType(GetEnumValue(TypeInfo(TTpoType), cb.Text));
            fn       := True;
            no       := I+1;

            cb.SetFocus;
          end
          else
          begin
            cb.Color := RGB(255, 10, 18);     // merah terang
          end;
      end
      else begin
        if cb.ItemIndex <= 2 then
        begin
          cb.Color := clAqua;
        end
        else
        begin
          cb.Color := RGB(242, 119, 151)
          end;   // merah redup
      end;

  end;

  if fn then begin
    edt_Barrel.Text := 'READY';
    lbl_Torp_N.Caption := IntToStr(no);

  end
  else
  begin
    edt_Barrel.Text := 'NOT READY';
    lbl_Torp_N.Caption := 'n';
  end;
end;

procedure TFrm_Main.SetDefaultEnvironment;
begin
  edt_Rng1.Color := clWhite;
  edt_Spd1.Color := clWhite;
  edt_Crs1.Color := clWhite;
  edt_Brg1.Color := clWhite;
  edt_Tn1.Color  := clWhite;
  edt_Rng2.Color := clWhite;
  edt_Spd2.Color := clWhite;
  edt_Crs2.Color := clWhite;
  edt_Brg2.Color := clWhite;
  edt_Tn2.Color  := clWhite;
  edt_Rng3.Color := clWhite;
  edt_Spd3.Color := clWhite;
  edt_Crs3.Color := clWhite;
  edt_Brg3.Color := clWhite;
  edt_Tn3.Color  := clWhite;

  rzchckbx_Tgt1.Checked := False;
  rzchckbx_Tgt2.Checked := False;
  rzchckbx_Tgt3.Checked := False;

  TargetSetNul;

  case CheckBarrelSelected of
    1 : begin
          btn_BARREL1.Down := False;
          cbbBARREL1.Color := clAqua;
        end;
    2 : begin
          btn_BARREL2.Down := False;
          cbbBARREL2.Color := clAqua;
        end;
    3 : begin
          btn_BARREL3.Down := False;
          cbbBARREL3.Color := clAqua;
        end;
    4 : begin
          btn_BARREL4.Down := False;
          cbbBARREL4.Color := clAqua;
        end;
    5 : begin
          btn_BARREL5.Down := False;
          cbbBARREL5.Color := clAqua;
        end;
    6 : begin
          btn_BARREL6.Down := False;
          cbbBARREL6.Color := clAqua;
        end;
  end;

  Fase := fDefault;
  State.SetState(Fase);

  edt_ITA.Text := '0';
  edt_Barrel.Text := 'NOT READY';
  edt_Gyro.Text   := 'OFF';
  edt_Status.Text := 'DESELECTED';
end;

procedure TFrm_Main.SetEditTextInTargetSelected(edt: TEdit; id: integer);
begin
  case id of
    1 : if rzchckbx_Tgt1.Checked then
          edt.Color := clRed;
    2 : if rzchckbx_Tgt2.Checked then
          edt.Color := clRed;
    3 : if rzchckbx_Tgt3.Checked then
          edt.Color := clRed;
  end;

end;

procedure TFrm_Main.btn_FireMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not btnPower.Down then Exit;

  //check heading & timedrop
  if (StrToFloat(edt_Heading.Text) = StrToFloat(edt_OptimCrs.Text)) and
     (StrToFloat(edt_TimeDrop.Text) = 0) then
  begin
    tmrReadyFire.Enabled := True;
  end
  else if (StrToFloat(edt_Heading.Text) < StrToFloat(edt_OptimCrs.Text)+5) and
          (StrToFloat(edt_Heading.Text) > StrToFloat(edt_OptimCrs.Text)-5) and
          (StrToFloat(edt_TimeDrop.Text) = 0) then
  begin
    tmrReadyFire.Enabled := True;
  end
  else Exit;

  //check phase for each step 
  if  Fase = fBarrelSelected  then
  begin
    tmrReadyFire.Enabled := True;
  end
  else if Fase = fGyroStarted then
  begin
    tmrReadyFire.Enabled := True;
  end
  else if Fase = fBeforeSelection then
  begin
    tmrReadyFire.Enabled := True;
  end
  else Exit;

  if (StrToFloat(edtRoll.Text) > StrToFloat(edtRoll.Text)+5) then
  begin
    pnl_Roll.Color := clRed;

    TimeFirePush := TimeFirePush + 7;

    tmrReadyFire.Enabled := True;
  end;

  if ((btnKey.Down = false) and (isLoadProgram = false)) then
  Exit;
end;

procedure TFrm_Main.btn_FireMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tmrReadyFire.Enabled := False;
  TimeFirePush := 0;
end;

procedure TFrm_Main.btn_H1Click(Sender: TObject);
var
  bt : TSpeedButton;
  cb : TComboBox;
  I  : Integer;
  s  : string;
begin
  btn_RESET.Down := True;

  for I := 0 to 5 do begin
    bt:= ListBtnbarrel[I];
    if bt.Down then
    begin
      cb:= ListCbbBarrel[I];

      if cb.ItemIndex <= 2 then
      begin
        bt.Down := False;
        cb.ItemIndex:= 0;

        tmrLoadProgram.Enabled := False;
        s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
        imgStanby.Picture.LoadFromFile(s);
      end
      else if cb.ItemIndex = 3 then
      begin
        bt.Down := False;
        cb.ItemIndex:= 3;
      end
      else if cb.ItemIndex = 4 then
      begin
        bt.Down := False;
        cb.ItemIndex:= 4;
      end
      else if cb.ItemIndex = 5 then
      begin
        bt.Down := False;
        cb.ItemIndex:= 5;
      end;

      TargetUnCheck;
      TargetSetNul;

      if rzchckbx_Tgt1.Checked then rzchckbx_Tgt1.Checked := False;
      if rzchckbx_Tgt2.Checked then rzchckbx_Tgt2.Checked := False;
      if rzchckbx_Tgt3.Checked then rzchckbx_Tgt3.Checked := False;

    end

  end;

  SetClrEdtTrp; 
  cbb_Wtr.Text:= 'SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  lbl_Torp_N.Caption := 'n';

  Fase := fDefault;
  State.SetState(Fase);
  edt_ITA.Text    := '0';
  edt_Barrel.Text := 'NOT READY';
  edt_Gyro.Text   := 'OFF';
  edt_Status.Text := 'DESELECTED';
end;

procedure TFrm_Main.btn_H1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H1, vrstrnglst1.Strings[46]);
end;

procedure TFrm_Main.btn_H1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H1, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H2Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL6.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_6 := 8;
    cbbBARREL6.SetFocus;
  end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL6.Down then
    btn_BARREL6.Down := False
  else
  begin
    btn_BARREL6.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlPortTIU.Caption   = 'INOP') or
       (pnlPort45.Caption    = 'NO')    or
       (pnlPortTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL6.Down := False;
      cbbBARREL6.SetFocus;
    end;

    case cbbBARREL6.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;

  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H2, vrstrnglst1.Strings[46]);
end;

procedure TFrm_Main.btn_H2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H2, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H3Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL2.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_2 := 8;
    cbbBARREL2.SetFocus;
  end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL2.Down then
    btn_BARREL2.Down:= False
  else
  begin
    btn_BARREL2.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlPortTIU.Caption   = 'INOP') or
       (pnlPort45.Caption    = 'NO')    or
       (pnlPortTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL2.Down := False;
      cbbbARREL2.SetFocus;
    end;

    case cbbBARREL2.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;
  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H3, vrstrnglst1.Strings[46]);

end;

procedure TFrm_Main.btn_H3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H3, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H4Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL4.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_4 := 8;
    cbbBARREL4.SetFocus;
  end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL4.Down then
    btn_BARREL4.Down:= False
  else begin
    btn_BARREL4.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlPortTIU.Caption   = 'INOP') or
       (pnlPort45.Caption    = 'NO')    or
       (pnlPortTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL4.Down := False;
      cbbBARREL4.SetFocus;
    end;

    case cbbBARREL4.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;
  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H4, vrstrnglst1.Strings[46]);

end;

procedure TFrm_Main.btn_H4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H4, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H5Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL5.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_5 := 8;
    cbbBARREL5.SetFocus;
  end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL5.Down then
    btn_BARREL5.Down:= False
  else
  begin
    btn_BARREL5.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlStbdTIU.Caption   = 'INOP') or
       (pnlStbd45.Caption    = 'NO')    or
       (pnlStbdTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL5.Down := False;
      cbbBARREL5.SetFocus;
    end;

    case cbbBARREL5.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;
  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H5, vrstrnglst1.Strings[46]);

end;

procedure TFrm_Main.btn_H5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H5, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H6Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL1.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_1 := 8;
    cbbBARREL1.SetFocus;
  end;

   if cbbBARREL1.ItemIndex = 4 then
   begin
     FStatusConsole.SPS_BARREL_1 := 8;
     cbbBARREL1.SetFocus;
   end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL1.Down then
     btn_BARREL1.Down:= False
  else
  begin
    btn_BARREL1.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlStbdTIU.Caption   = 'INOP') or
       (pnlStbd45.Caption    = 'NO')    or
       (pnlStbdTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL1.Down := False;
      cbbBARREL1.SetFocus;
    end;

    case cbbBARREL1.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;
  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H6, vrstrnglst1.Strings[46]);
end;

procedure TFrm_Main.btn_H6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H6, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.btn_H7Click(Sender: TObject);
var
    idx : integer;
    cb  : TComboBox;
begin
  if not btnPower.Down then Exit;

  if cbbBARREL3.ItemIndex = 4 then
  begin
    FStatusConsole.SPS_BARREL_3 := 8;
    cbbBARREL3.SetFocus;
  end;

  if btn_V4.Caption = 'STOP GYRO' then
  Exit;

  if btn_BARREL3.Down then
    btn_BARREL3.Down:= False
  else begin
    btn_BARREL3.Down := True;

    if (pnl_linkStat.Caption = 'INOP') or
       (pnlStbdTIU.Caption   = 'INOP') or
       (pnlStbd45.Caption    = 'NO')    or
       (pnlStbdTMP.Caption   = 'OVR')   then
    begin
      btn_BARREL3.Down := False;
      cbbBARREL3.SetFocus;
    end;

    case cbbBARREL3.ItemIndex of
      0 : TpoType1 := A244MOD3;
      1 : TpoType1 := A244MOD1;
    end;
  end;

  idx:= (Sender as Tcomponent).tag;
  if StateTorp[idx] > 0 then begin
    cb:= ListCbbBarrel[idx-1];
    cb.ItemIndex:=StateTorp[idx] + 3;
  end;

  TargetSetNul;

  // Barrel:=nil;
  edt_ITA.Text    := '0';
  edt_Status.Text := 'DESELECTED';

  cbb_Wtr.Text:='SH';
  defaultValue(TpoType1, cbb_Wtr.Text);
  SetClrEdtTrp;

  GetBarrelStatusByID(CheckBarrelSelected);
end;

procedure TFrm_Main.btn_H7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H7, vrstrnglst1.Strings[46]);
end;

procedure TFrm_Main.btn_H7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_H7, vrstrnglst1.Strings[23]);
end;

procedure TFrm_Main.SetImgButton(st: TPwr);
var
  i: Integer;
  btn: TVrBitmapButton;
begin
  case st of
    stOFF:
      begin
        for i := 0 to 6 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[0]);
        end;
        for i := 7 to 12 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[1]);
        end;
        for i := 13 to 33 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[i - 11]);
        end;
        Load_ImgButton(btn_Fire, vrstrnglst1.Strings[69]);
        pnl_screen.Visible := false;
      end;
    stON:
      begin
        for i := 0 to 6 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[23]);
        end;
        for i := 7 to 12 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[24]);
        end;
        for i := 13 to 33 do
        begin
          btn := ListBtn[i];
          Load_ImgButton(btn, vrstrnglst1.Strings[i + 12]);
        end;
        Load_ImgButton(btn_Fire, vrstrnglst1.Strings[70]);
        pnl_screen.Visible := true;
      end;

  end;
end;

procedure TFrm_Main.btn_Push0MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push0, vrstrnglst1.Strings[48]);

end;

procedure TFrm_Main.btn_Push0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push0, vrstrnglst1.Strings[25]);
end;

procedure TFrm_Main.btn_Push1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push1, vrstrnglst1.Strings[49]);
end;

procedure TFrm_Main.btn_Push1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push1, vrstrnglst1.Strings[26]);
end;

procedure TFrm_Main.btn_Push2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push2, vrstrnglst1.Strings[50]);
end;

procedure TFrm_Main.btn_Push2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push2, vrstrnglst1.Strings[27]);

end;

procedure TFrm_Main.btn_Push3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push3, vrstrnglst1.Strings[51]);
end;

procedure TFrm_Main.btn_Push3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push3, vrstrnglst1.Strings[28]);

end;

procedure TFrm_Main.btn_Push4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push4, vrstrnglst1.Strings[52]);
end;

procedure TFrm_Main.btn_Push4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push4, vrstrnglst1.Strings[29]);

end;

procedure TFrm_Main.btn_Push5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push5, vrstrnglst1.Strings[53]);

end;

procedure TFrm_Main.btn_Push5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push5, vrstrnglst1.Strings[30]);

end;

procedure TFrm_Main.btn_Push6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push6, vrstrnglst1.Strings[54]);

end;

procedure TFrm_Main.btn_Push6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push6, vrstrnglst1.Strings[31]);

end;

procedure TFrm_Main.btn_Push7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push7, vrstrnglst1.Strings[55]);

end;

procedure TFrm_Main.btn_Push7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push7, vrstrnglst1.Strings[32]);

end;

procedure TFrm_Main.btn_Push8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push8, vrstrnglst1.Strings[56]);

end;

procedure TFrm_Main.btn_Push8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push8, vrstrnglst1.Strings[33]);

end;

procedure TFrm_Main.btn_Push9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push9, vrstrnglst1.Strings[57]);

end;

procedure TFrm_Main.btn_Push9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Push9, vrstrnglst1.Strings[34]);

end;

procedure TFrm_Main.btn_PushCHNClick(Sender: TObject);
var Top : Integer;
begin
  if not btnPower.Down then Exit;

  // change combobox value
  if (ActiveControl is TComboBox) then
  begin
    case (ActiveControl as TComboBox).tag of
      1..6 :
      begin
        if (ActiveControl as TComboBox).ItemIndex > 2 then Exit;
        Top := 2;
      end
      else
      begin
        Top := (ActiveControl as TComboBox).Items.Count - 1;
      end;
    end;

    if (ActiveControl as TComboBox).ItemIndex = Top then
      (ActiveControl as TComboBox).ItemIndex := 0
    else
      (ActiveControl as TComboBox).ItemIndex :=
      (ActiveControl as TComboBox).ItemIndex + 1;

    if StandAloneMode then
    begin
      if (ActiveControl as TComboBox).Tag = 44 then
      begin
        CalchPHPOnStandAlone(StrToFloat(edt_Heading.Text), StrToFloat(edt_Speed.Text));
      end;
    end;
  end;

  // choose checkbox Target
  if (ActiveControl is TRzCheckBox) and (Mode = mdLocal) then
    FindTarget;
end;

procedure TFrm_Main.btn_PushCHNMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushCHN, vrstrnglst1.Strings[61]);

end;

procedure TFrm_Main.btn_PushCHNMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushCHN, vrstrnglst1.Strings[38]);

end;

procedure TFrm_Main.btn_PushCLRMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushCLR, vrstrnglst1.Strings[60]);
end;

procedure TFrm_Main.btn_PushCLRMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushCLR, vrstrnglst1.Strings[37]);
end;

procedure TFrm_Main.btn_PushDOWNClick(Sender: TObject);
var
  i: Integer;
begin
  if not btnPower.Down then Exit;

  NavDataTgt(tdirection((Sender as Tcomponent).Tag), iact, jact);
  //CheckTargetEnggaged;
end;

procedure TFrm_Main.btn_PushDOWNMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushDOWN, vrstrnglst1.Strings[67]);
end;

procedure TFrm_Main.btn_PushDOWNMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushDOWN, vrstrnglst1.Strings[44]);
end;

function TFrm_Main.ChangeStringValue(str: string):string;
var
  i : Integer;
  firstdotPos : integer;
  isSearch : Boolean;
  isFound : Boolean;

  strFloat : Double;
begin
  firstdotPos := -1;
  isSearch := True;

  for i := 1 to Length(str) do
  begin
    if str[i] = '.' then
    begin
      firstdotPos := i;
      Break;
    end;
  end;

  while isSearch do
  begin
    isFound := False;
    for i := Length(str) downto 1  do
    begin
      if i = firstdotPos then Continue;
      if str[i] = '.' then
      begin
        Delete(str, i, 1);
        isFound := true;

        Break;
      end;
    end;

    if not isFound then
    begin
      isSearch := false;
      Break;
    end;
  end;

  if TryStrToFloat(str, strFloat) then
    Result := str
  else
    Result := '0';
end;

procedure TFrm_Main.btn_PushENTClick(Sender: TObject);
var
  md: string;
  i : Integer;
begin
  //For Magic Key
  //Check Key Number
  //Net Setting
  if (KeyNumber[0]=3) and (KeyNumber[1]=3) and (KeyNumber[2]=3) then frmNetSetting.Show;
  //Log Memo
  if (KeyNumber[0]=6) and (KeyNumber[1]=6) and (KeyNumber[2]=6) then frmLogMemo.Show;
  //Close
  if (KeyNumber[0]=9) and (KeyNumber[1]=9) and (KeyNumber[2]=9) then Application.Terminate;

  idKeyNumber := 0;
  for i := 0 to 2 do
  begin
    KeyNumber[i] := 0;
  end;

  if not btnPower.Down then Exit;

  // active control checkbox Target
  if (ActiveControl is TRzCheckBox) then
  begin
    if CheckBarrelSelected <> 0 then
    begin
      SelectTarget(True); // Selected Target
    end;

    Exit;
  end;

  if (ActiveControl is TWincontrol) then
  begin
    case (ActiveControl as TWincontrol).Tag of
      100:
        begin
          // select Mode
          if not StandAloneMode then
          begin
            if (ActiveControl as TComboBox).Text = 'NORMAL' then
            begin
              md := 'Normal';
            end
            else
            begin
              md := 'Local';
              edt_Speed.Text    := '0';
              edt_Heading.Text  := '0';
            end;

            Mode := TMode(GetEnumValue(TypeInfo(TMode), md));

            Shipdata.Source:=cbb_Mode.Text;

            if cbb_Mode.ItemIndex = 0 then begin
              cbb_Source.Text     := 'NDS';
            end
            else begin
              cbb_Source.Text     := 'LCP';
            end;

          end
          else
          begin
            cbb_Mode.ItemIndex := 1;
          end;
        end;

      1 .. 6:
        begin
          // select Barrel n insert Torp
          TpoType1 := TTpoType(GetEnumValue(TypeInfo(TTpoType),
          (ActiveControl as TComboBox).Text));

          TorpData.Torp := TpoType1;            // select Torp Type
          defaultValue(TpoType1, cbb_Wtr.Text); // Set default Value Torp Data

          frmLogMemo.mmoSetting.Lines.Add('Torp ' +
          (ActiveControl as TComboBox).Text + 'Loaded');
        end;

       // insert Target Data
      11: ListTargetData[1].Tn  := StrToFloat(ChangeStringValue(edt_Tn1.Text));
      12: ListTargetData[1].Rng := StrToFloat(ChangeStringValue(edt_Rng1.Text));
      13: ListTargetData[1].Brg := StrToFloat(ChangeStringValue(edt_Brg1.Text));
      14: ListTargetData[1].Crs := StrToFloat(ChangeStringValue(edt_Crs1.Text));
      15: ListTargetData[1].Spd := StrToFloat(ChangeStringValue(edt_Spd1.Text));

      21: ListTargetData[2].Tn  := StrToFloat(ChangeStringValue(edt_Tn2.Text));
      22: ListTargetData[2].Rng := StrToFloat(ChangeStringValue(edt_Rng2.Text));
      23: ListTargetData[2].Brg := StrToFloat(ChangeStringValue(edt_Brg2.Text));
      24: ListTargetData[2].Crs := StrToFloat(ChangeStringValue(edt_Crs2.Text));
      25: ListTargetData[2].Spd := StrToFloat(ChangeStringValue(edt_Spd2.Text));

      31: ListTargetData[3].Tn  := StrToFloat(ChangeStringValue(edt_Tn3.Text));
      32: ListTargetData[3].Rng := StrToFloat(ChangeStringValue(edt_Rng3.Text));
      33: ListTargetData[3].Brg := StrToFloat(ChangeStringValue(edt_Brg3.Text));
      34: ListTargetData[3].Crs := StrToFloat(ChangeStringValue(edt_Crs3.Text));
      35: ListTargetData[3].Spd := StrToFloat(ChangeStringValue(edt_Spd3.Text));

      42: Shipdata.Heading := StrToInt(edt_Heading.Text);
      43: Shipdata.Speed :=StrToInt(edt_Speed.Text);

      44:
      begin
        Fire.TctData.MHP:= StrToInt(Copy(cbb_MHP.Text,1,2));
      end;

      51: TorpData.Isc := StrToInt(edt_Isc.Text);

      52:
      begin
        TorpData.Wtr := cbb_Wtr.Text;
        WtrChnValue(cbb_Wtr.Text);

        TorpData.Ace := StrToInt(cbb_Ace.Text);
        TorpData.Cei := StrToInt(cbb_Cei.Text);
        TorpData.Flo := StrToInt(cbb_Flo.Text);
        TorpData.Prg := cbb_Prg.Text;
        TorpData.Isd := StrToInt(cbb_Isd.Text);
        TorpData.Dop := cbb_Dop.Text;
        TorpData.Acm := cbb_Acm.Text;
      end;

      53: TorpData.Cei := StrToInt(cbb_Cei.Text);

      54: TorpData.Prg := cbb_Prg.Text;

      55: TorpData.Dop := cbb_Dop.Text;

      61: TorpData.Isr := StrToInt(cbb_Isr.Text);

      62: TorpData.Ace := StrToInt(cbb_Ace.Text);

      63:
      begin
        TorpData.Flo := StrToInt(cbb_Flo.Text);

        while (TorpData.Flo < StrToInt((cbb_Isd.Text))) do
          cbb_Isd.ItemIndex:=cbb_Isd.ItemIndex - 1;

        TorpData.Isd := StrToInt(cbb_Isd.Text);
      end;

      64:
      begin
        TorpData.Isd := StrToInt(cbb_Isd.Text);

        while (TorpData.Isd > StrToInt(cbb_Flo.Text)) do
          cbb_Flo.ItemIndex:=cbb_Flo.ItemIndex + 1;

        TorpData.Flo := StrToInt(cbb_Flo.Text);
      end;

      65: TorpData.Acm := cbb_Acm.Text;

    end;

  end;

  keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrm_Main.btn_PushENTMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushENT, vrstrnglst1.Strings[62]);
end;

procedure TFrm_Main.btn_PushENTMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushENT, vrstrnglst1.Strings[39]);

end;

procedure TFrm_Main.btn_PushESCMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushESC, vrstrnglst1.Strings[65]);

end;

procedure TFrm_Main.btn_PushESCMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushESC, vrstrnglst1.Strings[42]);

end;

procedure TFrm_Main.btn_PushLEFTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushLEFT, vrstrnglst1.Strings[66]);
end;

procedure TFrm_Main.btn_PushLEFTMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushLEFT, vrstrnglst1.Strings[43]);
end;

procedure TFrm_Main.btn_PushPlusMinClick(Sender: TObject);
var
  ScrollMessage:TWMVScroll;

begin
     {SCROLL TOP}
//   ScrollMessage.Msg:=WM_VScroll;
//   SendMessage(mmo_displayMSG.Handle, EM_SETSEL, 0, 0);
//   SendMessage(mmo_displayMSG.Handle, EM_SCROLLCARET, 0, 0);
//   curidxMmo:=0;
//   Exit;
    ScrollMessage.ScrollCode:=sb_LineDown;
    mmo_displayMSG.Dispatch(ScrollMessage);
  //  curidxMmo:=curidxMmo + 1;

end;

procedure TFrm_Main.btn_PushPlusMinMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushPlusMin, vrstrnglst1.Strings[58]);
end;

procedure TFrm_Main.btn_PushPlusMinMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushPlusMin, vrstrnglst1.Strings[35]);

end;

procedure TFrm_Main.btn_PushRIGHTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushRIGHT, vrstrnglst1.Strings[68]);

end;

procedure TFrm_Main.btn_PushRIGHTMouseUp
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushRIGHT, vrstrnglst1.Strings[45]);

end;

procedure TFrm_Main.btn_PushTABClick(Sender: TObject);
var
  i : Integer;
begin
  idKeyNumber := 0;
  for i := 0 to 2 do
  begin
    KeyNumber[i] := 0;
  end;

  if not btnPower.Down then Exit;

  keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrm_Main.btn_PushTABMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushTAB, vrstrnglst1.Strings[63]);

end;

procedure TFrm_Main.btn_PushTABMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushTAB, vrstrnglst1.Strings[40]);

end;

procedure TFrm_Main.btn_PushtitikMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Pushtitik, vrstrnglst1.Strings[59]);
end;

procedure TFrm_Main.btn_PushtitikMouseUp
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_Pushtitik, vrstrnglst1.Strings[36]);

end;

procedure TFrm_Main.btn_PushUPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushUP, vrstrnglst1.Strings[64]);

end;

procedure TFrm_Main.btn_PushUPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChnImgButton(PowerState, btn_PushUP, vrstrnglst1.Strings[41]);

end;

procedure TFrm_Main.cbbBARREL6Change(Sender: TObject);
begin
  if ((Sender as TComboBox).Text = 'A244MOD3') or
     ((Sender as TComboBox).Text = 'A244MOD1') or
     ((Sender as TComboBox).Text = 'OTHER') then
   (Sender as TComboBox).Color := clAqua
  else
   (Sender as TComboBox).Color := RGB(242, 119, 151);
end;

procedure TFrm_Main.cbbBARREL6Click(Sender: TObject);
begin

  if ((Sender as TComboBox).Text = 'A244MOD3') or
     ((Sender as TComboBox).Text = 'A244MOD1') or
     ((Sender as TComboBox).Text = 'OTHER') then
    (Sender as TComboBox).Color := clAqua
  else
    (Sender as TComboBox).Color := RGB(242, 119, 151);
end;

procedure TFrm_Main.cbb_AceExit(Sender: TObject);
begin
  cbb_Ace.Text := IntToStr(TorpData.Ace);
end;

procedure TFrm_Main.cbb_AcmExit(Sender: TObject);
begin
  cbb_Acm.Text := TorpData.Acm;
end;

procedure TFrm_Main.cbb_CeiExit(Sender: TObject);
begin
  cbb_Cei.Text := IntToStr(TorpData.Cei);
end;

procedure TFrm_Main.cbb_DopExit(Sender: TObject);
begin
  cbb_Dop.Text := TorpData.Dop;
end;

procedure TFrm_Main.cbb_FloExit(Sender: TObject);
begin
  cbb_Flo.Text := IntToStr(TorpData.Flo);
end;

procedure TFrm_Main.cbb_IsdExit(Sender: TObject);
begin
  cbb_Isd.Text := IntToStr(TorpData.Isd);
end;

procedure TFrm_Main.cbb_IsrExit(Sender: TObject);
begin
  cbb_Isr.Text := IntToStr(TorpData.Isr);
end;

procedure TFrm_Main.cbb_PrgExit(Sender: TObject);
begin
  cbb_Prg.Text := TorpData.Prg;
end;

procedure TFrm_Main.cbb_SourceEnter(Sender: TObject);
begin
  jact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 2, 1));
  iact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 1, 1));
end;

procedure TFrm_Main.cbb_WtrChange(Sender: TObject);
begin
  WtrChnValue(cbb_Wtr.Text);
end;

procedure TFrm_Main.cbb_WtrExit(Sender: TObject);
begin
    cbb_Wtr.Text := TorpData.Wtr
end;

procedure TFrm_Main.FormActivate(Sender: TObject);
begin
   // Port error
   if ErrorTIU1 <> '' then begin         //TIU
     mmo_displayMSG.Lines.Add('');
     mmo_displayMSG.Lines.Add(ErrorTIU1);
     mmo_displayMSG.Lines.Add('');
     ErrorTIU1 := '';
   end;

   if AnglePort = 45 then begin           // 45
     pnlPort45.Color:=clLime;
     pnlPort45.Caption :='OP';
   end
   else
   begin
     pnlPort45.Color:=clRed;
     pnlPort45.Caption :='NO';
   end;

   if TmpPort>=100 then begin            // TMP
     pnlPortTMP.Caption:='OVR';
     pnlPortTMP.Color:=clRed;
   end
   else
   begin
     pnlPortTMP.Caption:='OK';
     pnlPortTMP.Color:=clLime;
   end;

   // STBD error
   if ErrorTIU2 <> '' then
   begin
     mmo_displayMSG.Lines.Add('');
     mmo_displayMSG.Lines.Add(ErrorTIU2);   //TIU
     mmo_displayMSG.Lines.Add('');
     ErrorTIU1 := '';
   end;

   if AngleStbd = 45 then
   begin
     pnlStbd45.Color:=clLime;              //45
     pnlStbd45.Caption :='OP';
   end
   else
   begin
     pnlStbd45.Color:=clRed;
     pnlStbd45.Caption :='NO';
   end;

   if TmpStbd >=100 then
   begin            //TMP
     pnlStbdTMP.Caption:='OVR';
     pnlStbdTMP.Color:=clRed;
   end
   else
   begin
     pnlStbdTMP.Caption:='OK';
     pnlStbdTMP.Color:=clLime;
   end;

end;

procedure TFrm_Main.AddToLog(const LogMemo : TStringList;  str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

procedure TFrm_Main.FormCreate(Sender: TObject);
var
  i, Env_Map,
  ShipClassID  : Integer;
  ShipName,
  ShipClassName: string;
begin
  idKeyNumber := 0;

  TransparentColor := True;
  TransparentColorValue := clFuchsia;

  data_path     := Copy(ExtractFilepath(application.exename),1,Length(ExtractFiledir(application.exename))-4)+'\data' ;

  State         := Tstate.Create;
  ListBtn       := TList.Create;
  ListBtnBarrel := TList.Create;
  ListCbbBarrel := TList.Create;

  TheClient     := TTCPClient.Create;

  { added by bagoes }
  StandAloneMode := ParamCount <> max_param;

  if not StandAloneMode then  begin
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass, pShipID, pCurrentScenID);

    if DataModule1.InitZDB(pDBServer, pDBProto, pDBName, pDBUser, pDBPass) then
    begin
      ShipClassID  := DataModule1.GetShipType(pShipID, ShipClassName);
      ShipName     := DataModule1.GetShipName(pShipID);


      AddToLog(TheClient.Log, ' ShipID      = ' + IntToStr(pShipID));
      AddToLog(TheClient.Log, ' ShipClassId = ' + IntToStr(ShipClassID) );
      AddToLog(TheClient.Log, ' ShipName ' + ShipName );
      AddToLog(TheClient.Log, ' ShipClassName ' + ShipClassName );
    end;
    Env_Map := DataModule1.GetMapById(pCurrentScenID);
    DataModule1.GetOffsetMapByEnvMap(Env_Map ,OffX_Map, OffY_Map);
  end
  else
  begin
    OffX_Map := 0;
    OffY_Map := 0;

    cbb_Mode.ItemIndex := 1;
    Shipdata.Source    := cbb_Mode.Text;

    cbb_Source.Text      := 'LCP';

  end;
  { added by bagoes }

  //Connect to bridge
  tmrConnectToBridge.Enabled := True;
  TheClient.Socket.OnChangeState := onTCPChangeState;

  // Register Procedure SOCKET
  TheClient.RegisterProcedure(REC_3D_POSITION, EventOnReceiveDataPosition, sizeof(TRecData3DPosition));
  TheClient.RegisterProcedure(REC_SPSS_ORDER, nil, SizeOf(TRecDataTorperdo));
  TheClient.RegisterProcedure(REC_STAT_ORDER_CONSOLE, OnReceiveStatusConsole, SizeOf(TRecStatus_Console));
  TheClient.RegisterProcedure(REC_MISSILEPOS , OnReceiveTorpedoStatus, SizeOf(TRecMissilePos));
  TheClient.RegisterProcedure(REC_2D_ORDER, nil, SizeOf(TRecData2DOrder));


  Mode     := mdNormal;
  Fase     := fDefault;
  TpoType1 := A244MOD3;

  with Shipdata do begin
    Source   := cbb_Source.Text;
    Heading  := StrToInt(edt_Heading.Text);
    Speed    := StrToInt(edt_Heading.Text);
  end;

  PowerState       := stOFF;

  BootTime      := 0;
  StartUpGyro   := 0;
  IntervalGyro  := 0;
  IntervalGyro  := 0;

  TargetSetNul;

  DefaultTorpData(TpoType1);

  edt_Barrel.Text := 'NOT READY';
  edt_Gyro.Text   := 'OFF';
  edt_Status.Text := 'DESELECTED';

  State.SetButton(btn_V1, btn_V2, btn_V3, btn_V4, btn_V5, btn_V6);
  State.SetState(Fase);

  defaultValue(TpoType1, cbb_Wtr.Text);
  iact := 1;
  jact := 1;

  TEdit_GetIn;
  TBtn_GetIn;
  BtnCbbBarrel_GetIn;

  //default parameter error
  AnglePort := 45;
  AngleStbd := 45;
  TmpPort   := 80;
  TmpStbd   := 80;
  ErrorTpoGyro.code     := 0;
  ErrorSlctbarrel.code  := 0;
  for I := 1 to 6 do
   StateTorp[I]:=0;

  SetRecTorpedoDefaultEnv;

  FStatusConsole := TStatusConsoleSPS.create;

  TimeFirePush  := 0;
  TimeLoadProg  := 0;
  isLoadProgram := False;

end;

procedure TFrm_Main.FormDestroy(Sender: TObject);
begin
 if TheClient.State = wsConnected  then
   TheClient.Disconnect;
   FreeAndNil(TheClient);

  FreeAndNil(State);
  FreeAndNil(ListBtn);
  FreeAndNil(ListBtnBarrel);
  FreeAndNil(ListCbbBarrel);

end;

procedure TFrm_Main.TEdit_GetIn;
begin
  EdtTgtData[1, 1] := edt_Tn1;
  EdtTgtData[1, 2] := edt_Rng1;
  EdtTgtData[1, 3] := edt_Brg1;
  EdtTgtData[1, 4] := edt_Crs1;
  EdtTgtData[1, 5] := edt_Spd1;

  EdtTgtData[2, 1] := edt_Tn2;
  EdtTgtData[2, 2] := edt_Rng2;
  EdtTgtData[2, 3] := edt_Brg2;
  EdtTgtData[2, 4] := edt_Crs2;
  EdtTgtData[2, 5] := edt_Spd2;

  EdtTgtData[3, 1] := edt_Tn3;
  EdtTgtData[3, 2] := edt_Rng3;
  EdtTgtData[3, 3] := edt_Brg3;
  EdtTgtData[3, 4] := edt_Crs3;
  EdtTgtData[3, 5] := edt_Spd3;

  EdtTgtData[4, 1] := cbb_Source;
  EdtTgtData[4, 2] := edt_Heading;
  EdtTgtData[4, 3] := edt_Speed;
  EdtTgtData[4, 4] := cbb_MHP;
  EdtTgtData[4, 5] := nil;

  EdtTgtData[5, 1] := edt_Isc;
  EdtTgtData[5, 2] := cbb_Wtr;
  EdtTgtData[5, 3] := cbb_Cei;
  EdtTgtData[5, 4] := cbb_Prg;
  EdtTgtData[5, 5] := cbb_Dop;

  EdtTgtData[6, 1] := cbb_Isr;
  EdtTgtData[6, 2] := cbb_Ace;
  EdtTgtData[6, 3] := cbb_Flo;
  EdtTgtData[6, 4] := cbb_Isd;
  EdtTgtData[6, 5] := cbb_Acm;

end;

procedure TFrm_Main.TBtn_GetIn;
begin
  // insert Horisontal button
  ListBtn.Add(btn_H1); // idx==>0
  ListBtn.Add(btn_H2);
  ListBtn.Add(btn_H3);
  ListBtn.Add(btn_H4);
  ListBtn.Add(btn_H5);
  ListBtn.Add(btn_H6);
  ListBtn.Add(btn_H7);

  // insert Vertical button
  ListBtn.Add(btn_V11); // idx==>7
  ListBtn.Add(btn_V12);
  ListBtn.Add(btn_V13);
  ListBtn.Add(btn_V14);
  ListBtn.Add(btn_V15);
  ListBtn.Add(btn_V16);

  // insert keyboard button
  ListBtn.Add(btn_Push0); // idx==> 13
  ListBtn.Add(btn_Push1);
  ListBtn.Add(btn_Push2);
  ListBtn.Add(btn_Push3);
  ListBtn.Add(btn_Push4);
  ListBtn.Add(btn_Push5);
  ListBtn.Add(btn_Push6);
  ListBtn.Add(btn_Push7);
  ListBtn.Add(btn_Push8);
  ListBtn.Add(btn_Push9); // idx==> 22
  ListBtn.Add(btn_PushPlusMin);
  ListBtn.Add(btn_Pushtitik);
  ListBtn.Add(btn_PushCLR);
  ListBtn.Add(btn_PushCHN);
  ListBtn.Add(btn_PushENT);
  ListBtn.Add(btn_PushTAB);
  ListBtn.Add(btn_PushUP);
  ListBtn.Add(btn_PushESC);
  ListBtn.Add(btn_PushLEFT);
  ListBtn.Add(btn_PushDOWN);
  ListBtn.Add(btn_PushRIGHT);
  ListBtn.Add(btn_Fire); // idx==>34
end;

procedure TFrm_Main.btn1Click(Sender: TObject);
begin
  SendMessage(mmo_displayMSG.Handle, EM_SETSEL, 0, 0);
  {scroll a memo to start position}
  SendMessage(mmo_displayMSG.Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TFrm_Main.BtnCbbBarrel_GetIn;
var
  i: Integer;
  cb : TComboBox;
begin
  // insert Barrel button
  ListBtnBarrel.Add(btn_BARREL1);
  ListBtnBarrel.Add(btn_BARREL2);
  ListBtnBarrel.Add(btn_BARREL3);
  ListBtnBarrel.Add(btn_BARREL4);
  ListBtnBarrel.Add(btn_BARREL5);
  ListBtnBarrel.Add(btn_BARREL6);
  ListBtnBarrel.Add(btn_RESET); // idx==>0

  ListCbbBarrel.Add(cbbBARREL1);
  ListCbbBarrel.Add(cbbBARREL2);
  ListCbbBarrel.Add(cbbBARREL3);
  ListCbbBarrel.Add(cbbBARREL4);
  ListCbbBarrel.Add(cbbBARREL5);
  ListCbbBarrel.Add(cbbBARREL6);

  //initilize for cbbbarrel = empty
  for i := 0 to 5 do
  begin
    cb := TComboBox(ListCbbBarrel.Items[i]);
    cb.ItemIndex := 4;
    cb.Color := RGB(242, 119, 151);   // merah redup
  end;
end;

procedure TFrm_Main.WtrChnValue(wtr: string);
begin
  if cbb_Wtr.Text = 'SH' then
  begin
    FillCBB(Tcbb(2), cbb_Cei);
    FillCBB(Tcbb(3), cbb_Flo);
    FillCBB(Tcbb(4), cbb_Isd);
    cbb_Isd.ItemIndex := 3;
    cbb_Flo.ItemIndex := 2;
  end;
  if cbb_Wtr.Text = 'DP' then
  begin
    FillCBB(Tcbb(5), cbb_Cei);
    FillCBB(Tcbb(6), cbb_Flo);
    FillCBB(Tcbb(7), cbb_Isd);
    cbb_Isd.ItemIndex := 1;
    cbb_Flo.ItemIndex := 1;
  end;

  cbb_Cei.ItemIndex := 1;
  cbb_Prg.ItemIndex := 0;
  cbb_Ace.ItemIndex := 0;
  cbb_Dop.ItemIndex := 1;
  cbb_Acm.ItemIndex := 2;
end;

procedure TFrm_Main.defaultValue(Tp: TTpoType; wt: string);
begin
  if Tp = A244MOD1 then
  begin
    FillCBB(Tcbb(0), cbb_Isr);
    FillCBB(Tcbb(1), cbb_Ace);
  end
  else if Tp = A244MOD3 then
  begin
    FillCBB(Tcbb(8), cbb_Isr);
    FillCBB(Tcbb(9), cbb_Ace);
  end;
   cbb_Isr.ItemIndex := 3;

   WtrChnValue(wt);

end;

procedure TFrm_Main.DefaultTorpData(Tpo: TTpoType);
begin
  case Tpo of
    A244MOD3:
      begin
        TorpData.Isc := 0;
        TorpData.Isr := 3600;
        TorpData.Wtr := 'SH';
        TorpData.Ace := 0;
        TorpData.Cei := 10;
        TorpData.Flo := 60;
        TorpData.Prg := 'HE';
        TorpData.Isd := 40;
        TorpData.Dop := 'FM';
        TorpData.Acm := 'MIX';
      end;
    A244MOD1:
      begin
        TorpData.Isc := 0;
        TorpData.Isr := 1800;
        TorpData.Wtr := 'SH';
        TorpData.Ace := 0;
        TorpData.Cei := 10;
        TorpData.Flo := 60;
        TorpData.Prg := 'HE';
        TorpData.Isd := 40;
        TorpData.Dop := 'FM';
        TorpData.Acm := 'MIX';
      end;
    MU90:
      begin
        TorpData.Isc := 0;
        TorpData.Isr := 1800;
        TorpData.Wtr := 'SH';
        TorpData.Ace := 0;
        TorpData.Cei := 10;
        TorpData.Flo := 60;
        TorpData.Prg := 'HE';
        TorpData.Isd := 40;
        TorpData.Dop := 'FM';
        TorpData.Acm := 'MIX';
      end;
  end;

end;

procedure TFrm_Main.edtRollChange(Sender: TObject);
begin
  // DATA DIAMBIL DARI NDS (dinamis)
  if (StrTofloat(edtRoll.Text) >= -5) and (StrTofloat(edtRoll.Text) <= 5) then
    edtRoll.Color := clAqua
  else
    edtRoll.Color := clRed;
end;

procedure TFrm_Main.edt_Brg1Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Brg1.Text)) > val then
  begin
     edt_Brg1.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.TargetCheck;
begin
  if rzchckbx_Tgt1.Checked then
  begin
    edt_Tn1.Color := clRed;
    edt_Rng1.Color := clRed;
    edt_Brg1.Color := clRed;
    edt_Crs1.Color := clRed;
    edt_Spd1.Color := clRed;
  end
  else
  if rzchckbx_Tgt2.Checked then
  begin
    edt_Tn2.Color := clRed;
    edt_Rng2.Color := clRed;
    edt_Brg2.Color := clRed;
    edt_Crs2.Color := clRed;
    edt_Spd2.Color := clRed;
  end
  else
  if rzchckbx_Tgt3.Checked then
  begin
    edt_Tn3.Color := clRed;
    edt_Rng3.Color := clRed;
    edt_Brg3.Color := clRed;
    edt_Crs3.Color := clRed;
    edt_Spd3.Color := clRed;
  end;
end;

procedure TFrm_Main.TargetUnCheck;
begin
  edt_Tn1.Color  := clWhite;
  edt_Rng1.Color := clWhite;
  edt_Brg1.Color := clWhite;
  edt_Crs1.Color := clWhite;
  edt_Spd1.Color := clWhite;

  edt_Tn2.Color  := clWhite;
  edt_Rng2.Color := clWhite;
  edt_Brg2.Color := clWhite;
  edt_Crs2.Color := clWhite;
  edt_Spd2.Color := clWhite;

  edt_Tn3.Color  := clWhite;
  edt_Rng3.Color := clWhite;
  edt_Brg3.Color := clWhite;
  edt_Crs3.Color := clWhite;
  edt_Spd3.Color := clWhite;
end;

procedure TFrm_Main.TargetSetNul;
var
  i : integer;
begin
  // Disengaging Target
  rzchckbx_Tgt2.Checked := False;
  rzchckbx_Tgt1.Checked := False;
  rzchckbx_Tgt3.Checked := False;

  edt_Tn1.Text  := '0';
  edt_Rng1.Text := '0.00';
  edt_Brg1.Text := '0.00';
  edt_Crs1.Text := '0.00';
  edt_Spd1.Text := '0.00';
  edt_Tn1.Color := clWhite;
  edt_Rng1.Color := clWhite;
  edt_Brg1.Color := clWhite;
  edt_Crs1.Color := clWhite;
  edt_Spd1.Color := clWhite;

  edt_Tn2.Text  := '0';
  edt_Rng2.Text := '0.00';
  edt_Brg2.Text := '0.00';
  edt_Crs2.Text := '0.00';
  edt_Spd2.Text := '0.00';
  edt_Tn2.Color := clWhite;
  edt_Rng2.Color := clWhite;
  edt_Brg2.Color := clWhite;
  edt_Crs2.Color := clWhite;
  edt_Spd2.Color := clWhite;

  edt_Tn3.Text  := '0';
  edt_Rng3.Text := '0.00';
  edt_Brg3.Text := '0.00';
  edt_Crs3.Text := '0.00';
  edt_Spd3.Text := '0.00';
  edt_Tn3.Color := clWhite;
  edt_Rng3.Color := clWhite;
  edt_Brg3.Color := clWhite;
  edt_Crs3.Color := clWhite;
  edt_Spd3.Color := clWhite;

  for i := 1 to 3 do
  begin
    ListTargetData[i].Tn  := 0;
    ListTargetData[i].Rng := 0;
    ListTargetData[i].Brg := 0;
    ListTargetData[i].Crs := 0;
    ListTargetData[i].Spd := 0;
  end;
end;

procedure TFrm_Main.edt_Brg1Exit(Sender: TObject);
begin
  edt_Brg1.Color :=  clWindow;
  edt_Brg1.Text := FormatFloat('0.00', ListTargetData[1].Brg);

  SetEditTextInTargetSelected(edt_Brg1, 1);
end;

procedure TFrm_Main.edt_Brg2Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Brg2.Text)) > val then
  begin
     edt_Brg2.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Brg2Exit(Sender: TObject);
begin
  edt_Brg2.Color := clWindow;
  edt_Brg2.Text := FormatFloat('0.00', ListTargetData[2].Brg);

  TargetCheck;
end;

procedure TFrm_Main.edt_Brg3Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Brg3.Text)) > val then
  begin
     edt_Brg3.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Brg3Exit(Sender: TObject);
begin
  edt_Brg3.Color := clWindow;
  edt_Brg3.Text := FormatFloat('0.00', ListTargetData[3].Brg);

  TargetCheck;
end;

procedure TFrm_Main.edt_Crs1Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Crs1.Text)) > val then
  begin
     edt_Crs1.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Crs1Exit(Sender: TObject);
begin
  edt_Crs1.Color := clWindow;
  edt_Crs1.Text := FormatFloat('0.00', ListTargetData[1].Crs);

  SetEditTextInTargetSelected(edt_Crs1, 1);
end;

procedure TFrm_Main.edt_Crs2Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Crs2.Text)) > val then
  begin
     edt_Crs2.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Crs2Exit(Sender: TObject);
begin
  edt_Crs2.Color := clWindow;
  edt_Crs2.Text := FormatFloat('0.00', ListTargetData[2].Crs);

  TargetCheck;
end;

procedure TFrm_Main.edt_Crs3Change(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(ChangeStringValue(edt_Crs3.Text)) > val then
  begin
     edt_Crs3.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Crs3Exit(Sender: TObject);
begin
  edt_Crs3.Color := clWindow;
  edt_Crs3.Text := FormatFloat('0.00', ListTargetData[3].Crs);

  TargetCheck;
end;

procedure TFrm_Main.edt_HeadingEnter(Sender: TObject);
begin
  jact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 2, 1));
  iact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 1, 1));
end;

procedure TFrm_Main.edt_IscChange(Sender: TObject);
const
  val= 359;
begin
  if StrToFloat(edt_Isc.Text) > val then
  begin
     edt_Isc.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_IscExit(Sender: TObject);
begin
  edt_Isc.Text := IntToStr(TorpData.Isc);
end;

procedure TFrm_Main.edt_Rng1Change(Sender: TObject);
const
  val= 65535;
begin
  if StrToFloat(ChangeStringValue(edt_Rng1.Text)) > val then
  begin
     edt_Rng1.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Rng1Exit(Sender: TObject);
begin
  edt_Rng1.Color := clWindow;
  edt_Rng1.Text := FormatFloat('0.00', ListTargetData[1].Rng);

  SetEditTextInTargetSelected(edt_Rng1, 1);;
end;

procedure TFrm_Main.edt_Rng2Change(Sender: TObject);
const
  val= 65535;
begin
  if StrToFloat(ChangeStringValue(edt_Rng2.Text)) > val then
  begin
     edt_Rng2.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Rng2Exit(Sender: TObject);
begin
  edt_Rng2.Color := clWindow;
  edt_Rng2.Text := FormatFloat('0.00', ListTargetData[2].Rng);

  TargetCheck;
end;

procedure TFrm_Main.edt_Rng3Change(Sender: TObject);
const
  val= 65535;
begin
  if StrToFloat(ChangeStringValue(edt_Rng3.Text)) > val then
  begin
     edt_Rng3.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Rng3Exit(Sender: TObject);
begin
  edt_Rng3.Color := clWindow;
  edt_Rng3.Text := FormatFloat('0.00', ListTargetData[3].Rng);

  TargetCheck;
end;

procedure TFrm_Main.edt_Spd1Change(Sender: TObject);
const
  val= 100;
begin
  if StrToFloat(ChangeStringValue(edt_Spd1.Text)) > val then
  begin
     edt_Spd1.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Spd1Exit(Sender: TObject);
begin
  edt_Spd1.Color := clWindow;
  edt_Spd1.Text := FormatFloat('0.00', ListTargetData[1].Spd);

  SetEditTextInTargetSelected(edt_Spd1, 1);
end;

procedure TFrm_Main.edt_Spd2Change(Sender: TObject);
const
  val= 100;
begin
  if StrToFloat(ChangeStringValue(edt_Spd2.Text)) > val then
  begin
     edt_Spd2.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Spd2Exit(Sender: TObject);
begin
  edt_Spd2.Color := clWindow;
  edt_Spd2.Text := FormatFloat('0.00', ListTargetData[2].Spd);

  TargetCheck;
end;

procedure TFrm_Main.edt_Spd3Change(Sender: TObject);
const
  val= 100;
begin
  if StrToFloat(ChangeStringValue(edt_Spd3.Text)) > val then
  begin
     edt_Spd3.Text := FloatToStr(val);
  end;
end;

procedure TFrm_Main.edt_Spd3Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
  edt_Spd3.Text := FormatFloat('0.00', ListTargetData[3].Spd);

  TargetCheck;
end;

procedure TFrm_Main.edt_Tn1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := clWhite;
  (Sender as TEdit).Color := RGB(255, 211, 102);
  jact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 2, 1));
  iact := StrToInt(Copy(IntToStr((Sender as Tcomponent).Tag), 1, 1));
end;

procedure TFrm_Main.edt_Tn1Exit(Sender: TObject);
begin
 (Sender as TEdit).Color :=  clWindow;
  edt_Tn1.Text := FormatFloat('0', ListTargetData[1].Tn);

  SetEditTextInTargetSelected(edt_Tn1, 1);
end;

procedure TFrm_Main.edt_Tn2Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
  edt_Tn2.Text := FormatFloat('0', ListTargetData[2].Tn);

  SetEditTextInTargetSelected(edt_Tn2, 2);;
end;

procedure TFrm_Main.edt_Tn3Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
  edt_Tn3.Text := FormatFloat('0', ListTargetData[3].Tn);

  SetEditTextInTargetSelected(edt_Tn3, 3);;
end;

function TFrm_Main.CheckBarrelSelected: Integer;
begin
  Result := 0;

  if btn_BARREL1.Down then
    Result := 1
  else
  if btn_BARREL2.Down then
    Result := 2
  else
  if btn_BARREL3.Down then
    Result := 3
  else
  if btn_BARREL4.Down then
    Result := 4
  else
  if btn_BARREL5.Down then
    Result := 5
  else
  if btn_BARREL6.Down then
    Result := 6
end;

procedure TFrm_Main.CheckTargetEnggaged;
begin
  if rzchckbx_Tgt1.Checked then
  begin
    Set_TgtSelected(edt_Tn1, edt_Rng1, edt_Brg1, edt_Crs1, edt_Spd1, true);
  end
  else
  if rzchckbx_Tgt2.Checked then
  begin
    Set_TgtSelected(edt_Tn2, edt_Rng2, edt_Brg2, edt_Crs2, edt_Spd2, true);
  end
  else
  if rzchckbx_Tgt3.Checked then
  begin
    Set_TgtSelected(edt_Tn3, edt_Rng3, edt_Brg3, edt_Crs3, edt_Spd3, true);
  end;
end;

procedure TFrm_Main.ChnImgButton(stPwr: TPwr; btn: TVrBitmapButton;
  img: string);
begin
  if stPwr = stON then
    Load_ImgButton(btn, img)
  else
    Exit;

end;

procedure TFrm_Main.Close1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrm_Main.FindTarget;
begin
  if (ActiveControl as TRzCheckBox).Tag = 1 then
    rzchckbx_Tgt2.SetFocus
  else if (ActiveControl as TRzCheckBox).Tag = 2 then
    rzchckbx_Tgt3.SetFocus
  else if (ActiveControl as TRzCheckBox).Tag = 3 then
    rzchckbx_Tgt1.SetFocus;
end;

procedure TFrm_Main.StopSelectingTarget;
begin
  if (ActiveControl as TRzCheckBox).Tag = 1 then
    rzchckbx_Tgt1.SetFocus
  else if (ActiveControl as TRzCheckBox).Tag = 2 then
    rzchckbx_Tgt2.SetFocus
  else if (ActiveControl as TRzCheckBox).Tag = 3 then
    rzchckbx_Tgt3.SetFocus;
end;

procedure TFrm_Main.FireTorpedo;
begin

  //nando added
  if FStatusConsole.isReadyToFire(CheckBarrelSelected) then
  begin
    if not FStatusConsole.isErrorInFire(CheckBarrelSelected) then
    begin
      SendFireToController;
      SetAfterFire;

      frmLogMemo.mmoSetting.Lines.Add('Torpedo Launch');
    end
    else
    begin
      frmLogMemo.mmoSetting.Lines.Add('Torpedo Can Not Launch');

      case CheckBarrelSelected of
        1 : begin
              cbbBARREL1.ItemIndex := 5;
              cbbBARREL1.Color     := RGB(255, 10, 18);
            end;
        2 : begin
              cbbBARREL2.ItemIndex := 5;
              cbbBARREL2.Color     := RGB(255, 10, 18);
            end;
        3 : begin
              cbbBARREL3.ItemIndex := 5;
              cbbBARREL3.Color     := RGB(255, 10, 18);
            end;
        4 : begin
              cbbBARREL4.ItemIndex := 5;
              cbbBARREL4.Color     := RGB(255, 10, 18);
            end;
        5 : begin
              cbbBARREL5.ItemIndex := 5;
              cbbBARREL5.Color     := RGB(255, 10, 18);
            end;
        6 : begin
              cbbBARREL6.ItemIndex := 5;
              cbbBARREL6.Color     := RGB(255, 10, 18);
            end;
      end;
    end;
  end
  else
  begin
    frmLogMemo.mmoSetting.Lines.Add('Error In Equipment');
  end;
end;

procedure TFrm_Main.SelectTarget(st: boolean);
var
  isValid : Boolean;
  OldActifTarget : integer;
begin
  isValid := false;

  if rzchckbx_Tgt1.Checked then OldActifTarget := 1;
  if rzchckbx_Tgt2.Checked then OldActifTarget := 2;
  if rzchckbx_Tgt3.Checked then OldActifTarget := 3;

  rzchckbx_Tgt1.OnClick := nil;
  rzchckbx_Tgt2.OnClick := nil;
  rzchckbx_Tgt3.OnClick := nil;

  rzchckbx_Tgt1.Checked := False;
  rzchckbx_Tgt2.Checked := False;
  rzchckbx_Tgt3.Checked := False;

  (ActiveControl as TRzCheckBox).Checked := st;

  if st then
  begin
    case (ActiveControl as TRzCheckBox).Tag of // Selected Target
      1:
      begin
        Fire.Target := ListTargetData[1];
        if (edt_Tn1.Text = '0') or (edt_Rng1.Text = '0') then
        begin
          frmLogMemo.mmoSetting.Lines.Add('Target data is not complete');
          rzchckbx_Tgt1.Checked := False;

          case OldActifTarget of
            1 : rzchckbx_Tgt1.Checked := true;
            2 : rzchckbx_Tgt2.Checked := true;
            3 : rzchckbx_Tgt3.Checked := true;
          end;
        end
        else
        begin
          frmLogMemo.mmoSetting.Lines.Add('Target number ' + (edt_Tn1.Text) + ' has been Selected');
          isValid := True;
        end;
      end;

      2:
      begin
        Fire.Target := ListTargetData[2];
        if (edt_Tn2.Text = '0') or (edt_Rng2.Text = '0') then
        begin
          frmLogMemo.mmoSetting.Lines.Add('There is no Target or Target data is not complete');
          rzchckbx_Tgt2.Checked := False;

          case OldActifTarget of
            1 : rzchckbx_Tgt1.Checked := true;
            2 : rzchckbx_Tgt2.Checked := true;
            3 : rzchckbx_Tgt3.Checked := true;
          end;

        end
        else
        begin
          frmLogMemo.mmoSetting.Lines.Add('Target number '+ (edt_Tn2.Text) + 'has been Selected');
          isValid := True;
        end;
      end;

      3:
      begin
        Fire.Target := ListTargetData[3];
        if (edt_Tn3.Text = '0') or (edt_Rng3.Text = '0') then
        begin
          frmLogMemo.mmoSetting.Lines.Add('There is no Target or Target data is not complete');
          rzchckbx_Tgt3.Checked := False;

          case OldActifTarget of
            1 : rzchckbx_Tgt1.Checked := true;
            2 : rzchckbx_Tgt2.Checked := true;
            3 : rzchckbx_Tgt3.Checked := true;
          end;
        end
        else
        begin
          frmLogMemo.mmoSetting.Lines.Add('Target number '+ (edt_Tn3.Text) + 'has been Selected');
          isValid := True;
        end;
      end;
    end;
  end;

  if isValid then
  begin
    Set_TgtSelected(edt_Tn1, edt_Rng1, edt_Brg1, edt_Crs1, edt_Spd1, rzchckbx_Tgt1.Checked);
    Set_TgtSelected(edt_Tn2, edt_Rng2, edt_Brg2, edt_Crs2, edt_Spd2, rzchckbx_Tgt2.Checked);
    Set_TgtSelected(edt_Tn3, edt_Rng3, edt_Brg3, edt_Crs3, edt_Spd3, rzchckbx_Tgt3.Checked);

    if StandAloneMode then
    begin
      CalchPHPOnStandAlone(StrToInt(edt_Heading.Text), StrToInt(edt_Speed.Text));
    end;
  end;

  rzchckbx_Tgt1.OnClick := rzchckbx_Tgt1Click;
  rzchckbx_Tgt2.OnClick := rzchckbx_Tgt1Click;
  rzchckbx_Tgt3.OnClick := rzchckbx_Tgt1Click;
end;


procedure TFrm_Main.OnESC(TagControl: Integer);
begin
  case TagControl of
    11 : edt_Tn1.Text  := FloatToStr(ListTargetData[1].Tn);
    12 : edt_Rng1.Text := FloatToStr(ListTargetData[1].Rng);
    13 : edt_Brg1.Text := FloatToStr(ListTargetData[1].Brg);
    14 : edt_Crs1.Text := FloatToStr(ListTargetData[1].Crs);
    15 : edt_Spd1.Text := FloatToStr(ListTargetData[1].Spd);
    21 : edt_Tn1.Text  := FloatToStr(ListTargetData[2].Tn);
    22 : edt_Rng1.Text := FloatToStr(ListTargetData[2].Rng);
    23 : edt_Brg1.Text := FloatToStr(ListTargetData[2].Brg);
    24 : edt_Crs1.Text := FloatToStr(ListTargetData[2].Crs);
    25 : edt_Spd1.Text := FloatToStr(ListTargetData[2].Spd);
    31 : edt_Tn1.Text  := FloatToStr(ListTargetData[3].Tn);
    32 : edt_Rng1.Text := FloatToStr(ListTargetData[3].Rng);
    33 : edt_Brg1.Text := FloatToStr(ListTargetData[3].Brg);
    34 : edt_Crs1.Text := FloatToStr(ListTargetData[3].Crs);
    35 : edt_Spd1.Text := FloatToStr(ListTargetData[3].Spd);

    52 : cbb_Wtr.Text := TorpData.Wtr;
    53 : cbb_Cei.Text := IntToStr(TorpData.Cei);
    54 : cbb_Prg.Text := TorpData.Prg;
    55 : cbb_Dop.Text := TorpData.Dop;
    61 : cbb_Isr.Text := IntToStr(TorpData.Isr);
    62 : cbb_Ace.Text := IntToStr(TorpData.Ace);
    63 : cbb_Flo.Text := IntToStr(TorpData.Flo);
    64 : cbb_Isd.Text := IntToStr(TorpData.Isd);
    65 : cbb_Acm.Text := TorpData.Acm;
  end;
  keybd_event(VK_END , 0, 0, 0);
end;

procedure TFrm_Main.onRecDataAvailable(apRec: PAnsiChar; aSize: integer);
var
  aRec: TRecDataPosition;
begin
  CopyMemory(@aRec, apRec, aSize);
  edt_Speed.text   := formatfloat('_000_', aRec.speed);
  edt_Heading.Text := formatfloat('_000_', aRec.heading);
end;

procedure TFrm_Main.OnReceiveStatusConsole(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRecStatus_Console;
  i    : Integer;
  bt   : TSpeedButton;
  cb   : TComboBox;
  s    : string;
begin
  aRec := @apRec^;

  if pShipID = UniqueID_To_dbID(aRec.OWN_SHIP_UID) then
  begin
    case aRec.ErrorID of
    __STAT_SPS_115V              :
      begin
        case aRec.ParamError of
          __PARAM_115V_ON   : ;
          __PARAM_115V_OFF  : ;
        end;

        FStatusConsole.SPS_115V := aRec.ParamError;
      end;
    __STAT_SPS_NDS               :
      begin
        case aRec.ParamError of
          __PARAM_NDS_ON  :
            begin
              pnl_linkStat.Color    := clLime;
              pnl_linkStat.Caption  := 'OP';

              pnl_Roll.Color        := clLime;
              cbb_Source.ItemIndex  := 0;
            end;
          __PARAM_NDS_OFF :
            begin
              pnl_linkStat.Color    := clRed;
              pnl_linkStat.Caption  := 'INOP';

              pnl_Roll.Color        := clRed;
              cbb_Source.ItemIndex  := 1;

              if cbb_Mode.ItemIndex = 0 then
              begin
                cbb_Source.Text     := 'NDS';
              end
              else
              begin
                cbb_Source.Text     := 'LCP';
                edt_Heading.Text    := '0';
                edt_Speed.Text      := '0';
              end;

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_NDS := aRec.ParamError;
      end;
    __STAT_SPS_TIU_PORT          :
      begin
        case aRec.ParamError of
          __PARAM_TIU_NORMAL      :
            begin
              pnlPortTIU.Color    := clLime;
              pnlPortTIU.Caption  := 'OP';
            end;
          __PARAM_TIU_FAULTY      :
            begin
              pnlPortTIU.Color    := clRed;
              pnlPortTIU.Caption  := 'INOP';

              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
          __PARAM_TIU_LOWVOLTAGE  :
            begin
              pnlPortTIU.Color    := clRed;
              pnlPortTIU.Caption  := 'INOP';

              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
          __PARAM_TIU_NOLINK      :
            begin
              pnlPortTIU.Color    := clRed;
              pnlPortTIU.Caption  := 'INOP';

              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_TIU_PORT := aRec.ParamError;
      end;
    __STAT_SPS_TIU_STARBOARD     :
      begin
        case aRec.ParamError of
          __PARAM_TIU_NORMAL      :
            begin
              pnlStbdTIU.Color    := clLime;
              pnlStbdTIU.Caption  := 'OP';
            end;
          __PARAM_TIU_FAULTY      :
            begin
              pnlStbdTIU.Color    := clRed;
              pnlStbdTIU.Caption  := 'INOP';

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
          __PARAM_TIU_LOWVOLTAGE  :
            begin
              pnlStbdTIU.Color    := clRed;
              pnlStbdTIU.Caption  := 'INOP';

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
          __PARAM_TIU_NOLINK      :
            begin
              pnlStbdTIU.Color    := clRed;
              pnlStbdTIU.Caption  := 'INOP';

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_TIU_STARBOARD := aRec.ParamError;
      end;
    __STAT_SPS_TEMP_PORT         :
      begin
        case aRec.ParamError of
          __PARAM_TEMP_NORMAL     :
            begin
              pnlPortTMP.Color   := clLime;
              pnlPortTMP.Caption := 'OK';
            end;
          __PARAM_TEMP_OVERHEAD   :
            begin
              pnlPortTMP.Color   := clRed;
              pnlPortTMP.Caption := 'OVR';

              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_TEMP_PORT := aRec.ParamError;
      end;
    __STAT_SPS_TEMP_STARBOARD    :
      begin
        case aRec.ParamError of
          __PARAM_TEMP_NORMAL     :
            begin
              pnlStbdTMP.Color   := clLime;
              pnlStbdTMP.Caption := 'OK';
            end;
          __PARAM_TEMP_OVERHEAD   :
            begin
              pnlStbdTMP.Color   := clRed;
              pnlStbdTMP.Caption := 'OVR';

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_TEMP_STARBOARD := aRec.ParamError;
      end;
    __STAT_SPS_45_DEG_PORT       :
      begin
        case aRec.ParamError of
          __PARAM_45_ON   :
            begin
              pnlPort45.Color   := clLime;
              pnlPort45.Caption := 'YES';
            end;
          __PARAM_45_OFF  :
            begin
              pnlPort45.Color   := clRed;
              pnlPort45.Caption := 'NO';

              if btn_BARREL2.Down = True then
              begin
                btn_BARREL2.Down := False;
                cbbBARREL2.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL4.Down = True then
              begin
                btn_BARREL4.Down := False;
                cbbBARREL4.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL6.Down = True then
              begin
                btn_BARREL6.Down := False;
                cbbBARREL6.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_45_DEG_PORT := aRec.ParamError;
      end;
    __STAT_SPS_45_DEG_STARBOARD  :
      begin
        case aRec.ParamError of
          __PARAM_45_ON   :
            begin
              pnlStbd45.Color   := clLime;
              pnlStbd45.Caption := 'YES';
            end;
          __PARAM_45_OFF  :
            begin
              pnlStbd45.Color   := clRed;
              pnlStbd45.Caption := 'NO';

              if btn_BARREL1.Down = True then
              begin
                btn_BARREL1.Down := False;
                cbbBARREL1.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL3.Down = True then
              begin
                btn_BARREL3.Down := False;
                cbbBARREL3.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end
              else
              if btn_BARREL5.Down = True then
              begin
                btn_BARREL5.Down := False;
                cbbBARREL5.Color := clAqua;
                edt_ITA.Text := '0';
                edt_Barrel.Text := 'NOT READY';
                edt_Gyro.Text := 'OFF';
                edt_Status.Text := 'DESELECTED';
                btn_V4.Caption := 'START GYRO';
                btn_V2.Caption := 'SELECT TGT';
                btn_V5.Caption := 'SELECT n';

                tmrLoadProgram.Enabled := False;
                s := data_path + '.\Images\SPS115\lampu indikator off.bmp';
                imgStanby.Picture.LoadFromFile(s);
              end;
            end;
        end;

        FStatusConsole.SPS_45_DEG_STARBOARD := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_1            :
      begin
        if (btn_BARREL1.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_1 := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_2            :
      begin
        if (btn_BARREL2.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_2 := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_3            :
      begin
        if (btn_BARREL3.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_3 := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_4            :
      begin
        if (btn_BARREL4.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_4 := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_5            :
      begin
        if (btn_BARREL5.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_5 := aRec.ParamError;
      end;
    __STAT_SPS_GYRO_6            :
      begin
        if (btn_BARREL6.Down) and (btn_V4.Caption = 'STOP GYRO') then
        begin
          case aRec.ParamError of
            __PARAM_GYRO_NORMAL        :
            begin
              edt_Gyro.Text := 'STEADY';
            end;
            __PARAM_GYRO_LONG_CAGING, __PARAM_GYRO_OVERLOAD,
            __PARAM_GYRO_LONG_STARTING, __PARAM_GYRO_NOLINK_TIU    :
            begin
              edt_Gyro.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_GYRO_6 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_1          :
      begin
        if btn_BARREL1.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_1 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_2          :
      begin
        if btn_BARREL2.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_2 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_3          :
      begin
        if btn_BARREL3.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_3 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_4          :
      begin
        if btn_BARREL4.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_4 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_5          :
      begin
        if btn_BARREL5.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_5 := aRec.ParamError;
      end;
    __STAT_SPS_BARREL_6          :
      begin
        if btn_BARREL6.Down then
        begin
          case aRec.ParamError of
            __PARAM_BARREL_NORMAL,__PARAM_BARREL_FIREERROR      :
            begin
              edt_Barrel.Text := 'READY';
            end;
            __PARAM_BARREL_UNTIMESTART,__PARAM_BARREL_NOREADY,
            __PARAM_BARREL_NOGYRO, __PARAM_BARREL_WRITINGTRP,
            __PARAM_BARREL_HEADERROR   :
            begin
              edt_Barrel.Text := 'ERROR';
              mmo_displayMSG.Lines.Add(GetStatusConsoleByParam(aRec.ErrorID, aRec.ParamError));
            end;
          end;
        end;

        FStatusConsole.SPS_BARREL_6 := aRec.ParamError;
      end;
    __STAT_SPS_SELFTEST          :
      begin
        case aRec.ParamError of
          __PARAM_SELFTEST_OK   : ;
          __PARAM_SELFTEST_FAIL : ;
        end;

        FStatusConsole.SPS_SELFTEST := aRec.ParamError;
      end;
    end;
  end;
end;

procedure TFrm_Main.OnReceiveTorpedoStatus(apRec: PAnsiChar; aSize: integer);
var
  aRec : ^TRecMissilePos;
begin

  aRec := @apRec^;

  if ( pShipID = aRec^.ShipID ) and
     ( aRec^.WeaponID = C_DBID_TORPEDO_A244S)
  then
  begin
    case aRec^.launcherID of
      1 :
      begin
        case aRec.missileID of
          1 : //missile 2
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL2.Down then
                begin
                  btn_BARREL2.Down := True;
                  cbbbARREL2.Color := clLime;
                  cbbBARREL2.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL2.Down := False;
                  cbbbARREL2.Color := clAqua;
                  cbbBARREL2.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN :
              begin
                if btn_BARREL2.Down then
                begin
                  cbbBARREL2.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL2.Color:= RGB(242, 119, 151);

                cbbBARREL2.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_2 := 8;
                
              end;
              ST_MISSILE_DEL :
              begin
                cbbBARREL2.ItemIndex := 4;
                cbbbARREL2.Color := RGB(242, 119, 151);
              end;
            end;
          end;

          2 : //missile 4
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL4.Down then
                begin
                  btn_BARREL4.Down := True;
                  cbbbARREL4.Color := clLime;
                  cbbBARREL4.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL4.Down := False;
                  cbbbARREL4.Color := clAqua;
                  cbbBARREL4.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN :
              begin
                if btn_BARREL4.Down then
                begin
                  cbbBARREL4.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL4.Color:= RGB(242, 119, 151);

                cbbBARREL4.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_4 := 8;
              end;
              ST_MISSILE_DEL :
              begin
                cbbBARREL4.ItemIndex := 4;
                cbbbARREL4.Color := RGB(242, 119, 151);
              end;
            end;
          end;

          3 : //missile 6
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL6.Down then
                begin
                  btn_BARREL6.Down := True;
                  cbbbARREL6.Color := clLime;
                  cbbBARREL6.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL6.Down := False;
                  cbbbARREL6.Color := clAqua;
                  cbbBARREL6.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN    :
              begin
                if btn_BARREL6.Down then
                begin
                  cbbBARREL6.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL6.Color:= RGB(242, 119, 151);

                cbbBARREL6.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_6 := 8;
              end;
              ST_MISSILE_DEL    :
              begin
                cbbBARREL6.ItemIndex := 4;
                cbbbARREL6.Color:= RGB(242, 119, 151);
              end;
            end;
          end;
        end;
      end;
  
      2 :
      begin
        case aRec^.missileID of
          1 : //missile 1
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL1.Down then
                begin
                  btn_BARREL1.Down := True;
                  cbbbARREL1.Color := clLime;
                  cbbBARREL1.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL1.Down := False;
                  cbbbARREL1.Color := clAqua;
                  cbbBARREL1.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN    :
              begin
                if btn_BARREL1.Down then
                begin
                  cbbBARREL1.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL1.Color:= RGB(242, 119, 151);

                cbbBARREL1.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_1 := 8;
              end;
              ST_MISSILE_DEL    :
              begin
                cbbBARREL1.ItemIndex := 4;
                cbbbARREL1.Color:= RGB(242, 119, 151);
              end;
            end;
          end;
  
          2 : //missile 3
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL3.Down then
                begin
                  btn_BARREL3.Down := True;
                  cbbbARREL3.Color := clLime;
                  cbbBARREL3.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL3.Down := False;
                  cbbbARREL3.Color := clAqua;
                  cbbBARREL3.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN    :
              begin
                if btn_BARREL3.Down then
                begin
                  cbbBARREL3.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL3.Color:= RGB(242, 119, 151);

                cbbBARREL3.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_3 := 8;
              end;
              ST_MISSILE_DEL    :
              begin
                cbbBARREL3.ItemIndex := 4;
                cbbbARREL3.Color:= RGB(242, 119, 151);
              end;
            end;
          end;

          3 : //missile 5
          begin
            case aRec^.status of
              ST_MISSILE_LOADED :
              begin
                if btn_BARREL5.Down then
                begin
                  btn_BARREL5.Down := True;
                  cbbbARREL5.Color := clLime;
                  cbbBARREL5.ItemIndex := 0;
                end
                else
                begin
                  btn_BARREL5.Down := False;
                  cbbbARREL5.Color := clAqua;
                  cbbBARREL5.ItemIndex := 0;
                end;
              end;
              ST_MISSILE_RUN    :
              begin
                if btn_BARREL5.Down then
                begin
                  cbbBARREL5.Color:= RGB(255, 10, 18);
                end
                else
                  cbbBARREL5.Color:= RGB(242, 119, 151);

                cbbBARREL5.ItemIndex := 3;
                FStatusConsole.SPS_BARREL_5 := 8;
              end;
              ST_MISSILE_DEL    :
              begin
                cbbBARREL5.ItemIndex := 4;
                cbbbARREL5.Color:= RGB(242, 119, 151);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrm_Main.pmNetSettingClick(Sender: TObject);
begin
  frmNetSetting.Show;
end;

procedure  TFrm_Main.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
var
  aRec: ^TRecData3DPosition;
  roll : Single;
  rollstr : string;
begin
  aRec := @apRec^;

  if (cbb_Mode.ItemIndex = 0) and (pnl_linkStat.Caption = 'OP') then
  begin
    if pShipID = aRec.ShipID then begin
      edt_Speed.text    := formatfloat('0', aRec.speed);
      edt_Heading.Text  := formatfloat('0', aRec.heading);
      roll              := aRec.roll;
      rollstr           := Formatfloat('0.0', roll);
      edtRoll.Text      := FloatToStrF(roll,ffGeneral,1,1);
    end;
  end;

  LastPosition := aRec^;

  //MHP
  CalcHitPoint(LastPosition);

  //tmrLastPost.Enabled := True;
end;

procedure TFrm_Main.SetPort(apRec: PAnsiChar; aSize: integer);
Var
  TIU_Port : TPanelPortStbd;
  ErrTIU_port : string;
begin
  CopyMemory(@TIU_Port, apRec, aSize);

  with TIU_Port do begin
    case TIU of
      TIU_OP : begin
        pnlPortTIU.Caption := 'OP';
        pnlPortTIU.Color   := clLime;
        ErrTIU_port        := '';
      end;

      TIU_Faulty : begin
        pnlPortTIU.Caption := 'INOP';
        pnlPortTIU.Color   := clRed;
        ErrTIU_port        := 'TIU Port Faulty';
      end;

      TIU_LowVoltage : begin
        pnlPortTIU.Caption := 'INOP';
        pnlPortTIU.Color   := clRed;
        ErrTIU_port        := 'TIU Port LowVoltage';
      end;

      TIU_NoLink : begin
        pnlPortTIU.Caption := 'INOP';
        pnlPortTIU.Color   := clRed;
        ErrTIU_port        := 'TIU Port NoLink';
      end;
    end;

    if _45Deg then begin
      pnlPort45.Caption    :='YES';
      pnlPort45.Color      := clLime;
    end
    else begin
      pnlPort45.Caption    :='NO';
      pnlPort45.Color      := clRed;
    end;

    if Temp >= max_TIUTemp then begin
      pnlPortTMP.Color   := clRed;
      pnlPortTMP.Caption := 'OVR';
    end
    else begin
      pnlPortTMP.Color   := clLime;
      pnlPortTMP.Caption := 'OK';
    end;
  end;
end;

procedure TFrm_Main.SetStbd(apRec: PAnsiChar; aSize: integer);
Var
  TIU_Stbd : TPanelPortStbd;
  ErrTIU_Stbd : string;

begin
  CopyMemory(@TIU_Stbd, apRec, aSize);

  with TIU_Stbd do begin
    case TIU of
      TIU_OP : begin
        pnlStbdTIU.Caption:='OP';
        pnlStbdTIU.Color  :=clLime;
        ErrTIU_Stbd :='';
      end;

      TIU_Faulty : begin
        pnlStbdTIU.Caption:='INOP';
        pnlStbdTIU.Color  :=clRed;
        ErrTIU_Stbd :='TIU Stbd Faulty';
      end;

      TIU_LowVoltage  : begin
        pnlStbdTIU.Caption:='INOP';
        pnlStbdTIU.Color  :=clRed;
        ErrTIU_Stbd :='TIU Stbd LowVoltage';
      end;

      TIU_NoLink :begin
        pnlStbdTIU.Caption:='INOP';
        pnlStbdTIU.Color  :=clRed;
        ErrTIU_Stbd :='TIU Stbd NoLink';
      end;
    end;

    if _45Deg then begin
      pnlStbd45.Caption    :='YES';
      pnlStbd45.Color      := clLime;
    end
    else begin
      pnlStbd45.Caption    :='NO';
      pnlStbd45.Color      := clRed;
    end;

    if Temp >= max_TIUTemp then begin
      pnlStbdTMP.Color   := clRed;
      pnlStbdTMP.Caption := 'OVR';
    end
    else begin
      pnlStbdTMP.Color   := clLime;
      pnlStbdTMP.Caption := 'OK';
    end;
  end;
end;

//========================================================================================
//Socket Added By Nando
procedure TFrm_Main.SetRecTorpedoDefaultEnv;
begin
  RecSendTorpedo.ShipID       := pShipID;

  RecSendTorpedo.mWeaponID      := C_DBID_TORPEDO_A244S;
  RecSendTorpedo.mLauncherID    := 0;
  RecSendTorpedo.mMissileID     := 0;
  RecSendTorpedo.mMissileNumber := 0;

  RecSendTorpedo.ISC          := 0;
  RecSendTorpedo.ACE          := 0;
  RecSendTorpedo.ISR          := 3600;
  RecSendTorpedo.CEI          := 10;
  RecSendTorpedo.FLO          := 60;
  RecSendTorpedo.ISD          := 40;
  RecSendTorpedo.WTR          := word(SH);
  RecSendTorpedo.PRG          := word(HE);
  RecSendTorpedo.DOP          := word(FM);
  RecSendTorpedo.ACM          := word(MIX);

  IsErrorState := False;
end;

procedure TFrm_Main.PrepareToLaunchTorpedo;
var
  LauncherID,
  MissileID  : Integer;

  spsISC : Double;
begin
  RecSendTorpedo.ShipID         := pShipID;

  RecSendTorpedo.mWeaponID      := C_DBID_TORPEDO_A244S;

  case CheckBarrelSelected of
    2,4,6 :
    begin
      RecSendTorpedo.mLauncherID := 1;
      LauncherID := 1;
    end;
    1,3,5 :
    begin
      RecSendTorpedo.mLauncherID := 2;
      LauncherID := 2;
    end;
  end;

  case CheckBarrelSelected of
    1,2 : MissileID  := 1;
    3,4 : MissileID  := 2;
    5,6 : MissileID  := 3;
  end;

  RecSendTorpedo.mMissileID     := MissileID;
  RecSendTorpedo.mMissileNumber := 1;

  if TryStrTofloat(edt_Isc.Text, spsISC) then
  begin
    spsISC                    := ValidateDegree(spsISC);
    RecSendTorpedo.ISC        := spsISC;
  end
  else
  begin
    RecSendTorpedo.ISC        := 0;
    IsErrorState              := True;
  end;

  RecSendTorpedo.ACE          := StrToInt(cbb_Ace.Text);
  RecSendTorpedo.ISR          := StrToInt(cbb_Isr.Text);
  RecSendTorpedo.CEI          := StrToInt(cbb_Cei.Text);
  RecSendTorpedo.FLO          := StrToInt(cbb_Flo.Text);
  RecSendTorpedo.ISD          := StrToInt(cbb_Isd.Text);
  RecSendTorpedo.WTR          := cbb_Wtr.ItemIndex + 1;
  RecSendTorpedo.PRG          := cbb_Prg.ItemIndex + 1;
  RecSendTorpedo.DOP          := cbb_Dop.ItemIndex;
  RecSendTorpedo.ACM          := cbb_Acm.ItemIndex;

  RecSendTorpedo.OrderID      := _ORD_SPS_FIRE;
end;

procedure TFrm_Main.rzchckbx_Tgt1Click(Sender: TObject);
begin
  TRzCheckBox(sender).Checked := False;
end;

procedure TFrm_Main.SendFireToController;
begin
  if (RecSendTorpedo.mLauncherID <> 0) and (RecSendTorpedo.mMissileID <> 0) and
     (not IsErrorState) then
  begin
    TheClient.sendDataEx(REC_SPSS_ORDER, @RecSendTorpedo)
  end;
end;

function TFrm_Main.GetStatusConsoleByParam(aId, aParam: integer): string;
begin
  case aId of
  __STAT_SPS_115V              :
    begin
      case aParam of
        __PARAM_115V_ON   : Result := 'ON';
        __PARAM_115V_OFF  : Result := 'OFF';
      end;
    end;
  __STAT_SPS_NDS               :
    begin
      case aParam of
        __PARAM_NDS_ON   : Result := 'ON';
        __PARAM_NDS_OFF  : Result := 'OFF';
      end;
    end;
  __STAT_SPS_TIU_PORT, __STAT_SPS_TIU_STARBOARD  :
    begin
      case aParam of
        __PARAM_TIU_NORMAL      : Result := 'NORMAL';
        __PARAM_TIU_FAULTY      : Result := 'FAULTY';
        __PARAM_TIU_LOWVOLTAGE  : Result := 'LOW VOLTAGE';
        __PARAM_TIU_NOLINK      : Result := 'NO LINK';
      end;
    end;
  __STAT_SPS_TEMP_PORT, __STAT_SPS_TEMP_STARBOARD         :
    begin
      case aParam of
        __PARAM_TEMP_NORMAL     : Result := 'NORMAL';
        __PARAM_TEMP_OVERHEAD   : Result := 'OVERHEAD';
      end;
    end;
  __STAT_SPS_45_DEG_PORT ,__STAT_SPS_45_DEG_STARBOARD      :
    begin
      case aParam of
        __PARAM_45_ON   : Result := 'ON';
        __PARAM_45_OFF  : Result := 'OFF';
      end;
    end;
  __STAT_SPS_GYRO_1, __STAT_SPS_GYRO_2, __STAT_SPS_GYRO_3,
  __STAT_SPS_GYRO_4, __STAT_SPS_GYRO_5, __STAT_SPS_GYRO_6 :
    begin
      case aParam of
        __PARAM_GYRO_NORMAL        : Result := '';      //'STEADY';
        __PARAM_GYRO_LONG_CAGING   : Result := IntToStr(aId-108) + '-1';   //'LONG CAGING';
        __PARAM_GYRO_OVERLOAD      : Result := IntToStr(aId-108) + '-2';   //'OVERLOAD';
        __PARAM_GYRO_LONG_STARTING : Result := IntToStr(aId-108) + '-4';   //'LONG STARTING';
        __PARAM_GYRO_NOLINK_TIU    : Result := IntToStr(aId-108) + '-5';   //'NO LINK WITH TIU';
      end;
    end;
  __STAT_SPS_BARREL_1, __STAT_SPS_BARREL_2, __STAT_SPS_BARREL_3,
  __STAT_SPS_BARREL_4, __STAT_SPS_BARREL_5, __STAT_SPS_BARREL_6  :
    begin
      case aParam of
        __PARAM_BARREL_NORMAL      : Result := ''; //'READY';
        __PARAM_BARREL_UNTIMESTART : Result := IntToStr(aId-114) + '-3';  //'UNTIME START';
        __PARAM_BARREL_NOREADY     : Result := IntToStr(aId-114) + '-5';  //'NO READY';
        __PARAM_BARREL_NOGYRO      : Result := IntToStr(aId-114) + '-6';  //'NO GYRO';
        __PARAM_BARREL_WRITINGTRP  : Result := IntToStr(aId-114) + '-7';  //'ERROR WRITING TORPEDO';
        __PARAM_BARREL_HEADERROR   : Result := IntToStr(aId-114) + '-8';  //'HEAD ERROR';
        __PARAM_BARREL_FIREERROR   : Result := ''; //'READY';             // Error Saat Mau Nembak
      end;
    end;
  __STAT_SPS_SELFTEST          :
    begin
      case aParam of
        __PARAM_SELFTEST_OK   : Result := 'OK';
        __PARAM_SELFTEST_FAIL : Result := 'FAIL';
      end;
    end;
  end;
end;

function TFrm_Main.GetTIULink: Boolean;
begin
   Result := True;

   if (btn_BARREL1.Down) or (btn_BARREL3.Down) or (btn_BARREL5.Down) then
   begin
     if FStatusConsole.SPS_TIU_STARBOARD = 0 then
        Result := True
     else
        Result := False;
   end
   else
   if (btn_BARREL2.Down) or (btn_BARREL4.Down) or (btn_BARREL6.Down) then
   begin
     if FStatusConsole.SPS_TIU_PORT = 0 then
        Result := True
     else
        Result := False;
   end;
end;

procedure TFrm_Main.ImgBackgroundClick(Sender: TObject);
begin
  ChnImgButton(PowerState, btn_H1, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H2, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H3, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H4, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H5, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H6, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_H7, vrstrnglst1.Strings[23]);
  ChnImgButton(PowerState, btn_V11, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_V12, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_V13, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_V14, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_V15, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_V16, vrstrnglst1.Strings[24]);
  ChnImgButton(PowerState, btn_Push0, vrstrnglst1.Strings[25]);
  ChnImgButton(PowerState, btn_Push1, vrstrnglst1.Strings[26]);
  ChnImgButton(PowerState, btn_Push2, vrstrnglst1.Strings[27]);
  ChnImgButton(PowerState, btn_Push3, vrstrnglst1.Strings[28]);
  ChnImgButton(PowerState, btn_Push4, vrstrnglst1.Strings[29]);
  ChnImgButton(PowerState, btn_Push5, vrstrnglst1.Strings[30]);
  ChnImgButton(PowerState, btn_Push6, vrstrnglst1.Strings[31]);
  ChnImgButton(PowerState, btn_Push7, vrstrnglst1.Strings[32]);
  ChnImgButton(PowerState, btn_Push8, vrstrnglst1.Strings[33]);
  ChnImgButton(PowerState, btn_Push9, vrstrnglst1.Strings[34]);
  ChnImgButton(PowerState, btn_PushPlusMin, vrstrnglst1.Strings[35]);
  ChnImgButton(PowerState, btn_Pushtitik, vrstrnglst1.Strings[36]);
  ChnImgButton(PowerState, btn_PushCLR, vrstrnglst1.Strings[37]);
  ChnImgButton(PowerState, btn_PushCHN, vrstrnglst1.Strings[38]);
  ChnImgButton(PowerState, btn_PushENT, vrstrnglst1.Strings[39]);
  ChnImgButton(PowerState, btn_PushTAB, vrstrnglst1.Strings[40]);
  ChnImgButton(PowerState, btn_PushUP, vrstrnglst1.Strings[41]);
  ChnImgButton(PowerState, btn_PushESC, vrstrnglst1.Strings[42]);
  ChnImgButton(PowerState, btn_PushLEFT, vrstrnglst1.Strings[43]);
  ChnImgButton(PowerState, btn_PushDOWN, vrstrnglst1.Strings[44]);
  ChnImgButton(PowerState, btn_PushRIGHT, vrstrnglst1.Strings[45]);
end;

procedure TFrm_Main.mniLogMemo1Click(Sender: TObject);
begin
  frmLogMemo.Show;
end;

{ TStatusConsoleSPS }

constructor TStatusConsoleSPS.create;
begin
  //Normal Value
  ROLL                  := 1;
  SPS_115V              := 1;
  SPS_NDS               := 1;
  SPS_TIU_PORT          := 0;
  SPS_TIU_STARBOARD     := 0;
  SPS_TEMP_PORT         := 1;
  SPS_TEMP_STARBOARD    := 1;
  SPS_45_DEG_PORT       := 1;
  SPS_45_DEG_STARBOARD  := 1;
  SPS_GYRO_1            := 1;
  SPS_GYRO_2            := 1;
  SPS_GYRO_3            := 1;
  SPS_GYRO_4            := 1;
  SPS_GYRO_5            := 1;
  SPS_GYRO_6            := 1;
  SPS_BARREL_1          := 1;
  SPS_BARREL_2          := 1;
  SPS_BARREL_3          := 1;
  SPS_BARREL_4          := 1;
  SPS_BARREL_5          := 1;
  SPS_BARREL_6          := 1;
  SPS_SELFTEST          := 1;
end;

destructor TStatusConsoleSPS.destroy;
begin
  inherited;
end;

function TStatusConsoleSPS.isErrorInFire(BarrelID : integer):Boolean;
begin
  Result := False;

  case BarrelID of
    1 : begin
          if SPS_BARREL_1 = 7 then
            Result := True
          else
            Result := False;
        end;
    2 : begin
          if SPS_BARREL_2 = 7 then
            Result := True
          else
            Result := False;
        end;
    3 : begin
          if SPS_BARREL_3 = 7 then
            Result := True
          else
            Result := False;
        end;
    4 : begin
          if SPS_BARREL_4 = 7 then
            Result := True
          else
            Result := False;
        end;
    5 : begin
          if SPS_BARREL_5 = 7 then
            Result := True
          else
            Result := False;
        end;
    6 : begin
          if SPS_BARREL_6 = 7 then
            Result := True
          else
            Result := False;
        end;
  end;
end;

function TStatusConsoleSPS.isReadyToFire(BarrelID : integer):Boolean;
begin
  Result := False;

  case BarrelID of
    //NO BARREL SELECTED
    0 : Result := False;

    //STARBOARD
    1 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_STARBOARD = 0)                    and
              (SPS_TEMP_STARBOARD = 1)                   and
              (SPS_45_DEG_STARBOARD = 1)                 and
              (SPS_GYRO_1  = 1)                          and
              ((SPS_BARREL_1 = 1) or (SPS_BARREL_1 = 7))
          then
            Result := True
          else
            Result := False;
        end;
    3 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_STARBOARD = 0)                    and
              (SPS_TEMP_STARBOARD = 1)                   and
              (SPS_45_DEG_STARBOARD = 1)                 and
              (SPS_GYRO_3  = 1)                          and
              ((SPS_BARREL_3 = 1) or (SPS_BARREL_3 = 7))
          then
            Result := True
          else
            Result := False;
        end;
    5 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_STARBOARD = 0)                    and
              (SPS_TEMP_STARBOARD = 1)                   and
              (SPS_45_DEG_STARBOARD = 1)                 and
              (SPS_GYRO_5  = 1)                          and
              ((SPS_BARREL_5 = 1) or (SPS_BARREL_5 = 7))
          then
            Result := True
          else
            Result := False;
        end;

    //PORT
    2 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_PORT = 0)                         and
              (SPS_TEMP_PORT = 1)                        and
              (SPS_45_DEG_PORT = 1)                      and
              (SPS_GYRO_2  = 1)                          and
              ((SPS_BARREL_2 = 1) or (SPS_BARREL_2 = 7))
          then
            Result := True
          else
            Result := False;
        end;
    4 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_PORT = 0)                         and
              (SPS_TEMP_PORT = 1)                        and
              (SPS_45_DEG_PORT = 1)                      and
              (SPS_GYRO_4  = 1)                          and
              ((SPS_BARREL_4 = 1) or (SPS_BARREL_4 = 7))
          then
            Result := True
          else
            Result := False;
        end;
    6 : begin
          if
              (ROLL = 1)                                 and
              (SPS_115V = 1)                             and
              (SPS_SELFTEST = 1)                         and
              (SPS_TIU_PORT = 0)                         and
              (SPS_TEMP_PORT = 1)                        and
              (SPS_45_DEG_PORT = 1)                      and
              (SPS_GYRO_6  = 1)                          and
              ((SPS_BARREL_6 = 1) or (SPS_BARREL_6 = 7))
          then
            Result := True
          else
            Result := False;
        end;
  end;
end;

end.
