unit ufrmeLeftControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, AdvSmoothPanel, CurvyControls, AdvSmoothLabel,
  AdvSmoothButton, AdvSmoothTabPager, Menus,

  ufGuidance, ufWeaponStatus, uInstrukturManager, uInstrukturObjects,
  uBaseFunction;

type
  TfrmeControl = class(TFrame)
    pnlMain: TAdvSmoothPanel;
    TabShipMenu: TAdvSmoothTabPager;
    tsShipGuidance: TAdvSmoothTabPage;
    tsShipWeaponStatus: TAdvSmoothTabPage;
    pnlUp: TAdvSmoothPanel;
    btnRange: TAdvSmoothButton;
    lbl4: TAdvSmoothLabel;
    lbl3: TAdvSmoothLabel;
    lbl2: TAdvSmoothLabel;
    edtDeviceName: TCurvyEdit;
    edtDeviceLauncher: TCurvyEdit;
    edtDeviceType: TCurvyEdit;
    btnPpDeviceType: TAdvSmoothButton;
    btnPpDeviceLauncher: TAdvSmoothButton;
    btnPpDeviceName: TAdvSmoothButton;
    lblShipName: TAdvSmoothLabel;
    btnTikas: TAdvSmoothButton;
    procedure btnRangeClick(Sender: TObject);
    procedure btnTikasClick(Sender: TObject);
  private
    { Private declarations }


    MenuItemDeviceName,
    MenuItemDeviceLauncher,
    MenuItemDeviceType     : TMenuItem;

    procedure On_ClickBtnPopUp(sender : TObject);
    procedure On_ClickPpDeviceName(Sender : TObject);
    procedure On_ClickPpDeviceLauncher(Sender : TObject);
    procedure On_ClickPpDeviceType(Sender : TObject);
  public
    { Public declarations }
    { Frame }
    FrameGuidance     : TfGuidance;
    FrameWeaponStatus : TfWeaponStatus;

    { Pop Up Menu }
    PopUpDeviceName,
    PopUpDeviceLauncher,
    PopUpDeviceType     : TPopupMenu ;

    procedure NillAllSet;
    procedure SetObject(aObject : TInsObject);
    procedure RefreshFrame(aObject: TInsObject);
    procedure SetHandleEvent;

    procedure CreatePopUp;
    procedure DestroyPopUp;

  end;

implementation

{$R *.dfm}

{ TfrmeControl }
uses
  ufrmGameController;

procedure TfrmeControl.CreatePopUp;
begin
  PopUpDeviceName     := TPopupMenu.Create(nil);
  PopUpDeviceLauncher := TPopupMenu.Create(nil);
  PopUpDeviceType     := TPopupMenu.Create(nil);
end;

procedure TfrmeControl.DestroyPopUp;
begin
  NillAllSet;

  PopUpDeviceName.Free;
  PopUpDeviceLauncher.Free;
  PopUpDeviceType.Free;
end;

procedure TfrmeControl.On_ClickBtnPopUp(sender: TObject);
var
  p : TPoint;
begin
  GetCursorPos(p);
  case TComponent(sender).Tag of
    1 : PopUpDeviceName.Popup(p.X, p.Y);
    2 : PopUpDeviceLauncher.Popup(p.X, p.Y);
    3 : PopUpDeviceType.Popup(p.X, p.Y);
  end;
end;

procedure TfrmeControl.On_ClickPpDeviceLauncher(Sender: TObject);
var
  i,j : Integer;
  MenuItem   : TMenuItem;

  WeaponOnShip : TWeaponOnShip;
  WeaponOnShipDetail : TWeaponRangeDetail;
