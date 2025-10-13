unit uCommonLogReplay;

  (*-------------------------------------------------------------------------
    --  Gamer Recorder and Replay for Air Defence System Simlulator        --
    -------------------------------------------------------------------------
    -- unit name   : uCommonLogReplay                                      --
    -- description : definisi tipe data untuk TNewRecorder dan TNewReplay  --
    --                                                                     --
    -------------------------------------------------------------------------
    ..  First Created : 18 Maret 2005     ..
    ..  Finished      : 12 Mei   2005     ..
    ..  by            : andySu            ..
    ........................................
   *)

(* uCommonLogReplay history
   digunakan oleh uNewLog dan uNewReplay
   { 11 Mei 2005
      . Command Status Recording
   }
   { 10 Mei 2005
      . Recording status dipinda ke sini dari uNewLog
   }
   { 20 April 2005
      . File Version
   }
   { 19 April 2005
      . tambahan History jika di seekplay )
   }
   { 18 April 2005
      . penambahan tipe data aircraft
   }
   { 12 April 2005
      . penambahan data scenario sesusai ARCS
      . 'SnapShot' utuk mengetahui sekilas ttg data
   }
   { 18 Maret 2005
      . start, pindahan dari unit uNewLog dan uNewReplay
   }
*)

interface

uses
  Classes, Windows, SysUtils;

const
  CONST_CRLF   = #13#10;

  { File Header }
  CONST_PrimaryID   = 'ARCSREPLAY  ';
  CONST_SecondaryID = '11.05.2005  ';
  CONST_Version   = 1;
  CONST_Revision  = 2;

  CONST_MIN_GAMESPEED_MULTIPLIER  = 1;
  CONST_MAX_GAMESPEED_MULTIPLIER  = 16;

type

  { File Header }
  TRecFileHeader = record
    PrimaryID   : string[12];
    SecondaryID : string[12];
    Version  : integer;
    Revision : integer;
  end;

  { Save Replay Data }
  TRecObjectData = record
    {core data}
    UID      : string[12];
    CallSign : string[6];
    CoordX, CoordY, CoordZ : double;
    Speed, Heading, Fuel : double;

    {Command State}
    FlyCmdState : Word;

    DestSpeed,
    DestHeading,
    DestAltitude: double;

    {visual}
    CharSymbol : Char;
    TypeName   : string [15];
  end;

  aObjectData = array of TRecObjectData;

  { ScenarioData }
  TRecScenarioInfo = record
    scID : Integer;
    scMissionName : string[32];

    scMapGeoset   : string[255];
    scMapZoom: double;
  end;

  { History Data }
  TRecCoord = record
    CoordX, CoordY, CoordZ : double;
  end;

  TRecACHistory = record
    ACUID: string[12];
    HistoryData : array of TRecCoord;
    HistoryCount : integer;
  end;

  aACHistory = array of TRecACHistory;

  { status Recording of TNewRecorder }

  TRecorderStatus = (rsCreated, rsInitialized, rsRecording);

  procedure GetUidSnapShot(const aData: aObjectData; var aStrs: TStrings);

const

  CONST_FileReplayCurrentVersion: TRecFileHeader =
    ( PrimaryID   : CONST_PrimaryID;
      SecondaryID : CONST_SecondaryID;
      Version     : CONST_Version;
      Revision    : CONST_Revision;);


implementation


  procedure GetUidSnapShot(const aData: aObjectData; var aStrs: TStrings);
  var i: integer;
  begin
    if assigned(aStrs) then
      aStrs.Clear
    else
      aStrs := TStringList.Create;

    for i := 0 to Length(aData)-1 do
      aStrs.Add(aData[i].UID);

    TStringList(aStrs).Sort;
  end;

end.
