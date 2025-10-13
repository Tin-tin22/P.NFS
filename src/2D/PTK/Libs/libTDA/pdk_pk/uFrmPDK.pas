unit uFrmPDK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBaseTCMS, Buttons, VrControls,
  SpeedButtonImage,  uSigma, uMovingTrack, uPointTrack,
  uTCMSEventManager;

type
  TBtnMainType = (
        bmtGen, bmtTrackAir, bmtTrackSurf, bmtTrackSubsurf, bmtLinkYCntrl,
        bmtTrainEnv, bmtLirodEng, bmtTwsEng, bmtWeaponEng, bmtIdentCh
      );

  TfrmPDK = class(TfrmBaseTCMS)
    procedure FormShow(Sender: TObject);

  private
    btn : TSpeedButtonImage;
    FBtnArray         : array [0..34] of TSpeedButtonImage;
    FBtnMainCaption   : array [0..34] of string;
    FBtnMainNames     : array [0..34] of string;

    IdIncr : Integer;

    procedure GenerateCaption;
    procedure GenerateNames;
    procedure btnPdkClick(Sender : TObject);
    procedure GenerateCaptionByMenu(aMenu : string);
    procedure GenerateGenMenu;
    procedure GenerateTrackAirMenu;
    procedure GenerateTrackSurfMenu;
    procedure GenerateWeaponEngageMenu;
    procedure GenerateLirodEngageMenu;
    procedure GenerateTwsEngageMenu;
    procedure EnableAllBtn;
  public
    procedure InitButtons;
    procedure Fire76(aBallisTicID, aOrdID : Integer; aModeId : Integer; aElev, aBearing : Double);

  end;

var
  frmPDK: TfrmPDK;

implementation

uses
  uTCMSSimManager, StrUtils, uTrackObject, uExocet_MM40_OnVehicle, uExocet_MM40_Launcher,
  uTcmsData, uSimObjects, uNFS_TCPDatatype, uBaseCoordSystem, uCoordDataTypes,
  uTrackData, uLibCommon, uNonrealVehicle;


{$R *.dfm}

procedure TfrmPDK.Fire76(aBallisTicID, aOrdID : Integer; aModeId : Integer; aElev, aBearing : Double);
var
  aRec76Data : TRec76mm;
  aObj : TSimObject;
begin
  if Assigned(SimManager.Sigma.Gun76mm.TargetObject) then begin
    aObj := SimManager.Sigma.Gun76mm.TargetObject;
    aRec76Data.ShipID := SimManager.Sigma.ObjectIndex;
    aRec76Data.mWeaponID :=14;
    aRec76Data.mLauncherID := 1;
    aRec76Data.mMissileID := 1;
    aRec76Data.mMissileNum := 1;
    aRec76Data.OrderID := aOrdID;
    aRec76Data.mTargetID := StrToInt(aObj.ObjectID);
    aRec76Data.mModeID := aModeId;
    aRec76Data.mUpDown := 0;
    aRec76Data.mAutoCorrectElev := aElev;
    aRec76Data.mAutoCorrectBearing := aBearing;
    aRec76Data.mBalistikID := aBallisTicID;
    SimManager.netSendLaunch76mm(aRec76Data);
  end;
end;

procedure TfrmPDK.FormShow(Sender: TObject);
begin
  inherited;

end;

{ TfrmPDK }
procedure TfrmPDK.btnPdkClick(Sender: TObject);
var
  aSender : string;
  i, j, k  : integer;
  IsFiring, RangeFire : Boolean;
  FAuxPnt : TPointGen;
  aObj : TSimObject;
//  aHookedObj : TSimObject;
  MM40Launcher : TExocet_MM40Launcher;
  rec : TRecSetTetral;
  Range : Double;
  Bearing : Double;
  MissileNumb : Integer;
  Elev : Double;
  TargetPos : T2DPoint;
  aBrnOStoPHP, aRngOStoPHP : Double;
