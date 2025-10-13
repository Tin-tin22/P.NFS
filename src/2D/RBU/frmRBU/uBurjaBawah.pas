unit uBurjaBawah;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  VrControls,
  VrJogMeter,
  vrTypemeter,
  VrWheel,
  RzBmpBtn,
  VrDesign,

  //RotationIndicator,
  //RotationMeter,
  VrRotarySwitch, RotationMeter;

type
  TfrmBurjaBawah = class(TForm)
    bvl1: TBevel;
    wRadiusSas: TVrWheel;
    wKorCuaca: TVrWheel;
    wArahAngin: TVrWheel;
    wKecAngin: TVrWheel;
    wKecTPO: TVrWheel;
    wBarelTPO: TVrWheel;
    img7: TImage;
    img9: TImage;
    img11: TImage;
    img13: TImage;
    pnl16: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    img19: TImage;
    pnl11: TPanel;
    img20: TImage;
    pnl12: TPanel;
    img21: TImage;
    pnl13: TPanel;
    img22: TImage;
    pnl14: TPanel;
    img23: TImage;
    pnl15: TPanel;
    img24: TImage;
    pnl17: TPanel;
    img25: TImage;
    pnl18: TPanel;
    img26: TImage;
    img33: TImage;
    img34: TImage;
    img27: TImage;
    pnl19: TPanel;
    img28: TImage;
    pnl20: TPanel;
    img31: TImage;
    img32: TImage;
    pnl21: TPanel;
    pnl22: TPanel;
    img36: TImage;
    pnl23: TPanel;
    img39: TImage;
    img40: TImage;
    pnl24: TPanel;
    vrwhlELEVASI_DALAM: TVrWheel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    pnl28: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    img42: TImage;
    img43: TImage;
    img44: TImage;
    img45: TImage;
    img46: TImage;
    img47: TImage;
    btnJARTPO: TRzBmpButton;
    btnBARTPO: TRzBmpButton;
    btnHalSAS: TRzBmpButton;
    btnHalKPL: TRzBmpButton;
    btnBARELSAS: TRzBmpButton;
    btnTRAINING: TRzBmpButton;
    btnSDTCEGAT: TRzBmpButton;
    btnKECSAS: TRzBmpButton;
    btnLONCBRT: TRzBmpButton;
    btnKEDALAMAN: TRzBmpButton;
    btnELEVASI: TRzBmpButton;
    btnJARAK: TRzBmpButton;
    btnKECKAPAL: TRzBmpButton;
    btn_Mode_TrainWar: TRzBmpButton;
    btn108R: TVrBitmapButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btn108L: TVrBitmapButton;
    lbl_RadiusSas: TLabel;
    lbl_KorCuaca: TLabel;
    lbl_KecAngin: TLabel;
    lbl_ArahAngin: TLabel;
    lbl_BarelTPO: TLabel;
    lbl_KecTPO: TLabel;
    vrjgmtrRadiusSasaran: TVrJogMeter;
    img1: TImage;
    vrjgmtrArahAngin: TVrJogMeter;
    vrjgmtrKecAngin: TVrJogMeter;
    vrjgmtrKORCuaca: TVrJogMeter;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    vrjgmtrBarelTPO: TVrJogMeter;
    vrjgmtrKecTPO: TVrJogMeter;
    img5: TImage;
    img6: TImage;
    vrtryswtch1: TVrRotarySwitch;
    edt_Elevasi: TEdit;
    m1: TPanel;
    btn1: TButton;
    chkRestart: TRadioButton;
    chkShutdown: TRadioButton;
    chkClose: TRadioButton;
    CIElevasi: TCompassIndicator;
    procedure FormCreate(Sender: TObject);
    procedure btnJARTPOClick(Sender: TObject);
    procedure wRadiusSasChange(Sender: TObject);
    procedure btn108RClick(Sender: TObject);
    procedure btn108LClick(Sender: TObject);
    procedure wKorCuacaChange(Sender: TObject);
    procedure wArahAnginChange(Sender: TObject);
    procedure wKecAnginChange(Sender: TObject);
    procedure wKecTPOChange(Sender: TObject);
    procedure wBarelTPOChange(Sender: TObject);
    procedure vrwhlELEVASI_DALAMChange(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlELEVASI_DALAMMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlELEVASI_DALAMMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wArahAnginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wArahAnginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wRadiusSasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wRadiusSasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKorCuacaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKorCuacaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKecAnginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKecAnginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wBarelTPOMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wBarelTPOMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKecTPOMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wKecTPOMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure vrtryswtch1Change(Sender: TObject);
    procedure btn_Mode_TrainWarClick(Sender: TObject);
    procedure edt_ElevasiChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure pnl30MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnl31MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    Keypnl1,
    Keypnl2 : Boolean;

  public
    val:Double;

    LastVal_KecTPO,
    Val_KecTPO,

    LastVal_BarelTPo,
    Val_BarelTPo,

    LastVal_RadiusSas,
    Val_RadiusSas,

    LastVal_ArahAngin,
    Val_ArahAngin,

    LastVal_KecAngin,
    Val_KecAngin,

    LastVal_KorCuaca,
    Val_KorCuaca,

    Val_ElevKedalaman,
    LastVal_ElevKedalaman : Single;


    { Public declarations }

  end;

var
  frmBurjaBawah: TfrmBurjaBawah;

implementation
uses
  uMain, uBurjaAtas, uLibRBU, uRBU_Manager, uBaseConstan, uBaseFunction;

{$R *.dfm}

procedure TfrmBurjaBawah.btn108LClick(Sender: TObject);
begin
   uRBU_Manager.RBU_MAnager.frm108Kiri.Show;
end;

procedure TfrmBurjaBawah.btn108RClick(Sender: TObject);
begin
  uRBU_Manager.RBU_MAnager.frm108Kanan.Show;
end;

procedure TfrmBurjaBawah.btn1Click(Sender: TObject);
begin
   Application.Terminate;
if chkShutdown.Checked then
  WindowsExit(EWX_POWEROFF or EWX_FORCE);   // Shutdown
if chkRestart.Checked then
  WindowsExit(EWX_REBOOT or EWX_FORCE);     // Restart
if chkClose.Checked then
  Application.Terminate;                    // Restart

end;

procedure TfrmBurjaBawah.btnJARTPOClick(Sender: TObject);
var s : string;
begin
   case (sender as TRzBmpButton).Tag of
     31 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgJARTPO , btnJARTPO.Down);
            State_JarTPO := btnJARTPO.Down;
            if State_JarTPO then
              s := 'saklar JAR TPO switch on'
            else
              s := 'saklar JAR TPO switch off';
          end;
     32 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgBARTPO , btnBARTPO.Down);
            State_BarTPO := btnBARTPO.Down;
            if State_BarTPO then
              s := 'saklar BAR TPO switch on'
            else
              s := 'saklar BAR TPO switch off';
          end;
     33 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgHALSAS ,btnHalSAS.Down);
            State_HalSAS  := btnHalSAS.Down;

            if State_HalSAS then
              s := 'saklar HAL SAS switch on'
            else
              s := 'saklar HAL SAS switch off';
          end;
     34 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgHALKPL ,btnHalKPL.Down);
            State_HalKPL := btnHalKPL.Down;
            if State_HalKPL then
              s := 'saklar HAL KPL switch on'
            else
              s := 'saklar HAL KPL switch off';
          end;
     35 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgBARELSAS, btnBARELSAS.Down);
            State_BarSAS  := btnBARELSAS.Down;
            if State_BarSAS then
              s := 'saklar BAREL SAS switch on'
            else
              s := 'saklar BAREL SAS switch off';
          end;
     36 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgTRAINING, btnTRAINING.Down);
            State_Training := btnTRAINING.Down;
            if State_Training then
              s := 'saklar TRAINING switch on'
            else
              s := 'saklar TRAINING switch off';
          end;
     37 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgSDTCEGAT, btnSDTCEGAT.Down);
            State_SDTCegat := btnSDTCEGAT.Down;
            if State_Training then
              s := 'saklar SDT CEGAT switch on'
            else
              s := 'saklar SDT CEGAT switch off';
          end;

     41 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgKECSAS, btnKECSAS.Down);
            State_KecSAS  := btnKECSAS.Down;
            if State_KecSAS then
              s := 'saklar KEC SAS switch on'
            else
              s := 'saklar KEC SAS switch off';
          end;
     42 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgKECKPL, btnKECKAPAL.Down);
            State_KecKPL := btnKECKAPAL.Down;
            if State_KecKPL then
              s := 'saklar KEC KAPAL switch on'
            else
              s := 'saklar KEC KAPAL switch off';
          end;
     43 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgLONCBRT, btnLONCBRT.Down);
            State_LonchBRT := btnLONCBRT.Down;
            if State_LonchBRT then
              s := 'saklar LONC BRT switch on'
            else
              s := 'saklar LONC BRT switch off';
          end;
     44 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgKEDALAMAN, btnKEDALAMAN.Down);
            State_Kedalaman := btnKEDALAMAN.Down;
            if State_Kedalaman then
              s := 'saklar KEDALAMAN switch on'
            else
              s := 'saklar KEDALAMAN switch off';
          end;
     45 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgELEVASI, btnELEVASI.Down);
            State_Elevasi := btnELEVASI.Down;
            if State_Elevasi then
              s := 'saklar ELEVASI switch on'
            else
              s := 'saklar ELEVASI switch off';
          end;
     46 : begin
            SetImageIndikatorwithButton(uRBU_Manager.RBU_MAnager.frmTopBurja.imgJARAK, btnJARAK.Down);
            State_Jarak := btnJARAK.Down;
            if State_Jarak then
              s := 'saklar JARAK switch on'
            else
              s := 'saklar JARAK switch off';
          end;
   end;

   SetChangeImageIndikator(RBU_MAnager.frm108Kiri.imgAliranBurja,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', StatusAliranBurja);
   RBU_MAnager.frm108Kiri.BurjaSignal_is_On := StatusAliranBurja;
   SetChangeImageIndikator(RBU_MAnager.frm108Kanan.imgAliranBurja,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', StatusAliranBurja);
   RBU_MAnager.frm108Kanan.BurjaSignal_is_On := StatusAliranBurja;

end;

procedure TfrmBurjaBawah.btn_Mode_TrainWarClick(Sender: TObject);
begin
  Is_WarMode := btn_Mode_TrainWar.Down;
  if Is_WarMode then
    RBU_MAnager.SendEvenRBU(1)
  else
    RBU_MAnager.SendEvenRBU(2);
end;

procedure TfrmBurjaBawah.edt_ElevasiChange(Sender: TObject);
var bal : Word;
begin
  CIElevasi.Value := (StrToFloat(edt_Elevasi.Text));
  CIElevasi.Scale := 0.05;
  CIElevasi.ScaleOut := 3.6;

  Lonch1.ElevationAngle  := StrToFloat(edt_Elevasi.text) * C_TD_To_Degree;  // Value Elevation Angle  [Elevasi + Koreksi elevasi]
  Lonch2.ElevationAngle  := Lonch1.ElevationAngle;

end;

procedure TfrmBurjaBawah.FormCreate(Sender: TObject);
var I : Integer;
begin
  vrjgmtrRadiusSasaran.Scale.Position := voAfter;
  vrjgmtrArahAngin.Scale.Position := voAfter;
  vrjgmtrKecAngin.Scale.Position := voAfter;
  vrjgmtrKORCuaca.Scale.Position := voAfter;
  vrjgmtrBarelTPO.Scale.Position := voAfter;
  vrjgmtrKecTPO.Scale.Position := voAfter;

  Val_ElevKedalaman     := 0;
  LastVal_ElevKedalaman := 0;

  CIElevasi.LoadBGImage(path_image_burja + '200px_back.bmp');
  CIElevasi.LoadOutImage(path_image_burja + 'LonchHaluanOut.bmp');
  CIElevasi.LoadInImage(path_image_burja +  'Elevasi_Dalam_In.bmp');
  CIElevasi.Parent := self;
  CIElevasi.Value := 0;
  CIElevasi.ValMin := 0;
  CIElevasi.ValMax := 2000;
  CIElevasi.Line := LTop;

  val:=0;

   for I := 0 to ComponentCount - 1 do
    if (Components[I] is TRzBmpButton) then
      if (Components[I].Tag>=30) and (Components[I].Tag<=46) then
       with (Components[I] as TRzBmpButton).Bitmaps do begin
          Down.LoadFromFile(path_image_burja + 'switch_on.bmp');
          StayDown.LoadFromFile(path_image_burja + 'switch_on.bmp');
          Up.LoadFromFile(path_image_burja + 'switch_off.bmp');
          UpAndFocused.LoadFromFile(path_image_burja + 'switch_off.bmp');
       end;

  Is_WarMode := True;
  BalistikMode    := BlAuto;
end;


procedure TfrmBurjaBawah.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  if ssShift in Shift then
//    frm_Main.Visible := true
//  else
//    frm_Main.Visible := False;

  Keypnl1 := False;
  Keypnl2 := False;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaBawah.FormShow(Sender: TObject);
begin
 // vrjgmtrKORCuaca.Scale.Position := vr
end;

procedure TfrmBurjaBawah.pnl30MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Keypnl2 := True;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaBawah.pnl31MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Keypnl1 := True;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaBawah.wRadiusSasChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wRadiusSas.Position / wRadiusSas.MaxValue);
  if (LastVal_RadiusSas = Pos) then Exit;

  if LastVal_RadiusSas > Pos then
    Val_RadiusSas := Val_RadiusSas - 1
  else if LastVal_RadiusSas < Pos then
    Val_RadiusSas := Val_RadiusSas + 1;

  if (Val_RadiusSas <0) then
    Val_RadiusSas := 0;
  if (Val_RadiusSas > 800.00) then
    Val_RadiusSas := 800.00;

  LastVal_RadiusSas := Pos;

//  RIBarelSas.Degree := -d;
  lbl_RadiusSas.Caption := FormatFloat('00.0#',Val_RadiusSas);
  vrjgmtrRadiusSasaran.Value.Value := StrToFloat(lbl_RadiusSas.Caption);

end;

procedure TfrmBurjaBawah.wRadiusSasMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_RadiusSas.Visible := True;
end;

procedure TfrmBurjaBawah.wRadiusSasMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_RadiusSas.Visible := False;
end;

procedure TfrmBurjaBawah.wKorCuacaChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wKorCuaca.Position / wKorCuaca.MaxValue);
  if (LastVal_KorCuaca  = Pos) then Exit;

  if LastVal_KorCuaca  > Pos then
    Val_KorCuaca   := Val_KorCuaca - 0.1
  else if LastVal_KorCuaca < Pos then
    Val_KorCuaca := Val_KorCuaca + 0.1;

  if (Val_KorCuaca < -60) then
    Val_KorCuaca := -60;
  if (Val_KorCuaca > 60) then
    Val_KorCuaca := 60;

  LastVal_KorCuaca := Pos;

