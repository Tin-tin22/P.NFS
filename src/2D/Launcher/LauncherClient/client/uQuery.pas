unit uQuery;

interface

uses SysUtils;

const
  APP_2D = 0;
  APP_3D_Server   = 1;
  APP_3D_Client   = 2;
  APP_3D_weapon   = 3;

type
  tDataApplication = record
    c_id_console: integer;
    c_ip: string;
    c_id_cubicle: integer;
    c_name: string;
    c_app_tipe: byte;
    c_app_name: string;
    c_app_type: integer;
    c_app_type_name: string;
    c_app_params: string;
    c_app_name_2 : string;
  end;

function GetPCNameFromIPAddress(const ip: string): string;
function GetPCIDFromIPAddress(const ip: string): string;
function GetIPAddressFromPCID(const ip: string): string;
function GetPCIDAndPCNameFromIPAddress(const ip: string): tDataApplication;
function GetShipNameFromID(const id: integer): string;
function GetPCConfigFromIPAddress(const ip: string): tDataApplication;
function GetShipAssignedFromIDScenarioAndIDConsole(const idScenario, idConseole: integer): integer;
function GetSceneNameFromID(const id: integer): string;
function GetShip3DType(const id: integer): integer;
function GetShipControlType(const id: integer): string;
procedure GetShipIDFromSceIDAndConsoleID(const SceID, ConsoleID : integer;
                                         var ShipID : Integer;
                                         var Found : Boolean);
procedure GetShip_LauncherIDFromSceIDAndConsoleID(const SceID, ConsoleID : integer;
                                                  var ShipID : Integer;
                                                  var launcherID : Integer;
                                                  var Found : Boolean);

procedure GetShip_LauncherIDFromSceIDAndConsoleID_Runtime(const SceID, ConsoleID : integer;
                                                  var ShipID : Integer;
                                                  var launcherID : Integer;
                                                  var Found : Boolean);

procedure CheckLauncherExistAndHeadingFromShipWeapon(const ShipID, WeaponID, LauncherID : integer ;
                                            var HeadingLauncher : integer ;
                                            var isExist : boolean);                                                  

implementation

uses uDataModule, DB;

