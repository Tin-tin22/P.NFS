unit uPubProc;

interface

uses uTCPClient, uTCPDatatype, uDetected;

// Anjungan Command                    
{procedure SendFCData(var theClient: TTCPClient; const mShip: String; const OrdID: byte; const FCNum: byte;
  const FCCommand: byte; const Tgt: TManualTrack);
 }
implementation
{
procedure SendFCData(var theClient: TTCPClient; const mShip: String; const OrdID: byte; const FCNum: byte;
  const FCCommand: byte; const Tgt: TManualTrack);
var
  pkg: TRecFireControlOrder;
begin
  with pkg do
  begin
    //ID := C_REC_FIRE_CONTROL;
    ShipID := mShip;

    OrderID := OrdID;
    FC_number := FCNum;
    FC_command := FCCommand;
    TrackUID := Tgt.UniqueID;
    TrackNumber := tgt.TrackNumber;
    Ship_TID := tgt.ShipTrackID;
    X := tgt.PositionX;
    Y := tgt.PositionY;
  end;
  //theClient.sendDataEx(pkg.ID, @pkg);
end;
 }
end.

