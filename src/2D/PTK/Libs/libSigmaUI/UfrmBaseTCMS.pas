unit UfrmBaseTCMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTCMSService, uServiceDefinition, ExtCtrls, VrControls, uLibEvent,
  VrDesign, VrLcd, VrSpinner;

const
  C_MINI_WIDTH = 60;
  C_MINI_HEIGHT = 80;

type

  TfrmBaseTCMS = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    color_window : Integer;
    color_background : Integer;
  protected

    FService : TTCMS_Service;
    FServicePos: TRecServicePosition;
    FServiceIndex: Integer;

    LastTop, LastLeft, LastWidth, lastHeight, LatestTop, LatestLeft :Integer;
    LastTopIcon,LastLeftIcon, LastHeightIcon, LastWidthIcon : Integer;
    TopAwal, LeftAwal : Integer;
    IsFromMini : Boolean;
    clicked    : Boolean;
    FLeftOffset, FTopOffset : Integer;

    FFirstShow : Boolean;
    FFirstClick: Boolean;

  protected
    procedure DragPanel(Button : TMouseButton);
    procedure SetTCMSColors;
    procedure btnMiniClick(Sender: TObject); virtual;

    procedure imgDblClick(Sender: TObject);

    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  public
    { Public declarations }

    { For event in MainForm For Each Service }
    OnMainFormEvent : TOnMainFormEvent;
    isHaveOpened : Boolean;
  public
    procedure SetServicePosition(const aPos: TRecServicePosition);virtual;
    procedure SetServiceIndex(const aPrimOrSec : Byte);

    procedure OnServiceUpdate(sender: TObject); virtual;

    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
     procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;

  public
     property ServicePos: TRecServicePosition read FServicePos;
     property ServiceIndex : INteger read FServiceIndex write FServiceIndex;
  end;

implementation

uses
  StdCtrls, ComCtrls, Grids, VrButtons, uTCMSColors, uLibSettings;

{$R *.dfm}

procedure TfrmBaseTCMS.btnMiniClick(Sender: TObject);
begin
//  if Assigned(OnMainFormEvent) then
//    OnMainFormEvent(true);

end;

procedure TfrmBaseTCMS.DragPanel(Button: TMouseButton);
const

  SC_DragMove = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DragMove, 0);
  end;

  LastTopIcon := Top;
  LastLeftIcon:= Left;

end;

procedure TfrmBaseTCMS.FormActivate(Sender: TObject);
begin
  LatestTop := Top;
  LatestLeft:= Left - Screen.Monitors[FServiceIndex].WorkareaRect.Left;
end;

procedure TfrmBaseTCMS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(OnMainFormEvent) then
    OnMainFormEvent(False);
  //
end;

procedure TfrmBaseTCMS.FormCreate(Sender: TObject);
begin
//  if Sender is TTCMS_Service then
//    FService := Sender  as TTCMS_Service;

  case VThemeSetting.ColorNum of
    1 : begin
      color_window := CL_TCMS_Window;
      color_background := CL_TCMS_WindowBackGround;
    end;
    2 :
    begin
      color_window := CL_CMS_Window;
      color_background := CL_CMS_WindowBackGround;
    end;
  end;

  SetTCMSColors;

//  BorderStyle := bsSingle;

  { For event in MainForm For Each Service }
  isHaveOpened := false;
//  FServiceIndex := VMonitSetting.Primary;
//  DragKind := dkDock;

  FFirstShow  := True;
  FFirstClick := True;

  SetServiceIndex(0);
end;

procedure TfrmBaseTCMS.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmBaseTCMS.imgDblClick(Sender: TObject);
begin
  if Assigned(OnMainFormEvent) then
    OnMainFormEvent(True);
end;

procedure TfrmBaseTCMS.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DragPanel(Button);
end;

procedure TfrmBaseTCMS.OnServiceUpdate(sender: TObject);
begin
  FService := sender as TTCMS_Service;
end;

procedure TfrmBaseTCMS.SetTCMSColors;
var i: integer;
  c: TComponent;
