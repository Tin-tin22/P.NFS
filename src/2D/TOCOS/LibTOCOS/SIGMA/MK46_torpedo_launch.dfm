object FrmMK46_torpedo_launch: TFrmMK46_torpedo_launch
  Left = 326
  Top = 113
  Width = 364
  Height = 302
  Caption = 'MK46 torpedo launch'
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
    Width = 353
    Height = 265
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 24
      Width = 133
      Height = 13
      Alignment = taCenter
      Caption = 'Own launched torpedo:'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 64
      Width = 353
      Height = 2
    end
    object Label2: TLabel
      Left = 32
      Top = 88
      Width = 62
      Height = 13
      Alignment = taCenter
      Caption = 'Helicopter:'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 52
      Top = 112
      Width = 44
      Height = 13
      Alignment = taCenter
      Caption = 'Att rng:'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 152
      Top = 112
      Width = 26
      Height = 13
      Alignment = taCenter
      Caption = 'kyrd'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 40
      Top = 136
      Width = 56
      Height = 13
      Alignment = taCenter
      Caption = 'Att angle:'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 168
      Width = 353
      Height = 2
    end
    object Bevel3: TBevel
      Left = 0
      Top = 216
      Width = 353
      Height = 2
    end
    object Edit1: TEdit
      Left = 104
      Top = 85
      Width = 57
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
      Text = 'H 1234'
    end
    object VrDemoButton1: TVrDemoButton
      Left = 192
      Top = 20
      Width = 129
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
      Caption = 'Confirm launch'
      Color = clMedGray
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 192
      Top = 80
      Width = 129
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
      Text = '             -'
    end
    object Edit2: TEdit
      Left = 104
      Top = 109
      Width = 41
      Height = 21
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '00.0'
    end
    object Edit3: TEdit
      Left = 104
      Top = 133
      Width = 33
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
      Text = '000'
    end
    object VrDemoButton2: TVrDemoButton
      Left = 192
      Top = 132
      Width = 129
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
      Caption = 'Confirm launch'
      Color = clMedGray
      TabOrder = 5
    end
    object VrDemoButton3: TVrDemoButton
      Left = 80
      Top = 180
      Width = 193
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
      Caption = 'Stop post-launch display'
      Color = clMedGray
      TabOrder = 6
    end
    object VrDemoButton4: TVrDemoButton
      Left = 8
      Top = 228
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
      TabOrder = 7
    end
    object VrDemoButton5: TVrDemoButton
      Left = 280
      Top = 228
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
      TabOrder = 8
    end
  end
end
