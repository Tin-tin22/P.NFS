unit uPanelFire;

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
  VrDesign,
  RzButton,
  //RotationIndicator,
  uLibRBU,
  VrRotarySwitch, RotationMeter;
  //RotationMeter;

const
  C_START_DEG_TOFIRE_R = 0;
  C_START_DEG_TOFIRE_L = 15;
type
  TfrmPanelFire = class(TForm)
    imgSingleFire: TImage;
    imgSalvoFire: TImage;
    imgKunci_Fire: TImage;
    img3: TImage;
    btnFIRE: TVrBitmapButton;
    img6: TImage;
    img4: TImage;
    pnl11: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    btn2: TVrBitmapButton;
    lbl2: TLabel;
    pnlcheat: TPanel;
    edtBearing: TEdit;
    edtRange: TEdit;
    edtDepth: TEdit;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtmissile: TEdit;
    edtLauncher: TEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    img_AdaKontak: TImage;
    img_Automatis: TImage;
    img_KontakHilang: TImage;
    img_TdkmgknTembak: TImage;
    img_SasTPO: TImage;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    tmrFire: TTimer;
    vrtryswtch1: TVrRotarySwitch;
    vrtryswtch2: TVrRotarySwitch;
    mmo1: TMemo;
    pnl16: TPanel;
    RMKecSassaran: TRotationMeter;
    RMJarak: TRotationMeter;
    RMSDL2: TRotationMeter;
    RMSDL1: TRotationMeter;
    edtJarak: TEdit;
    tmrReadVal: TTimer;
    edt_Lonch1: TEdit;
    edt_Lonch2: TEdit;
    img1: TImage;
    edt_kec_Sasaran: TEdit;
    DCKapalSendiri: TDoubleCompass;
    DCSasaran: TDoubleCompass;
    edtSasaran: TEdit;
    edtValOut: TEdit;
    edtKplSendiri: TEdit;
    m2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnFIREClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgKunci_FireClick(Sender: TObject);
    procedure vrtryswtch1Change(Sender: TObject);
    procedure vrtryswtch2Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtJarakChange(Sender: TObject);
    procedure edt_Lonch1Change(Sender: TObject);
    procedure edt_Lonch2Change(Sender: TObject);

    function  setAutoIndikator(Val : Single; LmtMin, LmtMax : Single): boolean;
    procedure tmrReadValTimer(Sender: TObject);

    function DegreeSalvoMode(Count: byte): Single;
    procedure edtValOutChange(Sender: TObject);
    procedure edtSasaranChange(Sender: TObject);
    procedure edtKplSendiriChange(Sender: TObject);
    procedure txt1Change(Sender: TObject);
    procedure pnl16Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    SingleLauncherImg,
    SalvoLauncherImg   : Integer;
    TempSingleFireR     : Integer;
    TempSingleFireL     : Integer;
    IsReadyToFire      : boolean;



    IsBlindZone1,
    IsBlindZone2       : Boolean;

    Counter            : Integer;
    FireModeL,
    FireModeR          : TFireMode;

    DiffDegToFireR,
    DiffDegToFireL     : Single;

//    Bearing            : Double;
    function SendFireRBU(Lonchr : TLoncher; aCount : integer): Boolean;
    procedure SendFireCommand;
  end;

//var
//  frmPanelFire: TfrmPanelFire;

implementation
uses
   uTCPDatatype, uRBU_Manager, uBaseConstan, uBurjaAtas, uBaseFunction;
{$R *.dfm}


procedure TfrmPanelFire.FormCreate(Sender: TObject);

begin
// Launcher1 ==>> Kiri
   Lonch1   := TLoncher.Create;
   Lonch1.ID :=1;

