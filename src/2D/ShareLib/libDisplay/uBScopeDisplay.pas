unit uBScopeDisplay;

interface

uses
  Classes, Windows, Controls, Graphics, uBaseGraphicProc, uBaseGraphicObjects,
  uLabelDisplay, uEmulatorConstan, uEmulatorProc, uBaseConstan, uBaseFunction;

type

//==============================================================================
  TBScopeTool = (toolNone, toolSelectObject, toolSetLabel);

  TBScopeItem = class(TBMPObject)
  public
    Range     : single;
    Bearing   : single;
    Speed     : single;
    UID : string;
    Intensity : TColor;   //trisno: color intensity of object on screen
//    ixDir     : integer;
//    iyRange   : integer;
    Symbol : TCharSymbol;
    Info   : TInfoLabel;
    Status : sonarobjectstatus;

    constructor Create;
    destructor Destroy; override;

    procedure Draw(aCnv: TCanvas); override;
    procedure DrawNoBlur(aCnv: TCanvas);
    procedure DrawAudioNoise(aCnv: TCanvas);
  end;

//==============================================================================
//  TBScopeSweeper =
//==============================================================================
  TBScopeDisplay = class(TGraphicControl)
  private
    FDetectionRange: single;  // yard , 1 nm = 2000   yard
    FDetDegree  : single;      // 0..360
    FHScale     : single;
    FVScale     : single;
    FDirectionRange: single;
    FSonarMode : sonarmode;
    isShowSymbol : boolean;
    FHeading : double;

    FAudioLock : boolean;
    //currentSequenceList : TSequenceList;

    procedure SetDetectionRange(const Value: single);
    procedure SetDirectionRange(const Value: single);

    function RangeToPixel(const aR: single): integer;
    function PixelToRange(const aR: integer): single;

    function BearingToPixel(const aR: single): integer;
    function PixelToDirection(const aR: integer): single;

    function GetSonarMode: sonarmode;
    procedure SetSonarMode (const Value: sonarmode);

    function isSymbolShown: boolean;
    procedure ShowSymbol (const Value: boolean);

    function GetHeading: double;                    // in degree
    procedure SetHeading(const Value: double);
  protected
    FBmp    : TBitmap;
    FNoiseBmp : TBitmap;

    FItems  : TList;

    FSweepPosY : integer;
    FClickedPos : TPoint;

    FSweepPosYList : array [0 .. C_PulseNumber-1] of TBearingPixelPosList;

    procedure ConvertionItems;
    function FindByUID(const auid: string): integer;
    function FindByScreenCoord(const x, y: integer): integer;
    function FindByScreenXRange(const left: integer;const right: integer): integer;

    procedure Paint; override;

    procedure ActionMouseClick(const pt: TPoint);

    procedure HandleOnMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure HandleOnMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  public
    PulseDistance:Double;
    lastPulse : double;

    PulseDistanceList : array [0 .. C_PulseNumber-1] of TRangeList;
    lastPulseList : array [0 ..C_PulseNumber-1] of TRangeList;

    SlotBearingList : array [0 .. C_PulseNumber-1] of TSlotBearingList;

    CurrentTool     : TBScopeTool;
    CurrentLabel    : string;
    SelectedObject  : TBScopeItem;
    LabeledObjects  : array [0 .. C_Number_Target_Label-1] of TBScopeItem;
    LabeledObjectsLastRange : array [0 .. C_Number_Target_Label-1] of double;
    LabeledObjectsLastTime : array [0 .. C_Number_Target_Label-1] of double;

    MarkerX : integer;
    MarkerY : integer;

    FireSelectObjectEvent : TSelectObjectProc;
    FireSetAudioMarker : TAudioMoveProc;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure RunTimebase(const dt: Double; const curSlotBearingList: array of TSlotBearingList);
    procedure RunTimebaseFromList(const dtList:array of TRangeList; const curSlotBearingList: array of TSlotBearingList);

    procedure ResetDisplay;
    procedure HideItems;
    procedure HideItem(const UniqueID: string);
    procedure ClearItems;
    procedure AddItem(item: TBScopeItem); overload;
    procedure AddItem(const Range: double;const Bearing: double;
                      const Speed: double;const UniqueID: string;
                      const dt: double); overload;
    procedure DelItems(item: TBScopeItem);
    procedure LabelSelectedObject(const s:string);
    procedure LabelSelectedBearing(const s:string);
    procedure CreateNoise;
    procedure UpdateLabeledObject;
    function SetAudioLock(const isLocked: boolean):double;
  published
    property DetectionRange: single read FDetectionRange write SetDetectionRange;
    property DirectionRange: single read FDirectionRange write SetDirectionRange;

    property SonarMode: sonarmode read GetSonarMode write SetSonarMode;

    property SymbolShown: boolean read isSymbolShown write ShowSymbol;

    property Heading : double read GetHeading write SetHeading; //haluan kapal
  end;

