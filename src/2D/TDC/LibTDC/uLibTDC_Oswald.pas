unit uLibTDC_Oswald;

interface

uses
  Forms, Graphics, uLibTDCClass, ufQEK, ufMIK_Owa,  ufANDUDisplay, DA05, RCR_radar_LW03,
  ufTorpedoOwa,
  uLibTDC_Object, uLibTDCTracks, uLibTDCDisplay,
  uTCPDataType,
  uBaseDataType, uBaseConstan, uTDCConstan;

{const
  C_SpeedMan = 0;
  C_SpeedAut = 1;
}
type


  TSelectType = (tstMan, tstAut);

  TTDC_Oswald = class;

  TTDCOwaData = class
  private
    FParent : TTDC_Oswald;

    FDEGS  : T2DPoint;

    FSysDateOffset   : TDateTime;
    FSysTimeOffset,
    FLocalTimeOffset : TDateTime;   /// selisih antara sistem time dan 'GMT time'

    FTGO : TSurfaceGrid;
    FDLRP: TSurfaceGrid;

    function getTimeGMT: TDateTime;
    procedure setTimeGMT(const Value: TDateTime);

    function getTimeLOC: TDateTime;

    function getTimeZone: Char;
    procedure setTimeZone(const Value: Char);

    function getDateGMT: TDateTime;
    procedure setDateGMT(const Value: TDateTime);

    function getTGO: T2DPoint;
    procedure setTGO(const Value: T2DPoint);

    function getDLRP: T2DPoint;
    procedure setDLRP(const Value: T2DPoint);
  public

    SpeedType   : TSelectType;
    SpeedManual : single;
    CourseType  : TSelectType;
    CourseMan   : single;

    PADS  : T2DPoint;

//
  public
    constructor Create(aParent : TTDC_Oswald) ;
    destructor Destroy; override;

    procedure SetCoord_DEG(const x, y: double);
    function GetCoord_DEG :T2DPoint;

    procedure SetCoord_DOG(const x, y: double);
    function GetCoord_DOG :T2DPoint;


  public
    property Time_GMT  : TDateTime read getTimeGMT write setTimeGMT;
    property Time_Local: TDateTime read getTimeLOC ;
    property TimeZone: Char read getTimeZone write setTimeZone;

    property Date_GMT : TDateTime read getDateGMT write setDateGMT;

    property TGO  : T2DPoint read getTGO write setTGO;
    property DLRP : T2DPoint read getDLRP write setDLRP;

  end;

  TRequestedData = record
    active   : boolean;
    reqIndex : byte;
    reqTrack : TTDCTrack;
    displ    : TfrmANDUDisplay;
  end;

  THarpoonSearchMode = (hsmAttackBoundary, hsmSearchArea);
  TDualDirection = (tdPort, tdStarBoard);

  THarpoonEngageData  = record
    active   : boolean;
    engTrack   : TManualTrack;
    engSendUpdate : boolean;
    engUpdateCounter: Double;
    displ    : TfrmANDUDisplay;
    // diisi dari MIK > setting di harpoon command panel
    LaunchMode : TLaunchMode;               // RBL, BOL
    SearchMode : THarpoonSearchMode;         // SA, AB
    SearchArea : TLetterSize;               // smalL, medium, large
    RecSearchArea : TLetterSize;
    LauncherTube  :  TDualDirection;                          //PT , SB
    Reserve1, reserve2 : string;
  end;

  THarpoonCorrection  = record
     //WND OOO 00 TMP .....
     windCourse,
     windSpeed  : double;
     tmp   : double;
  end;

//==============================================================================
  TTDC_Oswald = class(TGenericTDCInterface)
  protected
    FForms : array[1..8] of TfrmQEK;

    frmMIK_Kanan : TfrmMIK_Owa;
    frmDisplay_kanan : TfrmANDUDisplay;

    frmMIK_Kiri : TfrmMIK_Owa;
    frmDisplay_Kiri : TfrmANDUDisplay;

    reqLeft, reqRight  : TRequestedData;

    procedure CreateForms_0;
    procedure CreateForms_1;
    procedure CreateForms_2;
    procedure CreateForms_3;
    procedure CreateForms_4;

    procedure UpdateDataRequest(dtReq: TRequestedData);
    procedure UpdateDataEngage(dtEng: THarpoonEngageData);
  public
    fTengahBawah : TfrmQEK;
    frmDA05      : TFrm_DA05;
    frmLW03      : TFrm_RCR_radar_LW03;
    frmTorpOWA   : TfrmTorpOWA;
    OWA_DATA : TTDCOwaData;

    MaxShipTID : byte;

    // HArpoon Engagment
    HarpoonEngageBox: TEngagementBox;

