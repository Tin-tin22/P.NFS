unit uLibTDC_Nala;

interface

uses
  MapXLib_TLB,  Windows, uLibTDCClass, uLibTDCTracks,  ufQEK, ufMIK, ufANDUDisplay, uTCPDatatype,
  ExtCtrls, ASRLRCU, ufrmBckGround;

type
  TTDCData_CPA = record
//    Visible : boolean;  // display on display
    Display : TfrmANDUDisplay;
    LineNum : byte;

//    Active  : boolean;  // calc cpa
    Target  : TTDCTrack;

    TgtBearing, tgtRange : double;
    cpaBearing, cpaRange : double;
    cpaTime              : double;
  end;

//==============================================================================

  TRoketType = class
    public
    Available : Byte;
    Speed     : Byte;
    Fuze      : Byte;

    constructor Create;
    destructor Destroy; override;


  end;

//==============================================================================

  TTDC_NalaInterface = class (TGenericTDCInterface)
  private

  protected

    TimerJedaSalvo,
    TimerAssignASRL  : TTimer;

    procedure CreateForms_0;
    procedure CreateForms_1;
    procedure CreateForms_2;
  public

    frmKiri : TfrmQEK;
    frmKanan: TfrmQEK;

    frmASROC : TfrmASRL;

    frmMIK_Kiri : TfMIK;
    frmMIK_Kanan : TfMIK;

    frmDisplay_Kiri  : TfrmANDUDisplay;
    frmDisplay_Kanan : TfrmANDUDisplay;
    frmBackGround    : TfrmBackground;
    CPA_list: array [0..1] of TTDCData_CPA;

    ShipIDSalvo2,
    TargetShipID,
    TypeRoket        : word;
    TargetBearingSalvo2,
    TargetRangeSalvo2,
    TargetDepthSalvo2    : double;

    Delaytime           : Integer;
    Rocket1_Set_on,
    Rocket2_Set_on,
    IsusedRocket1,
    IsusedRocket2,
    IsASRLAssigned      : Boolean;
    Erika, Nelly : TRoketType;
    memo : string;

    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;
    procedure SetDefaultLayOut; override;

    procedure ShowAllForm; override;

    procedure CommonDataRequest(obm: tTdc_Symbol; display: TfrmANDUDisplay);
    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_Right(const b: byte); override;

    procedure CPA_start(const ix: byte; cTGT : TManualTrack);
    procedure CPA_show(const ix: byte; displ: TfrmANDUDisplay; const lin: byte);
    procedure Calc_n_Show_CPA(const ix: byte);

    procedure Walk;   override;
    procedure DeleteFC5;
//    procedure setAssignASRLToFC5(aRec: TRecTrackOrder; Msltype : Word);
    procedure setAssignASRL(aRec: TRecTrackOrder; Msltype : Word; const send: boolean= TRUE); override;
    procedure ReAssignASRL(Msltype: Word);

    procedure setDeAssignASRL(aRec: TRecTrackOrder; const send: boolean= TRUE); override;
    procedure SetFireAsroc(aRec: TRecTrackOrder; IDLauncher :integer; mMissileID : word; RocketType : Byte;  IsSalvo : boolean; const send:boolean= TRUE); override;// Added by Bagus   8-11
    procedure RecvASRLSetting(aRec: TRecStatus_Console); override;

    procedure JedaSalvoTimer(Sender: TObject);
    procedure GetCurrentDataTrackASRL(var getHeading :Single; var getRange : double; var getBearing : double);
//    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    procedure SendEvenAsroc(EvenId: Word; const Prm1 :double = 0; Prm2 : double = 0; Prm3: double = 0);

  end;

implementation

uses
  SysUtils, Forms, uFormUtil, ufTDC1Kanan, ufTDC1Kiri, ufTDC2Kanan, ufTDC2Kiri,
  uBaseConstan, uBaseDatatype, uBaseFunction, ufTDCTengah_Nala, ufDisplay_Nala,
  uTrackFunction, Math, uDetected, uSettingFormToMonitorWith_ini, Dialogs;

const
  C_maxPosID = 1;

//==============================================================================
  function Calc_CPA(const s1,c1, s2,c2, range,bearing : double;
                    var cpaRange, cpaTime: double): boolean;
  var DTR : double;
  var x,y,xVel,yVel,dot,a,b,cpa : double;
  begin
    result := false;

    dtr := pi / 180.0;

    x := range * cos(DTR*bearing);
    y := range * sin(DTR*bearing);

    xVel := s2 * cos(DTR* c2) - s1 * cos(DTR* C1);
    yVel := s2 * sin(DTR* c2) - s1 * sin(DTR* C1);

    dot := x * xVel + y * yVel;
    if (dot >= 0.0) then begin
       result := false; // "No further closure.";
       exit;
    end;

    a := xVel * xVel + yVel * yVel;
    b := 2 * dot;

    if (abs(a) < 0.0001) or (abs(b) >( 24 * abs(a))) then
      exit;
     // return "CPA > 12";
    cpa := range * range - ((b*b)/(4*a));

    if (cpa <= 0.0) then
      cpaRange := 0.0
    else
      cpaRange := sqrt(cpa);
    cpaTime   := 60*(-b/(2*a)); // + " minutes";

    result := true;
  end;

