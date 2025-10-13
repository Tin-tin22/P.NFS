unit ufWCCPanelBawah2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrDesign, StdCtrls, ExtCtrls, Buttons,
  SpeedButtonImage, ImgList, VrRotarySwitch, uLibWCCClassNew, uLibWCCKu,
  uBaseConstan, uTCPDatatype, {xpPanel,} uBaseDataType, uBaseFunction, uDetected,


  ufWCCPanelAtas2,
  ufQEK, VrScope, xpPanel;

type
  TfrmWCCPanelBawah2 = class(TfrmQEK)
    Panel7: TPanel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    btnFC2_B: TSpeedButtonImage;
    btnGENFC2: TSpeedButtonImage;
    btnFC3_B: TSpeedButtonImage;
    btnGENFC3: TSpeedButtonImage;
    btnBLINDBOMB: TSpeedButtonImage;
    btnINDBOMB: TSpeedButtonImage;
    SpeedButtonImage84: TSpeedButtonImage;
    SpeedButtonImage85: TSpeedButtonImage;
    SpeedButtonImage86: TSpeedButtonImage;
    Bevel55: TBevel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    vThrowOff: TVrRotarySwitch;
    Panel6: TPanel;
    Bevel8: TBevel;
    btnG1FC1ASS: TSpeedButtonImage;
    btnG2FC1ASS: TSpeedButtonImage;
    btnG3FC1ASS: TSpeedButtonImage;
    btnTVFC1: TSpeedButtonImage;
    Label62: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label69: TLabel;
    Panel8: TPanel;
    Label31: TLabel;
    Timer1: TTimer;
    Button1: TButton;
    Panel1: TPanel;
    btnTV: TSpeedButtonImage;
    btnTEST: TSpeedButtonImage;
    btnPREACT: TSpeedButtonImage;
    btnNGS: TSpeedButtonImage;
    btnAIRSURF: TSpeedButtonImage;
    tmrGun: TTimer;
    Panel2: TPanel;
    bterase: TVrBitmapButton;
    bt7: TVrBitmapButton;
    bt4: TVrBitmapButton;
    btinsert: TVrBitmapButton;
    bt8: TVrBitmapButton;
    bt5: TVrBitmapButton;
    bt9: TVrBitmapButton;
    bt6: TVrBitmapButton;
    Label32: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    bt2: TVrBitmapButton;
    bt3: TVrBitmapButton;
    btplus: TVrBitmapButton;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    bt1: TVrBitmapButton;
    Label12: TLabel;
    bt0: TVrBitmapButton;
    btmin: TVrBitmapButton;
    Label2: TLabel;
    Label13: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    img1: TImage;
    tmrShowsplash: TTimer;
    btn1: TButton;
    btn3: TButton;
    shp1: TShape;
    btn4: TButton;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnlGun3Fire1: TPanel;
    lbl1: TLabel;
    bvl1: TBevel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    btnG3ATTN_S: TSpeedButtonImage;
    btnG3FIRE_S: TSpeedButtonImage;
    shp2: TShape;
    lmpG3INRANGE: TImage;
    lmpG3ASDFC3: TImage;
    lmpG3ASDFC2: TImage;
    pnlAssFCtoGUN3: TPanel;
    lbl5: TLabel;
    bvl2: TBevel;
    btnG1FC3ASS: TSpeedButtonImage;
    btnG2FC3ASS: TSpeedButtonImage;
    btnG3FC3ASS: TSpeedButtonImage;
    btnTVFC3: TSpeedButtonImage;
    pnlAssFCtoGUN2: TPanel;
    bvl3: TBevel;
    lbl6: TLabel;
    btnG2FC2ASS: TSpeedButtonImage;
    btnG1FC2ASS: TSpeedButtonImage;
    btnG3FC2ASS: TSpeedButtonImage;
    btnTVFC2: TSpeedButtonImage;
    pnlFC2: TPanel;
    lbl7: TLabel;
    bvl4: TBevel;
    btnFC2STO: TSpeedButtonImage;
    btnFC2AFS: TSpeedButtonImage;
    lbl8: TLabel;
    lmpFC2RDY: TImage;
    btnFC2SBS: TSpeedButtonImage;
    pnlFC3: TPanel;
    lbl9: TLabel;
    bvl5: TBevel;
    btnFC3STO: TSpeedButtonImage;
    btnFC3AFS: TSpeedButtonImage;
    lbl10: TLabel;
    lmpFC3RDY: TImage;
    btnFC3SBS: TSpeedButtonImage;
    pnlAssFCtoGUN4: TPanel;
    btnG2FC4ASS: TSpeedButtonImage;
    btnG3FC4ASS: TSpeedButtonImage;
    btnG1FC4ASS: TSpeedButtonImage;
    bvl22: TBevel;
    lbl11: TLabel;
    checkbtn: TRadioButton;
    pnl6: TPanel;
    Image5: TImage;
    btnSplashCorr: TSpeedButtonImage;
    btnGenCorr: TSpeedButtonImage;
    btnRESOBM_RIGHT: TSpeedButtonImage;
    bvl6: TBevel;
    bvl7: TBevel;
    bvl8: TBevel;
    bvl9: TBevel;
    pnl7: TPanel;
    pnl8: TPanel;
    lbl12: TLabel;
    bvl10: TBevel;
    btnG2ATTN_S: TSpeedButtonImage;
    shp3: TShape;
    btnG2FIRE_S: TSpeedButtonImage;
    lbl13: TLabel;
    lmpG2INRANGE: TImage;
    lbl14: TLabel;
    lbl15: TLabel;
    lmpG2ASDFC2: TImage;
    lmpG2ASDFC3: TImage;
    lbl16: TLabel;
    bvl11: TBevel;
    btnG4ATTN_S: TSpeedButtonImage;
    shp4: TShape;
    lbl17: TLabel;
    lmpG1INRANGE: TImage;
    lbl18: TLabel;
    lmpG1ASDFC3: TImage;
    lmpG1ASDFC2: TImage;
    lbl19: TLabel;
    btnG1FIRE_S: TSpeedButtonImage;
    pnl9: TPanel;
    lbl20: TLabel;
    bvl12: TBevel;
    btn5: TSpeedButtonImage;
    shp5: TShape;
    btnGUN1_FIRE: TSpeedButtonImage;
    lmp1: TImage;
    lbl21: TLabel;
    lmp2: TImage;
    lmp3: TImage;
    lbl22: TLabel;
    lbl23: TLabel;
    Panel3: TPanel;
    AirSurfPage: TxpPanel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Andu2093: TEdit;
    Edit5: TEdit;
    Andu2123: TEdit;
    Andu2113: TEdit;
    Andu2103: TEdit;
    Andu2073: TEdit;
    Andu2063: TEdit;
    Andu2053: TEdit;
    Andu2043: TEdit;
    Andu2033: TEdit;
    Andu2023: TEdit;
    Edit4: TEdit;
    Andu2122: TEdit;
    Andu2112: TEdit;
    Andu2102: TEdit;
    Andu2092: TEdit;
    Andu2072: TEdit;
    Andu2062: TEdit;
    Andu2052: TEdit;
    Andu2042: TEdit;
    Andu2032: TEdit;
    Andu2022: TEdit;
    Andu2021: TEdit;
    Andu2031: TEdit;
    Andu2041: TEdit;
    Andu2051: TEdit;
    Andu2061: TEdit;
    Andu2071: TEdit;
    Andu2101: TEdit;
    Andu2111: TEdit;
    Andu2121: TEdit;
    Edit2: TEdit;
    Andu2091: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    NgsPage: TxpPanel;
    Andu301: TEdit;
    Andu302: TEdit;
    Andu303: TEdit;
    Andu304: TEdit;
    Andu305: TEdit;
    Andu306: TEdit;
    Andu307: TEdit;
    Andu308: TEdit;
    Andu309: TEdit;
    Andu310: TEdit;
    Andu311: TEdit;
    Andu312: TEdit;
    Andu313: TEdit;
    Andu314: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    Edit49: TEdit;
    Edit50: TEdit;
    Edit51: TEdit;
    Edit52: TEdit;
    Edit53: TEdit;
    Edit1: TEdit;
    PreActPage: TxpPanel;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit21: TEdit;
    Andu101: TEdit;
    Andu102: TEdit;
    Andu103: TEdit;
    Andu104: TEdit;
    Andu105: TEdit;
    Andu106: TEdit;
    Andu108: TEdit;
    Andu109: TEdit;
    Andu107: TEdit;
    Andu111: TEdit;
    Andu112: TEdit;
    Andu113: TEdit;
    Andu115: TEdit;
    TestPage: TxpPanel;
    Test02: TEdit;
    Test03: TEdit;
    Test04: TEdit;
    Test05: TEdit;
    Test06: TEdit;
    Test07: TEdit;
    Test08: TEdit;
    Test09: TEdit;
    Test10: TEdit;
    Test11: TEdit;
    Test12: TEdit;
    Test13: TEdit;
    Test14: TEdit;
    Test01: TEdit;
    Test15: TEdit;
    tvpage: TxpPanel;
    xpPanel1: TxpPanel;
    valueinput: TEdit;
    codeinput: TEdit;
    lmp4: TImage;
    lmp5: TImage;
    lmp6: TImage;
    lmp7: TImage;
    lmp8: TImage;
    lmp9: TImage;
    lmp10: TImage;
    lmp11: TImage;
    lmp13: TImage;
    lmp14: TImage;
    mmo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnG1FC1ASSClick(Sender: TObject);
    procedure btnG2FC1ASSClick(Sender: TObject);
    procedure btnG3FC1ASSClick(Sender: TObject);
    procedure btnTVFC1Click(Sender: TObject);
    procedure btnG1FC2ASSClick(Sender: TObject);
    procedure btnG2FC2ASSClick(Sender: TObject);
    procedure btnG3FC2ASSClick(Sender: TObject);
    procedure btnTVFC2Click(Sender: TObject);
    procedure btnG1FC3ASSClick(Sender: TObject);
    procedure btnG2FC3ASSClick(Sender: TObject);
    procedure btnG3FC3ASSClick(Sender: TObject);
    procedure btnTVFC3Click(Sender: TObject);
    procedure btnG1FC4ASSClick(Sender: TObject);
    procedure btnG2FC4ASSClick(Sender: TObject);
    procedure btnG3FC4ASSClick(Sender: TObject);
    procedure btnFC2SBSClick(Sender: TObject);
    procedure btnFC2STOClick(Sender: TObject);
    procedure btnFC2AFSClick(Sender: TObject);
    procedure btnFC3STOClick(Sender: TObject);
    procedure btnFC3AFSClick(Sender: TObject);
    procedure btnFC3SBSClick(Sender: TObject);
    procedure btnG1FIRE_SClick(Sender: TObject);
    procedure btnG2ATTN_SClick(Sender: TObject);
    procedure btnG2FIRE_SClick(Sender: TObject);
    procedure btnG3ATTN_SClick(Sender: TObject);
    procedure btnG3FIRE_SClick(Sender: TObject);
    procedure btnSplashCorrClick(Sender: TObject);
    procedure btnGenCorrClick(Sender: TObject);
    procedure btnRESOBM_RIGHTClick(Sender: TObject);
    procedure btnBLINDBOMBClick(Sender: TObject);
    procedure btnINDBOMBClick(Sender: TObject);
    procedure btnGENFC2Click(Sender: TObject);
    procedure btnGENFC3Click(Sender: TObject);
    procedure btnFC2_BClick(Sender: TObject);
    procedure btnFC3_BClick(Sender: TObject);
    procedure btnPREACTClick(Sender: TObject);
    procedure btnAIRSURFClick(Sender: TObject);
    procedure btnNGSClick(Sender: TObject);
    procedure btnTESTClick(Sender: TObject);
    procedure btnTVClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure bteraseClick(Sender: TObject);
    procedure bt0Click(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure bt2Click(Sender: TObject);
    procedure bt3Click(Sender: TObject);
    procedure bt4Click(Sender: TObject);
    procedure bt5Click(Sender: TObject);
    procedure bt6Click(Sender: TObject);
    procedure bt7Click(Sender: TObject);
    procedure bt8Click(Sender: TObject);
    procedure bt9Click(Sender: TObject);
    procedure btplusClick(Sender: TObject);
    procedure btminClick(Sender: TObject);
    procedure btinsertClick(Sender: TObject);
    procedure Reset_Andu_Button;
    procedure Reset_AssignGun2FC4;
    procedure Button1Click(Sender: TObject);
    procedure InsertIntoAndu(const code: string; const val: double);

    procedure vThrowOffChange(Sender: TObject);
    procedure tmrGunTimer(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure SpeedButtonImage86Click(Sender: TObject);
    procedure tmrBTKTimer(Sender: TObject);
    procedure SpeedButtonImage85Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnG3FIRE_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG2FIRE_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG4ATTN_SMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG4ATTN_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG2ATTN_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG3ATTN_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG2ATTN_SMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG3ATTN_SMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButtonImage84Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure tmrShowsplashTimer(Sender: TObject);
    procedure Panel8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnG1ATTN_SMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnG1ATTN_SMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    IsBtnFire1_Ready,
    IsBtnFire2_Ready,
    IsBtnFire3_Ready : Boolean;

    IsStartingFC2, IsStartingFC3: boolean;
    FC2_COUNTER, FC3_COUNTER: Integer;
    AnduCode : string;
    FInputOnOff: boolean;



    function SplitPage(const s: string): integer;
    function SplitEditName(const s: string): string;

    function GetLine(const aCode: string): string;
    function GetValue(const aCode: string): string;
    function ValidateCode(const aCode: string): boolean;
    function ValidateValue(const aCode, aVal: string): boolean;
    function CekOnOff(const aCode: string): boolean;
  public
    { Public declarations }

    b, r, h, c, s: double;
    fA2: TfrmWCCPanelAtas2;

    // B-scope
    CounterShow,
    CounterDel : Integer;

    StartCountshowSplash,
    StartCountDelSplash : Boolean;

    procedure PreActShow;
    procedure AirSurfShow;
    procedure NgsShow;
    procedure TestPageShow;
    procedure getcode;
    procedure ApplyNumber(text: string);
    procedure insertvalue;
    procedure ShowAnduData;
    procedure tvshow;
    procedure SetOffBtnAndIndikator; override;
  end;

const

    onoff : array [1..2] of string = ('ON','OFF');

    C_CodeTypeLength = 30;
    listcode : array [1..C_CodeTypeLength] of string =
           ('101','102','103','104','105','106','107','108','109','112','113',
            '2101','2102','2103',
            '2111','2112','2113',
            '2121','2122','2123',
            '301','302','303','304','305','306','307','308','309','310');

    C_LineLength = 24;
    thecode : array [1..C_LineLength] of string =
           ('101','102','103','104','105','106','107','108','109','112','113',
            '210','211','212',
            '301','302','303','304','305','306','307','308','309','310');
    theline : array [1..C_LineLength] of string =
           ('101*BAL WIND SPEED   KTS',
            '102*BAL WIND DIR     DEG',
            '103*BAL TEMP         CEN',
            '104*AIR PRESSURE     MB',
            '105*MUZZLE VELOCITY 1 MPS',
            '106*MUZZLE VELOCITY 2 MPS',
            '107*MUZZLE VELOCITY 3 MPS',
            '108*LATITUDE        DEG',
            '109*HEIGHT AIR FOR LT FT',
            '112*DATA LOGGING       ',
            '113*QUICK OPER TEST    ',

            '210*LNCOR  MIL',
            '211*RGCOR YDS',
            '212*ELCOR MIL',

            '301*TGT BEARING     DEG',
            '302*TGT RANGE       YDS',
            '303*TGT HEIGHT      FT',
            '304*TGT/CRNT COURSE DEG',
            '305*TGT/CRNT SPEED  KTS',
            '306*OTL             DEG',
            '307*ADD/DROP WRT OTLYDS',
            '308*RGT/LEFT WRT OTLYDS',
            '309*OFF SET BEARING DEG',
            '310*OFF SET RANGE   YDS');

implementation

uses
  ufWCCTengah, ufWCCPanelBawah,  uAnduNala, uLabelDisplay, Types, Math, uLibTDCTracks, uTDCConstan,
   uWCCmanager, ufBScope;
const TimeofSplashShown = 15;
{$R *.dfm}

procedure TfrmWCCPanelBawah2.FormCreate(Sender: TObject);
begin
  inherited;
  codeinput.Focused ;
  tvpage.Visible :=true;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=false;

  tmrGun.Enabled := true;
  Timer1.Enabled := True;

  CounterShow:= 0;
  CounterDel := 0;
  tmrShowsplash.Enabled :=False;

end;

function TfrmWCCPanelBawah2.SplitPage(const s: string): integer;
begin
  result := StrToInt(Copy(s, 0, 1));
end;

function TfrmWCCPanelBawah2.SplitEditName(const s: string): string;
begin
  result := Copy(s, 5, Length(s) - 1);
end;

function TfrmWCCPanelBawah2.GetLine(const aCode: string): string;
var tCode: string;
    i: integer;
begin
  result := '';

  tCode := Copy(aCode, 0, 3);
  for i:=1 to C_LineLength do begin
    if thecode[i] = tCode then result := theline[i];
  end;
end;

function TfrmWCCPanelBawah2.GetValue(const aCode: string): string;
var nm  : string;
    i   : integer;
    tbox: TEdit;
begin
  result := '';

  for i := 0 to ComponentCount-1 do
    if Components[i] is TEdit then begin
      tbox := (Components[i] as TEdit);
      nm := LowerCase(SplitEditName(tbox.Name));

      if nm = aCode then
        result := tbox.Text;
        
    end;
end;

function TfrmWCCPanelBawah2.ValidateCode(const aCode: string): boolean;
var i: integer;
begin
  result := false;

  for i:=1 to C_CodeTypeLength do
    if listcode[i] = aCode then result := true;
end;

function TfrmWCCPanelBawah2.ValidateValue(const aCode, aVal: string): boolean;
var val: single;
    cod : integer;
    //part1, part2: string;
    //shour, smin, ssec: string;
    //ihour, imin, isec: integer;
begin
  result := false;

  cod := StrToInt(Copy(aCode, 0, 3));
  try
    {if cod = 215 then begin  //waktu

    end
    else begin
      if (cod = 210) or (cod = 308) then begin
        part1 := Copy(aVal, 0, 1);
        part2 := Copy(aVal, 2, Length(aVal) - 1);
      end
      else
        part2 :=  aVal;
     }
      val := StrToFloat(aVal);
    //end;
  except
    exit;
  end;

  case cod of
    101: if (val >= 1) and (val <= 100) then result := true;
    102: if (val >= 0) and (val <= 359) then result := true;
    103: if (val >= -15) and (val <= 45) then result := true;
    104: if (val >= 960) and (val <= 1066) then result := true;
    105,106,107: if (val >= 700) and (val <= 1200) then result := true;
    108: if (val >= -80) and (val <= 80) then result := true;
    109: if (val >= 0) and (val <= 999) then result := true;

    210: if (val >= 0) and (val <= 100) then result := true;
    211: if (val >= -2000) and (val <= 2000) then result := true;
    212: if (val >= -100) and (val <= 100) then result := true;

    301: if (val >= 0) and (val <= 359.9) then result := true;  // degree
    302: if (val >= 0) and (val <= 32000) then result := true;  // yards
    303: if (val >= 0) and (val <= 1500) then result := true;   // feet
    304: if (val >= 0) and (val <= 359) then result := true;    // degree
    305: if (val >= 0) and (val <= 99.9) then result := true;   // knot
    306: if (val >= 0) and (val <= 359) then result := true;    // degree
    307: if (val >= -2000) and (val <= 2000) then result := true;  // yard
    308: if (val >= -2000) and (val <= 2000) then result := true;
    309: if (val >= 0) and (val <= 359.9) then result := true;  //degree
    310: if (val >= 0) and (val <= 32000) then result := true;
  end;
end;

function TfrmWCCPanelBawah2.CekOnOff(const aCode: string): boolean;
begin
  if (aCode = 'ON') or (aCode = 'OFF') then result := true
  else result := false;
end;

//ANDU
procedure TfrmWCCPanelBawah2.Panel7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   if ssShift in Shift then
   begin
     btn1.Visible := True;
     btn3.Visible := True;
     Button1.Visible := True;
     btn4.Visible := True;
   end
   else
   begin
     btn1.Visible := false;
     btn3.Visible := false;
     Button1.Visible := false;
     btn4.Visible := False;
   end;
end;

procedure TfrmWCCPanelBawah2.Panel8MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  rimDown := False;
end;

procedure TfrmWCCPanelBawah2.PreActShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=true;
  preactpage.left:=11;
  preactpage.Top :=14;
  testpage.Visible :=false;
end;

procedure TfrmWCCPanelBawah2.AirSurfShow ;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=true;
  airsurfpage.left:=11;
  airsurfpage.Top :=14;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=false;
end;

procedure TfrmWCCPanelBawah2.TestPageShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=true;
  testpage.left:=11;
  testpage.Top :=14;
end;

procedure TfrmWCCPanelBawah2.NgsShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=true;
  ngspage.left:=11;
  ngspage.Top :=14;
  preactpage.Visible :=false;
  testpage.Visible :=false;
end;

procedure TfrmWCCPanelBawah2.tvshow ;
begin
  tvpage.Visible :=true;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  tvpage.left:=11;
  tvpage.Top :=14;
  preactpage.Visible :=false;
  testpage.Visible :=false;
end;

procedure TfrmWCCPanelBawah2.getcode;
var page : integer;
    tCode, tLine, tValue : string;
begin
  if codeinput.Text = '' then exit;

  tCode := codeinput.Text ;

  if ValidateCode(tCode) then begin
    AnduCode := tCode;

    tLine := GetLine(AnduCode);
    tValue := GetValue(AnduCode);
    if tLine <> '' then begin
      codeinput.Text := tLine + ' > ';
      checkbtn.Checked := true;

      FInputOnOff := CekOnOff(tValue);
      if FInputOnOff then valueinput.Text := tValue;

      page := SplitPage(AnduCode);
      case page of
        1: PreActShow;
        2: AirSurfShow;
        3: NgsShow;
        4: TestPageShow;
        5: tvshow;
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.ApplyNumber(text: string);
begin
  if tvpage.Visible then Exit; // added by bagus

  if checkbtn.Checked =true then begin
    if FInputOnOff then begin
      if text = '+' then valueinput.Text := 'ON'
      else if text = '-' then valueinput.Text := 'OFF';
    end
    else
      valueinput.Text := valueinput.Text + text;
  end
  else begin
    CodeInput.Text := CodeInput.Text + text;
    getcode;
  end;
end;

procedure TfrmWCCPanelBawah2.SetOffBtnAndIndikator;
var i: integer;
  bmp: TBitmap;
  nm, s : string;
begin
  inherited;
end;

procedure TfrmWCCPanelBawah2.ShowAnduData;
var rng, brg : Double;
Gun : TGun;
begin
  WCCInterface.UpdateAnduData;

  Andu2021.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][1].ToFlooredString;
  Andu2031.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][1].ToFlooredString;
  Andu2041.Text := WCCInterface.WCCAndu.Page_2[C_FCHeight][1].ToFlooredString;

  Andu2061.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][1].ToFlooredString;
  Andu2071.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][1].ToFlooredString;

  Andu2022.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][2].ToFlooredString;
  Andu2032.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][2].ToFlooredString;
  Andu2042.Text := WCCInterface.WCCAndu.Page_2[C_FCHeight][2].ToFlooredString;

  Andu2062.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][2].ToFlooredString;
  Andu2072.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][2].ToFlooredString;

