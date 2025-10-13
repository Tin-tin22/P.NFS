unit uRBU_Manager;

interface
uses
   Forms,
   Graphics,
   Classes,

//------------------------------------------------------------------------------
   uLibRBU,
   u108,
   uBurjaAtas,
   uBurjaBawah,
   uPanelFire,

   uTCPDatatype,
   uTCPClient,

   ufrmNetSetting,

   uBridgeSet,
   uCodecBase64,
   uBaseFunction,
   uBaseConstan;

type

   TRBUManager = class
   private
     procedure GetAsrocWeaponAssigned;
   protected
     constructor Create;
     destructor Destroy; override;

   public
     frm108Kiri       : Tfrm108;
     frm108Kanan      : Tfrm108;
     frmTopBurja      : TfrmBurjaAtas;
     frmBottomBurja   : TfrmBurjaBawah;
     frmPanelFire     : TfrmPanelFire;

     frmNet           : TfrmNetSetting;
     Datcom           : TTCPClient;
     Logmemo          : TStrings;
     StandAloneMode   : Boolean;
     pCurrentScenID   : integer;

     pServer_Ip,pServer_Port,
     pDBServer, pDBProto, pDBName, pDBUser, pDBPass,
     pShipName, pClassName : string;
     pShipID, pClassID : Integer;
     OffX_Map, OffY_Map: Double;
     // Weapon Assigned

     IsSonarTracked : Boolean;
     procedure BeginSimulation;
     procedure EndSimulation;
     procedure Initialize;
     procedure CreateObjek;
     procedure SetLayOutForm;

     procedure FrmNetShow;
     procedure Net_Connect;
     procedure Net_DisConnect;
     procedure EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
     procedure EventOnReceive3DOrder(apRec: PAnsiChar; aSize: integer);
     procedure EventOnReceiveSonarMode(apRec: PAnsiChar; aSize: integer);
     procedure Event_RcvRBUSetting(apRec: PAnsiChar; aSize: integer);
//     function  ReadValConsoleSetting(val : integer): Boolean;
     procedure AddToMemoLog(const str: string);
     procedure SendEvenRBU(EvenId: Word; const Prm1 :double = 0; Prm2 : double = 0; Prm3: double = 0);

   end;
var
  RBU_MAnager  : TRBUManager;

implementation
uses
  uFormUtil, Windows, SysUtils, Controls, Dialogs, uMain, uDataModule,
  uClassDatabase, uSettingFormToMonitorWith_ini;

procedure TRBUManager.BeginSimulation;
var
  str : string;
begin
   CreateObjek;
   SetLayOutForm;
   Initialize;

   Datcom.RegisterProcedure(
      REC_3D_POSITION, EventOnReceiveDataPosition , SizeOf(TRecData3DPosition));

   Datcom.RegisterProcedure(
      REC_3D_MISSILEPOS, EventOnReceive3DOrder , SizeOf(TRec3DMissilePos));

   Datcom.RegisterProcedure(
      REC_SET_RBU, nil, SizeOf(TRec3DSetRBU));

   Datcom.RegisterProcedure(
      REC_EVENT_LOG, nil, SizeOf(TRecEventLog));

   Datcom.RegisterProcedure(
       RecRBU_SonarMode_ORDER, EventOnReceiveSonarMode, SizeOf(TRecRBU_SonarMode));

   Datcom.RegisterProcedure(REC_STAT_ORDER_CONSOLE, Event_RcvRBUSetting , sizeof(TRecStatus_Console));

   Datcom.setLog(TStringList(frm_Main.mmo1.Lines));

   if not StandAloneMode then
   Net_Connect;

end;

procedure TRBUManager.EndSimulation;
begin
  RBU_MAnager.Free;
end;

{ TRBUManager }

constructor TRBUManager.Create;
begin
//  inherited;
  IsSonarTracked  := False;

end;

