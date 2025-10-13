unit uSimpleLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, MSThreadTimer,uCommonLogReplay, uNewLog, uNewReplay, ExtCtrls,
  Buttons, Grids;

type
  TfrmLogger = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    Label1: TLabel;
    btnSave: TButton;
    Label3: TLabel;
    OpenDlg: TOpenDialog;
    btnOpenFile: TButton;
    btnStartReplay: TButton;
    btnStopReplay: TButton;
    ScrollBar1: TScrollBar;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Memo2: TMemo;
    btnPause: TButton;
    btnResume: TButton;
    sGrid: TStringGrid;
    trbDelay: TTrackBar;
    pnlReplay: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    rgLogGameSpeed: TRadioGroup;
    pnlLog: TPanel;
    lblTrackBar: TLabel;
    SaveDialog1: TSaveDialog;
    rgReplayGameSpeed: TRadioGroup;
    Panel1: TPanel;
    lblFrameInfo: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure btnStartReplayClick(Sender: TObject);
    procedure btnStopReplayClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResumeClick(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure trbDelayChange(Sender: TObject);
    procedure rgLogGameSpeedClick(Sender: TObject);
    procedure rgReplayGameSpeedClick(Sender: TObject);
    procedure sGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Logger declarations }
    NLog : TNewRecorder;
    Counter : integer;
    MTimer : TMSTimer;
    prevTick, prevDataTick : LongWord;

    {Replay}
    NReplay: TNewReplay;
    ScInfo: TRecScenarioInfo;

  public
    GameSpeedVar: integer;
    { Public declarations }
    procedure MasterThreadOnExec(Sender: TObject);

    procedure ReplayOnGetFrame(const aData: aObjectData);
    procedure ReplayOnEnd(sender: TObject);

  end;

var
  frmLogger: TfrmLogger;

implementation
uses Math;

Const
  CONST_DEF_GAMEDELAY = 4000;
  CONST_DEF_TRB_MULTIPLY = 100;

{$R *.dfm}

{ TForm1 }

procedure TfrmLogger.MasterThreadOnExec(Sender: TObject);
var px, py, pz : double;
    sinT       : double;

    arrObjData : aObjectData;
    i, j : integer;
    gtc : LongWord;
begin
   Counter := (Counter +1) mod 360;
   sinT := Sin(DegToRad(Counter));

   px := RandG(112,0.1);
   py := RandG(-7,0.1);
   pz := RandG(6000 * (SinT +2) , 100);

   gtc := GetTickCount;
   label1.Caption := Format('%d  %2.4f%2.4f%2.4f',[gtc, px, py, pz]);

   j := 15;
   SetLength(arrObjData, 16);

   for i := 0 to j do
     with arrObjData[i] do begin
       UID      := 'uid'+IntToStr(i);
       CallSign := 'calls'+IntToStr(i);
       CoordX   := RandG(112,0.1);
       CoordY   := RandG(-7,0.1);
       CoordZ   := RandG(6000 * (SinT +2) , 100);
       Speed    := Counter;
       Heading  := 000.0;
       Fuel     := 32768.9;

   end;

   NLog.AddDataToLog(GameSpeedVar, arrObjData);
end;

procedure TfrmLogger.FormCreate(Sender: TObject);
var fName: string;
begin
  GameSpeedVar := 1;

  NLog := TNewRecorder.Create;

  fName := 'ARCS'+FormatDateTime('yyyymmddhhnnsszzz',now)+'.txt';

  ScInfo.scID := 12;
  ScInfo.scMissionName := 'Secret Mission';
  ScInfo.scMapGeoset := 'no';
  ScInfo.scMapZoom := 96.012;

  NLog.InitializedFileRecord(fName, ScInfo);


  Counter := 0;
  MTimer := TMSTimer.Create;
  MTimer.Interval := CONST_DEF_GAMEDELAY;
  MTimer.OnTimer := MasterThreadOnExec;

  NReplay := TNewReplay.Create;

  NReplay.OnFrameReplay := ReplayOnGetFrame;
  NReplay.OnEndReplay   := ReplayOnEnd;

  SGrid.Cells[0, 0] := 'Frame';
  SGrid.Cells[1, 0] := 'LogTime';
  SGrid.Cells[2, 0] := 'RealTime';
  SGrid.Cells[3, 0] := 'LogDelay';
  SGrid.Cells[4, 0] := 'Multiply';
  SGrid.Cells[5, 0] := 'RealDelay';

end;

procedure TfrmLogger.FormDestroy(Sender: TObject);
begin
  MTimer.Terminate;
  MTimer.Free;

  NReplay.Free;
  NLog.Free;
end;

procedure TfrmLogger.btnStartClick(Sender: TObject);
begin
  btnStart.Enabled := FALSE;
  btnStop.Enabled  := TRUE;
  MTimer.Resume;
end;

procedure TfrmLogger.btnStopClick(Sender: TObject);
begin
  btnStart.Enabled := TRUE;
  btnStop.Enabled  := FALSE;

  MTimer.Suspend;
end;


procedure TfrmLogger.btnSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    NLog.SaveFileRecord(SaveDialog1.FileName);
end;

// ========== replay...............

procedure TfrmLogger.ReplayOnGetFrame(const aData: aObjectData);
var i,j     : integer;
    rData : TRecObjectData;
    tick : LongWord;
