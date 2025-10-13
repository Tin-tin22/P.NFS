unit uMainFormTorpedo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Buttons, ExtCtrls, StdCtrls;

type

  TfMainTorpedo = class(TForm)
    MainMenu1: TMainMenu;
    mnProgram1: TMenuItem;
    mnExit1: TMenuItem;
    N1: TMenuItem;
    mnOpenScenario: TMenuItem;
    ConnectServer1: TMenuItem;
    mnMultiplayer1: TMenuItem;
    mnDisconnect1: TMenuItem;
    mnView: TMenuItem;
    mnMapWindow1: TMenuItem;
    mnMapControl1: TMenuItem;
    Map1: TMenuItem;
    mnOpenGeoset1: TMenuItem;
    mnCloseGeoset: TMenuItem;
    OpenScenDialog: TOpenDialog;
    OpenDialog1: TOpenDialog;
    spbRun: TSpeedButton;
    N2: TMenuItem;
    mnDC1Tengah1: TMenuItem;
    mnTDC_1: TMenuItem;
    mniMainPanel: TMenuItem;
    mniTechnicalPanel: TMenuItem;
    N3: TMenuItem;
    mniLeftPanel: TMenuItem;
    mniBottomPanel: TMenuItem;
    mmLogs: TMemo;
    mnCloseScene: TMenuItem;
    N5: TMenuItem;
    NetSetting1: TMenuItem;
    Panel1: TPanel;

    SpeedButton1: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnExit1Click(Sender: TObject);
    procedure mnMapWindow1Click(Sender: TObject);
    procedure spbRunClick(Sender: TObject);
    procedure ConnectServer1Click(Sender: TObject);
    procedure mnDisconnect1Click(Sender: TObject);
    procedure mnOpenScenarioClick(Sender: TObject);
    procedure mnCloseSceneClick(Sender: TObject);
    procedure mnMapControl1Click(Sender: TObject);
    procedure NetSetting1Click(Sender: TObject);
    procedure mnDC1Tengah1Click(Sender: TObject);
    procedure mniTechnicalPanelClick(Sender: TObject);
    procedure mniLeftPanelClick(Sender: TObject);
    procedure mniBottomPanelClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure mniMainPanelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitializeSimulation;
    procedure FinalizeSimulation;
  end;

var
  fMainTorpedo: TfMainTorpedo;

implementation

uses
  uSimulationManager, uTOCOSManager, uMapWindow, uMapTools, ufrmNetSetting, ufTDCTengah,
  ufTDC1Kiri, ufTDC1Kanan, uSpecialForm, ClipBrd, uLibTorpedo_Singa;

{$R *.dfm}



procedure TfMainTorpedo.InitializeSimulation;
begin
  //After All other Form Created
  //enabled some button
end;

procedure TfMainTorpedo.FinalizeSimulation;
begin

  //disable some button
end;


procedure TfMainTorpedo.FormCreate(Sender: TObject);
begin
  //

end;

procedure TfMainTorpedo.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfMainTorpedo.mnExit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMainTorpedo.mnMapWindow1Click(Sender: TObject);
begin
  frmMapWindow.Show;
end;

procedure TfMainTorpedo.spbRunClick(Sender: TObject);
begin
  uSimulationManager.SimCenter.Running := (sender as TSpeedButton).Down;
end;

procedure TfMainTorpedo.ConnectServer1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.netComm.Connect(uSimulationManager.SimCenter.ServerIp,
  uSimulationManager.SimCenter.ServerPort);
end;

procedure TfMainTorpedo.mnDisconnect1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.netComm.Disconnect;
end;

procedure TfMainTorpedo.mnOpenScenarioClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName);
    uSimulationManager.SimCenter.LoadScenarioFromIniFile(OpenScenDialog.FileName);// (OpenDialog1.FileName);
    //load peta dan objects
  end;
end;

procedure TfMainTorpedo.mnCloseSceneClick(Sender: TObject);
begin
  uSimulationManager.SimCenter.Running := FALSE;
  uSimulationManager.SimCenter.UnLoadScenario;
end;

procedure TfMainTorpedo.mnMapControl1Click(Sender: TObject);
begin
  frmMapTools.Show;
end;

procedure TfMainTorpedo.NetSetting1Click(Sender: TObject);
var mr: integer;
begin
  frmNetSetting.Edit1.Text := uSimulationManager.SimCenter.ServerIp;
  frmNetSetting.Edit2.Text := uSimulationManager.SimCenter.ServerPort;

  mr := frmNetSetting.ShowModal;

  if mr = mrOk then begin
    uSimulationManager.SimCenter.ServerIp   := frmNetSetting.Edit1.Text;
    uSimulationManager.SimCenter.ServerPort := frmNetSetting.Edit2.Text;
  end;
end;

procedure TfMainTorpedo.mnDC1Tengah1Click(Sender: TObject);
begin
  uTOCOSManager.TOCOSsimCenter.TheTDC.frmTengah.Show;
end;

procedure TfMainTorpedo.mniTechnicalPanelClick(Sender: TObject);
begin
  (uTOCOSManager.TOCOSsimCenter.TheTDC as TTorpedoInterface).vTechnicalCtrlPanel.Show;
end;

procedure TfMainTorpedo.mniLeftPanelClick(Sender: TObject);
begin
  (uTOCOSManager.TOCOSsimCenter.TheTDC as TTorpedoInterface).vDisplayCtrlPanelLeft.Show;
end;

procedure TfMainTorpedo.mniMainPanelClick(Sender: TObject);
begin
  (uTOCOSManager.TOCOSsimCenter.TheTDC as TTorpedoInterface).vMainCtrlPanel.Show;
end;

procedure TfMainTorpedo.mniBottomPanelClick(Sender: TObject);
begin
 (uTOCOSManager.TOCOSsimCenter.TheTDC as TTorpedoInterface).vDisplayCtrlPanelBottom.Show;
end;

procedure TfMainTorpedo.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (Button = mbRight) and (ssCtrl in Shift)
   and (ssAlt in Shift) then begin
      if not Assigned(frmDeveloper) then
         frmDeveloper := TfrmDeveloper.Create(nil);
      frmDeveloper.Show;
   end;
end;

procedure TfMainTorpedo.SpeedButton1Click(Sender: TObject);
begin
   Clipboard.SetTextBuf(mmLogs.Lines.GetText);
end;

end.
