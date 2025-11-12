unit uFrmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  System.Math, System.Types, System.UITypes, RzBmpBtn, VrControls, VrWheel, Generics.Collections,
  uTCPDatatype;

type
  TLayerItem = class
    Png: TPngImage;
    LayerName : string;
    Rotate: Boolean;
  end;

  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array[0..0] of TRGBQuad;

  TForm1 = class(TForm)
    Timer1: TTimer;
    pnlMainLeft: TPanel;
    pnlMainRight: TPanel;
    ImgFrame: TImage;
    pnlMonitor: TPanel;
    pnlTop: TPanel;
    ImgPower: TImage;
    ImgKolPc: TImage;
    ImgMasterSlave: TImage;
    ImgAutoMan: TImage;
    ImgStart: TImage;
    lblKolonka: TLabel;
    lblMaster: TLabel;
    lblAuto: TLabel;
    lblStart: TLabel;
    pnlCenter: TPanel;
    pnlBottom: TPanel;
    pnlCenterLeft: TPanel;
    pnlCenterRight: TPanel;
    pnlBackgroundNum: TPanel;
    pnlMonitorMenu: TPanel;
    VrWheel1: TVrWheel;
    ImgBtnMenu: TImage;
    ImgBtnPowerMonitor: TImage;
    ImgBtnBrightnesMin: TImage;
    ImgBtnBrightnesPlus: TImage;
    ImgBtnSegitiga: TImage;
    lblKolonkaValue: TLabel;
    lblElevasiValue: TLabel;
    pnlBottomLeft: TPanel;
    pnlBottomRight: TPanel;
    edtElevasi: TEdit;
    edtTraining: TEdit;
    lblElevasi: TLabel;
    lblTraining: TLabel;
    lblTime: TLabel;
    lblDate: TLabel;
    lblTimeValue: TLabel;
    lblDateValue: TLabel;
    pnlName: TPanel;
    lblKriName: TLabel;
    lblMeriam57Name: TLabel;
    lblPanelControlName: TLabel;
    ImgBtnWarning: TImage;
    ImgBtnSetting: TImage;
    pnlMainRightLeft: TPanel;
    pnlMainRightCenter: TPanel;
    pnlMainRightRight: TPanel;
    ImgSTBYIndikator: TImage;
    ImgSTBYState: TImage;
    lblStandby: TLabel;
    lblReady: TLabel;
    lblStateReady: TLabel;
    ImgOpenBox: TImage;
    lblTembak: TLabel;
    RzBmpBtnFire: TRzBmpButton;
    imgMonitorIndikator: TImage;
    ImgMonitorPowerSymbol: TImage;
    RzBmpBtnArrowLeft: TRzBmpButton;
    RzBmpBtnArrowRight: TRzBmpButton;
    RzBmpBtnArrowUp: TRzBmpButton;
    RzBmpBtnArrowDown: TRzBmpButton;
    RzBmpBtnTraining: TRzBmpButton;
    RzBmpBtnElevasi: TRzBmpButton;
    ImgNum9: TImage;
    ImgNum8: TImage;
    ImgNum7: TImage;
    ImgNumKoma: TImage;
    ImgNumNol: TImage;
    ImgNumDel: TImage;
    ImgNum5: TImage;
    ImgNum6: TImage;
    ImgNum2: TImage;
    ImgNum3: TImage;
    ImgNum4: TImage;
    ImgNum1: TImage;
    PntBxKolonka: TPaintBox;
    PntBxElevasi: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImageStateClick(Sender: TObject);
    procedure ImgSTBYStateClick(Sender: TObject);
    procedure ImgBtnArrowClick(Sender: TObject);
    procedure ArrowBmpButtonClick(Sender: TObject);
    procedure ImgNumClick(Sender: TObject);
    procedure OnImgNumMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnImgNumMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure PntBxElevasiPaint(Sender: TObject);
    procedure PntBxKolonkaPaint(Sender: TObject);
    procedure RzBmpBtnTrainingClick(Sender: TObject);
    procedure RzBmpBtnElevasiClick(Sender: TObject);
    procedure RzBmpBtnFireClick(Sender: TObject);
    procedure RzBmpBtnFireMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzBmpBtnFireMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FLayersKolonka, FLayersElevasi: TObjectList<TLayerItem>;
    FBufferKolonka, FBufferElevasi: TBitmap;
    FAngleKolonka, FAngleElevasi: Extended;
    FAngleDirection: Integer; // +1 atau -1
    FTargetAngleKolonka, FTargetAngleElevasi: Extended;

    pCurrentScenID  : integer;
    pServer_Ip,
    pServer_Port,               //TriD_IP, TriD_Port,
    pDBServer,
    pDBProto,
    pDBName,
    pDBUser,
    pDBPass,
    pShipName,
    pClassName      : string;
    pShipID,
    pClassID        : Integer;

    procedure changeImage(DestComponent : TObject; ImgPathSrc: string);

    procedure DrawRotatePNG(PNG: TPngImage; Target: TBitmap; Angle: Extended);
    procedure DrawLayerList(LayerList: TObjectList<TLayerItem>; Target: TBitmap; Angle: Extended);

    procedure UpdateAngle;
    procedure UpdateAngleKolonka;
    procedure UpdateAngleElevasi;

    procedure UpdateAngleWithLimits(var CurrentAngle, TargetAngle: Extended; StartAngle, EndAngle, Speed: Extended);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  ulibSettings, uScriptSimM57, uBridgeSet, uDataModule, uMeriam57Manager;

