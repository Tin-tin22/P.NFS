unit uLibWCC_Nala;

interface

uses
  ulibTDCClass, uLibWCCClassNew, uLibWCCKu, uFormUtil, Forms,
  uMainFormWCC;

type

//==============================================================================
  TWCC_NalaInterface = class (TGenericWCCInterface)
  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetDefaultLayOut; virtual;
    procedure SetLayoutpanelWith2Gun40MM(YESS : boolean);
    procedure SetFatahilahPanel;
    procedure SetNalaPanel;
    procedure getSettingForm_FromIni;


  end;

implementation

uses
  SysUtils, ufWCCPanelAtas, ufWCCPanelAtas2, ufWCCPanelBawah, ufWCCPanelBawah2,
  ufWCCTengah, ufAScope, ufBScope, ufQEK, ufrmBckGround, uAnduNala,
  uBaseConstan,uSettingFormToMonitorWith_ini;

//==============================================================================
{ TWCC_NalaInterface }

{LAYOUT PANEL WCC PADA SHIP FATAHILAH CLASS}
procedure TWCC_NalaInterface.SetLayoutpanelWith2Gun40MM(YESS : boolean);
begin
  (frmWCCAtas2 as TfrmWCCPanelAtas2).pnlcontrolGun3.Visible   := YESS;
  (frmWCCBawah2 as TfrmWCCPanelBawah2).pnlGun3Fire1.Visible   := YESS;
  (frmWCCBawah2 as TfrmWCCPanelBawah2).pnlFC3.Visible         := YESS;
end;

procedure TWCC_NalaInterface.SetFatahilahPanel;
begin
  SetLayoutpanelWith2Gun40MM(false);
end;

procedure TWCC_NalaInterface.SetNalaPanel;
begin
  SetLayoutpanelWith2Gun40MM(true);
end;

constructor TWCC_NalaInterface.Create;
begin
  inherited;

  fMainWCC.WCCInterface := self;

  frmQEK := TfrmQEK.Create(nil);
  (frmQEK as TfrmQEK).WCCInterface := self;

  frmTengah  :=  TfrmWCCTengah.Create(nil);
  (frmTengah as TfrmWCCTengah).WCCInterface := self;
  frmTengah.Caption := 'Weapon Control Console KRI Nala';

  frmWCCAtas1 := TfrmWCCPanelAtas.Create(nil);
  (frmWCCAtas1 as TfrmWCCPanelAtas).WCCInterface := self;
  frmWCCAtas1.Caption := 'Panel Kiri Atas';

  frmWCCAtas2 := TfrmWCCPanelAtas2.Create(nil);
  (frmWCCAtas2 as TfrmWCCPanelAtas2).WCCInterface := self;
  frmWCCAtas2.Caption := 'Panel Kanan Atas';

  frmWCCBawah1 := TfrmWCCPanelBawah.Create(nil);
  (frmWCCBawah1 as TfrmWCCPanelBawah).WCCInterface := self;
  frmWCCBawah1.Caption := 'Panel Kiri Bawah';

  frmWCCBawah2 := TfrmWCCPanelBawah2.Create(nil);
  (frmWCCBawah2 as TfrmWCCPanelBawah2).WCCInterface := self;
  frmWCCBawah2.Caption := 'Panel Kanan Bawah';
//  (frmWCCBawah2 as TfrmWCCPanelBawah2).Visible := False;

  frmAnduNala := TfrmAndu.Create(nil);
  (frmAnduNala as TfrmAndu).WCCInterface := self;
  (frmAnduNala as TfrmAndu).SetInitialValueAndu;
  frmAnduNala.Caption := 'Andu';

  frmScopeA := TfrmAScope.Create(nil);
  frmScopeA.Caption := 'A-Scope';

  frmScopeB := TfrmBScope.Create(nil);
  frmScopeB.Caption := 'B-Scope';

  frmBackground  := TfrmBackground.Create(nil);
  frmBackground.WindowState := wsMaximized;

  Gun1 := TGun.Create(1);
  Gun2 := TGun.Create(2);
  Gun3 := TGun.Create(3);


  SetDefaultLayOut;