function GetShipControlType(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_CTRL_TYPE from m_ship where SHIP_ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetShip3DType(const id: integer): integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_3D_TYPE from m_ship where SHIP_ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsInteger;
    DQ.Close;
  end;
end;

function GetSceneNameFromID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select NAMA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetShipNameFromID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_NAME from m_ship where SHIP_ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetPCIDAndPCNameFromIPAddress(const ip: string): tDataApplication;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select PC_ID,PC_NAME from cm_console where PC_IP=' + QuotedStr(ip));
    DQ.Open;
    Result.c_id_console := DQ.Fields[0].AsInteger;
    Result.c_name := DQ.Fields[1].AsString;
    DQ.Close;
  end;
end;

function GetPCConfigFromIPAddress(const ip: string): tDataApplication;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select * from cm_console where PC_IP=' + QuotedStr(ip));
    DQ.Open;
    with Result do begin
      c_id_console := DQ.FieldByName('PC_ID').AsInteger;
      c_ip := ip ;
      c_name := DQ.FieldByName('PC_NAME').AsString;
      c_app_tipe := DQ.FieldByName('APP_TIPE').AsInteger;
      c_id_cubicle := DQ.FieldByName('PC_IDM').AsInteger;
      c_app_name := DQ.FieldByName('APP_NAME').AsString;
      c_app_params := DQ.FieldByName('APP_PARAMS').AsString;
      c_app_name_2 := DQ.FieldByName('APP_NAME_2').AsString;
      case c_app_tipe of
        APP_2D: c_app_type_name := '2D';
        APP_3D_Server: c_app_type_name := '3D-S';
        APP_3D_Client: c_app_type_name := '3D-C';
        APP_3D_weapon: c_app_type_name := '3D-W';
      end;
    end;
    DQ.Close;
  end;
end;

function GetShipAssignedFromIDScenarioAndIDConsole(const idScenario, idConseole: integer): integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select IDSHIP from sce_ship where IDM=' + IntToStr(idScenario) + ' and IDCONSOLES=' + IntToStr(idConseole));
    DQ.Open;
    Result := DQ.Fields[0].AsInteger;
    DQ.Close;
  end;
end;

procedure GetShip_LauncherIDFromSceIDAndConsoleID_Runtime(const SceID, ConsoleID : integer;
                                                  var ShipID : Integer;
                                                  var launcherID : Integer;
                                                  var Found : Boolean);
begin
  Found := false;

  with DataModule1 do
  begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select IDSHIP, IDLAUNCHER from sce_ship where IDM=' + IntToStr(SceID) + ' and IDCONSOLES=' + IntToStr(ConsoleID));

    DQ.Open;
    DQ.First;
  end;

  if not DataModule1.DQ.IsEmpty then
  begin
    Found := True;

    while not DataModule1.DQ.Eof do
    begin
      ShipID      := DataModule1.DQ.FieldByName('IDSHIP').AsInteger;
      launcherID  := DataModule1.DQ.FieldByName('IDLAUNCHER').AsInteger;
      DataModule1.DQ.Next;
    end;
  end
  else
  begin
    Found := False;
  end;
end;

procedure GetShip_LauncherIDFromSceIDAndConsoleID(const SceID, ConsoleID : integer;
                                                  var ShipID : Integer;
                                                  var launcherID : Integer;
                                                  var Found : Boolean);
begin
  Found := false;

  with DataModule1 do
  begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_ID, SHIP_LAUNCHER from sce_console where IDM=' + IntToStr(SceID) + ' and SHIP_CONSOLE=' + IntToStr(ConsoleID));

    DQ.Open;
    DQ.First;
  end;

  if not DataModule1.DQ.IsEmpty then
  begin
    Found := True;

    while not DataModule1.DQ.Eof do
    begin
      ShipID      := DataModule1.DQ.FieldByName('SHIP_ID').AsInteger;
      launcherID  := DataModule1.DQ.FieldByName('SHIP_LAUNCHER').AsInteger;
      DataModule1.DQ.Next;
    end;
  end
  else
  begin
    Found := False;
  end;
end;

procedure GetShipIDFromSceIDAndConsoleID(const SceID, ConsoleID : integer; var ShipID : Integer; var Found : Boolean);
begin
  Found := false;

  with DataModule1 do
  begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_ID from sce_console where IDM=' + IntToStr(SceID) + ' and SHIP_CONSOLE=' + IntToStr(ConsoleID));

    DQ.Open;
    DQ.First;
  end;

  if not DataModule1.DQ.IsEmpty then
  begin
    Found := True;

    while not DataModule1.DQ.Eof do
    begin
      ShipID    := DataModule1.DQ.FieldByName('SHIP_ID').AsInteger;
      DataModule1.DQ.Next;
    end;
  end
  else
  begin
    Found := False;
  end;
end;

function GetPCNameFromIPAddress(const ip: string): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select PC_NAME from cm_console where PC_IP=' + QuotedStr(ip));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetPCIDFromIPAddress(const ip: string): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select PC_ID from cm_console where PC_IP=' + QuotedStr(ip));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetIPAddressFromPCID(const ip: string): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select PC_IP from cm_console where PC_ID=' + QuotedStr(ip));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

procedure CheckLauncherExistAndHeadingFromShipWeapon(const ShipID, WeaponID, LauncherID : integer ;
                                            var HeadingLauncher : integer ;
                                            var isExist : boolean);
begin
  HeadingLauncher := 0;
  isExist := False;

  with DataModule1 do
  begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select POS_H from m_ship_weapon where IDSHIP=' + IntToStr(ShipID) + ' and IDWEAPON=' + IntToStr(WeaponID) + ' and IDDET=' + IntToStr(LauncherID));

    DQ.Open;
    DQ.First;
  end;

  if not DataModule1.DQ.IsEmpty then
  begin
    isExist := True;

    while not DataModule1.DQ.Eof do
    begin
      HeadingLauncher    := DataModule1.DQ.FieldByName('POS_H').AsInteger;
      DataModule1.DQ.Next;
    end;
  end
  else
  begin
    isExist := False;
  end;
end;

end.

