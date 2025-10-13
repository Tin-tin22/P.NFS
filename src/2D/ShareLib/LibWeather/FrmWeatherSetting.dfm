object frmWeather: TfrmWeather
  Left = -1145
  Top = 0
  Width = 1003
  Height = 658
  Caption = 'Weather Setting'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 78
    Height = 13
    Caption = 'Weather Pattern'
  end
  object ComboBox1: TComboBox
    Left = 104
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'Load dari INI File'
    OnChange = ComboBox1Change
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 40
    Width = 353
    Height = 153
    Caption = 'Cloud '
    TabOrder = 1
    object Label3: TLabel
      Left = 32
      Top = 40
      Width = 26
      Height = 13
      Caption = 'Cirrus'
    end
    object Label4: TLabel
      Left = 160
      Top = 40
      Width = 49
      Height = 13
      Caption = 'Altostratus'
    end
    object Label5: TLabel
      Left = 32
      Top = 64
      Width = 33
      Height = 13
      Caption = 'Stratus'
    end
    object Label6: TLabel
      Left = 160
      Top = 64
      Width = 61
      Height = 13
      Caption = 'Nimbostratus'
    end
    object Label7: TLabel
      Left = 32
      Top = 88
      Width = 40
      Height = 13
      Caption = 'Cumulus'
    end
    object Label8: TLabel
      Left = 160
      Top = 88
      Width = 68
      Height = 13
      Caption = 'Cumulonimbus'
    end
    object Label9: TLabel
      Left = 16
      Top = 128
      Width = 63
      Height = 13
      Caption = 'Coverage (%)'
    end
    object Label11: TLabel
      Left = 144
      Top = 128
      Width = 58
      Height = 13
      Caption = 'Precipitation'
    end
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 58
      Height = 13
      Caption = 'Combination'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 112
      Width = 297
      Height = 9
      Shape = bsTopLine
    end
    object Bevel2: TBevel
      Left = 80
      Top = 23
      Width = 233
      Height = 10
      Shape = bsTopLine
    end
    object Label44: TLabel
      Left = 320
      Top = 129
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Edit1: TEdit
      Left = 88
      Top = 40
      Width = 43
      Height = 21
      TabOrder = 0
      Text = '5'
    end
    object Edit2: TEdit
      Left = 248
      Top = 40
      Width = 43
      Height = 21
      TabOrder = 1
      Text = '5'
    end
    object Edit3: TEdit
      Left = 88
      Top = 64
      Width = 43
      Height = 21
      TabOrder = 2
      Text = '4'
    end
    object Edit4: TEdit
      Left = 248
      Top = 64
      Width = 43
      Height = 21
      TabOrder = 3
      Text = '2'
    end
    object Edit5: TEdit
      Left = 88
      Top = 88
      Width = 43
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object Edit6: TEdit
      Left = 248
      Top = 88
      Width = 43
      Height = 21
      TabOrder = 5
      Text = '2'
    end
    object Edit7: TEdit
      Left = 88
      Top = 124
      Width = 43
      Height = 21
      TabOrder = 6
      Text = '30'
    end
    object ScrollBar1: TScrollBar
      Left = 210
      Top = 126
      Width = 103
      Height = 16
      Max = 10
      PageSize = 0
      TabOrder = 7
      OnChange = ScrollBar1Change
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 200
    Width = 353
    Height = 105
    Caption = 'Wind '
    TabOrder = 2
    object Label16: TLabel
      Left = 264
      Top = 32
      Width = 27
      Height = 13
      Caption = 'Knots'
    end
    object Label15: TLabel
      Left = 152
      Top = 32
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object Label14: TLabel
      Left = 8
      Top = 32
      Width = 57
      Height = 13
      Caption = 'Speed From'
    end
    object Label45: TLabel
      Left = 264
      Top = 56
      Width = 21
      Height = 13
      Caption = 'Feet'
    end
    object Label46: TLabel
      Left = 152
      Top = 56
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object Label47: TLabel
      Left = 8
      Top = 56
      Width = 57
      Height = 13
      Caption = 'Height From'
    end
    object Label48: TLabel
      Left = 8
      Top = 80
      Width = 57
      Height = 13
      Caption = 'Height Slice'
    end
    object Edit9: TEdit
      Left = 176
      Top = 24
      Width = 81
      Height = 21
      TabOrder = 0
      Text = '25'
    end
    object Edit8: TEdit
      Left = 72
      Top = 24
      Width = 43
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit34: TEdit
      Left = 72
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Edit35: TEdit
      Left = 176
      Top = 48
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '60000'
    end
    object Edit36: TEdit
      Left = 72
      Top = 72
      Width = 81
      Height = 21
      TabOrder = 4
      Text = '5000'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 312
    Width = 353
    Height = 73
    Caption = 'Temp&&Pressure '
    TabOrder = 3
    object Label13: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Temperature'
    end
    object Label17: TLabel
      Left = 16
      Top = 48
      Width = 104
      Height = 13
      Caption = 'Pressure at Sea Level'
    end
    object Label18: TLabel
      Left = 184
      Top = 16
      Width = 7
      Height = 13
      Caption = 'C'
    end
    object Edit10: TEdit
      Left = 128
      Top = 16
      Width = 43
      Height = 21
      TabOrder = 0
      Text = '10'
    end
    object Edit11: TEdit
      Left = 128
      Top = 40
      Width = 43
      Height = 21
      TabOrder = 1
      Text = '1'
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 392
    Width = 353
    Height = 49
    Caption = 'Weather Turbulence '
    TabOrder = 4
    object Label12: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 13
      Caption = 'Turbulence'
    end
    object ComboBox2: TComboBox
      Left = 80
      Top = 20
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'None'
      Items.Strings = (
        'None'
        'Very Light'
        'Light'
        'Moderate'
        'Hard')
    end
  end
  object PageControl1: TPageControl
    Left = 368
    Top = 8
    Width = 617
    Height = 617
    ActivePage = TabSheet2
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Wind'
      object Label28: TLabel
        Left = 64
        Top = 520
        Width = 7
        Height = 13
        Caption = 'X'
      end
      object Label29: TLabel
        Left = 64
        Top = 544
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label30: TLabel
        Left = 64
        Top = 568
        Width = 7
        Height = 13
        Caption = 'Z'
      end
      object Label31: TLabel
        Left = 240
        Top = 520
        Width = 38
        Height = 13
        Caption = 'Label31'
      end
      object Label32: TLabel
        Left = 240
        Top = 536
        Width = 38
        Height = 13
        Caption = 'Label32'
      end
      object StringGrid1: TStringGrid
        Left = 3
        Top = 2
        Width = 601
        Height = 503
        ColCount = 6
        DefaultColWidth = 62
        DefaultRowHeight = 22
        TabOrder = 0
      end
      object Edit22: TEdit
        Left = 88
        Top = 512
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '120'
      end
      object Edit23: TEdit
        Left = 88
        Top = 536
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '5'
      end
      object Edit24: TEdit
        Left = 88
        Top = 560
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '10000'
      end
      object Button1: TButton
        Left = 216
        Top = 560
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Turbulence'
      ImageIndex = 1
      object Label33: TLabel
        Left = 64
        Top = 520
        Width = 7
        Height = 13
        Caption = 'X'
      end
      object Label34: TLabel
        Left = 64
        Top = 544
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label35: TLabel
        Left = 64
        Top = 568
        Width = 7
        Height = 13
        Caption = 'Z'
      end
      object Label37: TLabel
        Left = 224
        Top = 520
        Width = 38
        Height = 13
        Caption = 'Label32'
      end
      object Label36: TLabel
        Left = 304
        Top = 544
        Width = 38
        Height = 13
        Caption = 'Label36'
      end
      object Label38: TLabel
        Left = 304
        Top = 560
        Width = 38
        Height = 13
        Caption = 'Label38'
      end
      object StringGrid2: TStringGrid
        Left = 8
        Top = 8
        Width = 585
        Height = 489
        ColCount = 7
        DefaultColWidth = 62
        DefaultRowHeight = 22
        TabOrder = 0
        ColWidths = (
          62
          104
          112
          88
          99
          62
          62)
      end
      object Edit25: TEdit
        Left = 88
        Top = 512
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '120'
      end
      object Edit26: TEdit
        Left = 88
        Top = 536
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '5'
      end
      object Edit27: TEdit
        Left = 88
        Top = 560
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '10000'
      end
      object Button2: TButton
        Left = 216
        Top = 560
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Clouds'
      ImageIndex = 2
      object Label39: TLabel
        Left = 0
        Top = 512
        Width = 33
        Height = 13
        Caption = 'From X'
      end
      object Label40: TLabel
        Left = 8
        Top = 544
        Width = 7
        Height = 13
        Caption = 'Y'
      end
      object Label41: TLabel
        Left = 16
        Top = 568
        Width = 7
        Height = 13
        Caption = 'Z'
      end
      object Label42: TLabel
        Left = 184
        Top = 512
        Width = 13
        Height = 13
        Caption = 'To'
      end
      object Label43: TLabel
        Left = 352
        Top = 536
        Width = 38
        Height = 13
        Caption = 'Label43'
      end
      object StringGrid3: TStringGrid
        Left = 8
        Top = 8
        Width = 577
        Height = 489
        ColCount = 9
        DefaultColWidth = 62
        DefaultRowHeight = 22
        TabOrder = 0
      end
      object Edit28: TEdit
        Left = 40
        Top = 512
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '11'
      end
      object Edit29: TEdit
        Left = 40
        Top = 536
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '11'
      end
      object Edit30: TEdit
        Left = 40
        Top = 560
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '11'
      end
      object Edit31: TEdit
        Left = 208
        Top = 512
        Width = 121
        Height = 21
        TabOrder = 4
        Text = '11'
      end
      object Edit32: TEdit
        Left = 208
        Top = 536
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '11'
      end
      object Edit33: TEdit
        Left = 208
        Top = 560
        Width = 121
        Height = 21
        TabOrder = 6
        Text = '11'
      end
      object Button6: TButton
        Left = 336
        Top = 560
        Width = 75
        Height = 25
        Caption = 'Button6'
        TabOrder = 7
        OnClick = Button6Click
      end
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 448
    Width = 353
    Height = 177
    TabOrder = 6
    object btnCreateWeather: TButton
      Left = 8
      Top = 24
      Width = 89
      Height = 25
      Caption = 'Weather Create'
      TabOrder = 0
      OnClick = btnCreateWeatherClick
    end
    object btnGetWeather: TButton
      Left = 8
      Top = 112
      Width = 89
      Height = 25
      Caption = 'Weather Get'
      TabOrder = 1
      OnClick = btnGetWeatherClick
    end
    object Button3: TButton
      Left = 256
      Top = 120
      Width = 89
      Height = 25
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 256
      Top = 88
      Width = 89
      Height = 25
      Caption = 'Set Cloud VAR'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 120
      Top = 120
      Width = 91
      Height = 25
      Caption = 'Set Turbulence'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Edit21: TEdit
      Left = 8
      Top = 88
      Width = 57
      Height = 21
      TabOrder = 5
      Text = '1'
    end
  end
end
