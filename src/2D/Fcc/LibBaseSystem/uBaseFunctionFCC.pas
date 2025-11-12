unit uBaseFunctionFCC;

interface
  uses
    Classes, Windows, Math, uBaseConst, Graphics, uCoordDataTypes;
  type
    TBGRA = packed record
      b, g, r, a: Byte;
    end;

  procedure TransAlphaBlend(aCnv: TCanvas; aBmpBG, aBmp: TBitmap;
    const x, y: integer; clTrans: TColor; aVal: Byte);
  procedure ChangeBitmapIndex(Bmp: TBitmap; const oldClr, newClr: TColor);
  procedure TranslatePoint(const ct: TPoint; var pt: TPoint);

  procedure InitOleVariant(var TheVar:OleVariant);

  function BlendPixel32(const p1, p2: TColor; const a: Byte): TColor;
  function RoundPoint(const d: t2DPoint): TPoint;

  function CalcBearing(const x1, y1, x2, y2: double): Double;
  function ValidateDegree(const aDegree: double): double;
  function ConvCartesian_To_Compass(const degree: double): double ;
  function ConvCompass_To_Cartesian(const degree: double): double;

  function ConvCustomAngleStart(const degree,startAngle: Double):Double;
  function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: Double)
    : t2DPoint;

implementation
  //==============================================================================
  procedure InitOleVariant(var TheVar:OleVariant);
  begin
    TVarData(TheVar).vType:=varError;
    TVarData(TheVar).vError:=  DISP_E_PARAMNOTFOUND;
  end;

  //==============================================================================
  function ConvCartesian_To_Compass(const degree: double): double ;
  begin
    // input : derajat (0..360) dari sumbu X, CCW, cartesian
    // output: derajat (0..360) dari utara,   CW, kompas

     result := 90.0 - degree;
     if result < 0.0 then result := result + 360.0;
  end;

  //==============================================================================
  function ConvCompass_To_Cartesian(const degree: double): double;
  begin
    result := ValidateDegree(90.0 - degree);
  end;

  //==============================================================================
  function ValidateDegree(const aDegree: double): double;
  begin
    result := aDegree - (Floor(aDegree / 360.0) * 360.0);
  end;

  //==============================================================================
  function ConvCustomAngleStart(const degree,startAngle: Double):Double;
  begin
    result := startAngle - degree;
    if result < 0.0 then result := result + 360.0;
  end;

  //==============================================================================
  function CalcBearing(const x1, y1, x2, y2: double): Double;
  var dx, dy, bearing: Extended;
  begin
    { input dec degree, output Compass Coord }
    dx := (x2 - x1);
    dy := (y2 - y1);
    bearing := C_RadToDeg * ArcTan2(dy, dx);
    result  := ConvCartesian_To_Compass(bearing);
  end;

  //==============================================================================
  procedure TransAlphaBlend(aCnv: TCanvas; aBmpBG, aBmp: TBitmap;
  const x, y: integer; clTrans: TColor; aVal: Byte);
  type
    PDWordArray = ^TDWordArray;
    TDWordArray = array [0 .. 255] of LongWord;
    // bitmap larger than 256 width is not supported;
  var
    i, j, iMax, jMax: integer;
    rB, rC: TRect;
    lBG, lBMP: PDWordArray;
  begin
    aBmp.PixelFormat := pf32bit;
    aBmpBG.PixelFormat := pf32bit;
    aBmpBG.Width := aBmp.Width div 2;
    aBmpBG.Height := aBmp.Height div 2;

    rC := Rect(x, y, x + aBmp.Width div 2, y + aBmp.Height div 2);
    rB := Rect(0, 0, aBmp.Width div 2, aBmp.Height div 2);

    aBmpBG.Canvas.CopyRect(rB, aCnv, rC);
    if aBmp.Height div 2 > 255 then
      jMax := 255
    else
      jMax := (aBmp.Height div 2) - 1;

    if aBmp.Height div 2 > 255 then
      iMax := 255
    else
      iMax := (aBmp.Width div 2) - 1;

    for j := 0 to jMax do
    begin
      lBG := aBmpBG.ScanLine[j];
      lBMP := aBmp.ScanLine[j];

      for i := 0 to iMax do
        if lBMP[i] <> clTrans then
          lBG[i] := BlendPixel32(lBG[i], lBMP[i], aVal);

    end;
    aCnv.Draw(x, y, aBmpBG);
  end;

  //==============================================================================
  function BlendPixel32(const p1, p2: TColor; const a: Byte): TColor;
  var
    minA: Byte;
    r1, r2, r3: ^TBGRA;
  begin
    r1 := @p1;
    r2 := @p2;
    minA := 255 - a;
    r3 := @result;
    r3.a := 0;
    r3.b := (r1^.b * minA + r2^.b * a) div 256;
    r3.g := (r1^.g * minA + r2^.g * a) div 256;
    r3.r := (r1^.r * minA + r2^.r * a) div 256;
  end;

  //==============================================================================
  // bitmap manipulation function
  procedure ChangeBitmapIndex(Bmp: TBitmap; const oldClr, newClr: TColor);
  // works only with 256 color bitmap..
  type
    TArrayByte = array [0 .. 255] of Byte;
    PAByte = ^TArrayByte;
  var
    i, j: integer;
    pB: PAByte;
    hPal: HPALETTE;
    oClr, nClr: Byte;
  begin
    Bmp.PixelFormat := pf8bit;
    hPal := Bmp.Palette;

    oClr := GetNearestPaletteIndex(hPal, oldClr);
    nClr := GetNearestPaletteIndex(hPal, newClr);

    for j := 0 to Bmp.Height - 1 do
    begin
      pB := Bmp.ScanLine[j];
      for i := 0 to Bmp.Width - 1 do
      begin
        if pB[i] = oClr then
          pB[i] := nClr
      end;
    end;
  end;

  function RoundPoint(const d: t2DPoint): TPoint;
  begin
    result.X := Round(d.X);
    result.Y := Round(d.Y);
  end;

  function ConvCoordPolar_To_Cartesian(const aAngleRadian, aRadius: Double)
    : t2DPoint;
  begin
    result.X := aRadius * Cos(aAngleRadian);
    result.Y := aRadius * Sin(aAngleRadian);
  end;

  procedure TranslatePoint(const ct: TPoint; var pt: TPoint);
  begin
    pt.X := ct.X + pt.X;
    pt.Y := ct.Y - pt.Y;
  end;

end.
