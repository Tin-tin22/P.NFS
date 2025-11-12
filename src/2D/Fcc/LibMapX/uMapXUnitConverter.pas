unit uMapXUnitConverter;

interface
uses
    MapXLib_TLB, uCoordConverter;

type
  TMapXUnitConverter = class(TCoordConverter)
  public
    FMap: TMap;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertToScreen(dx, dy: double; var ix, iy: integer); override;
    procedure ConvertToMap(const ix, iy: integer; var dx, dy: double); override;

{    function Distance_nmi(const x1, y1, x2, y2: double): double;
    function Distance_yard(const x1, y1, x2, y2: double): double;
    function Distance_meter(const x1, y1, x2, y2: double): double;
    function Distance_feet(const x1, y1, x2, y2: double): double;
}
  end;

implementation

{ TMapXUnitConverter }

procedure TMapXUnitConverter.ConvertToMap(const ix, iy: integer; var dx,
  dy: double);
var sx, sy: single;
begin
  if FMap = nil then begin
    dx := 0;
    dy := 0;
    exit;
  end;

  sx := ix;
  sy := iy;
  FMap.ConvertCoord(sx, sy, dx, dy, miScreenToMap);


end;

procedure TMapXUnitConverter.ConvertToScreen(dx, dy: double; var ix,
  iy: integer);
var sx, sy: single;
begin
  if FMap = nil then begin
    dx := 0;
    dy := 0;
    exit;
  end;

  FMap.ConvertCoord(sx, sy, dx, dy, miMapToScreen);
  ix := Round(sx);
  iy := Round(sy);
end;

constructor TMapXUnitConverter.Create;
begin
  FMap := nil;
end;

destructor TMapXUnitConverter.Destroy;
begin

  inherited;
end;

end.
