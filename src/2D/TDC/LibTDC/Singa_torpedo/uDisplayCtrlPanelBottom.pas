unit uDisplayCtrlPanelBottom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, VrControls, VrRotarySwitch, ExtCtrls, Buttons,
  SpeedButtonImage, StdCtrls,ufQEK, uLibTDCClass;

type
  TvDisplayCtrlPanelBottom = class(TfrmQEK)
    GroupBox7: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    btnBlueLabel: TSpeedButtonImage;
    btnMS: TSpeedButtonImage;
    btnLine: TSpeedButtonImage;
    btnAmplInfo: TSpeedButtonImage;
    btnTN: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOffCent: TSpeedButtonImage;
    btnSurf2: TSpeedButtonImage;
    btnHorScan: TSpeedButtonImage;
    Label52: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    vrCompass: TVrRotarySwitch;
    vrVideo2: TVrRotarySwitch;
    vrRR: TVrRotarySwitch;
    vrSynth: TVrRotarySwitch;
    vrCursor: TVrRotarySwitch;
    vrHM: TVrRotarySwitch;
//    ILBLUEBOX: TImageList;
//    ILGREENBOX: TImageList;
//    ILORANGEBOX: TImageList;
    grpRangeSel: TGroupBox;
    btnRange2: TSpeedButtonImage;
    btnRange4: TSpeedButtonImage;
    btnRange8: TSpeedButtonImage;
    btnRange16: TSpeedButtonImage;
    btnRange32: TSpeedButtonImage;
    btnRange64: TSpeedButtonImage;
    btnBlueRange: TSpeedButtonImage;
    GroupBox2: TGroupBox;
    btnSurf: TSpeedButtonImage;
    btnSubSurf: TSpeedButtonImage;
    btnBlueDisp1: TSpeedButtonImage;
    btnBlueDisp2: TSpeedButtonImage;
    btnLpdTes: TSpeedButtonImage;
    procedure RangeSelection(sender : TObject);
    procedure DisplaySelection(sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSurfClick(Sender: TObject);
  private
    procedure UpdateStateGroup(st,grp : Integer);
  public
    rangeSel : Byte;
     procedure SetLocalVariable(tdc :TGenericTDCInterface); override;

  end;

{var
  vDisplayCtrlPanelBottom: TvDisplayCtrlPanelBottom;}

implementation
{$R *.dfm}

uses
  uLibTorpedo_singa;

var
  TOCOS : TTorpedoInterface;

procedure TvDisplayCtrlPanelBottom.UpdateStateGroup(st, grp: integer);
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

procedure TvDisplayCtrlPanelBottom.RangeSelection(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    rangeSel := Tag;
    UpdateStateGroup(1, GroupIndex);
    ImageIndex := 1;
  end;
  tocos.SetView_RangeScale(rangeSel);
end;

procedure TvDisplayCtrlPanelBottom.DisplaySelection(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    UpdateStateGroup(1, GroupIndex);
    ImageIndex := 1;
  end;
end;

procedure TvDisplayCtrlPanelBottom.SetLocalVariable(
  tdc: TGenericTDCInterface);
begin
  TOCOS := tdc  AS TTorpedoInterface;
end;

procedure TvDisplayCtrlPanelBottom.FormCreate(Sender: TObject);
begin
//  inherited;

end;

procedure TvDisplayCtrlPanelBottom.btnSurfClick(Sender: TObject);
begin
  //inherited;

//  tocos.Filter(tdAtasAir, btnSurf.Down)
end;

end.
