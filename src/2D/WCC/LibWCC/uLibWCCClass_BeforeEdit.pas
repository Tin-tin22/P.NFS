unit uLibWCCClass;

interface

uses
  Dialogs, Classes, Windows, Graphics, Forms,  MapXLib_TLB, uMapWindow, uLabelDisplay,
  uBaseDataType, uTestShip, uLibRadar, uDetected, uLibTDCDisplay,
  uBaseSimulationObject, uTDCConstan, uLibWCCKu,
  ufAScope, uTCPClient,
  uTCPDatatype, uPubProc;

const
  C_Kanan = ' kanan';
  C_Kiri  = ' kiri';

type

  TCursorOrigin_Status = ( stCU_OR_OFFCENT, stCU_OR_CENT );
  TCenter_Status = (stCENT, stOFFCENT);

  TRadar_Type = (rtDA_05, rtWM_28);
  TRadar_Amp  = (raLiner, raLogarithmic);
//  TRadarMTI   = (rMTI, rNON_MTI);


  TAlignPos = (apNone, apLeftTop, apRightTop, apLeftBottom, apRightBottom, apCenter);

    TMoveData = record
      X, Y : double;
      Speed,
      Heading : single;
    end;


  //==============================================================================
  TTDC_Symbol =  class(TCharSymbol)
  public
    mPos      : t2DPoint;  // map position
    Selected  : Boolean;
    Moved     : Boolean;

    constructor Create;
  end;

//==============================================================================
  TDatum = class(TXShip)
  public
    Symbol : TTDC_Symbol;

    constructor Create;
    destructor Destroy;
  end;

//==============================================================================


//==============================================================================
  TGenericTDCInterface = class
  protected
    FTrueMotion: boolean;
    FTrackIndex_AtasAir,
    FTrackIndex_Udara  : integer;
    //FTrackIndex_BawahAir

    SelTrack_AtasAir, SelTrack_Udara : TManualTrack;

    mTrack : TManualTrack;

    ltid_bawahair,
    ltid_udara, ltid_atasair: byte;

    FMainSymbolVisible : boolean;
    FCourseVisible     : boolean;
    FAMPLInfoVisible   : boolean;
    FLINKVisible       : boolean;
    FTrackNumberVisible: boolean;


    function GetLTID_BawahAir: byte;
    function GetLTID_AtasAir: byte;
    function GetLTID_Udara: byte;


    procedure SetTrueMotion(const Value: boolean);

    function ConvertToScreen(const dx, dy: double): TPoint;
    function ConvertToMap(const ix, iy: integer): t2DPoint;

  public
    //Object yg akan dikendalikanTDC
    // - titipan - .
    FMap   :TMap;
    xSHIP  : TXShip;
    ActiveRadar: TClientRadar;
    netSend: TTCPClient;
    // - titipan -.

    frmTengah: TfrmMapWindow; // TForm;

    // panel WCC
    frmWCCAtas1: TForm;
    frmWCCAtas2: TForm;
    frmWCCBawah: TForm;
    frmWCCBawah2: TForm;

    procedure SetLayOut; virtual;
    procedure ShowAllForm; virtual;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertViewPosition;
    procedure Draw(aCnv : TCanvas);

    procedure Run(aDt: double);
    procedure Update;

    procedure Initialize; virtual;

    function FindMarkerByPosition(const pt: TPoint): integer;
    function FindTrackList(const x,y: integer; var aMtrack: tManualTrack): boolean;
    function FindTrackByID(const ID: String; var aMTrack: TManualTrack): boolean;

    procedure CreateDefaultMTrack(var mt: TManualTrack; const x, y: double);
  public // interface to forms
    // Main Display related procedure.
    DisplaySymbols  : array [i_min_marker .. i_max_marker] of TTDC_Symbol;
    SelectedMarkerTool : integer;

    OBMLeft  : TTDC_Symbol;
    OBMRight : TTDC_Symbol;
    ESMFixs  : TTDC_Symbol;

    Datum : TDatum;
    FOC   : tFOC;
    HeadingMarker : THeadingMarker;
    CentStatus    : TCenter_Status;

    CU_ORStatus   : TCursorOrigin_Status;
    Cursorss      : TTDC_Cursor;
    
    BlindArcs : TBlindARCS;

    LPDTest   : TLPDTest;

	  //assssm : TAssignSSMView;
    //php     : THitPointPrediction;
    TrackList :  TObjectContainer;  // container of TManualTrack
    shipt_tid   : byte;
    FTDCRangeScale : double;

    // gigih
    FC1, FC2, FC3: TFireControl;
    Gun1, Gun2, Gun3: TGun;
    BlindArc: TBlindArcs;
    TGM: TTDC_Symbol; // Tracking Gate Marker

    theClient: TTCPClient;

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
    procedure TGM_Reset; //gg

    procedure SetThreadAssesment(const aSecond: integer);

