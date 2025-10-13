unit uLibTDCTracks;

interface

  uses
    MapXLib_TLB, uRadarTracks, uDetected, uBaseDataType, uBaseConstan,
    uObjectView, uLibTDCDisplay
    ;

  type
//==============================================================================

    tDetectionMode = (dmUnInitiate, dmManual, dmAutomatic);
    tAmplInfo      = (aiAutomaticTrack, aiRAMTrack, aiAcquisitionTrack, aiDRTTrack, aiATRA, aiAT, aiRA, aiFC);
//    tTrackClassification = (tcUC, tcPOSP, tcPOSB, tcCRT, tcNOS);



//==============================================================================
    TTDCTrack   = class(TDisplayTrack)  // track yg bisa di testhit;
    protected
      FShipTrackID : byte;
      FTrackNumber : byte;

      FLineLabel    : TColumnLabel;
      Symbol  : TSymbolView;

      FVisibles     : boolean;

      procedure SetPrivCode(const Value: string);
      function GetPrivateCode: string;

      procedure SetVisibles(const Value: boolean); virtual;
    public
      Domain : TTrackDomain;

      procedure CreateDefaultView(const aMap: TMap); override;
      procedure SetTrackNumber(const aShipTID, aTrackNum: byte);


      property TrackNumber: byte read FTrackNumber;
      property ShipTrackId: byte read FShipTrackID;

      property PrivateCode: string read GetPrivateCode write SetPrivCode;
      property Visibles : boolean read FVisibles write SetVisibles;

    end;

   TTrackingState = (ts_init, ts_acq_to_auto, ts_acq_to_manual, ts_auto_rate_aid, ts_auto, ts_rate_aid);

//==============================================================================
// manual track : dibuat oleh operator tdc / radar
    TManualTrack = class(TTDCTrack)
    private
      function GetFlightLevel: single;
      procedure SetFlightLevel(const Value: single);
      function GetHistoryVisible: boolean;
      procedure SetHistoryVisible(const Value: boolean);
    function GetThreatVisible: boolean;
    procedure SetThreatVisible(const Value: boolean);

    protected

      function GetFCChanel: byte;
      procedure SetVisibles(const Value: boolean); override;

    protected
      FVSpeedVector : TSpeedVector;

      FRowLabel     : T3LineLabel;

      FThreatAsses  : TThreadAssesmentView;
      FTAssesTimer  : double;

      FTrackType: tAmplInfo;
      FHistory : THistory;
      FHistoryTimer : double;

      FAcquisitionTime: double;
      FAcqCounter     : double;
      FTrackingState  : TTrackingState;

      FRelationCandidate : TDetectedObject;
      FCNumCandidate : byte;
      FCHold  : boolean;

      procedure SetCourseVisible(const aVis: boolean);
      procedure SetMainSymbolVisible(const aVis: boolean);
      procedure SetAmpliInfoVisible(const aVis: boolean);
      procedure SetLinkVisible(const aVis: boolean);
      procedure SetTrackNumberVisible(const aVis: boolean);
      procedure SetAssByTorpedoVisible(const aVis:Boolean);

      function  GetMainSymbolVisible: boolean;
      function  GetCourseVisible: boolean;
      function  GetAmpliInfoVisible: boolean;
      function  GetLinkVisible: boolean;
      function  GetTrackNumberVisible: boolean;
      function GetAssbyTorpedoVisible: Boolean;

      procedure SetRelation(r: TDetectedObject);

    public // simulation
      Relation : TDetectedObject;
      // gigih
      TrackedBy : array [1..4] of boolean;
      IsNewlyCreated : boolean; // baru aja dibuat
      HasBeenTracked : boolean;  // udah ke track

      HistoryUpdateTime : double;   ///

      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      procedure Update; override;
      procedure Run(const aDeltaMs: double); override;

      //cakra
      procedure ShowTrackInfo(const TrackName: string);

      procedure SetHistoryLength(const aVal: Integer);
      //procedure HistoryVisible(const aVal: boolean);
      procedure SetSpeedVector(const sp, hd: double);

    public // interface

      //tracklabel
      //for underwater:
      SubClassification :  string[3];
      IdentSource  : Char;
      procedure ShowMarkCloseControler(const aVal: boolean=TRUE);


      procedure SetIdent(const sym: Char; const aSize: integer = 16);
      function GetIdent: Char;

      procedure SetAmplifyingInfo_1(const aInfo: tAmplInfo);      //track mode
      procedure SetAmplifyingInfo_2(const ac: Char);

      procedure SetAssignASRL(const aVal: boolean=TRUE);

      procedure SetAssign_FC(const aFCNum: byte; aHold: boolean);
      function SetDeAssign_FC(const aFCNum: byte): boolean;

      procedure SetAssign_FC_WCC(const tFCID: byte);
      function SetDeAssign_FC_WCC(const tFCID: byte): boolean;

      procedure SetThreadAssesment(const dtSecond: integer);

      procedure SetDelay_To_Automatic(const aFCNum: byte; aHold: boolean; r: TDetectedObject); // from acquit
      procedure SetDelay_To_Manual(const aFCNum: byte; aHold: boolean);
      procedure SetDelay_To_X(const ts: TTrackingState; r: TDetectedObject);

      function GetTrackingState: TTrackingState;

      {wida}
      procedure SetAssByTorpedo (const tube:String);

    public
       property  MainSymbolVisible: boolean
          read GetMainSymbolVisible write SetMainSymbolVisible;
       property  CourseVisible: boolean
          read GetCourseVisible write SetCourseVisible;
       property  AmpliInfoVisible: boolean
          read GetAmpliInfoVisible write SetAmpliInfoVisible;
       property  LinkVisible: boolean
          read GetLinkVisible write SetLinkVisible;
       property  TrackNumberVisible: boolean
          read GetTrackNumberVisible write SetTrackNumberVisible;
       property AssByTorpedoVisible: Boolean
          read  GetAssbyTorpedoVisible write SetAssByTorpedoVisible;

      property ThreatAssestVisible: boolean
        read  GetThreatVisible write SetThreatVisible;

       property HistoryVisible: boolean
          read GetHistoryVisible write SetHistoryVisible;

      property TrackType: tAmplInfo read FTrackType write SetAmplifyingInfo_1;

      property FCChanel: byte read GetFCChanel;

      property FlightLevel: single read GetFlightLevel write SetFlightLevel;

    end;

