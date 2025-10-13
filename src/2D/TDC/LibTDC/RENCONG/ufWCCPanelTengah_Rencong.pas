unit ufWCCPanelTengah_Rencong;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, VrControls, VrBlinkLed;

type
  TfrmWCCPanelTengah_Rencong = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    VrBlinkLed3: TVrBlinkLed;
    VrBlinkLed1: TVrBlinkLed;
    GroupBox2: TGroupBox;
    Shape2: TShape;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    GroupBox3: TGroupBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWCCPanelTengah_Rencong: TfrmWCCPanelTengah_Rencong;

implementation

{$R *.dfm}
const IMAGES_PATH='images/';

procedure freebmp(var bmp:TBitmap);
begin
bmp.Dormant;
bmp.FreeImage;
bmp.ReleaseHandle;
end;


procedure TfrmWCCPanelTengah_Rencong.FormCreate(Sender: TObject);
var bmp :TBitmap;
begin
bmp:=TBitmap.Create;

Image1.Picture.LoadFromFile(IMAGES_PATH+'display_2.bmp');

bmp.Free;
end;

end.
