unit ufassignmissile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, AdvSmoothButton, StdCtrls;

type
  TfrmAssignMisille = class(TForm)
    pnlMain: TPanel;
    lvMissile: TListView;
    btnCancel: TAdvSmoothButton;
    btnOk: TAdvSmoothButton;
    cbbModel: TComboBox;
    cbbDOF: TComboBox;
    lbl5: TLabel;
    lbl4: TLabel;
    lbl9: TLabel;
    edtPosHeading: TEdit;
    lbl10: TLabel;
    edtPosPitch: TEdit;
    cbHasLauncher: TCheckBox;
    Label1: TLabel;
    edtMissileID: TEdit;
    btnRemove: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure lvMissileClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ShipID : Integer;
    WeaponID : Integer;
    LauncherID : Integer;
    WeaponIDNumber : Integer;

    procedure ShowMissileOnWeapon;
    procedure ShowModel_Dof_Missile;
    procedure ClearAllDetail;

    function CheckAvailableMissileID(MissileID : integer):Boolean;
  end;

var
  frmAssignMisille: TfrmAssignMisille;

implementation

uses uClassDatabase, uDataModule;

{$R *.dfm}

{ TfrmAssignMisille }

procedure TfrmAssignMisille.ShowMissileOnWeapon;
var
  ListMissile : TList;
  mMissile : TMissile;

  i : Integer;
begin
  try
    lvMissile.Items.Clear;

    ListMissile := TList.Create;
    DataModule1.GetListMissileOnWeapon(WeaponIDNumber, ListMissile);

    for i:= 0 to ListMissile.Count-1 do
    begin
      mMissile := TMissile(ListMissile.Items[i]);

      with lvMissile.Items.Add do
      begin
        Caption := DataModule1.GetNameWeaponByID(WeaponID) + '-' +
                   IntToStr(ShipID) + '-' +
                   IntToStr(LauncherID);
        SubItems.Add(IntToStr(mMissile.IDMissile));
        SubItems.Add(DataModule1.GetModelNameByID(mMissile.IDModel));
        SubItems.Add(DataModule1.GetDOFNameByID(mMissile.IDDof));
        SubItems.Add(IntToStr(mMissile.Pos_H));
        SubItems.Add(IntToStr(mMissile.Pos_P));
        SubItems.Add(IntToStr(mMissile.HasLauncher));
      end;
    end;
  finally
    ListMissile.Free;
  end;
end;

procedure TfrmAssignMisille.FormShow(Sender: TObject);
begin
  ShowMissileOnWeapon;
  ShowModel_Dof_Missile;
  ClearAllDetail;
end;

procedure TfrmAssignMisille.ShowModel_Dof_Missile;
var
  listModel,
  listDOF : TList;

  mModel : TModel;
  mDOF : TDof;

  i : integer;
begin
  try
    cbbModel.Items.Clear;
    cbbDOF.Items.Clear;

    listModel   := TList.Create;
    listDOF     := TList.Create;

    DataModule1.GetAllModel3D(listModel);
    DataModule1.GetAllDOF3D(listDOF);

    cbbModel.Items.Add('Empty');
    for i:= 0 to listModel.Count-1 do
    begin
      mModel := TModel(listModel.Items[i]);

      if mModel.TIPE = 1 then continue;

      cbbModel.Items.Add(mModel.Nama);
    end;

    cbbDOF.Items.Add('Empty');
    for i:= 0 to listDOF.Count-1 do
    begin
      mDOF := TDof(listDOF.Items[i]);
      cbbDOF.Items.Add(mDOF.Nama);
    end;

  finally
    listModel.Free;
    listDOF.Free;
  end;
end;

procedure TfrmAssignMisille.ClearAllDetail;
begin
  cbbModel.ItemIndex := 0;
  cbbDOF.ItemIndex := 0;
  edtPosPitch.Text := '0';
  edtPosHeading.Text := '0';
  edtMissileID.Text := '0';
  cbHasLauncher.Checked := False;
end;

procedure TfrmAssignMisille.lvMissileClick(Sender: TObject);
begin
  ClearAllDetail;
end;

procedure TfrmAssignMisille.btnOkClick(Sender: TObject);
var
  MissileID : Integer;
  PosH, PosP : Integer;

  isValid : Boolean;
  isError : Boolean;

  RecMissile : TMissile;
begin
  isValid := True;
  isError := False;

  if not TryStrToInt(edtPosHeading.Text, PosH) then isValid := false;
  if not TryStrToInt(edtPosPitch.Text, PosP) then isValid := False;
  if not TryStrToInt(edtMissileID.Text, MissileID) then isValid := False;

  if isValid then
  begin
    if MissileID <> 0 then
    begin
      if CheckAvailableMissileID(MissileID) then
      begin
        if cbbModel.ItemIndex = 0 then isError := True;
        if cbbDOF.ItemIndex = 0 then isError := True;

        if not isError then
        begin
          RecMissile := TMissile.Create;
          RecMissile.ID         := 0;
          RecMissile.IDM        := WeaponIDNumber;
          RecMissile.IDMissile  := MissileID;
          RecMissile.IDModel    := DataModule1.GetModelIDByName(cbbModel.Text);
          RecMissile.IDDof      := DataModule1.GetDofIDByName(cbbDOF.Text);
          RecMissile.Pos_H      := PosH;
          RecMissile.Pos_P      := PosP;

          if cbHasLauncher.Checked then
            RecMissile.HasLauncher := 1
          else
            RecMissile.HasLauncher := 0;

          DataModule1.SaveMissileWeapon(RecMissile);

          ShowMissileOnWeapon;
          ClearAllDetail;
        end
        else
        begin
          ShowMessage('Model And Dof Cant Be Empty');
        end;
      end
      else
        ShowMessage('Weapon Has Been Assigned With This Missile ID');
    end
    else
      ShowMessage('Missile ID Cant be 0');
  end;
end;

procedure TfrmAssignMisille.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmAssignMisille.CheckAvailableMissileID(
  MissileID: integer): Boolean;
var
  ListMissile : TList;
  mMissile : TMissile;

  i : integer;
begin
  Result := true;

  try
    ListMissile := TList.Create;
    DataModule1.GetListMissileOnWeapon(WeaponIDNumber, ListMissile);

    for i:= 0 to ListMissile.Count-1 do
    begin
      mMissile := TMissile(ListMissile.Items[i]);

      if mMissile.IDMissile = MissileID then
      begin
        Result := false;
        Break;
      end;
    end;
  finally
    ListMissile.Free;
  end;
end;

procedure TfrmAssignMisille.btnRemoveClick(Sender: TObject);
begin
  if lvMissile.Selected <> nil then
  begin
    DataModule1.DeleteMissileWeapon(WeaponIDNumber,
                                  StrToInt(lvMissile.Selected.SubItems[0]));

    ShowMissileOnWeapon;
    ClearAllDetail;
  end
  else
  begin
    ShowMessage('Please Select Missile');
  end;
end;

end.
