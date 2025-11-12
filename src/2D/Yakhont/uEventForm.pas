unit uEventForm;

interface

uses
   MapXLib_TLB, Windows, Graphics, Math, Dialogs, SysUtils, Classes;

type
   TEventForm = class

   const
      { default radius on compasa }
      radius = 340;
      angleOfSeeker = 30;
   private
      wCross, widthCross, hCross, heightCross : Integer;

   public
      Pt, targetPt, seekerPt : TPoint;

      { temp of position all target position }
      target_X  : Array of Integer;
      target_Y  : Array of Integer;
      targetPos : TPoint;

      length_array : Integer;

      { for ellipse }
      r1, r2 : Integer;
      angle1, angle2 : Integer;

      startX1, startY1,
      endX1, endY1,
      startX2, startY2,
      endX2, endY2     : Single;

      { just for stand alone }
      defLong, defLatt : double;

      procedure initCenterPt;
      procedure initTargetPt;
      procedure initSeekerPt;
      procedure drawSmallCircle(FCanvas : TCanvas; fPt : TPoint; r : Integer);

      { draw target }
      procedure drawTarget(FCanvas : TCanvas);

      { draw compass }
      procedure drawCompass(FCanvas : TCanvas);
      procedure drawCircle (FCanvas : TCanvas);
      procedure drawTextOut(FCanvas : TCanvas);

      procedure drawDistance(FCanvas : TCanvas; center_Pt : TPoint; target_Pt : TPoint);
      procedure drawSector  (FCanvas : TCanvas);
      procedure drawEllipse (FCanvas : TCanvas);

      procedure drawDistLessThan19 (FCanvas : TCanvas);

      procedure DrawRotatedEllipse(Fcanvas: TCanvas; rec: TRect; degrees: integer);
      procedure RotatePts(var pts: array of TPoint; origin: TPoint; radians: single);

      procedure setProperties;
      procedure setProperties_MM;
      procedure setProperties_CT1;
      procedure setProperties_CT2;

      { event on button }
      procedure eventBtnTIOnClick;
      procedure eventBtnSDOnClick;
      procedure eventBtnDESOnClick;
      procedure eventBtnPLPOnClick;
      procedure eventBtnDocClick;
      procedure eventBtnExitClick;

      procedure eventBtnCWRClick;
      procedure eventBtnAWRClick;
      procedure eventBtnEROnClick;

      procedure eventRTP;
      procedure eventPTP;
      procedure eventBtnLockClick;
      procedure eventBtnTDClick;

      procedure CalcOfFiringData;
      procedure SetResultCalc;

      procedure showCRData;

      procedure eventBtnHeatingClick;
      procedure eventBtnMMClick;

      procedure OnLauncher1(Color : TColor);
      procedure OnLauncher2(Color : TColor);
      procedure OnLauncher3(Color : TColor);
      procedure OnLauncher4(Color : TColor);

      function checkPoint(X: single; y: single; centX: Single; centY: single): Integer;
      function getX(sdt : Integer; r: Integer; SectorCenterX: Single) : Single;
      function getY(sdt : Integer; r: Integer; SectorCenterY: Single) : single;
//      function getInRange(ShipPosisitionX, ShipPositionY , TargetPositionX, TargetPositionY) : Boolean;
   end;

var
  EventForm : TEventForm;

implementation

uses uMainMM, uManualInput, uCRData, uSelectionTI, uRegimesOfWork,
  uTargetDestination, uCirculationASM, uTrackFunction, uLibClientObject,
  uLock, uEmergencyRelease, uBaseDataType, uBaseFunction, uBaseConstan,
  uAppointmentASM, uDoc, uTest, uYakhontManager, uHeating;

procedure TEventForm.initCenterPt;
var
  defX, defY : Single;
begin
  with fmMainMM do
  begin
    { default get own ship position directly }
    Pt.X := Round(temp_PosX);
    Pt.Y := Round(temp_PosY);
  end;
end;

procedure TEventForm.initTargetPt;
var
  posShip, posTarget : tDouble2DPoint;