//==============================================================================
{ TTDC_NalaInterface }


constructor TTDC_NalaInterface.Create;
begin
  GunNumber := 3;
  Delaytime := 0;
  inherited;

  frmTengah  :=  TfrmTDCTengah_Nala.Create(nil);
  (frmTengah as TfrmTDCTengah_Nala).TDCInterface := self;

  frmTengah.Caption := ' Tactical Display Console';

  frmBackGround  := TfrmBackground.Create(nil);

  CPA_list[0].Display := nil;
  CPA_list[0].Target  := nil;

  CPA_list[1].Display := nil;
  CPA_list[1].Target  := nil;

  Erika := TRoketType.create;
  Nelly := TRoketType.create;
end;

destructor TTDC_NalaInterface.Destroy;
begin
  FreeAndNil(frmTengah);
  FreeAndNil(frmASROC);
  FreeAndNil(TimerJedaSalvo);
  FreeAndNil(TimerAssignASRL);
  FreeAndNil(frmBackGround);
  FreeAndNil(Erika);
  FreeAndNil(Nelly);
  inherited;
end;

procedure TTDC_NalaInterface.CreateForms_0;
begin
// ANDU Kiri
  frmMIK_Kiri      := TfMIK.Create(nil);
  frmMIK_Kiri.TDCInterface := self;
  frmMIK_Kiri.OBM := OBMleft;
  frmMIK_Kiri.PositionID :=  C_key_kiri;

  frmDisplay_Kiri  := TfrmDisplay_NALA.Create(nil);
  frmMIK_Kiri.Display := frmDisplay_Kiri;

  frmDisplay_Kiri.FOnExecuteCmd :=  frmMIK_Kiri.handle_execute;
  frmDisplay_Kiri.Caption := 'ANDU '+ MyShipName + '  kiri';

// ANDU kanan
  frmMIK_Kanan      := TfMIK.Create(nil);
  frmMIK_Kanan.TDCInterface := self;
  frmMIK_Kanan.OBM := OBMRight;
  frmMIK_Kiri.PositionID :=  C_key_kanan;

  frmDisplay_Kanan  := TfrmDisplay_NALA.Create(nil);
  frmMIK_Kanan.Display := frmDisplay_Kanan;

  frmDisplay_Kanan.FOnExecuteCmd :=  frmMIK_Kanan.handle_execute;
  frmDisplay_Kanan.Caption := 'ANDU '+ MyShipName + '  kanan';
  frmTengah.Caption := ' Tactical Display Console ' + MyShipName;
end;

procedure TTDC_NalaInterface.CreateForms_1;
var
  caption_1 : string;
begin
  inherited;
  CreateForms_0;
  caption_1 := MyShipName + ' 1 ';

  //- TDC 1 Kiri  -//
  frmKiri         := TfrmTDC1Kiri.Create(nil);
  frmKiri.TDCInterface := self;
  frmKiri.Caption           := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  frmKanan         := TfrmTDC1Kanan.Create(nil);
  frmKanan.TDCInterface := self;
  frmKanan.Caption          := caption_1 + C_Kanan;

  frmASROC       := TfrmASRL.Create(nil);
  frmASROC.TDC   := self;

  TimerJedaSalvo := TTimer.Create(nil);
  TimerJedaSalvo.Enabled := False;
  TimerJedaSalvo.Interval:= 1000;
  TimerJedaSalvo.OnTimer := JedaSalvoTimer;
end;

procedure TTDC_NalaInterface.CreateForms_2;
var
  caption_2 : string;
begin
  inherited;

  CreateForms_0;
  caption_2 := MyShipName + ' 2 ';

  //- TDC 2 Kanan -//
  frmKanan              := TfrmTDC2Kanan.Create(nil);
  frmKanan.TDCInterface := self;
  frmKanan.Caption      := caption_2 + C_Kanan;

  //- TDC 2 Kiri  -//
  frmKiri               := TfrmTDC2Kiri.Create(nil);
  frmKiri.TDCInterface  := self;
  frmKiri.Caption           := caption_2 + C_Kiri;

  frmASROC       := TfrmASRL.Create(nil);
  frmASROC.TDC   := self;

end;

procedure TTDC_NalaInterface.CreateFormss(const num: byte);
begin
  if num = 1 then CreateForms_1
  else if num = 2 then CreateForms_2;
end;

procedure TTDC_NalaInterface.ShowAllForm;
begin
//  inherited;
  if Assigned(frmTengah) then  frmTengah.Show;
  if Assigned(frmKiri)   then  frmKiri.Show;
  if Assigned(frmKanan)  then  frmKanan.Show;

  if Assigned(frmMIK_Kanan)then frmMIK_Kanan.Show;
  if Assigned(frmDisplay_Kanan  )then frmDisplay_Kanan.Show;

  if Assigned(frmMIK_kiri)then frmMIK_Kiri.Show;
  if Assigned(frmDisplay_Kiri) then frmDisplay_Kiri.Show;

  if Assigned(frmASROC )then     // Asroc
  frmASROC.Show;

  if Assigned(frmBackGround )then frmBackGround.Show;