begin
  tick := GetTickCount;

  Memo1.Lines.Add(Format('!Frame %d of %d',
     [NReplay.CurrentFrame, NReplay.MaxFrame ]));

  Memo2.Lines.Clear;

  for i := 0 to Length(NReplay.DataCurrent)-1 do begin
    rData := NReplay.DataCurrent[i];

    Memo2.Lines.Add(Format('%s, %2.4f, %2.4f',
      [rData.UID, rData.CoordX, rData.Speed]));
  end;

  lblFrameInfo.Caption:= Format('Frame %d of %d',
     [NReplay.CurrentFrame, NReplay.MaxFrame ]);

  if NReplay.AfterSeek then begin
    for i := NReplay.CurrentFrame to sGrid.RowCount-1 do
      for j := 0 to sGrid.ColCount-1 do
        SGrid.Cells[j, i] := '';

  end;

  SGrid.Cells[0, NReplay.CurrentFrame+1] := IntToStr(NReplay.CurrentFrame);

  SGrid.Cells[1, NReplay.CurrentFrame+1] := IntToStr(NReplay.DataTick);
  SGrid.Cells[2, NReplay.CurrentFrame+1] := IntToStr(GetTickCount);
(***)
  SGrid.Cells[3, NReplay.CurrentFrame+1] :=
      IntToStr(NReplay.DataTick - prevDataTick);
//  SGrid.Cells[3, NReplay.CurrentFrame+1] :=
//      IntToStr(NReplay.FrameTick[NReplay.CurrentFrame] - NReplay.FrameTick[NReplay.CurrentFrame-1]);

  SGrid.Cells[4, NReplay.CurrentFrame+1] := IntToStr(NReplay.FrameSpeedMultiply
  [NReplay.CurrentFrame] );

  SGrid.Cells[5, NReplay.CurrentFrame+1] := IntToStr(Tick - prevTick);

  ProgressBar1.Position := NReplay.CurrentFrame;

  ScrollBar1.OnChange := nil;
  ScrollBar1.Position := NReplay.CurrentFrame;
  ScrollBar1.OnChange := ScrollBar1Change;

  prevTick := tick;
  prevDataTick := NReplay.DataTick;
end;

procedure TfrmLogger.ReplayOnEnd(sender: TObject);
begin
  ShowMessage('End Of Replay');
end;

procedure TfrmLogger.btnOpenFileClick(Sender: TObject);
var i : integer;
begin
  if openDlg.Execute then begin
    if not NReplay.OpenFileReplay(openDlg.FileName) then begin
      ShowMessage('Failed to Open File Replay');
      exit;
    end;

    ProgressBar1.Max := NReplay.MaxFrame;
    ScrollBar1.Max := NReplay.MaxFrame;
    Memo1.Lines.Clear;

    sGrid.RowCount := NReplay.MaxFrame+1;

    for i := 1 to sGrid.RowCount-1 do begin
      sGrid.Rows[i].Clear;

    end;

  end;
end;

procedure TfrmLogger.btnStartReplayClick(Sender: TObject);
begin
  NReplay.StartPlay;
  prevTick := GetTickCount;
end;

procedure TfrmLogger.btnStopReplayClick(Sender: TObject);
begin
  NReplay.StopPlay;
end;

procedure TfrmLogger.btnPauseClick(Sender: TObject);
begin
  NReplay.PausePlay;
end;

procedure TfrmLogger.btnResumeClick(Sender: TObject);
begin
  NReplay.ResumePlay;
end;

procedure TfrmLogger.ScrollBar1Change(Sender: TObject);
begin
  Memo2.Lines.Add('SSChange@@');
  NReplay.SeekPlay(ScrollBar1.Position);
end;

procedure TfrmLogger.trbDelayChange(Sender: TObject);
begin
  MTimer.Interval := trbDelay.Position * CONST_DEF_TRB_MULTIPLY;
  lblTrackBar.Caption := IntToStr(trbDelay.Position);
end;

procedure TfrmLogger.rgLogGameSpeedClick(Sender: TObject);
var pw: integer;
begin
  pw := (sender as TRadioGroup).ItemIndex;
  GameSpeedVar := Round( IntPower(2,pw));

  trbDelay.Position := Round(
   (CONST_DEF_GAMEDELAY / GameSpeedVar)/ CONST_DEF_TRB_MULTIPLY);

end;

procedure TfrmLogger.rgReplayGameSpeedClick(Sender: TObject);
var pw: integer;
    gs : integer;
begin
  pw := (sender as TRadioGroup).ItemIndex;
  gs := Round(IntPower(2,pw));

  NReplay.ReplaySpeedMultiplier := gs;
end;

procedure TfrmLogger.sGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const DEF_CLR = $000008ff;
      DEF_CHAR = ['1', '2',  '4',  '8'];
var clr : TColor;
    trm : string;
    i: integer;
    ch : char;
begin
  trm := Trim(sGrid.Cells[4, ARow]);

  if (Length(trm)=1) then
    if trm[1] in DEF_CHAR then begin
      i := StrToInt(trm);

      clr := DEF_CLR shl i shl i;

      sGrid.Canvas.Font.Color := clr;

      sGrid.Canvas.TextOut(
        Rect.Left+2, Rect.Top+1, sGrid.Cells[ACol, ARow]);
    end;
end;

end.
