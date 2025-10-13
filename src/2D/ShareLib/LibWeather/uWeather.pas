{
Class Cuaca :
Class turbulence, turbulenceList, Awan dan AwanList.
Angin, AnginList ? -> Awan bergerak bersama angin dgn penyesuaian apa ? bobot awan ?
}
unit uWeather;
interface
uses uBaseDataType,uBaseSimulationObject,
     Math, uPtInRegion,uCloud, uTurbulence, uWind;


type

  TWeather = class (TSimulationClass)
  public
     W_UpLeft,W_BtmRight :tDouble2DPoint;
     W_Type           :Byte;
     W_Name           :String;
     W_Cirrus,W_AltoStratus,W_Stratus,W_NimboStratus,W_Cumulus,W_CumuloNimbus :Byte;
     W_Coverage       :Byte;

     W_Precipitation  :Byte;
     W_Turbulence     :Byte;
     W_Temperature    :Byte;
     W_PressureAtSeaLevel :Single;

     GlobWind       :TWind;
     GlobTurbulance :TTurbulence;
     GlobClouds     :TCloudList;
     //TopLeft, BottomRight  :tDouble2DPoint;
     constructor Create;overload;
     constructor Create(CreateType:Byte);overload;
     constructor Create(CreateType:Byte;TL,BR:tDouble2DPoint);overload;

     procedure Run(const aDeltaMs: double);    override;

     function GetTurbulence(PosXYZ:tDouble3DPoint; var TuCenter:tDouble2DPoint;
                            var TuTop,TuBottom,TuDiameter:Integer):Boolean;
     function TotDensity(FromPoint,ToPoint:tDouble3DPoint):Double; //->yg berhubungan dgn awan sementara ini,....
     procedure GetWindFactor(PosXYZ:tDouble3DPoint;var WSpeed,WDirection:Integer);

     procedure SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
     procedure SetCloudVar(Cirrus,AltoStratus,Stratus,NimboStratus,Cumulus,CumuloNimbus,Coverage,Precipitation:Byte);
     procedure NewLoad(CreateType:Byte);
     procedure SetKerapatanTurbulence(Rapat:Integer);

  end;

//var
    //GameUpLeft,GameBtRight:tDouble2DPoint;

implementation

uses
  uBaseConstan, uBaseFunction,SysUtils;

constructor TWeather.Create;
var I:Integer;
begin
  I:=GetIntIni(FGLOBALWEATHER,'SUM','ModelNum',1);
  Create(RandomRange(1,I));
end;

constructor TWeather.Create(CreateType:Byte);
begin
  inherited Create;

  W_UpLeft.X     :=GetIntIni(FWEATHER,'BOUNDARY','TOPLEFTX',90);
  W_UpLeft.Y     :=GetIntIni(FWEATHER,'BOUNDARY','TOPLEFTY',9);
  W_BtmRight.X   :=GetIntIni(FWEATHER,'BOUNDARY','BOTTOMRIGHTX',144);
  W_BtmRight.Y   :=GetIntIni(FWEATHER,'BOUNDARY','BOTTOMRIGHTY',-13);

  W_Type         :=CreateType;
  W_Name         :=GetStrIni(FGLOBALWEATHER,IntToStr(W_Type),'NAME','Untitled');
  W_Cirrus       :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Cirrus',4);
  W_AltoStratus  :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'AltoStratus',4);
  W_Stratus      :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Stratus',3);
  W_NimboStratus :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'NimboStratus',2);
  W_Cumulus      :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Cumulus',1);
  W_CumuloNimbus :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'CumuloNimbus',1);
  W_Coverage     :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Coverage',20);

  W_Precipitation      :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Precipitation',1);
  W_Turbulence         :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Turbulence',0);

  W_Temperature  :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'Temperature',23);
  W_PressureAtSeaLevel :=GetIntIni(FGLOBALWEATHER,IntToStr(W_Type),'PressureAtSL',2);

  GlobWind    :=  TWind.Create;
  GlobClouds  :=  TCloudList.Create(W_UpLeft,W_BtmRight, W_Cirrus,W_AltoStratus,
    W_Stratus,W_NimboStratus,W_Cumulus,W_CumuloNimbus,W_Coverage,W_Precipitation);

  GlobClouds.SetWindParent(GlobWind);

  GlobTurbulance:=TTurbulence.Create(W_UpLeft,W_BtmRight,W_Turbulence);

end;

constructor TWeather.Create(CreateType:Byte;TL,BR:tDouble2DPoint);
begin
  W_UpLeft  :=TL;
  W_BtmRight:=BR;
  Create(CreateType);
end;


procedure TWeather.Run(const aDeltaMs: double);
begin
  GlobWind.Run(aDeltaMs);
  GlobClouds.Run(aDeltaMs);
  GlobTurbulance.Run(aDeltaMs);

end;

function TWeather.GetTurbulence(PosXYZ:tDouble3DPoint; var TuCenter:tDouble2DPoint;
                                var TuTop,TuBottom,TuDiameter:Integer):Boolean;
var
  vTuCenter                     :tDouble2DPoint;
  vTuTop,vTuBottom,vTuDiameter  :Integer;
begin
  if GlobTurbulance.GetTurbulence(PosXYZ,vTuCenter,vTuTop,vTuBottom,vTuDiameter)then begin
            TuCenter  :=vTuCenter;
            TuTop     := vTuTop;
            TuBottom  :=vTuBottom;
            TuDiameter:=vTuDiameter;
            Result    :=True;
  end else  Result:=False;
end;

function TWeather.TotDensity(FromPoint,ToPoint:tDouble3DPoint):Double;
begin
  Result  :=GlobClouds.TotDensity(FromPoint,ToPoint);
end;

procedure TWeather.GetWindFactor(PosXYZ:tDouble3DPoint;var WSpeed,WDirection:Integer);
begin
  WSpeed      := GlobWind.GetSpeedAtPoint    (PosXYZ.X,PosXYZ.Y,Round(PosXYZ.Z));
  WDirection  := GlobWind.GetDirectionAtPoint(PosXYZ.X,PosXYZ.Y,Round(PosXYZ.Z));
end;

procedure TWeather.SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
begin
  GlobWind.SetBatasanH(Kiri_Atas,Kanan_Bawah);
  GlobClouds.SetBatasan(Kiri_Atas,Kanan_Bawah);
  GlobTurbulance.SetBatasan(Kiri_Atas,Kanan_Bawah);
end;

procedure TWeather.SetCloudVar(Cirrus,AltoStratus,Stratus,NimboStratus,Cumulus,CumuloNimbus,Coverage,Precipitation:Byte);
begin
   GlobClouds.SetAllVar(Cirrus,AltoStratus,Stratus,NimboStratus,Cumulus,CumuloNimbus,Coverage,Precipitation);
end;

procedure TWeather.SetKerapatanTurbulence(Rapat:Integer);
begin
    GlobTurbulance.SetKerapatan(Rapat);
end;

procedure TWeather.NewLoad(CreateType:Byte);
begin

end;

end.
