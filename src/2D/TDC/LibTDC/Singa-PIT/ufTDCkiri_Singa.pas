unit ufTDCkiri_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, Buttons, SpeedButtonImage,  ufQEK, uLibTDCClass;

type
  TfTDCKiri_singa = class(TfrmQEK)
    GroupBox1: TGroupBox;
    spbSet_FC1: TSpeedButtonImage;
    spbBT_FC1: TSpeedButtonImage;
    spbHold_FC1: TSpeedButtonImage;
    spbAssign_FC2: TSpeedButtonImage;
    spbBT_FC2: TSpeedButtonImage;
    spbHold_FC2: TSpeedButtonImage;
    spbLIODplus: TSpeedButtonImage;
    spbLIODmin: TSpeedButtonImage;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    spbAssign_FC3: TSpeedButtonImage;
    spbBT_FC3: TSpeedButtonImage;
    spbHold_FC3: TSpeedButtonImage;
    spbSlaveFC_FC4: TSpeedButtonImage;
    spbSlaveOBM_FC4: TSpeedButtonImage;
    spbBT_FC4: TSpeedButtonImage;
    spbHold_FC4: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    Bevel4: TBevel;
    SpeedButtonImage17: TSpeedButtonImage;
    SpeedButtonImage18: TSpeedButtonImage;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage20: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    SpeedButtonImage23: TSpeedButtonImage;
    SpeedButtonImage24: TSpeedButtonImage;
    spbTorpedoPlus: TSpeedButtonImage;
    spbTorpedoMin: TSpeedButtonImage;
    spbTorpedoDisplay: TSpeedButtonImage;
    spbChaffPlus: TSpeedButtonImage;
    spbChaffMin: TSpeedButtonImage;
    spbThreatPlus: TSpeedButtonImage;
    spbThreatMin: TSpeedButtonImage;
    spbWipe: TSpeedButtonImage;
    Bevel6: TBevel;
    Label32: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel1: TBevel;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure spbBT_FC1Click(Sender: TObject);
    procedure SpeedButtonImage17Click(Sender: TObject);
    procedure spbSet_FC1Click(Sender: TObject);
    procedure spbHold_FC1Click(Sender: TObject);
    procedure spbAssign_FC2Click(Sender: TObject);
    procedure spbBT_FC2Click(Sender: TObject);
    procedure spbHold_FC2Click(Sender: TObject);
    procedure spbAssign_FC3Click(Sender: TObject);
    procedure spbBT_FC3Click(Sender: TObject);
    procedure spbThreatPlusClick(Sender: TObject);
    procedure spbThreatMinClick(Sender: TObject);
    procedure spbWipeClick(Sender: TObject);
  private
    { Private declarations }

  protected
       procedure LoadImageList; override;

  public
  end;


implementation

uses
  uBaseConstan, uTCPDataType;

{$R *.dfm}
const IMAGES_PATH  = 'images/tdc/';

procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;
procedure TfTDCKiri_singa.LoadImageList;
begin
  inherited;

end;

procedure TfTDCKiri_singa.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfTDCKiri_singa.SpeedButtonImage17Click(Sender: TObject);
begin  //setident


end;


procedure TfTDCKiri_singa.spbSet_FC1Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(1,  TDCInterface.OBMLeft.Center);

end;

procedure TfTDCKiri_singa.spbBT_FC1Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(1);
end;


procedure TfTDCKiri_singa.spbHold_FC1Click(Sender: TObject);
begin
  TDCInterface.SetHoldFire_FC(1);
end;

procedure TfTDCKiri_singa.spbAssign_FC2Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(2, TDCInterface.OBMLeft.Center);
end;

procedure TfTDCKiri_singa.spbBT_FC2Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(2);
end;

procedure TfTDCKiri_singa.spbHold_FC2Click(Sender: TObject);
begin
  TDCInterface.SetHoldFire_FC(2);
end;

procedure TfTDCKiri_singa.spbAssign_FC3Click(Sender: TObject);
begin
  TDCInterface.SetAssign_FC(3, TDCInterface.OBMLeft.Center);
end;


procedure TfTDCKiri_singa.spbBT_FC3Click(Sender: TObject);
begin
  TDCInterface.SetDeAssign_FC(3);
end;

procedure TfTDCKiri_singa.spbThreatPlusClick(Sender: TObject);
begin
  TDCInterface.SetThreadAsses(true,
    TDCInterface.OBMLeft.Center.X,
    TDCInterface.OBMLeft.Center.Y  );
end;

procedure TfTDCKiri_singa.spbThreatMinClick(Sender: TObject);
begin
  TDCInterface.SetThreadAsses(false,
    TDCInterface.OBMLeft.Center.X,
    TDCInterface.OBMLeft.Center.Y  );

end;

procedure TfTDCKiri_singa.spbWipeClick(Sender: TObject);
begin
  TDCInterface.WipeOnLeftOBM;

end;

end.
