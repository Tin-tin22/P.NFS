object FrmFOC: TFrmFOC
  Left = 243
  Top = 276
  Width = 356
  Height = 355
  Caption = 'FOC'
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
    Width = 345
    Height = 321
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 11
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
    object Label2: TLabel
      Left = 122
      Top = 147
      Width = 15
      Height = 14
      Alignment = taCenter
      Caption = 'Tn:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 90
      Top = 171
      Width = 46
      Height = 14
      Alignment = taCenter
      Caption = 'FOC Spd:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 68
      Top = 195
      Width = 68
      Height = 14
      Alignment = taCenter
      Caption = 'Sec FOC Spd:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 64
      Top = 219
      Width = 73
      Height = 14
      Alignment = taCenter
      Caption = 'Activation time:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 272
      Width = 346
      Height = 2
    end
    object Label3: TLabel
      Left = 104
      Top = 11
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Spd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 160
      Top = 11
      Width = 38
      Height = 13
      Alignment = taCenter
      Caption = 'Radius'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 232
      Top = 11
      Width = 55
      Height = 13
      Alignment = taCenter
      Caption = 'Time rem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 84
      Top = 245
      Width = 52
      Height = 14
      Alignment = taCenter
      Caption = 'FFOC time:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 142
      Top = 144
      Width = 59
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'A  1234'
    end
    object ListBox1: TListBox
      Left = 16
      Top = 32
      Width = 305
      Height = 105
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'A 1234           23.5        89.4            12:24'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      ParentFont = False
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 142
      Top = 168
      Width = 43
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '99.9'
    end
    object Edit3: TEdit
      Left = 142
      Top = 192
      Width = 43
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '99.9'
    end
    object Edit4: TEdit
      Left = 142
      Top = 216
      Width = 51
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '12:59'
    end
    object VrDemoButton1: TVrDemoButton
      Left = 5
      Top = 283
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
      Caption = 'OK'
      Color = clMedGray
      TabOrder = 5
    end
    object VrDemoButton2: TVrDemoButton
      Left = 72
      Top = 283
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
      TabOrder = 6
    end
    object VrDemoButton3: TVrDemoButton
      Left = 139
      Top = 283
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
      Caption = 'Reset'
      Color = clMedGray
      TabOrder = 7
    end
    object VrDemoButton4: TVrDemoButton
      Left = 206
      Top = 283
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
      Caption = 'Cancel'
      Color = clMedGray
      TabOrder = 8
    end
    object VrDemoButton5: TVrDemoButton
      Left = 273
      Top = 283
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
      TabOrder = 9
    end
    object Edit5: TEdit
      Left = 142
      Top = 240
      Width = 51
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = '12:59'
    end
    object VrDemoButton6: TVrDemoButton
      Left = 240
      Top = 142
      Width = 81
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
      Caption = 'Remove'
      Color = clMedGray
      TabOrder = 11
    end
  end
end
