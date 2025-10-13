unit ufGunCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uCanvasCoord ;


type
 {  TGunProjectile
   1. Shoot :
      - setting timeAX (time conter) = 0;
      - setting x = 0; y =0;
 }
  TElevationMode = (emInvalid, emLow, emHigh);

  TGunProjectileCalc = class
  private
    FE0: double;
    procedure setElevMode(const Value: TElevationMode);
  protected
    FElevMode : TElevationMode;   //low or high

    pt: TPoint; // Range from Time
    FOnStop: TNotifyEvent;
    PR, PZ: double;

    function high_TimeToRange(const t: double ): double;

    procedure MoveLow(dt: double); //second;
    procedure MoveHigh(dt: double);

  public
    //constraint
    timeMax   : double; // time of flight;
    heightMax : double; // titik tertinggi;
    rangeMax  : double;

    //running param
    TimeAX  : double;

    //position
    R       : double;    //jarak dari rumus.
    //height calculation
    Z        : double;
    Running : boolean;

    // new calc method
    V0 : double;  // Kecepatan awal
    P  : double;  // pitch, sudut actual
    Vt, //linear speed;
    Vr, Vz : double;
    text : string;

    constructor Create;

    procedure Move(dt: double);

    function searchHighAngle(const tx, ty: double):double;
    function searchLowAngle(const tx, ty: double):double;

    procedure Converts(cc: TCanvasCoord);
    procedure Draw(aCnv: TCanvas);
  public
    property OnStop  : TNotifyEvent read FOnStop write FOnStop;

    property ElevMode: TElevationMode read FElevMode write setElevMode;
    property E0 : double read FE0;

    function SetElevation(const aElev: double): boolean;
    //proeprty RangeMax
//    function high_RangeToTime(const r: double ): double;

  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edElev: TEdit;
    btnRun: TButton;
    Label2: TLabel;
    edMaxRange: TEdit;
    edTOF: TEdit;
    Label5: TLabel;
    scBarElevLOW: TScrollBar;
    scBarTime: TScrollBar;
    Timer1: TTimer;
    edTertinggi: TEdit;
    Label7: TLabel;
    scBarMax: TScrollBar;
    scMarkRange: TScrollBar;
    scBarHIGH: TScrollBar;
    rgElev: TRadioGroup;
    Panel2: TPanel;
    LBLtiME: TLabel;
    lblRange: TLabel;
    lblMarkX: TLabel;
    Panel3: TPanel;
    lblHi: TLabel;
    lblLo: TLabel;
    scMarkHeight: TScrollBar;
    Panel4: TPanel;
    Button2: TButton;
    Memo1: TMemo;
    btnLockLo: TButton;
    Panel6: TPanel;
    Memo2: TMemo;
    lblMarkTime_low: TLabel;
    lblMarkTime_hi: TLabel;
    lblMarkY: TLabel;
    procedure btnRunClick(Sender: TObject);
    procedure scBarElevLOWChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure scBarTimeChange(Sender: TObject);
    procedure scBarMaxChange(Sender: TObject);
    procedure scMarkHeightChange(Sender: TObject);
    procedure scMarkRangeChange(Sender: TObject);
    procedure scBarHIGHChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnLockLoClick(Sender: TObject);
  private
    { Private declarations }
    FPerfFreq,
    FLastPerfCount : Int64;

  public
    { Public declarations }
    cc : TCanvasCoord;
    gp : TGunProjectileCalc;

    mk,
    tmk : TPointMarker;
    emk : TElevMarker;
    trj : TPointTrajectory;

    procedure gpOnStop(Sender: TObject);

    procedure FillTrajectory;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  Math;

//----------------------------------------------------------------------------
//01;
//(ok) elevation to max range:
function low_ElevToMaxRange(const xElev: double): double;
//input : degree
//output: meter
begin
//y = -0.043037695x4 + 3.584767811x3 - 107.4852179x2 + 1644.802547x + 561.263347
//R² = 0.99711045
   result := -0.043037695 * Power(xElev, 4.0)
             +3.584767811 * Power(xElev, 3.0)
             -107.4852179 * Power(xElev, 2.0)
             +1644.802547 * xElev
             +561.26334;
