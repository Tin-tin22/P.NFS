unit ufDisplay_OWA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufANDUDisplay, StdCtrls, ExtCtrls, uLibTDCClass;

const

   C_Count_SP1 = 12;
   C_Count_SP2 = 12;

   C_LineCount_ParSP2 : array [1 .. 11] of byte =
  //A   B   C    D  E   F  G  H   I  J  K
   (12, 12 , 6 , 12, 6, 11, 0, 0, 11, 0, 12);

   C_PARSP2_Set = ['A', 'B', 'C', 'D', 'E', 'F', 'I', 'K'];

   //masking
   C_Mask_UnEditable = 0;
   C_Mask_String     = 1;
   C_Mask_Integer    = 2;
   C_Mask_Word       = 3;  // POSITIF VALUE
   C_Mask_Float      = 4;
//   C_Mask_Coord      = 5;


type



  TStringFunction = function: string of object;

  TExecLineFunction = function(const ss: TStrings): integer of object;
  TExecStringFunction = function(const s: string): integer of object;

  TValidatorFunction = function(const s: string): boolean;

  // masih dipakai SP 1
  TSPData  = record
    SData     : string; // string data
    SPatt     : string; // pattern
    GetFunction : TStringFunction;
    ExcFunction : TExecLineFunction;
  end;

  TWorkPageData = record
    Content : byte;
    Header  : string;
    CSysPage: byte;
    CPar    : byte;
    CLin    : byte;
  end;


// =============================================================================
  TSPDataClass  = class
  protected
    function DefGetFunction: string;
    function DefExcFunction(const ss:  TStrings): integer;

  public
    SData     : string; // string data
    SPatt     : string; // pattern
    OnGetFunction : TStringFunction;
//    OnExcFunction : TExecStringFunction;
    OnExcFunction : TExecLineFunction;

    constructor Create;

    function GetFunction: string;
    function ExcFunction(const s: string): integer;
  end;

// =============================================================================
  TfrmDisplay_Owa = class(TfrmANDUDisplay)
    edPageHeader: TEdit;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AnduTDC16KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);

  protected
// -----------------------------------------------------------------------------

    SP_1 : array [0 .. C_Count_SP1-1] of TSPData;
    SP_2 : array [0 .. C_Count_SP2-1] of string;  // SP 2  'header'
   // CheckValidFunc :
(* -----------------------------------------------------------------------------
    function Get_SP1_xx =
      : mengambil aktual data sistem page dari TDC
*)
    function Get_SP1_00: string;
    function Get_SP1_01: string;
    function Get_SP1_02: string;
    function Get_SP1_03: string;
    function Get_SP1_04: string;
    function Get_SP1_05: string;
    function Get_SP1_06: string;
    function Get_SP1_07: string;
    function Get_SP1_08: string;
    function Get_SP1_09: string;
    function Get_SP1_10: string;
    function Get_SP1_11: string;
(* --------------------------------------------------------
    function exc_SP1_xx
      : memasukkan data from ANDU DRL / ICL ke TDC
*)
    function exc_SP1_00(const ss: TStrings): integer;
    function exc_SP1_01(const ss: TStrings): integer;
    function exc_SP1_02(const ss: TStrings): integer;
    function exc_SP1_03(const ss: TStrings): integer;
    function exc_SP1_04(const ss: TStrings): integer;
    function exc_SP1_05(const ss: TStrings): integer;
    function exc_SP1_06(const ss: TStrings): integer;
    function exc_SP1_07(const ss: TStrings): integer;
    function exc_SP1_08(const ss: TStrings): integer;
    function exc_SP1_09(const ss: TStrings): integer;
    function exc_SP1_10(const ss: TStrings): integer;
    function exc_SP1_11(const ss: TStrings): integer;

(* -----------------------------------------------------------------------------
    function Get_SP2_xx =
      : mengambil data  dari S Data
    function Get_SP2_deffunction: string;


*)
    procedure UpdateDataHarpoonEngage(sender: TObject);
    function Get_SP2_A_I: string;
    function exc_SP2_A_I(const ss: TStrings): integer;

    function Get_SP2_A_J: string;
    function exc_SP2_A_J(const ss: TStrings): integer;

    function Get_SP2_A_K: string;
    function exc_SP2_A_K(const ss: TStrings): integer;

  public
    { Public declarations }
    iTDC : TGenericTDCInterface;

    ParSP2 : array [1 .. 11] of array of TSPDataClass;
    PRM    : array [1 .. 13] of string;

    WPData : array[0 ..2] of TWorkPageData;

    // Get -> return string;
    function GetSysPageLine(const page: byte; const line: char): string;
    function SetSysPageLine(const page: byte; const line: char; const s: string): string;

    // Dislay -> show in ANDU edit.
    procedure Display_SystemPage(const spNum: byte);
    procedure Erase_SystemPage(const spNum: byte);

    procedure Display_Paragraph(const par: char);
    procedure Erase_Paragraph(const par: char);
    procedure Update_Paragraph(const par, lin: char);

    // SP 2
    procedure DisplayParLine_DRL(const par, line: char);


    // get formated string from system
    procedure DisplayPageHeader(const str: string);

    procedure SelectPage(pgIndex: byte); override;

    //wrapper & checker  for  execFunction
    function exec_SP1_Func(const line: char; const ss: TStrings) :integer;
    function exec_SP2_Func(const aPar, aLine: char; const sCmd: string) :integer;

    function tdc_CreateSpecialPoint(const x, y: double): integer;

    procedure SetUpdateHarpoonEngaged(sI, sJ, sK: string);


  end;

  function PageCharToByte(const c: char): byte;
  function PageByteTochar(const b: byte): char;


var
  frmDisplay_Owa: TfrmDisplay_Owa;

//  valid_func : array [0.. 4] of TValidatorFunction;

implementation



uses
  uBaseDataType, uStringFunction, uBaseFunction, uLibTDC_Oswald, uTrackFunction,
   Math, uTCPDatatype, uBaseConstan;

{$R *.dfm}

{const
  C_PAR_1 = 1;
  C_PAR_2 = 2;
//  C_LINE_A = 2
}

const
  //harpoon setting constan
  C_LM : array [0..1] of string =('RBL', 'BOL');
  C_SM : array [0..1] of string =('AB', 'SA');
  C_SZ : array [0..2] of string =('S', 'M', 'L');
  C_DD : array [0..1] of string =('PT', 'SB');

var oTDC : TTDC_Oswald;

function FindFirstNotSpace(const str: string; const off: byte=1): byte;
var i, count: byte;
    found : boolean;
begin
  result := 0;
  found  :=  false;
  i := off;
  count := Length(str);
  while not found and (i < count) do begin
    found :=  str[i] <> ' ';
    inc(i);
  end;
  if found then result := i-1;
end;

{function GetErrorString(const err: integer): string;
begin

end;
}
function fmtDaisyCoord(const aCoord:  t2DPoint): string;
var s: string;
    x, dx, mx : double;
    sn : TValueSign;
begin
 //        '0         1         2         3         4'
 ////       '1234567890123456789012345678901234567890'
  result := '00 - 00.0N 000 - 00.0E';

  sn := Sign(aCoord.Y);
  x  := abs(aCoord.Y); // get positive
  dx := floor(x);      // let it down.
  mx := (x - dx) * 60; // the minute

  s := FormatFloat('00', Round(dx));
  OverwriteString(result, s, 1);

  s := FormatFloat('00.0', mx);
  OverwriteString(result, s, 6);

  if sn = -1 then
    result[10] := 'S'
  else
    result[10] := 'N';

  sn := Sign(aCoord.X);
  x  := abs(aCoord.X);
  dx := floor(x);
  mx := (x - dx) * 60;

  s := FormatFloat('000', Round(dx));
  OverwriteString(result, s, 12);

  s := FormatFloat('00.0', mx);
  OverwriteString(result, s, 18);

  if sn = -1 then
    result[22] := 'W'
  else
    result[22] := 'E'

