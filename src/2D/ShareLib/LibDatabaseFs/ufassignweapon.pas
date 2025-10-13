unit ufassignweapon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, AdvSmoothButton,

  uDataModule, uClassDatabase;

type
  TfrmAssignWeapon = class(TForm)
    pnlmain: TPanel;
    lbl2: TLabel;
    edtWeaponLauncher: TEdit;
    lvWeapon: TListView;
    lbl1: TLabel;
    btnOk: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    cbbWeaponType: TComboBox;
    lbl3: TLabel;
    cbbSwitch: TComboBox;
    cb3DActor: TCheckBox;
    lbl8: TLabel;
    edtPosHeading: TEdit;
    edtPosPitch: TEdit;
    lbl10: TLabel;
    lbl9: TLabel;
    cbbDOF_I: TComboBox;
    cbbDOF_II: TComboBox;
    lbl6: TLabel;
    lbl5: TLabel;
    cbbModelBody: TComboBox;
    cbbModelSpout: TComboBox;
    lbl7: TLabel;
    lbl4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbWeaponTypeChange(Sender: TObject);
    procedure cb3DActorClick(Sender: TObject);
    procedure lvWeaponClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    shipID    : Integer;
    aListView : TlistView;

    function CekLauncherAvailable(cListView : TListView; idLauncher : integer): boolean;
    procedure GetAllTypeWeapon;
    procedure GetALL_Dof_Model_Switch;

    procedure GetWeaponByType(TypeID : integer);
    procedure ClearAllDetail;

  end;

var
  frmAssignWeapon: TfrmAssignWeapon;

implementation

uses ufWeaponList, uTCPDatatype, Math;

{$R *.dfm}

procedure TfrmAssignWeapon.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAssignWeapon.btnOkClick(Sender: TObject);
var
  launcherID : Integer;
  WeaponOnShip : TWeaponGetList;

  id : Integer;
  isError : Boolean;

  PosH,PosP : Integer;

  mModel1ID,
  mModel2ID,
  mDof1ID,
  mDof2ID,
  mSwitchID : integer;
begin
  isError := False;

  if lvWeapon.Selected <> nil then
  begin
    if (TryStrToInt(edtWeaponLauncher.Text, launcherID)) then
    begin
      if launcherID = 0 then
      begin
        ShowMessage('Can Not Assign To Launcher 0');
        isError := True;
      end;

      if CekLauncherAvailable(aListView , launcherID) then
      begin
        if cb3DActor.Checked then
        begin
          if cbbModelBody.Text = '' then isError := True;
          if cbbModelSpout.Text = '' then isError := True;
          if cbbDOF_I.Text = '' then isError := True;
          if cbbDOF_II.Text = '' then isError := True;
          if cbbSwitch.Text = '' then isError := True;

          if cbbModelBody.ItemIndex = 0 then isError := True;
          if cbbModelSpout.ItemIndex = 0 then isError := True;
          if cbbDOF_I.ItemIndex = 0 then isError := True;
          if cbbDOF_II.ItemIndex = 0 then isError := True;
          if cbbSwitch.ItemIndex = 0 then isError := True;

          if not TryStrToInt(edtPosPitch.Text, PosP) then isError := True;
          if not TryStrToInt(edtPosHeading.Text, PosH) then isError := True;
        end
        else
        begin
          if not TryStrToInt(edtPosPitch.Text, PosP) then isError := True;
          if not TryStrToInt(edtPosHeading.Text, PosH) then isError := True;
        end;

        if not isError then
        begin
          WeaponOnShip := TWeaponGetList.Create;
          WeaponOnShip.ID := 0;
          WeaponOnShip.IDShip := shipID;
          WeaponOnShip.IDWeapon := StrToInt(lvWeapon.Selected.Caption);
          WeaponOnShip.IDDetail := launcherID;

          if cb3DActor.Checked then
          begin
            mModel1ID     := DataModule1.GetModelIDByName(cbbModelBody.Text);
            mModel2ID     := DataModule1.GetModelIDByName(cbbModelSpout.Text);
            mDof1ID       := DataModule1.GetDofIDByName(cbbDOF_I.Text);
            mDof2ID       := DataModule1.GetDofIDByName(cbbDOF_II.Text);
            mSwitchID     := DataModule1.GetSwitchIDByName(cbbSwitch.Text);

            WeaponOnShip.Is3DActor := 1;
          end
          else
          begin
            mModel1ID     := 0;
            mModel2ID     := 0;
            mDof1ID       := 0;
            mDof2ID       := 0;
            mSwitchID     := 0;

            WeaponOnShip.Is3DActor := 0;
          end;

          WeaponOnShip.IDModel1 := mModel1ID;
          WeaponOnShip.IDModel2 := mModel2ID;
          WeaponOnShip.IDDof1   := mDof1ID;
          WeaponOnShip.IDDof2   := mDof2ID;
          WeaponOnShip.IDSwitch := mSwitchID;
          WeaponOnShip.Pos_H    := PosH;
          WeaponOnShip.Pos_P    := PosP;

          DataModule1.SaveWeaponShip(WeaponOnShip);

          close;
        end
        else
        begin
          ShowMessage('Weapon List Not Correct');
        end;
      end
      else
      begin
        ShowMessage('Weapon Have Set In Selected Launcer');
      end;
    end
    else
    begin
      ShowMessage('Input Wrong');
    end;
  end;

  frmWeaponList.ShowWeapon;
end;

function TfrmAssignWeapon.CekLauncherAvailable(cListView: TListView;
  idLauncher: integer): boolean;
var
  i: Integer;
  isFound : Boolean;
  launcher : Integer;
