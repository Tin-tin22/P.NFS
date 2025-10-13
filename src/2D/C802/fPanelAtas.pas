unit fPanelAtas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VrControls, VrLcd, jpeg, Buttons,
  SpeedButtonImage, ImgList, Keyboard, VrDigit, VrAnalog;

type

  RecImplicit_Panel = record
    FShow : array[0..6] of Boolean;
  end;

  TPanelAtas = class(TForm)
    lstImplicitPanel_4: TListBox;
    vrnm1: TVrNum;
    img1: TImage;
    il_launch: TImageList;
    btnLaunch_4: TSpeedButtonImage;
    btnLaunch_2: TSpeedButtonImage;
    btnLaunch_1: TSpeedButtonImage;
    btnLaunch_3: TSpeedButtonImage;
    vrnmPitchSett: TVrNum;
    vrnmRollSett: TVrNum;
    vrnmAltVoltage: TVrNum;
    lstImplicitPanel_1: TListBox;
    btnSet_FeedB: TSpeedButtonImage;
    il_set_orange: TImageList;
    btnFan: TSpeedButtonImage;
    il_green: TImageList;
    btnAC: TSpeedButtonImage;
    btnDC: TSpeedButtonImage;
    lstImplicitPanel_2: TListBox;
    lstImplicitPanel_3: TListBox;
    il_orange: TImageList;
    btnLowHighStt: TSpeedButtonImage;
    btnMissileSelection_4: TSpeedButtonImage;
    btnMissileSelection_2: TSpeedButtonImage;
    btnMissileSelection_1: TSpeedButtonImage;
    btnMissileSelection_3: TSpeedButtonImage;
    vrdgtgrpYawnLead: TVrDigitGroup;
    vrdgtgrpPitchSett: TVrDigitGroup;
    vrdgtgrpRollSett: TVrDigitGroup;
    vrdgtgrpAltitude: TVrDigitGroup;
    btnLimit_Yellow1: TSpeedButtonImage;
    btnLimit_Green1: TSpeedButtonImage;
    btnLimit_Yellow2: TSpeedButtonImage;
    btnLimit_Green2: TSpeedButtonImage;
    il_launch_disable: TImageList;
    il_orange_dis: TImageList;
    il_set_orange_dis: TImageList;
    il_green_dis: TImageList;
    procedure FormShow(Sender: TObject);
    procedure btnFanClick(Sender: TObject);
    procedure btnACClick(Sender: TObject);
    procedure btnDCClick(Sender: TObject);
    procedure MainMenu_On;
    procedure showImplicit(mis_num: Integer);
    procedure setImplicit(im_panel,im_show: Integer; show: Boolean);
    procedure btnMissileSelection_4Click(Sender: TObject);
    procedure btnLimit_Yellow1Click(Sender: TObject);
    procedure btnLimit_Yellow2Click(Sender: TObject);
    procedure btnLimit_Green2Click(Sender: TObject);
    procedure btnLimit_Green1Click(Sender: TObject);
  private
    { Private declarations }
    mis_selection : Integer;
    array_mis_select : array[0..3,0..3] of Double;
    isLimit_1, isLimit_2 : Boolean;

    procedure C802_Off;
    procedure C802_On;
  public
    { Public declarations }
    Fan_Switch, AC_Switch, Power_Switch, DC_Switch : Boolean;
    Implicit_panel: array[0..6] of string;
    Implicit_4 : RecImplicit_Panel;
    Implicit_2 : RecImplicit_Panel;
    Implicit_1 : RecImplicit_Panel;
    Implicit_3 : RecImplicit_Panel;

    isOn : Boolean;
  end;

var
  PanelAtas: TPanelAtas;

implementation

uses
  fPanelBawah, uC802Manager;

{$R *.dfm}

procedure TPanelAtas.C802_Off;
begin
  btnLaunch_1.ImageList := il_launch_disable;
  btnLaunch_2.ImageList := il_launch_disable;
  btnLaunch_3.ImageList := il_launch_disable;
  btnLaunch_4.ImageList := il_launch_disable;

  btnLowHighStt.ImageList := il_orange_dis;
  btnSet_FeedB.ImageList  := il_set_orange_dis;

  with PanelBawah do begin
    btnPWRtoM_1.ImageList := il_orange_dis;
    btnPWRtoM_2.ImageList := il_orange_dis;
    btnPWRtoM_3.ImageList := il_orange_dis;
    btnPWRtoM_4.ImageList := il_orange_dis;

    btnCover_1.ImageList  := il_orange_dis;
    btnCover_2.ImageList  := il_orange_dis;
    btnCover_3.ImageList  := il_orange_dis;
    btnCover_4.ImageList  := il_orange_dis;
  end;