end;

procedure TTDC_NalaInterface.JedaSalvoTimer(Sender: TObject);
var Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
label fail;
begin

  Delaytime := Delaytime + 1;

//  if not IsusedRocket2 then begin
//   frmASROC.mmo1.Lines.Add('Rocket 1 is not Ready');
//   TimerJedaSalvo.Enabled := false;
//   Delaytime := 0;
//   Exit;
//  end;
  if Delaytime = 2 then begin
     with Rec3DSetAsrock do begin
       ShipID         := ShipIDSalvo2;
       OrderID        := ORD_ASROCK;
       mLauncherID    := 1;
       mMissileID     := 2;
       mWeaponID      := C_DBID_ASROC;
       mMissileNumber := 1;
       mMissile_Type  := TypeRoket;
       mTargetID      := TargetShipID;
       mTargetBearing := TargetBearingSalvo2;
       mTargetRange   := TargetRangeSalvo2;
       mTargetDepth   := TargetDepthSalvo2;
       mCorrRange     := 25 * C_Yard_To_Meter;
    end;
    netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
    TimerJedaSalvo.Enabled := false;
    Delaytime := 0;
  end;
end;


procedure TTDC_NalaInterface.RecvASRLSetting(aRec: TRecStatus_Console);
Var IsVal : Boolean;
    Ind   : Tindikator;
begin
  inherited;
 if aRec.OWN_SHIP_UID  = xSHIP.UniqueID  then begin

   if (aRec.ErrorID >= 206) and (aRec.ErrorID <= 211) then begin
     case aRec.ErrorID of
       __STAT_ASROCK_AVAILABLE_ERIKA : begin     // = 206;
         Erika.Available := aRec.ParamError;
       end;
       __STAT_ASROCK_SPEED_ERIKA : begin         // = 207;
         Erika.Speed  := aRec.ParamError;
       end;
       __STAT_ASROCK_FUZE_ERIKA : begin          // = 208;
         Erika.Fuze  := aRec.ParamError;
       end;
       __STAT_ASROCK_AVAILABLE_NELLY : begin     // = 209;
         Nelly.Available := aRec.ParamError;
       end;
       __STAT_ASROCK_SPEED_NELLY : begin         // = 210;
         Nelly.Speed := aRec.ParamError;
       end;
       __STAT_ASROCK_FUZE_NELLY : begin          // = 211;
         Nelly.Fuze := aRec.ParamError;
       end;
     end;
   end;


   if (aRec.ErrorID >= 201) and (aRec.ErrorID <= 205) then begin
      with frmASROC do begin
         case aRec.ErrorID of
           __STAT_ASROCK_HYDR : begin       // = 201;
             Ind :=  Hydr;
           end;
           __STAT_ASROCK_LAUNCHER : begin          // = 202;
             Ind := LncrRdy;
           end;
           __STAT_ASROCK_LAUNCHER_SYNC  : begin    //  = 203;
             Ind := LncrSync;
           end;
           __STAT_ASROCK_ROCKET2_READY  : begin    //  = 204;
             Ind := RKT2Rdy;
             IsusedRocket2 := (Rocket2_Set_on) and (aRec.ParamError = 1);
           end;
           __STAT_ASROCK_ROCKET1_READY  : begin    //  = 205;
             Ind := RKT1Rdy;
             IsusedRocket1 := (Rocket1_Set_on) and (aRec.ParamError = 1);
           end;
         end;

         if aRec.ParamError = 1 then
           IsVal := True
         else
           IsVal := False;

          Ind.Status := IsVal;

          with Ind do
            SetChangeImageIndikator(Imgobj, ImgON, imgOFF, IsVal);
      end;
   end;
 end;
end;

procedure TTDC_NalaInterface.SendEvenAsroc(EvenId: Word; const Prm1 :double = 0; Prm2 : double = 0; Prm3: double = 0);
begin
  SendLogEvenConsole(netSend, UniqueID_To_dbID(xSHIP.UniqueID), C_DBID_ASROC, EvenId, Prm1, Prm2, Prm3);  // Test send Log konsol
end;

procedure TTDC_NalaInterface.SetDefaultLayOut;
var path :string;
  idxTengah, alTengah, xTengah, yTengah,

  idxDisplayKiri, alDisplayKiri, xDisplayKiri, yDisplayKiri,
  idxAnduKiri, alAnduKiri, xAnduKiri, yAnduKiri,
  idxQEKKiri, alQEKKiri, xQEKKiri, yQEKKiri,

  idxDisplayKanan, alDisplayKanan, xDisplayKanan, yDisplayKanan,
  idxAnduKanan, alAnduKanan, xAnduKanan, yAnduKanan,
  idxQEKKanan, alQEKKanan, xQEKKanan, yQEKKanan,

  idxASRL, alASRL, xASRL, yASRL,
  idxBcg, alBcg, xBcg, yBcg       : Integer;

