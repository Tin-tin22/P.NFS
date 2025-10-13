unit uEmulatorProc;

interface

uses
  uEmulatorConstan, Graphics, uBaseGraphicProc;

  function GetBearingIndex(const SlotBearingList :TSlotBearingList;const bearing: Single): integer;
  function GetColorFromEchoLevel(const EchoLevel: double):TColor;

implementation

function GetBearingIndex(const SlotBearingList :TSlotBearingList; const bearing: Single): integer;
var
  i : integer;
begin
  for i := 0 to C_Sonar_Bearing_Slot_Number-1 do begin
    if i = C_Sonar_Bearing_Slot_Number-1 then begin //check last bearing and first
      if SlotBearingList[i] > SlotBearingList[0] then begin
        if (bearing > SlotBearingList[i]) or (bearing <= SlotBearingList[0]) then
          Result := i;
      end
      else begin
        if (bearing > SlotBearingList[i]) and (bearing <= SlotBearingList[0]) then
          Result := i;
      end;
    end
    else begin //other
      if SlotBearingList[i] > SlotBearingList[i+1] then begin
        if (bearing > SlotBearingList[i]) or (bearing <= SlotBearingList[i+1]) then
          Result := i;
      end
      else begin
        if (bearing > SlotBearingList[i]) and (bearing <= SlotBearingList[i+1]) then
          Result := i;
      end;
    end;
  end;
end;

function GetColorFromEchoLevel(const EchoLevel: double):TColor;
var
  color : TColor;
begin
  color := C_EchoColor;
  DarkColor(color,round(255-EchoLevel));
  Result := color;
end;

end.
