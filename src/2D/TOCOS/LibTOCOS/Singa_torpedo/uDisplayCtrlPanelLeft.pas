unit uDisplayCtrlPanelLeft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Buttons, SpeedButtonImage, ufQEK,
  VrControls, VrWheel, VrButtons,  VrRotarySwitch,  uLibTDCClass,
  uBaseSimulationObject, uTorpedoTrack, uLibTDC_Object, uLibTDCTracks;

type
  TUnitTipe = (Deg, Knt, Yrd, UpLim_Ft, LoLim_Ft, Sec, Day, Year, Lat);

  TvDisplayCtrlPanelLeft = class(TfrmQEK)
    pPage9: TPanel;
    Edit290: TEdit;
    Edit292: TEdit;
    Edit293: TEdit;
    Edit294: TEdit;
    Edit295: TEdit;
    Edit296: TEdit;
    Edit297: TEdit;
    Edit298: TEdit;
    Edit299: TEdit;
    Edit300: TEdit;
    Edit301: TEdit;
    Edit302: TEdit;
    Edit303: TEdit;
    Edit304: TEdit;
    Edit305: TEdit;
    pPage8: TPanel;
    Edit274: TEdit;
    Edit275: TEdit;
    Edit276: TEdit;
    Edit277: TEdit;
    Edit278: TEdit;
    Edit279: TEdit;
    Edit280: TEdit;
    Edit281: TEdit;
    Edit282: TEdit;
    Edit283: TEdit;
    Edit284: TEdit;
    Edit285: TEdit;
    Edit286: TEdit;
    Edit287: TEdit;
    Edit288: TEdit;
    Edit291: TEdit;
    pPage6: TPanel;
    Edit239: TEdit;
    Edit240: TEdit;
    Edit241: TEdit;
    Edit242: TEdit;
    Edit243: TEdit;
    Edit244: TEdit;
    Edit245: TEdit;
    Edit246: TEdit;
    Edit247: TEdit;
    Edit248: TEdit;
    Edit249: TEdit;
    Edit250: TEdit;
    Edit251: TEdit;
    Edit252: TEdit;
    txtget603: TEdit;
    txt603: TEdit;
    txt606_1: TEdit;
    txt607_1: TEdit;
    txt609_1: TEdit;
    txt608_1: TEdit;
    txt612_1: TEdit;
    txt611_1: TEdit;
    txt610_1: TEdit;
    txt606_2: TEdit;
    txt607_2: TEdit;
    txt608_2: TEdit;
    txt609_2: TEdit;
    txt610_2: TEdit;
    txt611_2: TEdit;
    txt612_2: TEdit;
    txt614_2: TEdit;
    txt615: TEdit;
    txt614_1: TEdit;
    pPage4: TPanel;
    Edit174: TEdit;
    Edit175: TEdit;
    Edit176: TEdit;
    Edit177: TEdit;
    Edit178: TEdit;
    Edit179: TEdit;
    Edit180: TEdit;
    Edit181: TEdit;
    Edit182: TEdit;
    Edit183: TEdit;
    Edit184: TEdit;
    Edit185: TEdit;
    Edit186: TEdit;
    Edit187: TEdit;
    Edit188: TEdit;
    txttargetno_1: TEdit;
    targetbearing1: TEdit;
    targetrange1: TEdit;
    targetcourse1: TEdit;
    targetspeed1: TEdit;
    targetBngrat1: TEdit;
    targetAob1: TEdit;
    txttargetno_2: TEdit;
    targetbearing2: TEdit;
    targetrange2: TEdit;
    targetcourse2: TEdit;
    targetspeed2: TEdit;
    targetBngrat2: TEdit;
    targetAob2: TEdit;
    pPage3: TPanel;
    Edit140: TEdit;
    Edit141: TEdit;
    Edit142: TEdit;
    Edit143: TEdit;
    Edit144: TEdit;
    Edit145: TEdit;
    Edit146: TEdit;
    Edit147: TEdit;
    Edit148: TEdit;
    Edit149: TEdit;
    Edit150: TEdit;
    Edit151: TEdit;
    Edit152: TEdit;
    Edit153: TEdit;
    Edit154: TEdit;
    txtget303: TEdit;
    txtget305: TEdit;
    txtget306: TEdit;
    txtget307: TEdit;
    txtget308: TEdit;
    txtget309: TEdit;
    txtget310: TEdit;
    txtget312: TEdit;
    txtget313: TEdit;
    txtget3122: TEdit;
    txtget3132: TEdit;
    txtget3032: TEdit;
    txtget3052: TEdit;
    txtget3062: TEdit;
    txtget3072: TEdit;
    txtget3082: TEdit;
    txtget3092: TEdit;
    txtget3102: TEdit;
    pPage2: TPanel;
    Edit103: TEdit;
    Edit104: TEdit;
    Edit108: TEdit;
    Edit109: TEdit;
    Edit110: TEdit;
    Edit111: TEdit;
    Edit112: TEdit;
    Edit113: TEdit;
    Edit114: TEdit;
    Edit115: TEdit;
    Edit116: TEdit;
    Edit117: TEdit;
    Edit118: TEdit;
    Edit119: TEdit;
    Edit120: TEdit;
    txt203: TEdit;
    txtget203: TEdit;
    txtget204: TEdit;
    txtget205: TEdit;
    txtget206: TEdit;
    txt209: TEdit;
    txt207: TEdit;
    txt208: TEdit;
    txt211: TEdit;
    txtget212: TEdit;
    txtget213: TEdit;
    txtget211: TEdit;
    ttxtget2122: TEdit;
    txtget2132: TEdit;
    Edit136: TEdit;
    Edit137: TEdit;
    Edit138: TEdit;
    Edit139: TEdit;
    txt204: TEdit;
    Ppage1: TPanel;
    Edit69: TEdit;
    Edit70: TEdit;
    Edit71: TEdit;
    Edit72: TEdit;
    Edit73: TEdit;
    Edit74: TEdit;
    Edit75: TEdit;
    Edit76: TEdit;
    Edit77: TEdit;
    Edit78: TEdit;
    Edit79: TEdit;
    Edit80: TEdit;
    Edit81: TEdit;
    Edit82: TEdit;
    Edit83: TEdit;
    Panel1: TPanel;
    checkbtn: TRadioButton;
    Timer1: TTimer;
    ILORANGEROUND: TImageList;
    Panel2: TPanel;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox9: TGroupBox;
    vrReset: TVrDemoButton;
    vrInsert: TVrDemoButton;
    vr7: TVrDemoButton;
    vr8: TVrDemoButton;
    vr9: TVrDemoButton;
    vrPage: TVrDemoButton;
    vrTab: TVrDemoButton;
    vr6: TVrDemoButton;
    vr5: TVrDemoButton;
    vr4: TVrDemoButton;
    vr1: TVrDemoButton;
    vr2: TVrDemoButton;
    vr3: TVrDemoButton;
    vrPlus: TVrDemoButton;
    vrMinus: TVrDemoButton;
    vrEnter: TVrDemoButton;
    vr0: TVrDemoButton;
    sign22: TLabel;
    sign21: TLabel;
    sign24: TLabel;
    sign25: TLabel;
    sign26: TLabel;
    sign27: TLabel;
    sign28: TLabel;
    sign29: TLabel;
    sign210: TLabel;
    sign211: TLabel;
    sign212: TLabel;
    sign213: TLabel;
    sign41: TLabel;
    sign23: TLabel;
    sign42: TLabel;
    pPage5: TPanel;
    sign51: TLabel;
    Edit197: TEdit;
    Edit198: TEdit;
    Edit199: TEdit;
    Edit200: TEdit;
    Edit208: TEdit;
    Edit209: TEdit;
    Edit210: TEdit;
    Edit211: TEdit;
    Edit212: TEdit;
    Edit213: TEdit;
    Edit214: TEdit;
    Edit215: TEdit;
    Edit216: TEdit;
    Edit217: TEdit;
    Edit218: TEdit;
    txtget503: TEdit;
    txt503: TEdit;
    txt506_1: TEdit;
    txt507_1: TEdit;
    txt509_1: TEdit;
    txt508_1: TEdit;
    txt512_1: TEdit;
    txt511_1: TEdit;
    txt510_1: TEdit;
    txt506_2: TEdit;
    txt507_2: TEdit;
    txt508_2: TEdit;
    txt509_2: TEdit;
    txt510_2: TEdit;
    txt511_2: TEdit;
    txt512_2: TEdit;
    txt514_2: TEdit;
    txt515: TEdit;
    txt514_1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    sign52: TLabel;
    sign53: TLabel;
    sign54: TLabel;
    sign55: TLabel;
    sign56: TLabel;
    sign57: TLabel;
    sign58: TLabel;
    sign59: TLabel;
    sign510: TLabel;
    sign511: TLabel;
    sign512: TLabel;
    sign513: TLabel;
    sign514: TLabel;
    sign515: TLabel;
    Edit11: TEdit;
    sign61: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    sign62: TLabel;
    sign63: TLabel;
    sign64: TLabel;
    sign65: TLabel;
    sign66: TLabel;
    sign67: TLabel;
    sign68: TLabel;
    sign69: TLabel;
    sign610: TLabel;
    sign611: TLabel;
    sign612: TLabel;
    sign613: TLabel;
    sign614: TLabel;
    sign615: TLabel;
    code: TEdit;
    CodeInput: TEdit;
    txtValue: TEdit;
    txtValue2: TEdit;
    signVal1: TEdit;
    signVal2: TEdit;
    txt214_1: TEdit;
    txt214_2: TEdit;
    txt214_3: TEdit;
    txtDate: TEdit;
    txt2142_1: TEdit;
    txt2142_2: TEdit;
    txt2142_3: TEdit;
    txtTime: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    imgBackground: TImage;
    lmp1: TImage;
    lbl1: TLabel;


    procedure FormCreate(Sender: TObject);
    procedure vr0Click(Sender: TObject);
    procedure vr1Click(Sender: TObject);
    procedure vr2Click(Sender: TObject);
    procedure vr3Click(Sender: TObject);
    procedure vr4Click(Sender: TObject);
    procedure vr5Click(Sender: TObject);
    procedure vr6Click(Sender: TObject);
    procedure vr7Click(Sender: TObject);
    procedure vr8Click(Sender: TObject);
    procedure vr9Click(Sender: TObject);
    procedure vrPageClick(Sender: TObject);
    procedure vrResetClick(Sender: TObject);
    procedure vrTabClick(Sender: TObject);
    procedure vrInsertClick(Sender: TObject);
    procedure vrPlusClick(Sender: TObject);
    procedure vrMinusClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure txt512_2Change(Sender: TObject);
    procedure txt612_2Change(Sender: TObject);
    procedure txt507_1Change(Sender: TObject);
    procedure txt607_1Change(Sender: TObject);
    procedure txt214_3Change(Sender: TObject);
    procedure txt2142_3Change(Sender: TObject);
    procedure txt510_2Change(Sender: TObject);
    procedure txt606_1Change(Sender: TObject);
    procedure txt506_1Change(Sender: TObject);
    procedure txt608_1Change(Sender: TObject);
  private
    trackIndex, tabNo : Integer;
    textDate : Boolean;
    procedure ResetVal;
    procedure AnduData_Page2;
    procedure AnduData_Page3;
    procedure AnduData_Page4;
    procedure AnduData_Page5;
    procedure AnduData_Page6;
    procedure AnduData_RunOff(launcher: TTube);
    procedure Clear_Page;




  public
    trackNo: TStringList;

    procedure SetLocalVariable(tdc :TGenericTDCInterface); override;
    procedure ApplyNumber(text: string);
    procedure insertValue;
    procedure getValue;
    procedure SetPosAnduPAnel;
    procedure pPage1Show;
    procedure pPage2Show;
    procedure pPage3Show;
    procedure pPage4Show;
    procedure pPage5Show;
    procedure pPage6Show;
    procedure pPage8Show;
    procedure pPage9Show;
    procedure AnduData;
    function VAlidateValue(val : single; Unittipe : TUnitTipe): single;
    procedure ShowDataByMode(mode : TPredm; tube : TTube);
    procedure SystemOff;
  end;

