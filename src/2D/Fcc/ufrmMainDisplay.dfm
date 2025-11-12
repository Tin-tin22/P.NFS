object frmMainFCC: TfrmMainFCC
  Left = 0
  Top = 0
  ActiveControl = FltChkBxShootArea
  BorderStyle = bsNone
  Caption = 'FCC'
  ClientHeight = 1024
  ClientWidth = 1280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object pnlUpper: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 657
    Align = alTop
    TabOrder = 0
    object pnlSituationZone: TPanel
      Left = 1
      Top = 1
      Width = 824
      Height = 655
      Align = alLeft
      Color = clMedGray
      ParentBackground = False
      TabOrder = 0
      object imgBackgrounSituationZone: TImage
        Left = 1
        Top = 1
        Width = 822
        Height = 653
        Align = alClient
        ExplicitLeft = 200
        ExplicitTop = 201
        ExplicitWidth = 1030
        ExplicitHeight = 765
      end
      object lblMap48Km: TLabel
        Left = 92
        Top = 43
        Width = 32
        Height = 16
        Caption = '48Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblMap24Km: TLabel
        Left = 92
        Top = 74
        Width = 32
        Height = 16
        Caption = '24Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblMap12Km: TLabel
        Left = 92
        Top = 105
        Width = 32
        Height = 16
        Caption = '12Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblMap6Km: TLabel
        Left = 99
        Top = 136
        Width = 25
        Height = 16
        Caption = '6Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblMap3Km: TLabel
        Left = 103
        Top = 167
        Width = 25
        Height = 16
        Caption = '3Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblMap1point5Km: TLabel
        Left = 92
        Top = 198
        Width = 36
        Height = 16
        Caption = '1.5Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object imgCompas: TImage
        Left = 146
        Top = 8
        Width = 80
        Height = 80
        OnClick = imgCompasClick
      end
      object imgFcc1Image: TImage
        Left = 719
        Top = 550
        Width = 58
        Height = 87
        Stretch = True
      end
      object FMap: TMap
        Left = 1
        Top = 1
        Width = 822
        Height = 653
        ParentColor = False
        Align = alClient
        TabOrder = 0
        Visible = False
        OnMouseDown = FMapMouseDown
        OnDrawUserLayer = FMapDrawUserLayer
        ExplicitLeft = -2
        ExplicitTop = -13
        ExplicitWidth = 715
        ControlData = {
          8A1A0600F55400007D43000001000000FFFFFF000D47656F44696374696F6E61
          727905456D70747900E8030000000000000000000002000E001E000000000000
          0000000000000000000000000000000000000000000600010000000000500001
          010000640000000001F4010000050000800C000000000000000000000000FFFF
          FF000100000000000000000000000000000000000000000000000352E30B918F
          CE119DE300AA004BB8510100000090014C70070005417269616C000352E30B91
          8FCE119DE300AA004BB851010000009001348C030005417269616C0000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FFFF000000000000000001370000000000FFFFFF000000000000000352E30B91
          8FCE119DE300AA004BB851010000009001DC7C010005417269616C000352E30B
          918FCE119DE300AA004BB851010200009001A42C02000B4D61702053796D626F
          6C730000000000000001000100FFFFFF000200FFFFFF00000000000001000000
          0100011801000018D7160F010000006C906C771C000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000002
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          8076C000000000008056C0000000000080764000000000008056400100000018
          01000018D7160F01000000881300C01C00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000200000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000060CB9700CD8AC1761F
          00000000000000B08AC176A8176833FA35A4AFA0CB9700000000000000000000
          000088B3400000000000408F400001000001}
      end
      object btnMapIncrement: TButton
        Left = 27
        Top = 8
        Width = 46
        Height = 25
        Caption = '+'
        TabOrder = 1
        OnClick = btnMapIncrementClick
      end
      object btnMapDecrement: TButton
        Left = 27
        Top = 225
        Width = 46
        Height = 25
        Caption = '-'
        TabOrder = 2
        OnClick = btnMapDecrementClick
      end
      object pnlMap48km: TPanel
        Tag = 5
        Left = 11
        Top = 39
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 3
        OnClick = pnlMapRangeClick
      end
      object pnlMap24km: TPanel
        Tag = 4
        Left = 11
        Top = 70
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 4
        OnClick = pnlMapRangeClick
      end
      object pnlMap12km: TPanel
        Tag = 3
        Left = 11
        Top = 101
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 5
        OnClick = pnlMapRangeClick
      end
      object pnlMap6km: TPanel
        Tag = 2
        Left = 11
        Top = 132
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 6
        OnClick = pnlMapRangeClick
      end
      object pnlMap3km: TPanel
        Tag = 1
        Left = 11
        Top = 163
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 7
        OnClick = pnlMapRangeClick
      end
      object pnlMap1point5km: TPanel
        Left = 11
        Top = 194
        Width = 75
        Height = 25
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 8
        OnClick = pnlMapRangeClick
      end
      object FltChkBxTargetPara: TFlatCheckBox
        Left = 672
        Top = 12
        Width = 130
        Height = 25
        Caption = 'Target Para'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 9
        TabStop = True
      end
      object FltChkBxDisRing: TFlatCheckBox
        Left = 673
        Top = 43
        Width = 130
        Height = 25
        Caption = 'Dis Ring'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 10
        TabStop = True
      end
      object FltChkBxShootArea: TFlatCheckBox
        Left = 673
        Top = 74
        Width = 130
        Height = 25
        Caption = 'Shoot Area'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 11
        TabStop = True
      end
      object FltChkBxTrackerArea: TFlatCheckBox
        Left = 672
        Top = 105
        Width = 130
        Height = 25
        Caption = 'Tracker Area'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 12
        TabStop = True
      end
    end
    object pnlRightUpper: TPanel
      Left = 825
      Top = 1
      Width = 454
      Height = 655
      Align = alClient
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      object pnlVideoZone: TPanel
        Left = 1
        Top = 1
        Width = 452
        Height = 413
        Align = alTop
        TabOrder = 0
      end
      object pnlINDData: TPanel
        Left = 1
        Top = 414
        Width = 144
        Height = 240
        Align = alLeft
        TabOrder = 1
        object lblIndDataBatchNo: TLabel
          Left = 5
          Top = 47
          Width = 52
          Height = 13
          Caption = 'Batch No.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataType: TLabel
          Left = 4
          Top = 76
          Width = 28
          Height = 13
          Caption = 'Type'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataD: TLabel
          Left = 4
          Top = 101
          Width = 8
          Height = 13
          Caption = 'D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSatuanD: TLabel
          Left = 107
          Top = 101
          Width = 11
          Height = 13
          Caption = 'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataAZ: TLabel
          Left = 4
          Top = 132
          Width = 15
          Height = 13
          Caption = 'AZ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSatuanAZ: TLabel
          Left = 107
          Top = 132
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataEL: TLabel
          Left = 4
          Top = 160
          Width = 12
          Height = 13
          Caption = 'EL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSatuanEL: TLabel
          Left = 107
          Top = 160
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataCourse: TLabel
          Left = 4
          Top = 186
          Width = 39
          Height = 13
          Caption = 'Course'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSatuanCourse: TLabel
          Left = 107
          Top = 194
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSpeed: TLabel
          Left = 4
          Top = 213
          Width = 35
          Height = 13
          Caption = 'Speed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIndDataSatuanSpeed: TLabel
          Left = 107
          Top = 213
          Width = 26
          Height = 13
          Caption = ' m/s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlIndDataHeader: TPanel
          Left = 1
          Top = 1
          Width = 142
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Caption = 'IND Data'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object edtIndDataBatchNo: TEdit
          Left = 63
          Top = 42
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Text = '7.62'
        end
        object edtIndDataType: TEdit
          Left = 63
          Top = 73
          Width = 41
          Height = 21
          TabOrder = 2
          Text = 'Air'
        end
        object edtIndDataD: TEdit
          Left = 63
          Top = 100
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 3
          Text = '7.62'
        end
        object edtIndDataAZ: TEdit
          Left = 63
          Top = 128
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '25.63'
        end
        object edtIndDataEL: TEdit
          Left = 63
          Top = 155
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Text = '7.62'
        end
        object edtIndDataCourse: TEdit
          Left = 63
          Top = 183
          Width = 41
          Height = 21
          TabOrder = 6
          Text = '25.63'
        end
        object edtIndDataSpeed: TEdit
          Left = 63
          Top = 210
          Width = 41
          Height = 21
          TabOrder = 7
          Text = '25.63'
        end
      end
      object pnlNavData: TPanel
        Left = 145
        Top = 414
        Width = 144
        Height = 240
        Align = alLeft
        TabOrder = 2
        object lblNavDataRoll: TLabel
          Left = 11
          Top = 132
          Width = 21
          Height = 13
          Caption = 'Roll'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataHeading: TLabel
          Left = 12
          Top = 47
          Width = 46
          Height = 13
          Caption = 'Heading'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataLon: TLabel
          Left = 11
          Top = 186
          Width = 21
          Height = 13
          Caption = 'LON'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataPitch: TLabel
          Left = 11
          Top = 101
          Width = 28
          Height = 13
          Caption = 'Pitch'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSpeed: TLabel
          Left = 11
          Top = 160
          Width = 35
          Height = 13
          Caption = 'Speed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanRoll: TLabel
          Left = 120
          Top = 132
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanLon: TLabel
          Left = 120
          Top = 186
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanPitch: TLabel
          Left = 120
          Top = 101
          Width = 11
          Height = 13
          Caption = 'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanSpeed: TLabel
          Left = 120
          Top = 160
          Width = 14
          Height = 13
          Caption = 'Kn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataLat: TLabel
          Left = 11
          Top = 213
          Width = 21
          Height = 13
          Caption = 'LAT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataVoyage: TLabel
          Left = 11
          Top = 76
          Width = 42
          Height = 13
          Caption = 'Voyage'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanHeading: TLabel
          Left = 120
          Top = 48
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanVoyage: TLabel
          Left = 120
          Top = 78
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNavDataSatuanLat: TLabel
          Left = 120
          Top = 213
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlNavDataHeader: TPanel
          Left = 1
          Top = 1
          Width = 142
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Caption = 'NAV Data'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object edtNavDataRoll: TEdit
          Left = 61
          Top = 128
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '25.63'
        end
        object edtNavDataHeading: TEdit
          Left = 61
          Top = 42
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 2
          Text = '7.62'
        end
        object edtNavDataLON: TEdit
          Left = 44
          Top = 183
          Width = 73
          Height = 21
          TabOrder = 3
          Text = ' 0.00000000'
        end
        object edtNavDataPitch: TEdit
          Left = 61
          Top = 100
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 4
          Text = '7.62'
        end
        object edtNavDataSpeed: TEdit
          Left = 61
          Top = 155
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Text = '7.62'
        end
        object edtNavDataLAT: TEdit
          Left = 44
          Top = 210
          Width = 73
          Height = 21
          TabOrder = 6
          Text = ' 0.00000000'
        end
        object edtNavDataVoyage: TEdit
          Left = 61
          Top = 73
          Width = 41
          Height = 21
          TabOrder = 7
          Text = 'Air'
        end
      end
      object pnlWeatherData: TPanel
        Left = 289
        Top = 414
        Width = 164
        Height = 240
        Align = alClient
        TabOrder = 3
        object lblWeatherDataWs: TLabel
          Left = 6
          Top = 55
          Width = 21
          Height = 13
          Caption = 'W S'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataSatuanWs: TLabel
          Left = 95
          Top = 56
          Width = 23
          Height = 13
          Caption = 'm/s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataWd: TLabel
          Left = 5
          Top = 84
          Width = 22
          Height = 13
          Caption = 'W D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataSatuanWd: TLabel
          Left = 95
          Top = 86
          Width = 9
          Height = 13
          Caption = ' '#176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataTemp: TLabel
          Left = 5
          Top = 109
          Width = 35
          Height = 13
          Caption = 'Temp.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataSatuanTemp: TLabel
          Left = 95
          Top = 109
          Width = 16
          Height = 13
          Caption = ' '#8451
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataHumi: TLabel
          Left = 5
          Top = 140
          Width = 32
          Height = 13
          Caption = 'Humi.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataSatuanHumi: TLabel
          Left = 95
          Top = 140
          Width = 13
          Height = 13
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataAirP: TLabel
          Left = 5
          Top = 168
          Width = 26
          Height = 13
          Caption = 'Air P'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblWeatherDataSatuanAirP: TLabel
          Left = 95
          Top = 168
          Width = 21
          Height = 13
          Caption = 'hPa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlWeatherDataHeader: TPanel
          Left = 1
          Top = 1
          Width = 162
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Weather Data'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object edtWeatherDataWs: TEdit
          Left = 48
          Top = 50
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Text = '7.62'
        end
        object edtWeatherDataWd: TEdit
          Left = 48
          Top = 81
          Width = 41
          Height = 21
          TabOrder = 2
          Text = 'Air'
        end
        object edtWeatherDataTemp: TEdit
          Left = 48
          Top = 108
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 3
          Text = '7.62'
        end
        object edtWeatherDataHumi: TEdit
          Left = 48
          Top = 136
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '25.63'
        end
        object edtWeatherDataAirP: TEdit
          Left = 48
          Top = 163
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Text = '7.62'
        end
      end
    end
  end
  object PnlLower: TPanel
    Left = 0
    Top = 657
    Width = 1280
    Height = 367
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    object pnlFCC: TPanel
      Left = 1
      Top = 1
      Width = 824
      Height = 365
      Align = alLeft
      TabOrder = 0
      object pnlFCCHeader: TPanel
        Left = 1
        Top = 1
        Width = 822
        Height = 32
        Align = alTop
        Caption = 'FCC'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object pnlFCCBottom: TPanel
        Left = 1
        Top = 33
        Width = 822
        Height = 331
        Align = alClient
        TabOrder = 1
        object pnlButtonCtrl: TPanel
          Left = 1
          Top = 1
          Width = 96
          Height = 329
          Align = alLeft
          TabOrder = 0
          object pnlLocalState: TPanel
            Left = 1
            Top = 1
            Width = 94
            Height = 136
            Align = alTop
            TabOrder = 0
            object pnlLocalStateHeader: TPanel
              Left = 1
              Top = 1
              Width = 92
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Local State'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object pnlSysCtrl: TPanel
              Left = 9
              Top = 30
              Width = 74
              Height = 25
              Caption = 'Sys Ctrl'
              TabOrder = 1
            end
            object pnlCombatLs: TPanel
              Left = 9
              Top = 56
              Width = 74
              Height = 25
              Caption = 'Combat'
              TabOrder = 2
            end
            object pnlWaitLs: TPanel
              Left = 8
              Top = 81
              Width = 74
              Height = 25
              Caption = 'Wait'
              TabOrder = 3
            end
            object pnlTrLs: TPanel
              Left = 8
              Top = 107
              Width = 74
              Height = 25
              Caption = 'TR'
              TabOrder = 4
            end
          end
          object pnlCtrlCmd: TPanel
            Left = 1
            Top = 137
            Width = 94
            Height = 191
            Align = alClient
            TabOrder = 1
            object pnlCtrlCmdHeader: TPanel
              Left = 1
              Top = 1
              Width = 92
              Height = 25
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Ctrl Cmd'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object pnlCombatCtrl: TPanel
              Left = 9
              Top = 31
              Width = 74
              Height = 25
              Caption = 'Combat'
              TabOrder = 1
            end
            object pnlWaitCtrl: TPanel
              Left = 8
              Top = 57
              Width = 74
              Height = 25
              Caption = 'Wait'
              TabOrder = 2
            end
            object pnlCtrl: TPanel
              Left = 8
              Top = 83
              Width = 74
              Height = 25
              Caption = 'TR'
              TabOrder = 3
            end
            object pnlFireForbid: TPanel
              Left = 8
              Top = 108
              Width = 74
              Height = 25
              Caption = 'Fire Forbid'
              TabOrder = 4
            end
          end
        end
        object pnlCalData: TPanel
          Left = 361
          Top = 1
          Width = 176
          Height = 329
          Align = alLeft
          TabOrder = 1
          object pnlCalDataHeader: TPanel
            Left = 1
            Top = 1
            Width = 174
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'CAL Data'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
          object pnlLast: TPanel
            Left = 1
            Top = 24
            Width = 174
            Height = 121
            Align = alTop
            TabOrder = 1
            object lblLastDeltaBE: TLabel
              Left = 10
              Top = 41
              Width = 24
              Height = 13
              Caption = ' '#916'BE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblLastDeltaEL: TLabel
              Left = 9
              Top = 68
              Width = 23
              Height = 13
              Caption = ' '#916'EL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblLastDeltaD: TLabel
              Left = 13
              Top = 95
              Width = 16
              Height = 13
              Caption = #916'D'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblLastSatuanDeltaBE: TLabel
              Left = 126
              Top = 40
              Width = 30
              Height = 13
              Caption = 'mrad'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblLastSatuanDeltaEL: TLabel
              Left = 126
              Top = 68
              Width = 30
              Height = 13
              Caption = 'mrad'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblLastSatuanDeltaD: TLabel
              Left = 126
              Top = 96
              Width = 11
              Height = 13
              Caption = 'm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object pnlLastHeader: TPanel
              Left = 1
              Top = 1
              Width = 172
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Last'
              Color = clBlue
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clHighlightText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object edtLastDeltaBE: TEdit
              Left = 64
              Top = 38
              Width = 41
              Height = 21
              ReadOnly = True
              TabOrder = 1
              Text = '7.62'
            end
            object edtLastDeltaEL: TEdit
              Left = 64
              Top = 65
              Width = 41
              Height = 21
              TabOrder = 2
              Text = '25.63'
            end
            object edtLastDeltaD: TEdit
              Left = 64
              Top = 92
              Width = 41
              Height = 21
              TabOrder = 3
              Text = '25.63'
            end
          end
          object pnlSum: TPanel
            Left = 1
            Top = 145
            Width = 174
            Height = 183
            Align = alClient
            TabOrder = 2
            object lblSumDeltaBE: TLabel
              Left = 18
              Top = 49
              Width = 24
              Height = 13
              Caption = ' '#916'BE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblSumSatuanDeltaBe: TLabel
              Left = 134
              Top = 48
              Width = 30
              Height = 13
              Caption = 'mrad'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblSumDeltaEL: TLabel
              Left = 17
              Top = 76
              Width = 23
              Height = 13
              Caption = ' '#916'EL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblSumSatualDeltaEL: TLabel
              Left = 134
              Top = 76
              Width = 30
              Height = 13
              Caption = 'mrad'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblSumDeltaD: TLabel
              Left = 21
              Top = 103
              Width = 16
              Height = 13
              Caption = #916'D'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblSumSatuanDeltaD: TLabel
              Left = 134
              Top = 104
              Width = 11
              Height = 13
              Caption = 'm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object pnlSumHeader: TPanel
              Left = 1
              Top = 1
              Width = 172
              Height = 24
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Sum'
              Color = clBlue
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clHighlightText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object edtSumDeltaBe: TEdit
              Left = 72
              Top = 46
              Width = 41
              Height = 21
              ReadOnly = True
              TabOrder = 1
              Text = '7.62'
            end
            object edtSumDeltaEL: TEdit
              Left = 72
              Top = 73
              Width = 41
              Height = 21
              TabOrder = 2
              Text = '25.63'
            end
            object edtSumDeltaD: TEdit
              Left = 72
              Top = 100
              Width = 41
              Height = 21
              TabOrder = 3
              Text = '25.63'
            end
          end
        end
        object pnlCtrlData: TPanel
          Left = 670
          Top = 1
          Width = 151
          Height = 329
          Align = alClient
          TabOrder = 2
          object lblCtrlDataBE: TLabel
            Left = 14
            Top = 38
            Width = 13
            Height = 13
            Caption = 'BE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataEL: TLabel
            Left = 13
            Top = 68
            Width = 12
            Height = 13
            Caption = 'EL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanBE: TLabel
            Left = 103
            Top = 38
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanEL: TLabel
            Left = 103
            Top = 73
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataBeInc: TLabel
            Left = 13
            Top = 93
            Width = 34
            Height = 13
            Caption = 'BE Inc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanBeInc: TLabel
            Left = 103
            Top = 93
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LblCtrlDataELInc: TLabel
            Left = 13
            Top = 123
            Width = 33
            Height = 13
            Caption = 'EL Inc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanELInc: TLabel
            Left = 103
            Top = 124
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataBeS: TLabel
            Left = 13
            Top = 148
            Width = 23
            Height = 13
            Caption = 'BE S'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanBeS: TLabel
            Left = 103
            Top = 148
            Width = 21
            Height = 13
            Caption = ' '#176'/s'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataElS: TLabel
            Left = 13
            Top = 178
            Width = 22
            Height = 13
            Caption = 'EL S'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlDataSatuanElS: TLabel
            Left = 103
            Top = 178
            Width = 21
            Height = 13
            Caption = ' '#176'/s'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlCtrlDataHeader: TPanel
            Left = 1
            Top = 1
            Width = 149
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Ctrl Data'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
          object edtCtrlDataBE: TEdit
            Left = 56
            Top = 37
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 1
            Text = '7.62'
          end
          object edtCtrlDataEL: TEdit
            Left = 56
            Top = 65
            Width = 41
            Height = 21
            TabOrder = 2
            Text = '25.63'
          end
          object edtCtrlDataBeInc: TEdit
            Left = 56
            Top = 92
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 3
            Text = '7.62'
          end
          object edtCtrlDataElInc: TEdit
            Left = 56
            Top = 120
            Width = 41
            Height = 21
            TabOrder = 4
            Text = '25.63'
          end
          object edtCtrlDataBeS: TEdit
            Left = 56
            Top = 147
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 5
            Text = '7.62'
          end
          object edtCtrlDataElS: TEdit
            Left = 56
            Top = 175
            Width = 41
            Height = 21
            TabOrder = 6
            Text = '25.63'
          end
        end
        object pnlCtrlState: TPanel
          Left = 97
          Top = 1
          Width = 111
          Height = 329
          Align = alLeft
          TabOrder = 3
          object imgCtrlStateTracked: TImage
            Left = 82
            Top = 86
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateDataReady: TImage
            Left = 82
            Top = 122
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateFCC: TImage
            Left = 82
            Top = 53
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateFireAllow: TImage
            Left = 82
            Top = 238
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateFiring: TImage
            Left = 82
            Top = 274
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateLimitZone: TImage
            Left = 82
            Top = 195
            Width = 15
            Height = 15
            Stretch = True
          end
          object imgCtrlStateAimed: TImage
            Left = 82
            Top = 155
            Width = 15
            Height = 15
            Stretch = True
          end
          object lblCtrlStateTracked: TLabel
            Left = 10
            Top = 89
            Width = 46
            Height = 13
            Caption = 'Tracked'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateDataReady: TLabel
            Left = 10
            Top = 124
            Width = 66
            Height = 13
            Caption = 'Data Ready'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateFCC: TLabel
            Left = 10
            Top = 53
            Width = 50
            Height = 13
            Caption = 'FCC1 Ctrl'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateFireAllow: TLabel
            Left = 10
            Top = 238
            Width = 54
            Height = 13
            Caption = 'Fire Allow'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateFiring: TLabel
            Left = 10
            Top = 273
            Width = 31
            Height = 13
            Caption = 'Firing'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateLimitZone: TLabel
            Left = 10
            Top = 196
            Width = 59
            Height = 13
            Caption = 'Limit Zone'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCtrlStateAimed: TLabel
            Left = 10
            Top = 157
            Width = 36
            Height = 13
            Caption = 'Aimed'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlCtrlStateHeader: TPanel
            Left = 1
            Top = 1
            Width = 109
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Ctrl State'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
        end
        object pnlGunData: TPanel
          Left = 537
          Top = 1
          Width = 133
          Height = 329
          Align = alLeft
          TabOrder = 4
          object pnlGunPointAngel: TPanel
            Left = 1
            Top = 1
            Width = 131
            Height = 104
            Align = alTop
            TabOrder = 0
            object lblGpaBE: TLabel
              Left = 5
              Top = 30
              Width = 13
              Height = 13
              Caption = 'BE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblGpaEL: TLabel
              Left = 5
              Top = 60
              Width = 12
              Height = 13
              Caption = 'EL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblGpaSatuanBE: TLabel
              Left = 110
              Top = 30
              Width = 9
              Height = 13
              Caption = ' '#176
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblGpaSatuanEL: TLabel
              Left = 110
              Top = 62
              Width = 9
              Height = 13
              Caption = ' '#176
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object pnlGunPointAngelHeader: TPanel
              Left = 1
              Top = 1
              Width = 129
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Gun Point Angel'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object edtGpABE: TEdit
              Left = 56
              Top = 30
              Width = 41
              Height = 21
              ReadOnly = True
              TabOrder = 1
              Text = '7.62'
            end
            object edtGpaEL: TEdit
              Left = 56
              Top = 57
              Width = 41
              Height = 21
              TabOrder = 2
              Text = '25.63'
            end
          end
          object pnlGunState: TPanel
            Left = 1
            Top = 105
            Width = 131
            Height = 223
            Align = alClient
            TabOrder = 1
            object lblGunStateCtrlBy: TLabel
              Left = 5
              Top = 53
              Width = 37
              Height = 13
              Caption = 'Ctrl By'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgGunStateCtrlBy: TImage
              Left = 88
              Top = 53
              Width = 15
              Height = 15
              Stretch = True
            end
            object lblGunStateServo: TLabel
              Left = 5
              Top = 89
              Width = 33
              Height = 13
              Caption = 'Servo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgGunStateServo: TImage
              Left = 88
              Top = 86
              Width = 15
              Height = 15
              Stretch = True
            end
            object lblGunStateFC: TLabel
              Left = 5
              Top = 124
              Width = 13
              Height = 13
              Caption = 'FC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgGunStateFC: TImage
              Left = 88
              Top = 122
              Width = 15
              Height = 15
              Stretch = True
            end
            object lblGunStateReturnZero: TLabel
              Left = 5
              Top = 157
              Width = 68
              Height = 13
              Caption = 'Return Zero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgGunStateReturnZero: TImage
              Left = 88
              Top = 155
              Width = 15
              Height = 15
              Stretch = True
            end
            object pnlGunStateHeader: TPanel
              Left = 1
              Top = 1
              Width = 129
              Height = 24
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Gun State'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object pnlGunParameter: TPanel
          Left = 208
          Top = 1
          Width = 153
          Height = 329
          Align = alLeft
          TabOrder = 5
          object lblGpDrum: TLabel
            Left = 6
            Top = 40
            Width = 31
            Height = 13
            Caption = 'Drum'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpType: TLabel
            Left = 6
            Top = 59
            Width = 28
            Height = 13
            Caption = 'Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpRate: TLabel
            Left = 6
            Top = 85
            Width = 27
            Height = 13
            Caption = 'Rate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpPr: TLabel
            Left = 6
            Top = 111
            Width = 15
            Height = 13
            Caption = 'PR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpRr: TLabel
            Left = 6
            Top = 137
            Width = 16
            Height = 13
            Caption = 'RR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpMv: TLabel
            Left = 6
            Top = 163
            Width = 17
            Height = 13
            Caption = 'MV'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGpTime: TLabel
            Left = 6
            Top = 190
            Width = 28
            Height = 13
            Caption = 'Time'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSatuanMv: TLabel
            Left = 125
            Top = 138
            Width = 23
            Height = 13
            Caption = 'm/s'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblSatuanTime: TLabel
            Left = 126
            Top = 190
            Width = 6
            Height = 13
            Caption = 's'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlGunParameterHeader: TPanel
            Left = 1
            Top = 1
            Width = 151
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Gun Parameter'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
          object pnlGpDrum: TPanel
            Left = 43
            Top = 30
            Width = 74
            Height = 25
            Caption = 'Right'
            TabOrder = 1
          end
          object pnlGpType: TPanel
            Left = 43
            Top = 55
            Width = 74
            Height = 25
            Caption = 'HE'
            TabOrder = 2
          end
          object pnlGpRate: TPanel
            Left = 43
            Top = 80
            Width = 74
            Height = 25
            Caption = 'Hight'
            TabOrder = 3
          end
          object pnlGpPr: TPanel
            Left = 42
            Top = 106
            Width = 74
            Height = 25
            Caption = '35'
            TabOrder = 4
          end
          object pnlGpRr: TPanel
            Left = 43
            Top = 131
            Width = 74
            Height = 25
            Caption = '265'
            TabOrder = 5
          end
          object pnlGpMv: TPanel
            Left = 43
            Top = 157
            Width = 74
            Height = 25
            Caption = '910.00'
            TabOrder = 6
          end
          object pnlGpTime: TPanel
            Left = 43
            Top = 182
            Width = 74
            Height = 25
            Caption = '1.00'
            TabOrder = 7
          end
        end
      end
    end
    object pnlTracker: TPanel
      Left = 825
      Top = 1
      Width = 224
      Height = 365
      Align = alLeft
      TabOrder = 1
      object pnlTrackerHeader: TPanel
        Left = 1
        Top = 1
        Width = 222
        Height = 32
        Align = alTop
        Caption = 'TRACKER'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object pnlTrackerBottom: TPanel
        Left = 1
        Top = 33
        Width = 222
        Height = 331
        Align = alClient
        TabOrder = 1
        object pnlTrackerData: TPanel
          Left = 1
          Top = 1
          Width = 128
          Height = 329
          Align = alLeft
          TabOrder = 0
          object lblTrdBE: TLabel
            Left = 14
            Top = 38
            Width = 13
            Height = 13
            Caption = 'BE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdEL: TLabel
            Left = 13
            Top = 68
            Width = 12
            Height = 13
            Caption = 'EL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdSatuanBE: TLabel
            Left = 87
            Top = 38
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdSatuanEL: TLabel
            Left = 87
            Top = 73
            Width = 9
            Height = 13
            Caption = ' '#176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdD: TLabel
            Left = 13
            Top = 93
            Width = 8
            Height = 13
            Caption = 'D'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdSatuanD: TLabel
            Left = 87
            Top = 93
            Width = 11
            Height = 13
            Caption = 'm'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdDeltaBE: TLabel
            Left = 13
            Top = 123
            Width = 21
            Height = 13
            Caption = #916'BE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdSatuanDeltaBE: TLabel
            Left = 87
            Top = 124
            Width = 30
            Height = 13
            Caption = 'mrad'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdDeltaEL: TLabel
            Left = 13
            Top = 148
            Width = 20
            Height = 13
            Caption = #916'EL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTrdSatuanDeltaEL: TLabel
            Left = 87
            Top = 148
            Width = 30
            Height = 13
            Caption = 'mrad'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlTrackerDataHeader: TPanel
            Left = 1
            Top = 1
            Width = 126
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Tracker Data'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
          object edtTrdBE: TEdit
            Left = 40
            Top = 37
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 1
            Text = '7.62'
          end
          object edtTrdEL: TEdit
            Left = 40
            Top = 65
            Width = 41
            Height = 21
            TabOrder = 2
            Text = '25.63'
          end
          object edtTrdD: TEdit
            Left = 40
            Top = 92
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 3
            Text = '7.62'
          end
          object edtTrdDeltaBE: TEdit
            Left = 40
            Top = 120
            Width = 41
            Height = 21
            TabOrder = 4
            Text = '25.63'
          end
          object edtTrdDeltaEL: TEdit
            Left = 40
            Top = 147
            Width = 41
            Height = 21
            ReadOnly = True
            TabOrder = 5
            Text = '7.62'
          end
        end
        object pnlTrackerState: TPanel
          Left = 129
          Top = 1
          Width = 92
          Height = 329
          Align = alClient
          TabOrder = 1
          object pnlTrackerStateHeader: TPanel
            Left = 1
            Top = 1
            Width = 90
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Tracker State'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
          object edtTrsLocalCtrl: TEdit
            Left = 23
            Top = 38
            Width = 57
            Height = 21
            ReadOnly = True
            TabOrder = 1
            Text = 'Local Ctrl'
          end
          object edtTrsCombat: TEdit
            Left = 23
            Top = 65
            Width = 57
            Height = 21
            TabOrder = 2
            Text = 'Combat'
          end
          object edtTrsWait: TEdit
            Left = 23
            Top = 92
            Width = 57
            Height = 21
            ReadOnly = True
            TabOrder = 3
            Text = 'Wait'
          end
          object edtTrsLost: TEdit
            Left = 23
            Top = 120
            Width = 57
            Height = 21
            TabOrder = 4
            Text = 'Lost'
          end
          object edtTrsAuto: TEdit
            Left = 23
            Top = 147
            Width = 57
            Height = 21
            ReadOnly = True
            TabOrder = 5
            Text = 'Auto'
          end
          object edtTrsTvChannel: TEdit
            Left = 23
            Top = 175
            Width = 57
            Height = 21
            TabOrder = 6
            Text = 'TV Channel'
          end
          object edtTrsTurnOn: TEdit
            Left = 23
            Top = 202
            Width = 57
            Height = 21
            TabOrder = 7
            Text = 'Turn On'
          end
        end
      end
    end
    object pnlBite: TPanel
      Left = 1049
      Top = 1
      Width = 230
      Height = 365
      Align = alClient
      TabOrder = 2
      object pnlBiteHeader: TPanel
        Left = 1
        Top = 1
        Width = 228
        Height = 32
        Align = alTop
        Caption = 'BITE'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object pnlBiteBottom: TPanel
        Left = 1
        Top = 33
        Width = 228
        Height = 331
        Align = alClient
        TabOrder = 1
        object pnlBiteControl: TPanel
          Left = 1
          Top = 1
          Width = 226
          Height = 267
          Align = alTop
          TabOrder = 0
          object pnlBiteDvcState: TPanel
            Left = 1
            Top = 1
            Width = 120
            Height = 265
            Align = alLeft
            TabOrder = 0
            object imgBiteDvcStateFCC: TImage
              Left = 77
              Top = 40
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcState730B: TImage
              Left = 77
              Top = 61
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcStateEO: TImage
              Left = 77
              Top = 82
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcStateTR: TImage
              Left = 77
              Top = 103
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcStateTCC: TImage
              Left = 77
              Top = 124
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcStateSIE: TImage
              Left = 77
              Top = 145
              Width = 15
              Height = 15
              Stretch = True
            end
            object imgBiteDvcStateSR: TImage
              Left = 77
              Top = 166
              Width = 15
              Height = 15
              Stretch = True
            end
            object lblBiteDvcStateFcc: TLabel
              Left = 11
              Top = 44
              Width = 27
              Height = 13
              Caption = 'FCC1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcState730B: TLabel
              Left = 11
              Top = 63
              Width = 28
              Height = 13
              Caption = '730B'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateEO: TLabel
              Left = 11
              Top = 84
              Width = 14
              Height = 13
              Caption = 'EO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateTr: TLabel
              Left = 11
              Top = 105
              Width = 15
              Height = 13
              Caption = 'TR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateTCC: TLabel
              Left = 11
              Top = 126
              Width = 21
              Height = 13
              Caption = 'TCC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateSIE: TLabel
              Left = 11
              Top = 145
              Width = 18
              Height = 13
              Caption = 'SIE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateSR: TLabel
              Left = 11
              Top = 168
              Width = 15
              Height = 13
              Caption = 'SR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBiteDvcStateHeader: TPanel
              Left = 1
              Top = 1
              Width = 118
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Devices State'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
          object pnlBiteChooseDvc: TPanel
            Left = 121
            Top = 1
            Width = 104
            Height = 265
            Align = alClient
            TabOrder = 1
            object lblBiteChooseDvc: TPanel
              Left = 1
              Top = 1
              Width = 102
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Choose Device'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
            object btnBiteChooseDvcFCC: TButton
              Left = 6
              Top = 40
              Width = 75
              Height = 25
              Caption = 'FCC1'
              TabOrder = 1
            end
            object btnBiteChooseDvc730B: TButton
              Left = 6
              Top = 71
              Width = 75
              Height = 25
              Caption = '730B'
              TabOrder = 2
            end
          end
        end
        object pnlBiteBottomTime: TPanel
          Left = 1
          Top = 268
          Width = 226
          Height = 62
          Align = alClient
          TabOrder = 1
          object lblBiteOperating: TLabel
            Left = 40
            Top = 6
            Width = 48
            Height = 13
            Caption = 'Operating'
          end
          object lblBiteSystem: TLabel
            Left = 40
            Top = 25
            Width = 35
            Height = 13
            Caption = 'System'
          end
          object lblBiteTimeOperating: TLabel
            Left = 94
            Top = 6
            Width = 29
            Height = 13
            Caption = 'Time :'
          end
          object lblBiteTimeSystem: TLabel
            Left = 94
            Top = 25
            Width = 29
            Height = 13
            Caption = 'Time :'
          end
          object lblBiteTimeOperatingValue: TLabel
            Left = 144
            Top = 6
            Width = 44
            Height = 13
            Caption = '02:38:55'
          end
          object lblBiteTimeSystemValue: TLabel
            Left = 144
            Top = 25
            Width = 44
            Height = 13
            Caption = '02:38:55'
          end
        end
      end
    end
  end
  object imgListLight: TImageList
    Left = 209
    Top = 17
    Bitmap = {
      494C010107001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000032C0370031AF34003AC13F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000516B9800485F95005A72990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005D99850056928300659A890000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000029BC2A0021711C00266520000775000026642000286C24003BB43D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000415AA2000A10980000009500000095000000910011168F0054689B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004F9D8D00278688002085890000987700208084002F7D800062968B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000027C7
      2B00246F20000C8A02000E9200000E9200000E8E00000A820000265F20003BB3
      3D00000000000000000000000000000000000000000000000000000000003F59
      AD000000A0000000AC000000B4000000B3000000AE000000A00000008D005368
      9B00000000000000000000000000000000000000000000000000000000004AAA
      980020919B0000B49A0000B99C0000B7970000B18F0000A48200207C7F006296
      8B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000218B
      25000EA20F000FA90B0010A8040010A701000FA000000E9500000A820000296D
      2100000000000000000000000000000000000000000000000000000000000308
      AD000000B6000000C4000000CA000000CB000000C4000000B6000000A2000D11
      920000000000000000000000000000000000000000000000000000000000219D
      A80000C3B10000CCB70000D0B50000CFB10000C7A60000B9980000A685002A80
      8300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000043DD4F002496
      37000FBF220011BE150011BE0B0012BD040011B3010010A200000E9100002566
      200040C7440000000000000000000000000000000000000000005C77C9000000
      B3000000C7000000D3000000DC000000E0000000D7000000C6000000B2000000
      96005D76A100000000000000000000000000000000000000000062CCBC0020A7
      BA0000D4C80000DACA0000E0CA0000E2C70000DABC0000CAAB0000B797002086
      8B0068A292000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003BD64F0007C0
      30000FD1390011CD260011CB150012CA0B0012C0050011AE02000F990000067A
      00003CBA3D0000000000000000000000000000000000000000004F67CD000000
      BA000000CF000000DA000000E6000000EC000000E2000000CF000000BB000000
      9D004F64A300000000000000000000000000000000000000000055CFC30000CA
      BF0000DDD50000E2D60000E8D70000ECD50000E4CB0000D4BB0000C1A70000A3
      85005CA193000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003BE0510027AE
      54000FDB4E000FD83D0011D2270012CE150012C50B0011B705000FA20200256F
      200046D1490000000000000000000000000000000000000000005570CB000000
      BE000000D1000000DB000000E4000000E7000000E0000000D1000000BE000000
      A1006179AE00000000000000000000000000000000000000000058D0C10020B5
      CD0000E1DC0000E5DE0000E9DE0000EADB0000E4D20000D8C50000C7B3002093
      9C006AB0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000024B2
      4F000DDC58000EE0540010DA3E0011D4280012CB160012BF0B000EA602002883
      1F0000000000000000000000000000000000000000000000000000000000060B
      C3000000CC000000D8000000DC000000DD000000D8000000CE000000B900090D
      A9000000000000000000000000000000000000000000000000000000000022B6
      CA0000DFDC0000E5E30000E7E20000E6DE0000E1D70000D8CC0000C6B500269A
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000025D9
      410028B35D000DDE59000EDF510010DB3C0011D2260011BF1100238A200055D0
      5400000000000000000000000000000000000000000000000000000000003952
      C4000000C5000000CD000000D4000000D4000000D0000000C3000000AE006A7F
      D100000000000000000000000000000000000000000000000000000000003FC6
      BC0020BAD40000E2DF0000E4E20000E3DF0000DFD90000D3CA0020A1B20071CD
      C500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000021D73D0024B74F002AB659000DCE37002AAB3D0027A2290043D444000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000344DC100080EC7000000C6000000C6000000C000090EBB00586ECC000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003AC3BA0021BCCF0020BDD80000D8D20020B7CF0025AEBF005FCAC1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000025DE3B0027D4390030E03E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F5BBC00374EBE004A65BF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000041C5B5003DC1B9004CC6B80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000142EC500142FC800142FC8002438B300B9BEDF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A8A8A8009D9D9D00A7A7A700BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000068716800696C69007076710000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004AE96F004BF5730049EB6F0047EB6E004FE9740085E39A00BBE9C5000000
      000000000000000000000000000000000000000000000000000000000000142F
      C8001631C500142FC700142FC800142FC8001A33C0005B6BCE007480CC00E9EA
      F300000000000000000000000000000000000000000000000000000000000000
      000093949400929292009D9D9D00989898009C9C9C009D9D9D00B4B4B400B7B7
      B700000000000000000000000000000000000000000000000000000000000000
      000062666200654B65006F4F6F005C5C5C006E4E6E00694D6900727072000000
      0000000000000000000000000000000000000000000000000000000000004BF8
      74004BF673004BF774004BF874004BF874004BF874004CF6740060EC81008DE0
      9F00000000000000000000000000000000000000000000000000142FC800142F
      C800142FC800142FC800142FC800142FC800142FC800142FC8002840C700A4AB
      DD00000000000000000000000000000000000000000000000000000000009393
      930094949400959595009595950095959500959595009595950096969600A0A0
      A000A4A4A4000000000000000000000000000000000000000000000000006368
      63006C4B6B00686867006E6E6E00707070006E6E6D00666666006B4B6B007270
      72000000000000000000000000000000000000000000000000004AF573004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF8740060EC
      8100BBE9C50000000000000000000000000000000000142DC100142FC600142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC8002A41
      C500616FC5000000000000000000000000000000000000000000929292009595
      9500959595009595950095959500959595009595950095959500959595009696
      9600AAAAAA00D5D5D5000000000000000000000000000000000000000000664A
      660068686800727272007B7B7B007E7E7E007B7B7B0072727200666666006A4E
      6A000000000000000000000000000000000000000000000000004AEF71004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF874004CF6
      740086E39C0000000000000000000000000000000000142FC700142FC700142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC8001530
      C7005161C3000000000000000000000000000000000092929200949494009595
      9500959595009595950095959500959595009595950095959500959595009595
      95009B9B9B00B7B7B70000000000000000000000000000000000838C83006E4E
      6E006E6E6E007B7B7C00888888008D8D8D00888888007B7B7B006E6E6E006F4F
      6F00777F780000000000000000000000000000000000000000004BF874004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF874004BF8
      74008AEAA100DFEDE100000000000000000000000000142EC400142FC800142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC800142F
      C8006776CE00D3D4E20000000000000000000000000094949400959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      950095959500A4A4A40000000000000000000000000000000000808680005C5C
      5D00707070007F7F7F008E8E8E00969696008E8E8E007F7F7F00707070005C5C
      5C007777770000000000000000000000000000000000000000004BF874004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF874004BF8
      74007FEA9800D0E9D500000000000000000000000000142FC800142FC800142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC800142F
      C8005566CA00B5B9D70000000000000000000000000094949400959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      950095959500B4B4B400000000000000000000000000000000007E887E007050
      70006E6E6E007C7C7C00898989008F8F8F00898989007C7C7C006E6E6E006F4F
      6F008088810000000000000000000000000000000000000000004BF874004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF874004BF8
      740072E68D00D8E9DB00000000000000000000000000142EC400142FC800142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC800142F
      C8006776CF00D3D4E20000000000000000000000000093939300959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      950095959500B3B3B30000000000000000000000000000000000000000006A4E
      6A0069696900737373007D7C7C00808080007C7C7C0073737300676767006D51
      6D000000000000000000000000000000000000000000E5F1E70071EB8E004BF8
      74004BF874004BF874004BF874004BF874004BF874004BF874004BF874004DF4
      75008EE3A200000000000000000000000000000000005D6ED100142FC700142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC8001530
      C7005262C3000000000000000000000000000000000094949400949494009595
      9500959595009595950095959500959595009595950095959500959595009595
      950095959500B2B2B2000000000000000000000000000000000000000000686C
      670073527200696969006E6E6E00717171006F6F6F00686868006A4A6A009898
      990000000000000000000000000000000000000000000000000049EE70004AF5
      73004BF874004BF874004BF874004BF874004BF874004BF874004CF7740073EA
      8E00B3E5BE0000000000000000000000000000000000162FBF00142FC600142F
      C800142FC800142FC800142FC800142FC800142FC800142FC800142FC8002C42
      C6006371C4000000000000000000000000000000000097979700959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      950098989800B0B0B00000000000000000000000000000000000000000000000
      0000636763006C526C007555750062626200725272006D516C00898A89000000
      0000000000000000000000000000000000000000000000000000000000004AF4
      72004BF372004BF673004BF874004BF874004BF874004FF276007AE99400C1EA
      CA00000000000000000000000000000000000000000000000000142FC800142F
      C800142FC800142FC800142FC800142FC800142FC800142FC8002139C600A3AB
      DD00000000000000000000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500A6A6A600BEBEBE0000000000000000000000000000000000000000000000
      00000000000000000000677368006B6E6B00747E750000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000048EB6F004BF874004BF874004AF6730061E07F00CAEAD1000000
      000000000000000000000000000000000000000000000000000000000000142F
      C7001630C300152FC600142EC500142EC5001F37C1004256C6007581CE000000
      00000000000000000000000000000000000000000000000000009A9A9A00B0B0
      B00096969600959595009595950095959500959595009595950095959500B1B1
      B100D5D5D5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000172FBE00132DC200132DC0003043B70099A0CD00000000000000
      000000000000000000000000000000000000000000000000000000000000DDDD
      DD0095959500A1A1A1009696960095959500969696009F9F9F00A2A2A200D7D7
      D700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBEB00D9D9D900E8E8E80000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FC7FFC7FFC7F0000F01FF01FF01F0000E00FE00FE00F0000
      E00FE00FE00F0000C007C007C0070000C007C007C0070000C007C007C0070000
      E00FE00FE00F0000E00FE00FE00F0000F01FF01FF01F0000FC7FFC7FFC7F0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFF83FFC3FFC7FF01FE00FF00FF01FE00FC00FE007E00FC0078007C003
      E00FC00780078003C007C00380038003C007C00380038003C007C00380038003
      E00F800780078003E00FC00780078003F01FE00FC00FC003FC7FF81FE01FC007
      FFFFFFFFF83FE00FFFFFFFFFFFFFFC7F00000000000000000000000000000000
      000000000000}
  end
  object tmrUpdateForm: TTimer
    OnTimer = tmrUpdateFormTimer
    Left = 169
    Top = 17
  end
  object tmrUpdateHeading: TTimer
    OnTimer = tmrUpdateHeadingTimer
    Left = 273
    Top = 33
  end
end
