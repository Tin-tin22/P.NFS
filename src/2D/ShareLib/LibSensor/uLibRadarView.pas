unit uLibRadarView;
(*
  radar componen view
  Created       : 15 August 2007
  Last Modified : 18 August 2007

  Author        : Andy Sucipto
  description   : radar main view

*)



interface

uses
   MapXLib_TLB ,Windows, Graphics,

   uBaseDatatype, uBaseSimulationObject, uMapXSim, uGraphics ;

type


//==============================================================================
    TRadarAreaView = class(TSimViewOnMapX)
    private
     FRect: TRect;

    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;


//==============================================================================
    TDrawEvent = procedure (aCnv: TCanvas) of object;

    TRadarTimeBaseView = class(TSimViewOnMapX)
    private
      FBmpBG,
      FBmpFG,
      FBmpMask : TBitmap;

      FPoint : TPoint;
      FPrevSudut,
      FSudut : double;

      FRect  : TRect;

      FPoints     : array of TPoint;
      FSweepWidth : Word;
      FNoiseLevel : byte;
      FBackgroundVisible : boolean;

      FOnDraw : TDrawEvent;
      FTBVisible: boolean;

      procedure SetNoiseLevel(const Value: byte);
      procedure SetSweepWidth(const Value: word);

      procedure DrawTimeBase(aCnv: TCanvas);  //
      procedure DrawBackGround(aCnv: TCanvas);
      procedure DrawOriginale(aCnv: TCanvas);   //
      procedure DrawSimpleTimebase(aCnv: TCanvas);

      procedure DrawClean(aCnv: TCanvas);

      function getDrawBG: boolean;
      procedure setDrawBG(const Value: boolean);
    procedure setTBVisible(const Value: boolean);

    public
      Darkness: byte;
      UseEffect : boolean;
      AddNoise  : boolean;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    public
      property NoiseLevel: byte read FNoiseLevel write SetNoiseLevel;
      property SweepWidth: word read FSweepWidth write SetSweepWidth;

      property BackgroundVisible: boolean read getDrawBG write setDrawBG;
      property TimeBaseVisible: boolean read FTBVisible write setTBVisible;
        // draw back ground image or just draw the timebase.
    end;

//==============================================================================
    TRadarSectorView = class(TSimViewOnMapX)
    private
      FRange : double;
      FSudut : array[0..15] of double;
      FPoint : array[0..15] of TPoint;
    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

//==============================================================================
    TRadarPolarView = class(TSimViewOnMapX)
    private
      FRects : array of TRect;
      FRangeInterval: double;
      FNumOfRanges   : integer;
      FRangeMax: double;

      procedure SetRangeInterval(const Value: double);
      procedure SetRangeMax(const Value: double);

    public

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

    public
      property RangeInterval : double read FRangeInterval write SetRangeInterval;
      property RangeMax: double read FRangeMax write SetRangeMax;  //nautical miles
    end;

implementation

uses

  uLibRadar, uBaseFunction, uBaseConstan, uBaseGraphicProc,
  Math, Classes, Controls, uLibRadarComp;

//==============================================================================
{ TRadarAreaView}
constructor TRadarAreaView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;
//  Visible := TRUE;
end;

procedure TRadarAreaView.ConvertDataPosition;
var rdr : TClientRadar;
    dist, rot : double;
    sinx, cosx: extended;
    x1, y1, x2, y2 : double;
    sx, sy: single;
begin
  inherited;

  rdr  := FParent as TClientRadar;
  dist := rdr.DetectionRange * C_NauticalMile_To_Degree;

  rot :=  ConvCompass_To_Cartesian(-FMap.Rotation ) * C_DegToRad;
  SinCos(rot, sinx, cosx);

