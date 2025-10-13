object FrmLinkY_warning_NoNetwork: TFrmLinkY_warning_NoNetwork
  Left = 238
  Top = 240
  Width = 283
  Height = 140
  Caption = 'Link-Y Warning'
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
    Width = 273
    Height = 105
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 44
      Top = 25
      Width = 202
      Height = 16
      Alignment = taCenter
      Caption = 'No network synchronization'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 61
      Width = 271
      Height = 2
    end
    object Label3: TLabel
      Left = 12
      Top = 10
      Width = 12
      Height = 46
      Alignment = taCenter
      Caption = '!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -40
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 72
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
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 105
      Top = 72
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
      TabOrder = 1
    end
    object VrDemoButton3: TVrDemoButton
      Left = 201
      Top = 72
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