begin
//  inherited;
  path := ExtractFilePath(Application.ExeName) + 'SetFormToMonitor.ini';
  Getsettingform(path, 'TENGAH', idxTengah, alTengah, xTengah, yTengah);
  Getsettingform(path, 'KIRIATAS', idxDisplayKiri, alDisplayKiri, xDisplayKiri, yDisplayKiri);
  Getsettingform(path, 'KIRITENGAH', idxAnduKiri, alAnduKiri, xAnduKiri, yAnduKiri);
  Getsettingform(path, 'KIRIBAWAH', idxQEKKiri, alQEKKiri, xQEKKiri, yQEKKiri);
  Getsettingform(path, 'KANANATAS', idxDisplayKanan, alDisplayKanan, xDisplayKanan, yDisplayKanan);
  Getsettingform(path, 'KANANTENGAH', idxAnduKanan, alAnduKanan, xAnduKanan, yAnduKanan);
  Getsettingform(path, 'KANANBAWAH', idxQEKKanan, alQEKKanan, xQEKKanan, yQEKKanan);

  Getsettingform(path,'BACKGROUND', idxBcg, alBcg, xBcg, yBcg);
  Getsettingform(path, 'ASRL', idxASRL, alASRL, xASRL, yASRL);

  case Screen.MonitorCount of
    1,2 : begin
      AlignFormToMonitor(0, apLeftBottom   , 0 ,10, TForm(frmKiri));
      AlignFormToMonitor(0, apRightBottom  , 0 ,-20, TForm(frmKanan));
      AlignFormToMonitor(0, apLeftTop      , 0 , 0 , TForm(frmTengah ));

      AlignFormToMonitor(0, apLeftTop   , 10, 10, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(0, apLeftTop   , 10, frmDisplay_Kiri.Height +20, TForm(frmMIK_Kiri ));

      AlignFormToMonitor(0, apRightTop , -10 , 10, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor(0, apRightTop , -10 , frmDisplay_Kanan.Height +20 , TForm(frmMIK_Kanan ));

      frmKiri.BorderStyle           :=bsSingle;
      frmKanan.BorderStyle          :=bsSingle;
      frmDisplay_Kiri.BorderStyle   :=bsSingle;
      frmTengah.BorderStyle         :=bsSizeable;
      frmDisplay_Kanan.BorderStyle  :=bsSingle;
      frmASROC.BorderStyle          :=bsSingle;
      frmMIK_Kanan.BorderStyle      :=bsSingle;
      frmMIK_Kiri.BorderStyle       :=bsSingle;
      frmTengah.WindowState         :=wsMaximized;
    end;
    3 : begin
      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmTengah ));

      AlignFormToMonitor(0, apRightBottom  , 0, 0, TForm(frmKiri));
      AlignFormToMonitor(2, apLeftBottom  , 0 ,-20, TForm(frmKanan));

      AlignFormToMonitor(2, apLeftTop  , frmKanan.Width, 0, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor(2, apLeftTop  , frmKanan.Width, frmDisplay_Kiri.Height, TForm(frmMIK_Kanan ));

      AlignFormToMonitor(0, apRightTop  , -frmKiri.Width, 0, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(0, apRightTop  , -frmKiri.Width, frmDisplay_Kiri.Height, TForm(frmMIK_Kiri ));
     end;
    4 : begin

      AlignFormToMonitor(idxTengah,TAlignPos(alTengah), xTengah, yTengah, TForm(frmTengah));

      AlignFormToMonitor(idxDisplayKiri, TAlignPos(alDisplayKiri), xDisplayKiri, yDisplayKiri, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(idxAnduKiri, TAlignPos(alAnduKiri), xAnduKiri, yAnduKiri, TForm(frmMIK_Kiri ));
      AlignFormToMonitor(idxQEKKiri, TAlignPos(alQEKKiri), xQEKKiri, yQEKKiri, TForm(frmKiri));

      AlignFormToMonitor(idxDisplayKanan, TAlignPos(alDisplayKanan), xDisplayKanan, yDisplayKanan, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor( idxAnduKanan, TAlignPos(alAnduKanan), xAnduKanan, yAnduKanan , TForm(frmMIK_Kanan ));
      AlignFormToMonitor(idxQEKKanan, TAlignPos(alQEKKanan), xQEKKanan, yQEKKanan , TForm(frmKanan));

     end;
    5 : begin

      AlignFormToMonitor(idxTengah,TAlignPos(alTengah), xTengah, yTengah, TForm(frmTengah));

      AlignFormToMonitor(idxDisplayKiri, TAlignPos(alDisplayKiri), xDisplayKiri, yDisplayKiri, TForm(frmDisplay_Kiri ));
      AlignFormToMonitor(idxAnduKiri, TAlignPos(alAnduKiri), xAnduKiri, yAnduKiri, TForm(frmMIK_Kiri ));
      AlignFormToMonitor(idxQEKKiri, TAlignPos(alQEKKiri), xQEKKiri, yQEKKiri, TForm(frmKiri));

      AlignFormToMonitor(idxDisplayKanan, TAlignPos(alDisplayKanan), xDisplayKanan, yDisplayKanan, TForm(frmDisplay_Kanan ));
      AlignFormToMonitor(idxAnduKanan, TAlignPos(alAnduKanan), xAnduKanan, yAnduKanan , TForm(frmMIK_Kanan ));
      AlignFormToMonitor(idxQEKKanan, TAlignPos(alQEKKanan), xQEKKanan, yQEKKanan , TForm(frmKanan));

      AlignFormToMonitor(idxASRL, TAlignPos(alASRL), xASRL, yASRL, TForm(frmASROC));
      AlignFormToMonitor(idxBcg , TAlignPos(alBcg), xBcg, yBcg, TForm(frmBackGround));

//     frmTengah.FormStyle := fsStayOnTop;
      frmKiri.FormStyle           := fsStayOnTop;
      frmKanan.FormStyle          := fsStayOnTop;
      frmMIK_Kiri.FormStyle       := fsStayOnTop;
      frmMIK_Kanan.FormStyle      := fsStayOnTop;
      frmDisplay_Kanan.FormStyle  := fsStayOnTop;
      frmDisplay_Kiri.FormStyle   := fsStayOnTop;
      frmASROC.FormStyle          := fsStayOnTop;
      frmBackGround.BorderStyle   := bsNone;
      frmBackGround.Height:=  1024;
      frmBackGround.Width :=  1280;
    end;
  end;
end;

procedure TTDC_NalaInterface.CommonDataRequest(obm: tTdc_Symbol; display: TfrmANDUDisplay);
var s: string;
    findObj: boolean;
    mTrack : tManualTrack;
begin
  findObj := FindTrack_by_ScreenPos(obm.Center.X, obm.Center.Y, cTrack);
  if findObj  then begin

    s := '';
    if cTrack is TManualTrack then begin
      mTrack := cTrack as TManualTrack;
      s := formatSCR_track_AS(mTrack);
      case  mTrack.Domain of
        tdAtasAir,
        tdUdara   : begin
          s := formatSCR_track_AS(mTrack);
        end;
        tdBawahAir : begin
          s := formatSCR_track_U(mTrack);
        end;
      end;
    end
    else if cTrack is TDatumTrack then begin
       dtTrack := cTrack as TDatumTrack;
       s := formatSCR_datum(dtTrack, tdcData.LocalTime);
    end
    else if cTrack is TESMFixTrack then begin
       s := formatSCR_ESMFix(cTrack, tdcData.LocalTime);
    end
    else if cTrack is TESMBearingTrack then begin
       s := formatSCR_ESMBear(cTrack, tdcData.LocalTime);
    end
    else if cTrack is TRefPosTrack then begin
       s := formatSCR_RP(cTrack);
    end;

    display.SetDRLText(s);
  end
  else begin
    display.SetDRLText('');
  end;

end;

procedure TTDC_NalaInterface.DataRequest_left(const b: byte);
begin
  if b = 0 then begin
    CommonDataRequest(OBMLeft, frmDisplay_Kiri);
  end
  else begin
       frmDisplay_Kiri.SetDRLText('');
  end;
end;

procedure TTDC_NalaInterface.DataRequest_Right(const b: byte);
begin
  if b = 0 then begin
    CommonDataRequest(OBMRight, frmDisplay_Kanan);
  end
  else begin
       frmDisplay_Kanan.SetDRLText('');
  end;
end;

procedure TTDC_NalaInterface.Walk;
begin
  inherited;
  if (CPA_list[0].Target <> nil) and (CPA_list[0].Display <> nil) then
     Calc_n_Show_CPA(0);

  if (CPA_list[1].Target <> nil) and (CPA_list[1].Display <> nil) then
     Calc_n_Show_CPA(1);

  if Assigned(frmMIK_Kanan)then frmMIK_Kanan.UpdateDisplayData;
  if Assigned(frmMIK_kiri )then frmMIK_Kiri.UpdateDisplayData;
end;


procedure TTDC_NalaInterface.CPA_show(const ix: byte;
  displ: TfrmANDUDisplay; const lin: byte);
begin
  if ix  <= C_maxPosID then  begin
    CPA_list[ix].Display := displ;
    CPA_list[ix].LineNum := lin;
  end;
end;

procedure TTDC_NalaInterface.CPA_start(const ix: byte; cTGT: TManualTrack);
begin
  if ix  <= C_maxPosID then begin
    CPA_list[ix].Target := cTGT;
  end;
end;

procedure TTDC_NalaInterface.Calc_n_Show_CPA(const ix: byte);
var tRange, tBearing : double;
    cRange, cBearing, cTime  : double;
    dRange : double;

    s1, s2: string;
    pt1a, pt1b, pt2a, pt2b: t2DPoint;
begin
  tRange := CalcRange( xSHIP.PositionX, xSHIP.PositionY,
                       CPA_list[ix].Target.PositionX,  CPA_list[ix].Target.PositionY);
  tBearing := CalcBearing( xSHIP.PositionX, xSHIP.PositionY,
                       CPA_list[ix].Target.PositionX,  CPA_list[ix].Target.PositionY);

   if Calc_CPA( xSHIP.Speed,  xSHIP.Heading,
     CPA_list[ix].Target.Speed, CPA_list[ix].Target.Course,
     tRange, tBearing, cRange, cTime) then begin
     s1 := formatParC1(tBearing, tRange);

     pt1a.X := xSHIP.PositionX;
     pt1a.Y := xSHIP.PositionY;

     dRange := xShip.Speed * cTime / 60;

     pt1b := CalcPositionAhead(pt1a, dRange, ConvCompass_To_Cartesian(xSHIP.Heading));

     pt2a.X  :=  CPA_list[ix].Target.PositionX;
     pt2a.Y  :=  CPA_list[ix].Target.PositionY;

     dRange := CPA_list[ix].Target.Speed * cTime / 60;
     pt2b := CalcPositionAhead(pt2a, dRange, ConvCompass_To_Cartesian(CPA_list[ix].Target.Course));

     cBearing := CalcBearing(pt1b.X, pt1b.Y, pt2b.X, pt2b.Y);

     s2 := formatParC2(cpa_list[ix].Target.StringTrackNumber, cRange, cBearing, cTime);
     CPA_list[ix].Display.SetTextPar(CPA_list[ix].LineNum, s1, s2);
   end;
end;

procedure TTDC_NalaInterface.GetCurrentDataTrackASRL(var getHeading :Single; var getRange : double; var getBearing : double);
begin
  if IsASRLAssigned and (FC5.TrackedTarget <> nil) then begin

    getRange   := C_NauticalMiles_TO_Meter * calcrange(xSHIP.PositionX, xSHIP.PositionY, FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY);
    getBearing := CalcBearing(xSHIP.PositionX, xSHIP.PositionY, FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY);                 // nautical miles
  end
  else begin
    getRange   := 0;
    getBearing := 0;
  end;
  getHeading := xShip.Heading;
  Exit;
end;

//procedure TTDC_NalaInterface.setAssignASRL(aRec: TRecTrackOrder; Msltype : Word; const send: boolean= TRUE);
//var findObj   : boolean;
//    detObj    : TDetectedObject;
//    pnt       : TPoint;
//    r,b,d     : double;
//    Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
//    i : Integer;
//begin
//  inherited;
//  pnt := ConvertToScreen(aRec.x, aRec.Y);
//  findObj := FindTrack_by_ScreenPos(pnt.X, pnt.Y, cTrack);
//  if findObj and (cTrack is TManualTrack) then begin
//    mTrack := (cTrack as TManualTrack);
//    mTrack.setAssignASRL(True);
//    FMap.MapUnit := miUnitNauticalMile;
//
//   r := FMap.Distance(xSHIP.PositionX, xSHIP.PositionY,    // nautical miles
//        mTrack.PositionX, mTrack.PositionY);
//
//   b := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
//       mTrack.PositionX , mTrack.PositionY) - xSHIP.Heading;
//
//   d := Abs(mTrack.PositionZ); //mTrack.Height;
//
//   with Rec3DSetAsrock do begin
//     ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
//     OrderID        := ORD_ASROCK_ASSIGNED;
//     mWeaponID      := C_DBID_ASROC;
//     if mTrack.UniqueID <> '' then
//        mTargetID      := UniqueID_To_dbID(mTrack.UniqueID)
//     else
//        mTargetID      := mTrack.ShipTrackId;
//     frmASROC.mmo1.Lines.Add(IntToStr(mTargetID));
//     mMissileNumber := 1;
//     mLauncherID    := 1;
//     mMissile_Type  := Msltype;  // default 0;
//     mTargetBearing := b;
//     mTargetRange   := r * C_NauticalMiles_TO_Meter;
//     mTargetDepth   := d;
//     mCorrRange     := 0.0;
//
//     frmASROC.mmo1.Lines.Add(IntToStr(ShipID));
//     frmASROC.mmo1.Lines.Add('Assign');
//     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetBearing));
//     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetRange) + ' Nm');
//     frmASROC.mmo1.Lines.Add(FloatToStr(xShip.Heading));
//
////     frmASROC.mmo1.Lines.Add(FC5.TargetUID);
//
//     netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
//     IsASRLAssigned := True;
//     // mTrack.setAssignASRL(true);
//     frmASROC.SetRestRangeMtr;
//   end;
//  end;
//end;

procedure TTDC_NalaInterface.ReAssignASRL(Msltype: Word);
var Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
    RangeSalvo1,RangeSalvo2 : double;
    jeda : integer;
    RocketRdy, findObj : Boolean;
    pnt       : TPoint;
    brg, rng, dpth : Double;
    label fail;
begin
  if Assigned(FC5.TrackedTarget) and (mTrack = FC5.TrackedTarget) then begin

   with Rec3DSetAsrock do begin
     ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
     OrderID        := ORD_ASROCK_ASSIGNED;
     mWeaponID      := C_DBID_ASROC;

     if FC5.TrackedTarget.UniqueID <> '' then
        mTargetID      := UniqueID_To_dbID(FC5.TrackedTarget.UniqueID)
     else
        mTargetID      := 0; //FC5.TrackedTarget.ShipTrackId;

     mMissileNumber := 1;
     mLauncherID    := 1;
     mMissileID     := mLauncherID;
     mMissile_Type  := Msltype;  // default 0;
     mTargetBearing := 0;
     mTargetRange   := 0;
     mTargetDepth   := 0;
     mCorrRange     := 0.0;

     frmASROC.mmo1.Lines.Add(IntToStr(ShipID));
     frmASROC.mmo1.Lines.Add('Assign');
     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetBearing));
     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetRange) + ' Nm');
     frmASROC.mmo1.Lines.Add(FloatToStr(xShip.Heading));

     // Assignment
     netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
     IsASRLAssigned := True;
     FC5.TrackedTarget.SetAssignASRL(True);
     frmASROC.SetRestRangeMtr;

   end;
  end;
