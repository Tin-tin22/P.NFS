unit uReplayControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, AdvSmoothButton;

type
  TfrmReplayControl = class(TForm)
    pnlReplay: TGroupBox;
    rgReplayGameSpeed: TRadioGroup;
    btnStartReplay: TAdvSmoothButton;
    btnStopReplay: TAdvSmoothButton;
    btnPause: TAdvSmoothButton;
    btnResume: TAdvSmoothButton;
    procedure btnStartReplayClick(Sender: TObject);
    procedure btnStopReplayClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResumeClick(Sender: TObject);
    procedure rgReplayGameSpeedClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure StaticText1Click(Sender: TObject);
  private
  public
    procedure UpdateControl ( isRun : boolean );
  end;

var
  frmReplayControl: TfrmReplayControl;

implementation

uses Math, uInstrukturManager, uSimulationManager;

{$R *.dfm}

procedure TfrmReplayControl.UpdateControl ( isRun : boolean );
begin
   btnStartReplay.Enabled := not isRun ;
   btnStopReplay.Enabled  := isRun ;
   if isRun then
   begin
      if btnResume.Enabled then
         btnPause.Enabled       := true
      else
         btnPause.Enabled       := false;
       btnResume.Enabled        := btnPause.Enabled = false;
   end
   else
   begin
      btnPause.Enabled := false;
      btnResume.Enabled := false;
   end;
end;

procedure TfrmReplayControl.btnStartReplayClick(Sender: TObject);
begin
   SimManager.fGamePlayType := gpmReplay;
   SimManager.Replay_Start;
   btnResume.Enabled := true;
   UpdateControl(true);
   
   //send start
   SimManager.NetSend_ReplayControl(2, '', 1, 0);
end;

procedure TfrmReplayControl.btnStopReplayClick(Sender: TObject);
begin
   SimManager.Replay_Stop;
   UpdateControl(false);
   SimManager.fGamePlayType := gpmScenario;
   SimManager.ClearAllObjects;
   SimCenter.StartSimulation;

   //send stop
   SimManager.NetSend_ReplayControl(2, '', 2, 0);
end;

procedure TfrmReplayControl.btnPauseClick(Sender: TObject);
begin
   SimManager.Replay_Pause;
   UpdateControl(true);

   //send pause
   SimManager.NetSend_ReplayControl(2, '', 3, 0);
end;

procedure TfrmReplayControl.btnResumeClick(Sender: TObject);
begin
   SimManager.Replay_Resume;
   UpdateControl(true);

   //send resume
   SimManager.NetSend_ReplayControl(2, '', 4, 0);
end;

procedure TfrmReplayControl.rgReplayGameSpeedClick(Sender: TObject);
var pw: integer;
    gs : integer;
begin
    pw := (sender as TRadioGroup).ItemIndex;
    gs := Round(IntPower(2,pw));

    SimManager.FReplay.ReplaySpeedMultiplier :=  gs;

    //send speed
   SimManager.NetSend_ReplayControl(3, '', 0, gs);
end;

procedure TfrmReplayControl.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Self.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmReplayControl.FormShow(Sender: TObject);
begin
// with fMainInstr do
//   begin
//      btnRecord.Enabled := False;
//      btnMoveUnit.Enabled := False;
//
//      mnManOverBoard.Enabled := False ;
//      mnOtherObject.Enabled := False ;
//   end;
end;

procedure TfrmReplayControl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SimManager.Replay_Stop;
  SimManager.fGamePlayType := gpmScenario;
  SimManager.ClearAllObjects;
  SimCenter.StartSimulation;

  //send stop = close
   SimManager.NetSend_ReplayControl(2, '', 5, 0);

end;

end.
