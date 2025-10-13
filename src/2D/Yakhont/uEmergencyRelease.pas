unit uEmergencyRelease;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmEmergencyRelease = class(TForm)
    pnlEmergencyRelease: TPanel;
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    Label1: TLabel;
    pnlMain: TPanel;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    btnExit: TSpeedButton;
    pnlMissile2: TPanel;
    pnlMissile1: TPanel;
    pnlMissile4: TPanel;
    pnlMissile3: TPanel;
    Panel5: TPanel;
    btnApproval: TSpeedButton;
    Label2: TLabel;
    pnlCancelASM: TPanel;
    pnlSC: TPanel;
    pnlBSJoined: TPanel;
    pnlLiquidInDLC: TPanel;
    pnlInitialArticles: TPanel;
    pnlArticles2BC: TPanel;
    pnlMalfunctionOBSC: TPanel;
    pnlInitialBC: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    Label11: TLabel;
    valueCancelASM: TLabel;

    procedure btnExitClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure pnlMissile1Click(Sender: TObject);
    procedure btnApprovalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var
      checkRelease : Boolean;
      checkEmergency_1, checkEmergency_2, checkEmergency_3, checkEmergency_4 : Boolean;
      checkEmergency1, checkEmergency2, checkEmergency3, checkEmergency4 : Boolean;
      EmergencyLaunched_1, EmergencyLaunched_2, EmergencyLaunched_3, EmergencyLaunched_4 : Boolean;

    procedure missile_ready_to_On;
  end;

var
  frmEmergencyRelease: TfrmEmergencyRelease;


implementation

uses
  uMainMM, uYakhontManager, uAcknowledgement, uTCPDatatype, uBaseFunction, uRegimesOfWork, uAppointmentASM, uCirculationASM;

{$R *.dfm}

procedure TfrmEmergencyRelease.btnApprovalClick(Sender: TObject);
begin
  frmAcknowledgement.FormStyle := fsNormal;
  frmAcknowledgement.ShowModal;
end;

procedure TfrmEmergencyRelease.btnExitClick(Sender: TObject);
begin
   missile_ready_to_On;
   pnlMissile1.Color := clSilver;
   pnlMissile2.Color := clSilver;
   pnlMissile3.Color := clSilver;
   pnlMissile4.Color := clSilver;

   Close;
end;

procedure TfrmEmergencyRelease.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     Close;
  end;
end;

procedure TfrmEmergencyRelease.FormShow(Sender: TObject);
begin
   if fmMain.MainMode = 2 then
   begin
     Left := 673;
     Top  := 308;
   end
   else
   begin
     Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 102;
     Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 113;
   end;
end;

procedure TfrmEmergencyRelease.pnlMissile1Click(Sender: TObject);
begin
   if (Sender = pnlMissile1) then
  begin
  if checkEmergency_1 = True then
    begin
      if pnlMissile1.Color = clSilver then
      begin
        pnlMissile1.Color := clGray;
        YakhontManager.Missile1.isReady := False;
        checkEmergency1 := True;
      end
      else if pnlMissile1.Color = clGray then
      begin
        pnlMissile1.Color := clSilver;
        YakhontManager.Missile1.isReady := True;
      end;

    end;

  end;


  if (Sender = pnlMissile2) then
  begin
  if checkEmergency_2 = True then
    begin
      if pnlMissile2.Color = clSilver then
      begin
        pnlMissile2.Color := clGray;
        YakhontManager.Missile2.isReady := False;
        checkEmergency2 := True;
      end
      else if pnlMissile2.Color = clGray then
      begin
        pnlMissile2.Color := clSilver;
        YakhontManager.Missile2.isReady := True;
      end;

    end;

  end;

  if (Sender = pnlMissile3) then
  begin
  if checkEmergency_3 = True then
    begin
      if pnlMissile3.Color = clSilver then
      begin
        pnlMissile3.Color := clGray;
        YakhontManager.Missile3.isReady := False;
        checkEmergency3 := True;
      end
      else if pnlMissile3.Color = clGray then
      begin
        pnlMissile3.Color := clSilver;
        YakhontManager.Missile3.isReady := True;
      end;

    end;

  end;

  if (Sender = pnlMissile4) then
  begin
    if checkEmergency_4 = True then
    begin
      if pnlMissile4.Color = clSilver then
      begin
        pnlMissile4.Color := clGray;
        YakhontManager.Missile4.isReady := False;
        checkEmergency4 := True;
      end
      else if pnlMissile4.Color = clGray then
      begin
        pnlMissile4.Color := clSilver;
        YakhontManager.Missile4.isReady := True;
      end;

    end;
  end;

