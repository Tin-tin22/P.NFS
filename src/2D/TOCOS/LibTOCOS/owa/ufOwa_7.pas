unit ufOwa_7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList;

type
  TfrmOwa_7 = class(TfrmQEK)
    Panel1: TPanel;
    btnINIT_SUBSRT: TSpeedButtonImage;
    btnINIT_ASWPOINT: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnWIPE: TSpeedButtonImage;
    Label2: TLabel;
    Label3: TLabel;
    btnLOST: TSpeedButtonImage;
    btnCRS_SPD: TSpeedButtonImage;
    btnLINKPLUS: TSpeedButtonImage;
    btnLINKMIN: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnASS_LOCRT: TSpeedButtonImage;
    btnASS_LOCNRT: TSpeedButtonImage;
    btnCOR_DECOR: TSpeedButtonImage;
    Label8: TLabel;
    btnSEQ: TSpeedButtonImage;
    btnCORR: TSpeedButtonImage;
    btnREPOS: TSpeedButtonImage;
    btnCLOSE_CONTROL: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    btnASS_REMOTE: TSpeedButtonImage;
    procedure btnINIT_SUBSRTClick(Sender: TObject);
    procedure btnCLOSE_CONTROLClick(Sender: TObject);
    procedure btnWIPEClick(Sender: TObject);
    procedure btnREPOSClick(Sender: TObject);
    procedure btnCORRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmOwa_7: TfrmOwa_7;

implementation
uses
  uBaseConstan, uTCPDataType, uLibTDCClass;

{$R *.dfm}

procedure TfrmOwa_7.btnINIT_SUBSRTClick(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.TrackNumber := 255;
//  aRec.OrderType := C_OrdType_RAM_atasair;
  aRec.OrderType := byte(ID_BawahAir_Unknown);
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec, TDCInterface.HaveToSend);
end;

procedure TfrmOwa_7.btnCLOSE_CONTROLClick(Sender: TObject);
begin
  TDCInterface.CloseControlOWA(tdBawahAir, TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_7.btnWIPEClick(Sender: TObject);
begin
  TDCInterface.WipeOnLeftOBM;
end;

procedure TfrmOwa_7.btnREPOSClick(Sender: TObject);
begin
  TDCInterface.RePos_OWA(tdBawahAir, TDCInterface.OBMLeft, false);
end;

procedure TfrmOwa_7.btnCORRClick(Sender: TObject);
begin
  TDCInterface.CorrectRAM(tdBawahAir);
end;

end.