end;

function splitDaisyCoord(const s: string; var aCoord:  t2DPoint): boolean;
var ss: TStrings;
    sMin: string;
    cSign: char;
    dMin : double;
    w : word;
    getLatt, getLong : boolean;
begin
  result := false;
  if Length(s) <> 22 then exit;
  ss := TStringList.Create;
//  result := '00 - 00.0N 000 - 00.0E';
//              0 1  2      3 4  5
  Split_2(' ', s, ss);
  getLatt := FALSE;
  getLong := FALSE;

  if ss.Count = 6 then begin
    if ConvertToWord(ss[0], w) then begin
      if length(ss[2]) = 5 then begin
        sMin :=  Copy(ss[2], 1, 4);
        cSign := ss[2][5];
        if ConvertToFloat(sMin, dMin) then begin
          if cSign = 'S' then
            aCoord.Y := -(w + dMin / 60)
          else
            aCoord.Y := (w + dMin / 60);

          getLatt := true;
        end;
      end;
    end;

    if ConvertToWord(ss[3], w) then begin
      if length(ss[5]) = 5 then begin
        sMin :=  Copy(ss[5], 1, 4);
        cSign := ss[5][5];
        if ConvertToFloat(sMin, dMin) then begin
          if cSign = 'W' then
            aCoord.X := -(w + dMin / 60)
          else
            aCoord.X := (w + dMin / 60);

          getLong := true;
        end;
      end;
    end;
  end;

  result := getLatt and getLong;

  ss.Free;
end;

function fmtDaisyLocalTime(const dt: TDateTime): string;
begin
  result := FormatDateTime('hhnn', dt);
end;

{   C_Mask_UnEditable = 0;
   C_Mask_String     = 1;
   C_Mask_Integer    = 2;
   C_Mask_Word       = 3;  // POSITIF VALUE
   C_Mask_Float      = 4;


function IsValid_Mask_UnEditable(const s: string): boolean;
begin
  result := false;
end;

function IsValid_Mask_String(const s: string): boolean;
begin
  result := true;
end;

function IsValid_Mask_Integer(const s: string): boolean;
var i: integer;
begin
  result := ConvertToInt(s, i);
end;

function IsValid_Mask_Word(const s: string): boolean;
var i: word;
begin
  result := ConvertToWord(s, i);
end;

function IsValid_Mask_double(const s: string): boolean;
var f: Double;
begin
  result := ConvertToFloat(s, f);
end;
}
//==============================================================================
function CompareWithPattern(const sOld, sPtrn, sCmd: string;  var ssNew: TStrings): boolean;
{ sOld : original string.
  sCmd : merged space string.
}
var i, z: integer;
    ssOld, ssPat, ssCmd : TStrings;
    b : byte;
    allowed : boolean;
begin

  ssOld := TStringList.Create;
  ssPat := TStringList.Create;
  ssCmd := TStringList.Create;

  Split_2(' ', sOld , ssOld);
  Split_2(' ', sPtrn, ssPat);
  Split_2(' ', sCmd , ssCmd);
  // klo ga ada patern, oldnya tetap.
  // maks sejumlah pattern.

  result := true;

  for i := 0 to ssPat.Count-1 do begin
    b := StrToInt(ssPat[i]);
    if b = 0 then begin          // 0: unchange
      if i < ssOld.Count then begin
        ssNew.Add(ssOld[i]);
        allowed := SameText(ssOld[i], ssCmd[i]);
      end;
    end
    else if (b > 0) then begin
      if i < ssCmd.Count then
        ssNew.Add(ssCmd[i]);

      allowed := true;

    end;
    result := result and allowed;
  end;

  ssCmd.Free;
  ssPat.Free;
  ssOld.Free;
end;

function PageCharToByte(const c: char): byte;
begin //a -> 1
   result := ord(c) - 64;
end;

function PageByteTochar(const b: byte): char;
begin
   result := char(b + 64);
end;
//=============================================================================
{ TSPDataClass }

constructor TSPDataClass.Create;
begin
  OnGetFunction := DefGetFunction;
  OnExcFunction := DefExcFunction;
end;

function TSPDataClass.DefGetFunction: string;
begin
   Result := SData;
end;

{function TSPDataClass.DefExcFunction(const s: string): integer;
var sOld : string;
    ss  : TStrings;
begin
 sOld := GetFunction;

 ss  := TStringList.Create;

 if CompareWithPattern(sOld, SPatt, s, ss) then begin
   sData := s;
   result := 1;
 end;

 ss.Free;
end;

//==============================================================================

function TSPDataClass.ExcFunction(const s: string): integer;
begin
    Result := OnExcFunction(s);
end;
}
function TSPDataClass.DefExcFunction(const ss: TStrings): integer;
begin

  result := 1;

end;

//==============================================================================

function TSPDataClass.ExcFunction(const s: string): integer;
var sOld : string;
    ss  : TStrings;
begin
 sOld := GetFunction;

 ss  := TStringList.Create;

 if CompareWithPattern(sOld, SPatt, s, ss) then begin

   Result := OnExcFunction(ss);
 end;

 ss.Free;
end;

function TSPDataClass.GetFunction: string;
begin
    result := OnGetFunction;
end;

//==============================================================================
procedure TfrmDisplay_Owa.AnduTDC16KeyPress(Sender: TObject;
  var Key: Char);
var iKey : integer;
begin
  iKey := Ord(Key);
  if iKey = VK_RETURN	then begin
    if Assigned(FOnExecuteCmd) then begin
      StrCmd := AnduTDC16.Text;
      FOnExecuteCmd(StrCmd);
      Key := #0;
    end;
  end;
end;


procedure TfrmDisplay_Owa.FormCreate(Sender: TObject);
var a,b : byte;
begin
  inherited;
  ICL := AnduTDC16;

  SetNumOfPage(3); // Work page 1, 2, 3
  CurrentPageIndex := 0;

//- init -----------------------------------------------------------------------
  SP_1[ 0].SData := '1 Ship                              ';
  SP_1[ 1].SData := 'A DTGR 010600 Z JUL 83 0700 A 01    ';
  SP_1[ 2].SData := 'B COURSE MAN 045 SPEED MAN 14.8     ';
  SP_1[ 3].SData := 'C WIND 265 06 R 070 12 M/S          ';
  SP_1[ 4].SData := 'D DRIFT P 003 MAN 0250              ';
  SP_1[ 5].SData := 'E GRIDLCK P 1735 MAN 0250           ';
  SP_1[ 6].SData := 'F DEG S 53 - 03.5N 003 - 34.7E 0430 ';
  SP_1[ 7].SData := 'G PADS  00 - 00.0N 000 - 00.0E 0432 ';
  SP_1[ 8].SData := 'H DOG   53 - 03.5N 003 - 34.7E 0530 ';
  SP_1[ 9].SData := 'I DLRP  53 - 10.4N 003 - 25.2E 0530 ';
  SP_1[10].SData := 'J TGO   53 - 10.0N 003 - 25.0E 0531 ';
  SP_1[11].SData := 'K TNBLCK 2400 - 2577 0S 0024 0430   ';

  SP_1[ 0].GetFunction :=  Get_SP1_00;
  SP_1[ 1].GetFunction :=  Get_SP1_01;
  SP_1[ 2].GetFunction :=  Get_SP1_02;
  SP_1[ 3].GetFunction :=  Get_SP1_03;
  SP_1[ 4].GetFunction :=  Get_SP1_04;
  SP_1[ 5].GetFunction :=  Get_SP1_05;
  SP_1[ 6].GetFunction :=  Get_SP1_06;
  SP_1[ 7].GetFunction :=  Get_SP1_07;
  SP_1[ 8].GetFunction :=  Get_SP1_08;
  SP_1[ 9].GetFunction :=  Get_SP1_09;
  SP_1[10].GetFunction :=  Get_SP1_10;
  SP_1[11].GetFunction :=  Get_SP1_11;

  SP_1[ 0].ExcFunction :=  exc_SP1_00;
  SP_1[ 1].ExcFunction :=  exc_SP1_01;
  SP_1[ 2].ExcFunction :=  exc_SP1_02;
  SP_1[ 3].ExcFunction :=  exc_SP1_03;
  SP_1[ 4].ExcFunction :=  exc_SP1_04;
  SP_1[ 5].ExcFunction :=  exc_SP1_05;
  SP_1[ 6].ExcFunction :=  exc_SP1_06;
  SP_1[ 7].ExcFunction :=  exc_SP1_07;
  SP_1[ 8].ExcFunction :=  exc_SP1_08;
  SP_1[ 9].ExcFunction :=  exc_SP1_09;
  SP_1[10].ExcFunction :=  exc_SP1_10;
  SP_1[11].ExcFunction :=  exc_SP1_11;


  SP_2[ 0] := '2           '   ;
  SP_2[ 1] := 'A AAW / SW  '   ;
  SP_2[ 2] := 'B ASW       '   ;
  SP_2[ 3] := 'C EW        '   ;
  SP_2[ 4] := 'D TACMAN    '   ;
  SP_2[ 5] := 'E FAAW      '   ;
  SP_2[ 6] := 'F LINK I    '   ;
  SP_2[ 7] := '            '   ;
  SP_2[ 8] := '            '   ;
  SP_2[ 9] := 'I TACT REFF '   ;
  SP_2[10] := '            '   ;
  SP_2[11] := 'K SYMON     '   ;

  for b := 1 to C_Count_SP2-1 do
    SetLength(ParSP2[b], C_LineCount_ParSP2[b] );

  for b := 1 to C_Count_SP2-1 do
    if C_LineCount_ParSP2[b] > 0 then
      for a := 0 to C_LineCount_ParSP2[b]-1 do
        ParSP2[b, a] := TSPDataClass.Create;


