object frmBlankScreen: TfrmBlankScreen
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 1080
  ClientWidth = 1920
  Color = clBtnText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object btnExit: TButton
    Left = 25
    Top = 25
    Width = 105
    Height = 65
    Caption = 'EXIT - F8'
    TabOrder = 0
    Visible = False
    OnClick = btnExitClick
  end
end
