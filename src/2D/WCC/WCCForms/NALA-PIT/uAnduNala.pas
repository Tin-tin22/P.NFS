unit uAnduNala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, xpPanel, Buttons, SpeedButtonImage, VrControls,
  VrDesign, uLibWCCku, ufQEK, uLibWCCClassNew;

type
  TfrmAndu = class(TfrmQEK)
    pnl1: TPanel;
    lmpimg1: TImage;
    tmr1: TTimer;
    tvpage: TxpPanel;
    Panel1: TPanel;
    btnAIRSURF: TSpeedButtonImage;
    btnTV: TSpeedButtonImage;
    btnTEST: TSpeedButtonImage;
    btnPREACT: TSpeedButtonImage;
    btnNGS: TSpeedButtonImage;
    btn3: TButton;
    btn4: TButton;
    Button1: TButton;
    btn1: TButton;
    checkbtn: TRadioButton;
    Timer1: TTimer;
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
    xpPanel1: TxpPanel;
    valueinput: TEdit;
    codeinput: TEdit;
    pnlAnduKeyboard: TPanel;
    pnl2: TPanel;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    shp4: TShape;
    btnbterase: TVrBitmapButton;
    btnbt7: TVrBitmapButton;
    btnbt4: TVrBitmapButton;
    btnbtinsert: TVrBitmapButton;
    btnbt8: TVrBitmapButton;
    btnbt5: TVrBitmapButton;
    btnbt9: TVrBitmapButton;
    btnbt6: TVrBitmapButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    btnbt2: TVrBitmapButton;
    btnbt3: TVrBitmapButton;
    btnbtplus: TVrBitmapButton;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    btnbt1: TVrBitmapButton;
    lbl12: TLabel;
    btnbt0: TVrBitmapButton;
    btnbtmin: TVrBitmapButton;
    lbl13: TLabel;
    lbl14: TLabel;
    shp5: TShape;
    shp6: TShape;
    shp7: TShape;
    shp8: TShape;
    shp9: TShape;
    shp10: TShape;
    shp11: TShape;
    shp12: TShape;
    lmp1: TImage;
    lbl15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnbteraseClick(Sender: TObject);
    procedure lmpimg1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure btnbt0Click(Sender: TObject);
    procedure btnbt1Click(Sender: TObject);
    procedure btnbt2Click(Sender: TObject);
    procedure btnbt3Click(Sender: TObject);
    procedure btnbt4Click(Sender: TObject);
    procedure btnbt5Click(Sender: TObject);
    procedure btnbt6Click(Sender: TObject);
    procedure btnbt7Click(Sender: TObject);
    procedure btnbt8Click(Sender: TObject);
    procedure btnbt9Click(Sender: TObject);
    procedure btnbtplusClick(Sender: TObject);
    procedure btnbtminClick(Sender: TObject);
    procedure btnbtinsertClick(Sender: TObject);
    procedure btnNGSClick(Sender: TObject);
    procedure btnTESTClick(Sender: TObject);
    procedure btnPREACTClick(Sender: TObject);
    procedure btnAIRSURFClick(Sender: TObject);
    procedure btnTVClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }

    AnduCode : string;
    FInputOnOff: boolean;

    function SplitPage(const s: string): integer;
    function SplitEditName(const s: string): string;

    function GetLine(const aCode: string): string;
    function GetValue(const aCode: string): string;
    function ValidateCode(const aCode: string): boolean;
    function ValidateValue(const aCode, aVal: string): boolean;
    function CekOnOff(const aCode: string): boolean;

    procedure InsertIntoAndu(const code: string; const val: double);


     procedure SetPosMonitorAndu;
    procedure PreActShow;
    procedure AirSurfShow;
    procedure NgsShow;
    procedure TestPageShow;
    procedure getcode;
    procedure ApplyNumber(text: string);
    procedure insertvalue;
    procedure ShowAnduData;


  public
    { Public declarations }
    procedure Reset_Andu_Button;
    procedure SetInitialValueAndu;
    procedure tvshow;
    procedure SetOffBtnAndIndikator; override;

  end;

//var
//  Form1: TForm1;


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

{$R *.dfm}

procedure TfrmAndu.FormCreate(Sender: TObject);
begin
  inherited;
  codeinput.Focused ;
  tvpage.Visible :=true;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=false;

end;

procedure TfrmAndu.FormShow(Sender: TObject);
begin
  inherited;
  Reset_Andu_Button;

end;

function TfrmAndu.SplitPage(const s: string): integer;
begin
  result := StrToInt(Copy(s, 0, 1));
