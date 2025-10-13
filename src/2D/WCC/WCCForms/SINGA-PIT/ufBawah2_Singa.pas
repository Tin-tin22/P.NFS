unit ufBawah2_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrDesign, StdCtrls, ExtCtrls, Buttons,
  SpeedButtonImage, ImgList, VrRotarySwitch, uLibWCCClassNew, uLibWCCKu,
  uBaseConstan, uTCPDatatype, uBaseDataType, uBaseFunction, uDetected, ufQEK;

type
  TfrmBawah2_Singa = class(TfrmQEK)
    Panel6: TPanel;
    Bevel22: TBevel;
    Bevel13: TBevel;
    Bevel17: TBevel;
    Bevel8: TBevel;
    btnG1FC1ASS: TSpeedButtonImage;
    btnG2FC1ASS: TSpeedButtonImage;
    btnTVFC1: TSpeedButtonImage;
    btnG1FC2ASS: TSpeedButtonImage;
    btnG2FC2ASS: TSpeedButtonImage;
    btnTVFC2: TSpeedButtonImage;
    btnG1FC3ASS: TSpeedButtonImage;
    btnG2FC3ASS: TSpeedButtonImage;
    btnTVFC3: TSpeedButtonImage;
    btnG1FC4ASS: TSpeedButtonImage;
    btnG2FC4ASS: TSpeedButtonImage;
    Label62: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label74: TLabel;
    Label79: TLabel;
    Label84: TLabel;
    Panel8: TPanel;
    Bevel62: TBevel;
    Bevel2: TBevel;
    Bevel54: TBevel;
    Bevel56: TBevel;
    Bevel57: TBevel;
    lmpG1ASDFC3: TImage;
    lmpG2ASDFC2: TImage;
    lmpG1ASDFC2: TImage;
    lmpFC3RDY: TImage;
    lmpG1INRANGEFC2: TImage;
    lmpG2INRANGEFC2: TImage;
    lmpG1INRANGEFC3: TImage;
    lmpFC2RDY: TImage;
    btnFC2STO: TSpeedButtonImage;
    btnFC2AFS: TSpeedButtonImage;
    btnFC2SBS: TSpeedButtonImage;
    btnSplashCorr: TSpeedButtonImage;
    SpeedButtonImage92: TSpeedButtonImage;
    btnRESOBM_RIGHT: TSpeedButtonImage;
    btnFC3STO: TSpeedButtonImage;
    btnFC3AFS: TSpeedButtonImage;
    btnFC3SBS: TSpeedButtonImage;
    btnG1ATTNFC2: TSpeedButtonImage;
    Shape8: TShape;
    btnG1FIREFC2: TSpeedButtonImage;
    btnG2ATTNFC2: TSpeedButtonImage;
    Shape9: TShape;
    btnG2FIREFC2: TSpeedButtonImage;
    btnG1ATTNFC3: TSpeedButtonImage;
    Shape10: TShape;
    btnG1FIREFC3: TSpeedButtonImage;
    Label31: TLabel;
    Label35: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    Label54: TLabel;
    Label56: TLabel;
    Bevel58: TBevel;
    Bevel59: TBevel;
    Bevel60: TBevel;
    Bevel61: TBevel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Timer1: TTimer;
    Label14: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    lmpG2ASDFC3: TImage;
    lmpG2INRANGEFC3: TImage;
    btnG2ATTNFC3: TSpeedButtonImage;
    Shape5: TShape;
    btnG2FIREFC3: TSpeedButtonImage;
    Label15: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Bevel12: TBevel;
    Bevel14: TBevel;
    btnTVFC4: TSpeedButtonImage;
    SpeedButtonImage3: TSpeedButtonImage;
    Label23: TLabel;
    Bevel4: TBevel;
    tmrGun: TTimer;
    checkbtn: TRadioButton;
    tvpage: TPanel;
    xpPanel1: TPanel;
    valueinput: TEdit;
    codeinput: TEdit;
    AirSurfPage: TPanel;
    NgsPage: TPanel;
    PreActPage: TPanel;
    TestPage: TPanel;
    Panel1: TPanel;
    btnAIRSURF: TSpeedButtonImage;
    btnTV: TSpeedButtonImage;
    btnTEST: TSpeedButtonImage;
    btnPREACT: TSpeedButtonImage;
    btnNGS: TSpeedButtonImage;
    Panel2: TPanel;
    bterase: TVrBitmapButton;
    btinsert: TVrBitmapButton;
    bt7: TVrBitmapButton;
    bt8: TVrBitmapButton;
    bt2: TVrBitmapButton;
    bt5: TVrBitmapButton;
    bt0: TVrBitmapButton;
    bt4: TVrBitmapButton;
    bt1: TVrBitmapButton;
    bt9: TVrBitmapButton;
    bt6: TVrBitmapButton;
    bt3: TVrBitmapButton;
    btmin: TVrBitmapButton;
    btplus: TVrBitmapButton;
    Label32: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel7: TPanel;
    Bevel55: TBevel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    btnFC2_B: TSpeedButtonImage;
    btnGENFC2: TSpeedButtonImage;
    btnFC3_B: TSpeedButtonImage;
    btnGENFC3: TSpeedButtonImage;
    btnBLINDBOMB: TSpeedButtonImage;
    btnINDBOMB: TSpeedButtonImage;
    btnDIRBOMB: TSpeedButtonImage;
    SpeedButtonImage85: TSpeedButtonImage;
    SpeedButtonImage86: TSpeedButtonImage;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    vThrowOff: TVrRotarySwitch;
    Button1: TButton;
    Image4: TImage;
    btR: TVrBitmapButton;
    btL: TVrBitmapButton;
    VrBitmapButton3: TVrBitmapButton;
    Label16: TLabel;
    Label18: TLabel;
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
    Andu1012: TEdit;
    Andu1022: TEdit;
    Andu1032: TEdit;
    Andu1011: TEdit;
    Andu1021: TEdit;
    Andu1031: TEdit;
    Andu104: TEdit;
    Andu105: TEdit;
    Andu106: TEdit;
    Andu108: TEdit;
    Andu109: TEdit;
    Andu110: TEdit;
    Andu111: TEdit;
    Andu112: TEdit;
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
    Andu215: TEdit;
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
    Andu415: TEdit;
    Andu4104: TEdit;
    Andu2083: TEdit;
    Andu2082: TEdit;
    Andu2081: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnG1FC1ASSClick(Sender: TObject);
    procedure btnG2FC1ASSClick(Sender: TObject);
    procedure btnTVFC1Click(Sender: TObject);
    procedure btnG1FC2ASSClick(Sender: TObject);
    procedure btnG2FC2ASSClick(Sender: TObject);
    procedure btnTVFC2Click(Sender: TObject);
    procedure btnG1FC3ASSClick(Sender: TObject);
    procedure btnG2FC3ASSClick(Sender: TObject);
    procedure btnTVFC3Click(Sender: TObject);
    procedure btnG1FC4ASSClick(Sender: TObject);
    procedure btnG2FC4ASSClick(Sender: TObject);
    procedure btnTVFC4Click(Sender: TObject);
    procedure btnFC2SBSClick(Sender: TObject);
    procedure btnFC2STOClick(Sender: TObject);
    procedure btnFC2AFSClick(Sender: TObject);
    procedure btnFC3STOClick(Sender: TObject);
    procedure btnFC3AFSClick(Sender: TObject);
    procedure btnFC3SBSClick(Sender: TObject);
    procedure btnG1ATTNFC2Click(Sender: TObject);
    procedure btnG1FIREClick(Sender: TObject);
    procedure btnG2ATTNFC2Click(Sender: TObject);
    procedure btnG2FIREClick(Sender: TObject);
    //procedure btnG1ATTNFC3Click(Sender: TObject);
    //procedure btnG1FIREFC3Click(Sender: TObject);
    //procedure btnG2ATTNFC3Click(Sender: TObject);
    //procedure btnG2FIREFC3Click(Sender: TObject);
    procedure btnSplashCorrClick(Sender: TObject);
    procedure SpeedButtonImage92Click(Sender: TObject);
    procedure btnRESOBM_RIGHTClick(Sender: TObject);
    procedure btnBLINDBOMBClick(Sender: TObject);
    procedure btnINDBOMBClick(Sender: TObject);
    procedure btnGENFC2Click(Sender: TObject);
    procedure btnGEN2Click(Sender: TObject);
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
    procedure vThrowOffChange(Sender: TObject);
    procedure tmrGunTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btRClick(Sender: TObject);
    procedure btLClick(Sender: TObject);
  private
    { Private declarations }
    AnduCode : string;
    FHour, FMin, FSec: integer;
    FTimeRunning: boolean;

    FInputOnOff: boolean;

    function SplitPage(const s: string): integer;
    function SplitEditName(const s: string): string;

    function GetLine(const aCode: string): string;
    function GetValue(const aCode: string): string;
    function ValidateCode(const aCode: string): boolean;
    function ValidateValue(const aCode, aVal: string): boolean;
    function CekOnOff(const aCode: string): boolean;

    procedure RunTimer;
    procedure DisplayTimer;

    procedure InsertIntoAndu(const code: string; const val: double);

  public
    { Public declarations }
    //Andu
    procedure PreActShow;
    procedure AirSurfShow;
    procedure NgsShow;
    procedure TestPageShow;
    procedure getcode;
    procedure ApplyNumber(text: string);
    procedure insertvalue;
    procedure ShowAnduData;
    procedure tvshow;
  end;

