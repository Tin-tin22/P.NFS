unit uWCCmanager;
(*
  Created       : 14 August 2007
  Last Modified : 14 August 2007

  Author        : Andy Sucipto
  description   : implementation of simulation manager
                  for kolat emulator TDC .

*)

interface

uses
    Forms,
    Graphics,
    Classes,

//------------------------------------------------------------------------------
    uBaseDataType,
    uBaseSimulationObject,
    uBaseSensor,

    uLibRadar,

    uTCPClient,
    uTCPDatatype,


    uTestShip,
    uLibClientObject,

    uObjectView,
    uLibWCCClassNew,

    uSimulationManager,
    uTDCConstan,
    uLibTDCClass,
    Windows;

  type

//==============================================================================
// Client manager for TDC Simulator
//==============================================================================
    TGameSetting = record
      TargetFile: string;
      // nanti yg lain pindah sini ya...
      
    end;
    

    TTDCManager = class(TSimulationManager)
    private
      FTDC_OffCenter    : boolean;
      FShipUpdateIL     : tInterleave;
      FRadarUpdateIL    : tInterleave;

      function GetRepaintCycle: Word;
      procedure SetRepaintCycle(const Value: Word);


    protected
      UniqueIdFactory : integer;
      NetHandler      :   TCPT_ARRAY_PROCEDURE;

      procedure EventOnMainTimer(const dt: double); override;

      // NetWork Event handler
      //procedure Handle_ (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_datum           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_FOC_plus             (apRec: PAnsiChar; aSize: integer);
      procedure Handle_FOC_minus            (apRec: PAnsiChar; aSize: integer);

      procedure Handle_Change_Ident      (apRec: PAnsiChar; aSize: integer);
      procedure Handle_select_radar_type    (apRec: PAnsiChar; aSize: integer);

      procedure Handle_start_ICM            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_update_ICM           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_end_ICM              (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_tor           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_tor         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_asrl          (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_asrl        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_WIPE                 (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_ram             (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_auto            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_init_dr              (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_ram           (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_FC            (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_FC          (apRec: PAnsiChar; aSize: integer);

      procedure Handle_assign_SSM           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_SSM         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_init_esm_fix         (apRec: PAnsiChar; aSize: integer);

      procedure Handle_Synch_timebase       (apRec: PAnsiChar; aSize: integer);
      procedure SendSynchTimeBase;

      procedure Handle_CorrectRam           (apRec: PAnsiChar; aSize: integer);
      procedure Handle_UpdateTrackPosition  (apRec: PAnsiChar; aSize: integer);

      //gigih
//      procedure Handle_assign_FC_WCC        (apRec: PAnsiChar; aSize: integer);
//      procedure Handle_deassign_FC_WCC      (apRec: PAnsiChar; aSize: integer);
      procedure Handle_assign_gun_WCC       (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_gun_WCC     (apRec: PAnsiChar; aSize: integer);

      //mas sam
      procedure Handle_assign_FC_OCC        (apRec: PAnsiChar; aSize: integer);
      procedure Handle_deassign_FC_OCC      (apRec: PAnsiChar; aSize: integer);

      procedure  EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
      procedure  Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
      procedure  Event_AssignHandler(apRec: PAnsiChar; aSize: integer);
      procedure  EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
      procedure  EventonReceiveSplashPoint(apRec: PAnsiChar; aSize: integer);
      procedure  EventonReceiveConcsoleWCCSetting(apRec: PAnsiChar; aSize: integer);

      function  dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                         MissileID, MissileNumber  : integer): string;
      procedure CreateShipForms(const aShipClassID, aTDCNumber: integer); virtual;
      procedure CreateMinimalForms;

    public
    // TDC parts..
      OffX_Map, OffY_Map : Double;
      xShip       : TXShip;         // kapal tempat Radar berada
      ShipID, ShipClassID : integer;
      ShipName, ShipClassName : string;
      UseDatabase: boolean;
      Radarproses : boolean;
      ActiveRadar : TClientRadar;
      TheWCC      : TGenericWCCInterface;
      TDCNumber   : integer;
      FTimebaseServer : BOOLEAN;

      GameSetting : TGameSetting;
      StandAloneMode : boolean;



      constructor Create;
      destructor Destroy; override;

      procedure InitializeSimulation;     override;
      procedure FinalizeSimulation;       override;

      //specialProcedure
      function LoadScenarioFromIniFile(const fIni: string): integer; override;
      procedure LoadObjectSetting(const fIni: string);
      procedure LoadTarget(const fIni: string);


      procedure LoadScenario;     override;
      procedure UnLoadScenario;   override;

      procedure UpdateMember;                       override;

      procedure DrawMember;                         override;
      procedure DrawAllOnMapXCanvas(aCnv: TCanvas); override;

      procedure CleanUpMember;                      override;

      function GetUniqueId: string;
      procedure AddToMemoLog(const str :string);

      procedure LoadKabehSetting;
      procedure ApplyKabehSetting;

      procedure GetWCCWeaponAssigned;
    published
      property RepaintCycle: Word read GetRepaintCycle write SetRepaintCycle;
    end;
//==============================================================================


  procedure BeginSimulation;
  procedure EndSimulation;

var
  TDCSimCenter  : TTDCManager;


implementation

uses
    SysUtils, IniFiles, Math, uBaseFunction,  uBaseConstan, MapXLib_TLB,
    uMapXFunction,
    uLibWCC_Nala, uLibWCC_Rencong, uLibWCC_Singa, {uLibTDC_Oswald,
    uLibTDC_KapalSelam, uLibTDC_Sigma, uLibWCC_Cakra, }
    uMapWindow, uDataModule, uLibEmulatorSetting, uBridgeSet, Dialogs,
    uClassDatabase;

var
  bridgeSet:  TRecBridgeSet;
  bridgeSetPath : string;

  settingMap : TRecIniMapSet;
//  settingTDC : TRecIniTDCSet;


//------------------------------------------------------------------------------
//-- Simulation Initialization and Finalization
    procedure BeginSimulation;
    begin
      //ParamMap
      TDCSimCenter := TTDCManager.Create;
      uSimulationManager.SimCenter := TDCSimCenter;

    end;

    procedure EndSimulation;
    begin
      uSimulationManager.SimCenter := nil;
      TDCSimCenter.Free;

    end;

    function UniqueID_To_dbID(const uid: string): integer;
    var s: string;
    begin
      s := Copy(uid, 4, Length(uid)-3);
      try
        result := StrToInt(Trim(s));
      except
        on EConvertError do begin
          result := -1;
          exit;
        end
      end;
    end;

{ TClientManager }
//--------------------------------------------------------------------------
//-- Simulation Implementation
  constructor TTDCManager.Create;
  var i: integer;
  begin
    inherited;

    Radarproses := false;
    FGameDelayInterval  := 1;
    FRepaintIL.Cycle    := 1; //3

    UniqueIdFactory := random(10);
    FTDC_OffCenter  := TRUE;

    GamePlayMode := pmModeClient;

    FShipUpdateIL.Counter := 1;
    FShipUpdateIl.Cycle   := 29;   //10ms * 30

    FRadarUpdateIL.Counter := 2;
    FRadarUpdateIL.Cycle   := 297;


    SetLength(NetHandler, C_Max_Order_ID + 1);
    for i := 1 to C_Max_Order_ID do begin
      NetHandler[i] := nil;
    end;

//    NetHandler[OrdID_init_datum] := Handle_init_datum;

    NetHandler[OrdID_select_radar_type    ] := Handle_select_radar_type ;
    NetHandler[OrdID_start_ICM            ] := Handle_start_ICM ;
    NetHandler[OrdID_update_ICM           ] := Handle_update_ICM ;
    NetHandler[OrdID_end_ICM              ] := Handle_end_ICM ;
    NetHandler[OrdID_init_datum           ] := Handle_init_datum ;

    NetHandler[OrdID_FOC_plus             ] := Handle_FOC_plus ;
    NetHandler[OrdID_FOC_minus            ] := Handle_FOC_minus ;

    NetHandler[OrdID_Change_ident         ] := Handle_Change_Ident ;
{
    NetHandler[OrdID_ident_bawah_air      ] := Handle_ident_bawah_air ;
    NetHandler[OrdID_ident_atas_air       ] := Handle_ident_atas_air ;
    NetHandler[OrdID_ident_udara          ] := Handle_ident_udara;
}
    NetHandler[OrdID_assign_tor           ] := Handle_assign_tor ;
    NetHandler[OrdID_deassign_tor         ] := Handle_deassign_tor ;
    NetHandler[OrdID_assign_asrl          ] := Handle_assign_asrl ;
    NetHandler[OrdID_deassign_asrl        ] := Handle_deassign_asrl ;
    NetHandler[OrdID_WIPE                 ] := Handle_WIPE ;

    NetHandler[OrdID_init_ram    ]        := Handle_init_ram ;
{    NetHandler[OrdID_init_ram_udara       ] := Handle_init_ram_udara;
}
    NetHandler[ OrdID_init_auto           ] := Handle_init_auto ;
    NetHandler[ OrdID_init_DR             ] := Handle_init_DR ;
    NetHandler[OrdID_assign_ram           ] := Handle_assign_ram ;


    NetHandler[OrdID_assign_SSM           ] := Handle_assign_SSM ;
    NetHandler[OrdID_deassign_SSM         ] := Handle_deassign_SSM ;
    NetHandler[OrdID_init_esm_fix         ] := Handle_init_esm_fix ;

    NetHandler[OrdID_Synch_timebase       ] := Handle_Synch_timebase;

    NetHandler[OrdID_CorrectRAM           ] := Handle_CorrectRam;
    NetHandler[OrdID_UpdateTrackPos       ] := Handle_UpdateTrackPosition;

    NetHandler[OrdID_assign_FC            ] := Handle_assign_FC ;
    NetHandler[OrdID_deassign_FC          ] := Handle_deassign_FC ;


    NetHandler[OrdID_assign_gun           ] := Handle_assign_gun_WCC ;
    NetHandler[OrdID_assign_FC_OCC        ] := Handle_assign_FC_OCC ;
    NetHandler[OrdID_deassign_FC_OCC      ] := Handle_deassign_FC_OCC ;

    LoadKabehSetting;
  end;

  destructor TTDCManager.Destroy;
  begin
    SetLength(NetHandler, 0);

    inherited;
  end;


  procedure TTDCManager.EventOnMainTimer(const dt: double);
  var i : Integer;
  begin

    for i := 0 to FSpeedMultiplier-1  do begin
      // update time
      MainGameTimer.IncreaseMillisecond(dt);

      // call move memb/e/r

//      if GamePlayMode = pmStandalone then begin
        MoveMember(dt);
        xShip.Run(dt);         // xShip is Moving;
//      end;

      ActiveRadar.PositionX := xShip.PositionX;
      ActiveRadar.PositionY := xShip.PositionY;
      ActiveRadar.PositionZ := xShip.PositionZ;

      ActiveRadar.Direction := xShip.Heading;

      ActiveRadar.Run(dt);     // radar is rotating @ processing signal
//      ActiveRadar.TimeBaseView.ActualHeadingShip := TheWCC.xSHIP.Heading;
      ActiveRadar.RadarProcess(MainObjList, MainGameTimer.GetMillisecond, Radarproses);
      ActiveRadar.DetObjects.RunAllMemberObject(dt);

	    TheWCC.LastUpdateCounter :=  MainGameTimer.GetMillisecond;
      TheWCC.Run(dt);
    end;

    // end of for

    if (FShipUpdateIL.Counter = 0) or (FShipUpdateIL.Cycle = 0) then begin

      TheWCC.OwnShipMarker_SetPosition(xShip.PositionX, xShip.PositionY);

      TheWCC.Walk;

      if TheWCC. CU_ORStatus = stCU_OR_CENT then begin
       TheWCC.Cursorss.Org.X  := xShip.PositionX;
       TheWCC.Cursorss.Org.Y  := xShip.PositionY;
      end;

      if not TheWCC.TrueMotion then begin
        Fmap.CenterX := xShip.PositionX;
        Fmap.CenterY := xShip.PositionY;
        FMap.Rotation := 0;
      end
      else
        FMap.Rotation := -xShip.Heading;

	    // gigih
      TheWCC.SIM_SetPosition(xShip.PositionX, xShip.PositionY);

    end;
    if (FShipUpdateIL.Cycle > 0) then
      FShipUpdateIL.Counter := (FShipUpdateIL.Counter + 1) mod FShipUpdateIL.Cycle;

    if (FRadarUpdateIL.Counter = 0) or (FRadarUpdateIL.Cycle = 0) then begin
      if FTimebaseServer then
        SendSynchTimeBase;
    end;
    if (FRadarUpdateIL.Cycle > 0) then
      FRadarUpdateIL.Counter := (FRadarUpdateIL.Counter + 1) mod FRadarUpdateIL.Cycle;

    // proses yg tidak termasuk gamespeed multiplier:
    // call Draw member

    if (FRepaintIL.Counter = 0) or (FRepaintIL.Cycle = 0) then begin
      UpdateMember;
      DrawMember;
    end;

    if  FRepaintIL.Cycle > 0 then
      FRepaintIL.Counter := (FRepaintIL.Counter + 1) mod FRepaintIL.Cycle;

    // call update tote
    if (FFormUpdateIL.Counter = 0) or (FFormUpdateIL.Cycle = 0) then
       ShowMemberData;

    if  FFormUpdateIL.Cycle > 0 then
       FFormUpdateIL.Counter := (FFormUpdateIL.Counter + 1) mod FFormUpdateIL.Cycle;

    // destroy everything that ask for freedom...

    CleanUpMember;
    Application.ProcessMessages;

  end;

procedure TTDCManager.EventonReceiveConcsoleWCCSetting(apRec: PAnsiChar;
  aSize: integer);
var  aRec: ^TRecStatus_Console;
begin
   aRec := @apRec^;
   TheWCC.RecvWCCSettingConsole(aRec^);
end;

procedure TTDCManager.InitializeSimulation;
  var fName: string;
   I: Integer;
  begin
    inherited;

    NetComm.RegisterProcedure(
      REC_3D_POSITION, EventonReceiveDataPosition, SizeOf(TRecData3DPosition));

    NetComm.RegisterProcedure(
       C_REC_ORDER, Event_OrderRecognizer, SizeOf(TRecOrder)) ;

    NetComm.RegisterProcedure(
       C_REC_ORDER_XY, Event_OrderRecognizer, SizeOf(TRecOrderXY)) ;

    NetComm.RegisterProcedure(
      C_REC_TRACK_ORDER, Event_OrderRecognizer, SizeOf(TRecTrackOrder));

    NetComm.RegisterProcedure(
      C_REC_ORDER_ASSIGNMENT, Event_AssignHandler, sizeof(TRecOrderAssignment));

    NetComm.RegisterProcedure(
      C_REC_FIRE_CONTROL    ,Event_OrderRecognizer, sizeof(TRecFireControlOrder));

    NetComm.RegisterProcedure(
      C_REC_GUN_CONTROL    ,Event_OrderRecognizer, sizeof(TRecGunControl));

    NetComm.RegisterProcedure(
      C_REC_CANNON          ,Event_OrderRecognizer, sizeof(TRecMeriam));

    NetComm.RegisterProcedure(
      REC_MISSILEPOS        ,EventonRecMissilePosAvailable,  sizeof(TRecMissilePos));

    NetComm.RegisterProcedure(
      REC_STAT_CANNON_SPLASH  ,EventonReceiveSplashPoint  ,  sizeof(TRecSplashCannon));

   NetComm.RegisterProcedure(
      REC_STAT_ORDER_CONSOLE, EventonReceiveConcsoleWCCSetting , sizeof(TRecStatus_Console));

    NetComm.RegisterProcedure(
      REC_3D_WCC, nil ,  sizeof(TRec3DSetWCC));

    NetComm.RegisterProcedure(
      REC_EVENT_LOG, nil, SizeOf(TRecEventLog));

    if ParamCount < 9 then
      StandAloneMode := True
    else
      StandAloneMode := False;


    fname := ExtractFilePath(Application.ExeName) + 'Scenario\TDCScene.ini';
    LoadKabehSetting;

    CreateShipForms(ShipClassID, 1);
    //    LoadScenarioFromIniFile(fname);

//    TheWCC.shipClassID  := ShipClassID;

     if shipID = C_ShipID_Fatahillah then
       (TheWCC as TWCC_NalaInterface).SetFatahilahPanel
     else
     (TheWCC as TWCC_NalaInterface).SetNalaPanel;


    if not StandAloneMode then
      GetWCCWeaponAssigned;

    LoadGeoset(settingMap.geoset);

    ActiveRadar   := TClientRadar.Create;
    ActiveRadar.CreateDefaultView(FMap);
    ActiveRadar.PolarView.RangeMax := 128.0;

    xShip       := TXShip.Create;
    xShip.CreateDefaultView(Fmap);

	//procedure titip;
    TheWCC.FMap := FMap;
    TheWCC.xSHIP := xShip;
    TheWCC.ActiveRadar := ActiveRadar;
    TheWCC.SetRadar_type(rtWM_28);
    TheWCC.SetRadar_Amplification(raLiner);
    TheWCC.SetRadar_MTI_Status(FALSE);

    TheWCC.netSend := NetComm;
    TheWCC.HaveToSend := GamePlayMode = pmModeClient;

//    LoadObjectSetting(fname);
    ApplyKabehSetting;

    xShip.Enabled := TRUE;

    if Assigned(TheWCC) then begin
      TheWCC.Initialize;
    end;

    if not StandAloneMode then
     Net_Connect;
  end;


procedure TTDCManager.GetWCCWeaponAssigned;
var WeaponAssigned : TScenarioWeapon;
    ListWeaponAssigned : TList;
    I : Integer;
begin
  ListWeaponAssigned := TList.Create;
  if DataModule1.GetListWeaponOnShipBySceID( bridgeSet.mShip.mScenario , bridgeSet.mShip.mShipID , ListWeaponAssigned) > 0 then
  begin
    for I := 0 to ListWeaponAssigned.Count - 1 do begin
      WeaponAssigned := TScenarioWeapon.Create;
      WeaponAssigned := TScenarioWeapon(ListWeaponAssigned.Items[I]);
      if WeaponAssigned.WeaponID = C_DBID_CANNON40 then begin
        case WeaponAssigned.LauncherID of
          1 : begin
                TheWCC.Gun2.Isfunctionalized := True;
              end;
          2 : begin
                TheWCC.Gun3.Isfunctionalized := True;
              end;
        end;
      end;
       if (WeaponAssigned.WeaponID = C_DBID_CANNON120) and (WeaponAssigned.LauncherID=1) then begin
         TheWCC.Gun1.Isfunctionalized := True;
       end;
       WeaponAssigned.Free;
    end;
  end;
  ListWeaponAssigned.Free;

  if TheWCC.Gun1.Isfunctionalized then
    AddToMemoLog('Gun1 is Assigned')
  else
    AddToMemoLog('Gun1 is not Assigned');

  if TheWCC.Gun2.Isfunctionalized then
    AddToMemoLog('Gun2 is Assigned')
  else
    AddToMemoLog('Gun2 is not Assigned');

  if TheWCC.Gun3.Isfunctionalized then
    AddToMemoLog('Gun3 is Assigned')
  else
    AddToMemoLog('Gun3 is not Assigned');
end;

  procedure TTDCManager.FinalizeSimulation;
  begin
{    NetComm.RegisterProcedure(
      REC_POSITION, nil, SizeOf(TRecDataPosition));
}
    xShip.Free;
    ActiveRadar.Free;

    if Assigned(TheWCC) then
      TheWCC.Free;

     inherited;

  end;

  function TTDCManager.LoadScenarioFromIniFile(const fIni: string): integer;
  var IniF:TIniFile;
      readStr : string;
      readInt : integer;
      fName : string;
  begin
    // di sini CreateForm dan Load Map
    // sebaiknya diubah, load setting aja simpan ke variabel GameSetting,
    // setelah semua di load baru di execute.

    if FIni = '' then
      FName := ExtractFilePath(Application.ExeName) + 'Scenario\TDCScene.ini'
    else
      FName := FIni;

    if FileExists(FName) then
      AddToMemoLog('Opening scenario '+ FName)
    else begin
      AddToMemoLog('Error: Scenario "' +FName+ '" is not Exist');
      exit;
    end;

    IniF   := TIniFile.Create(FName);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    //. multiplayer section . . . .
    ServerIp  := Inif.ReadString(C_mult_sect, C_servip_id, '127.0.0.1');
    ServerPort:= Inif.ReadString(C_mult_sect, C_servport_id, '2120');

    //. Game Section . . . . .
    readInt := IniF.ReadInteger(C_game_sect, C_playmode_id, 0);
    GamePlayMode := TPlayMode(readInt);
    if GamePlayMode = pmModeClient then
      AddToMemoLog(' .Net Client.')
    else
      AddToMemoLog(' .Alone.');


    GameSetting.TargetFile :=  Inif.ReadString(C_game_sect,'target', '');

    //. this ship section . . . .

    readStr := Inif.ReadString(C_Ship_section, 'thisshipid', 'VSL0039');
    ShipID := UniqueID_To_dbID(readStr);

    readInt := Inif.ReadInteger(C_Ship_section, 'tdcnumber', 1);
    TDCNumber   := readInt;

    readInt := Inif.ReadInteger(C_game_sect, 'dbconnect', 0);
    UseDatabase := readInt = 1;

    if not UseDatabase then begin
      ShipClassID := Inif.ReadInteger(C_Ship_section, 'classid', -1);
      CreateShipForms(ShipClassID, TDCNumber);

    end
    else begin
      if ( ShipID <> -1)then begin
        ShipName    := DataModule1.GetShipName(ShipId);
        ShipClassID := DataModule1.GetShipType(ShipId, ShipClassName);

        AddToMemoLog(' ShipID      = ' + IntToStr(ShipID) );
        AddToMemoLog(' ShipClassId = ' + IntToStr(ShipClassID) );

        AddToMemoLog(' ShipName ' + ShipName );
        AddToMemoLog(' ShipClassName ' + ShipClassName );

        CreateShipForms(ShipClassID, TDCNumber);

      end
      else begin
        AddToMemoLog('Error ShipID = '+ IntToStr(ShipID) );
        AddToMemoLog('Can not acquire data from db');
        CreateMinimalForms; // form tengah (map)di sini
      end;
    end;

    TheWCC.shipClassID := ShipClassID;
    TheWCC.shipID := ShipID;

    //load map
    readStr := IniF.ReadString(C_Map_Section, C_gst_ident, '');
    if (readStr <> '') and FileExists(readStr) then begin
      AddToMemoLog('Opening geoset '+ readStr);
      LoadGeoset(readStr);
    end
    else begin
      dec(result);
      AddToMemoLog('Error: Geoset "' +readStr+ '" is not Exist');
      exit;
    end;

//    readStr := IniF.ReadString(C_Map_Section, C_grd_ident, '');
//    if (readStr <> '') and FileExists(readStr) then begin
//      AddToMemoLog('Opening 3D map '+ readStr);
//       LoadGrid(readStr);   // comment by bagus
//    end
//    else begin
//      dec(result);
//      AddToMemoLog('Error: 3D Map "' + readStr + '" is not Exist');
//      exit;
//    end;

    IniF.Free;
  end;

  procedure TTDCManager.LoadObjectSetting(const fIni: string);
  var IniF:TIniFile;
      readDbl : double;
      fName : string;
      readInt : integer;
  begin // di sini CreateForm dan Load Map
//    if FIni = '' then
//      FName := ExtractFilePath(Application.ExeName) + 'Scenario\TDCScene.ini'
//    else
      FName := FIni;

    if FileExists(FName) then
      AddToMemoLog('Load Setting '+ FName)
    else begin
      AddToMemoLog('Error:  "' +FName+ '" is not Exist');
      exit;
    end;

    IniF   := TIniFile.Create(FName);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    xship.Speed    := IniF.ReadFloat(C_Ship_section, C_speed_id,  0.0 );
    xship.Heading  := IniF.ReadFloat(C_Ship_section, C_heading_id,  0.0 );
    xship.UniqueID := Inif.ReadString(C_Ship_section, 'thisshipid', 'flyingdutchman');

    TheWCC.shipt_tid := IniF.ReadInteger(C_Ship_section, 'deftracknumber', 61);

    readDbl  := IniF.ReadFloat(C_Ship_section, C_posx_id,  0.0 );
    if  IsZero(readDbl) then
      xship.PositionX := FMap.CenterX
    else
      xship.PositionX := readDbl;

    readDbl  := IniF.ReadFloat(C_Ship_section, C_posy_id,  0.0 );
    if  IsZero(readDbl) then
      xship.PositionY := FMap.CenterY
    else
      xship.PositionY := readDbl;


    readDbl  := IniF.ReadFloat(C_Ship_section, C_posz_id,  0.0 );
    xship.PositionZ := readDbl;

    FMap.ZoomTo(64.0, xShip.PositionX, xShip.PositionY);

    //. WM_ radar section . . . .
    ActiveRadar.PositionX := xShip.PositionX;
    ActiveRadar.PositionY := xShip.PositionY;
    ActiveRadar.PositionZ := xShip.PositionZ;


    ActiveRadar.Frequency      := IniF.ReadFloat(C_wmradar_Section, C_freq_id, 9000.0 );
 //   ActiveRadar.PRF         := IniF.ReadFloat(C_wmradar_Section, C_prf_id,  3000.0 );

    readDbl := IniF.ReadFloat(C_wmradar_section, C_range_id,  32.0 );;
    TheWCC.SetView_RangeScale(readDbl);

    ActiveRadar.PulseWidth  := IniF.ReadFloat(C_wmradar_Section, C_pw_id, 0.05);
    ActiveRadar.AveratePower := Inif.ReadFloat(C_wmradar_Section, C_avpow_id, 21.0);


    ActiveRadar.LastTrackNumber := ShipID * 100;

    //. multiplayer section . . . .
    if GamePlayMode = pmModeClient then begin

      readInt := IniF.ReadInteger(C_mult_sect, 'autoconnect', 0);
      if readInt = 1 then begin
        AddToMemoLog('Connecting to: '+ ServerIp + ' '+ ServerPort);
        netComm.Connect(ServerIp, ServerPort);
      end;

      readInt := IniF.ReadInteger(C_mult_sect, 'timebaseserver', 0);
      if readInt = 1 then begin
        AddToMemoLog('timebase synch server');
        FTimebaseServer := TRUE;
        NetHandler[OrdID_Synch_timebase       ] := NIL
      end
      else begin
        FTimebaseServer := FALSE;
        NetHandler[OrdID_Synch_timebase       ] := Handle_Synch_timebase;
      end;
    end;

    if GameSetting.TargetFile <> '' then
      LoadTarget(GameSetting.TargetFile);

  end;

  procedure TTDCManager.LoadTarget(const fIni: string);
  var IniF:TIniFile;
      readDbl : double;
      readInt : integer;
      i, j: integer;
      sects : TStrings;
      ship : TXShip;
  begin // di sini CreateForm dan Load Map
    if not FileExists(FIni) then begin
      LogMemo.Add(fini + ' not found. No Target Loaded');
      exit;
    end;
      LogMemo.Add('Loading ' + fIni);

    IniF   := TIniFile.Create(FIni);
    sects := TStringList.Create;

    IniF.ReadSections(sects);
    for i := 0 to sects.Count-1 do begin

      LogMemo.Add('uid: ' + sects[i]);

      tmpNewObj  := TXShip.Create;

      Ship := tmpNewObj as TXShip;
      Ship.CreateDefaultView(FMap);
      Ship.UniqueID := sects[i];

      Ship.Speed    := IniF.ReadFloat(sects[i], C_speed_id,   0.0 );
      Ship.Heading  := IniF.ReadFloat(sects[i], C_heading_id, 0.0 );

      Ship.PositionX := IniF.ReadFloat(sects[i], C_posx_id,  0.0 );
      Ship.PositionY := IniF.ReadFloat(sects[i], C_posy_id,  0.0 );
      Ship.PositionZ := IniF.ReadFloat(sects[i], C_posz_id,  0.0 );

      Ship.Enabled := TRUE;
      MainObjList.AddObject(ship);
    end;
    sects.Clear;
    sects.Free;
  end;


  procedure TTDCManager.LoadScenario;
  begin
{    // kondisi map sudah di load.
} end;

  procedure TTDCManager.UnLoadScenario;
  begin
     MainObjList.ClearObject;
     MainViewList.ClearObject;
     netComm.Disconnect;
     // LoadGrid('');  // comment by bagus
  end;

  procedure TTDCManager.UpdateMember;
  begin
    inherited;
    xShip.Update;
    ActiveRadar.Update;
    TheWCC.Update;
  end;

  //--------------------------------------------------------------------------
  procedure TTDCManager.DrawAllOnMapXCanvas(aCnv: TCanvas);
  begin
    xShip.DrawViews(aCnv);
    ActiveRadar.DrawViews (aCnv);

    TheWCC.Draw(aCnv);

  end;
  procedure TTDCManager.DrawMember;
  begin
    ActiveRadar.ConvertViewsPosition;
    xShip.ConvertViewsPosition;

    TheWCC.ConvertViewPosition;

    FMap.Repaint;
  end;

  function TTDCManager.GetUniqueId: string;
  begin
     Result := IntToStr(UniqueIdFactory);
     Inc(UniqueIdFactory);
  end;


  procedure TTDCManager.AddToMemoLog(const str: string);
  begin
    if Assigned(LogMemo) then begin
     LogMemo.Add('  ' + str);
    end;
  end;

  procedure TTDCManager.CleanUpMember;
  begin
    inherited;
    ActiveRadar.DetObjects.CleanUpObject;
    TheWCC.TrackList.CleanUpObject;
  end;

  procedure TTDCManager.CreateShipForms(const aShipClassID, aTDCNumber: integer);
  begin
    case aShipClassID of
      //----------------------------------------------------------------------
      C_ShipC_Fatahillah : begin   // nala
        TheWCC := TWCC_NalaInterface.Create;

        FMap := TheWCC.frmTengah.Map;
        TheWCC.GunNumber := C_ShipC_Fatahillah;
        TheWCC.shipClassID := C_ShipC_Fatahillah;
      end;
      //----------------------------------------------------------------------
      C_ShipC_Mandau     : begin      //Rencong
        TheWCC := TWCC_RencongInterface.Create;
        FMap := TheWCC.frmTengah.Map;
        TheWCC.GunNumber := 2;
        TheWCC.shipClassID := C_ShipC_Mandau;
      end;
      //----------------------------------------------------------------------
      C_ShipC_Singa      : begin       // fpb singa
        TheWCC := TWCC_SingaInterface.Create;
        FMap := TheWCC.frmTengah.Map;
        TheWCC.GunNumber := 2;
        TheWCC.shipClassID := C_ShipC_Singa;
      end;
      else begin
         // hardcode nala
        TheWCC := TWCC_NalaInterface.Create;
        FMap := TheWCC.frmTengah.Map;
        TheWCC.GunNumber := 3;
        TheWCC.shipClassID := C_ShipC_Fatahillah;

//         MessageDlg('WCC Invalid Ship Class: ' +#13+#10+
//         bridgeSet.mShip.mClassName, mtError, [mbOK], 0);
//         Application.Terminate;
      end;
{      //----------------------------------------------------------------------
      C_ShipC_AhmadYani  : begin  // Oswald Siahaan

      end;
      //----------------------------------------------------------------------
      C_ShipC_Sigma      : begin

      end;
}
    end;
      if Assigned(TheWCC)then begin
        TheWCC.ShowAllForm(aShipClassID);
        TheWCC.SetDefaultLayOut;
      end;
  end;

  procedure TTDCManager.CreateMinimalForms;
  begin
    frmMapWindow := TfrmMapWindow.Create(nil);
    FMap := frmMapWindow.Map;
    frmMapWindow.Show;
  end;

 //= NetWork Event handler =================================================
  procedure  TTDCManager.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
  var  sc  : TSimulationClass;
       obj : TClientObject;
       aRec: ^TRecData3DPosition;

       TestHeading : Double;
  begin
    aRec := @apRec^;

    aRec.X := aRec.X + OffX_Map;
    aRec.Y := aRec.Y + OffY_Map;
    AddToMemoLog(' _pos: ' + dbID_to_UniqueID(aRec.ShipID) + ' ' + Format('%2.6f, %2.6f',[aRec.X, aRec.Y]));

    if aRec.ShipID = UniqueID_To_dbID(xShip.UniqueID) then begin
      if not TheWCC.tdcData.DeadReconEnable then begin
        xShip.PositionX := aRec.X;
        xShip.PositionY := aRec.Y;
        xShip.PositionZ := aRec.Z;

        xShip.Speed    := aRec.speed;
        xShip.Heading  := aRec.heading;
      end;
    end
    else begin
      sc := MainObjList.FindObjectByUid(dbID_to_UniqueID(aRec.ShipID));

      if sc = nil then begin
       obj := TClientObject.Create;
       obj.UniqueID := dbID_to_UniqueID(aRec.ShipID);
       obj.Enabled := TRUE;

       MainObjList.AddObject(obj);
      end
      else
       obj := sc as TClientObject;

      obj.PositionX := aRec.X;
      obj.PositionY := aRec.Y;
      obj.PositionZ := aRec.Z;
      obj.Speed     := aRec.speed;

      obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);
    end;
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure  TTDCManager.Event_OrderRecognizer(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrder;
  begin
    aRec := @apRec^;
    AddToMemoLog(' RECV: '+C_ORDER_STR[aRec.OrderID] +
      ' to:' + aRec.ShipID);

    if aRec.ShipID = xShip.UniqueID then begin
      if Assigned(NetHandler[aRec.OrderID]) then begin
        NetHandler[aRec.OrderID](apRec, aSize);
      end
      else begin
        if (aRec.OrderID >0) and (aRec.OrderID <= C_Max_Order_ID) then
          AddToMemoLog(' Unhandled Order ID '+
          InttoStr(aRec.OrderID) + '  '+ C_ORDER_STR[aRec.OrderID] )
        else
          AddToMemoLog(' Unhandled Order ID '+ InttoStr(aRec.OrderID) );
      end;
    end
    else begin
      AddToMemoLog(' Not for me. ');
      // kecuali ntransfer antar kapal
    end;
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TTDCManager.Event_AssignHandler(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecOrderAssignment;
  begin
    aRec := @apRec^;

    AddToMemoLog(' +RECV: Order Assignment '
      + Format('%d %d -> %s', [aRec^.Ship_TID, aRec^.TrackNumber, aRec^.DetectedUID]));

    if Assigned(NetHandler[aRec.OrderID]) then
      NetHandler[aRec.OrderID](apRec, aSize)
    else
      AddToMemoLog(' Unhandled OrderAssignment '+ InttoStr(aRec.OrderID) );

  end;
// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
procedure TTDCManager.EventonReceiveSplashPoint(apRec: PAnsiChar; // Even untuk receive Posisi Splash Point dari 3D
  aSize: integer);
var aRec : ^TRecSplashCannon;
    RecSplash : TRecSplashCannon;
begin
  aRec := @apRec^;
  if aRec^.ShipID = UniqueID_To_dbID(xShip.UniqueID) then begin
    RecSplash.PosX      := aRec^.PosX + OffX_Map;
    RecSplash.PosY      := aRec^.PosY + OffY_Map;
    RecSplash.PosZ      := aRec^.PosZ;
    RecSplash.WeaponID  := aRec^.WeaponID;
    RecSplash.LauncherID:= aRec^.LauncherID;
    (TheWCC as TGenericWCCInterface).ShowSplasFrom3D(RecSplash);
  end;
end;

procedure TTDCManager.EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
var arMissile : ^TRec3DMissilePos;
    TipeMissile, status, tempUID: string;
    obj : TClientObject;
    shipID, WeaponID, launcherID, missileID, MissileNumber : integer ;
begin
    arMissile := @apRec^;

    arMissile^.x := arMissile^.x + OffX_Map;
    arMissile^.y := arMissile^.y + OffY_Map;
    shipID        := arMissile^.shipID;
    WeaponID      := arMissile^.WeaponID;
    launcherID    := arMissile^.launcherID;
    missileID     := arMissile^.missileID;
    missileID     := arMissile^.missileID;
    MissileNumber := arMissile^.MissileNumber;

    if (WeaponID >= C_DBID_CANNON40) and (WeaponID <= C_DBID_CANNON120) then Exit;

    case WeaponID of
      C_DBID_ASROC        : TipeMissile := 'ASROC';
      C_DBID_RBU6000      : TipeMissile := 'RBU6000';
      C_DBID_TORPEDO_A244S: TipeMissile := 'TORPEDO_A244S';
      C_DBID_TORPEDO_SUT  : TipeMissile := 'TORPEDO_SUT';
      C_DBID_YAKHONT      : TipeMissile := 'YAKHONT';
      C_DBID_C802         : TipeMissile := 'C802';
      C_DBID_EXOCET_MM40  : TipeMissile := 'EXOCET_MM40';
      C_DBID_EXOCET_MM38  : TipeMissile := 'EXOCET_MM38';
    end;

    tempUID := dbID_to_MissileUniqueID( shipID, WeaponID, LauncherID, missileID, MissileNumber);

    tmpNewObj := MainObjList.FindObjectByUid(tempUID);

    if Assigned(tmpNewObj) then
      begin
        // UPDATE
        if arMissile^.status = ST_MISSILE_RUN then
        begin
          obj := tmpNewObj as TClientObject;

          obj.PositionX := arMissile^.x;
          obj.PositionY := arMissile^.y;
          obj.PositionZ := arMissile^.Z;
          obj.Speed    := arMissile^.speed;
          obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);

          status := 'Running';
        end
        else if arMissile^.status = ST_MISSILE_DEL then
        begin
          MainObjList.RemoveObject(tmpNewObj);
        end
        else if arMissile^.status = ST_MISSILE_HIT then
        begin
           status := 'Explode';
  //        MainObjList.RemoveObject(tmpNewObj);
        end;

        AddToMemoLog(' +RECV: ' + TipeMissile + ' is ' + status);
        AddToMemoLog('    Speed    :' + FloatToStr(arMissile.speed) );
        AddToMemoLog('    Heading  :' + FloatToStr(arMissile.heading) );
        AddToMemoLog('    XYZ      :' + Format('%3.8f, %3.8f, %3.8f', [arMissile.X, arMissile.Y, arMissile.Z]));
      end
    else
    begin
      if arMissile^.status = ST_MISSILE_RUN then
      begin
        //CREATE NEW
        obj := TClientObject.Create;
        //obj.UniqueID := aRec.missileID;
        obj.Enabled := TRUE;
        obj.UniqueID := tempUID;  //--> set UniqID-nya spt temp. biar klo dicari ketemu
        {tambahan Aldy}
        obj.PositionX := arMissile^.x;
        obj.PositionY := arMissile^.y;
        obj.PositionZ := arMissile^.Z;
        obj.Speed    := arMissile^.speed;
        obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);

        MainObjList.AddObject(obj);
      end;
    end;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TTDCManager.dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                         MissileID, MissileNumber  : integer): string;
begin
    result := Format('%s%0.4d%0.2d%0.2d%0.2d%0.2d',['MSL', ShipID, WeaponID, LauncherID,
                                                    MissileID, MissileNumber]);
end;


// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_init_datum(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;

    TheWCC.SetInitDatum(aRec^ , false);
  end;

  procedure TTDCManager.Handle_FOC_plus(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.setFOCPlus(aRec^, false);
  end;

  procedure TTDCManager.Handle_FOC_minus(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.setFOCMinus(aRec^, false);
  end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TTDCManager.Handle_Change_Ident(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin // change ident bawah air, atas air, udara
    aRec := @apRec^;
    TheWCC.Recv_Ident(aRec^);
  end;

  procedure TTDCManager.Handle_select_radar_type(apRec: PAnsiChar;
    aSize: integer);
//  var aRec: ^TRecOrder;
  begin
//    aRec := @apRec^;
//    aRec.OrderByteParam;
  end;

// .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
  procedure TTDCManager.Handle_start_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if aRec^.OrderType < 10 then
      TheWCC.StartICMLeft(aRec^.OrderType, aRec^.X, aRec^.Y, FALSE)
    else
      TheWCC.StartICMRight(aRec^.OrderType, aRec^.X, aRec^.Y, FALSE);
  end;

  procedure TTDCManager.Handle_update_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.UpdateICMPos(aRec^.OrderType,  aRec^.X, aRec^.Y);

  end;

  procedure TTDCManager.Handle_end_ICM(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if aRec^.OrderType < 10 then
      TheWCC.EndICMLeft(aRec^.OrderType, FALSE)
    else
      TheWCC.EndICMRight(aRec^.OrderType, FALSE);
  end;

  procedure TTDCManager.Handle_assign_tor(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.SetAssignTorpedo_MK44(aRec^, false);
  end;

  procedure TTDCManager.Handle_deassign_tor(apRec: PAnsiChar;
    aSize: integer);
//  var aRec: ^TRecOrder;
  begin
//    aRec := @apRec^;
    TheWCC.SetDeAssignTorpedo(false);
  end;

  // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_assign_asrl(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.setAssignASRL(aRec^, 1, false);
  end;

  procedure TTDCManager.Handle_deassign_asrl(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.setDeAssignASRL(aRec^, false);
  end;

  // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_WIPE(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.RecvWIPE(aRec^);

  end;
// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  procedure TTDCManager.Handle_init_ram(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.InitiateRAM(aRec^, false);
  end;

  procedure TTDCManager.Handle_init_auto(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.InitiateAuto(aRec^, false);
  end;

  procedure TTDCManager.Handle_init_dr(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.InitiateDR(aRec^, false);
  end;

  procedure TTDCManager.Handle_assign_ram(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
    aRec := @apRec^;
    TheWCC.AssignRAM(aRec^, FALSE);

  end;

  procedure TTDCManager.Handle_assign_FC(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecFireControlOrder;
  begin
    aRec := @apRec^;
    case TOrdType_FC_command(aRec^.FC_command) of
       RATO, RSTO,
       ATO, STO   : TheWCC.RecvAssign_FC(aRec^);
       Open_Fire  : TheWCC.SetOpenFire_FC(aRec^.FC_number, FALSE);
       Hold_Fire  : TheWCC.SetHoldFire_FC(aRec^.FC_number, FALSE);
       GenFix     : TheWCC.RecvAssign_GenFiX(aRec^);
       BlindBomb  : TheWCC.RecvAssign_BlindBomb(aRec^);
       AssignTrackSs : TheWCC.RecvAssign_FC(aRec^);
       //InitTrackSurf  : TheWCC.RecvInitiateTrack(aRec^);
    end;
  end;

  procedure TTDCManager.Handle_deassign_FC(apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecFireControlOrder;
  begin
    aRec := @apRec^;
    //SBS, SBA
    TheWCC.RecvDeAssign_FC(aRec^);
  end;

  procedure TTDCManager.Handle_assign_SSM(apRec: PAnsiChar; aSize: integer);
  var aRec : ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.setAssignSSM(aRec^, false);
  end;

  procedure TTDCManager.Handle_deassign_SSM(apRec: PAnsiChar;
    aSize: integer);
//  var aRec : ^TRecOrderXY;
  begin
//    aRec := @apRec^;
    TheWCC.setDeAssignSSM(false);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_init_esm_fix(apRec: PAnsiChar;
    aSize: integer);
  var aRec: ^TRecOrderXY;
  begin
    aRec := @apRec^;
    TheWCC.SetInitESMFix(aRec^, false);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_Synch_timebase(apRec: PAnsiChar; aSize: integer);
  var aRec : ^TRecOrderXY;
  begin
    aRec := @apRec^;
    if ActiveRadar.FRadarType = TRadar_type(aRec.OrderType) then begin
      ActiveRadar.TimeBase.AbsDirection := aRec^.X;
      ActiveRadar.TimeBase.Elevation    := aRec^.Y;
    end;
  end;

  procedure TTDCManager.SendSynchTimeBase;
  var aRec : TRecOrderXY;
  begin
    aRec.ShipID := xShip.UniqueID;

    aRec.X := ActiveRadar.TimeBase.AbsDirection;
    aRec.Y := ActiveRadar.TimeBase.Elevation;
    aRec.OrderType := Byte(ActiveRadar.FRadarType);
    aRec.OrderID := OrdID_Synch_timebase;
    NetComm.sendDataEx(C_REC_ORDER_XY, @aRec);
  end;

  // .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  procedure TTDCManager.Handle_CorrectRam     (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecOrderAssignment;
  begin
    aRec := @apRec^;

    if aRec.ShipID = xShip.UniqueID then begin
      TheWCC.AssignTrackToDetected(aRec^.Ship_TID, aRec^.TrackNumber, aRec^.DetectedUID)
    end;
  end;

  procedure TTDCManager.Handle_UpdateTrackPosition  (apRec: PAnsiChar; aSize: integer);
  var aRec: ^TRecTrackOrder;
  begin
     aRec := @apRec^;
     TheWCC.RecvUpdateTrackPosition(aRec^);
  end;


  function TTDCManager.GetRepaintCycle: Word;
  begin
    result := FRepaintIL.Cycle;
  end;

  procedure TTDCManager.SetRepaintCycle(const Value: Word);
  begin
    FRepaintIL.Cycle := Value;
  end;

{procedure TTDCManager.Handle_assign_FC_WCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecFireControlOrder;
begin
  aRec := @apRec^;
  TheWCC.Recv_AssignFC_WCC(aRec^);
end;

procedure TTDCManager.Handle_deassign_FC_WCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecFireControlOrder;
begin
  aRec := @apRec^;
  //TheWCC.OBM_DeAssignFC(aRec^, false);
end;
}
procedure TTDCManager.Handle_assign_gun_WCC(apRec: PAnsiChar; aSize: integer);
//var aRec: ^TRecGunControl;
begin
  //aRec := @apRec^;
  //TheWCC.AssignGunToFC(aRec.Gun_number, aRec.AssignedTo, False);
end;

procedure TTDCManager.Handle_deassign_gun_WCC(apRec: PAnsiChar; aSize: integer);
//var aRec: ^TRecFireControlOrder;
begin
  //aRec := @apRec^;
  //TheWCC.OBMRight_AssignFC(aRec^, false);
end;

procedure TTDCManager.Handle_assign_FC_OCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderAssignment;
begin
  aRec := @apRec^;
  TheWCC.OCC_AssignFC(aRec^);
end;

procedure TTDCManager.Handle_deassign_FC_OCC(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecOrderAssignment;
begin
  aRec := @apRec^;
  TheWCC.OCC_DeassignFC(aRec^);
end;

procedure TTDCManager.LoadKabehSetting;
var DBServer, DBProto, DBName, DBUser,
    DBPass : string;
    CurrentScenID  : Integer;
    Env_Map, n : Integer;

begin

// disini cuman baca doang.
{  bridgeSetPath := GetEmulatorSettingDirectory;

  with bridgeSet.mDB do
    InitDefault_DBConfig(bridgeSetPath,
      mDBServer, mDBProto, mDBName, mDBUser, mDBPass );

  with bridgeSet.mServer do
    InitDefault_GameServerConfig(bridgeSetPath,
      m2D_IP,  m2D_Port,
      m3D_IP,  m3D_Port);

  with bridgeSet.mShip do
    InitDefault_ShipConfig(bridgeSetPath,
      mShipID,   mClassID,
      mShipName, mClassName);

  }
      n := ParamCount ;
    if n < max_param then
    begin
      StandAloneMode := true ;
    end;

   if not StandAloneMode then  begin
      InitDefault_AllConfigFromInstruktur(ServerIp,ServerPort,
      DBServer, DBProto, DBName, DBUser,
      DBPass, ShipID, CurrentScenID);

      if DataModule1.InitZDB(DBServer, DBProto, DBName, DBUser, DBPass) then
      begin
        ShipClassID  := DataModule1.GetShipType(ShipID, ShipClassName);
        ShipName     := DataModule1.GetShipName(ShipID);

        AddToMemoLog(' ShipID      = ' + IntToStr(ShipID) );
        AddToMemoLog(' ShipClassId = ' + IntToStr(ShipClassID) );
        AddToMemoLog(' ShipName ' + ShipName );
        AddToMemoLog(' ShipClassName ' + ShipClassName );
      end;
      Env_Map := DataModule1.GetMapById(CurrentScenID);

      DataModule1.GetOffsetMapByEnvMap(Env_Map ,OffX_Map, OffY_Map);
   end;

  InitConfig_Map(settingMap);

  with bridgeSet.mDB do begin
    mDBServer  := DBServer;
    mDBProto   := DBProto;
    mDBName    := DBName;
    mDBUser    := DBUser;
    mDBPass    := DBPass;
  end;

  with bridgeSet.mServer do begin
    m2D_IP     := ServerIp;
    m2D_Port   := ServerPort;
    m3D_IP     := '';
    m3D_Port   := '';
  end;

  with bridgeSet.mShip do begin
    mShipID    := ShipID;
    mClassID   := ShipClassID;
    mShipName  := ShipName;
    mClassName := ShipClassName;
    mScenario  := CurrentScenID;
  end;

//  InitConfig_TDC(settingTDC);
//  ServerIp    := bridgeSet.mServer.m2D_IP;
//  ServerPort  := bridgeSet.mServer.m2D_Port;
//
//  ShipID      := bridgeSet.mShip.mShipID;
//  ShipName    := bridgeSet.mShip.mShipName;
//  ShipClassID := bridgeSet.mShip.mClassID;
//
end;

procedure TTDCManager.ApplyKabehSetting;
begin

  xShip.UniqueID := dbID_to_UniqueID(bridgeSet.mShip.mShipID);

  xShip.PositionX := settingMap.X;
  xShip.PositionY := settingMap.Y;
  xShip.PositionZ := 0;

  ActiveRadar.PositionX := xShip.PositionX;
  ActiveRadar.PositionY := xShip.PositionY;
  ActiveRadar.PositionZ := xShip.PositionZ;

end;

end.



