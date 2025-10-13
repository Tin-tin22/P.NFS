object Form1: TForm1
  Left = 654
  Top = 136
  Width = 546
  Height = 582
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 8
    Top = 8
    Width = 489
    Height = 201
    Caption = 'Primary Items'
    Color = clMedGray
    TabOrder = 0
    object Label2: TLabel
      Left = 14
      Top = 11
      Width = 36
      Height = 13
      Alignment = taCenter
      Caption = 'Scale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 110
      Top = 11
      Width = 29
      Height = 13
      Alignment = taCenter
      Caption = 'Grid:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 238
      Top = 11
      Width = 42
      Height = 13
      Alignment = taCenter
      Caption = 'Motion:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 342
      Top = 11
      Width = 20
      Height = 13
      Alignment = taCenter
      Caption = 'ST:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 414
      Top = 11
      Width = 23
      Height = 13
      Alignment = taCenter
      Caption = 'CC:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 54
      Top = 9
      Width = 51
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
      Text = '256'
      Items.Strings = (
        '0.5'
        '1.0'
        '2.0'
        '4.0'
        '8.0'
        '16.0'
        '24.0'
        '32.0'
        '48.0'
        '64.0'
        '128.0'
        '256.0'
        '512.0')
    end
    object ComboBox2: TComboBox
      Left = 142
      Top = 9
      Width = 91
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
      Text = 'Geografic'
      Items.Strings = (
        'Rng/Brn'
        'Geograpic'
        'Tactical'
        'Surface')
    end
    object ComboBox3: TComboBox
      Left = 286
      Top = 9
      Width = 51
      Height = 21
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
      Text = 'Rel'
      Items.Strings = (
        'Rel'
        'True')
    end
    object Edit1: TEdit
      Left = 369
      Top = 8
      Width = 40
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
      Text = '0001'
    end
    object Edit2: TEdit
      Left = 441
      Top = 8
      Width = 40
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
      Text = '0001'
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 32
      Width = 97
      Height = 153
      Caption = 'Primary Items'
      TabOrder = 5
      object VrPowerButton1: TVrPowerButton
        Left = 7
        Top = 14
        Width = 64
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Scale'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object VrPowerButton2: TVrPowerButton
        Left = 7
        Top = 41
        Width = 58
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Grid'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object VrPowerButton3: TVrPowerButton
        Left = 7
        Top = 68
        Width = 68
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Motion'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object VrPowerButton4: TVrPowerButton
        Left = 7
        Top = 121
        Width = 47
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'CC'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object VrPowerButton5: TVrPowerButton
        Left = 7
        Top = 94
        Width = 45
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'ST'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 240
    Width = 489
    Height = 145
    Caption = 'Secondary Items'
    Color = clMedGray
    TabOrder = 1
    object Label7: TLabel
      Left = 14
      Top = 11
      Width = 25
      Height = 13
      Alignment = taCenter
      Caption = 'Brn:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 14
      Top = 35
      Width = 27
      Height = 13
      Alignment = taCenter
      Caption = 'Rng:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 102
      Top = 11
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Lat:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 94
      Top = 35
      Width = 32
      Height = 13
      Alignment = taCenter
      Caption = 'Long:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 222
      Top = 11
      Width = 24
      Height = 13
      Alignment = taCenter
      Caption = 'Ref:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 302
      Top = 11
      Width = 31
      Height = 13
      Alignment = taCenter
      Caption = 'Prim:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 305
      Top = 35
      Width = 26
      Height = 13
      Alignment = taCenter
      Caption = 'Sec:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Edit3: TEdit
      Left = 129
      Top = 8
      Width = 80
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
      Text = '00-00.00 N'
    end
    object Edit4: TEdit
      Left = 249
      Top = 8
      Width = 40
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
      Text = '0001'
    end
    object Edit5: TEdit
      Left = 41
      Top = 8
      Width = 40
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
      Text = '128.0'
    end
    object Edit6: TEdit
      Left = 41
      Top = 32
      Width = 40
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
      Text = '16.85'
    end
    object Edit7: TEdit
      Left = 129
      Top = 32
      Width = 88
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
      Text = '000-00.00 W'
    end
    object GroupBox4: TGroupBox
      Left = 336
      Top = 8
      Width = 97
      Height = 129
      Caption = 'Secondary Items'
      TabOrder = 5
      object VrPowerButton6: TVrPowerButton
        Left = 7
        Top = 14
        Width = 82
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Rng/Brn'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object VrPowerButton7: TVrPowerButton
        Left = 7
        Top = 41
        Width = 58
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Grid'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object VrPowerButton8: TVrPowerButton
        Left = 7
        Top = 68
        Width = 58
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Ref'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object VrPowerButton10: TVrPowerButton
        Left = 7
        Top = 94
        Width = 66
        Height = 25
        Palette.Low = clGray
        Palette.High = clLime
        Caption = 'Video'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 417
    Width = 297
    Height = 49
    TabOrder = 2
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 16
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
      Caption = 'Menus'
      Color = clMedGray
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 81
      Top = 16
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
      Caption = 'Tools'
      Color = clMedGray
      TabOrder = 1
    end
    object VrDemoButton3: TVrDemoButton
      Left = 153
      Top = 16
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
      Caption = 'Prim'
      Color = clMedGray
      TabOrder = 2
    end
    object VrDemoButton4: TVrDemoButton
      Left = 225
      Top = 16
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
      Caption = 'Sec'
      Color = clMedGray
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = -4
    Top = 483
    Width = 553
    Height = 41
    Caption = 'ini dari FrmHal39'
    TabOrder = 3
  end
end
