unit uConst;

interface

const
  //aPort = '5001';
  aPort = '2120';

  BUFFER_SIZE = 1024 * 1024 * 20;
  PACKET_PASS = 'SKL';

  //REC_POSITION = 1;
  //REC_ORDER = 2;
  REC_POSITION = 2;
  REC_ORDER = 3;
  REC_SET_EXOCET = 4;
  REC_SET_CHAFF = 5;
  REC_SET_ASROCK = 6;
  REC_ORD_NOVAL = 40;
  REC_ENVI = 34;

  /// constant order
  ORD_ENGINE = 10; // ...
  ORD_NETWORK = 11;
  ORD_THROTTLE = 21; // ...
  ORD_RUDDER = 22;
  ORD_LIOD_LR = 31; // ...
  ORD_LIOD_UD = 32;
  ORD_LIOD_Z = 33;
  ORD_LIOD_SBO = 34;
  ORD_MERIAM_L = 41; // meriam left
  ORD_MERIAM_R = 42; // meriam right
  ORD_MERIAM_U = 43; // meriam up
  ORD_MERIAM_D = 44; // meriam down
  ORD_MERIAM_F = 45; // meriam fire
  ORD_PERISKOP_LR = 51; // ...
  ORD_PERISKOP_UD = 52;
  ORD_PERISKOP_ZOOM = 53;
  ORD_EXOCET = 61;
  ORD_CHAFF_LR = 71; // chaff elevation
  ORD_CHAFF_FIRE = 72; // fire center 1
  ORD_HARPOON = 81;
  ORD_HARPON_SB = 82; // set bearing
  ORD_ASROCK_ASSIGNED = 101; // Asrock Assign
  ORD_ASROCK_DEASSIGNED = 102; //Asrock Deassign
  ORD_ASROCK = 103; // Asrock Fire
  IMAGES_PATH = '../data/images/';

  ORD_ENVI = 54;

type
  tDouble3DPoint = record
    X, Y, Z: double;
  end;

  TPacketCheck = record
    ID: byte;
    Pass: array[0..2] of char;
  end;

  {
  TRecDataPosition = record
    pc: TPacketCheck;
    UID: word;
    position: tDouble3DPoint;
    heading: single;
    speed: single;
  end;
  }

  TRecDataPosition = record
    pc: TPacketCheck;
    UID: string[15];
    position: tDouble3DPoint;
    heading: single;
    speed: single;
    pitch : single;
    roll : single;
    fuel: single;
    status: byte;
  end;

  TRecDataOrder = record
    pc: TPacketCheck;
    shipID: word;
    sOrder: byte;
    mValue: single;
  end;

  TRecDataOrder_noval = record
     ID : Byte;
     Pass : array[0..2] of char;
     order : Byte;
  end;

  TRecDataEnvironment = record
    pc: TPacketCheck;
    windVelocity: Double;
    windHeading: Double;
    seaCurrentVelocity: Double;
    seaCurrentHeading: Double;
    temperature: Double;
    humidity: Double;
    surfacePressure: Double;
  end;

  TRecSetExocet = record
    pc: TPacketCheck;
    shipID: word;
    sOrder: byte;
    mCountID: single;
    mProxFuze: single;
    mAltitude: single;
    mSearchArea: single;
    mRTG: single;
    mManualWidth: single;
    mSelecDepth: single;
    mTBearing: single;
    mTRange: single;
  end;

  TRecSetChaff = record
    pc: TPacketCheck;
    ShipID: word;
    OrderID: byte;
    mCountID: integer;
    mDegreeRate: single;
    mPart: integer;
    mPartNo: integer;
  end;

  TRecSetAsrock = record
    pc: TPacketCheck;
    ShipID: word;
    OrderID: byte;
    mCountID: integer;
    mTargetBearing: single;
    Elevation: single;
    Radius: single;
  end;

  //TCPT_POSITION = procedure(apRec: PAnsiChar; aSize: integer) of object;
  //TCPT_ORDER = procedure(aRec: TRecDataOrder) of object;

implementation

end.