//  Display simbol
    procedure OwnShipMarker_SetPosition(const x, y: double);

    procedure OBMLeft_SetPosition(const x, y: integer);
    procedure OBMRight_SetPosition(const x, y: integer);
    procedure TGM_SetPosition(const x, y: integer); //gg

    procedure CursorSetRange(const r: double);
    procedure CursorSetBearing(const b: double);

    procedure OBMLeft_SetIdent_BawahAir(const tID: char);

    procedure SetBlindARC(const v: boolean);

    procedure SetLPDTest(const v: boolean);
                                 
    //QEK_1_Kiri Interface  for Bawah Air
    procedure SetInitDatum(const init: boolean; const pt: t2DPoint;
      const send: boolean=TRUE );

    procedure setFOCPlus;
    procedure setFOCMinus;

    procedure setAssignASRL;
    procedure setDeAssignASRL;

    // gigih
    procedure SetMainSymbolVisibility(const val: boolean);
    procedure SetTrackNumberVisibility(const val: boolean);
    procedure SetCourseVisibility(const val: boolean);
    procedure SetAmpVisibility(const val: boolean);
    procedure SetLINKVisibility(const val: boolean);
    // Atas Air
    function OBMRight_AssignFC(const tFCID: TFC_ID): boolean;
    function OBMRight_DeAssignFC(const tFCID: TFC_ID): boolean;
    procedure UpdateTargetSymbol(const tFCID: TFC_ID; const sym: Char);
    // Udara
    function OBMLeft_AssignFC: boolean;
    procedure UpdateTGMPosition;

    procedure SetTrackNumber(var aMTrack: TManualTrack);

    procedure Filter(const atd: TTrackDomain; const aVis: boolean);
   
    function TestBlindArc(const Gun: byte; const Tgt: TManualTrack): boolean;
    procedure CreateManTrack;
    function TrackTarget: boolean;

    function AssignGunToFC(const Gun_ID, FC_ID: byte): boolean;

    procedure test;
    procedure SendFireControlData(const tFC_ID: TFC_ID; const Order: byte; const Command: byte);
  published

    property TrueMotion : boolean read FTrueMotion write SetTrueMotion;

  end;

implementation

uses
  SysUtils, Types, uSimulationManager, uSimulationFunction,
  uBaseConstan, uBaseFunction, uBaseGraphicProc,
  ufWCCPanelAtas,
  ufWCCPanelAtas2,
  ufWCCPanelBawah,
  ufWCCPanelBawah2;

var
  Atas: TfrmWCCPanelAtas;
  Atas2: TfrmWCCPanelAtas2;
  Bawah: TfrmWCCPanelBawah;
  Bawah2: TfrmWCCPanelBawah2;

//==============================================================================
{ TOBM_Cursor }

constructor  TTDC_SYMBOL.Create;
begin
  FontName := 'TDCCursor';
  Color := C_defColor;
end;

{ TDatum }
constructor TDatum.Create;
begin
  inherited;
  Symbol  := TTDC_Symbol.Create;
  Symbol.CharSymbol := C_Symbol_Char[i_Datum] ;
  Symbol.Visible := TRUE;
end;

destructor TDatum.Destroy;
begin

  Symbol.Free;

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

  Datum := TDatum.Create;
  Datum.Speed := 0;
  Datum.Enabled := false;
  Datum.Symbol.Visible := FALSE;

  FOC := tFOC.Create;
  FOC.Visible := false;

  HeadingMarker := THeadingMarker.Create;
  HeadingMarker.Visible := false;

  Cursorss := TTDC_Cursor.Create;
  Cursorss.Visible := TRUE;
  CU_ORStatus := stCU_OR_CENT;

  TrackList :=  TObjectContainer.Create;

  ltid_bawahair := 0;
  ltid_udara    := 0;
  ltid_atasair  := 0;

  FTrackIndex_AtasAir := 0;
  FTrackIndex_Udara:= 0;
  SelTrack_AtasAir    := nil;
  SelTrack_Udara      := nil;

  // gigih
  BlindArcs := TBlindARCS.Create;
  BlindArcs.Distance := 128;
  BlindArcs.Enabled := true;

  FMainSymbolVisible := TRUE;
  FCourseVisible     := TRUE;
  FAMPLInfoVisible   := TRUE;
  FLINKVisible       := FALSE;
  FTrackNumberVisible:= TRUE;

  LPDTest   := TLPDTest.Create;

  DisplaySymbols[i_Gerbang_Pelacakan].Visible := TRUE;
  TGM := DisplaySymbols[i_Gerbang_Pelacakan];  // alias
  TGM.Visible := False;

  Atas := TfrmWCCPanelAtas(frmWCCAtas1);
  Atas2 := TfrmWCCPanelAtas2(frmWCCAtas2);
  Bawah := TfrmWCCPanelBawah(frmWCCBawah);
  Bawah2 := TfrmWCCPanelBawah2(frmWCCBawah2);

  theClient := TTCPClient.Create;
  //TheClient.RegisterProcedure(REC_POSITION, onRecPositionAvailable, sizeof(TRecDataPosition));
  //TheClient.RegisterProcedure(REC_SET_CHAFF, nil, sizeof(TRecSetChaff));
  //theClient.setLog(TStringList(Memo1.Lines));
end;

destructor TGenericTDCInterface.Destroy;
var i: integer;
begin
  TrackList.ClearObject;
//  ClearListAndObject(TrackList);
  TrackList.Free;

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i].Free;
    DisplaySymbols[i] := nil;
  end;

  Datum.Free;
  FOC.Free;

  HeadingMarker.Free;
  Cursorss.Free;

  BlindArcs.Free;

  LPDTest.Free;

  inherited;
end;

procedure TGenericTDCInterface.ConvertViewPosition;
begin
  ConvertMembersViewsPosition(TrackList);

  OBMLeft.Center  := ConvertToScreen(OBMLeft.mPos.X, OBMLeft.mPos.Y);
  OBMRight.Center := ConvertToScreen(OBMRight.mPos.X, OBMRight.mPos.Y);

  // gigih
  TGM.Center  := ConvertToScreen(TGM.mPos.X, TGM.mPos.Y);
end;


