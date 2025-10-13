object FrmTrial_man: TFrmTrial_man
  Left = 427
  Top = 148
  Width = 317
  Height = 140
  Caption = 'Trial manoeuvre'
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
    Width = 307
    Height = 105
    Color = clMedGray
    TabOrder = 0
    object Bevel1: TBevel
      Left = 2
      Top = 61
      Width = 315
      Height = 2
    end
    object Label2: TLabel
      Left = 48
      Top = 11
      Width = 51
      Height = 13
      Alignment = taCenter
      Caption = 'Own crs:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 48
      Top = 35
      Width = 54
      Height = 13
      Alignment = taCenter
      Caption = 'Own spd:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 144
      Top = 38
      Width = 17
      Height = 13
      Alignment = taCenter
      Caption = 'kts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrPowerButton1: TVrPowerButton
      Left = 200
      Top = 31
      Width = 89
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Active'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object VrDemoButton5: TVrDemoButton
      Left = 9
      Top = 73
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
      TabOrder = 1
    end
    object VrDemoButton6: TVrDemoButton
      Left = 233
      Top = 73
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
    object Edit2: TEdit
      Left = 107
      Top = 9
      Width = 46
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '000'
    end
    object Edit3: TEdit
      Left = 107
      Top = 34
      Width = 30
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0'
    end
  end
end
