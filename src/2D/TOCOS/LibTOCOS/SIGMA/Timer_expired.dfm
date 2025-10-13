object FrmTimer_expired: TFrmTimer_expired
  Left = 599
  Top = 147
  Width = 281
  Height = 140
  Caption = 'Timer expired'
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
      Left = 32
      Top = 9
      Width = 54
      Height = 16
      Alignment = taCenter
      Caption = 'Timer 2'
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
    object Label2: TLabel
      Left = 32
      Top = 28
      Width = 202
      Height = 16
      Alignment = taCenter
      Caption = 'Don'#39't forget trackrequest ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 2
      Width = 11
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
      Left = 89
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
  end
end
