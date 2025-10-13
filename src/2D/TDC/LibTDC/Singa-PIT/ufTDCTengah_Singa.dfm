inherited frmTDCTengah_Singa: TfrmTDCTengah_Singa
  Left = 58
  Top = 4
  AutoSize = True
  Caption = 'TDC Singa'
  ClientWidth = 1260
  Color = clMoneyGreen
  Font.Charset = ANSI_CHARSET
  Font.Name = 'Verdana'
  ExplicitTop = 8
  ExplicitWidth = 1268
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 0
    Height = 953
    OnMouseMove = Panel1MouseMove
    ExplicitLeft = 0
    ExplicitHeight = 953
    DesignSize = (
      1260
      953)
    object SpeedButtonImage31: TSpeedButtonImage [0]
      Left = 557
      Top = 875
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'TM'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButtonImage31Click
      ImageList = ilOrangeBox
    end
    inherited Image1: TImage
      Top = 101
      ExplicitTop = 101
    end
    object SpeedButtonImage32: TSpeedButtonImage [2]
      Left = 622
      Top = 875
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'OWN'#13#10'CURS'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButtonImage32Click
      ImageList = ilOrangeBox
    end
    object spbSetRange32: TSpeedButtonImage [7]
      Left = 249
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Down = True
      Caption = '32'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange8: TSpeedButtonImage [8]
      Left = 135
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange16: TSpeedButtonImage [9]
      Left = 192
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '16'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange4: TSpeedButtonImage [10]
      Left = 78
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object Label31: TLabel [11]
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
    object Bevel7: TBevel [12]
      Left = 240
      Top = 16
      Width = 91
      Height = 2
    end
    object Bevel8: TBevel [13]
      Left = 24
      Top = 16
      Width = 89
      Height = 2
    end
    object spbSetRange2: TSpeedButtonImage [14]
      Tag = 4
      Left = 21
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange64: TSpeedButtonImage [15]
      Left = 306
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Caption = '64'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object SpeedButtonImage1: TSpeedButtonImage [16]
      Left = 363
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilBlueBox
    end
    inherited Panel3: TPanel
      Left = 448
      TabOrder = 4
      ExplicitLeft = 448
    end
    inherited pnlRange: TPanel
      Left = 656
      TabOrder = 5
      ExplicitLeft = 656
    end
    object Panel2: TPanel
      Left = 16
      Top = 256
      Width = 169
      Height = 377
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 0
      object SpeedButtonImage10: TSpeedButtonImage
        Left = 93
        Top = 66
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'CU OR'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage10Click
        ImageList = ilGreenBox
        SpringLoaded = True
      end
      object SpeedButtonImage9: TSpeedButtonImage
        Left = 93
        Top = 9
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'CU OR'#13#10'OFF'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage9Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object SpeedButtonImage11: TSpeedButtonImage
        Left = 93
        Top = 123
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'OFF'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage11Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object SpeedButtonImage12: TSpeedButtonImage
        Left = 93
        Top = 180
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage12Click
        ImageList = ilGreenBox
        SpringLoaded = True
      end
      object SpeedButtonImage13: TSpeedButtonImage
        Left = 93
        Top = 237
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'RESET'#13#10'OBM'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage13Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object btnICM1_L: TSpeedButtonImage
        Left = 29
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = '1'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM2_L: TSpeedButtonImage
        Left = 29
        Top = 122
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = '2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM3_L: TSpeedButtonImage
        Left = 29
        Top = 179
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = '3'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object Label18: TLabel
        Left = 5
        Top = 153
        Width = 22
        Height = 12
        Alignment = taCenter
        Caption = 'ICM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object Bevel2: TBevel
        Left = 16
        Top = 98
        Width = 3
        Height = 133
      end
      object spbDataReq_L: TSpeedButtonImage
        Left = 96
        Top = 320
        Width = 57
        Height = 57
        Caption = 'DATA '#13#10'REQ'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnMouseDown = spbDataReq_LMouseDown
        OnMouseUp = spbDataReq_LMouseUp
        ImageList = ilGreenBox
        SpringLoaded = True
      end
    end
    object Panel3singa: TPanel
      Left = 1048
      Top = 248
      Width = 177
      Height = 385
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 1
      object SpeedButtonImage8: TSpeedButtonImage
        Left = 8
        Top = 240
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = 'RESET'#13#10'OBM'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage8Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object SpeedButtonImage7: TSpeedButtonImage
        Left = 8
        Top = 183
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = 'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage7Click
        ImageList = ilGreenBox
        SpringLoaded = True
      end
      object SpeedButtonImage6: TSpeedButtonImage
        Left = 8
        Top = 126
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = 'OFF'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage6Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object SpeedButtonImage5: TSpeedButtonImage
        Left = 8
        Top = 69
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = 'CU OR'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage5Click
        ImageList = ilGreenBox
        SpringLoaded = True
      end
      object btnICM1_R: TSpeedButtonImage
        Left = 72
        Top = 69
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = '1'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM1_RClick
        ImageList = ilGreenBox
      end
      object Label9: TLabel
        Left = 138
        Top = 161
        Width = 22
        Height = 12
        Alignment = taCenter
        Caption = 'ICM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object Bevel1: TBevel
        Left = 150
        Top = 106
        Width = 3
        Height = 133
      end
      object btnICM2_R: TSpeedButtonImage
        Left = 72
        Top = 126
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = '2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM1_RClick
        ImageList = ilGreenBox
      end
      object btnICM3_R: TSpeedButtonImage
        Left = 72
        Top = 183
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = '3'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnICM1_RClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage4: TSpeedButtonImage
        Left = 8
        Top = 12
        Width = 57
        Height = 57
        GroupIndex = 1
        Caption = 'CU OR'#13#10'OFF'#13#10'CENT'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage4Click
        ImageList = ilOrangeBox
        SpringLoaded = True
      end
      object spbDataReq_R: TSpeedButtonImage
        Left = 8
        Top = 317
        Width = 57
        Height = 57
        Caption = 'DATA '#13#10'REQ'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = spbDataReq_RClick
        OnMouseDown = spbDataReq_RMouseDown
        OnMouseUp = spbDataReq_RMouseUp
        ImageList = ilGreenBox
        SpringLoaded = True
      end
    end
    object Panel4: TPanel
      Left = 896
      Top = 8
      Width = 353
      Height = 129
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 2
      object SpeedButtonImage17: TSpeedButtonImage
        Left = 5
        Top = 7
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'A/N'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ImageList = ilGreenBox
      end
      object SpeedButtonImage18: TSpeedButtonImage
        Left = 62
        Top = 7
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'TV'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ImageList = ilGreenBox
      end
      object SpeedButtonImage19: TSpeedButtonImage
        Left = 234
        Top = 7
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'MTI'#13#10'NOT'#13#10'AVL'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ImageList = ilGreenRound
      end
      object SpeedButtonImage20: TSpeedButtonImage
        Left = 5
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        OnClick = SpeedButtonImage20Click
        ImageList = ilBlueBox
      end
      object SpeedButtonImage21: TSpeedButtonImage
        Left = 62
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        OnClick = SpeedButtonImage21Click
        ImageList = ilBlueBox
      end
      object SpeedButtonImage22: TSpeedButtonImage
        Left = 119
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        OnClick = SpeedButtonImage22Click
        ImageList = ilBlueBox
      end
      object btnWMNonMTI: TSpeedButtonImage
        Left = 176
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Down = True
        Caption = 'WM'#13#10'NON'#13#10'MTI'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnWMNonMTIClick
        ImageList = ilGreenBox
      end
      object btnWMMTI_R: TSpeedButtonImage
        Left = 233
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'WM'#13#10'MTI'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnWMMTI_RClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage25: TSpeedButtonImage
        Left = 290
        Top = 65
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'NAV'#13#10'RADAR'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ImageList = ilGreenBox
      end
      object SpeedButtonImage26: TSpeedButtonImage
        Left = 1259
        Top = 105
        Width = 65
        Height = 65
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
      end
    end
    object Panel5: TPanel
      Left = 1040
      Top = 160
      Width = 185
      Height = 73
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 3
      object SpeedButtonImage27: TSpeedButtonImage
        Left = 8
        Top = 9
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'IFF'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ImageList = ilGreenBox
      end
      object SpeedButtonImage28: TSpeedButtonImage
        Left = 65
        Top = 9
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'R R'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage28Click
        ImageList = ilGreenBox
      end
      object SpeedButtonImage29: TSpeedButtonImage
        Left = 122
        Top = 9
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'H M'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButtonImage29Click
        ImageList = ilGreenBox
      end
    end
  end
  inherited Map: TMap
    Left = 296
    Top = 104
    ExplicitLeft = 296
    ExplicitTop = 104
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
      010001180100003803260001000000DCE322001C000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8076C000000000008056C0000000000080764000000000008056400100000018
      0100003803260001000000FCE4E7791C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000001000000A801260000
      000000B0B4F1051CE02200000000009CE02200A8012600000000000000000000
      000088B3400000000000408F400001000001}
  end
  inherited PopupMenu1: TPopupMenu
    Left = 128
    Top = 128
  end
  inherited ColorDialog1: TColorDialog
    Left = 235
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
