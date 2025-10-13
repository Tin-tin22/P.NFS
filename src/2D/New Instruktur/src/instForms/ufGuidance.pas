unit ufGuidance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Menus, ExtCtrls, VrControls, VrWheel, StdCtrls, Buttons,
  
  uInstrukturManager, uTCPDatatype, uBridgeSet, uInstrukturObjects, uBaseConstan, uInstrukturViews,
  ComCtrls;

type
  TfGuidance = class(TFrame)
    pnlPlatformGuidance: TPanel;
    grpEvasion: TGroupBox;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lblEvasionActualGroundSpeed: TLabel;
    btnTrackToEvade: TSpeedButton;
    txt4: TStaticText;
    edtTrackToEvade: TEdit;
    txt5: TStaticText;
    grpOutrun: TGroupBox;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lblOutrunActualGroundSpeed: TLabel;
    btnTrackToOutrun: TSpeedButton;
    txt6: TStaticText;
    edtTrackToOutrun: TEdit;
    txt7: TStaticText;
    grpWaypoint: TGroupBox;
    lbl11: TLabel;
    lblName: TLabel;
    lblLongitude: TLabel;
    lbl12: TLabel;
    lblGroundSpeed: TLabel;
    lbl13: TLabel;
    lblEta: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lblDistance: TLabel;
    lblOrderGroundWaypoint: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lblLatitude: TLabel;
    lblActualGroundWaypoint: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    txt8: TStaticText;
    txt9: TStaticText;
    txt10: TStaticText;
    btnWaypoint: TButton;
    txt11: TStaticText;
    txt12: TStaticText;
    txt13: TStaticText;
    txt14: TStaticText;
    txt15: TStaticText;
    txt16: TStaticText;
    txt17: TStaticText;
    grpFormation: TGroupBox;
    lbl20: TLabel;
    lbl21: TLabel;
    lblLeaderFormation: TLabel;
    lblNameFormation: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lblRangeFormation: TLabel;
    lblBearingFormation: TLabel;
    lbl25: TLabel;
    txt18: TStaticText;
    txt19: TStaticText;
    txt20: TStaticText;
    txt21: TStaticText;
    grpSinuation: TGroupBox;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    lbl33: TLabel;
    lblSinuationActualGroundSpeed: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    txt22: TStaticText;
    edtSinuationBaseCourse: TEdit;
    txt23: TStaticText;
    edtSinuationBasePeriod: TEdit;
    txt24: TStaticText;
    edtSinuationAmplitude: TEdit;
    txt25: TStaticText;
    edtSinuationOrderedgroundSpeed: TEdit;
    txt26: TStaticText;
    grpStation: TGroupBox;
    lbl36: TLabel;
    bvl3: TBevel;
    btnOnTrackAnchorMode: TSpeedButton;
    lbl37: TLabel;
    btnOnTrackAnchorTrack: TSpeedButton;
    lbl38: TLabel;
    lbl39: TLabel;
    lbl40: TLabel;
    lbl41: TLabel;
    btnOnTrackAnchorBearing: TSpeedButton;
    txt27: TStaticText;
    edtOnTrackAnchorMode: TEdit;
    txt28: TStaticText;
    txt29: TStaticText;
    edtOnTrackAnchorTrack: TEdit;
    txt30: TStaticText;
    edtOnTrackAnchorBearing: TEdit;
    txt31: TStaticText;
    edtOnTrackAnchorRange: TEdit;
    grpZigZag: TGroupBox;
    lbl42: TLabel;
    lbl43: TLabel;
    lbl44: TLabel;
    lbl45: TLabel;
    lbl46: TLabel;
    lbl47: TLabel;
    lbl48: TLabel;
    lbl49: TLabel;
    lblZigZagActualGroundSpeed: TLabel;
    lbl50: TLabel;
    lbl51: TLabel;
    txt32: TStaticText;
    edtZigZagBaseCourse: TEdit;
    txt33: TStaticText;
    edtZigZagPeriod: TEdit;
    txt34: TStaticText;
    edtZigZagAmplitude: TEdit;
    txt35: TStaticText;
    edtZigZagOrderedGroundSpeed: TEdit;
    txt36: TStaticText;
    grpEngagement: TGroupBox;
    lbl52: TLabel;
    lbl53: TLabel;
    lbl54: TLabel;
    lbl55: TLabel;
    lbl56: TLabel;
    lbl57: TLabel;
    lblEngageActualGroundSpeed: TLabel;
    lbl58: TLabel;
    btnEngageTrackToEngage: TSpeedButton;
    pnlDepthEngagement: TPanel;
    lbl59: TLabel;
    lblDeptEngagMOde: TLabel;
    lbl60: TLabel;
    lbl61: TLabel;
    txt37: TStaticText;
    txt38: TStaticText;
    txt39: TStaticText;
    edt2: TEdit;
    txt40: TStaticText;
    edtTrackToEngage: TEdit;
    txt41: TStaticText;
    txt42: TStaticText;
    txt43: TStaticText;
    pnlAltitudeEngagement: TPanel;
    lbl62: TLabel;
    lblAltitudeEngagement: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    txt44: TStaticText;
    txt45: TStaticText;
    txt46: TStaticText;
    edtAltitudeEngagement: TEdit;
    edtEngageStandOffDistance: TEdit;
    edtEngageOrderedGroundSpeed: TEdit;
    grpShadow: TGroupBox;
    lbl65: TLabel;
    lbl66: TLabel;
    lbl67: TLabel;
    lbl68: TLabel;
    lbl69: TLabel;
    lbl70: TLabel;
    lblShadowActualGroundSpeed: TLabel;
    lbl71: TLabel;
    btnTrackToshadow: TSpeedButton;
    txt47: TStaticText;
    edtTrackToShadow: TEdit;
    txt48: TStaticText;
    edtStandoffDistanceShadow: TEdit;
    txt49: TStaticText;
    edtShadowOrdeeredGroundSpeed: TEdit;
    txt50: TStaticText;
    grpCircle: TGroupBox;
    scrlbxLauncher: TScrollBox;
    lbl72: TLabel;
    lbl73: TLabel;
    lbl74: TLabel;
    btnCircleDirection: TSpeedButton;
    bvl4: TBevel;
    lbl75: TLabel;
    lbl76: TLabel;
    lbl77: TLabel;
    lbl78: TLabel;
    lblCircleActualGroundSpeed: TLabel;
    lbllb1: TLabel;
    btnCircleMode: TSpeedButton;
    pnlPosition: TPanel;
    lbl79: TLabel;
    btnCircleOnPositionPosition: TSpeedButton;
    txt51: TStaticText;
    edtCircleOnPositionPosition: TEdit;
    pnlTrack: TPanel;
    lbl80: TLabel;
    btnCircleOnTrackTrack: TSpeedButton;
    lbl81: TLabel;
    lblCircleDegree: TLabel;
    lbl82: TLabel;
    lbl83: TLabel;
    btnCircleOnTrackBearing: TSpeedButton;
    txt52: TStaticText;
    edtCircleOnTrackRange: TEdit;
    txt53: TStaticText;
    edtCircleOnTrackBearing: TEdit;
    txt54: TStaticText;
    edtCircleOnTrackTrack: TEdit;
    txt55: TStaticText;
    edtCircleMode: TEdit;
    txt56: TStaticText;
    txt57: TStaticText;
    edtCircleRadius: TEdit;
    txt58: TStaticText;
    edtCircleDirection: TEdit;
    txt59: TStaticText;
    edtCircleOrderedGroundSpeed: TEdit;
    txt60: TStaticText;
    grpStraightLine: TGroupBox;
    scrlbxLauncher1: TScrollBox;
    vrwhlHeading: TVrWheel;
    lblStraightLineActualHeading: TLabel;
    lbl84: TLabel;
    lblStraightLineActualGroundSpeed: TLabel;
    lbl85: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    lbl88: TLabel;
    lbl89: TLabel;
    lbl90: TLabel;
    lblStraightLineActuaCourse: TLabel;
    lbl91: TLabel;
    pnlStraightAlt: TPanel;
    lblStraightVRudder: TLabel;
    lblStraightAlt: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    txtStraightActAlt: TStaticText;
    txt2: TStaticText;
    txt3: TStaticText;
    edtOrderVrudderStraight: TEdit;
    edtStraightLineOrderedGroundSpeed: TEdit;
    edtStraightLineOrderedHeading: TEdit;
    txt64: TStaticText;
    txt65: TStaticText;
    txt66: TStaticText;
    txt67: TStaticText;
    txt68: TStaticText;
    txt69: TStaticText;
    txt70: TStaticText;
    grpHelm: TGroupBox;
    lbl95: TLabel;
    lbl96: TLabel;
    lbl97: TLabel;
    lbl98: TLabel;
    lbl99: TLabel;
    lbl100: TLabel;
    lbl101: TLabel;
    lblHelmActualGroundSpeed: TLabel;
    lblActualHelmAngle: TLabel;
    lblHelmActualHeading: TLabel;
    lbl103: TLabel;
    lblHelmActualCourse: TLabel;
    lbl104: TLabel;
    lblHelmActualDepth: TLabel;
    vrwhlHelmAngle: TVrWheel;
    lbl105: TLabel;
    lbl106: TLabel;
    txt72: TStaticText;
    txt73: TStaticText;
    txt74: TStaticText;
    txt76: TStaticText;
    txt77: TStaticText;
    edtOrderedHelmAngle: TEdit;
    txt78: TStaticText;
    txt79: TStaticText;
    txt80: TStaticText;
    txt81: TStaticText;
    lbl112: TLabel;
    lbl113: TLabel;
    txt85: TStaticText;
    txt86: TStaticText;
    edtHelmOrderedGroundSpeed: TEdit;
    grpReturnToBase: TGroupBox;
    lbl115: TLabel;
    lblReturnToBaseDestinationBase: TLabel;
    lbl116: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl119: TLabel;
    lblReturnToBaseActualGroundSpeed: TLabel;
    lbl120: TLabel;
    lbl121: TLabel;
    lbl122: TLabel;
    lbl123: TLabel;
    lblReturnToBaseActualAltitude: TLabel;
    txt88: TStaticText;
    txt89: TStaticText;
    edtReturnToBaseOrderedGroundSpeed: TEdit;
    txt90: TStaticText;
    txt91: TStaticText;
    edtReturnToBaseOrderedAltitude: TEdit;
    txt92: TStaticText;
    pnlCoverAltitudeReturnToBase: TPanel;
    pnlGuidanceControlChoices: TPanel;
    edtGuidance: TEdit;
    pmCircleBearingDegree: TPopupMenu;
    True1: TMenuItem;
    Relative1: TMenuItem;
    pmGuidance: TPopupMenu;
    mnStraightLine1: TMenuItem;
    mnHelm1: TMenuItem;
    mnCircle: TMenuItem;
    mnStation: TMenuItem;
    mnZigzag1: TMenuItem;
    Short1: TMenuItem;
    Long1: TMenuItem;
    VeryLong1: TMenuItem;
    mnSinuation1: TMenuItem;
    mnFormation2: TMenuItem;
    mnEvasion1: TMenuItem;
    mnWaypoint1: TMenuItem;
    mnOutrun1: TMenuItem;
    mnEngagement1: TMenuItem;
    mnShadow1: TMenuItem;
    mnReturntoBase1: TMenuItem;
    pmCircleMode: TPopupMenu;
    Position1: TMenuItem;
    track1: TMenuItem;
    pmCircleDirection: TPopupMenu;
    Clockwise1: TMenuItem;
    Counterclockwise1: TMenuItem;
    pnlHelmAlt: TPanel;
    edtHelmOrderedVRudder: TEdit;
    lblHelmActAlt: TStaticText;
    lblHelmAlt: TLabel;
    btnGuidance: TButton;
    pnlBack: TPanel;
    txt71: TStaticText;
    txt75: TStaticText;
    txt82: TStaticText;
    txt83: TStaticText;
    lblHelmLatitude: TLabel;
    lblHelmLongitude: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtOrderAltStraight: TEdit;
    lbl92: TLabel;
    txt61: TStaticText;
    lblOrderStraightAlt: TLabel;
    lbl94: TLabel;
    txt62: TStaticText;
    edtHelmOrderedAltitude: TEdit;
    lbl102: TLabel;
    trckbrHelm1: TTrackBar;
    lbl93: TLabel;
    lbl108: TLabel;
    txt1: TStaticText;
    lbl107: TLabel;
    txt63: TStaticText;
    btnWayP: TButton;
    btnWayPOK: TButton;
    btnStopWayPoint: TButton;
    edtCoordX: TEdit;
    edtCoordY: TEdit;
    edtCoordZ: TEdit;
    procedure vrwhlHelmAngleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtHelmOrderedGroundSpeedKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtOrderedHelmAngleKeyPress(Sender: TObject; var Key: Char);
    procedure edtHelmOrderedVRudderKeyPress(Sender: TObject;
      var Key: Char);
    procedure btnGuidanceClick(Sender: TObject);
    procedure mnStraightLine1Click(Sender: TObject);
    procedure edtStraightLineOrderedHeadingKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtStraightLineOrderedGroundSpeedKeyPress(Sender: TObject;
      var Key: Char);
    procedure vrwhlHeadingMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtOrderVrudderStraightKeyPress(Sender: TObject; var Key: Char);
    procedure edtHelmOrderedAltitudeKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtOrderAltStraightKeyPress(Sender: TObject; var Key: Char);
    procedure trckbrHelm1Change(Sender: TObject);
    procedure vrwhlHeadingChange(Sender: TObject);
    procedure btnWayPClick(Sender: TObject);
    procedure btnWayPOKClick(Sender: TObject);
    procedure btnStopWayPointClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshGuidance;
    procedure UpdateGuidance(const t : Byte);
    procedure NillAllSet;

    procedure SetObject(aObj : TInsObject);

  end;

