unit uMainRdrSim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Menus, ComCtrls, XPMan;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pnlPlay: TPanel;
    pnlPause: TPanel;
    spbPlay: TSpeedButton;
    spbStop: TSpeedButton;
    spbPause: TSpeedButton;
    spbResume: TSpeedButton;
    shpPlayingStatus: TShape;
    rgSimSpeed: TRadioGroup;
    tmrStatus: TTimer;
    pnlSimCtrl: TPanel;
    pcMainMenu: TPageControl;
    tsInitialize: TTabSheet;
    tsSimulation: TTabSheet;
    tsMultiplayer: TTabSheet;
    rgMultiplayOption: TRadioGroup;
    Memo1: TMemo;
    Panel3: TPanel;
    pnlInit: TPanel;
    tsInfo: TTabSheet;
    pnlMultiplayer: TPanel;
    spbMultiPlayNext: TSpeedButton;
    spbInitSelectScene: TSpeedButton;
    spbInit: TSpeedButton;
    spbInitSceneNext: TSpeedButton;
    Memo2: TMemo;
    spbInitSceneBack: TSpeedButton;
    ScrollBar1: TScrollBar;
    Label3: TLabel;
    Label4: TLabel;
    spbSimRestart: TSpeedButton;
    Panel2: TPanel;
    XPManifest1: TXPManifest;
    tsLog: TTabSheet;
    RichEdit1: TRichEdit;
    TabSheet1: TTabSheet;
    Button1: TButton;
    btnRemove: TButton;
    btnAdd: TButton;
    Edit1: TEdit;
    lbx: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label5: TLabel;
    lblGamePlay: TLabel;
    procedure rgMultiplayOptionClick(Sender: TObject);
    procedure spbMultiPlayNextClick(Sender: TObject);

    procedure spbInitSceneNextClick(Sender: TObject);

    procedure spbPlayClick(Sender: TObject);
    procedure spbStopClick(Sender: TObject);
    procedure spbPauseClick(Sender: TObject);
    procedure spbResumeClick(Sender: TObject);
    procedure tmrStatusTimer(Sender: TObject);
    procedure spbSimRestartClick(Sender: TObject);
    procedure rgSimSpeedClick(Sender: TObject);
    procedure spbInitSelectSceneClick(Sender: TObject);
    procedure spbInitClick(Sender: TObject);
    procedure spbInitSceneBackClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

 //    simCenter EventHandler
    procedure ToteOnUpdateForm(Sender: TObject);
  public
    { Public declarations }
    SimulationIsRunning : boolean;

    procedure InitializeSimulation;
    procedure FinalizeSimulation;

  end;

var
  frmMain: TfrmMain;

implementation

uses
  uMapWindow, uSimulationManager, uAircraftClass, MapXLib_TLB;

{$R *.dfm}
//------------------------------------------------------------------------------

procedure TfrmMain.InitializeSimulation;
begin
  // collect Information about scenario.
  //
  frmMapWindow.LoadMap('Z:\GEOSET\INDONESIA.GST');

  uSimulationManager.BeginSimulation;     // just create sim center.

  uSimulationManager.SimCenter.FMap := frmMapWindow.Map;

  uSimulationManager.SimCenter.OnFormNeedUpdate := ToteOnUpdateForm;

  uSimulationManager.SimCenter.InitializeSimulation ;

  frmMapWindow.Show;

  uSimulationManager.SimCenter.AddAircraftAndView;

  //enabled some button
end;

procedure TfrmMain.FinalizeSimulation;
begin

//  uSimulationManager.SimCenter.RemoveAircraftAndView('ACuid');
  uSimulationManager.SimCenter.FinalizeSimulation;

  uSimulationManager.EndSimulation;  //Free sim Center

  //disable some button

end;


/////////= FORM EVENT HANDLER  =/////////////////////////////////////////////////

//-- tsMultiplayer ---
procedure TfrmMain.rgMultiplayOptionClick(Sender: TObject);
begin
//
end;

