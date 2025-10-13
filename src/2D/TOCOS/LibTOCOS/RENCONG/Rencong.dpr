program Rencong;

uses
  Forms,
  ufWCCPanelAtas_Rencong in 'ufWCCPanelAtas_Rencong.pas' {frmWCCPanelAtas_Rencong},
  ufWCCPanelTengah_Rencong in 'ufWCCPanelTengah_Rencong.pas' {frmWCCPanelTengah_Rencong},
  ufWCCPanelBawah_Rencong in 'ufWCCPanelBawah_Rencong.pas' {frmWCCPanelBawah_Rencong},
  ufExocet in 'ufExocet.pas' {frmExocet_Rencong},
  ufIRC in 'ufIRC.pas' {frmIRC_Rencong},
  ufIFF in 'ufIFF.pas' {frmIFF_Rencong},
  ufTDC2Kanan_Rencong in 'ufTDC2Kanan_Rencong.pas' {frmTDC2Kanan_Rencong},
  ufTDC1Kanan in 'ufTDC1Kanan.pas' {frmTDC1Kanan_Rencong},
  ufTDC1Kiri_Rencong in 'ufTDC1Kiri_Rencong.pas' {frmTDC1Kiri_Rencong},
  ufTDC2Kiri_Rencong in 'ufTDC2Kiri_Rencong.pas' {frmTDC2Kiri_Rencong},
  ufTDCTengah_Rencong in 'ufTDCTengah_Rencong.pas' {frmTDCTengah_Rencong};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTDCTengah_Rencong, frmTDCTengah_Rencong);
  Application.Run;
end.
