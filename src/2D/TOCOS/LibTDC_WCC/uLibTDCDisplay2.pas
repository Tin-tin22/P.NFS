unit uLibTDCDisplay;

interface

uses
  Classes, Windows, Graphics, MapXLib_TLB, uBaseDataType,
  uMapXSim, sysUtils;

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
  tFOC = class (TItemTDC)
  protected
    FHexs : array [0..5] of TPoint;

  public
    SpeedKnot : double;
    FDistance : double;

    constructor Create;

    procedure Draw(aCnv: TCanvas);     override;
    procedure Run(const aDt: double);  override;
    procedure ConvertCoord(aMap: TMap); override;
  end;

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

      procedure SetHeading(const Head: double); virtual;
      procedure SetDistance(const Value: double);
    public
      Style: TPenStyle;

      constructor Create;

      procedure Draw(aCnv: TCanvas);       override;
      procedure ConvertCoord(aMap: TMap);  override;

      property Heading: double read  GetHeading write SetHeading;   // Compass  Ship Heading;
      property Distance: double read GetDistance write SetDistance; // nautical miles, scale range:

      property EndPoint: TPoint read ptH write ptH;
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

      procedure SetDirection(const Value: double);
      procedure SetRange(const Value: double);
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

    public
      constructor Create;
      procedure Draw(aCnv: TCanvas);     override;
      procedure ConvertCoord(aMap: TMap); override;

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
    THitPointPrediction  = class (TItemTDC)
    public
      CharSymbol  : Char;

//      Target  : t2DComboPoint;
//      Hit     : t2DComboPoint;
      constructor Create;
      procedure Draw(aCnv: TCanvas);     override;
      procedure ConvertCoord(aMap: TMap); override;
    end;

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
{gigih}
  TTMADStatus1 = class (TLPDTest)
  public
    CAUTO : array [0..5] of string;
    CMAN : array [0..5] of string;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;
//==============================================================================
  TTMADStatus2 = class (TLPDTest)
  public
    RangeStatusDisplay: string;
    CSU : array [0..2] of string;
    CPRS : array [0..2] of string;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;
implementation

uses
  uBaseConstan, uBaseFunction,  Math, Types, uTDCConstan;

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
{ tFOC }

constructor tFOC.Create;
begin
  inherited;

  SpeedKnot  := 10;
  FDistance  :=  0; // nautical miles
  Enabled    := FALSE;
end;


procedure tFOC.Run(const aDt: double);
begin
  // aDt =   millisecond
  if  Enabled then
   FDistance  :=  FDistance + SpeedKnot * aDt * C_MilliSecondToHour ;

end;

procedure tFOC.ConvertCoord(aMap: TMap);
var i: integer;
    dr, dx, dy  : double;
    sx, sy, cx, cy  : single;
    t,  tSin, tCos : extended;
begin
  if not Visible then exit;

  dr := C_NauticalMile_To_Degree * FDistance;
  dx := Org.X;
  dy := Org.Y + dr;
  aMap.ConvertCoord(cx, cy, Org.X, Org.y, miMapToScreen);
  aMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

  Center.X := Round(cx);
  Center.Y := Round(cy);

  dr :=  abs(sY - cY);

  for i := 0 to 5 do begin
    t :=  (i * C_Pi)/3;
    SinCos(t, tSin, tCos);
    sx := cX + dr * tCos;
    sy := cY + dr * tSin;
    FHexs[i].X := Round(sx);
    FHexs[i].Y := Round(sY);
  end;
end;


procedure tFOC.Draw(aCnv: TCanvas);
var i: integer;
begin
  if not Visible then exit;

  aCnv.Pen.Color := Color;
  aCnv.MoveTo(FHexs[0].X, FHexs[0].Y);
  for i := 0 to 5 do
    aCnv.LineTo(FHexs[i].X, FHexs[i].Y);
  aCnv.LineTo(FHexs[0].X, FHexs[0].Y);

end;


//==============================================================================
{ TTDC_Cursor }

constructor TTDC_Cursor.Create;
begin
  inherited;
  FDistance := 128 * C_NauticalMile_To_Degree;
  FHeading := 90;
  Style := psSolid;
end;

procedure TTDC_Cursor.SetHeading(const Head: double);
begin
  FHeading := ConvCompass_To_Cartesian(Head);