end;

function TfrmAndu.SplitEditName(const s: string): string;
begin
  result := Copy(s, 5, Length(s) - 1);
end;

function TfrmAndu.GetLine(const aCode: string): string;
var tCode: string;
    i: integer;
begin
  result := '';

  tCode := Copy(aCode, 0, 3);
  for i:=1 to C_LineLength do begin
    if thecode[i] = tCode then result := theline[i];
  end;
end;

function TfrmAndu.GetValue(const aCode: string): string;
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

function TfrmAndu.ValidateCode(const aCode: string): boolean;
var i: integer;
begin
  result := false;

  for i:=1 to C_CodeTypeLength do
    if listcode[i] = aCode then result := true;
end;

function TfrmAndu.ValidateValue(const aCode, aVal: string): boolean;
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

function TfrmAndu.CekOnOff(const aCode: string): boolean;
begin
  if (aCode = 'ON') or (aCode = 'OFF') then result := true
  else result := false;
end;

//ANDU

procedure TfrmAndu.SetPosMonitorAndu;
var leftpos, TopPos : Integer;
begin
  leftpos := 37;
  TopPos := 42;

  preactpage.left:=leftpos;
  preactpage.Top :=TopPos;
  airsurfpage.left:=leftpos;
  airsurfpage.Top :=TopPos;
  testpage.left:=leftpos;
  testpage.Top :=TopPos;
  ngspage.left:=leftpos;
  ngspage.Top :=TopPos;
  tvpage.left:=leftpos;
  tvpage.Top :=TopPos;

end;

procedure TfrmAndu.PreActShow;
begin
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=true;
  testpage.Visible :=false;
  codeinput.Visible  := true;
  Valueinput.Visible := true;
  SetPosMonitorAndu;
end;

procedure TfrmAndu.AirSurfShow ;
begin
  SetPosMonitorAndu;
  tvpage.Visible :=false;
  airsurfpage.Visible :=true;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=false;
  codeinput.Visible  := true;
  Valueinput.Visible := true;
end;

procedure TfrmAndu.TestPageShow;
begin
  SetPosMonitorAndu;
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  preactpage.Visible :=false;
  testpage.Visible :=true;
  codeinput.Visible  := true;
  Valueinput.Visible := true;
end;

procedure TfrmAndu.NgsShow;
begin
  SetPosMonitorAndu;
  tvpage.Visible :=false;
  airsurfpage.Visible :=false;
  ngspage.Visible :=true;
  preactpage.Visible :=false;
  testpage.Visible :=false;
  codeinput.Visible  := true;
  Valueinput.Visible := true;
end;

procedure TfrmAndu.tvshow ;
begin
  SetPosMonitorAndu;
  tvpage.Visible :=true;
  airsurfpage.Visible :=false;
  ngspage.Visible :=false;
  codeinput.Visible :=false;
  Valueinput.Visible :=false;

  preactpage.Visible :=false;
  testpage.Visible :=false;
end;


procedure TfrmAndu.Timer1Timer(Sender: TObject);
begin
  inherited;
  ShowAnduData;
end;

procedure TfrmAndu.getcode;
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

procedure TfrmAndu.ApplyNumber(text: string);
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

procedure TfrmAndu.ShowAnduData;
var rng, brg : Double;
Gun : TGun;
i : Integer;
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
    Andu311.Text :=  WCCInterface.WCCAndu.Page_3[C_Gun_Tgt_Line].ToString;
  end;
    Andu312.Text :=  WCCInterface.WCCAndu.Page_3[C_Gun1TOF].ToString;
end;

procedure TfrmAndu.btnbteraseClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    CodeInput.Text := '';
    checkbtn.Checked := false;
    ValueInput.Text := '';
    AnduCode := '';
  end;
end;

procedure TfrmAndu.btnbt0Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('0');
end;

procedure TfrmAndu.btnbt1Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('1');
end;

procedure TfrmAndu.btnbt2Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('2');
end;

procedure TfrmAndu.btnbt3Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('3');
end;

procedure TfrmAndu.btnbt4Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('4');
end;

procedure TfrmAndu.btnbt5Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('5');
end;

procedure TfrmAndu.btnbt6Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('6');
end;

procedure TfrmAndu.btnbt7Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('7');
end;

procedure TfrmAndu.btnbt8Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('8');
end;