// - init  SP2 --------------------------------------------------------

               //// '1234567890123456789012345678901234567890'
  ParSP2[ 1,  0].SData  := 'A AAW / SW                            ';
  ParSP2[ 1,  0].SPatt  := '0 0 0 0';

  ParSP2[ 1,  1].SData  := 'A VITAL AREA ..... RADIUS ... WARFARE ';
  ParSP2[ 1,  1].SPatt  := '0 0 0 1 0 1 0';

  ParSP2[ 1,  2].SData  := 'B .                                   ';
  ParSP2[ 1,  2].SPatt  := '0';

  ParSP2[ 1,  3].SData  := 'C FC 1                                ';
  ParSP2[ 1,  3].SPatt  := '0 0 0 1 1 1 1 1 1';

  ParSP2[ 1,  4].SData  := 'D FC 2                                ';
  ParSP2[ 1,  4].SPatt  := '0 0 0 1 1 1 1 1 1';

  ParSP2[ 1,  5].SData  := 'E FC 3                                ';
  ParSP2[ 1,  5].SPatt  := '0 0 0 1 1 1 1 1 1';
// --
  ParSP2[ 1,  6].SData  := 'F                                     ';
  ParSP2[ 1,  6].SPatt  := '0';

  ParSP2[ 1,  7].SData  := 'G                                     ';
  ParSP2[ 1,  7].SPatt  := '0';

  ParSP2[ 1,  8].SData  := 'H                                     ';
  ParSP2[ 1,  8].SPatt  := '0';

  ParSP2[ 1,  9].SData  := 'I SSM .....                          ';
  ParSP2[ 1,  9].SPatt  := '0 0 1';
  ParSP2[ 1,  9].OnGetFunction := Get_SP2_A_I;
  ParSP2[ 1,  10].OnExcFunction := exc_SP2_A_I;

  ParSP2[ 1,  10].SData  := 'J RBL AB REC L SEL L ..... SB ..       ';
  ParSP2[ 1,  10].SPatt  := '0 1   1  0   1 0   0 1     1  1';
  ParSP2[ 1,  10].OnGetFunction := Get_SP2_A_J;
  ParSP2[ 1,  10].OnExcFunction := exc_SP2_A_J;

  ParSP2[ 1,  11].SData  := 'K COR TGTMV WND OOO 00 TMP .....     ';
  ParSP2[ 1,  11].SPatt  := '0 0   0     0   1   1  0   1';
  ParSP2[ 1,  11].OnGetFunction := Get_SP2_A_K;
  ParSP2[ 1,  11].OnExcFunction := exc_SP2_A_K;

  // ---------------------------------------------------------------


  ParSP2[ 2,  0].SData  := 'B ASW                                 ';
  ParSP2[ 2,  0].SPatt  := '0 0';

  ParSP2[ 2,  1].SData  := 'A TORT                                ';
  ParSP2[ 2,  1].SPatt  := '0 0';

  ParSP2[ 2,  2].SData  := 'B PORT 44-44-44    STBD 44-44-44      ';
  ParSP2[ 2,  2].SPatt  := '0 0 1 0 1';

  ParSP2[ 2,  3].SData  := 'C ADVICE MK --     URGENT ------      ';
  ParSP2[ 2,  3].SPatt  := '0 0 0 1 0 1';

  ParSP2[ 2,  4].SData  := 'D SWITCH ISD - FLOOR -                ';
  ParSP2[ 2,  4].SPatt  := '0 0 0 1 0 1';

  ParSP2[ 2,  5].SData  := 'E LAUNCHE   COURSE ---                ';
  ParSP2[ 2,  5].SPatt  := '0 0 0 1';

  ParSP2[ 2,  6].SData  := 'F ---          COURSE --- SEC         ';
  ParSP2[ 2,  6].SPatt  := '0 1 0 1 0';

  ParSP2[ 2,  7].SData  := 'G                                     ';
  ParSP2[ 2,  7].SPatt  := '0';

  ParSP2[ 2,  8].SData  := 'H                                     ';
  ParSP2[ 2,  8].SPatt  := '0';

  ParSP2[ 2,  9].SData  := 'I                                     ';
  ParSP2[ 2,  9].SPatt  := '0';

  ParSP2[ 2, 10].SData  := 'J VDS  CABLE  000 FT  DEPTH 000  FT   ';
  ParSP2[ 2, 10].SPatt  := '0 0 0 1 0 0 1 0';

  ParSP2[ 2, 11].SData  := 'K UWSV 4900 FT/SEC WATER DEPTH 0000 M ';
  ParSP2[ 2, 11].SPatt  := '0 0 1 0 0 0 1 0';
  // ----------------------------------------------------------

  ParSP2[ 3,  0].SData  := 'C EW                                  ';
  ParSP2[ 3,  0].SPatt  := '0 0';