begin
  aSender := (Sender as TSpeedButtonImage).Name;

  for I := 0 to Length(FBtnArray) - 1 do begin

    if FBtnArray[i].Name = (Sender as TSpeedButtonImage).Name then begin
      if i < 10 then begin
        EnableAllBtn;
        FBtnArray[i].Enabled := False;
        FBtnArray[i].Font.Color := clGray;
        GenerateCaptionByMenu(FBtnArray[i].Name);
      end
      else begin

        for j := 0 to 9 do begin
          if FBtnArray[j].Enabled = False then begin

            // WEAPON ENGAGE
            if FBtnArray[j].Name = 'btnWeaponEngage' then begin
              if aSender = 'btn11' then begin
                // DESIG Tetral FWD Run Here
                if Assigned(SimManager.Sigma) and
                    Assigned(SimManager.HookedPlat) then
                begin
                  if not TBaseTrack(SimManager.HookedPlat).HoldFire then
                  begin
                    if TBaseTrack(SimManager.HookedPlat).Domain = tdAir then
                    begin
                      with TSigma(SimManager.Sigma) do
                      begin
                        FTetralLauncher[0].SettoMissileNumber(TSimObject(SimManager.HookedPlat),
                                            MissileNumb, Elev);
                        FTetralLauncher[0].Visible := True;
                      end;

                      Range := CalcRangeDM(TSigma(SimManager.Sigma).PosX,
                                            TSigma(SimManager.Sigma).PosY,
                                            TBaseTrack(SimManager.HookedPlat).PosX,
                                            TBaseTrack(SimManager.HookedPlat).PosY);

                      bearing := CalcBearing(TSigma(SimManager.Sigma).PosX,
                                          TSigma(SimManager.Sigma).PosY,
                                          TBaseTrack(SimManager.HookedPlat).PosX,
                                          TBaseTrack(SimManager.HookedPlat).PosY);

                      with TSigma(SimManager.Sigma) do
                      begin
                        rec.ShipID := ObjectIndex;
                        Rec.mLauncherID      := FTetralLauncher[0].LauncherNumber;
                        Rec.mMissileID       := MissileNumb;
                        Rec.mMissileNumber   := 1;
                        Rec.OrderID          := 2;

                        Rec.mTargetBearing   := ValidateDegree(Bearing + Heading);
                        Rec.mTargetRange     := ((Range * C_DataMile_To_NauticalMile) * C_NauticalMile_To_Metre);
                        Rec.mTargetElev      := Elev;

                        Rec.mWeaponID        := C_DBID_TETRAL;
                      end;

                      if SimManager.IsConnected then
                         SimManager.netSendLaunchTetral(rec);
                    end
                    else
                    begin
                      MessageBox(1, 'Target is not air track', 'Tetral fwd', +MB_OK +mb_ICONWARNING)
                    end;
                  end
                  else
                  begin
                    MessageBox(1, 'Target is hold fire', 'Tetral fwd', +MB_OK +mb_ICONWARNING)
                  end;
                end;
              end
              else if aSender = 'btn12' then begin
                // DESIG Tetral AFT Run Here
                if Assigned(SimManager.Sigma) and
                    Assigned(SimManager.HookedPlat) then
                begin
                  if not TBaseTrack(SimManager.HookedPlat).HoldFire then
                  begin
                    if TBaseTrack(SimManager.HookedPlat).Domain = tdAir then
                    begin
                      with TSigma(SimManager.Sigma) do
                      begin
                        FTetralLauncher[1].SettoMissileNumber(TSimObject(SimManager.HookedPlat),
                                            MissileNumb, Elev);
                        FTetralLauncher[1].Visible := True;
                      end;

                      Range := CalcRangeDM(TSigma(SimManager.Sigma).PosX,
                                            TSigma(SimManager.Sigma).PosY,
                                            TBaseTrack(SimManager.HookedPlat).PosX,
                                            TBaseTrack(SimManager.HookedPlat).PosY);

                      bearing := CalcBearing(TSigma(SimManager.Sigma).PosX,
                                          TSigma(SimManager.Sigma).PosY,
                                          TBaseTrack(SimManager.HookedPlat).PosX,
                                          TBaseTrack(SimManager.HookedPlat).PosY);
                      with TSigma(SimManager.Sigma) do
                      begin
                        rec.ShipID := ObjectIndex;
                        Rec.mLauncherID      := FTetralLauncher[1].LauncherNumber;
                        Rec.mMissileID       := MissileNumb;
                        Rec.mMissileNumber   := 1;
                        Rec.OrderID          := 2;

                        Rec.mTargetBearing   := Bearing;
                        Rec.mTargetRange     := ((Range * C_DataMile_To_NauticalMile) * C_NauticalMile_To_Metre);
                        Rec.mTargetElev      := Elev;

                        Rec.mWeaponID        := C_DBID_TETRAL;
                      end;

                      if SimManager.IsConnected then
                        SimManager.netSendLaunchTetral(rec);
                    end
                    else
                    begin
                      MessageBox(1, 'Target is not air track', 'Tetral aft', +MB_OK +mb_ICONWARNING)
                    end;
                  end
                  else
                  begin
                    MessageBox(1, 'Target is hold fire','Tetral aft', +MB_OK +mb_ICONWARNING)
                  end;
                end;
              end
              else if aSender = 'btn13' then begin
                  // DESIG Gun 76 Run Here
                if Assigned(SimManager.HookedPlat) then begin
                  if (SimManager.Sigma.Gun76mm.GunConnection = gcDIRECT) or
                  (SimManager.Sigma.Gun76mm.GunConnection = gcNGS) then begin
                    if SimManager.Sigma.Gun76mm.Desig then begin
                      if Assigned(EventManager.OnMsg) then begin
                        EventManager.OnMsg(
                          '',
                          'Desig of Gun is only selectable',
                          ' if Gun is currently occupied'
                        );
                      end;

                    end
                    else begin
                      if ((SimManager.Sigma.Gun76mm.GunConnection = gcDIRECT)
                        and (TBaseTrack(SimManager.HookedPlat).Domain = tdAir)
                        or (TBaseTrack(SimManager.HookedPlat).Domain = tdSubSurface)) then begin
                        if Assigned(EventManager.OnMsg) then begin
                          EventManager.OnMsg('','Target is not Surface Track','');
                        end;
                      end
                      else begin
                        SimManager.Sigma.Gun76mm.Desig := True;
                        SimManager.Sigma.Gun76mm.Trajected := True;
                        SimManager.Sigma.Gun76mm.TargetObject := TBaseTrack(SimManager.HookedPlat);
                        EventManager.OnDesig(
                          SimManager.Sigma.Gun76mm.TargetObject,
                          SimManager.Sigma.Gun76mm.ObjectName,
                          False
                        );

                        if SimManager.IsConnected then begin
                          case SimManager.Sigma.Gun76mm.GunConnection of
                            gcNGS : begin
                              aBrnOStoPHP := CalcBearing(
                                SimManager.Sigma.PosX,
                                SimManager.Sigma.PosY,
                                SimManager.Sigma.Gun76mm.TargetObject.PosX,
                                SimManager.Sigma.Gun76mm.TargetObject.PosY
                              );

                              aRngOStoPHP := CalcRangeDM(
                                SimManager.Sigma.PosX,
                                SimManager.Sigma.PosY,
                                SimManager.Sigma.Gun76mm.TargetObject.PosX,
                                SimManager.Sigma.Gun76mm.TargetObject.PosY
                              );

                              case SimManager.Sigma.Gun76mm.BallisticType of
                                btHigh:begin
                                  Elev := high_MaxRangeToElev(aRngOStoPHP * C_DataMile_To_Metre);

                                end;
                                btLow: begin
                                  Elev := low_MaxRangeToElev(aRngOStoPHP * C_DataMile_To_Metre);

                                end;
                              end;
                              Fire76(
                                Integer(SimManager.Sigma.Gun76mm.BallisticType),
                                ORD_CANNON_76_ASSIGNED,
                                C_MODE_NGS,
                                Elev,
                                CalcBarrelBrn(SimManager.Sigma.Heading, aBrnOStoPHP)
                              );
                            end;
                            gcDIRECT : begin
                              case SimManager.Sigma.Gun76mm.BallisticType of
                                btHigh:begin
                                  Fire76(C_76_BALLISTIC_HIGH, ORD_CANNON_76_ASSIGNED, C_MODE_SURF,0,0);
                                end;
                                btLow: begin
                                  Fire76(C_76_BALLISTIC_LOW, ORD_CANNON_76_ASSIGNED, C_MODE_SURF, 0, 0);
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end
                  else begin
                    if Assigned(EventManager.OnMsg) then begin
                      EventManager.OnMsg(
                        '',
                        'Desig of Gun is only selectable if ',
                        'Direct Engagement is selected on the WAP'
                      );
                    end;

                  end;
                end;
              end
              else if aSender = 'btn14' then begin
                   // DESIG A244  Run Here
                
              end
              else if aSender = 'btn16' then begin
                  // BREAK Tetral FWD Run Here
                if Assigned(SimManager.Sigma) and
                    Assigned(SimManager.HookedPlat) then
                begin
                  with TSigma(SimManager.Sigma) do
                  begin
                    FTetralLauncher[0].TargetObject := nil;

                    for k := 0 to Length(FTetralLauncher[0].MissileInventory) - 1 do
                    begin
                      if FTetralLauncher[0].MissileInventory[k].IsUsed then
                      begin
                        FTetralLauncher[0].MissileInventory[k].TargetObject := nil;
                        FTetralLauncher[0].MissileInventory[k].IsUsed := False;
                        FTetralLauncher[0].IsPowerOnPK := False;
                        FTetralLauncher[0].Visible := False;
                      end;
                    end;
                  end;
                end;
              end
              else if aSender = 'btn17' then begin
                  // BREAK Tetral AFT Run Here
                if Assigned(SimManager.Sigma) and
                    Assigned(SimManager.HookedPlat) then
                begin
                  with TSigma(SimManager.Sigma) do
                  begin
                    FTetralLauncher[1].TargetObject := nil;

                    for k := 0 to Length(FTetralLauncher[1].MissileInventory) - 1 do
                    begin
                      if FTetralLauncher[1].MissileInventory[k].IsUsed then
                      begin
                        FTetralLauncher[1].MissileInventory[k].TargetObject := nil;
                        FTetralLauncher[1].MissileInventory[k].IsUsed := False;
                        FTetralLauncher[1].IsPowerOnPK := False;
                        FTetralLauncher[1].Visible := False;
                      end;
                    end;
                  end;
                end;
              end
              else if aSender = 'btn18' then begin
                    // BREAK GUN 76mm  Run Here
                SimManager.Sigma.Gun76mm.Desig := False;
                SimManager.Sigma.Gun76mm.Trajected := False;
              end
              else if aSender = 'btn19' then begin
                   // BREAK A244  Run Here

              end
              else if aSender = 'btn20' then begin
                    // DESIG EXOCET Run Here
                if Assigned(SimManager.HookedPlat) then
                begin
                  if not TBaseTrack(SimManager.HookedPlat).HoldFire then
                  begin

                  end
                  else

                end
                else

              end
              else if aSender = 'btn25' then begin
                    // BREAK EXOCET Run Here
                if Assigned(SimManager.HookedPlat) then
                begin
                  if not TBaseTrack(SimManager.HookedPlat).HoldFire then
                  begin
                    with TSigma(SimManager.Sigma) do
                    begin
                      
                    end;
                  end;
                end;
              end;
            end

            // GEN
            else if FBtnArray[j].Name = 'btnGen' then begin
              if aSender = 'btn25' then begin
                  // HOLD FIRE Run Here
                if Assigned(SimManager.HookedPlat) then begin
                  TBaseTrack(SimManager.HookedPlat).HoldFire := not TBaseTrack(SimManager.HookedPlat).HoldFire;
                end;