implementation


{$R *.dfm}

/// <summary>
/// Update or set input method of guidance (every activated, not based on time)
/// </summary>
/// <param name="t">t : constant of guidance</param>
procedure TfGuidance.UpdateGuidance(const t : Byte);
var
   tempRuder : integer;
   AngleStraight, speed,
   AngleHelm,altitude : double;
begin
  if not Assigned(SimManager.TrackObject) then
    Exit;

  AngleStraight := SimManager.TrackObject.OrderedHeadingStraight;
  AngleHelm := SimManager.TrackObject.OrderedHeadingHelm;
  speed := SimManager.TrackObject.OrderedSpeed;
  altitude := SimManager.TrackObject.OrderedZ;

  case t of
    VG_StraightLine:
    begin
      edtGuidance.Text := 'Straight Line';

      pnlGuidanceControlChoices.Visible := True;
      pnlPlatformGuidance.BringToFront;
      vrwhlHeading.BackImage.LoadFromFile('..\data\images\NFS instruktur - interface\bmp\main\button_rotary_mini.bmp');
      grpStraightLine.BringToFront;
      lbl93.Visible := False;

      edtStraightLineOrderedHeading.Text := floattostr(AngleStraight);
      edtStraightLineOrderedGroundSpeed.Text := floattostr(speed);

      if SimManager.TrackObject is TISubMarineObject then begin
        edtOrderAltStraight.Text :=  floattostr(-1 * altitude);
      end
      else begin
        edtOrderAltStraight.Text := floattostr(altitude);
      end;


      if AngleStraight < 180 then
      begin
        vrwhlHeading.Position := Round(AngleStraight + 180);
      end
      else
      begin
        vrwhlHeading.Position := Round(AngleStraight - 180);
      end;

      if (SimManager.TrackObject is TIHeliObject) or
         (SimManager.TrackObject is TIAirCraftObject)
      then
      begin
        pnlStraightAlt.Visible := True;
        lblOrderStraightAlt.Caption := 'Order Altitude';
        txtStraightActAlt.Caption := 'Actual Altitude';
      end
      else
      if (SimManager.TrackObject is TISubMarineObject) then
      begin
        pnlStraightAlt.Visible := True;
        lblOrderStraightAlt.Caption := 'Order Depth';
        txtStraightActAlt.Caption := 'Actual Depth';
      end
      else
      if (SimManager.TrackObject is TIShipObject) then
      begin
        pnlStraightAlt.Visible := False;
      end;

    end;
    VG_Helm:
    begin
      edtGuidance.Text := 'Helm';

      pnlGuidanceControlChoices.Visible := True;
      pnlPlatformGuidance.BringToFront;
      grpHelm.BringToFront;

      edtOrderedHelmAngle.Text := floattostr(AngleHelm);
      edtHelmOrderedGroundSpeed.Text := FloatToStr(speed);

      if SimManager.TrackObject is TISubMarineObject then begin
        edtHelmOrderedAltitude.Text := FloatToStr(-1 * altitude);
      end
      else begin
        edtHelmOrderedAltitude.Text := FloatToStr(altitude);
      end;

      vrwhlHelmAngle.Position := Round(AngleHelm + 180);

      if (SimManager.TrackObject is TIHeliObject) or
         (SimManager.TrackObject is TIAirCraftObject)
      then
      begin
        pnlHelmAlt.Visible := True;
        lblHelmActAlt.Caption := 'Actual Altitude';
      end
      else
      if (SimManager.TrackObject is TISubMarineObject) then
      begin
        pnlHelmAlt.Visible := True;
        lblHelmActAlt.Caption := 'Actual Depth';
      end
      else
      if (SimManager.TrackObject is TIShipObject) then
      begin
        pnlHelmAlt.Visible := False;
      end;

    end;
    VG_Circle:
    begin

    end;
    VG_Station:
    begin

    end;
    VG_Zigzag:
    begin

    end;
    VG_Sinuation:
    begin

    end;
    VG_Formation:
    begin

    end;
    VG_Evasion:
    begin

    end;
    VG_Waypoint:
    begin
      edtGuidance.Text := 'Waypoint';
      grpWaypoint.BringToFront;
    end;
    VG_Outrun:
    begin

    end;
    VG_Engagement:
    begin

    end;
    VG_Shadow:
    begin

    end;
  end;
