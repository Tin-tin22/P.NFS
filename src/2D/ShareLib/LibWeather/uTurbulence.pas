unit uTurbulence;
{ Setting Kerapatan Turbulence hanya berhubungan dgn banyak turbulence aja,
  bukan dgn diameter dan waktu kemunculan }

interface
  uses
    Classes, Windows, Graphics, SysUtils, Math, DB, DBTables,
    uBaseDataType, uBaseSimulationObject
     ;

type

//==============================================================================
  TTurbulenceItem = class (TSimulationClass)
  {Turbulence dibuat didalam regional batasan dgn jumlah sesuai dgn kerapatannya
   Bentuknya tabung, ligkaran dgn ketinggian tertentu}
  public
    CenterX,CenterY       :Double;
    Upper,Lower           :Integer;
    Diameter              :Integer; //(dalam Feet ?)
    ApprTime,DisApprTime  :TDateTime;//waktu simulasi
    IsTimeToDead          :Boolean;
    constructor Create(TopLeft, BottomRight:tDouble2DPoint); overload;

    procedure RandomPosition(TopLeft, BottomRight:tDouble2DPoint);
    procedure SetPosition(X,Y:Double;Bt,Up:Integer);
    procedure SetAppearance(Appr,DisAppr:Double);   //??? Gae opo :D aku lali
    procedure Run(const aDeltaMs: double); override;
  end;

//==============================================================================
  TTurbulence = class (TSimulationClass)
  public
    WindFactorParent      :TObject; //Kalo u/ weather=TWind, kalo u/ Awan=TAwan
    Name                  :String;
    DMaxTurb,DMinTurb,TMaxTurb,TMinTurb,HMaxTurb,HMinTurb:Integer;
    TimeMaxT,TimeMinT     :Double;
    KiriAtas, KananBawah  :tDouble2DPoint;
    Hmin,HMax             :Integer;
    Kerapatan             :Byte;
    TurbNormalNumber      :Integer; //Jumlah rata2 sesuai kerapatan

    constructor Create(Kiri_Atas, Kanan_Bawah:tDouble2DPoint;Num:Integer);overload;

    constructor Create(Kiri_Atas, Kanan_Bawah:tDouble2DPoint;H_Min,H_Max:Integer); overload;
    procedure BuatAllTurbulence;//Buat yg baru, yg lama dihapus semua dulu
    procedure CreateItem;
    procedure Delete(Pos:Integer);//Sebenarnya hanya pindah posisi dan ubah variable aja

    procedure DeleteAndMake;//Sesuai batasan jumlah turbulence, buat keputusan :Make,Delete or Abstaint :D
    procedure Run(const aDeltaMs: double); override;
    procedure GetFromIni(Fname,Section:String);
    procedure SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
    function  GetTurbulence(PosXYZ:tDouble3DPoint; var TuCenter:tDouble2DPoint;
                                  var TuTop,TuBottom,TuDiameter:Integer):Boolean;
    procedure SetKerapatan(Rapat:Integer);
    procedure SetWindParent(TheParent:TObject);

  end;


implementation

  uses
    uBaseFunction, uWind, uCloud, uBaseConstan;


  constructor TTurbulenceItem.Create(TopLeft, BottomRight:tDouble2DPoint);
  begin
     IsTimeToDead:=False;
     RandomPosition(TopLeft, BottomRight);
     inherited Create;
  end;

  procedure TTurbulenceItem.RandomPosition(TopLeft, BottomRight:tDouble2DPoint);
  begin
    CenterX :=TopLeft.X + (BottomRight.X-TopLeft.X)*Random;//->Cek lagi ttg model XY
    CenterY :=TopLeft.Y + (BottomRight.Y-TopLeft.Y)*Random;//->Cek lagi ttg model XY
  end;

  procedure TTurbulenceItem.SetPosition(X,Y:Double;Bt,Up:Integer);
  begin
    CenterX:=X;CenterY:=Y;
    if Bt>0 then Lower:=Bt;
    if Up>0 then Upper:=Up;

  end;
  procedure TTurbulenceItem.SetAppearance(Appr,DisAppr:Double);
  begin
     ApprTime     :=Appr;
     DisApprTime  :=DisAppr;
  end;

  procedure TTurbulenceItem.Run(const aDeltaMs: double);
  begin
     IsTimeToDead:=(DisApprTime<=Now);
  end;