//                if Assigned(SimManager.Sigma.TDSStbd.ObjRangeTDS) then begin
//                  SimManager.Sigma.TDSStbd.ObjRangeTDS.HoldFire := not SimManager.Sigma.TDSStbd.ObjRangeTDS.HoldFire;
//                end;
//
//                if Assigned(SimManager.Sigma.TDSPort.ObjRangeTDS) then begin
//                  SimManager.Sigma.TDSPort.ObjRangeTDS.HoldFire := not SimManager.Sigma.TDSPort.ObjRangeTDS.HoldFire;
//                end;
              end
            end

            // LIROD ENGAGE
            else if FBtnArray[j].Name = 'btnLirodEngage' then begin
              if aSender = 'btn15' then begin
                  // DESIG LIROD Run Here
                if Assigned(SimManager.HookedPlat) then begin
                  if SimManager.Sigma.LIROD_MK2.Desig then
                    MessageBox(0, 'LIROD is occupied', 'LIROD Warning', +MB_OK +mb_ICONWARNING)
                  else begin
                    SimManager.Sigma.LIROD_MK2.TargetObject := TBaseTrack(SimManager.HookedPlat);
                    SimManager.Sigma.LIROD_MK2.Desig := True;
                  end;

                end;
              end
              else if aSender = 'btn20' then begin
                  // BREAK LIROD Run Here
                SimManager.Sigma.LIROD_MK2.Desig := False;
              end
            end

            // TRACK SURF
            else if FBtnArray[j].Name = 'btnTrackSurf' then begin
              if aSender = 'btn12' then begin
                  // Surf POINT GEN
                IdIncr := IdIncr + 1;
                FAuxPnt := TPointGen.Create;
                FAuxPnt.Visible := True;
                FAuxPnt.ObjectName := 'R 00'+IntToStr(IdIncr);
                FAuxPnt.PosX := SimManager.CrossVisual.MidX;
                FAuxPnt.PosY := SimManager.CrossVisual.MidY;
                FAuxPnt.ObjectID := 'R 00'+IntToStr(IdIncr);
                SimManager.SimPlatforms.AddObject(FAuxPnt);

                {
                for k := 0 to SimManager.SimPlatforms.ItemCount - 1 do begin
                  aObj := SimManager.SimPlatforms.getObject(k);
                  if not aObj.TestClick(SimManager.CrossVisual.sx, SimManager.CrossVisual.sy) then begin
                    IdIncr := IdIncr + 1;
                    FAuxPnt := TAuxPoint.Create;
                    FAuxPnt.Visible := True;
                    FAuxPnt.InstanceName := 'R 00'+IntToStr(IdIncr);
                    FAuxPnt.PosX := SimManager.CrossVisual.MidX;
                    FAuxPnt.PosY := SimManager.CrossVisual.MidY;
                    FAuxPnt.ObjectID := 'R 00'+IntToStr(IdIncr);
                    SimManager.SimPlatforms.AddObject(FAuxPnt);
                    Break;
                  end;
                end;
                }


              end
              else if aSender = 'btn24' then begin
                  // Surf WIPE SOURCE

