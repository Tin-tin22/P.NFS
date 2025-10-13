unit uMapWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, MapXLib_TLB, Menus;

type
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
    FCoverVisible   : boolean;
    rRadius, rCX, rCY: integer;

    {Full screen}
    prevPos       : TRect;


  protected
    procedure setRegionRectangle;
    procedure setRegionCircle;
    procedure DrawAngle(aCnv: TCanvas);
  public
    lyrDraw: CMapXLayer;
    { Public declarations }
    procedure CreateCustomTools;
    procedure LoadMap(const aGst: string);

    procedure SetRangeScale(const  aScaleNm: double);
  end;

var
  frmMapWindow: TfrmMapWindow;

implementation

uses uTDCManager, Math, uBaseDataType, uBaseFunction;
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

{  procedure InitOleVariant(var TheVar:OleVariant);
  begin
    TVarData(TheVar).vType:=varError;
    TVarData(TheVar).vError:=  DISP_E_PARAMNOTFOUND;
  end;
}
//------- {Procedure} ----------------------------------------------------------
procedure TfrmMapWindow.CreateCustomTools;
var z : OleVariant;
begin
  InitOleVariant(z);

  Map.CreateCustomTool(
    TOOL_TDC_OFFCENTER, miToolTypePoint, miCrossCursor, miCrossCursor, miCrossCursor, z);

end;


procedure TfrmMapWindow.LoadMap(const aGst: string);
var i: integer;
  z: OleVariant;
  mInfo : CMapXLayerInfo;
begin
  InitOleVariant(z);
  Map.Layers.RemoveAll;
  Map.Geoset := aGst;

  if aGst <> '' then begin
    for i := 1 to Map.Layers.Count do begin
      Map.Layers.Item(i).Selectable := false;
      Map.Layers.Item(i).LabelProperties.Style.TextFontColor := clYellow;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw ;
    mInfo.AddParameter('Name', 'Animation');
    lyrDraw := Map.Layers.Add(mInfo, 1);

    Map.Layers.AnimationLayer := lyrDraw;
    Map.BackColor := RGB(32, 64, 16);
//    Map.Zoom := Map.Zom * 0.6;
  end

end;

procedure TfrmMapWindow.setRegionRectangle;
var nRgn : HRGN;
begin
  nRgn := CreateRectRgn(0, 0, ClientWidth,clientHeight);
  SetWindowRgn(map.Handle, nrgn, true);
end;

{procedure TfrmMapWindow.setRegionCircle;
const brd = 30;
var eRgn: HRGN;
    r : TRect;
    rcxMap, rcyMap,  mapW,
    rsHalf : integer;
begin
  mapW  := Min (Map.Height, Map.Width);
  rsHalf := mapW shr 1;
  rCXMap := Map.Width  shr 1;
  rCYMap := Map.Height shr 1;

  r := calcBoundRect(rCxMap, rCyMap, (rsHalf - brd));
  rRadius := rsHalf - brd +2;

  //guaplekkkk!!! in koordinat pixelnya TMap!!
  eRgn := CreateEllipticRgn(r.Left, r.Top, r.Right, r.Bottom);
  SetWindowRgn(map.Handle, eRgn, true);

  //global Form Koord
  rCx := rcxMap - Map.Left;
  rCy := rCYMap + Map.Top;
end;
}
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


//------- {form Event Handler} -------------------------------------------------
procedure TfrmMapWindow.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;
  Map.DoubleBuffered := true;

  Map.BackColor := $00400000;
  FCoverVisible  := true;
  setRegionCircle;       //

  //CreateCustomTools;
end;

procedure TfrmMapWindow.MapDrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Cardinal;
  const RectFull, RectInvalid: IDispatch);

var cnv : TCanvas;
begin
  cnv := TCanvas.Create;
  try
    cnv.Handle := hOutputDC;

    if Assigned(uTDCManager.SimCenter)then
      uTDCManager.SimCenter.DrawAllOnMapXCanvas(cnv);

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
  if FCoverVisible then
    DrawAngle(Canvas);
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

procedure TfrmMapWindow.SetRangeScale(const aScaleNm: double);
begin

//  Map.CurrentTool := miZoomInTool;

  uTDCManager.SimCenter.FMap.MapUnit := miUnitNauticalMile;
//  ShowMessage(Format('%2.2f',[Map.Zoom] ));
  uTDCManager.SimCenter.FMap.Zoom := aScaleNm;
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

end.