end;

//(ok) setting high:
function high_ElevToMaxRange(const e: double): double;
var x: Double;
begin
//x = sin (2a)
//y = -2.665269695x2 + 19.1354017x - 0.046825845
//R² = 0.999894749

  x := Sin(2* DegToRad(e));
  result :=  ( -2.665269695* sqr(x) + 19.1354017*x - 0.046825845);
  result := 1000 * Result;
end;

//----------------------------------------------------------------------------

function low_elevToMaxHeight(const e: double): double;
begin
//y = 0.001036599x4 - 0.107590687x3 + 5.244975761x2 + 20.25173288x - 15.4167862
//R² = 0.999976312

  result :=   0.001036599 * Power(e, 4.0)
            - 0.107590687 * Power(e, 3.0)
            + 5.244975761 * Power(e, 2.0)
            + 20.25173288 * e
            - 15.4167862;
  if result < 0 then
    result := 0;
end;

function high_elevToMaxHeight(const e: double): double;
var x: Double;
begin
//x= sin(a)
//y = 2.947601528x2 + 13.72305254x - 5.486492431
//R² = 0.999946205

  x := Sin(DegToRad(e));
  result :=  (2.947601528 * sqr(x) + 13.72305254*x - 5.486492431);
  result := 1000 * Result;
//ok
end;

//----------------------------------------------------------------------------
function low_rangeToMaxTime(const x: double): double;
//rangeToTime  //rangeToTOF
//input : meter
//output: detik
var r: double;
begin
//y = 0.00107063x4 - 0.028098132x3 + 0.386844803x2 + 0.294670735x + 0.314859117
//R² = 0.999753695

  r := 0.001 * x;
  result :=   0.00107063  * Power(r, 4.0)
            - 0.028098132 * Power(r, 3.0)
            + 0.386844803 * Power(r, 2.0)
            + 0.294670735 * r
            + 0.314859117;
end;


//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
function low_MaxRangeToElev(const x: double): double;
var r: double;
begin
{ r := x * 0.001
  y = 0.000640365x4 - 0.011721821x3 + 0.17811014x2 - 0.071564918x + 0.178761297
  R² = 0.999527894
}
  r := 0.001 * x;
  result :=   0.000640365 * Power(r, 4.0)
            - 0.011721821 * Power(r, 3.0)
            + 0.17811014  * Power(r, 2.0)
            - 0.071564918 * r;
//            + 0.178761297;
end;


//interpolation:
function timeToHeight(const t: double; const maxT, maxHeight: double): double;
var a : double;
    x : double;
begin
  result := 0;
  if maxT <=0  then exit;
//y =  a ( x – x1 ) ( x – x2 )

  x := 0.5 * maxT;
  a := maxHeight / ((x - 0) * (x - maxT));
  result := a * (t - 0) * (t - maxT);
end;



function high_MaxRangeToElev(const r: double): double;
var x, y: Double;
begin
// y = 0.000842593x2 + 0.044424219x + 0.04294116
// R² = 0.99989464

//y = sin (2a) -> jangan lupa kalo ini sudut > 45;
  x := 0.001 *r;
  y :=  ( 0.000842593* sqr(x) + 0.044424219*x + 0.04294116);
  if y < 0.0 then
    y := 0.0;

  if y > 1.0 then
    y := 1.0;

  result := (RadToDeg(ArcSin(y))/2);
  if result < 45 then
    result := 90 - result;

end;


function high_elevToMaxTime(const e: double): double;
begin
//y = -0.010709204x2 + 2.143751228x - 8.319353207
//R² = 0.999838654

  result :=  ( -0.010709204* sqr(e) + 2.143751228*e - 8.319353207);

//ok
end;


function new_TimeToRange(const t: double): double;
// dipakai oleh low dan high
var x: double;
begin
//y = -0.02907127x3 + 0.383275697x2 + 0.861348954x - 0.129575272
//R² = 0.999573187
  result := 0;

  if t <=0  then
    exit;

  x := sqrt(t);
  result := - 0.02907127 * Power(x,3)
            + 0.383275697 * Sqr(x)
            + 0.861348954 * x
            - 0.129575272;

  result :=  1000.0 * Result;

