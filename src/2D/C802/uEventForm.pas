unit uEventForm;

interface

uses
   Windows, Graphics, Math, Dialogs, SysUtils, Classes;

type
   TEventForm = class

   const
      { default radius on compasa }
      radius = 160;

   private
      wCross, widthCross, hCross, heightCross, r : Integer;
      LongTemp, LatTemp : Double;

      procedure drawSmallCircle(FCanvas: TCanvas; x_sc,y_sc : Integer);
      procedure drawCircle(FCanvas : TCanvas);
      procedure drawTextOut(FCanvas : TCanvas);

      procedure drawLine(FCanvas : TCanvas);
      procedure drawPie(FCanvas : TCanvas);
      procedure drawNorthLine(FCanvas : TCanvas);

   public
      Pt : TPoint;

      procedure initCenterPt;
      procedure zoomMap;

      { draw compass }
      procedure drawCompass(FCanvas : TCanvas);

      procedure drawTarget(FCanvas : TCanvas; Xtarget, Ytarget: Double; num: Integer);

   end;

implementation

uses fPanelBawah, MapXLib_TLB, uBaseFunction, uBaseConstan, uBaseDataType;

procedure TEventForm.initCenterPt;
var X_screen, Y_screen: Single;
begin
  LongTemp := PanelBawah.MapC802.CenterX;
  LatTemp  := PanelBawah.MapC802.CenterY;

  PanelBawah.MapC802.ConvertCoord(X_screen, Y_screen, LongTemp, LatTemp,mimaptoscreen);

  Pt.X := Round(X_screen);
  Pt.Y := Round(Y_screen);
end;

procedure TEventForm.zoomMap;
var x_rad, y_rad : Single;
    Long_rad, Lat_rad: Double;
    x_sc_rad, y_sc_rad : Integer;

    x_cent, y_cent: Single;
    long_cent, lat_cent: Double;

    dist_rad, dist_map ,zoom_const: Double;
    point_rad, point_ctr : t2DPoint;
begin
  x_cent := Round(PanelBawah.MapC802.Width/2);
  y_cent := Round(PanelBawah.MapC802.Height/2);

  //longlat center of map
  PanelBawah.MapC802.ConvertCoord(x_cent, y_cent, long_cent, lat_cent, miScreenToMap);

  x_rad := x_cent;
  y_rad := y_cent - radius;

  //longlat radius from screen
  PanelBawah.MapC802.ConvertCoord(x_rad, y_rad, Long_rad, Lat_rad, miScreenToMap);

  //longlat radius from map
  point_ctr.X := long_cent;
  point_ctr.Y := lat_cent;
  point_rad := CalcPositionAhead(point_ctr,120 * C_KiloMeter_To_NauticalMiles, 90);

  dist_rad := Lat_rad - lat_cent;
  dist_map := point_rad.Y - lat_cent;
  zoom_const := dist_rad / dist_map;

  PanelBawah.MapC802.ZoomTo(PanelBawah.MapC802.Zoom/zoom_const, point_ctr.X, point_ctr.Y);
end;

procedure TEventForm.drawTarget(FCanvas: TCanvas; Xtarget, Ytarget: Double; num: Integer);
var h: Integer;
    Xtarget_sc, Ytarget_sc: Integer;
    X_sing, Y_sing: Single;
begin
  with FCanvas do
  begin
    Pen.Color   := clRed;
    Brush.Style := bsClear;
    h := 5;

    PanelBawah.MapC802.ConvertCoord(X_sing, Y_sing, Xtarget, Ytarget, miMapToScreen);
    Xtarget_sc := Round(X_sing);
    Ytarget_sc := Round(Y_sing);

    MoveTo(Xtarget_sc - h, Ytarget_sc);
    LineTo(Xtarget_sc, Ytarget_sc - h);
    MoveTo(Xtarget_sc, Ytarget_sc - h);
    LineTo(Xtarget_sc + h, Ytarget_sc);
    MoveTo(Xtarget_sc + h, Ytarget_sc);
    LineTo(Xtarget_sc, Ytarget_sc + h);
    MoveTo(Xtarget_sc, Ytarget_sc + h);
    LineTo(Xtarget_sc - h, Ytarget_sc);

    Font.Color  := clLtGray;
    Brush.Style := bsClear;
    Font.Size   := 10;

    TextOut(Xtarget_sc + 10, Ytarget_sc - 5, IntToStr(num));
  end;
end;

procedure TEventForm.drawSmallCircle(FCanvas: TCanvas; x_sc,y_sc : Integer);
var x_120,y_120 : Single;
    point_120, point_ctr : t2DPoint;
    x_sc_120,y_sc_120 : Integer;
