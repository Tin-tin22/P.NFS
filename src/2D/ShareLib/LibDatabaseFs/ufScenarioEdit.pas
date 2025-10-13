unit ufScenarioEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Math

  ,ufWeaponList, ufListScenario, uClassDatabase, uDataModule, uInstrukturManager,
  uInstrukturObjects, uSimulationManager, uBaseConstan, AdvPageControl,
  AdvSmoothButton, Menus, AdvListV;

type
  TfrmSceEditor = class(TForm)
    pnlMain: TPanel;
    lbl1: TLabel;
    mmoKetSce: TMemo;
    lbl2: TLabel;
    edtScenarioName: TEdit;
    pgcShip: TAdvPageControl;
    tsGeneralShip: TAdvTabSheet;
    tsWarShip: TAdvTabSheet;
    lvWarShipAll: TListView;
    lvWarShipSelect: TListView;
    Port: TLabel;
    cbbPort: TComboBox;
    lvGeneralShipAll: TListView;
    lvGeneralShipSelect: TListView;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    pnlShipPicture: TPanel;
    imgShip: TImage;
    btnAddWarShip: TAdvSmoothButton;
    btnRemoveWarShip: TAdvSmoothButton;
    btnAddGnrShip: TAdvSmoothButton;
    btnRemoveGnrShip: TAdvSmoothButton;
    btnSaveScenario: TAdvSmoothButton;
    btnClose: TAdvSmoothButton;
    btnPortMore: TAdvSmoothButton;
    btnEditDatabase: TAdvSmoothButton;
    btnSetPosition: TAdvSmoothButton;
    tsConsoleList: TAdvTabSheet;
    lbl7: TLabel;
    lvConsole: TListView;
    pmConsole: TPopupMenu;
    btnWeaponList: TAdvSmoothButton;
    lvWeaponSelected: TListView;
    btnEnableWeapon: TAdvSmoothButton;
    lbl8: TLabel;
    btnShipEditor: TAdvSmoothButton;
    pmConsole2: TPopupMenu;
    procedure btnWeaponListClick(Sender: TObject);
    procedure btnEditDatabaseClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lvWarShipAllSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvWarShipSelectSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvWarShipAllClick(Sender: TObject);
    procedure lvWarShipSelectClick(Sender: TObject);
    procedure lvGeneralShipAllClick(Sender: TObject);
    procedure lvGeneralShipSelectClick(Sender: TObject);
    procedure btnAddWarShipClick(Sender: TObject);
    procedure btnRemoveWarShipClick(Sender: TObject);
    procedure lvWarShipSelectCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvWarShipAllCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvWarShipAllDblClick(Sender: TObject);
    procedure lvWarShipSelectDblClick(Sender: TObject);
    procedure btnSetPositionClick(Sender: TObject);
    procedure btnSaveScenarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPortMoreClick(Sender: TObject);
    procedure cbbPortCloseUp(Sender: TObject);
    procedure lvGeneralShipAllSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvGeneralShipAllCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvGeneralShipAllDblClick(Sender: TObject);
    procedure btnAddGnrShipClick(Sender: TObject);
    procedure btnRemoveGnrShipClick(Sender: TObject);
    procedure lvGeneralShipSelectCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lvGeneralShipSelectSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvGeneralShipSelectDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pnlMainClick(Sender: TObject);
    procedure lvConsoleDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEnableWeaponClick(Sender: TObject);
    procedure lvWeaponSelectedClick(Sender: TObject);
    procedure lvConsoleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Ship_ID : Integer;
    Ship_Name : string;
    { Private declarations }

    function IsMenuItemExist (const shipID : integer ) : boolean ;
    function IsMenuItem2Exist (const shipID : integer ) : boolean ;
    
    procedure AddMenuWithShipID (const shipID : integer);
    procedure DeleteMenuWithShipID (const shipID : integer);
    procedure PopupMenuClick (sender : TObject);
    procedure PopupMenuClick2(sender : TObject);
  public
    isNew : Boolean;

    ScenarioName : string;
    Scenario_ID  : Integer;
    MAP_ID : Integer;

    WeaponListScenario : TList;

    procedure ClearWeaponList;
    procedure FillWeaponList(ShipID : integer);
    procedure UpdateWeaponList(ShipID, SceID : integer);
    procedure DeleteWeaponList(ShipID : integer);
    procedure ShowWeaponOnShip(ShipID : integer);

    procedure UpdateVisualForm;
    procedure UpdateListViewCoor(const Mx, My : Double; NameShip : string);
    procedure UpdateListViewHeading(const Heading : Double; NameShip : string);
    procedure UpdateListViewDepth(const Depth : Double; NameShip : string);
    { Public declarations }
  end;

var
  frmSceEditor: TfrmSceEditor;

implementation

uses uQuery, uMainInstruktur, uBaseFunction, ufEnvi, uGlobalVar;

{$R *.dfm}

function DeleteAmpersand(Value: string): string;
var
  i: integer;
  found: Boolean;
begin
  i := -1;
  found := false;

  for i := 0 to Length(Value) - 1 do  begin
    if Value[i] = '&' then
    begin
      found := true;
      break;
    end;
  end;

  if found then
    Delete(Value, i, 1);
  result := Value;
end;

procedure TfrmSceEditor.btnAddGnrShipClick(Sender: TObject);
var
  ii, cnt: integer;
  isselected: Boolean;
  aListItem, selectedListItem: TListItem;
begin
 //MULTI SELECTION
  repeat
    isselected:= false;

    cnt:= lvGeneralShipAll.Items.Count;
    for ii := 0 to cnt - 1 do
    begin
      aListItem:= lvGeneralShipAll.Items[ii];
      if aListItem.Selected then
      begin
        isselected:= aListItem.Selected;
        selectedListItem:= aListItem;
        Break;
      end;
    end;

    if isselected then
    begin
      with lvGeneralShipSelect.Items.Add do
      begin
        Caption := selectedListItem.Caption;
        SubItems.Add(selectedListItem.SubItems[0]);
        SubItems.Add(selectedListItem.SubItems[1]);
        SubItems.Add('0');
        SubItems.Add('0');
        SubItems.Add('0');
        SubItems.Add('90');

        //create ship for drawing
        SimManager.CreateShipForDatabse(StrToInt(selectedListItem.Caption));
      end;

      AddMenuWithShipID(StrToInt(lvGeneralShipAll.Selected.Caption));
      lvGeneralShipAll.Selected.Delete;
    end;

  until not isselected;
end;

procedure TfrmSceEditor.btnAddWarShipClick(Sender: TObject);
var
  ii, cnt: integer;
  isselected: Boolean;
  aListItem, selectedListItem: TListItem;
begin
  //MULTI SELECTION
  repeat
    isselected:= false;

    cnt:= lvWarShipAll.Items.Count;
    for ii := 0 to cnt - 1 do
    begin
      aListItem:= lvWarShipAll.Items[ii];
      if aListItem.Selected then
      begin
        isselected:= aListItem.Selected;
        selectedListItem:= aListItem;
        Break;
      end;
    end;

    if isselected then
    begin
      with lvWarShipSelect.Items.Add do
      begin
        Caption := selectedListItem.Caption;
        SubItems.Add(selectedListItem.SubItems[0]);
        SubItems.Add(selectedListItem.SubItems[1]);
        SubItems.Add(selectedListItem.SubItems[2]);
        SubItems.Add('0');
        SubItems.Add('0');
        SubItems.Add('0');
        SubItems.Add('90');

        //create ship for drawing
        SimManager.CreateShipForDatabse(StrToInt(selectedListItem.Caption));
      end;

      AddMenuWithShipID(StrToInt(lvWarShipAll.Selected.Caption));

      //fill Weapon
      FillWeaponList(StrToInt(lvWarShipAll.Selected.Caption));
      
      lvWarShipAll.Selected.Delete;
    end;

  until not isselected;
end;

procedure TfrmSceEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSceEditor.btnEditDatabaseClick(Sender: TObject);
begin
  frmListScenario.isPlay := False;
  frmListScenario.Show;

  frmListScenario.btnOk.Tag := 0;
  frmListScenario.btnOk.Enabled        := True;
  frmListScenario.lblGameName.Visible  := False;
  frmListScenario.edtGameName.Visible  := False;
  frmListScenario.btnRemove.Visible    := True;