procedure RotateAndDisplay(TargetImage: TImage; SourcePng: TPngImage; Angle: Extended);
var
  Dst: TPngImage;
  x, y: Integer;
  fx, fy: Double;
  CenterSrcX, CenterSrcY: Double;
  CenterDstX, CenterDstY: Double;
  cosA, sinA: Double;
  SrcX, SrcY: Integer;
  PSrc, PAlphaSrc, PDst, PAlphaDst: PByteArray;
  BufferBmp: TBitmap;
  BufferCanvas: TCanvas;
begin
  Dst := TPngImage.Create;
  BufferBmp := TBitmap.Create;
  try
    // Ukuran hasil sama persis dengan Source
    Dst.CreateBlank(COLOR_RGBALPHA, 8, SourcePng.Width, SourcePng.Height);

    CenterSrcX := SourcePng.Width / 2;
    CenterSrcY := SourcePng.Height / 2;
    CenterDstX := Dst.Width / 2;
    CenterDstY := Dst.Height / 2;

    cosA := Cos(DegToRad(Angle));
    sinA := Sin(DegToRad(Angle));

    for y := 0 to Dst.Height - 1 do
    begin
      PDst := Dst.Scanline[y];
      PAlphaDst := Dst.AlphaScanline[y];
      for x := 0 to Dst.Width - 1 do
      begin
        fx := (x - CenterDstX) * cosA + (y - CenterDstY) * sinA + CenterSrcX;
        fy := (y - CenterDstY) * cosA - (x - CenterDstX) * sinA + CenterSrcY;

        SrcX := Floor(fx);
        SrcY := Floor(fy);

        if (SrcX >= 0) and (SrcX < SourcePng.Width) and (SrcY >= 0) and (SrcY < SourcePng.Height) then
        begin
          PSrc := SourcePng.Scanline[SrcY];
          PAlphaSrc := SourcePng.AlphaScanline[SrcY];

          PDst[x * 3 + 0] := PSrc[SrcX * 3 + 0]; // Blue
          PDst[x * 3 + 1] := PSrc[SrcX * 3 + 1]; // Green
          PDst[x * 3 + 2] := PSrc[SrcX * 3 + 2]; // Red
          PAlphaDst[x] := PAlphaSrc[SrcX];       // Alpha
        end
        else
        begin
          PDst[x * 3 + 0] := 0;
          PDst[x * 3 + 1] := 0;
          PDst[x * 3 + 2] := 0;
          PAlphaDst[x] := 0;
        end;
      end;
    end;

    // Double Buffering ke TargetImage
    BufferBmp.PixelFormat := pf32bit;
    BufferBmp.Width := TargetImage.Width;
    BufferBmp.Height := TargetImage.Height;

    BufferCanvas := BufferBmp.Canvas;
    BufferCanvas.Brush.Color := clBtnFace;
    BufferCanvas.FillRect(Rect(0, 0, BufferBmp.Width, BufferBmp.Height));

    BufferCanvas.Draw(0, 0, Dst); // Posisi 0,0 karena ukuran sudah sama

    TargetImage.Picture.Bitmap.Assign(BufferBmp);

  finally
    BufferBmp.Free;
    Dst.Free;
  end;
end;

procedure TForm1.ArrowBmpButtonClick(Sender: TObject);
var
  value : double;
begin
  case (Sender as TComponent).Tag of
    0://arrow left
    begin
      value := StrToFloat(edtTraining.Text);
      value := value - 0.01;

      if value < 0 then
        value := 0;

      edtTraining.Text := FormatFloat('0.00', value);

      FTargetAngleKolonka := StrToFloatDef(edtTraining.Text, 0);
      FTargetAngleKolonka := FMod(FTargetAngleKolonka, 360);
      if FTargetAngleKolonka < 0 then
        FTargetAngleKolonka := FTargetAngleKolonka + 360;
    end;
    1://arrow right
    begin
      value := StrToFloat(edtTraining.Text);
      value := value + 0.01;
      edtTraining.Text := FormatFloat('0.00', value);

      FTargetAngleKolonka := StrToFloatDef(edtTraining.Text, 0);
      FTargetAngleKolonka := FMod(FTargetAngleKolonka, 360);
      if FTargetAngleKolonka < 0 then
        FTargetAngleKolonka := FTargetAngleKolonka + 360;
    end;
    2://arrow up
    begin
      value := StrToFloat(edtElevasi.Text);
      value := value + 0.01;
      edtElevasi.Text := FormatFloat('0.00', value);

      FTargetAngleElevasi:= StrToFloatDef(edtElevasi.Text, 0);
      FTargetAngleElevasi := FMod(FTargetAngleElevasi, 360);
      if FTargetAngleElevasi < 0 then
        FTargetAngleElevasi := FTargetAngleElevasi + 360;
    end;
    3://arrow down
    begin
      value := StrToFloat(edtElevasi.Text);
      value := value - 0.01;
      if value < 0 then
        value := 0;

      edtElevasi.Text := FormatFloat('0.00', value);

      FTargetAngleElevasi:= StrToFloatDef(edtElevasi.Text, 0);
      FTargetAngleElevasi := FMod(FTargetAngleElevasi, 360);
      if FTargetAngleElevasi < 0 then
        FTargetAngleElevasi := FTargetAngleElevasi + 360;
    end;
  end;
end;

procedure TForm1.changeImage(DestComponent: TObject; ImgPathSrc: string);
var
  PngSrc : TPngImage;
