unit uDisplayCtrlPanelLeft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, VrControls, VrButtons, ExtCtrls, Buttons,
  SpeedButtonImage, StdCtrls, VrRotarySwitch, ufQEK, uLibTDCClass;

type
  TvDisplayCtrlPanelLeft = class(TfrmQEK)
    GroupBox4: TGroupBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    VrRotarySwitch1: TVrRotarySwitch;
    VrRotarySwitch2: TVrRotarySwitch;
//    ILGREENBOX: TImageList;
    ILORANGEROUND: TImageList;
    GroupBox6: TGroupBox;
    Label87: TLabel;
    btnIFF: TSpeedButtonImage;
    btnRR: TSpeedButtonImage;
    btnHM: TSpeedButtonImage;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel21: TBevel;
    GroupBox9: TGroupBox;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
    VrDemoButton4: TVrDemoButton;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    VrDemoButton13: TVrDemoButton;
    VrDemoButton9: TVrDemoButton;
    VrDemoButton8: TVrDemoButton;
    VrDemoButton7: TVrDemoButton;
    VrDemoButton10: TVrDemoButton;
    VrDemoButton11: TVrDemoButton;
    VrDemoButton12: TVrDemoButton;
    VrDemoButton14: TVrDemoButton;
    VrDemoButton17: TVrDemoButton;
    VrDemoButton16: TVrDemoButton;
    VrDemoButton18: TVrDemoButton;
    vrIFF: TVrRotarySwitch;
    vrVideo: TVrRotarySwitch;
    vrMixed: TVrRotarySwitch;
    grpVidSel: TGroupBox;
    btnMtiNotAvl: TSpeedButtonImage;
    btnOff: TSpeedButtonImage;
    btnWmNonMti: TSpeedButtonImage;
    btnWmMti: TSpeedButtonImage;
    procedure VideoSelection(sender : TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateStateGroup(st,grp : Integer);
  public
    { Public declarations }
     procedure SetLocalVariable(tdc :TGenericTDCInterface); override;
  end;

{var
  vDisplayCtrlPanelLeft: TvDisplayCtrlPanelLeft;
}
implementation

uses
  uLibTorpedo_singa;

var
  TOCOS : TTorpedoInterface;


{$R *.dfm}

procedure TvDisplayCtrlPanelLeft.SetLocalVariable(tdc :TGenericTDCInterface);
begin
  TOCOS := tdc  AS TTorpedoInterface;
end;

procedure TvDisplayCtrlPanelLeft.UpdateStateGroup(st, grp: integer);
var
  i: Integer;
  s: string;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    if Components[i].ClassType = TSpeedButtonImage then
    begin
      s := Components[i].Name;
      with TSpeedButtonImage(FindComponent(s)) do
      begin
        case st of
          0:
            begin
              ImageIndex := 0;
              Down := false;
            end;
          1:
            begin
              if GroupIndex = grp then
              begin
                ImageIndex := 0;
                Down := false;
              end;
            end;
        end;
      end;
    end;
  end;
end;

procedure TvDisplayCtrlPanelLeft.VideoSelection(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    UpdateStateGroup(1, GroupIndex);
    ImageIndex := 1;
  end;
end;

procedure TvDisplayCtrlPanelLeft.FormCreate(Sender: TObject);
begin
//  inherited;

end;

end.
