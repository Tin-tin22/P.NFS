unit uNetral;

interface

uses
   MapXLib_TLB, Windows, Graphics, Math, Dialogs, SysUtils, Classes;

type
  TNetral = class
    const

    private

    public

      procedure normalization;
      procedure norm_condition;
      procedure norm_panel;
      procedure norm_button;
      procedure norm_label;
      procedure norm_other;

      procedure norm_record;
  end;

var
   netral : TNetral;
   //qLaunchedRegime : Integer;

implementation

uses
  uMainMM, uYakhontManager, uManualInput, uCirculationASM, uAppointmentASM, uEmergencyRelease, uRegimesOfWork, uAcknowledgement;

procedure TNetral.normalization;
begin
  norm_condition;
  norm_panel;
  norm_button;
  norm_label;
  norm_other;

  norm_record;
end;

procedure TNetral.norm_condition;
var
  I, qOprational, qPassed, qLaunched : Integer;
begin
  with fmMainMM do
  begin
    C__isSendKey := false;
    C__isReady   := false;
    C__isSC_On   := false;


    isTI   := false;
    isSD   := false;
    isDES  := false;
    isPLP  := false;
    isDOC  := false;
    isExit := false;

    checkCancelAll := False;

//    isCWR  := false;
//    isAWR  := false;
//    isER   := false;

    checkRequestInstructure := False;

    for I := 1 to 4 do
    begin
      if fmMainMM.readyToLaunch[I] = 2 then
          //qLaunchedRegime   := qLaunchedRegime + 1;
    end;



    if fmMain.missileLoaded1 = True then
    begin
      YakhontManager.Missile1.isReady := true;
      readyToLaunch[1]:=1;
    end
    else
    begin
      YakhontManager.Missile1.isReady := False;
      readyToLaunch[1]:=3;
    end;

    if fmMain.missileLoaded2 = True then
    begin
      YakhontManager.Missile2.isReady := true;
      readyToLaunch[2]:=1;
    end
    else
    begin
      YakhontManager.Missile2.isReady := False;
      readyToLaunch[2]:=3;
    end;

    if fmMain.missileLoaded3 = True then
    begin
      YakhontManager.Missile3.isReady := true;
      readyToLaunch[3]:=1;
    end
    else
    begin
      YakhontManager.Missile3.isReady := False;
      readyToLaunch[3]:=3;
    end;

    if fmMain.missileLoaded4 = True then
    begin
      YakhontManager.Missile4.isReady := true;
      readyToLaunch[4]:=1;
    end
    else
    begin
      YakhontManager.Missile4.isReady := False;
      readyToLaunch[4]:=3;
    end;

//    YakhontManager.Missile1.isReady := True;
//    YakhontManager.Missile2.isReady := True;
//    YakhontManager.Missile3.isReady := True;
//    YakhontManager.Missile4.isReady := True;

    YakhontManager.Missile1.state   := YakhontManager.Missile1.C_noState;
    YakhontManager.Missile2.state   := YakhontManager.Missile2.C_noState;
    YakhontManager.Missile3.state   := YakhontManager.Missile3.C_noState;
    YakhontManager.Missile4.state   := YakhontManager.Missile4.C_noState;


    for I := 1 to 5 do
     checkerButtonProcedure[I] := 0;

    { readyto launch :
    0 = cancel
    1 = oprational
    2 = launched
    3 = passed }
    qOprational := 0;
    qPassed := 0;

    for I := 1 to 4 do
    begin
      if fmMainMM.readyToLaunch[I] = 1 then
        qOprational := qOprational + 1;

     if fmMainMM.readyToLaunch[I] = 3 then
        qPassed     := qPassed + 1;

    end;


    countAvailable  := 0;
    countOprational := qOprational;
    countDesignated := 0;
    countCancelled  := 0;
    countLaunched   := 0;
    countPassed     := qPassed;

    SD := false;
  end;

  with frmCirculationASM do
  begin