begin
  edtDeviceType.Enabled         := false;
  edtDeviceType.Text            := '';
  btnPpDeviceType.Enabled       := false;
  btnRange.Enabled              := false;
  btnRange.Tag                  := 1;
  btnRange.Caption              := 'Show Range';

  for i := PopUpDeviceType.Items.Count - 1 downto 0 do
  begin
    PopUpDeviceType.Items.Delete(i);
  end;
  PopUpDeviceType.Items.Clear;

  edtDeviceLauncher.Text := DeleteAmpersand(TMenuItem(sender).Caption);

  if Assigned(SimManager.TrackObject) then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
    begin
      WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List.Items[i]);

      if ( WeaponOnShip.Weapon_Name = edtDeviceName.Text ) and
         ( WeaponOnShip.Weapon_Launcher = TMenuItem(sender).Tag )
      then
      begin
        if WeaponOnShip.ListDetail.Count > 0 then
        begin
          edtDeviceType.Enabled    := true;
          btnPpDeviceType.Enabled  := true;
          btnRange.Enabled         := true;

          WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[0]);
          edtDeviceType.Text := WeaponOnShipDetail.Detail_Name;

          for j := 0 to WeaponOnShip.ListDetail.Count -1 do
          begin
            WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);

            MenuItem          := TMenuItem.Create(PopUpDeviceType);
            MenuItem.Tag      := WeaponOnShipDetail.Detail_Type;
            MenuItem.Caption  := WeaponOnShipDetail.Detail_Name;
            MenuItem.OnClick  := On_ClickPpDeviceType;
            PopUpDeviceType.Items.Add(MenuItem);
          end;
        end;

        break;
      end;
    end;
  end;

  if Assigned(SimManager.TrackObject) then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
    begin
      WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if ( WeaponOnShip.Weapon_Name = edtDeviceName.Text ) and
         ( 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher) = edtDeviceLauncher.Text )
      then
      begin
        for j := 0 to WeaponOnShip.ListDetail.Count -1 do
        begin
          WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);
          if WeaponOnShipDetail.Detail_Name = edtDeviceType.Text then
          begin
            if WeaponOnShipDetail.isShowWeaponRange then
            begin
              btnRange.Caption := 'Hide Range';
              btnRange.Tag     := 2;
            end
            else
            begin
              btnRange.Caption := 'Show Range';
              btnRange.Tag     := 1;
            end;

            Break;
          end;
        end;

        break;
      end;
    end;
  end;
end;

procedure TfrmeControl.On_ClickPpDeviceName(Sender: TObject);
var
  i,j: integer;
  MenuItem : TMenuItem;

  WeaponOnShip       : TWeaponOnShip;
  WeaponOnShipDetail : TWeaponRangeDetail;
begin
  edtDeviceLauncher.Enabled     := false;
  edtDeviceLauncher.Text        := '';
  btnPpDeviceLauncher.Enabled   := false;
  edtDeviceType.Enabled         := false;
  edtDeviceType.text            := '';
  btnPpDeviceType.Enabled       := false;
  btnRange.Enabled              := false;
  btnRange.Tag                  := 1;
  btnRange.Caption              := 'Show Range';

  edtDeviceName.Text := DeleteAmpersand(TMenuItem(sender).Caption);

  { Show Weapon Status }
  //FrameWeaponStatus.ShowWeaponPanel(edtDeviceName.Text);      //dendy cek

  For i := PopUpDeviceLauncher.Items.Count -1 downto 0 do
  begin
    PopUpDeviceLauncher.Items.Delete(i);
  end;
  PopUpDeviceLauncher.Items.Clear;

  for i := PopUpDeviceType.Items.Count - 1 downto 0 do
  begin
    PopUpDeviceType.Items.Delete(i);
  end;
  PopUpDeviceType.Items.Clear;

  if Assigned(SimManager.TrackObject) then
  begin
    SimManager.TrackObject.HookedWeaponID := TMenuItem(sender).Tag;

    // tak tandai
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
    begin
      WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      { Pop Up Device Launcher }
      if WeaponOnShip.Weapon_ID = TMenuItem(sender).Tag then
      begin
        MenuItem          := TMenuItem.Create(PopUpDeviceLauncher);
        MenuItem.Tag      := WeaponOnShip.Weapon_Launcher;
        MenuItem.Caption  := 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher);
        MenuItem.OnClick  := On_ClickPpDeviceLauncher;
        PopUpDeviceLauncher.Items.Add(MenuItem);
      end;
    end;

    if PopUpDeviceLauncher.Items.Count > 0 then
    begin
      edtDeviceLauncher.Enabled     := true;
      btnPpDeviceLauncher.Enabled   := true;
      edtDeviceLauncher.Text        := DeleteAmpersand(PopUpDeviceLauncher.Items[0].Caption);

      for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
      begin
        WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

        if ( WeaponOnShip.Weapon_ID = TMenuItem(sender).Tag ) and
           ( WeaponOnShip.Weapon_Launcher = PopUpDeviceLauncher.Items[0].Tag )
        then
        begin
          { Pop Up Device Type }
          if WeaponOnShip.ListDetail.Count > 0 then
          begin
            edtDeviceType.Enabled    := true;
            btnPpDeviceType.Enabled  := true;
            btnRange.Enabled         := true;
        
            WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[0]);
            edtDeviceType.Text := WeaponOnShipDetail.Detail_Name;

            for j := 0 to WeaponOnShip.ListDetail.Count -1 do
            begin
              WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);

              MenuItem          := TMenuItem.Create(PopUpDeviceType);
              MenuItem.Tag      := WeaponOnShipDetail.Detail_Type;
              MenuItem.Caption  := WeaponOnShipDetail.Detail_Name;
              MenuItem.OnClick  := On_ClickPpDeviceType;
              PopUpDeviceType.Items.Add(MenuItem);
            end;
          end;

          Break;
        end;
      end;
    end;

    if Assigned(SimManager.TrackObject) then
    begin
      for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
      begin
        WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

        if ( WeaponOnShip.Weapon_Name = edtDeviceName.Text ) and
           ( 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher) = edtDeviceLauncher.Text )
        then
        begin
          for j := 0 to WeaponOnShip.ListDetail.Count -1 do
          begin
            WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);
            if WeaponOnShipDetail.Detail_Name = edtDeviceType.Text then
            begin
              if WeaponOnShipDetail.isShowWeaponRange then
              begin
                btnRange.Caption := 'Hide Range';
                btnRange.Tag     := 2;
              end
              else
              begin
                btnRange.Caption := 'Show Range';
                btnRange.Tag     := 1;
              end;

              Break;
            end;
          end;

          break;
        end;
      end;
    end;
  end; 
