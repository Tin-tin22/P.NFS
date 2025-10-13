program RBU6000;

uses
  Forms,
  uMain in 'uMain.pas' {frm_Main},
  uDataModule in '..\Sharelib\AppForms\uDataModule.pas' {DataModule1: TDataModule},
  ufrmNetSetting in '..\Sharelib\AppForms\ufrmNetSetting.pas' {frmNetSetting},
  uTCPDatatype in '..\Sharelib\LibNetworks\uTCPDatatype.pas',
  uTCPClient in '..\Sharelib\LibNetworks\uTCPClient.pas',
  uBridgeSet in '..\Sharelib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in '..\Sharelib\LibSetting\uCodecBase64.pas',
  uRBU_Manager in 'uRBU_Manager.pas',
  uLibRBU in 'uLibRBU.pas',
  uFormUtil in '..\ShareLib\LibUtil\uFormUtil.pas',
  uBurjaAtas in 'frmRBU\uBurjaAtas.pas' {frmBurjaAtas},
  uBurjaBawah in 'frmRBU\uBurjaBawah.pas' {frmBurjaBawah},
  uPanelFire in 'frmRBU\uPanelFire.pas' {frmPanelFire},
  u108 in 'frmRBU\u108.pas' {frm108},
  uBaseConstan in '..\ShareLib\LibBaseSystem\uBaseConstan.pas',
  uBaseDataType in '..\ShareLib\LibBaseSystem\uBaseDataType.pas',
  uBaseFunction in '..\ShareLib\LibBaseSystem\uBaseFunction.pas',
  uSettingFormToMonitorWith_ini in '..\ShareLib\LibUtil\uSettingFormToMonitorWith_ini.pas',
  uClassDatabase in '..\ShareLib\AppForms\uClassDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

//  Application.CreateForm(TfrmBurjaAtas, frmBurjaAtas);
//  Application.CreateForm(Tfrm108, frm108);
//  Application.CreateForm(TfrmBurjaBawah, frmBurjaBawah);
     Application.CreateForm(TDataModule1, DataModule1);
  //  Application.CreateForm(TfrmNetSetting, frmNetSetting);

  RBU_MAnager  := TRBUManager.Create;
  Application.CreateForm(Tfrm_Main, frm_Main);

  Application.CreateForm(TfrmBurjaAtas, frmBurjaAtas);
  Application.CreateForm(TfrmBurjaBawah, frmBurjaBawah);
  //  Application.CreateForm(TfrmPanelFire, frmPanelFire);
  frm_Main.Left := -2000;
  Application.Run;
  RBU_MAnager.Free;
end.