//  ParSP2[ 3,  1].SData  := 'A B3456   ESM   280   B S 1257  EU  F ';
  ParSP2[ 3,  1].SData  := 'A         ESM         B S       EU  F ';
  ParSP2[ 3,  1].SPatt  := '0 1 0 1 0 0 1 0 0';

  ParSP2[ 3,  2].SData  := 'B PUFFBALL +3 BEARCHARLIE             ';
  ParSP2[ 3,  2].SPatt  := '0 1 1 1';

  ParSP2[ 3,  3].SData  := 'C PURPOSE -- SCANTY -- ARP         ';
  ParSP2[ 3,  3].SPatt  := '0 0 1 0 1 0';

  ParSP2[ 3,  4].SData  := 'D FA  - FREQ  -----                ';
  ParSP2[ 3,  4].SPatt  := '0 0 1 0 1';

  ParSP2[ 3,  5].SData  := 'E PJ  - PRF    -----    PW -----    ';
  ParSP2[ 3,  5].SPatt  := '0 0 1 0 1 0 1';

  // ----------------------------------------------------------

  ParSP2[ 4,  0].SData  := 'D TACMAN                              ';
  ParSP2[ 4,  0].SPatt  := '0 0';

  ParSP2[ 4,  1].SData  := 'A ---- TYP ----- SPD ----  -----      ';
  ParSP2[ 4,  1].SPatt  := '0 1 0 1 0 1 1';

  ParSP2[ 4,  2].SData  := 'B END --- MPNT 00 T00-0 VAR 00E       ';
  ParSP2[ 4,  2].SPatt  := '0 0 1 0 1 1 0 1';

  ParSP2[ 4,  3].SData  := 'C ---- ----- BRG --- RNG ----         ';
  ParSP2[ 4,  3].SPatt  := '0 1 1 0 1 0 1';

  ParSP2[ 4,  4].SData  := 'D PROCEED  ----  RNG ---- TIME ----   ';
  ParSP2[ 4,  4].SPatt  := '0 0 1 0 1 0 1';

  ParSP2[ 4,  5].SData  := 'E CONTROLLING UNIT -----              ';
  ParSP2[ 4,  5].SPatt  := '0 0 0 1';

  ParSP2[ 4,  6].SData  := 'F ---- TYP --- SPD ---- -----         ';
  ParSP2[ 4,  6].SPatt  := '0 1 0 1 0 1 1';

  ParSP2[ 4,  7].SData  := 'G END --- MPNT 000 T 00-0 VAR 00E     ';
  ParSP2[ 4,  7].SPatt  := '0 0 1 0 1 0 1 0 1';

  ParSP2[ 4,  8].SData  := 'H ----- --- -- BRG --- RGN ---        ';
  ParSP2[ 4,  8].SPatt  := '0 1 1 1 0 1 0 1';

  ParSP2[ 4,  9].SData  := 'I PROCEED --- RNG ---- TIME ----      ';
  ParSP2[ 4,  9].SPatt  := '0 0 1 0 1 0 1';

  ParSP2[ 4, 10].SData  := 'J ----- TYP ----- SPD ---- -----      ';
  ParSP2[ 4, 10].SPatt  := '0 1 0 1 0 1 1';

  ParSP2[ 4, 11].SData  := 'K S 0010 SEA . FC 000 FH 400 FT       ';
  ParSP2[ 4, 11].SPatt  := '0 1 1 0 1 0 1 0 1 0';

  // ----------------------------------------------------------

  ParSP2[ 5,  0].SData  := 'E FAAW                                ';
  ParSP2[ 5,  0].SPatt  := '0 0';

  ParSP2[ 5,  1].SData  := 'A UNIT     WPN    STAT   IRGT    CU   ';
  ParSP2[ 5,  1].SPatt  := '0 0 0 0 0 0';

  ParSP2[ 5,  2].SData  := 'B A 1223   REAR     +    .....  ....  ';
  ParSP2[ 5,  2].SPatt  := '0 1 1 1 1 1 1';

  ParSP2[ 5,  3].SData  := 'C A 1224   FRONT    +    .....  ....  ';
  ParSP2[ 5,  3].SPatt  := '0 1 1 1 1 1 1';

  ParSP2[ 5,  4].SData  := 'D S 0015   SAMSR    +    .....  ....  ';
  ParSP2[ 5,  4].SPatt  := '0 1 1 1 1 1 1';

  ParSP2[ 5,  5].SData  := 'E D 0012   SAMSR    +    .....  ....  ';
  ParSP2[ 5,  5].SPatt  := '0 1 1 1 1 1 1';

  // ----------------------------------------------------------
  ParSP2[ 6,  0].SData  := 'F LINK I                              ';
  ParSP2[ 6,  0].SPatt  := '0 0 0';

  ParSP2[ 6,  1].SData  := 'A FILTER AIR           NON AIR        ';
  ParSP2[ 6,  1].SPatt  := '0 0 0 0 0';

  ParSP2[ 6,  2].SData  := 'B TX           TX OS   AMPOS A  SU  . ';
  ParSP2[ 6,  2].SPatt  := '0 0 0 0 0 0 0 1';

  ParSP2[ 6,  3].SData  := 'C ..........   ....     ..... ....    ';
  ParSP2[ 6,  3].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  4].SData  := 'D ..........   ....     ..... ....    ';
  ParSP2[ 6,  4].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  5].SData  := 'E ..........   ....     ..... ....    ';
  ParSP2[ 6,  5].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  6].SData  := 'F ..........   ....     ..... ....    ';
  ParSP2[ 6,  6].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  7].SData  := 'G ..........   ....     ..... ....    ';
  ParSP2[ 6,  7].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  8].SData  := 'H ..........   ....     ..... ....    ';
  ParSP2[ 6,  8].SPatt  := '0 1 1 1 1';

  ParSP2[ 6,  9].SData  := 'I ..........   ....     ..... ....    ';
  ParSP2[ 6,  9].SPatt  := '0 1 1 1 1';

  ParSP2[ 6, 10].SData  := 'J ..........   ....     ..... ....    ';
  ParSP2[ 6, 10].SPatt  := '0 1 1 1 1';

  // ----------------------------------------------------------

  ParSP2[ 9,  0].SData  := 'I TACT REFF                           ';
  ParSP2[ 9,  0].SPatt  := '0 0 0';

//  ParSP2[ 9,  1].SData  := 'A FOC P5130    1513     A4107 ....    ';
  ParSP2[ 9,  1].SData  := 'A FOC .....    ....     ..... ....    ';
  ParSP2[ 9,  1].SPatt  := '0 0 1 1 1 1';

  ParSP2[ 9,  2].SData  := 'B FOC .....    ....     ..... ....    ';
  ParSP2[ 9,  2].SPatt  := '0 0 1 1 1 1';

  ParSP2[ 9,  3].SData  := 'C FOC .....    ....     ..... ....    ';
  ParSP2[ 9,  3].SPatt  := '0 0 1 1 1 1';

  ParSP2[ 9,  4].SData  := 'D CIR ..... R+   . .... T.  ..... T-  ';
  ParSP2[ 9,  4].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9,  5].SData  := 'E CIR ..... T-   . .... T-  ..... T-  ';
  ParSP2[ 9,  5].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9,  6].SData  := 'F FIG ..... T.   . .... T.  ..... T-  ';
  ParSP2[ 9,  6].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9,  7].SData  := 'G FIG ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9,  7].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9,  8].SData  := 'H FIG ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9,  8].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9,  9].SData  := 'I BTR ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9,  9].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  ParSP2[ 9, 10].SData  := 'J BTR ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9, 10].SPatt  := '0 0 1 1 1 1 1 1 1 ';

  // ----------------------------------------------------------

  ParSP2[11,  0].SData  := 'K SYMON                               ';
  ParSP2[11,  0].SPatt  := '0 0 ';

  ParSP2[11,  1].SData  := 'A DA 276 LINK 10  PRESENT  ACT        ';
  ParSP2[11,  1].SPatt  := '0 0 0 0 0 0 0';

  ParSP2[11,  2].SData  := 'B DA 276 EVENT DCL 400000000  0210    ';
  ParSP2[11,  2].SPatt  := '0 0 0 0 0 0 0';

  ParSP2[11,  3].SData  := 'C                                     ';
  ParSP2[11,  3].SPatt  := '0 0 ';

  ParSP2[11,  4].SData  := 'D                                     ';
  ParSP2[11,  4].SPatt  := '0 0 ';

  ParSP2[11,  5].SData  := 'E                                     ';
  ParSP2[11,  5].SPatt  := '0 0 ';

  ParSP2[11,  6].SData  := 'F                                     ';
  ParSP2[11,  6].SPatt  := '0 0 ';

  ParSP2[11,  7].SData  := 'G                                     ';
  ParSP2[11,  7].SPatt  := '0 0 ';

  ParSP2[11,  8].SData  := 'H                                     ';
  ParSP2[11,  8].SPatt  := '0 0 ';

  ParSP2[11,  9].SData  := 'I                                     ';
  ParSP2[11,  9].SPatt  := '0 0 ';

  ParSP2[11, 10].SData  := 'J MTU 1 RUN RECORDING                 ';
  ParSP2[11, 10].SPatt  := '0 0 0 0 0';

  ParSP2[11, 11].SData  := 'K MTU 2 CLR INOPERABLE                ';
  ParSP2[11, 11].SPatt  := '0 0 0 0 0';

  //===========================================================
  PRM[ 1] := 'PRM 01 DATUM SPD 00 DM / H ERR 00 KYD ';
  PRM[ 2] := 'PRM 02 INITIATECRIT DATA LINK 200     ';
  PRM[ 3] := 'PRM 03 CLOSE CONTACT RANGE 0000 YD    ';
  PRM[ 4] := 'PRM 04 SCA ANGLE 210 DEG DIST 2.0 DM  ';
  PRM[ 5] := 'PRM 05 GPJ ANGLE 3 1 DEG HIGHT 3.3 FT ';
  PRM[ 6] := 'PRM 06 PARRALAX  CORRECTION 044.6 M   ';
  PRM[ 7] := 'PRM 07 TORP .1 RADIUS DOG BOX 0000 YD ';
  PRM[ 8] := 'PRM 08 TORP .2 EXPIRING TIME 00 S     ';
  PRM[ 9] := 'PRM 09 TORP .3 FIRE DISTANCE 0000 YD  ';
  PRM[10] := 'PRM 10 IFF GATE 03.25 - 03.25 DEG     ';
  PRM[11] := 'PRM 11 CORRELATED DECOR CRIT 2.0 DM   ';
  PRM[12] := 'PRM 12                                ';
  PRM[13] := 'PRM 13 TTG DROP                       ';

  WPData[0].Header   := 'WP 1';
  WPData[1].Header   := 'WP 2';
  WPData[2].Header   := 'WP 3';

  for a := 0 to 2 do begin
    WPData[a].CSysPage := 0;
    WPData[a].CPar     := 0;
    WPData[a].CLin     := 0;
  end;

  edPageHeader.Text := WPData[0].Header;