procedure TRBUManager.CreateObjek;
var i :Integer;
begin
   Datcom  := TTCPClient.Create;

   Datcom.setLog(TStringList(Logmemo));

   OwnShip     := TShipRBU.Create;
   TargetShip  := TShipRBU.Create;
   TargetID    := 0;
   frmPanelFire    := TfrmPanelFire.Create(nil);

   frmTopBurja      := TfrmBurjaAtas.Create(nil);
   frmBottomBurja   := TfrmBurjaBawah.Create(nil);

   frm108Kiri       := Tfrm108.Create(nil);
   frm108Kiri.Caption:='Kiri';
   frm108Kiri.Name := 'frm108Kiri';
   frm108Kiri.unitform := '108 Kiri ';


   frm108Kanan      := Tfrm108.Create(nil);
   frm108Kanan.Caption:='Kanan';
   frm108Kanan.Name := 'frm108Kanan';
   frm108Kanan.unitform := '108 Kanan ';

   for i := 1 to  12 do begin

       ListMissileR[i] := TRecMissile.Create;
       ListMissileR[i].Launcher := 1;
       ListMissileR[i].Missile := i;
       ListMissileR[i].Available := False;
       ListMissileR[i].Condition := True;

       ListMissileL[i] := TRecMissile.Create;
       ListMissileL[i].Launcher := 2;
       ListMissileL[i].Missile := i;
       ListMissileL[i].Available := False;
       ListMissileL[i].Condition := True;
   end;

   frmPanelFire.Left := frm108Kiri.Width - frmPanelFire.Width - 10;
   frmPanelFire.Top  := 0;

   if Assigned (frmTopBurja) then frmTopBurja.Show;
   if Assigned (frmBottomBurja) then frmBottomBurja.Show;
   if Assigned (frm108Kiri) then frm108Kiri.Hide;
   if Assigned (frm108Kanan) then frm108Kanan.Hide;
   if Assigned (frmPanelFire) then frmPanelFire.Hide;

end;

destructor TRBUManager.Destroy;
begin
 //inherited;
     frm108Kiri.Free;
     frm108Kanan.Free;
     frmTopBurja.Free;
     frmBottomBurja.Free;
     frmPanelFire.Free;

     frmNet.Free;
     Datcom.Free;

     FreeAndNil(OwnShip);
     FreeAndNil(TargetShip);

end;

procedure TRBUManager.Initialize;
var
  Env_Map, ShipClassID,n : integer ;
  ShipName,ShipClassName, str  : string ;

begin
  n := ParamCount ;
  if n < max_param then
    StandAloneMode := true
  else
  begin
    StandAloneMode := false ;
    InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser,pDBPass, pShipID, pCurrentScenID );

    if DataModule1.InitZDB(pDBServer, pDBProto, pDBName, pDBUser, pDBPass) then
    begin
        ShipClassID  := DataModule1.GetShipType(pShipID, ShipClassName);
        ShipName     := DataModule1.GetShipName(pShipID);

        Datcom.Log.Add(' ShipID      = ' + IntToStr(pShipID) );
        Datcom.Log.Add(' ShipClassId = ' + IntToStr(ShipClassID) );
        Datcom.Log.Add(' ShipName ' + ShipName );
        Datcom.Log.Add(' ShipClassName ' + ShipClassName );
    end;

    Env_Map := DataModule1.GetMapById(pCurrentScenID);
    DataModule1.GetOffsetMapByEnvMap(Env_Map ,OffX_Map, OffY_Map);
 //    GetAsrocWeaponAssigned;
  end;

  stLEFT_UNFORMER1  := True;
  stLEFT_UNFORMER2  := True;
  stRIGHT_UNFORMER1 := True;
  stRIGHT_UNFORMER2 := True;

end;

procedure TRBUManager.GetAsrocWeaponAssigned;
var WeaponAssigned : TScenarioWeapon;
    ListWeaponAssigned : TList;
    I : Integer;
