unit uBScopeBaseDisplay;
//control for custom images and draw, featuring easy coversion between pixel
//and map scales.
//modified by Trisno Wijayanto
//ver 2.0

interface

uses
  Classes, Windows, Controls, Graphics, uBaseGraphicProc, uBaseGraphicObjects,
  uLabelDisplay, uBaseDataType, SysUtils, Menus, ExtCtrls;

type
//==============================================================================
  TBScopeDrawLineProc = procedure (aCnv : TCanvas;const aWidth,aHeight:integer;const color:TColor;const bkColor:TColor) of object;
  TBScopeDrawMarkerProc = procedure (aCnv : TCanvas;const markerRect:TRect;const color:TColor;const bkColor:TColor) of object;
  TBScopeDataGrabberProc = procedure (var dataList: TList) of object;

//==============================================================================
  TBScopeBaseItem = class(TBMPObject)
  private
    FScaledBmp : TBitmap;
    FPrevScale : double;
  public
    PositionX : double;
    PositionY : double;
    UID : string;
    Intensity : TColor;   //trisno: color intensity of object on screen
    Symbol : TCharSymbol;
    Info   : TInfoLabel;
    //gigih
    //LifeTime: integer;

    DrawNeeded : boolean;
    ProfileFName : string;

    constructor Create;
    destructor Destroy; override;

    function GetScaledRect(const scale:double):TRect;

    procedure Draw(aCnv: TCanvas); override;
    procedure DrawScaledNoised(aCnv: TCanvas; const scale:double);
    procedure DrawScaled(aCnv: TCanvas; const scale:double);
    procedure DrawNoBlur(aCnv: TCanvas);
  end;

  TBScopeItemOnProcces = class
    FcId    : Word;
    Php,
    Splash,
    Item    : TBScopeBaseItem;
    Spalshbmp,
    Itembmp : TBitmap;

    constructor Create;
    destructor Destroy; override;
  end;
//==============================================================================
  TBScopeBaseDisplay = class(TGraphicControl)
  private
    FMarkerRect : TRect;
    FHalfWidth : double;
    FHalfHeight : double;
    FCenterY: double;
    FCenterX: double;
    isShowSymbol : boolean;
    FStartUp : boolean;
    FUpdating : boolean;

    FMarkerShown: boolean;
    FMarkerPositionX: double;
    FMarkerPositionY: double;
    FMarkerColor: TColor;
    FMarkerDragable: boolean;
    FMarkerDragged : boolean;
    FPrevX : integer;
    FPrevY : integer;
    FTransparentBackground: boolean;
    FPopupMenu: TPopupMenu;

    FUpdateInterval: double;
    FUpdateCounter : double;
    FRunning: boolean;
    FMarkerWidth: integer;
    FMarkerHeight: integer;
    blur : Integer;

    function isSymbolShown: boolean;
    procedure ShowSymbol (const Value: boolean);

    procedure ReCalculateEverything;
    procedure ReCalculateMarker;

    procedure SetCenterX(const Value: double);
    procedure SetCenterY(const Value: double);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetLineColor(const Value: TColor);
    procedure SetMarkerPositionX(const Value: double);
    procedure SetMarkerPositionY(const Value: double);
    procedure SetMarkerShown(const Value: boolean);
    procedure SetMarkerColor(const Value: TColor);
    procedure SetMarkerDragable(const Value: boolean);
    procedure SetTransparentBackground(const Value: boolean);
    procedure SetPopupMenu(const Value: TPopupMenu);
    procedure SetUpdateInterval(const Value: double);
    procedure SetRunning(const Value: boolean);
    procedure SetMarkerHeight(const Value: integer);
    procedure SetMarkerWidth(const Value: integer);
  protected
    FBoundRect : TDoubleRect;
    FMarginsRect : TRect;

    FHScale     : single;
    FVScale     : single;

    FBmp    : TBitmap;
    FNoiseBmp : TBitmap;

    FBackgroundColor: TColor;
    FLineColor: TColor;

    FItems  : TList;

    FTmr    : Ttimer;   // Untuk membuat image blinking
    FBlink  : Boolean;
    BScopeItemtoBlinked : TBScopeItemOnProcces;

    function PositionYToPixel(const aR: double): integer;virtual;
    function PixelToPositionY(const aR: integer): double;virtual;
    function PositionXToPixel(const aR: double): integer;virtual;
    function PixelToPositionX(const aR: integer): double;virtual;
    procedure RecalcXScales(const mapWidth : double); virtual;
    procedure RecalcYScales(const mapHeight : double); virtual;

    function FindByUID(const auid: string): integer;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer);
      override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure DrawItems;virtual;
    procedure DrawNoise;virtual;
    procedure FilterBMP;virtual;
    procedure DrawBMP;virtual;
    procedure DrawGrids(aCnv : TCanvas;const aWidth,aHeight:integer;const color:TColor;const bkColor:TColor); virtual;
    procedure DrawEllipseMarker(aCnv : TCanvas;const markerRect:TRect;const color:TColor;const bkColor:TColor); virtual;

  public
    DrawLines : TBScopeDrawLineProc;
    DrawMarker : TBScopeDrawMarkerProc;
    GrabData : TBScopeDataGrabberProc;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ResizeImages(ALeft, ATop, AWidth, AHeight: Integer);
    procedure SetMargins(const ALeft, ATop, ARight, ABottom: Integer); overload;
    procedure SetMargins(const rect : TRect); overload;
    procedure SetMapBoundary(const ALeft, ATop, ARight, ABottom : double); overload;
    procedure SetMapBoundary(const rect : TDoubleRect); overload;

    procedure ResetDisplay;

    procedure RunTimebase(const dt: double);
    procedure Tick(const dt: double); virtual;

    procedure HideItems;
    procedure HideItem(const UniqueID: string);
    procedure ClearItems;
    procedure AddItem(item: TBScopeBaseItem); overload;
    procedure AddItem(const UniqueID: string;
      const PositionX, PositionY: double; const ProfileFName: String;
      const color : TColor); overload;
    procedure AddItem(const UniqueID: string;
      const PositionX, PositionY: double; const bmp : TBitmap;
      const color : TColor); overload;
    procedure DelItems(item: TBScopeBaseItem); overload;
    procedure DelItems(const UniqueID: string); overload;
    procedure SetBlinking(Value: boolean);
    procedure BlinkedObject(Sender: TObject);