procedure TGenericTDCInterface.Draw(aCnv : TCanvas);
var i: integer;
begin

  for i := i_min_marker to  i_max_marker do begin
    DisplaySymbols[i].Draw(aCnv);
  end;

  if Datum.Symbol.Visible then
    Datum.Symbol.Center := ConvertToScreen(Datum.PositionX, Datum.PositionY);
  Datum.Symbol.Draw(aCnv);

  foc.ConvertCoord(frmTengah.Map);
  foc.Draw(aCnv);

  HeadingMarker.ConvertCoord(frmTengah.Map);
  HeadingMarker.Draw(aCnv);

  Cursorss.ConvertCoord(frmTengah.Map);
  Cursorss.Draw(aCnv);

  DrawMembersView(TrackList, aCnv);

  if BlindArcs.Visible then begin
    BlindArcs.ConvertCoord(FMap);
    BlindArcs.Draw(aCnv);
  end;

  if LPDTest.Visible then
     LPDTest.Draw(aCnv);
end;

procedure TGenericTDCInterface.Run(aDt: double);
var pt1, pt2,ptShip: t2DPoint;
begin
//  Datum.Run(aDt);
  ptShip.X := xShip.PositionX;
  ptShip.Y := xShip.PositionY;

  if FOC.Enabled then begin
    FOC.Org.X := Datum.PositionX;
    FOC.Org.Y := Datum.PositionY;
    FOC.Run(aDt);
  end;
  HeadingMarker.Org := ptShip;
  HeadingMarker.Heading  := xShip.Heading;
  HeadingMarker.Distance := FTDCRangeScale;

  TrackList.RunAllMemberObject(aDt);

  if BlindArcs.Enabled then begin
    BlindArcs.Org := ptShip;
    BlindArcs.Heading := xSHIP.Heading;
  end;
end;

procedure TGenericTDCInterface.Update;
begin

  TrackList.UpdateAllMemberObject;

end;

procedure TGenericTDCInterface.Initialize;
begin
  OBMLeft_SetPosition( 80, frmTengah.Map.Height shr 1);
  OBMRight_SetPosition( frmTengah.Map.Width - 80, frmTengah.Map.Height shr 1);

  //TGM_SetPosition(90, frmTengah.Map.Height shr 1);
end;

function TGenericTDCInterface.ConvertToScreen(const dx, dy: double): TPoint;
var mx, my : double;
    sx, sy : single;
begin
  mx := dx;
  my := dy;
  frmTengah.Map.ConvertCoord(sx, sy, mx, my, miMapToScreen);
  result.X := Round(sx);
  result.Y := Round(sy);
end;

function TGenericTDCInterface.ConvertToMap(const ix, iy: integer): t2DPoint;
var mx, my : double;
    sx, sy : single;
begin
  sx := ix;
  sy := iy;

  frmTengah.Map.ConvertCoord(sx, sy, mx, my, miScreenToMap);
  result.X := mx;
  result.Y := my;
end;

procedure TGenericTDCInterface.SetLayOut;
var mIx : integer;
begin
  if Screen.MonitorCount > 1 then //MultiMonitor
     mIx := 1
  else
     mIx := 0;

  //frmKiri.Left  := Screen.Monitors[0].BoundsRect.Left;
  //frmKanan.Left := Screen.Monitors[mIx].BoundsRect.Right - frmKanan.Width;
end;

procedure TGenericTDCInterface.ShowAllForm;
begin
  if Assigned(frmWCCBawah2) then frmWCCBawah2.Show;
  if Assigned(frmTengah) then frmTengah.Show;
  if Assigned(frmWCCBawah) then frmWCCBawah.Show;
  if Assigned(frmWCCAtas2) then frmWCCAtas2.Show;
  if Assigned(frmWCCAtas1) then frmWCCAtas1.Show;

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TGenericTDCInterface.GetLTID_BawahAir: byte;
begin
  inc(ltid_bawahair);
  result := C_START_TRACKNUM_BAWAHAIR + ltid_bawahair;
end;

function TGenericTDCInterface.GetLTID_AtasAir: byte;
begin
  inc(ltid_atasair);
  result := C_START_TRACKNUM_ATASAIR + ltid_atasair;
end;

function TGenericTDCInterface.GetLTID_Udara: byte;
begin
  inc(ltid_udara);
  result := C_START_TRACKNUM_UDARA + ltid_udara;
end;

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
  case aRT of
    rtDA_05 : begin
      ActiveRadar.DetectionRange := 64;
      ActiveRadar.TimeBase.RotationSpeed := 10;
    end;
    rtWM_28 : begin
      ActiveRadar.DetectionRange := 32;
      ActiveRadar.TimeBase.RotationSpeed := 60;
    end;
  end;
end;

procedure TGenericTDCInterface.SetRadar_Amplification(
  const aRa: TRadar_Amp);
begin
  //  ActiveRadar.
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
       Cursorss.Org := OBMLeft.mPos;
    end;
    stCU_OR_CENT    :  begin
       Cursorss.Org.X :=  xShip.PositionX;
       Cursorss.Org.Y :=  xShip.PositionY;

    end;
  end;

end;

procedure TGenericTDCInterface.CU_OR_Right_SetStatus(
    const aCCStatus: TCursorOrigin_Status);
begin
  CU_ORStatus := aCCStatus;
  case aCCStatus of
    stCU_OR_OFFCENT : begin
       Cursorss.Org := OBMRight.mPos;

    end;
    stCU_OR_CENT    :  begin
       Cursorss.Org.X :=  xShip.PositionX;
       Cursorss.Org.Y :=  xShip.PositionY;
    end;
    {Cursor Origin Center:
      mengembalikam kedudukan 'titik pangkal cursor origin' ke kedudukan kapal
      sendiri.
    }
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
  if not Value then begin
     FMap.Rotation := 0;
  end;
end;

procedure TGenericTDCInterface.SetThreadAssesment(const aSecond: integer);
begin

end;

function TGenericTDCInterface.FindMarkerByPosition(const pt: TPoint): integer;
const sz = 4;
var found : boolean;
    r : TRect;
