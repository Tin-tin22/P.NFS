unit uTrackFunction;

interface

uses
  uBaseConstan, uLibTDCTracks{, uBaseDataType};



  function IsValidTrackNumber(const str: string): boolean;
  function SplitTrackNumber(const tnStr: string; var sId, tNum: byte): boolean;
  function MergeTrackNumber(const sId, tNum: byte): string;

  function trackDomainToChar(td : TTrackDomain): char;
  function CharToDomain(c: char): TTrackDomain;

  function IdentTambahanToChar(id : char) : char;

  function GetTrackDomainFromIDENT(const ID: char): TTrackDomain;

  function USubclassToChar(scl:String): Char;


  function  formatSCR_track_AS (mTrack: TManualTrack): string;
  function  formatSCR_track_U (mTrack: TManualTrack): string;
  function  formatSCR_datum (dt : TDatumTrack; const lTime :TDateTime): string;
  function  formatSCR_ESMBear (trck: TTDCTrack; const lTime :TDateTime): string;
  function  formatSCR_ESMFix (trck : TTDCTrack; const lTime :TDateTime): string;
  function  formatSCR_RP (trck : TTDCTrack): string;

//  function formatSLL(const aAir, bSurf, cSubSurf, dDatum, eESMFix, fRP, gAreaCurs: byte): string;
  function formatSLL(const aAir, bSurf, cSubSurf, dDatum, eESMFix, fRP, gAreaCurs: byte;
    const hTime: TDateTime ): string;

  function formatGeoCoord(const x, y: double; lt: tDateTime ): string;
  function formatGridCoord(const bObm, rOBM, xGrid, yGrid: double; const c: char): string;

  function formatQueryTW(const twCourse, twSpeed, rwCourse, rwSpeed,
             cCourse, cSpeed: double): string;

  function formatParS1(): string;
  function formatParS2(): string;

  function formatParC1(): string;
  function formatParC2(): string;

  function formatParT1(const tns: string;
    const rangeSas, bearingSas, speedSas: double ): string;

  function formatParT2(const rPHP, bPHP,tPHP: double): string;

  function formatParV1(): string;
  function formatParV2(): string;


  function IsValidPlatformID(c: char): boolean;

  function IsValidDatumSource(var str: string): boolean;
  function IsValidTwoLetterIndication(str : string): boolean;

  function IsValidIdentAmplification(C: char): boolean;
  function IsValidIdentSource(c: char): boolean;
  function IsValidSubClassif( str: string): boolean;

  function ChangeTrackIdentByIDA(const ident, ida: char ): char;


  /// -- owa function --------------------------------------------

  //function fmtowa_SCR_contoh(const sid, tn: byte; const course, speed: double) :string;
  function formatOWA_SCR(mTrack: TManualTrack):String;
  function formatOWA_ACR_IFF(mTrack: TManualTrack):String;
  function formatOWA_ACR_ESM(mTrack: TManualTrack):String;
  function formatOWA_ACR_PVC(mTrack: TManualTrack):String;
  function formatOWA_SCR_bearing(mTrack: TESMBearingTrack):String;
  function formatOWA_PVC_bearing(mTrack: TESMBearingTrack):String;
  function formatDR_OBM(pX,pY :Double; cIdent:Char; dX,dY :Double):String;
  function formatDR_OCM(head,dist :Double):String;
  


implementation

uses
  Classes, uBaseFunction, SysUtils, uStringFunction, Math;


function IsValidTrackNumber(const str: string): boolean;
var i, code: integer;
    b : byte;
begin // valid track number : 4 digit octal;
  result := false;
  if length(trim(str)) <> 4 then exit;
  result := true;
  for i := 1 to length(str) do begin
    vaL(str[i], b, code);
    if code = 0 then
      result := result AND (b < 8)
    else begin
      result := false;
      exit;
    end;
  end;
end;

function SplitTrackNumber(const tnStr: string; var sId, tNum: byte): boolean;
var s: string;
begin // valid track number : 4 digit octal; pastikan inputnya valid
  result :=  Length(tnStr) = 4;
  if result then begin
    s := Copy(tnStr, 1, 2);
    sId := OctToInt(s);
    s := Copy(tnStr, 3, 2);
    tNum := OctToInt(s);
  end;