procedure TfrmMain.spbMultiPlayNextClick(Sender: TObject);
begin
  //
end;

//-- tsInit
procedure TfrmMain.spbInitSelectSceneClick(Sender: TObject);
begin
  //select Scenario
end;

procedure TfrmMain.spbInitClick(Sender: TObject);
begin
  //reserve
end;

procedure TfrmMain.spbInitSceneBackClick(Sender: TObject);
begin
  // cancel, back to multiplayer setting
end;

procedure TfrmMain.spbInitSceneNextClick(Sender: TObject);
begin
  InitializeSimulation;
  tsInitialize.Enabled := FALSE;
  pnlSimCtrl.Enabled := TRUE;

  pcMainMenu.ActivePage := tsSimulation;
end;

// -- tsSimulation --
procedure TfrmMain.spbPlayClick(Sender: TObject);
begin
  shpPlayingStatus.Brush.Color := clLime;
  pnlPause.Enabled := TRUE;

  uSimulationManager.SimCenter.StartSimulation;
end;

procedure TfrmMain.spbStopClick(Sender: TObject);
begin
  shpPlayingStatus.Brush.Color := clGreen;
  pnlPause.Enabled := FALSE;

  uSimulationManager.SimCenter.EndSimulation;
end;

procedure TfrmMain.spbPauseClick(Sender: TObject);
begin
  tmrStatus.Enabled := TRUE;

end;

procedure TfrmMain.spbResumeClick(Sender: TObject);
begin
  tmrStatus.Enabled := FALSE;
end;

procedure TfrmMain.tmrStatusTimer(Sender: TObject);
begin
// timer khusus untuk tampilan. bukan untuk process!
// jangan gunakan timer ini untuk akses ke object.

end;

procedure TfrmMain.spbSimRestartClick(Sender: TObject);
begin
  FinalizeSimulation;
  pcMainMenu.ActivePage := tsInitialize;
  tsInitialize.Enabled  := TRUE;
  pnlSimCtrl.Enabled    := FALSE;
end;

procedure TfrmMain.rgSimSpeedClick(Sender: TObject);
var spd : word;
begin
  spd := StrToInt(rgSimSpeed.Items[rgSimSpeed.ItemIndex]);
  uSimulationManager.SimCenter.SpeedMultiplier := spd;
end;

procedure TfrmMain.ToteOnUpdateForm(Sender: TObject);
var t : TDateTime;
    l : TList;
    i : integer;
    ac: TAircraftClass;
    strTime: string;
begin

  t := uSimulationManager.SimCenter.MainGameTimer.GetTime;
  strTime :=  FormatDateTime('hh:nn:ss', t);
  lblGamePlay.Caption := strTime;

  if RichEdit1.Lines.Count > 100 then
  for i := 0 to 30 do
    RichEdit1.Lines.Delete(1);

  RichEdit1.Lines.Add(strTime);
  lbx.Items.Clear;

  l := uSimulationManager.SimCenter.MainObjList.getList;

  for i := 0 to l.Count-1 do begin
    ac := l.items[i];
    lbx.Items.add(ac.UniqueID);
  end;

  uSimulationManager.SimCenter.MainObjList.ReturnList;

end;


procedure TfrmMain.Button1Click(Sender: TObject);
begin
  frmMapWindow.Show;
end;

procedure TfrmMain.btnRemoveClick(Sender: TObject);
var i: integer;
begin
  for i := 0 to 50 do
    uSimulationManager.SimCenter.RemoveAircraftAndView(InttoStr(i));

end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var i: integer;
begin
  for i := 0 to 50 do
    uSimulationManager.SimCenter.AddAircraftAndView.UniqueID := InttoStr(i);

end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  frmMapWindow.Map.CurrentTool := miArrowTool;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  frmMapWindow.Map.CurrentTool := miZoomInTool;

end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  frmMapWindow.Map.CurrentTool := miZoomOutTool;

end;

end.
