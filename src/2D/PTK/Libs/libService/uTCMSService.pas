unit uTCMSService;

interface

uses
  Classes, Forms, uBaseService,
    uServiceDefinition;

type
// FonUpdate = procedure (id : integer) of object;


//------------------------------------------------------------------------------
  TTCMS_Service = class (TBaseService)
  protected
    FOnUpdate : TNotifyEvent;
    FFormList : TList;
    FMainForm : TForm;

    procedure AfterConstruction; override;
  public
    constructor Create (const aSVCID: integer);
    destructor Destroy; override;

    procedure Hide; virtual;


  public
    DisplayPosition : TRecServicePosition;

    procedure UpdateVisibleForm; virtual;

    property MainForm: TForm read FMainForm;

    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
    { Form Event For MainForm each service }
    procedure OnMainFormEvent(aValue : Boolean);

  end;

  TClassTCMS_Service = class of TTCMS_Service;

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------


implementation

uses
  uFrmBaseTCMS;

{ TTCMS_Service }

procedure TTCMS_Service.AfterConstruction;
var
  idx : Integer;
begin
  inherited AfterConstruction;

  idx := V_SVC_DEF_INDEX[FServiceID];

  (FMainForm as TfrmBaseTCMS).SetServiceIndex(idx);
  (FMainForm as TfrmBaseTCMS).OnMainFormEvent := OnMainFormEvent;
end;

constructor TTCMS_Service.Create(const aSVCID: integer);
begin
  inherited Create;

  FFormList := TList.Create;

  FServiceName := C_SVC_Name[aSVCID];
  FServiceID   := aSVCID;



end;

destructor TTCMS_Service.Destroy;
var i: integer;
    f: TForm;
begin
  for i := FFormList.Count - 1 downto 0 do begin
    f := FFormList[i];
    FFormList.Delete(i);
    f.Free;
  end;

  FFormList.Clear;
  FFormList.Free;

  inherited;
end;

procedure TTCMS_Service.Hide;
var i: integer;
    f: TForm;
begin
  for i := FFormList.Count - 1 downto 0 do begin
    f := FFormList[i];
    if Assigned(f) then
      f.Visible := False;
  end;
end;

procedure TTCMS_Service.OnMainFormEvent(aValue: Boolean);
var
  i : integer;
begin
  if aValue then
  begin
    for i := 0 to FFormList.Count - 1 do
    begin
      if TfrmBaseTCMS(FFormList.Items[i]).isHaveOpened then
        TfrmBaseTCMS(FFormList.Items[i]).Show;
    end;
  end
  else
  begin
    for i := 0 to FFormList.Count - 1 do
    begin
      if TfrmBaseTCMS(FFormList.Items[i]).isHaveOpened then
        TfrmBaseTCMS(FFormList.Items[i]).isHaveOpened := false;

      if TfrmBaseTCMS(FFormList.Items[i]).isHaveOpened then
        TfrmBaseTCMS(FFormList.Items[i]).Show;

      if TfrmBaseTCMS(FFormList.Items[i]).Showing then
        TfrmBaseTCMS(FFormList.Items[i]).isHaveOpened := true;
    end;

    for i := 0 to FFormList.Count - 1 do
    begin
      if TfrmBaseTCMS(FFormList.Items[i]) = TfrmBaseTCMS(FMainForm) then
        Continue;

      TfrmBaseTCMS(FFormList.Items[i]).Close;

    end;
  end;
end;

procedure TTCMS_Service.UpdateVisibleForm;
var i: integer;
    f: TfrmBaseTCMS;
begin
  if FRunning then
    for i := FFormList.Count - 1 downto 0 do begin
      f := FFormList[i];
      if assigned(f) then
        if f.Visible then
         f.OnServiceUpdate(self);
    end;
end;

end.