begin
  if (YakhontManager.shipTarget1 <> 0) or (YakhontManager.shipTarget2 <> 0) then
  begin
    with fmMainMM do
    begin
      { assigned target }
      targetPt.X := Round(cTarget_PosX);
      targetPt.Y := Round(cTarget_PosY);
    end;
  end
  else
  begin
    with fmMainMM do
    begin
      if frmManualInput.typeOfVariant = 1 then
      begin
        { default get own ship position directly }
        posShip.X := YakhontManager.xShip.PositionX;
        posShip.Y := YakhontManager.xShip.PositionY;

        posTarget := CalcPositionAhead
        (posShip,
        (frmManualInput.Rec_TIVar1.DistTarget * C_Meter_To_NauticalMiles),
        ConvCompass_To_Cartesian(frmManualInput.Rec_TIVar1.BearingTarget));

        FMap.ConvertCoord(miTarget_PosX, miTarget_PosY, posTarget.X, posTarget.Y, miMapToScreen);
        targetPt.X := Round(miTarget_PosX);
        targetPt.Y := Round(miTarget_PosY);
      end
      else if frmManualInput.typeOfVariant = 2 then
      begin
        FMap.ConvertCoord(miTarget_PosX, miTarget_PosY, frmManualInput.Rec_TIVar2.LongTarget, frmManualInput.Rec_TIVar2.LattTarget, miMapToScreen);

        targetPt.X := Round(miTarget_PosX);
        targetPt.Y := Round(miTarget_PosY);
      end;
    end;
  end;
end;

procedure TEventForm.initSeekerPt;
var
  posShip, posSeeker : tDouble2DPoint;
begin
  if (YakhontManager.shipTarget1 <> 0) or (YakhontManager.shipTarget2 <> 0) then
  begin
    with fmMainMM do
    begin
      seekerPt.X := Round(seeker_PosX);
      seekerPt.Y := Round(seeker_PosY);
    end;
  end
  else
  begin
    with fmMainMM do
    begin
      if frmManualInput.typeOfVariant = 1 then
      begin
        { default get own ship position directly }
        posShip.X := YakhontManager.xShip.PositionX;
        posShip.Y := YakhontManager.xShip.PositionY;

        posSeeker := CalcPositionAhead
        (posShip,
        (frmManualInput.Rec_TIVar1.DistTarget * C_Meter_To_NauticalMiles) - (19 * C_KiloMeter_To_NauticalMiles),
        ConvCompass_To_Cartesian(frmManualInput.Rec_TIVar1.BearingTarget));

        FMap.ConvertCoord(miSeeker_PosX, miSeeker_PosY, posSeeker.X, posSeeker.Y, miMapToScreen);
        seekerPt.X := Round(miSeeker_PosX);
        seekerPt.Y := Round(miSeeker_PosY);
      end
      else if frmManualInput.typeOfVariant = 2 then
      begin
        { default get own ship position directly }
        posShip.X := YakhontManager.xShip.PositionX;
        posShip.Y := YakhontManager.xShip.PositionY;

        posSeeker := CalcPositionAhead(posShip,
        CalcRange(posShip.X, posShip.Y, frmManualInput.Rec_TIVar2.LongTarget, frmManualInput.Rec_TIVar2.LattTarget) - (19 * C_KiloMeter_To_NauticalMiles),
        ConvCompass_To_Cartesian(CalcBearing(posShip.X, posShip.Y, frmManualInput.Rec_TIVar2.LongTarget, frmManualInput.Rec_TIVar2.LattTarget)));

        fmMainMM.FMap.ConvertCoord(miSeeker_PosX, miSeeker_PosY, posSeeker.X, posSeeker.Y, miMapToScreen);
        seekerPt.X := Round(miSeeker_PosX);
        seekerPt.Y := Round(miSeeker_PosY);
      end;
    end;
  end;
end;

procedure TEventForm.drawCompass(FCanvas: TCanvas);
var
  helperPt : TPoint;