//                aHookedObj := SimManager.HookedPlat;
                if Assigned(SimManager.HookedPlat) then begin
                  if (SimManager.HookedPlat is TPointGen) then begin
                    if (SimManager.HookedPlat as TPointGen).Controlled then begin
                      (SimManager.HookedPlat as TPointGen).Visible := False;
                      //SimManager.SimPlatforms.DeleteObject((SimManager.HookedPlat as TAuxPoint));
                    end;
                  end;
                end;

              end
            end

            // TWS ENGAGE
            else if FBtnArray[j].Name = 'btnTwsEngage' then begin
              if aSender = 'btn17' then begin
                // DESIG TWS-1 Run Here
                if Assigned(SimManager.HookedPlat) then begin
                  if SimManager.Sigma.Gun76mm.GunConnection = gcTWS1 then begin

                    if SimManager.Sigma.Gun76mm.Desig then begin
                      MessageBox(0, 'Desig of Gun is only selectable if Gun is currently occupied',
                          '76mm Warning', +MB_OK +mb_ICONWARNING)
                    end
                    else begin
                      SimManager.Sigma.Gun76mm.TargetObject := TBaseTrack(SimManager.HookedPlat);
                      SimManager.Sigma.Gun76mm.Desig := True;
                      (SimManager.Sigma.Gun76mm.TargetObject as TBaseTrack).HoldFire := True;

                    end;
                  end
                  else
                    MessageBox(0, 'Desig of Gun is only selectable if Direct Engagement is selected on the WAP',
                        '76mm Warning', +MB_OK +mb_ICONWARNING)
                end;
              end
              else if aSender = 'btn18' then begin
                // DESIG TWS-2 Run Here
                if Assigned(SimManager.HookedPlat) then begin
                  if SimManager.Sigma.Gun76mm.GunConnection = gcTWS2 then begin

                    if SimManager.Sigma.Gun76mm.Desig then begin
                      MessageBox(0, 'Desig of Gun is only selectable if Gun is currently occupied',
                          '76mm Warning', +MB_OK +mb_ICONWARNING)
                    end
                    else begin
                      SimManager.Sigma.Gun76mm.TargetObject := TBaseTrack(SimManager.HookedPlat);
                      SimManager.Sigma.Gun76mm.Desig := True;
                      (SimManager.Sigma.Gun76mm.TargetObject as TBaseTrack).HoldFire := True;

                    end;
                  end
                  else
                    MessageBox(0, 'Desig of Gun is only selectable if Direct Engagement is selected on the WAP',
                        '76mm Warning', +MB_OK +mb_ICONWARNING)
                end;
              end
              else if (aSender = 'btn22') or (aSender = 'btn23') then begin
                // BREAK TWS-1 and TWS-2 Run Here
                SimManager.Sigma.Gun76mm.Desig := False;
                SimManager.Sigma.Gun76mm.Trajected := False;
              end;


            end;

          end;
        end;
      end;
    end;
  end;
