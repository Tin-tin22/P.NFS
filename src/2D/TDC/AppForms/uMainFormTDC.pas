unit uMainFormTDC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Buttons, ExtCtrls, StdCtrls;

type

  TfMainTDC = class(TForm)
    MainMenu1: TMainMenu;
    mnProgram1: TMenuItem;
    mnExit1: TMenuItem;
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
    N2: TMenuItem;
    mnDC1Tengah1: TMenuItem;
    mnTDC_1: TMenuItem;
    mnDC1Kiri1: TMenuItem;
    mnDC1kanan1: TMenuItem;
    N3: TMenuItem;
    mnDC1KeyboardKiri1: TMenuItem;
    mnDC1KeyboardKanan1: TMenuItem;
    mmLogs: TMemo;
    N5: TMenuItem;
    NetSetting1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    spbConnect: TSpeedButton;
    SpeedButton2: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnExit1Click(Sender: TObject);
    procedure mnMapWindow1Click(Sender: TObject);
    procedure ConnectServer1Click(Sender: TObject);
    procedure mnDisconnect1Click(Sender: TObject);
    procedure mnMapControl1Click(Sender: TObject);
    procedure NetSetting1Click(Sender: TObject);
    procedure mnDC1Tengah1Click(Sender: TObject);
    procedure mnDC1Kiri1Click(Sender: TObject);
    procedure mnDC1kanan1Click(Sender: TObject);
    procedure mnDC1KeyboardKiri1Click(Sender: TObject);
    procedure mnDC1KeyboardKanan1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure spbConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitializeSimulation;
    procedure FinalizeSimulation;
  end;

var
  fMainTDC: TfMainTDC;

implementation

uses
  uSimulationManager, uTDCManager, uMapWindow, uMapTools, ufrmNetSetting, ufTDCTengah,
  ufTDC1Kiri, ufTDC1Kanan, uSpecialForm, ClipBrd, OverbyteIcswSocket;

{$R *.dfm}


procedure TfMainTDC.InitializeSimulation;
begin
  //After All other Form Created
  //enabled some button
end;

procedure TfMainTDC.FinalizeSimulation;
begin
  //disable some button
end;


procedure TfMainTDC.FormCreate(Sender: TObject);
begin
  //

end;

procedure TfMainTDC.FormDestroy(Sender: TObject);
begin
  //
end;
procedure TfMainTDC.mnExit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMainTDC.mnMapWindow1Click(Sender: TObject);
begin
  frmMapWindow.Show;
end;

{procedure TfMainTDC.spbRunClick(Sender: TObject);
begin
  with (sender as TSpeedButton) do begin
    uSimulationManager.SimCenter.Running := Down;
    if Down then Caption := 'Running'
    else Caption := 'Pause';
  end;

end;
}
procedure TfMainTDC.ConnectServer1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.Net_Connect;
//  uSimulationManager.SimCenter.netComm.Connect(uSimulationManager.SimCenter.ServerIp,
//  uSimulationManager.SimCenter.ServerPort);
end;

procedure TfMainTDC.mnDisconnect1Click(Sender: TObject);
begin
  uSimulationManager.SimCenter.Net_DisConnect;
//  uSimulationManager.SimCenter.netComm.Disconnect;
end;

procedure TfMainTDC.mnMapControl1Click(Sender: TObject);
begin
  frmMapTools.Show;
end;

procedure TfMainTDC.NetSetting1Click(Sender: TObject);
var mr: integer;
begin
  frmNetSetting := TfrmNetSetting.Create(nil);

  frmNetSetting.Edit1.Text := uSimulationManager.SimCenter.ServerIp;
  frmNetSetting.Edit2.Text := uSimulationManager.SimCenter.ServerPort;
//  frmNetSetting.Show;
  frmNetSetting.Left := Left + width;
  frmNetSetting.top := Top ;
//  frmNetSetting.Close;

  mr := frmNetSetting.ShowModal;

  if mr = mrOk then begin
    uSimulationManager.SimCenter.ServerIp   := frmNetSetting.Edit1.Text;
    uSimulationManager.SimCenter.ServerPort := frmNetSetting.Edit2.Text;
  end;
  frmNetSetting.Free;
end;

procedure TfMainTDC.mnDC1Tengah1Click(Sender: TObject);
begin
  uTDCManager.TDCSimCenter.TheTDC.frmTengah.Show;
end;

procedure TfMainTDC.mnDC1Kiri1Click(Sender: TObject);
begin
//  uTDCManager.TDCSimCenter.TheTDC.frmKiri.Show;
end;

procedure TfMainTDC.mnDC1kanan1Click(Sender: TObject);
begin
//  uTDCManager.TDCSimCenter.TheTDC.frmKanan.Show;

end;

procedure TfMainTDC.mnDC1KeyboardKiri1Click(Sender: TObject);
begin
//  uTDCManager.TDCSimCenter.TheTDC.frmKeyboardKiri.Show;
end;

procedure TfMainTDC.mnDC1KeyboardKanan1Click(Sender: TObject);
begin
//  uTDCManager.TDCSimCenter.TheTDC.frmKeyBoardKanan.Show;
end;

procedure TfMainTDC.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (Button = mbRight) and (ssCtrl in Shift)
   and (ssAlt in Shift) then begin
      if not Assigned(frmDeveloper) then
         frmDeveloper := TfrmDeveloper.Create(nil);
      frmDeveloper.Show;
   end;
end;

procedure TfMainTDC.SpeedButton1Click(Sender: TObject);
begin
   Clipboard.SetTextBuf(mmLogs.Lines.GetText);
end;

procedure TfMainTDC.spbConnectClick(Sender: TObject);
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

end.