const
    linename : array [1..79] of string =
        ( '  C O U R S E      D E G',                     // 1
          '  S P E E D           K N',                      // 2
          '  L A T               D E G',                    // 3
          '  S P E E D           K N',                      // 4
          '  D A T E',                                      // 5
          '  L T',                                          // 6
          '  T A R G E T         N O',                      // 7
          '  L A D I S',                                    // 8
          '  L A D I S           Y D',                      // 9
          '  C S P E D           K N',                      // 10
          '  U P L I M           F T',                      // 11
          '  L O L I M           F T',                      // 12
          '  T A R G E T         N O',                      // 13
          '  I N T E R V A L     S E C',                    // 14
          '  I D E N T',                                    // 15
          '  C O U R S           D E G',                    // 16
          '  S P E E D           K N',                      // 17
          '  O P E R M O D E',                              // 18
          '  T R A C K  G E N',                             // 19
          '  T A C   N A V',                                // 20
          '  D A T E',                                      // 21
          '  R U N',                                        // 22
          '  P R E D M',                                    // 23
          '  S P E E D',                                    // 24
          '  H O M N G',                                    // 25
          '  M O D E',                                      // 26
          '  L O L I M',                                    // 27
          '  H B L C K',                                    // 28
          '  T C O M   U N I T',                            // 29
          '  T C O M   U N I T',                            // 30
          '  X - Y   P L O T T I N G   A R E A   L P D',    // 31
          '  S Q U A R E   W I D T H   Y D / C M',          // 32
          '  T O R P  I N D E N T',                         // 33
          '  P L O T',                                      // 34
          '  L O G P O S',                                  // 35
          '  0',                                            // 36
          '  9',                                            // 37
          '  1',                                            // 38
          '  2',                                            // 39
          '  3',                                            // 40
          '  4',                                            // 41
          '  5',                                            // 42
          '  6',                                            // 43
          '  7',                                            // 44
          '  8',                                            // 45
          '  C H A N L',                                    // 46
          '  S E N S R',                                    // 47
          '  D I S P L',                                    // 48
          '  T C C',                                        // 49
          '  C H T C C',                                    // 50
          '  S H I P S',                                    // 51
          '  L P D T',                                      // 52
          '  D I S C R',                                    // 53
          '  C H W E C',                                    // 54
          '  A N D T',                                      // 55
          '  D A C O N',                                    // 56
          '  L O O P T',                                    // 57
          '  M I S C L',                                    // 58
          '  I N T E R',                                    // 59
          '  W E C',                                        // 60
          '  C M P T R',                                    // 61
          '  T D P',                                        // 62
          '  D I S C R',                                    // 63
          '  D A L O G',                                    // 64
          '  P H S',                                        // 65
          '  N U G   1',                                    // 66
          '  C S R',                                        // 67
          '  N U G   2',                                    // 68
          '  T T W',                                        // 69
          '  P O W E R',                                    // 70
          '  O B M *         D E G	',                      // 71
          '  O B M *         Y D	',                        // 72
          '  C O U R S       D E G	',                      // 73
          '  D E P T H       F T	',                        // 74
          '  E N D I S       Y D	',                        // 75
          '  X *             Y D	',                        // 76
          '  Y *             Y D	',                        // 77
          '  S R E E L           Y D',                      // 78
          '  T R E E L           Y D');                     // 79

    linecode : array [1..59] of string =
        ( 'P  A  G  E  1',  {1}        'P  A  G  E  2',  {2}
          'P  A  G  E  3',  {3}        'P  A  G  E  4',  {4}
          'P  A  G  E  5',  {5}        'P  A  G  E  6',  {6}
          'P  A  G  E  8',  {7}        'P  A  G  E  9',  {8}
          '  2  0  3',   {9}        '  2  0  4', {10}        '  2  0  7',   {11}       '  2  0  8',   {12}
          '  2  0  9',   {13}       '  2  1  1', {14}        '  2  1  2',   {15}       '  2  1  4',   {16}
          '  4  0  3',   {17}       '  5  0  3', {18}        '  5  0  6',   {19}       '  5  0  7',   {20}
          '  5  0  8',   {21}       '  5  0  9', {22}        '  5  0  9',   {23}       '  5  1  0',   {24}
          '  5  1  1',   {25}       '  5  1  2', {26}        '  5  1  4',   {27}       '  6  0  3',   {28}
          '  6  0  6',   {29}       '  6  0  7', {30}        '  6  0  8',   {31}       '  6  0  9',   {32}
          '  6  1  0',   {33}       '  6  1  1', {34}        '  6  1  2',   {35}       '  6  1  4',   {36}
          '  8  0  3',   {37}       '  8  0  5', {38}        '  8  0  7',   {39}       '  8  0  8',   {40}
          '  8  0  9',   {41}       '  8  0  9', {42}        '  8  1  2',   {43}       '  8  1  3',   {44}
          '  8  1  4',   {45}       '  8  1  5', {46}        '  9  0  3',   {47}       '  9  0  4',   {48}
          '  9  0  5',   {49}       '  9  0  6', {50}        '  9  1  0',   {51}       '  9  1  1',   {52}
          '  9  1  2',   {53}       '  9  1  3', {54}        '  9  1  4',   {55}       '  9  1  4',   {56}
          '  5  1  5',   {57}       '  6  1  5', {58}        'P  A  G  E  7');{59}

implementation

uses
  uLibTorpedo_singa, uLibRadar, uDetected, uBaseFunction, uBaseConstan, math, uAnduProc,
  uTCPDatatype, StrUtils;

var
  TOCOS : TTorpedoInterface;


{$R *.dfm}

procedure TvDisplayCtrlPanelLeft.SetLocalVariable(tdc :TGenericTDCInterface);
begin
  TOCOS := tdc  AS TTorpedoInterface;
end;


procedure TvDisplayCtrlPanelLeft.FormCreate(Sender: TObject);
begin
  Self.Width  := 645;
  Timer1.Enabled := True;
  trackNo     := TStringList.Create;
  trackIndex  := 0;
  textDate    := False;
  tabNo       := 0;
end;

procedure TvDisplayCtrlPanelLeft.Timer1Timer(Sender: TObject);
begin
  AnduData;
end;
//==================== menampilkan data di ANDU ================================
procedure TvDisplayCtrlPanelLeft.ApplyNumber(text: string);
begin
    if checkbtn.Checked =true then begin
       if tabNo=1 then begin
          if code.Text = linecode[16] then
            txt214_3.Text := txt214_3.Text + text
          else
            txtvalue.Text := txtvalue.Text + text;
       end
       else if tabNo=2 then begin
          if code.Text = linecode[16] then
            txt2142_3.Text := txt2142_3.Text + text
          else
            txtValue2.Text := txtValue2.Text + text;
       end;
    end
    else  CodeInput.Text := CodeInput.Text + text;
    getValue;
end;

procedure TvDisplayCtrlPanelLeft.Clear_Page;
begin
  txtget303.Text := '';   txtget3032.Text := '';
  txtget305.Text := '';   txtget3052.Text := '';
  txtget306.Text := '';   txtget3062.Text := '';
  txtget307.Text := '';   txtget3072.Text := '';
  txtget308.Text := '';   txtget3082.Text := '';
  txtget309.Text := '';   txtget3092.Text := '';
  txtget310.Text := '';   txtget3102.Text := '';
  txtget312.Text := '';   txtget3122.Text := '';
end;

procedure TvDisplayCtrlPanelLeft.AnduData;
begin
  AnduData_Page2;
  AnduData_Page3;
  AnduData_Page4;
  AnduData_Page5;
  AnduData_Page6;
end;

procedure TvDisplayCtrlPanelLeft.SetPosAnduPAnel;
Var l,t : Integer;
begin
  l  := 26;
  t  := 47;
 pPage1.Left :=l;pPage1.Top:=t;
 pPage2.Left :=l;pPage2.Top:=t;
 pPage3.Left :=l;pPage3.Top:=t;
 pPage4.Left :=l;pPage4.Top:=t;
 pPage5.Left :=l;pPage5.Top:=t;
 pPage6.Left :=l;pPage6.Top:=t;
 pPage8.Left :=l;pPage8.Top:=t;
 pPage9.Left :=l;pPage9.Top:=t;
end;

procedure TvDisplayCtrlPanelLeft.ShowDataByMode(mode: TPredm; tube : TTube);
var Is_shown :Boolean;
    Trp :TTorpedoTrack;
    i : Byte;
begin
  Is_shown := false;

  case mode of
    mIntercept: begin
     Is_shown := True;
    end;

    mBearingRider: begin
      Is_shown := false;

    end;
    mNone, mManualNavigate: exit;
  end;

  case tube of
    ttPort      : txt606_2.Visible := Is_shown;
    ttStarBoard : txt506_2.Visible := Is_shown;
  end;

  If not TOCOS.GetTorp_fromTube(tube,i,Trp) then begin
     if Assigned(TOCOS.torpManual) then
        Trp := TOCOS.torpManual;
  end;

  if Assigned(Trp) then begin
    Trp.PredMod := mode;
    TOCOS.SendTorpDatato3D(Trp);
  end;
