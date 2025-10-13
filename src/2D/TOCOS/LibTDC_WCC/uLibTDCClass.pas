unit uLibTDCClass;

interface

uses
  MapXLib_TLB,Classes, Windows, Graphics, Forms,   uMapWindow, uLabelDisplay,
  uBaseConstan, uBaseDataType, uTestShip, uLibRadar, uDetected, uLibTDCDisplay,
  uBaseSimulationObject, uLibTDCTracks, uTorpedoTrack,  ufLog, uObjectView,
  uLibTDC_Object,uTDCConstan, uTCPClient, uTCPDataType, SpeedButtonImage;

const
  C_Kanan = ' kanan';
  C_Kiri  = ' kiri';

type
  TocosOperMode = ( mLocal, mLocalwSonar, mRemote);
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

    selTrack, SelTrack_AtasAir, SelTrack_Udara: TManualTrack;

    cTrack  : TTDCTrack;
    mTrack  : TManualTrack;
    dtTrack : TDatumTrack;
    esbTrack: TESMBearingTrack;


    ltid : array [tdAtasAir .. tdDatum] of byte;

    FMainSymbolVisible : boolean;
    FCourseVisible     : boolean;
    FAMPLInfoVisible   : boolean;
    FLINKVisible       : boolean;
    FTrackNumberVisible: boolean;

    CConnect : TCursorTrackConnection;
    FCConnList       : TList;

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
    // - end of titipan -.

    frmTengah,
    frmTechCtrlPanel,
    frmMainCtrlPAnel,
    frmLeftPanel,
    frmBottomPanel     : TfrmMapWindow;

    procedure ShowAllForm; virtual;
    procedure CreateFormss(const num: byte); virtual; abstract;
    procedure SetDefaultLayOut; virtual;
    procedure ShowFormBawahOWA; virtual;
    procedure HideFormBawahOWA; virtual;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertViewPosition;
    procedure Draw(aCnv : TCanvas);

    procedure Run(aDt: double);
    procedure Update;  // update before draw;
    procedure Walk;    // walk is slower than run.

    procedure Initialize; virtual;

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
    procedure DeleteMTrack(var trck: TManualTrack);

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

    LPDTest   : TLPDTest;
    FC4Cursor: THeadingMarker;

    LPDText   : TLPDDisplayText;

//wida
    TOCOSSysON : Boolean;
    tocosMode : TocosOperMode;
    LPDStatus : TLPDStatus;
    TorpTest : TTorpTest;
    torpAssgn : TTube;
    torp_tocos : TObjectContainer; // container torpedo di tocos (max 2)
    TOCOSSim : Boolean;
    lastRangeTorp : Double;
    torpManual : TTorpedoTrack;
//
    TrackList   : TObjectContainer;  // container of TManualTrack
    shipt_tid   : byte;
    FTDCRangeScale : double;
    GunNumber   : integer;
    SelectedThreatAsses : integer;

    SystLoad :  TSysLoad;
    BKTSurface, BKTSubSurface : TRCounter;

    tdcData  :  TTDCDataGeneral;
    SGO      : TSurfaceGrid;
    VecData  : TTDCData_Vectac;

    EngageBox: TEngagementBox;

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

    procedure setAssignASRL(aRec: TRecTrackOrder; const send: boolean= TRUE);
    procedure setDeAssignASRL(aRec: TRecTrackOrder; const send: boolean= TRUE);

    // --- ident;
    procedure Recv_Ident(aRec : TRecTrackOrder);
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

    procedure setAssignSSM(aRec: TRecOrderXY; send: boolean);
    procedure SendUpdateSSM();

    procedure setDeAssignSSM(send: boolean);

    procedure SetAssignTorpedo_MK44(aRec: TRecTrackOrder;
        const send: boolean = TRUE);
    procedure SetDeAssignTorpedo(const send: boolean = TRUE);

    procedure SetAssignTorpedo_SUT(aRec: TRecOrderAssignment;
        const send: boolean = TRUE);
    procedure SetDeassignTorpedo_SUT(aRec: TRecOrderAssignment;const send: boolean = TRUE);

    procedure SetMainSymbolVisible(const aVis: boolean);
    procedure SetCourseVisible(const aVis: boolean);
    procedure SetAMPLInfoVisible(const aVis: boolean);
    procedure SetLINKVisible(const aVis: boolean);
    procedure SetTrackNumberVisible(const aVis: boolean);

    procedure Filter(const atd: TTrackDomain; const aVis: boolean);

    function SetAssign_FC(const aNum: byte; const pt: TPoint; const send:boolean= true): boolean;
    procedure SetDeAssign_FC(const aNum: byte; const send:boolean= true);  // BreakTrack

    procedure RecvAssign_FC(aRec: TRecFireControlOrder);
    procedure RecvDeAssign_FC(aRec: TRecFireControlOrder);

    procedure RecvAssign_GenFiX(aRec: TRecFireControlOrder);
    procedure RecvAssign_BlindBomb(aRec: TRecFireControlOrder);

    procedure SetOpenFire_FC(const aNum: byte; const send:boolean= true);
    procedure SetHoldFire_FC(const aNum: byte; const send:boolean= true);