end;

procedure TfGuidance.RefreshGuidance;
begin
    if SimManager.isDatabaseMode then Exit;
    if not Assigned(SimManager.TrackObject) then Exit;

    //---------------------Helm Movement--------------------------------------------------
    lblHelmActualCourse.Caption      := Format('%.2f',[SimManager.TrackObject.Course]);
    lblHelmActualGroundSpeed.Caption := Format('%.1f',[SimManager.TrackObject.Speed]);
    lblHelmAlt.Caption               := FormatFloat('0.00',SimManager.TrackObject.PositionZ);

    lblHelmActualHeading.Caption     := Format('%.2f',[SimManager.TrackObject.Course]);
    lblActualHelmAngle.Caption       := IntToStr(SimManager.TrackObject.RuderPos);
    lblHelmLatitude.Caption          := FormatFloat('0.000000000',SimManager.TrackObject.PositionX);
    lblHelmLongitude.Caption         := FormatFloat('0.000000000',SimManager.TrackObject.Positiony);

    //---------------------Straight Line Movement--------------------------------------------
    lblStraightLineActualHeading.Caption     := Format('%.2f',[SimManager.TrackObject.Course]);
    lblStraightLineActualGroundSpeed.Caption := Format('%.1f',[SimManager.TrackObject.Speed]);
    lblStraightLineActuaCourse.Caption       := Format('%.2f',[SimManager.TrackObject.Course]);
    lblStraightAlt.Caption                   := FormatFloat('0.00',SimManager.TrackObject.PositionZ);
