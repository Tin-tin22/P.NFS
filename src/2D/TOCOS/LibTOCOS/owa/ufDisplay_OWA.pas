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
   (6, 12 , 6 , 12, 6, 11, 0, 0, 11, 0, 12);

   C_PARSP2_Set = ['A', 'B', 'C', 'D', 'E', 'F', 'I', 'K'];

type
  TStringFunction = function: string of object;

  TfrmDisplay_Owa = class(TfrmANDUDisplay)
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected

    function Get_SP1_1: string;
    function Get_SP1_2: string;
    function Get_SP1_3: string;
    function Get_SP1_4: string;
    function Get_SP1_5: string;
    function Get_SP1_6: string;
    function Get_SP1_7: string;
    function Get_SP1_8: string;
    function Get_SP1_9: string;
    function Get_SP1_10: string;
    function Get_SP1_11: string;
    function Get_SP1_12: string;

//    function Set_SP1_3(cmd: string);
  public
    { Public declarations }
    iTDC : TGenericTDCInterface;

    CurrentSP: byte;

    SP     : array [1 .. 2] of array of string;
    ParSP2 : array [1 .. 11] of array of string;
    PRM    : array [1 .. 13] of string;

    SP1_Func : array [1 .. 12] of TStringFunction;

    procedure Display_Page_SP1;
    procedure Display_Page_SP2;

    procedure Display_Paragraph(const par: char);

    function GetSysPageLine(const page: byte; const line: char): string;
    function GetParagraphLine(const par, line: char) : string;



  end;

var
  frmDisplay_Owa: TfrmDisplay_Owa;

implementation

uses
  uStringFunction;

{$R *.dfm}

procedure TfrmDisplay_Owa.FormCreate(Sender: TObject);
var b : byte;
begin
  inherited;
  SetNumOfPage(3); // Work page 1, 2, 3
  CurrentPageIndex := 0;

  SetLength(SP[1], 12);
  SetLength(SP[2], 12);

  //           '12345678901234567890123456789012'
  SP[1,  0] := '1 Ship  F - 351                     ';
  SP[1,  1] := 'A DTGR 010600 Z 83 0700 A 01        ';
  SP[1,  2] := 'B COURSE MAN 045 SPEED MAN 14.8     ';
  SP[1,  3] := 'C WIND 265 06 R 070 12 M/S          ';
  SP[1,  4] := 'D DRIFT P 003 MAN 0250              ';
  SP[1,  5] := 'E GRIDLCK P 1735 MAN 0250           ';
  SP[1,  6] := 'F DEG S 53 - 03.5N 003 - 34.7E 0430 ';
  SP[1,  7] := 'G PADS  00 - 00.0N 000 - 00.0E 0432 ';
  SP[1,  8] := 'H DOG   53 - 03.5N 003 - 34.7E 0530 ';
  SP[1,  9] := 'I DLRP  53 - 10.4N 003 - 25.2E 0530 ';
  SP[1, 10] := 'J TGO   53 - 10.0N 003 - 25.0E 0531 ';
  SP[1, 11] := 'K TNBLCK 2400 - 2577 0S 0024 0430   ';

  SP1_Func [ 1]:= Get_SP1_1  ;
  SP1_Func [ 2]:= Get_SP1_2  ;
  SP1_Func [ 3]:= Get_SP1_3  ;
  SP1_Func [ 4]:= Get_SP1_4  ;
  SP1_Func [ 5]:= Get_SP1_5  ;
  SP1_Func [ 6]:= Get_SP1_6  ;
  SP1_Func [ 7]:= Get_SP1_7  ;
  SP1_Func [ 8]:= Get_SP1_8  ;
  SP1_Func [ 9]:= Get_SP1_9  ;
  SP1_Func [10]:= Get_SP1_10 ;
  SP1_Func [11]:= Get_SP1_11 ;
  SP1_Func [12]:= Get_SP1_12 ;



  SP[2,  0] := '2           '   ;
  SP[2,  1] := 'A AAW / SW  '   ;
  SP[2,  2] := 'B ASW       '   ;
  SP[2,  3] := 'C EW        '   ;
  SP[2,  4] := 'D TACMAN    '   ;
  SP[2,  5] := 'E FAAW      '   ;
  SP[2,  6] := 'F LINK I    '   ;
  SP[2,  7] := '            '   ;
  SP[2,  8] := '            '   ;
  SP[2,  9] := 'I TACT REFF '   ;
  SP[2, 10] := '            '   ;
  SP[2, 11] := 'K SYMON     '   ;

  for b := 1 to C_Count_SP2-1 do
    SetLength(ParSP2[b], C_LineCount_ParSP2[b] );

