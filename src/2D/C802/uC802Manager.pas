unit uC802Manager;

interface

uses
  Classes, uTCPClient, uTCPServer, overbyteicsWSocketS, uTestShip, uC802_Object,
  uSimulationManager, fPanelBawah, uTCPDatatype, WinSock;

type
  TC802Manager = class(TSimulationManager)

  private
  public
    /// <author>aldy s</author>
    /// <summary>
    /// Untuk koneksi ke Instruktur
    /// </summary>
    NetComm,
    TCPClient : TTCPClient;
    LogMemo   : TStrings;
    ServerIp  : string;
    ServerPort: string;

    ShouldConnect : boolean;

    /// <summary>
    /// Untuk koneksi local ke Archos
    /// </summary>
    NetLocalCommServer : TTCPServer;

    StandAloneMode   : Boolean;
    pCurrentScenID   : integer;

    pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
    pShipName, pClassName : string;
    pShipID, pClassID : Integer;

    /// <author>aldy</author>
    xShip       : TXShip;    //posisi kapal
    ShipID, ShipClassID : integer;
    ShipName, ShipClassName : string;

    // data environment
    Wind_Spd, Wind_Dir, Temp : Double;

    Missile1    : TC802_Object;
    Missile2    : TC802_Object;
    Missile3    : TC802_Object;
    Missile4    : TC802_Object;

    data_Path : string;

    {OFFSET MAP}
    mapOffsetX, mapOffsetY : Double;

    constructor Create; override;
    destructor Destroy; override;

    procedure BeginSimulation;
    procedure EndSimulation;
    procedure CreateObject;
    procedure SetLayOutForm;

    procedure Initialize;
    procedure Net_Connect;
    procedure Net_Disconnect;

    procedure AddToMemoLog(const str: string);
    function LoadScenarioFromIniFile(const fIni: string): integer; override;

    procedure EventOnMainTimer(const dt: double); override;
    procedure EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
    procedure EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
    procedure EventonReceiveStatusConsole(apRec: PAnsiChar; aSize: integer);
    procedure EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
    procedure EventOnReceiveAssignedobject(apRec: PAnsiChar; aSize: integer);
    procedure EventOnReceiveLauncherOn(apRec: PAnsiChar; aSize: integer);

    //added by aldy prediction
    procedure CalcDistanceCoursePrediction(obj : TRec_Target; var Distance, Course : Double);

    //get Offset Peta
    procedure SetSceneOffSetFromID(const id: integer; var x, y: Double);
    procedure GetSceneOffSetFromPortID(const id: integer; var x, y: double);
    procedure GetEnvPetaFromSceID(const id: integer; var aValue: integer);

    procedure ReceiveCommand(aKey_C802  : TRecCMD_C802);

    procedure SendEvenC802(EvenId: Word; Prm1 , Prm2 , Prm3: double);

    function GetHostandIPList(var aHostName: string; ss: TStrings): Boolean;
  end;

var
  C802Manager : TC802Manager;

const
  SM_COMBAT = 0;
  SM_SIMULATE = 1;
  SM_CHECK = 2;

implementation

uses
  overbyteicsWSocket, uBridgeSet, SysUtils, Keyboard,
  fPanelAtas, uLibClientObject, uBaseSimulationObject, uBaseFunction, Forms, IniFiles,
  uBaseConstan, MapXLib_TLB, uFormUtil, Windows, uDataModule, uBaseDataType,
  uEventForm, uClassDatabase, FKeyboard, uSettingFormToMonitorWith_ini;

function dbID_to_MissileUniqueID(const shipid, tipeid, launcher, missileid : integer): string; overload;
  begin
    result := Format('%s%0.4d%0.2d%0.2d%0.2d',['MSL', shipID, tipeID, launcher, missileid]);
  end;

function dbID_to_MissileUniqueID(const ShipID, WeaponID, LauncherID,
                                       MissileID, MissileNumber  : integer): string; overload;
begin
  result := Format('%s%0.4d%0.2d%0.2d%0.2d%0.2d',['MSL', ShipID, WeaponID, LauncherID,
                                                  MissileID, MissileNumber]);
end;

constructor TC802Manager.Create;
begin
  inherited;
  NetComm := TTCPClient.Create;
  TCPClient := NetComm;

  Missile1 := TC802_Object.Create;
  Missile2 := TC802_Object.Create;
  Missile3 := TC802_Object.Create;
  Missile4 := TC802_Object.Create;

  xShip := TXShip.Create;
  {default posisi ship}
  xShip.PositionX := 118.5;
  xShip.PositionY := -9.2;

  NetLocalCommServer := TTCPServer.Create;

  { default prelaunch check status }
  Missile1.FInitState   := True;
  Missile1.FPowerSupply := True;
  Missile1.FTurnOnEquip := True;
  Missile1.FCheckStage1 := True;
  Missile1.FAngleSet    := True;
  Missile1.FCoCheck     := True;
  Missile1.FTzkSetting  := True;
  Missile1.FCommandNo3  := True;
  Missile1.FMisNormal   := True;
  Missile1.FAccurateCal := True;
  Missile1.FInsideSectr := True;
  Missile1.FLimiterOut  := True;
  Missile1.FRigidityStt := True;
  Missile1.FFullOpen    := True;
  Missile1.FBoosterArm  := True;
  Missile1.FLaunchReady := True;
  Missile1.FLaunchButton := True;
  Missile1.FBatteryAct  := True;
  Missile1.FPowerSwitch := True;
  Missile1.FGyroUncaged := True;
  Missile1.FIgnition    := True;
  Missile1.FTakeOff     := True;

  Missile2.FInitState   := True;
  Missile2.FPowerSupply := True;
  Missile2.FTurnOnEquip := True;
  Missile2.FCheckStage1 := True;
  Missile2.FAngleSet    := True;
  Missile2.FCoCheck     := True;
  Missile2.FTzkSetting  := True;
  Missile2.FCommandNo3  := True;
  Missile2.FMisNormal   := True;
  Missile2.FAccurateCal := True;
  Missile2.FInsideSectr := True;
  Missile2.FLimiterOut  := True;
  Missile2.FRigidityStt := True;
  Missile2.FFullOpen    := True;
  Missile2.FBoosterArm  := True;
  Missile2.FLaunchReady := True;
  Missile2.FLaunchButton := True;
  Missile2.FBatteryAct  := True;
  Missile2.FPowerSwitch := True;
  Missile2.FGyroUncaged := True;
  Missile2.FIgnition    := True;
  Missile2.FTakeOff     := True;

  Missile3.FInitState   := True;
  Missile3.FPowerSupply := True;
  Missile3.FTurnOnEquip := True;
  Missile3.FCheckStage1 := True;
  Missile3.FAngleSet    := True;
  Missile3.FCoCheck     := True;
  Missile3.FTzkSetting  := True;
  Missile3.FCommandNo3  := True;
  Missile3.FMisNormal   := True;
  Missile3.FAccurateCal := True;
  Missile3.FInsideSectr := True;
  Missile3.FLimiterOut  := True;
  Missile3.FRigidityStt := True;
  Missile3.FFullOpen    := True;
  Missile3.FBoosterArm  := True;
  Missile3.FLaunchReady := True;
  Missile3.FLaunchButton := True;
  Missile3.FBatteryAct  := True;
  Missile3.FPowerSwitch := True;
  Missile3.FGyroUncaged := True;
  Missile3.FIgnition    := True;
  Missile3.FTakeOff     := True;

  Missile4.FInitState   := True;
  Missile4.FPowerSupply := True;
  Missile4.FTurnOnEquip := True;
  Missile4.FCheckStage1 := True;
  Missile4.FAngleSet    := True;
  Missile4.FCoCheck     := True;
  Missile4.FTzkSetting  := True;
  Missile4.FCommandNo3  := True;
  Missile4.FMisNormal   := True;
  Missile4.FAccurateCal := True;
  Missile4.FInsideSectr := True;
  Missile4.FLimiterOut  := True;
  Missile4.FRigidityStt := True;
  Missile4.FFullOpen    := True;
  Missile4.FBoosterArm  := True;
  Missile4.FLaunchReady := True;
  Missile4.FLaunchButton := True;
  Missile4.FBatteryAct  := True;
  Missile4.FPowerSwitch := True;
  Missile4.FGyroUncaged := True;
  Missile4.FIgnition    := True;
  Missile4.FTakeOff     := True;
