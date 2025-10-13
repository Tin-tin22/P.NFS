{Perhitungan gerakan dan perubahan speed dan arah 'kotak2' awan belum fix
 Metodenya yg perlu ditinjau lagi :D
 Bisa disederhanakan dengan hanya satu arah angin untuk satu tingkatan ketinggian
 }
unit uWind;
interface
uses
 Classes, Windows, Graphics,
 uBaseDataType,
 uBaseSimulationObject;

Type
  TWind     = class;
  TWindItem = record
                TopLeft, BottomRight  :tDouble2DPoint;
                Direction,Speed       :Integer;
              end;

  TWindLayer= class (TSimulationClass)
  public
      Parent        :TWind;
      WindItems     :array of array of TWindItem;
      TopLeft, BottomRight  :tDouble2DPoint;
      Top,Bottom    :Integer;
      SquareLength  :Double;//Panjang&Lebar sisi kotak pembagi
      constructor Create(TheParent:TWind;TL,BR:tDouble2DPoint;Square:Double;AvgSpd,WTop,WBottom:Integer);overload;
      procedure   SetBoundary(TL,BR:tDouble2DPoint;Square:Double);
//      procedure   SetDirection(X,Y,Dir:Integer);
//      procedure   SetSpeed(X,Y,Spd:Integer);
      function    GetDirectionAtPoint(Pos:tDouble2DPoint):Integer;
      function    GetSpeedAtPoint(Pos:tDouble2DPoint):Integer;
      procedure   RandomDirection;
      destructor  Destroy;
  end;

  TWind=class (TSimulationClass)
  public
    XCount,YCount :Integer;
    Parent        :TObject;
     TopMost,BottomLeast,HeightSlice        :Integer;
     WindSpeedMin,WindSpeedMax,SpeedDefault :Integer;
     SpeedDeviation,SpdChange,DirChange     :Integer;
    TopLeft, BottomRight  :tDouble2DPoint;
    SquareLength  :Double;//Panjang&Lebar sisi kotak pembagi
    TimerFactor,TimerCount   :Integer;
    function  GetDirectionAtPoint(X,Y:Double;Z:Integer) :Integer;
    function  GetSpeedAtPoint(X,Y:Double;Z:Integer)     :Integer;
    procedure RandomDirection;
    procedure CreateLayer(FromH,ToH,LayerH:Integer);
    procedure Run(const aDeltaMs: double);    override; //ngubah Speed dan Heading
    constructor Create;overload;
    constructor Create(TL,BR:tDouble2DPoint;Square:Double;SpFac:Byte);overload;
    constructor Create(TL,BR:tDouble2DPoint;Square:Double;SpFac:Byte;FromH,ToH,LayerH:Integer);overload;
    Procedure   SetBatasanH(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
    Procedure   SetBatasanV(Top,Bottom,Slice:Integer);
    procedure   SetBatasanSpeed(SpeedMin,SpeedMax,Default,Deviation,SpdCh,DirCh :Integer);
    procedure LoadIni;
  end;

implementation

uses Math, uBaseFunction, uBaseConstan;

constructor TWindLayer.Create(TheParent:TWind;TL,BR:tDouble2DPoint;Square:Double;AvgSpd,WTop,WBottom:Integer);
var I:Integer;
begin
  Inherited Create;
  Parent      :=TheParent;
  SetBoundary(TL,BR,Square);
  Top         :=WTop;
  Bottom      :=WBottom;
end;

procedure TWindLayer.SetBoundary(TL,BR:tDouble2DPoint;Square:Double);
var I:Integer;
begin
  TopLeft:=TL;
  BottomRight:=BR;
  SquareLength:=Square;
  SetLength(WindItems,Parent.XCount);
  for I:=0 to length(WindItems)-1 do
      SetLength(WindItems[I],Parent.YCount);
  RandomDirection();
end;
{
procedure TWindLayer.SetDirection(X,Y,Dir:Integer);
begin
   WindItems[X,Y].Direction:=Dir;
end;

procedure TWindLayer.SetSpeed(X,Y,Spd:Integer);
begin
   WindItems[X,Y].Speed:=Spd;
end;
}
function  TWindLayer.GetDirectionAtPoint(Pos:tDouble2DPoint):Integer;
var XInt,YInt:Integer;
begin
   XInt:=Floor(60*(Pos.X-TopLeft.X)/SquareLength);
   YInt:=Floor(60*(Pos.Y-BottomRight.Y)/SquareLength);
   try
   Result:=WindItems[XInt,YInt].Direction;
   except Result:=0;
   end;
end;

function  TWindLayer.GetSpeedAtPoint(Pos:tDouble2DPoint):Integer;
var XInt,YInt:Integer;
begin
   XInt:=Floor(60*(Pos.X-TopLeft.X)/SquareLength);
   YInt:=Floor(60*(Pos.Y-BottomRight.Y)/SquareLength);
   try
   Result:=WindItems[XInt,YInt].Speed;
   except Result:=0;
   end;
end;

procedure TWindLayer.RandomDirection;
{Belum FIX}
{random arah dan speed, berubah sedikit2, nggak tau efeknya nanti}
var I,J:Integer;
    PreSpeed,PreDir:Integer;
    NewSpeed,NewDir:Integer;
begin
  PreSpeed:=Parent.SpeedDefault;
  PreDir  :=Random(360);
  for I:=0 to length(WindItems)-1 do
     for J:=0 to length(WindItems[I])-1 do
     begin
         NewDir:=(abs(PreDir+RandomRange(-Parent.DirChange,Parent.DirChange)))mod 360;
         WindItems[I,J].Direction:=NewDir;
         PreDir:=NewDir;

         NewSpeed:=(abs(PreSpeed+RandomRange(-Parent.SpdChange,Parent.SpdChange)))mod (Parent.SpeedDefault+Parent.SpdChange);
         WindItems[I,J].Speed:=NewSpeed;
         PreSpeed:=NewSpeed;
     end;
end;

destructor TWindLayer.Destroy;
var I:Integer;
begin
  for I:=0 to length(WindItems)-1 do
      SetLength(WindItems[I],0);
  SetLength(WindItems,0);
  inherited;
end;

function  TWind.GetDirectionAtPoint(X,Y:Double;Z:Integer) :Integer;
var I  :Integer;
    TempWindL:TWindLayer;
    TempPoint:tDouble2DPoint;
BEGIN
    TempPoint.X:=X;
    TempPoint.Y:=Y;
    for I:=0 to ObjectContainer.ItemCount-1 do begin
      TempWindL:=ObjectContainer.ListItem.Items[I];
      if (Z>=TempWindL.Bottom) and (Z<=TempWindL.Top)then Break;
    end;
    Result:=TempWindL.GetDirectionAtPoint(TempPoint);
END;

function  TWind.GetSpeedAtPoint(X,Y:Double;Z:Integer)     :Integer;
var I  :Integer;
    TempWindL:TWindLayer;
    TempPoint:tDouble2DPoint;
BEGIN
    TempPoint.X:=X;
    TempPoint.Y:=Y;
    for I:=0 to ObjectContainer.ItemCount-1 do begin
      TempWindL:=ObjectContainer.ListItem.Items[I];
      if (Z>=TempWindL.Bottom) and (Z<=TempWindL.Top)then Break;
    end;
    Result:=TempWindL.GetSpeedAtPoint(TempPoint);
END;

procedure TWind.RandomDirection;
var I  :Integer;
    TempWindL:TWindLayer;
BEGIN
    for I:=0 to ObjectContainer.ItemCount-1 do begin
      TempWindL:=ObjectContainer.ListItem.Items[I];
      TempWindL.RandomDirection;
    end;
END;

procedure TWind.Run(const aDeltaMs: double); //ngubah Speed dan Heading
begin
  Inherited;
  
  TimerCount:=TimerCount+1;
  if TimerFactor=0 then  TimerCount:=0 else
  if TimerCount>=TimerFactor then begin
     RandomDirection;
     TimerCount:=0;
  end;
end;

constructor TWind.Create;
begin
   Inherited Create;
   LoadIni;
   //SquareLength:=100;
   TimerFactor:=1000;
   TimerCount:=0;
   TopLeft.X       :=GetIntIni(FWEATHER,'BOUNDARY','TOPLEFTX',90);
   TopLeft.Y       :=GetIntIni(FWEATHER,'BOUNDARY','TOPLEFTY',9);
   BottomRight.X   :=GetIntIni(FWEATHER,'BOUNDARY','BOTTOMRIGHTX',144);
   BottomRight.Y   :=GetIntIni(FWEATHER,'BOUNDARY','BOTTOMRIGHTY',-13);
   XCount:=abs(Ceil(60*(TopLeft.X-BottomRight.X)/SquareLength));
   YCount:=abs(Ceil(60*(TopLeft.Y-BottomRight.Y)/SquareLength));
   CreateLayer(BottomLeast,TopMost,HeightSlice);
end;

constructor TWind.Create(TL,BR:tDouble2DPoint;Square:Double;SpFac:Byte);
begin
   Inherited Create;
   LoadIni;
   TopLeft.X:=TL.X;
   TopLeft.Y:=TL.Y;
   BottomRight.X:=BR.X;
   BottomRight.Y:=BR.Y;
   SquareLength:=Square;
   SpeedDefault:=SpFac;
   TimerFactor:=1000;
   TimerCount:=0;
   XCount:=abs(Ceil((TopLeft.X-BottomRight.X)/Square));
   YCount:=abs(Ceil((TopLeft.Y-BottomRight.Y)/Square));
   CreateLayer(BottomLeast,TopMost,HeightSlice);
end;

constructor TWind.Create(TL,BR:tDouble2DPoint;Square:Double;SpFac:Byte;FromH,ToH,LayerH:Integer);
begin
   Inherited Create;
   TopLeft.X:=TL.X;
   TopLeft.Y:=TL.Y;
   BottomRight.X:=BR.X;
   BottomRight.Y:=BR.Y;
   SquareLength:=Square;
   SpeedDefault:=SpFac;
   TimerFactor:=1000;
   TimerCount:=0;
   CreateLayer(FromH,ToH,LayerH);
end;

procedure TWind.CreateLayer(FromH,ToH,LayerH:Integer);
var WindL:TWindLayer;
    I:Integer;
    TopLayer:Integer;
    WTop,WBottom:Integer;
begin
  WBottom       :=FromH;
 // ObjectContainer.CleanUpObject;
  repeat
       WTop     :=WBottom+LayerH;
       WindL    :=TWindLayer.Create(Self, TopLeft,BottomRight,SquareLength,SpeedDefault,WTop,WBottom);
       ObjectContainer.AddObject(WindL);
       WBottom  :=WTop;
  until WBottom >=ToH;
end;

Procedure   TWind.SetBatasanH(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
begin
   TopLeft.X      :=Kiri_Atas.X;
   TopLeft.Y      :=Kiri_Atas.Y;
   BottomRight.X  :=Kanan_Bawah.X;
   BottomRight.Y  :=Kanan_Bawah.Y;
    //Destroy semua layer
      //yo' opo carane,..... ? :((

   XCount:=abs(Ceil((TopLeft.X-BottomRight.X)/SquareLength));
   YCount:=abs(Ceil((TopLeft.Y-BottomRight.Y)/SquareLength));
   CreateLayer(BottomLeast,TopMost,HeightSlice);
end;

Procedure   TWind.SetBatasanV(Top,Bottom,Slice:Integer);
//<0 berarti TETAP nilai yg lama
begin
   if Top>0     then TopMost        := Top;
   if Bottom>0  then BottomLeast    := Bottom;
   if Slice>0   then HeightSlice    := Slice;
    //Destroy semua layer
      //yo' opo carane,..... ? :((

   CreateLayer(BottomLeast,TopMost,HeightSlice);
end;

procedure   TWind.SetBatasanSpeed(SpeedMin,SpeedMax,Default,Deviation,SpdCh,DirCh :Integer);
//<0 berarti TETAP nilai yg lama
begin
//Tidak perlu di reload, nunggu update berikutnya aja,....
   if SpeedMin>0   then WindSpeedMin   := SpeedMin;
   if SpeedMax >0  then WindSpeedMax   := SpeedMax;
   if Default >0   then SpeedDefault   := Default;
   if Deviation >0 then SpeedDeviation := Deviation;
   if SpdCh >0     then SpdChange      := SpdCh;
   if DirCh >0     then DirChange      := DirCh;
end;

procedure TWind.LoadIni;
begin
   SquareLength   :=GetIntIni(FWEATHER,'wind','SquareLength',100);
   TopMost        := GetIntIni(FWEATHER,'wind','TopMost',50000);
   BottomLeast    := GetIntIni(FWEATHER,'wind','BottomLeast',0);
   HeightSlice    := GetIntIni(FWEATHER,'wind','HeightSlice',10);
   WindSpeedMin   := GetIntIni(FWEATHER,'wind','WindSpeedMin',5);
   WindSpeedMax   := GetIntIni(FWEATHER,'wind','WindSpeedMax',60);
   SpeedDefault   := GetIntIni(FWEATHER,'wind','SpeedDefault',25);
   SpeedDeviation := GetIntIni(FWEATHER,'wind','SpeedDefault',10);
   SpdChange      := GetIntIni(FWEATHER,'wind','SpdChange',5);
   DirChange      := GetIntIni(FWEATHER,'wind','DirChange',5);
end;


end.