//    checkCirculationASM_1:=False;
//    checkCirculationASM_2:=False;
//    checkCirculationASM_3:=False;
//    checkCirculationASM_4:=False;
    checkCirculationReady1:=False;
    checkCirculationReady2:=False;
    checkCirculationReady3:=False;
    checkCirculationReady4:=False;
    checkCancelAll1:=False;
    checkCancelAll2:=False;
    checkCancelAll3:=False;
    checkCancelAll4:=False;
  end;

  with frmAppointmentASM do
  begin
    //checkAppointmentASM_1:=False;
    //checkAppointmentASM_2:=False;
    //checkAppointmentASM_3:=False;
    //checkAppointmentASM_4:=False;
    checkAppointmentASMReady:=False;
  end;

  with frmEmergencyRelease do
  begin
    //checkEmergency_1:=False;
    //checkEmergency_2:=False;
    //checkEmergency_3:=False;
    //checkEmergency_4:=False;
    checkRelease:=False;
    checkEmergency1:=False;
    checkEmergency2:=False;
    checkEmergency3:=False;
    checkEmergency4:=False;
    EmergencyLaunched_1:=False;
    EmergencyLaunched_2:=False;
    EmergencyLaunched_3:=False;
    EmergencyLaunched_4:=False;

  end;

  YakhontManager.isTimeAgeStart := False;
  YakhontManager.isTargetInRange := False;

  frmAcknowledgement.checkEmergencyButton := false;
end;

