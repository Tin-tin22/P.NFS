{
  for initialize record before send to network
}

unit uInitializeRecord;

interface

uses
  uNetwork_Data_TCMS;

  //initialize before send
  function InitializeTRec_Data_Gun76 : TRec_Data_Gun76;
  function InitializeTRec_Data_GIC76 : TRec_Data_GIC76;
  function InitializeTRec_Data_MW08 : TRec_Data_MW08;
  function InitializeTRec_Data_Area_MW08 : TRec_Data_Area_MW08;
  function InitializeTRec_Data_ScenarioSync : TRec_ScenarioSync;
  function InitializeTRec_FireTorpedoA244 : TRec_FireTorpedoA244;
  function InitializeTRec_State_Exocet : TRec_State_Exocet;
  function InitializeTRec_B515TubeContent : TRec_B515TubeContent;
  function InitializeTRec_Data_A244 : TRec_Data_A244;
  function InitializeTRec_Torpedo_ConfirmTarget : TRec_Torpedo_ConfirmTarget;
  function InitializeTRec_Data_DecoySim : TRec_Data_DecoySim;
  function InitializeTRec_Data_TRec_Data_DecoySysModeChg : TRec_Data_DecoySysModeChg;
  function InitializeTRec_Data_DecoyLauncher : TRec_Data_DecoyLauncher;
  function InitializeTRec_Data_DecoyController : TRec_Data_DecoyController;
  function InitializeTRec_Decoy_LaunchQueue : TRec_Decoy_Queue;
  function InitializeTRec_Decoy_FiringQueue : TRec_Decoy_Queue;
  function InitializeTRec_Decoy_Firing : TRec_Decoy_Firing;
  function InitializeTRec_Stationing_RefObj : TRec_Stationing_RefObj;
  function InitializeTRec_NavData_Stationing : TRec_NavData_Stationing;
  function InitializeTRec_Data_Target_Exocet : TRec_Data_Target_Exocet;
  function InitializeTRec_Data_DecoyLCC : TRec_Data_Decoy_LCC;
  function InitializeTRec_DecoyDesigOps : TRec_Decoy_Desig_Ops;
  function InitializeTRec_Data_DecoyAuto : TRec_Data_DecoyAuto;
  function InitializeTRec_InitDecoyFiring : TRec_Data_Init_Decoy_Firing;

  {NGS}
  function InitializeTRec_Data_NGS : TRec_Data_NGS;
  function InitializeTRec_NGS_Target : TRec_NGS_Target;

  {LIROD}
  function InitializeTRec_LIROD : TRec_LIROD_MK2;
  
  {SS}
  function InitializeTRec_Data_SectorScreen : TRec_Data_SectorScreen;
  function InitializeTRec_SectorScreen_Object : TRec_SectorScreen_Object;

  function InitializeTRec_Plan_Missile : TRec_Plan_Missile;
  function InitializeTRec_Missile_Parameter : TRec_Missile_Parameter;
  function InitializeTRec_Missile_Firing_Squence : TRec_Missile_Firing_Squence;

  function InitializeTRec_TrackMovement : TRec_Track_Movement;

  function InitializeTRec_TDS_Data : TRec_TDS_Data;
  function InitializeTRec_nav_Zigzag : TRec_Data_Nav_ZigzagPlan;
  function InitializeTRec_pl_nav_Zigzag : TRec_Data_Pl_Nav_ZigzagPlan;
  function initializeTRec_Data_Nav_ZigzagCatalogueValue : TRec_Data_Nav_ZigzagCatalogueValue;

  function InitializeTRec_Sonar_Envi: TRec_Sonar_Envi;

  function InitializeTRec_Threat_Eval_Values: TRec_Threat_Eval_Values;

  function InitializeTRec_TrackSelAirSetting: TRec_TrackSelAirSetting;
  function InitializeTRec_EvalTracklist: TRec_Eval_Tracklist;


  {PAC}
  function InitializeTRec_Pac_Data : TRec_PAC_Data;
  function InitializeTRec_Pac_Target : TRec_PAC_Target;

  function InitializeTRec_MW08_Simulator : TRec_MW08_Simulator;

  {ASW Danger Zones, Torpedo Danger Zones, and LLOA}
  function InitializeTRec_ASW_Danger_Zones : TRec_ASWDangerZones;
  {ECM} {icha}
  function IntializeTRec_ECMEngagement : TRec_ECMEngagement;
  function InitializeTRec_ECMSimulator : TRec_ECMSimulator;
  function InitializeTRec_ECMAuth      : TRec_ECMEAuth;

  {EMCON -icha}
  function InitializeTRec_EmconPlan1 : TRec_EmconPlan1;
  function InitializeTRec_EmconPlan2 : TRec_EmconPlan2;

  {HoldFire Report Definition}
  function InitializeTRec_Holdfire_Report_Definition : TRec_HoldfireReportDef;

  {Throw Off Control}
  function InitializeTRec_Throw_Off_Control : Trec_Throw_Off_Control;

  function InitializeTRec_GameTimeSync : TRec_GameSync;

  function InitRec_ESMDataReq: TESM_DataReq;

  function InitializeTRec_ECM_Jam : TRec_ECM_Jam;

  {IFF Plot Data}
  function InitializeTRec_Data_IFF_Plot : TRec_Data_IFF_Plot;
  function InitializeTRec_Data_IFF_Plot_Monit : TRec_Data_IFF_Monit;
  function InitializeTRec_ExocetMM40_Movement : TRec_ExocetMM40_Movement;

  {Track Monitor}
  function initializeTRec_Track_Monitor_Data : TRec_Track_Monitor;

  {Tactical Figure}
  function InitializeTRec_List_Tactical_Figur : Trec_List_Tactical_Figure;
  function InitializeTRec_Visual_Tactical_Figur : TRec_Visual_Tactical_Figure;
  function InitializeTRec_Visual_Tactical_Figur_Group : TRec_Visual_Tactical_Figure_Group;
  function InitializeTRec_Visual_Polygon : TRec_Visual_Polygon;
  function initializeTRec_Visual_Polyline : TRec_Visual_Polyline;

  {Geographic Situation}
  function InitializeTRec_List_Geo_Situation: TRec_List_Geographic_situation;
  function InitializeTRec_Visual_Geo_Fig: TRec_Visual_Geo_Fig;

  {IFF Simulator}
  function InitializeTRec_IFF_Simulator : TRec_IFF_Simulator;
  function InitializeTRec_IFF_TranspondCtrl : TRec_IFF_TranspondCtrl;
  function InitializeTRec_IFF_TranspondMC : TRec_IFF_TranspondMC;
  function InitializeTRec_IFF_Interrogations : TRec_IFF_Interrogations;

  {Area Alert}
  function initializeTRec_Area_Alert_Warning : TRec_Area_Alert_Warning;
  function initializeTRec_LinkY_Setting : TRec_LinkY_Setting;

  function initializeTRec_SelWasaChannel : TRec_SelWasaChannel;
  function initializeTRec_WasaChanProp : TRec_WasaChanProperties;
  function initializeTRec_ARPA_DetectedTrack : TRec_ARPA_DetectedTrack;
  function initializeTRec_ASWUnit : TRec_ASWUnit;

  function InitializeTRec_Data_Fire_Tetral : TRec_Data_Fire_Tetral;
  function InitializeTRec_Object_Data : TRec_Object_Data;

  {OS Environment}
  function InitializeTRec_Magnetic_Var : TRec_Magnetic_Var;
  function initializeTRec_Barometric_Pressure : TRec_Barometric_Pressure;
  function InitializeTRec_Humidity : TRec_Humidity;
  function initializeTRec_Air_Temperature : TRec_Air_Temperature;
  function initializaTrec_Wind : TRec_Wind;
  function initializeTRec_Depth : TRec_Depth;
  function initializeTRec_Drift : TRec_Drift;
  function initializeTRec_RelOSEnvi : TRec_Relative_OS_Poss;
  function initializeTRec_Envi_DateTime : TRec_Envi_Date_Time;

  {IFF Sector}
  function initializeTRec_Data_IFF_Sector_List : TRec_Data_IFF_Sector;

