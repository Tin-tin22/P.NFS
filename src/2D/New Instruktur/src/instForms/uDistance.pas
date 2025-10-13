unit uDistance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, MapXLib_TLB, AdvSmoothButton;

const
  //karna ruler yg ditampilkan cuma satu, UID-nya jadiin konstanta aja ya...
  CONST_RULER_ID = 'RLR001';

type
  TfrmDistance = class(TForm)
    Shape9: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Shape10: TShape;
    Shape1: TShape;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    tLong: TEdit;
    tLatt: TEdit;
    tGeo: TEdit;
    fLong: TEdit;
    fLatt: TEdit;
    fGeo: TEdit;
    eDist: TEdit;
    R1: TRadioButton;
    R2: TRadioButton;
    R3: TRadioButton;
    R4: TRadioButton;
    R5: TRadioButton;
    eBaring: TEdit;
    R6: TRadioButton;
    btClear: TAdvSmoothButton;
    img3: TImage;
    rbR7: TRadioButton;
    rbR8: TRadioButton;
    procedure rbR7Click(Sender: TObject);
  private
    function getPoint(const Index: Integer): integer;
    procedure setPoint(const Index, Value: integer);
  published
    Panel1: TPanel;
    Image1: TImage;
    img4: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure R1Click(Sender: TObject);
    procedure R2Click(Sender: TObject);
    procedure R3Click(Sender: TObject);
    procedure R4Click(Sender: TObject);
    procedure R5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure xpPanel1TitleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure R6Click(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure img3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    selUnitIndex : byte;
    Map : TMap;

    ptS : array [1..4] of single;
    ptM : array [1..4] of double;
    Range  : double;
    Bearing: double;
    isDatamile, isCable : boolean;

    procedure CalcIt;

    procedure updatePoint;
    procedure updateViewChange;

    property startX: integer index 1 read getPoint write setPoint;
    property startY: integer index 2 read getPoint write setPoint;

    property endX: integer index 3 read getPoint write setPoint;
    property endY: integer index 4 read getPoint write setPoint;
  end;

var
  frmDistance: TfrmDistance;

implementation

uses
  uBaseFunction, uInstrukturManager, ufrmMainInstruktur;
{$R *.DFM}

const
  mUnits : array [1..6] of integer =
  ( miUnitNauticalMile, miUnitMile, miUnitKilometer,
    miUnitMeter, miUnitYard,  miUnitFoot);

  procedure TfrmDistance.CalcIt;
begin

end;

procedure TfrmDistance.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SimManager.VRuler.Visible             := false;
  Map.CurrentTool                       := miPanTool;
  frmMainInstruktur.lblToolUsed.Caption := 'Select Hand';
end;

procedure TfrmDistance.R1Click(Sender: TObject);
begin
  isDatamile := false;
  isCable := false;

  Map.MapUnit := miUnitNauticalMile;
  Map.AreaUnit := miUnitSquareNauticalMile;
  selUnitIndex := (sender as TComponent).Tag;
  Map.MapUnit  := mUnits[selUnitIndex];

  updatePoint;
end;

procedure TfrmDistance.rbR7Click(Sender: TObject);
begin
  Map.MapUnit := miUnitNauticalMile;
  Map.AreaUnit := miUnitSquareNauticalMile;
  selUnitIndex := 1;                     //jadikan nauticalMile dulu
  Map.MapUnit  := mUnits[selUnitIndex];

  if (sender as TComponent).Tag = 7 then    //datamile
  begin
    isDatamile := true;
    isCable := false;
  end
  else if (sender as TComponent).Tag = 8 then    //cable
  begin
    isDatamile := false;
    isCable := true;
  end;

  updatePoint;
end;

procedure TfrmDistance.R2Click(Sender: TObject);
begin
  Map.MapUnit := miUnitMile;
  Map.AreaUnit := miUnitSquareMile;
  CalcIt;
end;

procedure TfrmDistance.R3Click(Sender: TObject);
begin
  Map.MapUnit := miUnitKilometer;
  Map.AreaUnit := miUnitSquareKilometer;
  CalcIt;
end;

procedure TfrmDistance.R4Click(Sender: TObject);
begin
  Map.MapUnit := miUnitMeter;
  Map.AreaUnit := miUnitSquareMeter;
  CalcIt;
end;

procedure TfrmDistance.R5Click(Sender: TObject);
begin
  Map.MapUnit := miUnitSurveyFoot;
  Map.AreaUnit := miUnitSquareSurveyFoot;
  CalcIt;
end;

//yard

procedure TfrmDistance.R6Click(Sender: TObject);
begin
  Map.MapUnit := miUnitYard;
  Map.AreaUnit := miUnitSquareYard;
  CalcIt;
end;

procedure TfrmDistance.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;
  selUnitIndex := 1;
  isDatamile := false;
  isCable := false;
end;

procedure TfrmDistance.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDistance.xpPanel1TitleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const SC_DRAGMOVE = $F012;
begin
  if button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure TfrmDistance.FormActivate(Sender: TObject);
begin

end;

procedure TfrmDistance.btClearClick(Sender: TObject);
begin
  SimManager.VRuler.Visible := false;
end;

procedure TfrmDistance.FormPaint(Sender: TObject);
var i, c, h2, y: integer;
begin
  c := ((ClientHeight - img3.Height) div img4.Height);
  h2 := img4.Height;
  y := img3.Height - h2;
  for i := 0 to c do begin
    y := y + h2;
    Canvas.Draw(1, y, img4.Picture.Bitmap);
  end;
  Canvas.Brush.Color := clBlack;
  Canvas.FrameRect(ClientRect);

end;

procedure TfrmDistance.img3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const SC_DRAGMOVE = $F012;
begin
  if button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;


function TfrmDistance.getPoint(const Index: Integer): integer;
begin
  result := Round(pts[Index]);
end;

procedure TfrmDistance.setPoint(const Index, Value: integer);
begin
  pts[Index] := Value;
  updatePoint;
end;

procedure TfrmDistance.updatePoint;
begin // convert Screen To Map;

  map.ConvertCoord(pts[1], pts[2], ptM[1], ptM[2], miScreenToMap);
  map.ConvertCoord(pts[3], pts[4], ptM[3], ptM[4], miScreenToMap);
  Map.MapUnit   := mUnits[selUnitIndex];
  
  Range   := Map.Distance(ptM[1], ptM[2], ptM[3], ptM[4]);
  Bearing := CalcBearing(ptM[1], ptM[2], ptM[3], ptM[4]);

  if isDatamile then
    Range :=  Range * 1.012686  //  NM_To_DM
  else if isCable then
    Range :=  Range * 10;       //  NM_To_Cable


  SimManager.VRuler.Range   := range;
  SimManager.VRuler.Bearing := Bearing;

  eBaring.Text := Format('%2.2f', [Bearing]);
  eDist.Text   := Format('%2.2f', [Range]);

  fLong.Text := ConvLL_To_Str(ptM[1], '0');
  fLatt.Text := ConvLL_To_Str(ptM[2], '1');

  tLong.Text := ConvLL_To_Str(ptM[3], '0');
  tLatt.Text := ConvLL_To_Str(ptM[4], '1');

  fGeo.Text := ConvDegree_To_Georef(ptM[1], ptM[2]);
  tGeo.Text := ConvDegree_To_Georef(ptM[3], ptM[4]);

  Map.MapUnit := 1; //balikkan ke nautical mile
end;

procedure TfrmDistance.updateViewChange;
begin
   map.ConvertCoord(pts[1], pts[2], ptM[1], ptM[2], miMapToScreen);
   map.ConvertCoord(pts[3], pts[4], ptM[3], ptM[4], miMapToScreen);
end;



end.
