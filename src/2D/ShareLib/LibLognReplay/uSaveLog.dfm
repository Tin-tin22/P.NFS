object frmSaveLog: TfrmSaveLog
  Left = 700
  Top = 248
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Record Name'
  ClientHeight = 147
  ClientWidth = 307
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 15
    Width = 275
    Height = 14
    Shape = bsTopLine
  end
  object Label7: TLabel
    Left = 17
    Top = 66
    Width = 94
    Height = 16
    Caption = 'Log File Name :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 17
    Top = 26
    Width = 54
    Height = 16
    Caption = 'Scenario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Bevel2: TBevel
    Left = 17
    Top = 93
    Width = 275
    Height = 14
    Shape = bsTopLine
  end
  object feScenarioName: TEdit
    Left = 128
    Top = 23
    Width = 167
    Height = 21
    Color = clWhite
    ReadOnly = True
    TabOrder = 0
  end
  object feLogName: TEdit
    Left = 128
    Top = 63
    Width = 167
    Height = 21
    Color = clWhite
    TabOrder = 1
  end
  object btnCancel: TAdvSmoothButton
    Left = 165
    Top = 102
    Width = 90
    Height = 25
    Appearance.Font.Charset = ANSI_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -13
    Appearance.Font.Name = 'Tahoma'
    Appearance.Font.Style = [fsBold]
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    BevelColor = clGray
    Caption = 'Batal'
    Color = clBlack
    ParentFont = False
    TabOrder = 2
    Version = '1.6.9.4'
    OnClick = btnCancelClick
  end
  object btnAccept: TAdvSmoothButton
    Left = 57
    Top = 102
    Width = 90
    Height = 25
    Appearance.Font.Charset = ANSI_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -13
    Appearance.Font.Name = 'Tahoma'
    Appearance.Font.Style = [fsBold]
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    BevelColor = clGray
    Caption = 'Simpan'
    Color = clBlack
    ParentFont = False
    TabOrder = 3
    Version = '1.6.9.4'
    OnClick = btnAcceptClick
  end
end
