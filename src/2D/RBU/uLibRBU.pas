unit uLibRBU;

interface
uses
  SysUtils,
  Forms,
  Classes,
  Graphics,
  StdCtrls,
  ExtCtrls,

  Math,

  uTCPDatatype,
  uBaseConstan,
  uBaseFunction,
  VrWheel;
  //RotationIndicator;

type
   TFireMode      = (off, Single12, Single6, Single11, Slavo4, Salvo8, Salvo12);
   TBalistikMode  = (Balistik1, Balistik2, BlAuto);
   TModeLonch     = (mlAuto, mlManualLoad, mlDirection);

  TRecMissile = class
    public
      //numb     : Byte;
      Missile  : Word;
      Launcher : Word;
      Available: boolean;
      Condition: Boolean;
      isLaunch : Boolean;
  end;

  TLoncher = class
    private
    protected
      Isused,
      IsReady           : Boolean;
      vTraining,
      vElev           : Single;
      vCorrTraining,
      vCorrElev       : Single;

      IsTrainingOn,
      IsElevOn   : boolean;


      procedure SetEnable(const aval: boolean);
      function  GetEnable : boolean;

      procedure SetReady(const aval: boolean);
      function  GetReady : boolean;


      function  GetTrainingVal : single;
      procedure setValTraining(const aVal: single);
      procedure setTrainingOn(const aval: boolean);
      function  GetTrainingOn : boolean;

      procedure SetTrainingCorr(const aval: Single);
      function  GetTrainingCorr : Single;
      procedure SetElevCorr(const aval: Single);
      function  GetElevCorr : Single;


      function  GetElevVal : single;
      procedure setValElev(const aVal: single);
      procedure setElevOn(const aval: boolean);
      function  GetElevOn : boolean;

    public
      ID : Byte;
      IsLoading : Boolean;
      OrderFire : Tlist;
      isReadyFire : Boolean;
      constructor Create;
      destructor Destroy; override;

    published
      property Enabled : boolean read GetEnable write SetEnable;
      property Ready : boolean read GetReady write SetReady;
      property TrainingValue : single read GetTrainingVal write setValTraining;
      property TrainingOn : boolean read GetTrainingOn write setTrainingOn;
      property ElevationAngle : single read GetElevVal write setValElev;
      property ElevOn : boolean read GetElevOn write setElevOn;
      property CorrTraining : single read GetTrainingCorr write SetTrainingCorr;
      property CorrElev : single read GetElevCorr write SetElevCorr;
  end;

  TShipRBU = class
    public
      ShipId    : string[15];
      position  : tDouble3DPoint;
      heading,
      speed     : Single;
  end;

const
 image_path = '..\data\images\rbu\';
 path_image_burja = image_path + 'burja\';
 path_image_108 = image_path + '108\';
 path_image_panelFire = image_path +'panelfire\';

 BlindZoneR_Start = 150;
 BlindZoneR_End   = 240;
 BlindZoneL_Start = 120;
 BlindZoneL_End   = 210;

 Rng_Balistik1_Min = 500;
 Rng_Balistik1_Max = 1500;
 Rng_Balistik2_Min = 1500.1;
 Rng_Balistik2_Max = 5500;

 WarmUptime = 180;
 SequenceMissile : array [1..12] of Integer = (1,7,6,12,2,8,5,11,3,9,4,10);
 Am1            : array [1..6] of Integer = (8,-7,3,-2,1,0);
 Am2            : array [1..6] of Integer = (3,-2,1,-1,0,0);
 TimeAutoLoadMissile   = 133; // Load < 16s
 TimeManulaLoadMissile = 200; // Load < 2s

 C_Radius_Tembakan = 100.0 * C_Meter_To_NauticalMiles; // Radius Tembakan 100m ==> in Nautical Miles

 minRange1 = 500;
 maxRange1 = 1500;
 minRange2 = 1500;
 maxRange2 = 5500;

 minElev  = 8.5;
 maxElev  = 45;

//function GetValRotateInd (RI: TRotationIndicator; vrwh: TVrWheel; Lbl : TLabel; C_Rts,RC : integer): Single;
procedure SetChangeImageIndikator(var Aimage : TImage; imgOn,ImgOff : string; const stat : boolean);
procedure SetImageIndikatorwithButton(var Aimage : TImage; const stat : boolean);
function StatusAliranBurja : Boolean;
function LauncherScope(const Val : Single): Single;
function RedGreenToDeg(const Val : Single) : Single;

procedure GetDistancePossition(const Input_X, Input_Y, Input_Range, InputBearing: double; var OutputX, OutputY : double);
procedure Fire_With_SalvoMode(const StartPoinX, StartPoinY, r, b, RadRange, RadBearing : double; var OutputRange, OutputBearing : double);

function Validate180Degree(const degreeOrg: double): double;
function ConvRangeToElevCorr(Blstk:Word; Range : double): double; // Meter To Degree
function ConvRangeToElev(Blstk:Word; Range : double): double; // Meter To Degree
function ConvElevToRange(Blstk:Word; Elev : double): double;  // Degree To Meter
function GetBalistik(BalistikMode : TBalistikMode; Range :double; var Useblstk: word): boolean;
//procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
//function ConvCompass_To_Cartesian(const degree: double): double;