end;


procedure TfrmPDK.EnableAllBtn;
var
  I : integer;
begin
  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Enabled := True;
    FBtnArray[i].Font.Color := clYellow;
  end;

end;

procedure TfrmPDK.GenerateCaption;
var
  i  : Integer;
begin
  FBtnMainCaption[0] := 'GEN'    + #13#10;
  FBtnMainCaption[1] := 'TRACK'  + #13#10 + 'AIR';
  FBtnMainCaption[2] := 'TRACK'  + #13#10 + 'SURF';
  FBtnMainCaption[3] := 'TRACK'  + #13#10 + 'SUBSURF';
  FBtnMainCaption[4] := 'LINK-Y' + #13#10 + 'CNTRL';
  FBtnMainCaption[5] := 'TRAIN'  + #13#10 + 'ENV';
  FBtnMainCaption[6] := 'LIROD'  + #13#10 + 'ENGAGE';
  FBtnMainCaption[7] := 'TWS'    + #13#10 + 'ENGAGE';
  FBtnMainCaption[8] := 'WEAPON' + #13#10 + 'ENGAGE';
  FBtnMainCaption[9] := 'IDENT'  + #13#10 + 'CHANGE';
  for I := 10 to Length(FBtnArray)-1 do
    FBtnMainCaption[i] := ' ';
