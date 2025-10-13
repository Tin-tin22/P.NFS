unit uLibWCCku;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  SpeedButtonImage, ExtCtrls, uDetected, uLibTDCDisplay,
  MapXLib_TLB, uBaseFunction, uTDCConstan, uBaseDataType, uBaseConstan, Types, uLibTDCClass;

type
  TBtnType    = (TBSpring, TBLock);
  //TBtnStatus  = (TBOn, TbOff);
  TBtnColor   = (GreenBOX, GreenROUND, RedBOX, RedROUND, OrangeBOX, OrangeROUND, BlueBOX, sGreenBOX, sGreenROUND, sOrangeBOX, sOrangeROUND, sBlueBOX);
  Ttype_of_Gun = (Gun40mm, Gun76mm, Gun120mm);
//==============================================================================
  TBtnCol = class
  public
    redBOX_On: TBitmap;
    redBOX_Off: TBitmap;
    redROUND_On: TBitmap;
    redROUND_Off: TBitmap;
    greenBOX_On: TBitmap;
    greenBOX_Off: TBitmap;
    orangeBOX_On: TBitmap;
    orangeBOX_Off: TBitmap;
    greenROUND_On: TBitmap;
    greenROUND_Off: TBitmap;
    orangeROUND_On: TBitmap;
    orangeROUND_Off: TBitmap;
    blueBOX_On: TBitmap;
    blueBOX_Off: TBitmap;
    switch_On: TBitmap;
    switch_Off: TBitmap;

    sgreenBOX_On: TBitmap;
    sgreenBOX_Off: TBitmap;
    sorangeBOX_On: TBitmap;
    sorangeBOX_Off: TBitmap;
    sgreenROUND_On: TBitmap;
    sgreenROUND_Off: TBitmap;
    sorangeROUND_On: TBitmap;
    sorangeROUND_Off: TBitmap;
    sblueBOX_On: TBitmap;
    sblueBOX_Off: TBitmap;


  public
    HeatLampOn : TColor;
    HeatLampOff : TColor;

    constructor Create;
    destructor Destroy; override;

    procedure BuatBitmap;

    procedure UpdateBtnImage(btn: TSpeedButtonImage; img: TBitmap); overload;
    procedure UpdateLockBtnImage(btn: TSpeedButtonImage; warna: TBtnColor);
    procedure UpdateImage(Timg: TImage; img: TBitmap); overload;
    procedure SpringLoaded(btn: TSpeedButtonImage);

    procedure UpdateButton(btn: TSpeedButtonImage; const tipe: TBtnType; const Kolor: TBtnColor; const aStatus: boolean);
    procedure UpdateImage(Timg: TImage; const Kolor: TBtnColor; const aStatus: boolean); overload;
    procedure UpdateBtnImage(btn: TSpeedButtonImage; const Kolor: TBtnColor; const aStatus: boolean); overload;
  end;
//==============================================================================
  TRadarku = class
  public
    Status: RADAR_STATUS;
    FreqType: FREQ_TYPE;
    FreqBand: FREQ_BAND;
    ScanType: SCAN_TYPE;
    Polarization: POLARIZATION_TYPE;
    PRF: PRF_TYPE;
    //IsDoingOffCent: Boolean;
    IsElevating: boolean;

    constructor Create;
    destructor Destroy; override;
  end;

//==============================================================================
   TWcc = class
   public
      PowerON: Boolean;
      SystemON: Boolean;
      Radar: TRadarku;
      Saklar: array[1..25] of Boolean;

      constructor Create;
      destructor Destroy; override;

      function CekSaklar(): Boolean;
   end;

//==============================================================================
{   TFireControl = class
   public
      Name: String;
      IsTracking: boolean;
      TrackedTarget: TManualTrack;
      //HasEcho: boolean;
      HasGun: boolean;
      GenFix: boolean;
      ThrowOff: boolean;
      //TargetUID: String;
      Detected : TDetectedObject;

      constructor Create;
      destructor Destroy; override;
   end;           }