begin
  { initialize center point }
  initCenterPt;

  { draw center point of compass }
  drawSmallCircle(FCanvas, Pt, 3);

  { draw compass }
  drawCircle(FCanvas);
  drawTextOut(FCanvas);

  { draw needle }
  //drawTarget(Fcanvas);                             // draw all target assignment
  initTargetPt;
  initSeekerPt;
  if YakhontManager.isDistMoreThan19 then
  begin
    drawDistance(FCanvas, Pt, targetPt);
    drawSmallCircle(FCanvas, targetPt, 3);
    drawSmallCircle(FCanvas, seekerPt, 3);
    drawSector(FCanvas);
    drawEllipse(FCanvas);
  end
  else
    drawDistLessThan19(FCanvas);
end;

procedure TEventForm.drawDistLessThan19 (FCanvas : TCanvas);
begin
  drawSmallCircle(FCanvas, targetPt, 3);
//  drawSector(FCanvas);
//  drawEllipse(FCanvas);
end;

procedure TEventForm.drawSmallCircle(FCanvas: TCanvas; fPt : TPoint; r : Integer);
begin
  with FCanvas do
  begin
    Pen.color   := clBlack;
    Brush.Color := clBlack;
    Brush.Style := bsSolid;
    Ellipse(fPt.X - r, fPt.Y - r, fPt.X + r, fPt.Y + r); //lingkaran kecil
  end;
end;

procedure TEventForm.drawCircle(FCanvas: TCanvas); // Gambar lingkaran luar radar
begin
  with FCanvas do
  begin
    Pen.color   := clGreen;
    Brush.Style := bsClear;
    Ellipse(pt.X - radius, pt.Y - radius, pt.X + radius, pt.Y + radius);
  end;
end;

procedure TEventForm.drawTextOut(FCanvas: TCanvas); // Teks Koordinat Derajat
begin
  with FCanvas do
  begin
    Font.Color  := clBlack;
    Brush.Style := bsClear;
    Font.Size   := 10;

    wCross      := round(cos(DegToRad(30)) * radius);
    widthCross  := round(cos(DegToRad(60)) * radius);
    hCross      := round(sin(DegToRad(30)) * radius);
    heightCross := round(sin(DegToRad(60)) * radius);

    TextOut(Pt.X, pt.Y - radius, '0');
    TextOut(pt.X + widthCross, Pt.Y - heightCross, '30');
    TextOut(pt.X + wCross, Pt.Y - hCross, '60');
    TextOut(Pt.X + radius, pt.Y, '90');
    TextOut(pt.X + wCross, Pt.Y + hCross, '120');
    TextOut(pt.X + widthCross, Pt.Y + heightCross, '150');
    TextOut(Pt.X, pt.Y + radius, '180');
    TextOut(pt.X - widthCross, Pt.Y + heightCross, '210');
    TextOut(pt.X - wCross, Pt.Y + hCross, '240');
    TextOut(Pt.X - radius, pt.Y, '270');
    TextOut(pt.X - wCross, Pt.Y - hCross, '300');
    TextOut(pt.X - widthCross, Pt.Y - heightCross, '330');
  end;
end;
//
procedure TEventForm.drawDistance(FCanvas : TCanvas; center_Pt : TPoint; target_Pt : TPoint);
begin
  with FCanvas do
  begin
    Pen.color   := clBlack;
    Brush.Style := bsClear;
    MoveTo(center_Pt.X, center_Pt.Y);
    LineTo(target_Pt.X, target_Pt.Y);
  end;
end;

procedure TEventForm.drawSector(FCanvas : TCanvas);
var
  dis, brg : Double;
