unit u108;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  VrControls,
  VrMeter,
  VrDesign,
  RzBmpBtn,
  Buttons,
  SpeedButtonImage,

  uLibRBU, VrRotarySwitch, RzBHints;

type
  Tfrm108 = class(TForm)
    imgInd_UNFR2: TImage;
    imgInd_BreakUNFR2: TImage;
    imgAliranBurja: TImage;
    imgPower: TImage;
    img_Aliran_Kapal: TImage;
    imgInd_UNFR1: TImage;
    pnl13: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl11: TPanel;
    pnl6: TPanel;
    img12: TImage;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl12: TPanel;
    img19: TImage;
    btnPOWER: TRzBmpButton;
    vrmtrUnf1A: TVrMeter;
    img3: TImage;
    img20: TImage;
    imgMode: TImage;
    imgLauncNumb: TImage;
    img13: TImage;
    img25: TImage;
    btnUNFORMER2_Off: TVrBitmapButton;
    btnBreakUNFR2: TRzBmpButton;
    img14: TImage;
    img15: TImage;
    btnUNFORMER2_On: TVrBitmapButton;
    btnUNFORMER1_On: TVrBitmapButton;
    btnUNFORMER1_Off: TVrBitmapButton;
    img10: TImage;
    btnBreakUNFR1: TRzBmpButton;
    pnl5: TPanel;
    pnl7: TPanel;
    img16: TImage;
    img17: TImage;
    img18: TImage;
    imgSelMode: TImage;
    imgSelLauncher: TImage;
    img22: TImage;
    img27: TImage;
    pnl8: TPanel;
    btn1: TVrBitmapButton;
    btnMode: TVrBitmapButton;
    imgNumbLauncher: TImage;
    btn108R: TVrBitmapButton;
    lbl1: TLabel;
    btn2: TVrBitmapButton;
    lbl2: TLabel;
    img4: TImage;
    imgInd_BreakUNFR1: TImage;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    tmrLoadMissile: TTimer;
    img5: TImage;
    vrmtrUnf2A: TVrMeter;
    img6: TImage;
    tmr2: TTimer;
    vrmtrUnf2B: TVrMeter;
    vrmtrUnf1B: TVrMeter;
    tmr3: TTimer;
    RTLauncherLoadingSelector: TVrRotarySwitch;
    RTModeSelector: TVrRotarySwitch;
    img_L1: TImage;
    img_L2: TImage;
    img_L3: TImage;
    img_L4: TImage;
    img_L5: TImage;
    img_L6: TImage;
    img_L12: TImage;
    img_L11: TImage;
    img_L10: TImage;
    img_L9: TImage;
    img_L8: TImage;
    img_L7: TImage;
    img1: TImage;
    m1: TPanel;
    tmrLoadMissileR: TTimer;
    m2: TPanel;
    procedure btnUNFORMER1_OffClick(Sender: TObject);
    procedure btnBreakUNFR2Click(Sender: TObject);
    procedure btnUNFORMER2_OnClick(Sender: TObject);
    procedure btnUNFORMER2_OffClick(Sender: TObject);
    procedure btnPOWERClick(Sender: TObject);
    procedure btnUNFORMER1_OnClick(Sender: TObject);
    procedure btnBreakUNFR1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure btn108RClick(Sender: TObject);
    procedure imgLauncNumbClick(Sender: TObject);
    procedure imgModeClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure RTModeSelectorChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrLoadMissileTimer(Sender: TObject);
    procedure RTLauncherLoadingSelectorChange(Sender: TObject);
    procedure img1Click(Sender: TObject);
    procedure RTModeSelectorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tmrLoadMissileRTimer(Sender: TObject);
//    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }

    stepNeedle  : Integer;
    procedure ManuallyLoadMissile;
    procedure SetKondisiOff;
    procedure SetLauncherReady(switch : boolean);

  public
    // variabel untuk mengatur urutan prosedur pengoperasian
    unitform    : string;
    Power_On,
    BurjaSignal_is_On,
    ShipLink_is_On,
    UnformerI_is_On,
    Switch_Break_UFI_is_On,
    UnformerII_is_On,
    Switch_Break_UFII_is_On,

    RealProcedure,
    EngineReady         : Boolean;
    WarmUpcounter       : Integer;

    btlonch, btmode     : Boolean;
    launcNumb, ModeNumb : Integer;
    RightFireMode       : TfireMode;
    CountToLoadMisile,
    CountToLoadMisileR  : Integer;
    CountAutoLoadMissile,
    CountAutoLoadMissileR : Integer;
    IsReadyToManualLoad,
    IsReadyToManualLoadR : Boolean;
    IsReadyToOperate108 : array [1..7] of Boolean;
    procedure RunNeedle(Mtr:TvrMeter; Step : integer);

    Procedure LoadingMissile(var Msl: TRecMissile; reload : boolean);
    procedure RefreshMissileIndikator(idx : Integer);
    function Isrunning : boolean;
    procedure setIndikatorLoadAndDirection(Loading : Boolean);
    procedure RunLauncherRBU(Launcher: TLoncher; Mode : word);

    { Public declarations }
  end;

