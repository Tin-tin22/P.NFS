unit uCloud;
{
  Bentuk dasar diambil dari kumpulan titik2 dgn posisi relatif thd titik Center
  dengan ada faktor pengali u/ ukuran
  Kemampuan : - Gerak berdasarkan arah dan kecepatan angin
              - Sesuai jenisnya dapat menjatuhkan hujan dengan volume dan speed tertentu
              - Menghalangi 'pandangan' radar dengan nilai tertentu (sesuai jenis dan ketebalan)
}

interface
uses
  Classes, Windows, Graphics,
  uBaseDataType,
  uBaseSimulationObject,Math,DB,DBTables,
  uTurbulence;

const
  C_Cirrus      =0;
  C_AltoS       =1;
  C_Stratus     =2;
  C_NimboS      =3;
  C_Cumulus     =4;
  C_Cumulonimbus=5;
  BaseCloudX:array [0..7]of Double=(-0.5,-0.25, 0  , 0.25,0.5,0.25,0  ,-0.25);//derajad Lat/Long
  BaseCloudY:array [0..7]of Double=( 0  ,-0.25,-0.5,-0.25,0  ,0.25,0.5, 0.25);//Luas Default =1

Type

  TCloudVar = record
        HeightFrom,HeightTo	    :Integer;
        ThickFrom,ThickTo		    :Integer;
        FactorFrom,FactorTo	    :Integer;
        WaterVlFrom,WaterVolTo  :Integer;
        DensityFrom,DensityTo	  :Integer;
        Turbulence	            :Byte;
        MaxFlowSpd              :Integer;
  end;

  TCloudList=class;

  TCloud=class (TSimulationClass)
  public
    Parent            :TCloudList;
    TL,BR             :tDouble2DPoint;//Batasan REAL awan
    Luas              :Double;
    Center            :tDouble2DPoint;//Titik 0,0 relatif
    PointList         :Array of tDouble2DPoint;
    Upper,Lower       :Integer;
    Kind              :Byte; //Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus
    Density           :Byte;
    Precipitation	    :Byte;
    Factor            :Single;//Berapa kali lebih besar dari point list
    WindSpeed         :Integer;
    WindHeading       :Integer;

    MaxFlowSpeed      :Integer;//Liter/menit/m2 ?,...
       WaterVolume    :Single; //Punya RainCloud Taruh sini aja dulu
       FlowSpeed      :Integer;//Liter/menit/m2 ?,...
    CloudTurbulence   :TTurbulence;
    WithTurbulence    :Boolean;
    constructor Create(TheParent:TCloudList; ToL,BoR:tDouble2DPoint);overload;
    constructor Create(TheParent:TCloudList;ToL,BoR:tDouble2DPoint;TKind,Percipt:Byte);overload;
    procedure DefaultPoint;
    procedure Make(PointInsert:Array of tDouble2DPoint;Fact:Single);  //hanya model titik2nya saja
    procedure LoadFromFile(FName:String);//Bentuknya aja
    function  GetDensity(FromPoint,ToPoint:tDouble3DPoint):Double;overload;
    function  GetDensity(FromPoint,ToPoint:tDouble3DPoint;BearingPoint:Double):Double;overload;
    procedure SetWindFactor(Speed,Heading:Integer);
    procedure SetRainFactor(WVolume,FSpeed:Integer);
    procedure Run(const aDeltaMs: double);    override;
    Procedure SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
    Function  GetWindSpeed  :Integer;
    Function  GetWindHeading:Integer;

//    destructor Destroy; override; //Kalo diluar area, dihapus aja,....

  end;


  TCloudList=class (TSimulationClass)
  public
    //CloudItems :Array of TCloud;
    WindParent      :TObject;
    TimeCount       :Integer;
    TopLeft, BottomRight  :tDouble2DPoint;

    constructor Create(TopLeft, BottomRight:tDouble2DPoint); overload;
    constructor Create(TopLeft, BottomRight:tDouble2DPoint;WeatherType:Byte);overload;
    constructor Create(TL,BR:tDouble2DPoint;Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus:Byte);overload;
    constructor Create(TL,BR:tDouble2DPoint;Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus,Coverage,Percipt:Byte);overload;
    procedure   Run(const aDeltaMs: double);    override;
    function    TotDensity(FromPoint,ToPoint:tDouble3DPoint):Double;
    procedure   SetWindParent(TheParent:TObject);
    Procedure   SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
    Procedure   SetAllVar(Cirrus,AltoStratus,Stratus,NimboStratus,Cumulus,CumuloNimbus,Coverage,Precipitation:Byte);
   end;

    procedure InitCloudsVar;

   var
     clCirrus,clAltos,clStratus,clNimbos,clCumulus,clCumulonimbus:TCloudVar;
     CloudModels  :array of String;

