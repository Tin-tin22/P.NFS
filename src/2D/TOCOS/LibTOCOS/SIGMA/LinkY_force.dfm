object FrmLinkY_force: TFrmLinkY_force
  Left = 658
  Top = 190
  Width = 323
  Height = 365
  Caption = 'Link-Y Force Engagement'
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
    Width = 313
    Height = 329
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 11
      Width = 52
      Height = 13
      Alignment = taCenter
      Caption = 'Weapons'
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
      Width = 49
      Height = 13
      Alignment = taCenter
      Caption = 'Own PU:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 242
      Top = 67
      Width = 16
      Height = 13
      Alignment = taCenter
      Caption = '01'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 10
      Top = 131
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Unit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 58
      Top = 131
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 141
      Top = 131
      Width = 36
      Height = 13
      Alignment = taCenter
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 210
      Top = 131
      Width = 18
      Height = 13
      Alignment = taCenter
      Caption = 'Tgt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 266
      Top = 131
      Width = 17
      Height = 13
      Alignment = taCenter
      Caption = 'CU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 288
      Width = 313
      Height = 2
    end
    object VrPowerButton1: TVrPowerButton
      Left = 174
      Top = 27
      Width = 102
      Height = 25
      Palette.Low = clGray
      Palette.High = clLime
      Caption = 'Auto report'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 24
      Width = 129
      Height = 97
      TabOrder = 1
      object VrPowerButton2: TVrPowerButton
        Left = 6
        Top = 11
        Width = 67
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Guns'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object VrPowerButton3: TVrPowerButton
        Left = 6
        Top = 39
        Width = 96
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'ASW Helo'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object VrPowerButton4: TVrPowerButton
        Left = 6
        Top = 67
        Width = 68
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'SSM'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object ListBox1: TListBox
      Left = 8
      Top = 152
      Width = 289
      Height = 121
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '1234    Dpth-Bomb     Not-avail     0200       00'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      ParentFont = False
      TabOrder = 2
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 296
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
      Caption = 'Quit'
      Color = clMedGray
      TabOrder = 3
    end
    object VrDemoButton2: TVrDemoButton
      Left = 241
      Top = 296
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
      TabOrder = 4
    end
  end
end
