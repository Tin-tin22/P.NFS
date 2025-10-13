unit uLibWCCClassNew;

interface

uses Dialogs, Classes, Windows, Graphics, Forms,  MapXLib_TLB, uMapWindow,
    uLibTDCClass, uLibTDCDisplay, uTDCConstan, uDetected, uLibTDCTracks,
    uBaseSimulationObject, uTCPDatatype, uBaseDataType, Math,
    uLibWCCku, uBaseConstan, uTestShip, ufLog, uLibTDC_Object,
    ufKoreksi, uDataModule, uLibClientObject;

type
  TTMADType = (ttAPD, ttBDD, ttERBD1, ttERBD2, ttERPD);
  TFireModeWCC = (fDirectBomb, fBlindBomb, fIndBomb);

  tbrData = record
    b, r: double;
  end;

  TBallisticData = record
    MuzzleVelocity,
    BarometricPressure,
    AirTemperature,
    Humidity,
    WindSpeed,
    OwnSpeed,
    TargetSpeed : double;

  end;

  TGenericWCCInterface = class(TGenericTDCInterface)
  protected
    // elev mark
    EMarkHeading: integer;
    EFlag: boolean;
    EMarkMax, EMarkMin: integer;

    FBallData1, FBallData2, FBallData3 : TBallisticData;

    procedure SetEMarkFlag(const val: boolean);
    procedure TOMarker_SetPosition(const r, b: double);

    procedure GetRandomPosition(var x, y, z: double);
    procedure GetRandomSpeedCourse(var s, c: double; const tipe: TSIMType);

  public
     // panel WCC
    frmWCCAtas1   : TForm;
    frmWCCAtas2   : TForm;
    frmWCCBawah1  : TForm;
    frmWCCBawah2  : TForm;
    frmScopeA     : TForm;
    frmScopeB     : TForm;
    frmQEK        : TForm;
    frmAnduNala   : TForm;
    frmBackground : TForm;

    //Console     : TWcc;
    //ColorButton : TBtnCol;

    constructor Create;
    destructor Destroy; override;

    procedure ConvertViewPosition;
    procedure Draw(aCnv : TCanvas); virtual;

    procedure Run(aDt: double);

    procedure Initialize; virtual;

    procedure ShowAllForm(const aShipClassID : integer); virtual;
    function FindToBeDeletedTrack(var IsNew: boolean; var indx: Integer): boolean;

    // ring dimmer
    procedure DrawAngle(aCnv:TCanvas);
    function MeterWidth: Integer;
    function MeterHeight: Integer;
    function WDiv2: Integer;
    function HDiv2: Integer;
    procedure RotateVarXY(Width, Height, Radius: Integer; Degrees: Double ; var sx, sy : integer );
    //function Rotate(Width, Height, Radius: Integer; Degrees: Double): TPoint;
    procedure DrawLine(Canvas: TCanvas; X1, Y1, X2, Y2: Integer;Color: TColor; Width: Integer);

  public
    // Object yg akan dikendalikan WCC
    // ListWeaponAssigned : TList;
    // TScenarioWeapon;
    MslNumb : Integer;
    ActiveGUN, Gun1, Gun2, Gun3: TGun;
    TGM_Marker  : TTDC_Symbol; // Tracking Gate Marker
    SIM_Marker  : TTDC_Symbol;
    EMark       : TElevationMark;
    IsTGMMoveable: boolean;
    OffsetPoint_Marker  : TTDC_Symbol;
    IndBombData : tbrData;

    WCCAndu: TAnduWCC;
    ModulKoreksi: TFrmKoreksi;

    Gun1Pressed, Gun2Pressed, Gun3Pressed : boolean;
    ActiveFC    : TFireControl;

    //  Display simbol

    IsRRNF_on,
    IsRadarError,
    IsCompError,
    IsRPC_on,
    IsRDY_RH_MAG_on,
    IsRDY_LH_MAG_on,
    IsGun2Syn,
    IsGun3Syn : Boolean;                   // untuk setting alat dari Instruktur

    SIMObject_ship1, SIMObject_ship2 : TXShip;    // Simulation Object ship

    procedure TGM_Reset;
    procedure TGM_SetPosition(const x, y: integer);
    procedure SIM_SetPosition(const x, y: double);
    procedure SetEmarkHeading;
    procedure SetEMarkConstraint(const min, max: integer);
    property EMarkFlag: boolean read EFlag write SetEMarkFlag;

    function ThrowOffMode(const pos: integer): boolean;
    procedure SetAssign_OnThrowOff(GunID : byte);

    function TestBlindArc(const Gun: byte; const Tgt: TManualTrack): boolean;
    function CekGunStatus: boolean; // blind, inrange

    function  AssignGunToFC(const Gun_ID, FCID: byte; const send: boolean= TRUE): boolean;
    function  DeAssignGun(const Gun_ID, FCID: byte; const send: boolean= TRUE): boolean;
    procedure DeassignActiveGun;


    procedure tes(const Id : byte);

    procedure ShowBScope(FCID: byte; const aShow, status: boolean);
    procedure SetBScopeMarkerPos(const x,y: double);
    function  GetBScopeMarkerPosX: double;
    function  GetBScopeMarkerPosY: double;
    procedure ShowAScope(const stat: ATOStat);

    //function WCC_FireGun(const Gun: byte): integer; // return TOF

    procedure SetRadarOnOff(const bOke: boolean);

    function DoBlindBomb: boolean;
    function unDoBlindBomb: boolean;
    function DoGenFix(const tFCID: byte): boolean;
    function DoIndirectBomb: boolean;
    function unDoIndirectBomb: boolean;

    procedure OffsetPoint_SetPosition(const x, y: double);

    procedure ShowSplash(TheGun: TGun; const IsShown: boolean);
    procedure ShowPHP(TheGun: TGun; const IsShown: boolean);
//    procedure ClearPHPandSplash(TheGun: TGun);
    procedure DoGunCorrection(TheGun: TGun);

    procedure SystemReset;
    procedure CreateSIMObject(const IsCreating: boolean);
    procedure ClearSIMObject;

    //procedure GetAnduData(const aFC: byte; var aData: TFireControlData);
    function IsFireControlInUse(const aFC: byte): boolean;

    function GetAnduIndex(const aCode: string): byte;
    procedure UpdateAnduData;

  protected
    //TheLog : TStringList;

    procedure InsertIntoPage2(const indx: integer);

    function CekDataBalistik: boolean;
    procedure WCC_FireGunLagi(const GunNumber: byte);

    procedure SetGunReady;

  public
    procedure RunGun(const aDeltaMs: double);

    function InRangeToFire(TargetPosX,TargetPosY:Double; GunType:byte): Boolean;

    procedure GetPHP(GunNumb:byte;  var X,Y,Z :Double);
    function  GetWeaponID(Gun_ID: word):word;
    function  GetGUN_by_ID(Gun_ID: word):TGun;
    function  GetModeID_Fire(TheGun : TGUN):byte;
    procedure StartCannonFire(Gun_ID : word);
    procedure StopCannonFire(Gun_ID : word);

    Procedure GetGunTOFfromDb(Gun_numb :integer; hpX, hpY, hpZ : Double);
    procedure Update_OnAnduChange(Sender: TObject);
    procedure Correction_OnAnduChange(Sender: TObject);
    procedure DoCorrection_OnAnduChange(const Gun_ID, Mode : byte);

    procedure DoCorrectionInDirAndBlindBomb(TheGun: TGun; var Brg, Elv: double);
    procedure DoCorrectionManDirBomb(TheGun: TGun; var Brg, Elv: double);
    procedure DoCorrectionAutoDirBomb(TheGun: TGun;var Corr_Training, Corr_Elev: Double);
    procedure DoCorrectionDirectBomb(TheGun: TGun;var Corr_Training, Corr_Elev: Double);


    procedure LineCorrection(var oX, oY: double; GunNum : word);
    procedure RangeCorrection(var oX, oY: double; GunNum : word);

    function FindTOFandPHPpoint(Gun_numb: Word; TgtCourse, TgtSpeed:Single;
       var oX, oY, oZ: Double): Single;
    Function GetTOF(Gun_numb :Word; X1,Y1,X2,Y2,Z2: Double): Single;
    procedure CalcHitPredition(const tRange, tBearing, tSpeed, tCourse: double;
       const pSpeed: double;
       var hRange, hBearing, hTime, hSpeed: double);
    procedure Erasesplash(IdGun:Integer);
    procedure ShowSplasFrom3D(Rec : TRecSplashCannon);
    procedure RecvWCCSettingConsole(aRec: TRecStatus_Console);

    procedure DeleteAllTrack;
    procedure SetTrackShown(Isvisible : boolean);
    procedure SendEvenWCC_120mm(EvenId: Word; const Prm1 :double = 0; Prm2 : double = 0; Prm3: double = 0);
  end;
const  C_RangeBTK_InMetter = 20;
       g120mm = 1;
       g40mm = 2;

implementation

uses
  SysUtils,
  Types,
  uSimulationManager,
  uBaseFunction,
  uBaseGraphicProc,
  ufWCCTengah,
  ufAScope,
  ufBScope,
  uLibRadar,
  uMapXFunction,
  uBScopeBaseDisplay,
  uRadarTracks,
  ufWCCPanelAtas2,
  ufWCCPanelAtas,
  ufWCCPanelBawah2,
  uAnduNala,
  StdCtrls;
  //, uBaseCoordSystem;

function UniqueID_To_dbID(const uid: string): integer;
var s: string;
begin
  s := Copy(uid, 4, Length(uid)-3);
  try
    result := StrToIntDef(Trim(s),0);
  except
    on EConvertError do begin
      result := 0;
      exit;
    end
  end;
end;

//****************************************************************************//
constructor TGenericWCCInterface.Create;
begin
  inherited;
  MslNumb := 0;
  DisplaySymbols[i_Gerbang_Pelacakan].Visible := TRUE;
  TGM_Marker := DisplaySymbols[i_Gerbang_Pelacakan];  // alias
  TGM_Marker.Visible := False;

  DisplaySymbols[i_Sasaran_simulasi_tes].Visible := TRUE;
  SIM_Marker := DisplaySymbols[i_Sasaran_simulasi_tes];  // alias
  SIM_Marker.Visible := True;

  EMark := TElevationMark.Create;
  EMark.Visible := True;

  Cursorss.Visible := False;
  EMarkHeading := 270;
  SetEMarkConstraint(C_EMarkMin, C_EMarkMax);

  DisplaySymbols[i_ThrowOff].Visible := TRUE;
  ThrowOff_Marker := DisplaySymbols[i_ThrowOff];  // alias
  ThrowOff_Marker.Visible := false;

  DisplaySymbols[i_Offset_BTK].Visible := TRUE;
  OffsetPoint_Marker := DisplaySymbols[i_Offset_BTK];  // alias
  OffsetPoint_Marker.Visible := false;

  WCCAndu := TAnduWCC.Create;
  ModulKoreksi := TFrmKoreksi.Create(nil);

  frmLog.Hide;

//  ListWeaponAssigned := TList.Create;

end;

destructor TGenericWCCInterface.Destroy;
//var i: integer;
begin
  inherited;

  EMark.Free;
//  ListWeaponAssigned.Free;

end;

procedure TGenericWCCInterface.ConvertViewPosition;
begin
  inherited;
  {ConvertMembersViewsPosition(TrackList);

  OBMLeft.Center  := ConvertToScreen(OBMLeft.mPos.X, OBMLeft.mPos.Y);
  OBMRight.Center := ConvertToScreen(OBMRight.mPos.X, OBMRight.mPos.Y);}
  SIM_Marker.Center := ConvertToScreen(SIM_Marker.mPos.X, SIM_Marker.mPos.Y);
  TGM_Marker.Center := ConvertToScreen(TGM_Marker.mPos.X, TGM_Marker.mPos.Y);
  ThrowOff_Marker.Center := ConvertToScreen(ThrowOff_Marker.mPos.X, ThrowOff_Marker.mPos.Y);
  OffsetPoint_Marker.Center := ConvertToScreen(OffsetPoint_Marker.mPos.X, OffsetPoint_Marker.mPos.Y);
end;

procedure TGenericWCCInterface.Update_OnAnduChange(Sender: TObject);
var Gun_ID, Mode_ID  : Byte;
    str : string;
    I: Integer;
begin
  Mode_ID := 0;
  Mode_ID := Tedit(Sender).Tag;
  case Mode_ID of
    3 : begin

    if Assigned(ActiveGUN) and (ActiveGUN.ID <> 0) and (ActiveGUN.IsAssigning) then begin
       unDoBlindBomb;
       DoBlindBomb;
    end;

    end;

    4 : begin
    if Assigned(ActiveGUN) and (ActiveGUN.ID <> 0) and (ActiveGUN.IsAssigning) then begin
       unDoIndirectBomb;
       DoIndirectBomb;
    end;
    end;
    0 : Exit;
  end;

end;


procedure TGenericWCCInterface.Correction_OnAnduChange(Sender: TObject);
var Gun_ID, Mode_ID  : Byte;
    str : string;
    I: Integer;
begin
  Gun_ID := 1;
  Mode_ID := Tedit(Sender).Tag;
  if Mode_ID = 1 then begin                             {Koreksi Andu DirectBomb}
    str := Tedit(Sender).Name;
    Gun_ID  := StrToInt(Copy(str ,length(str) , 1));
  end;
  DoCorrection_OnAnduChange(Gun_ID, Mode_ID);
end;

procedure TGenericWCCInterface.Draw(aCnv: TCanvas);
var detObj: TDetectedObject;
begin
  inherited;

  EMark.ConvertCoord(frmTengah.Map);
  EMark.Draw(aCnv);
end;

procedure TGenericWCCInterface.Run(aDt: double);
var ptShip: t2DPoint;
begin
  inherited;

  ptShip.X := xShip.PositionX;
  ptShip.Y := xShip.PositionY;

  EMark.Org := ptShip;
  EMark.Distance := FTDCRangeScale;

  OffsetPoint_Marker.Visible := FC2.IsDoingIndBomb;
  if (FC2.TrackedTarget <> nil) and (FC2.IsDoingIndBomb) then begin
    //hitung new bearing and range
    IndBombData.b := RoundTo(CalcBearing(FC2.TrackedTarget.PositionX, FC2.TrackedTarget.PositionY, OffsetPoint_Marker.mPos.X, OffsetPoint_Marker.mPos.Y), 0);
    IndBombData.r := RoundTo(CalcRange(FC2.TrackedTarget.PositionX, FC2.TrackedTarget.PositionY, OffsetPoint_Marker.mPos.X, OffsetPoint_Marker.mPos.Y) * C_NauticalMiles_To_Yard, 0);
  end;

  RunGun(aDt);