//    procedure ClearPHPandSplash;

    //procedure CreateNoise;
    //function GetItems: TList;
    // gigih

    function TestHit(const sID: string): boolean;
  published
    property IsBlinking : boolean read FBlink write SetBlinking;
    property CenterX : double read FCenterX write SetCenterX;
    property CenterY : double read FCenterY write SetCenterY;
    property BackgroundColor : TColor read FBackgroundColor write SetBackgroundColor;
    property LineColor : TColor read FLineColor write SetLineColor;
    property MarkerColor : TColor read FMarkerColor write SetMarkerColor;
    property SymbolShown: boolean read isSymbolShown write ShowSymbol;
    property MarkerDragable : boolean read FMarkerDragable write SetMarkerDragable;
    property MarkerShown: boolean read FMarkerShown write SetMarkerShown;
    property MarkerPositionX : double read FMarkerPositionX write SetMarkerPositionX;
    property MarkerPositionY : double read FMarkerPositionY write SetMarkerPositionY;
    property MarkerHeight: integer read FMarkerHeight write SetMarkerHeight;
    property MarkerWidth : integer read FMarkerWidth write SetMarkerWidth;
    property TransparentBackground : boolean read FTransparentBackground write SetTransparentBackground;
    property PopupMenu : TPopupMenu read FPopupMenu write SetPopupMenu;
    property UpdateInterval : double read FUpdateInterval write SetUpdateInterval;
    property Running : boolean read FRunning write SetRunning;
  end;

  
implementation
uses Messages, Types, Dialogs, uTDCConstan;
//==============================================================================
{ TBScopeBaseItem }

constructor TBScopeBaseItem.Create;
begin
  inherited;

  Left   := 0;
  Top    := 0;
  Width  := 15;
  Height := 8;
  Intensity := clWhite;
  DrawNeeded := true;

  Symbol := TCharSymbol.Create;
  Symbol.FontName := 'Sonar';
  Symbol.Visible := false;

  Info   := TInfoLabel.Create;
  Info.Color := clWhite;
  Info.Size := 14;

  FScaledBmp := TBitmap.Create;
  FPrevScale := 0;
                       
  //LifeTime := 5;
end;

destructor TBScopeBaseItem.Destroy;
begin
 Info.Free;
 Symbol.Free;
 FScaledBmp.Free;
end;

procedure TBScopeBaseItem.Draw(aCnv: TCanvas);
begin
  if DrawNeeded then begin
    with aCnv do begin
      if FBmp =  nil then begin
        Brush.color := Intensity;   //trisno: intensity as color
        FillRect(FBoundRect);
      end
      else begin
        FBmp.Transparent := true;
        FBmp.TransparentColor := clBlack;
        FBmp.TransparentMode := tmFixed;
        Draw(FBoundRect.Left,FBoundRect.Top,FBmp);
      end;
    end;
  end;
end;

procedure TBScopeBaseItem.DrawNoBlur(aCnv: TCanvas);
begin
  with aCnv do begin
    Symbol.Center.x := CenterX;
    Symbol.Center.y := CenterY;

    Info.Center := Symbol.Center;

    Symbol.Draw(aCnv);
    Info.Draw(aCnv);
  end;

end;

function TBScopeBaseItem.GetScaledRect(const scale: double): TRect;
var
  ScaledRect : TRect;
  scaledWidth, scaledHeight : integer;
begin
  scaledWidth := round(Width*scale);
  scaledHeight := Round(Height*scale);
  ScaledRect.Bottom := FBoundRect.Bottom;
  ScaledRect.Top := ScaledRect.Bottom - scaledHeight;
  ScaledRect.Left := CenterX - round(scaledWidth/2);
  ScaledRect.Right := ScaledRect.Left + scaledWidth;
  Result := ScaledRect;
end;

