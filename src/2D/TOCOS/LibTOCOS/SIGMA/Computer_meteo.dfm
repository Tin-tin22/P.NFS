object FrmComputer_meteo: TFrmComputer_meteo
  Left = 574
  Top = 41
  Width = 356
  Height = 388
  Caption = 'Computer meteo'
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
    Height = 353
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 11
      Width = 16
      Height = 13
      Alignment = taCenter
      Caption = 'Lvl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 57
      Top = 11
      Width = 17
      Height = 13
      Alignment = taCenter
      Caption = 'Dir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 112
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
    object Label4: TLabel
      Left = 178
      Top = 11
      Width = 56
      Height = 13
      Alignment = taCenter
      Caption = 'Virt Temp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 274
      Top = 11
      Width = 31
      Height = 13
      Alignment = taCenter
      Caption = 'Press'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 58
      Top = 163
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Level: 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 39
      Top = 187
      Width = 54
      Height = 13
      Alignment = taCenter
      Caption = 'Wind Dir:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 66
      Top = 211
      Width = 27
      Height = 13
      Alignment = taCenter
      Caption = 'Spd:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 154
      Top = 211
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
    object Label10: TLabel
      Left = 32
      Top = 235
      Width = 61
      Height = 13
      Alignment = taCenter
      Caption = 'Virt Temp:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 170
      Top = 235
      Width = 9
      Height = 13
      Alignment = taCenter
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 37
      Top = 259
      Width = 56
      Height = 13
      Alignment = taCenter
      Caption = 'Air Press:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 162
      Top = 259
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'mbar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 240
      Top = 257
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
    object VrClock1: TVrClock
      Left = 238
      Top = 272
      Width = 73
      Height = 25
      Threaded = True
      Palette.Low = clBlack
      Palette.High = clWhite
      Style = ns7x13
      Color = clMedGray
      ParentColor = False
    end
    object Bevel1: TBevel
      Left = -1
      Top = 301
      Width = 346
      Height = 2
    end
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 329
      Height = 121
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '17        000        000             000.0              0000'
        '16'
        '15'
        '14'
        '13'
        '12'
        '11')
      ParentFont = False
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 102
      Top = 181
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
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 102
      Top = 205
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
    object Edit3: TEdit
      Left = 102
      Top = 229
      Width = 59
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
    end
    object Edit4: TEdit
      Left = 102
      Top = 253
      Width = 51
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
    end
    object VrDemoButton1: TVrDemoButton
      Left = 239
      Top = 158
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
      Caption = 'Clear'
      Color = clMedGray
      TabOrder = 5
    end
    object VrDemoButton2: TVrDemoButton
      Left = 239
      Top = 190
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
      Caption = 'Clear All'
      Color = clMedGray
      TabOrder = 6
    end
    object VrPowerButton1: TVrPowerButton
      Left = 232
      Top = 223
      Width = 97
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Auto Level 1'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object VrDemoButton5: TVrDemoButton
      Left = 7
      Top = 312
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
      TabOrder = 8
    end
    object VrDemoButton3: TVrDemoButton
      Left = 74
      Top = 312
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
      TabOrder = 9
    end
    object VrDemoButton4: TVrDemoButton
      Left = 141
      Top = 312
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
      TabOrder = 10
    end
    object VrDemoButton6: TVrDemoButton
      Left = 208
      Top = 312
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
      TabOrder = 11
    end
    object VrDemoButton7: TVrDemoButton
      Left = 275
      Top = 312
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
      TabOrder = 12
    end
  end
end
