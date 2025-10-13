unit ufBScope;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uBScopeBaseDisplay,
  uBaseConstan, StdCtrls, ExtCtrls, uLibWCCku,
  uLibWCCClassNew, ufQEK;

type
  TfrmBScope = class(TfrmQEK)
    pnl1: TPanel;
    mPanel: TPanel;
    lmpFC2: TImage;
    lmpFC3: TImage;
    tmrblinkPHP: TTimer;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lmpimg1: TImage;
    lbl15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure mPanelResize(Sender: TObject);
    procedure tmrblinkPHPTimer(Sender: TObject);
  protected
    Counter: integer;

  private
    { Private declarations }
    FMarkerVisible           : boolean;
    procedure SetMarkerVisible(const Value: boolean);

  public
    { Public declarations }
    ScopeView : TBScopeBaseDisplay;
    blinkPHP : Boolean;
    property ShowMarker : boolean read FMarkerVisible write SetMarkerVisible;

    procedure SetMarkerPosition(const x,y: double);
    procedure ShowItem(const FCID: byte; const aMark: TBSMark);
    procedure LightTheLight(const FCID: byte; const aMark: TBSMark);
    procedure ShowSplashPoint(const x,y: double; const GunID: byte; const shown: boolean);
    procedure HideSplashPoint(const FCID: byte);
    procedure ClearAllItem;
    function ApplyCorrection(TheGun: TGun): boolean;
  end;

implementation

uses
  uTDCCOnstan;
{$R *.dfm}

procedure TfrmBScope.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;

  ScopeView := TBScopeBaseDisplay.Create(Self.mPanel);
  ScopeView.Parent := Self.mPanel;
  ScopeView.Left := 0;
  ScopeView.Top := 0;
  ScopeView.Width := self.mPanel.Width;
  ScopeView.Height := self.mPanel.Height;

  ScopeView.SetMapBoundary(0,1,1,0);
  ScopeView.BackgroundColor := clblack;//  RGB(225, 150, 0);
  ScopeView.LineColor :=  RGB(00,60,00);
  ScopeView.MarkerColor := clWhite; // ClBlack
  ScopeView.Visible := True;
  ScopeView.TransparentBackground := false;
  ScopeView.MarkerShown := False;

  ScopeView.MarkerHeight := 10;
  ScopeView.MarkerWidth := 10;

  self.Left := screen.WorkAreaWidth - self.Width;
  self.Top := 0;

  Counter := 0;
  blinkPHP := False;
//  ScopeView.IsBlinking:= false;
  ScopeView.IsBlinking:= True;
end;

procedure TfrmBScope.HideSplashPoint(const FCID: byte);
var ID : string;
i : Integer;
begin
  for i:=1 to 3 do begin
    ID := 'splash' + IntToStr(i);
    ScopeView.HideItem(ID);
  end;
end;

procedure TfrmBScope.SetMarkerPosition(const x,y: double);
begin
  ScopeView.MarkerPositionX := x;
  ScopeView.MarkerPositionY := y;
  mPanel.Repaint;

  //self.Caption := FloatToStr(x) + ', ' + FloatToStr(y);
end;

procedure TfrmBScope.SetMarkerVisible(const Value: boolean);
begin
  FMarkerVisible := Value;
  ScopeView.MarkerShown := Value;
  mPanel.Repaint;
end;

procedure TfrmBScope.ShowItem(const FCID: byte; const aMark: TBSMark);
var fName : String;
begin
  self.LightTheLight(FCID, aMark);
  case aMark of
    tbmDefault: fName := C_IMAGES_PATH + 'default.bmp';
    tbmShip   : fName := C_IMAGES_PATH + 'shipTest.bmp';
    tbmIsland : fName := C_IMAGES_PATH + 'island.bmp';
  end;
  ScopeView.AddItem('echo',0.5,0.5,fName,clGray);
  mPanel.Repaint;
end;

procedure TfrmBScope.ShowSplashPoint(const x, y: double; const GunID: byte; const shown: boolean);
var fName, ID : String;
  posx, posy: double;
begin
  if shown then fName := C_IMAGES_PATH + 'splashTest.bmp'
  else fName := '';

  ID := 'splash' + IntToStr(GunID);
  ScopeView.AddItem(ID, x, y, fName, clGray);
  mPanel.Repaint;
end;

procedure TfrmBScope.ClearAllItem;
begin
  ScopeView.ClearItems;
end;

procedure TfrmBScope.tmrblinkPHPTimer(Sender: TObject);
begin
  inherited;
  blinkPHP:= not blinkPHP;

  if blinkPHP then
    ScopeView.MarkerColor:= clWhite
  else
    ScopeView.MarkerColor:= clBlack;
end;

procedure TfrmBScope.LightTheLight(const FCID: byte; const aMark: TBSMark);
begin
  BtnC.UpdateImage(lmpFC2, BtnC.redROUND_Off);
  BtnC.UpdateImage(lmpFC3, BtnC.redROUND_Off);

  if aMark = tbmDefault then
    case FCID of
      2: BtnC.UpdateImage(lmpFC2, BtnC.orangeROUND_On);
      3: BtnC.UpdateImage(lmpFC3, BtnC.orangeROUND_On);
    end;
end;

procedure TfrmBScope.mPanelResize(Sender: TObject);
begin
//  ScopeView.Refresh;
end;

function TfrmBScope.ApplyCorrection(TheGun: TGun): boolean;
var ID: string;
begin
  case TheGun.ID of
    1: ID := 'splash1';
    2: ID := 'splash2';
    3: ID := 'splash3';
  end;
  TheGun.Corrected := ScopeView.TestHit(ID);

end;

{ procedure buat blinking
var x,y : Integer;
begin

  lbl1.Caption:= IntToStr(i);
  for x:= 1 to bmpAsli.Width do
  for y:=1 to bmpAsli.Height do
  begin
    img1.Canvas.Pixels[x,y] := img1.Canvas.Pixels[x,y] - RGB(i,i,i);
    if i=0 then begin
     img1.Picture.Assign(bmpAsli);
     i:=15;
    end;

  end;
  Paint;
  i:=i-1;
end;
}

end.





