unit uLibTDC_Oswald;

interface

uses
  Forms, uLibTDCClass, ufQEK, ufMIK_Owa,  ufANDUDisplay{, DA05, RCR_radar_LW03}, uBaseConstan;

type

//==============================================================================
  TTDC_Oswald = class(TGenericTDCInterface)
  protected
    FForms : array[1..8] of TfrmQEK;

    frmMIK_Kanan : TfrmMIK_Owa;
    frmDisplay_kanan : TfrmANDUDisplay;

    procedure CreateForms_0;
    procedure CreateForms_1;
    procedure CreateForms_2;
    procedure CreateForms_3;
    procedure CreateForms_4;
  public
    fTengahBawah : TfrmQEK;
    {frmDA05      : TFrm_DA05;
    frmLW03      : TFrm_RCR_radar_LW03;}

    constructor Create;
    destructor Destroy; override;

    procedure CreateFormss(const num: byte); override;
    procedure ShowAllForm; override;
    procedure SetDefaultLayOut; override;
    procedure ShowFormBawahOWA; override;
    procedure HideFormBawahOWA; override;

    procedure DataRequest_Left(const b: byte); override;
    procedure DataRequest_right(const b: byte); override;
    procedure DR_OBM_right(const b: Boolean); override;
    procedure DR_OBM_left(const b: Boolean); override;
    procedure DR_OCM_right; override;
    procedure DR_OCM_left; override;
  end;


implementation

uses
  SysUtils, ufTDCTengah, uFormUtil,
  uLibTDCTracks,
  uTrackFunction,
  ufDisplay_OWA,
  ufTDCTengah_OWA,
  ufTDCTengahBawah_OWA,
  ufOwa_1, ufOwa_2, ufOwa_3, ufOwa_4,
  ufOwa_5, ufOwa_6, ufOwa_7, ufOwa_8;


//==============================================================================
{ TTDC_Oswald }

constructor TTDC_Oswald.Create;
const
  osw_1_caption = ' osw TDC 1';
begin
  inherited;

  frmTengah  :=  TfrmTDCTengah_OWA.Create(nil);
  frmTengah.Caption := ' KRI Oswald Siahaan';
  (frmTengah as TfrmTDCTengah).TDCInterface := self;

  fTengahBawah := TfrmTengahBawah_OWA.Create(nil);
  fTengahBawah.TDCInterface := self;

end;


destructor TTDC_Oswald.Destroy;
var i: integer;
begin
  for i := 1 to 7 do
    if Assigned(FForms[i]) then FForms[i].Free;

  {FreeAndNil(frmDA05);
  FreeAndNil(frmLW03);}
  FreeAndNil(fTengahBawah);
  FreeAndNil(frmTengah);
  inherited;
end;

procedure TTDC_Oswald.CreateFormss(const num: byte);
begin
  FForms[1] := TfrmOwa_1.Create(nil);
  FForms[1].TDCInterface := self;
  FForms[2] := TfrmOwa_2.Create(nil);
  FForms[2].TDCInterface := self;
  FForms[3] := TfrmOwa_3.Create(nil);
  FForms[3].TDCInterface := self;
  FForms[4] := TfrmOwa_4.Create(nil);
  FForms[4].TDCInterface := self;
  FForms[5] := TfrmOwa_5.Create(nil);
  FForms[5].TDCInterface := self;
  FForms[6] := TfrmOwa_6.Create(nil);
  FForms[6].TDCInterface := self;
  FForms[7] := TfrmOwa_7.Create(nil);
  FForms[7].TDCInterface := self;
  FForms[8] := TfrmOwa_8.Create(nil);
  FForms[8].TDCInterface := self;

  {frmDA05 := TFrm_DA05.Create(nil);
  frmDA05.TDCInterface := self;
  frmLW03 := TFrm_RCR_radar_LW03.Create(nil);
  frmLW03.TDCInterface := self;}

  if num = 1 then CreateForms_1
  else if num = 2 then CreateForms_2
  else if num = 3 then CreateForms_3
  else if num = 4 then CreateForms_4;
end;
//==============================================================================

procedure TTDC_Oswald.ShowAllForm;
var i: integer;
begin
  //for i := 1 to 8 do
  //  if Assigned(FForms[i]) then FForms[i].Show;

  if Assigned(frmTengah) then  frmTengah.Show;
  if Assigned(fTengahBawah) then  fTengahBawah.Show;

  if Assigned(frmMIK_Kanan )then frmMIK_Kanan.Show;
  HideFormBawahOWA;

//  if Assigned(frmMIK_Kiri     )then frmMIK_Kiri.Show;
  if Assigned(frmDisplay_kanan  )then frmDisplay_kanan.Show;
end;


