unit ufInjectionKeyboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrDesign,
  ExtCtrls, ufQEK, uLibTdcClass;

type
  tPageType = (ptGeneral, ptFreeForm, ptLinkTransmit, ptLinkReceive);

  TfrmInjectionKeyBoard = class(TfrmQEK)
    GroupBox1: TGroupBox;
    btn_RB: TVrBitmapButton;
    Label2: TLabel;
    btn_plus: TVrBitmapButton;
    Label3: TLabel;
    btn_minus: TVrBitmapButton;
    Label4: TLabel;
    btn_7: TVrBitmapButton;
    Label5: TLabel;
    btn_8: TVrBitmapButton;
    Label6: TLabel;
    btn_9: TVrBitmapButton;
    Label7: TLabel;
    btn_4: TVrBitmapButton;
    Label8: TLabel;
    btn_5: TVrBitmapButton;
    Label9: TLabel;
    btn_6: TVrBitmapButton;
    Label10: TLabel;
    btn_1: TVrBitmapButton;
    Label11: TLabel;
    btn_2: TVrBitmapButton;
    Label12: TLabel;
    btn_3: TVrBitmapButton;
    Label13: TLabel;
    btn_0: TVrBitmapButton;
    Label14: TLabel;
    btn_dot: TVrBitmapButton;
    Label16: TLabel;
    GroupBox2: TGroupBox;
    VrBitmapButton15: TVrBitmapButton;
    Label15: TLabel;
    btn_B: TVrBitmapButton;
    Label19: TLabel;
    Label20: TLabel;
    btn_A: TVrBitmapButton;
    Label22: TLabel;
    btn_C: TVrBitmapButton;
    Label23: TLabel;
    btn_D: TVrBitmapButton;
    Label24: TLabel;
    btn_E: TVrBitmapButton;
    Label25: TLabel;
    btn_F: TVrBitmapButton;
    Label26: TLabel;
    btn_G: TVrBitmapButton;
    Label27: TLabel;
    VrBitmapButton17: TVrBitmapButton;
    btn_4space: TVrBitmapButton;
    Label18: TLabel;
    btn_H: TVrBitmapButton;
    btn_I: TVrBitmapButton;
    btn_J: TVrBitmapButton;
    btn_K: TVrBitmapButton;
    btn_L: TVrBitmapButton;
    btn_M: TVrBitmapButton;
    btn_N: TVrBitmapButton;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    btn_O: TVrBitmapButton;
    btn_P: TVrBitmapButton;
    btn_Q: TVrBitmapButton;
    btn_R: TVrBitmapButton;
    btn_S: TVrBitmapButton;
    btn_T: TVrBitmapButton;
    btn_U: TVrBitmapButton;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    btn_V: TVrBitmapButton;
    btn_W: TVrBitmapButton;
    btn_X: TVrBitmapButton;
    btn_Y: TVrBitmapButton;
    btn_Z: TVrBitmapButton;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    btn_BackSpace: TVrBitmapButton;
    btn_EraseSpace: TVrBitmapButton;
    btn_Space: TVrBitmapButton;
    lbl_BackSpace: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    lbl_Space: TLabel;
    btn_Execute: TVrBitmapButton;
    lbl_Execute: TLabel;
    lblText: TLabel;
    Panel1: TPanel;
    AnduTDC01: TEdit;
    AnduTDC02: TEdit;
    AnduTDC03: TEdit;
    AnduTDC04: TEdit;
    AnduTDC05: TEdit;
    AnduTDC06: TEdit;
    AnduTDC07: TEdit;
    AnduTDC08: TEdit;
    AnduTDC09: TEdit;
    AnduTDC10: TEdit;
    AnduTDC11: TEdit;
    AnduTDC12: TEdit;
    AnduTDC13: TEdit;
    AnduTDC14: TEdit;
    AnduTDC15: TEdit;
    AnduTDC16: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit57: TEdit;
    Edit58: TEdit;
    Edit59: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Edit62: TEdit;
    Edit63: TEdit;
    Edit64: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    Edit67: TEdit;
    Edit68: TEdit;
    Edit69: TEdit;
    Panel2: TPanel;
    procedure btn_BackSpaceClick(Sender: TObject);
    procedure btn_4spaceClick(Sender: TObject);
    procedure btn_ExecuteClick(Sender: TObject);
    procedure btn_EraseSpaceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_SpaceClick(Sender: TObject);
    procedure AnduTDC16KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  protected

  public
    { Public declarations }
    //ANDU Var
    baris:integer;
    Mnemonic : string;
    SS, A8,S9,U4,D4,F4,RP2,C8 : integer;  // SLL var
    LocTime : TDateTime; // local time
    TrackNumber,idSas,idTambahan,idSumber,HaluSas,HaluRef,SpeedSas,SpeedRef,
    TinggiSas,FCnumber,PrivatCode:integer; //SCR var
    TrackNumberSusie,DalamSas,ErrDatum,Baringan:integer;
    RepPulsa,LebarPulsa:integer;
    SS2,Mv,Td,Tf,Tw,TrackNumberCAR,HaluDropPoint,jarakSas,Baringan2,
    TimeTor,JarakPhp,StraightCourse,StraightRun:integer;   // parv var

    CoursePenjuru,SpeedPenjuru,BaringanStation,JarakStation,TrackNumberPenjuru,CourseStationBaru,SpeedStation:integer;
    BaringanCpa,JarakCpa:integer;    // parc var
    lintang1,lintang2,bujur1,bujur2:integer;  // QGC var
    BaringanOs,JarakRbOs,SumbuX,SumbuY:integer;  //QSG var
    ArahAnginSejati,KecAnginSejati,ArahAnginRelatif,KecAnginRelatif,ArahArus,KecArus:integer; //QTW var
    // array  data..........
    SLLAlok : array [1..9] of string;
    SCRAtasAir :array [1..11] of string;
    SCRBawahAir:array [1..9] of string;
    SCRDatum :array [1..9] of string;
    SCREsm :array [1..9] of string;
    SCRFix:array [1..9] of string;
    SCRRef:array [1..99] of string;
    PARV1 :array [1..6] of string;
    PARV2 :array [1..9] of string;
    PART1 :array [1..6] of string;
    PART2 :array [1..8] of string;
    PARS1 :array [1..7] of string;
    PARS2 :array [1..6] of string;
    PARC1 :array [1..5] of string;
    PARC2 :array [1..6] of string;
    QGC:array [1..9] of string;
    QSG:array [1..8] of string;
    QTW:array [1..9] of string;
    COS:array [1..5] of string;


    procedure btn_AlphaNumClick(Sender: TObject);
    procedure Action_Mnemonic(const value:String);
    procedure Action_SLL;
    procedure Action_SCRAtasAir;
    procedure Action_SCRBawahAir;
    procedure Action_SCRDatum;
    procedure Action_SCREsm;
    procedure Action_SCRFix;
    procedure Action_SCRRef;
    procedure Action_Parv;
    procedure Action_Part;
    procedure Action_Pars;
    procedure Action_Parc;
    procedure Action_Qgc;
    procedure Action_Qsg;
    procedure Action_Qtw;
    procedure Action_Cos;
    procedure waktulokal;
    function MakeStr(const Args: array of const): string;

  protected
//     SPageG, SPageF, SPageLT, SPageLR: TStrings;
     SPage: array[tPageType] of TStrings;

     procedure Do_NonTrack_Action(const ss: TStrings);
     procedure Do_Track_Action(const ss: TStrings);

     procedure SavePage(var ss: TStrings);
     procedure ReloadPage(const ss: TStrings);
     procedure WipePage;
     procedure Do__SelectPage(pt: tPageType);

  public
     // titipan:
     OBM : TTDC_Symbol;

     ANDULines : array[1..16] of TEdit;
     DRL, ICL : TEdit;
     CurrentPageType :   tPageType;

     procedure SetTextLine(const line: byte; const text: string);
     procedure SetTextLineCol(const line, col: byte; const text: string);

     procedure SetTextPar(const line: byte; const text1, text2: string);

     procedure ParseCommand(const str: string);


  end;

const
    FORMAT : array [1..18] of string =

          ( 'A8 S9 U4 C4 F4 RP2 C8 LTXXXXXX', '12222 345 666 7777 888 9 XXXXX',
            'U1111 222 333 44.4 555 6 XXXXX', 'D1111 222 3 4444 5555 66 77777',
            'B1111 222 3333 4 W555.5i66666X', 'F1111 23 444 5555        XXXXX',
            'R1111 22 333 4444        XXXXX', 'VEC MV111 TD22 TF33   TW444444',
            '56666CAR78888CS999SPOOO DUXXXX', 'TOR TN1111 R22222 B333 V4444  ',
            'R55555 B666 T7 IC888 IR9999 LX', 'STA   GD CS111SP22.2BR333RG4.4',
            'S5555 OS CS666SP77.7    DUXXXX', 'CPA   TGTBR111 RG22.2         ',
            'S3333 CPABR444 RG55.5   DUXXXX', 'RB 11 11.12 333 33.34 LTXXXXXX',
            'RB 111 222.2 GRD 3 444.4 555.5', 'TW 111 22 RW 333 44 CR 555 6.6');

