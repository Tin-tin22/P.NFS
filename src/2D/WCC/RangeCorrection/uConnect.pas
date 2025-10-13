unit uConnect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TvConnect = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    eServer: TComboBox;
    procedure eServerChange(Sender: TObject);
    {procedure eShipIDChange(Sender: TObject);}
  private
    mServer: string;
    mIDShip: integer;
    function GetCServer: string;
    procedure SetCServer(NewCServer: string);
    function GetIDShip: integer;
    procedure SetIDShip(NewIDShip: integer);
  public
    property CServer: string read GetCServer write SetCServer;
    property IDShip: integer read GetIDShip write SetIDShip;
    function ShowModalConnect: Integer;
  end;

var
  vConnect: TvConnect;

implementation

{$R *.dfm}

function TvConnect.GetCServer: string;
begin
  Result := mServer;
end;

procedure TvConnect.SetCServer(NewCServer: string);
begin
  mServer := NewCServer;
end;

function TvConnect.GetIDShip: integer;
begin
  Result := mIDShip;
end;

procedure TvConnect.SetIDShip(NewIDShip: integer);
begin
  mIDShip := NewIDShip;
end;

function TvConnect.ShowModalConnect: Integer;
begin
  eServer.Text := CServer;
  //eShipID.Text := IntToStr(IDShip);
  Result := ShowModal;
end;

procedure TvConnect.eServerChange(Sender: TObject);
begin
  if eServer.Text <> '' then
    SetCServer(eServer.Text);
end;

{procedure TvConnect.eShipIDChange(Sender: TObject);
begin
  if eShipID.Text <> '' then
    SetIDShip(StrToInt(eShipID.Text));
end;}

end.
