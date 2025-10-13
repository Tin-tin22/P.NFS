inherited frmTDCTengah_Rencong: TfrmTDCTengah_Rencong
  Left = 68
  Top = 12
  Caption = 'TDC Rencong'
  ClientWidth = 1271
  Color = clMoneyGreen
  ExplicitWidth = 1279
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 0
    Height = 999
    ExplicitLeft = 0
    ExplicitHeight = 999
    inherited Image1: TImage
      Left = 242
      ExplicitLeft = 242
    end
    object btnResetOBM_R: TSpeedButtonImage [1]
      Left = 1063
      Top = 471
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      OnClick = btnResetOBM_RClick
      ImageList = ilGreenBox
    end
    object btnWMnonMTI: TSpeedButtonImage [2]
      Left = 1022
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Down = True
      Flat = True
      OnClick = btnWMnonMTIClick
      ImageList = ilGreenBox
    end
    object btnWMMTI_R: TSpeedButtonImage [3]
      Left = 1079
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 5
      Flat = True
      OnClick = btnWMMTI_RClick
      ImageList = ilGreenBox
    end
    object SpeedButtonImage7: TSpeedButtonImage [4]
      Left = 1136
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ImageList = ilBlueBox
    end
    object lblWM_MTI: TLabel [5]
      Left = 1099
      Top = 46
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
    object Label5: TLabel [6]
      Left = 1036
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
      Left = 1160
      Top = 17
      Width = 33
      Height = 2
    end
    object lblWM_NONMTI: TLabel [8]
      Left = 1040
      Top = 41
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
    object btnRR_R: TSpeedButtonImage [9]
      Left = 1111
      Top = 135
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 9
      Flat = True
      OnClick = btnRR_RClick
      ImageList = ilGreenBox
    end
    object btnIFF_R: TSpeedButtonImage [10]
      Left = 1047
      Top = 135
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnIFF_RClick
      ImageList = ilGreenBox
    end
    object Label7: TLabel [11]
      Left = 1068
      Top = 157
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
    object Label8: TLabel [12]
      Left = 1133
      Top = 158
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
    object btnHM_R: TSpeedButtonImage [13]
      Left = 1175
      Top = 135
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 10
      Flat = True
      OnClick = btnHM_RClick
      ImageList = ilGreenBox
    end
    object Label9: TLabel [14]
      Left = 1198
      Top = 158
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
    object btnDataReq_R: TSpeedButtonImage [15]
      Left = 1063
      Top = 551
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      OnClick = btnDataReq_RClick
      OnMouseDown = btnDataReq_RMouseDown
      OnMouseUp = btnDataReq_RMouseUp
      ImageList = ilGreenBox
    end
    object Label19: TLabel [16]
      Left = 1079
      Top = 569
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
    object spbSetRange32: TSpeedButtonImage [17]
      Left = 249
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Down = True
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange8: TSpeedButtonImage [18]
      Left = 135
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange16: TSpeedButtonImage [19]
      Left = 192
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object spbSetRange4: TSpeedButtonImage [20]
      Left = 78
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object lblRange32: TLabel [21]
      Left = 271
      Top = 53
      Width = 12
      Height = 12
      Caption = '32'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange16: TLabel [22]
      Left = 216
      Top = 54
      Width = 12
      Height = 12
      Caption = '16'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object Label27: TLabel [23]
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
    object Bevel7: TBevel [24]
      Left = 240
      Top = 16
      Width = 91
      Height = 2
    end
    object Bevel8: TBevel [25]
      Left = 24
      Top = 16
      Width = 89
      Height = 2
    end
    object btnDataReq_L: TSpeedButtonImage [26]
      Left = 111
      Top = 543
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = btnDataReq_LClick
      OnMouseDown = btnDataReq_LMouseDown
      OnMouseUp = btnDataReq_LMouseUp
      ImageList = ilGreenBox
    end
    object Label42: TLabel [27]
      Left = 126
      Top = 561
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
    object btnTM: TSpeedButtonImage [28]
      Left = 535
      Top = 862
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 14
      Flat = True
      OnClick = btnTMClick
      ImageList = ilGreenBox
    end
    object Label43: TLabel [29]
      Left = 556
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
      OnClick = Label43Click
    end
    object btnOwnCurs: TSpeedButtonImage [30]
      Left = 599
      Top = 862
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 15
      Flat = True
      OnClick = btnOwnCursClick
      ImageList = ilGreenBox
    end
    object Label44: TLabel [31]
      Left = 616
      Top = 877
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
    object btn12Sec: TSpeedButtonImage [32]
      Left = 175
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn12SecClick
      ImageList = ilGreenBox
    end
    object btn30Sec: TSpeedButtonImage [33]
      Left = 239
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn30SecClick
      ImageList = ilGreenBox
    end
    object btn15Min: TSpeedButtonImage [34]
      Left = 367
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn15MinClick
      ImageList = ilGreenBox
    end
    object btn6Min: TSpeedButtonImage [35]
      Left = 303
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btn6MinClick
      ImageList = ilGreenBox
    end
    object btnReset: TSpeedButtonImage [36]
      Left = 431
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 13
      Flat = True
      OnClick = btnResetClick
      ImageList = ilGreenBox
    end
    object Label45: TLabel [37]
      Left = 194
      Top = 878
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
    object Label47: TLabel [38]
      Left = 259
      Top = 878
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
    object Label48: TLabel [39]
      Left = 323
      Top = 878
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
    object Label49: TLabel [40]
      Left = 446
      Top = 885
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
    object Label50: TLabel [41]
      Left = 386
      Top = 877
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
    object btnMS: TSpeedButtonImage [42]
      Left = 455
      Top = 935
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 24
      Down = True
      Flat = True
      OnClick = btnMSClick
      ImageList = ilGreenBox
    end
    object SpeedButtonImage50: TSpeedButtonImage [43]
      Left = 519
      Top = 935
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilGreenBox
    end
    object btnLINK: TSpeedButtonImage [44]
      Left = 647
      Top = 935
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 28
      Flat = True
      OnClick = btnLINKClick
      ImageList = ilGreenBox
    end
    object btnAMPLInfo: TSpeedButtonImage [45]
      Left = 583
      Top = 935
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 27
      Down = True
      Flat = True
      OnClick = btnAMPLInfoClick
      ImageList = ilGreenBox
    end
    object btnAIR: TSpeedButtonImage [46]
      Left = 703
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 15
      Flat = True
      OnClick = btnAIRClick
      ImageList = ilGreenBox
    end
    object btnSURF: TSpeedButtonImage [47]
      Left = 767
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 16
      Flat = True
      OnClick = btnSURFClick
      ImageList = ilGreenBox
    end
    object btnBLINDARC: TSpeedButtonImage [48]
      Left = 895
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 20
      Flat = True
      OnClick = btnBLINDARCClick
      ImageList = ilGreenBox
    end
    object btnLPDTEST: TSpeedButtonImage [49]
      Left = 959
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 22
      Flat = True
      OnClick = btnLPDTESTClick
      ImageList = ilGreenBox
    end
    object Label64: TLabel [50]
      Left = 264
      Top = 847
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
    object spbSetRange2: TSpeedButtonImage [51]
      Tag = 4
      Left = 21
      Top = 31
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      OnClick = spbSetRangeClick
      ImageList = ilGreenBox
    end
    object lblRange8: TLabel [52]
      Left = 162
      Top = 55
      Width = 6
      Height = 12
      Caption = '8'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange4: TLabel [53]
      Left = 104
      Top = 54
      Width = 6
      Height = 12
      Caption = '4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = lblRange4Click
    end
    object lblRange2: TLabel [54]
      Tag = 4
      Left = 44
      Top = 53
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
      OnClick = lblRange4Click
    end
    object Bevel13: TBevel [55]
      Left = 416
      Top = 853
      Width = 73
      Height = 3
    end
    object Bevel14: TBevel [56]
      Left = 192
      Top = 853
      Width = 65
      Height = 3
    end
    object Label29: TLabel [57]
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
    object LabelSelection: TLabel [58]
      Left = 552
      Top = 922
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
    object Bevel15: TBevel [59]
      Left = 680
      Top = 928
      Width = 81
      Height = 3
    end
    object Bevel16: TBevel [60]
      Left = 464
      Top = 928
      Width = 81
      Height = 3
    end
    object Label31: TLabel [61]
      Left = 475
      Top = 958
      Width = 14
      Height = 12
      Caption = 'MS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label31Click
    end
    object Label32: TLabel [62]
      Left = 599
      Top = 951
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
      OnClick = Label32Click
    end
    object Label53: TLabel [63]
      Left = 665
      Top = 958
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
      OnClick = Label53Click
    end
    object Label57: TLabel [64]
      Left = 724
      Top = 883
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
      OnClick = Label57Click
    end
    object Label58: TLabel [65]
      Left = 783
      Top = 883
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
      OnClick = Label58Click
    end
    object Label63: TLabel [66]
      Left = 908
      Top = 879
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
      OnClick = Label63Click
    end
    object Label66: TLabel [67]
      Left = 976
      Top = 877
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
      OnClick = Label66Click
    end
    object btnCUORoffCENT_L: TSpeedButtonImage [68]
      Left = 111
      Top = 191
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Flat = True
      OnClick = btnCUORoffCENT_LClick
      ImageList = ilGreenBox
    end
    object Label33: TLabel [69]
      Left = 125
      Top = 201
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
    object btnCUorCENT_L: TSpeedButtonImage [70]
      Left = 111
      Top = 255
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 7
      Flat = True
      OnClick = btnCUorCENT_LClick
      ImageList = ilGreenBox
    end
    object Label34: TLabel [71]
      Left = 124
      Top = 271
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
    object btnOFFCent_L: TSpeedButtonImage [72]
      Left = 111
      Top = 319
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnOFFCent_LClick
      ImageList = ilGreenBox
    end
    object Label35: TLabel [73]
      Left = 127
      Top = 335
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
    object btnCENT_L: TSpeedButtonImage [74]
      Left = 111
      Top = 383
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 8
      Flat = True
      OnClick = btnCENT_LClick
      ImageList = ilGreenBox
    end
    object Label36: TLabel [75]
      Left = 128
      Top = 406
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
    object btnResetOBM_L: TSpeedButtonImage [76]
      Left = 111
      Top = 447
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = btnResetOBM_LClick
      ImageList = ilGreenBox
    end
    object Label41: TLabel [77]
      Left = 125
      Top = 465
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
    object Label1: TLabel [78]
      Left = 1079
      Top = 488
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
      OnClick = Label1Click
    end
    object SpeedButtonImage2: TSpeedButtonImage [79]
      Left = 831
      Top = 863
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilBlueBox
    end
    object Bevel3: TBevel [80]
      Left = 1008
      Top = 17
      Width = 18
      Height = 2
    end
    object Label2: TLabel [81]
      Left = 1008
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
    inherited Image2: TImage
      Top = 658
      ExplicitTop = 658
    end
    object btnTN: TSpeedButtonImage [86]
      Left = 728
      Top = 933
      Width = 57
      Height = 57
      AllowAllUp = True
      GroupIndex = 29
      Down = True
      Flat = True
      OnClick = btnTNClick
      ImageList = ilGreenBox
    end
    object Label54: TLabel [87]
      Left = 751
      Top = 956
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
      OnClick = Label54Click
    end
    inherited pnlRange: TPanel
      Left = 704
      ExplicitLeft = 704
    end
  end
  inherited Map: TMap
    Left = 321
    Top = 150
    ExplicitLeft = 321
    ExplicitTop = 150
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
      00040058FA3E1654E022000E0000006C02310098012600000000000000000000
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
