object FrmEXOCET_monitoring_and_control: TFrmEXOCET_monitoring_and_control
  Left = 269
  Top = 169
  Width = 443
  Height = 306
  Caption = 'EXOCET monitoring and control'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 249
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 91
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon system'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 208
      Width = 433
      Height = 2
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 28
      Width = 409
      Height = 165
      TabOrder = 0
      object Label2: TLabel
        Left = 72
        Top = 20
        Width = 35
        Height = 13
        Alignment = taCenter
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 40
        Top = 40
        Width = 67
        Height = 13
        Alignment = taCenter
        Caption = 'Availability:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 25
        Top = 60
        Width = 82
        Height = 13
        Alignment = taCenter
        Caption = 'Configuration:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 60
        Top = 80
        Width = 47
        Height = 13
        Alignment = taCenter
        Caption = 'Activity:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 21
        Top = 101
        Width = 86
        Height = 13
        Alignment = taCenter
        Caption = 'Firing urgency:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 19
        Top = 121
        Width = 88
        Height = 13
        Alignment = taCenter
        Caption = 'Vert reference:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 20
        Top = 142
        Width = 87
        Height = 13
        Alignment = taCenter
        Caption = 'Blanking radio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 112
        Top = 20
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'On-line oper'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label10: TLabel
        Left = 112
        Top = 40
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Available'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label11: TLabel
        Left = 112
        Top = 60
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Centralized'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label12: TLabel
        Left = 112
        Top = 80
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Firing'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label13: TLabel
        Left = 112
        Top = 101
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Normal'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label14: TLabel
        Left = 112
        Top = 142
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Active'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label15: TLabel
        Left = 112
        Top = 121
        Width = 105
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Own ship'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object ComboBox1: TComboBox
        Left = 232
        Top = 75
        Width = 121
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Text = '      -'
      end
      object ComboBox2: TComboBox
        Left = 232
        Top = 99
        Width = 121
        Height = 21
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        Text = '      -'
      end
    end
    object VrDemoButton2: TVrDemoButton
      Left = 353
      Top = 216
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
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 392
    Top = 264
    object Settings1: TMenuItem
      Caption = 'Settings'
    end
  end
end
