unit ufEnvi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AdvSmoothButton, ComCtrls, VrControls,
  VrWheel,

  uBaseCoordSystem;
type
  TfrmMoreEnvi = class(TForm)
    pnlMain: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    eBuilding: TComboBox;
    eStaticShips: TComboBox;
    eBuoy: TComboBox;
    eTheme: TComboBox;
    btnClose: TAdvSmoothButton;
    gbSeaState: TGroupBox;
    tbSeaState: TTrackBar;
    GroupBox1: TGroupBox;
    tbWindSpeed: TTrackBar;
    vrwhlWindDirec: TVrWheel;
    lbl: TLabel;
    grpSeaSpeed: TGroupBox;
    tbSeaSpeed: TTrackBar;
    vrwhlSeaDirection: TVrWheel;
    lbl1: TLabel;
    grpTemp: TGroupBox;
    tbTemp: TTrackBar;
    edtSeaState: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtWindSpeed: TEdit;
    edtWindDirection: TEdit;
    edtCurrentSpeed: TEdit;
    edtCurrentDirection: TEdit;
    edtTemperature: TEdit;
    grpBaroPressure: TGroupBox;
    tbBaroPressure: TTrackBar;
    grpHumidity: TGroupBox;
    tbHumidity: TTrackBar;
    edtBaroPressure: TEdit;
    edtHumidity: TEdit;
    Label2: TLabel;
    lbl7: TLabel;
    gbFogHeight: TGroupBox;
    tbFogH: TTrackBar;
    lbl8: TLabel;
    edtFogheight: TEdit;
    lbl9: TLabel;
    eTree: TComboBox;
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
    procedure edtSeaStateKeyPress(Sender: TObject; var Key: Char);
    procedure edtWindSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCurrentSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure edtTemperatureKeyPress(Sender: TObject; var Key: Char);
    procedure edtWindDirectionKeyPress(Sender: TObject; var Key: Char);
    procedure edtCurrentDirectionKeyPress(Sender: TObject; var Key: Char);
    procedure tbBaroPressureChange(Sender: TObject);
    procedure tbHumidityChange(Sender: TObject);
    procedure tbFogHChange(Sender: TObject);
    procedure edtBaroPressureKeyPress(Sender: TObject; var Key: Char);
    procedure edtHumidityKeyPress(Sender: TObject; var Key: Char);
    procedure edtFogheightKeyPress(Sender: TObject; var Key: Char);
    procedure eTreeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    //For Port
    Building : integer;
    StaticShip : integer;
    Buoy : integer;
    Theme : integer;
    Tree : integer;

    //For Envi
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
end;

procedure TfrmMoreEnvi.SetDefaultEnvi;
begin
  
end;

procedure TfrmMoreEnvi.vrwhlWindDirecChange(Sender: TObject);
var
  newWindDir : Integer;
begin
  if vrwhlWindDirec.Position < 180 then
  begin
    newWindDir := (180 + vrwhlWindDirec.Position);

    edtWindDirection.Text := IntToStr(newWindDir);
    WindDir := newWindDir;
  end
  else
  begin
    newWindDir := (vrwhlWindDirec.Position - 180);

    edtWindDirection.Text := IntToStr(newWindDir);
    WindDir := newWindDir;
  end;
end;

procedure TfrmMoreEnvi.vrwhlSeaDirectionChange(Sender: TObject);
var
  newOceanDir : integer;
begin
  if vrwhlSeaDirection.Position < 180 then
  begin
    newOceanDir := (180 + vrwhlSeaDirection.Position);

    edtCurrentDirection.Text := IntToStr(newOceanDir);
    CurrentDir := newOceanDir;
  end
  else
  begin
    newOceanDir := (vrwhlSeaDirection.Position - 180);

    edtCurrentDirection.Text := IntToStr(newOceanDir);
    CurrentDir := newOceanDir;
  end;
end;

procedure TfrmMoreEnvi.tbSeaStateChange(Sender: TObject);
begin
  edtSeaState.Text := IntToStr(tbSeaState.Position);
  SeaState := tbSeaState.Position;
end;

procedure TfrmMoreEnvi.tbWindSpeedChange(Sender: TObject);
begin
  edtWindSpeed.Text := IntToStr(tbWindSpeed.Position);
  WindSpeed := tbWindSpeed.Position;
