unit FKeyboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, Buttons, SpeedButtonImage, ImgList, StdCtrls, uTCPDatatype;

type
  TKeyboard = class(TForm)
    btnCombat: TSpeedButtonImage;
    btnStatus: TSpeedButtonImage;
    btnSimulate: TSpeedButtonImage;
    btnMControl: TSpeedButtonImage;
    btnCheck: TSpeedButtonImage;
    btnParSetting: TSpeedButtonImage;
    btnLogOff: TSpeedButtonImage;
    btnRecordData: TSpeedButtonImage;
    btnTab: TSpeedButtonImage;
    btnBackSpace: TSpeedButtonImage;
    btnEsc: TSpeedButtonImage;
    btnEnter: TSpeedButtonImage;
    btnOn: TSpeedButtonImage;
    btnUp: TSpeedButtonImage;
    btnDown: TSpeedButtonImage;
    btnLeft: TSpeedButtonImage;
    btnRight: TSpeedButtonImage;
    btnDash: TSpeedButtonImage;
    btn0: TSpeedButtonImage;
    btnDot: TSpeedButtonImage;
    btn1: TSpeedButtonImage;
    btn2: TSpeedButtonImage;
    btn3: TSpeedButtonImage;
    btn4: TSpeedButtonImage;
    btn5: TSpeedButtonImage;
    btn6: TSpeedButtonImage;
    btn7: TSpeedButtonImage;
    btn8: TSpeedButtonImage;
    btn9: TSpeedButtonImage;
    img1: TImage;
    btnOff: TSpeedButtonImage;
    procedure btnCombatClick(Sender: TObject);
    procedure btnOffMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOffMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ilCombat : TImageList;
    ilStatus: TImageList;
    ilSimulate: TImageList;
    ilMControl: TImageList;
    ilCheck: TImageList;
    ilParSetting: TImageList;
    ilLogOff: TImageList;
    ilRecordData: TImageList;
    ilTab: TImageList;
    ilBackSpace: TImageList;
    ilEsc: TImageList;
    ilEnter: TImageList;
    ilOn: TImageList;
    ilOff: TImageList;
    ilUp: TImageList;
    ilDown: TImageList;
    ilLeft: TImageList;
    ilRight: TImageList;
    ilDash: TImageList;
    il0: TImageList;
    ilDot: TImageList;
    il1: TImageList;
    il2: TImageList;
    il3: TImageList;
    il4: TImageList;
    il5: TImageList;
    il6: TImageList;
    il7: TImageList;
    il8: TImageList;
    il9: TImageList;
  public
    { Public declarations }
    Key_C802  : TRecCMD_C802;
  end;

var
  Keyboard_Form: TKeyboard;

implementation

uses uC802Manager;
{$R *.dfm}

procedure TKeyboard.btnOffMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  btnOn.ImageIndex  := 1;
end;

procedure TKeyboard.btnOffMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  btnOn.ImageIndex  := 0;
end;

procedure TKeyboard.btnOnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  btnOff.ImageIndex := 1;
end;

procedure TKeyboard.btnOnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  btnOff.ImageIndex := 0;
end;

procedure TKeyboard.FormCreate(Sender: TObject);
var
 Bmap    : TBitmap;
begin

//btnCombat

  ilCombat := TImageList.Create(nil);
  ilCombat.Width  := btnCombat.Width;
  ilCombat.Height := btnCombat.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\combat.bmp');
  finally
    ilCombat.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\combat_down.bmp');
  finally
    ilCombat.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnCombat.ImageList  := ilCombat;
  btnCombat.ImageIndex := 0;

//btnStatus

  ilStatus := TImageList.Create(nil);
  ilStatus.Width  := btnStatus.Width;
  ilStatus.Height := btnStatus.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\status.bmp');
  finally
    ilStatus.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\status_down.bmp');
  finally
    ilStatus.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnStatus.ImageList  := ilStatus;
  btnStatus.ImageIndex := 0;

//btnSimulate

  ilSimulate := TImageList.Create(nil);
  ilSimulate.Width  := btnSimulate.Width;
  ilSimulate.Height := btnSimulate.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\simulate.bmp');
  finally
    ilSimulate.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\simulate_down.bmp');
  finally
    ilSimulate.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnSimulate.ImageList  := ilSimulate;
  btnSimulate.ImageIndex := 0;