//==============================================================================
    TDatumTrack = class (TTDCTrack)

    protected
      FFOC    : TFOCView;
      FOCIndex: integer;

      procedure SetVisibles(const Value: boolean); override;
    public
      Error   : byte;
      LastTime: TDateTime;
      DatumSource: string;

      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      procedure Update; override;
      procedure Run(const aDeltaMs: double); override;

      procedure SetFOC(var aFoc: tFOCView);
      procedure DelFOC;
    end;

//==============================================================================
    TESMFixTrack = class (TTDCTrack)
    private

    protected
      procedure SetVisibles(const Value: boolean); override;

    public
      LastTime : TDateTime;
      IdentChar: Char;
      PlatformID : char;

      constructor Create;
      destructor Destroy; override;

      procedure CreateDefaultView(const aMap: TMap); override;

    end;

//==============================================================================
    TRefPosTrack = class (TTDCTrack)
    protected
      procedure SetVisibles(const Value: boolean); override;

    public
      TLI       : string[2];

      procedure CreateDefaultView(const aMap: TMap); override;
    end;

//==============================================================================
    TESMBearingTrack = class (TTDCTrack)
    private
      FBearing: double;          // cartesian
      FDistance  : double;       // longlat degree
      FLineView : TLineView;

      procedure SetX(const Value: double); override;
      procedure SetY(const Value: double); override;

      function getBearing: double;
      procedure setBearing(const Value: double);
      procedure UpdateEndCoord;
      function GetDistance: double;
      procedure SetDistance(const Value: double);

    public

      LastTime    : TDateTime;
      PulseWidth  : single;
      PulseRepInt : single;
      SusieNumber : byte;
      Band        : Char;

      EndCoord : t2DPoint;  // map coord, if assigned to track

      pointType :String[3];

      constructor Create;
      destructor Destroy; override;

      procedure Run(const aDeltaMs: double); override;
      procedure Update; override;

      procedure CreateDefaultView(const aMap: TMap); override;
      function TestViewHit(const x, y: integer): boolean; override;

      procedure SetStartCoord(const x, y: double);
      procedure SetEndCoord(const x, y: double);

      property Bearing: double read getBearing write setBearing;
      property Distance: double read GetDistance write SetDistance; // nautical miles, scale range:


    end;

implementation

uses

  uBaseSimulationObject, uBaseFunction, SysUtils, Classes, Math;

