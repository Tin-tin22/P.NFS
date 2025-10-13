unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uBridgeSet, uTCPClient, OverbyteIcsWndControl,
  OverbyteIcsWSocket, uDataModule, Menus, uRBU_Manager

  ,uBurjaAtas, Buttons, ExtCtrls;

type
  Tfrm_Main = class(TForm)
    mmo1: TMemo;
    mm1: TMainMenu;
    mniProgram: TMenuItem;
    mni: TMenuItem;
    mniExit: TMenuItem;
    mniConnect1: TMenuItem;
    mniDisconnect: TMenuItem;
    mniNetSetting: TMenuItem;
    mniBurja1: TMenuItem;
    mniBurja: TMenuItem;
    mniN108Kiri1: TMenuItem;
    mniN108Kanan1: TMenuItem;
    pnl1: TPanel;
    btnConnect: TSpeedButton;
    procedure EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
    procedure FormCreate(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniNetSettingClick(Sender: TObject);
    procedure mniConnect1Click(Sender: TObject);
    procedure mniDisconnectClick(Sender: TObject);
    procedure mniBurjaClick(Sender: TObject);
    procedure mniN108Kiri1Click(Sender: TObject);
    procedure mniN108Kanan1Click(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);

  private
    { Private declarations }
  procedure InitSettingParam;

  public
    { Public declarations }

  end;

var
  frm_Main: Tfrm_Main;

implementation
uses
  uTCPDatatype,uBurjaBawah, u108;
{$R *.dfm}

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
  RBU_MAnager.BeginSimulation;
end;

procedure Tfrm_Main.InitSettingParam;

begin

end;

procedure Tfrm_Main.mniBurjaClick(Sender: TObject);
begin
  RBU_MAnager.frmBottomBurja.Show;
end;

procedure Tfrm_Main.mniConnect1Click(Sender: TObject);
begin
  RBU_MAnager.Net_Connect;
end;

procedure Tfrm_Main.mniDisconnectClick(Sender: TObject);
begin
  RBU_MAnager.Net_DisConnect;
end;

procedure Tfrm_Main.mniExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrm_Main.mniN108Kanan1Click(Sender: TObject);
begin
  RBU_MAnager.frm108Kanan.Show;
end;

procedure Tfrm_Main.mniN108Kiri1Click(Sender: TObject);
begin
   RBU_MAnager.frm108Kiri.Show;
end;

procedure Tfrm_Main.mniNetSettingClick(Sender: TObject);
begin
  RBU_MAnager.FrmNetShow;
end;

procedure Tfrm_Main.btnConnectClick(Sender: TObject);
var spb : TSpeedButton;
begin
  spb := (sender as TSpeedButton);
    if spb.Down then begin
       RBU_MAnager.Net_Connect;
      if RBU_MAnager.Datcom.State = wsConnected then
         spb.Caption := 'Connected';
    end
    else begin
      RBU_MAnager.Net_DisConnect;
      //netComm.Disconnect;
      spb.Caption := 'ReConnect';
    end;
end;


procedure  Tfrm_Main.EventOnReceiveDataPosition(apRec: PAnsiChar; aSize: integer);
  var  aRec: ^TRecDataPosition;
begin
end;


end.