end;

destructor TC802Manager.Destroy;
begin
  NetComm.Free;

  Missile1.Free;
  Missile2.Free;
  Missile3.Free;
  Missile4.Free;

  xShip.Free;

  NetLocalCommServer.Free;

  inherited;
end;

procedure TC802Manager.BeginSimulation;
var
  p : Integer;
  fname : string;
begin
  //create Object2-nya
  CreateObject;
  SetLayOutForm;

  TryStrToInt(pServer_Port, p);
  p := p + 1;
  //Register Packet-packet Net
  //------------------------------------------------------------ Local
  NetLocalCommServer.RegisterProcedure(REC_CMD_C802, EventOnReceiveCommand, SizeOf(TRecCMD_C802));
  NetLocalCommServer.Listen(IntToStr(p));
  //------------------------------------------------------------ To Instruktur
  NetComm.RegisterProcedure(REC_DATA_C802, nil, SizeOf(TRecData_C802));
  NetComm.RegisterProcedure(REC_3D_POSITION, EventonReceiveDataPosition, SizeOf(TRecData3DPosition));
  NetComm.RegisterProcedure(REC_STAT_ORDER_CONSOLE, EventonReceiveStatusConsole, SizeOf(TRecStatus_Console));
  NetComm.RegisterProcedure(REC_STAT_ASSIGN_OBJECT, EventOnReceiveAssignedobject, SizeOf(TRecObjectAssigned));
  NetComm.RegisterProcedure(REC_3D_MISSILEPOS, EventonRecMissilePosAvailable, SizeOf(TRec3DMissilePos));
  NetComm.RegisterProcedure(REC_EVENT_LOG, nil, SizeOf(TRecEventLog));


  PanelBawah.MapC802 := FMap;
  PanelBawah.MapC802.Refresh;

  if not StandAloneMode then
  Net_Connect;

  StartSimulation;
end;

/// <summary>
/// event untuk timer selama simulasi berjalan
/// -> untuk melakukan setiap proses yg dijalankan setiap waktu
/// -> e.g. menggambar pada peta (repaint, dll)
/// </summary>
/// <param name="dt"></param>
procedure TC802Manager.EventOnMainTimer(const dt: double);
begin
  inherited;

  if C802Manager.TCPClient.State <> wsConnected then
  begin
    C802Manager.Net_Connect;
  end
  else begin
    if Assigned(PanelBawah) then
    begin
      FMap.CenterX  := xShip.PositionX;
      FMap.CenterY  := xShip.PositionY;
      PanelBawah.ownHeading := xShip.Heading;
      FMap.Rotation := 360 - PanelBawah.ownHeading;
      PanelBawah.UpdatePosition;
      PanelBawah.UpdateTargetAssign1;
      PanelBawah.UpdateTargetAssign2;

      if PanelBawah.StartMode_index = SM_SIMULATE then
      begin
        { -- bebe
        PanelBawah.SimTarget1Draw.Update;
        //move
        PanelBawah.SimTarget1Draw.Run(dt);
        }
      end;
    end;
  end;

end;

procedure  TC802Manager.EventOnReceiveCommand(apRec: PAnsiChar; aSize: integer; Sender: TWSocketClient);
var aRec : ^TRecCMD_C802;
    capt : string;
begin
  aRec := @apRec^;

