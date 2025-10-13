object frmFiringCommand: TfrmFiringCommand
  Left = 477
  Top = 133
  Width = 889
  Height = 605
  Caption = 'Firing Command'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmfrmMain
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TAdvSmoothPanel
    Left = 0
    Top = 0
    Width = 881
    Height = 551
    Cursor = crDefault
    Caption.Location = plTopCenter
    Caption.HatchStyle = HatchStyleDiagonalBrick
    Caption.HTMLFont.Charset = DEFAULT_CHARSET
    Caption.HTMLFont.Color = clWindowText
    Caption.HTMLFont.Height = -13
    Caption.HTMLFont.Name = 'Tahoma'
    Caption.HTMLFont.Style = []
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -16
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = [fsBold]
    Caption.Top = 20
    Caption.ColorStart = clWhite
    Caption.ColorEnd = clWhite
    Caption.GradientType = gtHorizontal
    Caption.LineColor = clBlack
    Caption.Line = False
    Fill.Color = 7301478
    Fill.ColorTo = 10066329
    Fill.ColorMirror = 10066329
    Fill.ColorMirrorTo = 7301478
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clSilver
    Fill.BorderWidth = 5
    Fill.Rounding = 10
    Fill.ShadowColor = clNone
    Fill.ShadowOffset = 10
    Fill.Glow = gmNone
    Version = '1.0.9.6'
    Align = alClient
    TabOrder = 0
  end
  object mmfrmMain: TMainMenu
    Left = 488
    Top = 160
    object Application1: TMenuItem
      Caption = 'Application'
      object DisplayController1: TMenuItem
        Tag = 1
        Caption = 'Display Map'
        OnClick = DisplayController1Click
      end
      object DisplayFiringCommandProcedure1: TMenuItem
        Tag = 2
        Caption = 'Display Game Controller'
        OnClick = DisplayController1Click
      end
      object N1: TMenuItem
        Caption = '-----------------'
      end
      object Exit1: TMenuItem
        Tag = 10
        Caption = 'Exit'
        Visible = False
      end
    end
  end
end