//  RIBarelSas.Degree := -d;
  lbl_KorCuaca.Caption := FormatFloat('00.#',Val_KorCuaca);
  vrjgmtrKORCuaca.Value.Value := StrToFloat(lbl_KorCuaca.Caption);
end;

procedure TfrmBurjaBawah.wKorCuacaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_KorCuaca.Visible := True;
end;

procedure TfrmBurjaBawah.wKorCuacaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   lbl_KorCuaca.Visible := False;
end;

procedure TfrmBurjaBawah.wArahAnginChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wArahAngin.Position / wArahAngin.MaxValue);
  if (LastVal_ArahAngin  = Pos) then Exit;

  if LastVal_ArahAngin > Pos then
    Val_ArahAngin  := Val_ArahAngin - 0.1
  else if LastVal_ArahAngin < Pos then
    Val_ArahAngin := Val_ArahAngin + 0.1;

  if (Val_ArahAngin < 0) then
    Val_ArahAngin := 359.9;
  if (Val_ArahAngin > 359.9) then
    Val_ArahAngin := 0;

  LastVal_ArahAngin := Pos;

//  RIBarelSas.Degree := -d;
  lbl_ArahAngin.Caption := FormatFloat('00.#',Val_ArahAngin);
  vrjgmtrArahAngin.Value.Value := StrToFloat(lbl_ArahAngin.Caption);
