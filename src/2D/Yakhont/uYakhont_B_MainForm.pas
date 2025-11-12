unit uYakhont_B_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, SpeedButtonImage, ImgList, StdCtrls,
  uTCPDatatype, Menus, IniFiles, Vcl.Imaging.jpeg, System.ImageList;

type
  TfrmYakh_B_MainForm = class(TForm)
    ilBacklight: TImageList;
    ilCancel: TImageList;
    ilOnOff: TImageList;
    ilKey: TImageList;
    ilStart: TImageList;
    pmShowSocket: TPopupMenu;
    ShowConnector1: TMenuItem;
    HideConnector1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    pnlYakh_B_MainForm: TPanel;
    imgYakh_B_MainForm: TImage;
    btnKey: TSpeedButtonImage;
    btnBackLight: TSpeedButtonImage;
    btnCancel: TSpeedButtonImage;
    btnStart: TSpeedButtonImage;
    imgTechnologicalSelection: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgOff: TImage;
    imgOn: TImage;
    btnExit: TSpeedButton;
    KeyClosed: TImage;
    btnStartClosed: TImage;
    imgONSC: TImage;
    Edit1: TEdit;
    pnlConnector: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnExitClick(Sender: TObject);
    procedure imgYakh_B_MainFormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowConnector1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadSettingForm(filepath : string);
    procedure btnKeyClick(Sender: TObject);
    procedure btnStartClosedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    Key_Yakhont : TRecCMD_Yakhont;

    C__mayIOpenKey        : Boolean;
    C__mayIPressStartFire : Boolean;

    tempConf : boolean;

    picture_Path,
    fIndikatorOn, fIndikatorOff, fIndikatorRed : string;

    TimerTerminate : TTimer;

    procedure normalisasi;

    {Event On Connect}
    procedure OnConnectedToMainDisplay(cmd : boolean);
    procedure OnTimerTerminate(sender : TObject);
  end;

var
  frmYakh_B_MainForm: TfrmYakh_B_MainForm;

  idFormYakhontB, offX, offY : Integer;

implementation

uses
  uYakhont_B_Manager, overbyteicsWSocket;

{$R *.dfm}

procedure TfrmYakh_B_MainForm.btnCancelClick(Sender: TObject);
begin
  with Yakhont_B_Manager do
  begin
    if NetCommLocalClient.State <> wsConnected then
    begin
      Net_Connect;
    end;
  end;

  if Sender = btnCancel then
  begin
    case btnCancel.ImageIndex of
       0 : begin

       end;
       1 : begin

       end;
       3 : begin
       //Key_Yakhont.cmd := CMD_Yakhont_SCOn;

       end;
    end;
    Key_Yakhont.cmd := CMD_Yakhont_Cancel;
  end;

  if Sender = btnBackLight  then
  begin
    case btnBackLight.ImageIndex of
       0 : begin

       end;
       1 : begin

       end;
    end;
    Key_Yakhont.cmd := CMD_Yakhont_Backlight;
  end;

  Yakhont_B_Manager.NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
end;

procedure TfrmYakh_B_MainForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmYakh_B_MainForm.btnKeyClick(Sender: TObject);
begin
  with Yakhont_B_Manager do
  begin
    if NetCommLocalClient.State <> wsConnected then
    begin
      Net_Connect;
    end;
  end;

  if Sender = btnKey then
  begin
     case btnKey.ImageIndex of
        0 :  begin
         if not C__mayIOpenKey then begin
//            ShowMessage('Start circuit is not ready');
         end;
        end;
        1 :  begin
         if not C__mayIOpenKey then begin
//            ShowMessage('Start circuit is not ready');
         end;
        end;
        2 :  begin
         if C__mayIOpenKey then begin
            Key_Yakhont.cmd := CMD_Yakhont_Key;
            tempConf := true;
            btnStart.Visible       := True;
            btnStartClosed.Visible := False;
            imgONSC.Visible := True;
         end
         else begin
//            ShowMessage('Start circuit is not ready');

         end;
        end;
     end;
  end;

  Yakhont_B_Manager.NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
end;

procedure TfrmYakh_B_MainForm.btnStartClosedClick(Sender: TObject);
begin
  with Yakhont_B_Manager do
  begin
    if NetCommLocalClient.State <> wsConnected then
    begin
      Net_Connect;
    end;
  end;

  if Sender = btnStart then
  begin
     case btnStart.ImageIndex of
        0 : begin
         if not C__mayIPressStartFire then begin
//            ShowMessage('Not allowed to firing');

         end;
        end;
        1 : begin
         if not C__mayIPressStartFire then begin
//            ShowMessage('Not allowed to firing');

         end;
        end;
        2 : begin
         if C__mayIOpenKey then
         begin
           if tempConf then //coba kunci lagi
           begin
             if C__mayIPressStartFire then
               Key_Yakhont.cmd := CMD_Yakhont_Start;
           end;
         end
         else begin
