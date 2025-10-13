unit ufListScenario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,

  uDataModule, uClassDatabase, uQuery, uGlobalVar, uInstrukturManager,
  uEventConector, uBridgeSet, AdvSmoothButton, ExtCtrls;
type
  TfrmListScenario = class(TForm)
    lvListScen: TListView;
    pnlBottom: TPanel;
    btnRemove: TAdvSmoothButton;
    btnOk: TAdvSmoothButton;
    btnClose: TAdvSmoothButton;
    edtGameName: TEdit;
    lblGameName: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure edtGameNameChange(Sender: TObject);
    procedure lvListScenClick(Sender: TObject);
    procedure edtGameNameKeyPress(Sender: TObject; var Key: Char);
    procedure lvListScenKeyPress(Sender: TObject; var Key: Char);
  private
    procedure ConnectInstrukturTo3D(m3DServerIP, m3DServerPort: string);
    { Private declarations }
  public
    isPlay : Boolean;

    CurrentConsole3DServerAddress : string;
    procedure ShowScenario;
    { Public declarations }
  end;

var
  frmListScenario: TfrmListScenario;

implementation

uses ufScenarioEdit, uMainInstruktur, u3DController, uControllBellLampu,
  uController, uReplayControl;

{$R *.dfm}

const
  c_launched  = 'RUNNING';
  c_idle      = 'ONLINE';
  c_offline   = 'OFFLINE';

  idx_cub   = 0;
  idx_name  = 1;
  idx_type  = 2;
  idx_ip    = 3;
  idx_st    = 4;

procedure TfrmListScenario.btnCloseClick(Sender: TObject);
begin
  frmSceEditor.isNew := True;
  Close;
end;

procedure TfrmListScenario.btnOkClick(Sender: TObject);
var
  xOff, yOff: double;
  i, j: integer;
  li: TListItem;
  cAddress: string;
  c_data: tDataApplication;

  AllShip : TShip;
  listAllShip : Tlist;

  listConsole : TList;
  Console : TConsole;
  Console_ID : Integer;
  cekGameName : boolean;
begin
  case TButton(sender).Tag of
    0 : begin
          if lvListScen.Selected <> nil then
          begin
            frmSceEditor.Scenario_ID  := StrToInt(lvListScen.Selected.Caption);
            frmSceEditor.ScenarioName := lvListScen.Selected.SubItems[0];

            frmSceEditor.isNew := false;
            frmSceEditor.UpdateVisualForm;

            if isPlay then
              vController.ScenarioPlay1.Enabled := false;

            Close;
          end
          else
          begin
            ShowMessage('Select Scenario First');
          end;
        end;
    1 : begin
           if lvListScen.Selected <> nil then
           begin

             CurrentScenarioID := StrToInt(lvListScen.Selected.Caption);
             fMainInstr.Caption := 'I n s t r u k t u r'+' - '+ lvListScen.Selected.SubItems[0];
             IDGame := DataModule1.GetGameID(CurrentScenarioID);
             cekGameName := DataModule1.GameNameAlreadyExist(edtGameName.Text);
             if cekGameName then
             begin
               ShowMessage(QuotedStr(edtGameName.Text)+' is Already Exist');
               exit;
             end;

             GameName := edtGameName.Text;

             //send game name...
             NetSendGameName(GameName);

             if CurrentScenarioID > 0 then
             begin
                //Not Ready
                //DataModule1.DeleteDefaultScenario;
                //DataModule1.FillListDefaultScenario(CurrentScenarioID);

                fMainInstr.AutoConnect.PathSceID := IntToStr(CurrentScenarioID);
                fMainInstr.AutoConnect.Save;

                SimManager.ServerIp := CurrentConsole3DServerAddress;
                //ServerSendLaunchCommand(CurrentConsole3DServerAddress);
                InstrukturSendLaunchAllCommand;

                SetSceneOffSetFromID(CurrentScenarioID, xOff, yOff);
                instMapSet.useOffset := true;
                instMapSet.xOffset := xOff;
                instMapSet.yOffset := yOff;
                instMapSet.xCenter := xOff;
                instMapSet.yCenter := yOff;

                fMainInstr.Map.ZoomTo(fMainInstr.Map.Zoom, xOff, yOff);
                CurrentXOffset := xOff;
                CurrentYOffset := yOff;

                {cendol semenrtara}
                //SimManager.Net_DisConnect;
                ConnectInstrukturTo3D(CurrentConsole3DServerAddress, default3DServerPort);

                if frm3DController <> nil then begin
                  frm3DController.Close;
                  frm3DController.Clear;

                  frm3DController.Populate(SimManager.MainObjList.GetList);
                  SimManager.MainObjList.ReturnList;
                end;

                if vControllBellLampu <> nil then begin
                  vControllBellLampu.Close;
                  vControllBellLampu.Clear;

                  vControllBellLampu.Populate(SimManager.MainObjList.GetList);
                  SimManager.MainObjList.ReturnList;
                end;

                //ConnectInstrukturTo3D(CurrentConsole3DServerAddress, default3DServerPort);
                ConnectInstrukturTo3D(bridgeSet.mServer.m2D_IP , bridgeSet.mServer.m2D_Port);

                {cendol semenrtara}
                //Server3DIsOnline := C_SERVER3D_RUNNING ;

                vController.Update3DServerControls ;
                vController.UpdateListView(CurrentScenarioID);

                isDatabaseMode := False;

                /// ceck list client status
                for i := 0 to vController.listClient.Items.Count - 1 do begin
                  li := vController.listClient.Items.Item[i];
                  if li <> nil then begin
                    cAddress := li.SubItems[idx_ip];
                    c_data := GetPCConfigFromIPAddress(cAddress);
                    if c_data.c_app_tipe = APP_3D_Server then begin
                      li.SubItems[idx_st] := c_launched ;
                      Break;
                    end;
                  end;
                end;

                vController.ePort.ItemIndex := DataModule1.GetPortIDfromSceID(CurrentScenarioID);
             end;

             Close;
           end
           else
              ShowMessage('Select Scenario First');
        end;
  end;
