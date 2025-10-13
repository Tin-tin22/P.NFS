unit uCoordStringFormat;

{
-=-- did Simulation Framework  -----=-
  desc     : fungsi konversi format standard
  lastedit : 2012 02 24

-=-------------------------------------------------------=-
}
interface

uses
  Classes;

  procedure SplitDegreeMinute(const dd: double; var d, m: double);
  procedure SplitDegreeMinuteSecond(const dd: double; var d, m, s: double);

  function format_long_dms(const x: double): string;  // 112° 00' 00" E
  function format_latt_dms(const y: double): string;  // 007° 00' 00" S

  function format_long_dm(const x: double): string;   // 112-00.00 E
  function format_latt_dm(const y: double): string;   // 7-00.00 S

  function format_Course(const d: double): string;
  function format_Speed(const d: double): string;

  function dms_ToLong(const s: string): Double;       // 123.456789
  function dms_ToLatt(const s: string): Double;       // 070.123456

  function dm_ToLong(const s: string): Double;
  function dm_ToLatt(const s: string): Double;

  function FormatLongDmsSonar(const x: double): string; // 112 00 00 E
  function FormatLattDmsSonar(const y: double): string; // 00 00 00 N

//  procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
//
//  function RightStr(Const Str: String; Size: Word): String;
//
//  function MidStr(Const Str: String; From, Size: Word): String;
//
//  function LeftStr(Const Str: String; Size: Word): String;
//
//  procedure Slice(const aStr : string;const low, high : integer; var aStr2 : string);

  Function VAngka(const text: string; awal,akhir: Integer): Boolean;

  function IsAngka(const Text: string; awal, akhir: Integer): boolean;
  function IsFLoat(const text: string; awal, akhir: double):boolean;

  function IsZoneMGRS(const Text: string): Boolean;
  function IsSquareMGRS(const Text: string): Boolean;

  function LattFormat(const text : string): string;
  function LongFormat(const text : string): string;

  function SecToTime(Sec: Integer; IsMinute : boolean): string;
  function SecToMin(Sec: Integer): string;

  {
    desc : mengambil element dari string dimulai dari index ke low sampai ke high
           tanpa element ke high
    eg : aStr := 'ABCDEFGHIJK';
          Slice(aStr, 2, 6, aStr2);
          nilai aStr2 = 'CDEF';
  }

  implementation

uses
  SysUtils, Math, uStringFunc;