// Launcher2 ==>> Kanan
   Lonch2   := TLoncher.Create;
   Lonch2.ID :=2;

   DiffDegToFireR     := C_START_DEG_TOFIRE_R;
   DiffDegToFireL     := C_START_DEG_TOFIRE_L;
   Use_Balistik       := 2;
   IsBlindZone1       := False;
   IsBlindZone2       := False;

   SingleLauncherImg  := 1;
   SalvoLauncherImg   := 1;
   IsReadyToFire      := False;
   Counter            := 0;
  // color:= RGB();

  RMJarak.LoadBGImage(path_image_panelFire + '240px_back.bmp');
  RMJarak.LoadImage(path_image_panelFire +  'jarak.bmp');
  RMJarak.Parent := self;
  RMJarak.Value  := 0;
  RMJarak.ValMin := 0;
  RMJarak.ValMax := 120;
  RMJarak.Line   := LTop;

  DCKapalSendiri.LoadBGImage(path_image_panelFire + '260px_back.bmp');
  DCKapalSendiri.LoadOutImage(path_image_panelFire + 'kpl_sendiri_out.bmp');
  DCKapalSendiri.LoadInImage(path_image_panelFire + 'kpl_sendiri_in.bmp');
  DCKapalSendiri.Parent := self;
  DCKapalSendiri.Value := 0;
  DCKapalSendiri.ValueOut := 0;
  DCKapalSendiri.ValMin := -180;
  DCKapalSendiri.ValMax := 180;
  DCKapalSendiri.ValMinOut := 0;
  DCKapalSendiri.ValMaxOut := 360;
  DCKapalSendiri.Line := LTop;

  DCSasaran.LoadBGImage(path_image_panelFire + '280px_back.bmp');
  DCSasaran.LoadOutImage(path_image_panelFire + 'sasaran_out.bmp');
  DCSasaran.LoadInImage(path_image_panelFire + 'sasaran_in.bmp');
  DCSasaran.Parent := self;
  DCSasaran.Value := 0;
  DCSasaran.ValueOut := 0;
  DCSasaran.ValMin := -180;
  DCSasaran.ValMax := 180;
  DCSasaran.ValMinOut := 0;
  DCSasaran.ValMaxOut := 360;
  DCSasaran.Line := LBottom;

  RMKecSassaran.LoadBGImage(path_image_panelFire + '240px_back.bmp');
  RMKecSassaran.LoadImage(path_image_panelFire +  'kec_sasaran.bmp');
  RMKecSassaran.Parent := self;
  RMKecSassaran.Value  := 0;
  RMKecSassaran.ValMin := 0;
  RMKecSassaran.ValMax := 35;
  RMKecSassaran.Line   := LTop;

  RMSDL1.LoadBGImage(path_image_panelFire + '200px_sud_dat_lon_back.bmp');
  RMSDL1.LoadImage(path_image_panelFire + 'sud_dat_lon_1.bmp');
  RMSDL1.Parent := self;
  RMSDL1.Value  := 0;
  RMSDL1.ValMin := -160;
  RMSDL1.ValMax := 160;
  RMSDL1.Line := LNone;

  RMSDL2.LoadBGImage(path_image_panelFire + '200px_sud_dat_lon_back.bmp');
  RMSDL2.LoadImage(path_image_panelFire + 'sud_dat_lon_2.bmp');
  RMSDL2.Parent := self;
  RMSDL2.Value  := 0;
  RMSDL2.ValMin := -160;
  RMSDL2.ValMax := 160;
  RMSDL2.Line   := LNone;

  TempSingleFireR := 0;
  TempSingleFireL := 0;
end;

procedure TfrmPanelFire.edt_Lonch1Change(Sender: TObject);
Var degInPlus1,degInPlus2 : Single;
begin
  RMSDL1.Value  := Validate180Degree(StrToFloat(edt_Lonch1.Text));
  RMSDL1.Scale  := 1;

  RMSDL1.Value  := LauncherScope(RMSDL1.Value);
  degInPlus1     := RedGreenToDeg(RMSDL1.Value);
  degInPlus2     := RedGreenToDeg(RMSDL2.Value);

  IsBlindZone1  := setAutoIndikator(degInPlus1, BlindZoneR_Start, BlindZoneR_End);

  if IsBlindZone1 or IsBlindZone2 then
     img_TdkmgknTembak.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp')
  else
     img_TdkmgknTembak.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp');
end;

procedure TfrmPanelFire.edt_Lonch2Change(Sender: TObject);
Var degInPlus : Single;

begin
  RMSDL2.Value := Validate180Degree(strtofloat(edt_Lonch2.text));
  RMSDL2.Scale := 1;

  RMSDL2.Value := LauncherScope(RMSDL2.Value);
  degInPlus    := RedGreenToDeg(RMSDL2.Value);

  IsBlindZone2 := setAutoIndikator(degInPlus, BlindZoneL_Start, BlindZoneL_End);

  if IsBlindZone1 or IsBlindZone2 then
     img_TdkmgknTembak.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp')
  else
     img_TdkmgknTembak.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp');