procedure TBScopeBaseItem.DrawScaledNoised(aCnv: TCanvas; const scale: double);
begin
  if DrawNeeded then begin
    with aCnv do begin
      if FBmp =  nil then begin
        Brush.color := Intensity;   //intensity as color
        FillRect(FBoundRect);
      end
      else begin
        FBmp.Transparent := true;
        FBmp.TransparentColor := clBlack;
        FBmp.TransparentMode := tmFixed;
        if FScaledBmp = nil then FScaledBmp := TBitmap.Create;

        FScaledBmp.Assign(FBmp);
        BitmapNoise(FScaledBmp,10,Intensity);
        //BitmapBlur(FScaledBmp);
        StretchDraw(GetScaledRect(scale),FScaledBmp);
      end;

    end;
  end;
end;

procedure TBScopeBaseItem.DrawScaled(aCnv: TCanvas; const scale: double);
var
  scaledRect : TRect;
begin
  if DrawNeeded then begin
    with aCnv do begin
      if FBmp =  nil then begin
        Brush.color := Intensity;   //intensity as color
        FillRect(FBoundRect);
      end
      else begin
        FBmp.Transparent := true;
        FBmp.TransparentColor := clBlack;
        FBmp.TransparentMode := tmFixed;
        if FPrevScale <> scale then begin
          FScaledBmp.Assign(FBmp);
          FScaledBmp.Width := round(FScaledBmp.Width*scale);
          FScaledBmp.Height := round(FScaledBmp.Height*scale);
        end;
        scaledRect := GetScaledRect(scale);
        Draw(scaledRect.Left,scaledRect.Top,FScaledBmp);
      end;

    end;
  end;
end;

{ TBScopeBaseDisplay }
//==============================================================================

constructor TBScopeBaseDisplay.Create(AOwner: TComponent);
begin
  inherited;
  Visible := false;
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

  //FItems  := TList.Create;

  isShowSymbol  := false;
  FStartUp      := true;
  FUpdating     := false;
  FBackgroundColor := clGray;
  FLineColor    := clYellow;

  FMarkerShown := false;
  FMarkerDragable := true;

  //DrawLines := DrawGrids;
  //DrawMarker := DrawEllipseMarker;
  FTransparentBackground := true;
  FMarginsRect := Rect(0,0,0,0);

  FUpdateInterval := 0;
  FUpdateCounter  := 0;

  FBlink          := False;
  blur            := 0;                    // blink image
  FTmr            := Ttimer.Create(Self);
  FTmr.Interval   := 100;
  FTmr.Enabled    := true;
  FTmr.OnTimer    := BlinkedObject;
  BScopeItemtoBlinked := TBScopeItemOnProcces.Create;
  
end;

destructor TBScopeBaseDisplay.Destroy;
begin
  //ClearItems;
  FTmr.Free;
  BScopeItemtoBlinked.Free; 
  DestroyBitmap(FBmp);
  DestroyBitmap(FNoiseBmp);
  inherited;
end;

//------------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
//resize the screen
begin
  inherited;
  ResizeImages(ALeft, ATop, AWidth, AHeight);
end;

procedure TBScopeBaseDisplay.ResizeImages(ALeft, ATop, AWidth,
  AHeight: Integer);
//resize all images
begin
  FBmp.Width  := AWidth - FMarginsRect.Left - FMarginsRect.Right;
  FBmp.Height := AHeight - FMarginsRect.Top - FMarginsRect.Bottom;
  FNoiseBmp.Width  := AWidth - FMarginsRect.Left - FMarginsRect.Right;
  FNoiseBmp.Height := AHeight - FMarginsRect.Top - FMarginsRect.Bottom;
  if (AWidth > 0) and (AHeight > 0) then begin
    //BitmapFillBlack(FBmp);
    FBmp.Canvas.Brush.Color := FBackgroundColor;
    FBmp.Canvas.FillRect(FBmp.Canvas.ClipRect);
    //CreateNoise;
    FNoiseBmp.Canvas.Brush.Color := FBackgroundColor;
    FNoiseBmp.Canvas.FillRect(FNoiseBmp.Canvas.ClipRect);

    if FMarkerWidth = 0 then FMarkerWidth := round(Height/10);
    if FMarkerHeight = 0 then FMarkerHeight := round(Height/10);

    SetMapBoundary(FBoundRect);
  end;
  Repaint;
end;

//------------------------------------------------------------------------------
function TBScopeBaseDisplay.FindByUID(const auid: string): integer;
var i   : integer;
    found : boolean;
    obj : TBScopeBaseItem;
begin
  found := false;
  i := 0;
  if not Assigned(FItems)then Exit;

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

procedure TBScopeBaseDisplay.ClearItems;
var i: integer;
    obj : TObject;
begin
  if assigned(FItems) then begin
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];
      obj.Free;
    end;
    FItems.Clear;
  end;
  Paint;
end;

procedure TBScopeBaseDisplay.AddItem(item: TBScopeBaseItem);
var search : integer;
    obj : TBScopeBaseItem;
