unit uSpecialLamp;

interface
uses
  VrBlinkled, ExtCtrls;
type
  TSpecialLamp = class
  private
    FValue: string;
    function getValue(): string;
    procedure setValue(value: string);
  public
    Action: boolean;
    constructor create;
    procedure setBlinking(ob: TVrBlinkled; colour: string; value: boolean);
    property Value: string read getValue write setValue;
  end;
implementation
uses
  uShoot, Graphics;

constructor TSpecialLamp.create;
begin
end;

function TSpecialLamp.getValue(): string;
begin
  Result := Fvalue;
end;

procedure TSpecialLamp.setValue(value: string);
begin
  Fvalue := value;
  Action := True;
end;

procedure TSpecialLamp.setBlinking(ob: TVrBlinkled; colour: string; Value: boolean);
begin
  if (colour = 'Red') then
  begin
    if (value) then
    begin
      Ob.Palette1.High := clMaroon;
      Ob.Palette1.Low := clRed;
    end
    else
    begin
      Ob.Palette1.High := clMaroon;
      Ob.Palette1.Low := clMaroon;
    end;
  end
  else
    if (colour = 'Yellow') then
  begin
    if (value) then
    begin
      Ob.Palette1.High := clOlive;
      Ob.Palette1.Low := clYellow;
    end
    else
    begin
      Ob.Palette1.High := clOlive;
      Ob.Palette1.Low := clOlive;
    end;
  end
  else
    if (colour = 'Green') then
  begin
    if (value) then
    begin
      Ob.Palette1.High := clGreen;
      Ob.Palette1.Low := clLime;
    end
    else
    begin
      Ob.Palette1.High := clGreen;
      Ob.Palette1.Low := clGreen;
    end;
  end;
end;

end.