end;

destructor TWCC_NalaInterface.Destroy;
begin
  frmScopeA.Free;
//  FreeAndNil(frmScopeA);
  FreeAndNil(frmScopeB);
  FreeAndNil(frmWCCAtas1);
  FreeAndNil(frmWCCAtas2);
  FreeAndNil(frmWCCBawah1);
  FreeAndNil(frmWCCBawah2);
  FreeAndNil(frmTengah);
  FreeAndNil(frmBackground);
  FreeAndNil(frmAnduNala);
  inherited;
end;

procedure TWCC_NalaInterface.getSettingForm_FromIni;
begin

end;

procedure TWCC_NalaInterface.SetDefaultLayOut;
var path : string;
idxAscope, alAscop, xAscop, yAscop,
idxBscope, alBscope, xBscope, yBscope,
idxMiddle, alMiddle, xMiddle, yMiddle,
idxTopLeft, alTopLeft, xTopLeft, yTopLeft,
idxTopRight, alTopRight, xTopRight, yTopRight,
idxBottomLeft, alBottomLeft, xBottomLeft, yBottomLeft,
idxBottomRight, alBottomRight, xBottomRight, yBottomRight,
idxAndu, alAndu, xAndu, yAndu,
idxBeckground, alBeckground, xBeckground, yBeckground       :Integer;
begin
  path := ExtractFilePath(Application.ExeName) + 'SetFormWCCToMonitor.ini';

  Getsettingform(path, 'ASCOPE', idxAscope, alAscop, xAscop, yAscop);
  Getsettingform(path, 'BSCOPE', idxBscope, alBscope, xBscope, yBscope);
  Getsettingform(path, 'TENGAH', idxMiddle, alMiddle, xMiddle, yMiddle);
  Getsettingform(path, 'ATASKIRI', idxTopLeft, alTopLeft, xTopLeft, yTopLeft);
  Getsettingform(path, 'ATASKANAN', idxTopRight, alTopRight, xTopRight, yTopRight);
  Getsettingform(path, 'BAWAHKIRI', idxBottomLeft, alBottomLeft, xBottomLeft, yBottomLeft);
  Getsettingform(path, 'BAWAHKANAN', idxBottomRight, alBottomRight, xBottomRight, yBottomRight);
  Getsettingform(path, 'ANDU', idxAndu, alAndu, xAndu, yAndu);
  Getsettingform(path, 'BACKGROUND', idxBeckground, alBeckground, xBeckground, yBeckground);

  case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apLeftTop  , 0, 0, frmWCCAtas1);
      AlignFormToMonitor(0, apRightTop , 0, 0, frmWCCAtas2);
      AlignFormToMonitor(0, apLeftBottom  , 0 ,-20, frmWCCBawah1);
      AlignFormToMonitor(0, apRightBottom , 0 ,-20, frmWCCBawah2);
    end;
    2 : begin
      AlignFormToMonitor(idxAscope, TAlignPos(alAscop), xAscop, yAscop, frmScopeA);
      AlignFormToMonitor(idxBscope, TAlignPos(alBscope), xBscope, yBscope, frmScopeB);

      AlignFormToMonitor(idxTopLeft, TAlignPos(alTopLeft), xTopLeft, yTopLeft, frmWCCAtas1);
      AlignFormToMonitor(idxTopRight, TAlignPos(alTopRight), xTopRight, yTopRight, frmWCCAtas2);

      AlignFormToMonitor(idxMiddle, TAlignPos(alMiddle), xMiddle, yMiddle, TForm(frmTengah));

      AlignFormToMonitor( idxBottomLeft, TAlignPos(alBottomLeft), xBottomLeft, yBottomLeft, frmWCCBawah1);
      AlignFormToMonitor(idxBottomRight, TAlignPos(alBottomRight), xBottomRight, yBottomRight, frmWCCBawah2);

      AlignFormToMonitor(idxAndu, TAlignPos(alAndu), xAndu, yAndu, frmAnduNala);
      AlignFormToMonitor(idxBeckground, TAlignPos(alBeckground), xBeckground, yBeckground, frmBackground);

      frmWCCBawah1.FormStyle := fsStayOnTop;
      frmWCCBawah2.FormStyle := fsStayOnTop;

      TfrmWCCPanelBawah(frmWCCBawah1).Visible := False;
      TfrmWCCPanelBawah2(frmWCCBawah2).Visible := False;