end;


function new_rangeToTime(const r: double): double;
var x: double;
begin
//  y = 0.000633297x3 - 0.015931548x2 + 0.534878524x + 0.565785555
//  R² = 0.99976804
  x := 0.001 * r;

  result :=   0.000633297 * Power(x,3)
            - 0.015931548 * Sqr(x)
            + 0.534878524 * x
            + 0.565785555;
  result := sqr(result);

end;


function high_rangeToTime(const r: double): double;
// berlaku untuk max time. tidak berlaku untuk running time.
var x, y: double;
begin
  //y = -0.028601502x2 + 0.630486822x + 5.911782749
  //R² = 0.997905009
//y = -2.8601501872351300E-02x2 + 6.3048682162565600E-01x + 5.9117827493119300E+00
//R² = 9.9790500914331900E-01

  x := 0.001 * r;
  y := - 0.02860150187235132 * sqr(x)
       + 0.630486821625656 * x
       + 5.91178274931193;
  result := sqr(y);
end;

//function tes_heightToTime(const h, hMax, tMax: double; var t1, t2: double): boolean;
function tes_heightToTime(const h, hMax, tMax: double): double;
var  //g, t, v0, v02, vt, vt2: double;
    t, a, dh, dt, dt2: double;
begin
{ versi gerak vetikal ke atas:
  t := tMax/2;
  g := (2 * hMax) / (t*t);
  v0 := sqrt(2*g*hMax);
  vt := sqrt(sqr(v0) -2*g*h);
  result := (v0-vt)/g;
}
{ persamaan kuadrat:
  a  nya di hitung dari persamaan lengkap.
  trus parabolanya dipotong.
  tapi yg dicari inversenya, bukan f(t) nya.
}
//  result := false;
  result := 0;
  if (tMax <= 0) or (tMax > 120) then
   exit;

  t   := tMax/2;
  a   := hMax / sqr(t);
  dh  := hMax - h;

{  if abs(a) < 0.00000001 then
   exit;}

   dt2 := abs(dh / a);

   if dt2 < 0.0000000001 then
     exit;
  dt := sqrt(dt2);

  //akarnya ada dua,
  //t1 := t - dt;
  //t2 := t + dt;
  //result := true;
  // untuk anti air diasumsikan pake t1
  // untuk NGS mungkin pake t2

  result := t - dt;
end;

{ TGunProjectile }
constructor TGunProjectileCalc.Create;
begin
  V0 := 868.6728886;
  R       := 0;
  TimeAX  := 0;

  PR      := 0;
  PZ      := 0;
  ElevMode := emLow;
end;


function TGunProjectileCalc.SetElevation(const aElev: double): boolean;
begin

  FE0 := aElev;

  // hitung jarak maksimum dari elevasi;
  case FElevMode of
    emLow: begin
      RangeMax  := low_ElevToMaxRange(FE0);
      HeightMax := low_elevToMaxHeight(FE0);
      TimeMax   := low_rangeToMaxTime(rangeMax);

    end;
    emHigh :begin
      RangeMax  := high_elevToMaxRange(FE0);
      HeightMax := high_elevToMaxHeight(FE0);
      TimeMax   := high_elevToMaxTime(FE0);
    end;
  end;

end;

procedure TGunProjectileCalc.setElevMode(const Value: TElevationMode);
begin
  FElevMode := Value;
  //set procs
end;

function TGunProjectileCalc.high_TimeToRange(const t: double ): double;
var dt: double;
    lowTimeeMax: double;
begin
  result := 0;

  if rangeMax = 0.0 then
    exit;

  lowTimeeMax := low_rangeToMaxTime(rangeMax);

  dt := lowtimeeMax * t /timeMax;
  result := new_TimeToRange(dt);

end;

{function TGunProjectile.high_RangeToTime(const r: double ): double;
var tmp, loRange: double;
    lowTimeMax: double;

begin
  tmp := new_rangeToTime(r); //

  lowTimeMax := new_rangeToTime(rangeMax);
//  timeMax
  result :=  tmp * timeMax / lowTimeMax;

end;
}