//  Keyboard.SendKey();

  case aRec.cmd of
    CMD_C802_Combat:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_COMBAT;
          EnterButton;
        end;
      end;
    CMD_C802_Simulate:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_SIMULATE;
          CreateSimulationObject;
          EnterButton;
        end;
      end;
    CMD_C802_Check:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_CHECK;
          EnterButton;
        end;
      end;
    CMD_C802_LogOff:
      with PanelBawah do begin
        PgCtrlMainMenu.Pages[4].Show;
        ActivePage := PAGE_LOGOFF;
      end;
    CMD_C802_Status:
      with PanelBawah do begin
        PgCtrlMainMenu.Pages[0].Show;
        ActivePage := PAGE_STATUS;
      end;
    CMD_C802_MControl:
      with PanelBawah do begin
        PgCtrlMainMenu.Pages[1].Show;
        ActivePage := PAGE_MCONTROL;
        PanelEditOn(pnlPrecheck_MControl);
      end;
    CMD_C802_ParSetting:
      with PanelBawah do begin
        PgCtrlMainMenu.Pages[2].Show;
        ActivePage := PAGE_PARSETTING;
      end;
    CMD_C802_RecordData:
      with PanelBawah do begin
        PgCtrlMainMenu.Pages[3].Show;
        ActivePage := PAGE_RECORDDATA;
        PanelEditOn(pnlRecordData_No);
      end;

    CMD_C802_Tab:
      with PanelBawah do begin
        case ActivePage of
          PAGE_PARSETTING_ATTACK:
            begin
              if Length(ActivePanel.Caption) = 0 then
                ActivePanel.Caption := '1'
              else begin
                case StrToInt(ActivePanel.Caption) of
                  1: ActivePanel.Caption := '2';
                  2: ActivePanel.Caption := '3';
                  3: ActivePanel.Caption := '1';
                end;
              end;
            end;
        end;

      end;
    CMD_C802_Esc:
      with PanelBawah do begin
        case ActivePage of
          PAGE_MCONTROL..PAGE_LOGOFF:
            begin
              PanelEditOff(ActivePanel);
              PgCtrlMainMenu.Pages[0].Show;
            end;
          PAGE_PARSETTING_FIREPWR..PAGE_PARSETTING_QUEST:
            begin
              PanelEditOff(ActivePanel);
              ActivePage := PAGE_PARSETTING;
            end;
          PAGE_CHECK:
            begin
              grpCheckPage.Visible := False;
              grpStartPage.Visible := True;
              grpStartPage.BringToFront;
              ActivePage := PAGE_START;

              PanelUp(StartMode_array[0]);
              PanelUp(StartMode_array[1]);
              PanelUp(StartMode_array[2]);
              PanelDown(StartMode_array[StartMode_index]);
            end;
        end;
      end;
    CMD_C802_BackSpace:
      with PanelBawah do begin
        capt := ActivePanel.Caption;
        Delete(capt,Length(capt),1);
        ActivePanel.Caption  := capt;
      end;
    CMD_C802_Enter:
      begin
        PanelBawah.EnterButton;
      end;
    CMD_C802_OnOff:
      begin

      end;
    CMD_C802_Up:
      begin
       PanelBawah.UpButton;
      end;
    CMD_C802_Down:
      begin
       PanelBawah.DownButton;
      end;
    CMD_C802_Left:
      begin

      end;
    CMD_C802_Right:
      begin

      end;
    CMD_C802_Dash:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlTargetSet_1_Number) and (ActivePanel <> pnlTargetSet_1_Distance) and
           (ActivePanel <> pnlTargetSet_1_Speed) and (ActivePanel <> pnlTargetSet_1_Azimuth) and
           (ActivePanel <> pnlTargetSet_1_Course) and (ActivePanel <> pnlTargetSet_2_Number) and
           (ActivePanel <> pnlGPS_para_OwnSpd) and (ActivePanel <> pnlMete_para_WindSpd) and
           (ActivePanel <> pnlMete_para_WindDir) and (ActivePanel <> pnlGyro_para_OwnHdg) and
           (ActivePanel <> pnlQuestion_No) and (ActivePanel <> pnlRecordData_No)
        then
        begin
          capt := ActivePanel.Caption;
          if (StrScan(PChar(capt), '-') = nil) and (Length(capt) = 0) then
            InputNumber('-');
        end;
      end;
    CMD_C802_Dot:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlTargetSet_1_Number) and (ActivePanel <> pnlTargetSet_1_Course) and
           (ActivePanel <> pnlTargetSet_2_Number) and (ActivePanel <> pnlQuestion_No) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          capt := ActivePanel.Caption;
          if StrScan(PChar(capt), '.') = nil then
            InputNumber('.');
        end;
      end;

    CMD_C802_1:
      with PanelBawah do begin
        PanelBawah.InputNumber('1');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '1';
      end;
    CMD_C802_2:
      with PanelBawah do begin
        PanelBawah.InputNumber('2');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '2';
      end;
    CMD_C802_3:
      with PanelBawah do begin
        PanelBawah.InputNumber('3');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '3';
      end;
    CMD_C802_4:
      with PanelBawah do begin
        if (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) then
        begin
          InputNumber('4');

          if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
             (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
             (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
          then
            ActivePanel.Caption := '4';
        end;
      end;
    CMD_C802_5:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('5');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '5';
        end;
      end;
    CMD_C802_6:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('6');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '6';
        end;
      end;
    CMD_C802_7:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('7');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '7';
        end;
      end;
    CMD_C802_8:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('8');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '8';
        end;
      end;
    CMD_C802_9:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('9');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '9';
        end;
      end;
    CMD_C802_0:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlQuestion_No) and (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('0');
        end;
      end;
  end;
end;

procedure  TC802Manager.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
var
  sc  : TSimulationClass;
  obj : TClientObject;
  aRec: ^TRecData3DPosition;
  pts, ptt : tDouble2DPoint;
begin
  aRec := @apRec^;

  {Conver to 3D to map}
  aRec^.x := aRec^.x + mapoffsetX;
  aRec^.y := aRec^.y + mapoffsetY;

  AddToMemoLog(' _pos: ' + IntToStr(aRec^.ShipID) + Format('%2.6f, %2.6f',[aRec^.X, aRec^.Y]));

  // update it's own possision
  if aRec.ShipID = UniqueID_To_dbID(xShip.UniqueID) then
  begin
      xShip.PositionX := aRec.X;
      xShip.PositionY := aRec.Y;
      xShip.PositionZ := aRec.Z;

      xShip.Speed    := aRec.speed;
      xShip.Heading  := aRec.Heading;

      //***
      xShip.Pitch := aRec.pitch;
      xShip.Roll  := aRec.roll;
  end
  else begin
    //if PanelBawah.StartMode_index = SM_COMBAT then
    //begin
//      sc := TSimulationClass.Create;
      sc := MainObjList.FindObjectByUid( dbID_to_UniqueID(aRec.ShipID)) ;

      {klo gk nemu dicreate}
      if sc = nil then begin
        obj := TClientObject.Create;
        obj.UniqueID := dbID_to_UniqueID(aRec.ShipID);
        obj.Enabled := TRUE;

        obj.PositionX := aRec.X;
        obj.PositionY := aRec.Y;
        obj.PositionZ := aRec.Z;
        obj.Speed    := aRec.speed;
        obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);

        MainObjList.AddObject(obj);
      end
      else {klo nemu di update}
      begin
        obj := sc as TClientObject;

        obj.PositionX := aRec.X;
        obj.PositionY := aRec.Y;
        obj.PositionZ := aRec.Z;
        obj.Speed    := aRec.speed;
        obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);
      end;

    //end;
    //***
  end;

  {tambah untuk simulasi ndiri}
  if PanelBawah.StartMode_index = SM_SIMULATE then
  begin

  end;

end;

procedure TC802Manager.EventOnReceiveLauncherOn(apRec: PAnsiChar;
  aSize: integer);
var
  aRec : ^TRecData_C802;
begin

  aRec := @apRec^;

  if aRec^.OrderID  = __ORD_C802_ON then
  begin
    case aRec^.mLauncherID of
      1 : PanelBawah.Launcher1OnFromInstruktur := True;
      2 : PanelBawah.Launcher2OnFromInstruktur := True;
      3 : PanelBawah.Launcher3OnFromInstruktur := True;
      4 : PanelBawah.Launcher4OnFromInstruktur := True;
    end;

  end
  else if aRec^.OrderID  = __ORD_C802_OFF then
  begin
    case aRec^.mLauncherID of
      1 : PanelBawah.Launcher1OnFromInstruktur := False;
      2 : PanelBawah.Launcher2OnFromInstruktur := False;
      3 : PanelBawah.Launcher3OnFromInstruktur := False;
      4 : PanelBawah.Launcher4OnFromInstruktur := False;
    end;
  end;


end;

procedure  TC802Manager.EventOnReceiveStatusConsole(apRec: PAnsiChar; aSize: integer);
var
  sc  : TSimulationClass;
  obj : TClientObject;
  aRec: ^TRecStatus_Console;
  s   : string;
  MissileNum : TC802_Object;
  r   : Integer;