end;

procedure TfrmEmergencyRelease.missile_ready_to_On;
var
   I : Integer;
   qCancel, qOprational, qLaunched, qPassed : Integer;
   rec_dataEmergencyYakhont : TRecData_Yakhont;
   rec_Emergency : TRecCMD_Yakhont;
begin
   qCancel     := 0;
   qOprational := 0;
   qLaunched   := 0;
   qPassed     := 0;
   rec_dataEmergencyYakhont.ShipID         := UniqueID_To_dbID(YakhontManager.xShip.UniqueID);
   rec_dataEmergencyYakhont.mMissileID     := 1;
   rec_dataEmergencyYakhont.mWeaponID      := C_DBID_YAKHONT;
   rec_dataEmergencyYakhont.mTargetBearing := 0;
   rec_dataEmergencyYakhont.mTargetRange   := 0;
   rec_dataEmergencyYakhont.mMissile1      := 0;
   rec_dataEmergencyYakhont.mMissile2      := 0;
   rec_dataEmergencyYakhont.mMissile3      := 0;
   rec_dataEmergencyYakhont.mMissile4      := 0;

   { missile 1 }
   if YakhontManager.Missile1.isReady = True then
   begin
      if YakhontManager.Missile1.state = YakhontManager.Missile1.C_passed then
      begin
        with fmMainMM do
        begin
          readyToLaunch[1]  := 1;
          pnlPLP1.Color     := clLime;

          pnlNoASM1.Caption := '1';
          pnlT1.Caption     := FloatToStr(value_T1);
          pnlTmax1.Caption  := FloatToStr(value_TMax);
          pnltmaxs1.Caption := FloatToStr(value_TmaxS);
        end;
        YakhontManager.Missile1.isReady := True;
        YakhontManager.Missile1.state   := YakhontManager.Missile1.C_noState;
      end;
   end
   else
   begin
      if YakhontManager.Missile1.state = YakhontManager.Missile1.C_noState then
      begin
        if checkEmergency1 = True then
        begin
          with fmMainMM do
          begin
            //readyToLaunch[1]  := 2;
            //pnlPLP1.Color     := clAqua;
            if frmAcknowledgement.checkEmergencyButton then
            begin
              rec_dataEmergencyYakhont.mMissile1:=1;
              rec_dataEmergencyYakhont.mMissileNumber:=1;
              rec_dataEmergencyYakhont.OrderID:=2;
              rec_dataEmergencyYakhont.mLauncherID:=2;
              checkRelease:=True;
              //YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
              //pnlPLP2.Color   := clGray ;
              checkEmergency_1:=False;
              frmCirculationASM.checkCirculationASM_1:=False;
              frmAppointmentASM.checkAppointmentASM_1:=False;
              EmergencyLaunched_1 := True;
              readyToLaunch[1] := 3;
              checkEmergency1 := False;
