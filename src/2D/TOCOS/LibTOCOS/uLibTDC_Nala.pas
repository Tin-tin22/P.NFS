unit uLibTDC_Nala;

interface

uses
  uLibTDCClass, ufQEK, ufMIK, ufANDUDisplay;

type

//==============================================================================
  TTDC_NalaInterface = class (TGenericTDCInterface)
  protected
    frmKiri : TfrmQEK;
    frmKanan: TfrmQEK;

    frmMIK_Kiri : TfMIK;
    frmDisplay_Kiri : TfrmANDUDisplay;

    frmMIK_Kanan : TfMIK;
    frmDisplay_Kanan : TfrmANDUDisplay;

    procedure CreateForms_0;
    procedure CreateForms_1;
    procedure CreateForms_2;
  public

    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;
    procedure SetDefaultLayOut; override;

    procedure ShowAllForm; override;

    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_Right(const b: byte); override;

  end;

implementation

uses
  SysUtils, Forms, uFormUtil,  ufTDC1Kanan, ufTDC1Kiri, ufTDC2Kanan, ufTDC2Kiri,
  uLibTDCTracks,
  ufTDCTengah_Nala,
  ufDisplay_Nala,
  {ufInjectionKeyBoard, } uTrackFunction;

//==============================================================================
{ TTDC_NalaInterface }


constructor TTDC_NalaInterface.Create;
begin
  inherited;

  frmTengah  :=  TfrmTDCTengah_Nala.Create(nil);
  (frmTengah as TfrmTDCTengah_Nala).TDCInterface := self;
  frmTengah.Caption := ' Tactical Display Console KRI Nala';

end;

destructor TTDC_NalaInterface.Destroy;
begin
  FreeAndNil(frmTengah);

  inherited;
end;

procedure TTDC_NalaInterface.CreateForms_0;
begin
// ANDU Kiri
  frmMIK_Kiri      := TfMIK.Create(nil);
  frmMIK_Kiri.TDCInterface := self;
  frmMIK_Kiri.OBM := OBMleft;

  frmDisplay_Kiri  := TfrmDisplay_NALA.Create(nil);
  frmMIK_Kiri.Display := frmDisplay_Kiri;

  frmDisplay_Kiri.FOnExecuteCmd :=  frmMIK_Kiri.handle_execute;
  frmDisplay_Kiri.Caption := 'KRI NALA Alpha Numerik Display kiri';

// ANDU kanan
  frmMIK_Kanan      := TfMIK.Create(nil);
  frmMIK_Kanan.TDCInterface := self;
  frmMIK_Kanan.OBM := OBMRight;

  frmDisplay_Kanan  := TfrmDisplay_NALA.Create(nil);
  frmMIK_Kanan.Display := frmDisplay_Kanan;

  frmDisplay_Kanan.FOnExecuteCmd :=  frmMIK_Kanan.handle_execute;
  frmDisplay_Kiri.Caption := 'KRI NALA Alpha Numerik Display kanan';
end;

procedure TTDC_NalaInterface.CreateForms_1;
const
  caption_1 = ' NALA TDC 1';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  frmKiri         := TfrmTDC1Kiri.Create(nil);
  frmKiri.TDCInterface := self;
  frmKiri.Caption           := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  frmKanan         := TfrmTDC1Kanan.Create(nil);
  frmKanan.TDCInterface := self;
  frmKanan.Caption          := caption_1 + C_Kanan;
end;

procedure TTDC_NalaInterface.CreateForms_2;
const
  caption_2 = ' NALA TDC 2';
begin
  inherited;

  CreateForms_0;

  //- TDC 2 Kanan -//
  frmKanan              := TfrmTDC2Kanan.Create(nil);
  frmKanan.TDCInterface := self;
  frmKanan.Caption      := caption_2 + C_Kanan;

  //- TDC 2 Kiri  -//
  frmKiri               := TfrmTDC2Kiri.Create(nil);
  frmKiri.TDCInterface  := self;
  frmKiri.Caption           := caption_2 + C_Kiri;
end;

procedure TTDC_NalaInterface.CreateFormss(const num: byte);
begin
  if num = 1 then CreateForms_1
  else if num = 2 then CreateForms_2;
end;

procedure TTDC_NalaInterface.ShowAllForm;
begin
//  inherited;
  if Assigned(frmTengah) then  frmTengah.Show;
  if Assigned(frmKiri)   then  frmKiri.Show;
  if Assigned(frmKanan)  then  frmKanan.Show;
  if Assigned(frmMIK_Kanan)then frmMIK_Kanan.Show;
  if Assigned(frmDisplay_Kanan  )then frmDisplay_Kanan.Show;

  if Assigned(frmMIK_kiri )then frmMIK_Kiri.Show;
  if Assigned(frmDisplay_Kiri  )then frmDisplay_Kiri.Show;

end;

procedure TTDC_NalaInterface.SetDefaultLayOut;
begin
//  inherited;
   case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apLeftBottom   , 0 ,-20, TForm(frmKiri));
      AlignFormToMonitor(0, apRightBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(0, apLeftTop      , 0 , 0 , TForm(frmTengah ));

    end;
    2 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(1, apLeftBottom   , 0, -20, TForm(frmKiri));
      AlignFormToMonitor(1, apRightBottom  , 0 ,-20, TForm(frmKanan));

      AlignFormToMonitor(1, apRightTop  , 0, 0, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor(1, apRightTop  , 0, frmDisplay_Kanan.Height, TForm(frmMIK_Kanan));

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(1, apLeftTop  , 0, frmDisplay_Kanan.Height, TForm(frmMIK_Kiri ));
    end;
    3 : begin
      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));

      AlignFormToMonitor(0, apRightBottom  , 0, 0, TForm(frmKiri));
      AlignFormToMonitor(2, apLeftBottom  , 0 ,-20, TForm(frmKanan));

      AlignFormToMonitor(2, apLeftTop  , frmKanan.Width, 0, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor(2, apLeftTop  , frmKanan.Width, frmDisplay_Kiri.Height, TForm(frmMIK_Kanan ));

      AlignFormToMonitor(0, apRightTop  , -frmKiri.Width, 0, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(0, apRightTop  , -frmKiri.Width, frmDisplay_Kiri.Height, TForm(frmMIK_Kiri ));
    end;
  end;


end;


procedure TTDC_NalaInterface.DataRequest_left(const b: byte);
var obm    : tTdc_Symbol;
    findObj: boolean;
    s: string;
    frmDisplay : TfrmANDUDisplay;

begin // ini buat rencong dulu.
  if b = 255 then begin
     SetLPDText(false, '', '');
     exit;
  end;

    obm := OBMLeft;
    frmDisplay := frmDisplay_Kiri;

  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin
     if cTrack is TTDCTrack then begin
       s :=formatSCR_track_AS(cTrack as TManualTrack);
       frmDisplay.SetDRLText(s);
     end;
  end
  else begin
     frmDisplay.SetDRLText('');

  end;

end;

procedure TTDC_NalaInterface.DataRequest_Right(const b: byte); 
var obm    : tTdc_Symbol;
    findObj: boolean;
    s: string;
    frmDisplay : TfrmANDUDisplay;

begin // ini buat rencong dulu.
  if b = 255 then begin
     SetLPDText(false, '', '');
     exit;
  end;

  obm := OBMRight;
  frmDisplay := frmDisplay_Kanan;

  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin
     if cTrack is TTDCTrack then begin
       s :=formatSCR_track_AS(cTrack as TManualTrack);
       frmDisplay.SetDRLText(s);
     end;
  end
  else begin
     frmDisplay.SetDRLText('');

  end;

end;

end.
