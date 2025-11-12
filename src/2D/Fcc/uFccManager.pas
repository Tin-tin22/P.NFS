unit uFccManager;

interface
uses
  Forms,
  Graphics,
  Classes, Sysutils,
  windows, uSimulationManager, uTCPDatatype, uBaseSimulationObject, uLibClientObject,
  uBridgeSet, uTestShip, uBaseFunction;

type
  TFCCManager = class(TSimulationManager)
  private
    FIsStandAlone: boolean;
    FxShip       : TXShip;
    FIsTrueMotion: boolean;
  protected
    procedure  EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
    procedure  EventonRecMissilePosAvailable(apRec: PAnsiChar; aSize: integer);
    procedure  EventonReceiveSplashPoint(apRec: PAnsiChar; aSize: integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure InitializeSimulation;     override;

    property IsStandAlone:boolean read FIsStandAlone write FIsStandAlone;
    property IsTrueMotion: boolean read FIsTrueMotion write FIsTrueMotion;
    property xShip : TXShip read FxShip;
  end;

var
  FCCManager : TFCCManager;

implementation

{ TFCCManager }

constructor TFCCManager.Create;
begin
  inherited;
  FIsStandAlone := False;
  FIsTrueMotion := False;
end;

destructor TFCCManager.Destroy;
begin

  inherited;
end;

procedure TFCCManager.EventOnReceiveDataPosition(apRec: PAnsiChar;
  aSize: integer);
var  sc  : TSimulationClass;
     obj : TClientObject;
     aRec: ^TRecData3DPosition;

     TestHeading : Double;
begin
  aRec := @apRec^;

  aRec.X := aRec.X;
  aRec.Y := aRec.Y;
  AddToMemoLog(' _pos: ' + dbID_to_UniqueID(aRec.ShipID) + ' ' + Format('%2.6f, %2.6f',[aRec.X, aRec.Y]));

  if aRec.ShipID = UniqueID_To_dbID(FxShip.UniqueID) then begin
      FxShip.PositionX := aRec.X;
      FxShip.PositionY := aRec.Y;
      FxShip.PositionZ := aRec.Z;

      FxShip.Speed    := aRec.speed;
      FxShip.Heading  := aRec.heading;
  end
  else begin
    sc := MainObjList.FindObjectByUid(dbID_to_UniqueID(aRec.ShipID));

    if sc = nil then begin
     obj := TClientObject.Create;
     obj.UniqueID := dbID_to_UniqueID(aRec.ShipID);
     obj.Enabled := TRUE;

     MainObjList.AddObject(obj);
    end
    else
     obj := sc as TClientObject;

    obj.PositionX := aRec.X;
    obj.PositionY := aRec.Y;
    obj.PositionZ := aRec.Z;
    obj.Speed     := aRec.speed;

    obj.Heading  := ConvCompass_To_Cartesian(aRec.heading);
  end;
end;

procedure TFCCManager.EventonReceiveSplashPoint(apRec: PAnsiChar;
  aSize: integer);
begin

end;

procedure TFCCManager.EventonRecMissilePosAvailable(apRec: PAnsiChar;
  aSize: integer);
begin

end;

procedure TFCCManager.InitializeSimulation;
begin
  inherited;
    NetComm.RegisterProcedure(
      REC_3D_POSITION, EventonReceiveDataPosition, SizeOf(TRecData3DPosition));

  FxShip       := TXShip.Create;
  FxShip.PositionX := 112.75;
  FxShip.PositionY := -7.2;
  FxShip.Heading := 0;
  FxShip.CreateDefaultView(Fmap);
end;

end.