begin
  if not assigned(FItems) then FItems := TList.Create;
  search :=   FindByUID(item.UID);
  if search < 0 then
    FItems.Add(item)
  else begin
    obj := FItems[search];
    obj.PositionX := item.PositionX;
    obj.PositionY := item.PositionY;
    obj.Intensity := item.Intensity;
    if (item.ProfileFName <> '') and (item.ProfileFName <> obj.ProfileFName) then begin //profile changed
      obj.ProfileFName := item.ProfileFName;
      try
        obj.FBmp.LoadFromFile(item.ProfileFName);
        BitmapChangeMonochromeColor(obj.FBmp,obj.Intensity); //modify bitmap color
        if (obj.FBmp.Width <> 0) and (obj.FBmp.Height <> 0) then begin
          obj.Width := obj.FBmp.Width;
          obj.Height := obj.FBmp.Height;
          //BitmapBlur(obj.FBmp);
        end;
      except

      end;
    end
    else if (item.ProfileFName = '') then begin
      obj.ProfileFName := item.ProfileFName;
      obj.FBmp.Free;
      obj.FBmp := TBitmap.Create;
    end;
    item.Free;
  end;
end;

procedure TBScopeBaseDisplay.AddItem(const UniqueID: string;
  const PositionX, PositionY: double; const ProfileFName: String;
  const color : TColor);
var search : integer;
    obj : TBScopeBaseItem;
begin
  if not assigned(FItems) then FItems := TList.Create;
  search :=   FindByUID(UniqueID);
  if search < 0 then begin
    obj := TBScopeBaseItem.Create;
    obj.PositionX := PositionX;
    obj.PositionY := PositionY;
    obj.UID := UniqueID;
    obj.Intensity := color;
    if ProfileFName <> '' then begin
      obj.ProfileFName := ProfileFName;
      try
        obj.FBmp.LoadFromFile(ProfileFName);
        BitmapChangeMonochromeColor(obj.FBmp,obj.Intensity); //modify bitmap color
        if (obj.FBmp.Width <> 0) and (obj.FBmp.Height <> 0) then begin
          obj.Width := obj.FBmp.Width;
          obj.Height := obj.FBmp.Height;
          //BitmapBlur(obj.FBmp);
        end;
      except

      end;
    end;
    FItems.Add(obj)
  end
  else begin
    obj := FItems[search];
    obj.PositionX := PositionX;
    obj.PositionY := PositionY;
    obj.Intensity := color;
    if (ProfileFName <> '') and (ProfileFName <> obj.ProfileFName) then begin //profile changed
      obj.ProfileFName := ProfileFName;
      try
        obj.FBmp.LoadFromFile(ProfileFName);
        BitmapChangeMonochromeColor(obj.FBmp,obj.Intensity); //modify bitmap color
        if (obj.FBmp.Width <> 0) and (obj.FBmp.Height <> 0) then begin
          obj.Width := obj.FBmp.Width;
          obj.Height := obj.FBmp.Height;
          //BitmapBlur(obj.FBmp);
        end;
      except

      end;
    end
    else if (ProfileFName = '') then begin
      obj.ProfileFName := ProfileFName;
      obj.FBmp.Free;
      obj.FBmp := TBitmap.Create;
    end;
  end
end;

procedure TBScopeBaseDisplay.AddItem(const UniqueID: string;
  const PositionX, PositionY: double; const bmp: TBitmap;
  const color: TColor);
var search : integer;
    obj : TBScopeBaseItem;
begin
  if not assigned(FItems) then FItems := TList.Create;
  search :=   FindByUID(UniqueID);
  if search < 0 then begin
    obj := TBScopeBaseItem.Create;
    obj.PositionX := PositionX;
    obj.PositionY := PositionY;
    obj.UID := UniqueID;
    obj.Intensity := color;
    obj.FBmp := bmp;
    FItems.Add(obj)
  end
  else begin
    obj := FItems[search];
    obj.PositionX := PositionX;
    obj.PositionY := PositionY;
    obj.Intensity := color;
    obj.FBmp := bmp;
  end
end;

//procedure TBScopeBaseDisplay.ClearPHPandSplash;
//var search,i : Integer;
//obj : TBScopeBaseItem;
//begin
//  if not assigned(FItems) then Exit;
//  search :=  FindByUID('splash');
//  if search < 0  then Exit;
//
//  for i := FItems.Count-1 downto 0 do begin
//    obj := FItems[i];
//    if Copy(obj.UID,0,Length(obj.UID)-1) ='splash' then
//      obj.Free;
//  end;
//  paint;
//end;

procedure TBScopeBaseDisplay.BlinkedObject(Sender: TObject);
var search,i,x,y : Integer;
    obj : TBScopeBaseItem;
    tmpbmp : TBitmap;
begin
  if not assigned(FItems) then Exit;
  search :=   FindByUID('echo');
  if search < 0  then Exit;
  tmpbmp := TBitmap.Create;
 try
    if FBlink then begin
       if assigned(FItems) then begin
         for i :=  FItems.Count-1 downto 0 do begin
            obj := FItems[i];
            if (obj.UID='echo') then begin
              if (obj.ProfileFName = C_IMAGES_PATH + 'shipTest.bmp')then begin
                tmpbmp.LoadFromFile(C_IMAGES_PATH + 'shipTest.bmp');
                for x:= 1 to obj.FBmp.Width do
                for y:= 1 to obj.FBmp.Height do
                begin
                  obj.FBmp.Canvas.Pixels[x,y] := obj.FBmp.Canvas.Pixels[x,y] - RGB(blur,blur,blur);
                  if blur<=0 then begin
                   obj.FBmp.Assign(tmpbmp);
                   blur:=15;
                  end;
                end;

              end;
            end ;
