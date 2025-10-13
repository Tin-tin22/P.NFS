object frmLogs: TfrmLogs
  Left = 1010
  Top = 234
  Width = 314
  Height = 607
  Caption = 'Logs...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 182
    Width = 306
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 395
    Width = 306
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object netLogClient: TMemo
    Left = 0
    Top = 0
    Width = 306
    Height = 182
    Align = alTop
    TabOrder = 0
  end
  object netLogServer: TMemo
    Left = 0
    Top = 185
    Width = 306
    Height = 210
    Align = alClient
    TabOrder = 1
  end
  object mmLog: TMemo
    Left = 0
    Top = 398
    Width = 306
    Height = 182
    Align = alBottom
    TabOrder = 2
  end
end
