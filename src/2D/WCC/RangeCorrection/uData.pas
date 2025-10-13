{ ===========================
     MV : MUZZLE VELOCITY
     BP : BAROMETRIC PRESSURE
     AT : AIR TEMPERATURE
     HD : HUMIDITY
     RT : REAL TEMPERATURE
     FW : FOLLOWING WIND
     SS : SHIP SPEED
     TS : TARGET SPEED
     Et : dari tabel Et
  ============================ }

unit uData;

interface

uses SysUtils, DBTables, StdCtrls, DB, ADODB, Classes, Forms, iniFiles, math, uTCPClient, uTCPDatatype;

const C_DeltaRange    = 100;
      C_MaxRangeInDB  = 9000;
      C_MaxQEInDB     = 7.54;

type
  TEnvironmentData = record
    TargetDistance,
    MuzzleVelocity,
    BarometricPressure,
    AirTemperature,
    Humidity,
    FollowingWind,
    ShipSpeed,
    TargetSpeed : Double;
  end;

  TRecFactorCorr = record
    angleDeparture,
    MuzzleVelocity,
    increaseElev,
    BarometricPressure,
    AirTemperature,
    FollowingWind,
    ShipSpeed,
    TargetSpeed, Et : Double;
  end;

  TData = class
    ADOConn: TADOConnection;
    DataSource1,DataSource2: TDataSource;
    Query1,Query2: TADOQuery;

    constructor Create;
    destructor Destruct;

  private
    procedure Connect_by_Range(const section:String);
    procedure Connect_by_QuadratElevation(const deg:String);

    procedure ReadInputFromIniFile; //(apRec:PAnsiChar; aSize:Integer);
    procedure ReadData(const inTD,inBP,inAT : ShortString);
    function FindSection(const data : Single; const fact:Integer) : TStringList; {fact = 1 untuk tabel faktor koreksi}
  public                                                                          {fact = 2 untuk tabel Et}
    procedure LoadDataTabelCorr(const section : String; var hasil: TStringList);
    function GetAverageValueFromDB: TStringList;
    function SetValueFromAvg(avg: TStringList; const num: integer): TStringList;

    function LoadDataTabelEt(const fIni, section, key : String) : String;

  private
    FDataEnvironment : TEnvironmentData;
    FDataFaktorKoreksi : TRecFactorCorr;

    Log1 : TStringList;
    Log2 : TStringList;
  public
    elevClient : Double;

    function GetTargetDistance(const qeDeg : Double) : Double;

    function GetEnvironmentData: TEnvironmentData;
    function GetCorrectionData(const inTD,inBP,inAT : ShortString): TRecFactorCorr;

    procedure SetLog1(aLog: TStringList);
    procedure SetLog2(aLog: TStringList);

  end;

implementation

constructor TData.create;
begin
  elevclient := 0;
  ADOConn := TADOConnection.Create(nil);
  DataSource1 := TDataSource.Create(nil);
  DataSource2 := TDataSource.Create(nil);
  Query1 := TADOQuery.Create(nil);
  Query2 := TADOQuery.Create(nil);

  ADOConn.LoginPrompt := False;
  //ADOConn.ConnectionString:= 'Provider=MSDASQL.1;Password=password;Persist Security Info=True;User ID=root;Data Source=emulator;Extended Properties="DATABASE=portals;DSN=emulator;OPTION=0;PWD=password;PORT=0;SERVER=192.168.0.22;UID=root"';
  ADOConn.ConnectionString:= 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=emulatordb;Extended Properties="DATABASE=portals;DSN=emulatordb;OPTION=0;PORT=0;SERVER=192.168.0.2;UID=emulatordba"';
  
end;

destructor TData.destruct;
begin
  Query1.Close;
  Query2.Close;
  ADOConn.Close;

  Query1.Free;
  Query2.Free;
  ADOConn.Free;
end;

procedure TData.Connect_by_Range(const section:String);
begin
  with Query1 do
  begin
     Connection := ADOConn;
     with SQL do begin
        Clear;
        Add('select * from canon_surface_target where RANGE=:parRange');
     end;
     Parameters.ParamByName('parRange').Value := section;
     Active := true;
     Open;
  end;

  DataSource1.DataSet := Query1;
  DataSource1.DataSet.Refresh;
