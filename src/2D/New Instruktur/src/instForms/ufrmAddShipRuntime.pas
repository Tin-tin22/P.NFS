unit ufrmAddShipRuntime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothPanel, AdvSmoothButton, ComCtrls, AdvSmoothTabPager,
  AdvSmoothLabel, CurvyControls,

  uClassDatabase, uInstrukturManager, ufrmGameController, uDataModule;

type
  TfrmAddShipRuntime = class(TForm)
    pnlUp: TAdvSmoothPanel;
    pnlDown: TAdvSmoothPanel;
    TabSelection: TAdvSmoothTabPager;
    tsShipKRI: TAdvSmoothTabPage;
    lvWarShipAll: TListView;
    lvWeaponSelected: TListView;
    btnEnableWeapon: TAdvSmoothButton;
    tsShipTarget: TAdvSmoothTabPage;
    TabTargetShip: TAdvSmoothTabPager;
    tsSurface: TAdvSmoothTabPage;
    lvTargetSurfaceAll: TListView;
    tsSubsurface: TAdvSmoothTabPage;
    tsAir: TAdvSmoothTabPage;
    lvTargetAirAll: TListView;
    tsShipGeneral: TAdvSmoothTabPage;
    lvGeneralShipAll: TListView;
    lvTargetSubsurfaceAll: TListView;
    btnRemoveObject: TAdvSmoothButton;
    lblZ: TAdvSmoothLabel;
    edtZCoord: TCurvyEdit;
    procedure TabSelectionChange(Sender: TObject);
    procedure TabTargetShipChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveObjectClick(Sender: TObject);
  private
    { Private declarations }
    VehicleRuntime : TVehicle;
    procedure ListViewClick(Sender : TObject);
  public
    { Public declarations }
    PosX, PosY : Double;
  end;

var
  frmAddShipRuntime: TfrmAddShipRuntime;

implementation

{$R *.dfm}

