unit ufEnvi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AdvSmoothButton, ComCtrls, VrControls,
  VrWheel, AdvSmoothPanel, AdvSmoothLabel,

  uBaseCoordSystem, uClassDatabase, Buttons;
type
  TfrmMoreEnvi = class(TForm)
    pnlLeft: TAdvSmoothPanel;
    pnlRight: TAdvSmoothPanel;
    eBuilding: TComboBox;
    eStaticShips: TComboBox;
    eBuoy: TComboBox;
    eTheme: TComboBox;
    eTree: TComboBox;
    vrwhlWindDirec: TVrWheel;
    vrwhlSeaDirection: TVrWheel;
    tbWindSpeed: TTrackBar;
    tbSeaSpeed: TTrackBar;
    tbTemp: TTrackBar;
    tbBaroPressure: TTrackBar;
    tbHumidity: TTrackBar;
    tbFogH: TTrackBar;
    btnClose: TAdvSmoothButton;
    advsmthlbl1: TAdvSmoothLabel;
    AdvSmoothLabel1: TAdvSmoothLabel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    AdvSmoothLabel3: TAdvSmoothLabel;
    AdvSmoothLabel4: TAdvSmoothLabel;
    AdvSmoothLabel5: TAdvSmoothLabel;
    AdvSmoothLabel6: TAdvSmoothLabel;
    AdvSmoothLabel7: TAdvSmoothLabel;
    AdvSmoothLabel8: TAdvSmoothLabel;
    AdvSmoothLabel9: TAdvSmoothLabel;
    AdvSmoothLabel10: TAdvSmoothLabel;
    AdvSmoothLabel11: TAdvSmoothLabel;
    AdvSmoothLabel12: TAdvSmoothLabel;
    AdvSmoothLabel13: TAdvSmoothLabel;
    AdvSmoothLabel15: TAdvSmoothLabel;
    tbSeaState: TTrackBar;
    lblSeaState: TLabel;
    lblWindSpeed: TLabel;
    lblWindDirection: TLabel;
    lblCurrentDirection: TLabel;
    lblCurrentSpeed: TLabel;
    lblTemperature: TLabel;
    lblBaroPressure: TLabel;
    lblHumidity: TLabel;
    lblFogHeight: TLabel;
    AdvSmoothLabel14: TAdvSmoothLabel;
    advsmthlbl2: TAdvSmoothLabel;
    advsmthlbl3: TAdvSmoothLabel;
    advsmthlbl4: TAdvSmoothLabel;
    advsmthlbl5: TAdvSmoothLabel;
    advsmthlbl6: TAdvSmoothLabel;
    advsmthlbl7: TAdvSmoothLabel;
    advsmthlbl8: TAdvSmoothLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure eBuildingChange(Sender: TObject);
    procedure eStaticShipsChange(Sender: TObject);
    procedure eBuoyChange(Sender: TObject);
    procedure eThemeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vrwhlWindDirecChange(Sender: TObject);
    procedure vrwhlSeaDirectionChange(Sender: TObject);
    procedure tbSeaStateChange(Sender: TObject);
    procedure tbWindSpeedChange(Sender: TObject);
    procedure tbSeaSpeedChange(Sender: TObject);
    procedure tbTempChange(Sender: TObject);
    procedure tbBaroPressureChange(Sender: TObject);
    procedure tbHumidityChange(Sender: TObject);
    procedure tbFogHChange(Sender: TObject);
    procedure eTreeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    { For Port }
    Building : integer;
    StaticShip : integer;
    Buoy : integer;
    Theme : integer;
    Tree : integer;

    { For Envi }
    SeaState,
    WindSpeed,
    WindDir,
    CurrentSpeed,
    CurrentDir,
    Temperature,
    BaroPressure,
    Humidity,
    FogHeight : integer;

    procedure SetDefaultEnvi;
  end;

var
  frmMoreEnvi: TfrmMoreEnvi;

implementation

{$R *.dfm}

procedure TfrmMoreEnvi.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMoreEnvi.eBuildingChange(Sender: TObject);
begin
  Building := eBuilding.ItemIndex;
end;

procedure TfrmMoreEnvi.eBuoyChange(Sender: TObject);
begin
  Buoy := eBuoy.ItemIndex;
end;

