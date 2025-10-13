unit uSimulationManager;
(*
  Created       : 30 Mei 2005
  Last Modified : 13 Sept 2007

  Author        : Andy Sucipto
  description   : 'abstract' simulation manager.

  contain much virtual function.

  tested child


*)

interface

  uses
    Classes, Graphics,
    Variants, MapXLib_TLB,

//------------------------------------------------------------------------------
    MSThreadTimer,
    uVirtualTime,
    uBaseDataType,
    uBaseSimulationObject,
//------------------------------------------------------------------------------
    uTCPClient,
    uTCPDatatype;

  type

    TPlayingStatus = (playStatusStop, playStatusRun, playStatusPause);
    TPlayMode = (pmStandAlone, pmModeClient);
    TGamePlayType  = (gpmScenario, gpmScenAndRecord, gpmReplay);

    TSimulationManager = class
    private
      function IsRunning: boolean;
      procedure setRunStatus(const Value: boolean);

    protected
      {Overclocking Technology: }
      FSpeedMultiplier   : Word;
      FGameDelayInterval : Word;

      {Some 'low priority' task..  }
      FRunQIL        : tInterleave;
      FRepaintIL     : tInterleave;
      FFormUpdateIL  : tInterleave;

      FOnFormNeedUpdate: TNotifyEvent;
      FPlayStatus  : TPlayingStatus;
      FLyrDraw: CMapXLayer;

      FUniqueIdFactory : integer;
      rr : CMapXRectangle;

    //--------------------------------------------------------------------------
    //-- Simulation C O R E Procedure

      procedure UpdateMember;                       virtual;
      procedure MoveMember(const aDt: double);      virtual;
      procedure DrawMember;                         virtual; // trigger

      procedure ShowMemberData;                     virtual;

    //--------------------------------------------------------------------------
    //-- Garbage Collector

      procedure CleanUpMember;                      virtual;

    //--------------------------------------------------------------------------
    //-- Event Hanlder
      procedure EventOnMainTimer(const dt: double); virtual;

    public
    //-- 'Global variable' -----------------------------------------------------
      FMap : TMap; //pointer to MapX component on MapWindow;
      Data_dir : string;

      MainThread      : TMSTimer;
      MainGameTimer   : TVirtualTime;

      MainObjList     : TObjectContainer;   // container semua object
      MainViewList    : TViewContainer;     // object View;

    //--------------------------------------------------------------------------
      NetComm,
      TCPClient   : TTCPClient;
      LogMemo   : TStrings;
      ServerIp  : string;
      ServerPort: string;

      GamePlayMode: TPlayMode;
      ShouldConnect : boolean;

    //--------------------------------------------------------------------------
     tmpNewObj  : TSimulationClass;
     tmpNewView : TSimulationView;
     tmpActiveClickMap : integer ;

    //-- Simulation Initialization and Finalization
      constructor Create; virtual;
      destructor Destroy; override;

      procedure InitializeSimulation;     virtual; //Create objects
      procedure FinalizeSimulation;       virtual;

      procedure DrawAllOnMapXCanvas(aCnv: TCanvas); virtual;  // action

      procedure LoadScenario;   virtual; abstract;
      procedure UnLoadScenario; virtual; abstract;

      function LoadScenarioFromIniFile(const fIni: string): integer; virtual;
    //--------------------------------------------------------------------------
    //-- Simulation Control

      procedure StartSimulation;                    //                  virtual;
      procedure EndSimulation;                      //                  virtual;
      procedure PauseSimulation;                    //                  virtual;
      procedure ResumeSimulation;                   //                  virtual;

    //--------------------------------------------------------------------------
    //-- MapX  Wrapper
      procedure LoadGeoset(const aGst: string); virtual;

      function Get3DMapHeight(const xLong, yLatt: double;
         var aValue: double; var aType: string): boolean;

      procedure SetMapVisible(const v: boolean);

      function GenerateUniqueID: string;
      procedure AddToMemoLog(const str: string; const space: byte=2);

    //--------------------------------------------------------------------------
    //-- Net  Control
      procedure Net_Connect;    virtual;
      procedure Net_DisConnect;


    public
      property SpeedMultiplier: Word read FSpeedMultiplier write FSpeedMultiplier;

      property OnFormNeedUpdate: TNotifyEvent
        read FOnFormNeedUpdate write FOnFormNeedUpdate;

      property Running: boolean read IsRunning write setRunStatus;

    end;

  //==============================================================================
  var
     SimCenter  : TSimulationManager;

