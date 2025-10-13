object frmLogMemo: TfrmLogMemo
  Left = 0
  Top = 0
  Caption = 'Log Memo'
  ClientHeight = 321
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMemo: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 321
    Align = alLeft
    TabOrder = 0
    object mmoLogMemo: TMemo
      Left = 1
      Top = 1
      Width = 399
      Height = 319
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object pnlSetting: TPanel
    Left = 401
    Top = 0
    Width = 282
    Height = 321
    Align = alClient
    TabOrder = 1
    object mmoSetting: TMemo
      Left = 1
      Top = 1
      Width = 280
      Height = 319
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
end