end;

function MergeTrackNumber(const sId, tNum: byte): string;
begin
  result := IntToOct(sID, 2) + IntToOct(tNum, 2);
end;

function trackDomainToChar(td : TTrackDomain): char;
// track domain info on ANDU
begin
  result := ' ';
  case td of
    tdUdara    : result := 'A';
    tdAtasAir  : result := 'S';
    tdBawahAir : result := 'U';
    tdEW       : result := 'F';
    tdDontCare : result := ' ';
    // B : baringan ESM
    // F : ESM Fix
    // R : Reference Position

  end;
end;

function CharToDomain(c: char): TTrackDomain;
// track domain info on ANDU
begin
  case c of
    'A' : result := tdUdara   ;
    'S' : result := tdAtasAir ;
    'U' : result := tdBawahAir;
    'F' : Result := tdEW;
  else
    result := tdDontCare;
  end;
end;


function TrackIdentTo_IDA(id : char) : char;
// IDENT Constan to ANDU ident format
begin
  case id of
    ID_Udara_Unknown,
    ID_AtasAir_Unknown,
    ID_BawahAir_Unknown  : result := 'U';

    ID_AtasAir_Friendly,
    ID_Udara_Friendly,
    ID_BawahAir_Friendly,
    ID_AtasAir_Helicopter,
    ID_BawahAir_NonSub    : result := 'F';

    ID_AtasAir_Hostile,
    ID_Udara_Hostile,
    ID_BawahAir_Hostile,
    ID_Rudal : result := 'H';
  else
    result := ' '
  end;
end;

function IdentTambahanToChar(id : char) : char;
// IDENT constan non track to ANDU format
begin
  case id of
   ID_AtasAir_Helicopter : result := 'H';
   ID_Rudal              : result := 'M';
   // Torpedo            : result := 'T';
   // sonar active       : result := 'S';

  else
    result := ' '
  end;
end;

function GetTrackDomainFromIDENT(const ID: char): TTrackDomain;
begin
  case ID of
    ID_Udara_Unknown,
    ID_Udara_Friendly,
    ID_Udara_Hostile,
    ID_Rudal :              result := tdUdara;

    ID_AtasAir_Unknown,
    ID_AtasAir_Friendly,
    ID_AtasAir_Hostile,
    ID_AtasAir_Helicopter : result := tdAtasAir;

    ID_BawahAir_Unknown,
    ID_BawahAir_Friendly,
    ID_BawahAir_Hostile,
    ID_BawahAir_NonSub    : result := tdBawahAir;

  else
    result := tdDontCare;
  end;
end;

function ChangeTrackIdentByIDA(const ident, ida: char ): char;
var td : TTrackDomain;
begin
   result := ident;
   td := GetTrackDomainFromIDENT(ident);
   if td = tdDontCare then exit;

   case td of
     tdUdara : begin
       case ida of
         'U' : result := ID_Udara_Unknown;
         'H' : result := ID_Udara_Hostile;
         'F' : result := ID_Udara_Friendly;
       end;

     end;
     tdAtasAir : begin
       case ida of
         'U' : result := ID_AtasAir_Unknown;
         'H' : result := ID_AtasAir_Hostile;
         'F' : result := ID_Udara_Friendly;
       end;

     end;
     tdBawahAir: begin
       case ida of
         'U' : result := ID_BawahAir_Unknown;
         'H' : result := ID_BawahAir_Hostile;
         'F' : result := ID_BawahAir_Friendly;
       end;

     end;
   end;
end;

function IsValidPlatformID(C: char): boolean;
begin         //
  result := c in ['A', 'S', 'U', 'X', 'M', 'L'];
end;


function IsValidTwoLetterIndication(str : string): boolean;
begin
   result := Length(str) <= 2;
end;

function IsValidIdentAmplification(C: char): boolean;
begin
  result := c in ['U', 'H', 'F'];
end;

function IsValidIdentSource(c: char): boolean;
begin
  result := c in ['V', 'A','E','I','U','R'];
  {
  V : Visual
  A : Assumed
  E : ESM
  I : IFF
  U : Unknown
  R : Radar }

