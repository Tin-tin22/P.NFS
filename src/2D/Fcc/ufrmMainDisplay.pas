unit ufrmMainDisplay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList,Vcl.OleCtrls, MapXLib_TLB, uBaseFunctionFCC, uObjectVisual,
  uCoordConverter, uMapXUnitConverter, system.math, TFlatCheckBoxUnit, uFccManager, uBridgeSet,
  uSimulationManager, uRadarVisual, uRadarDynamicSector, uRadarNorthIndicator,
  uRadarTargets;

type
  TfrmMainFCC = class(TForm)
    pnlSituationZone: TPanel;
    pnlUpper: TPanel;
    PnlLower: TPanel;
    pnlRightUpper: TPanel;
    pnlVideoZone: TPanel;
    pnlINDData: TPanel;
    pnlNavData: TPanel;
    pnlWeatherData: TPanel;
    pnlFCC: TPanel;
    pnlTracker: TPanel;
    pnlBite: TPanel;
    pnlFCCHeader: TPanel;
    pnlFCCBottom: TPanel;
    pnlButtonCtrl: TPanel;
    pnlLocalState: TPanel;
    pnlLocalStateHeader: TPanel;
    pnlSysCtrl: TPanel;
    pnlCombatLs: TPanel;
    pnlWaitLs: TPanel;
    pnlTrLs: TPanel;
    pnlCtrlCmd: TPanel;
    pnlCtrlCmdHeader: TPanel;
    pnlCombatCtrl: TPanel;
    pnlWaitCtrl: TPanel;
    pnlCtrl: TPanel;
    pnlFireForbid: TPanel;
    pnlCalData: TPanel;
    pnlCalDataHeader: TPanel;
    pnlLast: TPanel;
    pnlLastHeader: TPanel;
    pnlSum: TPanel;
    pnlSumHeader: TPanel;
    pnlCtrlData: TPanel;
    pnlCtrlDataHeader: TPanel;
    pnlCtrlState: TPanel;
    pnlCtrlStateHeader: TPanel;
    pnlGunData: TPanel;
    pnlGunPointAngel: TPanel;
    pnlGunPointAngelHeader: TPanel;
    pnlGunState: TPanel;
    pnlGunStateHeader: TPanel;
    pnlGunParameter: TPanel;
    pnlGunParameterHeader: TPanel;
    pnlTrackerHeader: TPanel;
    pnlBiteHeader: TPanel;
    pnlTrackerBottom: TPanel;
    pnlBiteBottom: TPanel;
    pnlGpDrum: TPanel;
    pnlGpType: TPanel;
    pnlGpRate: TPanel;
    pnlGpPr: TPanel;
    pnlGpRr: TPanel;
    pnlGpMv: TPanel;
    pnlGpTime: TPanel;
    lblGpDrum: TLabel;
    lblGpType: TLabel;
    lblGpRate: TLabel;
    lblGpPr: TLabel;
    lblGpRr: TLabel;
    lblGpMv: TLabel;
    lblGpTime: TLabel;
    lblSatuanMv: TLabel;
    lblSatuanTime: TLabel;
    edtGpABE: TEdit;
    edtGpaEL: TEdit;
    lblGpaBE: TLabel;
    lblGpaEL: TLabel;
    lblLastDeltaBE: TLabel;
    edtLastDeltaBE: TEdit;
    edtLastDeltaEL: TEdit;
    lblLastDeltaEL: TLabel;
    edtLastDeltaD: TEdit;
    lblLastDeltaD: TLabel;
    lblLastSatuanDeltaBE: TLabel;
    lblLastSatuanDeltaEL: TLabel;
    lblLastSatuanDeltaD: TLabel;
    lblSumDeltaBE: TLabel;
    edtSumDeltaBe: TEdit;
    lblSumSatuanDeltaBe: TLabel;
    lblSumDeltaEL: TLabel;
    edtSumDeltaEL: TEdit;
    lblSumSatualDeltaEL: TLabel;
    LblSumDeltaD: TLabel;
    edtSumDeltaD: TEdit;
    lblSumSatuanDeltaD: TLabel;
    lblGpaSatuanBE: TLabel;
    lblGpaSatuanEL: TLabel;
    edtCtrlDataBE: TEdit;
    edtCtrlDataEL: TEdit;
    lblCtrlDataBE: TLabel;
    lblCtrlDataEL: TLabel;
    lblCtrlDataSatuanBE: TLabel;
    lblCtrlDataSatuanEL: TLabel;
    lblCtrlDataBeInc: TLabel;
    edtCtrlDataBeInc: TEdit;
    lblCtrlDataSatuanBeInc: TLabel;
    LblCtrlDataELInc: TLabel;
    edtCtrlDataElInc: TEdit;
    lblCtrlDataSatuanELInc: TLabel;
    lblCtrlDataBeS: TLabel;
    edtCtrlDataBeS: TEdit;
    lblCtrlDataSatuanBeS: TLabel;
    lblCtrlDataElS: TLabel;
    edtCtrlDataElS: TEdit;
    lblCtrlDataSatuanElS: TLabel;
    pnlTrackerData: TPanel;
    lblTrdBE: TLabel;
    lblTrdEL: TLabel;
    lblTrdSatuanBE: TLabel;
    lblTrdSatuanEL: TLabel;
    lblTrdD: TLabel;
    lblTrdSatuanD: TLabel;
    lblTrdDeltaBE: TLabel;
    lblTrdSatuanDeltaBE: TLabel;
    lblTrdDeltaEL: TLabel;
    lblTrdSatuanDeltaEL: TLabel;
    pnlTrackerDataHeader: TPanel;
    edtTrdBE: TEdit;
    edtTrdEL: TEdit;
    edtTrdD: TEdit;
    edtTrdDeltaBE: TEdit;
    edtTrdDeltaEL: TEdit;
    pnlTrackerState: TPanel;
    pnlTrackerStateHeader: TPanel;
    edtTrsLocalCtrl: TEdit;
    edtTrsCombat: TEdit;
    edtTrsWait: TEdit;
    edtTrsLost: TEdit;
    edtTrsAuto: TEdit;
    edtTrsTvChannel: TEdit;
    edtTrsTurnOn: TEdit;
    pnlBiteControl: TPanel;
    pnlBiteBottomTime: TPanel;
    lblBiteOperating: TLabel;
    lblBiteSystem: TLabel;
    lblBiteTimeOperating: TLabel;
    lblBiteTimeSystem: TLabel;
    lblBiteTimeOperatingValue: TLabel;
    lblBiteTimeSystemValue: TLabel;
    pnlBiteDvcState: TPanel;
    lblBiteDvcStateHeader: TPanel;
    pnlBiteChooseDvc: TPanel;
    lblBiteChooseDvc: TPanel;
    btnBiteChooseDvcFCC: TButton;
    btnBiteChooseDvc730B: TButton;
    imgListLight: TImageList;
    imgBiteDvcStateFCC: TImage;
    imgBiteDvcState730B: TImage;
    imgBiteDvcStateEO: TImage;
    imgBiteDvcStateTR: TImage;
    imgBiteDvcStateTCC: TImage;
    imgBiteDvcStateSIE: TImage;
    imgBiteDvcStateSR: TImage;
    lblBiteDvcStateFcc: TLabel;
    lblBiteDvcState730B: TLabel;
    lblBiteDvcStateEO: TLabel;
    lblBiteDvcStateTr: TLabel;
    lblBiteDvcStateTCC: TLabel;
    lblBiteDvcStateSIE: TLabel;
    lblBiteDvcStateSR: TLabel;
    imgCtrlStateTracked: TImage;
    imgCtrlStateDataReady: TImage;
    imgCtrlStateFCC: TImage;
    imgCtrlStateFireAllow: TImage;
    imgCtrlStateFiring: TImage;
    imgCtrlStateLimitZone: TImage;
    imgCtrlStateAimed: TImage;
    lblCtrlStateTracked: TLabel;
    lblCtrlStateDataReady: TLabel;
    lblCtrlStateFCC: TLabel;
    lblCtrlStateFireAllow: TLabel;
    lblCtrlStateFiring: TLabel;
    lblCtrlStateLimitZone: TLabel;
    lblCtrlStateAimed: TLabel;
    lblGunStateCtrlBy: TLabel;
    imgGunStateCtrlBy: TImage;
    lblGunStateServo: TLabel;
    imgGunStateServo: TImage;
    lblGunStateFC: TLabel;
    imgGunStateFC: TImage;
    lblGunStateReturnZero: TLabel;
    imgGunStateReturnZero: TImage;
    pnlIndDataHeader: TPanel;
    pnlNavDataHeader: TPanel;
    pnlWeatherDataHeader: TPanel;
    lblIndDataBatchNo: TLabel;
    edtIndDataBatchNo: TEdit;
    lblIndDataType: TLabel;
    edtIndDataType: TEdit;
    lblIndDataD: TLabel;
    edtIndDataD: TEdit;
    lblIndDataSatuanD: TLabel;
    lblIndDataAZ: TLabel;
    edtIndDataAZ: TEdit;
    lblIndDataSatuanAZ: TLabel;
    lblIndDataEL: TLabel;
    edtIndDataEL: TEdit;
    lblIndDataSatuanEL: TLabel;
    lblIndDataCourse: TLabel;
    edtIndDataCourse: TEdit;
    lblIndDataSatuanCourse: TLabel;
    lblIndDataSpeed: TLabel;
    edtIndDataSpeed: TEdit;
    lblIndDataSatuanSpeed: TLabel;
    edtNavDataRoll: TEdit;
    edtNavDataHeading: TEdit;
    edtNavDataLON: TEdit;
    edtNavDataPitch: TEdit;
    edtNavDataSpeed: TEdit;
    edtNavDataLAT: TEdit;
    edtNavDataVoyage: TEdit;
    lblNavDataRoll: TLabel;
    lblNavDataHeading: TLabel;
    lblNavDataLon: TLabel;
    lblNavDataPitch: TLabel;
    lblNavDataSpeed: TLabel;
    lblNavDataSatuanRoll: TLabel;
    lblNavDataSatuanLon: TLabel;
    lblNavDataSatuanPitch: TLabel;
    lblNavDataSatuanSpeed: TLabel;
    lblNavDataLat: TLabel;
    lblNavDataVoyage: TLabel;
    lblNavDataSatuanHeading: TLabel;
    lblNavDataSatuanVoyage: TLabel;
    lblNavDataSatuanLat: TLabel;
    lblWeatherDataWs: TLabel;
    edtWeatherDataWs: TEdit;
    lblWeatherDataSatuanWs: TLabel;
    lblWeatherDataWd: TLabel;
    edtWeatherDataWd: TEdit;
    lblWeatherDataSatuanWd: TLabel;
    lblWeatherDataTemp: TLabel;
    edtWeatherDataTemp: TEdit;
    lblWeatherDataSatuanTemp: TLabel;
    lblWeatherDataHumi: TLabel;
    edtWeatherDataHumi: TEdit;
    lblWeatherDataSatuanHumi: TLabel;
    lblWeatherDataAirP: TLabel;
    edtWeatherDataAirP: TEdit;
    lblWeatherDataSatuanAirP: TLabel;
    imgBackgrounSituationZone: TImage;
    FMap: TMap;
    btnMapIncrement: TButton;
    btnMapDecrement: TButton;
    pnlMap48km: TPanel;
    pnlMap24km: TPanel;
    pnlMap12km: TPanel;
    pnlMap6km: TPanel;
    pnlMap3km: TPanel;
    pnlMap1point5km: TPanel;
    lblMap48Km: TLabel;
    lblMap24Km: TLabel;
    lblMap12Km: TLabel;
    lblMap6Km: TLabel;
    lblMap3Km: TLabel;
    lblMap1point5Km: TLabel;
    imgCompas: TImage;
    tmrUpdateForm: TTimer;
    FltChkBxTargetPara: TFlatCheckBox;
    FltChkBxDisRing: TFlatCheckBox;
    FltChkBxShootArea: TFlatCheckBox;
    FltChkBxTrackerArea: TFlatCheckBox;
    imgFcc1Image: TImage;
    tmrUpdateHeading: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrUpdateFormTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FMapDrawUserLayer(ASender: TObject; const Layer: IDispatch;
      hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
    procedure btnMapIncrementClick(Sender: TObject);
    procedure btnMapDecrementClick(Sender: TObject);
    procedure pnlMapRangeClick(Sender: TObject);
    procedure imgCompasClick(Sender: TObject);
    procedure tmrUpdateHeadingTimer(Sender: TObject);
    procedure FMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    procedure DrawAngle(aCnv: TCanvas);
    procedure DrawCompas(aCnv: TCanvas);

    function MeterWidth: Integer;
    function MeterHeight: Integer;
    function Rotate(Width, Height, Radius: Integer; Degrees: Double): Winapi.Windows.TPoint;
    procedure DrawLine(Canvas: TCanvas; X1, Y1, X2, Y2: Integer;Color: TColor; Width: Integer);
  private
    { Private declarations }
    FBitmapBackground : TBitmap;
    FLyrDraw: CMapXLayer;
    FNorthAngle : Double;
    FMapCanvas     : TCanvas;
    FMapConverter : TMapXUnitConverter;
    FFlag       : Byte;
    FIndexRange : Integer;
    FCurrentRange : Double;  // meter
    FShipHeading : Integer;

    { Property On TDA }
//    FRangeRing: TRangeRingsVisual;
    FRings       : TRadarRangeRings;
//    FSectors     : array of TRadarSector;
    AreaBlindZone   : TRadarDynamicSector;
    AreaBlindZone1   : TRadarDynamicSector;
    AreaGunPoint   : TRadarDynamicSector;
    AreaPenembakan  : TRadarDynamicSector;
    AreaTracker  : TRadarDynamicSector;
    FBearing0    : TRadarBearing;

    FNorthInd : TRadarNorthIndicator;

    TargetMgr : TRadarTargetManager;

    FCircleRect  : TRect;
    FCircleCX    : Integer;
    FCircleCY    : Integer;
    FCircleR     : Integer; // radius pixel lingkaran peta

    procedure LoadGeoset(const aGst: string); virtual;
    procedure InitializeForm();
    procedure setRegionCircle;

    procedure ResetColorRange();

    procedure DrawAll(aCnv: TCanvas; aCvt: TCoordConverter; aFlag: Byte);
  public
    { Public declarations }
    rCX, rCY: integer;
  end;

var
  frmMainFCC: TfrmMainFCC;

implementation

{$R *.dfm}

uses uLibConst, uBaseConst;
const
  CMin_Z = 0;
  CMax_Z = 14;

function ZoomIndexToScale(const i: Integer): double;
begin
  if i < -3 then
    result := 0.125
  else if i > 14 then
    result := 2500.0
  else
    result := Power(2.0, (i - 3));
end;

function FindClosestZoomIndex(const z: double): Integer;
var
  i: Integer;
begin
  if z >= 2500 then
    result := CMax_Z
  else if z <= 0.125 then
    result := CMin_Z
  else
  begin
    i := Round(Log2(z));
    result := i + 3;
  end;
end;

function FixMapZoom(z: double): double;
begin
  if z >= 1.0 then
    result := Round(z)
  else
    result := 0.001 * Round(z * 1000);
end;

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmMainFCC.btnMapDecrementClick(Sender: TObject);
begin
  if self.FIndexRange > 0 then
  begin
    dec(self.FIndexRange);
    self.FCurrentRange := CRangeOperation[self.FIndexRange];
  end
  else
    self.FCurrentRange := CRangeOperation[0];

  ResetColorRange;

  case FIndexRange of
    0 :
    begin
      pnlMap1point5km.Color := clYellow;
    end;
    1 :
    begin
      pnlMap3km.Color := clYellow;
    end;
    2 :
    begin
      pnlMap6km.Color := clYellow;
    end;
    3 :
    begin
      pnlMap12km.Color := clYellow;
    end;
    4 :
    begin
      pnlMap24km.Color := clYellow;
    end;
    5 :
    begin
      pnlMap48km.Color := clYellow;
    end;
  end;

//  fmap.Zoom := self.FCurrentRange;
  FMap.ZoomTo((Self.FCurrentRange  * C_Meter_To_NauticalMile) * 2, FMap.CenterX, FMap.CenterY);
end;

procedure TfrmMainFCC.btnMapIncrementClick(Sender: TObject);
begin
  if self.FIndexRange < CCountRange - 1 then
  begin
    inc(self.FIndexRange);
    self.FCurrentRange := CRangeOperation[self.FIndexRange];
  end
  else
    self.FCurrentRange := CRangeOperation[CCountRange -1];

  ResetColorRange;

  case FIndexRange of
    0 :
    begin
      pnlMap1point5km.Color := clYellow;
    end;
    1 :
    begin
      pnlMap3km.Color := clYellow;
    end;
    2 :
    begin
      pnlMap6km.Color := clYellow;
    end;
    3 :
    begin
      pnlMap12km.Color := clYellow;
    end;
    4 :
    begin
      pnlMap24km.Color := clYellow;
    end;
    5 :
    begin
      pnlMap48km.Color := clYellow;
    end;
  end;


//  fmap.Zoom := self.FCurrentRange;
  FMap.ZoomTo((Self.FCurrentRange  * C_Meter_To_NauticalMile) * 2, FMap.CenterX, FMap.CenterY);
end;

procedure TfrmMainFCC.DrawAll(aCnv: TCanvas; aCvt: TCoordConverter;
  aFlag: Byte);
var
  pnt: Winapi.Windows.TPoint;
var
  z: double;
  i: Integer;
begin
  aCvt.ConvertToScreen(FMap.CenterX, FMap.CenterY, pnt.X, pnt.Y);

  { Range Rings }
//  FRangeRing.mx := FMap.CenterX;
//  FRangeRing.mY := FMap.CenterY;
//  FRangeRing.Center := pnt;

  z := FixMapZoom(FMap.Zoom);
  i := FindClosestZoomIndex(z);
  z := ZoomIndexToScale(i);

//  FRangeRing.Interval := (FCurrentRange * C_Meter_To_NauticalMile) / 10;
//  FRangeRing.RangeNum := 6;
//  FRangeRing.Visible := True;
//  FRangeRing.FilterShow := True;
//  FRangeRing.ConvertCoord(aCvt);
//  FRangeRing.Draw(aCnv);



    // SECTORS
//    for i := Low(FSectors) to High(FSectors) do
//      if Assigned(FSectors[i]) then
//      begin
//        FSectors[i].CircleRect     := FCircleRect;
//        FSectors[i].CurrentRange_m := FCurrentRange;
//        FSectors[i].MapCenterX     := FMap.CenterX;
//        FSectors[i].MapCenterY     := FMap.CenterY;
//        FSectors[i].ConvertCoord(aCvt);
//        FSectors[i].Draw(aCnv);
//      end;

    // BLIND ZONE
//    AreaBlindZone.CenterX       := FCircleCX;
//    AreaBlindZone.CenterY       := FCircleCY;
//    AreaBlindZone.OuterRadiusPx := FCircleR;
//    AreaBlindZone.HeadingDeg    := FShipHeadingDeg;
//    AreaBlindZone.Draw(C);

    AreaBlindZone1.CenterMode := cmMapPosition;
    AreaBlindZone1.MapPosX := FMap.CenterX;
    AreaBlindZone1.MapPosY := FMap.CenterY;
    AreaBlindZone1.CoordConverter := aCvt;
    AreaBlindZone1.ConvertCoord(aCvt);

    AreaBlindZone1.OuterRadiusPx := FCircleR;
    AreaBlindZone1.CurrentRange_m := Self.FCurrentRange;

    if Assigned(FCCManager) then
      AreaBlindZone1.HeadingDeg    := FCCManager.xShip.Heading;

    AreaBlindZone1.Draw(aCnv);

    AreaBlindZone.CenterMode := cmMapPosition;
    AreaBlindZone.MapPosX := FMap.CenterX;
    AreaBlindZone.MapPosY := FMap.CenterY;
    AreaBlindZone.CoordConverter := aCvt;
    AreaBlindZone.ConvertCoord(aCvt);

    AreaBlindZone.OuterRadiusPx := FCircleR;
    AreaBlindZone.CurrentRange_m := Self.FCurrentRange;

    if Assigned(FCCManager) then
      AreaBlindZone.HeadingDeg    := FCCManager.xShip.Heading;

    AreaBlindZone.Draw(aCnv);

    AreaPenembakan.CenterMode     := cmMapPosition;
    AreaPenembakan.MapPosX        := FMap.CenterX;
    AreaPenembakan.MapPosY        := FMap.CenterY;
    AreaPenembakan.CoordConverter := aCvt;

    AreaPenembakan.OuterRadiusPx  := FCircleR;
    AreaPenembakan.CurrentRange_m := Self.FCurrentRange;

    if Assigned(FCCManager) then
      AreaPenembakan.HeadingDeg    := FCCManager.xShip.Heading;

    AreaPenembakan.Draw(aCnv);

    AreaTracker.CenterMode     := cmMapPosition;
    AreaTracker.MapPosX        := FMap.CenterX;
    AreaTracker.MapPosY        := FMap.CenterY;
    AreaTracker.CoordConverter := aCvt;

    AreaTracker.OuterRadiusPx  := FCircleR;
    AreaTracker.CurrentRange_m := Self.FCurrentRange;

    if Assigned(FCCManager) then
      AreaTracker.HeadingDeg    := FCCManager.xShip.Heading;

    AreaTracker.Draw(aCnv);

    AreaGunPoint.CenterMode     := cmMapPosition;
    AreaGunPoint.MapPosX        := FMap.CenterX;
    AreaGunPoint.MapPosY        := FMap.CenterY;
    AreaGunPoint.CoordConverter := aCvt;

    AreaGunPoint.OuterRadiusPx  := FCircleR;
    AreaGunPoint.CurrentRange_m := Self.FCurrentRange;

    if Assigned(FCCManager) then
      AreaGunPoint.HeadingDeg    := FCCManager.xShip.Heading;

    AreaGunPoint.Draw(aCnv);

    // --- North Indicator ---
    FNorthInd.CenterX       := FCircleCX;
    FNorthInd.CenterY       := FCircleCY;
    FNorthInd.RadiusPx      := FCircleR;
    if Assigned(FCCManager) then
    begin
      FNorthInd.HeadingDeg    := FCCManager.xShip.Heading;
      FNorthInd.UseTrueMotion := FCCManager.IsTrueMotion; // TRUE or FALSE
    end;
    FNorthInd.Draw(aCnv);



    // RANGE RINGS
    FRings.CircleRect    := FCircleRect;
    FRings.CurrentRange_m := FCurrentRange;
    FRings.ConvertCoord(aCvt);
    FRings.Draw(aCnv);

    // BEARING 0°
    FBearing0.CircleRect := FCircleRect;
    FBearing0.ConvertCoord(aCvt);
    FBearing0.Draw(aCnv);

    TargetMgr.Draw(aCnv);

end;

procedure TfrmMainFCC.DrawAngle(aCnv: TCanvas);
var
  I,Size,Enlarge,StartAngle,AngleRadius: Integer;
  ticksMax,ticks,ticksEnlarge,ticksMin :integer;
  labels,decimals,labelsoffset: integer;
  Angle,AngleOffset,BaseAngle : integer;
  Increment,Degrees,CurValue,IncValue: Double;
  R: TRect;
  P1, P2: Winapi.Windows.TPoint;
  Mask,StrValue: string;
  ticksColor : TColor;
  labelsfont : TFont;

  left,top,right,bottom : Integer;
  diffBeetwinWH : Integer;  //differnt beetwin width and height width - height, kemudian dibagi dua sebagai batas left dan right,supaya lingkarannya tetap center.
begin
  Angle := 0;
  baseAngle := round(CBaseAngle);
  AngleOffset := round(CBaseAngle);
  labelsfont := TFont.Create();
  labelsfont.Color := clYellow;
  labelsfont.Size := 10;
  StartAngle := BaseAngle + Angle;

  diffBeetwinWH := (pnlSituationZone.Width - pnlSituationZone.Height) div 2;

  top := 50;
  bottom := pnlSituationZone.Height - top;
  left := diffBeetwinWH + top;
  right := pnlSituationZone.Width - left;
  with aCnv do
  begin
		Pen.Color := CForegroundColor;

    Brush.Style := bsClear;
//    R := Rect(0,0, Map.Width, Map.Height);
    R := Rect(left,top, right, bottom);
//    AngleRadius := (R.right - R.left) div 2;
    AngleRadius := 280;
    ticksmax := 16;
    ticks := round(24);
    ticksEnlarge := 5;
    ticksMin := 8;
    ticksColor := clGreen;
    labels := 24;
    decimals := 0;
    labelsoffset := 30;

    {jarum derajat}

    if Ticks >= 1 then
    begin
      Enlarge := TicksEnlarge;
      Degrees := StartAngle;
      Increment := AngleOffset/Ticks;
      aCnv.Pen.Color := clRed;
      aCnv.Pen.Width := 3;
      aCnv.Ellipse(R.Left, R.Top, R.Right, R.Bottom);
      for I := 1 to Ticks + 1 do
      begin
//        if (Enlarge mod TicksEnlarge = 0) then
//          Size := TicksMax else Size := TicksMin;
        Size := TicksMax;
        Inc(Enlarge);
        P1 := Rotate(MeterWidth, MeterHeight, AngleRadius, Degrees);
        P2 := Rotate(MeterWidth, MeterHeight, AngleRadius + Size, Degrees);
        DrawLine(aCnv, P1.X, P1.Y, P2.X, P2.Y, TicksColor, 2);
        Degrees := Degrees + Increment;
      end;
    end;


    {angka}

    if Labels >= 1 then
    begin
      Font := LabelsFont;
      CurValue := 0;
      IncValue := (360 - 0)/labels;
      Degrees := StartAngle;
      Increment := AngleOffset/labels;
      Mask := '%.' + IntToStr(Decimals) + 'f';
      for I := 1 to Labels  do
      begin
//        P1 := Rotate(MeterWidth, MeterHeight, AngleRadius + LabelsOffset, Degrees);
        P1 := Rotate(MeterWidth, MeterHeight, AngleRadius + LabelsOffset, Degrees);

//        if strlen(pchar(floattostr(CurValue))) <= 2 then
//          begin
//          if curValue = 0 then
//             StrValue := '00'+Format(Mask, [CurValue])
//          else
//             StrValue := '0'+Format(Mask, [CurValue]);
//          end
//        else
        if round(CurValue) mod 30 = 0 then
        begin
          if CurValue > 180 then
             StrValue := Format(Mask, [CurValue - 360]) + '°'
          else
            StrValue := Format(Mask, [CurValue]) + '°';

          P1.X := P1.X - TextWidth(StrValue) div 2;
          P1.Y := P1.Y - TextHeight(StrValue) div 2;
          TextOut(P1.X, P1.Y, StrValue);
          Degrees := Degrees + Increment;
          CurValue := 0 + (IncValue*I);
        end
        else
        begin
          Degrees := Degrees + Increment;
          CurValue := 0 + (IncValue*I);
        end;
      end;
    end;
  end;

end;

procedure TfrmMainFCC.DrawCompas(aCnv: TCanvas);
var
  R: TRect;
  CenterComp: Winapi.Windows.TPoint;
  Points, Points2: array of Winapi.Windows.TPoint;
begin
  SetLength(Points, 3);
  SetLength(Points2, 3);
  CenterComp.X := imgCompas.Height div 2;
  CenterComp.Y := imgCompas.Width div 2;
  R := Rect(0,0, imgCompas.Height, imgCompas.Width);
//  aCnv.Brush.Style := bsClear;
  aCnv.Pen.Color := clYellow;
  acnv.Brush.Color := clBlack;

  //draw lingkaran luar
  aCnv.Ellipse(r.Left, r.Top, r.Right, r.Bottom);

  //draw segitiga north
  Points[0] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2) - 46, FNorthAngle + 270);
  Points[1] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2 - 15), FNorthAngle);
  Points[2] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2) - 46, FNorthAngle + 90);

  //draw segitiga south
  Points2[0] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2) - 46, FNorthAngle + 270);
  Points2[1] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2) - 15, FNorthAngle + 180);
  Points2[2] := Rotate(imgCompas.Width, imgCompas.Height, (imgCompas.Height div 2) - 46, FNorthAngle + 90);

