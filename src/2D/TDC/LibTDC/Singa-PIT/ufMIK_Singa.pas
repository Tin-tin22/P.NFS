unit ufMIK_Singa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufANDUKeyboard, ImgList, VrControls, VrDesign, VrButtons,
  StdCtrls, ExtCtrls, Buttons, SpeedButtonImage;

type
  TfrmMIK_Singa = class(TfrmANDUKey)
    Panel2: TPanel;
     VrBitmapButton1 : TSpeedButtonImage;
     VrBitmapButton10 : TSpeedButtonImage;
     VrBitmapButton11 : TSpeedButtonImage;
     VrBitmapButton12 : TSpeedButtonImage;
     VrBitmapButton13 : TSpeedButtonImage;
     VrBitmapButton14 : TSpeedButtonImage;
     VrBitmapButton15 : TSpeedButtonImage;
     VrBitmapButton16 : TSpeedButtonImage;
     VrBitmapButton17 : TSpeedButtonImage;
     VrBitmapButton18 : TSpeedButtonImage;
     VrBitmapButton19 : TSpeedButtonImage;
     VrBitmapButton2 : TSpeedButtonImage;
     VrBitmapButton20 : TSpeedButtonImage;
     VrBitmapButton21 : TSpeedButtonImage;
     VrBitmapButton22 : TSpeedButtonImage;
     VrBitmapButton23 : TSpeedButtonImage;
     VrBitmapButton24 : TSpeedButtonImage;
     VrBitmapButton3 : TSpeedButtonImage;
     VrBitmapButton4 : TSpeedButtonImage;
     VrBitmapButton5 : TSpeedButtonImage;
     VrBitmapButton6 : TSpeedButtonImage;
     VrBitmapButton7 : TSpeedButtonImage;
     VrBitmapButton8 : TSpeedButtonImage;
     VrBitmapButton9 : TSpeedButtonImage;
     btn_0 : TSpeedButtonImage;
     btn_1 : TSpeedButtonImage;
     btn_2 : TSpeedButtonImage;
     btn_3 : TSpeedButtonImage;
     btn_4 : TSpeedButtonImage;
     btn_4space : TSpeedButtonImage;
     btn_5 : TSpeedButtonImage;
     btn_6 : TSpeedButtonImage;
     btn_7 : TSpeedButtonImage;
     btn_8 : TSpeedButtonImage;
     btn_9 : TSpeedButtonImage;
     btn_A : TSpeedButtonImage;
     btn_B : TSpeedButtonImage;
     btn_BackSpace : TSpeedButtonImage;
     btn_C : TSpeedButtonImage;
     btn_D : TSpeedButtonImage;
     btn_dot : TSpeedButtonImage;
     btn_E : TSpeedButtonImage;
     btn_EraseSpace : TSpeedButtonImage;
     btn_Execute : TSpeedButtonImage;
     btn_F : TSpeedButtonImage;
     btn_G : TSpeedButtonImage;
     btn_H : TSpeedButtonImage;
     btn_I : TSpeedButtonImage;
     btn_J : TSpeedButtonImage;
     btn_K : TSpeedButtonImage;
     btn_L : TSpeedButtonImage;
     btn_M : TSpeedButtonImage;
     btn_minus : TSpeedButtonImage;
     btn_N : TSpeedButtonImage;
     btn_O : TSpeedButtonImage;
     btn_P : TSpeedButtonImage;
     btn_plus : TSpeedButtonImage;
     btn_Q : TSpeedButtonImage;
     btn_R : TSpeedButtonImage;
     btn_RB : TSpeedButtonImage;
     btn_S : TSpeedButtonImage;
     btn_Space : TSpeedButtonImage;
     btn_T : TSpeedButtonImage;
     btn_U : TSpeedButtonImage;
     btn_V : TSpeedButtonImage;
     btn_W : TSpeedButtonImage;
     btn_X : TSpeedButtonImage;
     btn_Y : TSpeedButtonImage;
     btn_Z : TSpeedButtonImage;
    Label1: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
//    Mnemonic : string;

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
    vb: TSpeedButtonImage;
begin
  bmp := TBitmap.Create;
  if FileExists(image_path+ 'tdc\key_whiteBox.bmp') then begin
    bmp.LoadFromFile(image_path+ 'tdc\key_whiteBox.bmp');

    for i := 0 to ComponentCount-1 do begin
       if Components[i] is TSpeedButtonImage then begin
         vb := Components[i] as TSpeedButtonImage;
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
    btn: TSpeedButtonImage;
begin
  inherited;

  image_path := ExtractFilePath(Application.ExeName) + 'images\';
  LoadImageList;
  for i := 0 to 25 do begin
    s := 'btn_'+ char(ord('A')+i);
    btn := FindComponent(s) as TSpeedButtonImage;
    btn.Tag := ord('A') + i;
    btn.OnClick := btn_AlphaNumClick;
  end;

  for i := 0 to 9 do begin
    s := 'btn_'+ char(ord('0')+i);
    btn := FindComponent(s) as TSpeedButtonImage;
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

end.