end;

procedure TGenericWCCInterface.Initialize;
begin
  inherited;
    
//  SetRadarOnOff(False);
  EMark.Heading := EMarkHeading;
end;


procedure TGenericWCCInterface.ShowAllForm(const aShipClassID : integer);
begin
  case aShipClassID of
    C_ShipC_Cakra: begin
      if Assigned( frmWCCBawah2 ) then frmWCCBawah2 .Show;
      if Assigned( frmWCCBawah1 ) then frmWCCBawah1 .Show;
      if Assigned( frmWCCAtas2  ) then frmWCCAtas2  .Show;
      if Assigned( frmWCCAtas1  ) then frmWCCAtas1  .Show;
      //if Assigned( frmTMAD      ) then frmTMAD      .Show;
    end;
    C_ShipC_Fatahillah : begin
      if Assigned( frmScopeA    ) then frmScopeA    .Show;
      if Assigned( frmScopeB    ) then frmScopeB    .Show;
//      if Assigned( frmWCCBawah2 ) then frmWCCBawah2 .Show;
//      if Assigned( frmWCCBawah1 ) then frmWCCBawah1 .Show;
      if Assigned( frmWCCAtas2  ) then frmWCCAtas2  .Show;
      if Assigned( frmWCCAtas1  ) then frmWCCAtas1  .Show;
      if Assigned( frmBackground) then frmBackground.Show;

    end;
    else
      if Assigned( frmScopeA    ) then frmScopeA    .Show;
      if Assigned( frmScopeB    ) then frmScopeB    .Show;
  //    if Assigned( frmWCCBawah2 ) then frmWCCBawah2 .Show;
  //    if Assigned( frmWCCBawah1 ) then frmWCCBawah1 .Show;
      if Assigned( frmWCCAtas2  ) then frmWCCAtas2  .Show;
      if Assigned( frmWCCAtas1  ) then frmWCCAtas1  .Show;
      if Assigned( frmBackground) then frmBackground.Show;

  end;
  if Assigned( frmTengah      ) then frmTengah    .Show;

end;

function TGenericWCCInterface.FindToBeDeletedTrack(var IsNew: boolean; var indx: Integer): boolean;
var i: integer;
    list: TList;
    aMtrack: tManualTrack;
begin
  list := TrackList.GetList;

  i := list.Count-1;
  result := FALSE;
  IsNew := True;
  while not result and (i>=0) do begin
    aMtrack := list.Items[i];
    result := (aMtrack.IsNewlyCreated = True)
        and (aMtrack.HasBeenTracked = True);
    indx := i;
    dec(i);
  end;

  if not Result then begin
    indx := -1;
    i := list.Count-1;
    IsNew := False;
    while not result and (i>=0) do begin
      aMtrack := list.Items[i];
      result := (aMtrack.HasBeenTracked = True);
      indx := i;
      dec(i);
    end;
  end;
  TrackList.ReturnList;
  if not result then indx := -1;
end;



//****************************************************************************//
{function TGenericWCCInterface.FindDetObjectByUid(const aUid: string): Integer;
var i   : integer;
    obj : TSimulationClass;
    found : boolean;
    list: TList;
begin
  list := SimCenter.MainObjList.GetList;

  result := -1;
  //obj := nil;
  i := 0;
  found  := false;
  while not found and (i<list.Count) do begin
    obj := list.Items[i];
    found :=  aUid = obj.UniqueID;
    if found then result := i;
    inc(i);
  end;
end;  }
//****************************************************************************//
procedure TGenericWCCInterface.DrawAngle(aCnv:TCanvas);
var
  R: TRect;
  P1, P2: TPoint;
  I: Integer;
  Increment: Double;
  Degrees: Double;
  Size: Integer;
  Enlarge: Integer;
  Point1: Double;
  Point2: Double;
  CurValue: Double;
  Mask: string;
  StrValue, S: string;
  IncValue: Double;
  StartAngle: Integer;
  EndAngle: Integer;
  ZoneRadius: Integer;
  AngleRadius: Integer;
  Y, TW, TH: Integer;


  ticksMax,ticks,ticksEnlarge,ticksMin :integer;
  ticksColor : TColor;
  labels,decimals,labelsoffset,needleBaseWidth : integer;
  labelsfont : TFont;
  Angle : integer;
  AngleOffset,BaseAngle : integer;
begin

  Angle := 0;
  baseAngle := 360;
  AngleOffset := 360;
  labelsfont := TFont.Create();
  //labelsfont.Color := rgb(85,170,255);//cllime;
  labelsfont.Color := clRed;
  labelsfont.Size := 10;
  StartAngle := BaseAngle + Angle;
  EndAngle := BaseAngle + Angle+AngleOffset;
  Point1 := StartAngle + (AngleOffset *(60*0.01));
  Point2 := Point1 + (AngleOffset *(25*0.01));
  with aCnv do
  begin
    //Pen.Color := rgb(85,170,255);//clblack;
    Pen.Color := clRed;
    //Brush.Color := RGB(0,40,100);//clblack;
    Brush.Color := clGray;
    R := Rect(0,0, frmtengah.Map.Width, frmtengah.Map.Height);
    AngleRadius := (R.right - R.left) div 2;
    ticksmax := 16;
    ticks := 360;
    ticksEnlarge := 5;
    ticksMin := 8;
    //ticksColor := rgb(85,170,255);//cllime;
    ticksColor := clRed;
    labels := 36;
    decimals := 0;
    labelsoffset := 30;
    needleBaseWidth := 8;
                                    
    {jarum derajat}

    if Ticks >= 1 then
    begin
      Enlarge := TicksEnlarge;
      Degrees := StartAngle;
      Increment := AngleOffset/Ticks;
      for I := 1 to Ticks + 1 do
      begin
        if (Enlarge mod TicksEnlarge = 0) then
          Size := TicksMax else Size := TicksMin;
        Inc(Enlarge);
        { change by sam
          [DCC Error] uLibWCCClassNew.pas(437): E2010 Incompatible types: 'Types.TPoint' and 'MapXLib_TLB.TPoint'
          P1 := Rotate(MeterWidth, MeterHeight, AngleRadius, Degrees);
        P2 := Rotate(MeterWidth, MeterHeight, AngleRadius + Size, Degrees); }
        RotateVarXY(MeterWidth, MeterHeight, AngleRadius, Degrees, P1.X, P1.Y);
        RotateVarXY(MeterWidth, MeterHeight, AngleRadius + Size, Degrees, P2.X, P2.Y);

        DrawLine(aCnv, P1.X, P1.Y, P2.X, P2.Y, TicksColor, 1);
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
      //Mask := '%d';
      for I := 1 to Labels  do
      begin
        { change by sam
          [DCC Error] uLibWCCClassNew.pas(437): E2010 Incompatible types: 'Types.TPoint' and 'MapXLib_TLB.TPoint'
          P1 := Rotate(MeterWidth, MeterHeight, AngleRadius + LabelsOffset, Degrees); }
        RotateVarXY(MeterWidth, MeterHeight, AngleRadius + LabelsOffset, Degrees, P1.X, P1.Y);
        if strlen(pchar(floattostr(CurValue))) <= 2 then
          begin
          if curValue = 0 then
             StrValue := '00'+Format(Mask, [CurValue])
          else
             StrValue := '0'+Format(Mask, [CurValue]);
          end
        else
          StrValue := Format(Mask, [CurValue]);
        P1.X := P1.X - TextWidth(StrValue) div 2;
        P1.Y := P1.Y - TextHeight(StrValue) div 2;
        TextOut(P1.X, P1.Y, StrValue);
        Degrees := Degrees + Increment;
        CurValue := 0 + (IncValue*I);
      end;
    end;
  end;
end;

function TGenericWCCInterface.MeterWidth: Integer;
begin
    Result := frmTengah.Map.width + 2 * frmTengah.Map.Left;
end;

function TGenericWCCInterface.MeterHeight: Integer;
begin
    Result := frmTengah.Map.Height + 2 * frmTengah.Map.top;
end;

function TGenericWCCInterface.WDiv2: Integer;
begin
  Result := MeterWidth div 2;
end;

function TGenericWCCInterface.HDiv2: Integer;
begin
  Result := MeterHeight div 2;
end;

procedure TGenericWCCInterface.RotateVarXY(Width, Height, Radius: Integer; Degrees: Double ; var sx, sy : integer );
var
  Angle: Double;
  W, H: Integer;
begin
  Angle := (Degrees * pi) / 180;
  W := Width div 2;
  H := Height div 2;
  sx := W + Trunc(Sin(Angle) * Radius);
  sy := H + Trunc(Cos(Angle) * Radius);
  sy := Trunc(H * 2) - sy;
end;

{
function TGenericWCCInterface.Rotate(Width, Height, Radius: Integer; Degrees: Double): TPoint;
var
  Angle: Double;
  W, H: Integer;
begin
  Angle := (Degrees * pi) / 180;
  W := Width div 2;
  H := Height div 2;
  Result.X := W + Trunc(Sin(Angle) * Radius);
  Result.Y := H + Trunc(Cos(Angle) * Radius);
  Result.Y := (H * 2) - Result.Y;
end;
}

procedure TGenericWCCInterface.DrawLine(Canvas: TCanvas; X1, Y1, X2, Y2: Integer;
  Color: TColor; Width: Integer);
begin
  Canvas.Pen.Color := Color;
  Canvas.Pen.Width := Width;
  Canvas.MoveTo(X1, Y1);
  Canvas.LineTo(X2, Y2);
end;
procedure TGenericWCCInterface.Erasesplash(IdGun: Integer);
var Thegun : Tgun;
begin
  Thegun := GetGUN_by_ID(IdGun);
  TfrmBScope(frmScopeB).ShowSplashPoint(Thegun.PosBeforeCorr.X, Thegun.PosBeforeCorr.Y, IdGun , false);
end;

//****************************************************************************//
procedure TGenericWCCInterface.TGM_SetPosition(const x, y: integer);
begin
  DisplaySymbols[i_Gerbang_Pelacakan].Center.X := x;
  DisplaySymbols[i_Gerbang_Pelacakan].Center.Y := y;
  DisplaySymbols[i_Gerbang_Pelacakan].mPos := ConvertToMap(x, y);
end;

procedure TGenericWCCInterface.TGM_Reset;
var
  p: TPoint;
  dpt : t2DPoint;
  dRad: Extended;
  sinx, cosx: Extended;
begin
  Randomize;
  dRad := C_DegToRad * ConvCompass_To_Cartesian(random(360));
  SinCos(dRad, sinx, cosx);

  dpt.X := xShip.PositionX + (FTDCRangeScale - 0.25) * C_NauticalMile_To_Degree * cosx;
  dpt.Y := xShip.PositionY + (FTDCRangeScale - 0.25) * C_NauticalMile_To_Degree * sinx;

  p := ConvertToScreen(dpt.X, dpt.Y);
  TGM_Marker.Center := p;
  TGM_Marker.mPos := ConvertToMap(p.x, p.y);

  {DisplaySymbols[i_Gerbang_Pelacakan].mPos.X  := xShip.PositionX;
  DisplaySymbols[i_Gerbang_Pelacakan].mPos.Y  := xShip.PositionY;
  DisplaySymbols[i_Gerbang_Pelacakan].Center :=
    ConvertToScreen(DisplaySymbols[i_Gerbang_Pelacakan].mPos.X,
                    DisplaySymbols[i_Gerbang_Pelacakan].mPos.Y)}
end;

procedure TGenericWCCInterface.SIM_SetPosition(const x, y: double);
var
  p: TPoint;
  dpt : t2DPoint;
  dRad: Extended;
  sinx, cosx: Extended;
begin
  dRad := C_DegToRad * ConvCompass_To_Cartesian(C_SIM_BEARING);
  SinCos(dRad, sinx, cosx);

  dpt.X := x + C_SIM_RANGE * C_NauticalMile_To_Degree * cosx;
  dpt.Y := y + C_SIM_RANGE * C_NauticalMile_To_Degree * sinx;

  p := ConvertToScreen(dpt.X, dpt.Y);
  SIM_Marker.Center := p;
  SIM_Marker.mPos := dpt;    
end;

procedure TGenericWCCInterface.SetEmarkHeading;
begin
  if EFlag then begin
    Inc(EMarkHeading,1);
    if EMarkHeading > EMarkMax then EFlag := not EFlag;
  end
  else begin
    Dec(EMarkHeading,1);
    if EMarkHeading < EMarkMin then EFlag := not EFlag;
  end;
  
  EMark.Heading := EMarkHeading;
end;

procedure TGenericWCCInterface.SetEMarkConstraint(const min, max: integer);
begin
  EMarkMin := min;
  EMarkMax := max;
end;

procedure TGenericWCCInterface.SetEMarkFlag(const val: boolean);
begin
  EFlag := val;
end;

procedure TGenericWCCInterface.TOMarker_SetPosition(const r, b: double);
var
  p: TPoint;
  dpt : t2DPoint;
  dRad: Extended;
  sinx, cosx: Extended;
begin
  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  dpt.X := xShip.PositionX + r * C_NauticalMile_To_Degree * cosx;
  dpt.Y := xShip.PositionY + r * C_NauticalMile_To_Degree * sinx;

  p := ConvertToScreen(dpt.X, dpt.Y);
  ThrowOff_Marker.Center := p;
  ThrowOff_Marker.mPos := dpt;
end;

function TGenericWCCInterface.ThrowOffMode(const pos: integer): boolean;
var r, b, bTgt: double;
begin
  result := False;
  if pos = 2 then
    ThrowOff_Marker.Visible := False
  else begin
    ThrowOff_Marker.Visible := True;
    bTgt := CalcBearing(xShip.PositionX, xSHIP.PositionY, FC2.TrackedTarget.PositionX, FC2.TrackedTarget.PositionY);
    case pos of
      0: b := bTgt - 12;
      1: b := bTgt - 6;
      3: b := bTgt + 6;
      4: b := bTgt + 12;
    end;
    b := ValidateDegree(b);
    r := CalcRange(xShip.PositionX, xSHIP.PositionY, FC2.TrackedTarget.PositionX, FC2.TrackedTarget.PositionY);

    TOMarker_SetPosition(r, b);
    result := True;
  end;

  FC2.ThrowOff := Result;

   if Assigned(ActiveGUN) then
     if ActiveGUN.IsAssigning then
      SetAssign_OnThrowOff(ActiveGUN.ID);