implementation
  uses
    uBaseConstan, uBaseFunction, Windows, SysUtils, StrUtils, IniFiles, Forms, overbyteicsWSocket,
  Dialogs;

//= unit Procedure =============================================================
  constructor TSimulationManager.Create;
  begin
    inherited;
    Data_dir := copy(ExtractFilePath(Application.ExeName),1,Length(ExtractFilePath(Application.ExeName))-4) + 'data\';


    FSpeedMultiplier    := 1;
    FGameDelayInterval  := 10;

    FRunQIL.Counter    := 0;
    FRunQIL.Cycle      := 3;

    FRepaintIL.Counter  := 1; //1
    FRepaintIL.Cycle    := 3; //3

    FFormUpdateIL.Counter := 4;
    FFormUpdateIL.Cycle   := 40;

    MainThread            := TMSTimer.Create;
    MainThread.Interval   := FGameDelayInterval;
    MainThread.OnRunning  := EventOnMainTimer;
    MainThread.Priority   := tpHighest;

    MainGameTimer := TVirtualTime.Create;
    //    MainGameTimer.DateTimeOffset :=

    MainObjList   := TObjectContainer.Create;
    MainViewList  := TViewContainer.Create;

    FUniqueIdFactory := random(10);

    GamePlayMode := pmStandAlone;
    ShouldConnect := false;

    NetComm      := TTCPClient.Create;
    TCPClient  := NetComm;
    rr := CoRectangle.Create;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TSimulationManager.Destroy;
  begin
    NetComm.Free;

    MainThread.OnTimer    := nil;
    MainThread.Terminate;

    MainViewList.Free;
    MainViewList := nil;

    MainObjList.Free;
    MainObjList := nil;

    MainGameTimer.Free;
    MainGameTimer := nil;

    inherited;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.InitializeSimulation;
  var Err : Cardinal;
  begin
{    Err := vmInit('WindowsLatin1',0);
    if Err<>0 then begin
      //raise Exception.Create('Init VerticalMapper error');
      AddToMemoLog('Error: Init VerticalMapper');
      VMInited := false;
    end;


}

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.FinalizeSimulation;
  begin
    Running := FALSE;

//    vmTerm();
  end;

//------------------------------------------------------------------------------
//-- Simulation Control

  procedure TSimulationManager.StartSimulation;
  begin
    MainThread.Resume;

  end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.EndSimulation;
  begin
    MainThread.Suspend;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.PauseSimulation;
  begin
    MainThread.Suspend;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.ResumeSimulation;
  begin
    MainThread.Resume;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  function TSimulationManager.IsRunning: boolean;
  begin
    result := MainThread.Enabled;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.setRunStatus(const Value: boolean);
  begin
    MainThread.Enabled := Value;

  end;

  //------------------------------------------------------------------------------
  //-- Simulation C O R E Procedure
  procedure TSimulationManager.UpdateMember;
  begin
    MainObjList.UpdateAllMemberObject;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.MoveMember(const aDt: double);
  begin
    MainObjList.RunAllMemberObject(aDt);

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.DrawMember;
  var r : TRect;

     z : OleVariant;
  begin
    MainViewList.ConvertAllDataPosition();
