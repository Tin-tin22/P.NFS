object frmMain: TfrmMain
  Left = 192
  Top = 124
  Caption = 'frmMain'
  ClientHeight = 333
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 40
    Width = 201
    Height = 65
    Caption = 'Show Client Management'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 56
    Top = 128
    Width = 75
    Height = 25
    Caption = 'STOP'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 56
    Top = 160
    Width = 75
    Height = 25
    Caption = 'START'
    TabOrder = 2
    OnClick = Button3Click
  end
end