implementation

  function InitializeTRec_Object_Data : TRec_Object_Data;
  begin
    with result do
    begin
      SessionID := 0;
      objectIdx := 0;
      objectID := '';
      HookIDObj := '';
      ParentID := '';
      OrderID := 0;
      SenderForm := 0;
      TacticalMode := 0;
      EnterHook := False;
      EnterPosX := False;
      EnterPosY := False;
      EnterHeading := False;
      EnterTurnRate := False;
      EnterSpd := False;
      EnterAccel := False;
      EnterAltDepth := False;
      EnterCliDiveRate := False;
      ClassName := '';
      ObjName := '';
      Identity := 0;
      Speed := 0;
      Heading := 0;
      TurnRate := 0;
      Acceleration := 0;
      ClmbRate := 0;
      ImmediateSpd := False;
      ImmediateClm := False;
      ImmediateHdg := False;
      PosX := 0;
      PosY := 0;
      VerticalAlt := 0;
      CreateFrom := 0;
      MocName := 0;
      EntryRelCrsMode := 0;
      EntryRelSpdMode := 0;

      IFFMode1  := 0;
      IFFMode2  := 0;
      IFFMode3A := 0;
      IFFMode4  := 0;
      IFFSpec   := 0;

    end;
  end;


  function initializeTRec_ASWUnit : TRec_ASWUnit;
  begin
    with Result do
    begin
      SessionID := 0;
      SigmaID := '';
      OrderID := 0;
      ObjectID := '';
      PCode := '';
      UnitName := '';
      PosX := 0;
      PosY := 0;
      METFR := 0;
      Display := False;
    end;
  end;

  function InitializeTRec_Data_Fire_Tetral : TRec_Data_Fire_Tetral;
  begin
    with REsult do
    begin
      objectID := '';
      TargetID := '';
      TetralID := 0;
      ObjectIdx := 0;
      ProjectileID := '';
      ObjectName := '';
      ObjectName    := '';
      Enable         := False;
      TargetCourse   := 0.0;
      TargetSpeed   := 0.0;
      RangeMissile   := 0.0;
      BearingMissile := 0.0;
      Visible        := False;
      LauncherNumber := 0;
      Speed          := 0.0;
      TargetBearing  := 0.0;
      TargetRange    := 0.0;
    end;
  end;

  function initializeTRec_ARPA_DetectedTrack : TRec_ARPA_DetectedTrack;
  begin
    with Result do
    begin
      SessionID := 0;
      SigmaID := '';
      TrackID := '';
    end;
  end;

  function initializeTRec_LinkY_Setting : TRec_LinkY_Setting;
  begin
    with Result do
    begin
      SessionID := 0;
      SigmaID := '';

      isTXAuth := false;
      isRelayUnit := false;
      isAutoNTNAuth := false;
      isRadioSilence := false;
      isNetworkTest := false;
      isSlowPu := false;
      StationMode := 0;
      StationTime := 0;
      DLRPSetting := 0;
      DLRPGeoX := 0;
      DLRPGeoY := 0;
      DLRPObjectID := '';
      PlatFreq := 0;
      NTNLower := 0;
      NTNUpper := 0;
      Threshold := 0;
      SReportDelay := 0;
      OwnPU := 0;
      OrderLoopTest := 0;
      ShortLoopTest := 0;
      LongLoopTest := 0;
      Modem := 0;
      Encryption := 0;
      OperStatus := 0;
    end;
  end;

  function InitializeTRec_ExocetMM40_Movement : TRec_ExocetMM40_Movement;
  begin
    With Result do
    begin
      SessionID := 0;
      SigmaID := '';
      ObjectID := '';
      TargetObjectID := '';
      PosX := 0;
      PosY := 0;
      Elevation := 0;
      Heading := 0;
      Speed := 0;
      TargetPosX := 0;
      TargetPosY := 0;
      LaunchPosX := 0;
      LaunchPosY := 0;
      MovingStep := 0;
      LauncherDegree := 0;
      LauncherNumber := 0;
      TrajectoryType := 0;
      TrjctoryHighRng := 0;
      TrjctoryBOLBrng := 0;
      trjctoryHeading := 0;
      FarDistance := 0;
      NearDistance := 0;
      LSearchAngle := 0;
      RSearchAngle := 0;
      RangeToGo := 0;
      FirstLaunchX := 0;
      FirstLaunchY := 0;
      SecondLaunchX := 0;
      SecondLaunchY := 0;
      InitialStep := 0;
      ObstacleLength := 0;
      AngularApproach := 0;
      TerminalMan := 0;
      SearchMode := 0;
      Masking := 0;
      TargetPriority := 0;
      SearchCriterion := 0;
      Proximity := 0;
      RangeMax := 0;
      RangeHit := 0;
    end;
  end;

  function InitializeTRec_IFF_Simulator : TRec_IFF_Simulator;
  begin
    with Result do
    begin
      SigmaID := '';
      Online := 1;
      Availability := 1;
      Failure := 1;
      Interrogation := 1;
      Transpond := 1;
    end;
  end;

  function initializeTRec_IFF_TranspondCtrl : TRec_IFF_TranspondCtrl;
  begin
    with Result do
    begin
      SigmaID := '';
      TransmitAvail := 1;
      TransmitCtrl := 1;
      Mode1On := 1;
      Mode2On := 1;
      Mode3On := 1;
      Mode4On := 1;
      Mode4AOn := 1;
      Mode4BOn := 1;
      Mode4S1On := 1;
      Mode4S2On := 1;
      TranspondAdd := 1;
      Mode1Val := '';
      Mode2Val := '';
      Mode3Val := '';
      TransponderAdd := '';
    end;
  end;

  function InitializeTRec_IFF_Interrogations : TRec_IFF_Interrogations;
  begin
    with Result do
    begin
      SigmaID := '';
      TransmitAvail := 1;
      TransmitCtrl := 1;
      OmniMode1 := 1;
      OmniMode2 := 1;
      OmniMode3A := 1;
      OmniMode4 := 1;
      OmniModeC := 1;
      BeginRng := 0;
      EndRng := 0;
      DispIFFSector := 1;
      DispIFFBlankSector := 1;
      ZeroIFF := False;
    end;
  end;

  function InitializeTRec_IFF_TranspondMC : TRec_IFF_TranspondMC;
  begin
    with Result do
    begin
      SigmaID := '';
      ModeSIFreply := 1;
      ModeSecureR := 1;
      ModeSecureC := 1;
      JammingStat := 1;
    end;
  end;

  function InitializeTRec_Data_IFF_Plot : TRec_Data_IFF_Plot;
  begin
    with Result do
    begin
      OrderID := 0;
      SessionID := 0;
      ObjectId := '';
      TN := '';
      Mode1 := '';
      Mode2 := '';
      Mode3 := '';
      Mode4 := '';
      SpcCode := '';
      Brn := 0;
      Rng := 0;
    end;
  end;

  function InitializeTRec_Data_IFF_Plot_Monit : TRec_Data_IFF_Monit;
  begin
    with Result do
    begin
      OrderID := 0;
      SessionID := 0;
      ObjectId := '';
      Visible := False;
      DeltaRadX := 0;
      DeltaRadY := 0;
      SqrRadX   := 0;
      SqrRadY   := 0;
      VisibleIFFMode1 := False;
      VisibleIFFMode2 := False;
      VisibleIFFMode3 := False;
      VisibleIFFDisplay := False;
      VisibleIFFMonit := False;
    end;
  end;

  function InitializeTRec_List_Tactical_Figur : Trec_List_Tactical_Figure;
  begin
    with result do
    begin
      OrderID := 0;
      SessionID := 0;

      Visible := False;
      Active := False;
      TFigureName := '';
      TRelatedFigur := '';
      Envi := '';
      FigureScope := '';
      FigureRef := '';
      FigureType := '';
    end;
  end;

  function InitializeTRec_Visual_tactical_Figur : TRec_Visual_Tactical_Figure;
  begin
    with Result do
    begin
      SessionID := 0;
      ObjectID := '';
      Visible := False;
      Selected := False;
      FigureCopy := False;
      FigureSave := False;
      ParentGroup := False;
      GroupAll := False;
      PosX1 := 0;
      PosY1 := 0;
      PosX2 := 0;
      PosY2 := 0;
      XMapMin := 0;
      YMapMin := 0;
      XMapMax := 0;
      YMapMax := 0;
      CenterX := 0;
      CenterY := 0;
      FigurBrn := 0;
      FigurRng := 0;
      OffsetRng := 0;
      OffsetBrn := 0;
      PenStyle := 0;
      GDITranparent := 0;
      HatchStyle := 0;
      FillAlpha := 0;
      CLContour := 0;
      CLFill := 0;
      PenWidth := 0;
      VisualShape := 0;
      Radius := 0;
      CircleRadius := 0;
      SquareRadius := 0;
      PieRadius := 0;
      PieStartArch := 0;
      PieEndArch := 0;
      PieDrawMode := 0;
      RingHighRad := 0;
      RingLowRad  := 0;
      RingStartArch := 0;
      RingEndArch := 0;
      RingDrawMode := 0;
      IconIndex := 0;
      IconContourCl := 0;
      NameFig := '';
      RefID := '';
      RefType := 0;
    end;
  end;

  function InitializeTRec_Visual_Tactical_Figur_Group : TRec_Visual_Tactical_Figure_Group;
  begin
    with Result do
    begin
      SessionID := 0;
      ObjectID := '';
      GrpActive := False;
      GrpSelected := False;
      XMapGmax := 0;
      YMapGMax := 0;
      XMapGmin := 0;
      YMapGmin := 0;
    end;
  end;

  function InitializeTRec_Visual_Polygon : TRec_Visual_Polygon;
  begin
    with Result do
    begin
      SessionID := 0;
      ObjectID := '';
      ListLineID := 0;
      Visible := False;
      Selected := False;
      PenWidth := 0;
      PenStyle := 0;
      CLContour := 0;
      PosX1 := 0;
      PosX2 := 0;
      PosY1 := 0;
      PosY2 := 0;
      LineBrn := 0;
      LineRng := 0;
      RefID := '';
      RefType := 0;
      LineOffsetX := 0;
      LineOffsetY := 0;
    end;
  end;

  function initializeTRec_Visual_Polyline : TRec_Visual_Polyline;
  begin
    with Result do
    begin
      SessionID := 0;
      ObjectID := '';
      ListLineID := 0;
      Visible := False;
      Selected := False;
      PenWidth := 0;
      PenStyle := 0;
      CLContour := 0;
      PosX1 := 0;
      PosX2 := 0;
      PosY1 := 0;
      PosY2 := 0;
      LineBrn := 0;
      LineRng := 0;
      RefID := '';
      RefType := 0;
      LineOffsetX := 0;
      LineOffsetY := 0;
    end;
  end;

