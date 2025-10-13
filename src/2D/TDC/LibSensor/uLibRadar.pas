unit uLibRadar;
(*
  Created       : 14 August 2007
  Last Modified : 14 August 2007

  Author        : Andy Sucipto
  Description   : Radar class for Emulator Client2D

*)


interface

  uses
    Graphics, MapXLib_TLB,
    uBaseSimulationObject, uBaseSensor, uLibRadarComp, uLibRadarView, uMapXSim,
    uDetected, uObjectView;

  const
    C_Max_Freq_Slot = 16;


//==============================================================================
  type



//==============================================================================
    tPolarizationDirection = (pdHorizontal, pdVertical);
    tFrequencyMode = (fmFixed, fmAgile);
//==============================================================================
    // radar pulsed signal
{    tRadarSignal = class
    private
      FFrequency: double;
      FWavelength: double;
      procedure SetFrequency(const Value: double);
      procedure SetWavelength(const Value: double);

    public
      property Frequency   : double read FFrequency write SetFrequency;
      property Wavelength  : double read FWavelength write SetWavelength;  //from freq
    end;
}

//==============================================================================

    //  TClientRadar = class(TBaseSensor)
    TClientRadar = class(TSimClassOnMapX)
    private

      FDirection : double;

      FCurTimeBasePos,
      FPrevTimeBasePos  : double;
      FHorizontalBeamWidth: double;
      FVerticalBeamWidth: double;
      FAveratePower: double;

      FFrequencyMode: tFrequencyMode;
      FMin_Frequency: double;
      FMax_Frequency: double;

//      DirectionMode : TDirectionMode;
      function GetDirection: double;                    // Compass
      procedure SetDirection(const Value: double);
      procedure SetFrequencyMode(const Value: tFrequencyMode);
    procedure SetMax_Frequency(const Value: double);
    procedure SetMin_Frequency(const Value: double);

    protected
      FrequencySlot  : array [0 .. C_Max_Freq_Slot] of double;
      FrequencyIndex : byte;

      FFrequency      : double;
      FWavelength     : double;

      FPRF            : double;
      FDetectionRange : double;                              // Cartesian 0 .. 360

      FPulseWidth       : double;
      FRangeResolution  : double;

      FMTI_ON: boolean;


      procedure SetFrequency(const Value: double);
      procedure SetWavelength(const Value: double);

      procedure SetDetectionRange(const Value: double);
      procedure SetPRF(const Value: double);

      procedure SetPulseWidth(const Value: double);
      procedure SetRangeResolution(const Value: double);

      procedure SetHorizontalBeamWidth(const Value: double);
      procedure SetVerticalBeamWidth(const Value: double);

      procedure SetAveratePower(const Value: double);
      // Radar Mode Operation
      // 1. transmittion mode
{     procedure Scan_HORIZONTAL;
      procedure Scan_HELICAL;

      procedure Polarization_HORIZONTAL;
      procedure Polarization_CIRCULAR;

      procedure Frequency_FIX;
      procedure Frequency_AGILITY;

      procedure PulseRepetitionFreq_LOW;
      procedure PulseRepetitionFreq__HIGH;

      procedure AUTO_ON;

      procedure RADAR_SILENCE_ON;

      // 2. wm radar receiver
      procedure Search_Amplifier_LOGARITHMIC;
      procedure Search_Amplifier_LINEAR;
      procedure Search_DICKE_FIX;

      procedure Pulse_Length_Dicrimination;

      procedure Interference_Supression_Unit;
      procedure Quantiser;

      procedure Sensitif_Time_Control;

      procedure Moving_Target_Indicator;
      procedure MTI_Correction_COURSE;
      procedure MTI_Correction_SPEED;

      procedure Pulse_Amplitude_Tracking;
      procedure Pulse_Doppler_Tracking;

}
//      procedure ProcessObjectOnHitByTimeBase();
      procedure SetMTI_ON(const Value: boolean);
    protected
    // dipanggil dari RadarProcess(org: TObjectContainer);
      {1.x}
      function FindByRangeBearing(const r, b: double; var obj: TDetectedObject): boolean;
      procedure RangeBearingToCoord(const r, b: double; var mx, my : double);
      {1.1}
      procedure RadarProcess_MTI;
      {1.2}
      procedure RadarProcess_FrequencyAgile;
      {1.3}
      procedure RadarProcess_Signal;

    public
      // Radar parts............................................................
      DisplayArea   : TRadarAreaView;     //ok

      TimeBase      : TRadarTimebase;     //ok
      TimeBaseView  : TRadarTimeBaseView; //ok

      SectorView    : TRadarSectorView;   //ok
      PolarView     : TRadarPolarView;    //ok

      constructor Create;
      destructor Destroy; override;

      {0}
      procedure Run(const aDeltaMs: double);   override;
      procedure Update; override;

      procedure CreateDefaultView(const aMap: TMap); override;

      procedure ConvertViewsPosition(); override;
      procedure DrawViews(aCnv: TCanvas); override;


    public
      // Detected object ............................................................
      DetObjects : TObjectContainer;
      TmpDet     : TDetectedObject;

      {1}
      procedure RadarProcess(org: TObjectContainer; const gCount: LongWord);

    published
      property Direction: double                // arah radar, bukan arah timebase
          read GetDirection write SetDirection; // jika radar kapal, ikut halu kapal

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



  // BELUM //------------------------------------
      property AveratePower: double read FAveratePower write SetAveratePower;
      //property EffectivePower : double; // KW

      //AntenaType   : string;
      //PolarizationDirection : tPolarizationDirection;


    end;

