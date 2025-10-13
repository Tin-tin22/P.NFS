unit uNewLogEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, uNewReplay, StdCtrls, ExtCtrls, ComCtrls, Menus;

type

  TfrmReplayEditoor = class(TForm)
    sgReplayIndex: TStringGrid;
    Panel1: TPanel;
    btnOpen: TButton;
    btnClose: TButton;
    OpenDlg: TOpenDialog;
    Panel2: TPanel;
    memoScenario: TMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel3: TPanel;
    sgHistory: TStringGrid;
    Splitter3: TSplitter;
    Panel4: TPanel;
    tvData: TTreeView;
    pmTreeView: TPopupMenu;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    sgData: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure sgReplayIndexClick(Sender: TObject);
    procedure sgReplayIndexDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ExpandAll1Click(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
  private
    NReplay : TNewReplay;

    procedure CollectInfo;
    procedure ShowDataInfo;
    procedure ShowHistoryInfo;
  public

  end;

var
  frmReplayEditoor: TfrmReplayEditoor;

implementation

uses Math, uCommonLogReplay;

{$R *.dfm}

procedure TfrmReplayEditoor.FormCreate(Sender: TObject);
begin
  NReplay := TNewReplay.Create;
  sgData.Cells[0,1]  := ' UID'           ;
  sgData.Cells[0,2]  := ' CallSign'      ;
  sgData.Cells[0,3]  := ' CoordX'        ;
  sgData.Cells[0,4]  := ' CoordY'        ;
  sgData.Cells[0,5]  := ' CoordZ'        ;
  sgData.Cells[0,6]  := ' Speed'         ;
  sgData.Cells[0,7]  := ' Heading'       ;
  sgData.Cells[0,8]  := ' FlyCmdState'   ;
  sgData.Cells[0,9]  := ' DestHeading'   ;
  sgData.Cells[0,10] := ' DestSpeed'     ;
  sgData.Cells[0,11] := ' DestAltitude'  ;
  sgData.Cells[0,12] := ' Fuel'          ;
  sgData.Cells[0,13] := ' Symbol'        ;
end;

procedure TfrmReplayEditoor.FormDestroy(Sender: TObject);
begin
  NReplay.Free;
end;

procedure TfrmReplayEditoor.btnOpenClick(Sender: TObject);
begin
  if OpenDlg.Execute then begin

    NReplay.OpenFileReplay(OpenDlg.FileName);

    CollectInfo;

  end;
end;

procedure TfrmReplayEditoor.btnCloseClick(Sender: TObject);
begin
    NReplay.CloseFileReplay;
end;

procedure TfrmReplayEditoor.CollectInfo;
var i : integer;
begin
  sgReplayIndex.RowCount := 1 + NReplay.MaxFrame;

  sgReplayIndex.Cells[0, 0] := 'Frame';
  sgReplayIndex.Cells[1, 0] := 'Time';
  sgReplayIndex.Cells[2, 0] := 'Delay';
  sgReplayIndex.Cells[3, 0] := 'Multiply';
  sgReplayIndex.Cells[4, 0] := 'NumData';

  for i := 0 to NReplay.MaxFrame-1 do begin
    sgReplayIndex.Cells[0, i+1] := Format('%8d', [i]);
    sgReplayIndex.Cells[1, i+1] := Format('%12d', [NReplay.FrameTick[i]]);
    sgReplayIndex.Cells[3, i+1] := Format('%10d', [NReplay.FrameSpeedMultiply[i]]);
    sgReplayIndex.Cells[4, i+1] := Format('%10d', [NReplay.FrameNumData[i]]);

  end;

  for i := 0 to NReplay.MaxFrame-2 do
    sgReplayIndex.Cells[2, i+1] := Format('%6d',
    [(NReplay.FrameTick[i+1]-NReplay.FrameTick[i])]);


  memoScenario.Lines.Clear;
  memoScenario.Lines.Add(NReplay.ScenarioInfo.scMissionName);
  memoScenario.Lines.Add(NReplay.ScenarioInfo.scMapGeoset);
  memoScenario.Lines.Add(IntToStr(NReplay.ScenarioInfo.scId));
  memoScenario.Lines.Add(FloatToStr(NReplay.ScenarioInfo.scMapZoom));
end;

procedure TfrmReplayEditoor.sgReplayIndexClick(Sender: TObject);
var selIndex : integer;
    i : integer;
    recObj : TRecObjectData;
begin
  selIndex :=  sgReplayIndex.Selection.Top -1;
  NReplay.SeekPlay(selIndex);

  ShowDataInfo;
  ShowHistoryInfo;

end;

procedure TfrmReplayEditoor.ShowDataInfo;
var i, j : integer;
    recObj : TRecObjectData;
    nodePrn, nodeChld: TTreeNode;
begin
  sgData.ColCount := Length(NReplay.DataCurrent) + 1;
  for i := 1 to sgData.ColCount-1 do
    for j := 1 to sgData.RowCount-1 do
     sgData.Cells[i,j]  :=   '';

  for i := 0 to Length(NReplay.DataCurrent) -1 do begin
    recObj := NReplay.DataCurrent [i];
    sgData.Cells[i+1,1]  :=   recObj.UID;
    sgData.Cells[i+1,2]  :=   recObj.CallSign;
    sgData.Cells[i+1,3]  :=   Format('%2.6f', [recObj.CoordX]);
    sgData.Cells[i+1,4]  :=   Format('%2.6f', [recObj.CoordY]);
    sgData.Cells[i+1,5]  :=   Format('%2.6f', [recObj.CoordZ]);
    sgData.Cells[i+1,6]  :=   Format('%2.6f', [recObj.Speed]);
    sgData.Cells[i+1,7]  :=   Format('%2.6f', [recObj.Heading]);
    sgData.Cells[i+1,8]  :=   Format('%6d',   [recObj.FlyCmdState]);
    sgData.Cells[i+1,9]  :=   Format('%2.6f', [recObj.DestHeading]);
    sgData.Cells[i+1,10] :=   Format('%2.6f', [recObj.DestSpeed]);
    sgData.Cells[i+1,11] :=   Format('%2.6f', [recObj.DestAltitude]);
    sgData.Cells[i+1,12] :=   Format('%2.6f', [recObj.Fuel]);
    sgData.Cells[i+1,13] :=   recObj.CharSymbol;
  end
end;

{procedure TfrmReplayEditoor.ShowDataInfo;

var selIndex : integer;
    i : integer;
    recObj : TRecObjectData;
    nodePrn, nodeChld: TTreeNode;
begin
  tvData.Items.Clear;

  for i := 0 to Length(NReplay.DataCurrent) -1 do begin

    recObj := NReplay.DataCurrent [i];

    nodeChld:= tvData.Items.AddChild(nodePrn, 'Data ' + IntToStr(i));

    tvData.Items.AddChild(nodeChld, ' UID      : ' + recObj.UID);
    tvData.Items.AddChild(nodeChld, ' CallSign : ' + recObj.CallSign);
    tvData.Items.AddChild(nodeChld, ' CoordX   : ' + Format('%2.6f', [recObj.CoordX]));
    tvData.Items.AddChild(nodeChld, ' CoordY   : ' + Format('%2.6f', [recObj.CoordY]));
    tvData.Items.AddChild(nodeChld, ' CoordZ   : ' + Format('%2.6f', [recObj.CoordZ]));
    tvData.Items.AddChild(nodeChld, ' Speed    : ' + Format('%2.6f', [recObj.Speed]));
    tvData.Items.AddChild(nodeChld, ' Heading  : ' + Format('%2.6f', [recObj.Heading]));

    tvData.Items.AddChild(nodeChld, ' FlyCmdState  : ' + Format('%6d', [recObj.FlyCmdState]));
    tvData.Items.AddChild(nodeChld, ' DestHeading  : ' + Format('%2.6f', [recObj.DestHeading]));
    tvData.Items.AddChild(nodeChld, ' DestSpeed  : ' + Format('%2.6f', [recObj.DestSpeed]));
    tvData.Items.AddChild(nodeChld, ' DestAltitude  : ' + Format('%2.6f', [recObj.DestAltitude]));

    tvData.Items.AddChild(nodeChld, ' Fuel     : ' + Format('%2.6f', [recObj.Fuel]));
    tvData.Items.AddChild(nodeChld, ' Symbol   : ' + recObj.CharSymbol);

  end;

end;
}
procedure TfrmReplayEditoor.ShowHistoryInfo;
var aHistList:  aACHistory;
    i, j, maxRowC : integer;

begin
  for i := 0 to sgHistory.ColCount-1 do
    for j := 0 to sgHistory.RowCount-1 do
      sgHistory.Cells[i, j] := '';

  NReplay.GetPositionHistory(aHistList);

  maxRowC := 0;
  sgHistory.ColCount := Length(aHistList);
  for i := 0 to Length(aHistList)-1 do begin
    sgHistory.Cells[i, 0] := aHistList[i].ACUID;


    if maxRowC < aHistList[i].HistoryCount then
      maxRowC := aHistList[i].HistoryCount;

    for j := 0 to aHistList[i].HistoryCount-1 do
      sgHistory.Cells[i, j+1] := Format('%2.6f, %2.6f',
        [aHistList[i].HistoryData[j].CoordX, aHistList[i].HistoryData[j].CoordY])
      ;
  end;

  sgHistory.RowCount := maxRowC+1;

end;

procedure TfrmReplayEditoor.sgReplayIndexDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
const DEF_CLR = $000008ff;
      DEF_CHAR = ['1', '2',  '4',  '8'];
var clr : TColor;
    trm : string;
    i: integer;
    ch : char;
begin
  trm := Trim(sgReplayIndex.Cells[3, ARow]);

  if (Length(trm)=1) then
    if trm[1] in DEF_CHAR then begin
      i := StrToInt(trm);

      clr := DEF_CLR shl i shl i;

      sgReplayIndex.Canvas.Font.Color := clr;

      sgReplayIndex.Canvas.TextOut(
        Rect.Left+2, Rect.Top+1, sgReplayIndex.Cells[ACol, ARow]);
    end;
end;

procedure TfrmReplayEditoor.ExpandAll1Click(Sender: TObject);
var i : integer;
begin
  for i := 0 to tvData.Items.Count-1 do
    tvData.Items. Item[i].Expand(true);

end;

procedure TfrmReplayEditoor.CollapseAll1Click(Sender: TObject);
var i : integer;
begin
  for i := 0 to tvData.Items.Count-1 do
    tvData.Items. Item[i].Collapse(true);

end;

end.
