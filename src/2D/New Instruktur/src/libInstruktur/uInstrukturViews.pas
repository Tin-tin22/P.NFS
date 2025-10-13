unit uInstrukturViews;

interface

uses
   MapXLib_TLB , Windows, Graphics,
   uBaseSimulationObject, uMapXSim,
   uBaseDataType, uBaseCoordSystem, Classes;

type
//==============================================================================
    TActiveView = class(TSimViewOnMapX)
    public
      function TestHit(const pt: TPoint): boolean; virtual; abstract;
      procedure HandleDrag(const dx, dy: integer); virtual;
    end;

    TObjPoint = class(TObject)
      pointX, pointY : Double;
    end;

//==============================================================================
    //digarap besok oke!
//==============================================================================
  //YogaWay
  TWayPoint = class(TSimViewOnMapX)
    private
      FDrawX : Integer;
      FDrawY : Integer;
      FMapPosX, FMapPosY : Double;
      FWaypointList : TList;
    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      procedure DrawView(aCnv: TCanvas); override;
    published
      property DrawX : Integer read FDrawX write FDrawX;
      property DrawY : Integer read FDrawY write FDrawY;
      property MapPosX : Double read FMapPosX write FMapPosX;
      property MapPosY : Double read FMapPosY write FMapPosY;
      property listWayPoint : TList read FWaypointList write FWaypointList;
  end;
//==============================================================================
    //added by nando for drawing weapon range
    TWeaponRange = class(TActiveView)
    private
      FRotation : integer;
      FHeading   : double;

      FStartAngle : Double;
      FEndAngle   : Double;
      FLowRange   : Double;
      FHighRange  : Double;

      FHitRect  : TRect;

      FRadiusRect : TRect;

      function getRotation: double;
      procedure setRotation(const Value: double);
    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      function TestHit(const pt: TPoint): boolean; override;

    published
      property Heading: double read getRotation write setRotation;

      property StartAngle : Double read FStartAngle write FStartAngle;
      property EndAngle   : Double read FEndAngle write FEndAngle;
      property LowRange   : Double read FLowRange write FLowRange;
      property HighRange  : Double read FHighRange write FHighRange;
    end;


//==============================================================================
    TRotateSymbolView = class(TActiveView)
    private
      FRotation : integer;
      FHeading   : double;

      FHitRect  : TRect;
      function getRotation: double;
      procedure setRotation(const Value: double);

    public
      CharSymbol    : Char;
      FontName      : TFontName;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      function TestHit(const pt: TPoint): boolean; override;

    public
      property Heading: double read getRotation write setRotation;

    end;

//==============================================================================
    TMoveableLineLabel = class (TActiveView)
    private
//      RectCenter: TPoint;
      RectArea  : TRect;
      RectSize  : TSize;

      LabelH : integer; //pix
      LabelW : integer;
      FLines : array [1..5] of string;

      FLineChanged: boolean;
      procedure setLine(const Index: Integer; const Value: string);
      function GetLinee(const Index: Integer): string;
    public
      OffX,
      OffY : Integer;
      BGColor : TColor;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
      function TestHit(const pt: TPoint): boolean; override;
      procedure HandleDrag(const dx, dy: integer); override;

    public

      property Line1: string index 1 read GetLinee write setLine;
      property Line2: string index 2 read GetLinee write setLine;
      property Line3: string index 3 read GetLinee write setLine;
      property Line4: string index 4 read GetLinee write setLine;
      property Line5: string index 5 read GetLinee write setLine;
    end;

