object FrmMan_over_rec: TFrmMan_over_rec
  Left = 157
  Top = 113
  Width = 386
  Height = 413
  Caption = 'Man overboard recovery'
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
    Width = 377
    Height = 377
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 61
      Height = 13
      Alignment = taCenter
      Caption = 'Ship'#39's side'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 141
      Width = 375
      Height = 2
    end
    object Label5: TLabel
      Left = 192
      Top = 8
      Width = 28
      Height = 13
      Alignment = taCenter
      Caption = 'Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 128
      Top = 115
      Width = 119
      Height = 13
      Alignment = taCenter
      Caption = 'Estimated proc time:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 1
      Top = 335
      Width = 376
      Height = 2
    end
    object Label10: TLabel
      Left = 200
      Top = 91
      Width = 57
      Height = 13
      Alignment = taCenter
      Caption = 'Tum rate:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 299
      Top = 92
      Width = 32
      Height = 13
      Alignment = taCenter
      Caption = 'deg/s'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 147
      Width = 68
      Height = 13
      Alignment = taCenter
      Caption = 'MW position'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 192
      Top = 155
      Width = 58
      Height = 13
      Alignment = taCenter
      Caption = 'Turn point'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrPowerButton1: TVrPowerButton
      Left = 144
      Top = 295
      Width = 89
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Display'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 25
      Width = 177
      Height = 56
      TabOrder = 1
      object RadioButton1: TRadioButton
        Left = 7
        Top = 12
        Width = 82
        Height = 17
        Caption = 'Starboard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton2: TRadioButton
        Left = 7
        Top = 28
        Width = 73
        Height = 17
        Caption = 'Port'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 192
      Top = 26
      Width = 177
      Height = 55
      TabOrder = 2
      object RadioButton3: TRadioButton
        Left = 7
        Top = 12
        Width = 114
        Height = 17
        Caption = 'Williamson turn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton4: TRadioButton
        Left = 7
        Top = 28
        Width = 106
        Height = 17
        Caption = 'Direct turn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object VrDemoButton5: TVrDemoButton
      Left = 9
      Top = 345
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
      TabOrder = 3
    end
    object VrDemoButton6: TVrDemoButton
      Left = 305
      Top = 345
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
      TabOrder = 4
    end
    object Edit6: TEdit
      Left = 258
      Top = 90
      Width = 37
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '1.0'
    end
    object GroupBox4: TGroupBox
      Left = 7
      Top = 172
      Width = 178
      Height = 53
      TabOrder = 6
      object Label15: TLabel
        Left = 37
        Top = 12
        Width = 25
        Height = 13
        Alignment = taCenter
        Caption = 'Brn:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 8
        Top = 30
        Width = 54
        Height = 13
        Alignment = taCenter
        Caption = 'Distance:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
    end
    object GroupBox5: TGroupBox
      Left = 193
      Top = 172
      Width = 176
      Height = 109
      TabOrder = 7
      object Label18: TLabel
        Left = 48
        Top = 20
        Width = 28
        Height = 13
        Alignment = taCenter
        Caption = 'TTG:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 49
        Top = 43
        Width = 27
        Height = 13
        Alignment = taCenter
        Caption = 'ETA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 47
        Top = 66
        Width = 29
        Height = 13
        Alignment = taCenter
        Caption = 'RTG:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 86
        Width = 52
        Height = 13
        Alignment = taCenter
        Caption = 'Final crs:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 104
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
      Caption = 'Start MOB'
      Color = clMedGray
      TabOrder = 8
    end
    object VrDemoButton2: TVrDemoButton
      Left = 9
      Top = 248
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
      Caption = 'Stop MOB'
      Color = clMedGray
      TabOrder = 9
    end
  end
end