//            else if Copy(obj.UID,0,Length(obj.UID)-1) ='splash' then  begin
//              tmpbmp.LoadFromFile(C_IMAGES_PATH + 'splash.bmp');
//              obj.FBmp.Assign(tmpbmp);
//              for x:= 1 to obj.FBmp.Width do
//              for y:= 1 to obj.FBmp.Height do
//              begin
//                  obj.FBmp.Canvas.Pixels[x,y] := obj.FBmp.Canvas.Pixels[x,y] - RGB(0,0,0);
////                  if blur<=0 then begin
////                   obj.FBmp.Assign(tmpbmp);
////                   blur:=15;
////                  end;
//              end;
//            end;

            Paint;
         end;
       end;
     blur:=blur-1;
    end;
 finally
  tmpbmp.Free;
 end;


end;

procedure TBScopeBaseDisplay.DelItems(item: TBScopeBaseItem);
begin
  FItems.Remove(item);
end;

procedure TBScopeBaseDisplay.DelItems(const UniqueID: string);
var
  search : integer;
begin
  search := FindByUID(UniqueID);
  if search >= 0 then
    FItems.Remove(FItems[search])
end;

procedure TBScopeBaseDisplay.HideItems;
var
  i : integer;
  obj : TBScopeBaseItem;
begin
  for i := FItems.Count-1 downto 0 do begin
    obj := FItems[i];
    obj.Intensity := 0;
    obj.DrawNeeded := false;
    obj.Info.Line1 := '';
    obj.Info.Line2 := '';
    obj.Info.Line3 := '';
  end;
  Repaint;
end;

procedure TBScopeBaseDisplay.HideItem(const UniqueID: string);
var search : integer;
    obj : TBScopeBaseItem;
begin
if not Assigned(FItems)then Exit;
  search := FindByUID(UniqueID);
  if search >= 0 then begin
    obj := FItems[search];
    obj.Intensity := 0;
    obj.DrawNeeded := false;
    obj.Info.Line1 := '';
    obj.Info.Line2 := '';
    obj.Info.Line3 := '';
  end;
  Repaint;
end;

//------------------------------------------------------------------------------

function TBScopeBaseDisplay.PositionXToPixel(const aR: double): integer;
var                            //if inside the boundary result := pixel,
  vR : single;                 //else result := -1
  val : integer;
begin
  val := -1;
  if FHScale <> 0 then begin
    vR := 0;
    if FBoundRect.Left < FBoundRect.Right then begin  //left is smaller
      if (FBoundRect.Left <= aR) and (FBoundRect.Right >= aR) then begin
        vR := abs(aR - FBoundRect.Left);
      end;
    end
    else begin  //right is smaller
      if (FBoundRect.Left >= aR) and (FBoundRect.Right <= aR) then begin
        vR := abs(aR - FBoundRect.Left);
      end;
    end;
    val := Round(vR / FHScale)// + FMarginsRect.Left;
  end;
  //if val > (Width - FMarginsRect.Right) then val := -1;
  Result := val;
end;

function TBScopeBaseDisplay.PixelToPositionX(const aR: integer): double;
var
  vR : integer;
begin
  if aR <= (Width - FMarginsRect.Right) then begin
    vR := aR - FMarginsRect.Left;
    if FBoundRect.Left < FBoundRect.Right then begin  //left is smaller
      result := FBoundRect.Left + (vR * FHScale);
    end
    else begin //right is smaller
      result := FBoundRect.Left - (vR * FHScale);
    end;
  end
  else
    result := -1;
end;

function TBScopeBaseDisplay.PositionYToPixel(const aR: double): integer;
var                             //if inside the boundary result := pixel,
  vR : single;                  //else result := -1
  val : integer;
begin
  val := -1;
  if FVScale <> 0 then begin
    vR := 0;
    if FBoundRect.Top < FBoundRect.Bottom then begin  //Top is smaller
      if (FBoundRect.Top <= aR) and (FBoundRect.Bottom >= aR) then begin
        vR := abs(aR - FBoundRect.Top);
      end
    end
    else begin  //bottom is smaller
      if (FBoundRect.Top >= aR) and (FBoundRect.Bottom <= aR) then begin
        vR := abs(aR - FBoundRect.Top);
      end
    end;
    val := Round(vR / FVScale);// + FMarginsRect.Top;
  end;
  //if val > (Height - FMarginsRect.Bottom) then val := -1;
  Result := val;
end;

function TBScopeBaseDisplay.PixelToPositionY(const aR: integer): double;
var
  vR : integer;
begin
  if aR <= (Height - FMarginsRect.Bottom) then begin
    vR := aR - FMarginsRect.Top;
    if FBoundRect.Top < FBoundRect.Bottom then begin  //Top is smaller
      result := FBoundRect.Top + (vR * FVScale);
    end
    else begin
      result := FBoundRect.Top - (vR * FVScale);
    end;
  end
  else
    result := -1;
end;

//------------------------------------------------------------------------------
procedure TBScopeBaseDisplay.Paint;
var
  prevPenColor : TColor;
  prevPenStyle : TPenStyle;
  prevPenWidth : integer;
  prevBrushColor : TColor;