end;

procedure TvDisplayCtrlPanelLeft.pPage1show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=true;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
end;

procedure TvDisplayCtrlPanelLeft.pPage2Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
  pPage2.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage3Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
  pPage3.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage4Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
  pPage4.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage5Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
  pPage5.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage6Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=false;
  pPage6.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage8Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage9.Visible :=false;
  pPage8.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.pPage9Show;
begin
  SetPosAnduPAnel;
  pPage1.Visible :=false;
  pPage2.Visible :=false;
  pPage3.Visible :=false;
  pPage4.Visible :=false;
  pPage5.Visible :=false;
  pPage6.Visible :=false;
  pPage8.Visible :=false;
  pPage9.Visible :=true;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_Page2;
begin
  {== PAGE 2 ==}
   if pPage2.Visible then begin
      // course
      if (txt203.Text = 'A U T') then
        txtget203.Text := GetValToStr(RoundTo(TOCOS.xSHIP.Heading,-2));
      // speed
      if (txt204.Text = 'A U T') then
        txtget204.Text := GetValToStr(RoundTo(TOCOS.xSHIP.Speed,-2));
      // Roll
      txtget205.Text := GetValToStr(RoundTo(TOCOS.xSHIP.Roll,-2));
      // Pitch
      txtget206.Text := GetValToStr(RoundTo(TOCOS.xSHIP.Pitch,-2));
   end;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_Page3;
var
  list : TList;
  tR : TTorpedoTrack;
begin
  if (pPage3.Visible) then
  begin
    Clear_Page;

    list := TOCOS.torp_tocos.GetList;
    if (list.Count > 0) then
    begin
      {-- torpedo 1 --}
      tR := list.items[0];
      if not tR.IsNoTarget then
      begin
        txtget303.Text := SetTrackNoToAND(GetTrackNo(tR.TargetTrack.ShipTrackId,tR.TargetTrack.TrackNumber));
        txtget305.Text := GetValToStr(RoundTo(CalcBearing(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                          tR.TargetTrack.PositionX,tR.TargetTrack.PositionY),-2));
        txtget306.Text := GetValToStr(RoundTo(CalcRange(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                          tR.TargetTrack.PositionX,tR.TargetTrack.PositionY) * C_NauticalMiles_To_Yard,-2));
        txtget307.Text := GetValToStr(RoundTo(tR.TargetTrack.Course,-2));
        txtget308.Text := GetValToStr(RoundTo(tR.TargetTrack.Speed,-2));
        txtget312.Text := GetTubeStr(tR.Tube);
      end;

      {-- torpedo 2 --}
      if (list.Count > 1) then
      begin
        tR := list.items[1];
        if not tR.IsNoTarget then
        begin
          txtget3032.Text := SetTrackNoToAND(GetTrackNo(tR.TargetTrack.ShipTrackId,tR.TargetTrack.TrackNumber));
          txtget3052.Text := GetValToStr(RoundTo(CalcBearing(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                             tR.TargetTrack.PositionX,tR.TargetTrack.PositionY),-2));
          txtget3062.Text := GetValToStr(RoundTo(CalcRange(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                             tR.TargetTrack.PositionX,tR.TargetTrack.PositionY) * C_NauticalMiles_To_Yard,-2));
          txtget3072.Text := GetValToStr(RoundTo(tR.TargetTrack.Course,-2));
          txtget3082.Text := GetValToStr(RoundTo(tR.TargetTrack.Speed,-2));
          txtget3122.Text := GetTubeStr(tR.Tube);
        end;
      end;
    end ;
  end;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_Page4;
var
  s: String;
  aMTrack : TManualTrack;
  findTrack : Boolean;
begin
  {== PAGE 4 ==}
   if pPage4.Visible then begin
      // target I
      if (txttargetno_1.Text <> '') then begin
          s:= StringReplace(txttargetno_1.Text,' ','',[rfReplaceAll]);
          findTrack := TOCOS.FindTrack_by_TrackNo(s,aMTrack);
          if findTrack then begin
              targetbearing1.Text := GetValToStr(RoundTo(CalcBearing(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                              aMTrack.PositionX,aMTrack.PositionY),-2));
              targetrange1.Text := GetValToStr(RoundTo(CalcRange(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                              aMTrack.PositionX,aMTrack.PositionY) * C_NauticalMiles_To_Yard,-2));
              targetcourse1.Text := GetValToStr(ValidateDegree(RoundTo(aMTrack.Course,-2)));
              targetspeed1.Text := GetValToStr(RoundTo(aMTrack.Speed,-2));
          end
          else begin
              targetbearing1.Text := ' ';
              targetrange1.Text := ' ';
              targetcourse1.Text := ' ';
              targetspeed1.Text := ' ';
          end;
      end
      else begin
          targetbearing1.Text := ' ';
          targetrange1.Text := ' ';
          targetcourse1.Text := ' ';
          targetspeed1.Text := ' ';
      end;

      // target 2
      if (txttargetno_2.Text <> '') then begin
          s:= StringReplace(txttargetno_2.Text,' ','',[rfReplaceAll]);
          findTrack := TOCOS.FindTrack_by_TrackNo(s,aMTrack);
          if findTrack then begin
              targetbearing2.Text := GetValToStr(RoundTo(CalcBearing(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                                aMTrack.PositionX,aMTrack.PositionY),-2));
              targetrange2.Text := GetValToStr(RoundTo(CalcRange(TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY,
                              aMTrack.PositionX,aMTrack.PositionY) * C_NauticalMiles_To_Yard,-2));
              targetcourse2.Text := GetValToStr(ValidateDegree(RoundTo(aMTrack.Course,-2)));
              targetspeed2.Text := GetValToStr(RoundTo(aMTrack.Speed,-2));
          end
          else begin
              targetbearing2.Text := ' ';
              targetrange2.Text := ' ';
              targetcourse2.Text := ' ';
              targetspeed2.Text := ' ';
          end;
      end
      else begin
          targetbearing2.Text := ' ';
          targetrange2.Text := ' ';
          targetcourse2.Text := ' ';
          targetspeed2.Text := ' ';
      end;
   end;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_Page5;
var
  i             :Byte;
  torpTotrgt,
  Endist_Remains,
  sreel,treel   : Double;
  tR            :TTorpedoTrack;
begin
  { == PAGE 5 == }
  if (pPage5.Visible) then begin
    if not TOCOS.GetTorp_fromTube(ttStarBoard,i,tR) then begin
      if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = ttStarBoard) then
          tR := TOCOS.torpManual;
    end;

    if Assigned(tR) then
    begin
      if tR.IsNoTarget then
      begin
        sreel := 15311.0 - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);

        if sreel <= 0 then
        begin
          sreel := 0;
          treel := 20122.0 + 15311.0 - (RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2));
        end
        else
          treel := 20122.0;

        Endist_Remains := tR.EnablingDistance - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);
        if Endist_Remains <= 0 then
             Endist_Remains := 0;

        tR.TrackView.Show_Endist := Endist_Remains > 0;

        txtget503.Text := '';                                     {Target No}
        txt506_1.Text := GetPredmStr(tR.PredMod);                 {Prediction Mode}
        txt506_2.Text := '';                                      {Torpedo Track}

        txt507_1.Text := GetValToStr(RoundTo(tR.Course,-2));      {Course}
        txt507_2.Text := GetValToStr(tR.ladis);                   {Ladis}
        txt508_1.Text := GetSpeedTypeToStr(tR.SpeedType);         {Speed}
        txt509_1.Text := GetHomingTypeToStr(tR.HomingType);       {Homing}
        txt509_2.Text := GetValToStr(tR.Uplim);                   {Uplim}
        txt510_1.Text := GetTargetTypeToStr(tR.TargetType);       {Mode}
        txt510_2.Text := GetValToStr(abs(tR.Depth));              {Depth}
        txt511_1.Text := GetLolimModeToStr(tR.LolimMode);         {LolimMode}
        txt511_2.Text := GetValToStr(tR.Lolim);                   {Lolim}
        txt512_1.Text := GetHomingBlockToStr(tR.HomingBlockType); {Homing Block}
        txt512_2.Text := GetValToStr(tR.EnablingDistance);        {Endis}

        txt514_2.Text := GetValToStr(sreel);                      {Srell}
        txt515.Text := GetValToStr(treel);                        {Trell}
      end
      else
      begin
        if tR.TargetTrack.AssByTorpedoVisible then
        begin
          torpTotrgt  := RoundTo(CalcRange(tR.PositionX,tR.PositionY, tR.TargetTrack.PositionX, tR.TargetTrack.PositionY) * C_NauticalMiles_To_Yard,-2);

          sreel := 15311.0 - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);

          if sreel <= 0 then
          begin
            sreel := 0;
            treel := 20122.0 + 15311.0 - (RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2));
          end
          else
            treel   := 20122.0; {Asumsi}

          Endist_Remains := tR.EnablingDistance - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)*C_NauticalMiles_To_Yard,-2);
          if Endist_Remains <= 0 then
             Endist_Remains := 0;

          tR.TrackView.Show_Endist := Endist_Remains > 0;

          txtget503.Text := SetTrackNoToAND(GetTrackNo(tR.TargetTrack.ShipTrackId,tR.TargetTrack.TrackNumber));;
          txt506_1.Text := GetPredmStr(tR.PredMod);                 {Prediction Mode}
          txt506_2.Text := GetValToStr(torpTotrgt);                 {Torpedo Track}

          txt507_1.Text := GetValToStr(RoundTo(tR.Course,-2));      {Course}
          txt507_2.Text := GetValToStr(tR.ladis);                   {Ladis}
          txt508_1.Text := GetSpeedTypeToStr(tR.SpeedType);         {Speed}
          txt509_1.Text := GetHomingTypeToStr(tR.HomingType);       {Homing}
          txt509_2.Text := GetValToStr(tR.Uplim);                   {Uplim}
          txt510_1.Text := GetTargetTypeToStr(tR.TargetType);       {Mode}
          txt510_2.Text := GetValToStr(abs(tR.Depth));              {Depth}
          txt511_1.Text := GetLolimModeToStr(tR.LolimMode);         {LolimMode}
          txt511_2.Text := GetValToStr(tR.Lolim);                   {Lolim}
          txt512_1.Text := GetHomingBlockToStr(tR.HomingBlockType); {Homing Block}
          txt512_2.Text := GetValToStr(tR.EnablingDistance);        {Endis}

          txt514_2.Text := GetValToStr(sreel);                      {Srell}
          txt515.Text := GetValToStr(treel);                        {Trell}
        end
        else
        begin
          txtget503.Text  := '';
          txt506_2.Text   := '0';
          txt507_1.Text   := '0';
          txt510_2.Text   := '0';
          txt512_2.Text   := '0';
          txt514_2.Text   := '0';
          txt515.Text     := '0';

          txt506_2.Text   := '0';
          txt515.Text     := '';
          txt514_2.Text   := '';
        end;
      end;
    end;

  end;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_Page6;
