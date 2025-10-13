unit uWmiHwId;

interface
  //  {$APPTYPE CONSOLE}
  {$DEFINE Use_Jwscl} //necessary to obtain a hash of the data using md2, md4, md5 or sha1

uses
  Windows,  SysUtils, Variants, Classes,  Controls,
  Dialogs,
  {$IFDEF Use_Jwscl}
//    JwsclTypes, JwsclCryptProvider,
  {$ENDIF}
  ActiveX, ComObj, StdCtrls, uCodecBase64;

  function VarArrayToStr(const vArray: variant): AnsiString;
  function _VarToStr(const V: variant): AnsiString;
  function VarStrNull(const V:OleVariant):AnsiString;

type
  TMotherBoardInfo   = (Mb_SerialNumber,Mb_Manufacturer,Mb_Product,Mb_Model);
   TMotherBoardInfoSet= set of TMotherBoardInfo;
   TProcessorInfo     = (Pr_Description,Pr_Manufacturer,Pr_Name,Pr_ProcessorId,Pr_UniqueId);
   TProcessorInfoSet  = set of TProcessorInfo;
   TBIOSInfo          = (Bs_BIOSVersion,Bs_BuildNumber,Bs_Description,Bs_Manufacturer,Bs_Name,Bs_SerialNumber,Bs_Version);
   TBIOSInfoSet       = set of TBIOSInfo;
   TOSInfo            = (Os_BuildNumber,Os_BuildType,Os_Manufacturer,Os_Name,Os_SerialNumber,Os_Version);
   TOSInfoSet         = set of TOSInfo;
   TDiskInfo          = (Dk_SerialNumber, Dk_Manufacturer, Dk_Model, Dk_Size, Dk_InterfaceType, Dk_FirmwareRevision);
   TDiskInfoSet       = set of TDiskInfo;

const //properties names to get the data
   MotherBoardInfoArr: array[TMotherBoardInfo] of AnsiString =
                        ('SerialNumber','Manufacturer','Product','Model');

   OsInfoArr         : array[TOSInfo] of AnsiString =
                        ('BuildNumber','BuildType','Manufacturer','Name','SerialNumber','Version');

   BiosInfoArr       : array[TBIOSInfo] of AnsiString =
                        ('BIOSVersion','BuildNumber','Description','Manufacturer','Name','SerialNumber','Version');

   ProcessorInfoArr  : array[TProcessorInfo] of AnsiString =
                        ('Description','Manufacturer','Name','ProcessorId','UniqueId');

   DiskInfoArr       : array[TDiskInfo] of AnsiString =
                        ('SerialNumber','Manufacturer', 'Model', 'Size', 'InterfaceType', 'FirmwareRevision');

type
   THardwareId  = class
   private
    FOSInfo         : TOSInfoSet;
    FBIOSInfo       : TBIOSInfoSet;
    FProcessorInfo  : TProcessorInfoSet;
    FMotherBoardInfo: TMotherBoardInfoSet;
    FDiskInfo       : TDiskInfoSet;
    FBuffer         : AnsiString;
    function GetHardwareIdHex: AnsiString;
    function GetHardwareIdBase64: AnsiString;
  {$IFDEF Use_Jwscl}
//    function GetHashString(Algorithm: TJwHashAlgorithm; Buffer : Pointer;Size:Integer) : AnsiString;
    function GetHardwareIdMd5: AnsiString;
    function GetHardwareIdMd2: AnsiString;
    function GetHardwareIdMd4: AnsiString;
    function GetHardwareIdSHA: AnsiString;
  {$ENDIF}
   public
     //Set the properties to  be used in the generation of the hardware id
    property  MotherBoardInfo : TMotherBoardInfoSet read FMotherBoardInfo write FMotherBoardInfo;
    property  ProcessorInfo : TProcessorInfoSet read FProcessorInfo write FProcessorInfo;
    property  BIOSInfo: TBIOSInfoSet read FBIOSInfo write FBIOSInfo;
    property  OSInfo  : TOSInfoSet read FOSInfo write FOSInfo;
    property  DiskInfo: TDiskInfoSet read FDiskInfo write FDiskInfo;
    property  Buffer : AnsiString read FBuffer; //return the content of the data collected in the system
    property  HardwareIdHex : AnsiString read GetHardwareIdHex; //get a hexadecimal represntation of the data collected
    property  HardwareIdBase64 : AnsiString read GetHardwareIdBase64;
  {$IFDEF Use_Jwscl}
    property  HardwareIdMd2  : AnsiString read GetHardwareIdMd2; //get a Md2 hash of the data collected
    property  HardwareIdMd4  : AnsiString read GetHardwareIdMd4; //get a Md4 hash of the data collected
    property  HardwareIdMd5  : AnsiString read GetHardwareIdMd5; //get a Md5 hash of the data collected
    property  HardwareIdSHA  : AnsiString read GetHardwareIdSHA; //get a SHA1 hash of the data collected
  {$ENDIF}
    procedure GenerateHardwareId; //calculate the hardware id
    constructor  Create(Generate:Boolean=True); overload;
    Destructor  Destroy; override;
   end;