begin
  result := i_OBM_kanan;
  found := false;
  //while not found  and ( result <= i_OBM_kiri ) do begin
    while not found  and ( result <= i_Gerbang_Pelacakan ) do begin
    r := PtToRect(DisplaySymbols[result].Center, sz, sz);
    found := PtInRect(r, pt);
    inc(result);
  end;
  if found then
    dec(result)

  else
    result := -1;
end;

function TGenericTDCInterface.FindTrackList(const x,y: integer;
  var aMtrack: tManualTrack): boolean;
var i : integer;
    list: TList;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := false;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    result  := aMtrack.TestViewHit(x, y);
    dec(i);
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.CreateDefaultMTrack(var mt: TManualTrack; const x, y: double);
begin
  mt := TManualTrack.Create;
  mT.PositionX := X;
  mT.PositionY := Y;

  mT.CreateDefaultView(FMap);

  mT.MainSymbolVisible    := FMainSymbolVisible;
  mT.CourseVisible        := FCourseVisible;
  mT.AmpliInfoVisible     := FAMPLInfoVisible;
  mT.LINKVisible          := FLINKVisible;
  mT.TrackNumberVisible   := FTrackNumberVisible;

  mT.Enabled := TRUE;
  TrackList.AddObject(mT);

end;


//=============================================================================
procedure TGenericTDCInterface.OwnShipMarker_SetPosition(const x, y: double);
begin
  DisplaySymbols[i_OwnShip].mPos.X := X;
  DisplaySymbols[i_OwnShip].mPos.Y := Y;

  DisplaySymbols[i_OwnShip].Center := ConvertToScreen(x, y);
end;

procedure TGenericTDCInterface.OBMLeft_SetPosition(const x, y: integer);
begin
  DisplaySymbols[i_OBM_kiri].Center.X := x;
  DisplaySymbols[i_OBM_kiri].Center.Y := y;

  DisplaySymbols[i_OBM_kiri].mPos := ConvertToMap(x, y);

end;

procedure TGenericTDCInterface.OBMRight_SetPosition(const x, y: integer);
begin
  DisplaySymbols[i_OBM_kanan].Center.X := x;
  DisplaySymbols[i_OBM_kanan].Center.Y := y;
  DisplaySymbols[i_OBM_kanan].mPos := ConvertToMap(x, y);
end;

procedure TGenericTDCInterface.OBMLeft_Reset;
begin
  DisplaySymbols[i_OBM_kiri].mPos.X  := xShip.PositionX;
  DisplaySymbols[i_OBM_kiri].mPos.Y  := xShip.PositionY;
  DisplaySymbols[i_OBM_kiri].Center := ConvertToScreen(DisplaySymbols[i_OBM_kiri].mPos.X,
  DisplaySymbols[i_OBM_kiri].mPos.Y)
end;

procedure TGenericTDCInterface.OBMRight_Reset;
begin
  DisplaySymbols[i_OBM_kanan].mPos.X  := xShip.PositionX;
  DisplaySymbols[i_OBM_kanan].mPos.Y  := xShip.PositionY;
  DisplaySymbols[i_OBM_kanan].Center := ConvertToScreen(DisplaySymbols[i_OBM_kanan].mPos.X,
  DisplaySymbols[i_OBM_kanan].mPos.Y)
end;

procedure TGenericTDCInterface.TGM_Reset;
begin
  DisplaySymbols[i_Gerbang_Pelacakan].mPos.X  := xShip.PositionX + 10;
  DisplaySymbols[i_Gerbang_Pelacakan].mPos.Y  := xShip.PositionY + 10;
  DisplaySymbols[i_Gerbang_Pelacakan].Center := ConvertToScreen(DisplaySymbols[i_Gerbang_Pelacakan].mPos.X,
  DisplaySymbols[i_Gerbang_Pelacakan].mPos.Y)
end;

procedure TGenericTDCInterface.CursorSetRange(const r: double);
begin
  Cursorss.Distance := r;
end;
procedure TGenericTDCInterface.CursorSetBearing(const b: double);
begin
  Cursorss.Heading := b;
end;

procedure TGenericTDCInterface.OBMLeft_SetIdent_BawahAir(const tID: char);
var findObj: boolean;
    detObj : TDetectedObject;
    findTrack: boolean;
    tnumb : byte;
begin  //QEK_1_KIRI
  case tID of
    ID_BawahAir_Friendly,
    ID_BawahAir_Hostile,
    ID_BawahAir_Unknown,
    ID_BawahAir_NonSub :  begin

      findTrack := FindTrackList(OBMLeft.Center.X, OBMLeft.Center.Y, mTrack);

      if findTrack then begin
         mTrack.SetIdent(tID);
         mTrack.Domain := tdBawahAir;

      end
      else begin
        CreateDefaultMTrack(mTrack, OBMLeft.mPos.X, OBMLeft.mPos.Y);

        mTrack.SetTrackNumber(shipt_tid, GetLTID_BawahAir);
        mTrack.SetIdent(tID);
        mTrack.Domain := tdBawahAir;
      end;
    end;
  end;
end;

//procedure TGenericTDCInterface.SetInitDatum(const init: boolean);
procedure TGenericTDCInterface.SetInitDatum(
 const init: boolean; const pt: t2DPoint;
 const send: boolean=TRUE );

var aRec: TRecOrderXY;

begin  //QEK_1_KIRI
  Datum.PositionX := pt.X;
  Datum.PositionY := pt.Y;

  Datum.Enabled := init;
  Datum.Symbol.Visible := init;
  Datum.Speed := 0;
  Datum.Heading := 0;