//------------------------------------------------------------------------------
    TAdviceSPS = class(TActiveView)
    private
      FRotation : integer;
      FHeading   : double;
      FHitRect  : TRect;

      FRadius,
      FTgtSpeed,
      FTgtRange,
      FTgtBearing,
      FTgtCourse,
      FTgtPosX,
      FTgtPosY : Double;

      FShipSpeed,
      FA244Course,
      FA244Speed  : Double;

      function getRotation: double;
      procedure setRotation(const Value: double);
    public
      SymbolPHP, SymbolELP : TRotateSymbolView;
      MLinePHP, MLineELP   : TMoveableLineLabel;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      function TestHit(const pt: TPoint): boolean; override;
    published
      property Heading: double read getRotation write setRotation;

      property Radius      : Double read FRadius write FRadius;
      property TgtSpeed    : Double read FTgtSpeed write FTgtSpeed;
      property TgtRange    : Double read FTgtRange write FTgtRange;
      property TgtBearing  : Double read FTgtBearing write FTgtBearing;
      property TgtCourse   : Double read FTgtCourse write FTgtCourse;
      property TgtPosX     : Double read FTgtPosX write FTgtPosX;
      property TgtPosY     : Double read FTgtPosY write FTgtPosY;

      property ShipSpeed  : Double read FShipSpeed write FShipSpeed;
      property A244Speed   : Double read FA244Speed write FA244Speed;
      property A244Course  : Double read FA244Course write FA244Course;
    end;

//------------------------------------------------------------------------------
    TSimpleView = class
    public
      ptStart,
      ptEnd   : TPoint;
      Color : TColor;
      Visible : boolean;
      constructor Create;
      procedure DrawView(aCnv: TCanvas); virtual; abstract;
    end;

    TRulerView = class(TSimpleView)
    public
      Range , Bearing : double;
      constructor Create;
      procedure DrawView(aCnv: TCanvas); override;

    end;

    TRectView = class(TSimpleView)
    private

      function getRect: tRect;
      procedure setRect(const Value: tRect);
    public
      constructor Create;
      procedure DrawView(aCnv: TCanvas); override;

      property  Rects: tRect read getRect write setRect;
    end;


implementation

uses
  Math, sysUtils, Types,
  uInstrukturObjects;

{ TActiveView }

procedure TActiveView.HandleDrag(const dx, dy: integer);
begin
//
end;

//==============================================================================
{ TRotateSymbolView }

procedure TRotateSymbolView.ConvertDataPosition;
begin
  inherited;

end;

constructor TRotateSymbolView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;
  FRotation := 0;
  FontName := 'Arial';
  CharSymbol := 'A'

end;

function TRotateSymbolView.getRotation: double;
begin
//  result := 0.1 * FRotation - 90.0;
  result := RadToDeg(FHeading) + 90;
end;

procedure TRotateSymbolView.setRotation(const Value: double);
begin
  FRotation := Round( 10.0 * (90.0 - Value ));
  FHeading := DegToRad(90.0 - Value);
end;

procedure TRotateSymbolView.DrawView(aCnv: TCanvas);
var
  lf : TLogFont;
  tf : TFont;
  sz: TSize;
  q : TPoint;
  sinX, cosX : extended;
begin

  with aCnv do begin
    //Font := TFont.Create;
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;
    Font.Style := [fsBold];

    tf := TFont.Create;
    tf.Assign(Font);
    GetObject(tf.Handle, sizeof(lf), @lf);

    lf.lfEscapement  :=  FRotation;
    lf.lfOrientation :=  FRotation;
//    lf.lfWeight      := 700;

    tf.Handle := CreateFontIndirect(lf);
    Font.Assign(tf);
    tf.Free;

    SetTextAlign(handle, TA_CENTER or VTA_CENTER);
    sz := TextExtent(CharSymbol);

    SetBkMode(Handle, TRANSPARENT);
    SinCos(FHeading , sinX, cosX );

    q.X := CenterCoord.X - Floor( 0.5 * sz.cy * sinX);
    q.Y := CenterCoord.Y - Floor( 0.5 * sz.cy * cosX);

    FHitRect.Left  := CenterCoord.X - (sz.cx shr 1);
    FHitRect.Right := FHitRect.Left + sz.cx;

    FHitRect.Top  := CenterCoord.Y - (sz.cy shr 1);
    FHitRect.Bottom := FHitRect.top + sz.cy;
    //FrameRect(FHitRect);

    TextOut(q.X,  q.Y ,  CharSymbol);
    Font.Style := [];

    Brush.Style := bsClear;
  end;

end;


function TRotateSymbolView.TestHit(const pt: TPoint): boolean;
begin
   result := PtInRect(FHitRect, pt);
end;

