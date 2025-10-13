unit uLibWCC_Rencong;

interface

uses
  ulibTDCClass, uLibWCCClassNew, uLibWCCKu, uFormUtil, Forms,
  uMainFormWCC;

type

//==============================================================================
  TWCC_RencongInterface = class(TGenericWCCInterface)
  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetDefaultLayOut; virtual;
  end;

implementation

uses
  SysUtils, ufAtas_Rencong, ufAtas2_Rencong, ufBawah_Rencong, ufBawah2_Rencong,
  ufWCCTengah, ufAScope, ufBScope, ufQEK;

//==============================================================================
// TWCC_RencongInterface

constructor TWCC_RencongInterface.Create;
begin
  inherited;

  fMainWCC.WCCInterface := self;

  frmQEK := TfrmQEK.Create(nil);
  (frmQEK as TfrmQEK).WCCInterface := self;

  frmTengah  :=  TfrmWCCTengah.Create(nil);
  (frmTengah as TfrmWCCTengah).WCCInterface := self;
  frmTengah.Caption := 'Weapon Control Console KRI Rencong';

  frmWCCAtas1 := TfrmAtas_Rencong.Create(nil);
  (frmWCCAtas1 as TfrmAtas_Rencong).WCCInterface := self;
  frmWCCAtas1.Caption := 'Panel Kiri Atas';

  frmWCCAtas2 := TfrmAtas2_Rencong.Create(nil);
  (frmWCCAtas2 as TfrmAtas2_Rencong).WCCInterface := self;
  frmWCCAtas2.Caption := 'Panel Kanan Atas';

  frmWCCBawah1 := TfrmBawah_Rencong.Create(nil);
  (frmWCCBawah1 as TfrmBawah_Rencong).WCCInterface := self;
  frmWCCBawah1.Caption := 'Panel Kiri Bawah';

  frmWCCBawah2 := TfrmBawah2_Rencong.Create(nil);
  (frmWCCBawah2 as TfrmBawah2_Rencong).WCCInterface := self;
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

destructor TWCC_RencongInterface.Destroy;
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

procedure TWCC_RencongInterface.SetDefaultLayOut;
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
