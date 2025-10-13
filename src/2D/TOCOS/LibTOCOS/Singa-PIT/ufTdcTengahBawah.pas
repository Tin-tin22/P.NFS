unit ufTdcTengahBawah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, Buttons, SpeedButtonImage,
  ufQEK, uLibTDCClass;
  
type
  TfrmTdcTengahBawah = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage27: TSpeedButtonImage;
    Label22: TLabel;
    SpeedButtonImage28: TSpeedButtonImage;
    Label1: TLabel;
    SpeedButtonImage29: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage31: TSpeedButtonImage;
    SpeedButtonImage30: TSpeedButtonImage;
    Label4: TLabel;
    spb12Sec: TSpeedButtonImage;
    Label5: TLabel;
    spb30Sec: TSpeedButtonImage;
    Label6: TLabel;
    spb6Min: TSpeedButtonImage;
    Label7: TLabel;
    spb15Min: TSpeedButtonImage;
    Label8: TLabel;
    spbThreatReset: TSpeedButtonImage;
    Label9: TLabel;
    SpeedButtonImage10: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage11: TSpeedButtonImage;
    Label11: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    Label12: TLabel;
    SpeedButtonImage13: TSpeedButtonImage;
    Label13: TLabel;
    SpeedButtonImage14: TSpeedButtonImage;
    Label14: TLabel;
    SpeedButtonImage15: TSpeedButtonImage;
    Label15: TLabel;
    SpeedButtonImage16: TSpeedButtonImage;
    SpeedButtonImage17: TSpeedButtonImage;
    Label17: TLabel;
    Label16: TLabel;
    Bevel1: TBevel;
    Label18: TLabel;
    Bevel2: TBevel;
    Label19: TLabel;
    Bevel3: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure spb12SecClick(Sender: TObject);
    procedure SpeedButtonImage10Click(Sender: TObject);
    procedure SpeedButtonImage11Click(Sender: TObject);
    procedure SpeedButtonImage12Click(Sender: TObject);
    procedure SpeedButtonImage13Click(Sender: TObject);
    procedure SpeedButtonImage15Click(Sender: TObject);
    procedure SpeedButtonImage17Click(Sender: TObject);
    procedure SpeedButtonImage27Click(Sender: TObject);
    procedure SpeedButtonImage28Click(Sender: TObject);
    procedure SpeedButtonImage29Click(Sender: TObject);
    procedure SpeedButtonImage31Click(Sender: TObject);
    procedure SpeedButtonImage30Click(Sender: TObject);
    procedure SpeedButtonImage16Click(Sender: TObject);
  private
    { Private declarations }
    procedure Reset_Threat_Button;
  public
  end;


implementation

uses
  uBaseConstan;  

{$R *.dfm}
const IMAGES_PATH  = 'images\tdc\';

{procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;
}
procedure TfrmTdcTengahBawah.Reset_Threat_Button;
begin
  spb12Sec.ImageIndex := 0;
  spb30Sec.ImageIndex := 0;
  spb6Min.ImageIndex := 0;
  spb15Min.ImageIndex := 0;
  spbThreatReset.ImageIndex := 0;
end;

procedure TfrmTdcTengahBawah.FormCreate(Sender: TObject);
var bmpnya : TBitmap;
begin
  inherited;

  spb12Sec.Tag := 12;
  spb30Sec.Tag := 30;
  spb6Min.Tag  := 6 * 60;
  spb15Min.Tag := 15 * 60;
  spbThreatReset.Tag := -1;
end;

procedure TfrmTdcTengahBawah.spb12SecClick(Sender: TObject);
begin
  TDCInterface.SetThreadAssesmentDuration((sender as TComponent).Tag);
  Reset_Threat_Button;
  (sender as TSpeedButtonImage).ImageIndex := 1;
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage10Click(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  (sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage11Click(Sender: TObject);
begin
  TDCInterface.Filter( tdAtasAir,  (sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage12Click(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir,  (sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage13Click(Sender: TObject);
begin
  TDCInterface.Filter(tdEw,  (sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage15Click(Sender: TObject);
begin
  TDCInterface.SetBlindARC((sender as TSpeedButton).Down);

end;

procedure TfrmTdcTengahBawah.SpeedButtonImage17Click(Sender: TObject);
begin
  TDCInterface.SetLPDTest((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage27Click(Sender: TObject);
begin
  TDCInterface.SetMainSymbolVisible((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage28Click(Sender: TObject);
begin
  TDCInterface.SetCourseVisible((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage29Click(Sender: TObject);
begin
  TDCInterface.SetAMPLInfoVisible((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage31Click(Sender: TObject);
begin
//   TDCInterface.SetLINKVisible((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage30Click(Sender: TObject);
begin
  TDCInterface.SetTrackNumberVisible((sender as TSpeedButton).Down);
end;

procedure TfrmTdcTengahBawah.SpeedButtonImage16Click(Sender: TObject);
begin
//  inherited;

end;

end.