end;

procedure TPanelAtas.C802_On;
begin
  btnLaunch_1.ImageList := il_launch;
  btnLaunch_2.ImageList := il_launch;
  btnLaunch_3.ImageList := il_launch;
  btnLaunch_4.ImageList := il_launch;

  btnLowHighStt.ImageList := il_orange;
  btnSet_FeedB.ImageList  := il_set_orange;

  with PanelBawah do begin
    btnPWRtoM_1.ImageList := il_orange;
    btnPWRtoM_2.ImageList := il_orange;
    btnPWRtoM_3.ImageList := il_orange;
    btnPWRtoM_4.ImageList := il_orange;

    btnCover_1.ImageList  := il_orange;
    btnCover_2.ImageList  := il_orange;
    btnCover_3.ImageList  := il_orange;
    btnCover_4.ImageList  := il_orange;

  end;

end;

procedure TPanelAtas.btnLimit_Yellow2Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (not isLimit_2) and isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit orange.bmp');
    btnLimit_Yellow2.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit hijau ON.bmp');
    btnLimit_Green2.Glyph := bitmap;

    bitmap.Free;

    isLimit_2 := True;
  end;
end;

procedure TPanelAtas.btnACClick(Sender: TObject);
begin
  AC_Switch := not AC_Switch;
  C802Manager.SendEvenC802(2,0,0,0);
  MainMenu_On;
end;

procedure TPanelAtas.btnDCClick(Sender: TObject);
begin
  DC_Switch := not DC_Switch;
  C802Manager.SendEvenC802(3,0,0,0);
  MainMenu_On;
end;

procedure TPanelAtas.btnFanClick(Sender: TObject);
begin
  Fan_Switch  := not Fan_Switch;
  C802Manager.SendEvenC802(1,0,0,0);
  MainMenu_On;
end;

procedure TPanelAtas.btnLimit_Green1Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if isLimit_1 and isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit orange.bmp');
    btnLimit_Yellow1.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit hijau ON.bmp');
    btnLimit_Green1.Glyph := bitmap;

    bitmap.Free;

    isLimit_1 := False;
  end;
end;

procedure TPanelAtas.btnLimit_Green2Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if isLimit_2 and isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit orange ON.bmp');
    btnLimit_Yellow2.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit hijau.bmp');
    btnLimit_Green2.Glyph := bitmap;

    bitmap.Free;

    isLimit_2 := False;
  end;
end;

procedure TPanelAtas.btnLimit_Yellow1Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
begin
  if (not isLimit_1) and isOn then
  begin
    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit orange ON.bmp');
    btnLimit_Yellow1.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\limit hijau.bmp');
    btnLimit_Green1.Glyph := bitmap;

    bitmap.Free;

    isLimit_1 := True;
  end;
end;

procedure TPanelAtas.btnMissileSelection_4Click(Sender: TObject);
var data_Path: string;
    bitmap : TBitmap;
  I: Integer;
begin
  if isOn then
  begin
    if Sender = btnMissileSelection_4 then mis_selection := 4
    else if Sender = btnMissileSelection_2 then mis_selection := 2
    else if Sender = btnMissileSelection_1 then mis_selection := 1
    else if Sender = btnMissileSelection_3 then mis_selection := 3;

    bitmap  := TBitmap.Create;
    data_Path := Copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-4);

    bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 4.bmp');
    btnMissileSelection_4.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 2.bmp');
    btnMissileSelection_2.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 1.bmp');
    btnMissileSelection_1.Glyph := bitmap;
    bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 3.bmp');
    btnMissileSelection_3.Glyph := bitmap;

    case mis_selection of
      4:
        begin
          bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 4 ON.bmp');
          btnMissileSelection_4.Glyph := bitmap;
        end;
      2:
        begin
          bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 2 ON.bmp');
          btnMissileSelection_2.Glyph := bitmap;
        end;
      1:
        begin
          bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 1 ON.bmp');
          btnMissileSelection_1.Glyph := bitmap;
        end;
      3:
        begin
          bitmap.LoadFromFile(data_Path + 'data\images\C802\mis_selection 3 ON.bmp');
          btnMissileSelection_3.Glyph := bitmap;
        end;
    end;

    vrdgtgrpYawnLead.Value  := array_mis_select[mis_selection-1,0];
    vrdgtgrpPitchSett.Value := array_mis_select[mis_selection-1,1];
    vrdgtgrpRollSett.Value  := array_mis_select[mis_selection-1,2];
    vrdgtgrpAltitude.Value  := array_mis_select[mis_selection-1,3];

    bitmap.Free;
  end;