//  aCnv.Brush.Style := bsSolid;
  acnv.Pen.Width := 2;
  acnv.Pen.Color := clRed;
  acnv.Brush.Color := clRed;
  acnv.Polygon(Points);

  acnv.Pen.Color := clWhite;
  acnv.Brush.Color := clWhite;
  acnv.Polygon(Points2);
end;

procedure TfrmMainFCC.DrawLine(Canvas: TCanvas; X1, Y1, X2, Y2: Integer;
  Color: TColor; Width: Integer);
begin
  Canvas.Pen.Color := Color;
  Canvas.Pen.Width := Width;
  Canvas.MoveTo(X1, Y1);
  Canvas.LineTo(X2, Y2);
end;

procedure TfrmMainFCC.FMapDrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Integer; const RectFull,
  RectInvalid: IDispatch);
begin
  FMapCanvas.Handle := hOutputDC;
  DrawAll(FMapCanvas, FMapConverter, FFlag);
end;

procedure TfrmMainFCC.FMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Sel: TRadarTargetSymbol;
begin
  if Button <> mbLeft then Exit;

  Sel := TargetMgr.SelectAt(X, Y);

  FMap.Refresh; // langsung repaint untuk tunjukkan kotak putih

  if Assigned(Sel) then
  begin
    // misalnya tampilkan info target
    // ShowMessage('Target terpilih: ' + Sel.TrackLabel);
  end;
