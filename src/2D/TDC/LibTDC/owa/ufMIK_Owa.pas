unit ufMIK_Owa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufKeyBoard, ImgList, StdCtrls, VrControls, VrDesign, ExtCtrls,
  uLibTDCClass;

type
//  TInputState = (is_Ready, is_FromDRL  );

  TCmp_Stat = record
    Change : boolean;
    OldStr, NewStr : string;
  end;

  TStr_Compare_Array = array of TCmp_Stat;

  TfrmMIK_Owa = class(TfrmKeyBoard)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
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
    btn_RB: TVrBitmapButton;
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
    btn_17: TVrBitmapButton;
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
//    function Do_1_command(const ss: TStrings): integer;

    function Do_ExecLine_SP1(const ss: TStrings): integer;
    function Do_ExecLine_SP2(const aPar, aLine: Char; const sCmd : string): integer;

    function Do_Exec_Command(const sCmd: string): integer;

  public
    { Public declarations }
    OBM : TTDC_Symbol;
    ActiveSystemPage : byte;
    ActivePar  : char;
    ActiveLine : char;

    function  ParseCommand(const str: string): integer; override;


    procedure btn_RBClick(Sender: TObject);
  end;


implementation

uses
  uStringFunction, uBaseFunction, uTrackFunction, ufDisplay_OWA, Math;
{$R *.dfm}

{ TfrmMIK_Owa }

function TfrmMIK_Owa.ParseCommand(const str: string): integer;
var ss   : TStrings;
    sLen, err : integer;
    c1, c2   : Char;
    b : byte;
    s, sDRL : string;
    owaDisplay : TfrmDisplay_Owa;
begin
  result := 0;
  sLen := Length(str);
  if sLen = 0 then exit;


  owaDisplay := (Display as TfrmDisplay_Owa);
  c1 := str[1];

  case sLen of
    1 : begin
        // tergantung last command;
          case c1 of
            '+': begin // plus execute
               if ActiveSystemPage = 2 then begin
                 owaDisplay.Erase_SystemPage(ActiveSystemPage);
                 owaDisplay.Display_Paragraph(ActivePar);
                 owaDisplay.SetICLText('');
             end;
            end;
            '-': begin  // min execute
               if ActiveSystemPage = 2 then begin
                 owaDisplay.Erase_Paragraph(ActivePar);
                 owaDisplay.SetICLText('');
               end;
            end
            else begin
               // one char command
              if Do_Exec_Command(str) > 0 then
                 owaDisplay.SetICLText('');

            end;

          end; // of case

    end; //sLen =1

    2 : begin
          c2 := str[2];
          if c1 in ['1', '2'] then begin
            Val(c1, b, err);

            case c2 of
              '+' : begin // 1+  2+
                      owaDisplay.Erase_SystemPage(b);
                      owaDisplay.Display_SystemPage(b);

                      result := 1;
                      owaDisplay.SetICLText('');
              end;
              '-' : begin // 1-  2-
                      if err = 0 then begin
                        owaDisplay.Erase_SystemPage(b);
                       // owaDisplay.WipeActivePage;
                        owaDisplay.SetICLText('');
                        result := 1;
                      end;
               end;
               'A' .. 'K' :  begin // 1A .. 1K,  2A ..  2K
                    s := owaDisplay.GetSysPageLine(b,  c2);
                    owaDisplay.SetDRLText(s);
                    owaDisplay.SetICLText('');

                    ActiveSystemPage := b;
                    ActiveLine := c2; // for 1
                    ActivePar  := c2;

                    result := 1;
               end;
            end;
          end //if c1 in 1,2
          else
          if c1 in ['A' .. 'K'] then begin
            // AA, AB .. KA, KD
            owaDisplay.DisplayParLine_DRL(c1, c2);
            owaDisplay.SetICLText('');

            ActiveSystemPage := 2;
            ActivePar  := c1;
            ActiveLine := c2; // for 1

          end;


    end  // len =2
    else begin
       // command panjang
      c2 := str[2];
      if (c1 = ' ') and (c2 = ' ') then begin
       // insert data
        sDRL := owaDisplay.DRL.Text;
        s := MergeSpaceString(sDRL, str);

        owaDisplay.Edit1.Text := s;

        if ActiveSystemPage = 1 then begin
          ss := TStringList.Create;
          Split_2(' ', Trim(s), ss);
          if ss.Count < 1 then exit;
            result := Do_ExecLine_SP1(ss);
            if result  > 0 then begin

              s := owaDisplay.GetSysPageLine(ActiveSystemPage, ActiveLine);
              owaDisplay.SetSysPageLine(ActiveSystemPage, ActiveLine, s);
              owaDisplay.SetDRLText(s);
              owaDisplay.SetICLText('');
            end;
          ss.Clear;
          ss.Free;
        end
        else
           if ActiveSystemPage = 2 then begin
            result := owaDisplay.exec_SP2_Func(ActivePar, ActiveLine, s );
            if result  > 0 then begin

              owaDisplay.SetDRLText(s);
              owaDisplay.SetICLText('');
              owaDisplay.Update_Paragraph(ActivePar, ActiveLine);
            end

           end;

       end
      else begin

          if Do_Exec_Command(str) > 0 then begin
             owaDisplay.SetICLText('');

          end;

      end;

    end;
  end;


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
    btn.Glyph := btn_17.Glyph;
  end;

  for i := 0 to 9 do begin
    s := 'btn_'+ char(ord('0')+i);
    btn := FindComponent(s) as TVrBitmapButton;
    btn.Tag := ord('0') + i;
    btn.OnClick := btn_AlphaNumClick;
    btn.Glyph :=  btn_RB.Glyph;
  end;

  btn_dot.Tag       := ord('.');
  btn_dot.OnClick   := btn_AlphaNumClick;
  btn_dot.Glyph := btn_RB.Glyph;

  btn_plus.Tag      := ord('+');
  btn_plus.OnClick  := btn_AlphaNumClick;
  btn_plus.Glyph := btn_RB.Glyph;

  btn_minus.Tag     := ord('-');
  btn_minus.OnClick := btn_AlphaNumClick;
  btn_minus.Glyph := btn_RB.Glyph;


  btn_RB.OnClick         := btn_RBClick;

  btn_Space.Tag      := ord(' ');
  btn_space.OnClick  := btn_AlphaNumClick;
  btn_4space.OnClick     := btn_4SpaceClick;
  btn_4space.Glyph       := btn_Space.Glyph;

  btn_BackSpace.OnClick  := btn_BackSpaceClick;
  btn_Backspace.Glyph       := btn_Space.Glyph;

  btn_EraseSpace.OnClick := btn_EraseLineClick;
  btn_EraseSpace.Glyph       := btn_Space.Glyph;

  btn_Execute.OnClick    := btn_ExecuteClick;
