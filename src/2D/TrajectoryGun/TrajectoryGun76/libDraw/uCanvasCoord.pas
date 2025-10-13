unit uCanvasCoord;

interface
uses
  Windows, Graphics;
type

  tVect2D = record
    X, Y : double
  end;

  TCanvasCoord = class
  private
    FScale,
    FMax    : tVect2D;

    FWidth : integer;
    FHeight: integer;

    procedure setMax(const Index: integer; const Value: double);
    procedure setSize(const Index, Value: integer);
    procedure DrawTick(aCnv: TCanvas);

  public
    Offset: TPoint;

    constructor Create;

    function ConvertX(const xMeter: double): integer;
    function ConvertY(const yMeter: double): integer;

    procedure Draw(aCnv: TCanvas);

  public
    property MaxX   : double index 1 read FMax.X write setMax;
    property MaxY   : double index 2 read FMax.Y write setMax;

    property Width  : integer index 1 read FWidth write setSize;
    property Height : integer index 2 read FHeight write setSize;

  end;

  TPointMarker = class
  protected
    pt: TPoint;
  public
    X       : double;
    Y       : double;
    Color   : TColor;

    ptMin, ptMax: TPoint;
    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;

  TElevMarker = class
  protected
    ptC, ptR: TPoint;
  public
    R       : double;
    E       : double;  //elevataion
    X       : double; // origin
    Y       : double; //
    Color   : TColor;
    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;

  TPointTrajectory = class
  protected
    Fpt: array of TPoint;

  public
    Size: integer;
    FR : array of tVect2D;
    constructor Create;
    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;



implementation

uses
  Types, SysUtils, Math;
{ TCanvasCoord }

constructor TCanvasCoord.Create;
begin
  Offset.X := 160;
  Offset.Y := 360;

  FMax.X := 16000;
  FMax.Y := 12000;

  Width  := 800;
  Height := Round(FWidth *  FMax.Y / FMax.X );

//  Elev  := 0;
end;

procedure TCanvasCoord.setMax(const Index: integer; const Value: double);
begin
  case index of
    1: begin
      FMax.X    := Value;
      FScale.X  := FWidth / Value;
    end;
    2: begin
      FMax.Y    := Value;
      FScale.Y  := FHeight / Value;
    end;
  end;
end;

procedure TCanvasCoord.setSize(const Index, Value: integer);
begin
  case index of
    1: begin
      FWidth   := Value;
      FScale.X := FWidth / FMax.X;
    end;
    2: begin
      FHeight  := Value;
      FScale.Y := FHeight / FMax.Y;
    end;
  end;

end;

function TCanvasCoord.ConvertX(const xMeter: double): integer;
begin
  result := Offset.X + Round (xMeter * FScale.X);
end;

function TCanvasCoord.ConvertY(const yMeter: double): integer;
begin
  result := Offset.Y - Round (yMeter * FScale.Y);
end;


procedure TCanvasCoord.DrawTick(aCnv: TCanvas);
var i, iMax: integer;
    pt: TPoint;
    fsz: integer;
begin
  fsz := aCnv.Font.Size;
  aCnv.Font.Size := 7;

  iMax := Round(0.001 * FMax.X);
  pt.Y := Offset.Y +1;
  SetBkMode(aCnv.Handle, TRANSPARENT);
  aCnv.Font.Color := RGB(128, 0, 0);
  aCnv.Pen.Color := RGB(128, 0, 0);

  for i := 1 to iMax do begin
    pt.X := Offset.X + Round(FScale.X * i * 1000 );
    aCnv.MoveTo(pt.X, pt.Y);
    aCnv.LineTo(pt.X, pt.Y + 3);
    aCnv.TextOut(pt.X,pt.Y + 5, IntToStr(i) );

  end;

  iMax := Round(0.001 * FMax.Y);
  pt.X := Offset.X -1;

  aCnv.Font.Color := RGB(0, 128, 0);
  aCnv.Pen.Color := RGB(0, 128, 0);
  for i := 1 to iMax do begin
    pt.Y := Offset.Y - Round(FScale.Y * i * 1000 );

    aCnv.MoveTo(pt.X -3,  pt.Y);
    aCnv.LineTo(pt.X,     pt.Y);
    aCnv.TextOut(pt.X -8, pt.Y, IntToStr(i) );

  end;

  aCnv.Font.Size := fsz;
