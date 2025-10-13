unit uThreadSafeQueue;

interface

uses
  System.SysUtils,
  System.SyncObjs;

type
  PQueueNode = ^TQueueNode;

  TQueueNode = record
    Value: TBytes;
    Next: PQueueNode;
    Prev: PQueueNode;
  end;

  TThreadSafeQueue = class
  private
    FCount: Integer;
    FHead: PQueueNode;
    FTail: PQueueNode;
    FCriticalSection: TCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Enqueue(Value: TBytes);
    function Dequeue: TBytes;
    function IsEmpty: Boolean;
    procedure Clear;

    property Count: Integer read FCount;
  end;

implementation

constructor TThreadSafeQueue.Create;
begin
  inherited;
  FCount := 0;
  FCriticalSection := TCriticalSection.Create;
end;

destructor TThreadSafeQueue.Destroy;
begin
  Clear;
  FCriticalSection.DisposeOf;
  inherited;
end;

procedure TThreadSafeQueue.Clear;
begin
  while not IsEmpty do
    Dequeue;
end;

procedure TThreadSafeQueue.Enqueue(Value: TBytes);
var
  NewTail: PQueueNode;
begin
  FCriticalSection.Enter;
  try
    New(NewTail);
    NewTail.Value := Value;
    NewTail.Next := nil;
    if FTail <> nil then
    begin
      FTail.Next := NewTail;
      NewTail.Prev := FTail;
    end
    else
      FHead := NewTail;
    FTail := NewTail;
    FCount := FCount + 1;
  finally
    FCriticalSection.Leave;
  end;
end;

function TThreadSafeQueue.Dequeue: TBytes;
var
  OldHead: PQueueNode;
begin
  Result := nil;
  if IsEmpty then
    Exit;
  FCriticalSection.Enter;
  try
    OldHead := FHead;
    FHead := OldHead.Next;
    if FHead <> nil then
      FHead.Prev := nil
    else
      FTail := nil;

    Result := OldHead.Value;
    Dispose(OldHead);
    FCount := FCount - 1;
  finally
    FCriticalSection.Leave;
  end;
end;

function TThreadSafeQueue.IsEmpty: Boolean;
begin
  FCriticalSection.Enter;
  try
    Result := FHead = nil;
  finally
    FCriticalSection.Leave;
  end;
end;

end.