//==============================================================================
{ TBScopeAudioMarkerDisplay }
  TBScopeAudioMarkerDisplay = class(TGraphicControl)
  private
    FAudioMarkerX : integer;
    FStartUp : boolean;

    procedure SetAudioMarkerX(const Value: integer);
    function GetAudioMarkerX: integer;
  protected
    procedure Paint; override;
  public
    FScopeLeft : integer;
    FScopeTop : integer;
    FScopeWidth : integer;

    constructor Create(AOwner: TComponent); override;
  published
    property AudioMarkerX:integer read GetAudioMarkerX write SetAudioMarkerX;
  end;
implementation
uses
  Math, SysUtils, Dialogs;


//==============================================================================
{ TBScopeItem }

constructor TBScopeItem.Create;
begin
  inherited;

  Left   := 0;
  Top    := 0;
  Width  := 10;
  Height := 4;
  Intensity := C_DisplayColor;

  Symbol := TCharSymbol.Create;
  Symbol.FontName := 'Sonar';
  Symbol.Visible := false;
  Info   := TInfoLabel.Create;
  Info.Color := clYellow;
  Info.Size := 14;

  Status := UNMARKED;
end;

destructor TBScopeItem.Destroy;
begin
 Info.Free;
 Symbol.Free;

end;

procedure TBScopeItem.Draw(aCnv: TCanvas);
begin

  with aCnv do begin
    Brush.color := Intensity;   //trisno: intensity as color
    FillRect(FBoundRect);
    Font.Color := clWhite;
    SetBkMode(aCnv.Handle, TRANSPARENT);

    //TextOut(FBoundRect.Right + 4, FBoundRect.Top, Format('Dir %2.2f',[Direction]) );
    //TextOut(FBoundRect.Right + 4, FBoundRect.Top + 12, Format('range %2.2f',[range ]) );

//    FillRect(Rect(0, 0, Width, Height));
  end;
 {  with FBmp.Canvas do begin
    Brush.color := C_DisplayColor;
    FillRect(Rect(0, 0, fbmp.Width,fbmp.Height));
  end;
  BitBlt(aCnv.handle, Left, Top, Width, Height,
         fBmp.Canvas.Handle,0,0, SRCCOPY	);
}
end;

procedure TBScopeItem.DrawAudioNoise(aCnv: TCanvas);
var
  leftAddition : integer;
  rightAddition : integer;
begin
  with aCnv do begin
    Pen.Color := Intensity;
    leftAddition := RandomRange(-10,10);
    rightAddition := RandomRange(-10,10);
    MoveTo(FBoundRect.Left+leftAddition,FBoundRect.Top);
    LineTo(FBoundRect.Left+rightAddition,FBoundRect.Top);
  end;
end;

procedure TBScopeItem.DrawNoBlur(aCnv: TCanvas);
begin
  with aCnv do begin
    Symbol.Center.x := CenterX;
    Symbol.Center.y := CenterY;

    Info.Center := Symbol.Center;

    Symbol.Draw(aCnv);
    Info.Draw(aCnv);
  end;

end;

//==============================================================================
{ TBScopeDisplay }

constructor TBScopeDisplay.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;

  FBmp := TBitmap.Create;
  FBmp.PixelFormat := pf24bit;
  FBmp.Width  := Width;
  FBmp.Height := Height;

  BitmapFillBlack(FBmp);

  FNoiseBmp := TBitmap.Create;
  FNoiseBmp.PixelFormat := pf24bit;
  FNoiseBmp.Width  := Width;
  FNoiseBmp.Height := Height;
  FNoiseBmp.TransparentColor := 0;
  
  BitmapFillBlack(FNoiseBmp);
//  BitmapNoise(FNoiseBmp,C_SonarNoiseLevel,C_DisplayColor);

  FItems  := TList.Create;

  OnMouseDown := HandleOnMouseDown;
  OnMouseUp   := HandleOnMouseUp;

  CurrentTool := toolSelectObject;

  FSonarMode := OMNI;
  isShowSymbol := false;
  for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
    SlotBearingList[0,i] := C_SlotBearings[i];
    SlotBearingList[1,i] := C_SlotBearings[i];
  end;
  FAudioLock := false;
end;

destructor TBScopeDisplay.Destroy;
begin
  ClearItems;

  DestroyBitmap(FBmp);
  DestroyBitmap(FNoiseBmp);
  inherited;
end;