{ TMoveableLineLabel }
constructor TMoveableLineLabel.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

  Line1 := '1.satu';
  Line2 := '2.dua';
  Line3 := '3.tiga ';

  OffX := 30;
  OffY := 0;

//  Color := $0080f0;
  //Color := $00FFFFFD;
  Color := $000000;
  BGColor := $600000;

  FLineChanged := true;
end;


procedure TMoveableLineLabel.ConvertDataPosition;
begin
  inherited;

end;


procedure TMoveableLineLabel.DrawView(aCnv: TCanvas);
var ptDrawLine : TPoint;
    sz :  TSize;
    i: integer;
begin
  //inherited;

  with aCnv do begin

    //Font := TFont.Create;
    Font.Orientation := 0;

    Font.Name := 'Verdana';
    Font.Size := 8;
    Font.Color := clBlue;
    Font.Style := Font.Style + [fsBold];

    if FLineChanged then begin
      RectSize.cx := 0;
      RectSize.cy := 0;
      for i := 1 to 5 do begin

        //aldy
        if (i = 2) or (i = 5) then
          Continue;

        sz := TextExtent(FLines[i]);
        if sz.cx > RectSize.cx then
          RectSize.cx := sz.cx;
        RectSize.cy := RectSize.cy + sz.cy;
      end;

      {aldy}
      sz := TextExtent(FLines[3] + '° : ' + Flines[4]);
      if sz.cx > RectSize.cx then
        RectSize.cx := sz.cx;
      {end aldy}

      FLineChanged := false;
    end;

    if OffX < 0 then begin
      rectArea.Left  := CenterCoord.X  + offX - RectSize.cx;
      rectArea.Right := CenterCoord.X  + offX + 8;
    end
    else begin
      rectArea.Left  := CenterCoord.X  + offX ;
      rectArea.Right := CenterCoord.X  + offX + RectSize.cx + 8;
    end;
    rectArea.Top    := CenterCoord.Y  + offY;
    rectArea.Bottom := CenterCoord.Y  + offY + RectSize.cy + 4;


    //Pen.Color   := (BGColor + $00202020) and $00FFFFFF;
    Pen.Color   := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;

//    Brush.Color := $800000;
    Brush.Color := BGColor;
    //Brush.Style := bsSolid;
    Brush.Style := bsClear;

    Rectangle(RectArea);

     if offX >= 0  then
       ptDrawLine.X := RectArea.left
     else
       ptDrawLine.X := RectArea.Right;

    ptDrawLine.Y := RectArea.Top;

    SetBkMode(Handle, TRANSPARENT);
    Pen.Style := psDot;
    MoveTo(CenterCoord.X, CenterCoord.Y);
    LineTo(ptDrawLine.X, ptDrawLine.Y);
    Pen.Style := psSolid;

//   SetBkMode(Handle, TRANSPARENT);
    SetTextAlign(handle, ta_LEFT);
    i := rectArea.Left + 4;
    //before -- terlalu banyak
    {
    TextOut(i, rectArea.Top +  2 ,FLines[1]);
    TextOut(i, rectArea.Top + 14 ,FLines[2]);
    TextOut(i, rectArea.Top + 26, FLines[3]);
    TextOut(i, rectArea.Top + 38, FLines[4]);
    TextOut(i, rectArea.Top + 50, FLines[5]);
    }
    //after -- minimized
    TextOut(i, rectArea.Top +  2 ,FLines[1]);
    TextOut(i, rectArea.Top + 14 ,FLines[3] + '° :' + FLines[4]);
    TextOut(i, rectArea.Top + 26, FLines[5]);
//    TextOut(i, rectArea.Top + 38, FLines[4]);

//    TextOut(i, rectArea.Top + 60, InttoStr(offx) + ', '+InttoStr(offy));

  end;
end;

procedure TMoveableLineLabel.setLine(const Index: Integer;
  const Value: string);
var len,  mxLine : integer;
   i: integer;
begin
  FLines[index] := Value;
  FLineChanged  := TRUE;
end;

function TMoveableLineLabel.GetLinee(const Index: Integer): string;
begin
  result := FLines[Index];
end;

function TMoveableLineLabel.TestHit(const pt: TPoint): boolean;
begin
  result := PtInRect(RectArea, pt);
end;