end;

function USubclassToChar(scl:String): Char;
begin
  result := ' ';
  if scl = 'POS' then result := 'P'
  else if scl ='PRB' then result := 'B'
  else if scl ='CRT' then result := 'C'
  else if scl ='NOS' then result := 'N'
  else if scl ='UNC' then result := ' ';
end;

//------------------------------------------------------------------------------
// ANDU FORMAT
//   '         1         2         3  '
//   '12345678901234567890123456789012'

//------------------------------------------------------------------------------
  function  formatSCR_track_AS (mTrack: TManualTrack): string;
  var s: string;              // air & surface.
      cIdent : char;
  begin  //   '12345678901234567890123456789012'
//  result := '$$12222 345 666 7777 888 9 xxxxx';
    result := '$$                              ';
    cIdent := mTrack.GetIdent;

    case mTrack.Domain of
      tdAtasAir, tdUdara : begin
        Result[3] := trackDomainToChar(mTrack.Domain);
        s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
        OverwriteString(result, s, 4);
        result[ 9] := TrackIdentTo_IDA(cIdent);
        result[10] := IdentTambahanToChar(cIdent);
        Result[11] := mTrack.IdentSource; // GetIdentSource;

        s := FormatFloat('000', Round(mTrack.Course));
        OverwriteString(result, s, 13);

        s := FormatFloat('0000', Round(mTrack.Speed));
        OverwriteString(result, s, 17);
        s := FormatFloat('000', Round(mTrack.Height /100));
        OverwriteString(result, s, 22);

        s := IntToStr(mTrack.FCChanel);
        OverwriteString(result, s, 26);

        OverwriteString(result, mTrack.PrivateCode , 28);
      end;
    end;
  end;
//------------------------------------------------------------------------------
  function  formatSCR_track_U (mTrack: TManualTrack): string;
  var s: string;              // underwater  track
//      cIdent : char;
  begin   //  '12345678901234567890123456789012'
//  result := '$$U1111 222 333 44.4 555 6 xxxxx';
    result := '$$U                             ';
//    cIdent := mTrack.GetIdent;

    if mTrack.Domain = tdBawahAir then begin
        Result[3] := 'U';
  {%1}  s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
        OverwriteString(result, s, 4);

  {%2}  s := mTrack.SubClassification;
       OverwriteString(result, s, 9);

  {%3}  s := FormatFloat('000', Round(mTrack.Course));
        OverwriteString(result, s, 13);

  {%4}  s := FormatFloat('00.0', mTrack.Speed);
        OverwriteString(result, s, 17);

  {%5}  s := FormatFloat('000', abs(Round(mTrack.Height)));
        OverwriteString(result, s, 22);

  {%6}  s := IntToStr(mTrack.FCChanel);
        OverwriteString(result, s, 26);

  {%7}  OverwriteString(result, mTrack.PrivateCode , 28);
    end;
  end;
//------------------------------------------------------------------------------
  function  formatSCR_datum (dt : TDatumTrack; const lTime :TDateTime): string;
  var s: string;
  begin  //   '12345678901234567890123456789012'
  //result := '$$D1111 222 3 4444 5555 66 77777';
    result := '$$D                             ';
{%1}  s := MergeTrackNumber(dt.ShipTrackId, dt.TrackNumber);
      OverwriteString(result, s, 4);
{%2}  s := dt.DatumSource;
     OverwriteString(result, s, 9);
{%3}  s := IntToStr(dt.Error);
     OverwriteString(result, s, 13);
{%4}  s := FormatDateTime('hhnn', dt.LastTime);
     OverwriteString(result, s, 15);
{%5}  s := FormatDateTime('nnss', lTime - dt.LastTime);
     OverwriteString(result, s, 20);
{%6}  s := FormatFloat('00', dt.Speed);
     OverwriteString(result, s, 25);
{%7}  s := dt.PrivateCode;
     OverwriteString(result, s, 28);
  end;
