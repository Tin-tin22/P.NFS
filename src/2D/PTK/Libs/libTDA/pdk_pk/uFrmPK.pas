unit uFrmPK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SpeedButtonImage,
  UfrmBaseTCMS, uTCMSSimManager, uTrackObject, uTcmsData, Buttons;

type
  TfrmPK = class(TfrmBaseTCMS)
    btnExocet: TSpeedButtonImage;
    btnTetralAft: TSpeedButtonImage;
    btnTetralFwd: TSpeedButtonImage;
    btnGun76: TSpeedButtonImage;
    btnBlank1: TSpeedButtonImage;
    btnBlank2: TSpeedButtonImage;
    btnBlank3: TSpeedButtonImage;

    procedure OnServiceUpdate(sender : TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPK: TfrmPK;

implementation

{$R *.dfm}

{ TfrmPK }

procedure TfrmPK.FormCreate(Sender: TObject);
begin
  inherited;
  btnTetralAft.Caption := 'TETRAL AFT' + #13#10 + 'FIRE';
  btnTetralFwd.Caption := 'TETRAL FWD' + #13#10 + 'FIRE';
  btnExocet.Caption := 'EXOCET' + #13#10 + 'FIRE';
  btnGun76.Caption := 'GUN76' + #13#10 + 'FIRE';

  btnTetralAft.Color := clRed;
  btnTetralFwd.Color := clRed;
  btnExocet.Color := clRed;
  btnGun76.Color := clRed;
  btnBlank1.Color := clRed;
  btnBlank2.Color := clRed;
  btnBlank3.Color := clRed;

  btnTetralAft.Enabled := false;
  btnTetralFwd.Enabled := false;
  btnExocet.Enabled := false;
  btnGun76.Enabled := false;
  btnBlank1.Enabled := false;
  btnBlank2.Enabled := false;
  btnBlank3.Enabled := false;
end;

procedure TfrmPK.OnServiceUpdate(sender: TObject);
var
  { Gun76 }
  isGunOn, isGunAuth, isGunEng, isHF, isGunReady, isDesig : Boolean;
begin
  inherited;
  { gun76 }
  isHF      := True;
  isGunEng  := False;
  isGunOn   := False;
  isDesig   := False;

  if SimManager.Sigma.Gun76mm.PowerStat = psOn then
    isGunOn := True;

  isGunAuth := SimManager.Sigma.Gun76mm.FireAuth;
  if Assigned(SimManager.Sigma.Gun76mm.TargetObject) then
  begin
    isHF := TBaseTrack(SimManager.Sigma.Gun76mm.TargetObject).HoldFire;
  end;

  if SimManager.Sigma.Gun76mm.TgtEngAbl = teaENG then
    isGunEng := True;

  if SimManager.Sigma.Gun76mm.Desig then
    isDesig := True
  else
  if not SimManager.Sigma.Gun76mm.Desig then
    isDesig := False;

  isGunReady := isGunOn
                and (not isHF)
                and isGunAuth
                and isGunEng
                and isDesig;

  if (SimManager.Sigma.Gun76mm.GunConnection = gcTDSPort)
    or (SimManager.Sigma.Gun76mm.GunConnection = gcTDSStbd) then
  begin
    // Not send to PK 76mm
  end
  else begin
    // Updating PK Status
    if isGunReady then
    begin
      btnGun76.Enabled := true;
    end
    else if not isGunReady then
    begin
      btnGun76.Enabled := False;
    end;
  end;

  { Tetral }
  { Forward }
  if SimManager.Sigma.FTetralLauncher[0].IsPowerOnPK then
  begin
    btnTetralFwd.Enabled := True;
  end
  else
  begin
    btnTetralFwd.Enabled := False;
  end;
  { After }
  if SimManager.Sigma.FTetralLauncher[1].IsPowerOnPK then
  begin
    btnTetralAft.Enabled := True;
  end
  else
  begin
    btnTetralAft.Enabled := False;
  end;
end;

end.
