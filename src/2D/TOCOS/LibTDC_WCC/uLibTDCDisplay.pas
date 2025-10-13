
unit uLibTDCDisplay;

interface

uses
  MapXLib_TLB,Classes, Windows, Graphics, uBaseDataType,
  uMapXSim, uBaseSimulationObject, uTDCConstan;

type

//==============================================================================
{1}
  TItemTDC = class
  public
    Org : t2DPoint;
    Center : TPoint;

    Visible,
    Enabled : boolean;
    Color   : TColor;

    constructor Create;

    procedure Draw(aCnv: TCanvas);      virtual; abstract;
    procedure Run(const aDt: double);   virtual; abstract;
    procedure ConvertCoord(aMap: TMap); virtual; abstract;
  end;

//==============================================================================
{1.1}
//==============================================================================
{1.2}
  TTDC_Cursor  = class (TItemTDC)
  private
    function GetDistance: double;
    function GetHeading: double;
  protected
    //ptC,
    ptH : TPoint;
    FHeading: double;          // cartesian
    FDistance  : double;       // longlat degree

    EndCoord : tDouble2DPoint;  // map coord, if assigned to track
    procedure UpdateEndCoord;

    procedure SetHeading(const Head: double); virtual;
    procedure SetDistance(const Value: double); virtual;
  public
    Style: TPenStyle;

    constructor Create;

    procedure Draw(aCnv: TCanvas);       override;
    procedure ConvertCoord(aMap: TMap);  override;

    property Heading: double read  GetHeading write SetHeading;   // Compass  Ship Heading;
    property Distance: double read GetDistance write SetDistance; // nautical miles, scale range:

    property EndPoint: TPoint read ptH write ptH;
    procedure SetEndCoord(const x, y: double);
    procedure SetStartCoord(const x, y: double);
  end;

//==============================================================================
{1.2.1}
     THeadingMarker = class(TTDC_Cursor)
     end;
//==============================================================================
{1.2.2}
  TBlindARCS  = class(TTDC_Cursor)
  protected
    FCursors: array of TTDC_Cursor;
    FCursorCount: integer;
    GunOffset: array [1..5] of single;
    DirOffset: array [1..5] of single;

    procedure SetHeading(const Head: double); override;
  public
    constructor Create(const Num: integer);
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;
    procedure ConvertCoord(aMap: TMap); override;

    procedure GetGunAngle(const shipHeading: double;
                                 const Gun: byte;
                                 var LeftAngle, RightAngle: Double);
    procedure SetVisibles(const v: boolean);

  end;
//==============================================================================
{1.3}
  TWeaponAssignView = class(TItemTDC)
  protected
    FRange: double;              // saved as nautical mile
    FDirection: double;

    procedure SetDirection(const Value: double); virtual;
    procedure SetRange(const Value: double); virtual;
    function GetDirection: double;
    function GetRange: double;

  public
    property Range :double read GetRange write SetRange; // Kilometer
    property Direction: double read GetDirection write SetDirection;

  end;

//------------------------------------------------------------------------------
{1.3.1}
    TAssignSSMView = class(TWeaponAssignView)
    private
      pt1,                        //  4 km ahead
      ptHit,                      //  36 km ahead from pt 1; //  hit point center
      stL, stR,                   //  start of trapez
      enL, enR                    //  end of trapez
        : t2DComboPoint;

      mRangeToGo,
      mSearchDepth,
      mManWidth      : double;

      FRangeToGo,
      FSearch_Depth,
      FSearch_Width  : TLetterSize;

      FLaunchMode: TLaunchMode;

      procedure SetRangeToGo(const Value: TLetterSize);
      procedure SetSearch_Depth(const Value: TLetterSize);
      procedure SetSearch_Width(const Value: TLetterSize);
      procedure SetLaunchMode(const Value: TLaunchMode);
    protected
      procedure UpdateRangeDirection;

      procedure SetDirection(const Value: double); override;
      procedure SetRange(const Value: double); override;


    public
      ExocetID  :integer;
      constructor Create;
      procedure Draw(aCnv: TCanvas);     override;
      procedure ConvertCoord(aMap: TMap); override;

      property RangeToGo: TLetterSize read FRangeToGo write SetRangeToGo;
      property Search_Depth: TLetterSize read FSearch_Depth write SetSearch_Depth;
      property Search_Width: TLetterSize read FSearch_Width write SetSearch_Width;

      property LaunchMode: TLaunchMode read FLaunchMode write SetLaunchMode;
    end;

//==============================================================================
{1.3.2}
   TAssignTorpedoView = class(TWeaponAssignView)

   public
      LeftPoint : t2DComboPoint;
      RightPoint : t2DComboPoint;

      constructor Create;
      procedure Draw(aCnv: TCanvas);     override;
      procedure ConvertCoord(aMap: TMap); override;

    end;

//==============================================================================
{1.4}
  TTDCSymbol = class (TItemTDC)
  protected
    FCharSymbol: Char;
    FFontSize: integer;
    FFontName: string;

    FRect: TRect;
    FSymbolChange: boolean;

    FOffset : TPoint;

    procedure SetCharSymbol(const Value: Char);
    procedure SetFontName(const Value: string);
    procedure SetFontSize(const Value: integer);

    procedure SetOffset(const Index, Value: integer);
  public

    constructor Create;
    procedure Draw(aCnv: TCanvas);     override;
    procedure ConvertCoord(aMap: TMap); override;

    function IsHit(const x, y: integer): boolean;

    property CharSymbol: Char read FCharSymbol write SetCharSymbol;
    property FontName  : string read FFontName write SetFontName;
    property FontSize  : integer read FFontSize write SetFontSize;

    property OffsetX : integer index 0  read FOffset.X write SetOffset;
    property OffsetY : integer index 1  read FOffset.Y write SetOffset;
  end;