//  if WCCInterface.FC2.IsDoingIndBomb then begin
//    Andu309.Text := FloatToStr(WCCInterface.IndBombData.b);
//    Andu310.Text := FloatToStr(WCCInterface.IndBombData.r);
//  end;

  Andu2023.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][3].ToFlooredString;
  Andu2033.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][3].ToFlooredString;
  Andu2043.Text := WCCInterface.WCCAndu.Page_2[C_FCHeight][3].ToFlooredString;
  Andu2063.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][3].ToFlooredString;
  Andu2073.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][3].ToFlooredString;

  {if WCCInterface.Gun1.AssignTo <> nil then Andu2091.Text := IntToStr(WCCInterface.Gun1.TOF)
  else Andu2091.Text := '';
  if WCCInterface.Gun2.AssignTo <> nil then Andu2092.Text := IntToStr(WCCInterface.Gun2.TOF)
  else Andu2092.Text := '';
  if WCCInterface.Gun3.AssignTo <> nil then Andu2093.Text := IntToStr(WCCInterface.Gun3.TOF)
  else Andu2093.Text := '';}

  // TOF
  Andu2091.Text := WCCInterface.WCCAndu.Page_2[C_TOF][1].ToString;
  Andu2092.Text := WCCInterface.WCCAndu.Page_2[C_TOF][2].ToString;
  Andu2093.Text := WCCInterface.WCCAndu.Page_2[C_TOF][3].ToString;

  if WCCInterface.Gun1.AssignTo = nil then Andu2091.Text := '';
  if WCCInterface.Gun2.AssignTo = nil then Andu2092.Text := '';
  if WCCInterface.Gun3.AssignTo = nil then Andu2093.Text := '';

  Andu115.Text := Format('%3.1f',[WCCInterface.xSHIP.Speed]);

  if WCCInterface.FC2.IsDoingIndBomb then begin
    Andu313.Text :=  WCCInterface.WCCAndu.Page_3[C_Gen_Tgt_Bearing].ToString;
    Andu314.Text :=  WCCInterface.WCCAndu.Page_3[C_Gen_Tgt_Range].ToString;
  end;
