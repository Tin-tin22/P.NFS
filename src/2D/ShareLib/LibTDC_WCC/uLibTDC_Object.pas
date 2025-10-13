unit uLibTDC_Object;

interface
  uses
    Graphics, MapXLib_TLB,
    uMapXSim, uMover, uBaseDataType, uBaseConstan, uObjectView, uRadarTracks;

  type

//==============================================================================


  //TSurfaceGrid = class(TSimClassOnMapX)
  TSurfaceGrid = class(TDisplayTrack)
  private

  public
    Symbol  : TSymbolView;
    Lbl     : TLineLabel;

    constructor Create;
    procedure CreateDefaultView(const aMap: TMap); override;

    procedure SetOrigin(const x, y: double);

    procedure ConvertLatLongToSGO(const x, y: double; var c: char; var xx, yy: double);
    procedure ConvertSGOToLatLong(const c: char; const xx, yy: double; var x, y: double);

  end;



implementation

uses uBaseSimulationObject;


{ TSurfaceGrid }
constructor TSurfaceGrid.Create;
begin
  inherited;

  Enabled := FALSE;
end;


procedure TSurfaceGrid.CreateDefaultView(const aMap: TMap);
begin
  inherited;
  Symbol := TSymbolView.CreateOnMapX(self, aMap);
  Symbol.CharSymbol := C_Symbol_Char[i_Surface_Grid_Ori];
  Symbol.FontName :=  'TDCCursor';
  Symbol.Size := 12;
  Symbol.Visible := TRUE;

  ViewContainer.AddObject(Symbol);

  Lbl := TLineLabel.CreateOnMapX(self, aMap);
  Lbl.Visible := TRUE;
  Lbl.Line.Text := 'GS';
  Lbl.Line.OffX :=  5;
  Lbl.Line.OffY :=  5;

  ViewContainer.AddObject(Lbl);

end;


procedure TSurfaceGrid.ConvertLatLongToSGO(const x, y: double; var c: char;
  var xx, yy: double);
var dx, dy: double;
begin
  dx := x - FPosition.X;
  dy := y - FPosition.Y;

  xx := abs(dx * C_Degree_To_NauticalMile);
  yy := abs(dy * C_Degree_To_NauticalMile);

  if dx > 0 then
    if dy > 0 then
      c := 'W'
    else
      c := 'B'
  else
    if dy > 0 then
      c := 'R'
    else
      c := 'G';
end;

procedure TSurfaceGrid.ConvertSGOToLatLong(const c: char; const xx,
  yy: double; var x, y: double);
begin
  x := abs(xx);
  y := abs(yy);

  case c of
    'W' : begin
//       x := x;
//       y := y;
    end;
    'R' : begin
       x := -x;
//       y :=  y;
    end;
    'G' : begin
       x := -x;
       y := -y;
    end;
    'B': begin
//       x :=  x;
       y := -y;
      end;
  end;
  x := FPosition.X + x * C_NauticalMile_To_Degree;
  y := FPosition.Y + y * C_NauticalMile_To_Degree;

end;

procedure TSurfaceGrid.SetOrigin(const x, y: double);
begin
  FPosition.X := x;
  FPosition.Y := y;
end;

end.