function InitializeTRec_List_Geo_Situation: TRec_List_Geographic_situation;
begin
  with result do
  begin
    OrderID := 0;
    SessionID := 0;

    Visible := False;
    Active := False;
    GeoName := '';
  end;

end;


function InitializeTRec_Visual_Geo_Fig: TRec_Visual_Geo_Fig;
begin
  with result do
  begin
    SessionID := 0;
    objectID := '';
    Visible := False;
    Selected := False;
    FigureCopy := False;
    FigureSave := False;
    ParentGroup := False;
    GroupAll := False;
    PosX1 := 0;
    PosY1 := 0;
    PosX2 := 0;
    PosY2 := 0;
    XMapMin := 0;
    YMapMin := 0;
    XMapMax := 0;
    YMapMax := 0;
    CenterX := 0;
    CenterY := 0;
    FigurBrn := 0;
    FigurRng := 0;
    OffsetRng := 0;
    OffsetBrn := 0;
    PenStyle := 0;
    GDITranparent := 0;
    HatchStyle := 0;
    FillAlpha := 0;
    CLContour := 0;
    CLFill := 0;
    PenWidth := 0;
    VisualShape := 0;
    Radius := 0;
    CircleRadius := 0;
    SquareRadius := 0;
    PieRadius := 0;
    PieStartArch := 0;
    PieEndArch := 0;
    PieDrawMode := 0;
    RingHighRad := 0;
    RingLowRad := 0;
    RingStartArch := 0;
    RingEndArch := 0;
    RingDrawMode := 0;
    IconIndex := 0;
    IconContourCl := 0;
    NameGeo := '';
    RefID := '';
    RefType := 0;
  end;