//==============================================================================
  TGun = class
  public
    Isfunctionalized  : Boolean;
    PowerOn           : Boolean;
    Synchronized      : Boolean;  // pada gun2,3 ato local/remote pada gun1
    GunType           : Ttype_of_Gun;
    IsAssigning       : Boolean;
    //ParPROX : Boolean;       // gun1,2,3
    AssignTo          : TFireControl;
    Bullet1Type       : byte;      // 0=IMPACT, 1=PAR PROX
    Bullet2Type       : byte;      // 0=HE TRCR, 1=PRE FRAG, gun2 or 3 only
    MuzzleVelocity    : double;
    ID                : byte;
    FireBreakTimer    : double;
    Salvo             : boolean;
    IsSalvoFiring     : Boolean;
    // cm status
    IsBlind, IsInRange: boolean;
    TOF: single; //change by bagoes
    ReadyToFire, Firing: boolean;
    Corrected: boolean;
    PHPStart, PHPEnd, PHPCounter: Integer; //change by bagoes
    PosSplash, PosBeforeCorr, LastposCorr , PosAfterCorr: t2DPoint;

    constructor Create(const Jenis: integer);
    procedure OpenFire;
  end;
//==============================================================================
  TElevationMark = class(TTDC_Cursor)
  protected
    ptH2, ptH3 : TPoint;
  public
    constructor Create;

    procedure Draw(aCnv: TCanvas);       virtual;
    procedure ConvertCoord(aMap: TMap);  override;
  end;
//==============================================================================
  TAnduDataType = class
  private
    FDoubleValue  : double;
    FStringValue  : string;
    FCleared      : boolean;
  public
    constructor Create;

    procedure SetValue(const aVal: string); overload;
    procedure SetValue(const aVal: double); overload;

    function GetDoubleValue: double;
    function ToString: string;
    function ToFlooredString: string;

    procedure ClearValue;
    function IsEmpty: boolean;
  end;

  TAnduWCC = class
  public
    Page_1 : array [1..10] of TAnduDataType;
    Page_2 : array [1..9] of array [1..3] of TAnduDataType;
    Page_3 : array [1..14] of TAnduDataType;

    Humidity : TAnduDataType;

    constructor Create;
  end;

const
  // page 1
  C_WindSpeed        = 1;
  C_WindDir  		     = 2;
  C_AirTemp  		     = 3;
  C_AirPressure	     = 4;
  C_MuzzleV1 		     = 5;
  C_MuzzleV2 		     = 6;
  C_MuzzleV3 		     = 7;
  C_Latitude 		     = 8; // nala & rencong
  C_CCGun1         = 8; // singa
  C_AirTargetHeight  = 9;
  C_OwnSpeed 		     = 10;

  // page 2
  C_FCBearing     = 1;
  C_FCRange       = 2;
  C_FCHeight      = 3;
  C_FCCourse      = 4;
  C_FCSpeed       = 5;
  C_TOF           = 6;
  C_LNCorr        = 7;
  C_RGCorr        = 8;
  C_ElCorr        = 9;

  // page 3
  C_TgtBearing    = 1;
  C_TgtRange      = 2;
  C_TgtHeight     = 3;
  C_CurrentCourse = 4;
  C_CurrentSpeed  = 5;
  C_OTL           = 6;
  C_AddDroppOTL   = 7;
  C_LeftrightOTL  = 8;
  C_OffSetBearing = 9;
  C_OffSetRange   = 10;
  C_Gun_Tgt_Line  = 11;
  C_Gun1TOF       = 12;
  C_Gen_Tgt_Bearing = 13;
  C_Gen_Tgt_Range   = 14;

  C_DefaultHumidity = 60;

  C_DefaultRateOfFire = 20;