//  FOC.Org := OBMLeft.mPos;
  FOC.Org := pt;
  FOC.SpeedKnot := 15;
  FOC.FDistance := 0;
  FOC.Enabled := FALSE;
  FOC.Visible := TRUE;


  if Send then begin
    //aRec.PC.ID      := C_REC_ORDER_XY;
  //  aRec.PC.Pass    := PACKET_PASS;

    aRec.OrderID    := OrdID_init_datum;
    aRec.OrderType  := 1; // RESERVED FOR DATUM NUMBER;
    aRec.ShipID := xSHIP.UniqueID;

    aRec.X := pt.X;
    aRec.Y := pt.Y;
    netSend.sendDataEx(C_REC_ORDER_XY, @aRec );

  end;
end;

function TGenericTDCInterface.OBMRight_AssignFC(const tFCID: TFC_ID): boolean;
var findObj: boolean;
    detObj: TDetectedObject;
    findTrack: boolean;
    mTrack: TManualTrack;
begin
  result := False;

  case tFCID of
  FC_2: if FC2.TrackedTarget <> nil then Exit;
  FC_3: if FC3.TrackedTarget <> nil then Exit;
  end;

  inc(ltid_atasair);
  findObj := ActiveRadar.FindDetectedObjectByView(OBMRight.Center.X, OBMRight.Center.Y, detObj);
  findTrack := FindTrackList(OBMRight.Center.X, OBMRight.Center.Y, mTrack);
  if findTrack then
  begin
    case tFCID of
    FC_2:
      begin
        mTrack.TrackedBy[indx_FC2] := True;
        FC2.TrackedTarget := mTrack;
      end;
    FC_3:
      begin
        mTrack.TrackedBy[indx_FC3] := True;
        FC3.TrackedTarget := mTrack;
      end;
    end;
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
    mTrack.SetAssign_FC(tFCID);

    result := True;
  end
  else if findObj then
  begin
    mTrack := TManualTrack.Create;
    mTrack.PositionX := OBMRight.mPos.X;
    mTrack.PositionY := OBMRight.mPos.Y;

    mTrack.CreateDefaultView(FMap);
    mTrack.MainSymbolVisible := True;
    mTrack.SetIdent(ID_AtasAir_Unknown);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
    mTrack.SetAssign_FC(tFCID);
    mTrack.SetTrackNumber(shipt_tid, GetLTID_BawahAir);
    mTrack.Domain := tdAtasAir;
    mTrack.Enabled := TRUE;
    mTrack.Relation := detObj;
    TrackList.AddObject(mTrack);

    case tFCID of
    FC_2:
      begin
        mTrack.TrackedBy[indx_FC2] := True;
        FC2.TrackedTarget := mTrack;
      end;
    FC_3:
      begin
        mTrack.TrackedBy[indx_FC3] := True;
        FC3.TrackedTarget := mTrack;
      end;
    end;

    result := True;
  end;


end;

procedure TGenericTDCInterface.setFOCPlus;
begin
  FOC.Enabled := TRUE;
  FOC.SpeedKnot :=   FOC.SpeedKnot + 5;
  if FOC.SpeedKnot > 30 then FOC.SpeedKnot := 30;
end;

procedure TGenericTDCInterface.setFOCMinus;
begin
  FOC.SpeedKnot :=   FOC.SpeedKnot - 5;
  if FOC.SpeedKnot < 0 then FOC.SpeedKnot := 0;
end;

procedure TGenericTDCInterface.setAssignASRL;
var findObj: boolean;
begin
  findObj := FindTrackList(OBMLeft.Center.X, OBMLeft.Center.Y, mTrack);
  if findObj then
      mTrack.SetAssignASRL(TRUE);
end;

procedure TGenericTDCInterface.setDeAssignASRL;
var findObj: boolean;
begin
  findObj := FindTrackList(OBMLeft.Center.X, OBMLeft.Center.Y, mTrack);
  if findObj then
      mTrack.SetAssignASRL(FALSE);

//11  if findObj then
//11      detObj.SetAssignASRL(' ');
end;

procedure TGenericTDCInterface.SetMainSymbolVisibility(const val: Boolean);
var i: integer;
    list : TList;
    obj: TManualTrack;
begin
  list := TrackList.GetList;

  for i := 0 to TrackList.ItemCount - 1 do
  begin
    obj := list.Items[i];
    obj.MainSymbolVisible := val;
  end;
end;

procedure TGenericTDCInterface.SetCourseVisibility(const val: Boolean);
var i: integer;
    list : TList;
    obj: TManualTrack;
begin
  list := TrackList.GetList;

  for i := 0 to TrackList.ItemCount - 1 do
  begin
    obj := list.Items[i];
    obj.CourseVisible := val;
  end;
end;

procedure TGenericTDCInterface.SetAmpVisibility(const val: Boolean);
var i: integer;
    list : TList;
    obj: TManualTrack;
begin
  list := TrackList.GetList;

  for i := 0 to TrackList.ItemCount - 1 do
  begin
    obj := list.Items[i];
    obj.AmpliInfoVisible := val;
    //obj.SetLabelVisibility(id_ampli_info_1, val);
    //obj.SetLabelVisibility(id_ampli_info_2, val);
  end;
end;

procedure TGenericTDCInterface.SetTrackNumberVisibility(const val: Boolean);
var i: integer;
    list : TList;
    obj: TManualTrack;
begin
  list := TrackList.GetList;

  for i := 0 to TrackList.ItemCount - 1 do
  begin
    obj := list.Items[i];
    obj.TrackNumberVisible := val;
  end;
end;

procedure TGenericTDCInterface.SetLINKVisibility(const val: boolean);
var i: integer;
    list : TList;
    obj: TManualTrack;
begin
  list := TrackList.GetList;

  for i := 0 to TrackList.ItemCount - 1 do
  begin
    obj := list.Items[i];
    obj.LinkVisible := val;
  end;