//x' = (x * cos A) - (y * sin A)
//y' = (x * sin A) + (y * cos A)

  x1  := rdr.PositionX + (-dist * cosx) - (-dist * sinx);
  y1  := rdr.PositionY + (-dist * sinx) + (-dist * cosx);

  x2  := rdr.PositionX + (dist * cosx) - (dist * sinx);
  y2  := rdr.PositionY + (dist * sinx) + (dist * cosx);

  FMap.ConvertCoord( sx, sy, x1, y1, miMapToScreen );
  FRect.Left := Round(sx);
  FRect.Top := Round(sy);

  FMap.ConvertCoord(sx, sy, x2, y2, miMapToScreen );
  FRect.Right  := Round(sx);
  FRect.Bottom := Round(sy);
end;


procedure TRadarAreaView.DrawView(aCnv: TCanvas);
begin
  aCnv.Pen.Color := Color;
  aCnv.Pen.Style := psDot;

  aCnv.Arc(FRect.Left, FRect.Top, FRect.Right, FRect.Bottom, 0,0, 0,0);
end;

//==============================================================================
{ TRadarTimeBaseView }
constructor TRadarTimeBaseView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

//  Visible := true;
  Size := 1;
  Color := C_defColor;
  FBmpBG := TBitmap.Create;
  FBmpBG.PixelFormat := pf24bit;
  FBmpBG.Width  := FMap.Width;
  FBmpBG.Height := FMap.Height;
  BitmapFillBlack(FBmpBG);

  FBmpFG := TBitmap.Create;
  FBmpFG.PixelFormat := pf24bit;
  FBmpFG.Width  := FMap.Width;
  FBmpFG.Height := FMap.Height;
  BitmapFillBlack(FBmpFG);

  FBmpMask:= TBitmap.Create;
  FBmpMask.PixelFormat := pf24bit;
  FBmpMask.Width  := FMap.Width;
  FBmpMask.Height := FMap.Height;
  BitmapFillBlack(FBmpMask);


  FSweepWidth := 256;
  SetLength(FPoints, FSweepWidth);

  FSudut := NegInfinity;
  Darkness  := 100;
  UseEffect :=  TRUE;
  AddNoise := FALSE;
  NoiseLevel := 2;
//  setDrawBG(TRUE);
  FTBVisible := True;
  FBackgroundVisible := true;
  FOnDraw := DrawOriginale;
end;

destructor TRadarTimeBaseView.Destroy;
begin
  SetLength(FPoints, 0);

  DestroyBitmap(FBmpBG);
  DestroyBitmap(FBmpFG);
  DestroyBitmap(FBmpMask);

  inherited;
end;

function TRadarTimeBaseView.getDrawBG: boolean;
begin
  result := FBackgroundVisible;
end;

procedure TRadarTimeBaseView.setDrawBG(const Value: boolean);
begin
// FOnDraw := DrawClean;
{
  FBackgroundVisible := Value;
  if FBackgroundVisible then
    FOnDraw := DrawOriginale
  else
    FOnDraw := DrawTimeBase;
}
  FBackgroundVisible := Value;

  if FBackgroundVisible then begin
    if FTBVisible then
      FOnDraw := DrawOriginale
    else
      FOnDraw := DrawBackGround;
  end
  else begin
    if FTBVisible then
      FOnDraw := DrawTimeBase
    else
      FOnDraw := DrawClean;
  end

end;

procedure TRadarTimeBaseView.setTBVisible(const Value: boolean);
begin
  FTBVisible := Value;
  if FBackgroundVisible then begin
    if FTBVisible then
      FOnDraw := DrawOriginale
    else
      FOnDraw := DrawBackGround;

  end
  else begin
    if FTBVisible then
      FOnDraw := DrawTimeBase
    else
      FOnDraw := DrawClean;
  end
end;

procedure TRadarTimeBaseView.SetNoiseLevel(const Value: byte);
begin
  FNoiseLevel := Min(Value, 99);
end;

procedure TRadarTimeBaseView.SetSweepWidth(const Value: word);
begin
  FSweepWidth := Value;
  SetLength(FPoints, FSweepWidth);
