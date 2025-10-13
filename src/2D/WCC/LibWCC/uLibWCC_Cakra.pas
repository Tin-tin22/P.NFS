unit uLibWCC_Cakra;

interface

uses
  Graphics, ulibTDCClass, uLibWCCClassNew, uLibWCCKu, uFormUtil, Forms,
  uDetected, uBaseDataType, uBaseFunction;

type
//==============================================================================
  TWCC_CakraInterface = class (TGenericWCCInterface)
  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetDefaultLayOut; virtual;

    //procedure CreateTarget;

  end;

implementation

uses
  SysUtils, ufAndu_Cakra, ufAtas_Cakra, ufBawahKiri_Cakra, ufBawahKanan_Cakra,
  ufWCCTengah, ufAScope, ufBScope, uBaseConstan;

//==============================================================================
{ TWCC_CakraInterface }

constructor TWCC_CakraInterface.Create;
begin
  inherited;

  frmTengah  :=  TfrmWCCTengah.Create(nil);
  (frmTengah as TfrmWCCTengah).WCCInterface := self;
  frmTengah.Caption := 'Target Motion Analysis Display KRI Cakra';

  {frmTMAD := TfrmWCCTengah.Create(nil);
  (frmTMAD as TfrmWCCTengah).WCCInterface := self;
  frmTMAD.Caption := 'Weapon Control Display KRI Cakra';}

  frmWCCAtas1 := TfrmAtas_Cakra.Create(nil);
  (frmWCCAtas1 as TfrmAtas_Cakra).WCCInterface := self;
  frmWCCAtas1.Caption := 'Left Upper Panel';

  frmWCCAtas2 := TfrmAndu_Cakra.Create(nil);
  (frmWCCAtas2 as TfrmAndu_Cakra).WCCInterface := self;
  frmWCCAtas2.Caption := 'Right Upper Panel';

  frmWCCBawah1 := TfrmBawahKiri_Cakra.Create(nil);
  (frmWCCBawah1 as TfrmBawahKiri_Cakra).WCCInterface := self;
  frmWCCBawah1.Caption := 'Left Lower Panel';

  frmWCCBawah2 := TfrmBawahKanan_Cakra.Create(nil);
  (frmWCCBawah2 as TfrmBawahKanan_Cakra).WCCInterface := self;
  frmWCCBawah2.Caption := 'Right Lower Panel';

  frmScopeA := TfrmAScope.Create(nil);
  frmScopeA.Caption := 'A-Scope';
  frmScopeB := TfrmBScope.Create(nil);
  frmScopeB.Caption := 'B-Scope';

  Gun1 := TGun.Create(1);
  Gun2 := TGun.Create(2);
  Gun3 := TGun.Create(3);

  SetDefaultLayOut;        
end;

destructor TWCC_CakraInterface.Destroy;
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

procedure TWCC_CakraInterface.SetDefaultLayOut;
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
      AlignFormToMonitor(0, apLeftBottom , 0, 0, frmWCCBawah1);
      AlignFormToMonitor(1, apLeftTop   , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(1, apLeftBottom     , 0,   0, frmWCCBawah2);
      AlignFormToMonitor(1, apLeftBottom   , 0, 0, TForm(frmTengah));
    end;
    3,4 : begin
      AlignFormToMonitor(0, apRightTop , 0, 0, frmWCCAtas1);
      AlignFormToMonitor(0, apRightBottom  , 0, 0, frmWCCBawah1);
      AlignFormToMonitor(2, apLeftTop   , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(2, apLeftBottom  , 0, 0, frmWCCBawah2);
      AlignFormToMonitor(0, apCenter   , 0, 0, TForm(frmTengah));
      //AlignFormToMonitor(2, apRightTop   , 0, 0, TForm(frmTMAD));
    end;
  end;
end;
{

procedure TWCC_CakraInterface.CreateTarget;
var mTrack: TManualTrack;
  i, temp: integer;
  r, b: double;
  dpt : t2DPoint;
  pX, pY: double;
begin
  for i := 0 to 3 do begin
    Randomize;
    temp := Random(trunc(FTDCRangeScale));
    r := temp + random;
    temp := random(360);
    b := temp + random;

    RangeBearingToCoord(r, b, dPt.X, dPt.Y);

    pX := xSHIP.PositionX + dPt.X * C_NauticalMile_To_Degree;
    pY := xSHIP.Positiony + dPt.Y * C_NauticalMile_To_Degree;

    CreateDefaultMTrack(mTrack, pX, pY);
    mTrack.SetIdent(ID_AtasAir_Hostile);
    mTrack.Speed := 40.0;
    mTrack.Course := Random(360);
  end;
end;            }



end.


