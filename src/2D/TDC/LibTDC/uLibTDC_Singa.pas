unit uLibTDC_Singa;

interface

uses
  uLibTDCClass,
  forms,
  ufTDCTengah_Singa,
  ufQek,

  ufANDUKeyBoard,
  ufANDUDisplay,
  ufDisplay_Nala,
  ufTDCkanan_Singa,
  ufTDCkiri_Singa,
  ufTdcPc,
  ufTdcPwo,
  ufTdcTengahBawah;


type

//==============================================================================
  TTDC_Singa = class(TGenericTDCInterface)
  protected
    frmKiri : TfrmQEK;
    frmKanan: TfrmQEK;

    frmTengahBawah :  TForm;

    frmKB_kiri: TfrmANDUKey;
    frmDisplay_kiri : TfrmANDUDisplay;

    frmKB_kanan: TfrmANDUKey;
    frmDisplay_kanan : TfrmANDUDisplay;

    procedure CreateForms_1;
  public


    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;

    procedure SetDefaultLayOut; override;
    procedure ShowAllForm; override;

    procedure CommonDataRequest(obm: tTdc_Symbol; display: TfrmANDUDisplay);
    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_Right(const b: byte); override;

    procedure ShowFormBawahOWA; override;
    procedure HideFormBawahOWA; override;


  end;

implementation

uses
  SysUtils, uFormUtil,  ufMIK_singa, uLibTDCTracks, uTrackFunction, uBaseConstan;

//==============================================================================
{ TTDC_Singa }

constructor TTDC_Singa.Create;
begin
  GunNumber := 2;

  inherited;

end;

procedure TTDC_Singa.CreateFormss(const num: byte);
begin
  CreateForms_1;
  frmTengah.Caption := 'Tactical Display Console ' + MyShipName;
  frmKanan.Caption := 'Q E K  Kanan' + MyShipName;
  frmKiri.Caption := 'Q E K  Kiri' + MyShipName;

  frmDisplay_kiri.Caption := 'A N D U  kiri '   + MyShipName;
  frmDisplay_kanan.Caption := 'A N D U  kanan ' + MyShipName;

  frmKB_kiri.Caption   := 'MIK kiri ' + MyShipName;
  frmKB_kanan.Caption  := 'MIK kanan ' + MyShipName;

end;

procedure TTDC_Singa.CreateForms_1;
begin
  inherited;

  frmTengah       := TfrmTDCTengah_Singa.Create(nil);
  (frmTengah as  TfrmTDCTengah_Singa).TDCInterface :=  self;
  frmTengah.Caption := 'Tactical Display Console KRI SINGA';

//  frmKB_kiriKiri   := TfrmTdcKeyboard.Create(nil);
//  frmKB_kiriKanan  := TfrmTdcKeyboard.Create(nil);

  frmKanan  := TfTDCKanan_Singa.Create(nil);
  frmKanan.Caption := 'Quick Entry Keyboard Kanan ';
  (frmKanan as TfrmQEK).TDCInterface := self;

  frmkiri  := TfTDCKiri_singa.Create(nil);
  frmkiri.Caption := 'Quick Entry Keyboard kiri ';
  (frmkiri as TfrmQEK).TDCInterface := self;

  frmTengahBawah  :=  TfrmTdcTengahBawah.Create(nil);
  (frmTengahBawah as TfrmTdcTengahBawah).TDCInterface := self;

  frmDisplay_kiri := TfrmDisplay_NALA.Create(nil);
  frmDisplay_kiri.Caption := 'A N D U  ';

  frmKB_kiri := TfrmMIK_Singa.Create(nil);
  frmKB_kiri.TDCInterface := self;
  frmKB_kiri.OBM          := OBMLeft;
  frmKB_kiri.PositionID   :=  C_key_kiri;

  frmKB_kiri.Display := frmDisplay_kiri;
  frmDisplay_kiri.FOnExecuteCmd := frmKB_kiri.handle_execute;

  frmDisplay_kanan := TfrmDisplay_NALA.Create(nil);
  frmDisplay_kanan.Caption := 'A N D U  ';

  frmKB_kanan := TfrmMIK_Singa.Create(nil);
  frmKB_kanan.TDCInterface  := self;
  frmKB_kanan.OBM           := OBMRight;
  frmKB_kanan.PositionID    := C_key_kanan;

  frmKB_kanan.Display := frmDisplay_kanan;
  frmDisplay_kanan.FOnExecuteCmd := frmKB_kanan.handle_execute;

end;

destructor TTDC_Singa.Destroy;
begin

  FreeAndNil(frmKB_kiri);
  FreeAndNil(frmDisplay_kiri);

  FreeAndNil(frmKB_kanan);
  FreeAndNil(frmDisplay_kanan);

  FreeAndNil( frmTengah   );
  FreeAndNil( frmTengahBawah);


  FreeAndNil(frmKanan);
  FreeAndNil(frmKiri);

  FreeAndNil(frmTengahBawah);
//  FreeAndNil(frmTdcPwo);
//  FreeAndNil(frmTdcPc);

  inherited;
