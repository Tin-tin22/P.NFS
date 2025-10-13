unit uObjectView;
(*
  obejct componen view
  Created       : 28 August 2007
  Last Modified : 28 April 2008

  Author        : Andy Sucipto
  description   : object  & common view
*)



interface

uses
   MapXLib_TLB ,Windows, Graphics,

   uBaseDatatype, uBaseSimulationObject, uMapXSim ;

const
  maxCLabel = 10;

type


//==============================================================================
    TSymbolView = class(TSimViewOnMapX)
    private

    public
      CharSymbol    : Char;
      FontName      : TFontName;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

  {-----------------------------------------------------------------------------}
    TSpeedVector = class (TSimViewOnMapX)
    protected
      ptL,
      ptR,
      ptH : TPoint;

    public
      Speed   : double;
      Heading : double;
      Ratio   : double;
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

  {----------------------------------------------------------------------------}
    T3LineLabel = class (TSimViewOnMapX)
    private
      RectCenter: TPoint;
      RectArea  : TRect;

      LabelH : integer; //pix
      LabelW : integer;

      FLine1,
      FLine2,
      FLine3  : string;
      procedure setLine(const Index: Integer; const Value: string);
    public
      OffX,
      OffY : Integer;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      property Line1: string index 1 read FLine1 write setLine;
      property Line2: string index 2 read FLine2 write setLine;
      property Line3: string index 3 read FLine3 write setLine;
    end;

  {----------------------------------------------------------------------------}
    TLblItem = record
      OffX, OffY : integer;
      Text    : string;
      FontName: string;
      FontSize: integer;
      Visible: Boolean;
    end;
  {----------------------------------------------------------------------------}
    TColumnLabel = class (TSimViewOnMapX)
    public
      OffX,
      OffY : Integer;
      lbls : array [1..maxCLabel] of  TLblItem;
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

  {----------------------------------------------------------------------------}
    TLineLabel = class (TSimViewOnMapX)
    public
      Line : TLblItem;
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;
  {----------------------------------------------------------------------------}
    THistory = class(TSimViewOnMapX)
    private
      FTrailCapacity   : Word;
      FTrailCount      : Word;
      FPixelTrails     : array of TPoint;
    public
      Trails          : array of t3DPoint;  //  array of t3DPoint;
      VisibleCount     : integer;

      Selected : boolean;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      procedure AddPoint(dX, dY, dZ: double);
      procedure ClearHistory;

      //gigih
      function CountPoint: Integer;
      function CountMaxPoint: Integer;
    end;

    //==============================================================================
    TEnumSize =(esSmall , esMedium, esLarge, esFull);


    //==============================================================================
    TRawVideoView = class(TSimViewOnMapX)
    private
      Size          : Integer; // multiplier
      FPlotSize : TEnumSize;
      FBSRValue : TEnumSize;
      ptH      : TPoint;
      BGBmp, FGBmp  : TBitmap;

      procedure SetRawVideoSize(const sz: Integer);

      procedure SetPlotSize(const val: TEnumSize);
      procedure SetBSRValue(const val: TEnumSize);
    public
      Alpha         : single;
      Direction     : single;
      MaxColor      : byte;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      procedure MakeFullIntensity;
      procedure ReduceIntensity(const dt: double);   //use updateTime

    published
      property PlotSize: TEnumSize read FPlotSize write SetPlotSize;
      property BSRValue: TEnumSize read FBSRValue write FBSRValue;
    end;


//==============================================================================
    TThreadAssesmentView = class(TSimViewOnMapX)
    private
      FTrails         : array [0..9] of t2DPoint;
      FPixelTrails    : array [0..9] of TPoint;
      FOrigin         : t2DPoint;

    public
      VisibleCount      : byte;
      TimeAhead         : word;  //second
      SpeedKnot         : single;
      HeadingNorth      : single;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      procedure UpdateOrigin;
    public
      property Parent: TSimulationClass read FParent write FParent;

    end;

//==============================================================================
    TRectangleView = class(TSimViewOnMapX)
    private
      FArea: TRect;
    public

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      function TestHitView(const x, y: integer) : boolean;


      property Area : TRect read FArea;
    end;

//==============================================================================
    TFOCView = class (TSimViewOnMapX)
    protected
      FHexs : array [0..5] of TPoint;

    public
      FDistance : double;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

//==============================================================================
   TLineView = class (TSimViewOnMapX)
   private

   public
      EndCoord : t2DPoint;  // map coord, if assigned to track
      EndPoint : TPoint;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

   end;

{   TSGOView =  class (TSimViewOnMapX)

   public
     procedure GetRelatifCoord()
   end;
}
implementation