procedure TMoveableLineLabel.HandleDrag(const dx, dy: integer);
begin
//  inherited;
  OffX := offX + dx;
  OffY := offY + dy;
end;

function PointToRect(const pt: TPoint; z: integer): TRect;
begin
  with result do begin
    Left    := pt.x - z;
    Right   := pt.x + z;
    Top     := pt.y - z;
    Bottom  := pt.y + z;
  end;
end;

{ TSimpleView }
constructor TSimpleView.Create;
begin
  color := $00101010;
  Visible := false;
end;

{ TRulerObj }

constructor TRulerView.Create;
begin
  inherited;
  Range   := 0.0;
  Bearing := 0.0;
end;

procedure TRulerView.DrawView(aCnv: TCanvas);
var s1, s2 :string;
    r: TRect;
    tx1, tx2 : TSize;
begin
  if Visible then
  with aCnv do begin
    //Font := TFont.Create;
//    Font.Orientation := 0;

    r := PointToRect(ptStart, 2);
    Brush.Color := clWhite;
    Ellipse(r);

    r := PointToRect(ptEND, 2);
    Brush.Color := $00F0FFFF;
    Ellipse(r);

    pen.Color := $00080808;
    Pen.Style := psSolid;
    MoveTo(ptStart.X, ptStart.Y);
    LineTo(ptEnd.X, ptEnd.Y);

    Font.Name := 'Arial';
    Font.Size := 8;
    s1  := Format('jarak   : %2.2f', [Range]);
    tx1 := TextExtent(s1);
    s2  := Format('baring : %2.2f', [Bearing]);
    tx2 := TextExtent(s2);

    if (((bearing > 270) and (bearing < 360))  or ((bearing > 90) and (bearing< 180))) then
    begin
      r.Top  := round((ptEnd.Y+ptStart.Y)/2);
      r.Left := round(((ptEnd.X+ptStart.X)/2)) - (Max(tx1.cx , tx2.cx) + 6);
      r.Right  := r.Left ;
      r.Bottom := r.Top  + tx1.cy + tx2.cy + 4;
    end
    else
    //if (((bearing > 0) and (bearing< 90))  or ((bearing > 180) and (bearing< 270)))  then
    begin
      r.Top  := round((ptEnd.Y+ptStart.Y)/2);
      r.Left := round(((ptEnd.X+ptStart.X)/2));
      r.Right  := r.Left + Max(tx1.cx , tx2.cx) + 6;
      r.Bottom := r.Top  + tx1.cy + tx2.cy + 4;
    end;

//    r.Top  := ptEnd.Y;
//    r.Left := ptEnd.X + 10;
//    r.Right  := r.Left + Max(tx1.cx , tx2.cx) + 6;
//    r.Bottom := r.Top  + tx1.cy + tx2.cy + 4;

    Brush.Color := $00FFFFF0;
    Rectangle(r);

    Font.Color  := Color;
    SetTextAlign(Handle, TA_LEFT);
    TextOut(r.Left + 3, r.Top + 2 , s1);
    TextOut(r.Left + 3, r.Top + 16 , s2);
  end
end;


{ TRectView }

constructor TRectView.Create;
begin
  inherited;

end;

procedure TRectView.DrawView(aCnv: TCanvas);
var r: TRect;
begin
  inherited;
  with aCnv do begin
    Brush.Color := clBlue;
    FrameRect(Rect(ptStart.X, ptStart.Y, ptEnd.X, ptEnd.Y));
  end;
end;

function TRectView.getRect: tRect;
begin
  result.TopLeft      :=  ptStart;
  result.BottomRight  :=  ptEnd;
end;

procedure TRectView.setRect(const Value: tRect);
begin
  ptStart :=  Value.TopLeft;
  ptEnd   :=  Value.BottomRight;

end;

{ TWeaponRange }

procedure TWeaponRange.ConvertDataPosition;
begin
  inherited;

end;

constructor TWeaponRange.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;

end;