{1.4.1}
//==============================================================================
{1.5}
  TLPDFixDisplay = class (TItemTDC)
  protected
    FRect : TRect;
    function GetHeight: integer;
    function GetWidth: integer;

    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetWidth(const Value: integer);
    procedure SetHeight(const Value: integer);
  public

    constructor Create;
    procedure Draw(aCnv: TCanvas);  override;

    property Left: integer read FRect.Left write SetLeft;
    property Top: integer read FRect.Top write SetTop;
    property Width: integer read GetWidth write SetWidth;
    property Height: integer read GetHeight write SetHeight;

  end;

//==============================================================================
{1.5.1} {wida}
  TLPDStatus = class (TLPDFixDisplay)
  public
    CPORT : array [0..3, 0..3] of String;
    CSTB : array [0..3, 0..3] of String;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;
//==============================================================================
{1.6}
  TTorpTest = class (TLPDFixDisplay)

  public
    step : Byte;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;

  end;
//==============================================================================
//==============================================================================
{1.5.1}
  TLPDTest = class (TLPDFixDisplay)
  protected

    procedure DrawTextTest(aCnv: TCanvas);
  public

    constructor Create;
    procedure Draw(aCnv: TCanvas);  override;

  end;

//==============================================================================
{1.5.2}
  TLPDDisplayText = class (TLPDFixDisplay)
  protected

  public
    Line1, Line2 : string;

    constructor Create;
    procedure Draw(aCnv: TCanvas);  override;

  end;

//==============================================================================
  TEngagementBox = class(TItemTDC)
    private
      FTrails         : array [0..39] of t2DPoint;
      FPixelTrails    : array [0..39] of TPoint;
      FOrigin         : t2DPoint;
      FTimer          : double;
      VisibleCount    : byte;
      FEngageCursor   : TTDC_Cursor;

    public
      HeadingNorth    : single;
      EngageMode      : TEngageStatus;
      //EngagedTrack    : TTDCTrack;

      constructor Create;
      procedure ConvertDataPosition(aMap: TMap);
      procedure Draw(aCnv: TCanvas); override;
      procedure UpdateOrigin(const x1, y1, x2, y2: double);

      procedure Run(const aDeltaMs: double);

    end;


implementation

uses
  uBaseConstan, uBaseFunction,  Math, Types, SysUtils;

//==============================================================================

function CreateCursorPen(const style: byte; const aClr : TColor): HPEN;
type
  TCursor_Pattern = array[0..3] of DWORD;
const
  CursorPattern : array[0..7] of TCursor_Pattern =
  ( (2,  0,  2, 0),
    (4,  4,  4, 4),
    (8,  8,  8, 8),
    (12, 4, 12, 4),
    (20, 8, 20, 8),
    (12, 8, 12, 8),
    (12, 4,  4, 4),
    (20, 4,  4, 4)
    );

var pBrush  : TLogBrush;
    pStyle   : Pointer;
begin
  pBrush.lbStyle := BS_SOLID;
  pBrush.lbColor := aClr;
  pBrush.lbHatch := HS_VERTICAL;

  pStyle := @CursorPattern[style];
  result := ExtCreatePen(
     PS_GEOMETRIC or PS_USERSTYLE	,
     1,
     pBrush,
     4,
     pStyle);
end;


//==============================================================================
{ TItemTDC }
constructor TItemTDC.Create;
begin
  Color      := C_defColor;
  Visible := FALSE;
  Enabled := FALSE;
end;


//==============================================================================

//==============================================================================
{ TTDC_Cursor }

constructor TTDC_Cursor.Create;
begin
  inherited;
//  FDistance := 32 * C_NauticalMile_To_Degree;
//  FHeading := 90;
  FDistance := 0;
  FHeading  := 0;
//  SetHeading(000);

  Style := psSolid;
  Color := C_defColor;

end;

procedure TTDC_Cursor.UpdateEndCoord;
var sinx, cosx, headEast: extended;
begin
  headEast := C_DegToRad * (FHeading);
  SinCos(headEast, sinX, cosX );

  EndCoord.x := Org.X + FDistance  * cosX;
  EndCoord.y := Org.Y + FDistance  * sinX;
end;

procedure TTDC_Cursor.SetHeading(const Head: double);
begin
  FHeading := ConvCompass_To_Cartesian(Head);
  UpdateEndCoord;
end;

procedure TTDC_Cursor.SetDistance(const Value: double);
begin
  FDistance := C_NauticalMile_To_Degree * Value;
  UpdateEndCoord;
end;

function TTDC_Cursor.GetDistance: double;
begin
  Result := C_Degree_To_NauticalMile * FDistance;
end;

function TTDC_Cursor.GetHeading: double;
begin
  result := ConvCartesian_To_Compass(FHeading);
end;

procedure TTDC_Cursor.ConvertCoord(aMap: TMap);
var sx, sy: single;
begin
  if not Visible then exit;

  aMap.ConvertCoord(sx, sy, Org.X, Org.Y , miMapToScreen);
  Center := Point(Round(sx), Round(sy));

  aMap.ConvertCoord(sx, sy, EndCoord.X, EndCoord.Y , miMapToScreen);
  ptH := Point(Round(sx), Round(sy));
end;

procedure TTDC_Cursor.SetStartCoord(const x, y: double);
begin
  Org.X := x;
  Org.Y := y;

  UpdateEndCoord;