var
  BtnC: TBtnCol;
  ConsoleWCC : TWcc;

implementation

//**********************************************//
//      TWCC                                    //
//**********************************************//
constructor Twcc.Create;
begin
  inherited;
  self.Radar := TRadarku.Create;
end;

destructor Twcc.Destroy;
begin
  inherited;
end;

function TWcc.CekSaklar(): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 1 to 25 do begin
    if not saklar[i] then
      Result := False;
  end;
end;

//**********************************************//
//      BTN                                     //
//**********************************************//
constructor TBtnCol.Create;
begin
  inherited;

  BuatBitmap;

  HeatLampOn := RGB(255,255,0);
  HeatLampOff := RGB(255,200,0);
end;

destructor TBtnCol.Destroy;
begin
  inherited;
end;

procedure TBtnCol.BuatBitmap();
var s: string;
begin
  redBOX_On := TBitmap.Create;
  redBOX_Off := TBitmap.create;
  redROUND_On := TBitmap.Create;
  redROUND_Off := TBitmap.Create;
  greenBOX_On := TBitmap.Create;
  greenBOX_Off := TBitmap.Create;
  greenROUND_On := TBitmap.Create;
  greenROUND_Off := TBitmap.Create;
  orangeBOX_On := TBitmap.Create;
  orangeBOX_Off := TBitmap.Create;
  orangeROUND_On := TBitmap.Create;
  orangeROUND_Off := TBitmap.Create;
  blueBOX_On := TBitmap.Create;
  blueBOX_Off := TBitmap.Create;

  switch_On := TBitmap.Create;
  switch_Off := TBitmap.Create;

  sgreenBOX_On := TBitmap.Create;
  sgreenBOX_Off := TBitmap.Create;
  sgreenROUND_On := TBitmap.Create;
  sgreenROUND_Off := TBitmap.Create;
  sorangeBOX_On := TBitmap.Create;
  sorangeBOX_Off := TBitmap.Create;
  sorangeROUND_On := TBitmap.Create;
  sorangeROUND_Off := TBitmap.Create;
  sblueBOX_On := TBitmap.Create;
  sblueBOX_Off := TBitmap.Create;

  redBOX_On.LoadFromFile(C_IMAGES_PATH+'redBOX_down.bmp');
  redBOX_Off.LoadFromFile(C_IMAGES_PATH+'redBOX_up.bmp');
  redROUND_On.LoadFromFile(C_IMAGES_PATH+'redROUND_down.bmp');
  redROUND_Off.LoadFromFile(C_IMAGES_PATH+'redROUND_up.bmp');
  greenBOX_On.LoadFromFile(C_IMAGES_PATH+'greenBOX_down.bmp');
  greenBOX_Off.LoadFromFile(C_IMAGES_PATH+'greenBOX_up.bmp');
  greenROUND_On.LoadFromFile(C_IMAGES_PATH+'greenROUND_down.bmp');
  greenROUND_Off.LoadFromFile(C_IMAGES_PATH+'greenROUND_up.bmp');
  orangeBOX_On.LoadFromFile(C_IMAGES_PATH+'orangeBOX_down.bmp');
  orangeBOX_Off.LoadFromFile(C_IMAGES_PATH+'orangeBOX_up.bmp');
  orangeROUND_On.LoadFromFile(C_IMAGES_PATH+'orangeROUND_down.bmp');
  orangeROUND_Off.LoadFromFile(C_IMAGES_PATH+'orangeROUND_up.bmp');
  blueBOX_On.LoadFromFile(C_IMAGES_PATH+'blueBOX_down.bmp');
  blueBOX_Off.LoadFromFile(C_IMAGES_PATH+'blueBOX_up.bmp');

  switch_On.LoadFromFile(C_IMAGES_PATH+'switch_on.bmp');
  switch_Off.LoadFromFile(C_IMAGES_PATH+'switch_off.bmp');
  s := 'small/';
  sgreenBOX_On.LoadFromFile(C_IMAGES_PATH + s + 'greenBOX_down.bmp');
  sgreenBOX_Off.LoadFromFile(C_IMAGES_PATH + s +  'greenBOX_up.bmp');
  sgreenROUND_On.LoadFromFile(C_IMAGES_PATH + s +'greenROUND_down.bmp');
  sgreenROUND_Off.LoadFromFile(C_IMAGES_PATH + s +'greenROUND_up.bmp');
  sorangeBOX_On.LoadFromFile(C_IMAGES_PATH + s +'orangeBOX_down.bmp');
  sorangeBOX_Off.LoadFromFile(C_IMAGES_PATH + s +'orangeBOX_up.bmp');
  sorangeROUND_On.LoadFromFile(C_IMAGES_PATH + s +'orangeROUND_down.bmp');
  sorangeROUND_Off.LoadFromFile(C_IMAGES_PATH + s +'orangeROUND_up.bmp');
  sblueBOX_On.LoadFromFile(C_IMAGES_PATH + s +'blueBOX_down.bmp');
  sblueBOX_Off.LoadFromFile(C_IMAGES_PATH + s +'blueBOX_up.bmp');