end;

procedure TfrmSceEditor.btnPortMoreClick(Sender: TObject);
begin
  frmMoreEnvi.Show;
end;

procedure TfrmSceEditor.btnRemoveGnrShipClick(Sender: TObject);
var
  ii, cnt: integer;
  isselected: Boolean;
  aListItem, selectedListItem: TListItem;
  i: integer;

  ship : TInsObject;
begin
  //MULTI SELECTION
  repeat
    isselected:= false;

    cnt:= lvGeneralShipSelect.Items.Count;
    for ii := 0 to cnt - 1 do
    begin
      aListItem:= lvGeneralShipSelect.Items[ii];
      if aListItem.Selected then
      begin
        isselected:= aListItem.Selected;
        selectedListItem:= aListItem;
        Break;
      end;
    end;

    if isselected then
    begin
      with lvGeneralShipAll.Items.Add do
      begin
        Caption := selectedListItem.Caption;
        SubItems.Add(selectedListItem.SubItems[0]);
        SubItems.Add(selectedListItem.SubItems[1]);
        SubItems.Add(selectedListItem.SubItems[2]);
        SubItems.Add('0');
        SubItems.Add('0');
      end;

      for i := 0 to SimManager.MainObjList.ItemCount - 1 do
      begin
        ship := SimManager.MainObjList.getObject(i) as TInsObject;
        if InttoStr(ship.FDataBaseID) = lvGeneralShipSelect.Selected.Caption then
        begin
          SimManager.MainObjList.RemoveObject(ship);
          Break;
        end;
      end;

      DeleteMenuWithShipID(StrToInt(lvGeneralShipSelect.Selected.Caption));
      lvGeneralShipSelect.Selected.Delete;
    end;

  until not isselected;
end;

procedure TfrmSceEditor.btnRemoveWarShipClick(Sender: TObject);
var
  ii, cnt: integer;
  isselected: Boolean;
  aListItem, selectedListItem: TListItem;
  i: integer;

  ship : TInsObject;
begin
  //MULTI SELECTION
  repeat
    isselected:= false;

    cnt:= lvWarShipSelect.Items.Count;
    for ii := 0 to cnt - 1 do
    begin
      aListItem:= lvWarShipSelect.Items[ii];
      if aListItem.Selected then
      begin
        isselected:= aListItem.Selected;
        selectedListItem:= aListItem;
        Break;
      end;
    end;

    if isselected then
    begin
      with lvWarShipAll.Items.Add do
      begin
        Caption := selectedListItem.Caption;
        SubItems.Add(selectedListItem.SubItems[0]);
        SubItems.Add(selectedListItem.SubItems[1]);
        SubItems.Add(selectedListItem.SubItems[2]);
        SubItems.Add('0');
        SubItems.Add('0');
      end;

      for i := 0 to SimManager.MainObjList.ItemCount - 1 do
      begin
        ship := SimManager.MainObjList.getObject(i) as TInsObject;
        if InttoStr(ship.FDataBaseID) = lvWarShipSelect.Selected.Caption then
        begin
          SimManager.MainObjList.RemoveObject(ship);
          Break;
        end;
      end;

      DeleteMenuWithShipID(StrToInt(lvWarShipSelect.Selected.Caption));
      
      //Delete Weapon
      DeleteWeaponList(StrToInt(lvWarShipSelect.Selected.Caption));
      lvWeaponSelected.Items.Clear;

      lvWarShipSelect.Selected.Delete;
    end;

  until not isselected;
end;

procedure TfrmSceEditor.btnSaveScenarioClick(Sender: TObject);
var
  ListScenario : Tlist;
  Scenario : TScenarioList;
  I, j: Integer;
  isFound : Boolean;

  RecSceSave  : TScenarioSave;
  RecShipsave : TShipSave;
  RecConsoleSave : TSaveConsole;

  ListShip : Tlist;
  ListConsole : Tlist;

  ShipID_Select  : Integer;
  ShipID_Console : Integer;

  //For Fog Height
  lowerBound, upperBound, boundary, posPercentage, position : double;
  Val: single ;

  SceEnvi : TScenarioSave;