end;
function initializeTRec_Area_Alert_Warning : TRec_Area_Alert_Warning;
  begin
    with Result do
    begin
      SessionID := 0;
      ObjectID := '';
      TgtNumber := '';
      AreaName := '';
      AreaEnvi := '';
      Alert := False;
      IsAreaActive := False;
      IsAlertActive := False;
      IsEnterActive := False;
      IsExitActive := False;
    end;
  end;

  function initializeTRec_Track_Monitor_Data : TRec_Track_Monitor;
  begin
    with Result do
    begin
      OrderID := 0;
      SessionID := 0;
      CheckID   := 0;
      NameTrack := '';
      Identity  := 0;
      Envi      := 0;
      Brn       := 0;
      Rng       := 0;
      Crs       := 0;
      Speed     := 0;
      HD        := 0;
      PrivCode  := '';
      TypeTrk   := '';
      OrgBrn    := 0;
      ColorQ    := '';
      XCoor     := 0;
      YCoor     := 0;
      OrgCourse := 0;
    end;
  end;

  {EMCON -ica}

  function InitializeTRec_EmconPlan2 : TRec_EmconPlan2;
  begin
    with Result do
    begin
      ObjectID  := '';
      SessionID := 0;

      isActiveMw08  := False;
      isActiveLirod := False;
      isActiveECM   := False;
      isActiveKingklip  := False;

      isActivePlan2 := False;

      TStart2  := 0;
      TStop2   := 0;
      EmconDate2 := 0;

      onMW08      := False;
      offMW08     := False;

      onLirod     := False;
      offLirod    := False;

      onECM       := False;
      offECM      := False;

      onKingklip  := False;
      offKingklip := False;

    end;
  end;

  function InitializeTRec_EmconPlan1 : TRec_EmconPlan1;
  begin
    with result do
    begin
      ObjectID  := '';
      SessionID := 0;

      isActiveMw08  := False;
      isActiveLirod := False;
      isActiveECM   := False;
      isActiveKingklip  := False;

      isActivePlan1 := False;

      TStart  := 0;
      TStop   := 0;
      EmconDate := 0;


      onMW08      := False;
      offMW08     := False;

      onLirod     := False;
      offLirod    := False;

      onECM       := False;
      offECM      := False;

      onKingklip  := False;
      offKingklip := False;

    end;
  end;

  function IntializeTRec_ECMEngagement : TRec_ECMEngagement;
  begin
    with Result do
    begin
      ObjectID := '';
      SessionID := 0;
      OrderID := 1;
      IDSigma := '0';
      Brn := 0;
      Range := 0;
      ClassEcm := 0;
      Spot := '';
      Freq := 0;
      Scan := 0;
      NameEcm := '';
      priority := 1;
      Duration := 0;
      Counter := 0;
      JamID := 0;
      Status := 0;
      Jog := 0;
      active := false;
    end;
  end;

  function InitializeTRec_ECMAuth : TRec_ECMEAuth;
  begin
    with Result do
    begin
      ObjectID := '';
      SessionID := 0;
      OrderID := 1;

      ECMAuth := False;
    end;
  end;

  {icha}
  function InitializeTRec_ECMSimulator : TRec_ECMSimulator;
  begin
    with Result do
    begin

      ObjectID := '';
      SessionID := 0;
      OrderID := 1;
      IDSigma := '0';

      ECMState := byte(0);
      ECMAvailability := byte(0);
      ECMDesignation := byte(0);
      ECMSafetyMode := byte(0);
      ECMTrasmiter := byte(0);
      ECMHPA  := Byte(0);
    end;
  end;


  function InitializeTRec_Data_SectorScreen : TRec_Data_SectorScreen;
  begin
    with Result do
    begin
      RefPointID := '';
      RefStatus := 0;
      OffSetBearing := 0.0;
      OffsetRange := 0.0;
      IsRotationSlaved := false;
      IsActive := false;
      IsEnterSector := IsEnterSector;
      IsExitSector := False;
    end;
  end;

  function InitializeTRec_SectorScreen_Object : TRec_SectorScreen_Object;
  begin
    with Result do
    begin
      ObjectID := '';
      OrderID := 0;
      BearingStart := 0.0;
      BearingEnd := 0.0;
      RangeMin := 0.0;
      RangeMax := 0.0;
      UnitName := '';
      OffsetBearing := 0.0;
      OffsetRange := 0.0;
      TargetID := '';

    end;
  end;

  function InitializeTRec_Sonar_Envi: TRec_Sonar_Envi;
  begin
    with Result do
    begin
      ObjectID := '';
      Temperature := 0;
      Battleshort := False;
      EPU1 := False;
      EPU2 := False;
      PowerWarn := False;
      SensorWarn := False;
      PowerLimit := False;
      SmokeWarn := False;
      TXUStatus := False;
      RXUStatus := False;
      TransmitStatus := False;
      KeyStatus := False;
    end;
  end;

  function InitializeTRec_TrackMovement : TRec_Track_Movement;
  begin
    with Result do
    begin
      SigmaID := '';
      TrackID := 0;
      ObjectID :='';
      PlatID := '';
      PosX := 0.0;
      PosY := 0.0;
      DatumX := 0.0;
      DatumY := 0.0;
      Elevation := 0.0;
      HoldFire := False;
      Heading := 0.0;
      Speed := 0.0;
      TrackNum := 0;
      LinkYStat := '';
      PUNumber  := '';
      Ampli     := '';
      PrivCode  := '';
      ConnIndicator := '';
      IFFIndicator     := '';
      ThreatIndicator := '';
      Identity  := 0;
      SensorID  := 0;
      MOCSender := '';
      IsTrackUnitFound := False;
      DeviceNum := '';
      Range := 0.0;
      Bearing := 0.0;
    end;
  end;

  function InitializeTRec_MW08_Simulator : TRec_MW08_Simulator;
  begin
    with Result Do
    begin
      {
        SigmaID       : TStr10;
        Online        : Byte;
        Availability  : Byte;
        Failure       : Byte;
        AirSurv       : Byte;
        SurfSurv      : Byte;
        Jamming       : Byte;
        TWSMeas1      : Byte;
        TWSCal1       : Byte;
        TWSMeas2      : Byte;
        TWSCal2       : Byte;
        WarmUpTime    : Byte;
      }
      SigmaID := '';
      Online := 0;
      Availability := 0;
      Failure := 0;
      AirSurv := 0;
      SurfSurv := 0;
      Jamming := 0;
      TWSMeas1 := 0;
      TWSCal1 := 0;
      TWSMeas2 := 0;
      TWSCal2 := 0;
      WarmUpTime := 0;
    end;
  end;

  function InitializeTRec_nav_Zigzag : TRec_Data_Nav_ZigzagPlan;
  begin
    with Result do
    begin
      PlanName := '';
      Visible := False;
      Turn := '';
      X1 := 0;
      Y1 := 0;
      ObjectID := '';
      SessionID := 0;
      IndexPlanSelected := 0;
      PlanID := 1;

      Range := 0;
      Course := 0;

      Duration := 0;
      Angle := 0;
    end;
  end;

  function initializeTRec_Data_Nav_ZigzagCatalogueValue : TRec_Data_Nav_ZigzagCatalogueValue;
  begin
    with Result do
    begin
      ObjectID := '';
      SessionID := 0;

      CatName := '';
      IndexCat := 0;
      NrPlans  := 0;
    end;
  end;

  function InitializeTRec_pl_nav_Zigzag : TRec_Data_Pl_Nav_ZigzagPlan;
  begin
    with Result do
    begin
      ObjectID := '';
      SessionID := 0;

      PlanName := '';

      LegID := 0;
      duration :=0;
      Angle := 0;
      Turn := '';
    end;
  end;

  function InitializeTRec_Missile_Firing_Squence : TRec_Missile_Firing_Squence;
  begin
    with Result do
    begin
      {
        sigmaID         : TStr10;
        LauncherNumber  : integer;

        GyroStatus      : Byte;
        SimLauncherStat : Byte;
        TTF             : Double;
        TOT             : Double;
        isStopFire      : Boolean;
        isForceFire     : Boolean;
      }

      sigmaID := '';
      SimLauncherStat := 0;
      LauncherNumber := 0;
      GyroStatus := 0;
      GMTLaunchTime := 0;
      isStopFire := False;
      isForceFire := False;
    end;
  end;

  function InitializeTRec_Missile_Parameter : TRec_Missile_Parameter;
  var
    i,j : Integer;
  begin
    with Result do
    begin
      {
        sigmaID             : TStr10;
        LauncherNumber      : integer;
        InitialStepAltitude : byte;
        ApplyAllMissile     : Boolean;
        ObstacleLength      : Single;
        AngularApproach     : byte;
        TerminalManoueuver  : byte;
        SearchMode          : byte;
        Masking             : byte;
        TargetPriority      : byte;
        SearchCriterion     : byte;
        Proximity           : byte;
      }

      sigmaID := '';
      LauncherNumber := 0;
      ApplyAllMissile := False;
      InitialStepAltitude := 0;
      ObstacleLength := 0;
      AngularApproach := 0;
      TerminalManoueuvre := 0;
      SearchMode := 0;
      Masking := 0;
      TargetPriority := 0;
      SearchCriterion := 0;
      Proximity := 0;

      for i := 0 to 3 do
      begin
        for j := 0 to 3 do
        begin
          MaskingByte[i][j] := false;
        end;
      end;
    end;
  end;

  function InitializeTRec_Plan_Missile : TRec_Plan_Missile;
  begin
    with Result do
    begin
      {
        sigmaID           : TStr10;
        LauncherNumber    : integer;
        MissileStat       : Byte;
        ApproachRange     : Double;
        ApproachBearing   : Double;
        SeekerFar         : Double;
        SeekerNear        : Double;
        SeekerLeftSearch  : Double;
        SeekerRighSearch  : Double;
        SeekerRTG         : Double;
      }

      sigmaID := '';
      MissileFailure := false;
      LauncherNumber := 1;
      MissileStat := 0;
      ApproachRange := 0;
      ApproachBearing := 0;
      SeekerFar := 0;
      SeekerNear := 0;
      SeekerLeftSearch := 0;
      SeekerRighSearch := 0;
      SeekerRTG := 0;
    end;
  end;

  function InitializeTRec_Data_Target_Exocet : TRec_Data_Target_Exocet;
  begin
    with Result do
    begin
      {
        pid         : TPacketID;
        SessionID   : Integer;
        ObjectID    : TStr10;
        TargetID    : TStr10;
        Salvo       : integer;
        TSS         : Double;
      }

      SigmaID := '';
      TargetID := '';
      Salvo := 0;
      TSS := 0;
    end;
  end;

  function InitializeTRec_Torpedo_ConfirmTarget : TRec_Torpedo_ConfirmTarget;
  begin
    with Result do
    begin
      {
        Pc          : TPacketID;
        SessionID   : Integer;
        ObjectID    : string[20];
        TargetID    : integer;
        Stop        : Boolean;
        TrackNumber : string;
        TTG         : Double;
        PosX        : Double;
        PosY        : Double;
      }

      ObjectID := '0';
      TargetID := 0;
      Stop := False;
      TrackNumber := '';
      TTG := 0;
      PosX := 0;
      PosY := 0;
    end;
  end;

  function InitializeTRec_Data_A244 : TRec_Data_A244;
  begin
    with Result do
    begin
      {
        pid           : TPacketID;
        SessionID     : Integer;
        ObjectId      : string[255];
        TargetID      : string[255];
        MHPType       : Byte;
        LauncherMode  : Byte;
        RangeMode     : Byte;
        Duration      : Double;
        Speed         : Double;
        ISR           : Integer;
        ACE           : Integer;
        TTG           : Double;
      }

      ObjectId := '0';
      TargetID := '0';
      MHPType := 0;
      LauncherMode := 0;
      RangeMode := 0;
      Duration := 0;
      Speed := 0;
      ISR := 0;
      ACE := 0;
      TTG := 0;
    end;
  end;

  function InitializeTRec_B515TubeContent : TRec_B515TubeContent;
  var
    i : integer;
  begin
    with Result do
    begin
      {
        pid             : TPacketID;
        SessionID       : Integer;
        objectID        : string[20];
        TorpedoType     : byte;
        Authentication  : Boolean;
        TubePt          : array [0..2] of Boolean;
        TubeStb         : array [0..2] of Boolean;
      }

      objectID := '0';
      TorpedoType := 0;
      Authentication := False;
      ConfirmTarget := False;

      for i := 0 to 2 do
      begin
        TubePt[0] := false;
        TubeStb[0] := false;
      end;
    end;
  end;

  function InitializeTRec_State_Exocet : TRec_State_Exocet;
  var
    i : integer;
  begin
    with Result do
    begin
      {
        pid             : TPacketID;
        SessionID       : Integer;
        ObjectID        : string[255];
        LauncherNum     : Byte;
        OrderID         : Byte;

        SimOnline       : Byte;
        SimAvailability : Byte;
        SimFailure      : Byte;
        SafetyPnl       : Boolean;
        ControlPnl      : Boolean;
        SimEngMonitor   : Byte;
        SimEngagement   : Byte;
        SimEngSupport   : Byte;

        State           : Byte;
        Availability    : Byte;
        Configuration   : Byte;
        Activity        : Byte;
        Urgency         : Byte;

        ValidateEP      : Boolean;
        CancelEP        : Boolean;
        RestoreMissile  : Boolean;
        CMSFireAuth     : Boolean;
        TOTType         : Byte;
        TOTTime         : Double;
        MissileAlloc    : Byte;
        TrackNumber     : string[255];
        SalvoSize       : Byte;
        TrainMissile    : array[0..3] of Boolean;
        FiringMissile   : array[0..3] of Boolean;
      }

      ObjectID := '0';
      LauncherNum := 0;
      OrderID := 0;

      SimOnline := 0;
      SimAvailability := 0;
      SimFailure := 0;
      SafetyPnl := False;
      ControlPnl := False;
      SimEngMonitor := 0;
      SimEngagement := 0;
      SimEngSupport := 0;

      State := 0;
      Availability := 0;
      Configuration := 0;
      Activity := 0;
      Urgency := 0;

      ValidateEP := False;
      CancelEP := False;
      RestoreMissile := False;
      CMSFireAuth := False;
      TOTTime := 0;
      TOTType := 0;
      MissileAlloc := 0;
      SalvoSize := 0;

      for i := 0 to 3 do
      begin
        TrainOffMissile[i] := false;
        TrainMissile[i] := false;
        FiringMissile[i] := false;
      end;
    end;
  end;

  function InitializeTRec_FireTorpedoA244 : TRec_FireTorpedoA244;
  begin
    {
      Pc : TPacketID;
      SessionID : Integer;

      ShipID : string[20];
      OrderID : byte;

      ISC : single;
      ISR : word;
      WTR : word;
      CEI : word;
      PRG : word;
      DOP : word;
      ACE : word;
      FLO : word;
      ISD : word;
      ACM : word;
    }

    with Result do
    begin
      ShipID := '';
      OrderID := 0;
      mLauncherID := 0;
      ShipX := 0;
      ShipY := 0;
      ShipElev := 0;
      ISC := 0;
      ISR := 0;
      WTR := 0;
      CEI := 0;
      PRG := 0;
      DOP := 0;
      ACE := 0;
      FLO := 0;
      ISD := 0;
      ACM := 0;
      StepMoving := 0;
      TargetID := '';
      PosX := 0;
      PosY := 0;
      Elevation := 0;
      Speed := 0;
      Heading := 0;
      TurnRate := 0;
      InitISR_X := 0;
      InitISR_Y := 0;
      InitISR_Z := 0;
      TToGoISC := 0;
      TMSpinState := 0;
      TMDegStartM := 0;
      TMElevState := 0;
      TMCircle := 0;
      TMTurnRate := 0;
      RangeMove := 0;
    end;
  end;

  function InitializeTRec_Data_Gun76: TRec_Data_Gun76;
  begin
    {
      pid           : TPacketID;
      SessionID     : Integer;
      objectID      : TStr10;
      TargetID      : TStr10;
      IsDesig       : Boolean;
      IsTrajected   : Boolean;
      OrderID       : Byte;
      PowerStat     : Byte;
      BallisticType : Byte;
      FireRate      : Byte;
      Ammo          : Byte;
      ParProx       : Byte;
      GunConnection : Byte;
      GunPosition   : Byte;
      GunBttl       : Byte;
      GunBurst      : TFloatingPointS;
      GunCoeff      : TFloatingPointS;
      FireAuth      : Boolean;
      ProjectilSpd  : TFloatingPointS;
      RangeCorr     : TFloatingPointS;
      BearingCorr   : TFloatingPointS;
      OperabilityTest : Byte;
      ThrowOff : Double;
      AimMode : Byte;
    }

    //initialize record
    with Result do
    begin
      objectID := '';
      OrderID := 0;
      PowerStat := 0;
      BallisticType := 0;
      FireRate :=0;
      Ammo := 0;
      ParProx := 0;
      GunConnection := 0;
      GunBurst := 0;
      GunCoeff := 0;
      FireAuth := false;
      ProjectilSpd := 0;
      RangeCorr := 0;
      BearingCorr := 0;
      GunPosition := 0;
      GunBttl := 0;
      ThrowOff := 0;
      OperabilityTest := 0;
      TargetID := '';
      IsDesig  := False;
      IsTrajected := False;
      CorrMode := 0;
    end;
  end;

  function InitializeTRec_Data_GIC76 : TRec_Data_GIC76;
  begin
    {
      pid : TPacketID;
      SessionID : Integer;
      OnlineState,
      Availability,
      Failure,
      TargetEng,
      TargetAim,
      DirectEng,
      WarmFire,
      OperTest,
      DeckFixed,
      Auth : byte;
      OrderID : integer;
      StaticBrn,
      StaticElev,
      StaticRng,
      DynamicBrn,
      DynamicElev,
      DynamicRng : Double;
      SigmaID,
      FileInterupt,
      FireState,
      ObjectData,
      ObjectID,
      TrackNumber : string[255];
    }

    //initialize record
    with Result do
    begin
      SessionID := 0;

      OnlineState := 0;
      Availability := 0;
      Failure := 0;
      TargetEng := 0;
      TargetAim := 0;
      DirectEng := 0;
      WarmFire := 0;
      OperTest := 0;
      DeckFixed := 0;
      Auth := 0;
      OrderID := 0;
      StaticBrn := 0;
      StaticElev := 0;
      StaticRng := 0;
      DynamicBrn := 0;
      DynamicElev := 0;
      DynamicRng := 0;

      SigmaID := '';
      FileInterupt := '';
      FireState := '';
      ObjectData := '';
      ObjectID := '';
      TrackNumber := '';
    end;
  end;

  function InitializeTRec_Data_MW08 : TRec_Data_MW08;
  begin
    {
      pid               : TPacketID;
      SessionID         : Integer;
      objectID          : string[255];
      OrderID           : Byte;
      StateID           : Byte;
      BttlID            : Byte;
      BDriveID          : Byte;
      Stabilizer        : Byte;
      TransmitterState  : Byte;
      TXAuth            : Boolean;
      JammingDetection  : Boolean;
    }

    //initialize record
    with Result do
    begin
      SessionID := 0;
      objectID := '';
      OrderID := 0;
      StateID := 0;
      BttlID := 0;
      BDriveID := 0;
      Stabilizer := 0;
      TransmitterState := 0;
      TXAuth := 0;
      JammingDetection := 0;
    end;
  end;

  function InitializeTRec_Data_Area_MW08 : TRec_Data_Area_MW08;
  begin
    {
      pid         : TPacketID;
      SessionID   : Integer;
      ObjectId    : string[255];
      AreaMode    : Byte;
      ItemIdx     : Byte;
      BgnBrn      : Double;
      EndBrn      : Double;
      BgnRng      : Double;
      EndRng      : Double;
      ref         : string[255];
    }

    //initialize record
    with Result do
    begin
      Result.ObjectId := '';
      Result.AreaMode := 0;
      Result.ItemIdx := 0;
      Result.BgnBrn := 0;
      Result.EndBrn := 0;
      Result.BgnRng := 0;
      Result.EndRng := 0;
      Result.ref := '';
    end;
  end;

  function InitializeTRec_Data_ScenarioSync : TRec_ScenarioSync;
  begin
    {
      pid : TPacketID;
      SessionID : Integer;
      SigmaID : string[20];

      ScenarioName : string[50];
      ScenatioType : Byte;
      ScenarioStat : Byte;
      RecordName : string[50];
      RecordType : Byte;
      RecordStat : Byte;
      SnapshotName : string[20];
    }

    with Result do
    begin
      SigmaID := '';
      GamePlayType := 0;
      ScenarioName := '';
      ScenarioStat := 0;
      RecordName := '';
      RecordStat := 0;
    end;
  end;

  function InitializeTRec_Data_TRec_Data_DecoySysModeChg : TRec_Data_DecoySysModeChg;
  begin
    with Result do begin

      SessionID := 0;
      objectID := '';

      DecoySysMode  := 0;

      ModeChgNoteOnly := False;
      ModeChgDeplNote := False;
      ModeChgSimNote  := False;

    end;
  end;

  function InitializeTRec_Data_DecoySim : TRec_Data_DecoySim;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';

      DecoySimAvail := False;
      DecoyOpsStatus := 0;
      DecoySimCtrl := 0;
      DecoySysAvail := 0;

