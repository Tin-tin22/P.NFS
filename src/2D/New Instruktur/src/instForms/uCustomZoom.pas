unit uCustomZoom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, AdvSmoothButton, uTCPDatatype, uInstrukturManager,
  uSimulationManager ;
type
  TfrmCustomZoom = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    img4: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button1: TAdvSmoothButton;
    img3: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure img3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    function GetMapUnitStr(const i: integer): string;
  public
  end;

var
  frmCustomZoom: TfrmCustomZoom;

implementation

uses
  ufrmMainInstruktur, MapXLib_TLB;

{$R *.DFM}

procedure TfrmCustomZoom.Button1Click(Sender: TObject);
var
  I: Double;
  mapRec : TRecMapCommand;
begin
  if frmMainInstruktur.Map1Ready = True then
  begin
    I := StrToFloat(ComboBox1.Text);
    mapRec.ToolID   := miZoomInTool;
    mapRec.OrderID  := OID_MAP;
    mapRec.Scale    := Round(I);
    mapRec.MapID    := 1;

    SimManager.NetSendToMap(mapRec);
    ModalResult := mrOK;

  end
  else if frmMainInstruktur.Map2Ready = True then
  begin
    I := StrToFloat(ComboBox1.Text);
    mapRec.ToolID   := miZoomInTool;
    mapRec.OrderID  := OID_MAP;
    mapRec.Scale    := Round(I);
    mapRec.MapID    := 2;

    SimManager.NetSendToMap(mapRec);
    ModalResult := mrOK;

  end
  else if (frmMainInstruktur.Map1Ready = False) and (frmMainInstruktur.Map1Ready = False) then
  begin
    try
      I := StrToFloat(ComboBox1.Text);
      frmMainInstruktur.MainMap.Zoom := I;
    except
      MessageBox(Handle, PChar('Enter a valid zoom value ...'), PChar(Caption), MB_ICONSTOP);
      ComboBox1.SetFocus;
      Abort;
    end;
    ModalResult := mrOK;
    frmMainInstruktur.lblToolUsed.Caption := 'Select Hand';
  end;

  if SimManager.fGamePlayType = gpmReplay then
  begin
    I := StrToFloat(ComboBox1.Text);
    mapRec.ToolID   := miZoomInTool;
    mapRec.OrderID  := OID_MAP;
    mapRec.MapID    := 0;
    mapRec.Scale    := Round(I);
    SimManager.NetSendToMap(mapRec);
  end;
end;

function TfrmCustomZoom.GetMapUnitStr(const i: integer): string;
begin
  case i of
    miUnitNauticalMile: Result := 'Nautical Mile';
    miUnitMile:         Result := 'Mile';
    miUnitKilometer:    Result := 'Kilometer';
    miUnitFoot:         Result := 'Feet';
    miUnitYard:         Result := 'Yard';
    miUnitMeter:        Result := 'Meter';
  else
    Result := 'Unknown';
  end;
end;



procedure TfrmCustomZoom.FormShow(Sender: TObject);
var I: Integer;
begin
  Label2.Caption := Format('Zoom unit in : %s', [GetMapUnitStr(frmMainInstruktur.MainMap.MapUnit)]);
  I := 0;
  ComboBox1.Items.Clear;
  ComboBox1.Items.Add(IntToStr(4));
  ComboBox1.Items.Add(IntToStr(8));
  ComboBox1.Items.Add(IntToStr(16));
  ComboBox1.Items.Add(IntToStr(32));
  while I <= 2000 do
  begin
    I := I + 50;
    ComboBox1.Items.Add(IntToStr(I));
  end;
  ComboBox1.ItemIndex := 0;

end;

procedure TfrmCustomZoom.Image1Click(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TfrmCustomZoom.FormPaint(Sender: TObject);
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


procedure TfrmCustomZoom.img3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
const SC_DRAGMOVE = $F012;
begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
end;

end.