implementation

uses SysUtils,IniFiles, uWeather, uBaseFunction, uWind, uPtInRegion,
  uBaseConstan;

constructor TCloud.Create(TheParent:TCloudList;ToL,BoR:tDouble2DPoint);
begin
   Create(TheParent,ToL,BoR,RandomRange(0,5),Random(5));
end;

constructor TCloud.Create(TheParent:TCloudList;ToL,BoR:tDouble2DPoint;TKind,Percipt:Byte);
var CTypeUse:TCloudVar;
    CloudModelCount:Integer;
    CloudModelUse:Integer;
begin
  case TKind of
    C_Cirrus        : CTypeUse:=clCirrus;
    C_AltoS         : CTypeUse:=clAltos;
    C_Stratus       : CTypeUse:=clStratus;
    C_NimboS        : CTypeUse:=clNimbos;
    C_Cumulus       : CTypeUse:=clCumulus;
    C_Cumulonimbus  : CTypeUse:=clCumulonimbus;
  end;
 with CTypeUse do
 begin
    Center.X        :=ToL.X + abs(BoR.X-ToL.X)*Random;//->Cek lagi ttg model XY
    Center.Y        :=BoR.Y + abs(ToL.Y-BoR.Y)*Random;//->Cek lagi ttg model XY
    Lower           :=HeightFrom + round((HeightTo-HeightFrom)*Random);
    Upper           :=Lower + ThickFrom + round((ThickTo-ThickFrom)*Random);
    Kind            :=TKind ;
    Density         :=DensityFrom + round((DensityTo-DensityFrom)*Random);
    Factor          :=FactorFrom + (FactorTo-FactorFrom)*Random;
    WaterVolume     :=WaterVlFrom + round((WaterVolTo-WaterVlFrom)*Random);
    CloudModelCount :=GetIntIni(FWEATHER,'models','ModelCount',1);
    CloudModelUse   :=RandomRange(1,CloudModelCount);
    LoadFromFile(FWEATHERPATH + GetStrIni(FWEATHER,'models',IntToStr(CloudModelUse),
      FWEATHERPATH+'point1.ini'));
{    if (Turbulence>0) then
      CloudTurbulence.Create(TL,BR,Lower,Upper);
    CloudTurbulence.SetWindParent(Self);
}
    if (Turbulence>0) then begin
      CloudTurbulence:=TTurbulence.Create(TL,BR,Lower,Upper);//TL dan BR-nya Awan Sendiri
      CloudTurbulence.SetWindParent(Self);
    end;
    MaxFlowSpeed    :=MaxFlowSpd;
    Precipitation   :=Percipt;
    if WaterVolume>0 then FlowSpeed:=Random(Round(MaxFlowSpeed*Precipitation/10));
 end;
// Luas := 1;

end;


procedure TCloud.Make(PointInsert:Array of tDouble2DPoint;Fact:Single);
var I   :Integer;
begin
  SetLength(PointList,length(PointInsert));
  TL:=Center;
  BR:=Center;
  For I:=0 to length(PointInsert)-1 do begin
     PointList[I].X:=Center.X+PointInsert[I].X*Fact;
     PointList[I].Y:=Center.Y+PointInsert[I].Y*Fact;
     if PointList[I].X<TL.X then TL.X:=PointList[I].X;
     if PointList[I].X>BR.X then BR.X:=PointList[I].X;
     if PointList[I].Y>TL.Y then TL.X:=PointList[I].Y;
     if PointList[I].Y<BR.Y then BR.X:=PointList[I].Y;
  end;
  Luas:=1;
end;

procedure TCloud.DefaultPoint;
var
    PointArr:Array of tDouble2DPoint;
    I:Integer;
begin
   setLength(PointArr,8);
   for I:=0 to length(PointArr)-1 do begin
      PointArr[I].X:=BaseCloudX[I];
      PointArr[I].Y:=BaseCloudY[I];
   end;
   Make(PointArr,Factor);
end;


procedure TCloud.LoadFromFile(FName:String);
var
  I: Integer;
  XLATT,XLONG:Double;
  TotalPoint:Integer;