end;

procedure TfrmPDK.GenerateCaptionByMenu(aMenu: string);
var
  i : integer;
begin
  if aMenu = 'btnGen' then begin
    GenerateGenMenu;
  end
  else if aMenu = 'btnTrackAir' then begin
    GenerateTrackAirMenu;
  end
  else if aMenu = 'btnTrackSurf' then begin
    GenerateTrackSurfMenu;
  end
  else if aMenu = 'btnWeaponEngage' then begin
    GenerateWeaponEngageMenu;
  end
  else if aMenu = 'btnLirodEngage' then begin
    GenerateLirodEngageMenu;
  end
  else if aMenu = 'btnTwsEngage' then begin
    GenerateTwsEngageMenu;
  end;


  for I := 0 to Length(FBtnArray) - 1 do begin
    FBtnArray[i].Caption := FBtnMainCaption[i];
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;

end;

procedure TfrmPDK.GenerateGenMenu;
begin

  FBtnMainCaption[10] := ' ';
  FBtnMainCaption[11] := 'PLAFT'  + #13#10 + 'REQ';
  FBtnMainCaption[12] := 'DIS'    + #13#10 + 'JOIN';
  FBtnMainCaption[13] := 'SUW'    + #13#10 + 'ADVICE';
  FBtnMainCaption[14] := 'AAW'    + #13#10 + 'ADVICE';
  FBtnMainCaption[15] := 'SENSOR' + #13#10 + 'RANGE';
  FBtnMainCaption[16] := 'START'  + #13#10 + 'CPA';
  FBtnMainCaption[17] := 'JOIN'   + #13#10 + '';
  FBtnMainCaption[18] := 'ASSOC'  + #13#10 + '';
  FBtnMainCaption[19] := 'INCL'   + #13#10 + 'AAW';
  FBtnMainCaption[20] := 'WEAPON' + #13#10 + 'RANGE';
  FBtnMainCaption[21] := 'STOP'   + #13#10 + 'CPA';
  FBtnMainCaption[22] := 'DCRP'   + #13#10 + '';
  FBtnMainCaption[23] := 'DISSOC' + #13#10 + '';
  FBtnMainCaption[24] := 'EXCL'   + #13#10 + 'AAW';
  FBtnMainCaption[25] := 'HOLD'   + #13#10 + 'FIRE';
  FBtnMainCaption[26] := 'THROW'  + #13#10 + 'OFF';
  FBtnMainCaption[27] := 'MAN'    + #13#10 + 'OB';
  FBtnMainCaption[28] := 'COLL'   + #13#10 + 'AVOID';
  FBtnMainCaption[29] := 'ICM'    + #13#10 + '(ACK)';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.GenerateLirodEngageMenu;
begin
  FBtnMainCaption[10] := 'JOY-TO'    + #13#10 + 'LIROD';
  FBtnMainCaption[11] := ' '  + #13#10 + ' ';
  FBtnMainCaption[12] := ' '  + #13#10 + ' ';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := ' '    + #13#10 + ' ';
  FBtnMainCaption[15] := 'DESIG'    + #13#10 + 'LIROD';
  FBtnMainCaption[16] := 'SRV'  + #13#10 + 'LIROD';
  FBtnMainCaption[17] := 'OTO'  + #13#10 + 'LIROD';
  FBtnMainCaption[18] := 'RANGE'       + #13#10 + 'FAR';
  FBtnMainCaption[19] := ' '       + #13#10 + '';
  FBtnMainCaption[20] := 'BREAK'       + #13#10 + 'LIROD';
  FBtnMainCaption[21] := 'SS'       + #13#10 + 'LIROD';
  FBtnMainCaption[22] := 'AUTO'   + #13#10 + 'TRACK';
  FBtnMainCaption[23] := 'RANGE' + #13#10 + 'NEAR';
  FBtnMainCaption[24] := ' '   + #13#10 + ' ';
  FBtnMainCaption[25] := 'KILL'   + #13#10 + '';
  FBtnMainCaption[26] := 'MISS'   + #13#10 + '';
  FBtnMainCaption[27] := ' '    + #13#10 + ' ';
  FBtnMainCaption[28] := ' '   + #13#10 + '';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.GenerateNames;
