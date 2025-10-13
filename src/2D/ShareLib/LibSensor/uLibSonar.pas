unit uLibSonar;
(*
  Created       : 14 August 2007
  Last Modified : 14 August 2007

  Author        : Andy Sucipto
  description   : Sonar Classs for Emulator Client2D

*)


interface


  uses
    Graphics, MapXLib_TLB, classes,
    uBaseSimulationObject, uMapXSim, uBaseSensor,uSimulationManager,
    uBScopeDisplay,uBaseGraphicObjects,windows,
    uDetected, uObjectView,Messages, SysUtils, Variants, Controls, Forms,
     Dialogs, StdCtrls,mmsystem,
     uTestShip, uEmulatorConstan, uEmulatorProc, uLibSound;

  type
//==============================================================================
    TSonarSoundPlayer = class(TSoundPlayer)
    private
    public
      procedure SetMovement(const heading: double; const speed: double);
      procedure PlayObject2DSound(const UID: string;const fname: string;
        const bearing : double; const range : double;const speed : double;
        const Volume : integer;const loop : boolean);
    end;
//==============================================================================
    TLabeledObject = class(TObject)
    private
      FSelectedObject: TSimulationClass;
      FRange: double;
      FBearing: double;
      procedure SetSelectedObject(const Value: TSimulationClass);
      procedure SetBearing(const Value: double);
      procedure SetRange(const Value: double);
    published
      property SelectedObject : TSimulationClass read FSelectedObject write SetSelectedObject;
      property Range : double read FRange write SetRange;
      property Bearing : double read FBearing write SetBearing;
    end;
//==============================================================================
    TGenericSonar = class(TSimClassOnMapX)
    private

      FDirection : double;
      FHeading : double;
      FLeftAntiHeading : double;
      FRightAntiHeading : double;
      FSpeed : double;
      FHorizontalBeamWidth: double;
      FVerticalBeamWidth: double;
      FAveratePower: double;

      //FAudioLock : boolean;
      //LockedTargetIndex : integer;
      FAudioBeamType : audiobeamloc;
      FBearingLock : double;

      FFrequencyMode: tFrequencyMode;
      FMin_Frequency: double;
      FMax_Frequency: double;

      BearingSequenceList : array [0 .. C_PulseNumber-1] of TSequenceList;
      currentBearingType : array [0 .. C_PulseNumber-1] of byte; //used to determine range of bearing and time
      currentBearingTime : array [0 .. C_PulseNumber-1] of double; //in millisecond
      ActivePulse : array [0 .. C_PulseNumber-1] of boolean;
      FrontMostPulseIndex : array [0 .. C_PulseNumber-1] of byte;

      SelectedObject : TSimulationClass;
      FAutoTrackActive : boolean;
      TrackedObjectIndex : integer;

      runlock : boolean;
      prevDeltams : double;

      FSoundOn: boolean;
      FSoundVolume: integer;
      FNotchMeter: integer;
      FSoundVelocity: double;
      FDetLevel: double;
      FTVG: integer;

      FBackGroundSoundFName: string;
      FPingSoundFName: string;
      FAfterPingSoundFName: string;

      //FCassetteMode: boolean;
      FCurrentCassetteFile : integer;

      function GetDirection: double;                    // Compass
      procedure SetDirection(const Value: double);
      function GetHeading: double;                    // in degree
      procedure SetHeading(const Value: double);
      procedure SetFrequencyMode(const Value: tFrequencyMode);
      procedure SetMax_Frequency(const Value: double);
      procedure SetMin_Frequency(const Value: double);
      function GetSonarMode: sonarmode;                    //trisno: radar mode
      procedure SetSonarMode(const Value: sonarmode);

      function GetNextBearingTime(const bearingSequence: byte;curIdx : integer = 0) : double;
      procedure SetBearingList(const mode : sonarmode);