//      DecoySysMode  := 0;
//      ModeChgDeplNote := False;
//      ModeChgSimNote  := False;

      MasterSafetyArmed := False;
      MainWpnArmed := False;

      IsPlanning    := False;
      InclBtnActive := False;

      FireAuth := False;

      CTS_Mode := 0;
      TTF_Mode := 0;
      TTF_DelayBy := 0;
      CTS_EvadeTo := 0;

      CancelsFiringSeq := False;

//      RecAutoSend := False;

    end;

  end;

  function InitializeTRec_Data_DecoyLauncher : TRec_Data_DecoyLauncher;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';
      LauncherSide := 0;
      ArmingStatus := 0;
    end;

  end;

  function InitializeTRec_Data_DecoyController : TRec_Data_DecoyController;
  var
    I: Integer;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';
      LauncherSide := 0;

      for I := 0 to 11 do begin
        Selected[I]     := False;
        MunitionType[I] := 0;
        DecoyStatus[I]  := 0;  // avail, planned, etc.
        TubeStatus[I]   := 0;  // empty, loaded, etc.
      end;

    end;

  end;

  function InitializeTRec_Decoy_FiringQueue : TRec_Decoy_Queue;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';
      OrderID  := 0;

      QueueNum := 0;
      TubeNum := '';
      MunitionType:= 0;
      TTFSec := 0;
      TTF1   := 0;
      TTF2   := 0;
      TTF3   := 0;
      TTF4   := 0;
      BtnTag := 0;
      LauncherSide := 0;
      CTS_Mode := 0;
      TTF_Mode := 0;
    end;

  end;

  function InitializeTRec_Decoy_LaunchQueue : TRec_Decoy_Queue;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';
      OrderID  := 0;

      TubesInQueue := 0;

      QueueNum := 0;
      TubeNum := '';
      MunitionType:= 0;
      TTFSec := 0;
      TTF1   := 0;
      TTF2   := 0;
      TTF3   := 0;
      TTF4   := 0;
      BtnTag := 0;
      LauncherSide := 0;
      CTS_Mode := 0;
      TTF_Mode := 0;

    end;

  end;

  function InitializeTRec_Decoy_Firing : TRec_Decoy_Firing;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';
      OrderID  := 0;
      FireSeqStatus := 0;
      FireSeqInProgress := False;
      TubesInSequence := 0;
    end;

  end;


  function InitializeTRec_Stationing_RefObj : TRec_Stationing_RefObj;
  begin

    with Result do begin
      SessionID       := 0;
      objectID        := '';
      Guide_TrackName := '';
    end;

  end;


  function InitializeTRec_NavData_Stationing : TRec_NavData_Stationing;
  begin

    with Result do begin

      SessionID       := 0;
      objectID        := '';
      Active := False;
      Guide_Pos_Mode := 0;
      Guide_Vector_Mode := 0;
      Guide_Brg := 0;
      Guide_Rng := 0;
      Guide_Crs := 0;
      Guide_Spd := 0;
      OS_TurnRate := 0;
      OS_DurationMode := 0;
      OS_Duration := 0;
      OS_Spd := 0;

    end;

  end;

  function InitializeTRec_Data_NGS : TRec_Data_NGS;
  begin
    with Result do
    begin
      SessionID := 0;
      SigmaID := '';
      BombardMode := 0;
      Activation := False;
      Tracker := 0;
      RefStatus := 0;
      RefPointID := '';
      Range := 0.0;
      Bearing := 0.0;
      Height := 0.0;
      PosGrid := 0;
      ObjectID := '';
    end;
  end;

  function InitializeTRec_NGS_Target : TRec_NGS_Target;
  begin
    with Result do
    begin
      SessionID := 0;
      SigmaID := '';
      Range := 0.0;
      Bearing := 0.0;
      Height := 0.0;
      PosGrid := '';
      Engageable := '';
      PosX := 0.0;
      PosY := 0.0;
      Visible := True;
      OrderID := 0;
      ObjectID := '';
    end;
  end;

  function InitializeTRec_LIROD : TRec_LIROD_MK2;
  begin
    with Result do
    begin
      SessionID   := 0;
      SigmaID     := '';
      TargetID    := '';
      IsDesig     := False;
      {icha}

    end;
  end;


  function InitializeTRec_TDS_Data : TRec_TDS_Data;
  begin
    with Result do
    begin
      OnlineState := 0;
      Availability := 0;
      Failure := 0;
      TdsID := '';
      TargetID := '';

      Range := 0;
      Height := 0;
      ManualControl := False;
      OpticInv := 0;
      ResControl := 0;
      PowerLabel := '';
      OpticInvLabel := '';
      ResControlLabel := '';

      IsSelect := False;
      IsAction := False;
      IsFire := False;

      OrderID := 1;

      IsSelectEnable := False;
      IsActionEnable := False;
      IsFireEnable := False;

    end;
  end;

  function InitializeTRec_Data_DecoyLCC : TRec_Data_Decoy_LCC;
  begin
    with Result do
    begin
      SessionID := 0;
      AllowSurvRed := False;
      FiringWindow := False;
      VETO_Time := 0;
      PtHornSounding := False;
      SbHornSounding := False;
    end;
  end;

  function InitializeTRec_DecoyDesigOps : TRec_Decoy_Desig_Ops;
  begin

    with Result do begin
      SessionID := 0;
      OrderID := 0;

      TgtTN     := '';
      DecoyType := 0;
      Brg       := 0;
      ETR       := 0;
      LoPri     := False;
      SpotNr    := '17777';
      DesigID   := '99';
    end;

  end;

  function InitializeTRec_Pac_Data : TRec_PAC_Data;
  begin
    with Result do
    begin
      OrderID := 0;
      ObjectID := '';
