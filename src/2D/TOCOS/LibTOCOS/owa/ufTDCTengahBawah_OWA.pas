unit ufTDCTengahBawah_OWA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList, uLibTDCClass;

type
  TfrmTengahBawah_OWA = class(TfrmQEK)
    Panel8: TPanel;
    btnAirLoc: TSpeedButtonImage;
    Label43: TLabel;
    btnAirRem: TSpeedButtonImage;
    Label44: TLabel;
    btnSurfLoc: TSpeedButtonImage;
    Label45: TLabel;
    btnSurfRem: TSpeedButtonImage;
    Label46: TLabel;
    btnSubsLoc: TSpeedButtonImage;
    Label47: TLabel;
    btnSubsRem: TSpeedButtonImage;
    Label48: TLabel;
    btnPntAir: TSpeedButtonImage;
    Label49: TLabel;
    btnPntGen: TSpeedButtonImage;
    Label50: TLabel;
    btnPntSubs: TSpeedButtonImage;
    Label51: TLabel;
    btnBrgAir: TSpeedButtonImage;
    Label52: TLabel;
    btnBrgGen: TSpeedButtonImage;
    Label53: TLabel;
    btnBrgSubs: TSpeedButtonImage;
    Label54: TLabel;
    btnTactAir: TSpeedButtonImage;
    Label55: TLabel;
    btnTactGen: TSpeedButtonImage;
    Label56: TLabel;
    btnTactSubs: TSpeedButtonImage;
    Label57: TLabel;
    btnAsgAvl: TSpeedButtonImage;
    Label58: TLabel;
    btnMsRti: TSpeedButtonImage;
    Label59: TLabel;
    btnTM: TSpeedButtonImage;
    Label60: TLabel;
    btnLS: TSpeedButtonImage;
    Label61: TLabel;
    btnTRFC: TSpeedButtonImage;
    Label62: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label2: TLabel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel6: TBevel;
    pnlCaption: TPanel;
    procedure btnAirLocClick(Sender: TObject);
    procedure btnSurfLocClick(Sender: TObject);
    procedure btnSubsLocClick(Sender: TObject);
    procedure pnlCaptionMouseDown(Sender: TObject;
        Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlCaptionMouseMove(Sender: TObject;
        Shift: TShiftState; X,Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setPosition(ParentForm:TForm);
    procedure setMaxPosition(ParentForm:TForm);
  end;

//var
//  frmTengahBawah_OWA: TfrmTengahBawah_OWA;

implementation

uses Math, uBaseConstan, uLibRAdar, uTDCConstan,
    ufTDCTengah_OWA;

{$R *.dfm}

procedure TfrmTengahBawah_OWA.btnAirLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara,  btnAirLoc.Down);
end;

procedure TfrmTengahBawah_OWA.btnSurfLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, btnSurfLoc.Down)
end;

procedure TfrmTengahBawah_OWA.btnSubsLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir, btnSubsLoc.Down)
end;

procedure TfrmTengahBawah_OWA.setPosition(ParentForm:TForm);
begin
  //if self.Visible = True then begin
    //self.AlphaBlendValue := 20;
    self.Left := ParentForm.Left + (ParentForm.Width div 2) - (self.Width div 2);
    self.top := ParentForm.Top + ParentForm.Height  - self.pnlCaption.Height;
  //end;
end;

procedure TfrmTengahBawah_OWA.setMaxPosition(ParentForm:TForm);
begin
  //if self.Visible then begin
    self.Left := ParentForm.Left + (ParentForm.Width div 2) - (self.Width div 2);
    self.top := ParentForm.Top + ParentForm.Height  - self.Height;
    //self.AlphaBlendValue := 100;
  //end;
end;

procedure TfrmTengahBawah_OWA.pnlCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const SC_DRAGMOVE = $F012;
begin
  if button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND,SC_DRAGMOVE,0);
  end;
end;

procedure TfrmTengahBawah_OWA.pnlCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X,Y: Integer);
begin
  if PtInRect(self.pnlCaption.BoundsRect,Point(X,Y)) then begin
    //self.setMaxPosition(TfrmTDCTengah_OWA(TDCInterface.frmTengah));
    TDCInterface.ShowFormBawahOWA;
  end;

end;

end.
