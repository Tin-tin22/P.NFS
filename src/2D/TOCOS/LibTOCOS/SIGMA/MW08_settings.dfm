object FrmMW08_settings: TFrmMW08_settings
  Left = 286
  Top = 135
  Width = 427
  Height = 418
  Caption = 'MW08 settings'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 361
    Color = clMedGray
    TabOrder = 0
    object Label5: TLabel
      Left = 16
      Top = 97
      Width = 47
      Height = 13
      Alignment = taCenter
      Caption = 'Antenna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 185
      Width = 66
      Height = 13
      Alignment = taCenter
      Caption = 'Transmitter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 312
      Width = 417
      Height = 2
    end
    object VrDemoButton1: TVrDemoButton
      Left = 13
      Top = 323
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
    object VrPowerButton2: TVrPowerButton
      Left = 26
      Top = 272
      Width = 151
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Jammer detection'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 393
      Height = 41
      TabOrder = 2
      object Label1: TLabel
        Left = 56
        Top = 17
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
        Left = 104
        Top = 17
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'On-line dormant'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 48
      Width = 393
      Height = 41
      TabOrder = 3
      object Label3: TLabel
        Left = 32
        Top = 17
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
      object Label4: TLabel
        Left = 216
        Top = 17
        Width = 153
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Bttl short:'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ComboBox1: TComboBox
        Left = 98
        Top = 13
        Width = 95
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
        Text = '       -'
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 112
      Width = 393
      Height = 65
      TabOrder = 4
      object Label6: TLabel
        Left = 35
        Top = 17
        Width = 47
        Height = 13
        Alignment = taCenter
        Caption = 'B-drive:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 24
        Top = 38
        Width = 58
        Height = 13
        Alignment = taCenter
        Caption = 'Stabilizer:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 88
        Top = 17
        Width = 113
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'On'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label9: TLabel
        Left = 88
        Top = 41
        Width = 113
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Startup'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ComboBox2: TComboBox
        Left = 224
        Top = 13
        Width = 145
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
        Text = '             -'
      end
      object ComboBox3: TComboBox
        Left = 224
        Top = 37
        Width = 145
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
        Text = '             -'
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 200
      Width = 393
      Height = 65
      TabOrder = 5
      object Label11: TLabel
        Left = 43
        Top = 17
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
      object Label12: TLabel
        Left = 16
        Top = 38
        Width = 63
        Height = 13
        Alignment = taCenter
        Caption = 'Waveg sw:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 88
        Top = 17
        Width = 113
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Transmitting'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label14: TLabel
        Left = 88
        Top = 41
        Width = 113
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'On waveguide'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ComboBox4: TComboBox
        Left = 224
        Top = 13
        Width = 145
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
        Text = '             -'
      end
    end
    object VrPowerButton1: TVrPowerButton
      Left = 226
      Top = 272
      Width = 151
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Tx authorized'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object VrDemoButton2: TVrDemoButton
      Left = 341
      Top = 323
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
      TabOrder = 7
    end
  end
  object MainMenu1: TMainMenu
    Left = 360
    Top = 88
    object ransm1: TMenuItem
      Caption = 'Transm'
    end
    object Receiv1: TMenuItem
      Caption = 'Receiv'
    end
    object Areas1: TMenuItem
      Caption = 'Areas'
    end
  end
end
