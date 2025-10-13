object frmManualInput: TfrmManualInput
  Left = 0
  Top = 0
  Align = alCustom
  BorderStyle = bsNone
  Caption = 'Manual Input'
  ClientHeight = 550
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlmanualInput: TPanel
    Left = -18
    Top = 0
    Width = 577
    Height = 550
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 17
      Width = 118
      Height = 18
      Caption = 'MANUAL INPUT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMRSEOfTargetHeading: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 19
      object Label46: TLabel
        Left = 190
        Top = 10
        Width = 153
        Height = 16
        Caption = 'MRSE of target heading'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label47: TLabel
        Left = 360
        Top = 30
        Width = 24
        Height = 16
        Caption = 'deg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label48: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMRSEOfTargetHeading: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMRSEOfTargetHeading: TEdit
        Left = 185
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00.0'
        OnKeyPress = edtMRSEOfTargetHeadingKeyPress
      end
    end
    object pnlMemberOfTIVariant: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      object Label3: TLabel
        Left = 195
        Top = 10
        Width = 136
        Height = 16
        Caption = 'Member of TI variant'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMemberOfTIVariant: TEdit
        Left = 185
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        OnKeyPress = edtMemberOfTIVariantKeyPress
      end
    end
    object pnlNumberOfTIVariant: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 17
      object Label44: TLabel
        Left = 195
        Top = 10
        Width = 135
        Height = 16
        Caption = 'Number Of TI Variant'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErorTIVar: TLabel
        Left = 110
        Top = 57
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtNumberOfTIVariant: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0'
        OnKeyPress = edtNumberOfTIVariantKeyPress
      end
    end
    object pnlMovingCompOfTargetInputAttribute: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 18
      object Label45: TLabel
        Left = 130
        Top = 10
        Width = 292
        Height = 16
        Caption = 'Moving components of target input attribute'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMovCompTIAttribute: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMovingCompOfTargetInputAttribute: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '1'
        OnKeyPress = edtMovingCompOfTargetInputAttributeKeyPress
      end
    end
    object pnlInitTargetBearing: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 4
      object Label7: TLabel
        Left = 185
        Top = 10
        Width = 153
        Height = 16
        Caption = 'Initial Target of Bearing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 374
        Top = 30
        Width = 24
        Height = 16
        Caption = 'deg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 448
        Top = 10
        Width = 13
        Height = 16
        Caption = 'NI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorTargetBearing: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTargetOfBearing: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '000.00'
        OnKeyPress = edtTargetOfBearingKeyPress
      end
    end
    object pnlCoreRadius: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 12
      object Label29: TLabel
        Left = 220
        Top = 10
        Width = 77
        Height = 16
        Caption = 'Core Radius'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 360
        Top = 30
        Width = 11
        Height = 16
        Caption = 'm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorCoreRadius: TLabel
        Left = 160
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCoreRadius: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00'
        OnKeyPress = edtCoreRadiusKeyPress
      end
    end
    object pnlManualComponentOfTargetInputAttribute: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 3
      object Label4: TLabel
        Left = 125
        Top = 10
        Width = 285
        Height = 16
        Caption = 'Manual component of target input attribute'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtManualCompOfTargetAttribute: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
      end
    end
    object pnlMRSEOfTargetSpeed: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 9
      object Label22: TLabel
        Left = 195
        Top = 10
        Width = 141
        Height = 16
        Caption = 'MRSE of target speed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 360
        Top = 30
        Width = 26
        Height = 16
        Caption = 'm/s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMrseOfTargetSpeed: TLabel
        Left = 144
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMRSEOfTargetSpeed: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0000'
        OnKeyPress = edtMRSEOfTargetSpeedKeyPress
      end
    end
    object pnlMRSEOfTargetPos: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 16
      object Label41: TLabel
        Left = 190
        Top = 10
        Width = 155
        Height = 16
        Caption = 'MRSE Of Target Position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label42: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 361
        Top = 32
        Width = 11
        Height = 16
        Caption = 'm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMRSEOfTargetPos: TLabel
        Left = 130
        Top = 60
        Width = 3
        Height = 13
      end
      object edtMRSEOfTargetPos: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00'
        OnKeyPress = edtMRSEOfTargetPosKeyPress
      end
    end
    object pnlTargetHeading: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 5
      object Label10: TLabel
        Left = 215
        Top = 10
        Width = 99
        Height = 16
        Caption = 'Target Heading'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 385
        Top = 30
        Width = 24
        Height = 16
        Caption = 'deg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorTargetHeading: TLabel
        Left = 110
        Top = 57
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTargetHeading: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00.0'
        OnKeyPress = edtTargetHeadingKeyPress
      end
    end
    object pnlMRSEOfTargetBearing: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 8
      object Label19: TLabel
        Left = 190
        Top = 10
        Width = 151
        Height = 16
        Caption = 'MRSE of target bearing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 360
        Top = 30
        Width = 24
        Height = 16
        Caption = 'deg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMrseOfTargetBearing: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMRSEOfTargetBearing: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00.00'
        OnKeyPress = edtMRSEOfTargetBearingKeyPress
      end
    end
    object pnlTargetDataAgeingTime: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 10
      object Label25: TLabel
        Left = 185
        Top = 10
        Width = 156
        Height = 16
        Caption = 'Target data ageing time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label26: TLabel
        Left = 360
        Top = 30
        Width = 7
        Height = 16
        Caption = 's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label27: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorTargetDataAgeingTime: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTargetDataAgingTime: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0000'
        OnKeyPress = edtTargetDataAgingTimeKeyPress
      end
    end
    object pnlTargetType: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 11
      object Label28: TLabel
        Left = 225
        Top = 10
        Width = 78
        Height = 16
        Caption = 'Target Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorTargetType: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTargetType: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0'
        OnKeyPress = edtTargetTypeKeyPress
      end
    end
    object pnlQuantityofShipsInCore: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 20
      object Label49: TLabel
        Left = 185
        Top = 10
        Width = 151
        Height = 16
        Caption = 'Number of ships in core'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label50: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorQuantOfShipsInCore: TLabel
        Left = 155
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQuantOfShipsInCore: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00'
        OnKeyPress = edtQuantOfShipsInCoreKeyPress
      end
    end
    object pnlTargetSpeed: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 6
      object Label13: TLabel
        Left = 225
        Top = 10
        Width = 87
        Height = 16
        Caption = 'Target Speed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 385
        Top = 30
        Width = 26
        Height = 16
        Caption = 'm/s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorTargetSpeed: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTargetSpeed: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00.0'
        OnKeyPress = edtTargetSpeedKeyPress
      end
    end
    object pnlExit: TPanel
      Left = 24
      Top = 224
      Width = 547
      Height = 316
      BevelOuter = bvNone
      Color = clSilver
      ParentBackground = False
      TabOrder = 2
      object btnExit: TSpeedButton
        Left = 199
        Top = 276
        Width = 169
        Height = 25
        Caption = 'EXIT - F8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnExitClick
      end
      object StrGridShowResult: TStringGrid
        Left = 26
        Top = 10
        Width = 497
        Height = 252
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ColCount = 3
        FixedColor = clWhite
        FixedCols = 0
        RowCount = 32
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        GradientEndColor = clWhite
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 0
        Touch.ParentTabletOptions = False
        Touch.TabletOptions = [toPressAndHold]
        Visible = False
        OnSelectCell = StrGridShowResultSelectCell
      end
    end
    object pnlMRSEOfTargetRange: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 7
      object Label16: TLabel
        Left = 195
        Top = 10
        Width = 140
        Height = 16
        Caption = 'MRSE of target range'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 385
        Top = 30
        Width = 18
        Height = 16
        Caption = 'km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorMrseOfTargetRange: TLabel
        Left = 110
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMRSEOfTargetRange: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00.000'
        OnKeyPress = edtMRSEOfTargetRangeKeyPress
      end
    end
    object pnlQuantityOfShipsinFormations: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 13
      object Label34: TLabel
        Left = 165
        Top = 10
        Width = 192
        Height = 16
        Caption = 'Quantity of ships in formation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label37: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorQuantityOfShipsInFormations: TLabel
        Left = 155
        Top = 60
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQuantityOfShipsInFormations: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '00'
        OnKeyPress = edtQuantityOfShipsInFormationsKeyPress
      end
    end
    object pnlInitRangeToTarget: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 195
        Top = 8
        Width = 142
        Height = 16
        Caption = 'Initial range to target'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 360
        Top = 32
        Width = 19
        Height = 16
        Caption = 'Km'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorRangeTarget: TLabel
        Left = 110
        Top = 57
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtRangeToTarget: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '000.000'
        OnKeyPress = edtRangeToTargetKeyPress
      end
    end
    object pnlPosLongTarget: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 14
      object Label36: TLabel
        Left = 182
        Top = 10
        Width = 166
        Height = 16
        Caption = 'Target Longitude Position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label35: TLabel
        Left = 180
        Top = 57
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorLong: TLabel
        Left = 182
        Top = 80
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtLongTarget: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        OnKeyPress = edtLongTargetKeyPress
      end
    end
    object pnlPosLatTarget: TPanel
      Left = 24
      Top = 50
      Width = 547
      Height = 175
      Color = clSilver
      ParentBackground = False
      TabOrder = 15
      object Label39: TLabel
        Left = 186
        Top = 10
        Width = 156
        Height = 16
        Caption = 'Target Latitude Position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label40: TLabel
        Left = 480
        Top = 10
        Width = 16
        Height = 16
        Caption = 'N1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblErrorLat: TLabel
        Left = 182
        Top = 80
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 180
        Top = 57
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtLatTarget: TEdit
        Left = 180
        Top = 30
        Width = 169
        Height = 21
        TabOrder = 0
        OnKeyPress = edtLatTargetKeyPress
      end
    end
  end
end