procedure TfrmAddShipRuntime.TabSelectionChange(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to TabSelection.AdvSmoothTabPageCount -1 do
  begin
    TabSelection.AdvSmoothTabPages[i].TabAppearance.Appearance.SimpleLayout := True;
  end;
  TabSelection.ActivePage.TabAppearance.Appearance.SimpleLayout := False;

  edtZCoord.Visible := False;
  edtZCoord.Text    := '0';
  lblZ.Visible      := False;
  lblZ.Caption.Text := 'Altitude';
end;

procedure TfrmAddShipRuntime.TabTargetShipChange(Sender: TObject);
begin
  edtZCoord.Visible := False;
  edtZCoord.Text    := '0';
  lblZ.Visible      := False;
  lblZ.Caption.Text := 'Altitude';
end;

procedure TfrmAddShipRuntime.FormCreate(Sender: TObject);
begin
  VehicleRuntime := nil;

  edtZCoord.Visible := False;
  edtZCoord.Text    := '0';
  lblZ.Visible      := False;
  lblZ.Caption.Text := 'Altitude';

  { OnClick }
  lvWarShipAll.OnClick              := ListViewClick;
  lvGeneralShipAll.OnClick          := ListViewClick;
  lvTargetSurfaceAll.OnClick        := ListViewClick;
  lvTargetSubsurfaceAll.OnClick     := ListViewClick;
  lvTargetAirAll.OnClick            := ListViewClick;

  TabSelection.ActivePage := tsShipKRI;
end;

procedure TfrmAddShipRuntime.ListViewClick(Sender: TObject);
var
  Vehicle : TVehicle;
begin
  VehicleRuntime    := nil;

  edtZCoord.Visible := False;
  edtZCoord.Text    := '0';
  lblZ.Visible      := False;
  lblZ.Caption.Text := 'Altitude';

  if TListView(sender).Selected <> nil then
  begin
    if Assigned(TListView(sender).Selected.Data) then
    begin
      Vehicle := TVehicle(TListView(sender).Selected.Data);
      VehicleRuntime := Vehicle;

      case Vehicle.Vehicle_Type of
        1 :
        begin
          edtZCoord.Visible := False;
          edtZCoord.Text    := '0';
          lblZ.Visible      := False;
          lblZ.Caption.Text := 'Altitude';
        end;

        2 :
        begin
          edtZCoord.Visible := True;
          edtZCoord.Text    := '50';
          lblZ.Visible      := True;
          lblZ.Caption.Text := 'Altitude';
        end;

        3 :
        begin
          edtZCoord.Visible := True;
          edtZCoord.Text    := '15';
          lblZ.Visible      := True;
          lblZ.Caption.Text := 'Depth';
        end;
      end;
    end;
  end
end;

procedure TfrmAddShipRuntime.FormShow(Sender: TObject);
var
  i,j : integer;
  isFound : Boolean;

  { KRI, General, Target[Surface, Subsurface, Air] }
  listShipKRI,
  listShipGeneral,
  listTargetSurface,
  listTargetSubsurface,
  listTargetAir         : Tlist;

  Vehicle,
  ShipDetail,
  WarShip,
  GeneralShip,
  TargetSurfaceShip,
  TargetSubsurfaceShip,
  TargetAirShip         : TVehicle;
begin
   VehicleRuntime := nil;

   for i:= lvWarShipAll.Items.Count -1 downto 0 do
   begin
     lvWarShipAll.Items[i].Delete;
   end;
   lvWarShipAll.Items.Clear;

   for i:= lvGeneralShipAll.Items.Count -1 downto 0 do
   begin
     lvGeneralShipAll.Items[i].Delete;
   end;
   lvGeneralShipAll.Items.Clear;

   for i:= lvTargetSurfaceAll.Items.Count -1 downto 0 do
   begin
     lvTargetSurfaceAll.Items[i].Delete;
   end;
   lvTargetSurfaceAll.Items.Clear;

   for i:= lvTargetSubsurfaceAll.Items.Count -1 downto 0 do
   begin
     lvTargetSubsurfaceAll.Items[i].Delete;
   end;
   lvTargetSubsurfaceAll.Items.Clear;

   for i:= lvTargetAirAll.Items.Count -1 downto 0 do
   begin
     lvTargetAirAll.Items[i].Delete;
   end;
   lvTargetAirAll.Items.Clear;

   try
      listShipKRI           := TList.Create;
      listShipGeneral       := TList.Create;
      listTargetSurface     := TList.Create;
      listTargetSubsurface  := TList.Create;
      listTargetAir         := TList.Create;

      DataModule1.GetAllWarShip(listShipKRI);
      DataModule1.GetAllGeneralShip(listShipGeneral);
      DataModule1.GetAllTargetSurface(listTargetSurface);
      DataModule1.GetAllTargetSubsurface(listTargetSubsurface);
      DataModule1.GetAllTargetAir(listTargetAir);

      { Ship KRI }
      for i := 0 to listShipKRI.Count - 1 do
      begin
        isFound := false;
        WarShip := TVehicle(listShipKRI.Items[i]);

        for j := 0 to frmGameController.lvRuntimeShip.Items.Count -1 do
        begin
          if Assigned(frmGameController.lvRuntimeShip.Items[j].Data) then
          begin
            Vehicle := TVehicle(frmGameController.lvRuntimeShip.Items[j].Data);

            if WarShip.Vehicle_ID = Vehicle.Vehicle_ID then
            begin
              isFound := true;
              Break;
            end;
          end
          else
          begin
            isFound := true;
          end;
        end;

        if not isFound then
        begin
          with lvWarShipAll.Items.Add do
          begin
            ShipDetail := TVehicle.Create;
            ShipDetail.Vehicle_ID   := WarShip.Vehicle_ID;
            ShipDetail.Vehicle_Name := WarShip.Vehicle_Name;
            ShipDetail.Vehicle_Ctgr := WarShip.Vehicle_Ctgr;
            ShipDetail.Vehicle_No   := WarShip.Vehicle_No;
            ShipDetail.Vehicle_Type := DataModule1.GetShipDomain(ShipDetail.Vehicle_ID);

            Data      := ShipDetail;
            Caption   := WarShip.Vehicle_Name;
          end;
        end;
      end;

      { Ship General }
      for i := 0 to listShipGeneral.Count - 1 do
      begin            
        isFound := false;
        GeneralShip := TVehicle(listShipGeneral.Items[i]);

        for j := 0 to frmGameController.lvRuntimeShip.Items.Count -1 do
        begin
          if Assigned(frmGameController.lvRuntimeShip.Items[j].Data) then
          begin
            Vehicle := TVehicle(frmGameController.lvRuntimeShip.Items[j].Data);

            if GeneralShip.Vehicle_ID = Vehicle.Vehicle_ID then
            begin
              isFound := true;
              Break;
            end;
          end
          else
          begin
            isFound := true;
          end;
        end;

        if not isFound then
        begin
          with lvGeneralShipAll.Items.Add do
          begin
            ShipDetail := TVehicle.Create;
            ShipDetail.Vehicle_ID   := GeneralShip.Vehicle_ID;
            ShipDetail.Vehicle_Name := GeneralShip.Vehicle_Name;
            ShipDetail.Vehicle_Ctgr := GeneralShip.Vehicle_Ctgr;
            ShipDetail.Vehicle_No   := GeneralShip.Vehicle_No;
            ShipDetail.Vehicle_Type := DataModule1.GetShipDomain(ShipDetail.Vehicle_ID);

            Data      := ShipDetail;
            Caption   := GeneralShip.Vehicle_Name;
          end;
        end;
      end;

      { Target Surface}
      for i := 0 to listTargetSurface.Count - 1 do
      begin
        isFound := false;
        TargetSurfaceShip := TVehicle(listTargetSurface.Items[i]);

        for j := 0 to frmGameController.lvRuntimeShip.Items.Count -1 do
        begin
          if Assigned(frmGameController.lvRuntimeShip.Items[j].Data) then
          begin
            Vehicle := TVehicle(frmGameController.lvRuntimeShip.Items[j].Data);

            if TargetSurfaceShip.Vehicle_ID = Vehicle.Vehicle_ID then
            begin
              isFound := true;
              Break;
            end;
          end
          else
          begin
            isFound := true;
          end;
        end;

        if not isFound then
        begin
          with lvTargetSurfaceAll.Items.Add do
          begin
            ShipDetail := TVehicle.Create;
            ShipDetail.Vehicle_ID   := TargetSurfaceShip.Vehicle_ID;
            ShipDetail.Vehicle_Name := TargetSurfaceShip.Vehicle_Name;
            ShipDetail.Vehicle_Ctgr := TargetSurfaceShip.Vehicle_Ctgr;
            ShipDetail.Vehicle_No   := TargetSurfaceShip.Vehicle_No;
            ShipDetail.Vehicle_Type := DataModule1.GetShipDomain(ShipDetail.Vehicle_ID);

            Data    := ShipDetail;
            Caption := TargetSurfaceShip.Vehicle_Name;
          end;
        end;
      end;

      { Target Subsurface }
      for i := 0 to listTargetSubsurface.Count - 1 do
      begin
        isFound := false;
        TargetSubsurfaceShip := TVehicle(listTargetSubsurface.Items[i]);

        for j := 0 to frmGameController.lvRuntimeShip.Items.Count -1 do
        begin
          if Assigned(frmGameController.lvRuntimeShip.Items[j].Data) then
          begin
            Vehicle := TVehicle(frmGameController.lvRuntimeShip.Items[j].Data);

            if TargetSubsurfaceShip.Vehicle_ID = Vehicle.Vehicle_ID then
            begin
              isFound := true;
              Break;
            end;
          end
          else
          begin
            isFound := true;
          end;
        end;

        if not isFound then
        begin
          with lvTargetSubsurfaceAll.Items.Add do
          begin
            ShipDetail := TVehicle.Create;
            ShipDetail.Vehicle_ID   := TargetSubsurfaceShip.Vehicle_ID;
            ShipDetail.Vehicle_Name := TargetSubsurfaceShip.Vehicle_Name;
            ShipDetail.Vehicle_Ctgr := TargetSubsurfaceShip.Vehicle_Ctgr;
            ShipDetail.Vehicle_No   := TargetSubsurfaceShip.Vehicle_No;
            ShipDetail.Vehicle_Type := DataModule1.GetShipDomain(ShipDetail.Vehicle_ID);

            Data    := ShipDetail;
            Caption := TargetSubsurfaceShip.Vehicle_Name;
          end;
        end;
      end;

      { Target Air }
      for i := 0 to listTargetAir.Count - 1 do
      begin
        isFound := false;
        TargetAirShip := TVehicle(listTargetAir.Items[i]);

        for j := 0 to frmGameController.lvRuntimeShip.Items.Count -1 do
        begin
          if Assigned(frmGameController.lvRuntimeShip.Items[j].Data) then
          begin
            Vehicle := TVehicle(frmGameController.lvRuntimeShip.Items[j].Data);

            if TargetAirShip.Vehicle_ID = Vehicle.Vehicle_ID then
            begin
              isFound := true;
              Break;
            end;
          end
          else
          begin
            isFound := true;
          end;
        end;

        if not isFound then
        begin
          with lvTargetAirAll.Items.Add do
          begin
            ShipDetail := TVehicle.Create;
            ShipDetail.Vehicle_ID   := TargetAirShip.Vehicle_ID;
            ShipDetail.Vehicle_Name := TargetAirShip.Vehicle_Name;
            ShipDetail.Vehicle_Ctgr := TargetAirShip.Vehicle_Ctgr;
            ShipDetail.Vehicle_No   := TargetAirShip.Vehicle_No;
            ShipDetail.Vehicle_Type := DataModule1.GetShipDomain(ShipDetail.Vehicle_ID);

            Data    := ShipDetail;
            Caption := TargetAirShip.Vehicle_Name;
          end;
        end;
      end;
      
   finally
      listShipKRI.Free;
      listShipGeneral.Free;
      listTargetSurface.Free;
      listTargetSubsurface.Free;
      listTargetAir.Free;
   end;


end;

procedure TfrmAddShipRuntime.btnRemoveObjectClick(Sender: TObject);
var
  isValid : Boolean;
  PosZ    : Double;
begin
  IsValid := true;
  if VehicleRuntime <> nil then
  begin
    if not TryStrToFloat(edtZCoord.Text, PosZ) then isValid := false;

    if isValid then
    begin
      if VehicleRuntime.Vehicle_Type = 3 then PosZ := -1* Abs(PosZ);
      SimManager.NetSendTo3D_AddShipRuntime(VehicleRuntime.Vehicle_ID, PosX, PosY, PosZ, 0);
    end;

    //VehicleRuntime := nil;
  end;
  VehicleRuntime := nil;
  Close;
end;

end.