begin
  {

  TRecStatus_Console = record
    Pc: TPacketCheck;

    OWN_SHIP_UID    : string[15];
    ErrorID    : Word;
    ParamError : Byte;
  }

  MissileNum := TC802_Object.Create;
  aRec := @apRec^;
  AddToMemoLog(' _status: ' + IntToStr(aRec^.ErrorID) + ' ' + IntToStr(aRec^.ParamError));

  if (aRec^.OWN_SHIP_UID = s) or (aRec^.OWN_SHIP_UID = xSHIP.UniqueID) then
  begin
    case Integer(aRec^.ErrorID) of
      __STAT_C802_PRECHECK_LAUNCHER1:
        begin
          Missile1.FInitState   := True;
          Missile1.FPowerSupply := True;
          Missile1.FTurnOnEquip := True;
          Missile1.FCheckStage1 := True;
          Missile1.FAngleSet    := True;
          Missile1.FCoCheck     := True;
          Missile1.FTzkSetting  := True;
          Missile1.FCommandNo3  := True;
          Missile1.FMisNormal   := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(8);
            case r of
              0: Missile1.FInitState   := False;
              1: Missile1.FPowerSupply := False;
              2: Missile1.FTurnOnEquip := False;
              3: Missile1.FCheckStage1 := False;
              4: Missile1.FAngleSet    := False;
              5: Missile1.FCoCheck     := False;
              6: Missile1.FTzkSetting  := False;
              7: Missile1.FCommandNo3  := False;
            end;
            Missile1.FMisNormal   := False;
          end;
        end;

      __STAT_C802_PRECHECK_LAUNCHER2:
        begin
          Missile2.FInitState   := True;
          Missile2.FPowerSupply := True;
          Missile2.FTurnOnEquip := True;
          Missile2.FCheckStage1 := True;
          Missile2.FAngleSet    := True;
          Missile2.FCoCheck     := True;
          Missile2.FTzkSetting  := True;
          Missile2.FCommandNo3  := True;
          Missile2.FMisNormal   := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(8);
            case r of
              0: Missile2.FInitState   := False;
              1: Missile2.FPowerSupply := False;
              2: Missile2.FTurnOnEquip := False;
              3: Missile2.FCheckStage1 := False;
              4: Missile2.FAngleSet    := False;
              5: Missile2.FCoCheck     := False;
              6: Missile2.FTzkSetting  := False;
              7: Missile2.FCommandNo3  := False;
            end;
            Missile2.FMisNormal   := False;
          end;
        end;

      __STAT_C802_PRECHECK_LAUNCHER3:
        begin
          Missile3.FInitState   := True;
          Missile3.FPowerSupply := True;
          Missile3.FTurnOnEquip := True;
          Missile3.FCheckStage1 := True;
          Missile3.FAngleSet    := True;
          Missile3.FCoCheck     := True;
          Missile3.FTzkSetting  := True;
          Missile3.FCommandNo3  := True;
          Missile3.FMisNormal   := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(8);
            case r of
              0: Missile3.FInitState   := False;
              1: Missile3.FPowerSupply := False;
              2: Missile3.FTurnOnEquip := False;
              3: Missile3.FCheckStage1 := False;
              4: Missile3.FAngleSet    := False;
              5: Missile3.FCoCheck     := False;
              6: Missile3.FTzkSetting  := False;
              7: Missile3.FCommandNo3  := False;
            end;
            Missile3.FMisNormal   := False;
          end;
        end;

      __STAT_C802_PRECHECK_LAUNCHER4:
        begin
          Missile4.FInitState   := True;
          Missile4.FPowerSupply := True;
          Missile4.FTurnOnEquip := True;
          Missile4.FCheckStage1 := True;
          Missile4.FAngleSet    := True;
          Missile4.FCoCheck     := True;
          Missile4.FTzkSetting  := True;
          Missile4.FCommandNo3  := True;
          Missile4.FMisNormal   := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(8);
            case r of
              0: Missile4.FInitState   := False;
              1: Missile4.FPowerSupply := False;
              2: Missile4.FTurnOnEquip := False;
              3: Missile4.FCheckStage1 := False;
              4: Missile4.FAngleSet    := False;
              5: Missile4.FCoCheck     := False;
              6: Missile4.FTzkSetting  := False;
              7: Missile4.FCommandNo3  := False;
            end;
            Missile4.FMisNormal   := False;
          end;
        end;

      __STAT_C802_READYCONDITION_LAUNCHER1:
        begin
          Missile1.FAccurateCal := True;
          Missile1.FInsideSectr := True;
          Missile1.FLimiterOut  := True;
          Missile1.FRigidityStt := True;
          Missile1.FFullOpen    := True;
          Missile1.FBoosterArm  := True;
          Missile1.FLaunchReady := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(4);
            case r of
//              0: Missile1.FAccurateCal := False;
//              1: Missile1.FInsideSectr := False;
              0: Missile1.FLimiterOut  := False;
              1: Missile1.FRigidityStt := False;
              2: Missile1.FFullOpen    := False;
              3: Missile1.FBoosterArm  := False;
            end;
            Missile1.FLaunchReady   := False;
          end;
        end;

      __STAT_C802_READYCONDITION_LAUNCHER2:
        begin
          Missile2.FAccurateCal := True;
          Missile2.FInsideSectr := True;
          Missile2.FLimiterOut  := True;
          Missile2.FRigidityStt := True;
          Missile2.FFullOpen    := True;
          Missile2.FBoosterArm  := True;
          Missile2.FLaunchReady := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(4);
            case r of
//              0: Missile2.FAccurateCal := False;
//              1: Missile2.FInsideSectr := False;
              0: Missile2.FLimiterOut  := False;
              1: Missile2.FRigidityStt := False;
              2: Missile2.FFullOpen    := False;
              3: Missile2.FBoosterArm  := False;
            end;
            Missile2.FLaunchReady   := False;
          end;
        end;

      __STAT_C802_READYCONDITION_LAUNCHER3:
        begin
          Missile3.FAccurateCal := True;
          Missile3.FInsideSectr := True;
          Missile3.FLimiterOut  := True;
          Missile3.FRigidityStt := True;
          Missile3.FFullOpen    := True;
          Missile3.FBoosterArm  := True;
          Missile3.FLaunchReady := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(4);
            case r of
//              0: Missile3.FAccurateCal := False;
//              1: Missile3.FInsideSectr := False;
              0: Missile3.FLimiterOut  := False;
              1: Missile3.FRigidityStt := False;
              2: Missile3.FFullOpen    := False;
              3: Missile3.FBoosterArm  := False;
            end;
            Missile3.FLaunchReady   := False;
          end;
        end;

      __STAT_C802_READYCONDITION_LAUNCHER4:
        begin
          Missile4.FAccurateCal := True;
          Missile4.FInsideSectr := True;
          Missile4.FLimiterOut  := True;
          Missile4.FRigidityStt := True;
          Missile4.FFullOpen    := True;
          Missile4.FBoosterArm  := True;
          Missile4.FLaunchReady := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(4);
            case r of
