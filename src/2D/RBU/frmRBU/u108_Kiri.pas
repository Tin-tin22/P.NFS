unit u108_Kiri;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  VrControls,
  VrMeter,
  VrDesign,
  RzBmpBtn,
  Buttons,
  SpeedButtonImage,

  uLibRBU;

type
  Tfrm108_Kiri = class(TForm)
    img1: TImage;
    img2: TImage;
    vrmtr1: TVrMeter;
    imgInd_UNFR2: TImage;
    imgInd_BreakUNFR2: TImage;
    imgAliranBurja: TImage;
    imgPower: TImage;
    imgAliran_Kapal: TImage;
    imgInd_UNFR1: TImage;
    pnl13: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl11: TPanel;
    pnl6: TPanel;
    img12: TImage;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl12: TPanel;
    img19: TImage;
    btnPOWER: TRzBmpButton;
    vrmtr3: TVrMeter;
    img3: TImage;
    img20: TImage;
    imgMode: TImage;
    imgLauncNumb: TImage;
    img13: TImage;
    img25: TImage;
    btnUNFORMER2_Off: TVrBitmapButton;
    btnBreakUNFR2: TRzBmpButton;
    img14: TImage;
    img15: TImage;
    btnUNFORMER2_On: TVrBitmapButton;
    btnUNFORMER1_On: TVrBitmapButton;
    btnUNFORMER1_Off: TVrBitmapButton;
    img10: TImage;
    btnBreakUNFR1: TRzBmpButton;
    pnl5: TPanel;
    pnl7: TPanel;
    img16: TImage;
    img17: TImage;
    img18: TImage;
    imgSelMode: TImage;
    imgSelLauncher: TImage;
    img22: TImage;
    img27: TImage;
    pnl8: TPanel;
    btn1: TVrBitmapButton;
    btnMode: TVrBitmapButton;
    imgNumbLauncher: TImage;
    btn108R: TVrBitmapButton;
    lbl1: TLabel;
    btn2: TVrBitmapButton;
    lbl2: TLabel;
    btn3: TVrBitmapButton;
    img4: TImage;
    imgInd_BreakUNFR1: TImage;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    procedure btnUNFORMER1_OffClick(Sender: TObject);
    procedure btnBreakUNFR2Click(Sender: TObject);
    procedure btnUNFORMER2_OnClick(Sender: TObject);
    procedure btnUNFORMER2_OffClick(Sender: TObject);
    procedure btnPOWERClick(Sender: TObject);
    procedure btnUNFORMER1_OnClick(Sender: TObject);
    procedure btnBreakUNFR1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure btn108RClick(Sender: TObject);
    procedure imgLauncNumbClick(Sender: TObject);
    procedure imgModeClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
  btlonch, btmode     : Boolean;
  launcNumb, ModeNumb : Integer;
  RightFireMode       : TfireMode;
    { Public declarations }
  end;

//var
//  frm108: Tfrm108;

implementation
uses
    uRBU_Manager;
{$R *.dfm}

procedure Tfrm108_Kiri.btn108RClick(Sender: TObject);
begin
  Hide;
end;

procedure Tfrm108_Kiri.btn1Click(Sender: TObject);
begin
   btlonch := not btlonch;
   SetChangeImageIndikator(imgSelLauncher,path_image_108 +'RedInd.bmp', path_image_108 +'OffInd.bmp', btlonch);
end;

procedure Tfrm108_Kiri.btn2Click(Sender: TObject);
begin
  if Caption = '108 Kanan' then
      uRBU_Manager.RBU_MAnager.frmPanelFireR.Show
  else
    uRBU_Manager.RBU_MAnager.frmPanelFireL.Show;
end;

procedure Tfrm108_Kiri.btnBreakUNFR1Click(Sender: TObject);
begin
//   SetImageIndikatorwithButton(imgInd_BreakUNFR1, btnBreakUNFR1.Down);
  SetChangeImageIndikator(imgInd_BreakUNFR1 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR1.Down);
end;

procedure Tfrm108_Kiri.btnBreakUNFR2Click(Sender: TObject);
begin
//  SetImageIndikatorwithButton(imgInd_BreakUNFR2, btnBreakUNFR2.Down);
  SetChangeImageIndikator(imgInd_BreakUNFR2 ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btnBreakUNFR2.Down);

end;

procedure Tfrm108_Kiri.btnModeClick(Sender: TObject);
begin
   btmode := not btmode;
   SetChangeImageIndikator(imgSelMode ,path_image_108 +'YellowInd.bmp', path_image_108 +'OffInd.bmp', btmode);

end;

procedure Tfrm108_Kiri.btnPOWERClick(Sender: TObject);
begin
  SetChangeImageIndikator(imgPower,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', btnPOWER.Down);
end;

procedure Tfrm108_Kiri.btnUNFORMER1_OffClick(Sender: TObject);
begin
   imgInd_UNFR1.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
end;

procedure Tfrm108_Kiri.btnUNFORMER1_OnClick(Sender: TObject);
begin
   imgInd_UNFR1.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');
end;

procedure Tfrm108_Kiri.btnUNFORMER2_OffClick(Sender: TObject);
begin
   imgInd_UNFR2.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');
end;

procedure Tfrm108_Kiri.btnUNFORMER2_OnClick(Sender: TObject);
begin
   imgInd_UNFR2.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');
end;

procedure Tfrm108_Kiri.FormCreate(Sender: TObject);
begin
   btlonch   := False;
   btmode    := False;
   launcNumb := 1;
   ModeNumb  := 1;
end;

procedure Tfrm108_Kiri.FormShow(Sender: TObject);
begin
 SetChangeImageIndikator(imgAliranBurja,path_image_108 +'lampu indikator on.bmp', path_image_108 +'lampu indikator off.bmp', StatusAliranBurja);

end;

procedure Tfrm108_Kiri.imgModeClick(Sender: TObject);
begin
   ModeNumb := ModeNumb + 1;

  if ModeNumb = 4 then
    ModeNumb := 1;

  case ModeNumb of
    1  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Pengisian.bmp');
    2  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Pengarahan.bmp');
    3  : imgMode.Picture.LoadFromFile(path_image_108 + 'ImgMode_Penembakan.bmp');
  end;
end;

procedure Tfrm108_Kiri.imgLauncNumbClick(Sender: TObject);
begin
  launcNumb := launcNumb + 1;

  if launcNumb = 13 then
    launcNumb := 1;

  case launcNumb of
    1  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_01.bmp');
    2  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_02.bmp');
    3  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_03.bmp');
    4  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_04.bmp');
    5  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_05.bmp');
    6  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_06.bmp');
    7  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_07.bmp');
    8  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_08.bmp');
    9  : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_09.bmp');
    10 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_10.bmp');
    11 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_11.bmp');
    12 : imgLauncNumb.Picture.LoadFromFile(path_image_108 + 'Launcher_12.bmp');
  end;


  case launcNumb of
    1  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher1.bmp');
    2  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher2.bmp');
    3  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher3.bmp');
    4  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher4.bmp');
    5  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher5.bmp');
    6  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher6.bmp');
    7  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher7.bmp');
    8  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher8.bmp');
    9  : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher9.bmp');
    10 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher10.bmp');
    11 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher11.bmp');
    12 : imgNumbLauncher.Picture.LoadFromFile(path_image_108 + 'img_Launcher12.bmp');
  end;

end;

end.