{    engTrack   : TManualTrack;
    engSendUpdate : boolean;
    engUpdateCounter: Double;
}
    harpoonData: THarpoonEngageData;
    harpoonCorr: THarpoonCorrection;



    constructor Create;
    destructor Destroy; override;

    procedure Initialize; override;

    procedure Run(aDt: double);                override;
    procedure Walk;                            override;

    procedure CreateFormss(const num: byte); override;
    procedure ShowAllForm; override;
    procedure SetDefaultLayOut; override;
    procedure ShowFormBawahOWA; override;
    procedure HideFormBawahOWA; override;

    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_right(const b: byte); override;

    procedure DR_OBM_right(const b: Boolean); override;
    procedure DR_OBM_left(const b: Boolean); override;
    procedure DR_OCM_right; override;
    procedure DR_OCM_left; override;

    procedure ChangeShipTrackID(const sid, msid: byte);

    procedure ConvertViewPosition;  override;
    procedure Draw(aCnv : TCanvas); override;
    procedure DeleteMTrack(var trck: TManualTrack); override;

    procedure SetHarpoonEngage(aRec: TRecTrackOrder; send: boolean; tag: byte=0); override;
    procedure SendUpdateHarpoon(const tMode: TEngageStatus); // update ke sesama HDC

    procedure SendHarpoonPanelState(const stateID, stateValue: byte);
    procedure RecvHarpoonSetting(aRec: TRecHarpoonPanelSetting); override;
//    procedure SendHarpoonPanelState(const stateID, stateValue: byte);
  end;


implementation

uses
  Classes, windows, SysUtils, ufTDCTengah, uFormUtil,
  uRadarTracks,
  uTrackFunction,
  ufDisplay_OWA,
  ufTDCTengah_OWA,
  ufTDCTengahBawah_OWA,
  ufOwa_1, ufOwa_2, ufOwa_3, ufOwa_4,
  ufOwa_5, ufOwa_6, ufOwa_7, ufOwa_8, Math, uBaseSimulationObject,
  uBaseFunction;

//==============================================================================

function TimeDiffToZone(const timeDif : integer): char;
const
  C_TimeZone_plus : array [1 .. 12] of char =
//    1,  2,  3,  4,    5,  6,  7,  8,     9,  10, 11, 12,  0
    ('A','B','C','D',  'E','F','G','H',   'I','K','L','M');
//  , 'Z',
  C_TimeZone_min : array [1 .. 12] of char =
//   -1, -2, -3, -4,   -5, -6, -7, -8,    -9, -10,-11,-12
    ('N','O','P','Q',  'R','S','T','U',   'V','W','X','Y');

var db : byte;
begin
  result := 'Z';
  db := byte(abs(timeDif));

  if (timeDif > -13) and (timeDif < 0) then
    result := C_TimeZone_Min[db]
  else
  if (timeDif > 0) and (timeDif < 13) then
    result := C_TimeZone_plus[db];
end;

function TimeZoneToDiff(const tz: char): integer;
var c : char;
begin
   c := UpCase(tz);
   result := 0;
   case c of
   'Z' : result := 0;
   'A' .. 'M' : result := Ord(c) - 64;
   'N' .. 'Y' : result := -(Ord(c) - 76);
   end;
end;

//==============================================================================
{ TTDC_Oswald }

constructor TTDC_Oswald.Create;
const
  osw_1_caption = ' osw TDC 1';