end;

procedure TBtnCol.UpdateBtnImage(btn: TSpeedButtonImage; img: TBitmap);
begin
  btn.Glyph := img;
end;

procedure TBtnCol.UpdateLockBtnImage(btn: TSpeedButtonImage; warna: TBtnColor);
var img: TBitmap;
begin
  if btn.Down then
  begin
    case warna of
      RedBOX      : img := redBOX_On;
      RedROUND    : img := redROUND_On;
      GreenBOX    : img := greenBOX_On;
      GreenROUND  : img := greenROUND_On;
      OrangeBOX   : img := orangeBOX_On;
      OrangeROUND : img := orangeROUND_On;
      BlueBOX     : img := blueBOX_On;

      sGreenBOX   : img := sgreenBOX_On;
      sGreenROUND : img := sgreenROUND_On;
      sOrangeBOX  : img := sorangeBOX_On;
      sOrangeROUND: img := sorangeROUND_On;
      sBlueBOX    : img := sblueBOX_On;


    end;
  end
  else
  begin
    case warna of
      GreenBOX    : img := greenBOX_Off;
      GreenROUND  : img := greenROUND_Off;
      RedBOX      : img := redBOX_Off;
      RedROUND    : img := redROUND_Off;
      OrangeBOX   : img := orangeBOX_Off;
      OrangeROUND : img := orangeROUND_Off;
      BlueBOX     : img := blueBOX_Off;

      sGreenBOX   : img := sgreenBOX_off;
      sGreenROUND : img := sgreenROUND_off;
      sOrangeBOX  : img := sorangeBOX_off;
      sOrangeROUND: img := sorangeROUND_off;
      sBlueBOX    : img := sblueBOX_off;

    end;
  end;

  btn.Glyph := img;

end;

procedure TBtnCol.UpdateImage(Timg: TImage; img: TBitmap);
begin
  Timg.Picture := TPicture(img);
end;

procedure TBtnCol.SpringLoaded(btn: TSpeedButtonImage);
begin
  btn.Down := not btn.Down
end;

