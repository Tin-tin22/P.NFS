unit ufWCCTengah;

interface

uses
  MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uMapWindow,
  Dialogs, StdCtrls, Buttons, SpeedButtonImage, ImgList, ExtCtrls,
  Menus, OleCtrls,  uLibWCCClassNew, VrControls, VrWheel,
  uLibWCCKu, uWCCManager, uBaseConstan, uLibTDCClass, uCompassDisplay, VrDesign,
  uFormUtil, RzButton, RzRadChk, {xpPanel,} Unit_ColorButton;

type
  TfrmWCCTengah = class(TfrmMapWindow)
    ILREDROUND: TImageList;
    ILREDBOX: TImageList;
    ILORANGEBOX: TImageList;
    ILORANGEROUND: TImageList;
    ILGREENBOX: TImageList;
    ILGREENROUND: TImageList;
    ILBLUEBOX: TImageList;
    PopupMenu2: TPopupMenu;
    Image1: TImage;
    lblName: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblG1To: TLabel;
    lblG2To: TLabel;
    lblG3To: TLabel;
    lblG1Blind: TLabel;
    lblG2Blind: TLabel;
    lblG3Blind: TLabel;
    lblG1inrange: TLabel;
    lblG2inrange: TLabel;
    lblG3inrange: TLabel;
    btn2: TVrBitmapButton;
    btnCenter: TVrBitmapButton;
    btn3: TVrBitmapButton;
    btnclose: TVrBitmapButton;
    procedure btn12SecClick(Sender: TObject);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnCenterClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure xpnl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btncloseClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDblClick(Sender: TObject);
    procedure FormClick(Sender: TObject);

  private
    { Private declarations }
    msDown : boolean; // flag mouse down;
    mIndex : integer; // marker index;
    ClickNum: integer;

    procedure OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure TGM_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    function ResizeRadar: Boolean;
  public
    { Public declarations }
    //TDCInterface : TGenericTDCInterface;
    WCCInterface : TGenericWCCInterface;
    //procedure SetRangeScale(const  aScaleNm: double); override;

  end;
const
  C_IMAGES_WCC_PATH    ='../data/images/wcc/';
implementation

uses Math, uBasefunction;

{$R *.dfm}

procedure TfrmWCCTengah.btnCenterClick(Sender: TObject);
begin
  inherited;
  Self.Left:= 0;
  WCCInterface.frmWCCBawah1.Visible:= False;
  WCCInterface.frmWCCBawah2.Visible:= False;
end;

procedure TfrmWCCTengah.btncloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmWCCTengah.btn2Click(Sender: TObject);
begin
  inherited;
  Self.Left:= 350;
  WCCInterface.frmWCCBawah1.formstyle:= fsStayOnTop;
  WCCInterface.frmWCCBawah1.Visible:= True;
  WCCInterface.frmWCCBawah2.Visible:= False;
end;

procedure TfrmWCCTengah.btn3Click(Sender: TObject);
begin
  inherited;
  Self.Left:= -350;
  WCCInterface.frmWCCBawah1.Visible:= False;
  WCCInterface.frmWCCBawah2.formstyle:= fsStayOnTop;
  WCCInterface.frmWCCBawah2.Visible:= True;

end;

procedure TfrmWCCTengah.FormClick(Sender: TObject);
begin
  inherited;
//   btnclose.Visible := False;
end;

procedure TfrmWCCTengah.FormCreate(Sender: TObject);
var pic : string;
    c : TDrawCompass;
begin
  inherited;
  //BorderStyle := bsNone;
 // WindowState := wsMaximized;
  Width       := 1920;
  Height      := 1080;
  Image1.Left := (Self.Width - Image1.Width)  div 2;
  Image1.Top  := (Self.Height - Image1.Height)  div 2;

  Map.BackColor := clBlack;
  Map.Width   := Image1.Width - 64;
  Map.Height  := Image1.Height - 63;
  Map.Left    := Image1.Left + 33;
  Map.Top     := Image1.Top + 33;

   pic := C_IMAGES_WCC_PATH + 'WCC_LPD_1060px.bmp' ;

   if FileExists(pic) then
    Image1.Picture.LoadFromFile(pic);

  c := TDrawCompass.Create;
  c.ptC.X := Image1.WIdth shr 1;
  c.ptC.Y := Image1.Height shr 1;

  c.Radius := (Image1.WIdth shr 1) - 2;
  c.DrawCompass(Image1.Canvas);

  c.Free;

  FCoverVisible := TRUE;
  SetRegionCircle;
  //self.resizeRadar;
  ClickNum := 0;


 // pnlSwitch.top := 0;
 // pnlSwitch.Left := (Self.Width - pnlSwitch.Width) div 2;
