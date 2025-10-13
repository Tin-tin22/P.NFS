unit ufTDCKiri_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ufQEK,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, StdCtrls, ImgList, uLibTDCClass;

type
  TfrmTDCKiri_Rencong = class(TfrmQEK)
    spbFC_1: TSpeedButtonImage;
    spbBT_FC1: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    spbFC_2: TSpeedButtonImage;
    spbBT_FC2: TSpeedButtonImage;
    spbFC_3: TSpeedButtonImage;
    spbBT_FC3: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    spbAss_SSM: TSpeedButtonImage;
    spbDeAss_SSM: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure spbFC_1Click(Sender: TObject);
    procedure spbBT_FC1Click(Sender: TObject);
    procedure spbFC_2Click(Sender: TObject);
    procedure spbBT_FC2Click(Sender: TObject);
    procedure spbFC_3Click(Sender: TObject);
    procedure spbBT_FC3Click(Sender: TObject);
    procedure spbAss_SSMClick(Sender: TObject);
    procedure spbDeAss_SSMClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

{var
  frmTDC2Kiri_Rencong: TfrmTDC2Kiri_Rencong;
}
implementation

uses
  uTCPDataType;


{$R *.dfm}

procedure TfrmTDCKiri_Rencong.spbFC_1Click(Sender: TObject);
begin  //RATO
  TDCInterface.SetAssign_FC(1,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDCKiri_Rencong.spbBT_FC1Click(Sender: TObject);
begin // bt FC 1
  TDCInterface.SetDeAssign_FC(1);
end;

procedure TfrmTDCKiri_Rencong.spbFC_2Click(Sender: TObject);
begin //RSTO
  TDCInterface.SetAssign_FC(2,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDCKiri_Rencong.spbBT_FC2Click(Sender: TObject);
begin //bt FC2
  TDCInterface.SetDeAssign_FC(2);
end;

procedure TfrmTDCKiri_Rencong.spbFC_3Click(Sender: TObject);
begin //RSTO FC 3
  TDCInterface.SetAssign_FC(3,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDCKiri_Rencong.spbBT_FC3Click(Sender: TObject);
begin //bt FC 3
  TDCInterface.SetDeAssign_FC(3);
end;

procedure TfrmTDCKiri_Rencong.spbAss_SSMClick(Sender: TObject);
var aRec: TRecOrderXY;
begin // ass ssm

  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.setAssignSSM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDCKiri_Rencong.spbDeAss_SSMClick(Sender: TObject);
begin // deass ssm
  TDCInterface.setDeAssignSSM(TDCInterface.HaveToSend);
end;

end.
