unit uStringFunction;

interface

uses
  Classes;


  procedure  Split(const delimiter, S: string; var chunks: TStrings);
  procedure  Split_2(const delimiter, S: string; var chunks: TStrings);

  function InsertSpace(const str: string):string;
  function RemoveSpace(const str: string):string;
  function FillSpace(const n: byte): string;

  procedure OverwriteString(var s: string; const sub: string; const start: integer);

  function MergeSpaceString(const s1, s2: string): string;


implementation

uses
  SysUtils, StrUtils;

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

procedure  Split_2(const delimiter, S: string; var chunks: TStrings);
var i, l : integer;
  sub :string;
begin
  chunks.Clear;
  l := Length(S);
  i := 1;
  while (i <= l)  do  begin
     sub := '';
     while (i <= l) and not IsDelimiter(delimiter,S,i) do begin
       if (s[i]<> char(10)) and (s[i] <> char(13)) then
         sub := sub + s[i];   //^&^
       inc(i);
     end;
     sub := trim(sub);
     if sub <> '' then
       chunks.Append(sub);
     inc(i);
  end;
end;

function InsertSpace(const str: string):string;
//var i: integer;
begin
  result := str;
 {  result := '';
  for i := 0 to length(str)-1 do
     result := result +  str[i+1] + ' ';
}
end;

function RemoveSpace(const str: string):string;
//var i, m: integer;
begin
  result := str;
{  result := '';
  m := length(str) div 2;
  for i := 1 to m do
     result := result +  str[2*i-1];
}end;

function FillSpace(const n: byte): string;
var i: integer;
begin
  result := '';
  for i := 1 to n do begin
    result := result + ' ';
  end;
end;

procedure OverwriteString(var s: string; const sub: string; const start: integer);
var i, l1, l2 : integer;
begin
  l1 := Length(s);
  l2 := length(sub);
  if (start + l2) > l1 then
    s := s + FillSpace(start + l2 - l1 -1);

  for i := 1 to l2 do begin
    s[start+i-1] := sub[i];
  end;
end;


function MergeSpaceString(const s1, s2: string): string;
var i, l, l1, l2: integer;
begin
  l1 := Length(s1);
  l2 := Length(s2);
  if l1 < l2 then
    l := l1
  else
    l := l2;

  result := s1;
  for i := 1 to l do begin
    if s2[i] = ' ' then
      result[i] := s1[i]
    else
      result[i] := s2[i];
  end;

  if l1 < l2 then begin
    inc (l1);
    for i := l1 to l2 do
      result := result +  s2[i];
  end;
end;

end.