end;

procedure TTDC_Cursor.SetDistance(const Value: double);
begin
  FDistance := C_NauticalMile_To_Degree * Value;
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
    pt: t2DPoint;
    sinx, cosx, headEast: extended;
begin
  if not Visible then exit;

  headEast := C_DegToRad * (FHeading);
  SinCos(headEast, sinX, cosX );

  pt.x := Org.X + FDistance  * cosX;
  pt.y := Org.Y + FDistance  * sinX;

  aMap.ConvertCoord(sx, sy, Org.X, Org.Y , miMapToScreen);
//  ptC := Point(Round(sx), Round(sy));
  Center := Point(Round(sx), Round(sy));

  aMap.ConvertCoord(sx, sy, pt.X, pt.Y , miMapToScreen);
  ptH := Point(Round(sx), Round(sy));
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

end;

procedure TAssignSSMView.ConvertCoord(aMap: TMap);
var range1, range2: double;
begin
   {mode range and bearing}
  if not Visible then exit;


  range1 := 4.0 * C_KiloMeter_To_NauticalMiles;
  range2 := range1 +  0.6 * FRange;

  pt1.Mx   := CalcPositionAhead(Org, range1, FDirection);
  ptHit.Mx := CalcPositionAhead(Org, FRange, FDirection);

  stL.Mx := CalcPositionAhead(pt1.Mx, range2, FDirection + 12);
  stR.Mx := CalcPositionAhead(pt1.Mx, range2, FDirection - 12);

  enL.Mx := CalcPositionAhead(pt1.Mx, FRange + range1, FDirection + 12);
  enR.Mx := CalcPositionAhead(pt1.Mx, FRange + range1, FDirection - 12);

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

{    Pen.Style := psDot;
    MoveTo(pt1.Sc.X, pt1.Sc.Y);
    LineTo(stL.Sc.X, stL.Sc.Y);
    MoveTo(pt1.Sc.X, pt1.Sc.Y);
    LineTo(stR.Sc.X, stR.Sc.Y);
}
  end;

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

end;//-------------------------------------------------------------------------

{ THitPointPrediction }
constructor THitPointPrediction.Create;
begin
  inherited;
  CharSymbol := C_Symbol_Char[i_PHP_torpedo];
end;

procedure THitPointPrediction.ConvertCoord(aMap: TMap);
begin
  inherited;
//  Hit.Sc    := Convert_MapToScreen(aMap, Hit.Mx);
//  Target.Sc := Convert_MapToScreen(aMap, Target.Mx);
  Center   := Convert_MapToScreen(aMap, Org);
end;


procedure THitPointPrediction.Draw(aCnv: TCanvas);
var sz: TSize;
begin
  if not Visible then exit;

  //r := ptToRect(Hit.Sc, 10);

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  'TDCCursor';
    Font.Size  :=  12;
    Font.Color :=  C_defColor;
    sz :=  TextExtent(CharSymbol);
    //aligned center
    TextOut(Center.X - sz.cx shr 1,
            Center.Y - sz.cy shr 1 ,
            CharSymbol);
{    TextOut(Hit.Sc.X - sz.cx shr 1,
            Hit.Sc.y - sz.cy shr 1 ,
            CharSymbol);
}
{    pen.Style := psDot;
    MoveTo(FCenter.X, FCenter.Y);
    LineTo(Hit.Sc.X, Hit.Sc.Y);

    MoveTo(Target.Sc.X, Target.Sc.Y);
    LineTo(Hit.Sc.X, Hit.Sc.Y);
    pen.Style := psSolid;
}
  end;
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
//    Brush.Color := clLime;
//    FrameRect(FRect);
    Font.Color := C_defColor;
    Font.Name := 'Verdana';
    Font.Size := 7;


    sz := TextExtent(Line1);
    SetBkMode(handle, TRANSPARENT);

    TextOut(FRect.Left + 10 , FRect.Top, Line1);
    TextOut(FRect.Left + 10, FRect.Top + sz.cy + 10, Line2);


  end;

end;

{ TTMADStatus }
constructor TTMADStatus1.Create;
var
  i : Integer;
begin
  for i:= 0 to 5 do begin
    CAUTO[i] := 'AUTO' + inttostr(i);
    CMAN[i] := 'MAN' + inttostr(i);
  end;
end;

