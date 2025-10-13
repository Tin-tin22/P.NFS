unit ufReportEvent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,

  uDataModule,uClassDatabase, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls, QuickRpt,
  QRCtrls, Grids, DBGrids, CurvyControls;

type
  TfrmReportEvent = class(TForm)
    lvGame: TListView;
    btnReport: TButton;
    qckrp1: TQuickRep;
    qrbnd1: TQRBand;
    qrsbdtl1: TQRSubDetail;
    qrlbl1: TQRLabel;
    zqryEvent: TZQuery;
    dsEvent: TDataSource;
    QRDBText2: TQRDBText;
    zqry2: TZQuery;
    QRDBText5: TQRDBText;
    QRImage1: TQRImage;
    ds3: TDataSource;
    QRDBText6: TQRDBText;
    zqry2ID: TLargeintField;
    zqry2GameID: TLargeintField;
    zqry2NAMA: TStringField;
    zqry2ConsoleID: TLargeintField;
    zqry2SHIP_NAME: TStringField;
    zqry2Time: TMemoField;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    zqry2Message: TMemoField;
    zqry2cMessage: TStringField;
    zqry2Param1: TFloatField;
    zqry2Param2: TFloatField;
    zqry2Param3: TFloatField;
    QRDBText8: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    QRShape1: TQRShape;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    btnOK: TButton;
    chkScenario: TCheckBox;
    chkTanggal: TCheckBox;
    btnAllReport: TButton;
    grpFilter: TGroupBox;
    qrdbtxtaTime: TQRDBText;
    zqry2aTime: TMemoField;
    dtpReport: TDateTimePicker;
    CurvyComboSceFilter: TCurvyCombo;
    procedure FormShow(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure zqry2CalcFields(DataSet: TDataSet);
    procedure btnOKClick(Sender: TObject);
    procedure btnAllReportClick(Sender: TObject);
  private

  public
    { Public declarations }

  end;

var
  frmReportEvent: TfrmReportEvent;

implementation

{$R *.dfm}

procedure TfrmReportEvent.FormShow(Sender: TObject);
var
  i : integer;
  ListGame : Tlist;
  aGame : TGameList;

  ListScenario : Tlist;
  Scenario : TScenarioList;
begin
//  lvGame.Items.Clear;
//
//  ListGame := TList.Create;
//  DataModule1.GetAllGame(ListGame);
//
//  for i := 0 to ListGame.Count - 1 do
//  begin
//    aGame := TGameList(ListGame[i]);
//    with lvGame.Items.Add do
//    begin
//      Caption := aGame.GameName;
//    end;
//  end;

  ListScenario := TList.Create;
  DataModule1.GettAllScenario(ListScenario);

  for i := 0 to ListScenario.Count - 1 do
  begin
    Scenario := TScenarioList(ListScenario[i]);

    if Scenario.Scenario_ID = 0 then Continue;


    CurvyComboSceFilter.Items.Add(Scenario.Scenario_Name);
    CurvyComboSceFilter.Text := CurvyComboSceFilter.Items[0];
  end;
end;

procedure TfrmReportEvent.btnOKClick(Sender: TObject);
var
  i,j : integer;
  ListScenarioID, aListGame, aGame, aListGameDate : TList;
  aScen     : TSearchScenarioIDList;
  GameSce     : TGameList;
  strDate   : string;
  GameDate  : TGameList;

  sceID  : Integer;
begin
   lvGame.Items.Clear;

  if (chkScenario.Checked) and not (CurvyComboSceFilter.Text = '') then
  begin
    aGame := TList.Create;

    ListScenarioID := TList.Create;
    DataModule1.GetScenarioIDByName(CurvyComboSceFilter.Text,ListScenarioID);



    for i := 0 to ListScenarioID.Count - 1 do
    begin
      aScen := TSearchScenarioIDList(ListScenarioID[i]);
      sceID := ascen.IDSce;

      if (chkTanggal.Checked) then
      begin
        strDate:=datetostr(dtpReport.Date);
        aListGame := TList.Create;
        DataModule1.GetGameNameBySceIDDate(sceID,strDate,aListGame);
      end
      else
      begin
        aListGame := TList.Create;
        DataModule1.GetGameNameBySceID(sceID,aListGame);
      end;


      for j := 0 to aListGame.Count - 1 do
      begin
        aGame.Add(aListGame[j]);
      end;

    end;

    for i := 0 to aGame.Count-1 do
    begin
      GameSce := TGameList(aGame[i]);
      with lvGame.Items.Add do
      begin
        Caption := (GameSce.GameName);
        SubItems.Add(GameSce.aScenName);
        SubItems.Add(GameSce.aTanggal);
      end;
    end;
    
  end;

  if (chkTanggal.Checked)and not (chkScenario.Checked) then
  begin
    aListGameDate := TList.Create;
    strDate:=datetostr(dtpReport.Date);
    DataModule1.GetGameNameByDate(strDate,aListGameDate);

    for i := 0 to aListGameDate.Count - 1 do
    begin
      GameDate := TGameList(aListGameDate[i]);
      with lvGame.Items.Add do
      begin
        Caption := (GameDate.GameName);
        SubItems.Add(GameDate.aScenName);
        SubItems.Add(GameDate.aTanggal);
      end;
    end;
  end;

end;

procedure TfrmReportEvent.btnAllReportClick(Sender: TObject);
var
  i : integer;
  ListGame : Tlist;
  aGame : TGameList;
begin
  lvGame.Items.Clear;

  ListGame := TList.Create;
  DataModule1.GetAllGame(ListGame);

  for i := 0 to ListGame.Count - 1 do
  begin
    aGame := TGameList(ListGame[i]);
    with lvGame.Items.Add do
    begin
      Caption := aGame.GameName;
      SubItems.Add(aGame.aScenName);
      SubItems.Add(aGame.aTanggal);
    end;
  end;
end;

procedure TfrmReportEvent.btnReportClick(Sender: TObject);
begin
  if lvGame.Selected <> nil then
  begin
     zqryEvent.Close;
     zqryEvent.Params[0].asstring := lvgame.Selected.Caption;
     zqryEvent.Open ;

     zqry2.Close;
     zqry2.Open;

     qckrp1.Preview ;

  end
  else
    ShowMessage('Select Game First');

end;

function getParams(const val, s1, s2, s3 : string ) : string   ;
var
  MessageTemp,MessageEvent : string;
begin
   MessageTemp   := val;
   MessageEvent  := StringReplace(MessageTemp, '<1>', s1,
                          [rfReplaceAll, rfIgnoreCase]);
   MessageEvent  := StringReplace(MessageEvent, '<2>', s2,
                          [rfReplaceAll, rfIgnoreCase]);
   MessageEvent  := StringReplace(MessageEvent, '<3>', s3,
                          [rfReplaceAll, rfIgnoreCase]);

  Result :=  MessageEvent ;

end;

procedure TfrmReportEvent.zqry2CalcFields(DataSet: TDataSet);
var
 s1, s2, s3 : string;
 s:string;

begin
   if zqry2.Active then
   begin
     s1:= FloatToStr(zqry2Param1.Value);
     s2:= FloatToStr(zqry2Param2.Value);
     s3:= FloatToStr(zqry2Param3.Value);

     s := getParams(zqry2message.Value,s1,s2,s3);
     zqry2cmessage.Value := getParams(zqry2message.Value,s1,s2,s3);
   end;
end;



end.
