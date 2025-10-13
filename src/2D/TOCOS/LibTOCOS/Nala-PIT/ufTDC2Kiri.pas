unit ufTDC2Kiri;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Buttons, SpeedButtonImage, ExtCtrls, ufQEK,    uLibTDCClass;

type
  TfrmTDC2Kiri = class(TfrmQEK)
    GroupBox1: TGroupBox;
    spbSet_FC1: TSpeedButtonImage;
    spbBreak_FC1: TSpeedButtonImage;
    spbHoldFire_FC1: TSpeedButtonImage;
    spbOpenFire_FC1: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox2: TGroupBox;
    spbSet_FC2: TSpeedButtonImage;
    spbBreak_FC2: TSpeedButtonImage;
    spbHoldFire_FC2: TSpeedButtonImage;
    spbOpenFire_FC2: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    spbSet_FC3: TSpeedButtonImage;
    spbBreak_FC3: TSpeedButtonImage;
    spbHoldFire_FC3: TSpeedButtonImage;
    spbOpenFire_FC3: TSpeedButtonImage;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    GroupBox4: TGroupBox;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label1: TLabel;
    spbAssignSSM: TSpeedButtonImage;
    Label23: TLabel;
    Label24: TLabel;
    SpeedButtonImage10: TSpeedButtonImage;
    Label29: TLabel;
    procedure spbAssignSSMClick(Sender: TObject);
    procedure SpeedButtonImage10Click(Sender: TObject);
    procedure spbSet_FC1Click(Sender: TObject);
    procedure spbSet_FC2Click(Sender: TObject);
    procedure spbSet_FC3Click(Sender: TObject);
    procedure spbBreak_FC1Click(Sender: TObject);
    procedure spbBreak_FC2Click(Sender: TObject);
    procedure spbBreak_FC3Click(Sender: TObject);
    procedure spbOpenFire_FC1Click(Sender: TObject);
    procedure spbHoldFire_FC1Click(Sender: TObject);
    procedure spbOpenFire_FC2Click(Sender: TObject);
    procedure spbHoldFire_FC2Click(Sender: TObject);
    procedure spbOpenFire_FC3Click(Sender: TObject);
    procedure spbHoldFire_FC3Click(Sender: TObject);
    procedure SpeedButtonImage12Click(Sender: TObject);
    procedure SpeedButtonImage11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure LoadImageList; override;
  end;


implementation

uses
  uTCPDataType;

{$R *.dfm}

procedure TfrmTDC2Kiri.spbAssignSSMClick(Sender: TObject);
var aRec: TRecOrderXY;
begin
  aRec.X := TDCInterface.OBMLeft.mPos.X;
  aRec.Y := TDCInterface.OBMLeft.mPos.Y;

  TDCInterface.setAssignSSM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kiri.SpeedButtonImage10Click(Sender: TObject);
begin
  TDCInterface.setDeAssignSSM(TDCInterface.HaveToSend);
end;

procedure TfrmTDC2Kiri.spbSet_FC1Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(1,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDC2Kiri.spbBreak_FC1Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(1);
end;

procedure TfrmTDC2Kiri.spbOpenFire_FC1Click(Sender: TObject);
begin
  TDCInterface.SetOpenFire_FC(1);
end;

procedure TfrmTDC2Kiri.spbSet_FC2Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(2, TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDC2Kiri.spbBreak_FC2Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(2);
end;

procedure TfrmTDC2Kiri.spbSet_FC3Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(3, TDCInterface.OBMLeft.Center);
end;

procedure TfrmTDC2Kiri.spbBreak_FC3Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(3);
end;

procedure TfrmTDC2Kiri.spbHoldFire_FC1Click(Sender: TObject);
begin
//  TDCInterface.SetAssign_FC(1, TRUE);
  TDCInterface.SetHoldFire_FC(1);

end;

procedure TfrmTDC2Kiri.spbOpenFire_FC2Click(Sender: TObject);
begin
//  TDCInterface.SetAssign_FC(2, FALSE);
  TDCInterface.SetOpenFire_FC(2);

end;

procedure TfrmTDC2Kiri.spbHoldFire_FC2Click(Sender: TObject);
begin
//  TDCInterface.SetAssign_FC(2, TRUE);
  TDCInterface.SetHoldFire_FC(2);

end;

procedure TfrmTDC2Kiri.spbOpenFire_FC3Click(Sender: TObject);
begin
//  TDCInterface.SetAssign_FC(3, FALSE);
  TDCInterface.SetOpenFire_FC(3);

end;

procedure TfrmTDC2Kiri.spbHoldFire_FC3Click(Sender: TObject);
begin
//  TDCInterface.SetAssign_FC(3, FALSE);
  TDCInterface.SetHoldFire_FC(3);

end;

procedure TfrmTDC2Kiri.SpeedButtonImage12Click(Sender: TObject);
begin
  TDCInterface.SetOpenFire_FC(4);

end;

procedure TfrmTDC2Kiri.SpeedButtonImage11Click(Sender: TObject);
begin
  TDCInterface.SetHoldFire_FC(4);

end;

procedure TfrmTDC2Kiri.LoadImageList;
begin
  ilOrangeBox.Height := 55;
  ilOrangeBox.Width  := 220;

  LoadImageFile(image_path+'tdc\orangeBOX_4.bmp', ilOrangeBox );

end;

procedure TfrmTDC2Kiri.FormCreate(Sender: TObject);
begin
  inherited;
  SetSpeedButtonGlyphNumber(4);

end;

end.
