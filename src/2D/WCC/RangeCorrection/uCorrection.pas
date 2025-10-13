{ ===========================
     MV : MUZZLE VELOCITY
     BP : BAROMETRIC PRESSURE
     AT : AIR TEMPERATURE
     HD : HUMIDITY
     RT : REAL TEMPERATURE
     FW : FOLLOWING WIND
     SS : SHIP SPEED
     TS : TARGET SPEED
  ============================ }

unit uCorrection;

interface
  function correctionByMV(const inMV,corrMV : Double) : Double;
  function correctionByBP(const inBP,corrBP : Double) : Double;
  function correctionByRT(const inAT,inHD,corrEt,corrAT : Double) : Double;
  function correctionByFW(const inFW,corrFW : Double) : Double;
  function correctionBySS(const inSS,corrSS : Double) : Double;
  function correctionByTS(const inTS,corrTS : Double) : Double;
  function totalDistCorr(const inMV,corrMV,inBP,corrBP,inAT,inHD,corrEt,corrAT,inFW,corrFW,inSS,corrSS,inTS,corrTS : Double) : Double;
  function Calc_ElevCorrection(const totalCorr,corrAngleDep,corrIncElev : Double) : Double;
  function Calc_QEDeg(const totalCorr,corrIncElev,elev : Double) : Double;

const
  STD_MUZZLE_VELOCITY = 1030;         // m/s
  STD_BAROMETRIC_PRESSURE = 1013.25;  // mb
  STD_AIR_TEMP = 15;                  // celcius
  STD_HUMIDITY = 0;                   // percent
  STD_REAL_TEMP = 15;                 // celcius
  STD_FOLLOWING_WIND = 0;             // m/s
  STD_SHIP_SPEED = 0;                 // m/s
  STD_TARGET_SPEED = 0;               // m/s

implementation

uses uData,Math;

function correctionByMV(const inMV,corrMV : Double) : Double;
begin
  result := (inMV - STD_MUZZLE_VELOCITY) * corrMV / 10;
end;

function correctionByBP(const inBP,corrBP : Double) : Double;
begin
  result := -1*((inBP - STD_BAROMETRIC_PRESSURE)/STD_BAROMETRIC_PRESSURE)* 100 * corrBP;
end;

function correctionByRT(const inAT,inHD,corrEt,corrAT : Double) : Double;
var
  rt : Single;
begin
  rt := inAT + (inHD/100 * corrEt);
  result := (rt - STD_REAL_TEMP) * corrAT / 10;
end;

function correctionByFW(const inFW,corrFW : Double) : Double;
begin
  result := (inFW - STD_FOLLOWING_WIND) * corrFW /10;
end;

function correctionBySS(const inSS,corrSS : Double) : Double;
begin
  result := (inSS - STD_SHIP_SPEED) * corrSS / 10;
end;

function correctionByTS(const inTS,corrTS : Double) : Double;
begin
  result := (inTS - STD_TARGET_SPEED) * corrTS / 10;
end;

function totalDistCorr(const inMV, corrMV, inBP, corrBP, inAT, inHD, corrEt,
  corrAT, inFW, corrFW, inSS, corrSS, inTS, corrTS : Double) : Double;
begin
  result := correctionByMV(inMV,corrMV) + correctionByBP(inBP,corrBP) +
    correctionByRT(inAT,inHD,corrEt,corrAT) + correctionByFW(inFW,corrFW) +
    correctionBySS(inSS,corrSS) + correctionByTS(inTS,corrTS);
end;

function Calc_ElevCorrection(const totalCorr,corrAngleDep,corrIncElev : Double) : Double;
begin
  result:= RoundTo((corrAngleDep - (totalCorr / corrIncElev * 0.1)),-1);
end;

function Calc_QEDeg(const totalCorr,corrIncElev,elev : Double) : Double;
begin
  //result := elev + RoundTo((totalCorr / corrIncElev * 0.1),-1);
  result := elev + (totalCorr / corrIncElev * 0.1);
end;

end.
