unit uDisplayCtrlPanelBottom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, VrControls, VrRotarySwitch, ExtCtrls, Buttons,
  SpeedButtonImage, StdCtrls,ufQEK, uLibTDCClass, VrButtons, uTDCConstan,
  VrDesign;

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
    btnArrow: TSpeedButtonImage;
    btnAmplInfo: TSpeedButtonImage;
    btnTN: TSpeedButtonImage;
    btnTM: TSpeedButtonImage;
    btnOffCent: TSpeedButtonImage;
    btnCent: TSpeedButtonImage;
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
    Label1: TLabel;
    vrIFF: TVrRotarySwitch;
    vrVideo: TVrRotarySwitch;
    vrMixed: TVrRotarySwitch;
    grpVidSel: TGroupBox;
    btnOff: TSpeedButtonImage;
    btnWmNonMti: TSpeedButtonImage;
    btnWmMti: TSpeedButtonImage;
    ILORANGEROUND: TImageList;
    imgBackground: TImage;
    bvl1: TBevel;
    bvl2: TBevel;
    btnclose: TVrBitmapButton;
    IndRdyToFire1: TImage;
    lbl1: TLabel;
    procedure RangeSelection(sender : TObject);
    procedure DisplaySelection(sender : TObject);
    procedure btnSurfClick(Sender: TObject);
    procedure btnLpdTesClick(Sender: TObject);
    procedure btnSubSurfClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure btnArrowClick(Sender: TObject);
    procedure btnAmplInfoClick(Sender: TObject);
    procedure btnTNClick(Sender: TObject);
    procedure btnOffCentClick(Sender: TObject);
    procedure btnCentClick(Sender: TObject);
    procedure btnTMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label53Click(Sender: TObject);
    procedure Label54Click(Sender: TObject);
    procedure Label55Click(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure Label57Click(Sender: TObject);
    procedure Label58Click(Sender: TObject);
    procedure VideoSelection(sender : TObject);
    procedure btnWmNonMtiClick(Sender: TObject);
    procedure btnWmMtiClick(Sender: TObject);
    procedure btnOffClick(Sender: TObject);
    procedure btnRRClick(Sender: TObject);
    procedure btnHMClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnHorScanClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure Label93Click(Sender: TObject);
    procedure Label92Click(Sender: TObject);
    procedure GroupBox6Click(Sender: TObject);
  private
    cekClose1, cekclose2 : Boolean;
    procedure Reset_RadarSelect_Button;
    procedure UpdateStateGroup(st,grp : Integer);
    procedure SetUpdownImage(var spb : TSpeedButtonImage);
  public
    rangeSel : Byte;
     procedure SetLocalVariable(tdc :TGenericTDCInterface); override;
     procedure setbtnscale(tag: Integer);

  end;

{var
  vDisplayCtrlPanelBottom: TvDisplayCtrlPanelBottom;}

implementation
{$R *.dfm}

uses
  uLibTorpedo_singa,uLibRadar, uDetected, uBaseFunction,uBaseConstan, uDisplaySinga;

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

procedure TvDisplayCtrlPanelBottom.SetUpdownImage(var spb : TSpeedButtonImage);
begin
  if spb.Down then spb.ImageIndex := 1
  else spb.ImageIndex := 0;
end;

procedure TvDisplayCtrlPanelBottom.RangeSelection(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    rangeSel := Tag;
    if TOCOS.TOCOSSysON then begin
      UpdateStateGroup(1, GroupIndex);
      ImageIndex := 1;
      tocos.SetView_RangeScale(rangeSel);
      TOCOS.OBMRight_Reset;
      setbtnscale(Tag);
    end
    else UpdateStateGroup(1, GroupIndex);
  end;
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

procedure TvDisplayCtrlPanelBottom.btnLpdTesClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then TOCOS.SetLPDTest(btnLpdTes.Down)
  else begin
    btnLpdTes.Down := False;
    SetUpdownImage(btnLpdTes);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnSurfClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnSurf.Down) and
   ((TOCOS.tocosMode = mLocal) or (TOCOS.tocosMode = mRemote)) then
  begin
    btnSurf.Down := True;
    TOCOS.SetRadar_Surf_Status(True);
  end
  else
  begin
    TOCOS.SetRadar_Surf_Status(False);
    btnSurf.Down := False;
    SetUpdownImage(btnSurf);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnSubSurfClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnSubSurf.Down) and
   ((TOCOS.tocosMode = mLocalwSonar) or (TOCOS.tocosMode = mRemote)) then
  begin
    btnSubSurf.Down := True;
    TOCOS.SetRadar_SubSurf_Status(True);
  end
  else begin
    TOCOS.SetRadar_SubSurf_Status(False);
    btnSubSurf.Down := False;
    SetUpdownImage(btnSubSurf);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnMSClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnMS.Down)then
    btnMS.Down := True
  else
    btnMS.Down := False;

  SetUpdownImage(btnMS);
  TOCOS.SetMainSymbolVisible(btnMS.Down)
