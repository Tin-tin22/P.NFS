object FrmBarrometric_pressure: TFrmBarrometric_pressure
  Left = 275
  Top = 166
  Width = 346
  Height = 155
  Caption = 'Barrometric pressure'
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
    Width = 337
    Height = 121
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 9
      Width = 45
      Height = 13
      Alignment = taCenter
      Caption = 'Source:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 77
      Width = 337
      Height = 2
    end
    object Label5: TLabel
      Left = 224
      Top = 25
      Width = 71
      Height = 13
      Alignment = taCenter
      Caption = 'Last update:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 43
      Width = 78
      Height = 13
      Alignment = taCenter
      Caption = 'Barom Press:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrClock1: TVrClock
      Left = 222
      Top = 40
      Width = 73
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object VrDemoButton5: TVrDemoButton
      Left = 3
      Top = 87
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
    object VrDemoButton6: TVrDemoButton
      Left = 271
      Top = 88
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
    object Edit1: TEdit
      Left = 102
      Top = 37
      Width = 43
      Height = 21
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ComboBox1: TComboBox
      Left = 102
      Top = 6
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
      TabOrder = 3
      Text = 'Manual'
    end
  end
end