var
  i             :Byte;
  torpTotrgt,
  Endist_Remains,
  sreel,treel   : Double;
  tR            :TTorpedoTrack;

begin
  { == PAGE 6 == }
  if (pPage6.Visible) then begin
    if not TOCOS.GetTorp_fromTube(ttPort,i,tR) then begin
      if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = ttPort) then
          tR := TOCOS.torpManual;
    end;

    if Assigned(tR) then
    begin
      if tR.IsNoTarget then
      begin
        sreel := 15311.0 - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);

        if sreel <= 0 then
        begin
          sreel := 0;
          treel := 20122.0 + 15311.0 - (RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2));
        end
        else
          treel := 20122.0;

        Endist_Remains := tR.EnablingDistance - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);
        if Endist_Remains <= 0 then
             Endist_Remains := 0;

        tR.TrackView.Show_Endist := Endist_Remains > 0;

        txtget603.Text := '';                                     {Target No}
        txt606_1.Text := GetPredmStr(tR.PredMod);                 {Prediction Mode}
        txt606_2.Text := '';                                      {Torpedo Track}

        txt607_1.Text := GetValToStr(RoundTo(tR.Course,-2));      {Course}
        txt607_2.Text := GetValToStr(tR.ladis);                   {Ladis}
        txt608_1.Text := GetSpeedTypeToStr(tR.SpeedType);         {Speed}
        txt609_1.Text := GetHomingTypeToStr(tR.HomingType);       {Homing}
        txt609_2.Text := GetValToStr(tR.Uplim);                   {Uplim}
        txt610_1.Text := GetTargetTypeToStr(tR.TargetType);       {Mode}
        txt610_2.Text := GetValToStr(abs(tR.Depth));              {Depth}
        txt611_1.Text := GetLolimModeToStr(tR.LolimMode);         {LolimMode}
        txt611_2.Text := GetValToStr(tR.Lolim);                   {Lolim}
        txt612_1.Text := GetHomingBlockToStr(tR.HomingBlockType); {Homing Block}
        txt612_2.Text := GetValToStr(tR.EnablingDistance);        {Endis}

        txt614_2.Text := GetValToStr(sreel);                      {Srell}
        txt615.Text := GetValToStr(treel);                        {Trell}
      end
      else
      begin
        if tR.TargetTrack.AssByTorpedoVisible then
        begin
          torpTotrgt := RoundTo(CalcRange(tR.PositionX,tR.PositionY, tR.TargetTrack.PositionX, tR.TargetTrack.PositionY) * C_NauticalMiles_To_Yard,-2);

          sreel := 15311.0 - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);

          if sreel <= 0 then
          begin
            sreel := 0;
            treel := 20122.0 + 15311.0 - (RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2));
          end
          else
            treel := 20122.0;

          Endist_Remains := tR.EnablingDistance - RoundTo(CalcRange(tR.PositionX,tR.PositionY,TOCOS.xSHIP.PositionX,TOCOS.xSHIP.PositionY)* C_NauticalMiles_To_Yard,-2);
          if Endist_Remains <= 0 then
             Endist_Remains := 0;

          tR.TrackView.Show_Endist := Endist_Remains > 0;

          txtget603.Text  := SetTrackNoToAND(GetTrackNo(tR.TargetTrack.ShipTrackId,tR.TargetTrack.TrackNumber));;
          txt606_1.Text := GetPredmStr(tR.PredMod);                 {Prediction Mode}
          txt606_2.Text := GetValToStr(torpTotrgt);                 {Torpedo Track}

          txt607_1.Text := GetValToStr(RoundTo(tR.Course,-2));      {Course}
          txt607_2.Text := GetValToStr(tR.ladis);                   {Ladis}
          txt608_1.Text := GetSpeedTypeToStr(tR.SpeedType);         {Speed}
          txt609_1.Text := GetHomingTypeToStr(tR.HomingType);       {Homing}
          txt609_2.Text := GetValToStr(tR.Uplim);                   {Uplim}
          txt610_1.Text := GetTargetTypeToStr(tR.TargetType);       {Mode}
          txt610_2.Text := GetValToStr(abs(tR.Depth));              {Depth}
          txt611_1.Text := GetLolimModeToStr(tR.LolimMode);         {LolimMode}
          txt611_2.Text := GetValToStr(tR.Lolim);                   {Lolim}
          txt612_1.Text := GetHomingBlockToStr(tR.HomingBlockType); {Homing Block}
          txt612_2.Text := GetValToStr(tR.EnablingDistance);        {Endis}

          txt614_2.Text := GetValToStr(sreel);                      {Srell}
          txt615.Text := GetValToStr(treel);                        {Trell}
        end
        else
        begin
          txtget603.Text := '';
          txt606_2.Text  := '0';
          txt607_1.Text  := '0';
          txt610_2.Text  := '0';
          txt612_2.Text  := '0';
          txt614_2.Text  := '0';
          txt615.Text    := '0';
          txt606_2.Text  := '0';
          txt615.Text    := '';
          txt614_2.Text  := '';
        end;
      end;
    end;

  end;
end;

procedure TvDisplayCtrlPanelLeft.AnduData_RunOff(launcher: TTube);
begin
  if launcher = ttStarBoard then
  begin
    txtget503.Text:= '';
    txt506_1.Text := GetPredmStr(mIntercept);
    txt506_2.Text := '';

    txt507_1.Text := GetValToStr(0);
    txt510_2.Text := GetValToStr(0);
    txt512_2.Text := GetValToStr(0);

    txt514_2.Text := GetValToStr(0);
    txt515.Text   := GetValToStr(0);
  end
  else
  begin
    txtget503.Text:= '';
    txt606_1.Text := GetPredmStr(mIntercept);
    txt606_2.Text := '';

    txt607_1.Text := GetValToStr(0);
    txt610_2.Text := GetValToStr(0);
    txt612_2.Text := GetValToStr(0);

    txt614_2.Text := GetValToStr(0);
    txt615.Text   := GetValToStr(0);
  end;


end;

//==============================================================================
 procedure TvDisplayCtrlPanelLeft.vr0Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  0');
end;

procedure TvDisplayCtrlPanelLeft.vr1Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  1');
end;

procedure TvDisplayCtrlPanelLeft.vr2Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  2');
end;

procedure TvDisplayCtrlPanelLeft.vr3Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  3');
end;

procedure TvDisplayCtrlPanelLeft.vr4Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  4');
end;

procedure TvDisplayCtrlPanelLeft.vr5Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  5');
end;

procedure TvDisplayCtrlPanelLeft.vr6Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  6');
end;

procedure TvDisplayCtrlPanelLeft.vr7Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  7');
end;

procedure TvDisplayCtrlPanelLeft.vr8Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  8');
end;

