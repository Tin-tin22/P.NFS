unit uDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids;

type
  TfrmDoc = class(TForm)
    pnlDoc: TPanel;
    pnlTitle: TPanel;
    Label1: TLabel;
    pnlMenu: TPanel;
    btnView: TSpeedButton;
    btnPrint: TSpeedButton;
    btnUSB: TSpeedButton;
    btnExit: TSpeedButton;
    sgDoc: TStringGrid;
    pnlViewValue: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lblCurrentTIme: TLabel;
    timerDoc: TTimer;
    pnlBlank: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timerDocTimer(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    docStartTime, docStopTime: TDateTime;
    docDay, docHour, docMinute : integer;
	  docSecond : double;

    procedure setStringGrid;
    procedure AutoSizeCol(Grid: TStringGrid; Column: integer);

    function docSetTime(StartTime: double) : string;
  end;

var
  frmDoc: TfrmDoc;

implementation

{$R *.dfm}

uses uManualInput, uTrackFunction, uMainMM;

procedure TfrmDoc.btnExitClick(Sender: TObject);
begin
  timerDoc.Enabled := True;
  Close;
end;

procedure TfrmDoc.FormShow(Sender: TObject);
begin
  Left := 160;
  Top  := 0;

  pnlBlank.BringToFront;

  setStringGrid;

  timerDoc.Enabled := True;
  lblCurrentTIme.Caption := docSetTime(0.0);
end;

procedure TfrmDoc.btnViewClick(Sender: TObject);
begin
  pnlViewValue.BringToFront;
end;

procedure TfrmDoc.timerDocTimer(Sender: TObject);
var
	 CurrentTime: TDateTime;
	 EndTime: double;
begin
   CurrentTime := now;
   EndTime := CurrentTime - docStartTime;
   lblCurrentTIme.caption := docSetTime(EndTime);

   if docSecond > 0 then
   begin

   end;
end;

procedure TfrmDoc.setStringGrid;
var
   I : Integer;
begin
   sgDoc.Cells[0,0] := 'Moving Components Of target Input Attribute';                //==
   sgDoc.Cells[0,1] := 'Interval between launchers';
   sgDoc.Cells[0,2] := 'Geographic Latitude Of Ship';
   sgDoc.Cells[0,3] := 'Geographic Longitude Of Ship';
   sgDoc.Cells[0,4] := 'MRSE Of Ship Position';
   sgDoc.Cells[0,5] := 'Ship Heading';
   sgDoc.Cells[0,6] := 'Ship Speed';
   sgDoc.Cells[0,7] := 'Lateral deviation limit at final phase';
   sgDoc.Cells[0,8] := 'Range Limit';
   sgDoc.Cells[0,9] := 'Lateral deviation limit at launch area';
   sgDoc.Cells[0,10] := 'Range limitation within launch area';
   sgDoc.Cells[0,11] := 'Time limitation';
   sgDoc.Cells[0,12] := 'Minimum admissible angle of turn';
   sgDoc.Cells[0,13] := 'Maximum admissible angle of turn';
   sgDoc.Cells[0,14] := 'Number of ASM assigned for target hitting';
   sgDoc.Cells[0,15] := 'Period of saving MDP';
   sgDoc.Cells[0,16] := 'Initial range to target';                                   //==
   sgDoc.Cells[0,17] := 'Initial target bearing';                                    //==
   sgDoc.Cells[0,18] := 'Target heading';                                            //==
   sgDoc.Cells[0,19] := 'Target speed';                                              //==
   sgDoc.Cells[0,20] := 'MRSE Of target range';                                      //==
   sgDoc.Cells[0,21] := 'MRSE Of target bearing';                                    //==
// ============================================================================ //
   sgDoc.Cells[0,22] := 'Geographic Latitude Of Target';                             //==
   sgDoc.Cells[0,23] := 'Geographic Longitude Of Target';                            //==
   sgDoc.Cells[0,24] := 'MRSE of target position';                                   //==
   sgDoc.Cells[0,25] := 'MRSE Of Target Heading';                                    //==
   sgDoc.Cells[0,26] := 'MRSE Of Target Speed';                                      //==
   sgDoc.Cells[0,27] := 'Target Data Ageing Time';                                   //==
   sgDoc.Cells[0,28] := 'Target Type';                                               //==
   sgDoc.Cells[0,29] := 'Core Radius';                                               //==
   sgDoc.Cells[0,30] := 'Number of ship in Core';                                    //==
   sgDoc.Cells[0,31] := 'Quantity Ship in Formation';                                //==

   for i := 0 to sgDoc.ColCount - 1 do
      AutoSizeCol(sgDoc, 0);

   with frmManualInput do
   begin
     if typeOfVariant = 1 then
     begin
       sgDoc.Cells[1,0] := IntToStr(typeOfVariant);
       sgDoc.Cells[1,1] := '2.5';
  //     sgDoc.Cells[1,2] := '000.00.00';
  //     sgDoc.Cells[1,3] := '000.00.00';
       sgDoc.Cells[1,4] := '00000.0';
  //     sgDoc.Cells[1,5] := '00.0';
  //     sgDoc.Cells[1,6] := '00.0';
       sgDoc.Cells[1,7] := '90000.0';
       sgDoc.Cells[1,8] := '600000.0';
       sgDoc.Cells[1,9] := '90000.0';
       sgDoc.Cells[1,10] := '-600000.0';
       sgDoc.Cells[1,11] := '500.00';
       sgDoc.Cells[1,12] := '-180';
       sgDoc.Cells[1,13] := '180';
       sgDoc.Cells[1,14] := '1';
       sgDoc.Cells[1,15] := '0050';
       sgDoc.Cells[1,16] := FormatFloat('0.00', (Rec_TIVar1.DistTarget/1000));
       sgDoc.Cells[1,17] := FormatFloat('0.00', (Rec_TIVar1.BearingTarget));
       sgDoc.Cells[1,18] := FormatFloat('0.00',  Rec_TIVar1.HeadingTarget);
       sgDoc.Cells[1,19] := FormatFloat('0.00',  Rec_TIVar1.SpeedTarget);
       sgDoc.Cells[1,20] := FormatFloat('0.00', (Rec_TIVar1.MRSE_distTarget/1000));
       sgDoc.Cells[1,21] := FormatFloat('0.00',  Rec_TIVar1.MRSE_bearingTarget);
    // ============================================================================ //
       sgDoc.Cells[1,22] := '00.000.000';
       sgDoc.Cells[1,23] := '000.000.000';
       sgDoc.Cells[1,24] := '0.00';
       sgDoc.Cells[1,25] := FloatToStr(Rec_TIVar1.MRSE_headingTarget);
       sgDoc.Cells[1,26] := FloatToStr(Rec_TIVar1.MRSE_speedTarget);
       sgDoc.Cells[1,27] := FloatToStr(Rec_TIVar1.AgeingTimeDataTarget);
       sgDoc.Cells[1,28] := IntToStr(Rec_TIVar1.TypeTarget);
       sgDoc.Cells[1,29] := FloatToStr(Rec_TIVar1.CoreRadius);
       sgDoc.Cells[1,30] := IntToStr(Rec_TIVar1.QuantityOfShipInCore);
       sgDoc.Cells[1,31] := IntToStr(Rec_TIVar1.QuantityOfShipInFormation);
     end
     else
     begin
       sgDoc.Cells[1,0] := IntToStr(typeOfVariant);
       sgDoc.Cells[1,1] := '2.5';
  //     sgDoc.Cells[1,2] := '000.00.00';
  //     sgDoc.Cells[1,3] := '000.00.00';
       sgDoc.Cells[1,4] := '00000.0';
  //     sgDoc.Cells[1,5] := '00.0';
  //     sgDoc.Cells[1,6] := '00.0';
       sgDoc.Cells[1,7] := '90000.0';
       sgDoc.Cells[1,8] := '600000.0';
       sgDoc.Cells[1,9] := '90000.0';
       sgDoc.Cells[1,10] := '-600000.0';
       sgDoc.Cells[1,11] := '500.00';
       sgDoc.Cells[1,12] := '-180';
       sgDoc.Cells[1,13] := '180';
       sgDoc.Cells[1,14] := '1';
       sgDoc.Cells[1,15] := '0050';
       sgDoc.Cells[1,16] := '0';
       sgDoc.Cells[1,17] := '0';
       sgDoc.Cells[1,18] := FormatFloat('0.00', Rec_TIVar2.HeadingTarget);
       sgDoc.Cells[1,19] := FormatFloat('0.00', Rec_TIVar2.SpeedTarget);
       sgDoc.Cells[1,20] := '0';
       sgDoc.Cells[1,21] := '0';
    // ============================================================================ //
       sgDoc.Cells[1,22] := formatDMS_lat(Rec_TIVar2.LattTarget);
       sgDoc.Cells[1,23] := formatDMS_long(Rec_TIVar2.LongTarget);
       sgDoc.Cells[1,24] := FloatToStr(Rec_TIVar2.MRSE_posTarget);
       sgDoc.Cells[1,25] := FloatToStr(Rec_TIVar2.MRSE_headingTarget);
       sgDoc.Cells[1,26] := FloatToStr(Rec_TIVar2.MRSE_speedTarget);
       sgDoc.Cells[1,27] := FloatToStr(Rec_TIVar2.AgeingTimeDataTarget);
       sgDoc.Cells[1,28] := IntToStr(Rec_TIVar2.TypeTarget);
       sgDoc.Cells[1,29] := FloatToStr(Rec_TIVar2.CoreRadius);
       sgDoc.Cells[1,30] := IntToStr(Rec_TIVar2.QuantityOfShipInCore);
       sgDoc.Cells[1,31] := IntToStr(Rec_TIVar2.QuantityOfShipInFormation);
     end;
   end;

   for i := 0 to sgDoc.ColCount - 1 do
      AutoSizeCol(sgDoc, 1);

end;

procedure TfrmDoc.AutoSizeCol(Grid: TStringGrid; Column: integer);
var
  i, W, WMax: integer;
begin
  WMax := 0;
  for i := 0 to (Grid.RowCount - 1) do begin
    W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
    if W > WMax then
      WMax := W;
  end;
  Grid.ColWidths[Column] := WMax + 250;
end;

function TfrmDoc.docSetTime(StartTime: double) : String;
begin
	If int(StartTime) > 0 then
	  docDay := 0
  else
    docHour := Trunc(StartTime);

	StartTime  := Frac(StartTime) * 24; // untuk jam
	docHour   := Trunc(StartTime);

	StartTime  := frac(StartTime) * 60; // untuk Menit
	docMinute := Trunc(StartTime);

	docSecond := frac(StartTime) * 60; // untuk detik

  Result := '0' + IntToStr(docHour) + ' : ' + '0' + IntToStr(docMinute) + ' : ' + 	FloatToStrF(docSecond, ffFixed,15,0);

end;

end.
