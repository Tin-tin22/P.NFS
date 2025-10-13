unit ufQEK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, SpeedButtonImage, uLibTDCClass, uLibWCCKu, ExtCtrls, Math, uLibWCCClassNew,
  Buttons, StdCtrls, {xpPanel, }RzBmpBtn;

type

  TfrmQEK = class(TForm)
    ILSWITCH: TImageList;
    ILGREENROUND: TImageList;
    ILGREENBOX: TImageList;
    ILORANGEROUND: TImageList;
    ILORANGEBOX: TImageList;
    ILREDROUND: TImageList;
    ILREDBOX: TImageList;
    ILBLUEBOX: TImageList;
    Image2: TImage;
    Image3: TImage;
    btnFIRE1: TSpeedButtonImage;
    btnFIRE2: TSpeedButtonImage;
    btnFIRE3: TSpeedButtonImage;
    ILBLUEBOXSMALL: TImageList;
    ILORANGEBOXSMALL: TImageList;
    ILORANGEROUNDSMALL: TImageList;
    ILGREENBOXSMALL: TImageList;
    ILGREENROUNDSMALL: TImageList;
    ILREDROUNDSMALL: TImageList;
    btnBARTPO: TRzBmpButton;
    procedure FormCreate(Sender: TObject);

    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFIRE3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseLeave(Sender: TObject);
  private
    { Private declarations }


    rimLastPos: TPoint;
    rimScale  : single;


    limLastPos: TPoint;
    limScale  : single;

    function SplitName(const s: string; const indx: integer): string;
  protected
    //ConsoleWCC  : TWcc;
    //BtnC        : TBtnCol;
    rimDown   : boolean;
    limDown   : boolean;
    IsDoingSplashCorrection: boolean;

    procedure LoadImageFile(fName: string; imgL: TImageList);
    procedure UpdateSpeedBtn;


    procedure SetSpeedButtonGlyphNumber(const b: byte);
    function TestHitView(const x, y: integer; FArea : Trect): boolean;

   public
    { Public declarations }
    image_path : string;
    WCCInterface : TGenericWCCInterface;

    procedure LoadImageList; virtual;
    procedure SetLocalVariable(tdc :TGenericTDCInterface); virtual;
    procedure SetOffBtnAndIndikator; Virtual;
    procedure SetlabelColor(cl: TColor); Virtual;

 end;

//var
//  frmQEK: TfrmQEK;

implementation

{$R *.dfm}

{ TfrmQEK }
const IMAGES_PATH='../data/images/';

procedure freebmp(var bmp:TBitmap);
begin
  bmp.Dormant;
  bmp.FreeImage;
  bmp.ReleaseHandle;
end;

function TfrmQEK.SplitName(const s: string; const indx: integer): string;
begin
  result := Copy(s, indx, Length(s)-1);
end;

function TfrmQEK.TestHitView(const x, y: integer; FArea: Trect): boolean;
var pt : TPoint;
begin
  pt.X := x;
  pt.Y := y;
  result := ptInRect(FArea, pt);
end;

procedure TfrmQEK.UpdateSpeedBtn;
var i: integer;
  bmp: TBitmap;
  nm: string;
begin
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TSpeedButtonImage then begin
      //(Components[i] as TSpeedButtonImage).ImageIndex := 0;

      nm := LowerCase(SplitName((Components[i] as TSpeedButtonImage).ImageList.Name, 3));

      if nm = 'greenbox'    then bmp := BtnC.greenBOX_Off;
      if nm = 'greenround'  then bmp := BtnC.greenROUND_Off;
      if nm = 'orangebox'   then bmp := BtnC.orangeBOX_Off;
      if nm = 'orangeround' then bmp := BtnC.orangeROUND_Off;
      if nm = 'bluebox'     then bmp := BtnC.blueBOX_Off;

      if nm = 'greenboxsmall'    then bmp := BtnC.sgreenBOX_Off;
      if nm = 'greenroundsmall'  then bmp := BtnC.sgreenROUND_Off;
      if nm = 'orangeboxsmall'   then bmp := BtnC.sorangeBOX_Off;
      if nm = 'orangeroundsmall' then bmp := BtnC.sorangeROUND_Off;
      if nm = 'blueboxsmall'     then bmp := BtnC.sblueBOX_Off;

      if nm = 'redbox'      then bmp := BtnC.redBOX_Off;
      if nm = 'redround'    then bmp := BtnC.redROUND_Off;
      if nm = 'switch'      then bmp := BtnC.switch_Off;

     // if nm = 'switch' then
     //   (Components[i] as TSpeedButtonImage).ImageIndex := 1
     // else if nm <> '' then
        BtnC.UpdateBtnImage((Components[i] as TSpeedButtonImage), bmp);
    end;

    if (Components[I] is TRzBmpButton) then
       with (Components[I] as TRzBmpButton).Bitmaps do begin
          Down.Assign(BtnC.switch_On);
          StayDown.Assign(BtnC.switch_On);
          Up.Assign(BtnC.switch_Off);
          UpAndFocused.Assign(BtnC.switch_Off);
       end;

  end;