end;

procedure TfrmMainFCC.FormCreate(Sender: TObject);
var
  n : Integer;
  T: TRadarTargetSymbol;
begin
  FCCManager := TFCCManager.Create;
  SimCenter := FCCManager;
  SimCenter.FMap := FMap;

  FCCManager.InitializeSimulation;

  FNorthAngle := 0;
  FMapCanvas         := TCanvas.Create;
  FMapConverter := TMapXUnitConverter.Create;
  FMapConverter.FMap := FMap;
  FIndexRange := 3;
  FCurrentRange := CRangeOperation[3];
  pnlMap12km.Color := clYellow;

  EnableComposited(pnlSituationZone);
  FBitmapBackground := TBitmap.Create;
  FBitmapBackground.Height := imgBackgrounSituationZone.Height;
  FBitmapBackground.Width := imgBackgrounSituationZone.Width;
  FBitmapBackground.Canvas.Brush.Color := clBlack; // new color
  FBitmapBackground.Canvas.FillRect(
   Rect(
     0,
     0,
     FBitmapBackground.Width,
     FBitmapBackground.Height
    )
  );

  imgBackgrounSituationZone.Picture.Assign(FBitmapBackground);
  imgCompas.Picture.Assign(FBitmapBackground);
  InitializeForm;
//  LoadGeoset('.\data\tcms_map\Indonesia.gst');
  LoadGeoset('.\data\maps\IndonesiaNoGrid.gst');