end;

//**********************************************//
//      ASSIGNMENT PANEL                        //
//**********************************************//
procedure TfrmWCCPanelBawah2.btnG1FC1ASSClick(Sender: TObject);
var fB: TfrmWCCPanelBawah;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    fB := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);

    if self.WCCInterface.AssignGunToFC(1, 1) then
    begin
      BtnC.UpdateImage(fb.lmpG1ASDFC1, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(23);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,1) then begin
        BtnC.UpdateImage(fB.lmpG1ASDFC1, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(24);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG2FC1ASSClick(Sender: TObject);
var fB: TfrmWCCPanelBawah;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    fB := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);

    if self.WCCInterface.AssignGunToFC(2, 1) then
    begin
      BtnC.UpdateImage(fb.lmpG2ASDFC1, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(25);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,1) then begin
        BtnC.UpdateImage(fb.lmpG2ASDFC1, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(26);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG3FC1ASSClick(Sender: TObject);
var fB: TfrmWCCPanelBawah;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    fB := TfrmWCCPanelBawah(WCCInterface.frmWCCBawah1);

    if self.WCCInterface.AssignGunToFC(3, 1) then
    begin
      BtnC.UpdateImage(fb.lmpG3ASDFC1, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(27);
    end
    else
    begin
      if WCCInterface.DeAssignGun(3,1) then begin
        BtnC.UpdateImage(fb.lmpG3ASDFC1, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(28);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnTVFC1Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), sgreenBOX);
  end;
end;

procedure TfrmWCCPanelBawah2.btnG1FC2ASSClick(Sender: TObject);
//var a : TRect;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 2) then
    begin
      BtnC.UpdateImage(self.lmpG1ASDFC2, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(29);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,2) then begin
       BtnC.UpdateImage(self.lmpG1ASDFC2, BtnC.sgreenROUND_Off);
       BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
       {LOG}
        WCCInterface.SendEvenWCC_120mm(30);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG2FC2ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin                                    
    if self.WCCInterface.AssignGunToFC(2, 2) then
    begin
      BtnC.UpdateImage(self.lmpG2ASDFC2, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(31);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,2) then begin
        BtnC.UpdateImage(self.lmpG2ASDFC2, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(32);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG3FC2ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(3, 2) then
    begin
      BtnC.UpdateImage(self.lmpG3ASDFC2, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(33);
    end
    else
    begin
      if WCCInterface.DeAssignGun(3,2) then begin
        BtnC.UpdateImage(self.lmpG3ASDFC2, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(34);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnTVFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), sgreenBOX);
  end;
end;

procedure TfrmWCCPanelBawah2.btnG1FC3ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 3) then
    begin
      BtnC.UpdateImage(self.lmpG1ASDFC3, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(35);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,3) then begin
        BtnC.UpdateImage(self.lmpG1ASDFC3, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(36);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG2FC3ASSClick(Sender: TObject);
var fA2: TfrmWCCPanelAtas2;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(2, 3) then
    begin
      BtnC.UpdateImage(self.lmpG2ASDFC3, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(36);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,3) then begin
        BtnC.UpdateImage(self.lmpG2ASDFC3, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(37);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG3FC3ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(3, 3) then
    begin
      BtnC.UpdateImage(self.lmpG3ASDFC3, BtnC.sgreenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(38);
    end
    else
    begin
      if WCCInterface.DeAssignGun(3,3) then begin
        BtnC.UpdateImage(self.lmpG3ASDFC3, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(39);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnTVFC3Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), sgreenBOX);
  end;
end;

procedure TfrmWCCPanelBawah2.Reset_AssignGun2FC4;
begin
  btnG1FC4ASS.Down := False;
  btnG2FC4ASS.Down := False;
  btnG3FC4ASS.Down := False;

  BtnC.UpdateBtnImage(btnG1FC4ASS, BtnC.sgreenBOX_Off);
  BtnC.UpdateBtnImage(btnG2FC4ASS, BtnC.sgreenBOX_Off);
  BtnC.UpdateBtnImage(btnG3FC4ASS, BtnC.sgreenBOX_Off);
end;

procedure TfrmWCCPanelBawah2.btnG1FC4ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  //BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 4) then
    begin
      //self.Reset_AssignGun2FC4;
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,4) then begin
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG2FC4ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  //BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(2, 4) then
    begin
      //self.Reset_AssignGun2FC4;
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,4) then begin
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnG3FC4ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  //BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(3, 4) then
    begin
      //self.Reset_AssignGun2FC4;
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(3,4) then begin
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sgreenBOX_Off);
      end;
    end;
  end;