end;

//****************************************************************************//
function TGenericWCCInterface.CekGunStatus;
var r, b: double;
begin
  SIM_Marker.Visible := TrackList.ItemCount = 0;

  if (Gun1.AssignTo <> nil) and (Gun1.AssignTo.Name <> 'FC4') and (Gun1.AssignTo.TrackedTarget <> nil) then begin
    Gun1.IsBlind := self.TestBlindArc(1, Gun1.AssignTo.TrackedTarget);
    Gun1.IsInRange := (CalcRange(xSHIP.PositionX, xSHIP.PositionY, Gun1.AssignTo.TrackedTarget.PositionX,
      Gun1.AssignTo.TrackedTarget.PositionY) < C_GUN1_RANGE);
  end
  else begin
    Gun1.IsBlind := False;
    Gun1.IsInRange := False;
  end;

  if (Gun2.AssignTo <> nil) and (Gun2.AssignTo.Name <> 'FC4') and (Gun2.AssignTo.TrackedTarget <> nil) then begin
    Gun2.IsBlind := self.TestBlindArc(2, Gun2.AssignTo.TrackedTarget);
    Gun2.IsInRange := (CalcRange(xSHIP.PositionX, xSHIP.PositionY, Gun2.AssignTo.TrackedTarget.PositionX,
      Gun2.AssignTo.TrackedTarget.PositionY) < C_GUN2_RANGE);
  end
  else begin
    Gun2.IsBlind := False;
    Gun2.IsInRange := False;
  end;

  if (Gun3.AssignTo <> nil) and (Gun3.AssignTo.Name <> 'FC4') and (Gun3.AssignTo.TrackedTarget <> nil) then begin
    Gun3.IsBlind := self.TestBlindArc(3, Gun3.AssignTo.TrackedTarget);
    Gun3.IsInRange := (CalcRange(xSHIP.PositionX, xSHIP.PositionY, Gun3.AssignTo.TrackedTarget.PositionX,
      Gun3.AssignTo.TrackedTarget.PositionY) < C_GUN3_RANGE);
  end
  else begin
    Gun3.IsBlind := False;
    Gun3.IsInRange := False;
  end;
  SetGunReady;
end;


function TGenericWCCInterface.GetModeID_Fire(TheGun : TGUN):byte;
begin
  Result := 1;

  if TheGUN.AssignTo = FC1 then
     Result := 3;

  if (TheGUN.AssignTo = FC2) then
  begin
    if TheGUN.AssignTo.IsDoingIndBomb or
      TheGUN.AssignTo.IsDoingBlindBomb or
          TheGUN.AssignTo.ThrowOff then
      Result := 2;
  end;

  if TheGUN.AssignTo.GenFix then
      Result := 2;

end;

// Calc Correction
procedure TGenericWCCInterface.DoCorrectionDirectBomb(TheGun: TGun; var Corr_Training, Corr_Elev : Double);
var AnduCorrTraining,
    AnduCorrElev,
    BscopeCorrTraining,
    BscopeCorrElev    : Double;
begin
   AnduCorrTraining   := 0.0;
   AnduCorrElev       := 0.0;
   BscopeCorrTraining := 0.0;
   BscopeCorrElev     := 0.0;

   DoCorrectionManDirBomb(TheGun, AnduCorrTraining, AnduCorrElev);
   if TheGUN.Corrected then
     DoCorrectionAutoDirBomb(TheGun, BscopeCorrTraining, BscopeCorrElev);

   Corr_Training :=  AnduCorrTraining + BscopeCorrTraining;
   Corr_Elev     :=  AnduCorrElev + BscopeCorrElev;
end;

procedure TGenericWCCInterface.DoCorrection_OnAnduChange(const Gun_ID, Mode : byte);
var FC    : TFireControl;
    TheGUN: TGun;
    ModeID,
    TargetID : word;
    lRec        : TRec3DSetWCC;
    Range,
    CorrElev,
    CorrTraining      : Double;
begin

  CorrElev     := 0;
  CorrTraining := 0;

  if Mode = 1 then
    TheGUN := GetGUN_by_ID(Gun_ID);

  if Mode = 2 then begin
     if Gun1.AssignTo = FC2 then
      TheGUN := Gun1;
    if Gun3.AssignTo = FC2 then
      TheGUN := Gun3;
     if Gun2.AssignTo = FC2 then
       TheGUN := Gun2;
  end;

  if not TheGUN.IsAssigning then exit;

  if (TheGUN.ID < 1) or (TheGUN.ID > 3) then exit;
  if TheGUN.AssignTo = nil then exit;

 case Mode of   // Correction Process
    1 : begin
          DoCorrectionDirectBomb(TheGUN, CorrTraining, CorrElev);
          TargetID := UniqueID_To_dbID(TheGUN.AssignTo.TargetUID);
        end;
    2 : begin
          DoCorrectionInDirAndBlindBomb(TheGun, CorrTraining, CorrElev);
          TargetID := 0;
          CorrTraining := CorrTraining - xSHIP.Heading;
        end;
 end;

//  if FCID <> 4 then begin
    lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mWeaponID          := GetWeaponID(TheGUN.ID);
    lRec.mLauncherID        := TheGUN.ID;
    lRec.mMissileID         := TheGUN.ID;
    lRec.mMissileNumber     := 0;
    lRec.mOrderID           := __ORD_CANNON_ASSIGNED;
    lRec.mTargetID          := TargetID;
    lRec.mModeID            := Mode;
    lRec.mUpDown            := 0;
    lRec.mAutoCorrectElev   := CorrElev;
    lRec.mAutoCorrectBearing:= CorrTraining;
    lRec.mBalistikID        := 0;
    if (netSend <> nil) then
      netSend.sendDataEx(C_REC_CANNON , @lRec);
//  end
end;

function TGenericWCCInterface.AssignGunToFC(const Gun_ID, FCID: byte; const send: boolean= TRUE): boolean;
var FC    : TFireControl;
    TheGUN: TGun;
    aRec  : TRecGunControl;
    lRec        : TRec3DSetWCC;
    //FireMod : byte;
    Bullet1Type  : byte;
    Bullet2Type  : byte;
    fA2: TfrmWCCPanelAtas2;
    ModeID,
    TargetID  : Word;
    Range,
    CorrElev,
    CorrTraining      : Double;
begin
  result := False;

  CorrElev     := 0;
  CorrTraining := 0;
  TargetID     := 0;
  case FCID of
    1: FC := FC1;
    2: FC := FC2;
    3: FC := FC3;
    4: FC := FC4;
  end;

  TheGUN := GetGUN_by_ID(Gun_ID);

  if FC.TrackedTarget = nil then exit;

  if (TheGUN.AssignTo <> nil) then exit;

  TheGUN.AssignTo := FC;
  TheGUN.ID := Gun_ID;
  ActiveGUN := TheGUN;
  ActiveFC  := FC;

  Bullet1Type := TheGUN.Bullet1Type;
  Bullet2Type := TheGUN.Bullet2Type;

  ModeID      := GetModeID_Fire(TheGUN);

  case ModeID of   // Correction Process
    M_DirBomb : begin
          DoCorrectionDirectBomb(TheGUN, CorrTraining, CorrElev);
          TargetID := UniqueID_To_dbID(FC.TargetUID);
        end;
    M_IndBomb_BlindBomb : begin
          DoCorrectionInDirAndBlindBomb(TheGun, CorrTraining, CorrElev);
          TargetID := 0;
          CorrTraining := CorrTraining - xSHIP.Heading;
        end;
    M_AirTarget : begin
          TargetID := UniqueID_To_dbID(FC.TargetUID);
        end;
  end;

  if FCID <> 4 then begin
    TheGUN.IsAssigning      := True;

    lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mWeaponID          := GetWeaponID(TheGUN.ID);
    lRec.mLauncherID        := TheGUN.ID;
    lRec.mMissileID         := TheGUN.ID;
    lRec.mMissileNumber     := 0;
    lRec.mOrderID           := __ORD_CANNON_ASSIGNED;
    lRec.mTargetID          := TargetID;
    lRec.mModeID            := ModeID;
    lRec.mUpDown            := 0;
    lRec.mAutoCorrectElev   := CorrElev;
    lRec.mAutoCorrectBearing:= CorrTraining;
    lRec.mBalistikID        := 0;

    if (netSend <> nil) then
      netSend.sendDataEx(C_REC_CANNON , @lRec);

    result := True;
  end
  else begin
    if (not FC.HasGun) and (TheGUN.AssignTo = nil) then begin
      TheGUN.AssignTo := FC;
      FC.HasGun := True;
      result := True;
    end;
  end;
  if send and result and (FCID = 4) then begin
    with aRec do begin
      ShipID := xSHIP.UniqueID;
      OrderID := OrdID_assign_gun;
      Ship_TID := FC.TrackedTarget.ShipTrackId;
      //TrackNumber := FC.TrackedTarget.TrackNumber;
      Gun_number := Gun_ID;
      AssignedTo := FCID;
      //FireMode   := FireMod;      // (SINGLE, BURST) * gun1 only
      Bullet1    := Bullet1Type;    // (PARPROX, IMPACT) gun1,2,3
      Bullet2    := Bullet1Type;    // (HE_TRACER, PRE_FRAG) * gun2,3 only
      //ControlMode:= byte;   // (remote, local) gun1,2,3
      //IsSync      : boolean;// (remote, local) gun1,2,3
      //IsBlind     : boolean;// lg blind ato ga
      //InRange     : boolean;// masuk jarak tembak ato ga
    end;
    netSend.sendDataEx(C_REC_GUN_CONTROL, @aRec);
  end;
 // WCC_FireGunLagi(Gun_ID);

  CekGunStatus;

  fA2 := TfrmWCCPanelAtas2(frmWCCAtas2);
  case Gun_ID of
    1: begin
          if Gun1.IsBlind then
          // BtnC.UpdateImage(fA2.lmpRRNF, BtnC.redROUND_On);
       end;
    2: begin
          if Gun2.IsBlind then begin
            BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_On);
          end
          else begin
            BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_Off);
          end;
       end;
    3: begin
          if Gun3.IsBlind then begin
            BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_On);
          end
          else begin
            BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_Off);
          end;
       end;
  end;
end;

procedure TGenericWCCInterface.DeassignActiveGun;
var
  lRec  : TRec3DSetWCC;
begin
      if (ActiveGUN <> nil ) and (ActiveGUN.IsAssigning) then begin
        lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
        lRec.mWeaponID          := GetWeaponID(ActiveGUN.ID);
        lRec.mLauncherID        := ActiveGUN.ID;
        lRec.mMissileID         := ActiveGUN.ID;
        lRec.mMissileNumber     := 0;
        lRec.mOrderID           := __ORD_CANNON_DEASSIGNED;
        lRec.mTargetID          := 0;
        lRec.mModeID            := 2;
        lRec.mUpDown            := 0;
        lRec.mAutoCorrectElev   := 0;
        lRec.mAutoCorrectBearing:= 0;
        lRec.mBalistikID        := 0;
        if (netSend <> nil) then
          netSend.sendDataEx(C_REC_CANNON , @lRec);
      end;
end;

function TGenericWCCInterface.DeAssignGun(const Gun_ID, FCID: byte; const send: boolean= TRUE): boolean;
var
  FC: TFireControl;
  TheGUN: TGun;
  TargetID, ModeID : word;
  aRec  : TRecGunControl;
  lRec  : TRec3DSetWCC;
  fA2: TfrmWCCPanelAtas2;
begin
  result := False;
  case FCID of
    1: FC := FC1;
    2: FC := FC2;
    3: FC := FC3;
    4: FC := FC4;
  end;

  TheGUN :=  GetGUN_by_ID(Gun_ID);

  if TheGUN.IsSalvoFiring then
   StopCannonFire(TheGUN.ID);

  if TheGUN.AssignTo = nil then exit;

  if Assigned(ActiveGUN) then
    ActiveGUN.ID:= 0;

   ModeID      := GetModeID_Fire(TheGUN);
   case ModeID of   // Correction Process
      1 : TargetID := UniqueID_To_dbID(FC.TargetUID);
      2 : TargetID := 0;
   end;

    if TheGUN.AssignTo.Name = FC.Name then begin
      TheGUN.IsAssigning    := False;

      lRec.ShipID           := UniqueID_To_dbID(xSHIP.UniqueID);
      lRec.mLauncherID      := Gun_ID;
      lRec.mMissileID       := Gun_ID;
      lRec.mWeaponID        := GetWeaponID(Gun_ID);
      lRec.mTargetID        := 1;

      lRec.mMissileNumber   := 0;
      lRec.mOrderID         := __ORD_CANNON_DEASSIGNED; // meriam deassigned
                            //  OrdID_deassign_gun;  {orderID lama}
      lRec.mBalistikID      := 0;

      lRec.mModeID          := 1;
      lRec.mAutoCorrectElev := 0;
      lRec.mAutoCorrectBearing := 0;
      lRec.mSalvoRate       := 0;

      if (netSend <> nil) then
       netSend.sendDataEx(C_REC_CANNON , @lRec);

      TheGUN.AssignTo := nil;
      result := True;

//      TfrmBScope(frmScopeB).ShowSplashPoint(TheGun.PosBeforeCorr.X, TheGun.PosBeforeCorr.Y, TheGUN.ID , false);
//      TfrmBScope(frmScopeB).ShowMarker := false;
    end;

  if result and (FCID = 4) then FC.HasGun := False;

  if send and result and (FCID = 4) then begin
    with aRec do begin
      ShipID := xSHIP.UniqueID;
      OrderID := OrdID_deassign_gun;
      //Ship_TID := FC.TrackedTarget.ShipTrackId;
      //TrackNumber := FC.TrackedTarget.TrackNumber;
      Gun_number := Gun_ID;
      AssignedTo := FCID;
      //FireMode    := FireMod;        // (SINGLE, BURST) * gun1 only
      //Bullet1     := Bullet1Type;    // (PARPROX, IMPACT) gun1,2,3
      //Bullet2     := Bullet1Type;    // (HE_TRACER, PRE_FRAG) * gun2,3 only
      //ControlMode:= byte;   // (remote, local) gun1,2,3
      //IsSync      : boolean;// (remote, local) gun1,2,3
      //IsBlind     : boolean;// lg blind ato ga
      //InRange     : boolean;// masuk jarak tembak ato ga
    end;
    netSend.sendDataEx(C_REC_GUN_CONTROL, @aRec);
  end;

  fA2 := TfrmWCCPanelAtas2(frmWCCAtas2);
  case Gun_ID of
    1: BtnC.UpdateImage(fA2.lmpRRNF, BtnC.redROUND_Off);

    2: begin
         BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_Off);
         BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_Off);
       end;
    3: begin
         BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_Off);
         BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_Off);
       end;
  end;