//            ShowMessage('Not allowed to firing');

         end;
        end;
     end;
  end;

  Yakhont_B_Manager.NetCommLocalClient.sendDataEx(REC_CMD_Yakhont, @Key_Yakhont);
end;

procedure TfrmYakh_B_MainForm.FormCreate(Sender: TObject);
begin
//  LoadSettingForm('..\bin\SettingYakhontToMonitor.ini');

  TimerTerminate := TTimer.Create(nil);
  TimerTerminate.Enabled  := false;
  TimerTerminate.Interval := 200;
  TimerTerminate.OnTimer  := OnTimerTerminate;
  Yakhont_B_Manager := TYakhont_B_Manager.Create();
  Yakhont_B_Manager.Initialize;
  Yakhont_B_Manager.BeginSimulation;


//  Yakhont_B_Manager.OnConnected := OnConnectedToMainDisplay;
end;

procedure TfrmYakh_B_MainForm.FormDestroy(Sender: TObject);
begin
  TimerTerminate.Free;
end;

procedure TfrmYakh_B_MainForm.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  if GetKeyState(VK_F7) < 0 then
  begin
    btnExit.Visible := False;
  end;

  if GetKeyState(VK_F8) < 0 then
  begin
    btnExit.Visible := True;
  end;
end;

procedure TfrmYakh_B_MainForm.FormShow(Sender: TObject);
var
   i : Integer;
begin
  i := 0;
  DefaultMonitor := dmDesktop;
  i := idFormYakhontB;

//  Screen.Monitors[i].Left := offX;
//  Screen.Monitors[i].Top := offY;

//  if Screen.MonitorCount = 1  then
//    i := 0
//  else
//  if Screen.MonitorCount = 2 then
//    i := 1
//  else
//  if Screen.MonitorCount = 3 then
//    i := 2
//  else
//  if Screen.MonitorCount = 4 then
//    i := 3;

  Top := Screen.Monitors[i].Top + offY;
  Left := Screen.Monitors[i].Left + offX;


   picture_Path  := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
   fIndikatorOn  := picture_Path + 'data\images\yakhont\AB_Indikator_On.bmp';
   fIndikatorOff := picture_Path + 'data\images\yakhont\AB_Indikator_Off.bmp';

   fIndikatorRed := picture_Path + 'data\images\yakhont\AB_Indikator_On_Merah.bmp';

//   imgOn.Picture.LoadFromFile(fIndikatorOff);
   imgOff.Picture.LoadFromFile(fIndikatorOn);
end;

procedure TfrmYakh_B_MainForm.normalisasi;
begin
    C__mayIOpenKey        := False; //Tes Kunci //Edit Iqbal
    C__mayIPressStartFire := False;
    KeyClosed.Visible     := True;
    btnKey.Visible        := False;
    btnStartClosed.Visible:= True;
    btnStart.Visible      := False;
    tempConf := false;
end;

procedure TfrmYakh_B_MainForm.OnConnectedToMainDisplay(cmd: boolean);
begin
  if cmd then
  begin
    pnlConnector.Color    := clGreen;
    pnlConnector.Visible  := false;
    pnlConnector.Caption  := 'Connected';
  end
  else
  begin
    pnlConnector.Color    := clRed;
    pnlConnector.Visible  := True;
    pnlConnector.Caption  := 'Not Connected';
  end;
end;

procedure TfrmYakh_B_MainForm.OnTimerTerminate(sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmYakh_B_MainForm.ShowConnector1Click(Sender: TObject);
begin
  case TComponent(sender).tag of
    1 : pnlConnector.Visible := true;
    2 : pnlConnector.Visible := false;
    3 :
    begin
      Yakhont_B_Manager.Net_Disconnect;
      TimerTerminate.Enabled := True;
    end;
  end;
end;

procedure TfrmYakh_B_MainForm.imgYakh_B_MainFormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  buttonSelected : Integer;
  Point :  TPoint;
begin
  if Button = mbright then
  begin
    {
    buttonSelected := MessageDlg('Are you sure want to leave this form ? ',mtWarning, mbYesNo, 0);

    if buttonSelected = mrYes then
    begin
      Application.Terminate;
    end;
    }

    GetCursorPos(Point);
    pmShowSocket.Popup(Point.X, Point.Y);
  end;
end;



procedure TfrmYakh_B_MainForm.LoadSettingForm(filepath: string);
var
  inifile : TIniFile;
  tempstring : TStringList;
begin
  inifile := TIniFile.Create(filepath);
  tempstring := TStringList.Create;

  inifile.ReadSection('Form B', tempstring);

  idFormYakhontB := StrToInt(inifile.ReadString('Form B', tempstring[0],'Default'));
  offX := StrToInt(inifile.ReadString('Form B', tempstring[1],'Default'));
  offY := StrToInt(inifile.ReadString('Form B', tempstring[2],'Default'));

  inifile.Free;
  tempstring.Free;
end;

end.
