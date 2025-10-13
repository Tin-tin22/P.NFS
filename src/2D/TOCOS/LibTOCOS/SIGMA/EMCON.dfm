object FrmEMCON: TFrmEMCON
  Left = 181
  Top = 104
  Width = 323
  Height = 198
  Caption = 'EMCON'
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
    Width = 313
    Height = 161
    Color = clMedGray
    TabOrder = 0
    object Bevel1: TBevel
      Left = 2
      Top = 45
      Width = 311
      Height = 2
    end
    object Label1: TLabel
      Left = 15
      Top = 57
      Width = 68
      Height = 13
      Alignment = taCenter
      Caption = 'Active plan:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 51
      Top = 89
      Width = 32
      Height = 13
      Alignment = taCenter
      Caption = 'Date:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 187
      Top = 57
      Width = 43
      Height = 13
      Alignment = taCenter
      Caption = 'T-start:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 187
      Top = 89
      Width = 41
      Height = 13
      Alignment = taCenter
      Caption = 'T-stop:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrClock1: TVrClock
      Left = 240
      Top = 51
      Width = 49
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object VrClock2: TVrClock
      Left = 240
      Top = 83
      Width = 49
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object Label5: TLabel
      Left = 88
      Top = 89
      Width = 80
      Height = 13
      Alignment = taCenter
      Caption = 'dd mm yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 2
      Top = 117
      Width = 311
      Height = 2
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 8
      Width = 136
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
      Caption = 'Edit plan 1 ...'
      Color = clMedGray
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 161
      Top = 8
      Width = 136
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
      Caption = 'Edit plan 2 ...'
      Color = clMedGray
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 90
      Top = 54
      Width = 63
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
      Text = '    -'
    end
    object VrDemoButton3: TVrDemoButton
      Left = 9
      Top = 128
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
    object VrDemoButton4: TVrDemoButton
      Left = 241
      Top = 128
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
  end
end