end;

procedure TfrmeControl.On_ClickPpDeviceType(Sender: TObject);
var
  i, j : integer;
  WeaponOnShip : TWeaponOnShip;
  WeaponOnShipDetail : TWeaponRangeDetail;
begin
  edtDeviceType.Text := DeleteAmpersand(TMenuItem(sender).Caption);

  if Assigned(SimManager.TrackObject) then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
    begin
      WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if ( WeaponOnShip.Weapon_Name = edtDeviceName.Text ) and
         ( 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher) = edtDeviceLauncher.Text )
      then
      begin
        for j := 0 to WeaponOnShip.ListDetail.Count -1 do
        begin
          WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);
          if WeaponOnShipDetail.Detail_Name = edtDeviceType.Text then
          begin
            if WeaponOnShipDetail.isShowWeaponRange then
            begin
              btnRange.Caption := 'Hide Range';
              btnRange.Tag     := 2;
            end
            else
            begin
              btnRange.Caption := 'Show Range';
              btnRange.Tag     := 1;
            end;

            Break;
          end;
        end;

        break;
      end;
    end;
  end; 
end;

procedure TfrmeControl.NillAllSet;
var
  i : integer;
begin
  lblShipName.Caption.Text      := 'No Vehicle';
  edtDeviceName.Text            := '';
  edtDeviceLauncher.Text        := '';
  edtDeviceType.Text            := '';
  edtDeviceName.Enabled         := false;
  edtDeviceLauncher.Enabled     := false;
  edtDeviceType.Enabled         := False;
  btnRange.Enabled              := False;
  btnPpDeviceType.Enabled       := false;
  btnPpDeviceLauncher.Enabled   := false;
  btnPpDeviceName.Enabled       := False;
  btnRange.Caption              := 'Show Range';
  btnRange.Tag                  := 1;
  btnTikas.Enabled              := false;

  { Destroy Pop Up }
  for i := PopUpDeviceName.Items.Count - 1 downto 0 do
  begin
    PopUpDeviceName.Items.Delete(i);
  end;
  PopUpDeviceName.Items.Clear;

  for i := PopUpDeviceLauncher.Items.Count - 1 downto 0 do
  begin
    PopUpDeviceLauncher.Items.Delete(i);
  end;
  PopUpDeviceLauncher.Items.Clear;

  for i := PopUpDeviceType.Items.Count - 1 downto 0 do
  begin
    PopUpDeviceType.Items.Delete(i);
  end;
  PopUpDeviceType.Items.Clear;