//      TargetID := '';
      PACType := 0;
      IsActive := False;
      Gun := -1;
      Tracker := -1;
      IsEnable := False;
    end;
  end;

  function InitializeTRec_Pac_Target : TRec_PAC_Target;
  begin
    with Result do
    begin
      ObjectID := '';
      TargetID := '';
      OrderID := 0;
      Bearing := 0.0;
      Range := 0.0;
      Elev := 0.0;
      BCorr := 0.0;
      RCorr := 0.0;
      Ecorr := 0.0;
      TimeLast := '';
      PACType := 0;
    end;
  end;

  function InitializeTRec_ASW_Danger_Zones : TRec_ASWDangerZones;
  begin
    with Result do
    begin
      SessionID       := 0;
      SigmaID         := '';
      IncludeOwnShip  := false;
      DisplayContour  := false;
      FormationRef    := 0;
      ReferenceID     := '';
      KinematicCourse := 0;
      KinematicSpeed  := 0;
      METFR           := 0;
      TorpedoSpeed    := 0;
      TDZDisplay      := false;
      SnorkelSpeed    := 0;
      SubmergedSpeed  := 0;
      LLOADisplayTDA  := false;
      LLOAScreenLine  := false;
      LLOAFormation   := 0;
    end;
  end;

  function InitializeTRec_HoldFire_Report_Definition : TRec_HoldfireReportDef;
  begin
    with Result do
    begin
      WeaponStatus := 0;
      Pending := 0;
      AsdFrnd := 0;
      Frnd := 0;
      Neutral := 0;
      Unknown := 0;
      Suspect := 0;
      Hostile := 0;
    end;
  end;

  function InitializeTRec_Throw_Off_Control : Trec_Throw_Off_Control;
  begin
    with Result do
    begin
      DetectedName := '';
      ThrowOff := 0;
      LeftThrowOffBtnEnable := False;
      RightThrowOffBtnEnable := False;
      EdtThrowOffEnable := False;
    end;
  end;

  function InitializeTRec_InitDecoyFiring : TRec_Data_Init_Decoy_Firing;
  begin

    with Result do begin
      SessionID := 0;
      OS_Hdg := 0;
      TickCount := 0;
    end;

  end;

  function InitializeTRec_GameTimeSync : TRec_GameSync;
  begin

    with Result do begin
      SessionID := 0;
      SigmaID := '';
      MiliSecond := 0;
      GameTime := 0;
    end;

  end;

  function InitRec_ESMDataReq: TESM_DataReq;
  begin

    with Result do begin
      PRPModCW := False;
      EmitterFreqAgi := 0;
      Amplitude := 0;
      EmitterName := '';
      RdrTypeName := '';
      Freq := 0;
      PRF := 0;
      PRF_Modulation := 0;
      Pulsewidth := 0;
    end;

  end;

  function InitializeTRec_Data_DecoyAuto : TRec_Data_DecoyAuto;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';
      TargetDetName := '';