uses

  uBaseFunction, uBaseConstan, uBaseGraphicProc,
  Math, Classes, Types;

//==============================================================================
  const
    SYMBOL_FONT_NAME = 'LASA';
    SYMBOL_FONT_SIZE = 12;

//==============================================================================
{ TSymbolView }
constructor TSymbolView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

  Visible   := true;
  Color     := C_defColor;
  Size      := SYMBOL_FONT_SIZE;
  FontName  := SYMBOL_FONT_NAME;

end;

procedure TSymbolView.ConvertDataPosition;
begin
  inherited;

end;


procedure TSymbolView.DrawView(aCnv: TCanvas);
var sz:  TSize;
begin
  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;
    sz :=  TextExtent(CharSymbol);
    //aligned center
    TextOut(CenterCoord.X - sz.cx shr 1, CenterCoord.y - sz.cy shr 1 ,
      CharSymbol);

  end;
end;

//==============================================================================
{ TSpeedVector }

constructor TSpeedVector.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;
  Color := C_defColor;
  Ratio := 4.0;

end;

procedure TSpeedVector.ConvertDataPosition;
const
    SPEED_VECTOR_WIDTH = 8.0;

var headEast, spdKnots : double;
    sinA, cosA: extended;
begin
  inherited;

  headEast := C_DegToRad * (
  ConvCompass_To_Cartesian(Heading + FMap.Rotation ));
//  ConvCompass_To_Cartesian(Heading) + ConvCompass_To_Cartesian(-FMap.Rotation ));

  if Speed > 10000 then
      spdKnots := 1
  else
      spdKnots := sqrt(abs(Speed)) * Ratio;

  if Speed < 0 then   //  kapal mundur
    spdKnots := - spdKnots;

  //Calculate SpeedVector Coordinate
  SinCos(headEast, SinA, CosA);

  ptH.X :=  Round(CenterCoord.X + spdKnots * CosA);
  ptH.Y :=  Round(CenterCoord.Y - spdKnots * sinA);

end;

procedure TSpeedVector.DrawView(aCnv: TCanvas);
var r: TRect;
begin
  inherited;

  with aCnv do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    r := ptToRect(CenterCoord, 3, 3);
    Arc(r.Left, r.Top, r.Right, r.Bottom, 0,0,0,0);

    MoveTo(CenterCoord.X, CenterCoord.Y);
    LineTo(ptH.X, ptH.Y);
  end;

end;

//==============================================================================
{ T3LineLabel }

constructor T3LineLabel.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

  Line1 := '1.satu';
  Line2 := '2.dua';
  Line3 := '3.tiga ';

  OffX := 20;
  OffY := 0;

  Color := $0080f0;
end;

procedure T3LineLabel.ConvertDataPosition;
begin
  inherited;

  RectCenter.X := CenterCoord.X + OffX;
  RectCenter.Y := CenterCoord.Y + OffY;

  RectArea.Left   := RectCenter.X - LabelW;
  RectArea.Right  := RectCenter.X + LabelW;
  RectArea.Top    := RectCenter.Y - LabelH;
  RectArea.Bottom := RectCenter.Y + LabelH;
end;

procedure T3LineLabel.DrawView(aCnv: TCanvas);
var ptDrawLine : TPoint;
begin
  inherited;

  with aCnv do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psDot;

     if RectCenter.X < CenterCoord.X then
       ptDrawLine.X := RectArea.Right
     else
       ptDrawLine.X := RectArea.Left;

    ptDrawLine.Y := RectArea.Top;

//    MoveTo(CenterCoord.X, CenterCoord.Y);
//    LineTo(ptDrawLine.X, ptDrawLine.Y);

    Font.Name := 'Courier';
    Font.Size := 8;
    Font.Color := Color;
    SetBkMode(aCnv.Handle, TRANSPARENT);

    TextOut(rectArea.Left, rectArea.Top ,     FLine1);
    TextOut(rectArea.Left, rectArea.Top + 10 ,FLine2);
    TextOut(rectArea.Left, rectArea.Top + 20, FLine3);
  end;
end;

procedure T3LineLabel.setLine(const Index: Integer; const Value: string);
var len,  mxLine : integer;

begin
  case index of
    1: FLine1 := Value;
    2: FLine2 := Value;
    3: FLine3 := Value;
  end;

  mxLine := Length(FLine1);
  len    := Length(FLine2);

  if len > mxLine then
   mxLine := len;

  len :=   Length(FLine3);
  if len > mxLine then
   mxLine := len;

  LabelW := mxLine shl 2;