//    procedure Recv_AssignFC_WCC(aRec: TRecFireControlOrder);
//    function OBM_DeAssignFC(aRec : TRecFireControlOrder; const send: boolean= TRUE): boolean;

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

    procedure LaunchTorpedoTo(const sid, tn: byte);
    procedure LaunchTorpedoSUTTo(const sid, tn: Byte; const dUid: String);
    function DeleteTorpedoPHP(const pt: TPoint): boolean;
    procedure UpdateTorpedoPosition;
    procedure DeleteTorpedoSUTTrack(ttrack: TTorpedoTrack);


    procedure SetLPDText(const v: boolean; s1:string=''; s2: string='');

    procedure DataRequest_Left(const b: byte); virtual;
    procedure DataRequest_Right(const b: byte); virtual;
    procedure DR_OBM_right(const b: Boolean); virtual;
    procedure DR_OBM_left(const b: Boolean); virtual;
    procedure DR_OCM_right; virtual;
    procedure DR_OCM_left; virtual;

    procedure SetBackTracking(const v: boolean; var mTrack : TManualTrack);
    procedure SetBackTrackOnPos(const v: boolean; const x, y: integer;
     const send: boolean= true);

	 procedure SetDeadRecon(const v: boolean; const x, y: double);
//wida
    procedure SetLPDStatus (const v: boolean);
    procedure SetStatus(const i,j : Byte;const tAss: TTube;const status: String);
    procedure ResetStatus;
    procedure SetTorpStatus(aDt : Double);virtual;

// wcc gigih
  public
    FC1, FC2, FC3, FC4: TFireControl;
    FC_Chanel : array[1..4] of TFireControl;
        // ring dimmer
    function FindToBeDeletedTrack(var IsNew: boolean; var indx: Integer): boolean;
    function DeleteTrack(const tFCID: byte): boolean;

    procedure OCC_AssignFC(aRec : TRecOrderAssignment);
    procedure OCC_DeassignFC(aRec : TRecOrderAssignment);

    function GetLastTrackID(td: TTrackDomain): byte;
    procedure SetLastTrackID(const td: TTrackDomain; const newLtid: byte);

    function InitiateDATUM(var dtm: TDatumTrack; const x, y: double): boolean;
//    procedure DeleteDatumTrack(var trck: TTDCTrack);

    function InitiateESMFix(const x, y: double; const tid: byte): boolean;
    function InitiateRefPos(const x, y: double; const tid: byte): boolean;

    function initiateSurfaceGrid(const x, y: double): boolean;

    procedure setRelatifWind(const rCourse, rSpeed: double);
    function GetTrueWind : tVect2D;
    function GetRealtiveWind : tVect2D;

    function GetTorpedoTrack(var v : TTorpedoTrack): boolean;

    procedure SetEngagementBox(const aMode: TEngageStatus);
    function InitiateTrack(const aDomain: TTrackDomain; const pt: TPoint; const send:boolean= true): boolean;
    procedure RecvInitiateTrack(aRec: TRecFireControlOrder);
    procedure CorrectRAM_OWA(aDomain : TTrackDomain; OBM: TTDC_Symbol; const send:boolean= TRUE);
    procedure RePos_OWA(aDomain : TTrackDomain; OBM: TTDC_Symbol; const send:boolean= TRUE);
    procedure CloseControlOWA(aDomain : TTrackDomain; const pt: TPoint);

    procedure Update_Exocet_Position(const cID: integer; const x, y, heading: double);

    function GetTorp_fromTube(tube:TTube;var index:Byte; var torpTrack:TTorpedoTrack):Boolean;
    procedure FireTorp_SUT(aRec : TRecSetTorpedoSUT);
    procedure Update_TorpedoSUT_Position(const cID: integer; const x, y, heading: double; const stat:Byte);
    procedure Update_Bearing_TORP(aRec : TRecSetTorpedoSUT);
    procedure Update_Persistence_TORP(aRec : TRecSetTorpedoSUT);

    //Update Status pada Technical Control Panel : based on Instruktur command
    procedure UpdateButtonTechnical(var button : TSpeedButtonImage; value : Boolean);


  published

    property TrueMotion : boolean read FTrueMotion write SetTrueMotion;

  end;



implementation

uses
  SysUtils, Types, uSimulationManager,
  uBaseFunction, uBaseGraphicProc, uFormUtil, {ufTDCTengah,}
  StrUtils, uTrackFunction;

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

  // wida
  TOCOSSysON := false;
  tocosMode := mLocal;
  LPDTest   := TLPDTest.Create;
  LPDStatus := TLPDStatus.Create;
  TorpTest := TTorpTest.Create;
  torpAssgn := ttPort;
  TOCOSSim := False;
  lastRangeTorp := 0;
  torp_tocos := TObjectContainer.Create;

  //////////////////////////////////////////

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

  FC_Chanel[1] := FC1 ;
  FC_Chanel[2] := FC2 ;
  FC_Chanel[3] := FC3 ;
  FC_Chanel[4] := FC4 ;


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

  BKTSurface.Capacity     := 2;
  BKTSubSurface.Capacity  := 1;

  tdcData := TTDCDataGeneral.Create;

  EngageBox := TEngagementBox.Create;


  if Assigned(frmLog) then
    frmLog.Show;
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


  TorpedoList.ClearObject;
  TorpedoList.Free;

  TrackList.ClearObject;
  TrackList.Free;

  torp_tocos.ClearObject;
  torp_tocos.Free;

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i].Free;
    DisplaySymbols[i] := nil;
  end;

