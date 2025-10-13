unit ufRecordsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCommonLogReplay, StdCtrls, ComCtrls, ExtCtrls, AdvSmoothButton;

type
  TRecsInfo = class
    FDisplayName : string ;
    FFullName    : string ;
    FDateTime    : TDateTime;
    HInfo        : TRecScenarioInfo;
  end;
  
  TfrmRecordsList = class(TForm)
    lvScenario: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TAdvSmoothButton;
    Button2: TAdvSmoothButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lvScenarioChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvScenarioDblClick(Sender: TObject);
  private
    procedure ClearScenarioList;
  public
    SelectedRecsDisplayName  : string;
    Procedure UpdateListRecords;
  end;

var
  frmRecordsList: TfrmRecordsList;

implementation

uses DateUtils, StrUtils, uBridgeSet;

{$R *.dfm}

function GetDateRecsSnapshotName( FName : string ) : TDateTime ;
var
  intFileAge: LongInt;
begin
  intFileAge := FileAge(FName);
  if intFileAge = -1 then
    Result := 0
  else
    Result := FileDateToDateTime(intFileAge)
end;

function GetRecsNameWithOutExt( FName : string ) : string ;
begin
  Result := LeftStr(FName,Length(FName)-Length(cRecsExt))
end;

function GetRecsInfoFromFile (const s : string): TRecsInfo;
var
  lFile     : TFileStream;
  lHeader   : TRecFileHeader;
  lScen     : TRecScenarioInfo;
  SFullName : String ;
begin
  SFullName := GetFullNameRecsFileFromName(s);
  lFile     := TFileStream.Create(SFullName, fmOpenRead or fmShareDenyWrite);
  try
    lFile.ReadBuffer(lHeader, SizeOf(TRecFileHeader));
    if (lHeader.PrimaryID <> CONST_FileReplayCurrentVersion.PrimaryID)
        or (lHeader.SecondaryID <> CONST_FileReplayCurrentVersion.SecondaryID)
        or (lHeader.Version <> CONST_FileReplayCurrentVersion.Version)
        or (lHeader.Revision <> CONST_FileReplayCurrentVersion.Revision)
        then begin

       raise Exception.Create('Invalid File Replay.');
       exit;

    end;
    lFile.Seek(2, soCurrent);
    lFile.ReadBuffer(lScen, SizeOf(TRecScenarioInfo));

    Result := TRecsInfo.Create;
    with Result do
    begin
      FDisplayName  := GetRecsNameWithOutExt(ExtractFileName(SFullName));
      FFullName     := SFullName;
      FDateTime     := GetDateRecsSnapshotName(FFullName);
      HInfo         := lScen ;
    end;

  finally
    lFile.Free;
  end;
end;

procedure AddAllRecsListInfo ( Path : string ; var aList : TList ) ;
var
  SR : TSearchRec;
  srInfo : TRecsInfo ;
begin
  if aList = nil then exit ;
  if FindFirst(Path+'\*'+cRecsExt, faAnyFile, SR) = 0 then
  repeat
    srInfo := GetRecsInfoFromFile(GetRecsNameWithOutExt(SR.Name));
    aList.Add(srInfo);
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

procedure TfrmRecordsList.ClearScenarioList;
var i: integer;
    li: TListItem;
    scInfo : TRecsInfo;
begin
  for i := 0 to lvScenario.Items.Count - 1 do  begin
    li := lvScenario.Items[i];
    scInfo := li.Data;
    if scInfo <> nil then
    begin
       try
          scInfo.Free;
       except
          ShowMessage('Error Free Data');
          Continue;
       end;
    end;
  end;
  lvScenario.Items.Clear;

end;

{ TfrmRecordsList }

procedure TfrmRecordsList.UpdateListRecords;
var
  i : integer ;
  lInfo :  TList ;
  rcInfo : TRecsInfo ;
  li: TListItem;
begin
  lvScenario.OnChange := nil ;
  ClearScenarioList;
  lInfo := TList.Create;
  AddAllRecsListInfo(GetRecordsPath,lInfo);
  for i := 0 to lInfo.Count - 1 do begin
    rcInfo := lInfo.Items[i];

    li := lvScenario.Items.Add;
    li.Caption := rcInfo.FDisplayName;
    li.SubItems.Add(rcInfo.HInfo.scMissionName);
    li.SubItems.Add(FormatDateTime('YY-DD-MM HH:MM:SS', rcInfo.FDateTime));
    li.Data := rcInfo;
  end;
  
  lInfo.Free;
  lvScenario.OnChange := lvScenarioChange;
end;

procedure TfrmRecordsList.Button2Click(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfrmRecordsList.Button1Click(Sender: TObject);
begin
   ModalResult := mrOk;
end;

procedure TfrmRecordsList.lvScenarioChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  scInfo : TRecsInfo;
begin
  if (item <> nil) and (item.Data <> nil) then begin
    scInfo := item.Data;
    SelectedRecsDisplayName := '';
    SelectedRecsDisplayName := scInfo.FDisplayName;
  end;
end;

procedure TfrmRecordsList.lvScenarioDblClick(Sender: TObject);
begin
  if lvScenario.Selected.Index >= 0 then Button1Click(Sender);
end;

end.
