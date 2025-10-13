unit ufANDUKeyboard;

{
  ANDU keyBoard is for KRI Nala & Singa
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, ufKeyBoard, ImgList, ufANDUDisplay, uLibTDCClass;

type

  tRecTrackNumber = record
     sid, tNum : byte;
  end;

  TfrmANDUKey = class(TfrmKeyBoard)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected

  public
    { Public declarations }
    OBM : TTDC_Symbol;

    SParLine, CParLine, TParLine, VParLine : integer;

    SelTrackNum : tRecTrackNumber;

    function  ParseCommand(const str: string): integer; override;

    function  Do_NonTrack_Action(const ss: TStrings): integer;
    function  Do_Track_Action(const ss: TStrings): integer;

    function FindTrackByOBM(): boolean;

    procedure btn_RBClick(Sender: TObject);
  end;


implementation


{$R *.dfm}

uses
  StrUtils, uStringFunction, uBaseConstan, uBaseDataType, uBaseFunction, uDetected,
  uLibTDCTracks, uTorpedoTrack, uTrackFunction;


function IsValidLineNumber(const str: string; var lin: integer): boolean;
var code: integer;
begin
  Val(str, lin, code);
  result := (code = 0) and (lin > 0) and (lin < 15);
end;


function ConvertStrToLatLong(const sdy, smy, sdx, smx: string;
                          var dLat, dLong: double): boolean;
var s: string; //dd mm.m
    i1, len : integer;
    d1 : double;
    c: char;
begin
  result := false;

  if not ConvertToInt(sdy, i1) or (i1 > 90) then exit;
  len := Length(smy);
  s := Copy(smy , 1, len-1);
  c := smy[len];
  if not ConvertToFloat(s, d1) or (d1 > 59.9) then exit;
  if not (c in ['S', 'N']) then exit;
  if c = 'S' then
    dLat := -(i1 + d1/60.0)
  else
    dLat := i1 + d1/60.0;


  if not ConvertToInt(sdx, i1) or (i1 > 180) then exit;

  len := Length(smx);
  s := Copy(smx , 1, len-1);
  c := smx[len];
  if not ConvertToFloat(s, d1) or (d1 > 59.9) then exit;
  if not (c in ['E', 'W']) then exit;
  if c = 'W' then
    dLong := -(i1 + d1/60.0)
  else
    dLong := i1 + d1/60.0;

  result := true;
end;

function  TfrmANDUKey.Do_NonTrack_Action(const ss: TStrings): integer;
var i, i2, len: integer;
    d1, d2 : double;
    dx, dy : double;
    dt : TDateTime;
    b: byte;
    s, p1, p2 : string;
    sid, tn: byte;
    td : TTrackDomain;
    mTrack : TManualTrack;
    cTrack : TTDCTrack;
    cIdent : char;
    bFlag: boolean;
    tw, rw, cr : tVect2D;
    tpo : TTorpedoTrack;
begin
  result := 0;
  {#00}
////////////////////////////////////////////////////////////////////////////////
// MIK Display Selection - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  {#01}
  if ss[0] = 'PAG+' then  begin
//    result := -1;

    if ss[1] = 'G' then  Display.SelectPage(byte(ptGeneral))
    else if ss[1] = 'F' then Display.SelectPage(byte(ptFreeForm))
    else if ss[1] = 'LT' then Display.SelectPage(byte(ptLinkTransmit))
    else if ss[1] = 'LR' then Display.SelectPage(byte(ptLinkReceive));
    result := 1;
  end
  else
  {#02}
  if ss[0] = 'PAG-' then  begin
//    result := -2;
    Display.WipeActivePage;
    result := 2;
  end
  else
  {#03}
  if ss[0] = 'PAR+' then  begin
       // s, c , t, v
     result := -03;
     if ss.Count < 3 then exit;
     if length(ss[1]) <> 1 then exit;
     if not ConvertToInt(ss[2], i) or (i > 15) then exit;
     case ss[1][1] of
        'S' : begin
          SParLine := i;
          p1 := formatParS1();
          p2 := formatParS2();
          Display.SetTextPar(i, p1, p2);
        end;
        'C' : begin
          CParLine := i;
          p1 := formatParC1();
          p2 := formatParC2();
          Display.SetTextPar(i, p1, p2);

        end;
        'T' : begin
          TParLine := i;
          if not TDCInterface.GetTorpedoTrack(tpo) then exit;
          with (tpo.TargetTrack as  TManualTrack) do begin
            s := MergeTrackNumber(ShipTrackId, TrackNumber)
          end;

          p1 :=  formatParT1(s, tpo.Target.Distance * C_NauticalMiles_To_Yard,
            tpo.Target.Bearing, tpo.Target.Speed);

          p2 := formatParT2(tpo.PhpData.hitRange * C_NauticalMiles_To_Yard,
            tpo.PhpData.hitBearing,  tpo.PhpData.hitTime);

          Display.SetTextPar(i, p1, p2);

        end;
        'V' : begin
          VParLine := i;
          p1 := formatParV1();
          p2 := formatParV2();
          Display.SetTextPar(i, p1, p2);
        end;

     end;


     result := 03;
  end
  else
  {#04}
  if ss[0] = 'PAR-' then  begin
       // s, c , t, v
     if ss.Count < 2 then exit;
     if length(ss[1]) <> 1 then exit;
     case ss[1][1] of
        'S' : begin
          Display.SetTextPar(SParLine, '', '');
          SParLine := -1;
        end;
        'C' : begin
          Display.SetTextPar(CParLine, '', '');
          CParLine := -1;

        end;
        'T' : begin
          Display.SetTextPar(TParLine, '', '');
          TParLine := -1;
        end;
        'V' : begin
          Display.SetTextPar(VParLine, '', '');
          VParLine := -1;
        end;

     end;

  end
  else
  {#05}
  if ss[0] = 'FFL+' then  begin
    result := -5;
    if ss.Count < 3 then exit;
    Val(ss[1], b, i);
    if i <> 0 then exit;
    if (Display.CurrentPageIndex = byte(ptFreeForm)) or
    (Display.CurrentPageIndex = byte(ptLinkTransmit)) then
      s := '';
      for i := 2 to ss.Count-1  do
        s := s + ss[i] + ' ';
      Display.SetTextLine(b, s);
    result := 5;
  end
  else
  {#06}
  if ss[0] = 'SLL+' then  begin
    result := -6;
    if ss.Count < 2 then exit;
    Val(ss[1], b, i);
    if i <> 0 then exit;
    //aAir, bSurf, cSubSurf, dDatum, eESMFix, fRP, gAreaCurs:
    with TDCInterface do
      s := formatSLL(SystLoad[tdUdara].Count,
                     SystLoad[tdAtasAir].Count,
                     SystLoad[tdBawahAir].Count,
                     SystLoad[tdDatum].Count,
                     SystLoad[tdEW].Count,
                     SystLoad[tdRP].Count,
                     SystLoad[tdCursor].Count,
                     tdcData.LocalTime);

      Display.SetTextLineNumber(b, s);
    result := 6;
  end
  else
  {#07}
  if ss[0] = 'QGC+' then  begin
//    result := -7;
    s := formatGeoCoord(obm.mPos.X, obm.mPos.Y, TDCInterface.tdcData.LocalTime);
    Display.SetTextLineNumber(15, s);
    result := 7;
  end
  else
  {#08}
  if ss[0] = 'QSG+' then  begin
    result := -8;

    d1 := CalcBearing(TDCInterface.xSHIP.PositionX, TDCInterface.xSHIP.PositionY,
                     obm.mPos.X, obm.mPos.Y );

    d2 := CalcRange(TDCInterface.xSHIP.PositionX, TDCInterface.xSHIP.PositionY,
                     obm.mPos.X, obm.mPos.Y );

    if not Assigned(TDCInterface.SGO) then exit;

    TDCInterface.SGO.ConvertLatLongToSGO( obm.mPos.X, obm.mPos.Y, cIdent, dx, dy);


    s := formatGridCoord(d1, d2, dx, dy, cIdent);
    Display.SetTextLineNumber(15, s);

    result := -8;
  end
  else
  {#09}
  if ss[0] = 'QTW+' then  begin
//    result := -9;
    tw := TDCInterface.GetTrueWind;
    rw := TDCInterface.GetRealtiveWind;
    cr := TDCInterface.tdcData.SeaCurrent;

    s :=  formatQueryTW(tw.Course, tw.Speed, rw.Course, rw.Speed,
      cr.Course, cr.Speed);

    Display.SetTextLineNumber(15, s);
    result := 9;

  end
  else
  {#10}
  if ss[0] = 'LIN-' then  begin
    result := -10;
    Val(ss[1], b, i);
    if i <> 0 then exit;
    Display.SetTextLine(b, '');
    result := 10;
  end
  else
// NON Existing track - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//////////////////////////////////////////////////////////////////////////////

  {#11}
  if ss[0] = 'ARC+' then  begin
    result := -11;
    if ss.Count = 1 then begin
       TDCInterface.AddCursorFix;
       result := 11;

    end
    else if ss.Count = 2 then begin
  {#12 ARC+ tn}
      if IsValidTrackNumber(ss[1]) then begin
         SplitTrackNumber(ss[1], sid, tn);
         TDCInterface.AddCursorFixToTrack(sid, tn);
         result := 12;
      end;
    end;

  end
  else
  {#13}
  if ss[0] = 'REP+' then  begin
    result := -13;
    if TDCInterface.InitiateRefPos(OBM.mPos.X, OBM.mPos.Y, TDCInterface.GetLastTrackID(tdRP))
    then result := 13;
  end
  else
  {#14}
  if ss[0] = 'REP-' then  begin
    result := -14;
    if TDCInterface.FindTrack_by_screenpos(OBM.Center.X, OBM.Center.Y, cTrack) then
      if (cTrack is TRefPosTrack) then begin
        TDCInterface.WipeOnPosition(OBM.Center.X, OBM.Center.Y);
        result := 14;
      end;
  end
  else
  {#15}
  if ss[0] = 'SGO+' then  begin
    result := -14;
    if TDCInterface.initiateSurfaceGrid(OBM.mPos.X, OBM.mPos.Y)
    then
    result := 14;

  end
  else
  {#16}
  if ss[0] = 'TNB+' then  begin
    result := -16;
    if ss.Count < 2 then exit;
    if IsValidTrackNumber(ss[1]) then begin
      SplitTrackNumber(ss[1], sid, tn);
      if sid = 0 then begin
        TDCInterface.shipt_tid := tn;
        result := 16;
      end;
    end;
  end
  else
  {#17}
  if ss[0] = 'LOT+' then  begin
    result := -17;
    if ss.Count < 4 then exit;

    if not ConvertToInt(ss[1], i) or (i > 23) then exit;
    if not ConvertToInt(ss[2], i2) or (i2 > 59) then exit;
    if not ConvertToInt(ss[3], len) or (len > 59) then exit;

    dt := i + (i2/60.0) + (len/3600.0);
    TDCInterface.tdcData.LocalTime := dt;

    result := 17;
  end
  else
  {#18}
  if ss[0] = 'CUR+' then  begin
    result := -18;
    if ss.Count < 3 then exit;

    if not ConvertToInt(ss[1], i) or (i < 0) or (i>360)then exit;
    if not ConvertToFloat(ss[2], d1) or (d1< 0.0) or (d1 > 9.9) then exit;

    TDCInterface.tdcData.SeaCurrent.Course := i;
    TDCInterface.tdcData.SeaCurrent.Speed  := d1;

    result := 18;
  end
  else
  {#19}
  if ss[0] = 'OBG+' then  begin
    result := -19;
      if ss.Count < 5 then exit;
      if not ConvertStrToLatLong(ss[1], ss[2], ss[3], ss[4], d1, d2) then exit;
      if (d1 >= 60.0) or (d1 <= -60.0 ) then exit;
      OBM.mPos.X := d2;
      OBM.mPos.Y := d1;
    result := 19;
  end
  else
  {#20}
  if ss[0] = 'OBS+' then  begin
    result := -20;
    if ss.Count < 4 then exit;
    s := Trim(ss[1]);
    if length(s) <> 1 then exit;
    if not (s[1] in ['W', 'R', 'G', 'B' ])  then exit;
    if not ConvertToFloat(ss[2], d1) or (d1 < 0.0) or (d1 > 127.9) then exit;
    if not ConvertToFloat(ss[3], d2) or (d2 < 0.0) or (d2 > 127.9) then exit;

    if not Assigned(TDCInterface.SGO) then exit;

    TDCInterface.SGO.ConvertSGOToLatLong(s[1], d1, d2, dx, dy);
      OBM.mPos.X := dx;
      OBM.mPos.Y := dy;
    result := 20;
  end
  else
  {#21}
  if ss[0] = 'SIM+' then  begin

  end
  else
  {#22}
  if ss[0] = 'SIM-' then  begin

  end
  else
  {#23}
  if ss[0] = 'DRO+' then  begin
     result := -23;
     if ss.Count < 5 then exit;
     if not ConvertStrToLatLong(ss[1], ss[2], ss[3], ss[4], d1, d2) then exit;
     if (d1 >= 70.0) or (d1 <= -70.0 ) then exit;
      TDCInterface.SetDeadRecon(TRUE, d2, d1);

     result := 23;
  end
  else
  {#24}
  if ss[0] = 'DRO-' then  begin
//    result := -24;
    TDCInterface.SetDeadRecon(false, 0.0, 0.0);
    result := 24;
  end
  else
  {# 25}
  if ss[0] = 'STA+' then  begin

  end
  else
  {# 26}
  if ss[0] = 'STA-' then  begin

  end
  else
  {# 27}
  if ss[0] = 'STD+' then  begin

  end
  else
  {# 28}
  if ss[0] = 'STS+' then  begin

  end
  else
  {# 29}
  if ss[0] = 'STM+' then  begin

  end
  else
  {# 30}
  if ss[0] = 'PTR+' then  begin
    // ini salah, mestinya bisa pe te er plus minus
    result := -30;
    if ss.Count < 2 then exit;
    if not ConvertToInt(ss[1], i) then exit;
    if (i < -15) or (i > 45) then exit;  //centigrade.
    TDCInterface.tdcData.PowderTemp := i;

    result := 30;
  end
  else
  {# 31}
  if ss[0] = 'TAS+' then  begin
    result := -31;
    if ss.Count < 2 then exit;
    if not ConvertToInt(ss[1], i) then exit;
    if (i < 0) or (i > 999) then exit;  // DM/hr
    TDCInterface.VecData.TrueAirSpeed := i;

    result := 31;

  end
  else
  {# 32}
  if ss[0] = 'REW+' then  begin
    result := -32;
    if ss.Count < 3 then exit;
    if not ConvertToInt(ss[1], i) then exit;
    if not ConvertToInt(ss[2], i2) then exit;

    TDCInterface.setRelatifWind(i, i2);

    result := 32;
  end
  else
  {# 33}
  if ss[0] = 'MAV+' then  begin

  end
  else
  {# 34}
  if ss[0] = 'BAC+' then  begin

  end
  else
  {# 35}
  if ss[0] = 'TID+' then  begin
    result := -35;
    if ss.Count < 2 then exit;
    if not ConvertToInt(ss[1], i) then exit;
    if (i<0) or (i > 59)  then exit;  // second

    TDCInterface.tdcData.DelayTime := i;

    result := 35;
  end
  else
  {# 36}
  if ss[0] = 'DRT+' then  begin
    result := -36;
    if  ss.Count >= 2 then begin
      bFlag  := false;
      case ss[1][1] of
        'A' : begin
          td     := tdUdara;
          cIdent := ID_Udara_Unknown;
          bFlag  := true;
        end;
        'S' : begin
          td     := tdAtasAir;
          cIdent := ID_AtasAir_Unknown;
          bFlag  := true;
        end;
        'U' : begin
          td     := tdBawahAir;
          cIdent := ID_BawahAir_Unknown;
          bFlag  := true;
        end;
      end;
      if bFlag then begin
        TDCInterface.CreateDefaultMTrack(mTrack, OBM.mPos.X, OBM.mPos.Y);
        if TDCInterface.InitMTrackIdent(mTrack, cIdent) then begin
          mTrack.SetAmplifyingInfo_1(aiDRTTrack);
          if (ss.Count = 3) and  IsValidTrackNumber(ss[2])then begin
             SplitTrackNumber(ss[2], sid, tn);
             mTrack.SetTrackNumber(sid, tn);
          end
          else begin
             sid := TDCInterface.shipt_tid;
             tn := TDCInterface.GetLastTrackID(td);
             mTrack.SetTrackNumber(sid, tn);
          end;
          result := 36;
        end;
      end;
    end;
  end
  else
  {# 37}
  if ss[0] = 'SLT+' then  begin

  end
  else
  {# 38}
  if ss[0] = 'LCN+' then  begin

  end

(*
  else
  {# 0}
  if ss[0] = '+' then  begin
  end
*)

end;

function TfrmANDUKey.Do_Track_Action(const ss: TStrings): integer;
var  sid, tn: byte;
     w: Word;
     hh, nn : Word;
     c: char;
     mTrack : TManualTrack;
     cTrack : TTDCTrack;
     dtTrack : TDatumTrack;
     esfTrack: TESMFixTrack;
     rp       : TRefPosTrack;

     spd, course, maxSpd : double;
     linNum : integer;
     str : string;
begin
  result := 0;

  if IsValidTrackNumber(ss[0]) then begin
    SplitTrackNumber(ss[0], sid, tn);

    if not TDCInterface.FindTDCTrack_by_trackID(sid, tn, cTrack) then exit;
    if cTrack is TManualTrack then
      mTrack := cTrack as TManualTrack
    else
      mTrack := nil;
  end
  else exit;

  {# 07}
  {# 39}
  if ss[1] = 'SCR+' then  begin
    result := -39;
    if ss.Count > 2 then begin
      if IsValidLineNumber(ss[2], linNum) then begin
        if (mTrack <> nil) then begin
          case  mTrack.Domain of
            tdAtasAir,
            tdUdara   : begin
              str := formatSCR_track_AS(mTrack);
              Display.SetTextLineNumber(linNum, str);

              result := 39;
            end;
            tdBawahAir : begin
              str := formatSCR_track_U(mTrack);
              Display.SetTextLineNumber(linNum, str);

              result := 39;
            end;
          end;
        end
        else if cTrack is TDatumTrack then begin
           dtTrack := cTrack as TDatumTrack;
           str := formatSCR_datum(dtTrack, TDCInterface.tdcData.LocalTime);
           Display.SetTextLineNumber(linNum, str);
        end
        else if cTrack is TESMFixTrack then begin
           str := formatSCR_ESMFix(cTrack, TDCInterface.tdcData.LocalTime);

           Display.SetTextLineNumber(linNum, str);
        end
        else if cTrack is TESMBearingTrack then begin
           str := formatSCR_ESMBear(cTrack, TDCInterface.tdcData.LocalTime);
           Display.SetTextLineNumber(linNum, str);
        end
        else if cTrack is TRefPosTrack then begin
           str := formatSCR_RP(cTrack);
           Display.SetTextLineNumber(linNum, str);
        end

       end
    end
  end
  else
  {# 40}
  if ss[1] = 'NTN+' then  begin
    result := -40;
    if IsValidTrackNumber(ss[2]) then begin
      SplitTrackNumber(ss[2], sid, tn);

      cTrack.SetTrackNumber(sid, tn);
      //netsend
    result := 40;
    end
  end
  else
  {# 41}
  if ss[1] = 'NEP+' then  begin
//    result := -41;
    cTrack.SetPosition(OBM.mPos.X, OBM.mPos.Y);
    result := 41;
  end
  else
  {# 42}
  if ss[1] = 'PRC+' then  begin
    result := -42;

    if ss.Count >= 3 then begin
      if Length(ss[2]) > 5 then
        cTrack.PrivateCode := Copy(ss[2], 1, 5)
      else
        cTrack.PrivateCode := ss[2];

      result := 42;
    end
    else
      if ss.Count = 2 then begin
        cTrack.PrivateCode := '';

        result := 42;
      end;
  end
  else
  {# 43}
  if ss[1] = 'IDA+' then  begin
     // U, H, F
     result := -43;
     if ss.Count < 3 then exit;
     if length(ss[2]) <> 1 then exit;
     if mTrack = nil then exit;
     str := ss[2];
     if not IsValidIdentAmplification(str[1]) then exit;
     C := ChangeTrackIdentByIDA(mtrack.GetIdent, str[1]);
     mTrack.SetIdent(c);
     result := 43;
  end
  else
  {# 44}
  if ss[1] = 'IDS+' then  begin
     result := -44;
     //A, E, V, I, U, R
     if ss.Count < 3 then exit;
     if length(ss[2]) <> 1 then exit;
     str := ss[2];
     if not IsValidIdentSource(str[1]) then exit;
     if mTrack = nil then exit;
     if (mTrack.Domain = tdUdara) or (mTrack.Domain = tdAtasAir) then begin
       mtrack.IdentSource := str[1];
       result := 44;
     end;

  end
  else
  {# 45}
  if ss[1] = 'COS+' then  begin
    result := -45;

    // menurut buku cuma drt yg bisa di set speed & course
    if ss.Count < 4 then exit;
    try
      course   := StrToInt(ss[2]);
      spd      := StrToFloat(ss[3]);
    except
      On EConvertError do begin
        exit;
      end;
    end;

    if cTrack is TRefPosTrack then begin
      rp := cTrack as TRefPosTrack;
      if (Course >= 0.0) and (course < 360.0) then begin
        rp.Course := course;
        rp.Speed  := spd;
        result := 45;
        exit;
      end
    end;

    if mTrack = nil then  exit;
    if (mTrack.TrackType = aiDRTTrack)
    or (mTrack.TrackType = aiRAMTrack) then begin
      if (Course >= 0.0) and (course < 360.0) then begin
        mTrack.Course := course;
        result := 45;
      end;

      if mTrack.Domain = tdudara then
        maxSpd  := 1500
      else
        maxSpd  := 100;
      if (spd >= 0) and (spd < maxSpd) then begin
        mTrack.Speed  := spd;
        result := 45;
      end;
    end;
  end
  else
  {# 46}
  if ss[1] = 'HEI+' then  begin
    result := -46;
    if mTrack = nil then exit;
    if ss.Count < 3 then exit;
    if mTrack.Domain = tdUdara then begin
      if ConvertToWord(ss[2], w) and (w < 1000) then begin
        mTrack.FlightLevel := w;
        result := 46;
      end;
    end;
  end
  else
  {# 47}
  if ss[1] = 'TMD+' then  begin
    result := -47;
    if mTrack <> nil then begin
       mTrack.SetAmplifyingInfo_1(aiDRTTrack);
       result := 47;
    end;
  end

  else
  {# 48}
  if ss[1] = 'CLA+' then  begin
    result := -48;
    if ss.Count < 3 then exit;
    if (mTrack = nil) or (mTrack.Domain <> tdBawahAir) then exit;
    if  IsValidSubClassif(ss[2]) then exit;
    mTrack.SubClassification := ss[2];
    result := 48;

  end
  else
  {# 49}
  if ss[1] = 'DEP+' then  begin
    if mTrack = nil then exit;
    if ss.Count < 3 then exit;
    if mTrack.Domain = tdBawahAir then begin
      if ConvertToWord(ss[2], w) and (w < 400) then begin
        mTrack.Height := - C_Meter_To_Feet * w;
        result := 49;
      end;
    end;

  end
  else
  {# 50}
  if ss[1] = 'ERR+' then  begin
    if ss.Count < 3 then exit;
    if(cTrack is TDatumTrack)
      and ConvertToWord(ss[2], w )
      and (w < 10) then begin
        (cTrack as  TDatumTrack).Error := w;
      result := 50;
    end;

  end
  else
  {# 51}
  if ss[1] = 'SOU+' then  begin
    if ss.Count < 3 then exit;
    str := ss[2];
    if cTrack is TDatumTrack and
      IsValidDatumSource(str) then begin
      (cTrack as  TDatumTrack).DatumSource := str;
      Result := 51;
    end;
  end
  else
  {# 52}
  if ss[1] = 'SPE+' then  begin
    if cTrack is TDatumTrack then begin
      if ConvertToFloat(ss[2], spd) and (spd < 100) then begin
        cTrack.Speed := spd;
        Result := 52;
      end;
    end;
  end
  else
  {# 53}
  if ss[1] = 'TIM+' then  begin
    Result := -53;
    if ConvertToWord(ss[2], hh) and  ConvertToWord(ss[3], nn) then begin
      if (hh < 24) and (nn < 60) and (cTrack is TDatumTrack) then begin
        (cTrack as TDatumTrack).LastTime := ((nn/60) + hh)/24;
        Result := 53;
      end;
    end;

  end
  else
  {# 54}
  if ss[1] = 'PLA+' then  begin
    result := -54;
    if ss.Count < 3 then exit;
    str := trim(ss[2]);
    if Length(str) <> 1 then exit;
    if  IsValidPlatformID(str[1] ) and (cTrack is TESMFixTrack) then begin
      esfTrack := (cTrack as TESMFixTrack);
      esfTrack.PlatformID := str[1];
      result := 54;
    end
  end

  else
  {# 55}
  if ss[1] = 'TLI+' then  begin
    if ss.Count < 3 then exit;
    if (cTrack is TRefPosTrack) then begin
      if IsValidTwoLetterIndication(ss[2]) then
        (cTrack as TRefPosTrack).TLI := ss[2];
    end;

  end
  else
  {# 56}
  if ss[1] = 'CPA+' then  begin

  end
  else
  {# 57}
  if ss[1] = 'CPA-' then  begin

  end
  else
  {# 58}
  if ss[1] = 'VEC+' then  begin

  end
  else
  {# 59}
  if ss[1] = 'VEC-' then  begin

  end
  else
  {# 60}
  if ss[1] = 'NES+' then  begin

  end
  else
  {# 61}
  if ss[1] = 'BKT+' then  begin
     if mTrack = nil then exit;
     TDCInterface.SetBackTracking(True, mTrack);

  end
  else
  {# 62}
  if ss[1] = 'BKT-' then  begin
     if mTrack = nil then exit;
     TDCInterface.SetBackTracking(false, mTrack);

  end

  else
  {# 63}
  if ss[1] = 'TRA+' then  begin
     result := -62;
     if mTrack <> nil then begin
       mTrack.SetThreadAssesment(TDCInterface.SelectedThreatAsses);
       mTrack.ThreatAssestVisible := TRUE;
       result := 62;
     end;
  end
  else
  {# 64}
  if ss[1] = 'TRA-' then  begin
     if mTrack <> nil then
     mTrack.SetThreadAssesment(-1);
     mTrack.ThreatAssestVisible := FALSE;
  end
  else
  if ss[1] = '+' then  begin

  end
end;

function TfrmANDUKey.ParseCommand(const str: string): integer;
var ss : TStrings;
begin
//  History.Add(str);
  result := 0;
  ss := TStringList.Create;
  Split(' ', Trim(str), ss);
  if ss.Count < 1 then exit;

  if ss.Count > 1 then begin
    if ss[0] = 'LOAD' then begin
       if (ss.Count < 2) then exit;
       LoadScript(ss[1]);
    end
    else begin
      if IsValidTrackNumber(ss[0]) then
         result := Do_Track_Action(ss)
      else
        result := Do_NonTrack_Action(ss);
    end;
  end
  else                                                           

    result := Do_NonTrack_Action(ss);

  ss.Clear;
  ss.Free;
end;

function TfrmANDUKey.FindTrackByOBM(): boolean;
var cTrack : TTDCTrack;
   s : string;
begin
  result := TDCInterface.FindTrack_by_screenpos(OBM.Center.X, OBM.Center.Y, cTrack);
  if result then begin
    SelTrackNum.sid  := cTrack.ShipTrackId;
    SelTrackNum.tNum := cTrack.TrackNumber;
    s := MergeTrackNumber(SelTrackNum.sid, SelTrackNum.tNum);
    Mnemonic := S;
    Display.SetTextLine(16, s);
  end
end;


procedure TfrmANDUKey.FormCreate(Sender: TObject);
begin
  inherited;
  
  TParLine := -1;
  SParLine := -1;
  VParLine := -1;
  CParLine := -1;
end;

procedure TfrmANDUKey.btn_RBClick(Sender: TObject);
begin
  FindTrackByOBM;
end;

end.