implementation

function VarArrayToStr(const vArray: variant): AnsiString;

var
i : integer;
begin
    Result := '[';
    if (VarType(vArray) and VarArray)=0 then
       Result := _VarToStr(vArray)
    else
    for i := VarArrayLowBound(vArray, 1) to VarArrayHighBound(vArray, 1) do
     if i=VarArrayLowBound(vArray, 1)  then
      Result := Result+_VarToStr(vArray[i])
     else
      Result := Result+'|'+_VarToStr(vArray[i]);

    Result:=Result+']';
end;

function _VarToStr(const V: variant): AnsiString;
  var
  Vt: integer;
  begin
   Vt := VarType(V);
      case Vt of
        varSmallint,
        varInteger  : Result := AnsiString(IntToStr(integer(V)));
        varSingle,
        varDouble,
        varCurrency : Result := AnsiString(FloatToStr(Double(V)));
        varDate     : Result := AnsiString(VarToStr(V));
        varOleStr   : Result := AnsiString(WideString(V));
        varBoolean  : Result := AnsiString(VarToStr(V));
        varVariant  : Result := AnsiString(VarToStr(Variant(V)));
        varByte     : Result := AnsiChar(byte(V));
        varString   : Result := AnsiString(V);
        varArray    : Result := VarArrayToStr(Variant(V));
      end;
  end;

function VarStrNull(const V:OleVariant):AnsiString; //avoid problems with null strings
begin
  Result:='';
  if not VarIsNull(V) then
  begin
    if VarIsArray(V) then
       Result:=VarArrayToStr(V)
    else
    Result:=AnsiString(VarToStr(V));
  end;
end;

{ THardwareId }

constructor THardwareId.Create(Generate: Boolean);
begin
  inherited Create;
   CoInitialize(nil);
   FBuffer          :='';
   //Set the propeties to be used in the hardware id generation
   FMotherBoardInfo :=[Mb_SerialNumber];// ,Mb_Manufacturer,Mb_Product,Mb_Model
   FOSInfo          :=[Os_BuildNumber,Os_BuildType,Os_Manufacturer,Os_Name,Os_SerialNumber,Os_Version];
   FBIOSInfo        :=[Bs_BIOSVersion,Bs_BuildNumber,Bs_Description,Bs_Manufacturer,Bs_Name,Bs_SerialNumber,Bs_Version];
   FProcessorInfo   :=[];//including the processor info is expensive [Pr_Description,Pr_Manufacturer,Pr_Name,Pr_ProcessorId,Pr_UniqueId];
   FDiskInfo        :=[Dk_SerialNumber, Dk_InterfaceType];// , Dk_Manufacturer, Dk_Model, Dk_Size, Dk_FirmwareRevision
   if Generate then
    GenerateHardwareId;
end;

destructor THardwareId.Destroy;
begin
  CoUninitialize;
  inherited;
end;

//Main function which collect the system data.
procedure THardwareId.GenerateHardwareId;
var
  objSWbemLocator : OLEVariant;
  objWMIService   : OLEVariant;
  objWbemObjectSet: OLEVariant;
  oWmiObject      : OLEVariant;
  oEnum           : IEnumvariant;
  iValue          : LongWord;
  SDummy          : AnsiString;
  Mb              : TMotherBoardInfo;
  Os              : TOSInfo;
  Bs              : TBIOSInfo;
  Pr              : TProcessorInfo;
  Dk              : TDiskInfo;
begin
  objSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  objWMIService   := objSWbemLocator.ConnectServer('localhost','root\cimv2', '','');

  if FMotherBoardInfo<>[] then //MotherBoard info
  begin
    objWbemObjectSet:= objWMIService.ExecQuery('SELECT * FROM Win32_BaseBoard','WQL',0);
    oEnum           := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
    FBuffer := FBuffer+'MotherBoardInfo:'+ #13#10;
    while oEnum.Next(1, oWmiObject, iValue) = 0 do
    begin
      for Mb := Low(TMotherBoardInfo) to High(TMotherBoardInfo) do
       if Mb in FMotherBoardInfo then
       begin
          SDummy:='_'+MotherBoardInfoArr[Mb]+' :' + VarStrNull(oWmiObject.Properties_.Item(MotherBoardInfoArr[Mb]).Value) + #13#10;
          FBuffer:=FBuffer+SDummy;
       end;
       oWmiObject:=Unassigned;
    end;
  end;

