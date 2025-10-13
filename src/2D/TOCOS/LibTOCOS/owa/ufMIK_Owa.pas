unit ufMIK_Owa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufKeyBoard, ImgList, StdCtrls, VrControls, VrDesign, ExtCtrls,
  uLibTDCClass;

type
//  TInputState = (is_Ready, is_FromDRL  );

  TfrmMIK_Owa = class(TfrmKeyBoard)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    btn_RB: TVrBitmapButton;
    Label2: TLabel;
    btn_plus: TVrBitmapButton;
    Label3: TLabel;
    btn_minus: TVrBitmapButton;
    Label4: TLabel;
    btn_7: TVrBitmapButton;
    Label5: TLabel;
    btn_8: TVrBitmapButton;
    Label6: TLabel;
    btn_9: TVrBitmapButton;
    Label7: TLabel;
    btn_4: TVrBitmapButton;
    Label8: TLabel;
    btn_5: TVrBitmapButton;
    Label9: TLabel;
    btn_6: TVrBitmapButton;
    Label10: TLabel;
    btn_1: TVrBitmapButton;
    Label11: TLabel;
    btn_2: TVrBitmapButton;
    Label12: TLabel;
    btn_3: TVrBitmapButton;
    Label13: TLabel;
    btn_0: TVrBitmapButton;
    Label14: TLabel;
    btn_dot: TVrBitmapButton;
    Label16: TLabel;
    GroupBox2: TGroupBox;
    VrBitmapButton15: TVrBitmapButton;
    Label15: TLabel;
    btn_B: TVrBitmapButton;
    Label19: TLabel;
    Label20: TLabel;
    btn_A: TVrBitmapButton;
    Label22: TLabel;
    btn_C: TVrBitmapButton;
    Label23: TLabel;
    btn_D: TVrBitmapButton;
    Label24: TLabel;
    btn_E: TVrBitmapButton;
    Label25: TLabel;
    btn_F: TVrBitmapButton;
    Label26: TLabel;
    btn_G: TVrBitmapButton;
    Label27: TLabel;
    VrBitmapButton17: TVrBitmapButton;
    btn_4space: TVrBitmapButton;
    Label18: TLabel;
    btn_H: TVrBitmapButton;
    btn_I: TVrBitmapButton;
    btn_J: TVrBitmapButton;
    btn_K: TVrBitmapButton;
    btn_L: TVrBitmapButton;
    btn_M: TVrBitmapButton;
    btn_N: TVrBitmapButton;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    btn_O: TVrBitmapButton;
    btn_P: TVrBitmapButton;
    btn_Q: TVrBitmapButton;
    btn_R: TVrBitmapButton;
    btn_S: TVrBitmapButton;
    btn_T: TVrBitmapButton;
    btn_U: TVrBitmapButton;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    btn_V: TVrBitmapButton;
    btn_W: TVrBitmapButton;
    btn_X: TVrBitmapButton;
    btn_Y: TVrBitmapButton;
    btn_Z: TVrBitmapButton;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    btn_BackSpace: TVrBitmapButton;
    btn_EraseSpace: TVrBitmapButton;
    btn_Space: TVrBitmapButton;
    lbl_BackSpace: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    lbl_Space: TLabel;
    btn_Execute: TVrBitmapButton;
    lbl_Execute: TLabel;
    lblText: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function Do_1_command(const ss: TStrings): integer;
  public
    { Public declarations }
    OBM : TTDC_Symbol;
    ActivePage : byte;
    ActivePar  : char;
    ActiveLine : char;

    function  ParseCommand(const str: string): integer; override;

//    function 

    procedure btn_RBClick(Sender: TObject);
  end;


implementation

uses
  uStringFunction, uBaseFunction, uTrackFunction, ufDisplay_OWA;
{$R *.dfm}

{ TfrmMIK_Owa }

function TfrmMIK_Owa.ParseCommand(const str: string): integer;
var ss : TStrings;
begin
  result := 0;
  ss := TStringList.Create;
  Split(' ', Trim(str), ss);
  if ss.Count < 1 then exit;

  result :=  Do_1_command(ss);


  ss.Clear;
  ss.Free;
