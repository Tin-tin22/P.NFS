object FrmTimer_settings: TFrmTimer_settings
  Left = 374
  Top = 450
  Width = 469
  Height = 189
  Caption = 'Timer Settings'
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
    Width = 457
    Height = 153
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 44
      Height = 13
      Alignment = taCenter
      Caption = 'Timer 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 109
      Width = 456
      Height = 2
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 23
      Width = 441
      Height = 74
      TabOrder = 0
      object Label2: TLabel
        Left = 10
        Top = 13
        Width = 94
        Height = 13
        Alignment = taCenter
        Caption = 'Time remaining:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 10
        Top = 37
        Width = 30
        Height = 13
        Alignment = taCenter
        Caption = 'Text:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 210
        Top = 17
        Width = 57
        Height = 13
        Alignment = taCenter
        Caption = 'hh:mm ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 112
        Top = 13
        Width = 89
        Height = 21
        AutoSize = False
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '00:00 56'
      end
      object Edit2: TEdit
        Left = 48
        Top = 37
        Width = 385
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
        Text = 'Timer has expired!'
      end
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 120
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
      TabOrder = 1
    end
    object VrDemoButton2: TVrDemoButton
      Left = 385
      Top = 120
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
      TabOrder = 2
    end
  end
end
