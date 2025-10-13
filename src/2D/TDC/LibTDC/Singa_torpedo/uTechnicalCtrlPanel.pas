unit uTechnicalCtrlPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, VrControls, VrBlinkLed, Buttons,
  SpeedButtonImage, StdCtrls, uDisplayCtrlPanelLeft,
  uDisplayCtrlPanelBottom,uMainCtrlPanel, uConst,uTCPClient, Menus,ufQEK, uLibTDCClass;

type
  TvTechnicalCtrlPanel  = class(TfrmQEK)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btnTempWec: TSpeedButtonImage;
    btnTempTcc: TSpeedButtonImage;
    btnWec: TSpeedButtonImage;
    btnFusesTcc: TSpeedButtonImage;
    Label3: TLabel;
    btnCmptr: TSpeedButtonImage;
    btnNugPower2: TSpeedButtonImage;
    btnNugPower1: TSpeedButtonImage;
    btnPowerResetWec: TSpeedButtonImage;
    btnPowerResetTcc: TSpeedButtonImage;
    btnSoftw: TSpeedButtonImage;
    VrBlinkLed1: TVrBlinkLed;
    Label4: TLabel;
    btnReadyLp: TSpeedButtonImage;
    btnLoadProgr: TSpeedButtonImage;
    btnTorpSim: TSpeedButtonImage;
    btnSysReset: TSpeedButtonImage;
    btnPowerOn: TSpeedButtonImage;
    btnSysOn: TSpeedButtonImage;
    btnOff: TSpeedButtonImage;
    Bevel22: TBevel;
    //ILORANGEBOX: TImageList;
    ILREDBOX: TImageList;
    ILREDROUND: TImageList;
    //ILGREENBOX: TImageList;
    ILGREENROUND: TImageList;
    ILORANGEROUND: TImageList;
    ILSWITCH: TImageList;
    GroupBox2: TGroupBox;
    Label22: TLabel;
    btnExtStabAvl: TSpeedButtonImage;
    btnCasStabAvl: TSpeedButtonImage;
    btnExt: TSpeedButtonImage;
    btnCas: TSpeedButtonImage;
    GroupBox3: TGroupBox;
    Label27: TLabel;
    btnPort: TSpeedButtonImage;
    btnToSupply1: TSpeedButtonImage;
    btn120Bar1: TSpeedButtonImage;
    btn20Bar1: TSpeedButtonImage;
    btnDoorOpen1: TSpeedButtonImage;
    btnTorpOn1: TSpeedButtonImage;
    btnRdyToFre1: TSpeedButtonImage;
    btnStb: TSpeedButtonImage;
    btnToSupply2: TSpeedButtonImage;
    btn120Bar2: TSpeedButtonImage;
    btn20Bar2: TSpeedButtonImage;
    btnDoorOpen2: TSpeedButtonImage;
    btnTorpOn2: TSpeedButtonImage;
    btnRdyToFre2: TSpeedButtonImage;
    GroupBox4: TGroupBox;
    SpeedButtonImage1: TSpeedButtonImage;
    Label42: TLabel;
    Label43: TLabel;
    SpeedButtonImage2: TSpeedButtonImage;
    Label44: TLabel;
    Label45: TLabel;
    SpeedButtonImage3: TSpeedButtonImage;
    Label46: TLabel;
    Label47: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    Label48: TLabel;
    Label49: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label50: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    SpeedButtonImage5: TSpeedButtonImage;
    Label51: TLabel;
    Label52: TLabel;
    SpeedButtonImage6: TSpeedButtonImage;
    Label53: TLabel;
    Label54: TLabel;
    SpeedButtonImage7: TSpeedButtonImage;
    Label55: TLabel;
    Label56: TLabel;
    PopupMenu1: TPopupMenu;
    pmConnect: TMenuItem;
    N1: TMenuItem;
    pmLog: TMenuItem;
    N2: TMenuItem;
    pmClose: TMenuItem;
    Memo1: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pmConnectClick(Sender: TObject);
    procedure pmCloseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnTorpSimClick(Sender: TObject);
  private
    procedure LoadImageButton;

  public
    powerON : Boolean;
    mServer: string;
    mShip: integer;
    bConnect: boolean;
    TheClient: TTCPClient;
    //procedure onRecPositionAvailable(apRec: PAnsiChar; aSize: integer);
     procedure SetLocalVariable(tdc :TGenericTDCInterface); override;

  end;