begin
//   with fmMainMM do
//   begin
//     r2 := round(sqrt(power((abs(miTarget_PosX - miSeeker_PosX)),2) + power((abs(miTarget_PosY - miSeeker_PosY)),2)));
//     r1 := r2 - Round(r2*0.25);
//   end;

   { default get bearing directly }
   //angle1  := Round(YakhontManager.bearing) - 30 {40};
   //angle2  := Round(YakhontManager.bearing) + 30 {80};

  if (YakhontManager.shipTarget1 <> 0) or (YakhontManager.shipTarget2 <> 0) then
  begin
    with fmMainMM do
    begin
      r2 := round(sqrt(power((abs(targetPt.X - seekerPt.X)),2) + power((abs(targetPt.Y - seekerPt.Y)),2)));
      r1 := r2 - Round(r2*0.25);

      angle1  := Round(YakhontManager.bearing) - angleOfSeeker {30} {40};
      angle2  := Round(YakhontManager.bearing) + angleOfSeeker{30} {80};
    end;
  end
  else
  begin
    with fmMainMM do
    begin
      r2 := round(sqrt(power((abs(miTarget_PosX - miSeeker_PosX)),2) + power((abs(miTarget_PosY - miSeeker_PosY)),2)));
      r1 := r2 - Round(r2*0.25);

      if frmManualInput.typeOfVariant = 1 then
      begin
        angle1  := Round(frmManualInput.Rec_TIVar1.BearingTarget) - angleOfSeeker {30};
        angle2  := Round(frmManualInput.Rec_TIVar1.BearingTarget) + angleOfSeeker {30};
      end
      else if frmManualInput.typeOfVariant = 2 then
      begin
        YakhontManager.PredictDistanceCourse(frmManualInput.Rec_TIVar2, dis, brg);

        angle1  := Round(brg) - angleOfSeeker {30};
        angle2  := Round(brg) + angleOfSeeker {30};
      end;
    end;
  end;

//   r1 := {50};
//   r2 := {80};

   startX1 := getX(angle1, r1, seekerPt.X);
   startY1 := getY(angle1, r1, seekerPt.Y);
   endX1   := getX(angle2, r1, seekerPt.X);
   endY1   := getY(angle2, r1, seekerPt.Y);

   startX2 := getX(angle1, r2, seekerPt.X);
   startY2 := getY(angle1, r2, seekerPt.Y);
   endX2   := getX(angle2, r2, seekerPt.X);
   endY2   := getY(angle2, r2, seekerPt.Y);

   FCanvas.ARC(round(seekerPt.X - r1), round(seekerPt.Y - r1),
              round(seekerPt.X + r1), round(seekerPt.Y + r1),
              round(endX1), round(endY1), round(startX1), round(startY1));

   FCanvas.ARC(round(seekerPt.X - r2), round(seekerPt.Y - r2),
              round(seekerPt.X + r2), round(seekerPt.Y + r2),
              round(endX2), round(endY2), round(startX2), round(startY2));

   FCanvas.MoveTo(round(startX1), round(startY1));
   FCanvas.LineTo(round(startX2), round(startY2));
   FCanvas.MoveTo(round(endX1), round(endY1));
   FCanvas.LineTo(round(endX2), round(endY2));

   FCanvas.MoveTo(round(seekerPt.X), round(seekerPt.Y));
   FCanvas.LineTo(round(startX1), round(startY1));
   FCanvas.MoveTo(round(seekerPt.X), round(seekerPt.Y));
   FCanvas.LineTo(round(endX1), round(endY1));
end;

function TEventForm.checkPoint(X: single; y: single; centX: Single; centY: single): Integer;
var
  tanRad, angle  : single;
begin
  if (abs(centX-X)) = 0 then
  begin
    tanRad := 90;
  end
  else
    tanRad := ArcTan(abs(centY-Y)/abs(centX-X));
  angle  := RadToDeg(tanRad);

  if (X > centX) AND (Y < centY) then            // kw 1,2,3,4
  begin
      angle := 0 + (90-angle);
  end
  else if (X < centX) AND (Y < centY) then
  begin
      angle := 270 + angle;
  end
  else if (X < centX) AND (Y > centY ) then
  begin
      angle := 180 + (90-angle);
  end
  else if (X > centX) AND (Y > centY) then
  begin
      angle := 90 + angle;
  end;
  Result := round(angle);
end;

//function TEventForm.getInRange(ShipPosisitionX, ShipPositionY, TargetPositionX,
//  TargetPositionY): Boolean;
//var
//  range : Double;
//begin
//  range := Sqrt(Power(ShipPosisitionX-TargetPositionX),2 + Power(ShipPositionY-TargetPositionY),2);
//
//end;