procedure TBScopeDisplay.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  
  FBmp.Width  := AWidth;
  FBmp.Height := AHeight;
  FNoiseBmp.Width  := AWidth;
  FNoiseBmp.Height := AHeight;
  if (AWidth > 0) and (AHeight > 0) then begin
    BitmapFillBlack(FBmp);
    //BitmapFillBlack(FNoiseBmp);
    //BitmapNoise(FNoiseBmp,C_SonarNoiseLevel,C_DisplayColor);
    //BitmapBlur(FNoiseBMP);
    CreateNoise;
    SetDirectionRange(360);  // 1 pixel = 1 derajat

    SetDetectionRange(DetectionRange); // 1 pixel = 2 yard;        ---->2000 dari mana??
    SetHeading(FHeading);
  end;
  Repaint;

end;

//------------------------------------------------------------------------------

procedure TBScopeDisplay.ClearItems;
var i: integer;
    obj : TObject;
begin
  for i := FItems.Count-1 downto 0 do begin
    obj := FItems[i];
    obj.Free;
  end;
  FItems.Clear;
end;

procedure TBScopeDisplay.AddItem(item: TBScopeItem);
var search : integer;
    obj : TBScopeItem;
begin
  search :=   FindByUID(item.UID);
  if search < 0 then
    FItems.Add(item)
  else begin
    obj := FItems[search];
    obj.Range := item.Range;
    obj.Bearing := item.Bearing;
    obj.Speed := item.Speed;
    obj.Intensity := item.Intensity;
    item.Free;
  end;


end;

procedure TBScopeDisplay.DelItems(item: TBScopeItem);
begin
  FItems.Remove(item);
end;

//------------------------------------------------------------------------------

function TBScopeDisplay.BearingToPixel(const aR: single): integer;
var vr : single;
begin
  vR := aR + 180;
  if vR > 360 then vR :=  vR - 360;
  result := Round(vR / FHScale);
end;

function TBScopeDisplay.PixelToDirection(const aR: integer): single;
begin
  result := (aR * FHScale);
  result := (result - 180);
  if Result < 0 then result := result + 360;
end;

function TBScopeDisplay.PixelToRange(const aR: integer): single;
begin
  result := (FBmp.Height - aR * FVScale);
end;

function TBScopeDisplay.RangeToPixel(const aR: single): integer;
begin                // vScale = range / pixel
  if FVScale > 0 then
    result := FBmp.Height - Round(aR / FVScale)
  else
    result := 0;
end;

procedure TBScopeDisplay.SetDetectionRange(const Value: single);
begin
  FDetectionRange := Value;
  if FBmp.Height > 0 then
    FVScale := FDetectionRange / FBmp.Height
  else
    FVScale := 0;
  ResetDisplay;

end;

procedure TBScopeDisplay.SetDirectionRange(const Value: single);
begin
  FDirectionRange := Value;
  if FBmp.Width > 0 then
    FHScale := FDirectionRange / FBmp.Width;
  ResetDisplay;
end;

procedure TBScopeDisplay.ConvertionItems;
var i   : integer;
    obj : TBScopeItem;
begin
  for i := FItems.Count-1 downto 0 do begin
    obj := FItems[i];

    obj.CenterX := BearingToPixel(obj.Bearing);
    obj.CenterY := RangeToPixel(obj.Range);
  end;
end;

function TBScopeDisplay.FindByUID(const auid: string): integer;
var i   : integer;
    found : boolean;
    obj : TBScopeItem;
begin
  found := false;
  i := 0;
  While not found and (i < FItems.Count) do begin
    obj := FItems[i];

    found := (obj.UID) = (auid);
    inc(i);
  end;
  if found then
    result := i-1
  else
    result := -1;
end;

function TBScopeDisplay.FindByScreenCoord(const x, y: integer): integer;
var i   : integer;
    found : boolean;
    obj : TBScopeItem;
    pt : TPoint;

begin
  pt := Point(x,y);
  found := false;
  i := 0;
  while not found and (i < FItems.Count) do begin
    obj := FItems[i];
    inc(i);
    found := PtInRect(obj.FBoundRect, pt)
  end;

  if found then
    result := i-1
  else
    result := -1;

end;


procedure TBScopeDisplay.Paint;
var i,j   : integer;
    obj : TBScopeItem;
    prevSweepPosY : integer;
    bearingSize : integer;
    currentBearingIndex, currentBearingPixel : integer;
begin
  bearingSize := FBmp.Width div C_Sonar_Bearing_Slot_Number;

  //BitmapSubstract(FBMP,1);

