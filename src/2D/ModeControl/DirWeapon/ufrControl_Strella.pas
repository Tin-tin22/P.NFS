unit ufrControl_Strella;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, uTCPDatatype, uTCPClient, OverbyteIcsWSocket;

type
  TfrCtrlStrella = class(TFrame)
    pnl_Launcher1: TPanel;
    pnl_Launcher2: TPanel;
    pnl_Left1: TPanel;
    pnl_Left2: TPanel;
    pnl_Left3: TPanel;
    pnl_Left4: TPanel;
    pnl_Right1: TPanel;
    pnl_Right2: TPanel;
    pnl_Right3: TPanel;
    pnl_Right4: TPanel;

    procedure pnl_Left1Click(Sender: TObject);
    procedure pnl_Left2Click(Sender: TObject);
    procedure pnl_Left3Click(Sender: TObject);
    procedure pnl_Left4Click(Sender: TObject);
    procedure pnl_Right1Click(Sender: TObject);
    procedure pnl_Right2Click(Sender: TObject);
    procedure pnl_Right3Click(Sender: TObject);
    procedure pnl_Right4Click(Sender: TObject);
    procedure PrepareOrdUnlock;
    procedure SendOrdUnlock;
    private
    { Private declarations }
    function CheckPanelClick: Integer;
  public
    { Public declarations }
    pIndex,
    pLauncherID,
    pMissileID : Integer;
  end;
var
  RecSendStrella: TRec3DSetStrella;

implementation

uses uModeControl;

{$R *.dfm}

procedure TfrCtrlStrella.pnl_Left1Click(Sender: TObject);
begin
  if pnl_Left1.Color = clGray then
  begin
    pnl_Left1.Enabled := False
  end
  else
  if pnl_Left1.Color = clYellow then
  begin
    pnl_Left1.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Left1.Color := clLime;
    pnl_Left1.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=1;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Left2Click(Sender: TObject);
begin
  if pnl_Left2.Color = clGray then
  begin
    pnl_Left2.Enabled := False
  end
  else
  if pnl_Left2.Color = clYellow then
  begin
    pnl_Left2.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Left2.Color := clLime;
    pnl_Left2.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=2;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Left3Click(Sender: TObject);
begin
  if pnl_Left3.Color = clGray then
  begin
    pnl_Left3.Enabled := False
  end
  else
  if pnl_Left3.Color = clYellow then
  begin
    pnl_Left3.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Left3.Color := clLime;
    pnl_Left3.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=3;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Left4Click(Sender: TObject);
begin
  if pnl_Left4.Color = clGray then
  begin
    pnl_Left4.Enabled := False
  end
  else
  if pnl_Left4.Color = clYellow then
  begin
    pnl_Left4.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Left4.Color := clLime;
    pnl_Left4.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=4;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Right1Click(Sender: TObject);
begin
  if pnl_Right1.Color = clGray then
  begin
    pnl_Right1.Enabled := False
  end
  else
  if pnl_Right1.Color = clYellow then
  begin
    pnl_Right1.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Right1.Color := clLime;
    pnl_Right1.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=5;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Right2Click(Sender: TObject);
begin
  if pnl_Right2.Color = clGray then
  begin
    pnl_Right2.Enabled := False
  end
  else
  if pnl_Right2.Color = clYellow then
  begin
    pnl_Right2.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Right2.Color := clLime;
    pnl_Right2.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=6;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Right3Click(Sender: TObject);
begin
  if pnl_Right3.Color = clGray then
  begin
    pnl_Right3.Enabled := False
  end
  else
  if pnl_Right3.Color = clYellow then
  begin
    pnl_Right3.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Right3.Color := clLime;
    pnl_Right3.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=7;
  SendOrdUnlock;
end;

procedure TfrCtrlStrella.pnl_Right4Click(Sender: TObject);
begin
  if pnl_Right4.Color = clGray then
  begin
    pnl_Right4.Enabled := False
  end
  else
  if pnl_Right4.Color = clYellow then
  begin
    pnl_Right4.Enabled := True;
    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    pnl_Right4.Color := clLime;
    pnl_Right4.Enabled := True;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;
  pIndex:=8;
  SendOrdUnlock;
end;

function TfrCtrlStrella.CheckPanelClick: Integer;
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
    Result := 4
  else
  if pIndex = 5 then
    Result := 5
  else
  if pIndex = 6 then
    Result := 6
  else
  if pIndex = 7 then
    Result := 7
  else
  if pIndex = 8 then
    Result := 8;

end;

procedure TfrCtrlStrella.PrepareOrdUnlock;
begin
  RecSendStrella.ShipID  := fMainForm.pShipID;

  RecSendStrella.mWeaponID := C_DBID_STRELA;

  case CheckPanelClick of
    1,2,3,4:
    begin
      RecSendStrella.mLauncherID := 1;
      pLauncherID := 1;
    end;
    5,6,7,8:
    begin
      RecSendStrella.mLauncherID := 2;
      pLauncherID := 2;
    end;
  end;

  case CheckPanelClick of
    1,5 : pMissileID := 1;
    2,6 : pMissileID := 2;
    3,7 : pMissileID := 3;
    4,8 : pMissileID := 4;
  end;

  RecSendStrella.mMissileID := pMissileID;
  RecSendStrella.mMissileNumber := 1;

end;

procedure TfrCtrlStrella.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendStrella.mLauncherID <> 0) and (RecSendStrella.mMissileID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_CMD_STRELLA, @RecSendStrella)
  end;
end;

end.