//    rr.Set_(0,0, FMap.Width-1, FMap.Height-1);
    rr.Set_(0,0, FMap.Width-1, FMap.Height -1);
    FLyrDraw.Invalidate(rr);
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.DrawAllOnMapXCanvas(aCnv: TCanvas);
  begin
    MainViewList.DrawAllView(aCnv);

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationManager.ShowMemberData;
  begin
     if Assigned(FOnFormNeedUpdate) then FOnFormNeedUpdate(self);

  end;

  //------------------------------------------------------------------------------
  //-- Garbage Collector
  procedure TSimulationManager.CleanUpMember;
  begin
     MainObjList.CleanUpObject;
     MainViewList.CleanUpObject;

  end;

//------------------------------------------------------------------------------
//-- Event Handler;
//-- bagian Looping paling penting dari simulasi.
  procedure TSimulationManager.EventOnMainTimer(const dt: double);
  begin
     { Main Simulation Looping.
       ini di isi di class turunannya.
     }

  end;

  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  //-- Event Handler -----------------------------------------------------------

  procedure TSimulationManager.LoadGeoset(const aGst: string);
  var i: integer;
    z: OleVariant;
    mInfo : CMapXLayerInfo;
  begin
    if Not FileExists(aGst) then
      MessageDlg('Geoset not found! '+ aGst, mtWarning, [mbOK], 0);

    InitOleVariant(z);
    FMap.Layers.RemoveAll;
    FMap.Geoset := aGst;

    if aGst <> '' then begin
      mInfo := CoLayerInfo.Create;
      mInfo.type_ := miLayerInfoTypeUserDraw ;
      mInfo.AddParameter('Name', 'Animation');
      FLyrDraw := FMap.Layers.Add(mInfo, 1);

      FMap.Layers.AnimationLayer := FLyrDraw;
      FMap.MapUnit := miUnitNauticalMile;
//      FMap.BackColor :=  RGB(64, 64, 64) // RGB(32, 64, 16);
    end


  end;

  function TSimulationManager.Get3DMapHeight(const xLong, yLatt: double;
           var aValue: double; var aType: string): boolean;
  var vRT : ^LongInt;
      vGV : ^double;
      zVal: ^PChar;
  begin
    result := false;
 end;

  procedure TSimulationManager.SetMapVisible(const v: boolean);
  var i: integer;
  begin // set semua layer (kecuali animation  layer)
      for i := 1 to FMap.Layers.Count do begin
       // FMap.Layers.Item(i).Selectable := false;
      //  FMap.Layers.Item(i).LabelProperties.Style.TextFontColor := clYellow;
//        FMap.Layers.Item(i).Visible := FALSE;
      end;

  end;

  function TSimulationManager.GenerateUniqueID: string;
  begin
    Result := IntToStr(FUniqueIdFactory);
    Inc(FUniqueIdFactory);
  end;

  procedure TSimulationManager.AddToMemoLog(const str: string; const space: byte=2);
  var s: string;
  begin
    if Assigned(LogMemo) then begin
      SetLength(s, space);
      FillChar(s[1], space, ' ' );
      LogMemo.Add( s + str);
    end;
  end;

  function TSimulationManager.LoadScenarioFromIniFile(const fIni: string): integer;
  var IniF:TIniFile;
      readStr : string;
      readInt : integer;
      fName : string;
  begin
    result := 0;
    if FIni = '' then
      fName := Data_dir
 //     fName := ExtractFilePath(Application.ExeName) + 'Scenario\DefScene.ini'
    else
      fName := FIni;

    if FileExists(fName) then
      AddToMemoLog('Opening scenario '+ fName)
    else begin
      AddToMemoLog('Error: Scenario "' +fName+ '" is not Exist');
      exit;
    end;

    IniF   := TIniFile.Create(FName);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    // . map section  . . . . . . . . .
    result := 0;
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

    IniF.Free;

  end;
procedure TSimulationManager.Net_Connect;
begin
  NetComm.Connect(ServerIp,  ServerPort);
  if NetComm.State = wsConnected then 
    ShouldConnect := true;
end;

procedure TSimulationManager.Net_DisConnect;
begin
  ShouldConnect := false;
  NetComm.Disconnect;
end;

end.
