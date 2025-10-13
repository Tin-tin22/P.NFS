unit ufListScenario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, AdvSmoothButton, IniFiles,

  uDataModule, uClassDatabase, uGlobalVar, uInstrukturManager,
  uBridgeSet;
type
  TfrmListScenario = class(TForm)
    lvListScen: TListView;
    pnlBottom: TPanel;
    btnRemove: TAdvSmoothButton;
    btnOk: TAdvSmoothButton;
    btnClose: TAdvSmoothButton;
    edtGameName: TEdit;
    lblGameName: TLabel;
    tmrPlayScenario: TTimer;
    tmrPlayScenario2: TTimer;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure edtGameNameChange(Sender: TObject);
    procedure lvListScenClick(Sender: TObject);
    procedure lvListScenKeyPress(Sender: TObject; var Key: Char);
    procedure edtGameNameKeyPress(Sender: TObject; var Key: Char);
    procedure tmrPlayScenarioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvListScenDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    isPlay : Boolean;
    firstPlay : Boolean;

    CurrentConsole3DServerAddress : string;
    counter : Integer;
    ip3DServer : string;
    waitingTime, rerunCounter : Integer;

    procedure ShowScenario;
    procedure readBridgeSetIni;
    { Public declarations }
  end;

var
  frmListScenario: TfrmListScenario;

implementation

uses
  ufScenarioEdit, ufrmMainInstruktur,uTCPDatatype, ufrmGameController;

{$R *.dfm}

procedure TfrmListScenario.btnCloseClick(Sender: TObject);
begin
  frmSceEditor.isNew := True;
  Close;
end;

procedure TfrmListScenario.btnOkClick(Sender: TObject);
var
  cekGameName : boolean;
  recCons     : TList;
  SceConList  : TSceConList;
  i,j         : Integer;
begin
  case TButton(sender).Tag of
    0 : begin
          if lvListScen.Selected <> nil then
          begin
            frmSceEditor.Scenario_ID  := StrToInt(lvListScen.Selected.Caption);
            frmSceEditor.ScenarioName := lvListScen.Selected.SubItems[0];
            frmMainInstruktur.Caption := 'Firing System Instruktur - '+lvListScen.Selected.SubItems[0];

            frmSceEditor.isNew := false;
            frmSceEditor.UpdateVisualForm;

            Close;
          end
          else
          begin
            ShowMessage('Select Scenario First');
          end;
        end;
    1 : begin  //ketika play
           if lvListScen.Selected <> nil then
           begin
             DataModule1.DeleteDefaultScenario;
             CurrentScenarioID  := StrToInt(lvListScen.Selected.Caption);
             CurrentScenarioName := lvListScen.Selected.SubItems[0];
             IDGame             := DataModule1.GetGameID(CurrentScenarioID);
             cekGameName        := DataModule1.GameNameAlreadyExist(edtGameName.Text);
             SceIDTemporary     := CurrentScenarioID;

             if cekGameName then
             begin
               ShowMessage(QuotedStr(edtGameName.Text)+' is Already Exist');
               exit;
             end;

             GameName := edtGameName.Text;

             //send game name...
             SimManager.NetSendGameName(GameName);
             SimManager.NetSendTo3D_SetCommandOrder(0, ORD_REFRESH_CLIENT, 0, 0,0,0,0);



             //DataModule1.DeleteDefaultScenario;

             DataModule1.FillListDefaultScenario(CurrentScenarioID);
             SimManager.NetSendStatusGame(CurrentScenarioID, 1);

             CurrentScenarioID := 0;


             if CurrentScenarioID = 0 then
             begin
                SimManager.ServerIp := CurrentConsole3DServerAddress;
                SimManager.InstrukturSendLaunchAllCommand;
             end;


             SimManager.isDatabaseMode := False;
             Close;
           end
           else
              ShowMessage('Select Scenario First');

            //ShowMessage(IntToStr(SimManager.MainObjList.ItemCount));
             //frmMainInstruktur.edt1.Text := IntToStr(SimManager.MainObjList.ItemCount);
            //tmrPlayScenario.Enabled := True;
            //tmrPlayScenario2.Enabled := True;
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

