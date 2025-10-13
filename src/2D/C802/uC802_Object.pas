unit uC802_Object;

interface

type
  TC802_Object = class
    private
      FMisNo : Integer;
      FTgtNo : Integer; // Target no
      FDis : Double;  // Distance
      FAzm : Double;  // Azimut : posisi terhadap N
      FSpd : Double;  // Speed
      FCou : Double; // Course
      FRzd : Double;
      FTzk : Double;
      FPsiq : Double;
      FSitaZ : Double;
      FGamaZ : Double;
      FTime : TDateTime;

      FLong : Double;
      FLat : Double;
      FOwnSpd : Double;
      FOwnHdg : Double;
      FPitch : Double;
      FRoll : Double;
      FTzkFB : Double;
      FWndSpd : Double;
      FWndDir : Double;
      FTemp : Double;

      FMode : Byte;

    public
      {parameter state - boolean}
      FBoosterState : Byte;
      FPWRtoM,

      FInitState,
      FPowerSupply,
      FTurnOnEquip,
      FCheckStage1,
      FAngleSet,
      FCoCheck,
      FTzkSetting,
      FCommandNo3,
      FMisNormal,
      FAccurateCal,
      FInsideSectr,
      FLimiterOut,
      FRigidityStt,
      FFullOpen,
      FBoosterArm,
      FLaunchReady,
      FLaunchButton,
      FBatteryAct,
      FPowerSwitch,
      FGyroUncaged,
      FIgnition,
      FTakeOff : Boolean;

      constructor Create;
      destructor Destroy;

      {end - state}

    published
      property MisNo : Integer read FMisNo write FMisNo;
      property TgtNo : Integer read FTgtNo write FTgtNo;
      property Dis : Double read FDis write FDis;
      property Azm : Double read FAzm write FAzm;
      property Spd : Double read FSpd write FSpd;
      property Cou : Double read FCou write FCou;
      property Rzd : Double read FRzd write FRzd;
      property Tzk : Double read FTzk write FTzk;
      property Psiq : Double read FPsiq write FPsiq;
      property SitaZ : Double read FSitaZ write FSitaZ;
      property GamaZ : Double read FGamaZ write FGamaZ;
      property Time : TDateTime read FTime write FTime;

      property Long : Double read FLong write FLong;
      property Lat : Double read FLat write FLat;
      property OwnSpd : Double read FOwnSpd write FOwnSpd;
      property OwnHdg : Double read FOwnHdg write FOwnHdg;
      property Pitch : Double read FPitch write FPitch;
      property Roll : Double read FRoll write FRoll;
      property TzkFB : Double read FTzkFB write FTzkFB;
      property WndSpd : Double read FWndSpd write FWndSpd;
      property WndDir : Double read FWndDir write FWndDir;
      property Temp : Double read FTemp write FTemp;

      property Mode : byte read FMode write FMode;

  end;

implementation

constructor TC802_Object.Create;
begin
  FDis := 0;
  FAzm := 0;
  FSpd := 0;
  FCou := 0;
  FMode := 0;

  {default long lat}
  Long := 112.0;
  Lat := -9.2;
end;

destructor TC802_Object.Destroy;
begin

end;

end.