end;

procedure TfrmListScenario.btnRemoveClick(Sender: TObject);
var
  id : Integer;
begin
  if lvListScen.Selected <> nil then
  begin
    id :=  StrToInt(lvListScen.Selected.Caption);
    DataModule1.DeleteScenario(id);
  end
  else
    ShowMessage('Select Scenario First');

  ShowScenario;
end;

procedure TfrmListScenario.ConnectInstrukturTo3D(m3DServerIP,
  m3DServerPort: string);
begin
  if frmReplayControl.Showing then frmReplayControl.Close;

  SimManager.ClearAllObjects;
  SimManager.ServerIp   := m3DServerIP;
  SimManager.ServerPort := m3DServerPort;

  SimManager.Net_Connect;
end;

procedure TfrmListScenario.FormShow(Sender: TObject);
begin
  ShowScenario;

  //Cendol Dulu By Nando...eheheh
//  if isPlay then
//  begin
//    btnOk.Caption := 'Ok';
//    btnOk.Tag := 0;
//
//    btnRemove.Visible := False;
//  end
//  else
//  begin
//    btnOk.Caption := 'Play';
//    btnOk.Tag := 1;
//
//    btnRemove.Visible := True;
//  end;
end;

procedure TfrmListScenario.ShowScenario;
var
  i : integer;
  ListScenario : Tlist;
  Scenario : TScenarioList;
begin
  edtGameName.Text:=''; 
  lvListScen.Items.Clear;

  ListScenario := TList.Create;
  DataModule1.GettAllScenario(ListScenario);

  for i := 0 to ListScenario.Count - 1 do
  begin
    Scenario := TScenarioList(ListScenario[i]);

    if Scenario.Scenario_ID = 0 then Continue;

    with lvListScen.Items.Add do
    begin
      Caption := IntToStr(Scenario.Scenario_ID);
      SubItems.Add(Scenario.Scenario_Name);
      SubItems.Add(DataModule1.GetPortNameNoById(Scenario.ENV_PETA));


      if Scenario.ENV_PETA = 0 then

      else
      if Scenario.ENV_PETA = 1 then
        SubItems.Add('Jakarta')
      else
      if Scenario.ENV_PETA = 2 then
        SubItems.Add('Laut Lepas')
      else
      if Scenario.ENV_PETA = 3 then
        SubItems.Add('BalikPapan')
      else
      if Scenario.ENV_PETA = 4 then
      begin
        SubItems.Add('Medan')
      end;
    end;
  end;
end;

procedure TfrmListScenario.edtGameNameChange(Sender: TObject);
begin
  if (Length(edtGameName.Text) > 0) then
    btnOk.Enabled := True
  else
    btnOk.Enabled := False;
end;

procedure TfrmListScenario.lvListScenClick(Sender: TObject);
var
  aDateTime : TDatetime;
  formatDate : string;
begin
  aDateTime := Now;
  DateTimeToString(formatDate, 'ddmmyy_hhnnss', aDateTime);
  edtGameName.Text := lvListScen.Selected.SubItems[0]+'_'+formatDate;

  //btnOk.SetFocus;
end;

procedure TfrmListScenario.edtGameNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btnOkClick(sender);
  end;
end;

procedure TfrmListScenario.lvListScenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btnOkClick(sender);
  end;
end;

end.