//              frmAcknowledgement.checkEmergencyButton := False;
              pnlNoASM1.Caption := '';
              pnlT1.Caption     := '';
              pnlTmax1.Caption  := '';
              pnltmaxs1.Caption := '';
            end;


          end;
          YakhontManager.Missile1.isReady := False;
          YakhontManager.Missile1.state   := YakhontManager.Missile1.C_passed;
        end;

      end;
   end;

   { missile 2 }
   if YakhontManager.Missile2.isReady = True then
   begin
      if YakhontManager.Missile2.state = YakhontManager.Missile2.C_passed then
      begin
        with fmMainMM do
        begin
          readyToLaunch[2]  := 1;
          pnlPLP2.Color     := clLime;

          pnlNoASM2.Caption := '2';
          pnlT2.Caption     := FloatToStr(value_T2);
          pnlTmax2.Caption  := FloatToStr(value_TMax);
          pnltmaxs2.Caption := FloatToStr(value_TmaxS);
        end;
        YakhontManager.Missile2.isReady := True;
        YakhontManager.Missile2.state   := YakhontManager.Missile2.C_noState;
      end;
   end
   else
   begin
      if YakhontManager.Missile2.state = YakhontManager.Missile2.C_noState then
      begin
        if checkEmergency2 = True then
        begin
          with fmMainMM do
          begin
            //readyToLaunch[2]  := 2;
            //pnlPLP2.Color     := clAqua;
            if frmAcknowledgement.checkEmergencyButton then
            begin
              rec_dataEmergencyYakhont.mMissile2:=1;
              rec_dataEmergencyYakhont.mMissileNumber:=1;
              rec_dataEmergencyYakhont.OrderID:=2;
              rec_dataEmergencyYakhont.mLauncherID:=2;
              checkRelease:=True;
              //YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
              //pnlPLP2.Color   := clGray ;
              checkEmergency_2:=False;
              frmCirculationASM.checkCirculationASM_2:=False;
              frmAppointmentASM.checkAppointmentASM_2:=False;
              EmergencyLaunched_2 := True;
              readyToLaunch[2] := 3;
              checkEmergency2 := False;
//              frmAcknowledgement.checkEmergencyButton := False;
              pnlNoASM2.Caption := '';
              pnlT2.Caption     := '';
              pnlTmax2.Caption  := '';
              pnltmaxs2.Caption := '';
            end;


          end;
          YakhontManager.Missile2.isReady := False;
          YakhontManager.Missile2.state   := YakhontManager.Missile2.C_passed;
        end;

      end;
   end;

   { missile 3 }
   if YakhontManager.Missile3.isReady = True then
   begin
      if YakhontManager.Missile3.state = YakhontManager.Missile3.C_passed then
      begin
        with fmMainMM do
        begin
          readyToLaunch[3]  := 1;
          pnlPLP3.Color     := clLime;

          pnlNoASM3.Caption := '3';
          pnlT3.Caption     := FloatToStr(value_T3);
          pnlTmax3.Caption  := FloatToStr(value_TMax);
          pnltmaxs3.Caption := FloatToStr(value_TmaxS);
        end;
        YakhontManager.Missile3.isReady := True;
        YakhontManager.Missile3.state   := YakhontManager.Missile3.C_noState;
      end;
   end
   else
   begin
      if YakhontManager.Missile3.state = YakhontManager.Missile3.C_noState then
      begin
        if checkEmergency3 = True then
        begin
          with fmMainMM do
          begin
            //readyToLaunch[3]  := 2;
            //pnlPLP3.Color     := clAqua;
            if frmAcknowledgement.checkEmergencyButton then
            begin
              rec_dataEmergencyYakhont.mMissile3:=1;
              rec_dataEmergencyYakhont.mMissileNumber:=1;
              rec_dataEmergencyYakhont.OrderID:=2;
              rec_dataEmergencyYakhont.mLauncherID:=3;
              checkRelease:=True;
              //YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
              //pnlPLP3.Color   := clGray;
              checkEmergency_1:=False;
              frmCirculationASM.checkCirculationASM_3:=False;
              frmAppointmentASM.checkAppointmentASM_3:=False;
              EmergencyLaunched_3 := True;
              readyToLaunch[3] := 3;
              checkEmergency3 := False;
