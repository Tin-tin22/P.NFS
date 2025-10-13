unit uLibTDCClass;

interface

uses
  MapXLib_TLB,Classes, Windows, Graphics, Forms,   uMapWindow, uLabelDisplay,
  uBaseConstan, uBaseDataType, uTestShip, uLibRadar, uDetected, uLibTDCDisplay,
  uBaseSimulationObject, uLibTDCTracks, uTorpedoTrack,  ufLog, uObjectView,
  uLibTDC_Object,

  uTDCConstan, uTCPClient, uTCPDataType;

const
  C_Kanan = ' kanan';
  C_Kiri  = ' kiri';

type

//  TCursorOrigin_Status = ( stCU_OR_OFFCENT, stCU_OR_CENT );
//  TCenter_Status = (stCENT, stOFFCENT);

  //==============================================================================
  TTDC_Symbol =  class(TCharSymbol)
  public
    mPos      : t2DPoint;  // map position
    Selected  : Boolean;
    Moved     : Boolean;

    constructor Create;
  end;

//==============================================================================

//==============================================================================
  TICM_Symbol = class(TTDC_Symbol)
  public
    icmNum: byte;
    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;

//==============================================================================

  TFireControl = class
  public
    Name: String;
    IsTracking      : boolean;
    TrackedTarget   : TManualTrack;
    LastTrackedTarget: TManualTrack;
    //HasEcho: boolean;
    HasGun          : boolean;
    GenFix          : boolean;
    ThrowOff        : boolean;
    TargetUID       : String;
    IsDoingBlindBomb  : boolean;
    IsDoingIndBomb    : boolean;

    Detected    : TDetectedObject;

    constructor Create;
    destructor Destroy; override;
  end;

  TTorpData = record
    BarrelID  : byte;
    ISD       : Single;
    Floor     : Single;
    GyroRunOut: boolean;
  end;

//==============================================================================
  TCursorTrackConnection = class
  public
    esbTrack : TESMBearingTrack;
    mTrack   : TManualTrack;
  end;

  TRCounter = record
    Count    : byte;
    Capacity : byte;
  end;

  TSysLoad = array[ TTrackDomain ] of TRCounter;

// data di inject dari MIK
  TTDCDataGeneral = class
  private

    FOffsetTime : TDateTime;
    FTrueWind   : tVect2D;

    function GetLocalTime: TDateTime;
    procedure SetLocalTime(const Value: TDateTime);
  published  //lot+
    property LocalTime: TDateTime read GetLocalTime write SetLocalTime;

  public
    //weather
    //REW+
//    RelWind    : tVect2D;
   //CUR+ ,
    SeaCurrent : tVect2D;

    //DRO+ -
    DeadReconEnable : boolean;
    DeadReconPos    : t2DPoint;
    //PTR+ asrock
    PowderTemp    : single;
    //TID+
    DelayTime : byte;
    // link page       : byte;
    // link call number: string[5];

    constructor Create;
    function getTrueWind(const dShipCourse, dShip: double): tVect2D;
  end;

  TTDCDataStationing  = record
    //sta+ -
    Starting : boolean;
    //sts+
    Duration : word; // menit;
    // sts+ stm+
    Movement : tVect2D;
  end;

  TTDCData_Vectac = record
    Starting :  boolean;
    //TAS+
    TrueAirSpeed  : double;
    MagneticVariation : double;
    BallisticCorrection : byte;
  end;
//==============================================================================

//==============================================================================
  TGenericTDCInterface = class
  protected
    FTrueMotion: boolean;
    FTrackIndex,
    FTrackIndex_AtasAir,
    FTrackIndex_Udara  : integer;
    //FTrackIndex_BawahAir

    selTrack, SelTrack_AtasAir, SelTrack_Udara, SelTrack_BawahAir: TManualTrack;

    cTrack  : TTDCTrack;
    mTrack  : TManualTrack;
    dtTrack : TDatumTrack;
    esbTrack: TESMBearingTrack;
    ptTrack : TPointTrack;
    snTrack : TManualTrack;

    ltid : array [tdAtasAir .. tdDatum] of byte;

    FMainSymbolVisible : boolean;
    FCourseVisible     : boolean;
    FAMPLInfoVisible   : boolean;
    FLINKVisible       : boolean;
    FTrackNumberVisible: boolean;

    CConnect : TCursorTrackConnection;
    FCConnList       : TList;

    FCorrelationBoxRange : double; //nm

    procedure SetTrueMotion(const Value: boolean);

    function ConvertToScreen(const dx, dy: double): TPoint;
    function ConvertToMap(const ix, iy: integer): t2DPoint;

    procedure AddGameLog(s: string);

  public
    //Object yg akan dikendalikanTDC
    // - titipan - .
    FMap              : TMap;
    xSHIP             : TXShip;
    ActiveRadar       : TClientRadar;
    netSend           : TTCPClient;
    HaveToSend        : boolean;   // := GameplayMode = pmModeClient
    LastUpdateCounter : LongWord;   // MainGameTimer.Millisecond;
    TDCNumber         : integer;
    // - end of titipan -.

    frmTengah: TfrmMapWindow;

    procedure ShowAllForm; virtual;
    procedure CreateFormss(const num: byte); virtual; abstract;
    procedure SetDefaultLayOut; virtual;
    procedure ShowFormBawahOWA; virtual;
    procedure HideFormBawahOWA; virtual;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertViewPosition;  virtual;
    procedure Draw(aCnv : TCanvas); virtual;

    procedure Run(aDt: double);                virtual;
    procedure Update;  // update before draw;
    procedure Walk;   virtual;  // walk is slower than run.

    procedure Initialize; virtual;

    function FindMarkerByPositionXY (const sx , sy: Integer): integer;
    function FindMarkerByPosition(const pt: TPoint): integer;
//    function FindTrack_by_screenpos(const x,y: integer; var aMtrack: tManualTrack): boolean;
    function FindTrack_by_screenpos(const x,y: integer; var aTrack: TTDCTrack): boolean;
    function IsHitTrack(const pt: TPoint): boolean;

    function FindTrack_by_trackID(const aShiptid, aTrackNum: byte;
        var aMtrack: tManualTrack): boolean;

    function FindTDCTrack_by_trackID(const aShiptid, aTrackNum: byte;
        var aTrack: tTDCTrack): boolean;

    procedure CreateDefaultMTrack(var mt: TManualTrack; const x, y: double);
    function InitMTrackIdent(var mt: TManualTrack;
                             const initid: char): boolean;
    function ChangeMTrackIdent(var mt: TManualTrack;
                               const newid: char): boolean;
    procedure DeleteMTrack(var trck: TManualTrack);  virtual;

  public // interface to forms
    // == from obejct View
    FOCView   : tFOCView;

    // from TDCDisplay
    // Main Display related procedure.
    DisplaySymbols  : array [i_min_marker .. i_max_marker] of TTDC_Symbol;
    SelectedMarkerTool : integer;

    OBMLeft  : TTDC_Symbol;
    OBMRight : TTDC_Symbol;

    ICMLeft, ICMRight : TICM_Symbol;

    HeadingMarker : THeadingMarker;
    CentStatus    : TCenter_Status;

    CU_ORStatus   : TCursorOrigin_Status;
    Cursorss      : TTDC_Cursor;        // always exist cursor;


    assssm     : TAssignSSMView;
    ssmTrack   : TManualTrack;
    ssmSendUpdate : boolean;
    ssmUpdateCounter: Double;

    AssTorpedo : TAssignTorpedoView;

    trackTorped : TTorpedoTrack;      // the torpedo
    TorpedoList : TObjectContainer;  // container of the Torpedo

    BlindArcs : TBlindARCS;
    BlindArcsAsw : TBlindARCSAsw;

    LPDTest   : TLPDTest;
    FC4Cursor: THeadingMarker;

    LPDText   : TLPDDisplayText;

    TrackList   : TObjectContainer;  // container of TManualTrack
    shipt_tid   : byte;
    FTDCRangeScale : double;
    GunNumber   : integer;
    SelectedThreatAsses : integer;
    shipID,
    shipClassID : integer;

    SystLoad :  TSysLoad;
    BKTSurface, BKTSubSurface : TRCounter;

    // data nala
    tdcData  : TTDCDataGeneral;
    SGO      : TSurfaceGrid;
    VecData  : TTDCData_Vectac;
    MyShipName : string;

//  -- Main Display --
    procedure SetView_RangeScale(const aRangeNM: double);         // TDC Range Scale

    procedure SetRadar_Amplification(const aRa: TRadar_Amp);
    procedure SetRadar_MTI_Status(const aOnOff: boolean);
    procedure SetRadar_type(const aRT: TRadar_Type);

    procedure SetRadar_RangeRing(const aOnOff: boolean);
    procedure SetRadar_HeadingMarker(const aOnOff: boolean);

    procedure CU_OR_Left_SetStatus(const aCCStatus: TCursorOrigin_Status);
    procedure CU_OR_Right_SetStatus(const aCCStatus: TCursorOrigin_Status);

    procedure CentLeft_SetStatus(const aCCStatus: TCenter_Status);
    procedure CentRight_SetStatus(const aCCStatus: TCenter_Status);

    procedure OBMLeft_Reset;
    procedure OBMRight_Reset;

    procedure SetThreadAssesmentDuration(const aSecond: integer);
    procedure SetThreadAsses(const v: boolean; const x, y: integer);

//  Display simbol
    procedure OwnShipMarker_SetPosition(const x, y: double);

    procedure OBMLeft_SetPosition(const x, y: integer);
    procedure OBMRight_SetPosition(const x, y: integer);

    procedure CursorSetRange(const r: double);
    procedure CursorSetBearing(const b: double);

    procedure SetBlindARC(const v: boolean);
    procedure SetBlindARCASW(const v: boolean);

    procedure SetLPDTest(const v: boolean);

    //QEK Common
    procedure WipeOnPosition(const X, Y: integer);
    procedure WipeOnLeftOBM;
    procedure WipeOnRightOBM;
    procedure RecvWIPE(aRec: TRecOrderXY);
    procedure SendWIPE(const X,Y: double);

    //QEK_1_Kiri Interface  for Bawah Air
    //noloop
    procedure SetInitDatum(aRec: TRecOrderXY;
      const send: boolean=TRUE );

    procedure setFOCPlus(aRec: TRecOrderXY; const send: boolean= TRUE);
    procedure setFOCMinus(aRec: TRecOrderXY; const send: boolean= TRUE);

    procedure setAssignASRL(aRec: TRecTrackOrder; Msltype : Word; const send: boolean= TRUE); Virtual;
    procedure setDeAssignASRL(aRec: TRecTrackOrder; const send: boolean= TRUE); virtual;
    procedure SetFireAsroc(aRec: TRecTrackOrder; IDLauncher :integer; mMissileID : word; RocketType : Byte;  IsSalvo : boolean; const send:boolean= TRUE); virtual;  // Added by Bagus   8-11
//    procedure GetCurrentDataTrackASRL(var getHeading :Single; var getRange, getBearing : double); virtual;


    // --- ident;
    procedure Recv_Ident(aRec : TRecTrackOrder);
    procedure Recv_Ident_OWA(aRec : TRecTrackOrder);
   {procedure three in one}
    procedure Change_Ident( aRec : TRecTrackOrder;
      const send: boolean= TRUE );

    //init RAM untuk Atas Air & udara
    procedure initiateTrackPacket(var aRec : TRecTrackOrder; var td: TTrackDomain);
    procedure InitiateRAM(aRec : TRecTrackOrder; const send: boolean=TRUE);
    procedure InitiateAuto(aRec : TRecTrackOrder; const send: boolean=TRUE);
    procedure InitiateDR(aRec : TRecTrackOrder; const send: boolean=TRUE);

    procedure AssignRAM(aRec: TRecTrackOrder; const send: boolean=TRUE);
    procedure RecvAssignRAM(aRec: TRecTrackOrder);

    procedure AssignDR(aRec: TRecTrackOrder; const send: boolean=TRUE);
    procedure AssignAuto(aRec: TRecTrackOrder; const send: boolean=TRUE);

    procedure CorrectRAM(aDomain : TTrackDomain; const send:boolean= TRUE);
    procedure CloseControl(aDomain : TTrackDomain);

    //procedure Assign RAM
    procedure SetOBMRightPos_NextTrack_AtasAir;
    procedure SetOBMRightPos_NextTrack_Udara;   // tombol nya kok ga ada?

    procedure SetOBMPos_NextTrack;   // all track, for rencong

    procedure SetInitESMFix(
      aRec: TRecOrderXY;
      const send: boolean= TRUE );

    procedure setAssignSSM(aRec: TRecOrderXY; send: boolean); virtual;
    procedure SendUpdateSSM();

    procedure setDeAssignSSM(send: boolean); virtual;

    procedure SetAssignTorpedo_MK44(aRec: TRecTrackOrder;
        const send: boolean = TRUE);
    procedure SetDeAssignTorpedo(const send: boolean = TRUE);

    procedure SetMainSymbolVisible(const aVis: boolean);
    procedure SetCourseVisible(const aVis: boolean);
    procedure SetAMPLInfoVisible(const aVis: boolean);
    procedure SetLINKVisible(const aVis: boolean);
    procedure SetTrackNumberVisible(const aVis: boolean);

    procedure Filter(const atd: TTrackDomain; const aVis: boolean); overload;
    procedure Filter(const atd: TTrackDomain; const org: TTrackOrigin_OWA; const aVis: boolean); overload;

    function SetAssign_FC(const aNum: byte; const pt: TPoint; const send:boolean= true): boolean;

    function SetDeAssign_FC(const aNum: byte; const send:boolean= true): boolean;  // BreakTrack

    procedure RecvAssign_FC(aRec: TRecFireControlOrder);
    procedure RecvDeAssign_FC(aRec: TRecFireControlOrder);

    procedure RecvAssign_GenFiX(aRec: TRecFireControlOrder);
    procedure RecvAssign_BlindBomb(aRec: TRecFireControlOrder);

    procedure SetOpenFire_FC(const aNum: byte; const send:boolean= true);
    procedure SetHoldFire_FC(const aNum: byte; const send:boolean= true);

    function CreateCursorFix(var nESMB: TESMBearingTrack): boolean;
    procedure AddCursorFix; // lokal aja.
    function DelCursorFix(const pt: TPoint): boolean;

    procedure AddCursorFixToTrack(const sid, tnum: byte);

    procedure StartICMLeft(const icmNum: byte; const x,y: double; const send:boolean= true);
    procedure EndICMLeft(const icmNum: byte; const send:boolean= true);

    procedure StartICMRight(const icmNum: byte; const x,y: double; const send:boolean= true);
    procedure EndICMRight(const icmNum: byte; const send:boolean= true);
    procedure UpdateICMPos(const icmNum: byte; const x, y: double);

    procedure AssignTrackToDetected(const sid, tn: byte; const dUid: string);

    procedure RecvUpdateTrackPosition(aRec: TRecTrackOrder);

//    procedure LaunchTorpedoTo(const X, Y: double);
    procedure LaunchTorpedoTo(const sid, tn: byte);
    function DeleteTorpedoPHP(const pt: TPoint): boolean;
    procedure UpdateTorpedoPosition;

    procedure SetLPDText(const v: boolean; s1:string=''; s2: string='');

    procedure DataRequest(const b: byte); virtual;

    procedure DataRequest_Left(const b: byte); virtual; abstract;
    procedure DataRequest_Right(const b: byte); virtual;abstract;

    procedure DR_OBM_right(const b: Boolean); virtual; abstract;
    procedure DR_OBM_left(const b: Boolean); virtual; abstract;
    procedure DR_OCM_right; virtual;                 abstract;
    procedure DR_OCM_left; virtual;                 abstract;

    procedure SetBackTracking(const v: boolean; var mTrack : TManualTrack);
    procedure SetBackTrackOnPos(const v: boolean; const x, y: integer;
     const send: boolean= true);

    procedure SetDeadRecon(const v: boolean; const x, y: double);

    procedure RecvHarpoonSetting(aRec: TRecHarpoonPanelSetting); virtual;
    procedure SetHarpoonEngage(aRec: TRecTrackOrder; send: boolean; tag: byte=0); virtual;
//    procedure SendUpdateHarpoon(const tMode: TEngageStatus);virtual;

    procedure RecvASRLSetting(aRec: TRecStatus_Console); virtual;


  // wcc gigih
  public
    FC1, FC2, FC3, FC4, FC5: TFireControl;
    FC_Chanel : array[1..8] of TFireControl;
    ThrowOff_Marker: TTDC_Symbol;

    // ring dimmer
    function FindToBeDeletedTrack(var IsNew: boolean; var indx: Integer): boolean;
    function DeleteTrack(const tFCID: byte): boolean;

    procedure OCC_AssignFC(aRec : TRecOrderAssignment);
    procedure OCC_DeassignFC(aRec : TRecOrderAssignment);

    function GetLastTrackID(td: TTrackDomain): byte;
    procedure SetLastTrackID(const td: TTrackDomain; const newLtid: byte);

    function InitiateDATUM(var dtm: TDatumTrack; const x, y: double): boolean;

    function InitiateESMFix(const x, y: double; const tid: byte): boolean;
    function InitiateRefPos(const x, y: double; const tid: byte): boolean;

    function initiateSurfaceGrid(const x, y: double): boolean;

    procedure setRelatifWind(const rCourse, rSpeed: double);
    function GetRealtiveWind : tVect2D;
    function GetTrueWind : tVect2D;

    function GetTorpedoTrack(var v : TTorpedoTrack): boolean;

    function InitiateTrack(const aCom: TOrdType_OWA_command; const OBM: TTDC_Symbol): boolean;
    procedure RecvInitiateTrack(aRec: TRecXXXOrder);
    function AssignLocRT(aRec: TRecXXXOrder; const send: boolean= True): boolean;
    function AssignLocNRT(aRec: TRecXXXOrder; const send: boolean= True): boolean;
    function AssignRemote(aRec: TRecXXXOrder; const send: boolean= True): boolean;

    procedure ReviewFriend_OWA(const aVal: boolean);

    procedure SendLink_OWA(OBM: TTDC_Symbol; const IsSending: boolean);
    procedure RecvLink_OWA(aRec: TRecLinkOrder);

    procedure SwitchTrackPosition(OBM: TTDC_Symbol; const send: boolean= True);
    procedure RecvChangeTrackPos(aRec : TRecGunControl);

    procedure SetInitPoint(aRec: TRecOrderXY; const send: boolean=TRUE );
    function InitiatePoint(var ptt: TPointTrack; var td: TTrackDomain; const x, y: double): boolean;

    procedure SetOBM_NextTrack_OWA(OBM: TTDC_Symbol);
    procedure SetTrackInLostMode(aRec: TRecFireControlOrder; const send: boolean= True);
    procedure GetCourseSpeedSubTrack(OBM: TTDC_Symbol; var c, s: double);

    procedure CorrelateOrDecorelateTrack(OBM: TTDC_Symbol; const send: boolean= True);
    procedure RecvCorrelateTrack(aRec : TRecGunControl);
    procedure RecvDecorrelateTrack(aRec : TRecGunControl);

    procedure CorrectRAM_OWA(OBM: TTDC_Symbol; const send:boolean= TRUE); //sama, cuma parameternya aj yg diganti
    procedure RePos_OWA(OBM: TTDC_Symbol; const send:boolean= TRUE);
    procedure CloseControl_OWA(const pt: TPoint);

    procedure RecvUpdateTrackPos_Owa(aRec: TRecTrackOrder);

    procedure TestSonar;
    procedure RecvSonarPositionData_OWA(aRec: TRecTrackOrder);

    procedure LaunchTorpedo_OWA(const aDt: TTorpData);

    procedure Update_Exocet_Position(const cID: integer; const x, y, heading: double);

  published

    property TrueMotion : boolean read FTrueMotion write SetTrueMotion;

  end;



