object frmNetSetting: TfrmNetSetting
  Left = 559
  Top = 319
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connect To Server 3D'
  ClientHeight = 115
  ClientWidth = 196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = -1
    Width = 193
    Height = 73
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 44
    Height = 13
    Caption = 'Server IP'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object Edit1: TEdit
    Left = 64
    Top = 16
    Width = 121
    Height = 21
    BevelKind = bkTile
    BorderStyle = bsNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    Text = '192.168.0.167'
    OnKeyDown = Edit1KeyDown
  end
  object Edit2: TEdit
    Left = 64
    Top = 39
    Width = 121
    Height = 21
    BevelKind = bkTile
    BorderStyle = bsNone
    TabOrder = 1
    Text = '2120'
  end
  object btnSet: TButton
    Left = 64
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Connect'
    ModalResult = 1
    TabOrder = 2
    OnClick = btnSetClick
  end
end