end;

procedure TGenericWCCInterface.StartCannonFire(Gun_ID: word);
var lRec        : TRec3DSetWCC;
   pnt          : TPoint;
   findObj      : boolean;
   idx_Mv,
   idx_FC,
   rdm,
   idlog        : Integer;
   Gun          : TGun;
   TgtPos       : t3DPoint;
   Crs, Spd     : Double;
begin
   if ActiveFC = nil then Exit;
   if ActiveGUN.ID <> Gun_ID then Exit;
   if IsRRNF_on then Exit;                   // Setting Error dr Instruktur

   Gun := GetGUN_by_ID(Gun_ID);

   if not Gun.PowerOn then Exit;

    // if not Gun.Isfunctionalized then Exit;    // Weapon Tidak di assign Instruktur

     TgtPos.X := Gun.AssignTo.TrackedTarget.PositionX;
     TgtPos.Y := Gun.AssignTo.TrackedTarget.PositionY;
     TgtPos.Z := Gun.AssignTo.TrackedTarget.PositionZ;

     Crs := Gun.AssignTo.TrackedTarget.Course;
     Spd := Gun.AssignTo.TrackedTarget.Speed;

     SetGunReady;
     if GetModeID_Fire(Gun) = M_DirBomb then
     else if GetModeID_Fire(Gun) = M_IndBomb_BlindBomb then begin
        if (Gun.AssignTo = FC2) and (Gun.AssignTo.IsDoingIndBomb)then
        begin
          if OffsetPoint_Marker.Visible then begin
             TgtPos.X := OffsetPoint_Marker.mPos.X;
             TgtPos.Y := OffsetPoint_Marker.mPos.Y;
          end;
        end;
     end;

     if Assigned(Gun) then
       Gun.TOF := FindTOFandPHPpoint(Gun_ID, Crs , Spd,
       TgtPos.X , TgtPos.Y, TgtPos.Z);



     if InRangeToFire(TgtPos.X, TgtPos.Y, Gun_ID) then begin
        lRec.ShipID           := UniqueID_To_dbID(xSHIP.UniqueID);
        lRec.mWeaponID        := GetWeaponID(GUN.ID);
        lRec.mLauncherID      := GUN.ID;
        lRec.mMissileID          := GUN.ID;
        if Gun.salvo then begin
          lRec.mOrderID   := __ORD_CANNON_START_F;
          Gun.IsSalvoFiring   := True;                   // penembakan salvo
          lRec.mMissileNumber   := 1;
          lRec.mSalvoRate       := 30;
        end
        else begin
          lRec.mOrderID   := __ORD_CANNON_F;
          Gun.IsSalvoFiring   := False;             // penembakan penilikan
          Inc(MslNumb);
          lRec.mMissileNumber   := MslNumb;
        end;

        lRec.mModeID      := GetModeID_Fire(Gun);

        case lRec.mModeID of   // Correction Process
          M_DirBomb : begin
                lRec.mTargetID :=  UniqueID_To_dbID(Gun.AssignTo.TargetUID);
                WCCAndu.Page_2[C_TOF][Gun_ID].SetValue(Gun.TOF);
                WCCAndu.Page_3[C_Gun1TOF].SetValue(Gun.TOF);
              end;
          M_IndBomb_BlindBomb : begin
                lRec.mTargetID := 0;
                WCCAndu.Page_2[C_TOF][Gun_ID].SetValue(Gun.TOF);
                WCCAndu.Page_3[C_Gun1TOF].SetValue(Gun.TOF);
              end;
        end;
        lRec.mUpDown              := 0;
        lRec.mAutoCorrectElev     := 0;
        lRec.mAutoCorrectBearing  := 0;
        lRec.mBalistikID          := 0;
        if (netSend <> nil) then
        netSend.sendDataEx(C_REC_CANNON , @lRec);

         case Gun_ID of
           1 : idlog := 40;
           2 : idlog := 41;
           3 : idlog := 42;
         end;
         SendEvenWCC_120mm(idlog);



        Gun.PosBeforeCorr.X := 0.5;           // posisi awal PHP
        Gun.PosBeforeCorr.Y := 0.5;

        ShowPHP(ActiveGUN , true);

        TfrmWCCPanelBawah2(frmWCCBawah2).tmrShowsplash.Enabled := True;
        TfrmWCCPanelBawah2(frmWCCBawah2).StartCountDelSplash   := False;
     end;
end;

function TGenericWCCInterface.GetWeaponID(Gun_ID: word):word;
begin
   case Gun_ID of
      1 : Result := C_DBID_CANNON120;
      2 : Result := C_DBID_CANNON40;
      3 : Result := C_DBID_CANNON40;
   end;
end;

function TGenericWCCInterface.GetGUN_by_ID(Gun_ID: word): TGun;
begin
   case Gun_ID of
     1 : Result := Gun1;
     2 : Result := Gun2;
     3 : Result := Gun3;
   end;
end;

procedure TGenericWCCInterface.StopCannonFire(Gun_ID: word);
var lRec : TRec3DSetWCC;
   pnt       : TPoint;
   findObj   : boolean;
   WeaponType: Word;
   Gun :TGun;
begin
    Gun := GetGUN_by_ID(Gun_ID);
    if not Gun.IsSalvoFiring then Exit;    // jk tdk Sedang melakukan penembakan Exit

    lRec.ShipID               := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mLauncherID          := Gun_ID;
    lRec.mWeaponID            := GetWeaponID(Gun_ID);
    lRec.mMissileNumber       := 0;
    lRec.mMissileID           := Gun_ID;
    lRec.mOrderID             := __ORD_CANNON_STOP_F;
    lRec.mTargetID            := 0;  //  UniqueID_To_dbID(FC.TargetUID);
                                     //  OrdID_assign_gun;    {orderID lama}
    lRec.mModeID              := 0;
    lRec.mUpDown              := 0;
    lRec.mAutoCorrectElev     := 0;
    lRec.mAutoCorrectBearing  := 0;
    lRec.mBalistikID          := 0;
    if (netSend <> nil) then
    netSend.sendDataEx(C_REC_CANNON , @lRec);
    Gun.IsSalvoFiring := False;

    TfrmWCCPanelBawah2(frmWCCBawah2).CounterDel            :=  0;
    TfrmWCCPanelBawah2(frmWCCBawah2).StartCountDelSplash   := true;
end;

procedure TGenericWCCInterface.DeleteAllTrack;
var
  I: Integer;
  FC_Needto_WIPE : TFireControl;
begin
  for I := 1 to 3 do begin
    case i of
      1: FC_Needto_WIPE := FC1;
      2: FC_Needto_WIPE := FC2;
      3: FC_Needto_WIPE := FC3;
    end;

  if FC_Needto_WIPE.TrackedTarget <> nil then
    DeleteMTrack(FC_Needto_WIPE.TrackedTarget);
  end;
end;

procedure TGenericWCCInterface.ShowBScope(FCID: byte; const aShow, status : boolean);
begin
  if not status then begin
    TfrmBScope(frmScopeB).ClearAllItem;
    Exit;
  end;

  if not aShow then
  FCID := 0;
  TfrmBScope(frmScopeB).ShowMarker := false;
  TfrmBScope(frmScopeB).ClearAllItem;
  case FCID of
    0 : TfrmBScope(frmScopeB).ShowItem(FCID, tbmDefault);
    2 : if (FC2.TrackedTarget = nil) or FC2.GenFix then TfrmBScope(frmScopeB).ShowItem(FCID, tbmDefault)
        else TfrmBScope(frmScopeB).ShowItem(FCID, tbmShip);
    3 : if (FC3.TrackedTarget = nil) or FC3.GenFix then TfrmBScope(frmScopeB).ShowItem(FCID, tbmDefault)
        else TfrmBScope(frmScopeB).ShowItem(FCID, tbmShip);
  end;
end;

procedure TGenericWCCInterface.SetAssign_OnThrowOff(GunID: byte);
var FC    : TFireControl;
    TheGUN: TGun;
    aRec  : TRecGunControl;
    lRec        : TRec3DSetWCC;
    //FireMod : byte;
    Bullet1Type  : byte;
    Bullet2Type  : byte;
    fA2: TfrmWCCPanelAtas2;
    ModeID,
    TargetID  : Word;
    Range,
    CorrElev,
    CorrTraining      : Double;
begin


  CorrElev     := 0;
  CorrTraining := 0;
  TargetID     := 0;

  case GunID of
    1: TheGUN := Gun1;
    2: TheGUN := Gun2;
    3: TheGUN := Gun3;
  end;

  if TheGUN.AssignTo = FC2 then
    FC := FC2
  else
    Exit;

  if FC.TrackedTarget = nil then exit;

  TheGUN.AssignTo := FC;
  TheGUN.ID := GunID;
  ActiveGUN := TheGUN;
  ActiveFC  := FC;

  Bullet1Type := TheGUN.Bullet1Type;
  Bullet2Type := TheGUN.Bullet2Type;

  ModeID      := GetModeID_Fire(TheGUN);

  case ModeID of   // Correction Process
    M_DirBomb : begin
          DoCorrectionDirectBomb(TheGUN, CorrTraining, CorrElev);
          TargetID := UniqueID_To_dbID(FC.TargetUID);
        end;
    M_IndBomb_BlindBomb : begin
          DoCorrectionInDirAndBlindBomb(TheGun, CorrTraining, CorrElev);
          TargetID := 0;
          CorrTraining := CorrTraining - xSHIP.Heading;
        end;
  end;
    TheGUN.IsAssigning      := True;

    lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mWeaponID          := GetWeaponID(TheGUN.ID);
    lRec.mLauncherID        := TheGUN.ID;
    lRec.mMissileID         := TheGUN.ID;
    lRec.mMissileNumber     := 0;
    lRec.mOrderID           := __ORD_CANNON_ASSIGNED;
    lRec.mTargetID          := TargetID;
    lRec.mModeID            := ModeID;
    lRec.mUpDown            := 0;
    lRec.mAutoCorrectElev   := CorrElev;
    lRec.mAutoCorrectBearing:= CorrTraining;
    lRec.mBalistikID        := 0;
    if (netSend <> nil) then
      netSend.sendDataEx(C_REC_CANNON , @lRec);

   CekGunStatus;

  fA2 := TfrmWCCPanelAtas2(frmWCCAtas2);
  case GunID of
    1: begin
          if Gun1.IsBlind then
          // BtnC.UpdateImage(fA2.lmpRRNF, BtnC.redROUND_On);
       end;
    2: begin
          if Gun2.IsBlind then begin
            BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_On);
          end
          else begin
            BtnC.UpdateImage(fA2.lmpG2BLDARC, BtnC.redROUND_Off);
          end;
       end;
    3: begin
          if Gun3.IsBlind then begin
            BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_On);
          end
          else begin
            BtnC.UpdateImage(fA2.lmpG3BLDARC, BtnC.redROUND_Off);
          end;
       end;
  end;
end;


procedure TGenericWCCInterface.SetBScopeMarkerPos(const x,y: double);
begin
  TfrmBScope(frmScopeB).SetMarkerPosition(x,y);
end;

function TGenericWCCInterface.GetBScopeMarkerPosX: double;
begin
  result := TfrmBScope(frmScopeB).ScopeView.MarkerPositionX;
end;

function TGenericWCCInterface.GetBScopeMarkerPosY: double;
begin
  result := TfrmBScope(frmScopeB).ScopeView.MarkerPositionY;
end;

Function TGenericWCCInterface.GetTOF(Gun_numb :Word; X1,Y1,X2,Y2,Z2: Double): Single;
var TargetRange : Double;
begin
  if DataModule1.GetStatusconDB then begin
//    TargetRange := Sqrt(Sqr(CalcRange(X1, Y1, X2, Y2) * C_NauticalMiles_TO_Meter) + Sqr(Z2));
    TargetRange := CalcRange(X1, Y1, X2, Y2) * C_NauticalMiles_TO_Meter;
    Result := DataModule1.GetCanonTOFbyRange(Gun_numb, TargetRange);
  end
  else
    Result := 3;   // Konstanta TOF

end;

function TGenericWCCInterface.FindTOFandPHPpoint(Gun_numb: Word; TgtCourse, TgtSpeed:Single;
var oX, oY, oZ: Double): Single;
var lastrange, range, movement, brg, toleran,
    tmpX, tmpY,
    iX, iY, iZ : Double;
    CurTgtPos : tDouble2DPoint;
    Tof  : Single;
    i :integer;
begin
  i  := 0;
  iX := oX;
  iY := oY;

  toleran   := 1 * C_Meter_To_NauticalMiles;
  lastrange := 0;
  range     := 0;
  repeat
    inc(i);
    lastrange := range;
    Tof       := GetTOF(Gun_numb, xSHIP.PositionX, xSHIP.PositionY, oX, oY, oZ);
    movement  := (Tof/3600) * TgtSpeed;                        // Range pergerakan kapal  target (Nm)
    RangeBearingToCoord(movement,TgtCourse,tmpX, tmpY);        // titik pergerakan kapal target
    oX := 0;
    oY := 0;
    oX := iX + tmpX * C_NauticalMile_To_Degree;               //posisi X,Y terakhir pada saat TOF
    oY := iY + tmpY * C_NauticalMile_To_Degree;
    range := CalcRange(xSHIP.PositionX, xSHIP.PositionY, oX, oY);

    Result := Tof;
  until(Lastrange > (range - toleran)) and (Lastrange < (range + toleran)) or (i=100);

end;

Procedure TGenericWCCInterface.GetGunTOFfromDb(Gun_numb :integer; hpX, hpY, hpZ : Double); // Untuk mendapatkan nilai TOF berdasarkan tabel TOF
var TargetRange : Double;
    UseGun      : TGun;
begin

  UseGun := GetGUN_by_ID(Gun_numb);

  TargetRange := Sqrt(Sqr(CalcRange(xSHIP.PositionX, xSHIP.PositionY, hpX, hpY) * C_NauticalMiles_TO_Meter) + Sqr(hpZ));

//   WCCAndu.Page_2[C_TOF][Gun_numb].SetValue(DataModule1.GetCanonTOFbyRange(Gun_numb, TargetRange));
   UseGun.TOF := DataModule1.GetCanonTOFbyRange(Gun_numb, TargetRange);
