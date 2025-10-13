unit ufTDCTengah;

interface

uses
  MapXLib_TLB,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, OleCtrls,   uMapWindow,
  ExtCtrls, Buttons, SpeedButtonImage, StdCtrls,
  uLibTDCClass, VrControls, VrDigit, VrWheel;

type

  tHandWheelData = record
    LastPos : integer;
    MinVal, MaxVal  : double;
    Step    : double;
    Value   : double;
  end;


  TfrmTDCTengah = class(TfrmMapWindow)
    ilGreenBox: TImageList;
    ilGreenRound: TImageList;
    ilBlueBox: TImageList;
    ilOrangeBox: TImageList;
    ilOrangeRound: TImageList;

    Panel1: TPanel;
    Panel3: TPanel;
    VrBearing: TVrDigitGroup;
    lblBearing: TLabel;
    pnlRange: TPanel;
    VrRange: TVrDigitGroup;
    lblRanges: TLabel;
    Image1: TImage;
    wBearing: TVrWheel;
    wRange: TVrWheel;
    Image3: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wBearingChange(Sender: TObject);
    procedure wRangeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;
    tdc_image_path:  string;

    msDown : boolean; // flag mouse down;
    mIndex : integer; // marker index;
    ClickNum: integer;

    bData : tHandWheelData;  // bearing;
    rData : tHandWheelData;  // range  ;

    procedure OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure CalcHandWheelData(var hData: tHandWheelData; hw: TVrWheel);
  end;


  procedure freeBmp (var bmp:TBitmap);

  const IMAGES_PATH  = 'images\tdc\';

implementation

uses
  Math, uBaseConstan, uLibRadar, uCompassDisplay;

{$R *.dfm}

{ TfrmTDCTengah }
procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;


procedure TfrmTDCTengah.OBMKanan_MapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.OBMRight_SetPosition(X, Y);
end;

procedure TfrmTDCTengah.OBMKiri_MapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.OBMLeft_SetPosition(X, Y);
end;

procedure TfrmTDCTengah.FormCreate(Sender: TObject);
var bmp :TBitmap;
   i: integer;
   fname: string;
   c :TDrawCompass;
begin
  inherited;

  Map.BackColor := clGray;
  Map.Width   := Image1.Width - 60;
  Map.Height  := Image1.Height- 60;
  Map.Left    := Image1.Left  + Panel1.Left + 30;
  Map.Top     := Image1.Top   + Panel1.Top  + 30;

  FCoverVisible := TRUE;
  SetRegionCircle;

  tdc_image_path := ExtractFilePath(Application.ExeName);
  tdc_image_path := Copy(tdc_image_path,1,length(tdc_image_path)-4) + 'data\images\tdc\';

  bmp:=TBitmap.Create;

  bmp.LoadFromFile(tdc_image_path+'greenBOX.bmp');
  ilGreenBox.Add(bmp,nil);
  freebmp(bmp);

  bmp.LoadFromFile(tdc_image_path+'greenROUND.bmp');
  ilGreenRound.Add(bmp,nil);
  freebmp(bmp);

  bmp.LoadFromFile(tdc_image_path+'blueBOX.bmp');
  ilBlueBox.Add(bmp,nil);
  freebmp(bmp);

  bmp.LoadFromFile(tdc_image_path+'orangeBOX.bmp');
  ilOrangeBox.Add(bmp,nil);
  freebmp(bmp);

  bmp.LoadFromFile(tdc_image_path+'orangeROUND.bmp');
  ilOrangeRound.Add(bmp,nil);
  freebmp(bmp);

  bmp.Free;
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).ImageIndex := 0;
  end;

  fname := tdc_image_path+ 'tdc_LPD.BMP';

  if FileExists(fname) then
    Image1.Picture.LoadFromFile(fname);

  c := TDrawCompass.Create;
  c.ptC.X := Image1.WIdth shr 1;
  c.ptC.Y := Image1.Height shr 1;

  c.Radius := (Image1.WIdth shr 1) - 2;
  c.DrawCompass(Image1.Canvas);

  c.Free;

  with bData do begin
    LastPos := wBearing.Position;
    MinVal  := 0.0;
    MaxVal  := 360.0;
    Step    := 0.5;
    Value   := 0.0;
  end;

  with rData do begin
    LastPos := wRange.Position;
    MinVal  := 0.0;
    MaxVal  := 128.0;
    Step    := 0.1;
    Value   := 0.0;
  end;

end;

procedure TfrmTDCTengah.MapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var lPt  : TPoint;
begin
  //inherited;

  msDown := Button = mbLeft;
  lpt.X  := X;
  lpt.Y  := Y;
  mIndex := TDCInterface.FindMarkerByPosition(lPt);
  TDCInterface.SelectedMarkerTool := mIndex;

  if mIndex < 0 then begin
    Map.OnMouseMove := nil;
    exit;
    ClickNum := 0;
  end;

  case mIndex of

    i_OBM_kiri  : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKiri_MapMouseMove;
    end;
    i_OBM_kanan : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKanan_MapMouseMove;
    end;

  end;
end;

procedure TfrmTDCTengah.MapMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
//  inherited;

end;

procedure TfrmTDCTengah.MapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  inherited;
  if  ClickNum = 1 then
    exit
  else if ClickNum = 2 then begin
    ClickNum := 0;
    Map.OnMouseMove := nil;
    msDown := FALSE;
    mIndex := -1;
    TDCInterface.SelectedMarkerTool := -1;
  end;

end;

procedure TfrmTDCTengah.wBearingChange(Sender: TObject);
begin
  CalcHandWheelData(bData, wBearing);

  TDCInterface.CursorSetBearing(bData.Value);
  VrBearing.Value := bData.Value * 10;

end;

procedure TfrmTDCTengah.wRangeChange(Sender: TObject);
begin
  CalcHandWheelData(rData, wRange);

  TDCInterface.CursorSetRange(rData.Value);
  VrRange.Value := rData.Value;

end;

procedure TfrmTDCTengah.CalcHandWheelData(var hData: tHandWheelData;
  hw: TVrWheel);
var dPos: integer;
    v : integer;
begin
  dPos := hw.Position - hData.LastPos;
  v := Sign(dPos);
  if abs(dPos) > (hw.MaxValue - hw.MinValue) shr 1 then
    dPos := dPos - v * hw.MaxValue;

  with hData do begin
    LastPos := hW.Position;
    Value := Value + Step * dPos;
    if Value < MinVal then Value := Value + MaxVal;
    if Value > MaxVal then Value := Value - MaxVal;
   end;
end;

end.
