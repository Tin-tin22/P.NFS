program PTK;

uses
  Vcl.Forms,
  uFrmPTK in 'uFrmPTK.pas' {frmPTK},
  uThreadTimer in 'Libs\didFramework\LibBaseUtils\Counter\uThreadTimer.pas',
  uIniFilesProcs in 'Libs\didFramework\LibBaseUtils\uIniFilesProcs.pas',
  uWmiHwId in 'Libs\didFramework\LibBaseUtils\uWmiHwId.pas',
  uTCMSColors in 'Libs\libColor\uTCMSColors.pas',
  uLibEvent in 'Libs\libEvent\uLibEvent.pas',
  uBridgeSet in 'Libs\libNFS\ShareLib\LibSetting\uBridgeSet.pas',
  uCodecBase64 in 'Libs\libNFS\ShareLib\LibSetting\uCodecBase64.pas',
  uBaseService in 'Libs\libService\uBaseService.pas',
  uServiceDefinition in 'Libs\libService\uServiceDefinition.pas',
  uTCMSService in 'Libs\libService\uTCMSService.pas',
  UfrmBaseTCMS in 'Libs\libSigmaUI\UfrmBaseTCMS.pas' {frmBaseTCMS},
  uFrmLogNewPDK in 'Libs\libTDA\pdk_pk\uFrmLogNewPDK.pas' {frmLogPDK},
  uNewFrmPDK in 'Libs\libTDA\pdk_pk\uNewFrmPDK.pas' {frmMainPDK},
  uNetwork_Data_TCMS in 'Libs\NetworkTCMS\uNetwork_Data_TCMS.pas',
  uUDPDatatype in 'Libs\NetworkTCMS\NetComponent\uUDPDatatype.pas',
  uLibSettings in 'Libs\uLibSettings.pas',
  uPTKEnum in 'Libs\uPTKEnum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPTK, frmPTK);
  Application.CreateForm(TfrmLogPDK, frmLogPDK);
  Application.CreateForm(TfrmMainPDK, frmMainPDK);
  Application.Run;
end.