procedure TBtnCol.UpdateButton(btn: TSpeedButtonImage; const tipe: TBtnType; const Kolor: TBtnColor; const aStatus: boolean);
var kol: TBitmap;
begin
  if aStatus then begin
    case Kolor of
      GreenBOX    : kol := greenBOX_On;
      GreenROUND  : kol := greenROUND_On;
      RedBOX      : kol := redBOX_On;
      RedROUND    : kol := redROUND_On;
      OrangeBOX   : kol := orangeBOX_On;
      OrangeROUND : kol := orangeROUND_On;
      BlueBOX     : kol := blueBOX_On;

      sGreenBOX   : kol := sgreenBOX_On;
      sGreenROUND : kol := sgreenROUND_On;
      sOrangeBOX  : kol := sorangeBOX_On;
      sOrangeROUND: kol := sorangeROUND_On;
      sBlueBOX    : kol := sblueBOX_On;

    end;
  end
  else begin
    case Kolor of
      GreenBOX    : kol := greenBOX_Off;
      GreenROUND  : kol := greenROUND_Off;
      RedBOX      : kol := redBOX_Off;
      RedROUND    : kol := redROUND_Off;
      OrangeBOX   : kol := orangeBOX_Off;
      OrangeROUND : kol := orangeROUND_Off;
      BlueBOX     : kol := blueBOX_Off;

      sGreenBOX   : kol := sgreenBOX_Off;
      sGreenROUND : kol := sgreenROUND_Off;
      sOrangeBOX  : kol := sorangeBOX_Off;
      sOrangeROUND: kol := sorangeROUND_Off;
      sBlueBOX    : kol := sblueBOX_Off;


    end;
  end;
  btn.Glyph := kol;

  case tipe of
    TBSpring: btn.Down := False;
    TBLock: btn.Down := aStatus;
  end;
end;

procedure TBtnCol.UpdateImage(Timg: TImage; const Kolor: TBtnColor; const aStatus: boolean);
var kol: TBitmap;
begin
  if aStatus then begin
    case Kolor of
      GreenBOX    : kol := greenBOX_On;
      GreenROUND  : kol := greenROUND_On;
      RedBOX      : kol := redBOX_On;
      RedROUND    : kol := redROUND_On;
      OrangeBOX   : kol := orangeBOX_On;
      OrangeROUND : kol := orangeROUND_On;
      BlueBOX     : kol := blueBOX_On;

      sGreenBOX   : kol := sgreenBOX_On;
      sGreenROUND : kol := sgreenROUND_On;
      sOrangeBOX  : kol := sorangeBOX_On;
      sOrangeROUND: kol := sorangeROUND_On;
      sBlueBOX    : kol := sblueBOX_On;

    end;
  end
  else begin
    case Kolor of
      GreenBOX    : kol := greenBOX_Off;
      GreenROUND  : kol := greenROUND_Off;
      RedBOX      : kol := redBOX_Off;
      RedROUND    : kol := redROUND_Off;
      OrangeBOX   : kol := orangeBOX_Off;
      OrangeROUND : kol := orangeROUND_Off;
      BlueBOX     : kol := blueBOX_Off;

      sGreenBOX   : kol := sgreenBOX_Off;
      sGreenROUND : kol := sgreenROUND_Off;
      sOrangeBOX  : kol := sorangeBOX_Off;
      sOrangeROUND: kol := sorangeROUND_Off;
      sBlueBOX    : kol := sblueBOX_Off;

    end;
  end;
  Timg.Picture := TPicture(kol);
end;

procedure TBtnCol.UpdateBtnImage(btn: TSpeedButtonImage; const Kolor: TBtnColor; const aStatus: boolean);
var kol: TBitmap;
begin
  if aStatus then begin
    case Kolor of
      GreenBOX    : kol := greenBOX_On;
      GreenROUND  : kol := greenROUND_On;
      RedBOX      : kol := redBOX_On;
      RedROUND    : kol := redROUND_On;
      OrangeBOX   : kol := orangeBOX_On;
      OrangeROUND : kol := orangeROUND_On;
      BlueBOX     : kol := blueBOX_On;

      sGreenBOX   : kol := sgreenBOX_On;
      sGreenROUND : kol := sgreenROUND_On;
      sOrangeBOX  : kol := sorangeBOX_On;
      sOrangeROUND: kol := sorangeROUND_On;
      sBlueBOX    : kol := sblueBOX_On;
    end;
  end
  else begin
    case Kolor of
      GreenBOX    : kol := greenBOX_Off;
      GreenROUND  : kol := greenROUND_Off;
      RedBOX      : kol := redBOX_Off;
      RedROUND    : kol := redROUND_Off;
      OrangeBOX   : kol := orangeBOX_Off;
      OrangeROUND : kol := orangeROUND_Off;
      BlueBOX     : kol := blueBOX_Off;

      sGreenBOX   : kol := sgreenBOX_Off;
      sGreenROUND : kol := sgreenROUND_Off;
      sOrangeBOX  : kol := sorangeBOX_Off;
      sOrangeROUND: kol := sorangeROUND_Off;
      sBlueBOX    : kol := sblueBOX_Off;
    end;
  end;
  btn.Glyph := kol;