end;

//**********************************************//
//      SURFACE FIRE & CONTROL PANEL            //
//**********************************************//

procedure TfrmWCCPanelBawah2.btnFC2SBSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(2) then exit;
    if WCCInterface.SetDeAssign_FC(2) then begin
      BtnC.UpdateButton(btnFC2SBS, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC2AFS, TBSpring, sGreenBOX, False);
      BtnC.UpdateImage(lmpFC2RDY, BtnC.sgreenROUND_Off);
      BtnC.UpdateButton(btnBLINDBOMB, TBSpring, sGreenBOX, False);
      BtnC.UpdateButton(btnINDBOMB, TBSpring, sGreenBOX, False);
      BtnC.UpdateButton(btnGENFC2, TBSpring, sOrangeBOX, False);

      if WCCInterface.FC2.IsDoingBlindBomb then
      begin
        WCCInterface.unDoBlindBomb;
        WCCInterface.FC2.IsDoingBlindBomb := false;
      end;
      if WCCInterface.FC2.IsDoingIndBomb then
      begin
        WCCInterface.unDoIndirectBomb;
        WCCInterface.FC2.IsDoingIndBomb   := false;
      end;
      if WCCInterface.FC2.GenFix then
        WCCInterface.FC2.GenFix           := false;

      WCCInterface.ShowBScope(2, btnFC2_B.Down, true);
      WCCInterface.ShowBScope(3, btnFC3_B.Down, true);
      BtnC.UpdateImage(TfrmBScope(WCCInterface.frmScopeB).lmpFC2, BtnC.orangeROUND_On);
      WCCInterface.SendEvenWCC_120mm(15);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC3SBSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(3) then exit;
    if WCCInterface.SetDeAssign_FC(3) then begin
      BtnC.UpdateButton(btnFC3SBS, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC3AFS, TBSpring, sGreenBOX, False);
      BtnC.UpdateImage(lmpFC3RDY, BtnC.sgreenROUND_Off);
      BtnC.UpdateButton(btnGENFC3, TBSpring, sOrangeBOX, False);

      if WCCInterface.FC3.GenFix then
        WCCInterface.FC3.GenFix           := false;

      WCCInterface.ShowBScope(2, btnFC2_B.Down, true);
      WCCInterface.ShowBScope(3, btnFC3_B.Down, true);
      BtnC.UpdateImage(TfrmBScope(WCCInterface.frmScopeB).lmpFC3, BtnC.orangeROUND_On);
      {LOG}
      WCCInterface.SendEvenWCC_120mm(16);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC2STOClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnFC2STO);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.SetAssign_FC(2, WCCInterface.OBMRight.Center) then begin
      BtnC.UpdateButton(btnFC2STO, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC2AFS, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC2SBS, TBSpring, sGreenBOX, False);
      IsStartingFC2 := True;
      WCCInterface.SendEvenWCC_120mm(13);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC3STOClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnFC3STO);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.SetAssign_FC(3, WCCInterface.OBMRight.Center) then begin
      BtnC.UpdateButton(btnFC3STO, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC3AFS, TBSpring, sGreenBOX, True);
      BtnC.UpdateButton(btnFC3SBS, TBSpring, sGreenBOX, False);
      IsStartingFC3 := True;
      WCCInterface.SendEvenWCC_120mm(14);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC2AFSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmWCCPanelBawah2.btnFC3AFSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmWCCPanelBawah2.btnG1ATTN_SMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

 inherited;
  if WCCInterface.Gun1.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah2.btnG1ATTN_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
 TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah2.btnG4ATTN_SMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if WCCInterface.Gun1.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah2.btnG4ATTN_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah2.btnG1FIRE_SClick(Sender: TObject);