const
    onoff : array [1..2] of string = ('ON','OFF');

    C_CodeTypeLength = 43;
    listcode : array [1..C_CodeTypeLength] of string =
           ('1011','1012','1021','1022','1031','1032','104', '105', '106', '108', '109', '110',
            '21011','21012','21013',
            '21021','21022','21023',
            '21111','21112','21113',
            '21121','21122','21123',
            '21211','21212','21213',
            '21221','21222','21223','215',
            '301','302','303','304','305','306','307','308','309','310',
            '4104','415');
    
    C_LineLength = 26;
    thecode : array [1..C_LineLength] of string =
           ('101','102','103','104','105','106','108','109','110','111',
             '210','211','212','215',
             '301','302','303','304','305','306','307','308','309','310',
             '410','415');
    theline : array [1..C_LineLength] of string =
           ('101*WIND AA/SU  KTS',
            '102*WIND AA/SU  DEG',
            '103*TEMP AA/SU  CEL',
            '104*AIR PRESSURE MB',
            '105*V0 GUN1     MPS',
            '106*V0 GUN2     MPS',
            '108*CC GUN1     %',
            '109*LATITUDE    DEG',
            '110*HGHT AIR LT FT',
            '111*NEGAT LINUP GUN',

            '210*LNCOR MIL',
            '211*RGCOR YDS',
            '212*ELCOR MIL',
            '215*LOCAL TIME',

            '301*TGT BEARING     DEG',
            '302*TGT RANGE       YDS',
            '303*TGT HEIGHT      FT',
            '304*CRNT COURSE     DEG',
            '305*CRNT SPEED      KTS',
            '306*OTL             DEG',
            '307*ADD/DROP WRT OTLYDS',
            '308*RGT/LEFT WRT OTLYDS',
            '309*OFF SET BEARING DEG',
            '310*OFF SET RANGE   YDS',

            '410*QOT                ',      // on off
            '415*DALOG              ');     // on off

