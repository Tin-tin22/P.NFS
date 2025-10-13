object vConnect: TvConnect
  Left = 1891
  Top = 324
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Connect'
  ClientHeight = 113
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Button1: TButton
    Left = 72
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 160
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object eServer: TComboBox
    Left = 72
    Top = 16
    Width = 193
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'localhost'
    OnChange = eServerChange
    Items.Strings = (
      '192.168.0.167'
      '192.168.0.151'
      'server'
      'localhost')
  end
end
