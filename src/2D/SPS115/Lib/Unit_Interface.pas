unit Unit_Interface;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Buttons, StdCtrls, ComCtrls, ToolWin, ExtCtrls, VrControls,
  VrButtons, VrDesign, jpeg, Dialogs,
  Unit_dataObject;

type
  Tdirection = (mUp,mDown,mLeft,mRight);

  TState = class
  private
    Fphase : Tphase;
    Btn1,Btn2,Btn3,Btn4,Btn5,Btn6: Tbutton;

  public
    Clr : TColor;
    constructor Create;
    destructor Destroy; override;

    procedure SetButton(Bt1,Bt2,Bt3,Bt4,Bt5,Bt6: TButton);
    procedure SetState(fase: Tphase);
  end;

  procedure Set_TgtSelected(edt1,edt2,edt3,edt4,edt5:TEdit; selected: boolean);
  procedure NavDataTgt(move:Tdirection; var i,j:Integer);
  procedure Load_ImgButton(btn:TVrbitmapbutton; img:string);


implementation

constructor TState.Create;
begin
  Fphase :=fDefault;
  Clr:= RGB(193,228,248);
end;

destructor TState.Destroy;
begin
  inherited;
end;

procedure TState.SetButton(Bt1,Bt2,Bt3,Bt4,Bt5,Bt6: TButton);
begin
  Btn1:=Bt1;
  Btn2:=Bt2;
  Btn3:=Bt3;
  Btn4:=Bt4;
  Btn5:=Bt5;
  Btn6:=Bt6;
end;

procedure TState.SetState(fase: Tphase);
begin
  case fase of
    fDefault: begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='BITE';
       Btn2.Caption:='SELECT TGT';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='START GYRO';
       Btn5.Caption:='SELECT n';
       Btn6.Caption:='STANDBY';
    end;

    fBite: begin
       Btn1.Caption:='EXIT';
       Btn2.Caption:='TIU BITE';
       Btn3.Caption:='LCP BITE';
       Btn4.Caption:='SW ID';
       Btn5.Caption:='SMEP DISP';
       Btn6.Caption:='COUNTER';
    end;

    fGyroStarted: begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='SELECT TGT';
       Btn2.Caption:='BITE';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='STOP GYRO';
       Btn5.Caption:='SELECT n';
       Btn6.Caption:='STANDBY';
    end;

    fGyroOff:begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='BITE';
       Btn2.Caption:='SELECT TGT';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='START GYRO';
       Btn5.Caption:='SELECT n';
       Btn6.Caption:='STANDBY';
    end;

    fBarrelDeselected:begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='SELECT TGT';
       Btn2.Caption:='BITE';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='STOP GYRO';
       Btn5.Caption:='SELECT n';
       Btn6.Caption:='STANDBY';
    end;

    fBarrelSelected: begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='BITE';
       Btn2.Caption:='BITE';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='STOP GYRO';
       Btn5.Caption:='DESELECT n';
       Btn6.Caption:='STANDBY';
    end;

    fPreStandBy:begin
       Btn1.Caption:='MODE';
       //Btn2.Caption:='BITE';
       Btn2.Caption:='SELECT TGT';
       Btn3.Caption:='TORP TYPE';
       Btn4.Caption:='START GYRO';
       Btn5.Caption:='SELECT n';
       Btn6.Caption:='STANDBY';
    end;
  end;
end;

procedure Set_TgtSelected(edt1,edt2,edt3,edt4,edt5:TEdit; selected: boolean);
begin
  if selected then begin
    edt1.Color := clRed;
    edt2.Color := clRed;
    edt3.Color := clRed;
    edt4.Color := clRed;
    edt5.Color := clRed;
  end
  else begin
    edt1.Color := clHighlightText;
    edt2.Color := clHighlightText;
    edt3.Color := clHighlightText;
    edt4.Color := clHighlightText;
    edt5.Color := clHighlightText;

    {edt1.Text := '0';
    edt2.Text := '0';
    edt3.Text := '0';
    edt4.Text := '0';
    edt5.Text := '0';}
  end;

end;

procedure NavDataTgt(move:Tdirection; var i,j:Integer);
var
  isChangeColor : Boolean;
begin
  isChangeColor := true;

  case move  of
    mUp: begin
      if j = 1 then
        exit
      else                   //4,5 nil
        j:=j-1;
    end;

    mDown: begin
      if j = 5 then
        exit
      else
      if (i=4) and (j=4) then
        Exit
      else
        j:=j+1;
    end;

    mLeft: begin
      if i=1 then
        exit
      else
      if (i=5) and (j=5) then
        i:=3
      else
      i:=i-1;
    end;

    mRight: begin
      if i=6 then
        exit
      else
      if (i=3) and (j=5)  then
        i:=5
      else
      i:=i+1;
    end;
  end;

  //Cendol Bby Nando
//  if EdtTgtData[i, j] is TEdit then
//  begin
//    if TEdit(EdtTgtData[i,j]).Color = clRed then
//    begin
//      isChangeColor := False;
//    end;
//  end;

  EdtTgtData[i,j].SetFocus;

  //Cendol Bby Nando
//  if not isChangeColor then
//  begin
//    if EdtTgtData[i, j] is TEdit then
//    begin
//      TEdit(EdtTgtData[i,j]).Color := clRed;
//    end;
//  end;

end;

procedure Load_ImgButton(btn:TVrbitmapbutton; img:string);
var s: string;
begin
  s:= '..\data\images\SPS115\';
  if DirectoryExists(s) then
    btn.glyph.LoadFromFile(s + img + '.bmp')
  else
    ShowMessage('"ERROR :: '+s+', not exist !!!"');
end;

end.