end;

procedure TRadarTimeBaseView.ConvertDataPosition;
var sx, sy : single;
    dx, dy: double;
    rRange : double;
    theRadar : TClientRadar;
    sdt, sinX, cosX : extended;
    i: integer;
begin
  inherited;

  theRadar := FParent as TClientRadar;

  rRange := theRadar.DetectionRange * C_NauticalMile_To_Degree;

  FPrevSudut := FSudut;
  FSudut := theRadar.TimeBase.Direction;              // cartesian...
  if FPrevSudut = NegInfinity then exit;

  for i := 0 to FSweepWidth-1 do begin
//    sdt    := FPrevSudut +  i* abs(FSudut - FPrevSudut)/FSweepWidth;
    sdt    := FSudut +  i* 0.1;
    SinCos(sdt * C_degToRad, sinX, cosX );

    dx := theRadar.PositionX + rRange * cosX;
    dy := theRadar.PositionY + rRange * sinX;

    FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

    FPoints[i].X := Round(sx);
    FPoints[i].Y := Round(sy);
  end;
  FPoint.X := FPoints[0].X;
  FPoint.Y := FPoints[0].Y;

  i := Round(sqrt(sqr(FPoint.X-CenterCoord.X) + sqr(FPoint.Y-CenterCoord.Y)));
  FRect.Left    := CenterCoord.X - i;
  FRect.Right   := CenterCoord.X + i;
  FRect.Top     := CenterCoord.Y - i;
  FRect.Bottom  := CenterCoord.Y + i;

end;


procedure TRadarTimeBaseView.DrawView(aCnv: TCanvas);
begin
  FOnDraw(aCnv);

//  DrawBackGround(aCnv);
//  DrawTimeBase(aCnv);
//  DrawOriginale(aCnv);
//  DrawSimpleTimebase(aCnv);
end;

procedure TRadarTimeBaseView.DrawBackGround(aCnv: TCanvas);
var i: integer;
    r: TRect;
    cl : TColor;
    s: single;
    b: byte;
begin
  r := Rect(0,0, FMap.Width, FMap.Height);
  ///--> copy clean map
    BitBlt(FBmpFG.Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom,
           aCnv.Handle, r.Left, r.Top,
           SRCCOPY);

  ///--> add the colored timebase
    if Darkness <> 0 then
      BitmapSubstract(FBmpFG, Darkness);
  ///--> return to mapx canvas
    BitBlt(aCnv.Handle, r.Left, r.Top, r.Right, r.Bottom,
           FBmpFG.Canvas.Handle, r.Left, r.Top,
           SRCCOPY);
end;

procedure TRadarTimeBaseView.DrawTimeBase(aCnv: TCanvas);
var i: integer;
    r: TRect;
    cl : TColor;
    s: single;
begin
  r := Rect(0,0, FMap.Width, FMap.Height);
///--> draw the time base
  BitmapFillBlack(FBmpBG);
  with FBmpBG.Canvas do begin
    Pen.Width := Size;
    Pen.Style := psSolid;

    Brush.Color := Color;
    Pen.Color := Color;
    cl := Color;
    for i := 0 to FSweepWidth-1 do begin
      s := 256 * sqrt(0.5 * i / FSweepWidth);
      cl := Color;
      DarkColor(cl, Round(s));
      Pen.Color := cl;
      MoveTo(CenterCoord.X, CenterCoord.Y);
      LineTo(FPoints[i].X, FPoints[i].Y);
    end;

  end;
  if Darkness <> 0 then
    BitmapSubstract(FBmpBG, Darkness);

///--> return to mapx canvas
  BitBlt(aCnv.Handle, r.Left, r.Top, r.Right, r.Bottom,
         FBmpBG.Canvas.Handle, r.Left, r.Top,
         SRCCOPY);
end;

procedure TRadarTimeBaseView.DrawClean(aCnv: TCanvas);
var i: integer;
    r: TRect;
    cl : TColor;
    s: single;