end;

//==============================================================================
{ THistory }

constructor THistory.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;
  VisibleCount := 10;
  ClearHistory;
  Selected := true;
end;

destructor THistory.Destroy;
begin
  FTrailCount := 0;
  SetLength(Trails, 0);
  SetLength(FPixelTrails, 0);

  inherited;
end;

procedure THistory.ConvertDataPosition;
var i: integer;
    sx, sy : single;
    dx, dy: double;
begin
  inherited;

  for i := 0 to FTrailCount-1 do begin
    dx := Trails[i].x;
    dy := Trails[i].y;
    FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
    FPixelTrails[i].X :=  Round(sx);
    FPixelTrails[i].Y :=  Round(sy);
  end;
end;


procedure THistory.DrawView(aCnv: TCanvas);
var i: integer;
    mnTrail : integer;
    r :TRect;
    cl : TColor;
begin
  if not Visible then exit;
  if VisibleCount = 0 then exit
  else
  if VisibleCount > 0 then begin
    mnTrail := Max(0, FTrailCount-VisibleCount-2);
    for i := FTrailCount-2 downto mnTrail do
      aCnv.Pixels[FPixelTrails[i].X, FPixelTrails[i].Y] := Color;
  end
  else begin //-1
      cl := Color;
      for i := FTrailCount-1 downto 0 do begin
        r := ptToRect(Point(FPixelTrails[i].X, FPixelTrails[i].Y), 1, 1);
        DarkColor(cl, 1);
        aCnv.Brush.Color := cl;
        aCnv.Pen.Color := cl;
        aCnv.Ellipse(r);
        aCnv.Pixels[FPixelTrails[i].X, FPixelTrails[i].Y] := cl;
      end
  end;
end;

procedure THistory.AddPoint(dX, dY, dZ: double);
var sx, sy, sz : single;

begin
  inc(FTrailCount);
  if FTrailCount >= FTrailCapacity then
  begin
    FTrailCapacity := FTrailCapacity + 32;
    SetLength(Trails, FTrailCapacity);
    SetLength(FPixelTrails, FTrailCapacity);
  end;
  Trails[FTrailCount-1].x := dX;
  Trails[FTrailCount-1].y := dY;
  Trails[FTrailCount-1].Z := dZ;

  FMap.ConvertCoord(sx, sy, dX, dY, miMapToScreen);

  FPixelTrails[FTrailCount-1].X := Round(sx);
  FPixelTrails[FTrailCount-1].Y := Round(sy);
end;


procedure THistory.ClearHistory;
begin
  FTrailCapacity := 32;
  FTrailCount := 0;
  SetLength(Trails, FTrailCapacity);
  SetLength(FPixelTrails, FTrailCapacity);
end;

//==============================================================================
function THistory.CountMaxPoint: Integer;
begin
  Result := FTrailCapacity;
end;

function THistory.CountPoint: Integer;
begin
  result := FTrailCount;
end;

{ TRawVideoView }


constructor TRawVideoView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

  BGBmp := TBitmap.Create;
  FGBmp := TBitmap.Create;

  BGBmp.PixelFormat := pf24Bit;
  FGBmp.PixelFormat := pf24Bit;

  SetPlotSize(esLarge);
  Alpha   := 1.0;
  Color := C_defColor;

  FBSRValue := esFull;
  MaxColor  := 140;
end;

destructor TRawVideoView.Destroy;
begin
  FGBmp.Free;
  BGBmp.Free;

  inherited;
end;

procedure TRawVideoView.ConvertDataPosition;
var headEast : double;
    sinA, cosA: extended;
begin
  inherited;

//  headEast := C_DegToRad * Direction;
  headEast := C_DegToRad * (Direction + ConvCompass_To_Cartesian(-FMap.Rotation ));

  SinCos(headEast, SinA, CosA);

  ptH.X :=  Round(Size * CosA);
  ptH.Y :=  Round(-Size * sinA);
end;

procedure TRawVideoView.DrawView(aCnv: TCanvas);
var sz, t, l : integer;
    rct : TRect;
//    i,j : integer;
begin
  sz := Size shr 1;

  l :=  CenterCoord.X - sz;
  t :=  CenterCoord.Y - sz;
  rct := Rect(l, t, l + Size,t + Size);

  FGBmp.Canvas.CopyRect(Rect(0,0,Size,
    Size), aCnv, rct);

  BGBmp.Canvas.CopyRect(Rect(0,0,Size,
    Size), aCnv, rct);

  with FGBmp.Canvas do begin
    Brush.Color := Color;
    Pen.Color   := Color;

    Pen.Width := 4;
    MoveTo(sz, sz);
    LineTo(sz + ptH.X, sz + ptH.Y);
  end;

  DrawTransparent(aCnv, rct, Round(MaxColor * Alpha), FGBmp);
