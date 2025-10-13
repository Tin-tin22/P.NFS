unit ufWeaponList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, AdvSmoothButton

  , uDataModule, uClassDatabase;

type
  TfrmWeaponList = class(TForm)
    pnlMain: TPanel;
    lbl1: TLabel;
    edtShipName: TEdit;
    btnClose: TAdvSmoothButton;
    lvWeaponSelect: TListView;
    btnAddweapon: TAdvSmoothButton;
    btnRemove: TAdvSmoothButton;
    btnAddMissile: TAdvSmoothButton;
    btnEditWeapon: TAdvSmoothButton;
    pnlShow: TPanel;
    pnlDetail: TPanel;
    pnlEdit: TPanel;
    edtSwitch: TEdit;
    lbl8: TLabel;
    lbl2: TLabel;
    edt3DActor: TEdit;
    edtPosHeading: TEdit;
    edtPosPitch: TEdit;
    lbl10: TLabel;
    lbl9: TLabel;
    edtDOF1: TEdit;
    edtDOF2: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    edtModelSpout: TEdit;
    lbl7: TLabel;
    lbl4: TLabel;
    edtModelBody: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtUpdatePitch: TEdit;
    edtUpdateHeading: TEdit;
    btnUpdate: TAdvSmoothButton;
    cbbModelBody: TComboBox;
    cbbModelSpout: TComboBox;
    cbbDOF_I: TComboBox;
    cbbDOF_II: TComboBox;
    cbbSwitch: TComboBox;
    cb3DActor: TCheckBox;
    lbl3: TLabel;
    edtLauncher: TEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddweaponClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvWeaponSelectClick(Sender: TObject);
    procedure btnAddMissileClick(Sender: TObject);
    procedure btnEditWeaponClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cb3DActorClick(Sender: TObject);
  private
    { Private declarations }
  public
    Ship_Name : string;
    Ship_ID : Integer;

    procedure ShowWeapon;
    procedure ClearAllDetail;
    procedure GetALL_Dof_Model_Switch;
    function CekLauncherAvailable(cListView: TListView; idLauncher: integer): boolean;

    { Public declarations }
  end;

var
  frmWeaponList: TfrmWeaponList;

implementation

uses ufassignweapon, ufassignmissile;

{$R *.dfm}

procedure TfrmWeaponList.btnAddweaponClick(Sender: TObject);
begin
  frmAssignWeapon.shipID        := Ship_ID;
  frmAssignWeapon.aListView     := lvWeaponSelect;
  frmAssignWeapon.Show;
end;

function TfrmWeaponList.CekLauncherAvailable(cListView: TListView;
  idLauncher: integer): boolean;
var
  i: Integer;
  isFound : Boolean;
  launcher : Integer;
begin
  Result := False;

  isFound := False;
  for i := 0 to cListView.Items.Count - 1 do
  begin
    launcher := StrToInt(cListView.Items[i].SubItems[1]);

    if (launcher = idLauncher) and (cListView.Items[i].Caption = lvWeaponSelect.Selected.Caption) then
    begin
      isFound := True;
      Break;
    end;

  end;

  if not isFound then
    Result := True;
end;

procedure TfrmWeaponList.btnEditWeaponClick(Sender: TObject);
var
  IDweapon,
  IDDetail : Integer;

  i : integer;
  WeaponOnShip : TWeaponGetList;

  ListWeaponOnShip : TList;