implementation

uses
  ufWCCTengah, ufBawah_Singa, uLabelDisplay, Types, Math, uLibTDCTracks, uTDCConstan;

{$R *.dfm}
var
  IsStartingFC2, IsStartingFC3: boolean;
  FC2_COUNTER, FC3_COUNTER: Integer;
  
procedure TfrmBawah2_Singa.FormCreate(Sender: TObject);
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
end;

function TfrmBawah2_Singa.SplitPage(const s: string): integer;
begin
  result := StrToInt(Copy(s, 0, 1));
end;

function TfrmBawah2_Singa.SplitEditName(const s: string): string;
begin
  result := Copy(s, 5, Length(s) - 1);
end;

function TfrmBawah2_Singa.GetLine(const aCode: string): string;
var tCode: string;
    i: integer;
begin
  result := '';

  tCode := Copy(aCode, 0, 3);
  for i:=1 to C_LineLength do begin
    if thecode[i] = tCode then result := theline[i];
  end;
end;

function TfrmBawah2_Singa.GetValue(const aCode: string): string;
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

function TfrmBawah2_Singa.ValidateCode(const aCode: string): boolean;
var i: integer;
begin
  result := false;

  for i:=1 to C_CodeTypeLength do
    if listcode[i] = aCode then result := true;
end;

function TfrmBawah2_Singa.ValidateValue(const aCode, aVal: string): boolean;
var val: single;
    cod : integer;
    part1, part2: string;
    shour, smin, ssec: string;
    ihour, imin, isec: integer;
begin
  result := false;

  cod := StrToInt(Copy(aCode, 0, 3));
  try
    if cod = 215 then begin  //waktu
      if Length(aVal) = 6 then begin
        shour := Copy(aVal, 0, 2);
        smin := Copy(aVal, 3, 2);
        ssec := Copy(aVal, 5, Length(aVal) - 1);

        ihour := StrToInt(shour);
        if (ihour < 0) or (ihour > 23) then exit;
        imin := StrToInt(smin);
        if (imin < 0) or (imin > 59) then exit;
        isec := StrToInt(ssec);
        if (isec < 0) or (isec > 59) then exit;

        FHour := ihour;
        FMin := imin;
        FSec := isec;
        FTimeRunning := true;
        result := true;
      end;
    end
    else begin
      if (cod = 210) or (cod = 308) then begin
        part1 := Copy(aVal, 0, 1);
        part2 := Copy(aVal, 2, Length(aVal) - 1);
      end
      else
        part2 :=  aVal;

      val := StrToFloat(part2);
    end;
  except
    exit;
  end;

  case cod of
    101: if (val >= 1) and (val <= 100) then result := true;
    102: if (val >= 0) and (val <= 359) then result := true;
    103: if (val >= -15) and (val <= 60) then result := true;
    104: if (val >= 960) and (val <= 1066) then result := true;
    105: if (val >= 700) and (val <= 1200) then result := true;
    106: if (val >= 900) and (val <= 1250) then result := true;
    108: if (val >= 0.1) and (val <= 9.9) then result := true;
    109: if (val >= -80) and (val <= 80) then result := true;
    110: if (val >= 0) and (val <= 999) then result := true;
    210: if (val >= 0) and (val <= 100) and ((part1 = 'L') or (part1 = 'R')) then result := true;
    211: if (val >= -2000) and (val <= 2000) then result := true;
    212: if (val >= -100) and (val <= 100) then result := true;
    301: if (val >= 0) and (val <= 359.9) then result := true;  // degree
    302: if (val >= 0) and (val <= 32000) then result := true;  // yards
    303: if (val >= 0) and (val <= 1500) then result := true;   // feet
    304: if (val >= 0) and (val <= 359) then result := true;    // degree
    305: if (val >= 0) and (val <= 99.9) then result := true;   // knot
    306: if (val >= 0) and (val <= 359) then result := true;    // degree
    307: if (val >= -2000) and (val <= 2000) then result := true;  // yard
    308: if (val >= 0) and (val <= 2000) and ((part1 = 'L') or (part1 = 'R')) then result := true;
    309: if (val >= 0) and (val <= 359.9) then result := true;  //degree
    310: if (val >= 0) and (val <= 32000) then result := true;
  end;