end;

procedure TfrmQEK.LoadImageList;
begin
  //LoadImageFile(image_path+'wcc\switch_fusion.bmp', ILSWITCH);
  {LoadImageFile(image_path+'wcc\greenBOX.bmp', ILGREENBOX );
  LoadImageFile(image_path+'wcc\greenROUND.bmp', ILGREENROUND );
  LoadImageFile(image_path+'wcc\orangeBOX.bmp', ILORANGEBOX );
  LoadImageFile(image_path+'wcc\orangeROUND.bmp', ILORANGEROUND );
  LoadImageFile(image_path+'wcc\redBOX.bmp', ILREDBOX );
  LoadImageFile(image_path+'wcc\redROUND.bmp', ILREDROUND );
  LoadImageFile(image_path+'wcc\blueBOX.bmp', ILBLUEBOX );}
end;

procedure TfrmQEK.LoadImageFile(fName: string; imgL: TImageList);
var bmp :TBitmap;
begin
  if not FileExists(fName) then exit;

  bmp:=TBitmap.Create;
  bmp.LoadFromFile(fName);

  imgL.Add(bmp,nil);

  freebmp(bmp);
  bmp.free;
end;

procedure TfrmQEK.SetlabelColor(cl: TColor);
var i : Integer;
begin
 for i := 0 to ComponentCount-1 do begin
    if (Components[i] is TLabel) and ((Components[i] as TLabel).Tag = 0) then begin
        (Components[i] as TLabel).Font.Color := cl;
    end;
     if (Components[i] is TPanel)  then begin
        (Components[i] as TPanel).Font.Color := cl;
    end;
//     if (Components[i] is TSpeedButtonImage)  then begin
//        (Components[i] as TSpeedButtonImage).Font.Color := cl;
//    end;
 end;

end;

procedure TfrmQEK.SetLocalVariable(tdc: TGenericTDCInterface);
begin
//
end;


procedure TfrmQEK.SetOffBtnAndIndikator;
var i, tg: integer;
  bmp: TBitmap;
  nm, s : string;
begin
 for i := 0 to ComponentCount-1 do begin
    if (Components[i] is TSpeedButtonImage)  then begin
      //(Components[i] as TSpeedButtonImage).ImageIndex := 0;
      s := (Components[i] as TSpeedButtonImage).ImageList.Name;
      nm := LowerCase(copy(s, 3, Length(s)-1));

      if nm = 'greenbox'    then bmp := BtnC.greenBOX_Off;
      if nm = 'orangebox'   then bmp := BtnC.orangeBOX_Off;
      if nm = 'bluebox'     then bmp := BtnC.blueBOX_Off;

      if nm = 'greenboxsmall'    then bmp := BtnC.sgreenBOX_Off;
      if nm = 'orangeboxsmall'   then bmp := BtnC.sorangeBOX_Off;
      if nm = 'blueboxsmall'     then bmp := BtnC.sblueBOX_Off;

      if nm = 'redbox'      then bmp := BtnC.redBOX_Off;

      if (Components[i] is TSpeedButtonImage) then
        BtnC.UpdateBtnImage((Components[i] as TSpeedButtonImage), bmp);
    end;

    if (Components[i] is TImage) then begin

       if (Components[i] as TImage).Tag = 1001 then bmp := BtnC.greenROUND_Off;
       if (Components[i] as TImage).Tag = 1002 then bmp := BtnC.orangeROUND_Off;
       if (Components[i] as TImage).Tag = 1003 then bmp := BtnC.redROUND_Off;

       if (Components[i] as TImage).Tag = 1004 then bmp := BtnC.sgreenROUND_Off;
       if (Components[i] as TImage).Tag = 1005 then bmp := BtnC.sorangeROUND_Off;

       if (Components[i] is TImage) and ((Components[i] as TImage).Tag >=1001) and ((Components[i] as TImage).Tag <=1005) then
          BtnC.UpdateImage((Components[i] as TImage), bmp);
    end;
  end;


