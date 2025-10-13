unit uMapWindow;

interface

uses
  MapXLib_TLB,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls,  Menus, uBaseDataType;

const
  TOOL_RANGE_BEARING = 01;
  TOOL_SELECT_MARKER   = 02;


type

  TMapDisplayCoord = record
    iPt :  TPoint;
    dPt :  t2DPoint;
  end;

  TfrmMapWindow = class(TForm)
    Map: TMap;
    PopupMenu1: TPopupMenu;
    pmnFullscreen: TMenuItem;
    mnBackGround: TMenuItem;
    mnLayer: TMenuItem;
    pmnDegeeMarker: TMenuItem;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure MapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Cardinal; const RectFull,
      RectInvalid: IDispatch);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pmnFullscreenClick(Sender: TObject);
    procedure mnLayerClick(Sender: TObject);
    procedure mnBackGroundClick(Sender: TObject);
    procedure pmnDegeeMarkerClick(Sender: TObject);
    procedure MapToolUsed(ASender: TObject; ToolNum: Smallint; X1, Y1, X2,
      Y2, Distance: Double; Shift, Ctrl: WordBool;
      var EnableDefault: WordBool);
  private
    {Cover}
    rRadius, rCX, rCY: integer;

    {Full screen}
    prevPos       : TRect;

    mDown         : boolean;
    pt1, pt2      : TPoint;
    range, bearing: double;

  protected
    FCoverVisible   : boolean;

    procedure setRegionRectangle;
    procedure setRegionCircle;
    procedure DrawAngle(aCnv: TCanvas);
    procedure DrawRangeBearing(aCnv: TCanvas);
    procedure ConvertToScreen(var mdc: TMapDisplayCoord);
    function TestHitView(const x, y: integer; FArea : Trect): boolean;

  public
//    LPDCursor :  TMapDisplayCoord;

    { Public declarations }
    procedure CreateCustomTools;  virtual;


  end;

var
  frmMapWindow: TfrmMapWindow;

implementation


uses
  uSimulationManager, uBaseFunction ,Math ,Types, DateUtils;
{$R *.dfm}


{ TfrmMapWindow }

//------- Local function ------------

  function calcBoundRect(cx, cy, r: integer): TRect;
  begin
    with result do begin
      Left    := cx - r;
      Right   := cx + r;
      Top     := cy - r;
      Bottom  := cy + r;
    end;
  end;

  function TfrmMapWindow.TestHitView(const x, y: integer; FArea : Trect): boolean;
  var pt : TPoint;
  begin
    pt.X := x;
    pt.Y := y;
    result := ptInRect(FArea, pt);
  end;


//------- {Procedure} ----------------------------------------------------------
procedure TfrmMapWindow.CreateCustomTools;
var z: OleVariant;
begin
  InitOleVariant(z);
  Map.CreateCustomTool(
    TOOL_RANGE_BEARING, miToolTypePoint, miCrossCursor, miCrossCursor, miCrossCursor, z);

  Map.CreateCustomTool(
    TOOL_SELECT_MARKER, miToolTypePoint, miCrossCursor, miCrossCursor, miCrossCursor, z);
end;

procedure TfrmMapWindow.setRegionRectangle;
var nRgn : HRGN;
begin
  nRgn := CreateRectRgn(0, 0, ClientWidth, ClientHeight);
  SetWindowRgn(map.Handle, nrgn, true);
end;

procedure TfrmMapWindow.setRegionCircle;
const brd = 30;
var eRgn: HRGN;
    r : TRect;
    rcxMap, rcyMap : integer;
begin
  rCXMap := Map.Width  shr 1;
  rCYMap := Map.Height shr 1;

  r := Rect(0,0, Map.Width, Map.Height);
  eRgn := CreateEllipticRgn(r.Left, r.Top, r.Right, r.Bottom);
  SetWindowRgn(map.Handle, eRgn, true);

  //global Form Koord
  rCx := rcxMap - Map.Left;
  rCy := rCYMap + Map.Top;
end;

  procedure TfrmMapWindow.DrawAngle(aCnv: TCanvas);

  procedure TranslatePoint(var pt: TPoint);
  begin
    pt.x := rCX + pt.X;
    pt.y := rCY - pt.Y;
  end;

  function ConvertScreenPoint(const aRadian, aRange: double): TPoint;
  var  ptd : tDouble2DPoint;
  begin

    ptd :=  ConvCoordPolar_To_Cartesian(0.5*Pi-aRadian, aRange);
    Result.X := Round(ptd.X);
    Result.Y := Round(ptd.Y);
    TranslatePoint(Result);
  end;

const tickwidth = 12;
      lbl_Space = 20;
      lbl_W = 10;
      lbl_H = 7;
var i, maxi : integer;
    aDeg: double;
    iDeg : integer;
    rct : TRect;
    pnt, pt1, pt2: TPoint;
    degreeMark : integer;