end;

procedure TfrmeControl.SetObject(aObject: TInsObject);
var
  i,j : integer;
  isFound : Boolean;

  WeaponOnShip,
  WeaponOnShipTemp   : TWeaponOnShip;
  WeaponOnShipDetail : TWeaponRangeDetail;

  MenuItem : TMenuItem;
begin
  lblShipName.Caption.Text      := aObject.ObjName;

  if Assigned(SimManager.TrackObject) then
  begin
    FrameWeaponStatus.SetWeaponGroupBar;
    btnTikas.Enabled := True;
    //frmGameController.lvRuntimeShip.sel

    { Initialize }
    if SimManager.TrackObject.WeaponOnShip_List.Count > 0 then
    begin
      edtDeviceName.Enabled         := true;
      btnPpDeviceName.Enabled       := true;
      edtDeviceLauncher.Enabled     := true;
      btnPpDeviceLauncher.Enabled   := true;

      WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List.Items[0]);

      edtDeviceName.Text := WeaponOnShip.Weapon_Name;
      edtDeviceLauncher.Text := 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher);
      SimManager.TrackObject.HookedWeaponID := WeaponOnShip.Weapon_ID;


      { Fill Pop Up }
      { Pop Up Device Launcher }
      for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
      begin
        WeaponOnShipTemp := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List.Items[i]);

        if WeaponOnShipTemp.Weapon_ID = WeaponOnShip.Weapon_ID then
        begin
          MenuItem          := TMenuItem.Create(PopUpDeviceLauncher);
          MenuItem.Tag      := WeaponOnShipTemp.Weapon_Launcher;
          MenuItem.Caption  := 'Launcher ' + IntToStr(WeaponOnShipTemp.Weapon_Launcher);
          MenuItem.OnClick  := On_ClickPpDeviceLauncher;
          PopUpDeviceLauncher.Items.Add(MenuItem);
        end;
      end;

      { Pop Up Device Type }
      if WeaponOnShip.ListDetail.Count > 0 then
      begin
        edtDeviceType.Enabled    := true;
        btnPpDeviceType.Enabled  := true;
        btnRange.Enabled         := true;
        
        WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[0]);
        edtDeviceType.Text := WeaponOnShipDetail.Detail_Name;

        for i := 0 to WeaponOnShip.ListDetail.Count -1 do
        begin
          WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[i]);

          MenuItem          := TMenuItem.Create(PopUpDeviceType);
          MenuItem.Tag      := WeaponOnShipDetail.Detail_Type;
          MenuItem.Caption  := WeaponOnShipDetail.Detail_Name;
          MenuItem.OnClick  := On_ClickPpDeviceType;
          PopUpDeviceType.Items.Add(MenuItem);
        end;
      end;

      { Pop Up Device Name }
      for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count - 1 do
      begin
        WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List.Items[i]);

        isFound := false;
        for j := 0 to PopUpDeviceName.Items.Count - 1 do
        begin
          MenuItem := TMenuItem(PopUpDeviceName.Items[j]);
          if MenuItem.Caption = WeaponOnShip.Weapon_Name then
          begin
            isFound := True;
            Break;
          end;
        end;
        //ShowMessage(WeaponOnShip.Weapon_Name);
        { Show Weapon Status }
        FrameWeaponStatus.ShowWeaponPanel(WeaponOnShip.Weapon_Name);
        
        if not isFound then
        begin

          { Device Name }
          MenuItem          := TMenuItem.Create(PopUpDeviceName);
          MenuItem.Caption  := WeaponOnShip.Weapon_Name;
          MenuItem.Tag      := WeaponOnShip.Weapon_ID;
          MenuItem.OnClick  := On_ClickPpDeviceName;
          PopUpDeviceName.Items.Add(MenuItem);
        end;
      end;

      for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
      begin
        WeaponOnShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

        if ( WeaponOnShip.Weapon_Name = edtDeviceName.Text ) and
           ( 'Launcher ' + IntToStr(WeaponOnShip.Weapon_Launcher) = edtDeviceLauncher.Text )
        then
        begin
          for j := 0 to WeaponOnShip.ListDetail.Count -1 do
          begin
            WeaponOnShipDetail := TWeaponRangeDetail(WeaponOnShip.ListDetail.Items[j]);
            if WeaponOnShipDetail.Detail_Name = edtDeviceType.Text then
            begin
              if WeaponOnShipDetail.isShowWeaponRange then
              begin
                btnRange.Caption := 'Hide Range';
                btnRange.Tag     := 2;
              end
              else
              begin
                btnRange.Caption := 'Show Range';
                btnRange.Tag     := 1;
              end;

              Break;
            end;
          end;

          break;
        end;
      end;
    end;
  end