const
  //untul line label
  id_mainsymbol        = 1;
  id_ampli_info_1      = 2;
  id_ampli_info_2      = 3;
  id_assign_fc         = 4;
  id_line_tracknumber  = 5;

  id_hold_FC           = 6;
  id_PrivateCode       = 7;
  id_colext3           = 8;

  id_ass_by_torpedo    = 9;
  id_close_control     = 10;

//==============================================================================
{ TTDCTrack }

procedure TTDCTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  FLineLabel          := TColumnLabel.CreateOnMapX(self, aMap);
  FLineLabel.Color    := C_defColor;
  FLineLabel.Visible  := TRUE;
  FLineLabel.OffX     := 0;
  FLineLabel.OffY     := 0;

  FLineLabel.Lbls[id_line_tracknumber].FontSize := 8;
  FLineLabel.Lbls[id_line_tracknumber].FontName := 'Arial';
  FLineLabel.lbls[id_line_tracknumber].OffX     := 53;       // id_line_tracknumber  = 5;

  FLineLabel.lbls[id_PrivateCode].Visible := false;                   //id_PrivateCode = 7;
  FLineLabel.lbls[id_PrivateCode].OffX    := 90;

  ViewContainer.AddObject(FLineLabel);

  Symbol := TSymbolView.CreateOnMapX(Self, aMap);
  Symbol.FontName :=  'TDCCursor';
  Symbol.CharSymbol := ' ';
  Symbol.Size := 12;
  Symbol.Visible := TRUE;

  ViewContainer.AddObject(Symbol);

end;


procedure TTDCTrack.SetTrackNumber(const aShipTID, aTrackNum: byte);
begin  //  (5)
  FShipTrackID := aShipTID;
  FTrackNumber :=  aTrackNum;
  FLineLabel.Lbls[id_line_tracknumber].Text :=
      IntToOct(aShipTID, 2) +
      IntToOct(aTrackNum, 2);

//  FLineLabel.Lbls[id_line_tracknumber].FontSize := 8;
//  fLineLabel.Lbls[id_line_tracknumber].FontName := 'Arial';
end;



procedure TTDCTrack.SetPrivCode(const Value: string);
begin
  if Length(Value) > 5 then
    FLineLabel.lbls[id_PrivateCode].Text  := Copy(Value, 1, 5)
  else
    FLineLabel.lbls[id_PrivateCode].Text := Value;

  FLineLabel.lbls[id_PrivateCode].Visible := Value <> '';

end;

function TTDCTrack.GetPrivateCode: string;
begin
  result := FLineLabel.lbls[id_PrivateCode].Text;
end;

procedure TTDCTrack.SetVisibles(const Value: boolean);
begin
  FVisibles := Value;
  FLineLabel.Visible := Value;

end;
//==============================================================================
{ TManualTrack }

constructor TManualTrack.Create;
begin
  inherited;
  HistoryUpdateTime := 60.0;
  FHistoryTimer     := 0.0;

  FAcquisitionTime := 4000.0; // ms ?
  FTrackingState := ts_init;

  IdentSource  := 'R';

end;

destructor TManualTrack.Destroy;
begin

  inherited;
end;
{
}
procedure TManualTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  FVSpeedVector         := TSpeedVector.CreateOnMapX(self, aMap);
  FVSpeedVector.Color   := C_defColor;
  FVSpeedVector.Visible := TRUE;
  FVSpeedVector.Ratio := 3;
  ViewContainer.AddObject(FVSpeedVector);

  FLineLabel.Color    := C_defColor;
  FLineLabel.Visible  := TRUE;

  FLineLabel.lbls[id_mainsymbol ].OffX        := 0;        // id_mainsymbol        = 1;
  FLineLabel.lbls[id_close_control ].OffX     := -6;        // id_mainsymbol        = 1;
  FLineLabel.lbls[id_close_control ].OffY     := 1;
  FLineLabel.lbls[id_ampli_info_1].OffX       := 16;       // id_ampli_info_1      = 2;
  FLineLabel.lbls[id_ampli_info_2].OffX       := 26;       // id_ampli_info_2      = 3;
  FLineLabel.lbls[id_assign_fc].OffX          := 31;       // id_assign_fc         = 4;
