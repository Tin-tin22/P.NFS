unit uVirtualTime;

{
-=-- did Simulation Framework  -----=-
  desc     : Class untuk simulasi game time.
  lastedit : 2012 02 24

-=-------------------------------------------------------=-
}

interface

uses
  SysUtils;

type

//==============================================================================

  TVirtualTime = class
  protected
    FMsCounter  : double;
    FMilliSecond: LongWord;
    FDateTimeOffset: TDateTime;

  public
    constructor Create;
    destructor Destroy; override;

    procedure IncreaseMillisecond(const aMs: double);

    procedure Reset(const aMs: double = 0.0);

    function GetTime: TDateTime;
    function GetMillisecond: LongWord;
    procedure SetMilliSecond(const aMs: LongWord);

    property DateTimeOffset: TDateTime read FDateTimeOffset write FDateTimeOffset;
  end;


implementation

//==============================================================================
{ TVirtualTime }

constructor TVirtualTime.Create;
begin
  FDateTimeOffset := Now;
  FMilliSecond := 0;
  FMsCounter := 0.0;
end;

destructor TVirtualTime.Destroy;
begin

  inherited;
end;

function TVirtualTime.GetMillisecond: LongWord;
begin
  result := FMilliSecond;
end;

procedure TVirtualTime.SetMilliSecond(const aMs: LongWord);
begin
  FMscounter := aMs;
  FMilliSecond := aMs;
end;

function TVirtualTime.GetTime: TDateTime;
var
  dt: TDateTime;
  ms, s, n, h: word;
  ns, detik: Cardinal;
begin
  //VirtualTick in millisecond;

  detik := FMilliSecond div 1000;
  ms    := FMilliSecond mod 1000;
  s     := detik mod 60;
  ns    := detik div 60;
  n     := ns mod 60;
  ns    := ns div 60;
  h     := ns mod 24;

  dt := EncodeTime(h, n, s, ms);

  result := dt + FDateTimeOffset;
end;

procedure TVirtualTime.IncreaseMillisecond(const aMs: double);
begin
  FMscounter := FMscounter + aMs;
  FMilliSecond := Round(FMscounter);
end;

procedure TVirtualTime.Reset(const aMs: double = 0.0);
begin
  FMscounter := aMs;
  FMilliSecond := Round(FMscounter);
end;


end.