//btnMControl

  ilMControl := TImageList.Create(nil);
  ilMControl.Width  := btnMControl.Width;
  ilMControl.Height := btnMControl.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\mcontrol.bmp');
  finally
    ilMControl.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\mcontrol_down.bmp');
  finally
    ilMControl.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnMControl.ImageList  := ilMControl;
  btnMControl.ImageIndex := 0;

//btnCheck

  ilCheck := TImageList.Create(nil);
  ilCheck.Width  := btnCheck.Width;
  ilCheck.Height := btnCheck.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\check.bmp');
  finally
    ilCheck.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\check_down.bmp');
  finally
    ilCheck.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnCheck.ImageList  := ilCheck;
  btnCheck.ImageIndex := 0;

//btnParSetting

  ilParSetting := TImageList.Create(nil);
  ilParSetting.Width  := btnParSetting.Width;
  ilParSetting.Height := btnParSetting.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\parsetting.bmp');
  finally
    ilParSetting.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\parsetting_down.bmp');
  finally
    ilParSetting.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnParSetting.ImageList  := ilParSetting;
  btnParSetting.ImageIndex := 0;

//btnLogOff

  ilLogOff := TImageList.Create(nil);
  ilLogOff.Width  := btnLogOff.Width;
  ilLogOff.Height := btnLogOff.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\log off.bmp');
  finally
    ilLogOff.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\log off_down.bmp');
  finally
    ilLogOff.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnLogOff.ImageList  := ilLogOff;
  btnLogOff.ImageIndex := 0;

//btnRecordData

  ilRecordData := TImageList.Create(nil);
  ilRecordData.Width  := btnRecordData.Width;
  ilRecordData.Height := btnRecordData.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\record data.bmp');
  finally
    ilRecordData.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\record data_down.bmp');
  finally
    ilRecordData.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnRecordData.ImageList  := ilRecordData;
  btnRecordData.ImageIndex := 0;

//btnTab

  ilTab := TImageList.Create(nil);
  ilTab.Width  := btnTab.Width;
  ilTab.Height := btnTab.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\tab.bmp');
  finally
    ilTab.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\tab_down.bmp');
  finally
    ilTab.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnTab.ImageList  := ilTab;
  btnTab.ImageIndex := 0;

//btnBackSpace

  ilBackSpace := TImageList.Create(nil);
  ilBackSpace.Width  := btnBackSpace.Width;
  ilBackSpace.Height := btnBackSpace.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\back space.bmp');
  finally
    ilBackSpace.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\back space_down.bmp');
  finally
    ilBackSpace.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnBackSpace.ImageList  := ilBackSpace;
  btnBackSpace.ImageIndex := 0;

//btnEsc

  ilEsc := TImageList.Create(nil);
  ilEsc.Width  := btnEsc.Width;
  ilEsc.Height := btnEsc.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\esc.bmp');
  finally
    ilEsc.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\esc_down.bmp');
  finally
    ilEsc.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnEsc.ImageList  := ilEsc;
  btnEsc.ImageIndex := 0;

//btnEnter

  ilEnter := TImageList.Create(nil);
  ilEnter.Width  := btnEnter.Width;
  ilEnter.Height := btnEnter.Height;
  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\enter.bmp');
  finally
    ilEnter.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\enter_down.bmp');
  finally
    ilEnter.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnEnter.ImageList  := ilEnter;
  btnEnter.ImageIndex := 0;

//btnOn

  ilOn := TImageList.Create(nil);
  ilOn.Width  := btnOn.Width;
  ilOn.Height := btnOn.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\on.bmp');
  finally
    ilOn.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\on_down.bmp');
  finally
    ilOn.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnOn.ImageList  := ilOn;
  btnOn.ImageIndex := 0;

