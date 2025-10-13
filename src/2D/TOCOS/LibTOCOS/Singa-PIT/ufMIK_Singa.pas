unit ufMIK_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufANDUKeyboard, ImgList, VrControls, VrDesign, VrButtons,
  StdCtrls, ExtCtrls;

type
  TfrmMIK_Singa = class(TfrmANDUKey)
    Panel2: TPanel;
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
    VrBitmapButton15: TVrBitmapButton;
    Label15: TLabel;
    btn_B: TVrBitmapButton;
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
    VrBitmapButton1: TVrBitmapButton;
    VrBitmapButton2: TVrBitmapButton;
    VrBitmapButton3: TVrBitmapButton;
    VrBitmapButton4: TVrBitmapButton;
    VrBitmapButton5: TVrBitmapButton;
    VrBitmapButton6: TVrBitmapButton;
    VrBitmapButton7: TVrBitmapButton;
    VrBitmapButton8: TVrBitmapButton;
    VrBitmapButton9: TVrBitmapButton;
    VrBitmapButton10: TVrBitmapButton;
    VrBitmapButton11: TVrBitmapButton;
    VrBitmapButton12: TVrBitmapButton;
    VrBitmapButton13: TVrBitmapButton;
    VrBitmapButton14: TVrBitmapButton;
    VrBitmapButton16: TVrBitmapButton;
    VrBitmapButton17: TVrBitmapButton;
    VrBitmapButton18: TVrBitmapButton;
    VrBitmapButton19: TVrBitmapButton;
    VrBitmapButton20: TVrBitmapButton;
    VrBitmapButton21: TVrBitmapButton;
    VrBitmapButton22: TVrBitmapButton;
    VrBitmapButton23: TVrBitmapButton;
    VrBitmapButton24: TVrBitmapButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Mnemonic : string;

{   procedure btn_AlphaNumClick(Sender: TObject);
    procedure btn_BackSpaceClick(Sender: TObject);
    procedure btn_4spaceClick(Sender: TObject);
    procedure btn_ExecuteClick(Sender: TObject);
    procedure btn_EraseSpaceClick(Sender: TObject);
    procedure btn_RBClick(Sender: TObject);
}
  public
    { Public declarations }
     procedure LoadImageList; override;

  end;

var
  frmMIK_Singa: TfrmMIK_Singa;

implementation

{$R *.dfm}

procedure TfrmMIK_Singa.LoadImageList;
var i: integer;
    bmp: TBitmap;
    vb: TVrBitmapButton;
begin
  bmp := TBitmap.Create;
  if FileExists(image_path+ 'tdc\key_whiteBox.bmp') then begin
    bmp.LoadFromFile(image_path+ 'tdc\key_whiteBox.bmp');

    for i := 0 to ComponentCount-1 do begin
       if Components[i] is TVrBitmapButton then begin
         vb := Components[i] as TVrBitmapButton;
         vb.Glyph.Assign(bmp);
       end

    end;

    bmp.Dormant;
    bmp.FreeImage;
    bmp.ReleaseHandle;
  end;


  if FileExists(image_path+ 'tdc\key_whiteBig.bmp') then begin
    bmp.LoadFromFile(image_path+ 'tdc\key_whiteBig.bmp');
    btn_Execute.Glyph.Assign(bmp);
    bmp.Dormant;
    bmp.FreeImage;
    bmp.ReleaseHandle;
  end;

  bmp.Free;


end;

procedure TfrmMIK_Singa.FormCreate(Sender: TObject);
var i: integer;
    s: string;
    btn: TVrBitmapButton;
begin
  image_path := ExtractFilePath(Application.ExeName) ;
  image_path := Copy(image_path,1,Length(image_path)-4)+ 'data\images\';
  LoadImageList;
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
  //
end;

procedure TfrmMIK_Singa.FormDestroy(Sender: TObject);
begin
  //
end;
{
procedure TfrmMIK_Singa.btn_AlphaNumClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + char( byte((sender as TComponent).Tag));
  Display.SetICLText(Mnemonic);
end;

procedure TfrmMIK_Singa.btn_BackSpaceClick(Sender: TObject);
begin
  SetLength(Mnemonic, Length(Mnemonic)-1);
  Display.SetICLText(Mnemonic);
end;


procedure TfrmMIK_Singa.btn_4spaceClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + '   ';
  Display.SetICLText(Mnemonic);
end;

procedure TfrmMIK_Singa.btn_ExecuteClick(Sender: TObject);
begin
//  Action_Mnemonic(Mnemonic);
  ParseCommand(Mnemonic);
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;

procedure TfrmMIK_Singa.btn_EraseSpaceClick(Sender: TObject);
begin
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;


procedure TfrmMIK_Singa.btn_RBClick(Sender: TObject);
begin
  FindTrackByOBM;
end;
}
end.