//  FLineLabel.lbls[id_line_tracknumber].OffX   := 53;     // id_line_tracknumber  = 5;

  FLineLabel.lbls[id_hold_FC].OffX            := 29;       //id_hold_FC           = 6;

  FLineLabel.lbls[id_PrivateCode].Visible := false;       //id_PrivateCode = 7;
  FLineLabel.lbls[id_PrivateCode].OffX    := 90;

  FLineLabel.lbls[id_colext3].OffX            := 31;    //id_colext3 = 8;  fc 3

  //wida
  FLineLabel.Lbls[id_ass_by_torpedo].FontSize := 8;
  FLineLabel.Lbls[id_ass_by_torpedo].FontName := 'Arial';
  FLineLabel.lbls[id_ass_by_torpedo].OffX     := 0;
  FLineLabel.lbls[id_ass_by_torpedo].OffY     := 15;

//  FLineLabel.lbls[9].OffX := 16;       add
//  FLineLabel.lbls[9].OffY := 16;       add
//  FLineLabel.lbls[9].Visible := true;

// testing
  FThreatAsses := TThreadAssesmentView.CreateOnMapX(self,  aMap);
  FThreatAsses.UpdateOrigin;
  FThreatAsses.Visible := FALSE;
  ViewContainer.AddObject(FThreatAsses);

  FHistory := THistory.CreateOnMapX(self, aMap);
  FHistory.VisibleCount := -1;
  FHistory.Visible := FALSE;
  FHistory.Color := C_defColor;
  ViewContainer.AddObject(FHistory);

  FRowLabel := T3LineLabel.CreateOnMapX(self, aMap);
  FRowLabel.Color    := C_defColor;
  FRowLabel.Visible  := False;
  FRowLabel.OffX := 20;
  FRowLabel.OffY := -5;

  ViewContainer.AddObject(FRowLabel);
end;

procedure TManualTrack.Run(const aDeltaMs: double);
begin
  if Relation <> nil then begin

    Speed := Relation.DetSpeed;
    Course := ConvCompass_To_Cartesian(Relation.DetHead);
    PositionX := Relation.PositionX;
    PositionY := Relation.PositionY;
    PositionZ := Relation.PositionZ;

  end
  else
    inherited;

  if Assigned(FThreatAsses) and  FThreatAsses.Visible then begin
    FTAssesTimer  := FTAssesTimer  + aDeltaMs;
    if FTAssesTimer > 250 then begin
      FTAssesTimer  := 0;
      FThreatAsses.VisibleCount := (FThreatAsses.VisibleCount + 1) mod 10;
      if FThreatAsses.VisibleCount = 0 then begin
        FThreatAsses.HeadingNorth := Course;
        FThreatAsses.SpeedKnot    := Speed;
        FThreatAsses.UpdateOrigin;
      end
    end;
  end;

  FHistoryTimer := FHistoryTimer + aDeltaMs; // ms
  if (FHistoryTimer * 0.001) > HistoryUpdateTime then begin
    FHistoryTimer := FHistoryTimer - (HistoryUpdateTime * 1000.0);
    FHistory.AddPoint( PositionX, PositionY, PositionZ) ;
  end;

  if (FTrackingState <> ts_init) then begin
    FAcqCounter :=  FAcqCounter + aDeltaMs;
    if FAcqCounter > FAcquisitionTime then begin
      if (FTrackingState = ts_acq_to_auto) then begin
        SetRelation(FRelationCandidate);
        SetAssign_FC(FCNumCandidate, FCHold);
//        SetAmplifyingInfo_1(aiAutomaticTrack);
      end
      else if (FTrackingState = ts_acq_to_manual) then begin
        FRelationCandidate := nil;
        SetRelation(nil);
        SetAmplifyingInfo_1(aiRAMTrack);
      end
      else if (FTrackingState = ts_auto_rate_aid) then begin
        SetAmplifyingInfo_1(aiATRA);
      end
      else if (FTrackingState = ts_auto) then begin
        SetRelation(FRelationCandidate);
        SetAmplifyingInfo_1(aiAT);
      end
      else if (FTrackingState = ts_rate_aid) then begin
        FRelationCandidate := nil;
        SetRelation(nil);
        SetAmplifyingInfo_1(aiRA);
      end;
      FTrackingState :=  ts_init;
    end;
  end;
end;

// gg tambahan
procedure TManualTrack.ShowTrackInfo(const TrackName: string);
var temp: String;
begin
  FRowLabel.Line1 := TrackName;
  temp := FloatToStr(trunc(Course));
  if Length(temp) < 3 then temp := '0' + temp;
  FRowLabel.Line2 := temp;
  FRowLabel.Line3 := FloatToStr(trunc(Speed));

  FRowLabel.Visible := True;
