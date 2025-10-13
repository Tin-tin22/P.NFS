object FrmExtSensor: TFrmExtSensor
  Left = 162
  Top = 114
  Width = 334
  Height = 245
  Caption = 'Ext. sensor & weapon coverage'
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
    Top = -3
    Width = 321
    Height = 212
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 75
      Top = 56
      Width = 38
      Height = 13
      Alignment = taCenter
      Caption = 'S-Ring'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 136
      Top = 56
      Width = 24
      Height = 13
      Alignment = taCenter
      Caption = 'TDA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 187
      Top = 56
      Width = 41
      Height = 13
      Alignment = taCenter
      Caption = 'W-Ring'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 11
      Top = 56
      Width = 15
      Height = 13
      Alignment = taCenter
      Caption = 'TN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 11
      Top = 24
      Width = 77
      Height = 13
      Alignment = taCenter
      Caption = 'Environment:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 168
      Width = 322
      Height = 2
    end
    object Label5: TLabel
      Left = 251
      Top = 56
      Width = 24
      Height = 13
      Alignment = taCenter
      Caption = 'TDA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object ListBox1: TListBox
      Left = 8
      Top = 74
      Width = 297
      Height = 87
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        
          'S  1234     045           Y          020           Y            ' +
          '  '
        
          'S  1235     160            -          020           -           ' +
          '   '
        
          'S  1774     075            -          030           Y           ' +
          '   ')
      ParentFont = False
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 252
      Top = 176
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
    object VrDemoButton3: TVrDemoButton
      Left = 7
      Top = 176
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
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 96
      Top = 8
      Width = 137
      Height = 41
      TabOrder = 3
      object RadioButton1: TRadioButton
        Left = 9
        Top = 15
        Width = 42
        Height = 17
        Caption = 'Air'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton2: TRadioButton
        Left = 57
        Top = 15
        Width = 72
        Height = 17
        Caption = 'Non-air'
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
end