//              0: Missile4.FAccurateCal := False;
//              1: Missile4.FInsideSectr := False;
              0: Missile4.FLimiterOut  := False;
              1: Missile4.FRigidityStt := False;
              2: Missile4.FFullOpen    := False;
              3: Missile4.FBoosterArm  := False;
            end;
            Missile4.FLaunchReady   := False;
          end;
        end;

      __STAT_C802_LAUNCH_LAUNCHER1:
        begin
          Missile1.FLaunchButton := True;
          Missile1.FBatteryAct   := True;
          Missile1.FPowerSwitch  := True;
          Missile1.FGyroUncaged  := True;
          Missile1.FIgnition     := True;
          Missile1.FTakeOff      := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(6);
            case r of
              0: Missile1.FLaunchButton := False;
              1: Missile1.FBatteryAct   := False;
              2: Missile1.FPowerSwitch  := False;
              3: Missile1.FGyroUncaged  := False;
              4: Missile1.FIgnition     := False;
              5: Missile1.FTakeOff      := False;
            end;
          end;
        end;

      __STAT_C802_LAUNCH_LAUNCHER2:
        begin
          Missile2.FLaunchButton := True;
          Missile2.FBatteryAct   := True;
          Missile2.FPowerSwitch  := True;
          Missile2.FGyroUncaged  := True;
          Missile2.FIgnition     := True;
          Missile2.FTakeOff      := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(6);
            case r of
              0: Missile2.FLaunchButton := False;
              1: Missile2.FBatteryAct   := False;
              2: Missile2.FPowerSwitch  := False;
              3: Missile2.FGyroUncaged  := False;
              4: Missile2.FIgnition     := False;
              5: Missile2.FTakeOff      := False;
            end;
          end;
        end;

      __STAT_C802_LAUNCH_LAUNCHER3:
        begin
          Missile3.FLaunchButton := True;
          Missile3.FBatteryAct   := True;
          Missile3.FPowerSwitch  := True;
          Missile3.FGyroUncaged  := True;
          Missile3.FIgnition     := True;
          Missile3.FTakeOff      := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(6);
            case r of
              0: Missile3.FLaunchButton := False;
              1: Missile3.FBatteryAct   := False;
              2: Missile3.FPowerSwitch  := False;
              3: Missile3.FGyroUncaged  := False;
              4: Missile3.FIgnition     := False;
              5: Missile3.FTakeOff      := False;
            end;
          end;
        end;

      __STAT_C802_LAUNCH_LAUNCHER4:
        begin
          Missile4.FLaunchButton := True;
          Missile4.FBatteryAct   := True;
          Missile4.FPowerSwitch  := True;
          Missile4.FGyroUncaged  := True;
          Missile4.FIgnition     := True;
          Missile4.FTakeOff      := True;

          if aRec^.ParamError = __PARAM_C802_OFF then
          begin
            r := Random(6);
            case r of
              0: Missile4.FLaunchButton := False;
              1: Missile4.FBatteryAct   := False;
              2: Missile4.FPowerSwitch  := False;
              3: Missile4.FGyroUncaged  := False;
              4: Missile4.FIgnition     := False;
              5: Missile4.FTakeOff      := False;
            end;
          end;
        end;
    end;
  end;

end;

procedure TC802Manager.EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
var aRec: TRecMissilePos;
    arMissile : ^TRec3DMissilePos;
    tipe, status: string;
    tempUID  : string;
    ts        : LongWord;
    obj : TClientObject;
    shipID, weaponID, launcherID, missileID, missileNumber : integer ;
begin
  CopyMemory(@aRec, apRec, aSize);

  arMissile := @apRec^;

  shipID        := arMissile^.shipID ;
  WeaponID      := arMissile^.WeaponID ;
  launcherID    := arMissile^.launcherID;
  missileID     := arMissile^.missileID;
  missileNumber := arMissile^.MissileNumber;

  tempUID := dbID_to_MissileUniqueID(shipID, WeaponID, launcherID, missileID, missileNumber);

  case arMissile^.status of
    ST_MISSILE_RUN :
    begin

    end;

    ST_MISSILE_HIT :
    begin

    end;

    ST_MISSILE_DEL :
    begin
      case arMissile^.launcherID  of
        1 : PanelBawah.Launcher1OnFromInstruktur := False;
        2 : PanelBawah.Launcher2OnFromInstruktur := False;
        3 : PanelBawah.Launcher3OnFromInstruktur := False;
        4 : PanelBawah.Launcher4OnFromInstruktur := False;
      end;
    end;

    ST_MISSILE_LOADED :
    begin
      case arMissile^.launcherID  of
        1 : PanelBawah.Launcher1OnFromInstruktur := True;
        2 : PanelBawah.Launcher2OnFromInstruktur := True;
        3 : PanelBawah.Launcher3OnFromInstruktur := True;
        4 : PanelBawah.Launcher4OnFromInstruktur := True;
      end;
    end;
  end;

//  tmpNewObj := MainObjList.FindObjectByUid(tempUID);
//
//  if Assigned(tmpNewObj) then
//  begin
//    // UPDATE
//    if arMissile^.status = ST_MISSILE_RUN then
//    begin
//      obj := tmpNewObj as TClientObject;
//
//      obj.PositionX := arMissile^.x;
//      obj.PositionY := arMissile^.y;
//      obj.PositionZ := arMissile^.Z;
//      obj.Speed    := arMissile^.speed;
//      obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);
//    end
//    else if arMissile^.status = ST_MISSILE_DEL then
//    begin
//      tmpNewObj.MarkAs_NeedToBeFree;
//    end
//    else if arMissile^.status = ST_MISSILE_HIT then
//    begin
////        MainObjList.RemoveObject(tmpNewObj);
//    end;
//  end
//  else
//  begin
//    if arMissile^.status = ST_MISSILE_RUN then
//    begin
//      //CREATE NEW
//      obj := TClientObject.Create;
//      //obj.UniqueID := aRec.missileID;
//      obj.Enabled := TRUE;
//      obj.UniqueID := tempUID;  //--> set UniqID-nya spt temp. biar klo dicari ketemu
//      {tambahan Aldy}
//      obj.PositionX := arMissile^.x;
//      obj.PositionY := arMissile^.y;
//      obj.PositionZ := arMissile^.Z;
//      obj.Speed    := arMissile^.speed;
//      obj.Heading  := ConvCompass_To_Cartesian(arMissile^.heading);
//
//      MainObjList.AddObject(obj);
//    end;
//  end;
end;

procedure TC802Manager.EventOnReceiveAssignedobject(apRec: PAnsiChar; aSize: Integer);
var
  oRec : ^TRecObjectAssigned;
  I: Integer;
  sc : TClientObject;
begin
  oRec := @apRec^;

  if oRec^.ShipID <> UniqueID_To_dbID(xShip.UniqueID) then
    Exit;

  if oRec^.OrderID = __ORD_ID_C802 then
  begin
    for I := 0 to MainObjList.ItemCount - 1 do
    begin
      sc := MainObjList.getObject(I) as TClientObject;
      if oRec.ObjectAssign = UniqueID_To_dbID(sc.UniqueID) then
      begin
        if Assigned(PanelBawah.ListAssignedObjects[0]) then
          PanelBawah.ListAssignedObjects[1] := PanelBawah.ListAssignedObjects[0];

        PanelBawah.ListAssignedObjects[0] := sc;
      end;
    end;
  end;