{
  //clear current line
  if (SonarMode = OMNI) and (FSweepPosY <> 0) then begin
    prevSweepPosY := RangeToPixel(lastPulse);
    BitmapFillBlack(FBmp,0,FSweepPosY,FBmp.Width,prevSweepPosY-FSweepPosY);
  end
  else if (SonarMode = TRDT) or (SonarMode = LPST) or (SonarMode = LPGC) then begin
    for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      for j := 0 to 1 do begin
        currentBearingPixel := DirectionToPixel(SlotBearingList[j,i]);
        if FSweepPosYList[j,i] <> 0 then begin
          prevSweepPosY := RangeToPixel(lastPulseList[j,i]);
          if (currentBearingPixel+bearingSize) > FBmp.Width then begin
            if currentBearingPixel <= FBmp.Width then begin
              //draw right slice
              BitmapFillBlack(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                              FBmp.Width-currentBearingPixel,
                              prevSweepPosY-FSweepPosYList[j,i]);
            end;
            currentBearingPixel := currentBearingPixel - FBmp.Width;
          end;
          //draw all
          BitmapFillBlack(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                          bearingSize,
                          prevSweepPosY-FSweepPosYList[j,i]);
        end;
      end;
    end;
  end;
}
  //draw objects

  //BitmapBlur(FBMP);


  //draw noises
  if ((SonarMode = OMNI) or (SonarMode = MCC)) and (FSweepPosY <> 0) then begin
    prevSweepPosY := RangeToPixel(lastPulse);
    BitmapFillBlack(FBmp,0,FSweepPosY,FBmp.Width,prevSweepPosY-FSweepPosY);
    BitmapBlend(FBmp,0,FSweepPosY,FNoiseBmp,0,FSweepPosY,
                FNoiseBmp.Width,prevSweepPosY-FSweepPosY,C_DisplayColor);
  end
  else if (SonarMode = TRDT) or (SonarMode = LPST) or (SonarMode = LPGC) then begin
    for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      for j := 0 to 1 do begin
        currentBearingPixel := BearingToPixel(SlotBearingList[j,i]);
        if FSweepPosYList[j,i] <> 0 then begin
          prevSweepPosY := RangeToPixel(lastPulseList[j,i]);
          if (currentBearingPixel+bearingSize) > FBmp.Width then begin
            if currentBearingPixel <= FBmp.Width then begin
              //draw right slice
              BitmapFillBlack(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                              FBmp.Width-currentBearingPixel,
                              prevSweepPosY-FSweepPosYList[j,i]);
              BitmapBlend(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                          FNoiseBmp,currentBearingPixel,FSweepPosYList[j,i],
                          FBmp.Width-currentBearingPixel,
                          prevSweepPosY-FSweepPosYList[j,i],C_DisplayColor);
            end;
            currentBearingPixel := currentBearingPixel - FBmp.Width;
          end;
          //draw all
          BitmapFillBlack(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                          bearingSize,
                          prevSweepPosY-FSweepPosYList[j,i]);
          BitmapBlend(FBmp,currentBearingPixel,FSweepPosYList[j,i],
                      FNoiseBmp,currentBearingPixel,FSweepPosYList[j,i],
                      bearingSize,
                      prevSweepPosY-FSweepPosYList[j,i],C_DisplayColor);
        end;
      end;
    end;
  end;

  //draw object
  if SonarMode = LISTEN then begin
    prevSweepPosY := RangeToPixel(lastPulse);
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];
      obj.CenterX := BearingToPixel(obj.Bearing);
      obj.CenterY := FSweepPosYList[0,0];
      if (prevSweepPosY <> FSweepPosYList[0,0]) then
        obj.DrawAudioNoise(FBmp.Canvas);
      lastPulse := PulseDistanceList[0,0];
    end;
  end
  else if SonarMode = OMNI then begin
    //prevSweepPosY := RangeToPixel(lastPulse);
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];
      obj.CenterX := BearingToPixel(obj.Bearing);
      obj.CenterY := RangeToPixel(obj.Range);
      obj.Draw(FBmp.Canvas);
    end;
  end
  else if (SonarMode = TRDT) or (SonarMode = LPST) or (SonarMode = LPGC) then begin
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];
      obj.CenterX := BearingToPixel(obj.Bearing);
      obj.CenterY := RangeToPixel(obj.Range);
      obj.Draw(FBmp.Canvas);
      //FBmp.Canvas.TextOut( obj.CenterX,obj.CenterY, obj.UID );
    end;
  end;

  //BitmapBlend(FBmp,0,FSweepPosY,FNoiseBmp,0,FSweepPosY,
  //            FNoiseBmp.Width,FNoiseBmp.Height,C_DisplayColor);
  //BitmapFillBlack(FBmp);
  BitBlt(Canvas.handle, 0, 0, FBmp.Width, FBmp.Height,
         FBmp.Canvas.Handle, 0, 0, SRCCOPY	);
  //BitBlt(Canvas.handle, 0, FSweepPosY, FNoiseBmp.Width, FNoiseBmp.Height,
  //       FNoiseBmp.Canvas.Handle, 0, FSweepPosY, SRCPAINT	);

  //draw scan line
  if SonarMode = LISTEN then begin
    {with Canvas do begin
      Brush.Color := C_DisplayColor;
      Brush.Style := bsSolid;
      currentBearingPixel := BearingToPixel(SlotBearingList[0,0]);
      FillRect(Rect(currentBearingPixel-3, FBmp.Height-18, currentBearingPixel+3, FBmp.Height));
    end;}
  end
  else if SonarMode = OMNI then begin
    with Canvas do begin
      Pen.Color := C_DisplayColor;
      Pen.Width := 1;
      Pen.Mode := pmCopy;
      currentBearingPixel := BearingToPixel(SlotBearingList[0,0]);
      //MoveTo(0,  FSweepPosY);
      //FBmp.Width, FSweepPosY);
      if (currentBearingPixel+bearingSize) > FBmp.Width then begin
        if currentBearingPixel <= FBmp.Width then begin
          MoveTo(currentBearingPixel,  FSweepPosY);
          LineTo(FBmp.Width, FSweepPosY);
        end;
        currentBearingPixel := currentBearingPixel - FBmp.Width;
      end;

      MoveTo(currentBearingPixel,  FSweepPosY);
      LineTo(currentBearingPixel+bearingSize, FSweepPosY);
    end;
  end
  else if (SonarMode = TRDT) or (SonarMode = LPST) or (SonarMode = LPGC) then begin
    with Canvas do begin
      Pen.Color := C_DisplayColor;
      Pen.Width := 1;
      Pen.Mode := pmCopy;
      //for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      i:=0;
      for j := 0 to 1 do begin
        currentBearingPixel := BearingToPixel(SlotBearingList[j,i]);
        if FSweepPosYList[j,i] <> 0 then begin
          if (currentBearingPixel+bearingSize) > FBmp.Width then begin
            if currentBearingPixel <= FBmp.Width then begin
              MoveTo(currentBearingPixel,  FSweepPosYList[j,i]);
              LineTo(FBmp.Width, FSweepPosYList[j,i]);
            end;
            currentBearingPixel := currentBearingPixel - FBmp.Width;
          end;

          MoveTo(currentBearingPixel,  FSweepPosYList[j,i]);
          LineTo(currentBearingPixel+bearingSize, FSweepPosYList[j,i]);
          //if i = 0 then begin
          //  MoveTo(0,  FSweepPosYList[j,i]);
          //  LineTo(FBmp.Width, FSweepPosYList[j,i]);
          //end;
        end;
      end;
      //end;
    end;
  end
  else if (SonarMode = MCC) then begin
    with Canvas do begin
      Pen.Color := C_DisplayColor;
      Pen.Width := 1;
      Pen.Mode := pmCopy;
      currentBearingPixel := BearingToPixel(354);
      MoveTo(currentBearingPixel,  FSweepPosY);
      LineTo(currentBearingPixel+bearingSize, FSweepPosY);
    end;
  end;

  // draw heading line
  with Canvas do begin
    Pen.Color := C_DisplayColor;
    Pen.Width := 1;
    Pen.Mode := pmCopy;
    currentBearingPixel := BearingToPixel(Heading);
    MoveTo(currentBearingPixel,0);
    LineTo(currentBearingPixel,FBmp.Height);
  end;

  //draw marker
  with Canvas do begin
    Pen.Color := clYellow;//C_DisplayColor;
    Pen.Width := 1;
    Pen.Mode := pmCopy;
    Brush.Color := clYellow;//C_DisplayColor;

    MoveTo(MarkerX,MarkerY-4); //draw cross
    LineTo(MarkerX,MarkerY+4);
    MoveTo(MarkerX-4,MarkerY);
    LineTo(MarkerX+4,MarkerY);

    if SonarMode = LISTEN then begin
      for i := 0 to C_Number_Target_Label-1 do begin
        if LabeledObjects[i] <> nil then begin
          if LabeledObjects[i].Status = GATED then begin
            Brush.Style := bsClear;
            Rectangle(LabeledObjects[i].CenterX-10,LabeledObjects[i].CenterY-12,
                      LabeledObjects[i].CenterX+10,LabeledObjects[i].CenterY+8);
            TextOut(LabeledObjects[i].CenterX+12, LabeledObjects[i].CenterY-8 ,
                    LabeledObjects[i].Info.Line1);
            Brush.Style := bsSolid;
          end;
        end;
      end;
    end
    else begin
      for i := FItems.Count-1 downto 0 do begin
        obj := FItems[i];
        {
        if obj.Status = MARKED then begin
          MoveTo(obj.CenterX,obj.CenterY-6); //draw cross
          LineTo(obj.CenterX,obj.CenterY+6);
          MoveTo(obj.CenterX-6,obj.CenterY);
          LineTo(obj.CenterX+6,obj.CenterY);
        end
        else }if obj.Status = GATED then begin
          Brush.Style := bsClear;
          Rectangle(obj.CenterX-10,obj.CenterY-10,obj.CenterX+10,obj.CenterY+10);
          Brush.Style := bsSolid;
        end
        else if obj.Status = AUTOTRACKED then begin
          Brush.Style := bsClear;
          pen.Style := psDot;
          Rectangle(obj.CenterX-10,obj.CenterY-10,obj.CenterX+10,obj.CenterY+10);
          pen.Style := psSolid;
          Brush.Style := bsSolid;
        end
      end;
    end;
  end;