function TEventForm.getX(sdt: Integer; r: Integer; SectorCenterX: Single) : single;
begin
  Result := SectorCenterX + (cos(DegToRad(90-sdt))*r);
end;

function TEventForm.getY(sdt: Integer; r: Integer; SectorCenterY: Single) : single;
begin
  Result := SectorCenterY - (sin(DegToRad(90-sdt))*r);
end;

procedure TEventForm.drawEllipse(FCanvas : TCanvas);
var
  rec: TRect;
  tempRadian : Integer;
//const
//  rec: TRect = (left:100; top:100; right:300; bottom:200);
begin
//  rec.Left   := round(seekerPt.X - r2);
//  rec.Top    := round(seekerPt.Y - r2);
//  rec.Right  := round(seekerPt.X + r2);
//  rec.Bottom := round(seekerPt.Y + r2);

  rec.Left   := round(EndX2);
  rec.Top    := round(EndY2);
  rec.Right  := round(StartX1);
  rec.Bottom := round(StartY1);

  FCanvas.Brush.Style := bsClear;
  tempRadian := Round (frmManualInput.Rec_TIVar1.BearingTarget);
  while tempRadian >= 90 do
  begin
    tempRadian := tempRadian - 90;
  end;
  if tempRadian > 45 then tempRadian := -tempRadian;

  DrawRotatedEllipse(FCanvas, rec, tempRadian);
end;

procedure TEventForm.RotatePts(var pts: array of TPoint;
  origin: TPoint; radians: single);
var
  i,x,y: integer;
  cosAng, sinAng: single;
begin
  cosAng := cos(radians);
  sinAng := sin(radians);
  for i := low(pts) to high(pts) do
  begin
    x := pts[i].X - origin.X;
    y := pts[i].Y - origin.Y;
    pts[i].X := round((x * cosAng) - (y * sinAng)) + origin.X;
    pts[i].Y := round((x * sinAng) + (y * cosAng)) + origin.Y;
  end;
end;

procedure TEventForm.DrawRotatedEllipse(Fcanvas: TCanvas; rec: TRect; degrees: integer);
const offsett: single = 0.27614237;
var
  midx, midy, offx, offy: integer;
  pts: array [0..12] of TPoint;
  radians: single;
begin
  degrees := degrees mod 360;
  if degrees < 0 then inc(degrees, 360);

  radians := degrees *Pi / 180;

  //if there's no rotation, use the standard Windows function
  if radians = 0 then
    Fcanvas.Ellipse(rec)
  else
  begin
    with rec do
    begin
      dec(right); dec(bottom); //empirically this seems better
      midx := (right + left) div 2;
      midy := (bottom + top) div 2;
      offx := round((right - left) * offsett);
      offy := round((bottom - top) * offsett);
      pts[0]  := Point(left, midy);
      pts[1]  := Point(left, midy - offy);
      pts[2]  := Point(midx - offx, top);
      pts[3]  := Point(midx, top);
      pts[4]  := Point(midx + offx, top);
      pts[5]  := Point(right, midy - offy);
      pts[6]  := Point(right, midy);
      pts[7]  := Point(right, midy + offy);
      pts[8]  := Point(midx + offx, bottom);
      pts[9]  := Point(midx, bottom);
      pts[10] := Point(midx - offx, bottom);
      pts[11] := Point(left, midy + offy);
      pts[12] := pts[0];


      //rotate all points about the ellipse center ...
      RotatePts(pts, Point(midx,midy), radians);
    end;
    with Fcanvas do
    begin
      beginPath(Handle);
      Fcanvas.PolyBezier(pts);
      EndPath(Handle);
      if Fcanvas.Brush.Style = bsClear then
        StrokePath(Handle) else
        StrokeAndFillPath(Handle);
    end;
  end;
end;

procedure TEventForm.drawTarget(FCanvas : TCanvas);
var
  I  : Integer;
  pnt: TPoint;
begin
  for I := 0 to length_array - 1 do
  begin
    pnt.X := target_X[I];
    pnt.Y := target_Y[I];
    drawSmallCircle(FCanvas, pnt, 3);
  end;
end;