end;

procedure TfrmPanelFire.edtJarakChange(Sender: TObject);
begin
  RMJarak.Value := (StrToFloat(edtJarak.Text));
  RMJarak.Scale := 2.75;
end;

procedure TfrmPanelFire.edtKplSendiriChange(Sender: TObject);
begin
  DCKapalSendiri.Value := Validate180Degree(-StrToFloatDef(edtKplSendiri.Text,0.0));
  DCKapalSendiri.Scale := 1;
end;

procedure TfrmPanelFire.edtSasaranChange(Sender: TObject);
begin
  DCSasaran.Value := Validate180Degree(-StrToFloat(edtSasaran.Text));
  DCSasaran.Scale := 1;
end;

procedure TfrmPanelFire.edtValOutChange(Sender: TObject);
begin
 DCKapalSendiri.ValueOut := ValidateDegree(StrToFloat(edtValOut.Text));
 DCKapalSendiri.ScaleOut := 1;

 DCSasaran.ValueOut := ValidateDegree(StrToFloat(edtValOut.Text));
 DCSasaran.ScaleOut := 1;
end;

procedure TfrmPanelFire.FormDestroy(Sender: TObject);
begin
  freeandnil(Lonch1);
  freeandnil(Lonch2);
end;

procedure TfrmPanelFire.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssShift in Shift then
    pnlcheat.Visible  := true
  else
    pnlcheat.Visible  := False;
end;

procedure TfrmPanelFire.imgKunci_FireClick(Sender: TObject);
begin

  IsReadyToFire := not IsReadyToFire;
  if IsReadyToFire then
    imgKunci_Fire.Picture.LoadFromFile(path_image_panelFire + 'Kunci_FireB.bmp')
  else
    imgKunci_Fire.Picture.LoadFromFile(path_image_panelFire + 'Kunci_FireA.bmp')
end;

procedure TfrmPanelFire.pnl16Click(Sender: TObject);
Var i : integer;
begin
 for i := 1 to  12 do begin
    ListMissileR[i].Available := True;
    ListMissileL[i].Available := True;
    RBU_MAnager.frm108Kanan.RefreshMissileIndikator(i);
    RBU_MAnager.frm108Kiri.RefreshMissileIndikator(i);
 end;

end;

procedure TfrmPanelFire.btn2Click(Sender: TObject);
begin
  Hide;
end;

procedure TfrmPanelFire.SendFireCommand;
Var lRec : TRec3DSetRBU;
    PktToFire : TRecMissile;

    RangeToFire,
    BearingToFire,

    Bearing, DiffRange, DiffBearing: Double;

    BlindZone_Start,
    BlindZone_End,

    RandomElevcorr,
    RandomTrainingCorr,
    GrandElevCorr,
    GrandTrainingCorr     : Double;

    label Fail_to_Fire_R, Fail_to_Fire_L;