procedure SplitDegreeMinute(const dd: double; var d, m: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := MinDet;

end;

//==============================================================================
procedure SplitDegreeMinuteSecond(const dd: double; var d, m, s: double);
var
  absLongLat: double;
  MinDet: double;
begin
  absLongLat := abs(dd);
  d := Trunc(absLongLat);
  MinDet := Frac(absLongLat) * 60.0;
  m := Trunc(MinDet);
  s := Frac(MinDet) * 60.0;
end;


//==============================================================================
function format_long_dms(const x: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('000', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;


//==============================================================================
function format_latt_dms(const y: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('00', Degree) + '° ' +
    FormatFloat('00', Minute) + ''' ' +
    FormatFloat('00.0', second) + '" ';

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function format_long_dm(const x: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('000', Degree) + '-' +
    FormatFloat('00.00', Minute) + ' ' ;
  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

function format_latt_dm(const y: double): string;
var
  absLongLat: double;
  Degree, Minute: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinute(absLongLat, Degree, Minute);

  Result := FormatFloat('00', Degree) + '-' +
    FormatFloat('00.00', Minute) + ' ';

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

function format_Course(const d: double): string;
var
  i1, i2: Integer;
begin
  i1 := Floor(d) mod 360;
  i2 := Floor(frac(d) * 10);
  result := Format('%3.3d.%1.1d', [i1, i2]);
end;

function format_Speed(const d: double): string;
begin
  result := FormatFloat('00.00', abs(d));
end;

function dms_ToLong(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
begin
  Result := 0.0;
  if length(s) < 16 then exit;
    //    1234567890123456
    //    114° 57' 37.6" E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 6, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 10, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[16] = 'W' then
    result := -result;
end;

function dms_ToLatt(const s: string): Double;
var
  d, m: Integer;
  sec: double;
  str: string;
  sLength : Integer;
begin
  Result := 0.0;

  sLength := Length(s);
  if sLength < 15 then exit;
    // 123456789012345
    // 07° 52' 34.2" S

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 2);
  M := ConvertStringToInt(str);

  str := Copy(s, 9, 4);
  sec := ConvertStringToFloat(str);

  result := d + (m / 60.0) + (sec / 3600.0);

  if s[15] = 'S' then
    result := -result;

end;

function dm_ToLong(const s: string): Double;
var
  d: Integer;
  m : Double;
  str: string;
begin
  Result := 0.0;
  if length(s) < 11 then exit;
    //    12345678901
    //    114-57.37 E

  str := Copy(s, 1, 3);
  d := ConvertStringToInt(str);

  str := Copy(s, 5, 5);
  M := ConvertStringToFloat(str);

  if M > 59.99 then
    M := 59.99;

  result := d + (m / 60.0);

  if s[11] = 'W' then
    result := -result;
end;

function dm_ToLatt(const s: string): Double;
var
  d: Integer;
  m : double;
//  sec: double;
  str: string;
  sLength : Integer;
begin
  Result := 0.0;

  sLength := Length(s);
  if sLength < 10 then exit;
    // 1234567890
    // 07-52.34 S

  str := Copy(s, 1, 2);
  d := ConvertStringToInt(str);

  str := Copy(s, 4, 5);
  M := ConvertStringToFloat(str);

  if M > 59.99 then
    M := 59.99;

  result := d + (m / 60.0);

  if s[10] = 'S' then
    result := -result;
end;
//
//
//function RightStr(Const Str: String; Size: Word): String;
//begin
//  if Size > Length(Str) then Size := Length(Str) ;
//  RightStr := Copy(Str, Length(Str)-Size+1, Size)
//end;
//
//function MidStr(Const Str: String; From, Size: Word): String;
//begin
//  MidStr := Copy(Str, From, Size)
//end;
//
//function LeftStr(Const Str: String; Size: Word): String;
//begin
//  LeftStr := Copy(Str, 1, Size)
//end;
//
//procedure Slice(const aStr : string;const low, high : integer; var aStr2 : string);
//var
//  dLength : integer;
//begin
//  dLength := high - low;
//  aStr2 := Copy(aStr, low + 1, dLength);
//end;

Function VAngka(const text: string; awal,akhir: Integer): Boolean;
const
  angka =['0'..'9'];
var
  I: Integer;
  nilai : Integer;
begin
  Result := False;
  iF (Length(text) = 0) or not (text[1] in angka) then Exit;
  for I := 2 to Length(text) do
    if not (text[I] in angka) then Exit;
  nilai := strtoint(text);
  if not((nilai <= akhir) and (nilai >= awal)) then Exit;
  Result := True;
end;


function IsAngka(const Text: string; awal, akhir: Integer): boolean;
var
  aVal : Integer;
begin
  Result := False;
  if TryStrToInt(text, aVal) then begin
    if not ((aVal <= akhir) and (aVal >= awal)) then
      Exit
    else
      Result := True;
  end;

end;

function IsFLoat(const text: string; awal, akhir: double):boolean;
var
  aVal : double;
begin
  Result := False;
  if TryStrToFloat(text, aVal) then begin
    if not ((aVal <= akhir) and (aVal >= awal)) then
      Exit
    else
      Result := True;
  end;

end;

function IsZoneMGRS(const Text: string): Boolean;
const
  DigraphLetrsE = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
var
  size : Integer;
  zoneNumber : Integer;
  i : Integer;
  f : boolean;
  Latz : Char;
  sZoneNumber : string;
begin

  Result := False;

  size := Length(text);

  if Text = '' then
    Exit;

  if size > 3 then
    Exit;

  sZoneNumber := Copy(Text, 0, 2);

  if not TryStrToInt(sZoneNumber, zoneNumber) then
    Exit;
  
  if not ((zoneNumber >= 0) and (zoneNumber <= 60)) then
    Exit;

  Latz := RightStr(Text, 1)[Length(RightStr(Text, 1))];

  for I := 0 to Length(DigraphLetrsE) - 1 do
  begin
    f := DigraphLetrsE[i + 1] = UpperCase (Latz);
    if f then
      Break;
  end;

  if not f then
    Exit;

  Result := True;

end;

function IsSquareMGRS(const Text: string): Boolean;
const
  C_DIGRAPH_LETTERS : array [0..23] of Char = (
    'A','B','C','D','E','F','G','H','J','K','L','M',
    'N','P','Q','R','S','T','U','V','W','X','Y','Z'
  );
var
  SqLeft, SqRight : Char;
  i : Integer;
  fLeft, fRight : Boolean;
begin

  Result := False;

  SqLeft := LeftStr(Text, 1)[Length(LeftStr(Text, 1))];
  SqRight := RightStr(Text, 1)[Length(RightStr(Text, 1))];

  for I := 0 to Length(C_DIGRAPH_LETTERS) - 1 do
  begin
    fLeft := SqLeft = C_DIGRAPH_LETTERS[i];

    if fLeft then begin
      Break;
    end
  end;

  for I := 0 to Length(C_DIGRAPH_LETTERS) - 1 do
  begin
    fRight := SqRight = C_DIGRAPH_LETTERS[i];

    if fRight then begin
      Break;
    end
  end;

  if not fLeft then Exit;
  if not fRight then Exit;
  

  Result := True;

end;

function LattFormat(const text : string): string;
const
  C_ERR_CODE = 'ERROR';
var
  aDeg : string;
  aMid : string;
  aSec : string;
  aStr : string;
begin
  // 00-00.00 N
//  aDeg := LeftStr(aStr, 2);
//  aMin := MidStr(aStr, 4, 2);
//  aSec := MidStr(aStr, 7, 2);
  aStr := AnsiUpperCase(text);

  Result := C_ERR_CODE;
  if Length(aStr) = 1 then begin
    aDeg := LeftStr(aStr, 1);
    if VAngka(aDeg, 0, 9) then
      Result := '0'+aDeg + '-00.00 N'
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 2 then begin
    aDeg := LeftStr(aStr, 2);
    if VAngka(aDeg, 0, 90) then
      Result := aDeg + '-00.00 N'
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 4 then begin
    aDeg := LeftStr(aStr, 2);
    if aStr[3] = '-' then begin
      if not VAngka(aDeg, 0, 90) then
        Result := C_ERR_CODE
      else if not VAngka(aStr[4], 0, 5) then
        Result := C_ERR_CODE
      else
        Result := aDeg +'-'+aStr[4]+'0.00 N';
    end
    else if aStr[2] ='-' then begin
      aDeg := LeftStr(aStr, 1);
      aMid := MidStr(aStr, 3, 2);
      if not VAngka(aDeg, 0, 9) then
        Result := C_ERR_CODE
      else if not VAngka(aMid, 0, 59) then
        Result := C_ERR_CODE
      else
        Result := '0'+aDeg+'-'+aMid+'.00 N';
    end
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 5 then begin
    aDeg := LeftStr(aStr, 2);
    aMid := MidStr(aStr, 4, 2);
    if not VAngka(aDeg, 0 , 90) then
        Result := C_ERR_CODE
    else if not VAngka(aMid, 0, 59) then
      Result := C_ERR_CODE
    else begin
      Result := aStr + '.00 N';
    end;

  end
  else if Length(aStr) = 10 then begin

    if not ((aStr[3] = '-') and (aStr[6] = '.') and (aStr[9] = ' '))then
      Result := C_ERR_CODE
    else begin
      aDeg := LeftStr(aStr, 2);
      aMid := MidStr(aStr, 4, 2);
      aSec := MidStr(aStr, 7, 2);
      if not VAngka(aDeg, 0 , 90) then
        Result := C_ERR_CODE
      else if not VAngka(aMid, 0, 59) then
        Result := C_ERR_CODE
      else if not VAngka(aSec, 0, 99) then
        Result := C_ERR_CODE
      else if not ((aStr[10] = 'N') or (aStr[10] = 'S')) then
        Result := C_ERR_CODE

      else begin
        Result := aStr;

      end;
    end;
  end;
end;

function LongFormat(const text : string): string;
const
  C_ERR_CODE = 'ERROR';
var
  aDeg : string;
  aMid : string;
  aSec : string;
  aStr : string;
begin
  // 000-00.00 E
//  aDeg := LeftStr(aStr, 2);
//  aMin := MidStr(aStr, 4, 2);
//  aSec := MidStr(aStr, 7, 2);
  aStr := AnsiUpperCase(text);
  Result := C_ERR_CODE;
  if Length(aStr) = 1 then begin
    aDeg := LeftStr(aStr, 1);
    if VAngka(aDeg, 0, 9) then
      Result := '00'+aDeg + '-00.00 E'
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 2 then begin
    aDeg := LeftStr(aStr, 2);
    if VAngka(aDeg, 0, 99) then
      Result := '0'+aDeg + '-00.00 E'
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 3 then begin
    aDeg := LeftStr(aStr, 3);
    if VAngka(aDeg, 0, 180) then
      Result := aDeg + '-00.00 E'
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 5 then begin
    aDeg := LeftStr(aStr, 3);
    if aStr[4] = '-' then begin
      if not VAngka(aDeg, 0, 180) then
        Result := C_ERR_CODE
      else if not VAngka(aStr[5], 0, 5) then
        Result := C_ERR_CODE
      else
        Result := aDeg +'-'+aStr[5]+'0.00 E';
    end
    else if aStr[3] ='-' then begin
      aDeg := LeftStr(aStr, 2);
      aMid := MidStr(aStr, 4, 2);
      if not VAngka(aDeg, 0, 99) then
        Result := C_ERR_CODE
      else if not VAngka(aMid, 0, 59) then
        Result := C_ERR_CODE
      else
        Result := '0'+aDeg+'-'+aMid+'.00 E';
    end
    else
      Result := C_ERR_CODE;
  end
  else if Length(aStr) = 6 then begin
    aDeg := LeftStr(aStr, 3);
    aMid := MidStr(aStr, 5, 2);
    if not VAngka(aDeg, 0 , 180) then
        Result := C_ERR_CODE
    else if not VAngka(aMid, 0, 59) then
      Result := C_ERR_CODE
    else begin
      Result := aStr + '.00 E';
    end;

  end
  else if Length(aStr) = 11 then begin

    if not ((aStr[4] = '-') and (aStr[7] = '.') and (aStr[10] = ' '))then
      Result := C_ERR_CODE
    else begin
      aDeg := LeftStr(aStr, 3);
      aMid := MidStr(aStr, 5, 2);
      aSec := MidStr(aStr, 8, 2);
      if not VAngka(aDeg, 0 , 180) then
        Result := C_ERR_CODE
      else if not VAngka(aMid, 0, 59) then
        Result := C_ERR_CODE
      else if not VAngka(aSec, 0, 99) then
        Result := C_ERR_CODE
      else begin
        Result := aStr;

      end;
    end;
  end;
end;

function SecToTime(Sec: Integer; IsMinute : boolean): string;
var
  H, M, S: string;
  ZH, ZM, ZS: Integer;
begin
  ZH := Sec div 3600;
  ZM := Sec div 60 - ZH * 60;
  ZS := Sec - (ZH * 3600 + ZM * 60) ;

  H := FormatFloat('00',ZH);
  M := FormatFloat('00',ZM);
  S := FormatFloat('00',ZS);
  if IsMinute then
    Result := H + ':' + M
  else
    Result := H + ':' + M + ':' + S;
end;

function SecToMin(Sec: Integer): string;
var
  H, M, S: string;
  ZH, ZM, ZS: Integer;
begin
  ZH := Sec div 3600;
  ZM := Sec div 60 - ZH * 60;
  ZS := Sec - (ZH * 3600 + ZM * 60) ;

  H := FormatFloat('00',ZH);
  M := FormatFloat('00',ZM);
  S := FormatFloat('00',ZS);
  Result := M + ':' + S;
end;

function FormatLongDmsSonar(const x: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(x);
  if absLongLat > 180.0 then absLongLat := 180.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('000', Degree) + ' ' +
    FormatFloat('00', Minute)+ ' ' +
    FormatFloat('00', second) + ' ';

  if x < 0 then
    Result := Result + 'W'
  else
    Result := Result + 'E'
end;

function FormatLattDmsSonar(const y: double): string;
var
  absLongLat: double;
  Degree, Minute, Second: double;
begin
  absLongLat := abs(y);
  if absLongLat > 90.0 then absLongLat := 90.0;
  SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

  Result := FormatFloat('00', Degree) + ' ' +
    FormatFloat('00', Minute) + ' ' +
    FormatFloat('00', second) + ' ';

  if y < 0 then
    Result := Result + 'S'
  else
    Result := Result + 'N';
end;

end.