//------------------------------------------------------------------------------
  function  formatSCR_ESMBear (trck: TTDCTrack; const lTime :TDateTime): string;
  var s: string;
      esb : TESMBearingTrack;
  begin   //  '12345678901234567890123456789012'
  //result := '$$B1111 222 3333 4 W555.5I66666X';
    result := '$$B                W   . I     X';
    esb := trck as TESMBearingTrack;

{%1} s := MergeTrackNumber(esb.ShipTrackId, esb.TrackNumber);
     OverwriteString(result, s, 4);

{%2} s := FormatFloat('000', esb.Bearing);
     OverwriteString(result, s, 9);

{%3} s := FormatDateTime('nnss', lTime - esb.LastTime);
     OverwriteString(result, s, 13);

{%4} s := IntToStr(esb.SusieNumber);
     OverwriteString(result, s, 18);

{%5} s := FormatFloat('000.0', esb.PulseWidth);
     OverwriteString(result, s, 21);

{%6} s := FormatFloat('00000', esb.PulseRepInt);
     OverwriteString(result, s, 27);

{%X} result[32] := esb.Band;

  end;
//------------------------------------------------------------------------------
  function  formatSCR_ESMFix (trck : TTDCTrack; const lTime :TDateTime): string;
  var s: string;
      esf : TESMFixTrack;
  begin    //  '12345678901234567890123456789012'
   //result := '$$F1111 23 4444 5555       xxxxx';
     result := '$$F                             ';
     esf := trck as TESMFixTrack;

{%1} s := MergeTrackNumber(esf.ShipTrackId, esf.TrackNumber);
     OverwriteString(result, s, 4);

      result[ 9]  := esf.IdentChar; // ident dari mana?? //U, H, F.
      result[10]  := esf.PlatformID;

{%4} s := FormatDateTime('hhnn', esf.LastTime);
     OverwriteString(result, s, 12);
{%5} s := FormatDateTime('nnss', lTime - esf.LastTime);
     OverwriteString(result, s, 17);

{%7} s := esf.PrivateCode;
     OverwriteString(result, s, 28);

  end;
//------------------------------------------------------------------------------
  function  formatSCR_RP (trck : TTDCTrack): string;
  var s: string;
     rp : TRefPosTrack;
  begin
     rp := trck as TRefPosTrack;
  //          '12345678901234567890123456789012'
  //result := '$$R1111 22 333 4444        xxxxx';
    result := '$$R                             ';
{%1}  s := MergeTrackNumber(rp.ShipTrackId, rp.TrackNumber);
      OverwriteString(result, s, 4);

{%2}  s := rp.TLI;
      OverwriteString(result, s, 9);

{%3}  s := FormatFloat('000', Round(rp.Course));
      OverwriteString(result, s, 12);

{%4}  s := FormatFloat('00.0', rp.Speed);
        OverwriteString(result, s, 16);
{%5}  s := rp.PrivateCode;
        OverwriteString(result, s, 28);

  end;
//------------------------------------------------------------------------------
  function formatLocalTime(dt: TDateTime): string;
  begin
    result := FormatDateTime('hhnnss', dt);
  end;

//------------------------------------------------------------------------------
  function formatSLL(const aAir, bSurf, cSubSurf, dDatum, eESMFix, fRP, gAreaCurs: byte;
    const hTime: TDateTime ): string;
  begin