begin
//
    RangeToFire   := StrToFloat(edtJarak.text) * C_Cable_To_Meter; // jarak dlm meter

    lRec.ShipID         := RBU_MAnager.pShipID;;
    lRec.mWeaponID      := C_DBID_RBU6000;
    lRec.OrderID        := __ORD_RBU_FIRE;
    lRec.mMissileType   := Use_Balistik;
    lRec.mTargetID      := TargetID;
    lRec.mTargetDepth   := StrToFloat(TfrmBurjaAtas(RBU_MAnager.frmTopBurja).edt_Kedalaman.Text);

    with Lonch1 do
    begin
      if Counter <= OrderFire.Count-1 then begin

  //      if not Lonch1.Enabled then  goto BlindzoneR;

          PktToFire := OrderFire.Items[Counter];

          if (not PktToFire.Available)    // Missile not Available
            or (not PktToFire.Condition)  // Missile set fault from Instruktur
            or (IsLoading) then           // Launcher sedang Loading
              goto Fail_to_Fire_R;

          Bearing := TrainingValue;

          if OrderFire.Count > 2 then begin
            DiffDegToFireR := DiffDegToFireR + DegreeSalvoMode(OrderFire.Count);
            Fire_With_SalvoMode
              (OwnShip.position.X, OwnShip.position.Y, RangeToFire, Bearing, C_Radius_Tembakan, DiffDegToFireR, RangeToFire, Bearing);
          end;

          lRec.mLauncherID    := PktToFire.Launcher;
          lRec.mMissileID     := PktToFire.Missile;
          lRec.mMissileNumber := lRec.mMissileID;

          lRec.mLncrBearing  := Bearing;
          lRec.mLncRange     := RangeToFire;
          lRec.mCorrBearing  := CorrTraining;
          lRec.mCorrElev     := CorrElev;

          if (validatedegree(Bearing) >= BlindZoneR_Start) and (validatedegree(Bearing) <= BlindZoneR_End) then
            goto Fail_to_Fire_R;  // Blindzone Area

          if (RBU_MAnager.Datcom <> nil) then
            RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);

          PktToFire.Available := False;
          RBU_MAnager.frm108Kanan.RefreshMissileIndikator(PktToFire.Missile);

        mmo1.Lines.Add('FIRE');
        mmo1.Lines.Add('Loncher Kanan');
        mmo1.Lines.Add('Missile' + floattostr(lRec.mMissileID));
        mmo1.Lines.Add('Bearing' + FloatToStr(lRec.mLncrBearing));
        mmo1.Lines.Add('Range' + FloatToStr(lRec.mLncRange));
        mmo1.Lines.Add( ''  );
        Fail_to_Fire_R :// Blind zone area
      end;
    end;

    if Counter <= OrderFireL.Count-1 then begin
      //  if not Lonch2.Enabled then  goto BlindzoneL;

      PktToFire := OrderFireL.Items[Counter];

      if not PktToFire.Condition then
        goto Fail_to_Fire_L;   // Missile set fault from Instruktur

      if not PktToFire.Available then
        goto Fail_to_Fire_L;   // Missile not Available

      lRec.mLauncherID  := PktToFire.Launcher;
      lRec.mMissileID   := PktToFire.Missile;
      lRec.mMissileNumber := lRec.mMissileID;
      Bearing := Lonch2.TrainingValue;

      if OrderFireL.Count > 2 then begin
        DiffDegToFireL := DiffDegToFireL + DegreeSalvoMode(OrderFireL.Count);
        Fire_With_SalvoMode
          (OwnShip.position.X, OwnShip.position.Y, RangeToFire, Bearing, C_Radius_Tembakan, DiffDegToFireL, RangeToFire, Bearing);
      end;
      lRec.mLncrBearing := Bearing;
      lRec.mLncRange    := RangeToFire;
      lRec.mCorrBearing  := Lonch1.CorrTraining;
      lRec.mCorrElev     := Lonch2.CorrElev;


       if (validatedegree(Bearing) >= BlindZoneL_Start) and (validatedegree(Bearing) <= BlindZoneL_End) then
        goto Fail_to_Fire_L;

      if (RBU_MAnager.Datcom <> nil) then
        RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);

      PktToFire.Available := False;
      RBU_MAnager.frm108Kiri.RefreshMissileIndikator(PktToFire.Missile);
      mmo1.Lines.Add('FIRE');
      mmo1.Lines.Add('Loncher Kiri');
      mmo1.Lines.Add('Missile' + floattostr(PktToFire.Missile));
      mmo1.Lines.Add('Bearing' + FloatToStr(lRec.mLncrBearing));
      mmo1.Lines.Add('Range' + FloatToStr(lRec.mLncRange));
      mmo1.Lines.Add( ''  );

      Fail_to_Fire_L: // Blindzone Left Launcher
    end;

end;


procedure TfrmPanelFire.btnFIREClick(Sender: TObject);
Var I, aCount : integer;
    Range              : Double;
begin
  Range   := StrToFloat(edtJarak.text) * C_Cable_To_Meter; // jarak dlm meter

  if not Is_WarMode then            // Switch burja pada posisi Latihan
    Range := Range - 3300;