procedure TNetral.norm_panel;
begin
  with fmMainMM do
  begin
    Panel13.Color         := RGB(15, 69, 69);
    Panel14.Color         := RGB(15, 69, 69);
    Panel15.Color         := RGB(15, 69, 69);
    Panel16.Color         := RGB(15, 69, 69);
    Panel17.Color         := RGB(15, 69, 69);
    Panel18.Color         := RGB(15, 69, 69);

    pnlLeftCenter.Color   := RGB(15, 69, 69);
    pnlLeftBottom.Color   := RGB(15, 69, 69);
    pnlPLP.Color          := RGB(15, 69, 69);
    pnlMainPLP.Color      := RGB(15, 69, 69);

    pnlNow.Color          := RGB(15, 69, 69);
    pnlNext.Color         := RGB(15, 69, 69);

    pnlDate.Color         := RGB(15, 69, 69);
    pnlTime.Color         := RGB(15, 69, 69);
    pnlSC.Color           := RGB(15, 69, 69);
    pnlFault.Color        := RGB(15, 69, 69);
    pnlsperryMK.Color     := RGB(15, 69, 69);
    pnlTI1.Color          := RGB(15, 69, 69);
    pnlTI2.Color          := RGB(15, 69, 69);
    pnlTimeAge.Color      := RGB(15, 69, 69);
    pnlRegime.Color       := RGB(15, 69, 69);
    pnlTimeOfRegime.Color := RGB(15, 69, 69);

    {pnlPLP1.Color := clPurple;
    pnlPLP2.Color := clPurple;
    pnlPLP3.Color := clPurple;
    pnlPLP4.Color := clPurple;}

    progBarPrePLP.Visible := True;
    progBarPLP.Visible    := False;
    progBarPrePLP.Position := 0;

    //Set Nilai random T
     value_T1 := RandomRange(881,891)*0.01;
     value_T2 := RandomRange(881,891)*0.01;
     value_T3 := RandomRange(881,891)*0.01;
     value_T4 := RandomRange(881,891)*0.01;


    if fmMain.missileLoaded1 = True then
    begin
      pnlPLP1.Color := clLime;
      frmCirculationASM.colorMissile1.Color := clCream;
      frmAppointmentASM.colorMissile1.Color := clCream;
      pnlNoASM1.Caption:= '1';
      pnlT1.Caption    := FloatToStr(fmMainMM.value_T1);
      pnlTmax1.Caption := FloatToStr(fmMainMM.value_TMax);
      pnltmaxs1.Caption:= FloatToStr(fmMainMM.value_TmaxS);
    end
    else if fmMain.missileLoaded1 = False then
    begin
      pnlPLP1.Color := clPurple;
      frmCirculationASM.colorMissile1.Color := clRed;
      frmAppointmentASM.colorMissile1.Color := clRed;
      pnlNoASM1.Caption:= '';
      pnlT1.Caption    := '';
      pnlTmax1.Caption := '';
      pnltmaxs1.Caption:= '';
    end;

    if fmMain.missileLoaded2 = True then
    begin
      pnlPLP2.Color := clLime;
      frmCirculationASM.colorMissile2.Color := clCream;
      frmAppointmentASM.colorMissile2.Color := clCream;
      pnlNoASM2.Caption:= '2';
      pnlT2.Caption    := FloatToStr(fmMainMM.value_T2);
      pnlTmax2.Caption := FloatToStr(fmMainMM.value_TMax);
      pnltmaxs2.Caption:= FloatToStr(fmMainMM.value_TmaxS);
    end
    else if fmMain.missileLoaded2 = False then
    begin
      pnlPLP2.Color := clPurple;
      frmCirculationASM.colorMissile2.Color := clRed;
      frmAppointmentASM.colorMissile2.Color := clRed;
      pnlNoASM2.Caption:= '';
      pnlT2.Caption    := '';
      pnlTmax2.Caption := '';
      pnltmaxs2.Caption:= '';
    end;

    if fmMain.missileLoaded3 = True then
    begin
      pnlPLP3.Color := clLime;
      frmCirculationASM.colorMissile3.Color := clCream;
      frmAppointmentASM.colorMissile3.Color := clCream;
      pnlNoASM3.Caption:= '3';
      pnlT3.Caption    := FloatToStr(fmMainMM.value_T3);
      pnlTmax3.Caption := FloatToStr(fmMainMM.value_TMax);
      pnltmaxs3.Caption:= FloatToStr(fmMainMM.value_TmaxS);
    end
    else if fmMain.missileLoaded3 = False then
    begin
      pnlPLP3.Color := clPurple;
      frmCirculationASM.colorMissile3.Color := clRed;
      frmAppointmentASM.colorMissile3.Color := clRed;
      pnlNoASM3.Caption:= '';
      pnlT3.Caption    := '';
      pnlTmax3.Caption := '';
      pnltmaxs3.Caption:= '';
    end;

    if fmMain.missileLoaded4 = True then
    begin
      pnlPLP4.Color := clLime;
      frmCirculationASM.colorMissile4.Color := clCream;
      frmCirculationASM.colorMissile4.Color := clCream;
      pnlNoASM4.Caption:= '4';
      pnlT4.Caption    := FloatToStr(fmMainMM.value_T4);
      pnlTmax4.Caption := FloatToStr(fmMainMM.value_TMax);
      pnltmaxs4.Caption:= FloatToStr(fmMainMM.value_TmaxS);
    end
    else if fmMain.missileLoaded4 = False then
    begin
      pnlPLP4.Color := clPurple;
      frmCirculationASM.colorMissile4.Color := clRed;
      frmAppointmentASM.colorMissile4.Color := clRed;
      pnlNoASM4.Caption:= '';
      pnlT4.Caption    := '';
      pnlTmax4.Caption := '';
      pnltmaxs4.Caption:= '';
    end;

    pnlRegime.Caption      := '';

    pnlRTP.Caption         := '';
    pnlRange.Caption       := '';

    pnlNow.Caption         := '';
    pnlNext.Caption        := '';

    pnlAvailable.Caption   := IntToStr(countAvailable);
    pnlOperational.Caption := IntToStr(countOprational);
    pnlDesignated.Caption  := IntToStr(countDesignated);
    pnlCancelled.Caption   := IntToStr(countCancelled);
    pnlLaunched.Caption    := IntToStr(countLaunched);
    pnlPassed.Caption      := IntToStr(countPassed);
  end;

