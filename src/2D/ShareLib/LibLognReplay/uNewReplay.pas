unit uNewReplay;

  (*-------------------------------------------------------------------------
    --  Gamer Recorder and Replay for Air Defence System Simlulator        --
    -------------------------------------------------------------------------
    -- unit name   : uNewReplay                                            --
    -- description : Player Class for TNewRecorder saved file              --
    -- requirement : MSThreadTimer                                         --
    -------------------------------------------------------------------------
    ..  First Created : 18 Maret 2005     ..
    ..  Finished      : 12 Mei   2005     ..
    ..  by            : andySu            ..
    ........................................
   *)


interface

uses
  Classes, Windows, SysUtils, Dialogs, uCommonLogReplay, uTCPDataType, MSThreadTimer;

const
  CONTS_SZOF_WORD       = SizeOf(Word);
  CONTS_SZOF_LONGWORD   = SizeOf(LongWord);
  CONTS_SZOF_RECOBJDATA = SizeOf(TRecDataAll3DPosition);

type

(* R E P L A Y * S E C T I O N *********************************)
  TFrameReplayEvent =  procedure (const aData: aObjectData) of object;

  TReplayStatus = (rsCreated, rsOpenFile, rsRePlay, rsRePlayPause, rsEnd);

//===========================================================================
(* TNewReplay history
    { 06 Mei 2005
       + Speed Multiplier
    }
    { 28 April 2005
       + AfterSeek Status. Flag untuk menandai Frame 'pertama' setelah di seek.
    }
    { 25 April 2005
       + pebaikan kecil tapi fatal di GetPositionHistory().
    }
    { 19 April 2005
       + tambahan History jika di seekplay().
    }
    { 12 April 2005
      + Modifikasi GetFileReplayInfo untuk ScenarioInfo.
    }
    { 11 April 2005
      + tambahan property  FrameTick[i] dan  FrameNumData[i].
    }
    {08 April 2005
      * +tambahan property, akses ke header;
        - seek play, harusnya sleep() di REVISI..()
        - KASUS ARCS TEST, frame0 nilai sleepnya buesaar.
    }
    {30 Maret 2005
     * release 0.1
     + BugFix  03_29_01
     + BugFix  03_28_01
    }
    {29 maret 2005
     + FTimer.Interval := NextData.time - currentData.Time;
     - 03_29_01 : Perubahan interval meleset 1 frame
     - belum diek jika log tidak berisi data.
    }
    {28 Maret 2005
     - sudah bisa di seekPlay, ke frame manapun;
     - FTimer.Interval := 4000; //tidak pernah diubah.
     - 03_28_01 : if FReplayStatus = rsEnd then hang.
    }
    { .. undocumented progress..
    }
    {18 Maret 2005
     . started
    }
*)

//===========================================================================
  TReplayReadData = record
    Tick          : LongWord;
    SpeedMultiply : Word;
    NumOfData     : Word;
    FilePos       : Int64;
  end;

  { TNewReplay }
  TNewReplay = class(TObject)
  private

  {FileHandling}
    FFileName       : string;
    FDataStart,
    FLastDataPos    : Int64;

    FScenarioInfo     : TRecScenarioInfo;

  {FrameIndexing}
    FFrameIndexList  : array of TReplayReadData;
    FFrameIndexSize,
    FFrameIndexCount : integer;

  {ReplayStatus}
    FReplayStatus : TReplayStatus;
    FCurrentFrame : Integer;
    FOnFrameReplay: TFrameReplayEvent;
    FAfterSeek    : boolean;

    FOnEndReplay : TNotifyEvent;

  {ReplayData}
    FDataCurrent      : aObjectData;

  {Timer/Threads}
    FTimer    : TMSTimer;
    FDataCurentTick : LongWord;

  {Speed Multiplier}
    FSpeedMultiply : Word;

  {private_methods_internal_playing}
    procedure PlayNextFrame;
    
  {private_methods_FrameIndexing}
    procedure AddToFrameIndex(const aFilePos: Int64;
                              const aTimeTick: LongWord;
                              const aSpeedMultiply: Word;
                              const aNumData: Word);

  {private_methods_'low level'_data_retrieving}
    function GetFileReplayInfo(const aFName: string): boolean;

    function ReadFrameData(const aFrameIndex: integer;
                           var aData: aObjectData): boolean;

  {private_methods_timer_event_handler}
    procedure OnTimerHandler(sender: TObject);

  {private_methods_property_frame_fnfo}
    function getFrameTick(ix: integer) : LongWord;
    function getFrameNumOfData(ix: integer) : LongWord;
    function getFrameSpeedMultiplier(ix: integer) : Word;

  {private_methods_property_SpeedMultiplier }
    procedure setSpeedMultiplier(aMult: word);

  public

    constructor Create;
    destructor Destroy; override;

  {public_methods_File_Handling}
    function OpenFileReplay(const aFName: string): boolean;
    procedure CloseFileReplay;

  {public_methods_Play_Function}
    procedure StartPlay;
    procedure StopPlay;
    procedure PausePlay;
    procedure ResumePlay;
    procedure SeekPlay(const aFrameIndex: integer);
  {public_method_HistoryFunction}
    procedure GetPositionHistory(var aHistList:  aACHistory; const aFrameIx: integer=-1);

    function GetCurrentFrameFilePos : Int64;
    
  published

  {published_property_play_function}
    property CurrentFrame : integer read FCurrentFrame;
    property MaxFrame     : integer read FFrameIndexCount;

    property DataCurrent  : aObjectData read FDataCurrent;
    property DataTick     : LongWord    read  FDataCurentTick;
    property OnFrameReplay: TFrameReplayEvent read FOnFrameReplay write FOnFrameReplay;

  {published_property_ReplayStatus}
    property ReplayStatus  : TReplayStatus read FReplayStatus;
    property AfterSeek     : boolean read FAfterSeek;
    property OnEndReplay   : TNotifyEvent read FOnEndReplay write FOnEndReplay;

  public
    property PFFileName : string read FFileName;
  {public_property_FrameInfo}
    property FrameTick[index: integer]:  Longword  read getFrameTick ;
    property FrameSpeedMultiply[index: integer]:  Word  read getFrameSpeedMultiplier;
    property FrameNumData[index: integer]:  Longword  read getFrameNumOfData;

    property ScenarioInfo: TRecScenarioInfo read FScenarioInfo;

    property ReplaySpeedMultiplier: Word read FSpeedMultiply write setSpeedMultiplier;
  end;