begin
 ListWeaponAssigned := TList.Create;
 if DataModule1.GetListWeaponOnShipBySceID( pCurrentScenID , pShipID, ListWeaponAssigned) > 0 then
 begin
   for i := 0 to ListWeaponAssigned.Count - 1 do begin
     WeaponAssigned := TScenarioWeapon.Create;
     WeaponAssigned := TScenarioWeapon(ListWeaponAssigned.Items[i]);
     if WeaponAssigned.WeaponID = C_DBID_RBU6000 then begin
       case WeaponAssigned.LauncherID of
         1 : begin
               Lonch1.Enabled := True;
             end;
         2 : begin
               Lonch2.Enabled := True;
             end;
       end;
     end;
     WeaponAssigned.Free;
   end;
 end;
  ListWeaponAssigned.Free;

  if Lonch1.Enabled then
    Datcom.Log.Add('Lonc1 is assigned')
  else
    Datcom.Log.Add('Lonc1 is not assigned');

  if Lonch2.Enabled then
    Datcom.Log.Add('Lonc2 is assigned')
  else
    Datcom.Log.Add('Lonc2 is not assigned');

end;

procedure TRBUManager.FrmNetShow;
var mr: integer;
begin
  frmNetSetting := TfrmNetSetting.Create(nil);
  frmNetSetting.Edit1.Text := pServer_Ip;
  frmNetSetting.Edit2.Text := pServer_Port;
  //  frmNetSetting.Show;
  frmNetSetting.Left := 50 ;
  frmNetSetting.top := 50 ;
  //  frmNetSetting.Close;

  mr := frmNetSetting.ShowModal;

  if mr = mrOk then begin
    pServer_Ip   := frmNetSetting.Edit1.Text;
    pServer_Port := frmNetSetting.Edit2.Text;
  end;
  frmNetSetting.Free;
end;

procedure TRBUManager.Net_Connect;
begin
  Datcom.Connect(pServer_Ip,  pServer_Port);
end;

procedure TRBUManager.Net_DisConnect;
begin
  DatCom.Disconnect;
end;

procedure TRBUManager.SendEvenRBU(EvenId: Word; const Prm1 :double = 0; Prm2 : double = 0; Prm3: double = 0);
begin
  SendLogEvenConsole(Datcom, pShipID, C_DBID_RBU6000, EvenId, Prm1, Prm2, Prm3);  // Test send Log konsol
end;

procedure TRBUManager.SetLayOutForm;
var path :string;
  idxBurjaAtas, alBurjaAtas, xBurjaAtas, yBurjaAtas,
  idxBurjaBawah, alBurjaBawah, xBurjaBawah, yBurjaBawah,
  idx108Kanan, al108Kanan, x108Kanan, y108Kanan,
  idx108Kiri, al108Kiri, x108Kiri, y108Kiri,
  idxAnjungan, alAnjungan, xAnjungan, yAnjungan,
  bdrBurjaAtas, bdrBurjaBawah, bdr108, bdrAnjungan: Integer;