var
  OwnShip, TargetShip : TShipRBU;

  // Burja
  State_JarTPO,
  State_BarTPO,
  State_HalSAS,
  State_HalKPL,
  State_BarSAS,
  State_Training,
  State_SDTCegat,
  State_KecSAS,
  State_KecKPL,
  State_LonchBRT,
  State_Kedalaman,
  State_Elevasi,
  State_Jarak        : Boolean;

  //Atas
  Lonch1, Lonch2     : TLoncher;   //direction (c)

  // Bawah
  BalistikMode       : TBalistikMode;
  Is_WarMode         : Boolean;
  Use_Balistik       : word;

  // 108
  ModeLonchL,
  ModeLonchR          : TModeLonch;    // Mode Load/Direct

  stLEFT_UNFORMER1,              // setting alat
  stLEFT_UNFORMER2,
  stRIGHT_UNFORMER1,
  stRIGHT_UNFORMER2  : boolean;

  //Panel Fire
  ListMissileR,
  ListMissileL       : array [1..12] of TRecMissile;

  OrderFireL,
  OrderFireR         : TList;

  TargetID           : Word;

implementation

uses
  Dialogs;

procedure SetChangeImageIndikator(var Aimage : TImage; imgOn,ImgOff : string; const stat : boolean);
begin
  if stat then
    Aimage.Picture.LoadFromFile(imgOn)
  else
    Aimage.Picture.LoadFromFile(imgOff);
end;

function Validate180Degree(const degreeOrg: double): double;
begin
  try
    result := degreeOrg - (Floor(degreeOrg / 360.0)* 360.0);
    if result > 180 then
    result := result -360;
  except
    ShowMessage('Error Validate Degree : ' + FloatToStr(degreeOrg));
  end
end;

procedure SetImageIndikatorwithButton(var Aimage : TImage; const stat : boolean);
begin
 if stat then
    Aimage.Picture.LoadFromFile(path_image_burja + 'Burja_indikator_on.bmp')
  else
    Aimage.Picture.LoadFromFile(path_image_burja + 'Burja_indikator_off.bmp');
end;

function StatusAliranBurja : Boolean;
begin
   if State_JarTPO and
      State_BarTPO and
      State_HalSAS and
      State_HalKPL and
      State_BarSAS and
      State_Training and
      State_SDTCegat and
      State_KecSAS and
      State_KecKPL and
      State_LonchBRT and
      State_Kedalaman and
      State_Elevasi and
      State_Jarak then
    Result := True
    else
    Result := False;
end;

function ConvRangeToElevCorr(Blstk:Word; Range : double): double; // Meter To Degree
var minRange,
    maxRange : Double;
begin
  case Blstk of
    1 :begin
       maxRange:= maxRange1;
       minRange:= minRange1;
    end;
    2 :begin
       maxRange:= maxRange2;
       minRange:= minRange2;
    end;
  end;


  Result := (((Range-minRange)/(maxRange-minRange))*(maxElev-minElev));
end;

function ConvRangeToElev (Blstk:Word; Range : double): double;  // meter To Degree
var minRange,
    maxRange : Double;
begin
  case Blstk of
    1 :begin
       maxRange:= maxRange1;
       minRange:= minRange1;
    end;
    2:begin
       maxRange:= maxRange2;
       minRange:= minRange2;
    end;
  end;

  if Range <= minRange then
    Result := minElev
  else if Range >= maxRange then
    Result := maxElev
  else
  Result := (((Range-minRange)/(maxRange-minRange))*(maxElev-minElev))+ minElev;
end;

function ConvElevToRange(Blstk:Word; Elev : double): double;  // Degree To Meter
var minRange,
    maxRange : Double;
begin
  case Blstk of
    1 :begin
       maxRange:= maxRange1;
       minRange:= minRange1;
    end;
    2:begin
       maxRange:= maxRange2;
       minRange:= minRange2;
    end;
  end;

  if Elev <= minElev then
    Result := minElev
  else if Elev >= maxElev then
    Result := maxElev
  else

  Result := (((Elev-minElev)/(maxElev-minElev))*(maxRange-minRange))+ minRange;
end;


function GetBalistik(BalistikMode : TBalistikMode; Range :double; var Useblstk: word): boolean;
begin
  Result := False;
  Useblstk := 1;
  case BalistikMode of
    Balistik1 : begin
      if (Range >= Rng_Balistik1_Min) and (Range <= Rng_Balistik1_Max) then begin
        Useblstk := 1;
        Result := true;
      end;
       // Out of area Balistik 1
    end;
    Balistik2 : begin
     if (Range >= Rng_Balistik2_Min) and (Range <= Rng_Balistik2_Max) then begin
       Useblstk := 2;
       Result := true;
     end;
     // Out of area Balistik 2
    end;
    BlAuto : begin
       if (Range < Rng_Balistik1_Min) or (Range > Rng_Balistik2_Max) then begin        // Out of range RBU
          // Use_Balistik := 0
          Result := False;
       end
       else if (Range >= Rng_Balistik1_Min) and (Range <= Rng_Balistik1_Max) then begin
          Useblstk := 1;
          Result := true;
       end
       else if (Range >= Rng_Balistik2_Min) and (Range <= Rng_Balistik2_Max) then begin
          Useblstk := 2;
          Result := true;
       end;
    end;
  end;