//      procedure SetCurrentBearingIndexToSelected;
//      procedure ShiftBearingSequenceListToSelected;
//      procedure ShiftRightBearingSequenceList(const dIndex: integer;const bearingSequence: byte);
      procedure ShiftRightBearingArc(const deg: integer;const bearingSequence: byte);
      procedure ShiftBearingArc(const bearingSequence: byte);

      function GetSelectedObject: TSimulationClass;
      procedure SetSelectedObject(const obj : TSimulationClass);
      function GetBearingSequence(const idx : integer;const bearingSequence: byte): integer;
      procedure SetBearingSequence(const idx : integer; const value: byte;const bearingSequence: byte);
      procedure SetSpeed(const Value: double);
      function GetSpeed: double;
      procedure PlayObjectSound(const UID:string; const soundfname:string; const volume: integer;const loop : boolean);
      procedure PlayObject2DSound(const UID, soundfname: string;
        const bearing, range, speed: double;const Volume : integer;const loop : boolean);
      procedure PauseMP3(const UID:string; const FileName: string);

      procedure SetSoundOn(const Value: boolean);
      procedure SetSoundVolume(const Value: integer);
      procedure SetNotchMeter(const Value: integer);
      function GetNotchMeter: integer;
      procedure SetSoundVelocity(const Value: double);
    procedure SetDetLevel(const Value: integer);
    procedure SetTVG(const Value: integer);
    function GetDetLevel: integer;
    procedure SetBackGroundSoundFName(const Value: string);
    procedure SetPingSoundFName(const Value: string);
    procedure SetBearingLock(const Value: double);
    procedure SetAudioBeamType(const Value: audiobeamloc);
    procedure SetAfterPingSoundFName(const Value: string);
    //procedure SetCassetteMode(const Value: boolean);
    //function GetCassetteMode: boolean;
    //procedure SetQOTMode(const Value: boolean);
    //function GetQOTMode: boolean;
    protected
      FrequencySlot  : array [0 .. C_Sonar_Max_Freq_Slot] of double;
      FrequencyIndex : byte;

      FBmp    : TBitmap;

      FFrequency      : double;
      FWavelength     : double;

      FPRF            : double;
      FDetectionRange : double;                              // Cartesian 0 .. 360
      FDetectionFreq  : double;

      FPulseWidth       : double;
      FRangeResolution  : double;

      FMTI_ON: boolean;

      FSonarMode : sonarmode;

      procedure SetFrequency(const Value: double);
      procedure SetWavelength(const Value: double);

      procedure SetDetectionRange(const Value: double);
      procedure SetDetectionFreq(const Value: double);
      procedure SetPRF(const Value: double);

      procedure SetPulseWidth(const Value: double);
      procedure SetRangeResolution(const Value: double);

      procedure SetHorizontalBeamWidth(const Value: double);
      procedure SetVerticalBeamWidth(const Value: double);

      procedure SetAveratePower(const Value: double);
      procedure SetMTI_ON(const Value: boolean);
    protected
    // dipanggil dari RadarProcess(org: TObjectContainer);
      {1.x}
      function FindByRange(const aRange, aTolerance: double; var obj: TDetectedObject): boolean;

      procedure RangeBearingToCoord(const r, b: double; var mx, my : double);

      procedure ProcessObjectFound (const rObj : TSimulationClass; const range :double;
        const bearing : double; const gCount: LongWord); //trisno: move the detection process to procedure

      procedure ProcessObjectUndetected (const rObj : TSimulationClass; const range :double;
        const bearing : double);

    public
      // Radar parts............................................................
      MRange: Double;
      PrevRange:Double;
      wDeviceID: word;
      // doppler parts
      Vs:Double;
      Vo:Double;
      FreqSource:Double;
      FreqDetected:Double;
      DiffRange:double;
      RangeBef:Double;

      FireNewPulseLineEvent : TNewPulseLineProc;
      //PlayMP3 : TPlayerFunc;
      SoundPlayer : TSonarSoundPlayer;

      ListenRefreshCounter : double;
      ListenShiftCounter : double;

      //trisno: var for TRDT
      MRangeList : array [0 .. C_PulseNumber-1] of TRangeList;
      PrevRangeList : array [0 .. C_PulseNumber-1] of TRangeList;
      SlotBearingList : array [0 .. C_PulseNumber-1] of TSlotBearingList;
      //DoublePulsedList :  array [0 .. 1] of TSequenceList;
      //newPulseNeededList : array [0 .. 1] of TSequenceList;
      ALCStart : double;
      ALCEnd   : double;
      ALCLock  : boolean;


      constructor Create;
      destructor Destroy; override;

      {0}
      procedure Run(const aDeltaMs: double);   override;
      procedure Update; override;
      procedure ResetLists(const resetbearing : boolean);

      procedure CreateDefaultView(const aMap: TMap); override;

      procedure ConvertViewsPosition(); override;
      procedure DrawViews(aCnv: TCanvas); override;
      procedure DopplerEffects (const Value: double);
      function PlayWav(const FileName: string): Boolean;
      procedure SetAutoTrack (const isTracked: boolean;const idx: integer);
      procedure ShiftBearingArcToTracked(const bearingSequence: byte);
    public
      // Detected object ............................................................
      DetObjects : TObjectContainer;
      TmpDet     : TSonarDetectedObject;
      //AGObject   : TDetectedObject;
      LabeledObjects : array [0 .. C_Number_Target_Label-1] of TLabeledObject;
      CassetteFileList : TStringList;

      {1}
      procedure DetectionProcess(org: TObjectContainer; const gCount: LongWord);
      procedure LabelSelectedObject(const s:integer; const range:double ;const bearing : double);
      function GetObjectRangeinKYdInt(const obj:TSimulationClass): integer;
      function GetObjectBearinginInt(const obj:TSimulationClass): integer;
      function GetObjectDopplerSpeedinInt(const obj:TSimulationClass): integer;
      procedure SetAudioLock (const isLocked: boolean;const bearing: double);
      procedure SetAudioGate (const isLocked: boolean;const lbl : integer);
    published
      property Direction: double                // arah radar, bukan arah timebase
          read GetDirection write SetDirection; // jika radar kapal, ikut halu kapal

      property Heading : double
          read GetHeading write SetHeading; //haluan kapal
      property Speed : double read GetSpeed write SetSpeed;
  //------------------------------------
      property Frequency   : double                     // MHz
          read FFrequency write SetFrequency;
      property Wavelength  : double                     //
          read FWavelength;   // write SetWavelength;
      property Max_Frequency : double read FMax_Frequency write SetMax_Frequency;
      property Min_Frequency : double read FMin_Frequency write SetMin_Frequency;

  //------------------------------------
     property DetectionRange: double                   // nautical miles
          read FDetectionRange write SetDetectionRange;
     property DetectionFreq: double
          read FDetectionFreq write SetDetectionFreq;


      property PRF : double                             // pulse per second
          read FPRF write SetPRF;

  //------------------------------------
      property PulseWidth :double                      // micro second
          read FPulseWidth write SetPulseWidth;
      property RangeResolution: double
          read FRangeResolution; //write SetRangeResolution;

  //------------------------------------
      property VerticalBeamWidth     : double                  // degree
          read FVerticalBeamWidth write SetVerticalBeamWidth;
      property HorizontalBeamWidth   : double                  // degree
          read FHorizontalBeamWidth write SetHorizontalBeamWidth;

  //------------------------------------
     property MTI_ON: boolean read FMTI_ON write SetMTI_ON;
     property FrequencyMode : tFrequencyMode read FFrequencyMode write SetFrequencyMode;
     property SonarMode : sonarmode read GetSonarMode write SetSonarMode;
     property SoundOn : boolean read FSoundOn write SetSoundOn;
     property SoundVolume : integer read FSoundVolume write SetSoundVolume;
     property NotchMeter : integer read GetNotchMeter write SetNotchMeter;
     property SoundVelocity : double read FSoundVelocity write SetSoundVelocity; //TODO:not yet used
     property DetLevel : integer read GetDetLevel write SetDetLevel;
     property TVG : integer read FTVG write SetTVG;//TODO:not yet used
     property BackGroundSoundFName: string read FBackGroundSoundFName write SetBackGroundSoundFName;
     property PingSoundFName: string read FPingSoundFName write SetPingSoundFName;
     property AfterPingSoundFName : string read FAfterPingSoundFName write SetAfterPingSoundFName;
     property BearingLock : double read FBearingLock write SetBearingLock;
     property AudioBeamType : audiobeamloc read FAudioBeamType write SetAudioBeamType;
     //property CassetteMode : boolean read GetCassetteMode write SetCassetteMode;
     //property QOTMode : boolean read GetQOTMode write SetQOTMode;

  //------------------------------------
     property SelectedTarget : TSimulationClass read GetSelectedObject write SetSelectedObject;
     //property AutotrackTarget : boolean read FAutoTrackActive write SetAutoTrack;



  // BELUM //------------------------------------
      property AveratePower: double read FAveratePower write SetAveratePower;
      //property EffectivePower : double; // KW

      //AntenaType   : string;
      //PolarizationDirection : tPolarizationDirection;


    end;


implementation

uses
  uBaseConstan, uBaseDataType, uBaseFunction, Math;