implementation

uses
  SysUtils, Types, uSimulationManager,
  uBaseFunction, uBaseGraphicProc, uFormUtil, {ufTDCTengah,}
  StrUtils, uTrackFunction, Math, uRadarTracks, Dialogs;

//const
//  c_space32 = '                                ';

//==============================================================================
{ TOBM_Cursor }

constructor  TTDC_SYMBOL.Create;
begin
  FontName := 'TDCCursor';
  Color := C_defColor;
end;


//==============================================================================
{ TICMSymbol }
constructor TICM_Symbol.Create;
begin
  inherited;
  Size   := 10;
  icmNum := 0;
end;

procedure TICM_Symbol.Draw(aCnv: TCanvas);
var sz: TSize;
begin
  inherited;
  if not Visible then exit;
  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;
    sz :=  TextExtent(CharSymbol);
    //aligned center
    Font.Size  :=  8;
    TextOut((Offset.x + Center.X - sz.cx shr 1 ) + 10,
            (Offset.y + Center.y - sz.cy shr 1 ) ,
            IntToStr(icmNum));
  end;

end;

//==============================================================================
constructor TFireControl.Create;
begin
  inherited;
  TrackedTarget := nil;
  LastTrackedTarget := nil;
  ThrowOff := false;
  GenFix          := false;
  IsDoingBlindBomb  := false;
  IsDoingIndBomb    := false;
end;

destructor TFireControl.Destroy;
begin
  inherited;
end;
//==============================================================================
{ TGenericTDCInterface }

constructor TGenericTDCInterface.Create;
var i: integer;
begin

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i] := TTDC_Symbol.Create;
    DisplaySymbols[i].CharSymbol := C_Symbol_Char[i];
  end;

  DisplaySymbols[i_OwnShip].Visible := TRUE;

  DisplaySymbols[i_OBM_Kiri].Visible := TRUE;
  OBMLeft := DisplaySymbols[i_OBM_kiri];  // alias

  DisplaySymbols[i_OBM_kanan].Visible := TRUE;
  OBMRight := DisplaySymbols[i_OBM_kanan];  // alias

  HeadingMarker := THeadingMarker.Create;
  HeadingMarker.Visible := false;

  Cursorss := TTDC_Cursor.Create;
  Cursorss.Distance := 32;
  Cursorss.Heading := 000;

  Cursorss.Visible := TRUE;
  CU_ORStatus := stCU_OR_CENT;

  TrackList :=  TObjectContainer.Create;

  ltid[tdAtasAir]   := 0;
  ltid[tdBawahAir]  := 0;
  ltid[tdUdara]     := 0;
  ltid[tdEW]        := 0;
  ltid[tdDontCare]  := 0;
  ltid[tdDatum]     := 0;

  FTrackIndex := 0;
  FTrackIndex_AtasAir := 0;
  FTrackIndex_Udara:= 0;
  SelTrack    := nil;
  SelTrack_AtasAir    := nil;
  SelTrack_Udara      := nil;
  SelTrack_BawahAir   := nil;

  assssm := TAssignSSMView.Create;
  assssm.Enabled := FALSE;
  assssm.Visible := FALSE;
  ssmTrack   :=  nil;
  ssmSendUpdate := false;
  ssmUpdateCounter:= 0.0;

  AssTorpedo := TAssignTorpedoView.Create;
  AssTorpedo.Range := C_Yard_To_NauticalMiles * 1000.0;

  TorpedoList := TObjectContainer.Create;

  {BlindArcs := TBlindARCS.Create(GunNumber);
  BlindArcs.Distance := 128;
  BlindArcs.Enabled := true;}

  FMainSymbolVisible := TRUE;
  FCourseVisible     := TRUE;
  FAMPLInfoVisible   := TRUE;
  FLINKVisible       := FALSE;
  FTrackNumberVisible:= TRUE;

  LPDTest   := TLPDTest.Create;

  ICMRight := TICM_Symbol.Create;
  ICMRight.CharSymbol := C_Symbol_Char[i_ICM_sender];
  ICMRight.icmNum := 0;

  ICMLeft := TICM_Symbol.Create;
  ICMLeft.CharSymbol := C_Symbol_Char[i_ICM_sender];
  ICMLeft.icmNum := 0; // inactive

  FC1 := TFireControl.Create;
  FC1.Name := 'FC1';

  FC2 := TFireControl.Create;
  FC2.Name := 'FC2';
  FC3 := TFireControl.Create;
  FC3.Name := 'FC3';
  FC4 := TFireControl.Create;
  FC4.Name := 'FC4';
  FC5 := TFireControl.Create;
  FC5.Name := 'FC5';

  FC_Chanel[1] := FC1 ;
  FC_Chanel[2] := FC2 ;
  FC_Chanel[3] := FC3 ;
  FC_Chanel[4] := FC4 ;
  FC_Chanel[5] := FC5 ;


  FC4Cursor := THeadingMarker.Create;
  FC4Cursor.Visible := false;

  LPDText   := TLPDDisplayText.Create;

  FCConnList       := TList.Create;;
  SelectedThreatAsses := 15 * 60;

  SystLoad[tdAtasAir   ].Capacity   := 6;
  SystLoad[tdUdara     ].Capacity   := 6;
  SystLoad[tdBawahAir  ].Capacity   := 2;
  SystLoad[tdEW        ].Capacity   := 4;  //esm fix
  //SystLoad[tdDontCare].Capacity   := 4;
  SystLoad[tdDatum     ].Capacity   := 4;
  SystLoad[tdRP        ].Capacity   := 2;
  SystLoad[tdCursor    ].Capacity   := 8;

  //buat OWA
  SystLoad[tdPointGen    ].Capacity   := 6;
  SystLoad[tdPointEW     ].Capacity   := 6;
  SystLoad[tdPointAir    ].Capacity   := 6;

  BKTSurface.Capacity     := 2;
  BKTSubSurface.Capacity  := 1;

  tdcData := TTDCDataGeneral.Create;

{  HarpoonEngageBox := TEngagementBox.Create;
  HarpoonEngageBox.Enabled := FALSE;
  HarpoonEngageBox.Visible := FALSE;
  engTrack   :=  nil;
  engSendUpdate := false;
  engUpdateCounter:= 0.0;
}
  DisplaySymbols[i_ThrowOff].Visible := TRUE;
  ThrowOff_Marker := DisplaySymbols[i_ThrowOff];  // alias
  ThrowOff_Marker.Visible := false;

  FCorrelationBoxRange := 2;
end;

destructor TGenericTDCInterface.Destroy;
var i: integer;
begin
  tdcData.Free;

  ClearListAndObject(FCConnList);

  FreeAndNil(FC1);
  FreeAndNil(FC2);
  FreeAndNil(FC3);
  FreeAndNil(FC4);
  FreeAndNil(FC5);


  TorpedoList.ClearObject;
  TorpedoList.Free;

  TrackList.ClearObject;
  TrackList.Free;

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i].Free;
    DisplaySymbols[i] := nil;
  end;

  HeadingMarker.Free;
  Cursorss.Free;

  assssm.Free;

  AssTorpedo.Free;
  BlindArcs.Free;
  BlindArcsAsw.Free;
  LPDTest.Free;
  LPDText.Free;

  inherited;
end;

procedure TGenericTDCInterface.ConvertViewPosition;
begin
  ConvertMembersViewsPosition(TrackList);
  ConvertMembersViewsPosition(TorpedoList);

  OBMLeft.Center  := ConvertToScreen(OBMLeft.mPos.X, OBMLeft.mPos.Y);
  OBMRight.Center := ConvertToScreen(OBMRight.mPos.X, OBMRight.mPos.Y);

  assssm.ConvertCoord(FMap);
  Cursorss.ConvertCoord(FMap);

  HeadingMarker.ConvertCoord(FMap);
  FC4Cursor.ConvertCoord(FMap);

end;

procedure TGenericTDCInterface.Draw(aCnv : TCanvas);
var i: integer;
begin

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i].Draw(aCnv);
  end;

  HeadingMarker.Draw(aCnv);

  Cursorss.Draw(aCnv);

  DrawMembersView(TrackList, aCnv);
  DrawMembersView(TorpedoList, aCnv);

  assssm.Draw(aCnv);

//  ESMFixs.Draw(aCnv);

  if AssTorpedo.Enabled then begin
    AssTorpedo.ConvertCoord(FMap);
    AssTorpedo.Draw(aCnv);
  end;

  if assigned(BlindArcs) and BlindArcs.Visible then begin
    BlindArcs.ConvertCoord(FMap);
    BlindArcs.Draw(aCnv);
  end;

  if Assigned(BlindArcsAsw) and BlindArcsAsw.Visible then
  begin
    BlindArcsAsw.ConvertCoord(FMap);
    BlindArcsAsw.Draw(aCnv);
  end;

  LPDTest.Draw(aCnv);

  if ICMleft.Visible then begin
    ICMleft.Center := ConvertToScreen(ICMleft.mPos.X, ICMleft.mPos.Y);
    ICMleft.Draw(aCnv);
  end;

  if ICMRight.Visible then begin
    ICMRight.Center := ConvertToScreen(ICMRight.mPos.X, ICMRight.mPos.Y);
    ICMRight.Draw(aCnv);
  end;

  FC4Cursor.Draw(aCnv);

  LPDText.Draw(aCnv);

end;

procedure TGenericTDCInterface.Run(aDt: double);
var ptShip: t2DPoint;
begin

  ptShip.X := xShip.PositionX;
  ptShip.Y := xShip.PositionY;

  HeadingMarker.Org := ptShip;

  HeadingMarker.Distance := FTDCRangeScale;

  HeadingMarker.Heading  := xShip.Heading;

  TrackList.RunAllMemberObject(aDt);

  UpdateTorpedoPosition;
  TorpedoList.RunAllMemberObject(aDt);

  if NOT assssm.Enabled then begin
    assssm.Org := ptShip;

    if ssmTrack <> nil then begin
      assssm.Direction := CalcBearing(assssm.Org.X, assssm.Org.Y,
       ssmTrack.PositionX, ssmTrack.PositionY);
    end;

    if ssmSendUpdate then begin
      ssmUpdateCounter := ssmUpdateCounter + aDt;

      if (ssmUpdateCounter > 1000.0) then begin
        ssmUpdateCounter  := ssmUpdateCounter - 1000.0;
        SendUpdateSSM();
      end
    end
  end;

  if AssTorpedo.Enabled then begin
    AssTorpedo.Direction := xSHIP.Heading;
    AssTorpedo.Org := ptShip;
  end;

  if BlindArcs.Enabled then begin
    BlindArcs.Org := ptShip;
    BlindArcs.Distance := 128;
    BlindArcs.Heading := xSHIP.Heading;
  end;

  if BlindArcsAsw.Enabled then
  begin
    BlindArcsAsw.Org := ptShip;
    BlindArcsAsw.Distance := 128;
    BlindArcsAsw.Heading := xSHIP.Heading;
  end;

  if FC4.Detected <> nil then begin
    FC4Cursor.Heading := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
       FC4.Detected.PositionX, FC4.Detected.PositionY);
  end;

  if not tdcData.DeadReconEnable then begin
    tdcData.DeadReconPos.X := xSHIP.PositionX;
    tdcData.DeadReconPos.Y := xSHIP.PositionY;
  end;

end;

procedure TGenericTDCInterface.Update;
begin

  TrackList.UpdateAllMemberObject;
  TorpedoList.UpdateAllMemberObject;

end;

procedure TGenericTDCInterface.Walk;    // walk is slower than run.
var i: integer;
    c: TCursorTrackConnection;
begin
  if FCConnList.Count > 0 then begin
    for i := 0 to FCConnList.Count-1 do begin
      c := FCConnList.Items[i];
      if (c.esbTrack <> nil) and Assigned(c.mTrack) then begin
           c.esbTrack.SetEndCoord(mTrack.PositionX, c.mTrack.PositionY);
      end
    end;
  end;
end;

procedure TGenericTDCInterface.Initialize;
begin
  OBMLeft_SetPosition( frmTengah.Map.Width shr 2 , frmTengah.Map.Height shr 1);
  OBMRight_SetPosition( frmTengah.Map.Width -  (frmTengah.Map.Width shr 2) -80, frmTengah.Map.Height shr 1);

  Cursorss.SetStartCoord(xSHIP.PositionX, xSHIP.PositionY);
  Cursorss.Distance := 32;
  Cursorss.Heading  := 000;

  BlindArcs := TBlindARCS.Create(GunNumber);
  BlindArcs.Heading  := 000;
  BlindArcs.Distance := 128;
  BlindArcs.Enabled := true;

  BlindArcsAsw := TBlindARCSAsw.Create(GunNumber);
  BlindArcsAsw.Heading  := 000;
  BlindArcsAsw.Distance := 128;
  BlindArcsAsw.Enabled := true;
end;

function TGenericTDCInterface.ConvertToScreen(const dx, dy: double): TPoint;
var mx, my : double;
    sx, sy : single;
begin
  mx := dx;
  my := dy;
  FMap.ConvertCoord(sx, sy, mx, my, miMapToScreen);
  result.X := Round(sx);
  result.Y := Round(sy);
end;

function TGenericTDCInterface.ConvertToMap(const ix, iy: integer): t2DPoint;
var mx, my : double;
    sx, sy : single;
begin
  sx := ix;
  sy := iy;

  FMap.ConvertCoord(sx, sy, mx, my, miScreenToMap);
  result.X := mx;
  result.Y := my;
end;


procedure TGenericTDCInterface.ShowAllForm;
begin
  if Assigned( frmTengah       ) then frmTengah       .Show;
{  if Assigned( frmKanan        ) then frmKanan        .Show;
  if Assigned( frmKeyBoardKanan) then frmKeyBoardKanan.Show;
  if Assigned( frmKiri         ) then frmKiri         .Show;
  if Assigned( frmKeyboardKiri ) then frmKeyboardKiri .Show;
}
end;


procedure TGenericTDCInterface.SetDefaultLayOut;
begin

{  case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, frmKeyboardKiri);
      AlignFormToMonitor(0, apRightTop , 0, 0, frmKeyboardKanan);
      AlignFormToMonitor(0, apLeftBottom  , 0 ,-20, frmKiri);
      AlignFormToMonitor(0, apRightBottom , 0 ,-20, frmKanan);
    end;
    2 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, frmKeyboardKiri);
      AlignFormToMonitor(0, apRightBottom , 0, 0, frmKeyboardKanan);
      AlignFormToMonitor(0, apLeftBottom   , 0, -20, frmKiri);
      AlignFormToMonitor(0, apRightTop     , 0,   0, frmKanan);

    end;
    3 : begin
      AlignFormToMonitor(0, apRightTop  , 0, 0, frmKeyboardKiri);
      AlignFormToMonitor(2, apLeftTop , 0, 0, frmKeyboardKanan);

      AlignFormToMonitor(0, apRightBottom  , 0, 0, frmKiri);
      AlignFormToMonitor(2, apLeftBottom   , 0, 0, frmKanan);
    end;
  end;
}
end;
procedure TGenericTDCInterface.ShowFormBawahOWA;
begin
end;

procedure TGenericTDCInterface.HideFormBawahOWA;
begin
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TGenericTDCInterface.SetView_RangeScale(const aRangeNM: double);
begin
  FMap.MapUnit := miUnitNauticalMile;
  FMap.Zoom := 2* aRangeNM;
  ActiveRadar.PolarView.RangeInterval := (0.25 * aRangeNM);
  ActiveRadar.PolarView.RangeMax := 128;
  FTDCRangeScale := aRangeNM;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TGenericTDCInterface.SetRadar_type(const aRT: TRadar_Type);
begin
  ActiveRadar.FRadarType := aRT;
  case aRT of
    rtDA_05 : begin
      ActiveRadar.DetectionRange := 128;
      ActiveRadar.TimeBase.RotationSpeed := 10;
//      ActiveRadar.TimeBaseView.SweepWidth := 200;
      ActiveRadar.TimeBaseView.SweepWidth := 750;
//      ActiveRadar.TimeBaseView.Darkness := 120;
      ActiveRadar.TimeBaseView.Darkness := 160;

    end;
    rtWM_28 : begin
      ActiveRadar.DetectionRange := 32;
      ActiveRadar.TimeBase.RotationSpeed := 60;
      ActiveRadar.TimeBaseView.SweepWidth := 1500; //1000;
      ActiveRadar.TimeBaseView.Darkness := 165;  //160
    end;
    rtLW_03 : begin
      ActiveRadar.DetectionRange := 256;
      ActiveRadar.TimeBase.RotationSpeed := 5;
      ActiveRadar.TimeBaseView.SweepWidth := 1000;
      ActiveRadar.TimeBaseView.Darkness := 100;
    end;
    rtDECCA_1229 : begin
      ActiveRadar.DetectionRange := 16;
      ActiveRadar.TimeBase.RotationSpeed := 60;
      ActiveRadar.TimeBaseView.SweepWidth := 1000;
      ActiveRadar.TimeBaseView.Darkness := 100;
    end;
    // tes iqbal
    tes_Radar : begin
      ActiveRadar.DetectionRange := 128;
      ActiveRadar.TimeBase.RotationSpeed := 10;
      ActiveRadar.TimeBaseView.SweepWidth := 200;
      ActiveRadar.TimeBaseView.Darkness := 120;
    end;
  end;
end;

procedure TGenericTDCInterface.SetRadar_Amplification(
  const aRa: TRadar_Amp);
begin
  // ActiveRadar.
  // TDCSimCenter.ActiveRadar.
end;

procedure TGenericTDCInterface.SetRadar_MTI_Status(const aOnOff: boolean);
begin
  ActiveRadar.MTI_ON := aOnOff;
end;