if not GetBalistik(BalistikMode, Range,  Use_Balistik) then exit;


  if IsReadyToFire then
  begin

    case FireModeR of
      off:
      begin

      end;
      Single6:
      begin
       // ListMissileR[6].isLaunch := false;
        Lonch1.OrderFire.Add(ListMissileR[6]);
        TempSingleFireR := 6;
       // Lonch1.isreadyFire := true;
      end;
      Single11:
      begin
       // ListMissileR[11].isLaunch := false;
        Lonch1.OrderFire.Add(ListMissileR[11]);
        TempSingleFireR := 11;
       // Lonch1.isreadyFire := true;
      end;
      Single12:
      begin
      //  ListMissileR[12].isLaunch := false;
        Lonch1.OrderFire.Add(ListMissileR[12]);
        TempSingleFireR := 12;
      //  Lonch1.isreadyFire := true;
      end;
      Slavo4:
      begin
        for I := 1 to 4 do
        begin
         // ListMissileR[SequenceMissile[I]].isLaunch := false;
          Lonch1.OrderFire.Add(ListMissileR[SequenceMissile[I]]);
        //  Lonch1.isreadyFire := true;
          TempSingleFireR := 1;
        end;
        aCount := 4;
      end;
      Salvo8:
      begin
        for I := 1 to 8 do
        begin
        //  ListMissileR[SequenceMissile[I]].isLaunch := false;
          Lonch1.OrderFire.Add(ListMissileR[SequenceMissile[I]]);
         // Lonch1.isreadyFire := true;
         TempSingleFireR := 1;
        end;
        aCount := 8;
      end;
      Salvo12:
      begin
        for I := 1 to 12 do
        begin
        //  ListMissileR[SequenceMissile[I]].isLaunch := false;
          Lonch1.OrderFire.Add(ListMissileR[SequenceMissile[I]]);
        //  Lonch1.isreadyFire := true;
          TempSingleFireR := 1;
        end;
        aCount := 12;
      end;
    end;

    case FireModeL of
      off:
      begin

      end;
      Single6:
      begin
       Lonch2.OrderFire.Add(ListMissileL[6]);
       TempSingleFireL := 6;
      end;
      Single11:
      begin
        Lonch2.OrderFire.Add(ListMissileL[11]);
        TempSingleFireL := 11;
      end;
      Single12:
      begin
        Lonch2.OrderFire.Add(ListMissileL[12]);
        TempSingleFireL := 12;
      end;
      Slavo4:
      begin
        for I := 1 to 4 do
        Lonch2.OrderFire.Add(ListMissileL[SequenceMissile[I]]);
        TempSingleFireL := 1;

        aCount := 4;
      end;
      Salvo8:
      begin
        for I := 1 to 8 do
        Lonch2.OrderFire.Add(ListMissileL[SequenceMissile[I]]);
        TempSingleFireL := 1;

        aCount := 8;
      end;
      Salvo12:
      begin
        for I := 1 to 12 do
        Lonch2.OrderFire.Add(ListMissileL[SequenceMissile[I]]);
        TempSingleFireL := 1;

        aCount := 12;
      end;
    end;

    {Ontimer}

    if (Lonch1.OrderFire.Count < 1) and (Lonch2.OrderFire.Count < 1)  then
    begin
      Exit;
    end;

    if SendFireRBU(Lonch1, aCount) then
    begin
      mmo1.Lines.Add('FIRE');
      mmo1.Lines.Add('Loncher Kanan');
    end;
    if SendFireRBU(Lonch2, aCount) then
    begin
      mmo1.Lines.Add('FIRE');
      mmo1.Lines.Add('Loncher Kiri');
    end;

    Lonch1.OrderFire.Clear;
    Lonch2.OrderFire.Clear;

    {Ontimer}

  end;
end;

function TfrmPanelFire.DegreeSalvoMode(Count: byte): Single;
begin
  Result := 360 / Count;
end;

function TfrmPanelFire.SendFireRBU(Lonchr: TLoncher; aCount : integer): Boolean;
Var lRec : TRec3DSetRBU;
    PktToFire : TRecMissile;
    RangeToFire,
    BearingToFire,
    BlindZone_Start,
    BlindZone_End    : Double;

    I,
    Count : Integer;
    Order : Byte;
