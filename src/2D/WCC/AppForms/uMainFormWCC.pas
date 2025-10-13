unit uMainFormWCC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Buttons, ExtCtrls, StdCtrls,
  uLibWCCClassNew, ufKoreksi;

type
  TfMainWCC = class(TForm)
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
    PanelKiriAtas1: TMenuItem;
    mnWCC: TMenuItem;
    PanelKiriBawah1: TMenuItem;
    PanelTengah1: TMenuItem;
    mmLogs: TMemo;
    mnCloseScene: TMenuItem;
    N5: TMenuItem;
    NetSetting1: TMenuItem;
    PanelKananAtas1: TMenuItem;
    PanelKananBawah1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnExit1Click(Sender: TObject);
    procedure mnMapWindow1Click(Sender: TObject);
    procedure mnOpenGeoset1Click(Sender: TObject);
    procedure spbRunClick(Sender: TObject);
    procedure ConnectServer1Click(Sender: TObject);
    procedure mnDisconnect1Click(Sender: TObject);
    procedure mnOpenScenarioClick(Sender: TObject);
    procedure mnCloseSceneClick(Sender: TObject);
    procedure mnMapControl1Click(Sender: TObject);
    procedure NetSetting1Click(Sender: TObject);
    procedure PanelKiriAtas1Click(Sender: TObject);
    procedure PanelKiriBawah1Click(Sender: TObject);
    procedure PanelTengah1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelKananAtas1Click(Sender: TObject);
    procedure PanelKananBawah1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WCCInterface : TGenericWCCInterface;

    procedure InitializeSimulation;
    procedure FinalizeSimulation;
  end;

var
  fMainWCC: TfMainWCC;

implementation

uses
  uSimulationManager, uMapWindow, uMapTools, ufrmNetSetting, ufWCCTengah,
  //ufWCCPanelAtas, ufWCCPanelAtas2, ufWCCPanelBawah, ufWCCPanelBawah2,
  OverbyteICSWSocket,
  uSpecialForm;

{$R *.dfm}


procedure TfMainWCC.InitializeSimulation;
begin
  //After All other Form Created
  //enabled some button
end;

procedure TfMainWCC.FinalizeSimulation;
begin
  //disable some button
end;


procedure TfMainWCC.FormCreate(Sender: TObject);
begin
  self.Left := (screen.WorkAreaWidth - self.Width) div 2 ;
  self.Top := screen.WorkAreaHeight - Self.Height;

  if Screen.MonitorCount = 2 then
  self.Top := screen.Monitors[1].Top;


end;

procedure TfMainWCC.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfMainWCC.mnExit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMainWCC.mnMapWindow1Click(Sender: TObject);
begin
  frmMapWindow.Show;
end;

procedure TfMainWCC.mnOpenGeoset1Click(Sender: TObject);
begin
//  OpenScenDialog.InitialDir := ExtractFileDir(Application.ExeName);
//  if OpenScenDialog.Execute then
//     uWCCManager.SimCenter.LoadScenarioFromIniFile(OpenScenDialog.FileName);
end;

procedure TfMainWCC.spbRunClick(Sender: TObject);
var spb : TSpeedButton;
begin
  spb := (sender as TSpeedButton);
  with uSimulationManager.SimCenter do begin
    if spb.Down then begin
       uSimulationManager.SimCenter.Net_Connect;
//       netComm.Connect(ServerIp,  ServerPort);
      if NetComm.State = wsConnected then
         spb.Caption := 'Connected';
    end
    else begin
      uSimulationManager.SimCenter.Net_DisConnect;
      //netComm.Disconnect;
      spb.Caption := 'ReConnect';
    end;
  end;

end;

{begin
  uSimulationManager.SimCenter.Running := (sender as TSpeedButton).Down;
end;
}
procedure TfMainWCC.ConnectServer1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.netComm.Connect(uSimulationManager.SimCenter.ServerIp,
     uSimulationManager.SimCenter.ServerPort);
end;

procedure TfMainWCC.mnDisconnect1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.netComm.Disconnect;
end;

procedure TfMainWCC.mnOpenScenarioClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName);
    uSimulationManager.SimCenter.LoadScenarioFromIniFile(OpenDialog1.FileName);
    //load peta dan objects
  end;

end;

procedure TfMainWCC.mnCloseSceneClick(Sender: TObject);
begin
  //uSimulationManager.SimCenter.Running := FALSE;
  uSimulationManager.SimCenter.UnLoadScenario;

end;

procedure TfMainWCC.mnMapControl1Click(Sender: TObject);
begin
  frmMapTools.Show;
end;

procedure TfMainWCC.NetSetting1Click(Sender: TObject);
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

procedure TfMainWCC.PanelKiriAtas1Click(Sender: TObject);
begin
  WCCInterface.frmWCCAtas1.Show;
end;

procedure TfMainWCC.PanelKiriBawah1Click(Sender: TObject);
begin
  WCCInterface.frmWCCBawah1.Show;
end;

procedure TfMainWCC.PanelTengah1Click(Sender: TObject);
begin
  WCCInterface.frmTengah.Show;
end;

procedure TfMainWCC.PanelKananAtas1Click(Sender: TObject);
begin
  WCCInterface.frmWCCAtas2.Show;
end;

procedure TfMainWCC.PanelKananBawah1Click(Sender: TObject);
begin
  WCCInterface.frmWCCBawah2.Show;
end;

procedure TfMainWCC.FormShow(Sender: TObject);
begin
  //matikan sweep radar
  //self.TDCInterface.WM_Radar.TimeBase.Enabled := False;
  //self.TDCInterface.WM_Radar.TimeBaseView.Visible := True;
end;

procedure TfMainWCC.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (Button = mbRight) and (ssCtrl in Shift)
   and (ssAlt in Shift) then begin
      if not Assigned(frmDeveloper) then
        frmDeveloper := TfrmDeveloper.Create(nil);

      if Assigned(frmDeveloper) then
        frmDeveloper.Show;

      WCCInterface.ModulKoreksi.Show;

   end;
end;    

end.
