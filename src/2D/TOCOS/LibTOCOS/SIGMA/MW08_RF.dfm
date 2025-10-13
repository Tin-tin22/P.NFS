object FrmMW08_RF: TFrmMW08_RF
  Left = 345
  Top = 302
  Width = 380
  Height = 460
  Caption = 'MW08 RF/PRF modes'
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
    Width = 369
    Height = 425
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 11
      Width = 102
      Height = 13
      Alignment = taCenter
      Caption = 'Operational mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 107
      Width = 64
      Height = 13
      Alignment = taCenter
      Caption = 'Scan mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 184
      Top = 107
      Width = 68
      Height = 13
      Alignment = taCenter
      Caption = 'RF channels'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 384
      Width = 369
      Height = 2
    end
    object VrPowerButton2: TVrPowerButton
      Left = 202
      Top = 32
      Width = 127
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Ducting mode'
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
      Left = 16
      Top = 28
      Width = 137
      Height = 69
      TabOrder = 1
      object RadioButton1: TRadioButton
        Left = 16
        Top = 16
        Width = 105
        Height = 17
        Caption = 'Surveillance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton2: TRadioButton
        Left = 16
        Top = 40
        Width = 105
        Height = 17
        Caption = 'Self defence'
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
      Left = 16
      Top = 124
      Width = 137
      Height = 253
      TabOrder = 2
      object RadioButton3: TRadioButton
        Left = 16
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Fixed 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton4: TRadioButton
        Left = 16
        Top = 40
        Width = 73
        Height = 17
        Caption = 'Fixed 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object RadioButton5: TRadioButton
        Left = 16
        Top = 64
        Width = 73
        Height = 17
        Caption = 'Fixed 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object RadioButton6: TRadioButton
        Left = 16
        Top = 88
        Width = 73
        Height = 17
        Caption = 'Fixed 4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object RadioButton7: TRadioButton
        Left = 16
        Top = 112
        Width = 73
        Height = 17
        Caption = 'Fixed 5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object RadioButton8: TRadioButton
        Left = 16
        Top = 136
        Width = 73
        Height = 17
        Caption = 'Fixed 6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object RadioButton9: TRadioButton
        Left = 16
        Top = 160
        Width = 73
        Height = 17
        Caption = 'Fixed 7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object RadioButton10: TRadioButton
        Left = 16
        Top = 184
        Width = 73
        Height = 17
        Caption = 'Fixed 8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object RadioButton11: TRadioButton
        Left = 16
        Top = 208
        Width = 57
        Height = 17
        Caption = 'Agile'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
    end
    object GroupBox3: TGroupBox
      Left = 192
      Top = 125
      Width = 161
      Height = 252
      TabOrder = 3
      object VrPowerButton1: TVrPowerButton
        Left = 18
        Top = 10
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object VrPowerButton3: TVrPowerButton
        Left = 18
        Top = 36
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object VrPowerButton4: TVrPowerButton
        Left = 18
        Top = 62
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object VrPowerButton5: TVrPowerButton
        Left = 18
        Top = 88
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object VrPowerButton6: TVrPowerButton
        Left = 18
        Top = 114
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object VrPowerButton7: TVrPowerButton
        Left = 18
        Top = 140
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object VrPowerButton8: TVrPowerButton
        Left = 18
        Top = 166
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object VrPowerButton9: TVrPowerButton
        Left = 18
        Top = 192
        Width = 103
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Channel 1'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object VrDemoButton1: TVrDemoButton
        Left = 41
        Top = 219
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
        Caption = 'Apply'
        Color = clMedGray
        TabOrder = 8
      end
    end
    object VrDemoButton2: TVrDemoButton
      Left = 9
      Top = 392
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
    object VrDemoButton3: TVrDemoButton
      Left = 297
      Top = 392
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
