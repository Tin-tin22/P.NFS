unit uLabelDisplay;

interface
uses
  Classes, Windows, Graphics;
type

//==============================================================================
  TTextInfo = class
  public
    Size        : byte;
    Color       : TColor;
    Center      : TPoint;
    Offset      : TPoint;
    FontName    : TFontName;
    Visible     : boolean;

    constructor Create;
    procedure Draw(aCnv: TCanvas); virtual; abstract;
  end;

//==============================================================================
  TCharSymbol = class(TTextInfo)
  public
    CharSymbol  : Char;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;

  end;

//==============================================================================
  TInfoLabel = class(TTextInfo)
  public
    Line1: string;
    Line2: string;
    Line3: string;

    constructor Create;
    procedure Draw(aCnv: TCanvas); override;
  end;


implementation
//==============================================================================
{ TTextInfo }

constructor TTextInfo.Create;
begin
  Size   := 12;
  FontName := 'Sonar';
  Color := clLime;
  Center.x := 0;
  Center.y := 0;
  Offset := Center;
  Visible  := true;
end;

//==============================================================================
{ TCharSymbol }

constructor TCharSymbol.Create;
begin
  inherited;
  Size := 14;

  CharSymbol := 'U';
  Visible  := false;
end;

procedure TCharSymbol.Draw(aCnv: TCanvas);
var sz: TSize;
begin
  if not Visible then exit;
  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;
    sz :=  TextExtent(CharSymbol);
    //aligned center
    TextOut(Offset.x + Center.X - sz.cx shr 1,
            Offset.y + Center.y - sz.cy shr 1 ,
            CharSymbol);
  end;
end;
//==============================================================================
{ TInfoLabel }

constructor TInfoLabel.Create;
begin
  inherited;
  Size := 8;
  FontName := 'Arial';

  Line1 := ' ';
  Line2 := ' ';
  Line3 := ' ';
  Offset.x := 16;
  Offset.y := 0;

end;

procedure TInfoLabel.Draw(aCnv: TCanvas);
var p: TSmallPoint;
begin

  if not Visible then exit;

  p.x :=  Center.x + Offset.x;
  p.y :=  Center.y + Offset.y;

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  FontName;
    Font.Size  :=  Size;
    Font.Color :=  Color;

    TextOut(p.x, p.y -10  ,Line1);
    TextOut(p.x, p.y  ,Line2);
    TextOut(p.x, p.y + 10 ,Line3);
  end;

end;




end.