//  Datum.Free;
//  FOC.Free;

  HeadingMarker.Free;
  Cursorss.Free;

  assssm.Free;
//  ESMFixs.Free;

  AssTorpedo.Free;
  BlindArcs.Free;
  LPDTest.Free;
  LPDText.Free;
  LPDStatus.Free;

  EngageBox.Free;


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

  EngageBox.ConvertDataPosition(FMap);
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

  LPDTest.Draw(aCnv);

  {== wida ==}
  if LPDStatus.Visible then
     LPDStatus.Draw(aCnv);

  if TorpTest.Visible then
    TorpTest.Draw(aCnv);
  {==========}
  
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

  if EngageBox.Visible then
    EngageBox.Draw(aCnv);

end;

procedure TGenericTDCInterface.Run(aDt: double);
var ptShip: t2DPoint;
begin

  ptShip.X := xShip.PositionX;
  ptShip.Y := xShip.PositionY;

  HeadingMarker.Org := ptShip;
  HeadingMarker.Heading  := xShip.Heading;
  HeadingMarker.Distance := FTDCRangeScale;

  TrackList.RunAllMemberObject(aDt);

  UpdateTorpedoPosition;
  TorpedoList.RunAllMemberObject(aDt);

  if assssm.Enabled then begin
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

  if LPDStatus.Visible then
    SetTorpStatus(aDt);


{  if php.Enabled and (phpTrack <> nil) then begin
    php.Org.X := phpTrack.PositionX;
    php.Org.Y := phpTrack
    .PositionY;

  end;
}
//  trackTorped.Run(aDt);

  if BlindArcs.Enabled then begin
    BlindArcs.Org := ptShip;
    BlindArcs.Heading := xSHIP.Heading;
    BlindArcs.Distance := 128;
  end;

  if FC4.Detected <> nil then begin
    FC4Cursor.Heading := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
       FC4.Detected.PositionX, FC4.Detected.PositionY);
  end;

  if not tdcData.DeadReconEnable then begin
    tdcData.DeadReconPos.X := xSHIP.PositionX;
    tdcData.DeadReconPos.Y := xSHIP.PositionY;
  end;

  if EngageBox.Visible then
    EngageBox.Run(aDt);
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
  BlindArcs.Distance := 128;
  BlindArcs.Enabled := true;
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
  if Assigned( frmTechCtrlPanel) then frmTechCtrlPanel.Show;
  if Assigned( frmMainCtrlPAnel) then frmMainCtrlPAnel.Show;
  if Assigned( frmLeftPanel    ) then frmLeftPanel    .Show;
  if Assigned( frmBottomPanel  ) then frmBottomPanel  .Show;

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
      ActiveRadar.DetectionRange := 64;
      ActiveRadar.TimeBase.RotationSpeed := 10;
      ActiveRadar.TimeBaseView.SweepWidth := 200;
      ActiveRadar.TimeBaseView.Darkness := 80;

    end;
    rtWM_28 : begin
      ActiveRadar.DetectionRange := 32;
      ActiveRadar.TimeBase.RotationSpeed := 60;
      ActiveRadar.TimeBaseView.SweepWidth := 1000;
      ActiveRadar.TimeBaseView.Darkness := 100;
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
begin
  CentStatus :=  aCCStatus;
  case aCCStatus of
    stCENT          : begin
       FMap.CenterX := xShip.PositionX;
       FMap.CenterY := xShip.PositionY;
    end;
    stOFFCENT       : begin
       FMap.CenterX := OBMLeft.mPos.X ;
       FMap.CenterY := OBMLeft.mPos.Y;
    end;
  end;
end;

procedure TGenericTDCInterface.CentRight_SetStatus(const aCCStatus: TCenter_Status);
begin
  CentStatus :=  aCCStatus;
  case aCCStatus of
    stCENT          : begin
       FMap.CenterX := xShip.PositionX;
       FMap.CenterY := xShip.PositionY;
    end;
    stOFFCENT       : begin
       FMap.CenterX := OBMRight.mPos.X ;
       FMap.CenterY := OBMRight.mPos.Y;
    end;
  end;
end;


procedure TGenericTDCInterface.SetTrueMotion(const Value: boolean);
begin
  FTrueMotion := Value;
//  if not Value then begin
//     FMap.Rotation := 0;
//  end;
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
    pt  : TPoint;
