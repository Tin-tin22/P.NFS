unit ufrControl_Mistral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, uTCPDatatype, uTCPClient, OverbyteIcsWSocket;

type
  TfrCtrlMistral = class(TFrame)
    pnl_Left1: TPanel;
    pnl_Left2: TPanel;
    pnl_Launcher1: TPanel;
    pnl_Right1: TPanel;
    pnl_Right2: TPanel;
    pnl_Launcher2: TPanel;
    procedure pnl_Left1Click(Sender: TObject);
    procedure pnl_Left2Click(Sender: TObject);
    procedure pnl_Right1Click(Sender: TObject);
    procedure pnl_Right2Click(Sender: TObject);
    procedure PrepareOrdUnlock;
    procedure SendOrdUnlock;
  private
    { Private declarations }
    function CheckPanelClick: Integer;
  public
    { Public declarations }
    pIndex,
    pLauncherID,
    pMissileID: Integer;
  end;

var
  RecSendMistral: TRec3DSetMistral;

implementation

uses uModeControl;

{$R *.dfm}

procedure TfrCtrlMistral.pnl_Left1Click(Sender: TObject);
begin
  if pnl_Left1.Color = clGray then
  begin
    pnl_Left1.Enabled := False
  end
  else
  if pnl_Left1.Color = clYellow then
  begin
    pnl_Left1.Enabled := True;
    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    pnl_Left1.Color := clLime;
    pnl_Left1.Enabled := True;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;
  pIndex :=1;
  SendOrdUnlock
end;

procedure TfrCtrlMistral.pnl_Left2Click(Sender: TObject);
begin
  if pnl_Left2.Color = clGray then
  begin
    pnl_Left2.Enabled := False
  end
  else
  if pnl_Left2.Color = clYellow then
  begin
    pnl_Left2.Enabled := True;
    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    pnl_Left2.Color := clLime;
    pnl_Left2.Enabled := True;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;
  pIndex :=2;
  SendOrdUnlock;
end;

procedure TfrCtrlMistral.pnl_Right1Click(Sender: TObject);
begin
  if pnl_Right1.Color = clGray then
  begin
    pnl_Right1.Enabled := False
  end
  else
  if pnl_Right1.Color = clYellow then
  begin
    pnl_Right1.Enabled := True;
    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    pnl_Right1.Color := clLime;
    pnl_Right1.Enabled := True;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;
  pIndex :=3;
  SendOrdUnlock;
end;

procedure TfrCtrlMistral.pnl_Right2Click(Sender: TObject);
begin
  if pnl_Right2.Color = clGray then
  begin
    pnl_Right2.Enabled := False
  end
  else
  if pnl_Right2.Color = clYellow then
  begin
    pnl_Right2.Enabled := True;
    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    pnl_Right2.Color := clLime;
    pnl_Right2.Enabled := True;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;
  pIndex :=4;
  SendOrdUnlock;
end;

function TfrCtrlMistral.CheckPanelClick: Integer;
begin
  Result := 0;

  if pIndex = 1 then
    Result := 1
  else
  if pIndex = 2 then
    Result := 2
  else
  if pIndex = 3 then
    Result := 3
  else
  if pIndex = 4 then
    Result := 4;

end;

procedure TfrCtrlMistral.PrepareOrdUnlock;
begin
  RecSendMistral.ShipID  := fMainForm.pShipID;

  RecSendMistral.mWeaponID := C_DBID_MISTRAL;

  case CheckPanelClick of
    1,2,5,6:
    begin
      RecSendMistral.mLauncherID := 1;
      pLauncherID := 1;
    end;
    3,4,7,8:
    begin
      RecSendMistral.mLauncherID := 2;
      pLauncherID := 2;
    end;
  end;

  case CheckPanelClick of
    1,3,5,7 : pMissileID := 1;
    2,4,6,8 : pMissileID := 2;
  end;

  RecSendMistral.mMissileID := pMissileID;
  RecSendMistral.mMissileNumber := 1;

end;

procedure TfrCtrlMistral.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendMistral.mLauncherID <> 0) and (RecSendMistral.mMissileID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_CMD_MISTRAL, @RecSendMistral)
  end;
end;

end.
