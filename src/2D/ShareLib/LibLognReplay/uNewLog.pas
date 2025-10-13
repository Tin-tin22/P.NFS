unit uNewLog;

  (*-------------------------------------------------------------------------
    --  Gamer Recorder and Replay for Air Defence System Simlulator        --
    -------------------------------------------------------------------------
    -- unit name     : uNewLog                                             --
    -- description   : Recorder Class                                      --
    -------------------------------------------------------------------------
    ..  First Created : 15 Maret 2005     ..
    ..  Finished      : 12 Mei   2005     ..
    ..  by            : andySu            ..
    ........................................
   *)



interface
uses
  Classes, Windows, SysUtils, uCommonLogReplay, uTCPDataType;

type

//---------------------------------------------------------------------------
(* -= TNewRecorder =-
    { 10 Mei 2005
       + GameSpeed Finished

      06 Mei 2005
       + GameSpeed Started
    }
    { 12 April 2005
       + tambahan Scenario Info
    }
    { 17 Maret 2005
      * Release 0.1
      +
    }
    { 15 Maret 2005
      - pakai TTimer
      . Start
    }
    { Format File Replay:
      ScenarioName
      Z:\geoset\indonesia.gst
      replayData
      TimeStamp1 ac1data ac2data
      TimeStamp2 ac1data ac2data ac3data
    }
*)

//---------------------------------------------------------------------------
  TNewRecorder = class(TObject)
  private
  {TimeStamp}
    FFirstTick: LongWord;

  {FileHandling}
    FTemporaryName: string;
    FFileStream   : TFileStream;

  {RecordingStatus}
    FRecStatus : TRecorderStatus;

  {Header}

  {ScenarioInfo}
    FScenarioInfo     : TRecScenarioInfo;

  protected

  public
    constructor Create;
    destructor Destroy; override;

  {public_methods_File_Handling}
    procedure InitializedFileRecord(
      const aFileName: string; const aSceneInfo: TRecScenarioInfo);

    procedure SaveFileRecord(const aFNewName: string);

  {public_methods_DataLog}

    procedure AddDataToLog(const aGameSpeed: Word;  const aData: aObjectData);

    procedure CloseFileLog;
  public
    property ScenarioInfo: TRecScenarioInfo read FScenarioInfo;
    property RecordingStatus: TRecorderStatus read FRecStatus;

  end;


implementation

{ TNewRecorder }

constructor TNewRecorder.Create;
begin
  FFileStream := nil;

  FRecStatus := rsCreated;
end;

destructor TNewRecorder.Destroy;
begin
  if FFileStream <> nil then FreeAndNil(FFileStream);
  inherited;
end;

//- {public_methods_File_Handling} ---------------------------------------------
//-

procedure TNewRecorder.InitializedFileRecord(
    const aFileName: string; const aSceneInfo: TRecScenarioInfo);

var pcWrite: PChar;
begin
  if FRecStatus = rsCreated then begin

    FScenarioInfo  := aSceneInfo;
    FTemporaryName := aFileName;

    pcWrite := '  ';
    pcWrite := PChar(CONST_CRLF);

    FFileStream := TFileStream.Create(FTemporaryName, fmCreate);

    FFileStream.WriteBuffer(CONST_FileReplayCurrentVersion,
      SizeOf(TRecFileHeader));
    FFileStream.WriteBuffer(pcWrite^, Length(pcWrite));

    FFileStream.WriteBuffer(FScenarioInfo, SizeOf(TRecScenarioInfo));
    FFileStream.WriteBuffer(pcWrite^, Length(pcWrite));

    FRecStatus :=  rsInitialized;

  end
  else begin
  end;

end;

procedure TNewRecorder.SaveFileRecord(const aFNewName: string);
begin
  FreeAndNil(FFileStream);
  FRecStatus := rsCreated;

  if aFNewName <> '' then
    RenameFile(FTemporaryName, aFNewName);
end;

//- {public_methods_DataLog} ---------------------------------------------------
//-

procedure TNewRecorder.AddDataToLog(const aGameSpeed: Word;
                                    const aData: aObjectData);
var timeStamp: LongWord;
    gs: Word;
    i, sz : integer;
    pcWrite: PChar;
    num : Word;
begin
  if FFileStream = nil then exit;

  if FRecStatus = rsInitialized then begin

    FFirstTick := GetTickCount;
    FRecStatus := rsRecording;
  end;

  if FRecStatus = rsRecording then begin
    timestamp := GetTickCount - FFirstTick;

    FFileStream.WriteBuffer(timeStamp, SizeOf(timeStamp));

    gs := aGameSpeed;

    if gs < CONST_MIN_GAMESPEED_MULTIPLIER then
      gs := CONST_MIN_GAMESPEED_MULTIPLIER;

    if gs > CONST_MAX_GAMESPEED_MULTIPLIER then
      gs := CONST_MAX_GAMESPEED_MULTIPLIER;

    FFileStream.WriteBuffer(gs, SizeOf(Word));

    num := Length(aData);
    FFileStream.WriteBuffer(Num, SizeOf(num));

    sz := SizeOf(TRecDataAll3DPosition);
    for i := 0 to High(aData) do begin
      FFileStream.WriteBuffer(aData[i] , sz);
    end;

    pcWrite := PChar(CONST_CRLF);
    FFileStream.WriteBuffer(pcWrite^, Length(pcWrite));
  end;

end;

procedure TNewRecorder.CloseFileLog;
begin
   FTemporaryName := '';
end;

end.