///////////////////////////////////////////////////////////////////////////////
   TWM_Radar = class(TClientRadar)


   end;

   TDA_Radar = class (TClientRadar)

   end;
///////////////////////////////////////////////////////////////////////////////

implementation

uses
  Classes, uTDCManager, uBaseConstan, uBaseDataType, uBaseFunction, Math;

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

constructor TClientRadar.Create;
var i: integer;
    deltaf:  double;
begin
  inherited;

//-display area;
  DisplayArea   := TRadarAreaView.CreateOnMapX(self,
      uTDCManager.SimCenter.Fmap);
  ViewContainer.AddObject(DisplayArea);
  DisplayArea.Visible := TRUE;

// time base
  TimeBase     := TRadarTimebase.Create;
  TimeBase.Enabled := TRUE;
  ObjectContainer.AddObject(TimeBase);

  TimeBaseView := TRadarTimeBaseView.CreateOnMapX(self,
      uTDCManager.SimCenter.Fmap);
  ViewContainer.AddObject(TimeBaseView);
  TimeBaseView.Color := $60A0ff;
  TimeBaseView.Visible := TRUE;


  SectorView := TRadarSectorView.CreateOnMapX(self,
      uTDCManager.SimCenter.Fmap);
  ViewContainer.AddObject(SectorView);
//  SectorView.Visible := true;

  PolarView := TRadarPolarView.CreateOnMapX(self,
      uTDCManager.SimCenter.Fmap);
  ViewContainer.AddObject(PolarView);
//  PolarView.Visible := true;

  DetObjects := TObjectContainer.Create;
//  DetViews   := TViewContainer.Create;


  FMin_Frequency :=  9000.0; // MHz;
  FMax_Frequency := 12000.0; // MHz;

  deltaf := (FMax_Frequency - FMin_Frequency) / C_Max_Freq_Slot;
  for i := 0 to C_Max_Freq_Slot do begin
    FrequencySlot[i] := FMin_Frequency + i * deltaf;
  end;

  FrequencyIndex := 0;
  SetFrequency(FrequencySlot[0]);

end;

destructor TClientRadar.Destroy;
begin
  ViewContainer.ClearObject;
  ObjectContainer.ClearObject;

  DetObjects.ClearObject;
  DetObjects.Free;


  inherited;
end;

// =============================================================================
function TClientRadar.GetDirection: double;
begin
  Result := ConvCartesian_To_Compass(FDirection);
end;

procedure TClientRadar.SetDirection(const Value: double);
begin
  FDirection := ConvCompass_To_Cartesian(Value);
//  if DirectionMode = then
  TimeBase.DirectionOffset := Value;
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TClientRadar.SetFrequency(const Value: double);
begin
  FFrequency := Value;
  FWavelength := ifThen(IsAlmostZero(Value), 0.0, (C_SPEED_OF_LIGHT / Value));