end;

procedure TfrmMoreEnvi.tbSeaSpeedChange(Sender: TObject);
begin
  edtCurrentSpeed.Text := IntToStr(tbSeaSpeed.Position);
  CurrentSpeed := tbSeaSpeed.Position;
end;

procedure TfrmMoreEnvi.tbTempChange(Sender: TObject);
begin
  edtTemperature.Text := IntToStr(tbTemp.Position);
  Temperature := tbTemp.Position;
end;

procedure TfrmMoreEnvi.edtSeaStateKeyPress(Sender: TObject; var Key: Char);
var
  NewSeaState  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtSeaState.Text, NewSeaState) then
    begin
      if NewSeaState > tbSeaState.Max then
      begin
        SeaState := tbSeaState.Max;
        edtSeaState.Text    := IntToStr(tbSeaState.Max);
        tbSeaState.Position := tbSeaState.Max;
      end
      else
      begin
        SeaState := NewSeaState;
        edtSeaState.Text    := IntToStr(NewSeaState);
        tbSeaState.Position := NewSeaState
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtSeaState.Text    := intToStr(SeaState);
      tbSeaState.Position := SeaState;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtWindSpeedKeyPress(Sender: TObject;
  var Key: Char);
var
  NewWindSpeed  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtWindSpeed.Text, NewWindSpeed) then
    begin
      if NewWindSpeed > tbWindSpeed.Max then
      begin
        WindSpeed := tbWindSpeed.Max;
        edtWindSpeed.Text    := IntToStr(tbWindSpeed.Max);
        tbWindSpeed.Position := tbWindSpeed.Max;
      end
      else
      begin
        WindSpeed := NewWindSpeed;
        edtWindSpeed.Text    := IntToStr(NewWindSpeed);
        tbWindSpeed.Position := NewWindSpeed;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtWindSpeed.Text    := intToStr(WindSpeed);
      tbWindSpeed.Position := WindSpeed;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtCurrentSpeedKeyPress(Sender: TObject;
  var Key: Char);
var
  NewCurrentSpeed  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtCurrentSpeed.Text, NewCurrentSpeed) then
    begin
      if NewCurrentSpeed > tbSeaSpeed.Max then
      begin
        CurrentSpeed := tbSeaSpeed.Max;
        edtCurrentSpeed.Text  := IntToStr(tbSeaSpeed.Max);
        tbSeaSpeed.Position   := tbSeaSpeed.Max;
      end
      else
      begin
        CurrentSpeed := NewCurrentSpeed;
        edtCurrentSpeed.Text  := IntToStr(NewCurrentSpeed);
        tbSeaSpeed.Position   := NewCurrentSpeed;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtCurrentSpeed.Text    := intToStr(CurrentSpeed);
      tbSeaSpeed.Position     := CurrentSpeed;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtTemperatureKeyPress(Sender: TObject;
  var Key: Char);
var
  NewTemprt  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtTemperature.Text, NewTemprt) then
    begin
      if NewTemprt > tbTemp.Max then
      begin
        Temperature := tbTemp.Max;
        edtTemperature.Text  := IntToStr(tbTemp.Max);
        tbTemp.Position      := tbTemp.Max;
      end
      else
      begin
        Temperature := NewTemprt;
        edtTemperature.Text   := IntToStr(NewTemprt);
        tbTemp.Position       := NewTemprt;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtTemperature.Text    := IntToStr(Temperature);
      tbTemp.Position        := Temperature;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtWindDirectionKeyPress(Sender: TObject;
  var Key: Char);
var
  NewWindDir : Double;
begin
  if Key = #13 then
  begin
    if TryStrToFloat(edtWindDirection.Text, NewWindDir) then
    begin
      edtWindDirection.Text   := IntToStr(Round(ValidateDegree(NewWindDir)));
      WindDir := Round(ValidateDegree(NewWindDir));

      if WindDir > 180 then
        vrwhlWindDirec.Position := (WindDir - 180)
      else
        vrwhlWindDirec.Position := (WindDir + 180);
    end
    else
    begin
      ShowMessage('Input Error');

      edtWindDirection.Text   := IntToStr(WindDir);
      if WindDir > 180 then
        vrwhlWindDirec.Position := (WindDir - 180)
      else
        vrwhlWindDirec.Position := (WindDir + 180);
    end;
  end;