procedure TfrmAndu.btnbt9Click(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('9');
end;

procedure TfrmAndu.btnbtplusClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('+');
end;

procedure TfrmAndu.btnbtminClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    applynumber('-');
end;

procedure TfrmAndu.btnNGSClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnNGS,BtnC.greenBOX_On);
  NgsShow;
  //ngsbt.Click;
  end;
end;

procedure TfrmAndu.btnbtinsertClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then
    if (checkbtn.Checked = true) then begin
      insertvalue;
    end
    else
      getcode;
end;

procedure TfrmAndu.insertvalue;
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
        if indx > 0 then btnbteraseClick(nil);  //reset field
      end;
    end;
    btnbteraseClick(nil);
end;

procedure TfrmAndu.SetInitialValueAndu;
begin
  WCCInterface.WCCAndu.Page_1[C_WindSpeed].SetValue(0.0);
  WCCInterface.WCCAndu.Page_1[C_WindDir].SetValue(0.0);
  WCCInterface.WCCAndu.Page_1[C_AirTemp].SetValue(30.0);
  WCCInterface.WCCAndu.Page_1[C_AirPressure].SetValue(1011.0);
  WCCInterface.WCCAndu.Page_1[C_MuzzleV1].SetValue(800.0);
  WCCInterface.WCCAndu.Page_1[C_MuzzleV2].SetValue(985.0);
  WCCInterface.WCCAndu.Page_1[C_MuzzleV3].SetValue(985.0);
  WCCInterface.WCCAndu.Page_1[C_Latitude].SetValue(0.0);
  WCCInterface.WCCAndu.Page_1[C_AirTargetHeight].SetValue(100.0);

  Andu2101.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2102.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2103.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2111.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2112.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2113.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2121.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2122.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu2123.OnChange := WCCInterface.Correction_OnAnduChange;
  Andu306.OnChange  := WCCInterface.Correction_OnAnduChange;
  Andu307.OnChange  := WCCInterface.Correction_OnAnduChange;
  Andu308.OnChange  := WCCInterface.Correction_OnAnduChange;


//  Andu301.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu302.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu303.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu304.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu305.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu309.OnChange := WCCInterface.Update_OnAnduChange;
//  Andu310.OnChange := WCCInterface.Update_OnAnduChange;


end;

procedure TfrmAndu.SetOffBtnAndIndikator;
begin
  inherited;

end;

procedure TfrmAndu.lmpimg1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
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

procedure TfrmAndu.Button1Click(Sender: TObject);
begin
  InsertIntoAndu('101', 0);
  InsertIntoAndu('102', 0);
  InsertIntoAndu('103', 30);
  InsertIntoAndu('104', 1011);
  InsertIntoAndu('105', 800);  // initial 800
  InsertIntoAndu('106', 985);
  InsertIntoAndu('107', 985);
  InsertIntoAndu('108', 0);
  InsertIntoAndu('109', 100);

end;

procedure TfrmAndu.InsertIntoAndu(const code: string; const val: double);
begin
  valueinput.Text := FloatToStr(val);
  checkbtn.Checked := true;
  AnduCode := code;
  insertvalue;
end;

procedure TfrmAndu.btn1Click(Sender: TObject);
begin
  inherited;
  InsertIntoAndu('301', 135);
  InsertIntoAndu('302', 4800);
  InsertIntoAndu('303', 40);
  InsertIntoAndu('304', 0);
  InsertIntoAndu('305', 0);
  btnbteraseClick(nil);

end;

procedure TfrmAndu.btn3Click(Sender: TObject);
begin
  inherited;
  InsertIntoAndu('309', 35);
  InsertIntoAndu('310', 5000);

end;

procedure TfrmAndu.btnAIRSURFClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnairsurf,BtnC.greenBOX_On);
  AirSurfShow;
  //airsurfbt.Click ;
  end;
end;

procedure TfrmAndu.btnPREACTClick(Sender: TObject);
begin
 if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btnpreact,BtnC.orangeBOX_On);
  PreActShow;
  //preactbt.Click ;
  end;
end;

procedure TfrmAndu.btnTESTClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
  //BtnC.SpringLoaded(TSpeedButtonImage(Sender));
  self.Reset_Andu_Button;
  BtnC.UpdateBtnImage(btntest,BtnC.orangeBOX_On);
  TestPageShow;
  //testbt.Click ;
  end;
end;

procedure TfrmAndu.btnTVClick(Sender: TObject);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON then begin
    self.Reset_Andu_Button;
    BtnC.UpdateBtnImage(btntv,BtnC.greenBOX_On);
    tvshow;
  end;
end;

procedure TfrmAndu.Reset_Andu_Button;
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

end.