end;

function TGenericTDCInterface.TrackTarget;
var
{  findObj : boolean;
  i: Integer;
  list : TList;
  trackObj: TManualTrack;
  detObj: TDetectedObject;
  trackCent: TPoint;  }

  blind1, blind2, blind3: boolean;
  fAtas2: TfrmWCCPanelAtas2;
  fBawah: TfrmWCCPanelBawah;
  fBawah2: TfrmWCCPanelBawah2;

begin
  fAtas2 := TfrmWCCPanelAtas2(frmWCCAtas2);
  fBawah := TfrmWCCPanelBawah(frmWCCBawah);
  fBawah2 := TfrmWCCPanelBawah2(frmWCCBawah2);
{
  list := TrackList.GetList;
  for i := 0 to TrackList.ItemCount - 1 do
  begin
    trackObj := list.Items[i];
    if trackObj.Relation = nil then
    begin
      trackCent := ConvertToScreen(trackObj.PositionX, trackObj.PositionY);
      findObj := WM_Radar.FindDetectedObjectByView(trackCent.X, trackCent.Y, detObj);

      if findObj then begin
        detObj.Visibles := False;
        trackObj.Relation := detObj;
        trackObj.SetIdent(ID_AtasAir_Hostile);
        //ShowMessage('ketemu ' + FloatToStr(GetLTID_BawahAir));
      end;
    end
    else
    begin
      Form1.lblBearing.Caption := FloatToStr(trackObj.Relation.DetBearing);
      Form1.lblRange.Caption := FloatToStr(trackObj.Relation.DetRange);
    end;
  end;
  }

  if FC2.TrackedTarget <> nil then
  begin

    frmAScope.lblBearing.Caption := FloatToStr(FC2.TrackedTarget.Relation.DetBearing);
    frmAScope.lblRange.Caption := FloatToStr(FC2.TrackedTarget.Relation.DetRange);

    if FC2.TrackedTarget.Relation.DetRange > C_FC2_RANGE then
    begin
      self.OBMRight_DeAssignFC(FC_2);
      //ShowMessage('FC2 loose contact');
    end;
  end
  else
  begin
    frmAScope.lblBearing.Caption := '-';
    frmAScope.lblRange.Caption := '-';
  end;
  if FC3.TrackedTarget <> nil then
  begin

    frmAScope.lblBearing2.Caption := FloatToStr(FC3.TrackedTarget.Relation.DetBearing);
    frmAScope.lblRange2.Caption := FloatToStr(FC3.TrackedTarget.Relation.DetRange);

    if FC3.TrackedTarget.Relation.DetRange > C_FC3_RANGE then
    begin
      self.OBMRight_DeAssignFC(FC_3);
      //ShowMessage('FC2 loose contact');
    end;
  end
  else
  begin
    frmAScope.lblBearing2.Caption := '-';
    frmAScope.lblRange2.Caption := '-';
  end;

  if (Gun1.AssignTo <> nil) and (Gun1.AssignTo.TrackedTarget <> nil) then
  begin
    frmAScope.lblG1To.Caption := Gun1.AssignTo.Name;

    blind1 := self.TestBlindArc(1, Gun1.AssignTo.TrackedTarget);
    if blind1 then
      frmAScope.lblG1Blind.Caption := 'blind'
    else
      frmAScope.lblG1Blind.Caption := 'ok';
    
    if gun1.AssignTo.TrackedTarget.Relation.DetRange < C_GUN1_RANGE then
      frmAScope.lblG1inrange.Caption := 'in range'
    else
      frmAScope.lblG1inrange.Caption := 'out of range';

    if (gun1.AssignTo.TrackedTarget.Relation.DetRange < C_GUN1_RANGE) and (blind1 = false) then
      col.UpdateImage(fBawah2.lmpG1INRANGE, col.greenROUND_On)
    else
      col.UpdateImage(fBawah2.lmpG1INRANGE, col.greenROUND_Off);
  end
  else
  begin
    frmAScope.lblG1To.Caption := 'not Assigned';
    frmAScope.lblG1Blind.Caption := '-';
    frmAScope.lblG1inrange.Caption := '-';
  end;

  if (Gun2.AssignTo <> nil) and (Gun2.AssignTo.TrackedTarget <> nil) then
  begin
    frmAScope.lblG2To.Caption := Gun2.AssignTo.Name;

    blind2 := self.TestBlindArc(2, Gun2.AssignTo.TrackedTarget);
    if blind2 then begin
      frmAScope.lblG2Blind.Caption := 'blind';
      col.UpdateImage(fAtas2.lmpG2BLDARC, col.redROUND_On);end
    else begin
      frmAScope.lblG2Blind.Caption := 'ok';
      col.UpdateImage(fAtas2.lmpG2BLDARC, col.redROUND_Off);end;

    if gun2.AssignTo.TrackedTarget.Relation.DetRange < C_GUN2_RANGE then
      frmAScope.lblG2inrange.Caption := 'in range'
    else
      frmAScope.lblG2inrange.Caption := 'out of range';

    if (gun2.AssignTo.TrackedTarget.Relation.DetRange < C_GUN2_RANGE) and (blind2 = false) then
      col.UpdateImage(fBawah2.lmpG2INRANGE, col.greenROUND_On)
    else
      col.UpdateImage(fBawah2.lmpG2INRANGE, col.greenROUND_Off);
  end
  else
  begin
    frmAScope.lblG2To.Caption := 'not Assigned';
    frmAScope.lblG2Blind.Caption := '-';
    frmAScope.lblG2inrange.Caption := '-';
  end;

  if (Gun3.AssignTo <> nil) and (Gun3.AssignTo.TrackedTarget <> nil) then
  begin
    frmAScope.lblG3To.Caption := Gun3.AssignTo.Name;

    blind3 := self.TestBlindArc(3, Gun3.AssignTo.TrackedTarget);
    if blind3 then begin
      frmAScope.lblG3Blind.Caption := 'blind';
      col.UpdateImage(fAtas2.lmpG3BLDARC, col.redROUND_On);end
    else begin
      frmAScope.lblG3Blind.Caption := 'ok';
      col.UpdateImage(fAtas2.lmpG3BLDARC, col.redROUND_Off);end;

    if gun3.AssignTo.TrackedTarget.Relation.DetRange < C_GUN3_RANGE then
      frmAScope.lblG3inrange.Caption := 'in range'
    else
      frmAScope.lblG3inrange.Caption := 'out of range';

    if (gun3.AssignTo.TrackedTarget.Relation.DetRange < C_GUN3_RANGE) and (blind3 = false) then
      col.UpdateImage(fBawah2.lmpG3INRANGE, col.greenROUND_On)
    else
      col.UpdateImage(fBawah2.lmpG3INRANGE, col.greenROUND_Off);
      
  end
  else
  begin
    frmAScope.lblG3To.Caption := 'not Assigned';
    frmAScope.lblG3Blind.Caption := '-';
    frmAScope.lblG3inrange.Caption := '-';
  end;

  frmAScope.lblHM.Caption := FloatToStr(self.xSHIP.Heading)
