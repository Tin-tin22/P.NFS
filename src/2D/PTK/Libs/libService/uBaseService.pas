unit uBaseService;

interface

uses
  Classes;

type

  TBaseService = class
  protected
    FServiceID   : Word;
    FServiceName : string;

    FRunning      : boolean;
  public

    constructor Create;
    destructor Destroy; override;

  public
    property ServiceID: Word read FServiceID;
    property ServiceName : string read FServiceName;

    property Running: boolean read FRunning;

  end;


implementation

{ TBaseService }

constructor TBaseService.Create;
begin
  inherited;

  FServiceName := 'BaseService';
  FServiceID   := 0;
  // Service Name harus di override diturunannya.
  FRunning      := true;

end;

destructor TBaseService.Destroy;
begin

  inherited;
end;

end.