//==============================================================================
// radar function
{function Calc_PRF_To_Detection_Range(const aPRFinPPS: double):double;
begin ///result in nautical miles  //untested
  result := IfThen(IsAlmostZero(aPRFinPPS), 0.0,
    (C_Meter_To_NauticalMiles * 0.5 * C_SPEED_OF_LIGHT / aPRFinPPS));
end;

function Calc_DetectionRange_To_PRF(const aRNm: double):double;
begin //untested
  result :=  0.5 * C_SPEED_OF_LIGHT / (aRNm * C_NauticalMiles_TO_Meter);
end;
}
//function Calc


//==============================================================================
//==============================================================================
{ TClientRadar }

constructor TGenericSonar.Create;
var i: integer;
    deltaf:  double;
begin
  inherited;

//-display area;

  DetObjects := TObjectContainer.Create;
//  DetViews   := TViewContainer.Create;

  FMin_Frequency :=  9000.0; // MHz;
  FMax_Frequency := 12000.0; // MHz;

  deltaf := (FMax_Frequency - FMin_Frequency) / C_Sonar_Max_Freq_Slot;
  for i := 0 to C_Sonar_Max_Freq_Slot do begin
    FrequencySlot[i] := FMin_Frequency + i * deltaf;
  end;

  FrequencyIndex := 0;
  SetFrequency(FrequencySlot[0]);
  FSonarMode := OMNI;
  FPulseWidth := 100;
  FAudioBeamType := ASC;
  ResetLists(true);

  for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin   //trisno: resetting list
    SlotBearingList[0,i] := C_SlotBearings[i];
  end;

  FSoundOn := false;
  FSoundVolume := 100;
  FNotchMeter := 0;
  FSoundVelocity := 4925.0;
  FDetLevel := (((5+1)/10)*230);
  FTVG := 0;

  ALCStart := -1;
  ALCEnd   := -1;
  ALCLock  := false;

  //FCassetteMode := false;
  CassetteFileList := TStringList.Create;
  FCurrentCassetteFile := -1;
  //SelectedObjectBearingIndex := -1;
  //currentBearingTime := FPulseWidth;
end;

destructor TGenericSonar.Destroy;
begin
  ViewContainer.ClearObject;
  ObjectContainer.ClearObject;

  DetObjects.ClearObject;
  DetObjects.Free;


  inherited;
end;

// =============================================================================
function TGenericSonar.GetDirection: double;
begin
  Result := ConvCartesian_To_Compass(FDirection);
end;

procedure TGenericSonar.SetDirection(const Value: double);
begin
  FDirection := ConvCompass_To_Cartesian(Value);
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TGenericSonar.GetHeading: double;
begin
  Result := FHeading;
end;

procedure TGenericSonar.SetHeading(const Value: double);
begin
  FHeading := Value;
  FLeftAntiHeading := FHeading - 190;
  if FLeftAntiHeading < 0 then FLeftAntiHeading := FLeftAntiHeading + 360;
  FRightAntiHeading := FHeading - 170;
  if FRightAntiHeading < 0 then FRightAntiHeading := FRightAntiHeading + 360;
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function TGenericSonar.GetSonarMode: sonarmode;     //trisno: mode selection
begin
  Result := FSonarMode;
end;

procedure TGenericSonar.SetSonarMode(const Value: sonarmode);
var
  i : integer;
  prevDeg : double;
begin
  if FSonarMode = LISTEN then begin
    for i:= 0 to C_Number_Target_Label-1 do begin
      LabeledObjects[i] := nil;
    end;
    DetObjects.ClearObject;
    ResetLists(false);
    
  end;
  FSonarMode := Value;
  //ResetLists;
  SetBearingList(FSonarMode);

  if (FSonarMode = LISTEN) then begin
    ListenRefreshCounter := C_ListenRefreshInterval; //20 minutes
    ListenShiftCounter := C_ListenShiftInterval;
  end
  else begin
    //DONE : set to loop
    PlayObjectSound('ping',PingSoundFName,100,true);
  end;

end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TGenericSonar.SetFrequency(const Value: double);
begin
  FFrequency := Value;
  FWavelength := ifThen(IsAlmostZero(Value), 0.0, (C_SPEED_OF_LIGHT / Value));
end;

procedure TGenericSonar.SetWavelength(const Value: double);
begin
  FWavelength := Value;
  FFrequency  := ifThen(IsAlmostZero(Value), 0.0, (C_SPEED_OF_LIGHT / Value));
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TGenericSonar.SetDetectionRange(const Value: double);
begin
  FDetectionRange := Value;
  ResetLists(false);
  SetBearingList(FSonarMode);

  //ResetLists;
  //SetBearingList(FSonarMode);
//  FPRF :=ifThen(IsAlmostZero(Value), 0.0,
//    0.5 * C_SPEED_OF_SOUND_IN_SEA / (Value * C_NauticalMiles_TO_Meter));
end;

procedure TGenericSonar.SetDetectionFreq(const Value: double);
begin
  FDetectionFreq := Value;
  ResetLists(false);
  SetBearingList(FSonarMode);

  //ResetLists;
  //SetBearingList(FSonarMode);
//  FPRF :=ifThen(IsAlmostZero(Value), 0.0,
//    0.5 * C_SPEED_OF_SOUND_IN_SEA / (Value * C_NauticalMiles_TO_Meter));
end;


procedure TGenericSonar.SetPRF(const Value: double);
begin
  FPRF := Value;
//  FDetectionRange :=  IfThen(IsAlmostZero(Value), 0.0,
//    (C_Meter_To_NauticalMiles * 0.5 * C_SPEED_OF_SOUND_IN_SEA / Value));

end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TGenericSonar.SetPulseWidth(const Value: double);
begin // input in Micro Second
  //ResetLists;
  //SetBearingList(FSonarMode);
  FPulseWidth := Value;
  FRangeResolution :=(0.5*(C_SPEED_OF_SOUND_IN_SEA*Value))
end;

procedure TGenericSonar.SetRangeResolution(const Value: double);
begin
  FRangeResolution := Value;
  FPulseWidth := 2.0 * Value / C_SPEED_OF_SOUND_IN_SEA;
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TGenericSonar.SetAutoTrack (const isTracked: boolean;const idx: integer);
begin
  FAutoTrackActive := isTracked;
  TrackedObjectIndex := idx;
  //if FSonarMode = OMNI then ShiftBearingArcToSelected(255);
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// =============================================================================
procedure TGenericSonar.Update;
//var i : integer;
begin
  inherited;

  DetObjects.UpdateAllMemberObject

end;
//==============================================================================
function TGenericSonar.PlayWav(const FileName: string): Boolean;
var
  mciOpenParms: TMCI_Open_Parms;
  mciPlayParms: TMCI_Play_Parms;
