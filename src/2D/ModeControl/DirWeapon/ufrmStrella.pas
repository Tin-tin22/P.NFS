unit ufrmStrella;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, VrDigit, VrControls, VrDesign, VrSystem, ImgList,
  uTCPDatatype, uTCPClient, OverbyteIcsWSocket;

type
  TfrmStrella = class(TFrame)
    vrbtmplst1: TVrBitmapList;
    vrbtmplst2: TVrBitmapList;
    Image1: TImage;
    imgUnlock1: TVrBitmapImage;
    imgLeftControl1: TVrBitmapImage;
    imgLeftControl2: TVrBitmapImage;
    imgRightControl1: TVrBitmapImage;
    imgRightControl2: TVrBitmapImage;
    pnl1: TPanel;
    vrdgtgrpVrBearing: TVrDigitGroup;
    lblBearing: TLabel;
    pnl2: TPanel;
    vrdgtgrpElevation: TVrDigitGroup;
    lblRanges: TLabel;
    imgUnlock2: TVrBitmapImage;
    imgUnlock3: TVrBitmapImage;
    imgUnlock4: TVrBitmapImage;
    procedure imgUnlock1Click(Sender: TObject);
    procedure imgUnlock2Click(Sender: TObject);
    procedure imgUnlock3Click(Sender: TObject);
    procedure imgUnlock4Click(Sender: TObject);
  private
    { Private declarations }
    procedure PrepareOrdUnlock;
    procedure SendOrdUnlock;
    function CheckButtonUnlock: Integer;
  public
    { Public declarations }
    pIndex: Integer;
  end;

var
  RecSendStrella: TRec3DSetStrella;

implementation

uses uModeControl;

{$R *.dfm}


function TfrmStrella.CheckButtonUnlock: Integer;
begin
  Result := 0;
  Result := pIndex;
end;

procedure TfrmStrella.imgUnlock1Click(Sender: TObject);
begin
  if (imgLeftControl1.BitmapIndex = 0) and
     (imgUnlock1.BitmapIndex = 0) then
  begin
    imgUnlock1.Enabled := False;
  end
  else
  if imgLeftControl1.BitmapIndex = 1 then
  begin
    imgUnlock1.Enabled := True;
    imgUnlock1.BitmapIndex := 0;

    imgLeftControl1.BitmapIndex := 4;

    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    imgUnlock1.Enabled := True;
    imgUnlock1.BitmapIndex := 1;

    imgLeftControl1.BitmapIndex := 2;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;

  pIndex:=1;
  SendOrdUnlock;
end;

procedure TfrmStrella.imgUnlock2Click(Sender: TObject);
begin
  if (imgLeftControl2.BitmapIndex = 0) and
     (imgUnlock2.BitmapIndex = 0) then
  begin
    imgUnlock2.Enabled := False;
  end
  else
  if imgLeftControl2.BitmapIndex = 1 then
  begin
    imgUnlock2.Enabled := True;
    imgUnlock2.BitmapIndex := 0;

    imgLeftControl2.BitmapIndex := 4;

    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    imgUnlock2.BitmapIndex := 1;
    imgUnlock2.Enabled := True;

    imgLeftControl2.BitmapIndex := 2;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;

  pIndex:=2;
  SendOrdUnlock;
end;

procedure TfrmStrella.imgUnlock3Click(Sender: TObject);
begin
  if (imgRightControl1.BitmapIndex = 0) and
     (imgUnlock3.BitmapIndex = 0) then
  begin
    imgUnlock3.Enabled := False;
  end
  else
  if imgRightControl1.BitmapIndex = 1 then
  begin
    imgUnlock3.Enabled := True;
    imgUnlock3.BitmapIndex := 0;

    imgRightControl1.BitmapIndex := 4;

    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    imgUnlock3.BitmapIndex := 1;
    imgUnlock3.Enabled := True;

    imgRightControl1.BitmapIndex := 2;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;

  pIndex:=3;
  SendOrdUnlock;
end;

procedure TfrmStrella.imgUnlock4Click(Sender: TObject);
begin
  if (imgRightControl2.BitmapIndex = 0) and
     (imgUnlock4.BitmapIndex = 0) then
  begin
    imgUnlock4.Enabled := False;
  end
  else
  if imgRightControl2.BitmapIndex = 1 then
  begin
    imgUnlock4.Enabled := True;
    imgUnlock4.BitmapIndex := 0;

    imgRightControl2.BitmapIndex := 4;

    RecSendStrella.OrderID := __ORD_STRELA_LOCK;
  end
  else
  begin
    imgUnlock4.BitmapIndex := 1;
    imgUnlock4.Enabled := True;

    imgRightControl2.BitmapIndex := 2;

    RecSendStrella.OrderID := __ORD_STRELA_UNLOCK;
  end;

  pIndex:=4;
  SendOrdUnlock;
end;

procedure TfrmStrella.PrepareOrdUnlock;
begin
  RecSendStrella.ShipID  := fMainForm.pShipID;
  RecSendStrella.mLauncherID := fMainForm.pLauncherID;
  RecSendStrella.mWeaponID := C_DBID_STRELA;
  RecSendStrella.mMissileID := CheckButtonUnlock;
  RecSendStrella.mMissileNumber := 1;
end;

procedure TfrmStrella.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendStrella.mLauncherID <> 0) and (RecSendStrella.mMissileID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_CMD_STRELLA, @RecSendStrella)
  end;
end;

end.
