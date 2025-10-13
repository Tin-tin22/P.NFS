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
   Windows, Graphics, MapXLib_TLB ,

   uBaseDatatype, uBaseSimulationObject, uMapXSim ;

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
    TRadarTimeBaseView = class(TSimViewOnMapX)
    private
      FPoint : TPoint;
      FSudut : double;

    public
      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

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

      procedure SetRangeInterval(const Value: double);

    public

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      destructor Destroy; override;

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

    public
      property RangeInterval : double read FRangeInterval write SetRangeInterval;

    end;

implementation

uses

  uLibRadar, uBaseFunction, uBaseConstan,
  Math, Classes;

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
    dist: double;
    x1, y1, x2, y2 : double;
    sx, sy: single;
begin
  inherited;

  rdr  := FParent as TClientRadar;
  dist := rdr.DetectionRange * C_NauticalMile_To_Degree;
  x1  := rdr.PositionX - dist;
  x2  := rdr.PositionX + dist;
  y1  := rdr.PositionY - dist;
  y2  := rdr.PositionY + dist;

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
  Color := clWhite;

end;

destructor TRadarTimeBaseView.Destroy;
begin

  inherited;
end;

procedure TRadarTimeBaseView.ConvertDataPosition;
var sx, sy : single;
    dx, dy: double;
    rRange : double;
    theRadar : TClientRadar;
    sinX, cosX : extended;

begin
  inherited;
  theRadar := FParent as TClientRadar;

  rRange :=  theRadar.DetectionRange * C_NauticalMile_To_Degree;
  FSudut := theRadar.TimeBase.OriginalDirection;

  SinCos((C_DegToRad * FSudut), sinX, cosX );

  dx := theRadar.PositionX + rRange * cosX;
  dy := theRadar.PositionY + rRange * sinX;

  FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

  FPoint.X := Round(sx);
  FPoint.Y := Round(sy);

end;

procedure TRadarTimeBaseView.DrawView(aCnv: TCanvas);
begin

  with aCnv do begin
    Pen.Color := Color;
    Pen.Width := Size;

    Pen.Style := psSolid;
    MoveTo(CenterCoord.X, CenterCoord.Y);
    LineTo(FPoint.X, FPoint.Y);

  end;

end;

//=============================================================================
{ TSectorView }

//********untuk tampilan 16 sector ********************
constructor TRadarSectorView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
var i : integer;
begin
  inherited;

  for i:= 0 to 15 do
    FSudut[i] := i * 0.125 * Pi  ;

//  Visible:= true;
  Color := clWhite;
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
  Color := clWhite;

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
begin
  if abs(FRangeInterval) < 0.0000001 then exit;
  inherited;

  rdr  := FParent as TClientRadar;
  pt := Double2DPoint(rdr.PositionX, rdr.PositionY);

  FNumOfRanges := Floor(rdr.DetectionRange / FRangeInterval);

  if FNumOfRanges <> Length(FRects) then begin
    SetLength(FRects,     FNumOfRanges);
  end;

  for i := 0 to FNumOfRanges-1 do begin
     r := i* FRangeInterval * C_NauticalMile_To_Degree;
     dRct := Double2DPointToDoubleRect(pt, r) ;

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
    aCnv.Pen.Style := psDot;
    aCnv.Brush.Style := bsClear;
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

end.
