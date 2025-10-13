unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, math;

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

    tMaxTime,
    tMaxRange : Double;

    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;

  THeli = class
  protected
    pt: TPoint;
  public
    Offset : TPoint;
    R,Y : Double;

    constructor Create;

    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  end;

  TfrmGun40trj = class(TForm)
    pnlLeft: TPanel;
    pnlUp: TPanel;
    pnlBottom: TPanel;
    scrlbrTOF: TScrollBar;
    scrlbrRange: TScrollBar;
    pnlLeft2: TPanel;
    scrlbrElev: TScrollBar;
    edtElev: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtRange: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtTOF: TEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    edtRangeX: TEdit;
    edtRangeZ: TEdit;
    btnRun: TButton;
    pnlAir: TPanel;
    edtHeliAlt: TEdit;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtHeliRange: TEdit;
    scrlbrHeliAlt: TScrollBar;
    scrlbrHeliRange: TScrollBar;
    lbl12: TLabel;
    lbl13: TLabel;
    btnHeliLock: TButton;
    rgMeriam: TRadioGroup;
    btnHeliLock2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure scrlbrElevChange(Sender: TObject);
    procedure scrlbrRangeChange(Sender: TObject);
    procedure scrlbrTOFChange(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure scrlbrHeliAltChange(Sender: TObject);
    procedure scrlbrHeliRangeChange(Sender: TObject);
    procedure btnHeliLockClick(Sender: TObject);
    procedure rgMeriamClick(Sender: TObject);
    procedure btnHeliLock2Click(Sender: TObject);
  private
    { Private declarations }
    FTimerRun : TTimer;

    procedure OnTimerRun(Sender : TObject);
  public
    { Public declarations }
    CCanvas        : TCanvasCoord;
    GunProjectile  : TGunProjectile;
    HeliActor      : THeli;

    procedure FillTrajectory(const GunElev, MaxTime : Double);
  end;

var
  frmGun40trj: TfrmGun40trj;

implementation

uses Trajec;

{$R *.dfm}

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
  Offset.X := 90;
  Offset.Y := 450;
end;

procedure TCanvasCoord.Draw(aCnv: TCanvas);
begin
  aCnv.Pen.Color := RGB(32, 32, 32);

  aCnv.MoveTo(Offset.X - 30,  Offset.Y);
  aCnv.LineTo(Offset.X + 800, Offset.Y);

  aCnv.MoveTo(Offset.X , Offset.Y - 350);
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

procedure TfrmGun40trj.btnHeliLock2Click(Sender: TObject);
Var
  TargetAlt,
  TargetRange : Double;

  isLock : Boolean;

  GunTimeExpolde : Double;

  sinVOY : Double;
begin
  TargetAlt     := scrlbrHeliAlt.Max - scrlbrHeliAlt.Position;
  TargetRange   := scrlbrHeliRange.Max - scrlbrHeliRange.Position;

  isLock := false;

  case rgMeriam.ItemIndex of
    0 :
    begin
      GunTimeExpolde := Gun40_GetTimeExplode(TargetAlt, TargetRange);

      if GunTimeExpolde > 0 then
        isLock := true;
    end;

    1 :
    begin

    end;
  end;

  if isLock then
    ShowMessage('Target Lock')
  else
    ShowMessage('Cannot Lock Target');

end;

procedure TfrmGun40trj.btnHeliLockClick(Sender: TObject);
var
  GunElev,
  GunTime : double;

  TargetAlt,
  TargetRange : Double;
begin
  TargetAlt     := scrlbrHeliAlt.Max - scrlbrHeliAlt.Position;
  TargetRange   := scrlbrHeliRange.Max - scrlbrHeliRange.Position;

  case rgMeriam.ItemIndex of
    0 :
    begin
      Gun40_LockTargetAir(TargetAlt, TargetRange, GunElev, GunTime);
    end;

    1 :
    begin
      Gun120_LockTargetAir(TargetAlt, TargetRange, GunElev, GunTime);
    end;
  end;

  if GunElev > 0 then
  begin
    ShowMessage('Locked At Elev ' + FloatToStr(GunElev) + ' Time ' + FloatToStr(GunTime)) ;
    scrlbrElev.Position := Round(scrlbrElev.Max - (GunElev*10));
  end
  else
    ShowMessage('Cant Lock Target In Height ' + FloatToStr(TargetAlt) + ' Range ' + FloatToStr(TargetRange));
end;

procedure TfrmGun40trj.btnRunClick(Sender: TObject);
begin
  case TButton(sender).Tag of
    0 :
    begin
      TButton(sender).Caption := 'Stop';
      TButton(sender).Tag     := 1;
      FTimerRun.Enabled       := True;
    end;

    1 :
    begin
      TButton(sender).Caption := 'Run';
      TButton(sender).Tag     := 0;
      FTimerRun.Enabled       := false;
    end;
  end;
end;

procedure TfrmGun40trj.FillTrajectory(const GunElev, MaxTime : Double);
var
  i: Integer;

  TimeGun     : array[0..10] of Double;
  TimePoint   : array[0..10] of TPoint;
  FirstPoint  : TPoint;

  GunV0X, GunV0Y : Double;
  GunPosX, GunPosY : Double;

  CosVOX, sinVOY : Double;
begin
  Repaint;

  for i := 0 to 10 do
  begin
    TimeGun[i]      := (i+1)/11 * MaxTime;
    TimePoint[i].X  := 0;
    TimePoint[i].Y  := 0;
  end;

  for i := 0 to 10 do
  begin
    case rgMeriam.ItemIndex of
      0 :
      begin
        GunV0X := Gun40_GetV0XByElev(GunElev);
        GunV0Y := Gun40_GetV0YByElev(GunElev);
      end;

      1 :
      begin
        GunV0X := Gun120_GetV0XByElev(GunElev);
        GunV0Y := Gun120_GetV0YByElev(GunElev);
      end;
    end;

    CosVOX := Cos(DegToRad(GunElev));
    sinVOY := Sin(DegToRad(GunElev));

    GunPosX := GunV0X * CosVOX * TimeGun[i];
    GunPosY := (GunV0Y * sinVOY * TimeGun[i]) - (5 * TimeGun[i] * TimeGun[i]);

    TimePoint[i].X := CCanvas.ConvertX(GunPosX);
    TimePoint[i].Y := CCanvas.ConvertY(GunPosY);
  end;

  FirstPoint.X := CCanvas.ConvertX(0);
  FirstPoint.Y := CCanvas.ConvertY(0);

  Canvas.MoveTo(FirstPoint.X    , FirstPoint.Y);
  Canvas.LineTo(TimePoint[0].X  , TimePoint[0].Y);

  for i := 0 to 10 do
  begin
    if i+1 <= 10  then
    begin
      Canvas.Pen.Color := RGB(32, 32, 32);
      Canvas.MoveTo(TimePoint[i].X    , TimePoint[i].Y);
      Canvas.LineTo(TimePoint[i+1].X  , TimePoint[i+1].Y);
    end;
  end;
end;

procedure TfrmGun40trj.FormCreate(Sender: TObject);
begin
  CCanvas := TCanvasCoord.Create;

  CCanvas.Scale.X  := 800 / 20000;
  CCanvas.Scale.Y  := 800 / 20000;

  GunProjectile := TGunProjectile.Create;
  GunProjectile.R := 0;
  GunProjectile.Y := 0;

  HeliActor := THeli.Create;
  HeliActor.R := 2000;
  HeliActor.Y := 2000;

  scrlbrHeliAlt.Position    := Round(HeliActor.R);
  scrlbrHeliRange.Position  := Round(HeliActor.Y);

  FTimerRun := TTimer.Create(nil);
  FTimerRun.Interval  := 10;
  FTimerRun.Enabled   := false;
  FTimerRun.OnTimer   := OnTimerRun;
end;

procedure TfrmGun40trj.FormDestroy(Sender: TObject);
begin
  CCanvas.Free;
  GunProjectile.Free;
end;

procedure TfrmGun40trj.FormPaint(Sender: TObject);
begin
  CCanvas.Draw(Canvas);

  GunProjectile.Converts(CCanvas);
  GunProjectile.Draw(Canvas);

  HeliActor.Converts(CCanvas);
  HeliActor.Draw(Canvas);
end;

procedure TfrmGun40trj.OnTimerRun(Sender: TObject);
var
  GunElev : Double;
begin
  GunElev     := (scrlbrElev.Max - scrlbrElev.Position) / 10;

  if GunElev < 0.05 then
  begin
    scrlbrTOF.Position := 0;
    ShowMessage('Elevation Must Larger Than 0.05 Degree');

    FTimerRun.Enabled := false;
    btnRun.Tag := 0;
    btnRun.Caption := 'Run';

    Exit;
  end;

  scrlbrTOF.Position := scrlbrTOF.Position + 1;

  if scrlbrTOF.Position = scrlbrTOF.Max then
  begin
    FTimerRun.Enabled := false;
    btnRun.Tag := 0;
    btnRun.Caption := 'Run';

    GunProjectile.R := 0;
    GunProjectile.Y := 0;

    scrlbrTOF.Position   := 0;
  end;

end;

procedure TfrmGun40trj.rgMeriamClick(Sender: TObject);
begin
  case rgMeriam.ItemIndex of
    0 :
    begin
      scrlbrElev.Max        := 370;
      scrlbrElev.Position   := 370;

      scrlbrRange.Max       := 12200;
      scrlbrRange.Position  := 0;

      GunProjectile.R := 0;
      GunProjectile.Y := 0;
    end;

    1 :
    begin
      scrlbrElev.Max        := 400;
      scrlbrElev.Position   := 400;

      scrlbrRange.Max       := 18800;
      scrlbrRange.Position  := 0;

      GunProjectile.R := 0;
      GunProjectile.Y := 0;
    end;
  end;
end;

procedure TfrmGun40trj.scrlbrElevChange(Sender: TObject);
var
  GunElev : Double;
  MaxTime, MaxRange : Double;
begin
  scrlbrRange.OnChange := nil;

  GunElev         := (scrlbrElev.Max - scrlbrElev.Position) / 10;
  edtElev.Text    := FloatToStr(GunElev);

  case rgMeriam.ItemIndex of
    0 :
    begin
      Gun40_GetFlightTimeAndRangeMaxByElev(GunElev, MaxTime, MaxRange );

      scrlbrRange.Position := Round(MaxRange);
      scrlbrTOF.Position   := 0;
      scrlbrTOF.Max        := Round(MaxTime*10);
      edtRange.Text        := FloatToStr(MaxRange);

      GunProjectile.R := 0;
      GunProjectile.Y := 0;

      GunProjectile.tMaxTime   := MaxTime;
      GunProjectile.tMaxRange  := MaxRange;

      FillTrajectory(GunElev, MaxTime);
    end;

    1 :
    begin
      Gun120_GetFlightTimeAndRangeMaxByElev(GunElev, MaxTime, MaxRange );

      scrlbrRange.Position := Round(MaxRange);
      scrlbrTOF.Position   := 0;
      scrlbrTOF.Max        := Round(MaxTime*10);
      edtRange.Text        := FloatToStr(MaxRange);

      GunProjectile.R := 0;
      GunProjectile.Y := 0;

      GunProjectile.tMaxTime   := MaxTime;
      GunProjectile.tMaxRange  := MaxRange;

      FillTrajectory(GunElev, MaxTime);
    end;
  end;

  scrlbrRange.OnChange := scrlbrRangeChange;
end;

procedure TfrmGun40trj.scrlbrHeliAltChange(Sender: TObject);
var
  HeliAlt : Double;
  GunElev : Double;
begin
  GunElev := (scrlbrElev.Max - scrlbrElev.Position) / 10;

  HeliAlt := (scrlbrHeliAlt.Max - scrlbrHeliAlt.Position);
  edtHeliAlt.Text := FloatToStr(HeliAlt);

  HeliActor.Y := HeliAlt;

  FillTrajectory(GunElev, GunProjectile.tMaxTime);
end;

procedure TfrmGun40trj.scrlbrHeliRangeChange(Sender: TObject);
var
  HeliRange : Double;
  GunElev   : Double;
begin
  GunElev := (scrlbrElev.Max - scrlbrElev.Position) / 10;

  HeliRange := (scrlbrHeliRange.Max - scrlbrHeliRange.Position);
  edtHeliRange.Text := FloatToStr(HeliRange);

  HeliActor.R := HeliRange;

  FillTrajectory(GunElev, GunProjectile.tMaxTime);
end;

procedure TfrmGun40trj.scrlbrRangeChange(Sender: TObject);
var
  GunRange : Double;
  GunElev  : Double;

  MaxTime, MaxRange : Double;
begin
  scrlbrElev.OnChange := nil;

  case rgMeriam.ItemIndex of
    0 :
    begin
      GunRange         := scrlbrRange.Position;
      edtRange.Text    := FloatToStr(GunRange);

      GunElev       := Gun40_GetElevByRange(GunRange);
      edtElev.Text  := FloatToStr(GunElev);

      scrlbrElev.Position := Round(scrlbrElev.Max - (GunElev*10));

      Gun40_GetFlightTimeAndRangeMaxByElev(GunElev, MaxTime, MaxRange );
      GunProjectile.tMaxTime   := MaxTime;
      GunProjectile.tMaxRange  := MaxRange;

      scrlbrTOF.Position   := 0;
      scrlbrTOF.Max        := Round(MaxTime*10);
      edtRange.Text        := FloatToStr(MaxRange);

      GunProjectile.R := 0;
      GunProjectile.Y := 0;

      FillTrajectory(GunElev, MaxTime);
    end;

    1 :
    begin
      GunRange         := scrlbrRange.Position;
      edtRange.Text    := FloatToStr(GunRange);

      GunElev       := Gun120_GetElevByRange(GunRange);
      edtElev.Text  := FloatToStr(GunElev);

      scrlbrElev.Position := Round(scrlbrElev.Max - (GunElev*10));

      Gun120_GetFlightTimeAndRangeMaxByElev(GunElev, MaxTime, MaxRange );
      GunProjectile.tMaxTime   := MaxTime;
      GunProjectile.tMaxRange  := MaxRange;

      scrlbrTOF.Position   := 0;
      scrlbrTOF.Max        := Round(MaxTime*10);
      edtRange.Text        := FloatToStr(MaxRange);

      GunProjectile.R := 0;
      GunProjectile.Y := 0;

      FillTrajectory(GunElev, MaxTime);
    end;
  end;

  scrlbrElev.OnChange := scrlbrElevChange;
end;

procedure TfrmGun40trj.scrlbrTOFChange(Sender: TObject);
var
  GunTOF : Double;
  GunElev : Double;

  GunV0X, GunV0Y : Double;
  GunPosX, GunPosY : Double;

  CosVOX, sinVOY : Double;
begin
  GunElev     := (scrlbrElev.Max - scrlbrElev.Position) / 10;

  if GunElev < 0.05 then
  begin
    scrlbrTOF.Position := 0;
    ShowMessage('Elevation Must Larger Than 0.05 Degree');

    Exit;
  end;

  case rgMeriam.ItemIndex of
    0 :
    begin
      GunTOF      := scrlbrTOF.Position / 10;
      edtTOF.Text := FloatToStr(GunTOF);

      GunV0X := Gun40_GetV0XByElev(GunElev);
      GunV0Y := Gun40_GetV0YByElev(GunElev);

      CosVOX := Cos(DegToRad(GunElev));
      sinVOY := Sin(DegToRad(GunElev));

      GunPosX := GunV0X * CosVOX * GunTOF;
      GunPosY := (GunV0Y * sinVOY * GunTOF) - (5 * GunTOF * GunTOF);

      GunProjectile.R := GunPosX;
      GunProjectile.Y := GunPosY;

      edtRangeX.Text := FloatToStr(GunPosX);
      edtRangeZ.Text := FloatToStr(GunPosY);

      FillTrajectory(GunElev, GunProjectile.tMaxTime);
    end;

    1 :
    begin
      GunTOF      := scrlbrTOF.Position / 10;
      edtTOF.Text := FloatToStr(GunTOF);

      GunV0X := Gun120_GetV0XByElev(GunElev);
      GunV0Y := Gun120_GetV0YByElev(GunElev);

      CosVOX := Cos(DegToRad(GunElev));
      sinVOY := Sin(DegToRad(GunElev));

      GunPosX := GunV0X * CosVOX * GunTOF;
      GunPosY := (GunV0Y * sinVOY * GunTOF) - (5 * GunTOF * GunTOF);

      GunProjectile.R := GunPosX;
      GunProjectile.Y := GunPosY;

      edtRangeX.Text := FloatToStr(GunPosX);
      edtRangeZ.Text := FloatToStr(GunPosY);

      FillTrajectory(GunElev, GunProjectile.tMaxTime);
    end;

  end;

end;

{ THeli }

procedure THeli.Converts(cc: TCanvasCoord);
begin
  pt.X := cc.ConvertX(R);
  pt.Y := cc.ConvertY(Y);
end;

constructor THeli.Create;
begin
  Offset.X := 90;
  Offset.Y := 450;
end;

procedure THeli.Draw(aCnv: TCanvas);
const
  sz = 3;
var
  rct: TRect;
begin
  rct := Rect(pt.X-sz, pt.Y-sz, pt.X+sz, pt.Y+sz);

  aCnv.Ellipse(rct);
  SetBkMode(aCnv.Handle, TRANSPARENT);

  aCnv.Font.Color   := clRed;

  aCnv.TextOut(pt.X + 12, pt.Y -40, 'Heli');
  aCnv.TextOut(pt.X + 12, pt.Y -30, 'Height : ' + FormatFloat('00.00', Y));
  aCnv.TextOut(pt.X + 12, pt.Y -20, 'Range : ' + FormatFloat('00.00', R));

  aCnv.MoveTo(Offset.X - 30,  pt.Y);
  aCnv.LineTo(Offset.X + 800, pt.Y);

  aCnv.MoveTo(pt.X , Offset.Y - 350);
  aCnv.LineTo(pt.X , Offset.Y + 30);

end;

end.