var X, Y, Z, TOF : Double;
pnt : tDouble2DPoint;
begin
  inherited;
//  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if TSpeedButtonImage(Sender).Down then
    WCCInterface.StartCannonFire(TSpeedButtonImage(Sender).Tag)
  else
   WCCInterface.StopCannonFire(TSpeedButtonImage(Sender).Tag);

   if TSpeedButtonImage(Sender).Tag = 1 then
    if not TfrmWCCPanelAtas2(WCCInterface.frmWCCAtas2).btnG1AUTO.Down then
      TSpeedButtonImage(Sender).Down := False;
end;

procedure TfrmWCCPanelBawah2.btnG2ATTN_SClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmWCCPanelBawah2.btnG2ATTN_SMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if WCCInterface.Gun1.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah2.btnG2ATTN_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah2.btnG2FIRE_SClick(Sender: TObject);
var X, Y, Z, TOF : Double;
pnt : tDouble2DPoint;
begin
//  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
//    WCCInterface.StartCannonFire(2);
end;

procedure TfrmWCCPanelBawah2.btnG2FIRE_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var posX, posY, posZ, TOF : Double;
pnt : tDouble2DPoint;
begin
   inherited;
//     WCCInterface.StopCannonFire(2);
end;

procedure TfrmWCCPanelBawah2.btnG3ATTN_SClick(Sender: TObject);
begin
  inherited;
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmWCCPanelBawah2.btnG3ATTN_SMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   if WCCInterface.Gun3.ReadyToFire then
    TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_On;
end;

procedure TfrmWCCPanelBawah2.btnG3ATTN_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TSpeedButtonImage(Sender).Glyph := BtnC.sgreenBOX_Off;
end;

procedure TfrmWCCPanelBawah2.btnG3FIRE_SClick(Sender: TObject);
var X, Y, Z, TOF : Double;
pnt : tDouble2DPoint;
begin


end;

procedure TfrmWCCPanelBawah2.btnG3FIRE_SMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var posX, posY, posZ, TOF : Double;
pnt : tDouble2DPoint;
begin
  inherited;
end;

procedure TfrmWCCPanelBawah2.btnSplashCorrClick(Sender: TObject);
begin
//  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if (not btnFC2_B.Down) and (not btnFC3_B.Down) then Exit;

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSplashCorr, sOrangeBOX);
    IsDoingSplashCorrection := btnSplashCorr.Down;
    if btnSplashCorr.Down then begin
      //bVal := (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun1, (WCCInterface.Gun1.AssignTo <> nil));