begin
  if waveOutGetNumDevs < 1 then             { Any devices? }
    ShowMessage('No wave devices available!')
  else
  begin
    FillChar(mciOpenParms,
      SizeOf(TMCI_Open_Parms), 0);
    FillChar(mciPlayParms,
      SizeOf(TMCI_Play_Parms), 0);

    with mciOpenParms do                    { Set MCI to play WAV files }
    begin
      lpStrDeviceType := 'waveaudio';
      lpstrElementName := pchar(FileName);
    end;
    if mciSendCommand(0, MCI_OPEN,
      MCI_OPEN_TYPE or MCI_OPEN_ELEMENT,
      Longint(@mciOpenParms)) = 0 then      { Open Device }
    begin
      wDeviceID := mciOpenParms.wDeviceID;  { Grab Device ID for later }

      //mciPlayParms.dwCallback := Handle;    { Set our Handle for Callback message }

      mciSendCommand(wDeviceID, MCI_PLAY, MCI_NOTIFY,
        LongInt(@mciPlayParms));            { Kick off play of File; await message }
    end
    else
      mciSendCommand(wDeviceID, MCI_PLAY, MCI_NOTIFY,
        LongInt(@mciPlayParms));            { Kick off play of File; await message }
  end;

end;

//==============================================================================

//==============================================================================
procedure TGenericSonar.Run(const aDeltaMs: double);
//  var : double;
var
  dRange : double;
  dDegA,dDegB : double;
  DegatALCEnd : boolean;
begin
  if not runlock then begin
    runlock := true;

    if FSonarMode <> PLAYCASSETTE{not FCassetteMode} then begin
      dRange := (((prevDeltams+aDeltaMs)*0.001)*(C_SPEED_OF_SOUND_IN_SEA_Y/2));
      prevDeltams := 0;
      //mode sonar LISTEN...menyapu objek pasif pada band freq 9-12 khz

      //play background sound
      PlayObjectSound('bksound',BackGroundSoundFName,5,true);

      //modify range
      if (FSonarMode = LISTEN) then begin
        if (FAudioBeamType = ASC) and (ALClock) then begin  //ALClock implementation
          if SlotBearingList[0,0] = round(ALCEnd) then begin
            FBearingLock := ALCStart;
            ShiftBearingArc(0);
          end
          else begin
            FBearingLock := 0;
            ShiftRightBearingArc(1,0);
          end;
        end
        else if FAudioBeamType = ALC then
          ShiftBearingArc(0)
        else begin
          if ListenShiftCounter > 0 then
            ListenShiftCounter := ListenShiftCounter - prevDeltams - aDeltaMs
          else begin
            ListenShiftCounter := ListenShiftCounter + C_ListenShiftInterval;
            ShiftRightBearingArc(1,0);
          end;
        end;
        if ListenRefreshCounter > 0 then
          ListenRefreshCounter := ListenRefreshCounter - prevDeltams - aDeltaMs
        else begin
          ListenRefreshCounter := ListenRefreshCounter + C_ListenRefreshInterval;
          if Assigned(FireNewPulseLineEvent) then FireNewPulseLineEvent;
        end;
      end
      else begin //if (FSonarMode = OMNI) then begin//mode Sonar OMNI
        PrevRange :=MRange;
        MRange:= MRange + dRange;
        if MRange > FDetectionRange then begin
          MRange := 0;
          if Assigned(FireNewPulseLineEvent) then begin
            FireNewPulseLineEvent;
            //DONE : set to loop
            PlayObjectSound('ping',PingSoundFName,100,true);
          end;
          if FSonarMode = MCC then begin
            FBearingLock := 0;
            ShiftBearingArc(0);
          end
          else if (FAudioBeamType = ASC) and (ALClock) then begin //ALClock implementation
            DegatALCEnd := false;
            dDegA := SlotBearingList[0,0] - 6;
            if dDegA < 0 then dDegA := dDegA + 360;
            dDegB := SlotBearingList[0,0] + 6;
            if dDegB > 360 then begin
              dDegB := dDegB - 360;
              if (dDegA <= ALCEnd) or (dDegB >= ALCEnd) then begin
                DegatALCEnd := true;
              end;
            end
            else begin
              if (dDegA <= ALCEnd) and (dDegB >= ALCEnd) then begin
                DegatALCEnd := true;
              end;
            end;

            {
            dDeg := ALCEnd + 11;
            if dDeg > 360 then begin
              dDeg := dDeg - 360;
              if (SlotBearingList[0,0] >= ALCEnd) or
                (SlotBearingList[0,0] < dDeg) then begin
                 DegatALCEnd := true;
              end;
            end
            else begin
              if (SlotBearingList[0,0] >= ALCEnd) and
                (SlotBearingList[0,0] < dDeg) then begin
                 DegatALCEnd := true;
              end;
            end;
            }
            if DegatALCEnd then begin
              //FBearingLock := ALCStart;
              //ShiftBearingArc(0);
              SetBearingLock(ALCStart);
            end
            else begin
              FBearingLock := 0;
              ShiftRightBearingArc(C_BearingShift,0);

              dDegA := SlotBearingList[0,0] - 6;
              if dDegA < 0 then dDegA := dDegA + 360;
              dDegB := SlotBearingList[0,0] + 6;
              if dDegB > 360 then begin
                dDegB := dDegB - 360;
                if (dDegA <= ALCEnd) or (dDegB > ALCEnd) then begin
                  SetBearingLock(ALCEnd);
                end;
              end
              else begin
                if (dDegA <= ALCEnd) and (dDegB > ALCEnd) then begin
                  SetBearingLock(ALCEnd);
                end;
              end;

            end;
          end
          else if FAudioBeamType = ALC then
            ShiftBearingArc(0)
          else if (FAudioBeamType = AG) or (FSonarMode = LPGC) then
            ShiftBearingArcToTracked(0)
          else
            ShiftRightBearingArc(C_BearingShift,0);  //TODO : make the shift slotted ?
        end;
      end;
    end
    else begin
      //DONE : run cassette player
      if FSoundOn then begin
        if FCurrentCassetteFile = -1 then begin
          If SoundPlayer <> nil then SoundPlayer.ClearAllMP3; 
          FCurrentCassetteFile := 0;
          PlayObjectSound('cassette',CassetteFileList[FCurrentCassetteFile],100,false);
        end
        else begin
          if SoundPlayer <> nil then begin
            if not SoundPlayer.isMP3Playing('cassette',CassetteFileList[FCurrentCassetteFile]) then begin
              inc(FCurrentCassetteFile);
              if FCurrentCassetteFile <> CassetteFileList.Count then begin
                PlayObjectSound('cassette',CassetteFileList[FCurrentCassetteFile]
                  ,100,false);
              end
              else begin
                exit;
              end;
            end;
          end;
        end;
      end;
    end;
    runlock := false;
  end
  else begin
    prevDeltams := prevDeltams + aDeltaMs;
  end;
  if SoundPlayer <> nil then  begin
    //set position
    SoundPlayer.setMovement(SlotBearingList[0,0],0);//FHeading,0);
  end;
