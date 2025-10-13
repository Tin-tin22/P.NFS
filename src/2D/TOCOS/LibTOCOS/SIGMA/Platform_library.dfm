object FrmPlatform_library: TFrmPlatform_library
  Left = 441
  Top = 187
  Width = 426
  Height = 454
  Caption = 'Platform library'
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
    Width = 417
    Height = 417
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 122
      Height = 13
      Alignment = taCenter
      Caption = 'Library last modified:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrClock1: TVrClock
      Left = 136
      Top = 8
      Width = 49
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 45
      Width = 417
      Height = 2
    end
    object Bevel2: TBevel
      Left = 0
      Top = 373
      Width = 417
      Height = 2
    end
    object DateTimePicker1: TDateTimePicker
      Left = 184
      Top = 10
      Width = 225
      Height = 21
      CalColors.MonthBackColor = clMedGray
      Date = 39356.577526574070000000
      Time = 39356.577526574070000000
      Color = clMedGray
      DateFormat = dfLong
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 49
      Width = 404
      Height = 144
      TabOrder = 1
      object Label2: TLabel
        Left = 144
        Top = 21
        Width = 140
        Height = 13
        Alignment = taCenter
        Caption = '12345678901234567890'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 147
        Top = 53
        Width = 140
        Height = 13
        Alignment = taCenter
        Caption = '12345678901234567890'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 19
        Top = 81
        Width = 102
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Caption = 'Not related'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object VrDemoButton5: TVrDemoButton
        Left = 17
        Top = 14
        Width = 104
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
        Caption = 'Nation ...'
        Color = clMedGray
        TabOrder = 0
      end
      object VrDemoButton1: TVrDemoButton
        Left = 17
        Top = 46
        Width = 104
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
        Caption = 'Class ...'
        Color = clMedGray
        TabOrder = 1
      end
      object VrDemoButton2: TVrDemoButton
        Left = 153
        Top = 78
        Width = 104
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
        Caption = 'Add class'
        Color = clMedGray
        TabOrder = 2
      end
      object VrDemoButton3: TVrDemoButton
        Left = 273
        Top = 78
        Width = 104
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
        Caption = 'Remove class'
        Color = clMedGray
        TabOrder = 3
      end
      object VrDemoButton4: TVrDemoButton
        Left = 153
        Top = 110
        Width = 104
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
        Caption = 'Weapons ...'
        Color = clMedGray
        TabOrder = 4
      end
      object VrDemoButton6: TVrDemoButton
        Left = 273
        Top = 110
        Width = 104
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
        Caption = 'Sensors ...'
        Color = clMedGray
        TabOrder = 5
      end
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 193
      Width = 404
      Height = 112
      TabOrder = 2
      object Label5: TLabel
        Left = 147
        Top = 21
        Width = 70
        Height = 13
        Alignment = taCenter
        Caption = '1234567890'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 147
        Top = 53
        Width = 140
        Height = 13
        Alignment = taCenter
        Caption = '12345678901234567890'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 59
        Top = 53
        Width = 63
        Height = 13
        Alignment = taCenter
        Caption = 'Unit name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object VrDemoButton7: TVrDemoButton
        Left = 17
        Top = 14
        Width = 104
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
        Caption = 'Side nr ...'
        Color = clMedGray
        TabOrder = 0
      end
      object VrDemoButton11: TVrDemoButton
        Left = 153
        Top = 78
        Width = 104
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
        Caption = 'Weapons ...'
        Color = clMedGray
        TabOrder = 1
      end
      object VrDemoButton12: TVrDemoButton
        Left = 273
        Top = 78
        Width = 104
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
        Caption = 'Sensors ...'
        Color = clMedGray
        TabOrder = 2
      end
    end
    object VrDemoButton8: TVrDemoButton
      Left = 25
      Top = 310
      Width = 176
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
      Caption = 'Weapon library ...'
      Color = clMedGray
      TabOrder = 3
    end
    object VrDemoButton9: TVrDemoButton
      Left = 217
      Top = 310
      Width = 176
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
      Caption = 'Sensor library ...'
      Color = clMedGray
      TabOrder = 4
    end
    object VrDemoButton10: TVrDemoButton
      Left = 25
      Top = 342
      Width = 368
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
      Caption = 'Release new platform library'
      Color = clMedGray
      TabOrder = 5
    end
    object VrDemoButton13: TVrDemoButton
      Left = 9
      Top = 382
      Width = 72
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
      TabOrder = 6
    end
    object VrDemoButton14: TVrDemoButton
      Left = 337
      Top = 382
      Width = 72
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
      TabOrder = 7
    end
  end
end