//      WCCInterface.ShowSplash(WCCInterface.Gun1, (WCCInterface.Gun1.AssignTo <> nil));
      if (WCCInterface.Gun1.AssignTo <> nil) then exit;

      //bVal := (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun2, (WCCInterface.Gun2.AssignTo <> nil));
//      WCCInterface.ShowSplash(WCCInterface.Gun2, (WCCInterface.Gun2.AssignTo <> nil));
      if (WCCInterface.Gun2.AssignTo <> nil) then exit;

      //bVal := (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun3, (WCCInterface.Gun3.AssignTo <> nil));
//      WCCInterface.ShowSplash(WCCInterface.Gun3, (WCCInterface.Gun3.AssignTo <> nil));
    end
    else begin
      if not WCCInterface.Gun1.Corrected then WCCInterface.DoGunCorrection(WCCInterface.Gun1);
      if not WCCInterface.Gun2.Corrected then WCCInterface.DoGunCorrection(WCCInterface.Gun2);
      if not WCCInterface.Gun3.Corrected then WCCInterface.DoGunCorrection(WCCInterface.Gun3);

      WCCInterface.ShowPHP(WCCInterface.Gun1, False);
      WCCInterface.ShowSplash(WCCInterface.Gun1, False);
      WCCInterface.ShowPHP(WCCInterface.Gun2, False);
      WCCInterface.ShowSplash(WCCInterface.Gun2, False);
      WCCInterface.ShowPHP(WCCInterface.Gun2, False);
      WCCInterface.ShowSplash(WCCInterface.Gun2, False);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.SpeedButtonImage84Click(Sender: TObject);
begin
  inherited;
  //WCCInterface.Erasesplash(1);
  TfrmBScope(WCCInterface.frmScopeB).ClearAllItem;
end;

procedure TfrmWCCPanelBawah2.SpeedButtonImage85Click(Sender: TObject);
var rdm:Integer;
begin

end;

procedure TfrmWCCPanelBawah2.SpeedButtonImage86Click(Sender: TObject);
var selisih : t2DPoint;
begin

end;

procedure TfrmWCCPanelBawah2.btnGenCorrClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmWCCPanelBawah2.btnRESOBM_RIGHTClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnRESOBM_RIGHT);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.OBMRight_Reset;
  end;
end;

//**********************************************//
//      SURFACE & BOMBARDMENT PANEL             //
//**********************************************//  
procedure TfrmWCCPanelBawah2.btnBLINDBOMBClick(Sender: TObject);

begin
 // BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if TSpeedButtonImage(Sender).Down then begin
      if  WCCInterface.DoBlindBomb then begin
        BtnC.UpdateBtnImage(self.btnBLINDBOMB, BtnC.sgreenBOX_On);
        BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(17);
      end;
    end
    else
    begin
      if  WCCInterface.unDoBlindBomb then begin
        BtnC.UpdateBtnImage(self.btnBLINDBOMB, BtnC.sgreenBOX_Off);
        BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.sgreenBOX_On);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(19);
      end;
    end;

  end;
end;

procedure TfrmWCCPanelBawah2.btnINDBOMBClick(Sender: TObject);
begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if TSpeedButtonImage(Sender).Down then begin
    if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    begin
       if WCCInterface.DoIndirectBomb then begin
        BtnC.UpdateBtnImage(self.btnINDBOMB, BtnC.sgreenBOX_On);
        BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.sgreenBOX_Off);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(18);
      end;
    end;
  end
  else
  begin
   if WCCInterface.unDoIndirectBomb then begin
        BtnC.UpdateBtnImage(self.btnINDBOMB, BtnC.sgreenBOX_Off);
        BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.sgreenBOX_On);
        {LOG}
        WCCInterface.SendEvenWCC_120mm(20);
   end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnGENFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.DoGenFix(2) then begin
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sorangeBOX_On);
      BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.sgreenBOX_Off);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(21);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnGENFC3Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.DoGenFix(3) then begin
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.sorangeBOX_On);
      BtnC.UpdateBtnImage(self.btnFC3SBS, BtnC.sgreenBOX_Off);
      {LOG}
        WCCInterface.SendEvenWCC_120mm(22);
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC2_BClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if btnFC2_B.Down then
    begin
      TfrmBScope(WCCInterface.frmScopeB).ClearAllItem;
      btnFC2_B.Glyph := BtnC.sgreenBOX_On;
      btnFC3_B.Glyph := BtnC.sgreenBOX_Off;
      WCCInterface.ShowBScope(2, true, btnFC2_B.Down);
    end
    else begin
      btnFC2_B.Glyph := BtnC.sgreenBOX_Off;
      BtnC.UpdateImage(TfrmBScope(WCCInterface.frmScopeB).lmpFC2, BtnC.redROUND_Off);
      WCCInterface.ShowBScope(2, true, btnFC2_B.Down);
    end;
  end
  else begin
      btnFC2_B.Glyph := BtnC.sgreenBOX_Off;
      BtnC.UpdateImage(TfrmBScope(WCCInterface.frmScopeB).lmpFC2, BtnC.redROUND_Off);
      WCCInterface.ShowBScope(2, false, false);
      if  WCCInterface.ActiveGUN <> nil then
       WCCInterface.ShowPHP(WCCInterface.ActiveGUN, False);
  end;
end;

procedure TfrmWCCPanelBawah2.btnFC3_BClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if btnFC3_B.Down then
    begin
      TfrmBScope(WCCInterface.frmScopeB).ClearAllItem;
      btnFC3_B.Glyph := BtnC.sgreenBOX_On;
      btnFC2_B.Glyph := BtnC.sgreenBOX_Off;
       WCCInterface.ShowBScope(3,true, btnFC3_B.Down);
    end
    else begin
      btnFC3_B.Glyph := BtnC.sgreenBOX_Off;
      BtnC.UpdateImage(TfrmBScope(WCCInterface.frmScopeB).lmpFC3, BtnC.redROUND_Off);
      WCCInterface.ShowBScope(3, true, btnFC3_B.Down);
    end;
//    WCCInterface.ShowBScope(3, btnFC3_B.Down);
  end;
end;

//**********************************************//
//      ACTION PAGE                             //
//**********************************************//
procedure TfrmWCCPanelBawah2.Reset_Andu_Button;
begin
  btnPREACT.Down := False;
  BtnC.UpdateBtnImage(btnPreact,BtnC.sorangeBOX_Off);
  btnAIRSURF.Down := False;
  BtnC.UpdateBtnImage(btnairsurf,BtnC.sgreenBOX_Off);
  btnNGS.Down := False;
  BtnC.UpdateBtnImage(btnngs,BtnC.sgreenBOX_Off);
  btnTEST.Down := False;
  BtnC.UpdateBtnImage(btntest,BtnC.sorangeBOX_Off);
  btnTV.Down := False;
  BtnC.UpdateBtnImage(btntv,BtnC.sgreenBOX_Off);
end;

procedure TfrmWCCPanelBawah2.btnPREACTClick(Sender: TObject);
begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    self.Reset_Andu_Button;
    BtnC.UpdateBtnImage(btnpreact,BtnC.sorangeBOX_On);
    PreActShow;
    //preactbt.Click ;
  end;
end;