begin
  PngSrc := TPngImage.Create;
  try
    PngSrc.LoadFromFile(ImgPathSrc);

    if DestComponent is TImage then
    begin
      (DestComponent as TImage).Picture.Assign(PngSrc);
    end;
  finally
    PngSrc.Free;
  end;
end;

procedure TForm1.DrawLayerList(LayerList: TObjectList<TLayerItem>;
  Target: TBitmap; Angle: Extended);
var
  Layer: TLayerItem;
begin
  Target.Canvas.FillRect(Rect(0, 0, Target.Width, Target.Height));
  for Layer in LayerList do
  begin
    if Layer.Rotate then
      DrawRotatePNG(Layer.Png, Target, Angle)
    else
      Target.Canvas.Draw(0,0, Layer.Png);
  end;
end;

procedure TForm1.DrawRotatePNG(PNG: TPngImage; Target: TBitmap;
  Angle: Extended);
var
  Temp: TPngImage;
  x, y: Integer;
  fx, fy: Double;
  CenterX, CenterY: Double;
  cosA, sinA: Double;
  SrcX, SrcY: Integer;
  PSrc, PAlphaSrc, PDst, PAlphaDst: PByteArray;
begin
  Temp := TPngImage.Create;
  try
    Temp.CreateBlank(COLOR_RGBALPHA, 8, PNG.Width, PNG.Height);

    CenterX := PNG.Width / 2;
    CenterY := PNG.Height / 2;

    cosA := Cos(DegToRad(Angle));
    sinA := Sin(DegToRad(Angle));

    for y := 0 to Temp.Height - 1 do
    begin
      PDst := Temp.Scanline[y];
      PAlphaDst := Temp.AlphaScanline[y];
      for x := 0 to Temp.Width - 1 do
      begin
        fx := (x - CenterX) * cosA + (y - CenterY) * sinA + CenterX;
        fy := (y - CenterY) * cosA - (x - CenterX) * sinA + CenterY;

        SrcX := Floor(fx);
        SrcY := Floor(fy);

        if (SrcX >= 0) and (SrcX < PNG.Width) and (SrcY >= 0) and (SrcY < PNG.Height) then
        begin
          PSrc := PNG.Scanline[SrcY];
          PAlphaSrc := PNG.AlphaScanline[SrcY];

          PDst[x * 3 + 0] := PSrc[SrcX * 3 + 0];
          PDst[x * 3 + 1] := PSrc[SrcX * 3 + 1];
          PDst[x * 3 + 2] := PSrc[SrcX * 3 + 2];
          PAlphaDst[x] := PAlphaSrc[SrcX];
        end
        else
        begin
          PDst[x * 3 + 0] := 0;
          PDst[x * 3 + 1] := 0;
          PDst[x * 3 + 2] := 0;
          PAlphaDst[x] := 0;
        end;
      end;
    end;

    // Draw hasil rotasi langsung ke target (NO RESIZE)
    Target.Canvas.Draw(0, 0, Temp);
  finally
    Temp.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  PngSrc, PngSrcOn, PngSrcArrowLeftOff, PngSrcArrowLeftOn,
  PngSrcArrowRighttOff, PngSrcArrowRightOn,
  PngSrcArrowUpOff, PngSrcArrowUpOn,
  PngSrcArrowDownOff, PngSrcArrowDownOn : TPngImage;
  LayerKolonka, LayerElevasi: TLayerItem;
  Env_Map,
  ShipClassID,
  ShipNumber,n  : Integer;
  ShipName,
  ShipClassName,
  ShipCallSign: string;
begin
  Meriam57Manager := TMeriam57Manager.Create;

  DoubleBuffered := True;
  pnlMonitor.DoubleBuffered := True;
  pnlCenter.DoubleBuffered := True;
  pnlCenterLeft.DoubleBuffered := True;
  PntBxKolonka.ControlStyle := PntBxKolonka.ControlStyle + [csOpaque];
  PntBxElevasi.ControlStyle := PntBxElevasi.ControlStyle + [csOpaque];
  Scaled := false;

  FAngleKolonka := 0;
  FAngleElevasi := 0;

  BeginGame_M57;

  n := ParamCount ;
  if n < max_param then
  begin
    Meriam57Manager.IsStandAlone := true ;
  end;

  if not Meriam57Manager.IsStandAlone then
  begin
      InitDefault_AllConfigFromInstruktur(pServer_Ip,pServer_Port,
    pDBServer, pDBProto, pDBName, pDBUser,
    pDBPass, pShipID, pCurrentScenID);

    Meriam57Manager.CurrentScenID := pCurrentScenID;
    Meriam57Manager.Server_Ip := pServer_Ip;
    Meriam57Manager.Server_Port := pServer_Port;               //TriD_IP, TriD_Port,
    Meriam57Manager.DBServer := pDBServer;
    Meriam57Manager.DBProto := pDBProto;
    Meriam57Manager.DBName := pDBName;
    Meriam57Manager.DBUser := pDBUser;
    Meriam57Manager.DBPass := pDBPass;
    Meriam57Manager.ShipID := pShipID;
    Meriam57Manager.ClassID := pClassID;

    Meriam57Manager.ServerIp := vBridgeServer.m2D_IP;
    Meriam57Manager.ServerPort := vBridgeServer.m2D_Port;

    Meriam57Manager.InitializeSimulation;

    if DataModule1.InitZDB(vDbServer.mDBServer, vDbServer.mDBProto, vDbServer.mDBName, vDbServer.mDBUser, vDbServer.mDBPass, vDbServer.mDBPort) then
    begin
      Meriam57Manager.ShipClassID  := DataModule1.GetShipType(Meriam57Manager.ShipID, ShipClassName);
      Meriam57Manager.ShipName     := DataModule1.GetShipName(Meriam57Manager.ShipID);
      Meriam57Manager.ShipNumber := DataModule1.GetShipNoById(Meriam57Manager.ShipID);
      Meriam57Manager.ShipCallSign := DataModule1.GetShipCallsignByID(Meriam57Manager.ShipID);

      lblKriName.Caption := 'KRI ' + Meriam57Manager.ShipCallSign + '-' + IntToStr(Meriam57Manager.ShipNumber);
    end;
    Meriam57Manager.Env_Map := DataModule1.GetMapById(Meriam57Manager.CurrentScenID);

    Meriam57Manager.Get57WeaponAssigned;

    if Assigned(Meriam57Manager.AssignedWeapon) then
    begin
      FTargetAngleKolonka := Meriam57Manager.AssignedWeapon.Pos_H;
      FAngleKolonka := Meriam57Manager.AssignedWeapon.Pos_H;

      edtTraining.Text := FormatFloat('0.00', FTargetAngleKolonka);
    end;

    Meriam57Manager.Running := True;
  end;