{var
  vTechnicalCtrlPanel: TvTechnicalCtrlPanel;
}
implementation

uses
  uLibTorpedo_singa,  uConnect;

{$R *.dfm}

var
  TOCOS : TTorpedoInterface;

procedure freebmp(var bmp: TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TvTechnicalCtrlPanel.LoadImageButton;
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;

  bmp.LoadFromFile(IMAGES_PATH + 'switchHz2.bmp');
  ILSWITCH.Add(bmp, nil);
  SpeedButtonImage1.ImageIndex := 0;
  SpeedButtonImage2.ImageIndex := 0;
  SpeedButtonImage3.ImageIndex := 0;
  SpeedButtonImage4.ImageIndex := 0;
  SpeedButtonImage5.ImageIndex := 0;
  SpeedButtonImage6.ImageIndex := 0;
  SpeedButtonImage7.ImageIndex := 0;

  freebmp(bmp);
  bmp.FreeInstance;
end;

procedure TvTechnicalCtrlPanel.FormShow(Sender: TObject);
begin
//  vDisplay.Show;
//  vDisplayCtrlPanelLeft.Show;
//  vDisplayCtrlPanelBottom.Show;
//  vMainCtrlPanel.Show;
end;

procedure TvTechnicalCtrlPanel.FormCreate(Sender: TObject);
begin
  powerON := False;
  bConnect := false;
  mShip := 72 ;

  theClient := TTCPClient.Create;
  TheClient.RegisterProcedure(REC_SET_TORPEDO, nil, sizeof(TRecSetTorpedo));
  theClient.setLog(TStringList(Memo1.Lines));

  LoadImageButton;
  VrBlinkLed1.Palette1.High := clMaroon;
end;

procedure TvTechnicalCtrlPanel.pmConnectClick(Sender: TObject);
begin
  vConnect.IDShip := mShip;
  if vConnect.ShowModalConnect = mrOk then
  begin
    mServer := vConnect.CServer;
    mShip := vConnect.IDShip;
    theClient.Connect(mServer, aPort);
    bConnect := True;
  end;
end;

procedure TvTechnicalCtrlPanel.pmCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TvTechnicalCtrlPanel.btnPowerOnClick(Sender: TObject);
begin
  powerON := True;
  btnCmptr.ImageIndex := 1;
  TOCOS.vDisplayCtrlPanelBottom.btnRange64.ImageIndex := 1;
  TOCOS.vDisplayCtrlPanelLeft.btnOff.ImageIndex := 1;
  Timer1.Enabled := True;
end;

procedure TvTechnicalCtrlPanel.Timer1Timer(Sender: TObject);
begin
  if (Timer1.Enabled) then
  begin
    btnLoadProgr.ImageIndex := 1;
    Timer2.Enabled := True;
    Timer1.Enabled := false;
  end;
end;

procedure TvTechnicalCtrlPanel.Timer2Timer(Sender: TObject);
begin
  if (Timer2.Enabled) then
  begin
    btnLoadProgr.ImageIndex := 0;
    btnCmptr.ImageIndex := 0;
    btnReadyLp.ImageIndex := 1;
    Timer2.Enabled := False;
  end;
end;

procedure TvTechnicalCtrlPanel.btnTorpSimClick(Sender: TObject);
begin
  if (powerON) then
  begin
    btnPort.ImageIndex := 1;
    btnStb.ImageIndex := 1;
    btnToSupply1.ImageIndex := 1;
    btnToSupply2.ImageIndex := 1;
    btn120Bar1.ImageIndex := 1;
    btn120Bar2.ImageIndex := 1;
    btn20Bar1.ImageIndex := 1;
    btn20Bar2.ImageIndex := 1;
  end;
end;

procedure TvTechnicalCtrlPanel.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//  inherited;
  TOCOS := tdc  AS TTorpedoInterface;

end;

end.