end;

procedure TfrmBurjaBawah.wArahAnginMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_ArahAngin.Visible := True;
end;

procedure TfrmBurjaBawah.wArahAnginMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_ArahAngin.Visible := False;
end;

procedure TfrmBurjaBawah.wKecAnginChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wKecAngin.Position / wKecAngin.MaxValue);
  if (LastVal_KecAngin  = Pos) then Exit;

  if LastVal_KecAngin > Pos then
    Val_KecAngin  := Val_KecAngin - 0.1
  else if LastVal_KecAngin < Pos then
    Val_KecAngin := Val_KecAngin + 0.1;

  if (Val_KecAngin <0) then
    Val_KecAngin := 0;
  if (Val_KecAngin > 20) then
    Val_KecAngin := 20;

  LastVal_KecAngin := Pos;

//  RIBarelSas.Degree := -d;
  lbl_KecAngin.Caption := FormatFloat('00.#',Val_KecAngin);
  vrjgmtrKecAngin.Value.Value := StrToFloat(lbl_KecAngin.Caption);

end;

procedure TfrmBurjaBawah.wKecAnginMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_KecAngin.Visible := True;
end;

procedure TfrmBurjaBawah.wKecAnginMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_KecAngin.Visible := False;
end;

procedure TfrmBurjaBawah.wKecTPOChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wKecTPO.Position / wKecTPO.MaxValue);
  if (LastVal_KecTPO = Pos) then Exit;

  if LastVal_KecTPO > Pos then
    Val_KecTPO  := Val_KecTPO - 0.1
  else if LastVal_KecTPO < Pos then
    Val_KecTPO := Val_KecTPO + 0.1;

  if (Val_KecTPO < 0) then
    Val_KecTPO := 0;
  if (Val_KecTPO > 60) then
    Val_KecTPO := 60;

  LastVal_KecTPO := Pos;