end;


procedure TTDC_Singa.SetDefaultLayOut;
begin
   case Screen.MonitorCount of
    1 : begin

      AlignFormToMonitor(0, apLeftBottom   , 0 ,-20, TForm(frmKiri));
      AlignFormToMonitor(0, apRightBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(0, apLeftTop  , 0, 0, TForm(frmDisplay_kiri ));
      AlignFormToMonitor(0, apLeftTop  , 0, frmDisplay_kiri.Height, TForm(frmKB_kiri ));
      AlignFormToMonitor(0, apRightTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(0, apRightTop  , 0, frmDisplay_kanan.Height, TForm(frmKB_kanan ));

      AlignFormToMonitor(0, apLeftTop      , 0 , 0 , TForm(frmTengah ));
    end;
    2 : begin
      AlignFormToMonitor(0, apLeftTop  ,  0, 0, TForm(frmTengah ));
      AlignFormToMonitor(1, apLeftBottom   , 0, -20, TForm(frmKiri));
      AlignFormToMonitor(1, apRightBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(1, apRightBottom, 0, -20, frmTengahBawah);

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmDisplay_kiri ));
      AlignFormToMonitor(1, apLeftTop  , 0, frmDisplay_kiri.Height, TForm(frmKB_kiri ));
      AlignFormToMonitor(1, apRightTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(1, apRightTop  , 0, frmDisplay_kanan.Height, TForm(frmKB_kanan ));
    end;
    3 : begin

      AlignFormToMonitor(0, apRightBottom  , 0, 0, TForm(frmKiri));
      AlignFormToMonitor(0, apRightTop     , 0, 0, TForm(frmDisplay_kiri ));
      AlignFormToMonitor(0, apRightTop     , 0, frmDisplay_kiri.Height, TForm(frmKB_kiri ));

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));

      AlignFormToMonitor(2, apLeftBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(2, apLeftTop     , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(2, apLeftTop     , 0, frmDisplay_kanan.Height, TForm(frmKB_kanan ));

    end;
  end;

end;

procedure TTDC_Singa.ShowAllForm;
begin

  if Assigned(frmTengah       )then frmTengah.Show;
  if Assigned(frmTengahBawah  )then frmTengahBawah.Show;

  if Assigned(frmKiri         )then frmKiri.Show;
  if Assigned(frmKanan        )then frmKanan.Show;

  if Assigned(frmDisplay_kiri )then frmDisplay_kiri.Show ;
  if Assigned(frmKB_kiri )then frmKB_kiri.Show ;

  if Assigned(frmDisplay_kanan )then frmDisplay_kanan.Show ;
  if Assigned(frmKB_kanan )then frmKB_kanan.Show ;
end;


procedure TTDC_Singa.CommonDataRequest(obm: tTdc_Symbol; display: TfrmANDUDisplay);
var s: string;
    findObj: boolean;
    mTrack : tManualTrack;
begin
  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin

    s := '';
    if cTrack is TManualTrack then begin
      mTrack := cTrack as TManualTrack;
      s := formatSCR_track_AS(mTrack);
      case  mTrack.Domain of
        tdAtasAir,
        tdUdara   : begin
          s := formatSCR_track_AS(mTrack);
        end;
        tdBawahAir : begin
          s := formatSCR_track_U(mTrack);
        end;
      end;
    end
    else if cTrack is TDatumTrack then begin
       dtTrack := cTrack as TDatumTrack;
       s := formatSCR_datum(dtTrack, tdcData.LocalTime);
    end
    else if cTrack is TESMFixTrack then begin
       s := formatSCR_ESMFix(cTrack, tdcData.LocalTime);
    end
    else if cTrack is TESMBearingTrack then begin
       s := formatSCR_ESMBear(cTrack, tdcData.LocalTime);
    end
    else if cTrack is TRefPosTrack then begin
       s := formatSCR_RP(cTrack);
    end;

    display.SetDRLText(s);

  end
  else begin
       display.SetDRLText('');
  end;

end;

procedure TTDC_Singa.DataRequest_left(const b: byte);
begin
  if b = 0 then begin
    CommonDataRequest(OBMLeft, frmDisplay_kiri);

  end
  else begin
       frmDisplay_kiri.SetDRLText('');
  end;

end;

procedure TTDC_Singa.DataRequest_Right(const b: byte);
begin
  if b = 0 then begin
    CommonDataRequest(OBMRight, frmDisplay_kanan);
  end
  else begin
       frmDisplay_kanan.SetDRLText('');
  end;
end;

procedure TTDC_Singa.ShowFormBawahOWA;
begin
  TfrmTdcTengahBawah(frmTengahBawah).setMaxPosition(frmTengah);
  frmTengahBawah.AlphaBlend := false;
end;

procedure TTDC_Singa.HideFormBawahOWA;
begin
  TfrmTdcTengahBawah(frmTengahBawah).setPosition(frmTengah);
  frmTengahBawah.AlphaBlend := true;
end;

end.