procedure TWeaponRange.DrawView(aCnv: TCanvas);
var
  tShipPositionOnScreen : Tpoint;
  tShipPositiOnMap : t2DPoint;

  RelatifStartangle : Integer;
  RelatifEndAngle   : Integer;

  //Rect
  rDegree1, rDegree2 : Double;
  dPt1 ,dPt2 : t2DPoint;
  pt1, pt2 : Tpoint;
  r1, r2 : Integer;

  //Coord High -> 2 point
  //map
  HighCoord1 : t2DPoint;
  HighCoord2 : t2DPoint;
  //scren
  tHighCoord1 : TPoint;
  tHighCoord2 : TPoint;

  //Coord Low --> 2 Point
  LowCoord1 : t2DPoint;
  LowCoord2 : t2DPoint;
  //screen
  tLowCoord1 : TPoint;
  tLowCoord2 : TPoint;

begin
  inherited;
  if not Visible then Exit;
  if StartAngle = EndAngle then Exit;

  RelatifStartangle :=  Round(TInsObject(FParent).Course) + Round(StartAngle);
  RelatifEndAngle   :=  Round(TInsObject(FParent).Course) + Round(EndAngle);

  tShipPositionMap.X := TSimulationClass(FParent).PositionX;
  tShipPositionMap.Y := TSimulationClass(FParent).PositionY;

  //Get High Range
  RangeBearingToCoord(HighRange, RelatifStartangle, HighCoord1.X, HighCoord1.y);
  RangeBearingToCoord(HighRange, RelatifEndAngle, HighCoord2.X, HighCoord2.Y);

  HighCoord1.X :=  HighCoord1.X + tShipPositionMap.X;
  HighCoord1.Y :=  HighCoord1.Y + tShipPositionMap.Y;
  HighCoord2.X :=  HighCoord2.X + tShipPositionMap.X;
  HighCoord2.Y :=  HighCoord2.Y + tShipPositionMap.Y;

  tHighCoord1 := Convert_MapToScreen(FMap, HighCoord1);
  tHighCoord2 := Convert_MapToScreen(FMap, HighCoord2);

  //Get Low Range
  RangeBearingToCoord(LowRange, RelatifStartangle, LowCoord1.X, LowCoord1.y);
  RangeBearingToCoord(LowRange, RelatifEndAngle, LowCoord2.X, LowCoord2.Y);

  LowCoord1.X :=  LowCoord1.X + tShipPositionMap.X;
  LowCoord1.Y :=  LowCoord1.Y + tShipPositionMap.Y;
  LowCoord2.X :=  LowCoord2.X + tShipPositionMap.X;
  LowCoord2.Y :=  LowCoord2.Y + tShipPositionMap.Y;

  tLowCoord1 := Convert_MapToScreen(FMap, LowCoord1);
  tLowCoord2 := Convert_MapToScreen(FMap, LowCoord2);

  //Get Rect
  rDegree1 := HighRange / 60;
  dPt1.X := tShipPositionMap.X + rDegree1;
  dPt1.Y := tShipPositiOnMap.Y;
  rDegree2 := LowRange / 60;
  dPt2.X := tShipPositionMap.X + rDegree2;
  dPt2.Y := tShipPositiOnMap.Y;

  pt1 := Convert_MapToScreen(FMap, dPt1);
  pt2 := Convert_MapToScreen(FMap, dPt2);
  r1 := Abs(pt1.X - CenterCoord.X);
  r2 := Abs(pt2.X - CenterCoord.X);

  with aCnv do
  begin
    //Font := TFont.Create;
//    Font.Orientation := 0;
    Pen.Color := Color;

    //Get Rect
    FRadiusRect.Top     := CenterCoord.Y - r1;
    FRadiusRect.Left    := CenterCoord.X - r1;
    FRadiusRect.Bottom  := CenterCoord.Y + r1;
    FRadiusRect.Right   := CenterCoord.X + r1;
    Arc(FRadiusRect.Left,FRadiusRect.Top,FRadiusRect.Right,FRadiusRect.Bottom,
        Round(tHighCoord2.X),Round(tHighCoord2.Y),
        Round(tHighCoord1.X),Round(tHighCoord1.Y));

    FRadiusRect.Top     := CenterCoord.Y - r2;
    FRadiusRect.Left    := CenterCoord.X - r2;
    FRadiusRect.Bottom  := CenterCoord.Y + r2;
    FRadiusRect.Right   := CenterCoord.X + r2;
    Arc(FRadiusRect.Left,FRadiusRect.Top,FRadiusRect.Right,FRadiusRect.Bottom,
        Round(tLowCoord2.X),Round(tLowCoord2.Y),
        Round(tLowCoord1.X),Round(tLowCoord1.Y));

    MoveTo(tLowCoord1.X, tLowCoord1.Y);
    LineTo(tHighCoord1.X, tHighCoord1.Y);

    MoveTo(tLowCoord2.X, tLowCoord2.Y);
    LineTo(tHighCoord2.X, tHighCoord2.Y);

  end;