procedure TfrmListScenario.FormShow(Sender: TObject);
begin
  ShowScenario;
  //ShowMessage(IntToStr(tmrPlayScenario.Interval));
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
  if lvListScen.Selected = nil then Exit;

  aDateTime := Now;
  DateTimeToString(formatDate, 'ddmmyy_hhnnss', aDateTime);
  edtGameName.Text := lvListScen.Selected.SubItems[0]+'_'+formatDate;

  //btnOk.SetFocus;
end;

procedure TfrmListScenario.lvListScenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
//    btnOK.Tag := 1;
    btnOkClick(btnOK);
  end;
end;

procedure TfrmListScenario.edtGameNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
//    btnOK.Tag := 1;
    btnOkClick(btnOK);
  end;
end;
procedure TfrmListScenario.tmrPlayScenarioTimer(Sender: TObject);
var
  recsend : TRecData2DOrder;
begin
  frmMainInstruktur.edt1.Text := IntToStr(SimManager.MainObjList.ItemCount);

  //ShowMessage(ip3DServer);
  if ((SimManager.MainObjList.ItemCount = 0) and ((frmMainInstruktur.lblCekRunning.Caption = 'Play') and (firstPlay = True))) or
      ((SimManager.MainObjList.ItemCount = 0) and ((frmMainInstruktur.lblCekRunning.Caption = 'Play') and (firstPlay = False))) then
  begin
    //jika selama 10 detik ditunggu tidak ada kapal di 2D maka scenario di stop
    frmMainInstruktur.FrameControlLeft.FrameWeaponStatus.SetWeaponGroupBar;
    if Length(SimManager.bridgeSet.mServer.m3D_IP) > 0 then
      SimManager.StopToClientOnIP(SimManager.bridgeSet.mServer.m3D_IP);

    frmMainInstruktur.Caption := 'Firing System Instruktur';
    frmMainInstruktur.cekCaption  := frmMainInstruktur.Caption;
    SimManager.NetSendStatusGame(0, 2);
    SimManager.NetSendTo3D_SetCommandOrder(0, ORD_REFRESH_CLIENT, 0, 0,0,0,0) ;
    frmMainInstruktur.deleteLeftFrame;
    frmGameController.SetDefaultEnvirontment;

    //dendy sementara
    frmGameController.lvRuntimeShipTrajectory.Items.Clear;
    frmGameController.lvRuntimeMissileTrajectory.Items.Clear;

    sleep (1000);

    CurrentScenarioID := 0;
    if CurrentScenarioID = 0 then
     begin
        SimManager.NetSendStatusGame(CurrentScenarioID, 1);
        SimManager.ServerIp := CurrentConsole3DServerAddress;
        SimManager.InstrukturSendLaunchAllCommand;
        //frmMainInstruktur.lblCekRunning.Caption := 'Play';
     end;

    counter := counter + 1;
    if counter > rerunCounter then
    begin
      RecSend.orderID   := _CM_CLIENT_MANAGE;
      RecSend.numValue  := __CM_CLIENT_RESTART;
      RecSend.strValue  := '';
      RecSend.strValue2 := '';
      RecSend.strValue3 := '';
      RecSend.ipConsole := ip3DServer;

      SimManager.SendCommand2D_Order(RecSend);
    end;

    firstPlay := False;
  end
  else if SimManager.MainObjList.ItemCount > 0 then
  begin
    tmrPlayScenario.Enabled := False;
  end;
end;

procedure TfrmListScenario.readBridgeSetIni;
var
  iniFile : TIniFile;
begin
  iniFile := TIniFile.Create('..\bin\BridgeSet.ini');

  ip3DServer  := iniFile.ReadString('CONFIG','3DSERVER','Default');
  waitingTime := StrToInt(iniFile.ReadString('CONFIG','waitingTime','Default'));
  rerunCounter:= StrToInt(iniFile.ReadString('CONFIG','rerunCounter','Default'));

  iniFile.Free;
end;

procedure TfrmListScenario.FormCreate(Sender: TObject);
begin
  counter := 0;
  readBridgeSetIni;
  tmrPlayScenario.Interval := waitingTime;
  tmrPlayScenario.Enabled := False;
  tmrPlayScenario2.Interval := 10000;
  tmrPlayScenario2.Enabled := False;
  firstPlay := True;
end;

procedure TfrmListScenario.lvListScenDblClick(Sender: TObject);
begin
  btnOkClick(btnOk);

end;

end.