procedure TGenericTDCInterface.SetRadar_RangeRing(const aOnOff: boolean);
begin
  ActiveRadar.PolarView.Visible := aOnOff;
end;

procedure TGenericTDCInterface.SetRadar_HeadingMarker(
  const aOnOff: boolean);
begin
  HeadingMarker.Visible := aOnOff;
end;

procedure TGenericTDCInterface.CU_OR_Left_SetStatus(
  const aCCStatus: TCursorOrigin_Status);
begin
  CU_ORStatus := aCCStatus;
  case aCCStatus of
    stCU_OR_OFFCENT : begin
         Cursorss.SetStartCoord(OBMLeft.mPos.X, OBMLeft.mPos.Y);
    end;
    stCU_OR_CENT    :  begin
      Cursorss.SetStartCoord(xShip.PositionX, xShip.PositionY);
   end;
  end;

end;

procedure TGenericTDCInterface.CU_OR_Right_SetStatus(
    const aCCStatus: TCursorOrigin_Status);
begin
  CU_ORStatus := aCCStatus;
  case aCCStatus of
    stCU_OR_OFFCENT : begin
         Cursorss.SetStartCoord(OBMRight.mPos.X, OBMRight.mPos.Y);

    end;
    stCU_OR_CENT    :  begin

      Cursorss.SetStartCoord(xShip.PositionX, xShip.PositionY);
    end;
  end;

end;

procedure TGenericTDCInterface.CentLeft_SetStatus(const aCCStatus: TCenter_Status);
var r, b, x, y: double;
begin
  CentStatus :=  aCCStatus;
  case aCCStatus of
    stCENT          : begin
      FMap.CenterX := xShip.PositionX;
      FMap.CenterY := xShip.PositionY;
    end;
    stOFFCENT       : begin
      r := CalcRange(FMap.CenterX, FMap.CenterY, OBMLeft.mPos.X, OBMLeft.mPos.Y);
      b := CalcBearing(FMap.CenterX, FMap.CenterY, OBMLeft.mPos.X, OBMLeft.mPos.Y);
      RangeBearingToCoord(r, b, x, y);

      FMap.CenterX := OBMLeft.mPos.X;
      FMap.CenterY := OBMLeft.mPos.Y;

      x := FMap.CenterX + x * C_NauticalMile_To_Degree;
      y := FMap.CenterY + y * C_NauticalMile_To_Degree;

      OBMLeft.mPos.X  := x;
      OBMLeft.mPos.Y  := y;
      OBMLeft.Center  := ConvertToScreen(OBMLeft.mPos.X, OBMLeft.mPos.Y)
    end;
  end;
end;

procedure TGenericTDCInterface.CentRight_SetStatus(const aCCStatus: TCenter_Status);
var r, b, x, y: double;
begin
  CentStatus :=  aCCStatus;
  case aCCStatus of
    stCENT          : begin
      FMap.CenterX := xShip.PositionX;
      FMap.CenterY := xShip.PositionY;
    end;
    stOFFCENT       : begin
      r := CalcRange(FMap.CenterX, FMap.CenterY, OBMRight.mPos.X, OBMRight.mPos.Y);
      b := CalcBearing(FMap.CenterX, FMap.CenterY, OBMRight.mPos.X, OBMRight.mPos.Y);
      RangeBearingToCoord(r, b, x, y);

      FMap.CenterX := OBMRight.mPos.X;
      FMap.CenterY := OBMRight.mPos.Y;

      x := FMap.CenterX + x * C_NauticalMile_To_Degree;
      y := FMap.CenterY + y * C_NauticalMile_To_Degree;

      OBMRight.mPos.X  := x;
      OBMRight.mPos.Y  := y;
      OBMRight.Center  := ConvertToScreen(OBMRight.mPos.X, OBMRight.mPos.Y)
    end;
  end;
end;


procedure TGenericTDCInterface.SetTrueMotion(const Value: boolean);
begin
  FTrueMotion := Value;
end;

procedure TGenericTDCInterface.SetThreadAssesmentDuration(const aSecond: integer);
var i : integer;
    list: TList;
begin
  SelectedThreatAsses := aSecond;
  list := TrackList.GetList;

  for i := 0 to list.Count-1 do begin
    cTrack := list.Items[i];
    if cTrack is TManualTrack then begin
       mTrack := (cTrack as  TManualTrack);
       if mTrack.ThreatAssestVisible then
          mTrack.SetThreadAssesment(aSecond);
    end
  end;

  TrackList.ReturnList;
end;


procedure TGenericTDCInterface.SetThreadAsses(const v: boolean; const x, y: integer);
var findTrack: boolean;
begin  //

  findTrack := FindTrack_by_ScreenPos(X, Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin

    (cTrack as TManualTrack).SetThreadAssesment(SelectedThreatAsses);
    (cTrack as TManualTrack).ThreatAssestVisible := v;
  end;
end;

function TGenericTDCInterface.FindMarkerByPositionXY (const sx , sy: Integer): integer;
const sz = 4;
var found : boolean;
    r : TRect;
    pt: TPoint ;
begin
  result := i_OBM_kanan;
  found := false;
  pt.X := sx ;
  pt.Y := sy ;
  while not found  and ( result <= i_OBM_kiri ) do begin
    r := PtToRect(DisplaySymbols[result].Center, sz, sz);
    found := PtInRect(r, pt);
    inc(result);
  end;
  if found then
    dec(result)

  else
    result := -1;
end;

function TGenericTDCInterface.FindMarkerByPosition(const pt: TPoint): integer;
const sz = 4;
var found : boolean;
    r : TRect;
begin
  result := i_OBM_kanan;
  found := false;
  while not found  and ( result <= i_OBM_kiri ) do begin
    r := PtToRect(DisplaySymbols[result].Center, sz, sz);
    found := PtInRect(r, pt);
    inc(result);
  end;
  if found then
    dec(result)

  else
    result := -1;
end;

function TGenericTDCInterface.FindTrack_by_screenpos(const x,y: integer;
    var aTrack: TTDCTrack): boolean;

//function TGenericTDCInterface.FindTrack_by_ScreenPos(const x,y: integer;
//  var aMtrack: tManualTrack): boolean;
var i : integer;
    list: TList;
begin
  list := TrackList.GetList;

  if Assigned(frmLog) then frmLog.AddLog('TrackList count : ' + IntToStr(list.Count));

  i := list.Count-1;
  result := false;
  while not result and (i>=0) do begin
    aTrack := list.Items[i];
    result  := aTrack.TestViewHit(x, y);
    dec(i);
  end;

  TrackList.ReturnList;
end;


function TGenericTDCInterface.IsHitTrack(const pt: TPoint): boolean;
var aMtrack: tManualTrack;
    i : integer;
    list: TList;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := false;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    result  := aMtrack.TestViewHit(pt.x, pt.y);
    dec(i);
  end;

  TrackList.ReturnList;
end;

function TGenericTDCInterface.FindTrack_by_trackID(const aShiptid, aTrackNum: byte;
        var aMtrack: tManualTrack): boolean;

var i: integer;
    list: TList;
    ct : TTDCTrack;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := FALSE;
  while not result and (i>=0) do begin
    ct := list.Items[i];
    if ct is TManualTrack then begin
      aMtrack := cT as TManualTrack;
      result := (aMtrack.ShipTrackId = aShiptid)
        and (aMtrack.TrackNumber = aTrackNum);
    end;
    dec(i);
  end;
  TrackList.ReturnList;

  if not Result then
    amTrack := nil;
end;

function TGenericTDCInterface.FindTDCTrack_by_trackID(const aShiptid, aTrackNum: byte;
        var aTrack: tTDCTrack): boolean;
var i: integer;
    list: TList;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := FALSE;
  while not result and (i>=0) do begin
    aTrack := list.Items[i];
    result := (aTrack.ShipTrackId = aShiptid)
        and (aTrack.TrackNumber = aTrackNum);
    dec(i);
  end;
  TrackList.ReturnList;

  if not Result then aTrack := nil;
end;

procedure TGenericTDCInterface.CreateDefaultMTrack(var mt: TManualTrack; const x, y: double);
// Creating Track: step 1 of 2.
begin
  mt := TManualTrack.Create;

  mt.SetPosition(X, Y);
  mT.CreateDefaultView(FMap);

  mT.MainSymbolVisible    := FMainSymbolVisible;
  mT.CourseVisible        := FCourseVisible;
  mT.AmpliInfoVisible     := FAMPLInfoVisible;
  mT.LINKVisible          := FLINKVisible;
  mT.TrackNumberVisible   := FTrackNumberVisible;

//  mT.Enabled := TRUE;
//  mT.LastUpdateTime := LastUpdateCounter;
//  TrackList.AddObject(mT);
end;

function TGenericTDCInterface.InitMTrackIdent(var mt: TManualTrack;
                                              const initid: char): boolean;
// Creating Track: step 2 of 2.
var td : TTrackDomain;
begin
   td := GetTrackDomainFromIDENT(initid);
   result := false;

  if td in [tdAtasAir, tdUdara, tdBawahAir] then begin
    if SystLoad[td].Count < SystLoad[td].Capacity then begin
      SystLoad[td].Count := SystLoad[td].Count + 1;
      result := true;
    end;
  end;

  if result then begin
    mt.SetIdent(initid);
    mt.Domain := td;

    // ga sekalian set track number??

    mT.Enabled := TRUE;
    mT.LastUpdateTime := LastUpdateCounter;
    TrackList.AddObject(mT);
  end
  else begin // tiada tempat bagimu!
    mt.Free;
    mt := nil;
    AddGameLog('Tidak boleh. Hapus track yg ada dulu.');
  end;
end;

function TGenericTDCInterface.ChangeMTrackIdent(var mt: TManualTrack;
  const newid: char): boolean;
var tdOld, tdNew : tTrackDomain;
begin
  // bisa di ganti jika domainnya sama.
  tdOld := GetTrackDomainFromIDENT(mt.GetIdent);
  tdNew := GetTrackDomainFromIDENT(newID);
  result := false;

  if (tdOld <> tdDontCare)  and (tdOld <> tdNew) then begin
    AddGameLog('Tidak boleh. Domain harus sama ' );
    exit;
  end;

  case newID of
    ID_AtasAir_Helicopter :
      if (mT.GetIdent = ID_AtasAir_Friendly) then begin
        mt.SetIdent(newID);
        result := TRUE;
      end;

    ID_Rudal : begin
      if (mTrack.GetIdent = ID_Udara_Friendly) then begin
        mt.SetIdent(newID);
        result := TRUE;
      end
    end
    else begin
        mt.SetIdent(newID);
        result := TRUE;
    end;
  end;
end;

procedure TGenericTDCInterface.DeleteMTrack(var trck: TManualTrack);
var i: integer;
   td : TTrackdomain;
begin
  td := GetTrackDomainFromIDENT(trck.GetIdent);

  if td in [tdAtasAir, tdUdara, tdBawahAir] then begin
    if SystLoad[td].Count > 0 then
     SystLoad[td].Count := SystLoad[td].Count - 1;
  end;

  trck.MarkAs_NeedToBeFree;
  trck.Relation := nil;
  for i := FCConnList.Count-1 downto 0 do begin
    CConnect := FCConnList[i];

    if CConnect.mTrack = trck then begin
      FCConnList.Delete(i);
      CConnect.Free;
    end;
   end;

  if trck = ssmTrack then ssmTrack := nil;

  if trck = FC1.TrackedTarget then begin
    FC1.TrackedTarget := nil;
    FC1.IsTracking := false;
  end;

  if trck = FC2.TrackedTarget then  begin
    FC2.TrackedTarget := nil;
    FC2.IsTracking := false;
  end;
  if trck = FC3.TrackedTarget then begin
    FC3.TrackedTarget := nil;
    FC3.IsTracking := false;
  end;

  if trck = FC4.TrackedTarget then begin
    FC4.TrackedTarget := nil;
    FC4.IsTracking := false;
  end;

  if trck = FC5.TrackedTarget then begin
    FC5.TrackedTarget := nil;
    FC5.IsTracking := false;
  end;


end;


//=============================================================================
procedure TGenericTDCInterface.OwnShipMarker_SetPosition(const x, y: double);
begin
  DisplaySymbols[i_OwnShip].mPos.X := X;
  DisplaySymbols[i_OwnShip].mPos.Y := Y;

  DisplaySymbols[i_OwnShip].Center := ConvertToScreen(x, y);
end;

procedure TGenericTDCInterface.OBMLeft_SetPosition(const x, y: integer);
var aRec: TRecOrderXY;
    DPT : t2DPoint;
begin
  DisplaySymbols[i_OBM_kiri].Center.X := x;
  DisplaySymbols[i_OBM_kiri].Center.Y := y;
  DisplaySymbols[i_OBM_kiri].mPos := ConvertToMap(x, y);

  aRec.OrderID := OrdID_update_ICM;
  aRec.ShipID := xSHIP.UniqueID;
  aRec.X := OBMLeft.mPos.X;
  aRec.Y := OBMLeft.mPos.Y;
   dpt := OBMLeft.mPos;

  if ICMLeft.Moved then begin
    ICMLeft.mPos :=  dpt;

    aRec.OrderID   := OrdID_update_ICM;
    aRec.OrderType := ICMLeft.icmNum;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;

end;

procedure TGenericTDCInterface.OBMRight_SetPosition(const x, y: integer);
var aRec: TRecOrderXY;
    dpt : t2DPoint;
begin
  DisplaySymbols[i_OBM_kanan].Center.X := x;
  DisplaySymbols[i_OBM_kanan].Center.Y := y;
  DisplaySymbols[i_OBM_kanan].mPos := ConvertToMap(x, y);

  aRec.OrderID := OrdID_update_ICM;
  aRec.ShipID := xSHIP.UniqueID;
  aRec.X := OBMRight.mPos.X;
  aRec.Y := OBMRight.mPos.Y;
  dpt := OBMRight.mPos;

  if ICMRight.Moved then begin
    ICMRight.mPos :=  dpt;

    aRec.OrderID   := OrdID_update_ICM;
    aRec.OrderType := ICMRight.icmNum;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;
end;

procedure TGenericTDCInterface.OBMLeft_Reset;
begin
  DisplaySymbols[i_OBM_kiri].mPos.X  := xShip.PositionX;
  DisplaySymbols[i_OBM_kiri].mPos.Y  := xShip.PositionY;
  DisplaySymbols[i_OBM_kiri].Center :=
    ConvertToScreen(DisplaySymbols[i_OBM_kiri].mPos.X,
                    DisplaySymbols[i_OBM_kiri].mPos.Y)
end;

procedure TGenericTDCInterface.OBMRight_Reset;
begin
  DisplaySymbols[i_OBM_kanan].mPos.X  := xShip.PositionX;
  DisplaySymbols[i_OBM_kanan].mPos.Y  := xShip.PositionY;
  DisplaySymbols[i_OBM_kanan].Center :=
    ConvertToScreen(DisplaySymbols[i_OBM_kanan].mPos.X,
                    DisplaySymbols[i_OBM_kanan].mPos.Y)
end;

procedure TGenericTDCInterface.CursorSetRange(const r: double);
begin
  Cursorss.Distance := r;
end;

procedure TGenericTDCInterface.CursorSetBearing(const b: double);
begin
  Cursorss.Heading := b;
end;

procedure TGenericTDCInterface.SetInitDatum(aRec: TRecOrderXY;
  const send: boolean=TRUE );
begin  //QEK_1_KIRI

  if Send then begin
    aRec.OrderID    := OrdID_init_datum;
    aRec.OrderType  := GetLastTrackID(tdDatum);                 // RESERVED FOR DATUM NUMBER;
    aRec.ShipID := xSHIP.UniqueID;

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec );
  end
  else begin
    if InitiateDATUM(dtTrack, aRec.X, aRec.Y) then begin
       dtTrack.SetTrackNumber(shipt_tid, aRec.OrderType);
    end;
  end;
end;

procedure TGenericTDCInterface.setFOCPlus(aRec: TRecOrderXY; const send: boolean= TRUE);
var findObj: boolean;
   pt : TPoint;
begin
  if send then begin
    aRec.ShipID := xSHIP.UniqueID;
    aRec.OrderID := OrdID_FOC_plus;
    aRec.OrderType := 1; //reserve datum number;

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec );
  end
  else begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
    if findObj and (cTrack is TDatumTrack) then begin
      dtTrack := (cTrack as TDatumTrack);
      if not Assigned(FOCView) then begin
        FOCView := TFOCView.CreateOnMapX(dtTrack, FMap);
        FOCView.Visible :=  true;
      end;
      FOCView.FDistance := 0;
      dtTrack.SetFOC(FOCView);
      dtTrack.Speed := 10;
      dtTrack.Enabled := true;

    end;

{    FOC.Enabled := TRUE;
    FOC.SpeedKnot :=   FOC.SpeedKnot + 5;
    if FOC.SpeedKnot > 30 then FOC.SpeedKnot := 30;
}  end;
end;

procedure TGenericTDCInterface.setFOCMinus(aRec: TRecOrderXY; const send: boolean= TRUE);
var findObj: boolean;
    pt : TPoint;
begin
  if send then begin
    aRec.ShipID := xSHIP.UniqueID;
    aRec.OrderID := OrdID_FOC_minus;
    aRec.OrderType := 1; //reserve datum number;

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec );
  end
  else begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
    if findObj and (cTrack is TDatumTrack) then begin
      dtTrack := (cTrack as TDatumTrack);
      dtTrack.DelFOC;
    end;
  end;
end;

procedure TGenericTDCInterface.setAssignASRL(aRec: TRecTrackOrder; Msltype : Word; const send: boolean= TRUE);
//procedure TGenericTDCInterface.setAssignASRL
//    (aRec: TRecTrackOrder; const send: boolean= TRUE);
var findObj   : boolean;
    detObj    : TDetectedObject;
    pt        : TPoint;
    thePacket : TRecOrderAssignment; // send to asroc
    r, b      : double;
    Rec3DSetAsrock  : TRec3DSetAsrock; // tambahan buta dikirim ke 3D
