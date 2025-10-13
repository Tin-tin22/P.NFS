unit uTargetDestination;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Buttons, uYakhontManager;

type
  TfrmTargetDest = class(TForm)
    pnlTargetDest_Outer: TPanel;
    pnlTargetDist_Inner: TPanel;
    Label1: TLabel;
    pnlValue: TPanel;
    grpValue: TGroupBox;
    sgValue: TStringGrid;
    pnlEnter: TPanel;
    Label2: TLabel;
    btnP: TSpeedButton;
    btnQASM: TSpeedButton;
    pnlApproval: TPanel;
    btnMax: TSpeedButton;
    Label3: TLabel;
    btnMIP: TSpeedButton;
    btnMIQ: TSpeedButton;
    btnExit: TSpeedButton;
    lblErrorP: TLabel;
    lblErrorQASM: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure sgValueDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure sgValueSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure sgValueSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnPClick(Sender: TObject);
    procedure btnQASMClick(Sender: TObject);
    procedure btnMaxClick(Sender: TObject);
    procedure btnMIPClick(Sender: TObject);
    procedure btnMIQClick(Sender: TObject);
    procedure setMissileASM(Q_ASM: string);
  private
    { Private declarations }
    isTargetDestMax, isTargetDestMIP, isTargetDestMIQ : Boolean;
    P, Q_ASM : string;

    procedure AutoSizeCol(Grid: TStringGrid; Column: integer);
    procedure setStringGrid;

  public
    { Public declarations }
  end;

var
  frmTargetDest: TfrmTargetDest;

implementation

uses
  uMainMM, uAppointmentASM, uCirculationASM;

{$R *.dfm}

procedure TfrmTargetDest.btnExitClick(Sender: TObject);
begin
   with fmMainMM do
   begin
     btnDES.Enabled    := false;
     btnPLP.Font.Color := clBlack;
     fMap.Repaint;
   end;

   Close;
end;

procedure TfrmTargetDest.btnMaxClick(Sender: TObject);
begin
//  sgValue.Cells[1,3] := '4';
//  sgValue.Cells[2,3] := '100';
  isTargetDestMax := True;
  isTargetDestMIP := False;
  isTargetDestMIQ := False;

  btnMax.Enabled := False;
  btnMIP.Enabled := False;
  btnMIQ.Enabled := False;
end;

procedure TfrmTargetDest.btnMIPClick(Sender: TObject);
begin
  if (P = '70') or (sgValue.Cells[1,3] = '70') then
    sgValue.Cells[2,3] := '1'
  else if (P = '80') or (sgValue.Cells[1,3] = '80') then
    sgValue.Cells[2,3] := '2'
  else if (P = '90') or (sgValue.Cells[1,3] = '90') then
    sgValue.Cells[2,3] := '3'
  else if (P = '95') or (sgValue.Cells[1,3] = '95') then
    sgValue.Cells[2,3] := '4'
  else
    sgValue.Cells[2,3] := '0';

  isTargetDestMax := False;
  isTargetDestMIP := True;
  isTargetDestMIQ := False;

  btnMax.Enabled := False;
  btnMIP.Enabled := False;
  btnMIQ.Enabled := False;

  setMissileASM(sgValue.Cells[2,3]);
end;

procedure TfrmTargetDest.btnMIQClick(Sender: TObject);
begin
  if (Q_ASM = '1') or (sgValue.Cells[2,3] = '1') then
    sgValue.Cells[1,3] := '70'
  else if (Q_ASM = '2') or (sgValue.Cells[2,3] = '2') then
    sgValue.Cells[1,3] := '80'
  else if (Q_ASM = '3') or (sgValue.Cells[2,3] = '3') then
    sgValue.Cells[1,3] := '90'
  else if (Q_ASM = '4') or (sgValue.Cells[2,3] = '4') then
    sgValue.Cells[1,3] := '95'
  else
    sgValue.Cells[1,3] := '0';

  isTargetDestMax := False;
  isTargetDestMIP := False;
  isTargetDestMIQ := True;

  btnMax.Enabled := False;
  btnMIP.Enabled := False;
  btnMIQ.Enabled := False;

  setMissileASM(sgValue.Cells[2,3]);
end;

