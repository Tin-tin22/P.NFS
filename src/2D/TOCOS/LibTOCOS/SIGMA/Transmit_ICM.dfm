object FrmTransmit_ICM: TFrmTransmit_ICM
  Left = 295
  Top = 121
  Width = 228
  Height = 279
  Caption = 'Transmit ICM'
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
    Width = 219
    Height = 241
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 75
      Height = 13
      Alignment = taCenter
      Caption = 'Active Roles:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 2
      Top = 199
      Width = 217
      Height = 2
    end
    object VrDemoButton3: TVrDemoButton
      Left = 168
      Top = 209
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
      Top = 210
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
    object Edit1: TEdit
      Left = 7
      Top = 29
      Width = 207
      Height = 164
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
  end
end