end;

procedure TTDC_Cursor.SetEndCoord(const x, y: double);
var dx, dy, bearing : Extended;
begin
  EndCoord.X := x;
  EndCoord.Y := y;

  dx := (EndCoord.x - Org.X);
  dy := (EndCoord.y - Org.Y);

  FDistance := sqrt(sqr(dx) + sqr(dy));
  FHeading  := RadToDeg(ArcTan2(dy, dx));
end;

procedure TTDC_Cursor.Draw(aCnv: TCanvas);
begin
  if not Visible then exit;

  aCnv.Pen.Color := Color;
  aCnv.Pen.Width := 1;
  aCnv.Pen.Style := Style;

//  aCnv.MoveTo(ptC.X, ptC.Y);
  aCnv.MoveTo(Center.X, Center.Y);
  aCnv.LineTo(ptH.X, ptH.Y);
end;

//==============================================================================
{ TBlindARCS }
constructor TBlindARCS.Create(const Num: integer);
var i: integer;
  st: TPenStyle;
begin
  inherited Create;

  FCursorCount := 2 * Num;
  SetLength(FCursors, FCursorCount);

  for i := 0 to FCursorCount-1 do begin
    FCursors[i] := TTDC_Cursor.Create;
    if i mod 2 = 1 then begin
      case i of
      1: st:= psDash;
      3: st:= psDashDot;
      5: st:= psDashDotDot;
      7, 9: st := psDot;
      end;

      FCursors[i].Style := st;
      FCursors[i-1].Style := st;
    end;
  end;

  //SetLength(GunOffset, 5);
  //SetLength(DirOffset, 5);
  case num of
    2: begin
      GunOffset[1] := 80;
      GunOffset[2] := 100;
      GunOffset[3] := 60;
      GunOffset[4] := 35;
      GunOffset[5] := 35;

      DirOffset[1] := 0;
      DirOffset[2] := 0;
      DirOffset[3] := 90;
      DirOffset[4] := -90;
      DirOffset[5] := 90;
    end;
    3: begin
      GunOffset[1] := 130;
      GunOffset[2] := 60;
      GunOffset[3] := 60;
      GunOffset[4] := 35;
      GunOffset[5] := 35;

      DirOffset[1] := 0;
      DirOffset[2] := -90;
      DirOffset[3] := 90;
      DirOffset[4] := -90;
      DirOffset[5] := 90;
    end;
  end;
  //FCursors[0].Style := psDash;  //
  //FCursors[1].Style := psDash;
  //FCursors[2].Style := psDashDot;
  //FCursors[3].Style := psDashDot;
  //FCursors[4].Style := psDashDotDot;
  //FCursors[5].Style := psDashDotDot;
  //FCursors[6].Style := psDot;
  //FCursors[7].Style := psDot;
  //FCursors[8].Style := psDot;
  //FCursors[9].Style := psDot;

end;

destructor TBlindARCS.Destroy;
var i: integer;
begin
  for i := 0 to FCursorCount-1 do
    FCursors[i].Free;

  SetLength(FCursors, 0);
  inherited;
end;

procedure TBlindARCS.SetHeading(const Head: double);
var i: integer;
    l, r : double;
begin
  FHeading := ConvCompass_To_Cartesian(Head);
  for i := 1 to FCursorCount div 2 do begin
    GetGunAngle(Head, i, l, r);                //kompass
    FCursors[2*(i-1)].Heading   := l;
    FCursors[2*(i-1)+1].Heading := r;
  end;

end;

procedure TBlindARCS.ConvertCoord(aMap: TMap);
var i: integer;
begin
  inherited;
  if not Visible then exit;

  for i := 0 to FCursorCount-1 do  begin
    FCursors[i].Org := Org;
    FCursors[i].ConvertCoord(aMap);
  end;

end;


procedure TBlindARCS.Draw(aCnv: TCanvas);
var i: integer;
begin
//not inherited,
  if not Visible then exit;

  for i := 0 to FCursorCount-1 do
    FCursors[i].Draw(aCnv);

end;

procedure TBlindArcs.GetGunAngle(const shipHeading: double;
                                 const Gun: byte;
                                 var LeftAngle, RightAngle: Double);
{const GunOffset: array [1..5] of single =
 (130, 60, 60, 35, 35);
 DirOffset: array[1..5] of single =
 (0, -90, 90 , -90, 90);}
begin
  if (gun >= 1) and (gun <= 5) then begin
    LeftAngle  := ValidateDegree(shipHeading - GunOffset[Gun] + DirOffset[Gun]);
    RightAngle := ValidateDegree(shipHeading + GunOffset[Gun] + DirOffset[Gun]);
 end;
end;

procedure TBlindArcs.SetVisibles(const v: boolean);
var i: integer;
begin
  Visible := v;
  for i := 0 to FCursorCount-1 do
    FCursors[i].Visible := v;

end;
 
//-------------------------------------------------------------------------
//==============================================================================
{ TWeaponAssignView }

procedure TWeaponAssignView.SetDirection(const Value: double);
begin
  FDirection := ConvCompass_To_Cartesian(Value);
end;

function TWeaponAssignView.GetDirection: double;
begin
  Result := ConvCartesian_To_Compass(FDirection);
end;

//-------------------------------------------------------------------------
procedure TWeaponAssignView.SetRange(const Value: double);
begin
  FRange := Value;
end;

function TWeaponAssignView.GetRange: double;
begin
  Result :=  FRange;
end;


{ TAssignSSMView }

constructor TAssignSSMView.Create;
begin
  inherited;
  FLaunchMode := lmRBL;