begin
  r := Rect(0,0, FMap.Width, FMap.Height);
///--> draw the time base
  BitmapFillBlack(FBmpBG);
  if Darkness <> 0 then
    BitmapSubstract(FBmpBG, Darkness);

///--> return to mapx canvas
  BitBlt(aCnv.Handle, r.Left, r.Top, r.Right, r.Bottom,
         FBmpBG.Canvas.Handle, r.Left, r.Top,
         SRCCOPY);
end;

procedure TRadarTimeBaseView.DrawSimpleTimebase(aCnv: TCanvas);
begin
//-- batas simple timebase
  with aCnv do begin
    Pen.Color := Color;
    Pen.Width := Size;

    Pen.Style := psSolid;
    MoveTo(CenterCoord.X, CenterCoord.Y);
    LineTo(FPoint.X, FPoint.Y);
  end;
end;

procedure TRadarTimeBaseView.DrawOriginale(aCnv: TCanvas);
var i: integer;
    r: TRect;
    cl : TColor;
    s: single;
begin
  r := Rect(0,0, FMap.Width, FMap.Height);

  ///--> copy clean map
      BitBlt(FBmpFG.Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom,
             aCnv.Handle, r.Left, r.Top, SRCCOPY);

  if UseEffect then begin
  ///--> draw the time base
//    BitmapFillBlack(FBmpBG);
    with FBmpBG.Canvas do begin
      Pen.Width := Size;
      Pen.Style := psSolid;

      Brush.Color := Color;
      Pen.Color := Color;
      cl := Color;
      for i := 0 to FSweepWidth-1 do begin
        s := 256 * sqrt(0.5 * i / FSweepWidth);
//        s := 256 * (i / FSweepWidth);
        cl := Color;
        DarkColor(cl, Round(s));
        Pen.Color := cl;
        MoveTo(CenterCoord.X, CenterCoord.Y);
        LineTo(FPoints[i].X, FPoints[i].Y);
      end;

    end;
    BitmapBlur(FBmpBG);

  ///--> create visible area by timbase using white mask;
    with FBmpMask.Canvas do begin
      Pen.Width := Size;
      Pen.Style := psSolid;

      Pen.Color := clWhite;
      cl := Color;
      for i := 0 to FSweepWidth-1 do begin
        MoveTo(CenterCoord.X, CenterCoord.Y);
        LineTo(FPoints[i].X, FPoints[i].Y);
      end;

    end;
    BitmapBlur(FBmpMask);

    if AddNoise then
      BitmapNoise(FBmpFG, NoiseLevel, Color);

    BitmapBlend_AND(FBmpMask, FBmpFG);

  ///--> add the colored timebase
    BitmapBlend_avg(FBmpBG, FBmpFG);
    if Darkness <> 0 then
      BitmapSubstract(FBmpFG, Darkness);

  ///--> return to mapx canvas
    BitBlt(aCnv.Handle, r.Left, r.Top, r.Right, r.Bottom,
           FBmpFG.Canvas.Handle, r.Left, r.Top, SRCCOPY);
  end;
end;

//=============================================================================
{ TRadarSectorView }

//********untuk tampilan 16 sector ********************
constructor TRadarSectorView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
var i : integer;
begin
  inherited;

  for i:= 0 to 15 do
    FSudut[i] := i * 0.125 * Pi  ;

//  Visible:= true;
  Color := C_defColor;
  Size := 1;
end;

procedure TRadarSectorView.ConvertDataPosition;
var sx, sy : single;
    dx, dy: double;
    theRadar : TClientRadar;
    sinX, cosX : extended;
    i : integer;
