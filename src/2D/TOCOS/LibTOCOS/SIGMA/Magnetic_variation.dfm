object FrmMagnetic_var: TFrmMagnetic_var
  Left = 295
  Top = 235
  Width = 348
  Height = 157
  Caption = 'Magnetic variation'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 121
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 41
      Width = 52
      Height = 13
      Alignment = taCenter
      Caption = 'Mag Var:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = -1
      Top = 77
      Width = 337
      Height = 2
    end
    object Label5: TLabel
      Left = 192
      Top = 9
      Width = 71
      Height = 13
      Alignment = taCenter
      Caption = 'Last update:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrClock1: TVrClock
      Left = 190
      Top = 24
      Width = 73
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 7
      Top = 86
      Width = 64
      Height = 25
      FontEnter.Charset = DEFAULT_CHARSET
      FontEnter.Color = clWhite
      FontEnter.Height = -11
      FontEnter.Name = 'Verdana'
      FontEnter.Style = [fsBold]
      FontLeave.Charset = DEFAULT_CHARSET
      FontLeave.Color = clWhite
      FontLeave.Height = -11
      FontLeave.Name = 'Verdana'
      FontLeave.Style = [fsBold]
      Caption = 'Quit'
      Color = clMedGray
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 267
      Top = 86
      Width = 64
      Height = 25
      FontEnter.Charset = DEFAULT_CHARSET
      FontEnter.Color = clWhite
      FontEnter.Height = -11
      FontEnter.Name = 'Verdana'
      FontEnter.Style = [fsBold]
      FontLeave.Charset = DEFAULT_CHARSET
      FontLeave.Color = clWhite
      FontLeave.Height = -11
      FontLeave.Name = 'Verdana'
      FontLeave.Style = [fsBold]
      Caption = 'Help'
      Color = clMedGray
      TabOrder = 1
    end
    object Edit1: TEdit
      Left = 78
      Top = 37
      Width = 43
      Height = 21
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
end