//  FLaunchMode := lmBOL;

  SetRangeToGo(szMedium);
  SetSearch_Depth(szMedium);
  SetSearch_Width(szMedium);
end;

procedure TAssignSSMView.ConvertCoord(aMap: TMap);
begin
   {mode range and bearing}
  if not Visible then exit;

  Center := Convert_MapToScreen(aMap, Org);
  pt1.Sc :=  Convert_MapToScreen(aMap, pt1.Mx);

  ptHit.Sc :=  Convert_MapToScreen(aMap, ptHit.Mx);

  stL.Sc :=  Convert_MapToScreen(aMap, stL.Mx);
  stR.Sc :=  Convert_MapToScreen(aMap, stR.Mx);

  enL.Sc :=  Convert_MapToScreen(aMap, enL.Mx);
  enR.Sc :=  Convert_MapToScreen(aMap, enR.Mx);

end;


procedure TAssignSSMView.Draw(aCnv: TCanvas);
begin
  if not Visible then exit;
  if FLaunchMode = lmRBL then

  with aCnv do begin
    Pen.Color := Color;
    Pen.Style := psSolid;
    MoveTo(Center.X, Center.Y);
    LineTo(ptHit.Sc.X, ptHit.Sc.Y);

    MoveTo(stL.Sc.X, stL.Sc.Y);
    LineTo(enL.Sc.X, enL.Sc.Y);
    LineTo(enR.Sc.X, enR.Sc.Y);
    LineTo(stR.Sc.X, stR.Sc.Y);
    LineTo(stL.Sc.X, stL.Sc.Y);

  end
  else   with aCnv do begin
    Pen.Color := Color;
    Pen.Style := psSolid;
    MoveTo(Center.X, Center.Y);
    LineTo(pt1.Sc.X, pt1.Sc.Y);

    MoveTo(pt1.Sc.X, pt1.Sc.Y);
    LineTo(enL.Sc.X, enL.Sc.Y);

    MoveTo(pt1.Sc.X, pt1.Sc.Y);
    LineTo(enR.Sc.X, enR.Sc.Y);

    MoveTo(pt1.Sc.X, pt1.Sc.Y);
    LineTo(ptHit.Sc.X, ptHit.Sc.Y);
  end;

end;

procedure TAssignSSMView.SetDirection(const Value: double);
begin
  inherited;
  UpdateRangeDirection;

end;

procedure TAssignSSMView.SetRange(const Value: double);
begin
  inherited;
  UpdateRangeDirection;

end;

procedure TAssignSSMView.UpdateRangeDirection;
var range1, range2: double;
begin
  if FLaunchMode = lmRBL then begin
    range1 := FRange - mRangeToGo;
    pt1.Mx   := CalcPositionAhead(Org, range1, FDirection);

    ptHit.Mx := CalcPositionAhead(Org, FRange, FDirection);

    stL.Mx := CalcPositionAhead(pt1.Mx, mRangeToGo - mSearchDepth, FDirection + mManWidth);
    stR.Mx := CalcPositionAhead(pt1.Mx, mRangeToGo - mSearchDepth, FDirection - mManWidth);

    enL.Mx := CalcPositionAhead(pt1.Mx, mRangeToGo + mSearchDepth, FDirection + mManWidth);
    enR.Mx := CalcPositionAhead(pt1.Mx, mRangeToGo + mSearchDepth, FDirection - mManWidth);
  end
  else begin
    range1 := 4.0  * C_KiloMeter_To_NauticalMiles;
    range2 := 36.0 * C_KiloMeter_To_NauticalMiles;

    pt1.Mx   := CalcPositionAhead(Org, range1, FDirection);

    ptHit.Mx := CalcPositionAhead(pt1.Mx, range2, FDirection);
    enL.Mx := CalcPositionAhead(pt1.Mx, range2, FDirection + mManWidth);
    enR.Mx := CalcPositionAhead(pt1.Mx, range2, FDirection - mManWidth);

  end;
{}
end;

procedure TAssignSSMView.SetRangeToGo(const Value: TLetterSize);
begin
  FRangeToGo := Value;
  case Value of
     szSmall  : mRangeToGo := 5000.0  * C_Meter_To_NauticalMiles;
     szMedium : mRangeToGo := 8000.0  * C_Meter_To_NauticalMiles;
     szLarge  : mRangeToGo := 12000.0 * C_Meter_To_NauticalMiles;
  end;
end;

procedure TAssignSSMView.SetSearch_Depth(const Value: TLetterSize);
begin
  FSearch_Depth := Value;
  case Value of
		szSmall  : mSearchDepth := 750.0  * C_Meter_To_NauticalMiles;
		szMedium : mSearchDepth := 1812.5 * C_Meter_To_NauticalMiles;
		szLarge  : mSearchDepth := 2500.0 * C_Meter_To_NauticalMiles;
  end;
end;

procedure TAssignSSMView.SetSearch_Width(const Value: TLetterSize);
begin
  FSearch_Width := Value;
  case Value of
		szSmall   : mManWidth := 2.5;
		szMedium  : mManWidth := 6.25;
		szLarge   : mManWidth := 10.0;
  end;
end;

procedure TAssignSSMView.SetLaunchMode(const Value: TLaunchMode);
begin
  FLaunchMode := Value;
end;
{ TAssignTorpedoView }

constructor TAssignTorpedoView.Create;
begin
   inherited;
end;

