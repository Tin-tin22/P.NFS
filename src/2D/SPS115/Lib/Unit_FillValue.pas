unit Unit_FillValue;

interface

uses Windows, Messages, SysUtils, Variants, Classes, StdCtrls, ExtCtrls,
  Unit_dataObject, uTCPDatatype;

type
  TCBB = (cbb_IsrMd1, cbb_AceMd1, cbb_CeiSH, cbb_FloSH, cbb_IsdSH, cbb_CeiDP,  cbb_FloDP, cbb_IsdDP, cbb_IsrMd3, cbb_AceMd3 );

procedure FillCBB(ComB:TCBB; Cbb:tcombobox);
procedure ClearTargetData(var LTD :TgtDataRec);
procedure MaxVal(edt: TEdit; val :Double);

implementation

procedure FillCBB(ComB:TCBB; Cbb:tcombobox);
var val,up,i,n:Integer;
begin
  Cbb.Items.Clear;

  case ComB of
    cbb_IsrMd1: begin
       val:=0;
       up:=600;
       n:=7;
    end;
    cbb_AceMd1: begin
       val:=0;
       up:=1200;
       n:=3;
    end;
    cbb_CeiSH: begin
       val:=4;
       up:=6;
       n:=1;
    end;
    cbb_CeiDP: begin
       val:=20;
       up:=30;
       n:=1;
    end;
    cbb_FloSH: begin
       val:=20;
       up:=20;
       n:=3;
    end;
    cbb_FloDP: begin
       val:=100;
       up:=100;
       n:=3;
    end;
    cbb_IsdSH: begin
       val:=10;
       up:=10;
       n:=7;
    end;
    cbb_IsdDP: begin
       val:=50;
       up:=50;
       n:=7;
    end;
    cbb_IsrMd3: begin
       val:=0;
       up:=1200;
       n:=7;
    end;
    cbb_AceMd3: begin
       val:=0;
       up:=2400;
       n:=3;
    end;
  end;
  for i := 0 to n do begin
    Cbb.Items.Add(IntToStr(val));
    val:=val+up;
  end;

  Cbb.ItemIndex:=0;

end;

procedure ClearTargetData(var LTD :TgtDataRec);
begin
    LTD.Tn :=0;
    LTD.Rng:=0;
    LTD.Brg:=0;
    LTD.Crs:=0;
    LTD.Spd:=0;
end;
procedure MaxVal(edt: TEdit; val :Double);
begin
   if Length(edt.Text)<1 then
    edt.Text := '0';

   //edt.Text := FloatToStr(StrToFloat(edt.Text));

   if StrToFloat(edt.Text) > val then
   edt.Text := FloatToStr(val);
end;



end.