// ----------------------------------------------------------
               ////  '1234567890123456789012345678901234567890'
  ParSP2[ 1,  0] := 'A AAW / SW                            ';
  ParSP2[ 1,  1] := 'A VITAL AREA ..... RADIUS ... WARFARE ';
  ParSP2[ 1,  2] := 'B .                                   ';
  ParSP2[ 1,  3] := 'C FC 1   A1234 EU 275 450 12T +       ';
  ParSP2[ 1,  4] := 'D FC 2                                ';
  ParSP2[ 1,  5] := 'E FC 3                                ';

  // ----------------------------------------------------------
  ParSP2[ 2,  0] := 'B ASW                                 ';
  ParSP2[ 2,  1] := 'A TORT                                ';
  ParSP2[ 2,  2] := 'B PORT 44-44-44    STBD 44-44-44      ';
  ParSP2[ 2,  3] := 'C ADVICE MK --     URGENT ------      ';
  ParSP2[ 2,  4] := 'D SWITCH ISD - FLOOR -                ';
  ParSP2[ 2,  5] := 'E LAUNCHE   COURSE ---                ';
  ParSP2[ 2,  6] := 'F ---          COURSE --- SEC         ';
  ParSP2[ 2,  7] := 'G                                     ';
  ParSP2[ 2,  8] := 'H                                     ';
  ParSP2[ 2,  9] := 'I                                     ';
  ParSP2[ 2, 10] := 'J VDS  CABLE  000 FT  DEPTH 000  FT   ';
  ParSP2[ 2, 11] := 'K UWSV 4900 FT/SEC WATER DEPTH 0000 M ';
  // ----------------------------------------------------------

  ParSP2[ 3,  0] := 'C EW                                  ';
  ParSP2[ 3,  1] := 'A B3456   ESM   280   B S 1257  EU  F ';
  ParSP2[ 3,  2] := 'B PUFFBALL +3 BEARCHARLIE             ';
  ParSP2[ 3,  3] := 'C PURPOSE  ..  SCANTY  .. ARP         ';
  ParSP2[ 3,  4] := 'D FA   .  FREQ   .....                ';
  ParSP2[ 3,  5] := 'E PJ   .  PRF    .....    PW .....    ';

  // ----------------------------------------------------------

  ParSP2[ 4,  0] := 'D TACMAN                              ';
  ParSP2[ 4,  1] := 'A .... TYP ..... SPD ....  .....      ';
  ParSP2[ 4,  2] := 'B END ... MPNT 00 T00.0 VAR 00E       ';
  ParSP2[ 4,  3] := 'C .... ..... BRG ... RNG ....         ';
  ParSP2[ 4,  4] := 'D PROCEED  ....  RNG .... TIME ....   ';
  ParSP2[ 4,  5] := 'E CONTROLLING UNIT .....              ';
  ParSP2[ 4,  6] := 'F .... TYP ... SPD .... .....         ';
  ParSP2[ 4,  7] := 'G END ... MPNT 000 T 00.0 VAR 00E     ';
  ParSP2[ 4,  8] := 'H ..... ... .. BRG ... RGN ...        ';
  ParSP2[ 4,  9] := 'I PROCEED ... RNG .... TIME ....      ';
  ParSP2[ 4, 10] := 'J ..... TYP ..... SPD .... .....      ';
  ParSP2[ 4, 11] := 'K S 0010 SEA . FC 000 FH 400 FT       ';

  // ----------------------------------------------------------

  ParSP2[ 5,  0] := 'E FAAW                                ';
  ParSP2[ 5,  1] := 'A UNIT     WPN    STAT   IRGT    CU   ';
  ParSP2[ 5,  2] := 'B A 1223   REAR     +    .....  ....  ';
  ParSP2[ 5,  3] := 'C A 1224   FRONT    +    .....  ....  ';
  ParSP2[ 5,  4] := 'D S 0015   SAMSR    +    .....  ....  ';
  ParSP2[ 5,  5] := 'E D 0012   SAMSR    +    .....  ....  ';

  // ----------------------------------------------------------
  ParSP2[ 6,  0] := 'F LINK I                              ';
  ParSP2[ 6,  1] := 'A FILTER AIR           NON AIR        ';
  ParSP2[ 6,  2] := 'B TX           TX OS   AMPOS A  SU  . ';
  ParSP2[ 6,  3] := 'C ..........   ....     ..... ....    ';
  ParSP2[ 6,  4] := 'D ..........   ....     ..... ....    ';
  ParSP2[ 6,  5] := 'E ..........   ....     ..... ....    ';
  ParSP2[ 6,  6] := 'F ..........   ....     ..... ....    ';
  ParSP2[ 6,  7] := 'G ..........   ....     ..... ....    ';
  ParSP2[ 6,  8] := 'H ..........   ....     ..... ....    ';
  ParSP2[ 6,  9] := 'I ..........   ....     ..... ....    ';
  ParSP2[ 6, 10] := 'J ..........   ....     ..... ....    ';

  // ----------------------------------------------------------

  ParSP2[ 9,  0] := 'I TACT REFF                           ';
  ParSP2[ 9,  1] := 'A FOC P5130    1513     A4107 ....    ';
  ParSP2[ 9,  2] := 'B FOC .....    ....     ..... ....    ';
  ParSP2[ 9,  3] := 'C FOC .....    ....     ..... ....    ';
  ParSP2[ 9,  4] := 'D CIR A2100 R+   S 2517 T.  ..... T-  ';
  ParSP2[ 9,  5] := 'E CIR ..... T-   . .... T-  ..... T-  ';
  ParSP2[ 9,  6] := 'F FIG A2101 T+   U 1737 T.  ..... T-  ';
  ParSP2[ 9,  7] := 'G FIG ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9,  8] := 'H FIG ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9,  9] := 'I BTR ..... T.   . .... T-  ..... T-  ';
  ParSP2[ 9, 10] := 'J BTR P3113 T-   . .... T-  U6316 T-  ';
  // ----------------------------------------------------------

  ParSP2[11,  0] := 'K SYMON                               ';
  ParSP2[11,  1] := 'A DA 276 LINK 10  PRESENT  ACT        ';
  ParSP2[11,  2] := 'B DA 276 EVENT DCL 400000000  0210    ';
  ParSP2[11,  3] := 'C                                     ';
  ParSP2[11,  4] := 'D                                     ';
  ParSP2[11,  5] := 'E                                     ';
  ParSP2[11,  6] := 'F                                     ';
  ParSP2[11,  7] := 'G                                     ';
  ParSP2[11,  8] := 'H                                     ';
  ParSP2[11,  9] := 'I                                     ';
  ParSP2[11, 10] := 'J MTU 1 RUN RECORDING                 ';
  ParSP2[11, 11] := 'K MTU 2 CLR INOPERABLE                ';

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