var IniF:TIniFile;
begin
    if FileExists(FName)then
    try
      begin
        TL.X :=  1000000.0;
        TL.Y := -1000000.0;

        BR.X :=  -1000000.0;
        BR.Y :=   1000000.0;

        SetLength(PointList,0);
        IniF      := TIniFile.Create(FName);
        TotalPoint:= IniF.ReadInteger('VAR','TOTALPOINT',0);
        if TotalPoint>2 then begin
           SetLength(PointList,TotalPoint);
           for I:= 0 to TotalPoint-1 do begin
            XLATT  := IniF.ReadFloat(IntToStr(I+1),'LAT' ,1);
            XLONG  := IniF.ReadFloat(IntToStr(I+1),'LONG',1);
            PointList[i].X:=XLONG;
            PointList[i].Y:=XLATT;

            if XLONG < TL.X then  TL.X:=XLONG;
            if XLONG > BR.X then  BR.X:=XLONG;

            if XLATT > TL.Y then TL.Y  := XLATT;
            if XLATT < BR.Y then BR.Y  := XLATT;

           end;
           Luas:=ABS((TL.X-BR.X)*(TL.Y-BR.Y));//Luas asli file ini
           TL:=Center;
           BR:=Center;
           if Luas < 0.0000000000001 then
             Luas := 1.0;
           for I:= 0 to Length(PointList)-1 do begin
              PointList[I].X:=Center.X+PointList[I].X*Factor/Luas; //anggapan luas file ini=1 nm2
              PointList[I].Y:=Center.Y+PointList[I].Y*Factor/Luas;
              if PointList[I].X<TL.X then  TL.X:=PointList[I].X;
              if PointList[I].X>BR.X then  BR.X:=PointList[I].X;
              if PointList[I].Y>TL.Y then  TL.Y:=PointList[I].Y;
              if PointList[I].Y<BR.Y then  BR.Y:=PointList[I].Y;
           end;
           Luas:=Luas * Factor*Factor;//Luas asli file ini

        end else DefaultPoint;
      end;
    except
      DefaultPoint;
    end;
//   IniF.Free;
end;

function  TCloud.GetDensity(FromPoint,ToPoint:tDouble3DPoint):Double;
var Bear :Double;
begin
  Bear:= CalcBearing(FromPoint.X,FromPoint.Y,ToPoint.X,ToPoint.Y);
  result:=GetDensity(FromPoint,ToPoint,Bear);
end;

function  TCloud.GetDensity(FromPoint,ToPoint:tDouble3DPoint;BearingPoint:Double):Double;
var
    BearingAwan :Double;
    Tp,Btm      :Double;
    P0,P1,P2    :tDoublePoint;
    I           :Integer;
    Kiri,Kanan  :Boolean;//Jika garis 2D (X,Y) From ke To masuk ke Region
    R           :Double;
begin
 //Cari total jarak yg melewati awan pada posisi tsb  kalikan dengan variable Density
 //1. Cari yg Bearing 2D FromPoint ke pusat awan dan ToPoint apakah <  Toleransi
   BearingAwan:= CalcBearing(FromPoint.X,FromPoint.Y,Center.X,Center.Y);
   if abs(BearingAwan-BearingPoint)<10 then begin


     if FromPoint.Z<ToPoint.Z then begin
        Btm:=FromPoint.Z; Tp:=ToPoint.Z;
     end else begin
        Btm:=ToPoint.Z; Tp:=FromPoint.Z;
     end;
     if ((Btm>Upper)and(Tp>Upper))or((Btm<Lower)and(Tp<Lower))then result:=0 else{semua diatas atau semua dibawah}
     begin
         I:=0;
         Kiri:=False;
         P0.X:=FromPoint.X; P0.Y:=FromPoint.Y;
         P2.X:=ToPoint.X; P2.Y:=ToPoint.Y;
         while ((I<Length(PointList)-1) and (not Kiri) )do begin
            P1.X:=PointList[I].X;
            P1.Y:=PointList[I].Y;
            if FN_CCW(P0,P1,P2)=1 then Kiri:=True;
            I:=I+1;
         end;
         Kanan:=False;
         if Kiri then
         while (I<Length(PointList)-1) and (not Kanan) do begin
            P1.X:=PointList[I].X;
            P1.Y:=PointList[I].Y;
            if FN_CCW(P0,P1,P2)=-1 then Kanan:=True;
            I:=I+1;
         end else result:=0;
         if Kiri and Kanan then begin
         {Garis melintasi/di dalam polygon 2D}
            R:=Range3D(FromPoint.X,FromPoint.Y,FromPoint.Z,ToPoint.X,ToPoint.Y,ToPoint.Z);//NM
            Result:=Density*(Upper-Lower)*R/(Tp-Btm); {Density * Jarak dalam NM}
         end else result:=0;
     end;
   end else result:=0;
end;