//  StretchBlt(Canvas.Handle, 0,0, Width, Height, FBmp.Canvas.Handle,
//   0,0,FBmp.Width, FBmp.Height, SRCcOPY);
  //if isShowSymbol then begin
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];

      //obj.Info.Line1 := Format('%d, %d', [obj.FBoundRect.Left, obj.FBoundRect.Top ]);
      //obj.Info.Line2 := Format('%2.2f',[obj.Direction]);
      //obj.Info.Line3 := Format('%2.2f',[obj.Range]);
      obj.DrawNoBlur(Canvas);
    end;
  //end;
//Canvas.TextOut( 200,230, Format('%2.2f',[lastPulse]) );

//  Canvas.TextOut( 200,200, IntToStr(FItems.Count) );
//  Canvas.TextOut( 200,230, Format('%2.2f',[lastPulse]) );
//  Canvas.TextOut( 200,260, Format('%2.2f',[PulseDistance] ));
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TBScopeDisplay.RunTimebase(const dt: double; const curSlotBearingList: array of TSlotBearingList);
var
  i,j : integer;
begin
  lastPulse := PulseDistance;
  PulseDistance := dt;
  FSweepPosY := RangeToPixel(dt);
  for j := 0 to C_PulseNumber-1 do begin
    for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      SlotBearingList[j,i] := curSlotBearingList[j,i];
    end;
  end;
  FireSetAudioMarker(BearingToPixel(SlotBearingList[0,0]+(C_BearingShift/2)));