end;

procedure TfrmDisplay_Owa.FormDestroy(Sender: TObject);
var b: byte;
begin
  inherited;

   for b := C_Count_SP2-1 downto 1  do
    SetLength(ParSP2[b], 0 );

  SetLength(SP[2], 0);
  SetLength(SP[1], 0);
end;


procedure TfrmDisplay_Owa.Display_Page_SP1;
var i: integer;
begin
  WipeActivePage;

  for i := 0 to C_Count_SP1-1 do begin
    SP[1][i] := SP1_Func[i+1];
    ANDULines[i+1].Text := SP[1][i];
  end;
end;

procedure TfrmDisplay_Owa.Display_Page_SP2;
var i, j: integer;
begin
  wipeActivePage;

  for i := 0 to C_Count_SP2-1 do
    ANDULines[i+1].Text := InsertSpace( SP[2][i]);
end;

procedure TfrmDisplay_Owa.Display_Paragraph(const par: char);
var iPar, iLin : byte;
begin
  if  not (par in C_PARSP2_Set) then exit;
  WipeActivePage;

  iPar := ord(par) - 64;

  for iLin := 0 to C_LineCount_ParSP2[iPar]-1 do
    ANDULines[iLin+1].Text := InsertSpace(ParSP2[iPar, iLin]);

