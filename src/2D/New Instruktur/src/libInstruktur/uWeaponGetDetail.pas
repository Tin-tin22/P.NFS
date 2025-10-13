unit uWeaponGetDetail;

interface

uses
  Classes;

{SPS115}
function getSPS_TIU_Stat(const Id : integer): string;
function getSPS_Gyro_Stat(const Id : integer): string;
function getSPS_Barrel_Stat(const Id : integer): string;

implementation

{SPS115}
function getSPS_TIU_Stat(const Id : integer): string;
begin
  case id of
    0 : Result := 'Normal';
    1 : Result := 'Faulty';
    2 : Result := 'Low Voltage';
    3 : Result := 'No Link';
  end;
end;

function getSPS_Gyro_Stat(const Id : integer): string;
begin
  case id of
    1 : result := 'Normal';
    2 : result := 'Too Long Gyro Caging Time';
    3 : result := 'Gyro Starting Overload';
    4 : result := 'Too Long Gyro Starting';
    5 : result := 'No Link With TIU';
  end;
end;

function getSPS_Barrel_Stat(const Id : integer): string;
begin
  case id of
    1 : result := 'Normal';
    2 : result := 'Untimely Starting Time';
    3 : result := 'Barrel No Longer Ready';
    4 : result := 'Absence Of Gyro';
    5 : result := 'Error Writing Torpedo';
    6 : result := 'Exercise Head Not Start';
    7 : Result := 'Torpedo Not Leave Barrel In Fire';
  end;
end;

end.
