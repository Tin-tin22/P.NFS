unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  tVect2D = record
    X, Y : double
  end;

  TCanvasCoord = class
  protected

  public
    Offset : TPoint;
    Scale : tVect2D;

    constructor Create;

    function ConvertX(const xMeter: double): integer;
    function ConvertY(const yMeter: double): integer;

    procedure Draw(aCnv: TCanvas);
  public

  end;

  TGunProjectile = class
  protected
    pt: TPoint;
  public
    R,Y : Double;

    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;

  TfrmMain = class(TForm)
    pnlUp: TPanel;
    pnlLeft: TPanel;
    pnlBottom: TPanel;
    scrlbrElevTOF: TScrollBar;
    scrlbrElev: TScrollBar;
    edtElevGun: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtTOF: TEdit;
    ImgGun: TImage;
    edtRange: TEdit;
    edtElevCorrect: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    edtRange2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtElevCorrect2: TEdit;
    procedure scrlbrElevChange(Sender: TObject);
    procedure scrlbrElevTOFChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtRangeKeyPress(Sender: TObject; var Key: Char);
    procedure edtRange2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure DefaultCanvas;
    procedure DefaultProjectile;
  public
    { Public declarations }
    Canvas        : TCanvasCoord;
    GunProjectile : TGunProjectile;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ Function }
procedure Gun120_GetElevByRange(const Range : Double; var Elev : Double);
begin
  Elev := 0;

  if ( Range > 0 ) and ( Range <= 3500 ) then
  begin
    Elev := ( 3 * Power(10, -8.0) * Power(Range, 2.0) ) +
            ( 4.26 * Power(10, -4) * Range) + 0.0074;
  end
  else
  if ( Range > 3500 ) and ( Range <= 7000 ) then
  begin
    Elev := ((0.0006)*Power(((Range/100)-35), 2.0)) +
            ((0.0637)*((Range/100)-35)) + 1.9098;
  end
  else
  if ( Range > 7000 ) and ( Range <= 10500 ) then
  begin
    Elev := ((0.0011)*Power(((Range/100)-75), 2.0)) +
            ((0.1074)*((Range/100)-70)) + 4.9383;
  end
  else
  if ( Range > 10500 ) and ( Range <= 14000 ) then
  begin
    Elev := ((0.0012)*Power(((Range/100)-105), 2.0)) +
            ((0.1836)*((Range/100)-105)) + 10.077;
  end
  else
  if ( Range > 14000 ) and ( Range <= 17500 ) then
  begin
    Elev := ((0.0019)*Power(((Range/100)-140), 2.0)) +
            ((0.292)*((Range/100)-140)) + 17.967;
  end
  else
  if ( Range > 17500 ) and ( Range <= 18350) then
  begin
    Elev := ((0.0022)*Power(((Range/100)-175), 3.0)) +
            ((0.0323)*Power(((Range/100)-175), 2.0)) +
            ((0.6739)*((Range/100)-175)) + 29.865;
  end;
end;

procedure Gun120_GetElevByRange2(const Range : Double; var Elev : Double);
begin
  Elev := 0;

  if ( Range > 0 ) and ( Range <= 3500 ) then
  begin
    Elev := ((0.0003)*Power(((Range/100)), 2.0)) +
            ((0.0426)*((Range/100))) + 0.0074;
  end
  else
  if ( Range > 3500 ) and ( Range <= 7000 ) then
  begin
    Elev := ((0.0006)*Power(((Range/100)), 2.0)) +
            ((0.019)*((Range/100))) + 0.4617;
  end
  else
  if ( Range > 7000 ) and ( Range <= 10500 ) then
  begin
    Elev := ((0.0011)*Power(((Range/100)), 2.0)) -
            ((0.0477)*((Range/100))) + 2.849;
  end
  else
  if ( Range > 10500 ) and ( Range <= 14000 ) then
  begin
    Elev := ((0.1229)*Power(((Range/1000)), 2.0)) -
            ((0.7451)*((Range/1000))) + 4.3499;
  end
  else
  if ( Range > 14000 ) and ( Range <= 17500 ) then
  begin
    Elev := ((0.1246)*Power(((Range/1000)), 2.0)) -
            ((0.4754)*((Range/1000)));
  end
  else
  if ( Range > 17500 ) and ( Range <= 18350) then
  begin
    Elev := ((0.0174)*Power(((Range/100)-175), 2.0)) +
            ((0.3609)*((Range/100)-175)) + 30.323;
  end;
end;

procedure Gun120_GetV0_ByElev(const Elev : Double; var V0x, V0y : Double);
begin
  V0x := 0;
  V0y := 0;

  if (( Elev > 0.05 ) and ( Elev <= 1.9 )) then
  begin
    V0x := (-7.0619*(Power(Elev, 2.0))) + (-40.285*Elev) + 778.26;
    V0y := (-7.0619*(Power(Elev, 2.0))) + (-40.285*Elev) + 778.26;
  end
  else
  if (( Elev > 1.9 ) and ( Elev <= 4.93 )) then
  begin
    V0x := (3.4889*(Power(Elev, 2.0))) + (-60.798*Elev) + 782.56;
    V0y := (0.4951*(Power(Elev, 2.0))) + (-21.937*Elev) + 816.72;
  end
  else
  if (( Elev > 4.93 ) and ( Elev <= 10.06 )) then
  begin
    V0x := (1.651*(Power(Elev, 2.0))) + (-43.559*Elev) + 741.34;
    V0y := (0.2156*(Power(Elev, 2.0))) + (-16.992*Elev) + 799.05;
  end
  else
  if (( Elev > 10.06 ) and ( Elev <= 18.02 )) then
  begin
    V0x := (0.413*(Power(Elev, 2.0))) + (-18.644*Elev) + 614.76;
    V0y := (0.3914*(Power(Elev, 2.0))) + (-20.022*Elev) + 810.97;
  end
  else
  if (( Elev > 18.02 ) and ( Elev <= 30.14 )) then
  begin
    V0x := (0.1289*(Power(Elev, 2.0))) + (-8.7146*Elev) + 527.14;
    V0y := (0.1613*(Power(Elev, 2.0))) + (-11.74*Elev) + 736.15;
  end
  else
  if (( Elev > 30.14 ) and ( Elev <= 40 )) then
  begin
    V0x := (0.0614*(Power(Elev, 2.0))) + (-4.8105*Elev) + 470.38;
    V0y := (0.0761*(Power(Elev, 2.0))) + (-6.8575*Elev) + 661.1;
  end;