begin
 path := ExtractFilePath(Application.ExeName) + 'SetFormRBU6000ToMonitor.ini';

  Getsettingform(path, 'BURJAATAS',  idxBurjaAtas,  alBurjaAtas,    xBurjaAtas,  yBurjaAtas );
  Getsettingform(path, 'BURJABAWAH', idxBurjaBawah, alBurjaBawah,   xBurjaBawah, yBurjaBawah);
  Getsettingform(path, '108KANAN',   idx108Kanan,   al108Kanan,     x108Kanan,   y108Kanan  );
  Getsettingform(path, '108KIRI',    idx108Kiri,    al108Kiri,      x108Kiri,    y108Kiri   );
  Getsettingform(path, 'ANJUNGAN',   idxAnjungan,   alAnjungan,     xAnjungan,   yAnjungan  );
  Getsettingform(path, 'BORDER',     bdrBurjaAtas,  bdrBurjaBawah,  bdr108,      bdrAnjungan  );

   case Screen.MonitorCount of
     1: begin
        AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frmTopBurja));
        AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frmBottomBurja));
        AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frm108Kiri));
        AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm( frm108Kanan));

       frmPanelFire.FormStyle     := fsStayOnTop;
       frm108Kiri.BorderStyle     := TFormBorderStyle(bdr108);
       frm108Kanan.BorderStyle    := TFormBorderStyle(bdr108);
       frmTopBurja.BorderStyle    := TFormBorderStyle(bdrBurjaAtas);
       frmBottomBurja.BorderStyle := TFormBorderStyle(bdrBurjaBawah);
       frmPanelFire.BorderStyle   := TFormBorderStyle(bdrAnjungan);

     end;
     2,3: begin
       frmTopBurja.Height := 1080;
       frmTopBurja.Width := 1920;

       frmBottomBurja.Height := frmTopBurja.Height;
       frmBottomBurja.Width := frmTopBurja.Width;

       frm108Kiri.Height := frmTopBurja.Height;
       frm108Kiri.Width  := frmTopBurja.Width;

       frm108Kanan.Height := frmTopBurja.Height;
       frm108Kanan.Width := frmTopBurja.Width;


       frmBottomBurja.Height := frmTopBurja.Height;
       frmBottomBurja.Width := frmTopBurja.Width;

       frmPanelFire.Height := frmTopBurja.Height;
       frmPanelFire.Width := frmTopBurja.Width;


       frm108Kiri.BorderStyle     := TFormBorderStyle(bdr108);
       frm108Kanan.BorderStyle    := TFormBorderStyle(bdr108);
       frmTopBurja.BorderStyle    := TFormBorderStyle(bdrBurjaAtas);
       frmBottomBurja.BorderStyle := TFormBorderStyle(bdrBurjaBawah);
       frmPanelFire.BorderStyle   := TFormBorderStyle(bdrAnjungan);

       AlignFormToMonitor(idxBurjaAtas,  TAlignPos(alBurjaAtas),  xBurjaAtas,  yBurjaAtas, TForm(frmTopBurja));
       AlignFormToMonitor(idxBurjaBawah, TAlignPos(alBurjaBawah), xBurjaBawah, yBurjaBawah, TForm(frmBottomBurja));
       AlignFormToMonitor(idx108Kanan,   TAlignPos(al108Kanan),   x108Kanan,   y108Kanan, TForm(frm108Kanan));
       AlignFormToMonitor(idx108Kiri,    TAlignPos(al108Kiri),    x108Kiri,    y108Kiri, TForm(frm108Kiri));
       AlignFormToMonitor(idxAnjungan,   TAlignPos(alAnjungan),   xAnjungan,   yAnjungan, TForm(frmPanelFire));

//       AlignFormToMonitor(1, apLeftTop , 0 ,0, TForm(frmTopBurja));
//       AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frmBottomBurja));
//       AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frm108Kiri));
//       AlignFormToMonitor(0, apLeftTop , 0 ,0, TForm(frm108Kanan));
//       AlignFormToMonitor(1, apRightTop, 0 ,0, TForm(frmPanelFire));


//       frm108Kiri.btn2.Left := 1200;
//       frm108Kiri.btn108R.Left := 1200;
//       frm108Kanan.btn2.Left := 1200;
//       frm108Kanan.btn108R.Left := 1200;
//
//       frm108Kanan.btnUNFORMER1_On.Left := 1000;
//       frm108Kiri.btnUNFORMER1_On.Left := 1000;
//       frmBottomBurja.btn108R.Left := 1200;

     end;
   end;

end;

procedure TRBUManager.AddToMemoLog(const str: string);
begin
  if Assigned(LogMemo) then begin
    LogMemo.Add('  ' + str);
  end;
end;