//
//  PntBxKolonka.DoubleBuffered := True;
//  PntBxElevasi.DoubleBuffered := True;

//  FrotatingDegree := 0;
  PngSrc := TPngImage.Create;
  PngSrcOn := TPngImage.Create;

  PngSrcArrowLeftOff := TPngImage.Create;
  PngSrcArrowLeftOn := TPngImage.Create;

  PngSrcArrowRighttOff := TPngImage.Create;
  PngSrcArrowRightOn := TPngImage.Create;

  PngSrcArrowUpOff := TPngImage.Create;
  PngSrcArrowUpOn := TPngImage.Create;

  PngSrcArrowDownOff := TPngImage.Create;
  PngSrcArrowDownOn := TPngImage.Create;
  try
    PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'button_tembakOFF.png');
    PngSrcOn.LoadFromFile(vPathImageSetting.ImgPath + 'button_tembakON.png');

    //panah kiri
    PngSrcArrowLeftOff.LoadFromFile(vPathImageSetting.ImgPath + 'button_left.png');
    PngSrcArrowLeftOn.LoadFromFile(vPathImageSetting.ImgPath + 'button_left1.png');

    //panah kanan
    PngSrcArrowRighttOff.LoadFromFile(vPathImageSetting.ImgPath + 'button_right.png');
    PngSrcArrowRightOn.LoadFromFile(vPathImageSetting.ImgPath + 'button_right1.png');

    //panah atas
    PngSrcArrowUpOff.LoadFromFile(vPathImageSetting.ImgPath + 'button_up.png');
    PngSrcArrowUpOn.LoadFromFile(vPathImageSetting.ImgPath + 'button_up1.png');

    //panah bawah
    PngSrcArrowDownOff.LoadFromFile(vPathImageSetting.ImgPath + 'button_down.png');
    PngSrcArrowDownOn.LoadFromFile(vPathImageSetting.ImgPath + 'button_down1.png');

    RzBmpBtnFire.Bitmaps.Down.Assign(PngSrcOn);
    RzBmpBtnFire.Bitmaps.Up.Assign(PngSrc);

    //kiri
    RzBmpBtnArrowLeft.Bitmaps.Down.Assign(PngSrcArrowLeftOn);
    RzBmpBtnArrowLeft.Bitmaps.Up.Assign(PngSrcArrowLeftOff);

    //kanan
    RzBmpBtnArrowRight.Bitmaps.Down.Assign(PngSrcArrowRightOn);
    RzBmpBtnArrowRight.Bitmaps.Up.Assign(PngSrcArrowRighttOff);

    //up
    RzBmpBtnArrowUp.Bitmaps.Down.Assign(PngSrcArrowUpOn);
    RzBmpBtnArrowUp.Bitmaps.Up.Assign(PngSrcArrowUpOff);

    //bawah
    RzBmpBtnArrowDown.Bitmaps.Down.Assign(PngSrcArrowDownOn);
    RzBmpBtnArrowDown.Bitmaps.Up.Assign(PngSrcArrowDownOff);
  finally
    PngSrcArrowLeftOff.Free;
    PngSrcArrowLeftOn.Free;

    PngSrc.Free;
    PngSrcOn.Free;
  end;

  FLayersKolonka := TObjectList<TLayerItem>.Create(True);

  // Tambah background
  LayerKolonka := TLayerItem.Create;
  LayerKolonka.Png := TPngImage.Create;
  LayerKolonka.Png.LoadFromFile(vPathImageSetting.ImgPath + 'panel_meriam1b.png');
  LayerKolonka.Rotate := False;
  LayerKolonka.LayerName := 'Background';
  FLayersKolonka.Add(LayerKolonka);

  // Tambah rotating
  LayerKolonka := TLayerItem.Create;
  LayerKolonka.Png := TPngImage.Create;
  LayerKolonka.Png.LoadFromFile(vPathImageSetting.ImgPath + 'panel_meriam1a.png');
  LayerKolonka.Rotate := false;
  LayerKolonka.LayerName := 'Rotate Background';
  FLayersKolonka.Add(LayerKolonka);

  // Tambah overlay 1
  LayerKolonka := TLayerItem.Create;
  LayerKolonka.Png := TPngImage.Create;
  LayerKolonka.Png.LoadFromFile(vPathImageSetting.ImgPath + 'Meriam57_Bodi_Top.png');
  LayerKolonka.Rotate := false;
  LayerKolonka.LayerName := 'Body Kolonka';
  FLayersKolonka.Add(LayerKolonka);

  // Tambah overlay 2 (optional, bisa tambah lagi)
  LayerKolonka := TLayerItem.Create;
  LayerKolonka.Png := TPngImage.Create;
  LayerKolonka.Png.LoadFromFile(vPathImageSetting.ImgPath + 'Meriam57_Turret_Top.png');
  LayerKolonka.Rotate := true;
  LayerKolonka.LayerName := 'Turret Kolonka';
  FLayersKolonka.Add(LayerKolonka);

  FBufferKolonka := TBitmap.Create;
  FBufferKolonka.SetSize(FLayersKolonka[0].Png.Width, FLayersKolonka[0].Png.Height);
  FBufferKolonka.PixelFormat := pf32bit;
  FBufferKolonka.HandleType := bmDIB;
  FBufferKolonka.Canvas.Font.PixelsPerInch := 96;  // <-- WAJIB ini supaya Canvas DPI = 96


  FLayersElevasi := TObjectList<TLayerItem>.Create(True);

  // Tambah background
  LayerElevasi := TLayerItem.Create;
  LayerElevasi.Png := TPngImage.Create;
  LayerElevasi.Png.LoadFromFile(vPathImageSetting.ImgPath + 'panel_meriam2b.png');
  LayerElevasi.Rotate := False;
  LayerElevasi.LayerName := 'Background Elevasi';
  FLayersElevasi.Add(LayerElevasi);

    // Tambah backgorun blind zone
  LayerElevasi := TLayerItem.Create;
  LayerElevasi.Png := TPngImage.Create;
  LayerElevasi.Png.LoadFromFile(vPathImageSetting.ImgPath + 'panel_meriam2a.png');
  LayerElevasi.Rotate := False;
  LayerElevasi.LayerName := 'Background blind zone';
  FLayersElevasi.Add(LayerElevasi);

    // Tambah Laras layer
  LayerElevasi := TLayerItem.Create;
  LayerElevasi.Png := TPngImage.Create;
  LayerElevasi.Png.LoadFromFile(vPathImageSetting.ImgPath + 'Meriam57_Turret_Side.png');
  LayerElevasi.Rotate := true;
  LayerElevasi.LayerName := 'Laras Layer';
  FLayersElevasi.Add(LayerElevasi);

    // Tambah Body side
  LayerElevasi := TLayerItem.Create;
  LayerElevasi.Png := TPngImage.Create;
  LayerElevasi.Png.LoadFromFile(vPathImageSetting.ImgPath + 'Meriam57_Bodi_Side.png');
  LayerElevasi.Rotate := False;
  LayerElevasi.LayerName := 'Body Side';
  FLayersElevasi.Add(LayerElevasi);

  FBufferElevasi := TBitmap.Create;
  FBufferElevasi.SetSize(FLayersElevasi[0].Png.Width, FLayersElevasi[0].Png.Height);
  FBufferElevasi.PixelFormat := pf32bit;
  FBufferElevasi.HandleType := bmDIB;
  FBufferElevasi.Canvas.Font.PixelsPerInch := 96;  // <-- WAJIB ini supaya Canvas DPI = 96


  FAngleDirection := 1; // Awalnya naik
  Timer1.Interval := 100;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Meriam57Manager.FinalizeSimulation;
  Meriam57Manager.Free;

  FLayersElevasi.Free;
  FBufferElevasi.Free;

  FLayersKolonka.Free;
  FBufferKolonka.Free;