procedure TfrmWCCPanelBawah2.btn1Click(Sender: TObject);
begin
  inherited;
  InsertIntoAndu('301', 135);
  InsertIntoAndu('302', 4800);
  InsertIntoAndu('303', 40);
  InsertIntoAndu('304', 0);
  InsertIntoAndu('305', 0);
  bteraseClick(nil);
end;

procedure TfrmWCCPanelBawah2.btn2Click(Sender: TObject);
begin
  inherited;
  WCCInterface.frmTengah.Left:= 350;
  WCCInterface.frmWCCBawah1.formstyle:= fsStayOnTop;
  WCCInterface.frmWCCBawah1.Visible:= True;
  WCCInterface.frmWCCBawah2.Visible:= False;
end;

procedure TfrmWCCPanelBawah2.btn3Click(Sender: TObject);
begin
  inherited;
  InsertIntoAndu('309', 35);
  InsertIntoAndu('310', 5000);
end;

procedure TfrmWCCPanelBawah2.btn4Click(Sender: TObject);
begin
  inherited;
   InsertIntoAndu('306', 60);
   InsertIntoAndu('307', 500);
   InsertIntoAndu('308', 900);

end;

procedure TfrmWCCPanelBawah2.btnAIRSURFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnairsurf,BtnC.sgreenBOX_On);
  AirSurfShow;
  //airsurfbt.Click ;
  end;
end;

procedure TfrmWCCPanelBawah2.btnNGSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnNGS,BtnC.sgreenBOX_On);
  NgsShow;
  //ngsbt.Click;
  end;
end;

procedure TfrmWCCPanelBawah2.btnTESTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btntest,BtnC.sorangeBOX_On);
  TestPageShow;
  //testbt.Click ;
  end;
end;

procedure TfrmWCCPanelBawah2.btnTVClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    self.Reset_Andu_Button;
    BtnC.UpdateBtnImage(btntv,BtnC.sgreenBOX_On);
    tvshow;
  end;
end;

procedure TfrmWCCPanelBawah2.Timer1Timer(Sender: TObject);
var a,b,c : Boolean;
    F1, F2, F3 : Boolean;
begin
  WCCInterface.CekGunStatus;

  If IsStartingFC2 then begin
    Inc(FC2_COUNTER, 1);
      If C_FC_READY_TIME = FC2_COUNTER then begin
      FC2_COUNTER := 0;
      IsStartingFC2 := False;

      BtnC.UpdateBtnImage(self.btnFC2AFS, BtnC.sgreenBOX_Off);
      if WCCInterface.IsFireControlInUse(2) then begin
        BtnC.UpdateImage(self.lmpFC2RDY, BtnC.sgreenROUND_On);
        BtnC.UpdateButton(btnFC2STO, TBSpring, sGreenBOX, False);
        WCCInterface. ShowBScope(2, btnFC2_B.Down, btnFC2_B.Down);
      end
      else begin
        BtnC.UpdateButton(btnFC2SBS, TBSpring, sGreenBOX, True);
        BtnC.UpdateButton(btnFC2STO, TBSpring, sGreenBOX, False);
      end;
    end;
  end;

  If IsStartingFC3 then begin
    Inc(FC3_COUNTER, 1);
    If (C_FC_READY_TIME = FC3_COUNTER) then begin
      FC3_COUNTER := 0;
      IsStartingFC3 := False;

      BtnC.UpdateButton(btnFC3AFS, TBSpring, sGreenBOX, False);
      if WCCInterface.IsFireControlInUse(3) then  begin
        BtnC.UpdateImage(self.lmpFC3RDY, BtnC.sgreenROUND_On);
        BtnC.UpdateButton(btnFC3STO, TBSpring, sGreenBOX, False);
        WCCInterface.ShowBScope(3, btnFC3_B.Down, btnFC3_B.Down);
      end
      else begin
        BtnC.UpdateButton(btnFC3SBS, TBSpring, sGreenBOX, True);
        BtnC.UpdateButton(btnFC3STO, TBSpring, sGreenBOX, False);
      end;
    end;
  end;

  // Lampu Indikator senjata
  {if (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name <> 'FC1') and WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.IsBlind = false) then
    BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG1INRANGE, BtnC.greenROUND_Off);

  if (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name <> 'FC1') and WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.IsBlind = false) then
    BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG2INRANGE, BtnC.greenROUND_Off);

  if (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name <> 'FC1') and WCCInterface.Gun3.IsInRange and (WCCInterface.Gun3.IsBlind = false) then
    BtnC.UpdateImage(lmpG3INRANGE, BtnC.greenROUND_On)
  else BtnC.UpdateImage(lmpG3INRANGE, BtnC.greenROUND_Off);
   }

  BtnC.UpdateImage(lmpG1INRANGE, sGreenROUND, WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name <> 'FC1'));
  BtnC.UpdateImage(lmpG2INRANGE, sGreenROUND, WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name <> 'FC1'));
  BtnC.UpdateImage(lmpG3INRANGE, sGreenROUND, WCCInterface.Gun3.IsInRange and (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name <> 'FC1'));

  F1 :=  WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name <> 'FC1');
  F2 :=  WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name <> 'FC1');
  F3 := WCCInterface.Gun3.ReadyToFire and (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name <> 'FC1');

  if IsBtnFire1_Ready <> F1 then
   BtnC.UpdateBtnImage(btnG1FIRE_S, sGreenBOX, F1);

  if IsBtnFire2_Ready <> F2 then
   BtnC.UpdateBtnImage(btnG2FIRE_S, sGreenBOX, F2);

  if IsBtnFire3_Ready <> F3 then
   BtnC.UpdateBtnImage(btnG3FIRE_S, sGreenBOX, F3);

   IsBtnFire1_Ready := F1;
   IsBtnFire2_Ready := F2;
   IsBtnFire3_Ready := F3;

  BtnC.UpdateBtnImage(btnGUN1_FIRE, sGreenBOX, WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name <> 'FC1'));

  // Caption := FloatToStr(WCCInterface.Gun1.FireBreakTimer * 0.001) + ' - ' +
  // FloatToStr(WCCInterface.Gun2.FireBreakTimer * 0.001) + ' - ' +
  // FloatToStr(WCCInterface.Gun3.FireBreakTimer * 0.001);
  // Buat nampilin data di Andu

  ShowAnduData;
end;

procedure TfrmWCCPanelBawah2.bteraseClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    CodeInput.Text := '';
    checkbtn.Checked := false;
    ValueInput.Text := '';
    AnduCode := '';
  end;
end;

procedure TfrmWCCPanelBawah2.bt0Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('0');
end;

procedure TfrmWCCPanelBawah2.bt1Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('1');
end;

procedure TfrmWCCPanelBawah2.bt2Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('2');
end;

procedure TfrmWCCPanelBawah2.bt3Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('3');
end;

procedure TfrmWCCPanelBawah2.bt4Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('4');
end;

procedure TfrmWCCPanelBawah2.bt5Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('5');
end;

procedure TfrmWCCPanelBawah2.bt6Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('6');
end;

procedure TfrmWCCPanelBawah2.bt7Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('7');
end;

procedure TfrmWCCPanelBawah2.bt8Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('8');
end;

procedure TfrmWCCPanelBawah2.bt9Click(Sender: TObject);
begin


  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('9');
end;

procedure TfrmWCCPanelBawah2.btplusClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('+');
end;

procedure TfrmWCCPanelBawah2.btminClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('-');
end;