procedure TAssignTorpedoView.ConvertCoord(aMap: TMap);
begin
    // nautical mile
  // left
  if not Visible then exit;

  LeftPoint.Mx  := CalcPositionAhead(org, FRange, FDirection + 45);
  RightPoint.Mx := CalcPositionAhead(org, FRange, FDirection - 45);

  LeftPoint.Sc  := Convert_MapToScreen(aMap, LeftPoint.Mx);
  RightPoint.Sc := Convert_MapToScreen(aMap, RightPoint.Mx);
  Center := Convert_MapToScreen(aMap, Org);
end;

procedure TAssignTorpedoView.Draw(aCnv: TCanvas);
begin
  if not Visible then exit;

  with aCnv do begin
    Pen.Color := Color;

    MoveTo(LeftPoint.Sc.X, LeftPoint.Sc.Y);
    LineTo(Center.X, Center.Y);
    LineTo(RightPoint.Sc.X, RightPoint.Sc.Y);
  end;

end;
//-------------------------------------------------------------------------
{ TLPDDisplayText }

constructor TLPDDisplayText.Create;
begin
   inherited;

end;

procedure TLPDDisplayText.Draw(aCnv: TCanvas);
var sz: TSize;
begin
  if not visible then exit;
  with aCnv do begin
    Font.Color := C_defColor;
    Font.Name := 'Verdana';
    Font.Size := 7;


    sz := TextExtent(Line1);
    SetBkMode(handle, TRANSPARENT);

    TextOut(FRect.Left + 10 , FRect.Top, Line1);
    TextOut(FRect.Left + 10, FRect.Top + sz.cy + 10, Line2);

  end;

end;

//-------------------------------------------------------------------------
{ TTDCSymbol }

constructor TTDCSymbol.Create;
begin
  inherited;

  FRect := Rect(0,0,0,0);
  FFontSize := 12;
  FFontName := 'TDCCursor';
  CharSymbol := 'H';

  FOffset.X := 0;
  FOffset.Y := 0;

  FSymbolChange := true;
end;

procedure TTDCSymbol.ConvertCoord(aMap: TMap);
begin
  inherited;
  Center   := Convert_MapToScreen(aMap, Org);
end;

procedure TTDCSymbol.Draw(aCnv: TCanvas);
var sz, hSz: TSize;
begin
  if not Visible then exit;

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  FFontName;
    Font.Size  :=  FontSize;
    Font.Color :=  Color;
    sz :=  TextExtent(CharSymbol);

//    if FSymbolChange then begin
      hSz.cx := sz.cx shr 1;
      hSz.cy := sz.cy shr 1;

      //aligned center
      FRect.Left   :=  FOffset.X + Center.X   - hSz.cx;
      FRect.Top    :=  FOffset.Y + Center.Y   - hSz.cy;
      FRect.Right  :=  FOffset.X + FRect.Left + sz.cx;
      FRect.Bottom :=  FOffset.Y + FRect.Top  + sz.cx;

      FSymbolChange := false;
//    end;
    TextOut(FRect.Left, FRect.Top,
            CharSymbol);
  end;
end;

function TTDCSymbol.IsHit(const x, y: integer): boolean;
begin
  result := PtInRect(FRect, Point(x, y));
end;

procedure TTDCSymbol.SetCharSymbol(const Value: Char);
begin
  FCharSymbol := Value;
  FSymbolChange := true;
end;

procedure TTDCSymbol.SetFontName(const Value: string);
begin
  FFontName := Value;
  FSymbolChange := true;
end;

procedure TTDCSymbol.SetFontSize(const Value: integer);
begin
  FFontSize := Value;
  FSymbolChange := true;
end;

procedure TTDCSymbol.SetOffset(const Index, Value: integer);
begin
  case index of
    0 : FOffset.X := Value;
    1 : FOffset.Y := Value;
  end;
  FSymbolChange := true;
end;

{ TLPDFixDisplay }

constructor TLPDFixDisplay.Create;
begin

end;



procedure TLPDFixDisplay.SetLeft(const Value: integer);
begin
  FRect.Right:= Value + (FRect.Right - FRect.Left);
  FRect.Left := Value;
  Center.X := (FRect.Left + FRect.Right) shr 1;
end;

procedure TLPDFixDisplay.SetTop(const Value: integer);
begin
  FRect.Bottom:= Value + (FRect.Bottom - FRect.Top);
  FRect.Top := Value;
  Center.Y := (FRect.Top +  FRect.Bottom) shr 1;
end;

procedure TLPDFixDisplay.SetWidth(const Value: integer);
begin
  FRect.Right:= FRect.Left + Value;
  Center.X := (FRect.Left + FRect.Right) shr 1;
end;

procedure TLPDFixDisplay.SetHeight(const Value: integer);
begin
  FRect.Bottom := FRect.Top + Value;
  Center.Y := (FRect.Top +  FRect.Bottom) shr 1;
end;

function TLPDFixDisplay.GetHeight: integer;
begin
  result := (FRect.Bottom - FRect.Top);
end;

function TLPDFixDisplay.GetWidth: integer;
begin
  result := (FRect.Right - FRect.Left);
end;

procedure TLPDFixDisplay.Draw(aCnv: TCanvas);
begin
  inherited;

end;

{ TLPDTest }

constructor TLPDTest.Create;
begin
   inherited;
   Color := C_defColor;

end;


procedure TLPDTest.DrawTextTest(aCnv: TCanvas);
  function GetPost(const pt: TPoint; const ix, iy: integer): TPoint;
  const spcX = 12; spcY = 15;
  begin
    result.X := pt.X + spcX * ix;
    result.Y := pt.Y + spcY * iy;
  end;