end;

procedure TfrmMIK_Owa.btn_RBClick(Sender: TObject);
begin
  //FindTrackByOBM;
end;

{function TfrmMIK_Owa.Do_1_command(const ss: TStrings): integer;
var owaDisplay : TfrmDisplay_Owa;
    w : word;
    s, cmd : string;
    Len : integer;
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
                if cmd[2] in ['A' .. 'K'] then begin
                  s := owaDisplay.DisplaySysPageLine(1,  cmd[2]);
                  owaDisplay.SetSysPageLine(1, cmd[2], s);
                  owaDisplay.SetDRLText(s);
//                  owaDisplay.SetICLText(s);

                  ActivePage := 1;              Death If I Ran
                  ActiveLine := cmd[2];

                  result := 1;
                end;
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
}
function TfrmMIK_Owa.Do_ExecLine_SP1(const ss: TStrings): integer;
var s1 : string;
    owaDisplay : TfrmDisplay_Owa;
begin
  result := 0;
  owaDisplay := (Display as TfrmDisplay_Owa);
  if owaDisplay = nil then exit;

  if ss.Count < 3 then exit;
  // ini page 1 dulu.

  if length(ss[0]) = 1 then begin
    result := owaDisplay.exec_SP1_Func(ss[0][1], ss);
    s1 := owaDisplay.GetSysPageLine(1, ss[0][1]);
    owaDisplay.SetSysPageLine(1, ss[0][1] , s1)
  end;

end;


function TfrmMIK_Owa.Do_ExecLine_SP2(const aPar, aLine: Char; const sCmd : string): integer;
var
   owaDisplay : TfrmDisplay_Owa;
begin
  // sData ~ sCmd

  owaDisplay := (Display as TfrmDisplay_Owa);
  if owaDisplay = nil then exit;

  owaDisplay.exec_SP2_Func(aPar, aLine, sCmd );


end;

function TfrmMIK_Owa.Do_Exec_Command(const sCmd: string): integer;

var w: word;
    owaDisplay : TfrmDisplay_Owa;
    ss: TStrings;
begin
  ss := TStringList.Create;
  Split_2(' ', Trim(sCmd), ss);
  if ss.Count < 1 then exit;

  result := 0;
  owaDisplay := (Display as TfrmDisplay_Owa);
  if owaDisplay = nil then exit;

  if ss[0] = 'WP' then begin
    if ss.Count < 2 then exit;

    if not ConvertToWord(ss[1], w) or (w < 1) or (w > 3) then exit;
    dec(w);
    owaDisplay.SelectPage(w);
    ActiveSystemPage :=  owaDisplay.WPData[w].CSysPage;
    ActivePar        := PageByteTochar(owaDisplay.WPData[w].Cpar);
    ActiveLine       := PageByteTochar(owaDisplay.WPData[w].CLin);
    result := 1;
  end;

  if ss[0] = 'P' then begin
    result := owaDisplay.tdc_CreateSpecialPoint(obm.mPos.X, obm.mPos.Y);
  end;

  ss.Clear;
  ss.Free;

end;

end.