end;

function TfrmBawah2_Singa.CekOnOff(const aCode: string): boolean;
begin
  if (aCode = 'ON') or (aCode = 'OFF') then result := true
  else result := false;
end;

procedure TfrmBawah2_Singa.RunTimer;
begin
  if FTimeRunning then begin
    Inc(FSec,1);
    if FSec > 59 then begin
      Inc(FMin,1);
      FSec := 0;
    end;
    if FMin > 59 then begin
      Inc(FHour,1);
      FMin := 0;
    end;
    if FHour > 23 then begin
      FHour := 0;
    end;

    DisplayTimer;
  end;
end;

procedure TfrmBawah2_Singa.DisplayTimer;
begin
  Andu215.Text := IntToStr(FHour) + ':' + IntToStr(FMin) + ':' + IntToStr(FSec);
end;

procedure TfrmBawah2_Singa.InsertIntoAndu(const code: string; const val: double);
begin
  valueinput.Text := FloatToStr(val);
  checkbtn.Checked := true;
  AnduCode := code;
  insertvalue;
end;

//ANDU
procedure TfrmBawah2_Singa.PreActShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=true;
  preactpage.left:=0;
  preactpage.Top :=0;
  testpage.Visible :=false;
end;

procedure TfrmBawah2_Singa.AirSurfShow ;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=true;
  airsurfpage.left:=0;
  airsurfpage.Top :=0;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=false;
end;

procedure TfrmBawah2_Singa.TestPageShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=true;
  testpage.left:=0;
  testpage.Top :=0;
end;

procedure TfrmBawah2_Singa.NgsShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=true;
  ngspage.left:=0;
  ngspage.Top :=0;
  preactpage.Visible :=false;
  testpage.Visible :=false;
end;

procedure TfrmBawah2_Singa.tvshow ;
begin
  tvpage.Visible :=true;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  tvpage.left:=0;
  tvpage.Top :=0;
  preactpage.Visible :=false;
  testpage.Visible :=false; 
end;
         
procedure TfrmBawah2_Singa.getcode;
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

procedure TfrmBawah2_Singa.ApplyNumber(text: string);
begin
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

procedure TfrmBawah2_Singa.ShowAnduData;
var tBox1, tBox2 : TEdit;
begin
  WCCInterface.UpdateAnduData;

  Andu2021.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][1].ToFlooredString;
  Andu2031.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][1].ToFlooredString;
  Andu2061.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][1].ToFlooredString;
  Andu2071.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][1].ToFlooredString;

  Andu2022.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][2].ToFlooredString;
  Andu2032.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][2].ToFlooredString;
  Andu2062.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][2].ToFlooredString;
  Andu2072.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][2].ToFlooredString;

  if WCCInterface.FC2.IsDoingIndBomb then begin
    Andu309.Text := FloatToStr(WCCInterface.IndBombData.b);
    Andu310.Text := FloatToStr(WCCInterface.IndBombData.r);
  end;

  Andu2023.Text := WCCInterface.WCCAndu.Page_2[C_FCBearing][3].ToFlooredString;
  Andu2033.Text := WCCInterface.WCCAndu.Page_2[C_FCRange][3].ToFlooredString;
  Andu2063.Text := WCCInterface.WCCAndu.Page_2[C_FCCourse][3].ToFlooredString;
  Andu2073.Text := WCCInterface.WCCAndu.Page_2[C_FCSpeed][3].ToFlooredString;

  {if WCCInterface.Gun1.AssignTo <> nil then Andu2091.Text := IntToStr(WCCInterface.Gun1.TOF)
  else Andu2091.Text := '';
  if WCCInterface.Gun2.AssignTo <> nil then Andu2092.Text := IntToStr(WCCInterface.Gun2.TOF)
  else Andu2092.Text := '';
  if WCCInterface.Gun3.AssignTo <> nil then Andu2093.Text := IntToStr(WCCInterface.Gun3.TOF)
  else Andu2093.Text := '';}

  // TOF
  if WCCInterface.Gun1.AssignTo <> nil then begin
    if WCCInterface.Gun1.AssignTo.Name = 'FC1' then tBox1 := Andu2091
    else if WCCInterface.Gun1.AssignTo.Name = 'FC2' then tBox1 := Andu2092
    else tBox1 := Andu2093;
    tBox1.Text := WCCInterface.WCCAndu.Page_2[C_TOF][1].ToFlooredString;
  end
  else begin
    Andu2091.Text := '';
    Andu2092.Text := '';
    Andu2093.Text := '';
  end;

  if WCCInterface.Gun2.AssignTo <> nil then begin
    if WCCInterface.Gun2.AssignTo.Name = 'FC1' then tBox2 := Andu2081
    else if WCCInterface.Gun2.AssignTo.Name = 'FC2' then tBox2 := Andu2082
    else tBox2 := Andu2083;
    tBox2.Text := WCCInterface.WCCAndu.Page_2[C_TOF][2].ToFlooredString;
  end
  else begin
    Andu2081.Text := '';
    Andu2082.Text := '';
    Andu2083.Text := '';
  end;

  Andu112.Text := Format('%3.1f',[WCCInterface.xSHIP.Speed]);