var
  i : Integer;
begin
  FBtnMainNames[0] := 'Gen';
  FBtnMainNames[1] := 'TrackAir';
  FBtnMainNames[2] := 'TrackSurf';
  FBtnMainNames[3] := 'TrackSubsurf';
  FBtnMainNames[4] := 'LinkYCntrl';
  FBtnMainNames[5] := 'TrainEnv';
  FBtnMainNames[6] := 'LirodEngage';
  FBtnMainNames[7] := 'TwsEngage';
  FBtnMainNames[8] := 'WeaponEngage';
  FBtnMainNames[9] := 'IdentChange';

  for I := 10 to Length(FBtnMainNames)-1 do
    FBtnMainNames[i] := IntToStr(i);
end;



procedure TfrmPDK.GenerateTrackAirMenu;
begin
  FBtnMainCaption[10] := 'DIR'    + #13#10 + 'AIR';
  FBtnMainCaption[11] := 'VIS-B'  + #13#10 + 'AIR';
  FBtnMainCaption[12] := 'POINT'  + #13#10 + 'GEN';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := 'IFF'    + #13#10 + 'PLOT';
  FBtnMainCaption[15] := 'RAM'    + #13#10 + 'AIR';
  FBtnMainCaption[16] := 'ESM-B'  + #13#10 + 'AIR';
  FBtnMainCaption[17] := 'POINT'  + #13#10 + 'AIR';
  FBtnMainCaption[18] := ' '       + #13#10 + '';
  FBtnMainCaption[19] := ' '       + #13#10 + '';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'KEEP'   + #13#10 + 'LOST';
  FBtnMainCaption[23] := 'CHANGE' + #13#10 + 'SOURCE';
  FBtnMainCaption[24] := 'WIPE'   + #13#10 + 'SOURCE';
  FBtnMainCaption[25] := 'TAKE'   + #13#10 + 'RAM';
  FBtnMainCaption[26] := 'NEXT'   + #13#10 + 'RAM';
  FBtnMainCaption[27] := 'RE-'    + #13#10 + 'POSIT';
  FBtnMainCaption[28] := 'CORR'   + #13#10 + '';
  FBtnMainCaption[29] := 'WIPE'   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.GenerateTrackSurfMenu;
begin
  FBtnMainCaption[10] := 'DR'    + #13#10 + 'SURF';
  FBtnMainCaption[11] := 'VIS-B'  + #13#10 + 'SURF';
  FBtnMainCaption[12] := 'POINT'  + #13#10 + 'GEN';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := 'MW08'    + #13#10 + 'SURF';
  FBtnMainCaption[15] := 'RAM'    + #13#10 + 'SURF';
  FBtnMainCaption[16] := 'ESM-B'  + #13#10 + 'SURF';
  FBtnMainCaption[17] := 'POINT'  + #13#10 + 'ESMFIX';
  FBtnMainCaption[18] := ' '       + #13#10 + '';
  FBtnMainCaption[19] := 'INIT'       + #13#10 + 'NAVRAD';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'KEEP'   + #13#10 + 'LOST';
  FBtnMainCaption[23] := 'CHANGE' + #13#10 + 'SOURCE';
  FBtnMainCaption[24] := 'WIPE'   + #13#10 + 'SOURCE';
  FBtnMainCaption[25] := 'TAKE'   + #13#10 + 'RAM';
  FBtnMainCaption[26] := 'NEXT'   + #13#10 + 'RAM';
  FBtnMainCaption[27] := 'RE-'    + #13#10 + 'POSIT';
  FBtnMainCaption[28] := 'CORR'   + #13#10 + '';
  FBtnMainCaption[29] := 'WIPE'   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.GenerateTwsEngageMenu;
begin
  FBtnMainCaption[10] := ' '    + #13#10 + '';
  FBtnMainCaption[11] := ' '  + #13#10 + '';
  FBtnMainCaption[12] := ' '  + #13#10 + '';
  FBtnMainCaption[13] := ' '       + #13#10 + '';
  FBtnMainCaption[14] := ' '    + #13#10 + '';
  FBtnMainCaption[15] := ' '    + #13#10 + '';
  FBtnMainCaption[16] := ' '  + #13#10 + '';
  FBtnMainCaption[17] := 'DESIG'  + #13#10 + 'TWS-1';
  FBtnMainCaption[18] := 'DESIG'       + #13#10 + 'TWS-2';
  FBtnMainCaption[19] := ' '       + #13#10 + ' ';
  FBtnMainCaption[20] := ' '       + #13#10 + '';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := 'BREAK'   + #13#10 + 'TWS-1';
  FBtnMainCaption[23] := 'BREAK' + #13#10 + 'TWS-2';
  FBtnMainCaption[24] := ' '   + #13#10 + '';
  FBtnMainCaption[25] := ' '   + #13#10 + '';
  FBtnMainCaption[26] := ' '   + #13#10 + '';
  FBtnMainCaption[27] := 'MARK'    + #13#10 + 'SPLASH';
  FBtnMainCaption[28] := 'DELETE'   + #13#10 + 'SPLASH';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.GenerateWeaponEngageMenu;