begin  //

  findTrack := FindTrack_by_ScreenPos(X, Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin

    (cTrack as TManualTrack).SetThreadAssesment(SelectedThreatAsses);
    (cTrack as TManualTrack).ThreatAssestVisible := v;
  end;
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

  if not Result then amTrack := nil;
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
  trck.Relation := nil;
  for i := FCConnList.Count-1 downto 0 do begin
    CConnect := FCConnList[i];

    if CConnect.mTrack = trck then begin
      FCConnList.Delete(i);
      CConnect.Free;
    end

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

  td := GetTrackDomainFromIDENT(trck.GetIdent);

  if td in [tdAtasAir, tdUdara, tdBawahAir] then begin
    if SystLoad[td].Count > 0 then
     SystLoad[td].Count := SystLoad[td].Count - 1;
  end;

  trck.MarkAs_NeedToBeFree;
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

procedure TGenericTDCInterface.setAssignASRL
    (aRec: TRecTrackOrder; const send: boolean= TRUE);
var findObj: boolean;
    pt : TPoint;
begin
  pt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);
    if Send then begin
      aRec.ShipID   := xSHIP.UniqueID;
      aRec.OrderID  := OrdID_assign_asrl;
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X  := mTrack.PositionX;
      aRec.Y  := mTrack.PositionY;
      netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec );
    end
    else begin
      mTrack.SetAssignASRL(TRUE);
    end;

  end;
end;

procedure TGenericTDCInterface.setDeAssignASRL
    (aRec: TRecTrackOrder; const send: boolean= TRUE);
var findObj: boolean;
    pt : TPoint;
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
  end;
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
  if TOCOSSysON and ((tocosMode = mLocal) or (tocosMode = mLocalwSonar)) then
      aRec.Ship_TID := 0
  else aRec.Ship_TID     := shipt_tid;
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
      //mTrack.SetTrackNumber(0, aRec.TrackNumber);
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
      mTrack    := list.Items[FTrackIndex_AtasAir];
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
      tdDontCare :
         selTrack := mTrack;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TGenericTDCInterface.Recv_Ident(
      aRec : TRecTrackOrder);
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
    ChangeMTrackIdent(mTrack, tID);
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
var findTrack : boolean;
    pt      : TPoint;
begin

  if send then begin
    pt := ConvertToScreen(aRec.X, aRec.Y);
    findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);

    if findTrack and (cTrack is TManualTrack) then begin
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
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber , mTrack);
    if findTrack then begin
      LaunchTorpedoTo(aRec.Ship_TID, aRec.TrackNumber);
    end

  end;

  AssTorpedo.Direction  := xSHIP.Heading;
  AssTorpedo.Enabled    := TRUE;
  AssTorpedo.Visible    := TRUE;
end;

procedure TGenericTDCInterface.SetAssignTorpedo_SUT(aRec: TRecOrderAssignment;
        const send: boolean = TRUE);
var findTrack,
    findObj   : boolean;
    detObj    : TDetectedObject;
begin

  if send then begin
    findTrack := FindTrack_by_ScreenPos(OBMRight.Center.X, OBMRight.Center.Y, cTrack);
    findObj   := ActiveRadar.FindDetectedObjectByView(OBMRight.Center.X,OBMRight.Center.Y,detObj);

    if findObj then begin
      if findTrack and (cTrack is TManualTrack) then begin
        mTrack := (cTrack as TManualTrack);
        mTrack.Relation := detObj;
        aRec.ShipID  := xShip.UniqueID;
        aRec.OrderID := OrdID_assign_torpedoSUT;
        aRec.DetectedUID  := detObj.UniqueID;
        aRec.Ship_TID     := mTrack.ShipTrackId;
        aRec.TrackNumber  := mTrack.TrackNumber;

        netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @aRec );
      end;
    end;
  end
  else begin
    findTrack := FindTrack_by_trackID(aRec.Ship_TID, aRec.TrackNumber , mTrack);
    if findTrack then begin
        LaunchTorpedoSUTTo(aRec.Ship_TID, aRec.TrackNumber, aRec.DetectedUID);
    end
  end;

  AssTorpedo.Direction  := xSHIP.Heading;
  AssTorpedo.Enabled    := TRUE;
  AssTorpedo.Visible    := TRUE;
end;

procedure TGenericTDCInterface.SetDeassignTorpedo_SUT(aRec: TRecOrderAssignment;
        const send: boolean = TRUE);
begin

  AssTorpedo.Enabled := FALSE;
  AssTorpedo.Visible := FALSE;

  if send then begin
     aRec.ShipID  := xShip.UniqueID;
     aRec.OrderID := OrdID_deassign_torpedoSUT;
     aRec.DetectedUID := '';
     netSend.sendDataEx(C_REC_ORDER_ASSIGNMENT, @aRec );
  end;
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
  if  (aNum < 1) or (aNum > 4) then exit;

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

      TrackList.AddObject(mTrack);
      case aNum of
         1   :    aRec.TrackNumber := GetLastTrackID(tdUdara);
         2, 3, 4: aRec.TrackNumber := GetLastTrackID(tdAtasAir);// GetLTID_AtasAir;
      end;
      aRec.Ship_TID := shipt_tid;

      mTrack.SetTrackNumber(aRec.Ship_TID, aRec.TrackNumber);
      mTrack.Domain := td;
      mTrack.SetIdent(ID);
      mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
    end;

    r := CalcRange(xShip.PositionX, xSHIP.PositionY, mTrack.PositionX, mTrack.PositionY);
    if r < minRange then begin
      mTrack.SetDelay_To_Automatic(aNum, false,  detObj);
      TrackUID := detObj.UniqueID;
      result := True;
    end
    else begin
      mTrack.SetDelay_To_Manual(aNum, false);
      result := false;