//btnOff

  ilOff := TImageList.Create(nil);
  ilOff.Width  := btnOff.Width;
  ilOff.Height := btnOff.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\off.bmp');
  finally
    ilOff.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\off_down.bmp');
  finally
    ilOff.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnOff.ImageList  := ilOff;
  btnOff.ImageIndex := 0;

 //btnUp

  ilUp := TImageList.Create(nil);
  ilUp.Width  := btnUp.Width;
  ilUp.Height := btnUp.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah atas.bmp');
  finally
    ilUp.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah atas_down.bmp');
  finally
    ilUp.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnUp.ImageList  := ilUp;
  btnUp.ImageIndex := 0;

//btnDown

  ilDown := TImageList.Create(nil);
  ilDown.Width  := btnDown.Width;
  ilDown.Height := btnDown.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah bawah.bmp');
  finally
    ilDown.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah bawah_down.bmp');
  finally
    ilDown.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnDown.ImageList  := ilDown;
  btnDown.ImageIndex := 0;

//btnRight

  ilRight := TImageList.Create(nil);
  ilRight.Width  := btnRight.Width;
  ilRight.Height := btnRight.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah kanan.bmp');
  finally
    ilRight.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah kanan_down.bmp');
  finally
    ilRight.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnRight.ImageList  := ilRight;
  btnRight.ImageIndex := 0;

//btnLeft

  ilLeft := TImageList.Create(nil);
  ilLeft.Width  := btnLeft.Width;
  ilLeft.Height := btnLeft.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah kiri.bmp');
  finally
    ilLeft.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\panah kiri_down.bmp');
  finally
    ilLeft.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnLeft.ImageList  := ilLeft;
  btnLeft.ImageIndex := 0;

//btnDash

  ilDash := TImageList.Create(nil);
  ilDash.Width  := btnDash.Width;
  ilDash.Height := btnDash.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\minus.bmp');
  finally
    ilDash.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\minus_down.bmp');
  finally
    ilDash.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnDash.ImageList  := ilDash;
  btnDash.ImageIndex := 0;

//btn0

  il0 := TImageList.Create(nil);
  il0.Width  := btn0.Width;
  il0.Height := btn0.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\0.bmp');
  finally
    il0.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\0_down.bmp');
  finally
    il0.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn0.ImageList  := il0;
  btn0.ImageIndex := 0;

//btnDot

  ilDot := TImageList.Create(nil);
  ilDot.Width  := btnDot.Width;
  ilDot.Height := btnDot.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\titik.bmp');
  finally
    ilDot.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\titik_down.bmp');
  finally
    ilDot.Add(Bmap, nil);
    Bmap.Free;
  end;
  btnDot.ImageList  := ilDot;
  btnDot.ImageIndex := 0;

//btn1

  il1 := TImageList.Create(nil);
  il1.Width  := btn1.Width;
  il1.Height := btn1.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\1.bmp');
  finally
    il1.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\1_down.bmp');
  finally
    il1.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn1.ImageList  := il1;
  btn1.ImageIndex := 0;

//btn2

  il2 := TImageList.Create(nil);
  il2.Width  := btn2.Width;
  il2.Height := btn2.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\2.bmp');
  finally
    il2.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\2_down.bmp');
  finally
    il2.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn2.ImageList  := il2;
  btn2.ImageIndex := 0;

//btn3

  il3 := TImageList.Create(nil);
  il3.Width  := btn3.Width;
  il3.Height := btn3.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\3.bmp');
  finally
    il3.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\3_down.bmp');
  finally
    il3.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn3.ImageList  := il3;
  btn3.ImageIndex := 0;

//btn4

  il4 := TImageList.Create(nil);
  il4.Width  := btn4.Width;
  il4.Height := btn4.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\4.bmp');
  finally
    il4.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\4_down.bmp');
  finally
    il4.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn4.ImageList  := il4;
  btn4.ImageIndex := 0;

//btn5

  il5 := TImageList.Create(nil);
  il5.Width  := btn5.Width;
  il5.Height := btn5.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\5.bmp');
  finally
    il5.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\5_down.bmp');
  finally
    il5.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn5.ImageList  := il5;
  btn5.ImageIndex := 0;

//btn6

  il6 := TImageList.Create(nil);
  il6.Width  := btn6.Width;
  il6.Height := btn6.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\6.bmp');
  finally
    il6.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\6_down.bmp');
  finally
    il6.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn6.ImageList  := il6;
  btn6.ImageIndex := 0;

