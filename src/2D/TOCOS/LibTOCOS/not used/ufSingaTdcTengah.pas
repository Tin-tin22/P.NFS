unit ufSingaTdcTengah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uMapWindow,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ufTDCTengah, SpeedButtonImage, ImgList, MapXLib_TLB,
  Menus, OleCtrls, uLibTDCClass, VrControls, VrWheel, VrDigit;

type

  TfrmTDCTengah_Singa = class(TfrmTDCTengah)
    Panel1: TPanel;
    ilOrange: TImageList;
    btnICM1_R: TSpeedButtonImage;
    Label3: TLabel;
    ilGreen: TImageList;
    btnICM2_R: TSpeedButtonImage;
    Label1: TLabel;
    btnICM3_R: TSpeedButtonImage;
    Label2: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    Label4: TLabel;
    SpeedButtonImage5: TSpeedButtonImage;
    Label5: TLabel;
    SpeedButtonImage6: TSpeedButtonImage;
    Label6: TLabel;
    SpeedButtonImage7: TSpeedButtonImage;
    Label7: TLabel;
    SpeedButtonImage8: TSpeedButtonImage;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    SpeedButtonImage9: TSpeedButtonImage;
    Label10: TLabel;
    SpeedButtonImage10: TSpeedButtonImage;
    Label11: TLabel;
    SpeedButtonImage11: TSpeedButtonImage;
    Label12: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    Label13: TLabel;
    SpeedButtonImage13: TSpeedButtonImage;
    Label14: TLabel;
    btnICM1_L: TSpeedButtonImage;
    Label15: TLabel;
    btnICM2_L: TSpeedButtonImage;
    Label16: TLabel;
    btnICM3_L: TSpeedButtonImage;
    Label17: TLabel;
    Label18: TLabel;
    Bevel2: TBevel;
    SpeedButtonImage17: TSpeedButtonImage;
    Label19: TLabel;
    SpeedButtonImage18: TSpeedButtonImage;
    Label20: TLabel;
    SpeedButtonImage19: TSpeedButtonImage;
    Label21: TLabel;
    SpeedButtonImage20: TSpeedButtonImage;
    SpeedButtonImage21: TSpeedButtonImage;
    SpeedButtonImage22: TSpeedButtonImage;
    SpeedButtonImage23: TSpeedButtonImage;
    Label25: TLabel;
    SpeedButtonImage24: TSpeedButtonImage;
    Label26: TLabel;
    SpeedButtonImage25: TSpeedButtonImage;
    Label27: TLabel;
    SpeedButtonImage26: TSpeedButtonImage;
    ilBlue: TImageList;
    ilOrangeRound: TImageList;
    SpeedButtonImage27: TSpeedButtonImage;
    Label22: TLabel;
    SpeedButtonImage28: TSpeedButtonImage;
    Label23: TLabel;
    SpeedButtonImage29: TSpeedButtonImage;
    Label24: TLabel;
    SpeedButtonImage30: TSpeedButtonImage;
    Label28: TLabel;
    SpeedButtonImage31: TSpeedButtonImage;
    Label29: TLabel;
    SpeedButtonImage32: TSpeedButtonImage;
    Label30: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Image1: TImage;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    wRange: TVrWheel;
    wBearing: TVrWheel;
    Panel6: TPanel;
    VrBearing: TVrDigitGroup;
    Label34: TLabel;
    Panel7: TPanel;
    VrRange: TVrDigitGroup;
    Label35: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonImage4Click(Sender: TObject);
    procedure SpeedButtonImage9Click(Sender: TObject);
    procedure SpeedButtonImage10Click(Sender: TObject);
    procedure SpeedButtonImage11Click(Sender: TObject);
    procedure SpeedButtonImage12Click(Sender: TObject);
    procedure SpeedButtonImage13Click(Sender: TObject);
    procedure SpeedButtonImage5Click(Sender: TObject);
    procedure SpeedButtonImage6Click(Sender: TObject);
    procedure SpeedButtonImage7Click(Sender: TObject);
    procedure SpeedButtonImage8Click(Sender: TObject);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButtonImage20Click(Sender: TObject);
    procedure SpeedButtonImage21Click(Sender: TObject);
    procedure SpeedButtonImage22Click(Sender: TObject);
    procedure SpeedButtonImage23Click(Sender: TObject);
    procedure SpeedButtonImage24Click(Sender: TObject);
    procedure SpeedButtonImage31Click(Sender: TObject);
    procedure SpeedButtonImage32Click(Sender: TObject);
    procedure SpeedButtonImage28Click(Sender: TObject);
    procedure SpeedButtonImage29Click(Sender: TObject);
    procedure btnICM_LClick(Sender: TObject);
    procedure btnICM1_RClick(Sender: TObject);
    procedure wBearingChange(Sender: TObject);
    procedure wRangeChange(Sender: TObject);
  private
    msDown : boolean; // flag mouse down;
    mIndex : integer; // marker index;
    ClickNum: integer;

    procedure OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  public
    { Public declarations }