end;

function TWeaponRange.getRotation: double;
begin
  result := RadToDeg(FHeading) + 90;
end;

procedure TWeaponRange.setRotation(const Value: double);
begin
  FRotation := Round( 10.0 * (90.0 - Value ));
  FHeading := DegToRad(90.0 - Value);
end;

function TWeaponRange.TestHit(const pt: TPoint): boolean;
begin
  result := PtInRect(FHitRect, pt);
end;

{ TAdviceSPS }

procedure TAdviceSPS.ConvertDataPosition;
begin
  inherited;

end;

constructor TAdviceSPS.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;

  FA244Speed := 30;

  SymbolPHP := TRotateSymbolView.CreateOnMapX(aParent, aMap);
  SymbolPHP.FHeading    := 0;
  SymbolPHP.CharSymbol  := 'N';
  SymbolPHP.FontName    := 'TDCIdent';
  SymbolPHP.Visible     := False;

  SymbolELP := TRotateSymbolView.CreateOnMapX(aParent, aMap);
  SymbolELP.FHeading    := 0;
  SymbolELP.CharSymbol  := 'N';
  SymbolELP.FontName    := 'TDCIdent';
  SymbolELP.Visible     := False;

  MLinePHP := TMoveableLineLabel.CreateOnMapX(aParent, aMap);
  MLinePHP.Line1 := 'PHP';
  MLinePHP.Line2 := 'Torpedo A244';
  MLinePHP.Line3 := '';
  MLinePHP.Line4 := '';
  MLinePHP.Line5 := '';

  MLineELP := TMoveableLineLabel.CreateOnMapX(aParent, aMap);
  MLineELP.Line1 := 'ELP';
  MLineELP.Line2 := 'Torpedo A244';
  MLineELP.Line3 := '';
  MLineELP.Line4 := '';
  MLineELP.Line5 := '';
end;

procedure TAdviceSPS.DrawView(aCnv: TCanvas);
var
  tShipPositionOnScreen : Tpoint;
  tShipPositionMap      : t2DPoint;

  trpoint : TPoint;
  dpoint : t2DPoint;

  hRange , hBearing, hTime,
  hSpeed, mx, my : double;

  PHPonMap    : t2DPoint;
  PHPonScreen : Tpoint;

  ELPonMap    : t2DPoint;
  ELPonScreen : Tpoint;

  Rects : TRect;
  r : integer;

  ELPBearing : Double;
  ELPX, ELPY : Double;
