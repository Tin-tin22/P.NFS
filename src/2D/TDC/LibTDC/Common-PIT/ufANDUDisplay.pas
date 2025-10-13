unit ufANDUDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  tPageType = (ptGeneral, ptFreeForm, ptLinkTransmit, ptLinkReceive);
  tExecuteEvent = procedure (const s: string) of object;

  TfrmANDUDisplay = class(TForm)
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
    tmrCursor: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AnduTDC16KeyPress(Sender: TObject; var Key: Char);
    procedure tmrCursorTimer(Sender: TObject);
  private
    { Private declarations }
    FNumOfPage  : byte;
  public
    { Public declarations }

     ANDULines : array[1..16] of TEdit;
     DRL,                  //Data Request Line
     ICL : TEdit;          //Input Check Line

     LastPageIndex    : byte;
     CurrentPageIndex : byte;
     SPage: array of TStrings;

     StrCmd: string;
     ICLText : string;
     ICL_Blink : boolean;

     procedure SetTextLine(const line: byte; const text: string);

     procedure SetTextLineNumber(const line: byte; const text: string);
     procedure SetTextLineCol(const line, col: byte; const text: string);
     procedure SetTextPar(const line: byte; const text1, text2: string);

     procedure SetICLText(const s: string);
     procedure SetDRLText(const s: string);

     // page management

     procedure SetNumOfPage(const b: byte);

     procedure WipeActivePage;
     procedure SaveCurrentPage(var ss: TStrings);
     procedure ReloadPage(const ss: TStrings);
     procedure SelectPage(pgIndex: byte); virtual;
  public
     FOnExecuteCmd : tExecuteEvent;

     property NumOfPage: Byte read FNumOfPage write SetNumOfPage;
  end;

{var
  frmANDUDisplay: TfrmANDUDisplay;
}
implementation

uses
  uStringFunction, StrUtils;

{$R *.dfm}


procedure TfrmANDUDisplay.SetTextLine(const line: byte; const text: string);
begin
  if (line >=1) and (line <= 16) then
    ANDULines[line].Text := text;
end;

procedure TfrmANDUDisplay.SetTextLineNumber(const line: byte; const text: string);
var s, ss :string;
begin
  if (line >=1) and (line <= 16) then begin
    ss := text;
    s :=  FormatFloat('00', line);
    OverwriteString( ss, s, 1);
    ANDULines[line].Text := ss;
  end;
end;

procedure TfrmANDUDisplay.SetTextPar(const line: byte; const text1, text2: string);
var s, ss :string;
begin
  if (line >=1) and (line < 16) then begin
    ss := text1;
    s :=  FormatFloat('00', line);
    OverwriteString( ss, s, 1);
    ANDULines[line].Text   := ss;

    ss := text2;
    s :=  FormatFloat('00', line+1);
    OverwriteString( ss, s, 1);
    ANDULines[line+1].Text := ss;
  end;
end;

procedure TfrmANDUDisplay.SetICLText(const s: string);
begin
  ICLText := s;
  ICL.Text := s;
  ICL.SelStart := 0;
  ICL.SelLength := length(ICL.Text);
end;

procedure TfrmANDUDisplay.SetDRLText(const s: string);
begin
  DRL.Text := s + '';
end;

procedure TfrmANDUDisplay.SetTextLineCol(const line, col: byte; const text: string);
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

procedure TfrmANDUDisplay.SetNumOfPage(const b: byte);
var i: byte;
begin
  FNumOfPage := b;
  LastPageIndex    := 0;
  CurrentPageIndex:= 0;
  SetLength(SPage, b);

  for i := 0 to b-1 do begin
    if not Assigned(SPage[i]) then
      SPage[i] := TStringList.Create
    else
      SPage[i].Clear;
  end;

end;

procedure TfrmANDUDisplay.WipeActivePage;
var i: integer;
begin
  for i := 1 to 16 do
    ANDULines[i].Text := '';
end;

procedure TfrmANDUDisplay.SaveCurrentPage(var ss: TStrings);
var i: integer;
begin
  ss.Clear;
  for i := 1 to 16 do
    ss.Add(ANDULines[i].Text);
end;

procedure TfrmANDUDisplay.ReloadPage(const ss: TStrings);
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


procedure TfrmANDUDisplay.SelectPage(pgIndex: byte);
begin
  if pgIndex = CurrentPageIndex then exit;

  SaveCurrentPage(sPage[CurrentPageIndex]);
  ReloadPage(sPage[pgIndex]);

  LastPageIndex    := CurrentPageIndex;
  CurrentPageIndex := pgIndex;
end;


procedure TfrmANDUDisplay.FormCreate(Sender: TObject);
begin
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

  SetNumOfPage(1);
  CurrentPageIndex := 0;

//  SetTextLine(01, '0         1         2         3');
//  SetTextLine(02, '012345678901234567890123456789012');

end;

procedure TfrmANDUDisplay.FormDestroy(Sender: TObject);
var p: byte;
begin
  for p := 0 to NumOfPage-1 do begin
    SPage[p].Clear;
    SPage[p].Free;
  end;
end;

procedure TfrmANDUDisplay.AnduTDC16KeyPress(Sender: TObject;
  var Key: Char);
var s: string;
   iKey : integer;
begin
  iKey := Ord(Key);
  if iKey = VK_BACK	then begin
    s := Copy(AnduTDC16.Text, 1, Length(AnduTDC16.Text) -1);

    SetICLText(s);
  end
  else
  if iKey = VK_RETURN	then begin
    if Assigned(FOnExecuteCmd) then begin

      StrCmd := ICLText;
      FOnExecuteCmd(StrCmd);
    end;
  end

  else
  begin
    AnduTDC16.Text := AnduTDC16.Text + UpperCase(Key);
    AnduTDC16.SelectAll;
  end;
  StrCmd := AnduTDC16.Text;
  Key := #0;


end;


procedure TfrmANDUDisplay.tmrCursorTimer(Sender: TObject);
begin
  ICL_Blink := not ICL_Blink;
  if ICL_Blink then
    ICL.Text := ICLText
  else
    ICL.Text := ICLText + '*';

end;

end.