end;

//==============================================================================
procedure TGenericSonar.DopplerEffects (const Value: double);

begin
  DiffRange:=(TmpDet.DetRange)-(TmpDet.DetRangeBef) ;
  // yg di deteksi mendekat
  if DiffRange < 0 then begin
    FreqDetected:=(FreqSource/(1-(Vs/C_SPEED_OF_SOUND_IN_SEA_Y)));
  end;
  // yg di deteksi menjauh
  if DiffRange > 0 then begin
    FreqDetected:=(FreqSource/(1+(Vs/C_SPEED_OF_SOUND_IN_SEA_Y)));
  end;
  // yg men-deteksi nemdekat
  if DiffRange < 0 then begin
    FreqDetected:=(FreqSource/(1+(Vo/C_SPEED_OF_SOUND_IN_SEA_Y)));
  end;
  // yg men-deteksi menjauh
  if DiffRange > 0 then begin
    FreqDetected:=(FreqSource/(1+(Vo/C_SPEED_OF_SOUND_IN_SEA_Y)));
  end;

end;
//==============================================================================
procedure TGenericSonar.CreateDefaultView(const aMap: TMap);
begin


end;

procedure TGenericSonar.ConvertViewsPosition();
begin

end;

procedure TGenericSonar.DrawViews(aCnv: TCanvas);
begin
//
end;


//==============================================================================
procedure TGenericSonar.RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
begin  // return *relatif* coord to radar center
  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := r * cosx;
  my := r * sinx;
end;

function TGenericSonar.FindByRange(const aRange, aTolerance: double; var obj: TDetectedObject): boolean;
var i: integer;
    found : boolean;
    list : TList;
begin  // bearingnya belum;

  list := DetObjects.GetList;
  found := false;
  i := 0;
  while not found and (i < list.Count) do begin
    obj := TSonarDetectedObject(list[i]);

    found :=  abs(obj.DetRange - aRange) < aTolerance;

    inc(i);
  end;
  DetObjects.ReturnList;

  result :=  found;
end;

procedure TGenericSonar.DetectionProcess(org: TObjectContainer; const gCount: LongWord);
{ radar processing routine
  input  : org -> 'real' object -> syncrhonized with network ;
  output : in ObjectContainer, processes & viewed;
}
var i,xx,j,k: integer;
    rObj, dObj : TSimulationClass;
    list : TList;
    dpt1 : t2DPoint;
    range, bearing, elev, px, py: double;
    s: array[0..79] of char;
    inarc : boolean;
    //soundfname : String;
begin
  list := org.GetList;
  //DetObjects.ClearObject;

  for i := 0 to list.Count -1  do begin
    rObj := list[i];

    range   := CalcRange(PositionX, PositionY, rObj.PositionX, rObj.PositionY) * C_NauticalMiles_To_Yard;
    bearing := CalcBearing(PositionX, PositionY, rObj.PositionX, rObj.PositionY);
    //LISTEN Mode
    if (FSonarMode = LISTEN) then begin  //trisno: OMNI mode detection
      if (range < FDetectionRange) then begin
        ProcessObjectFound(rObj, range, bearing, gCount);
      end;
    end
    else begin//if (FSonarMode = OMNI) or (FSonarMode = MCC) then begin  //trisno: OMNI mode detection
      if (rObj as TXSonarObject).EchoLevel < FDetLevel then begin
        ProcessObjectUndetected(rObj,range,bearing);         //cek DelLevel
      end
      else if (range < FDetectionRange) then begin
        if (range > PrevRange) and (range < MRange) then  begin  //check blind arc
          if not DegComp_IsBeetwen(bearing,FLeftAntiHeading,FRightAntiHeading) then begin
            ProcessObjectFound(rObj, range, bearing, gCount);
          end;
        end
        else
          ProcessObjectUndetected(rObj,range,bearing);
      end
      else
        ProcessObjectUndetected(rObj,range,bearing);
    end;   // hasil proces di atas ada di list DetObject;  // isinya semua object yg berada di dalam range radar.
  end;
  org.ReturnList;

end;

//trisno: moved from detection process
procedure TGenericSonar.ProcessObjectFound (const rObj : TSimulationClass;
  const range :double; const bearing : double; const gCount: LongWord);
var
  dObj : TSimulationClass;
  dpt1 : t2DPoint;
  px, py: double;
  soundfname : string;
  inarc : boolean;
  i : integer;
  vol : double;
  scale : double;
