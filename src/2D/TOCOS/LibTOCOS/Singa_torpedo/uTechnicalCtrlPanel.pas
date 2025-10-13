unit uTechnicalCtrlPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, VrControls, VrBlinkLed, Buttons,
  SpeedButtonImage, StdCtrls, uTCPClient, Menus,ufQEK, uLibTDCClass, RzBmpBtn,
  VrDesign, uLibRadar{untuk cheat};

type
  TvTechnicalCtrlPanel  = class(TfrmQEK)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnPowerResetWec: TSpeedButtonImage;
    btnPowerResetTcc: TSpeedButtonImage;
    btnSoftw: TSpeedButtonImage;
    VrBlinkLed1: TVrBlinkLed;
    Label4: TLabel;
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
    btnExt: TSpeedButtonImage;
    btnCas: TSpeedButtonImage;
    GroupBox3: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    grpUp: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label50: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
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
    grpRight: TGroupBox;
    grpCenter: TGroupBox;
    grpLeft: TGroupBox;
    grpBottom: TGroupBox;
    btnV1: TRzBmpButton;
    btn10: TRzBmpButton;
    btn2: TRzBmpButton;
    btn3: TRzBmpButton;
    btn4: TRzBmpButton;
    btn5: TRzBmpButton;
    btn6: TRzBmpButton;
    btnclose: TVrBitmapButton;
    lmpTempWEC: TImage;
    lmp1: TImage;
    lmp2: TImage;
    lmp3: TImage;
    IndCmptr: TImage;
    IndNUG2: TImage;
    IndNUG1: TImage;
    IndRdyToFire1: TImage;
    IndRdyToFire2: TImage;
    IndTorpOn1: TImage;
    IndTorpOn2: TImage;
    IndDoorOpen1: TImage;
    IndDooropen2: TImage;
    Ind20Bar1: TImage;
    Ind20Bar2: TImage;
    Ind120Bar2: TImage;
    IndToSupply2: TImage;
    IndStb: TImage;
    IndPort: TImage;
    IndToSupply1: TImage;
    Ind120Bar1: TImage;
    IndRdyLp: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    IndExt: TImage;
    IndCas: TImage;
    lbl31: TLabel;
    lbl32: TLabel;
    pmHiden: TPopupMenu;
    QuickStart1: TMenuItem;
    CloseAllForm1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure pmConnectClick(Sender: TObject);
    procedure pmCloseClick(Sender: TObject);
    procedure btnPowerOnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnTorpSimClick(Sender: TObject);
    procedure btnSysOnClick(Sender: TObject);
    procedure btnOffClick(Sender: TObject);
    procedure btnSysResetClick(Sender: TObject);
    procedure btnExtClick(Sender: TObject);
    procedure btnCasClick(Sender: TObject);
    procedure btnExitAppClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadProgrClick(Sender: TObject);
    procedure btnV1Click(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure Label54Click(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure grpUpClick(Sender: TObject);
    procedure btnCheatOnClick(Sender: TObject);
    procedure btnClearScenarioClick(Sender: TObject);
    procedure QuickStartClick(Sender: TObject);
    procedure CloseAllForm1Click(Sender: TObject);
  private
    image_path:  string;


//    switch_On: TBitmap;
//    switch_Off: TBitmap;

    switch : array [1..7] of Boolean;
    isReadyLP, cekClose1, cekclose2 : Boolean;
    procedure LoadImageButton;
//    procedure Reset_Stab_button;
    function cekSwitch : Boolean;
    procedure PowerOff;

  public
    IndPort_on,
    IndStb_on,
    IndToSup1_on,
    IndToSup2_on,
    Ind120Bar1_on,
    Ind120Bar2_on,
    Ind20Bar1_on,
    Ind20Bar2_on,
    IndDorrOpn1_on,
    IndDorrOpn2_on,
    IndTorpOn1_on,
    IndTorpOn2_on,
    IndRdyToFre1_on,
    IndRdyToFre2_on,

    powerON : Boolean;
    {mServer: string;
    mShip: integer;
    bConnect: boolean;
    TheClient: TTCPClient;
    procedure onRecPositionAvailable(apRec: PAnsiChar; aSize: integer);}
    procedure SetLocalVariable(tdc :TGenericTDCInterface); override;
    procedure SetUpdownImage(var spb : TSpeedButtonImage);
    procedure System_On(Is_on : boolean);


  end;

{var
  vTechnicalCtrlPanel: TvTechnicalCtrlPanel;
}
implementation

uses
  uLibTorpedo_singa, ComObj; //,  uConnect;

{$R *.dfm}

var
  TOCOS : TTorpedoInterface;


procedure TvTechnicalCtrlPanel.Label54Click(Sender: TObject);
begin
  cekClose1 := True;
  btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvTechnicalCtrlPanel.Label56Click(Sender: TObject);
begin
 cekClose2 := True;
 btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvTechnicalCtrlPanel.LoadImageButton;
var
  bmp_on, bmp_off : TBitmap;
  I : Integer;
begin
  bmp_on := TBitmap.Create;
  bmp_off:= TBitmap.Create;

  image_path := '..\data\images\';  // ExtractFilePath(Application.ExeName) ;

  bmp_on.LoadFromFile(image_path  + 'torpedo\switch_on.bmp');
  bmp_off.LoadFromFile(image_path + 'torpedo\switch_off.bmp');

  for i := 0 to ComponentCount-1 do
    if (Components[I] is TRzBmpButton) then
    with (Components[I] as TRzBmpButton).Bitmaps do begin
      Down.Assign(bmp_on);
      StayDown.Assign(bmp_on);
      Up.Assign(bmp_off);
      UpAndFocused.Assign(bmp_off);
    end;

  freebmp(bmp_off);
  bmp_off.FreeInstance;
  freebmp(bmp_on);
  bmp_on.FreeInstance;
end;

procedure TvTechnicalCtrlPanel.SetUpdownImage(var spb : TSpeedButtonImage);
begin
  if spb.Down then spb.ImageIndex := 1
  else spb.ImageIndex := 0;
end;


procedure TvTechnicalCtrlPanel.FormCreate(Sender: TObject);
Var I : Integer;
begin
  inherited;

    IndPort_on      := False;
    IndStb_on       := False;
    IndToSup1_on    := False;
    IndToSup2_on    := False;
    Ind120Bar1_on   := False;
    Ind120Bar2_on   := False;
    Ind20Bar1_on    := False;
    Ind20Bar2_on    := False;
    IndDorrOpn1_on  := False;
    IndDorrOpn2_on  := False;
    IndTorpOn1_on   := False;
    IndTorpOn2_on   := False;
    IndRdyToFre1_on := False;
    IndRdyToFre2_on := False;

  {bConnect := false;
  mShip := 72 ;

  theClient := TTCPClient.Create;
  TheClient.RegisterProcedure(REC_SET_TORPEDO, nil, sizeof(TRecSetTorpedo));
  theClient.setLog(TStringList(Memo1.Lines));}


  isReadyLP := False;
  cekClose1 := False;
  cekclose2 := False;

  for I := 1 to 7 do
    switch[I] := false;

  powerON := False;
  SetUpdownImage(btnOff);
  LoadImageButton;
  VrBlinkLed1.Palette1.High := clRed;

  btnPowerResetWec.Caption  := UpperCase('POWER' + #13 + 'RESET' + #13 + 'WEC');
  btnPowerResetTcc.Caption  := UpperCase('POWER' + #13 + 'RESET' + #13 + 'TCC');
  btnLoadProgr.Caption      := UpperCase('LOAD' + #13 + 'PROGR');
  btnTorpSim.Caption        := UpperCase('TORP' + #13 + 'SIM');
  btnPowerOn.Caption        := UpperCase('POWER' + #13 + 'ON');
  btnSysOn.Caption          := UpperCase('SYS' + #13 + 'ON');
  btnSysReset.Caption       := UpperCase('SYS' + #13 + 'RESET');
end;

procedure TvTechnicalCtrlPanel.FormShow(Sender: TObject);
begin
//  inherited;
//  grpLeft.Width := Self.Width div 2 + GroupBox3.Width div 2;
//  grpRight.Width := Self.Width div 2;

end;

procedure TvTechnicalCtrlPanel.grpUpClick(Sender: TObject);
begin
//  inherited;
 cekClose1 := false;
 cekClose1 := false;
 btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvTechnicalCtrlPanel.pmConnectClick(Sender: TObject);
begin
  {vConnect.IDShip := mShip;
  if vConnect.ShowModalConnect = mrOk then
  begin
    mServer := vConnect.CServer;
    mShip := vConnect.IDShip;
    theClient.Connect(mServer, aPort);
    bConnect := True;
  end;}
end;

procedure TvTechnicalCtrlPanel.pmCloseClick(Sender: TObject);
//var
//  shell : Variant;
begin
//  Close;
  Application.Terminate;
//  shell := CreateOleObject('Shell.Application');
//  shell.ShutdownWindows;
end;

procedure TvTechnicalCtrlPanel.btnPowerOnClick(Sender: TObject);
begin
  if not cekSwitch then begin
    btnPowerOn.Down := False;
    btnOff.Down := False;
    SetUpdownImage(btnOff);
    SetUpdownImage(btnPowerOn);

    Exit;
  end;

//  if (btnPowerOn.Down) then begin
      powerON := True;
      SetImageIndikator(IndCmptr, cRed, True);
      VrBlinkLed1.Palette1.High := clMaroon;
      btnLoadProgr.Down := False;
      TOCOS.SendEvenTOCOS(1);

      btnPowerOn.Down := True;
      btnOff.Down := False;
      SetUpdownImage(btnOff);
      SetUpdownImage(btnPowerOn);
//   Timer1.Enabled := True;
//  end;

 
end;

procedure TvTechnicalCtrlPanel.Timer1Timer(Sender: TObject);
begin
  btnLoadProgr.ImageIndex := 1;
  Timer1.Enabled := false;
end;

procedure TvTechnicalCtrlPanel.Timer2Timer(Sender: TObject);
begin
  btnLoadProgr.ImageIndex := 0;
  SetImageIndikator(IndCmptr, cRed, False);
  SetImageIndikator(IndRdyLp, cGreen, True);
  isReadyLP := True;
  btnSysReset.Down := True;
  SetUpdownImage(btnSysReset);
  Timer2.Enabled := False;
end;

procedure TvTechnicalCtrlPanel.btnCheatOnClick(Sender: TObject);
var
  i : Integer;
begin
  btnV1.Down := True;
  btn10.Down := True;
  btn2.Down := True;
  btn3.Down := True;
  btn4.Down := True;
  btn5.Down := True;
  btn6.Down := True;
  for I := 1 to 7 do
  begin
    switch[I] := True;
  end;

  SetImageIndikator(IndCmptr, cRed, True);
  SetImageIndikator(IndCmptr, cRed, False);
  SetImageIndikator(IndRdyLp, cGreen, True);

  VrBlinkLed1.Palette1.High := clMaroon;
  TOCOS.SendEvenTOCOS(1);

  powerON := True;
  isReadyLP := True;
  btnPowerOn.Down := True;
  btnOff.Down := False;
  btnSysOn.Down := True;
  btnSysReset.Down := False;
  SetUpdownImage(btnOff);
  SetUpdownImage(btnPowerOn);
  SetUpdownImage(btnSysOn);
  SetUpdownImage(btnSysReset);
  System_On(true);

  if TOCOS.TOCOSSysON then begin
    TOCOS.vDisplayCtrlPanelBottom.btnOff.ImageIndex := 0;
    TOCOS.vDisplayCtrlPanelBottom.btnWmNonMti.ImageIndex := 0;
    TOCOS.vDisplayCtrlPanelBottom.btnWmMti.ImageIndex := 0;
    TOCOS.vDisplayCtrlPanelBottom.btnWmNonMti.ImageIndex := 1;
    TOCOS.Set_Radar_Off(TOCOS.vDisplay.Map, True);
    TOCOS.SetRadar_type(rtWM_28);
    TOCOS.SetRadar_MTI_Status(FALSE);
  end;

  tocos.SetView_RangeScale(32);
  TOCOS.OBMRight_Reset;

//  Self.Hide;
//  TOCOS.vDisplayCtrlPanelBottom.Hide;
//  TOCOS.vDisplayCtrlPanelLeft.Hide
end;

procedure TvTechnicalCtrlPanel.btnClearScenarioClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 1 to 2 do
    TOCOS.ClearSkenario(i)
end;

procedure TvTechnicalCtrlPanel.btnTorpSimClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnTorpSim.Down) then begin
    {btnPort.ImageIndex := 1;
    btnStb.ImageIndex := 1;
    btnToSupply1.ImageIndex := 1;
    btnToSupply2.ImageIndex := 1;
    btn20Bar1.ImageIndex := 1;
    btn20Bar2.ImageIndex := 1; }
    TOCOS.TOCOSSim := True;
  end
  else begin
    TOCOS.TOCOSSim := False;
    btnTorpSim.Down := False;
    SetUpdownImage(btnTorpSim);
  end;
end;

procedure TvTechnicalCtrlPanel.btnV1Click(Sender: TObject);
begin
//  inherited;
    switch[TRzBmpButton(Sender).Tag] := TRzBmpButton(Sender).Down;
    if cekSwitch then begin
      btnOff.Down := True;
    end
    else begin
      PowerOff;
      btnOff.Down := false;
    end;
      btnPowerOn.Down := false;
      SetUpdownImage(btnOff);
      SetUpdownImage(btnPowerOn);
end;

function TvTechnicalCtrlPanel.cekSwitch: Boolean;
var I : Integer;
begin
  Result := True;
  for I := 1 to 7 do
    if not switch[I] then
      Result := false;
end;

procedure TvTechnicalCtrlPanel.CloseAllForm1Click(Sender: TObject);
begin
  inherited;
  TOCOS.close;
end;

procedure TvTechnicalCtrlPanel.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//  inherited;
  TOCOS := tdc  AS TTorpedoInterface;
end;

procedure TvTechnicalCtrlPanel.btnSysOnClick(Sender: TObject);
begin
  if powerON and isReadyLP then
  begin
    SetUpdownImage(btnSysOn);
    SetUpdownImage(btnSysReset);
    System_On(btnSysOn.Down);

    {set lampu}
    SetImageIndikator(IndToSupply1, cYellow, IndToSup1_on);
    SetImageIndikator(IndToSupply2, cYellow, IndToSup2_on);
    SetImageIndikator(Ind20Bar1 , cYellow, Ind20Bar1_on);
    SetImageIndikator(Ind20Bar2 , cYellow, Ind20Bar2_on);
  end
  else
  begin
    btnSysReset.Down := False;
    btnSysOn.Down := False;
    SetUpdownImage(btnSysReset);
    SetUpdownImage(btnSysOn);
  end;
end;

procedure TvTechnicalCtrlPanel.System_On(Is_on: boolean);
var
  I: integer;
  spbimg : TSpeedButtonImage;

begin
    TOCOS.TOCOSSysON := Is_on;
    {This Form}
    btnExt.Down := Is_on;
    SetUpdownImage(btnExt);
    btnCas.Down := False;
    SetUpdownImage(btnCas);

    SetImageIndikator(IndExt, cGreen, btnExt.Down);
    SetImageIndikator(IndCas, cGreen, btnCas.Down);

    SetImageIndikator(IndPort, cYellow, Is_on);
    IndPort_on  := Is_on;

    SetImageIndikator(IndStb , cYellow, Is_on);
    IndStb_on  := Is_on;

    {Reset Indikator}
    SetImageIndikator(IndToSupply1, cYellow, False);
    SetImageIndikator(IndToSupply2, cYellow, False);
    SetImageIndikator(Ind20Bar1 , cYellow, False);
    SetImageIndikator(Ind20Bar2 , cYellow, False);
    SetImageIndikator(Ind120Bar1 , cYellow, False);
    Ind120Bar1_on := False;
    SetImageIndikator(Ind120Bar2 , cYellow, False);
    Ind120Bar2_on := False;
    SetImageIndikator(IndDoorOpen1 , cYellow, False);
    IndDorrOpn1_on := False;
    SetImageIndikator(IndDoorOpen2 , cYellow, False);
    IndDorrOpn2_on := False;
    SetImageIndikator(IndTorpOn1 , cYellow, False);
    IndTorpOn1_on := False;
    SetImageIndikator(IndTorpOn2 , cYellow, False);
    IndTorpOn2_on := False;
    SetImageIndikator(IndRdyToFire1 , cYellow, False);
    IndRdyToFre1_on := False;
    SetImageIndikator(IndRdyToFire2 , cYellow, False);
    IndRdyToFre2_on := False;

    {Vidoe (LPD) Setting (Form Ctrl Panel Bottom)}
    TOCOS.SetRadar_HeadingMarker(false);
    TOCOS.SetRadar_RangeRing(false);
    TOCOS.Set_Radar_Off(TOCOS.vDisplay.Map, false);

    with TOCOS.vDisplayCtrlPanelBottom do
    begin
      for I := 0 to ComponentCount - 1 do
      begin
        if Components[i] is TSpeedButtonImage then begin
          spbimg := (Components[i] as TSpeedButtonImage);
          spbimg.Down := false;
          SetUpdownImage(spbimg);
        end;
      end;
      if Is_on then
      begin
        btnOff.Click;
        btnRange64.Click;
      end;
    end;

    with TOCOS.vMainCtrlPanel do
    begin
      for I := 0 to ComponentCount - 1 do begin
        if Components[i] is TSpeedButtonImage then begin
          spbimg := (Components[i] as TSpeedButtonImage);
          spbimg.Down := false;
          SetUpdownImage(spbimg);
        end;
      end;
      SystemOff;
    end;

    with TOCOS.vDisplayCtrlPanelLeft do
    begin
      SystemOff;
    end;
end;

procedure TvTechnicalCtrlPanel.PowerOff;
begin

  powerON := False;

  btnLoadProgr.Down := False;
  SetUpdownImage(btnLoadProgr);

  timer2.Enabled := False;

  SetImageIndikator(IndRdyLp, cGreen, False);
  isReadyLP := False;

  btnSysOn.Down := False;
  SetUpdownImage(btnSysOn);

  btnSysReset.Down := False;
  SetUpdownImage(btnSysReset);

  SetUpdownImage(btnOff);
  SetUpdownImage(btnPowerOn);

  SetImageIndikator(IndCmptr, cRed, False);
  VrBlinkLed1.Palette1.High := clRed;

  System_On(False);
end;

procedure TvTechnicalCtrlPanel.QuickStartClick(Sender: TObject);
var
  i : Integer;
  tempIndToSup1_on, tempIndToSup2_on,
  tempInd20Bar1_on, tempInd20Bar2_on : Boolean;
begin
  for i := 1 to 2 do
    TOCOS.ClearSkenario(i);

  tempIndToSup1_on := IndToSup1_on;
  tempInd20Bar1_on := Ind20Bar1_on;
  tempIndToSup2_on := IndToSup2_on;
  tempInd20Bar2_on := Ind20Bar2_on;

  btnV1.Down := True;
  btn10.Down := True;
  btn2.Down := True;
  btn3.Down := True;
  btn4.Down := True;
  btn5.Down := True;
  btn6.Down := True;
  for I := 1 to 7 do
  begin
    switch[I] := True;
  end;

  SetImageIndikator(IndCmptr, cRed, True);
  SetImageIndikator(IndCmptr, cRed, False);
  SetImageIndikator(IndRdyLp, cGreen, True);

  VrBlinkLed1.Palette1.High := clMaroon;
  TOCOS.SendEvenTOCOS(1);

  powerON := True;
  isReadyLP := True;
  btnPowerOn.Down := True;
  btnOff.Down := False;
  btnSysOn.Down := True;
  btnSysReset.Down := False;
  SetUpdownImage(btnOff);
  SetUpdownImage(btnPowerOn);
  SetUpdownImage(btnSysOn);
  SetUpdownImage(btnSysReset);
  System_On(true);

  IndToSup1_on := tempIndToSup1_on;
  Ind20Bar1_on := tempInd20Bar1_on;
  IndToSup2_on := tempIndToSup2_on;
  Ind20Bar2_on := tempInd20Bar2_on;

  SetImageIndikator(IndToSupply1, cYellow, IndToSup1_on);
  SetImageIndikator(Ind20Bar1, cYellow, Ind20Bar1_on);
  SetImageIndikator(IndToSupply2, cYellow, IndToSup2_on);
  SetImageIndikator(Ind20Bar2, cYellow, Ind20Bar2_on);

  if TOCOS.TOCOSSysON then begin
    TOCOS.vDisplayCtrlPanelBottom.btnWmNonMti.Click;
    TOCOS.vDisplayCtrlPanelBottom.btnRange64.Click;
    TOCOS.vDisplayCtrlPanelBottom.btnSurf.Down := True;
    TOCOS.vDisplayCtrlPanelBottom.btnSurf.Click;
  end;
  TOCOS.OBMRight_Reset;
end;

procedure TvTechnicalCtrlPanel.btnOffClick(Sender: TObject);
begin
//  if (btnPowerOn.Down) then btnPowerOn.ImageIndex := 0;
  if not cekSwitch then begin
    btnPowerOn.Down := False;
    btnOff.Down := False;
    SetUpdownImage(btnOff);
    SetUpdownImage(btnPowerOn);

    Exit;
  end;
  PowerOff;

  //Prince
  btnOff.Down := True;
  SetUpdownImage(btnOff);
end;

procedure TvTechnicalCtrlPanel.btnSysResetClick(Sender: TObject);
begin
  if powerON then begin
    TOCOS.SysReset;
    System_On(false);
    btnSysReset.Down := True;
    SetUpdownImage(btnSysReset);
    SetUpdownImage(btnSysOn);
  end
  else
  begin
    btnSysReset.Down := False;
    btnSysOn.Down := False;
    SetUpdownImage(btnSysReset);
    SetUpdownImage(btnSysOn);
  end;
end;

//procedure TvTechnicalCtrlPanel.Reset_Stab_button;
//begin
//
//end;

procedure TvTechnicalCtrlPanel.btnExitAppClick(Sender: TObject);
//var
//  shell : Variant;
begin
  //Close;
  Application.Terminate;
  //  shell := CreateOleObject('Shell.Application');
  //  shell.ShutdownWindows;
end;

procedure TvTechnicalCtrlPanel.btnExtClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then begin
    SetImageIndikator(IndExt ,  cGreen, btnExt.Down);
    SetImageIndikator(IndCas ,  cGreen, btncas.Down);
    btncas.ImageIndex := 0;
  end;
end;

procedure TvTechnicalCtrlPanel.btnLoadProgrClick(Sender: TObject);
begin
  inherited;
  if powerON and not(isReadyLP) then begin
    Timer2.Enabled := True;
    btnLoadProgr.Down := True;

  end
//Prince
  else
  begin
    btnLoadProgr.Down := False;
  end;
  SetUpdownImage(btnLoadProgr);
end;

procedure TvTechnicalCtrlPanel.btnCasClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then begin
    SetImageIndikator(IndExt ,  cGreen, btnExt.Down);
    SetImageIndikator(IndCas ,  cGreen, btncas.Down);
    btnExt.ImageIndex := 0;
  end;
end;
procedure TvTechnicalCtrlPanel.btncloseClick(Sender: TObject);
begin
//  inherited;
   Application.Terminate;
end;

end.