end;

procedure TfrmDisplay_Owa.FormDestroy(Sender: TObject);
var b: byte;
begin
  inherited;

  for b := C_Count_SP2-1 downto 1  do
    SetLength(ParSP2[b], 0 );

end;

procedure TfrmDisplay_Owa.Timer1Timer(Sender: TObject);
begin
  inherited;  // Cursor Blinker
  
end;

function TfrmDisplay_Owa.GetSysPageLine(const page: byte;
  const line: char): string;
var i : integer;
begin
  if (page = 1) then begin
    if line in ['A' .. 'K'] then begin
      i := ord(line) - 64;
      result := SP_1[i].GetFunction;
    end
  end
  else if (page = 2) then begin
    // baris judul paragraph
    if line in ['A' .. 'F', 'I', 'K'] then begin
      i := ord(line) - 64;
      result := SP_2[i];
    end
  end;
end;

function TfrmDisplay_Owa.SetSysPageLine(const page: byte;
  const line: char; const s: string): string;
var i : integer;
begin
  if (page = 1) then begin
    if line in ['A' .. 'K'] then begin
      i := ord(line) - 64;
      SP_1[i].SData := s;
    end
  end
  else if (page = 2) then begin
    // baris judul paragraph.  tidak bisa di set.
  end;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TfrmDisplay_Owa.Display_SystemPage(const spNum: byte);
var i: integer;
    s : string;
begin
  wipeActivePage;
  s :=  '   SP -';

  if spNum = 1 then begin
    WPData[CurrentPageIndex].CSysPage := 1;
    for i := 0 to C_Count_SP1-1 do begin
      ANDULines[i+1].Text := SP_1[i].GetFunction;
      s :=   '   SP '+  IntToStr(spNum);
    end;
  end
  else if spNum = 2 then begin
    WPData[CurrentPageIndex].CSysPage := 2;
    for i := 0 to C_Count_SP2-1 do
      ANDULines[i+1].Text := SP_2[i];
    s :=   '   SP '+  IntToStr(spNum);
  end;
  DisplayPageHeader(s);
end;

procedure TfrmDisplay_Owa.Erase_SystemPage(const spNum: byte);
var i: integer;
begin
  if spNum = 1 then begin
    for i := 0 to C_Count_SP1-1 do
      ANDULines[i+1].Text := '';

    WPData[CurrentPageIndex].CSysPage := 0;
  end
  else if spNum = 2 then begin
    for i := 0 to C_Count_SP2-1 do
      ANDULines[i+1].Text := '';
    WPData[CurrentPageIndex].CSysPage := 0;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TfrmDisplay_Owa.Display_Paragraph(const par: char);
var iPar, iLin : byte;
begin
  // system Page
  //display semua baris paragraph 2X di display
  if  not (par in C_PARSP2_Set) then exit;

  iPar := ord(par) - 64;

  WPData[CurrentPageIndex].CPar := iPar;
  for iLin := 0 to C_LineCount_ParSP2[iPar]-1 do
    ANDULines[iLin+1].Text := ParSP2[iPar, iLin].GetFunction;

end;

procedure TfrmDisplay_Owa.Update_Paragraph(const par, lin: char);
var iPar, iLin : integer;
begin
  if not (Par in C_PARSP2_Set) then  exit;
  // par A = 1
  iPar := Ord(Par) - 64;
  iLin := Ord(Lin) - 64;
  if not ((iLin > 0) and (iLin < C_LineCount_ParSP2[iPar])) then exit;

  ANDULines[iLin+1].Text := ParSP2[iPar, iLin].GetFunction;
end;

procedure TfrmDisplay_Owa.Erase_Paragraph(const par: char);
var iPar, iLin : byte;
begin
  if  not (par in C_PARSP2_Set) then exit;

  iPar := ord(par) - 64;

  WPData[CurrentPageIndex].CPar := 0;

  for iLin := 0 to C_LineCount_ParSP2[iPar]-1 do
    ANDULines[iLin+1].Text := '';

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
{function TfrmDisplay_Owa.GetParagraphLine(const par, line: char) : string;
var iPar, iLin : byte;
begin
  result := '';
  if par in  C_PARSP2_Set then begin
    iPar := ord(par) - 64;
    iLin := ord(Line) - 64;

    if iLin < C_LineCount_ParSP2[iPar] then
    result := ParSP2[iPar, iLin].GetFunction;
  end;
end;
}
procedure TfrmDisplay_Owa.DisplayParLine_DRL(const par, line: char);
// display line in DRL
var iPar, iLin : byte;
    s: string;
begin
  if par in  C_PARSP2_Set then begin
    iPar := ord(par) - 64;
    iLin := ord(Line) - 64;

    if iLin < C_LineCount_ParSP2[iPar] then begin
      s := ParSP2[iPar, iLin].GetFunction;

      SetDRLText(s);

      WPData[CurrentPageIndex].CLin := iLin;
    end
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TfrmDisplay_Owa.Get_SP1_00: string;
begin
  result :=  '' //1 Ship  F - 351                     ';
end;

function TfrmDisplay_Owa.Get_SP1_01: string;
var s: string;
    dt, gmt, loc : TDateTime;
    i: integer;
begin
 //        '0         1         2         3         4'
 //         '1234567890123456789012345678901234567890'
  result := 'A DTGR 010600 Z JUL 83 0700 A 01';
  oTDC := (iTdc as TTDC_Oswald);

  dt  := oTDC.OWA_DATA.Date_GMT;
  gmt := oTDC.OWA_DATA.Time_GMT;
  loc := oTDC.OWA_DATA.Time_Local;

  s := FormatDateTime('dd', dt);
  OverwriteString(result, s, 8);

  s := FormatDateTime('hhnn', gmt);
  OverwriteString(result, s, 10);