end;

procedure TForm1.ImageStateClick(Sender: TObject);
var
  PngSrc: TPngImage;
begin
  PngSrc := TPngImage.Create;
  try
    case TImage(Sender).Tag of
      0 : //ImgPowerOff
      begin
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'poweroff.png');
        ImgPower.Picture.Assign(PngSrc);
        ImgPower.Tag := 1;
      end;
      1 : //ImgPowerON
      begin
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'poweron.png');
        ImgPower.Picture.Assign(PngSrc);
        ImgPower.Tag := 0;
      end;
      2 : //ImgKolPc
      begin
        lblKolonka.Caption := 'PC';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'kolonka_2.png');
        ImgKolPc.Picture.Assign(PngSrc);
        ImgKolPc.Tag := 3;
      end;
      3 : //ImgKolPc
      begin
        lblKolonka.Caption := 'KOLONKA';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'kolonka_1.png');
        ImgKolPc.Picture.Assign(PngSrc);
        ImgKolPc.Tag := 2;
      end;
      4 : //ImgMasteSlave
      begin
        lblMaster.Caption := 'SLAVE';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'master_2.png');
        ImgMasterSlave.Picture.Assign(PngSrc);
        ImgMasterSlave.Tag := 5;
      end;
      5 : //ImgMasteSlave
      begin
        lblMaster.Caption := 'MASTER';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'master_1.png');
        ImgMasterSlave.Picture.Assign(PngSrc);
        ImgMasterSlave.Tag := 4;
      end;
      6 : //ImgAutoMan
      begin
        lblAuto.Caption := 'AUTO';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'manual_1.png');
        ImgAutoMan.Picture.Assign(PngSrc);
        ImgAutoMan.Tag := 7;
      end;
      7 : //ImgAutoMan
      begin
        lblAuto.Caption := 'MANUAL';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'manual_2.png');
        ImgAutoMan.Picture.Assign(PngSrc);
        ImgAutoMan.Tag := 6;
      end;
      8 : //ImgStart
      begin
        lblStart.Caption := 'OFF';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'start_1.png');
        ImgStart.Picture.Assign(PngSrc);
        ImgStart.Tag := 9;
      end;
      9 : //ImgStart
      begin
        lblStart.Caption := 'ON';
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'start_2.png');
        ImgStart.Picture.Assign(PngSrc);
        ImgStart.Tag := 8;
      end;
    end;
  finally
    PngSrc.Free;
  end;