end;


procedure TTDC_NalaInterface.setAssignASRL(aRec: TRecTrackOrder; Msltype : Word; const send: boolean= TRUE);
var Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
    RangeSalvo1,RangeSalvo2 : double;
    jeda : integer;
    RocketRdy, findObj : Boolean;
    pnt       : TPoint;
    brg, rng, dpth : Double;
    label fail;
begin
  inherited;
  pnt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pnt.X, pnt.Y, cTrack);
  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

  if Assigned(FC5.TrackedTarget) and (mTrack = FC5.TrackedTarget) then begin

   with Rec3DSetAsrock do begin
     ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
     OrderID        := ORD_ASROCK_ASSIGNED;
     mWeaponID      := C_DBID_ASROC;

     if FC5.TrackedTarget.UniqueID <> '' then
        mTargetID      := UniqueID_To_dbID(FC5.TrackedTarget.UniqueID)
     else
        mTargetID      := 0; //FC5.TrackedTarget.ShipTrackId;

     mMissileNumber := 1;
     mLauncherID    := 1;
     mMissileID     := mLauncherID;
     mMissile_Type  := Msltype;  // default 0;
     mTargetBearing := 0;
     mTargetRange   := 0;
     mTargetDepth   := 0;
     mCorrRange     := 0.0;

     frmASROC.mmo1.Lines.Add(IntToStr(ShipID));
     frmASROC.mmo1.Lines.Add('Assign');
     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetBearing));
     frmASROC.mmo1.Lines.Add(FloatToStr(mTargetRange) + ' Nm');
     frmASROC.mmo1.Lines.Add(FloatToStr(xShip.Heading));

     // Assignment
     netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
     IsASRLAssigned := True;
     FC5.TrackedTarget.SetAssignASRL(True);
     frmASROC.SetRestRangeMtr;

     // Log
     brg := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
            FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY);
     rng := Calcrange(xSHIP.PositionX, xSHIP.PositionY,
            FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY);
     dpth:= Abs(FC5.TrackedTarget.PositionZ);

     SendEvenAsroc(1, brg, rng, dpth); // Test send Log konsol
   end;
  end;