end;

procedure TfGuidance.vrwhlHelmAngleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sid : Integer;
begin
  if not Assigned(SimManager.TrackObject) then
      Exit;

  if vrwhlHelmAngle.Position < 143 then                //max helm 37  min helm -37
    vrwhlHelmAngle.Position := 143
  else if  vrwhlHelmAngle.Position > 217 then
    vrwhlHelmAngle.Position := 217;


  sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
  SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, TVrWheel(Sender).Position - 180, VG_Helm,0,0,0);

  edtOrderedHelmAngle.Text := IntToStr(Round(TVrWheel(Sender).Position - 180));
end;

procedure TfGuidance.edtHelmOrderedGroundSpeedKeyPress(Sender: TObject;
  var Key: Char);
var
  speed: double;
  sID: integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, speed) then
    begin
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_THROTTLE, speed, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedSpeed := speed;
    end
    else
      ShowMessage('Invalid Speed Input');
  end;
end;

procedure TfGuidance.btnGuidanceClick(Sender: TObject);
var
  pos : TPoint;
begin
  if Assigned(SimManager.TrackObject) then
  begin
    GetCursorPos(pos);
    pmGuidance.Popup(pos.X, pos.Y);
  end;
end;

procedure TfGuidance.edtOrderedHelmAngleKeyPress(Sender: TObject;
  var Key: Char);