begin

  pt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if Assigned(frmLog) then
  begin
    if (cTrack = nil) then frmLog.AddLog('cTrack is Null')
    else
    if (cTrack <> nil) then
    begin
      frmLog.AddLog('cTrack not Null');
      if cTrack is TManualTrack then
        frmLog.AddLog('cTrack is ManualTrack')
      else if cTrack is TDatumTrack then
        frmLog.AddLog('cTrack is DatumTrack')
      else if cTrack is TESMBearingTrack then
        frmLog.AddLog('cTrack is TESBearingTrack')
      else if cTrack is TPointTrack then
        frmLog.AddLog('cTrack is PointTrack') ;
    end;

  end;

  if Assigned(frmLog) then
  begin
    if findObj then
      frmLog.AddLog('findObj by screen pos true')
    else if not findObj then
      frmLog.AddLog('findObj by screen pos false');
  end;
  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);
    if Assigned(frmLog) then frmLog.AddLog('mTrack : '+ UIntToStr(mTrack.ShipTrackId));


    if Send then begin
      aRec.ShipID       := xSHIP.UniqueID;
      aRec.OrderID      := OrdID_assign_asrl;
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X            := mTrack.PositionX;
      aRec.Y            := mTrack.PositionY;
      netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec );
    end
    else begin
      mTrack.SetAssignASRL(TRUE);
    end;

    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);
    if Assigned(frmLog) then
    begin
      if findObj then
        frmLog.AddLog('findObj by view pos true')
      else if not findObj then
        frmLog.AddLog('findObj by view pos false');
    end;
    if findObj then begin
      if Assigned(frmLog) then frmLog.AddLog('detObj : '+detObj.UniqueID);
      with thePacket do begin
        ShipID      := xSHIP.UniqueID;
        OrderID     := ORD_ASROCK_ASSIGNED;
        DetectedUID := detObj.UniqueID;
        Ship_TID    := 0;
        TrackNumber := 0;
      end;
      netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @thePacket);
    end;
  end;

end;

procedure TGenericTDCInterface.SetFireAsroc
(aRec: TRecTrackOrder; IDLauncher :integer; mMissileID : word; RocketType : Byte;  IsSalvo : boolean; const send:boolean= TRUE);
var
  aRecAsrocFire : TRec3DSetAsrock;
  lTrack        : TManualTrack;
  findObj       : boolean;
  detObj        : TDetectedObject;
  r, b          : double;
  pt            : TPoint;
begin

  pt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if Assigned(frmLog) then
  begin
    if (cTrack = nil) then frmLog.AddLog('cTrack is Null')
    else
    if (cTrack <> nil) then
    begin
      frmLog.AddLog('cTrack not Null');
      if cTrack is TManualTrack then
        frmLog.AddLog('cTrack is ManualTrack')
      else if cTrack is TDatumTrack then
        frmLog.AddLog('cTrack is DatumTrack')
      else if cTrack is TESMBearingTrack then
        frmLog.AddLog('cTrack is TESBearingTrack')
      else if cTrack is TPointTrack then
        frmLog.AddLog('cTrack is PointTrack') ;
    end;

  end;

  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

    if send then begin

      {aRec.Ship_TID    := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X            := mTrack.PositionX;
      aRec.Y            := mTrack.PositionY;
      }
      r  := CalcRange(xSHIP.PositionX, xSHIP.PositionY,    // nautical miles
         mTrack.PositionX, mTrack.PositionY);
      b  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
         mTrack.PositionX, mTrack.PositionY);

      with aRecAsrocFire do begin
        ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
        OrderID        := ORD_ASROCK;
        mLauncherID    := IDLauncher;
        mWeaponID      := C_DBID_ASROC;
        mMissileNumber := 0;
        mMissile_Type  := 0;
        mTargetBearing := b;
        mTargetRange   := r;
        mTargetDepth   := 0;
      end;
//      netSend.sendDataEx(REC_SET_ASROCK, @aRecAsrocFire);
    end;
  end;
end;

procedure TGenericTDCInterface.setDeAssignASRL
    (aRec: TRecTrackOrder; const send: boolean= TRUE);
var findObj: boolean;
    detObj : TDetectedObject;
    pt : TPoint;
    thePacket: TRecOrderAssignment; // send to asroc
begin
  pt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

    if Send then begin
      aRec.ShipID   := xSHIP.UniqueID;
      aRec.OrderID  := OrdID_deassign_asrl;
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;

      netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec );
    end
    else begin
      mTrack.SetAssignASRL(FALSE);
    end;
    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);
    if findObj then begin
      with thePacket do begin
        ShipID      := xSHIP.UniqueID;
        OrderID     := ORD_ASROCK_DEASSIGNED;
        DetectedUID := detObj.UniqueID;
        Ship_TID := 0;
        TrackNumber := 0;
      end;
      netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @thePacket);
    end;
  end
end;

procedure TGenericTDCInterface.WipeOnPosition(const X, Y: integer);
var findObj: boolean;
    pt  : TPoint;
    td : TTrackDomain;
begin
  pt.X := X;
  pt.Y := Y;

  findObj := FindTrack_by_ScreenPos(X, Y, cTrack);

  if findObj then begin
    if (cTrack is TManualTrack) then begin
      mTrack := (cTrack as TManualTrack);
      DeleteMTrack(mTrack);
      exit;
    end
    else begin
      td := cTrack.Domain;   // datum, esmfix, rp
      if td = tdCursor then begin
//        DelCursorFix(pt)
      end
      else begin
        if SystLoad[td].Count > 0 then
          SystLoad[td].Count := SystLoad[td].Count - 1;
        cTrack.MarkAs_NeedToBeFree;
      end;
    end;
  end;                                                 
end;

procedure TGenericTDCInterface.WipeOnLeftOBM;
begin
  if HaveToSend then
    SendWIPE(OBMLeft.mPos.X, OBMLeft.mPos.Y)
  else
    WipeOnPosition(OBMLeft.Center.X, OBMLeft.Center.Y);
end;

procedure TGenericTDCInterface.WipeOnRightOBM;
begin
  if HaveToSend then
    SendWIPE(OBMRight.mPos.X, OBMRight.mPos.Y)
  else
    WipeOnPosition(OBMRight.Center.X, OBMRight.Center.Y);
end;

procedure TGenericTDCInterface.RecvWIPE(aRec: TRecOrderXY);
var pt: TPoint;
begin
  pt := ConvertToScreen(aRec.X, aRec.Y);
  WipeOnPosition(pt.X, pt.Y);
end;

procedure TGenericTDCInterface.SendWIPE(const X,Y: double);
var aRec : TRecOrderXY;
begin
  aRec.X := X;
  aRec.Y := Y;
  aRec.OrderID  := OrdID_WIPE;
  aRec.ShipID   := xSHIP.UniqueID;
  netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//qek 1 2 kanan
procedure TGenericTDCInterface.initiateTrackPacket(var aRec : TRecTrackOrder;
  var td: TTrackDomain);
var identc: char;
begin
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  identc := Char(aRec.OrderType);
  td := GetTrackDomainFromIDENT(identC);

  if aRec.TrackNumber  = 255 then
     aRec.TrackNumber  :=  GetLastTrackID(td)
  else
    SetLastTrackID(td, aRec.TrackNumber);

  aRec.ShipID       := xSHIP.UniqueID;
  aRec.Ship_TID     := shipt_tid;
end;

procedure TGenericTDCInterface.InitiateRAM(aRec : TRecTrackOrder;
   const send: boolean=TRUE);
var td: TTrackDomain;
    id: Char;
begin
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  initiateTrackPacket(aRec, td);

  if send then begin
    aRec.OrderID      :=  OrdID_init_ram;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);
    id := Char(aRec.OrderType);

    if InitMTrackIdent(mTrack, id) then begin
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
      mTrack.SetAmplifyingInfo_1(aiRAMTrack);
    end;

  end;
end;

procedure TGenericTDCInterface.InitiateAuto(aRec : TRecTrackOrder; const send: boolean=TRUE);
var td: TTrackDomain;
    id: Char;
begin
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  initiateTrackPacket(aRec, td);

  if send then begin
    aRec.OrderID      :=  OrdID_init_auto;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);
    id := Char(aRec.OrderType);

    if InitMTrackIdent(mTrack, id) then begin
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
      mTrack.SetAmplifyingInfo_1(aiAutomaticTrack);
    end;

  end;
end;

procedure TGenericTDCInterface.InitiateDR(aRec : TRecTrackOrder; const send: boolean=TRUE);
var td: TTrackDomain;
    id: Char;
begin
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  initiateTrackPacket(aRec, td);

  if send then begin
    aRec.OrderID      :=  OrdID_init_DR;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);

    id := Char(aRec.OrderType);
    if InitMTrackIdent(mTrack, id) then begin
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
      mTrack.SetAmplifyingInfo_1(aiDRTTrack);
    end;
  end;
end;

procedure TGenericTDCInterface.RecvAssignRAM(aRec: TRecTrackOrder);
var findTrack: boolean;
    ai : tAmplInfo;
begin
  findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
  if not findTrack then exit;

  ai := TAmplInfo(aRec.OrderType);
  case ai of
    aiRAMTrack :
      //rule: hanya DRT yg bisa jadi ram track
      if  (mTrack.TrackType = aiDRTTrack) then
        mTrack.SetAmplifyingInfo_1(aiRAMTrack);

    aiAutomaticTrack :
       mTrack.SetAmplifyingInfo_1(aiAutomaticTrack);

    aiDRTTrack :
      mTrack.SetAmplifyingInfo_1(aiDRTTrack);
  end;


end;

procedure TGenericTDCInterface.AssignRAM(aRec: TRecTrackOrder; const send: boolean=TRUE);
var pt : TPoint;
    findTrack: boolean;
    ai : tAmplInfo;
begin
  pt := ConvertToScreen(aRec.X, aRec.Y);
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if not findTrack  or not (cTrack is TManualTrack) then exit;
  mTrack := cTrack as TManualTrack;

  if Send then begin
    aRec.OrderID := OrdID_change_ampl_info;

    aRec.OrderType := byte(aiRAMTrack);

    aRec.ShipID := xSHIP.UniqueID;

    aRec.Ship_TID   := mTrack.ShipTrackId;
    aRec.TrackNumber:= mTrack.TrackNumber;
    aRec.X          := mTrack.PositionX;
    aRec.Y          := mTrack.PositionY;

    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    ai := TAmplInfo(aRec.OrderType);
    case ai of
      aiRAMTrack :
        //rule: hanya DRT yg bisa jadi ram track
        if  (mTrack.TrackType = aiDRTTrack) then
          mTrack.SetAmplifyingInfo_1(aiRAMTrack);

      aiAutomaticTrack :
         mTrack.SetAmplifyingInfo_1(aiAutomaticTrack);

      aiDRTTrack :
        mTrack.SetAmplifyingInfo_1(aiDRTTrack);
    end;
  end;
end;

procedure TGenericTDCInterface.AssignDR(aRec: TRecTrackOrder; const send: boolean=TRUE);
var pt : TPoint;
    findTrack: boolean;
begin
  pt := ConvertToScreen(aRec.X, aRec.Y);
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if not findTrack then exit;

  if Send then begin
    aRec.OrderID := OrdID_change_ampl_info;
    aRec.OrderType := byte(aiDRTTrack);
    aRec.ShipID := xSHIP.UniqueID;

    aRec.Ship_TID   := mTrack.ShipTrackId;
    aRec.TrackNumber:= mTrack.TrackNumber;
    aRec.X          := mTrack.PositionX;
    aRec.Y          := mTrack.PositionY;

    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    if mTrack.TrackType = aiDRTTrack then begin
      mTrack.SetAmplifyingInfo_1(aiRAMTrack);
    end;
  end;
end;
procedure TGenericTDCInterface.AssignAuto(aRec: TRecTrackOrder; const send: boolean=TRUE);
var pt : TPoint;
    findTrack: boolean;
begin
  pt := ConvertToScreen(aRec.X, aRec.Y);
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if not findTrack then exit;

  if Send then begin
    aRec.OrderID := OrdID_change_ampl_info;
    aRec.OrderType := byte(aiAutomaticTrack);

    aRec.ShipID := xSHIP.UniqueID;

    aRec.Ship_TID   := mTrack.ShipTrackId;
    aRec.TrackNumber:= mTrack.TrackNumber;
    aRec.X          := mTrack.PositionX;
    aRec.Y          := mTrack.PositionY;

    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    if mTrack.TrackType = aiDRTTrack then begin
      mTrack.SetAmplifyingInfo_1(aiRAMTrack);
    end;
  end;
end;

procedure TGenericTDCInterface.AssignTrackToDetected(const sid, tn: byte;
  const dUid: string);        //receive correctRAM
var detObj : TDetectedObject;
begin
  detObj := ActiveRadar.DetObjects.FindObjectByUid(dUid) as TDetectedObject;
  // if detObj = nil -> close relation
  if FindTrack_by_trackID(sid, tn, mTrack)  then begin
     mTrack.Relation := detObj;
     if detObj <> nil then
       mTrack.SetAmplifyingInfo_1(aiAutomaticTrack);
  end;
end;

procedure TGenericTDCInterface.RecvUpdateTrackPosition(aRec: TRecTrackOrder);
var  r, b, dt: double;
begin                         //receive correctRAM juga.
  if FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack)  then begin
    
    dt :=  LastUpdateCounter - mTrack.LastUpdateTime;   // ms
    r := CalcRange(mTrack.LastSetX, mTrack.LastSetY,    // nautical miles
       aRec.X, aRec.Y);

    b := CalcBearing(mTrack.LastSetX, mTrack.LastSetY,
       aRec.X, aRec.Y);

    mTrack.Course := b;
    if dt > 0 then
      mTrack.Speed  := (r * C_HourToMilliSecond)/ dt
    else
      mTrack.Speed  := 0.0;

    mTrack.SetPosition(aRec.X, aRec.Y);
    mTrack.LastUpdateTime := LastUpdateCounter;
  end;

end;

procedure TGenericTDCInterface.CorrectRAM(aDomain : TTrackDomain;
 const send:boolean = TRUE);
var findObj   : boolean;
    detObj    : TDetectedObject;
    lTrack : TManualTrack;
    aRec : TRecOrderAssignment;
    aRecOrder: TRecTrackOrder;
    r, b,  dt: double;
begin
  lTrack := nil;
  case aDomain of
    tdAtasAir : lTrack := SelTrack_AtasAir;
    tdUdara   : lTrack := SelTrack_Udara;
    tdBawahAir: lTrack := SelTrack_BawahAir;
    tdDontCare: lTrack := selTrack;
  end;

  if lTrack = nil then exit;

  findObj := ActiveRadar.FindDetectedObjectByView(
    OBMRight.Center.X, OBMRight.Center.Y, detObj);

  if send then begin
    aRec.OrderID := OrdID_CorrectRAM;
    aRec.ShipID  := xSHIP.UniqueID;

    aRec.Ship_TID     := lTrack.ShipTrackId;
    aRec.TrackNumber  := lTrack.TrackNumber;

    if findObj then begin
      aRec.DetectedUID := detObj.UniqueID;
      netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @aRec);
    end;

    aRecOrder.ShipID := xSHIP.UniqueID;
    aRecOrder.Ship_TID      := lTrack.ShipTrackId;
    aRecOrder.TrackNumber   := lTrack.TrackNumber;
    aRecOrder.OrderID       := OrdID_UpdateTrackPos;
    aRecOrder.X   := OBMRight.mPos.X;
    aRecOrder.Y   := OBMRight.mPos.Y;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRecOrder);

  end
  else begin
    dt :=  LastUpdateCounter - lTrack.LastUpdateTime;   // ms
    r := CalcRange(lTrack.LastSetX, lTrack.LastSetY,    // nautical miles
       OBMRight.mPos.X, OBMRight.mPos.Y);

    b := CalcBearing(lTrack.LastSetX, lTrack.LastSetY,
       OBMRight.mPos.X, OBMRight.mPos.Y);

    lTrack.Course := b;
    if dt > 0 then
      lTrack.Speed  := (r * C_HourToMilliSecond)/ dt
    else
      lTrack.Speed  := 0.0;

    if findObj then begin
      lTrack.Relation := detObj;
      lTrack.SetAmplifyingInfo_1(aiAutomaticTrack);
    end
    else begin
      lTrack.Relation := nil;
      lTrack.SetAmplifyingInfo_1(aiRAMTrack);
    end;

    lTrack.SetPosition(OBMRight.mPos.X, OBMRight.mPos.Y);

    lTrack.LastUpdateTime := LastUpdateCounter;
  end;
end;

procedure TGenericTDCInterface.SetOBMRightPos_NextTrack_AtasAir;
var repCount  : integer;
    list      : TList;
begin
  list := TrackList.GetList;
  if list.Count > 0 then begin
    repCount := 0;
    repeat
      FTrackIndex_AtasAir := (FTrackIndex_AtasAir + 1) mod list.Count;
      mTrack              := list.Items[FTrackIndex_AtasAir];
      inc(repCount);
    until (mTrack.Domain = tdAtasAir) or (repCount=list.Count);
    TrackList.ReturnList;

    if mTrack.Domain = tdAtasAir then begin

      OBMRight.mPos.X   := mTrack.PositionX;
      OBMRight.mPos.Y   := mTrack.PositionY;
      ConvertViewPosition;

      SelTrack_AtasAir := mTrack;
    end;
  end;
end;

procedure TGenericTDCInterface.SetOBMRightPos_NextTrack_Udara;
var repCount  : integer;
    list      : TList;
begin
  list := TrackList.GetList;
  if list.Count > 0 then begin
    repCount := 0;
    repeat
      FTrackIndex_Udara := (FTrackIndex_Udara + 1) mod list.Count;
      mTrack    := list.Items[FTrackIndex_Udara];
      inc(repCount);
    until (mTrack.Domain = tdUdara) or (repCount=list.Count);
    TrackList.ReturnList;

    if mTrack.Domain = tdUdara then begin

      OBMRight.mPos.X   := mTrack.PositionX;
      OBMRight.mPos.Y   := mTrack.PositionY;
      ConvertViewPosition;

      SelTrack_Udara := mTrack;
    end;
  end;
end;

procedure TGenericTDCInterface.SetOBMPos_NextTrack;   // all track, for rencong
var list      : TList;
begin
  list := TrackList.GetList;
  if list.Count > 0 then begin
    FTrackIndex := (FTrackIndex + 1) mod list.Count;
    mTrack    := list.Items[FTrackIndex];
    TrackList.ReturnList;

    OBMRight.mPos.X   := mTrack.PositionX;
    OBMRight.mPos.Y   := mTrack.PositionY;
    ConvertViewPosition;

    SelTrack := mTrack;
  end;
end;

procedure TGenericTDCInterface.CloseControl(aDomain : TTrackDomain);
var findTrack: boolean;
begin
  findTrack := FindTrack_by_ScreenPos(OBMRight.Center.X, OBMRight.Center.Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);
    case aDomain of
      tdAtasAir :
        SelTrack_AtasAir := mTrack;
      tdUdara :
        SelTrack_Udara := mTrack;
      tdBawahAir :
        SelTrack_BawahAir := mTrack;
      tdDontCare :
        selTrack := mTrack;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TGenericTDCInterface.Recv_Ident(aRec : TRecTrackOrder);
var tId : char;
    findTrack: boolean;
begin
  findTrack :=  FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
  tID  := Char(aRec.OrderType);

  if not findTrack then  begin
    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);

    if InitMTrackIdent(mTrack, tID) then
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
  end
  else
    ChangeMTrackIdent(mTrack, tID);