procedure TTMADStatus1.Draw(aCnv: TCanvas);
  function GetPost(const pt: TPoint; const ix: integer): TPoint;
  const spcX = 60;
  begin
    result.X := pt.X + spcX * ix;
    result.Y := pt.Y;
  end;
var i: integer;
    delta: integer;
    pt1, pt2, pt3, pt4, pt5, pt6, pt7 : TPoint;
    cPen : HPEN;
    savePen : HGDIOBJ;
begin
  if not visible then exit;

  delta := (Width) shr 4; // seperempat jari jari;

  pt1.X := Center.X - delta * 2 - 20;
  pt1.Y := FRect.Top + delta + 30;

  with aCnv do begin
    Font.Name := 'Arial';
    Font.Size := 7;
    SetTextAlign(aCnv.Handle, TA_RIGHT);
    TextOut( pt1.X, pt1.Y, 'BNGRAT');
    pt2 := GetPost(pt1, 1);
    TextOut(pt2.X, pt2.Y, 'BEARNG');
    pt3 := GetPost(pt1, 2);
    TextOut(pt3.X, pt3.Y, 'RANGE');
    pt4 := GetPost(pt1, 3);
    TextOut(pt4.X, pt4.Y, 'COURSE');
    pt5 := GetPost(pt1, 4);
    TextOut(pt5.X, pt5.Y, 'A O B');
    pt6 := GetPost(pt1, 5);
    TextOut(pt6.X, pt6.Y, 'SPEED');

    SetTextAlign(aCnv.Handle, TA_LEFT);
    pt7 := GetPost(pt1, -1);
    TextOut(pt7.X, pt7.Y+10, 'AUT');
    TextOut(pt7.X, pt7.Y+20, 'MAN');

    SetTextAlign(aCnv.Handle, TA_RIGHT);
    with aCnv do begin
      Font.Size := 7;
      for i := 0 to 5 do
      begin
        pt2 :=  GetPost(pt1, i);
        Font.Name := 'Arial';
        TextOut(pt2.X, pt2.Y + 10, CAUTO[i]);
      end;

      for i := 0 to 5 do
      begin
        pt2 :=  GetPost(pt1, i);
        Font.Name := 'Arial';
        TextOut(pt2.X, pt2.Y + 20, CMAN[i]);
      end;
    end;
  end;
end;

{ TTMADStatus2 }

constructor TTMADStatus2.Create;
var
  i : Integer;
begin
  for i:= 0 to 2 do begin
    CSU[i] := 'CSU' + inttostr(i);
    CPRS[i] := 'PRS' + inttostr(i);
  end;
  RangeStatusDisplay := '16';
end;

procedure TTMADStatus2.Draw(aCnv: TCanvas);
  function GetPost(const pt: TPoint; const ix: integer): TPoint;
  const spcX = 30;
  begin
    result.X := pt.X + spcX * ix;
    result.Y := pt.Y;
  end;
var i: integer;
    delta: integer;
    pt1, pt2: TPoint;
    cPen : HPEN;
    savePen : HGDIOBJ;
begin
  if not visible then exit;

  delta := (Width) shr 4; // seperempat jari jari;

  pt1.X := Center.X - delta - 20;
  pt1.Y := FRect.Top + delta;

  with aCnv do begin
    Font.Name := 'Arial';
    Font.Size := 7;
    SetTextAlign(aCnv.Handle, TA_LEFT);
    pt2.X := Center.X - 20;
    pt2.Y := pt1.Y - 10;
    TextOut( pt2.X, pt2.Y, RangeStatusDisplay + '  KYD ');
    /////
    TextOut( pt1.X, pt1.Y, 'CSU');
    pt2 := pt1;
    pt2.Y := pt1.Y + 10;
    TextOut(pt2.X, pt2.Y, 'PRS');

    with aCnv do begin
      Font.Size := 7;
      for i := 0 to 2 do
      begin
        pt2 :=  GetPost(pt1, i + 1);
        Font.Name := 'Arial';
        TextOut(pt2.X, pt2.Y, CSU[i]);
      end;

      for i := 0 to 2 do
      begin
        pt2 :=  GetPost(pt1, i + 1);
        Font.Name := 'Arial';
        TextOut(pt2.X, pt2.Y + 10, CPRS[i]);
      end;
    end;
  end;
end;

end.