end;
end;

procedure TTDC_NalaInterface.setDeAssignASRL(aRec: TRecTrackOrder;
const send: boolean);
var Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
findObj : Boolean;
pnt       : TPoint;
begin
  inherited;
  if not IsASRLAssigned then Exit;

  pnt := ConvertToScreen(aRec.x, aRec.Y);
  findObj := FindTrack_by_ScreenPos(pnt.X, pnt.Y, cTrack);
  if findObj and (cTrack is TManualTrack) then begin
    mTrack := (cTrack as TManualTrack);

  if Assigned(FC5.TrackedTarget) and (mTrack = FC5.TrackedTarget) then begin
       mTrack.setAssignASRL(false);
       with Rec3DSetAsrock do begin
         ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
         OrderID        := ORD_ASROCK_DEASSIGNED;
         mWeaponID      := C_DBID_ASROC;

         if FC5.TargetUID <> '' then
           mTargetID      := UniqueID_To_dbID(FC5.TrackedTarget.UniqueID)
         else
            mTargetID      := 0;

         mMissileNumber := 1;
         mLauncherID    := 1;
         mMissileID     := mLauncherID;
         mMissile_Type  := 1;  // default 0;
         mTargetBearing := 0;
         mTargetRange   := 0;
         mTargetDepth   := 0;
         mCorrRange     := 0.0;

         netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
         IsASRLAssigned := False;
         frmASROC.SetRestRangeMtr;

         SendEvenAsroc(2);

       end;
    end;

  end;
