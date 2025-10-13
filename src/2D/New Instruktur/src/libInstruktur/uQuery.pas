unit uQuery;

interface

uses SysUtils;

const
  APP_2D = 0;
  APP_3D_Server = 1;
  APP_3D_Client = 2;
  APP_3D_Weapon = 3;

type
  tDataApplication = record
    c_id_console: integer;
    c_id_cubicle : integer;  /// id cubicle
    c_ip: string;
    c_name: string;
    c_app_tipe: byte;
    c_app_name: string;
    c_app_type: integer;
    c_app_type_name: string;
    c_app_params: string;
    c_mac:string;
    c_app_name_2 : string;
  end;

function GetCubicleNameFromID(const id: integer ): string;
function GetPCConfigFromPC_ID(const pc_id: integer): tDataApplication;
function GetPCConfigFromIPAddress(const ip: string): tDataApplication;
function GetShipAssignedFromIDScenarioAndIDConsole(const idScenario, idConseole: integer): integer;
function GetPCNameFromIPAddress(const ip: string): string;
function GetPCIDFromIPAddress(const ip: string): string;
function GetIPAddressFromPCID(const ip: string): string;
function GetPCIDAndPCNameFromIPAddress(const ip: string): tDataApplication;
function GetShipNoLambungFromID(const id: integer): string;
function GetShipNameFromID(const id: integer): string;
function GetShipSHIP_3D_TYPE(const id: integer): integer;
function GetShipClassNameFromID(const id: integer): string;
function GetWeaponNameFromWeaponID(const id: integer): string;
function GetSceneNameFromID(const id: integer): string;
function GetSceneIDFromName(const s: string): integer;


function GetNewID(const tbl, fie: string): integer;
function GetFontIDFromIndex( val: integer) : integer;

function IsSubmarinesCategory (const catid: integer ): boolean;
function IsSubmarinesCategoryFromShipID (const ShipID: integer ): boolean;
function IsSubmarinesCategoryVarCatName (const catid: integer ; var CatName : string ): boolean;

procedure HapusDetail(const tbl, fie: string; val: integer);

function CheckObjectCatDomain(const shipID: integer ): integer;
function CheckObjectCatDomainByCatID(const CatID: integer ): integer;

procedure SetSceneOffSetFromID(const id: integer; var x, y: double);
procedure GetSceneOffSetFromPortID(const id: integer; var x, y: double);

function IsFindScenarioID (const id : integer): boolean;



implementation



uses uDataModule, DB;

const
  CAT_SUBMARINES = 'SUBMARINE';
  CAT_HELICOPTER = 'HELICOPTER';
  CAT_AIRCRAFT   = 'AIRCRAFT';

function IsFindScenarioID (const id : integer): boolean;
begin
  Result := False;
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ID from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    if not DQ.IsEmpty then
    Result := true ;
    DQ.Close;
  end;
end;

procedure GetSceneOffSetFromPortID(const id: integer; var x, y: double);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select XOFFSET,YOFFSET from env_port where ID=' + IntToStr(id));
    DQ.Open;
    x := DQ.FieldByName('XOFFSET').AsFloat;
    y := DQ.FieldByName('YOFFSET').AsFloat;
    DQ.Close;
  end;
end;


procedure SetSceneOffSetFromID(const id: integer; var x, y: double);
var
  IDPORT : integer ;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ENV_PETA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    IDPORT := DQ.Fields[0].AsInteger ;
    DQ.Close;
    GetSceneOffSetFromPortID(IDPORT,x,y);
  end;
end;

function GetSceneIDFromName(const s: string): integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select ID from sce_main where NAMA=' + QuotedStr(s));
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

function GetShipNoLambungFromID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_NO from m_ship where SHIP_ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetShipSHIP_3D_TYPE(const id: integer): integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select SHIP_3D_TYPE from m_ship where SHIP_ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsInteger;
    DQ.Close;
  end;
end;

function GetShipClassNameFromID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select B.SHIP_CLASS_NAME from m_ship A, m_ship_class B where B.SHIP_CLASS_ID=A.SHIP_CLASS_ID and A.SHIP_ID =' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetWeaponNameFromWeaponID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select NAMA from m_weapon where ID=' + IntToStr(id));
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

