unit ufTDCTengahBawah_OWA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, StdCtrls, Buttons, SpeedButtonImage, ExtCtrls, ImgList, uLibTDCClass;

type
  TfrmTengahBawah_OWA = class(TfrmQEK)
    Panel8: TPanel;
    btnAirLoc: TSpeedButtonImage;
    btnAirRem: TSpeedButtonImage;
    btnSurfLoc: TSpeedButtonImage;
    btnSurfRem: TSpeedButtonImage;
    btnSubsLoc: TSpeedButtonImage;
    btnSubsRem: TSpeedButtonImage;
    btnPntAir: TSpeedButtonImage;
    btnPntGen: TSpeedButtonImage;
    btnPntSubs: TSpeedButtonImage;
    btnBrgAir: TSpeedButtonImage;
    btnBrgGen: TSpeedButtonImage;
    btnBrgSubs: TSpeedButtonImage;
    btnTactAir: TSpeedButtonImage;
    btnTactGen: TSpeedButtonImage;
    btnTactSubs: TSpeedButtonImage;
    btnAsgAvl: TSpeedButtonImage;
    btnMsRti: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnLS: TSpeedButtonImage;
    btnTRFC: TSpeedButtonImage;
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
    procedure btnPntAirClick(Sender: TObject);
    procedure btnPntGenClick(Sender: TObject);
    procedure btnPntSubsClick(Sender: TObject);
    procedure btnAirRemClick(Sender: TObject);
    procedure btnSurfRemClick(Sender: TObject);
    procedure btnSubsRemClick(Sender: TObject);
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
    ufTDCTengah_OWA, uLibTDCTracks;

{$R *.dfm}

procedure TfrmTengahBawah_OWA.btnAirLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara, toLocal, btnAirLoc.Down);
  TDCInterface.Filter(tdUdara, toTransmitted, btnAirLoc.Down);
end;

procedure TfrmTengahBawah_OWA.btnSurfLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, toLocal, btnSurfLoc.Down);
  TDCInterface.Filter(tdAtasAir, toTransmitted, btnSurfLoc.Down);
end;

procedure TfrmTengahBawah_OWA.btnSubsLocClick(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir, toLocal, btnSubsLoc.Down);
  TDCInterface.Filter(tdBawahAir, toTransmitted, btnSubsLoc.Down);
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

procedure TfrmTengahBawah_OWA.btnPntAirClick(Sender: TObject);
begin
  TDCInterface.Filter(tdPointAir, btnPntAir.Down)
end;

procedure TfrmTengahBawah_OWA.btnPntGenClick(Sender: TObject);
begin
  TDCInterface.Filter(tdPointGen, btnPntGen.Down)
end;

procedure TfrmTengahBawah_OWA.btnPntSubsClick(Sender: TObject);
begin
  TDCInterface.Filter(tdDatum, btnPntSubs.Down)
end;

procedure TfrmTengahBawah_OWA.btnAirRemClick(Sender: TObject);
begin
  TDCInterface.Filter(tdUdara, toRemote, btnAirRem.Down);
end;

procedure TfrmTengahBawah_OWA.btnSurfRemClick(Sender: TObject);
begin
  TDCInterface.Filter(tdAtasAir, toRemote, btnSurfRem.Down);
end;

procedure TfrmTengahBawah_OWA.btnSubsRemClick(Sender: TObject);
begin
  TDCInterface.Filter(tdBawahAir, toRemote, btnSubsRem.Down);
end;

end.
