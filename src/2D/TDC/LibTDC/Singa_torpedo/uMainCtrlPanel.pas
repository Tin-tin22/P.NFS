unit uMainCtrlPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Buttons, SpeedButtonImage, ufQEK, uLibTDCClass;

type
  TvMainCtrlPanel  = class(TfrmQEK)
    GroupBox10: TGroupBox;
    btnFrndl: TSpeedButtonImage;
    btnHostl: TSpeedButtonImage;
    btnUnkn: TSpeedButtonImage;
    btnIniRam: TSpeedButtonImage;
    btnCorr: TSpeedButtonImage;
    btnCloseContr: TSpeedButtonImage;
    btnWhi: TSpeedButtonImage;
    Shape7: TShape;
    btnResetObm: TSpeedButtonImage;
    GroupBox8: TGroupBox;
    Shape6: TShape;
    Label71: TLabel;
    btnAssTrack: TSpeedButtonImage;
    btnSearch: TSpeedButtonImage;
    btnHomng: TSpeedButtonImage;
    btnMan: TSpeedButtonImage;
    btnTorpCours: TSpeedButtonImage;
    btnTorpDepth: TSpeedButtonImage;
    btnEnds: TSpeedButtonImage;
    Bevel17: TBevel;
    Shape4: TShape;
    btnThorpShutDown: TSpeedButtonImage;
    Shape5: TShape;
    Label72: TLabel;
    btnTorpOn: TSpeedButtonImage;
    btnTorpTest: TSpeedButtonImage;
    btnPrePareTube: TSpeedButtonImage;
    btnFire: TSpeedButtonImage;

    grpTorpAssg: TGroupBox;
    btnPort: TSpeedButtonImage;
    btnStd: TSpeedButtonImage;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure TorpedoAssgn(sender : TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnTorpOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrePareTubeClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure UpdateStateGroup(st,grp : Integer);
  public
    torpAssgn : Byte;
    procedure SetLocalVariable(tdc :TGenericTDCInterface); override;

  end;

{var
  vMainCtrlPanel: TvMainCtrlPanel;
}
implementation

//uses uTechnicalCtrlPanel;
uses
  uLibTorpedo_singa, uTechnicalCtrlPanel;

var
  TOCOS : TTorpedoInterface;

{$R *.dfm}
procedure TvMainCtrlPanel.UpdateStateGroup(st, grp: integer);
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

procedure TvMainCtrlPanel.TorpedoAssgn(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    torpAssgn := Tag;    {PORT = 0   STB = 1}
    UpdateStateGroup(1, GroupIndex);
    ImageIndex := 1;
  end;
end;

procedure TvMainCtrlPanel.Timer1Timer(Sender: TObject);
begin
  if (Timer1.Enabled) then
  begin
    if (torpAssgn =0) then
      (TOCOS).vTechnicalCtrlPanel.btnTorpOn1.ImageIndex := 1
    else if (torpAssgn = 1) then
      TOCOS.vTechnicalCtrlPanel.btnTorpOn2.ImageIndex := 1;

    Timer1.Enabled := false;
  end;
end;

procedure TvMainCtrlPanel.btnTorpOnClick(Sender: TObject);
begin
    Timer1.Enabled:= true;
end;

procedure TvMainCtrlPanel.FormCreate(Sender: TObject);
begin
  torpAssgn := 0;
end;

procedure TvMainCtrlPanel.btnPrePareTubeClick(Sender: TObject);
begin
  if (torpAssgn = 0) then
  begin
    TOCOS.vTechnicalCtrlPanel.btnDoorOpen1.ImageIndex := 1;
    TOCOS.vTechnicalCtrlPanel.btn20Bar1.ImageIndex := 0;
    Timer2.Enabled := True;
  end
  else if (torpAssgn =1) then
  begin
    TOCOS.vTechnicalCtrlPanel.btnDoorOpen2.ImageIndex := 1;
    TOCOS.vTechnicalCtrlPanel.btn20Bar2.ImageIndex := 0;
    Timer2.Enabled := True;
  end;
end;

procedure TvMainCtrlPanel.Timer2Timer(Sender: TObject);
begin
  if (Timer2.Enabled) then
  begin
    if (torpAssgn = 0) then
      TOCOS.vTechnicalCtrlPanel.btnRdyToFre1.ImageIndex := 1
    else if (torpAssgn =1) then
      TOCOS.vTechnicalCtrlPanel.btnRdyToFre2.ImageIndex := 1;

    Timer2.Enabled := false;
  end;
end;

procedure TvMainCtrlPanel.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//  inherited;
  TOCOS := tdc  AS TTorpedoInterface;
end;

end.