//      DecoyObjID := '';
    end;

  end;

  function InitializeTRec_ECM_Jam : TRec_ECM_Jam;
  begin

    with Result do begin
      SessionID := 0;
      Jam_Status := 0;
    end;

  end;

  function InitializeTRec_Threat_Eval_Values: TRec_Threat_Eval_Values;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';
      Tgt_TN := '';
      Inhibit:= False;
      IndexOffset := 0;

    end;

  end;

  function InitializeTRec_TrackSelAirSetting: TRec_TrackSelAirSetting;
  begin

    with Result do begin
      SessionID := 0;
      objectID := '';

      IsTrackingHostileId:= True;
      IsTrackingSuspectId:= True;
      IsTrackingUnknownId:= True;
      IsTrackingPendingId:= True;
      // kinematics
      SectorMin := 0;
      SectorMax := 0;
      RangeMin := 0;
      RangeMax := 0;
      SpeedMin := 0;
      SpeedMax := 0;
      InclineAngle:= 0;

      // For selection indicators
//      IdentSuspectSelected:= False;
//      IdentHostileSelected:= False;
//      IdentUnknownSelected:= False;
//      IdentPendingSelected:= False;
      KinematicSectorSelected:= False;
      KinematicRangeSelected:= False;
      KinematicSpeedSelected:= False;
      KinematicInclineSelected:= False;

    end;

  end;

  function InitializeTRec_EvalTracklist: TRec_Eval_Tracklist;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';

      TracklistOps := 0;
      TrkObjID := '';
      TrkTN := '';

    end;

  end;

  function initializeTRec_SelWasaChannel : TRec_SelWasaChannel;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';

      TgtDetectName := '';
      SensorName := '';
      WeaponName := '';

      IsSyncMsg  := False;

    end;

  end;

  function initializeTRec_WasaChanProp : TRec_WasaChanProperties;
  begin

    with Result do begin

      SessionID := 0;
      objectID := '';

      TgtDetectName := '';
      SensorName := '';
      WeaponName := '';

      PlanAuth := False;
      PlanInhibited := False;
      EngStatus := 0;
      EngResult := 0;

    end;

  end;

  function InitializeTRec_Magnetic_Var : TRec_Magnetic_Var;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      MagValue := '';
      EntryMode := 1;
    end;
  end;

  function initializeTRec_Barometric_Pressure : TRec_Barometric_Pressure;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      BaromValue := 0;
      EntryMode := 0;
    end;
  end;

  function InitializeTRec_Humidity : TRec_Humidity;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      HumidValue := 0;
      EntryMode := 0;
    end;
  end;

  function initializeTRec_Air_Temperature : TRec_Air_Temperature;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      AirTempValue := 0;
      EntryMode := 0;
    end;
  end;

  function initializaTrec_Wind : TRec_Wind;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      TrueWindDirection := 0;
      TrueWindSpeed := 0;
      EntryMode := 0;
    end;

  end;

  function initializeTRec_Depth : TRec_Depth;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      DepthValue := 0;
      EntryMode := 0;
    end;
  end;

  function initializeTRec_Drift : TRec_Drift;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      CourseValue := 0;
      SpeedValue := 0;
      EntryMode := 0;
    end;
  end;

  function initializeTRec_RelOSEnvi : TRec_Relative_OS_Poss;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      EntrySpdMode := 1;
      EntryCrsMode := 1;
      EntryPosMode := 0;
      RelLattPos := 0;
      RelLongPos := 0;
    end;
  end;

  function initializeTRec_Envi_DateTime : TRec_Envi_Date_Time;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      EntryTimeMode := 1;
      EntryTimeZoneMode :=0;
      EntryDateMode := 1;

      EnviTime := 0;
      EnviTimeZone := '';
      EnviDate := 0;
    end;
  end;

  function initializeTRec_Data_IFF_Sector_List : TRec_Data_IFF_Sector;
  begin
    with Result do begin
      SessionID := 0;
      SigmaID := '';
      SectorID := 0;
      StartBrn := 0;
      EndBrn := 0;
      StartRng := 0;
      EndRng := 0;
      SectorRef := '';
      SectorVisible := False;
    end;
  end;
end.