end;

procedure TClientRadar.SetWavelength(const Value: double);
begin
  FWavelength := Value;
  FFrequency  := ifThen(IsAlmostZero(Value), 0.0, (C_SPEED_OF_LIGHT / Value));
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TClientRadar.SetDetectionRange(const Value: double);
begin
  FDetectionRange := Value;
  FPRF :=ifThen(IsAlmostZero(Value), 0.0,
    0.5 * C_SPEED_OF_LIGHT / (Value * C_NauticalMiles_TO_Meter));
//  PolarView.RangeInterval := Value;
end;

procedure TClientRadar.SetPRF(const Value: double);
begin
  FPRF := Value;
  FDetectionRange :=  IfThen(IsAlmostZero(Value), 0.0,
    (C_Meter_To_NauticalMiles * 0.5 * C_SPEED_OF_LIGHT / Value));

end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TClientRadar.SetPulseWidth(const Value: double);
begin // input in Micro Second
  FPulseWidth := Value;
  FRangeResolution :=(0.5*(C_SPEED_OF_LIGHT*Value))
end;

procedure TClientRadar.SetRangeResolution(const Value: double);
begin
  FRangeResolution := Value;
  FPulseWidth := 2.0 * Value / C_SPEED_OF_LIGHT;
end;
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// =============================================================================
procedure TClientRadar.Update;
//var i : integer;
begin
  inherited;

  DetObjects.UpdateAllMemberObject

end;

procedure TClientRadar.Run(const aDeltaMs: double);
begin
//  inherited;
//  ObjectContainer.RunAllMemberObject(aDeltaMs);
//  TimeBase.CurrentDirection

  FPrevTimeBasePos := TimeBase.CurrentDirection; // compass
  TimeBase.Run(aDeltaMs);
  FCurTimeBasePos  := TimeBase.CurrentDirection; //
end;

procedure TClientRadar.CreateDefaultView(const aMap: TMap);
begin


end;

procedure TClientRadar.ConvertViewsPosition();
var i: integer;
    list: TList;
    obj : TSimClassOnMapX;
begin
  //inherited;  //-> convert self.viewcontainer.ConvertAllDataPosition;

  viewcontainer.ConvertAllDataPosition;

  //-> convert member's  view container.
  List := DetObjects.GetList;
  for i := 0 to List.Count-1 do begin
    obj := List[i];
    obj.ViewContainer.ConvertAllDataPosition;

  end;

  DetObjects.ReturnList;

end;

procedure TClientRadar.DrawViews(aCnv: TCanvas);
var i: integer;
    list: TList;
    obj : TSimClassOnMapX;
begin
//  inherited;  //-> convert self.viewcontainer.DrawAllview;
  ViewContainer.DrawAllview(aCnv);

  // DrawDetectedObjects;
  List := DetObjects.GetList;
  for i := 0 to List.Count-1 do begin
    obj := List[i];
    obj.ViewContainer.DrawAllView(aCnv);
  end;
  DetObjects.ReturnList;

end;


//==============================================================================
procedure TClientRadar.RangeBearingToCoord(const r, b: double; var mx, my : double);
var dRad  : extended;
    sinx, cosx: extended;
begin  // return *relatif* coord to radar center
  dRad := C_DegToRad * ConvCompass_To_Cartesian(b);
  SinCos(dRad, sinx, cosx);

  mx := r * cosx;
  my := r * sinx;
end;

function TClientRadar.FindByRangeBearing(const r, b: double; var obj: TDetectedObject): boolean;
var i: integer;
    found : boolean;
    list : TList;
begin  // bearingnya belum;

  list := DetObjects.GetList;
  found := false;
  i := 0;
  while not found and (i < list.Count) do begin
    obj := TDetectedObject(list[i]);

    found :=  abs(obj.DetRange -r) < FRangeResolution;

    inc(i);
  end;
  DetObjects.ReturnList;

  result :=  found;
end;

procedure TClientRadar.RadarProcess_MTI;
const
  C_MTI_Speed_tolerance = 10.0; // knots
var i : integer;
    list : TList;
    dObj : TDetectedObject;