implementation


//==============================================================================
{ TNewReplay }

  constructor TNewReplay.Create;
  begin
    FSpeedMultiply := 1;

    FTimer := TMSTimer.Create;
    FTimer.Interval := 1000;
    FTimer.OnTimer := OnTimerHandler;

    FFrameIndexCount := 0;
    FFrameIndexSize  := 64;
    SetLength(FFrameIndexList, FFrameIndexSize);

    FReplayStatus := rsCreated;
    FAfterSeek    := false;
  end;

  destructor TNewReplay.Destroy;
  begin
    FTimer.Terminate;
    FTimer.Free;
    SetLength(FFrameIndexList, 0);

    inherited;
  end;

//- {private_methods_FrameIndexing} -------------------------------------------
//- menyimpan Posisi data Frame di File

  procedure TNewReplay.AddToFrameIndex(const aFilePos: Int64;
                              const aTimeTick: LongWord;
                              const aSpeedMultiply: Word;
                              const aNumData: Word);
  begin
    if FFrameIndexCount >= FFrameIndexSize then begin
      FFrameIndexSize  := FFrameIndexSize + 64;
      SetLength(FFrameIndexList, FFrameIndexSize);
    end;

    FFrameIndexList[FFrameIndexCount].Tick           := aTimeTick;
    FFrameIndexList[FFrameIndexCount].SpeedMultiply  := aSpeedMultiply;

    FFrameIndexList[FFrameIndexCount].NumOfData := aNumData;
    FFrameIndexList[FFrameIndexCount].FilePos   := aFilePos;
    inc(FFrameIndexCount);
  end;

