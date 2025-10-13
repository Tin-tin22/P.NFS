unit ufMIK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrDesign, ExtCtrls, ufANDUkeyBoard,
  ImgList;

type

  TfMIK = class(TfrmANDUKey)
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
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }

{    procedure btn_AlphaNumClick(Sender: TObject);
    procedure btn_BackSpaceClick(Sender: TObject);
    procedure btn_4spaceClick(Sender: TObject);
    procedure btn_ExecuteClick(Sender: TObject);
    procedure btn_EraseLineClick(Sender: TObject);
    procedure btn_SpaceClick(Sender: TObject);
    procedure btn_RBClick(Sender: TObject);
}
  public
    { Public declarations }
     procedure LoadImageList; override;

  end;

var
  fMIK: TfMIK;

implementation

{$R *.dfm}

procedure TfMIK.LoadImageList;
var i: integer;
    bmp: TBitmap;
    vb: TVrBitmapButton;
begin
  bmp := TBitmap.Create;
  bmp.LoadFromFile(image_path+ 'tdc\key_whiteBox.bmp');

  for i := 0 to ComponentCount-1 do begin
     if Components[i] is TVrBitmapButton then begin
       vb := Components[i] as TVrBitmapButton;
       vb.Glyph.Assign(bmp);
     end

  end;
  bmp.Free;


end;

procedure TfMIK.FormCreate(Sender: TObject);
var i: integer;
    s: string;
    btn: TVrBitmapButton;
begin
  image_path := ExtractFilePath(Application.ExeName) + 'data\images\';
//  LoadImageList;

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

procedure TfMIK.FormDestroy(Sender: TObject);
begin
  //
end;


{procedure TfMIK.btn_AlphaNumClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + char( byte((sender as TComponent).Tag));
  Display.SetICLText(Mnemonic);
end;

procedure TfMIK.btn_BackSpaceClick(Sender: TObject);
begin
  SetLength(Mnemonic, Length(Mnemonic)-1);
  Display.SetICLText(Mnemonic);
end;


procedure TfMIK.btn_4spaceClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + '   ';
  Display.SetICLText(Mnemonic);
end;

procedure TfMIK.btn_ExecuteClick(Sender: TObject);
begin
  ParseCommand(Mnemonic);
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;

procedure TfMIK.btn_EraseLineClick(Sender: TObject);
begin
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;

procedure TfMIK.btn_SpaceClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + ' ';
  Display.SetICLText(Mnemonic);
end;


procedure TfMIK.btn_RBClick(Sender: TObject);
begin
  FindTrackByOBM;
end;
}
procedure TfMIK.FormKeyPress(Sender: TObject; var Key: Char);
const alphaNum = ['A'..'Z', 'a'..'z', '0'..'9', '.', '+', '-'];
      alphaSmall = ['a'..'z'];
begin
//  inherited;

 if Ord(Key) = VK_BACK	then  begin
    key_BackSpace(Key);
  end
  else
  if Ord(Key) = VK_RETURN	then begin
    key_Execute(Key);
  end
  else
  if Ord(Key) = VK_SPACE then begin
    key_Space(Key);
  end
  else
    if Key in alphanum then
      key_AlphaNum(UpCase(Key));

  Display.SetICLText(Mnemonic);
  Key := #0;

end;

procedure TfMIK.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;

  if Key = VK_LEFT then  begin
    key_lastexect('^');
    Display.SetICLText(Mnemonic);
  end


end;

end.