end;

//**********************************************//
//      ASSIGNMENT PANEL                        //
//**********************************************//
procedure TfrmBawah2_Singa.btnG1FC1ASSClick(Sender: TObject);
var fB: TfrmBawah_Singa;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    fB := TfrmBawah_Singa(WCCInterface.frmWCCBawah1);

    if self.WCCInterface.AssignGunToFC(1, 1) then
    begin
      BtnC.UpdateImage(fB.lmpG1ASDFC1, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,1) then begin
        BtnC.UpdateImage(fB.lmpG1ASDFC1, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnG2FC1ASSClick(Sender: TObject);
var fB: TfrmBawah_Singa;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    fB := TfrmBawah_Singa(WCCInterface.frmWCCBawah1);

    if self.WCCInterface.AssignGunToFC(2, 1) then
    begin
      BtnC.UpdateImage(fb.lmpG2ASDFC1, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,1) then begin
        BtnC.UpdateImage(fb.lmpG2ASDFC1, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnTVFC1Click(Sender: TObject);
begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  end;
end;

procedure TfrmBawah2_Singa.btnG1FC2ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 2) then
    begin
      BtnC.UpdateImage(self.lmpG1ASDFC2, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,2) then begin
        BtnC.UpdateImage(self.lmpG1ASDFC2, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnG2FC2ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin                                    
    if self.WCCInterface.AssignGunToFC(2, 2) then
    begin
      BtnC.UpdateImage(self.lmpG2ASDFC2, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,2) then begin
        BtnC.UpdateImage(self.lmpG2ASDFC2, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnTVFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  end;
end;

procedure TfrmBawah2_Singa.btnG1FC3ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 3) then
    begin
      BtnC.UpdateImage(self.lmpG1ASDFC3, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,3) then begin
        BtnC.UpdateImage(self.lmpG1ASDFC3, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;                                      
  end;
end;

procedure TfrmBawah2_Singa.btnG2FC3ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(2, 3) then
    begin
      BtnC.UpdateImage(self.lmpG2ASDFC3, BtnC.greenROUND_On);
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,3) then begin
        BtnC.UpdateImage(self.lmpG2ASDFC3, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnTVFC3Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  end;
end;

procedure TfrmBawah2_Singa.Reset_AssignGun2FC4;
begin
  btnG1FC4ASS.Down := False;
  btnG2FC4ASS.Down := False;

  BtnC.UpdateBtnImage(btnG1FC4ASS, BtnC.greenBOX_Off);
  BtnC.UpdateBtnImage(btnG2FC4ASS, BtnC.greenBOX_Off);
end;

procedure TfrmBawah2_Singa.btnG1FC4ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  //BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(1, 4) then
    begin
      //self.Reset_AssignGun2FC4;
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(1,4) then begin
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnG2FC4ASSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  //BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if self.WCCInterface.AssignGunToFC(2, 4) then
    begin
      //self.Reset_AssignGun2FC4;
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_On);
    end
    else
    begin
      if WCCInterface.DeAssignGun(2,4) then begin
        BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.greenBOX_Off);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnTVFC4Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
      BtnC.UpdateLockBtnImage(TSpeedButtonImage(Sender), greenBOX);
  end;
end;

//**********************************************//
//      SURFACE FIRE & CONTROL PANEL            //
//**********************************************//

procedure TfrmBawah2_Singa.btnFC2SBSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(2) then exit;

    WCCInterface.SetDeAssign_FC(2);

    BtnC.UpdateButton(btnFC2SBS, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC2AFS, TBSpring, GreenBOX, False);
    BtnC.UpdateImage(lmpFC2RDY, BtnC.greenROUND_Off);
    BtnC.UpdateButton(btnBLINDBOMB, TBSpring, GreenBOX, False);
    BtnC.UpdateButton(btnINDBOMB, TBSpring, GreenBOX, False);
    BtnC.UpdateButton(btnGENFC2, TBSpring, OrangeBOX, False);
    WCCInterface.ShowBScope(2, true, btnFC2_B.Down);
    WCCInterface.ShowBScope(3, true, btnFC3_B.Down);
  end;
end;

procedure TfrmBawah2_Singa.btnFC3SBSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if not WCCInterface.IsFireControlInUse(3) then exit;

    WCCInterface.SetDeAssign_FC(3);

    BtnC.UpdateButton(btnFC3SBS, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC3AFS, TBSpring, GreenBOX, False);
    BtnC.UpdateImage(lmpFC3RDY, BtnC.greenROUND_Off);
    BtnC.UpdateButton(btnGENFC3, TBSpring, OrangeBOX, False);
    WCCInterface.ShowBScope(2, true, btnFC2_B.Down);
    WCCInterface.ShowBScope(3, true, btnFC3_B.Down);
  end;
end;

procedure TfrmBawah2_Singa.btnFC2STOClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnFC2STO);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.SetAssign_FC(2, WCCInterface.OBMRight.Center);
    BtnC.UpdateButton(btnFC2STO, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC2AFS, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC2SBS, TBSpring, GreenBOX, False);
    IsStartingFC2 := True;
  end;
