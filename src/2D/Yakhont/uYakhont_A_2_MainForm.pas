unit uYakhont_A_2_MainForm;

{ Yakhont Panel Kanan }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, Buttons, SpeedButtonImage, VrControls, VrLcd, IniFiles,
  System.ImageList{,
  acPNG};

type
  TfrmYakh_A_2_MainForm = class(TForm)
    ilOn: TImageList;
    pnlYakh_A_2_MainForm: TPanel;
    imgYakh_A_2_MainForm: TImage;
    btnSACS: TSpeedButtonImage;
    VrClock1: TVrClock;
    img27v: TImage;
    img1: TImage;
    imgLedBlockUnit: TImage;
    imgLedMonitor: TImage;
    imgLedFrontPanels: TImage;
    imgSACSon: TImage;
    procedure btnSACSClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSACSMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadSettingForm(filepath : string);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isSACS    : Boolean;

    _state27v : Boolean;

    picture_Path : String;
    fIndikatorOff, fIndikatorFault : String;
  end;

var
  frmYakh_A_2_MainForm: TfrmYakh_A_2_MainForm;

  idFormKananAtas, offX, offY : Integer;

implementation

{$R *.dfm}

uses
   uYakhont_A_1_MainForm, uYakhontManager, uLoadingScreen;

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmYakh_A_2_MainForm.btnSACSMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   //if frmYakh_A_1_MainForm.StateOn = True then
    //isSACS := True;

end;

procedure TfrmYakh_A_2_MainForm.FormActivate(Sender: TObject);
begin
  VrClock1.Active := True;
end;

procedure TfrmYakh_A_2_MainForm.FormCreate(Sender: TObject);
begin
//  LoadSettingForm('..\bin\SettingYakhontToMonitor.ini');
end;

procedure TfrmYakh_A_2_MainForm.FormShow(Sender: TObject);
var
  i : Integer;
begin
  i := 0;
//  DefaultMonitor := dmDesktop;
//  i := idFormKananAtas;
//
//  Left := Screen.Monitors[i].Left + offX;
//  Top := Screen.Monitors[i].Top + offY;

   EnableComposited(pnlYakh_A_2_MainForm);

   isSACS    := false;
   _state27v := false;

   picture_Path    := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);
   fIndikatorOff   := picture_Path + 'data\images\yakhont\AB_Indikator_Of_SMALL.bmp';
   fIndikatorFault := picture_Path + 'data\images\yakhont\AB_Indikator_On_SMALL_Merah.bmp';
end;



procedure TfrmYakh_A_2_MainForm.LoadSettingForm(filepath: string);
var
  inifile : TIniFile;
  tempstring : TStringList;
begin
  inifile := TIniFile.Create(filepath);
  tempstring := TStringList.Create;

  inifile.ReadSection('Kanan Atas', tempstring);

  idFormKananAtas := StrToInt(inifile.ReadString('Kanan Atas', tempstring[0],'Default'));
  offX := StrToInt(inifile.ReadString('Kanan Atas', tempstring[1],'Default'));
  offY := StrToInt(inifile.ReadString('Kanan Atas', tempstring[2],'Default'));

  inifile.Free;
  tempstring.Free;
end;

procedure TfrmYakh_A_2_MainForm.btnSACSClick(Sender: TObject);
begin
     YakhontManager.EventOnSendingLog(2, 0, 0, 0);

   case btnSACS.ImageIndex of
     0 : begin
       isSACS := False;
     end;
     1 : begin
//        if NCR button has been clicked, you may press SACS button
       if frmYakh_A_1_MainForm.isEnabled then
       begin
          isSACS := true;
          frmLoadingScreen.pbLoadingScreen.Position := 0;
          frmLoadingScreen.temp_Counter := 0;

       end;

     end;
   end;

    frmLoadingScreen.Show;
    frmLoadingScreen.timerLoadingScreen.Enabled := True;
    imgSACSon.Visible := True;

end;
end.