end;

procedure TGenericTDCInterface.Recv_Ident_OWA(aRec : TRecTrackOrder);
var tId : char;
    findTrack: boolean;
begin
  findTrack :=  FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
  tID  := Char(aRec.OrderType);
                     
  if not findTrack then  begin
    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);

    if InitMTrackIdent(mTrack, tID) then
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
  end
  else begin
    if (tID = ID_BawahAir_NonSub) then begin
      if mTrack.Domain = tdBawahAir then begin
        ChangeMTrackIdent(mTrack, tID);
        mTrack.CourseVisible := false;
        mTrack.AmpliInfoVisible := false;
        mTrack.Relation := nil;
      end;
    end
    else ChangeMTrackIdent(mTrack, tID);
  end;

end;

//------------------------------------------------------------------------------

procedure TGenericTDCInterface.Change_Ident(
      aRec : TRecTrackOrder;
      const send: boolean= TRUE );
var findTrack: boolean;
    pt  : TPoint;
    tId : char;
begin        // change only. does not create if track doesn't exist.
  pt  := ConvertToScreen(aRec.X, aRec.Y);
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if not findTrack or not (cTrack is TManualTrack) then exit;

  if send then begin
    aRec.ShipID       := xSHIP.UniqueID;
    aRec.Ship_TID     := cTrack.ShipTrackId;
    aRec.TrackNumber  := cTrack.TrackNumber;
  end;

  tID  := Char(aRec.OrderType);

  if Send then begin
    aRec.OrderID := OrdID_change_ident;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
  end
  else begin
    //ChangeMTrackIdent(mTrack, tID);
  end;

end;

//------------------------------------------------------------------------------
procedure TGenericTDCInterface.SetInitESMFix(
      aRec: TRecOrderXY;
      const send: boolean= TRUE );

begin
  if send then begin
    aRec.ShipID  := xSHIP.UniqueID;
    aRec.OrderID := OrdID_init_esm_fix;
    aRec.OrderType := GetLastTrackID(tdEW);
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end
  else begin
     InitiateESMFix(aRec.X, aRec.Y, aRec.OrderType)
  end;
end;

procedure TGenericTDCInterface.setAssignSSM(aRec: TRecOrderXY; send: boolean);
var pt  : TPoint;
    findTrack : boolean;
begin

  pt := ConvertToScreen(aRec.X, aRec.Y);
  if send then begin  // send to other TDC / wcc
    aRec.ShipID := xSHIP.UniqueID;
    aRec.OrderID := OrdID_assign_SSM;
    aRec.OrderType := 0;  //reserve, search mode.

    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
    if findTrack and (cTrack is TManualTrack) then begin
      mTrack := (cTrack as TManualTrack);

      netSend.sendDataEx(C_REC_ORDER_XY, @aRec);

      ssmTrack := mTrack;
      ssmUpdateCounter := 0.0;
      ssmSendUpdate    := true;
    end
  end
  else begin
    assssm.Org.X := xShip.PositionX;
    assssm.Org.Y := xShip.PositionY;
    assssm.ExocetID := -1;
    if aRec.OrderType = 0 then begin
//      assssm.Range := C_KiloMeter_To_NauticalMiles * 36; // km
      assssm.Direction := CalcBearing(
        xShip.PositionX, xShip.PositionY,
       aRec.X, aRec.Y);

      findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
      if findTrack and (cTrack is TManualTrack) then begin
        mTrack := (cTrack as TManualTrack);

        assssm.Range := CalcRange(xShip.PositionX, xShip.PositionY,
          mTrack.PositionX, mTrack.PositionY);

        ssmTrack := mTrack;
        assssm.Visible := true;
        assssm.Enabled := FALSE;
      end;
    end;
  end;
end;

procedure TGenericTDCInterface.SendUpdateSSM();
var aRec: TRecOrderXY;
begin
  // send to exocet command panel
  if Assigned(ssmTrack) then begin
    aRec.ShipID  := xSHIP.UniqueID;
    aRec.OrderID := OrdID_update_SSM;
    aRec.OrderType := 0;

    aRec.X := CalcRange(xShip.PositionX, xShip.PositionY,
      mTrack.PositionX, mTrack.PositionY);

    aRec.Y := CalcBearing(xShip.PositionX, xShip.PositionY,
      mTrack.PositionX, mTrack.PositionY);

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;
end;

procedure TGenericTDCInterface.setDeAssignSSM(send: boolean);
var aRec: TRecOrderXY;
begin
  if send then begin
    aRec.ShipID := xSHIP.UniqueID;
    aRec.OrderID := OrdID_deassign_SSM;
    aRec.OrderType := 0;  //reserve, search mode.

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
    ssmTrack := nil;
    ssmSendUpdate := False;
  end
  else begin
    assssm.ExocetID := -1;
    assssm.Visible := false;
    assssm.Enabled := false;

    ssmTrack := nil;
    ssmSendUpdate := False;
  end;
end;

procedure TGenericTDCInterface.SetAssignTorpedo_MK44(
  aRec: TRecTrackOrder;
  const send: boolean = TRUE);
var findObj: boolean;
    pt: TPoint;
begin

  if send then begin
  pt := ConvertToScreen(aRec.X, aRec.Y);
    findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

    if findObj and (cTrack is TManualTrack) then begin
      mTrack := (cTrack as TManualTrack);
      aRec.ShipID  := xShip.UniqueID;
      aRec.OrderID := OrdID_assign_tor;
      aRec.OrderType    := C_OrdType_Torpedo_MK44;
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;

      netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec );
    end
  end
  else begin
    findObj := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber , mTrack);
    if findObj then begin
// if    aRec.OrderType    = C_OrdType_Torpedo_MK44 then
      LaunchTorpedoTo(aRec.Ship_TID, aRec.TrackNumber);
    end

  end;

  AssTorpedo.Direction  := xSHIP.Heading;
  AssTorpedo.Enabled    := TRUE;
  AssTorpedo.Visible    := TRUE;
end;

procedure TGenericTDCInterface.SetDeAssignTorpedo;
var aRec: TRecOrder;
begin

  AssTorpedo.Enabled := FALSE;
  AssTorpedo.Visible := FALSE;

  if send then begin
     aRec.ShipID  := xShip.UniqueID;
     aRec.OrderID := OrdID_deassign_tor;
     aRec.OrderByteParam    := C_OrdType_Torpedo_MK44;
     netSend.sendDataEx(C_REC_ORDER, @aRec );
  end;
end;