end;

procedure TData.Connect_by_QuadratElevation(const deg:String);
begin
  with Query2 do
  begin
     Connection := ADOConn;
     with SQL do begin
        Clear;
        Add('select RANGE from canon_surface_target where round(QE_DEGREE,1)=round(:parDeg,1)');
     end;
     Parameters.ParamByName('parDeg').Value := deg;
     Active := true;
     Open;
  end;

  DataSource2.DataSet := Query2;
  //DataSource2.DataSet.Refresh;
end;

{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}

{ == membaca tabel koreksi dan tabel Et(tabelEt.ini) ==}
procedure TData.ReadData(const inTD,inBP,inAT : ShortString);
var sectTD, sectBP, keyAT: ShortString;
    loadedData : TStringList;
begin
  sectTD := inTD;
  sectBP := inBP;
  keyAT := inAT;
  
  LoadDataTabelCorr(sectTD, loadedData);
  FDataFaktorKoreksi.angleDeparture := StrToFloat(loadedData.Strings[3]);     //QE_DEGREE
  FDataFaktorKoreksi.MuzzleVelocity := StrToFloat(loadedData.Strings[10]);    // IMV
  FDataFaktorKoreksi.increaseElev := StrToFloat(loadedData.Strings[11]);      //IQE
  FDataFaktorKoreksi.BarometricPressure := StrToFloat(loadedData.Strings[13]);//BAR_PRESSURE
  FDataFaktorKoreksi.AirTemperature := StrToFloat(loadedData.Strings[14]);    //AIR_DENSITY
  FDataFaktorKoreksi.FollowingWind := StrToFloat(loadedData.Strings[16]);     //FOLLOWING_WIND
  FDataFaktorKoreksi.ShipSpeed := StrToFloat(loadedData.Strings[17]);         //SPEED_GUN_PLANE
  FDataFaktorKoreksi.TargetSpeed := StrToFloat(loadedData.Strings[18]);       //SPEED_TARGET_PLANE

  FDataFaktorKoreksi.Et := StrToFloat(LoadDataTabelEt('Scenario\tabelET.ini',sectBP,keyAT));

end;

function TData.FindSection(const data : Single; const fact:Integer) : TStringList;
var
  delta : Single;
  sect : TStringList;
begin
  sect := TStringList.Create;
  delta := IntPower(10,2) / fact;
  sect.Add(FloatToStr(Floor(data/delta) * delta));
  sect.Add(FloatToStr(Ceil(data/delta) * delta));
  result := sect;
end;