end;

procedure TvDisplayCtrlPanelBottom.btnArrowClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnArrow.Down)then
    btnArrow.Down := True
  else
    btnArrow.Down := False;

  SetUpdownImage(btnArrow);
  TOCOS.SetCourseVisible(btnArrow.Down)
end;

procedure TvDisplayCtrlPanelBottom.btnAmplInfoClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnAmplInfo.Down)then
    btnAmplInfo.Down := True
  else
    btnAmplInfo.Down := False;

  SetUpdownImage(btnAmplInfo);
  TOCOS.SetAMPLInfoVisible(btnAmplInfo.Down)
end;

procedure TvDisplayCtrlPanelBottom.btnTNClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON and (btnTN.Down)then
    btnTN.Down := True
  else
    btnTN.Down := False;

  SetUpdownImage(btnTN);
  TOCOS.SetTrackNumberVisible(btnTN.Down)
end;

procedure TvDisplayCtrlPanelBottom.btnOffCentClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnOffCent.Down) then begin
    //TOCOS.CentLeft_SetStatus(stOFFCENT);
    TOCOS.CentRight_SetStatus(stOFFCENT);
    btnCent.ImageIndex := 0;
  end
  else begin
    btnOffCent.Down := False;
    SetUpdownImage(btnOffCent);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnCentClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnCent.Down) then begin
    //TOCOS.CentLeft_SetStatus(stCENT);
    TOCOS.CentRight_SetStatus(stCENT);
    btnOffCent.ImageIndex := 0;
  end
  else begin
    btnCent.Down := False;
    SetUpdownImage(btnCent);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btncloseClick(Sender: TObject);
begin
//  inherited;
 Application.Terminate;
end;

procedure TvDisplayCtrlPanelBottom.btnTMClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then TOCOS.TrueMotion := btnTM.Down
  else begin
    btnTM.Down := False;
    SetUpdownImage(btnTM);
  end;
end;