procedure TfrmTargetDest.btnPClick(Sender: TObject);
begin
  if (P = '70') or (sgValue.Cells[1,3] = '70') then
  begin
    sgValue.Cells[2,3] := '1';
    lblErrorP.Caption := '';
  end
  else if (P = '80') or (sgValue.Cells[1,3] = '80') then
  begin
    sgValue.Cells[2,3] := '2';
    lblErrorP.Caption := '';
  end
  else if (P = '90') or (sgValue.Cells[1,3] = '90') then
  begin
    sgValue.Cells[2,3] := '3';
    lblErrorP.Caption := '';
  end
  else if (P = '95') or (sgValue.Cells[1,3] = '95') then
  begin
    sgValue.Cells[2,3] := '4';
    lblErrorP.Caption := '';
  end
  else
    sgValue.Cells[2,3] := '4';
end;

procedure TfrmTargetDest.btnQASMClick(Sender: TObject);
begin
  if (Q_ASM = '1') or (sgValue.Cells[2,3] = '1') then
  begin
    sgValue.Cells[1,3] := '70';
    lblErrorQASM.Caption := '';
  end
  else if (Q_ASM = '2') or (sgValue.Cells[2,3] = '2') then
  begin
    sgValue.Cells[1,3] := '80';
    lblErrorQASM.Caption := '';
  end
  else if (Q_ASM = '3') or (sgValue.Cells[2,3] = '3') then
  begin
    sgValue.Cells[1,3] := '90';
    lblErrorQASM.Caption := '';
  end
  else if (Q_ASM = '4') or (sgValue.Cells[2,3] = '4') then
  begin
    sgValue.Cells[1,3] := '95';
    lblErrorQASM.Caption := '';
  end
  else
    sgValue.Cells[1,3] := '95'
end;

procedure TfrmTargetDest.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if GetKeyState(VK_F8) < 0 then
  begin
     with fmMainMM do
     begin
       btnDES.Enabled := false;
       btnPLP.Font.Color := clBlack;
//       fMap.Repaint;
     end;

     Close;
  end;
end;

procedure TfrmTargetDest.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 110;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 45;

   setStringGrid;

   sgValue.Repaint;

   btnMax.Enabled := True;
   btnMIP.Enabled := True;
   btnMIQ.Enabled := True;
end;

procedure TfrmTargetDest.setMissileASM(Q_ASM: string);
var
  I : Integer;
  qCancel, qOprational, qLaunched, qPassed : Integer;
begin
  if (fmMainMM.readyToLaunch[1] = 1) and (fmMainMM.readyToLaunch[2] = 1) and
    (fmMainMM.readyToLaunch[3] = 1) and (fmMainMM.readyToLaunch[4] = 1) then
  begin
    qCancel     := 0;
    qOprational := 0;
    qLaunched   := 0;
    qPassed     := 0;
  //  if Q_ASM = '1' then
  //  begin
  //    with fmMainMM do
  //    begin
  //      readyToLaunch[1] := 0;
  //      pnlPLP1.Color := clRed;
  //
  //      pnlNoASM1.Caption := '';
  //      pnlT1.Caption     := '';
  //      pnlTmax1.Caption  := '';
  //      pnltmaxs1.Caption := '';
  //    end;
  //    frmAppointmentASM.colorMissile1.Color := clRed;
  //    YakhontManager.Missile1.isReady := False;
  //    YakhontManager.Missile1.state   := YakhontManager.Missile1.C_canceled;
  //    frmCirculationASM.checkCancelAll1:=True;
  //  end
    if Q_ASM = '1' then
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
      frmCirculationASM.checkCancelAll2:=True;

      with fmMainMM do
      begin
        readyToLaunch[3] := 0;
        pnlPLP3.Color := clRed;

        pnlNoASM3.Caption := '';
        pnlT3.Caption     := '';
        pnlTmax3.Caption  := '';
        pnltmaxs3.Caption := '';
      end;
      frmAppointmentASM.colorMissile3.Color := clRed;
      YakhontManager.Missile3.isReady := False;
      YakhontManager.Missile3.state   := YakhontManager.Missile3.C_canceled;
      frmCirculationASM.checkCancelAll3:=True;

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
      frmCirculationASM.checkCancelAll4:=True;
    end
    else if Q_ASM = '2' then
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
      frmCirculationASM.checkCancelAll2:=True;

      with fmMainMM do
      begin
        readyToLaunch[3] := 0;
        pnlPLP3.Color := clRed;

        pnlNoASM3.Caption := '';
        pnlT3.Caption     := '';
        pnlTmax3.Caption  := '';
        pnltmaxs3.Caption := '';
      end;
      frmAppointmentASM.colorMissile3.Color := clRed;
      YakhontManager.Missile3.isReady := False;
      YakhontManager.Missile3.state   := YakhontManager.Missile3.C_canceled;
      frmCirculationASM.checkCancelAll3:=True;
    end
    else if Q_ASM = '3' then
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
      frmCirculationASM.checkCancelAll4:=True;
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
end;