procedure TTDC_Oswald.SetDefaultLayOut;
begin
  case Screen.MonitorCount of
    1 : begin
      AlignFormToMonitor(0, apCenter      , 0 , 0 , TForm(frmTengah ));
      AlignFormToMonitor(0, apCenterBottom, 0 , 0 , TForm(fTengahBawah ));

    end;
    2 : begin
      AlignFormToMonitor(0, apCenter  , 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(0, apCenterBottom      , 0 , 0 , TForm(fTengahBawah ));

      AlignFormToMonitor(1, apLeftTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(1, apLeftTop  , 0, frmDisplay_kanan.Height, TForm(frmMIK_Kanan ));
    end;
    3 : begin
      AlignFormToMonitor(1, apCenter, 0, 0, TForm(frmTengah ));
      AlignFormToMonitor(1, apCenterBottom, 0, 0, TForm(fTengahBawah ));

      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[1]));
      AlignFormToMonitor(2, apLeftBottom, 0, 0, TForm(FForms[2]));
      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[3]));
      AlignFormToMonitor(2, apLeftBottom, 0, 0, TForm(FForms[4]));

      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[5]));
      AlignFormToMonitor(2, apLeftBottom, 0, 0, TForm(FForms[6]));
      AlignFormToMonitor(0, apRightBottom,  0, 0, TForm(FForms[7]));
      AlignFormToMonitor(2, apLeftBottom, 0, 0, TForm(FForms[8]));

      AlignFormToMonitor(2, apLeftTop  , 0, 0, TForm(frmDisplay_kanan ));
      AlignFormToMonitor(2, apLeftTop  , 0, frmDisplay_kanan.Height, TForm(frmMIK_Kanan ));

      {AlignFormToMonitor(0, apRightTop,  0, 0, TForm(frmDA05));
      AlignFormToMonitor(0, apRightTop,  0, 0, TForm(frmLW03));}

    end;
  end;
end;

procedure TTDC_Oswald.ShowFormBawahOWA;
begin
  TfrmTengahBawah_OWA(fTengahBawah).setMaxPosition(TfrmTDCTengah_OWA(frmTengah));
end;

procedure TTDC_Oswald.HideFormBawahOWA;
begin
  TfrmTengahBawah_OWA(fTengahBawah).setPosition(TfrmTDCTengah_OWA(frmTengah));
end;

procedure TTDC_Oswald.CreateForms_0;
begin
  frmDisplay_kanan  := TfrmDisplay_Owa.Create(nil);
  frmDisplay_kanan.Caption := 'KRI OWA Alpha Numerik Display Unit';
  (frmDisplay_kanan as TfrmDisplay_Owa).iTDC := self;

  frmMIK_Kanan      := TfrmMIK_Owa.Create(nil);
  frmMIK_Kanan.TDCInterface := self;
  frmMIK_Kanan.OBM := OBMRight;

  frmMIK_Kanan.Display := frmDisplay_kanan;

  frmDisplay_kanan.FOnExecuteCmd :=  frmMIK_Kanan.handle_execute;
end;

procedure TTDC_Oswald.CreateForms_1;
const
  caption_1 = ' OWA HDC 1';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[7].Show;
  FForms[7].Caption          := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//    
  FForms[8].Show;
  FForms[8].Caption := caption_1 + C_Kanan;

  {frmDA05.Show;
  frmDA05.Caption := 'Panel Radar DA-05';}

//  (frmKeyBoardKanan as TfrmInjectionKeyBoard).TDCInterface := self;
//  (frmKeyBoardKiri as TfrmInjectionKeyBoard).TDCInterface := self;

end;

procedure TTDC_Oswald.CreateForms_2;
const
  caption_1 = ' OWA HDC 2';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[4].Show;
  FForms[4].Caption := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  FForms[5].Show;
  FForms[5].Caption          := caption_1 + C_Kanan;

  //frmLW03.Show;
  //frmLW03.Caption := 'Panel Radar LW-03';

//  (frmKeyBoardKanan as TfrmInjectionKeyBoard).TDCInterface := self;
//  (frmKeyBoardKiri as TfrmInjectionKeyBoard).TDCInterface := self;

end;

procedure TTDC_Oswald.CreateForms_3;
const
  caption_1 = ' OWA HDC 3';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[3].Show;
  FForms[3].Caption := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  FForms[6].Show;
  FForms[6].Caption          := caption_1 + C_Kanan;

//  (frmKeyBoardKanan as TfrmInjectionKeyBoard).TDCInterface := self;
//  (frmKeyBoardKiri as TfrmInjectionKeyBoard).TDCInterface := self;

end;

procedure TTDC_Oswald.CreateForms_4;
const
  caption_1 = ' OWA HDC 4';
begin
  inherited;
  CreateForms_0;

  //- TDC 1 Kiri  -//
  FForms[4].Show;
  FForms[4].Caption := caption_1 + C_Kiri;

  //- TDC 1 Kanan -//
  FForms[1].Show;
  FForms[1].Caption          := caption_1 + C_Kanan;