//==============================================================================
  constructor TTurbulence.Create(Kiri_Atas, Kanan_Bawah:tDouble2DPoint;Num:Integer);
  var Luas:Double;
  begin
     inherited Create;

     KiriAtas   :=Kiri_Atas;
     KananBawah :=Kanan_Bawah;
     GetFromIni(FTURBULENCE,IntToStr(Num));
     Luas:=abs((KiriAtas.X-KananBawah.X)*(KiriAtas.Y-KananBawah.Y))*60;//nm2
     TurbNormalNumber:=Ceil(Luas*Kerapatan/10000);
     BuatAllTurbulence;
  end;

  constructor TTurbulence.Create(Kiri_Atas, Kanan_Bawah:tDouble2DPoint;H_Min,H_Max:Integer);
  var Luas:Double;
  begin
     inherited Create;
     KiriAtas   :=Kiri_Atas;
     KananBawah :=Kanan_Bawah;
     GetFromIni(FWEATHER,'CloudTurbulence');
     Hmin       :=H_Min;
     HMax       :=H_Max;
     Luas:=abs((KiriAtas.X-KananBawah.X)*(KiriAtas.Y-KananBawah.Y))*60;//nm2
     TurbNormalNumber:=Ceil(Luas*Kerapatan/10000);

     BuatAllTurbulence;
     Inherited Create;
  end;

  procedure TTurbulence.BuatAllTurbulence;
  var I:Integer;
  begin
      for I:= 0 to TurbNormalNumber-1 do begin
         CreateItem;
      end;
      //->Create semua turbulence sesuai jumlah
  end;

  procedure TTurbulence.Delete(Pos:Integer);
  begin
        ObjectContainer.RemoveObjectIndex(Pos);
  end;

  procedure TTurbulence.DeleteAndMake;
  var I,Num:Integer;
      TurbCurrent:TTurbulenceItem;
  begin
     for I:=0 to ObjectContainer.ItemCount-1 do begin
        TurbCurrent:=ObjectContainer.ListItem.Items[I];
        if TurbCurrent.IsTimeToDead then ObjectContainer.RemoveObject(TurbCurrent);// Delete(I);
     end;
     Num:=RandomRange(-3,3)+TurbNormalNumber-ObjectContainer.ItemCount;
     for I:=0 to Num-1 do CreateItem;
  end;

  procedure TTurbulence.Run(const aDeltaMs: double);
  var I:Integer;
      V_pergerakan,H_pergerakan :Integer;
      T_Item :TTurbulenceItem;
      NewX,NewY:Double;
  begin
     Inherited;
     DeleteAndMake;
     if WindFactorParent is TWind then begin//jika bukan punya awan
     for I:=0 to ObjectContainer.ItemCount-1 do begin
         T_Item:=ObjectContainer.ListItem.Items[I];
         V_pergerakan:=TWind(WindFactorParent).GetSpeedAtPoint(T_Item.CenterX,T_Item.CenterY,T_Item.Upper);
         H_pergerakan:=TWind(WindFactorParent).GetDirectionAtPoint(T_Item.CenterX,T_Item.CenterY,T_Item.Upper);
         //Kemudian tentukan posisi baru,.....
         NextPost2D(T_Item.CenterX,T_Item.CenterY,V_pergerakan,H_pergerakan,aDeltaMs/3600000,NewX,NewY);
         //SetPosition(X,Y,T_Item.Bt,T_Item.Up);
         T_Item.SetPosition(NewX,NewY,-1,-1);//-1= Tetep gak berubah
     end;  end else begin //Jika Punya awan
         V_pergerakan:=TCloud(WindFactorParent).GetWindSpeed;
         H_pergerakan:=TCloud(WindFactorParent).GetWindHeading;
         for I:=0 to ObjectContainer.ItemCount-1 do begin
             T_Item:=ObjectContainer.ListItem.Items[I];
             //Kemudian tentukan posisi baru,.....
             NextPost2D(T_Item.CenterX,T_Item.CenterY,V_pergerakan,H_pergerakan,aDeltaMs/3600000,NewX,NewY);
             //SetPosition(X,Y,T_Item.Bt,T_Item.Up);
             T_Item.SetPosition(NewX,NewY,-1,-1);//-1= Tetep gak berubah
         end;
     end;
  end;

  procedure TTurbulence.GetFromIni(Fname,Section:String);
  begin
    Name      :=GetStrIni(Fname,Section,'NAME','Untitled');
    DMaxTurb  :=GetIntIni(Fname,Section,'DiameterMax',1000);
    DMinTurb  :=GetIntIni(Fname,Section,'DiameterMin',100);
    TMaxTurb  :=GetIntIni(Fname,Section,'TinggiMax',50);
    TMinTurb  :=GetIntIni(Fname,Section,'TinggiMin',20);
    Kerapatan :=GetIntIni(Fname,Section,'Kerapatan',3);
    HMaxTurb  :=GetIntIni(Fname,Section,'KetinggianMax',10000);
    HMinTurb  :=GetIntIni(Fname,Section,'KetinggianMin',100);
    TimeMaxT  :=GetIntIni(Fname,Section,'TimeMax',2);
    TimeMinT  :=GetIntIni(Fname,Section,'TimeMin',1);
  end;

  procedure TTurbulence.CreateItem;
  var NewT:TTurbulenceItem;
      LifeTime :Double;
      HourD,MinuteD,SecD:Word;//Waktu hidup dalam menit;
  begin
         NewT:=TTurbulenceItem.Create(KiriAtas,KananBawah);
         with NewT do begin
               IsTimeToDead:=False;
               Diameter   :=DMinTurb+round((DMaxTurb-DMinTurb)*Random(100)/100);
               Lower      :=HMinTurb+round((HMaxTurb-HMinTurb)*Random(100)/100);
               Upper      :=Lower+round((TMaxTurb-TMinTurb)*Random(100)/100);
               LifeTime   :=TimeMinT+  abs(TimeMaxT-TimeMinT)*Random(100)/100;
               HourD      :=floor(LifeTime) div 60;
               MinuteD    :=floor(LifeTime) mod 60;
               SecD       :=floor((LifeTime-HourD*60-MinuteD)*60)mod 60;
               ApprTime   :=Now;
               DisApprTime:=ApprTime+EncodeTime(HourD,MinuteD,SecD,0);
         end;
         ObjectContainer.AddObject(NewT);
  end;

  procedure TTurbulence.SetBatasan(Kiri_Atas, Kanan_Bawah:tDouble2DPoint);
  var Luas:Double;
  begin
    KiriAtas    :=Kiri_Atas;
    KananBawah  :=Kanan_Bawah;
    Luas:=abs((KiriAtas.X-KananBawah.X)*(KiriAtas.Y-KananBawah.Y))*60;//nm2
    TurbNormalNumber:=Ceil(Luas*Kerapatan/100);

  end;

  function  TTurbulence.GetTurbulence(PosXYZ:tDouble3DPoint; var TuCenter:tDouble2DPoint;
                                var TuTop,TuBottom,TuDiameter:Integer):Boolean;
  var TItemObj:TTurbulenceItem;
      I:Integer;
  begin
  //Asumsi tidak ada yg berdekatan, Cari dari semua item yg melingkupi titik tsb,
  //Pencarian selesai jika ketemu 1 atau iterasi selesai
       Result:=False;
       TuCenter.X:=0;     TuCenter.Y:=0;
       TuTop     :=0;     TuBottom  :=0;
       TuDiameter:=0;
       for I:=0 to ObjectContainer.ItemCount-1 do begin
           TItemObj:=ObjectContainer.ListItem.Items[I];
           if (Range3D(PosXYZ.X,PosXYZ.Y,0,TItemObj.CenterX,TItemObj.CenterY,0)<TItemObj.Diameter) and
              (PosXYZ.Z>TItemObj.Lower)and(PosXYZ.Z<TItemObj.Upper) then begin
                  Result:=True;
                  TuCenter.X:=tItemObj.CenterX;
                  TuCenter.Y:=tItemObj.CenterY;
                  TuTop     :=TItemObj.Upper;
                  TuBottom  :=TItemObj.Lower;
                  TuDiameter:=TItemObj.Diameter;
                  Break;
              end;
       end;
  end;

  procedure TTurbulence.SetKerapatan(Rapat:Integer);
  var Luas        :Double;
      I           :Integer;
      TurbCurrent :TTurbulenceItem;
      Beda        :Integer;
  begin
    Kerapatan:=Rapat;
    Luas:=abs((KiriAtas.X-KananBawah.X)*(KiriAtas.Y-KananBawah.Y))*60;//nm2
    TurbNormalNumber:=Ceil(Luas*Kerapatan/100);
    Beda:=ObjectContainer.ItemCount-TurbNormalNumber;
    //Jika yg lama lebih banyak matikan sebagian shg jumlahnya sesuai
    //Jika lebih sedikit, biarkan nambah sendiri waktu Run
   // if Beda>0 then
    for I:=0 to Beda-1 do begin
          TurbCurrent:=ObjectContainer.ListItem.Items[I];
          ObjectContainer.RemoveObject(TurbCurrent);// Delete(I);
    end;
  end;

  procedure   TTurbulence.SetWindParent(TheParent:TObject);
  begin
      WindFactorParent:=TheParent;
  end;


end.
