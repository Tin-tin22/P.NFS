unit ufWeaponList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, AdvSmoothButton

  , uDataModule, uClassDatabase, AdvSmoothLabel, CurvyControls,
  AdvSmoothPanel, AdvSmoothTabPager, jpeg;

type
  TfrmWeaponList = class(TForm)
    TabSelection: TAdvSmoothTabPager;
    tsShipKRI: TAdvSmoothTabPage;
    tsShipTarget: TAdvSmoothTabPage;
    pnlMainUp: TAdvSmoothPanel;
    lblShipName: TAdvSmoothLabel;
    advsmthlbl1: TAdvSmoothLabel;
    advsmthlbl2: TAdvSmoothLabel;
    lvWeaponSelect: TListView;
    edtShipName: TCurvyEdit;
    btnRemove: TAdvSmoothButton;
    btnAddWeapon: TAdvSmoothButton;
    btnAddMissile: TAdvSmoothButton;
    pnl3DRelated: TAdvSmoothPanel;
    pnlEdit: TAdvSmoothPanel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    AdvSmoothLabel3: TAdvSmoothLabel;
    AdvSmoothLabel4: TAdvSmoothLabel;
    AdvSmoothLabel5: TAdvSmoothLabel;
    AdvSmoothLabel6: TAdvSmoothLabel;
    AdvSmoothLabel7: TAdvSmoothLabel;
    AdvSmoothLabel8: TAdvSmoothLabel;
    AdvSmoothLabel9: TAdvSmoothLabel;
    AdvSmoothLabel10: TAdvSmoothLabel;
    edtUpdatePitch: TEdit;
    edtUpdateHeading: TEdit;
    edtLauncher: TEdit;
    cbbSwitch: TComboBox;
    cbbModelSpout: TComboBox;
    cbbModelBody: TComboBox;
    cbbDOF_II: TComboBox;
    cbbDOF_I: TComboBox;
    cb3DActor: TCheckBox;
    pnlDetail: TAdvSmoothPanel;
    AdvSmoothLabel1: TAdvSmoothLabel;
    advsmthlbl3: TAdvSmoothLabel;
    advsmthlbl4: TAdvSmoothLabel;
    advsmthlbl5: TAdvSmoothLabel;
    advsmthlbl6: TAdvSmoothLabel;
    advsmthlbl7: TAdvSmoothLabel;
    advsmthlbl8: TAdvSmoothLabel;
    advsmthlbl9: TAdvSmoothLabel;
    edtSwitch: TEdit;
    edt3DActor: TEdit;
    edtPosHeading: TEdit;
    edtPosPitch: TEdit;
    edtDOF1: TEdit;
    edtDOF2: TEdit;
    edtModelBody: TEdit;
    edtModelSpout: TEdit;
    btnEditWeapon: TAdvSmoothButton;
    pnl2DRelated: TAdvSmoothPanel;
    advsmthlbl10: TAdvSmoothLabel;
    advsmthlbl11: TAdvSmoothLabel;
    advsmthlbl12: TAdvSmoothLabel;
    AdvSmoothLabel11: TAdvSmoothLabel;
    AdvSmoothLabel12: TAdvSmoothLabel;
    lvDetail: TListView;
    btnAddDetail: TAdvSmoothButton;
    edtDetailName: TEdit;
    edtStartDegree: TEdit;
    edtEndDegree: TEdit;
    edtMinRange: TEdit;
    edtMaxRange: TEdit;
    btnRemoveDetail: TAdvSmoothButton;
    btnUpdate: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    AdvSmoothLabel13: TAdvSmoothLabel;
    AdvSmoothLabel15: TAdvSmoothLabel;
    imgShip: TImage;
    CurvyEdit1: TCurvyEdit;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothLabel16: TAdvSmoothLabel;
    AdvSmoothLabel18: TAdvSmoothLabel;
    AdvSmoothLabel20: TAdvSmoothLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    AdvSmoothPanel3: TAdvSmoothPanel;
    AdvSmoothLabel25: TAdvSmoothLabel;
    AdvSmoothLabel27: TAdvSmoothLabel;
    Edit14: TEdit;
    Edit16: TEdit;
    btnSetPosition: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    CurvyEdit2: TCurvyEdit;
    AdvSmoothLabel14: TAdvSmoothLabel;
    Edit2: TEdit;
    AdvSmoothLabel17: TAdvSmoothLabel;
    Edit1: TEdit;
    AdvSmoothLabel19: TAdvSmoothLabel;
    AdvSmoothLabel21: TAdvSmoothLabel;
    AdvSmoothLabel23: TAdvSmoothLabel;
    AdvSmoothLabel24: TAdvSmoothLabel;
    AdvSmoothLabel26: TAdvSmoothLabel;
    AdvSmoothLabel28: TAdvSmoothLabel;
    AdvSmoothLabel29: TAdvSmoothLabel;
    AdvSmoothButton2: TAdvSmoothButton;
    pnlPicture1: TAdvSmoothPanel;
    edtShipRudderSwingRate: TEdit;
    AdvSmoothLabel22: TAdvSmoothLabel;
    edtShipThrottleRate: TEdit;
    AdvSmoothLabel30: TAdvSmoothLabel;
    edtShipDisplacement: TEdit;
    AdvSmoothLabel31: TAdvSmoothLabel;
    edtShipTrimFactor: TEdit;
    AdvSmoothLabel32: TAdvSmoothLabel;
    AdvSmoothLabel33: TAdvSmoothLabel;
    edtShipTacDiameter: TEdit;
    edtShipShaftUp: TEdit;
    AdvSmoothLabel34: TAdvSmoothLabel;
    AdvSmoothLabel35: TAdvSmoothLabel;
    edtShipHeelFactor: TEdit;
    procedure btnAddweaponClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvWeaponSelectClick(Sender: TObject);
    procedure btnAddMissileClick(Sender: TObject);
    procedure btnEditWeaponClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cb3DActorClick(Sender: TObject);
    procedure btnRemoveDetailClick(Sender: TObject);
    procedure btnAddDetailClick(Sender: TObject);
    procedure tbSeaSpeedChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TrackBar1Change(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure getVehicleProperties;
    procedure btnSetPositionClick(Sender: TObject);
    procedure ToClose;
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

uses ufassignweapon, ufassignmissile, Math;

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
     btnUpdate.Visible := True;

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
  edtPosPitch.Text    := '';
  edtPosHeading.Text  := '';
  edtModelBody.Text   := '';
  edtModelSpout.Text  := '';
  edtDOF1.Text        := '';
  edtDOF2.Text        := '';
  edtSwitch.Text      := '';
  edt3DActor.Text     := '';

  cbbModelBody.ItemIndex  := 0;
  cbbModelSpout.ItemIndex := 0;
  cbbDOF_I.ItemIndex      := 0;
  cbbDOF_II.ItemIndex     := 0;
  cbbSwitch.ItemIndex     := 0;

  edtLauncher.Text        := '0';
  edtUpdateHeading.Text   := '0';
  edtUpdatePitch.Text     := '0';

  btnUpdate.Visible       := false;

  edtDetailName.Text  := '';
  edtStartDegree.Text := '';
  edtEndDegree.Text   := '';
  edtMinRange.Text    := '';
  edtMaxRange.Text    := '';

  lvDetail.Items.Clear;
  pnlDetail.BringToFront;
end;

procedure TfrmWeaponList.FormShow(Sender: TObject);
begin
  ShowWeapon;
  GetALL_Dof_Model_Switch;
  getVehicleProperties;
end;

procedure TfrmWeaponList.ShowWeapon;
var
  ListWeaponOnShip : TList;
  WeaponOnShip : TWeaponGetList;
  i: Integer;
  strPicture : string;
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
 WeaponOnShip     : TWeaponGetList;

 ListWeaponDetail : Tlist;
 WeaponDetail     : TWeaponDetail;

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
    ListWeaponDetail := TList.Create;

    DataModule1.GetListWeaponOnShip(Ship_ID, ListWeaponOnShip);
    DataModule1.GetListWeaponRangeDetail(Ship_ID, IDweapon, IDDetail,  ListWeaponDetail);

    for i:= 0 to ListWeaponOnShip.Count-1 do
    begin
      WeaponOnShip := TWeaponGetList(ListWeaponOnShip.Items[i]);

      if (WeaponOnShip.IDShip = Ship_ID) and
         (WeaponOnShip.IDWeapon = IDweapon) and
         (WeaponOnShip.IDDetail = IDDetail)
      then
      begin
        edtModelBody.Text   := DataModule1.GetModelNameByID(WeaponOnShip.IDModel1);
        edtModelSpout.Text  := DataModule1.GetModelNameByID(WeaponOnShip.IDModel2);
        edtDOF1.Text        := DataModule1.GetDOFNameByID(WeaponOnShip.IDDof1);
        edtDOF2.Text        := DataModule1.GetDOFNameByID(WeaponOnShip.IDDof2);
        edtSwitch.Text      := DataModule1.GetSwitchNameByID(WeaponOnShip.IDSwitch);
        edtPosPitch.Text    := IntToStr(WeaponOnShip.Pos_P);
        edtPosHeading.Text  := IntToStr(WeaponOnShip.Pos_H);
        Edit2.Text := FloatToStr(DataModule1.GetLethalityByID(IDweapon));
        case WeaponOnShip.Is3DActor of
          0 : edt3DActor.Text := 'NO';
          1 : edt3DActor.Text := 'YES';
        end;

        Break;
      end;
    end;

    for i := 0 to ListWeaponDetail.Count - 1 do
    begin
      WeaponDetail := TWeaponDetail(ListWeaponDetail.Items[i]);

      with lvDetail.Items.Add do
      begin
        Caption := IntToStr(WeaponDetail.IDType);
        SubItems.Add(WeaponDetail.DetName);
        SubItems.Add(FloatToStr(WeaponDetail.StartAngle));
        SubItems.Add(FloatToStr(WeaponDetail.EndAngle));
        SubItems.Add(FloatToStr(WeaponDetail.LowRange));
        SubItems.Add(FloatToStr(WeaponDetail.HighRange));

      end;
    end;
  finally
    ListWeaponOnShip.Free;
    ListWeaponDetail.Free;
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

procedure TfrmWeaponList.btnRemoveDetailClick(Sender: TObject);
var
  WeaponDetail : TWeaponDetail;
begin
  if (lvDetail.Selected <> nil) and
     (lvWeaponSelect.Selected <> nil)
  then
  begin
    try
      WeaponDetail := TWeaponDetail.Create;
      WeaponDetail.IDShip       := Ship_ID;
      WeaponDetail.IDWeapon     := StrToInt(lvWeaponSelect.Selected.caption);
      WeaponDetail.IDType       := StrToInt(lvDetail.Selected.Caption);
      WeaponDetail.IDLauncher   := StrToInt(lvWeaponSelect.Selected.SubItems[1]);

      DataModule1.DeleteDetailWeapon(WeaponDetail);

      ClearAllDetail;
      ShowWeapon;
    finally
      WeaponDetail.Free;
    end;
  end;
end;

procedure TfrmWeaponList.btnAddDetailClick(Sender: TObject);
var
  WeaponDetail : TWeaponDetail;

  StartDregree,
  EndDegree,
  MinRange,
  MaxRange : Double;

  isValid : Boolean;
begin
  if lvWeaponSelect.Selected <> nil then
  begin
    isValid := True;

    try
      WeaponDetail := TWeaponDetail.Create;

      if not TryStrToFloat(edtStartDegree.Text, StartDregree) then isValid := false;
      if not TryStrToFloat(edtEndDegree.Text,   EndDegree)    then isValid := false;
      if not TryStrToFloat(edtMinRange.Text,    MinRange)     then isValid := false;
      if not TryStrToFloat(edtMaxRange.Text,    MaxRange)     then isValid := false;

      if isValid then
      begin
        WeaponDetail.DetName    := edtDetailName.Text;
        WeaponDetail.IDShip     := Ship_ID;
        WeaponDetail.IDWeapon   := StrToInt(lvWeaponSelect.Selected.Caption);
        WeaponDetail.IDLauncher := StrToInt(lvWeaponSelect.Selected.SubItems[1]);

        if lvDetail.Items.Count > 0 then WeaponDetail.IDType := StrToInt(lvDetail.Items[lvDetail.Items.Count -1].Caption) + 1
        else WeaponDetail.IDType   := 1;

        WeaponDetail.StartAngle := StartDregree;
        WeaponDetail.EndAngle   := EndDegree;
        WeaponDetail.LowRange   := MinRange;
        WeaponDetail.HighRange  := MaxRange;


        DataModule1.AddDetailWeapon(WeaponDetail);

        ClearAllDetail;
        ShowWeapon;
      end;
    finally
      WeaponDetail.Free;
    end
  end;
end;

procedure TfrmWeaponList.tbSeaSpeedChange(Sender: TObject);
begin
  edit1.Text := IntToStr((sender as TTrackBar).Position);
end;

procedure TfrmWeaponList.Edit1Change(Sender: TObject);
begin
  if (Edit1.Text <> '') then
  begin
    try
    except
      on E : Exception do Exit;
    end;
  end;
end;

procedure TfrmWeaponList.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  tmpFloat : Double;
begin

  if not (Key in[#48 .. #57, #8, #13, #46]) then
    Key := #0;

  if key = #13 then
    Edit1.Text := FormatFloat('0.00', StrToFloat(Edit1.Text));
end;

procedure TfrmWeaponList.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Edit1.Text = '' then
    Exit;

   if (StrToFloat(Edit1.Text) > 200)  then
    begin
      ShowMessage('Incorrect value');
      Edit1.Text := '200';
    end;
end;

procedure TfrmWeaponList.AdvSmoothButton1Click(Sender: TObject);
begin
 // ToClose;
  Close;
end;

procedure TfrmWeaponList.Edit2Change(Sender: TObject);
begin
  if (Edit2.Text <> '') then
  begin
    try
      // TrackBar1.Position := StrToInt(Edit2.Text);
    except
      on E : Exception do Exit;
    end;
  end;
end;

procedure TfrmWeaponList.Edit2KeyPress(Sender: TObject; var Key: Char);
var
  tmpFloat : Double;
begin

  if not (Key in[#48 .. #57, #8, #13, #46]) then
    Key := #0;

  if key = #13 then
    Edit2.Text := FormatFloat('0.00', StrToFloat(Edit2.Text));
end;

procedure TfrmWeaponList.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Edit2.Text = '' then
    Exit;

   if (StrToFloat(Edit2.Text) > 100)  then
    begin
      ShowMessage('Incorrect value');
      Edit2.Text := '100';
    end;
end;
procedure TfrmWeaponList.TrackBar1Change(Sender: TObject);
begin
  edit2.Text := IntToStr((sender as TTrackBar).Position);
end;

procedure TfrmWeaponList.AdvSmoothButton2Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmWeaponList.getVehicleProperties;
var
  aVec : TVehicle;
begin
  CurvyEdit2.Text :=  Ship_Name;
  CurvyEdit1.Text := DataModule1.IDclassbyName(Ship_ID);
  Edit7.Text := FloatToStr(DataModule1.GetShipDemensiLENGTHByID(Ship_ID));
  Edit5.Text := FloatToStr(DataModule1.GetShipDemensiWIDTHByID(Ship_ID));
  Edit4.Text := FloatToStr(DataModule1.GetShipDemensiHEIGHTByID(Ship_ID));
  Edit16.Text := FloatToStr(DataModule1.GetShipMaxSpeed(Ship_ID));
  Edit14.Text := FloatToStr(DataModule1.GetShipMinSpeed(Ship_ID));
  Edit1.Text := FloatToStr(DataModule1.GetShipDamageByID(Ship_ID));
  Edit2.Text := '';

  aVec := DataModule1.GetVehicleProperties(Ship_ID);

  edtShipRudderSwingRate.Text := FloatToStr(aVec.Vehicle_RudderSwingRate);
  edtShipThrottleRate.Text := FloatToStr(aVec.Vehicle_ThrottleRate);
  edtShipDisplacement.Text := FloatToStr(aVec.Vehicle_Displacement);
  edtShipHeelFactor.Text := FloatToStr(aVec.Vehicle_HeelFactor);
  edtShipShaftUp.Text := FloatToStr(aVec.Vehicle_ShaftUp);
  edtShipTacDiameter.Text := FloatToStr(aVec.Vehicle_TacDiameter);
  edtShipTrimFactor.Text := FloatToStr(aVec.Vehicle_TrimFactor);

end;

procedure TfrmWeaponList.btnSetPositionClick(Sender: TObject);
var vehicle : TVehicle;
begin
  with vehicle do begin
    vehicle                 := TVehicle.Create;
    Vehicle_LENGTH          := StrToFloat(Edit7.Text);
    Vehicle_WIDTH           := StrToFloat(Edit5.Text);
    Vehicle_HEIGHT          := StrToFloat(Edit4.Text);
    Vehicle_SUSTAINABILITY  := StrToFloat(Edit1.Text);
    Vehicle_Maxspeed        := StrToFloat(Edit16.Text);
    Vehicle_Minspeed        := StrToFloat(Edit14.Text);

    Vehicle_RudderSwingRate := StrToFloat(edtShipRudderSwingRate.Text);
    Vehicle_ThrottleRate    := StrToFloat(edtShipThrottleRate.Text);
    Vehicle_Displacement    := StrToFloat(edtShipDisplacement.Text);
    Vehicle_HeelFactor      := StrToFloat(edtShipHeelFactor.Text);
    Vehicle_ShaftUp         := StrToFloat(edtShipShaftUp.Text);
    Vehicle_TacDiameter     := StrToFloat(edtShipTacDiameter.Text);
    Vehicle_TrimFactor      := StrToFloat(edtShipTrimFactor.Text);
  end;
  DataModule1.UpdateShipEditor(Ship_ID,vehicle);
 // ToClose;
  close;
end;

procedure TfrmWeaponList.ToClose;
begin
  Edit7.Enabled := False;
  Edit4.Enabled := False;
  Edit5.Enabled := False;
  Edit1.Enabled := False;
  Edit14.Enabled := False;
  Edit16.Enabled := False;
end;

end.
