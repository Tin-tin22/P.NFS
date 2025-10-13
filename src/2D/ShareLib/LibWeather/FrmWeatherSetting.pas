unit FrmWeatherSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, uWeather, Grids;

type
  TfrmWeather = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Edit9: TEdit;
    Edit8: TEdit;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    btnCreateWeather: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    btnGetWeather: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Edit21: TEdit;
    GroupBox5: TGroupBox;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Button1: TButton;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Button2: TButton;
    Label36: TLabel;
    Label38: TLabel;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Button6: TButton;
    Label43: TLabel;
    ScrollBar1: TScrollBar;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Label48: TLabel;
    ComboBox2: TComboBox;
    procedure btnCreateWeatherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnGetWeatherClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeather: TfrmWeather;
  WEA  :TWeather;

implementation

uses
  uCloud, uWind, uBaseSimulationObject, uBaseDataType, uTurbulence,
  uBaseFunction, uBaseConstan;


{$R *.dfm}

procedure TfrmWeather.btnCreateWeatherClick(Sender: TObject);
begin
   WEA:=TWeather.Create(1);

end;

procedure TfrmWeather.FormCreate(Sender: TObject);
var ModelNum,I :Integer;
    StrWeather :String;
begin

  StringGrid2.Cells[1,0]:='X';
  StringGrid2.Cells[2,0]:='Y';
  StringGrid2.Cells[3,0]:='Z';
  StringGrid2.Cells[4,0]:='D';

  StringGrid2.RowCount:=2;
             //awan
  StringGrid3.Cells[1,0]:='X';
  StringGrid3.Cells[2,0]:='Y';
  StringGrid3.Cells[3,0]:='TOP';
  StringGrid3.Cells[4,0]:='BOTTOM';
  StringGrid3.Cells[5,0]:='DENSITY';
  StringGrid3.RowCount:=2;
  ModelNum   :=GetIntIni(FGLOBALWEATHER,'SUM','ModelNum',1);
  ComboBox1.Clear;
  for I:=1 to ModelNum do begin
      StrWeather:=GetStrIni(FGLOBALWEATHER,IntToStr(I),'Name','Nil');
      ComboBox1.Items.Add(StrWeather);
  end;

  ModelNum   :=GetIntIni(FTURBULENCE,'SUM','ModelNum',1);  //Turbulence
  ComboBox2.Clear;
  for I:=1 to ModelNum do begin
      StrWeather:=GetStrIni(FTURBULENCE,IntToStr(I),'Name','Nil');
      ComboBox2.Items.Add(StrWeather);
  end;

  Show;


end;

procedure TfrmWeather.Button4Click(Sender: TObject);
begin
{
  WEA.SetCloudVar(StrToInt(Edit12.Text),StrToInt(Edit13.Text),StrToInt(Edit14.Text),StrToInt(Edit15.Text),
  StrToInt(Edit16.Text),StrToInt(Edit17.Text),StrToInt(Edit18.Text),StrToInt(Edit19.Text));
}
end;

procedure TfrmWeather.Button5Click(Sender: TObject);
begin
{
  WEA.SetKerapatanTurbulence(StrToInt(Edit20.Text));
 }
end;

procedure TfrmWeather.Button3Click(Sender: TObject);
var C,I,J,K:Integer;
    CL:TCloud;
begin
 //wind : X,Y,Z,SPEED,HEIGHT
    For I := 0 to WEA.GlobWind.ObjectContainer.ItemCount-1 do
//        For J:= 0 to length (WEA.GlobWind.ObjectContainer.ListItem.Items[J].WindItem)do
        begin
        end;
end;

procedure TfrmWeather.btnGetWeatherClick(Sender: TObject);
var I,J:Integer;
    WindT:TWindLayer;
    TurbT:TTurbulenceItem;
    CloudT :TCloud;
    ItemCount :Integer;