end;


procedure TGenericWCCInterface.ShowAScope(const stat: ATOStat);
var posx: double;
begin
  Randomize;
  posx := Random;
  case stat of
    atoBreak: begin
//      TfrmAScope(frmScopeA).ShowItem(tamNone, posx, False);
      TfrmAScope(frmScopeA).ShowItem(tamNone, 0.1, False);
      TfrmAScope(frmScopeA).ShowItem(tamNone, 0.5, True);
    end;
    atoLockOn: begin                          {posx}
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.8, True);
    end;
    atoAuto1: begin
    {asli}
//      TfrmAScope(frmScopeA).ShowItem(tamBGateEcho, posx, False);
//      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);
    {asli}
      TfrmAScope(frmScopeA).ShowItem(tamBGateEcho, 0.8, False);
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);

    end;
    {added by bagoes}
    atoAuto2: begin
      TfrmAScope(frmScopeA).ShowItem(tamBGateEcho, 0.6, False);
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);
    end;
    {added by bagoes}
    atoReady: begin
  //    TfrmAScope(frmScopeA).ShowItem(tamNGate, posx, False);
      TfrmAScope(frmScopeA).ShowItem(tamNGate, 0.5, False);
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);
    end;
    atoLost1: begin
      TfrmAScope(frmScopeA).ShowItem(tamNGate, 0.4, False);
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);
    end;
    atoLost2: begin
      TfrmAScope(frmScopeA).ShowItem(tamNGate, 0.2, False);
      TfrmAScope(frmScopeA).ShowItem(tamEcho, 0.5, True);
    end;
     atoGone: begin
      TfrmAScope(frmScopeA).ShowItem(tamNone, 0.0, False);
      TfrmAScope(frmScopeA).ShowItem(tamNone, 0.5, True);
    end;
  end;
end;

{function TGenericWCCInterface.WCC_FireGun(const Gun: byte): integer;
var aRec: TRecMeriam;
  TheGun: TGun;
begin
  result := 0;
  case Gun of
  1: TheGun := Gun1;
  2: TheGun := Gun2;
  3: TheGun := Gun3;
  end;

  if TheGun.PowerOn and (not TheGun.IsBlind) and (TheGun.AssignTo.TrackedTarget <> nil) then begin
    TheGun.TOF := Floor((CalcRange(xSHIP.PositionX, xSHIP.PositionY, TheGun.AssignTo.TrackedTarget.PositionX,
      TheGun.AssignTo.TrackedTarget.PositionY) * C_NauticalMiles_TO_Meter) / TheGun.MuzzleVelocity);
    with aRec do begin
      ShipID      := UniqueID_To_dbID(xSHIP.UniqueID);
      OrderID     := ORD_CANNON_F;
      Gun_number  := Gun;
      X           := TheGun.AssignTo.TrackedTarget.PositionX;
      Y           := TheGun.AssignTo.TrackedTarget.PositionY;
    end;
    netSend.sendDataEx(C_REC_MERIAM, @aRec);

    if TheGun.TOF <= 2 then begin
      TheGun.PHPStart := 0;
      TheGun.PHPEnd := 2;
    end
    else begin
      TheGun.PHPStart := TheGun.TOF - 2;
      TheGun.PHPEnd := TheGun.TOF + 2;
    end;
    TheGun.Firing := True;

    result := TheGun.TOF;
  end;
end;}

//****************************************************************************//
procedure TGenericWCCInterface.SetRadarOnOff(const bOke: boolean);
begin
  ActiveRadar.Enabled := bOke;
  SetAllLayerVisibility(frmTengah.Map, bOke);
end;

procedure TGenericWCCInterface.SetTrackShown(Isvisible: boolean);
var
  I: Integer;
  FC : TFireControl;
begin
  for I := 1 to 3 do begin
    case i of
      1: FC := FC1;
      2: FC := FC2;
      3: FC := FC3;
    end;

    if FC.TrackedTarget <> nil then
      FC.TrackedTarget.Visibles := Isvisible;
  end;
end;

//****************************************************************************//
function TGenericWCCInterface.DoBlindBomb: boolean;
var
  dpt       : t2DPoint;
  mTrack    : TManualTrack;
  shiptid,
  tnumb     : byte;
  pX, pY    : double;
  aRec      : TRecFireControlOrder;
  lRec      : TRec3DSetWCC;
  FCnum     : byte;
  b, r, h, c, s,
  CorrElev  ,
  CorrTraining : Double;
  IsGunassigned : Boolean;
begin
  result := False;
   IsGunassigned := false;
  if (FC2.TrackedTarget <> nil) or (FC2.IsDoingIndBomb) then exit;
  FCnum := 2;

  b := WCCAndu.Page_3[C_TgtBearing].GetDoubleValue;
  r := WCCAndu.Page_3[C_TgtRange].GetDoubleValue  * C_Yard_To_NauticalMiles;
  h := WCCAndu.Page_3[C_TgtHeight].GetDoubleValue;
  c := WCCAndu.Page_3[C_CurrentCourse].GetDoubleValue;
  s := WCCAndu.Page_3[C_CurrentSpeed].GetDoubleValue;

  if (b >= 0) and (r > 0) then begin
    RangeBearingToCoord(r, b, dPt.X, dPt.Y);

    pX := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
    pY := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;

    CreateDefaultMTrack(mTrack, pX, pY);

    mTrack.Enabled := TRUE;
    mTrack.LastUpdateTime := LastUpdateCounter;
    TrackList.AddObject(mTrack);

    if mTrack.TrackNumber = 0 then begin
      shiptid   := shipt_tid;
      tnumb     := GetLastTrackID(tdAtasAir);
      mTrack.SetTrackNumber(shiptid, tNumb);
    end;
    mTrack.Domain := tdAtasAir;
    mTrack.SetIdent(ID_AtasAir_Hostile);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
  // -----
    FC2.IsTracking    := true;
    FC2.TrackedTarget :=  mTrack;
    mTrack.SetDelay_To_Automatic(FCnum, false,  nil);

    if s > 0 then mTrack.Speed := s;
    mTrack.Course := c;
    mTrack.Height := h; // added by bagus

    FC2.IsDoingBlindBomb := True;
    result := True;
    if Assigned(ActiveGUN)then
      IsGunassigned := ActiveGUN.IsAssigning;
  end;

  if result then begin
  // Send Sinkron FC
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.FC_number  := FCnum;
    aRec.FC_command := Byte(BlindBomb);
    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;

   if IsGunassigned then
   begin
     // Send Assign gun
    DoCorrectionInDirAndBlindBomb(ActiveGUN , CorrTraining, CorrElev);

    lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mWeaponID          := GetWeaponID(ActiveGUN.ID);
    lRec.mLauncherID        := ActiveGUN.ID;
    lRec.mMissileID         := ActiveGUN.ID;
    lRec.mMissileNumber     := 0;
    lRec.mOrderID           := __ORD_CANNON_ASSIGNED;
    lRec.mTargetID          := 0;
    lRec.mModeID            := 2;
    lRec.mUpDown            := 0;
    lRec.mAutoCorrectElev   := CorrElev;
    lRec.mAutoCorrectBearing:= CorrTraining - xSHIP.Heading;
    lRec.mBalistikID        := 0;
    if (netSend <> nil) then
      netSend.sendDataEx(C_REC_CANNON , @lRec);
   end;
end;

function TGenericWCCInterface.unDoBlindBomb: boolean;
var
  dpt : t2DPoint;
  mTrack: TManualTrack;
  shiptid, tnumb : byte;
  Fpoint: Tpoint;
  aRec: TRecFireControlOrder;
  lRec      : TRec3DSetWCC;
  FCnum: byte;
  findTrack: Boolean;
  Px, py : Double;
  b,r,h,c,s : Double;

begin
  result := False;

  if (FC2.TrackedTarget = nil) or (not FC2.IsDoingBlindBomb) then exit;

  b := WCCAndu.Page_3[C_TgtBearing].GetDoubleValue;
  r := WCCAndu.Page_3[C_TgtRange].GetDoubleValue  * C_Yard_To_NauticalMiles;
  h := WCCAndu.Page_3[C_TgtHeight].GetDoubleValue;
  c := WCCAndu.Page_3[C_CurrentCourse].GetDoubleValue;
  s := WCCAndu.Page_3[C_CurrentSpeed].GetDoubleValue;

  FCnum := 2;
  if (b >= 0) and (r > 0) then begin
    RangeBearingToCoord(r, b, dPt.X, dPt.Y);
    Px  := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
    Py  := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;
    Fpoint:= ConvertToScreen(Px,Py);
    FindTrack := FindTrack_by_screenpos(Fpoint.X, Fpoint.Y, cTrack);

    if findTrack  and (cTrack is TManualTrack) then begin
      DeassignActiveGun;
      mTrack := (cTrack as TManualTrack);
      mTrack.Enabled    := false;
      mTrack.Visibles   := False;
      FC2.IsTracking    := false;
      FC2.TrackedTarget :=  nil;
      FC2.IsDoingBlindBomb := false;
      result := True;
    end;
    if result then begin
      aRec.OrderID    := OrdID_deassign_FC_WCC;
      aRec.ShipID     := xSHIP.UniqueID;

      aRec.Ship_TID     := mTrack.ShipTrackId;
      aRec.TrackNumber  := mTrack.TrackNumber;
      aRec.FC_number  := FCnum;
      aRec.FC_command := Byte(BlindBomb);
      netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
    end;
  end;
end;

function TGenericWCCInterface.DoIndirectBomb: boolean;
var
  b, r: double;
  dpt : t2DPoint;
  pX, pY, cBrg, cRng :double;
  aRec: TRecFireControlOrder;
  lRec        : TRec3DSetWCC;
  jarak : Double;
  IsGunassigned : Boolean;
  CorrElev,
  CorrTraining,
  GunTgtLine    : Double;
const FCnum = 2;
begin
  result := False;
  IsGunassigned := false;

  if (FC2.TrackedTarget = nil) or (FC2.IsDoingBlindBomb) then exit;

  b := WCCAndu.Page_3[C_OffSetBearing].GetDoubleValue;
  r := WCCAndu.Page_3[C_OffSetRange].GetDoubleValue  * C_Yard_To_NauticalMiles;

  if (b >= 0) and (r > 0) then begin

    RangeBearingToCoord(r, b, dPt.X, dPt.Y);

    pX := FC2.TrackedTarget.PositionX + dPt.X * C_NauticalMile_To_Degree;
    pY := FC2.TrackedTarget.Positiony + dPt.Y * C_NauticalMile_To_Degree;

    OffsetPoint_Marker.Visible := true;
    OffsetPoint_SetPosition(pX, pY);
    FC2.IsDoingIndBomb := true;
    result := True;

    cbrg := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, OffsetPoint_Marker.mPos.X, OffsetPoint_Marker.mPos.Y);
    cRng  := CalcRange(xSHIP.PositionX, xSHIP.PositionY,OffsetPoint_Marker.mPos.X, OffsetPoint_Marker.mPos.Y) * C_NauticalMiles_To_Yard;
    WCCAndu.Page_3[C_Gen_Tgt_Bearing].SetValue(cbrg);
    WCCAndu.Page_3[C_Gen_Tgt_Range].SetValue(cRng);

    GunTgtLine := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, FC2.TrackedTarget.PositionX , FC2.TrackedTarget.PositionY);
    WCCAndu.Page_3[C_Gun_Tgt_Line].SetValue(GunTgtLine);

    if Assigned(ActiveGUN)then
       IsGunassigned := ActiveGUN.IsAssigning;
  end;

   if IsGunassigned then
   begin
     // Send Assign gun
    DoCorrectionInDirAndBlindBomb(ActiveGUN , CorrTraining, CorrElev);

    lRec.ShipID             := UniqueID_To_dbID(xSHIP.UniqueID);
    lRec.mWeaponID          := GetWeaponID(ActiveGUN.ID);
    lRec.mLauncherID        := ActiveGUN.ID;
    lRec.mMissileID         := ActiveGUN.ID;
    lRec.mMissileNumber     := 0;
    lRec.mOrderID           := __ORD_CANNON_ASSIGNED;
    lRec.mTargetID          := 0;
    lRec.mModeID            := 2;
    lRec.mUpDown            := 0;
    lRec.mAutoCorrectElev   := CorrElev;
    lRec.mAutoCorrectBearing:= CorrTraining - xSHIP.Heading;
    lRec.mBalistikID        := 0;
    if (netSend <> nil) then
      netSend.sendDataEx(C_REC_CANNON , @lRec);
   end;
  {if result then begin
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.FC_number  := FCnum;
    aRec.FC_command := Byte(IndirectBomb);

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;}
end;

function TGenericWCCInterface.unDoIndirectBomb: Boolean;
begin
  Result := false;
  if (FC2.IsDoingIndBomb) then begin
    OffsetPoint_Marker.Visible := false;
    FC2.IsDoingIndBomb := false;
    Result := true;
    WCCAndu.Page_3[C_Gen_Tgt_Bearing].ClearValue;
    WCCAndu.Page_3[C_Gen_Tgt_Range].ClearValue;
    DeassignActiveGun;
  end
  else
    Exit;
end;

procedure TGenericWCCInterface.OffsetPoint_SetPosition(const x, y: double);
begin
  OffsetPoint_Marker.mPos.X := x;
  OffsetPoint_Marker.mPos.Y := y;
  OffsetPoint_Marker.Center := ConvertToScreen(x, y);
end;

function TGenericWCCInterface.DoGenFix(const tFCID: byte): boolean;
var
  mTrack: TManualTrack;
  shiptid, tnumb : byte;
  aRec: TRecFireControlOrder;
  FCnum: byte;
  FCtmp : TFireControl;