procedure TRBUManager.EventOnReceive3DOrder(apRec: PAnsiChar; aSize: integer);
var
aRec: ^TRec3DMissilePos;
lRec : TRec3DSetRBU;

i: Integer;
isValid : Boolean;
LauncherMissile : TRecMissile;
begin
  aRec := @apRec^;

//  if aRec^.shipID <> pShipID then Exit;
//
//  case aRec^.status   of
//
//    ST_MISSILE_RUN, ST_MISSILE_DEL:
//    begin
//      if aRec^.WeaponID = C_DBID_RBU6000 then
//      begin
//        case aRec^.launcherID of
//          1 :
//          begin
//            isValid := True;
//
//            if Lonch1.OrderFire.Count > 1 then
//            begin
//              for i := 0 to Lonch1.OrderFire.Count - 1 do
//              begin
//                LauncherMissile := TRecMissile(Lonch1.OrderFire.Items[i]);
//                if i+1 = aRec^.missileID then
//                begin
//                  LauncherMissile.isLaunch := True;
//                end;
//              end;
//            end
//            else
//            begin
//              LauncherMissile := TRecMissile(Lonch1.OrderFire.Items[0]);
//              if LauncherMissile.Missile = aRec^.missileID then
//              begin
//                LauncherMissile.isLaunch := True;
//              end;
//            end;
//
//
//            for i := 0 to Lonch1.OrderFire.Count - 1 do
//            begin
//              LauncherMissile := TRecMissile(Lonch1.OrderFire.Items[i]);
//              if not LauncherMissile.isLaunch then isValid := false;
//            end;
//
//            if isValid then
//            begin
//              if Lonch1.isReadyFire then
//              begin
//                lRec.ShipID          := pShipID;
//                lRec.mWeaponID       := C_DBID_RBU6000;
//                lRec.mLauncherID     := aRec^.launcherID;
//                lRec.mMissileID      := 0;
//                lRec.mMissileNumber  := 0;
//                lRec.mCount          := 0;
//                lRec.mMissileType    := 0;
//                lRec.mTargetID       := 0;
//                lRec.mLncrBearing    := 0;
//                lRec.mLncRange       := 0;
//                lRec.mTargetDepth    := 0;
//                lRec.mCorrBearing    := 0;
//                lRec.mCorrElev       := 0;
//                lRec.OrderID         := __ORD_RBU_DEASSIGNED;
//
//                if Datcom <> nil then
//                begin
//                  Datcom.sendDataEx(REC_3D_RBU, @lRec);
//                end;
//
//                Lonch1.isReadyFire := false;
//                Lonch1.OrderFire.Clear;
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//
//
//  end;

end;

procedure  TRBUManager.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
var aRec: ^TRecData3DPosition;

begin
   aRec := @apRec^;
   aRec.X :=  aRec.X + OffX_Map;
   aRec.Y :=  aRec.Y + OffY_Map;

   AddToMemoLog(' : ' + dbID_to_UniqueID(aRec.ShipID) + Format(' %2.6f, %2.6f',[aRec.X, aRec.Y]));

   if aRec.ShipID  = pShipID then begin
    OwnShip.ShipId  := dbID_to_UniqueID(aRec.ShipID);
    OwnShip.heading := aRec.heading;
    OwnShip.speed   := aRec.speed;

    OwnShip.position.X := aRec.X;
    OwnShip.position.Y := aRec.Y;
    OwnShip.position.Z := aRec.Z;
   end;

   if IsSonarTracked  and StatusAliranBurja then begin
      if aRec.ShipID = UniqueID_To_dbID (TargetShip.ShipId) then begin
        TargetShip.heading := aRec.heading;
        TargetShip.speed   := aRec.speed;

        TargetShip.position.X := aRec.X;
        TargetShip.position.Y := aRec.Y;
        TargetShip.position.Z := aRec.Z;
      end;

      with frmTopBurja do begin
        edt_HaluSasaran.Text  := FloatToStr(TargetShip.heading);
        edt_haluKapal.Text    := FloatToStr(OwnShip.heading);
        edt_BarelSas.Text     := FloatToStr(Validate180Degree(
            CalcBearing(OwnShip.position.X, OwnShip.position.Y, TargetShip.position.X, TargetShip.position.Y) - OwnShip.heading));
        edtKecSasaran.Text    := FloatToStr(TargetShip.speed);
        edt_KecKapal.Text     := FloatToStr(OwnShip.speed);
        edtJarak.Text         := FloatToStr(
            C_NauticalMile_To_Cable * CalcRange(OwnShip.position.X, OwnShip.position.Y, TargetShip.position.X, TargetShip.position.Y));
        edt_Kedalaman.Text    := FloatToStr(Abs(TargetShip.position.Z));
      end;

