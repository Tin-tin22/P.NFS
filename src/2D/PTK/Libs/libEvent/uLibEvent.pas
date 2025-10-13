unit uLibEvent;

interface

uses  uNetwork_Data_TCMS, Windows;

type

   TOnMainFormEvent = procedure (aValue : Boolean) of Object;
   TOnDecoyStateChange = procedure (const btnTag: Integer; var TubeNr, DcyTypeName: string) of object;

  TOnDecoyNewLaunchQueueTube = procedure (const TTF_Sec, TTF1, TTF2, TTF3, TTF4: string;
                                          const CrsMaintain, FireImmediately: Boolean
                                         ) of object;
  TOnDecoyFireExec = procedure (TimeNowUtc: TTime; SigmaHdg: Double) of object;

//  TOnGetActiveRole = procedure (var AnActiveRole: TRoleType) of object;

  // WinMsg events
  TOnMsgSendDataMovement = procedure (DataObj: TRec_Data_Movement) of object;
  TOnMsgHndSendData = procedure (copyDataStruct: TCopyDataStruct) of object;

  TOnUpdateLirodData = procedure (aHeading, aElevation: DOuble) of object;


  TOnSonarDetectTrack = procedure (aSonarType : Byte; Sender: TObject) of object;
  TOnSonarDetect = procedure (Value: Integer;aSensor : TObject; aTrack : TObject; aValue : boolean) of object;

  TOnVigileDetect = procedure (aSensor : TObject; aTrack: TObject; ESM_TN: string; ESM_SYS_TN: string; EsmDataReq: TESM_DataReq; aValue: boolean) of object;

  TOnSensorDetect = procedure (aSensor : TObject; aTrack : TObject; aValue : boolean) of object;
  TOnSenarCMSUpdate = procedure (aSensor : TObject) of object;
  TOnSonarUpdateTrack = procedure (aMsg : TRec_Sonar_Sync) of object;
  TOnWeaponHit    = procedure (aWeapon : TObject; aTrack : TObject; aValue : integer) of object;
  TOnWeaponLaunch = procedure (aWeapon : TObject; aTrack : TObject) of object;
  TOnWeaponTargetChange = procedure (aWeapon : TObject; aTrack : TObject) of object;

  TOnPdkFire76 = procedure(aBallisTicID, aOrdID : Integer; aModeId : Integer; aElev, aBearing : Double) of object;


  TEventAddWaypoint = procedure (Long,Lat : double) of object;
  TEventToolMapUsed = procedure (ASender: TObject; ToolNum: Smallint;
            X1, Y1, X2, Y2, Distance: double; Shift, Ctrl: WordBool;
            var EnableDefault: WordBool) of object;

  TOnSubsurfaceDetect = procedure (aObj : TObject; State : Boolean) of object;
  TTorpedoAlert = procedure (aObj : TObject; State : Boolean) of object;

  TOnSendFire76       = procedure (aBallisTicID, aOrdID : Integer; aModeId : Integer; aElev, aBearing : Double) of object;
  TOnAutoDesigTetral  = procedure (aObj : TObject; aLauncerID : integer) of object;

  TOnSplashBullet     =  procedure (aObj : TObject; gunConn : Integer) of object;

  TOnSetString        = procedure (aStr : string) of object;
  TOnIndex            = procedure (aIdx : integer) of object;

  TOnUpdateAdviceTgt = procedure(objID: string) of object;


  {Mail icha}
  TOnReceiveMail = procedure (aString : string) of Object;
  TOnResMail    = procedure (aString : string) of Object;

  {EMCON}
  TOnExpiredPlan1 = procedure (aString : string) of object;
  TOnStartPlan1   = procedure (aString : string) of object;

  TOnExpiredPlan2 = procedure (aString : string) of object;
  TOnStartPlan2   = procedure (aString : string) of object;

  {All service active}
  TOnEmconMw08    = procedure (aString : string) of object;
  TOnEmconLirod   = procedure (aString : string) of object;
  TOnEmconECM     = procedure (aString : string) of object;
  TOnEmconKingklip  = procedure (aString : string) of object;

  TOnEmconWarningActive  = procedure (aString : string) of object;
  TOnEmconWarningExpired = procedure (aString : string) of object;


  TOnAreaAlertActive = procedure (aString : string) of object;


  TOnTsmcStateChange = procedure(Segment, State : Integer) of object;

  TOnChangeState = procedure(aValue: Integer) of object;

  TOnCreatePAC = procedure (aID: string; Sender: TObject) of object;
  TOnSetSalvo = procedure(aValue: Integer; aTrNr: string) of object;

  TGunOnHit = procedure (Sender : TObject;aPosX, aPosY : Double)of object;

  TOnRoleChange         = procedure(IDRole, IDUser: Integer; Status: Boolean) of object;
  TOnLibraryChange      = procedure(Lib : Integer; Status : boolean) of object;
  TOnCreateICM          = procedure(RoleSend, RoleRecv: Integer; PosX, PosY: Double) of object;
  TOnDesigtExocet       = procedure(ObjectID, TargetID: Integer) of object;
  TOnBreakExocet        = procedure(ObjectID, TargetID: Integer) of object;
  TOnSetWpnAndSnsrState = procedure(ParentID, DeviceID: Integer; State: Byte) of object;
  TOnFire76             = procedure(apRec: PAnsiChar; OrdID: Byte) of object;
  TOnSyncData           = procedure(apRec: PAnsiChar) of object;
  TOnSyncSonar          = procedure(aRec: TRec_Sonar_Sync) of object;
  TOnSyncScenario       = procedure(apRec: PAnsiChar) of object;
  TOnUpdateDecoyLaunchQueue = procedure(apRec: PAnsiChar; OrdID: Byte) of object;
  TOnUpdateDecoyFiringQueue = procedure(apRec: PAnsiChar; OrdID: Byte) of object;
  TOnDecoyFiring        = procedure(apRec: PAnsiChar; OrdID: Byte) of object;

  TOnLoadWeapon = procedure (str : string; Parent : TObject) of object;
  TOnDataAvailable = procedure (aRec : TRec_Object_Data) of object;

  TOnSendChannelSetting = procedure (Value1, Value2, Value3 : Byte) of object;
  TOnSendSet3DPlayer = procedure (Value1, Value2: Integer;Value3: Double) of object;



implementation

end.
