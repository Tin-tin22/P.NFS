unit ufrControl_C57;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, Buttons, StdCtrls, uTCPDatatype, uTCPClient,
  OverbyteIcsWSocket;

type
  TfrCtrl57 = class(TFrame)
    btn_R10: TSpeedButton;
    btn_R30: TSpeedButton;
    btn_R100: TSpeedButton;
    btn_R50: TSpeedButton;
    pnl_C57Lock: TPanel;
    btn_FireC57: TSpeedButton;
    btn_Salvo57: TSpeedButton;
    procedure pnl_C57LockClick(Sender: TObject);
    procedure btn_FireC57Click(Sender: TObject);
    procedure btn_R10Click(Sender: TObject);
    procedure SetDefaultValOrd;
    procedure PrepareOrdUnlock;
    procedure SendOrdUnlock;
  private
    { Private declarations }
    function CheckSelectRate: Integer;
    function CheckModeFire: Integer;
  public
    { Public declarations }
    pMissileID : Integer;
  end;

var
  RecSendCannon57: TRec3DSetWCC;

implementation

uses uModeControl;

{$R *.dfm}

procedure TfrCtrl57.btn_FireC57Click(Sender: TObject);
begin
  CheckModeFire;
end;

procedure TfrCtrl57.btn_R10Click(Sender: TObject);
begin
  CheckSelectRate;
end;

procedure TfrCtrl57.pnl_C57LockClick(Sender: TObject);
begin
  if pnl_C57Lock.Color = clYellow then
  begin
    pnl_C57Lock.Enabled := True;

    RecSendCannon57.mOrderID := __ORD_CANNON_LOCK;
    SendOrdUnlock;
  end
  else
  begin
    pnl_C57Lock.Color := clLime;
    pnl_C57Lock.Enabled := True;

    RecSendCannon57.mOrderID := __ORD_CANNON_UNLOCK;
    SendOrdUnlock;
  end;
end;

function TfrCtrl57.CheckSelectRate;
begin
  Result := 0;

  if btn_R10.Down then
    Result := 1
  else
  if btn_R30.Down then
    Result := 2
  else
  if btn_R50.Down then
    Result := 3
  else
  if btn_R100.Down then
    Result := 4
end;

function TfrCtrl57.CheckModeFire;
begin
  Result := 0;

  if btn_FireC57.Down then
    Result := 1
  else
  if btn_Salvo57.Down then
    Result := 2
end;

procedure TfrCtrl57.SetDefaultValOrd;
begin
  RecSendCannon57.ShipID           := fMainForm.pShipID;
  RecSendCannon57.mWeaponID        := C_DBID_CANNON40;
  RecSendCannon57.mLauncherID      := 2;
  RecSendCannon57.mMissileID       := 0;
  RecSendCannon57.mMissileNumber   := 0;
  RecSendCannon57.mModeID          := 1;
  RecSendCannon57.mBalistikID      := 1;
end;

procedure TfrCtrl57.PrepareOrdUnlock;
begin
  RecSendCannon57.ShipID := fMainForm.pShipID;

  RecSendCannon57.mLauncherID:= 2;

  RecSendCannon57.mWeaponID := C_DBID_CANNON57;

  case CheckSelectRate of
    1: RecSendCannon57.mBalistikID := 1;
    2: RecSendCannon57.mBalistikID := 2;
    3: RecSendCannon57.mBalistikID := 3;
    4: RecSendCannon57.mBalistikID := 4;
  end;

  case CheckModeFire of
    1: RecSendCannon57.mModeID := 1;
    2: RecSendCannon57.mModeID := 2;
  end;

  RecSendCannon57.mMissileID := 0;
  RecSendCannon57.mMissileNumber:= 0;

end;

procedure TfrCtrl57.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendCannon57.mWeaponID <> 0) and (RecSendCannon57.mOrderID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_SET_CANNON, @RecSendCannon57)
  end;
end;
end.
