unit uLibTDC_Rencong;

interface

uses
  uLibTDCClass, uTCPDataType,
  ufQEK;

type

//==============================================================================
  TTDC_Rencong = class(TGenericTDCInterface)
  protected
    frmKiri : TfrmQEK;
    frmKanan: TfrmQEK;

    procedure CreateForms_1;

  public
    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;
    procedure ShowAllForm; override;

    procedure SetDefaultLayOut; override;

    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_right(const b: byte); override;

    procedure setAssignSSM(aRec: TRecOrderXY; send: boolean); override;
    procedure setDeAssignSSM(send: boolean); override;

    procedure Walk;   override;  // walk is slower than run.

  end;

implementation

uses
  SysUtils, Forms, // ufTDC1Kanan,   ufTDC1Kiri, ufTDC2Kanan, ufTDC2Kiri,
  //ufTDCTengah,
  ufTDCTengah_Rencong,
  ufTDCKiri_Rencong,
  ufTDCKanan_Rencong,
  uFormUtil, uLibTDCTracks,  uTrackFunction
  ;


{ TTDC_Rencong }

constructor TTDC_Rencong.Create;
begin
  GunNumber := 2;

  inherited;

  frmTengah  :=  TfrmTDCTengah_Rencong.Create(nil);
  (frmTengah as TfrmTDCTengah_Rencong).TDCInterface := self;

  frmTengah.Caption := ' Tactical Display Console';

  frmKiri := TfrmTDCKiri_Rencong.Create(nil);
  (frmKiri as TfrmTDCKiri_Rencong).TDCInterface := self;

  frmKanan := TfrmTDCKanan_Rencong.Create(nil);
  (frmKanan as TfrmTDCKanan_Rencong).TDCInterface := self;

end;

destructor TTDC_Rencong.Destroy;
begin

  FreeAndNil(frmTengah);

  if Assigned(frmKanan) then FreeAndNil(frmKanan);
  if Assigned(frmKiri) then FreeAndNil(frmKiri);

  inherited;
end;

procedure TTDC_Rencong.CreateForms_1;
const
  caption_1 = ' Rencong TDC 1';
begin
  inherited;

  //- TDC 1 Kiri  -//
//  frmKiri         := TfrmTDC1Kiri.Create(nil);
//  (frmKiri as TfrmTDC1Kiri).TDCInterface := self;

  //- TDC 1 Kanan -//
//  frmKanan         := TfrmTDC1Kanan.Create(nil);
//  (frmKanan as TfrmTDC1Kanan).TDCInterface := self;

//  frmKanan.Caption          := caption_1 + C_Kanan;
//  frmKeyBoardKanan.Caption  := caption_1 + C_Kanan;

//  frmKiri.Caption           := caption_1 + C_Kiri;
//  frmKeyboardKiri.Caption   := caption_1 + C_Kiri;

  SetDefaultLayOut;

end;

procedure TTDC_Rencong.CreateFormss;
begin
//  inherited;
  CreateForms_1;
  frmTengah.Caption := ' Tactical Display Console' + MyShipName;

end;

procedure TTDC_Rencong.ShowAllForm;
begin
  if Assigned(frmTengah) then  frmTengah.Show;
  if Assigned(frmKiri)   then  frmKiri.Show;
  if Assigned(frmKanan)  then  frmKanan.Show;

end;

procedure TTDC_Rencong.SetDefaultLayOut;
begin
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

    end;
    3 : begin
      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));

      AlignFormToMonitor(0, apRightBottom  , 0, 0, TForm(frmKiri));
      AlignFormToMonitor(2, apLeftBottom  , 0 ,-20, TForm(frmKanan));

    end;
  end;
end;

procedure TTDC_Rencong.DataRequest_Left(const b: byte);
var obm    : tTdc_Symbol;
    findObj: boolean;
    s: string;
begin // ini buat rencong dulu.
  if b = 255 then begin
     SetLPDText(false, '', '');
     exit;
  end;

  if b = 0 then obm := OBMLeft
  else obm := OBMRight;

  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin
     if cTrack is tManualTrack then begin
       s := formatSCR_track_AS (cTrack as TManualTrack);
       SetLPDText(true, s);
     end;
  end
  else begin
     SetLPDText(false, '', '');

  end;
end;

procedure TTDC_Rencong.DataRequest_Right(const b: byte);
var obm    : tTdc_Symbol;
    findObj: boolean;
    s: string;
begin // ini buat rencong dulu.
  if b = 255 then begin
     SetLPDText(false, '', '');
     exit;
  end;

  if b = 0 then obm := OBMLeft
  else obm := OBMRight;

  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin
     if cTrack is tManualTrack then begin
       s := formatSCR_track_AS (cTrack as TManualTrack);
       SetLPDText(true, s);
     end;
  end
  else begin
     SetLPDText(false, '', '');

  end;
end;

procedure TTDC_Rencong.setAssignSSM(aRec: TRecOrderXY; send: boolean);
begin
  inherited;

  SetLPDText(TRUE, 'R - M     W - M     D - M', ' ');
end;

procedure TTDC_Rencong.setDeAssignSSM(send: boolean);
begin
  inherited;

  SetLPDText(false, '', ' ');

end;

procedure TTDC_Rencong.Walk;
begin
  inherited;


end;

end.