begin
  if not FUpdating then begin
    prevPenColor := Canvas.Pen.Color;
    prevPenStyle := Canvas.Pen.Style;
    prevPenWidth := Canvas.Pen.Width;
    prevBrushColor := Canvas.Brush.Color;

    //clean board
    if not FTransparentBackground then begin
      Canvas.Brush.Color := FBackgroundColor;
      Canvas.FillRect(Rect(0,0,Width, FMarginsRect.Top));
      Canvas.FillRect(Rect(0,Height - FMarginsRect.Bottom,Width, Height));
      Canvas.FillRect(Rect(0,FMarginsRect.Top,FMarginsRect.Left, Height - FMarginsRect.Bottom));
      Canvas.FillRect(Rect(Width - FMarginsRect.Right,FMarginsRect.Top,Width, Height - FMarginsRect.Bottom));
    end;
    FBmp.Canvas.Brush.Color :=FBackgroundColor; //}$00333333;
    FBmp.Canvas.FillRect(FBmp.Canvas.ClipRect);

    //draw objects
    DrawItems;

    //blend noises to FBmp
    DrawNoise;

    //filter FBmp
    FilterBMP;

    //draw the bitmap
    DrawBmp;

    //draw marker
    if Assigned(DrawMarker) then
      DrawMarker(Canvas,FMarkerRect,FMarkerColor, FBackgroundColor)
    else
      DrawEllipseMarker(Canvas,FMarkerRect,FMarkerColor, FBackgroundColor);

    //draw lines
    if Assigned(DrawLines) then
      DrawLines(Canvas,Width,Height, FLineColor, FBackgroundColor)
    else
      DrawGrids(Canvas,Width,Height, FLineColor, FBackgroundColor);


    Canvas.Pen.Color := prevPenColor;
    Canvas.Pen.Style := prevPenStyle;
    Canvas.Pen.Width := prevPenWidth;
    Canvas.Brush.Color := prevBrushColor;
  end;
end;
//------------------------------------------------------------------------------
procedure TBScopeBaseDisplay.DrawGrids(aCnv: TCanvas; const aWidth,
  aHeight: integer;const color:TColor;const bkColor:TColor);
//Draw lines on foreground;
//assign DrawLines property or override this proc to customize
var
  step,i : integer;
begin
  //draw lines
  with aCnv do begin
    Pen.Color := color;
    Pen.Style := psSolid;
    step := round(aWidth/10);
    for i := 1 to 9 do begin
      if i = 5 then Pen.Width := 2
      else Pen.Width := 1;
      MoveTo(i*step,0);
      LineTo(i*step,aHeight);
    end;
    step := round(aHeight/10);
    for i := 1 to 9 do begin
      if i = 5 then Pen.Width := 2
      else Pen.Width := 1;
      MoveTo(0,i*step);
      LineTo(aWidth,i*step);
    end;
  end;
end;

procedure TBScopeBaseDisplay.DrawEllipseMarker(aCnv: TCanvas;
  const markerRect: TRect; const color: TColor;const bkColor:TColor);
//Draw marker that appear on mouse click;
//assign DrawMarker property or override this proc to customize
begin
  //draw ellipse marker
  if FMarkerShown then begin
    Canvas.Brush.Color := color;
    Canvas.Pen.Color := color;
    Canvas.Ellipse(markerRect);
  end;
end;

procedure TBScopeBaseDisplay.DrawBMP;
//Draw processed FBmp to screen, must be overrided to change
begin
  if not FTransparentBackground then begin
    BitBlt(Canvas.handle, FMarginsRect.Left, FMarginsRect.Top, FBmp.Width, FBmp.Height,
           FBmp.Canvas.Handle, 0, 0, SRCCOPY );
  end
  else begin
    FBmp.TransparentColor := FBackgroundColor;
    //FBmp.TransparentMode := tmFixed;
    FBmp.Transparent := true;
    Canvas.Draw(FMarginsRect.Left, FMarginsRect.Top,FBmp);
  end;
end;

procedure TBScopeBaseDisplay.DrawItems;
//Draw all items, must be overrided to change
var
  i : integer;
  obj : TBScopeBaseItem;
  x,y : integer;
begin
  if assigned(Fitems) then begin
    for i := FItems.Count-1 downto 0 do begin
      obj := FItems[i];
      x := PositionXToPixel(obj.PositionX);
      y := PositionYToPixel(obj.PositionY);
      obj.CenterX := x;
      obj.CenterY := y;
      if (x >= 0) and (y >= 0) then begin
        obj.Draw(FBmp.Canvas);
      end;
    end;
  end;
end;

procedure TBScopeBaseDisplay.DrawNoise;
//Draw Noise, must be overrided to change
begin
  //TODO: Draw noises
end;

procedure TBScopeBaseDisplay.FilterBMP;
//Draw Filtered pictures, must be overrided to change
begin
  //TODO: fill FilteredBmp
end;


//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TBScopeBaseDisplay.RunTimebase(const dt: double);
//Call this on Thread run
begin
  FStartUp := false;
  FUpdateCounter := FUpdateCounter - dt;
  if FUpdateCounter <= 0 then begin
    FUpdating := true;

    Tick(dt);

    FUpdating := false;
    FUpdateCounter := FUpdateInterval;
  end;
  Repaint;
end;

procedure TBScopeBaseDisplay.Tick(const dt: double);
//override this to handle the Thread run
begin
  //TODO : do thread tick works here