//  SimCenter.LoadGeoset('.\data\maps\IndonesiaNoGrid.gst');
  setRegionCircle;

//  FRangeRing := TRangeRingsVisual.Create;
//  FRangeRing.Color := clWhite;

  FRings := TRadarRangeRings.Create;

  // siapkan sectors (contoh sesuai gambar)
//  SetLength(FSectors, 4);
//  FSectors[0] := TRadarSector.Create(45, 30, RGB(255,60,80), True);   // merah bawah
//  FSectors[1] := TRadarSector.Create(330, 360, RGB(255,60,80), True);   // merah kanan atas
//  FSectors[2] := TRadarSector.Create(  0,  30, RGB(255,60,80), True);   // merah kiri atas
//  FSectors[3] := TRadarSector.Create(345,  15, RGB(130,130,130), True); // abu depan

  // Blind zone: dua sektor
  // contoh inisialisasi
  Self.FCurrentRange := 3000; // 3 km
  AreaBlindZone := TRadarDynamicSector.Create;
  AreaBlindZone.Color := RGB(183,73,40);
  AreaBlindZone.AddSlice(30,45, 0.0, 48000.0); // center–3 km
  AreaBlindZone.AddSlice(315,330,   0.0, 48000.0);

  AreaBlindZone1 := TRadarDynamicSector.Create;
  AreaBlindZone1.Color := RGB(94,90,105);
  AreaBlindZone1.AddSlice(330,30, 0.0, 48000.0); // dari 1–3 km

  AreaGunPoint := TRadarDynamicSector.Create;
  AreaGunPoint.Color := RGB(237,83,93);
  AreaGunPoint.AddSlice(165,195, 0.0, 48000.0); // dari 1–3 km

  AreaPenembakan := TRadarDynamicSector.Create;
  AreaPenembakan.Color := RGB(53,80,75);
  AreaPenembakan.AddSlice(45,315, 0.0, 6500.0); // dari 1–3 km

  AreaTracker := TRadarDynamicSector.Create;
  AreaTracker.Color := RGB(32,70,145);
  AreaTracker.AddSlice(45,315, 6500.0, 17000.0); // dari 1–3 km

  FNorthInd := TRadarNorthIndicator.Create;

  FShipHeading := 0; // awal

  FBearing0 := TRadarBearing.Create(0, clWhite, 'MR35');

  TargetMgr := TRadarTargetManager.Create;
  TargetMgr.CoordConverter := FMapConverter;

  T := TargetMgr.AddTarget(112.751, -7.199);
  T.SetFontSymbol('Segoe UI Symbol', '▲', clLime, clYellow, 10);
  T.TrackLabel := '001';

  T := TargetMgr.AddTarget(112.760, -7.210);
  T.CircleRadius := 3;                       // fallback circle
  T.TrackLabel   := '002';

  n := ParamCount ;
  if n < max_param then
  begin
    FCCManager.IsStandAlone := true ;
  end;