begin
  with FCanvas do
  begin
    Pen.color   := clLtGray;
    Brush.Style := bsClear;
    r := Round(radius * (8/120));
    Ellipse(x_sc - r, y_sc - r, x_sc + r, y_sc + r);



    {
    //draw center point
    Pen.Color := clRed;
    Brush.Style := bsClear;
    r := 5;
    Ellipse(x_sc - r, y_sc - r, x_sc + r, y_sc+r);

    //draw point 120 km
    point_ctr.X := LongTemp;
    point_ctr.Y := LatTemp;
    point_120 := CalcPositionAhead(point_ctr,120 * C_KiloMeter_To_NauticalMiles, 0);
    PanelBawah.MapC802.ConvertCoord(x_120, y_120, point_120.X, point_120.Y,mimaptoscreen);
    x_sc_120 := Round(x_120);
    y_sc_120 := Round(y_120);

    Ellipse(x_sc_120-r, y_sc_120-r, x_sc_120+r, y_sc_120+r);

    MoveTo(Pt.X, Pt.Y);
    LineTo(x_sc_120, y_sc_120);
    }
  end;
end;

procedure TEventForm.drawCompass(FCanvas: TCanvas);
var
  helperPt : TPoint;
begin
  { initialize center point }
  initCenterPt;

  drawSmallCircle(FCanvas, Pt.X, Pt.Y);
  drawCircle(FCanvas);
  drawTextOut(FCanvas);
  drawLine(FCanvas);
  drawPie(FCanvas);
  drawNorthLine(FCanvas);

//  zoomMap;
end;

procedure TEventForm.drawCircle(FCanvas: TCanvas);
begin
  with FCanvas do
  begin
    Pen.color   := clLtGray;
    Brush.Style := bsClear;
    Ellipse(pt.X - radius, pt.Y - radius, pt.X + radius, pt.Y + radius);
  end;
end;

procedure TEventForm.drawPie(FCanvas: TCanvas);
var h_pie,s_rad : Integer;
begin
  with FCanvas do
  begin
    Pen.color   := clLime;
    Brush.Style := bsClear;
    h_pie := Round(ArcTan(DegToRad(30))*radius);
    Pie(pt.X - radius, pt.Y - radius, pt.X + radius, pt.Y + radius, pt.X-radius, pt.Y-h_pie, pt.X-radius, pt.Y+h_pie);
    Pie(pt.X - radius, pt.Y - radius, pt.X + radius, pt.Y + radius, pt.X+radius, pt.Y+h_pie, pt.X+radius, pt.Y-h_pie);

    s_rad := Round(radius * (8/120));
    h_pie := Round(ArcTan(DegToRad(30))*s_rad);
    Pie(pt.X - s_rad, pt.Y - s_rad, pt.X + s_rad, pt.Y + s_rad, pt.X-s_rad, pt.Y-h_pie, pt.X-s_rad, pt.Y+h_pie);
    Pie(pt.X - s_rad, pt.Y - s_rad, pt.X + s_rad, pt.Y + s_rad, pt.X+s_rad, pt.Y+h_pie, pt.X+s_rad, pt.Y-h_pie);
  end;
end;

procedure TEventForm.drawTextOut(FCanvas: TCanvas);
begin
  with FCanvas do
  begin
    Font.Color  := clLtGray;
    Brush.Style := bsClear;
    Font.Size   := 10;

    TextOut(Pt.X - 10, pt.Y + r + 5, '8 km');
    TextOut(pt.X - 15, (Pt.Y * 2) - 25, '120 km');
    TextOut(Pt.X - radius - 45, Pt.Y - 8, 'PRT');
    TextOut(Pt.X + radius + 25, Pt.Y - 8, 'STB');
  end;
end;

procedure TEventForm.drawLine(FCanvas : TCanvas);
begin
  with FCanvas do
  begin
    Pen.color   := clLtGray;
    Brush.Style := bsClear;
    MoveTo(Pt.X, Pt.Y - radius);
    LineTo(Pt.X, Pt.Y + radius);
    MoveTo(Pt.X - radius - 20, Pt.Y);
    LineTo(Pt.X + radius + 20, Pt.Y);
  end;
end;

procedure TEventForm.drawNorthLine(FCanvas : TCanvas);
var point_north, point_ctr : t2DPoint;
    x_north,y_north : Single;
    own_h : Double;
begin
  with FCanvas do
  begin
    point_ctr.X := LongTemp;
    point_ctr.Y := LatTemp;
    own_h := 360 - PanelBawah.ownHeading;
    point_north := CalcPositionAhead(point_ctr,120 * C_KiloMeter_To_NauticalMiles, ConvCompass_To_Cartesian(0));
    PanelBawah.MapC802.ConvertCoord(x_north, y_north, point_north.X, point_north.Y,mimaptoscreen);

    Pen.color   := clYellow;
    Brush.Style := bsClear;
    MoveTo(Pt.X, Pt.Y);
    LineTo(Round(x_north), Round(y_north));

    { line for ownship heading }
    {point_north := CalcPositionAhead(point_ctr,120 * C_KiloMeter_To_NauticalMiles, ConvCompass_To_Cartesian(PanelBawah.ownHeading));
    PanelBawah.MapC802.ConvertCoord(x_north, y_north, point_north.X, point_north.Y,mimaptoscreen);

    Pen.color   := clRed;
    Brush.Style := bsClear;
    MoveTo(Pt.X, Pt.Y);
    LineTo(Round(x_north), Round(y_north));}
  end;
end;

end.

