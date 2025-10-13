inherited frmTDCTengah_Rencong: TfrmTDCTengah_Rencong
  Left = 1422
  Top = 4
  AutoSize = True
  Caption = 'TDC Rencong'
  ClientHeight = 1065
  ClientWidth = 1616
  Color = clMoneyGreen
  ExplicitTop = -93
  ExplicitWidth = 1624
  ExplicitHeight = 1092
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1161
    Height = 993
    ExplicitLeft = 0
    ExplicitWidth = 1161
    ExplicitHeight = 993
    inherited Image1: TImage
      Left = 186
      Top = 76
      ExplicitLeft = 186
      ExplicitTop = 76
    end
    object btnResetOBM_R: TSpeedButtonImage [1]
      Left = 967
      Top = 455
      Width = 57
      Height = 57
      AllowAllUp = True
      Caption = 'RESET'#13#10' OBM'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnResetOBM_RClick
      ImageList = ilGreenBox
      SpringLoaded = True
    end
    object btnWMnonMTI: TSpeedButtonImage [2]
      Left = 958
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Down = True
      Caption = 'WM'#13#10'NON'#13#10'MTI'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnWMnonMTIClick
      ImageList = ilGreenBox
    end
    object btnWMMTI_R: TSpeedButtonImage [3]
      Left = 1015
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Caption = 'WM'#13#10'MTI'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnWMMTI_RClick
      ImageList = ilGreenBox
    end
    object SpeedButtonImage7: TSpeedButtonImage [4]
      Left = 1072
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilBlueBox
    end
    object Label5: TLabel [6]
      Left = 972
      Top = 11
      Width = 115
      Height = 13
      Caption = 'VIDEO SELECTION'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel1: TBevel [7]
      Left = 1096
      Top = 17
      Width = 33
      Height = 2
    end
    object btnRR_R: TSpeedButtonImage [9]
      Left = 1023
      Top = 127
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 9
      Caption = 'RR'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnRR_RClick
      ImageList = ilGreenBox
    end
    object btnIFF_R: TSpeedButtonImage [10]
      Left = 959
      Top = 127
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Caption = 'IFF'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnIFF_RClick
      ImageList = ilGreenBox
    end
    object Image3: TImage [11]
      Left = 984
      Top = 0
      Width = 105
      Height = 105
    end
    object Image2: TImage [12]
      Left = 0
      Top = 658
      Width = 105
      Height = 105
    end
    object btnHM_R: TSpeedButtonImage [13]
      Left = 1087
      Top = 127
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 10
      Caption = 'HM'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnHM_RClick
      ImageList = ilGreenBox
    end
    object btnDataReq_R: TSpeedButtonImage [14]
      Left = 967
      Top = 543
      Width = 57
      Height = 57
      AllowAllUp = True
      Caption = 'DATA'#13#10' REQ'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnDataReq_RClick
      OnMouseDown = btnDataReq_RMouseDown
      OnMouseUp = btnDataReq_RMouseUp
      ImageList = ilGreenBox
    end
    object spbSetRange32: TSpeedButtonImage [15]
      Left = 249
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Down = True
      Caption = '32'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange8: TSpeedButtonImage [16]
      Left = 135
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '8'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange16: TSpeedButtonImage [17]
      Left = 192
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '16'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange4: TSpeedButtonImage [18]
      Left = 78
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '4'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object Label27: TLabel [19]
      Left = 116
      Top = 11
      Width = 122
      Height = 13
      Caption = 'RANGE SCALE (DM)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel7: TBevel [20]
      Left = 240
      Top = 16
      Width = 91
      Height = 2
    end
    object Bevel8: TBevel [21]
      Left = 24
      Top = 16
      Width = 89
      Height = 2
    end
    object btnDataReq_L: TSpeedButtonImage [22]
      Left = 111
      Top = 543
      Width = 57
      Height = 57
      AllowAllUp = True
      Caption = 'DATA'#13#10' REQ'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnDataReq_LClick
      OnMouseDown = btnDataReq_LMouseDown
      OnMouseUp = btnDataReq_LMouseUp
      ImageList = ilGreenBox
    end
    object spbSetRange2: TSpeedButtonImage [23]
      Tag = 4
      Left = 21
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '2'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object Label29: TLabel [24]
      Left = 184
      Top = 826
      Width = 57
      Height = 13
      Caption = 'BEARING'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnCUORoffCENT_L: TSpeedButtonImage [25]
      Left = 111
      Top = 191
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Caption = 'CU OR'#13#10' OFF'#13#10'CENT'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCUORoffCENT_LClick
      ImageList = ilGreenBox
    end
    object btnCUorCENT_L: TSpeedButtonImage [26]
      Left = 111
      Top = 255
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Down = True
      Caption = 'CU OR'#13#10' CENT'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCUorCENT_LClick
      ImageList = ilGreenBox
    end
    object btnOFFCent_L: TSpeedButtonImage [27]
      Left = 111
      Top = 319
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 6
      Caption = ' OFF'#13#10'CENT'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnOFFCent_LClick
      ImageList = ilGreenBox
    end
    object btnCENT_L: TSpeedButtonImage [28]
      Left = 111
      Top = 383
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 6
      Down = True
      Caption = 'CENT'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCENT_LClick
      ImageList = ilGreenBox
    end
    object btnResetOBM_L: TSpeedButtonImage [29]
      Left = 111
      Top = 447
      Width = 57
      Height = 57
      AllowAllUp = True
      Caption = 'RESET'#13#10' OBM'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnResetOBM_LClick
      ImageList = ilGreenBox
      SpringLoaded = True
    end
    object Bevel3: TBevel [30]
      Left = 944
      Top = 17
      Width = 18
      Height = 2
    end
    object Label2: TLabel [31]
      Left = 912
      Top = 826
      Width = 40
      Height = 13
      Caption = 'Range'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited Panel3: TPanel
      Left = 344
      Top = 0
      Width = 161
      Height = 73
      ExplicitLeft = 344
      ExplicitTop = 0
      ExplicitWidth = 161
      ExplicitHeight = 73
      inherited VrBearing: TVrDigitGroup
        Left = 25
        Width = 112
        Height = 45
        ExplicitLeft = 25
        ExplicitWidth = 112
        ExplicitHeight = 45
      end
      inherited lblBearing: TLabel
        Left = 28
        Top = 56
        Width = 103
        Height = 14
        Font.Height = -12
        ExplicitLeft = 28
        ExplicitTop = 56
        ExplicitWidth = 103
        ExplicitHeight = 14
      end
    end
    inherited pnlRange: TPanel
      Left = 640
      Top = 0
      Width = 161
      Height = 73
      ExplicitLeft = 640
      ExplicitTop = 0
      ExplicitWidth = 161
      ExplicitHeight = 73
      inherited VrRange: TVrDigitGroup
        Left = 16
        Width = 137
        Height = 45
        ExplicitLeft = 16
        ExplicitWidth = 137
        ExplicitHeight = 45
      end
      inherited lblRanges: TLabel
        Left = 41
        Top = 56
        Width = 85
        Height = 14
        Font.Height = -12
        ExplicitLeft = 41
        ExplicitTop = 56
        ExplicitWidth = 85
        ExplicitHeight = 14
      end
    end
    inherited pnl1: TPanel
      TabOrder = 3
      inherited wRange: TVrWheel
        Left = 884
        ExplicitLeft = 884
      end
    end
    object Panel2: TPanel
      Left = 136
      Top = 840
      Width = 857
      Height = 153
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 2
      object LabelSelection: TLabel
        Left = 384
        Top = 77
        Width = 114
        Height = 13
        Caption = 'LABEL SELECTION'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object btnTM: TSpeedButtonImage
        Left = 367
        Top = 17
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 14
        Caption = 'TM'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTMClick
        ImageList = ilGreenBox
      end
      object btnOwnCurs: TSpeedButtonImage
        Left = 431
        Top = 17
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 15
        Caption = 'OWN'#13#10'CURS'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnOwnCursClick
        ImageList = ilGreenBox
      end
      object btn12Sec: TSpeedButtonImage
        Left = 7
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 13
        Caption = ' 12'#13#10'SEC'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btn12SecClick
        ImageList = ilGreenBox
      end
      object btn30Sec: TSpeedButtonImage
        Left = 71
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 13
        Caption = ' 30'#13#10'SEC'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btn30SecClick
        ImageList = ilGreenBox
      end
      object btn15Min: TSpeedButtonImage
        Left = 199
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 13
        Caption = ' 15'#13#10'MIN'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btn15MinClick
        ImageList = ilGreenBox
      end
      object btn6Min: TSpeedButtonImage
        Left = 135
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 13
        Caption = '  6'#13#10'MIN'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btn6MinClick
        ImageList = ilGreenBox
      end
      object btnReset: TSpeedButtonImage
        Left = 263
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 13
        Caption = 'RESET'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnResetClick
        ImageList = ilGreenBox
      end
      object btnMS: TSpeedButtonImage
        Left = 287
        Top = 91
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 24
        Down = True
        Caption = 'MS'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMSClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage50: TSpeedButtonImage
        Left = 351
        Top = 91
        Width = 57
        Height = 57
        AllowAllUp = True
        Flat = True
        ImageList = ilGreenBox
      end
      object btnLINK: TSpeedButtonImage
        Left = 479
        Top = 91
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 28
        Caption = 'LINK'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnLINKClick
        ImageList = ilGreenBox
      end
      object btnAMPLInfo: TSpeedButtonImage
        Left = 415
        Top = 91
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 27
        Down = True
        Caption = 'AMPL'#13#10'INFO'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAMPLInfoClick
        ImageList = ilGreenBox
      end
      object btnAIR: TSpeedButtonImage
        Left = 535
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 15
        Down = True
        Caption = 'AIR'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAIRClick
        ImageList = ilGreenBox
      end
      object btnSURF: TSpeedButtonImage
        Left = 599
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 16
        Down = True
        Caption = 'SURF'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnSURFClick
        ImageList = ilGreenBox
      end
      object btnBLINDARC: TSpeedButtonImage
        Left = 727
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 20
        Caption = 'BLIND'#13#10'ARCS'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnBLINDARCClick
        ImageList = ilGreenBox
      end
      object btnLPDTEST: TSpeedButtonImage
        Left = 791
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 22
        Caption = 'LPD'#13#10'TEST'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnLPDTESTClick
        ImageList = ilGreenBox
      end
      object Label64: TLabel
        Left = 96
        Top = 2
        Width = 138
        Height = 13
        Caption = 'THREAT ASSESSMENT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel13: TBevel
        Left = 248
        Top = 8
        Width = 73
        Height = 3
      end
      object Bevel14: TBevel
        Left = 24
        Top = 8
        Width = 65
        Height = 3
      end
      object Bevel15: TBevel
        Left = 512
        Top = 83
        Width = 81
        Height = 3
      end
      object Bevel16: TBevel
        Left = 296
        Top = 83
        Width = 81
        Height = 3
      end
      object SpeedButtonImage2: TSpeedButtonImage
        Left = 663
        Top = 18
        Width = 57
        Height = 57
        AllowAllUp = True
        Flat = True
        ImageList = ilBlueBox
      end
      object btnTN: TSpeedButtonImage
        Left = 560
        Top = 91
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 29
        Down = True
        Caption = 'TN'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTNClick
        ImageList = ilGreenBox
      end
    end
  end
  inherited Map: TMap
    Left = 321
    Top = 166
    ExplicitLeft = 321
    ExplicitTop = 166
    ControlData = {
      8B1A0600D885000037660000010000000F0000FF0D47656F44696374696F6E61
      727905456D70747900E8030000000000000000000002000E001E000000000000
      0000000000000000000000000000000000000000000600010000000000500001
      010000640000000001F4010000050000800C000000000000000000000000FFFF
      FF000100000000000000000000000000000000000000000000000352E30B918F
      CE119DE300AA004BB851010000009001B0710B0005417269616C000352E30B91
      8FCE119DE300AA004BB8510100000090019C51030005417269616C0000000000
      00000000000000000000000000000000000000000000000000000000000000D8
      ECF8000000000000000001370000000000D8ECF8000000000000000352E30B91
      8FCE119DE300AA004BB851010000009001DC7C010005417269616C000352E30B
      918FCE119DE300AA004BB851010200009001A42C02000B4D61702053796D626F
      6C730000000000000001000100FFFFFF000200D8ECF800000000000001000000
      010001180100000005260001000000F0EE22001C000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8076C000000000008056C0000000000080764000000000008056400100000018
      0100000005260001000000C5A629501C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005C005300C804260041
      00730090F2C906200053000D00000050B7CC06C8042600000000000000000000
      000088B3400000000000408F400001000001}
  end
  inherited PopupMenu1: TPopupMenu
    Left = 200
    Top = 88
  end
  inherited ColorDialog1: TColorDialog
    Left = 323
    Top = 42
  end
  inherited ilGreenBox: TImageList
    Left = 250
  end
  inherited ilGreenRound: TImageList
    Left = 332
  end
  inherited ilBlueBox: TImageList
    Left = 286
  end
  inherited ilOrangeBox: TImageList
    Left = 370
  end
end