end;

procedure TfrmQEK.FormCreate(Sender: TObject);
begin
  image_path := ExtractFilePath(Application.ExeName) + IMAGES_PATH;
  LoadImageList;

  ConsoleWCC := TWcc.Create;
  BtnC := TBtnCol.Create;
  BtnC.BuatBitmap;

  UpdateSpeedBtn;
  SetlabelColor(clBlack);
end;

procedure TfrmQEK.Image3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  rimDown   := true;
  rimLastPos.X:= X;
  rimLastPos.Y:= Y;
  if IsDoingSplashCorrection then begin
    WCCInterface.ActiveGUN.PosBeforeCorr.X  := WCCInterface.GetBScopeMarkerPosX;
    WCCInterface.ActiveGUN.PosBeforeCorr.Y  := WCCInterface.GetBScopeMarkerPosY;
  end;
end;

procedure TfrmQEK.Image3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var ix, iy : integer;
RollBallArea : Trect;
begin
  if rimDown then begin
    RollBallArea := Rect(Point(0,0), Point(Image3.height ,Image3.width));
    if not TestHitView(X, Y, RollBallArea) then Exit;
    ix := X - rimLastPos.X;
    iy := Y - rimLastPos.Y;
    if IsDoingSplashCorrection then
      WCCInterface.SetBScopeMarkerPos(
      WCCInterface.GetBScopeMarkerPosX + (ix * rimScale),
      WCCInterface.GetBScopeMarkerPosY - (iy * rimScale))
    else
      WCCInterface.OBMRight_SetPosition(
      WCCInterface.OBMRight.Center.X + Floor(ix * rimScale),
      WCCInterface.OBMRight.Center.Y + Floor(iy * rimScale));

    rimLastPos.X := X;
    rimLastPos.Y := Y;
  end
  else

  if IsDoingSplashCorrection then
    rimScale := 0.005
  else
    rimScale  := 1.0;
end;

procedure TfrmQEK.Image3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  rimDown   := false;
  if not Assigned (WCCInterface.ActiveGUN) then Exit;

  if IsDoingSplashCorrection then begin
    WCCInterface.ActiveGUN.PosAfterCorr.X  := WCCInterface.GetBScopeMarkerPosX;
    WCCInterface.ActiveGUN.PosAfterCorr.Y  := WCCInterface.GetBScopeMarkerPosY;
  end;
end;

procedure TfrmQEK.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  limDown   := true;
  limLastPos.X:= X;
  limLastPos.Y:= Y;
end;

procedure TfrmQEK.Image2MouseLeave(Sender: TObject);
begin
limDown   := false;
end;

procedure TfrmQEK.Image2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var ix, iy : integer;
RollBallArea : Trect;
begin
  if limDown then begin
    RollBallArea := Rect(Point(0,0), Point(Image2.height ,Image2.width));
    if not TestHitView(X, Y, RollBallArea) then Exit;

    ix := X - limLastPos.X;
    iy := Y - limLastPos.Y;
    WCCInterface.OBMleft_SetPosition(
        WCCInterface.OBMLeft.Center.X + Floor(ix * limScale),
        WCCInterface.OBMLeft.Center.Y + Floor(iy * limScale));

    limLastPos.X := X;
    limLastPos.Y := Y;
  end;
  limScale  := 1.0;
end;

procedure TfrmQEK.Image2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  limDown   := false;
end;

procedure TfrmQEK.SetSpeedButtonGlyphNumber(const b: byte);
var i: integer;
begin
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonImage then
     (Components[i] as TSpeedButtonImage).NumGlyphs := b;
end;

procedure TfrmQEK.btnFIRE1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun1.ReadyToFire then
      WCCInterface.Gun1Pressed := true;
end;

procedure TfrmQEK.btnFIRE1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun1.ReadyToFire then
      WCCInterface.Gun1Pressed := false;
end;

procedure TfrmQEK.btnFIRE2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun2.ReadyToFire then
      WCCInterface.Gun2Pressed := true;
end;

procedure TfrmQEK.btnFIRE2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun2.ReadyToFire then
      WCCInterface.Gun2Pressed := false;
end;

procedure TfrmQEK.btnFIRE3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun3.ReadyToFire then
      WCCInterface.Gun3Pressed := true;
end;

procedure TfrmQEK.btnFIRE3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ConsoleWCC.PowerON and ConsoleWCC.SystemON and
    WCCInterface.Gun3.ReadyToFire then
      WCCInterface.Gun3Pressed := false;
end;

end.