begin
  case TButton(sender).Tag of
    0 : begin
          //save new scenario
          if edtScenarioName.Text <> '' then
          begin
            ListScenario := TList.Create;
            DataModule1.GettAllScenario(ListScenario);

            isFound := False;
            for I := 0 to ListScenario.Count - 1 do
            begin
              Scenario := TScenarioList(ListScenario[i]);

              if LowerCase(Scenario.Scenario_Name) = LowerCase(edtScenarioName.Text) then
              begin
                isFound := True;
                Break;
              end;
            end;

            if not isFound then
            begin
              RecSceSave := TScenarioSave.Create;
              with RecSceSave do
              begin
                Scenario_Name := edtScenarioName.Text;
                Scenario_Port := cbbPort.ItemIndex;
                Scenario_Building   := frmMoreEnvi.Building;
                Scenario_StaticShip := frmMoreEnvi.StaticShip;
                Scenario_Buoy       := frmMoreEnvi.Buoy;
                Scenario_Theme      := frmMoreEnvi.Theme;
                Scenario_Desc       := mmoKetSce.Text;

                //Environment
                Scenario_SeaState     := frmMoreEnvi.SeaState;
                Scenario_WindSpeed    := frmMoreEnvi.WindSpeed;

                //Wind Calc
                Scenario_WindDir_X    := cos(DegToRad(frmMoreEnvi.WindDir));
                Scenario_WindDir_Y    := sin(DegToRad(frmMoreEnvi.WindDir));
                Scenario_WindDir_Deg  := frmMoreEnvi.WindDir;
                Scenario_CurrSpeed    := frmMoreEnvi.CurrentSpeed;
                Scenario_CurrDir_X    := cos(DegToRad(frmMoreEnvi.WindDir));
                Scenario_CurrDir_Y    := sin(DegToRad(frmMoreEnvi.WindDir));
                Scenario_CurrDir_Deg  := frmMoreEnvi.CurrentDir;
                Scenario_Temperature  := frmMoreEnvi.Temperature;
                Scenario_BaroPressure := frmMoreEnvi.BaroPressure;
                Scenario_Humidity     := frmMoreEnvi.Humidity;

                //Fog Calculation
                LowerBound    := 0.00005;
                UpperBound    := 0.08;
                Boundary      := upperBound - lowerBound;
                Position      := ((frmMoreEnvi.tbFogH.Max)-(frmMoreEnvi.tbFogH.Position))
                                  / (frmMoreEnvi.tbFogH.Max);
                PosPercentage := log10(frmMoreEnvi.tbFogH.Max * position) / log10(frmMoreEnvi.tbFogH.Max);
                Val           := lowerBound + ((boundary - (posPercentage * boundary)));

                Scenario_FogHeight        := Val;
                Scenario_FogHeight_Persen := frmMoreEnvi.FogHeight;
              end;

              ListShip := TList.Create;

              //save WarShip and Submarine Configuration
              for i := 0 to lvWarShipSelect.Items.Count - 1 do
              begin
                RecShipsave := TShipSave.Create;
                RecShipsave.Ship_ID := StrToInt(lvWarShipSelect.Items[i].Caption);
                RecShipsave.Ship_TransX  := StrToInt(lvWarShipSelect.Items[i].SubItems[3]);
                RecShipsave.Ship_TransY  := StrToInt(lvWarShipSelect.Items[i].SubItems[4]);
                RecShipsave.Ship_TransZ  := StrToInt(lvWarShipSelect.Items[i].SubItems[5]);
                RecShipsave.SHip_Heading := StrToInt(lvWarShipSelect.Items[i].SubItems[6]);

                ListShip.Add(RecShipsave);
              end;

              //Save General Ship Configuration
              for i := 0 to lvGeneralShipSelect.Items.Count -1 do
              begin
                RecShipsave := TShipSave.Create;
                RecShipsave.Ship_ID := StrToInt(lvGeneralShipSelect.Items[i].Caption);
                RecShipsave.Ship_TransX  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[2]);
                RecShipsave.Ship_TransY  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[3]);
                RecShipsave.Ship_TransZ  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[4]);
                RecShipsave.SHip_Heading := StrToInt(lvGeneralShipSelect.Items[i].SubItems[5]);

                ListShip.Add(RecShipsave);
              end;

              //Save Setting Console
              ListConsole := TList.Create;
              for i := 0 to lvConsole.Items.Count - 1 do
              begin
                if lvConsole.Items[i].SubItems[4] <> '' then
                begin
                  RecConsoleSave            := TSaveConsole.Create;
                  RecConsoleSave.ConsoleID  := StrToInt(lvConsole.Items[i].Caption);
                  RecConsoleSave.ShipID     := StrToInt(lvConsole.Items[i].SubItems[5]);
                  RecConsoleSave.LauncherID := StrToInt(lvConsole.Items[i].SubItems[6]);

                  ListConsole.Add(RecConsoleSave);
                end;
              end;

              if ListShip.Count > 0 then
              begin
                DataModule1.SaveScenario(RecSceSave, ListShip, ListConsole, WeaponListScenario);

                SimManager.MainObjList.ClearObject;
                Close;
              end
              else
              begin
                ShowMessage('Add Ship First');
              end;
            end
            else
            begin
              ShowMessage('Scenario Name Already Exist');
            end;

          end
          else
          begin
            ShowMessage('Please Fill Scenario Name');
          end;
        end;
    1 : begin
          //update Scenario

          //Fog Calculation
          LowerBound    := 0.00005;
          UpperBound    := 0.08;
          Boundary      := upperBound - lowerBound;
          Position      := ((frmMoreEnvi.tbFogH.Max)-(frmMoreEnvi.tbFogH.Position))
                            / (frmMoreEnvi.tbFogH.Max);
          PosPercentage := log10(frmMoreEnvi.tbFogH.Max * position) / log10(frmMoreEnvi.tbFogH.Max);
          Val           := lowerBound + ((boundary - (posPercentage * boundary)));


          SceEnvi := TScenarioSave.Create;
          SceEnvi.Scenario_Building     := frmMoreEnvi.Building;
          SceEnvi.Scenario_StaticShip   := frmMoreEnvi.StaticShip;
          SceEnvi.Scenario_Buoy         := frmMoreEnvi.Buoy;
          SceEnvi.Scenario_Tree         := frmMoreEnvi.Tree;
          SceEnvi.Scenario_Theme        := frmMoreEnvi.Theme;

          SceEnvi.Scenario_SeaState     := frmMoreEnvi.SeaState;

          SceEnvi.Scenario_WindSpeed    := frmMoreEnvi.WindSpeed;
          SceEnvi.Scenario_WindDir_X    := Cos(DegToRad(frmMoreEnvi.WindDir));
          SceEnvi.Scenario_WindDir_Y    := Sin(DegToRad(frmMoreEnvi.WindDir));
          SceEnvi.Scenario_WindDir_Deg  := frmMoreEnvi.WindDir;

          SceEnvi.Scenario_CurrSpeed    := frmMoreEnvi.CurrentSpeed;
          SceEnvi.Scenario_CurrDir_X    := Cos(DegToRad(frmMoreEnvi.CurrentDir));
          SceEnvi.Scenario_CurrDir_Y    := Sin(DegToRad(frmMoreEnvi.CurrentDir));
          SceEnvi.Scenario_CurrDir_Deg  := frmMoreEnvi.CurrentDir;

          SceEnvi.Scenario_Temperature      := frmMoreEnvi.Temperature;
          SceEnvi.Scenario_BaroPressure     := frmMoreEnvi.BaroPressure;
          SceEnvi.Scenario_Humidity         := frmMoreEnvi.Humidity;
          SceEnvi.Scenario_FogHeight        := Val;
          SceEnvi.Scenario_FogHeight_Persen := frmMoreEnvi.FogHeight;

          //Update
          DataModule1.UpdateEnvi(Scenario_ID, SceEnvi);

          ListShip := TList.Create;
          //save WarShip and Submarine Configuration
          for i := 0 to lvWarShipSelect.Items.Count - 1 do
          begin
            RecShipsave := TShipSave.Create;
            RecShipsave.Ship_ID := StrToInt(lvWarShipSelect.Items[i].Caption);
            RecShipsave.Ship_TransX  := StrToInt(lvWarShipSelect.Items[i].SubItems[3]);
            RecShipsave.Ship_TransY  := StrToInt(lvWarShipSelect.Items[i].SubItems[4]);
            RecShipsave.Ship_TransZ  := StrToInt(lvWarShipSelect.Items[i].SubItems[5]);
            RecShipsave.SHip_Heading := StrToInt(lvWarShipSelect.Items[i].SubItems[6]);
            RecShipsave.Ship_Console := 0;

            ShipID_Select := StrToInt(lvWarShipSelect.Items[i].Caption);

            for j := 0 to lvConsole.Items.Count - 1 do
            begin
              if lvConsole.Items[j].SubItems[5] = '' then Continue;
              ShipID_Console := StrToInt(lvConsole.Items[j].SubItems[5]);

              if ShipID_Select = ShipID_Console then
              begin
                RecShipsave.Ship_Console := StrToInt(lvConsole.Items[j].Caption);
                Break;
              end;
            end;

            ListShip.Add(RecShipsave);
          end;

          //Save General Ship Configuration
          for i := 0 to lvGeneralShipSelect.Items.Count -1 do
          begin
            RecShipsave := TShipSave.Create;
            RecShipsave.Ship_ID := StrToInt(lvGeneralShipSelect.Items[i].Caption);
            RecShipsave.Ship_TransX  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[2]);
            RecShipsave.Ship_TransY  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[3]);
            RecShipsave.Ship_TransZ  := StrToInt(lvGeneralShipSelect.Items[i].SubItems[4]);
            RecShipsave.SHip_Heading := StrToInt(lvGeneralShipSelect.Items[i].SubItems[5]);
            RecShipsave.Ship_Console := 0;

            ShipID_Select := StrToInt(lvGeneralShipSelect.Items[i].Caption);

            for j := 0 to lvConsole.Items.Count - 1 do
            begin
              if lvConsole.Items[j].SubItems[5] = '' then Continue;
              ShipID_Console := StrToInt(lvConsole.Items[j].SubItems[5]);

              if ShipID_Select = ShipID_Console then
              begin
                RecShipsave.Ship_Console := StrToInt(lvConsole.Items[j].Caption);
                Break;
              end;
            end;

            ListShip.Add(RecShipsave);
          end;

          //Save Setting Console
          ListConsole := TList.Create;
          for i := 0 to lvConsole.Items.Count - 1 do
          begin
            if lvConsole.Items[i].SubItems[4] <> '' then
            begin
              RecConsoleSave            := TSaveConsole.Create;
              RecConsoleSave.ConsoleID  := StrToInt(lvConsole.Items[i].Caption);
              RecConsoleSave.ShipID     := StrToInt(lvConsole.Items[i].SubItems[5]);
              RecConsoleSave.LauncherID := StrToInt(lvConsole.Items[i].SubItems[6]);

              ListConsole.Add(RecConsoleSave);
            end;
          end;

          if ListShip.Count > 0 then
          begin
            DataModule1.UpdateCurrentDatabase(Scenario_ID, ListShip, ListConsole, WeaponListScenario);

            SimManager.MainObjList.ClearObject;
            Close;
          end
          else
          begin
            ShowMessage('Add Ship First');
          end;
        end;
  end;
end;

procedure TfrmSceEditor.btnSetPositionClick(Sender: TObject);
var
  i: Integer;
  Ship : Tinsobject;
begin
  if lvWarShipSelect.Selected <> nil then
  begin
    DatabaseObject := nil;
    for i := 0 to SimManager.MainObjList.ItemCount - 1 do
    begin
      Ship := SimManager.MainObjList.getObject(i) as TInsObject;

      if lvWarShipSelect.Selected.Caption = IntToStr(Ship.FDataBaseID) then
      begin
        DatabaseObject := Ship;
        tmpActiveClickMap := c_klik_databaseship;
      end;
    end;
  end
  else
  if lvGeneralShipSelect.Selected <> nil then
  begin
    DatabaseObject := nil;
    for i := 0 to SimManager.MainObjList.ItemCount - 1 do
    begin
      Ship := SimManager.MainObjList.getObject(i) as TInsObject;

      if lvGeneralShipSelect.Selected.Caption = IntToStr(Ship.FDataBaseID) then
      begin
        DatabaseObject := Ship;
        tmpActiveClickMap := c_klik_databaseship;
      end;
    end;
  end;