{procedure TData.LoadDataTabelCorr(const section : String; var hasil: TStringList);
var data0,dataSect,data1,data2,dataTemp : TStringList;
    fList : TFieldList;
    temp, delta,tes : double;
    i,count : Byte;
    Value, top, bottom : integer;
begin
  dataSect := TStringList.Create;
  data0 := TStringList.Create;
  data1 := TStringList.Create;
  data2 := TStringList.Create;

  Value := StrToInt(section);

  if Value <= C_MaxRangeInDB then begin     // ada di database

    Connect_by_Range(section);
    if not DataSource1.DataSet.IsEmpty then begin  // data jarak ada
      count := DataSource1.DataSet.FieldCount;
      for i:=0 to count-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        data0.Add(fList.Fields[i].AsString);
      end;
    end
    else begin     // data jarak tidak ada
      dataSect := FindSection(StrToFloat(section), 1);

      Connect_by_Range(dataSect.Strings[0]);
      for i:=0 to DataSource1.DataSet.FieldCount-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        data1.Add(fList.Fields[i].AsString);
      end;

      Connect_by_Range(dataSect.Strings[1]);
      for i:=0 to DataSource1.DataSet.FieldCount-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        data2.Add(fList.Fields[i].AsString);
      end;

      delta := StrToFloat(dataSect.Strings[1]) - StrToFloat(dataSect.Strings[0]);
      if data1.Count = data2.Count then
        for i:=0 to data1.Count-1 do
          if (i=0) or (i=1) or (i=2) then
            data0.Add('')
          else begin
            tes := StrToFloat(data1.Strings[i]);
            temp := (StrToFloat(data1.Strings[i]))+
                ((StrToFloat(data2.Strings[i]))-(StrToFloat(data1.Strings[i]))) / delta *
                (StrToFloat(section)-StrToFloat(dataSect.Strings[0]));
            data0.Add(FloatToStr(temp));        // data0 : cuma value aja
          end;
    end;
    result := data0;
  end
  else begin    // klo g ada di database
    dataTemp := GetAverageValueFromDB;

    if (Value mod C_DeltaRange) = 0 then begin
      top := Value div C_DeltaRange;
      data0 := SetValueFromAvg(dataTemp, top);
    end
    else begin
      dataSect := FindSection(Value, 1);
      top := StrToInt(dataSect.Strings[0]) div C_DeltaRange;
      bottom := StrToInt(dataSect.Strings[1]) div C_DeltaRange;

      data1 := SetValueFromAvg(dataTemp, top);
      data2 := SetValueFromAvg(dataTemp, bottom);

      delta := bottom - top;
      if data1.Count = data2.Count then
        for i:=0 to data1.Count-1 do
          if (i=0) or (i=1) then
            data0.Add('1')
          else begin
            tes := StrToFloat(data1.Strings[i]);
            temp := (StrToFloat(data1.Strings[i]))+
                ((StrToFloat(data2.Strings[i]))-(StrToFloat(data1.Strings[i]))) / delta *
                (StrToFloat(section)-StrToFloat(dataSect.Strings[0]));
            data0.Add(FloatToStr(temp));        // data0 : cuma value aja
          end;

      result := data0;
    end;

    for i:=0 to data0.Count-1 do
      Log1.Add(IntToStr(i) + ' : ' + data0.Strings[i]);

  end;
end;  }

procedure TData.LoadDataTabelCorr(const section : String; var hasil: TStringList);
var dataSect,data1,data2,rata2 : TStringList;
    fList : TFieldList;
    temp, delta,tes : double;
    i,count : Byte;
    Value, top, bottom : integer;
begin
  dataSect := TStringList.Create;
  data1 := TStringList.Create;
  data2 := TStringList.Create;
  hasil := TStringList.Create;

  Value := StrToInt(section);

  if Value <= C_MaxRangeInDB then begin     // ada di database

    Connect_by_Range(section);
    if not DataSource1.DataSet.IsEmpty then begin  // data jarak ada
      count := DataSource1.DataSet.FieldCount;
      for i:=0 to count-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        hasil.Add(fList.Fields[i].AsString);
      end;
    end
    else begin     // data jarak tidak ada
      dataSect := FindSection(StrToFloat(section), 1);

      Connect_by_Range(dataSect.Strings[0]);
      for i:=0 to DataSource1.DataSet.FieldCount-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        data1.Add(fList.Fields[i].AsString);
      end;

      Connect_by_Range(dataSect.Strings[1]);
      for i:=0 to DataSource1.DataSet.FieldCount-1 do
      begin
        fList := DataSource1.DataSet.FieldList;
        data2.Add(fList.Fields[i].AsString);
      end;

      delta := StrToFloat(dataSect.Strings[1]) - StrToFloat(dataSect.Strings[0]);
      if data1.Count = data2.Count then
        for i:=0 to data1.Count-1 do
          if (i=0) or (i=1) or (i=2) then
            hasil.Add('')
          else begin
            tes := StrToFloat(data1.Strings[i]);
            temp := (StrToFloat(data1.Strings[i]))+
                ((StrToFloat(data2.Strings[i]))-(StrToFloat(data1.Strings[i]))) / delta *
                (StrToFloat(section)-StrToFloat(dataSect.Strings[0]));
            hasil.Add(FloatToStr(temp));        // data0 : cuma value aja
          end;
    end;
  end
  else begin    // klo g ada di database
    rata2 := GetAverageValueFromDB;

    if (Value mod C_DeltaRange) = 0 then begin
      top := Value;
      hasil := SetValueFromAvg(rata2, top div C_DeltaRange);
    end
    else begin
      dataSect := FindSection(Value, 1);
      top := StrToInt(dataSect.Strings[0]);
      bottom := StrToInt(dataSect.Strings[1]);

      data1 := SetValueFromAvg(rata2, top  div C_DeltaRange);
      data2 := SetValueFromAvg(rata2, bottom div C_DeltaRange);

      delta := bottom - top;
      if data1.Count = data2.Count then
        for i:=0 to data1.Count-1 do
          if (i=0) or (i=1) then
            hasil.Add('1')
          else begin
            tes := StrToFloat(data1.Strings[i]);
            temp := StrToFloat(data1.Strings[i]) + (StrToFloat(data2.Strings[i]) - StrToFloat(data1.Strings[i])) / delta * (Value-top);
            hasil.Add(FloatToStr(temp));
          end;
    end;

    {Log1.Clear;
    Log2.Clear;
    log2.Add('atas');
    log1.Add('rata2');
    for i:=0 to hasil.Count-1 do begin
      Log1.Add(IntToStr(i) + ' : ' + rata2.Strings[i]);
      if data1.Count > 0 then Log2.Add(IntToStr(i) + ' : ' + data1.Strings[i]);
    end;
    log2.Add('bawah');
    for i:=0 to hasil.Count-1 do
      if data2.Count > 0 then Log2.Add(IntToStr(i) + ' : ' + data2.Strings[i]);

      }
  end;