end;

procedure TCanvasCoord.Draw(aCnv: TCanvas);
begin

  aCnv.Pen.Mode   := pmCopy;
  aCnv.Pen.Style  := psSolid;

  aCnv.Pen.Color := clRed;

  aCnv.MoveTo(Offset.X - 30,  Offset.Y);
  aCnv.LineTo(Offset.X + FWidth, Offset.Y);

  aCnv.Pen.Color := clGreen;
  aCnv.MoveTo(Offset.X , Offset.Y - FHeight);
  aCnv.LineTo(Offset.X , Offset.Y + 30);

  DrawTick(aCnv);

end;

{ TPointMarker }

procedure TPointMarker.Converts(cc: TCanvasCoord);
begin
  pt.X := cc.ConvertX(X);
  pt.Y := cc.ConvertY(Y);

  ptMin.X := cc.Offset.X + 2;
  ptMin.Y := cc.Offset.Y + 2;

  ptMax.X := cc.Offset.X + cc.Width;
  ptMax.Y := cc.Offset.Y - cc.Height;

end;

procedure TPointMarker.Draw(aCnv: TCanvas);
const sz = 3;
var r: TRect;
begin

  aCnv.Pen.Mode   := pmMerge;
  aCnv.Pen.Style  := psDot;
  aCnv.Brush.Color := Color;
  aCnv.Pen.Color := Color or RGB(127, 127, 127);
  aCnv.MoveTo( ptMin.X, pt.Y);
  aCnv.LineTo( ptMax.X, pt.Y);

  aCnv.MoveTo( pt.X, ptMin.Y);
  aCnv.LineTo( pt.X, ptMax.Y);

  r := Rect(pt.X-sz, pt.Y-sz, pt.X+sz, pt.Y+sz);

  aCnv.Brush.Color := Color;
  aCnv.Pen.Mode := pmCopy;
  aCnv.Pen.Style := psSolid;
  aCnv.Rectangle(r);

  aCnv.Font.Color := Color or RGB(64, 64, 64);
  SetBkMode(aCnv.Handle, TRANSPARENT);
  aCnv.TextOut(pt.X + 4, pt.Y - 15, Format('%2.2f, %2.2f', [x, y] ));

end;

procedure TElevMarker.Converts(cc: TCanvasCoord);
var dx, dy: double;
begin
  ptC.X   := cc.ConvertX(X);
  ptC.Y   := cc.ConvertY(Y);

  dx := X + r * cos (DegToRad(E));
  dy := Y + r * sin (DegToRad(E));

  ptR.X   := cc.ConvertX(dx);
  ptR.Y   := cc.ConvertY(dy);

end;

procedure TElevMarker.Draw(aCnv: TCanvas);
begin
  aCnv.Pen.Color := Color;
  aCnv.MoveTo(ptC.X, ptC.Y);
  aCnv.LineTo(ptR.X, ptR.Y);

  aCnv.TextOut(ptR.X + 4 , ptR.Y, FormatFloat('00.0', E));
end;


{ TPointTrajectory }
constructor TPointTrajectory.Create;
begin
  Size := 11;
  SetLength(FPt, Size);
  SetLength(FR , Size);

end;

procedure TPointTrajectory.Converts(cc: TCanvasCoord);
var i: integer;
begin

  for i := 0 to Size-1 do begin
    Fpt[i].X := cc.ConvertX(FR[i].X);
    Fpt[i].Y := cc.ConvertY(FR[i].Y);
  end;

end;


procedure TPointTrajectory.Draw(aCnv: TCanvas);
const sz = 2;
var i: integer;
    r: TRect;
begin
  i := 0;
  aCnv.Brush.Color := clWhite;
  aCnv.Pen.Color := clSilver;
  r := Rect(Fpt[i].X-sz, Fpt[i].Y-sz, Fpt[i].X+sz, Fpt[i].Y+sz);
  aCnv.Ellipse(r);

  aCnv.MoveTo(Fpt[i].X, Fpt[i].Y);
  for i := 0 to Size-1 do begin
    aCnv.LineTo(Fpt[i].X, Fpt[i].Y);
    r := Rect(Fpt[i].X-sz, Fpt[i].Y-sz, Fpt[i].X+sz, Fpt[i].Y+sz);
    aCnv.Ellipse(r);
  end;

end;

end.
