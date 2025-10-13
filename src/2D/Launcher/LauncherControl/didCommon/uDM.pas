unit uDM;

interface

uses
  Forms, Dialogs, SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZConnection;

type
  TDM = class(TDataModule)
    DQ: TZQuery;
    DS: TZQuery;
    EmuConn: TZConnection;
  private
    { Private declarations }
  public
    function GetShipType(const shipid: integer; var shipName: string): integer;
    function GetShipCallsign(const shipid: integer): string;
    function GetShipName(const shipid: integer): string;
    function SetDBConnection(mDBServer, mDBProto, mDBName, mDBUser, mDBPass: string): boolean;
    function GetShipNameByID(ID: integer): string;
    function GetShipIDByName( ShipName : string ): integer ;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

function TDM.GetShipType(const shipid: integer; var shipName: string): integer;
begin
  with DQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add(' t.ship_class_id, t.ship_class_name ');
    SQL.Add('FROM ');
    SQL.Add(' m_ship s , m_ship_class t ');
    SQL.Add('WHERE ');
    SQL.Add('(s.ship_class_id = t.ship_class_id) and ');
    ;
    SQL.Add('(ship_id = ' + IntToStr(shipid) + ')');
    Open;
    First;
  end;

  if DQ.RecordCount > 0 then
  begin
    result := DQ.Fields[0].AsInteger;
    shipName := DQ.Fields[1].AsString;
  end
  else
    Result := -1;

end;

function TDM.GetShipIDByName( ShipName : string ): integer ;
begin
  with DQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add(' ship_id  ');
    SQL.Add('FROM ');
    SQL.Add(' m_ship ');
    SQL.Add('WHERE ');
    SQL.Add('(ship_name = ' + QuotedStr(ShipName) + ')');
    Open;
    First;
  end;

  if DQ.RecordCount > 0 then
  begin
    result := DQ.Fields[0].AsInteger;
  end
  else
    Result := 0;

end;

function TDM.GetShipCallsign(const shipid: integer): string;
begin
  with DQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add(' SHIP_CALLSIGN  ');
    SQL.Add('FROM ');
    SQL.Add(' m_ship ');
    SQL.Add('WHERE ');
    SQL.Add('(ship_id = ' + IntToStr(shipid) + ')');

    Open;
    First;
  end;

  if DQ.RecordCount > 0 then
  begin
    result := DQ.Fields[0].AsString;
  end
  else
    Result := '';

end;

function TDM.GetShipName(const shipid: integer): string;
begin
  with DQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add(' ship_name  ');
    SQL.Add('FROM ');
    SQL.Add(' m_ship ');
    SQL.Add('WHERE ');
    SQL.Add('(ship_id = ' + IntToStr(shipid) + ')');

    Open;
    First;
  end;

  if DQ.RecordCount > 0 then
  begin
    result := DQ.Fields[0].AsString;
  end
  else
    Result := '';

end;

function TDM.SetDBConnection(mDBServer, mDBProto, mDBName, mDBUser, mDBPass : string): boolean;
begin

  EmuConn.HostName :=  mDBServer;
  EmuConn.Protocol := mDBProto;
  EmuConn.Database := mDBName;
  EmuConn.User := mDBUser;
  EmuConn.Password := mDBPass ;

  try
    EmuConn.Connect;
    Result :=  EmuConn.Connected;
  except
    on Exception do
    begin
      MessageDlg('Error Database Connection on ' + mDBServer, mtError, [mbOK], 0);
      Result := false;
      exit;
    end
  end;
end;

function TDM.GetShipNameByID(ID: integer): string;
begin
  DQ.Close;
  DQ.SQL.Clear;
  DQ.SQL.Add('SELECT  A.SID,A.SNAME');
  DQ.SQL.Add('FROM v_ship_data A');
  DQ.SQL.Add('WHERE A.SID =:SID');
  DQ.ParamByName('SID').AsInteger := ID;
  DQ.Open;
  Result := DQ.FieldByName('SNAME').AsString;
  DQ.Close;
end;

end.