begin
  result := False;

    case tFCID of
      2 : FCtmp :=FC2;
      3 : FCtmp :=FC3;
    end;

  if (FCtmp.TrackedTarget <> nil) or (FCtmp.IsDoingIndBomb) then exit;

  FCnum := tFCID;
 if (tFCID = 2) or (tFCID = 3)  then begin
    CreateDefaultMTrack(mTrack, OBMRight.mPos.X , OBMRight.mPos.Y);
    mTrack.Enabled := TRUE;
    mTrack.LastUpdateTime := LastUpdateCounter;
    TrackList.AddObject(mTrack);

    if mTrack.TrackNumber = 0 then begin
      shiptid   := shipt_tid;
      tnumb     := GetLastTrackID(tdAtasAir);
      mTrack.SetTrackNumber(shiptid, tNumb);
    end;
    mTrack.Domain := tdAtasAir;
    mTrack.SetIdent(ID_AtasAir_Hostile);
    mTrack.SetAmplifyingInfo_1(aiAcquisitionTrack);
  // -----
    FCtmp.GenFix        :=  true;
    FCtmp.IsTracking    :=  true;
    FCtmp.TrackedTarget :=  mTrack;
    mTrack.SetDelay_To_Automatic(FCnum, false,  nil);

    mTrack.Speed  := 0;
    mTrack.Course := 0;
    mTrack.Height := 0; // added by bagus

   // FC2.IsDoingBlindBomb := True;
    result := True;
  end;

  if result then begin
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;
    aRec.FC_number  := FCnum;
    aRec.FC_command := Byte(genfix);

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );
  end;

  { comment by bagus
    result := false;
  if (tFCID < 2) or (tFCID > 3)  then exit;

  findTrack := FindTrack_by_screenpos(OBMRight.Center.X, OBMRight.Center.Y, cTrack);
  if findTrack and (cTrack is TManualTrack) then begin
    mTrack  := cTrack as TManualTrack;
    aRec.OrderID    := OrdID_assign_FC;
    aRec.ShipID     := xSHIP.UniqueID;

    aRec.FC_number  := tFCID;
    aRec.FC_command := Byte(genfix)  ;
    aRec.Ship_TID     := mTrack.ShipTrackId;
    aRec.TrackNumber  := mTrack.TrackNumber;

    netSend.sendDataEx(C_REC_FIRE_CONTROL, @aRec );

    result := true;
  end;
 }
end;

//****************************************************************************//
function TGenericWCCInterface.TestBlindArc(const Gun: byte; const Tgt: TManualTrack): boolean;
var
  LAngle, RAngle, b: double;
begin

  BlindArcs.GetGunAngle(self.xSHIP.Heading, Gun, LAngle, RAngle);

  b := CalcBearing(xShip.PositionX, xShip.PositionY,
   Tgt.PositionX, Tgt.PositionY);

  Result := not DegComp_IsBeetwen(b, LAngle, RAngle);
end;

//****************************************************************************//
// draw Splash from 3D
procedure TGenericWCCInterface.ShowSplasFrom3D(Rec : TRecSplashCannon);
var TheGun : TGun;
  RangeDeviation,     BearingDeviation,
  SplashRange,        SplashBearing,
  TgtRange,           TgtBearing,
  Val_X, Val_Y,
  PosX, PosY  : Double;
begin

  TheGun := GetGUN_by_ID(Rec.LauncherID);
//  if not TheGun.IsSalvoFiring then Exit;

  if TheGun.AssignTo.TrackedTarget <> nil then begin

    SplashRange     := CalcRange(xSHIP.PositionX, xSHIP.PositionY, Rec.PosX, Rec.PosY);
    TgtRange        := CalcRange(xSHIP.PositionX, xSHIP.PositionY, TheGun.AssignTo.TrackedTarget.PositionX , TheGun.AssignTo.TrackedTarget.PositionY);
    RangeDeviation  := SplashRange - TgtRange;

    SplashBearing   := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, Rec.PosX, Rec.PosY);
    TgtBearing      := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, TheGun.AssignTo.TrackedTarget.PositionX , TheGun.AssignTo.TrackedTarget.PositionY);
    BearingDeviation:= SplashBearing - TgtBearing;

    Val_Y := RangeDeviation * C_NauticalMiles_To_Bscope_ScaleHeight;
    Val_Y := RangeDeviation;
    PosY  := 0.5 + Val_Y;
//    PosY := 0.5;
//    PosX := 0.5;

    Val_X := BearingDeviation * C_Degree_To_Bscope_ScaleWidth;
    Val_X := BearingDeviation;
     PosX  := 0.5 + Val_X;

    with TheGun do begin
      PosSplash.X := PosX;
      PosSplash.Y := PosY;
      {Show Splash di Bscope}
      TfrmBScope(frmScopeB).ShowSplashPoint(PosX, PosY, TheGun.ID, True);
    end;

    {Hapus PHP dan Splash di Bscope}
    TfrmWCCPanelBawah2(frmWCCBawah2).tmrShowsplash.Enabled  := True;
    TfrmWCCPanelBawah2(frmWCCBawah2).StartCountDelSplash    := True;
    TfrmWCCPanelBawah2(frmWCCBawah2).CounterDel             := 0;
  end;
end;

procedure TGenericWCCInterface.ShowSplash(TheGun: TGun; const IsShown: boolean);
var posx, posy: double;
begin
  Randomize;
  if TheGun.Corrected then begin
    posx := 0.5; posy := 0.5;
  end
  else begin
    posx := TheGun.PosSplash.X;
    posy := TheGun.PosSplash.Y;
   {Hanya untuk demo delivery}
    posx := 0.5; posy := 0.5;           // Hapus setelah delivery console wcc
   {Hanya untuk demo delivery}

  end;
  TfrmBScope(frmScopeB).ShowSplashPoint(posx, posy, TheGun.ID, IsShown);
  TheGun.PosSplash.X := posx;
  TheGun.PosSplash.Y := posy;
end;

procedure TGenericWCCInterface.ShowPHP(TheGun: TGun; const IsShown: boolean);
var posx, posy: double;
begin
  if TheGun.Corrected then begin
    posx := TheGun.PosAfterCorr.X;
    posy := TheGun.PosAfterCorr.Y;
  end
  else begin
    posx := TheGun.PosBeforeCorr.X;
    posy := TheGun.PosBeforeCorr.Y;
  end;

   {Hanya untuk demo delivery}
//    posx := 0.5; posy := 0.5;    // target tidak bergerak
   {Hanya untuk demo delivery}

  TfrmBScope(frmScopeB).ShowMarker := IsShown;
 TfrmBScope(frmScopeB).SetMarkerPosition(TheGun.PosBeforeCorr.X ,TheGun.PosBeforeCorr.Y);
//  TfrmBScope(frmScopeB).SetMarkerPosition(posx, posy);
end;

procedure TGenericWCCInterface.DoCorrectionAutoDirBomb(TheGun: TGun; var Corr_Training, Corr_Elev: Double); // var oX, oY: Double);
var Dev_Pos_onBscope, DevonMap : t2DPoint;
    init_Dir_of_Fire, init_Range_of_Fire,
    Training_Corr, Range_Corr,
    L, B, tmpX, tmpY : Double;
begin
  if not Assigned(TheGun) then Exit;

  with TheGun do begin
    Dev_Pos_onBscope.x := PosAfterCorr.X  - PosBeforeCorr.X;
    Dev_Pos_onBscope.y := PosAfterCorr.Y  - PosBeforeCorr.Y;
  end;

  Corr_Training := ValidateDegree(init_Dir_of_Fire + (Dev_Pos_onBscope.x * C_ScaleWidth_on_Bscope));
  if TheGun.ID = 1 then
    Corr_Elev     := Gun120_ConvertRangeToElev(Dev_Pos_onBscope.y * C_ScaleHeight_on_Bscope)
  else
    Corr_Elev     := Gun40_ConvertRangeToElev(Dev_Pos_onBscope.y * C_ScaleHeight_on_Bscope);

//  if not Assigned(TheGun) then Exit;
//
//  with TheGun do begin
//    Dev_Pos_onBscope.x := LastposCorr.X  - PosBeforeCorr.X;
//    L := LastposCorr.Y;
//    B := PosBeforeCorr.Y;
//    Dev_Pos_onBscope.y := LastposCorr.Y  - PosBeforeCorr.Y ;
//
//  end;
//
//  init_Dir_of_Fire    := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, oX, oY);
//  init_Range_of_Fire  := CalcRange(xSHIP.PositionX, xSHIP.PositionY, oX, oY);
//
//  Training_Corr       := ValidateDegree(init_Dir_of_Fire + (Dev_Pos_onBscope.x * C_ScaleWidth_on_Bscope));
//  RangeBearingToCoord(init_Range_of_Fire,Training_Corr, tmpX, tmpY);
//  oX := xSHIP.PositionX + (tmpX * C_NauticalMile_To_Degree);
//  oY := xSHIP.PositionY + (tmpY * C_NauticalMile_To_Degree);
//
//  Range_Corr          := Dev_Pos_onBscope.y * C_ScaleHeight_on_Bscope;
//  RangeBearingToCoord(Range_Corr,Training_Corr, tmpX, tmpY);
//  oX := oX + (tmpX * C_NauticalMile_To_Degree);
//  oY := oY + (tmpY * C_NauticalMile_To_Degree);
end;

procedure TGenericWCCInterface.DoGunCorrection(TheGun: TGun);
begin
  TfrmBScope(frmScopeB).ApplyCorrection(TheGun);
  if TheGun.Corrected then begin
    TheGun.PosAfterCorr.X := 0.5;
    TheGun.PosAfterCorr.Y := 0.5;
  end;
end;

procedure TGenericWCCInterface.SystemReset;
var i : integer;
    list: TList;
    ob: TObject;
    aTrack: TManualTrack;
begin
  if (FC1.TrackedTarget <> nil) or (FC2.TrackedTarget <> nil)
    or (FC3.TrackedTarget <> nil) then exit;

  list := TrackList.GetList;

  i := list.Count-1;
  while (i>=0) do begin
    aTrack := list.Items[i];
    if aTrack is TManualTrack then aTrack.MarkAs_NeedToBeFree;
    dec(i);
  end;
  TrackList.ReturnList;
end;

procedure TGenericWCCInterface.tes(const Id: byte);
begin
end;

function TGenericWCCInterface.InRangeToFire(TargetPosX,TargetPosY:Double; GunType:byte): Boolean;
var range, MaxRange: Double;
begin
  Result := False;
  range := CalcRange(xSHIP.PositionX, xSHIP.PositionY, TargetPosX, TargetPosY);

  if GunType = g120mm then
    MaxRange := C_GUN1_RANGE
  else
    MaxRange := C_GUN2_RANGE;

  if range <= MaxRange then
    Result := True;

end;

procedure TGenericWCCInterface.GetPHP(GunNumb: byte; var X, Y, Z: Double);
var MuzzleVelocity, tRng, tBrg, tSpd, tCrs : Double;
idx_Mv : Integer;
begin


end;


//procedure TGenericWCCInterface.tembak(pt : tDouble2DPoint; ShipId: Integer; iX, iY, iZ, iTOF: double; LauncherID , MissileID : word);
//var lRec : TRec3DSetWCC;
//   pnt       : TPoint;
//   findObj   : boolean;
//
//begin
//      //Rng := Rng * C_Meter_To_NauticalMiles;
//    //  Rng := Rng ; //- 0.34;    kompensasi jarak
//   pnt := ConvertToScreen(pt.x, pt.Y);
//   findObj := FindTrack_by_ScreenPos(pnt.X, pnt.Y, cTrack);
//   if findObj and (cTrack is TManualTrack) then begin
//      mTrack := (cTrack as TManualTrack);
//      iX := mTrack.PositionX;
//      iY := mTrack.PositionY;
//      iZ := mTrack.PositionZ;
//
//   end;
//      lRec.ShipID           := ShipId;
//      lRec.mLauncherID      := LauncherID;
//      lRec.mMissileID       := C_DBID_WCC_CANNON;
//      lRec.mOrderID         := __ORD_CANNON_F;
//      lRec.mXTarget         := iX;
//      lRec.mYTarget         := iY;
//      lRec.mZTarget         := iZ;
//      lRec.mTOF             := iTOF;
//      if (netSend <> nil) then
//      netSend.sendDataEx(C_REC_MERIAM , @lRec);
//end;

{procedure TGenericWCCInterface.CreateSIMObject(const tipe: TSIMType);
var //simObj: TDetectedObject;
    ship: TXShip;
    dpt : t2DPoint;
    pX, pY: double;
    r, b, s, h: double;
    temp, indx: integer;
begin
  indx := FindDetObjectByUid(C_SIMObjectID);
  if indx <> -1 then begin
    //ActiveRadar.DetObjects.popObject(indx);
    SimCenter.MainObjList.popObject(indx);
  end;

  Randomize;
  temp := Random(trunc(FTDCRangeScale));
  r := temp + random;
  temp := random(360);
  b := temp + random;

  RangeBearingToCoord(r, b, dPt.X, dPt.Y);

  pX := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
  pY := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;

  case tipe of
    tsShip: begin
      temp := Random(20);
      s := temp + random;
      temp := random(360);
      h := temp + random;
    end;
    tsPlane: begin
      temp := Random(70);
      s := temp + random;
      temp := random(360);
      h := temp + random;
    end;
  end;
  Ship := TXShip.Create;
  Ship.CreateDefaultView(FMap);
  Ship.UniqueID := C_SIMObjectID;

  Ship.Speed    := s;
  Ship.Heading  := h;

  Ship.PositionX := pX;
  Ship.PositionY := pY;
  Ship.PositionZ := 0;

  Ship.Enabled := TRUE;
  SimCenter.MainObjList.AddObject(ship);
end; }

procedure TGenericWCCInterface.GetRandomPosition(var x, y, z: double);
var r, b: double;
  dpt : t2DPoint;
begin
  Randomize;
  r := Random(trunc(FTDCRangeScale)) + random;
  b := random(360) + random;
  RangeBearingToCoord(r, b, dPt.X, dPt.Y);
  x := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
  y := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;
  z := 0.0;
end;

procedure TGenericWCCInterface.GetRandomSpeedCourse(var s, c: double; const tipe: TSIMType);
begin
  Randomize;
  case tipe of
    tsShip: begin
      s := Random(20) + random;
      c := Random(360) + random;
    end;
    tsPlane: begin
      s := 40 + Random(70);
      c := random(360) + random;
    end;
  end;
end;

procedure TGenericWCCInterface.CreateSIMObject(const IsCreating: boolean);
var ship, plane: TXShip;
    pX, pY, pZ: double;
    speed, course: double;
    sc1, sc2 : TSimulationClass;
begin
  sc1 := SimCenter.MainObjList.FindObjectByUid(C_SIMUID_Ship);
  if sc1 <> nil then sc1.MarkAs_NeedToBeFree;

  sc2 := SimCenter.MainObjList.FindObjectByUid(C_SIMUID_Plane);
  if sc2 <> nil then sc2.MarkAs_NeedToBeFree;

  if IsCreating then begin
//    GetRandomPosition(pX, pY, pZ);
//    GetRandomSpeedCourse(speed, course, tsShip);