//            '12345678901234567890123456789012'
    result := '$$Ax Sx Ux Dx Fx RPx Cx LT' + formatLocalTime(hTime);
    OverwriteString(result, IntToStr(aAir),      4);
    OverwriteString(result, IntToStr(bSurf),     7);
    OverwriteString(result, IntToStr(cSubSurf), 10);
    OverwriteString(result, IntToStr(dDatum),   13);
    OverwriteString(result, IntToStr(eESMFix),  16);
    OverwriteString(result, IntToStr(fRP),      20);
    OverwriteString(result, IntToStr(gAreaCurs),23);
  end;

  procedure SplitDegreeMinuteSecond(const dd: double; var d, m, s: double);
  var absLongLat       : double;
      MinDet{,DetDec}    : double;
      {Degree,Minute    : double;}
  begin
    absLongLat:=  abs(dd);
    d    :=  Trunc(absLongLat);
    MinDet    :=  Frac(absLongLat) * 60.0;
    m    :=  Trunc(MinDet);
    s    :=  Frac(MinDet) * 60.0;
  end;

  function formatDMS_long(const x: double): string;
  var absLongLat       : double;
      Degree, Minute, Second    : double;
  begin
    absLongLat:=  abs(x);
    if absLongLat > 180.0 then absLongLat := 180.0;
    SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

    if x<0 then
      Result:=FormatFloat('000 ', Degree) +
              FormatFloat('00.0', Minute)+ 'W'
    else
      Result:=FormatFloat('000 ', Degree) +
              FormatFloat('00.0', Minute)+ 'E';
  end;

  function formatDMS_lat(const y: double): string;
  var absLongLat       : double;
      Degree, Minute, Second    : double;
  begin
    absLongLat:=  abs(y);
    if absLongLat > 90.0 then absLongLat := 90.0;
    SplitDegreeMinuteSecond(absLongLat, Degree, Minute, Second);

    if y<0 then
      Result:=FormatFloat('00 ', Degree) +
              FormatFloat('00.0', Minute)+ 'S'
    else
      Result:=FormatFloat('00 ', Degree) +
              FormatFloat('00.0', Minute)+ 'N';
  end;

  function formatGeoCoord(const x, y: double; lt: tDateTime ): string;
  var s: string;
  begin // QGC+
  //          '12345678901234567890123456789012'
  //result := '$$RB 11 11.12 333 33.34 LTxxxxxx';
    result := '$$RB                    LT      ';

{%1} s := formatDMS_lat(y);
     OverwriteString(result, s, 6);

{%2} s := formatDMS_long(x);
     OverwriteString(result, s, 15);

{%3} s := formatLocalTime(lt);
     OverwriteString(result, s, 27);

  end;

  function formatGridCoord(const bObm, rOBM, xGrid, yGrid: double; const c: char): string;
  var s: string;
  begin // QSG+
  //          '12345678901234567890123456789012'
  //result := '$$RB 111 222.2 GRD 3 444.4 555.5';
    result := '$$RB           GRD              ';

{%1} s := FormatFloat('000', Round(bObm));
     OverwriteString(result, s, 6);

{%2} s := FormatFloat('000.0', rObm);
     OverwriteString(result, s, 10);

{%3} result[20] := c;

{%4} s := FormatFloat('000.0', xGrid);
     OverwriteString(result, s, 22);