//var
//  frm108: Tfrm108;

implementation
uses
    uRBU_Manager, uTCPDatatype, uBaseFunction, uBaseConstan, uBurjaAtas;
{$R *.dfm}


procedure Tfrm108.FormCreate(Sender: TObject);
begin

   ShipLink_is_On := True;

   CountToLoadMisile    := 0;
   CountAutoLoadMissile := 0;
   IsReadyToManualLoad  := true;

   RealProcedure := true;
   EngineReady   := false;
   WarmUpcounter := 0;

   btlonch   := False;
   btmode    := False;

   launcNumb := 1;
   ModeNumb  := 1;

   ModeLonchR := mlAuto;
   ModeLonchL := mlAuto;
   stepNeedle:= 1;
end;

procedure Tfrm108.FormDestroy(Sender: TObject);
Var i : Integer;
begin
 for i := 1 to  12 do begin
    FreeAndNil(ListMissileR[i]);
    FreeAndNil(ListMissileL[i]);
 end;
end;

procedure Tfrm108.SetKondisiOff;
var
lRec    : TRec3DSetRBU;
begin
    Power_On                := false;
    UnformerI_is_On         := false;
    //Switch_Break_UFI_is_On  := false;
    UnformerII_is_On        := false;
    //Switch_Break_UFII_is_On := false;

    imgInd_UNFR1.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
    imgInd_BreakUNFR1.Picture.LoadFromFile(path_image_108 + 'OffInd.bmp');
    imgInd_UNFR2.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
    imgInd_BreakUNFR2.Picture.LoadFromFile(path_image_108 + 'OffInd.bmp');


  if (Caption = 'Kanan') and (Power_On = False) then
  begin
    lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 1;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end
  else if  (Caption = 'Kiri') and (Power_On = False) then
  begin
      lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 2;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end;



end;

function Tfrm108.Isrunning : boolean;
var
  i: Integer;
begin
  Result := ShipLink_is_On and Power_On and BurjaSignal_is_On  and UnformerI_is_On and UnformerII_is_On and
            Switch_Break_UFII_is_On and Switch_Break_UFI_is_On;
end;

