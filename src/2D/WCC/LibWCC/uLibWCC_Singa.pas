unit uLibWCC_Singa;

interface

uses
  ulibTDCClass, uLibWCCClassNew, uLibWCCKu, uFormUtil, Forms,
  uMainFormWCC;

type

//==============================================================================
  TWCC_SingaInterface = class(TGenericWCCInterface)
  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetDefaultLayOut; virtual;
  end;

implementation

uses
  SysUtils, ufAtas_Singa, ufAtas2_Singa, ufBawah_Singa, ufBawah2_Singa,
  ufWCCTengah, ufAScope, ufBScope, ufQEK;

//==============================================================================
// TWCC_SingaInterface

constructor TWCC_SingaInterface.Create;
begin
  inherited;

  fMainWCC.WCCInterface := self;

  frmQEK := TfrmQEK.Create(nil);
  (frmQEK as TfrmQEK).WCCInterface := self;

  frmTengah  :=  TfrmWCCTengah.Create(nil);
  (frmTengah as TfrmWCCTengah).WCCInterface := self;
  frmTengah.Caption := 'Weapon Control Console KRI Singa';

  frmWCCAtas1 := TfrmAtas_Singa.Create(nil);
  (frmWCCAtas1 as TfrmAtas_Singa).WCCInterface := self;
  frmWCCAtas1.Caption := 'Panel Kiri Atas';

  frmWCCAtas2 := TfrmAtas2_Singa.Create(nil);
  (frmWCCAtas2 as TfrmAtas2_Singa).WCCInterface := self;
  frmWCCAtas2.Caption := 'Panel Kanan Atas';

  frmWCCBawah1 := TfrmBawah_Singa.Create(nil);
  (frmWCCBawah1 as TfrmBawah_Singa).WCCInterface := self;
  frmWCCBawah1.Caption := 'Panel Kiri Bawah';

  frmWCCBawah2 := TfrmBawah2_Singa.Create(nil);
  (frmWCCBawah2 as TfrmBawah2_Singa).WCCInterface := self;
  frmWCCBawah2.Caption := 'Panel Kanan Bawah';

  frmScopeA := TfrmAScope.Create(nil);
  frmScopeA.Caption := 'A-Scope';
  frmScopeB := TfrmBScope.Create(nil);
  frmScopeB.Caption := 'B-Scope';

  Gun1 := TGun.Create(1);
  Gun2 := TGun.Create(2);
  Gun3 := TGun.Create(3);

  SetDefaultLayOut;
end;

destructor TWCC_SingaInterface.Destroy;
begin
  FreeAndNil(frmWCCAtas1);
  FreeAndNil(frmWCCAtas2);
  FreeAndNil(frmWCCBawah1);
  FreeAndNil(frmWCCBawah2);
  FreeAndNil(frmTengah);
  FreeAndNil(frmScopeA);
  FreeAndNil(frmScopeB);

  inherited;
end;

procedure TWCC_SingaInterface.SetDefaultLayOut;
begin
  case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, frmWCCAtas1);
      AlignFormToMonitor(0, apRightTop , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(0, apLeftBottom  , 0 ,-20, frmWCCBawah1);
      AlignFormToMonitor(0, apRightBottom , 0 ,-20, frmWCCBawah2);
    end;
    2 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, frmWCCAtas1);
      AlignFormToMonitor(0, apLeftBottom , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(1, apLeftTop   , 0, 0, frmWCCBawah1);
      AlignFormToMonitor(1, apLeftBottom     , 0,   0, frmWCCBawah2);
      AlignFormToMonitor(0, apLeftBottom   , 0, 0, TForm(frmTengah));
    end;
    3,4 : begin
      AlignFormToMonitor(0, apRightTop , 0, 0, frmWCCAtas1);
      AlignFormToMonitor(0, apRightBottom  , 0, 0, frmWCCBawah1);
      AlignFormToMonitor(2, apLeftTop   , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(2, apLeftBottom  , 0, 0, frmWCCBawah2);
      AlignFormToMonitor(1, apLeftTop   , 0, 0, frmScopeA);
      AlignFormToMonitor(1, apRightTop   , 0, 0, frmScopeB);
      AlignFormToMonitor(1, apLeftBottom   , 0, 0, TForm(frmTengah));
    end;
  end;

end;

end.