begin
  inherited;

  theRadar := FParent as TClientRadar;

  FRange :=  theRadar.DetectionRange * C_NauticalMile_To_Degree;
  for i:= 0 to 15 do  begin
    SinCos(FSudut[i], sinX, cosX );

    dx := theRadar.PositionX + FRange * cosX;
    dy := theRadar.PositionY + FRange * sinX;

    FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

    FPoint[i].X := Round(sx);
    FPoint[i].Y := Round(sy);
  end;
end;

procedure TRadarSectorView.DrawView(aCnv:TCanvas);
var i : integer;
begin
  with aCnv do begin
    for i:= 0 to 15 do begin
      Pen.Color := Color;
      Pen.Width := Size;

      Pen.Style := psDot;
      MoveTo(CenterCoord.X, CenterCoord.Y);
      LineTo(FPoint[i].X, FPoint[i].Y);
    end;
  end;
end;


{ TRadarPolarView }
constructor TRadarPolarView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;
  Color := C_defColor;

  SetRangeInterval(20.0); // nautical miles
end;

destructor TRadarPolarView.Destroy;
begin
  SetLength(FRects, 0);
 // SetLength(FRanges, 0);
//  SetLength(FMapRects,  0);

  inherited;
end;

procedure TRadarPolarView.ConvertDataPosition;
var sx, sy: single;
    i : integer;
    pt : tDouble2DPoint;
    dRct: TDoubleRect;

    rdr : TClientRadar;
    r: double;
    sinx, cosx, rot: extended;
begin
  if abs(FRangeInterval) < 0.0000001 then exit;
  inherited;

  rdr  := FParent as TClientRadar;
  pt := Double2DPoint(rdr.PositionX, rdr.PositionY);

//  FNumOfRanges := Floor(rdr.DetectionRange / FRangeInterval);
  FNumOfRanges :=  Floor(FRangeMax / FRangeInterval);
  if FNumOfRanges <> Length(FRects) then begin
    SetLength(FRects,     FNumOfRanges);
  end;

  rot :=  ConvCompass_To_Cartesian(-FMap.Rotation ) * C_DegToRad;
  SinCos(rot, sinx, cosx);

  for i := 0 to FNumOfRanges-1 do begin
    r := i* FRangeInterval * C_NauticalMile_To_Degree;

    dRct.Left := pt.X + (-r * cosx) - (-r * sinx);
    dRct.Top  := pt.Y + (-r * sinx) + (-r * cosx);

    dRct.Right := pt.X + (r * cosx) - (r * sinx);
    dRct.Bottom  := pt.Y + (r * sinx) + (r * cosx);

    FMap.ConvertCoord(sx, sy, dRct.Left, dRct.Top , miMapToScreen);
    FRects[i].TopLeft := Point(Round(sx), Round(sy));

    FMap.ConvertCoord(sx, sy, dRct.Right, dRct.Bottom , miMapToScreen);
    FRects[i].BottomRight := Point(Round(sx), Round(sy));
  end;
end;


procedure TRadarPolarView.DrawView(aCnv: TCanvas);
var i : integer;
begin
  inherited;

  for i := 0 to FNumOfRanges-1 do begin
    aCnv.Pen.Color := Color;
    aCnv.Pen.Style := psSolid;
//    aCnv.Brush.Style := bsClear;
    aCnv.Arc(FRects[i].Left, FRects[i].Top , FRects[i].Right , FRects[i].Bottom,
     0, 0, 0, 0);
  end;
end;

procedure TRadarPolarView.SetRangeInterval(const Value: double);
//var rdr : TClientRadar;
begin

  FRangeInterval := Value;

//  rdr  := FParent as TClientRadar;
{  pt := Double2DPoint(rdr.PositionX, rdr.PositionY);

   for i := 1 to FNumOfRanges do begin
     FRanges[i-1]   :=  i* FRangeInterval;
     FMapRects[i-1] := Double2DPointToDoubleRect(pt, FRanges[i-1]) ;
  end;
}
end;

procedure TRadarPolarView.SetRangeMax(const Value: double);
begin
  FRangeMax := abs(Value);
end;

end.