end;

procedure TForm1.ImgBtnArrowClick(Sender: TObject);
var
  value : double;
begin
  case (Sender as TComponent).Tag of
    0://arrow left
    begin
      value := StrToFloat(edtTraining.Text);
      value := value - 0.01;
      edtTraining.Text := FormatFloat('0.00', value);
    end;
    1://arrow right
    begin
      value := StrToFloat(edtTraining.Text);
      value := value + 0.01;
      edtTraining.Text := FormatFloat('0.00', value);
    end;
    2://arrow up
    begin
      value := StrToFloat(edtElevasi.Text);
      value := value + 0.01;
      edtElevasi.Text := FormatFloat('0.00', value);
    end;
    3://arrow down
    begin
      value := StrToFloat(edtElevasi.Text);
      value := value - 0.01;
      edtElevasi.Text := FormatFloat('0.00', value);
    end;
  end;
end;


procedure TForm1.ImgNumClick(Sender: TObject);
begin
  case (Sender as TComponent).Tag of
    8:
    begin
      if (ActiveControl is TEdit) then
      begin
        keybd_event((Sender as TComponent).Tag,0,0,0);
      end;
    end;
    110:
    begin
      if (ActiveControl is TEdit) then
      begin
        keybd_event((Sender as TComponent).Tag,0,0,0);
        keybd_event(VK_END,0,0,0);
      end;
    end;
    95..105:
    begin
      if (ActiveControl is TEdit) then
      begin
        keybd_event((Sender as TComponent).Tag,0,0,0);
        keybd_event(VK_END,0,0,0);
      end;
    end;
  end;
end;

procedure TForm1.ImgSTBYStateClick(Sender: TObject);
var
  PngSrc,PngIndikator: TPngImage;
begin
  PngSrc := TPngImage.Create;
  PngIndikator := TPngImage.Create;
  try
    case (Sender as TComponent).Tag of
      10:
      begin
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'button_RDY.png');
        ImgSTBYState.Picture.Assign(PngSrc);
        ImgSTBYState.Tag := 11;

        PngIndikator.LoadFromFile(vPathImageSetting.ImgPath + 'indicator_readyON.png');
        ImgSTBYIndikator.Picture.Assign(PngIndikator);

        RzBmpBtnFire.Enabled := True;
      end;
      11:
      begin
        PngSrc.LoadFromFile(vPathImageSetting.ImgPath + 'button_STBY.png');
        ImgSTBYState.Picture.Assign(PngSrc);
        ImgSTBYState.Tag := 10;

        PngIndikator.LoadFromFile(vPathImageSetting.ImgPath + 'indicator_readyOFF.png');
        ImgSTBYIndikator.Picture.Assign(PngIndikator);

        RzBmpBtnFire.Enabled := False;
      end;
    end;
  finally
    PngSrc.Free;
    PngIndikator.Free;
  end;
end;

procedure TForm1.OnImgNumMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case (Sender as TComponent).Tag of
    8 : //numpad Del
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_DEL1.png');
    end;
    95 :
    begin

    end;
    96 : //numpad 0
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_0-1.png');
    end;
    97 :  //numpad 1
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_1-1.png');
    end;
    98:  //numpad 2
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_2-1.png');
    end;
    99 :  //numpad 3
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_3-1.png');
    end;
    100 :  //numpad 4
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_4-1.png');
    end;
    101 :  //numpad 5
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_5-1.png');
    end;
    102 :  //numpad 6
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_6-1.png');
    end;
    103 :  //numpad 7
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_7-1.png');
    end;
    104 : //numpad 8
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_8-1.png');
    end;
    105 :  //numpad 9
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_9-1.png');
    end;
    110 :  // Numpad koma
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_(,)-1.png');
    end;
  end;
end;

procedure TForm1.OnImgNumMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case (Sender as TComponent).Tag of
    8 : //numpad Del
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_DEL.png');
    end;
    95 :
    begin

    end;
    96 : //numpad 0
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_0.png');
    end;
    97 :  //numpad 1
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_1.png');
    end;
    98:  //numpad 2
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_2.png');
    end;
    99 :  //numpad 3
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_3.png');
    end;
    100 :  //numpad 4
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_4.png');
    end;
    101 :  //numpad 5
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_5.png');
    end;
    102 :  //numpad 6
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_6.png');
    end;
    103 :  //numpad 7
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_7.png');
    end;
    104 : //numpad 8
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_8.png');
    end;
    105 :  //numpad 9
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_9.png');
    end;
    110 :  // Numpad koma
    begin
      changeImage(Sender, vPathImageSetting.ImgPath + 'num_(,).png');
    end;
  end;
end;

procedure TForm1.PntBxElevasiPaint(Sender: TObject);
begin
    // Clear background → wajib agar tidak flicker
