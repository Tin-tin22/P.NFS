unit ufrControl_C40;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, Buttons, StdCtrls, uTCPDataType, uTCPClient,
  OverbyteIcsWSocket;

type
  TfrCtrl40 = class(TFrame)
    btn_FireC40: TSpeedButton;
    pnl_C40Lock: TPanel;
    btn_R10: TSpeedButton;
    btn_R50: TSpeedButton;
    btn_R30: TSpeedButton;
    btn_R100: TSpeedButton;
    btn_Salvo40: TSpeedButton;
    procedure pnl_C40LockClick(Sender: TObject);
    procedure btn_FireC40Click(Sender: TObject);
    procedure btn_R10Click(Sender: TObject);
    procedure SetDefaultValOrd;
    procedure PrepareOrdUnlock;
    procedure SendOrdUnlock;
  private
    { Private declarations }
    function CheckSelectedRate: Integer;
    function CheckModeFire: Integer;
  public
    { Public declarations }
    pMissileID : Integer;
  end;

var
  RecSendCanon40: TRec3DSetWCC;

implementation

uses uModeControl;

{$R *.dfm}

procedure TfrCtrl40.btn_FireC40Click(Sender: TObject);
begin
  CheckModeFire;
end;

procedure TfrCtrl40.pnl_C40LockClick(Sender: TObject);
begin
  if pnl_C40Lock.Color = clYellow then
  begin
    pnl_C40Lock.Enabled := True;

    RecSendCanon40.mOrderID := __ORD_CANNON_LOCK;
    SendOrdUnlock;
  end
  else
  begin
    pnl_C40Lock.Color := clLime;
    pnl_C40Lock.Enabled := True;

    RecSendCanon40.mOrderID := __ORD_CANNON_UNLOCK;
    SendOrdUnlock;
  end;

end;

function TfrCtrl40.CheckSelectedRate:Integer;
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

procedure TfrCtrl40.btn_R10Click(Sender: TObject);
begin
  CheckSelectedRate;
end;

function TfrCtrl40.CheckModeFire: Integer;
begin
  Result := 0;

  if btn_FireC40.Down then
    Result := 1
  else
  if btn_Salvo40.Down then
    Result := 2
end;

procedure TfrCtrl40.SetDefaultValOrd;
begin
  RecSendCanon40.ShipID           := fMainForm.pShipID;
  RecSendCanon40.mWeaponID        := C_DBID_CANNON40;
  RecSendCanon40.mLauncherID      := 2;
  RecSendCanon40.mMissileID       := 0;
  RecSendCanon40.mMissileNumber   := 0;
  RecSendCanon40.mModeID          := 1;
  RecSendCanon40.mBalistikID      := 1;
end;

procedure TfrCtrl40.PrepareOrdUnlock;
begin
  RecSendCanon40.ShipID  := fMainForm.pShipID;;

  RecSendCanon40.mLauncherID  := 2;

  RecSendCanon40.mWeaponID := C_DBID_CANNON40;

  case CheckSelectedRate of
    1: RecSendCanon40.mBalistikID := 1;
    2: RecSendCanon40.mBalistikID := 2;
    3: RecSendCanon40.mBalistikID := 3;
    4: RecSendCanon40.mBalistikID := 4;
  end;

  case CheckModeFire of
    1: RecSendCanon40.mModeID := 1;
    2: RecSendCanon40.mModeID := 2;
  end;

  RecSendCanon40.mMissileID := 0;
  RecSendCanon40.mMissileNumber := 0;

end;

procedure TfrCtrl40.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendCanon40.mWeaponID <> 0) and (RecSendCanon40.mOrderID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_SET_CANNON, @RecSendCanon40)
  end;
end;

end.