var
  helm: double;
  sID: integer;

begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    if  strtoint(TEdit(Sender).Text) > 37  then          //max helm 37
       TEdit(Sender).Text := '37'
    else if strtoint(TEdit(Sender).Text)< -37 then       //min helm -37
       TEdit(Sender).Text := '-37';

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, helm) then
    begin

      vrwhlHelmAngle.Position := Round(helm + 180);
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, helm, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedHeadingHelm := helm;

    end
    else
      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.edtHelmOrderedVRudderKeyPress(Sender: TObject;
  var Key: Char);
var
  Vrudder : double;
  sID     : integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, Vrudder) then
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_VERRUDDER, Vrudder, VG_Helm,0,0,0)
    else
      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.mnStraightLine1Click(Sender: TObject);
var
  GuideTag : integer;
begin
  if Assigned(SimManager.TrackObject) then
  begin
    GuideTag := TComponent(sender).Tag;
    SimManager.TrackObject.GuidanceMode := GuideTag;

    UpdateGuidance(GuideTag);
  end;
end;

procedure TfGuidance.edtStraightLineOrderedHeadingKeyPress(Sender: TObject;
  var Key: Char);
var
  Straight: double;
  sID: integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    if strtoint(TEdit(Sender).Text) > 360 then
      TEdit(Sender).Text := '360'
    else if  strtoint(TEdit(Sender).Text) < 0  then
      TEdit(Sender).Text := '0';

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, Straight) then
    begin
      if Straight < 180 then
      begin
        vrwhlHeading.Position := Round(Straight + 180);
      end
      else
      begin
        vrwhlHeading.Position := Round(Straight - 180);
      end;

      SimManager.TrackObject.OrderedHeadingStraight := Straight;

      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, Straight, VG_StraightLine,0,0,0);

    end
    else
      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.edtStraightLineOrderedGroundSpeedKeyPress(
  Sender: TObject; var Key: Char);