end;

procedure TBScopeDisplay.RunTimebaseFromList(const dtList:array of TRangeList;
  const curSlotBearingList: array of TSlotBearingList);
var
  i,j : integer;
  ActiveSlot : integer;
begin
  ActiveSlot := 0;
  for j := 0 to C_PulseNumber-1 do begin
    for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      lastPulseList[j,i] := PulseDistanceList[j,i];
      PulseDistanceList[j,i] := dtList[j,i];
      if dtList[j,i] <> 0 then begin
        FSweepPosYList[j,i] := RangeToPixel(dtList[j,i]);
        if i = 0 then ActiveSlot := j;
      end
      else begin
        FSweepPosYList[j,i] := 0;
      end;
      SlotBearingList[j,i] := curSlotBearingList[j,i];
    end;
  end;
  FireSetAudioMarker(BearingToPixel(curSlotBearingList[ActiveSlot,0]+(C_BearingShift/2)));
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TBScopeDisplay.ActionMouseClick(const pt: TPoint);
var
  i,j: integer;
  CurObject : TBScopeItem;
begin
  SelectedObject  := nil;
  i := FindByScreenCoord(pt.X, pt.Y);

  if i <> -1 then begin
    //clear marked object
    for j := FItems.Count-1 downto 0 do begin
      CurObject := FItems[j];
      if CurObject.Status = MARKED then CurObject.Status := UNMARKED;
    end;
    //mark selected object
    SelectedObject := FItems[i];
    if CurObject.Status = UNMARKED then  SelectedObject.Status := MARKED;
    //FItems[i] := SelectedObject;
    if Assigned(FireSelectObjectEvent) then FireSelectObjectEvent(SelectedObject.UID);
  end;
  MarkerX := pt.X;
  MarkerY := pt.Y;
end;

procedure TBScopeDisplay.HandleOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FClickedPos := Point(X, Y);
end;

procedure TBScopeDisplay.HandleOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var pt : TPoint;
begin
  pt := Point(X, Y);
  if PtInRect(Rect(pt.X - 10, pt.Y-10, pt.X + 10, pt.Y + 10), FClickedPos) then begin
    ActionMouseClick(pt);
  end;

end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TBScopeDisplay.GetSonarMode: sonarmode;
begin
  Result := FSonarMode;
end;

procedure TBScopeDisplay.SetSonarMode (const Value: sonarmode);
var
  i : integer;