end;

procedure TfrmMainFCC.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
//  FRangeRing.Free;
  FNorthInd.Free;
  FBearing0.Free;

  AreaGunPoint.Free;
  AreaBlindZone1.Free;
  AreaTracker.Free;
  AreaBlindZone.Free;
  AreaPenembakan.Free;

  FRings.Free;

  FMapCanvas.Free;

  FCCManager.Free;
end;

procedure TfrmMainFCC.FormPaint(Sender: TObject);
begin
  DrawAngle(imgBackgrounSituationZone.Canvas);
  DrawCompas(imgCompas.Canvas);
end;

procedure TfrmMainFCC.imgCompasClick(Sender: TObject);
begin
  if Assigned(FCCManager) then
  begin
    FCCManager.IsTrueMotion := not FCCManager.IsTrueMotion;
  end;
end;

procedure TfrmMainFCC.InitializeForm;
begin
  // light from image list
  //  0 grey
  //  1 green
  //  2 red
  //  3 grey
  //  4 green
  //  5 red
  //  6 yellow

  //  initialize panel indikator control state
  imgListLight.GetBitmap(1, imgCtrlStateFCC.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgCtrlStateTracked.Picture.Bitmap);
  imgListLight.GetBitmap(0, imgCtrlStateDataReady.Picture.Bitmap);
  imgListLight.GetBitmap(0, imgCtrlStateAimed.Picture.Bitmap);
  imgListLight.GetBitmap(2, imgCtrlStateLimitZone.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgCtrlStateFireAllow.Picture.Bitmap);
  imgListLight.GetBitmap(0, imgCtrlStateFiring.Picture.Bitmap);

  //  initialize panel indikator Gun state
  imgListLight.GetBitmap(1, imgGunStateCtrlBy.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgGunStateServo.Picture.Bitmap);
  imgListLight.GetBitmap(0, imgGunStateFC.Picture.Bitmap);
  imgListLight.GetBitmap(0, imgGunStateReturnZero.Picture.Bitmap);

  //  initialize panel indikator Bite Device state
  imgListLight.GetBitmap(1, imgBiteDvcStateFCC.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgBiteDvcState730B.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgBiteDvcStateEO.Picture.Bitmap);
  imgListLight.GetBitmap(2, imgBiteDvcStateTR.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgBiteDvcStateTCC.Picture.Bitmap);
  imgListLight.GetBitmap(2, imgBiteDvcStateSIE.Picture.Bitmap);
  imgListLight.GetBitmap(1, imgBiteDvcStateSR.Picture.Bitmap);