implementation

uses StrUtils, uBaseFunction;

{$R *.dfm}

procedure  Split(const delimiter, S: string; var chunks: TStrings);
var i, l : integer;
  sub :string;
begin
  chunks.Clear;
  l := Length(S);
  i := 1;
  while (i <= l)  do
  begin
     sub := '';
     while (i <= l) and not IsDelimiter(delimiter,S,i) do
     begin   //Warning! isDelimiter ngetes salah satu karakter(OR)..
       if (s[i]<> char(10)) and (s[i] <> char(13)) then
        sub := sub + s[i];   //^&^
       inc(i);
     end;
     sub := trim(sub);
     if sub <> '' then
      chunks.Append(sub)
     else
      chunks.Append(' ');

     inc(i);
  end;
end;

function InsertSpace(const str: string):string;
var i: integer;
begin
  result := '';
  for i := 0 to length(str)-1 do
     result := result +  str[i+1] + ' ';
end;

function RemoveSpace(const str: string):string;
var i, m: integer;
begin
  result := '';
  m := length(str) div 2;
  for i := 1 to m do
     result := result +  str[2*i-1];
end;

function FillSpace(const n: byte): string;
var i: integer;
begin
  result := '';
  for i := 1 to n do begin
    result := result + ' ';
  end;
end;

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


procedure TfrmInjectionKeyBoard.SetTextLine(const line: byte; const text: string);
begin
  if (line >=1) and (line <= 16) then
    ANDULines[line].Text := InsertSpace(text);
end;

procedure TfrmInjectionKeyBoard.SetTextPar(const line: byte; const text1, text2: string);
begin
  if (line >=1) and (line < 16) then begin
    ANDULines[line].Text := InsertSpace(text1);
    ANDULines[line+1].Text := InsertSpace(text2);
  end;
end;

procedure TfrmInjectionKeyBoard.SetTextLineCol(const line, col: byte; const text: string);
var str: string;
    l : integer;
begin
  if (line >=1) and (line <= 16)
     and (col < 32) then begin
      str := RemoveSpace(ANDULines[line].Text);
      l := length(str);
      if  (l <  col ) then begin
        str := str + FillSpace(col - l) + text;
        ANDULines[line].Text := InsertSpace(str);
      end
      else begin
        SetLength(str, col + length(text));
        str := StuffString(str, col +1, length(text), text);
        ANDULines[line].Text := InsertSpace(str);
      end;
  end;
end;

procedure TfrmInjectionKeyBoard.ParseCommand(const str: string);
var ss : TStrings;
begin
  ss := TStringList.Create;
  Split(' ', str, ss);
  if ss.Count < 1 then exit;

  if ss.Count > 1 then begin
    if IsValidTrackNumber(ss[0]) then
       Do_Track_Action(ss)
    else
      Do_NonTrack_Action(ss);
  end
  else
    Do_NonTrack_Action(ss);

  ss.Clear;
  ss.Free;
end;

procedure TfrmInjectionKeyBoard.Do_NonTrack_Action(const ss: TStrings);
var i: integer;
    b: byte;
    s : string;
