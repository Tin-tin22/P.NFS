unit uData;

interface

type
   TRecTIVariant1 = record
      MovingCompTI : Integer;
      DistTarget : Double;                    // in meter
      BearingTarget : Double;                 // in degree
      HeadingTarget : Double;                 // in degree
      SpeedTarget : Double;                   // in m/s
      MRSE_distTarget : Double;
      MRSE_bearingTarget : Double;
      MRSE_headingTarget : Double;
      MRSE_speedTarget : Double;
      AgeingTimeDataTarget : Double;
      TypeTarget : Integer;
      CoreRadius : Double;
      QuantityOfShipInCore : Integer;
      QuantityOfShipInFormation : Integer;
   end;

   TRecTIVariant2 = record
      MovingCompTI : Integer;
      LongTarget : Double;
      LattTarget : Double;
      MRSE_posTarget : Double;
      HeadingTarget : Double;                 // in degree
      Speedtarget : Double;                   // in m/s
      MRSE_headingTarget : Double;
      MRSE_speedTarget : Double;
      AgeingTimeDataTarget : Double;
      TypeTarget : Integer;
      CoreRadius : Double;
      QuantityOfShipInCore : Integer;
      QuantityOfShipInFormation : Integer;
   end;

implementation

end.
