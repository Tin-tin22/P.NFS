object FrmGun_settings: TFrmGun_settings
  Left = 196
  Top = 114
  Width = 392
  Height = 480
  VertScrollBar.Position = 69
  Caption = '76mm Gun settings'
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
    Top = -69
    Width = 353
    Height = 515
    Color = clMedGray
    TabOrder = 0
    object Label6: TLabel
      Left = 8
      Top = 123
      Width = 61
      Height = 13
      Alignment = taCenter
      Caption = 'Gun barrel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 219
      Width = 62
      Height = 13
      Alignment = taCenter
      Caption = 'Gun report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 315
      Width = 69
      Height = 13
      Alignment = taCenter
      Caption = 'Fire settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 0
      Top = 464
      Width = 353
      Height = 2
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 1
      Width = 332
      Height = 112
      TabOrder = 0
      object Label1: TLabel
        Left = 96
        Top = 11
        Width = 35
        Height = 13
        Alignment = taCenter
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 136
        Top = 11
        Width = 97
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'On-line dorm'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 2
        Top = 32
        Width = 329
        Height = 2
      end
      object Label3: TLabel
        Left = 201
        Top = 45
        Width = 97
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'OK'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 3
        Top = 72
        Width = 329
        Height = 2
      end
      object Label4: TLabel
        Left = 16
        Top = 83
        Width = 57
        Height = 13
        Alignment = taCenter
        Caption = 'Bttl short:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 200
        Top = 83
        Width = 97
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Battle short'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object VrPowerButton1: TVrPowerButton
        Left = 40
        Top = 40
        Width = 121
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Operability test'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ComboBox1: TComboBox
        Left = 80
        Top = 80
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        Text = '     -'
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 136
      Width = 329
      Height = 73
      TabOrder = 1
      object Label7: TLabel
        Left = 16
        Top = 19
        Width = 49
        Height = 13
        Alignment = taCenter
        Caption = 'Position:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 224
        Top = 19
        Width = 13
        Height = 13
        Alignment = taCenter
        Caption = 'B:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 208
        Top = 43
        Width = 29
        Height = 13
        Alignment = taCenter
        Caption = 'Elev:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 248
        Top = 19
        Width = 36
        Height = 13
        Alignment = taCenter
        Caption = '000.0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 248
        Top = 43
        Width = 34
        Height = 13
        Alignment = taCenter
        Caption = '-00.0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ComboBox2: TComboBox
        Left = 78
        Top = 16
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Text = '     -'
      end
    end
    object GroupBox3: TGroupBox
      Left = 6
      Top = 232
      Width = 329
      Height = 73
      TabOrder = 2
      object Label13: TLabel
        Left = 16
        Top = 19
        Width = 44
        Height = 13
        Alignment = taCenter
        Caption = 'Access:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 65
        Top = 21
        Width = 97
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Remote'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 208
        Top = 8
        Width = 105
        Height = 57
        TabOrder = 0
        object RadioButton1: TRadioButton
          Left = 15
          Top = 12
          Width = 73
          Height = 17
          Caption = 'Power off'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RadioButton2: TRadioButton
          Left = 15
          Top = 32
          Width = 73
          Height = 17
          Caption = 'Power on'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 330
      Width = 329
      Height = 119
      TabOrder = 3
      object Label16: TLabel
        Left = 8
        Top = 18
        Width = 54
        Height = 13
        Alignment = taCenter
        Caption = 'Ballistics:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 8
        Top = 42
        Width = 53
        Height = 13
        Alignment = taCenter
        Caption = 'Fire rate:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 19
        Top = 66
        Width = 42
        Height = 13
        Alignment = taCenter
        Caption = 'Ammo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 6
        Top = 90
        Width = 54
        Height = 13
        Alignment = taCenter
        Caption = 'Par prox:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 192
        Top = 18
        Width = 37
        Height = 13
        Alignment = taCenter
        Caption = 'Vmuz:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 192
        Top = 42
        Width = 35
        Height = 13
        Alignment = taCenter
        Caption = 'Burst:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 192
        Top = 66
        Width = 36
        Height = 13
        Alignment = taCenter
        Caption = 'Coeff:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 280
        Top = 18
        Width = 22
        Height = 13
        Alignment = taCenter
        Caption = 'm/s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 280
        Top = 42
        Width = 6
        Height = 13
        Alignment = taCenter
        Caption = 's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 288
        Top = 66
        Width = 12
        Height = 13
        Alignment = taCenter
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object ComboBox3: TComboBox
        Left = 70
        Top = 16
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Text = 'Low'
      end
      object ComboBox4: TComboBox
        Left = 70
        Top = 40
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        Text = '     -'
      end
      object ComboBox5: TComboBox
        Left = 70
        Top = 64
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
        Text = '     -'
      end
      object ComboBox6: TComboBox
        Left = 70
        Top = 88
        Width = 89
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
        Text = '     -'
      end
      object Edit1: TEdit
        Left = 233
        Top = 13
        Width = 40
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '900'
      end
      object Edit2: TEdit
        Left = 233
        Top = 37
        Width = 40
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '10.0'
      end
      object Edit3: TEdit
        Left = 233
        Top = 61
        Width = 48
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '+10.0'
      end
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 475
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
      TabOrder = 4
    end
    object VrDemoButton2: TVrDemoButton
      Left = 281
      Top = 475
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
      TabOrder = 5
    end
  end
end