//btn7

  il7 := TImageList.Create(nil);
  il7.Width  := btn7.Width;
  il7.Height := btn7.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\7.bmp');
  finally
    il7.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\7_down.bmp');
  finally
    il7.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn7.ImageList  := il7;
  btn7.ImageIndex := 0;

//btn8

  il8 := TImageList.Create(nil);
  il8.Width  := btn8.Width;
  il8.Height := btn8.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\8.bmp');
  finally
    il8.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\8_down.bmp');
  finally
    il8.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn8.ImageList  := il8;
  btn8.ImageIndex := 0;

//btn9

  il9 := TImageList.Create(nil);
  il9.Width  := btn9.Width;
  il9.Height := btn9.Height;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\9.bmp');
  finally
    il9.Add(Bmap, nil);
    Bmap.Free;
  end;

  try
    Bmap := TBitmap.Create;
    Bmap.LoadFromFile('..\data\images\C802\Keyboard\9_down.bmp');
  finally
    il9.Add(Bmap, nil);
    Bmap.Free;
  end;
  btn9.ImageList  := il9;
  btn9.ImageIndex := 0;

end;

procedure TKeyboard.btnCombatClick(Sender: TObject);
begin
  if Sender = btnCombat          then Key_C802.cmd  := CMD_C802_Combat
  else if Sender = btnStatus     then Key_C802.cmd  := CMD_C802_Status
  else if Sender = btnSimulate   then Key_C802.cmd  := CMD_C802_Simulate
  else if Sender = btnMControl   then Key_C802.cmd  := CMD_C802_MControl
  else if Sender = btnCheck      then Key_C802.cmd  := CMD_C802_Check
  else if Sender = btnParSetting then Key_C802.cmd  := CMD_C802_ParSetting
  else if Sender = btnLogOff     then Key_C802.cmd  := CMD_C802_LogOff
  else if Sender = btnRecordData then Key_C802.cmd  := CMD_C802_RecordData

  else if Sender = btnTab        then Key_C802.cmd  := CMD_C802_Tab
  else if Sender = btnBackSpace  then Key_C802.cmd  := CMD_C802_BackSpace
  else if Sender = btnEsc        then Key_C802.cmd  := CMD_C802_Esc
  else if Sender = btnEnter      then Key_C802.cmd  := CMD_C802_Enter
  else if Sender = btnOn         then Key_C802.cmd  := CMD_C802_OnOff
  else if Sender = btnOff        then Key_C802.cmd  := CMD_C802_OnOff
  else if Sender = btnUp         then Key_C802.cmd  := CMD_C802_Up
  else if Sender = btnDown       then Key_C802.cmd  := CMD_C802_Down
  else if Sender = btnLeft       then Key_C802.cmd  := CMD_C802_Left
  else if Sender = btnRight      then Key_C802.cmd  := CMD_C802_Right

  else if Sender = btnDash       then Key_C802.cmd  := CMD_C802_Dash
  else if Sender = btn0          then Key_C802.cmd  := CMD_C802_0
  else if Sender = btnDot        then Key_C802.cmd  := CMD_C802_Dot
  else if Sender = btn1          then Key_C802.cmd  := CMD_C802_1
  else if Sender = btn2          then Key_C802.cmd  := CMD_C802_2
  else if Sender = btn3          then Key_C802.cmd  := CMD_C802_3
  else if Sender = btn4          then Key_C802.cmd  := CMD_C802_4
  else if Sender = btn5          then Key_C802.cmd  := CMD_C802_5
  else if Sender = btn6          then Key_C802.cmd  := CMD_C802_6
  else if Sender = btn7          then Key_C802.cmd  := CMD_C802_7
  else if Sender = btn8          then Key_C802.cmd  := CMD_C802_8
  else if Sender = btn9          then Key_C802.cmd  := CMD_C802_9;

//  if not C802_ArchosManager.ShouldConnect then
//  begin
//    C802_ArchosManager.Net_Connect;
//  end;
//
//  C802_ArchosManager.NetCommLocalClient.sendDataEx(REC_CMD_C802, @Key_C802);

  C802Manager.ReceiveCommand(Key_C802);

end;

end.
