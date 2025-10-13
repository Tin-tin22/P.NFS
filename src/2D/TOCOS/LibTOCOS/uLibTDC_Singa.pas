unit uLibTDC_Singa;

interface

uses
  uLibTDCClass,
  forms,
  ufTDCTengah_Singa,
  ufQek,

  ufANDUKeyBoard,
  ufANDUDisplay,
//  ufTdcKeyboard,
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

    frmKeyBoard: TfrmANDUKey;
    frmDisplay : TfrmANDUDisplay;


    procedure CreateForms_1;
  public

//    frmTdcPwo      :  TForm;
//    frmTdcPC       :  TForm;

    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;

    procedure SetDefaultLayOut; override;
    procedure ShowAllForm; override;


  end;

implementation

uses
  SysUtils, uFormUtil,  ufMIK_singa;

//==============================================================================
{ TTDC_Singa }

constructor TTDC_Singa.Create;
begin
  inherited;

end;

procedure TTDC_Singa.CreateFormss(const num: byte);
begin
  CreateForms_1;
end;

procedure TTDC_Singa.CreateForms_1;
begin
  inherited;

  frmTengah       := TfrmTDCTengah_Singa.Create(nil);
  (frmTengah as  TfrmTDCTengah_Singa).TDCInterface :=  self;
  frmTengah.Caption := 'Tactical Display Console KRI SINGA';

//  frmKeyBoardKiri   := TfrmTdcKeyboard.Create(nil);
//  frmKeyBoardKanan  := TfrmTdcKeyboard.Create(nil);

  frmKanan  := TfTDCKanan_Singa.Create(nil);
  frmKanan.Caption := 'Quick Entry Keyboard Kanan KRI Singa';
  (frmKanan as TfrmQEK).TDCInterface := self;

  frmkiri  := TfTDCKiri_singa.Create(nil);
  frmkiri.Caption := 'Quick Entry Keyboard kiri KRI Singa';
  (frmkiri as TfrmQEK).TDCInterface := self;

  frmTengahBawah  :=  TfrmTdcTengahBawah.Create(nil);
  (frmTengahBawah as TfrmTdcTengahBawah).TDCInterface := self;
//  frmTdcPwo       :=  TfrmTdcPwo.Create(nil);
//  frmTdcPC        :=  TfrmTdcPc.Create(nil);

  frmDisplay := TfrmANDUDisplay.Create(nil);

  frmKeyBoard := TfrmMIK_Singa.Create(nil);
  frmKeyBoard.TDCInterface := self;
  frmKeyBoard.OBM := OBMRight;
  
  frmKeyBoard.Display := frmDisplay;

  frmDisplay.FOnExecuteCmd := frmKeyBoard.handle_execute;
end;

destructor TTDC_Singa.Destroy;
begin

  FreeAndNil(frmKeyBoard);

  FreeAndNil(frmDisplay);

  FreeAndNil( frmTengah   );
  FreeAndNil( frmTengahBawah);

//  FreeAndNil(frmKeyBoardKiri);
//  FreeAndNil(frmKeyBoardKanan);

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
      AlignFormToMonitor(0, apLeftTop      , 0 , 0 , TForm(frmTengah ));

      AlignFormToMonitor(0, apLeftBottom   , 0 ,-20, TForm(frmKiri));
      AlignFormToMonitor(0, apRightBottom  , 0 ,-20, TForm(frmKanan));

    end;
    2 : begin
      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(1, apLeftBottom   , 0, -20, TForm(frmKiri));
      AlignFormToMonitor(1, apRightBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(1, apRightBottom, 0, -20, frmTengahBawah);

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmDisplay ));
      AlignFormToMonitor(1, apLeftTop  , 0, frmDisplay.Height, TForm(frmKeyBoard ));
    end;
    3 : begin
      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));

      AlignFormToMonitor(0, apRightBottom  , 0, 0, TForm(frmKiri));
      AlignFormToMonitor(2, apLeftBottom  , 0 ,-20, TForm(frmKanan));

      AlignFormToMonitor(2, apLeftTop  , 0, 0, TForm(frmDisplay ));
      AlignFormToMonitor(2, apLeftTop  , 0, frmDisplay.Height, TForm(frmKeyBoard ));

    end;
  end;

end;

procedure TTDC_Singa.ShowAllForm;
begin

  if Assigned(frmTengah       )then frmTengah.Show;
  if Assigned(frmTengahBawah  )then frmTengahBawah.Show;

  if Assigned(frmKiri         )then frmKiri.Show;
  if Assigned(frmKanan        )then frmKanan.Show;

  if Assigned(frmTengahBawah  )then frmTengahBawah.Show ;
  if Assigned(frmDisplay )then frmDisplay.Show ;
  if Assigned(frmKeyBoard )then frmKeyBoard.Show ;


end;

end.