end;


procedure TRawVideoView.MakeFullIntensity;
begin
//  Alpha := 0.4 + (0.6 *Integer(FBSRValue)/Integer(esFull));
  Alpha := 0.4 + (0.6 *Integer(FBSRValue)/Integer(esFull));

end;

procedure TRawVideoView.ReduceIntensity(const dt: double);
const decr = 1.0/2000.0;
begin //(0.000125 =  1.0 / 8000.0 ms)  (30 rpm: )
  if Alpha > 0.0 then begin
    Alpha :=  Alpha -  (dt * decr );
    if Alpha < 0.0 then Alpha := 0.0;
  end;
end;

procedure TRawVideoView.SetBSRValue(const val: TEnumSize);
begin
  FBSRValue := val;
end;

procedure TRawVideoView.SetPlotSize(const val: TEnumSize);
begin
  FPlotSize := val;
  SetRawVideoSize((Integer(val) +3)*3);
end;

procedure TRawVideoView.SetRawVideoSize(const sz: Integer);
begin
  Size        := sz;
  BGBmp.Width := sz;
  BGBmp.Height:= sz;
  FGBmp.Width := sz;
  FGBmp.Height:= sz;
end;

{ TThreadAssesment }

procedure TThreadAssesmentView.ConvertDataPosition;
var i: integer;
    sx, sy : single;
    dx, dy: double;
begin
  if FParent = nil then exit;

  inherited;

  for i := 0 to 9 do begin
    dx := FTrails[i].x;
    dy := FTrails[i].y;
    FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
    FPixelTrails[i].X :=  Round(sx);
    FPixelTrails[i].Y :=  Round(sy);
  end;
end;

constructor TThreadAssesmentView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;
  Color     := C_defColor;

  TimeAhead         :=  60 * 15; // detik;

  SpeedKnot := 0;
  HeadingNorth := 0;
end;

destructor TThreadAssesmentView.Destroy;
begin

  inherited;
end;

procedure TThreadAssesmentView.DrawView(aCnv: TCanvas);
var i: integer;
  procedure DrawCross(aCnv: TCanvas; px, py: integer);
  const sz = 2;
  begin
    aCnv.Rectangle(px-1, py-1, px+1, py+1);
    //aCnv.TextOut(px, py, '*');
{    aCnv.MoveTo( px-2, py );
    aCnv.LineTo( px+3, py );

    aCnv.MoveTo( px, py-2 );
    aCnv.LineTo( px, py+3 );}
  end;
begin

  if (not Visible) or (VisibleCount < 0) then exit;

  if VisibleCount > 0 then begin
    aCnv.Pen.Color := Color;
    for i := 0 to VisibleCount do begin
      DrawCross(aCnv, FPixelTrails[i].X, FPixelTrails[i].Y);
    end;
  end;
end;

procedure TThreadAssesmentView.UpdateOrigin;
var i: integer;
    dR : double;
    sinA, cosA : extended;
    headEast : single;
begin
  if Fparent = nil then exit;

  FOrigin.X := FParent.PositionX;
  FOrigin.Y := FParent.PositionY;


  headEast := C_DegToRad * ConvCompass_To_Cartesian(HeadingNorth);
  SinCos(headEast, sinA, cosA);

  dR := (SpeedKnot * C_NauticalMile_To_Degree * C_SecondToHour)
   * TimeAhead * 0.1;

  for i := 0 to 9 do begin
     FTrails[i].X := FOrigin.X + (i + 1)* dR * cosA;
     FTrails[i].Y := FOrigin.Y + (i + 1)* dR * sinA;
  end;

end;

{ TRectangleView }

constructor TRectangleView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;
  Size := 6; // pixel
end;


procedure TRectangleView.ConvertDataPosition();
begin
  inherited;
  FArea := PtToRect(CenterCoord, Size, Size)
end;

procedure TRectangleView.DrawView(aCnv: TCanvas);
begin
  aCnv.Pen.Color := clLime;
  aCnv.FrameRect(FArea);
end;

function TRectangleView.TestHitView(const x, y: integer): boolean;
var pt : TPoint;
begin
  pt.X := x;
  pt.Y := y;
  result := ptInRect(FArea, pt);
end;

//=============================================================================
{ TColumnLabel }

procedure TColumnLabel.ConvertDataPosition;
begin
  inherited;

end;