function GetCubicleNameFromID(const id: integer ): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select NAMA from cm_cubicle where ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetPCConfigFromPC_ID(const pc_id: integer): tDataApplication;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select * from cm_console where PC_ID=' + IntToStr(pc_id));
    DQ.Open;
    with Result do begin
      c_id_console := DQ.FieldByName('PC_ID').AsInteger;
      c_id_cubicle := DQ.FieldByName('PC_IDM').AsInteger;
      c_ip         := DQ.FieldByName('PC_IP').AsString;
      c_name       := DQ.FieldByName('PC_NAME').AsString;
      c_app_tipe   := DQ.FieldByName('APP_TIPE').AsInteger;
      c_app_name   := DQ.FieldByName('APP_NAME').AsString;
      c_app_params := DQ.FieldByName('APP_PARAMS').AsString;
      c_mac        := DQ.FieldByName('PC_MAC').AsString;
      c_app_name_2   := DQ.FieldByName('APP_NAME_2').AsString;
      case c_app_tipe of
        APP_2D: c_app_type_name := '2D';
        APP_3D_Server: c_app_type_name := '3D-S';
        APP_3D_Client: c_app_type_name := '3D-C';
      end;
    end;
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
      c_id_cubicle := DQ.FieldByName('PC_IDM').AsInteger;
      c_ip := ip;
      c_name := DQ.FieldByName('PC_NAME').AsString;
      c_app_tipe := DQ.FieldByName('APP_TIPE').AsInteger;
      c_app_name := DQ.FieldByName('APP_NAME').AsString;
      c_app_params := DQ.FieldByName('APP_PARAMS').AsString;
      c_mac := DQ.FieldByName('PC_MAC').AsString;
      c_app_name_2 := DQ.FieldByName('APP_NAME_2').AsString;
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
var
  pc_id: integer;
  spc_id: string;
begin
  if TryStrToInt(ip, pc_id) then begin
    spc_id := IntToStr(pc_id);
    with DataModule1 do begin
      DQ.SQL.Clear;
      DQ.SQL.Add('select PC_IP from cm_console where PC_ID=' + QuotedStr(spc_id));
      DQ.Open;
      Result := DQ.Fields[0].AsString;
      DQ.Close;
    end;
  end
  else
    Result := '0';
end;

function GetFontIDFromIndex( val: integer) : integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('SELECT FONT_ID FROM font_taktis where  FONT_INDEX=' + IntToStr(val));
    DQ.Open;
    Result := DQ.Fields[0].AsInteger;
    DQ.Close;
  end;
end;

function GetNewID(const tbl, fie: string): integer;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select MAX(' + fie + ') from ' + tbl);
    DQ.Open;
    if DQ.Fields[0].AsInteger <= 0 then
      Result := 1
    else
      Result := DQ.Fields[0].AsInteger + 1;
    DQ.Close;
  end;
end;

function IsSubmarinesCategory (const catid: integer ): boolean;
begin
   Result := false ;
   if DataModule1.GetShipCategoryName(catid) =  CAT_SUBMARINES then
      Result := true;
end;

function CheckObjectCatDomainByCatID(const CatID: integer ): integer;
begin
  if DataModule1.GetShipCategoryName(catid) =  CAT_SUBMARINES then
    Result := 2
  else
  if DataModule1.GetShipCategoryName(catid) = CAT_HELICOPTER then
    Result := 3
  else
  if DataModule1.GetShipCategoryName(catid) = CAT_AIRCRAFT then
    Result := 4
  else
    Result := 1;
end;

function CheckObjectCatDomain(const shipID: integer ): integer;
var
   catid : integer ;
begin
  catid  := DataModule1.GetShipCategoryID(shipID);

  if DataModule1.GetShipCategoryName(catid) =  CAT_SUBMARINES then
    Result := 2
  else
  if DataModule1.GetShipCategoryName(catid) = CAT_HELICOPTER then
    Result := 3
  else
  if DataModule1.GetShipCategoryName(catid) = CAT_AIRCRAFT then
    Result := 4
  else
    Result := 1;
end;

function IsSubmarinesCategoryFromShipID (const ShipID: integer ): boolean;
var
   catid : integer ;
begin
   catid  := DataModule1.GetShipCategoryID(shipID);
   Result := IsSubmarinesCategory ( catid ) ;
end;


function IsSubmarinesCategoryVarCatName (const catid: integer ; var CatName : string ): boolean;
begin
   Result := false ;
   CatName := DataModule1.GetShipCategoryName(catid);
   if CatName =  CAT_SUBMARINES then
      Result := true;
end;


procedure HapusDetail(const tbl, fie: string; val: integer);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('delete from ' + tbl + ' where ' + fie + '=' + IntToStr(val));
    DQ.ExecSQL;
  end;
end;

procedure UpdateScenarioShipList(const tbl, fie: string; val: integer);
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('delete from ' + tbl + ' where ' + fie + '=' + IntToStr(val));
    DQ.ExecSQL;
  end;
end;

end.