end;

procedure TManualTrack.SetHistoryLength(const aVal: Integer);
begin
  FHistory.VisibleCount := aVal;
end;

{procedure TManualTrack.HistoryVisible(const aVal: boolean);
begin
  FHistory.Visible := aVal;
end; }

procedure TManualTrack.SetSpeedVector(const sp, hd: double);
begin
  FVSpeedVector.Speed := sp;
  FVSpeedVector.Heading := hd;
end;
// end of tambahan

procedure TManualTrack.Update;
begin
  inherited;

  {if FVSpeedVector.Visible then begin
    FVSpeedVector.Speed     := Speed;
    FVSpeedVector.Heading   := Course;
  end;}
  // gg
  if (FVSpeedVector.Visible) then begin
    if Speed <> 0 then begin
      FVSpeedVector.Speed     := Speed;
      FVSpeedVector.Heading   := Course;
    end;
  end;

//  FLineLabel.Lbls[9].Text :=  Format('s: %2.2f, h: %2.2f ',[Speed, Course]);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
{Column label constan
  id_mainsymbol       = 1;
  id_ampli_info_1     = 2
  id_ampli_info_2     = 3
  id_assign_fc        = 4
  id_line_tracknumber = 5;
}
procedure TManualTrack.SetIdent(const sym: Char; const aSize: integer = 16);
begin   // (1) Main Symbol
  with FLineLabel.lbls[id_mainsymbol]  do begin
    Text := sym;
    Visible := TRUE;
    FontName := 'TDCIdent';
    FontSize := aSize;
  end;
end;

procedure TManualTrack.ShowMarkCloseControler(const aVal: boolean{=TRUE});
begin   // (1) Main Symbol
  with FLineLabel.Lbls[id_close_control] do
  begin
    Text      := ID_Close_controller;
    FontName  := 'TDCIdent';
    FontSize  := 18;
    Visible   := aVal;
  end;
 end;

function TManualTrack.GetIdent: Char;
begin
  if Length(FLineLabel.lbls[id_mainsymbol].Text) > 0 then
  result := FLineLabel.lbls[id_mainsymbol].text[1]
  else result := ' ';
end;


procedure TManualTrack.SetAmplifyingInfo_1(const aInfo: tAmplInfo);
var symbol: char;
    sz: Integer;
begin  // (2)
  sz := 14;
  FTrackType := aInfo;
  case aInfo of
    aiAutomaticTrack, aiAT   : begin
      symbol :=  ID_AutomaticTrack   ;
      sz := 14;
    end;
    aiRAMTrack         : symbol :=  ID_RAMTrack;
    aiAcquisitionTrack, aiATRA : begin
      symbol :=  ID_AcquisitionTrack ;
      sz := 8;
    end;
    aiDRTTrack         : symbol := ID_DRTTrack;
    aiRA               : symbol := ID_RA;
    aiFC               : symbol := ID_FC;
  else
    symbol :=  ' ';
  end;

  FLineLabel.Lbls[id_ampli_info_1].FontName := 'TDCIdent';
  FLineLabel.Lbls[id_ampli_info_1].Text := symbol;
  FLineLabel.Lbls[id_ampli_info_1].FontSize := sz;
  FLineLabel.Lbls[id_ampli_info_1].Visible := TRUE;
end;

procedure TManualTrack.SetAmplifyingInfo_2(const ac: Char);
begin  // (2) belum dipakai...
  FLineLabel.Lbls[id_ampli_info_2].FontName := 'TDCIdent';
  FLineLabel.Lbls[id_ampli_info_2].Text := ac;
  FLineLabel.Lbls[id_ampli_info_2].FontSize := 10;
  FLineLabel.Lbls[id_ampli_info_2].Visible := TRUE;
end;


procedure TManualTrack.SetAssignASRL(const aVal: boolean=TRUE);
begin
  if aVal then
    SetAmplifyingInfo_1(aiAcquisitionTrack)
  else
    SetAmplifyingInfo_1(aiRAMTrack);
end;