end;

procedure TPanelAtas.setImplicit(im_panel,im_show: Integer; show: Boolean);
begin
  case im_panel of
    1: Implicit_1.FShow[im_show] := show;
    2: Implicit_2.FShow[im_show] := show;
    3: Implicit_3.FShow[im_show] := show;
    4: Implicit_4.FShow[im_show] := show;
  end;
  showImplicit(im_panel);
end;

procedure TPanelAtas.FormShow(Sender: TObject);
begin
  Fan_Switch  := False;
  AC_Switch   := False;
  Power_Switch:= False;
  DC_Switch   := False;

  Implicit_panel[0] := 'SET.CHK';
  Implicit_panel[1] := 'LMT.OUT';
  Implicit_panel[2] := 'BUS.V';
  Implicit_panel[3] := 'GYRO.V';
  Implicit_panel[4] := 'M.NORMAL';
  Implicit_panel[5] := 'LNCH.RDY';
  Implicit_panel[6] := 'TAKE OFF';


  {temporary}
  array_mis_select[0,0] := 1.1;
  array_mis_select[0,1] := 1.01;
  array_mis_select[0,2] := 1.001;
  array_mis_select[0,3] := 1.11;
  array_mis_select[1,0] := 2.2;
  array_mis_select[1,1] := 2.02;
  array_mis_select[1,2] := 2.002;
  array_mis_select[1,3] := 2.22;
  array_mis_select[2,0] := 3.3;
  array_mis_select[2,1] := 3.03;
  array_mis_select[2,2] := 3.003;
  array_mis_select[2,3] := 3.33;
  array_mis_select[3,0] := 4.4;
  array_mis_select[3,1] := 4.04;
  array_mis_select[3,2] := 4.004;
  array_mis_select[3,3] := 4.44;

  isLimit_1 := True;
  isLimit_2 := True;

  C802_Off;
  isOn := False;
end;

procedure TPanelAtas.showImplicit(mis_num: Integer);
var I: Integer;
begin
  case mis_num of
    4:
      begin
        lstImplicitPanel_4.Clear;
        for I := 0 to 6 do
        begin
          if Implicit_4.FShow[I] then
            lstImplicitPanel_4.Items.Add(Implicit_panel[I])
          else lstImplicitPanel_4.Items.Add('');
        end;
      end;
    2:
      begin
        lstImplicitPanel_2.Clear;
        for I := 0 to 6 do
        begin
          if Implicit_2.FShow[I] then
            lstImplicitPanel_2.Items.Add(Implicit_panel[I])
          else lstImplicitPanel_2.Items.Add('');
        end;
      end;
    1:
      begin
        lstImplicitPanel_1.Clear;
        for I := 0 to 6 do
        begin
          if Implicit_1.FShow[I] then
            lstImplicitPanel_1.Items.Add(Implicit_panel[I])
          else lstImplicitPanel_1.Items.Add('');
        end;
      end;
    3:
      begin
        lstImplicitPanel_3.Clear;
        for I := 0 to 6 do
        begin
          if Implicit_3.FShow[I] then
            lstImplicitPanel_3.Items.Add(Implicit_panel[I])
          else lstImplicitPanel_3.Items.Add('');
        end;
      end;
  end;
end;

procedure TPanelAtas.MainMenu_On;
begin
  if Fan_Switch and AC_Switch {and Power_Switch} and DC_Switch then
  begin
//    PanelBawah.pnlStatusPage.Visible  := True;
//    PanelBawah.grpStartPage.Visible   := True;
    PanelBawah.ActivePage := PAGE_START;

    C802_On;
    isOn := True;
  end
  else begin
//    PanelBawah.pnlStatusPage.Visible  := False;
//    PanelBawah.grpStartPage.Visible   := False;

    C802_Off;
    isOn := False;
  end;

  PanelBawah.pnlStatusPage.Visible  := False;
  PanelBawah.grpStartPage.Visible   := False;
end;

end.
