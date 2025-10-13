unit uQScheduler3;
  (*-------------------------------------------------------------------------
    --  Queue Task Scheduler                                               --
    -------------------------------------------------------------------------
    -- unit name    : uQScheduler                                          --
    -- description  : simple Task Scheduler                                --
    -- Requirement  : unit MSThreadTimer                                   --
    -------------------------------------------------------------------------
    ..  First Created : 19 Mei 2005       ..
    ..  Finished      : 19 Mei 2005       ..
    ..  by            : andySu            ..
    ........................................
   *)

interface

uses
  Classes, MSThreadTimer;

type

//==============================================================================
(* -= TTaskItem =-
    : job yang diantrikan untuk dijalankan setelah 'delay' dalam milidetik;
      ! buat turunan dari class ini untuk tipe task yg lain.
    : tidak punya timer sendiri.
*)

  TTaskItem = class
  protected
    FTickToLaunch: Longword;

  public
    Delay        : Longword;
    IntData      : Integer;
    StrTaskType,
    StrTaskParam : string;
  end;

//==============================================================================
(* -= TQueueScheduler =-
    : Antrian di execute berdasarkan delay.
    : presisi terbatas pada interval Timer
    ! jangan isi eventOnTimer!
    : TODO alternatif: insert task di tempat yg pas, agak berat waktu insert,
                       waktu OnTimer Handler tidak perlu iterasi sampai task
                       terakhir.
*)

  TQueueScheduler = class
  protected
    FCounterTick  : LongWord;

    FTaskQueue    : TThreadList;
    FEmptyList    : boolean;

    FCurrentTask  : TTaskItem;
    FOnSchedule   : TNotifyEvent;

  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure AddTask (var aTask: TTaskItem);
    procedure ClearAllTask();

    procedure Run(const aMsIncrease: LongWord);
    procedure ResetCounter(const aCounter: LongWord= 0);


    property OnSchedule: TNotifyEvent read FOnSchedule write FOnSchedule;
    property CounterTick: LongWord read FCounterTick;

  end;


implementation

{ TQueueScheduler }

constructor TQueueScheduler.Create;
begin
  inherited;
  { default interval TMSTimer adalah 100 ms }

  FCounterTick :=  0;
  FEmptyList   := TRUE;

  FTaskQueue := TThreadList.Create;
end;

destructor TQueueScheduler.Destroy;
var i: integer;
    tsk : TTaskItem;
begin

  with FTaskQueue.LockList do begin
    for i := Count-1 downto 0 do begin
      tsk := Items[i];
      Delete(i);
      tsk.Free;
    end;
  end;

  FTaskQueue.UnlockList;

  FTaskQueue.Free;

  inherited;
end;

//- {public_methods_} ---------------------------------------------------------

procedure TQueueScheduler.Run(const aMsIncrease: LongWord);
var i: integer;
begin
  FCounterTick := FCounterTick + aMsIncrease;

  if not FEmptyList then begin
    with FTaskQueue.LockList do begin
      for i := Count-1 downto 0 do begin
        FCurrentTask := Items[i];

        if FCurrentTask.FTickToLaunch < FCounterTick then begin
          if Assigned(FOnSchedule) then FOnSchedule(FCurrentTask);

          Delete(i);
          FCurrentTask.Free;
        end;
      end;
      FEmptyList  := Count = 0;
    end;
    FTaskQueue.UnlockList;
  end;

end;

procedure TQueueScheduler.ResetCounter(const aCounter: LongWord= 0);
begin
  FCounterTick :=  aCounter;
end;

procedure TQueueScheduler.AddTask(var aTask: TTaskItem);
begin
  aTask.FTickToLaunch := FCounterTick + aTask.Delay;

  with FTaskQueue.LockList do begin
    Insert(0, aTask);
  end;
  FTaskQueue.UnlockList;

  FEmptyList  := FALSE;
end;

procedure TQueueScheduler.ClearAllTask();
begin

  with FTaskQueue.LockList do begin
    Clear;
  end;
  FTaskQueue.UnlockList;
  FEmptyList  := TRUE;

end;

end.