procedure TManualTrack.SetAssign_FC(const aFCNum: byte; aHold: boolean);
begin
  if (aFCNum <1 ) or (aFCnum > 4) then
    exit;

  TrackedBy[aFCNum] := true;
  SetAmplifyingInfo_1(aiAutomaticTrack);

  case aFCnum of
  1: begin
       FLineLabel.Lbls[id_assign_fc].Text :='1';
  end;
  2: begin
      FLineLabel.Lbls[id_assign_fc].Text :='2';
      FLineLabel.Lbls[id_assign_fc].Visible := TRUE;
      FLineLabel.Lbls[id_assign_fc].FontName := 'TDCIdent';
      FLineLabel.Lbls[id_assign_fc].FontSize := 10;
    end;
  3: begin
      FLineLabel.Lbls[id_colext3].Text :='3';
      FLineLabel.Lbls[id_colext3].Visible := TRUE;
      FLineLabel.Lbls[id_colext3].FontName := 'TDCIdent';
      FLineLabel.Lbls[id_colext3].FontSize := 10;
    end;
  4: begin
      FLineLabel.Lbls[id_assign_fc].Text :=' ';
      FLineLabel.Lbls[id_assign_fc].Visible := TRUE;
    end;
  end;

  with FLineLabel.Lbls[id_assign_fc] do begin
    FontName := 'TDCIdent';
    FontSize := 10;
  end;

  with FLineLabel.Lbls[id_hold_FC] do begin
    Text := ID_HOLD;
    FontName := 'TDCIdent';
    FontSize := 12;
    Visible := aHold;
  end
end;

function TManualTrack.SetDeAssign_FC(const aFCNum: byte): boolean;
var i : byte;
    exist : boolean;
begin
  result := False;

  if (aFCNum <1) or (aFCnum > 4) then
    exit;


  case aFCNum of
  1,4: begin
      FLineLabel.Lbls[id_assign_fc].Text :='';
      result := True;
    end;
  2: begin
      FLineLabel.Lbls[id_assign_fc].Text := ' ';
      FLineLabel.Lbls[id_assign_fc].Visible := false;
      result := True;
    end;
  3: begin
      FLineLabel.Lbls[id_colext3].Text := ' ';
      FLineLabel.Lbls[id_colext3].Visible := false;
      result := True;
    end;
  end;
  TrackedBy[aFCNum] := False;

  exist := false;

  for i := 1 to 4 do
    exist := exist OR TrackedBy[i];

  if not exist then
    SetAmplifyingInfo_1(aiRAMTrack);

  with FLineLabel.Lbls[id_hold_FC] do begin
    Text := ID_HOLD;
    FontName := 'TDCIdent';
    FontSize := 12;
    Visible := false;
  end
end;


procedure TManualTrack.SetAssign_FC_WCC(const tFCID: byte);
begin
  SetAssign_FC(tFCID, true);
end;

function TManualTrack.SetDeAssign_FC_WCC(const tFCID: byte): boolean;
begin
  SetDeAssign_FC(tFCID);
end;

procedure TManualTrack.SetAssByTorpedo(const tube:String);
begin
   FLineLabel.lbls[id_ass_by_torpedo].Text := 'T ' + '. ' + tube;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TManualTrack.SetCourseVisible(const aVis: boolean);
begin
   FVSpeedVector.Visible := aVis;
end;

function TManualTrack.GetCourseVisible: boolean;
begin
  result := FVSpeedVector.Visible;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TManualTrack.SetMainSymbolVisible(const aVis: boolean);
begin
  FLineLabel.Lbls[id_mainsymbol].Visible := aVis;
end;

function TManualTrack.GetMainSymbolVisible: boolean;
begin
  result := FLineLabel.Lbls[id_mainsymbol].Visible;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TManualTrack.SetAmpliInfoVisible(const aVis: boolean);
begin
  FLineLabel.Lbls[id_ampli_info_1].Visible := aVis;
  FLineLabel.Lbls[id_ampli_info_2].Visible := aVis;
//  id_ampli_info_2

end;
function TManualTrack.GetAmpliInfoVisible: boolean;
begin
  result := FLineLabel.Lbls[id_ampli_info_1].Visible;
//  id_ampli_info_2

end;

procedure TManualTrack.SetAssByTorpedoVisible(const aVis: Boolean);
begin
  FLineLabel.lbls[id_ass_by_torpedo].Visible := aVis;
end;

function TManualTrack.GetAssbyTorpedoVisible: Boolean;
begin
  result := FLineLabel.lbls[id_ass_by_torpedo].Visible;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TManualTrack.SetLinkVisible(const aVis: boolean);
begin

end;

function TManualTrack.GetLinkVisible: boolean;
begin
  //result :=
end;