//      exit;  // track out of range.
    end;

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
        1 : aRec.FC_command := Byte(RATO)  ;
        2 : aRec.FC_command := Byte(RSTO)  ;
        3 : aRec.FC_command := Byte(RSTO)  ;
        4 : aRec.FC_command := Byte(RSTO)  ; // cek lagi.
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


procedure TGenericTDCInterface.SetDeAssign_FC(const aNum: byte; const send:boolean= true);
var aRec: TRecFireControlOrder;
    trck : TManualTrack;
begin
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
  FC_Chanel[aNum].IsDoingBlindBomb := false;
  FC_Chanel[aNum].IsDoingIndBomb   := false;

  if send then
    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );

end;

procedure TGenericTDCInterface.RecvDeAssign_FC(aRec: TRecFireControlOrder);
var aNum: byte;
begin
  aNum :=  aRec.FC_number;
  if  (aNum < 1) or (aNum > 4) then exit;

  if FC_Chanel[aNum].TrackedTarget <> nil then begin
    FC_Chanel[aNum].TrackedTarget.SetDeAssign_FC(aNum);
    FC_Chanel[aNum].TrackedTarget := nil;
  end;

  FC_Chanel[aNum].IsTracking    := false;
  FC_Chanel[aNum].TargetUID     :=  '';
  FC_Chanel[aNum].Detected      := nil;
  FC_Chanel[aNum].GenFix        := false;
  FC_Chanel[aNum].IsDoingBlindBomb := false;
  FC_Chanel[aNum].IsDoingIndBomb   := false;
	
end;


procedure TGenericTDCInterface.SetHoldFire_FC(const aNum: byte; const send:boolean= true);
var aRec: TRecFireControlOrder;
begin
  if (aNum > 4) or (aNum < 1) then exit;

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
  if (aNum > 4) or (aNum < 1) then exit;

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
begin  //
  if (aRec.FC_number < 2) or (aRec.FC_number > 3)  then exit;

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
  FC2.GenFix := true;
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
    w := 3*(FMap.Width div 4);
    h := FMap.Height div 6;

    LPDText.Left := FMap.Width div 8 ;
    LPDText.Top  := FMap.Height - (FMap.Height div 3) -10;
    LPDText.Width  := w;
    LPDText.Height := h;
    LPDText.Line1 := s1;
    LPDText.Line2 := s2;

  end;
end;


procedure TGenericTDCInterface.SetLPDStatus(const v: Boolean);
begin
  LPDStatus.Visible :=  v;
  if v then begin
    LPDStatus.Left := 1;
    LPDStatus.Top  := 1;
    LPDStatus.Width  := FMap.Width -2;
    LPDStatus.Height := FMap.Height -2;
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
    rct : TRect;
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

procedure TGenericTDCInterface.LaunchTorpedoSUTTo(const sid, tn: Byte; const dUid: String);
var findTrack: boolean;
begin
  findTrack := FindTrack_by_trackID(sid, tn, mTrack);

  if findTrack then begin
    mTrack.UniqueID := dUid;
    trackTorped := TTorpedoTrack.Create;
    with trackTorped do begin
        SetPosition(xSHIP.PositionX, xSHIP.PositionY);
        CreateDefaultView(Fmap);
        TargetTrack := mTrack;

        Target.Speed  := mTrack.Speed;
        Target.Course := mTrack.Course;
        Target.Distance := CalcRange(xSHIP.PositionX, xSHIP.PositionY,
                                        mTrack.PositionX, mTrack.PositionY);
        Target.Bearing  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
                                        mTrack.PositionX, mTrack.PositionY);

        SpeedType := stLow;
        Tube := torpAssgn;
        Depth := 60.0;
        CalcPHP;
        Enabled := false;
    end;

    TorpedoList.AddObject(trackTorped);

    // tocos
    if TOCOSSysON then begin
        if (torp_tocos.GetList.Count <=2) then
            torp_tocos.AddObject(trackTorped);

        if LPDStatus.Visible then begin
            SetStatus(2,0,trackTorped.Tube,IntToStr(Round(trackTorped.RunTime)));
            SetStatus(1,0,trackTorped.Tube,FloatToStr(trackTorped.Depth));
        end;
    end;
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

procedure TGenericTDCInterface.SetStatus(const i,j : Byte;const tAss: TTube;const status: String);
begin
  if (tAss = ttPort) then
    LPDStatus.CPORT[i,j] := status
  else if (tAss = ttStarBoard) then
    LPDStatus.CSTB[i,j] := status;
end;