end;

procedure TfrmWCCTengah.FormDblClick(Sender: TObject);
begin
  inherited;
   btnclose.Visible := True;
end;

procedure TfrmWCCTengah.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
    btnclose.Visible := False
  else if Button = mbRight then
    btnclose.Visible := True;
end;

function TfrmWCCTengah.resizeRadar:boolean;
var
minWidth : integer;
begin
  minWidth := Min(self.Width, self.height );
  Map.Width   := minWidth - 170;
  Map.Height  := minWidth - 170;
  Map.Width   := Image1.Width - 60;
  Map.Height  := Image1.Height- 60;
  Map.Left    := (self.Width - Map.Width) div 2;
  Map.Top     := 15 + (self.Height - Map.Height) div 2;

  Map.BackColor := clGray;
  Map.Width   := Image1.Width - 60;
  Map.Height  := Image1.Height- 60;
//Map.Left    := Image1.Left  + Panel1.Left + 30;
//Map.Top     := Image1.Top   + Panel1.Top  + 30;

  FCoverVisible := TRUE;

  //********************************//
  {wBearing.Left := map.Left;
  wBearing.Top := map.Top + map.Height - wBearing.Height;
  wRange.Left := map.Left + map.Width - wRange.Width;
  wRange.Top := map.Top + map.Height - wRange.Height;}
end;

procedure SetDown(spb: TSpeedButtonImage; const val: boolean);
var ev: TNotifyEvent;
begin
  ev := spb.OnClick;
  spb.Down := val;
  spb.OnClick := ev;
  if val then
    spb.ImageIndex := 1
  else
    spb.ImageIndex := 0;
end;
{
procedure TfrmWCCTengah.SetRangeScale(const aScaleNm: double);
begin
  WCCInterface.SetView_RangeScale(aScaleNm);

end;
}
procedure TfrmWCCTengah.btn12SecClick(Sender: TObject);
begin
  //WCCInterface.
end;

procedure TfrmWCCTengah.MapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var lPt  : TPoint;
begin
  //inherited;

  msDown := Button = mbLeft;
  lpt.X  := X;
  lpt.Y  := Y;
  mIndex := WCCInterface.FindMarkerByPosition(lPt);
  if (mIndex = i_Gerbang_Pelacakan) and not WCCInterface.IsTGMMoveable then mIndex := -1;
  WCCInterface.SelectedMarkerTool := mIndex;

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
    i_Gerbang_Pelacakan : begin
      ClickNum := ClickNum + 1;
      Map.OnMouseMove := TGM_MapMouseMove;
    end;
  end;
end;

procedure TfrmWCCTengah.MapMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  //inherited;
end;

procedure TfrmWCCTengah.OBMKiri_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  WCCInterface.OBMLeft_SetPosition(X, Y);
end;

procedure TfrmWCCTengah.OBMKanan_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  WCCInterface.OBMRight_SetPosition(X, Y);
end;

procedure TfrmWCCTengah.TGM_MapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  WCCInterface.TGM_SetPosition(X, Y);

end;

procedure TfrmWCCTengah.xpnl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var showRbClose : Boolean;
begin
  inherited;

end;

procedure TfrmWCCTengah.MapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  if ClickNum = 1 then
    exit
  else if ClickNum = 2 then begin
    ClickNum := 0;
    Map.OnMouseMove := nil;
    msDown := FALSE;
    mIndex := -1;
    WCCInterface.SelectedMarkerTool := -1;
  end;
end;

procedure TfrmWCCTengah.FormResize(Sender: TObject);
begin
  inherited;
  //self.resizeRadar;
  //SetRegionCircle;
  //self.repaint;
  //self.Refresh;
end;

//****************************************************************************//
procedure TfrmWCCTengah.FormShow(Sender: TObject);
begin
  inherited;
  self.lblName.Caption := self.Caption;
  self.lblName.Left := trunc((self.Width/2) - (self.lblName.Width/2));
 // WCCInterface.DrawAngle(image1.Canvas);
end;

procedure TfrmWCCTengah.FormPaint(Sender: TObject);
begin
  inherited;

 // WCCInterface.DrawAngle(self.Canvas);

end;

end.