//  PntBxElevasi.Canvas.Brush.Color := clBtnFace; // atau clBtnFace
//  PntBxElevasi.Canvas.FillRect(PntBxElevasi.ClientRect);
//
//  PntBxElevasi.Canvas.Draw(0, 0, FBufferElevasi);
  if Assigned(FBufferElevasi) then
    BitBlt(PntBxElevasi.Canvas.Handle, 0, 0, FBufferElevasi.Width, FBufferElevasi.Height,
       FBufferElevasi.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TForm1.PntBxKolonkaPaint(Sender: TObject);
begin
//  PntBxKolonka.Canvas.Brush.Color := clBtnFace; // atau clBtnFace
//  PntBxKolonka.Canvas.FillRect(PntBxKolonka.ClientRect);
//
//  PntBxKolonka.Canvas.Draw(0, 0, FBufferKolonka);

  if Assigned(FBufferKolonka) then
    BitBlt(PntBxKolonka.Canvas.Handle, 0, 0, FBufferKolonka.Width, FBufferKolonka.Height,
       FBufferKolonka.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TForm1.RzBmpBtnElevasiClick(Sender: TObject);
var
  isValid : Boolean;
  RecSend : TRec3DSetWCC;

  CorrectBearing,
  CorrectElev : Double;
begin
  if (StrToFloatDef(edtElevasi.Text, 0) <= 80 ) and (StrToFloatDef(edtElevasi.Text, 0) >= 0 )then
  begin
    FTargetAngleElevasi:= StrToFloatDef(edtElevasi.Text, 0);
    FTargetAngleElevasi := FMod(FTargetAngleElevasi, 360);
    if FTargetAngleElevasi < 0 then
      FTargetAngleElevasi := FTargetAngleElevasi + 360;

    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := FTargetAngleElevasi;
    RecSend.mAutoCorrectBearing := FTargetAngleKolonka;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_ASSIGNED;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end
  else if (StrToFloatDef(edtElevasi.Text, 0) >= 350 )then
  begin
    FTargetAngleElevasi:= StrToFloatDef(edtElevasi.Text, 0);
    FTargetAngleElevasi := FMod(FTargetAngleElevasi, 360);
    if FTargetAngleElevasi < 0 then
      FTargetAngleElevasi := FTargetAngleElevasi + 360;

    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := FTargetAngleElevasi;
    RecSend.mAutoCorrectBearing := FTargetAngleKolonka;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_ASSIGNED;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end;
end;

procedure TForm1.RzBmpBtnFireClick(Sender: TObject);
var
  isValid : Boolean;
  RecSend : TRec3DSetWCC;

  CorrectBearing,
  CorrectElev : Double;
begin
  if not TryStrToFloat(edtElevasi.Text, CorrectElev) then isValid := false;
  if not TryStrToFloat(edtTraining.Text, CorrectBearing) then isValid := False;

  if isValid then
  begin
    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := CorrectElev;
    RecSend.mAutoCorrectBearing := CorrectBearing;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_F;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end;
end;

procedure TForm1.RzBmpBtnFireMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  isValid : Boolean;
  RecSend : TRec3DSetWCC;

  CorrectBearing,
  CorrectElev : Double;
begin
  if not TryStrToFloat(edtElevasi.Text, CorrectElev) then isValid := false;
  if not TryStrToFloat(edtTraining.Text, CorrectBearing) then isValid := False;

  if isValid then
  begin
    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := CorrectElev;
    RecSend.mAutoCorrectBearing := CorrectBearing;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_START_F;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end;
end;

procedure TForm1.RzBmpBtnFireMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  isValid : Boolean;
  RecSend : TRec3DSetWCC;

  CorrectBearing,
  CorrectElev : Double;
begin
  if not TryStrToFloat(edtElevasi.Text, CorrectElev) then isValid := false;
  if not TryStrToFloat(edtTraining.Text, CorrectBearing) then isValid := False;

  if isValid then
  begin
    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := CorrectElev;
    RecSend.mAutoCorrectBearing := CorrectBearing;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_STOP_F;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end;
end;

procedure TForm1.RzBmpBtnTrainingClick(Sender: TObject);
var
  isValid : Boolean;
  RecSend : TRec3DSetWCC;
begin
  if (StrToFloatDef(edtTraining.Text, 0) < Meriam57Manager.AssignedWeapon.ENDANGLE ) and (StrToFloatDef(edtTraining.Text, 0) > Meriam57Manager.AssignedWeapon.STARTANGLE )then
  begin
    FTargetAngleKolonka := StrToFloatDef(edtTraining.Text, 0);
    FTargetAngleKolonka := FMod(FTargetAngleKolonka, 360);
    if FTargetAngleKolonka < 0 then
      FTargetAngleKolonka := FTargetAngleKolonka + 360;

    RecSend.ShipID          := Meriam57Manager.ShipID;
    RecSend.mWeaponID       := Meriam57Manager.AssignedWeapon.IDWeapon;
    RecSend.mLauncherID     := 0;
    RecSend.mMissileID      := 0;
    RecSend.mMissileNumber  := 0;
    RecSend.mOrderID        := 0;

    RecSend.mUpDown             := 0;
    RecSend.mTargetID           := 0;
    RecSend.mModeID             := 0;
    RecSend.mAutoCorrectElev    := FTargetAngleElevasi;
    RecSend.mAutoCorrectBearing := FTargetAngleKolonka;

    RecSend.mBalistikID         := 0;
    RecSend.mSalvoRate          := 30;


    RecSend.mOrderID := __ORD_CANNON_ASSIGNED;
    Meriam57Manager.NetSendTo3D_OrderCannon(RecSend);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  PngSrc, PngSrc2: TPngImage;
begin
    UpdateAngle;
    DrawLayerList(FLayersKolonka, FBufferKolonka, FAngleKolonka);
    DrawLayerList(FLayersElevasi, FBufferElevasi, FAngleElevasi);

    PntBxKolonka.Repaint;
    PntBxElevasi.Repaint;

    lblKolonkaValue.Caption := FormatFloat('0.00', FAngleKolonka);
    lblElevasiValue.Caption := FormatFloat('0.00', FAngleElevasi);

    lblTimeValue.Caption := FormatDateTime('hh:nn:ss',now);
    lblDateValue.Caption := FormatDateTime('dd-mm-yyyy',now);
end;

procedure TForm1.UpdateAngle;
begin
  if Assigned(Meriam57Manager.AssignedWeapon) then
  begin
    UpdateAngleWithLimits(
      FAngleKolonka,
      FTargetAngleKolonka,
      Meriam57Manager.AssignedWeapon.STARTANGLE,
      Meriam57Manager.AssignedWeapon.ENDANGLE,
      1.0 // Speed
    );
  end
  else
    UpdateAngleKolonka;

  UpdateAngleElevasi;
end;

procedure TForm1.UpdateAngleElevasi;
var
  Delta: Extended;
  Speed: Extended;
begin
  Speed := 1; // Kecepatan rotasi per tick (bisa ubah sesuai keinginan)

  // Hitung delta arah terpendek
  Delta := FTargetAngleElevasi - FAngleElevasi;

  if Delta > 180 then
    Delta := Delta - 360
  else if Delta < -180 then
    Delta := Delta + 360;

  // Jika sudah dekat, langsung set supaya tidak jitter
  if Abs(Delta) <= Speed then
  begin
    FAngleElevasi := FTargetAngleElevasi;
  end
  else
  begin
    // Update arah putar
    if Delta > 0 then
      FAngleElevasi := FAngleElevasi + Speed
    else
      FAngleElevasi := FAngleElevasi - Speed;
  end;

  // Normalisasi FAngle supaya tetap 0..360
  if FAngleElevasi < 0 then
    FAngleElevasi := FAngleElevasi + 360
  else if FAngleElevasi >= 360 then
    FAngleElevasi := FAngleElevasi - 360;
end;

procedure TForm1.UpdateAngleKolonka;
var
  Delta: Extended;
  Speed: Extended;
begin
  Speed := 1; // Kecepatan rotasi per tick (bisa ubah sesuai keinginan)

  // Hitung delta arah terpendek
  Delta := FTargetAngleKolonka - FAngleKolonka;

  if Delta > 180 then
    Delta := Delta - 360
  else if Delta < -180 then
    Delta := Delta + 360;

  // Jika sudah dekat, langsung set supaya tidak jitter
  if Abs(Delta) <= Speed then
  begin
    FAngleKolonka := FTargetAngleKolonka;
  end
  else
  begin
    // Update arah putar
    if Delta > 0 then
      FAngleKolonka := FAngleKolonka + Speed
    else
      FAngleKolonka := FAngleKolonka - Speed;
  end;

  // Normalisasi FAngle supaya tetap 0..360
  if FAngleKolonka < 0 then
    FAngleKolonka := FAngleKolonka + 360
  else if FAngleKolonka >= 360 then
    FAngleKolonka := FAngleKolonka - 360;
end;

procedure TForm1.UpdateAngleWithLimits(var CurrentAngle, TargetAngle: Extended;
  StartAngle, EndAngle, Speed: Extended);
var
  DirCW: Boolean;
  NextAngle, Target, StartA, EndA: Extended;

  function Normalize(Angle: Extended): Extended;
  begin
    while Angle < 0 do Angle := Angle + 360;
    while Angle >= 360 do Angle := Angle - 360;
    Result := Angle;
  end;

  function IsInRange(Value, StartA, EndA: Extended): Boolean;
  begin
    Value := Normalize(Value);
    StartA := Normalize(StartA);
    EndA := Normalize(EndA);

    if StartA <= EndA then
      Result := (Value >= StartA) and (Value <= EndA)
    else
      Result := (Value >= StartA) or (Value <= EndA);
  end;

begin
  CurrentAngle := Normalize(CurrentAngle);
  Target := Normalize(TargetAngle);
  StartA := Normalize(StartAngle);
  EndA := Normalize(EndAngle);

  // Jika target di luar batas area, maka tidak rotasi
  if not IsInRange(Target, StartA, EndA) then
    Exit;

  // Rotasi berdasarkan arah, bukan jalur terpendek
  if Target > CurrentAngle then
    DirCW := True
  else if Target < CurrentAngle then
    DirCW := False
  else
    Exit; // Sudah sama

  // Hitung next angle
  if DirCW then
    NextAngle := Normalize(CurrentAngle + Speed)
  else
    NextAngle := Normalize(CurrentAngle - Speed);

  // Kalau next angle melebihi target, langsung ke target
  if (DirCW and (NextAngle > Target)) or
     (not DirCW and (NextAngle < Target)) then
    NextAngle := Target;

  // Cek apakah nextAngle masih di dalam range yang diizinkan
  if IsInRange(NextAngle, StartA, EndA) then
    CurrentAngle := NextAngle;
end;

end.
