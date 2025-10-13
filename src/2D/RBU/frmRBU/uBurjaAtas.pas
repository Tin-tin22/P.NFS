unit uBurjaAtas;

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
  StdCtrls,
  ExtCtrls,
  ComCtrls,

  VrControls,
  VrWheel,
  Menus,
  ShellAPI,
  MapXLib_TLB,

  //RotationIndicator,
  {RotationMeter}
   Spin, RotationMeter
  ;

type
  TfrmBurjaAtas = class(TForm)
    vrwhlHALU_HALSAS: TVrWheel;
    pnl1: TPanel;
    pnl2: TPanel;
    img_Balistik17: TImage;
    img3: TImage;
    img4: TImage;
    Bevel1: TBevel;
    vrwhlKOREKSI_HALSAS: TVrWheel;
    imgHALSAS: TImage;
    img31: TImage;
    img30: TImage;
    img33: TImage;
    img34: TImage;
    pnl3: TPanel;
    pnl4: TPanel;
    img_Bahaya_Tpo: TImage;
    img26: TImage;
    img27: TImage;
    vrwhlKEC_SASARAN: TVrWheel;
    vrwhlKEDALAMAN: TVrWheel;
    vrwhlJARAK_DLM_KABEL: TVrWheel;
    pnl6: TPanel;
    pnl5: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl21: TPanel;
    img_KontakHilang: TImage;
    vrwhlKOREKSI_TRAINING: TVrWheel;
    vrwhlKOREKSI_ELEVASI: TVrWheel;
    vrwhlBAREL_SAS: TVrWheel;
    vrwhlHALU_KAPAL: TVrWheel;
    vrwhlKEC_KAPAL: TVrWheel;
    imgHALKPL: TImage;
    imgBARTPO: TImage;
    imgBARELSAS: TImage;
    imgSDTCEGAT: TImage;
    imgTRAINING: TImage;
    imgLONCBRT: TImage;
    imgJARAK: TImage;
    imgELEVASI: TImage;
    imgKEDALAMAN: TImage;
    imgJARTPO: TImage;
    imgKECKPL: TImage;
    imgKECSAS: TImage;
    img_Perubahan_Halu: TImage;
    img21: TImage;
    img22: TImage;
    img23: TImage;
    img24: TImage;
    img2: TImage;
    img6: TImage;
    img28: TImage;
    img20: TImage;
    img36: TImage;
    img39: TImage;
    img40: TImage;
    img9: TImage;
    img10: TImage;
    CIHaluSasaran: TCompassIndicator;
    RmBarSasaran: TRotationMeter;
    CIHaluKapal: TCompassIndicator;
    CILonchHaluan: TCompassIndicator;
    CILonchBuritan: TCompassIndicator;
    RmKoreksiHalsas: TRotationMeter;
    RmKoreksiTraining: TRotationMeter;
    CIBarelSas: TCompassIndicator;
    RmKecSassaran: TRotationMeter;
    RmKecKapal: TRotationMeter;
    RmKedalaman: TRotationMeter;
    CIJarakDlmKabel: TCompassIndicator;
    RmKoreksiElevasi: TRotationMeter;
    edtJarak: TEdit;
    edtKecSasaran: TEdit;
    edt_BarelSas: TEdit;
    edt_HaluSasaran: TEdit;
    edt_KoreksiHalsas: TEdit;
    edt_haluKapal: TEdit;
    edt_KoreksiElevasi: TEdit;
    edt_Keckapal: TEdit;
    edt_Kedalaman: TEdit;
    edt_BarSasaran: TEdit;
    edt_KoreksiTraining: TEdit;
    m1: TPanel;
    btn1: TButton;
    chkRestart: TRadioButton;
    chkShutdown: TRadioButton;
    rbclose: TRadioButton;
    m2: TPanel;
    se1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure vrwhlHALU_HALSASChange(Sender: TObject);
    procedure vrwhlKOREKSI_HALSASChange(Sender: TObject);
    procedure vrwhlBAREL_SASChange(Sender: TObject);
    procedure vrwhlKOREKSI_TRAININGChange(Sender: TObject);
    procedure vrwhlKEC_KAPALChange(Sender: TObject);
    procedure vrwhlKOREKSI_ELEVASIChange(Sender: TObject);
    procedure vrwhlKEDALAMANChange(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlHALU_HALSASMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlHALU_HALSASMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_HALSASMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_HALSASMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlHALU_KAPALMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlHALU_KAPALMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlBAREL_SASMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlBAREL_SASMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_TRAININGMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_TRAININGMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_ELEVASIMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKOREKSI_ELEVASIMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlJARAK_DLM_KABELMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vrwhlJARAK_DLM_KABELMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEC_SASARANMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEC_SASARANMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEDALAMANMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEDALAMANMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEC_KAPALMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlKEC_KAPALMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vrwhlHALU_KAPALChange(Sender: TObject);
    procedure vrwhlKEC_SASARANChange(Sender: TObject);
    procedure vrwhlJARAK_DLM_KABELChange(Sender: TObject);
    procedure edtJarakChange(Sender: TObject);
    procedure edtKecSasaranChange(Sender: TObject);
    procedure edt_BarelSasChange(Sender: TObject);
    procedure edt_HaluSasaranChange(Sender: TObject);
    procedure edt_KoreksiHalsasChange(Sender: TObject);
    procedure edt_haluKapalChange(Sender: TObject);
    procedure edt_KoreksiElevasiChange(Sender: TObject);
    procedure edt_KeckapalChange(Sender: TObject);
    procedure edt_KedalamanChange(Sender: TObject);
    procedure edt_KoreksiTrainingChange(Sender: TObject);
    procedure edt_BarSasaranChange(Sender: TObject);
    procedure img30Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure pnl6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnl7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure se1Change(Sender: TObject);

  private
    { Private declarations }
    Count_HaluSasaran,
    Count_HaluKapal     : Integer;

    Val_JarakDlmKabel,
    LastVal_JarakDlmKabel,

    Val_KoreksiTraining,
    LastVal_KoreksiTraining,

    Val_KoreksiElevasi,
    LastVal_KoreksiElevasi,

    Val_Kedalaman,
    LastVal_Kedalaman,

    Val_KecKapal,
    LastVal_KecKapal,

    Val_KecSasaran,
    LastVal_KecSasaran,

    Val_KoreksiHalSas,
    LastVal_KoreksiHalSas,

    Val_BarelSas,
    LastVal_BarelSas,

    Val_HaluSasaran,
    LastVal_HaluSasaran,

    Val_HaluKapal,
    LastVal_HaluKapal : Single;

    Keypnl1,
    Keypnl2 : Boolean;

  public
    RotateCount_HalSas : Integer;
    RotateCount_HaluKapal : Integer;

//    procedure bubar;
    function InitMove(const Vl, Lst: single): boolean;
    function GetValueWheel(const Ps : single;
      var Multiple :Integer; Var LastValue: single): String;
    function InitValue(const Value: single): Single;

    { Public declarations }
  end;

var
  frmBurjaAtas: TfrmBurjaAtas;

implementation
uses
   uMain, uLibRBU, uRBU_Manager, uBaseFunction, uPanelFire, uBaseConstan,
  uTCPDatatype;
{$R *.dfm}

//procedure TfrmBurjaAtas.bubar;
//begin
//  Application.Terminate;
//  ShellExecute(Handle, 'open', 'shutdown_restart.exe', nil, nil, SW_SHOWNORMAL);
//end;

procedure TfrmBurjaAtas.btn1Click(Sender: TObject);
begin
//  inherited;

if chkShutdown.Checked then
  WindowsExit(EWX_POWEROFF or EWX_FORCE);   //Shutdown
if chkRestart.Checked then
  WindowsExit(EWX_REBOOT or EWX_FORCE);    //Restart
if rbclose.Checked then
  Application.Terminate;    //Restart

end;

procedure TfrmBurjaAtas.edtJarakChange(Sender: TObject);
var Jrk_dlm_Cable : Double;
begin
  CIJarakDlmKabel.Value := StrToFloatDef(edtJarak.text,0.0);
  CIJarakDlmKabel.Scale := 3.6;
  CIJarakDlmKabel.ScaleOut := 180;
//  RBU_MAnager.frmPanelFire.RMJarak.Value := CIJarakDlmKabel.Value;
//  RBU_MAnager.frmPanelFire.RMJarak.Scale  := CIJarakDlmKabel.Value;
end;

procedure TfrmBurjaAtas.edtKecSasaranChange(Sender: TObject);
begin
  RmKecSassaran.Value := (StrToFloat(edtKecSasaran.Text));
  RmKecSassaran.Scale := 7;
//  RBU_MAnager.frmPanelFire.RMKecSassaran.Value := (StrToFloat(edtKecSasaran.Text));
//  RBU_MAnager.frmPanelFire.RMKecSassaran.Scale := 7;
end;

procedure TfrmBurjaAtas.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Keypnl1 := False;
  Keypnl2 := False;
  DoubleBuffered := true;

  CIHaluSasaran.LoadBGImage(path_image_burja + '200px_back.bmp');
  CIHaluSasaran.LoadOutImage(path_image_burja + 'HaluSasaranOut.bmp');
  CIHaluSasaran.LoadInImage(path_image_burja + 'HaluSasaranIn.bmp');
  CIHaluSasaran.Parent := self;
  CIHaluSasaran.Value := 0;
  CIHaluSasaran.ValMin := 0;
  CIHaluSasaran.ValMax := 360;
  CIHaluSasaran.Line := LTop;

  RmKoreksiHalsas.LoadBGImage(path_image_burja + 'KoreksiHalsas.bmp');
  RmKoreksiHalsas.LoadImage(path_image_burja +  'Jarum.bmp');
  RmKoreksiHalsas.Parent := self;
  RmKoreksiHalsas.Value := 0;
  RmKoreksiHalsas.ValMin := -60;
  RmKoreksiHalsas.ValMax := 60;
  RmKoreksiHalsas.Line := LNone;


  RmBarSasaran.LoadBGImage(path_image_burja + '200px_back.bmp');
  RmBarSasaran.LoadImage(path_image_burja + 'BarSasaran.bmp');
  RmBarSasaran.Parent := self;
  RmBarSasaran.Value := 0;
  RmBarSasaran.ValMin := -180;
  RmBarSasaran.ValMax := 180;
  RmBarSasaran.Line := LBottom;

  CIHaluKapal.LoadBGImage(path_image_burja + '200px_back.bmp');
  CIHaluKapal.LoadOutImage(path_image_burja +  'HaluSasaranOut.bmp');
  CIHaluKapal.LoadInImage(path_image_burja +  'HaluSasaranIn.bmp');
  CIHaluKapal.Parent := self;
  CIHaluKapal.Value := 0;
  CIHaluKapal.ValMin := 0;
  CIHaluKapal.ValMax := 360;
  CIHaluKapal.Line := LTop;

  CIBarelSas.LoadBGImage(path_image_burja + '200px_back.bmp');
  CIBarelSas.LoadOutImage(path_image_burja +  'BarelSas_Out.bmp');
  CIBarelSas.LoadInImage(path_image_burja +  'BarelSas_In.bmp');
  CIBarelSas.Parent := self;
  CIBarelSas.Value := 0;
  CIBarelSas.ValMin := -180;
  CIBarelSas.ValMax := 180;
  CIBarelSas.Line := LTop;

  CILonchHaluan.LoadBGImage(path_image_burja + '200px_back.bmp');
  CILonchHaluan.LoadOutImage(path_image_burja +  'LonchHaluanOut.bmp');
  CILonchHaluan.LoadInImage(path_image_burja +  'LonchHaluanIn.bmp');
  CILonchHaluan.Parent := self;
  CILonchHaluan.Value := 0;
  CILonchHaluan.ValMin := 0;
  CILonchHaluan.ValMax := 360;
  CILonchHaluan.Line := LTop;

  RmKoreksiTraining.LoadBGImage(path_image_burja + 'KoreksiTraining.bmp');
  RmKoreksiTraining.LoadImage(path_image_burja +  'Jarum.bmp');
  RmKoreksiTraining.Parent := self;
  RmKoreksiTraining.Value := 0;
  RmKoreksiTraining.ValMin := -60;
  RmKoreksiTraining.ValMax := 60;
  RmKoreksiTraining.Line := LNone;

  CILonchBuritan.LoadBGImage(path_image_burja + '200px_back.bmp');
  CILonchBuritan.LoadOutImage(path_image_burja +  'LonchHaluanOut.bmp');
  CILonchBuritan.LoadInImage(path_image_burja +  'LonchHaluanIn.bmp');
  CILonchBuritan.Parent := self;
  CILonchBuritan.Value := 0;
  CILonchBuritan.ValMin := 0;
  CILonchBuritan.ValMax := 360;
  CILonchBuritan.Line := LTop;

  RmKecSassaran.LoadBGImage(path_image_burja + '200px_back.bmp');
  RmKecSassaran.LoadImage(path_image_burja +  'Kec_Sasaran.bmp');
  RmKecSassaran.Parent := self;
  RmKecSassaran.Value := 0;
  RmKecSassaran.ValMin := 0;
  RmKecSassaran.ValMax := 35;
  RmKecSassaran.Line := LTop;

  RmKecKapal.LoadBGImage(path_image_burja + '200px_back.bmp');
  RmKecKapal.LoadImage(path_image_burja +  'Kec_Kapal.bmp');
  RmKecKapal.Parent := self;
  RmKecKapal.Value := 0;
  RmKecKapal.ValMin := 0;
  RmKecKapal.ValMax := 180;
  RmKecKapal.Line := LTop;

  RmKedalaman.LoadBGImage(path_image_burja + '200px_back.bmp');
  RmKedalaman.LoadImage(path_image_burja +  'Kedalaman.bmp');
  RmKedalaman.Parent := self;
  RmKedalaman.Value := 0;
  RmKedalaman.ValMin := 0;
  RmKedalaman.ValMax := 300;
  RmKedalaman.Line := LTop;

  CIJarakDlmKabel.LoadBGImage(path_image_burja + '200px_back.bmp');
  CIJarakDlmKabel.LoadOutImage(path_image_burja + 'JarakDalamKabel_Out.bmp');
  CIJarakDlmKabel.LoadInImage(path_image_burja + 'JarakDalamKabel_In.bmp');
  CIJarakDlmKabel.Parent := self;
  CIJarakDlmKabel.Value := 0;
  CIJarakDlmKabel.ValMin := 0;
  CIJarakDlmKabel.ValMax := 100;
  CIJarakDlmKabel.Line := LTop;

  RmKoreksiElevasi.LoadBGImage(path_image_burja + 'Koreksi_Elevasi.bmp');
  RmKoreksiElevasi.LoadImage(path_image_burja +  'Jarum.bmp');
  RmKoreksiElevasi.Parent := self;
  RmKoreksiElevasi.Value := 0;
  RmKoreksiElevasi.ValMin := -3.0;
  RmKoreksiElevasi.ValMax := 3.0;
  RmKoreksiElevasi.Line := LNone;



   for I := 0 to ComponentCount - 1 do
    if (Components[I] is TImage) and (Components[I].Tag=9)then
       (Components[I] as TImage).Picture.LoadFromFile(path_image_burja + 'Burja_indikator_off.bmp');

    Count_HaluSasaran     := 0;
    LastVal_HaluSasaran   := 0;

    Count_HaluKapal       := 0;
    LastVal_HaluKapal     := 0;

end;

procedure TfrmBurjaAtas.vrwhlKEC_KAPALChange(Sender: TObject);
Var Pos : Single;
begin

  Pos := 45 * (vrwhlKEC_KAPAL.Position / vrwhlKEC_KAPAL.MaxValue);
  if (LastVal_KecKapal = Pos) then Exit;

  if LastVal_KecKapal  > Pos then
    Val_KecKapal := Val_KecKapal  - 0.25
  else if LastVal_KecKapal < Pos then
    Val_KecKapal := Val_KecKapal + 0.25;

  if (Val_KecKapal < 0) then
    Val_KecKapal := 0;
  if (Val_KecKapal > 45) then
    Val_KecKapal := 45;

  LastVal_KecKapal := Pos;

//  lbl_KecKapal.Caption := FormatFloat('00.#',Val_KecKapal);
  edt_Keckapal.Text := FormatFloat('#0.0',Val_KecKapal);
end;

procedure TfrmBurjaAtas.vrwhlKEC_KAPALMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KecKapal.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlKEC_KAPALMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KecKapal.Visible := False;
end;

procedure TfrmBurjaAtas.vrwhlKEC_SASARANChange(Sender: TObject);
Var Pos : Single;
begin

  Pos := 35 * (vrwhlKEC_SASARAN.Position / vrwhlKEC_SASARAN.MaxValue);
  if (LastVal_KecSasaran = Pos) then Exit;

  if LastVal_KecSasaran  > Pos then
    Val_KecSasaran := Val_KecSasaran  - 0.25
  else if LastVal_KecSasaran < Pos then
    Val_KecSasaran := Val_KecSasaran + 0.25;

  if (Val_KecSasaran <0) then
    Val_KecSasaran := 0;
  if (Val_KecSasaran > 35) then
    Val_KecSasaran := 35;

  LastVal_KecSasaran := Pos;

  // lbl_KecSasaran.Caption := FormatFloat('00.0#',Val_KecSasaran);
  //lbl_KecSasaran.Caption := Inttostr(Round(Val_KecSasaran));
  edtKecSasaran.Text := FormatFloat('#0.0',Val_KecSasaran);

end;

procedure TfrmBurjaAtas.vrwhlKEC_SASARANMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtKecSasaran.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlKEC_SASARANMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtKecSasaran.Visible := False;
end;

procedure TfrmBurjaAtas.vrwhlKEDALAMANChange(Sender: TObject);
Var Pos : Single;
begin

  Pos := 30 * (vrwhlKEDALAMAN.Position / vrwhlKEDALAMAN.MaxValue);
  if (LastVal_Kedalaman = Pos) then Exit;

  if LastVal_Kedalaman  > Pos then
    Val_Kedalaman := Val_Kedalaman  - 1
  else if LastVal_Kedalaman < Pos then
    Val_Kedalaman := Val_Kedalaman +1;

  if (Val_Kedalaman <0) then
    Val_Kedalaman := 0;
  if (Val_Kedalaman > 300) then
    Val_Kedalaman := 300;

  LastVal_Kedalaman := Pos;

//  lbl_Kedalaman.Caption := FormatFloat('00#',Val_Kedalaman);
  edt_Kedalaman.text := Inttostr(Round(Val_Kedalaman));

end;

procedure TfrmBurjaAtas.vrwhlKEDALAMANMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
edt_Kedalaman.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlKEDALAMANMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_Kedalaman.Visible := False;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_ELEVASIChange(Sender: TObject);
Var Pos : Single;
begin
  Pos := 30 * (vrwhlKOREKSI_ELEVASI.Position / vrwhlKOREKSI_ELEVASI.MaxValue);
  if (LastVal_KoreksiElevasi = Pos) then Exit;

  if LastVal_KoreksiElevasi > Pos then
    Val_KoreksiElevasi  := Val_KoreksiElevasi  - 0.01
  else if LastVal_KoreksiElevasi < Pos then
    Val_KoreksiElevasi := Val_KoreksiElevasi + 0.01;

  if (Val_KoreksiElevasi < -3.00) then
    Val_KoreksiElevasi := -3.00;
  if (Val_KoreksiElevasi > 3.00) then
    Val_KoreksiElevasi := 3.00;

  LastVal_KoreksiElevasi := Pos;
  edt_KoreksiElevasi.Text := FormatFloat('#0.0',Val_KoreksiElevasi);
end;
procedure TfrmBurjaAtas.vrwhlKOREKSI_ELEVASIMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KoreksiElevasi.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_ELEVASIMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KoreksiElevasi.Visible := False;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_HALSASChange(Sender: TObject);
Var Pos : Single;
begin
  Pos := 5 * (vrwhlKOREKSI_HALSAS.Position / vrwhlKOREKSI_HALSAS.MaxValue);
  if (LastVal_KoreksiHalSas = Pos) then Exit;

  if LastVal_KoreksiHalSas  > Pos then
    Val_KoreksiHalSas := Val_KoreksiHalSas  - 0.1
  else if LastVal_KoreksiHalSas < Pos then
    Val_KoreksiHalSas := Val_KoreksiHalSas + 0.1;

  if (Val_KoreksiHalSas <-50) then
    Val_KoreksiHalSas := -50;
  if (Val_KoreksiHalSas > 50) then
    Val_KoreksiHalSas := 50;

  LastVal_KoreksiHalSas := Pos;

//  RIBarelSas.Degree := -d;
  edt_KoreksiHalsas.Text := FormatFloat('#0.0',Val_KoreksiHalSas);

end;

procedure TfrmBurjaAtas.edt_KeckapalChange(Sender: TObject);
begin
  RmKecKapal.Value := (StrToFloat(edt_Keckapal.Text));
  RmKecKapal.Scale := 7;
end;

procedure TfrmBurjaAtas.edt_KedalamanChange(Sender: TObject);
begin

 RmKedalaman.Value := (StrToFloat(edt_Kedalaman.text ));
 RmKedalaman.Scale := 0.9;

end;

procedure TfrmBurjaAtas.edt_KoreksiElevasiChange(Sender: TObject);
begin
 RmKoreksiElevasi.Value := StrToFloat(edt_KoreksiElevasi.Text);
 RmKoreksiElevasi.Scale := 45;
 Lonch1.CorrElev := StrToFloat(edt_KoreksiElevasi.Text);
 Lonch2.CorrElev := StrToFloat(edt_KoreksiElevasi.Text);
end;

procedure TfrmBurjaAtas.edt_KoreksiHalsasChange(Sender: TObject);
begin
  RmKoreksiHalsas.Value := (StrToFloat(edt_KoreksiHalsas.Text));
  RmKoreksiHalsas.Scale := 3;
end;

procedure TfrmBurjaAtas.edt_KoreksiTrainingChange(Sender: TObject);
begin
  RmKoreksiTraining.Value := (StrToFloat(edt_KoreksiTraining.Text));
  RmKoreksiTraining.Scale := 30;
  Lonch1.CorrTraining  := StrToFloat(edt_KoreksiTraining.text);
  Lonch2.CorrTraining  := StrToFloat(edt_KoreksiTraining.text);
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_HALSASMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KoreksiHalsas.Visible:=True;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_HALSASMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   edt_KoreksiHalsas.Visible:=False;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_TRAININGChange(Sender: TObject);
Var Pos : Single;
begin
  Pos := 5 * (vrwhlKOREKSI_TRAINING.Position / vrwhlKOREKSI_TRAINING.MaxValue);
  if (LastVal_KoreksiTraining  = Pos) then Exit;

  if LastVal_KoreksiTraining  > Pos then
    Val_KoreksiTraining  := Val_KoreksiTraining  - 0.01
  else if LastVal_KoreksiTraining < Pos then
    Val_KoreksiTraining := Val_KoreksiTraining + 0.01;

  if (Val_KoreksiTraining <-5) then
    Val_KoreksiTraining := -5;
  if (Val_KoreksiTraining > 5) then
    Val_KoreksiTraining := 5;

  LastVal_KoreksiTraining := Pos;

  edt_KoreksiTraining.text := FormatFloat('#0.0',Val_KoreksiTraining);
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_TRAININGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KoreksiTraining.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlKOREKSI_TRAININGMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_KoreksiTraining.Visible := false;
end;

procedure TfrmBurjaAtas.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//   if ssShift in Shift then
//    frm_Main.Visible := true
//  else
//    frm_Main.Visible := False;

  Keypnl1 := False;
  Keypnl2 := False;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaAtas.img30Click(Sender: TObject);
begin
  ShowMessage(edtJarak.Text);
end;

procedure TfrmBurjaAtas.vrwhlBAREL_SASChange(Sender: TObject);
var Pos : single;
begin
  Pos := 100 * (vrwhlBAREL_SAS.Position / vrwhlBAREL_SAS.MaxValue);
  if (LastVal_BarelSas = Pos) then Exit;

  if LastVal_BarelSas > Pos then
    Val_BarelSas := Val_BarelSas - 0.25
  else if LastVal_BarelSas < Pos then
    Val_BarelSas := Val_BarelSas + 0.25;

  if (Val_BarelSas <-180) then
    Val_BarelSas := -180;
  if (Val_BarelSas > 180) then
    Val_BarelSas := 180;

  LastVal_BarelSas := Pos;

  edt_BarelSas.Text := FormatFloat('00.0#',Val_BarelSas);

end;

procedure TfrmBurjaAtas.edt_BarelSasChange(Sender: TObject);
//var val : Single;

begin
// val := StrToFloat(edt_BarelSas.Text);
//// edt_BarelSas.Text := FloatToStr(val);
// if Val > 180 then
//    val := val - 360
// else if Val < -180 then
//    val := val + 360;
//
  CIBarelSas.Value := StrToFloat(edt_BarelSas.Text);
  CIBarelSas.Scale := 1;
  CIBarelSas.ScaleOut := 36;

  edt_BarSasaran.Text := FloatToStr(Validate180Degree(CIBarelSas.Value + strtofloat(edt_haluKapal.Text){OwnShip.heading}));
  Lonch2.TrainingValue := StrToFloat(edt_BarelSas.Text);
  Lonch1.TrainingValue := StrToFloat(edt_BarelSas.Text);

  RBU_MAnager.frmPanelFire.edtValOut.Text :=  FloatToStr(ValidateDegree(StrToFloat(edt_BarelSas.Text)));
end;

procedure TfrmBurjaAtas.edt_BarSasaranChange(Sender: TObject);
var val: Single;
begin
  val := (StrToFloat(edt_BarSasaran.Text));
//  edt_BarSasaran.Text := FloatToStr(val);
  if Val > 180 then
    val := val - 360
  else if Val < -180 then
    val := val + 360;

  RmBarSasaran.Value := val;
  RmBarSasaran.Scale := 1;
end;

procedure TfrmBurjaAtas.edt_haluKapalChange(Sender: TObject);
begin
  CIHaluKapal.Value := StrToFloat(edt_haluKapal.Text);
  CIHaluKapal.Scale := 1;
  CIHaluKapal.ScaleOut := 36;
  RBU_MAnager.frmPanelFire.edtKplSendiri.Text := edt_haluKapal.Text;
end;

procedure TfrmBurjaAtas.vrwhlBAREL_SASMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_BarelSas.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlBAREL_SASMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_BarelSas.Visible := False;

  if not RBU_MAnager.IsSonarTracked then begin

   {Set Assign Lonch2 Manual}
   if (RBU_MAnager.frm108Kiri.Isrunning) and (not Lonch2.IsLoading) then
      RBU_MAnager.frm108Kiri.RunLauncherRBU(Lonch2 , __ORD_RBU_ASSIGNED);

   {Set Assign Lonch2 Manual}
   if (RBU_MAnager.frm108Kanan.Isrunning) and (not Lonch1.IsLoading) then
      RBU_MAnager.frm108Kanan.RunLauncherRBU(Lonch1 , __ORD_RBU_ASSIGNED);
  end;
end;

function TfrmBurjaAtas.InitMove(const Vl, Lst: single): boolean;
begin
  if Vl > Lst  then
    Result := True
  else
    Result := False;
end;

procedure TfrmBurjaAtas.vrwhlHALU_HALSASChange(Sender: TObject);
 var
  Pos : single;
begin

  Pos := 360 *(vrwhlHALU_HALSAS.Position / vrwhlHALU_HALSAS.MaxValue);
  if (LastVal_HaluSasaran = Pos) then Exit;

  if LastVal_HaluSasaran > Pos then
    Val_HaluSasaran := Val_HaluSasaran  - 0.25
  else if LastVal_HaluSasaran  < Pos then
    Val_HaluSasaran := Val_HaluSasaran + 0.25;

  if (Val_HaluSasaran < 0.00) then
    Val_HaluSasaran := 359.75;
  if (Val_HaluSasaran > 359.75) then
    Val_HaluSasaran := 0.00;

  LastVal_HaluSasaran := Pos;

  //edt_HaluSasaran.Text := FormatFloat('###0.##0',Val_HaluSasaran);
  edt_HaluSasaran.Text := Format('%n', [Val_HaluSasaran]);

end;

procedure TfrmBurjaAtas.edt_HaluSasaranChange(Sender: TObject);
begin
  CIHaluSasaran.Value := StrToFloat(edt_HaluSasaran.Text); //StrToFloat(lbl_HaluSasaran.Caption);
  CIHaluSasaran.Scale := 1;
  CIHaluSasaran.ScaleOut := 36;
  RBU_MAnager.frmPanelFire.edtSasaran.Text := edt_HaluSasaran.Text;
end;

procedure TfrmBurjaAtas.vrwhlHALU_HALSASMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   edt_HaluSasaran.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlHALU_HALSASMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_HaluSasaran.Visible := False;
end;


procedure TfrmBurjaAtas.vrwhlHALU_KAPALChange(Sender: TObject);
 var
  Pos : single;
begin

  Pos := 360 *(vrwhlHALU_KAPAL.Position / vrwhlHALU_KAPAL.MaxValue);
  if (LastVal_HaluKapal = Pos) then Exit;

  if LastVal_HaluKapal > Pos then
    Val_HaluKapal := Val_HaluKapal  - 0.25
  else if LastVal_HaluKapal  < Pos then
    Val_HaluKapal := Val_HaluKapal + 0.25;

  if (Val_HaluKapal < 0.00) then
    Val_HaluKapal := 359.75;
  if (Val_HaluKapal > 359.75) then
    Val_HaluKapal := 0.00;

  LastVal_HaluKapal := Pos;

  edt_HaluKapal.Text := Format('%n', [Val_HaluKapal]);

end;

procedure TfrmBurjaAtas.vrwhlHALU_KAPALMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_haluKapal.Visible := True;
end;

procedure TfrmBurjaAtas.vrwhlHALU_KAPALMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edt_haluKapal.Visible := False;
end;

procedure TfrmBurjaAtas.vrwhlJARAK_DLM_KABELChange(Sender: TObject);
var Pos : single;
bal : Word;
begin
  Pos := 80 * (vrwhlJARAK_DLM_KABEL.Position / vrwhlJARAK_DLM_KABEL.MaxValue);
  if (LastVal_JarakDlmKabel = Pos) then Exit;

  if LastVal_JarakDlmKabel > Pos then
    Val_JarakDlmKabel := Val_JarakDlmKabel - 1/4
  else if LastVal_JarakDlmKabel < Pos then
    Val_JarakDlmKabel := Val_JarakDlmKabel + 1/4;

  if (Val_JarakDlmKabel <0) then
    Val_JarakDlmKabel := 0;
  if (Val_JarakDlmKabel > 80) then
    Val_JarakDlmKabel := 80;

  LastVal_JarakDlmKabel := Pos;

  edtJarak.Text := FormatFloat('#0.0',Val_JarakDlmKabel);

  if BalistikMode = Balistik1 then
     bal := 1
  else
    bal := 2;
  RBU_MAnager.frmBottomBurja.edt_Elevasi.Text := FormatFloat('#0.0', C_Degree_To_TD *
  ConvRangeToElev(bal , C_Cable_To_Meter *  StrToFloatDef(edtJarak.text,0.0)));
end;

procedure TfrmBurjaAtas.vrwhlJARAK_DLM_KABELMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtJarak.Visible := True;
  RBU_MAnager.frmBottomBurja.edt_Elevasi.Visible := edtJarak.Visible;
end;

procedure TfrmBurjaAtas.vrwhlJARAK_DLM_KABELMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtJarak.Visible := False;
  RBU_MAnager.frmBottomBurja.edt_Elevasi.Visible := edtJarak.Visible;
end;

function TfrmBurjaAtas.GetValueWheel(const Ps : single;
var Multiple :Integer; Var LastValue: single): String;
begin
  if LastValue = Ps then Exit;

  if LastValue = 0 then
  begin
    if InitValue(Ps/36) = 0 then   //dari 0 bertambah, nilai tambah 1
    begin
      Multiple := Multiple + 1;
      if Multiple > 10 then
        Multiple := 1;
    end
  end;
   if Ps = 0 then                  //menuju 0 dari kecil, nilai berkurang 1
  begin
    if InitValue(LastValue/36) = 0 then
    begin
      Multiple := Multiple - 1;
      if Multiple < 1 then
        Multiple := 10;
    end;
  end;

  if Multiple < 1 then
    Multiple := 10;

  LastValue := Ps;

  if Ps = 0 then
  Exit;

  Result :=  FormatFloat('00.0#',Ps + (36*(Multiple-1))); //(Round(Pos + (36*(Count_HaluSasaran-1))));

end;

function TfrmBurjaAtas.InitValue(const Value: single): Single;
begin
  if Value < 0.5 then
    Result := 0
  else
    Result := 1;
end;

procedure TfrmBurjaAtas.pnl6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Keypnl1 := True;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaAtas.pnl7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Keypnl2 := True;
  m1.Visible := Keypnl1 and Keypnl2;
end;

procedure TfrmBurjaAtas.se1Change(Sender: TObject);
begin
   edt_Kedalaman.Text := IntToStr(se1.Value);
end;

end.
