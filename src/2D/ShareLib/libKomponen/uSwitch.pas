unit uSwitch;

interface
uses
  uSpecialLamp;
type
  TSwitch = class
  private
    Swc1: boolean;
    Swc2: boolean;
    Swc3: boolean;
    Swc4: boolean;
    //FLamp : boolean;
    FValue: integer;

    function getValue(): integer;
    procedure setValue(value: integer);

    function getSwc1(): boolean;
    procedure setSwc1(value: boolean);

    function getSwc2(): boolean;
    procedure setSwc2(value: boolean);

    function getSwc3(): boolean;
    procedure setSwc3(value: boolean);

    function getSwc4(): boolean;
    procedure setSwc4(value: boolean);

    //  function getLamp():boolean;
    //  procedure setLamp(value : boolean);
  public
    Lamp: TSpecialLamp;
    constructor create;
    property Val: integer read getValue write setValue;
    property switch1: boolean read getSwc1 write setSwc1;
    property switch2: boolean read getSwc2 write setSwc2;
    property switch3: boolean read getSwc3 write setSwc3;
    property switch4: boolean read getSwc4 write setSwc4;
  end;
implementation
uses uShoot;

constructor TSwitch.create;
begin
  Swc1 := False;
  Swc2 := False;
  Swc3 := False;
  Swc4 := False;
  Lamp := TSpecialLamp.create;
  FValue := 1;
end;

function TSwitch.getSwc1(): boolean;
begin
  if (Shoot.Power.Action) then
    Result := Swc1
  else
    Result := False;
end;

procedure TSwitch.setSwc1(value: boolean);
begin
  Swc1 := value;
end;

function TSwitch.getSwc2(): boolean;
begin
  if (Shoot.Power.Action) then
    Result := Swc2
  else
    Result := False;
end;

procedure TSwitch.setSwc2(value: boolean);
begin
  Swc2 := value;
end;

function TSwitch.getSwc3(): boolean;
begin
  if (Shoot.Power.Action) then
    Result := Swc3
  else
    Result := False;
end;

procedure TSwitch.setSwc3(value: boolean);
begin
  Swc3 := value;
end;

function TSwitch.getSwc4(): boolean;
begin
  if (Shoot.Power.Action) then
    Result := Swc4
  else
    Result := False;
end;

procedure TSwitch.setSwc4(value: boolean);
begin
  Swc4 := value;
end;

{function TSwitch.getLamp():boolean;
begin
  Result := FLamp;
end;

procedure TSwitch.setLamp(value : boolean);
begin
  FLamp := value;
end;
}

function TSwitch.getValue(): integer;
begin
  if (switch1) then
  begin
    FValue := 1;
  end
  else
    if (switch2) then
  begin
    FValue := 2;
  end
  else
    if (switch3) then
  begin
    FValue := 3;
  end
  else
    if (switch4) then
  begin
    FValue := 4;
  end;
  Result := FValue;
end;

procedure TSwitch.setValue(value: integer);
begin
  FValue := value;
end;

end.