{%5} s := FormatFloat('000.0', yGrid);
     OverwriteString(result, s, 28);

  end;
  function IsValidDatumSource(var str: string): boolean;
  begin
    str := Trim(UpperCase(str));
    result := (str = 'LOS') or
              (str = 'BOY') or
              (str = 'VIS') or
              (str = 'MAD') or
              (str = 'ESM') or
              (str = 'TOR') or
              (str = 'SIN');
  end;

  function IsValidSubClassif(str: string): boolean;
  begin
    str := Trim(UpperCase(str));
    result :=
    (str = 'UNC') or
    (str = 'POS') or
    (str = 'PRB') or
    (str = 'CRT') or
    (str = 'NOS');
  end;

  function ConvertStrToLongitude(const str :string ; var x: double): boolean;
  var strs: TStrings;
      sMin: string;
      cSign : char;
      i: integer;
     d, m : double;
  begin // andu format ddd mm.m
    result := false;
    strs := TStringList.Create;

    Split( ' ', str, strs);

    if strs.Count < 2 then exit;

    if not ConvertToInt(strs[0], i ) then exit;
    d := abs(i);
    if (d > 180) then exit;

    i := length(strs[1]);

    sMin := Copy(strs[1], 1, i-1);
    if not ConvertToFloat(sMin, m ) then exit;
    if m >= 60.0 then exit;

    cSign := strs[1][i];
    if not (cSign in ['E','W']) then exit;

    x := d + m/60.0;

    if x > 180.0 then exit;

    if cSign = 'E' then
     x := -x;

    strs.free;
    result := true;
  end;


  function ConvertStrToLattitude(const str:string ; var y: double): boolean;
  // andu format dd mm.m
  var strs: TStrings;
      sMin: string;
      cSign : char;
      i: integer;
     d, m : double;
  begin // andu format ddd mm.m
    result := false;
    strs := TStringList.Create;

    Split( ' ', str, strs);

    if strs.Count < 2 then exit;

    if not ConvertToInt(strs[0], i ) then exit;
    d := abs(i);
    if (d > 90) then exit;

    i := length(strs[1]);

    sMin := Copy(strs[1], 1, i-1);
    if not ConvertToFloat(sMin, m ) then exit;
    if m >= 60.0 then exit;

    cSign := strs[1][i];
    if not (cSign in ['S','N']) then exit;


    y := d + m/60.0;

    if y > 90.0 then exit;

    if cSign = 'S' then
     y := -y;

    strs.free;
    result := true;
  end;

  function formatQueryTW(const twCourse, twSpeed, rwCourse, rwSpeed,
             cCourse, cSpeed: double): string;
  var s: string;
  begin
  //          '12345678901234567890123456789012'
  //result := '$$TW 111 22 RW 333 44 CR 555 6.6';
    result := '$$TW        RW        CR       ';

  {%1} s := FormatFloat('000', Round(twCourse));
      OverwriteString(result, s, 6);

  {%2} s := FormatFloat('00', Round(twSpeed));
      OverwriteString(result, s, 10);

  {%3} s := FormatFloat('000', Round(rwCourse));
      OverwriteString(result, s, 16);

  {%4} s := FormatFloat('00', Round(rwSpeed));
      OverwriteString(result, s, 20);

  {%5} s := FormatFloat('000', Round(cCourse));
      OverwriteString(result, s, 26);

  {%6} s := FormatFloat('0.0', cSpeed);
      OverwriteString(result, s, 30);
  end;

  function formatParS1(): string;
  begin
    result := '$$STA   GD CS111SP22.2BR333RG4.4';

  end;

  function formatParS2(): string;
  begin
    result := '$$S5555 OS CS666SP77.7    DUXXXX';

  end;

  function formatParC1(): string;
  begin
    result := '$$CPA   TGTBR111 RG22.2         ';

  end;

  function formatParC2(): string;
  begin
    result :='$$S3333 CPABR444 RG55.5   DUXXXX';

  end;

  function formatParT1(const tns: string;
    const rangeSas, bearingSas, speedSas: double ): string;
  var s: string;
  begin
  //          '12345678901234567890123456789012'
    result := '$$TOR TN1111 R22222 B333 V4444  ';
    OverwriteString(result, tns, 9);

  {%2} s := FormatFloat('00000', Round(rangeSas));
      OverwriteString(result, s, 15);

  {%3} s := FormatFloat('000', Round(bearingSas));
      OverwriteString(result, s, 22);

  {%4} s := FormatFloat('0000', Round(speedSas));
      OverwriteString(result, s, 27);

  end;

  function formatParT2(const rPHP, bPHP, tPHP: double): string;
  var s: string;
  begin
  //           '12345678901234567890123456789012'
     result := '$$R55555 B666 T7 IC888 IR9999 LX';

  {%2} s := FormatFloat('00000', Round(rPHP));
      OverwriteString(result, s, 4);

  {%3} s := FormatFloat('000', Round(bPHP));
      OverwriteString(result, s, 11);

  {%4} s := FormatFloat('0', Round(tPHP));
      OverwriteString(result, s, 16);

{     R5  = jarak PHP
     B6  = BAringan PHP
     T7  = waktu run
     IC8 = Initial Stright Course ?
     IR9 = Initial Stright RUN ?
     LX  = P/S}
     
  end;

  function formatParV1(): string;
  begin
    result := '$$VEC MV111 TD22 TF33   TW444444';

  end;

  function formatParV2(): string;
  begin
    result := '$$56666CAR78888CS999SPOOO DUXXXX';

  end;

