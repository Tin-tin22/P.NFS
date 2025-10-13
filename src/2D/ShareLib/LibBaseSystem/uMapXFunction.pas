unit uMapXFunction;

interface
  uses
    Windows, MapXLib_TLB;

  const

   TOOL_DISTANCE  = 100;
   TOOL_MOVE_UNIT = 101;

   
  procedure SetAllLayerVisibility(map: TMap; const v: boolean);
  function GetMapUnitStr(const i: integer): string;

implementation

  uses
    Variants;


procedure SetAllLayerVisibility(map: TMap; const v: boolean);
var i: integer;
    lyrCount : integer;
begin
    lyrCount := map.Layers.Count;
    for i := 1 to lyrCount do begin
      map.Layers.Item(i).Visible := v;
    end;
end;

function GetMapUnitStr(const i: integer): string;
begin
  case i of
    miUnitNauticalMile: Result := 'Nautical Mile';
    miUnitMile: Result := 'Mile';
    miUnitKilometer: Result := 'Kilometer';
    miUnitFoot: Result := 'Feet';
    miUnitYard: Result := 'Yard';
    miUnitMeter: Result := 'Meter';
  else
    Result := 'Unknown';
  end;
end;

end.
