program TDC_Owa;

uses
  Forms,
  ufQEK in '..\source\ufQEK.pas' {frmQEK},
  uLibTDCClass in '..\source\uLibTDCClass.pas',
  uMainQEK_Owa in 'uMainQEK_Owa.pas' {Form1},
  ufSatu in 'ufSatu.pas' {frmSatu},
  ufDua in 'ufDua.pas' {frmDua},
  ufTiga in 'ufTiga.pas' {frmTiga},
  ufEmpat in 'ufEmpat.pas' {frmEmpat},
  ufLima in 'ufLima.pas' {frmLima},
  ufEnam in 'ufEnam.pas' {frmEnam},
  ufTujuh in 'ufTujuh.pas' {frmTujuh},
  ufDelapan in 'ufDelapan.pas' {frmDelapan},
  ufSembilan in 'ufSembilan.pas' {frmSembilan};

//  ufMainRAAS in 'ufMainRAAS.pas' {fMainRaas};

{$R *.res}

begin
  Application.Initialize;
//  Application.CreateForm(TfMainRaas, fMainRaas);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSatu, frmSatu);
  Application.CreateForm(TfrmDua, frmDua);
  Application.CreateForm(TfrmTiga, frmTiga);
  Application.CreateForm(TfrmEmpat, frmEmpat);
  Application.CreateForm(TfrmLima, frmLima);
  Application.CreateForm(TfrmEnam, frmEnam);
  Application.CreateForm(TfrmTujuh, frmTujuh);
  Application.CreateForm(TfrmDelapan, frmDelapan);
  Application.CreateForm(TfrmSembilan, frmSembilan);
  Application.Run;
end.
