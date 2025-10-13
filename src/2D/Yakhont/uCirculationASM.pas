unit uCirculationASM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TfrmCirculationASM = class(TForm)
    pnlCirculationASM: TPanel;
    pnlMain: TPanel;
    btnExit: TSpeedButton;
    grpMissile2: TGroupBox;
    grpMissile1: TGroupBox;
    grpMissile3: TGroupBox;
    grpMissile4: TGroupBox;
    pnlMissile2: TPanel;
    pnlMissile4: TPanel;
    pnlMissile1: TPanel;
    pnlMissile3: TPanel;
    lblASM: TLabel;
    colorMissile1: TPanel;
    colorMissile2: TPanel;
    colorMissile4: TPanel;
    colorMissile3: TPanel;
    lbl2: TLabel;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl3: TLabel;
    Panel1: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure pnlMissile1Click(Sender: TObject);
    procedure pnlMissile2Click(Sender: TObject);
    procedure pnlMissile3Click(Sender: TObject);
    procedure pnlMissile4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  var
     checkCirculationASM_1, checkCirculationASM_2, checkCirculationASM_3, checkCirculationASM_4,
     checkCirculationReady1, checkCirculationReady2, checkCirculationReady3, checkCirculationReady4,
     checkCancelAll1, checkCancelAll2, checkCancelAll3, checkCancelAll4,
     check_AWR, check_CWR,
     check_AWR1, check_AWR2, check_AWR3, check_AWR4,
     check_CWR1, check_CWR2, check_CWR3, check_CWR4 : Boolean;

    procedure missile_ready_to_On;
  end;

var
  frmCirculationASM: TfrmCirculationASM;


implementation

uses
  uMainMM, uYakhontManager, uAppointmentASM;

{$R *.dfm}

procedure TfrmCirculationASM.pnlMissile1Click(Sender: TObject);

begin
   if (Sender = pnlMissile1) or (Sender = colorMissile1) or (Sender =  grpMissile1) then
   begin
    if (checkCirculationASM_1 = true) and (checkCancelAll1 = False) then
      begin
        if (colorMissile1.Color = clCream) then
        begin
          colorMissile1.Color := clRed;
          YakhontManager.Missile1.isReady := False;
        end
        else if (colorMissile1.Color = clRed) then
        begin
          colorMissile1.Color := clCream;
          YakhontManager.Missile1.isReady := True;
        end;
        checkCirculationReady1 := True;
      end;

   end;
end;

procedure TfrmCirculationASM.pnlMissile2Click(Sender: TObject);
begin
   if (Sender = pnlMissile2) or (Sender = colorMissile2) or (Sender = grpMissile2) then
   begin
     if (checkCirculationASM_2 = True) and (checkCancelAll2 = False) then
     begin
       if colorMissile2.Color = clCream then
       begin
          colorMissile2.Color := clRed;
          YakhontManager.Missile2.isReady := False;
       end
       else if colorMissile2.Color = clRed then
       begin
          colorMissile2.Color := clCream;
          YakhontManager.Missile2.isReady := True;
       end;
       checkCirculationReady2 := True;
     end;

   end;
end;

procedure TfrmCirculationASM.pnlMissile3Click(Sender: TObject);
begin
   if (Sender = pnlMissile3) or (Sender = colorMissile3) or (Sender = grpMissile3) then
   begin
     if (checkCirculationASM_3 = True) and (checkCancelAll3 = False) then
     begin
       if colorMissile3.Color = clCream then
       begin
          colorMissile3.Color := clRed;
          YakhontManager.Missile3.isReady := False;
       end
       else if colorMissile3.Color = clRed then
       begin
          colorMissile3.Color := clCream;
          YakhontManager.Missile3.isReady := True;
       end;
       checkCirculationReady3 := True;
     end;

   end;
end;

procedure TfrmCirculationASM.pnlMissile4Click(Sender: TObject);
begin
   if (Sender = pnlMissile4) or (Sender = colorMissile4) or (Sender = grpMissile4) then
   begin
     if (checkCirculationASM_4 = True) and (checkCancelAll4 = False) then
     begin
       if colorMissile4.Color = clCream then
       begin
          colorMissile4.Color := clRed;
          YakhontManager.Missile4.isReady := False;
       end
       else if colorMissile4.Color = clRed then
       begin
          colorMissile4.Color := clCream;
          YakhontManager.Missile4.isReady := True;
       end;
       checkCirculationReady4 := True;
     end;
   end;

end;

procedure TfrmCirculationASM.btnExitClick(Sender: TObject);
begin
   missile_ready_to_On;
   if fmMainMM.fCancel = fmMainMM.C_AWR then
   begin
     check_AWR := True;
   end
   else
   if fmMainMM.fCancel = fmMainMM.C_CWR then
   begin
     check_CWR := True;
   end;
   Close;
end;

procedure TfrmCirculationASM.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     missile_ready_to_On;
     Close;
  end;
end;

procedure TfrmCirculationASM.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 195;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 195;
end;

procedure TfrmCirculationASM.missile_ready_to_On;
var
   I : Integer;
   qCancel, qOprational, qLaunched, qPassed : Integer;
