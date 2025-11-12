object fmMainMM: TfmMainMM
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'fmMainMM'
  ClientHeight = 1080
  ClientWidth = 1920
  Color = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMainMM: TPanel
    Left = 160
    Top = 0
    Width = 1600
    Height = 1080
    Alignment = taLeftJustify
    Color = clLime
    ParentBackground = False
    TabOrder = 0
    object pnlTop: TPanel
      Left = 10
      Top = 10
      Width = 1575
      Height = 89
      Color = clLime
      ParentBackground = False
      TabOrder = 0
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 1577
        Height = 89
        Caption = 'object Panel24: TPanel'
        TabOrder = 0
        object Panel13: TPanel
          Left = 0
          Top = 0
          Width = 137
          Height = 29
          Caption = 'Time Of Regime'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object Panel14: TPanel
          Left = 140
          Top = 0
          Width = 145
          Height = 29
          Caption = 'Regime'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
        object Panel15: TPanel
          Left = 288
          Top = 0
          Width = 171
          Height = 29
          Caption = 'Time Age'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
        end
        object Panel16: TPanel
          Left = 461
          Top = 0
          Width = 552
          Height = 29
          Caption = 'External Systems'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
        end
        object Panel17: TPanel
          Left = 1015
          Top = 0
          Width = 207
          Height = 29
          Caption = 'Fault'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
        end
        object Panel18: TPanel
          Left = 1224
          Top = -3
          Width = 183
          Height = 31
          Caption = 'SC'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
        end
        object pnlDate: TPanel
          Left = 1409
          Top = 0
          Width = 166
          Height = 53
          BevelOuter = bvNone
          Caption = '00.00.0000'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
        end
        object pnlTime: TPanel
          Left = 1409
          Top = 52
          Width = 166
          Height = 37
          BevelOuter = bvNone
          Caption = '00:00:00'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
        end
        object pnlTimeOfRegime: TPanel
          Left = 0
          Top = 31
          Width = 137
          Height = 58
          Caption = '00:00:00'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 8
        end
        object pnlRegime: TPanel
          Left = 140
          Top = 31
          Width = 145
          Height = 58
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 9
        end
        object pnlTimeAge: TPanel
          Left = 288
          Top = 31
          Width = 171
          Height = 58
          Caption = '00:00:00'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 10
        end
        object pnlTI1: TPanel
          Left = 461
          Top = 31
          Width = 137
          Height = 58
          Caption = 'TI 1'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 11
        end
        object pnlSperryMK: TPanel
          Left = 739
          Top = 31
          Width = 274
          Height = 20
          Caption = 'SPERRY MK 39'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 12
        end
        object pnlSperryATT: TPanel
          Left = 739
          Top = 52
          Width = 88
          Height = 37
          Caption = 'ATT'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 13
        end
        object pnlSperryB: TPanel
          Left = 832
          Top = 52
          Width = 88
          Height = 37
          Caption = 'B'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 14
        end
        object pnlSperryC: TPanel
          Left = 925
          Top = 52
          Width = 88
          Height = 37
          Caption = 'C'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 15
        end
        object pnlFault: TPanel
          Left = 1015
          Top = 31
          Width = 207
          Height = 58
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 16
        end
        object pnlSC: TPanel
          Left = 1224
          Top = 31
          Width = 183
          Height = 58
          Caption = 'OFF'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 17
        end
        object pnlTI2: TPanel
          Left = 600
          Top = 31
          Width = 137
          Height = 58
          Caption = 'TI 2'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 18
        end
      end
    end
    object pnlLeftCenter: TPanel
      Left = 10
      Top = 105
      Width = 823
      Height = 768
      Color = clTeal
      ParentBackground = False
      TabOrder = 1
      object fMap: TMap
        Left = 16
        Top = 43
        Width = 793
        Height = 720
        ParentColor = False
        TabOrder = 0
        OnMouseDown = fMapMouseDown
        OnDrawUserLayer = fMapDrawUserLayer
        ControlData = {
          8A1A0600F55100006A4A000001000000008080000D47656F44696374696F6E61
          727905456D70747900E8030000000000000000000002000E001E000000000000
          0000000000000000000000000000000000000000000600010000000000500001
          010000640000000001F401000000FFFF000C000000000000000000000000FFFF
          FF000100000000000000000000000000000000000000000000000352E30B918F
          CE119DE300AA004BB8510100000090013485190005417269616C000352E30B91
          8FCE119DE300AA004BB8510100000090015C790C0005417269616C0000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FFFF000000000000000001370000000000FFFFFF000000000000000352E30B91
          8FCE119DE300AA004BB851010000009001DC7C010005417269616C000352E30B
          918FCE119DE300AA004BB851010200009001A42C02000B4D61702053796D626F
          6C730000000000000001000100FFFFFF000200FFFFFF00000000000001000000
          01000118010000C848820F010000006C9015771C000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000002
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          8076C000000000008056C0000000000080764000000000008056400100000018
          010000C848820F01000000880300C01C00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000200000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000B0E49700DD865B761F
          00000000000000C0865B7660FA930F78215605F0E49700000000000000000000
          000088B3400000000000408F400001000001}
      end
      object Panel32: TPanel
        Left = 16
        Top = 8
        Width = 793
        Height = 30
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object pnlRTP: TPanel
          Left = 19
          Top = 3
          Width = 250
          Height = 26
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object Panel34: TPanel
          Left = 275
          Top = 3
          Width = 250
          Height = 26
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
        end
        object pnlRange: TPanel
          Left = 531
          Top = 3
          Width = 250
          Height = 26
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object pnlLeftBottom: TPanel
      Left = 10
      Top = 874
      Width = 823
      Height = 212
      Color = clTeal
      ParentBackground = False
      TabOrder = 2
      object pnlLeftBottomType: TPanel
        Left = 6
        Top = 7
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'TYPE :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblType: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomD: TPanel
        Left = 6
        Top = 49
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'D :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblD: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomDd: TPanel
        Left = 6
        Top = 91
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'D d :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lblDd: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomB: TPanel
        Left = 322
        Top = 7
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'B :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object lblB: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomDj: TPanel
        Left = 322
        Top = 49
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvLowered
        Caption = 'D j :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object lblDj: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomDsgh: TPanel
        Left = 322
        Top = 91
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'D sgh :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object lblDsgh: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomTrajectoryType: TPanel
        Left = 7
        Top = 175
        Width = 631
        Height = 29
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 
          'Trajectory Type :                                               ' +
          '                                                                ' +
          '             '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        object lblTrajectoryType: TLabel
          Left = 327
          Top = 7
          Width = 4
          Height = 16
        end
      end
      object pnlLatitudeShip: TPanel
        Left = 638
        Top = 7
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = #966's :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        object lblLatitude: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlLongitudeShip: TPanel
        Left = 638
        Top = 40
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = #955's :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        object lblLongitude: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlShipHeading: TPanel
        Left = 638
        Top = 73
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Cs :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        object lblShipHeading: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlShipSpeed: TPanel
        Left = 638
        Top = 106
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Vs :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        object lblShipSpeed: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlShipPitch: TPanel
        Left = 638
        Top = 139
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = #936's :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        object lblShipPitch: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlShipRoll: TPanel
        Left = 638
        Top = 172
        Width = 171
        Height = 32
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = #952's :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        object lblShipRoll: TLabel
          Left = 51
          Top = 8
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomPx: TPanel
        Left = 6
        Top = 133
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'P x :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        object lblPx: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
      object pnlLeftBottomPz: TPanel
        Left = 322
        Top = 133
        Width = 315
        Height = 41
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'P z :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        object lblPz: TLabel
          Left = 171
          Top = 12
          Width = 4
          Height = 16
        end
      end
    end
    object pnlRightTop: TPanel
      Left = 839
      Top = 105
      Width = 746
      Height = 168
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      object Panel62: TPanel
        Left = 11
        Top = 8
        Width = 727
        Height = 73
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object pnlNow: TPanel
          Left = 52
          Top = 16
          Width = 308
          Height = 41
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object pnlNext: TPanel
          Left = 380
          Top = 16
          Width = 308
          Height = 41
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
        object btnLog: TButton
          Left = 646
          Top = 5
          Width = 75
          Height = 25
          Caption = 'btnLog'
          TabOrder = 2
          Visible = False
          OnClick = btnLogClick
        end
      end
      object Panel63: TPanel
        Left = 11
        Top = 87
        Width = 727
        Height = 74
        TabOrder = 1
        object btnTI: TSpeedButton
          Left = 54
          Top = 13
          Width = 91
          Height = 44
          Caption = 'TI'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnTIClick
        end
        object btnSD: TSpeedButton
          Left = 163
          Top = 13
          Width = 91
          Height = 44
          Caption = 'SD'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnSDClick
        end
        object btnDES: TSpeedButton
          Left = 272
          Top = 13
          Width = 91
          Height = 44
          Caption = 'DES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnDESClick
        end
        object btnPLP: TSpeedButton
          Left = 381
          Top = 13
          Width = 91
          Height = 44
          Caption = 'PLP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnPLPClick
        end
        object btnDOC: TSpeedButton
          Left = 490
          Top = 13
          Width = 91
          Height = 44
          Caption = 'DOC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnDOCClick
        end
        object btnEXIT: TSpeedButton
          Left = 599
          Top = 13
          Width = 91
          Height = 44
          Caption = 'EXIT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnEXITClick
        end
      end
      object btnFire: TButton
        Left = 16
        Top = 131
        Width = 75
        Height = 25
        Caption = 'FIRE'
        TabOrder = 2
        Visible = False
        OnClick = btnFireClick
      end
    end
    object pnlPLP: TPanel
      Left = 839
      Top = 279
      Width = 746
      Height = 666
      Color = clTeal
      ParentBackground = False
      TabOrder = 4
      object grpPLP: TGroupBox
        Left = 0
        Top = 0
        Width = 729
        Height = 657
        TabOrder = 0
        OnMouseDown = grpPLPMouseDown
        object lblTimeToPLP: TLabel
          Left = 40
          Top = 23
          Width = 212
          Height = 18
          Caption = 'Time Of Preparation to PLP :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 464
          Top = 164
          Width = 89
          Height = 18
          Caption = 'Operational'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 464
          Top = 201
          Width = 84
          Height = 18
          Caption = 'Designated'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 464
          Top = 234
          Width = 73
          Height = 18
          Caption = 'Cancelled'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 464
          Top = 269
          Width = 71
          Height = 18
          Caption = 'Launched'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 464
          Top = 305
          Width = 53
          Height = 18
          Caption = 'Passed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgRuler: TImage
          Left = 64
          Top = 607
          Width = 609
          Height = 42
          ParentShowHint = False
          Picture.Data = {
            07544269746D6170663A0100424D663A01000000000036000000280000006102
            00002C0000000100180000000000303A0100C40E0000C40E0000000000000000
            00003E3F1D403E1F403F1D3E3F1D403F1D413F1D413F1D403E1F3E3F1D403E1F
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D403F1D3E3F
            1D403F1D403F1D403F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E401C3E401C403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D40
            3F1D403F1D403F1D403F1D3E3F1F3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403E1F
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403E1F403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1F3E3F1D403E1F403F1D3E3F1F3E3F
            1D403E1F403F1D403F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D
            403F1D403F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D3E3F1D3E3F1D3E3F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D403F1D403F
            1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1F3E3F
            1D403E1F403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D403F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D403F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D403F1D403F1D403F1D403F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D403F1D403F1D403F1D403F1D3E
            3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1F3E3F1D403E1F
            403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D40
            3F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D403F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D
            3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1F3E3F1D403E1F403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D403F1D403F1D403F1D403F1D403F1D403F1D403E1F403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E
            3F1D3E3F1DFF4343134343154343154343154343134543134543134343154343
            1343431543431343431343431343431343431341441341441343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134144134144
            1343431343431543431543431543431543431343431343431345431343431343
            4313434313454313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431341441341441343431343431343431343431341
            4413414413434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343154343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431543431543431543431343431343431343431343431343431343431343
            4313434313434315434315434315434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431543431343431543431343
            4315434313434315434313434313434313434313434313434313434313434313
            4343134144134144134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431341441341441343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1345431343431341441341441343431343431343431343431343431343431343
            4315434313434315434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134144134144134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343154343
            1343431543431343431343431343431343431343431343431343431343431341
            4413414413434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134144134144134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313414413414413434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434315434313434315434313434313434313434313
            4343134343134343134343134343134144134144134343134343134343134343
            1343431343431343431343431343431343431343431343431343431543431543
            4315434313434313434313434313434313434313434313434313434313434313
            434313434313434313FF45450F45441145441145450F45450F47450F47450F45
            450F45450F45450F45450F45450F45450F45450F45450F43460F43460F45450F
            45450F45450F45450F45450F45460E45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F43
            460F43460F45450F45450F45441145441145450F45450F45450F45450F47450F
            47450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F43460F43460F45450F45450F45460E
            45460E43460F43460F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45441145441145450F45450F45450F45450F45450F45450F45460E
            45460E45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45460E45460E45450F4545
            0F45450F45450F43460F43460F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45460E45460E45450F45450F45450F45450F43460F43460F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E47450F45450F45450F43460F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45460E45460E45450F4545
            0F45450F45450F43460F43460F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45460E45460E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43460F43460F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45460E45460E43460F45450F45450F47450F45
            460E45460E45460E45460E45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F43460F43460F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F43460F43460F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450FFF45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45441145441145450F4545
            0F45450F45450F45441145450F45450F45450F45460E45460E45450F45450F45
            450F45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F43460F43460F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145450F45
            450F45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F45450F45450F45460E45460E45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            441145441145450F45450F45460E45460E45450F45450F45450F45450F45450F
            45450F45450F45450F45441145450F45450F45460E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45
            450F45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F4545
            0F45450F45450F47441147441145450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F47
            441147441145450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45460E45460E45450F45450F43460F43460F45450F4545
            0F47450F47450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F47450F47450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45441145441145450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F47
            450F47450F47450F47450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F43460F43460F4544114544
            1145450F45450F43460F43460F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F47450F47450F45450F45450F45450F45450F4544114544114544114544
            1147450F47450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45441145441143460F43460F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45460E45460E45450F45450F45450F45450F45
            450F45450F43460F43460F45441145441145450F45450F43460F43460F45450F
            45450F45450F45450F45450F45450F45460E45460E45450F45450F4544114544
            1145450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450FFF45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F45450F45441145441145450F45450F45460E45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F43460F43460F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F43460F43460F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45450F45450F45460E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45460E45460E45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45441145441145450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441145450F45450F45460E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45460E45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45
            450F45450F45450F45450F47441147441145450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45460E45460E45450F
            45450F47441147441145450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45460E45460E45450F45450F43460F43460F45
            450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441145441145450F45450F45441145441145
            450F45450F45450F45450F45450F45450F45450F45450F45460E45460E45450F
            45450F47450F47450F47450F47450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F43460F45
            441145441145450F45450F43460F43460F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45441145441145
            441145441147450F47450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45441145441143460F43460F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45450F
            45450F45450F45450F45450F43460F45441145441145450F45450F43460F4346
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45
            441145441145450F45450F47450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450FFF45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F44440E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F46461045450F47450F
            47450F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F43460F43460F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F44440E45450F45450F45450F45450F45
            450F45450F45441145441145450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F43460F43460F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F44440E44440E45450F45450F
            46461047450F47450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F44440E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F47450F45450F45450F45441145441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441145441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F46461045450F46461045450F
            45450F45450F45450F45450F45450F45460E45460E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45441145441145450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F47450F47450F47450F47450F45450F
            45450F45450F45450F47450F47450F45450F46461045450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F43
            451143451145450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F46461045450F45450F43460E43460E45450F45450F45
            441145441147450F45450F45450F43460F45450F45450F47450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F44440E45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F43460F
            43460F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F43460F43460F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F43460F43460F43460F4346
            0F45450F45450F47450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450FFF45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F44440E45450F4545
            0F46461045450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F47450F45450F45450F45441145450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F43460F43460F45450F45450F45450F45450F45450F4545
            0F45441145441145450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F44440E45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45441145441145450F
            46461045450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F43460F43460F45
            450F45450F45450F45450F45450F45450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F44440E45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F47450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F44440E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45441145441145450F45450F45450F45450F45450F45450F45450F45450F47
            450F47450F45450F45450F45450F45450F45450F44440E45450F44440E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F47450F47450F45450F45450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F44440E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F44440E45450F45450F45460E45460E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F44431045441145450F45450F45450F45450F45450F45450F45
            450F44440E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F47450F47450F47450F4745
            0F45450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43451143460F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F43460E43460E45450F
            45450F45441145441146440E45450F45450F43460F45450F45450F47450F4745
            0F45450F45450F45450F45450F45441145441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F43460F43460F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F43460F43460F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F43460F43460F43
            460F43460F45450F45450F47450F47450F45450F45450F45450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45441145441145450F45450F45441145441145450F45450F45450F45450F45
            450F44440E45450F45450F45450F45450F45450F45450F45450F45450FFF4545
            0F44440E45450F45450F45450F45450F44440E45450F45450F45450F45450F45
            450F45450F45450F46461044440E45450F45450F45450F45441145441145450F
            44440E43460F43460F45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F47450F45450F45450F45450F45450F45450F44440E45450F46461045
            450F45450F45450F45450F45450F45450F45450F45450F45450F45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F43
            460F45450F45450F47450F45450F45450F44440E45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F43460F43460F45450F45450F45
            450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F
            45450F45450F45450F45460E45460E45450F45450F45450F45450F47450F4745
            0F45450F45450F43460F45450F45450F47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F44440E45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43460F43460F45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F47450F45450F45450F45450F45450F45450F46461046440E47450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            441142441044440E45450F47450F47450F47450F47450F45450F45450F47460E
            47460E44440E45450F47450F48461045450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F44440E44440E
            45450F45441145441145450F46461045450F44440E45450F46461044440E4545
            0F45450F46461045450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47441146431044440E45450F45450F4545
            0F45450F45450F45450F44440E45450F45450F44440E45450F47450F48461045
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F44440E44440E45450F45441145441145450F45450F45
            450F45450F45450F45450F44440E45450F43460F44471045450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F44440E44440E45450F45450F45450F44440E44440E45450F45450F47460E
            47460E44440E45450F47450F48461045450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45460E45460E45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F44440E45450F45460E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F44440E43460F43460F46461045450F45450F45450F45450F45450F45
            450F44440E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45441145441145450F45450F45450F45450F45450F45450F47
            450F45450F43460F43460F45450F45450F45450F45450F45441144431045450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F44440E44440E44440E45
            450F45450F45450F45450F45450F45450F45450F45450F44431045441145450F
            45450F45450F45450F45450F45450F45450F44440E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F44440E45450F45450F45450F47450F
            47450F44440E45450F45450F46461045450F45450F45450F45450F45450F4545
            0FFF45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F4544114344124544124544114544114645124343134343
            1345441145450F45450F43460F45450F45450F45450F45450F45450F45450F45
            450F45450F47450F45450F45450F45450F45450F45450F45441145441145450F
            45450F45450F45450F45441143441245441243441245441245441145450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43460F45450F45450F45450F45441143451145450F4544114344124344
            1245441145450F45441143441245441245441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F43460F43460F45450F
            45450F45450F45450F45450F45450F45450F45450F47450F45450F45450F4545
            0F45450F45450F45441143441245441144451342421243431343441245441245
            441245441245441243451143460F45450F45450F47450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            441145441145450F45450F45441144431045450F45450F454411434412454412
            45441145450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F43460F43460F45450F45450F45450F45450F45450F45450F45
            450F45450F47450F45450F45450F45450F45450F45450F45441145441145450F
            45441143441243441245441145450F45441143441245441245441145450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43451143451145450F45450F4544114544124543134543134544114544
            1145441243441245441245441146440E47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45441145441243431343431343431345441145441143431343431343
            441245441144440E45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47441147441145450F45450F46
            451245441145450F45450F45450F45441143431343431343441245441146440E
            47450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F454411454412434313434313
            43431345441145441143431343431343441243451144431045450F45450F4545
            0F45441145441145450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F4544114344124343134343134544114544
            1145441245441245441245441146440E47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F44440E45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441143451145441243441243431343431345
            441145450F45450F45450F45450F45450F45460E45460E45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F44440E45450F45450F45450F45450F45450F45450F45441143
            441243431343441243441243441243441243431343431345441145450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F454411454411454412434412434313434313434313
            43431345441245441243431343431345441145450F45450F45450F4544114544
            1145450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45441145441145450F4544114544124343
            1343431343431345441145450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F45450F45441145441144440E45450F45450F45450F45450F45450F45
            450F45450FFF45450F45450F45450F45441145441145450F45450F45460E4544
            114242144242144544114544114343154142164341184343154645134344123F
            40193F401845441245460E45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F4544114343154343
            1546451245450F45450F45441143431541421643421641421643421643431543
            441245450F45450F47450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45460E4546
            0E45460E45460E45450F45450F45450F45441141431541431543451143441240
            411940411943441245441143431541421643421643431545441145450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45441143431541421643421641421840401C40401C414218
            42411543421643421643421643431543451145450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F47450F45450F45450F43460F45450F45450F45450F
            4544114343154343154544114544114343154343154544114544114343154142
            1643421643431545441145450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F4544114343154343
            154544114344124041193F401843441245441143431541421643421643431545
            441145450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F454411434315404018413F1C41401A43
            43134343133F401940401C41411943431545441147450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F47450F47450F45
            450F45450F45450F45441142421441411940401C41401A43431343431341401A
            403F1D41411943431545441147450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45441145441145450F45450F45450F
            45441143431543431545441147450F45450F44441441401A40401C4141194343
            1545441147450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F47450F47450F47450F47450F45450F45450F45450F4544114343154141
            1940401C41401A43431343431341401A40401C41411943431545441245450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45460E4546
            0E45450F45450F45450F45450F45450F45441143431541411940401C41401A43
            431343431341401A413F1C41411943431545441147450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F46461045450F45450F45
            450F45450F45450F45450F44440E45441142421441421643421641411940401C
            41401A43431345450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F46461045450F45450F45450F45450F45450F
            43441241421A40401C414218434216434216414119413F1C41401A4343134545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47
            450F47450F45450F45450F45450F45450F45460E45460E47450F47450F45450F
            45450F45450F45450F45450F46461047450F45441143431541421841411D3E3F
            1D3F3E1C40401C41411941411940401C41401A43431345450F45450F45450F43
            460F43460F45441145441145450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45460E4546
            0E45450F45450F47450F47450F45450F45441143431543431545441145441143
            431541411940401C41401A43431345450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F47
            450F47450F45450F45441143431543431545441145450F45450F45450F45450F
            45450F45450F45450FFF45450F45450F45450F45441145441143431343441245
            450F434412414218FFFFE3434412434412434216FFFFE4FFFFE641401A434216
            414216FFFFE4FFFFE443421645441245441145450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441143441243441243451145450F454412FF
            FFE2414119434313434313434315414218FFFFE6403F1D40401CFFFFE6FFFFE6
            41411943431345450F45450F47450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45450F45441143451145441245441145450F434412FFFFE2404119434313
            414315FFFFE6FFFFE6434315434313414119FFFFE6FFFFE64142184344124545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            43441243441243451145450F454412FFFFE240411A414119FFFFE4FFFFEAFFFF
            E9FFFFE340411741401AFFFFE6FFFFE641411943441245450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F45450F4345114344124344124544
            1145450F434412FFFFE2414218434412434511414218FFFFE243441243441241
            4218FFFFE6FFFFE641421843441245450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441143441243441243451145450F454412FF
            FFE2414119434216414216FFFFE4FFFFE4414216434216414119FFFFE6FFFFE6
            41411943441245450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F454411434412454412434313414119FFFFE7FFFFEB
            FFFFEA40401C40411AFFFFE7FFFFE7FFFFE641421845441247450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F47450F
            45450F454411434412454412434313414119FFFFE7FFFFEBFFFFEA4141194141
            19FFFFE7FFFFE9FFFFE641421845441247450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F4544114544114544124344
            12454412434313434315FFFFE0434315434313434313414216FFFFE6FFFFE7FF
            FFE641421845441247450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F47450F45450F45441143441245441243431341
            4119FFFFE6FFFFE7FFFFE741401A41401AFFFFE7FFFFE7FFFFE7414119454412
            47450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F45450F454411434412454412434313414218FFFFE4FFFFE7
            FFFFE741401A41401AFFFFE7FFFFE7FFFFE641421845441247450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            454411434412434313434412434313434315414218FFFFE6403F1D40401CFFFF
            E6FFFFE7FFFFE641421643441245441145450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F4544114344124343
            13434412434315FFFFE6FFFFE9FFFFE642401D413F1CFFFFE6FFFFE7FFFFE641
            421643441245441145450F45450F45450F45450F45450F45450F45450F45450F
            45450F47450F47450F45450F45450F45450F45450F45460E45460E47450F4745
            0F45450F45450F45450F45450F45450F454411454412434315414218FFFFE4FF
            FFEAFFFFEBFFFFEAFFFFE940401CFFFFE6FFFFE7FFFFE6414216434412454411
            45450F43460F43460F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            460E45460E45450F454411454412454412454411434412414218FFFFE2434412
            434412404117FFFFE6FFFFE7FFFFE641421643441245441145450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F
            47450F47450F454411434313434216FFFFE341421843441245450F45450F4545
            0F45450F45450F45450F45450FFF47450F45450F45450F45450F43431341401A
            41401A43441243431340401CFFFFE6434313434412FFFFE040411A3E3F1FFFFF
            E9403E1FFFFFE6414216414216FFFFE641401A45431347450F45450F45450F45
            450F45450F45450F45450F45450F454411434315414216414216434315454411
            434313FFFFE63E3F1D414119FFFFE4FFFFEBFFFFF0FFFFF1FFFFF0FFFFEB3C3E
            203E3E20FFFFE643431345450F45450F45460E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F454411434315414216434216434315454411434313FFFFE63E3F
            1D404119FFFFE240411A41401AFFFFE2414119FFFFE73E3E203E3E20FFFFE643
            431345460E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F47450F47450F45450F45450F45450F45450F45450F45450F45450F4544
            11434315414216414216434315454411434313FFFFE63E3F1D40411AFFFFE43D
            3D1F3E3F1D434315434315FFFFE63E3E203E3E20FFFFE643431345450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F45441143431541421641
            4216434315454411434313FFFFE640401C43431343441240411AFFFFE4434313
            434313FFFFE63E3E203E3E20FFFFE643431345460E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45
            450F45450F45450F45450F45450F454411434315414216414216434315454411
            434313FFFFE63E3F1F403E1FFFFFE6414216414216FFFFE6403E1FFFFFE93E3E
            203E3E20FFFFE643431345450F47450F47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F454411434315414216434216414119FFFFE73E3E
            203E3D213C3B26FFFFF4FFFFF040411A4043163E3F1DFFFFE443441245460E46
            461045450F45441145441145450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F47450F47450F45450F45450F45450F45450F4744114744
            1145450F454411434315414216434216414119FFFFE73E3E203E3D213C3D23FF
            FFEEFFFFEA4141194142183E3F1DFFFFE643431345450F46461045450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45441143
            4315414216434216434315434313434315FFFFE441401E403F1DFFFFE4414216
            414216403F1DFFFFE443441245460E46461045450F45441145441145450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45
            450F45450F45450F45450F47441147441145450F454411434315414216434216
            414119FFFFE740401C41421841401AFFFFF0FFFFF041401A434118403F1DFFFF
            E643431345450F48461047450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F43460F43460F45450F454411434315414216434216414218FFFFE34142
            1843431541401AFFFFF1FFFFF141401A414216403F1DFFFFE443441245460E46
            461045450F45441145441145450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45441145441145450F45450F45450F4545
            0F45460E4344124041193E401C414218FFFFE4FFFFEBFFFFF0FFFFF1FFFFEEFF
            FFEB40401C414218414216FFFFE440411943441245450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F43441240
            411940401C414218FFFFE241401A40401C403E1FFFFFEAFFFFEA40401C414218
            414216FFFFE440411943441245450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F44451340411940401C41401A
            FFFFE43E3E203E3E20403F1D40401CFFFFE940401C414218414216FFFFE44041
            1943441245450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F4344124041194041194344124343133F3F1BFFFF
            E6434313434313FFFFE640401C414218414216FFFFE440411943441245450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F47450F45450F45450F45450F4545
            0F47450F47450F45450F43431341401AFFFFE93E3F1FFFFFE643431345450F46
            461045450F45450F45450F45450F45450FFF47450F45450F45450F45450F4343
            13FFFFE4FFFFE4454313434315403E20FFFFEA444416434313403F193E3F1F3E
            3F1FFFFFEA3E3D21FFFFE7434315434313FFFFE9403F1D45421547450F45450F
            45450F45450F45450F45450F45450F45450F454411434315FFFFE0FFFFE04343
            15434313434216FFFFE73E3F1F41411940411AFFFFEE393B28FFFFF43A3A28FF
            FFEE3C3E213E3D23FFFFE743431544440E45460E45460E45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F454411434315FFFFE0FFFFE0434315434313414216FF
            FFE73E3F1F40401C414119414218FFFFE2403F19403F1DFFFFEA3C3E213C3D23
            FFFFE743431344450D45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F454411434315FFFFE0FFFFE0434315434313434216FFFFE73D3E1E40411A
            414119FFFFE6FFFFE4434315434216FFFFE73C3E213E3D23FFFFE74343154444
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F47450F454411434315
            FFFFE0FFFFE0434315454313434216FFFFE73E3F1D4343134343133E3F1FFFFF
            E6434315434313FFFFE73C3E213C3D23FFFFE743431344450D45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45450F
            45450F45450F45450F45450F45450F45450F454411434315FFFFE0FFFFE04343
            15434313434216FFFFE73C3E213D3C22FFFFE7434315424212FFFFE93E3D23FF
            FFEB3C3E213E3D23FFFFE943431544440E47450F47450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F44440E45450F45450F434511434315FFFFE0FFFFE04141193E
            3F1FFFFFEAFFFFE9FFFFEEFFFFF9FFFFF53F40184144133E3F1DFFFFE7434313
            46470F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F47450F47450F45450F45450F45450F45450F46
            431047441145450F454411434315FFFFE0FFFFE04141193E3F1FFFFFEAFFFFE9
            FFFFEB393A2AFFFFF04142184343133E3F1DFFFFE743431346461045450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F44440E45450F45450F
            454411434315FFFFE0FFFFE0434315454411434313FFFFE93E3D233C3E21FFFF
            E74343134343133E3F1DFFFFE743431346470F45450F45450F45441145441145
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F
            47450F45450F45450F45450F45450F46431047441145450F454411434315FFFF
            E0FFFFE040411AFFFFEB3E3E2041421840401CFFFFF5FFFFF44041174343133E
            3F1DFFFFE743431346461047450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F42450E43460F45450F454411434315FFFFE0FFFFE04142183F
            3F1B40401C41421640401CFFFFF4FFFFF24142184343133E3F1DFFFFE7434313
            46470F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45441145441145450F45450F45
            450F45450F45460E434412FFFFE3FFFFE640411740401CFFFFF03A3A2AFFFFF4
            3A3B27FFFFED3E3F1D434313434313FFFFE73E3F1D43431345450F45450F4444
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            434412FFFFE3FFFFE6403F19414119414218FFFFE4FFFFEA3E3D23FFFFEB3E3F
            1D434313414413FFFFE73C401D43431345450F45450F44440E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F434412FFFFE3FFFF
            E641401A41401AFFFFE6FFFFE6FFFFE6403F1DFFFFEA3E3F1D434313434313FF
            FFE73E3F1D43431345450F45450F44440E45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45460E45460E44440E434412FFFFE3FFFFE34344124343153E
            3F1FFFFFE9434315434313FFFFE73E3F1D434313404312FFFFE73C401D434313
            45450F45450F44440E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F45450F45
            450F45450F46440E47450F45450F414413403E1FFFFFED3C3E21FFFFE7434313
            46461045450F45450F45450F45450F45450F45450FFF45450F45450F45450F45
            450F4544114442124543134744114342163E3D23FFFFED414216434315FFFFEB
            FFFFEEFFFFE93F3E1C3E3D21FFFFE7414315414413FFFFE9403F1D4542154745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441143441245
            4411424311434315414119FFFFE93E3F1D404115414216FFFFEA3A3D24FFFFF0
            3C3C24FFFFED3C3E213E3D23FFFFE743431544440E45460E45460E45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F454411434412454412424212414315
            404119FFFFE93D3E1E40401C414218424212434315FFFFE73E3E20FFFFEB3C3E
            213C3D23FFFFE743431344440E45450F45450F45450F45450F45450F45450F45
            450F45450F47441147441147450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F454411434412454411424311434315414119FFFFE93D3E
            1E40411A414216424212414315FFFFE4403E1FFFFFEA3C3E213E3D23FFFFE743
            431544440E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F454411434412454412424212434315414119FFFFE93E3F1D4444144143153C
            3D23FFFFEB434216434313FFFFE73C3E213C3D23FFFFE743431344440E45450F
            45450F45450F45450F45450F45450F45450F45450F47441147441147450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441143441245
            4411424311434315414119FFFFE93C3E213E3D23FFFFE7434315424212FFFFE9
            3F3E24FFFFEB3C3E213E3D23FFFFE945421546440E47450F47450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F43460F43460F434511434412454412
            414216FFFFE73E3F1F43411840401CFFFFF7FFFFF54041194144133E3F1DFFFF
            E743431346461045450F45450F45441145441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F454411434412454412414216FFFFE73E3F
            1F41421840401CFFFFF5FFFFF44141194343133E3F1DFFFFE743431346461045
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45441145441145441243441245441245441145450F434313FFFFE93E3D233B
            3D20FFFFE74343134444143E3F1DFFFFE743431346461045450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            4411434412454412414218FFFFEEFFFFF1FFFFEBFFFFEB3A392BFFFFF1414218
            4242123E3F1DFFFFE743431346461045450F45450F45460E45460E45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F454411434412454412
            414216FFFFEBFFFFEEFFFFEAFFFFE93C3C24FFFFEB4343154343133E3F1DFFFF
            E743431346461045450F45450F45441145441147450F47450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F454411434412434313434412414216FFFFEA3C3C
            24FFFFEE3C3C24FFFFED3D3E1C434313434313FFFFE73E3F1D43431345450F45
            450F44440E47450F47450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F454411434412424214414218414218434315424115403E1FFFFFEDFF
            FFEB3E3F1D424212414413FFFFE73C401D43431545441147450F46440E45450F
            45450F45450F45450F45450F45450F45460E45450F45450F45450F47450F4745
            0F45450F45450F43451143451143460F43460F45450F45450F45450F45441143
            4412424214434118434118434315424115403F1DFFFFEAFFFFEB3E3F1D404312
            414413FFFFE73E3F1D43431345450F45450F44440E45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F454411434412434412454411
            4142163C3D23FFFFED414216424212FFFFE63E3F1D434313414413FFFFE73C40
            1D43431545441147450F46440E45450F45450F45450F45450F45450F45450F45
            460E45450F45450F45450F45450F45460E45450F45450F45450F45450F45450F
            45450F45450F45450F46440E47450F45450F434313403E1FFFFFED3C3E21FFFF
            E743431345450F45450F45450F45450F46461047450F47450FFF45450F45450F
            45450F45450F45450F45450F47450F47450F434315FFFFEBFFFFEB4343154343
            153E3D21FFFFEE403E1F40401C403F1DFFFFE6414216414216FFFFE641401A45
            431347450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E454411434315FFFFE3FFFFE740401C434313434412404119FFFF
            E7FFFFEA3E3E20FFFFEA3E3E203E3E20FFFFE643431345450F45460E45460E45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4345
            11414315FFFFE3FFFFE73E3F1D414119FFFFE0434315414216FFFFE63E3F1FFF
            FFE93C3E203E3E20FFFFE643431345450F45450F45450F45450F45450F45450F
            45450F45450F45450F47441147441147450F47450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E454411434315FFFFE3FF
            FFE73E3F1D414218FFFFDF434313414315FFFFE6403E1FFFFFE93E3E203E3E20
            FFFFE643431345450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47
            450F47450F45450F45450F45450F454411434315FFFFE3FFFFE740401C434313
            424416FFFFEBFFFFEA434315434313FFFFE63C3E203E3E20FFFFE64343134545
            0F45450F45450F45450F45450F45450F45450F45450F45450F47441147441147
            450F47450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E454411434315FFFFE3FFFFE73E3F1F403E1FFFFFE64142164142
            16FFFFE6403E1FFFFFE93E3E203E3D21FFFFE745431347450F47450F47450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F43460F43460F45450F4545
            0F45450F434313FFFFE640401C43411841401AFFFFF0FFFFEF40411A4142163E
            401CFFFFE443431345450F46461045450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F434313FF
            FFE640401C41421841401AFFFFF1FFFFF041401A414216403F1DFFFFE6434313
            45450F46461045450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45441145441145450F45450F45450F454411444513414218403E1F
            FFFFEB3E3E20FFFFE64341184342163E401CFFFFE443431345450F4646104545
            0F45441145441145450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F434315FFFFEA3D3C283C3C243C3D23FFFFEEFFFF
            EB414119414218403F1DFFFFE643431345450F46461045450F45460E45460E45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F4343153E3D21FFFFF03E3C243E3D213D3D1FFFFFE641421841421640
            3F1DFFFFE643431345450F46461045450F45441145441147450F47450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F4344123F
            4018FFFFE7FFFFEA3E3E20FFFFEA40401C414218414216FFFFE4404119434412
            45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F454411434315FFFFE0434315414218403F1D
            FFFFEAFFFFEA40401C414218414216FFFFE440411943431345441145450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45450F45450F45441147
            450F47450F45450F45450F43451143460F43460F43460F45450F45450F45450F
            45450F45450F454411434315FFFFE0434315434216403F1DFFFFEAFFFFEA3E40
            1C414218414216FFFFE440411943441245450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F434315FFFFEBFFFFEB434315434313FFFFE640401C414218414216FF
            FFE440411943431345441145450F45450F45450F45450F45450F45450F45450F
            45450F45460E45450F45450F45450F45450F45460E45450F45450F45450F4545
            0F45450F45450F45450F45450F47450F47450F45450F43431341401AFFFFE93E
            3F1FFFFFE643431345450F45450F45450F45450F45450F47450F47450FFF4545
            0F45450F45450F45450F45450F45450F45450F45450F43431341401AFFFFE443
            431343431341401AFFFFE9FFFFE9FFFFE6414218414216FFFFE6FFFFE6414216
            43431345441145450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F454411434313FFFFE341421843441245441143
            4412414216FFFFE33F3F1B40401CFFFFE6FFFFE641411943441245450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E43460F43460F45
            450F45450F434511434313FFFFE2414119434313434315FFFFE4FFFFE4414216
            414216414119FFFFE6FFFFE641411943441245450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            434313FFFFE2414119434313434313FFFFE4FFFFE4414216434216414119FFFF
            E6FFFFE641411943441245450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F47450F45450F454411434313FFFFE34142
            1843441243431340411AFFFFE3434412434412414218FFFFE6FFFFE641411943
            441245450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F454411434313FFFFE3414119434216414216FF
            FFE6FFFFE6414216434216414119FFFFE6FFFFE641411945441247450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F434412414218FFFFE6FFFFE7FFFFE740411A40411AFFFFE7
            FFFFE7FFFFE441421843441245450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45460E45460E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            434412414218FFFFE6FFFFE7FFFFE741401A41401AFFFFE7FFFFE7FFFFE64142
            1843441245450F45450F45450F45441145441145450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F47450F47450F45450F434412FFFFE3FFFF
            E9FFFFEBFFFFEBFFFFE740401CFFFFE7FFFFE7FFFFE441421843441245450F45
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45460E
            45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F434313403F19FFFFE9FFFFEBFFFFEA41
            4119414119FFFFE7FFFFE9FFFFE641421843441245450F45450F45450F45460E
            45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F47450F45431341401AFFFFEAFFFFEBFFFFEBFFFFE740401CFFFFE7
            FFFFE7FFFFE641421843441245450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45460E45460E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            454411434412414216FFFFE340401C40401CFFFFE6FFFFE6FFFFE64142164344
            1245441145450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45460E45450F454411434315FFFFE4FFFF
            E6FFFFE640411A40411AFFFFE6FFFFE7FFFFE641421643441245441145450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45460E45450F4545
            0F45441145441145450F45450F454411434315FFFFE4FFFFE6FFFFE640401C40
            401CFFFFE6FFFFE7FFFFE641421643441245441145450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45460E43441241401AFFFFE4434313434412414218FFFFE6FFFFE7
            FFFFE641421643441245441145450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F454411434313
            434216FFFFE341421843441245450F47450F47450F45450F45450F4544114544
            11FF45450F45450F45450F45450F454411434313434313434511434511434315
            43431545441145441143431540411740401C40411943441243431340411A4041
            1A43431344440E45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F454411434315434315454411
            4544114344124343154342164142164342164142164342164343154544114545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45460E43460F
            43460F45450F45450F45450F4544114343154343154544114242123E3F1D3E3F
            1D43431345441143431541421643421643431545441145450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F4544114343154343154544114242123E3F1D3E3F1D43431343451143
            431541421643421643431545441145450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45460E45450F45450F47450F47450F45450F45441143
            4315434315454411434412414218414218434412454411434315414216434216
            43431545441145450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F454411434315434315464512
            4343133E3F1F3E3F1D4343154544114343154142164342164343154544114745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45441143431541421840401C40411A4142164142
            1640401C40401C41421843431345441145450F45450F45450F45450F45450F45
            450F45450F45450F45450F47450F47450F45460E45460E45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45441143431541411940401C40401C41421641421640401C40401C41
            411943431545441145450F45450F45450F45441145441145450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F43441240
            41193E3F1D403F1D403F1D40401C40401C403F1D40401C414218434313454411
            45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45460E45460E45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45441143431541411940401C
            40401C41421641421640401C403F1D41411943431545441245450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F47450F45441143421641411940401C403F1D40401C4141
            1D3F3E1C40401C41411943431545441145450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F43441241411941401A41421841411941411D41401A43
            431345450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45460E45460E45450F43441240
            411940401C40411A41411941421841411940401C41401A43431345450F47450F
            45450F45450F43460F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45460E45460E45
            450F45450F45441145441145450F45450F45450F4343134041193E401C40401C
            41401A41421841411940401C41401A43431345450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45460E4544114343154342164444164343154342164141
            1940401C41401A43431345450F47450F45450F45450F43460F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45441143431543421643431543431345441147450F45450F45450F45
            4411454411FF45450F45450F45450F45450F434313FFFFE440411A4343134346
            0F43451145441145450F45450F45441145441243431343441245441145441143
            431343431345441145450F45450F45450F45450F45450F45460E45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F4544114544
            1144440E434412404119FFFFE443431543441245441243441245441245441245
            441145450F45450F45450F45450F45450F45450F45450F47450F47450F45450F
            45450F45450F45450F45450F45450F45450F45450F45441145450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45441145441145450F4343133E
            3F1DFFFFE743431345450F45441143441245441245441145450F47450F45460E
            45460E45450F45450F45460E45460E45460E45460E45460E45460E45450F4545
            0F45450F45450F45460E45460E45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45441145441145450F4343133E3F1DFFFFE7414413
            43460F43451143441245441245441145450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F45441145450F45450F45450F45450F45450F45450F45450F45450F
            45450F45441145441145450F43431340401CFFFFE643431345450F4544114344
            1245441245441145450F47450F45460E45460E45450F45450F45460E45460E45
            460E45460E45460E45460E45450F45450F45450F45450F45460E45460E45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F4544114443
            1045450F4444143E3F1FFFFFE743431545450F45441143441245441245441145
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45450F
            45450F45450F45450F45450F45450F45450F45450F45441145441145450F4545
            0F45450F45450F45450F45450F45450F45450F454411434412434313404214FF
            FFE440411A42431743431343441245441144440E45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F454411454411454412434412434313404115FFFFE43E411A424317
            43431343441245441144440E45450F45441145441145450F45450F45450F4545
            0F45450F45450F47450F47450F45450F45450F45450F45450F45450F45450F45
            450F45450F45441145441145450F45450F43460F43460F45460E45460E45450F
            454411434412434313424212414218FFFFE73E3F1D4142184343134344124544
            1144440E45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45450F
            45450F45450F45450F45450F45450F45450F45450F4544114544114544124344
            12424212414216FFFFE43F401941421643431343441245441144431045441145
            450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45450F
            45450F45450F45450F45450F45450F45450F45450F45441145441145450F4545
            0F45450F45450F47450F47450F45450F45450F454412434412434313414216FF
            FFE640401C41421842421243441245441144440E45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45
            450F45450F45450F45450F44440E43431340401CFFFFE7434315434412434313
            43431345441145450F45460E45460E45450F45450F43460F45450F45450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            454411434412414216403F1DFFFFE64343154344124343134343134544114545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F4544114544114544114544114343134142
            16403F1DFFFFE743431543441243431343431345441145450F45450F45450F45
            450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F454411434315413F1CFFFFE644
            441643441243431343431345441145450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45441145441145450F45450F45
            450F45450F45450F45450F45441143431541401AFFFFE443431345450F45450F
            45450F45450F45450FFF45450F45450F45450F45450F434313FFFFE9403F1D41
            431543460F45450F45450F45450F45450F47450F47450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45460E4546
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F4343133E3F1DFFFFE743431345450F45450F45450F454411
            45441145450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F45450F45450F45450F45450F45450F44440E45450F45450F
            4343133E3F1DFFFFE743431345450F45450F45450F45450F45450F47450F4745
            0F45460E45460E45450F45450F45460E45460E45460E45460E45460E45460E45
            450F45450F45450F45450F45460E45460E45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F44440E45450F45450F4343133E3F1DFFFF
            E741441345450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F4343133E3F1DFFFFE743431345450F45
            450F45450F45450F45450F47450F47450F45460E45460E45450F45450F45460E
            45460E45460E45460E45460E45460E45450F45450F45450F45450F45460E4546
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F44440E4343133E3F1DFFFFE743431345450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45460E
            434313FFFFE73E3F1D43431345450F44440E45450F45450F46461045450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45450F414413FFFFE73C40
            1D43431345450F44440E45450F45450F46461045441145441145450F45450F45
            450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F43460F43460F45460E4546
            0E45450F45450F45450F45450F44440E434313FFFFE73E3F1D42421245450F44
            440E45450F45450F46461045450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F434313FFFFE73E3F1D41441345460E44440E45450F454411
            46451245450F45450F45441145441145450F45450F45450F45450F47450F4745
            0F45450F45450F45450F45450F45450F45450F45450F45450F45441145441145
            450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45450F
            434313FFFFE73E3F1D43431344440E44440E45450F45450F46461045450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47
            450F47450F45450F45450F45450F45450F45450F45450F45450F45450F47450F
            47450F45450F45450F45450F45450F45450F4343133E3F1FFFFFE74343154545
            0F45450F45450F45450F45450F45460E45460E45450F44440E43460F45450F45
            450F47450F45450F45450F45450F45450F45450F45450F45450F45450F47450F
            47450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F434313403E1FFFFFE742421445450F45450F45450F45
            450F45450F45450F45450F45450F44440E45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45441145441145441145
            450F434313403E1FFFFFE742421245450F45450F45450F45450F45450F45450F
            45450F45450F44440E45450F45450F47450F47450F45450F45450F45450F4545
            0F45450F45450F45450F45450F47450F47450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F434315403E1F
            FFFFE943431545450F45450F45450F45450F45450F45450F45450F45450F4444
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45441145441144440E
            45450F45450F45450F45450F45450F45450F434313403F1DFFFFE74343134545
            0F45450F45450F45450F45450FFF45450F45450F45450F45450F434313FFFFE9
            403F1D43431545450F45450F45450F44450D44450D45450F46461045450F4545
            0F45441145441145450F45450F45450F44440E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F45450F4343133E3F1DFFFFE743431345450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45441145441145450F45450F45450F45450F45450F4545
            0F45450F4343133E3F1DFFFFE743431345460E45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45441145441147450F47450F45450F4343133E
            3F1DFFFFE743431345450F45450F45450F45450F45450F45450F45450F45460E
            45460E45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45460E4343133E3F1DFFFFE7434313
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F454411
            45441145450F45450F45450F4343133E3F1DFFFFE743431347450F45450F4545
            0F47450F47450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F43460F43460F45450F45450F47450F4745
            0F45450F434313FFFFE73E3F1D43431345450F45450F44440E45450F45450F45
            450F45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F47450F47450F45450F414413FF
            FFE73C401D43431345450F45460E44450D45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47
            450F47450F45450F45450F45450F44440E45450F434313FFFFE73E3F1D434313
            45450F45450F44440E45450F45450F45450F45450F45460E45460E45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F46461045450F45450F434313FFFFE73E3F1D43431345450F45450F4444
            0E45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F434313FFFFE73E3F1D43431345450F45450F44440E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F434313403E1FFFFFE743
            431544440E45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F47450F47450F45
            450F45450F45450F45450F47450F454313403E1FFFFFE743431545450F45450F
            45450F45460E45460E45450F45450F45450F45450F45450F45450F45450F4545
            0F47450F47450F45450F45450F43460F43460F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F47450F
            47450F45450F434313403E1FFFFFE743431345460E45450F45450F45460E4546
            0E45450F45450F45450F45450F45450F45450F45460E45460E45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4343
            15403E1FFFFFE943431544440E45450F45450F45460E45460E45450F45450F45
            450F45450F45450F45450F45450F45450F47450F47450F45450F45450F43460F
            43460F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F434313403F1DFFFFE743
            431345450F45450F45450F45450F45450FFF45450F45450F45450F45450F4343
            13FFFFE9403E1F41421843441245441145441143441243441244431045441143
            4412434313454411454411434313434412454411454411434412434412454411
            4544114343134343134544114544114344124344124544114544114344124343
            134544114544114343134344124544114343133E3F1DFFFFE743431345441143
            4313434412454411454411434412434412454411454411434412434412454411
            4544114344124344124544114544114344124344124544114544114344124344
            1245441145441143441243431345441145441143431343441245441145441143
            44124344124544114343133E3F1DFFFFE743431345450F434412434412454411
            4544114343134344124544114544114344124344124544114544114344124344
            1245441145441143441243441245441145441143431343431345441145441143
            4412434412454411454411434412434313454411454411454313454412454411
            4343133E3F1DFFFFE74343134544114344124344124544114544114344124344
            1245450F45450F43441243441245441145441143441243441245441145441143
            4412434412454411454411434412434412454411454411434412434412454411
            45441143441243441245441145441143441243441245450F4343133E3F1DFFFF
            E743431346451243441243441245441145441143431343441245441145441143
            4412434412454411454411434412434412454411454411434412434412454411
            4544114343134343134544114544114344124344124544114544114344124343
            134544114544114343134344124544114343133E3F1DFFFFE743431345441143
            4412434412454411454411434412434412454411454411434412434412454411
            4544114344124344124544114544114344124344124544114544114344124344
            1245441145441143441243441245441143451143441241441245441145441145
            4412454412454411434313FFFFE73F401E434313454411434412434412454411
            45441143441243441245450F45450F4344124344124544114544114344124344
            1245441145441143441243441245441145441143441243441245441145441143
            4412434412454411454411434412434412454411454411454412454412454411
            434313FFFFE73F401E4144134345114344124344124544114544114344124344
            1245441145441143441243441245441145441143441243441245441145441143
            4412434412454411454411434412434412454411454411434412434412454411
            454411454412454412454411454411434313434412454411434313FFFFE73E3F
            1D43431345441143441243441245441145441143441243441245450F45450F43
            4412434412454411454411434412434412454411454411434412434412454411
            4544114344124344124544114544114344124344124544114544114344124344
            12454411454411434412434412454411434313FFFFE73E3F1D43431345441143
            4412434412454411454411434412434412454411454411434412434412454411
            4544114344124344124544114544114344124344124544114544114344124344
            1245441145441143441243441245441145441143441243441245441145441143
            4412434412454411434313FFFFE93E3F1F414218434313454411454411434313
            4343134544114544114343134343134544114544114343134343134544114544
            1143431343441245450F45450F43441243431345441145441143431343431345
            4411454411434313434313454411454411434313434313454411434313403E1F
            FFFFE74242144544114343134343134544114544114343134343134544114544
            1143431343441245450F45450F43441243431345441145441143431343431345
            4411454411434313434313454411454411434313434313454411454411454313
            454313454411454411434313434313454411444212403F1DFFFFE74343134544
            1143431343441245450F45450F43441243431345441145441143431343431345
            4411454411454313454313454411454411434313434313454411454411434313
            43431345441145441143431343431345441145441143431343441245450F4545
            0F454412454313454411424212403E1FFFFFE743431345450F43441243441245
            450F45450F43441243431345441145441143441243441245450F45450F434412
            4343134544114544114343134343134544114544114343134343134544114544
            1143431343431345441145441143431343431345441145441143431343431345
            4411434313403E1FFFFFE743431545441143431343441245450F45450F434412
            4343134544114544114343134343134544114544114543134543134544114544
            1143431343431345441145441143431343431345441145441143431343431345
            4411454411434412434412454411454411434313434313454411434313403F1D
            FFFFE743431345450F45450F45450F45450F45450FFF45450F45450F45450F45
            450F434313FFFFE93E3D213E3F1DFFFFE3434412434412404119FFFFE3434412
            434412404119FFFFE3434313434313404119FFFFE3434412434412404119FFFF
            E343441243431340411AFFFFE4434313434412404119FFFFE343441243441240
            4119FFFFE3434313434313404119FFFFE34344124343133E3F1DFFFFE7434315
            43431340411AFFFFE3434412434412404119FFFFE3434412434412404119FFFF
            E3434412434412404119FFFFE3434412434412404119FFFFE343441243441240
            4119FFFFE3434412434412404119FFFFE3434313434313404119FFFFE3434412
            434412404119FFFFE34344124343133E3F1DFFFFE7434313434412404119FFFF
            E343431343431340411AFFFFE3434412434412404119FFFFE343441243441240
            4119FFFFE3434412434412404119FFFFE343441243431340411AFFFFE4434313
            434412404119FFFFE3434412434412404119FFFFE3434313434313404119FFFF
            E34344124343133E3F1DFFFFE7434313434412404119FFFFE343441243441240
            4119FFFFE3434412434412404119FFFFE3434412434412404119FFFFE3434412
            434412404119FFFFE3434412434412404119FFFFE3434412434412404119FFFF
            E3434412434412404119FFFFE3434412434412404119FFFFE343441243431340
            401CFFFFE6434313434412404119FFFFE343431343431340411AFFFFE3434412
            434412404119FFFFE3434412434412404119FFFFE3434412434412404119FFFF
            E343441243431340411AFFFFE4434313434412404119FFFFE343441243441240
            4119FFFFE3434313434313404119FFFFE34344124343133E3F1DFFFFE7434313
            434412FFFFE3404119434412434412FFFFE3404119434412434412FFFFE34041
            19434412434412FFFFE3404119434412434412FFFFE3404119434412434412FF
            FFE3404119434412434412FFFFE3404119434412434412FFFFE3404119434412
            434412FFFFE3404119434412434313FFFFE73E3F1D434313434412FFFFE34041
            19434412434412FFFFE3414119434412434412FFFFE3404119434412434412FF
            FFE3404119434412434412FFFFE3404119434412434412FFFFE3404119434412
            434412FFFFE3404119434412434412FFFFE3404119434412434412FFFFE34041
            19434412434313FFFFE73E3F1D414413414412FFFFE3404119434412434412FF
            FFE3404119434412434412FFFFE3404119434412434412FFFFE3404119434412
            434412FFFFE3404119434412434412FFFFE3404119434412434412FFFFE34041
            19434412434412FFFFE3404119434313434313FFFFE4404119434412414413FF
            FFE73E3F1D434313434412FFFFE3404119434412434412FFFFE3414119434412
            434412FFFFE3404119434412434412FFFFE3404119434412434412FFFFE34041
            19434412434412FFFFE3404119434412434412FFFFE3404119434412434412FF
            FFE3404119434412434412FFFFE3404119434412434313FFFFE73E3F1D434313
            434412FFFFE3404119434412434412FFFFE3404119434412434412FFFFE34041
            19434412434412FFFFE3404119434412434412FFFFE3404119434412434412FF
            FFE3404119434412434412FFFFE3404119434412434412FFFFE3404119434412
            434412FFFFE3404119434412434313FFFFE93C3E21403E1FFFFFE44343134343
            1340411AFFFFE443431343431341401AFFFFE443431343431341401AFFFFE443
            431343431341401AFFFFE443441243441241401AFFFFE443431343431341401A
            FFFFE443441243441241401AFFFFE443431343431341401AFFFFE44343134144
            133E3F1FFFFFE743431543431341401AFFFFE443431343431341401AFFFFE443
            431343431341401AFFFFE443441243441241401AFFFFE443431343431341401A
            FFFFE443441243441241401AFFFFE443431343431341401AFFFFE44343134343
            1341401AFFFFE443431343431341401AFFFFE4434412434313403F1DFFFFE745
            431345431341401AFFFFE445441245441241401AFFFFE443431343431341401A
            FFFFE443431343431341401AFFFFE443431343431341401AFFFFE44344124344
            1241401AFFFFE443431343431341401AFFFFE443431343431341401AFFFFE443
            441243441241401AFFFFE4434313434313403E1FFFFFE743431343441241401A
            FFFFE443441243441241401AFFFFE4434313434412414119FFFFE34344124344
            1241401AFFFFE443431343431341401AFFFFE443441243441241401AFFFFE443
            431343431341401AFFFFE443431343431341401AFFFFE443431343431341401A
            FFFFE4434313434313403E1FFFFFE743431543431341401AFFFFE44544124544
            1241401AFFFFE443431343431341401AFFFFE443431343431341401AFFFFE443
            431343431341401AFFFFE443431343431341401AFFFFE443431343431341401A
            FFFFE4434313434412414119FFFFE343441243431341401AFFFFE44343134343
            15403E1FFFFFE943431545450F45450F45450F45450F45450FFF45450F45450F
            45450F45450F434313FFFFE93E3D233C3E21FFFFE64343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            401CFFFFE64343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343154343153E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343154343153E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E401CFFFFE64343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            43431340401CFFFFE64343134343133E3F1DFFFFE74343154343153E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            401CFFFFE64343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E7434313434313FFFFE63E401C434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE63E401C434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE7403F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D414413414413FFFFE63E401C434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434315434315FFFFE73E3F1D414413
            414413FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE7403F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73C3D233E3D23FFFFE743
            4313434313403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434313434313403F1DFFFFE74343154343
            13403E1FFFFFE7434313434313403F1DFFFFE7434315434313403E1FFFFFE741
            43154144133E3F1FFFFFE7434315434313403E1FFFFFE7434315434313403F1D
            FFFFE7434313434313403E1FFFFFE7434313434313403F1DFFFFE74343154343
            13403E1FFFFFE7434313434313403F1DFFFFE7434315434313403E1FFFFFE743
            4315434313403E1FFFFFE9414315414315403E1FFFFFE7434313434313403F1D
            FFFFE7454313454313403E1FFFFFE7454215454313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434315403E1FFFFFE943
            4313434313403F1DFFFFE9434315434315403E1FFFFFE7434315434313403E1F
            FFFFE7434313434313403F1DFFFFE9434315434315403E1FFFFFE94343154343
            15403F1DFFFFE7434313434313403E1FFFFFE9434315434313403F1DFFFFE743
            4313434313403F1DFFFFE7434315434313403E1FFFFFE7434313434313403F1D
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE94343154343
            15403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE745
            4215454313403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434315403E1FFFFFE9434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403F1DFFFFE7434313434313403E1FFFFFE743
            4315424214403E1FFFFFE943431545450F45450F45450F45450F45450FFF4545
            0F45450F45450F45450F434313FFFFE93E3D233C3E21FFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E401CFFFFE64343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E401CFFFFE6434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E401CFFFFE64343134343133E3F1DFFFFE74343134343133E
            401CFFFFE6434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434315
            434315FFFFE73E3F1D434313434313FFFFE73E3F1D414413414413FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D414413414413FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D414413414413FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE63E401C434313434313FFFFE73E3F1D434313434313FFFFE73C3E213E3D21
            FFFFE7434313434313403E1FFFFFE7454215454313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7454313454313403F1DFFFFE743
            4315434313403E1FFFFFE7434313434313403F1DFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403F1DFFFFE7454313454313403E1FFFFFE7454313454313403F1DFFFFE743
            4315434313403E1FFFFFE7434313434313403F1DFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE9434315434315403E1FFFFFE74343134343
            13403F1DFFFFE7434313434313403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403E1FFFFFE7434315434313403E1FFFFFE7434315434315403E1F
            FFFFE9434313434313403F1DFFFFE9434315434315403E1FFFFFE74343154343
            13403E1FFFFFE7434313434313403F1DFFFFE9434315434315403E1FFFFFE943
            4315434315403F1DFFFFE7434313434313403E1FFFFFE9434315434315403E1F
            FFFFE7454313454313403F1DFFFFE7434315434313403E1FFFFFE74343134343
            13403F1DFFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE943
            4315434315403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434315403E1FFFFFE9434315434313403E1FFFFFE743
            4315434313403E1FFFFFE7434315434313403F1DFFFFE7434313434313403E1F
            FFFFE7434315434315403E1FFFFFE943431545441146461045450F47460E4546
            0EFF45450F45450F45450F45450F424212FFFFE93E3D233C3E21FFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E401CFFFFE64343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E401CFFFF
            E64343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E401CFFFFE64343134343133E3F1DFFFFE7434313
            4343133E401CFFFFE6434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434315434315FFFFE73E3F1D434313434313FFFFE73E3F1D414413414413FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D414413414413FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D414413
            414413FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE63E401C434313434313FFFFE73E3F1D434313434313FFFFE73C3E
            213F3E22FFFFE7434313434313413E1FFFFFE7454215454313403E1FFFFFE743
            4315434313403E1FFFFFE7434315434313403E1FFFFFE7454215454313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403F1DFFFFE74343134343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434313403F1DFFFFE743
            4313434313403F1DFFFFE7434313434313403E1FFFFFE7454215454313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403F1DFFFFE74343134343
            13403E1FFFFFE7434315434313403E1FFFFFE9434315434315403E1FFFFFE743
            4313434313403F1DFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403E1FFFFFE7434313434313403F1DFFFFE9434315434315403E1F
            FFFFE9434315434315403F1DFFFFE7434313434313403E1FFFFFE94343154343
            15403E1FFFFFE7454215454313403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403F1DFFFFE7434313434313403E1FFFFFE7434315434313403E1F
            FFFFE9434315434315403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403F1DFFFFE7434313434313403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434313434313403F1DFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE943431545441145450F45450F47
            460E47460EFF45441145450F45450F45450F434313FFFFE93E3D233C3E21FFFF
            E64343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434315
            4343153E401CFFFFE64343134343133E401CFFFFE64343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E
            3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFFE7434313
            4343133E3F1DFFFFE74343134343133E3F1DFFFFE74343134343133E3F1DFFFF
            E74343134343133E3F1DFFFFE7434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            414413FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE63E401C434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE7403F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313414413FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313
            434313FFFFE73E3F1D434313434313FFFFE73E3F1D434313434313FFFFE73E3F
            1D434313434313FFFFE63E3F1D434313434313FFFFE73E3F1D434313434313FF
            FFE73C3E213E3D23FFFFE7434313434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434313403F1DFFFFE743
            4313434313403E1FFFFFE7454215454313403E1FFFFFE7434315434313413F1D
            FFFFE7434313434313403F1DFFFFE7434313434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434313403F1DFFFFE743
            4313434313403E1FFFFFE7434315434313403E1FFFFFE7434313434313403F1D
            FFFFE7434313434313403F1DFFFFE7434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313413E1FFFFFE7434313434313403F1DFFFFE94343154343
            15403E1FFFFFE9434315434315403F1DFFFFE7434313434313413E1FFFFFE943
            4315434315403E1FFFFFE7434315434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403F1DFFFFE7434313434313403E1FFFFFE74343154343
            13403E1FFFFFE9434315434315403E1FFFFFE7434315434313403E1FFFFFE743
            4315434313403F1DFFFFE7434313434313403E1FFFFFE7434315434313403E1F
            FFFFE7434315434313403E1FFFFFE7434315434313403E1FFFFFE74343154343
            13403E1FFFFFE7434315434313403E1FFFFFE7434313434313403F1DFFFFE741
            43154144133E3F1FFFFFE7434315454313403E1FFFFFE943431545450F45450F
            45450F45450F45450FFF45450F45450F45450F45450F434313FFFFE93E3D233C
            3E21FFFFE74142184142183E3F1FFFFFE94142184142183C401DFFFFE7414218
            4142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFF
            E94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE9414218
            4142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFF
            E94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE9414218
            4142183C3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFF
            E94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE9414218
            4142183E3F1FFFFFE94142184142183E3F1FFFFFE74142164142163E3F1DFFFF
            E94142184142183E3F1DFFFFE74142184142183E3F1DFFFFE74142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE9414218
            4142183E3F1FFFFFE94142184142183E3F1FFFFFE94341184341183E3F1FFFFF
            E94142184142183E3F1FFFFFE94341184341183E3F1FFFFFE94142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE9414218
            4142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E3F1FFFFF
            E94142184142183E3F1FFFFFE94142184142183E3F1FFFFFE94142184142183E
            3F1FFFFFE94142184142183E3F1FFFFFE9414218414218FFFFE93E3F1F414218
            414218FFFFE73E3F1D414218414218FFFFE93E3F1F414218414218FFFFE93E3F
            1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218
            414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F
            1F414218414218FFFFE93C3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218
            414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE73E3F
            1D414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218
            414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE9403E
            1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93C3F1F414218
            414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F
            1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218
            414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F
            1F414218414218FFFFE93E3F1F414218414218FFFFE93E3F1F414218414218FF
            FFE93E3F1D414216414216FFFFE73E3F1F414218414218FFFFE93E3F1F414218
            414218FFFFE93C3E213E3D23FFFFE9414218414218403E1FFFFFE94142184142
            18403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE941
            4218414218403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1F
            FFFFE9414218414218403E1FFFFFE9434118434118403E1FFFFFE94142184142
            18403E1FFFFFE9414216414216403E1FFFFFE9414218404218403E1FFFFFE941
            4218414218403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1F
            FFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE94142164142
            16403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE941
            4218414218403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1F
            FFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE94142184142
            18403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE941
            42184142183E3E20FFFFEA414218414218403E1FFFFFE9414218414218403E1F
            FFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE94142184142
            18403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE941
            4218414218403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1F
            FFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE94142184142
            18403E1FFFFFE9414218414218403E1FFFFFE9414218414218403E1FFFFFE941
            4218414218403E1FFFFFE9414218414218403E1FFFFFE9414216414216403E1F
            FFFFE94142184042183E3F1FFFFFE9414218434118403E1FFFFFE74343154545
            0F45450F45450F45450F45450FFF45450F45450F45460E43460F414413FFFFE9
            FFFFEDFFFFEBFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEBFFFF
            EBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEBFFFFEAFFFFEAFFFFEBFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEBFFFFEAFFFFEAFFFFEBFFFF
            EAFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEBFFFFEAFFFFEAFFFFEBFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFF
            EAFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FF
            FFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEAFFFFE9
            FFFFE9FFFFEAFFFFEAFFFFE9FFFFE9FFFFEAFFFFEBFFFFEAFFFFEAFFFFEBFFFF
            EAFFFFE9FFFFE9FFFFEAFFFFEBFFFFEDFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE7FFFFE7FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE7FFFFE7FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFF
            FFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEB
            FFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFF
            E9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFEBFFFFE9FFFFE9FFFFEBFFFFE743
            431545450F43460F43460F45450F45450FFF45450F45460E45460E43460F4144
            133F40193E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            401C3E401C403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D
            3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403E1F403E1F3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E401C3E401C403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403E1F403E1F3E
            3F1D3E3F1D403F1D403F1D3E3F1F3E3F1D403E1F403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D403F1D403F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403E1F403E1F3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1F3E3F1D403E1F403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D403F1D403F1D403F1D403F1D3E3F1D403F1D403E1F403E1F40
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3F3E1C403F1D3E3F1D3E3F1D403F1D
            403F1D3E401C3E401C403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D3E3F1D
            3E3F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D403F1D403F1D403F1D403E1F3E3F1D403E1F403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E401C3E40
            1C403F1D403F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E
            3F1F3E3F1D403E1F403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F
            1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1F3E3F1D403E1F403F1D3E
            3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D403F1D3E3F1D3E3F1D403F1D
            403F1943431345450F43460F43460F45450F45450FFF45450F45450F45450F45
            450F434511434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434315434315434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434315
            4343154343134343134343134343134343154343134343154343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431543431543431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343154343134343154343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434315
            4343154343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431543431343431543431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434313434313434313
            4343134343154343134343154343134343134343134343134343134343134343
            1343431343431343431343431343431343431343431343431343431343431343
            4313434313434313434313434313434313434313434313434315434313434315
            4343134343134343134343134343134343134343134343134343134343134343
            1343431343431345441145450F45450F45450F45450F45450FFF45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450FFF4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0FFF45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450FFF45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450FFF45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450FFF45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450FFF45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450FFF45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450FFF45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450FFF4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0FFF45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450FFF45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450FFF45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450FFF45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F
            45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F4545
            0F45450F45450F45450F45450F45450F45450F45450F45450F45450F45450F45
            450F45450F45450F45450F45450F45450FFF}
          ShowHint = False
        end
        object Label1: TLabel
          Left = 464
          Top = 129
          Width = 70
          Height = 18
          Caption = 'Available'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object progBarPLP: TAdvSmoothProgressBar
          Left = 40
          Top = 55
          Width = 649
          Height = 33
          Step = 10.000000000000000000
          Maximum = 100.000000000000000000
          GlowAnimation = False
          Appearance.BackGroundFill.ColorTo = clSilver
          Appearance.BackGroundFill.ColorMirror = clNone
          Appearance.BackGroundFill.ColorMirrorTo = clNone
          Appearance.BackGroundFill.GradientType = gtVertical
          Appearance.BackGroundFill.GradientMirrorType = gtSolid
          Appearance.BackGroundFill.BorderColor = clSilver
          Appearance.BackGroundFill.Rounding = 0
          Appearance.BackGroundFill.ShadowOffset = 0
          Appearance.BackGroundFill.Glow = gmNone
          Appearance.ProgressFill.Color = 16737843
          Appearance.ProgressFill.ColorTo = 16737843
          Appearance.ProgressFill.ColorMirror = 16737843
          Appearance.ProgressFill.ColorMirrorTo = 16737843
          Appearance.ProgressFill.GradientType = gtVertical
          Appearance.ProgressFill.GradientMirrorType = gtVertical
          Appearance.ProgressFill.BorderColor = 16765357
          Appearance.ProgressFill.Rounding = 0
          Appearance.ProgressFill.ShadowOffset = 0
          Appearance.ProgressFill.Glow = gmNone
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWindowText
          Appearance.Font.Height = -16
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Appearance.ProgressFont.Charset = DEFAULT_CHARSET
          Appearance.ProgressFont.Color = clWindowText
          Appearance.ProgressFont.Height = -16
          Appearance.ProgressFont.Name = 'Tahoma'
          Appearance.ProgressFont.Style = [fsBold]
          Appearance.ValueFormat = '%.0f s'
          Appearance.ValueVisible = True
          Version = '1.9.1.0'
          MarqueeInterval = 30
          Visible = False
          TMSStyle = 0
        end
        object progBarPrePLP: TAdvSmoothProgressBar
          Left = 40
          Top = 55
          Width = 649
          Height = 33
          Step = 10.000000000000000000
          Maximum = 100.000000000000000000
          GlowAnimation = False
          Appearance.BackGroundFill.ColorTo = clSilver
          Appearance.BackGroundFill.ColorMirror = clNone
          Appearance.BackGroundFill.ColorMirrorTo = clNone
          Appearance.BackGroundFill.GradientType = gtVertical
          Appearance.BackGroundFill.GradientMirrorType = gtSolid
          Appearance.BackGroundFill.BorderColor = clSilver
          Appearance.BackGroundFill.Rounding = 0
          Appearance.BackGroundFill.ShadowOffset = 0
          Appearance.BackGroundFill.Glow = gmNone
          Appearance.ProgressFill.Color = 16737843
          Appearance.ProgressFill.ColorTo = 16737843
          Appearance.ProgressFill.ColorMirror = 16737843
          Appearance.ProgressFill.ColorMirrorTo = 16737843
          Appearance.ProgressFill.GradientType = gtVertical
          Appearance.ProgressFill.GradientMirrorType = gtVertical
          Appearance.ProgressFill.BorderColor = 16765357
          Appearance.ProgressFill.Rounding = 0
          Appearance.ProgressFill.ShadowOffset = 0
          Appearance.ProgressFill.Glow = gmNone
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWindowText
          Appearance.Font.Height = -16
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Appearance.ProgressFont.Charset = DEFAULT_CHARSET
          Appearance.ProgressFont.Color = clWindowText
          Appearance.ProgressFont.Height = -16
          Appearance.ProgressFont.Name = 'Tahoma'
          Appearance.ProgressFont.Style = [fsBold]
          Appearance.ValueFormat = '%.0f s'
          Appearance.ValueVisible = True
          Version = '1.9.1.0'
          TMSStyle = 0
        end
        object pnlMainPLP: TPanel
          Left = 40
          Top = 94
          Width = 321
          Height = 298
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clTeal
          ParentBackground = False
          TabOrder = 0
          object grpLeftDown: TGroupBox
            Left = 27
            Top = 111
            Width = 102
            Height = 96
            TabOrder = 0
            object pnlPLP4: TPanel
              Left = 9
              Top = 32
              Width = 56
              Height = 55
              BevelOuter = bvLowered
              Caption = '4'
              Color = clLime
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
          object grbLeftTop: TGroupBox
            Left = 27
            Top = 9
            Width = 102
            Height = 96
            TabOrder = 1
            object pnlPLP2: TPanel
              Left = 9
              Top = 32
              Width = 56
              Height = 55
              BevelOuter = bvLowered
              Caption = '2'
              Color = clLime
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
          object grpRightTop: TGroupBox
            Left = 187
            Top = 9
            Width = 102
            Height = 96
            TabOrder = 2
            object pnlPLP1: TPanel
              Left = 9
              Top = 32
              Width = 56
              Height = 55
              BevelOuter = bvLowered
              Caption = '1'
              Color = clLime
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
          object grpRightDown: TGroupBox
            Left = 187
            Top = 111
            Width = 102
            Height = 96
            TabOrder = 3
            object pnlPLP3: TPanel
              Left = 9
              Top = 32
              Width = 56
              Height = 55
              BevelOuter = bvLowered
              Caption = '3'
              Color = clLime
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
            end
          end
          object pnlAwrCwrEr: TPanel
            Left = 14
            Top = 217
            Width = 297
            Height = 68
            Color = clGray
            ParentBackground = False
            TabOrder = 4
            object btnAWR: TSpeedButton
              Left = 10
              Top = 14
              Width = 89
              Height = 43
              Caption = 'AWR - F1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = btnAWRClick
            end
            object btnCWR: TSpeedButton
              Left = 105
              Top = 14
              Width = 89
              Height = 43
              Caption = 'CWR - F2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = btnCWRClick
            end
            object btnER: TSpeedButton
              Left = 200
              Top = 14
              Width = 89
              Height = 43
              Caption = 'ER - F10'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = btnERClick
            end
          end
        end
        object Panel10: TPanel
          Left = 40
          Top = 400
          Width = 649
          Height = 201
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Panel42: TPanel
            Left = 10
            Top = 6
            Width = 89
            Height = 49
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'N   ASM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object Panel43: TPanel
            Left = 100
            Top = 6
            Width = 179
            Height = 49
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'T'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
          object Panel44: TPanel
            Left = 280
            Top = 6
            Width = 179
            Height = 49
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'Tmax'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          object Panel45: TPanel
            Left = 460
            Top = 6
            Width = 179
            Height = 49
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'tmax, (s)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
          end
          object pnlNoASM1: TPanel
            Left = 10
            Top = 56
            Width = 89
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
          end
          object pnlT1: TPanel
            AlignWithMargins = True
            Left = 100
            Top = 56
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 5
          end
          object pnlTmax1: TPanel
            Left = 280
            Top = 56
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 6
          end
          object pnltmaxs1: TPanel
            Left = 460
            Top = 56
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 7
          end
          object pnlNoASM2: TPanel
            Left = 10
            Top = 90
            Width = 89
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 8
          end
          object pnlT2: TPanel
            Left = 100
            Top = 90
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 9
          end
          object pnlTmax2: TPanel
            Left = 280
            Top = 90
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 10
          end
          object pnltmaxs2: TPanel
            Left = 460
            Top = 90
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 11
          end
          object pnlNoASM3: TPanel
            Left = 10
            Top = 124
            Width = 89
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 12
          end
          object pnlT3: TPanel
            Left = 100
            Top = 124
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 13
          end
          object pnlTmax3: TPanel
            Left = 280
            Top = 124
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 14
          end
          object pnltmaxs3: TPanel
            Left = 460
            Top = 124
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 15
          end
          object pnlNoASM4: TPanel
            Left = 10
            Top = 158
            Width = 89
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 16
          end
          object pnlT4: TPanel
            Left = 100
            Top = 158
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 17
          end
          object pnlTmax4: TPanel
            Left = 280
            Top = 158
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 18
          end
          object pnltmaxs4: TPanel
            Left = 460
            Top = 158
            Width = 179
            Height = 33
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clMedGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clYellow
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 19
          end
        end
        object pnlAvailable: TPanel
          Left = 600
          Top = 129
          Width = 29
          Height = 25
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
        end
        object pnlOperational: TPanel
          Left = 600
          Top = 164
          Width = 29
          Height = 25
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
        end
        object pnlLaunched: TPanel
          Left = 600
          Top = 269
          Width = 29
          Height = 25
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
        end
        object pnlPassed: TPanel
          Left = 600
          Top = 305
          Width = 29
          Height = 25
          Color = clPurple
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
        end
        object pnlDesignated: TPanel
          Left = 600
          Top = 199
          Width = 29
          Height = 25
          Color = clAqua
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
        end
        object pnlCancelled: TPanel
          Left = 600
          Top = 234
          Width = 29
          Height = 25
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
        end
        object Panel1: TPanel
          Left = 198
          Top = 133
          Width = 1
          Height = 140
          TabOrder = 8
        end
        object btnFireNow: TButton
          Left = 592
          Top = 24
          Width = 97
          Height = 25
          Caption = 'Tembak Langsung'
          TabOrder = 11
          Visible = False
          OnClick = btnFireNowClick
        end
      end
      object Panel2: TPanel
        Left = 169
        Top = 59
        Width = 2
        Height = 33
        TabOrder = 1
        object pnl1: TPanel
          Left = 0
          Top = 0
          Width = 2
          Height = 33
          TabOrder = 0
        end
      end
    end
    object pnlRightBottom: TPanel
      Left = 839
      Top = 951
      Width = 746
      Height = 129
      Color = clGray
      ParentBackground = False
      TabOrder = 5
      object GroupBox1: TGroupBox
        Left = 25
        Top = 8
        Width = 729
        Height = 114
        TabOrder = 0
        object btnRTP: TSpeedButton
          Left = 63
          Top = 16
          Width = 73
          Height = 41
          Caption = 'RTP - F4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnRTPClick
        end
        object btnPTP: TSpeedButton
          Left = 242
          Top = 16
          Width = 73
          Height = 41
          Caption = 'PTP - F5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnPTPClick
        end
        object btnLock: TSpeedButton
          Left = 418
          Top = 16
          Width = 73
          Height = 41
          Caption = 'LOCK - F6'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnLockClick
        end
        object btnDate: TSpeedButton
          Left = 593
          Top = 17
          Width = 73
          Height = 41
          Caption = 'DATE - F11'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnDateClick
        end
        object btnInd: TSpeedButton
          Left = 152
          Top = 70
          Width = 73
          Height = 41
          Caption = 'IND - F3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnIndClick
        end
        object btnTD: TSpeedButton
          Left = 331
          Top = 70
          Width = 73
          Height = 41
          Caption = 'TD - F7'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnTDClick
        end
        object btnCT: TSpeedButton
          Left = 503
          Top = 70
          Width = 73
          Height = 41
          Caption = 'CT - F9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnCTClick
        end
        object Panel7: TPanel
          Left = 63
          Top = 64
          Width = 603
          Height = 4
          Color = clCream
          ParentBackground = False
          TabOrder = 0
        end
      end
    end
  end
  object timerStart: TTimer
    Enabled = False
    OnTimer = timerStartTimer
    Left = 752
    Top = 248
  end
end