begin
  aCnv.Pen.Color := clWhite;
  Font.Color := clYellow;

  i := 5;
  while i < 360 do begin
    aDeg := DegToRad(i);

    pt1 := ConvertScreenPoint(aDeg, rRadius);

    pt2 := ConvertScreenPoint(aDeg, rRadius + 8);

    aCnv.MoveTo (pt1.X, pt1.Y);
    aCnv.LineTo (pt2.X, pt2.Y);
    inc(i, 10);
  end;

  degreeMark := 10;
  for i := 1 to 359 do begin
    if (i  mod degreeMark) = 0 then continue;
    aDeg := DegToRad(i);

    pt1 := ConvertScreenPoint(aDeg, rRadius );
    pt2 := ConvertScreenPoint(aDeg, rRadius + 4 );

    aCnv.MoveTo (pt1.X, pt1.Y);
    aCnv.LineTo (pt2.X, pt2.Y);
  end;


  maxi  := (360 div DegreeMark)-1;
  for i := 0 to maxi do begin
    iDeg :=  i * DegreeMark;
    aDeg := DegToRad(iDeg);

    pt1 := ConvertScreenPoint(aDeg, rRadius );
    pt2 := ConvertScreenPoint(aDeg, rRadius + tickwidth);
    pnt := ConvertScreenPoint(aDeg, rRadius + lbl_Space);

    rct := Rect(pnt.x - lbl_W, pnt.y - lbl_H, pnt.x+ lbl_W, pnt.y + lbl_H);
    with aCnv do begin
      MoveTo (pt1.X, pt1.Y);
      LineTo (pt2.X, pt2.Y);
      TextOut(rct.Left, rct.Top , Format('%3d',[iDeg]));
    end;
  end;

  rct := calcBoundRect(rCX, rCY, rRadius-1  );
  with rct do
    aCnv.arc(Left, Top, Right, Bottom ,0,0,0,0);

  rct := calcBoundRect(rCX, rCY, rRadius+tickwidth);
  with rct do
    aCnv.arc(Left, Top, Right, Bottom ,0,0,0,0);
end;

procedure TfrmMapWindow.DrawRangeBearing(aCnv: TCanvas);
var str: string;
    sz : TSize;
    px, py: integer;
begin
  with  aCnv do begin
    Pen.Color := clYellow;
    Font.Color := clYellow;

    MoveTo(pt1.X, pt1.Y);
    LineTo(pt2.X, pt2.Y);


    Font.Name := 'Arial';
//    Font.Color := RGB(80, 40, 0);
    Font.Color := clYellow;

    Font.Size := 8;
    str := Format('%2.0f nm ~ %2.0f°',[range, bearing]);
    sz := TextExtent(str);

    px := (pt1.X + pt2.X - sz.cx) shr 1;
    py := (pt1.Y + pt2.Y) shr 1;

    if (bearing <= 45 )then
      pX := pX + 12
    else if pY < 135 then
      pY := pY + 12
    else if pY < 225 then
      pY := pY - 12 -sz.cy
    else
     pX := pX - sz.cx - 12;

    SetBKMode(aCnv.Handle, TRANSPARENT);
    TextOut(pX, pY, str);

  end
end;

//------- {form Event Handler} -------------------------------------------------
procedure TfrmMapWindow.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;
  Map.DoubleBuffered := true;

  mDown := false;

  CreateCustomTools;
end;

procedure TfrmMapWindow.MapDrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Cardinal;
  const RectFull, RectInvalid: IDispatch);

var cnv : TCanvas;
begin
  cnv := TCanvas.Create;
  try
    cnv.Handle := hOutputDC;

    if Assigned(SimCenter)then
      SimCenter.DrawAllOnMapXCanvas(cnv);

    if Map.CurrentTool = TOOL_RANGE_BEARING then
      DrawRangeBearing(cnv);

  finally
    cnv.Free;
  end;

end;


procedure TfrmMapWindow.FormResize(Sender: TObject);
begin
//  Repaint;
  if FCoverVisible then
    setRegionCircle
  else
    setRegionRectangle;

  Repaint;
end;

procedure TfrmMapWindow.FormPaint(Sender: TObject);
begin
//  if FCoverVisible then
//    DrawAngle(Canvas);

end;

procedure TfrmMapWindow.pmnFullscreenClick(Sender: TObject);
begin
  with pmnFullscreen do
    Checked := not Checked;

  if pmnFullscreen.Checked then begin
    prevPos        := ClientRect;
    prevPos.Left   := Left;
    prevPos.Right  := Width;
    prevPos.Top    := Top;
    prevPos.Bottom := Height;

    BorderStyle := bsNone;
    WindowState := wsMaximized;
  end
  else begin
    BorderStyle := bsSizeable;
    WindowState := wsNormal;
    Left   := prevPos.Left;
    Top    := prevPos.Top;
    Width  := prevPos.Right;
    Height := prevPos.Bottom;
  end;

end;

procedure TfrmMapWindow.mnLayerClick(Sender: TObject);
var x : OleVariant;
begin
  InitOleVariant(x);
  Map.Layers.LayersDlg(x, x);
end;


procedure TfrmMapWindow.mnBackGroundClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Map.BackColor := ColorDialog1.Color;
end;

procedure TfrmMapWindow.pmnDegeeMarkerClick(Sender: TObject);
begin

  with pmnDegeeMarker do begin
   Checked := not Checked;
   FCoverVisible  := Checked;

  if FCoverVisible then
    setRegionCircle
  else
    setRegionRectangle;
  end;
  Repaint;

end;

procedure TfrmMapWindow.MapToolUsed(ASender: TObject; ToolNum: Smallint;
  X1, Y1, X2, Y2, Distance: Double; Shift, Ctrl: WordBool;
  var EnableDefault: WordBool);
begin
 { case ToolNum of

    TOOL_TDC_OFFCENTER : begin
       Map.ZoomTo(Map.Zoom, X1, Y1);
    end;
  end;  }
end;


procedure TfrmMapWindow.ConvertToScreen(var mdc: TMapDisplayCoord);
var sx, sy: single;
begin
  Map.ConvertCoord(sx, sy, mdc.dPt.X, mdc.dPt.Y , miMapToScreen);
  mdc.iPt.X :=  Round(sx);
  mdc.iPt.Y :=  Round(sy);
end;




end.
