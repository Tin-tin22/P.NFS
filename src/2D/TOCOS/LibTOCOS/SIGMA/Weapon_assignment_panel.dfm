object FrmWeapon_assign_panel: TFrmWeapon_assign_panel
  Left = 494
  Top = 297
  Width = 364
  Height = 220
  Caption = 'Weapon assignment panel'
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
    Width = 355
    Height = 185
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 25
      Top = 8
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = 'WASA:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 73
      Top = 8
      Width = 81
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Auto assign'
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
      Left = 1
      Top = 32
      Width = 353
      Height = 2
    end
    object Label3: TLabel
      Left = 9
      Top = 40
      Width = 62
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon 1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 75
      Width = 62
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon 2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 73
      Top = 40
      Width = 81
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sensor 1'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 73
      Top = 75
      Width = 81
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sensor 2'
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
      Left = 2
      Top = 104
      Width = 353
      Height = 2
    end
    object Bevel3: TBevel
      Left = 2
      Top = 144
      Width = 353
      Height = 2
    end
    object Label7: TLabel
      Left = 134
      Top = 155
      Width = 81
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'CHECK FIRE'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 167
      Top = 5
      Width = 99
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
      Text = '        -'
    end
    object VrDemoButton1: TVrDemoButton
      Left = 122
      Top = 112
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
      Caption = 'Check fire'
      Color = clMedGray
      TabOrder = 1
    end
    object VrPowerButton1: TVrPowerButton
      Left = 292
      Top = 39
      Width = 53
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'FA'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 167
      Top = 37
      Width = 82
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
      Text = '        -'
    end
    object ComboBox3: TComboBox
      Left = 167
      Top = 72
      Width = 82
      Height = 21
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
      Text = '        -'
    end
    object VrPowerButton2: TVrPowerButton
      Left = 292
      Top = 71
      Width = 53
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'FA'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object VrDemoButton2: TVrDemoButton
      Left = 10
      Top = 152
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
    object VrDemoButton3: TVrDemoButton
      Left = 282
      Top = 152
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