end;
{ TLoncher }

constructor TLoncher.Create;
begin
   vTraining    := 0.00;
   vElev        := 0.00;
   IsElevOn     := false;
   IsTrainingOn := false;
   Isused       := False;
   IsLoading    := False;
   OrderFire:= TList.Create;
   isReadyFire := false;
end;

destructor TLoncher.Destroy;
begin
  inherited;
  FreeAndNil(OrderFire);
end;

function TLoncher.GetTrainingCorr: Single;
begin
  Result := vCorrTraining;
end;

function TLoncher.GetElevCorr: Single;
begin
  Result := vCorrElev;
end;

function TLoncher.GetElevOn: boolean;
begin
  Result := IsElevOn;
end;

function TLoncher.GetElevVal: single;
begin
  if IsElevOn then
    Result := vElev;
end;

function TLoncher.GetEnable: boolean;
begin
  result := Isused;
end;

function TLoncher.GetReady: boolean;
begin
Result := IsReady;
end;

function TLoncher.GetTrainingOn: boolean;
begin
  Result:=  IsTrainingOn
end;

function TLoncher.GetTrainingVal: single;
begin
  if IsTrainingOn then
    Result := vTraining;
end;

procedure TLoncher.SetTrainingCorr(const aval: Single);
begin
  vCorrTraining := aval;
end;

procedure TLoncher.SetElevCorr(const aval: Single);
begin
   vCorrElev := aval;
end;

procedure TLoncher.setElevOn(const aval: boolean);
begin
  IsElevOn := aVal;
end;

procedure TLoncher.SetEnable(const aval: boolean);
begin
   Isused :=aval;
end;

procedure TLoncher.SetReady(const aval: boolean);
begin
   IsReady  :=aval;
end;

procedure TLoncher.setTrainingOn(const aVal: boolean);
begin
  IsTrainingOn := aVal;
end;

procedure TLoncher.setValElev(const aVal: single);
begin
  vElev := aVal;
end;

procedure TLoncher.setValTraining(const aVal: single);
begin
     vTraining := aVal;
end;

function LauncherScope(const Val : Single): Single;
begin
 result := val;
   if Val > 170 then
     result := 170;
  if Val < -170 then
     result := -170;
end;

function RedGreenToDeg(const Val : Single) : Single;
begin
  if Val < 0 then
    result := 360 - Val
  else
    Result := VAl;
end;

procedure GetDistancePossition(const Input_X, Input_Y, Input_Range, InputBearing: double; var OutputX, OutputY : double);
var ax, ay, rng : Double;
begin
 rng := Input_Range * C_NauticalMile_To_Degree;
 RangeBearingToCoord(rng, InputBearing, ax, ay);

 OutputX := Input_X + ax;
 OutputY := Input_Y + ay;

end;

procedure Fire_With_SalvoMode(const StartPoinX, StartPoinY, r, b, RadRange, RadBearing : double; var OutputRange, OutputBearing : double);
var PosX, PosY : Double;
RangeOwnShip_To_TargetPoint,
BearingOwnShip_To_TargetPoint : Double;
begin
// Fire_With_SalvoMode
//(OwnShip.position.X, OwnShip.position.Y, RangeToFire, Bearing, C_Radius_Tembakan,
//DiffDegToFireR, RangeToFire, Bearing);


  GetDistancePossition(StartPoinX, StartPoinY, r, b, PosX, PosY);     // own ship --> titik posisi Bidik
  GetDistancePossition(PosX, PosY, RadRange, RadBearing, PosX, PosY); // Titik Bidik --> Titik tembak

  RangeOwnShip_To_TargetPoint   := CalcRange(StartPoinX, StartPoinY, PosX, PosY);     // Jarak own ship ke Titik tembak
  BearingOwnShip_To_TargetPoint := CalcBearing(StartPoinX, StartPoinY, PosX, PosY);   // Bearing own ship ke Titik tembak

  OutputRange   := RangeOwnShip_To_TargetPoint - r;   // Different Range
  OutputBearing := Validate180Degree(BearingOwnShip_To_TargetPoint - b); // Different Bearing

end;
{
//Referensi perhitungan jarak salvo mode
procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
    range : double;
begin
  range := r * C_NauticalMile_To_Degree;

  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := range * cosx;
  my := range * sinx;
end;

function ConvCompass_To_Cartesian(const degree: double): double;
begin
  // input : derajat (0..360) dari utara,   CW, kompas
  // output: derajat (0..360) dari sumbu X, CCW, cartesian

  result := 90.0 - degree;
  if result < 0.0 then result := result + 360.0;
end;
 }



end.