////////////////////////////////////////////////////////////////////////////////

  {function fmtowa_SCR_contoh(const sid, tn: byte; const course, speed: double) :string;
  var s  : string;
  begin
  //          '12345678901234567890123456789012'
    result := '  1122 333 44  ';

    s := MergeTrackNumber(sid, tn);
    OverwriteString(result, s, 3);

    s := FormatFloat('000', Round(course));
    OverwriteString(result, s, 8);

    s := FormatFloat('00', Round(speed));
    OverwriteString(result, s, 12);


  end;}

   function formatOWA_SCR(mTrack:TManualTrack):String;
   var s: string;
      cIdent : char;
   begin
//  result := 'A 3475 * H M 315 M1,8 12 7 4 +NRT 081625';
    result := ' ';
    cIdent := mTrack.GetIdent;

    case mTrack.Domain of
      tdUdara : begin
   {a}     result := trackDomainToChar(mTrack.Domain);
   {b}     s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
   {c}     result := result + ' ' + s + '*';

   {d}     s := TrackIdentTo_IDA(cIdent);
           result := result + ' ' + s;

   {e}     s := IdentTambahanToChar(cIdent);
           result := Result + ' ' + s;

   {f}    s := FormatFloat('000',round(mTrack.Course));
          result := Result + ' ' + s;

   {g}    s := FormatFloat('0000',round(mTrack.Speed));
          result := Result + ' ' + s;

   {h}    s := FormatFloat('00',round(mTrack.Height));
          result := Result + ' ' + s;

   {i}    result := result + ' ' +'7'; // LTQ (0 - 7) blm tahu darimana

   {j}    result := result + ' ' +'4'; // RTQ (1 - 4) blm tahu darimana

   {k}    result := result + ' ' +'+NRT'; // Real time/geo indicator (-NRT , +NRT)

   {l}    s := formatLocalTime(Now);
          result := result + ' ' + s;
      end;
      tdAtasAir  : begin
   {a}    result := trackDomainToChar(mTrack.Domain);
   {b}    s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
   {c}    result := result + ' ' + s + '*';

   {d}    s := TrackIdentTo_IDA(cIdent);
          result := result + ' ' + s;

   {e}    s := IdentTambahanToChar(cIdent);
          result := Result + ' ' + s;

   {f}    s := FormatFloat('000',round(mTrack.Course));
          result := Result + ' ' + s;

   {g}    s := FormatFloat('0000',round(mTrack.Speed));
          result := Result + ' ' + s;

   {h}    result := result + ' ' +'7'; // LTQ (0 - 7) blm tahu darimana

   {i}    result := result + ' ' +'4'; // RTQ (1 - 4) blm tahu darimana

   {j}    result := result + ' ' +'+NRT'; // Real time/geo indicator (-NRT , +NRT)

   {k}    s := formatLocalTime(Now);
          result := result + ' ' + s;
      end;
      tdBawahAir : begin
   {a}     result := trackDomainToChar(mTrack.Domain);
   {b}     s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
   {c}     result := result + ' ' + s + '*';

   {d}     s := TrackIdentTo_IDA(cIdent);
           result := result + ' ' + s;

   {e}     s := USubclassToChar(mTrack.SubClassification);
           result := Result + ' ' + s;

   {f}     result := Result + ' ' + '4'; // confidence level(huruf&angka 1 - 4)

   {g}     s := FormatFloat('000',round(mTrack.Course));
           result := Result + ' ' + s;

   {h}     s := FormatFloat('0000',round(mTrack.Speed));
           result := Result + ' ' + s;

   {i}     s := FormatFloat('00',round(mTrack.Height)); // kedalaman
           result := Result + ' ' + s;

   {j}     result := Result + ' ' + '+13'; // dopler (-45 s/d +45)

   {k}     result := result + ' ' +'+NRT'; // Real time/geo indicator (-NRT , +NRT)

   {l}     s := formatLocalTime(Now);
           result := result + ' ' + s;
      end;
    end;
   end;

   function formatOWA_ACR_IFF(mTrack: TManualTrack):String;
   var s: string;
   begin   //  '1234567890123456789012345'
 //  result := 'S 3457 * IFF S2 6610 7143';
     result := '       * IFF             ';

{%1}  s := trackDomainToChar(mTrack.Domain);
      OverwriteString(result, s, 1);

{%2}  s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
      OverwriteString(result, s, 3);