end;

procedure TfrmBawah2_Singa.btnFC3STOClick(Sender: TObject);
begin
  BtnC.SpringLoaded(btnFC3STO);

  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    WCCInterface.SetAssign_FC(3, WCCInterface.OBMRight.Center);
    BtnC.UpdateButton(btnFC3STO, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC3AFS, TBSpring, GreenBOX, True);
    BtnC.UpdateButton(btnFC3SBS, TBSpring, GreenBOX, False);
    IsStartingFC3 := True;
  end;
end;

procedure TfrmBawah2_Singa.btnFC2AFSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnFC3AFSClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnG1ATTNFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnG1FIREClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender)); 
end;

procedure TfrmBawah2_Singa.btnG2ATTNFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnG2FIREClick(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnSplashCorrClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    BtnC.UpdateLockBtnImage(btnSplashCorr, OrangeBOX);
    IsDoingSplashCorrection := btnSplashCorr.Down;    
    if btnSplashCorr.Down then begin
      //bVal := (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun1, (WCCInterface.Gun1.AssignTo <> nil));
      WCCInterface.ShowSplash(WCCInterface.Gun1, (WCCInterface.Gun1.AssignTo <> nil));
      if (WCCInterface.Gun1.AssignTo <> nil) then exit;

      //bVal := (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun2, (WCCInterface.Gun2.AssignTo <> nil));
      WCCInterface.ShowSplash(WCCInterface.Gun2, (WCCInterface.Gun2.AssignTo <> nil));
      if (WCCInterface.Gun2.AssignTo <> nil) then exit;

      //bVal := (WCCInterface.Gun3.AssignTo <> nil) and (WCCInterface.Gun3.Corrected = False);
      WCCInterface.ShowPHP(WCCInterface.Gun3, (WCCInterface.Gun3.AssignTo <> nil));
      WCCInterface.ShowSplash(WCCInterface.Gun3, (WCCInterface.Gun3.AssignTo <> nil));
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

procedure TfrmBawah2_Singa.SpeedButtonImage92Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
end;

procedure TfrmBawah2_Singa.btnRESOBM_RIGHTClick(Sender: TObject);
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
procedure TfrmBawah2_Singa.btnBLINDBOMBClick(Sender: TObject);
var b, r, h, c, s: double;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    b := 0; r := 0; h := 0; c := 0; s := 0;

    if Andu301.Text <> '' then b := StrToFloat(Andu301.Text);
    if Andu302.Text <> '' then r := StrToFloat(Andu302.Text) * C_Yard_To_NauticalMiles;
    if Andu303.Text <> '' then h := StrToFloat(Andu303.Text);
    if Andu304.Text <> '' then c := StrToFloat(Andu304.Text);
    if Andu305.Text <> '' then s := StrToFloat(Andu305.Text);

    if WCCInterface.DoBlindBomb then begin
      BtnC.UpdateBtnImage(self.btnBLINDBOMB, BtnC.greenBOX_On);
      BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.greenBOX_Off);
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnINDBOMBClick(Sender: TObject);
var b, r: double;
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    b := 0; r := 0;

    if Andu309.Text <> '' then b := StrToFloat(Andu309.Text);
    if Andu310.Text <> '' then r := StrToFloat(Andu310.Text) * C_Yard_To_NauticalMiles;

    if WCCInterface.DoIndirectBomb then begin
      BtnC.UpdateBtnImage(self.btnINDBOMB, BtnC.greenBOX_On);
      BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.greenBOX_Off);
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnGENFC2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.DoGenFix(2) then begin
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.orangeBOX_On);
      BtnC.UpdateBtnImage(self.btnFC2SBS, BtnC.greenBOX_Off);
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnGEN2Click(Sender: TObject);
begin
  BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.DoGenFix(3) then begin
      BtnC.UpdateBtnImage(TSpeedButtonImage(Sender), BtnC.orangeBOX_On);
      BtnC.UpdateBtnImage(self.btnFC3SBS, BtnC.greenBOX_Off);
    end;
  end;
