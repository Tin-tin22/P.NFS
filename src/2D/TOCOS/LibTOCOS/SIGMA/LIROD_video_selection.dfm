object FrmLIROD_video_selection: TFrmLIROD_video_selection
  Left = 192
  Top = 114
  Width = 268
  Height = 203
  Caption = 'LIROD video selection'
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
    Width = 257
    Height = 169
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 20
      Width = 34
      Height = 13
      Alignment = taCenter
      Caption = 'TU in:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 56
      Top = 44
      Width = 42
      Height = 13
      Alignment = taCenter
      Caption = 'TU out:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 53
      Top = 68
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Chan 1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 53
      Top = 92
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Chan 2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 120
      Width = 258
      Height = 2
    end
    object ComboBox1: TComboBox
      Left = 104
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
    object ComboBox2: TComboBox
      Left = 104
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
    object ComboBox3: TComboBox
      Left = 104
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
    object ComboBox4: TComboBox
      Left = 104
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
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 134
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
      Left = 185
      Top = 134
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