begin
  GunNumber := 2;

  inherited;

  frmTengah  :=  TfrmTDCTengah_OWA.Create(nil);
  frmTengah.Caption := ' KRI Oswald Siahaan';
  (frmTengah as TfrmTDCTengah).TDCInterface := self;

  fTengahBawah := TfrmTengahBawah_OWA.Create(nil);
  fTengahBawah.TDCInterface := self;
  reqLeft.active := FALSE;
  reqRight.active := FALSE;

  HarpoonEngageBox := TEngagementBox.Create;
  HarpoonEngageBox.Enabled := FALSE;
  HarpoonEngageBox.Visible := FALSE;

  with harpoonData do begin
    engTrack   :=  nil;
    engSendUpdate := false;
    engUpdateCounter:= 0.0;
  end;

  with harpoonCorr do begin
    windCourse := 0;
    windSpeed  := 0;
    tmp := 30;
  end;
end;


destructor TTDC_Oswald.Destroy;
var i: integer;
begin
  HarpoonEngageBox.Free;

  for i := 1 to 7 do
    if Assigned(FForms[i]) then FForms[i].Free;

  FreeAndNil(frmDA05);
  FreeAndNil(frmLW03);
  FreeAndNil(frmTorpOWA);
  FreeAndNil(fTengahBawah);
  FreeAndNil(frmTengah);
  OWA_DATA.Free;
  inherited;
end;

procedure TTDC_Oswald.Initialize;
begin
  inherited;

  OWA_DATA := TTDCOwaData.Create(self);

  with OWA_DATA do begin
    SpeedType  := tstAUT;
    CourseType := tstAUT;
  end;

end;

procedure TTDC_Oswald.CreateFormss(const num: byte);
begin
  FForms[1] := TfrmOwa_1.Create(nil);
  FForms[1].TDCInterface := self;
  FForms[2] := TfrmOwa_2.Create(nil);
  FForms[2].TDCInterface := self;
  FForms[3] := TfrmOwa_3.Create(nil);
  FForms[3].TDCInterface := self;
  FForms[4] := TfrmOwa_4.Create(nil);
  FForms[4].TDCInterface := self;
  FForms[5] := TfrmOwa_5.Create(nil);
  FForms[5].TDCInterface := self;
  FForms[6] := TfrmOwa_6.Create(nil);
  FForms[6].TDCInterface := self;
  FForms[7] := TfrmOwa_7.Create(nil);
  FForms[7].TDCInterface := self;
  FForms[8] := TfrmOwa_8.Create(nil);
  FForms[8].TDCInterface := self;

  frmDA05 := TFrm_DA05.Create(nil);
  frmDA05.TDCInterface := self;
  frmLW03 := TFrm_RCR_radar_LW03.Create(nil);
  frmLW03.TDCInterface := self;

  frmTorpOWA := TfrmTorpOWA.Create(nil);
  frmTorpOWA.TDCInterface := self;

  if num = 1 then CreateForms_1
  else if num = 2 then CreateForms_2
  else if num = 3 then CreateForms_3
  else if num = 4 then CreateForms_4;


end;
//==============================================================================

procedure TTDC_Oswald.ShowAllForm;
var i: integer;
begin
  //for i := 1 to 8 do
  //  if Assigned(FForms[i]) then FForms[i].Show;

  if Assigned(frmTengah) then  frmTengah.Show;
  if Assigned(fTengahBawah) then  fTengahBawah.Show;

  if Assigned(frmMIK_Kanan )then frmMIK_Kanan.Show;
  HideFormBawahOWA;

//  if Assigned(frmMIK_Kiri     )then frmMIK_Kiri.Show;
  if Assigned(frmDisplay_kanan  )then frmDisplay_kanan.Show;

  if Assigned(frmMIK_Kiri)     then frmMIK_Kiri.Show;
  if Assigned(frmDisplay_Kiri) then frmDisplay_Kiri.Show;

end;


