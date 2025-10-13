unit Unit_dataObject;


interface

uses
  Windows, SysUtils, Controls, StdCtrls,Variants, Classes, Forms, uTCPDatatype;

type

  TMode = (mdNormal,mdLocal);                                             // Mode
  Tphase = (fDefault, fBite, fGyroStarted, fGyroOff,                      // Fase Proses Penembakan
  fBeforeSelection, fBarrelDeselected, fBarrelSelected, fPreStandBy);

  TPwr = (stOFF,stON);                                                    // Status Kondisi Power

   TShipData = record                                                     // data Kapal
    Source: string;
    Heading, Speed: Integer;
  end;

  TTacticalData = record                                                  // TacticalData
   MHP, OptCrs, TimeDrop: Integer;
  end;



  // Input data Setting Error
  TErrorMsg = record                                                      // data indikasi Error
    code : Integer;
    Msg : String;
  end;




var
 EdtTgtData : array [1..6,1..5]of TWinControl;

 // Asumsi Data Error
 ListErrorTorpGyro, ListErrorSlcBarrel, ListCbbSetBrl : TList;

 // Read Error var
 ErrorTpoGyro, ErrorSlctbarrel    : TErrorMsg;
 ErrorTIU1,ErrorTIU2              : string;
 AnglePort, AngleStbd             : Integer;
 TmpPort, TmpStbd                 : Integer;
 StateTorp                        : array [1..6] of integer;

implementation

end.