begin
  Font.Name := 'Arial';
  Font.Size := 9;

  Color := color_window;

  for i := 0 to ComponentCount - 1 do  begin
    c := Components[i];
    if c is TPanel then
      with c as TPanel do begin
      Color           := color_window;
      BevelOuter      := bvLowered;
      BevelInner      := bvRaised;
      BevelKind       := bkNone;
    end
    else if c is TRadioButton then
      with c as TRadioButton do begin
        Color           := color_window;
      end
    else if c is TEdit then
      with c as TEdit do begin
        Color           := color_background;
        BevelInner      := bvNone;
        BevelKind       := bkSoft;
        BorderStyle     := bsNone;
    end
    else if c is TMemo then
      with c as TMemo do begin
        Color           := color_background;
    end
    else if c is TVrSpinner then
      with c as TVrSpinner do begin
        Color           := color_window;
        Palette.High    := color_window;
    end
    else if c is TLabel then
      with c as TLabel do begin
        if Color = clMedGray then
          Color           := color_window
        else if Color = CL_TCMS_Red then
          Color           := CL_TCMS_Red
        else if Color = CL_TCMS_Green then
          Color           := CL_TCMS_Green
        else if Color = $000080FF then
          Color           := CL_TCMS_Orange
        else
          Color           := color_window;
    end
    else if c is TDateTimePicker then
      with c as TDateTimePicker do
      begin
        Color           := color_background;
      end
    else if c is TStringGrid then
      with c as TStringGrid do begin
        Color           := color_background;
    end
    else if c is TUpDown  then
      with c as TUpDown do begin
        Color           := color_background;
    end
    else if c is TDateTimePicker  then
      with c as TDateTimePicker do begin
        Color           := color_background;
    end

    else if c is TScrollBox then
      with c as TScrollBox do begin
       Color           := color_window;

    end
    else if c is TGroupBox then
      with c as TGroupBox do begin
        Color           := color_window;

    end
    else if c is TListBox then
    with c as TListBox do begin
        Color           := color_background;
    end
    else if c is TListView then
    with c as TListView do begin
        Color           := color_background;
    end
    else if c is TComboBox then
      with c as TComboBox do begin
        Color           := color_window;
       Style            := csOwnerDrawFixed;
    end
    else if c is  TVrDemoButton then begin
      with c as  TVrDemoButton do begin
        OutLineWidth    := 0;
        HighlightColor  := CL_TCMS_HighLight;
        ShadowColor     := CL_TCMS_Shadow;
        Color           := color_window;
       end;
    end
    else if c is  TVrBitmapButton then begin
      with c as  TVrBitmapButton do begin
        Color           := color_window;
       end;
    end
    else if c is  TVrBitmapRadioButton then begin
      with c as  TVrBitmapRadioButton do begin
        Color           := color_window;
        FocusColor      := color_window;
        TransparentColor:= color_window;

       end;
    end
    else if c is TToolBar then
      with c as TToolBar do begin
         Color          := color_window;
      end
    else if c is TVrClock then
      with c as TVrClock do begin
         Color          := color_window;
      end
    else if c is TVrPowerButton then
      with c as TVrPowerButton do begin
        Color           := color_window;
        OutlineWidth    := 0;
        HighlightColor  := CL_TCMS_HighLight;
        ShadowColor     := CL_TCMS_Shadow;
        Palette.High    := CL_GreenLamp;
        Palette.Low     := color_window;
      end
  end;
end;

procedure TfrmBaseTCMS.WMExitSizeMove(var Message: TMessage);
begin
  LatestTop := Top;
  LatestLeft:= Left - Screen.Monitors[FServiceIndex].WorkareaRect.Left;

  LastLeft := LatestLeft;
  LastTop  := LatestTop;
end;

procedure TfrmBaseTCMS.WMMoving(var Msg: TWMMoving);
var
  monNum : Integer;
  workArea: TRect;
begin

   workArea := Screen.Monitors[FServiceIndex].WorkareaRect;

   with Msg.DragRect^ do
   begin
     if Left < workArea.Left then
       OffsetRect(Msg.DragRect^, workArea.Left - Left, 0) ;

     if Top < workArea.Top then
       OffsetRect(Msg.DragRect^, 0, workArea.Top - Top) ;

     if Right > workArea.Right then
       OffsetRect(Msg.DragRect^, workArea.Right - Right, 0) ;

     if Bottom > workArea.Bottom then
       OffsetRect(Msg.DragRect^, 0, workArea.Bottom - Bottom) ;
   end;

   inherited;
end;

procedure TfrmBaseTCMS.SetServiceIndex(const aPrimOrSec : Byte);
begin
  //VMonitSetting.Primary
  case VMonitSetting.Primary of
    0 : FServiceIndex := aPrimOrSec;
    1 :
    begin
      case aPrimOrSec of
        C_SVCMonitor_Primary :
        begin
          FServiceIndex := 1;
        end;
        C_SVCMonitor_Secondary:
        begin
          FServiceIndex := 0;
        end;
      end;
    end;
    2 : FServiceIndex := 1;
    else
    begin
      FServiceIndex := 0;
    end;
  end;

  if (Screen.MonitorCount = 1) or ((VMonitSetting.Primary <> 0) and (VMonitSetting.Primary <> 1) and (VMonitSetting.Primary <> 2))then
    FServiceIndex := 0;
end;

procedure TfrmBaseTCMS.SetServicePosition(const aPos: TRecServicePosition);
begin
  FServicePos    := aPos;

  DefaultMonitor := dmDesktop;

  SetServiceIndex(aPos.Monitor);
  Left := aPos.X + Screen.Monitors[FServiceIndex].BoundsRect.Left;
  Top  := aPos.Y + Screen.Monitors[FServiceIndex].BoundsRect.Top;
end;

end.