const
  FI: array[0..2] of string  //font index
    = ('Arial', 'TDCCursor', 'TDCIdent');
  FM : array [0..7, 0..17] of byte =
 (( 0,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0),
  ( 0,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0),
  ( 0,  0,  0,  0,    0,  0,  1,  1,    1,  1,  1,  1,    1,  1,  1,  1,    1,  1),
  ( 2,  0,  2,  0,    2,  0,  2,  0,    2,  0,  2,  0,    2,  0,  2,  0,    2,  0),
//-----------------------------------------------------------------------------------//
  ( 2,  0,  1,  0,    1,  0,  1,  0,    1,  0,  1,  0,    0,  0,  0,  0,    1,  0),
  ( 1,  0,  1,  0,    1,  0,  1,  0,    2,  0,  2,  0,    2,  0,  2,  0,    0,  0),
  ( 1,  0,  1,  0,    0,  0,  0,  0,    0,  0,  0,  0,    2,  0,  1,  0,    1,  0),
  ( 1,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0,  0,  0,    0,  0) );

 CM : array [0..7, 0..17] of char =
 (('0','1','2','3',  '4','5','6','7',  '8','9',':',';',  '*',' ','?','A',  'B','C'),
  ('D','E','F','G',  'H','I','J','K',  'L','M','N','O',  'P','Q','R','S',  'T','U'),
  ('V','W','X','Y',  'Z',' ','K',' ',  'G',' ','P',' ',  'M',' ','_',' ',  'L',' '),
  ('A',' ','C',' ',  'B',' ','G',' ',  'D',' ','A',' ',  'B',' ','E',' ',  'J',' '),
//-----------------------------------------------------------------------------------//
  ('K',' ','O',' ',  'P',' ','O',' ',  'D',' ','E',' ',  'X',' ','x',' ',  'F',' '),
  ('Q',' ','N',' ',  'H',' ','C',' ',  'R',' ','G',' ',  'I',' ','H',' ',  '0',' '),
  ('L',' ','P',' ',  '.',' ','.',' ',  '0',' ','0',' ',  'U',' ','F',' ',  'I',' '),
  ('H',' ','(',' ',  ')',' ','*',' ',  '+',' ','.',' ',  '-',' ','.',' ',  '/',' '));

var
   i, j: integer;
   p1, p2: tPoint;

begin
  p1.X := Center.X - width div 4 - 30;
  p1.Y := Center.Y - width div 4;

  with aCnv do begin
    Font.Size := 8;
    for j := 0 to 7 do
      for i := 0 to 17 do begin
        p2 :=  GetPost(p1, i, j);
        Font.Name := FI[FM[j,i]];
        TextOut(p2.X, p2.Y, CM[j,i]);
      end;
  end;
end;


procedure TLPDTest.Draw(aCnv: TCanvas);
var i: integer;
    dist, delta, hw: integer;
    r: TRect;
    pt1, pt2 : TPoint;
    cPen : HPEN;
    savePen : HGDIOBJ;

begin
  // draw 4  'range ring'
  if not visible then exit;

  with aCnv do begin
    Pen.Color := Color;
    Pen.Style := psSolid;
    MoveTo(Center.X, FRect.Top);
    LineTo(Center.X, FRect.Bottom);

    MoveTo(FRect.Left ,  Center.Y);
    LineTo(FRect.Right,  Center.Y);
  end;
  delta := (Width) shr 3; // seperempat jari jari;

  dist := Round(delta * cos(0.25 * PI ));
  pt1.X := Center.X - dist;
  pt1.Y := Center.Y - dist;

  dist := dist * 4;

  with aCnv do begin
    MoveTo(Center.x, Center.Y);
    LineTo(pt1.X , pt1.Y);

    MoveTo(Center.X - dist, Center.Y);
    LineTo(Center.X, Center.Y + dist);

    LineTo(Center.X + dist, Center.Y);
    LineTo(Center.X, Center.Y - dist);
    LineTo(Center.X - dist, Center.Y);
  end;

  cPen := CreateCursorPen(0, Color);
  savePen := SelectObject(aCnv.Handle, cPen);
  aCnv.MoveTo(Center.x + dist, Center.Y - dist);
  aCnv.LineTo(Center.x       , Center.Y - dist);
  DeleteObject(cPen);

  cPen := CreateCursorPen(1, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x - dist , Center.Y - dist);
  DeleteObject(cPen);

  cPen := CreateCursorPen(2, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x - dist , Center.Y );
  DeleteObject(cPen);

  cPen := CreateCursorPen(3, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x - dist , Center.Y + dist);
  DeleteObject(cPen);

  cPen := CreateCursorPen(4, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x        , Center.Y + dist);
  DeleteObject(cPen);

  cPen := CreateCursorPen(5, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x + dist, Center.Y + dist);
  DeleteObject(cPen);

  cPen := CreateCursorPen(6, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x + dist, Center.Y );
  DeleteObject(cPen);

  cPen := CreateCursorPen(7, Color);
  SelectObject(aCnv.Handle, cPen);
  aCnv.LineTo(Center.x + dist, Center.Y - dist);
  DeleteObject(cPen);

  SelectObject(aCnv.Handle, SavePen);

  for i := 1 to 4 do begin
    dist := i * delta;
    r := ptToRect(Center, dist);

    with aCnv do begin
      Pen.Color := Color;
      Pen.Style := psSolid;
      Arc(r.Left, r.Top, r.Right, r.Bottom, 0,0,0,0);
    end;
  end;

  pt1.X := Center.X;
  pt1.Y := FRect.Top + delta div 2;

  with aCnv do begin
    Font.Name := 'Arial';
    Font.Size := 10;
    SetTextAlign(aCnv.Handle, TA_CENTER);
    TextOut( pt1.X, pt1.Y, 'LPD TEST');


    dist := Round(delta * cos(0.25 * PI ));
    hw := (4* dist div 10);

    SetTextAlign(aCnv.Handle, TA_LEFT);
    pt2.X := Center.X - 4 * dist + 20;
    pt2.Y := Center.Y + hw;

    pt1 := pt2;
    TextOut( pt1.X, pt1.Y, 'TM              ...');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'DISP SEL    ...');

    pt1.Y := pt1.Y + 2 * hw;
    TextOut( pt1.X, pt1.Y, 'Q.E.K');
    TextOut( pt1.X + 90, pt1.Y, 'L');
    TextOut( pt1.X + 120, pt1.Y, 'R');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'OVERL.');
    TextOut( pt1.X + 90, pt1.Y, 'L');
    TextOut( pt1.X + 120, pt1.Y, 'R');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'I.C.M.');
    TextOut( pt1.X + 90, pt1.Y, 'L');
    TextOut( pt1.X + 120, pt1.Y, 'R');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'D.R.');
    TextOut( pt1.X + 90, pt1.Y, 'L');
    TextOut( pt1.X + 120, pt1.Y, 'R');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'M.I.K.');
    TextOut( pt1.X + 90, pt1.Y, 'L');
    TextOut( pt1.X + 120, pt1.Y, 'R');

    pt1.Y := pt1.Y + hw;
    TextOut( pt1.X, pt1.Y, 'THRT ASS  ............');

    pt2.x := Center.X + 20;
    pt2.y := Center.Y ;

    pt1 := pt2;
    pt1.Y := pt2.Y + 4 * hw;
    TextOut( pt1.X, pt1.Y, 'OBM');
    TextOut( pt1.X + 90, pt1.Y,             'X  ....');
    TextOut( pt1.X + 90, pt1.Y + hw div 2,  'Y  ....');

    pt1.Y := pt2.Y + 6 * hw;
    TextOut( pt1.X, pt1.Y, 'OFF CENT');
    TextOut( pt1.X + 90, pt1.Y,             'X  ....');
    TextOut( pt1.X + 90, pt1.Y + hw div 2,  'Y  ....');

    pt1.Y := pt2.Y + 9 * hw;
    TextOut( pt1.X, pt1.Y, 'RANGE SEL');
    TextOut( pt1.X + 90, pt1.Y,             '.... DM');
  end;
  DrawTextTest(aCnv);
