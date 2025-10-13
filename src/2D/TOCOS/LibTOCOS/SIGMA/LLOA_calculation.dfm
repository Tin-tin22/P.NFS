object FrmLLOA_calculation: TFrmLLOA_calculation
  Left = 215
  Top = 273
  Width = 358
  Height = 288
  Caption = 'LLOA calculation'
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
    Height = 249
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 11
      Width = 68
      Height = 26
      Alignment = taCenter
      Caption = 'Threatening'#13#10'Tracks:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 186
      Top = 67
      Width = 46
      Height = 14
      Alignment = taCenter
      Caption = 'LLSu spd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 178
      Top = 91
      Width = 54
      Height = 14
      Alignment = taCenter
      Caption = 'LLSuA spd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 200
      Top = 115
      Width = 34
      Height = 14
      Alignment = taCenter
      Caption = 'FC spd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 190
      Top = 139
      Width = 45
      Height = 14
      Alignment = taCenter
      Caption = 'Base Crs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 208
      Width = 346
      Height = 2
    end
    object Edit1: TEdit
      Left = 246
      Top = 64
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
    end
    object ListBox1: TListBox
      Left = 24
      Top = 48
      Width = 105
      Height = 105
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        's 1234'
        's 4523')
      ParentFont = False
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 246
      Top = 88
      Width = 59
      Height = 21
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
      Left = 246
      Top = 112
      Width = 59
      Height = 21
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
      Left = 246
      Top = 136
      Width = 59
      Height = 21
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object VrPowerButton2: TVrPowerButton
      Left = 162
      Top = 16
      Width = 143
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Displ. LLOA on TDA'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object VrDemoButton1: TVrDemoButton
      Left = 5
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
      Caption = 'OK'
      Color = clMedGray
      TabOrder = 6
    end
    object VrDemoButton2: TVrDemoButton
      Left = 72
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
      TabOrder = 7
    end
    object VrDemoButton3: TVrDemoButton
      Left = 139
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
      Caption = 'Reset'
      Color = clMedGray
      TabOrder = 8
    end
    object VrDemoButton4: TVrDemoButton
      Left = 206
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
      Caption = 'Cancel'
      Color = clMedGray
      TabOrder = 9
    end
    object VrDemoButton5: TVrDemoButton
      Left = 273
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
      Caption = 'Help'
      Color = clMedGray
      TabOrder = 10
    end
  end
end