end;

procedure TfrmSceEditor.btnWeaponListClick(Sender: TObject);
begin
  if (lvWarShipAll.Selected <> nil) or (lvWarShipSelect.Selected <> nil) then
  begin
    frmWeaponList.Ship_ID := Ship_ID;
    frmWeaponList.Ship_Name := Ship_Name;
    frmWeaponList.Show;
  end
  else
  begin
    ShowMessage('Select War Ship First');
  end;
end;

procedure TfrmSceEditor.cbbPortCloseUp(Sender: TObject);
var
  xOff : Double;
  yOff : Double;
begin
  if cbbPort.ItemIndex > -1 then begin
     GetSceneOffSetFromPortID(cbbPort.ItemIndex, xOff, yOff);
      if (( instMapSet.xOffset <> xOff ) and ( instMapSet.yOffset <> yOff )) then
      begin
        instMapSet.useOffset := true;
        instMapSet.xOffset := xOff;
        instMapSet.yOffset := yOff;
        instMapSet.xCenter := xOff;
        instMapSet.yCenter := yOff;
        fMainInstr.Map.ZoomTo(fMainInstr.Map.Zoom, xOff, yOff);
      end;
  end;
end;

procedure TfrmSceEditor.DeleteMenuWithShipID(const shipID: integer);
var
  i : integer ;
  menuItem : TMenuItem;
begin
  for i:=0 to pmConsole.Items.Count - 1 do
  begin
    menuItem := pmConsole.Items[i];
    if menuItem.Name = 'pmShip'+IntToStr(shipID) then
    begin
      pmConsole.Items.Delete(i);
      FreeAndNil(menuItem);
      Break;
    end;
  end;

  for i:=0 to pmConsole2.Items.Count - 1 do
  begin
    menuItem := pmConsole2.Items[i];
    if menuItem.Name = 'pm2Ship'+IntToStr(shipID) then
    begin
      pmConsole2.Items.Delete(i);
      FreeAndNil(menuItem);
      Break;
    end;
  end;
end;
procedure TfrmSceEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMainInstr.frameleftpanel1.NillAllSet;
  TrackObject := nil;
  DatabaseObject := nil;

  isDatabaseMode := False;
  SimManager.MainObjList.ClearObject;
end;

procedure TfrmSceEditor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //

end;

procedure TfrmSceEditor.FormShow(Sender: TObject);
begin
  isDatabaseMode := True;
  UpdateVisualForm;
end;

function TfrmSceEditor.IsMenuItemExist(const shipID: integer): boolean;
var
  i : integer ;
  menuItem : TMenuItem;
begin
  Result := false ;
  for i:=0 to pmConsole.Items.Count - 1 do
  begin
    menuItem := pmConsole.Items[i];
    if menuItem.Name = 'pmShip'+IntToStr(shipID) then
    begin
      Result := true ;
      Break;
    end;
  end;
end;

function TfrmSceEditor.IsMenuItem2Exist(const shipID: integer): boolean;
var
  i : integer ;
  menuItem : TMenuItem;
begin
  Result := false ;
  for i:=0 to pmConsole2.Items.Count - 1 do
  begin
    menuItem := pmConsole2.Items[i];
    if menuItem.Name = 'pm2Ship'+IntToStr(shipID) then
    begin
      Result := true ;
      Break;
    end;
  end;
end;

procedure TfrmSceEditor.AddMenuWithShipID(const shipID: integer);
var
  i : integer;

  menuItem,
  subItem : TMenuItem;
begin
  if not IsMenuItemExist(shipID) then
  begin
    menuItem := TMenuItem.Create(pmConsole);
    menuItem.Name    := 'pmShip'+IntToStr(shipID);
    menuItem.Caption := GetShipNameFromID(shipID);
    menuItem.OnClick := PopupMenuClick;
    menuItem.Tag     := shipID;
    pmConsole.Items.Add(menuItem);
  end;

  if not IsMenuItem2Exist(shipID) then
  begin
    menuItem := TMenuItem.Create(pmConsole2);
    menuItem.Name    := 'pm2Ship'+IntToStr(shipID);
    menuItem.Caption := GetShipNameFromID(shipID);
    menuItem.Tag     := shipID;
    pmConsole2.Items.Add(menuItem);

    for i := 1 to 3 do
    begin
      subItem := TMenuItem.Create(pmConsole2);
      subItem.Caption   := 'Launcher ' + IntToStr(i);
      subItem.Tag      := shipID;
      subItem.Hint     := IntToStr(i);
      subItem.OnClick  := PopupMenuClick2;
      menuItem.Add(subItem);
    end;
  end;
end;

procedure TfrmSceEditor.PopupMenuClick2(sender: TObject);
begin
  if lvConsole.Selected <> nil then
  begin
    lvConsole.Selected.SubItems[4] := GetShipNameFromID(TMenuItem(sender).Tag);
    lvConsole.Selected.SubItems[5] := IntToStr(TMenuItem(sender).Tag);
    lvConsole.Selected.SubItems[6] := TMenuItem(sender).Hint;
  end;
end;

procedure TfrmSceEditor.PopupMenuClick(sender: TObject);
begin
  if lvConsole.Selected <> nil then
  begin
    lvConsole.Selected.SubItems[4] := DeleteAmpersand(TMenuItem(sender).Caption);
    lvConsole.Selected.SubItems[5] := IntToStr(TMenuItem(sender).Tag);
    lvConsole.Selected.SubItems[6] := IntToStr(0);
  end;
end;

procedure TfrmSceEditor.lvConsoleDblClick(Sender: TObject);
begin
  if lvConsole.Selected = nil then Exit;

  lvConsole.Selected.SubItems[4] := '';
  lvConsole.Selected.SubItems[5] := '';
  lvConsole.Selected.SubItems[6] := '';
end;

procedure TfrmSceEditor.lvGeneralShipAllClick(Sender: TObject);
begin
  lvWarShipAll.Selected := nil;
  lvWarShipSelect.Selected := nil;
  lvGeneralShipSelect.Selected := nil;
end;

procedure TfrmSceEditor.lvGeneralShipAllCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
   intItem1,
   intItem2: Integer;
begin
   intItem1 := StrToInt(Item1.Caption);
   intItem2 := StrToInt(Item2.Caption);

   if intItem1 < intItem2 then
     Compare := -1
   else
   if intItem1 > intItem2 then
     Compare := 1
   else
     Compare := 0;
end;

procedure TfrmSceEditor.lvGeneralShipAllDblClick(Sender: TObject);
begin
  if lvGeneralShipAll.Selected <> nil then
  begin
    with lvGeneralShipSelect.Items.Add do
    begin
      Caption := lvGeneralShipAll.Selected.Caption;
      SubItems.Add(lvGeneralShipAll.Selected.SubItems[0]);
      SubItems.Add(lvGeneralShipAll.Selected.SubItems[1]);
      SubItems.Add('0');
      SubItems.Add('0');
      SubItems.Add('0');
      SubItems.Add('90');
    end;

    //create pop up menu
    AddMenuWithShipID(StrToInt(lvGeneralShipAll.Selected.Caption));

    //create ship for drawing
    SimManager.CreateShipForDatabse(StrToInt(lvGeneralShipAll.Selected.Caption));

    lvGeneralShipAll.Selected.Delete;
  end
  else
  begin
    ShowMessage('Select Ship First');
  end;
end;