//      frmScopeA.BorderStyle     := bsNone;
//      frmScopeB.BorderStyle     := bsNone;
//      frmWCCAtas1.BorderStyle   := bsNone;
//      frmWCCAtas2.BorderStyle   := bsNone;
//      frmWCCBawah1.BorderStyle  := bsNone;
//      frmWCCBawah2.BorderStyle  := bsNone;
//      frmBackground.BorderStyle := bsNone;
//      frmAnduNala.BorderStyle   := bsNone;

      frmTengah.BorderStyle     := bsSizeable;

//      frmScopeA.FormStyle       := fsStayOnTop;
//      frmScopeB.FormStyle       := fsStayOnTop;
//      frmWCCAtas1.FormStyle     := fsStayOnTop;
//      frmWCCAtas2.FormStyle     := fsStayOnTop;
//      frmWCCBawah1.FormStyle    := fsStayOnTop;
//      frmWCCBawah2.FormStyle    := fsStayOnTop;
//      frmTengah.FormStyle       := fsStayOnTop;
//      frmAnduNala.FormStyle     := fsStayOnTop;

    end;
    3,4 : begin
      AlignFormToMonitor(idxAscope, TAlignPos(alAscop), xAscop, yAscop, frmScopeA);
      AlignFormToMonitor(idxBscope, TAlignPos(alBscope), xBscope, yBscope, frmScopeB);
      AlignFormToMonitor(idxAndu, TAlignPos(alAndu), xAndu, yAndu, frmAnduNala);

      AlignFormToMonitor(idxTopLeft, TAlignPos(alTopLeft), xTopLeft, yTopLeft, frmWCCAtas1);
      AlignFormToMonitor(idxTopRight, TAlignPos(alTopRight), xTopRight, yTopRight, frmWCCAtas2);

      AlignFormToMonitor(idxMiddle, TAlignPos(alMiddle), xMiddle, yMiddle, TForm(frmTengah));

      AlignFormToMonitor( idxBottomLeft, TAlignPos(alBottomLeft), xBottomLeft, yBottomLeft, frmWCCBawah1);
      AlignFormToMonitor(idxBottomRight, TAlignPos(alBottomRight), xBottomRight, yBottomRight, frmWCCBawah2);

      AlignFormToMonitor(idxBeckground, TAlignPos(alBeckground), xBeckground, yBeckground, frmBackground);

      frmScopeA.BorderStyle     := bsNone;
      frmScopeB.BorderStyle     := bsNone;
      frmWCCAtas1.BorderStyle   := bsNone;
      frmWCCAtas2.BorderStyle   := bsNone;
      frmWCCBawah1.BorderStyle  := bsNone;
      frmWCCBawah2.BorderStyle  := bsNone;
      frmTengah.BorderStyle     := bsNone;
      frmBackground.BorderStyle := bsNone;
      frmAnduNala.BorderStyle  := bsNone;

      frmScopeA.FormStyle       := fsStayOnTop;
      frmScopeB.FormStyle       := fsStayOnTop;
      frmWCCAtas1.FormStyle     := fsStayOnTop;
      frmWCCAtas2.FormStyle     := fsStayOnTop;
      frmWCCBawah1.FormStyle    := fsStayOnTop;
      frmWCCBawah2.FormStyle    := fsStayOnTop;
      frmTengah.FormStyle       := fsStayOnTop;
      frmAnduNala.FormStyle     := fsStayOnTop;

      frmTengah.WindowState     := wsMaximized;

      TfrmWCCPanelBawah(frmWCCBawah1).Visible  := true;
      TfrmWCCPanelBawah2(frmWCCBawah2).Visible := true;

      TfrmWCCTengah(frmTengah).btn2.Visible := False;
      TfrmWCCTengah(frmTengah).btn3.Visible := False;


    end;
  end;
end;

end.
