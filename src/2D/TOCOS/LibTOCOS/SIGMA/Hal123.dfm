object FrmHal123: TFrmHal123
  Left = 688
  Top = 112
  Width = 329
  Height = 480
  Caption = 'Hal123'
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
    Width = 305
    Height = 700
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 50
      Height = 13
      Alignment = taCenter
      Caption = 'Terminal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 121
      Width = 47
      Height = 13
      Alignment = taCenter
      Caption = 'Network'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 8
      Top = 305
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'DLRP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 8
      Top = 449
      Width = 73
      Height = 13
      Alignment = taCenter
      Caption = 'NCS settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 8
      Top = 561
      Width = 64
      Height = 13
      Alignment = taCenter
      Caption = 'NCS report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 648
      Width = 305
      Height = 2
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 22
      Width = 281
      Height = 91
      TabOrder = 0
      object Label5: TLabel
        Left = 34
        Top = 57
        Width = 81
        Height = 13
        Alignment = taCenter
        Caption = 'Station mode:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 18
        Top = 22
        Width = 49
        Height = 13
        Alignment = taCenter
        Caption = 'Own PU:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object ComboBox1: TComboBox
        Left = 134
        Top = 55
        Width = 123
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
        Text = '         -'
      end
      object VrPowerButton1: TVrPowerButton
        Left = 11
        Top = 15
        Width = 102
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Relay unit'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object VrPowerButton2: TVrPowerButton
        Left = 131
        Top = 15
        Width = 126
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
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 137
      Width = 281
      Height = 160
      TabOrder = 1
      object Label3: TLabel
        Left = 18
        Top = 22
        Width = 49
        Height = 13
        Alignment = taCenter
        Caption = 'Own PU:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 114
        Top = 22
        Width = 86
        Height = 13
        Alignment = taCenter
        Caption = 'Own platf freq:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 53
        Top = 86
        Width = 63
        Height = 13
        Alignment = taCenter
        Caption = 'NTN-limits:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 55
        Top = 110
        Width = 61
        Height = 13
        Alignment = taCenter
        Caption = 'Threshold:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 4
        Top = 134
        Width = 114
        Height = 13
        Alignment = taCenter
        Caption = 'Single report delay:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 157
        Top = 86
        Width = 5
        Height = 13
        Alignment = taCenter
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 157
        Top = 110
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
      object Label12: TLabel
        Left = 165
        Top = 134
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
      object Edit1: TEdit
        Left = 73
        Top = 16
        Width = 32
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ComboBox2: TComboBox
        Left = 206
        Top = 19
        Width = 67
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
        Text = '   -'
      end
      object VrPowerButton3: TVrPowerButton
        Left = 10
        Top = 47
        Width = 158
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Auto NTN authorization'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object VrPowerButton4: TVrPowerButton
        Left = 172
        Top = 47
        Width = 102
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Radio silence'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Edit2: TEdit
        Left = 119
        Top = 82
        Width = 32
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
        Text = '200'
      end
      object Edit3: TEdit
        Left = 119
        Top = 106
        Width = 32
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
        Text = '100'
      end
      object Edit4: TEdit
        Left = 167
        Top = 82
        Width = 42
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
        Text = '7776'
      end
      object Edit5: TEdit
        Left = 119
        Top = 130
        Width = 42
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = '10.0'
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 320
      Width = 281
      Height = 41
      TabOrder = 2
      object Label14: TLabel
        Left = 15
        Top = 15
        Width = 45
        Height = 13
        Alignment = taCenter
        Caption = 'Setting:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 135
        Top = 15
        Width = 53
        Height = 13
        Alignment = taCenter
        Caption = 'Last upd:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object VrClock1: TVrClock
        Left = 189
        Top = 11
        Width = 57
        Height = 25
        Threaded = True
        Palette.Low = clBlack
        Palette.High = clWhite
        Style = ns7x13
        Color = clMedGray
        ParentColor = False
      end
      object ComboBox3: TComboBox
        Left = 64
        Top = 12
        Width = 67
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
        Text = '   -'
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 358
      Width = 281
      Height = 83
      TabOrder = 3
      object Label16: TLabel
        Left = 24
        Top = 17
        Width = 22
        Height = 13
        Alignment = taCenter
        Caption = 'Lat:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 15
        Top = 49
        Width = 32
        Height = 13
        Alignment = taCenter
        Caption = 'Long:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 200
        Top = 8
        Width = 1
        Height = 76
      end
      object Label18: TLabel
        Left = 222
        Top = 25
        Width = 37
        Height = 13
        Alignment = taCenter
        Caption = 'Track:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Edit6: TEdit
        Left = 50
        Top = 16
        Width = 79
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '00-00.00 N'
      end
      object Edit7: TEdit
        Left = 50
        Top = 48
        Width = 87
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '000-00.00 W'
      end
      object VrDemoButton1: TVrDemoButton
        Left = 145
        Top = 14
        Width = 48
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
        Caption = 'Reset'
        Color = clMedGray
        TabOrder = 2
      end
      object VrDemoButton2: TVrDemoButton
        Left = 145
        Top = 46
        Width = 48
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
        Caption = 'Apply'
        Color = clMedGray
        TabOrder = 3
      end
      object Edit8: TEdit
        Left = 217
        Top = 48
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
        TabOrder = 4
      end
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 464
      Width = 281
      Height = 89
      TabOrder = 4
      object Label20: TLabel
        Left = 151
        Top = 12
        Width = 47
        Height = 13
        Alignment = taCenter
        Caption = 'Modern:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 135
        Top = 36
        Width = 65
        Height = 13
        Alignment = taCenter
        Caption = 'Encryption:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 135
        Top = 62
        Width = 65
        Height = 13
        Alignment = taCenter
        Caption = 'Priority PU:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object VrDemoButton3: TVrDemoButton
        Left = 9
        Top = 14
        Width = 112
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
        Caption = 'Define keys ...'
        Color = clMedGray
        TabOrder = 0
      end
      object VrPowerButton5: TVrPowerButton
        Left = 12
        Top = 55
        Width = 102
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Slow PUs'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ComboBox4: TComboBox
        Left = 200
        Top = 11
        Width = 67
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
        Text = '   -'
      end
      object ComboBox5: TComboBox
        Left = 200
        Top = 35
        Width = 57
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
        Text = '   -'
      end
      object Edit9: TEdit
        Left = 201
        Top = 59
        Width = 32
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
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 576
      Width = 281
      Height = 65
      TabOrder = 5
      object Label24: TLabel
        Left = 151
        Top = 12
        Width = 47
        Height = 13
        Alignment = taCenter
        Caption = 'Modern:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 135
        Top = 36
        Width = 65
        Height = 13
        Alignment = taCenter
        Caption = 'Encryption:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 200
        Top = 14
        Width = 46
        Height = 13
        Alignment = taCenter
        Caption = 'Mode 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label27: TLabel
        Left = 200
        Top = 38
        Width = 36
        Height = 13
        Alignment = taCenter
        Caption = 'Key 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrDemoButton4: TVrDemoButton
        Left = 9
        Top = 14
        Width = 112
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
        Caption = 'Define keys ...'
        Color = clMedGray
        TabOrder = 0
      end
    end
    object VrDemoButton5: TVrDemoButton
      Left = 9
      Top = 662
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
      TabOrder = 6
    end
    object VrDemoButton6: TVrDemoButton
      Left = 233
      Top = 662
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
end