constructor TColumnLabel.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
var i: integer;
begin
  inherited;
  OffX := 0;
  OffY := 0;

  for i := 1 to maxCLabel do begin
    Lbls[i].OffX := 20 * (i-1);  //default offset from center column
    Lbls[i].OffY := 0;
    Lbls[i].FontName := 'Courier New';
    Lbls[i].FontSize := 8;
    Lbls[i].Visible := True;
  end;
end;

procedure TColumnLabel.DrawView(aCnv: TCanvas);
var i, dx, dy: integer;
    sz: TSize;
begin
  inherited;
  if not Visible then exit;

  with aCnv do begin
    for i := 1 to maxCLabel do begin
      if lbls[i].Visible then  begin
        Font.Name := lbls[i].FontName;
        Font.Size := lbls[i].FontSize;
        Font.Color := Color;
        SetBkMode(Handle, TRANSPARENT);

        sz := TextExtent(lbls[i].Text);

        dx := CenterCoord.X + OffX + lbls[i].OffX - (sz.cx shr 1);  //center aligned
        dy := CenterCoord.Y + OffY + lbls[i].OffY - (sz.cy shr 1);  //center aligned
          TextOut(dx, dy, lbls[i].Text);
      end;
    end;
  end;

end;

{ TLineLabel }
constructor TLineLabel.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;

  Line.OffX := 10;  //default offset from center column
  Line.OffY := 0;
  Line.FontName := 'Courier New';
  Line.FontSize := 8;
  Line.Visible := True;
  Line.Text := '(~_~)';

  Color := C_defColor;

end;

procedure TLineLabel.ConvertDataPosition();
begin
  inherited;
end;

procedure TLineLabel.DrawView(aCnv: TCanvas);
var i, dx, dy: integer;
    sz: TSize;
begin
  if not Visible then exit;

  with aCnv do begin
    Font.Name := Line.FontName;
    Font.Size := Line.FontSize;
    Font.Color := Color;
    SetBkMode(Handle, TRANSPARENT);

    sz := TextExtent(Line.Text);

    dx := CenterCoord.X + Line.OffX;  //center aligned
    dy := CenterCoord.Y + Line.OffY;  //center aligned
    TextOut(dx, dy, Line.Text);
  end;

end;

{ TFOCView }

constructor TFOCView.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited;

  FDistance  :=  0; // nautical miles
  Color := C_defColor;
end;

procedure TFOCView.ConvertDataPosition;
var i: integer;
    dr, dx, dy  : double;
    sx, sy, cx, cy  : single;
    t,  tSin, tCos : extended;
begin
  if FParent = nil then exit;
  if not Visible then exit;

  inherited;

  dr := C_NauticalMile_To_Degree * FDistance;
  dx := FParent.PositionX;
  dy := FParent.PositionY + dr;

  FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

{  dy := FParent.PositionY;
  FMap.ConvertCoord(cx, cy, dx, dy, miMapToScreen);
}
  dr :=  abs(sY - CenterCoord.Y);

  for i := 0 to 5 do begin
    t :=  (i * C_Pi)/3;
    SinCos(t, tSin, tCos);
    sx := CenterCoord.X + dr * tCos;
    sy := CenterCoord.Y + dr * tSin;
{
    sx := cX + dr * tCos;
    sy := cY + dr * tSin;
}    FHexs[i].X := Round(sx);
    FHexs[i].Y := Round(sY);
  end;

end;


procedure TFOCView.DrawView(aCnv: TCanvas);
var i: integer;
begin
  if not Visible then exit;

  aCnv.Pen.Color := Color;
  aCnv.MoveTo(FHexs[0].X, FHexs[0].Y);
  for i := 0 to 5 do
    aCnv.LineTo(FHexs[i].X, FHexs[i].Y);
  aCnv.LineTo(FHexs[0].X, FHexs[0].Y);

end;

{ TBearingView }

procedure TLineView.ConvertDataPosition;
var sx, sy  : single;
begin
  if FParent = nil then exit;
  if not Visible then exit;

  inherited;

  Color := C_defColor;
  
  FMap.ConvertCoord(sx, sy, EndCoord.X , EndCoord.y, miMapToScreen);
  EndPoint.X := Round(sx);
  EndPoint.Y := Round(sy);
end;

{constructor TBearingView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

end;
}
procedure TLineView.DrawView(aCnv: TCanvas);
var r :TRect;
begin
 // inherited;
  with aCnv do begin
    Pen.Color := Color;

    MoveTo(CenterCoord.X, CenterCoord.Y);
    LineTo(EndPoint.X, EndPoint.Y);
  end;
end;




end.