procedure TManualTrack.SetVisibles(const Value: boolean);
begin
  FVisibles := Value;
  FVSpeedVector.Visible := Value;
  FLineLabel.Visible := Value;
  FHistory.Visible := Value;
end;

//  id_assign_fc
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TManualTrack.SetTrackNumberVisible(const aVis: boolean);
begin
  FLineLabel.Lbls[id_line_tracknumber].Visible := aVis;
end;

function TManualTrack.GetTrackNumberVisible: boolean;
begin
  result := FLineLabel.Lbls[id_line_tracknumber].Visible;
end;

procedure TManualTrack.SetThreadAssesment(const dtSecond: integer);
begin
//  FThreatAsses.Visible    := dtSecond > 0;
  FThreatAsses.TimeAhead  := MAX(0, dtSecond) ;
end;

procedure TManualTrack.SetRelation(r: TDetectedObject);
begin
  Relation := r;
  if Relation <> nil then begin
    Speed := Relation.Speed;
    Course := Relation.Course;
  end
  else begin
    Speed := 0;
    Course := 0;
  end;

end;

function TManualTrack.GetFCChanel: byte;
var i: byte;
begin
  result := 0;
  for i := 1 to 4 do begin
    if TrackedBy[i] then Result := i ;
  end;
end;

procedure TManualTrack.SetDelay_To_Automatic(const aFCNum: byte; aHold: boolean; r: TDetectedObject); // from acquit
begin
  FCNumCandidate := aFCNum;
  FCHold := aHold;
  FTrackingState := ts_acq_to_auto;

  FAcqCounter    := 0;
  FRelationCandidate := r;
end;

procedure TManualTrack.SetDelay_To_Manual(const aFCNum: byte; aHold: boolean);
begin
  FTrackingState := ts_acq_to_manual;
  FAcqCounter     := 0;
  FCNumCandidate := aFCNum;
  FCHold := aHold;
end;

procedure TManualTrack.SetDelay_To_X(const ts: TTrackingState; r: TDetectedObject);
begin
  FTrackingState := ts;
  FAcqCounter     := 0;
  FCHold := false;
  if ts = ts_auto then begin
    FRelationCandidate := r;
  end;
end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TManualTrack.GetFlightLevel: single;
begin
  result := (PositionZ * C_Degree_To_NauticalMile * C_NauticalMile_To_Feet) / 100;
end;

procedure TManualTrack.SetFlightLevel(const Value: single);
begin
   PositionZ := (Value * 100 * C_Feet_To_NauticalMile * C_NauticalMile_To_Degree);
end;

function TManualTrack.GetTrackingState: TTrackingState;
begin
  result := FTrackingState;
end;

function TManualTrack.GetHistoryVisible: boolean;
begin
  result := FHistory.Visible;
end;

procedure TManualTrack.SetHistoryVisible(const Value: boolean);
begin
  FHistory.Visible := Value;
end;

//==============================================================================
function TManualTrack.GetThreatVisible: boolean;
begin
  result := FThreatAsses.Visible;
end;

procedure TManualTrack.SetThreatVisible(const Value: boolean);
begin
  FThreatAsses.Visible := Value;

end;

{ TDatumTrack }

constructor TDatumTrack.Create;
begin
  inherited;
  Speed := 10.0;
  Error := 2;

  LastTime := Time;
  DatumSource := 'LOS';

end;

procedure TDatumTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  Symbol.FontName :=  'TDCCursor';
  Symbol.CharSymbol := C_Symbol_Char[i_DATUM];
  Symbol.Size := 12;
  Symbol.Visible := TRUE;

  FFOC     := nil;
  FOCIndex := -1;
end;

destructor TDatumTrack.Destroy;
begin

  inherited;
end;

procedure TDatumTrack.Run(const aDeltaMs: double);
begin
  //inherited;

  if Enabled and (FOCIndex >= 0) and Assigned(FFOC) then begin
    if FFOC.FDistance < 64 then
      FFOC.FDistance  :=  FFOC.FDistance + Speed * aDeltaMs * C_MilliSecondToHour ;
  end;

end;

procedure TDatumTrack.SetFOC(var aFoc: TFOCView);
var l : tList;
begin

  FFOC := aFOC;
  FFOC.Parent := self;
  l := ViewContainer.GetList;
  FOCindex :=  l.Add(FFOC);
  ViewContainer.ReturnList;

  FFOC.Visible := true;
end;