procedure TGenericTDCInterface.SetMainSymbolVisible(const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    mTrack := l[i];
    mTrack.MainSymbolVisible := aVis;
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.SetAMPLInfoVisible(const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    mTrack := l[i];
    mTrack.AmpliInfoVisible := aVis;
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.SetCourseVisible(const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    mTrack := l[i];
    mTrack.CourseVisible := aVis;
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.SetLINKVisible(const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    mTrack := l[i];
    mTrack.LinkVisible := aVis;
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.SetTrackNumberVisible(const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    mTrack := l[i];
    mTrack.TrackNumberVisible := aVis;
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.Filter(const atd: TTrackDomain;
  const aVis: boolean);
var i: integer;
    l : TList;
begin
//  if atd = tdEW then begin

//    ESMFixs.Visible := aVis;
//  end
// else begin
    l := TrackList.GetList;
    for i := 0 to l.Count-1 do begin
      cTrack := l[i];
      if cTrack.Domain = atd then
        cTrack.Visibles := aVis;
    end;

    TrackList.ReturnList;
//  end;
end;

procedure TGenericTDCInterface.Filter(const atd: TTrackDomain; const org: TTrackOrigin_OWA; const aVis: boolean);
var i: integer;
    l : TList;
begin
  l := TrackList.GetList;
  for i := 0 to l.Count-1 do begin
    cTrack := l[i];
    if (cTrack.Domain = atd) and (cTrack.GetTrackOrigin = org) then
      cTrack.Visibles := aVis;
  end;

  TrackList.ReturnList;
end;

function TGenericTDCInterface.SetAssign_FC(const aNum: byte; const pt: TPoint;
  const send:boolean= true): boolean;
var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    minRange : double;
    td : TTrackDomain;
    ID: char;
    FC : TFireControl;
    r: double;
    dpt : t2DPoint;
    TrackUID : string;
    aRec: TRecFireControlOrder;
begin  //beres
  result := false;
  if  (aNum < 1) or (aNum > 5) then exit;
  case aNum of
    1: begin
      minRange := C_FC1_RANGE;
      td := tdUdara;
      ID := ID_Udara_Hostile;
      FC := FC1;
    end;
    2: begin
      minRange := C_FC2_RANGE;
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
      FC := FC2;
    end;
    3: begin
      minRange := C_FC3_RANGE;
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
      FC := FC3;
    end;
    5: begin
      minRange := C_FC3_RANGE;
      td := tdBawahAir;
      ID := ID_BawahAir_Hostile;
      FC := FC5;
    end;
  end;

  if FC.TrackedTarget <> nil then Exit; //
  // FC  dipakai. de assign dulu.
  if (aNum = 3) and (FC.ThrowOff = True) then exit;

  findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
  if findTrack  and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

    mTrack.Domain := td;
    mTrack.SetIdent(ID);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
  end;

  TrackUID := '';
  findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

  if findObj then begin
    if not findTrack then begin
      dpt := ConvertToMap(pt.X, pt.Y);

      CreateDefaultMTrack(mTrack, dPt.X,  dPt.Y);
      mTrack.LastUpdateTime := LastUpdateCounter;
      mTrack.Enabled := TRUE;
      mTrack.UniqueID := detObj.UniqueID;

      TrackList.AddObject(mTrack);
      mTrack.ConvertViewsPosition;

      case aNum of
         1  : aRec.TrackNumber := GetLastTrackID(tdUdara);
         2,
         3,
         4  : aRec.TrackNumber := GetLastTrackID(tdAtasAir);  // GetLTID_AtasAir;
         5  : begin
                aRec.TrackNumber := GetLastTrackID(tdBawahAir);
                mTrack.Height := -15;                         // setting default kedalaman di andu 15 meter
                mTrack.PositionZ := -15;
              end;
      end;
      aRec.Ship_TID := shipt_tid;

      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
      mTrack.Domain := td;
      mTrack.SetIdent(ID);
      mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
    end;

    r := CalcRange(xShip.PositionX, xSHIP.PositionY, mTrack.PositionX, mTrack.PositionY);
    if r < minRange then begin
//      if aNum < 5 then
        mTrack.SetDelay_To_Automatic(aNum, false,  detObj);
//      else
//        mTrack.SetDelay_To_Automatic(aNum, true,  detObj);

      TrackUID := detObj.UniqueID;
      result := True;
    end
    else begin
      mTrack.SetDelay_To_Manual(aNum, false);
      result := false;
//      exit;  // track out of range.
    end;

    mTrack.UniqueID := detObj.UniqueID;
    aRec.TrackUID     := detObj.UniqueID;
    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.X := mTrack.PositionX;
    aRec.Y := mTrack.PositionY;
  end
  else begin // det object not found.
    aRec.TrackUID     := '';
    if findTrack then begin
      mTrack.SetDelay_To_Manual(aNum, false);
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X := mTrack.PositionX;
      aRec.Y := mTrack.PositionY;

    end;
    result := false;
  end;

  // last track
  if mTrack <> nil then FC_Chanel[aNum].LastTrackedTarget := mTrack;

  if result then begin
    FC.IsTracking     := true;
    FC.TrackedTarget  := mTrack;
    FC.Detected       := detObj;
    FC.TargetUID      := detObj.UniqueID;
  end
  else begin
    FC.IsTracking     := FALSE;
    FC.TrackedTarget  := nil;
    FC.Detected       := nil;
    FC.TargetUID      := '';
  end;

  if send then begin
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.FC_number  := aNum;
    case aNum of
        1 : aRec.FC_command := Byte(RATO);
        2 : aRec.FC_command := Byte(RSTO);
        3 : aRec.FC_command := Byte(RSTO);   // cek lagi.
        4 : aRec.FC_command := Byte(RSTO);
        5 : aRec.FC_command := Byte(AssignTrackSs);
    end;

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;
 //   mTrack.Domain := td;
end;

procedure TGenericTDCInterface.RecvAssign_FC(aRec: TRecFireControlOrder);
var sim : TSimulationClass;
    detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;

    td : TTrackDomain;
    ID: char;
    FC : TFireControl;
    r, minRange: double;
begin  //beres
// kondisi sudah di cek dan valid dari pengirim
//  aRec.OrderID    := OrdID_assign_FC;
//  aRec.ShipID     := xSHIP.UniqueID;
  case aRec.FC_number of
    1: begin
      minRange := C_FC1_RANGE;
      td := tdUdara;
      ID := ID_Udara_Hostile;
      FC := FC1;
    end;
    2: begin
      minRange := C_FC2_RANGE;
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
      FC := FC2;
    end;
    3: begin
      minRange := C_FC3_RANGE;
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
      FC := FC3;
    end;
    4: begin
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
      FC := FC4;
    end;
    5: begin
      minRange := C_FC3_RANGE;
      td := tdBawahAir;
      ID := ID_BawahAir_Hostile;
      FC := FC5;
    end;
  end;

  findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
// ----- receive.
  if not findTrack then begin
    CreateDefaultMTrack(mTrack, aRec.X,  aRec.Y);
    mTrack.LastUpdateTime := LastUpdateCounter;
    mTrack.Enabled := TRUE;

    TrackList.AddObject(mTrack);

    mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
  end;

  mTrack.TrackNumberVisible := True;
  mTrack.Domain := td;
  mTrack.SetIdent(ID);
  mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
// -----
  detObj := nil;
  sim  := ActiveRadar.DetObjects.FindObjectByUid(aRec.TrackUID);
  if (sim is TDetectedObject) then
    detObj := (sim as TDetectedObject);
  findObj := detObj <> nil;

  if findObj then begin
    mTrack.UniqueID:= detObj.UniqueID;
    mTrack.Height := detObj.PositionZ;

    r := CalcRange(xShip.PositionX, xSHIP.PositionY, mTrack.PositionX, mTrack.PositionY);
    if r < minRange then begin
      FC.TrackedTarget :=  mTrack;
      mTrack.SetDelay_To_Automatic(aRec.FC_number, false,  detObj);

    end
    else
      mTrack.SetDelay_To_Manual(aRec.FC_number, false);
  end
  else begin
    FC.TrackedTarget :=  nil;
    mTrack.SetDelay_To_Manual(aRec.FC_number, false);
  end;
end;
//  OrdType_FC_number = (FC1, FC2, FC3, FC4);
//  OrdType_FC_command = (STO, SBS, ATO, SBA, RATO, RSTO,  break_track, open_fire, hold_fire);


function TGenericTDCInterface.SetDeAssign_FC(const aNum: byte; const send:boolean= true): boolean;
var aRec: TRecFireControlOrder;
    trck : TManualTrack;
begin
Result := False;
  if  (aNum < 1) or (aNum > 4) then exit;

  if Send then begin
    aRec.OrderID    := OrdID_deassign_FC;
    aRec.ShipID     := xSHIP.UniqueID;
    aRec.FC_number  := aNum;
  end;

  if FC_Chanel[aNum].TrackedTarget <> nil then begin
    trck := FC_Chanel[aNum].TrackedTarget;

    if Send then begin
      aRec.X            := trck.PositionX;
      aRec.Y            := trck.PositionY;
      if trck.Relation <> nil then
      aRec.TrackUID     := trck.Relation.UniqueID;
      aRec.Ship_TID     := trck.ShipTrackId;
      aRec.TrackNumber  := trck.TrackNumber;
    end;

    trck.SetDeAssign_FC(aNum);
  end;

  FC_Chanel[aNum].IsTracking    := false;
  FC_Chanel[aNum].TrackedTarget := nil;
  FC_Chanel[aNum].TargetUID     :=  '';
  FC_Chanel[aNum].Detected      := nil;
//  FC_Chanel[aNum].IsDoingBlindBomb := false;
//  FC_Chanel[aNum].IsDoingIndBomb   := false;
//  FC_Chanel[aNum].GenFix           := false;

  if send then begin
    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
    Result := True;
  end;


end;

procedure TGenericTDCInterface.RecvDeAssign_FC(aRec: TRecFireControlOrder);
var
  aNum    : byte;
  aRecTrack : TRecTrackOrder;
begin
  aNum :=  aRec.FC_number;
//  if  (aNum < 1) or (aNum > 4) then exit;
  if  (aNum < 1) or (aNum > 5) then exit;

  if FC_Chanel[aNum].TrackedTarget <> nil then begin
    mTrack.MainSymbolVisible    := False;
    mTrack.CourseVisible        := False;
    mTrack.AmpliInfoVisible     := False;
    mTrack.LINKVisible          := False;
    mTrack.TrackNumberVisible   := False;

    FC_Chanel[aNum].TrackedTarget.SetDeAssign_FC(aNum);
    FC_Chanel[aNum].TrackedTarget := nil;
  end;

  FC_Chanel[aNum].IsTracking    := false;
  FC_Chanel[aNum].TargetUID     :=  '';
  FC_Chanel[aNum].Detected      := nil;
  FC_Chanel[aNum].GenFix        := false;
  FC_Chanel[aNum].IsDoingBlindBomb := false;
  FC_Chanel[aNum].IsDoingIndBomb   := false;

  ThrowOff_Marker.Visible := false;
end;


procedure TGenericTDCInterface.SetHoldFire_FC(const aNum: byte; const send:boolean= true);
var aRec: TRecFireControlOrder;
begin
  if (aNum > 5) or (aNum < 1) then exit;

  if  FC_Chanel[aNum].TrackedTarget <> nil then begin
    if Send then begin
      aRec.OrderID    := OrdID_assign_FC;
      aRec.ShipID     := xSHIP.UniqueID;

      aRec.FC_number  := aNum;
      aRec.FC_command := Byte(Hold_Fire);

      netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
    end
    else
      FC_Chanel[aNum].TrackedTarget.SetAssign_FC(aNum, TRUE);

  end;
end;

procedure TGenericTDCInterface.SetOpenFire_FC(const aNum: byte; const send:boolean= true);
var aRec: TRecFireControlOrder;
begin
  if (aNum > 5) or (aNum < 1) then exit;

  if  FC_Chanel[aNum].TrackedTarget <> nil then begin
    if Send then begin
      aRec.OrderID    := OrdID_assign_FC;
      aRec.ShipID     := xSHIP.UniqueID;

      aRec.FC_number  := aNum;
      aRec.FC_command := Byte(Open_Fire);

      netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
    end
    else
    FC_Chanel[aNum].TrackedTarget.SetAssign_FC(aNum, FALSE);
  end;
end;

procedure TGenericTDCInterface.RecvAssign_GenFiX(aRec: TRecFireControlOrder);
//create echo if not exist.
var findTrack : boolean;
 FCtmp :TFireControl;
begin  //
  if (aRec.FC_number < 2) or (aRec.FC_number > 3)  then exit;

    case aRec.FC_number of
      2 : FCtmp :=FC2;
      3 : FCtmp :=FC3;
    end;

  findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
// ----- receive.
  if not findTrack then begin
    CreateDefaultMTrack(mTrack, aRec.X,  aRec.Y);
    TrackList.AddObject(mTrack);
    mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
  end;

  mTrack.Domain := tdAtasAir;
  mTrack.SetIdent(ID_AtasAir_Hostile);
  mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
// -----
  FCtmp.IsTracking    := true;
  FCtmp.TrackedTarget :=  mTrack;
  FCtmp.GenFix := true;

  mTrack.SetDelay_To_Automatic(aRec.FC_number, false,  nil);
end;

procedure TGenericTDCInterface.RecvAssign_BlindBomb(aRec: TRecFireControlOrder);
// assign FC 2 tanpa echo
var findTrack : boolean;
begin  //
  if aRec.FC_number <> 2 then exit;

  findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);
// ----- receive.
  if not findTrack then begin
    CreateDefaultMTrack(mTrack, aRec.X,  aRec.Y);
    TrackList.AddObject(mTrack);
    mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
  end;

  mTrack.Domain := tdAtasAir;
  mTrack.SetIdent(ID_AtasAir_Hostile);
  mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
// -----
  FC2.IsTracking    := true;
  FC2.TrackedTarget :=  mTrack;
  mTrack.SetDelay_To_Automatic(aRec.FC_number, false,  nil);
end;

procedure TGenericTDCInterface.SetBlindARC(const v: boolean);
begin
  BlindArcs.SetVisibles(v);
end;

procedure TGenericTDCInterface.SetBlindARCASW(const v: boolean);
begin
  BlindArcsAsw.SetVisibles(v);
end;

procedure TGenericTDCInterface.SetLPDTest(const v: boolean);
begin
  LPDTest.Visible :=  v;
  if v then begin
    LPDTest.Left := 1;
    LPDTest.Top  := 1;
    LPDTest.Width  := FMap.Width -2;
    LPDTest.Height := FMap.Height -2;
  end;
end;

procedure TGenericTDCInterface.SetLPDText(const v: boolean; s1:string=''; s2: string='');
var w, h : integer;
begin
  LPDText.Visible := v and ( (s1 <> '') or (s2 <> ''));

  if LPDText.Visible then begin
    w := (FMap.Width div 2);
    h := FMap.Height div 12;

    LPDText.Left := FMap.Width div 4 ;
    LPDText.Top  := FMap.Height - (FMap.Height div 10) -10;
    LPDText.Width  := w;
    LPDText.Height := h;
    LPDText.Line1 := s1;
    LPDText.Line2 := s2;
  end;
end;


function TGenericTDCInterface.CreateCursorFix(var nESMB: TESMBearingTrack): boolean;
begin
  result := FALSE;
  if SystLoad[tdCursor].Count < SystLoad[tdCursor].Capacity then begin

    nESMB := TESMBearingTrack.Create;
    nESMB.CreateDefaultView(FMap);
    nESMB.SetTrackNumber(shipt_tid, GetLastTrackID(tdCursor));
    nESMB.SetPosition(Cursorss.Org.X, Cursorss.Org.Y);
    nESMB.Bearing  := Cursorss.Heading;
    nESMB.Distance := Cursorss.Distance;
    nESMB.Domain := tdCursor;

    nESMB.Enabled := true;
    TrackList.AddObject(nESMB);

    SystLoad[tdCursor].Count := SystLoad[tdCursor].Count + 1;
    result := TRUE;
  end
  else
    AddGameLog('Add Cursor Failed.');

end;

procedure TGenericTDCInterface.AddCursorFix;
begin
  CreateCursorFix(esbTrack);
end;

procedure TGenericTDCInterface.AddCursorFixToTrack(const sid, tnum: byte);
var findTrack : boolean;
begin
  if CreateCursorFix(esbTrack) then begin

    findTrack := FindTrack_by_trackID(sid, tnum, mTrack);

    if findTrack then begin
      CConnect :=  TCursorTrackConnection.Create;
      CConnect.mTrack := mTrack;
      CConnect.esbTrack := esbTrack;
      FCConnList.Add(CConnect);
    end
  end
end;

{function TGenericTDCInterface.DelCursorFix(const pt: TPoint): boolean;
var i: integer;
begin
  i := FixCursorList.Count-1;
  result := false;
  while not result and  (i >= 0) do begin
    newARC := FixCursorList[i];

    if ptToLineDistance(newARC.Center, newARC.EndPoint, pt) < 5 then begin
      FixCursorList.Delete(i);
      newARC.Free;
      result := true;

      if SystLoad[tdCursor].Count > 0 then
        SystLoad[tdCursor].Count := SystLoad[tdCursor].Count -1;
    end;

    dec(i);
  end;
end;
}
function TGenericTDCInterface.DelCursorFix(const pt: TPoint): boolean;
var findObj: boolean;
    td : TTrackDomain;
    i: integer;
begin
  findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

  if findObj then begin
    if (cTrack is TESMBearingTrack) then begin
      td := cTrack.Domain;   // datum, esmfix, rp

      if SystLoad[td].Count > 0 then
        SystLoad[td].Count := SystLoad[td].Count - 1;

      cTrack.MarkAs_NeedToBeFree;

      for i := FCConnList.Count-1 downto 0 do begin
        CConnect := FCConnList[i];

        if CConnect.esbTrack = cTrack then begin
          FCConnList.Delete(i);
          CConnect.Free;
        end
      end;
    end;
  end;

end;

procedure TGenericTDCInterface.StartICMLeft(const icmNum: byte; const x,y: double; const send:boolean= true);
var aRec: TRecOrderXY;
begin
  if (icmNum > 0) and (icmNum < 4) then begin
    ICMLeft.icmNum := icmNum;

    ICMLeft.Visible := TRUE;
    ICMLeft.Moved   := TRUE;
    ICMLeft.mPos.X    := X;
    ICMLeft.mPos.Y    := Y;

    OBMLeft.Visible := FALSE;

    ICMRight.Moved   := FALSE;
    ICMRight.Visible := FALSE;

  end;
  if send then begin
    aRec.OrderID := OrdID_start_ICM;
    aRec.ShipID := xSHIP.UniqueID;

    aRec.X := x;
    aRec.Y := y;

    aRec.OrderType := icmNum;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;
end;

procedure TGenericTDCInterface.EndICMLeft(const icmNum: byte; const send:boolean= true);
var aRec: TRecOrderXY;
begin
  if (icmNum > 0) and (icmNum < 4) then begin
    ICMLeft.Visible := FALSE;
    ICMLeft.Moved   := FALSE;

    OBMLeft.Visible := TRUE;
  end;

  if send then begin
    aRec.OrderID := OrdID_end_ICM;
    aRec.ShipID := xSHIP.UniqueID;

    aRec.OrderType := icmNum;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;
end;

procedure TGenericTDCInterface.StartICMRight(const icmNum: byte; const x,y: double; const send:boolean= true);
var aRec: TRecOrderXY;
begin
  if (icmNum > 10) and (icmNum < 14) then begin
    ICMRight.icmNum := icmNum - 10;
    ICMRight.Visible := TRUE;
    ICMRight.Moved   := TRUE;
    ICMRight.mPos.X := X;
    ICMRight.mPos.Y := Y;

    ICMLeft.Visible := FALSE;
    ICMLeft.Moved   := FALSE;

    OBMRight.Visible := FALSE;
  end;

  if send then begin
    aRec.OrderID := OrdID_start_ICM;
    aRec.ShipID := xSHIP.UniqueID;

    aRec.OrderType := icmNum;
    aRec.X := x;
    aRec.Y := y;

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;

end;

procedure TGenericTDCInterface.EndICMRight(const icmNum: byte; const send:boolean= true);
var aRec: TRecOrderXY;
begin
  if (icmNum > 10) and (icmNum < 14) then begin
    ICMRight.Visible := FALSE;
    ICMRight.Moved   := FALSE;
    OBMRight.Visible := TRUE;
  end;
  if send then begin
    aRec.OrderID := OrdID_end_ICM;
    aRec.ShipID := xSHIP.UniqueID;

    aRec.OrderType := icmNum;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;
end;

procedure TGenericTDCInterface.UpdateICMPos(const icmNum: byte; const x, y: double);
begin
  if ICMLeft.Moved  and (ICMLeft.icmNum = icmNum) then  begin
    ICMLeft.mPos.X := X;
    ICMLeft.mPos.Y := Y;
  end;

  if ICMRight.Moved  and (ICMRight.icmNum = icmNum) then  begin
    ICMRight.mPos.X := X;
    ICMRight.mPos.Y := Y;
  end;
end;


function TGenericTDCInterface.DeleteTrack(const tFCID: byte): boolean;
var findTrack: integer;
  baru: boolean;
  mTrack: TManualTrack;
begin
  result := False;

  FindToBeDeletedTrack(baru, findTrack);
  if baru then begin
    if findTrack > -1 then TrackList.popObject(findTrack);
    result := True;
  end
  else begin
    if findtrack > -1 then begin
      mTrack := TManualTrack(TrackList.getObject(findTrack));
      mTrack.SetDeAssign_FC_WCC(tFCID);
      result := True;
    end;
  end;
end;


function TGenericTDCInterface.FindToBeDeletedTrack(var IsNew: boolean;
  var indx: Integer): boolean;
var i: integer;
    list: TList;
    aMtrack: tManualTrack;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := FALSE;
  IsNew := True;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    result := (aMtrack.IsNewlyCreated = True)
        and (aMtrack.HasBeenTracked = True);
    indx := i;
    dec(i);
  end;

  if not Result then begin
    indx := -1;
    i := list.Count-1;
    IsNew := False;
    while not result and (i>=0) do begin
      aMtrack := list.Items[i];
      result := (aMtrack.HasBeenTracked = True);
      indx := i;
      dec(i);
    end;
  end;
  TrackList.ReturnList;

  if not result then indx := -1;
end;


procedure TGenericTDCInterface.OCC_AssignFC(aRec : TRecOrderAssignment);
var detObj: TDetectedObject;
begin
  detObj := ActiveRadar.DetObjects.FindObjectByUid(arec.DetectedUID) as TDetectedObject;

  FC4.Detected  := detObj;
  if detObj = nil then exit;

  FC4.TargetUID := aRec.DetectedUID;
  FC4Cursor.Heading := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, detObj.PositionX, detObj.PositionY);
  FC4Cursor.Visible := True;
end;

procedure TGenericTDCInterface.OCC_DeassignFC(aRec : TRecOrderAssignment);
begin
  FC4.Detected := nil;
  FC4.TargetUID := '';
  FC4Cursor.Visible := False;
end;

procedure TGenericTDCInterface.LaunchTorpedoTo(const  sid, tn: byte);
var findObj: boolean;
begin
  findObj := FindTrack_by_trackID(sid, tn, mTrack);

  if findObj then begin
    trackTorped := TTorpedoTrack.Create;
    trackTorped.CreateDefaultView(Fmap);

    trackTorped.SetPosition( xSHIP.PositionX, xSHIP.PositionY);

    trackTorped.Target.Speed    := mTrack.Speed;
    trackTorped.Target.Course   := mTrack.Course;
    trackTorped.Target.Distance := CalcRange(xSHIP.PositionX, xSHIP.PositionY,
      mTrack.PositionX, mTrack.PositionY);
    trackTorped.Target.Bearing  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
      mTrack.PositionX, mTrack.PositionY);

    trackTorped.Speed := 24;
    trackTorped.Tube := TTube(Random(2));  //ttPort;

    trackTorped.TargetTrack := mTrack;

    trackTorped.CalcPHP;

    trackTorped.Enabled := TRUE; // tembak dari tocos
    TorpedoList.AddObject(trackTorped);
  end;

end;


function TGenericTDCInterface.DeleteTorpedoPHP(const pt: TPoint): boolean;
begin

end;

procedure TGenericTDCInterface.UpdateTorpedoPosition;
var i: integer;
    l : TList;
begin
  l := TorpedoList.GetList;

  for i := 0 to l.Count-1 do begin
    trackTorped := l[i];
    if not trackTorped.Launched then
      trackTorped.SetPosition(xSHIP.PositionX, xSHIP.PositionY );

  end;
  TorpedoList.ReturnList;
end;

procedure TGenericTDCInterface.DataRequest(const b: byte);
begin
end;

{procedure TGenericTDCInterface.DataRequest_Left(const b: byte);
begin // ini buat sendiri2 tiap kapal dulu.
end;

procedure TGenericTDCInterface.DataRequest_right(const b: byte);
begin // ini buat sendiri2 tiap kapal dulu.
end;

procedure TGenericTDCInterface.DR_OBM_right(const b: Boolean);
begin
end;

procedure TGenericTDCInterface.DR_OBM_left(const b: Boolean);
begin
end;

procedure TGenericTDCInterface.DR_OCM_right;
begin
end;

procedure TGenericTDCInterface.DR_OCM_left;
begin
end;
}
function TGenericTDCInterface.GetLastTrackID(td: TTrackDomain): byte;
begin
  result := 0;
{ separated domain
  inc(ltid[td]);
  if ltid[td] >= 24 then
      ltid[td] :=  1;
}
  case td of
    tdUdara, tdEW, tdCursor, tdPointAir  : begin
      inc(ltid[tdUdara]);
      if ltid[tdUdara] >= 24 then
        ltid[tdUdara] :=  1;
      result := C_START_TRACKNUM_UDARA + ltid[tdUdara];
    end;

    tdAtasAir, tdRP : begin
      inc(ltid[tdAtasAir]);
      if ltid[tdatasAir] >= 24 then
        ltid[tdAtasAir] :=  1;

      result := C_START_TRACKNUM_ATASAIR + ltid[tdAtasAir];
    end;

    tdBawahAir, tdDatum, tdPointASW : begin
      inc(ltid[tdBawahAir]);
      if ltid[tdBawahAir] >= 24 then
        ltid[tdBawahAir] :=  1;

      result := C_START_TRACKNUM_BAWAHAIR + ltid[tdBawahAir];
    end;
  end;
end;

procedure TGenericTDCInterface.SetLastTrackID(const td: TTrackDomain; const newLtid: byte);
begin
   case td of
     tdUdara, tdEW, tdCursor    :
        ltid[tdUdara]   := newLtid - C_START_TRACKNUM_UDARA;
     tdAtasAir  :
        ltid[tdAtasAir] := newLtid - C_START_TRACKNUM_ATASAIR;
     tdBawahAir, tdDatum :
        ltid[tdBawahAir] := newLtid - C_START_TRACKNUM_BAWAHAIR;

   end;
end;

procedure TGenericTDCInterface.AddGameLog(s: string);
begin
  if Assigned(frmLog) then frmLog.AddLog(s);
end;

function TGenericTDCInterface.InitiateDATUM(var dtm: TDatumTrack; const x, y: double): boolean;
var td: TTrackDomain;
begin
  td := tdDatum;
  if SystLoad[td].Count < SystLoad[td].Capacity then begin
    SystLoad[td].Count := SystLoad[td].Count + 1;
    dtm := TDatumTrack.Create;
    dtm.SetPosition(X, Y);
    dtm.CreateDefaultView(FMap);

    dtm.Enabled := false; //enable FOC
    dtm.Speed := 10;
    dtm.Domain := tdDatum;

    TrackList.AddObject(dtm);
    result := TRUE;
  end
  else begin
    result := FALSE;
  end;
end;

{procedure TGenericTDCInterface.DeleteDatumTrack(var trck: TTDCTrack);
begin
  if SystLoad[tdDatum].Count > 0 then
    SystLoad[tdDatum].Count := SystLoad[tdDatum].Count - 1;

  trck.MarkAs_NeedToBeFree;
end;
}

function TGenericTDCInterface.InitiateESMFix(const x, y: double; const tid: byte): boolean;
var td: TTrackDomain;
begin
  td := tdEW;
  if SystLoad[td].Count < SystLoad[td].Capacity then begin
    SystLoad[td].Count := SystLoad[td].Count + 1;
    cTrack := TESMFixTrack.Create;
    cTrack.SetPosition(X, Y);
    cTrack.CreateDefaultView(FMap);
    cTrack.SetTrackNumber(shipt_tid, tid);
    cTrack.Domain := tdEW;

    TrackList.AddObject(cTrack);
  end

end;

function TGenericTDCInterface.InitiateRefPos(const x, y: double; const tid: byte): boolean;
var td: TTrackDomain;
begin
  td := tdRP;
  result := false;

  if SystLoad[td].Count < SystLoad[td].Capacity then begin
    SystLoad[td].Count := SystLoad[td].Count + 1;

    cTrack := TRefPosTrack.Create;
    cTrack.SetPosition(X, Y);
    cTrack.CreateDefaultView(FMap);
    cTrack.SetTrackNumber(shipt_tid, tid);
    cTrack.Domain := tdRP;

    TrackList.AddObject(cTrack);
    result := true;
  end

end;


procedure TGenericTDCInterface.SetBackTracking(const v: boolean; var mTrack : TManualTrack);
begin
  if v then begin
    if mTrack.Domain = tdAtasAir then begin
      if BKTSurface.Count < BKTSurface.Capacity then begin
        if not mTrack.HistoryVisible then begin
          BKTSurface.Count := BKTSurface.Count + 1;
          mTrack.HistoryVisible := TRUE;
        end

      end;
    end
    else if mTrack.Domain = tdBawahAir then  begin
      if BKTSubSurface.Count < BKTSubSurface.Capacity then begin
        if not mTrack.HistoryVisible then begin
          BKTSubSurface.Count := BKTSubSurface.Count + 1;
          mTrack.HistoryVisible := TRUE;
        end;
      end;

    end;
  end
  else begin
    if mTrack.Domain = tdAtasAir then begin
      if mTrack.HistoryVisible then begin
        if BKTSurface.Count > 0 then
          BKTSurface.Count := BKTSurface.Count - 1;
        mTrack.HistoryVisible := FALSE;
      end;
    end
    else if mTrack.Domain = tdBawahAir then  begin
      if mTrack.HistoryVisible then begin
        if BKTSubSurface.Count > 0 then
          BKTSubSurface.Count := BKTSubSurface.Count - 1;
          mTrack.HistoryVisible := FALSE;
      end;
    end;

  end;
end;
procedure TGenericTDCInterface.SetBackTrackOnPos(const v: boolean; const x, y: integer;
     const send: boolean= true);
begin
  if not FindTrack_by_screenpos(x, y, cTrack) then exit;
  if not(cTrack is TManualTrack) then exit;
  mTrack := cTrack as TManualTrack;
  SetBackTracking(v, mTrack);

end;
procedure TGenericTDCInterface.SetDeadRecon(const v: boolean; const x,
  y: double);
begin
   if v then begin
     tdcData.DeadReconEnable := true;

     xSHIP.PositionX := x;
     xSHIP.PositionY := y;
     xSHIP.Heading := tdcData.SeaCurrent.Course;
     xSHIP.Speed   := tdcData.SeaCurrent.Speed;

   end
   else begin
     tdcData.DeadReconEnable := false;
     xSHIP.Heading := 0;
     xSHIP.Speed   := 0;

   end
end;

function TGenericTDCInterface.initiateSurfaceGrid(const x,
  y: double): boolean;
begin
  result := false;
  if Assigned(SGO) then exit;

  SGO := TSurfaceGrid.Create;
  SGO.CreateDefaultView(FMap);
  SGO.Enabled := true;
  SGO.Symbol.Visible := true;
  SGO.PositionX := x;
  SGO.PositionY := y;

  TrackList.AddObject(SGO);
  result := true;
end;

procedure TGenericTDCInterface.setRelatifWind(const rCourse, rSpeed: double
  );
var rw, sh : tVect2D;
begin
  rw.Speed  := rSpeed;
  rw.Course := rCourse;
  sh.Speed  := xSHIP.Speed;
  sh.Course := xSHIP.Heading;

  tdcData.FTrueWind := WindRelToTrue(rw, sh );
end;

function TGenericTDCInterface.GetRealtiveWind: tVect2D;
var sh : tVect2D;
begin
  sh.Speed  := xSHIP.Speed;
  sh.Course := xSHIP.Heading;
  result    := WindTrueToRel(tdcData.FTrueWind, sh);
end;

function TGenericTDCInterface.GetTrueWind: tVect2D;
begin
  result := tdcData.FTrueWind;
end;

function TGenericTDCInterface.GetTorpedoTrack(
  var v: TTorpedoTrack): boolean;

var l : TList;
begin
  result := false;
  if TorpedoList.ItemCount < 1 then exit;
  l := TorpedoList.GetList;

  v := l.Items[0];
  result := TRue;


  TorpedoList.ReturnList;
end;


{ merge 080814
function TGenericTDCInterface.InitiateTrack(const aCom: TOrdType_OWA_command; const OBM: TTDC_Symbol): boolean;
var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    ID: char;
    dpt : t2DPoint;
    TrackUID : string;
    aRec: TRecFireControlOrder;
    com: TOrdType_OWA_command;
begin  
  result := false;

  case aDomain of
    tdUdara   : begin
      ID := ID_Udara_Unknown;
      com := InitAir;
    end;
    tdAtasAir : begin
      ID := ID_AtasAir_Unknown;
      com := InitSurf;
    end;
    tdBawahAir: begin
      ID := ID_BawahAir_Unknown;
      com := InitSub;
    end;
  end;

  findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
  if findTrack  and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

    mTrack.Domain := aDomain;mTrack.SetIdent(ID);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
  end;
  if not findTrack then begin
    dpt := ConvertToMap(pt.X, pt.Y);

    CreateDefaultMTrack(mTrack, dPt.X,  dPt.Y);
    mTrack.LastUpdateTime := LastUpdateCounter;
    mTrack.Enabled := TRUE;

    TrackList.AddObject(mTrack);
    aRec.TrackNumber := GetLastTrackID(aDomain);
    aRec.Ship_TID := shipt_tid;

    mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
    mTrack.Domain := aDomain;
    mTrack.SetIdent(ID);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
  end;

  TrackUID := '';
  findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

  if findObj then begin
    mTrack.SetDelay_To_X(ts_auto, detObj);
    TrackUID := detObj.UniqueID;

    aRec.TrackUID     := detObj.UniqueID;
    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.X := mTrack.PositionX;
    aRec.Y := mTrack.PositionY;
  end
  else begin // det object not found.
    aRec.TrackUID     := '';

    if findTrack then begin
      mTrack.SetDelay_To_X(ts_rate_aid, nil);
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X := mTrack.PositionX;
      aRec.Y := mTrack.PositionY;

    end;
  end;

  if send then begin
    aRec.OrderID    := OrdID_init_track;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.FC_number  := 0;
    aRec.FC_command := Byte(com);

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;

 //   mTrack.Domain := td;
end;
}


function TGenericTDCInterface.InitiateTrack(const aCom: TOrdType_OWA_command; const OBM: TTDC_Symbol): boolean;
var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    aRec: TRecXXXOrder;
begin
  result := false;

  findObj := ActiveRadar.FindDetectedObjectByView(OBM.Center.X, OBM.Center.Y, detObj);

  if findObj then
    aRec.TrackUID     := detObj.UniqueID
  else  // det object not found.
    aRec.TrackUID     := '';

  aRec.OrderID    := OrdID_init_track;
  aRec.ShipID     := xSHIP.UniqueID;

  aRec.Ship_TID     := shipt_tid;
  aRec.TrackNumber  := 255;
  aRec.X := OBM.mPos.X;
  aRec.Y := OBM.mPos.Y;

  aRec.temp1 := Byte(aCom);
  aRec.temp2 := TDCNumber;    //createdbyhdc

  netSend.sendDataEx(C_REC_XXX_ORDER, @aRec );
end;

procedure TGenericTDCInterface.RecvInitiateTrack(aRec: TRecXXXOrder);
var sim : TSimulationClass;
    detObj : TDetectedObject;
    findObj : boolean;
    findTrack : boolean;
    td : TTrackDomain;
    ID : char;
    com : TOrdType_OWA_command;
    iTrack : TManualTrack;
begin
  com := TOrdType_OWA_command(aRec.temp1);

  case com of
    InitAir: begin
      td := tdUdara;
      ID := ID_Udara_Unknown;
    end;
    InitSurf: begin
      td := tdAtasAir;
      ID := ID_AtasAir_Unknown;
    end;
    InitSubRT, InitSubNRT: begin
      td := tdBawahAir;
      ID := ID_BawahAir_Unknown;
    end;
  end;

  aRec.TrackNumber  :=  GetLastTrackID(td);
  SetLastTrackID(td, aRec.TrackNumber);
  aRec.ShipID       := xSHIP.UniqueID;
  aRec.Ship_TID     := shipt_tid;

  CreateDefaultMTrack(iTrack, aRec.X, aRec.Y);

  if InitMTrackIdent(iTrack, id) then
    iTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber)
  else exit;

  iTrack.SetAmplifyingInfo_1(aiATRA);

  if com = InitSubRT then
    iTrack.SetDelay_To_X(ts_rate_aid, nil)
  else if com = InitSubNRT then
    iTrack.SetDelay_To_X(ts_dr, nil)
  else begin
    detObj := nil;
    sim  := ActiveRadar.DetObjects.FindObjectByUid(aRec.TrackUID);
    if (sim is TDetectedObject) then
      detObj := (sim as TDetectedObject);
    findObj := detObj <> nil;

    if findObj then
      iTrack.SetDelay_To_X(ts_auto, detObj)
    else
      iTrack.SetDelay_To_X(ts_rate_aid, nil);
  end;

  iTrack.CreatedByHDC := aRec.temp2;
  iTrack.SetTrackOrigin(toLocal);
end;

function TGenericTDCInterface.AssignLocRT(aRec: TRecXXXOrder; const send: boolean= True): boolean;
var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    ts: TTrackingState;
    pt: TPoint;
    iTrack: TManualTrack;
begin
  result := false;

  // AT/RA -> AT
  // AT -> RA
  if send then begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);

    if not findTrack then exit;

    if findTrack  and (cTrack is TManualTrack) then
        iTrack := (cTrack as TManualTrack);

    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

    if findObj then
      aRec.TrackUID     := detObj.UniqueID
    else
      aRec.TrackUID     := '';

    aRec.Ship_TID     := iTrack.ShipTrackId;
    aRec.TrackNumber  := iTrack.TrackNumber;
    aRec.X := iTrack.PositionX;
    aRec.Y := iTrack.PositionY;

    //temp1 : FC_Command
    //temp2 : track state
    //temp3 : createdby

    aRec.OrderID    := OrdID_init_track;
    aRec.ShipID     := xSHIP.UniqueID;
    aRec.temp1      := Byte(AssLocRT);
    aRec.temp2      := Byte(iTrack.GetTrackingState);
    aRec.temp3      := TDCNumber;

    netSend.sendDataEx(C_REC_XXX_ORDER, @aRec );
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, iTrack);
    if not findTrack then exit;

    pt := ConvertToScreen(aRec.x, aRec.Y);
    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

    iTrack.SetAmplifyingInfo_1(aiATRA);
    ts := TTrackingState(aRec.temp2);
    case ts of
      ts_dr : iTrack.SetDelay_To_X(ts_rate_aid, nil);     // ke RA
      ts_rate_aid : begin // ke AT
        if findObj then iTrack.SetDelay_To_X(ts_auto, detObj)
        else iTrack.SetDelay_To_X(ts_rate_aid, nil);   // tetep RA
      end;
      ts_auto : iTrack.SetDelay_To_X(ts_rate_aid, nil);   // ke RA
    end;

    iTrack.CreatedByHDC := aRec.temp3;
    iTrack.SetTrackOrigin(toLocal);
  end;
