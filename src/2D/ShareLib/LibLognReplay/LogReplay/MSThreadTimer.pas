unit MSThreadTimer;

(* -= Master Slave Timer =-
   . Timer terbuat dari TThread,
   . Sleep(Interval);
   . Untuk eksekusi 'OnTimer', buat thread lain (TSlaveThread)

   { Created: 15 Maret 2005
           by andySu }
*)

interface

uses
  Classes, Windows;

type

//==============================================================================
  TSlaveThread = class(TThread)
  private
    FOnExecute: TNotifyEvent;

  protected
    procedure Execute; override;

  published
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;

  end;

//==============================================================================
  TMSTimer = class(TThread)
  private
    FSlave    : TSlaveThread;
    FInterval : Integer;
    FOnTimer  : TNotifyEvent;

    procedure SetInterval(const Value: Integer);
    procedure CreateSlaveAndExecute;

  protected
    procedure Execute; override;

  public
    constructor Create;
    destructor Destroy; override;

  published
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property Interval: Integer read FInterval write SetInterval;

  end;

implementation


uses SyncObjs;

//==============================================================================
{ TSlaveThread }

procedure TSlaveThread.Execute;
var CritSect : TCriticalSection;
begin
  inherited;

  CritSect := TCriticalSection.Create;
  CritSect.Enter;

  if Assigned(FOnExecute) then FOnExecute(self);

  CritSect.Leave;
  CritSect.Free;
end;

//==============================================================================
{ TMSTimer }

constructor TMSTimer.Create;
begin
  FInterval := 100;

  inherited Create(TRUE);
end;

destructor TMSTimer.Destroy;
begin
  FOnTimer := nil;

  inherited;
end;

procedure TMSTimer.CreateSlaveAndExecute;
begin
  FSlave := TSlaveThread.Create(TRUE);
  FSlave.FreeOnTerminate := TRUE;
  FSlave.Priority := tpHigher;

  FSlave.OnExecute := FOnTimer;
  FSlave.Resume;
end;

procedure TMSTimer.Execute;
begin
  inherited;

  while not Terminated do begin
    Synchronize(CreateSlaveAndExecute);

    Sleep(FInterval);
  end;
end;

procedure TMSTimer.SetInterval(const Value: Integer);
begin
  FInterval := Value;
end;

end.
