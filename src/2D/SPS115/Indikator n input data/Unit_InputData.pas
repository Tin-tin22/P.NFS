unit Unit_InputData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Unit_dataObject, CheckLst;

type
  TFrm_InputData = class(TForm)
    grp1: TGroupBox;
    edt_Speed: TEdit;
    edt_Heading: TEdit;
    lbl12: TLabel;
    lbl11: TLabel;
    lbl10: TLabel;
    pnl30: TPanel;
    btn_Set: TButton;
    grp2: TGroupBox;
    pnl1: TPanel;
    btnSetBarrel: TButton;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cbb1: TComboBox;
    cbb2: TComboBox;
    cbb3: TComboBox;
    cbb4: TComboBox;
    cbb5: TComboBox;
    cbb6: TComboBox;
    grp3: TGroupBox;
    cbb_link: TComboBox;
    pnl2: TPanel;
    btn_link: TButton;
    cbb_Source: TComboBox;
    grp4: TGroupBox;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    pnl3: TPanel;
    btnErrSystem: TButton;
    edtPort45: TEdit;
    edtSTBD45: TEdit;
    edtTmpPort: TEdit;
    edtTmpStbd: TEdit;
    lbl7: TLabel;
    lbl9: TLabel;
    cbbSTBDSet: TComboBox;
    cbbCbbPortSet: TComboBox;
    lbl8: TLabel;
    lbl13: TLabel;
    grp6: TGroupBox;
    pnl5: TPanel;
    btnTpoGyro: TButton;
    grp5: TGroupBox;
    pnl4: TPanel;
    btnBrlSlct: TButton;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    rbN_3: TRadioButton;
    rbN_5: TRadioButton;
    rbN_6: TRadioButton;
    rbN_7: TRadioButton;
    rbN_8: TRadioButton;
    rbNormalBrlSelcted: TRadioButton;
    rb_n10: TRadioButton;
    rb_N6: TRadioButton;
    rb_N5: TRadioButton;
    rb_N4: TRadioButton;
    rb_N2: TRadioButton;
    rb_N1: TRadioButton;
    rb_GyroNormal: TRadioButton;
    rbN_9: TRadioButton;
    procedure btn_SetClick(Sender: TObject);
    procedure btn_linkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnErrSystemClick(Sender: TObject);
    procedure btnTpoGyroClick(Sender: TObject);
    procedure btnBrlSlctClick(Sender: TObject);
    procedure btnSetBarrelClick(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Frm_InputData: TFrm_InputData;


implementation

uses uSPS115;

{$R *.dfm}

procedure TFrm_InputData.btnSetBarrelClick(Sender: TObject);
var
  I: Integer;
  cb : TComboBox;
begin
for I := 0 to 5 do begin
  cb:= ListCbbSetBrl[I];
  StateTorp[I+1] := cb.ItemIndex;
end;

end;

procedure TFrm_InputData.btnBrlSlctClick(Sender: TObject);
var I : Integer;
    rb: TRadioButton;
begin

  for I := 0 to ListErrorSlcBarrel.Count - 2 do begin
     rb:= ListErrorSlcBarrel[I];
     if rb.Checked then begin
       ErrorSlctbarrel.code:=rb.Tag;
       ErrorSlctbarrel.Msg :=rb.Caption;
     end;
  end;

end;

procedure TFrm_InputData.btnErrSystemClick(Sender: TObject);
begin
   ErrorTIU1:='';
   ErrorTIU2:='';

   if cbbCbbPortSet.ItemIndex>0 then
    ErrorTIU1:=cbbCbbPortSet.Text;

   if cbbSTBDSet.ItemIndex>0 then
    ErrorTIU2:=cbbSTBDSet.Text;

   AnglePort:=StrToInt(edtPort45.Text);
   AngleStbd:=StrToInt(edtSTBD45.Text);

   TmpPort:= StrToInt(edtTmpPort.Text);
   TmpStbd:= StrToInt(edtTmpStbd.Text);

end;

procedure TFrm_InputData.btnTpoGyroClick(Sender: TObject);
var I : Integer;
    rb: TRadioButton;
begin

  for I := 0 to ListErrorTorpGyro.Count  - 1 do begin
     rb:= ListErrorTorpGyro[I];
     if rb.Checked then begin
       ErrorTpoGyro.code:=rb.Tag;
       ErrorTpoGyro.Msg :=rb.Caption;
     end;
  end;
end;

procedure TFrm_InputData.btn_linkClick(Sender: TObject);
begin
  Frm_SPS115.pnl_linkStat.Caption :=cbb_link.Text;
     if Frm_SPS115.pnl_linkStat.Caption='INOP' then
    Frm_SPS115.pnl_linkStat.Color:=clRed
  else
    Frm_SPS115.pnl_linkStat.Color:=clLime;
end;

procedure TFrm_InputData.btn_SetClick(Sender: TObject);
begin
  Frm_SPS115.cbb_Source.ItemIndex :=cbb_Source.ItemIndex;
  Frm_SPS115.edt_Heading.Text  :=edt_Heading.Text;
  Frm_SPS115.edt_Speed.Text :=edt_Speed.Text;

end;

procedure TFrm_InputData.FormCreate(Sender: TObject);
begin
  ListErrorTorpGyro := TList.Create;
  ListErrorSlcBarrel:= TList.Create;
  ListCbbSetBrl:= TList.Create;

  ListErrorTorpGyro.Add(rb_GyroNormal);
  ListErrorTorpGyro.Add(rb_N1);
  ListErrorTorpGyro.Add(rb_N2);
  ListErrorTorpGyro.Add(rb_N4);
  ListErrorTorpGyro.Add(rb_N5);
  ListErrorTorpGyro.Add(rb_N6);
  ListErrorTorpGyro.Add(rb_N10);

  ListErrorSlcBarrel.Add(rbNormalBrlSelcted);
  ListErrorSlcBarrel.Add(rbN_3);
  ListErrorSlcBarrel.Add(rbN_5);
  ListErrorSlcBarrel.Add(rbN_6);
  ListErrorSlcBarrel.Add(rbN_7);
  ListErrorSlcBarrel.Add(rbN_8);

  ListCbbSetBrl.Add(cbb1);
  ListCbbSetBrl.Add(cbb2);
  ListCbbSetBrl.Add(cbb3);
  ListCbbSetBrl.Add(cbb4);
  ListCbbSetBrl.Add(cbb5);
  ListCbbSetBrl.Add(cbb6);




end;

procedure TFrm_InputData.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ListErrorTorpGyro);
  FreeAndNil(ListErrorSlcBarrel);
end;

end.