procedure TGenericTDCInterface.ResetStatus;
var i,j : Integer;
begin
  for i:=0 to 3 do begin
    for j:= 0 to 3 do begin
      LPDStatus.CPORT[i,j] := '';
      LPDStatus.CSTB[i,j]  := ''; 
    end;
  end;
end;

procedure TGenericTDCInterface.SetTorpStatus(aDt: Double);
begin
  // di singa
end;


////////////////////////////////////////////////////////////////////////////////

procedure TGenericTDCInterface.DataRequest_Left(const b: byte);
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

function TGenericTDCInterface.GetLastTrackID(td: TTrackDomain): byte;
begin
  result := 0;
{ separated domain
  inc(ltid[td]);
  if ltid[td] >= 24 then
      ltid[td] :=  1;
 }
  case td of
    tdUdara, tdEW, tdCursor  : begin
      inc(ltid[tdUdara]);
      if ltid[tdUdara] >= 24 then
        ltid[tdUdara] :=  1;
      result := C_START_TRACKNUM_UDARA + ltid[tdUdara];
    end;

    tdAtasAir, tdRP  : begin
      inc(ltid[tdAtasAir]);
      if ltid[tdatasAir] >= 24 then
         ltid[tdAtasAir] :=  1;

      if TOCOSSysON and ((tocosMode = mLocal) or (tocosMode = mLocalwSonar)) then
        result := C_START_TRACKNUM_ATASAIR_TOCOS + ltid[tdAtasAir]
      else
        result := C_START_TRACKNUM_ATASAIR + ltid[tdAtasAir];
    end;

    tdBawahAir, tdDatum : begin
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
     tdAtasAir  : begin
        if TOCOSSysON and ((tocosMode = mLocal) or (tocosMode = mLocalwSonar)) then
           ltid[tdAtasAir] := newLtid - C_START_TRACKNUM_ATASAIR_TOCOS
        else
           ltid[tdAtasAir] := newLtid - C_START_TRACKNUM_ATASAIR;
     end;
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

procedure TGenericTDCInterface.SetEngagementBox(const aMode: TEngageStatus);
begin
  EngageBox.EngageMode := aMode;
  case aMode of
    teTrialReview, teEngage: EngageBox.Visible := true;
    teCeaseEngage: EngageBox.Visible := false;
  end;
  EngageBox.HeadingNorth := CalcBearing(OBMLeft.mPos.X, OBMLeft.mPos.Y, xSHIP.PositionX, xSHIP.PositionY);
  EngageBox.UpdateOrigin(OBMLeft.mPos.X, OBMLeft.mPos.Y, xSHIP.PositionX, xSHIP.PositionY);

end;