end;

function TData.GetAverageValueFromDB: TStringList;
const C_StartRange  = 0;
      C_DeltaNum    = 90;
var data  : array [1 .. C_DeltaNum] of TStringList;
    data0, tmpStr : TStringList;
    fList : TFieldList;
    i, j  : Byte;
    tmpDbl  : double;
begin
  data0 := TStringList.Create;
  tmpStr:= TStringList.Create;
  
  for i := 1 to C_DeltaNum do
    data[i] := TStringList.Create;

  for i := 1 to C_DeltaNum do begin
    Connect_by_Range(IntToStr(C_StartRange + (i * C_DeltaRange)));

    for j := 0 to DataSource1.DataSet.FieldCount-1 do begin
      fList := DataSource1.DataSet.FieldList;
      data[i].Add(fList.Fields[j].AsString);
    end;
  end;

  for j := 0 to DataSource1.DataSet.FieldCount-1 do begin
    tmpDbl := 0.0;

    for i := 1 to C_DeltaNum - 1 do
      tmpDbl := tmpDbl + StrToFloat(data[i+1].Strings[j]) - StrToFloat(data[i].Strings[j]);

    tmpStr.Add(FloatToStr(tmpDbl));
  end;

  for j := 0 to DataSource1.DataSet.FieldCount-1 do begin
    tmpDbl := StrToFloat(tmpStr.Strings[j]) / (C_DeltaNum - 1);
    data0.Add(FloatToStr(tmpDbl));
  end;

  result := data0;

end;


function TData.SetValueFromAvg(avg: TStringList; const num: integer): TStringList;
var i: integer;
  res: TStringList;
  temp: double;
begin
  res := TStringList.Create;

  for i:=0 to avg.Count-1 do begin
    if (i=0) or (i=1) then
      res.Add('1')
    else begin
      temp := StrToFloat(avg.Strings[i]) * num;
      res.Add(FloatToStr(temp));
    end;
  end;
  result := res;
end;

