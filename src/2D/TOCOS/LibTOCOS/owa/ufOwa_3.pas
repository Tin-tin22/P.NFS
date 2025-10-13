unit ufOwa_3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, ImgList, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls;

type
  TfrmOwa_3 = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage19: TSpeedButtonImage;
    btnIFF: TSpeedButtonImage;
    btnCEASE_ENG: TSpeedButtonImage;
    btnENG: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnFC1: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    btnTRRV_ENG: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnFC2: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    btnSEQ_TGT: TSpeedButtonImage;
    btnSEQ_WPN: TSpeedButtonImage;
    Label8: TLabel;
    btnFC3: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    btnREVIEW_FRND: TSpeedButtonImage;
    btnRESET_SEQ: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure btnFC1Click(Sender: TObject);
    procedure btnFC2Click(Sender: TObject);
    procedure btnFC3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOwa_3: TfrmOwa_3;

implementation

{$R *.dfm}

procedure TfrmOwa_3.btnFC1Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(1,  TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_3.btnFC2Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(2, TDCInterface.OBMLeft.Center);
end;

procedure TfrmOwa_3.btnFC3Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(3, TDCInterface.OBMLeft.Center);
end;

end.