//- {private_methods_'low level'_data_retrieving} ------------------------------
//- membaca data dari file, tidak mengubah status

  function TNewReplay.GetFileReplayInfo(const aFName: string): boolean;
  var readCount, seekCount : integer;
      lastPos   : int64;
      rLongWord : LongWord;
      rWordNumData,
      rWordGameMul : Word;
      fdStream  : TFileStream;
      fRecHeader: TRecFileHeader;
  begin
    result := FALSE;
    if not FileExists(aFName) then
      exit;

    if FReplayStatus = rsCreated then begin
      FFileName := aFName;

      fdStream := TFileStream.Create(FFileName, fmOpenRead);

      // ...GetHeader...
      fdStream.ReadBuffer(fRecHeader, SizeOf(TRecFileHeader));

      if (fRecHeader.PrimaryID <> CONST_FileReplayCurrentVersion.PrimaryID)
          or (fRecHeader.SecondaryID <> CONST_FileReplayCurrentVersion.SecondaryID)
          or (fRecHeader.Version <> CONST_FileReplayCurrentVersion.Version)
          or (fRecHeader.Revision <> CONST_FileReplayCurrentVersion.Revision)
          then begin

         raise Exception.Create('Invalid File Replay.');
         exit;

      end;
      fdStream.Seek(2, soCurrent);

      // ...Scenario Info...
      fdStream.ReadBuffer(FScenarioInfo, SizeOf(TRecScenarioInfo));
      fdStream.Seek(2, soCurrent);

      FDataStart := fdStream.Position ;
      lastPos    := fdStream.Position;

      // ...First Line Data...
      //   . timeStamp
      readCount := fdStream.Read(rLongWord, CONTS_SZOF_LONGWORD);
      lastPos := lastPos + readCount;

      //   . gameSpeedMultiplier
      readCount := fdStream.Read(rWordGameMul, CONTS_SZOF_WORD);
      lastPos := lastPos + readCount;

      while readCount > 0 do begin
        readCount := fdStream.Read(rWordNumData, CONTS_SZOF_WORD);
        lastPos := lastPos + readCount;

        if readCount > 0 then begin
    {*}   AddToFrameIndex(lastPos, rLongWord, rWordGameMul, rWordNumData);

          seekCount := rWordNumData * CONTS_SZOF_RECOBJDATA +2;  // +2 for CRLF
          fdStream.Seek(seekCount, soCurrent);

          lastPos := lastPos + seekCount;
        end;

        readCount := fdStream.Read(rLongWord, CONTS_SZOF_LONGWORD);
        lastPos := lastPos + readCount;

        readCount := fdStream.Read(rWordGameMul, CONTS_SZOF_WORD);
        lastPos := lastPos + readCount;
      end;

      fdStream.Free;
      result := TRUE;
    end;
  end;

  function TNewReplay.ReadFrameData(const aFrameIndex: integer;
                             var aData: aObjectData): boolean;
  var i : integer;
      numOfDat : Word;
      fdStream : TFileStream;
  begin
    result := (aFrameIndex >= 0) AND (aFrameIndex < FFrameIndexCount);
    if not result then exit;

    //fdStream := TFileStream.Create(FFileName, fmOpenRead);
    fdStream := TFileStream.Create(FFileName, fmOpenRead or fmShareDenyNone);
    fdStream.Seek(FFrameIndexList[aFrameIndex].FilePos, soFromBeginning);

    numOfDat:= FFrameIndexList[aFrameIndex].NumOfData;
    setLength(aData, numOfDat);
    for i := 0 to numOfDat-1 do
      fdStream.ReadBuffer(aData[i], CONTS_SZOF_RECOBJDATA);

    fdStream.Free;
  end;

//- {private_methods_internal_playing} -----------------------------------------
//-

  procedure TNewReplay.PlayNextFrame;
  var prevFrame : integer;
      deltaT               : LongWord;
  begin
    if Assigned(FOnFrameReplay) then FOnFrameReplay(FDataCurrent);
    FAfterSeek    :=  FALSE;

    if FCurrentFrame < (FFrameIndexCount-1) then begin
      prevFrame     := FCurrentFrame;
      FCurrentFrame := FCurrentFrame + 1;

      ReadFrameData(FCurrentFrame, FDataCurrent);
      FDataCurentTick := FFrameIndexList[FCurrentFrame].Tick;

      deltaT := FFrameIndexList[FCurrentFrame].Tick -
        FFrameIndexList[prevFrame].Tick;

      FTimer.Interval := Round(
        (FFrameIndexList[prevFrame].SpeedMultiply / FSpeedMultiply) * deltaT - 0.5);

    end
    else begin
      //  if  end of frame then change status.
      FReplayStatus := rsEnd;

      if Assigned(FOnEndReplay) then FOnEndReplay(self);

    end;
  end;

//- {private_methods_timer_event_handler} --------------------------------------
//-

  procedure TNewReplay.OnTimerHandler(sender: TObject);
  begin
    if FReplayStatus = rsRePlay then
      PlayNextFrame;

    if FReplayStatus = rsEnd then begin
      FTimer.Suspend;
      FReplayStatus := rsOpenFile;
    end;
  end;

//- {private_methods_property_frame_fnfo} -------------------------------------
//-

  function TNewReplay.getFrameTick(ix: integer): LongWord;
  begin
    if (ix >=0) and (ix < FFrameIndexCount) then
      result :=  FFrameIndexList[ix].Tick
    else
      result := 0
  end;

  function TNewReplay.getFrameNumOfData(ix: integer): LongWord;
  begin
    if (ix >=0) and (ix < FFrameIndexCount) then
      result :=  FFrameIndexList[ix].NumOfData
    else
      result := 0
  end;

  function TNewReplay.getFrameSpeedMultiplier(ix: integer) : Word;
  begin
    if (ix >=0) and (ix < FFrameIndexCount) then
      result :=  FFrameIndexList[ix].SpeedMultiply
    else
      result := 1
  end;

  procedure TNewReplay.setSpeedMultiplier(aMult: word);
  begin
    FSpeedMultiply := aMult;
  end;