begin
   qCancel     := 0;
   qOprational := 0;
   qLaunched   := 0;
   qPassed     := 0;

   { missile 1 }
   if YakhontManager.Missile1.isReady then
   begin
      if YakhontManager.Missile1.state = YakhontManager.Missile1.C_canceled then
      begin
        with fmMainMM do
        begin
          readyToLaunch[1] := 1;
          pnlPLP1.Color := clLime;

          pnlNoASM1.Caption := '1';
          pnlT1.Caption     := FloatToStr(value_T1);
          pnlTmax1.Caption  := FloatToStr(value_TMax);
          pnltmaxs1.Caption := FloatToStr(value_TmaxS);

        end;
        frmAppointmentASM.colorMissile1.Color := clCream;
        YakhontManager.Missile1.isReady := True;
        YakhontManager.Missile1.state   := YakhontManager.Missile1.C_noState;
        checkCancelAll1 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile1.state = YakhontManager.Missile1.C_noState then
      begin
        if checkCirculationReady1 = true then
        begin
          with fmMainMM do
          begin
            readyToLaunch[1] := 0;
            pnlPLP1.Color := clRed;

            pnlNoASM1.Caption := '';
            pnlT1.Caption     := '';
            pnlTmax1.Caption  := '';
            pnltmaxs1.Caption := '';
          end;
          frmAppointmentASM.colorMissile1.Color := clRed;
          YakhontManager.Missile1.isReady := False;
          YakhontManager.Missile1.state   := YakhontManager.Missile1.C_canceled;
          checkCancelAll1:=True;
        end;

      end;
   end;

   { missile 2 }
   if YakhontManager.Missile2.isReady then
   begin
      if YakhontManager.Missile2.state = YakhontManager.Missile2.C_canceled then
      begin
        with fmMainMM do
        begin
          readyToLaunch[2] := 1;
          pnlPLP2.Color := clLime;

          pnlNoASM2.Caption := '2';
          pnlT2.Caption     := FloatToStr(value_T2);
          pnlTmax2.Caption  := FloatToStr(value_TMax);
          pnltmaxs2.Caption := FloatToStr(value_TmaxS);

        end;
        frmAppointmentASM.colorMissile2.Color := clCream;
        YakhontManager.Missile2.isReady := True;
        YakhontManager.Missile2.state   := YakhontManager.Missile2.C_noState;
        checkCancelAll2 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile2.state = YakhontManager.Missile2.C_noState then
      begin
        if checkCirculationReady2 = true then
        begin
          with fmMainMM do
          begin
            readyToLaunch[2] := 0;
            pnlPLP2.Color := clRed;

            pnlNoASM2.Caption := '';
            pnlT2.Caption     := '';
            pnlTmax2.Caption  := '';
            pnltmaxs2.Caption := '';
          end;
          frmAppointmentASM.colorMissile2.Color := clRed;
          YakhontManager.Missile2.isReady := False;
          YakhontManager.Missile2.state   := YakhontManager.Missile2.C_canceled;
          checkCancelAll2:=True;
        end;

      end;
   end;

   { missile 3 }
   if YakhontManager.Missile3.isReady then
   begin
      if YakhontManager.Missile3.state = YakhontManager.Missile3.C_canceled then
      begin
        with fmMainMM do
        begin
          readyToLaunch[3] := 1;
          pnlPLP3.Color := clLime;

          pnlNoASM3.Caption := '3';
          pnlT3.Caption     := FloatToStr(value_T3);
          pnlTmax3.Caption  := FloatToStr(value_TMax);
          pnltmaxs3.Caption := FloatToStr(value_TmaxS);
        end;
        frmAppointmentASM.colorMissile3.Color := clCream;
        YakhontManager.Missile3.isReady := true;
        YakhontManager.Missile3.state   := YakhontManager.Missile3.C_noState;
        checkCancelAll3 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile3.state = YakhontManager.Missile3.C_noState then
      begin
        if checkCirculationReady3 = True then
        begin
          with fmMainMM do
          begin
            readyToLaunch[3] := 0;
            pnlPLP3.Color    := clRed;

            pnlNoASM3.Caption := '';
            pnlT3.Caption     := '';
            pnlTmax3.Caption  := '';
            pnltmaxs3.Caption := '';
          end;
          frmAppointmentASM.colorMissile3.Color := clRed;
          YakhontManager.Missile3.isReady := False;
          YakhontManager.Missile3.state   := YakhontManager.Missile3.C_canceled;
          checkCancelAll3:=True;
        end;
      end;
   end;

   { missile 4 }
   if YakhontManager.Missile4.isReady then
   begin
      if YakhontManager.Missile4.state = YakhontManager.Missile4.C_canceled then
      begin
        with fmMainMM do
        begin
          readyToLaunch[4] := 1;
          pnlPLP4.Color := clLime;

          pnlNoASM4.Caption := '4';
          pnlT4.Caption     := FloatToStr(value_T4);
          pnlTmax4.Caption  := FloatToStr(value_TMax);
          pnltmaxs4.Caption := FloatToStr(value_TmaxS);
        end;
        frmAppointmentASM.colorMissile4.Color := clCream;
        YakhontManager.Missile4.isReady := true;
        YakhontManager.Missile4.state   := YakhontManager.Missile4.C_noState;
        checkCancelAll4 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile4.state = YakhontManager.Missile4.C_noState then
      begin
        if checkCirculationReady4 = True then
        begin
          with fmMainMM do
          begin
            readyToLaunch[4] := 0;
            pnlPLP4.Color := clRed;

            pnlNoASM4.Caption := '';
            pnlT4.Caption     := '';
            pnlTmax4.Caption  := '';
            pnltmaxs4.Caption := '';
          end;
          frmAppointmentASM.colorMissile4.Color := clRed;
          YakhontManager.Missile4.isReady := False;
          YakhontManager.Missile4.state   := YakhontManager.Missile4.C_canceled;
          checkCancelAll4:=True;
        end;

      end;
   end;

   for I := 1 to 4 do
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
end;

end.
