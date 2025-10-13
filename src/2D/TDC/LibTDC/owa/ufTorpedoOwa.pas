unit ufTorpedoOwa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrWheel, StdCtrls, VrRotarySwitch, ExtCtrls,
  VrBlinkLed, Buttons, SpeedButtonImage, ImgList, VrDesign,
  uLibTDCClass;

type
  TfrmTorpOWA = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    vrISD: TVrRotarySwitch;
    vrFloor: TVrRotarySwitch;
    ilSwitch: TImageList;
    Panel1: TPanel;
    lmpISD: TVrBlinkLed;
    lmpFloor: TVrBlinkLed;
    lmpPower1: TVrBlinkLed;
    lmpPower2: TVrBlinkLed;
    lmpRunOut: TVrBlinkLed;
    lmpNoRunOut: TVrBlinkLed;
    btnRunOut: TSpeedButtonImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    vrPower: TVrRotarySwitch;
    Panel3: TPanel;
    VrBlinkLed7: TVrBlinkLed;
    Panel4: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel5: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    vrBarrelSel: TVrRotarySwitch;
    lmpStandBy: TVrBlinkLed;
    lmpReset: TVrBlinkLed;
    lmpFire: TVrBlinkLed;
    lmpBarrelReady: TVrBlinkLed;
    Label19: TLabel;
    Panel6: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    btnSbyReady: TSpeedButtonImage;
    ilSwitchRev: TImageList;
    btnInsert: TVrBitmapButton;
    procedure vrPowerChange(Sender: TObject);
    procedure btnRunOutClick(Sender: TObject);
    procedure btnSbyReadyClick(Sender: TObject);
    procedure vrISDChange(Sender: TObject);
    procedure vrFloorChange(Sender: TObject);
    procedure vrBarrelSelChange(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TorpData : TTorpData;

    IsOn : boolean;
    IsFiring : boolean;
    IsRunOut : boolean;
    IsDepthSet, IsFloorSet, IsBarrelSet, IsGyroSet : boolean;

    procedure LampOn(vr: TVrBlinkLed);
    procedure LampOff(vr: TVrBlinkLed);
  public
    { Public declarations }
    TDCInterface : TGenericTDCInterface;
  end;

//var
//  frmTorpOWA: TfrmTorpOWA;

implementation

{$R *.dfm}
uses uBaseConstan;

procedure TfrmTorpOWA.LampOn(vr: TVrBlinkLed);
begin
  vr.Palette1.High := clRed;
end;

procedure TfrmTorpOWA.LampOff(vr: TVrBlinkLed);
begin
  vr.Palette1.High := clMaroon;
end;

procedure TfrmTorpOWA.vrPowerChange(Sender: TObject);
begin
  IsOn := not IsOn;

  if IsOn then begin
    LampOn(lmpPower1);
    LampOn(lmpPower2);

    //LampOn(lmpNoRunOut);
    LampOn(lmpStandBy);

    LampOn(lmpBarrelReady);
    IsBarrelSet := IsOn;
    TorpData.BarrelID := 1;
  end
  else begin
    LampOff(lmpPower1);
    LampOff(lmpPower2);

    LampOff(lmpISD);
    LampOff(lmpFloor);
    LampOff(lmpRunOut);
    LampOff(lmpNoRunOut);
    LampOff(lmpBarrelReady);
    LampOff(lmpStandBy);
    LampOff(lmpFire);

    IsDepthSet := IsOn;
    IsFloorSet := IsOn;
    IsBarrelSet := IsOn;
    IsGyroSet := IsOn;

    TorpData.ISD := -1;
    TorpData.Floor := -1;
  end;
end;

procedure TfrmTorpOWA.btnRunOutClick(Sender: TObject);
begin
  IsRunOut := not IsRunOut;
  if IsOn then begin
    IsGyroSet := true;
    TorpData.GyroRunOut := IsRunOut;
    if IsRunOut then begin
      LampOn(lmpRunOut);
      LampOff(lmpNoRunOut);
    end
    else begin
      LampOn(lmpNoRunOut);
      LampOff(lmpRunOut);
    end;
  end;
end;

procedure TfrmTorpOWA.btnSbyReadyClick(Sender: TObject);
begin
  IsFiring := not IsFiring;
  if IsOn then begin
    if IsFiring then begin
      if IsDepthSet and IsFloorSet and IsBarrelSet and IsGyroSet then begin
        TDCInterface.LaunchTorpedo_OWA(TorpData);
        LampOn(lmpFire);
        LampOff(lmpStandBy);
      end;
    end
    else begin
      LampOn(lmpStandBy);
      LampOff(lmpFire);
    end;
  end;
end;

procedure TfrmTorpOWA.vrISDChange(Sender: TObject);
begin
  // feet
  if IsOn then begin
    case vrISD.SwitchPosition of
      1, 7: TorpData.ISD := C_Feet_To_Meter * 125;  //feet
      2, 3: TorpData.ISD := C_Feet_To_Meter * 275;  //feet
      4: TorpData.ISD := C_Feet_To_Meter * 500;    //feet
      5: TorpData.ISD := C_Feet_To_Meter * 750;    //feet
      6: TorpData.ISD := C_Feet_To_Meter * 1000;   //feet
    end;
  end;
end;

procedure TfrmTorpOWA.vrFloorChange(Sender: TObject);
begin
  // feet
  if IsOn then begin
    case vrFloor.SwitchPosition of
    1, 2, 4: TorpData.Floor := C_Feet_To_Meter * 50;    //feet
    3, 5: TorpData.Floor := C_Feet_To_Meter * 20;       //feet
    end;
  end;
end;

procedure TfrmTorpOWA.vrBarrelSelChange(Sender: TObject);
begin
  if IsOn then begin
    case vrBarrelSel.SwitchPosition of
      0: TorpData.BarrelID := 3;
      1: TorpData.BarrelID := 2;
      2: TorpData.BarrelID := 1;
      3: TorpData.BarrelID := 4;
      4: TorpData.BarrelID := 5;
      5: TorpData.BarrelID := 6;
    end;
    LampOn(lmpBarrelReady);
    IsBarrelSet := true;
  end;
end;

procedure TfrmTorpOWA.btnInsertClick(Sender: TObject);
begin
  if IsOn then begin
    if (TorpData.ISD > 0) and (TorpData.Floor > 0) then begin
      LampOn(lmpISD);
      IsDepthSet := true;
      LampOn(lmpFloor);
      IsFloorSet := true;
    end;
  end;
end;

procedure TfrmTorpOWA.FormCreate(Sender: TObject);
begin
  TorpData.GyroRunOut := IsRunOut;
end;

end.