var
  speed: double;
  sID: integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, speed) then
    begin
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_THROTTLE, speed, VG_StraightLine,0,0,0);
      SimManager.TrackObject.OrderedSpeed := speed;
    end
    else
      ShowMessage('Invalid Speed Input');
  end;
end;

procedure TfGuidance.vrwhlHeadingMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sid,StraightHeading : Integer;
begin
  if not Assigned(SimManager.TrackObject) then
      Exit;
  lbl93.Visible := false;
  if TVrWheel(Sender).Position < 180 then
  begin
    StraightHeading := (180 + TVrWheel(Sender).Position);
    edtStraightLineOrderedHeading.Text := IntToStr(StraightHeading);
  end
  else
  begin
    StraightHeading := (TVrWheel(Sender).Position - 180);
    edtStraightLineOrderedHeading.Text := IntToStr(StraightHeading);
  end;

   sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
   SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, StraightHeading, VG_StraightLine,0,0,0);

end;


procedure TfGuidance.edtOrderVrudderStraightKeyPress(Sender: TObject; var Key: Char);
var
  OrderVRudder : double;
  sID      : integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
    if TryStrToFloat(TEdit(Sender).Text, OrderVRudder) then
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_VERRUDDER, OrderVRudder, VG_StraightLine,0,0,0)
    else
      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.NillAllSet;