end;

//**********************************************//
//      TRadarku                                //
//**********************************************//

constructor TRadarku.Create;
begin
  inherited;
  Status := RAD_OFF;
  FreqType := FREQ_OFF;
  FreqBand := BAND_OFF;
  ScanType := SCAN_OFF;
  Polarization := POL_OFF;
  PRF := PRF_OFF;
end;

destructor TRadarku.Destroy;
begin
  inherited;
end;

//**********************************************//
//      TFireControl                            //
//**********************************************//
{constructor TFireControl.Create;
begin
  inherited;
  TrackedTarget := nil;
end;

destructor TFireControl.Destroy;
begin
  inherited;
end;}

//**********************************************//
//      TGun                                    //
//**********************************************//
constructor TGun.Create(const Jenis: integer);
var val: integer;
begin
  Isfunctionalized  := False;
  IsAssigning       := False;
  AssignTo          := nil;
  IsSalvoFiring := False;
  Salvo             := True;
  PHPStart          := 0;
  PHPEnd            := 0;
  PHPCounter        := -1;
  ID                := Jenis;
  case Jenis of
    1: begin
        MuzzleVelocity := C_MuzzleVel1;
        GunType := Gun120mm;
        Salvo   := False;
        PowerOn := True;
       end;

    2: begin
        MuzzleVelocity := C_MuzzleVel2;
        GunType := Gun40mm;
        PowerOn := True;
       end;

    3: begin
        MuzzleVelocity := C_MuzzleVel3;
        GunType := Gun40mm;
        PowerOn := True;
       end;
  end;

    PosBeforeCorr.X := 0.5;
    PosBeforeCorr.Y := 0.5;
    PosAfterCorr.X := 0.5;
    PosAfterCorr.Y := 0.5;

//  Randomize;
//
//  val:=0;
//  while val = 0 do
//  begin
//    val := random(10);
//    PosBeforeCorr.X := val / 10;
//  end;
//
//  val:=0;
//  while val = 0 do
//  begin
//    val := random(10);
//    PosBeforeCorr.Y := val / 10;
//  end;
//
//  val:=0;
//  while val = 0 do
//  begin
//    val := random(10);
//    PosAfterCorr.X := val / 10;
//  end;
//  val:=0;
//  while val = 0 do
//  begin
//    val := random(10);
//    PosAfterCorr.Y := val / 10;
//  end;
end;

procedure TGun.OpenFire;
begin
end;

//**********************************************//
//      TElevationMark                          //
//**********************************************//
constructor TElevationMark.Create;
begin
  inherited;

end;

procedure TElevationMark.ConvertCoord(aMap: TMap);
var sx, sy: single;
    pt: t2DPoint;
    sinx, cosx, headEast: extended;
const
    p = 0.95;
    p2 = 0.96;
    p3 = 0.97;