end;

procedure TBScopeBaseDisplay.SetUpdateInterval(const Value: double);
begin
  FUpdateInterval := Value;
  FUpdateCounter  := Value;
end;

procedure TBScopeBaseDisplay.SetRunning(const Value: boolean);
begin
  FRunning := Value;
end;

//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TBScopeBaseDisplay.isSymbolShown: boolean;
begin
  Result := isShowSymbol;
end;

procedure TBScopeBaseDisplay.ShowSymbol (const Value: boolean);
begin
  isShowSymbol := Value;
end;
//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.ResetDisplay;
var
  i : integer;
  obj : TBScopeBaseItem;
begin
  BitmapFillBlack(FBmp); //clear display

  for i := FItems.Count-1 downto 0 do begin   //hide items
    obj := FItems[i];
    obj.Intensity := 0;
  end;

  Repaint;
end;

//----------------------------------------------------------------------------
{
procedure TBScopeBaseDisplay.CreateNoise;
begin
  BitmapFillBlack(FNoiseBmp);
  //TODO: draw noises here
  BitmapBlur(FNoiseBmp);
end;
}

procedure TBScopeBaseDisplay.SetCenterX(const Value: double);
begin
  FCenterX := Value;
  if FBoundRect.Left < FBoundRect.Right then begin  //left is smaller
    FBoundRect.Left := FCenterX - FHalfWidth;
    FBoundRect.Right := FCenterX + FHalfWidth;
  end
  else begin //right is smaller
    FBoundRect.Left := FCenterX + FHalfWidth;
    FBoundRect.Right := FCenterX - FHalfWidth;
  end;
  ReCalculateMarker;
end;

procedure TBScopeBaseDisplay.SetCenterY(const Value: double);
begin
  FCenterY := Value;
  if FBoundRect.Top < FBoundRect.Bottom then begin //Top is smaller
    FBoundRect.Top := FCenterY - FHalfHeight;
    FBoundRect.Bottom := FCenterY + FHalfHeight;
  end
  else begin //bottom is smaller
    FBoundRect.Top := FCenterY + FHalfHeight;
    FBoundRect.Bottom := FCenterY - FHalfHeight;
  end;
  ReCalculateMarker;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetMapBoundary(const ALeft, ATop, ARight,
  ABottom: double);
begin
  //Assert(ALeft <> ARight);
  //Assert(ATop <> ABottom);
  FBoundRect.Left := ALeft;
  FBoundRect.Top := ATop;
  FBoundRect.Right := ARight;
  FBoundRect.Bottom := ABottom;

  ReCalculateEverything;
end;

procedure TBScopeBaseDisplay.SetMapBoundary(const rect: TDoubleRect);
begin
  //Assert(rect.Left <> rect.Right);
  //Assert(rect.Top <> rect.Bottom);
  FBoundRect.Left := rect.Left;
  FBoundRect.Top := rect.Top;
  FBoundRect.Right := rect.Right;
  FBoundRect.Bottom := rect.Bottom;

  ReCalculateEverything;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  Repaint;
end;

procedure TBScopeBaseDisplay.SetBlinking(Value: boolean);
begin
FBlink := Value;
end;

procedure TBScopeBaseDisplay.SetLineColor(const Value: TColor);
begin
  FLineColor := Value;
  Repaint;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetMarkerPositionX(const Value: double);
begin
  FMarkerPositionX := Value;
  ReCalculateMarker;
end;

procedure TBScopeBaseDisplay.SetMarkerPositionY(const Value: double);
begin
  FMarkerPositionY := Value;
  ReCalculateMarker;
end;

procedure TBScopeBaseDisplay.SetMarkerShown(const Value: boolean);
begin
  FMarkerShown := Value;
  Repaint;
end;

procedure TBScopeBaseDisplay.SetMarkerColor(const Value: TColor);
begin
  FMarkerColor := Value;
end;

procedure TBScopeBaseDisplay.SetMarkerDragable(const Value: boolean);
begin
  FMarkerDragable := Value;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetTransparentBackground(
  const Value: boolean);
begin
  FTransparentBackground := Value;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
end;

//----------------------------------------------------------------------------
procedure TBScopeBaseDisplay.SetMargins(const ALeft, ATop, ARight,
  ABottom: Integer);
begin
  FMarginsRect.Left := ALeft;
  FMarginsRect.Top := ATop;
  FMarginsRect.Right := ARight;
  FMarginsRect.Bottom := ABottom;

  ResizeImages(Left,Top,Width,Height);
  ReCalculateEverything;
end;

procedure TBScopeBaseDisplay.SetMargins(const rect: TRect);
begin
  FMarginsRect := rect;

  ResizeImages(Left,Top,Width,Height);
  ReCalculateEverything;
end;