end;

procedure TTDC_NalaInterface.SetFireAsroc
(aRec: TRecTrackOrder; IDLauncher :integer; mMissileID : word; RocketType : Byte;  IsSalvo : boolean; const send:boolean= TRUE);  // Added by Bagus   8-11
var findObj   : boolean;
    detObj    : TDetectedObject;
    pnt       : TPoint;
    r, b, d   : double;

    Rec3DSetAsrock  : TRec3DSetAsrock;  // tambahan buat dikirim ke 3D
    RangeSalvo1,RangeSalvo2 : double;
    jeda : integer;
    RocketRdy : Boolean;
    label fail;
begin
   inherited;
   pnt := ConvertToScreen(aRec.x, aRec.Y);
   findObj := FindTrack_by_ScreenPos(pnt.X, pnt.Y, cTrack);
//   if findObj and (cTrack is TManualTrack) then begin
//   mTrack := (cTrack as TManualTrack);

 if FC5.TrackedTarget <> nil then begin
   r  := CalcRange(xSHIP.PositionX, xSHIP.PositionY,
       FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY) * C_NauticalMiles_TO_Meter ;

   b  := CalcBearing(xSHIP.PositionX, xSHIP.PositionY,
       FC5.TrackedTarget.PositionX , FC5.TrackedTarget.PositionY) - xSHIP.Heading;
   d  := Abs(FC5.TrackedTarget.PositionZ);

    with Rec3DSetAsrock do begin
       ShipID         := UniqueID_To_dbID(xSHIP.UniqueID);
       OrderID        := ORD_ASROCK;
       mWeaponID      := C_DBID_ASROC;
       mLauncherID    := 1;
       mMissileID     := mLauncherID;
       mMissileNumber := 1;
       mMissile_Type  := RocketType;
       if FC5.TargetUID <> '' then
          mTargetID      := UniqueID_To_dbID(FC5.TrackedTarget.UniqueID)
       else
          mTargetID      := 0;
       mTargetBearing := b;
       mTargetDepth   := d;
       mFuzeType      := 0;
    end;

   if IsSalvo then begin
     TypeRoket := RocketType;
      ShipIDSalvo2 := Rec3DSetAsrock.ShipID;
      TargetShipID := Rec3DSetAsrock.mTargetID;
      TargetBearingSalvo2 := b;
      TargetRangeSalvo2   := r + (25 * C_Yard_To_Meter);
      TargetDepthSalvo2   := d;
      TimerJedaSalvo.Enabled :=true;