begin
  FSonarMode := Value;
  for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
    lastPulseList[0,i] := 0;
    lastPulseList[1,i] := 0;
    PulseDistanceList[0,i] := 0;
    PulseDistanceList[1,i] := 0;
    FSweepPosYList[0,i] := 0;
    FSweepPosYList[1,i] := 0;
  end;
  ResetDisplay;
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TBScopeDisplay.isSymbolShown: boolean;
begin
  Result := isShowSymbol;
end;

procedure TBScopeDisplay.ShowSymbol (const Value: boolean);
begin
  isShowSymbol := Value;
end;

//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TBScopeDisplay.GetHeading: double;
begin
  Result := FHeading;
end;

procedure TBScopeDisplay.SetHeading(const Value: double);
begin
  FHeading := Value;
end;

//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TBScopeDisplay.LabelSelectedObject(const s:string);
begin
  if (SelectedObject <> nil) then begin
    SelectedObject.Info.Line1 := s;
    SelectedObject.Status := LABELED;
    if s = '1' then
      LabeledObjects[0] := SelectedObject;
    if s = '2' then
      LabeledObjects[1] := SelectedObject;
    if s = '3' then
      LabeledObjects[2] := SelectedObject;
    if s = '4' then
      LabeledObjects[3] := SelectedObject;

  end;
end;

procedure TBScopeDisplay.ResetDisplay;
var
  i,j : integer;
  obj : TBScopeItem;
begin
  BitmapFillBlack(FBmp);
  //if FItems <> nil then
  //  FItems.Clear;
  for i := FItems.Count-1 downto 0 do begin
    obj := FItems[i];
    obj.Intensity := 0;
    //obj.Status := UNMARKED;
    //obj.Info.Line1 := '';
    //obj.Info.Line2 := '';
    //obj.Info.Line3 := '';
  end;
  {
  for i := 0 to C_Number_Target_Label-1 do begin
    LabeledObjects[i] := nil;
    LabeledObjectsLastRange[i] := 0;
    LabeledObjectsLastTime[i] := 0;
  end;
  FAudioLock := false;
  MarkerX := 0;
  MarkerY := 0;
  }
  FSweepPosY := 0;
  lastPulse := 0;
  PulseDistance := 0;

  for j := 0 to C_PulseNumber-1 do begin
    for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      FSweepPosYList[j,i] := 0;
    end;
  end;
end;

procedure TBScopeDisplay.CreateNoise;
var
  noised : integer;
  y : integer;
begin
  BitmapFillBlack(FNoiseBmp);
  BitmapNoise(FNoiseBmp,C_SonarNoiseLevel,C_DisplayColor);
  BitmapBlur(FNoiseBmp);
  for y := 0 to FNoiseBmp.Height-1 do begin
    noised := Random(10);
    if noised <= 3 then begin
      BitmapNoiseLine(FNoiseBmp,y,C_SonarNoiseLevel,C_DisplayColor);
    end;
  end;
end;

procedure TBScopeDisplay.AddItem(const Range, Bearing, Speed: double;
  const UniqueID: string; const dt: double);
var search : integer;
    obj : TBScopeItem;
    i : integer;
    labeled : boolean;
    deltayd : double;
begin
  search :=   FindByUID(UniqueID);
  labeled := false;
  if search < 0 then begin
    obj := TBScopeItem.Create;
    obj.Range := Range;
    obj.Bearing := Bearing;
    obj.Speed := Speed;
    obj.UID := UniqueID;
    FItems.Add(obj)
  end
  else begin
    obj := FItems[search];
    obj.Range := Range;
    obj.Bearing := Bearing;
    for i := 0 to C_Number_Target_Label-1 do begin
      if LabeledObjects[i] <> nil then begin
        if UniqueID = LabeledObjects[i].UID then begin
          labeled := true;
          //calc relative speed
          if LabeledObjectsLastRange[i] <> 0 then begin
            LabeledObjectsLastTime[i] := LabeledObjectsLastTime[i] + dt;
            if (LabeledObjectsLastRange[i] <> Range) and
              (not IsAlmostZero (LabeledObjectsLastTime[i])) then begin
              deltayd := range - LabeledObjectsLastRange[i];
              obj.Speed := -1.0*(deltayd*C_Yard_To_NauticalMiles)*C_HourToMilliSecond/
                           LabeledObjectsLastTime[i];
              LabeledObjectsLastRange[i] := Range;
              LabeledObjectsLastTime[i] := 0;
            end
          end
          else begin
            LabeledObjectsLastRange[i] := Range;
            LabeledObjectsLastTime[i] := dt;
          end;
          //else
          //  obj.Speed := 0;
          exit;
        end;
      end;
    end;
    if not labeled then obj.Speed := Speed;
    obj.Intensity := C_DisplayColor;
  end


