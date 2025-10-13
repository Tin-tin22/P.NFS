unit ufOwa_1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, Buttons, SpeedButtonImage, ExtCtrls, ImgList, StdCtrls;

type
  TfrmOwa_1 = class(TfrmQEK)
    Panel1: TPanel;
    SpeedButtonImage19: TSpeedButtonImage;
    SpeedButtonImage1: TSpeedButtonImage;
    btnCeaseEngage: TSpeedButtonImage;
    btnEngage: TSpeedButtonImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButtonImage4: TSpeedButtonImage;
    SpeedButtonImage5: TSpeedButtonImage;
    SpeedButtonImage6: TSpeedButtonImage;
    SpeedButtonImage7: TSpeedButtonImage;
    Label4: TLabel;
    Label5: TLabel;
    btnTREngage: TSpeedButtonImage;
    SpeedButtonImage9: TSpeedButtonImage;
    SpeedButtonImage10: TSpeedButtonImage;
    SpeedButtonImage11: TSpeedButtonImage;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButtonImage12: TSpeedButtonImage;
    SpeedButtonImage13: TSpeedButtonImage;
    SpeedButtonImage14: TSpeedButtonImage;
    SpeedButtonImage15: TSpeedButtonImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure btnTREngageClick(Sender: TObject);
    procedure btnCeaseEngageClick(Sender: TObject);
    procedure btnEngageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  frmOwa_1: TfrmOwa_1;
 }
implementation

uses uTDCConstan;

{$R *.dfm}

procedure TfrmOwa_1.btnTREngageClick(Sender: TObject);
begin
  TDCInterface.SetEngagementBox(teTrialReview);
end;

procedure TfrmOwa_1.btnCeaseEngageClick(Sender: TObject);
begin
  TDCInterface.SetEngagementBox(teCeaseEngage);
end;

procedure TfrmOwa_1.btnEngageClick(Sender: TObject);
begin
  TDCInterface.SetEngagementBox(teEngage);
end;

end.
