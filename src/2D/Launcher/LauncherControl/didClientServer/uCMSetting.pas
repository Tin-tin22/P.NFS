unit uCMSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons;

type
  TfrmCMSetting = class(TForm)
    tblCM: TZQuery;
    tblCMID: TIntegerField;
    tblCMNAMA: TStringField;
    dstblCM: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    DBGrid2: TDBGrid;
    DBEdit3: TDBEdit;
    dstblDetCM: TDataSource;
    tblDetCM: TZQuery;
    tblDetCMID: TIntegerField;
    tblDetCMPC_IP: TStringField;
    tblDetCMPC_ID: TIntegerField;
    tblDetCMPC_IDM: TIntegerField;
    tblDetCMPC_NAME: TStringField;
    tblDetCMAPP_TIPE: TIntegerField;
    tblDetCMAPP_NAME: TStringField;
    tblDetCMAPP_PARAMS: TStringField;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    Label4: TLabel;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    ActiveSource: TDataSource;
    btnNew: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSave: TSpeedButton;
    btnCancel: TSpeedButton;
    btnClose: TSpeedButton;
    DQ: TZQuery;
    DBComboBox2: TDBComboBox;
    procedure tblDetCMBeforePost(DataSet: TDataSet);
    procedure tblDetCMNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActiveSourceDataChange(Sender: TObject; Field: TField);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure tblCMBeforeDelete(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure KeMaster(Sender: TObject);
    procedure KeDetail(Sender: TObject);
  private
    function GetNewID(const tbl, fie: string): integer;
    procedure HapusDetail(const tbl, fie: string; val: integer);
  public
    procedure ShowThisForm();
  end;

var
  frmCMSetting: TfrmCMSetting;

implementation

uses uDM;

{$R *.dfm}

function TfrmCMSetting.GetNewID(const tbl, fie: string): integer;
begin
  DQ.SQL.Clear;
  DQ.SQL.Add('select MAX(' + fie + ') from ' + tbl);
  DQ.Open;
  if DQ.Fields[0].AsInteger <= 0 then
    Result := 1
  else
    Result := DQ.Fields[0].AsInteger + 1;
  DQ.Close;
end;

procedure TfrmCMSetting.HapusDetail(const tbl, fie: string; val: integer);
begin
  DQ.SQL.Clear;
  DQ.SQL.Add('delete from ' + tbl + ' where ' + fie + '=' + IntToStr(val));
  DQ.ExecSQL;
end;

procedure TfrmCMSetting.ShowThisForm;
begin
  tblCM.Open;
  tblDetCM.Open;
  Show;
end;

procedure TfrmCMSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tblDetCM.Close;
  tblCM.Close;
end;

procedure TfrmCMSetting.tblCMBeforeDelete(DataSet: TDataSet);
begin
  HapusDetail('cm_set_app', 'PC_IDM', tblCMID.Value);
end;

procedure TfrmCMSetting.tblDetCMBeforePost(DataSet: TDataSet);
begin
  if tblDetCM.State = dsInsert then begin
    tblDetCMID.Value := GetNewID('cm_set_app', 'ID');
  end;
end;

procedure TfrmCMSetting.tblDetCMNewRecord(DataSet: TDataSet);
begin
  tblDetCMPC_IDM.Value := tblCMID.Value;
end;

procedure TfrmCMSetting.ActiveSourceDataChange(Sender: TObject;
  Field: TField);
begin
  btnNew.Enabled := ActiveSource.DataSet.State = dsBrowse;
  btnDelete.Enabled := btnNew.Enabled;
  btnClose.Enabled := btnNew.Enabled;
  btnSave.Enabled := ActiveSource.DataSet.State in dsEditModes;
  btnCancel.Enabled := btnSave.Enabled;
end;

procedure TfrmCMSetting.btnNewClick(Sender: TObject);
begin
  ActiveSource.DataSet.Insert;
end;

procedure TfrmCMSetting.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('Click OK to confirm delete, or Cancel.', mtInformation, mbOKCancel, 0) = mrOk then
    ActiveSource.DataSet.Delete;
end;

procedure TfrmCMSetting.btnSaveClick(Sender: TObject);
begin
  if ActiveSource.DataSet.State in dsEditModes then
    ActiveSource.DataSet.Post;
end;

procedure TfrmCMSetting.btnCancelClick(Sender: TObject);
begin
  if ActiveSource.DataSet.State in dsEditModes then
    ActiveSource.DataSet.Cancel;
end;

procedure TfrmCMSetting.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCMSetting.KeMaster(Sender: TObject);
begin
  if ActiveSource.DataSet <> tblCM then begin
    if ActiveSource.DataSet.State in dsEditModes then
      ActiveSource.DataSet.Post;
    ActiveSource.DataSet := tblCM;
  end;
end;

procedure TfrmCMSetting.KeDetail(Sender: TObject);
begin
  if ActiveSource.DataSet <> tblDetCM then begin
    if ActiveSource.DataSet.State in dsEditModes then
      ActiveSource.DataSet.Post;
    ActiveSource.DataSet := tblDetCM;
  end;
end;

end.