begin
  dObj := DetObjects.FindObjectByUid(rObj.UniqueID);
  if (dObj = nil) then begin
    TmpDet := TSonarDetectedObject.Create;
    TmpDet.UniqueID := rObj.UniqueID;
    TmpDet.Enabled := TRUE;
    TmpDet.DetRange   := range;  //yard
    TmpDet.DetBearing := bearing;
    //TmpDet.ProfileFname := (rObj as TXSonarObject).ProfileFile;
    TmpDet.oObj := rObj;
    DetObjects.AddObject(TmpDet);
  end
  else begin
    TmpDet := dObj as TSonarDetectedObject;
    //if not TmpDet.Detected then begin
      TmpDet.Enabled := TRUE;
      TmpDet.DetRange   := range;  //yard
      TmpDet.DetBearing := bearing;
      //TmpDet.ProfileFname := (rObj as TXSonarObject).ProfileFile;
      TmpDet.oObj := rObj;
    //end;
    //TmpDet.Freq := (dObj as TXSonarObject).Freq;
  end;

  //update labeled object
  for i:= 0 to C_Number_Target_Label-1 do begin
    if LabeledObjects[i] <> nil then begin
      if LabeledObjects[i].SelectedObject <> nil then begin
        if LabeledObjects[i].SelectedObject.UniqueID = TmpDet.UniqueID then begin
          LabeledObjects[i].Range := range;
          LabeledObjects[i].Bearing := bearing;
        end;
      end;
    end;
  end;

  //TmpDet.DetSpeed   := (rObj as TXSonarObject).Speed;
    //TmpDet.Freq := (rObj as TXSonarObject).Freq;

  RangeBearingToCoord(range /C_NauticalMiles_To_Yard , bearing, dPt1.X, dPt1.Y);

  pX := PositionX + dPt1.X * C_NauticalMile_To_Degree;
  pY := Positiony + dPt1.Y * C_NauticalMile_To_Degree;

  TmpDet.SetDetectedPosition(px, pY, 0, gCount, PositionX, PositionY);
  //cek notch
  if (TmpDet.DetSpeed >= FNotchMeter) {or ((TmpDet.initvalue) and (FNotchMeter = 0))} then begin
    //play sounds
    if FSonarMode = LISTEN then begin     
      {
      inarc := false;
      if SlotBearingList[0,0] > SlotBearingList[0,1] then begin
        if (bearing > SlotBearingList[0,0]) or (bearing <= SlotBearingList[0,1]) then
          inarc := true
      end
      else begin
        if (bearing > SlotBearingList[0,0]) and (bearing <= SlotBearingList[0,1]) then
          inarc := true
      end;
      soundfname := (rObj as TXSonarObject).SoundFilePassive;
      if inarc then begin
        //PlayObjectSound(rObj.UniqueID,soundfname,100);
        vol := exp(-2)*100;
        PlayObject2DSound(rObj.UniqueID,soundfname,bearing,range,0,round(vol));
      end
      else begin
        //PlayObjectSound(rObj.UniqueID,soundfname,10);
        vol := exp(-2)*100;
        PlayObject2DSound(rObj.UniqueID,soundfname,bearing,range,0,round(vol));
      end;
      }
      soundfname := (rObj as TXSonarObject).SoundFilePassive;
      scale := abs(SlotBearingList[0,0] - bearing);
      if scale > 180 then scale := 360 - scale;
      scale := scale - 6;
      if scale > 0 then scale := (scale/174)*-1.414213
      else scale := 0;
      scale := exp(scale);
      vol := scale*scale*100;
      //PlayObjectSound(rObj.UniqueID,soundfname,100,false);
      PlayObject2DSound(rObj.UniqueID,soundfname,bearing,range,0,round(vol),true);
    end
    else begin
      if DegComp_IsBeetwen(bearing,SlotBearingList[0,0],SlotBearingList[0,1]) then begin
        PauseMp3('ping',PingSoundFName);
        soundfname := (rObj as TXSonarObject).SoundFile;
        PlayObjectSound(rObj.UniqueID,soundfname,100,false);//FSoundVolume);  //TODO : add doppler effect
      end;
    end;
  end
  else begin
    TmpDet.Enabled := FALSE;
  end;
end;

procedure TGenericSonar.ProcessObjectUndetected(
  const rObj: TSimulationClass; const range :double;
  const bearing : double);
var
  dObj : TSimulationClass;
  dpt1 : t2DPoint;
  px, py: double;
  soundfname : string;
begin
  dObj := DetObjects.FindObjectByUid(rObj.UniqueID);
  /////start frequency effect
  if (dObj <> nil) then begin
    TmpDet := dObj as TSonarDetectedObject;
    TmpDet.Enabled := false;
    TmpDet.DetRange := range;
    TmpDet.DetBearing := bearing;
  end;
  //TODO: start 'active after ping' sound
  //PlayObjectSound('bksound',AfterPingSoundFName,5,true);
end;

procedure TGenericSonar.SetHorizontalBeamWidth(const Value: double);
begin
  FHorizontalBeamWidth := Value;
end;

procedure TGenericSonar.SetVerticalBeamWidth(const Value: double);
begin
  FVerticalBeamWidth := Value;
end;


procedure TGenericSonar.SetAveratePower(const Value: double);
begin
  FAveratePower := Value;
end;

procedure TGenericSonar.SetMTI_ON(const Value: boolean);
begin
  FMTI_ON := Value;
end;

procedure TGenericSonar.SetFrequencyMode(const Value: tFrequencyMode);
begin
  FFrequencyMode := Value;
end;

procedure TGenericSonar.SetMax_Frequency(const Value: double);
begin
  FMax_Frequency := Value;
end;

procedure TGenericSonar.SetMin_Frequency(const Value: double);
begin
  FMin_Frequency := Value;
end;

//==============================================================================
function TGenericSonar.GetNextBearingTime(const bearingSequence: byte;curIdx : integer ) : double;
begin
  if FSonarMode = LPST then begin
    if currentBearingType[bearingSequence] = 1 then
      Result := 400
    else
      Result := FPulseWidth;
  end
  else if FSonarMode = LPGC then begin
    if currentBearingType[bearingSequence] = 1 then begin
      if curIdx = 0 then
        Result := 450   
      else
        Result := FPulseWidth;
    end
    else
      Result := FPulseWidth;
  end
  else
    Result := FPulseWidth;

end;
{
procedure TGenericSonar.SetCurrentBearingIndexToSelected;
begin
  if SelectedObject <> nil then begin
    SelectedObjectBearingIndex := GetBearingIndex(SlotBearingList[0],
                                    CalcBearing(PositionX, PositionY, SelectedObject.PositionX,
                                       SelectedObject.PositionY))
  end
  else
    SelectedObjectBearingIndex := -1;
end;
}
procedure TGenericSonar.ResetLists(const resetbearing : boolean);
var
  i,j : integer;
begin
  MRange:=0;
  PrevRange := 0;
  prevDeltams := 0;
  ActivePulse[0] := true;
  ActivePulse[1] := false;
  FrontMostPulseIndex[0] := 0;
  FrontMostPulseIndex[1] := 0;
  currentBearingType[0] := 1;
  currentBearingTime[0] := GetNextBearingTime(0,0);
  for j := 0 to C_PulseNumber-1 do begin
    for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin   //trisno: resetting list
      MRangeList[j,i] := 0;
      PrevRangeList[j,i] := 0;
      if resetbearing then SlotBearingList[j,i] := C_SlotBearings[i];
    end;
  end;
  DetObjects.ClearObject;
  {
  for i := 0 to C_Number_Target_Label-1 do begin
    LabeledObjects[i] := nil;
  end;
  FAudioLock := false;
  }
end;

procedure TGenericSonar.SetBearingList(const mode : sonarmode);
var
  i : integer;
begin
  {if (mode <> OMNI) then begin //trisno : temporary TRDT only
    currentBearingType[0] := 1;
    for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      BearingSequenceList[0,i] := C_DefaultBearingSequence[i];
    end;
    BearingSequenceList[1] := BearingSequenceList[0];
    //SelectedObjectBearingIndex := -1;
  end;}
  if (FSonarMode = MCC) then begin
    FBearingLock := 0;
    ShiftBearingArc(0);
  end
  else if (mode = LPGC) then begin
    //ShiftBearingSequenceListToSelected;
    ShiftBearingArcToTracked(0);
  end; {
  if (mode = MCC) then begin
    currentBearingType[0] := 1;
    for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      BearingSequenceList[0,i] := 354;
    end;
    BearingSequenceList[1] := BearingSequenceList[0];
    SelectedObjectBearingIndex := -1;
  end;  }