procedure TCloud.SetWindFactor(Speed,Heading:Integer);
begin
  WindSpeed   :=Speed;
  WindHeading :=Heading;
end;

procedure TCloud.SetRainFactor(WVolume,FSpeed:Integer);
begin
  WaterVolume :=WVolume;
  FlowSpeed   :=FSpeed;
end;

procedure TCloud.Run(const aDeltaMs: double);
var TimeHour   :Double;
    TimeMinute :Double;
begin
 TimeHour     :=aDeltaMs/(1000*3600);
 WindSpeed    :=TWind(Parent.WindParent).GetSpeedAtPoint(Center.X,Center.Y,Upper);
 WindHeading  :=TWind(Parent.WindParent).GetDirectionAtPoint(Center.X,Center.Y,Upper);

 NextPost2D(Center.X,Center.Y,WindSpeed,WindHeading,aDeltaMs/3600000,Center.X,Center.Y);

 if Center.X<TL.X then  Center.X:=BR.X;
 if Center.X>BR.X then  Center.X:=TL.X;
 if Center.Y>TL.Y then  Center.Y:=BR.Y;
 if Center.Y<BR.X then  Center.Y:=TL.Y;

 TimeMinute:=aDeltaMs/(1000*60);
 if WaterVolume>0 then begin
  WaterVolume:=WaterVolume-FlowSpeed*TimeMinute; //sama2 per m2 luasan
  FlowSpeed:=Random(Round(MaxFlowSpeed*Precipitation/10));
 end else FlowSpeed:=0;

end;

Procedure TCloud.SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
begin
  TL:=Kiri_Atas;
  BR:=Kanan_Bawah;
end;


Function  TCloud.GetWindSpeed  :Integer;
begin
   Result:=WindSpeed;
end;

Function  TCloud.GetWindHeading:Integer;
begin
   Result:=WindHeading;
end;

///////////C L O U D  L I S T /////////////////////////////////

constructor TCloudList.Create(TL, BR:tDouble2DPoint;Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus:Byte);
begin
  inherited Create;
  Create(TL,BR,Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus,random(30),Random(5));
end;

constructor TCloudList.Create(TL,BR:tDouble2DPoint;Cirrus,AltoS,Stratus,NimboS,Cumulus,Cumulonimbus,Coverage,Percipt:Byte);
var CreateCloud:TCloud;
    Total:Integer;
    TotCoverage,GameCoverage:Double;
    TPos,ClType:Byte;
    V:array [0..5]of Byte;
begin
   inherited Create;

   BottomRight:=BR;
   TopLeft    :=TL;
   GameCoverage:= abs((BottomRight.X-TopLeft.X)*(TopLeft.Y-BottomRight.Y));
   TotCoverage:=0;
   V[0]:=Cirrus;        V[1]:=V[0]+AltoS;
   V[2]:=V[1]+Stratus;  V[3]:=V[2]+NimboS;
   V[4]:=V[3]+Cumulus;  V[5]:=V[4]+Cumulonimbus;
   Total:=Cirrus+AltoS+Stratus+NimboS+Cumulus+Cumulonimbus;
   repeat
     TPos:=RandomRange(1,Total);
     if TPos<V[0] then ClType:=0 else if TPos<V[1] then ClType:=1 else
     if TPos<V[2] then ClType:=2 else if TPos<V[3] then ClType:=3 else
     if TPos<V[4] then ClType:=4 else ClType:=5;
     CreateCloud:=TCloud.Create(Self, TopLeft,BottomRight, ClType,Percipt);
//??a??
//     CreateCloud.Luas := 1;

     ObjectContainer.AddObject(CreateCloud);

     TotCoverage:=TotCoverage+CreateCloud.Luas;

   until TotCoverage>=(GameCoverage*Coverage/100);
end;

constructor TCloudList.Create(TopLeft, BottomRight:tDouble2DPoint);
begin
end;

constructor TCloudList.Create(TopLeft, BottomRight:tDouble2DPoint;WeatherType:Byte);
begin
end;

procedure TCloudList.Run(const aDeltaMs: double);
begin
   TimeCount:=TimeCount+1;
   if TimeCount>10 then begin //10 kali baru update :D
     ObjectContainer.RunAllMemberObject(10*aDeltaMs);

     TimeCount:=0;
   end;
end;

function  TCloudList.TotDensity(FromPoint,ToPoint:tDouble3DPoint):Double;
var I:Integer;
    Total:Double;
    Cl:TCloud;
    Bearing :Double;

begin
  Bearing:=CalcBearing(FromPoint.X,FromPoint.Y,ToPoint.X,ToPoint.Y);