end;

/// Kalkulasi Distance dan Course Prediction
/// <param name="obj">Object C802</param>
/// <param name="Distance"> result Distance</param>
/// <param name="Course"> result Course -> asumsi dari posisi ship </param>
procedure TC802Manager.CalcDistanceCoursePrediction(obj : TRec_Target; var Distance, Course : Double);
var
  posShip : tDouble2DPoint;
  pos1 : tDouble2DPoint;
  posTargetAwal : tDouble2DPoint;
  posTargetAkhir: tDouble2DPoint;
  t : Double;
  v : Double;
  d1 : Double;
  d2 : Double;
begin
  //set posisi kapal
  posShip.X := xShip.PositionX;
  posShip.Y := xShip.PositionY;

  posTargetAwal := CalcPositionAhead(posShip, obj.Distance, obj.Azimuth);

  {mencari posisi 1}
  v := 0.9 * 340; // kecepatan 0.8 - 0.9 ma -> 1 ma = 340 m/s;
  // hard code waktu awal 8 second
  d1 := v * 8;

  pos1 := CalcPositionAhead(posShip, d1, 30);
  {}
  {mencari distance 2 dan waktunya}
  d2 := CalcRange(pos1.X, pos1.Y, posTargetAwal.X, posTargetAwal.Y);

  t := d2 / v;

  t := t + 8; // waktu 2 ditambah waktu awal luncur

  {mencari d kapal ke posisi baru}
  d2 := obj.Speed * t;

  {mencari posisi akhir kapal}
  posTargetAkhir := CalcPositionAhead(posTargetAwal, d2, obj.Course);

  {dapatkan range dari ship}
  Distance := CalcRange(posShip.X, posShip.Y, posTargetAkhir.X, posTargetAkhir.Y);
  Course := CalcBearing(posShip.X, posShip.Y, posTargetAkhir.X, posTargetAkhir.Y);
end;

procedure TC802Manager.SetSceneOffSetFromID(const id: Integer; var x: Double; var y: Double);
var
  IDPORT : integer ;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ENV_PETA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    IDPORT := DQ.Fields[0].AsInteger ;
    DQ.Close;
    GetSceneOffSetFromPortID(IDPORT,x,y);
  end;
end;

function TC802Manager.GetHostandIPList(var aHostName: string; ss: TStrings): Boolean;
type
  TArrayPInAddr = array[0..10] of PInAddr;
  PArrayPInAddr = ^TArrayPInAddr;
var i: integer;
  pHe: PHostEnt;
  ptrPA: PArrayPInAddr;
  pBuffer : PAnsiChar;
  WSAData: TWSAData;
  ipAddr: string;

begin
  result := false;

  if WSAStartup($0002, WSAData) <> 0 then
    exit;

  GetMem(pBuffer, 64);

  GetHostName(pBuffer, 64);
  pHe := GetHostByName(pBuffer);

  if pHe = nil then
    exit;

  aHostName := string(pBuffer);
  ss.Clear;

  PtrPA := PArrayPInAddr(PHe^.h_addr_list);
  i := 0;
  while PtrPA^[i] <> nil do begin
    iPaddr := string(inet_ntoa(ptrPA^[i]^));
    ss.Add(ipAddr);
    inc(i);
  end;
  result := True;
  WSACleanup;
end;

procedure TC802Manager.GetSceneOffSetFromPortID(const id: integer; var x, y: double);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select XOFFSET,YOFFSET from env_port where ID=' + IntToStr(id));
    DQ.Open;
    x := DQ.FieldByName('XOFFSET').AsFloat;
    y := DQ.FieldByName('YOFFSET').AsFloat;
    DQ.Close;
  end;
end;

procedure TC802Manager.GetEnvPetaFromSceID(const id: integer;
  var aValue: integer);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ENV_PETA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    aValue := DQ.FieldByName('ENV_PETA').AsInteger;
    DQ.Close;
  end;
end;

procedure TC802Manager.EndSimulation;
begin
  MainThread.Suspend;
end;

procedure TC802Manager.CreateObject;
begin
  NetComm.setLog(TStringList(LogMemo));

  // Create Form ---------------------------------------------------

  // Show Form -----------------------------------------------------

end;

procedure TC802Manager.SendEvenC802(EvenId: Word; Prm1 , Prm2 , Prm3: double);
begin
  SendLogEvenConsole(TCPClient, pShipID, C_DBID_C802, EvenId, Prm1, Prm2, Prm3);  // Test send Log konsol
end;

procedure TC802Manager.SetLayOutForm;
var
  path : string;
  idxPanelAtas, alPanelAtas, xPanelAtas, yPanelAtas,
  idxPanelBawah, alPanelBawah, xPanelBawah, yPanelBawah,
  idxKeyboard, alKeyboard, xKeyboard, yKeyboard,
  bdrPanelAtas,  bdrPanelBawah,  bdrKeyboard,  bdrTemp: Integer;
begin

   path := ExtractFilePath(Application.ExeName) + 'SetFormC802ToMonitor.ini';

   Getsettingform(path, 'PANELATAS',  idxPanelAtas,  alPanelAtas,    xPanelAtas,   yPanelAtas);
   Getsettingform(path, 'PANELBAWAH', idxPanelBawah, alPanelBawah,   xPanelBawah,  yPanelBawah);
   Getsettingform(path, 'KEYBOARD',   idxKeyboard,   alKeyboard,     xKeyboard,    yKeyboard);
   Getsettingform(path, 'BORDER',     bdrPanelAtas,  bdrPanelBawah,  bdrKeyboard,  bdrTemp);


  case Screen.MonitorCount of
    1 :
      begin
        AlignFormToMonitor(0, apLeftTop, 0, 0, TForm(PanelAtas));
        AlignFormToMonitor(0, apLeftTop, 0, 0, TForm(PanelBawah));
        AlignFormToMonitor(0, apCenter, 0, 0, TForm(Keyboard_Form));

        PanelAtas.BorderStyle := TFormBorderStyle(bdrPanelAtas);
        PanelBawah.BorderStyle := TFormBorderStyle(bdrPanelBawah);
        Keyboard_Form.BorderStyle := TFormBorderStyle(bdrKeyboard);
      end;
    2 :
      begin
        AlignFormToMonitor(idxPanelAtas, apLeftTop, 0, 0, TForm(PanelAtas));
        AlignFormToMonitor(idxPanelBawah, apLeftTop, 0, 0, TForm(PanelBawah));
        AlignFormToMonitor(idxPanelBawah, apLeftTop, 0, 0, TForm(Keyboard_Form));

        PanelAtas.BorderStyle := TFormBorderStyle(bdrPanelAtas);
        PanelBawah.BorderStyle := TFormBorderStyle(bdrPanelBawah);
        Keyboard_Form.BorderStyle := TFormBorderStyle(bdrKeyboard);

      end;
    3 :
      begin
        AlignFormToMonitor(idxPanelAtas, TAlignPos(alPanelAtas), 0, 0, TForm(PanelAtas));
        AlignFormToMonitor(idxPanelBawah, TAlignPos(alPanelBawah), 0, 0, TForm(PanelBawah));
        AlignFormToMonitor(idxKeyboard, TAlignPos(alKeyboard), 0, 0, TForm(Keyboard_Form));

        PanelAtas.BorderStyle := TFormBorderStyle(bdrPanelAtas);
        PanelBawah.BorderStyle := TFormBorderStyle(bdrPanelBawah);
        Keyboard_Form.BorderStyle := TFormBorderStyle(bdrKeyboard);
      end;

  end;

  PanelBawah.Show;
  PanelBawah.WindowState := wsMaximized;
  PanelAtas.Show;
  PanelAtas.WindowState := wsMaximized;
  Keyboard_Form.Show;
