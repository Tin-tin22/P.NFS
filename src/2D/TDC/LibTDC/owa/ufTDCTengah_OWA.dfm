inherited frmTDCTengah_OWA: TfrmTDCTengah_OWA
  Left = 95
  Top = 15
  Width = 1283
  Height = 1007
  AutoSize = True
  Caption = 'frmTDCTengah_OWA'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 0
    Width = 1275
    Font.Color = clWhite
    Font.Height = -9
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    OnMouseMove = Panel1MouseMove
    inherited Image1: TImage
      Left = 254
      Top = 140
    end
    inherited wRange: TVrWheel [1]
      Left = 876
      Top = 872
    end
    inherited Image2: TImage [2]
      Left = 174
      Top = 814
    end
    inherited wBearing: TVrWheel [3]
      Left = 316
      Top = 872
    end
    inherited Image3: TImage [4]
      Left = 976
      Top = 816
    end
    object Panel5: TPanel [5]
      Left = 1108
      Top = 222
      Width = 157
      Height = 640
      BevelOuter = bvNone
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object btnICM1_R: TSpeedButtonImage
        Tag = 11
        Left = 66
        Top = 2
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '1'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM2_R: TSpeedButtonImage
        Tag = 12
        Left = 66
        Top = 59
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '2'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM3_R: TSpeedButtonImage
        Tag = 13
        Left = 66
        Top = 116
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '3'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object Label23: TLabel
        Left = 130
        Top = 279
        Width = 19
        Height = 12
        Caption = 'ICM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel1: TBevel
        Left = 143
        Top = 34
        Width = 2
        Height = 245
      end
      object Bevel2: TBevel
        Left = 143
        Top = 296
        Width = 2
        Height = 251
      end
      object Bevel3: TBevel
        Left = 122
        Top = 34
        Width = 20
        Height = 2
      end
      object Bevel4: TBevel
        Left = 123
        Top = 545
        Width = 20
        Height = 2
      end
      object btnICM4_R: TSpeedButtonImage
        Tag = 14
        Left = 66
        Top = 173
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '4'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM5_R: TSpeedButtonImage
        Tag = 15
        Left = 66
        Top = 230
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '5'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM6_R: TSpeedButtonImage
        Tag = 16
        Left = 66
        Top = 287
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '6'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM7_R: TSpeedButtonImage
        Tag = 17
        Left = 66
        Top = 344
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '7'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage8: TSpeedButtonImage
        Tag = 18
        Left = 66
        Top = 401
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '8'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnICM9_R: TSpeedButtonImage
        Tag = 19
        Left = 66
        Top = 458
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '9'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage18: TSpeedButtonImage
        Tag = 20
        Left = 66
        Top = 515
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '10'
        Flat = True
        OnClick = btnICM_RClick
        ImageList = ilGreenBox
      end
      object btnDROCM_R: TSpeedButtonImage
        Left = 3
        Top = 173
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR'#13#10'OCM'
        Flat = True
        OnClick = btnDROCM_RClick
        ImageList = ilOrangeBox
      end
      object btnDROBM_R: TSpeedButtonImage
        Left = 3
        Top = 230
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR'#13#10'OBM'
        Flat = True
        OnClick = btnDROBM_RClick
        ImageList = ilOrangeBox
      end
      object btnOFFCent_R: TSpeedButtonImage
        Left = 3
        Top = 287
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'PICT'#13#10'OFFC'
        Flat = True
        OnClick = btnOFFCent_RClick
        ImageList = ilOrangeBox
      end
      object btnCENT_R: TSpeedButtonImage
        Left = 3
        Top = 344
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'PICT'#13#10'REST'
        Flat = True
        OnClick = btnCENT_RClick
        ImageList = ilOrangeBox
      end
      object btnCUORoffCENT_R: TSpeedButtonImage
        Left = 3
        Top = 401
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OCM'#13#10'OFFC'
        Flat = True
        OnClick = btnCUORoffCENT_RClick
        ImageList = ilOrangeBox
      end
      object btnCUorCENT_R: TSpeedButtonImage
        Left = 3
        Top = 458
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OCM'#13#10'RES'
        Flat = True
        OnClick = btnCUorCENT_RClick
        ImageList = ilOrangeBox
      end
      object btnResetOBM_R: TSpeedButtonImage
        Left = 3
        Top = 515
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OBM'#13#10'RES'
        Flat = True
        OnClick = btnResetOBM_RClick
        ImageList = ilGreenBox
      end
      object btnDataReq_R: TSpeedButtonImage
        Left = 66
        Top = 579
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR'
        Flat = True
        OnClick = btnDataReq_RClick
        ImageList = ilGreenBox
      end
    end
    object Panel4: TPanel [6]
      Left = 2
      Top = 80
      Width = 456
      Height = 57
      AutoSize = True
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 3
      object spbSetRange256: TSpeedButtonImage
        Left = 399
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '256'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange128: TSpeedButtonImage
        Left = 342
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '128'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange64: TSpeedButtonImage
        Left = 285
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '64'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange32: TSpeedButtonImage
        Left = 228
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '32'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange4: TSpeedButtonImage
        Tag = 4
        Left = 57
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '4'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange8: TSpeedButtonImage
        Left = 114
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '8'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange16: TSpeedButtonImage
        Left = 171
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '16'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
      object spbSetRange2: TSpeedButtonImage
        Tag = 4
        Left = 0
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 4
        Caption = '2'
        Flat = True
        OnClick = spbSetRange256Click
        ImageList = ilGreenBox
      end
    end
    inherited Panel3: TPanel
      Left = 392
      Top = 0
    end
    object Panel2: TPanel [8]
      Left = 8
      Top = 214
      Width = 162
      Height = 640
      BevelOuter = bvNone
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object btnICM1_L: TSpeedButtonImage
        Tag = 1
        Left = 38
        Top = 2
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '1'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM2_L: TSpeedButtonImage
        Tag = 2
        Left = 38
        Top = 59
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '2'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM3_L: TSpeedButtonImage
        Tag = 3
        Left = 38
        Top = 116
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '3'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object Label40: TLabel
        Left = 3
        Top = 279
        Width = 19
        Height = 12
        Caption = 'ICM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel9: TBevel
        Left = 12
        Top = 34
        Width = 2
        Height = 245
      end
      object Bevel10: TBevel
        Left = 16
        Top = 296
        Width = 2
        Height = 251
      end
      object Bevel11: TBevel
        Left = 11
        Top = 34
        Width = 16
        Height = 2
      end
      object Bevel12: TBevel
        Left = 15
        Top = 545
        Width = 15
        Height = 2
      end
      object btnICM4_L: TSpeedButtonImage
        Tag = 4
        Left = 38
        Top = 173
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '4'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM5_L: TSpeedButtonImage
        Tag = 5
        Left = 38
        Top = 230
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '5'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM6_L: TSpeedButtonImage
        Tag = 6
        Left = 38
        Top = 287
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '6'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM7_L: TSpeedButtonImage
        Tag = 7
        Left = 38
        Top = 344
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '7'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM8_L: TSpeedButtonImage
        Tag = 8
        Left = 38
        Top = 401
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '8'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM9_L: TSpeedButtonImage
        Tag = 9
        Left = 38
        Top = 458
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '9'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object btnICM10_L: TSpeedButtonImage
        Tag = 10
        Left = 38
        Top = 515
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = '10'
        Flat = True
        OnClick = btnICM_LClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage9: TSpeedButtonImage
        Left = 102
        Top = 173
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR '#13#10'OCM'
        Flat = True
        ImageList = ilOrangeBox
      end
      object btnDROBM_L: TSpeedButtonImage
        Left = 102
        Top = 230
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR '#13#10'OBM'
        Flat = True
        OnClick = btnDROBM_LClick
        ImageList = ilOrangeBox
      end
      object btnOFFCent_L: TSpeedButtonImage
        Left = 102
        Top = 287
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'PICT '#13#10'OFFC'
        Flat = True
        OnClick = btnOFFCent_LClick
        ImageList = ilOrangeBox
      end
      object btnCent_L: TSpeedButtonImage
        Left = 102
        Top = 344
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'PICT '#13#10'REST'
        Flat = True
        OnClick = btnCent_LClick
        ImageList = ilOrangeBox
      end
      object btnCUORoffCENT_L: TSpeedButtonImage
        Left = 102
        Top = 401
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OCM'#13#10'OFFC'
        Flat = True
        OnClick = btnCUORoffCENT_LClick
        ImageList = ilOrangeBox
      end
      object btnCUorCENT_L: TSpeedButtonImage
        Left = 102
        Top = 458
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OCM'#13#10'RES'
        Flat = True
        OnClick = btnCUorCENT_LClick
        ImageList = ilOrangeBox
      end
      object btnResetOBM_L: TSpeedButtonImage
        Left = 102
        Top = 515
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'OBM'#13#10'RES'
        Flat = True
        OnClick = btnResetOBM_LClick
        ImageList = ilGreenBox
      end
      object btnDataReq_L: TSpeedButtonImage
        Left = 38
        Top = 579
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DR'
        Flat = True
        OnClick = btnDataReq_LClick
        ImageList = ilGreenBox
      end
    end
    object Panel6: TPanel [9]
      Left = 705
      Top = 81
      Width = 568
      Height = 57
      AutoSize = True
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 5
      object btnIFF: TSpeedButtonImage
        Left = 0
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'IFF'
        Flat = True
        OnClick = btnIFFClick
        ImageList = ilGreenBox
      end
      object btnVESTA: TSpeedButtonImage
        Left = 57
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'VESTA'
        Flat = True
        OnClick = btnVESTAClick
        ImageList = ilGreenBox
      end
      object btnLW03: TSpeedButtonImage
        Left = 114
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'LW 03'
        Flat = True
        OnClick = btnLW03Click
        ImageList = ilGreenBox
      end
      object btnDALIN: TSpeedButtonImage
        Left = 169
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DA'#13#10'LIN'
        Flat = True
        OnClick = btnDALINClick
        ImageList = ilGreenBox
      end
      object btnDALOG: TSpeedButtonImage
        Left = 226
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DA'#13#10'LOG'
        Flat = True
        OnClick = btnDALOGClick
        ImageList = ilGreenBox
      end
      object btnDAMTI: TSpeedButtonImage
        Left = 283
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DA'#13#10'MTI'
        Flat = True
        OnClick = btnDAMTIClick
        ImageList = ilGreenBox
      end
      object btnDECCA: TSpeedButtonImage
        Left = 340
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'DECCA'#13#10' 1229'
        Flat = True
        OnClick = btnDECCAClick
        ImageList = ilGreenBox
      end
      object SpeedButtonImage17: TSpeedButtonImage
        Left = 397
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Flat = True
        ImageList = ilGreenBox
      end
      object SpeedButtonImage27: TSpeedButtonImage
        Left = 454
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Flat = True
        ImageList = ilGreenBox
      end
      object SpeedButtonImage28: TSpeedButtonImage
        Left = 511
        Top = 0
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Flat = True
        ImageList = ilGreenBox
      end
    end
    object Panel7: TPanel [10]
      Left = 1046
      Top = 148
      Width = 117
      Height = 61
      BevelOuter = bvNone
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Terminal'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    inherited pnlRange: TPanel
      Left = 592
      Top = 0
    end
    object Panel9: TPanel
      Left = 564
      Top = 912
      Width = 117
      Height = 62
      BevelOuter = bvNone
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Terminal'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object btnTM: TSpeedButtonImage
        Left = 58
        Top = 1
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'TM'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTMClick
        ImageList = ilOrangeBox
      end
      object btnCUGEO: TSpeedButtonImage
        Left = 1
        Top = 1
        Width = 57
        Height = 57
        AllowAllUp = True
        GroupIndex = 6
        Caption = 'CU - '#13#10'GEO'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ImageList = ilGreenBox
      end
    end
  end
  inherited Map: TMap
    Left = 320
    Top = 288
    Width = 593
    Height = 485
    ControlData = {
      8A1A06000F5500007D430000010000000F0000FF0D47656F44696374696F6E61
      727905456D70747900E8030000000000000000000002000E001E000000000000
      0000000000000000000000000000000000000000000600010000000000500001
      010000640000000001F4010000050000800C000000000000000000000000FFFF
      FF000100000000000000000000000000000000000000000000000352E30B918F
      CE119DE300AA004BB851010000009001E4AA070005417269616C000352E30B91
      8FCE119DE300AA004BB8510100000090019C51030005417269616C0000000000
      00000000000000000000000000000000000000000000000000000000000000D8
      ECF8000000000000000001370000000000D8ECF8000000000000000352E30B91
      8FCE119DE300AA004BB851010000009001DC7C010005417269616C000352E30B
      918FCE119DE300AA004BB851010200009001A42C02000B4D61702053796D626F
      6C730000000000000001000100FFFFFF000200D8ECF800000000000001000000
      01000118010000B80215000100000034E313001C000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8076C000000000008056C0000000000080764000000000008056400100000018
      010000B802150001000000D00225011C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000530500005305A0
      FC5E0410705C04100000001000000060D32400D8DF5704000000000000000000
      000088B3400000000000408F400001000001}
  end
  inherited ColorDialog1: TColorDialog [2]
    Left = 88
    Top = 0
  end
  inherited ilGreenBox: TImageList [3]
    Left = 226
    Top = 16
  end
  inherited ilGreenRound: TImageList [4]
    Left = 324
    Top = 16
  end
  inherited ilBlueBox: TImageList [5]
    Left = 286
    Top = 16
  end
  inherited ilOrangeBox: TImageList [6]
    Left = 362
    Top = 16
  end
  inherited ilOrangeRound: TImageList [7]
    Left = 180
    Top = 16
  end
  inherited PopupMenu1: TPopupMenu [8]
    Left = 128
    Top = 0
  end
  object ilWhite: TImageList
    Left = 303
    Top = 45
  end
end