begin
  inherited;

  SymbolPHP.Visible := false;
  SymbolELP.Visible := false;
  MLinePHP.Visible  := false;
  MLineELP.Visible  := false;

  tShipPositionMap.X := TSimulationClass(FParent).PositionX;
  tShipPositionMap.Y := TSimulationClass(FParent).PositionY;

  tShipPositionOnScreen := Convert_MapToScreen(FMap, tShipPositionMap);

  FTgtRange   := CalcRange(tShipPositionMap.X,tShipPositionMap.Y, FTgtPosX, FTgtPosY);
  FTgtBearing := CalcBearing(tShipPositionMap.X,tShipPositionMap.Y, FTgtPosX, FTgtPosY);

  CalcHitPredition(FTgtRange, FTgtBearing, FTgtSpeed, FTgtCourse, FA244Speed,
          hRange , hBearing, hTime, hSpeed);

  RangeBearingToCoord(hRange,hBearing,mx,my);

  PHPonMap.X  := tShipPositionMap.X + mx;
  PHPonMap.Y  := tShipPositionMap.Y + my;

  dpoint.X := PHPonMap.X  + (FRadius/60);
  dpoint.Y := PHPonMap.Y;

  PHPonScreen := Convert_MapToScreen(FMap, PHPonMap);
  trpoint     := Convert_MapToScreen(FMap, dpoint);

  r := Abs(trpoint.X - PHPonScreen.X);

  ELPBearing := CalcBearing(PHPonMap.X, PHPonMap.Y, tShipPositionMap.X, tShipPositionMap.Y);
  RangeBearingToCoord(FRadius, ELPBearing, ELPX, ELPY);
  ELPonMap.X  := PHPonMap.X + ELPX;
  ELPonMap.Y  := PHPonMap.Y + ELPY;
  ELPonScreen := Convert_MapToScreen(FMap, ELPonMap);

  with aCnv do
  begin
    Pen.Color := clRed;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Brush.Style := bsClear;

    if CalcRange(tShipPositionMap.X, tShipPositionMap.Y, PHPonMap.X, PHPonMap.Y) > FRadius then
    begin
      //Draw Circle
      Rects.Top     := PHPonScreen.Y - r;
      Rects.Left    := PHPonScreen.X - r;
      Rects.Bottom  := PHPonScreen.Y + r;
      Rects.Right   := PHPonScreen.X + r;

      MoveTo(tShipPositionOnScreen.X, tShipPositionOnScreen.Y);
      LineTo(PHPonScreen.X, PHPonScreen.Y);

      Ellipse(Rects);

      SymbolPHP.Visible := True;
      SymbolELP.Visible := True;
      MLinePHP.Visible  := True;
      MLineELP.Visible  := True;

      //Draw Font
      SymbolPHP.CenterCoord.X := PHPonScreen.X;
      SymbolPHP.CenterCoord.Y := PHPonScreen.Y;
      SymbolELP.CenterCoord.X := ELPonScreen.X;
      SymbolELP.CenterCoord.Y := ELPonScreen.Y;

      MLinePHP.CenterCoord.X  := PHPonScreen.X;
      MLinePHP.CenterCoord.Y  := PHPonScreen.Y;
      MLineELP.CenterCoord.X  := ELPonScreen.X;
      MLineELP.CenterCoord.Y  := ELPonScreen.Y;
    end
    else
    begin
      MoveTo(tShipPositionOnScreen.X, tShipPositionOnScreen.Y);
      LineTo(PHPonScreen.X, PHPonScreen.Y);

      //Draw Font
      SymbolPHP.Visible := True;
      MLinePHP.Visible  := True;
      SymbolPHP.CenterCoord.X := PHPonScreen.X;
      SymbolPHP.CenterCoord.Y := PHPonScreen.Y;
      MLinePHP.CenterCoord.X  := PHPonScreen.X;
      MLinePHP.CenterCoord.Y  := PHPonScreen.Y;
    end;
  end;
end;

function TAdviceSPS.getRotation: double;
begin
  result := RadToDeg(FHeading) + 90;
end;

procedure TAdviceSPS.setRotation(const Value: double);
begin
  FRotation := Round( 10.0 * (90.0 - Value ));
  FHeading := DegToRad(90.0 - Value);
end;

function TAdviceSPS.TestHit(const pt: TPoint): boolean;
begin
  result := PtInRect(FHitRect, pt);
end;

{ TWayPoint }

constructor TWayPoint.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;
  FWaypointList := TList.Create;
end;

procedure TWayPoint.DrawView(aCnv: TCanvas);
var
  mapPos : t2DPoint;
  scrPos : TPoint;
  i : Integer;
begin
  inherited;

  for i := 0 to FWaypointList.Count - 1 do
  begin
    mapPos.X := TObjPoint(FWaypointList[i]).pointX;
    mapPos.Y := TObjPoint(FWaypointList[i]).pointY;
    scrPos := Convert_MapToScreen(FMap, mapPos);
    DrawX := scrPos.X;
    DrawY := scrPos.Y;

    with aCnv do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clRed;
      Pen.Color := clRed;

      Ellipse(DrawX - 5, DrawY - 5, DrawX + 5, DrawY + 5);
    end;
  end;
end;

end.
