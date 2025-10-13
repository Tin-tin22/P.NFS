object FrmLinkY_test: TFrmLinkY_test
  Left = 192
  Top = 114
  Width = 325
  Height = 413
  Caption = 'Link-Y test'
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
    Height = 377
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 11
      Width = 72
      Height = 13
      Alignment = taCenter
      Caption = 'Network test'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 32
      Width = 314
      Height = 2
    end
    object Bevel2: TBevel
      Left = -1
      Top = 336
      Width = 315
      Height = 2
    end
    object Label2: TLabel
      Left = 13
      Top = 235
      Width = 42
      Height = 14
      Alignment = taCenter
      Caption = 'Looptest'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 5
      Top = 344
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
      Left = 240
      Top = 344
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
    object GroupBox1: TGroupBox
      Left = 8
      Top = 40
      Width = 289
      Height = 185
      TabOrder = 2
      object Label3: TLabel
        Left = 13
        Top = 51
        Width = 44
        Height = 14
        Alignment = taCenter
        Caption = 'Trans PU'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 78
        Top = 51
        Width = 36
        Height = 14
        Alignment = taCenter
        Caption = 'Frames'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 134
        Top = 51
        Width = 61
        Height = 14
        Alignment = taCenter
        Caption = 'Error frames'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 222
        Top = 51
        Width = 19
        Height = 14
        Alignment = taCenter
        Caption = 'Rec'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object ListBox1: TListBox
        Left = 8
        Top = 72
        Width = 273
        Height = 105
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          '.    21          21             21              R'
          '.    04          21             12              '
          '.    05          21             00              R'
          '.    21        999           999              R'
          '.    21          21             21              R'
          '')
        ParentFont = False
        TabOrder = 0
      end
      object VrPowerButton1: TVrPowerButton
        Left = 11
        Top = 15
        Width = 102
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Network test'
        Color = clMedGray
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
      Left = 8
      Top = 248
      Width = 281
      Height = 81
      TabOrder = 3
      object Label4: TLabel
        Left = 125
        Top = 23
        Width = 68
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Running'
        Color = clOlive
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 125
        Top = 55
        Width = 68
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Not OK'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label9: TLabel
        Left = 205
        Top = 24
        Width = 27
        Height = 14
        Alignment = taCenter
        Caption = 'Error:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 205
        Top = 56
        Width = 27
        Height = 14
        Alignment = taCenter
        Caption = 'Error:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 237
        Top = 24
        Width = 18
        Height = 14
        Alignment = taCenter
        Caption = '001'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 237
        Top = 56
        Width = 18
        Height = 14
        Alignment = taCenter
        Caption = '001'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Label2'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrDemoButton3: TVrDemoButton
        Left = 5
        Top = 16
        Width = 108
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
        Caption = 'Short looptest'
        Color = clMedGray
        TabOrder = 0
      end
      object VrDemoButton4: TVrDemoButton
        Left = 5
        Top = 48
        Width = 108
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
        Caption = 'Long looptest'
        Color = clMedGray
        TabOrder = 1
      end
    end
  end
end