end;

procedure TfrmeControl.RefreshFrame(aObject: TInsObject);
begin
  if Assigned(SimManager.TrackObject) then
  begin
    if TInsObject(SimManager.TrackObject).Tikas then
      btnTikas.Caption := 'Hide History'
    else
      btnTikas.Caption := 'Show History';
  end;
end;

procedure TfrmeControl.SetHandleEvent;
begin
  btnPpDeviceName.Tag     := 1;
  btnPpDeviceLauncher.Tag := 2;
  btnPpDeviceType.Tag     := 3;

  btnPpDeviceName.OnClick     := On_ClickBtnPopUp;
  btnPpDeviceLauncher.OnClick := On_ClickBtnPopUp;
  btnPpDeviceType.OnClick     := On_ClickBtnPopUp;
end;

procedure TfrmeControl.btnRangeClick(Sender: TObject);
var
  i,j : integer;
  WeaponShip : TWeaponOnShip;
  WeaponShipDetail : TWeaponRangeDetail;
begin
  if Assigned(SimManager.TrackObject) then
  begin
    for i := 0 to SimManager.TrackObject.WeaponOnShip_List.Count -1 do
    begin
      WeaponShip := TWeaponOnShip(SimManager.TrackObject.WeaponOnShip_List[i]);

      if ( WeaponShip.Weapon_Name = edtDeviceName.Text ) and
         ( 'Launcher ' + IntToStr(WeaponShip.Weapon_Launcher) = edtDeviceLauncher.Text )
      then
      begin
        for j := 0 to WeaponShip.ListDetail.Count -1 do
        begin
          WeaponShipDetail := TWeaponRangeDetail(WeaponShip.ListDetail.Items[j]);
          if WeaponShipDetail.Detail_Name = edtDeviceType.Text then
          begin
            case TComponent(sender).Tag of
              1 :
              begin
                WeaponShipDetail.isShowWeaponRange := True;
                SimManager.NetSend_ViewRangeWeapon(SimManager.TrackObject.UniqueID, edtDeviceName.Text,edtDeviceLauncher.Text,
                                                  edtDeviceType.Text, True);
                WeaponShipDetail.setWeaponHeading(SimManager.TrackObject.Course);
                btnRange.Tag     := 2;
                btnRange.Caption := 'Hide Range';
              end;

              2 :
              begin
                WeaponShipDetail.isShowWeaponRange := False;
                SimManager.NetSend_ViewRangeWeapon(SimManager.TrackObject.UniqueID, edtDeviceName.Text,edtDeviceLauncher.Text,
                                                  edtDeviceType.Text, False);
                btnRange.Tag     := 1;
                btnRange.Caption := 'Show Range';
              end;
            end;

            Break;
          end;
        end;

        break;
      end;
    end;
  end;
end;

procedure TfrmeControl.btnTikasClick(Sender: TObject);
begin
  if Assigned(SimManager.TrackObject) then
  begin
    if TInsObject(SimManager.TrackObject).Tikas then
    begin
      TInsObject(SimManager.TrackObject).VHistory.Visible := false;
      TInsObject(SimManager.TrackObject).Tikas := false;
      btnTikas.Caption := 'Show History';
    end
    else
    begin
      TInsObject(SimManager.TrackObject).VHistory.Visible := true;
      TInsObject(SimManager.TrackObject).Tikas := true;
      btnTikas.Caption := 'Hide History';
    end;
  end;
end;



end.