procedure TGunProjectileCalc.MoveHigh(dt: double);
begin
  TimeAX  := TimeAX + dt;

  Z := timeToHeight(TimeAX, timeMax, heightMax);
  R := high_TimeToRange(TimeAX);

end;

procedure TGunProjectileCalc.MoveLow(dt: double);
begin
  TimeAX  := TimeAX + dt;

  R := new_timeToRange(TimeAX);
  Z := timeToHeight(TimeAX, timeMax, heightMax);

end;

procedure TGunProjectileCalc.Move(dt: double);
var dx, dy: double;
begin
  PR := R;
  PZ := Z;

  if FElevMode = emLow then
    MoveLow(dt)
  else
    MoveHigh(dt);

  dx := R - PR;
  dy := Z - PZ;

  P := RadTodeg( ArcTan2(dy, dx));    // pitch

  if dt > 0 then begin
    Vt := sqrt(dx*dx+dy*dy) / dt;
    Vr := dx / dt;
    Vz := dy / dt;
  end;

  Running := (TimeAX <= timeMax) and (Z >=0);

  if not Running then
    if Assigned(FOnStop) then
      FOnStop(self);

end;


procedure TGunProjectileCalc.Converts(cc: TCanvasCoord);
begin
  pt.X := cc.ConvertX(R);
  pt.Y := cc.ConvertY(Z);

end;

procedure TGunProjectileCalc.Draw(aCnv: TCanvas);
const sz = 3;
var rct: TRect;
begin
  rct := Rect(pt.X-sz, pt.Y-sz, pt.X+sz, pt.Y+sz);

  aCnv.Brush.Color := clRed;
  aCnv.Ellipse(rct);

  SetBkMode(aCnv.Handle, TRANSPARENT);

  aCnv.Font.Color := clWhite;

  aCnv.TextOut(pt.X + 12, pt.Y    , 't: ' + FormatFloat('00.00', TimeAx)
    + '~ Lo: ' + FormatFloat('00.00', timeMax));
    // + ' Hi: ' + FormatFloat('00.00', timeMaxHi) );


  if R < rangeMax then
    aCnv.Font.Color := clAqua
  else
    aCnv.Font.Color := clRed;
  aCnv.TextOut(pt.X + 12, pt.Y +12, 'r: ' + FormatFloat('0000.00', R)
    + '~' + FormatFloat('0000.00', rangeMax));

  aCnv.TextOut(pt.X + 12, pt.Y +22, 'y: ' + FormatFloat('00.00', Z ));

  if (Z >= 0) and (Z < heightMax) then
    aCnv.Font.Color := clBlue
  else
   aCnv.Font.Color := clRed;

  aCnv.TextOut(pt.X + 12, pt.Y +36, 'err: ' + FormatFloat('00.00', rangeMax-R ));

//  aCnv.TextOut(pt.X + 80, pt.Y + 0, 'p: ' + FormatFloat('00.00', P ));
//  aCnv.TextOut(pt.X + 80, pt.Y +10, 'Vt: ' + FormatFloat('00.00', Vt ));
//  aCnv.TextOut(pt.X + 80, pt.Y +20, 'Vx: ' + FormatFloat('00.00', Vr ));
//  aCnv.TextOut(pt.X + 80, pt.Y +30, 'Vy: ' + FormatFloat('00.00', Vz ));
end;

function Sigmoid(const t: double ): double;
begin
  result := -1 + 2 / (1 +  Exp(-t));
end;

function searchLowAngle():double;
begin

   result := 0;
end;

function TGunProjectileCalc.searchHighAngle(const tX, tY: double):double;
var
    i: integer;
    t1,    // time to target
    e1, dR : double;
    err, delta: double;
    locked: boolean;
begin
  result := 0;
  ElevMode := emHigh;

//  e1 := high_MaxRangeToElev(tX);
  e1 := 72;
  i := 0;

  delta := 0;

  repeat
    e1 := e1 + delta;

    SetElevation(E1);

    t1 := tes_heightToTime( tY, heightMax, timeMax);

