unit uSpecialForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids;

type
  TfrmDeveloper = class(TForm)
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    tsTDC: TTabSheet;
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
    tsTest: TTabSheet;
    SpeedButton1: TSpeedButton;
    lvTrack: TListView;
    edHalu: TEdit;
    edCepat: TEdit;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label10: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
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
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lvTrackSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDeveloper: TfrmDeveloper;

implementation

uses
  uTDCManager, uTCPClient, uTCPdataType, uLibTDCClass, uLibTDCtracks, uBaseFunction;

{$R *.dfm}


procedure TfrmDeveloper.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord(Edit1.Text, w) then
      uTDCManager.TDCSimCenter.MainThread.Interval := w
    else begin
      Edit1.Text := 'invalid';
      Edit1.SelectAll;
    end;
  end
  else if Key = VK_UP then begin
    Edit1.Text := IntToStr(uTDCManager.TDCSimCenter.MainThread.Interval);
  end;
end;

procedure TfrmDeveloper.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uTDCManager.TDCSimCenter.ActiveRadar.TimeBase.RotationSpeed := w
    else
      (Sender as TEdit).Text := IntToStr(w);
  end
  else if Key = VK_UP then begin
    Edit3.Text := Format('%2.2f', [uTDCManager.TDCSimCenter.ActiveRadar.TimeBase.RotationSpeed]);
  end;

end;

procedure TfrmDeveloper.TrackBar1Change(Sender: TObject);
begin
//  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.Darkness := TrackBar1.Position;
  uTDCManager.TDCSimCenter.ActiveRadar.MaxIntensity := TrackBar1.Position;
  Label6.Caption := IntToStr(TrackBar1.Position);
end;

procedure TfrmDeveloper.CheckBox1Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.UseEffect := CheckBox1.Checked;
end;

procedure TfrmDeveloper.CheckBox2Click(Sender: TObject);
var w: word;
begin
  if ConvertToWord((edNoiselevel).Text, w) then
      uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel := byte(w);
  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.AddNoise := CheckBox2.Checked;
end;

procedure TfrmDeveloper.edNoiseLevelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w: word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel := byte(w);
  end
  else  if Key = VK_UP then begin
    edNoiseLevel.Text := IntToStr(uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.NoiseLevel);
  end;

end;

procedure TfrmDeveloper.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lvTrack.OnSelectItem := nil;
  Action := caFree;
end;

procedure TfrmDeveloper.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w: word;
begin
  if Key = VK_DOWN then begin
    if ConvertToWord((Sender as TEdit).Text, w) then
      uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.SweepWidth := w;
  end
  else  if Key = VK_UP then begin
    Edit6.Text := IntToStr(uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.SweepWidth);
  end;

end;

procedure TfrmDeveloper.CheckBox3Click(Sender: TObject);
var w : word;
begin
  if CheckBox3.Checked then
    uTDCManager.TDCSimCenter.MainThread.Interval := 0
  else begin
    if ConvertToWord(Edit1.Text, w) then
      uTDCManager.TDCSimCenter.MainThread.Interval := w
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
      uTDCManager.TDCSimCenter.xShip.Speed  := w
    else
      ed.Text := '-0.0';
  end
  else if Key = VK_UP then begin
    ed.Text := Format('%2.2f',
     [uTDCManager.TDCSimCenter.xShip.Speed]);
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
      uTDCManager.TDCSimCenter.xShip.Heading  := w
    else
      ed.Text := '-0.0';
  end
  else if Key = VK_UP then begin
    ed.Text := Format('%2.2f',
     [uTDCManager.TDCSimCenter.xShip.Heading]);
  end;


end;

procedure TfrmDeveloper.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
//  w : double;
  ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
      uTDCManager.TDCSimCenter.xShip.UniqueID := ed.Text;
  end
  else if Key = VK_UP then begin
    ed.Text := uTDCManager.TDCSimCenter.xShip.UniqueID;
  end;


end;

procedure TfrmDeveloper.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var w : word;
   ed : TEdit;
begin
  ed := (Sender as TEdit);
  if Key = VK_DOWN then begin
    if ConvertToWord(ed.Text, w) then
      uTDCManager.TDCSimCenter.RepaintCycle := w;
  end
  else if Key = VK_UP then begin
    ed.Text := IntToStr(uTDCManager.TDCSimCenter.RepaintCycle);

  end;

end;

procedure TfrmDeveloper.SpeedButton1Click(Sender: TObject);
var i: integer;
   t : TManualTrack;
   l : TList;
   li : TListItem;
   r : double;
begin
  with uTDCManager.TDCSimCenter.TheTDC do begin
    l := TrackList.GetList;
    TrackList.ReturnList;
    lvTrack.Items.Clear;
    for i := 0 to l.Count -1 do begin
       t := l.Items[i];
       li := lvTrack.Items.Add;
       li.Caption  := IntToOct(t.ShipTrackId , 2)+
          IntToOct(t.TrackNumber, 2);
       li.SubItems.Add(Format('%2.2f', [t.Course]) );
       li.SubItems.Add(Format('%2.2f', [t.Speed]) );
       r := CalcRange(xSHIP.PositionX, xSHIP.PositionY, t.PositionX, t.PositionY);
       li.SubItems.Add(Format('%2.2f', [r]) );

       r := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, t.PositionX, t.PositionY);
       li.SubItems.Add(Format('%2.2f', [r]) );
    end;
  end;
end;

procedure TfrmDeveloper.lvTrackSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
//var
//   l : TList;
//   li : TListItem;
//   t : TManualTrack;
begin
  if Item = nil then exit;
  if item.SubItems.Count > 1 then begin
    edHalu.Text  := item.SubItems[0];
    edCepat.Text := item.SubItems[1];
  end;

{  with uTDCManager.TDCSimCenter.TheTDC do begin
    l := TrackList.GetList;
    TrackList.ReturnList;
    if (Item.Index >= 0) and (Item.Index < l.Count) then begin
      t:= l[Item.Index];
      edHalu.Text  := Format('%2.2f', [t.Course]);
      edCepat.Text := Format('%2.2f', [t.Speed]) ;
    end;
  end;
}end;

procedure TfrmDeveloper.SpeedButton2Click(Sender: TObject);
var i : integer;
   l : TList;
//   li : TListItem;
   t : TManualTrack;
begin
  with uTDCManager.TDCSimCenter.TheTDC do begin
    l := TrackList.GetList;
    TrackList.ReturnList;
    i := lvTrack.ItemIndex;

    if (i >= 0) and (i < l.Count) then begin
      t:= l[i];

      t.Course := StrToFloat(edHalu.Text);
      t.Speed  := StrToFloat(edCepat.Text);
    end;
  end;
end;


procedure TfrmDeveloper.SpeedButton3Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.TheTDC.AddCursorFix;
end;

procedure TfrmDeveloper.SpeedButton4Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.TheTDC.DelCursorFix(
    uTDCManager.TDCSimCenter.TheTDC.OBMLeft.Center);

end;

procedure TfrmDeveloper.SpeedButton5Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.ActiveRadar.Radiate := (SENDER AS TSpeedButton).Down;
end;

procedure TfrmDeveloper.SpeedButton6Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.TimeBaseVisible
   :=   (SENDER AS TSpeedButton).Down;
//  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.
end;

procedure TfrmDeveloper.SpeedButton7Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.ActiveRadar.TimeBaseView.BackgroundVisible
   :=   (SENDER AS TSpeedButton).Down;

end;

end.