begin
  Result := False;

  isFound := False;
  for i := 0 to aListView.Items.Count - 1 do
  begin
    launcher := StrToInt(aListView.Items[i].SubItems[1]);

    if (launcher = idLauncher) and (cListView.Items[i].Caption = lvWeapon.Selected.Caption) then
    begin
      isFound := True;
      Break;
    end;

  end;

  if not isFound then
    Result := True;
end;

procedure TfrmAssignWeapon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmWeaponList.ShowWeapon;
end;

procedure TfrmAssignWeapon.FormShow(Sender: TObject);
var
   ListWeapon : TList;
   Weapon : TShipWeapon;
   i : Integer;
begin
  GetAllTypeWeapon;
  GetALL_Dof_Model_Switch;
  ClearAllDetail;
end;

procedure TfrmAssignWeapon.GetAllTypeWeapon;
var
  ListTypeWeapon : TList;
  Weapon : TTypeWeapon;
  i : Integer;
begin
  try
    ListTypeWeapon := TList.Create;
    DataModule1.GetALLTypeWeapon(ListTypeWeapon);
    cbbWeaponType.Items.Clear;

    for i:=0 to ListTypeWeapon.Count -1 do
    begin
      Weapon := TTypeWeapon(ListTypeWeapon.Items[i]);
      cbbWeaponType.Items.Add(Weapon.Weapon_Name);
    end;

    if ListTypeWeapon.Count > 0 then
    begin
      cbbWeaponType.ItemIndex := 0;
      GetWeaponByType(cbbWeaponType.ItemIndex + 1)
    end; 

  finally
    ListTypeWeapon.Free;
  end
end;

procedure TfrmAssignWeapon.GetWeaponByType(TypeID: integer);
var
  ListWeapon : TList;
  Weapon : TShipWeapon;

  i : integer;
begin
  lvWeapon.Items.Clear;

  try
    ListWeapon := TList.Create;
    DataModule1.GetAllWeapon(ListWeapon);

    for i:=0 to ListWeapon.Count -1 do
    begin
      Weapon := TShipWeapon(ListWeapon.Items[i]);

      if Weapon.Weapon_Type = TypeID then
      begin
        with lvWeapon.Items.Add do
        begin
          Caption       := IntToStr(Weapon.Weapon_ID);
          SubItems.Add(weapon.Weapon_Name);
        end;

      end;
    end;

  finally
    ListWeapon.Free;
  end;
end;

procedure TfrmAssignWeapon.cbbWeaponTypeChange(Sender: TObject);
begin
  GetWeaponByType(cbbWeaponType.ItemIndex + 1);
  ClearAllDetail;
end;

procedure TfrmAssignWeapon.GetALL_Dof_Model_Switch;
var
  listModel,
  listDOF,
  ListSwitch : TList;

  mModel : TModel;
  mDOF : TDof;
  mSwitch : TSwitch;

  i : integer;
begin
  try
    cbbModelBody.Items.Clear;
    cbbModelSpout.Items.Clear;
    cbbDOF_I.Items.Clear;
    cbbDOF_II.Items.Clear;
    cbbSwitch.Items.Clear;

    listModel   := TList.Create;
    listDOF     := TList.Create;
    ListSwitch  := TList.Create;

    DataModule1.GetAllModel3D(listModel);
    DataModule1.GetAllDOF3D(listDOF);
    DataModule1.GetAllSwitch(ListSwitch);

    cbbModelBody.Items.Add('Empty');
    cbbModelSpout.Items.Add('Empty');
    for i:= 0 to listModel.Count-1 do
    begin
      mModel := TModel(listModel.Items[i]);

      if mModel.TIPE = 1 then continue;

      cbbModelBody.Items.Add(mModel.Nama);
      cbbModelSpout.Items.Add(mModel.Nama);
    end;

    cbbDOF_I.Items.Add('Empty');
    cbbDOF_II.Items.Add('Empty');
    for i:= 0 to listDOF.Count-1 do
    begin
      mDOF := TDof(listDOF.Items[i]);
      cbbDOF_I.Items.Add(mDOF.Nama);
      cbbDOF_II.Items.Add(mDOF.Nama);
    end;

    cbbSwitch.Items.Add('Empty');
    for i:= 0 to ListSwitch.Count-1 do
    begin
      mSwitch := TSwitch(ListSwitch.Items[i]);
      cbbSwitch.Items.Add(mSwitch.Nama);
    end;
  finally
    listModel.Free;
    listDOF.Free;
    ListSwitch.Free;
  end;

end;

procedure TfrmAssignWeapon.cb3DActorClick(Sender: TObject);
begin
  if not cb3DActor.Checked then
  begin
    cbbModelBody.ItemIndex := 0;
    cbbModelSpout.ItemIndex := 0;
    cbbDOF_I.ItemIndex := 0;
    cbbDOF_II.ItemIndex := 0;
    cbbSwitch.ItemIndex := 0;
  end;
end;

procedure TfrmAssignWeapon.lvWeaponClick(Sender: TObject);
begin
  if lvWeapon.Selected <> nil then
  begin
    ClearAllDetail;
  end;
end;

procedure TfrmAssignWeapon.ClearAllDetail;
begin
  cbbModelBody.ItemIndex := 0;
  cbbModelSpout.ItemIndex := 0;
  cbbDOF_I.ItemIndex := 0;
  cbbDOF_II.ItemIndex := 0;
  cbbSwitch.ItemIndex := 0;
  edtPosPitch.Text := '0';
  edtPosHeading.Text := '0';
  edtWeaponLauncher.Text := '0';
  cb3DActor.Checked := False;
end;

end.