//Hitung density dari FromPoint ke ToPoint berdasarkan posisi semua awan
  Total:=0;
  for I:=0 to ObjectContainer.ItemCount-1 do begin
     Cl:=ObjectContainer.ListItem.Items[i];
     Total:=Total+Cl.GetDensity(FromPoint,ToPoint,Bearing);
  end;
  Result:=Total;   {Density * Jarak dalam NM}
end;

Procedure   TCloudList.SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
var Cl:TCloud;
    I:Integer;
begin
   TopLeft     :=Kiri_Atas;
   BottomRight :=Kanan_Bawah;
   for I:=0 to ObjectContainer.ItemCount-1 do begin
       Cl:=ObjectContainer.ListItem.Items[i];
       Cl.SetBatasan(TopLeft,BottomRight);
   end;
end;

Procedure   TCloudList.SetAllVar(Cirrus,AltoStratus,Stratus,NimboStratus,Cumulus,CumuloNimbus,Coverage,Precipitation:Byte);
var CreateCloud:TCloud;
    Total:Integer;
    TotCoverage,GameCoverage:Double;
    TPos,ClType:Byte;
    V:array [0..5]of Byte;
begin
//Clear Semua Awan dari Object Container
//Gimana caranya ? :((
//Buat lagi
   GameCoverage:= abs((BottomRight.X-TopLeft.X)*(TopLeft.Y-BottomRight.Y));
   TotCoverage:=0;
   V[0]:=Cirrus;        V[1]:=V[0]+AltoStratus;
   V[2]:=V[1]+Stratus;  V[3]:=V[2]+NimboStratus;
   V[4]:=V[3]+Cumulus;  V[5]:=V[4]+Cumulonimbus;
   Total:=Cirrus+AltoStratus+Stratus+NimboStratus+Cumulus+Cumulonimbus;
   repeat
     TPos:=RandomRange(1,Total);
     if TPos<V[0] then ClType:=0 else if TPos<V[1] then ClType:=1 else
     if TPos<V[2] then ClType:=2 else if TPos<V[3] then ClType:=3 else
     if TPos<V[4] then ClType:=4 else ClType:=5;
     CreateCloud:=TCloud.Create(Self, TopLeft,BottomRight, ClType,Precipitation);
     ObjectContainer.AddObject(CreateCloud);
     TotCoverage:=TotCoverage+CreateCloud.Luas;
   until TotCoverage>=(GameCoverage*Coverage/100);

end;

procedure   TCloudList.SetWindParent(TheParent:TObject);
begin
    WindParent:=TheParent;
end;


procedure InitCloudsVar;
var IniF:TIniFile;
  procedure LOad(var CloudType:TCloudVar;IniTxt:String);
  begin
      CloudType.HeightFrom  :=IniF.ReadInteger(IniTxt,'HeightFrom'  ,0);
      CloudType.HeightTo    :=IniF.ReadInteger(IniTxt,'HeightTo'    ,6500);
      CloudType.ThickFrom   :=IniF.ReadInteger(IniTxt,'ThickFrom'   ,1);
      CloudType.ThickTo     :=IniF.ReadInteger(IniTxt,'ThickTo'     ,2);
      CloudType.FactorFrom  :=IniF.ReadInteger(IniTxt,'FactorFrom'  ,1);
      CloudType.FactorTo    :=IniF.ReadInteger(IniTxt,'FactorTo'    ,3);
      CloudType.WaterVlFrom :=IniF.ReadInteger(IniTxt,'WaterVolFrom',0);
      CloudType.WaterVolTo  :=IniF.ReadInteger(IniTxt,'WaterVolTo'  ,1);
      CloudType.DensityFrom :=IniF.ReadInteger(IniTxt,'DensityFrom' ,1);
      CloudType.DensityTo   :=IniF.ReadInteger(IniTxt,'DensityTo'   ,1);
      CloudType.Turbulence  :=IniF.ReadInteger(IniTxt,'Turbulence'  ,0);
      CloudType.MaxFlowSpd  :=IniF.ReadInteger(IniTxt,'MaxFlowSpeed',0);
  end;
begin
  IniF := TIniFile.Create(FWEATHER);
  LOad(clCirrus,      'C_Cirrus');
  LOad(clAltos,       'C_AltoS');
  LOad(clStratus,     'C_Stratus');
  LOad(clNimbos,      'C_NimboS');
  LOad(clCumulus,     'C_Cumulus');
  LOad(clCumulonimbus,'C_Cumulonimbus');

  IniF.Free;
end;

initialization
begin
  InitCloudsVar;
end;


end.
