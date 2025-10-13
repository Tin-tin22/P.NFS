unit uLoadingScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmLoadingScreen = class(TForm)
    imgLoadingScreen: TImage;
    Label1: TLabel;
    pbLoadingScreen: TProgressBar;
    timerLoadingScreen: TTimer;
    procedure timerLoadingScreenTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Start_Time, Stop_Time: TDateTime;
    this_Day, this_Hour, this_Minute : integer;
	  this_Second : double;

    temp_Counter : Integer;

    procedure Set_Time(StartTime: double);
  end;

var
  frmLoadingScreen: TfrmLoadingScreen;

implementation

{$R *.dfm}

uses uRegimesOfWork;

procedure TfrmLoadingScreen.timerLoadingScreenTimer(Sender: TObject);
var
	 C_Time: TDateTime;
	 E_Time: double;
begin
   C_Time := now;
   E_Time := C_Time - Start_Time;
   Set_Time(E_Time);

   if this_Second = 0 then
   begin
     pbLoadingScreen.Position := 0;
     temp_Counter := 0;
   end;

   if this_Second > 0 then
   begin
     inc(temp_Counter);
     pbLoadingScreen.Position := temp_Counter;
   end;

   if (pbLoadingScreen.Position >= pbLoadingScreen.Max) then
   begin
     timerLoadingScreen.Enabled := False;
     frmLoadingScreen.Close;

     fmMain.ShowModal;
   end;
end;

procedure TfrmLoadingScreen.FormShow(Sender: TObject);
begin
//  this_Second := 0;
//  pbLoadingScreen.Position := 0;
end;

procedure TfrmLoadingScreen.Set_Time(StartTime: double);
begin
	If int(StartTime) > 0 then
	  this_Day := 0
  else
    this_Hour := Trunc(StartTime);

	StartTime  := Frac(StartTime) * 24; // untuk jam
	this_Hour   := Trunc(StartTime);

	StartTime  := frac(StartTime) * 60; // untuk Menit
	this_Minute := Trunc(StartTime);

	this_Second := frac(StartTime) * 60; // untuk detik

//  Result := '0' + IntToStr(thisHour) + ' : ' + '0' + IntToStr(thisMinute) + ' : ' + 	FloatToStrF(thisSecond, ffFixed,15,0);
end;

end.
