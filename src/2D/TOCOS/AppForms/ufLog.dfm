object frmLog: TfrmLog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmLog'
  ClientHeight = 186
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 41
    Width = 274
    Height = 126
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'sf')
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 274
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 167
    Width = 274
    Height = 19
    Panels = <>
  end
end