begin
  if not Visible then exit;

  headEast := C_DegToRad * (FHeading);
  SinCos(headEast, sinX, cosX );

  //aMap.ConvertCoord(sx, sy, Org.X, Org.Y , miMapToScreen);
  //ptC := Point(Round(sx), Round(sy));

  pt.x := Org.X + (FDistance * p) * cosX;
  pt.y := Org.Y + (FDistance * p) * sinX;
  aMap.ConvertCoord(sx, sy, pt.X, pt.Y , miMapToScreen);
  Center := Point(Round(sx), Round(sy));

  pt.x := Org.X + (FDistance * p2) * cosX;
  pt.y := Org.Y + (FDistance * p2) * sinX;
  aMap.ConvertCoord(sx, sy, pt.X, pt.Y , miMapToScreen);
  ptH := Point(Round(sx), Round(sy));

  pt.x := Org.X + (FDistance * p3) * cosX;
  pt.y := Org.Y + (FDistance * p3) * sinX;
  aMap.ConvertCoord(sx, sy, pt.X, pt.Y , miMapToScreen);
  ptH2 := Point(Round(sx), Round(sy));

  pt.x := Org.X + FDistance * cosX;
  pt.y := Org.Y + FDistance * sinX;
  aMap.ConvertCoord(sx, sy, pt.X, pt.Y , miMapToScreen);
  ptH3 := Point(Round(sx), Round(sy));
end;

procedure TElevationMark.Draw(aCnv: TCanvas);
begin
  if not Visible then exit;

  aCnv.Pen.Color := Color;
  aCnv.Pen.Width := 2;
  aCnv.Pen.Style := Style;

  aCnv.MoveTo(Center.X, Center.Y);
  aCnv.LineTo(ptH.X, ptH.Y);

  aCnv.MoveTo(ptH2.X, ptH2.Y);
  aCnv.LineTo(ptH3.X, ptH3.Y);
end;

//**********************************************//
//                TAnduDataType                 //
//**********************************************//

constructor TAnduDataType.Create;
begin
  FStringValue := '';
  FCleared := true;
end;

procedure TAnduDataType.SetValue(const aVal: string);
var temp: double;
  dblFlag: boolean;
  tempstr: string;
begin
  try
    temp := StrToFloatDef(aVal, 0);
    dblFlag := true;
  except
    dblFlag := false;
  end;

  if dblFlag then
    FDoubleValue := temp
  else begin
    FStringValue := Copy(aVal, 0, 1);
    FDoubleValue := StrToFloat(Copy(aVal, 2, Length(aVal) - 1));
  end;

  FCleared := false;
end;

procedure TAnduDataType.SetValue(const aVal: double);
begin
  FDoubleValue := aVal;
  FCleared := false;
end;

function TAnduDataType.GetDoubleValue: double;
begin
  result := FDoubleValue;
end;

function TAnduDataType.ToString: string;
begin
  if FStringValue = '' then
    result := Format('%3.2f', [FDoubleValue])
  else
    result := FStringValue + Format('%3.2f', [FDoubleValue]);

  if FCleared then result := '';
end;

function TAnduDataType.ToFlooredString: string;
begin
  if FStringValue = '' then
    result := IntToStr(FLoor(FDoubleValue))
  else
    result := FStringValue + IntToStr(FLoor(FDoubleValue));

  if FCleared then result := '';
end;

procedure TAnduDataType.ClearValue;
begin
  FCleared := true;
  FDoubleValue := 0.0;
end;

function TAnduDataType.IsEmpty: boolean;
begin
  result := FCleared;
end;

//**********************************************//
//               TAnduWCC                       //
//**********************************************//

constructor TAnduWCC.Create;
var i,j: integer;
begin
  // page  1
  for i := 1 to 10 do
    Page_1[i] := TAnduDataType.Create;

  // page 2
  for i := 1 to 9 do
  begin
    for j := 1 to 3 do
      Page_2[i][j] := TAnduDataType.Create;
  end;

  // page 3
  for i := 1 to 14 do
    Page_3[i] := TAnduDataType.Create;

  Humidity := TAnduDataType.Create;
  Humidity.SetValue(C_DefaultHumidity);
end;

end.