//     frmPanelFire.edtJarak.Text := FloatToStr(
//            C_NauticalMile_To_Cable * CalcRange(OwnShip.position.X, OwnShip.position.Y, TargetShip.position.X, TargetShip.position.Y));

     TargetID := UniqueID_To_dbID(TargetShip.ShipId);
   end
   else begin
     TargetID := 0;
   end;
end;

procedure TRBUManager.EventOnReceiveSonarMode(apRec: PAnsiChar; aSize: integer);
  var  aRec: ^TRecRBU_SonarMode;
       lRec : TRec3DSetRBU;
       I: Integer;
       cekKondisilaucher : array [1..2] of Boolean;
begin
   aRec := @apRec^;
   if aRec^.OWN_SHIP_UID = OwnShip.ShipId then begin
      TargetShip.ShipId := aRec^.TARGET_SHIP_UID;
      IsSonarTracked    := aRec^.Mode;
      cekKondisilaucher[1] := Lonch1.Ready;
      cekKondisilaucher[2] := Lonch2.Ready;

      if IsSonarTracked then begin
        frmPanelFire.img_Automatis.Picture.LoadFromFile( path_image_panelFire  + 'Auto_indikator_on.bmp');
        frmPanelFire.img_AdaKontak.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_on.bmp');
        lRec.OrderID        := __ORD_RBU_AUTO;
        {LOG}
        SendEvenRBU(6);
      end
      else begin
        frmPanelFire.img_AdaKontak.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_off.bmp');
        frmPanelFire.img_Automatis.Picture.LoadFromFile(path_image_panelFire + 'Auto_indikator_off.bmp');
        lRec.OrderID        := __ORD_RBU_DEASSIGNED;
        {LOG}
        SendEvenRBU(7);
      end;

      for I := 1 to 2 do begin
        lRec.ShipID         := RBU_MAnager.pShipID;
        lRec.mWeaponID      := C_DBID_RBU6000;
        lRec.mMissileNumber := 0;
        lRec.mMissileType   := 2;
        lRec.mMissileID     := 0;
        lRec.mTargetID      := UniqueID_To_dbID(TargetShip.ShipId);
        lRec.mLncrBearing   := 0;
        lRec.mLncRange      := 0;
        lRec.mTargetDepth   := 0;
        lRec.mLauncherID    := I;
        if cekKondisilaucher[I] and (RBU_MAnager.Datcom <> nil) then
           RBU_MAnager.Datcom.sendDataEx(REC_3D_RBU, @lRec);
      end;
   end;
end;

procedure TRBUManager.Event_RcvRBUSetting(apRec: PAnsiChar; aSize: integer);
  var  aRec: ^TRecStatus_Console;
  Id :Integer;