procedure TDatumTrack.DelFOC;
var l : tList;
begin
  if  FFOC = nil then exit;

  FFOC.FDistance := 0;
  FFOC.Visible := false;

  l := ViewContainer.GetList;
  l.Remove(FFOC);
  ViewContainer.ReturnList;

  FOCIndex := -1;
  FFOC.Parent := nil;
  FFOC := nil;
end;


procedure TDatumTrack.Update;
begin
  inherited;

end;


procedure TDatumTrack.SetVisibles(const Value: boolean);
begin
  inherited;
  FFOC.Visible    := Value;
  Symbol.Visible  := Value;
end;

{ TESMFixTrack }

constructor TESMFixTrack.Create;
begin
  inherited;

  PlatformID  := 'X';  // ASUXML
  IdentChar   := 'U';  // UHF

  LastTime := Time;
end;

procedure TESMFixTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  Symbol.FontName :=  'TDCIdent';
  Symbol.CharSymbol := ID_ESM_Fix;
  Symbol.Size := 12;

//  ViewContainer.AddObject(Symbol);
end;

destructor TESMFixTrack.Destroy;
begin

  inherited;
end;

procedure TESMFixTrack.SetVisibles(const Value: boolean);
begin
  inherited;
  Symbol.Visible  := Value;

end;

//==============================================================================
{ TRefPosTrack }

procedure TRefPosTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  Symbol.FontName   :=  'TDCIdent';
  Symbol.CharSymbol :=   ID_REFF_POS;
  Symbol.Size := 12;

end;

procedure TRefPosTrack.SetVisibles(const Value: boolean);
begin

  inherited;

end;

//==============================================================================
{ TESMBearing }

constructor TESMBearingTrack.Create;
begin
  inherited;

  LastTime    := time;
  PulseWidth  := 555.5;
  PulseRepInt := 12000;
  SusieNumber := 1;
  Band        := 'J';  // J, X, C , S
end;

destructor TESMBearingTrack.Destroy;
begin

  inherited;
end;

procedure TESMBearingTrack.CreateDefaultView(const aMap: TMap);
begin
  inherited;

  Symbol.Visible := FALSE;

  FLineView := TLineView.CreateOnMapX(self, aMap);
  FLineView.Visible := TRUE;
  ViewContainer.AddObject(FLineView);
end;


function TESMBearingTrack.getBearing: double;
begin
  result :=  ConvCartesian_To_Compass(C_RadToDeg * FBearing)

end;

procedure TESMBearingTrack.setBearing(const Value: double);
begin
  FBearing := C_DegToRad * ConvCompass_To_Cartesian(Value);
  UpdateEndCoord;

end;

procedure TESMBearingTrack.Run(const aDeltaMs: double);
begin
  //inherited;

end;

procedure TESMBearingTrack.Update;
begin
  inherited;
  FLineView.EndCoord := EndCoord;

end;

procedure TESMBearingTrack.UpdateEndCoord;
var sinx, cosx: extended;
begin
  SinCos(FBearing, sinX, cosX );

  EndCoord.x := FPosition.X + FDistance  * CosX;
  EndCoord.y := FPosition.Y + FDistance  * SinX;
end;

procedure TESMBearingTrack.SetX(const Value: double);
begin
  inherited;
  UpdateEndCoord;

end;

procedure TESMBearingTrack.SetY(const Value: double);
begin
  inherited;
  UpdateEndCoord;
end;

function TESMBearingTrack.GetDistance: double;
begin
  result := C_Degree_To_NauticalMile * FDistance;
end;

procedure TESMBearingTrack.SetDistance(const Value: double);
begin
  if Value > 128 then exit;

  FDistance := C_NauticalMile_To_Degree * Value;
  UpdateEndCoord;
end;

procedure TESMBearingTrack.SetStartCoord(const x, y: double);
begin
  SetPosition(x, y);
end;

procedure TESMBearingTrack.SetEndCoord(const x, y: double);
var dx, dy, bearing : Extended;
begin
  EndCoord.X := x;
  EndCoord.Y := y;

  dx := (EndCoord.X - FPosition.X);
  dy := (EndCoord.Y - FPosition.Y);

  FDistance := sqrt(sqr(dx) + sqr(dy));
  FBearing  := RadToDeg(ArcTan2(dy, dx));
end;


function TESMBearingTrack.TestViewHit(const x, y: integer): boolean;
begin
  result := ptToLineDistance(FLineView.CenterCoord,
    FLineView.EndPoint , Point(X, Y)) < 5 ;

end;

end.