//    dZ := timeToHeight(t1, timeMax, heightMax);
    dR := high_TimeToRange(t1);
    err := dR - tX;

    delta :=  (2.0 * Sigmoid( 0.001 * err ));

    locked := (abs(delta) < 0.1); //  degree.
    inc(i);
   until  (i > 40) or locked  or (e1 >= 80) or (e1 < 45);

//  (i > 40) or locked  or (e1 >= 90) or (e1 < 30);

  if locked then begin
     result := e1;
  end
  else begin
     result := -1.0;
  end;

end;

function TGunProjectileCalc.searchLowAngle(const tx, ty: double):double;
var tt,   // time to target
    e1 : double;
    i: integer;
    err, delta : double;
    locked: boolean;
begin

  ElevMode := emLow;
  tt := low_rangeToMaxTime(tX); //masih bisa diandalkan untuk setting low
  e1 := RadToDeg(ArcTan2(tY, tX));

  i := 0;

  repeat
    SetElevation(e1);

    TimeAX := 0;
    Move(tt);

    err := tY - Z;
    delta :=  (2.0 * Sigmoid( 0.001 * err ));


    e1 := e1 + delta;
    inc(i);

    locked := (abs(err) < 1.0); // meter
   until locked or (i >= 45) or (e1 < 0);

  if locked then begin
    result := e1;
  end
  else begin
    result := -1.0;
  end;
end;

{
procedure TForm1.btnLockClick(Sender: TObject);
var tt,   // time to target
    tmax,  // assumed max time
    e1 : double;
    i: integer;
    err, delta, dir, a, lastDelta: double;
    locked: boolean;
begin
//input:

  if rgElev.ItemIndex = 0 then begin
    gp.ElevMode := emLow;
    tt := low_rangeToMaxTime(tmk.X);
    e1 := RadToDeg(Arctan2(tmk.Y, tmk.X));
  end
  else begin
    gp.ElevMode := emHigh;

    e1 := high_MaxRangeToElev(tmk.X);
  end;


  i := 0;
  memo1.Lines.Clear;
  locked := false;
  delta  := 0;

  repeat
    gp.SetElevation(e1);

    if gp.ElevMode = emHigh then
      tt := tes_heightToTime(tmk.Y, gp.heightMax, gp.timeMax)
    else
      tt := low_rangeToMaxTime(tmk.X);

    gp.TimeAX := 0;
    gp.Move(tt);

    err := gp.R - tmk.X;

    emk.E := gp.E0;
    mk.X  := gp.rangeMax;
    mk.Y  := gp.heightMax;

    if err < 0 then
      dir := -1
    else
      dir := 1;

    lastDelta := delta;
    delta :=  (3.0 * Sigmoid( 0.001 * err ));

  //  if abs(delta) > abs(lastDelta) then
  // unonvergen

     memo1.Lines.Insert(0, IntToStr(i)
     + ',e1: ' + FormatFloat('00.0', E1)
     + ',z: ' + FormatFloat('00.0', gp.Z)
     + ',tt' + FormatFloat('00.0', tt));

    e1 := e1 + delta;
    inc(i);

    FillTrajectory;

    Repaint;
    Sleep(120);

    locked := (abs(err) < 1.0); // meter
   until  (i > 40) or locked or (e1 >= 90);

  if locked then begin
    memo1.Lines.Insert(0, 'target locked');

    gp.TimeAX := 0;
    if not Timer1.Enabled then begin
      QueryPerformanceFrequency(FPerfFreq);
      QueryPerformanceCounter(FLastPerfCount);
      timer1.Enabled := true;
    end;
  end
  else begin
    memo1.Lines.Insert(0, 'Failed');

  end;

end;
}
procedure TForm1.Button2Click(Sender: TObject);
begin
  gp.TimeAX := 0;
  gp.Move(0);
  repaint;
end;

procedure TForm1.btnLockLoClick(Sender: TObject);
var e0: double;
begin
  if rgElev.ItemIndex = 0 then
    e0 := gp.searchLowAngle(tmk.X, tmk.Y)
  else
    e0 := gp.searchHighAngle(tmk.X, tmk.Y);

  if e0 <= 0 then
    Memo1.Lines.Add(' failed ')
  else begin
    Memo1.Lines.Add(' locked at ' + FormatFloat('00.0', E0));

    gp.SetElevation(e0);
    FillTrajectory;
    Repaint;

    gp.TimeAX := 0;
    if not Timer1.Enabled then begin
        QueryPerformanceFrequency(FPerfFreq);
        QueryPerformanceCounter(FLastPerfCount);
        timer1.Enabled := true;
    end;
  end;