{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
function TData.LoadDataTabelEt(const fIni, section, key : String) : String;
var
  dataSect,data1,data2  : TStringList;
  dataTemp : TStringList;
  data0,data11,data12,data21,data22 : String;
  iniF : TIniFile;
  fname : String;
  temp,temp1,temp2,delta  : Double;
  i,keyIndex : Byte;
begin
  dataSect := TStringList.Create;
  data1 := TStringList.Create;
  data2 := TStringList.Create;
  dataTemp := TStringList.Create;

  if fIni = '' then
    fName := ExtractFilePath(Application.ExeName) + 'Scenario\tabelEt.ini'
  else
    fName := ExtractFilePath(Application.ExeName) + fIni;

  iniF := TIniFile.Create(fName);
  try
    if (iniF.SectionExists(section)) then   {section exist}
    begin
      iniF.ReadSectionValues(section,dataTemp);
      {== check key ==}
      if iniF.ValueExists(section,key) then  {key exist}
      begin
        data0 := dataTemp.Values[key];
      end
      else  {key not exist}
      begin
          for i:=0 to dataTemp.Count-1 do
          begin
             if i = 0 then
             begin
                if ( StrToFloat(key) < StrToFloat(dataTemp.Names[i]) ) then {key awal}
                begin
                    keyIndex := i;
                    data11 := dataTemp.ValueFromIndex[keyIndex];
                    temp := StrToFloat(data11)-(StrToFloat(data11)/StrToFloat(dataTemp.Names[keyIndex]) * (StrToFloat(key)-StrToFloat(dataTemp.Names[keyIndex])));
                    data0 := FloatToStr(temp);
                    Break;
                end;
             end
             else if i = dataTemp.Count-1 then
             begin
                if ( StrToFloat(key) > StrToFloat(dataTemp.Names[i]) ) then {key terakhir}
                begin
                    keyIndex := i;
                    data11 := dataTemp.ValueFromIndex[keyIndex];
                    temp := StrToFloat(data11)+(StrToFloat(data11)/StrToFloat(dataTemp.Names[keyIndex]) * (StrToFloat(key)-StrToFloat(dataTemp.Names[keyIndex])));
                    data0 := FloatToStr(temp);
                    Break;
                end;
             end;

                if (StrToFloat(dataTemp.Names[i])< StrToFloat(key)) and (StrToFloat(dataTemp.Names[i+1])> StrToFloat(key)) then
                begin
                   keyIndex := i;
                   data11 := dataTemp.ValueFromIndex[keyIndex];
                   data12 := dataTemp.ValueFromIndex[keyIndex+1];
                   temp := StrToFloat(data11)+((StrToFloat(data12)-StrToFloat(data11))/(StrToFloat(dataTemp.Names[keyIndex+1])-StrToFloat(dataTemp.Names[keyIndex])) * (StrToFloat(key)-StrToFloat(dataTemp.Names[keyIndex])));
                   data0 := FloatToStr(temp);
                   Break;
                end;
            
          end;
      end;

    end
    else  {section not exist -> cari rata2nya }
    begin
      dataSect := FindSection(StrToFloat(section),2);

      {== check datasec.string[0] dan datasec.string[1] exist??? ==}
      if not(iniF.SectionExists(dataSect.Strings[0]) and iniF.SectionExists(dataSect.Strings[1])) then
      begin
        data0 := FloatToStr(0.0);
        result := data0;
        Exit;
      end;

      iniF.ReadSectionValues(dataSect.Strings[0],data1);
      iniF.ReadSectionValues(dataSect.Strings[1],data2);

      {== check key ==}
      if iniF.ValueExists(dataSect.Strings[0],key) then  {key exist}
      begin
        data11 := data1.Values[key];
        data12 := data2.Values[key];
        delta := StrToFloat(dataSect.Strings[1])- StrToFloat(dataSect.Strings[0]);
        temp := StrToFloat(data11)+ ((StrToFloat(data12)-StrToFloat(data11))/delta) * (StrToFloat(section)-StrToFloat(dataSect.Strings[0]));
        data0 := FloatToStr(temp);        // data0 : cuman value aja
      end
      else  {key not exist}
      begin
         for i:=0 to data1.Count-1 do
         begin
           if i = data1.Count-1 then
           begin
             if (StrToFloat(data1.Names[i])< StrToFloat(key)) or (StrToFloat(data1.Names[i])> StrToFloat(key)) then
             begin
                keyIndex := i;
                Break;
             end;
           end
           else
           begin
              if (StrToFloat(data1.Names[i])< StrToFloat(key)) and (StrToFloat(data1.Names[i+1])> StrToFloat(key)) then
              begin
                keyIndex := i;
                Break;
              end;
           end;
         end;
         data11 := data1.ValueFromIndex[keyIndex];
         data12 := data1.ValueFromIndex[keyIndex+1];
         data21 := data2.ValueFromIndex[keyIndex];
         data22 := data2.ValueFromIndex[keyIndex+1];

         temp1 := StrToFloat(data11)+((StrToFloat(data12)-StrToFloat(data11))/(StrToFloat(data1.Names[keyIndex+1])-StrToFloat(data1.Names[keyIndex])) * (StrToFloat(key)-StrToFloat(data1.Names[keyIndex])));
         temp2 := StrToFloat(data21)+((StrToFloat(data22)-StrToFloat(data21))/(StrToFloat(data2.Names[keyIndex+1])-StrToFloat(data2.Names[keyIndex])) * (StrToFloat(key)-StrToFloat(data2.Names[keyIndex])));
         temp := (temp1 + temp2)/2;
         data0 := FloatToStr(temp);
      end;

    end;

  finally
    iniF.Free;
  end;
    result := data0;
end;

{ ===================== untuk server 2D ============================= }
procedure TData.ReadInputFromIniFile; //(apRec:PAnsiChar; aSize:Integer);
var
  Ini: TIniFile;
  data: TStringList;
begin
    Ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'Scenario\tabelEnvirontment.ini');
    data := TStringList.Create;
  try
    Ini.ReadSectionValues('input',data);

    FDataEnvironment.MuzzleVelocity := StrToFloat(data.ValueFromIndex[1]);
    FDataEnvironment.ShipSpeed := StrToFloat(data.ValueFromIndex[6]);
    FDataEnvironment.TargetSpeed := StrToFloat(data.ValueFromIndex[7]);

    FDataEnvironment.BarometricPressure := StrToFloat(data.ValueFromIndex[2]);
    FDataEnvironment.AirTemperature := StrToFloat(data.ValueFromIndex[3]);
    FDataEnvironment.Humidity := StrToFloat(data.ValueFromIndex[4]);
    FDataEnvironment.FollowingWind := StrToFloat(data.ValueFromIndex[5]);

  finally
    Ini.Free;
  end;