end;

//==============================================================================
{ TEngagementBox }

constructor TEngagementBox.Create;
begin
  HeadingNorth := 0;
  FTimer := 0.0;
  FEngageCursor := TTDC_Cursor.Create;
end;

procedure TEngagementBox.ConvertDataPosition(aMap: TMap);
var i: integer;
    sx, sy : single;
    dx, dy: double;
begin
  for i := 0 to 39 do begin
    dx := FTrails[i].x;
    dy := FTrails[i].y;
    aMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
    FPixelTrails[i].X :=  Round(sx);
    FPixelTrails[i].Y :=  Round(sy);
  end;

  FEngageCursor.ConvertCoord(aMap);
end;

procedure TEngagementBox.Draw(aCnv: TCanvas);
var i: integer;
  procedure DrawCross(aCnv: TCanvas; px, py: integer);
  const sz = 2;
  begin
    aCnv.TextOut(px, py, '*');
  end;
begin
  if (not Visible) or (VisibleCount < 0) then exit;
  if VisibleCount > 0 then begin
    aCnv.Pen.Color := Color;
    for i := 0 to VisibleCount do begin
      DrawCross(aCnv, FPixelTrails[i].X, FPixelTrails[i].Y);
    end;
  end;
  FEngageCursor.Draw(aCnv);
end;

{ TLPDStatus}
constructor TLPDStatus.Create;
var
  i,j : Integer;
begin
  for i:= 0 to 3 do begin
    for j:= 0 to 3 do begin
      CPORT[i,j] := ' ';
      CSTB[i,j] := ' ';
    end;
  end;
end;

procedure TLPDStatus.Draw(aCnv: TCanvas);
function GetPost(const pt: TPoint; const iy: integer): TPoint;
    const spcY = 20;
    begin
      result.Y := pt.Y + spcY * iy;
  end;
const
  FI: array[0..1] of string  //font index
    = ('TorpedoStatus', 'Arial');
  FM : array [0..3, 0..3] of byte =
 (( 0,  0,  0,  0),
  ( 1,  1,  1,  1),
  ( 1,  1,  1,  1),
  ( 1,  1,  1,  1));

var i, j: integer;
    delta: integer;
    pt1, pt2, pt3 : TPoint;
    cPen : HPEN;
    savePen : HGDIOBJ;

