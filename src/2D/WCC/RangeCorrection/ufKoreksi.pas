unit ufKoreksi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTCPClient, uTCPDatatype, Menus, DB, ADODB, DBTables, Grids,
  DBGrids, uData;

type
  TFrmKoreksi = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    btnRead: TButton;
    Label11: TLabel;
    PopupMenu1: TPopupMenu;
    pmConnect: TMenuItem;
    N1: TMenuItem;
    pmLog: TMenuItem;
    N2: TMenuItem;
    pmClose: TMenuItem;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    tdWCC: TEdit;
    mvWCC: TEdit;
    bpWCC: TEdit;
    atWCC: TEdit;
    humWCC: TEdit;
    fwWCC: TEdit;
    ssWCC: TEdit;
    tsWCC: TEdit;
    btnCorrectClient: TButton;
    txtElevClient: TEdit;
    btnCorrect: TButton;
    Label10: TLabel;
    txtDir: TEdit;
    Edit9: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Edit10: TEdit;
    Button2: TButton;
    Memo3: TMemo;
    procedure btnReadClick(Sender: TObject);
    procedure btnCorrectClick(Sender: TObject);
    procedure pmConnectClick(Sender: TObject);
    procedure pmLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dataEnvironmentAvailable(apRec: PAnsiChar; aSize: integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnCorrectClientClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    data : TData;

  public
    mServer : string;
    mShip : Integer;
    bConnect : boolean;
    TheClient : TTCPClient;

    function GetElevation(const TD, MV, BP, AT, Hum, FW, SS, TS: double): double;
    function GetTargetRange(const TD, BP, AT, ElevasiSenjata: double): double;
  end;

//var
//  frmKoreksi: TFrmKoreksi;

implementation

uses uCorrection, math;//, uConnect;

{$R *.dfm}


{==== perhitungan koreksi di WCC ====}
procedure TFrmKoreksi.btnCorrectClientClick(Sender: TObject);
var inputWCC :TEnvironmentData;
    totalCorr : Double;
    DataKoreksi: TRecFactorCorr;
begin
  inputWCC.TargetDistance := StrToFloat(tdWCC.Text);
  inputWCC.MuzzleVelocity := StrToFloat(mvWCC.Text);
  inputWCC.BarometricPressure := StrToFloat(bpWCC.Text);
  inputWCC.AirTemperature := StrToFloat(atWCC.Text);
  inputWCC.Humidity := StrToFloat(humWCC.Text);
  inputWCC.FollowingWind := StrToFloat(fwWCC.Text);
  inputWCC.ShipSpeed := StrToFloat(ssWCC.Text);
  inputWCC.TargetSpeed := StrToFloat(tsWCC.Text);

  //data.ReadData(tdWCC.Text,bpWCC.Text,atWCC.Text);
  DataKoreksi := data.GetCorrectionData(tdWCC.Text,bpWCC.Text,atWCC.Text);

  //totalCorr := totalDistCorr(inputWCC.MuzzleVelocity, data.DataFaktorKoreksi.MuzzleVelocity, inputWCC.BarometricPressure,
  //    data.DataFaktorKoreksi.BarometricPressure, inputWCC.AirTemperature, inputWCC.Humidity, data.DataFaktorKoreksi.Et,
  //    data.DataFaktorKoreksi.AirTemperature, inputWCC.FollowingWind, data.DataFaktorKoreksi.FollowingWind, inputWCC.ShipSpeed, data.DataFaktorKoreksi.ShipSpeed,
  //    inputWCC.TargetSpeed, data.DataFaktorKoreksi.TargetSpeed);

  {totalCorr := totalDistCorr(inputWCC.MuzzleVelocity, DataKoreksi.MuzzleVelocity, inputWCC.BarometricPressure,
      DataKoreksi.BarometricPressure, inputWCC.AirTemperature, inputWCC.Humidity, DataKoreksi.Et,
      DataKoreksi.AirTemperature, inputWCC.FollowingWind, DataKoreksi.FollowingWind, inputWCC.ShipSpeed,
      DataKoreksi.ShipSpeed, inputWCC.TargetSpeed, DataKoreksi.TargetSpeed);

  data.elevClient := Calc_ElevCorrection(totalCorr, DataKoreksi.angleDeparture, DataKoreksi.increaseElev);

  txtElevClient.Text := FloatToStr(data.elevClient);}

  txtElevClient.Text := FloatToStr(GetElevation(inputWCC.TargetDistance,
      inputWCC.MuzzleVelocity, inputWCC.BarometricPressure, inputWCC.AirTemperature,
      inputWCC.Humidity, inputWCC.FollowingWind, inputWCC.ShipSpeed, inputWCC.TargetSpeed));

end;

function TFrmKoreksi.GetElevation(const TD, MV, BP, AT, Hum, FW, SS, TS: double): double;
var totalCorr : Double;
    DataKoreksi : TRecFactorCorr;
begin
  DataKoreksi := data.GetCorrectionData(FloatToStr(TD), FloatToStr(BP), FloatToStr(AT));

  totalCorr := totalDistCorr(MV, DataKoreksi.MuzzleVelocity, BP,
      DataKoreksi.BarometricPressure, AT, Hum, DataKoreksi.Et,
      DataKoreksi.AirTemperature, FW, DataKoreksi.FollowingWind, SS,
      DataKoreksi.ShipSpeed, TS, DataKoreksi.TargetSpeed);

  data.elevClient := Calc_ElevCorrection(totalCorr, DataKoreksi.angleDeparture, DataKoreksi.increaseElev);

  result := data.elevClient;      //return in degree
end;

{ == == }

procedure TFrmKoreksi.Button3Click(Sender: TObject);
begin
  Close;
end;
{ == == }

 {== WCC ngirim sudut elevasi&data2 koreksi (data.DataFaktorKoreksi) ke server ==}
{==== perhitungan jarak di server 2D ====}
procedure TFrmKoreksi.btnReadClick(Sender: TObject);
var
  order_noval : TRecDataOrder_noval;
  dt : TEnvironmentData;
begin
  order_noval.order := ORD_ENVI;
  TheClient.sendDataEx(REC_ORD_NOVAL,@order_noval);
  //data.ReadInputFromIniFile;

  //Edit1.Text := FloatToStr(data.elevClient);
  //Edit2.Text := FloatToStr(data.inputServ.MuzzleVelocity);
  //Edit3.Text := FloatToStr(data.inputServ.BarometricPressure);
  //Edit4.Text := FloatToStr(data.inputServ.AirTemperature);
  //Edit5.Text := FloatToStr(data.inputServ.Humidity);
  //Edit6.Text := FloatToStr(data.inputServ.FollowingWind);
  //Edit7.Text := FloatToStr(data.inputServ.ShipSpeed);
  //Edit8.Text := FloatToStr(data.inputServ.TargetSpeed);

  dt := data.GetEnvironmentData;

  Edit1.Text := FloatToStr(data.elevClient);
  Edit2.Text := FloatToStr(dt.MuzzleVelocity);
  Edit3.Text := FloatToStr(dt.BarometricPressure);
  Edit4.Text := FloatToStr(dt.AirTemperature);
  Edit5.Text := FloatToStr(dt.Humidity);
  Edit6.Text := FloatToStr(dt.FollowingWind);
  Edit7.Text := FloatToStr(dt.ShipSpeed);
  Edit8.Text := FloatToStr(dt.TargetSpeed);
end;

procedure TFrmKoreksi.btnCorrectClick(Sender: TObject);
var
  targetDist : Double;
  totCorr,qe_deg : Double;
  EnvData: TEnvironmentData;
  DataKoreksi : TRecFactorCorr;
begin
  //hitung total koreksi
  //totCorr := totalDistCorr(data.inputServ.MuzzleVelocity, data.DataFaktorKoreksi.MuzzleVelocity, data.inputServ.BarometricPressure,
  //           data.DataFaktorKoreksi.BarometricPressure, data.inputServ.AirTemperature, data.inputServ.Humidity, data.DataFaktorKoreksi.Et,
  //           data.DataFaktorKoreksi.AirTemperature, data.inputServ.FollowingWind, data.DataFaktorKoreksi.FollowingWind, data.inputServ.ShipSpeed, data.DataFaktorKoreksi.ShipSpeed,
  //           data.inputServ.TargetSpeed, data.DataFaktorKoreksi.TargetSpeed);

  EnvData := data.GetEnvironmentData;
  DataKoreksi := data.GetCorrectionData(tdWCC.Text,bpWCC.Text,atWCC.Text);

  totCorr := totalDistCorr(EnvData.MuzzleVelocity, DataKoreksi.MuzzleVelocity, EnvData.BarometricPressure,
             DataKoreksi.BarometricPressure, EnvData.AirTemperature, EnvData.Humidity, DataKoreksi.Et,
             DataKoreksi.AirTemperature, EnvData.FollowingWind, DataKoreksi.FollowingWind, EnvData.ShipSpeed, DataKoreksi.ShipSpeed,
             EnvData.TargetSpeed, DataKoreksi.TargetSpeed);

  //hitung qe_deg
  qe_deg := Calc_QEDeg(totCorr, DataKoreksi.increaseElev, StrToFloat(edit1.Text));

  //hitung jarak
  targetDist := data.GetTargetDistance(qe_deg);     //(qe_deg);
  txtDir.Text := FloatToStr(targetDist);
end;

function TFrmKoreksi.GetTargetRange(const TD, BP, AT, ElevasiSenjata: double): double;
var totCorr, qe_deg, targetDist : double;
  EnvData: TEnvironmentData;
  DataKoreksi : TRecFactorCorr;
begin
  EnvData := data.GetEnvironmentData;
  DataKoreksi := data.GetCorrectionData(IntToStr(Floor(TD)), IntToStr(Floor(BP)), IntToStr(Floor(AT)));

  //hitung total koreksi
  totCorr := totalDistCorr(EnvData.MuzzleVelocity, DataKoreksi.MuzzleVelocity, EnvData.BarometricPressure,
             DataKoreksi.BarometricPressure, EnvData.AirTemperature, EnvData.Humidity, DataKoreksi.Et,
             DataKoreksi.AirTemperature, EnvData.FollowingWind, DataKoreksi.FollowingWind, EnvData.ShipSpeed, DataKoreksi.ShipSpeed,
             EnvData.TargetSpeed, DataKoreksi.TargetSpeed);

  //hitung qe_deg
  qe_deg := Calc_QEDeg(totCorr, DataKoreksi.increaseElev, ElevasiSenjata);

  //hitung jarak
  targetDist := data.GetTargetDistance(qe_deg);     //(qe_deg);
  result := targetDist;   // return in meter
end;

procedure TFrmKoreksi.pmConnectClick(Sender: TObject);
begin
  {//vConnect.IDShip := mShip;
  if vConnect.ShowModalConnect = mrOk then
  begin
    mServer := vConnect.CServer;
    //mShip := vConnect.IDShip;
    theClient.Connect(mServer, aPort);
    bConnect := True;
  end;}
end;

procedure TFrmKoreksi.pmLogClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmKoreksi.dataEnvironmentAvailable(apRec: PAnsiChar; aSize: integer);
var
  aRec: TRecDataEnvironment;
begin
  CopyMemory(@aRec, apRec, sizeof(TRecDataEnvironment));
  //data.DataEnvironment.BarometricPressure := aRec.surfacePressure;
  //data.DataEnvironment.AirTemperature := aRec.temperature;
  //data.DataEnvironment.Humidity:= aRec.humidity;
  //data.DataEnvironment.FollowingWind := aRec.windVelocity;
end;

procedure TFrmKoreksi.FormCreate(Sender: TObject);
begin
  data := TData.create;

  bConnect := false;
  TheClient:= TTCPClient.Create;
  TheClient.setLog(TStringList(Memo1.Lines));
  TheClient.RegisterProcedure(REC_ORD_NOVAL,nil,sizeof(TRecDataEnvironment));
  TheClient.RegisterProcedure(REC_ENVI,dataEnvironmentAvailable,sizeof(TRecDataEnvironment));

  data.SetLog1(TStringList(Memo2.Lines));
  data.SetLog2(TStringList(Memo3.Lines));
end;

procedure TFrmKoreksi.FormDestroy(Sender: TObject);
begin
  TheClient.Free;
end;

procedure TFrmKoreksi.Button1Click(Sender: TObject);
var a: TStringList;
begin
  Memo2.Clear;
  data.LoadDataTabelCorr(edit10.Text, a);
end;

procedure TFrmKoreksi.Button2Click(Sender: TObject);
var a: TStringList;
begin
  data.LoadDataTabelCorr(edit10.Text, a);
end;

end.