procedure TfrmTargetDest.setStringGrid;
var
   I : Integer;
begin
   sgValue.Cells[0,1] := 'MAX';
   sgValue.Cells[0,3] := 'MI - Q ASM';

   sgValue.Cells[1,0] := 'P';
   sgValue.Cells[2,0] := 'Q ASM';

   sgValue.Cells[1,2] := 'Ship List Empty';

   sgValue.Cells[1,1] := '100';
//   sgValue.Cells[1,3] := '0.0';

   sgValue.Cells[2,1] := '4';
//   sgValue.Cells[2,3] := '0';

   for i := 0 to sgValue.ColCount - 1 do
   begin
      AutoSizeCol(sgValue, 0);
      AutoSizeCol(sgValue, 1);
      AutoSizeCol(sgValue, 2);
   end;
end;

procedure TfrmTargetDest.sgValueDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if (((ACol = 0) and (ARow = 2))) then
   begin
     sgValue.Canvas.Brush.Color := RGB(255, 255, 0);
     sgValue.Canvas.FillRect(Rect);
     sgValue.Canvas.TextRect(Rect, Rect.Left, Rect.Top, sgValue.Cells[ACol, ARow]);
     sgValue.Canvas.DrawFocusRect(Rect);
   end;

   if (((ACol = 1) and (ARow = 2))) then
   begin
     sgValue.Canvas.Brush.Color := RGB(255, 255, 0);
     sgValue.Canvas.FillRect(Rect);
     sgValue.Canvas.TextRect(Rect, Rect.Left, Rect.Top, sgValue.Cells[ACol, ARow]);
     sgValue.Canvas.DrawFocusRect(Rect);
   end;

   if (((ACol = 2) and (ARow = 2))) then
   begin
     sgValue.Canvas.Brush.Color := RGB(255, 255, 0);
     sgValue.Canvas.FillRect(Rect);
     sgValue.Canvas.TextRect(Rect, Rect.Left, Rect.Top, sgValue.Cells[ACol, ARow]);
     sgValue.Canvas.DrawFocusRect(Rect);
   end;
end;

procedure TfrmTargetDest.sgValueSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  i : Integer;
begin
//  if ARow IN [2,3] then
//  begin
//    if goEditing IN sgValue.Options then
//      sgValue.Options := sgValue.Options-[goEditing];
//  end
//  else
  if (ARow = 3) and ((ACol = 1) or (ACol = 2)) then
  begin
    if NOT (goEditing IN sgValue.Options) then
      sgValue.Options := sgValue.Options+[goEditing];
  end
  else
  begin
    if goEditing IN sgValue.Options then
      sgValue.Options := sgValue.Options-[goEditing];
  end;

end;

procedure TfrmTargetDest.sgValueSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if ARow = 3 then
  begin
    if ACol = 1 then
    begin
      P := Value;
//      if P = '70' then
//        sgValue.Cells[2,3] := '1'
//      else if P = '80' then
//        sgValue.Cells[2,3] := '2'
//      else if P = '90' then
//        sgValue.Cells[2,3] := '3'
//      else if P = '95' then
//        sgValue.Cells[2,3] := '4'
//      else
//        sgValue.Cells[2,3] := '0'
    end
    else if ACol = 2 then
    begin
      Q_ASM := Value;
//      if Q_ASM = '1' then
//        sgValue.Cells[1,3] := '70'
//      else if Q_ASM = '2' then
//        sgValue.Cells[1,3] := '80'
//      else if Q_ASM = '3' then
//        sgValue.Cells[1,3] := '90'
//      else if Q_ASM = '4' then
//        sgValue.Cells[1,3] := '95'
//      else
//        sgValue.Cells[1,3] := '0';
    end;

  end;
end;

procedure TfrmTargetDest.AutoSizeCol(Grid: TStringGrid; Column: integer);
var
  i, W, WMax: integer;
begin
  WMax := 0;
  for i := 0 to (Grid.RowCount - 1) do begin
    W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
    if W > WMax then
      WMax := W;
  end;
  Grid.ColWidths[Column] := WMax + 50;
end;

end.