end;

function TGenericTDCInterface.OBMRight_DeAssignFC(const tFCID: TFC_ID): boolean;
var
  found: boolean;
  aMTrack: TManualTrack;
  detObj: TDetectedObject;
begin
  result := False;

  case tFCID of
    FC_2:
    begin
      if FC2.TrackedTarget <> nil then
      begin
        FC2.TrackedTarget.SetDeAssign_FC(tFCID);
        FC2.TrackedTarget.TrackedBy[indx_FC2] := False;
        FC2.TrackedTarget := nil;

        result := True;

        if (Gun1.AssignTo <> nil ) and (Gun1.AssignTo.Name = FC2.Name) then Gun1.AssignTo := nil;
        if (Gun2.AssignTo <> nil ) and (Gun2.AssignTo.Name = FC2.Name) then Gun2.AssignTo := nil;
        if (Gun3.AssignTo <> nil ) and (Gun3.AssignTo.Name = FC2.Name) then Gun3.AssignTo := nil;
      end;
    end;
    FC_3:
    begin
      if FC3.TrackedTarget <> nil then
      begin
        Fc3.TrackedTarget.SetDeAssign_FC(tFCID);
        FC3.TrackedTarget.TrackedBy[indx_FC3] := False;
        FC3.TrackedTarget := nil;

        result := True;

        if (Gun1.AssignTo <> nil ) and (Gun1.AssignTo.Name = FC3.Name) then Gun1.AssignTo := nil;
        if (Gun2.AssignTo <> nil ) and (Gun2.AssignTo.Name = FC3.Name) then Gun2.AssignTo := nil;
        if (Gun3.AssignTo <> nil ) and (Gun3.AssignTo.Name = FC3.Name) then Gun3.AssignTo := nil;
      end;
    end;
  end;
end;

function TGenericTDCInterface.FindTrackByID(const ID: String; var aMTrack: TManualTrack): boolean;
var i : integer;
    list: TList;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := false;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    if aMTrack.UniqueID = ID then result := True;
    dec(i);
  end;

  TrackList.ReturnList;
end;

procedure TGenericTDCInterface.UpdateTargetSymbol(const tFCID: TFC_ID; const sym: Char);
begin
  case tFCID of
    FC_1: if FC1.TrackedTarget <> nil then begin FC1.TrackedTarget.SetIdent(sym); FC1.TrackedTarget.SetAmplifyingInfo_1(aiAutomaticTrack); end;
    FC_2: if FC2.TrackedTarget <> nil then begin FC2.TrackedTarget.SetIdent(sym); FC2.TrackedTarget.SetAmplifyingInfo_1(aiAutomaticTrack); end;
    FC_3: if FC3.TrackedTarget <> nil then begin FC3.TrackedTarget.SetIdent(sym); FC3.TrackedTarget.SetAmplifyingInfo_1(aiAutomaticTrack); end;
  end;
end;

function TGenericTDCInterface.TestBlindArc(const Gun: byte; const Tgt: TManualTrack): boolean;
var
  LAngle, RAngle, Baringan: double;
begin
  Baringan := Tgt.Relation.DetBearing;
  BlindArc.GetGunAngle(self.xSHIP.Heading, Gun, LAngle, RAngle);
  Result := not DegComp_IsBeetwen(Baringan, LAngle, RAngle);
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

//********************  Udara     **********************//
function TGenericTDCInterface.OBMLeft_AssignFC: boolean;
var findObj: boolean;
    detObj: TDetectedObject;
    findTrack: boolean;
    mTrack: TManualTrack;
    initPos: TPoint;