end;
{
procedure TGenericSonar.ShiftBearingSequenceListToSelected;
var
  i,sidx : integer;
begin
  //SetCurrentBearingIndexToSelected;
  if SelectedObjectBearingIndex <> -1 then begin
    sidx := SelectedObjectBearingIndex;
    for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      SetBearingSequence(sidx,C_DefaultBearingSequence[i],255);
      sidx := sidx + 1;
      if sidx > C_Sonar_Bearing_Slot_Number-1 then sidx := 0;
    end;
  end;
end;

procedure TGenericSonar.ShiftRightBearingSequenceList(const dIndex: integer;const bearingSequence: byte);
var
  resultSeq : TSequenceList;
  i,sidx : integer;
begin
  sidx := dIndex-1;
  if sidx = 0 then sidx := C_Sonar_Bearing_Slot_Number-1;
  if sidx > C_Sonar_Bearing_Slot_Number-1 then begin
    sidx := sidx mod C_Sonar_Bearing_Slot_Number;
  end;
  if (sidx <> 0) then begin
    for i:= 0 to C_Sonar_Bearing_Slot_Number-1 do begin
      resultSeq[i] := GetBearingSequence(sidx, bearingSequence);
      sidx := sidx+1;
      if sidx > C_Sonar_Bearing_Slot_Number-1 then sidx := 0;
    end;
    BearingSequenceList[bearingSequence] := resultSeq;
  end;
end;
}
procedure TGenericSonar.ShiftRightBearingArc(const deg: integer;const bearingSequence: byte);
var
  i : integer;
begin
  for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
    SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i] + deg;
    if SlotBearingList[bearingSequence,i] >= 360 then
      SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i]-360;
    if SlotBearingList[bearingSequence,i] < 0 then
      SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i]+360;
  end;
end;

procedure TGenericSonar.ShiftBearingArcToTracked(const bearingSequence: byte);
var
  i : integer;
  deg : double;
  seq : byte;
  TrackedObject : TLabeledObject;
begin
  TrackedObject := LabeledObjects[TrackedObjectIndex];
  if TrackedObject <> nil then begin
    seq := bearingSequence;
    if seq = 255 then begin
      if MRangeList[0,0] >= MRangeList[1,0] then seq := 0
      else seq := 1;
    end;
    deg := TrackedObject.Bearing;//floor(CalcBearing(PositionX, PositionY, TrackedObject.PositionX, TrackedObject.PositionY));
    deg := deg - SlotBearingList[seq,0];
    deg := deg - 6; //center to object
    if deg < 0 then
      deg := deg + 360;
    if deg <> 0 then begin
      for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
        SlotBearingList[seq,i] := SlotBearingList[seq,i] + deg;
        if SlotBearingList[seq,i] >= 360 then
          SlotBearingList[seq,i] := SlotBearingList[seq,i]-360;
      end;
    end;
  end;
end;


procedure TGenericSonar.SetSelectedObject(const obj : TSimulationClass);
begin
  SelectedObject := obj;
  //SetCurrentBearingIndexToSelected;
end;

function TGenericSonar.GetSelectedObject: TSimulationClass;
begin
  Result := SelectedObject;
end;

function TGenericSonar.GetBearingSequence(const idx : integer;const bearingSequence: byte): integer;
begin
  Assert(idx < C_Sonar_Bearing_Slot_Number);
  Assert(idx >= 0);
  Assert(bearingSequence < 2);
  if bearingSequence <> 255 then
    Result := BearingSequenceList[bearingSequence,idx]
  else
    Result := BearingSequenceList[0,idx];
end;

procedure TGenericSonar.SetBearingSequence(const idx : integer; const Value : byte;const bearingSequence: byte);
begin
  if bearingSequence <> 255 then
    BearingSequenceList[bearingSequence,idx] := Value
  else
    BearingSequenceList[0,idx] := Value;
end;

procedure TGenericSonar.LabelSelectedObject(const s:integer; const range:double;const bearing : double);
var
  i : integer;
begin
  i := s-1;
  Assert (i>=0);
  if LabeledObjects[i] = nil then LabeledObjects[i] := TLabeledObject.Create;
  LabeledObjects[i].Range := range;
  LabeledObjects[i].Bearing := bearing;
  //if (SelectedObject <> nil) then begin
  LabeledObjects[i].SelectedObject := SelectedObject;
  //end;
end;

function TGenericSonar.GetObjectRangeinKYdInt(
  const obj: TSimulationClass): integer;
begin
  Result := round((CalcRange(PositionX, PositionY, obj.PositionX, obj.PositionY) * C_NauticalMiles_To_Yard)/1000);
end;

function TGenericSonar.GetObjectBearinginInt(
  const obj: TSimulationClass): integer;
begin
  Result := round(CalcBearing(PositionX, PositionY, obj.PositionX, obj.PositionY));
end;

function TGenericSonar.GetObjectDopplerSpeedinInt(
  const obj: TSimulationClass): integer;
begin
  if FSpeed >= (obj as TXSonarObject).Speed then
    Result := round(FSpeed-(obj as TXSonarObject).Speed)
  else
    Result := round((obj as TXSonarObject).Speed-FSpeed);
end;

procedure TGenericSonar.SetSpeed(const Value: double);
begin
  FSpeed := Value;
end;

function TGenericSonar.GetSpeed: double;
begin
  Result := FSpeed;
end;



procedure TGenericSonar.SetAudioLock(const isLocked: boolean;
  const bearing: double);
begin
  //if isLocked then
  //  FAudioBeamType := ALC
  //else
  //  FAudioBeamType := ASC;

  FBearingLock := bearing;
  //if SonarMode = OMNI then
  if isLocked then ShiftBearingArc(0);
end;

procedure TGenericSonar.ShiftBearingArc(const bearingSequence: byte);
var
  deltaDeg : double;
  i : integer;
begin
  deltaDeg := round(FBearingLock) - SlotBearingList[bearingSequence,0] - round(C_BearingShift/2);
  for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
    SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i] + deltaDeg;
    if SlotBearingList[bearingSequence,i] >= 360 then
      SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i]-360;
    if SlotBearingList[bearingSequence,i] < 0 then
      SlotBearingList[bearingSequence,i] := SlotBearingList[bearingSequence,i]+360;
  end;
end;

procedure TGenericSonar.SetAudioGate(const isLocked: boolean;
  const lbl: integer);
