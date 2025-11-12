unit uSimVisuals;

interface
uses
  classes,windows, Graphics, GdiPlus, uCoordConverter;

type
  TDrawElement = class
  private
    procedure SetVisibility(const Index: Integer; const Value: boolean);

  protected
    FColor   : TColor;
    FCenter  : TPoint;
    FAlpha: Integer;

    FFilterShow: boolean;
    FVisible: boolean;
    FFinalShow: boolean;

    procedure SetFColor(const Value: TColor);  virtual;
    procedure SetCenter(const Value: TPoint); virtual;

  public
    Size    : byte;
    Size2  : Byte;
    Offset  : TPoint;
    FontName: TFontName;


    constructor Create;
    procedure Draw(aCnv: TCanvas); virtual;
    procedure ConvertCoord(cvt: TCoordConverter); virtual;


  published
    property Color : TColor read FColor write SetFColor;
    property Center: TPoint read FCenter write SetCenter;
    property Alpha : Integer read FAlpha write FAlpha;
    ///<summary> Visible is original state from menu or user. </summary>
    property Visible : boolean index 1 read FVisible write SetVisibility;

    ///<summary> Filter is  state from Filter menu. </summary>
    property FilterShow: boolean index 2 read FFilterShow write SetVisibility;

    ///<summary> FinalShow is finale state, will be draw or not. </summary>
    property FinalShow: boolean index 3 read FFinalShow;

  end;

implementation

{ TDrawElement }

procedure TDrawElement.ConvertCoord(cvt: TCoordConverter);
begin

end;

constructor TDrawElement.Create;
begin
  Size := 12;
  Size2 := 12;
  FontName := 'Arial';
  Color := RGB(12, 255, 12);
  FCenter := Point(0 ,0);
  FAlpha := 255;

  Offset := Center;
  Visible := true;
end;

procedure TDrawElement.Draw(aCnv: TCanvas);
begin
  if not Visible then
    exit;

  with aCnv do
  begin
    Font.Name := FontName;
    Font.Size := Size;
    //// this
    Font.Color := Color;
  end;

end;

procedure TDrawElement.SetCenter(const Value: TPoint);
begin
  FCenter := Value;
end;

procedure TDrawElement.SetFColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TDrawElement.SetVisibility(const Index: Integer;
  const Value: boolean);
begin
  case Index of
     1 : FVisible     := Value;
     2 : FFilterShow  := Value;
  end;
  FFinalShow := FVisible and FFilterShow;
end;

end.
