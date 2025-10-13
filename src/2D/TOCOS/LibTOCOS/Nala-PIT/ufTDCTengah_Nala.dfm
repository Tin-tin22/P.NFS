inherited frmTDCTengah_Nala: TfrmTDCTengah_Nala
  Left = 100
  Top = 31
  Caption = 'TDC TENGAH NALA'
  ClientWidth = 1269
  Color = clMoneyGreen
  DefaultMonitor = dmDesktop
  Scaled = False
  ExplicitWidth = 1277
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 0
    Width = 1241
    ExplicitLeft = 0
    ExplicitWidth = 1241
    object btnAN_R: TSpeedButtonImage [1]
      Left = 976
      Top = 4
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilGreenBox
    end
    object Label65: TLabel [2]
      Left = 996
      Top = 28
      Width = 21
      Height = 12
      Caption = 'A/N'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnTV_R: TSpeedButtonImage [3]
      Left = 1042
      Top = 4
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilGreenBox
    end
    object Label1: TLabel [4]
      Left = 1066
      Top = 29
      Width = 13
      Height = 12
      Caption = 'TV'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnDAMTI_R: TSpeedButtonImage [5]
      Left = 897
      Top = 85
      Width = 58
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Flat = True
      OnClick = btnDAMTI_RClick
      ImageList = ilGreenBox
    end
    object BtnDALIN_R: TSpeedButtonImage [6]
      Left = 956
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Flat = True
      OnClick = BtnDALIN_RClick
      ImageList = ilGreenBox
    end
    object btnWMnonMTI: TSpeedButtonImage [7]
      Left = 1068
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Down = True
      Flat = True
      OnClick = btnWMnonMTIClick
      ImageList = ilGreenBox
    end
    object btnDALOG_R: TSpeedButtonImage [8]
      Left = 1012
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Flat = True
      OnClick = btnDALOG_RClick
      ImageList = ilGreenBox
    end
    object btnWMMTI_R: TSpeedButtonImage [9]
      Left = 1125
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Flat = True
      OnClick = btnWMMTI_RClick
      ImageList = ilGreenBox
    end
    object SpeedButtonImage7: TSpeedButtonImage [10]
      Left = 1181
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilGreenBox
    end
    object lblDA_MTI: TLabel [11]
      Left = 916
      Top = 100
      Width = 19
      Height = 24
      Caption = ' DA'#13#10'MTI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblDA_MTIClick
    end
    object lblDA_LIN: TLabel [12]
      Left = 974
      Top = 100
      Width = 18
      Height = 24
      Caption = ' DA'#13#10'LIN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblDA_LINClick
    end
    object lblDA_Log: TLabel [13]
      Left = 1029
      Top = 100
      Width = 21
      Height = 24
      Caption = ' DA'#13#10'LOG'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblDA_LogClick
    end
    object lblWM_MTI: TLabel [14]
      Left = 1143
      Top = 100
      Width = 19
      Height = 24
      Caption = 'WM'#13#10'MTI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblWM_MTIClick
    end
    object Label5: TLabel [15]
      Left = 1003
      Top = 67
      Width = 130
      Height = 16
      Caption = 'VIDEO SELECTION'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel1: TBevel [16]
      Left = 1150
      Top = 74
      Width = 83
      Height = 3
    end
    object Bevel2: TBevel [17]
      Left = 888
      Top = 77
      Width = 105
      Height = 3
    end
    object lblWM_NONMTI: TLabel [18]
      Left = 1085
      Top = 95
      Width = 22
      Height = 36
      Caption = 'WM'#13#10'NON'#13#10'MTI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblWM_NONMTIClick
    end
    object btnMRnonXXX_R: TSpeedButtonImage [19]
      Left = 1154
      Top = 4
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilGreenRound
    end
    object Label6: TLabel [20]
      Left = 1176
      Top = 16
      Width = 22
      Height = 36
      Caption = 'MTI'#13#10'NON'#13#10'AVL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnRR_R: TSpeedButtonImage [21]
      Left = 1123
      Top = 169
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 9
      Flat = True
      OnClick = btnRR_RClick
      ImageList = ilGreenBox
    end
    object btnIFF_R: TSpeedButtonImage [22]
      Left = 1067
      Top = 169
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnIFF_RClick
      ImageList = ilGreenBox
    end
    object Label7: TLabel [23]
      Left = 1089
      Top = 192
      Width = 17
      Height = 12
      Caption = 'IFF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label7Click
    end
    object Label8: TLabel [24]
      Left = 1142
      Top = 192
      Width = 14
      Height = 12
      Caption = 'RR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label8Click
    end
    object btnHM_R: TSpeedButtonImage [25]
      Left = 1179
      Top = 169
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 10
      Flat = True
      OnClick = btnHM_RClick
      ImageList = ilGreenBox
    end
    object Label9: TLabel [26]
      Left = 1198
      Top = 192
      Width = 15
      Height = 12
      Caption = 'HM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label9Click
    end
    object btnCUORoffCENT_R: TSpeedButtonImage [27]
      Left = 1056
      Top = 244
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 10
      Flat = True
      OnClick = btnCUORoffCENT_RClick
      ImageList = ilGreenBox
    end
    object Label10: TLabel [28]
      Left = 1069
      Top = 257
      Width = 31
      Height = 36
      Caption = 'CU OR'#13#10' OFF'#13#10'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label10Click
    end
    object btnCUorCENT_R: TSpeedButtonImage [29]
      Left = 1056
      Top = 308
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 10
      Flat = True
      OnClick = btnCUorCENT_RClick
      ImageList = ilGreenBox
    end
    object Label11: TLabel [30]
      Left = 1069
      Top = 326
      Width = 31
      Height = 24
      Caption = 'CU OR'#13#10' CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label11Click
    end
    object btnOFFCent_R: TSpeedButtonImage [31]
      Left = 1056
      Top = 373
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 11
      Flat = True
      OnClick = btnOFFCent_RClick
      ImageList = ilGreenBox
    end
    object Label12: TLabel [32]
      Left = 1071
      Top = 390
      Width = 25
      Height = 24
      Caption = ' OFF'#13#10'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label12Click
    end
    object btnCENT_R: TSpeedButtonImage [33]
      Left = 1056
      Top = 437
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 11
      Flat = True
      OnClick = btnCENT_RClick
      ImageList = ilGreenBox
    end
    object Label13: TLabel [34]
      Left = 1071
      Top = 461
      Width = 25
      Height = 12
      Caption = 'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label13Click
    end
    object btnResetOBM_R: TSpeedButtonImage [35]
      Left = 1056
      Top = 502
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      OnClick = btnResetOBM_RClick
      ImageList = ilGreenBox
    end
    object btnICM1_R: TSpeedButtonImage [36]
      Left = 1136
      Top = 319
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 12
      Flat = True
      OnClick = btnICM_RClick
      ImageList = ilGreenBox
    end
    object Label14: TLabel [37]
      Left = 1161
      Top = 342
      Width = 6
      Height = 12
      Caption = '1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnICM2_R: TSpeedButtonImage [38]
      Left = 1137
      Top = 384
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 12
      Flat = True
      OnClick = btnICM_RClick
      ImageList = ilGreenBox
    end
    object Label15: TLabel [39]
      Left = 1161
      Top = 406
      Width = 6
      Height = 12
      Caption = '2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnICM3_R: TSpeedButtonImage [40]
      Left = 1137
      Top = 447
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 12
      Flat = True
      OnClick = btnICM_RClick
      ImageList = ilGreenBox
    end
    object Label16: TLabel [41]
      Left = 1161
      Top = 470
      Width = 6
      Height = 12
      Caption = '3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label17: TLabel [42]
      Left = 1200
      Top = 412
      Width = 24
      Height = 13
      Caption = 'ICM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel3: TBevel [43]
      Left = 1215
      Top = 353
      Width = 3
      Height = 57
    end
    object Bevel4: TBevel [44]
      Left = 1215
      Top = 427
      Width = 3
      Height = 55
    end
    object Bevel5: TBevel [45]
      Left = 1197
      Top = 353
      Width = 20
      Height = 3
    end
    object Bevel6: TBevel [46]
      Left = 1197
      Top = 481
      Width = 20
      Height = 3
    end
    object Label18: TLabel [47]
      Left = 1069
      Top = 519
      Width = 31
      Height = 24
      Caption = 'RESET'#13#10' OBM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label18Click
    end
    object btnDataReq_R: TSpeedButtonImage [48]
      Left = 1056
      Top = 567
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = btnDataReq_RClick
      OnMouseDown = btnDataReq_RMouseDown
      OnMouseUp = btnDataReq_RMouseUp
      ImageList = ilGreenBox
    end
    object Label19: TLabel [49]
      Left = 1071
      Top = 584
      Width = 29
      Height = 24
      Caption = 'DATA'#13#10' REQ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label19Click
    end
    object btnAN_L: TSpeedButtonImage [50]
      Left = 195
      Top = 2
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilGreenBox
    end
    object Label21: TLabel [51]
      Left = 216
      Top = 25
      Width = 21
      Height = 12
      Caption = 'A/N'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnTV_L: TSpeedButtonImage [52]
      Left = 131
      Top = 1
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      OnClick = btnTV_LClick
      ImageList = ilGreenBox
    end
    object Label22: TLabel [53]
      Left = 153
      Top = 25
      Width = 13
      Height = 12
      Caption = 'TV'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object spbSetRange128: TSpeedButtonImage [54]
      Left = 350
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange64: TSpeedButtonImage [55]
      Left = 292
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange16: TSpeedButtonImage [56]
      Left = 178
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange32: TSpeedButtonImage [57]
      Left = 235
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Down = True
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange8: TSpeedButtonImage [58]
      Left = 121
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object lblRange128: TLabel [59]
      Left = 367
      Top = 110
      Width = 24
      Height = 13
      Caption = '128'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange64: TLabel [60]
      Left = 310
      Top = 110
      Width = 16
      Height = 13
      Caption = '64'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange32: TLabel [61]
      Left = 254
      Top = 110
      Width = 16
      Height = 13
      Caption = '32'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange8: TLabel [62]
      Left = 142
      Top = 110
      Width = 8
      Height = 13
      Caption = '8'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object Label27: TLabel [63]
      Left = 138
      Top = 63
      Width = 88
      Height = 16
      Caption = 'Range Scale'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel7: TBevel [64]
      Left = 263
      Top = 72
      Width = 105
      Height = 3
    end
    object Bevel8: TBevel [65]
      Left = 8
      Top = 73
      Width = 105
      Height = 3
    end
    object lblRange16: TLabel [66]
      Left = 198
      Top = 110
      Width = 16
      Height = 13
      Caption = '16'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object btnMRnonXXX_L: TSpeedButtonImage [67]
      Left = 11
      Top = 4
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      Visible = False
      ImageList = ilGreenRound
    end
    object Label29: TLabel [68]
      Left = 33
      Top = 17
      Width = 22
      Height = 36
      Caption = 'MR'#13#10'NON'#13#10'XXX'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object btnCUORoffCENT_L: TSpeedButtonImage [69]
      Left = 142
      Top = 244
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Flat = True
      OnClick = btnCUORoffCENT_LClick
      ImageList = ilGreenBox
    end
    object Label33: TLabel [70]
      Left = 156
      Top = 256
      Width = 31
      Height = 36
      Caption = 'CU OR'#13#10' OFF'#13#10'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label33Click
    end
    object btnCUorCENT_L: TSpeedButtonImage [71]
      Left = 142
      Top = 308
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Flat = True
      OnClick = btnCUorCENT_LClick
      ImageList = ilGreenBox
    end
    object Label34: TLabel [72]
      Left = 156
      Top = 325
      Width = 31
      Height = 24
      Caption = 'CU OR'#13#10' CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label34Click
    end
    object btnOFFCent_L: TSpeedButtonImage [73]
      Left = 142
      Top = 372
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnOFFCent_LClick
      ImageList = ilGreenBox
    end
    object Label35: TLabel [74]
      Left = 158
      Top = 389
      Width = 25
      Height = 24
      Caption = ' OFF'#13#10'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label35Click
    end
    object btnCENT_L: TSpeedButtonImage [75]
      Left = 142
      Top = 436
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnCENT_LClick
      ImageList = ilGreenBox
    end
    object Label36: TLabel [76]
      Left = 159
      Top = 460
      Width = 25
      Height = 12
      Caption = 'CENT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label36Click
    end
    object btnResetOBM_L: TSpeedButtonImage [77]
      Left = 142
      Top = 500
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = btnResetOBM_LClick
      ImageList = ilGreenBox
    end
    object btnICM1_L: TSpeedButtonImage [78]
      Left = 62
      Top = 315
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 6
      Flat = True
      OnClick = btnICM_LClick
      ImageList = ilGreenBox
    end
    object Label37: TLabel [79]
      Left = 89
      Top = 338
      Width = 6
      Height = 12
      Caption = '1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnICM2_L: TSpeedButtonImage [80]
      Left = 63
      Top = 377
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 6
      Flat = True
      OnClick = btnICM_LClick
      ImageList = ilGreenBox
    end
    object Label38: TLabel [81]
      Left = 89
      Top = 402
      Width = 6
      Height = 12
      Caption = '2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnICM3_L: TSpeedButtonImage [82]
      Left = 62
      Top = 443
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 6
      Flat = True
      OnClick = btnICM_LClick
      ImageList = ilGreenBox
    end
    object Label39: TLabel [83]
      Left = 89
      Top = 466
      Width = 6
      Height = 12
      Caption = '3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label40: TLabel [84]
      Left = 32
      Top = 405
      Width = 24
      Height = 13
      Caption = 'ICM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel9: TBevel [85]
      Left = 42
      Top = 348
      Width = 3
      Height = 57
    end
    object Bevel10: TBevel [86]
      Left = 42
      Top = 422
      Width = 3
      Height = 55
    end
    object Bevel11: TBevel [87]
      Left = 42
      Top = 348
      Width = 20
      Height = 3
    end
    object Bevel12: TBevel [88]
      Left = 42
      Top = 476
      Width = 20
      Height = 3
    end
    object Label41: TLabel [89]
      Left = 156
      Top = 518
      Width = 31
      Height = 24
      Caption = 'RESET'#13#10' OBM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label41Click
    end
    object btnDataReq_L: TSpeedButtonImage [90]
      Left = 142
      Top = 567
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = btnDataReq_LClick
      OnMouseDown = btnDataReq_LMouseDown
      OnMouseUp = btnDataReq_LMouseUp
      ImageList = ilGreenBox
    end
    object Label42: TLabel [91]
      Left = 157
      Top = 584
      Width = 29
      Height = 24
      Caption = 'DATA'#13#10' REQ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label42Click
    end
    object btnTM: TSpeedButtonImage [92]
      Left = 521
      Top = 859
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 14
      Flat = True
      OnClick = btnTMClick
      ImageList = ilGreenBox
    end
    object lblBtnTM: TLabel [93]
      Left = 542
      Top = 882
      Width = 14
      Height = 12
      Caption = 'TM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblBtnTMClick
    end
    object btnOwnCurs: TSpeedButtonImage [94]
      Left = 592
      Top = 859
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 15
      Flat = True
      OnClick = btnOwnCursClick
      ImageList = ilGreenBox
    end
    object Label44: TLabel [95]
      Left = 608
      Top = 876
      Width = 26
      Height = 24
      Caption = 'OWN'#13#10'CURS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label44Click
    end
    object btn12Sec: TSpeedButtonImage [96]
      Left = 138
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object btn30Sec: TSpeedButtonImage [97]
      Left = 195
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object btn15Min: TSpeedButtonImage [98]
      Left = 310
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Down = True
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object btn6Min: TSpeedButtonImage [99]
      Left = 253
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object btnReset: TSpeedButtonImage [100]
      Left = 367
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object Label45: TLabel [101]
      Left = 159
      Top = 868
      Width = 18
      Height = 24
      Caption = ' 12'#13#10'SEC'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label45Click
    end
    object Label47: TLabel [102]
      Left = 215
      Top = 868
      Width = 18
      Height = 24
      Caption = ' 30'#13#10'SEC'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label47Click
    end
    object Label48: TLabel [103]
      Left = 271
      Top = 868
      Width = 20
      Height = 24
      Caption = '  6'#13#10'MIN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label48Click
    end
    object Label49: TLabel [104]
      Left = 380
      Top = 873
      Width = 31
      Height = 12
      Caption = 'RESET'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label49Click
    end
    object Label50: TLabel [105]
      Left = 326
      Top = 867
      Width = 20
      Height = 24
      Caption = ' 15'#13#10'MIN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label50Click
    end
    object btnMS: TSpeedButtonImage [106]
      Left = 424
      Top = 919
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 24
      Down = True
      Flat = True
      OnClick = btnMSClick
      ImageList = ilGreenBox
    end
    object btnArrow: TSpeedButtonImage [107]
      Left = 488
      Top = 919
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 25
      Down = True
      Flat = True
      OnClick = btnArrowClick
      ImageList = ilGreenBox
    end
    object btnLINK: TSpeedButtonImage [108]
      Left = 616
      Top = 919
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 28
      Flat = True
      OnClick = btnLINKClick
      ImageList = ilGreenBox
    end
    object btnAMPLInfo: TSpeedButtonImage [109]
      Left = 552
      Top = 919
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 27
      Down = True
      Flat = True
      OnClick = btnAMPLInfoClick
      ImageList = ilGreenBox
    end
    object btnTN: TSpeedButtonImage [110]
      Left = 680
      Top = 919
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 29
      Down = True
      Flat = True
      OnClick = btnTNClick
      ImageList = ilGreenBox
    end
    object btnAIR: TSpeedButtonImage [111]
      Left = 767
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 16
      Down = True
      Flat = True
      OnClick = btnAIRClick
      ImageList = ilGreenBox
    end
    object btnSURF: TSpeedButtonImage [112]
      Left = 825
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 17
      Flat = True
      OnClick = btnSURFClick
      ImageList = ilGreenBox
    end
    object btnEW: TSpeedButtonImage [113]
      Left = 939
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 19
      Flat = True
      OnClick = btnEWClick
      ImageList = ilGreenBox
    end
    object btnSUBSURF: TSpeedButtonImage [114]
      Left = 882
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 18
      Down = True
      Flat = True
      OnClick = btnSUBSURFClick
      ImageList = ilGreenBox
    end
    object btnNAVAids: TSpeedButtonImage [115]
      Left = 996
      Top = 851
      Width = 56
      Height = 57
      AllowAllUp = True
      GroupIndex = 20
      Flat = True
      OnClick = btnNAVAidsClick
      ImageList = ilGreenBox
    end
    object btnBLINDARC: TSpeedButtonImage [116]
      Left = 1053
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 21
      Flat = True
      OnClick = btnBLINDARCClick
      ImageList = ilGreenBox
    end
    object btnBLINDARCASW: TSpeedButtonImage [117]
      Left = 1110
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 22
      Flat = True
      OnClick = btnBLINDARCASWClick
      ImageList = ilGreenBox
    end
    object btnLPDTEST: TSpeedButtonImage [118]
      Left = 1167
      Top = 851
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 23
      Flat = True
      OnClick = btnLPDTESTClick
      ImageList = ilGreenBox
    end
    object Label64: TLabel [119]
      Left = 204
      Top = 836
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
    object spbSetRange4: TSpeedButtonImage [120]
      Tag = 4
      Left = 64
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object lblRange4: TLabel [121]
      Tag = 4
      Left = 86
      Top = 110
      Width = 8
      Height = 13
      Caption = '4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object Label23: TLabel [122]
      Left = 786
      Top = 875
      Width = 20
      Height = 12
      Caption = 'AIR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label23Click
    end
    object Label24: TLabel [123]
      Left = 840
      Top = 875
      Width = 26
      Height = 12
      Caption = 'SURF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label24Click
    end
    object Label25: TLabel [124]
      Left = 959
      Top = 875
      Width = 17
      Height = 12
      Caption = 'EW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label25Click
    end
    object Label26: TLabel [125]
      Left = 1011
      Top = 868
      Width = 26
      Height = 24
      Caption = 'NAV'#13#10'AIDS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label28: TLabel [126]
      Left = 1065
      Top = 868
      Width = 32
      Height = 24
      Caption = 'BLIND'#13#10'ARCS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label28Click
    end
    object Label43: TLabel [127]
      Left = 1123
      Top = 863
      Width = 32
      Height = 36
      Caption = 'BLIND'#13#10'ARCS'#13#10'ASW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label51: TLabel [128]
      Left = 1180
      Top = 868
      Width = 24
      Height = 24
      Caption = 'LPD'#13#10'TEST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label51Click
    end
    object Label52: TLabel [129]
      Left = 896
      Top = 868
      Width = 26
      Height = 24
      Caption = 'SUB'#13#10'SURF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label52Click
    end
    object Label53: TLabel [130]
      Left = 445
      Top = 941
      Width = 17
      Height = 12
      Caption = 'M S'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label53Click
    end
    object Label54: TLabel [131]
      Left = 512
      Top = 946
      Width = 6
      Height = 12
      Caption = '/'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label54Click
    end
    object Label55: TLabel [132]
      Left = 566
      Top = 938
      Width = 29
      Height = 24
      Caption = 'AMPL'#13#10'INFO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label55Click
    end
    object Label56: TLabel [133]
      Left = 632
      Top = 941
      Width = 25
      Height = 12
      Caption = 'LINK'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label56Click
    end
    object Label57: TLabel [134]
      Left = 704
      Top = 941
      Width = 13
      Height = 12
      Caption = 'TN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label57Click
    end
    object spbSetRange2: TSpeedButtonImage [135]
      Tag = 4
      Left = 7
      Top = 84
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object lblRange2: TLabel [136]
      Tag = 4
      Left = 30
      Top = 110
      Width = 8
      Height = 13
      Caption = '2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
  end
  inherited Map: TMap
    Left = 303
    ExplicitLeft = 303
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
      01000118010000B002260001000000DCE322001C000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8076C000000000008056C0000000000080764000000000008056400100000018
      010000B002260001000000C5A629501C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000064E02200F050970600
      00040058FA3E1658EE3E160E0000001600000098012600000000000000000000
      000088B3400000000000408F400001000001}
  end
  inherited PopupMenu1: TPopupMenu
    Left = 640
  end
  inherited ColorDialog1: TColorDialog
    Left = 627
    Top = 50
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
  object PopupMenu2: TPopupMenu
    Left = 665
    Top = 52
  end
end