//  RIBarelSas.Degree := -d;
  lbl_KecTPO.Caption := FormatFloat('00.#',Val_KecTPO);
  vrjgmtrKecTPO.Value.Value := StrToFloat(lbl_KecTPO.Caption);
end;

procedure TfrmBurjaBawah.wKecTPOMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_KecTPO.Visible := True;
end;

procedure TfrmBurjaBawah.wKecTPOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_KecTPO.Visible := False;
end;

procedure TfrmBurjaBawah.vrtryswtch1Change(Sender: TObject);
begin
  BalistikMode:= TBalistikMode(vrtryswtch1.SwitchPosition);
  case BalistikMode of
    Balistik1 : RBU_MAnager.SendEvenRBU(3);
    Balistik2 : RBU_MAnager.SendEvenRBU(4);
    BlAuto    : RBU_MAnager.SendEvenRBU(5);
  end;
end;

procedure TfrmBurjaBawah.vrwhlELEVASI_DALAMChange(Sender: TObject);
var Pos  : single;
Val_elef : Double;
bal : Word;
begin
  Pos := 100 * (vrwhlELEVASI_DALAM.Position / vrwhlELEVASI_DALAM.MaxValue);
  if (LastVal_ElevKedalaman = Pos) then Exit;

  if LastVal_ElevKedalaman > Pos then
    Val_ElevKedalaman := Val_ElevKedalaman - 1
  else if LastVal_ElevKedalaman < Pos then
    Val_ElevKedalaman := Val_ElevKedalaman + 1;

  if (Val_ElevKedalaman < 0) then
    Val_ElevKedalaman := 0;
  if (Val_ElevKedalaman > 800) then
    Val_ElevKedalaman := 800;
  LastVal_ElevKedalaman := Pos;

  edt_Elevasi.Text  := FormatFloat('#0',Val_ElevKedalaman);

  if BalistikMode = Balistik1 then
    bal := 1
  else
    bal := 2;

  RBU_MAnager.frmTopBurja.edtJarak.Text := FormatFloat('#0.0',
  ConvElevToRange(bal , (Val_ElevKedalaman * C_TD_To_Degree))  * C_Meter_To_Cable);