//     if not IsusedRocket1 then begin
//       frmASROC.mmo1.Lines.Add('Rocket 1 is not Ready');
//       Exit;
//     end;

     with Rec3DSetAsrock do begin
       mMissileID     := 1;
       mTargetRange   := r - (25 * C_Yard_To_Meter);
       mCorrRange     := - (25 * C_Yard_To_Meter);

       frmASROC.mmo1.Lines.Add(IntToStr(ShipID));
       frmASROC.mmo1.Lines.Add('Fire');
       frmASROC.mmo1.Lines.Add('Range  :' + FloatToStr(mTargetRange) + ' M');
       frmASROC.mmo1.Lines.Add('Range  :' + FloatToStr(mTargetRange * C_Meter_To_NauticalMiles) + ' Nm');
       frmASROC.mmo1.Lines.Add('target own ship Heading :' + FloatToStr(xShip.Heading));
       frmASROC.mmo1.Lines.Add('target bearing relative:' + FloatToStr(mTargetBearing));
     end;
      netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);
   end
   else begin
     case IDLauncher of
       1: RocketRdy := IsusedRocket1;
       2: RocketRdy := IsusedRocket2;
     end;
//     if not RocketRdy then begin
//       frmASROC.mmo1.Lines.Add('Rocket ' + IntToStr(IDLauncher) + ' is not Ready');
//       Exit;
//     end;

     with Rec3DSetAsrock do begin
       mMissileID     := IDLauncher;
       mTargetRange   := r;
       mCorrRange     := 0.0;
       netSend.sendDataEx(REC_SET_ASROCK, @Rec3DSetAsrock);

       frmASROC.mmo1.Lines.Add('Fire');
       frmASROC.mmo1.Lines.Add('Order ID : ' +IntToStr(OrderID ) );
       frmASROC.mmo1.Lines.Add('Launcher ID : ' + IntToStr(mLauncherID ));
       frmASROC.mmo1.Lines.Add('Missile ID : ' + IntToStr(mMissileID));
       frmASROC.mmo1.Lines.Add('Missile Type  :' + FloatToStr(mMissile_Type));
       frmASROC.mmo1.Lines.Add('mTargetBearing :' + FloatToStr(mTargetBearing));
       frmASROC.mmo1.Lines.Add('mTargetRange  :' + FloatToStr(mTargetRange));
       frmASROC.mmo1.Lines.Add('mTargetDepth :' + FloatToStr(mTargetDepth));
     end;
   end;
  end;
end;

procedure TTDC_NalaInterface.DeleteFC5;
begin
  if FC5.TrackedTarget <> nil then
    DeleteMTrack(FC5.TrackedTarget);
end;

{ TRoketType }

constructor TRoketType.Create;
begin
    Available := 1;
    Speed     := 1;
    Fuze      := 1;
end;

destructor TRoketType.Destroy;
begin

  inherited;
end;

end.