begin
  result := False;

  if FC1.TrackedTarget <> nil then Exit;

  inc(ltid_udara);
  findObj := ActiveRadar.FindDetectedObjectByView(OBMLeft.Center.X, OBMLeft.Center.Y, detObj);
  findTrack := FindTrackList(OBMLeft.Center.X, OBMLeft.Center.Y, mTrack);
  if findTrack then
  begin
    mTrack.TrackedBy[indx_FC1] := True;
    //mTrack.SetAcquisitionLabel(ID_AcquisitionLabel, 'TDCCursor');
    //mTrack.SetAssign_FC(tFCID);
    FC1.TrackedTarget := mTrack;

    result := True;
  end
  else if findObj then
  begin
    mTrack := TManualTrack.Create;
    mTrack.PositionX := OBMLeft.mPos.X;
    mTrack.PositionY := OBMLeft.mPos.Y;

    mTrack.TrackedBy[indx_FC1] := True;

    mTrack.CreateDefaultView(FMap);
    //mTrack.SetCourseVisibility(True);
    //mTrack.SetAcquisitionLabel(ID_AcquisitionLabel, 'TDCCursor');
    //mTrack.SetIdent(ID_Udara_Hostile);
    //mTrack.SetAssign_FC(tFCID);
    //mTrack.SetTrackNumber(shipt_tid, GetLTID_Udara);
    mTrack.Domain := tdUdara;
    mTrack.Enabled := TRUE;
    mTrack.Relation := detObj;
    FC1.TrackedTarget := mTrack;

    TrackList.AddObject(mTrack);

    result := True;
  end;

  if findObj or findTrack then
  begin
    TGM.Visible := True;
    initPos :=  ConvertToScreen(xSHIP.PositionX, xSHIP.positionY);
    //TGM_SetPosition(initPos.X, initPos.Y);
    TGM_SetPosition(10, frmTengah.Map.Height shr 1);
  end;
end;

procedure TGenericTDCInterface.TGM_SetPosition(const x, y: integer);
begin
  DisplaySymbols[i_Gerbang_Pelacakan].Center.X := x;
  DisplaySymbols[i_Gerbang_Pelacakan].Center.Y := y;

  DisplaySymbols[i_Gerbang_Pelacakan].mPos := ConvertToMap(x, y);
end;

procedure TGenericTDCInterface.UpdateTGMPosition;
var
  pos: TPoint;
begin
  pos := ConvertToScreen(FC1.TrackedTarget.PositionX, FC1.TrackedTarget.PositionY);
  TGM_SetPosition(pos.X, pos.Y);
end;

procedure TGenericTDCInterface.SetTrackNumber(var aMTrack: TManualTrack);
begin
  aMTrack.SetTrackNumber(shipt_tid, GetLTID_Udara);
end;

procedure TGenericTDCInterface.Filter(const atd: TTrackDomain;
  const aVis: boolean);
var i: integer;
    l : TList;
begin
  if atd = tdEW then begin

    //ESMFixs.Visible := aVis;
  end
  else begin
    l := TrackList.GetList;
    for i := 0 to l.Count-1 do begin
      mTrack := l[i];
      if mTrack.Domain = atd then
      mTrack.Visibles := aVis;
    end;

    TrackList.ReturnList;
  end;
end;

function TGenericTDCInterface.AssignGunToFC(const Gun_ID, FC_ID: byte): boolean;
var
  FC: TFireControl;
begin
  result := False;
  
  case FC_ID of
  1: begin
      //if FC1.TrackedTarget = nil then Exit;
      FC := FC1;
    end;
  2: begin
      //if FC2.TrackedTarget = nil then Exit;
      FC := FC2;
    end;
  3: begin
      //if FC3.TrackedTarget = nil then Exit;
      FC := FC3;
    end;
  end;

  case Gun_ID of
  1:
    begin
      if Gun1.AssignTo <> nil then result := False
      else begin Gun1.AssignTo := FC; result := True; end;
    end;
  2:
    begin
      if Gun2.AssignTo <> nil then result := False
      else begin Gun2.AssignTo := FC; result := True; end;
    end;
  3:
    begin
      if Gun3.AssignTo <> nil then result := False
      else begin Gun3.AssignTo := FC; result := True; end;
    end;
  end;

end;

procedure TGenericTDCInterface.SendFireControlData(const tFC_ID: TFC_ID; const Order: byte; const Command: byte);
var
  fcNum: byte;
  tgt: TManualTrack;
begin
  //procedure SetFireControl(var theClient: TTCPClient; const mShip: String;
  //    const OrdID: byte; const FCNum: byte; const FCCommand: byte; const Tgt: TManualTrack);
  case tFC_ID of
  FC_1: begin
      fcnum := 1; tgt := FC1.TrackedTarget;
    end;
  FC_2: begin
      fcnum := 2; tgt := FC2.TrackedTarget;
    end;
  FC_3: begin
      fcnum := 3; tgt := FC3.TrackedTarget;
    end;
  end;

  SendFCData(self.theclient, xship.UniqueID, Order, fcnum, Command, tgt);
end;

procedure TGenericTDCInterface.test;
begin
  //self.ActiveRadar.Enabled := False;
  self.ActiveRadar.TimeBase.Enabled := False;
  self.ActiveRadar.TimeBaseView.Visible := False;
  self.ActiveRadar.SectorView.Visible := False;
  self.ActiveRadar.PolarView.Visible := False;
end;

//******************  buat simulasi ********************//
procedure TGenericTDCInterface.CreateManTrack;
var
  i: Integer;
  mTrack: TManualTrack;
  list: TList;
  detObj: TDetectedObject;
begin
  list := self.ActiveRadar.DetObjects.GetList;

  for i := 0 to list.Count -1 do
  begin
  detObj := List[i];
    if i mod 2 = 0 then
    begin
      mTrack := TManualTrack.Create;
      mTrack.PositionX := detObj.PositionX;
      mTrack.PositionY := detObj.PositionY;

      mTrack.CreateDefaultView(FMap);
      if (i = 2) or (i=4) then mTrack.SetIdent(ID_Udara_Unknown)
      else mTrack.SetIdent(ID_AtasAir_Unknown);
      mTrack.SetTrackNumber(shipt_tid, GetLTID_BawahAir);
      mTrack.Domain := tdAtasAir;
      mTrack.Enabled := TRUE;
      mTrack.Relation := detObj;

      TrackList.AddObject(mTrack);
    end;
  end;
end;
//******************  buat simulasi ********************//

end.