begin
  pnlBack.BringToFront;
  pnlGuidanceControlChoices.Visible := false;
end;

procedure TfGuidance.SetObject(aObj: TInsObject);
begin
  if aObj = nil then Exit;

  pnlPlatformGuidance.BringToFront;
  pnlGuidanceControlChoices.Visible := true;
  UpdateGuidance(1);
end;

procedure TfGuidance.edtHelmOrderedAltitudeKeyPress(Sender: TObject;
  var Key: Char);
var
  VAlt : double;
  sID     : integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);

    if (SimManager.TrackObject is TISubMarineObject) and (TryStrToFloat(TEdit(Sender).Text, VAlt)) then begin
      VAlt := VAlt * -1;
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, VAlt, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedZ := VAlt;
    end
    else if ((SimManager.TrackObject is TIHeliObject) or (SimManager.TrackObject is TIAirCraftObject))
      and (TryStrToFloat(TEdit(Sender).Text, VAlt)) then begin
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, VAlt, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedZ := VAlt;
    end
    else begin
      ShowMessage('Invalid Input');
    end;

//    if TryStrToFloat(TEdit(Sender).Text, VAlt) then
//    begin
//      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, VAlt, VG_Helm);
//      SimManager.TrackObject.OrderedZ := VAlt;
//    end
//    else
//      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.edtOrderAltStraightKeyPress(Sender: TObject;
  var Key: Char);
var
  OrderAlt : double;
  sID      : integer;
begin
  if Key = #13 then
  begin
    if not Assigned(SimManager.TrackObject) then
      Exit;

    sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);

    if (SimManager.TrackObject is TISubMarineObject) and (TryStrToFloat(TEdit(Sender).Text, OrderAlt)) then begin
      OrderAlt := OrderAlt * -1;
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, OrderAlt, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedZ := OrderAlt;
    end
    else if ((SimManager.TrackObject is TIHeliObject) or (SimManager.TrackObject is TIAirCraftObject))
      and (TryStrToFloat(TEdit(Sender).Text, OrderAlt)) then begin
      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, OrderAlt, VG_Helm,0,0,0);
      SimManager.TrackObject.OrderedZ := OrderAlt;
    end
    else begin
      ShowMessage('Invalid Input');
    end;
//
//    if TryStrToFloat(TEdit(Sender).Text, OrderAlt) then
//    begin
//      SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_ALT, OrderAlt, VG_StraightLine);
//      SimManager.TrackObject.OrderedZ := OrderAlt;
//    end
//    else
//      ShowMessage('Invalid Input');
  end;
end;

procedure TfGuidance.trckbrHelm1Change(Sender: TObject);
var
  sid : Integer;
