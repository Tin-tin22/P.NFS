unit uCMSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, AdvSmoothButton;

type
  TfrmCMSetting = class(TForm)
    tblCM: TZQuery;
    tblCMID: TIntegerField;
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
    tblDetCMPC_ID: TIntegerField;
    tblDetCMPC_IDM: TIntegerField;
    tblDetCMAPP_TIPE: TIntegerField;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    Label4: TLabel;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    ActiveSource: TDataSource;
    DQ: TZQuery;
    DBComboBox2: TDBComboBox;
    wdstrngfldDetCMPC_IP: TWideStringField;
    wdstrngfldDetCMPC_NAME: TWideStringField;
    wdstrngfldDetCMAPP_NAME: TWideStringField;
    wdstrngfldDetCMAPP_PARAMS: TWideStringField;
    btnNew: TAdvSmoothButton;
    btnDelete: TAdvSmoothButton;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    btnClose: TAdvSmoothButton;
    dbedtPC_MAC: TDBEdit;
    lbl1: TLabel;
    dbedtAPP_NAME_2: TDBEdit;
    tblCMNAMA: TWideStringField;
    wdstrngfldDetCMPC_MAC: TWideStringField;
    wdstrngfldDetCMAPP_NAME_2: TWideStringField;
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
  public
    procedure ShowThisForm( mleft , mtop : integer );
  end;

var  frmCMSetting: TfrmCMSetting;

implementation

uses uDataModule, uQuery;

{$R *.dfm}


procedure TfrmCMSetting.ShowThisForm ( mleft , mtop : integer );
begin
  left  := ( mleft - Width ) div 2;
  Top   := ( mtop - Height ) div 2;

  tblCM.Open;
  tblDetCM.Open;
  ShowModal;
end;

procedure TfrmCMSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tblDetCM.Close;
  tblCM.Close;
end;

procedure TfrmCMSetting.tblCMBeforeDelete(DataSet: TDataSet);
begin
  HapusDetail('cm_console', 'PC_IDM', tblCMID.Value);
end;

procedure TfrmCMSetting.tblDetCMBeforePost(DataSet: TDataSet);
begin
  if tblDetCM.State = dsInsert then begin
    tblDetCMID.Value := GetNewID('cm_console', 'ID');
    tblDetCMPC_ID.Value := tblDetCMID.Value;
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
  if ActiveSource.DataSet <> tblCM then
  begin
    if ActiveSource.DataSet.State in dsEditModes then
      ActiveSource.DataSet.Post;
    ActiveSource.DataSet := tblCM;
  end;
end;

procedure TfrmCMSetting.KeDetail(Sender: TObject);
begin
  if ActiveSource.DataSet <> tblDetCM then
  begin
    if ActiveSource.DataSet.State in dsEditModes then
      ActiveSource.DataSet.Post;
    ActiveSource.DataSet := tblDetCM;
  end;
end;

end.