procedure TfrmMoreEnvi.eStaticShipsChange(Sender: TObject);
begin
  StaticShip := eStaticShips.ItemIndex;
end;

procedure TfrmMoreEnvi.eThemeChange(Sender: TObject);
begin
  Theme := eTheme.ItemIndex;
end;

procedure TfrmMoreEnvi.FormCreate(Sender: TObject);
begin
  SetDefaultEnvi;

end;

procedure TfrmMoreEnvi.SetDefaultEnvi;
begin
  Building      := 0;
  StaticShip    := 0;
  Buoy          := 0;
  Theme         := 0;
  Tree          := 0;

  SeaState      := 1;
  WindSpeed     := 0;
  WindDir       := 0;
  CurrentSpeed  := 0;
  CurrentDir    := 0;
  Temperature   := 30;
  BaroPressure  := 0;
  Humidity      := 0;
  fogHeight     := 0;

  tbSeaState.Brush.Color      := clSilver;
  tbWindSpeed.Brush.Color     := clSilver;
  tbSeaSpeed.Brush.Color      := clSilver;
  tbTemp.Brush.Color          := clSilver;
  tbBaroPressure.Brush.Color  := clSilver;
  tbHumidity.Brush.Color      := clSilver;
  tbFogH.Brush.Color          := clSilver;
  vrwhlWindDirec.BackImage.LoadFromFile('..\data\images\NFS instruktur - interface\bmp\main\button_rotary_mini.bmp');
  vrwhlSeaDirection.BackImage.LoadFromFile('..\data\images\NFS instruktur - interface\bmp\main\button_rotary_mini.bmp');
end;

procedure TfrmMoreEnvi.vrwhlWindDirecChange(Sender: TObject);
var
  newWindDir : Integer;
begin
  if vrwhlWindDirec.Position < 180 then
  begin
    newWindDir := (180 + vrwhlWindDirec.Position);

    WindDir := newWindDir;
  end
  else
  begin
    newWindDir := (vrwhlWindDirec.Position - 180);

    WindDir := newWindDir;
  end;
  lblWindDirection.Caption := IntToStr(newWindDir);
end;

procedure TfrmMoreEnvi.vrwhlSeaDirectionChange(Sender: TObject);
var
  newOceanDir : integer;
begin
  if vrwhlSeaDirection.Position < 180 then
  begin
    newOceanDir := (180 + vrwhlSeaDirection.Position);

    CurrentDir := newOceanDir;
  end
  else
  begin
    newOceanDir := (vrwhlSeaDirection.Position - 180);

    CurrentDir := newOceanDir;
  end;
  lblCurrentDirection.Caption := IntToStr(newOceanDir);
end;

procedure TfrmMoreEnvi.tbSeaStateChange(Sender: TObject);
begin
  lblSeaState.Caption := IntToStr(tbSeaState.Position);
  SeaState            := tbSeaState.Position;
end;

procedure TfrmMoreEnvi.tbWindSpeedChange(Sender: TObject);
begin
  lblWindSpeed.Caption := IntToStr(tbWindSpeed.Position);
  WindSpeed := tbWindSpeed.Position;
end;

procedure TfrmMoreEnvi.tbSeaSpeedChange(Sender: TObject);
begin
  lblCurrentSpeed.Caption := IntToStr(tbSeaSpeed.Position);
  CurrentSpeed := tbSeaSpeed.Position;
end;

procedure TfrmMoreEnvi.tbTempChange(Sender: TObject);
begin
  lblTemperature.Caption := IntToStr(tbTemp.Position);
  Temperature := tbTemp.Position;
end;

procedure TfrmMoreEnvi.tbBaroPressureChange(Sender: TObject);
begin
  lblBaroPressure.Caption := IntToStr(tbBaroPressure.Position);
  BaroPressure := tbBaroPressure.Position;
end;

procedure TfrmMoreEnvi.tbHumidityChange(Sender: TObject);
begin
  lblHumidity.Caption := IntToStr(tbHumidity.Position);
  Humidity := tbHumidity.Position;
end;

procedure TfrmMoreEnvi.tbFogHChange(Sender: TObject);
begin
  lblFogHeight.Caption := IntToStr(tbFogH.Position);
  FogHeight := tbFogH.Position;
end;

procedure TfrmMoreEnvi.eTreeChange(Sender: TObject);
begin
  Tree := eTree.ItemIndex;
end;

end.