end;

function TfrmDisplay_Owa.GetSysPageLine(const page: byte;
  const line: char): string;
var i : integer;
begin
  if (page = 1) then begin
    if line in ['A' .. 'K'] then begin
      i := ord(line) - 64;
      result := SP[1][i];

    end
  end
  else if (page = 2) then begin
    // baris judul paragraph
    if line in ['A' .. 'F', 'I', 'K'] then begin
      i := ord(line) - 64;
      result := SP[2][i];
    end
  end;
end;

function TfrmDisplay_Owa.GetParagraphLine(const par, line: char) : string;
var iPar, iLin : byte;
begin
  result := '';
  if par in  C_PARSP2_Set then begin
    iPar := ord(par) - 64;
    iLin := ord(Line) - 64;

    if iLin < C_LineCount_ParSP2[iPar] then
    result := ParSP2[iPar, iLin];

  end;
end;

function TfrmDisplay_Owa.Get_SP1_1: string;
begin
  result :=  '1 Ship  F - 351                     ';
end;


function TfrmDisplay_Owa.Get_SP1_2: string;
begin
  result := 'A DTGR 010600 Z 83 0700 A 01        ';
end;

function TfrmDisplay_Owa.Get_SP1_3: string;
var s: string;
begin  //  '0         1         2         3         4'
      ////  '1234567890123456789012345678901234567890'
  result := 'B COURSE MAN 045 SPEED MAN 14.8     ';

  s := FormatFloat('000', Round(iTDC.xSHIP.Heading));
  OverwriteString(result, s, 14);

  s := FormatFloat('00.0', iTDC.xSHIP.Speed);
  OverwriteString(result, s, 28);
end;

{function TfrmDisplay_Owa.Set_SP1_3(cmd: string);
begin

end;
}
function TfrmDisplay_Owa.Get_SP1_4: string;
begin
  result := 'C WIND 265 06 R 070 12 M/S          ';
end;

function TfrmDisplay_Owa.Get_SP1_5: string;
begin
  result := 'D DRIFT P 003 MAN 0250              ';

end;

function TfrmDisplay_Owa.Get_SP1_6: string;
begin
  result := 'E GRIDLCK P 1735 MAN 0250           ';
end;

function TfrmDisplay_Owa.Get_SP1_7: string;
begin
  result := 'F DEG S 53 - 03.5N 003 - 34.7E 0430 ';

end;

function TfrmDisplay_Owa.Get_SP1_8: string;
begin
  result := 'G PADS  00 - 00.0N 000 - 00.0E 0432 ';
end;

function TfrmDisplay_Owa.Get_SP1_9: string;
begin
  result := 'H DOG   53 - 03.5N 003 - 34.7E 0530 ';
end;

function TfrmDisplay_Owa.Get_SP1_10: string;
begin
  result := 'I DLRP  53 - 10.4N 003 - 25.2E 0530 ';

end;

function TfrmDisplay_Owa.Get_SP1_11: string;
begin
  result := 'J TGO   53 - 10.0N 003 - 25.0E 0531 ';

end;

function TfrmDisplay_Owa.Get_SP1_12: string;
begin
  result := 'K TNBLCK 2400 - 2577 0S 0024 0430   ';
end;

end.