//              frmAcknowledgement.checkEmergencyButton := False;
              pnlNoASM3.Caption := '';
              pnlT3.Caption     := '';
              pnlTmax3.Caption  := '';
              pnltmaxs3.Caption := '';
            end;


          end;
          YakhontManager.Missile3.isReady := False;
          YakhontManager.Missile3.state   := YakhontManager.Missile3.C_passed;
      end;

      end;
   end;

   { missile 4 }
   if YakhontManager.Missile4.isReady = True then
   begin
      if YakhontManager.Missile4.state = YakhontManager.Missile4.C_passed then
      begin
        with fmMainMM do
        begin
          readyToLaunch[4]  := 1;
          pnlPLP4.Color     := clLime;

          pnlNoASM4.Caption := '4';
          pnlT4.Caption     := FloatToStr(value_T4);
          pnlTmax4.Caption  := FloatToStr(value_TMax);
          pnltmaxs4.Caption := FloatToStr(value_TmaxS);
        end;
        YakhontManager.Missile4.isReady := True;
        YakhontManager.Missile4.state   := YakhontManager.Missile4.C_noState;
      end;
   end
   else
   begin
      if YakhontManager.Missile4.state = YakhontManager.Missile4.C_noState then
      begin
        if checkEmergency4 = True then
        begin
          with fmMainMM do
          begin
            //readyToLaunch[4]  := 2;
            //pnlPLP4.Color     := clAqua;
            if frmAcknowledgement.checkEmergencyButton then
            begin
              rec_dataEmergencyYakhont.mMissile4:=1;
              rec_dataEmergencyYakhont.mMissileNumber:=1;
              rec_dataEmergencyYakhont.OrderID:=2;
              rec_dataEmergencyYakhont.mLauncherID:=4;
              checkRelease:=True;
              //YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
              //pnlPLP4.Color   := clGray;
              checkEmergency_4:=False;
              frmCirculationASM.checkCirculationASM_4:=False;
              frmAppointmentASM.checkAppointmentASM_4:=False;
              EmergencyLaunched_4 := True;
              readyToLaunch[4] := 3;
              checkEmergency4 := False;
//              frmAcknowledgement.checkEmergencyButton := False;
              pnlNoASM4.Caption := '';
              pnlT4.Caption     := '';
              pnlTmax4.Caption  := '';
              pnltmaxs4.Caption := '';
            end;


          end;
          YakhontManager.Missile4.isReady := False;
          YakhontManager.Missile4.state   := YakhontManager.Missile4.C_passed;
        end;
      end;
   end;




   if checkRelease = True then
   begin
     YakhontManager.NetComm.sendDataEx(REC_DATA_Yakhont, @rec_dataEmergencyYakhont);
   end;

   if EmergencyLaunched_1 and EmergencyLaunched_2 and EmergencyLaunched_3 and EmergencyLaunched_4 = True then
   begin

     with fmMainMM do
     begin
//       isTI   := false;
//       isSD   := false;
//       isDES  := false;
//       isPLP  := false;
//       isDOC  := False;
//       isExit := True;

       btnER.Enabled := False;
       btnAWR.Enabled := False;
       btnCWR.Enabled := False;
       btnTI.Enabled := False;
       btnSD.Enabled := False;
       btnDES.Enabled:= False;
       btnPLP.Enabled:= False;
       btnDOC.Enabled:= False;
       btnEXIT.Enabled:= True;
     end;

   end;

   {for I := 1 to 4 do
   begin
     if fmMainMM.readyToLaunch[I] = 0 then
        qCancel     := qCancel + 1;

     if fmMainMM.readyToLaunch[I] = 1 then
        qOprational := qOprational + 1;

     if fmMainMM.readyToLaunch[I] = 2 then
        qLaunched   := qLaunched + 1;

     if fmMainMM.readyToLaunch[I] = 3 then
        qPassed     := qPassed + 1;
   end;

   fmMainMM.countAvailable         := qCancel + qOprational;
   fmMainMM.countCancelled         := qCancel;
   fmMainMM.countOprational        := qOprational;
   fmMainMM.countLaunched          := qLaunched;
   fmMainMM.countPassed            := qPassed;

   fmMainMM.pnlAvailable.Caption   := IntToStr(fmMainMM.countAvailable);
   fmMainMM.pnlCancelled.Caption   := IntToStr(fmMainMM.countCancelled);
   fmMainMM.pnlOperational.Caption := IntToStr(fmMainMM.countOprational);
   fmMainMM.pnlLaunched.Caption    := IntToStr(fmMainMM.countLaunched);
   fmMainMM.pnlPassed.Caption      := IntToStr(fmMainMM.countPassed);
   }
end;

end.
