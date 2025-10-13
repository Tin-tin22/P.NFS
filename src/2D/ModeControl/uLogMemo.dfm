object frmLogMemo: TfrmLogMemo
  Left = 0
  Top = 0
  Caption = 'Log Memo'
  ClientHeight = 311
  ClientWidth = 256
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
    Width = 257
    Height = 313
    TabOrder = 0
    object mmoLogMemo: TMemo
      Left = 1
      Top = 1
      Width = 255
      Height = 311
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitWidth = 399
      ExplicitHeight = 319
    end
  end
end