end;

procedure TForm1.FillTrajectory;
var i: integer;
   dt: double;
begin
  for i := 0 to trj.size-1 do begin
     dt := (i)  * gp.timeMax / (trj.size-1);
     gp.TimeAX := dt;
     gp.Move(0);
     trj.FR[i].X := gp.R;
     trj.FR[i].Y := gp.Z;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;

  gp := TGunProjectileCalc.Create;
  gp.OnStop := gpOnStop;
  cc := TCanvasCoord.Create;
  cc.Offset.X := 100;
  cc.Offset.Y := 540;

  mk        := TPointMarker.Create;
  mk.Color  := clFuchsia;

  tmk       := TPointMarker.Create;
  tmk.Color := clYellow;

  emk := TElevMarker.Create;
  emk.Color := clGray;
  emk.R := 10000;
  emk.X := 0;
  emk.Y := 0;

  trj := TPointTrajectory.Create;

  scBarElevLOW.Position := 300;
  scMarkHeight.Position  := 50;
  scMarkRange.Position := 1000;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  tmk.Free;
  mk.Free;
  cc.Free;
  gp.Free;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

  cc.Draw(Canvas);

  mk.Converts(cc);
  mk.Draw(Canvas);

  tmk.Converts(cc);
  tmk.Draw(Canvas);

  emk.Converts(cc);
  emk.Draw(Canvas);

  trj.Converts(cc);
  trj.Draw(Canvas);

  gp.Converts(cc);
  gp.Draw(Canvas);

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  cc.Offset.X := 100;
  cc.Offset.Y := Height - 180;
  Repaint;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  top := 1;
end;

procedure TForm1.btnRunClick(Sender: TObject);
begin
  if not Timer1.Enabled then begin

    QueryPerformanceFrequency(FPerfFreq);
    QueryPerformanceCounter(FLastPerfCount);
  end;

  Timer1.Enabled := not Timer1.Enabled;
end;


procedure TForm1.gpOnStop(Sender: TObject);
begin
   Timer1.Enabled := false;
end;


procedure TForm1.scBarElevLOWChange(Sender: TObject);
var sc : TScrollBar;
    e: double;
begin
  // input = elevasi
  //max = 360
  sc := sender as TScrollBar;
  e := (sc.Max - sc.Position) / 10;
  lblLo.Caption := 'Lo: ' + FormatFloat('00.0', e);
  edElev.Text := FormatFloat('00.00', e) ;
  emk.E := e;

  gp.ElevMode  := emLow;
  gp.SetElevation(e);

  scBarMax.OnChange := nil;
  scBarMax.Position := Round(0.1 * gp.rangeMax );
  scBarMax.OnChange := scBarMaxChange;

  // hitung jarak maksimum dari elevasi;
  edMaxRange.Text   := FormatFloat('0000.00', gp.rangeMax) ;
  edTertinggi.Text  := FormatFloat('00.00', gp.heightMax);

  // hitung waktu tempuh maksimum dari jarak
  edTOF.Text          :=   FormatFloat('00.00', gp.timeMax) ;


  mk.X := gp.rangeMax;
  mk.Y := gp.heightMax;

  FillTrajectory;

  Repaint;
end;

procedure TForm1.scBarHIGHChange(Sender: TObject);
var sc : TScrollBar;
    e  : double;
begin
  // input = elevasi
  //max = 450-800
  sc := sender as TScrollBar;
  e := (sc.Min + sc.Max - sc.Position) / 10;
  lblHi.Caption := 'Hi: '+  FormatFloat('00.0', e);
  edElev.Text := FormatFloat('00.00', e) ;
  emk.E := e;

  gp.ElevMode := emHigh;
  gp.SetElevation(e);


  scBarMax.OnChange := nil;
  scBarMax.Position := Round(0.1 * gp.rangeMax );
  scBarMax.OnChange := scBarMaxChange;

  edMaxRange.Text   := FormatFloat('0000.00', gp.rangeMax) ;
  edTertinggi.Text  := FormatFloat('00.00', gp.heightMax);
  edTOF.Text        := FormatFloat('00.00', gp.timeMax);

  mk.X := gp.rangeMax;
  mk.Y := gp.heightMax;
  FillTrajectory;

  Repaint;