begin
  if lvWeaponSelect.Selected <> nil then
  begin
     pnlEdit.BringToFront;

     IDweapon := StrToInt(lvWeaponSelect.Selected.Caption);
     IDDetail := StrToInt(lvWeaponSelect.Selected.SubItems[1]);

     try
       ListWeaponOnShip := TList.Create;
       DataModule1.GetListWeaponOnShip(Ship_ID, ListWeaponOnShip);

       for i:= 0 to ListWeaponOnShip.Count-1 do
       begin
         WeaponOnShip := TWeaponGetList(ListWeaponOnShip.Items[i]);

         if (WeaponOnShip.IDShip = Ship_ID) and
         (WeaponOnShip.IDWeapon = IDweapon) and
         (WeaponOnShip.IDDetail = IDDetail) then
         begin
           if cbbModelBody.Items.IndexOf(
                           DataModule1.GetModelNameByID(
                           WeaponOnShip.IDModel1)) <> -1 then
           begin
             cbbModelBody.ItemIndex := cbbModelBody.Items.IndexOf(
                                       DataModule1.GetModelNameByID(
                                       WeaponOnShip.IDModel1))
           end;

           if cbbModelSpout.Items.IndexOf(
                           DataModule1.GetModelNameByID(
                           WeaponOnShip.IDModel2)) <> -1 then
           begin
             cbbModelSpout.ItemIndex := cbbModelBody.Items.IndexOf(
                                        DataModule1.GetModelNameByID(
                                        WeaponOnShip.IDModel2))
           end;

           if cbbDOF_I.Items.IndexOf(
                           DataModule1.GetDOFNameByID(
                           WeaponOnShip.IDDof1)) <> -1 then
           begin
             cbbDOF_I.ItemIndex := cbbDOF_I.Items.IndexOf(
                                   DataModule1.GetDOFNameByID(
                                   WeaponOnShip.IDDof1))
           end;

           if cbbDOF_II.Items.IndexOf(
                           DataModule1.GetDOFNameByID(
                           WeaponOnShip.IDDof2)) <> -1 then
           begin
             cbbDOF_II.ItemIndex := cbbDOF_II.Items.IndexOf(
                                    DataModule1.GetDOFNameByID(
                                    WeaponOnShip.IDDof2))
           end;

           if cbbSwitch.Items.IndexOf(
                           DataModule1.GetswitchNameByID(
                           WeaponOnShip.IDSwitch)) <> -1 then
           begin
             cbbSwitch.ItemIndex := cbbSwitch.Items.IndexOf(
                                    DataModule1.GetswitchNameByID(
                                    WeaponOnShip.IDSwitch))
           end;

           edtUpdateHeading.Text := IntToStr(WeaponOnShip.Pos_H);
           edtUpdatePitch.Text   := IntToStr(WeaponOnShip.Pos_P);
           edtLauncher.Text      := IntToStr(WeaponOnShip.IDDetail);

           case WeaponOnShip.Is3DActor of
              0 : cb3DActor.Checked := False;
              1 : cb3DActor.Checked := true;
           end;

           Break;
         end;

       end;
     finally
       ListWeaponOnShip.Free;
     end;
  end;
end;

procedure TfrmWeaponList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmWeaponList.btnRemoveClick(Sender: TObject);
begin
  if lvWeaponSelect.Selected <> nil then
  begin
    DataModule1.DeleteWeaponShip(Ship_ID,
                                 StrToInt(lvWeaponSelect.Selected.caption),
                                 StrToInt(lvWeaponSelect.Selected.SubItems[1]),
                                 StrToInt(lvWeaponSelect.Selected.SubItems[2]));

    ShowWeapon;
    ClearAllDetail;
  end
  else
  begin
    ShowMessage('Select Weapon First');
  end;
end;

procedure TfrmWeaponList.ClearAllDetail;
begin
  edtPosPitch.Text := '';
  edtPosHeading.Text := '';
  edtModelBody.Text := '';
  edtModelSpout.Text := '';
  edtDOF1.Text := '';
  edtDOF2.Text := '';
  edtSwitch.Text := '';
  edt3DActor.Text := '';

  cbbModelBody.ItemIndex := 0;
  cbbModelSpout.ItemIndex := 0;
  cbbDOF_I.ItemIndex := 0;
  cbbDOF_II.ItemIndex := 0;
  cbbSwitch.ItemIndex := 0;
  
  edtLauncher.Text := '0';
  edtUpdateHeading.Text := '0';
  edtUpdatePitch.Text := '0';

  pnlDetail.BringToFront;
end;

procedure TfrmWeaponList.FormShow(Sender: TObject);
begin
  ShowWeapon;
  GetALL_Dof_Model_Switch;
end;

procedure TfrmWeaponList.ShowWeapon;
var
  ListWeaponOnShip : TList;
  WeaponOnShip : TWeaponGetList;

  i: Integer;
begin
  edtShipName.Text := Ship_Name;

  lvWeaponSelect.Items.Clear;
  ListWeaponOnShip := TList.Create;

  ClearAllDetail;

  DataModule1.GetListWeaponOnShip(Ship_ID, ListWeaponOnShip);

  for i := 0 to ListWeaponOnShip.Count - 1 do
  begin
    WeaponOnShip := TWeaponGetList(ListWeaponOnShip[i]);

    with lvWeaponSelect.Items.Add do
    begin
      Caption := IntToStr(WeaponOnShip.IDWeapon);
      SubItems.Add(DataModule1.GetNameWeaponByID(WeaponOnShip.IDWeapon));
      SubItems.Add(IntToStr(WeaponOnShip.IDDetail));
      SubItems.Add(IntToStr(WeaponOnShip.ID));
    end;
  end;
end;

procedure TfrmWeaponList.lvWeaponSelectClick(Sender: TObject);
var
 ListWeaponOnShip : TList;
 WeaponOnShip : TWeaponGetList;

 IDweapon,
 IDDetail : Integer;

 i : Integer;