procedure TTDC_Oswald.SetDefaultLayOut;
begin
  case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apCenter      , 0 , 0 , TForm(frmTengah ));
      AlignFormToMonitor(0, apCenterBottom, 0 , 0 , TForm(fTengahBawah ));

    end;
    2 : begin
      AlignFormToMonitor(0, apCenter  , 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(0, apCenterBottom      , 0 , 0 , TForm(fTengahBawah ));

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(1, apLeftTop  , 0, frmDisplay_kanan.Height, TForm(frmMIK_Kanan ));
    end;
    3 : begin
      AlignFormToMonitor(1, apCenter, 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(1, apCenterBottom, 0, 0, TForm(fTengahBawah ));

      AlignFormToMonitor(2, apLeftBottom,   0, 0, TForm(FForms[1]));
      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[2]));

      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[4]));
      AlignFormToMonitor(2, apLeftBottom,   0, 0, TForm(FForms[5]));

      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[3]));
      AlignFormToMonitor(2, apLeftBottom,   0, 0, TForm(FForms[6]));

      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[7]));
      AlignFormToMonitor(2, apLeftBottom,   0, 0, TForm(FForms[8]));

      AlignFormToMonitor(2, apLeftTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(2, apLeftTop  , 0, frmDisplay_kanan.Height, TForm(frmMIK_Kanan ));

      AlignFormToMonitor(0, apRightTop  , 0, 0, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(0, apRightTop  , 0, frmDisplay_kiri.Height, TForm(frmMIK_Kiri ));

      AlignFormToMonitor(0, apRightTop,  0, 0, TForm(frmDA05));
      AlignFormToMonitor(0, apRightTop,  0, 0, TForm(frmLW03));
      AlignFormToMonitor(0, apRightTop,  0, 0, TForm(frmTorpOWA));

    end;
  end;
end;

procedure TTDC_Oswald.ShowFormBawahOWA;
begin
  TfrmTengahBawah_OWA(fTengahBawah).setMaxPosition(TfrmTDCTengah_OWA(frmTengah));
end;

procedure TTDC_Oswald.HideFormBawahOWA;
begin
  TfrmTengahBawah_OWA(fTengahBawah).setPosition(TfrmTDCTengah_OWA(frmTengah));
end;

procedure TTDC_Oswald.CreateForms_0;
begin
  frmDisplay_kanan  := TfrmDisplay_Owa.Create(nil);
  frmDisplay_kanan.Caption := 'Alpha Numerik Display Unit';
  (frmDisplay_kanan as TfrmDisplay_Owa).iTDC := self;

  frmMIK_Kanan      := TfrmMIK_Owa.Create(nil);
  frmMIK_Kanan.TDCInterface := self;
  frmMIK_Kanan.OBM := OBMRight;
  frmMIK_Kanan.Display := frmDisplay_kanan;

  frmDisplay_kanan.FOnExecuteCmd :=  frmMIK_Kanan.handle_execute;

  frmDisplay_Kiri  := TfrmDisplay_Owa.Create(nil);
  frmDisplay_Kiri.Caption := 'Alpha Numerik Display Unit';
  (frmDisplay_Kiri as TfrmDisplay_Owa).iTDC := self;


  frmMIK_Kiri      := TfrmMIK_Owa.Create(nil);
  frmMIK_Kiri.TDCInterface := self;
  frmMIK_Kiri.OBM := OBMLeft;
  frmMIK_Kiri.Display := frmDisplay_Kiri;

  frmDisplay_Kiri.FOnExecuteCmd :=  frmMIK_Kiri.handle_execute;

  reqLeft.displ := frmDisplay_Kiri;
  reqRight.displ :=  frmDisplay_kanan;


end;

procedure TTDC_Oswald.CreateForms_1;
const
  caption_1 = ' OWA HDC 1';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[7].Show;
  FForms[7].Caption          := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  FForms[8].Show;
  FForms[8].Caption := caption_1 + C_Kanan;

  frmTorpOWA.Show;
  frmTorpOWA.Caption := 'Panel Torpedo OWA';

end;

procedure TTDC_Oswald.CreateForms_2;
const
  caption_1 = ' OWA HDC 2';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[4].Show;                                //engg
  FForms[4].Caption := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  FForms[5].Show;
  FForms[5].Caption          := caption_1 + C_Kanan;

  //frmLW03.Show;
  //frmLW03.Caption := 'Panel Radar LW-03';
  harpoonData.displ := frmDisplay_Kiri;
end;

procedure TTDC_Oswald.CreateForms_3;
const
  caption_1 = ' OWA HDC 3';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[3].Show;
  FForms[3].Caption := caption_1 + C_Kiri;       //engg

  //- TDC 1 Kanan -//
  FForms[6].Show;
  FForms[6].Caption          := caption_1 + C_Kanan;

  frmDA05.Show;
  frmDA05.Caption := 'Panel Radar DA-05';
  harpoonData.displ := frmDisplay_Kiri;

end;

procedure TTDC_Oswald.CreateForms_4;
const
  caption_1 = ' OWA HDC 4';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[4].Show;
  FForms[4].Caption := caption_1 + C_Kiri;        //engg

  //- TDC 1 Kanan -//
  FForms[1].Show;
  FForms[1].Caption          := caption_1 + C_Kanan;

end;

procedure TTDC_Oswald.DataRequest_Left(const b: byte);
var cTrack : TTDCTrack;
    s : string;
begin
   if FindTrack_by_screenpos(OBMLeft.Center.X, OBMLeft.Center.Y, cTrack) then begin
     reqLeft.reqIndex := b;
     reqLeft.reqTrack := cTrack;
     reqLeft.active := TRue;
  end
  else begin
    reqLeft.reqTrack := nil;
    reqLeft.active := FALSE;
  end;

end;

procedure TTDC_Oswald.DataRequest_right(const b: byte);
var cTrack:TTDCTrack;
    s : String;
begin
  if FindTrack_by_screenpos(OBMRight.Center.X, OBMRight.Center.Y, cTrack) then begin
     reqRight.reqIndex := b;
     reqRight.reqTrack := cTrack;
     reqright.active := TRue;
  end
  else begin
     reqRight.reqTrack := nil;
     reqright.active := FALSE;
  end;
end;

procedure TTDC_Oswald.DR_OBM_right(const b: Boolean);
var s       :String;
    cIdent  :Char;
    dX,dY   :Double;
begin
  if b then begin
    if initiateSurfaceGrid(xSHIP.PositionX,xSHIP.PositionY) then begin
      s := ' ';
    end;

    SGO.ConvertLatLongToSGO(OBMRight.mPos.X,OBMRight.mPos.Y,cIdent,dX,dY);
    s := formatDR_OBM(OBMRight.mPos.X,OBMRight.mPos.Y,cIdent,dX,dY);
    frmDisplay_kanan.SetDRLText(s);
  end
  else begin
    frmDisplay_kanan.SetDRLText('');
  end;
end;

procedure TTDC_Oswald.DR_OBM_left(const b: Boolean);
var s       :String;
    cIdent  :Char;
    dX,dY   :Double;
begin
  if b then begin
    if initiateSurfaceGrid(xSHIP.PositionX,xSHIP.PositionY) then begin
      s := ' ';
    end;

    SGO.ConvertLatLongToSGO(OBMLeft.mPos.X,OBMLeft.mPos.Y,cIdent,dX,dY);
    s := formatDR_OBM(OBMLeft.mPos.X,OBMLeft.mPos.Y,cIdent,dX,dY);
    frmDisplay_kiri.SetDRLText(s);
  end
  else begin
    frmDisplay_kiri.SetDRLText('');
  end;
end;

procedure TTDC_Oswald.DR_OCM_right;
var s:String;
begin
  s := formatDR_OCM(Cursorss.Heading,Cursorss.Distance * C_NM_To_DM);
  frmDisplay_kanan.SetDRLText(s);
end;

procedure TTDC_Oswald.DR_OCM_left;
var s:String;
begin
  s := formatDR_OCM(Cursorss.Heading,Cursorss.Distance * C_NM_To_DM);
  frmDisplay_kiri.SetDRLText(s);
end;

procedure TTDC_Oswald.Run(aDt: double);
var ptShip: t2DPoint;
begin
  inherited;

  ptShip.X := xShip.PositionX;
  ptShip.Y := xShip.PositionY;

  OWA_DATA.SetCoord_DEG(xShip.PositionX, xShip.PositionY);

  if HarpoonEngageBox.Visible then begin
    HarpoonEngageBox.Run(aDt);
    HarpoonEngageBox.Org := ptShip;

    with harpoonData do begin
      if engTrack <> nil then
        HarpoonEngageBox.HeadingNorth := CalcBearing(HarpoonEngageBox.Org.X, HarpoonEngageBox.Org.Y, engTrack.PositionX, engTrack.PositionY);

      if engSendUpdate then begin
        engUpdateCounter := engUpdateCounter + aDt;

      if (engUpdateCounter > 1000.0) then begin
        engUpdateCounter  := engUpdateCounter - 1000.0;
        SendUpdateHarpoon(HarpoonEngageBox.EngageMode);
        UpdateDataEngage(harpoonData);
        
      end
    end
  end
end;

end;

procedure TTDC_Oswald.Walk;
begin
//  inherited;

  if reqLeft.active then  UpdateDataRequest(reqLeft) ;
  if reqRight.active then  UpdateDataRequest(reqRight) ;

  if harpoonData.active then begin
     UpdateDataEngage(harpoonData);
  end;

end;

procedure TTDC_Oswald.UpdateDataRequest(dtReq: TRequestedData);
var mTrack : TManualTrack;
    eTrack : TESMBearingTrack;
    b : byte;
    s : string;
begin
  if not dtReq.active then exit;
  if  not assigned(dtReq.reqTrack) then exit;

  if dtReq.reqTrack is TManualTrack then begin
    mTrack := dtReq.reqTrack as TManualTrack;
     s:= ' ';
     case dtReq.reqIndex of
      1 : begin
        // DR pertama
        s := formatOWA_SCR(mTrack)
      end;
      2: begin
        // DR kedua
        if (mTrack.Domain = tdAtasAir) or (mTrack.Domain = tdUdara) then
            s := formatOWA_ACR_IFF(mTrack)
        else if (cTrack.Domain = tdBawahAir) then
            s := formatOWA_ACR_ESM(mTrack)
      end;
      3: begin
        // DR ketiga
        if (mTrack.Domain = tdAtasAir) or (mTrack.Domain = tdUdara) then
            s := formatOWA_ACR_ESM(mTrack)
        else if (mTrack.Domain = tdBawahAir) then
            s := formatOWA_ACR_PVC(mTrack)

      end;
      4: begin
        // DR keempat
          if (mTrack.Domain = tdAtasAir) or (mTrack.Domain = tdUdara) then
              s := formatOWA_ACR_PVC(mTrack)
      end;
    end;

    dtReq.displ.SetDRLText(s);
  end
  else if dtReq.reqTrack  is TESMBearingTrack then begin
     case dtReq.reqIndex of
      1:  s := formatOWA_SCR_bearing(cTrack as TESMBearingTrack);
      2 : s := formatOWA_PVC_bearing(cTrack as TESMBearingTrack);
      else  s:= ' ';
     end;
     dtReq.displ.SetDRLText(s);
   end;
end;

procedure TTDC_Oswald.UpdateDataEngage(dtEng: THarpoonEngageData);
begin
//  dtEng.displ.SetUpdateHarpoonEngaged(sI, sJ, sK: string);
//

end;


procedure TTDC_Oswald.ConvertViewPosition;
begin
  inherited;
  HarpoonEngageBox.ConvertDataPosition(FMap);

end;

procedure TTDC_Oswald.Draw(aCnv: TCanvas);
begin
  inherited;
  if HarpoonEngageBox.Visible then
    HarpoonEngageBox.Draw(aCnv);


end;

procedure TTDC_Oswald.DeleteMTrack(var trck: TManualTrack);
begin
  inherited;

  with harpoonData  do
  if trck = engTrack then engTrack := nil;

end;


procedure TTDC_Oswald.SendHarpoonPanelState(const stateID,
  stateValue: byte);
var aRec: TRecHarpoonPanelSetting;
begin
{
  aRec.ShipID := xSHIP.UniqueID;
  aRec.OrderID   := stateID;
  aRec.OrderData := stateValue;
  netSend.sendDataEx(C_REC_HARPOON_SETTING, @aRec);
}
end;

procedure TTDC_Oswald.RecvHarpoonSetting(aRec: TRecHarpoonPanelSetting);
begin

  if aRec.ShipID <> xShip.UniqueID then exit;
  if aRec.OrderID <= OrdHpn_Selected then exit;

   if aRec.OrderID = OrdHpn_Sel_Area  then begin
      case aRec.OrderData of
       1 : begin
         harpoonData.LaunchMode := lmBOL;
//         harpoonData.SearchArea :=  whatever!
       end;
       2 : begin
         harpoonData.LaunchMode := lmRBL;
         harpoonData.SearchArea := szSmall;
       end;
       3 : begin
         harpoonData.LaunchMode := lmRBL;
         harpoonData.SearchArea := szMedium;
       end;
       4 : begin
         harpoonData.LaunchMode := lmRBL;
         harpoonData.SearchArea := szLarge;
       end;

     end;

  end ;

end;

{ TTDCOwaData }

constructor TTDCOwaData.Create(aParent : TTDC_Oswald);
begin
  FParent := aParent;

  PADS.X := 0;
  PADS.Y := 0;

  FSysDateOffset   := 0;
  FSysTimeOffset   := -7/24 ;
  FLocalTimeOffset := +7/24;

  FTGO := TSurfaceGrid.Create;
  FTGO.CreateDefaultView(FParent.FMap);
  FTGO.Enabled := true;
  FTGO.Symbol.Visible := true;
  FTGO.Lbl.Line.Text := '';

  FParent.TrackList.AddObject(FTGO);


  FDLRP := TSurfaceGrid.Create;
  FDLRP.CreateDefaultView(FParent.FMap);
  FDLRP.Enabled := true;
  FDLRP.Symbol.Visible := true;
  FDLRP.Lbl.Line.Text := '';
  FParent.TrackList.AddObject(FDLRP);

end;

destructor TTDCOwaData.Destroy;
begin

end;

function TTDCOwaData.GetCoord_DEG: T2DPoint;
begin
  result.X :=  FDEGS.X;
  result.Y :=  FDEGS.Y;
end;

procedure TTDCOwaData.SetCoord_DEG(const x, y: double);
begin
   FDEGS.X := X;
   FDEGS.Y := Y;
end;

function TTDCOwaData.GetCoord_DOG: T2DPoint;
begin
  result.X :=  FDEGS.X - PADS.X;
  result.Y :=  FDEGS.Y - PADS.Y;
end;

procedure TTDCOwaData.SetCoord_DOG(const x, y: double);
begin
  PADS.X := FDEGS.X - X;
  PADS.X := FDEGS.Y - Y;
end;


function TTDCOwaData.getTimeGMT: TDateTime;
begin
  result := Time()  + FSysTimeOffset;
end;

procedure TTDCOwaData.setTimeGMT(const Value: TDateTime);
begin
  FSysTimeOffset := Value -  Time();
end;

function TTDCOwaData.getTimeLOC: TDateTime;
begin
  result := Time_GMT + FLocalTimeOffset;
end;

function TTDCOwaData.getTimeZone: Char;
begin
  result := TimeDiffToZone(Round(FLocalTimeOffset * 24));
end;

procedure TTDCOwaData.setTimeZone(const Value: Char);
begin
  FLocalTimeOffset :=  TimeZoneToDiff(Value) / 24;
end;

function TTDCOwaData.getDateGMT: TDateTime;
begin
  result := FSysDateOffset + Date();
end;

procedure TTDCOwaData.setDateGMT(const Value: TDateTime);
begin
  FSysDateOffset  := Value - Date();
end;

function TTDCOwaData.getTGO: T2DPoint;
begin
  result.X :=  FTGO.PositionX;
  result.Y :=  FTGO.PositionY;
end;

procedure TTDCOwaData.setTGO(const Value: T2DPoint);
begin
  FTGO.SetOrigin(Value.X, Value.Y);
end;

function TTDCOwaData.getDLRP: T2DPoint;
begin
  result.X :=  FDLRP.PositionX;
  result.Y :=  FDLRP.PositionY;
end;

procedure TTDCOwaData.SetDLRP(const Value: T2DPoint);
begin
  FDLRP.SetOrigin(Value.X, Value.Y);
end;

procedure TTDC_Oswald.ChangeShipTrackID(const sid, msid: byte);
var i: integer;
    track: TRadarTrack;
    l : TList;
begin
   l := TrackList.GetList;

   for i := 0 to l.Count-1 do begin
     track := l.Items[i];
     if track is TTDCTrack then
      with (track as TTDCTrack) do
        SetTrackNumber(sid, TrackNumber);
   end;

   TrackList.ReturnList;

end;

procedure TTDC_Oswald.SetHarpoonEngage(aRec: TRecTrackOrder; send: boolean;
            tag: byte=0);
var pt  : TPoint;
    findTrack : boolean;
    tMode: TEngageStatus;
    tSend: TSendStatus;
begin
  // OrderType: teTrialReview, teEngage, teCeaseEngage
  // TrackNumber : tssCreate, tssUpdate

  pt := ConvertToScreen(aRec.X, aRec.Y);
  if send then begin                    // send to other tdc
    aRec.ShipID := xSHIP.UniqueID;
    aRec.OrderID := OrdID_assign_engBox;

    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
    if findTrack and (cTrack is TManualTrack) then begin
      mTrack := (cTrack as TManualTrack);

      tMode := TEngageStatus(aRec.OrderType);
      case tMode of
        teTrialReview, teEngage: begin  // assign ssm/harpoon
          aRec.TrackNumber := Byte(tssCreate);

          with harpoonData  do begin

            engTrack := mTrack;
            engUpdateCounter := 0.0;
            engSendUpdate    := true;
            active := true;
            if tag = 0 then
              displ := frmDisplay_Kiri
            else
              displ := frmDisplay_kanan;
            (displ as TfrmDisplay_Owa).SetUpdateHarpoonEngaged('', '', '');
          end
        end;
        teCeaseEngage: begin            // deassign ssm/harpoon
          with harpoonData  do begin
            engTrack := nil;
            engSendUpdate := False;
            active := false;
          end;
        end;
      end;

      netSend.sendDataEx(C_REC_TRACK_ORDER, @aRec);
    end
  end
  else begin
    findTrack := FindTrack_by_screenpos(pt.X, pt.Y, cTrack);
    if findTrack and (cTrack is TManualTrack) then begin
      mTrack := (cTrack as TManualTrack);

      tMode := TEngageStatus(aRec.OrderType);
      case tMode of
        teTrialReview, teEngage: begin  // assign ssm/harpoon
          tSend := TSendStatus(aRec.TrackNumber);
          if tSend = tssCreate then
            HarpoonEngageBox.SetTime(200);

          HarpoonEngageBox.EngageMode := tMode;
          HarpoonEngageBox.HeadingNorth := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, aRec.X, aRec.Y);
          HarpoonEngageBox.UpdateOrigin(xSHIP.PositionX, xSHIP.PositionY, aRec.X, aRec.Y);

          harpoonData.engTrack := mTrack;
          HarpoonEngageBox.Visible := true;
          HarpoonEngageBox.Enabled := FALSE;

            if tag = 0 then
              harpoonData.displ := frmDisplay_Kiri
            else
              harpoonData.displ := frmDisplay_kanan;
          harpoonData.active := TRUE;


        end;
        teCeaseEngage: begin            // deassign ssm/harpoon
          HarpoonEngageBox.Visible := false;
          HarpoonEngageBox.Enabled := false;

          harpoonData.active := FALSE;
          harpoonData.engTrack := nil;
          harpoonData.engSendUpdate := False;
        end;
      end;
    end;
  end;
end;

procedure TTDC_Oswald.SendUpdateHarpoon(const tMode: TEngageStatus);
var aRec: TRecTrackOrder;
begin
  if Assigned(harpoonData.engTrack) then begin
    aRec.ShipID  := xSHIP.UniqueID;
    aRec.OrderID := OrdID_update_SSM;
    aRec.OrderType := Byte(tMode);
    aRec.TrackNumber := Byte(tssUpdate);

    aRec.X := CalcRange(xShip.PositionX, xShip.PositionY,
      harpoonData.engTrack.PositionX, harpoonData.engTrack.PositionY);

    aRec.Y := CalcBearing(xShip.PositionX, xShip.PositionY,
      harpoonData.engTrack.PositionX, harpoonData.engTrack.PositionY);

    netSend.sendDataEx(C_REC_ORDER_XY, @aRec);

  end;
end;

end.