end;

procedure TfrmMoreEnvi.edtCurrentDirectionKeyPress(Sender: TObject;
  var Key: Char);
var
  NewCurrentDir : Double;
begin
  if Key = #13 then
  begin
    if TryStrToFloat(edtCurrentDirection.Text, NewCurrentDir) then
    begin
      
      edtCurrentDirection.Text      := IntToStr(Round(ValidateDegree(NewCurrentDir)));
      CurrentDir := Round(ValidateDegree(NewCurrentDir));

      if CurrentDir > 180 then
        vrwhlSeaDirection.Position := (CurrentDir - 180)
      else
        vrwhlSeaDirection.Position := (CurrentDir + 180);
    end
    else
    begin
      ShowMessage('Input Error');

      edtCurrentDirection.Text   := IntToStr(CurrentDir);
      if CurrentDir > 180 then
        vrwhlSeaDirection.Position := (CurrentDir - 180)
      else
        vrwhlSeaDirection.Position := (CurrentDir + 180);
    end;
  end;
end;

procedure TfrmMoreEnvi.tbBaroPressureChange(Sender: TObject);
begin
  edtBaroPressure.Text := IntToStr(tbBaroPressure.Position);
  BaroPressure := tbBaroPressure.Position;
end;

procedure TfrmMoreEnvi.tbHumidityChange(Sender: TObject);
begin
  edtHumidity.Text := IntToStr(tbHumidity.Position);
  Humidity := tbHumidity.Position;
end;

procedure TfrmMoreEnvi.tbFogHChange(Sender: TObject);
begin
  edtFogheight.Text := IntToStr(tbFogH.Position);
  FogHeight := tbFogH.Position;
end;

procedure TfrmMoreEnvi.edtBaroPressureKeyPress(Sender: TObject;
  var Key: Char);
var
  NewBaro  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtBaroPressure.Text, NewBaro) then
    begin
      if NewBaro > tbBaroPressure.Max then
      begin
        BaroPressure := tbBaroPressure.Max;
        edtBaroPressure.Text  := IntToStr(tbBaroPressure.Max);
        tbBaroPressure.Position       := tbBaroPressure.Max;
      end
      else
      begin
        BaroPressure := NewBaro;
        edtBaroPressure.Text    := IntToStr(NewBaro);
        tbBaroPressure.Position := NewBaro;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtBaroPressure.Text    := IntToStr(BaroPressure);
      tbBaroPressure.Position := BaroPressure;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtHumidityKeyPress(Sender: TObject; var Key: Char);
var
  NewHumidity  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtHumidity.Text, NewHumidity) then
    begin
      if NewHumidity > tbHumidity.Max then
      begin
        Humidity := tbHumidity.Max;
        edtHumidity.Text    := IntToStr(tbHumidity.Max);
        tbHumidity.Position := tbHumidity.Max;
      end
      else
      begin
        Humidity := NewHumidity;
        edtHumidity.Text    := IntToStr(NewHumidity);
        tbHumidity.Position := NewHumidity;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtHumidity.Text    := IntToStr(BaroPressure);
      tbHumidity.Position := Humidity;
    end;
  end;
end;

procedure TfrmMoreEnvi.edtFogheightKeyPress(Sender: TObject;
  var Key: Char);
var
  NewFog  : Integer;
begin
  if Key = #13 then
  begin
    if TryStrToInt(edtFogheight.Text, NewFog) then
    begin
      if NewFog > tbFogH.Max then
      begin
        FogHeight := tbFogH.Max;
        edtFogheight.Text    := IntToStr(tbFogH.Max);
        tbFogH.Position      := tbFogH.Max;
      end
      else
      begin
        FogHeight := NewFog;
        edtFogheight.Text := IntToStr(NewFog);
        tbFogH.Position   := NewFog;
      end;
    end
    else
    begin
      ShowMessage('Input Error');

      edtFogheight.Text   := IntToStr(FogHeight);
      tbFogH.Position     := FogHeight;
    end;
  end;
end;
procedure TfrmMoreEnvi.eTreeChange(Sender: TObject);
begin
  Tree := eTree.ItemIndex;
end;

end.