//    Ship := TXShip.Create;
//    Ship.CreateDefaultView(FMap);
//    Ship.UniqueID := C_SIMUID_Ship;
//    Ship.Speed    := speed;
//    Ship.Heading  := course;
//    Ship.PositionX := pX;
//    Ship.PositionY := pY;
//    Ship.PositionZ := pZ;
//    Ship.Enabled := TRUE;
//    SimCenter.MainObjList.AddObject(ship);
//
////    GetRandomPosition(pX, pY, pZ);
////    GetRandomSpeedCourse(speed, course, tsPlane);
//
//    plane := TXShip.Create;
//    plane.CreateDefaultView(FMap);
//    plane.UniqueID := C_SIMUID_Plane;
//    plane.Speed    := speed;
//    plane.Heading  := course;
//    plane.PositionX := pX;
//    plane.PositionY := pY;
//    plane.PositionZ := pZ;
//    plane.Enabled := TRUE;
//    SimCenter.MainObjList.AddObject(plane);
//
    //------------
    SIMObject_ship1 := TXShip.Create;
    SIMObject_ship1.CreateDefaultView(FMap);
    SIMObject_ship1.UniqueID := 'VSL1000';
    SIMObject_ship1.Speed    := 0;
    SIMObject_ship1.Heading  := 180;
//    SIMObject_ship1.PositionX := 112.92660465;;
//    SIMObject_ship1.PositionY := -7.30799794;
    SIMObject_ship1.PositionX := 119.40525559;
    SIMObject_ship1.PositionY := 0.69002319;
    SIMObject_ship1.PositionZ := 0;
    SIMObject_ship1.Enabled := TRUE;
    SimCenter.MainObjList.AddObject(SIMObject_ship1);

    SIMObject_ship2 := TXShip.Create;
    SIMObject_ship2.CreateDefaultView(FMap);
    SIMObject_ship2.UniqueID := 'VSL1023';
    SIMObject_ship2.Speed    := 0;
    SIMObject_ship2.Heading  := 90;
//    SIMObject_ship2.PositionX := 112.82082005;
//    SIMObject_ship2.PositionY := -7.17766928;
    SIMObject_ship2.PositionX := 119.30525559;
    SIMObject_ship2.PositionY := 0.89002319;
    SIMObject_ship2.PositionZ := 0;
    SIMObject_ship2.Enabled := TRUE;
    SimCenter.MainObjList.AddObject(SIMObject_ship2);
  end;
end;

procedure TGenericWCCInterface.ClearSIMObject;
var    sc1, sc2 : TSimulationClass;
begin
  sc1 := SimCenter.MainObjList.FindObjectByUid('VSL1000');
  if sc1 <> nil then sc1.MarkAs_NeedToBeFree;

  sc2 := SimCenter.MainObjList.FindObjectByUid('VSL1023');
  if sc2 <> nil then sc2.MarkAs_NeedToBeFree;

//  if Assigned(SIMObject_ship1) then
//      SimCenter.MainObjList.RemoveObject(SIMObject_ship1);
//  if Assigned(SIMObject_ship2) then
//      SimCenter.MainObjList.RemoveObject(SIMObject_ship2);
end;

{procedure TGenericWCCInterface.GetAnduData(const aFC: byte; var aData: TFireControlData);
var r, b, c, s: double;
    FC: TFireControl;
begin
  case aFC of
  1: FC := FC1;
  2: FC := FC2;
  3: FC := FC3;
  end;

  if FC.TrackedTarget <> nil then
  begin
    r := CalcRange(xSHIP.PositionX, xSHIP.PositionY,
      FC.TrackedTarget.PositionX, FC.TrackedTarget.PositionY) * C_NauticalMiles_To_Yard;
    aData.range := IntToStr(Floor(r));

    b := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
      FC.TrackedTarget.PositionX, FC.TrackedTarget.PositionY);
    aData.bearing := Format('%3.2f', [b]);

    aData.course := IntToStr(Floor(FC.TrackedTarget.Course));
    aData.speed := IntToStr(Floor(FC.TrackedTarget.Speed));
  end
  else begin
    aData.range := '';
    aData.bearing := '';
    aData.course := '';
    aData.speed := '';
  end;
end;               }

function TGenericWCCInterface.IsFireControlInUse(const aFC: byte): boolean;
var FC: TFireControl;
begin
  case aFC of
    1: FC := FC1;
    2: FC := FC2;
    3: FC := FC3;
  end;

  if FC.TrackedTarget <> nil then
    result := true
  else
    result := false;
end;

// bearing correction
procedure TGenericWCCInterface.LineCorrection(var oX, oY: double; GunNum : word);
var LineCorr, CurrBearing, CurrRange, BearingCorr, tmpX, tmpY : Double;
begin
  if WCCAndu.Page_2[C_LNCorr][GunNum].ToString = '' then
    LineCorr := 0.0
  else
    LineCorr := WCCAndu.Page_2[C_LNCorr][GunNum].GetDoubleValue;

  CurrRange    := CalcRange(xSHIP.PositionX, xSHIP.PositionY, oX, oY);
  CurrBearing  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, oX, oY);
  BearingCorr  := ValidateDegree(CurrBearing + (LineCorr * C_Mils_To_Degree));
  RangeBearingToCoord(CurrRange, BearingCorr, tmpX, tmpY);
  oX := xSHIP.PositionX + (tmpX * C_NauticalMile_To_Degree);
  oY := xSHIP.PositionY + (tmpY * C_NauticalMile_To_Degree);
  OffsetPoint_Marker.Visible := true;
  OffsetPoint_SetPosition(oX, oY);
end;

// Range correction
procedure TGenericWCCInterface.RangeCorrection(var oX, oY : double;
GunNum: word);
Var initialRange, RangeCorr,
     CurrBearing, tmpX, tmpY : Double;
begin
  if WCCAndu.Page_2[C_RGCorr][GunNum].ToString = '' then
    RangeCorr:= 0.0
  else
    RangeCorr:= WCCAndu.Page_2[C_RGCorr][GunNum].GetDoubleValue;

  CurrBearing  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, oX, oY);
  RangeBearingToCoord(RangeCorr * C_Yard_To_NauticalMiles, CurrBearing, tmpX, tmpY);

  oX := oX + (tmpX * C_NauticalMile_To_Degree);
  oY := oY + (tmpY * C_NauticalMile_To_Degree);

//  OffsetPoint_Marker.Visible := true;
//  OffsetPoint_SetPosition(oX, oY);
end;

procedure TGenericWCCInterface.DoCorrectionManDirBomb(TheGun: TGun; var Brg, Elv: double);
var FireDirection : Double;
    RangeCorr, LineCorr, ElevCorr : Double;
    TxtLineCorr, TxtRngCorr, TxtElevCorr : TEdit;
begin
  case TheGun.ID of
    1 : begin
        TxtLineCorr := TfrmAndu(frmAnduNala).Andu2101;
        TxtRngCorr  := TfrmAndu(frmAnduNala).Andu2111;
        TxtElevCorr := TfrmAndu(frmAnduNala).Andu2121;
       end;
    2 : begin
        TxtLineCorr := TfrmAndu(frmAnduNala).Andu2102;
        TxtRngCorr  := TfrmAndu(frmAnduNala).Andu2112;
        TxtElevCorr := TfrmAndu(frmAnduNala).Andu2122;
       end;
    3 : begin
        TxtLineCorr := TfrmAndu(frmAnduNala).Andu2103;
        TxtRngCorr  := TfrmAndu(frmAnduNala).Andu2113;
        TxtElevCorr := TfrmAndu(frmAnduNala).Andu2123;
       end;
  end;

   LineCorr:= StrToFloatDef(TxtLineCorr.Text,0.0);
   RangeCorr:= StrToFloatDef(TxtRngCorr.Text,0.0);
   ElevCorr:= StrToFloatDef(TxtElevCorr.Text,0.0);

//  if WCCAndu.Page_2[C_LNCorr][TheGun.ID].ToString = '' then
//    LineCorr := 0.0
//  else
//    LineCorr := WCCAndu.Page_2[C_LNCorr][TheGun.ID].GetDoubleValue;
//
//  if WCCAndu.Page_2[C_RGCorr][TheGun.ID].ToString = '' then
//    RangeCorr:= 0.0
//  else
//    RangeCorr:= WCCAndu.Page_2[C_RGCorr][TheGun.ID].GetDoubleValue;
//
//  if WCCAndu.Page_2[C_ElCorr][TheGun.ID].ToString = '' then
//    ElevCorr:= 0.0
//  else
//    ElevCorr:= WCCAndu.Page_2[C_ElCorr][TheGun.ID].GetDoubleValue;

  Brg := (LineCorr * C_Mils_To_Degree);

  if TheGun.ID = 1 then
    Elv := Gun120_ConvertRangeToElev(RangeCorr * C_Yard_To_Meter) + (ElevCorr * C_Mils_To_Degree)
  else
    Elv := Gun40_ConvertRangeToElev(RangeCorr * C_Yard_To_Meter) + (ElevCorr * C_Mils_To_Degree);

//  LineCorrection(oX, oY, TheGun.ID);
//  RangeCorrection(oX, oY ,TheGun.ID);
end;

procedure TGenericWCCInterface.DoCorrectionInDirAndBlindBomb(TheGun: TGun; var Brg, Elv: double);
var BearingOTL, LeftRight, AddDrop : Double;
    posX, posY,
    oX, oY,
    tmpX, tmpY,
    crossAngle,
    NewRange  : Double;
begin

  BearingOTL  := StrToFloatDef(TfrmAndu(frmAnduNala).Andu306.Text,0.0);
  AddDrop     := StrToFloatDef(TfrmAndu(frmAnduNala).Andu307.Text,0.0) * C_Yard_To_NauticalMiles;
  LeftRight   := StrToFloatDef(TfrmAndu(frmAnduNala).Andu308.Text,0.0) * C_Yard_To_NauticalMiles;

  if TheGun.AssignTo.IsDoingBlindBomb or TheGun.AssignTo.GenFix then
  begin
    posX := TheGun.AssignTo.TrackedTarget.PositionX;
    posY := TheGun.AssignTo.TrackedTarget.PositionY;
  end;

  if TheGun.AssignTo.IsDoingIndBomb then
  begin
    posX := OffsetPoint_Marker.mPos.X;
    posY := OffsetPoint_Marker.mPos.Y;
  end;

  if TheGun.AssignTo.ThrowOff then
  begin
    posX := ThrowOff_Marker.mPos.X;
    posY := ThrowOff_Marker.mPos.Y;
  end;

  RangeBearingToCoord(AddDrop, BearingOTL, tmpX, tmpY);
  oX := posX + (tmpX * C_NauticalMile_To_Degree);
  oY := posY + (tmpY * C_NauticalMile_To_Degree);

  crossAngle := ValidateDegree(BearingOTL + 90);
  RangeBearingToCoord(LeftRight, crossAngle, tmpX, tmpY);
  oX := oX + (tmpX * C_NauticalMile_To_Degree);
  oY := oY + (tmpY * C_NauticalMile_To_Degree);

  NewRange  := CalcRange(xSHIP.PositionX, xSHIP.PositionY, oX, oY)* C_NauticalMiles_TO_Meter;
  if TheGun.ID = 1 then
    Elv := Gun120_ConvertRangeToElev(NewRange)
  else
    Elv := Gun40_ConvertRangeToElev(NewRange);
  Brg       := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, oX, oY);

//  OffsetPoint_Marker.Visible := true;
//  OffsetPoint_SetPosition(oX, oY);
end;

procedure TGenericWCCInterface.RecvWCCSettingConsole(aRec: TRecStatus_Console);
begin
    if aRec.OWN_SHIP_UID  = xSHIP.UniqueID then begin
      case aRec.ErrorID of
        __STAT_RRNF : begin  // Blm Kontak, Tabuzone, dll
           IsRRNF_on := ReadValConsoleSetting(aRec.ParamError);
           if IsRRNF_on then
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRRNF, BtnC.redROUND_On)
           else
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRRNF, BtnC.redROUND_Off);
        end;
        __STAT_RPC_LPC : begin
           IsRPC_on := ReadValConsoleSetting(aRec.ParamError);
           if IsRPC_on then begin
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRPCRDY, BtnC.greenROUND_On);
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpLPCRDY, BtnC.orangeROUND_Off);
           end
           else begin
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRPCRDY, BtnC.greenROUND_Off);
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpLPCRDY, BtnC.orangeROUND_On);
           end;
        end;
        __STAT_RDY_RH_LH_MAG: begin
           IsRDY_RH_MAG_on := ReadValConsoleSetting(aRec.ParamError);
           if IsRDY_RH_MAG_on then begin
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRMAGRDY, BtnC.redROUND_Off);
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpLMAGRDY , BtnC.redROUND_On);
           end
           else begin
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpRMAGRDY, BtnC.redROUND_On);
              BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpLMAGRDY, BtnC.redROUND_Off);
           end;
        end;
        __STAT_RADAR_ERROR : begin
           IsRadarError := ReadValConsoleSetting(aRec.ParamError);
           if IsRadarError then begin
             BtnC.UpdateImage(TfrmWCCPanelAtas(frmWCCAtas1).imgLmpRadar , BtnC.redROUND_On);
             TfrmWCCPanelAtas2(frmWCCAtas2).btnRadarStandBy.Click;
           end
           else
           begin
             BtnC.UpdateImage(TfrmWCCPanelAtas(frmWCCAtas1).imgLmpRadar, BtnC.redROUND_Off);
           end;
        end;
        __STAT_COMPUTER : begin
           IsCompError := ReadValConsoleSetting(aRec.ParamError);
           if IsCompError then begin
              BtnC.UpdateImage(TfrmWCCPanelAtas(frmWCCAtas1).LmpComp, BtnC.redROUND_On);
              TfrmWCCPanelAtas(frmWCCAtas1).PowerOff;
           end
           else
               BtnC.UpdateImage(TfrmWCCPanelAtas(frmWCCAtas1).LmpComp, BtnC.redROUND_Off);
        end;
         __STAT_SYN_GUN2 : begin
           IsGun2Syn := ReadValConsoleSetting(aRec.ParamError);
           if IsGun2Syn then begin
            BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpG2SYNC, BtnC.redROUND_On);
           end
           else
            BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpG2SYNC, BtnC.redROUND_Off);
         end;
         __STAT_SYN_GUN3 : begin
           IsGun3Syn := ReadValConsoleSetting(aRec.ParamError);
           if IsGun3Syn then begin
            BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpG2SYNC, BtnC.redROUND_On);
           end
           else
            BtnC.UpdateImage(TfrmWCCPanelAtas2(frmWCCAtas2).lmpG2SYNC, BtnC.redROUND_Off);
         end;
      end;
    end;