//------------------------------------------------------------------------------
procedure TBScopeBaseDisplay.ReCalculateEverything;
//recalculate scales and centers
begin
  FHalfWidth := abs((FBoundRect.Right - FBoundRect.Left)/2);
  FHalfHeight := abs((FBoundRect.Bottom - FBoundRect.Top)/2);
  if FBoundRect.Left < FBoundRect.Right then //left is smaller
    FCenterX := FBoundRect.Left + FHalfWidth
  else //right is smaller
    FCenterX := FBoundRect.Left - FHalfWidth;
  if FBoundRect.Top < FBoundRect.Bottom then //top is smaller
    FCenterY := FBoundRect.Top + FHalfHeight
  else  //bottom is smaller
    FCenterY := FBoundRect.Top - FHalfHeight;

  RecalcXScales(FHalfWidth*2);
  RecalcYScales(FHalfHeight*2);
  ReCalculateMarker;
end;

procedure TBScopeBaseDisplay.ReCalculateMarker;
//recalculate marker position
var
  x,y : integer;
begin
  if (Width <> 0) and (Height <> 0) then begin
    x := PositionXToPixel(FMarkerPositionX);
    y := PositionYToPixel(FMarkerPositionY);
    if (x >= 0) and (y >= 0) then begin
      FMarkerRect.Left := x - round(FMarkerWidth/2);
      FMarkerRect.Top := y - round(FMarkerHeight/2);
      FMarkerRect.Right := FMarkerRect.Left + round(FMarkerWidth);
      FMarkerRect.Bottom :=FMarkerRect.Top + round(FMarkerHeight);
    end
  end;
  Repaint;
end;

procedure TBScopeBaseDisplay.RecalcXScales(const mapWidth: double);
//recalculate horizontal scales
begin
  FHScale := mapWidth/(FBmp.Width);// - FMarginsRect.Left - FMarginsRect.Right);
end;

procedure TBScopeBaseDisplay.RecalcYScales(const mapHeight: double);
//recalculate vertical scales
begin
  FVScale := mapHeight/(FBmp.Height);// - FMarginsRect.Top - FMarginsRect.Bottom);
end;

//------------------------------------------------------------------------------
procedure TBScopeBaseDisplay.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt : TPoint;
  msg : TMessage;
begin
  inherited;
  if FMarkerDragable then begin
    if Button = mbLeft then begin
      pt.X := X;
      pt.Y := Y;
      if PtInRect(FMarkerRect,pt) then begin
        FMarkerDragged := true;
        FPrevX := X;
        FPrevY := Y;
      end;
    end;
  end;
  if TransparentBackground then begin
    if Button = mbLeft then begin
      msg.Msg := WM_LBUTTONDOWN;
      msg.WParam := 0;
      msg.LParamLo := X;
      msg.LParamHi := Y;
    end;
    parent.Broadcast(msg);
  end;
end;

procedure TBScopeBaseDisplay.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  xshift, yshift : integer;
  markerX, markerY : integer;
begin
  inherited;
  if FMarkerDragable then begin
    if FMarkerDragged then begin
      xshift := X - FPrevX;//FPrevX - X;
      yshift := Y - FPrevY;//FPrevY - Y;
      FPrevX := X;
      FPrevY := Y;

      //move marker rect
      FMarkerRect.Left := FMarkerRect.Left + xshift;
      FMarkerRect.Right := FMarkerRect.Right + xshift;
      FMarkerRect.Top := FMarkerRect.Top + yshift;
      FMarkerRect.Bottom := FMarkerRect.Bottom + yshift;

      //move position
      markerX := FMarkerRect.Left + round((FMarkerRect.Right - FMarkerRect.Left)/2);
      markerY := FMarkerRect.Top + round((FMarkerRect.Bottom - FMarkerRect.Top)/2);
      FMarkerPositionX := PixelToPositionX(markerX);
      FMarkerPositionY := PixelToPositionY(markerY);

      Repaint;
    end;
  end;
end;

procedure TBScopeBaseDisplay.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt : TPoint;
begin
  inherited;
  if FMarkerDragable then begin
    if Button = mbLeft then begin
      FMarkerDragged := false;
    end;
  end;
  if Button = mbRight then begin
    if assigned(FPopupMenu) then begin
      Pt := Parent.ClientToScreen(Point(X,Y));
      FPopupMenu.Popup(Pt.X,Pt.Y);
    end;
  end;
end;

procedure TBScopeBaseDisplay.SetMarkerHeight(const Value: integer);
begin
  FMarkerHeight := Value;
  ReCalculateMarker;
end;

procedure TBScopeBaseDisplay.SetMarkerWidth(const Value: integer);
begin
  FMarkerWidth := Value;
  ReCalculateMarker;
end;

function TBScopeBaseDisplay.TestHit(const sID: string): boolean;
var itm: TBScopeBaseItem;
  indx: integer;
  r : TRect;
begin
  result := false;
  indx := FindByUID(sID);
  if indx <> -1 then begin
    itm := FItems[indx];
    result := IntersectRect(r, FMarkerRect, itm.FBoundRect);
  end;
end;
{ TBScopeItemOnProcces }

constructor TBScopeItemOnProcces.Create;
begin
  FcId      := 0;
  Php       := TBScopeBaseItem.create;
  Splash    := TBScopeBaseItem.create;
  Item      := TBScopeBaseItem.create;
  Spalshbmp := TBitmap.Create;
  Itembmp   := TBitmap.Create;

end;

destructor TBScopeItemOnProcces.Destroy;
begin
  Php.Free;
  Splash.Free;    
  Item.Free;      
  Spalshbmp.Free; 
  Itembmp.Free;   
  inherited;
end;

end.