{%3}  s := 'S2'; // KODE IFF MODE 1
      OverwriteString(result, s, 14);

{%4}  s := '6610'; // KODE IFF MODE 2
      OverwriteString(result, s, 17);

{%5}  s := '7143'; // KODE IFF MODE 3
      OverwriteString(result, s, 22);
   end;

   function formatOWA_ACR_ESM(mTrack: TManualTrack):String;
   var s: string;
   begin   //  '1234567890123456789012345678901'
 //  result := 'S 3457 * ESM TOPSAIL + 3 KRESTA';
     result := '       * ESM                   ';

{%1}  s := trackDomainToChar(mTrack.Domain);
      OverwriteString(result, s, 1);

{%2}  s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
      OverwriteString(result, s, 3);

{%3}  s := 'TOP SAIL'; // NAMA RADAR
      OverwriteString(result, s, 14);

{%4}  s := '+'; // + : THREAT RADAR -: BUKAN THREAT RADAR
      OverwriteString(result, s, 22);

{%5}  s := '3'; // CONFIDENCE LEVEL
      OverwriteString(result, s, 24);

{%6}  s := 'KRESTA'; // NAMA PLATFORM
      OverwriteString(result, s, 26);
   end;

   function formatOWA_ACR_PVC(mTrack: TManualTrack):String;
   var s: string;
   begin   //  '12345678901234567890'
 //  result := 'U 1251 PVC XXXXXXXXX';
     result := '       PVC          ';

{%1}  s := trackDomainToChar(mTrack.Domain);
      OverwriteString(result, s, 1);

{%2}  s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
      OverwriteString(result, s, 3);

{%3}  OverwriteString(result, mTrack.PrivateCode, 12);
   end;

   function formatOWA_SCR_bearing(mTrack: TESMBearingTrack):String;
   var s: string;
//      cIdent : char;
   begin
//  result := 'P 3475 - DAT 270 10.1 10 99   120259';
    result := ' ';

   {a}     result := 'P';
   {b}     s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
   {c}     result := result + ' ' + s + ' ';

   {d}     s := mTrack.pointType;
           result := result + ' ' + s;

   {e}    s := FormatFloat('000',round(mTrack.Course));
          result := Result + ' ' + s;

   {f}    s := FormatFloat('0000',round(mTrack.Speed));
          result := Result + ' ' + s;

   {g}    s := FormatFloat('00',round(mTrack.Height));
          result := Result + ' ' + s;

   {h}    result := result + ' ' +' '; // ERROR

   {i}    result := result + ' ' +'+NRT'; // Real time/geo indicator (-NRT , +NRT)

   {j}    s := formatLocalTime(Now);
          result := result + ' ' + s;

   end;


   function formatOWA_PVC_bearing(mTrack: TESMBearingTrack):String;
   var s: string;
   begin   //  '12345678901234567890'
 //  result := 'U 1251 PVC XXXXXXXXX';
     result := '       PVC          ';

{%1}  s := 'P';
      OverwriteString(result, s, 1);

{%2}  s := MergeTrackNumber(mTrack.ShipTrackId, mTrack.TrackNumber);
      OverwriteString(result, s, 3);

{%3}  OverwriteString(result, mTrack.PrivateCode, 12);
   end;

   function formatDR_OBM(pX,pY :Double; cIdent:Char; dX,dY :Double):String;
   var s:String;
   begin
   //result := 010 07 00N 115 2700 E W 005-012.0728
      result := '';

      s := formatDMS_long(pX);
      result := result + s;

      s := formatDMS_lat(pY);
      result := Result + ' '+s;

      result := Result + ' '+ cIdent + ' ' + FormatFloat('000',dX) + '-' + FormatFloat('000',dY) ;


      s:= formatLocalTime(now);
      result := result + '-' + s;
   end;

   function formatDR_OCM(head,dist :Double):String;
   var s:String;
   begin
   // result := S 0010 000.0 000.0 085.5 000.05
      result := 'S 0010 000.0 000.0';

      s := FormatFloat('000.0',head);
      result := result + ' ' + s;

      s := FormatFloat('000.0',dist);
      result := Result + ' ' + s;
   end;


end.
