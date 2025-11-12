unit uCoordConverter;
{
-=-- did Simulation Framework  -----=-
  desc     : Base Class untuk unit converter.
             implementasi class turunan : TMapXUnitConverter
             dicadangkan untuk unit conversi tanpa peta.

  lastedit : 2012 02 24

-=-------------------------------------------------------=-
}

interface

type

  TCoordConverter = class

  public

    constructor Create;
    destructor Destroy; override;

    procedure ConvertToScreen(dx, dy: double; var ix, iy: integer); virtual;
    procedure ConvertToMap(const ix, iy: integer; var dx, dy: double); virtual;

//    function NauticalMilesToPixels(const aNmRange: double): integer;
  end;


//var
//   VConvertor: TCoordConverter;

implementation

{ TCoordConverter }

procedure TCoordConverter.ConvertToMap(const ix, iy: integer; var dx,
  dy: double);
begin

end;

procedure TCoordConverter.ConvertToScreen(dx, dy: double; var ix, iy: integer);
begin

end;

constructor TCoordConverter.Create;
begin

end;

destructor TCoordConverter.Destroy;
begin

  inherited;
end;

//function TCoordConverter.NauticalMilesToPixels(const aNmRange: double): integer;
//begin
//  result := Round( abs((aNmRange * RectMap.xRToScreen ) /  60.0 ));
//end;

end.