end;

procedure TfrmMainFCC.LoadGeoset(const aGst: string);
var i: integer;
  z: OleVariant;
  mInfo : CMapXLayerInfo;
begin

  InitOleVariant(z);
  FMap.Layers.RemoveAll;

  if (aGst <> '') and  FileExists(aGst) then begin
    FMap.Geoset := aGst;
    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw ;
    mInfo.AddParameter('Name', 'Animation');
    FLyrDraw := FMap.Layers.Add(mInfo, 1);
    FMap.Layers.AnimationLayer := FLyrDraw;
    FMap.BackColor := CBackgroundMapColor;
    FMap.MapUnit := miUnitNauticalMile;
    FMap.CenterX := 112.75;
    fmap.CenterY := -7.2;
    FMap.ZoomTo((Self.FCurrentRange  * C_Meter_To_NauticalMile) * 2, FMap.CenterX, FMap.CenterY);
  end
end;

function TfrmMainFCC.MeterHeight: Integer;
begin
  Result := FMap.Height;
end;

function TfrmMainFCC.MeterWidth: Integer;
begin
  Result := FMap.width;
end;

procedure TfrmMainFCC.pnlMapRangeClick(Sender: TObject);
begin
  ResetColorRange;
  TPanel(Sender).Color := clYellow;

  Self.FIndexRange := TPanel(Sender).Tag;
  self.FCurrentRange := CRangeOperation[TPanel(Sender).Tag];
  FMap.ZoomTo((Self.FCurrentRange  * C_Meter_To_NauticalMile) * 2, FMap.CenterX, FMap.CenterY);
