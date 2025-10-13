unit ufTdcOrange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, Buttons, SpeedButtonImage, uLibTDCClass;

type
  TfrmTDCQEKSinga = class(TForm)
    GroupBox1: TGroupBox;
    SpeedButtonImage1: TSpeedButtonImage;
    ilOrange: TImageList;
    SpeedButtonImage2: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    SpeedButtonImage8: TSpeedButtonImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    SpeedButtonImage16: TSpeedButtonImage;
    Bevel4: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    SpeedButtonImage17: TSpeedButtonImage;
    SpeedButtonImage18: TSpeedButtonImage;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage20: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    SpeedButtonImage23: TSpeedButtonImage;
    SpeedButtonImage24: TSpeedButtonImage;
    Bevel5: TBevel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label24: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    SpeedButtonImage25: TSpeedButtonImage;
    SpeedButtonImage26: TSpeedButtonImage;
    SpeedButtonImage27: TSpeedButtonImage;
    SpeedButtonImage28: TSpeedButtonImage;
    SpeedButtonImage29: TSpeedButtonImage;
    SpeedButtonImage30: TSpeedButtonImage;
    SpeedButtonImage31: TSpeedButtonImage;
    SpeedButtonImage32: TSpeedButtonImage;
    Bevel6: TBevel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Bevel7: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonImage2Click(Sender: TObject);
    procedure SpeedButtonImage17Click(Sender: TObject);
  private
    { Private declarations }
  public
    TDCInterface : TGenericTDCInterface;
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

procedure TfrmTDCQEKSinga.FormCreate(Sender: TObject);
var bmpnya : TBitmap;
begin
  // ini buat imagelistnya
  bmpnya := TBitmap.Create;

  //ORANGE
  bmpnya.LoadFromFile(IMAGES_PATH + 'orangeBOX.bmp');
  ilOrange. Add(bmpnya,nil);
  SpeedButtonImage1.ImageIndex := 0;

  SpeedButtonImage2.ImageIndex := 0;
  SpeedButtonImage3.ImageIndex := 0;
  SpeedButtonImage4.ImageIndex := 0;
  SpeedButtonImage5.ImageIndex := 0;
  SpeedButtonImage6.ImageIndex := 0;
  SpeedButtonImage7.ImageIndex := 0;
  SpeedButtonImage8.ImageIndex := 0;
  SpeedButtonImage9.ImageIndex := 0;
  SpeedButtonImage10.ImageIndex := 0;
  SpeedButtonImage11.ImageIndex := 0;
  SpeedButtonImage12.ImageIndex := 0;
  SpeedButtonImage13.ImageIndex := 0;
  SpeedButtonImage14.ImageIndex := 0;
  SpeedButtonImage15.ImageIndex := 0;
  SpeedButtonImage16.ImageIndex := 0;
  SpeedButtonImage17.ImageIndex := 0;
  SpeedButtonImage18.ImageIndex := 0;
  SpeedButtonImage19.ImageIndex := 0;
  SpeedButtonImage20.ImageIndex := 0;
  SpeedButtonImage21.ImageIndex := 0;
  SpeedButtonImage22.ImageIndex := 0;
  SpeedButtonImage23.ImageIndex := 0;
  SpeedButtonImage24.ImageIndex := 0;
  SpeedButtonImage25.ImageIndex := 0;
  SpeedButtonImage26.ImageIndex := 0;
  SpeedButtonImage27.ImageIndex := 0;
  SpeedButtonImage28.ImageIndex := 0;
  SpeedButtonImage29.ImageIndex := 0;
  SpeedButtonImage30.ImageIndex := 0;
  SpeedButtonImage31.ImageIndex := 0;
  SpeedButtonImage32.ImageIndex := 0;
  freeBmp(bmpnya);
  //END ORANGE
  bmpnya.Free;
end;

procedure TfrmTDCQEKSinga.SpeedButtonImage2Click(Sender: TObject);
var aRec : TRecTrackOrder;
begin
  aRec.OrderID := 0;
  aRec.OrderType := C_OrdType_RAM_atasair;
  aRec.X := TDCInterface.OBMRight.mPos.X;
  aRec.Y := TDCInterface.OBMRight.mPos.Y;

  TDCInterface.InitiateRAM(aRec);
end;

procedure TfrmTDCQEKSinga.SpeedButtonImage17Click(Sender: TObject);
begin  //setident


end;

end.