procedure TEventForm.OnLauncher1(Color : TColor);
begin
  fmMainMM.pnlPLP1.Color := Color;
end;

procedure TEventForm.OnLauncher2(Color : TColor);
begin
  fmMainMM.pnlPLP2.Color := Color;
end;

procedure TEventForm.OnLauncher3(Color : TColor);
begin
  fmMainMM.pnlPLP3.Color := Color;
end;

procedure TEventForm.OnLauncher4(Color : TColor);
begin
  fmMainMM.pnlPLP4.Color := Color;
end;

procedure TEventForm.setProperties;
begin
  with fmMainMM do
  begin
    if fmMain.MainMode = 1 then
      setProperties_MM;

    if fmMain.MainMode = 4 then
    begin
      if CTType = 1 then
         setProperties_CT1
      else if CTType = 2 then
         setProperties_CT2;
    end;
  end;
end;

procedure TEventForm.setProperties_MM;
begin
  with fmMainMM do
  begin
     pnlRegime.Caption := 'MM';
//     pnlRange.Caption  := 'In Range';
     pnlNow.Caption    := 'SACS Ready';
     pnlNext.Caption   := 'Selection of TI';

     lblD.Caption      := '0.00';
     lblDd.Caption     := '0.00';
     lblPx.Caption     := '0.000';

     lblB.Caption      := '0.00';
     lblDj.Caption     := '0.00';
     lblDsgh.Caption   := '0.00';
     lblPz.Caption     := '0.000';

     lblLatitude.Caption    := '000.00.00';
     lblLongitude.Caption   := '000.00.00';
     lblShipHeading.Caption := '0.00';
     lblShipSpeed.Caption   := '0.00';
     lblShipPitch.Caption   := '0.00';
     lblShipRoll.Caption    := '0.00';

//     pnlNoASM1.Caption := '1';
//     pnlNoASM2.Caption := '2';
//     pnlNoASM3.Caption := '3';
//     pnlNoASM4.Caption := '4';
     // ------------------------------------------------------------------- //

     

     //---------------------------------------------------------------------//
//     pnlT1.Caption    := FloatToStr(value_T1);
//     pnlTmax1.Caption := FloatToStr(value_TMax);
//     pnltmaxs1.Caption:= FloatToStr(value_TmaxS);
//     pnlT2.Caption    := FloatToStr(value_T2);
//     pnlTmax2.Caption := FloatToStr(value_TMax);
//     pnltmaxs2.Caption:= FloatToStr(value_TmaxS);
//     pnlT3.Caption    := FloatToStr(value_T3);
//     pnlTmax3.Caption := FloatToStr(value_TMax);
//     pnltmaxs3.Caption:= FloatToStr(value_TmaxS);
//     pnlT4.Caption    := FloatToStr(value_T4);
//     pnlTmax4.Caption := FloatToStr(value_TMax);
//     pnltmaxs4.Caption:= FloatToStr(value_TmaxS);

     pnlAvailable.Caption   := IntToStr(countAvailable);
     pnlOperational.Caption := IntToStr(countOprational);
     pnlDesignated.Caption  := IntToStr(countDesignated);
     pnlCancelled.Caption   := IntToStr(countCancelled);
     pnlLaunched.Caption    := IntToStr(countLaunched);
     pnlPassed.Caption      := IntToStr(countPassed);
  end;
end;

procedure TEventForm.setProperties_CT1;
begin
  with fmMainMM do
  begin
     pnlRegime.Caption := 'CT1';
     btnRTP.Font.Color  := clWhite;
     btnPTP.Font.Color  := clWhite;
     btnLock.Font.Color := clWhite;
     btnTD.Font.Color   := clWhite;

     pnlNoASM1.Color    := clMedGray;
     pnlNoASM2.Color    := clMedGray;
     pnlNoASM3.Color    := clMedGray;
     pnlNoASM4.Color    := clMedGray;

     btnAWR.Font.Color := clWhite;
     btnCWR.Font.Color := clWhite;
     btnER.Font.Color  := clWhite;

     pnlPLP1.Color := clMedGray;
     pnlPLP2.Color := clMedGray;
     pnlPLP3.Color := clMedGray;
     pnlPLP4.Color := clMedGray;
     // ------------------------------------------------------------------ //
     pnlPLP1.Font.Color := clWhite;
     pnlPLP2.Font.Color := clWhite;
     pnlPLP3.Font.Color := clWhite;
     pnlPLP4.Font.Color := clWhite;

     btnTI.Font.Color  := clWhite;
     btnSD.Font.Color  := clWhite;
     btnDES.Font.Color := clWhite;
     btnPLP.Font.Color := clWhite;
     btnDOC.Font.Color := clWhite;

    