begin
  //set audio mode to audio gate
  if isLocked then begin
    FAudioBeamType := AG;
    TrackedObjectIndex := lbl-1;
    ShiftBearingArcToTracked(0);
  end
  else begin
    FAudioBeamType := ASC;
  end;
end;


procedure TGenericSonar.PlayObjectSound(const UID:string; const soundfname: string;
  const volume: integer;const loop : boolean);
begin
  if FSoundOn then begin
    if soundfname = '' then begin
      //if SoundPlayer <> nil then SoundPlayer.PlayMP3(UID,'sonar2.wav',volume,loop);
    end
    else begin
      if SoundPlayer <> nil then SoundPlayer.PlayMP3(UID,soundfname,volume,loop);
    end;
  end
  else begin
    if soundfname = '' then begin
      //if SoundPlayer <> nil then SoundPlayer.PlayMP3(UID,'sonar2.wav',0,loop);
    end
    else begin
      if SoundPlayer <> nil then SoundPlayer.PlayMP3(UID,soundfname,0,loop);
    end;
  end;
end;

procedure TGenericSonar.PlayObject2DSound(const UID, soundfname: string;
  const bearing, range, speed: double;const Volume : integer;const loop : boolean);
begin
  if FSoundOn then begin
    if soundfname = '' then begin
      //if SoundPlayer <> nil then
      //  SoundPlayer.PlayObject2DSound(UID,'sonar2.wav',bearing, range, speed, Volume,loop);
    end
    else begin
      if SoundPlayer <> nil then
        SoundPlayer.PlayObject2DSound(UID,soundfname,bearing, range, speed, Volume,loop);
    end;
  end;{
  else begin
    if soundfname = '' then begin
      if SoundPlayer <> nil then
        SoundPlayer.PlayMP3(UID,'sonar2.wav',0);
    end
    else begin
      if SoundPlayer <> nil then SoundPlayer.PlayMP3(UID,soundfname,0);
    end;
  end; }
end;

procedure TGenericSonar.PauseMP3(const UID, FileName: string);
begin
  if FSoundOn then begin
    if FileName <> '' then begin
      if SoundPlayer <> nil then
        SoundPlayer.PauseMP3(UID,FileName);
    end;
  end;
end;

procedure TGenericSonar.SetSoundOn(const Value: boolean);
begin
  FSoundOn := Value;
  if SoundPlayer <> nil then SoundPlayer.MuteAllMP3;
end;

procedure TGenericSonar.SetSoundVolume(const Value: integer);
begin
  FSoundVolume := Value;
  if SoundPlayer <> nil then SoundPlayer.Volume := Value;
end;

procedure TGenericSonar.SetNotchMeter(const Value: integer);
begin
  FNotchMeter := Value;
end;

function TGenericSonar.GetNotchMeter: integer;
begin
  Result := FNotchMeter;
end;

procedure TGenericSonar.SetSoundVelocity(const Value: double);
begin
  FSoundVelocity := Value;
end;

procedure TGenericSonar.SetDetLevel(const Value: integer);
begin
  //FDetLevel := ((10-Value)/10)*230;
  FDetLevel := ((Value+1)/10)*230;
end;

procedure TGenericSonar.SetTVG(const Value: integer);
begin
  FTVG := Value;
end;

function TGenericSonar.GetDetLevel: integer;
begin
  Result := round((FDetLevel/230)*10)+1;
end;

{ TLabeledObject }

procedure TLabeledObject.SetBearing(const Value: double);
begin
  FBearing := Value;
end;

procedure TLabeledObject.SetRange(const Value: double);
begin
  FRange := Value;
end;

procedure TLabeledObject.SetSelectedObject(
  const Value: TSimulationClass);
begin
  FSelectedObject := Value;
end;


procedure TGenericSonar.SetBackGroundSoundFName(const Value: string);
begin
  FBackGroundSoundFName := Value;
end;

procedure TGenericSonar.SetPingSoundFName(const Value: string);
begin
  FPingSoundFName := Value;
end;

{ TSonarSoundPlayer }
procedure TSonarSoundPlayer.PlayObject2DSound(const UID, fname: string;
  const bearing, range, speed: double;const Volume : integer;const loop: boolean);
var
  posx, posy : double;
begin
  posx := range * cos(DegToRad(ConvCompass_To_Cartesian(bearing)));
  posy := range * sin(DegToRad(ConvCompass_To_Cartesian(bearing)));
  //set to 0 .. 1
  posx := posx/C_RANGE_OF_SOUND_IN_20M;
  posy := posy/C_RANGE_OF_SOUND_IN_20M;
  Play2DMP3(UID,fname,posx, posy, speed, Volume,loop);
end;

procedure TSonarSoundPlayer.SetMovement(const heading, speed: double);
begin
  SetListener2DPos(0,0,ConvCompass_To_Cartesian(heading),speed);
end;



procedure TGenericSonar.SetBearingLock(const Value: double);
begin
  FBearingLock := Value;
  ShiftBearingArc(0);
end;

procedure TGenericSonar.SetAudioBeamType(const Value: audiobeamloc);
begin
  if Value = ASC then begin
    if (FAudioBeamType = ASC) and ALCLock then begin
      //ALClock termination
      ALCStart := -1;
      ALCEnd := -1;
      ALCLock := false;
    end;
  end
  else if Value = ALC then begin
    if ALCStart < 0 then begin
      ALCStart := FBearingLock;//SlotBearingList[0,0];//
    end
    else if ALCEnd < 0 then begin
      ALCEnd := FBearingLock;//SlotBearingList[0,0];//
      ALCLock := true;
    end
    else begin
      ALCStart := FBearingLock;//SlotBearingList[0,0];//
      ALCEnd := -1;
      ALCLock := false;
    end;
  end
  else if Value = AG then begin
  end;
  FAudioBeamType := Value;
end;
{
procedure TGenericSonar.SetCassetteMode(const Value: boolean);
begin
  //FCassetteMode := Value;
  if Value then FSonarMode := PLAYCASSETTE
  else FSonarMode := LISTEN;
end;

function TGenericSonar.GetCassetteMode: boolean;
begin
  if FSonarMode = PLAYCASSETTE then Result := true
  else Result := false;
end;

procedure TGenericSonar.SetQOTMode(const Value: boolean);
begin
  if Value then FSonarMode := QOT
  else FSonarMode := LISTEN;
end;

function TGenericSonar.GetQOTMode: boolean;
begin
  if FSonarMode = QOT then Result := true
  else Result := false;
end;
}

procedure TGenericSonar.SetAfterPingSoundFName(const Value: string);
begin
  FAfterPingSoundFName := Value;
end;

end.