end;

procedure TfrmMainFCC.ResetColorRange;
begin
  pnlMap1point5km.Color := clAqua;
  pnlMap3km.Color := clAqua;
  pnlMap6km.Color := clAqua;
  pnlMap12km.Color := clAqua;
  pnlMap24km.Color := clAqua;
  pnlMap48km.Color := clAqua;
end;

function TfrmMainFCC.Rotate(Width, Height, Radius: Integer;
  Degrees: Double): Winapi.Windows.TPoint;
var
  Angle: Double;
  W, H: Integer;
//  HeadingView : THeadingRadarView;
begin
//  if Assigned(NavSimCenter.NAV_Radar.HeadingView) then
//  begin
//   HeadingView := uRadarNavManager.NavSimCenter.NAV_Radar.getHeadingLine;
//   if HeadingView.HeadingMode = sbmCourseUp then
//   begin
//       Angle := HeadingView.Heading;
//       if Angle < 0 then Angle := CBaseAngle - Angle;
//       Angle := CBaseAngle - Angle;
//       Angle := ConvCompass_To_Cartesian(Angle);
//       Angle := ConvCustomAngleStart(degrees,Angle);
//       Angle := Angle*C_DegToRad;
//   end
//   else
//   //if HeadingView.HeadingMode = sbmCourseUp then
//      Angle  := ConvCartesian_To_Compass(Degrees)*C_DegToRad;
//  end
//  else
     Angle := ConvCartesian_To_Compass(Degrees)*C_DegToRad;

  W := Width div 2;
  H := Height div 2;
  Result.X := W + Round(Cos(Angle) * Radius);
  Result.Y := H + Round(Sin(Angle) * Radius);
  Result.Y := (H * 2) - Result.Y;