function TGenericTDCInterface.InitiateTrack(const aDomain: TTrackDomain; const pt: TPoint; const send:boolean= true): boolean;
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
      com := InitSubRT;
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
{var detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;
    ID: char;
    dpt : t2DPoint;
    TrackUID : string;
    aRec: TRecFireControlOrder;
begin  //beres
  result := false;

  case aDomain of
  tdUdara   : ID := ID_Udara_Hostile;
  tdAtasAir : ID := ID_AtasAir_Hostile;
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
      mTrack.SetDelay_To_X(ts_auto_rate_aid, nil);
      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.X := mTrack.PositionX;
      aRec.Y := mTrack.PositionY;

    end;
  end;

  if send then begin
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.FC_number  := 0;
    aRec.FC_command := Byte(InitTrackSurf);

    //case aNum of
    //    1 : aRec.FC_command := Byte(RATO)  ;
    //    2 : aRec.FC_command := Byte(RSTO)  ;
    //    3 : aRec.FC_command := Byte(RSTO)  ;
    //    4 : aRec.FC_command := Byte(RSTO)  ; // cek lagi.
    //end;

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;

 //   mTrack.Domain := td;}
end;



procedure TGenericTDCInterface.RecvInitiateTrack(aRec: TRecFireControlOrder);
var sim : TSimulationClass;
    detObj: TDetectedObject;
    findObj: boolean;
    findTrack: boolean;

    td : TTrackDomain;
    ID: char;
    //FC : TFireControl;
    //r, minRange: double;
begin  //beres
// kondisi sudah di cek dan valid dari pengirim
//  aRec.OrderID    := OrdID_assign_FC;
//  aRec.ShipID     := xSHIP.UniqueID;
  case aRec.FC_command of
    byte(InitTrackSurf) : begin
      td := tdAtasAir;
      ID := ID_AtasAir_Hostile;
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
    mTrack.SetDelay_To_X(ts_auto, detObj);
  end
  else begin
    mTrack.SetDelay_To_X(ts_auto_rate_aid, nil);  
  end;
end;

procedure TGenericTDCInterface.CorrectRAM_OWA(aDomain : TTrackDomain; OBM: TTDC_Symbol; const send:boolean= TRUE);
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
    tdDontCare: lTrack := selTrack;
  end;

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

    aRecOrder.ShipID := xSHIP.UniqueID;
    aRecOrder.Ship_TID      := lTrack.ShipTrackId;
    aRecOrder.TrackNumber   := lTrack.TrackNumber;
    aRecOrder.OrderID       := OrdID_UpdateTrackPos;
    aRecOrder.X   := OBM.mPos.X;
    aRecOrder.Y   := OBM.mPos.Y;
    netSend.sendDataEx(C_REC_TRACK_ORDER, @aRecOrder);

  end
  else begin
    dt :=  LastUpdateCounter - lTrack.LastUpdateTime;   // ms
    r := CalcRange(lTrack.LastSetX, lTrack.LastSetY,    // nautical miles
       OBM.mPos.X, OBM.mPos.Y);

    b := CalcBearing(lTrack.LastSetX, lTrack.LastSetY,
       OBM.mPos.X, OBM.mPos.Y);

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

    lTrack.SetPosition(OBM.mPos.X, OBM.mPos.Y);

    lTrack.LastUpdateTime := LastUpdateCounter;
  end;
end;

procedure TGenericTDCInterface.RePos_OWA(aDomain : TTrackDomain; OBM: TTDC_Symbol; const send:boolean= TRUE);
var findObj   : boolean;
    detObj    : TDetectedObject;
    lTrack : TManualTrack;
    aRec : TRecOrderAssignment;
    aRecOrder: TRecTrackOrder;
    //r, b,  dt: double;
begin
  lTrack := nil;
  case aDomain of
    tdAtasAir : lTrack := SelTrack_AtasAir;
    tdUdara   : lTrack := SelTrack_Udara;
    tdDontCare: lTrack := selTrack;
  end;

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

    aRecOrder.ShipID := xSHIP.UniqueID;
    aRecOrder.Ship_TID      := lTrack.ShipTrackId;
    aRecOrder.TrackNumber   := lTrack.TrackNumber;
    aRecOrder.OrderID       := OrdID_UpdateTrackPos;
    aRecOrder.X   := OBM.mPos.X;
    aRecOrder.Y   := OBM.mPos.Y;
    //netSend.sendDataEx(C_REC_TRACK_ORDER, @aRecOrder);

  end
  else begin
    if findObj then begin
      lTrack.Relation := detObj;
      lTrack.SetAmplifyingInfo_1(aiAutomaticTrack);
    end
    else begin
      lTrack.Relation := nil;
      lTrack.SetAmplifyingInfo_1(aiRAMTrack);
    end;

    lTrack.SetPosition(OBM.mPos.X, OBM.mPos.Y);

    //lTrack.CourseVisible := false;
    lTrack.Course := 0.0;
    lTrack.Speed  := 0.0;

    lTrack.LastUpdateTime := LastUpdateCounter;
  end;
end;

procedure TGenericTDCInterface.CloseControlOWA(aDomain : TTrackDomain; const pt: TPoint);
var findTrack: boolean;
begin
  findTrack := FindTrack_by_ScreenPos(pt.X, pt.Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);
    case aDomain of
      tdAtasAir :
         SelTrack_AtasAir := mTrack;
      tdUdara :
         SelTrack_Udara := mTrack;
      tdDontCare :
         selTrack := mTrack;
    end;
  end;
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

function TGenericTDCInterface.GetTorp_fromTube(tube:TTube;var index:Byte; var torpTrack:TTorpedoTrack):Boolean;
var
  i :Integer;
  list :TList;
  tR :TTorpedoTrack;
begin
  list := torp_tocos.GetList;
  result := False;

  if (list.Count <= 0) then exit;

  i := list.Count -1;
  while not result and (i>=0) do begin
    tR := list.items[i];
    if (tR.Tube = tube) then begin
       torpTrack := tR;
       index := i;
       Result := true;
    end;
    dec(i);
  end;
  torp_tocos.ReturnList;
end;

procedure TGenericTDCInterface.FireTorp_SUT(aRec : TRecSetTorpedoSUT);
var
  i     : Byte;
  s,t     : String;
  mShip,mTarget : Integer;
  tR    :TTorpedoTrack;
begin
  if not GetTorp_fromTube(torpAssgn,i,tR) then begin
     if Assigned(torpManual)  then
        tR := torpManual;

  end;
  //torpReady.Enabled := True;

  if Assigned(tR) then begin
    tR.Launched := True;
    tR.Enabled := True;

    if not TOCOSSim then begin
      s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
      t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
      TryStrToInt(s,mShip);
      TryStrToInt(t,mTarget);

      aRec.ShipID  := mShip;
      aRec.TargetID:= mTarget;
      aRec.OrderID := ORD_3D_TORPEDO_SUT_FIRED;
      if (torpAssgn = ttPort) then aRec.mLauncherID := 2
      else if (torpAssgn = ttStarBoard) then aRec.mLauncherID := 1;

      aRec.mTorpedoCourse := tR.Course;
      aRec.mTorpedoSpeed := tR.Speed;
      aRec.mTorpedoDepth := tR.Depth * C_Feet_To_Meter;
      /// comment by sam, cek 3D dulu aRec.Predm := Integer(tR.PredMod);

      netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
    end;
  end;
end;

procedure TGenericTDCInterface.Update_TorpedoSUT_Position(const cID: integer; const x, y, heading: double; const stat:Byte);
var i : integer;
    l : TList;
    tube : TTube;
    //aldy
    aRec : TRecSetTorpedoSUT;
    newBearing: Double;
begin
  if ((cID mod 2)= 0) then tube := ttPort
  else tube := ttStarBoard;
  {if cID = 1 then tube := ttStarBoard
  else if cID = 2 then tube := ttPort;}

  l := TorpedoList.GetList;
  for i := 0 to l.Count-1 do begin
    trackTorped := l[i];
    if (trackTorped.Launched) and (trackTorped.Tube = tube)  then begin
      if (stat = 3) then begin // fired
         SetStatus(0, 0, tube, ID_WireRupture);
         DeleteTorpedoSUTTrack(trackTorped);
      end
      else begin
        trackTorped.PositionX := x;
        trackTorped.PositionY := y;
        trackTorped.Course    := heading;

        //set nilai record
        if Assigned(trackTorped) then
        begin
          if (stat = 1) then
          begin
            //dapatkan posisi torpedo dari trackTorped
            //dapatkan posisi target dari trackTorped.Target
            //hitung bearingnya
            if trackTorped.PredMod = mBearingRider then
            begin
              newBearing := CalcBearing(trackTorped.PositionX, trackTorped.PositionY,
                trackTorped.TargetTrack.PositionX, trackTorped.TargetTrack.PositionY);

              aRec.OrderID := ORD_3D_TORPEDO_SUT_UPDATE_BEARING;
              aRec.mTorpedoCourse := newBearing;

              netSend.sendDataEx(ORD_3D_TORPEDO_SUT_UPDATE_BEARING, @aRec);

            end
            else if trackTorped.PredMod = mIntercept then
            begin
              aRec.OrderID := ORD_3D_TORPEDO_SUT_UPDATE_INTERCEPT;

              netSend.sendDataEx(ORD_3D_TORPEDO_SUT_UPDATE_BEARING, @aRec);

            end;

          end;
        end;

      end;
    end;
  end;
  TorpedoList.ReturnList;

end;

procedure TGenericTDCInterface.Update_Bearing_TORP(aRec : TRecSetTorpedoSUT);
var
  i     : Byte;
  s,t     : String;
  mShip,mTarget : Integer;
  tR    :TTorpedoTrack;
begin
  if Assigned(tR) then begin
    tR.Launched := True;
    tR.Enabled := True;

    if not TOCOSSim then begin
      s := StringReplace(xSHIP.UniqueID,'VSL','',[rfReplaceAll]);
      t := StringReplace(tR.TargetTrack.UniqueID,'VSL','',[rfReplaceAll]);
      TryStrToInt(s,mShip);
      TryStrToInt(t,mTarget);

      aRec.ShipID  := mShip;
      aRec.TargetID:= mTarget;
      aRec.OrderID := __ORD_TORPEDOSUT_NAVIGATE;
      if (torpAssgn = ttPort) then aRec.mLauncherID := 2
      else if (torpAssgn = ttStarBoard) then aRec.mLauncherID := 1;

//      aRec.mTorpedoCourse := tR.Course;
//      aRec.mTorpedoSpeed := tR.Speed;
//      aRec.mTorpedoDepth := tR.Depth * C_Feet_To_Meter;
//      /// comment by sam, cek 3D dulu aRec.Predm := Integer(tR.PredMod);

      netSend.sendDataEx(REC_3D_TORPEDO_SUT, @aRec);
    end;
  end;
end;

procedure TGenericTDCInterface.Update_Persistence_TORP(aRec : TRecSetTorpedoSUT);
begin

end;

/// <summary>
/// fungsi untuk update Up Down Button (param 1), dengan nilai param 2
/// true -> Down;
/// false -> Up;
/// </summary>
/// <param name="button">var button yang akan diupdate type: TSpeedButton</param>
/// <param name="value">value untuk mengupdate type : boolean</param>
procedure TGenericTDCInterface.UpdateButtonTechnical(var button : TSpeedButtonImage; value : Boolean);
begin
  if Assigned(button) then
  begin
    button.Down := value;
  end;
end;

procedure TGenericTDCInterface.DeleteTorpedoSUTTrack(ttrack: TTorpedoTrack);
var tube : TTube;
    i    : Byte;
    aRec : TRecOrderAssignment;
begin
  tube := ttrack.Tube;
  ttrack.Enabled := False;

  aRec.Ship_TID    := ttrack.TargetTrack.ShipTrackId;
  aRec.TrackNumber := ttrack.TargetTrack.TrackNumber;

  if not GetTorp_fromTube(tube,i,ttrack) then begin
     if Assigned(torpManual) and (torpManual.Tube = tube)  then begin
        torpManual.visTrackView(False);
        torpManual := nil;
     end;
  end
  else begin
    torp_tocos.popObject(i);
    ttrack.visTrackView(False);
  end;
  DeleteMTrack(ttrack.TargetTrack as TManualTrack);
  if not TOCOSSim then SetDeassignTorpedo_SUT(aRec);
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