end;

{ TCanvasCoord }

function TCanvasCoord.ConvertX(const xMeter: double): integer;
begin
  result := Offset.X + Round (xMeter * Scale.X);
end;

function TCanvasCoord.ConvertY(const yMeter: double): integer;
begin
  result := Offset.Y - Round (yMeter * Scale.Y);
end;

constructor TCanvasCoord.Create;
begin
  Offset.X := 30;
  Offset.Y := 500;
end;

procedure TCanvasCoord.Draw(aCnv: TCanvas);
begin
  aCnv.Pen.Color := RGB(32, 32, 32);

  aCnv.MoveTo(Offset.X - 30,  Offset.Y);
  aCnv.LineTo(Offset.X + 1150, Offset.Y);

  aCnv.MoveTo(Offset.X , Offset.Y - 450);
  aCnv.LineTo(Offset.X , Offset.Y + 30);
end;

{ TGunProjectile }

procedure TGunProjectile.Converts(cc: TCanvasCoord);
begin
  pt.X := cc.ConvertX(R);
  pt.Y := cc.ConvertY(Y);
end;

procedure TGunProjectile.Draw(aCnv: TCanvas);
const
  sz = 3;
var
  rct: TRect;
begin
  rct := Rect(pt.X-sz, pt.Y-sz, pt.X+sz, pt.Y+sz);

  aCnv.Ellipse(rct);
  SetBkMode(aCnv.Handle, TRANSPARENT);
  aCnv.Font.Color := clRed;

  aCnv.TextOut(pt.X + 12, pt.Y -20, 'Height : ' + FormatFloat('00.00', Y));
  aCnv.TextOut(pt.X + 12, pt.Y -30, 'Range : ' + FormatFloat('00.00', R));
end;

procedure TfrmMain.scrlbrElevChange(Sender: TObject);
var
  GunElev : Double;
begin
  GunElev         := (scrlbrElev.Max - scrlbrElev.Position) / 10;
  edtElevGun.Text := FloatToStr(GunElev);

  DefaultProjectile;
end;

procedure TfrmMain.scrlbrElevTOFChange(Sender: TObject);
var
  GunTOF : Double;
  GunElev : Double;

  GunV0X, GunV0Y : Double;
  GunPosX, GunPosY : Double;
begin
  GunElev     := (scrlbrElev.Max - scrlbrElev.Position) / 10;

  if GunElev < 0.05 then
  begin
    scrlbrElevTOF.Position := 0;
    ShowMessage('Elevation Must Larger Than 0.05 Degree');
    Exit;
  end;

  GunTOF      := scrlbrElevTOF.Position / 10;
  edtTOF.Text := FloatToStr(GunTOF);

  Gun120_GetV0_ByElev(GunElev, GunV0X, GunV0Y);
  GunPosX := GunV0X * Cos(DegToRad(GunElev)) * GunTOF;
  GunPosY := (GunV0Y * Sin(DegToRad(GunElev)) * GunTOF) - (5 * GunTOF * GunTOF);

  DefaultCanvas;

  GunProjectile.R := GunPosX;
  GunProjectile.Y := GunPosY;
  GunProjectile.Converts(Canvas);
  GunProjectile.Draw(imgGun.Canvas);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Canvas        := TCanvasCoord.Create;
  GunProjectile := TGunProjectile.Create;

  Canvas.Offset.X := 50;
  Canvas.Scale.X  := 800 / 16000;
  Canvas.Scale.Y  := 800 / 16000;

  GunProjectile.R := 0;
  GunProjectile.Y := 0;
  GunProjectile.Converts(Canvas);

  DefaultCanvas;
  GunProjectile.Draw(imgGun.Canvas);
end;

procedure TfrmMain.DefaultCanvas;
begin
  ImgGun.Canvas.FillRect(ImgGun.Canvas.ClipRect);
  Canvas.Draw(imgGun.Canvas);  
end;

procedure TfrmMain.DefaultProjectile;
begin
  DefaultCanvas;

  GunProjectile.R := 0;
  GunProjectile.Y := 0;
  GunProjectile.Converts(Canvas);
  GunProjectile.Draw(imgGun.Canvas);

  scrlbrElevTOF.Position := 0;
  edtTOF.Text := '0';
end;

procedure TfrmMain.edtRangeKeyPress(Sender: TObject; var Key: Char);
var
  Elev, Range : Double;
begin
  if Key = #13 then
  begin
    Range := StrToFloat(edtRange.Text);

    Gun120_GetElevByRange(Range, Elev);
    edtElevCorrect.Text := FloatToStr(Elev);
  end;
end;

procedure TfrmMain.edtRange2KeyPress(Sender: TObject; var Key: Char);
var
  Elev, Range : Double;
begin
  if Key = #13 then
  begin
    Range := StrToFloat(edtRange2.Text);

    Gun120_GetElevByRange2(Range, Elev);
    edtElevCorrect2.Text := FloatToStr(Elev);
  end;
end;

end.