begin
  aRec := @apRec^;
 if aRec.OWN_SHIP_UID  = OwnShip.ShipId then begin
   case aRec^.ErrorID of
        __STAT_RBU_BALISTIK12 : begin
          if aRec^.ParamError = __PARAM_RBU_ON then
            frmTopBurja.img_Balistik17.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_on.bmp')
          else
            frmTopBurja.img_Balistik17.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_off.bmp'); //__PARAM_BALISTIK17_OFF  = 301;
        end;
        __STAT_RBU_PERUBAHAN_HALU : begin
          if aRec^.ParamError = __PARAM_RBU_ON then
            frmTopBurja.img_Perubahan_Halu.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp')
          else
            frmTopBurja.img_Perubahan_Halu.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp'); //__PARAM_PERUBAHAN_HALU_OFF = 302;
        end;
        __STAT_RBU_BAHAYA_TPO : begin
          if aRec^.ParamError = __PARAM_RBU_ON then
            frmTopBurja.img_Bahaya_Tpo.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp')
          else
            frmTopBurja.img_Bahaya_Tpo.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp'); //__PARAM_BAHAYA_TPO_OFF = 303;
        end;
        __STAT_RBU_KONTAK_HILANG : begin
          if aRec^.ParamError = __PARAM_RBU_ON then begin
            frmTopBurja.img_KontakHilang.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp');
            frmPanelFire.img_KontakHilang.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_on.bmp');
            frmPanelFire.img_AdaKontak.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_off.bmp');
          end
          else begin
            frmTopBurja.img_KontakHilang.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp'); //__PARAM_KONTAK_HILANG_OFF = 304;
            frmPanelFire.img_KontakHilang.Picture.LoadFromFile(path_image_panelFire + 'Red_Indikator_off.bmp');
            frmPanelFire.img_AdaKontak.Picture.LoadFromFile(path_image_panelFire + 'Blue_Indikator_on.bmp');
          end;
        end;
        __STAT_RBU_ALIRAN_KAPAL : begin
          if aRec^.ParamError = __PARAM_RBU_ON then begin
            frm108Kiri.img_Aliran_Kapal.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');  //__STAT_ALIRAN_KAPAL = 305;
            frm108Kanan.img_Aliran_Kapal.Picture.LoadFromFile(path_image_108 + 'lampu indikator on.bmp');

            frm108Kiri.ShipLink_is_On := True;
            frm108Kanan.ShipLink_is_On := True;
            {LOG}
            SendEvenRBU(8);
          end
          else begin
            frm108Kiri.img_Aliran_Kapal.Picture.LoadFromFile(path_image_108  + 'lampu indikator off.bmp');
            frm108Kanan.img_Aliran_Kapal.Picture.LoadFromFile(path_image_108 + 'lampu indikator off.bmp');

            frm108Kiri.ShipLink_is_On := false;
            frm108Kanan.ShipLink_is_On := false;
            {LOG}
            SendEvenRBU(9);
          end;
        end;

        __STAT_RBU_UNFORMER_I_LEFT : begin
            stLEFT_UNFORMER1:= ReadValConsoleSetting( aRec^.ParamError);
        end;
        __STAT_RBU_UNFORMER_II_LEFT : begin
           stLEFT_UNFORMER2:= ReadValConsoleSetting( aRec^.ParamError);
        end;
        __STAT_RBU_UNFORMER_I_RIGHT : begin
            stRIGHT_UNFORMER1:= ReadValConsoleSetting( aRec^.ParamError);
        end;
        __STAT_RBU_UNFORMER_II_RIGHT : begin
           stRIGHT_UNFORMER2:= ReadValConsoleSetting( aRec^.ParamError);
        end;

        311..322 : begin
         Id :=  aRec^.ErrorID - 310;
         ListMissileR[Id].Condition := ReadValConsoleSetting( aRec^.ParamError);
        end;

        331..342 : begin
         Id :=  aRec^.ErrorID - 330;
         ListMissileL[Id].Condition := ReadValConsoleSetting( aRec^.ParamError);
        end;
   end;
 end;
end;

//function TRBUManager.ReadValConsoleSetting(val: integer): Boolean;
//begin
//  Result := False;
//  if val = 1 then
//    Result := True;
//end;

end.

