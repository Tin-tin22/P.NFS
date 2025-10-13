unit uAppointmentASM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmAppointmentASM = class(TForm)
    pnlCirculationASM: TPanel;
    lblASM: TLabel;
    pnlMain: TPanel;
    btnExit: TSpeedButton;
    grpMissile2: TGroupBox;
    pnlMissile2: TPanel;
    lbl2: TLabel;
    colorMissile2: TPanel;
    grpMissile3: TGroupBox;
    pnlMissile3: TPanel;
    lbl3: TLabel;
    colorMissile3: TPanel;
    grpMissile4: TGroupBox;
    pnlMissile4: TPanel;
    lbl4: TLabel;
    colorMissile4: TPanel;
    grpMissile1: TGroupBox;
    pnlMissile1: TPanel;
    lbl1: TLabel;
    colorMissile1: TPanel;
    Panel1: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure pnlMissile1Click(Sender: TObject);
    procedure pnlMissile2Click(Sender: TObject);
    procedure pnlMissile3Click(Sender: TObject);
    procedure pnlMissile4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
      checkAppointmentASM_1, checkAppointmentASM_2, checkAppointmentASM_3, checkAppointmentASM_4, checkAppointmentASMReady : Boolean;
    procedure missile_ready_to_On;
  end;

var
  frmAppointmentASM: TfrmAppointmentASM;


implementation

uses
  uMainMM, uYakhontManager, uCirculationASM;

{$R *.dfm}

procedure TfrmAppointmentASM.btnExitClick(Sender: TObject);
begin
  missile_ready_to_On;
  Close;
end;

procedure TfrmAppointmentASM.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     missile_ready_to_On;
     Close;
  end;
end;

procedure TfrmAppointmentASM.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 195;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 195;
end;

procedure TfrmAppointmentASM.pnlMissile1Click(Sender: TObject);
begin
   if (Sender = pnlMissile1) or (Sender = colorMissile1) or (Sender =  grpMissile1) then
   begin
     if (checkAppointmentASM_1 = true) and (frmCirculationASM.checkCancelAll1 = True) then
     begin
        if colorMissile1.Color = clCream then
        begin
          colorMissile1.Color := clRed;
          YakhontManager.Missile1.isReady := False;
        end
        else if colorMissile1.Color = clRed then
        begin
          colorMissile1.Color := clCream;
          YakhontManager.Missile1.isReady := True;
        end;
        checkAppointmentASMReady := True;
     end;

   end;
end;

procedure TfrmAppointmentASM.pnlMissile2Click(Sender: TObject);
begin
   if (Sender = pnlMissile2) or (Sender = colorMissile2) or (Sender = grpMissile2) then
   begin
     if (checkAppointmentASM_2 = True) and (frmCirculationASM.checkCancelAll2 = True) then
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
       checkAppointmentASMReady := True;
     end;

   end;
end;

procedure TfrmAppointmentASM.pnlMissile3Click(Sender: TObject);
begin
   if (Sender = pnlMissile3) or (Sender = colorMissile3) or (Sender = grpMissile3) then
   begin
     if (checkAppointmentASM_3 = True) and (frmCirculationASM.checkCancelAll3 = True) then
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
       checkAppointmentASMReady := True;
     end;

   end;
end;

procedure TfrmAppointmentASM.pnlMissile4Click(Sender: TObject);
begin
   if (Sender = pnlMissile4) or (Sender = colorMissile4) or (Sender = grpMissile4) then
   begin
     if (checkAppointmentASM_4 = True) and (frmCirculationASM.checkCancelAll4 = True) then
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
       checkAppointmentASMReady := True;
     end;

   end;
end;

procedure TfrmAppointmentASM.missile_ready_to_On;
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
        frmCirculationASM.colorMissile1.Color := clCream;
        YakhontManager.Missile1.isReady := True;
        YakhontManager.Missile1.state   := YakhontManager.Missile1.C_noState;
        frmCirculationASM.checkCancelAll1 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile1.state = YakhontManager.Missile1.C_noState then
      begin
        if checkAppointmentASMReady = True then
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
          frmCirculationASM.colorMissile1.Color := clRed;
          YakhontManager.Missile1.isReady := False;
          YakhontManager.Missile1.state   := YakhontManager.Missile1.C_canceled;
          frmCirculationASM.checkCancelAll1 := True;
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
        frmCirculationASM.colorMissile2.Color := clCream;
        YakhontManager.Missile2.isReady := true;
        YakhontManager.Missile2.state   := YakhontManager.Missile2.C_noState;
        frmCirculationASM.checkCancelAll2 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile2.state = YakhontManager.Missile2.C_noState then
      begin
        if checkAppointmentASMReady = True then
        begin
          with fmMainMM do
          begin
            readyToLaunch[2] := 0;
            pnlPLP2.Color    := clRed;

            pnlNoASM2.Caption := '';
            pnlT2.Caption     := '';
            pnlTmax2.Caption  := '';
            pnltmaxs2.Caption := '';
          end;
          frmCirculationASM.colorMissile2.Color := clRed;
          YakhontManager.Missile2.isReady := False;
          YakhontManager.Missile2.state   := YakhontManager.Missile2.C_canceled;
          frmCirculationASM.checkCancelAll2 := True;
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
        frmCirculationASM.colorMissile3.Color := clCream;
        YakhontManager.Missile3.isReady := true;
        YakhontManager.Missile3.state   := YakhontManager.Missile3.C_noState;
        frmCirculationASM.checkCancelAll3 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile3.state = YakhontManager.Missile3.C_noState then
      begin
        if checkAppointmentASMReady = True then
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
          frmCirculationASM.colorMissile3.Color := clRed;
          YakhontManager.Missile3.isReady := False;
          YakhontManager.Missile3.state   := YakhontManager.Missile3.C_canceled;
          frmCirculationASM.checkCancelAll3 := True;
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
        frmCirculationASM.colorMissile4.Color := clCream;
        YakhontManager.Missile4.isReady := true;
        YakhontManager.Missile4.state   := YakhontManager.Missile4.C_noState;
        frmCirculationASM.checkCancelAll4 := False;
      end;
   end
   else
   begin
      if YakhontManager.Missile4.state = YakhontManager.Missile4.C_noState then
      begin
        if checkAppointmentASMReady = true then
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
          frmCirculationASM.colorMissile4.Color := clRed;
          YakhontManager.Missile4.isReady := False;
          YakhontManager.Missile4.state   := YakhontManager.Missile4.C_canceled;
          frmCirculationASM.checkCancelAll4 := True;
        end;

      end;
   end;

//   for I := 1 to 4 do
//   begin
//     if fmMainMM.readyToLaunch[I] = 0 then
//        qcancel := qcancel + 1;
//
//     if fmMainMM.readyToLaunch[I] = 1 then
//        qOprational := qOprational + 1;
//   end;

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