begin

  {# 0}
// MIK Display Selection - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  {# 01}
  if ss[0] = 'PAG+' then  begin
    if ss[1] = 'G' then  Do__SelectPage(ptGeneral)
    else if ss[1] = 'F' then Do__SelectPage(ptFreeForm)
    else if ss[1] = 'LR' then Do__SelectPage(ptLinkTransmit)
    else if ss[1] = 'LR' then Do__SelectPage(ptLinkReceive);
  end
  else
  {# 02}
  if ss[0] = 'PAG-' then  begin
     WipePage;
  end
  else
  {# 03}
  if ss[0] = 'PAR+' then  begin
       // s, c , t, v
  end
  else
  {# 04}
  if ss[0] = 'PAR-' then  begin
       // s, c , t, v

  end
  else
  {# 05}
  if ss[0] = 'FFL+' then  begin
    if ss.Count < 3 then exit;
    Val(ss[1], b, i);
    if i <> 0 then exit;
    if (CurrentPageType = ptFreeForm) or
    (CurrentPageType = ptLinkTransmit) then
      s := '';
      for i := 2 to ss.Count-1  do
        s := s + ss[i] + ' ';
      SetTextLine(b, s);
  end
  else
  {# 06}
  if ss[0] = 'SLL+' then  begin

  end
  else
  {# 08}
  if ss[0] = 'QGC+' then  begin

  end
  else
  {# 09}
  if ss[0] = 'QSG+' then  begin

  end
  else
  {# 10}
  if ss[0] = 'QTW+' then  begin

  end
  else
  {# 11}
  if ss[0] = 'LIN-' then  begin
    Val(ss[1], b, i);
    if i <> 0 then exit;
    SetTextLine(b, '');
  end
  else
  {# 0}
  if ss[0] = '+' then  begin

  end
  else
  {# 0}
  if ss[0] = '+' then  begin

  end
  else
  {# 0}
  if ss[0] = '+' then  begin

  end

(*
  else
  {# 0}
  if ss[0] = '+' then  begin

  end

*)

end;

procedure TfrmInjectionKeyBoard.Do_Track_Action(const ss: TStrings);
begin
  {# 07}
  if ss[1] = 'SCR+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end

  else
  {# 0}
  if ss[1] = '+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end
  else
  {# 0}
  if ss[1] = '+' then  begin

  end
end;

procedure TfrmInjectionKeyBoard.WipePage;
var i: integer;
begin
  for i := 1 to 16 do
    ANDULines[i].Text := '';
end;

procedure TfrmInjectionKeyBoard.SavePage(var ss: TStrings);
var i: integer;
begin
  ss.Clear;
  for i := 1 to 16 do
    ss.Add(ANDULines[i].Text);
end;

procedure TfrmInjectionKeyBoard.ReloadPage(const ss: TStrings);
var i, j: integer;
begin
  for i := 1 to 16 do
    ANDULines[i].Text := '';
  if ss.Count > 16 then
    j := 16
  else
    j := ss.Count;

  for i := 0 to j-1 do
    ANDULines[i+1].Text := ss.Strings[i];
end;


procedure TfrmInjectionKeyBoard.Do__SelectPage(pt: tPageType);
begin
  if pt = CurrentPageType then exit;
  SavePage(sPage[CurrentPageType]);
  ReloadPage(sPage[pt]);

  CurrentPageType := pt;
end;

procedure TfrmInjectionKeyBoard.FormCreate(Sender: TObject);
var i: integer;
    s: string;
    btn: TVrBitmapButton;
begin
  for i := 0 to 25 do begin
    s := 'btn_'+ char(ord('A')+i);
    btn := FindComponent(s) as TVrBitmapButton;
    btn.Tag := ord('A') + i;
    btn.OnClick := btn_AlphaNumClick;
  end;

  for i := 0 to 9 do begin
    s := 'btn_'+ char(ord('0')+i);
    btn := FindComponent(s) as TVrBitmapButton;
    btn.Tag := ord('0') + i;
    btn.OnClick := btn_AlphaNumClick;
  end;

  btn_dot.Tag       := ord('.');
  btn_dot.OnClick   := btn_AlphaNumClick;

  btn_plus.Tag      := ord('+');
  btn_plus.OnClick  := btn_AlphaNumClick;

  btn_minus.Tag     := ord('-');
  btn_minus.OnClick := btn_AlphaNumClick;

  btn_Space.Tag      := ord(' ');
  btn_space.OnClick  := btn_AlphaNumClick;

  ANDULines[01] := AnduTDC01;
  ANDULines[02] := AnduTDC02;
  ANDULines[03] := AnduTDC03;
  ANDULines[04] := AnduTDC04;
  ANDULines[05] := AnduTDC05;
  ANDULines[06] := AnduTDC06;
  ANDULines[07] := AnduTDC07;
  ANDULines[08] := AnduTDC08;
  ANDULines[09] := AnduTDC09;
  ANDULines[10] := AnduTDC10;
  ANDULines[11] := AnduTDC11;
  ANDULines[12] := AnduTDC12;
  ANDULines[13] := AnduTDC13;
  ANDULines[14] := AnduTDC14;
  ANDULines[15] := AnduTDC15;
  ANDULines[16] := AnduTDC16;

  DRL := AnduTDC15;
  ICL := AnduTDC16;


  SPage[ptGeneral      ]  := TStringList.Create;
  SPage[ptFreeForm     ]  := TStringList.Create;
  SPage[ptLinkTransmit ]  := TStringList.Create;
  SPage[ptLinkReceive  ]  := TStringList.Create;

  CurrentPageType := ptGeneral;

{  SetTextLineCol(3, 0, 'tes 123');
  SetTextLineCol(4, 10, 'col 10');
  SetTextLine(5, 'tes 1234567890');
  SetTextLineCol(5, 10, 'col 10');
}
end;

procedure TfrmInjectionKeyBoard.FormDestroy(Sender: TObject);
var p: tPageType;
begin
  for p := ptGeneral to ptLinkReceive do begin
    SPage[p].Clear;
    SPage[p].Free;
  end;
end;

procedure TfrmInjectionKeyBoard.btn_AlphaNumClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + char( byte((sender as TComponent).Tag));
  SetTextLine(16, Mnemonic);

  AnduTDC16.SetFocus;
  AnduTDC16.SelStart := length(AnduTDC16.Text);

end;

procedure TfrmInjectionKeyBoard.btn_BackSpaceClick(Sender: TObject);
begin
  SetLength(Mnemonic, Length(Mnemonic)-1);
  SetTextLine(16, Mnemonic);
end;


procedure TfrmInjectionKeyBoard.btn_4spaceClick(Sender: TObject);
begin
  Mnemonic := '   ';
  SetTextLine(16, Mnemonic);
end;

procedure TfrmInjectionKeyBoard.btn_ExecuteClick(Sender: TObject);
begin
//
//  Action_Mnemonic(Mnemonic);
  ParseCommand(Mnemonic);
  Mnemonic := '';
  SetTextLine(16, Mnemonic);
end;

procedure TfrmInjectionKeyBoard.btn_EraseSpaceClick(Sender: TObject);
begin
  Mnemonic := '';
  ANDULines[16].Text := '';
end;

procedure TfrmInjectionKeyBoard.btn_SpaceClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + ' ';
  //lblText.Caption := Mnemonic;
  SetTextLine(16, Mnemonic);
end;

///////////////////////////////////////////////////////////////////////////
function TfrmInjectionKeyBoard.MakeStr(const Args: array of const): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(Args) do
    with Args[I] do
      case VType of
        vtInteger:    Result := Result + IntToStr(VInteger);
        vtBoolean:    Result := Result + BoolToStr(VBoolean);
        vtChar:       Result := Result + VChar;
        vtExtended:   Result := Result + FloatToStr(VExtended^);

        vtString:     Result := Result + VString^;
        vtPChar:      Result := Result + VPChar;
        vtObject:     Result := Result + VObject.ClassName;
        vtClass:      Result := Result + VClass.ClassName;
        vtAnsiString: Result := Result + string(VAnsiString);
        vtCurrency:   Result := Result + CurrToStr(VCurrency^);
        vtVariant:    Result := Result + string(VVariant^);
        vtInt64:      Result := Result + IntToStr(VInt64^);
    end;
end;

procedure TfrmInjectionKeyBoard.waktulokal;
var j:integer;
begin
      //SLLAlok : array [1..9] of string =('SS','A8','S9','U4','D4','F4','RP2','C8','LTXXXXXX');
      j:=baris;
      LocTime:=Time;
      SS:=baris;          //line number
      A8:=8;          //alok kontak udara
      S9:=9;          //alok kontak atas air
      U4:=4;          //alok kontak bawah air
      D4:=4;          //alok DATUM
      F4:=4;          //alok ESM FIX
      RP2:=2;         //alok posisi Referensi
      C8:=8;          //alok cursor
      SLLAlok[1]:=' ' + inttostr(SS);
      SLLAlok[2]:='A'+inttostr(A8);
      SLLAlok[3]:=' S'+inttostr(S9);
      SLLAlok[4]:=' U'+inttostr(U4);
      SLLAlok[5]:=' D'+inttostr(D4);
      SLLAlok[6]:=' F'+inttostr(F4);
      SLLAlok[7]:=' RP'+inttostr(RP2);
      SLLAlok[8]:=' C'+inttostr(C8);
      SLLAlok[9]:=TimetoStr(LocTime);
      case j of
        1:begin  AnduTDC01.Text :=AnduTDC01.Text + SLLAlok[9];end;
        2:begin  AnduTDC02.Text :=AnduTDC02.Text + SLLAlok[9];end;
        3:begin  AnduTDC03.Text :=AnduTDC03.Text + SLLAlok[9];end;
        4:begin  AnduTDC04.Text :=AnduTDC04.Text + SLLAlok[9];end;
        5:begin  AnduTDC05.Text :=AnduTDC05.Text + SLLAlok[9];end;
        6:begin  AnduTDC06.Text :=AnduTDC06.Text + SLLAlok[9];end;
        7:begin  AnduTDC07.Text :=AnduTDC07.Text + SLLAlok[9];end;
        8:begin  AnduTDC08.Text :=AnduTDC08.Text + SLLAlok[9];end;
        9:begin  AnduTDC09.Text :=AnduTDC09.Text + SLLAlok[9];end;
       10:begin  AnduTDC10.Text :=AnduTDC10.Text + SLLAlok[9];end;
       11:begin  AnduTDC11.Text :=AnduTDC11.Text + SLLAlok[9];end;
       12:begin  AnduTDC12.Text :=AnduTDC12.Text + SLLAlok[9];end;
       13:begin  AnduTDC13.Text :=AnduTDC13.Text + SLLAlok[9];end;
       14:begin  AnduTDC14.Text :=AnduTDC14.Text + SLLAlok[9];end;
       15:begin  AnduTDC15.Text :=AnduTDC15.Text + SLLAlok[9];end;
      end;

end;



procedure TfrmInjectionKeyBoard.Action_SLL;
var i,j:integer;
begin
      //SLLAlok : array [1..9] of string =('SS','A8','S9','U4','D4','F4','RP2','C8','LTXXXXXX');
      j:=baris;
      LocTime:=Time;
      SS:=baris;          //line number
      A8:=8;          //alok kontak udara
      S9:=9;          //alok kontak atas air
      U4:=4;          //alok kontak bawah air
      D4:=4;          //alok DATUM
      F4:=4;          //alok ESM FIX
      RP2:=2;         //alok posisi Referensi
      C8:=8;          //alok cursor
      SLLAlok[1]:=' ' + inttostr(SS);
      SLLAlok[2]:='A'+ inttostr(A8);
      SLLAlok[3]:=' S'+inttostr(S9);
      SLLAlok[4]:=' U'+inttostr(U4);
      SLLAlok[5]:=' D'+inttostr(D4);
      SLLAlok[6]:=' F'+inttostr(F4);
      SLLAlok[7]:=' RP'+inttostr(RP2);
      SLLAlok[8]:=' C'+inttostr(C8);
      SLLAlok[9]:=TimetoStr(LocTime);
      for i:= 1 to 9 do begin
        case j of
        1:begin  AnduTDC01.Text :=AnduTDC01.Text + SLLAlok[i];end;
        2:begin  AnduTDC02.Text :=AnduTDC02.Text + SLLAlok[i];end;
        3:begin  AnduTDC03.Text :=AnduTDC03.Text + SLLAlok[i];end;
        4:begin  AnduTDC04.Text :=AnduTDC04.Text + SLLAlok[i];end;
        5:begin  AnduTDC05.Text :=AnduTDC05.Text + SLLAlok[i];end;
        6:begin  AnduTDC06.Text :=AnduTDC06.Text + SLLAlok[i];end;
        7:begin  AnduTDC07.Text :=AnduTDC07.Text + SLLAlok[i];end;
        8:begin  AnduTDC08.Text :=AnduTDC08.Text + SLLAlok[i];end;
        9:begin  AnduTDC09.Text :=AnduTDC09.Text + SLLAlok[i];end;
       10:begin  AnduTDC10.Text :=AnduTDC10.Text + SLLAlok[i];end;
       11:begin  AnduTDC11.Text :=AnduTDC11.Text + SLLAlok[i];end;
       12:begin  AnduTDC12.Text :=AnduTDC12.Text + SLLAlok[i];end;
       13:begin  AnduTDC13.Text :=AnduTDC13.Text + SLLAlok[i];end;
       14:begin  AnduTDC14.Text :=AnduTDC14.Text + SLLAlok[i];end;
       15:begin  AnduTDC15.Text :=AnduTDC15.Text + SLLAlok[i];end;
        end;

      end;

end;

procedure TfrmInjectionKeyBoard.Action_SCRAtasAir;
var i,j:integer;
begin
      //SCRAtasAir :array [1..11] of string =('SS','1','2222','3','4','5','666','7777','888','9','XXXXX');
      j:=baris;
      //array initial value
      LocTime:=Time;
      SS:=baris;
      TrackNumber:=2222; // initial value
      idSas:=3;
      idTambahan:=4;
      idSumber:=5;
      HaluSas:=359;
      SpeedSas:=7777;
      TinggiSas:=888;
      FCnumber:=2;
      PrivatCode:=1010;

      SCRAtasAir[1]:=' ' + inttostr(SS);
      SCRAtasAir[2]:= 'A'; // jika surface 'S'
      SCRAtasAir[3]:= ' ' + inttoStr(TrackNumber);
      SCRAtasAir[4]:= ' ' + inttoStr(idSas);
      SCRAtasAir[5]:= ' ' + inttoStr(idTambahan);
      SCRAtasAir[6]:= ' ' + inttoStr(idSumber);
      SCRAtasAir[7]:= ' ' + inttoStr(HaluSas);
      SCRAtasAir[8]:= ' ' + inttoStr(SpeedSas);
      SCRAtasAir[9]:= ' ' + inttoStr(TinggiSas);
      SCRAtasAir[10]:= ' ' + inttoStr(FCnumber);
      SCRAtasAir[11]:= ' ' + inttoStr(PrivatCode);
      for i:= 1 to 11 do begin
       case j of
        1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCRAtasAir[i];end;
        2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCRAtasAir[i];end;
        3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCRAtasAir[i];end;
        4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCRAtasAir[i];end;
        5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCRAtasAir[i];end;
        6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCRAtasAir[i];end;
        7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCRAtasAir[i];end;
        8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCRAtasAir[i];end;
        9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCRAtasAir[i];end;
       10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCRAtasAir[i];end;
       11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCRAtasAir[i];end;
       12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCRAtasAir[i];end;
       13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCRAtasAir[i];end;
       14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCRAtasAir[i];end;
       15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCRAtasAir[i];end;
       end;
      end;
end;

procedure TfrmInjectionKeyBoard.Action_SCRBawahAir;
var i,j:integer;
begin
      //SCRBawahAir:array [1..9] of string =('SS','U','1111','222','333','44.4','555','6','XXXXX');
      j:=baris;
      SS:=baris;//line number
      TrackNumber:=2222; // initial value
      HaluSas:=359;
      SpeedSas:=7777;
      TinggiSas:=888;
      FCnumber:=2;
      PrivatCode:=1010;
      SCRBawahAir[1]:=' ' + inttostr(SS);
      SCRBawahAir[2]:= ' U';
      SCRBawahAir[3]:= ' ' + inttoStr(TrackNumber);
      SCRBawahAir[4]:= ' ' + 'UNC'; // POS, PRB, CRT
      SCRBawahAir[5]:= ' ' + inttoStr(HaluSas);
      SCRBawahAir[6]:= ' ' + inttoStr(SpeedSas);
      SCRBawahAir[7]:= ' ' + inttoStr(DalamSas);
      SCRBawahAir[8]:= ' ' + inttoStr(FCnumber);
      SCRBawahAir[9]:= ' ' + inttoStr(PrivatCode);
      for i:= 1 to 9 do begin
       case j of
        1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCRBawahAir[i];end;
        2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCRBawahAir[i];end;
        3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCRBawahAir[i];end;
        4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCRBawahAir[i];end;
        5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCRBawahAir[i];end;
        6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCRBawahAir[i];end;
        7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCRBawahAir[i];end;
        8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCRBawahAir[i];end;
        9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCRBawahAir[i];end;
       10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCRBawahAir[i];end;
       11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCRBawahAir[i];end;
       12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCRBawahAir[i];end;
       13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCRBawahAir[i];end;
       14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCRBawahAir[i];end;
       15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCRBawahAir[i];end;
       end;
      end;
end;

procedure TfrmInjectionKeyBoard.Action_SCRDatum;
var i,j:integer;
begin
      //SCRDatum :array [1..9] of string =('SS','D','1111','222','3','4444','5555','66','77777');
      j:=baris;
      SS:=baris;
      TrackNumber:=2222; // initial value
      ErrDatum:=3;
      LocTime:=Time;
      HaluSas:=359;
      SpeedSas:=7777;
      TinggiSas:=888;
      FCnumber:=2;
      PrivatCode:=1010;
      SCRDatum[1]:=' ' + inttostr(SS);
      SCRDatum[2]:= ' D';
      SCRDatum[3]:= ' ' + inttoStr(TrackNumber);
      SCRDatum[4]:= ' ' + 'SOU'; // sumber datum
      SCRDatum[5]:= ' ' + inttoStr(ErrDatum);
      SCRDatum[6]:= ' ' + TimetoStr(LocTime);
      SCRDatum[7]:= ' ' + TimetoStr(LocTime);// not time,but lifetime
      SCRDatum[8]:= ' ' + inttoStr(SpeedSas);
      SCRDatum[9]:= ' ' + inttoStr(PrivatCode);
      for i:= 1 to 9 do begin
         case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCRDatum[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCRDatum[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCRDatum[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCRDatum[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCRDatum[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCRDatum[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCRDatum[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCRDatum[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCRDatum[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCRDatum[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCRDatum[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCRDatum[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCRDatum[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCRDatum[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCRDatum[i];end;
         end;
      end;
end;

procedure TfrmInjectionKeyBoard.Action_SCREsm;
var i,j:integer;
begin
      //SCREsm :array [1..9] of string =('SS','B','1111','222','3333','4','W555.5','I66666','X');
      j:=baris;
      SS:=baris;
      TrackNumber:=2222; // initial value
      ErrDatum:=3;
      LocTime:=Time;
      Baringan:=359;
      TrackNumberSusie:=4;
      LebarPulsa:=5555;
      RepPulsa:=66666;
      SpeedSas:=7777;
      TinggiSas:=888;
      FCnumber:=2;
      PrivatCode:=1010;
      SCREsm[1]:=' ' + inttostr(SS);
      SCREsm[2]:= ' B';
      SCREsm[3]:= ' ' + inttoStr(TrackNumber);
      SCREsm[4]:= ' ' + inttoStr(Baringan);
      SCREsm[5]:= ' ' + TimetoStr(LocTime);// not time,but lifetime
      SCREsm[6]:= ' ' + inttoStr(TrackNumberSusie);
      SCREsm[7]:= ' W' + inttoStr(LebarPulsa);
      SCREsm[8]:= ' I' + inttoStr(RepPulsa);
      SCREsm[9]:= ' X'; //J ,X,C,S
      for i:= 1 to 9 do begin
        case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCREsm[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCREsm[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCREsm[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCREsm[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCREsm[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCREsm[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCREsm[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCREsm[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCREsm[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCREsm[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCREsm[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCREsm[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCREsm[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCREsm[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCREsm[i];end;
         end;
      end;
end;

procedure TfrmInjectionKeyBoard.Action_SCRFix;
var i,j:integer;
begin
      //SCRFix:array [1..8] of string =('ss','F','1111','23','444','5555','******','XXXXX');
      j:=baris;
      SS:=baris;
      TrackNumber:=2222; // initial value
      idSas:=3;   //
      LocTime:=Time;
      PrivatCode:=1010;
      SCRFix[1]:=' ' + inttostr(SS);
      SCRFix[2]:= ' F';
      SCRFix[3]:= ' ' + inttoStr(TrackNumber);
      SCRFix[4]:= ' ' + inttoStr(idSas);  // identitas apa nggak jelas
      SCRFix[5]:= 'W'; //platform/wahana........nggak ngerti
      SCRFix[6]:= ' ' + TimetoStr(LocTime);
      SCRFix[7]:= ' ' + TimetoStr(LocTime); // life time.....dimulai dr mana nggak ngerti
      SCRFix[8]:= '        ';
      SCRFix[9]:= ' ' + inttoStr(PrivatCode);
      for i:= 1 to 9 do begin
         case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCRFix[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCRFix[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCRFix[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCRFix[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCRFix[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCRFix[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCRFix[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCRFix[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCRFix[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCRFix[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCRFix[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCRFix[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCRFix[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCRFix[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCRFix[i];end;
         end;
      end;
end;

procedure TfrmInjectionKeyBoard.Action_SCRRef ;
var i,j,CodeTrack:integer;
begin
      //SCRRef:array [1..8] of string =('SS','R','1111','22','333','4444','******','XXXXX');
      j:=baris;
      SS:=baris;
      TrackNumber:=1111; // initial value
      CodeTrack:=22;
      HaluRef:=333;
      SpeedRef:=4444;
      PrivatCode:=1010;
      SCRRef[1]:=' ' + inttostr(SS);
      SCRRef[2]:= 'R';
      SCRRef[3]:= inttoStr(TrackNumber);
      SCRRef[4]:= ' ' + inttoStr(CodeTrack);  // codetrack dua huruf.....nggak ngerti
      SCRRef[5]:= ' ' + inttoStr(HaluRef); //Haluan posisi referensi...nggak ngerti
      SCRRef[6]:= ' ' + inttoStr(SpeedRef);
      SCRRef[7]:= '        ';
      SCRRef[8]:= ' ' + inttoStr(PrivatCode);
      SCRRef[9]:='';
      for i:= 1 to 9 do begin
        case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + SCRRef[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + SCRRef[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + SCRRef[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + SCRRef[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + SCRRef[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + SCRRef[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + SCRRef[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + SCRRef[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + SCRRef[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + SCRRef[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + SCRRef[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + SCRRef[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + SCRRef[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + SCRRef[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + SCRRef[i];end;
         end;
      end;
end;


procedure TfrmInjectionKeyBoard.Action_Parv;
var i,j:integer;
begin
      //cPARV1 :array [1..6] of string =('SS','VEC','MV111','TD22','TF33','TW444444');
      //cPARV2 :array [1..9] of string =('SS','5','6666','CAR','7','8888','CS999','SPOOO','DUXXXX');
      j:=baris;
      SS:=baris;
      SS2:=SS +1;
      Mv:=111;          // variasi kompas magnit
      Td:=22;           // time delay
      Tf:=33;           // koreksi balistik
      Tw:=444444;       // angin sejati (arah dan cepat)
      TrackNumber:=6666;
      TrackNumberCAR:=8888;
      HaluDropPoint:=999;
      LocTime:=Time;
      PARV1[1]:=' ' + inttostr(SS);
      PARV2[1]:=' ' + inttostr(SS2);
      PARV1[2]:='VEC';
      PARV2[2]:='S';  // atau 'U'  ---> klasifikasi sasaran
      PARV1[3]:=' ' +'MV'+inttoStr(Mv);
      PARV2[3]:=inttoStr(TrackNumber);
      PARV1[4]:=' ' +'TD'+inttoStr(Td);
      PARV2[4]:='CAR';
      PARV1[5]:=' ' +'TF'+inttoStr(Tf);
      PARV2[5]:='S';  // atau 'A'  ---> klasifikasi pembawa senjata
      PARV1[6]:=' ' +'   TW'+inttoStr(Tw);
      PARV2[6]:=inttoStr(TrackNumberCAR);  // track number pembawa senjata
      PARV2[7]:='CS' + inttoStr(HaluDropPoint);
      PARV2[8]:='DU' + TimetoStr(LocTime);
      for i:= 1 to 6 do begin
       case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + PARV1[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + PARV1[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + PARV1[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + PARV1[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + PARV1[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + PARV1[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + PARV1[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + PARV1[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + PARV1[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + PARV1[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + PARV1[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + PARV1[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + PARV1[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + PARV1[i];end;
         end;
      end;
      for i:= 1 to 8 do begin
       case j of
          1:begin  AnduTDC02.Text :=AnduTDC02.Text + PARV2[i];end;
          2:begin  AnduTDC03.Text :=AnduTDC03.Text + PARV2[i];end;
          3:begin  AnduTDC04.Text :=AnduTDC04.Text + PARV2[i];end;
          4:begin  AnduTDC05.Text :=AnduTDC05.Text + PARV2[i];end;
          5:begin  AnduTDC06.Text :=AnduTDC06.Text + PARV2[i];end;
          6:begin  AnduTDC07.Text :=AnduTDC07.Text + PARV2[i];end;
          7:begin  AnduTDC08.Text :=AnduTDC08.Text + PARV2[i];end;
          8:begin  AnduTDC09.Text :=AnduTDC09.Text + PARV2[i];end;
          9:begin  AnduTDC10.Text :=AnduTDC10.Text + PARV2[i];end;
         10:begin  AnduTDC11.Text :=AnduTDC11.Text + PARV2[i];end;
         11:begin  AnduTDC12.Text :=AnduTDC12.Text + PARV2[i];end;
         12:begin  AnduTDC13.Text :=AnduTDC13.Text + PARV2[i];end;
         13:begin  AnduTDC14.Text :=AnduTDC14.Text + PARV2[i];end;
         14:begin  AnduTDC15.Text :=AnduTDC15.Text + PARV2[i];end;
         end;
      end;
end;


procedure TfrmInjectionKeyBoard.Action_Part;
var i,j:integer;
begin
      //cPART1 :array [1..6] of string =('SS','TOR','TN1111','R22222','B333','V4444');
      //cPART2 :array [1..7] of string =('SS','R55555','B666','T7','IC888','IR9999','LX');
      j:=baris;
      SS:=baris;//line number
      SS2:=SS +1;
      TrackNumber:=1111;
      JarakSas:=22222;
      Baringan:=333;
      Baringan2:=666;
      TimeTor:=7;
      SpeedSas:=4444;
      JarakPhp:=55555;
      StraightCourse:=888;
      StraightRun:=9999;
      PART1[1]:=' ' + inttostr(SS);
      PART2[1]:=' ' + inttostr(SS2);
      PART1[2]:='TOR';
      PART2[2]:='R' + inttoStr(JarakPhp);  // jarak PHP  ---> prediction hit point
      PART1[3]:=' ' +'TN'+inttoStr(TrackNumber);
      PART2[3]:=' ' + 'B'+inttoStr(Baringan2);
      PART1[4]:=' ' +'R'+inttoStr(JarakSas);
      PART2[4]:='CAR';
      PART1[5]:=' ' +'B'+inttoStr(Baringan);   // baringan sasaran dalam yard
      PART2[5]:=' ' +'T'+inttoStr(TimeTor);// waktu run terpedo
      PART1[6]:=' ' +'V'+inttoStr(SpeedSas);
      PART2[6]:=' ' + 'IC' +inttoStr(StraightCourse);  // initial straight course
      PART2[7]:=' ' + 'IR' +inttoStr(StraightRun);   // initial staright run
      PART2[8]:='LP';  // atau 'LS' ---> peluncur
      for i:= 1 to 6 do begin
       case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + PART1[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + PART1[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + PART1[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + PART1[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + PART1[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + PART1[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + PART1[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + PART1[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + PART1[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + PART1[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + PART1[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + PART1[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + PART1[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + PART1[i];end;
         end;
      end;
      for i:= 1 to 8 do begin
       case j of
          1:begin  AnduTDC02.Text :=AnduTDC02.Text + PART2[i];end;
          2:begin  AnduTDC03.Text :=AnduTDC03.Text + PART2[i];end;
          3:begin  AnduTDC04.Text :=AnduTDC04.Text + PART2[i];end;
          4:begin  AnduTDC05.Text :=AnduTDC05.Text + PART2[i];end;
          5:begin  AnduTDC06.Text :=AnduTDC06.Text + PART2[i];end;
          6:begin  AnduTDC07.Text :=AnduTDC07.Text + PART2[i];end;
          7:begin  AnduTDC08.Text :=AnduTDC08.Text + PART2[i];end;
          8:begin  AnduTDC09.Text :=AnduTDC09.Text + PART2[i];end;
          9:begin  AnduTDC10.Text :=AnduTDC10.Text + PART2[i];end;
         10:begin  AnduTDC11.Text :=AnduTDC11.Text + PART2[i];end;
         11:begin  AnduTDC12.Text :=AnduTDC12.Text + PART2[i];end;
         12:begin  AnduTDC13.Text :=AnduTDC13.Text + PART2[i];end;
         13:begin  AnduTDC14.Text :=AnduTDC14.Text + PART2[i];end;
         14:begin  AnduTDC15.Text :=AnduTDC15.Text + PART2[i];end;
         end;
      end;
      {
      for i:= 1 to 6 do begin
        AnduTDC01.Text :=AnduTDC01.Text + PART1[i];
      end;
      for i:= 1 to 8 do begin
        AnduTDC02.Text :=AnduTDC02.Text + PART2[i];
      end;}
end;

procedure TfrmInjectionKeyBoard.Action_Pars ;
var i,j:integer;
begin
    //PARS1 :array [1..7] of string =('SS','STA','GD','CS111','SP22.2','BR333','RG4.4');
    //PARS2 :array [1..5] of string =('SS','S5555','OS','CS666SP77.7','DUXXXX');
    j:=baris;
    SS:=baris;
    SS2:=SS +1;
    CoursePenjuru:=111;
    SpeedPenjuru:=222;
    BaringanStation:=333;
    JarakStation:=44;
    TrackNumberPenjuru:=5555;
    CourseStationBaru:=666;
    SpeedStation:=777;
    LocTime:=Time;
    PARS1[1]:=' ' + inttostr(SS);
    PARS2[1]:=' ' + inttostr(SS2);
    PARS1[2]:='STA';
    PARS2[2]:='S' + inttoStr(TrackNumberPenjuru);  // nomor track number penjuru....nggak ngerti
    PARS1[3]:='   ' +'GD';
    PARS2[3]:=' ' + 'OS';
    PARS1[4]:=' ' +'CS'+inttoStr(CoursePenjuru);
    PARS2[4]:=' ' + inttoStr(CourseStationBaru);  // hal menuju station baru.....nggak ngerti
    PARS1[5]:='SP'+inttoStr(SpeedPenjuru);
    PARS2[5]:='SP' +inttoStr(SpeedStation);   //cepat station
    PARS1[6]:='BR'+inttoStr(BaringanStation);  // baringan station baru dari penjuru
    PARS2[6]:='    ' + 'DU' +TimetoStr(LocTime);  // waktu manorva (menit,detik)
    PARS1[7]:='RG' + inttoStr(JarakStation);   //jarak station baru dari penjuru
    for i:= 1 to 6 do begin
       case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + PARS1[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + PARS1[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + PARS1[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + PARS1[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + PARS1[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + PARS1[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + PARS1[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + PARS1[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + PARS1[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + PARS1[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + PARS1[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + PARS1[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + PARS1[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + PARS1[i];end;
         end;
      end;
      for i:= 1 to 7 do begin
       case j of
          1:begin  AnduTDC02.Text :=AnduTDC02.Text + PARS2[i];end;
          2:begin  AnduTDC03.Text :=AnduTDC03.Text + PARS2[i];end;
          3:begin  AnduTDC04.Text :=AnduTDC04.Text + PARS2[i];end;
          4:begin  AnduTDC05.Text :=AnduTDC05.Text + PARS2[i];end;
          5:begin  AnduTDC06.Text :=AnduTDC06.Text + PARS2[i];end;
          6:begin  AnduTDC07.Text :=AnduTDC07.Text + PARS2[i];end;
          7:begin  AnduTDC08.Text :=AnduTDC08.Text + PARS2[i];end;
          8:begin  AnduTDC09.Text :=AnduTDC09.Text + PARS2[i];end;
          9:begin  AnduTDC10.Text :=AnduTDC10.Text + PARS2[i];end;
         10:begin  AnduTDC11.Text :=AnduTDC11.Text + PARS2[i];end;
         11:begin  AnduTDC12.Text :=AnduTDC12.Text + PARS2[i];end;
         12:begin  AnduTDC13.Text :=AnduTDC13.Text + PARS2[i];end;
         13:begin  AnduTDC14.Text :=AnduTDC14.Text + PARS2[i];end;
         14:begin  AnduTDC15.Text :=AnduTDC15.Text + PARS2[i];end;
         end;
      end;
    {
    for i:= 1 to 6 do begin
      AnduTDC01.Text :=AnduTDC01.Text + PARS1[i];
    end;
    for i:= 1 to 7 do begin
      AnduTDC02.Text :=AnduTDC02.Text + PARS2[i];
    end;}
end;

procedure TfrmInjectionKeyBoard.Action_Parc ;
var i,j:integer;
begin
    //PARC1 :array [1..4] of string =('SS','CPA','TGTBR111','RG22.2');
    //PARC2 :array [1..5] of string =('SS','S3333','CPABR444','RG55.5','DUXXXX');
    j:=baris;
    SS:=baris;
    SS2:=SS +1;
    Baringan:=111;
    JarakSas:=222;
    trackNumber:=3333;
    BaringanCpa:=444;
    JarakCpa:=555;
    locTime:=Time;
    PARC1[1]:=' ' + inttostr(SS);
    PARC2[1]:=' ' + inttostr(SS2);
    PARC1[2]:='CPA';  // closest point of approach
    PARC2[2]:='S';
    PARC1[3]:='   ' + 'TGT'; // target /sasaran
    PARC2[3]:=inttoStr(tracknumber);
    PARC1[4]:='BR' + inttoStr (baringan);
    PARC2[4]:=' '+ 'CPABR' + inttoStr(BaringanCpa);
    PARC1[5]:=' ' +'RG' + intToStr (JarakSas);
    PARC2[5]:=' ' + 'RG' + inttoStr(JarakCpa);
    PARC2[6]:='    ' + 'DU' +TimetoStr(LocTime);  // waktu sammpai dengan CPA (menit,detik)
    for i:= 1 to 5 do begin
       case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + PARC1[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + PARC1[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + PARC1[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + PARC1[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + PARC1[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + PARC1[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + PARC1[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + PARC1[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + PARC1[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + PARC1[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + PARC1[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + PARC1[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + PARC1[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + PARC1[i];end;
         end;
      end;
      for i:= 1 to 6 do begin
       case j of
          1:begin  AnduTDC02.Text :=AnduTDC02.Text + PARC2[i];end;
          2:begin  AnduTDC03.Text :=AnduTDC03.Text + PARC2[i];end;
          3:begin  AnduTDC04.Text :=AnduTDC04.Text + PARC2[i];end;
          4:begin  AnduTDC05.Text :=AnduTDC05.Text + PARC2[i];end;
          5:begin  AnduTDC06.Text :=AnduTDC06.Text + PARC2[i];end;
          6:begin  AnduTDC07.Text :=AnduTDC07.Text + PARC2[i];end;
          7:begin  AnduTDC08.Text :=AnduTDC08.Text + PARC2[i];end;
          8:begin  AnduTDC09.Text :=AnduTDC09.Text + PARC2[i];end;
          9:begin  AnduTDC10.Text :=AnduTDC10.Text + PARC2[i];end;
         10:begin  AnduTDC11.Text :=AnduTDC11.Text + PARC2[i];end;
         11:begin  AnduTDC12.Text :=AnduTDC12.Text + PARC2[i];end;
         12:begin  AnduTDC13.Text :=AnduTDC13.Text + PARC2[i];end;
         13:begin  AnduTDC14.Text :=AnduTDC14.Text + PARC2[i];end;
         14:begin  AnduTDC15.Text :=AnduTDC15.Text + PARC2[i];end;
         end;
      end;
    {
    for i:= 1 to 5 do begin
      AnduTDC01.Text :=AnduTDC01.Text + PARC1[i];
    end;
    for i:= 1 to 6 do begin
      AnduTDC02.Text :=AnduTDC02.Text + PARC2[i];
    end;}
end;

procedure TfrmInjectionKeyBoard.Action_Qgc;
var i,j:integer;
begin
    //QGC:array [1..7] of string =('SS','RB','11 11.1','2','333 33.3','4','LTXXXXXX');
    j:=baris;
    SS:=baris;
    lintang1:=11;
    lintang2:=111;
    bujur1:=333;
    bujur2:=333;
    LocTime:=Time;
    QGC[1]:=' ' + inttostr(SS);
    QGC[2]:='RB';   // roling ball...nggak ngerti maksudnya,mungkin ambil data dari RB
    QGC[3]:=' ' + inttoStr(lintang1);
    QGC[4]:=' ' + inttoStr(lintang2);
    QGC[5]:='N'; //atau 'S'
    QGC[6]:=' ' + inttoStr(bujur1);
    QGC[7]:=' ' + inttoStr(bujur2);
    QGC[8]:='W'; //atau 'E'
    QGC[9]:=TimetoStr(LocTime);
    for i:= 1 to 9 do begin
      //AnduTDC01.Text :=AnduTDC01.Text + QGC[i];
         case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + QGC[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + QGC[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + QGC[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + QGC[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + QGC[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + QGC[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + QGC[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + QGC[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + QGC[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + QGC[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + QGC[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + QGC[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + QGC[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + QGC[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + QGC[i];end;
         end;
    end;
end;

procedure TfrmInjectionKeyBoard.Action_Qsg;
var i,j:integer;
begin
    //QSG:array [1..8] of string =('SS','RB','111','222.2','GRD','3','444.4','555.5');
    j:=baris;
    SS:=baris;
    BaringanOs:=111;
    JarakRbOs:=2222;
    SumbuX:=4444;
    SumbuY:=5555;
    LocTime:=Time;
    QSG[1]:=' ' + inttostr(SS);
    QSG[2]:='RB';   // roling ball...nggak ngerti maksudnya,mungkin ambil data dari RB
    QSG[3]:=' ' + inttoStr(BaringanOs);
    QSG[4]:=' ' + inttoStr(JarakRbOs);
    QSG[5]:=' ' +'GRD';
    QSG[6]:=' ' + 'R';   // atau 'W', 'B' , 'G'  warna kwadrant
    QSG[7]:=' ' + inttoStr(sumbuX);
    QSG[8]:=' ' + inttoStr(sumbuY);
    for i:= 1 to 8 do begin
      //AnduTDC01.Text :=AnduTDC01.Text + QSG[i];
         case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + QSG[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + QSG[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + QSG[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + QSG[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + QSG[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + QSG[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + QSG[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + QSG[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + QSG[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + QSG[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + QSG[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + QSG[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + QSG[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + QSG[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + QSG[i];end;
         end;
    end;
end;

procedure TfrmInjectionKeyBoard.Action_Qtw;
var i,j:integer;
begin
    //QTW:array [1..10] of string =('SS','TW','111','22','RW','333','44','CR','555','6.6');
    j:=baris;
    SS:=baris;
    ArahAnginSejati:=111;
    KecAnginSejati:=22;
    ArahAnginRelatif:=333;
    KecAnginRelatif:=44;
    ArahArus:=555;
    KecArus:=66;
    QTW[1]:=' ' + inttostr(SS);
    QTW[2]:='TW';   // true wind...angin sejati
    QTW[3]:=' ' + inttoStr(ArahAnginSejati);
    QTW[4]:=' ' + inttoStr(KecAnginSejati);
    QTW[5]:=' ' +'RW';  // relative wind
    QTW[6]:=' ' + inttoStr(ArahAnginRelatif);
    QTW[7]:=' ' + 'CR';   // current arus
    QTW[8]:=' ' + inttoStr(ArahArus);
    QTW[9]:=' ' + inttoStr(KecArus);
    for i:= 1 to 9 do begin
      //AnduTDC01.Text :=AnduTDC01.Text + QTW[i];
         case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + QTW[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + QTW[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + QTW[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + QTW[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + QTW[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + QTW[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + QTW[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + QTW[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + QTW[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + QTW[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + QTW[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + QTW[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + QTW[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + QTW[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + QTW[i];end;
         end;
    end;
end;

procedure TfrmInjectionKeyBoard.Action_Cos;
var i,j,tracknumber_cos,haluan_cos,kecepatan_cos:integer;
begin
    j:=baris;
    SS:=baris;
    tracknumber_cos:=1111;
    haluan_cos:=359;
    kecepatan_cos:=1500;
    COS[1]:=inttostr(SS);
    COS[2]:=' ' + inttoStr(tracknumber_cos);
    COS[3]:='COS +';
    COS[4]:=' ' + inttoStr(haluan_cos);
    COS[5]:=' ' + inttoStr(kecepatan_cos);
    for i:= 1 to 5 do begin
      case j of
          1:begin  AnduTDC01.Text :=AnduTDC01.Text + COS[i];end;
          2:begin  AnduTDC02.Text :=AnduTDC02.Text + COS[i];end;
          3:begin  AnduTDC03.Text :=AnduTDC03.Text + COS[i];end;
          4:begin  AnduTDC04.Text :=AnduTDC04.Text + COS[i];end;
          5:begin  AnduTDC05.Text :=AnduTDC05.Text + COS[i];end;
          6:begin  AnduTDC06.Text :=AnduTDC06.Text + COS[i];end;
          7:begin  AnduTDC07.Text :=AnduTDC07.Text + COS[i];end;
          8:begin  AnduTDC08.Text :=AnduTDC08.Text + COS[i];end;
          9:begin  AnduTDC09.Text :=AnduTDC09.Text + COS[i];end;
         10:begin  AnduTDC10.Text :=AnduTDC10.Text + COS[i];end;
         11:begin  AnduTDC11.Text :=AnduTDC11.Text + COS[i];end;
         12:begin  AnduTDC12.Text :=AnduTDC12.Text + COS[i];end;
         13:begin  AnduTDC13.Text :=AnduTDC13.Text + COS[i];end;
         14:begin  AnduTDC14.Text :=AnduTDC14.Text + COS[i];end;
         15:begin  AnduTDC15.Text :=AnduTDC15.Text + COS[i];end;
         end;
    end;

end;


procedure TfrmInjectionKeyBoard.Action_Mnemonic(const value: String);
var j:integer;
begin
//*  if (value = 'PAG+G') then begin   halgeneral;end
//*  else if (value = 'PAG+ F') then begin halfree;end
//*  else if (value = 'PAG-') then begin halhapus;end
//*  else
//*   if (value = 'FFL+ 01') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 02') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 03') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 04') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 05') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 06') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 07') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 08') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 09') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 10') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 11') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 12') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 13') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 14') then begin    AnduTDC01.SetFocus ;  end
//*   else if (value = 'FFL+ 15') then begin    AnduTDC01.SetFocus ;  end
  //happus baris ke....
//*   else if (value = 'LIN- 01') then begin     AnduTDC01.Text :='';  end
//*   else if (value = 'LIN- 02') then begin     AnduTDC02.Text :='';  end
//*   else if (value = 'LIN- 03') then begin     AnduTDC03.Text :='';  end
//*   else if (value = 'LIN- 04') then begin     AnduTDC04.Text :='';  end
//*   else if (value = 'LIN- 05') then begin     AnduTDC05.Text :='';  end
//*   else if (value = 'LIN- 06') then begin     AnduTDC06.Text :='';  end
//*   else if (value = 'LIN- 07') then begin     AnduTDC07.Text :='';  end
//*   else if (value = 'LIN- 08') then begin     AnduTDC08.Text :='';  end
//*   else if (value = 'LIN- 09') then begin     AnduTDC09.Text :='';  end
//*   else if (value = 'LIN- 10') then begin     AnduTDC10.Text :='';  end
//*   else if (value = 'LIN- 11') then begin     AnduTDC11.Text :='';  end
//*   else if (value = 'LIN- 12') then begin     AnduTDC12.Text :='';  end
//*   else if (value = 'LIN- 13') then begin     AnduTDC13.Text :='';  end
//*   else if (value = 'LIN- 14') then begin     AnduTDC14.Text :='';  end
//*   else if (value = 'LIN- 15') then begin     AnduTDC15.Text :='';  end
  //sll
//*   else
  if (value = 'SLL+ 01') then begin j:=1;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 02') then begin j:=2;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 03') then begin j:=3;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 04') then begin j:=4;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 05') then begin j:=5;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 06') then begin j:=6;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 07') then begin j:=7;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 08') then begin j:=8;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 09') then begin j:=9;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 10') then begin j:=10;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 11') then begin j:=11;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 12') then begin j:=12;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 13') then begin j:=13;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 14') then begin j:=14;  baris:=j;Action_SLL;end
  else if (value = 'SLL+ 15') then begin j:=15;  baris:=j;Action_SLL;end
  //SCR
  else if (value = 'SCR+A 01') then begin j:=1;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 02') then begin j:=2;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 03') then begin j:=3;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 04') then begin j:=4;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 05') then begin j:=5;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 06') then begin j:=6;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 07') then begin j:=7;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 08') then begin j:=8;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 09') then begin j:=9;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 10') then begin j:=10;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 11') then begin j:=11;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 12') then begin j:=12;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 13') then begin j:=13;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 14') then begin j:=14;  baris:=j;Action_SCRAtasAir;end
  else if (value = 'SCR+A 14') then begin j:=15;  baris:=j;Action_SCRAtasAir;end

  else if (value = 'SCR+U 01') then begin j:=1;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 02') then begin j:=2;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 03') then begin j:=3;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 04') then begin j:=4;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 05') then begin j:=5;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 06') then begin j:=6;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 07') then begin j:=7;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 08') then begin j:=8;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 09') then begin j:=9;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 10') then begin j:=10;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 11') then begin j:=11;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 12') then begin j:=12;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 13') then begin j:=13;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 14') then begin j:=14;  baris:=j;Action_SCRBawahAir;end
  else if (value = 'SCR+U 15') then begin j:=15;  baris:=j;Action_SCRBawahAir;end

  else if (value = 'SCR+D 01') then begin j:=1;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 02') then begin j:=2;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 03') then begin j:=3;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 04') then begin j:=4;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 05') then begin j:=5;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 06') then begin j:=6;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 07') then begin j:=7;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 08') then begin j:=8;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 09') then begin j:=9;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 10') then begin j:=10;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 11') then begin j:=11;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 12') then begin j:=12;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 13') then begin j:=13;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 14') then begin j:=14;  baris:=j;Action_SCRDatum;end
  else if (value = 'SCR+D 15') then begin j:=15;  baris:=j;Action_SCRDatum;end

  else if (value = 'SCR+E 01') then begin j:=1;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 02') then begin j:=2;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 03') then begin j:=3;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 04') then begin j:=4;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 05') then begin j:=5;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 06') then begin j:=6;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 07') then begin j:=7;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 08') then begin j:=8;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 09') then begin j:=9;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 10') then begin j:=10;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 11') then begin j:=11;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 12') then begin j:=12;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 13') then begin j:=13;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 14') then begin j:=14;  baris:=j;Action_SCREsm;end
  else if (value = 'SCR+E 15') then begin j:=15;  baris:=j;Action_SCREsm;end

  else if (value = 'SCR+F 01') then begin j:=1;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 02') then begin j:=2;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 03') then begin j:=3;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 04') then begin j:=4;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 05') then begin j:=5;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 06') then begin j:=6;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 07') then begin j:=7;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 08') then begin j:=8;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 09') then begin j:=9;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 10') then begin j:=10;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 11') then begin j:=11;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 12') then begin j:=12;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 13') then begin j:=13;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 14') then begin j:=14;  baris:=j;Action_SCRFix;end
  else if (value = 'SCR+F 15') then begin j:=15;  baris:=j;Action_SCRFix;end

  else if (value = 'SCR+R 01') then begin j:=1;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 02') then begin j:=2;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 03') then begin j:=3;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 04') then begin j:=4;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 05') then begin j:=5;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 06') then begin j:=6;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 07') then begin j:=7;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 08') then begin j:=8;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 09') then begin j:=9;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 10') then begin j:=10;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 11') then begin j:=11;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 12') then begin j:=12;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 13') then begin j:=13;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 14') then begin j:=14;  baris:=j;Action_SCRRef;end
  else if (value = 'SCR+R 15') then begin j:=15;  baris:=j;Action_SCRRef;end

  else if (value = 'PAR+V 01') then begin j:=1;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 02') then begin j:=2;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 03') then begin j:=3;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 04') then begin j:=4;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 05') then begin j:=5;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 06') then begin j:=6;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 07') then begin j:=7;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 08') then begin j:=8;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 09') then begin j:=9;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 10') then begin j:=10;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 11') then begin j:=11;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 12') then begin j:=12;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 13') then begin j:=13;  baris:=j;Action_Parv;end
  else if (value = 'PAR+V 14') then begin j:=14;  baris:=j;Action_Parv;end

  else if (value = 'PAR+T 01') then begin j:=1;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 02') then begin j:=2;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 03') then begin j:=3;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 04') then begin j:=4;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 05') then begin j:=5;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 06') then begin j:=6;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 07') then begin j:=7;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 08') then begin j:=8;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 09') then begin j:=9;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 10') then begin j:=10;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 11') then begin j:=11;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 12') then begin j:=12;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 13') then begin j:=13;  baris:=j;Action_Part;end
  else if (value = 'PAR+T 14') then begin j:=14;  baris:=j;Action_Part;end

  else if (value = 'PAR+S 01') then begin j:=1;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 02') then begin j:=2;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 03') then begin j:=3;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 04') then begin j:=4;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 05') then begin j:=5;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 06') then begin j:=6;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 07') then begin j:=7;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 08') then begin j:=8;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 09') then begin j:=9;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 10') then begin j:=10;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 11') then begin j:=11;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 12') then begin j:=12;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 13') then begin j:=13;  baris:=j;Action_Pars;end
  else if (value = 'PAR+S 14') then begin j:=14;  baris:=j;Action_Pars;end

  else if (value = 'PAR+C 01') then begin j:=1;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 02') then begin j:=2;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 03') then begin j:=3;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 04') then begin j:=4;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 05') then begin j:=5;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 06') then begin j:=6;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 07') then begin j:=7;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 08') then begin j:=8;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 09') then begin j:=9;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 10') then begin j:=10;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 11') then begin j:=11;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 12') then begin j:=12;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 13') then begin j:=13;  baris:=j;Action_Parc;end
  else if (value = 'PAR+C 14') then begin j:=14;  baris:=j;Action_Parc;end

  else if (value = 'QGC+ 01') then begin j:=1;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 02') then begin j:=2;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 03') then begin j:=3;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 04') then begin j:=4;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 05') then begin j:=5;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 06') then begin j:=6;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 07') then begin j:=7;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 08') then begin j:=8;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 09') then begin j:=9;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 10') then begin j:=10;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 11') then begin j:=11;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 12') then begin j:=12;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 13') then begin j:=13;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 14') then begin j:=14;  baris:=j;Action_Qgc;end
  else if (value = 'QGC+ 15') then begin j:=15;  baris:=j;Action_Qgc;end

  else if (value = 'QSG+ 01') then begin j:=1;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 02') then begin j:=2;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 03') then begin j:=3;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 04') then begin j:=4;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 05') then begin j:=5;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 06') then begin j:=6;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 07') then begin j:=7;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 08') then begin j:=8;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 09') then begin j:=9;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 10') then begin j:=10;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 11') then begin j:=11;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 12') then begin j:=12;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 13') then begin j:=13;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 14') then begin j:=14;  baris:=j;Action_Qsg;end
  else if (value = 'QSG+ 15') then begin j:=15;  baris:=j;Action_Qsg;end

  else if (value = 'QTW+ 01') then begin j:=1;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 02') then begin j:=2;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 03') then begin j:=3;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 04') then begin j:=4;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 05') then begin j:=5;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 06') then begin j:=6;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 07') then begin j:=7;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 08') then begin j:=8;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 09') then begin j:=9;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 10') then begin j:=10;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 11') then begin j:=11;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 12') then begin j:=12;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 13') then begin j:=13;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 14') then begin j:=14;  baris:=j;Action_Qtw;end
  else if (value = 'QTW+ 15') then begin j:=15;  baris:=j;Action_Qtw;end

  else if (value = 'LOT+ 01') then begin j:=1;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 02') then begin j:=2;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 03') then begin j:=3;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 04') then begin j:=4;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 05') then begin j:=5;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 06') then begin j:=6;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 07') then begin j:=7;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 08') then begin j:=8;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 09') then begin j:=9;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 10') then begin j:=10;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 11') then begin j:=11;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 12') then begin j:=12;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 13') then begin j:=13;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 14') then begin j:=14;  baris:=j;waktulokal;end
  else if (value = 'LOT+ 15') then begin j:=15;  baris:=j;waktulokal;end

  else if (value = 'NTN+') then begin end
  else if (value = 'COS+ 01') then begin j:=1;  baris:=j;action_cos;end




  //.....................................


  else if (value = 'ARC+') then begin
    //Initiate Area Cursor
  end
  else if (value = 'REP+') then begin
    //Initiate Reference Position
  end
  else if (value = 'REP-') then begin
    //Wipe Reference position
  end
  else if (value = 'SGO+') then begin
    //Initiate Surface Grid Origin
  end
  else if (value = 'TNB+') then begin
    //Track Number Block
  end
  else if (value = 'CUR+') then begin
    //Inject Current
  end

  else if (value = 'OBG+') then begin
  //Display OBM in Geographical Position
  end
  else if (value = 'OBS+') then begin
  //Display OBM in Surface Grid Position
  end
  else if (value = 'SIM+') then begin
  //Start Simulation
  end
  else if (value = 'SIM-') then begin
  //Stop Simulation
  end
  else if (value = 'DRO+') then begin
  //Start Dead Reconning Own Ship
  end
  else if (value = 'DRO-') then begin
  //Stop Dead Reconning Own Ship
  end
  else if (value = 'STA+') then begin
  //Start Stationing Calculation
  end
  else if (value = 'STA-') then begin
  //Stop Stationing Calculation
  end
  else if (value = 'STD+') then begin
  //Inject Stationing Duration
  end
  else if (value = 'STS+') then begin
  //Inject Stationing Speed
  end
  else if (value = 'STM+') then begin
  //Inject Stationing Movement
  end
  else if (value = 'PTR+/-') then begin
  //Inject Powder Temperature Rockets
  end
  else if (value = 'TAS+') then begin
  // Inject True Air Speed
  end
  else if (value = 'REW+') then begin
  // Inject Relative Wind
  end
  else if (value = 'MAV+/-') then begin
  //Inject Magnetic Variation
  end
  else if (value = 'BAC+') then begin
  //Inject ballistic Correction
  end
  else if (value = 'TID+') then begin
  // Inject Time of Delay
  end
  else if (value = 'DRT+') then begin
  //Inject Dead Reconned Track
  end
  else if (value = 'SLT+') then begin
  //Send Link Transmissions Page
  end
  else if (value = 'LCN+') then begin
  //Inject Link Call Number
  end

  else if (value = 'PRC+') then begin
  //Allocate Private Code
  end
  else if (value = 'NEP+') then begin
  //Allocate New Position to Track
  end
  else if (value = 'IDA+') then begin
  //Allocate Identity Amplification
  end
  else if (value = 'IDS+') then begin
  //Allocate Identity Source
  end
  else if (value = 'HEI+') then begin
  //Allocate height to Air Track
  //Operator dapat memasukkan data ketinggian pada RAM atau DR Track sasaran udara
  end
  else if (value = 'TMD+') then begin
  //Allocate Tracking Mode Dead Rekonned
  end
  else if (value = 'CLA+') then begin
  //Allocate Classification to Sub Surface track
  end
  else if (value = 'PLA+') then begin
  //Allocate Plat Form to ESM fix
  end
  else if (value = 'TLI+') then begin
  //Allocate Two Letter Indication to R.P (Reference Position = REF POS)
  end
  else if (value = 'CPA+') then begin
  //Start Closed Point  of Approach Calculation
  end
  else if (value = 'CPA-') then begin
  //Stop Closed Point  of Approach Calculation
  end
  else if (value = 'NES+') then begin
  //Allocate New Station with Respect to Guide
  end
  else if (value = 'BKT+') then begin
  //Start Back track
  end
  else if (value = 'BKT-') then begin
  //Stop Back track
  end
  else if (value = 'TRA+') then begin
  //Start Threat Assisment
  end
  else if (value = 'TRA-') then begin
  //Stop Threat Assisment
  end;
  {
  [melihat jejak trak pada menit2 sebelumnya,max 8 menit]
  (TN)BKT+   --->
  [Klasifikasi kontak bawah air]
  (TN)CLA+ ***   ---> ***, UNC(unclasified),PRB(Probable submarine),CRT(Certain submarine).
  [haluan dan kecepatan dead reckoning]
  (TN)COS+ *** ****.*   ---> ***(haluan), ****.* (Kecepatan)
  [titik pertemuan terdekat terhadap suatu track]
  (TN)CPA+   --->
  [kedalaman menyelam]
  (TN) DEP+ ***   ---> ***, dalam meter,default 15meter
  [Track DR]
  DRT+ * (TN)   ---> *, A,S,U
  [kesalahan posisi DATUM]
  (TN)ERR+*  ---> *,kesalahan jarak
  [memberikan nilai ketinggian]
  (TN)HEI+***   ---> ***,ketinggian dalam 100feet
  [identitas tambahan]
  (TN)IDA+*   ---> *,semua huruf kecuali M,H,P
  [identitas sumber]
  (TN)IDS+*   ---> *, A(assumed),E(ESM),V(visual),I(IFF),U(unidenfied),R(radar)
  [nomor panggilan link]
  (TN)LCN+*****   --->*****, lima karakter angka
  [memindahkan posisi track]
  (TN)NEP +
  [posisi relatif terhadap titik tertentu]
  (TN)NES+*** **  --->***,baringan ** ,jarak
  [merubah nomor track]
  (TN)NTN+**** --->****,nomer track baru
  [menetapkan tipe platform]
  (TN)PLA+*   --->*, A,S,U,,N,L

  }
end;


procedure TfrmInjectionKeyBoard.AnduTDC16KeyPress(Sender: TObject;
  var Key: Char);
var s: string;
begin
  if Ord(Key) = VK_BACK	then begin
    s := Copy(AnduTDC16.Text, 1, Length(AnduTDC16.Text) -2);
    AnduTDC16.Text := s;
  end
  else
  if Ord(Key) = VK_RETURN	then begin
    btn_ExecuteClick(nil);
  end
  else
  begin
    AnduTDC16.Text := AnduTDC16.Text + UpperCase(Key) + ' ';
//    AnduTDC16.SelStart := length(AnduTDC16.Text);
    AnduTDC16.SelectAll;
  end;
  Mnemonic := RemoveSpace(AnduTDC16.Text);
  Key := #0;

end;

end.