end;

procedure TfrmMainFCC.setRegionCircle;
const brd = 30;
var eRgn: HRGN;
    r : TRect;
    rcxMap, rcyMap: integer;
    left,top,right,bottom : Integer;
    diffBeetwinWH : Integer;  //differnt beetwin width and height width - height, kemudian dibagi dua sebagai batas left dan right,supaya lingkarannya tetap center.
begin
  rCXMap := FMap.Width  shr 1;
  rCYMap := FMap.Height shr 1;

//  r := Rect(222,50, FMap.Height + 110, FMap.Height - 50);
  diffBeetwinWH := (pnlSituationZone.Width - pnlSituationZone.Height) div 2;

  top := 50;
  bottom := pnlSituationZone.Height - top;
  left := diffBeetwinWH + top;
  right := pnlSituationZone.Width - left;

  FCircleRect  := Rect(left,top, right, bottom);

  eRgn := CreateEllipticRgn(FCircleRect.Left, FCircleRect.Top, FCircleRect.Right, FCircleRect.Bottom);
  SetWindowRgn(FMap.Handle, eRgn, true);

  // center & radius dalam koordinat FMap (DC yang dipakai DrawUserLayer)
  FCircleCX := (FCircleRect.Left + FCircleRect.Right) div 2;
  FCircleCY := (FCircleRect.Top  + FCircleRect.Bottom) div 2;
  FCircleR  := (FCircleRect.Right - FCircleRect.Left) div 2;

  //global Form Koord
  rCx := rcxMap - FMap.Left;
  rCy := rCYMap + FMap.Top;
end;

procedure TfrmMainFCC.tmrUpdateFormTimer(Sender: TObject);
begin
//  if FNorthAngle < 360 then
//    Inc(FNorthAngle)
//  else
//    FNorthAngle := 0;

  imgCompas.Repaint;

  lblBiteTimeSystemValue.Caption := FormatDateTime('hh:nn:ss',now);

  if not FCCManager.IsTrueMotion then begin
    Fmap.CenterX := FCCManager.xShip.PositionX;
    Fmap.CenterY := FCCManager.xShip.PositionY;
//    FMap.Rotation := 0;
    FNorthAngle := 0;
  end
  else
  begin
    FNorthAngle := -FCCManager.xShip.Heading;;
//    FMap.Rotation := -FCCManager.xShip.Heading;
  end;
end;

procedure TfrmMainFCC.tmrUpdateHeadingTimer(Sender: TObject);
begin
  if Assigned(FCCManager) then
  begin
    if Assigned(FCCManager.xShip) then
    begin
      FCCManager.xShip.Heading := FCCManager.xShip.Heading + 1;
    end;
  end;
end;

end.