procedure TvDisplayCtrlPanelLeft.vr9Click(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then  applynumber('  9');
end;

procedure TvDisplayCtrlPanelLeft.vrPageClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then applynumber('P  A  G  E');
end;

//======================= RESET VAL ============================================
procedure TvDisplayCtrlPanelLeft.ResetVal;
begin
  codeinput.Text    :='';
  checkbtn.Checked  :=false;
  code.Text         := '';
  txtValue.visible := True; txtvalue.Text     :='';
  txtValue2.Visible:= true; txtValue2.Text    := '';
  signVal1.Text     := '';
  signVal2.Text     := '';
  txt214_1.Visible := false; txt214_2.Visible := false; txt214_3.Visible := false;
  txt2142_1.Visible:= false; txt2142_2.Visible:= false; txt2142_3.Visible:= false;
end;

procedure TvDisplayCtrlPanelLeft.vrResetClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then ResetVal;
end;
//==============================================================================

procedure TvDisplayCtrlPanelLeft.getValue;
var
  i:integer;
  Vtext:string;
begin
  Vtext:=codeinput.Text ;
  for i:=1 to 59 do begin
    if codeinput.Text = linecode[i] then begin
        if (i > 8) and (i < 59) then code.Text:= linecode[i];

        case i of
         1: begin            pPage1show;codeinput.Text :='';end;
         2: begin            pPage2show;codeinput.Text :='';end;
         3: begin            pPage3show;codeinput.Text :='';end;
         4: begin            pPage4show;codeinput.Text :='';end;
         5: begin            pPage5show;codeinput.Text :='';end;
         6: begin            pPage6show;codeinput.Text :='';end;
         7: begin            pPage8show;codeinput.Text :='';end;
         8: begin            pPage9show;codeinput.Text :='';end;
         9: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[1];
              tabNo := 1;
              if txt203.Text = autman[2] then signVal1.Text := insert_byNIK;
            end;
         10: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[2];
              tabNo := 1;
              if txt204.Text = autman[2] then signVal1.Text := insert_byNIK;
             end;
         11: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[3];
              tabNo := 1;
              signVal1.Text := insert_byNIK;
             end;
         12: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[18];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt208.Text;
              tabNo := 1;
             end;
         13: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[19];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt209.Text;
              tabNo := 1;
             end;
         14: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[20];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt211.Text;
              tabNo := 1;
             end;
         15: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[4];
              tabNo := 1;
              if (sign29.Caption = '*') then signVal1.Text := insert_byNIK
              else signVal1.Text := '';
             end;
         16: begin
              pPage2show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[5];
              signVal1.Text := insert_byNIK;
              tabNo := 1;

              txt214_1.Visible:= True; txt214_1.Text := '';
              txt214_2.Visible:= True; txt214_2.Text := '';
              txt214_3.Visible:= True; txt214_3.Text := '';
              txtValue.Visible := False;

              txt2142_1.Visible:= true; txt2142_1.Text :='';
              txt2142_2.Visible:= true; txt2142_2.Text :='';
              txt2142_3.Visible:= True; txt2142_3.Text :='';
              txtValue2.Visible := false;
              end;
         17: begin
              pPage4show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[7];
              signVal1.Text := insert_byNIK;
              tabNo := 1;
              end;
         18: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[22];
              signVal2.Text := insert_byRolling;
              txtValue2.Text := txt503.Text;
              tabNo := 2;
              end;
         19: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[23];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt506_1.Text;
              tabNo := 1;
              end;
         20: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[9];
              signVal2.Text := insert_byNIK;
              tabNo := 2;
              end;
         21: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[24];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt508_1.Text;
              tabNo := 1;
             end;
         22: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[25];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt509_1.Text;
              tabNo := 1;
              end;
         24: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[26];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt510_1.Text;
              tabNo := 1;
              end;
         25: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[27];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt511_1.Text;
              tabNo := 1;
              end;
         26: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[28];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt512_1.Text;
              tabNo := 1;
              end;
         27: begin
              pPage5show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[29];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt514_1.Text;
              tabNo := 1;
              end;
         28: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[22];
              signVal2.Text := insert_byRolling;
              txtValue2.Text := txt603.Text;
              tabNo := 2;
              end;
         29: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[23];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt606_1.Text;
              tabNo := 1;
              end;
         30: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[9];
              signVal2.Text := insert_byNIK;
              tabNo := 2;
              end;
         31: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[24];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt608_1.Text;
              tabNo := 1;
              end;
         32: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[25];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt609_1.Text;
              tabNo := 1;
              end;
         33: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[26];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt610_1.Text;
              tabNo := 1;
              end;
         34: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[27];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt611_1.Text;
              tabNo := 1;
              end;
         35: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[28];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt612_1.Text;
              tabNo := 1;
              end;
         36: begin
              pPage6show;
              checkbtn.Checked :=true;
              codeinput.Text :=linename[29];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt614_1.Text;
              tabNo := 1;
              end;
         59: begin            pPage1show;codeinput.Text :='';end;
         {
         37: begin            codeinput.Text :=linename[31];pPage8show;checkbtn.Checked :=true;end;
         38: begin            codeinput.Text :=linename[32];pPage8show;checkbtn.Checked :=true;end;
         39: begin            codeinput.Text :=linename[13];pPage8show;checkbtn.Checked :=true;end;
         40: begin            codeinput.Text :=linename[33];pPage8show;checkbtn.Checked :=true;end;
         41: begin            codeinput.Text :=linename[14];pPage8show;checkbtn.Checked :=true;end;
         42: begin            codeinput.Text :=linename[14];pPage8show;checkbtn.Checked :=true;end;
         43: begin            codeinput.Text :=linename[15];pPage8show;checkbtn.Checked :=true;end;
         44: begin            codeinput.Text :=linename[36];pPage8show;checkbtn.Checked :=true;end;
         45: begin            codeinput.Text :=linename[38];pPage8show;checkbtn.Checked :=true;end;
         46: begin            codeinput.Text :=linename[42];pPage8show;checkbtn.Checked :=true;end;
         47: begin            codeinput.Text :=linename[46];pPage9show;checkbtn.Checked :=true;end;
         48: begin            codeinput.Text :=linename[50];pPage9show;checkbtn.Checked :=true;end;
         49: begin            codeinput.Text :=linename[54];pPage9show;checkbtn.Checked :=true;end;
         50: begin            codeinput.Text :=linename[57];pPage9show;checkbtn.Checked :=true;end;
         51: begin            codeinput.Text :=linename[58];pPage9show;checkbtn.Checked :=true;end;
         52: begin            codeinput.Text :=linename[61];pPage9show;checkbtn.Checked :=true;end;
         53: begin            codeinput.Text :=linename[64];pPage9show;checkbtn.Checked :=true;end;
         54: begin            codeinput.Text :=linename[67];pPage9show;checkbtn.Checked :=true;end;
         55: begin            codeinput.Text :=linename[69];pPage9show;checkbtn.Checked :=true;end;
         56: begin            codeinput.Text :=linename[69];pPage9show;checkbtn.Checked :=true;end;}

        end;
      end;
  end;
end;

//=========================== INSERT ===========================================
procedure TvDisplayCtrlPanelLeft.vrInsertClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then begin
    insertvalue;
//    ResetVal;
  end;
end;


procedure TvDisplayCtrlPanelLeft.insertValue;
var
  j,k     :Byte;
  i       :integer;
  tR      :TTorpedoTrack;
  ladis,
  cspeed,
  uplim,
  lolim,spd, degree :Double;
  Sumdd, Sumyy : Integer;
  jam, dtk, mnt : Double;
  sjam, sdtk, smnt : string;

function cek_tgl(valyy, valmm, valdd :string): Boolean;
var
  hr, thn : Integer;
begin
  Result := False;

  thn := StrToInt(GetStrToLength(valyy));
  hr := StrToInt(GetStrToLength(valdd));

  if (hr = 0) or (thn = 0) then
    Exit;

  if (valmm = 'J A N') or (valmm = 'M A R') or (valmm = 'M A Y') or (valmm = 'J U L') or
     (valmm = 'A U G') or (valmm = 'O C T') or (valmm = 'D E C') then
  begin
    if hr <= 31 then
      Result := True;
  end
  else if (valmm = 'A P R') or (valmm = 'J U N') or (valmm = 'S E P') or (valmm = 'N O V') then
  begin
    if hr <= 30 then
      Result := True;
  end
  else
  begin
    if (thn mod 4) = 0 then
    begin
      if hr <= 29 then
        Result := True;
    end
    else
    begin
      if hr <= 28 then
        Result := True;
    end;
  end;
end;

function cek_jam(val:Double): Boolean;
begin
  Result := False;

  if val <= 23 then
    Result := True;
end;

function cek_dtk_mnt(val:Double): Boolean;
begin
  Result := False;

  if val <= 59 then
    Result := True;
end;

begin
  for i:=1 to 59 do begin
    if code.Text = linecode[i] then begin
        case i of
        9:  begin
              if tabNo = 1 then
              begin
                degree := VAlidateValue(GetStrToVal(txtValue.Text), Deg);

                if degree <= 360 then
                begin
                  if degree = 360 then
                    degree := 000;

                  txtget203.Text := FloatToStr(degree);
                  TOCOS.xSHIP.Heading := degree;

                  ResetVal;
                end
              end
              else if tabNo = 2 then
              begin
                if (txtValue2.Text = autman[1]) or (txtValue2.Text = autman[2]) then
                begin
                  txt203.Text := txtValue2.Text;
                  if txt203.Text = autman[2] then
                    sign21.Caption := '*'
                  else
                    sign21.Caption := '';

                  ResetVal;
                end
              end;
            end;
        10: begin
              if tabNo = 1 then
              begin
                spd := VAlidateValue(GetStrToVal(txtValue.Text), Knt);

                txtget204.Text := GetValToStr(RoundTo(spd,-2));
                TOCOS.xSHIP.Speed := spd;

                ResetVal;
              end
              else if tabNo = 2 then
              begin
                if (txtValue2.Text = autman[1]) or (txtValue2.Text = autman[2]) then
                begin
                  txt204.Text := txtValue2.Text;
                  if txt204.Text = autman[2] then
                    sign23.Caption := '*'
                  else
                    sign23.Caption := '';

                  ResetVal;
                end
              end;
            end;
        11: begin
              txt207.Text := GetValToStr(VAlidateValue(GetStrToVal(txtvalue.Text),Lat));
              ResetVal;
            end;
        12: begin
              if (txtValue.Text = opermode[1]) or (txtValue.Text = opermode[2]) or (txtValue.Text = opermode[3]) then
              begin
                if (txtValue.Text = opermode[1])then
                begin
                  TOCOS.tocosMode := mLocalwSonar;
                  sign213.Visible := True
                end
                else if (txtValue.Text = opermode[2]) then
                begin
                  TOCOS.tocosMode := mLocal;
                  sign213.Visible := True
                end
                else if (txtValue.Text = opermode[3]) then
                begin
                  TOCOS.tocosMode := mRemote;
                  sign213.Visible := False;

                  sjam := GetStrToSpace(FormatDateTime('hh',now));
                  smnt := GetStrToSpace(FormatDateTime('nn',now));
                  sdtk := GetStrToSpace(FormatDateTime('ss',now));

                  txtTime.Text := sjam + ': ' + smnt + ': ' + sdtk;
                end;
                txt208.Text := txtvalue.Text;
                ResetVal;
              end
            end;
        13: begin
              if (txtValue.Text = onof[1]) or (txtValue.Text = onof[2]) then
              begin
                txt209.Text :=txtvalue.Text;
                ResetVal;
              end
            end;
        14: begin
              if (txtValue.Text = onof[1]) or (txtValue.Text = onof[2]) then
              begin
                txt211.Text :=txtvalue.Text;
                ResetVal;
              end
            end;
        15: begin
              if (signVal1.Text = insert_byNIK) then
              begin
                txtget212.Text := txtValue.Text;
                ResetVal;
              end
            end;
        16: begin
              if tabNo = 1 then
              begin
                Sumyy := Length(GetStrToLength(txt214_1.Text));
                Sumdd := Length(GetStrToLength(txt214_3.Text));

                {cek batas jumlah karakter}
                if (Sumyy = 4) and (Sumdd = 2) then
                begin
                  if cek_tgl (txt214_1.Text, txt214_2.Text, txt214_3.Text) then
                  begin
                    txtDate.Text := txt214_1.Text + txt214_2.Text + txt214_3.Text;
                    ResetVal;
                  end
                end;
              end
              else if tabNo = 2 then
              begin
                if (txt2142_1.Text = '') or (txt2142_2.Text= '') or (txt2142_3.Text = '')then
                  exit;

                jam := GetStrToVal(txt2142_1.Text);
                mnt := GetStrToVal(txt2142_2.Text);
                dtk := GetStrToVal(txt2142_3.Text);

                if (cek_jam(jam)) and (cek_dtk_mnt(mnt)) and (cek_dtk_mnt(dtk))then
                begin
                  txtTime.Text := txt2142_1.Text + txt2142_2.Text + txt2142_3.Text;
                  ResetVal;
                end;
              end;
            end;
        17: begin
              if tabNo = 1 then
              begin
                txttargetno_1.Text := txtValue.Text;
                ResetVal;
              end
              else if tabNo = 2 then
              begin
                txttargetno_2.Text := txtValue2.Text;
                ResetVal;
              end
            end;
        18: begin {RUN ON/ OFF}

              if txtValue2.Text = 'O F F' then
              begin
                if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
                begin
                  TOCOS.vMainCtrlPanel.Passing(2);
                  AnduData_RunOff(ttStarBoard);
                  TOCOS.RemovePredictionLineView(2, false);
                  txt503.Text := txtValue2.Text;
                  ResetVal;
                end;
              end;
              if txtValue2.Text = 'O N' then
              begin
                TOCOS.SetNoTargetBeforeFire(ttStarBoard);
                TOCOS.vMainCtrlPanel.btnMan.Click;
                txt503.Text := txtValue2.Text;
                ResetVal;
              end
            end;
        19: begin {Prediction Mode}
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if txtValue.Text = 'I N T' then
                  tR.PredMod := mIntercept
                else if txtValue.Text = ' R I D' then
                  tR.PredMod := mBearingRider
                else
                  Exit;

                txt506_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        20: begin {LADIS}
              if txtValue2.Text = '' then
                Exit;

              ladis := GetStrToVal(txtValue2.Text);
              if (ladis < 0) then
                ladis := 0
              else if (ladis > 9999) then
                ladis := 9999;

              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if tR.isSafedistance then
                begin
                  tR.Ladis := ladis;
                  txt507_2.Text := GetValToStr(ladis);
                  ResetVal;
                end
              end;
            end;
        21: begin
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if tabNo = 1 then {SPEED}
                begin
                  if (txtValue.Text = 'L O W') or (txtValue.Text = 'M D M') or (txtValue.Text = 'H G H') then
                  begin
                    txt508_1.Text := txtValue.Text;

                    tR.SpeedType := GetStrToSpeedType(txtValue.Text);

                    if tR.Launched and tR.isSafedistance then
                    begin
                      TOCOS.SendTorpDatato3D(tR);
                      txt508_2.Text := '';
                    end;

                    if tR.PredMod = mIntercept  then
                      tR.CalcPHP;

                    ResetVal;
                  end;
                end
                else if tabNo = 2 then  {CSPEED}
                begin
                  cspeed := GetStrToVal(txtValue2.Text)/10;
                  if (cspeed < -9.9) then
                    cspeed := -9.9
                  else if (cspeed > 9.9) then
                    cspeed := 9.9;

                  if tR.Launched and tR.isSafedistance then  {asumsi hrs dilakukan stelah penembakan}
                  begin
                    tR.SpeedType := tR.SpeedType;
                    tR.Speed := tR.Speed + cspeed;
                    TOCOS.SendTorpDatato3D(tR);

                    txt508_2.Text := FloatToStr(RoundTo(cspeed,-2));
                    ResetVal;
                  end;
                end;
              end
            end;
        22: begin
              if tabNo = 1 then {HOMNG}
              begin
                if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
                begin
                  if txtValue.Text = 'P A S' then
                    tR.HomingType := htPas
                  else if txtValue.Text = 'A C T' then
                    tR.HomingType := htAct
                  else if txtValue.Text = 'C M B' then
                    tR.HomingType := htCmb
                  else
                    Exit;

                  txt509_1.Text := txtValue.Text;
                  ResetVal;
                end
              end
              else if tabNo = 2 then {UPLIM}
              begin
                if txtValue2.Text = '' then
                  Exit;
                uplim := GetStrToVal(txtValue2.Text);
                if (uplim < 6) then
                  uplim := 6
                else if (uplim > 1518) then
                  uplim := 1518;

                if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
                begin
                  tR.Uplim := uplim;
                  txt509_2.Text := GetValToStr(uplim);
                  ResetVal;
                end;
              end;
            end;
        24: begin {MODE}
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if txtValue.Text = 'S U R' then
                  tR.TargetType := __TORPEDOSUT_TARGET_SURFACE
                else if txtValue.Text = 'S U B' then
                  tR.TargetType := __TORPEDOSUT_TARGET_SUBSURFACE
                else
                  Exit;

                txt510_1.Text := txtValue.Text;
                ResetVal;
              end;
            end;
        25: begin
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if tabNo = 1 then {LOLIM ON/OFF}
                begin
                  if txtValue.Text = 'O N' then
                    tr.LolimMode := lmOn
                  else if txtValue.Text = 'O F F' then
                    tr.LolimMode := lmOff
                  else
                    Exit;

                  txt511_1.Text := txtValue.Text;
                  ResetVal;
                end
                else if tabNo = 2 then {LOLIM}
                begin
                  lolim := GetStrToVal(txtValue2.Text);
                  if (lolim < 18) then
                    lolim := 18
                  else if (lolim > 1518) then
                    lolim := 1518;

                  txt511_2.Text := GetValToStr(lolim);
                  tR.Lolim := lolim;
                  ResetVal;
                end;
              end
            end;
        26: begin {HOMING BLOCK}
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if (txtValue.Text = 'O N') then
                  tR.HomingBlockType := hbOn
                else if (txtValue.Text = 'O F F') then
                  tR.HomingBlockType := hbOff
                else
                  Exit;

                txt512_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        27: begin {TCOM}
              if TOCOS.GetTorp_fromTube(ttStarBoard,j,tR) then
              begin
                if (txtValue.Text = '0') then
                  tR.ComUnit := 0
                else if(txtValue.Text = '1') then
                  tR.ComUnit := 1
                else if (txtValue.Text = '2') then
                  tR.ComUnit := 2
                else
                  Exit;

                txt514_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        28: begin {RUN ON/ OFF}

              if txtValue2.Text = 'O F F' then
              begin
                if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
                begin
                  TOCOS.vMainCtrlPanel.Passing(1);
                  AnduData_RunOff(ttPort);
                  TOCOS.RemovePredictionLineView(1, false);

                  txt603.Text := txtValue2.Text;
                  ResetVal;
                end;
              end;
              if txtValue2.Text = 'O N'then
              begin
                TOCOS.SetNoTargetBeforeFire(ttPort);
                TOCOS.vMainCtrlPanel.btnMan.Click;
                txt603.Text := txtValue2.Text;
                ResetVal;
              end
            end;
        29: begin {Prediction Mode}
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if txtValue.Text = 'I N T' then
                  tR.PredMod := mIntercept
                else if txtValue.Text = ' R I D' then
                  tR.PredMod := mBearingRider
                else
                  Exit;

                txt606_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        30: begin {LADIS}
              if txtValue2.Text = '' then
                Exit;

              ladis := GetStrToVal(txtValue2.Text);
              if (ladis < 0) then
                ladis := 0
              else if (ladis > 9999) then
                ladis := 9999;

              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if tR.isSafedistance then
                begin
                  tR.Ladis := ladis;
                  txt607_2.Text := GetValToStr(ladis);
                  ResetVal;
                end
              end;
            end;
        31: begin
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if tabNo = 1 then {SPEED}
                begin
                  if (txtValue.Text = 'L O W') or (txtValue.Text = 'M D M') or (txtValue.Text = 'H G H') then
                  begin
                    txt608_1.Text := txtValue.Text;

                    tR.SpeedType := GetStrToSpeedType(txtValue.Text);

                    if tR.Launched and tR.isSafedistance then
                    begin
                      TOCOS.SendTorpDatato3D(tR);
                      txt608_2.Text := '';
                    end;

                    if tR.PredMod = mIntercept  then
                      tR.CalcPHP;

                    ResetVal;
                  end
                end
                else if tabNo = 2 then {CSPEED}
                begin
                  cspeed := GetStrToVal(txtValue2.Text)/10;
                  if (cspeed < -9.9) then
                    cspeed := -9.9
                  else if (cspeed > 9.9) then
                    cspeed := 9.9;

                  if tR.Launched and tR.isSafedistance then   {asumsi hrs dilakukan stelah penembakan}
                  begin
                    tR.SpeedType := tR.SpeedType;
                    tR.Speed := tR.Speed + cspeed;
                    TOCOS.SendTorpDatato3D(tR);

                    txt608_2.Text := FloatToStr(RoundTo(cspeed,-2));
                    ResetVal;
                  end;
                end;
              end
            end;
        32: begin
              if tabNo = 1 then {HOMNG}
              begin
                if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
                begin
                  if txtValue.Text = 'P A S' then
                    tR.HomingType := htPas
                  else if txtValue.Text = 'A C T' then
                    tR.HomingType := htAct
                  else if txtValue.Text = 'C M B' then
                    tR.HomingType := htCmb
                  else
                    Exit;

                  txt609_1.Text := txtValue.Text;
                  ResetVal;
                end
              end
              else if tabNo = 2 then {UPLIM}
              begin
                if txtValue2.Text = '' then
                  Exit;
                uplim := GetStrToVal(txtValue2.Text);
                if (uplim < 6) then
                  uplim := 6
                else if (uplim > 1518) then
                  uplim := 1518;

                if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
                begin
                  tR.Uplim := uplim;
                  txt609_2.Text := GetValToStr(uplim);
                  ResetVal;
                end;
              end;
            end;
        33: begin {MODE}
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if txtValue.Text = 'S U R' then
                  tR.TargetType := __TORPEDOSUT_TARGET_SURFACE
                else if txtValue.Text = 'S U B' then
                  tR.TargetType := __TORPEDOSUT_TARGET_SUBSURFACE
                else
                  Exit;

                txt610_1.Text := txtValue.Text;
                ResetVal;
              end;
            end;
        34: begin
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if tabNo = 1 then {LOLIM ON/OFF}
                begin
                  if txtValue.Text = 'O N' then
                    tr.LolimMode := lmOn
                  else if txtValue.Text = 'O F F' then
                    tr.LolimMode := lmOff;

                  txt611_1.Text := txtValue.Text;
                  ResetVal;
                end
                else if tabNo = 2 then {LOLIM}
                begin
                  lolim := GetStrToVal(txtValue2.Text);
                  if (lolim < 18) then
                    lolim := 18
                  else if (lolim > 1518) then
                    lolim := 1518;

                  txt611_2.Text := GetValToStr(lolim);
                  tR.Lolim := lolim;
                  ResetVal;
                end;
              end
            end;
        35: begin {HOMING BLOCK}
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if (txtValue.Text = 'O N') then
                  tR.HomingBlockType := hbOn
                else if (txtValue.Text = 'O F F') then
                  tR.HomingBlockType := hbOff
                else
                  Exit;

                txt612_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        36: begin {TCOM}
              if TOCOS.GetTorp_fromTube(ttPort,k,tR) then
              begin
                if (txtValue.Text = '0') then
                  tR.ComUnit := 0
                else if(txtValue.Text = '1') then
                  tR.ComUnit := 1
                else if (txtValue.Text = '2') then
                  tR.ComUnit := 2
                else
                  Exit;

                txt614_1.Text := txtValue.Text;
                ResetVal;
              end
            end;
        end;

    end;
  end;
end;
//===============================================================================



//========================== TAB ===============================================
procedure TvDisplayCtrlPanelLeft.vrTabClick(Sender: TObject);
begin
  inherited;
  inc(tabNo);
  if (tabNo >2) then tabNo := 1;
  
  if (checkbtn.Checked = True) then begin
      {========================================================================}
      if (code.Text = linecode[9]) then begin
          if (tabNo = 1) and (sign21.Caption = '*') then begin
            signVal1.Text := insert_byNIK;
            signVal2.Text := '';
          end
          else if (tabNo = 2) then begin
            signVal1.Text :='';
            signVal2.Text := insert_byRolling;
            txtValue2.Text := txt203.Text;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[10]) then begin
          if (tabNo = 1) and (sign23.Caption = '*') then begin
            signVal1.Text := insert_byNIK;
            signVal2.Text := '';
          end
          else if (tabNo = 2) then begin
            signVal1.Text :='';
            signVal2.Text := insert_byRolling;
            txtValue2.Text := txt204.Text;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[16]) then begin
          if (tabNo = 1) then begin
            CodeInput.Text := linename[5];
            signVal1.Text := insert_byNIK;
            signVal2.Text := '';
          end
          else if (tabNo = 2) then begin
            CodeInput.Text := linename[6];
            signVal1.Text := '';
            signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[17]) then begin
          if (tabNo = 1) then begin
            signVal1.Text := insert_byNIK;
            signVal2.Text := '';
          end
          else if (tabNo = 2) then begin
            signVal1.Text := '';
            signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[18]) or (code.Text = linecode[20]) or
              (code.Text = linecode[28]) or (code.Text = linecode[30]) then
          tabNo := 2
      {========================================================================}
      else if (code.Text = linecode[21]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[24];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt508_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[10];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[22]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[25];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt509_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[11];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[25]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[27];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt511_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[12];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[31]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[24];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt608_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[10];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
       else if (code.Text = linecode[32]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[25];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt609_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[11];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      {========================================================================}
      else if (code.Text = linecode[34]) then begin
          if tabNo = 1 then begin
              CodeInput.Text := linename[27];
              signVal1.Text := insert_byRolling;
              txtValue.Text := txt611_1.Text;
              signVal2.Text := '';
          end
          else if tabNo = 2 then begin
              CodeInput.Text := linename[12];
              signVal1.Text := '';
              txtValue.Text := '';
              signVal2.Text := insert_byNIK;
          end;
      end
      else tabNo := 1;
  end;

end;


//==================== PLUS & MINUS ============================================

procedure TvDisplayCtrlPanelLeft.vrPlusClick(Sender: TObject);
//var
//  {i,}n:integer;
//  s:String;
begin
  if TOCOS.TOCOSSysON then begin
    {..........................................................................}
     if ((code.Text = linecode[9]) or (code.Text = linecode[10])) and (tabNo=2) then begin
        if txtvalue2.Text =autman[1] then txtvalue2.Text :=autman[2]
        else if txtvalue2.Text =autman[2] then txtvalue2.Text :=autman[2];
     end
    {..........................................................................}
     else if (code.Text = linecode[12]) then begin
        if txtvalue.Text =opermode[1] then txtvalue.Text :=opermode[2]
        else if txtvalue.Text =opermode[2] then txtvalue.Text :=opermode[3]
        else if txtvalue.Text =opermode[3] then txtvalue.Text :=opermode[3];
     end
    {..........................................................................}
     else if (code.Text = linecode[13]) or (code.Text = linecode[25]) or (code.Text = linecode[26])
     or (code.Text = linecode[34]) or (code.Text = linecode[35]) then begin
        if txtvalue.Text =onof[1] then txtvalue.Text :=onof[2]
        else if txtvalue.Text =onof[2] then txtValue.Text := onof[2];
     end
    {..........................................................................}
     else if (code.Text = linecode[14]) then begin
        if txtvalue.Text =onof[1] then txtvalue.Text :=onof[2]
        else if txtvalue.Text =onof[2] then txtValue.Text := onof[3]
        else if txtValue.Text = onof[3] then txtValue.Text := onof[3];
     end
    {..........................................................................}
    else if (code.Text = linecode[16]) and (CodeInput.Text = linename[5]) then begin
        if (textDate = false) and (txt214_2.Text =monthdate[1]) then txt214_2.Text :=monthdate[2]
        else if (textDate = false) and (txt214_2.Text =monthdate[2]) then txt214_2.Text :=monthdate[3]
        else if (textDate = false) and (txt214_2.Text =monthdate[3]) then txt214_2.Text :=monthdate[4]
        else if (textDate = false) and (txt214_2.Text =monthdate[4]) then txt214_2.Text :=monthdate[5]
        else if (textDate = false) and (txt214_2.Text =monthdate[5]) then txt214_2.Text :=monthdate[6]
        else if (textDate = false) and (txt214_2.Text =monthdate[6]) then txt214_2.Text :=monthdate[7]
        else if (textDate = false) and (txt214_2.Text =monthdate[7]) then txt214_2.Text :=monthdate[8]
        else if (textDate = false) and (txt214_2.Text =monthdate[8]) then txt214_2.Text :=monthdate[9]
        else if (textDate = false) and (txt214_2.Text =monthdate[9]) then txt214_2.Text :=monthdate[10]
        else if (textDate = false) and (txt214_2.Text =monthdate[10]) then txt214_2.Text :=monthdate[11]
        else if (textDate = false) and (txt214_2.Text =monthdate[11]) then txt214_2.Text :=monthdate[12]
        else if (textDate = false) and (txt214_2.Text =monthdate[12]) then txt214_2.Text :=monthdate[12]
    end
    {..........................................................................}
    else if (code.Text = linecode[18]) or (code.Text = linecode[28]) then begin
        if txtvalue2.Text =onof[1] then txtvalue2.Text :=onof[2]
        else if txtvalue2.Text =onof[2] then txtValue2.Text := onof[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[19]) or (code.Text = linecode[29]) then begin
        if Copy(txtvalue.Text, 0, 5) =predm[1] then txtvalue.Text :=predm[2]
        else if Copy(txtvalue.Text, 0, 5) =predm[2] then txtvalue.Text :=predm[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[21]) or (code.Text = linecode[31]) then begin
        if txtvalue.Text =speedcode[1] then txtvalue.Text :=speedcode[2]
        else if txtvalue.Text =speedcode[2] then txtvalue.Text :=speedcode[3]
        else if txtvalue.Text =speedcode[3] then txtvalue.Text :=speedcode[3];
    end
    {..........................................................................}
    else if (code.Text = linecode[22]) or (code.Text = linecode[32]) then begin
        if txtvalue.Text =homing[1] then txtvalue.Text :=homing[2]
        else if txtvalue.Text =homing[2] then txtvalue.Text :=homing[3]
        else if txtvalue.Text =homing[3] then txtvalue.Text :=homing[3];
    end
    {..........................................................................}
    else if (code.Text = linecode[24]) or (code.Text = linecode[33]) then begin
        if txtvalue.Text =modesursub[1] then txtvalue.Text :=modesursub[2]
        else if txtvalue.Text =modesursub[2] then txtvalue.Text :=modesursub[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[27]) or (code.Text = linecode[36]) then begin
        if txtvalue.Text =tcomunit[1] then txtvalue.Text :=tcomunit[2]
        else if txtvalue.Text =tcomunit[2] then txtvalue.Text :=tcomunit[3]
        else if txtvalue.Text =tcomunit[3] then txtvalue.Text :=tcomunit[3];
    end;
    {..........................................................................}


    if CodeInput.Text = linename[10] then applynumber('  +');
    if textDate = True then begin
       txt214_2.Text := 'J U N';
       txt214_1.Text := txt214_3.Text + ' . ';
       txt214_3.Text := '';
       textDate      := False;
    end;
  end;
end;


procedure TvDisplayCtrlPanelLeft.vrMinusClick(Sender: TObject);
//var
//  i,n : Integer;
//  s : String;
begin
  if TOCOS.TOCOSSysON then begin
    {..........................................................................}
    if (code.Text = linecode[9]) or (code.Text = linecode[10]) then begin
        if txtvalue2.Text =autman[1] then txtvalue2.Text :=autman[1]
        else if txtvalue2.Text =autman[2] then txtvalue2.Text :=autman[1];
    end
    {..........................................................................}
     else if (code.Text = linecode[11]) then
     ApplyNumber(' -')
    {..........................................................................}
    else if (code.Text = linecode[12]) then begin
        if txtvalue.Text =opermode[1] then txtvalue.Text :=opermode[1]
        else if txtvalue.Text =opermode[2] then txtvalue.Text :=opermode[1]
        else if txtvalue.Text =opermode[3] then txtvalue.Text :=opermode[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[13]) or (code.Text = linecode[25]) or (code.Text = linecode[26])
    or (code.Text = linecode[34]) or (code.Text = linecode[35]) then begin
        if txtvalue.Text =onof[1] then txtvalue.Text :=onof[1]
        else if txtvalue.Text =onof[2] then txtValue.Text := onof[1];
    end
   {..........................................................................}
    else if (code.Text = linecode[14]) then begin
        if txtvalue.Text =onof[1] then txtvalue.Text :=onof[1]
        else if txtvalue.Text =onof[2] then txtValue.Text := onof[1]
        else if txtValue.Text = onof[3] then txtValue.Text := onof[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[16]) and (CodeInput.Text = linename[5]) then begin
        if (textDate = false) and (txt214_2.Text =monthdate[1]) then txt214_2.Text :=monthdate[1]
        else if (textDate = false) and (txt214_2.Text =monthdate[2]) then txt214_2.Text :=monthdate[1]
        else if (textDate = false) and (txt214_2.Text =monthdate[3]) then txt214_2.Text :=monthdate[2]
        else if (textDate = false) and (txt214_2.Text =monthdate[4]) then txt214_2.Text :=monthdate[3]
        else if (textDate = false) and (txt214_2.Text =monthdate[5]) then txt214_2.Text :=monthdate[4]
        else if (textDate = false) and (txt214_2.Text =monthdate[6]) then txt214_2.Text :=monthdate[5]
        else if (textDate = false) and (txt214_2.Text =monthdate[7]) then txt214_2.Text :=monthdate[6]
        else if (textDate = false) and (txt214_2.Text =monthdate[8]) then txt214_2.Text :=monthdate[7]
        else if (textDate = false) and (txt214_2.Text =monthdate[9]) then txt214_2.Text :=monthdate[8]
        else if (textDate = false) and (txt214_2.Text =monthdate[10]) then txt214_2.Text :=monthdate[9]
        else if (textDate = false) and (txt214_2.Text =monthdate[11]) then txt214_2.Text :=monthdate[10]
        else if (textDate = false) and (txt214_2.Text =monthdate[12]) then txt214_2.Text :=monthdate[11]
    end
    {..........................................................................}
    else if (code.Text = linecode[18]) or (code.Text = linecode[28]) then begin
        if txtvalue2.Text =onof[1] then txtvalue2.Text :=onof[1]
        else if txtvalue2.Text =onof[2] then txtValue2.Text := onof[1];
    end
    {..........................................................................}
    else if (code.Text = linecode[19]) or (code.Text = linecode[29]) then begin
        if txtvalue.Text =predm[1] then txtvalue.Text :=predm[1]
        else if txtvalue.Text =predm[2] then txtvalue.Text :=predm[1];
    end
    {..........................................................................}
    else if (code.Text = linecode[21]) or (code.Text = linecode[31]) then begin
        if txtvalue.Text =speedcode[1] then txtvalue.Text :=speedcode[1]
        else if txtvalue.Text =speedcode[2] then txtvalue.Text :=speedcode[1]
        else if txtvalue.Text =speedcode[3] then txtvalue.Text :=speedcode[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[22]) or (code.Text = linecode[32]) then begin
        if txtvalue.Text =homing[1] then txtvalue.Text :=homing[1]
        else if txtvalue.Text =homing[2] then txtvalue.Text :=homing[1]
        else if txtvalue.Text =homing[3] then txtvalue.Text :=homing[2];
    end
    {..........................................................................}
    else if (code.Text = linecode[24]) or (code.Text = linecode[33]) then begin
        if txtvalue.Text =modesursub[1] then txtvalue.Text :=modesursub[1]
        else if txtvalue.Text =modesursub[2] then txtvalue.Text :=modesursub[1];
    end
    {..........................................................................}
     else if (code.Text = linecode[27]) or (code.Text = linecode[36]) then begin
        if txtvalue.Text =tcomunit[1] then txtvalue.Text :=tcomunit[1]
        else if txtvalue.Text =tcomunit[2] then txtvalue.Text :=tcomunit[1]
        else if txtvalue.Text =tcomunit[3] then txtvalue.Text :=tcomunit[2];
    end;
    {..........................................................................}

    if CodeInput.Text = linename[10] then applynumber('  -');
    if textDate = True then begin
       txt214_2.Text := 'J U N';
       txt214_1.Text := txt214_3.Text + ' . ';
       txt214_3.Text := '';
       textDate      := False;
    end;
  end;
end;


procedure TvDisplayCtrlPanelLeft.FormDestroy(Sender: TObject);
begin
  trackNo.Destroy;
end;

{ ================== nilai course berubah (torpedo manual) ====================}
procedure TvDisplayCtrlPanelLeft.txt506_1Change(Sender: TObject);
begin
  inherited;
   ShowDataByMode(GetPredmType_fromStr(txt506_1.Text), ttStarBoard );
end;

procedure TvDisplayCtrlPanelLeft.txt507_1Change(Sender: TObject);
var
  tR   : TTorpedoTrack;
begin
    if (TOCOS.torpManual <> nil) and (TOCOS.torpManual.Tube = ttStarBoard) then begin
       tR := TOCOS.torpManual;
       tR.UpdateTrack(tR.Course);
    end;
end;

procedure TvDisplayCtrlPanelLeft.txt606_1Change(Sender: TObject);
begin
//  inherited;
  ShowDataByMode(GetPredmType_fromStr(txt606_1.Text), ttPort);
end;

procedure TvDisplayCtrlPanelLeft.txt607_1Change(Sender: TObject);
var
  tR   : TTorpedoTrack;
begin
    if (TOCOS.torpManual <> nil) and (TOCOS.torpManual.Tube = ttPort) then begin
       tR := TOCOS.torpManual;
       tR.UpdateTrack(tR.Course);
    end;
end;

procedure TvDisplayCtrlPanelLeft.txt608_1Change(Sender: TObject);
begin
  inherited;

end;

{ ========================== nilai endis berubah ==============================}
procedure TvDisplayCtrlPanelLeft.txt510_2Change(Sender: TObject);
//var
//  i    : Byte;
//  tR   : TTorpedoTrack;
begin
//  inherited;
//   if not TOCOS.GetTorp_fromTube(ttStarBoard,i,tR) then begin
//       if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = ttStarBoard) then
//          tR := TOCOS.torpManual;
//    end;
//
//    tR.UpdateTrack(tR.Course);
end;

procedure TvDisplayCtrlPanelLeft.txt512_2Change(Sender: TObject);
var
  i    : Byte;
  tR   : TTorpedoTrack;
begin
    if not TOCOS.GetTorp_fromTube(ttStarBoard,i,tR) then begin
       if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = ttStarBoard) then
          tR := TOCOS.torpManual;
    end;
    if txt503.Text = 'O F F' then Exit;
    if Assigned(tR)  then
      tR.UpdateTrack(tR.Course);
end;

procedure TvDisplayCtrlPanelLeft.txt612_2Change(Sender: TObject);
var
  i    : Byte;
  tR   : TTorpedoTrack;
begin
    if not TOCOS.GetTorp_fromTube(ttPort,i,tR) then begin
       if Assigned(TOCOS.torpManual) and (TOCOS.torpManual.Tube = ttPort) then
          tR := TOCOS.torpManual;
    end;
    if txt603.Text = 'O F F' then Exit;
    if Assigned(tR)  then
      tR.UpdateTrack(tR.Course);
end;

function TvDisplayCtrlPanelLeft.VAlidateValue(val: single;
  Unittipe: TUnitTipe): single;
Var MinVal, MaxVal : Single;

  function GetResult(Inval: single): Single;
  begin
      if Inval <= MinVal then
        Result := MinVal
      else if Inval >= MaxVal then
        Result := MaxVal
      else
        Result := Inval;
  end;
begin
case Unittipe of
    Deg: Result := ValidateDegree(val);
    Knt: begin
      MinVal := 0.0;
      MaxVal := 99.9;
      Result := GetResult(val);
    end;

    Yrd: begin
      MinVal := 0;
      MaxVal := 9999;
      Result := GetResult(val);
    end;

    UpLim_Ft: begin
      MinVal := 6;
      MaxVal := 1518;
      Result := GetResult(val);
    end;

    LoLim_Ft: begin
      MinVal := 18;
      MaxVal := 1518;
      Result := GetResult(val);
    end;

    Sec:  begin
      MinVal := 0;
      MaxVal := 59;
      Result := GetResult(val);
    end;
    Lat : begin
      MinVal := -90;
      MaxVal := 90;
      Result := GetResult(val);
    end;
    Day: begin
      MinVal := 01;
      MaxVal := 31;
      Result := GetResult(val);
    end;
    Year: begin
      MinVal := 01;
      MaxVal := 99;
      Result := GetResult(val);
    end;
end;
end;


{================================== DATE ======================================}
procedure TvDisplayCtrlPanelLeft.txt214_3Change(Sender: TObject);
var s:String;
//    i:Integer;
begin
  if (TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar) or
     (TOCOS.tocosMode = mRemote) then begin
      s:= StringReplace(txt214_3.Text,' ','',[rfReplaceAll]);
      textDate := True;
      if (Length(s) = 2) and (txt214_1.Text <> '') then begin
        txt214_3.Text := ' . ' + txt214_3.Text;
        textDate := False;
      end;
  end;

end;

{========================= LOCAL TIME =========================================}
procedure TvDisplayCtrlPanelLeft.txt2142_3Change(Sender: TObject);
var s, temp:String;
    i:Integer;
begin
  if (TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mLocalwSonar) then begin
     s:= StringReplace(txt2142_3.Text,' ','',[rfReplaceAll]);

     if (Length(s) = 3) then begin
        for i:=1 to 2 do begin
          temp := temp + s[i] + '  ';
        end;


        if (txt2142_2.Text = '') and (txt2142_1.Text = '') then begin
            txt2142_2.Text := temp + ': ';
        end
        else if (txt2142_1.Text = '') and (txt2142_2.Text <> '') then begin
            txt2142_1.Text := txt2142_2.Text ;
            txt2142_2.Text := temp + ': ';
        end;

        txt2142_3.Text := s[3];
     end;
  end;

end;

procedure TvDisplayCtrlPanelLeft.SystemOff;
begin
  {Page 2 reset}
  txtget203.Text := '';
  txtget204.Text := '';
  txtget205.Text := '';
  txtget206.Text := '';

  {Page 3 reset}
  txtget303.Text := '';
  txtget305.Text := '';
  txtget306.Text := '';
  txtget307.Text := '';
  txtget308.Text := '';
  txtget312.Text := '';

  txtget3032.Text := '';
  txtget3052.Text := '';
  txtget3062.Text := '';
  txtget3072.Text := '';
  txtget3082.Text := '';
  txtget3122.Text := '';

  {Page 4 reset}
  txttargetno_1.Text  := '';
  targetbearing1.Text := '';
  targetrange1.Text   := '';
  targetcourse1.Text  := '';
  targetspeed1.Text   := '';
  txttargetno_2.Text  := '';
  targetbearing2.Text := '';
  targetrange2.Text   := '';
  targetcourse2.Text  := '';
  targetspeed2.Text   := ' ';

  {Page 5 reset}
  txtget503.Text := '';       {Target No}
  txt503.Text   := 'O F F';   {Run}
  txt506_1.Text := 'I N T';   {Prediction Mode}
  txt506_2.Text := '';        {Torpedo Track}
  txt507_1.Text := '0';       {Course}
  txt507_2.Text := '';        {Ladis}
  txt508_1.Text := 'L O W';   {Speed}
  txt508_2.Text := '';        {CSpeed}
  txt509_1.Text := 'P A S';   {Homing}
  txt509_2.Text := '';        {Uplim}
  txt510_1.Text := 'S U R';   {Mode Surb}
  txt510_2.Text := '0';       {Depth}
  txt511_1.Text := 'O N';     {Mode Lolim}
  txt511_2.Text := '';        {Lolim}
  txt512_1.Text := 'O F F';   {Homing Block}
  txt512_2.Text := '0';       {Endis}
  txt514_2.Text := '';        {Srell}
  txt515.Text   := '';        {Trell}

  {Page 6 reset}
  txtget603.Text := '';       {Target No}
  txt603.Text   := 'O F F';   {Run}
  txt606_1.Text := 'I N T';   {Prediction Mode}
  txt606_2.Text := '';        {Torpedo Track}
  txt607_1.Text := '0';       {Course}
  txt607_2.Text := '';        {Ladis}
  txt608_1.Text := 'L O W';   {Speed}
  txt608_2.Text := '';        {CSpeed}
  txt609_1.Text := 'P A S';   {Homing}
  txt609_2.Text := '';        {Uplim}
  txt610_1.Text := 'S U R';   {Mode Surb}
  txt610_2.Text := '0';       {Depth}
  txt611_1.Text := 'O N';     {Mode Lolim}
  txt611_2.Text := '';        {Lolim}
  txt612_1.Text := 'O F F';   {Homing Block}
  txt612_2.Text := '0';       {Endis}
  txt614_2.Text := '';        {Srell}
  txt615.Text   := '';        {Trell}
end;
end.