//     pnlRange.Caption   := 'In Range';

  end;
end;

procedure TEventForm.setProperties_CT2;
begin
  with fmMainMM do
  begin
     pnlRegime.Caption  := 'CT2';
     btnRTP.Font.Color  := clWhite;
     btnPTP.Font.Color  := clWhite;
     btnLock.Font.Color := clWhite;
     btnTD.Font.Color   := clWhite;

     pnlNoASM1.Color    := clMedGray;
     pnlNoASM2.Color    := clMedGray;
     pnlNoASM3.Color    := clMedGray;
     pnlNoASM4.Color    := clMedGray;

     btnAWR.Font.Color := clWhite;
     btnCWR.Font.Color := clWhite;
     btnER.Font.Color  := clWhite;

     pnlPLP1.Color := clMedGray;
     pnlPLP2.Color := clMedGray;
     pnlPLP3.Color := clMedGray;
     pnlPLP4.Color := clMedGray;
     // ------------------------------------------------------------------ //
     pnlPLP1.Font.Color := clWhite;
     pnlPLP2.Font.Color := clWhite;
     pnlPLP3.Font.Color := clWhite;
     pnlPLP4.Font.Color := clWhite;

     btnTI.Font.Color  := clWhite;
     btnSD.Font.Color  := clWhite;
     btnDES.Font.Color := clWhite;
     btnPLP.Font.Color := clWhite;
     btnDOC.Font.Color := clWhite;


  end;
end;

procedure TEventForm.eventBtnTIOnClick;
begin
//  frmManualInput.pnlNumberOfTIVariant.BringToFront;

   with fmMainMM do
   begin
     isTI   := True;
     isSD   := false;
     isDES  := false;
     isPLP  := false;
     isDOC  := false;
     isExit := false;
   end;

  if fmMain.MainMode = 1 then
  begin
    frmSelectionTI.panel1.BringToFront;
    frmSelectionTI.ShowModal;
  end;

  if fmMain.MainMode = 4 then
  begin
    with fmMainMM do
    begin
      if CTType = 1 then
      begin
        frmSelectionTI.btnTI1.Font.Color := clWhite;
        frmSelectionTI.btnTI2.Font.Color := clWhite;
        frmSelectionTI.btnMI.Font.Color  := clBlack;

        frmSelectionTI.ShowModal;
      end
      else if CTType = 2 then
      begin
        frmManualInput.ShowModal;
      end;
    end;
  end;
end;

procedure TEventForm.eventBtnSDOnClick;
begin
  with fmMainMM do
  begin
    isTI   := false;
    isSD   := true;
    isDES  := false;
    isPLP  := false;
    isDOC  := false;
    isExit := false;

    fMap.Repaint;

    pnlNow.Caption    := 'SD';
    pnlNext.Caption   := 'Calculation of number of ASM';
    btnSD.Enabled     := false;
    btnDES.Font.Color := clBlack;

    CalcOfFiringData;
    SetResultCalc;

    if YakhontManager.isTargetInRange then
      pnlRange.Caption := 'In Range'
    else
      pnlRange.Caption := 'Not In Range';
  end;
end;

procedure TEventForm.eventBtnDESOnClick;
begin
  with fmMainMM do
  begin
    isTI   := false;
    isSD   := false;
    isDES  := true;
    isPLP  := false;
    isDOC  := false;
    isExit := false;

//    fMap.Repaint;

    pnlNow.Caption    := 'Calculation of number of ASM';
    pnlNext.Caption   := 'PLP';
  end;

  frmTargetDest.ShowModal;