//  DecodeDate(dt, yy, mm, dd);

  s := FormatDateTime('mmm', dt);
  OverwriteString(result, s, 17);

  s := FormatDateTime('yy', dt);
  OverwriteString(result, s, 21);

  s := FormatDateTime('hhnn', loc);
  OverwriteString(result, s, 24);

  result[29] := oTDC.OWA_DATA.TimeZone;

  i := TimeZoneToDiff(oTDC.OWA_DATA.TimeZone);
  s := FormatFloat('00', i);
  OverwriteString(result, s, 31);
end;

function TfrmDisplay_Owa.Get_SP1_02: string;
var s: string;
begin
  result := 'B COURSE MAN 045 SPEED MAN 14.8     ';

  oTDC := (iTdc as TTDC_Oswald);

  if oTDC.OWA_DATA.CourseType = tstMan then
    s := FormatFloat('000', Round(oTDC.OWA_DATA.CourseMan))
  else begin
    OverwriteString(result, 'AUT', 10);
    s := FormatFloat('000', Round(iTDC.xSHIP.Heading));
  end;

  OverwriteString(result, s, 14);

  if oTDC.OWA_DATA.SpeedType = tstMan then
    s := FormatFloat('00.0', oTDC.OWA_DATA.SpeedManual)
  else begin
    OverwriteString(result, 'AUT', 24);
    s := FormatFloat('00.0', iTDC.xSHIP.Speed);

  end;

  OverwriteString(result, s, 28);
end;

function TfrmDisplay_Owa.Get_SP1_03: string;
var Wind : tVect2D;
    s: string;
    c: char;
    rel: double;
begin
 //        '0         1         2         3         4'
 //         '1234567890123456789012345678901234567890'
  result := 'C WIND 265 06 R 070 12 M/S          ';
  Wind := iTDc.GetTrueWind;

  s := FormatFloat('000', Round(Wind.Course));
  OverwriteString(result, s, 8);

  s := FormatFloat('00', Round(Wind.Speed));
  OverwriteString(result, s, 12);

  Wind := iTDc.GetRealtiveWind;

  degreeToRedGreen(Wind.Course, c, rel);
  result[15] := c;

  s := FormatFloat('000', Round(rel));
  OverwriteString(result, s, 17);

  s := FormatFloat('00', Round(Wind.Speed));
  OverwriteString(result, s, 21);
end;

function TfrmDisplay_Owa.Get_SP1_04: string;
begin
//  result := 'D DRIFT P 003 MAN 0250              ';
  result :=   SP_1[4].SData;
end;

function TfrmDisplay_Owa.Get_SP1_05: string;
begin
//  result := 'E GRIDLCK P 1735 MAN 0250           ';
  result :=   SP_1[5].SData;
end;

function TfrmDisplay_Owa.Get_SP1_06: string;
var s: string;
begin
  oTDC := (iTdc as TTDC_Oswald);

  result := 'F DEG S 53 - 03.5N 003 - 34.7E 0430 ';

  s := fmtDaisyCoord(oTDC.OWA_DATA.GetCoord_DEG);
  OverwriteString(result, s, 9);

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 32);
end;

function TfrmDisplay_Owa.Get_SP1_07: string;
var s: string;
begin
  result := 'G PADS  00 - 00.0N 000 - 00.0E 0432 ';

  oTDC := (iTdc as TTDC_Oswald);
  s := fmtDaisyCoord(oTDC.OWA_DATA.PADS);
  OverwriteString(result, s, 9);

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 32);
end;

function TfrmDisplay_Owa.Get_SP1_08: string;
var s: string;
begin
  result := 'H DOG   53 - 03.5N 003 - 34.7E 0530 ';

  oTDC := (iTdc as TTDC_Oswald);
  s := fmtDaisyCoord(oTDC.OWA_DATA.GetCoord_DOG);
  OverwriteString(result, s, 9);

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 32);
end;

function TfrmDisplay_Owa.Get_SP1_09: string;
var s: string;
begin
  result := 'I DLRP  53 - 10.4N 003 - 25.2E 0530 ';

  oTDC := (iTdc as TTDC_Oswald);
  s := fmtDaisyCoord(oTDC.OWA_DATA.DLRP);
  OverwriteString(result, s, 9);

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 32);
end;

function TfrmDisplay_Owa.Get_SP1_10: string;
var s: string;
begin
  result := 'J TGO   53 - 10.0N 003 - 25.0E 0531 ';

  oTDC := (iTdc as TTDC_Oswald);
  s := fmtDaisyCoord(oTDC.OWA_DATA.TGO);
  OverwriteString(result, s, 9);

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 32);
end;

function TfrmDisplay_Owa.Get_SP1_11: string;
var s: string;
begin
  result := 'K TNBLCK 2400 - 2577 0S 0024 0430   ';

  s :=  fmtDaisyLocalTime(iTdC.tdcData.LocalTime);
  OverwriteString(result, s, 30);
end;


function TfrmDisplay_Owa.exc_SP1_00(const ss: TStrings): integer;
begin
  result :=   100 ; // '1 Ship  F - 351                     ';
end;

function SearcShortMonth(const str: string): byte;
var f : boolean;
begin
  f := false;
  result := 1;
  while not f and (result <= 12) do begin
    f := CompareText(str, ShortMonthNames[result]) = 0;
    inc(result);
  end;

  if f then dec(result)
  else result := 0;
end;

function TfrmDisplay_Owa.exc_SP1_01(const ss: TStrings): integer;
var i: integer;
    dt, gmt, loc : TDateTime;
    s, s1, s2, s3 : string;

    yy, mm, dd : word;
    hh, nn, sc, msc: word;
    dtChange : boolean;
    cInt  : integer;
    cWord : word;

begin
//  result := 'A DTGR 010600 Z JUL 83 0700 A 01';
  result := 0;
  if ss.Count < 8 then exit;
  if ss[0] <> 'A' then exit;
  if ss[1] <> 'DTGR'  then exit;

  oTDC := (iTdc as TTDC_Oswald);
  dt  := oTDC.OWA_DATA.Date_GMT;
  gmt := oTDC.OWA_DATA.Time_GMT;
  loc := oTDC.OWA_DATA.Time_Local;

  DecodeDate(dt, yy, mm, dd);
  dtChange := false;
  if length(ss[2]) = 6 then begin
    s1 := Copy(ss[2], 1, 2);
    s2 := Copy(ss[2], 3, 4);

    s := UpperCase(FormatDateTime('dd', dt));
    // s1 = date
    if CompareText(s1, s) <> 0 then begin
     //update tanggal
      if ConvertToWord(s1, cWord) and (cWord >0) and (cWord < 32) then begin
        dtChange := true;
        dd := cWord;
      end;
    end;

    //update time  gmt
    s := FormatDateTime('hhnn', gmt);
    if CompareText(s2, s) <> 0 then begin
     DecodeTime(gmt, hh, nn, sc, msc);
     if ConvertToWord(Copy(s2, 1, 2), cWord) then hh := cWord;
     if ConvertToWord(Copy(s2, 3, 2), cWord) then nn := cWord;
       gmt := EncodeTime(hh, nn, sc, msc);
       oTDC.OWA_DATA.Time_GMT := gmt;
     end;

  end;

  s := UpperCase(FormatDateTime('mmm', dt));
  if CompareText(ss[4], s) <> 0 then begin
     cWord := SearcShortMonth(ss[4]);
     if cWord > 0 then begin
       mm := cWord;
       dtChange := true;
     end;
  end;

  s := UpperCase(FormatDateTime('yy', dt));
  if CompareText(ss[5], s) <> 0 then begin
     //update tahun
     if ConvertToWord(ss[5], cWord) then begin
       dtChange := true;
       if cWord < 50 then
         yy := 2000 + cWord
       else if cWord < 100 then
         yy := 1900 + cWord
       else
         yy := cWord;
     end;
  end;
  if dtChange then begin
    oTDC.OWA_DATA.Date_GMT :=   EncodeDate(yy, mm, dd);
  end;

  s := oTDC.OWA_DATA.TimeZone;
  if ss[7]  <> s then begin
     //update time Zone
     oTDC.OWA_DATA.TimeZone := ss[7][1];

  end;
  result := 101;         {
 //        '0         1         2         3         4'
 ////       '1234567890123456789012345678901234567890'
  result := 'A DTGR 010600 Z JUL 83 0700 A 01';
             0 1        2  3  4   5   6  7  8
}

