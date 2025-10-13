unit uAnduProc;

interface

uses SysUtils, uBaseFunction, math, uBaseDataType, uTorpedoTrack;
const
    autman : array [1..2] of string =('A U T','M A N');
    opermode : array [1..3] of string =('L O C A L   W I T H   S O N A R','L O C A L','R E M O T E');
    onof : array [1..3] of string =('O N','O F F','S E L');
    monthdate  : array [1..12] of string =('J A N','F E B','M A R','A P R','M A Y','J U N','J U L','A U G','S E P','O C T','N O V','D E C');
    predm :array [1..2] of string =('I N T',' R I D');
    speedcode :array [1..3] of string =('L O W','M D M','H G H');
    homing :array [1..3] of string =('P A S','A C T','C M B');
    modesursub:array [1..2] of string =('S U R','S U B');
    tcomunit :array [1..3] of string =('0','1','2');
    squarewidth :array [1..6] of string =('6 0','1 2 0','3 0 0','6 0 0','1 2 0 0','3 0 0 0');
    indentorp :array [1..2] of string =('P O R T','S T B');
    codepage9 :array [1..2] of string =('N*','#');
    logpos :array [1..2] of string = ('B O T','E O L');

    insert_byNIK = '>';
    insert_byRolling = 'V';
{var
    t2d : t2DPoint;}

function GetStrToLength(value : String): String;
function GetStrToSpace(value : String): String;
function GetStrToVal(value : String): Double;
function GetValToStr(value : Double): String;
function GetLolimModeToStr(llm : TLolimm): String;
function GetHomingBlockToStr(hbt : THomingBlockType): String;
function GetTrackNo(const aShipTID, aTrackNum : Byte) : String;
function SetTrackNoToAND(s:String) : String;
function GetTubeStr(tube:TTube):String;
function GetTube_fromStr(TxtTube:String):TTube;
function GetStrToSpeedType(spd:String):TSpeedType;
function GetSpeedTypeToStr(spd:TSpeedType):String;
function GetHomingTypeToStr(hmg:THomingType):String;
function GetTargetTypeToStr(ttp:Byte):String;
function GetPredmType_fromStr(prdm:String): TPredm;
function GetPredmStr(pr:TPredm):String;

implementation

function GetStrToLength(value : String): String;
var
  s : string;
begin
  s := StringReplace(value,' ','',[rfReplaceAll]);
  s := StringReplace(s,'.','',[rfReplaceAll]);
  result := s;
end;

function GetStrToVal(value : String): Double;
var
  s : String;
begin
  s := StringReplace(value,' ','',[rfReplaceAll]);
  s := StringReplace(s,':','',[rfReplaceAll]);
  result := StrToFloat(s);
end;

function GetStrToSpace(value : String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(value) do
  begin
      Result := Result + value[i] + ' ' + ' ';
  end;
end;

function GetValToStr(value: Double): String;
var
  i: Integer;
  s: string;
begin
//  s := FloatToStr (value);
  s :=  formatfloat('#,#0',value);

  if s = '' then
   s:= '0';

  Result := '';
  for i := 1 to Length(s) do
  begin
      Result := Result + s[i] + ' ';
  end;
end;

function GetTrackNo(const aShipTID, aTrackNum : Byte) : String;
var
  s : String;
begin
  s := IntToOct(aShipTID,2) + IntToOct(aTrackNum,2);
  Result := s;
end;

function SetTrackNoToAND(s:String) : String;
var i : Integer;
begin
  result := '';
  for i:=1 to Length(s) do begin
    result := Result + s[i] + ' ';
  end;
end;

function GetStrToSpeedType(spd:String):TSpeedType;
begin
  if (spd = speedCode[1])then result := stLow
  else if (spd = speedCode[2]) then result := stMedium
  else if (spd = speedCode[3]) then result := stHigh;
end;

function GetSpeedTypeToStr(spd:TSpeedType):String;
begin
  if (spd = stLow)then result := speedCode[1]
  else if (spd = stMedium) then result := speedCode[2]
  else if (spd = stHigh) then result := speedCode[3];
end;

function GetHomingTypeToStr(hmg:THomingType):String;
begin
  if (hmg = htPas)then result := homing[1]
  else if (hmg = htAct) then result := homing[2]
  else if (hmg = htCmb) then result := homing[3];
end;

function GetTargetTypeToStr(ttp:Byte):String;
begin
  if (ttp = 1)then result := modesursub[1]
  else if (ttp = 2) then result := modesursub[2];
end;

function GetLolimModeToStr(llm : TLolimm): String;
begin
  if (llm = lmOn)then result := onof[1]
  else if (llm = lmOff) then result := onof[2];
end;

function GetHomingBlockToStr(hbt : THomingBlockType): String;
begin
  if (hbt = hbOn)then result := onof[1]
  else if (hbt = hbOff) then result := onof[2];
end;

function GetTubeStr(tube : TTube):String;
begin
  if (tube = ttPort) then result := 'P  O  R  T'
  else if (tube = ttStarBoard) then result := 'S  T  B'
  else Result := '';
end;

function GetTube_fromStr(TxtTube:String):TTube;
begin
  if (TxtTube = 'P  O  R  T') then result := ttPort
  else if (TxtTube = 'S  T  B') then result := ttStarBoard;
end;


function GetPredmType_fromStr(prdm:String): TPredm;
begin
  if (prdm = predm[1]) then result:= mIntercept
  else Result := mBearingRider;
end;

function GetPredmStr(pr:TPredm):String;
begin
  if (pr = mIntercept) then Result:= predm[1]
  else Result := predm[2];
end;
end.