begin
  if not visible then exit;

  delta := (Width) shr 3; // seperempat jari jari;

  pt1.X := Center.X - 120;
  pt1.Y := FRect.Top + delta div 2;

  with aCnv do begin
    Font.Name := 'Arial';
    Font.Size := 8;
    SetTextAlign(aCnv.Handle, TA_LEFT);
    TextOut( pt1.X, pt1.Y, 'TORP');
    pt2.X := pt1.X + 90;
    pt2.Y := pt1.Y;
    TextOut(pt2.X, pt2.Y, 'PORT');
    pt3.X := pt2.X + 60;
    pt3.Y := pt2.Y;
    TextOut(pt3.X, pt3.Y, 'STB');

    TextOut(pt1.X, pt1.Y+20, 'STATUS');
    TextOut(pt1.X, pt1.Y+40, 'DEPTH');
    TextOut(pt1.X, pt1.Y+60, 'RUNTIME');
    TextOut(pt1.X, pt1.Y+80, 'WARNING');

    with aCnv do begin
    Font.Size := 8;
    pt1.X := pt1.X + 90;
    for j := 0 to 3 do
    begin
      pt2 :=  GetPost(pt1, j+1);
      for i := 0 to 3 do begin
        Font.Name := FI[FM[j,i]];
        TextOut(pt2.X + i*10, pt2.Y, CPORT[j,i]);
      end;
    end;

    pt2.X := pt1.X + 60;
    pt2.Y := pt1.Y;
    for j := 0 to 3 do
    begin
      pt3 :=  GetPost(pt2, j+1);
      for i := 0 to 3 do begin
        Font.Name := FI[FM[j,i]];
        TextOut(pt3.X + i*10, pt3.Y, CSTB[j,i]);
      end;
    end;
    end;

  end;
end;

{ TTorpTest }
constructor TTorpTest.Create;
begin
  step := 0;
end;

procedure TTorpTest.Draw(aCnv: TCanvas);
var
  pt1: TPoint;
begin
  if not Visible then exit;

  pt1.X := Center.X - 50;
  pt1.Y := FRect.Bottom - 120;

  with aCnv do begin
    font.Name := 'Arial';
    Font.Size := 8;
    SetTextAlign(aCnv.Handle,TA_LEFT);
    TextOut(pt1.X,pt1.Y,'TEST');
    TextOut(pt1.X + 90, pt1.Y, 'OK');

    case step of
    1: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'1');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    2: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'2');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    3: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'3');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    4: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'4');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    5: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'5');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    6: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'6');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    7: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'6.1');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    8: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'6.2');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    9: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'6.3');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    10: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'7.1');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    11: begin
        TextOut(pt1.X + 10,pt1.Y + 20,'7.2');
        TextOut(pt1.X + 90, pt1.Y + 20, 'OK');
       end;
    end;

  end;
end;
procedure TEngagementBox.UpdateOrigin(const x1, y1, x2, y2: double);
var i: integer;
    dR, r : double;
    sinA, cosA, headEast : extended;
    sinPlus90, cosPlus90, headPlus90: extended;
    sinPlus180, cosPlus180, headPlus180: extended;
    sinPlus270, cosPlus270, headPlus270: extended;
const Sisi = 15; //nm
  Diag = 10.6;
begin
  FEngageCursor.Visible := Visible;
  
  if not Visible then exit;
  
  headEast := C_DegToRad * ConvCompass_To_Cartesian(HeadingNorth);
  SinCos(headEast, sinA, cosA);
  headPlus90 := C_DegToRad * ConvCompass_To_Cartesian(HeadingNorth + 90.0);
  SinCos(headPlus90, sinPlus90, cosPlus90 );
  headPlus180 := C_DegToRad * ConvCompass_To_Cartesian(HeadingNorth + 180.0);
  SinCos(headPlus180, sinPlus180, cosPlus180 );
  headPlus270 := C_DegToRad * ConvCompass_To_Cartesian(HeadingNorth + 270.0);
  SinCos(headPlus270, sinPlus270, cosPlus270 );

  r := Sisi / 2;
  FOrigin.X := x1 + (r * cosA * C_NauticalMile_To_Degree) + (r * cosPlus90 * C_NauticalMile_To_Degree);
  FOrigin.Y := y1 + (r * sinA * C_NauticalMile_To_Degree) + (r * sinPlus90 * C_NauticalMile_To_Degree);

  dR := Sisi * C_NauticalMile_To_Degree * 0.1;

  for i := 0 to 9 do begin
     FTrails[i].X := FOrigin.X - (i + 1)* dR * cosA;
     FTrails[i].Y := FOrigin.Y - (i + 1)* dR * sinA;
  end;
  for i := 10 to 19 do begin
     FTrails[i].X := FTrails[9].X - (i + 1 - 10)* dR * cosPlus90;
     FTrails[i].Y := FTrails[9].Y - (i + 1 - 10)* dR * sinPlus90;
  end;
  for i := 20 to 29 do begin
     FTrails[i].X := FTrails[19].X - (i + 1 - 20)* dR * cosPlus180;
     FTrails[i].Y := FTrails[19].Y - (i + 1 - 20)* dR * sinPlus180;
  end;
  for i := 30 to 39 do begin
     FTrails[i].X := FTrails[29].X - (i + 1 - 30)* dR * cosPlus270;
     FTrails[i].Y := FTrails[29].Y - (i + 1 - 30)* dR * sinPlus270;
  end;

  case EngageMode of
    teTrialReview: FEngageCursor.Style := psDot;
    teEngage: FEngageCursor.Style := psSolid;
    //teCeaseEngage: FEngageCursor.Visible := false;
  end;

  FEngageCursor.Org.X := x2;
  FEngageCursor.Org.Y := y2;
  FEngageCursor.Heading := CalcBearing(x2, y2, x1, y1);
  FEngageCursor.Distance := CalcRange(x2, y2, x1, y1);

end;

procedure TEngagementBox.Run(const aDeltaMs: double);
begin
  if Visible then begin
    FTimer  := FTimer  + aDeltaMs;
    if FTimer > 50 then begin
      FTimer  := 0;
      VisibleCount := (VisibleCount + 1) mod 40;
      if VisibleCount = 0 then begin
        //HeadingNorth := Course;
        //UpdateOrigin;
      end
    end;
  end;
end;

end.
