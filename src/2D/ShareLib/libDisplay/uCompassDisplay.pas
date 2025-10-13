unit uCompassDisplay;

interface

  uses
    Classes, Windows, Graphics;

  type

    TDrawCompass  = class
    public
      ptC : TPoint;
      Radius: integer;
      Color    : TColor;
      FontColor: TColor;

      constructor Create;
      procedure DrawCompass(aCnv: TCanvas); virtual;
   end;

    TDrawCompass2  = class (TDrawCompass)
    public

      procedure DrawCompass(aCnv: TCanvas); override;
    end;

implementation

  uses
    Math, SysUtils;

  type

   t2DPoint = record
     X : double;
     Y : double;
   end;


  function RoundPoint(const d: t2DPoint): TPoint;
  begin
   Result.X := Round(d.X);
   Result.Y := Round(d.Y);
  end;

  function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: double): t2DPoint;
  begin
    Result.x := aRadius * Cos(aAngleRadian);
    Result.y := aRadius * Sin(aAngleRadian);
  end;

  procedure TranslatePoint(const ct: TPoint; var pt: TPoint);
  begin
    pt.x := ct.X + pt.X;
    pt.y := ct.Y - pt.Y;
  end;
  function calcRect(const pt: tPoint; const r: integer): tRect;
  var d: integer;
  begin
    d := abs(r);
    Result := Rect(pt.X - d, pt.Y - d, pt.X + d, pt.Y + d)
  end;

 { TDrawCompass }
  constructor TDrawCompass.Create;
  begin
    ptC   := Point(0,0);
    Radius:= 100;
    Color :=  clRed;
  end;

  procedure TDrawCompass.DrawCompass(aCnv: TCanvas);
  const tickwidth = 10;
        lbl_Space = 18;
        lbl_W = 10;
        lbl_H = 7;
  var i, maxi : integer;
      aDeg: double;
      iDeg : integer;
      rct : TRect;
      pnt, pt1, pt2: TPoint;
      ptd : t2DPoint;
      degreeMark : integer;
  begin
    aCnv.Pen.Color := Color;
    aCnv.Font.Color := Color;

    degreeMark := 5;
    for i := 1 to 359 do begin
      if (i  mod degreeMark) = 0 then continue;
      aDeg := DegToRad(i);

      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius -1));
      TranslatePoint(ptC, pt1);
      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius - 4));
      TranslatePoint(ptC, pt2);

      aCnv.MoveTo (pt1.X, pt1.Y);
      aCnv.LineTo (pt2.X, pt2.Y);
    end;

    i := 5;
    while i < 360 do begin
      aDeg := DegToRad(i);
      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius -1));
      TranslatePoint(ptC, pt1);
      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius - 9));
      TranslatePoint(ptC, pt2);

      aCnv.MoveTo (pt1.X, pt1.Y);
      aCnv.LineTo (pt2.X, pt2.Y);
      inc(i, 10);
    end;

    degreeMark := 10;
    maxi  := (360 div DegreeMark)-1;
    for i := 0 to maxi do begin
      iDeg :=  i * DegreeMark;
      aDeg := DegToRad(iDeg);

      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius -1));
      TranslatePoint(ptC, pt1);

      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius - tickwidth));
      TranslatePoint(ptC, pt2);

      pnt := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius - lbl_Space));
      TranslatePoint(ptC, pnt);

      rct := Rect(pnt.x - lbl_W, pnt.y - lbl_H, pnt.x+ lbl_W, pnt.y + lbl_H);
      iDeg := (90 - iDeg);

      if iDeg < 0 then iDeg := iDeg + 360;
      if iDeg > 360 then iDeg := iDeg mod 360;

      SetBKMode(aCnv.Handle, TRANSPARENT);
      with aCnv do begin
        MoveTo (pt1.X, pt1.Y);
        LineTo (pt2.X, pt2.Y);
        TextOut(rct.Left, rct.Top , Format('%3d',[iDeg]));
      end;
    end;

   rct := calcRect(ptC, Radius  );
   with rct do
    aCnv.arc(Left, Top, Right, Bottom ,0,0,0,0);
  end;

{ TDrawCompass2 }

procedure TDrawCompass2.DrawCompass(aCnv: TCanvas);
  const tickwidth = 10;
        lbl_Space = 18;
        lbl_W = 10;
        lbl_H = 7;
  var i, maxi : integer;
      aDeg: double;
      iDeg : integer;
      rct : TRect;
      pnt, pt1, pt2: TPoint;
      ptd : t2DPoint;
      degreeMark : integer;
  begin
    aCnv.Pen.Color := Color;
    aCnv.Font.Color := Color;

    degreeMark := 5;
    for i := 1 to 359 do begin
      if (i  mod degreeMark) = 0 then continue;
      aDeg := DegToRad(i);

      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius +1));
      TranslatePoint(ptC, pt1);
      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius + 4));
      TranslatePoint(ptC, pt2);

      aCnv.MoveTo (pt1.X, pt1.Y);
      aCnv.LineTo (pt2.X, pt2.Y);
    end;

    i := 5;
    while i < 360 do begin
      aDeg := DegToRad(i);
      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius +1));
      TranslatePoint(ptC, pt1);
      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius + 9));
      TranslatePoint(ptC, pt2);

      aCnv.MoveTo (pt1.X, pt1.Y);
      aCnv.LineTo (pt2.X, pt2.Y);
      inc(i, 10);
    end;

    degreeMark := 10;
    maxi  := (360 div DegreeMark)-1;
    for i := 0 to maxi do begin
      iDeg :=  i * DegreeMark;
      aDeg := DegToRad(iDeg);

      pt1 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius +1));
      TranslatePoint(ptC, pt1);

      pt2 := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius + tickwidth));
      TranslatePoint(ptC, pt2);

      pnt := RoundPoint(ConvCoordPolar_To_Cartesian(aDeg, Radius + lbl_Space));
      TranslatePoint(ptC, pnt);

      rct := Rect(pnt.x - lbl_W, pnt.y - lbl_H, pnt.x+ lbl_W, pnt.y + lbl_H);
      iDeg := (90 - iDeg);

      if iDeg < 0 then iDeg := iDeg + 360;
      if iDeg > 360 then iDeg := iDeg mod 360;

      SetBKMode(aCnv.Handle, TRANSPARENT);
      with aCnv do begin
        MoveTo (pt1.X, pt1.Y);
        LineTo (pt2.X, pt2.Y);
        TextOut(rct.Left, rct.Top , Format('%3d',[iDeg]));
      end;
    end;

   rct := calcRect(ptC, Radius  );
   with rct do
    aCnv.arc(Left, Top, Right, Bottom ,0,0,0,0);

   rct := calcRect(ptC, Radius + tickwidth  );
   with rct do
    aCnv.arc(Left, Top, Right, Bottom ,0,0,0,0);
  end;

end.
