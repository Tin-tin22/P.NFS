unit uMapXSim;

interface

  uses

    MapXLib_TLB,Windows, Graphics,

    uBaseDataType,
    uBaseSimulationObject,
    math;

  { CenterCoord   : TPoint;
    Visible       : boolean;
    Size          : Integer;
    Color         : TColor;
    Text          : string;
  }

  type

    //==========================================================================
    TSimViewOnMapX = class (TSimulationView)
    protected
      FMap : TMap;

    public

      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); virtual;
      destructor Destroy; override;

      property Parent: TSimulationClass read FParent write FParent;
    end;

    //==========================================================================
    TSimClassOnMapX = class (TSimulationClass)
    protected
      FMap : TMap;

    public
       procedure CreateDefaultView(const aMap: TMap); virtual;

       procedure ConvertViewsPosition(); virtual;
       procedure DrawViews(aCnv: TCanvas); virtual;

    end;


    function Convert_MapToScreen(const aMap: TMap; const pt: t2DPoint): TPoint;
    function Convert_ScreenToMap(const aMap: TMap; const pt: tPoint): t2DPoint;
    //==========================================================================

implementation

uses
   Classes, Dialogs, SysUtils;

{ TSimViewOnMapX }

constructor TSimViewOnMapX.CreateOnMapX(aParent: TSimulationClass; aMap: TMap);
begin
  inherited Create(aParent);

  FMap := aMap;
  Color := clBlue;
  Size  := 8;
  Text  := '';
end;

destructor TSimViewOnMapX.Destroy;
begin
  FMap := nil;

  inherited;
end;

procedure TSimViewOnMapX.ConvertDataPosition;
var sx, sy: single;
    dx, dy: double;
begin
  if not Assigned(FParent) then exit;

  dx := FParent.PositionX;
  dy := FParent.PositionY;

  if not IsNan(dx) and not IsNan(dy) then
  begin
    try
      FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
      CenterCoord.X := Round(sx);
      CenterCoord.Y := Round(sy);
    except
      
    end;
  end;
end;

procedure TSimViewOnMapX.DrawView(aCnv: TCanvas);
begin

end;

//==============================================================================
{ TSimClassOnMapX }

procedure TSimClassOnMapX.ConvertViewsPosition();
begin
  ViewContainer.ConvertAllDataPosition;
end;

procedure TSimClassOnMapX.DrawViews(aCnv: TCanvas);
begin
  ViewContainer.DrawAllView(aCnv);
end;

procedure TSimClassOnMapX.CreateDefaultView(const aMap: TMap);
begin
  FMap := aMap;
end;
//--------------------------------------------------------------------------
function Convert_MapToScreen(const aMap: TMap; const pt: t2DPoint): TPoint;
var sx, sy: single;
    dx, dy: double;
begin
  dx := pt.X;
  dy := pt.Y;

  aMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

  Result.X := Round(sx);
  Result.Y := Round(sy);
end;


function Convert_ScreenToMap(const aMap: TMap; const pt: tPoint): t2DPoint;
var sx, sy: single;
    dx, dy: double;
begin
  sx := pt.X;
  sy := pt.Y;

  aMap.ConvertCoord(sx, sy, dx, dy, miScreenToMap);

  Result.X := dx;
  Result.Y := dy;
end;

end.