end;

function TfrmDisplay_Owa.exc_SP1_02(const ss: TStrings): integer;
var w : Word;
    f : double;
begin
//  result := 'B COURSE MAN 045 SPEED MAN 14.8     ';
  result := 0;
  oTDC := (iTdc as TTDC_Oswald);
  if ss.Count < 7 then exit;

  if ss[0] <> 'B' then exit;

  if ss[1] <> 'COURSE'  then exit;
     if ss[2] = 'MAN' then begin
        oTDC.OWA_DATA.CourseType := tstMan;
        if ConvertToWord(ss[3], w) then begin
           oTDC.OWA_DATA.CourseMan := w;
        end;
     end
     else
     if ss[2] = 'AUT' then begin
        oTDC.OWA_DATA.SpeedType := tstAut;
     end;

  if ss[4] <> 'SPEED'  then exit;
     if ss[5] = 'MAN' then begin
        oTDC.OWA_DATA.SpeedType := tstMan;
        if ConvertToFloat(ss[6], f) then begin
           oTDC.OWA_DATA.SpeedManual := f;
        end;
     end
     else
     if ss[5] = 'AUT' then begin
        oTDC.OWA_DATA.SpeedType := tstAut;
     end;
  result := 102;

end;

function TfrmDisplay_Owa.exc_SP1_03(const ss: TStrings): integer;
var w : Word;
    Wind : tVect2D;
begin
//  result := 'C WIND 265 06 R 070 12 M/S          ';
  result := 0;
  if ss.Count < 8 then exit;

  if ss[0] <> 'C' then exit;
  wind := iTDc.GetRealtiveWind;

  if ConvertToWord(ss[5], w) and (W < 360)then
    wind.Course := w;

  if ConvertToWord(ss[6], w) then
    wind.Speed := w;

  iTDc.setRelatifWind(wind.Course, wind.Speed);

  result := 103;
end;

function TfrmDisplay_Owa.exc_SP1_04(const ss: TStrings): integer;
begin
//  result := 'D DRIFT P 003 MAN 0250              ';
  result := 0;

end;

function TfrmDisplay_Owa.exc_SP1_05(const ss: TStrings): integer;
begin
//  result := 'E GRIDLCK P 1735 MAN 0250           ';
  result := 0;


end;

function TfrmDisplay_Owa.exc_SP1_06(const ss: TStrings): integer;
var i : integer;
    s : string;
    deg : t2DPoint;
begin
//  result := 'F DEG S 53 - 03.5N 003 - 34.7E 0430 ';
  result := 0;
  if ss.Count < 10 then exit;
  if (ss[0] <> 'F') or (ss[1] <> 'DEG') then exit;

  s := '';
  for i := 3 to 7 do
    s := s + ss[i] + ' ';
  s := s + ss[8];

  if splitDaisyCoord(s, deg) then begin
    oTDC := (iTdc as TTDC_Oswald);
    oTDC.OWA_DATA.SetCoord_DEG(deg.X, deg.Y);
    result := 106;
  end;

end;

function TfrmDisplay_Owa.exc_SP1_07(const ss: TStrings): integer;
var i : integer;
    s : string;
    pads : t2DPoint;
begin
//  result := 'G PADS  00 - 00.0N 000 - 00.0E 0432 ';
  result := 0;

  if ss.Count < 9 then exit;
  if (ss[0] <> 'G') or (ss[1] <> 'PADS')  then exit;

  s := '';
  for i := 2 to 6 do
    s := s + ss[i] + ' ';
  s := s + ss[7];

  if splitDaisyCoord(s, pads) then begin
    oTDC := (iTdc as TTDC_Oswald);
    oTDC.OWA_DATA.PADS := pads;
    result := 107;
  end;
end;

function TfrmDisplay_Owa.exc_SP1_08(const ss: TStrings): integer;

var i : integer;
    s : string;
    dog : t2DPoint;
begin
//  result := 'H DOG   53 - 03.5N 003 - 34.7E 0530 ';
  result := 0;
  if ss.Count < 9 then exit;
  if (ss[0] <> 'H') or (ss[1] <> 'DOG') then exit;

  s := '';
  for i := 2 to 6 do
    s := s + ss[i] + ' ';
  s := s + ss[7];

  if splitDaisyCoord(s, dog) then begin
    oTDC := (iTdc as TTDC_Oswald);
    oTDC.OWA_DATA.SetCoord_DOG(dog.X, dog.Y);
    result := 108;
  end;

end;

function TfrmDisplay_Owa.exc_SP1_09(const ss: TStrings): integer;
var i : integer;
    s : string;
    dlrp : t2DPoint;
begin
//  result := 'I DLRP  53 - 10.4N 003 - 25.2E 0530 ';
  result := 0;

  if ss.Count < 9 then exit;
  if (ss[0] <> 'I') or (ss[1] <> 'DLRP')  then exit;

  s := '';
  for i := 2 to 6 do
    s := s + ss[i] + ' ';
  s := s + ss[7];

  if splitDaisyCoord(s, dlrp) then begin
    oTDC := (iTdc as TTDC_Oswald);
    oTDC.OWA_DATA.DLRP := dlrp;
    result := 109;
  end;
end;

function TfrmDisplay_Owa.exc_SP1_10(const ss: TStrings): integer;
var i : integer;
    s : string;
    tgo : t2DPoint;
begin
//  result := 'J TGO   53 - 10.0N 003 - 25.0E 0531 ';
  result := 0;

  if ss.Count < 9 then exit;
  if (ss[0] <> 'J') or (ss[1] <> 'TGO')  then exit;

  s := '';
  for i := 2 to 6 do
    s := s + ss[i] + ' ';
  s := s + ss[7];

  if splitDaisyCoord(s, tgo) then begin
    oTDC := (iTdc as TTDC_Oswald);
    oTDC.OWA_DATA.TGO := tgo;
    result := 110;
  end;
end;

function TfrmDisplay_Owa.exc_SP1_11(const ss: TStrings): integer;
var
  ssid , ssmid : string;
  b1, b2 : byte;
  i : integer;
begin
//  result := 'K TNBLCK 2400 - 2577 0S 0024 0430   ';
  result := 0;
  if ss.Count < 5 then exit;
    oTDC := (iTdc as TTDC_Oswald);

    ssid := Copy(ss[2], 1, 2);
    b1 := OctToInt(ssid);

    ssmid := Copy(ss[4], 1, 2);
    b2 := OctToInt(ssmid);
    oTDC.ChangeShipTrackID(b1, b2);

  result := 111;

end;

function TfrmDisplay_Owa.exec_SP1_Func(const line: char; const ss: TStrings): integer;
var i : integer;
begin
    if line in ['A' .. 'K'] then begin
      i := ord(line) - 64;         // A ~  1
      result := SP_1[i].ExcFunction(ss);
    end
end;


function TfrmDisplay_Owa.exec_SP2_Func(const aPar, aLine: char; const sCmd: string) :integer;
var iPar, iLine : integer;
begin
  result := 0;
  if not (aPar in C_PARSP2_Set) then  exit;
  // par A = 1
  iPar := Ord(aPar) - 64;
  iLine := Ord(aLine) - 64;
  if not ((iLine > 0) and (iLine < C_LineCount_ParSP2[iPar])) then exit;

  result :=  ParSP2[iPar , iLine].ExcFunction(sCmd);

end;

procedure TfrmDisplay_Owa.SelectPage(pgIndex: byte);
begin
  if pgIndex = CurrentPageIndex then exit;

  if (pgIndex >= 0) and (pgIndex < 3) then
    edPageHeader.Text := WPData[pgIndex].Header;

  inherited;