procedure Tfrm108.setIndikatorLoadAndDirection(Loading : Boolean);
begin
  SetChangeImageIndikator(imgSelMode ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', not Loading);
  SetChangeImageIndikator(imgSelLauncher ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp',  Loading);
end;

procedure Tfrm108.btn108RClick(Sender: TObject);
begin
  Hide;
end;

procedure Tfrm108.btn1Click(Sender: TObject);
var Lncr : TLoncher;
tmrLoad : TTimer;
begin
   btlonch := not btlonch;
   //SetChangeImageIndikator(imgSelLauncher,path_image_108 +'RedInd.bmp', path_image_108 +'OffInd.bmp', btlonch);
   if Isrunning and (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto ) then
   begin

      if Caption = 'Kanan' then
      begin
        Lncr := Lonch1;
        tmrLoad := tmrLoadMissileR;
      end
      else
      begin
        Lncr := Lonch2;
        tmrLoad := tmrLoadMissile;
      end;
      RunLauncherRBU(Lncr , __ORD_RBU_LOADING);

      setIndikatorLoadAndDirection(True);
      tmrLoad.Enabled:= True;
      IsReadyToManualLoad := false;
   end;
end;

procedure Tfrm108.btn2Click(Sender: TObject);
begin
//  if Caption = '108 Kanan' then
//      uRBU_Manager.RBU_MAnager.frmPanelFireR.Show
//  else
    uRBU_Manager.RBU_MAnager.frmPanelFire.Show;
end;

procedure Tfrm108.btnBreakUNFR1Click(Sender: TObject);
var s : string;
lRec    : TRec3DSetRBU;
begin

  Switch_Break_UFI_is_On := btnBreakUNFR1.Down;
  if Power_On  then
  begin
    SetChangeImageIndikator(imgInd_BreakUNFR1 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR1.Down);
    if BurjaSignal_is_On and ShipLink_is_On then
    begin
      if Caption = 'Kanan' then
        Lonch1.ElevOn  := btnBreakUNFR1.Down
      else
        Lonch2.ElevOn := btnBreakUNFR1.Down;
    end;

    if Switch_Break_UFI_is_On then
      s := unitform + 'switch break Unformer I switch on'
    else
      s := unitform + 'switch break Unformer I switch off';

  end;
  SetLauncherReady(btnBreakUNFR2.Down and btnBreakUNFR1.Down);


  if (Caption = 'Kanan') and (btnBreakUNFR1.Down = False) then
  begin
    lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 1;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end
  else if  (Caption = 'Kiri') and (btnBreakUNFR1.Down = False) then
  begin
      lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 2;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end;



end;

procedure Tfrm108.SetLauncherReady(switch : boolean);
begin
   if Caption = 'Kanan' then
      Lonch1.Ready  := Isrunning and switch
   else
      Lonch2.Ready  := Isrunning and switch;
end;

procedure Tfrm108.btnBreakUNFR2Click(Sender: TObject);
var s : string;
lRec   : TRec3DSetRBU;
begin
    Switch_Break_UFII_is_On := btnBreakUNFR2.Down;
  if Power_On  then
  begin
    SetChangeImageIndikator(imgInd_BreakUNFR2 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR2.Down);

    if BurjaSignal_is_On and ShipLink_is_On then
    begin
      if Caption = 'Kanan' then
        Lonch1.TrainingOn := btnBreakUNFR2.Down
      else
        Lonch2.TrainingOn := btnBreakUNFR2.Down ;
    end;

    if Switch_Break_UFII_is_On then
      s := unitform + 'switch break Unformer I switch on'
    else
      s := unitform + 'switch break Unformer I switch off';

  end;

  if (Caption = 'Kanan') and (btnBreakUNFR2.Down = False) then
  begin
    lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 1;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end
  else if  (Caption = 'Kiri') and (btnBreakUNFR2.Down = False) then
  begin
      lRec.ShipID          := RBU_MAnager.pShipID;
    lRec.mWeaponID       := C_DBID_RBU6000;
    lRec.mLauncherID     := 2;
    lRec.mMissileID      := 0;
    lRec.mMissileNumber  := 0;
    lRec.mCount          := 0;
    lRec.mMissileType    := 0;
    lRec.mTargetID       := 0;
    lRec.mLncrBearing    := 0;
    lRec.mLncRange       := 0;
    lRec.mTargetDepth    := 0;
    lRec.mCorrBearing    := 0;
    lRec.mCorrElev       := 0;
    lRec.OrderID         := __ORD_RBU_DEASSIGNED;

    if RBU_MAnager.Datcom <> nil then
    begin
      RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
    end;
  end;

  SetLauncherReady(btnBreakUNFR2.Down and btnBreakUNFR1.Down);
end;

procedure Tfrm108.btnModeClick(Sender: TObject);
var Lncr : TLoncher;
tmrLoad : TTimer;
begin
   if Isrunning and (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto) then
   begin
//     tmrLoadMissile.Enabled:= True;
//     IsReadyToManualLoad := false;


      if (Caption = 'Kanan') and (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto) then begin
        Lncr := Lonch1;
        tmrLoad := tmrLoadMissileR;
      end
      else
      if (Caption = 'Kiri') and (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto) then begin
        Lncr := Lonch2;
          tmrLoad := tmrLoadMissile;
      end;

      if Power_On and UnformerII_is_On and Switch_Break_UFII_is_On then begin
        Lncr.TrainingOn    := Switch_Break_UFII_is_On and (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto);
      end;

      if RBU_MAnager.IsSonarTracked then
        RunLauncherRBU(Lncr , __ORD_RBU_AUTO)
      else
        RunLauncherRBU(Lncr , __ORD_RBU_ASSIGNED);

      setIndikatorLoadAndDirection(false);
      tmrLoad.Enabled:= false;

   end;
end;

procedure Tfrm108.btnPOWERClick(Sender: TObject);
var s : string;
begin
  SetChangeImageIndikator(imgPower,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', btnPOWER.Down);
  Power_On        := btnPOWER.Down;
  if not Power_On then
  begin
    SetKondisiOff;
    s := 'saklar utama switch off';
  end
  else
  begin
    s := 'saklar utama switch on';

    if Switch_Break_UFII_is_On = True then
    begin
      SetChangeImageIndikator(imgInd_BreakUNFR2 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR2.Down);
      Switch_Break_UFII_is_On := btnBreakUNFR2.Down;
      if BurjaSignal_is_On and ShipLink_is_On then
      begin
        if Caption = 'Kanan' then
          Lonch1.TrainingOn := btnBreakUNFR2.Down
        else
          Lonch2.TrainingOn := btnBreakUNFR2.Down ;
      end;

      if Switch_Break_UFII_is_On then
        s := unitform + 'switch break Unformer I switch on'
      else
        s := unitform + 'switch break Unformer I switch off'

    end;

    if Switch_Break_UFI_is_On = True then
    begin
      SetChangeImageIndikator(imgInd_BreakUNFR1 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR1.Down);
      Switch_Break_UFI_is_On := btnBreakUNFR1.Down;
      if BurjaSignal_is_On and ShipLink_is_On then
      begin
        if Caption = 'Kanan' then
          Lonch1.ElevOn  := btnBreakUNFR1.Down
        else
          Lonch2.ElevOn := btnBreakUNFR1.Down;
      end;

      if Switch_Break_UFI_is_On then
        s := unitform + 'switch break Unformer I switch on'
      else
        s := unitform + 'switch break Unformer I switch off'

    end;
  end;


  s := unitform + s;
end;

procedure Tfrm108.btnUNFORMER1_OffClick(Sender: TObject);
var s : string;
begin
   imgInd_UNFR1.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
//   imgInd_BreakUNFR1.Picture.LoadFromFile(path_image_108 + 'OffInd.bmp');
   s := 'Unformer 1 switch off';
   UnformerI_is_On := false;
   s := unitform + s;
end;

procedure Tfrm108.btnUNFORMER1_OnClick(Sender: TObject);
var isRight, isLeft : Boolean;
s : string;
begin
   if not Power_On then Exit;
   isRight := self.Caption = 'Kanan';
   isLeft  := self.Caption = 'Kiri';

   if (isRight and stRIGHT_UNFORMER1) or (isLeft and stLEFT_UNFORMER1) then begin
     imgInd_UNFR1.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');
     s := 'Unformer 1 switch on';
     if btnBreakUNFR1.Down then
       imgInd_BreakUNFR1.Picture.LoadFromFile(path_image_108 + 'YellowInd.bmp');

     tmr3.Enabled:= True;
     UnformerI_is_On := True;
   end;
   s := unitform + s;
end;

procedure Tfrm108.btnUNFORMER2_OffClick(Sender: TObject);
var s : string;
begin
   imgInd_UNFR2.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
//   imgInd_BreakUNFR2.Picture.LoadFromFile(path_image_108 + 'OffInd.bmp');
   s := 'Unformer 1 switch off';
   UnformerII_is_On := false;
end;

procedure Tfrm108.btnUNFORMER2_OnClick(Sender: TObject);
var isRight, isLeft : Boolean;
s : string;
begin
   if not Power_On then Exit;
   isRight := self.Caption = 'Kanan';
   isLeft  := self.Caption = 'Kiri';

   if (isRight and stRIGHT_UNFORMER2) or (isLeft and stLEFT_UNFORMER2) then begin
     imgInd_UNFR2.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');
      s := 'Unformer 2 switch on';
     if btnBreakUNFR2.Down then
       imgInd_BreakUNFR2.Picture.LoadFromFile(path_image_108 + 'YellowInd.bmp');

     tmr2.Enabled := True;
     UnformerII_is_On := True;
   end;
    s := unitform + s;
end;

procedure Tfrm108.FormShow(Sender: TObject);
var
  I: Integer;
begin
 SetChangeImageIndikator(imgAliranBurja,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', StatusAliranBurja);
 BurjaSignal_is_On := StatusAliranBurja;

 for I := 1 to 12 do
  RefreshMissileIndikator(I);
 if Self.Caption = 'Kanan' then
  m2.Caption := '108 Kanan'
 else
  m2.Caption := '108 Kiri';

end;

procedure Tfrm108.imgModeClick(Sender: TObject);
begin
//   ModeNumb := ModeNumb + 1;
//
//  if ModeNumb = 4 then
//    ModeNumb := 1;
//
//  case ModeNumb of
//    1  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Pengisian.bmp');
//    2  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Pengarahan.bmp');
//    3  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Penembakan.bmp');
//  end;
end;

procedure Tfrm108.LoadingMissile(var Msl: TRecMissile; reload: boolean);
begin
  Msl.Available := reload;
end;

procedure Tfrm108.RefreshMissileIndikator(idx : Integer);
begin
   if Caption = 'Kanan' then begin
       case idx of
       1 :  SetChangeImageIndikator(img_L1, path_image_108 + 'lampu01 _on.bmp' ,path_image_108 + 'lampu01 _off.bmp', ListMissileR[1].Available);
       2 :  SetChangeImageIndikator(img_L2, path_image_108 + 'lampu02 _on.bmp' ,path_image_108 + 'lampu02 _off.bmp', ListMissileR[2].Available);
       3 :  SetChangeImageIndikator(img_L3, path_image_108 + 'lampu03 _on.bmp' ,path_image_108 + 'lampu03 _off.bmp', ListMissileR[3].Available);
       4 :  SetChangeImageIndikator(img_L4, path_image_108 + 'lampu04 _on.bmp' ,path_image_108 + 'lampu04 _off.bmp', ListMissileR[4].Available);
       5 :  SetChangeImageIndikator(img_L5, path_image_108 + 'lampu05 _on.bmp' ,path_image_108 + 'lampu05 _off.bmp', ListMissileR[5].Available);
       6 :  SetChangeImageIndikator(img_L6, path_image_108 + 'lampu06 _on.bmp' ,path_image_108 + 'lampu06 _off.bmp', ListMissileR[6].Available);
       7 :  SetChangeImageIndikator(img_L7, path_image_108 + 'lampu07 _on.bmp' ,path_image_108 + 'lampu07 _off.bmp', ListMissileR[7].Available);
       8 :  SetChangeImageIndikator(img_L8, path_image_108 + 'lampu08 _on.bmp' ,path_image_108 + 'lampu08 _off.bmp', ListMissileR[8].Available);
       9 :  SetChangeImageIndikator(img_L9, path_image_108 + 'lampu09 _on.bmp' ,path_image_108 + 'lampu09 _off.bmp', ListMissileR[9].Available);
       10 : SetChangeImageIndikator(img_L10, path_image_108 + 'lampu10 _on.bmp' ,path_image_108 + 'lampu10 _off.bmp', ListMissileR[10].Available);
       11 : SetChangeImageIndikator(img_L11, path_image_108 + 'lampu11 _on.bmp' ,path_image_108 + 'lampu11 _off.bmp', ListMissileR[11].Available);
       12 : SetChangeImageIndikator(img_L12, path_image_108 + 'lampu12 _on.bmp' ,path_image_108 + 'lampu12 _off.bmp', ListMissileR[12].Available);
     end;
   end
   else
   begin
       case idx of
       1: SetChangeImageIndikator(img_L1, path_image_108 + 'lampu01 _on.bmp' ,path_image_108 + 'lampu01 _off.bmp', ListMissileL[1].Available);
       2: SetChangeImageIndikator(img_L2, path_image_108 + 'lampu02 _on.bmp' ,path_image_108 + 'lampu02 _off.bmp', ListMissileL[2].Available);
       3: SetChangeImageIndikator(img_L3, path_image_108 + 'lampu03 _on.bmp' ,path_image_108 + 'lampu03 _off.bmp', ListMissileL[3].Available);
       4: SetChangeImageIndikator(img_L4, path_image_108 + 'lampu04 _on.bmp' ,path_image_108 + 'lampu04 _off.bmp', ListMissileL[4].Available);
       5: SetChangeImageIndikator(img_L5, path_image_108 + 'lampu05 _on.bmp' ,path_image_108 + 'lampu05 _off.bmp', ListMissileL[5].Available);
       6: SetChangeImageIndikator(img_L6, path_image_108 + 'lampu06 _on.bmp' ,path_image_108 + 'lampu06 _off.bmp', ListMissileL[6].Available);
       7: SetChangeImageIndikator(img_L7, path_image_108 + 'lampu07 _on.bmp' ,path_image_108 + 'lampu07 _off.bmp', ListMissileL[7].Available);
       8: SetChangeImageIndikator(img_L8, path_image_108 + 'lampu08 _on.bmp' ,path_image_108 + 'lampu08 _off.bmp', ListMissileL[8].Available);
       9: SetChangeImageIndikator(img_L9, path_image_108 + 'lampu09 _on.bmp' ,path_image_108 + 'lampu09 _off.bmp', ListMissileL[9].Available);
       10:SetChangeImageIndikator(img_L10, path_image_108 + 'lampu10 _on.bmp' ,path_image_108 + 'lampu10 _off.bmp', ListMissileL[10].Available);
       11:SetChangeImageIndikator(img_L11, path_image_108 + 'lampu11 _on.bmp' ,path_image_108 + 'lampu11 _off.bmp', ListMissileL[11].Available);
       12:SetChangeImageIndikator(img_L12, path_image_108 + 'lampu12 _on.bmp' ,path_image_108 + 'lampu12 _off.bmp', ListMissileL[12].Available);
      end;
    end;
end;



procedure Tfrm108.RTLauncherLoadingSelectorChange(Sender: TObject);
begin
//if Caption = 'Kanan' then
//  SetChangeImageIndikator(imgSelLauncher,path_image_108 +'RedInd.bmp', path_image_108 +'OffInd.bmp', ListMissileR[RTLauncherLoadingSelector.SwitchPosition+1].Available)
//else
//  SetChangeImageIndikator(imgSelLauncher,path_image_108 +'RedInd.bmp', path_image_108 +'OffInd.bmp', ListMissileL[RTLauncherLoadingSelector.SwitchPosition+1].Available);
  ManuallyLoadMissile;
  case RTLauncherLoadingSelector.SwitchPosition + 1 of
    1  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher1.bmp');
    2  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher2.bmp');
    3  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher3.bmp');
    4  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher4.bmp');
    5  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher5.bmp');
    6  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher6.bmp');
    7  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher7.bmp');
    8  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher8.bmp');
    9  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher9.bmp');
    10 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher10.bmp');
    11 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher11.bmp');
    12 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher12.bmp');
  end;
end;

procedure Tfrm108.RunLauncherRBU(Launcher: TLoncher; Mode : word);
var lRec : TRec3DSetRBU;
    s:string;
    Range : Double;
begin

 Range   := StrToFloat(RBU_MAnager.frmTopBurja.edtJarak.text) * C_Cable_To_Meter; // jarak dlm meter

 if Mode = __ORD_RBU_LOADING then
    Use_Balistik := 2
 else
    GetBalistik(BalistikMode, Range,  Use_Balistik);

   if not Is_WarMode then begin            // Switch burja pada posisi Latihan
    Range := Range - 3300;
    if Range <= 500 then
       Range := 500;
  end;

      lRec.ShipID         := RBU_MAnager.pShipID;;
      lRec.mWeaponID      := C_DBID_RBU6000;
      lRec.mMissileID     := 1;
      lRec.mMissileNumber := lRec.mMissileID;
      lRec.mMissileType   := Use_Balistik;
      lRec.mTargetID      := TargetID;
      lRec.mCount         := 12;
      lRec.mLncrBearing   := Launcher.TrainingValue;
      lRec.mLncRange      := StrToFloat(RBU_MAnager.frmPanelFire.edtJarak.text) * C_Cable_To_Meter;
      lRec.mTargetDepth   := strToFloat(RBU_MAnager.frmTopBurja.edt_Kedalaman.Text);
      lRec.mCorrBearing   := strToFloat(RBU_MAnager.frmTopBurja.edt_KoreksiTraining.Text);
      lRec.mCorrElev      := strToFloat(RBU_MAnager.frmTopBurja.edt_KoreksiElevasi.Text);;
      lRec.mLauncherID    := Launcher.ID;
      lRec.OrderID        := Mode;

      if Launcher.TrainingOn and Launcher.ElevOn then begin
        if (RBU_MAnager.Datcom <> nil) then
           RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);

         if (Mode = __ORD_RBU_ASSIGNED) or (Mode = __ORD_RBU_AUTO) then begin
           s:='ASSIGN';
           Launcher.IsLoading := False;
           if Launcher.ID = 1 then
             RBU_MAnager.SendEvenRBU(12)
           else
             RBU_MAnager.SendEvenRBU(13);
         end
         else if Mode = __ORD_RBU_LOADING  then begin
           s:='LOADING';
           Launcher.IsLoading := True;
           if Launcher.ID = 1 then
             RBU_MAnager.SendEvenRBU(10)
           else
             RBU_MAnager.SendEvenRBU(11);
         end;

         RBU_MAnager.frmPanelFire.mmo1.Lines.Add(s);
         RBU_MAnager.frmPanelFire.mmo1.Lines.Add(FloatToStr(lRec.mLncrBearing));
         RBU_MAnager.frmPanelFire.mmo1.Lines.Add(FloatToStr(lRec.mLncRange));
         RBU_MAnager.frmPanelFire.mmo1.Lines.Add('');
      end;
end;

procedure Tfrm108.RTModeSelectorChange(Sender: TObject);
var Lncr    : TLoncher;
    orderID : Word;
    tmrLoad : Ttimer;
    Right   : Boolean;
    MdLonch : TModeLonch;
    Range   : Double;
begin
   Range   := StrToFloat(RBU_MAnager.frmTopBurja.edtJarak.text) * C_Cable_To_Meter; // jarak dlm meter

   SetChangeImageIndikator(imgSelMode ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', false);
   SetChangeImageIndikator(imgSelLauncher ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', false);

    if Caption = 'Kanan' then begin
      Lncr := Lonch1;
      tmrLoad := tmrLoadMissileR;
      IsReadyToManualLoadR := false;
      Right := True;
//      MdLonch := ModeLonchR;
    end
    else begin
      Lncr := Lonch2;
      tmrLoad := tmrLoadMissile;
      IsReadyToManualLoad  := false;
      Right := false;
//    MdLonch := ModeLonchL;
    end;

   case TModeLonch(RTModeSelector.SwitchPosition) of
     mlAuto : begin
        tmrLoad.Enabled:= False;
//      orderID             := __ORD_RBU_LOADING;
        SetChangeImageIndikator(imgSelMode ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', false);
        SetChangeImageIndikator(imgSelLauncher ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', false);
        exit;
     end;

     mlManualLoad : begin
        if Right then
          IsReadyToManualLoadR := true
        else
          IsReadyToManualLoad  := true;

        tmrLoad.Enabled:= False;

        if not Isrunning then Exit;
        orderID             := __ORD_RBU_LOADING;

        setIndikatorLoadAndDirection(True);
     end;

     mlDirection : begin

       tmrLoad.Enabled:= False;
       if not Isrunning then Exit;

       if RBU_MAnager.IsSonarTracked then
         orderID             := __ORD_RBU_AUTO
       else
         orderID             := __ORD_RBU_ASSIGNED;

       setIndikatorLoadAndDirection(false);
     end;
   end;
   RunLauncherRBU(Lncr , orderID);


end;

procedure Tfrm108.RTModeSelectorMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
Var r : TRect;
begin

end;

procedure Tfrm108.RunNeedle(Mtr: TvrMeter; Step: integer);
begin
     if Mtr.Position < Step then
        Mtr.Position := Mtr.Position + 1
     else if Mtr.Position > Step then
        Mtr.Position := Mtr.Position - 1;
end;

procedure Tfrm108.tmr2Timer(Sender: TObject);
begin
    RunNeedle(vrmtrUnf2A,am1[StepNeedle]);
    RunNeedle(vrmtrUnf2B,am2[StepNeedle]);

    if (vrmtrUnf2B.Position = am2[StepNeedle])
      and (vrmtrUnf2A.Position = am1[StepNeedle]) then

     StepNeedle := StepNeedle + 1;
    if StepNeedle = 7 then begin
      tmr2.Enabled := False;
      StepNeedle := 1;
    end;
end;

procedure Tfrm108.tmr3Timer(Sender: TObject);
begin
    RunNeedle(vrmtrUnf1A,am1[StepNeedle]);
    RunNeedle(vrmtrUnf1B,am2[StepNeedle]);

    if (vrmtrUnf1B.Position = am2[StepNeedle])
      and (vrmtrUnf1A.Position = am1[StepNeedle]) then
     StepNeedle := StepNeedle + 1;

    if StepNeedle = 7 then begin
      tmr3.Enabled := False;
      StepNeedle := 1;
    end;
end;
procedure Tfrm108.ManuallyLoadMissile;
begin
  if (Caption = 'Kanan') and IsReadyToManualLoadR then begin
    if ListMissileR[RTLauncherLoadingSelector.SwitchPosition + 1 ].Available then Exit;
    tmrLoadMissileR.Enabled:= False;
    CountToLoadMisileR :=0;
    if IsReadyToManualLoadR and Isrunning then
       if (TModeLonch(RTModeSelector.SwitchPosition)) =  mlManualLoad then
         tmrLoadMissileR.Enabled:= True;
  end;

  if (Caption = 'Kiri') and IsReadyToManualLoad then begin
    if ListMissileL[RTLauncherLoadingSelector.SwitchPosition + 1 ].Available then Exit;
    tmrLoadMissile.Enabled:= False;
    CountToLoadMisile :=0;
    if IsReadyToManualLoad and Isrunning then
       if (TModeLonch(RTModeSelector.SwitchPosition)) =  mlManualLoad then
         tmrLoadMissile.Enabled:= True;
  end;
end;

procedure Tfrm108.tmrLoadMissileRTimer(Sender: TObject);
label next;
begin
   CountToLoadMisileR    := CountToLoadMisileR + 1;
   if (TModeLonch(RTModeSelector.SwitchPosition) = mlManualLoad) then begin
      if CountToLoadMisileR >= TimeManulaLoadMissile then begin
         if Caption = 'Kanan' then begin
           LoadingMissile(ListMissileR[RTLauncherLoadingSelector.SwitchPosition + 1 ], True);
         end;
         CountToLoadMisileR :=0;
         tmrLoadMissileR.Enabled := False;
         RefreshMissileIndikator(RTLauncherLoadingSelector.SwitchPosition + 1);
         SetChangeImageIndikator(imgSelLauncher,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', true);
      end;
   end
   else if (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto) then begin
      if CountToLoadMisileR >= TimeAutoLoadMissile then begin
         Next:
         CountAutoLoadMissileR := CountAutoLoadMissileR + 1;

         if CountAutoLoadMissileR > 12 then begin
            tmrLoadMissileR.Enabled := False;
            CountAutoLoadMissileR := 0;
            exit;
         end;

         if Caption = 'Kanan' then begin
           if ListMissileR[CountAutoLoadMissileR].Available then
              goto Next;

           LoadingMissile(ListMissileR[CountAutoLoadMissileR], True);
         end;
          CountToLoadMisileR :=0;
         RefreshMissileIndikator(CountAutoLoadMissileR);
      end;
   end;
end;

procedure Tfrm108.tmrLoadMissileTimer(Sender: TObject);
label next;
begin
   CountToLoadMisile    := CountToLoadMisile +1;

   if (TModeLonch(RTModeSelector.SwitchPosition) = mlManualLoad)  then begin
      if CountToLoadMisile >= TimeManulaLoadMissile then begin
           LoadingMissile(ListMissileL[RTLauncherLoadingSelector .SwitchPosition + 1 ], True);
         CountToLoadMisile :=0;
         tmrLoadMissile.Enabled := False;
         RefreshMissileIndikator(RTLauncherLoadingSelector.SwitchPosition + 1);
         SetChangeImageIndikator(imgSelLauncher,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', true);
      end;
   end
   else if (TModeLonch(RTModeSelector.SwitchPosition) = mlAuto) then begin
      if CountToLoadMisile >= TimeAutoLoadMissile then begin
         Next:
         CountAutoLoadMissile := CountAutoLoadMissile + 1;

         if CountAutoLoadMissile > 12 then begin
           tmrLoadMissile.Enabled := False;
           CountAutoLoadMissile := 0;
           exit;
         end;

          if ListMissileL[CountAutoLoadMissile].Available then
              goto Next;
           LoadingMissile(ListMissileL[CountAutoLoadMissile], True);

         CountToLoadMisile :=0;
         RefreshMissileIndikator(CountAutoLoadMissile);
      end;


   end;

end;

procedure Tfrm108.img1Click(Sender: TObject);
begin
  ShipLink_is_On := True;
end;

procedure Tfrm108.imgLauncNumbClick(Sender: TObject);
begin
//  launcNumb := launcNumb + 1;
//
//  if launcNumb = 13 then
//    launcNumb := 1;
//
//  case launcNumb of
//    1  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_01.bmp');
//    2  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_02.bmp');
//    3  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_03.bmp');
//    4  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_04.bmp');
//    5  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_05.bmp');
//    6  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_06.bmp');
//    7  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_07.bmp');
//    8  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_08.bmp');
//    9  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_09.bmp');
//    10 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_10.bmp');
//    11 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_11.bmp');
//    12 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_12.bmp');
//  end;
//
//  case launcNumb of
//    1  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher1.bmp');
//    2  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher2.bmp');
//    3  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher3.bmp');
//    4  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher4.bmp');
//    5  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher5.bmp');
//    6  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher6.bmp');
//    7  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher7.bmp');
//    8  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher8.bmp');
//    9  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher9.bmp');
//    10 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher10.bmp');
//    11 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher11.bmp');
//    12 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher12.bmp');
//  end;

end;
{
Procedure Tfrm108.LoadingMissile(var Msl: TRecMissile; reload : boolean);
var time : Integer;
begin
  Msl.Available := reload;
end;

procedure Tfrm108.tmr1Timer(Sender: TObject);
begin

end;
 }
end.