end;

function TGenericTDCInterface.AssignLocNRT(aRec: TRecXXXOrder; const send: boolean= True): boolean;
var findTrack: boolean;
    ts: TTrackingState;
    pt: TPoint;
    iTrack: TManualTrack;
begin
  result := false;

  // AT/RA, AT -> DR
  if send then begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
    if not findTrack then exit;

    if findTrack  and (cTrack is TManualTrack) then
        iTrack := (cTrack as TManualTrack);

    //temp1 : FC_Command
    //temp2 : track state
    //temp3 : createdby

    aRec.Ship_TID     := iTrack.ShipTrackId;
    aRec.TrackNumber  := iTrack.TrackNumber;
    aRec.X := iTrack.PositionX;
    aRec.Y := iTrack.PositionY;

    aRec.OrderID    := OrdID_init_track;
    aRec.ShipID     := xSHIP.UniqueID;
    aRec.temp1      := Byte(AssLocNRT);
    aRec.temp2      := Byte(iTrack.GetTrackingState);
    aRec.temp3      := TDCNumber;

    netSend.sendDataEx(C_REC_XXX_ORDER, @aRec );
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, iTrack);
    if not findTrack then exit;

    ts := TTrackingState(aRec.temp2);
    if (ts = ts_dr) then exit;

    iTrack.SetAmplifyingInfo_1(aiATRA);
    iTrack.SetDelay_To_X(ts_dr, nil);
    iTrack.CreatedByHDC := aRec.temp3;
    iTrack.SetTrackOrigin(toLocal);
  end;
end;

function TGenericTDCInterface.AssignRemote(aRec: TRecXXXOrder; const send: boolean= True): boolean;
var findTrack: boolean;
    ts: TTrackingState;
    pt: TPoint;
    iTrack: TManualTrack;
begin
  result := false;

  // AT/RA, AT -> Remote
  if send then begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
    if not findTrack then exit;

    if findTrack  and (cTrack is TManualTrack) then
        iTrack := (cTrack as TManualTrack);

    //temp1 : FC_Command
    //temp2 : track state
    //temp3 : createdby

    aRec.Ship_TID     := iTrack.ShipTrackId;
    aRec.TrackNumber  := iTrack.TrackNumber;
    aRec.X := iTrack.PositionX;
    aRec.Y := iTrack.PositionY;

    aRec.OrderID    := OrdID_init_track;
    aRec.ShipID     := xSHIP.UniqueID;
    aRec.temp1      := Byte(AssRemote);
    aRec.temp2      := Byte(iTrack.GetTrackingState);
    aRec.temp3      := TDCNumber;

    netSend.sendDataEx(C_REC_XXX_ORDER, @aRec );
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, iTrack);
    if not findTrack then exit;

    //ts := TTrackingState(aRec.temp2);
    //if (ts = ts_dr) then exit;

    iTrack.SetAmplifyingInfo_1(aiATRA);
    iTrack.SetDelay_To_X(ts_rate_aid, nil);
    iTrack.CreatedByHDC := aRec.temp3;
    iTrack.SetTrackOrigin(toRemote);
  end;
end;

procedure TGenericTDCInterface.ReviewFriend_OWA(const aVal: boolean);
var i: integer;
    list: TList;
    ct : TTDCTrack;
    mt : TManualTrack;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  while (i>=0) do begin
    ct := list.Items[i];
    if ct is TManualTrack then begin
      mt := cT as TManualTrack;
      if (mt.GetIdent = ID_Udara_Friendly) or (mt.GetIdent = ID_AtasAir_Friendly) or
        (mt.GetIdent = ID_BawahAir_Friendly) then begin
          mt.ShowPrivateCode(aVal);
      end;
    end;
    dec(i);
  end;
  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.SendLink_OWA(OBM: TTDC_Symbol; const IsSending: boolean);
var aRec: TRecLinkOrder;
    detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    ts: TTrackingState;
begin
  findTrack := FindTrack_by_screenpos(OBM.Center.X, OBM.Center.Y, cTrack);
  if not findTrack then exit;

  if IsSending and (cTrack.GetTrackOrigin = toTransmitted) then exit;
  if (not IsSending) and (cTrack.GetTrackOrigin <> toTransmitted) then exit;

  if findTrack  and (cTrack is TManualTrack) then
      mTrack := (cTrack as TManualTrack);

  findObj := ActiveRadar.FindDetectedObjectByView(OBM.Center.X, OBM.Center.Y, detObj);

  // sending part
  if IsSending then begin
    aRec.OrderID := OrdID_send_link;
    mTrack.SetTrackOrigin(toTransmitted); //lg transmit
  end
  else begin
    aRec.OrderID := OrdID_stop_send_link;
    mTrack.SetTrackOrigin(toLocal);       //stop transmit
  end;

  if findObj then aRec.TrackUID := detObj.UniqueID
  else aRec.TrackUID := '';

  aRec.ShipID     := xSHIP.UniqueID;
  aRec.SenderID   := xSHIP.UniqueID; //kok sama kaya ShipID ya??
                           
  aRec.TrackSymbol  := byte(mTrack.GetIdent);
  aRec.TrackAmp1    := byte(mTrack.GetTrackingState); //AT, RA, or DR
  aRec.TrackAmp2    := byte(mTrack.GetAmpInfo2);     //local ato remote
  aRec.PrivCode     := mTrack.PrivateCode;
  aRec.Ship_TID     := mTrack.ShipTrackId;
  aRec.TrackNumber  := mTrack.TrackNumber;
  aRec.Speed        := mTrack.Speed;
  aRec.Course       := mTrack.Course;
  aRec.X            := mTrack.PositionX;
  aRec.Y            := mTrack.PositionY;
  aRec.Z            := mTrack.PositionZ;

  netSend.sendDataEx(C_REC_LINK_ORDER, @aRec );
end;

procedure TGenericTDCInterface.RecvLink_OWA(aRec: TRecLinkOrder);
var td : TTrackDomain;
    ID, amp2 : char;
    ts : TTrackingState;
    findTrack : boolean;
begin
  // klo sama dg sender, g usah diterima
  if aRec.SenderID = xSHIP.UniqueID then exit;

  if aRec.OrderID = OrdID_send_link then begin
    ID    := Char(aRec.TrackSymbol);
    ts    := TTrackingState(aRec.TrackAmp1);
    amp2  := Char(aRec.TrackAmp2);

    CreateDefaultMTrack(mTrack, aRec.X, aRec.Y);
    if InitMTrackIdent(mTrack, id) then
      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber)
    else exit;
    
    // receive, pasti selalu RA
    mTrack.SetAmplifyingInfo_1(aiATRA);
    mTrack.SetDelay_To_X(ts_rate_aid, nil);

    // receive, pasti remote
    mTrack.SetTrackOrigin(toRemote);
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);

    if findTrack then DeleteMTrack(mTrack);
  end;
end;

procedure TGenericTDCInterface.SwitchTrackPosition(OBM: TTDC_Symbol; const send: boolean= True);
var findObj1, findObj2 : boolean;
    detObj1, detObj2   : TDetectedObject;
    mTrack1, mTrack2   : TManualTrack;
    findTrack : boolean;
    aRec : TRecGunControl;
    pt : TPoint;
begin
  if send then begin
    mTrack1 := selTrack;
    if mTrack1 = nil then exit;

    pt := ConvertToScreen(mTrack1.PositionX, mTrack1.PositionY);
    findObj1 := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj1);

    findTrack := FindTrack_by_ScreenPos(OBM.Center.X, OBM.Center.Y, cTrack);
    if findTrack and (cTrack is TManualTrack) then mTrack2 := (cTrack as TManualTrack);
    if mTrack2 = nil then exit;

    findObj2 := ActiveRadar.FindDetectedObjectByView(OBM.Center.X, OBM.Center.Y, detObj2);

    //Ship_TID    : mtrack1.ShipTrackID
    //TrackNumber : mtrack1.TrackNumber
    //Gun_number  : mtrack2.ShipTrackID
    //AssignedTo  : mtrack2.TrackNumber

    aRec.OrderID := OrdID_SwitchPosition;
    aRec.ShipID  := xSHIP.UniqueID;

    aRec.Ship_TID     := mTrack1.ShipTrackId;
    aRec.TrackNumber  := mTrack1.TrackNumber;
    aRec.Gun_number   := mTrack2.ShipTrackId;
    aRec.AssignedTo   := mTrack2.TrackNumber;

    netSend.sendDataEx(C_REC_GUN_CONTROL, @aRec);

  end;
end;

procedure TGenericTDCInterface.RecvChangeTrackPos(aRec : TRecGunControl);
var findObj1, findObj2 : boolean;
    detObj1, detObj2   : TDetectedObject;
    mTrack1, mTrack2   : TManualTrack;
    findTrack1, findTrack2 : boolean;
    pt : TPoint;
    temp2dPt: t2DPoint;
begin
  //Ship_TID    : mtrack1.ShipTrackID
  //TrackNumber : mtrack1.TrackNumber
  //Gun_number  : mtrack2.ShipTrackID
  //AssignedTo  : mtrack2.TrackNumber

  findTrack1 := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack1);
  if not findTrack1 then exit;

  pt := ConvertToScreen(mTrack1.PositionX, mTrack1.PositionY);
  findObj1 := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj1);

  findTrack2 := FindTrack_by_trackID(aRec.Gun_number, aRec.AssignedTo, mTrack2);
  if not findTrack2 then exit;
                          
  pt := ConvertToScreen(mTrack2.PositionX, mTrack2.PositionY);
  findObj2 := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj2);

  //change position
  mTrack1.Relation := nil;
  mTrack2.Relation := nil;
  temp2dPt.X := mTrack1.PositionX;
  temp2dPt.Y := mTrack1.PositionY;

  mTrack1.SetPosition(mTrack2.PositionX, mTrack2.PositionY);
  mTrack2.SetPosition(temp2dPt.X, temp2dPt.Y);

  if findObj1 then mTrack2.SetDelay_To_X(ts_auto, detObj1)
  else mTrack2.SetDelay_To_X(ts_rate_aid, nil);

  if findObj2 then mTrack1.SetDelay_To_X(ts_auto, detObj2)
  else mTrack1.SetDelay_To_X(ts_rate_aid, nil);