end;

procedure TfrmDisplay_Owa.DisplayPageHeader(const str: string);
begin

  WPData[CurrentPageIndex].Header :=
   'WP '+ IntToStr(CurrentPageIndex + 1) + '  ' +  str;

  edPageHeader.Text := WPData[CurrentPageIndex].Header;
end;


function TfrmDisplay_Owa.tdc_CreateSpecialPoint(const x, y: double): integer;
var aRec: TRecOrderXY;
begin
  result := 1;
  oTDC := (iTdc as TTDC_Oswald);

 // tdPointGen, tdPointEW, tdPointAir, tdPointASW
  aRec.OrderID    := OrdID_init_point;
  aRec.OrderType  := byte(tdPointGen);
  aRec.X := X;
  aRec.Y := Y;

  oTDC.SetInitPoint(aRec, oTDC.HaveToSend );

end;



{  valid_func[0] := IsValid_Mask_UnEditable;
  valid_func[1] := IsValid_Mask_String  ;
  valid_func[2] := IsValid_Mask_Integer;
  valid_func[3] := IsValid_Mask_Word;
  valid_func[4] := IsValid_Mask_double;
}
procedure TfrmDisplay_Owa.SetUpdateHarpoonEngaged(sI, sJ, sK: string);
begin

  SetDRLText('active par'+ IntToStr(WPData[CurrentPageIndex].CPar));
  if (WPData[CurrentPageIndex].CPar = 1) then begin   // display par A
   UpdateDataHarpoonEngage(nil);
  end;
end;
// ============================================================================
// SP 2
function TfrmDisplay_Owa.Get_SP2_A_I: string;
var
   s : string;
begin                       //1234567
//  ParSP2[ 1,  9].SData  := 'I SSM .....                          ';
  if not Assigned(iTDC) then exit;
  oTDC := iTDC as TTDC_Oswald;
  if not oTDc.harpoonData.active then exit;
  if not Assigned(oTDc.harpoonData.engTrack) then exit;

  result := ParSP2[ 1,  9].SData;
  s := oTDc.harpoonData.engTrack.StringTrackNumber;

  OverwriteString(result, s, 7);

end;

function TfrmDisplay_Owa.exc_SP2_A_I(const ss: TStrings): integer;
begin
   // set engage harpoon. lewat tomol engage aja.

end;

function TfrmDisplay_Owa.Get_SP2_A_J: string;
var s: string;

begin                       // 123456789012345678901234567890
//  ParSP2[ 1,  10].SData  := 'J RBL AB REC L SEL L ..... SB ..       ';
  result := ParSP2[ 1,  10].SData;
  // RBL
  // AB = ATTACK BOUNDARY / SA  = SEARCH AREA
  // REC = RECOMENDED
  oTDC := iTDC as TTDC_Oswald;
  with oTDc.harpoonData do begin
    s := C_LM[byte(LaunchMode)];
    OverwriteString(result, s, 3 );

    s := C_SM[byte(SearchMode)];
    OverwriteString(result, s, 7 );

    s := C_SZ[byte(RecSearchArea)];
    OverwriteString(result, s, 14 );

    s := C_SZ[byte(SearchArea)];
    OverwriteString(result, s, 20 );

    s := C_SZ[byte(LauncherTube)];
    OverwriteString(result, s, 28 );
  end;
end;

function TfrmDisplay_Owa.exc_SP2_A_J(const ss: TStrings): integer;
var b: byte;
    s: string;
begin
// 0 1   2  3   4 5   6 7     8  9  10
//'J RBL AB REC L SEL L ..... SB ..
{ SEL : setting yg dipilih di harpoon panel
  REC : setting dari HDC, dikirim ke harpoon panel.
}
//   Memo1.Lines.Clear;
//   Memo1.Lines.AddStrings(ss);
   if ss.Count < 10 then exit;

   oTDC := iTDC as TTDC_Oswald;
   with oTDc.harpoonData do begin

     s := C_LM[byte(LaunchMode)];
     // .. .. ..  .. .. ..  .. .. ..  .. .. ..  ..
     if ss[1] ='RBL' then begin
       LaunchMode := lmRBL;

       if ss[4] = C_SZ[byte(szSmall)] then
         RecSearchArea := szSmall;

       if ss[4] = C_SZ[byte(szMedium)] then
         RecSearchArea := szMedium;

       if ss[4] = C_SZ[byte(szLarge)] then
         RecSearchArea := szLarge;
       oTDC.SendHarpoonPanelState(OrdHpn_RecSearchArea, byte(SearchArea) );
     end
     else if ss[1] = 'BOL' then begin
       LaunchMode := lmBOL;
       //send hpUdate
       oTDC.SendHarpoonPanelState(OrdHpn_LaunchMode, byte(lmBOL) );
       // min bol dari mana?? :((

     end;

//    s := C_SM[byte(SearchMode)];
    if ss[2] = C_SM[byte(hsmAttackBoundary)] then
      SearchMode  := hsmAttackBoundary;

    if ss[2] = C_SM[byte(hsmSearchArea)] then
      SearchMode := hsmSearchArea;

    oTDC.SendHarpoonPanelState(OrdHpn_SearchMode, byte(SearchMode) );

//    s := C_SZ[byte(LauncherTube)];
    if ss[8] = C_SZ[byte(tdPort)] then
       LauncherTube := tdPort;
    if ss[8] = C_SZ[byte(tdStarBoard)] then
       LauncherTube := tdStarBoard;
    oTDC.SendHarpoonPanelState(OrdHpn_LauncherTube, byte(LauncherTube) );

  end;
  result := 1;
end;


function TfrmDisplay_Owa.Get_SP2_A_K: string;
var s: string;
begin
//                             123456789012345678901234567890
//  ParSP2[ 1,  11].SData  := 'K COR TGTMV WND OOO 00 TMP .....     ';
  result := ParSP2[ 1,  11].SData;
  oTDC := (iTdc as TTDC_Oswald);

  s := FormatFloat('000', Round(oTDC.harpoonCorr.windCourse));
  OverwriteString(result, s, 17);

  s := FormatFloat('000', Round(oTDC.harpoonCorr.windSpeed));
  OverwriteString(result, s, 21);

  s := FormatFloat('000', Round(oTDC.harpoonCorr.tmp));
  OverwriteString(result, s, 28);
end;

function TfrmDisplay_Owa.exc_SP2_A_K(const ss: TStrings): integer;
var d: double;
begin
//   1 2   3     4   5   6  7   8
//  'K COR TGTMV WND OOO 00 TMP .....     ';

   oTDC := iTDC as TTDC_Oswald;
   if ss.Count < 8 then exit;
   //d :=
   if ConvertToFloat(ss[5], d ) then begin
     if (d >= 0.0) and (d <= 360.0 ) then
      oTDC.harpoonCorr.windCourse := d
   end;

   if ConvertToFloat(ss[6], d ) then begin
     if (d >= 0.0) and (d <= 100.0 ) then
      oTDC.harpoonCorr.windSpeed := d
   end;

   if ConvertToFloat(ss[8], d ) then begin
     if (d >= 0.0) and (d <= 100.0 ) then
      oTDC.harpoonCorr.tmp := d
   end;
end;

procedure TfrmDisplay_Owa.UpdateDataHarpoonEngage(sender: TObject);
var oTDC : TTDC_Oswald;
   s : string;
begin
  if not Assigned(iTDC) then exit;
  if (WPData[CurrentPageIndex].CPar <> 1) then exit;   // display par A
  oTDC := iTDC as TTDC_Oswald;
  if not oTDc.harpoonData.active then exit;
  if not Assigned(oTDc.harpoonData.engTrack) then exit;

  Update_Paragraph('A', 'I');
  Update_Paragraph('A', 'J');
  Update_Paragraph('A', 'K');
end;



end.
