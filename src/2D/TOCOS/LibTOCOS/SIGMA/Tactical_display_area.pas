unit Tactical_display_area;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VrControls, VrButtons, Menus, VrDesign,
  ComCtrls, ToolWin, uMapWindow, MapXLib_TLB, uLibTDCClass, OleCtrls;

type

  TFrmTactical_display_area = class(TfrmMapWindow)
    MainMenu1: TMainMenu;
    View1: TMenuItem;
    Area1: TMenuItem;
    Preferences1: TMenuItem;
    New1: TMenuItem;
    Quit1: TMenuItem;
    FitWindowtoRange1: TMenuItem;
    Gridsize1: TMenuItem;
    Fine1: TMenuItem;
    Normal1: TMenuItem;
    Coarse1: TMenuItem;
    Filters1: TMenuItem;
    Display1: TMenuItem;
    Figures1: TMenuItem;
    Labels1: TMenuItem;
    racks1: TMenuItem;
    acticos1: TMenuItem;
    ICM1: TMenuItem;
    RAMtrackseq1: TMenuItem;
    SGOdefinition1: TMenuItem;
    DAReposition1: TMenuItem;
    Map1: TMenuItem;
    RTFSelections1: TMenuItem;
    EcisMapSettings1: TMenuItem;
    EcisGeneralSettings1: TMenuItem;
    EcisObjectInfo1: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;
  end;

{var
  FrmTactical_display_area: TFrmTactical_display_area;}

  implementation

{$R *.dfm}
const
  IMAGES_PATH='images/sigma/';

procedure freebmp(var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

procedure TFrmTactical_display_area.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
  inherited;

  bmp:=TBitmap.Create;

  bmp.LoadFromFile(IMAGES_PATH+'1.bmp');
  VrBitmapButton1.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'2.bmp');
  VrBitmapButton2.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'3.bmp');
  VrBitmapButton3.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'4.bmp');
  VrBitmapButton4.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'5.bmp');
  VrBitmapButton5.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'6.bmp');
  VrBitmapButton6.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'7.bmp');
  VrBitmapButton7.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'8.bmp');
  VrBitmapButton8.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'9.bmp');
  VrBitmapButton9.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'10.bmp');
  VrBitmapButton10.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'11.bmp');
  VrBitmapButton11.Glyph:=bmp;
  freebmp(bmp);

  bmp.LoadFromFile(IMAGES_PATH+'12.bmp');
  VrBitmapButton12.Glyph:=bmp;
  freebmp(bmp);


  bmp.Free;
end;

end.