end;

procedure TBScopeDisplay.HideItems;
var
  i : integer;
  obj : TBScopeItem;
begin
  for i := FItems.Count-1 downto 0 do begin
    obj := FItems[i];
    obj.Intensity := 0;
    if obj.Range >= FDetectionRange then begin
      obj.Status := UNMARKED;
      obj.Info.Line1 := '';
      obj.Info.Line2 := '';
      obj.Info.Line3 := '';
    end;
  end;
end;

procedure TBScopeDisplay.HideItem(const UniqueID: string);
var search : integer;
    obj : TBScopeItem;
begin
  search :=   FindByUID(UniqueID);
  if search >= 0 then begin
    obj := FItems[search];
    obj.Intensity := 0;
    obj.Status := UNMARKED;
    obj.Info.Line1 := '';
    obj.Info.Line2 := '';
    obj.Info.Line3 := '';
  end;
end;

procedure TBScopeDisplay.LabelSelectedBearing(const s:string);
var
  i : integer;
  BearingObject : TBScopeItem;
begin
  i := FindByScreenXRange(MarkerX-10, MarkerX+10);

  if i <> -1 then begin
    SelectedObject := FItems[i];
    if Assigned(FireSelectObjectEvent) then FireSelectObjectEvent(SelectedObject.UID);

    BearingObject := TBScopeItem.Create;
    BearingObject.UID := SelectedObject.UID;
    BearingObject.Range := 0;//SelectedObject.Range;
    BearingObject.Bearing := SelectedObject.Bearing;
    BearingObject.Speed := 0;//SelectedObject.Speed;
    BearingObject.Left := SelectedObject.Left;
    BearingObject.Top := Height - 16;
    BearingObject.Width := SelectedObject.Width;
    BearingObject.Height := 16;
    BearingObject.CenterX := SelectedObject.CenterX;
    BearingObject.CenterY := Height - 8;
    BearingObject.Status := GATED;
    BearingObject.Info.Line1 := s;
    //SelectedObject.Info.Line1 := s;
    if s = '1' then
      LabeledObjects[0] := BearingObject;
    if s = '2' then
      LabeledObjects[1] := BearingObject;
    if s = '3' then
      LabeledObjects[2] := BearingObject;
    if s = '4' then
      LabeledObjects[3] := BearingObject;
  end;

end;
//----------------------------------------------------------------------------
function TBScopeDisplay.FindByScreenXRange(const left,
  right: integer): integer;
var i   : integer;
    found : boolean;
    obj : TBScopeItem;
begin
  found := false;
  i := 0;
  while not found and (i < FItems.Count) do begin
    obj := FItems[i];
    inc(i);
    found := (left <= obj.FBoundRect.Left) and (right >= obj.FBoundRect.Left);
  end;

  if found then
    result := i-1
  else
    result := -1;
end;

procedure TBScopeDisplay.UpdateLabeledObject;
var
  i: integer;
  itemIdx : integer;
  obj : TBScopeItem;
begin
  for i := 0 to C_Number_Target_Label-1 do begin
    if LabeledObjects[i] <>  nil then begin
      itemIdx := FindByUID(LabeledObjects[i].UID);
      if itemIdx <> -1 then begin
        obj := FItems[itemIdx];
        LabeledObjects[i].Bearing := obj.Bearing;
      end;
    end;
  end;
end;
//==============================================================================
function TBScopeDisplay.SetAudioLock(const isLocked: boolean):double;
begin
  FAudioLock := isLocked;
  Result := PixelToDirection(MarkerX);
end;

{ TBScopeAudioMarkerDisplay }

constructor TBScopeAudioMarkerDisplay.Create(AOwner: TComponent);
begin
  inherited;
  FStartUp := true;
end;

function TBScopeAudioMarkerDisplay.GetAudioMarkerX: integer;
begin
  Result := FAudioMarkerX - FScopeLeft + Left;
end;

procedure TBScopeAudioMarkerDisplay.Paint;
begin
  inherited;
  with Canvas do begin
    Brush.Color := clBlack;
    FillRect(Rect(0,0,Width,Height));
    if not FStartUp then begin
      Pen.Color := C_DisplayColor;
      Brush.Color := C_DisplayColor;
      Brush.Style := bsSolid;
      FillRect(Rect(FAudioMarkerX-3, 0, FAudioMarkerX+3, Height));
    end;
  end;

end;

procedure TBScopeAudioMarkerDisplay.SetAudioMarkerX(const Value: integer);
begin
  FStartUp := false;
  FAudioMarkerX := Value + FScopeLeft - Left;
  Repaint;
end;

end.