end;

procedure TGenericTDCInterface.SetInitPoint(aRec: TRecOrderXY; const send: boolean=TRUE );
var td: TTrackDomain;
begin
  if Send then begin
    aRec.ShipID     := xSHIP.UniqueID;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec );
  end
  else begin
    td := TTrackDomain(aRec.OrderType);
    InitiatePoint(ptTrack, td, aRec.X, aRec.Y);
  end;
end;

function TGenericTDCInterface.InitiatePoint(var ptt: TPointTrack; var td: TTrackDomain; const x, y: double): boolean;
var cID: char;
    sLabel: string;
begin
  sLabel:= '';
  case td of
    tdPointGen : begin
       cID := ID_Gen_SpecPoint;
      sLabel := 'GEN';
    end;

    tdPointAir : begin
      cID := ID_Air_SpecPoint;

  //    sLabel:
    end;
    tdPointASW : exit;
    tdPointEW : begin
      td :=  tdEW;
      cID := ID_EW_SpecPoint;
    end;
  end;

  if SystLoad[td].Count < SystLoad[td].Capacity then begin
    SystLoad[td].Count := SystLoad[td].Count + 1;
    ptt := TPointTrack.Create;
    ptt.SetPosition(X, Y);
    ptt.CreateDefaultView(FMap);

    ptt.SetIdent(cID);
    ptt.SetLabel(sLabel);
    ptt.Enabled := false;
    ptt.Domain := td;

    TrackList.AddObject(ptt);
    result := TRUE;
  end
  else begin
    result := FALSE;
  end;
end;

procedure TGenericTDCInterface.SetOBM_NextTrack_OWA(OBM: TTDC_Symbol);
var repCount  : integer;
    list      : TList;
begin
  list := TrackList.GetList;
  if list.Count > 0 then begin
    repCount := 0;
    repeat
      FTrackIndex := (FTrackIndex + 1) mod list.Count;
      mTrack    := list.Items[FTrackIndex];
      inc(repCount);
    until (mTrack.CreatedByHDC = TDCNumber) or (repCount=list.Count);
    TrackList.ReturnList;

    if mTrack.CreatedByHDC = TDCNumber then begin

      OBM.mPos.X   := mTrack.PositionX;
      OBM.mPos.Y   := mTrack.PositionY;
      ConvertViewPosition;

      selTrack := mTrack;
    end;
  end;
end;

procedure TGenericTDCInterface.SetTrackInLostMode(aRec: TRecFireControlOrder; const send: boolean= True);
var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    ts: TTrackingState;
    pt: TPoint;
begin
  if send then begin
    pt := ConvertToScreen(aRec.x, aRec.Y);
    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);

    if not findTrack then exit;

    if findTrack and (cTrack is TManualTrack) then
        mTrack := (cTrack as TManualTrack);

    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

    if findObj then
      aRec.TrackUID     := detObj.UniqueID
    else
      aRec.TrackUID     := '';

    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.X := mTrack.PositionX;
    aRec.Y := mTrack.PositionY;

    aRec.OrderID    := OrdID_TrackLost;
    aRec.ShipID     := xSHIP.UniqueID;

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack);

    if not findTrack then exit;

    pt := ConvertToScreen(aRec.x, aRec.Y);
    findObj := ActiveRadar.FindDetectedObjectByView(pt.X, pt.Y, detObj);

    if findObj then mTrack.Relation := nil;

    mTrack.IsLost := True;
  end;
end;

procedure TGenericTDCInterface.GetCourseSpeedSubTrack(OBM: TTDC_Symbol; var c, s: double);
var findTrack: boolean;
begin
  findTrack := FindTrack_by_screenpos(OBM.Center.X, OBM.Center.Y, cTrack);
  if not findTrack then exit;
  if cTrack is TManualTrack then mTrack := (cTrack as TManualTrack);

  if mTrack.Domain <> tdBawahAir then exit;

  c := mTrack.FCorrCourse;
  s := mTrack.FCorrSpeed;
end;

procedure TGenericTDCInterface.CorrelateOrDecorelateTrack(OBM: TTDC_Symbol; const send: boolean= True);
var mTrack1, mTrack2   : TManualTrack;
    findTrack : boolean;
    aRec : TRecGunControl;
begin
  if send then begin
    findTrack := FindTrack_by_ScreenPos(OBM.Center.X, OBM.Center.Y, cTrack);
    if findTrack and (cTrack is TManualTrack) then mTrack2 := (cTrack as TManualTrack);
    if mTrack2 = nil then exit;

    // klo correlate
    if (mTrack2.GetTrackOrigin = toLocal) or (mTrack2.GetTrackOrigin = toRemote) then begin
      mTrack1 := selTrack;
      if mTrack1 = nil then exit;

      aRec.OrderID := OrdID_correlate_track;
      aRec.ShipID  := xSHIP.UniqueID;
      aRec.Ship_TID     := mTrack1.ShipTrackId;
      aRec.TrackNumber  := mTrack1.TrackNumber;
      aRec.Gun_number   := mTrack2.ShipTrackId;
      aRec.AssignedTo   := mTrack2.TrackNumber;

      netSend.sendDataEx(C_REC_GUN_CONTROL, @aRec);
    end
    else if mTrack2.GetTrackOrigin = toCorrelated then begin // klo de-correlate
      aRec.OrderID := OrdID_decorrelate_track;
      aRec.ShipID  := xSHIP.UniqueID;

      aRec.Ship_TID     := mTrack2.ShipTrackId;
      aRec.TrackNumber  := mTrack2.TrackNumber;

      netSend.sendDataEx(C_REC_GUN_CONTROL, @aRec);
    end;

    //kosongkan seltrack
    selTrack := nil;
  end;
end;

procedure TGenericTDCInterface.RecvCorrelateTrack(aRec : TRecGunControl);
var mTrack1, mTrack2, corTrack, locTrack, remTrack: TManualTrack;
    findTrack1, findTrack2 : boolean;
    temp2dPt: t2DPoint;
    r, b: double;
    dt: TCorrelatedData;
begin
  //Ship_TID    : mtrack1.ShipTrackID
  //TrackNumber : mtrack1.TrackNumber
  //Gun_number  : mtrack2.ShipTrackID
  //AssignedTo  : mtrack2.TrackNumber

  findTrack1 := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack1);
  if (not findTrack1) or (mTrack1.GetTrackOrigin = toTransmitted) or (mTrack1.GetTrackOrigin = toCorrelated) then exit;

  findTrack2 := FindTrack_by_trackID(aRec.Gun_number, aRec.AssignedTo, mTrack2);
  if (not findTrack2) or (mTrack2.GetTrackOrigin = toTransmitted) or (mTrack2.GetTrackOrigin = toCorrelated) then exit;

  if (mTrack1.Domain <> mTrack2.Domain) or (mTrack1.GetTrackOrigin = mTrack2.GetTrackOrigin) or
    (mTrack1.Domain = tdBawahAir) or (mTrack2.Domain = tdBawahAir) then exit;

  r := CalcRange(mTrack1.PositionX, mTrack1.PositionY, mTrack2.PositionX, mTrack2.PositionY);
  if (r > (FCorrelationBoxRange / 2)) then exit;

  if (mTrack1.GetTrackOrigin = toLocal) then begin
    locTrack := mTrack1;
    remTrack := mTrack2;
  end
  else begin
    remTrack := mTrack1;
    locTrack := mTrack2;
  end;

  temp2dPt.X := remTrack.PositionX;
  temp2dPt.Y := remTrack.PositionY;

  dt.LocShipTrackId := locTrack.ShipTrackId;
  dt.LocTrackNumber := locTrack.TrackNumber;
  dt.TrackState := locTrack.GetTrackingState;
  dt.PosX := locTrack.PositionX;
  dt.PosY := locTrack.PositionY;

  //create correlated track
  CreateDefaultMTrack(corTrack, temp2dPt.X, temp2dPt.Y);

  if InitMTrackIdent(corTrack, locTrack.GetIdent) then
    corTrack.SetTrackNumber(remTrack.ShipTrackId, remTrack.TrackNumber)
  else exit;
  
  corTrack.SetAmplifyingInfo_1(aiATRA);
  corTrack.SetDelay_To_X(ts_rate_aid, nil);

  //corTrack.CreatedByHDC := aRec.temp2;
  corTrack.SetTrackOrigin(toCorrelated);
  corTrack.FCorrelatedData := dt;

  locTrack.MarkAs_NeedToBeFree;
  remTrack.MarkAs_NeedToBeFree;
end;

procedure TGenericTDCInterface.RecvDecorrelateTrack(aRec : TRecGunControl);
var corTrack, locTrack, remTrack: TManualTrack;
    findTrack : boolean;
    temp2dPt : t2DPoint;
    dt : TCorrelatedData;
begin
  //Ship_TID    : mtrack1.ShipTrackID
  //TrackNumber : mtrack1.TrackNumber

  findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, corTrack);
  if (not findTrack) or (corTrack.GetTrackOrigin <> toCorrelated) then exit;
  
  dt := corTrack.FCorrelatedData;

  //create local track
  CreateDefaultMTrack(locTrack, dt.PosX, dt.PosY);
  if InitMTrackIdent(locTrack, corTrack.GetIdent) then
    locTrack.SetTrackNumber(dt.LocShipTrackId, dt.LocTrackNumber)
  else exit;

  locTrack.SetAmplifyingInfo_1(aiATRA);
  locTrack.SetDelay_To_X(ts_rate_aid, nil);

  locTrack.CreatedByHDC := TDCNumber;
  locTrack.SetTrackOrigin(toLocal);

  //create remote track
  CreateDefaultMTrack(remTrack, corTrack.PositionX, corTrack.PositionY);
  if InitMTrackIdent(remTrack, corTrack.GetIdent) then
    remTrack.SetTrackNumber(corTrack.ShipTrackId, corTrack.TrackNumber)
  else exit;

  remTrack.SetAmplifyingInfo_1(aiATRA);
  remTrack.SetDelay_To_X(ts_rate_aid, nil);

  //remTrack.CreatedByHDC := TDCNumber;
  remTrack.SetTrackOrigin(toRemote);

  corTrack.MarkAs_NeedToBeFree;
end;

procedure TGenericTDCInterface.CorrectRAM_OWA(OBM: TTDC_Symbol; const send:boolean= TRUE);
var findObj   : boolean;
    detObj    : TDetectedObject;
    lTrack : TManualTrack;
    aRec : TRecOrderAssignment;
    aRecOrder: TRecTrackOrder;
    r, b,  dt: double;
begin
  lTrack := selTrack;
  if lTrack = nil then exit;

  findObj := ActiveRadar.FindDetectedObjectByView(
    OBM.Center.X, OBM.Center.Y, detObj);

  if send then begin
    aRec.OrderID := OrdID_CorrectRAM;
    aRec.ShipID  := xSHIP.UniqueID;

    aRec.Ship_TID     := lTrack.ShipTrackId;
    aRec.TrackNumber  := lTrack.TrackNumber;

    if findObj then begin
      aRec.DetectedUID := detObj.UniqueID;
      netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @aRec);
    end;

    aRecOrder.OrderID       := OrdID_UpdateTrackPos_Owa;
    aRecOrder.OrderType     := byte(CorrectTrack);
    aRecOrder.ShipID := xSHIP.UniqueID;
    aRecOrder.Ship_TID      := lTrack.ShipTrackId;
    aRecOrder.TrackNumber   := lTrack.TrackNumber;  
    aRecOrder.X   := OBM.mPos.X;
    aRecOrder.Y   := OBM.mPos.Y;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRecOrder);

  end;
end;

procedure TGenericTDCInterface.RePos_OWA(OBM: TTDC_Symbol; const send:boolean= TRUE);
var detObj    : TDetectedObject;
    lTrack : TManualTrack;
    aRecOrder: TRecTrackOrder;
begin
  lTrack := selTrack;
  if lTrack = nil then exit;

  if send then begin
    aRecOrder.OrderID       := OrdID_UpdateTrackPos_Owa;
    aRecOrder.OrderType     := byte(ReposTrack);
    aRecOrder.ShipID        := xSHIP.UniqueID;
    aRecOrder.Ship_TID      := lTrack.ShipTrackId;
    aRecOrder.TrackNumber   := lTrack.TrackNumber;
    aRecOrder.X   := OBM.mPos.X;
    aRecOrder.Y   := OBM.mPos.Y;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRecOrder);
  end;
end;


procedure TGenericTDCInterface.CloseControl_OWA(const pt: TPoint);
var findTrack: boolean;
begin
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);
    case mTrack.Domain of
      tdAtasAir :
        SelTrack_AtasAir := mTrack;
      tdUdara :
        SelTrack_Udara := mTrack;
      tdBawahAir :
        SelTrack_BawahAir := mTrack;
      tdDontCare :
        selTrack := mTrack;
    end;
    selTrack := mTrack;
  end;
end;

{procedure TGenericTDCInterface.RecvTrackRepos_Owa(aRec: TRecTrackOrder);
var  r, b, dt: double;
begin                         //receive correctRAM juga.
  if FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack) then begin
    if mTrack.IsLost then exit;

    mTrack.Course := 0.0;
    mTrack.Speed  := 0.0;

    mTrack.SetPosition(aRec.X, aRec.Y);
    mTrack.LastUpdateTime := LastUpdateCounter;
  end;
end;}

procedure TGenericTDCInterface.RecvUpdateTrackPos_Owa(aRec: TRecTrackOrder);
var  r, b, dt: double;
  com: TOrdType_OWA_command;
begin                         //receive correctRAM juga.
  if FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber, mTrack)  then begin
    if mTrack.IsLost then exit;

    com := TOrdType_OWA_command(aRec.OrderType);

    if (com = ReposTrack) then begin
      mTrack.Speed := 0.0;
      mTrack.Course := 0.0;
    end
    else begin

      dt :=  LastUpdateCounter - mTrack.LastUpdateTime;   // ms
      r := CalcRange(mTrack.LastSetX, mTrack.LastSetY,    // nautical miles
         aRec.X, aRec.Y);

      b := CalcBearing(mTrack.LastSetX, mTrack.LastSetY,
         aRec.X, aRec.Y);

      mTrack.Course := b;
      if dt > 0 then
        mTrack.Speed  := (r * C_HourToMilliSecond)/ dt
      else
        mTrack.Speed  := 0.0;

      if mTrack.Domain = tdBawahAir then begin
        mTrack.FCorrSpeed := mTrack.Speed;
        mTrack.FCorrCourse := mTrack.Course;

        mTrack.Speed := 0.0;
        mTrack.Course := 0.0;
      end;
    end;

    mTrack.SetPosition(aRec.X, aRec.Y);
    mTrack.LastUpdateTime := LastUpdateCounter;
  end;

end;

procedure TGenericTDCInterface.TestSonar;
var aRec: TRecTrackOrder;
begin
  aRec.OrderID       := OrdID_recv_sonar_owa;
  aRec.ShipID        := xSHIP.UniqueID;
  aRec.OrderType     := byte(ID_Sonar_Active);
  aRec.X   := 10;   // range -> mil
  aRec.Y   := 350;  // bearing -> degree
  netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
end;

procedure TGenericTDCInterface.RecvSonarPositionData_OWA(aRec: TRecTrackOrder);
var x,y : double;
  dpt: t2DPoint;
begin
  if snTrack = nil then begin
    snTrack := TManualTrack.Create;
    snTrack.CreateDefaultView(FMap);

    snTrack.MainSymbolVisible    := true;
    snTrack.CourseVisible        := false;
    snTrack.AmpliInfoVisible     := true;
    snTrack.LINKVisible          := false;
    snTrack.TrackNumberVisible   := false;

    snTrack.Enabled := TRUE;
    snTrack.LastUpdateTime := LastUpdateCounter;
    TrackList.AddObject(snTrack);
  end;

  RangeBearingToCoord(aRec.X, aRec.Y, dpt.x, dpt.y);
  x := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
  y := xSHIP.PositionY + dPt.Y * C_NauticalMile_To_Degree;

  snTrack.SetIdent(ID_AcquisitionTrack, 10);
  snTrack.SetAmpInfo_Sonar('Arial', Char(aRec.OrderType), 8);
  snTrack.SetPosition(x, y);
  snTrack.Visibles := true;
end;

procedure TGenericTDCInterface.LaunchTorpedo_OWA(const aDt: TTorpData);
var aRec: TRecTorpedoMK44Order;
begin
  with aRec do begin
    ShipID  := UniqueID_To_dbID(xSHIP.UniqueID);
    OrderID := ORD_3D_TORPEDO_MK44_FIRED;
    mID     := aDt.BarrelID;
    //mISD    := aDt.ISD;
    //mFloor  := aDt.Floor;
    mISD    := 200;
    mFloor  := 200;
    mGyroRunOut := aDt.GyroRunOut;
  end;

  netSend.sendDataEx(REC_3D_TORPEDO_MK44, @aRec);
end;


procedure TGenericTDCInterface.Update_Exocet_Position(const cID: integer; const x, y, heading: double);
begin
  assssm.Enabled  := true;
  if assssm.ExocetID < 0 then
     assssm.ExocetID := cID
  else
    if assssm.ExocetID = cID then begin
      assssm.org.X := X;
      assssm.org.Y := Y;
    end;
end;


procedure TGenericTDCInterface.SetHarpoonEngage(aRec: TRecTrackOrder;
  send: boolean; tag: byte=0);
begin

end;

procedure TGenericTDCInterface.RecvHarpoonSetting(aRec: TRecHarpoonPanelSetting);
begin

end;

procedure TGenericTDCInterface.RecvASRLSetting(aRec: TRecStatus_Console);
begin
//

end;


{ TTDCDataGeneral }

constructor TTDCDataGeneral.Create;
begin
  FOffsetTime := 0.0;
end;


function TTDCDataGeneral.getTrueWind(const dShipCourse, dShip: double): tVect2D;
begin
// TrueTrueRel();

end;


function TTDCDataGeneral.GetLocalTime: TDateTime;
begin
  result := Time()  + FOffsetTime;
end;

procedure TTDCDataGeneral.SetLocalTime(const Value: TDateTime);
begin
  FOffsetTime := Value - Time();
end;


end.