begin
 WindT:=TWindLayer(WEA.GlobWind.ObjectContainer.ListItem.Items[1]);
 StringGrid1.ColCount:=length(WindT.WindItems)+4;
 StringGrid1.RowCount:=length(WindT.WindItems[1])+4;

 for I:=0 to length(WindT.WindItems)-1 do
     for J:=0 to length(WindT.WindItems[I])-1 do
         StringGrid1.Cells[I+2,J+2]:=IntToStr(WindT.WindItems[I,J].Direction)+':'+IntToStr(WindT.WindItems[I,J].Speed);

 ItemCount  := WEA.GlobTurbulance.ObjectContainer.ItemCount;
 Label36.Caption:=IntToStr(WEA.GlobTurbulance.Kerapatan);
 Label38.Caption:=IntToStr(WEA.GlobTurbulance.TurbNormalNumber);
 StringGrid2.RowCount:=ItemCount+3;
 for I:=0 to ItemCount-1 do
    begin
      TurbT:=WEA.GlobTurbulance.ObjectContainer.ListItem.Items[I];
      StringGrid2.Cells[0,I+2]:=IntToStr(I+1);
      StringGrid2.Cells[1,I+2]:=FloatToStr(TurbT.CenterX);
      StringGrid2.Cells[2,I+2]:=FloatToStr(TurbT.CenterY);
      StringGrid2.Cells[3,I+2]:=IntToStr(TurbT.Lower);
      StringGrid2.Cells[4,I+2]:=IntToStr(TurbT.Diameter);
      StringGrid2.Cells[5,I+2]:=DateTimeToStr(TurbT.ApprTime);
      StringGrid2.Cells[6,I+2]:=DateTimeToStr(TurbT.DisApprTime);
    end;
 ItemCount  := WEA.GlobClouds.ObjectContainer.ItemCount;
 StringGrid3.RowCount:=ItemCount+3;
 for I:=0 to ItemCount-1 do begin
     CloudT:=WEA.GlobClouds.ObjectContainer.ListItem.Items[I];
     StringGrid3.Cells[0,I+2]:=IntToStr(I+1);
     StringGrid3.Cells[1,I+2]:=FloatToStr(CloudT.Center.X);
     StringGrid3.Cells[2,I+2]:=FloatToStr(CloudT.Center.Y);
     StringGrid3.Cells[3,I+2]:=IntToStr(CloudT.Upper);
     StringGrid3.Cells[4,I+2]:=IntToStr(CloudT.Lower);
     StringGrid3.Cells[5,I+2]:=IntToStr(CloudT.Density);
     StringGrid3.Cells[6,I+2]:=FloatToStr(CloudT.Luas);
      case CloudT.Kind of
        0: StringGrid3.Cells[7,I+2]:='Cirrus';
        1: StringGrid3.Cells[7,I+2]:='Altos';
        2: StringGrid3.Cells[7,I+2]:='Stratus';
        3: StringGrid3.Cells[7,I+2]:='Nimbos';
        4: StringGrid3.Cells[7,I+2]:='Cumulus';
        5: StringGrid3.Cells[7,I+2]:='Cumulonimbus';
      end;


 end;

end;

procedure TfrmWeather.Button1Click(Sender: TObject);
var Spee,Dir:Integer;
    Pos  :tDouble3DPoint;
begin
    Pos.X:=StrToFloat(Edit22.Text);
    Pos.Y:=StrToFloat(Edit23.Text);
    Pos.Z:=StrToInt(Edit24.Text);

    WEA.GetWindFactor(Pos,Spee,Dir);
    Label31.Caption:='Dir   : '+IntToStr(Dir);
    Label32.Caption:='Speed : '+IntToStr(Spee);
end;

procedure TfrmWeather.Button2Click(Sender: TObject);
var Spee,Dir:Integer;
    Pos  :tDouble3DPoint;
    Cent:tDouble2DPoint;
    Tp,Bt,Dia:Integer;
begin
    Pos.X:=StrToFloat(Edit25.Text);
    Pos.Y:=StrToFloat(Edit26.Text);
    Pos.Z:=StrToInt(Edit27.text);

    WEA.GetTurbulence(Pos,Cent,Tp,Bt,Dia);
    Label37.Caption:='D :'+IntToStr(Dia)+' Top :'+IntToStr(Tp)+' Btm :'+IntToStr(Bt);
end;

procedure TfrmWeather.Button6Click(Sender: TObject);
var 
    PosF,PosT :tDouble3DPoint;
    Denst:Double;
begin
    PosF.X:=StrToFloat(Edit28.Text);
    PosF.Y:=StrToFloat(Edit29.Text);
    PosF.Z:=StrToInt(Edit30.text);
    PosT.X:=StrToFloat(Edit31.Text);
    PosT.Y:=StrToFloat(Edit32.Text);
    PosT.Z:=StrToInt(Edit33.text);
    Denst:=WEA.TotDensity(PosF,PosT);
    Label43.Caption:='Density :'+FloatToStr(Denst);
end;

procedure TfrmWeather.ComboBox1Change(Sender: TObject);
var WeatherItem:String;
     Val:Integer;
begin
   WeatherItem:=IntToStr(ComboBox1.ItemIndex+1);
   Edit1.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'Cirrus',5));
   Edit2.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'AltoStratus',5));
   Edit3.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'Stratus',4));
   Edit4.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'NimboStratus',2));
   Edit5.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'Cumulus',1));
   Edit6.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'CumuloNimbus',2));
   Edit7.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'Coverage',30));
   Val:=GetIntIni(FGLOBALWEATHER,WeatherItem,'Precipitation',30);
   if (Val>0)and (Val<11)then ScrollBar1.Position:=Val else ScrollBar1.Position:=0;
   Edit10.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'Temperature',30));
   Edit11.Text:=IntToStr(GetIntIni(FGLOBALWEATHER,WeatherItem,'PressureAtSL',30));
   ComboBox2.ItemIndex:=GetIntIni(FGLOBALWEATHER,WeatherItem,'Turbulence',1)-1;

   Edit8.Text:= IntToStr(GetIntIni(FWEATHER,'Wind','WindSpeedMin',0));
   Edit9.Text:=IntToStr(GetIntIni(FWEATHER,'Wind','WindSpeedMax',25));
   Edit34.Text:=IntToStr(GetIntIni(FWEATHER,'Wind','BottomLeast',0));
   Edit35.Text:=IntToStr(GetIntIni(FWEATHER,'Wind','TopMost',60000));
   Edit36.Text:=IntToStr(GetIntIni(FWEATHER,'Wind','HeightSlice',5000));
end;

procedure TfrmWeather.ScrollBar1Change(Sender: TObject);
begin
   Label44.Caption:='('+IntToStr(ScrollBar1.Position)+')';
end;

end.