//- {public_methods_File_Handling} ---------------------------------------------
//-

  function  TNewReplay.OpenFileReplay(const aFName: string): boolean;
  begin
    result := FALSE;
    if FReplayStatus <> rsCreated then exit;

    if not GetFileReplayInfo(aFName) then exit;

    if FFrameIndexCount > 1 then begin
      FReplayStatus := rsOpenFile;
    end;

    result := TRUE;
  end;

  procedure TNewReplay.CloseFileReplay;
  begin
    FFileName     := '';

    FDataStart    := 0;
    FLastDataPos  := 0;
    FCurrentFrame := 0;

    FReplayStatus := rsCreated;
  end;

//- {public_methods_Play_Function} ---------------------------------------------
//-

  procedure TNewReplay.StartPlay;
  var nextFrame, deltaT: integer;
  begin
    if (FReplayStatus = rsOpenFile) then begin
      FReplayStatus := rsRePlay;

      FCurrentFrame := 0;
      ReadFrameData(FCurrentFrame, FDataCurrent);
      FDataCurentTick := FFrameIndexList[FCurrentFrame].Tick;

      nextFrame := FCurrentFrame +1;
      if nextFrame < FFrameIndexCount then begin

        deltaT  :=  FFrameIndexList[nextFrame].Tick -
              FFrameIndexList[FCurrentFrame].Tick;

        FTimer.Interval := Round(
            (FFrameIndexList[FCurrentFrame].SpeedMultiply / FSpeedMultiply) * deltaT -0.5);
      end;

      FTimer.Resume;
    end;
  end;

  procedure TNewReplay.StopPlay;
  begin
    if (FReplayStatus = rsReplay) then
      FTimer.Suspend;

    if (FReplayStatus = rsRePlayPause)
        or  (FReplayStatus = rsReplay)
        or  (FReplayStatus = rsEnd)
        then
      FReplayStatus := rsOpenFile;
  end;

  procedure TNewReplay.PausePlay;
  begin
    if (FReplayStatus = rsRePlay) then begin
      FTimer.Suspend;
      FReplayStatus := rsRePlayPause;
    end;
  end;

  procedure TNewReplay.ResumePlay;
  begin
    if FReplayStatus = rsRePlayPause then begin
      FReplayStatus := rsRePlay;
      FTimer.Resume;
    end;
  end;

  procedure TNewReplay.SeekPlay(const aFrameIndex: integer);
  begin
    if FReplayStatus = rsReplay then
      FTimer.Suspend;

    if (aFrameIndex > 0 ) and (aFrameIndex < FFrameIndexCount) then begin
      FCurrentFrame :=  aFrameIndex;
      ReadFrameData(FCurrentFrame, FDataCurrent);
    end;
    FAfterSeek    := TRUE;

    if FReplayStatus = rsReplay then
      FTimer.Resume;
  end;

//- {public_method_HistoryFunction} --------------------------------------------
//--

  procedure TNewReplay.GetPositionHistory(var aHistList:  aACHistory;
     const aFrameIx: integer=-1);
  var i, j, k, maxFrame: integer;
      tmpData: aObjectData;
      numOfAC: integer;

  begin
    if aFrameIx = -1 then
      maxFrame := FCurrentFrame
    else
      maxFrame := aFrameIx;

    ReadFrameData(maxFrame, tmpData);
    numOfAC:= Length(tmpData);
    setLength(aHistList, numOfAc);

    for j := 0 to numOfAC-1 do begin
       //aHistList[j].ACUID := tmpData[j].UID;
       aHistList[j].ShipID := tmpData[j].ShipID;
       SetLength(aHistList[j].HistoryData, maxFrame+1);
       aHistList[j].HistoryCount := 0;
    end;

    for i := maxFrame-1 downto 0 do begin
      ReadFrameData(i, tmpData);

      for j := 0 to Length(tmpData)-1 do begin
        k := 0;
       // while (k <  numOfAC) and (tmpData[j].UID <> aHistList[k].ACUID) do
        while (k <  numOfAC) and (tmpData[j].ShipID <> aHistList[k].ShipID) do
          inc(k);

        if (k < numOfAC) then {found} begin
          aHistList[k].HistoryData[aHistList[k].HistoryCount].CoordX :=
            tmpData[j].x;//tmpData[j].CoordX;
          aHistList[k].HistoryData[aHistList[k].HistoryCount].CoordY :=
            tmpData[j].y;//tmpData[j].CoordY;

          aHistList[k].HistoryCount := aHistList[k].HistoryCount +1;
        end;
      end;
    end;
  end;

  function TNewReplay.GetCurrentFrameFilePos: Int64;
  begin
      Result := FFrameIndexList[CurrentFrame].FilePos ;
  end;
  
end.
