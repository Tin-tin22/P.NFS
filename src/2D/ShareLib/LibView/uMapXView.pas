unit uMapXView;

interface

  uses

    Windows, Graphics, MapXLib_TLB ,

    uBaseDataType,
    uBaseSimulationObject;

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

    end;

    //==========================================================================
    TSimClassOnMapX = class (TSimulationClass)

    public
       procedure CreateDefaultView(const aMap: TMap); virtual; abstract;

    end;

    //==========================================================================

implementation

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
  FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);

  CenterCoord.X := Round(sx);
  CenterCoord.Y := Round(sy);

end;

procedure TSimViewOnMapX.DrawView(aCnv: TCanvas);
begin

end;

end.