//  (frmKeyBoardKanan as TfrmInjectionKeyBoard).TDCInterface := self;
//  (frmKeyBoardKiri as TfrmInjectionKeyBoard).TDCInterface := self;

end;

procedure TTDC_Oswald.DataRequest_Left(const b: byte);
var cTrack : TTDCTrack;
    s : string;
begin
   if FindTrack_by_screenpos(OBMLeft.Center.X, OBMLeft.Center.Y, cTrack) then begin
     if cTrack is TManualTrack then begin
        // DR pertama
        if (b=1) then s := formatOWA_SCR(cTrack as TManualTrack)
        // DR kedua
        else if (b=2) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_IFF(cTrack as TManualTrack)
            else if (cTrack.Domain = tdBawahAir) then
                s := formatOWA_ACR_ESM(cTrack as TManualTrack)
            else s:= ' ';
        end
        // DR ketiga
        else if (b=3) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_ESM(cTrack as TManualTrack)
            else if (cTrack.Domain = tdBawahAir) then
                s := formatOWA_ACR_PVC(cTrack as TManualTrack)
            else s:= ' ';
        end
        // DR keempat
        else if (b=4) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_PVC(cTrack as TManualTrack)
            else s:= ' ';
        end;
     end
     else if cTrack is TESMBearingTrack then begin
        if (b=1) then formatOWA_SCR_bearing(cTrack as TESMBearingTrack)
        else if (b=2) then formatOWA_PVC_bearing(cTrack as TESMBearingTrack);
     end;

     //frmDisplay_kiri.SetDRLText(s);
  end;
end;

procedure TTDC_Oswald.DataRequest_right(const b: byte);
var cTrack:TTDCTrack;
    s : String;
begin
  if FindTrack_by_screenpos(OBMRight.Center.X, OBMRight.Center.Y, cTrack) then begin
     if cTrack is TManualTrack then begin
        // DR pertama
        if (b=1) then s := formatOWA_SCR(cTrack as TManualTrack)
        // DR kedua
        else if (b=2) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_IFF(cTrack as TManualTrack)
            else if (cTrack.Domain = tdBawahAir) then
                s := formatOWA_ACR_ESM(cTrack as TManualTrack)
            else s:= ' ';
        end
        // DR ketiga
        else if (b=3) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_ESM(cTrack as TManualTrack)
            else if (cTrack.Domain = tdBawahAir) then
                s := formatOWA_ACR_PVC(cTrack as TManualTrack)
            else s:= ' ';
        end
        // DR keempat
        else if (b=4) then begin
            if (cTrack.Domain = tdAtasAir) or (cTrack.Domain = tdUdara) then
                s := formatOWA_ACR_PVC(cTrack as TManualTrack)
            else s:= ' ';
        end;
     end
     else if cTrack is TESMBearingTrack then begin
        if (b=1) then s := formatOWA_SCR_bearing(cTrack as TESMBearingTrack)
        else if (b=2) then s := formatOWA_PVC_bearing(cTrack as TESMBearingTrack)
        else  s:= ' ';
     end;

     frmDisplay_kanan.SetDRLText(s);
  end;
end;

procedure TTDC_Oswald.DR_OBM_right(const b: Boolean);
var s       :String;
    cIdent  :Char;
    dX,dY   :Double;
begin
  if b then begin
    if initiateSurfaceGrid(xSHIP.PositionX,xSHIP.PositionY) then begin
      s := ' ';
    end;

    SGO.ConvertLatLongToSGO(OBMRight.mPos.X,OBMRight.mPos.Y,cIdent,dX,dY);
    s := formatDR_OBM(OBMRight.mPos.X,OBMRight.mPos.Y,cIdent,dX,dY);
    frmDisplay_kanan.SetDRLText(s);
  end
  else begin
    frmDisplay_kanan.SetDRLText('');
  end;
end;

procedure TTDC_Oswald.DR_OBM_left(const b: Boolean);
var s       :String;
    cIdent  :Char;
    dX,dY   :Double;
begin
  if b then begin
    if initiateSurfaceGrid(xSHIP.PositionX,xSHIP.PositionY) then begin
      s := ' ';
    end;

    SGO.ConvertLatLongToSGO(OBMLeft.mPos.X,OBMLeft.mPos.Y,cIdent,dX,dY);
    s := formatDR_OBM(OBMLeft.mPos.X,OBMLeft.mPos.Y,cIdent,dX,dY);
    //frmDisplay_kanan.SetDRLText(s);
  end
  else begin
    //frmDisplay_kanan.SetDRLText('');
  end;
end;

procedure TTDC_Oswald.DR_OCM_right;
var s:String;
begin
  s := formatDR_OCM(Cursorss.Heading,Cursorss.Distance * C_NM_To_DM);
  frmDisplay_kanan.SetDRLText(s);
end;

procedure TTDC_Oswald.DR_OCM_left;
begin
end;

end.
