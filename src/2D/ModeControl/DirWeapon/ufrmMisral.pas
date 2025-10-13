unit ufrmMisral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrDesign, VrSystem, ImgList, ExtCtrls, StdCtrls, VrDigit,
  uTCPDatatype, uTCPClient, OverbyteIcsWSocket;

type
  TfrmMistral = class(TFrame)
    vrbtmplst1: TVrBitmapList;
    imgLeftControl: TVrBitmapImage;
    imgRightControl: TVrBitmapImage;
    vrbtmplst2: TVrBitmapList;
    imgUnlock1: TVrBitmapImage;
    pnl2: TPanel;
    vrdgtgrpElevasi: TVrDigitGroup;
    lblRanges: TLabel;
    imgUnlock2: TVrBitmapImage;
    pnl1: TPanel;
    vrdgtgrpVrBearing: TVrDigitGroup;
    lblBearing: TLabel;
    Image1: TImage;
    procedure imgUnlock1Click(Sender: TObject);
    procedure imgUnlock2Click(Sender: TObject);

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
  RecSendMistral: TRec3DSetMistral;

implementation

uses uModeControl;

{$R *.dfm}

function TfrmMistral.CheckButtonUnlock: Integer;
begin
  Result := 0;
  Result := pIndex;
end;

procedure TfrmMistral.imgUnlock1Click(Sender: TObject);
begin
  if (imgLeftControl.BitmapIndex = 0) and
     (imgUnlock1.BitmapIndex = 0) then
  begin
    imgUnlock1.Enabled := False;
  end
  else
  if imgLeftControl.BitmapIndex = 1 then
  begin
    imgUnlock1.Enabled := True;
    imgUnlock1.BitmapIndex := 0;

    imgLeftControl.BitmapIndex := 4;

    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    imgUnlock1.Enabled := True;
    imgUnlock1.BitmapIndex := 1;

    imgLeftControl.BitmapIndex := 2;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;

  pIndex:=1;
  SendOrdUnlock;
end;

procedure TfrmMistral.imgUnlock2Click(Sender: TObject);
begin
  if (imgRightControl.BitmapIndex = 0) and
     (imgUnlock2.BitmapIndex = 0) then
  begin
    imgUnlock2.Enabled := False;
  end
  else
  if imgRightControl.BitmapIndex = 1 then
  begin
    imgUnlock2.Enabled := True;
    imgUnlock2.BitmapIndex := 0;

    imgRightControl.BitmapIndex := 4;

    RecSendMistral.OrderID := __ORD_MISTRAL_LOCK;
  end
  else
  begin
    imgUnlock2.Enabled := True;
    imgUnlock2.BitmapIndex := 1;

    imgRightControl.BitmapIndex := 2;

    RecSendMistral.OrderID := __ORD_MISTRAL_UNLOCK;
  end;

  pIndex:=2;
  SendOrdUnlock;
end;

procedure TfrmMistral.PrepareOrdUnlock;
begin
  RecSendMistral.ShipID  := fMainForm.pShipID;
  RecSendMistral.mLauncherID := fMainForm.pLauncherID;
  RecSendMistral.mWeaponID := C_DBID_MISTRAL;
  RecSendMistral.mMissileID := CheckButtonUnlock;
  RecSendMistral.mMissileNumber := 1;
end;

procedure TfrmMistral.SendOrdUnlock;
begin
  PrepareOrdUnlock;

  if fMainForm.TcpClient.State <> wsconnected then Exit;

  if (RecSendMistral.mLauncherID <> 0) and (RecSendMistral.mMissileID <> 0) then
  begin
    fMainForm.TcpClient.sendDataEx(REC_CMD_MISTRAL, @RecSendMistral)
  end;
end;

end.