end;

function TData.GetTargetDistance(const qeDeg : Double) : Double;
var dist, qeDegRound, qeDegTemp : Double;
    dataTemp: TStringList;
    num, temprange : double;
begin
  if qeDeg < C_MaxQEInDB then begin     // ada di database
    Connect_by_QuadratElevation(FloatToStr(qeDeg));
    qeDegRound := RoundTo(qeDeg,-1);

    if not DataSource2.DataSet.IsEmpty then begin   // data jarak ada
      dist := StrToFloat(DataSource2.DataSet.FieldValues['range']);
      dist := dist + (qeDeg-qeDegRound)/100;
    end
    else begin      // data jarak tidak ada
      qeDegTemp := qeDegRound-0.1;
      Connect_by_QuadratElevation(FloatToStr(qeDegTemp));
      dist := StrToFloat(DataSource2.DataSet.FieldValues['range']);
      dist := dist + (qeDeg - qeDegTemp) / 100;
    end;
    Result:= dist;
  end
  else begin  // klo g ada di database
    dataTemp := GetAverageValueFromDB;

    qeDegRound := RoundTo(qeDeg, -1);
    qeDegTemp := StrToFloat(dataTemp.Strings[3]);     //QE_DEGREE;
    //num := Ceil(qeDegRound / qeDegTemp);
    num := qeDegRound / qeDegTemp;
    temprange := StrToFloat(dataTemp.Strings[2]);     //RANGE

    result := num * temprange;

  end;
end;

function TData.GetEnvironmentData: TEnvironmentData;
begin
  ReadInputFromIniFile;
  result := FDataEnvironment;
end;

function TData.GetCorrectionData(const inTD,inBP,inAT : ShortString): TRecFactorCorr;
begin
  ReadData(inTD, inBP, inAT);
  result := FDataFaktorKoreksi;
end;

procedure TData.SetLog1(aLog: TStringList);
begin
  if not Assigned(Log1) then Log1 := TStringList.Create;

  aLog.Assign(Log1);
  Log1 := aLog;

end;

procedure TData.SetLog2(aLog: TStringList);
begin
  if not Assigned(Log2) then Log2 := TStringList.Create;

  aLog.Assign(Log2);
  Log2 := aLog;

end;

end.