procedure TfrmWCCPanelBawah2.btinsertClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    if (checkbtn.Checked = true) then begin
      insertvalue;
    end
    else
      getcode;
end;

procedure TfrmWCCPanelBawah2.insertvalue;
var i :integer;
    nm, tempnm, pg, tab : string;
    indx, indx2: byte;
begin
  if valueinput.Text = '' then exit;

  for i := 0 to ComponentCount-1 do
    if Components[i] is TEdit then begin
      nm := LowerCase(SplitEditName((Components[i] as TEdit).Name));

      pg := Copy(AnduCode, 0, 1);
      if (pg = '1') or (pg = '3') or (pg = '4') then
        tempnm := AnduCode
      else if (pg = '2') then begin
        //tab := Copy(AnduCode, 5, 1);
        //tempnm := Copy(AnduCode, 0, 3) + tab;
        tempnm := AnduCode;
      end;

      if (tempnm = nm) then begin
        if not FInputOnOff then
          if not ValidateValue(AnduCode, valueinput.Text) then
            exit;

        (Components[i] as TEdit).Text := valueinput.Text;

        indx := 0;
        indx := WCCInterface.GetAnduIndex(AnduCode);
        if pg = '1' then begin
          if indx > 0 then
            WCCInterface.WCCAndu.Page_1[indx].SetValue(valueinput.Text);
        end
        else if pg = '2' then begin
          indx2 := StrToInt(Copy(AnduCode, 2, 1));
          if indx > 0 then
            WCCInterface.WCCAndu.Page_2[indx][indx2].SetValue(valueinput.Text);
        end
        else if pg = '3' then begin
          if indx > 0 then
            WCCInterface.WCCAndu.Page_3[indx].SetValue(valueinput.Text);
        end;
        if indx > 0 then bteraseClick(nil);  //reset field
      end;
    end;
    bteraseClick(nil);
end;

procedure TfrmWCCPanelBawah2.Button1Click(Sender: TObject);
begin
  InsertIntoAndu('101', 8);
  InsertIntoAndu('102', 90);
  InsertIntoAndu('103', 30);
  InsertIntoAndu('104', 1011);
  InsertIntoAndu('105', 800);  // initial 800
  InsertIntoAndu('106', 985);
  InsertIntoAndu('107', 985);
  InsertIntoAndu('108', 25);
  InsertIntoAndu('109', 100);

end;

procedure TfrmWCCPanelBawah2.InsertIntoAndu(const code: string; const val: double);
begin
  valueinput.Text := FloatToStr(val);
  checkbtn.Checked := true;
  AnduCode := code;
  insertvalue;
end;

procedure TfrmWCCPanelBawah2.vThrowOffChange(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.IsFireControlInUse(2) then begin
      WCCInterface.FC2.ThrowOff := WCCInterface.ThrowOffMode(vThrowOff.SwitchPosition);
      if WCCInterface.FC2.ThrowOff then begin
        btnFC3SBSClick(nil);
        BtnC.UpdateBtnImage(btnFC2SBS, BtnC.sgreenBOX_Off);

      end
      else begin
        BtnC.UpdateImage(lmpFC2RDY, BtnC.sgreenROUND_Off);
        BtnC.UpdateBtnImage(btnFC2SBS, BtnC.sgreenBOX_On);
      end;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.tmrBTKTimer(Sender: TObject);
var X, Y, Z, TOF , SndX, SndY: Double;
rdm : Integer;
pnt : tDouble2DPoint;
begin

end;

procedure TfrmWCCPanelBawah2.tmrGunTimer(Sender: TObject);
var tampilkan: boolean;
begin
  tampilkan := btnFC2_B.Down or btnFC3_B.Down;
    
  if (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name <> 'FC1') and WCCInterface.Gun1.Firing then begin
    inc(WCCInterface.Gun1.PHPCounter,1);

    // buat PHP
    if (WCCInterface.Gun1.PHPCounter >= WCCInterface.Gun1.PHPStart) and (WCCInterface.Gun1.PHPCounter < WCCInterface.Gun1.PHPEnd) then
        WCCInterface.ShowPHP(WCCInterface.Gun1, tampilkan);

    // buat splash
    WCCInterface.ShowSplash(WCCInterface.Gun1, tampilkan and (WCCInterface.Gun1.PHPCounter = WCCInterface.Gun1.TOF));

    if WCCInterface.Gun1.PHPCounter > WCCInterface.Gun1.PHPEnd then begin
      WCCInterface.ShowPHP(WCCInterface.Gun1, False);
      WCCInterface.Gun1.PHPCounter := -1;
      WCCInterface.Gun1.Firing := false;
    end;
  end;
  if (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name <> 'FC1') and WCCInterface.Gun2.Firing then begin
    inc(WCCInterface.Gun2.PHPCounter,1);

    // buat PHP
    if (WCCInterface.Gun2.PHPCounter >= WCCInterface.Gun2.PHPStart) and (WCCInterface.Gun2.PHPCounter < WCCInterface.Gun2.PHPEnd) then
        WCCInterface.ShowPHP(WCCInterface.Gun2, tampilkan);

    // buat splash
    WCCInterface.ShowSplash(WCCInterface.Gun2, tampilkan and (WCCInterface.Gun2.PHPCounter = WCCInterface.Gun2.TOF));

    if WCCInterface.Gun2.PHPCounter > WCCInterface.Gun2.PHPEnd then begin
      WCCInterface.ShowPHP(WCCInterface.Gun2, False);
      WCCInterface.Gun2.Firing := False;
      WCCInterface.Gun2.PHPCounter := -1;
    end;
  end;
  if (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.AssignTo.Name <> 'FC1') and WCCInterface.Gun3.Firing then begin
    inc(WCCInterface.Gun3.PHPCounter,1);

    // buat PHP
    if (WCCInterface.Gun3.PHPCounter >= WCCInterface.Gun3.PHPStart) and (WCCInterface.Gun3.PHPCounter < WCCInterface.Gun3.PHPEnd) then
        WCCInterface.ShowPHP(WCCInterface.Gun3, tampilkan);

    // buat splash
    WCCInterface.ShowSplash(WCCInterface.Gun3, tampilkan and (WCCInterface.Gun3.PHPCounter = WCCInterface.Gun3.TOF));

    if WCCInterface.Gun3.PHPCounter > WCCInterface.Gun3.PHPEnd then begin
      WCCInterface.ShowPHP(WCCInterface.Gun3, False);
      WCCInterface.Gun3.Firing := False;
      WCCInterface.Gun3.PHPCounter := -1;
    end;
  end;
end;

procedure TfrmWCCPanelBawah2.tmrShowsplashTimer(Sender: TObject);
var delay : Integer;
begin
  inherited;
  if StartCountDelSplash then begin     // Splash visible  := false
   CounterDel := CounterDel +1;
   mmo1.Lines.Add(IntToStr(CounterDel));
    if CounterDel >= TimeofSplashShown  then begin
      WCCInterface.ShowPHP(WCCInterface.ActiveGUN , false);
      WCCInterface.ShowSplash(WCCInterface.ActiveGUN , false);
      StartCountDelSplash := False;
      CounterDel:= 0;
      tmrShowsplash.Enabled:=False;
//    TfrmBScope(WCCInterface.frmScopeB).tmrblinkPHP.Enabled := False;
    end;
  end;
end;
end.

