unit uAScopeDisplay;

interface

uses Classes, Windows, Controls, Graphics, uBaseGraphicProc, uBaseGraphicObjects,
  uLabelDisplay, uBaseDataType, SysUtils, Menus,
  uBScopeBaseDisplay;

type
  TAScopeDisplay = class(TBScopeBaseDisplay)
  private
  protected
    //procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GambarGaris(aCnv: TCanvas; const aWidth,
      aHeight: integer;const color:TColor;const bkColor:TColor);
  end;

implementation

{ TAScopeDisplay }
//==============================================================================

constructor TAScopeDisplay.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TAScopeDisplay.Destroy;
begin
  inherited;
end;
                         {
procedure TAScopeDisplay.Paint;
begin
  inherited;
end;                      }

procedure TAScopeDisplay.GambarGaris(aCnv: TCanvas; const aWidth,
  aHeight: integer;const color:TColor;const bkColor:TColor);
//Draw lines on foreground;
//assign DrawLines property or override this proc to customize
var
  step,i : integer;
begin
  //draw lines
  with aCnv do begin
    Pen.Color := color;
    Pen.Style := psSolid;

    //garis tengah
    {step := round(aWidth/2);
    Pen.Width := 1;
    MoveTo(step, 0);
    LineTo(step, aHeight); }

    step := round(aHeight/3);
    for i := 1 to 2 do begin
      MoveTo(0,i*step);
      LineTo(aWidth,i*step);
    end;
  end;
end;

end.