begin
  if lvWeaponSelect.Selected = nil then
  begin
    ClearAllDetail;
    Exit;
  end;

  ClearAllDetail;

  IDweapon := StrToInt(lvWeaponSelect.Selected.Caption);
  IDDetail := StrToInt(lvWeaponSelect.Selected.SubItems[1]);

  try
    ListWeaponOnShip := TList.Create;
    DataModule1.GetListWeaponOnShip(Ship_ID, ListWeaponOnShip);

    for i:= 0 to ListWeaponOnShip.Count-1 do
    begin
      WeaponOnShip := TWeaponGetList(ListWeaponOnShip.Items[i]);

      if (WeaponOnShip.IDShip = Ship_ID) and
         (WeaponOnShip.IDWeapon = IDweapon) and
         (WeaponOnShip.IDDetail = IDDetail) then
      begin
        edtModelBody.Text   := DataModule1.GetModelNameByID(WeaponOnShip.IDModel1);
        edtModelSpout.Text  := DataModule1.GetModelNameByID(WeaponOnShip.IDModel2);
        edtDOF1.Text        := DataModule1.GetDOFNameByID(WeaponOnShip.IDDof1);
        edtDOF2.Text        := DataModule1.GetDOFNameByID(WeaponOnShip.IDDof2);
        edtSwitch.Text      := DataModule1.GetSwitchNameByID(WeaponOnShip.IDSwitch);
        edtPosPitch.Text    := IntToStr(WeaponOnShip.Pos_P);
        edtPosHeading.Text  := IntToStr(WeaponOnShip.Pos_H);

        case WeaponOnShip.Is3DActor of
          0 : edt3DActor.Text := 'NO';
          1 : edt3DActor.Text := 'YES';
        end;

        Break;
      end;
    end;
  finally
    ListWeaponOnShip.Free;
  end;
end;

procedure TfrmWeaponList.btnAddMissileClick(Sender: TObject);
begin
  if lvWeaponSelect.Selected <> nil then
  begin
    frmAssignMisille.ShipID := Ship_ID;
    frmAssignMisille.WeaponID       := StrToInt(lvWeaponSelect.Selected.Caption);
    frmAssignMisille.LauncherID     := StrToInt(lvWeaponSelect.Selected.SubItems[1]);
    frmAssignMisille.WeaponIDNumber := StrToInt(lvWeaponSelect.Selected.SubItems[2]);

    frmAssignMisille.Show;
  end
  else
  begin
    ShowMessage('Select Weapon First');
  end;

end;

procedure TfrmWeaponList.GetALL_Dof_Model_Switch;
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

procedure TfrmWeaponList.btnUpdateClick(Sender: TObject);
var
  isvalid,
  isError,
  isAvailableLauncher : Boolean;

  WeaponOnShip : TWeaponGetList;

  launcherID : Integer;

  PosH,PosP : Integer;

  mModel1ID,
  mModel2ID,
  mDof1ID,
  mDof2ID,
  mSwitchID : integer;
begin
  if lvWeaponSelect.Selected <> nil then
  begin
    isvalid := True;
    isError := false;
    isAvailableLauncher := True;

    if (TryStrToInt(edtLauncher.Text, launcherID)) then
    begin
      if launcherID = 0 then
      begin
        ShowMessage('Can Not Assign To Launcher 0');
        isError := True;
      end;

      if launcherID <> StrToInt(lvWeaponSelect.Selected.SubItems[1]) then
        isAvailableLauncher := CekLauncherAvailable(lvWeaponSelect , launcherID);

      if isAvailableLauncher then
      begin
        if cb3DActor.Checked then
        begin
          if cbbModelBody.ItemIndex = 0 then isError := True;
          if cbbModelSpout.ItemIndex = 0 then isError := True;
          if cbbDOF_I.ItemIndex = 0 then isError := True;
          if cbbDOF_II.ItemIndex = 0 then isError := True;
          if cbbSwitch.ItemIndex = 0 then isError := True;

          if not TryStrToInt(edtUpdatePitch.Text, PosP) then isError := True;
          if not TryStrToInt(edtUpdateHeading.Text, PosH) then isError := True;
        end
        else
        begin
          if not TryStrToInt(edtUpdatePitch.Text, PosP) then isError := True;
          if not TryStrToInt(edtUpdateHeading.Text, PosH) then isError := True;
        end;

        if not isError then
        begin
          WeaponOnShip := TWeaponGetList.Create;
          WeaponOnShip.ID := 0;
          WeaponOnShip.IDShip := Ship_ID;
          WeaponOnShip.IDWeapon := StrToInt(lvWeaponSelect.Selected.Caption);
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

          DataModule1.UpdateWeaponShip(WeaponOnShip,
                                       StrToInt(lvWeaponSelect.Selected.SubItems[2]));

          ShowWeapon;
          ClearAllDetail;
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
end;

procedure TfrmWeaponList.cb3DActorClick(Sender: TObject);
begin
  if not cb3DActor.Checked then
  begin
    cbbModelBody.ItemIndex  := 0;
    cbbModelSpout.ItemIndex := 0;
    cbbDOF_I.ItemIndex := 0;
    cbbDOF_II.ItemIndex := 0;
    cbbSwitch.ItemIndex := 0;
  end;
end;

end.
