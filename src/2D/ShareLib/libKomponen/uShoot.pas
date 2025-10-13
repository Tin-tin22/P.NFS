unit uShoot;

interface
uses
  VrBlinkled, uSpecialLamp, uSwitch;
type
  TShootMachine = class
  private

  public
    Power: TSpecialLamp;
    WarmUp: TSpecialLamp;
    TestORAction: TSwitch;
    Gyro1: TSpecialLamp;
    Gyro2: TSpecialLamp;
    Safe1: TSwitch;
    Safe2: TSwitch;
    Safe3: TSwitch;
    Safe4: TSwitch;
    Run1: TSwitch;
    Run2: TSwitch;
    Run3: TSwitch;
    Run4: TSwitch;
    AIM1: TSwitch;
    AIM2: TSwitch;
    AIM3: TSwitch;
    AIM4: TSwitch;
    FUZE: TSwitch;
    ALTITUDE: TSwitch;
    SEARCHAREA: TSwitch;
    Fire1: TSpecialLamp;
    Fire2: TSpecialLamp;
    Fire3: TSpecialLamp;
    Fire4: TSpecialLamp;
    TargetBearing: TSwitch;
    Degrees: TSwitch;
    TargetRange: TSwitch;
    RangeToGo: TSwitch;
    ManualWidth: TSwitch;
    Selection: TSwitch;
    constructor create;
  end;
var
  Shoot: TShootMachine;

implementation
uses
  Graphics;

constructor TShootMachine.create;
begin
  Power := TSpecialLamp.create;
  WarmUp := TSpecialLamp.create;
  TestORAction := TSwitch.create;
  Gyro1 := TSpecialLamp.create;
  Gyro2 := TSpecialLamp.create;
  Safe1 := TSwitch.create;
  Safe2 := TSwitch.create;
  Safe3 := TSwitch.create;
  Safe4 := TSwitch.create;
  Run1 := TSwitch.create;
  Run2 := TSwitch.create;
  Run3 := TSwitch.create;
  Run4 := TSwitch.create;
  AIM1 := TSwitch.create;
  AIM2 := TSwitch.create;
  AIM3 := TSwitch.create;
  AIM4 := TSwitch.create;
  FUZE := TSwitch.create;
  ALTITUDE := TSwitch.create;
  SEARCHAREA := TSwitch.create;
  Fire1 := TSpecialLamp.create;
  Fire2 := TSpecialLamp.create;
  Fire3 := TSpecialLamp.create;
  Fire4 := TSpecialLamp.create;
  TargetBearing := TSwitch.create;
  Degrees := TSwitch.create;
  TargetRange := TSwitch.create;
  RangeToGo := TSwitch.create;
  ManualWidth := TSwitch.create;
  Selection := TSwitch.create;
end;

end.