procedure TvDisplayCtrlPanelBottom.FormCreate(Sender: TObject);
begin
  inherited;
  cekClose1 := False;
  cekclose2 := False;
  btnWmNonMti.Caption := UpperCase('WM' + #13 + 'NON' + #13 + 'MTI');
  btnWmMti.Caption := UpperCase('WM' + #13 + 'MTI');
  btnAmplInfo.Caption := UpperCase('AMPL' + #13 + 'INFO');
  btnSubSurf.Caption := UpperCase('SUB' + #13 + 'SURF');
  btnLpdTes.Caption := UpperCase('LPD' + #13 + 'TEST');
  btnOffCent.Caption := UpperCase('OFF' + #13 + 'CENT');
  btnHorScan.Caption := UpperCase('HOR' + #13 + 'SCAN');
end;

procedure TvDisplayCtrlPanelBottom.GroupBox6Click(Sender: TObject);
begin
//  inherited;
 cekClose2 := False;
 cekClose1 := False;
 btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvDisplayCtrlPanelBottom.Label53Click(Sender: TObject);
begin
  btnRange2.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label54Click(Sender: TObject);
begin
  btnRange4.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label55Click(Sender: TObject);
begin
  btnRange8.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label56Click(Sender: TObject);
begin
  btnRange16.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label57Click(Sender: TObject);
begin
  btnRange32.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label58Click(Sender: TObject);
begin
  btnRange64.Click;
end;

procedure TvDisplayCtrlPanelBottom.Label92Click(Sender: TObject);
begin
//  inherited;
 cekClose2 := True;
 btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvDisplayCtrlPanelBottom.Label93Click(Sender: TObject);
begin
//  inherited;
  cekClose1 := True;
  btnclose.Visible := cekClose1 and cekClose2;
end;

procedure TvDisplayCtrlPanelBottom.VideoSelection(sender : TObject);
begin
  with Sender as TSpeedButtonImage do
  begin
    UpdateStateGroup(1, GroupIndex);
    ImageIndex := 1;
  end;
end;

procedure TvDisplayCtrlPanelBottom.Reset_RadarSelect_Button;
begin
  btnOff.ImageIndex := 0;
  btnWmNonMti.ImageIndex := 0;
  btnWmMti.ImageIndex := 0;
end;

procedure TvDisplayCtrlPanelBottom.setbtnscale(tag: Integer);
begin
  btnRange2.Down  := False;
  btnRange4.Down  := False;
  btnRange8.Down  := False;
  btnRange16.Down := False;
  btnRange32.Down := False;
  btnRange64.Down := False;

  if tag = 2 then
    btnRange2.Down := True else
  if tag = 4 then
    btnRange4.Down := True else
  if tag = 8 then
    btnRange8.Down := True else
  if tag = 16 then
    btnRange16.Down := True else
  if tag = 32 then
    btnRange32.Down := True else
  if tag = 64 then
    btnRange64.Down := True;
end;

procedure TvDisplayCtrlPanelBottom.btnWmNonMtiClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then begin
    Reset_RadarSelect_Button;
    (sender as TSpeedButtonImage).ImageIndex := 1;
    TOCOS.Set_Radar_Off(TOCOS.vDisplay.Map, True);
    TOCOS.SetRadar_type(rtWM_28);
    TOCOS.SetRadar_MTI_Status(FALSE);
    TOCOS.SetRadarForTocos_Status(True);

    if (not btnRange2.Down) and (not btnRange4.Down) and (not btnRange8.Down)
       and (not btnRange16.Down) and (not btnRange32.Down) and (not btnRange64.Down)then
    begin
      btnRange64.Click
    end;

  end
  else begin
    btnWmNonMti.Down := False;
    SetUpdownImage(btnWmNonMti);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnWmMtiClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then begin
    Reset_RadarSelect_Button;
    (sender as TSpeedButtonImage).ImageIndex := 1;
    TOCOS.Set_Radar_Off(TOCOS.vDisplay.Map, True);
    TOCOS.SetRadar_type(rtWM_28);
    TOCOS.SetRadar_MTI_Status(TRUE);
    TOCOS.SetRadarForTocos_Status(True);

    if (not btnRange2.Down) and (not btnRange4.Down) and (not btnRange8.Down)
       and (not btnRange16.Down) and (not btnRange32.Down) and (not btnRange64.Down)then
    begin
      btnRange64.Click
    end;
  end
  else begin
    btnWmMti.Down := False;
    SetUpdownImage(btnWmMti);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnOffClick(Sender: TObject);
var
  i : Integer;
  spbimg : TSpeedButtonImage;
begin
  if TOCOS.TOCOSSysON then begin
    Reset_RadarSelect_Button;
    TOCOS.Set_Radar_Off(TOCOS.vDisplay.Map, false);
    for I := 0 to ComponentCount - 1 do begin
      if Components[i] is TSpeedButtonImage then begin
        spbimg := (Components[i] as TSpeedButtonImage);
        spbimg.Down := false;
        SetUpdownImage(spbimg);
      end;
    end;
    btnOff.Down := True;
    SetUpdownImage(btnOff);
  end
  else begin
    btnOff.Down := False;
    SetUpdownImage(btnOff);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnRRClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then TOCOS.SetRadar_RangeRing(btnRR.Down)
  else begin
    btnRR.Down := False;
    SetUpdownImage(btnRR);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnHMClick(Sender: TObject);
begin
  if TOCOS.TOCOSSysON then TOCOS.SetRadar_HeadingMarker(btnHM.Down)
  else begin
    btnHM.Down := False;
    SetUpdownImage(btnHM);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnIFFClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnIFF.Down) then begin
    // fungsi IFF
  end
  else begin
    btnIFF.Down := False;
    SetUpdownImage(btnIFF);
  end;
end;

procedure TvDisplayCtrlPanelBottom.btnHorScanClick(Sender: TObject);
begin
  if (TOCOS.TOCOSSysON) and (btnHorScan.Down) then begin
    // fungsi Horscan
  end
  else begin
    btnHorScan.Down := False;
    SetUpdownImage(btnHorScan);
  end;
end;

end.