end;

procedure TfrmMIK_Owa.FormCreate(Sender: TObject);
var i: integer;
    s: string;
    btn: TVrBitmapButton;
begin

  for i := 0 to 25 do begin
    s := 'btn_'+ char(ord('A')+i);
    btn := FindComponent(s) as TVrBitmapButton;
    btn.Tag := ord('A') + i;
    btn.OnClick := btn_AlphaNumClick;
  end;

  for i := 0 to 9 do begin
    s := 'btn_'+ char(ord('0')+i);
    btn := FindComponent(s) as TVrBitmapButton;
    btn.Tag := ord('0') + i;
    btn.OnClick := btn_AlphaNumClick;
  end;

  btn_dot.Tag       := ord('.');
  btn_dot.OnClick   := btn_AlphaNumClick;

  btn_plus.Tag      := ord('+');
  btn_plus.OnClick  := btn_AlphaNumClick;

  btn_minus.Tag     := ord('-');
  btn_minus.OnClick := btn_AlphaNumClick;

  btn_Space.Tag      := ord(' ');
  btn_space.OnClick  := btn_AlphaNumClick;

  btn_4space.OnClick     := btn_4SpaceClick;
  btn_BackSpace.OnClick  := btn_BackSpaceClick;
  btn_EraseSpace.OnClick := btn_EraseLineClick;
  btn_Execute.OnClick    := btn_ExecuteClick;
  btn_RB.OnClick         := btn_RBClick;
end;

procedure TfrmMIK_Owa.btn_RBClick(Sender: TObject);
begin
  //FindTrackByOBM;
end;

function TfrmMIK_Owa.Do_1_command(const ss: TStrings): integer;
var owaDisplay : TfrmDisplay_Owa;
    w : word;
    s, cmd : string;
    ix, Len : integer;
begin
  result := 0;

  owaDisplay := (Display as TfrmDisplay_Owa);
  if ss.Count = 1 then begin
    cmd := Trim(ss[0]);
    Len := Length(cmd);
    case Len  of
      2 : begin
        case cmd[1] of
          '1' : begin
            case cmd[2] of
              '+' : begin
                owaDisplay.Display_Page_SP1;
                result := 1;
              end;
              '-' : begin
                owaDisplay.WipeActivePage;
                result := 1;
              end
              else begin
                s := owaDisplay.GetSysPageLine(1, cmd[2]);
                owaDisplay.SetDRLText(s);
                ActivePage := 1;
                ActiveLine := cmd[2];

                result := 1;
              end;
            end;
          end;
          '2' : begin
            case cmd[2] of
              '+' : begin
                owaDisplay.Display_Page_SP2;
                result := 1;
              end;
              '-' : begin
                owaDisplay.WipeActivePage;
                result := 1;
              end
              else begin
                // 2b exc: display paragraph 2b di DRL
                s := owaDisplay.GetSysPageLine(2, cmd[2]);
                owaDisplay.SetDRLText(s);

                ActivePage := 2;
                ActivePar  := cmd[2];

                result := 1;
              end;
            end;
          end; // of '2'
          'A' .. 'F', 'I', 'K' : begin
             s := owaDisplay.GetParagraphLine(cmd[1], cmd[2]);
             owaDisplay.SetDRLText(s);
                ActivePage := 2;
                ActivePar  := cmd[1];
                ActiveLine := cmd[2];

                result := 1;
          end
        end;  // of case cmd[1]
      end;
      3: begin
         if (cmd[1] = '2') and (cmd[3] = '+') then begin
          // 2b+ exc: display paragraph 2b di working page
          owaDisplay.Display_Paragraph(cmd[2]);
          ActivePage := 2;
          ActivePar  := cmd[2];
          ActiveLine := ' ';

          result := 1;
        end;

      end;


    end;

  end

  else if ss.Count = 2 then begin
    if ss[0] = 'WP' then begin
      result := 1;
      if not ConvertToWord(ss[1], w) or (w < 1) or (w > 3) then exit;
       owaDisplay.SelectPage(w - 1 );
      result := 1;
    end


  end

end;

end.