procedure TfrmSceEditor.lvGeneralShipAllSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if lvGeneralShipAll.Selected <> nil then
  begin
    Ship_ID := StrToInt(lvGeneralShipAll.Selected.Caption);
    Ship_Name := lvGeneralShipAll.Selected.SubItems[0];

    lvGeneralShipSelect.Selected := nil;

    try
      imgShip.Picture.LoadFromFile('..\Data\imageship\'+ lvGeneralShipAll.Selected.SubItems[0] + '.jpg');
    Except
      ShowMessage('Picture Doesnt Exist');
    end;
  end;
end;

procedure TfrmSceEditor.lvGeneralShipSelectClick(Sender: TObject);
begin
  lvWarShipAll.Selected := nil;
  lvWarShipSelect.Selected := nil;
  lvGeneralShipAll.Selected := nil;
end;

procedure TfrmSceEditor.lvGeneralShipSelectCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
   intItem1,
   intItem2: Integer;
begin
   intItem1 := StrToInt(Item1.Caption);
   intItem2 := StrToInt(Item2.Caption);

   if intItem1 < intItem2 then
     Compare := -1
   else
   if intItem1 > intItem2 then
     Compare := 1
   else
     Compare := 0;
end;

procedure TfrmSceEditor.lvGeneralShipSelectDblClick(Sender: TObject);
var
  i : Integer;
  Ship : TInsObject;
begin
  if lvGeneralShipSelect.Selected <> nil then
  begin
    with lvGeneralShipAll.Items.Add do
    begin
      Caption := lvGeneralShipSelect.Selected.Caption;
      SubItems.Add(lvGeneralShipSelect.Selected.SubItems[0]);
      SubItems.Add(lvGeneralShipSelect.Selected.SubItems[1]);
      SubItems.Add(lvGeneralShipSelect.Selected.SubItems[2]);
    end;

    for i := 0 to SimManager.MainObjList.ItemCount - 1 do
    begin
      ship := SimManager.MainObjList.getObject(i) as TInsObject;
      if InttoStr(ship.FDataBaseID) = lvGeneralShipSelect.Selected.Caption then
      begin
        SimManager.MainObjList.RemoveObject(ship);
        break;
      end;
    end;

    DeleteMenuWithShipID(StrToInt(lvGeneralShipSelect.Selected.Caption));

    lvGeneralShipSelect.Selected.Delete;
  end
  else
  begin
    ShowMessage('Select Ship First');
  end;
end;


procedure TfrmSceEditor.lvGeneralShipSelectSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if lvGeneralShipSelect.Selected <> nil then
  begin
    Ship_ID := StrToInt(lvGeneralShipSelect.Selected.Caption);
    Ship_Name := lvGeneralShipSelect.Selected.SubItems[0];

    lvGeneralShipAll.Selected := nil;

    try
      imgShip.Picture.LoadFromFile('..\Data\imageship\'+ lvGeneralShipSelect.Selected.SubItems[0] + '.jpg');
    Except
      ShowMessage('Picture Doesnt Exist');
    end;
  end;
end;

procedure TfrmSceEditor.lvWarShipAllClick(Sender: TObject);
begin
  lvWarShipSelect.Selected := nil;
  lvGeneralShipAll.Selected := nil;
  lvGeneralShipSelect.Selected := nil;

  lvWeaponSelected.Items.Clear;
end;

procedure TfrmSceEditor.lvWarShipAllCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
   intItem1,
   intItem2: Integer;
begin
   intItem1 := StrToInt(Item1.Caption);
   intItem2 := StrToInt(Item2.Caption);

   if intItem1 < intItem2 then
     Compare := -1
   else
   if intItem1 > intItem2 then
     Compare := 1
   else
     Compare := 0;
end;

procedure TfrmSceEditor.lvWarShipAllDblClick(Sender: TObject);
begin
  if lvWarShipAll.Selected <> nil then
  begin
    with lvWarShipSelect.Items.Add do
    begin
      Caption := lvWarShipAll.Selected.Caption;
      SubItems.Add(lvWarShipAll.Selected.SubItems[0]);
      SubItems.Add(lvWarShipAll.Selected.SubItems[1]);
      SubItems.Add(lvWarShipAll.Selected.SubItems[2]);
      SubItems.Add('0');
      SubItems.Add('0');
      SubItems.Add('0');
      SubItems.Add('90');
    end;

    //create menu pop up
    AddMenuWithShipID(StrToInt(lvWarShipAll.Selected.Caption));

    //create ship for drawing
    SimManager.CreateShipForDatabse(StrToInt(lvWarShipAll.Selected.Caption));

    //fill Weapon
    FillWeaponList(StrToInt(lvWarShipAll.Selected.Caption));

    lvWarShipAll.Selected.Delete;
  end
  else
  begin
    ShowMessage('Select Ship First');
  end;
end;

procedure TfrmSceEditor.lvWarShipAllSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if lvWarShipAll.Selected <> nil then
  begin
    Ship_ID := StrToInt(lvWarShipAll.Selected.Caption);
    Ship_Name := lvWarShipAll.Selected.SubItems[0];

    lvWarShipSelect.Selected := nil;

    try
      imgShip.Picture.LoadFromFile('..\Data\imageship\'+ lvWarShipAll.Selected.SubItems[1] + '.jpg');
    Except
      ShowMessage('Picture Doesnt Exist');
    end;
  end;
end;

procedure TfrmSceEditor.lvWarShipSelectClick(Sender: TObject);
begin
  lvWarShipAll.Selected := nil;
  lvGeneralShipAll.Selected := nil;
  lvGeneralShipSelect.Selected := nil;

  if lvWarShipSelect.Selected <> nil then
  begin
    ShowWeaponOnShip(StrToInt(lvWarShipSelect.Selected.Caption));
  end
  else
  begin
    lvWeaponSelected.Items.Clear;
  end;
end;

procedure TfrmSceEditor.lvWarShipSelectCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
   intItem1,
   intItem2: Integer;
begin
   intItem1 := StrToInt(Item1.Caption);
   intItem2 := StrToInt(Item2.Caption);

   if intItem1 < intItem2 then
     Compare := -1
   else
   if intItem1 > intItem2 then
     Compare := 1
   else
     Compare := 0;
end;

procedure TfrmSceEditor.lvWarShipSelectDblClick(Sender: TObject);
var
  i : Integer;
  Ship : TInsObject;
begin
  if lvWarShipSelect.Selected <> nil then
  begin
    with lvWarShipAll.Items.Add do
    begin
      Caption := lvWarShipSelect.Selected.Caption;
      SubItems.Add(lvWarShipSelect.Selected.SubItems[0]);
      SubItems.Add(lvWarShipSelect.Selected.SubItems[1]);
      SubItems.Add(lvWarShipSelect.Selected.SubItems[2]);
    end;

    for i := 0 to SimManager.MainObjList.ItemCount - 1 do
    begin
      ship := SimManager.MainObjList.getObject(i) as TInsObject;
      if InttoStr(ship.FDataBaseID) = lvWarShipSelect.Selected.Caption then
      begin
        SimManager.MainObjList.RemoveObject(ship);
        break;
      end;
    end;

    DeleteMenuWithShipID(StrToInt(lvWarShipSelect.Selected.Caption));

    //Delete Weapon
    DeleteWeaponList(StrToInt(lvWarShipSelect.Selected.Caption));
    lvWeaponSelected.Items.Clear;

    lvWarShipSelect.Selected.Delete;
  end
  else
  begin
    ShowMessage('Select Ship First');
  end;
end;



procedure TfrmSceEditor.lvWarShipSelectSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if lvWarShipSelect.Selected <> nil then
  begin
    Ship_ID := StrToInt(lvWarShipSelect.Selected.Caption);
    Ship_Name := lvWarShipSelect.Selected.SubItems[0];

    lvWarShipAll.Selected := nil;

    try
      imgShip.Picture.LoadFromFile('..\Data\imageship\'+ lvWarShipSelect.Selected.SubItems[1] + '.jpg');
    Except
      ShowMessage('Picture Doesnt Exist');
    end;
  end;
end;

procedure TfrmSceEditor.pnlMainClick(Sender: TObject);
begin
  if GetAsyncKeyState(16) <> 0 then
  begin
    btnWeaponList.Visible := True;
    btnShipEditor.Visible := True;
  end
  else
  begin
    btnWeaponList.Visible := False;
    btnShipEditor.Visible := False;
  end;
end;

procedure TfrmSceEditor.UpdateListViewCoor(const Mx, My : Double; NameShip : string);
var
  i: Integer;
begin
  for i := 0 to lvWarShipSelect.Items.Count - 1 do
  begin
    if lvWarShipSelect.Items[i].SubItems[0] = NameShip then
    begin
      lvWarShipSelect.Items[i].SubItems[3] := FormatFloat('0',(Mx-instMapSet.xOffset) * C_Degree_to_Meter);
      lvWarShipSelect.Items[i].SubItems[4] := FormatFloat('0',(My-instMapSet.yOffset) * C_Degree_to_Meter);
      lvWarShipSelect.Items[i].SubItems[5] := lvWarShipSelect.Items[i].SubItems[5];
      Break;
    end;
  end;

  for i := 0 to lvGeneralShipSelect.Items.Count - 1 do
  begin
    if lvGeneralShipSelect.Items[i].SubItems[0] = NameShip then
    begin
      lvGeneralShipSelect.Items[i].SubItems[2] := FormatFloat('0',(Mx-instMapSet.xOffset) * C_Degree_to_Meter);
      lvGeneralShipSelect.Items[i].SubItems[3] := FormatFloat('0',(My-instMapSet.yOffset) * C_Degree_to_Meter);
      lvGeneralShipSelect.Items[i].SubItems[4] := lvGeneralShipSelect.Items[i].SubItems[4];
      Break;
    end;
  end;
end;

procedure TfrmSceEditor.UpdateListViewDepth(const Depth: Double;
  NameShip: string);
var
  i: Integer;
begin
  for i := 0 to lvWarShipSelect.Items.Count - 1 do
  begin
    if lvWarShipSelect.Items[i].SubItems[0] = NameShip then
    begin
      lvWarShipSelect.Items[i].SubItems[5] := FormatFloat('0',Depth);
      Break;
    end;
  end;
end;

procedure TfrmSceEditor.UpdateListViewHeading(const Heading: Double;
  NameShip: string);
var
  i: Integer;
begin
  for i := 0 to lvWarShipSelect.Items.Count - 1 do
  begin
    if lvWarShipSelect.Items[i].SubItems[0] = NameShip then
    begin
      lvWarShipSelect.Items[i].SubItems[6] := FormatFloat('0',Heading);
      Break;
    end;
  end;

  for i := 0 to lvGeneralShipSelect.Items.Count - 1 do
  begin
    if lvGeneralShipSelect.Items[i].SubItems[0] = NameShip then
    begin
      lvGeneralShipSelect.Items[i].SubItems[5] := FormatFloat('0',Heading);
      Break;
    end;
  end;
end;

procedure TfrmSceEditor.UpdateVisualForm;
var
  listWarShip    : Tlist;
  listGeneralShp : TList;
  listAllShip    : Tlist;
  listAllConsole : Tlist;

  WarShip : TShip;
  GeneralShip : TShip;
  AllShip : TShip;
  AllConsole : TClientConsole;
  i: Integer;
  j: Integer;

  isfound : Boolean;
  Dx, Dy : Double;
  Mx, My : Double;

  Ship : TInsObject;

  ListScenario : Tlist;
  Scenario : TScenarioList;

  menuItem : TmenuItem;

  li : TlistItem;

  listConsole : TList;
  Console : TConsole;
  Console_ID : Integer;

  //Envi
  SceEnvi : TScenarioSave;

  //For Fog Height
  lowerBound, upperBound, boundary, posPercentage, position : double;
  Val: single ;
begin
  ClearWeaponList;

  edtScenarioName.Text := '';
  edtScenarioName.Text := '';
  mmoKetSce.Clear;

  lvWarShipAll.Items.Clear;
  lvWarShipSelect.Items.Clear;
  lvGeneralShipAll.Items.Clear;
  lvGeneralShipSelect.Items.Clear;
  lvConsole.Items.Clear;
  lvWeaponSelected.Items.Clear;

  pmConsole.Items.Clear;
  pmConsole2.Items.Clear;

  SimManager.MainObjList.ClearObject;

  listAllConsole  := TList.Create;
  DataModule1.GetPC_Client(listAllConsole);

  for i := 0 to listAllConsole.Count - 1 do
  begin
    AllConsole := TClientConsole(listAllConsole.Items[i]);

    if AllConsole.PC_IDM = 0 then  Continue;

    with lvConsole.Items.Add do
    begin
      Caption := IntToStr(AllConsole.ID);

      case AllConsole.PC_IDM of
        0 : SubItems.Add('SERVER');
        1 : SubItems.Add('PIT');
        2 : SubItems.Add('OBSERVER');
      end;

      SubItems.Add(AllConsole.PC_NAME);

      case AllConsole.APP_TIPE of
        0 : SubItems.Add('2D');
        1 : SubItems.Add('3D-S');
        2 : SubItems.Add('3D-C');
        3 : SubItems.Add('3D-W');
      end;

      SubItems.Add(AllConsole.PC_IP);
      SubItems.Add('');
      SubItems.Add('');
      SubItems.Add('');
    end;
  end;

  if isNew then
  begin
    btnSaveScenario.Caption := 'Save New Scenario';
    btnSaveScenario.Tag := 0;

    edtScenarioName.Enabled := True;
    cbbPort.Enabled := True;

    listWarShip     := TList.Create;
    listGeneralShp  := TList.Create;

    DataModule1.GetAllWarShip(listWarShip);
    DataModule1.GetAllGeneralShip(listGeneralShp);

    for i := 0 to listWarShip.Count - 1 do
    begin
      WarShip := TShip(listWarShip[i]);

      with lvWarShipAll.Items.Add do
      begin
        Caption := IntToStr(WarShip.Ship_ID);
        SubItems.Add(WarShip.Ship_Name);
        SubItems.Add(IntToStr(WarShip.Ship_No));
        SubItems.Add(IntToStr(WarShip.Ship_Ctgr));
      end;
    end;

    for i := 0 to listGeneralShp.Count - 1 do
    begin
      GeneralShip := TShip(listGeneralShp[i]);

      with lvGeneralShipAll.Items.Add do
      begin
        Caption := IntToStr(GeneralShip.Ship_ID);
        SubItems.Add(GeneralShip.Ship_Name);
        SubItems.Add(IntToStr(GeneralShip.Ship_Ctgr));
      end;
    end;
  end
  else
  begin
    edtScenarioName.Enabled := False;
    edtScenarioName.Text := ScenarioName;
    cbbPort.Enabled := False;

    listAllShip := TList.Create;
    btnSaveScenario.Caption := 'Save Scenario';
    btnSaveScenario.Tag := 1;

    ListScenario := TList.Create;
    DataModule1.GettAllScenario(ListScenario);

    //=============================================================================
    //========================= Environment =======================================
    SceEnvi := TScenarioSave.Create;
    DataModule1.GetEnviBySceID(Scenario_ID, SceEnvi);

    frmMoreEnvi.eBuilding.ItemIndex     := SceEnvi.Scenario_Building;
    frmMoreEnvi.eStaticShips.ItemIndex  := SceEnvi.Scenario_StaticShip;
    frmMoreEnvi.eBuoy.ItemIndex         := SceEnvi.Scenario_Buoy;
    frmMoreEnvi.eTree.ItemIndex         := SceEnvi.Scenario_Tree;
    frmMoreEnvi.eTheme.ItemIndex        := SceEnvi.Scenario_Theme;
    frmMoreEnvi.Building                := SceEnvi.Scenario_Building;
    frmMoreEnvi.StaticShip              := SceEnvi.Scenario_StaticShip;
    frmMoreEnvi.Buoy                    := SceEnvi.Scenario_Buoy;
    frmMoreEnvi.Tree                    := SceEnvi.Scenario_Tree;
    frmMoreEnvi.Theme                   := SceEnvi.Scenario_Theme;

    frmMoreEnvi.edtSeaState.Text          := FloatToStr(SceEnvi.Scenario_SeaState);
    frmMoreEnvi.edtWindSpeed.Text         := FloatToStr(SceEnvi.Scenario_WindSpeed);
    frmMoreEnvi.edtCurrentSpeed.Text      := FloatToStr(SceEnvi.Scenario_CurrSpeed);
    frmMoreEnvi.edtWindDirection.Text     := FloatToStr(SceEnvi.Scenario_WindDir_Deg);
    frmMoreEnvi.edtCurrentDirection.Text  := FloatToStr(SceEnvi.Scenario_CurrDir_Deg);
    frmMoreEnvi.edtTemperature.Text       := FloatToStr(SceEnvi.Scenario_Temperature);
    frmMoreEnvi.edtBaroPressure.Text      := FloatToStr(SceEnvi.Scenario_BaroPressure);
    frmMoreEnvi.edtHumidity.Text          := FloatToStr(SceEnvi.Scenario_Humidity);
    frmMoreEnvi.edtFogheight.Text         := FloatToStr(SceEnvi.Scenario_FogHeight_Persen);
    frmMoreEnvi.SeaState                  := Round(SceEnvi.Scenario_SeaState);
    frmMoreEnvi.WindSpeed                 := Round(SceEnvi.Scenario_WindSpeed);
    frmMoreEnvi.CurrentSpeed              := Round(SceEnvi.Scenario_CurrSpeed);
    frmMoreEnvi.WindDir                   := Round(SceEnvi.Scenario_WindDir_Deg);
    frmMoreEnvi.CurrentDir                := Round(SceEnvi.Scenario_CurrDir_Deg);
    frmMoreEnvi.Temperature               := Round(SceEnvi.Scenario_Temperature);
    frmMoreEnvi.BaroPressure              := Round(SceEnvi.Scenario_BaroPressure);
    frmMoreEnvi.Humidity                  := Round(SceEnvi.Scenario_Humidity);
    frmMoreEnvi.FogHeight                 := Round(SceEnvi.Scenario_FogHeight_Persen);

    frmMoreEnvi.tbSeaState.Position       := Round(SceEnvi.Scenario_SeaState);
    frmMoreEnvi.tbWindSpeed.Position      := Round(SceEnvi.Scenario_WindSpeed);
    frmMoreEnvi.tbSeaSpeed.Position       := Round(SceEnvi.Scenario_CurrSpeed);
    frmMoreEnvi.tbTemp.Position           := Round(SceEnvi.Scenario_Temperature);
    frmMoreEnvi.tbBaroPressure.Position   := Round(SceEnvi.Scenario_BaroPressure);
    frmMoreEnvi.tbHumidity.Position       := Round(SceEnvi.Scenario_Humidity);
    frmMoreEnvi.tbFogH.Position           := Round(SceEnvi.Scenario_FogHeight_Persen);

    if SceEnvi.Scenario_WindDir_Deg > 180 then
        frmMoreEnvi.vrwhlWindDirec.Position := (Round(SceEnvi.Scenario_WindDir_Deg) - 180)
    else
        frmMoreEnvi.vrwhlWindDirec.Position := (Round(SceEnvi.Scenario_WindDir_Deg) + 180);

    if SceEnvi.Scenario_CurrDir_Deg > 180 then
        frmMoreEnvi.vrwhlSeaDirection.Position := (Round(SceEnvi.Scenario_CurrDir_Deg) - 180)
    else
        frmMoreEnvi.vrwhlSeaDirection.Position := (Round(SceEnvi.Scenario_CurrDir_Deg) + 180);

    //=============================================================================

    for i := 0 to ListScenario.Count - 1 do
    begin
      Scenario := TScenarioList(ListScenario[i]);

      if Scenario.Scenario_ID = Scenario_ID then
      begin
        if Scenario.ENV_PETA = 0 then
          cbbPort.Text := 'Surabaya'
        else
        if Scenario.ENV_PETA = 1 then
          cbbPort.Text := 'Jakarta'
        else
        if Scenario.ENV_PETA = 2 then
          cbbPort.Text := 'Laut Lepas'
        else
        if Scenario.ENV_PETA = 3 then
          cbbPort.Text := 'BalikPapan'
        else
        if Scenario.ENV_PETA = 4 then
        begin
          cbbPort.Text := 'Medan';
        end;

        Break;
      end;
    end;

    listConsole := TList.Create;
    DataModule1.GetConsoleListBySceID(Scenario_ID, listConsole);
    for i := 0 to listConsole.Count - 1 do
    begin
      Console := TConsole(listConsole.Items[i]);

      for j := 0 to lvConsole.Items.Count - 1 do
      begin
        Console_ID := StrToInt(lvConsole.Items[j].Caption);

        if Console.ConsoleID = Console_ID then
        begin
          lvConsole.Items[j].SubItems[4] := DataModule1.GetShipName(Console.ShipID);
          lvConsole.Items[j].SubItems[5] := IntToStr(Console.ShipID);
          lvConsole.Items[j].SubItems[6] := IntToStr(Console.LauncherID);

          Break;
        end;
      end;
    end;


    DataModule1.GetAllShipFromScen(Scenario_ID, listAllShip);

    mmoKetSce.Lines.Add(DataModule1.GetDesById(Scenario_ID));
    GetSceneOffSetFromPortID(DataModule1.GetMapById(Scenario_ID), Dx, Dy);

    CurrentXOffset := Dx;
    CurrentYOffset := Dy;

    if (( instMapSet.xOffset <> Dx ) and ( instMapSet.yOffset <> Dy )) then
    begin
      instMapSet.useOffset := true;
      instMapSet.xOffset := Dx;
      instMapSet.yOffset := Dy;
      instMapSet.xCenter := Dx;
      instMapSet.yCenter := Dy;
      fMainInstr.Map.ZoomTo(fMainInstr.Map.Zoom, Dx, Dy);
    end;

    for i := 0 to listAllShip.Count - 1 do
    begin
      AllShip := TShip(listAllShip[i]);

      if AllShip.Ship_Ctgr <> 0 then
      begin

        //Get Warship
        with lvWarShipSelect.Items.Add do
        begin
          Caption := IntToStr(AllShip.Ship_ID);
          SubItems.Add(AllShip.Ship_Name);
          SubItems.Add(IntToStr(AllShip.Ship_No));
          SubItems.Add(IntToStr(AllShip.Ship_Ctgr));
          SubItems.Add(IntToStr(AllShip.SHIP_X));
          SubItems.Add(IntToStr(AllShip.SHIP_Y));
          SubItems.Add(IntToStr(AllShip.SHIP_Z));
          SubItems.Add(IntToStr(AllShip.Heading));

          //create ship for drawing
          SimManager.CreateShipForDatabse(StrToInt(Caption));
          Mx := (AllShip.SHIP_X / C_Degree_To_Meter)+ Dx;
          My := (AllShip.SHIP_Y / C_Degree_To_Meter)+ Dy;

          for j := 0 to SimManager.MainObjList.ItemCount - 1 do
          begin
            Ship := SimManager.MainObjList.getObject(i) as TInsObject;
            if Ship.ObjName = AllShip.Ship_Name then
            begin
              Ship.MoveTo(Mx, My);
              Ship.VSymbol.Heading  := ValidateDegree(AllShip.Heading);
              Break;
            end;
          end;

          FillWeaponList(AllShip.Ship_ID);
          UpdateWeaponList(AllShip.Ship_ID, Scenario_ID);
        end;
      end
      else
      if AllShip.Ship_Ctgr = 0 then
      begin
        //Get General Ship
        with lvGeneralShipSelect.Items.Add do
        begin
          Caption := IntToStr(AllShip.Ship_ID);
          SubItems.Add(AllShip.Ship_Name);
          SubItems.Add(IntToStr(AllShip.Ship_Ctgr));
          SubItems.Add(IntToStr(AllShip.SHIP_X));
          SubItems.Add(IntToStr(AllShip.SHIP_Y));
          SubItems.Add(IntToStr(AllShip.SHIP_Z));
          SubItems.Add(IntToStr(AllShip.Heading));

          //create ship for drawing
          SimManager.CreateShipForDatabse(StrToInt(Caption));
          Mx := (AllShip.SHIP_X / C_Degree_To_Meter)+ Dx;
          My := (AllShip.SHIP_Y / C_Degree_To_Meter)+ Dy;

          for j := 0 to SimManager.MainObjList.ItemCount - 1 do
          begin
            Ship := SimManager.MainObjList.getObject(i) as TInsObject;
            if Ship.ObjName = AllShip.Ship_Name then
            begin
              Ship.MoveTo(Mx, My);
              Ship.VSymbol.Heading  := ValidateDegree(AllShip.Heading);
              Break;
            end;
          end;
        end;
      end;

    end;

    //Get WarShip
    listWarShip := TList.Create;
    DataModule1.GetAllWarShip(listWarShip);
    for i := 0 to listWarShip.Count - 1 do
    begin
      isfound := False;

      WarShip := TShip(listWarShip[i]);
      for j := 0 to listAllShip.Count - 1 do
      begin
         AllShip := TShip(listAllShip[j]);

         if WarShip.Ship_ID = AllShip.Ship_ID then
         begin
           isfound := True;

           AddMenuWithShipID(WarShip.Ship_ID);
           Break;
         end;
      end;

      if not isfound then
      begin
        with lvWarShipAll.Items.Add do
        begin
          Caption := IntToStr(WarShip.Ship_ID);
          SubItems.Add(WarShip.Ship_Name);
          SubItems.Add(IntToStr(WarShip.Ship_No));
          SubItems.Add(IntToStr(WarShip.Ship_Ctgr));
        end;
      end;
    end;

    //Get General Ship
    listGeneralShp := TList.Create;
    DataModule1.GetAllGeneralShip(listGeneralShp);
    for i := 0 to listGeneralShp.Count - 1 do
    begin
      isfound := False;

      GeneralShip := TShip(listGeneralShp[i]);
      for j := 0 to listAllShip.Count - 1 do
      begin
         AllShip := TShip(listAllShip[j]);

         if GeneralShip.Ship_ID = AllShip.Ship_ID then
         begin
           isfound := True;

           AddMenuWithShipID(GeneralShip.Ship_ID);
           Break;
         end;
      end;

      if not isfound then
      begin
        with lvGeneralShipAll.Items.Add do
        begin
          Caption := IntToStr(GeneralShip.Ship_ID);
          SubItems.Add(GeneralShip.Ship_Name);
          SubItems.Add(IntToStr(GeneralShip.Ship_No));
          SubItems.Add(IntToStr(GeneralShip.Ship_Ctgr));
        end;
      end;
    end;
  end;
end;

procedure TfrmSceEditor.FormCreate(Sender: TObject);
begin
  WeaponListScenario := TList.Create;
end;

procedure TfrmSceEditor.FormDestroy(Sender: TObject);
begin
  WeaponListScenario.Free;
end;

procedure TfrmSceEditor.ClearWeaponList;
var
  I : Integer;
begin
  for i:= WeaponListScenario.Count -1 downto 0 do
  begin
    WeaponListScenario.Delete(i);
  end;
  WeaponListScenario.Clear;
end;

procedure TfrmSceEditor.DeleteWeaponList(ShipID: integer);
var
  i : integer;
  SceWeapon   : TScenarioWeapon;
begin
  for i:= WeaponListScenario.Count-1 downto 0 do
  begin
    SceWeapon := TScenarioWeapon(WeaponListScenario.Items[i]);
    if SceWeapon.ShipID = ShipID then
    begin
      WeaponListScenario.Delete(i);
    end;
  end;
end;

procedure TfrmSceEditor.FillWeaponList(ShipID: integer);
var
  ListWeapon  : TList;
  Weapon      : TWeaponGetList;
  SceWeapon   : TScenarioWeapon;

  I : Integer;
begin
  try
    ListWeapon := TList.Create;
    DataModule1.GetListWeaponOnShip(ShipID, ListWeapon);

    for i := 0 to ListWeapon.Count -1 do
    begin
      Weapon := TWeaponGetList(ListWeapon.Items[i]);

      SceWeapon := TScenarioWeapon.Create;
      SceWeapon.ShipID        := ShipID;
      SceWeapon.WeaponID      := Weapon.IDWeapon;
      SceWeapon.LauncherID    := Weapon.IDDetail;
      SceWeapon.WeaponName    := DataModule1.GetNameWeaponByID(Weapon.IDWeapon);
      SceWeapon.EnableWeapon  := True;

      WeaponListScenario.Add(SceWeapon);
    end;

  finally
    ListWeapon.Free;
  end;


end;

procedure TfrmSceEditor.ShowWeaponOnShip(ShipID: integer);
var
  I : Integer;
  SceWeapon : TScenarioWeapon;
begin
  lvWeaponSelected.Items.Clear;

  for i:= 0 to WeaponListScenario.Count-1 do
  begin
    SceWeapon := TScenarioWeapon(WeaponListScenario.Items[i]);

    if SceWeapon.ShipID <> ShipID then Continue;

    with lvWeaponSelected.Items.Add do
    begin
      Caption := IntToStr(SceWeapon.WeaponID);
      SubItems.Add(SceWeapon.WeaponName);
      SubItems.Add(IntToStr(SceWeapon.LauncherID));

      if SceWeapon.EnableWeapon then
      begin
        SubItems.Add('Enable')
      end
      else
      begin
        SubItems.Add('Disable');
      end;
    end;
  end;
end;

procedure TfrmSceEditor.btnEnableWeaponClick(Sender: TObject);
var
  I : Integer;
  SceWeapon : TScenarioWeapon;
  isEnable : Boolean;

  WeaponID,
  LauncherID,
  ShipID : integer;
begin
  if btnEnableWeapon.Tag = 0 then
    isEnable := False
  else
    isEnable := True;

  if lvWarShipSelect.Selected <> nil then
  begin
    ShipID := StrToInt(lvWarShipSelect.Selected.Caption);

    if lvWeaponSelected.Selected <> nil then
    begin
      WeaponID := StrToInt(lvWeaponSelected.Selected.Caption);
      LauncherID := StrToInt(lvWeaponSelected.Selected.SubItems[1]);

      for i := 0 to WeaponListScenario.Count -1 do
      begin
        SceWeapon := TScenarioWeapon(WeaponListScenario.Items[i]);

        if (SceWeapon.ShipID = ShipID) and (SceWeapon.WeaponID = WeaponID)
          and (SceWeapon.LauncherID = LauncherID) then
        begin
          SceWeapon.EnableWeapon := isEnable;
        end;
      end;
    end;

    ShowWeaponOnShip(StrToInt(lvWarShipSelect.Selected.Caption));
  end;
end;

procedure TfrmSceEditor.lvWeaponSelectedClick(Sender: TObject);
begin
  if lvWeaponSelected.Selected <> nil then
  begin
    if lvWeaponSelected.Selected.SubItems[2] = 'Enable' then
    begin
      btnEnableWeapon.Tag := 0;
      btnEnableWeapon.Caption := 'Disable';
    end
    else
    if lvWeaponSelected.Selected.SubItems[2] = 'Disable' then
    begin
      btnEnableWeapon.Tag := 1;
      btnEnableWeapon.Caption := 'Enable';
    end;
  end;
end;

procedure TfrmSceEditor.UpdateWeaponList(ShipID, SceID: integer);
var
  SceWeapon     : TScenarioWeapon;
  TempSceWeapon : TScenarioWeapon;

  WeaponList : TList;
  i,j : Integer;
begin
  try
    WeaponList := TList.Create;
    DataModule1.GetListWeaponOnShipBySceID(SceID, ShipID, WeaponList);

    for i:= 0 to WeaponListScenario.Count -1 do
    begin
      SceWeapon := TScenarioWeapon(WeaponListScenario.Items[i]);

      if SceWeapon.ShipID = ShipID then
      begin
        SceWeapon.EnableWeapon := False;
      end;
    end;

    for j := 0 to WeaponList.Count -1 do
    begin
      TempSceWeapon := TScenarioWeapon(WeaponList.Items[j]);

      for i:= 0 to WeaponListScenario.Count -1 do
      begin
        SceWeapon := TScenarioWeapon(WeaponListScenario.Items[i]);

        if (TempSceWeapon.ShipID = SceWeapon.ShipID) and
           (TempSceWeapon.WeaponID = SceWeapon.WeaponID) and
           (TempSceWeapon.LauncherID = SceWeapon.LauncherID) then
        begin
          SceWeapon.EnableWeapon := True;
          break;
        end;
      end;
    end;

  finally
    WeaponList.Free;
  end;
end;

procedure TfrmSceEditor.lvConsoleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p : TPoint;
begin
  if (Button = MbRight) then
  begin
    if lvConsole.Selected <> nil then
    begin
      GetCursorPos(p);

      if ( lvConsole.Selected.SubItems[2] = '3D-W' ) 
      then
      begin
        pmConsole2.Popup(p.X, p.Y);
      end
      else
      begin
        pmConsole.Popup(p.X, p.Y);
      end;
    end;
  end;
end;

end.