end;

procedure TfrmBawah2_Singa.btnFC2_BClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if btnFC2_B.Down then
    begin
      btnFC2_B.Glyph := BtnC.greenBOX_On;
      btnFC3_B.Glyph := BtnC.greenBOX_Off;
    end
    else btnFC2_B.Glyph := BtnC.greenBOX_Off;

    WCCInterface.ShowBScope(2, btnFC2_B.Down, true);
  end;
end;

procedure TfrmBawah2_Singa.btnFC3_BClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if btnFC3_B.Down then
    begin
      btnFC3_B.Glyph := BtnC.greenBOX_On;
      btnFC2_B.Glyph := BtnC.greenBOX_Off;
    end
    else btnFC3_B.Glyph := BtnC.greenBOX_Off;
    WCCInterface.ShowBScope(3, btnFC3_B.Down, true);
  end;
end;

//**********************************************//
//      ACTION PAGE                             //
//**********************************************//
procedure TfrmBawah2_Singa.Reset_Andu_Button;
begin
  btnPREACT.Down := False;
  BtnC.UpdateBtnImage(btnPreact,BtnC.orangeBOX_Off);
  btnAIRSURF.Down := False;
  BtnC.UpdateBtnImage(btnairsurf,BtnC.greenBOX_Off);
  btnNGS.Down := False;
  BtnC.UpdateBtnImage(btnngs,BtnC.greenBOX_Off);
  btnTEST.Down := False;
  BtnC.UpdateBtnImage(btntest,BtnC.orangeBOX_Off);
  btnTV.Down := False;
  BtnC.UpdateBtnImage(btntv,BtnC.greenBOX_Off);
end;

procedure TfrmBawah2_Singa.btnPREACTClick(Sender: TObject);
begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnpreact,BtnC.orangeBOX_On);
  PreActShow;
  //preactbt.Click ;
  end;
end;

procedure TfrmBawah2_Singa.btnAIRSURFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnairsurf,BtnC.greenBOX_On);
  AirSurfShow;
  //airsurfbt.Click ;
  end;
end;

procedure TfrmBawah2_Singa.btnNGSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnNGS,BtnC.greenBOX_On);
  NgsShow;
  //ngsbt.Click;
  end;
end;

procedure TfrmBawah2_Singa.btnTESTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btntest,BtnC.orangeBOX_On);
  TestPageShow;
  //testbt.Click ;
  end;
end;

procedure TfrmBawah2_Singa.btnTVClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    self.Reset_Andu_Button;
    BtnC.UpdateBtnImage(btntv,BtnC.greenBOX_On);
    tvshow;
  end;
end;