end;

procedure TNetral.norm_button;
begin
  with fmMainMM do
  begin
    btnRTP.Font.Color  := clWhite;
    btnPTP.Font.Color  := clWhite;
    btnLock.Font.Color := clWhite;
    btnTD.Font.Color   := clWhite;

    btnSD.Font.Color   := clWhite;
    btnDES.Font.Color  := clWhite;
    btnPLP.Font.Color  := clWhite;
    btnDOC.Font.Color  := clWhite;

    btnTI.Font.Color   := clBlack;
    btnSD.Font.Color   := clBlack;
    btnDES.Font.Color  := clBlack;
    btnPLP.Font.Color  := clBlack;
    btnDOC.Font.Color  := clBlack;
    btnEXIT.Font.Color := clBlack;

    btnTI.Enabled      := True;
    btnSD.Enabled      := True;
    btnDES.Enabled     := True;
    btnPLP.Enabled     := True;
    btnDOC.Enabled     := True;
    btnEXIT.Enabled    := True;
    btnAWR.Enabled     := True;
    btnCWR.Enabled     := True;
    btnER.Enabled      := True;
  end;
end;

procedure TNetral.norm_label;
begin
  with fmMainMM do
  begin
    lblType.Caption             := '';
    lblD.Caption                := '';
    lblDd.Caption               := '';
    lblPx.Caption               := '';
    lblB.Caption                := '';
    lblDj.Caption               := '';
    lblDsgh.Caption             := '';
    lblPz.Caption               := '';
    lblTrajectoryType.Caption   := '';
  end;
end;

procedure TNetral.norm_other;
begin
  with fmMainMM do
  begin
    tempCounter := 0;
    progBarPLP.Position  := 0;
    pnlTimeOfRegime.Caption := setTime(0.0);
    pnlTimeAge.Caption := SetTime(0.0);
  end;
end;

procedure TNetral.norm_record;
begin
  with frmManualInput do
  begin
    Rec_TIVar1.MovingCompTI               := 0;
    Rec_TIVar1.DistTarget                 := 0;
    Rec_TIVar1.BearingTarget              := 0;
    Rec_TIVar1.HeadingTarget              := 0;
    Rec_TIVar1.SpeedTarget                := 0;
    Rec_TIVar1.MRSE_distTarget            := 0;
    Rec_TIVar1.MRSE_bearingTarget         := 0;
    Rec_TIVar1.MRSE_headingTarget         := 0;
    Rec_TIVar1.MRSE_speedTarget           := 0;
    Rec_TIVar1.AgeingTimeDataTarget       := 0;
    Rec_TIVar1.TypeTarget                 := 0;
    Rec_TIVar1.CoreRadius                 := 0;
    Rec_TIVar1.QuantityOfShipInCore       := 0;
    Rec_TIVar1.QuantityOfShipInFormation  := 0;

    Rec_TIVar2.MovingCompTI               := 0;
    Rec_TIVar2.LongTarget                 := 0;
    Rec_TIVar2.LattTarget                 := 0;
    Rec_TIVar2.MRSE_posTarget             := 0;
    Rec_TIVar2.HeadingTarget              := 0;
    Rec_TIVar2.Speedtarget                := 0;
    Rec_TIVar2.MRSE_headingTarget         := 0;
    Rec_TIVar2.MRSE_speedTarget           := 0;
    Rec_TIVar2.AgeingTimeDataTarget       := 0;
    Rec_TIVar2.TypeTarget                 := 0;
    Rec_TIVar2.CoreRadius                 := 0;
    Rec_TIVar2.QuantityOfShipInCore       := 0;
    Rec_TIVar2.QuantityOfShipInFormation  := 0;
  end;
end;

end.