end;

procedure TfrmBurjaBawah.vrwhlELEVASI_DALAMMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_Elevasi.Visible := True;
  RBU_MAnager.frmTopBurja.edtJarak.Visible := edt_Elevasi.Visible;
end;

procedure TfrmBurjaBawah.vrwhlELEVASI_DALAMMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_Elevasi.Visible := False;
  RBU_MAnager.frmTopBurja.edtJarak.Visible := edt_Elevasi.Visible;
end;

procedure TfrmBurjaBawah.wBarelTPOChange(Sender: TObject);
var Pos : single;
begin
  Pos := 10 * (wBarelTPO.Position / wBarelTPO.MaxValue);
  if (LastVal_BarelTPo = Pos) then Exit;

  if LastVal_BarelTPo > Pos then
    Val_BarelTPo  := Val_BarelTPo - 0.1
  else if LastVal_BarelTPo < Pos then
    Val_BarelTPo := Val_BarelTPo + 0.1;

  if (Val_BarelTPo < -60) then
    Val_BarelTPo := -60;
  if (Val_BarelTPo > 60) then
    Val_BarelTPo := 60;

  LastVal_BarelTPo := Pos;

//  RIBarelSas.Degree := -d;
  lbl_BarelTPO.Caption := FormatFloat('00.#',Val_BarelTPo);
  vrjgmtrBarelTPO.Value.Value := StrToFloat(lbl_BarelTPO.Caption);
end;

procedure TfrmBurjaBawah.wBarelTPOMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbl_BarelTPO.Visible := True;
end;

procedure TfrmBurjaBawah.wBarelTPOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lbl_BarelTPO.Visible := False;
end;

end.