procedure TfrmBawah2_Singa.Timer1Timer(Sender: TObject);
begin
  WCCInterface.CekGunStatus;
  
  If IsStartingFC2 then begin
    Inc(FC2_COUNTER, 1);
      If C_FC_READY_TIME = FC2_COUNTER then begin
      FC2_COUNTER := 0;
      IsStartingFC2 := False;

      BtnC.UpdateBtnImage(self.btnFC2AFS, BtnC.greenBOX_Off);
      if WCCInterface.IsFireControlInUse(2) then begin
        BtnC.UpdateImage(self.lmpFC2RDY, BtnC.greenROUND_On);
        BtnC.UpdateButton(btnFC2STO, TBSpring, GreenBOX, False);
        WCCInterface.ShowBScope(2, btnFC2_B.Down, true);
      end
      else begin
        BtnC.UpdateButton(btnFC2SBS, TBSpring, GreenBOX, True);
        BtnC.UpdateButton(btnFC2STO, TBSpring, GreenBOX, False);
      end;

    end;
  end;

  If IsStartingFC3 then begin
    Inc(FC3_COUNTER, 1);
    If (C_FC_READY_TIME = FC3_COUNTER) then begin
      FC3_COUNTER := 0;
      IsStartingFC3 := False;

      BtnC.UpdateButton(btnFC3AFS, TBSpring, GreenBOX, False);
      if WCCInterface.IsFireControlInUse(3) then  begin
        BtnC.UpdateImage(self.lmpFC3RDY, BtnC.greenROUND_On);
        BtnC.UpdateButton(btnFC3STO, TBSpring, GreenBOX, False);
        WCCInterface.ShowBScope(3, btnFC3_B.Down, true);
      end
      else begin
        BtnC.UpdateButton(btnFC3SBS, TBSpring, GreenBOX, True);
        BtnC.UpdateButton(btnFC3STO, TBSpring, GreenBOX, False);
      end;
    end;
  end;

  // Lampu Indikator senjata
  if (WCCInterface.Gun1.AssignTo <> nil) and WCCInterface.Gun1.IsInRange and (WCCInterface.Gun1.IsBlind = false) then
    if (WCCInterface.Gun1.AssignTo.Name = 'FC2') then BtnC.UpdateImage(lmpG1INRANGEFC2, BtnC.greenROUND_On)
    else BtnC.UpdateImage(lmpG1INRANGEFC3, BtnC.greenROUND_On)
  else begin
    BtnC.UpdateImage(lmpG1INRANGEFC2, BtnC.greenROUND_Off);
    BtnC.UpdateImage(lmpG1INRANGEFC3, BtnC.greenROUND_Off);
  end;

  if (WCCInterface.Gun2.AssignTo <> nil) and WCCInterface.Gun2.IsInRange and (WCCInterface.Gun2.IsBlind = false) then
    if (WCCInterface.Gun2.AssignTo.Name = 'FC2') then BtnC.UpdateImage(lmpG2INRANGEFC2, BtnC.greenROUND_On)
    else BtnC.UpdateImage(lmpG2INRANGEFC3, BtnC.greenROUND_On)
  else begin
    BtnC.UpdateImage(lmpG2INRANGEFC2, BtnC.greenROUND_Off);
    BtnC.UpdateImage(lmpG2INRANGEFC3, BtnC.greenROUND_Off);
  end;

  BtnC.UpdateBtnImage(btnG1FIREFC2, GreenBOX, WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC2'));
  BtnC.UpdateBtnImage(btnG1FIREFC3, GreenBOX, WCCInterface.Gun1.ReadyToFire and (WCCInterface.Gun1.AssignTo <> nil) and (WCCInterface.Gun1.AssignTo.Name = 'FC3'));
  BtnC.UpdateBtnImage(btnG2FIREFC2, GreenBOX, WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC2'));
  BtnC.UpdateBtnImage(btnG2FIREFC3, GreenBOX, WCCInterface.Gun2.ReadyToFire and (WCCInterface.Gun2.AssignTo <> nil) and (WCCInterface.Gun2.AssignTo.Name = 'FC3'));

  //Caption := FloatToStr(WCCInterface.Gun1.FireBreakTimer * 0.001) + ' - ' +
  //    FloatToStr(WCCInterface.Gun2.FireBreakTimer * 0.001);

  // Buat nampilin data di Andu
  ShowAnduData;
  
end;

procedure TfrmBawah2_Singa.bteraseClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    CodeInput.Text := '';
    checkbtn.Checked := false;
    ValueInput.Text := '';
    AnduCode := '';
  end;
end;

procedure TfrmBawah2_Singa.bt0Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('0');
end;

procedure TfrmBawah2_Singa.bt1Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('1');
end;

procedure TfrmBawah2_Singa.bt2Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('2');
end;

procedure TfrmBawah2_Singa.bt3Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('3');
end;

procedure TfrmBawah2_Singa.bt4Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('4');
end;

procedure TfrmBawah2_Singa.bt5Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('5');
end;

procedure TfrmBawah2_Singa.bt6Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('6');
end;

procedure TfrmBawah2_Singa.bt7Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('7');
end;

procedure TfrmBawah2_Singa.bt8Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('8');
end;

procedure TfrmBawah2_Singa.bt9Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('9');
end;

procedure TfrmBawah2_Singa.btplusClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('+');
end;

procedure TfrmBawah2_Singa.btminClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('-');
end;

procedure TfrmBawah2_Singa.btRClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('R');
end;

procedure TfrmBawah2_Singa.btLClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('L');
end;

procedure TfrmBawah2_Singa.btinsertClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    if (checkbtn.Checked = true) then insertvalue
    else getcode
end;

procedure TfrmBawah2_Singa.insertvalue ;
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
        tab := Copy(AnduCode, 5, 1);
        tempnm := Copy(AnduCode, 0, 3) + tab;
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
end;

procedure TfrmBawah2_Singa.vThrowOffChange(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
  begin
    if WCCInterface.IsFireControlInUse(2) then begin
      WCCInterface.FC3.ThrowOff := WCCInterface.ThrowOffMode(vThrowOff.SwitchPosition);
      if WCCInterface.FC3.ThrowOff then begin
        btnFC3SBSClick(nil);
        BtnC.UpdateBtnImage(btnFC3SBS, BtnC.greenBOX_Off);
      end
      else begin
        BtnC.UpdateImage(lmpFC3RDY, BtnC.greenROUND_Off);
        BtnC.UpdateBtnImage(btnFC3SBS, BtnC.greenBOX_On);
      end;
    end;
  end;
end;

procedure TfrmBawah2_Singa.tmrGunTimer(Sender: TObject);
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

  // running timer
  RunTimer;
  
end;

procedure TfrmBawah2_Singa.Button1Click(Sender: TObject);
begin
  InsertIntoAndu('1012', 8);
  InsertIntoAndu('1022', 200);
  InsertIntoAndu('1032', 15);
  InsertIntoAndu('104', 1010);
  InsertIntoAndu('105', 1030);
  InsertIntoAndu('106', 1030);
  InsertIntoAndu('107', 1030);
  InsertIntoAndu('109', 25);
  InsertIntoAndu('110', 250);
end;


end.