begin
  FBtnMainCaption[10] := ' '    + #13#10 + '';
  FBtnMainCaption[11] := 'TETRAL'  + #13#10 + 'DESFWD';
  FBtnMainCaption[12] := 'TETRAL'  + #13#10 + 'DESAFT';
  FBtnMainCaption[13] := 'DESIG'       + #13#10 + 'GUN-76';
  FBtnMainCaption[14] := 'DESIG'    + #13#10 + 'A244';
  FBtnMainCaption[15] := ' '    + #13#10 + '';
  FBtnMainCaption[16] := 'TETRAL'  + #13#10 + 'BRKFWD';
  FBtnMainCaption[17] := 'TETRAL'  + #13#10 + 'BRKAFT';
  FBtnMainCaption[18] := 'BREAK'       + #13#10 + 'GUN-76';
  FBtnMainCaption[19] := 'BREAK'       + #13#10 + 'A244';
  FBtnMainCaption[20] := 'DESIG'       + #13#10 + 'EXOCET';
  FBtnMainCaption[21] := ' '       + #13#10 + '';
  FBtnMainCaption[22] := ' '   + #13#10 + '';
  FBtnMainCaption[23] := ' ' + #13#10 + '';
  FBtnMainCaption[24] := ' '   + #13#10 + '';
  FBtnMainCaption[25] := 'BREAK'   + #13#10 + 'EXOCET';
  FBtnMainCaption[26] := 'STOP'   + #13#10 + 'EXO-F1';
  FBtnMainCaption[27] := 'MARK'    + #13#10 + 'SPLASH';
  FBtnMainCaption[28] := 'DELETE'   + #13#10 + 'SPLASH';
  FBtnMainCaption[29] := ' '   + #13#10 + '';
  FBtnMainCaption[30] := 'DATA'   + #13#10 + 'REQ';
  FBtnMainCaption[31] := 'MONIT'  + #13#10 + 'REQ';
  FBtnMainCaption[32] := 'CLOSE'  + #13#10 + 'CNTRL';
  FBtnMainCaption[33] := 'SEARCH' + #13#10 + 'TRACK';
  FBtnMainCaption[34] := 'TRACK'  + #13#10 + 'LABEL';
end;

procedure TfrmPDK.InitButtons;
const
  C_BTN_SEPARATOR = 7;
  C_BTN_WIDTH = 62;
  C_BTN_HEIGHT = 50;
var
  i, j,k : Integer;
//  aBtnCount : Integer;
  aTopInc : Integer;

begin

  GenerateCaption;
  GenerateNames;
//  aBtnCount := 0;
  aTopInc := 0;
  j := 0;
  k := 0;

  for I := 0 to Length(FBtnArray) - 1 do begin
    btn             := TSpeedButtonImage.Create(nil);
    btn.Parent      := frmPDK;
    btn.Width       := C_BTN_WIDTH;
    btn.Height      := C_BTN_HEIGHT;
    btn.Color       := clBlack;
    btn.Font.Color  := clYellow;
    btn.Name        := 'btn' + FBtnMainNames[i];
    btn.Caption     := FBtnMainCaption[i];
    btn.OnClick     := btnPdkClick;
    btn.Tag         := i;
    btn.Left        := C_BTN_SEPARATOR + k * (C_BTN_WIDTH + C_BTN_SEPARATOR);
    btn.Top         := C_BTN_SEPARATOR + aTopInc;
    FBtnArray[i]    := btn;
    k := k + 1;
    if ((i + 1)mod 5) = 0 then begin
      j := j + 1;
      aTopInc := C_BTN_SEPARATOR + j * (C_BTN_HEIGHT + C_BTN_SEPARATOR);
      k := 0;
    end;
    if AnsiContainsStr(FBtnArray[i].Caption, ' ') then begin
      FBtnArray[i].Enabled := False;
    end;
  end;
end;

end.
