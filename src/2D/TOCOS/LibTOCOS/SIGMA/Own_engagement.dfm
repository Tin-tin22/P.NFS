object FrmOwn_engagement: TFrmOwn_engagement
  Left = 196
  Top = 266
  Width = 332
  Height = 205
  Caption = 'Own engagements'
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
    Width = 321
    Height = 169
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 8
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = 'Sensor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 128
      Width = 321
      Height = 2
    end
    object Label2: TLabel
      Left = 96
      Top = 8
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 195
      Top = 8
      Width = 37
      Height = 13
      Alignment = taCenter
      Caption = 'Target'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 275
      Top = 8
      Width = 21
      Height = 13
      Alignment = taCenter
      Caption = 'Env'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 10
      Top = 136
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
    object ListBox1: TListBox
      Left = 8
      Top = 26
      Width = 305
      Height = 87
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'Sensor1         Weapon1            2 0576            A'
        'Sensor2         Weapon2            3 1236            S'
        '')
      ParentFont = False
      TabOrder = 1
    end
    object VrDemoButton2: TVrDemoButton
      Left = 250
      Top = 136
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
      TabOrder = 2
    end
  end
end
