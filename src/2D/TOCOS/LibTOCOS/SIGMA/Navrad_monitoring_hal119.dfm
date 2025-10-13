object FrmNAVRAD_monitoring_hal119: TFrmNAVRAD_monitoring_hal119
  Left = 410
  Top = 334
  Width = 390
  Height = 287
  Caption = 'NAVRAD monitoring'
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
    Left = -2
    Top = 0
    Width = 379
    Height = 249
    Color = clMedGray
    TabOrder = 0
    object Bevel2: TBevel
      Left = 6
      Top = 199
      Width = 371
      Height = 2
    end
    object Label3: TLabel
      Left = 8
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
    object Label4: TLabel
      Left = 88
      Top = 11
      Width = 20
      Height = 13
      Alignment = taCenter
      Caption = 'Snr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 136
      Top = 11
      Width = 20
      Height = 13
      Alignment = taCenter
      Caption = 'Brn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 184
      Top = 11
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Rng'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 264
      Top = 11
      Width = 24
      Height = 13
      Alignment = taCenter
      Caption = 'CPA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 328
      Top = 11
      Width = 36
      Height = 13
      Alignment = taCenter
      Caption = 'T-CPA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object VrDemoButton3: TVrDemoButton
      Left = 320
      Top = 211
      Width = 49
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
      TabOrder = 0
    end
    object VrDemoButton4: TVrDemoButton
      Left = 8
      Top = 213
      Width = 49
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
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 361
      Height = 153
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        
          'A  1234        00         000      0000.0           00.0        ' +
          '  +960'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      ParentFont = False
      TabOrder = 2
    end
  end
end
