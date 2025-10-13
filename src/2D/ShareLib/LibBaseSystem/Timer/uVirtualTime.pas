unit uVirtualTime;
  (*-------------------------------------------------------------------------
    --  Main Thread Timer class definition  for ECM ECCM Radar Simlulator  --
    -------------------------------------------------------------------------
    -- unit name   :                                       --
    -- description :                                                       --
    -- requirement :                             --
    -------------------------------------------------------------------------
    ..  First Created : 02 Juni 2005      ..
    ..  Finished      :                   ..
    ..  by            : andySu            ..
    ........................................
   *)

interface

  uses
    SysUtils;

  type


//==============================================================================
(* TVirtualTime
    { 13 Augustus 2007
      - ubah counter dari LongWord (FMillisecond) dengan double;
      - ubah increaseMillisecond jadi double, untuk mengakomodasi
        QueryPerformaceCounter;
      ! next update: ubah counter jadi tDateTime !
    }
    { 02 Juni 2005
      limited for 49 days. (MaxLongWord millisecond);
    }
*)

  TVirtualTime  = class
  protected
    FMsCounter      : double;
    FMilliSecond    : LongWord;
    FDateTimeOffset : TDateTime;

  public
    constructor Create;
    destructor Destroy; override;

    procedure IncreaseMillisecond(const aMs: double);

    procedure Reset(const aMs: double = 0.0);

    function GetTime : TDateTime;
    function GetMillisecond : LongWord;

    property DateTimeOffset: TDateTime read FDateTimeOffset  write FDateTimeOffset;
  end;


implementation


//==============================================================================
{ TVirtualTime }



constructor TVirtualTime.Create;
begin
  FDateTimeOffset := Now;
end;

destructor TVirtualTime.Destroy;
begin

  inherited;
end;

function TVirtualTime.GetMillisecond: LongWord;
begin
  result := FMilliSecond;
end;

function TVirtualTime.GetTime: TDateTime;
var dt: TDateTime;
    ms, s, n, h : word;
    ns, detik : Cardinal;
begin
  //VirtualTick in millisecond;

  detik := FMilliSecond div 1000;
  ms    := FMilliSecond mod 1000;
  s  := detik mod 60;
  ns := detik div 60;
  n  := ns mod 60;
  ns := ns div 60;
  h  := ns mod 24;

  dt := EncodeTime(h,n,s, ms);

  result := dt + FDateTimeOffset;
end;

procedure TVirtualTime.IncreaseMillisecond(const aMs: double);
begin
  FMscounter   := FMscounter + aMs;
  FMilliSecond := Round(FMscounter);
end;

procedure TVirtualTime.Reset(const aMs: double = 0.0);
begin
  FMscounter   := aMs;
  FMilliSecond := Round(FMscounter);
end;

end.
