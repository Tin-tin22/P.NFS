unit uSpecialForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TfrmDeveloper = class(TForm)
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    tsTDC: TTabSheet;
    tsRadar: TTabSheet;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    tsShip: TTabSheet;
    Label4: TLabel;
    Edit4: TEdit;
    tsEffect: TTabSheet;
    TrackBar1: TTrackBar;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    edNoiseLevel: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    CheckBox3: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    tsNetTest: TTabSheet;
    Button1: TButton;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure edNoiseLevelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox3Click(Sender: TObject);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDeveloper: TfrmDeveloper;

implementation

uses
  uWCCManager, uTCPClient, uTCPdataType;

{$R *.dfm}

function ConvertToWord(const str: string; var w: word):boolean;
begin
  w := 1;
  try
    w := StrToInt(str);
    if w<= 0 then w := 1;
  except
    on EConvertError do w := 1;
  end;
  result := true;
end;

function ConvertToFloat(const str: string; var f: double):boolean;
begin
  f := 1;
  try
    f := StrToFloat(str);
  except
    on EConvertError do f := 1;
  end;
  result := true;
end;
procedure TfrmDeveloper.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord(Edit1.Text, w) then
      uWCCManager.TDCSimCenter.MainThread.Interval := w
    else begin
      Edit1.Text := 'invalid';
      Edit1.SelectAll;
    end;
  end
  else if Key = VK_UP then begin
    Edit1.Text := IntToStr(uWCCManager.TDCSimCenter.MainThread.Interval);
  end;
end;

procedure TfrmDeveloper.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uWCCManager.TDCSimCenter.ActiveRadar.TimeBase.RotationSpeed := w
    else
      (Sender as TEdit).Text := IntToStr(w);
  end
  else if Key = VK_UP then begin
    Edit3.Text := Format('%2.2f', [uWCCManager.TDCSimCenter.ActiveRadar.TimeBase.RotationSpeed]);
  end;

end;

procedure TfrmDeveloper.TrackBar1Change(Sender: TObject);
begin
  uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.Darkness := TrackBar1.Position;
  Label6.Caption := IntToStr(TrackBar1.Position);
end;

procedure TfrmDeveloper.CheckBox1Click(Sender: TObject);
begin
  uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.UseEffect := CheckBox1.Checked;
end;

procedure TfrmDeveloper.CheckBox2Click(Sender: TObject);
var w: word;
begin
  if ConvertToWord((edNoiselevel).Text, w) then
      uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel := byte(w);
  uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.AddNoise := CheckBox2.Checked;
end;

procedure TfrmDeveloper.edNoiseLevelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w: word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel := byte(w);
  end
  else  if Key = VK_UP then begin
    edNoiseLevel.Text := IntToStr(uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel);
  end;

end;

procedure TfrmDeveloper.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Action := caFree;
end;

procedure TfrmDeveloper.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w: word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.SweepWidth := w;
  end
  else  if Key = VK_UP then begin
    Edit6.Text := IntToStr(uWCCManager.TDCSimCenter.ActiveRadar.TimeBaseView.SweepWidth);
  end;

end;

procedure TfrmDeveloper.CheckBox3Click(Sender: TObject);
var w : word;
begin
  if CheckBox3.Checked then
    uWCCManager.TDCSimCenter.MainThread.Interval := 0
  else begin
    if ConvertToWord(Edit1.Text, w) then
      uWCCManager.TDCSimCenter.MainThread.Interval := w
  end;

end;

procedure TfrmDeveloper.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : double;
   ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
    if ConvertTofloat(ed.Text, w) then
      uWCCManager.TDCSimCenter.xShip.Speed  := w
    else
      ed.Text := '-0.0';
  end
  else if Key = VK_UP then begin
    ed.Text := Format('%2.2f',
     [uWCCManager.TDCSimCenter.xShip.Speed]);
  end;


end;

procedure TfrmDeveloper.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : double;
   ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
    if ConvertTofloat(ed.Text, w) then
      uWCCManager.TDCSimCenter.xShip.Heading  := w
    else
      ed.Text := '-0.0';
  end
  else if Key = VK_UP then begin
    ed.Text := Format('%2.2f',
     [uWCCManager.TDCSimCenter.xShip.Heading]);
  end;


end;

procedure TfrmDeveloper.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : double;
   ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
      uWCCManager.TDCSimCenter.xShip.UniqueID := ed.Text;
  end
  else if Key = VK_UP then begin
    ed.Text := uWCCManager.TDCSimCenter.xShip.UniqueID;
  end;


end;

procedure TfrmDeveloper.Button1Click(Sender: TObject);
var aRec : TRecOrderXY;
begin
    aRec.OrderID    := OrdID_init_datum;
    aRec.OrderType  := 1; // RESERVED FOR DATUM NUMBER;
    aRec.ShipID := uWCCManager.TDCSimCenter.xShip.UniqueID;

    aRec.X := 118.4;
    aRec.Y := -9.3;

    uWCCManager.TDCSimCenter.NetComm.sendDataEx(C_REC_ORDER_XY, @aRec );

end;

procedure TfrmDeveloper.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
   ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
    if ConvertToWord(ed.Text, w) then
      uWCCManager.TDCSimCenter.RepaintCycle := w;
  end
  else if Key = VK_UP then begin
    ed.Text := IntToStr(uWCCManager.TDCSimCenter.RepaintCycle);

  end;

end;

end.