end;

procedure TEventForm.eventBtnPLPOnClick;
begin
  with fmMainMM do
  begin
    { Load progress bar until 120 s }
    {jika semua cancel -> exit}
    if frmCirculationASM.checkCancelAll1 and frmCirculationASM.checkCancelAll2
    and frmCirculationASM.checkCancelAll3 and frmCirculationASM.checkCancelAll4 = True then
    begin
      isTI   := false;
      isSD   := false;
      isDES  := false;
      isPLP  := False;
      isDOC  := True;
      isExit := True;
      checkCancelAll := True;
    end
    else
    begin
      isTI   := false;
      isSD   := false;
      isDES  := false;
      isPLP  := true;
      isDOC  := false;
      isExit := false;

      fMap.Repaint;

      progBarPLP.Visible:=True;
      progBarPrePLP.visible:=false;

      pnlNow.Caption    := 'PLP in progress';
      pnlNext.Caption   := 'Salvo ready';
      lblTimeToPLP.Caption := 'PLP Time:';
      btnPLP.Enabled    := false;
      btnDOC.Font.Color := clBlack;
      progBarPrePLP.Visible:=False;
    end;



  end;
end;

procedure TEventForm.eventBtnDocClick;
begin
  frmDoc.ShowModal;
end;

procedure TEventForm.eventBtnExitClick;
begin
  with fmMainMM do
  begin
    isExit              := true;
    timerStart.Enabled  := false;
    tempPLP             := False;
    isPLP               := false;
    tempSecond          := 0;
    counterTemp         := 0;
    StopTime            := Now;
    progBarPrePLP.Position := 0;
    Close;
  end;
end;

procedure TEventForm.eventBtnHeatingClick;
begin
  with fmMainMM do
  begin
    progBarPLP.Enabled;
    CTType := 0;
    timerStart.Enabled := True;
    tempPLP := True;
    StartTime := now;
    lblTimeToPLP.Caption := 'Time of preparation to PLP:';
    Show;
    if fmmain.MainMode = 5 then
    begin
      frmHeating.pnlHeating.BringToFront;
      frmHeating.ShowModal;
    end;

    btnTI.Enabled := False;
    btnSD.Enabled := False;
    btnDES.Enabled:= False;
    btnPLP.Enabled:= False;
    btnDOC.Enabled:= False;
    btnEXIT.Enabled:= True;
  end;
end;

procedure TEventForm.eventBtnAWRClick;
begin
  frmAppointmentASM.lblASM.Caption := 'Activation ASM';
  frmAppointmentASM.ShowModal;
end;

procedure TEventForm.eventBtnCWRClick;
begin
//  with fmMainMM do
//  begin
//    if fCancel = C_AWR then
//      frmCirculationASM.lblASM.Caption := 'Activation ASM'
//    else if fCancel = C_CWR then
      frmCirculationASM.lblASM.Caption := 'Cancellation ASM';
//  end;

  frmCirculationASM.ShowModal;
end;

procedure TEventForm.eventBtnEROnClick;

begin
  frmEmergencyRelease.ShowModal;
end;

procedure TEventForm.eventRTP;
begin
  fmMainMM.pnlRTP.Caption := 'RTP';
end;

procedure TEventForm.eventPTP;
begin
  fmMainMM.pnlRTP.Caption := 'PTP';
end;

procedure TEventForm.eventBtnLockClick;
begin
  frmLock.ShowModal;
end;

procedure TEventForm.eventBtnMMClick;
begin
with fmMainMM do
  begin
     progBarPLP.Enabled;
     CTType := 0;
     timerStart.Enabled := True;
     tempPLP := True;
     StartTime := now;
     lblTimeToPLP.Caption := 'Time of preparation to PLP:';
     Show;
  end;
end;

procedure TEventForm.eventBtnTDClick;
begin
  frmTest.ShowModal;
end;

procedure TEventForm.CalcOfFiringData;
begin

end;

procedure TEventForm.SetResultCalc;
begin

end;

procedure TEventForm.showCRData;
begin
  frmCRData.ShowModal;
end;

end.