//    TDCInterface : TGenericTDCInterface;

  end;


implementation

uses uBaseConstan, uLibRadar;

{$R *.dfm}
const IMAGES_PATH  = 'images\tdc\';

procedure freeBmp (var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TfrmTDCTengah_Singa.FormCreate(Sender: TObject);
var bmpnya : TBitmap;
    fName : string;
begin
  // ini buat imagelistnya
  inherited;

  Map.BackColor := clGray;

  Map.Width   := Image1.Width - 60;
  Map.Height  := Image1.Height- 60;
  Map.Left    := Image1.Left  + Panel1.Left + 30;
  Map.Top     := Image1.Top   + Panel1.Top  + 30;

  FCoverVisible := TRUE;

  fname := ExtractFilePath(Application.ExeName) + 'images\tdc\tdc_LPD.bmp';
  if FileExists(fname) then
    Image1.Picture.Bitmap.LoadFromFile(fname);


  SetRegionCircle;

  bmpnya := TBitmap.Create;

  //ORANGE
  bmpnya.LoadFromFile(IMAGES_PATH + 'orangeBOX.bmp');
  ilOrange. Add(bmpnya,nil);
  SpeedButtonImage5.ImageIndex := 0;
  SpeedButtonImage9.ImageIndex := 0;
  SpeedButtonImage11.ImageIndex := 0;
  SpeedButtonImage13.ImageIndex := 0;
  SpeedButtonImage31.ImageIndex := 0;
  SpeedButtonImage32.ImageIndex := 0;
  freeBmp(bmpnya);

  //END ORANGE

  //GREEN
  bmpnya.LoadFromFile(IMAGES_PATH + 'greenBOX.bmp');
  ilGreen. Add(bmpnya,nil);
  btnICM1_R.ImageIndex := 0;
  btnICM2_R.ImageIndex := 0;
  btnICM3_R.ImageIndex := 0;

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
  btnICM1_L.ImageIndex := 0;
  btnICM2_L.ImageIndex := 0;
  btnICM3_L.ImageIndex := 0;
  SpeedButtonImage17.ImageIndex := 0;
  SpeedButtonImage18.ImageIndex := 0;
  SpeedButtonImage23.ImageIndex := 0;
  SpeedButtonImage24.ImageIndex := 0;
  SpeedButtonImage25.ImageIndex := 0;
  SpeedButtonImage27.ImageIndex := 0;
  SpeedButtonImage28.ImageIndex := 0;
  SpeedButtonImage29.ImageIndex := 0;
  SpeedButtonImage30.ImageIndex := 0;
  freeBmp(bmpnya);

  //END GREEN

  //BLUE
  bmpnya.LoadFromFile(IMAGES_PATH + 'blueBOX.bmp');
  ilBlue. Add(bmpnya,nil);
  SpeedButtonImage20.ImageIndex := 0;
  SpeedButtonImage21.ImageIndex := 0;
  SpeedButtonImage22.ImageIndex := 0;
  SpeedButtonImage26.ImageIndex := 0;
  freeBmp(bmpnya);

  //END BLUE

 //orangeROUND
  bmpnya.LoadFromFile(IMAGES_PATH + 'orangeROUND.bmp');
  ilOrangeRound. Add(bmpnya,nil);
  SpeedButtonImage19.ImageIndex := 0;
  freeBmp(bmpnya);

 //end orangeROUND
  bmpnya.Free;

  ClickNum := 0;

  btnICM1_L.Tag := 1;
  btnICM2_L.Tag := 2;
  btnICM3_L.Tag := 3;

  btnICM1_R.Tag := 11;
  btnICM2_R.Tag := 12;
  btnICM3_R.Tag := 13;

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage4Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_OFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage9Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_OFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage10Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Left_SetStatus(stCU_OR_CENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage11Click(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stOFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage12Click(Sender: TObject);
begin
  TDCInterface.CentLeft_SetStatus(stCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage13Click(Sender: TObject);
begin
  TDCInterface.OBMLeft_Reset;

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage5Click(Sender: TObject);
begin
  TDCInterface.CU_OR_Right_SetStatus(stCU_OR_CENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage6Click(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stOFFCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage7Click(Sender: TObject);
begin
  TDCInterface.CentRight_SetStatus(stCENT);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage8Click(Sender: TObject);
begin
  TDCInterface.OBMRight_Reset;

end;

procedure TfrmTDCTengah_Singa.MapMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lPt  : TPoint;
begin

  msDown := Button = mbLeft;
  lpt.X  := X;
  lpt.Y  := Y;
  mIndex := TDCInterface.FindMarkerByPosition(lPt);
  TDCInterface.SelectedMarkerTool := mIndex;

  if mIndex < 0 then begin
    Map.OnMouseMove := nil;
    exit;
    ClickNum := 0;
  end;

  case mIndex of

    i_OBM_kiri  : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKiri_MapMouseMove;
    end;
    i_OBM_kanan : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := OBMKanan_MapMouseMove;
    end;

  end;

end;

procedure TfrmTDCTengah_Singa.MapMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  if  ClickNum = 1 then
    exit
  else if ClickNum = 2 then begin
    ClickNum := 0;
    Map.OnMouseMove := nil;
    msDown := FALSE;
    mIndex := -1;
    TDCInterface.SelectedMarkerTool := -1;
  end;

end;

procedure TfrmTDCTengah_Singa.OBMKanan_MapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.OBMRight_SetPosition(X, Y);
end;

procedure TfrmTDCTengah_Singa.OBMKiri_MapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TDCInterface.OBMLeft_SetPosition(X, Y);
end;


procedure TfrmTDCTengah_Singa.SpeedButtonImage20Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(TRUE);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage21Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLiner);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage22Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtDA_05);
  TDCInterface.SetRadar_MTI_Status(FALSE);
  TDCInterface.SetRadar_Amplification(raLogarithmic);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage23Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(FALSE);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage24Click(Sender: TObject);
begin
  TDCInterface.SetRadar_type(rtWM_28);
  TDCInterface.SetRadar_MTI_Status(TRUE);

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage31Click(Sender: TObject);
begin
  TDCInterface.TrueMotion := (sender as TSpeedButtonImage).Down;

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage32Click(Sender: TObject);
begin
   TDCInterface.Cursorss.Visible := (sender as TSpeedButtonImage).Down;

end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage28Click(Sender: TObject);
begin
  TDCInterface.SetRadar_RangeRing((sender as TSpeedButtonImage).Down);
end;

procedure TfrmTDCTengah_Singa.SpeedButtonImage29Click(Sender: TObject);
begin
  TDCInterface.SetRadar_HeadingMarker((sender as TSpeedButtonImage).Down);

end;

procedure TfrmTDCTengah_Singa.btnICM_LClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMLeft(num,
      TDCInterface.OBMleft.mPos.X , TDCInterface.OBMleft.mPos.Y)
  else
    TDCInterface.EndICMLeft(num);

end;

procedure TfrmTDCTengah_Singa.btnICM1_RClick(Sender: TObject);
var num: byte;
begin
  num := (Sender as TSpeedButton).Tag;
  if (Sender as TSpeedButton).Down then
    TDCInterface.StartICMRight(num,
      TDCInterface.OBMRight.mPos.X , TDCInterface.OBMRight.mPos.Y)
  else
    TDCInterface.EndICMRight(num);

end;

procedure TfrmTDCTengah_Singa.wBearingChange(Sender: TObject);
begin
  TDCInterface.CursorSetBearing(wBearing.Position);
  VrBearing.Value := wBearing.Position * 10;

end;

procedure TfrmTDCTengah_Singa.wRangeChange(Sender: TObject);
begin
  TDCInterface.CursorSetRange(wRange.Position);
  VrRange.Value := wRange.Position;

end;

end.
