object FrmEMCON_warning_hal103: TFrmEMCON_warning_hal103
  Left = 618
  Top = 224
  Width = 283
  Height = 164
  Caption = 'EMCON warning'
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
    Height = 129
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 9
      Width = 147
      Height = 16
      Alignment = taCenter
      Caption = '<subsystem name>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 85
      Width = 271
      Height = 2
    end
    object Label2: TLabel
      Left = 32
      Top = 33
      Width = 208
      Height = 16
      Alignment = taCenter
      Caption = '<as defined by EMCOMplan>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
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
    object Label4: TLabel
      Left = 88
      Top = 57
      Width = 73
      Height = 16
      Alignment = taCenter
      Caption = 'Continue?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 96
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
      Caption = 'Yes'
      Color = clMedGray
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 105
      Top = 96
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
      Caption = 'No'
      Color = clMedGray
      TabOrder = 1
    end
    object VrDemoButton3: TVrDemoButton
      Left = 201
      Top = 96
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
