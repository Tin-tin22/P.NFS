unit uQuery;

interface

uses SysUtils;

const
  APP_2D = 0;
  APP_3D_Server = 1;
  APP_3D_Client = 2;

type
  tDataApplication = record
    c_id: integer;
    c_ip: string;
    c_id_console: integer;
    c_name: string;
    c_app_tipe: byte;
    c_app_name: string;
    c_app_type: integer;
    c_app_type_name: string;
    c_app_params: string;
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
    Result.c_id := DQ.Fields[0].AsInteger;
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
      c_id := DQ.FieldByName('PC_ID').AsInteger;
      c_ip := ip ;
      c_name := DQ.FieldByName('PC_NAME').AsString;
      c_app_tipe := DQ.FieldByName('APP_TIPE').AsInteger;
      c_id_console := DQ.FieldByName('PC_IDM').AsInteger;
      c_app_name := DQ.FieldByName('APP_NAME').AsString;
      c_app_params := DQ.FieldByName('APP_PARAMS').AsString;
      case c_app_tipe of
        APP_2D: c_app_type_name := '2D';
        APP_3D_Server: c_app_type_name := '3D-S';
        APP_3D_Client: c_app_type_name := '3D-C';
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

end.

