unit uBaseInterleaver;

interface

uses
 Classes;

type

  tInterLeaver = class
    Counter, Cycle : Integer;
  private
    FOnAction: TNotifyEvent;
    procedure SetOnAction(const Value: TNotifyEvent);

  public
    constructor Create;
    procedure  Step();
    property OnAction : TNotifyEvent read FOnAction write SetOnAction;
  end;

  tDelayer = class
  private
    FOnAction: TNotifyEvent;
    FAccum, FDelay : double;

    procedure SetOnAction(const Value: TNotifyEvent);
    function getDelay: Word;
    procedure setDelay(const Value: Word);

  public
    constructor Create;
    procedure  Step(const dt: double); // millisecond
    property OnAction : TNotifyEvent read FOnAction write SetOnAction;
    property Delay: Word read getDelay write setDelay; // miliseccond
    property Accum:Double read FAccum write FAccum;
  end;

  
implementation

{ tInterLeaver }

constructor tInterLeaver.Create;
begin
   Counter := 0;
   Cycle   := 0;
end;

procedure tInterLeaver.SetOnAction(const Value: TNotifyEvent);
begin
  FOnAction := Value;
end;

procedure tInterLeaver.Step;
begin
  if (Counter = 0) or (Cycle = 0) then
    if Assigned(FOnAction) then FOnAction(self);

 if  Cycle > 0 then
     Counter := (Counter + 1) mod Cycle;
end;

{ tDelayer }

constructor tDelayer.Create;
begin
  FAccum := 0.0;

end;

function tDelayer.getDelay: Word;
begin
  result := Round (FDelay)
end;

procedure tDelayer.setDelay(const Value: Word);
begin
   FDelay := Value;
end;

procedure tDelayer.SetOnAction(const Value: TNotifyEvent);
begin
  FOnAction := Value;
  FAccum := 0.0;
end;

procedure tDelayer.Step(const dt: double);
var dx: double;
begin
  FAccum := FAccum + dt;
  if FAccum > FDelay then begin
    FAccum := FAccum - FDelay;
    if Assigned(FOnAction) then FOnAction(self);
  end;

end;

end.