begin
  if not Assigned(SimManager.TrackObject) then
      Exit;

  sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
  SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, trckbrHelm1.Position, VG_Helm,0,0,0);

  //edtOrderedHelmAngle.Text := IntToStr(Round(trckbrHelm1.Position));
  if (IntToStr(Round(trckbrHelm1.Position)) = '0') then begin
    edtOrderedHelmAngle.Text := '0';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '1') then begin
    edtOrderedHelmAngle.Text := '0.25';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '2') then begin
    edtOrderedHelmAngle.Text := '0.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '3') then begin
    edtOrderedHelmAngle.Text := '0.75';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '4') then begin
    edtOrderedHelmAngle.Text := '1';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '5') then begin
    edtOrderedHelmAngle.Text := '1.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '6') then begin
    edtOrderedHelmAngle.Text := '2';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '7') then begin
    edtOrderedHelmAngle.Text := '2.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '8') then begin
    edtOrderedHelmAngle.Text := '3';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '9') then begin
    edtOrderedHelmAngle.Text := '5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '10') then begin
    edtOrderedHelmAngle.Text := '7';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '11') then begin
    edtOrderedHelmAngle.Text := '12';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '12') then begin
    edtOrderedHelmAngle.Text := '16';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '13') then begin
    edtOrderedHelmAngle.Text := '23';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '14') then begin
    edtOrderedHelmAngle.Text := '30';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '15') then begin
    edtOrderedHelmAngle.Text := '37';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-1') then begin
    edtOrderedHelmAngle.Text := '-0.25';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-2') then begin
    edtOrderedHelmAngle.Text := '-0.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-3') then begin
    edtOrderedHelmAngle.Text := '-0.75';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-4') then begin
    edtOrderedHelmAngle.Text := '-1';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-5') then begin
    edtOrderedHelmAngle.Text := '-1.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-6') then begin
    edtOrderedHelmAngle.Text := '-2';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-7') then begin
    edtOrderedHelmAngle.Text := '-2.5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-8') then begin
    edtOrderedHelmAngle.Text := '-3';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-9') then begin
    edtOrderedHelmAngle.Text := '-5';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-10') then begin
    edtOrderedHelmAngle.Text := '-7';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-11') then begin
    edtOrderedHelmAngle.Text := '-12';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-12') then begin
    edtOrderedHelmAngle.Text := '-16';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-13') then begin
    edtOrderedHelmAngle.Text := '-23';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-14') then begin
    edtOrderedHelmAngle.Text := '-30';
  end
  else if (IntToStr(Round(trckbrHelm1.Position)) = '-15') then begin
    edtOrderedHelmAngle.Text := '-37';
  end;

end;

procedure TfGuidance.vrwhlHeadingChange(Sender: TObject);
var
 StraightHeading : Integer;
begin
  if not Assigned(SimManager.TrackObject) then
      Exit;

  lbl93.Visible := True;
  if TVrWheel(Sender).Position < 180 then
  begin
    StraightHeading := (180 + TVrWheel(Sender).Position);
    lbl93.Caption := IntToStr(StraightHeading);
  end
  else
  begin
    StraightHeading := (TVrWheel(Sender).Position - 180);
    lbl93.Caption := IntToStr(StraightHeading);
  end;
end;



procedure TfGuidance.btnWayPClick(Sender: TObject);
var
  sID      : integer;
begin
  if not Assigned(SimManager.TrackObject) then
      Exit;
  SimManager.FMap.CurrentTool := TOOL_SELECT_WAYPOINT;

  //sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);

 { if TInsObject(SimManager.TrackObject).VWayPoint.listWayPoint.Count > 0 then
  begin
    edtCoordX.Text := FloatToStr(TObjPoint(TInsObject(SimManager.TrackObject).VWayPoint.listWayPoint[0]).pointX);
  end;}
end;

procedure TfGuidance.btnWayPOKClick(Sender: TObject);
var
  sID : Integer;
begin

  if not Assigned(SimManager.TrackObject) then
      Exit;

  sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
  SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, 0, VG_WaypointMove, 0, 0, 0);
  
end;

procedure TfGuidance.btnStopWayPointClick(Sender: TObject);
var
  sID : Integer;
begin
   if not Assigned(SimManager.TrackObject) then
      Exit;

  sID := UniqueID_To_dbID(SimManager.TrackObject.UniqueID);
  SimManager.NetSendTo3D_SetCommandOrder(sid, ORD_RUDDER, 0, VG_WaypointStop, 0, 0, 0);
end;

end.