end;


procedure TForm1.scBarTimeChange(Sender: TObject);
var d: double;
begin
  d := (scBarTime.Position / scBarTime.Max) * gp.timeMax ;

  gp.TimeAX := d;
  gp.Move(0);

  gp.Converts(cc);

  LbltiME.Caption := 't: ' +FormatFloat('00.0', d);
  Repaint;
end;

procedure TForm1.scBarMaxChange(Sender: TObject);
var r, e: double;
begin
  // input = elevasi
  r := (scBarMax.Position * 10);
  lblRange.Caption := 'r: ' +FormatFloat('00.0', r);

  if rgElev.ItemIndex = 0 then begin
    e := low_MaxRangeToElev(r);
    gp.ElevMode := emLow;

    scBarElevLow.OnChange := nil;
    scBarElevLow.Position := scBarElevLow.Max + scBarElevLow.Min -(Round(e*10));
    scBarElevLow.OnChange := scBarElevLowChange;

  end
  else begin
    e := high_MaxRangeToElev(r);
    gp.ElevMode := emHigh;

    scBarHIGH.OnChange := nil;
    scBarHIGH.Position := scBarHIGH.Max + scBarHIGH.Min - ( Round(e*10));
    scBarHIGH.OnChange := scBarHIGHChange;

  end;
  gp.SetElevation(e);

  emk.E := e;

  edElev.Text         := FormatFloat('00.00', gp.E0) ;
  edMaxRange.Text     := FormatFloat('00.00', gp.rangeMax) ;
  edTOF.Text          := FormatFloat('00.00', gp.timeMax) ;
  edTertinggi.Text    := FormatFloat('00.00', gp.heightMax);


  mk.X := r;
  mk.Y := gp.heightMax;

  FillTrajectory;

  Repaint;
end;
//==============================================================================

procedure TForm1.scMarkHeightChange(Sender: TObject);
var h, e0: double;
begin
  h := 10 * (scMarkHeight.Max - scMarkHeight.Position) / scMarkHeight.Max;
  tmk.Y := h * 1000;
  lblMarkY.Caption := 't.x: ' +FormatFloat('00.0', h);

  if rgElev.ItemIndex = 0 then
    e0 := gp.searchLowAngle(tmk.X, tmk.Y)
  else
    e0 := gp.searchHighAngle(tmk.X, tmk.Y);

  if e0 >= 0 then begin
      emk.E := e0;
    gp.SetElevation(e0);
    FillTrajectory;

  end;

  Repaint;
end;


procedure TForm1.scMarkRangeChange(Sender: TObject);
var r, tt, e0: double;
begin
  // input = elevasi
  r := 16.0 * (scMarkRange.Position / scMarkRange.Max);
//
  tmk.X := r * 1000;

  lblMarkX.Caption := 't.x: ' +FormatFloat('00.0', r);

  tt := low_rangeToMaxTime(tmk.X);
  lblMarkTime_low.Caption := 'tLo: ' + FormatFloat('00.00', tt);

  tt := high_RangeToTime(tmk.X);
  lblMarkTime_hi.Caption :=  'tHi: ' + FormatFloat('00.00', tt);

  if rgElev.ItemIndex = 0 then
    e0 := gp.searchLowAngle(tmk.X, tmk.Y)
  else
    e0 := gp.searchHighAngle(tmk.X, tmk.Y);

  if e0 >= 0 then begin
      emk.E := e0;
    gp.SetElevation(e0);
    FillTrajectory;
  end;

  Repaint;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var Count: Int64;
    sec : double;
begin
  QueryPerformanceCounter(Count);

  Sec := (Count - FLastPerfCount) / FPerfFreq;
  FLastPerfCount := Count;

  gp.Move(sec);

  Repaint;
end;


end.