begin
  list := DetObjects.GetList;

  for i := list.Count-1 downto 0 do begin

    dObj := list.Items[i];
    if dObj.DetSpeed < C_MTI_Speed_tolerance then
      dObj.Visibles :=  false;
  end;

  DetObjects.ReturnList;
end;

procedure TClientRadar.RadarProcess_FrequencyAgile;
begin
  FrequencyIndex := RANDOM(C_Max_Freq_Slot+1);
  SetFrequency(FrequencySlot[FrequencyIndex]);
end;

procedure TClientRadar.RadarProcess_Signal;
var i : integer;
    list : TList;
    dObj : TDetectedObject;
begin
  list := DetObjects.GetList;

  for i := list.Count-1 downto 0 do begin

    dObj := list.Items[i];

  end;

  DetObjects.ReturnList;
end;


procedure TClientRadar.RadarProcess(org: TObjectContainer; const gCount: LongWord);
{ radar processing routine
  input  : org -> 'real' object -> syncrhonized with network ;
  output : in ObjectContainer, processes & viewed;
}
var i: integer;
    rObj, dObj : TSimulationClass;
    list : TList;
    dpt1 : t2DPoint;
    range, bearing, elev, px, py: double;

begin
  list := org.GetList;

  // Detect object by range and bearing;

  for i := 0 to list.Count -1  do begin
    rObj := list[i];

    range   := CalcRange(PositionX, PositionY, rObj.PositionX, rObj.PositionY);
    bearing := CalcBearing(PositionX, PositionY, rObj.PositionX, rObj.PositionY);

    elev    := CalcElevation(range, PositionZ, rObj.PositionZ);
    //if not  elev in VerticalBeamWidth

    if not DegComp_IsBeetwen(bearing, FPrevTimeBasePos, FCurTimeBasePos) then
      Continue;

    if (range > FDetectionRange) then
      Continue;

//    if not FindByRangeBearing(range, bearing, tmpDet) then
    dObj := DetObjects.FindObjectByUid(rObj.UniqueID);
    if (dObj = nil) then begin
      TmpDet := TDetectedObject.Create;
      TmpDet.UniqueID := rObj.UniqueID;
      TmpDet.CreateDefaultView(uTDCManager.SimCenter.FMap);
      TmpDet.Enabled := TRUE;
      DetObjects.AddObject(tmpDet);
    end
    else
      TmpDet := dObj as TDetectedObject;


    TmpDet.DetRange   := range;
    TmpDet.DetBearing := bearing;
    RangeBearingToCoord(range, bearing, dPt1.X, dPt1.Y);

    pX := PositionX + dPt1.X * C_NauticalMile_To_Degree;
    pY := Positiony + dPt1.Y * C_NauticalMile_To_Degree;

    TmpDet.SetDetectedPosition(px, pY, 0, gCount);
//CHEAT
//    tmpDet.DetSpeed  := 0;
//    tmpDet.Dethead  := 0;

  end;

  // hasil proces di atas ada di list DetObject;
  // isinya semua object yg berada di dalam range radar.
  org.ReturnList;
  if FrequencyMode = fmAgile then begin
    // return warning MTI NOT AVAILABLE;
     RadarProcess_FrequencyAgile;

  end;

  if FFrequencyMode = fmFixed then begin
    if FMTI_ON then
      RadarProcess_MTI

  end;

 // RadarProcess_Signal;

end;

procedure TClientRadar.SetHorizontalBeamWidth(const Value: double);
begin
  FHorizontalBeamWidth := Value;
end;

procedure TClientRadar.SetVerticalBeamWidth(const Value: double);
begin
  FVerticalBeamWidth := Value;
end;


procedure TClientRadar.SetAveratePower(const Value: double);
begin
  FAveratePower := Value;
end;

procedure TClientRadar.SetMTI_ON(const Value: boolean);
begin
  FMTI_ON := Value;
end;

procedure TClientRadar.SetFrequencyMode(const Value: tFrequencyMode);
begin
  FFrequencyMode := Value;
end;

procedure TClientRadar.SetMax_Frequency(const Value: double);
begin
  FMax_Frequency := Value;
end;

procedure TClientRadar.SetMin_Frequency(const Value: double);
begin
  FMin_Frequency := Value;
end;

end.