begin
    Result := False;

    if (Lonchr.IsLoading) then exit;           // Launcher sedang Loading

    RangeToFire   := StrToFloat(edtJarak.text) * C_Cable_To_Meter; // jarak dlm meter
    BearingToFire := Lonchr.TrainingValue;

    if Lonchr.ID = 1 then
    begin
      BlindZone_Start := BlindZoneR_Start;
      BlindZone_End   := BlindZoneR_End;
    end
    else if Lonchr.ID = 2 then
    begin
      BlindZone_Start := BlindZoneL_Start;
      BlindZone_End   := BlindZoneL_End;
    end;

    if (validatedegree(BearingToFire) >= BlindZone_Start) and
      (validatedegree(BearingToFire) <= BlindZone_End) then
      exit;  // Blindzone Area

    lRec.ShipID         := RBU_MAnager.pShipID;
    lRec.mWeaponID      := C_DBID_RBU6000;
    lRec.mMissileType   := Use_Balistik;
    lRec.mTargetID      := TargetID;
    lRec.mTargetDepth   := Abs(StrToFloat(TfrmBurjaAtas(RBU_MAnager.frmTopBurja).edt_Kedalaman.Text));

    Count := 0;

    for I := 0 to Lonchr.OrderFire.Count-1 do
    begin
      PktToFire := Lonchr.OrderFire.Items[I];

      if (PktToFire.Available) and (PktToFire.Condition) then         // Missile Available and set goood Condition from Instruktur
        Count := Count + 1;

       PktToFire.Available := False;
      if Lonchr.ID = 1 then
        RBU_MAnager.frm108Kanan.RefreshMissileIndikator(PktToFire.Missile)
      else
        RBU_MAnager.frm108Kiri.RefreshMissileIndikator(PktToFire.Missile);

    end;

    if Count > 0 then
    begin

        if Count > 1 then
          Order := __ORD_RBU_FIRE_SALVO
        else
          Order := __ORD_RBU_FIRE;

        lRec.mLauncherID    := Lonchr.ID;
        if Lonchr = Lonch1 then
        begin
           lRec.mMissileID     := TempSingleFireR;
        end
        else
        begin
           lRec.mMissileID     := TempSingleFireL;
        end;

        lRec.mMissileNumber := 1;
        lRec.mCount         := aCount;
        lRec.OrderID        := Order;
        lRec.mLncrBearing   := BearingToFire;
        lRec.mLncRange      := RangeToFire;
        lRec.mCorrBearing   := Lonchr.CorrTraining;   // Degree
        lRec.mCorrElev      := Lonchr.CorrElev;       // Degree

      if (RBU_MAnager.Datcom <> nil) then
      begin
         RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
         Result := True;
      end;
    end;
end;


procedure TfrmPanelFire.tmrReadValTimer(Sender: TObject);
var DirLauncher1, DirLauncher2 : Double;
begin

  if State_BarSAS then begin
    DirLauncher1 := Validate180Degree(Lonch1.TrainingValue);
    DirLauncher2 := Validate180Degree(Lonch2.TrainingValue);

    edt_Lonch1.Text :=  FloatToStr(LauncherScope(DirLauncher1));
    edt_Lonch2.Text :=  FloatToStr(LauncherScope(DirLauncher2));
  end;
  if State_Jarak then
    edtJarak.Text   := RBU_MAnager.frmTopBurja.edtJarak.Text;

  if State_KecSAS then
  edt_kec_Sasaran.Text := RBU_MAnager.frmTopBurja.edtKecSasaran.Text;

  //  RMKecSassaran.Value;
  //  RMKecSassaran.Scale := RmKecSassaran.Scale;

 end;

procedure TfrmPanelFire.txt1Change(Sender: TObject);
begin
//  edtValOut.Text := txt1.Text;
end;

procedure TfrmPanelFire.vrtryswtch1Change(Sender: TObject);
var idLog : Integer;
begin
   FireModeR := TFireMode(vrtryswtch1.SwitchPosition);
   case TFireMode(vrtryswtch1.SwitchPosition) of
     Single12 : idLog := 14;
     Single6  : idLog := 15;
     Single11 : idLog := 16;
     Slavo4   : idLog := 17;
     Salvo8   : idLog := 18;
     Salvo12  : idLog := 19;
   end;
   RBU_MAnager.SendEvenRBU(idLog);
end;

procedure TfrmPanelFire.vrtryswtch2Change(Sender: TObject);
var idLog : Integer;
begin
   FireModeL := TFireMode(vrtryswtch2.SwitchPosition);
   case TFireMode(vrtryswtch1.SwitchPosition) of
     Single12 : idLog := 20;
     Single6  : idLog := 21;
     Single11 : idLog := 22;
     Slavo4   : idLog := 23;
     Salvo8   : idLog := 24;
     Salvo12  : idLog := 25;
   end;
   RBU_MAnager.SendEvenRBU(idLog);
end;

function TfrmPanelFire.setAutoIndikator(Val : Single; LmtMin, LmtMax : Single): boolean;
begin
  if (Val > LmtMin) and (Val < LmtMax) then
    Result := True
  else
    Result := false;
end;

end.