end;

procedure TC802Manager.Initialize;
var
  i, n : integer ;
  str, fname : string ;
  EventForm: TEventForm;

  aHost : string;
  aIPList : TStrings;
  found : Boolean;
begin
  found := false;
  n := ParamCount ;
  if n = max_param then
  begin
     StandAloneMode := false ;
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
      pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );


    if pDBServer = 'localhost' then
     found := True
    else
    begin
      aIPList := TStringList.Create;
      GetHostandIPList(aHost,aIPList);

      for I := 0 to aIPList.Count - 1 do
      begin
        if pDBServer = aIPList.Strings[i] then
        begin
          found := True;
          Break;
        end
      end;
    end;

    if found then
    begin
      PanelBawah.Launcher1OnFromInstruktur := True;
      PanelBawah.Launcher2OnFromInstruktur := True;
      PanelBawah.Launcher3OnFromInstruktur := True;
      PanelBawah.Launcher4OnFromInstruktur := True;
    end;

  end
  else
  begin
    StandAloneMode := True;
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
      pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );

    PanelBawah.Launcher1OnFromInstruktur := True;    // dibuat true karena tidak didapatkan dari instruktur
    PanelBawah.Launcher2OnFromInstruktur := True;
    PanelBawah.Launcher3OnFromInstruktur := True;
    PanelBawah.Launcher4OnFromInstruktur := True;
  end;

  FMap := PanelBawah.MapC802;
  //set data_path
  data_Path           := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

  fname := data_Path + 'data\Scenario\TDCC802.ini';
  LoadScenarioFromIniFile(fname);

  xShip.UniqueID := dbID_to_UniqueID(ShipID);

  EventForm.zoomMap;

  SetLayOutForm;
end;

procedure TC802Manager.Net_Connect;
begin
  NetComm.Connect(pServer_Ip, pServer_Port);
  if NetComm.State = wsConnected then
    ShouldConnect := true;
end;

procedure TC802Manager.Net_Disconnect;
begin
  ShouldConnect := false;
  NetComm.Disconnect;
end;

procedure TC802Manager.ReceiveCommand(aKey_C802: TRecCMD_C802);
var
 capt : string;