end;

function TGenericWCCInterface.GetAnduIndex(const aCode: string): byte;
var baseCode: integer;
begin
  baseCode := StrToInt(Copy(aCode, 0, 3));

  if (shipClassID = C_ShipC_Fatahillah) or (shipClassID = C_ShipC_Mandau) then begin  // nala or rencong
    case baseCode of
      101: result := C_WindSpeed;
      102: result := C_WindDir;
      103: result := C_AirTemp;
      104: result := C_AirPressure;
      105: result := C_MuzzleV1;
      106: result := C_MuzzleV2;
      107: if (shipClassID = C_ShipC_Fatahillah) then result := C_MuzzleV3; //cm nala
      108: result := C_Latitude;
      109: result := C_AirTargetHeight;
      115: result := C_OwnSpeed;

      202: result := C_FCBearing;
      203: result := C_FCRange;
      204: result := C_FCHeight;
      206: result := C_FCCourse;
      207: result := C_FCSpeed;
      210: result := C_LNCorr;
      211: result := C_RGCorr;
      212: result := C_ElCorr;

      301: result := C_TgtBearing;
      302: result := C_TgtRange;
      303: result := C_TgtHeight;
      304: result := C_CurrentCourse;
      305: result := C_CurrentSpeed;
      306: result := C_OTL;
      307: result := C_AddDroppOTL;
      308: result := C_LeftrightOTL;
      309: result := C_OffSetBearing;
      310: result := C_OffSetRange;

    end;
  end
  else if shipClassID = C_ShipC_Singa then begin      // fpb singa
    case baseCode of
      101: result := C_WindSpeed;
      102: result := C_WindDir;
      103: result := C_AirTemp;
      104: result := C_AirPressure;
      105: result := C_MuzzleV1;
      106: result := C_MuzzleV2;
      108: result := C_CCGun1;
      109: result := C_Latitude;
      110: result := C_AirTargetHeight;
      112: result := C_OwnSpeed;

      202: result := C_FCBearing;
      203: result := C_FCRange;
      204: result := C_FCHeight;
      206: result := C_FCCourse;
      207: result := C_FCSpeed;
      209: result := C_TOF;
      210: result := C_LNCorr;
      211: result := C_RGCorr;
      212: result := C_ElCorr;

      301: result := C_TgtBearing;
      302: result := C_TgtRange;
      303: result := C_TgtHeight;
      304: result := C_CurrentCourse;
      305: result := C_CurrentSpeed;
      306: result := C_OTL;
      307: result := C_AddDroppOTL;
      308: result := C_LeftrightOTL;
      309: result := C_OffSetBearing;
      310: result := C_OffSetRange;
    end;
  end;
end;

procedure TGenericWCCInterface.UpdateAnduData;
begin
  // page 1
  WCCAndu.Page_1[C_OwnSpeed].SetValue(xSHIP.Speed);
  // page 2
  InsertIntoPage2(1);
  InsertIntoPage2(2);
  InsertIntoPage2(3);
end;

procedure TGenericWCCInterface.InsertIntoPage2(const indx: integer);
var FC: TFireControl;
    r, b, c, s, h: double;
begin
  case indx of
    1: FC := FC1;
    2: FC := FC2;
    3: FC := FC3;
  end;

  if FC.TrackedTarget <> nil then
  begin
    r := CalcRange(xSHIP.PositionX, xSHIP.PositionY,
      FC.TrackedTarget.PositionX, FC.TrackedTarget.PositionY) * C_NauticalMiles_To_Yard;
    b := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
      FC.TrackedTarget.PositionX, FC.TrackedTarget.PositionY);
    h := FC.TrackedTarget.PositionZ * C_Meter_To_Feet;

    c := FC.TrackedTarget.Course;
    s := FC.TrackedTarget.Speed;

    WCCAndu.Page_2[C_FCRange][indx].SetValue(FloatToStr(r));
    WCCAndu.Page_2[C_FCBearing][indx].SetValue(FloatToStr(b));
    WCCAndu.Page_2[C_FCHeight][indx].SetValue(FloatToStr(h));
    WCCAndu.Page_2[C_FCCourse][indx].SetValue(FloatToStr(c));
    WCCAndu.Page_2[C_FCSpeed][indx].SetValue(FloatToStr(s));
  end
  else begin
    WCCAndu.Page_2[C_FCRange][indx].ClearValue;
    WCCAndu.Page_2[C_FCBearing][indx].ClearValue;
    WCCAndu.Page_2[C_FCHeight][indx].ClearValue;
    WCCAndu.Page_2[C_FCCourse][indx].ClearValue;
    WCCAndu.Page_2[C_FCSpeed][indx].ClearValue;
  end;
end;


function TGenericWCCInterface.CekDataBalistik: boolean;
var i: integer;
begin
  // C_WindSpeed        = 1;
  // C_WindDir  		    = 2;
  // C_AirTemp  		    = 3;
  // C_AirPressure	    = 4;
  // C_MuzzleV1 		    = 5;
  // C_MuzzleV2 		    = 6;
  // C_MuzzleV3 		    = 7;
  // C_Latitude 		    = 8; // nala & rencong
  // C_CorrGun1         = 8; // singa
  // C_AirTargetHeight  = 9;
  // C_OwnSpeed 		    = 10;

  result := false;

  for i := C_WindSpeed to C_AirTargetHeight do
  begin
    if (i <> C_MuzzleV3) then begin
      if WCCAndu.Page_1[i].IsEmpty then Exit
    end
    else begin
      if (shipClassID = C_ShipC_Fatahillah) and
        (WCCAndu.Page_1[i].IsEmpty) then Exit;
    end;
  end;

  result := true;

end;

procedure TGenericWCCInterface.WCC_FireGunLagi(const GunNumber: byte);
var aRec      : TRecMeriam;
    TheGun    : TGun;
    indx  : byte;
    GunElevation, RangeAffected, jarakTarget, bearingTarget, pX, pY : double;
    dPt : t2DPoint;
    Mv : Double;
begin

  if not CekDataBalistik then exit;

  case GunNumber of
    1: begin
      TheGun := Gun1;
      indx := C_MuzzleV1;
    end;
    2: begin
      TheGun := Gun2;
      indx := C_MuzzleV2;
    end;
    3: begin
      TheGun := Gun3;
      indx := C_MuzzleV3;
    end;
  end;

  if (TheGun.AssignTo = nil) or (TheGun.AssignTo.TrackedTarget = nil) then exit;

  jarakTarget := Floor(CalcRange(xSHIP.PositionX, xSHIP.PositionY, TheGun.AssignTo.TrackedTarget.PositionX,
    TheGun.AssignTo.TrackedTarget.PositionY) * C_NauticalMiles_TO_Meter);

  bearingTarget := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, TheGun.AssignTo.TrackedTarget.PositionX,
    TheGun.AssignTo.TrackedTarget.PositionY);

  Mv := WCCAndu.Page_1[indx].GetDoubleValue;
  GunElevation := ModulKoreksi.GetElevation(jarakTarget, Mv,
    WCCAndu.Page_1[C_AirPressure].GetDoubleValue, WCCAndu.Page_1[C_AirTemp].GetDoubleValue,
    WCCAndu.Humidity.GetDoubleValue, WCCAndu.Page_1[C_WindSpeed].GetDoubleValue,
    xSHIP.Speed, TheGun.AssignTo.TrackedTarget.Speed);

  if not WCCAndu.Page_2[C_ElCorr][GunNumber].IsEmpty then       //GunElevation in degrees
    GunElevation := GunElevation + (WCCAndu.Page_2[C_ElCorr][GunNumber].GetDoubleValue * C_Mils_To_Degree);

  RangeAffected := ModulKoreksi.GetTargetRange(jarakTarget, WCCAndu.Page_1[C_AirPressure].GetDoubleValue,
    WCCAndu.Page_1[C_AirTemp].GetDoubleValue, GunElevation);

  if not WCCAndu.Page_2[C_RGCorr][GunNumber].IsEmpty then       //RangeAffected in meters
    RangeAffected := RangeAffected + (WCCAndu.Page_2[C_RGCorr][GunNumber].GetDoubleValue * C_Yard_To_Meter);

  //RangeAffected in NauticalMiles
  RangeAffected := RangeAffected * C_Meter_To_NauticalMiles;

  if not WCCAndu.Page_2[C_LNCorr][GunNumber].IsEmpty then       //Bearing in degrees
    bearingTarget := bearingTarget + (WCCAndu.Page_2[C_LNCorr][GunNumber].GetDoubleValue * C_Mils_To_Degree);

  WCCAndu.Page_2[C_TOF][GunNumber].SetValue(jarakTarget / WCCAndu.Page_1[indx].GetDoubleValue);

  RangeBearingToCoord(RangeAffected, bearingTarget, dPt.X, dPt.Y);
  pX := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
  pY := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;

  if GunNumber = 1 then begin
    OBMRight.mPos.X := pX;
    OBMRight.mPos.Y := pY;
    OBMRight.Center  := ConvertToScreen(OBMRight.mPos.X, OBMRight.mPos.Y);
  end
  else begin
    OBMLeft.mPos.X := pX;
    OBMLeft.mPos.Y := pY;
    OBMLeft.Center  := ConvertToScreen(OBMLeft.mPos.X, OBMLeft.mPos.Y);
  end;

  with aRec do begin
    ShipID      := UniqueID_To_dbID(xSHIP.UniqueID);
    OrderID     :=  __ORD_CANNON_F;
    Gun_number  := GunNumber;
    X           := pX;
    Y           := pY;
  end;
  netSend.sendDataEx(C_REC_CANNON, @aRec);

  TheGun.TOF := Ceil(WCCAndu.Page_2[C_TOF][GunNumber].GetDoubleValue);

  if TheGun.TOF <= 2 then begin
    TheGun.PHPStart := 0;
    TheGun.PHPEnd := 2;
  end
  else begin
    TheGun.PHPStart := Round(TheGun.TOF - 2);     // modif by bagoes
    TheGun.PHPEnd := Round(TheGun.TOF + 2);
  end;
  TheGun.Firing := True;

end;

procedure TGenericWCCInterface.SetGunReady;
begin
  Gun1.ReadyToFire := (Gun1.AssignTo <> nil) and (Gun1.AssignTo.TrackedTarget <> nil)
    and Gun1.PowerOn and (Gun1.IsBlind = false) and Gun1.IsInRange;
  Gun2.ReadyToFire := (Gun2.AssignTo <> nil) and (Gun2.AssignTo.TrackedTarget <> nil)
    and Gun2.PowerOn and (Gun2.IsBlind = false) and Gun2.IsInRange;
  Gun3.ReadyToFire := (Gun3.AssignTo <> nil) and (Gun3.AssignTo.TrackedTarget <> nil)
    and Gun3.PowerOn and (Gun3.IsBlind = false) and Gun3.IsInRange;
end;

procedure TGenericWCCInterface.RunGun(const aDeltaMs: double);
begin
  // Gun 1
  if Gun1Pressed then Gun1.FireBreakTimer := Gun1.FireBreakTimer + aDeltaMs // ms
  else Gun1.FireBreakTimer := 0.0;

  if (Gun1.FireBreakTimer > 0) and (Gun1.FireBreakTimer < (1.5 * aDeltaMs)) then  // first round
    WCC_FireGunLagi(1)
  else if (Gun1.FireBreakTimer * 0.001) > (60 / C_DefaultRateOfFire) then begin   // 2nd round and so on
    Gun1.FireBreakTimer := 0.0;
    WCC_FireGunLagi(1);
  end;

  // Gun 2
  if Gun2Pressed then Gun2.FireBreakTimer := Gun2.FireBreakTimer + aDeltaMs // ms
  else Gun2.FireBreakTimer := 0.0;

  if (Gun2.FireBreakTimer > 0) and (Gun2.FireBreakTimer < (1.5 * aDeltaMs)) then  // first round
    WCC_FireGunLagi(2)
  else if (Gun2.FireBreakTimer * 0.001) > (60 / C_DefaultRateOfFire) then begin   // 2nd round and so on
    Gun2.FireBreakTimer := 0.0;
    WCC_FireGunLagi(2);
  end;

  // Gun 3
  if Gun3Pressed then Gun3.FireBreakTimer := Gun3.FireBreakTimer + aDeltaMs // ms
  else Gun3.FireBreakTimer := 0.0;

  if (Gun3.FireBreakTimer > 0) and (Gun3.FireBreakTimer < (1.5 * aDeltaMs)) then  // first round
    WCC_FireGunLagi(3)
  else if (Gun3.FireBreakTimer * 0.001) > (60 / C_DefaultRateOfFire) then begin   // 2nd round and so on
    Gun3.FireBreakTimer := 0.0;
    WCC_FireGunLagi(3);
  end;
end;

procedure TGenericWCCInterface.CalcHitPredition(
   const tRange, tBearing, tSpeed, tCourse: double;
   const pSpeed: double;
   var hRange, hBearing, hTime, hSpeed: double);
var vR : double;
    tMinute: double;
    dA, dB, dC : double;
    sinA, sinB, sinC : double;
begin
//   a : target speed
//    b : relatif speed.
//    c : torpedo speed

   if  abs(pSpeed) < 0.00000001 then exit;

   dC := 180 - (tBearing - tCourse);
   sinC := sin(DegToRad(dC));
   sinA := (tSpeed * sinC)/ pSpeed;
   dA := RadToDeg(ArcSin(sinA));
   dB := 180 - dC - dA;
   sinB := Sin(DegToRad(dB));

   if  abs(sinC) < 0.00000001 then begin
      vR := pSpeed + tSpeed * cos(DegToRad(dC));
   end
   else begin
      vR := (pSpeed * sinB) / sinC;
   end;
   hBearing := tCourse + dB;

   if abs(vR) < 0.00000001 then begin
     hTime  := 99999.99;  //  tidak terkejar
     hRange := 99999.99;  //
   end
   else begin
     // hTime := (tRange / vR) / 3600;  // secon
     hTime := (tRange / pSpeed) / 3600;  // secon
     hRange := hTime * pSpeed;
   end;

   hSpeed := Vr;
end;

procedure TGenericWCCInterface.SendEvenWCC_120mm(EvenId: Word;
  const Prm1: double; Prm2, Prm3: double);
begin
  SendLogEvenConsole(netSend , UniqueID_To_dbID(xSHIP.UniqueID), C_DBID_CANNON120 , EvenId, Prm1, Prm2, Prm3);
end;

end.