//  if FOSInfo<>[] then//Windows info
//  begin
//    objWbemObjectSet:= objWMIService.ExecQuery('SELECT * FROM Win32_OperatingSystem','WQL',0);
//    oEnum           := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
//    while oEnum.Next(1, oWmiObject, iValue) = 0 do
//    begin
//      for Os := Low(TOSInfo) to High(TOSInfo) do
//       if Os in FOSInfo then
//       begin
//          SDummy:=VarStrNull(oWmiObject.Properties_.Item(OsInfoArr[Os]).Value);
//          FBuffer:=FBuffer+SDummy;
//       end;
//       oWmiObject:=Unassigned;
//    end;
//  end;

//  if FBIOSInfo<>[] then//BIOS info
//  begin
//    objWbemObjectSet:= objWMIService.ExecQuery('SELECT * FROM Win32_BIOS','WQL',0);
//    oEnum           := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
//    while oEnum.Next(1, oWmiObject, iValue) = 0 do
//    begin
//      for Bs := Low(TBIOSInfo) to High(TBIOSInfo) do
//       if Bs in FBIOSInfo then
//       begin
//          SDummy:=VarStrNull(oWmiObject.Properties_.Item(BiosInfoArr[Bs]).Value);
//          FBuffer:=FBuffer+SDummy;
//       end;
//       oWmiObject:=Unassigned;
//    end;
//  end;

//  if FProcessorInfo<>[] then//CPU info
//  begin
//    objWbemObjectSet:= objWMIService.ExecQuery('SELECT * FROM Win32_Processor','WQL',0);
//    oEnum           := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
//    while oEnum.Next(1, oWmiObject, iValue) = 0 do
//    begin
//      for Pr := Low(TProcessorInfo) to High(TProcessorInfo) do
//       if Pr in FProcessorInfo then
//       begin
//          SDummy:=VarStrNull(oWmiObject.Properties_.Item(ProcessorInfoArr[Pr]).Value);
//          FBuffer:=FBuffer+SDummy;
//       end;
//       oWmiObject:=Unassigned;
//    end;
//  end;

  if FDiskInfo<>[] then//Disk info
  begin
    objWbemObjectSet:= objWMIService.ExecQuery('SELECT * FROM Win32_DiskDrive where InterfaceType != '+QuotedStr('USB'), 'WQL', 0);
    oEnum := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
    FBuffer := FBuffer+'DiskInfo:'+ #13#10;
    while oEnum.Next(1, oWmiObject, iValue) = 0 do
    begin
      for Dk := Low(TDiskInfo) to High(TDiskInfo) do
        if Dk in FDiskInfo then
        begin
          SDummy := '_'+DiskInfoArr[Dk]+' :'+Trim(VarStrNull(oWmiObject.Properties_.Item(DiskInfoArr[Dk]).Value))+#13#10;
          FBuffer := FBuffer + SDummy;
        end;
        oWmiObject := Unassigned;
    end;
  end;

end;

function THardwareId.GetHardwareIdBase64: AnsiString;
begin
  Result := Base64Encode(FBuffer);
end;

function THardwareId.GetHardwareIdHex: AnsiString;
begin
  SetLength(Result,Length(FBuffer)*2);
  BinToHex(PAnsiChar(FBuffer),PAnsiChar(Result),Length(FBuffer));
end;

{$IFDEF Use_Jwscl}
//function THardwareId.GetHashString(Algorithm: TJwHashAlgorithm; Buffer : Pointer;Size:Integer) : AnsiString;
//var
//  Hash: TJwHash;
//  HashSize: Cardinal;
//  HashData: Pointer;
//begin
//  Hash := TJwHash.Create(Algorithm);
//  try
//    Hash.HashData(Buffer,Size);
//    HashData := Hash.RetrieveHash(HashSize);
//    try
//        SetLength(Result,HashSize*2);
//        BinToHex(PAnsiChar(HashData),PAnsiChar(Result),HashSize);
//    finally
//      TJwHash.FreeBuffer(HashData);
//    end;
//  finally
//    Hash.Free;
//  end;
//end;

function THardwareId.GetHardwareIdMd2: AnsiString;
begin
//  Result:=GetHashString(haMD2,@FBuffer[1],Length(FBuffer));
end;

function THardwareId.GetHardwareIdMd4: AnsiString;
begin
//  Result:=GetHashString(haMD4,@FBuffer[1],Length(FBuffer));
end;

function THardwareId.GetHardwareIdMd5: AnsiString;
begin
//  Result:=GetHashString(haMD5,@FBuffer[1],Length(FBuffer));
end;

function THardwareId.GetHardwareIdSHA: AnsiString;
begin
//  Result:=GetHashString(haSHA,@FBuffer[1],Length(FBuffer));
end;
{$ENDIF}

end.