begin
  case aKey_C802.cmd of
    CMD_C802_Combat:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_COMBAT;
          EnterButton;
          SendEvenC802(5,0,0,0);
        end;
      end;
    CMD_C802_Simulate:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_SIMULATE;
          CreateSimulationObject;
          EnterButton;
          SendEvenC802(6,0,0,0);
        end;
      end;
    CMD_C802_Check:
      with PanelBawah do begin
        if ActivePage = PAGE_START then
        begin
          StartMode_index := SM_CHECK;
          EnterButton;
          SendEvenC802(7,0,0,0);
        end;
      end;
    CMD_C802_LogOff:
      with PanelBawah do begin
        if ActivePage = PAGE_START then Exit;
        PgCtrlMainMenu.Pages[4].Show;
        ActivePage := PAGE_LOGOFF;
      end;
    CMD_C802_Status:
      with PanelBawah do begin
        if ActivePage = PAGE_START then Exit;
        PgCtrlMainMenu.Pages[0].Show;
        ActivePage := PAGE_STATUS;
      end;
    CMD_C802_MControl:
      with PanelBawah do begin
        if ActivePage = PAGE_START then Exit;
        PgCtrlMainMenu.Pages[1].Show;
        ActivePage := PAGE_MCONTROL;
        PanelEditOn(pnlPrecheck_MControl);
      end;
    CMD_C802_ParSetting:
      with PanelBawah do begin
        if ActivePage = PAGE_START then Exit;
        PgCtrlMainMenu.Pages[2].Show;
        ActivePage := PAGE_PARSETTING;
      end;
    CMD_C802_RecordData:
      with PanelBawah do begin
        if ActivePage = PAGE_START then Exit;
        PgCtrlMainMenu.Pages[3].Show;
        ActivePage := PAGE_RECORDDATA;
        PanelEditOn(pnlRecordData_No);
      end;

    CMD_C802_Tab:
      with PanelBawah do begin
        case ActivePage of
          PAGE_PARSETTING_ATTACK:
            begin
              if Length(ActivePanel.Caption) = 0 then
                ActivePanel.Caption := '1'
              else begin
                case StrToInt(ActivePanel.Caption) of
                  1: ActivePanel.Caption := '2';
                  2: ActivePanel.Caption := '3';
                  3: ActivePanel.Caption := '1';
                end;
              end;
            end;
        end;

      end;
    CMD_C802_Esc:
      with PanelBawah do begin
        case ActivePage of
          PAGE_MCONTROL..PAGE_LOGOFF:
            begin
              if Assigned(ActivePanel) then
              PanelEditOff(ActivePanel);

              PgCtrlMainMenu.Pages[0].Show;
            end;
          PAGE_PARSETTING_FIREPWR..PAGE_PARSETTING_QUEST:
            begin
              PanelEditOff(ActivePanel);
              ActivePage := PAGE_PARSETTING;
            end;
          PAGE_CHECK:
            begin
              grpCheckPage.Visible := False;
              grpStartPage.Visible := True;
              grpStartPage.BringToFront;
              ActivePage := PAGE_START;

              PanelUp(StartMode_array[0]);
              PanelUp(StartMode_array[1]);
              PanelUp(StartMode_array[2]);
              PanelDown(StartMode_array[StartMode_index]);
            end;
        end;
      end;
    CMD_C802_BackSpace:
      with PanelBawah do begin
        capt := ActivePanel.Caption;
        Delete(capt,Length(capt),1);
        ActivePanel.Caption  := capt;
      end;
    CMD_C802_Enter:
      begin
        PanelBawah.EnterButton;
      end;
    CMD_C802_OnOff:
      begin

      end;
    CMD_C802_Up:
      begin
       PanelBawah.UpButton;
      end;
    CMD_C802_Down:
      begin
       PanelBawah.DownButton;
      end;
    CMD_C802_Left:
      begin

      end;
    CMD_C802_Right:
      begin

      end;
    CMD_C802_Dash:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlTargetSet_1_Number) and (ActivePanel <> pnlTargetSet_1_Distance) and
           (ActivePanel <> pnlTargetSet_1_Speed) and (ActivePanel <> pnlTargetSet_1_Azimuth) and
           (ActivePanel <> pnlTargetSet_1_Course) and (ActivePanel <> pnlTargetSet_2_Number) and
           (ActivePanel <> pnlGPS_para_OwnSpd) and (ActivePanel <> pnlMete_para_WindSpd) and
           (ActivePanel <> pnlMete_para_WindDir) and (ActivePanel <> pnlGyro_para_OwnHdg) and
           (ActivePanel <> pnlQuestion_No) and (ActivePanel <> pnlRecordData_No)
        then
        begin
          capt := ActivePanel.Caption;
          if (StrScan(PChar(capt), '-') = nil) and (Length(capt) = 0) then
            InputNumber('-');
        end;
      end;
    CMD_C802_Dot:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlTargetSet_1_Number) and (ActivePanel <> pnlTargetSet_1_Course) and
           (ActivePanel <> pnlTargetSet_2_Number) and (ActivePanel <> pnlQuestion_No) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          capt := ActivePanel.Caption;
          if StrScan(PChar(capt), '.') = nil then
            InputNumber('.');
        end;
      end;

    CMD_C802_1:
      with PanelBawah do begin
        PanelBawah.InputNumber('1');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '1';
      end;
    CMD_C802_2:
      with PanelBawah do begin
        PanelBawah.InputNumber('2');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '2';
      end;
    CMD_C802_3:
      with PanelBawah do begin
        PanelBawah.InputNumber('3');

        if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
           (ActivePanel = pnlAttack_Mode_Tgt1)  or (ActivePanel = pnlAttack_Mode_Tgt2) or
           (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
           (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
        then
          ActivePanel.Caption := '3';
      end;
    CMD_C802_4:
      with PanelBawah do begin
        if (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) then
        begin
          InputNumber('4');

          if (ActivePanel = pnlPrecheck_MControl) or (ActivePanel = pnlRecheck_MControl) or (ActivePanel = pnlPowerOff_MControl) or
             (ActivePanel = pnlFirePwr_Dist_Target1) or (ActivePanel = pnlFirePwr_Dist_Target2) or
             (ActivePanel = pnlQuestion_No) or (ActivePanel = pnlRecordData_No)
          then
            ActivePanel.Caption := '4';
        end;
      end;
    CMD_C802_5:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('5');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '5';
        end;
      end;
    CMD_C802_6:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('6');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '6';
        end;
      end;
    CMD_C802_7:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('7');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '7';
        end;
      end;
    CMD_C802_8:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('8');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '8';
        end;
      end;
    CMD_C802_9:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('9');

          if (ActivePanel = pnlQuestion_No) then
            ActivePanel.Caption := '9';
        end;
      end;
    CMD_C802_0:
      with PanelBawah do begin
        if (ActivePanel <> pnlPrecheck_MControl) and (ActivePanel <> pnlRecheck_MControl) and
           (ActivePanel <> pnlPowerOff_MControl) and
           (ActivePanel <> pnlAttack_Mode_Tgt1) and (ActivePanel <> pnlAttack_Mode_Tgt2) and
           (ActivePanel <> pnlFirePwr_Dist_Target1) and (ActivePanel <> pnlFirePwr_Dist_Target2) and
           (ActivePanel <> pnlQuestion_No) and (ActivePanel <> pnlRecordData_No)
        then
        begin
          InputNumber('0');
        end;
      end;
  end;
end;

procedure TC802Manager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

function TC802Manager.LoadScenarioFromIniFile(const fIni: string): integer;
var
  IniF : TIniFile;
  readStr : string;
  readInt, n, envPeta : integer;
  fName : string;

  pCurrentScenID : integer;
  pServer_Ip,pServer_Port, //TriD_IP, TriD_Port,
  pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
  pShipName, pClassName : string;
  pShipID, pClassID : Integer;
  enviID : Integer;
  scenRec : TScenario;
begin // di sini CreateForm dan Load Map
  // sebaiknya diubah, load setting aja simpan ke variabel GameSetting,
  // setelah semua di load baru di execute.
    if FIni = '' then
      FName := Copy(ExtractFilePath(Application.ExeName),1,Length(ExtractFilePath(Application.ExeName))-4) + 'data\Scenario\TDCC802.ini'
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

    if not StandAloneMode then
    begin

      InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
          pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );

      //. multiplayer section . . . .
      ServerIp  := pServer_Ip;     // Inif.ReadString(C_mult_sect, C_servip_id, '127.0.0.1');
      ServerPort:= pServer_Port;   //Inif.ReadString(C_mult_sect, C_servport_id, '2120'

      //. this ship section . . . .

      readStr := Inif.ReadString(C_Ship_section, 'thisshipid', 'VSL0020');
      ShipID := pShipID;  //UniqueID_To_dbID(readStr);

      readInt := Inif.ReadInteger(C_game_sect, 'dbconnect', 0);

      if ( ShipID <> -1)then
      begin
        DataModule1.EmuConn.HostName := pDBServer;
        DataModule1.EmuConn.User := pDBUser;
        DataModule1.EmuConn.Database := pDBName;
        DataModule1.EmuConn.Password := pDBPass;
        DataModule1.EmuConn.Connect;

        //get offset by scenario;
        GetEnvPetaFromSceID(pCurrentScenID, envPeta);

        GetSceneOffSetFromPortID(envPeta, mapOffsetX, mapOffsetY);

        ShipName    := DataModule1.GetShipName(ShipId);
        ShipClassID := DataModule1.GetShipType(ShipId, ShipClassName);

        AddToMemoLog(' ShipID      = ' + IntToStr(ShipID) );
        AddToMemoLog(' ShipClassId = ' + IntToStr(ShipClassID) );

        AddToMemoLog(' ShipName ' + ShipName );
        AddToMemoLog(' ShipClassName ' + ShipClassName );
      end;
    end;

    //load map
    readStr := IniF.ReadString(C_Map_Section, C_gst_ident, '');
    //showmessage(readStr);
    if (readStr <> '') and FileExists(readStr) then begin
      AddToMemoLog('Opening geoset '+ readStr);
      LoadGeoset(readStr);
    end
    else begin
      dec(result);
      AddToMemoLog('Error: Geoset "' +readStr+ '" is not Exist');
      exit;
    end;

    readStr := IniF.ReadString(C_Map_Section, C_grd_ident, '');
    if (readStr <> '') and FileExists(readStr) then begin
      AddToMemoLog('Opening 3D map '+ readStr);
      ///LoadGrid(readStr);
    end
    else begin
      dec(result);
      AddToMemoLog('Error: 3D Map "' + readStr + '" is not Exist');
      exit;
    end;

    IniF.Free;
end;

end.
